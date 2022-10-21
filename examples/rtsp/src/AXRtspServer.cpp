/**********************************************************************************
 *
 * Copyright (c) 2019-2020 Beijing AXera Technology Co., Ltd. All Rights Reserved.
 *
 * This source file is the property of Beijing AXera Technology Co., Ltd. and
 * may not be copied or distributed in any isomorphic form without the prior
 * written consent of Beijing AXera Technology Co., Ltd.
 *
 **********************************************************************************/
#include <sys/ioctl.h>
#include <sys/prctl.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <dirent.h>
#include <vector>
#include <string>
#include "ax_base_type.h"
#include "AXRtspServer.h"
#include "AXFramedSource.h"
#include "GroupsockHelper.hh"

using namespace std;

#define BASE_PORT     (18888)
#define RTSPSERVER    "RTSPSERVER"

#define RTSP_PORT 8554
#define RTSP_END_POINT "axstream"

static char gStopEventLoop = 0;

static AX_BOOL GetIP(const vector<string>& vNetType, AX_CHAR* pOutIPAddress)
{
    for (size_t i = 0; i < vNetType.size(); i++) {
        for (char c = '0'; c <= '9'; ++c) {
            string strDevice = vNetType[i] + c;
            int fd;
            struct ifreq ifr;
            fd = socket(AF_INET, SOCK_DGRAM, 0);
            strcpy(ifr.ifr_name, strDevice.c_str());
            if (ioctl(fd, SIOCGIFADDR, &ifr) <  0) {
                ::close(fd);
                continue;
            }

            char* pIP = inet_ntoa(((struct sockaddr_in*)&(ifr.ifr_addr))->sin_addr);
            if (pIP) {
                strcpy((char *)pOutIPAddress, pIP);
                ::close(fd);
                return AX_TRUE;
            }
        }
    }
    return AX_FALSE;
}


void* RtspServerThreadFunc(void *args)
{
    COMM_RTSP_PRT("+++");

    prctl(PR_SET_NAME, "IPC_RTSP_Main");

    AXRtspServer * pThis = (AXRtspServer *)args;
    if (pThis->m_nMaxNum > MAX_RTSP_CHANNEL_NUM) {
        *pThis->m_pUEnv << "Rtsp channel exceeded max number" <<"\n";
        return nullptr;
    }

    OutPacketBuffer::maxSize = 700000;
    TaskScheduler* taskSchedular = BasicTaskScheduler::createNew();
    pThis->m_pUEnv = BasicUsageEnvironment::createNew(*taskSchedular);
    pThis->m_pRtspServer = RTSPServer::createNew(*pThis->m_pUEnv, RTSP_PORT, NULL);
    if(pThis->m_pRtspServer == NULL) {
        *pThis->m_pUEnv << "Failed to create rtsp server ::" << pThis->m_pUEnv->getResultMsg() <<"\n";
        return nullptr;
    }

    AX_CHAR szIP[64] = {0};
    vector<string> vNetType;
    vNetType.push_back("eth");
    AX_BOOL bGetIPRet = AX_FALSE;
    if (GetIP(vNetType, &szIP[0])) {
        bGetIPRet = AX_TRUE;
    }

    for (size_t i = 0; i < pThis->m_nMaxNum; i++) {
        AX_CHAR strStream[64] = {0};
        sprintf(strStream,"%s%d", RTSP_END_POINT, pThis->m_arrIndex[i]);
        ServerMediaSession* sms = ServerMediaSession::createNew(*pThis->m_pUEnv, strStream, strStream, "Live Stream");
        pThis->m_pLiveServerMediaSession[pThis->m_arrIndex[i]] = AXLiveServerMediaSession::createNew(*pThis->m_pUEnv, true, pThis->m_isH264);
        sms->addSubsession(pThis->m_pLiveServerMediaSession[pThis->m_arrIndex[i]]);
        pThis->m_pRtspServer->addServerMediaSession(sms);

        char* url = nullptr;
        if (bGetIPRet) {
            url = new char[64];
            sprintf(url, "rtsp://%s:%d/%s", szIP, RTSP_PORT, strStream);
        } else {
            url = pThis->m_pRtspServer->rtspURL(sms);
        }

        COMM_RTSP_PRT("Play the stream using url: <<<<< %s >>>>>", url);
        delete[] url;
    }

    taskSchedular->doEventLoop(&gStopEventLoop);
    delete(taskSchedular);

    COMM_RTSP_PRT("---");

    return nullptr;
}

AXRtspServer::AXRtspServer(void)
{
    m_isH264      = true;
    m_uBasePort   = BASE_PORT;
    m_tidServer   = 0;
    m_nMaxNum     = 0;

    m_pUEnv       = NULL;
    m_pRtspServer = nullptr;

    for (int i = 0; i < MAX_RTSP_CHANNEL_NUM; i++) {
        m_pLiveServerMediaSession[i] = NULL;
    }
}

AXRtspServer::~AXRtspServer(void)
{
}

AX_BOOL AXRtspServer::Init(AX_S32 arrIndex[], AX_S32 nNum, bool isH264, AX_U16 uBasePort)
{
    if (uBasePort == 0) {
        uBasePort = BASE_PORT;
    }

    m_isH264       = isH264;
    m_uBasePort    = uBasePort;
    gStopEventLoop = 0;

    memset(m_arrIndex, 0x0, sizeof(m_arrIndex));
    if (nNum <= MAX_RTSP_CHANNEL_NUM) {
        memcpy(m_arrIndex, arrIndex, sizeof(AX_S32) * nNum);
    }
    else {
        COMM_RTSP_PRT("exceed max rtsp channel numer");
        return AX_FALSE;
    }
    m_nMaxNum = nNum;

    return AX_TRUE;
}

void AXRtspServer::SendNalu(AX_U8 nChn, const AX_U8* pBuf, AX_U32 nLen, AX_U64 nPts/*=0*/, AX_BOOL bIFrame/*=AX_FALSE*/)
{
    if (m_pLiveServerMediaSession[nChn]) {
        m_pLiveServerMediaSession[nChn]->SendNalu(nChn, pBuf, nLen, nPts, bIFrame);
    }
}

AX_BOOL AXRtspServer::Start(void)
{
    if (0 != pthread_create(&m_tidServer, NULL, RtspServerThreadFunc, this)) {
        m_tidServer = 0;
        COMM_RTSP_PRT("pthread_create(RtspServerThreadFunc) fail");
        return AX_FALSE;
    }
    return AX_TRUE;
}

void AXRtspServer::Stop(void)
{
    for (size_t i = 0; i < m_nMaxNum; i++) {
        if (m_pRtspServer) {
            AX_CHAR strStream[64] = {0};
            sprintf(strStream, "%s%d", RTSP_END_POINT,m_arrIndex[i]);
            ServerMediaSession* sms = m_pRtspServer->lookupServerMediaSession(strStream);
            if (sms) {
                m_pRtspServer->removeServerMediaSession(sms);
                m_pRtspServer->closeAllClientSessionsForServerMediaSession(sms);
                sms->deleteAllSubsessions();
            }
            m_pLiveServerMediaSession[i] = NULL;
        }
    }

    m_pUEnv = NULL;
    gStopEventLoop = 1;
}

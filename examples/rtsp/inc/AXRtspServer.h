/**********************************************************************************
 *
 * Copyright (c) 2019-2020 Beijing AXera Technology Co., Ltd. All Rights Reserved.
 *
 * This source file is the property of Beijing AXera Technology Co., Ltd. and
 * may not be copied or distributed in any isomorphic form without the prior
 * written consent of Beijing AXera Technology Co., Ltd.
 *
 **********************************************************************************/

#ifndef __AXRTSPSERVER_H__
#define __AXRTSPSERVER_H__

#include "ax_base_type.h"
#include "liveMedia.hh"
#include "BasicUsageEnvironment.hh"
#include "AXLiveServerMediaSession.h"

#define MAX_RTSP_CHANNEL_NUM (8)


class AXRtspServer{
public:
    AXRtspServer(void);
    virtual ~AXRtspServer(void);

public:
    AX_BOOL Init(AX_S32 arrIndex[], AX_S32 nNum, bool isH264=true, AX_U16 uBasePort=0);
    AX_BOOL Start(void);
    void    Stop(void);
	void    SendNalu(AX_U8 nChn, const AX_U8* pBuf, AX_U32 nLen, AX_U64 nPts=0, AX_BOOL bIFrame=AX_FALSE);

public:
    RTSPServer*               m_pRtspServer;
    AX_U16                    m_uBasePort;

    AX_S32                    m_arrIndex[MAX_RTSP_CHANNEL_NUM];
    AX_U16                    m_nMaxNum;

    AXLiveServerMediaSession* m_pLiveServerMediaSession[MAX_RTSP_CHANNEL_NUM];
    UsageEnvironment*         m_pUEnv;
    bool                      m_isH264;
private:
    pthread_t m_tidServer;

};

#endif /*__AXRTSPSERVER_H__*/
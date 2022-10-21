#include "AXRtspWrapper.h"
#include "AXRtspServer.h"

static AXRtspServer g_rtspServer;

AX_VOID AX_Rtsp_Start(AX_S32 arrIndex[], AX_S32 nNum, AX_BOOL bIsH264)
{
    g_rtspServer.Init(arrIndex, nNum, bIsH264?true:false);
    g_rtspServer.Start();
}

AX_VOID AX_Rtsp_Stop(AX_VOID)
{
    g_rtspServer.Stop();
}

AX_VOID AX_Rtsp_SendNalu(AX_U8 nChn, const AX_U8* pBuf, AX_U32 nLen, AX_U64 nPts, AX_BOOL bIFrame)
{
    g_rtspServer.SendNalu(nChn, pBuf, nLen, nPts, bIFrame);
}

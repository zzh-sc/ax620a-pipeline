#ifndef __AX_RTSP_WRAPPER_H__
#define __AX_RTSP_WRAPPER_H__

#include "ax_base_type.h"

#ifdef __cplusplus
extern "C" {
#endif

AX_VOID AX_Rtsp_Start(AX_S32 arrIndex[], AX_S32 nNum, AX_BOOL bIsH264);
AX_VOID AX_Rtsp_Stop(AX_VOID);
AX_VOID AX_Rtsp_SendNalu(AX_U8 nChn, const AX_U8* pBuf, AX_U32 nLen, AX_U64 nPts, AX_BOOL bIFrame);

#ifdef __cplusplus
}
#endif

#endif  // __AX_RTSP_WRAPPER_H__
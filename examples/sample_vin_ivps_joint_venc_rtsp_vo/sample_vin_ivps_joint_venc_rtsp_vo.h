/**********************************************************************************
 *
 * Copyright (c) 2019-2020 Beijing AXera Technology Co., Ltd. All Rights Reserved.
 *
 * This source file is the property of Beijing AXera Technology Co., Ltd. and
 * may not be copied or distributed in any isomorphic form without the prior
 * written consent of Beijing AXera Technology Co., Ltd.
 *
 **********************************************************************************/
#ifndef _SAMPLE_VIN_IVPS_JOINT_VENC_H_
#define _SAMPLE_VIN_IVPS_JOINT_VENC_H_

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <errno.h>
#include <unistd.h>
#include <pthread.h>
#include <sys/prctl.h>

#include "ax_venc_api.h"
#include "ax_ivps_api.h"
#include "ax_isp_api.h"

#include "common_sys.h"
#include "common_vin.h"
#include "common_cam.h"
#include "common_codec/common_venc.h"
#include "AXRtspWrapper.h"
#include "../utilities/sample_log.h"

#define SAMPLE_IVPS_GROUP_NUM (3)
#define SAMPLE_IVPS_CHN_NUM (1)
#define SAMPLE_VENC_CHN_NUM (1)
#define SAMPLE_REGION_COUNT (2)
#define SAMPLE_RECT_BOX_COUNT (16) // <=16

#define RED 0xFF0000
#define PINK 0xFFC0CB
#define GREEN 0x00FF00
#define BLUE 0x0000FF
#define PURPLE 0xA020F0
#define ORANGE 0xFFA500
#define YELLOW 0xFFFF00

#ifndef ALIGN_UP
#define ALIGN_UP(x, align) ((((x) + ((align)-1)) / (align)) * (align))
#endif

#ifndef ALIGN_DOWN
#define ALIGN_DOWN(x, align) (((x) / (align)) * (align))
#endif

typedef AX_S32 IVPS_GRP;
typedef AX_S32 AX_IVPS_FILTER;

typedef enum
{
    SYS_CASE_NONE = -1,
    SYS_CASE_SINGLE_OS04A10 = 0,
    SYS_CASE_SINGLE_IMX334 = 1,
    SYS_CASE_SINGLE_GC4653 = 2,
    SYS_CASE_SINGLE_OS08A20 = 3,
    SYS_CASE_SINGLE_OS04A10_ONLINE = 4,
    SYS_CASE_BUTT
} COMMON_SYS_CASE_E;

typedef enum
{
    VENC_CASE_NONE = -1,
    VENC_CASE_H264 = 0,
    VENC_CASE_H265 = 1,
    VENC_CASE_BUTT
} COMMON_VENC_CASE_E;

typedef struct _IVPS_REGION_PARAM
{
    IVPS_RGN_HANDLE hChnRgn;
    IVPS_GRP nGroup;
    AX_IVPS_FILTER nFilter;
    AX_BOOL bExit;
} IVPS_REGION_PARAM_T, *IVPS_REGION_PARAM_PTR;

static AX_S32 s_sample_framerate = 25;

extern volatile AX_S32 gLoopExit;

extern pthread_mutex_t g_result_mutex;

extern CAMERA_T gCams[MAX_CAMERAS];

extern const AX_S32 gVencChnMapping[SAMPLE_VENC_CHN_NUM];
// extern VENC_GETSTREAM_PARAM_T gGetStreamPara[SAMPLE_VENC_CHN_NUM];
// extern pthread_t gGetStreamPid[SAMPLE_VENC_CHN_NUM];

extern IVPS_REGION_PARAM_T g_arrRgnThreadParam[SAMPLE_REGION_COUNT];

extern int SAMPLE_ALGO_WIDTH;  // 640
extern int SAMPLE_ALGO_HEIGHT; // 640
extern int SAMPLE_MAJOR_STREAM_WIDTH;
extern int SAMPLE_MAJOR_STREAM_HEIGHT;
#define SAMPLE_MINOR_STREAM_WIDTH 854
#define SAMPLE_MINOR_STREAM_HEIGHT 480
#endif

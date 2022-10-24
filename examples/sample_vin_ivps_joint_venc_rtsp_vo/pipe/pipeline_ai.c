/*
 * AXERA is pleased to support the open source community by making ax-samples available.
 *
 * Copyright (c) 2022, AXERA Semiconductor (Shanghai) Co., Ltd. All rights reserved.
 *
 * Licensed under the BSD 3-Clause License (the "License"); you may not use this file except
 * in compliance with the License. You may obtain a copy of the License at
 *
 * https://opensource.org/licenses/BSD-3-Clause
 *
 * Unless required by applicable law or agreed to in writing, software distributed
 * under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 */

/*
 * Author: ZHEQIUSHUI
 */

#include "../sample_vin_ivps_joint_venc_rtsp_vo.h"
#include "../../sample_run_joint/sample_run_joint.h"
#include "npu_common.h"

extern void *gJointHandle;

extern sample_run_joint_results pResult_disp;

AX_VOID *GetFrameThread(AX_VOID *pArg)
{
    IVPS_GRP IvpsGrp = 1;
    IVPS_CHN IvpsChn = 0;
    AX_S32 nMilliSec = 200;

    prctl(PR_SET_NAME, "SAMPLE_IVPS_GET");

    while (!gLoopExit)
    {
        AX_VIDEO_FRAME_S tVideoFrame;

        AX_S32 ret = AX_IVPS_GetChnFrame(IvpsGrp, IvpsChn, &tVideoFrame, nMilliSec);

        if (0 != ret)
        {
            if (AX_ERR_IVPS_BUF_EMPTY == ret)
            {
                usleep(1000);
                continue;
            }
            usleep(1000);
            continue;
        }

        tVideoFrame.u64VirAddr[0] = (AX_U32)AX_POOL_GetBlockVirAddr(tVideoFrame.u32BlkId[0]);
        tVideoFrame.u64PhyAddr[0] = AX_POOL_Handle2PhysAddr(tVideoFrame.u32BlkId[0]);
        tVideoFrame.u32FrameSize = tVideoFrame.u32PicStride[0] * tVideoFrame.u32Height * 3 / 2;

        AX_NPU_CV_Image tSrcFrame = {0};
        tSrcFrame.nWidth = tVideoFrame.u32Width;
        tSrcFrame.nHeight = tVideoFrame.u32Height;
        tSrcFrame.eDtype = AX_NPU_CV_FDT_NV12;
        tSrcFrame.tStride.nW = (0 == tVideoFrame.u32PicStride[0]) ? tSrcFrame.nWidth : tVideoFrame.u32PicStride[0];
        tSrcFrame.nSize = tVideoFrame.u32FrameSize; // t.tStride.nW * t.nHeight * 3 / 2;
        tSrcFrame.pPhy = tVideoFrame.u64PhyAddr[0];
        tSrcFrame.pVir = (AX_U8 *)tVideoFrame.u64VirAddr[0];

        if (gJointHandle)
        {
            static sample_run_joint_results pResult;
            ret = sample_run_joint_inference(gJointHandle, &tSrcFrame, SAMPLE_MAJOR_STREAM_WIDTH, SAMPLE_MAJOR_STREAM_HEIGHT, &pResult);

            pthread_mutex_lock(&g_result_mutex);

            if (0 == ret)
            {
                memcpy(&pResult_disp, &pResult, sizeof(sample_run_joint_results));

                for (AX_U8 i = 0; i < pResult_disp.size && i < SAMPLE_RECT_BOX_COUNT; i++)
                {
                    pResult_disp.objects[i].x /= SAMPLE_MAJOR_STREAM_WIDTH;
                    pResult_disp.objects[i].y /= SAMPLE_MAJOR_STREAM_HEIGHT;
                    pResult_disp.objects[i].w /= SAMPLE_MAJOR_STREAM_WIDTH;
                    pResult_disp.objects[i].h /= SAMPLE_MAJOR_STREAM_HEIGHT;
                }
            }
            pthread_mutex_unlock(&g_result_mutex);
        }

        ret = AX_IVPS_ReleaseChnFrame(IvpsGrp, IvpsChn, &tVideoFrame);
    }

    return (AX_VOID *)0;
}

#include "common_pipeline.h"

#include "ax_ivps_api.h"
#include "ax_buffer_tool.h"
#include "ax_vdec_api.h"
#include "ax_venc_api.h"
#include "npu_cv_kit/ax_npu_imgproc.h"
#include "algorithm"
#include "vector"
#include "string"
#include "string.h"
#include "map"

#include "rtsp.h"
#include "../utilities/sample_log.h"
#include "../utilities/net_utils.h"

extern "C"
{
#include "vo/sample_comm_vo.h"
#include "common_codec/common_venc.h"
}

#define VDEC_LINK_MODE 1
#define RTSP_PORT 8554

typedef struct
{

    std::map<int, pipeline_t *> pipeid_pipe;

    bool b_maix3_init = false;

    rtsp_demo_handle rDemoHandle = NULL;
    std::map<int, rtsp_session_handle> rtsp_pipeid_sessiones;
    std::vector<std::string> rtsp_end_point;

    std::vector<int> ivps_grp;
    std::vector<int> vdec_grp;
    std::vector<int> venc_chn;
} pipeline_internal_handle_t;

static pipeline_internal_handle_t pipeline_handle;

#define SAMPLE_VO_DEV0 0

typedef struct axSAMPLE_VO_CHN_THREAD_PARAM
{
    pthread_t ThreadID;

    AX_U32 u32ThreadForceStop;

    AX_U32 u32LayerID;
    AX_U32 u32ChnID;
    AX_POOL u32UserPoolId;
} SAMPLE_VO_CHN_THREAD_PARAM_S;

SAMPLE_VO_CONFIG_S stVoConf;
SAMPLE_VO_CHN_THREAD_PARAM_S g_stChnThreadParam = {0};

AX_S32 ParseVoPubAttr(AX_CHAR *pStr, SAMPLE_VO_CONFIG_S *pstVoConf)
{
    AX_CHAR *p, *end;

    if (!pStr || !pstVoConf)
        return -EINVAL;

    p = pStr;

    if (strstr(p, "dpi"))
    {
        SAMPLE_PRT("dpi output\n");
        pstVoConf->enVoIntfType = VO_INTF_DPI;
    }
    else if (strstr(p, "dsi0"))
    {
        SAMPLE_PRT("dsi0 output\n");
        pstVoConf->enVoIntfType = VO_INTF_DSI0;
    }
    else if (strstr(p, "dsi1"))
    {
        SAMPLE_PRT("dsi1 output\n");
        pstVoConf->enVoIntfType = VO_INTF_DSI1;
    }
    else if (strstr(p, "2dsi"))
    {
        SAMPLE_PRT("dsi0 output\n");
        pstVoConf->enVoIntfType = VO_INTF_2DSI;
        pstVoConf->u32LayerNr = 2;
    }
    else if (strstr(p, "bt656"))
    {
        SAMPLE_PRT("bt656 output\n");
        pstVoConf->enVoIntfType = VO_INTF_BT656;
    }
    else if (strstr(p, "bt1120"))
    {
        SAMPLE_PRT("bt1120 output\n");
        pstVoConf->enVoIntfType = VO_INTF_BT1120;
    }
    else
    {
        SAMPLE_PRT("unsupported interface type, %s\n", p);
        return -EINVAL;
    }

    end = strstr(p, "@");
    p = end + 1;
    pstVoConf->stReso.u32Width = strtoul(p, &end, 10);
    end = strstr(p, "x");
    p = end + 1;
    pstVoConf->stReso.u32Height = strtoul(p, &end, 10);
    end = strstr(p, "@");
    p = end + 1;
    pstVoConf->stReso.u32RefreshRate = strtoul(p, &end, 10);

    SAMPLE_PRT("reso: %dx%d-%d\n", pstVoConf->stReso.u32Width,
               pstVoConf->stReso.u32Height, pstVoConf->stReso.u32RefreshRate);

    return 0;
}

static AX_S32 SAMPLE_VO_CREATE_POOL(AX_U32 u32BlkCnt, AX_U64 u64BlkSize, AX_U64 u64MetaSize, AX_U32 *pPoolID)
{
    AX_POOL_CONFIG_T stPoolCfg = {0};

    stPoolCfg.MetaSize = u64MetaSize;
    stPoolCfg.BlkCnt = u32BlkCnt;
    stPoolCfg.BlkSize = u64BlkSize;
    stPoolCfg.CacheMode = POOL_CACHE_MODE_NONCACHE;
    strcpy((char *)stPoolCfg.PartitionName, "anonymous");

    *pPoolID = AX_POOL_CreatePool(&stPoolCfg);
    if (*pPoolID == AX_INVALID_POOLID)
    {
        SAMPLE_PRT("AX_POOL_CreatePool failed, u32BlkCnt = %d, u64BlkSize = 0x%llx, u64MetaSize = 0x%llx\n", u32BlkCnt,
                   u64BlkSize, u64MetaSize);
        return -1;
    }

    SAMPLE_PRT("u32BlkCnt = %d, u64BlkSize = 0x%llx, pPoolID = %d\n", u32BlkCnt, u64BlkSize, *pPoolID);

    return 0;
}

static int SAMPLE_VO_POOL_DESTROY(AX_U32 u32PoolID)
{
    return AX_POOL_MarkDestroyPool(u32PoolID);
}

template <typename T>
bool contain(std::vector<T> &v, T &t)
{
    auto item = std::find(v.begin(), v.end(), t);
    if (item != v.end())
    {
        return true;
    }
    return false;
}

template <typename KT, typename VT>
bool contain(std::map<KT, VT> &v, KT &t)
{
    auto item = v.find(t);
    if (item != v.end())
    {
        return true;
    }
    return false;
}

template <typename T>
bool erase(std::vector<T> &v, T &t)
{
    auto item = std::find(v.begin(), v.end(), t);
    if (item != v.end())
    {
        v.erase(item);
        return true;
    }
    return false;
}

template <typename KT, typename VT>
bool erase(std::map<KT, VT> &v, KT &t)
{
    auto item = v.find(t);
    if (item != v.end())
    {
        v.erase(item);
        return true;
    }
    return false;
}

static void PrintRtsp(char *rtsp_path)
{
    char ipaddr[64];
    int ret = get_ip("eth0", ipaddr);
    printf("\n");
    if (ret == 0)
    {
        ALOGI("                                    [eth0]  rtsp url >>>>>> rtsp://%s:%d%s <<<<<<", ipaddr, RTSP_PORT, rtsp_path);
    }
    ret = get_ip("wlan0", ipaddr);
    if (ret == 0)
    {
        ALOGI("                                    [wlan0] rtsp url >>>>>> rtsp://%s:%d%s <<<<<<", ipaddr, RTSP_PORT, rtsp_path);
    }
    ret = get_ip("usb0", ipaddr);
    if (ret == 0)
    {
        ALOGI("                                    [usb0]  rtsp url >>>>>> rtsp://%s:%d%s <<<<<<\n", ipaddr, RTSP_PORT, rtsp_path);
    }
}

void *_ivps_get_frame_thread(void *arg)
{
    pipeline_t *pipe = (pipeline_t *)arg;

    AX_S32 nMilliSec = 200;

    // prctl(PR_SET_NAME, "SAMPLE_IVPS_GET");

    // ALOGN("SAMPLE_RUN_JOINT +++");

    while (!pipe->n_loog_exit)
    {
        AX_VIDEO_FRAME_S tVideoFrame;

        AX_S32 ret = AX_IVPS_GetChnFrame(pipe->m_ivps_attr.n_ivps_grp, 0, &tVideoFrame, nMilliSec);

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

        AX_NPU_CV_Image tSrcFrame = {0};
        tSrcFrame.nWidth = tVideoFrame.u32Width;
        tSrcFrame.nHeight = tVideoFrame.u32Height;
        switch (tVideoFrame.enImgFormat)
        {
        case AX_YUV420_SEMIPLANAR:
            tSrcFrame.eDtype = AX_NPU_CV_FDT_NV12;
            tVideoFrame.u32FrameSize = tVideoFrame.u32PicStride[0] * tVideoFrame.u32Height * 3 / 2;
            break;
        case AX_FORMAT_RGB888:
            tSrcFrame.eDtype = AX_NPU_CV_FDT_RGB;
            tVideoFrame.u32FrameSize = tVideoFrame.u32PicStride[0] * tVideoFrame.u32Height * 3;
            break;
        case AX_FORMAT_BGR888:
            tSrcFrame.eDtype = AX_NPU_CV_FDT_BGR;
            tVideoFrame.u32FrameSize = tVideoFrame.u32PicStride[0] * tVideoFrame.u32Height * 3;
            break;
        default:
            tSrcFrame.eDtype = AX_NPU_CV_FDT_UNKNOWN;
            break;
        }
        tSrcFrame.tStride.nW = (0 == tVideoFrame.u32PicStride[0]) ? tSrcFrame.nWidth : tVideoFrame.u32PicStride[0];
        tSrcFrame.nSize = tVideoFrame.u32FrameSize; // t.tStride.nW * t.nHeight * 3 / 2;
        tSrcFrame.pPhy = tVideoFrame.u64PhyAddr[0];
        tSrcFrame.pVir = (AX_U8 *)tVideoFrame.u64VirAddr[0];

        if (pipe->output_func)
        {
            // printf("%d %d\n", tSrcFrame.nWidth, tSrcFrame.nHeight);
            pipeline_buffer_t buf;
            buf.pipeid = pipe->pipeid;
            buf.m_output_type = pipe->m_output_type;
            buf.n_width = tSrcFrame.nWidth;
            buf.n_height = tSrcFrame.nHeight;
            buf.n_size = tSrcFrame.nSize;
            buf.n_stride = tSrcFrame.tStride.nW;
            buf.d_type = tSrcFrame.eDtype;
            buf.p_vir = tSrcFrame.pVir;
            buf.p_phy = tSrcFrame.pPhy;
            buf.p_pipe = pipe;
            pipe->output_func(&buf);
        }

        ret = AX_IVPS_ReleaseChnFrame(pipe->m_ivps_attr.n_ivps_grp, 0, &tVideoFrame);
    }
    ALOGN("SAMPLE_RUN_JOINT ---");
    return (AX_VOID *)0;
}

void *_venc_get_frame_thread(void *arg)
{
    pipeline_t *pipe = (pipeline_t *)arg;
    AX_S16 syncType = -1;
    AX_VENC_STREAM_S stStream;
    AX_VENC_RECV_PIC_PARAM_S stRecvParam;
    int s32Ret = AX_VENC_StartRecvFrame(pipe->m_venc_attr.n_venc_chn, &stRecvParam);
    if (AX_SUCCESS != s32Ret)
    {
        ALOGE("AX_VENC_StartRecvFrame failed, s32Ret:0x%x\n", s32Ret);
        return NULL;
    }

    while (!pipe->n_loog_exit)
    {
        s32Ret = AX_VENC_GetStream(pipe->m_venc_attr.n_venc_chn, &stStream, syncType);
        // printf("%d\n",stStream.stPack.u32Len);
        if (AX_SUCCESS == s32Ret)
        {

            switch (pipe->m_output_type)
            {
            case po_rtsp_h264:
            case po_rtsp_h265:
            {
                if (contain(pipeline_handle.rtsp_pipeid_sessiones, pipe->pipeid))
                {
                    rtsp_sever_tx_video(pipeline_handle.rDemoHandle, pipeline_handle.rtsp_pipeid_sessiones[pipe->pipeid], stStream.stPack.pu8Addr, stStream.stPack.u32Len, stStream.stPack.u64PTS);
                }
            }
            break;
            default:
                break;
            }
            
            if (pipe->output_func)
            {
                pipeline_buffer_t buf;
                buf.pipeid = pipe->pipeid;
                buf.m_output_type = pipe->m_output_type;
                buf.n_width = 0;
                buf.n_height = 0;
                buf.n_size = stStream.stPack.u32Len;
                buf.n_stride = 0;
                buf.d_type = 0;
                buf.p_vir = stStream.stPack.pu8Addr;
                buf.p_phy = stStream.stPack.ulPhyAddr;
                buf.p_pipe = pipe;
                pipe->output_func(&buf);
            }

            s32Ret = AX_VENC_ReleaseStream(pipe->m_venc_attr.n_venc_chn, &stStream);
        }
        else
        {
            ALOGE("VencChn %d: AX_VENC_ReleaseStream failed!s32Ret:0x%x\n", pipe->m_venc_attr.n_venc_chn, s32Ret);
            goto EXIT;
        }
    }

EXIT:
    ALOGN("VencChn %d: getStream Exit!\n", pipe->m_venc_attr.n_venc_chn);
    return NULL;
}

void *_vdec_get_frame_thread(void *arg)
{
    pipeline_t *pipe = (pipeline_t *)arg;
    AX_VIDEO_FRAME_INFO_S frameInfo = {0};
    // AX_VIDEO_FRAME_S frame;
    while (!pipe->n_loog_exit)
    {
        AX_S32 ret = AX_VDEC_GetFrame(pipe->n_vdec_grp, &frameInfo, 200);
        if (ret != 0)
        {
            ALOGE("AX_VDEC_GetFrame 0x%x", ret);
            usleep(50 * 1000);
            continue;
        }
        else
        {

            frameInfo.stVFrame.u64VirAddr[0] = (AX_U32)AX_POOL_GetBlockVirAddr(frameInfo.stVFrame.u32BlkId[0]);
            frameInfo.stVFrame.u64PhyAddr[0] = AX_POOL_Handle2PhysAddr(frameInfo.stVFrame.u32BlkId[0]);
            ALOGI("AX_VDEC_GetFrame success %d %d %d %d %ld %ld", frameInfo.stVFrame.u32Width, frameInfo.stVFrame.u32Height, frameInfo.stVFrame.enImgFormat,
                  frameInfo.stVFrame.u32BlkId[0],
                  frameInfo.stVFrame.u64PhyAddr[0], frameInfo.stVFrame.u64VirAddr[0]);
        }

        ret = AX_IVPS_SendFrame(pipe->m_ivps_attr.n_ivps_grp, &frameInfo.stVFrame, 0);
        if (ret != 0)
        {
            ALOGE("AX_IVPS_SendFrame 0x%x", ret);
        }

        AX_VDEC_ReleaseFrame(pipe->n_vdec_grp, &frameInfo);
    }
}

AX_S32 _create_vo(char *pStr, pipeline_t *pipe)
{

    /* for device */
    stVoConf.VoDev = SAMPLE_VO_DEV0;
    stVoConf.enVoIntfType = VO_INTF_DSI0;
    stVoConf.enIntfSync = VO_OUTPUT_USER;
    stVoConf.stReso.u32Width = 1280;
    stVoConf.stReso.u32Height = 800;
    stVoConf.stReso.u32RefreshRate = 45;
    stVoConf.u32LayerNr = 1;

    // layer0
    stVoConf.stVoLayer[0].VoLayer = 0;
    stVoConf.stVoLayer[0].stVoLayerAttr.stDispRect = {0, 0, 1280, 800};
    stVoConf.stVoLayer[0].stVoLayerAttr.stImageSize = {1280, 800};
    stVoConf.stVoLayer[0].stVoLayerAttr.enPixFmt = AX_YUV420_SEMIPLANAR;
    stVoConf.stVoLayer[0].stVoLayerAttr.enLayerSync = VO_LAYER_SYNC_PRIMARY;
    stVoConf.stVoLayer[0].stVoLayerAttr.u32PrimaryChnId = 0;
    stVoConf.stVoLayer[0].stVoLayerAttr.u32FrameRate = 0;
    stVoConf.stVoLayer[0].stVoLayerAttr.u32FifoDepth = 0;
    stVoConf.stVoLayer[0].stVoLayerAttr.u32ChnNr = 2;
    stVoConf.stVoLayer[0].stVoLayerAttr.u32BkClr = 0;
    stVoConf.stVoLayer[0].stVoLayerAttr.enLayerBuf = VO_LAYER_OUT_BUF_POOL;
    stVoConf.stVoLayer[0].stVoLayerAttr.u32InplaceChnId = 0;
    stVoConf.stVoLayer[0].stVoLayerAttr.u32PoolId = 0;
    stVoConf.stVoLayer[0].stVoLayerAttr.enDispatchMode = VO_LAYER_OUT_TO_FIFO;
    stVoConf.stVoLayer[0].stVoLayerAttr.u64KeepChnPrevFrameBitmap = 0x1;
    stVoConf.stVoLayer[0].enVoMode = VO_MODE_1MUX;
    // layer1
    stVoConf.stVoLayer[1].VoLayer = 1;
    stVoConf.stVoLayer[1].stVoLayerAttr.stDispRect = {0, 0, 1280, 800};
    stVoConf.stVoLayer[1].stVoLayerAttr.stImageSize = {1280, 800};
    stVoConf.stVoLayer[1].stVoLayerAttr.enPixFmt = AX_YUV420_SEMIPLANAR;
    stVoConf.stVoLayer[1].stVoLayerAttr.enLayerSync = VO_LAYER_SYNC_NORMAL;
    stVoConf.stVoLayer[1].stVoLayerAttr.u32PrimaryChnId = 0;
    stVoConf.stVoLayer[1].stVoLayerAttr.u32FrameRate = 0;
    stVoConf.stVoLayer[1].stVoLayerAttr.u32FifoDepth = 0;
    stVoConf.stVoLayer[1].stVoLayerAttr.u32ChnNr = 16;
    stVoConf.stVoLayer[1].stVoLayerAttr.u32BkClr = 0;
    stVoConf.stVoLayer[1].stVoLayerAttr.enLayerBuf = VO_LAYER_OUT_BUF_POOL;
    stVoConf.stVoLayer[1].stVoLayerAttr.u32InplaceChnId = 0;
    stVoConf.stVoLayer[1].stVoLayerAttr.u32PoolId = 0;
    stVoConf.stVoLayer[1].stVoLayerAttr.enDispatchMode = VO_LAYER_OUT_TO_FIFO;
    stVoConf.stVoLayer[1].stVoLayerAttr.u64KeepChnPrevFrameBitmap = ~0x0;

    stVoConf.stVoLayer[1].enVoMode = VO_MODE_1MUX;

    AX_S32 i, s32Ret;
    AX_U64 u64BlkSize = 0;
    SAMPLE_VO_LAYER_CONFIG_S *pstVoLayer;
    VO_VIDEO_LAYER_ATTR_S *pstVoLayerAttr;
    SAMPLE_VO_CHN_THREAD_PARAM_S *pstChnThreadParam = &g_stChnThreadParam;

    s32Ret = ParseVoPubAttr(pStr, &stVoConf);
    SAMPLE_VO_CONFIG_S *pstVoConf = &stVoConf;

    s32Ret = AX_SYS_Init();
    if (s32Ret)
    {
        SAMPLE_PRT("AX_SYS_Init failed, s32Ret = 0x%x\n", s32Ret);
        return -1;
    }

    s32Ret = AX_VO_Init();
    if (s32Ret)
    {
        SAMPLE_PRT("AX_VO_Init failed, s32Ret = 0x%x\n", s32Ret);
        goto exit0;
    }

    SAMPLE_PRT("u32LayerNr = %d\n", pstVoConf->u32LayerNr);

    for (i = 0; i < pstVoConf->u32LayerNr; i++)
    {
        pstVoLayer = &pstVoConf->stVoLayer[i];
        pstVoLayerAttr = &pstVoLayer->stVoLayerAttr;
        if (i == 0)
        {
            switch (pipe->m_ivps_attr.n_ivps_rotate)
            {
            case 1:
            case 3:
                pstVoLayerAttr->stImageSize.u32Width = pipe->m_ivps_attr.n_ivps_height;
                pstVoLayerAttr->stImageSize.u32Height = pipe->m_ivps_attr.n_ivps_width;
                break;
            default:
                pstVoLayerAttr->stImageSize.u32Width = pipe->m_ivps_attr.n_ivps_width;
                pstVoLayerAttr->stImageSize.u32Height = pipe->m_ivps_attr.n_ivps_height;
                break;
            }
        }
        else
        {
            // pstVoLayer->enVoMode = VO_MODE_1MUX;
            // pstVoLayerAttr->stImageSize.u32Width = (pstVoConf->stReso.u32Width + 0xF) & (~0xF);
            // pstVoLayerAttr->stImageSize.u32Height = pstVoConf->stReso.u32Height;
            // pstVoLayerAttr->stDispRect.u32X = pstVoConf->stReso.u32Width;
            // pstVoLayerAttr->u32ChnNr = 1;
        }

        pstVoLayerAttr->stDispRect.u32Width = pstVoLayerAttr->stImageSize.u32Width;
        pstVoLayerAttr->stDispRect.u32Height = pstVoLayerAttr->stImageSize.u32Height;

        SAMPLE_PRT("layer%d u32Width = %d, u32Height = %d\n", i, pstVoLayerAttr->stImageSize.u32Width,
                   pstVoLayerAttr->stImageSize.u32Height);

        pstVoLayerAttr->u32PoolId = ~0;
        u64BlkSize = pstVoLayerAttr->stImageSize.u32Width * pstVoLayerAttr->stImageSize.u32Height * 3 / 2;
        s32Ret = SAMPLE_VO_CREATE_POOL(3, u64BlkSize, 512, &pstVoLayerAttr->u32PoolId);
        if (s32Ret)
        {
            SAMPLE_PRT("SAMPLE_VO_CREATE_POOL failed, s32Ret = 0x%x\n", s32Ret);
            goto exit1;
        }

        SAMPLE_PRT("layer pool id = 0x%x\n", pstVoLayerAttr->u32PoolId);
    }

    s32Ret = SAMPLE_COMM_VO_StartVO(pstVoConf);
    if (s32Ret)
    {
        SAMPLE_PRT("SAMPLE_COMM_VO_StartVO failed, s32Ret = 0x%x\n", s32Ret);
        goto exit1;
    }

    // for (i = 0; i < pstVoConf->u32LayerNr; i++) {
    //     pstVoLayer = &pstVoConf->stVoLayer[i];
    //     if (i == 0) {
    //         pstVoLayer->stSrcMod.enModId = AX_ID_IVPS;
    //         pstVoLayer->stSrcMod.s32GrpId = u32IvpsGrp;
    //         pstVoLayer->stSrcMod.s32ChnId = 0;

    //         pstVoLayer->stDstMod.enModId = AX_ID_VO;
    //         pstVoLayer->stDstMod.s32GrpId = 0;
    //         pstVoLayer->stDstMod.s32ChnId = 0;
    //         AX_SYS_Link(&pstVoLayer->stSrcMod, &pstVoLayer->stDstMod);
    //     } else {
    //         // pstChnThreadParam->u32LayerID = pstVoLayer->VoLayer;
    //         // pstChnThreadParam->u32ChnID = 0;
    //         // pstChnThreadParam->u32ThreadForceStop = 0;
    //         // pstChnThreadParam->u32UserPoolId = ~0;
    //         // pthread_create(&pstChnThreadParam->ThreadID, NULL, SAMPLE_VO_CHN_THREAD, pstChnThreadParam);
    //     }
    // }

    SAMPLE_PRT("done\n");

    return 0;

exit1:
    for (i = 0; i < pstVoConf->u32LayerNr; i++)
    {
        pstVoLayer = &pstVoConf->stVoLayer[i];
        pstVoLayerAttr = &pstVoLayer->stVoLayerAttr;
        if (pstVoLayerAttr->u32PoolId != ~0)
            SAMPLE_VO_POOL_DESTROY(pstVoLayerAttr->u32PoolId);
    }

    AX_VO_Deinit();

exit0:
    AX_SYS_Deinit();

    SAMPLE_PRT("done, s32Ret = 0x%x\n", s32Ret);

    return s32Ret;
}

AX_VOID _destory_vo()
{
    AX_S32 i;
    SAMPLE_VO_LAYER_CONFIG_S *pstVoLayer;
    VO_VIDEO_LAYER_ATTR_S *pstVoLayerAttr;
    SAMPLE_VO_CHN_THREAD_PARAM_S *pstChnThreadParam = &g_stChnThreadParam;
    SAMPLE_VO_CONFIG_S *pstVoConf = &stVoConf;

    // for (i = 0; i < pstVoConf->u32LayerNr; i++) {
    //     pstVoLayer = &pstVoConf->stVoLayer[i];
    //     if (i == 0) {
    //         AX_SYS_UnLink(&pstVoLayer->stSrcMod, &pstVoLayer->stDstMod);
    //     } else {
    //         if (pstChnThreadParam->ThreadID) {
    //             pstChnThreadParam->u32ThreadForceStop = 1;
    //             pthread_join(pstChnThreadParam->ThreadID, NULL);
    //         }
    //     }
    // }

    SAMPLE_COMM_VO_StopVO(pstVoConf);

    AX_VO_Deinit();

    for (i = 0; i < pstVoConf->u32LayerNr; i++)
    {
        pstVoLayer = &pstVoConf->stVoLayer[i];
        pstVoLayerAttr = &pstVoLayer->stVoLayerAttr;
        if (i != 0)
        {
            if (pstChnThreadParam->u32UserPoolId != ~0)
                SAMPLE_VO_POOL_DESTROY(pstChnThreadParam->u32UserPoolId);
        }

        if (pstVoLayerAttr->u32PoolId != ~0)
            SAMPLE_VO_POOL_DESTROY(pstVoLayerAttr->u32PoolId);
    }

    AX_SYS_Deinit();
}

int _create_ivps_grp(pipeline_t *pipe)
{
    AX_S32 s32Ret = 0;
    AX_S32 nGrp = pipe->m_ivps_attr.n_ivps_grp, nChn = 0;
    AX_IVPS_GRP_ATTR_S stGrpAttr = {0};
    AX_IVPS_PIPELINE_ATTR_S stPipelineAttr = {0};

    stPipelineAttr.tFbInfo.PoolId = AX_INVALID_POOLID;
    stPipelineAttr.nOutChnNum = 1;

    stGrpAttr.nInFifoDepth = 1;
    stGrpAttr.ePipeline = AX_IVPS_PIPELINE_DEFAULT;
    s32Ret = AX_IVPS_CreateGrp(nGrp, &stGrpAttr);
    if (0 != s32Ret)
    {
        ALOGE("AX_IVPS_CreateGrp failed,nGrp %d,s32Ret:0x%x\n", nGrp, s32Ret);
        return s32Ret;
    }

    memset(&stPipelineAttr.tFilter, 0x00, sizeof(stPipelineAttr.tFilter));

    stPipelineAttr.tFilter[nChn + 1][0].bEnable = AX_TRUE;
    stPipelineAttr.tFilter[nChn + 1][0].tFRC.nSrcFrameRate = pipe->m_ivps_attr.n_ivps_fps;
    stPipelineAttr.tFilter[nChn + 1][0].tFRC.nDstFrameRate = pipe->m_ivps_attr.n_ivps_fps;
    stPipelineAttr.tFilter[nChn + 1][0].nDstPicOffsetX0 = 0;
    stPipelineAttr.tFilter[nChn + 1][0].nDstPicOffsetY0 = 0;
    stPipelineAttr.tFilter[nChn + 1][0].nDstPicWidth = pipe->m_ivps_attr.n_ivps_width;
    stPipelineAttr.tFilter[nChn + 1][0].nDstPicHeight = pipe->m_ivps_attr.n_ivps_height;
    stPipelineAttr.tFilter[nChn + 1][0].nDstPicStride = ALIGN_UP(stPipelineAttr.tFilter[nChn + 1][0].nDstPicWidth, 64);
    stPipelineAttr.tFilter[nChn + 1][0].nDstFrameWidth = pipe->m_ivps_attr.n_ivps_width;
    stPipelineAttr.tFilter[nChn + 1][0].nDstFrameHeight = pipe->m_ivps_attr.n_ivps_height;
    stPipelineAttr.tFilter[nChn + 1][0].eDstPicFormat = AX_YUV420_SEMIPLANAR;
    stPipelineAttr.tFilter[nChn + 1][0].eEngine = AX_IVPS_ENGINE_TDP;

    if (pipe->m_ivps_attr.b_letterbox)
    {
        // letterbox filling image
        AX_IVPS_ASPECT_RATIO_S tAspectRatio;
        tAspectRatio.eMode = AX_IVPS_ASPECT_RATIO_AUTO;
        tAspectRatio.eAligns[0] = AX_IVPS_ASPECT_RATIO_HORIZONTAL_CENTER;
        tAspectRatio.eAligns[1] = AX_IVPS_ASPECT_RATIO_VERTICAL_CENTER;
        tAspectRatio.nBgColor = 0x0000FF;
        stPipelineAttr.tFilter[nChn + 1][0].tTdpCfg.tAspectRatio = tAspectRatio;
    }

    stPipelineAttr.tFilter[nChn + 1][0].tTdpCfg.bFlip = pipe->m_ivps_attr.b_ivps_flip > 0 ? AX_TRUE : AX_FALSE;
    stPipelineAttr.tFilter[nChn + 1][0].tTdpCfg.bMirror = pipe->m_ivps_attr.b_ivps_mirror > 0 ? AX_TRUE : AX_FALSE;
    stPipelineAttr.tFilter[nChn + 1][0].tTdpCfg.eRotation = (AX_IVPS_ROTATION_E)pipe->m_ivps_attr.n_ivps_rotate;

    switch (stPipelineAttr.tFilter[nChn + 1][0].tTdpCfg.eRotation)
    {
    case AX_IVPS_ROTATION_90:
    case AX_IVPS_ROTATION_270:
        stPipelineAttr.tFilter[nChn + 1][0].nDstPicWidth = pipe->m_ivps_attr.n_ivps_height;
        stPipelineAttr.tFilter[nChn + 1][0].nDstPicHeight = pipe->m_ivps_attr.n_ivps_width;
        stPipelineAttr.tFilter[nChn + 1][0].nDstFrameWidth = pipe->m_ivps_attr.n_ivps_height;
        stPipelineAttr.tFilter[nChn + 1][0].nDstFrameHeight = pipe->m_ivps_attr.n_ivps_width;
        break;

    default:
        break;
    }

    switch (pipe->m_output_type)
    {
    case po_buff_rgb:
        stPipelineAttr.tFilter[nChn + 1][0].eDstPicFormat = AX_FORMAT_RGB888;
        break;
    case po_buff_bgr:
        stPipelineAttr.tFilter[nChn + 1][0].eDstPicFormat = AX_FORMAT_BGR888;
        break;
    case po_buff_nv21:
        stPipelineAttr.tFilter[nChn + 1][0].eDstPicFormat = AX_YUV420_SEMIPLANAR_VU;
        break;
    case po_buff_nv12:
    case po_venc_mjpg:
    case po_venc_h264:
    case po_venc_h265:
    case po_rtsp_h264:
    case po_rtsp_h265:
    case po_vo_sipeed_maix3_screen:
        stPipelineAttr.tFilter[nChn + 1][0].eDstPicFormat = AX_YUV420_SEMIPLANAR;
        break;
    default:
        break;
    }

    stPipelineAttr.nOutFifoDepth[nChn] = pipe->m_ivps_attr.n_fifo_count;
    if (stPipelineAttr.nOutFifoDepth[nChn] < 0)
        stPipelineAttr.nOutFifoDepth[nChn] = 0;
    if (stPipelineAttr.nOutFifoDepth[nChn] > 4)
        stPipelineAttr.nOutFifoDepth[nChn] = 4;

    s32Ret = AX_IVPS_SetPipelineAttr(nGrp, &stPipelineAttr);
    if (0 != s32Ret)
    {
        ALOGE("AX_IVPS_SetPipelineAttr failed,nGrp %d,s32Ret:0x%x\n", nGrp, s32Ret);
        return s32Ret;
    }

    s32Ret = AX_IVPS_EnableChn(nGrp, nChn);
    if (0 != s32Ret)
    {
        ALOGE("AX_IVPS_EnableChn failed,nGrp %d,nChn %d,s32Ret:0x%x\n", nGrp, nChn, s32Ret);
        return s32Ret;
    }

    s32Ret = AX_IVPS_StartGrp(nGrp);
    if (0 != s32Ret)
    {
        ALOGE("AX_IVPS_StartGrp failed,nGrp %d,s32Ret:0x%x\n", nGrp, s32Ret);
        return s32Ret;
    }

    for (int i = 0; i < pipe->m_ivps_attr.n_osd_rgn && i < MAX_OSD_RGN_COUNT; i++)
    {
        IVPS_RGN_HANDLE hChnRgn = AX_IVPS_RGN_Create();
        if (AX_IVPS_INVALID_REGION_HANDLE != hChnRgn)
        {
            AX_S32 nFilter = 0x10;
            int nRet = AX_IVPS_RGN_AttachToFilter(hChnRgn, pipe->m_ivps_attr.n_ivps_grp, nFilter);
            if (0 != nRet)
            {
                ALOGE("AX_IVPS_RGN_AttachToFilter(Grp: %d, Filter: 0x%x) failed, ret=0x%x", pipe->m_ivps_attr.n_ivps_grp, nFilter, nRet);
                pipe->m_ivps_attr.n_osd_rgn = i;
                break;
            }
            pipe->m_ivps_attr.n_osd_rgn_chn[i] = hChnRgn;
            continue;
        }
        pipe->m_ivps_attr.n_osd_rgn = i;
        break;
    }

    switch (pipe->m_output_type)
    {
    case po_buff_rgb:
    case po_buff_bgr:
    case po_buff_nv12:
    case po_buff_nv21:
        if (stPipelineAttr.nOutFifoDepth[nChn] > 0)
        {
            pthread_t tid = 0;
            if (0 != pthread_create(&tid, NULL, _ivps_get_frame_thread, pipe))
            {
                return -1;
            }
            pthread_detach(tid);
        }
        else
        {

            ALOGW("m_output_type set po_buff mode,but pipe->m_ivps_attr.n_fifo_count got %d", pipe->m_ivps_attr.n_fifo_count);
        }
        break;
    default:
        break;
    }

    return 0;
}

int _destore_ivps_grp(pipeline_t *pipe)
{
    AX_S32 s32Ret = 0;

    s32Ret = AX_IVPS_StopGrp(pipe->m_ivps_attr.n_ivps_grp);
    if (0 != s32Ret)
    {
        ALOGE("AX_IVPS_StopGrp failed,nGrp %d,s32Ret:0x%x\n", pipe->m_ivps_attr.n_ivps_grp, s32Ret);
        return s32Ret;
    }

    s32Ret = AX_IVPS_DisableChn(pipe->m_ivps_attr.n_ivps_grp, 0);
    if (0 != s32Ret)
    {
        ALOGE("AX_IVPS_DisableChn failed,nGrp %d,nChn %d,s32Ret:0x%x\n", pipe->m_ivps_attr.n_ivps_grp, 0, s32Ret);
        return s32Ret;
    }

    s32Ret = AX_IVPS_DestoryGrp(pipe->m_ivps_attr.n_ivps_grp);
    if (0 != s32Ret)
    {
        ALOGE("AX_IVPS_DestoryGrp failed,nGrp %d,s32Ret:0x%x", pipe->m_ivps_attr.n_ivps_grp, s32Ret);
        return s32Ret;
    }
    return 0;
}

AX_BOOL set_jpeg_param(pipeline_t *pipe)
{
    AX_S32 s32Ret = 0;
    AX_VENC_JPEG_PARAM_S stJpegParam;
    memset(&stJpegParam, 0, sizeof(stJpegParam));
    s32Ret = AX_VENC_GetJpegParam(pipe->m_venc_attr.n_venc_chn, &stJpegParam);
    if (AX_SUCCESS != s32Ret)
    {
        printf("AX_VENC_GetJpegParam:%d failed, error type 0x%x!\n", pipe->m_venc_attr.n_venc_chn, s32Ret);
        return AX_FALSE;
    }

    stJpegParam.u32Qfactor = 90;
    /* Use user set qtable. Qtable example */
    // if (gS32QTableEnable)
    // {
    //     memcpy(stJpegParam.u8YQt, QTableLuminance, sizeof(QTableLuminance));
    //     memcpy(stJpegParam.u8CbCrQt, QTableChrominance, sizeof(QTableChrominance));
    // }

    s32Ret = AX_VENC_SetJpegParam(pipe->m_venc_attr.n_venc_chn, &stJpegParam);
    if (AX_SUCCESS != s32Ret)
    {
        printf("AX_VENC_SetJpegParam:%d failed, error type 0x%x!\n", pipe->m_venc_attr.n_venc_chn, s32Ret);
        return AX_FALSE;
    }

    return AX_TRUE;
}

AX_BOOL set_rc_param(pipeline_t *pipe, AX_VENC_RC_MODE_E enRcMode)
{
    // #ifdef VIDEO_ENABLE_RC_DYNAMIC
    AX_S32 s32Ret = 0;
    AX_VENC_RC_PARAM_S stRcParam;

    s32Ret = AX_VENC_GetRcParam(pipe->m_venc_attr.n_venc_chn, &stRcParam);
    if (AX_SUCCESS != s32Ret)
    {
        printf("AX_VENC_GetRcParam:%d failed, error type 0x%x!\n", pipe->m_venc_attr.n_venc_chn, s32Ret);
        return AX_FALSE;
    }

    if (enRcMode == VENC_RC_MODE_MJPEGCBR)
    {
        stRcParam.stMjpegCbr.u32BitRate = 4000;
        stRcParam.stMjpegCbr.u32MinQp = 20;
        stRcParam.stMjpegCbr.u32MaxQp = 30;
    }
    else if (enRcMode == VENC_RC_MODE_MJPEGVBR)
    {
        stRcParam.stMjpegVbr.u32MaxBitRate = 4000;
        stRcParam.stMjpegVbr.u32MinQp = 20;
        stRcParam.stMjpegVbr.u32MaxQp = 30;
    }
    else if (enRcMode == VENC_RC_MODE_MJPEGFIXQP)
    {
        stRcParam.stMjpegFixQp.s32FixedQp = 22;
    }

    s32Ret = AX_VENC_SetRcParam(pipe->m_venc_attr.n_venc_chn, &stRcParam);
    if (AX_SUCCESS != s32Ret)
    {
        printf("AX_VENC_SetRcParam:%d failed, error type 0x%x!\n", pipe->m_venc_attr.n_venc_chn, s32Ret);
        return AX_FALSE;
    }

    // #endif
    return AX_TRUE;
}

int _create_venc_chn(pipeline_t *pipe)
{
    typedef struct _stRCInfo
    {
        SAMPLE_VENC_RC_E eRCType;
        AX_U32 nMinQp;
        AX_U32 nMaxQp;
        AX_U32 nMinIQp;
        AX_U32 nMaxIQp;
        AX_S32 nIntraQpDelta;
    } RC_INFO_T;
    typedef struct _stVideoConfig
    {
        AX_PAYLOAD_TYPE_E ePayloadType;
        AX_U32 nGOP;
        AX_U32 nSrcFrameRate;
        AX_U32 nDstFrameRate;
        AX_U32 nStride;
        AX_S32 nInWidth;
        AX_S32 nInHeight;
        AX_S32 nOutWidth;
        AX_S32 nOutHeight;
        AX_S32 nOffsetCropX;
        AX_S32 nOffsetCropY;
        AX_S32 nOffsetCropW;
        AX_S32 nOffsetCropH;
        AX_IMG_FORMAT_E eImgFormat;
        RC_INFO_T stRCInfo;
        AX_S32 nBitrate;
    } VIDEO_CONFIG_T;
    AX_VENC_CHN_ATTR_S stVencChnAttr;
    VIDEO_CONFIG_T config;
    memset(&config, 0, sizeof(VIDEO_CONFIG_T));
    AX_S32 s32Ret = 0;

    config.stRCInfo.eRCType = VENC_RC_VBR;
    config.nGOP = 50;
    config.nBitrate = 5000;
    config.stRCInfo.nMinQp = 10;
    config.stRCInfo.nMaxQp = 51;
    config.stRCInfo.nMinIQp = 10;
    config.stRCInfo.nMaxIQp = 51;
    config.stRCInfo.nIntraQpDelta = -2;
    config.nOffsetCropX = 0;
    config.nOffsetCropY = 0;
    config.nOffsetCropW = 0;
    config.nOffsetCropH = 0;
    switch (pipe->m_output_type)
    {
    case po_venc_h264:
    case po_rtsp_h264:
        config.ePayloadType = PT_H264;
        break;
    case po_venc_h265:
    case po_rtsp_h265:
        config.ePayloadType = PT_H265;
        break;
    case po_venc_mjpg:
        config.ePayloadType = PT_MJPEG;
        break;
    default:
        ALOGE("pipeline_output_e=%d,should not init venc");
        return -1;
    }

    config.nInWidth = pipe->m_ivps_attr.n_ivps_width;
    config.nInHeight = pipe->m_ivps_attr.n_ivps_height;
    config.nStride = config.nInWidth;

    switch (pipe->m_ivps_attr.n_ivps_rotate)
    {
    case AX_IVPS_ROTATION_90:
    case AX_IVPS_ROTATION_270:
        config.nInWidth = pipe->m_ivps_attr.n_ivps_height;
        config.nInHeight = pipe->m_ivps_attr.n_ivps_width;
        config.nStride = config.nInWidth;
        break;

    default:
        break;
    }

    config.nSrcFrameRate = pipe->m_ivps_attr.n_ivps_fps;
    config.nDstFrameRate = pipe->m_ivps_attr.n_ivps_fps;

    memset(&stVencChnAttr, 0, sizeof(AX_VENC_CHN_ATTR_S));

    stVencChnAttr.stVencAttr.u32MaxPicWidth = 0;
    stVencChnAttr.stVencAttr.u32MaxPicHeight = 0;

    stVencChnAttr.stVencAttr.u32PicWidthSrc = config.nInWidth;   /*the picture width*/
    stVencChnAttr.stVencAttr.u32PicHeightSrc = config.nInHeight; /*the picture height*/

    stVencChnAttr.stVencAttr.u32CropOffsetX = config.nOffsetCropX;
    stVencChnAttr.stVencAttr.u32CropOffsetY = config.nOffsetCropY;
    stVencChnAttr.stVencAttr.u32CropWidth = config.nOffsetCropW;
    stVencChnAttr.stVencAttr.u32CropHeight = config.nOffsetCropH;
    stVencChnAttr.stVencAttr.u32VideoRange = 1; /* 0: Narrow Range(NR), Y[16,235], Cb/Cr[16,240]; 1: Full Range(FR), Y/Cb/Cr[0,255] */

    // ALOGN("VencChn %d:w:%d, h:%d, s:%d, Crop:(%d, %d, %d, %d) rcType:%d, payload:%d", gVencChnMapping[VencChn], stVencChnAttr.stVencAttr.u32PicWidthSrc, stVencChnAttr.stVencAttr.u32PicHeightSrc, config.nStride, stVencChnAttr.stVencAttr.u32CropOffsetX, stVencChnAttr.stVencAttr.u32CropOffsetY, stVencChnAttr.stVencAttr.u32CropWidth, stVencChnAttr.stVencAttr.u32CropHeight, config.stRCInfo.eRCType, config.ePayloadType);

    stVencChnAttr.stVencAttr.u32BufSize = config.nStride * config.nInHeight * 3 / 2; /*stream buffer size*/
    stVencChnAttr.stVencAttr.u32MbLinesPerSlice = 0;                                 /*get stream mode is slice mode or frame mode?*/
    stVencChnAttr.stVencAttr.enLinkMode = AX_LINK_MODE;
    stVencChnAttr.stVencAttr.u32GdrDuration = 0;
    /* GOP Setting */
    stVencChnAttr.stGopAttr.enGopMode = VENC_GOPMODE_NORMALP;

    stVencChnAttr.stVencAttr.enType = config.ePayloadType;
    switch (stVencChnAttr.stVencAttr.enType)
    {
    case PT_H265:
    {
        stVencChnAttr.stVencAttr.enProfile = VENC_HEVC_MAIN_PROFILE;
        stVencChnAttr.stVencAttr.enLevel = VENC_HEVC_LEVEL_6;
        stVencChnAttr.stVencAttr.enTier = VENC_HEVC_MAIN_TIER;

        if (config.stRCInfo.eRCType == VENC_RC_CBR)
        {
            AX_VENC_H265_CBR_S stH265Cbr;
            stVencChnAttr.stRcAttr.enRcMode = VENC_RC_MODE_H265CBR;
            stVencChnAttr.stRcAttr.s32FirstFrameStartQp = -1;
            stH265Cbr.u32Gop = config.nGOP;
            stH265Cbr.u32SrcFrameRate = config.nSrcFrameRate;  /* input frame rate */
            stH265Cbr.fr32DstFrameRate = config.nDstFrameRate; /* target frame rate */
            stH265Cbr.u32BitRate = config.nBitrate;
            stH265Cbr.u32MinQp = config.stRCInfo.nMinQp;
            stH265Cbr.u32MaxQp = config.stRCInfo.nMaxQp;
            stH265Cbr.u32MinIQp = config.stRCInfo.nMinIQp;
            stH265Cbr.u32MaxIQp = config.stRCInfo.nMaxIQp;
            stH265Cbr.s32IntraQpDelta = config.stRCInfo.nIntraQpDelta;
            memcpy(&stVencChnAttr.stRcAttr.stH265Cbr, &stH265Cbr, sizeof(AX_VENC_H265_CBR_S));
        }
        else if (config.stRCInfo.eRCType == VENC_RC_VBR)
        {
            AX_VENC_H265_VBR_S stH265Vbr;
            stVencChnAttr.stRcAttr.enRcMode = VENC_RC_MODE_H265VBR;
            stVencChnAttr.stRcAttr.s32FirstFrameStartQp = -1;
            stH265Vbr.u32Gop = config.nGOP;
            stH265Vbr.u32SrcFrameRate = config.nSrcFrameRate;
            stH265Vbr.fr32DstFrameRate = config.nDstFrameRate;
            stH265Vbr.u32MaxBitRate = config.nBitrate;
            stH265Vbr.u32MinQp = config.stRCInfo.nMinQp;
            stH265Vbr.u32MaxQp = config.stRCInfo.nMaxQp;
            stH265Vbr.u32MinIQp = config.stRCInfo.nMinIQp;
            stH265Vbr.u32MaxIQp = config.stRCInfo.nMaxIQp;
            stH265Vbr.s32IntraQpDelta = config.stRCInfo.nIntraQpDelta;
            memcpy(&stVencChnAttr.stRcAttr.stH265Vbr, &stH265Vbr, sizeof(AX_VENC_H265_VBR_S));
        }
        else if (config.stRCInfo.eRCType == VENC_RC_FIXQP)
        {
            AX_VENC_H265_FIXQP_S stH265FixQp;
            stVencChnAttr.stRcAttr.enRcMode = VENC_RC_MODE_H265FIXQP;
            stH265FixQp.u32Gop = config.nGOP;
            stH265FixQp.u32SrcFrameRate = config.nSrcFrameRate;
            stH265FixQp.fr32DstFrameRate = config.nDstFrameRate;
            stH265FixQp.u32IQp = 25;
            stH265FixQp.u32PQp = 30;
            stH265FixQp.u32BQp = 32;
            memcpy(&stVencChnAttr.stRcAttr.stH265FixQp, &stH265FixQp, sizeof(AX_VENC_H265_FIXQP_S));
        }
        break;
    }
    case PT_H264:
    {
        stVencChnAttr.stVencAttr.enProfile = VENC_H264_MAIN_PROFILE;
        stVencChnAttr.stVencAttr.enLevel = VENC_H264_LEVEL_5_2;

        if (config.stRCInfo.eRCType == VENC_RC_CBR)
        {
            AX_VENC_H264_CBR_S stH264Cbr;
            stVencChnAttr.stRcAttr.enRcMode = VENC_RC_MODE_H264CBR;
            stVencChnAttr.stRcAttr.s32FirstFrameStartQp = -1;
            stH264Cbr.u32Gop = config.nGOP;
            stH264Cbr.u32SrcFrameRate = config.nSrcFrameRate;  /* input frame rate */
            stH264Cbr.fr32DstFrameRate = config.nDstFrameRate; /* target frame rate */
            stH264Cbr.u32BitRate = config.nBitrate;
            stH264Cbr.u32MinQp = config.stRCInfo.nMinQp;
            stH264Cbr.u32MaxQp = config.stRCInfo.nMaxQp;
            stH264Cbr.u32MinIQp = config.stRCInfo.nMinIQp;
            stH264Cbr.u32MaxIQp = config.stRCInfo.nMaxIQp;
            stH264Cbr.s32IntraQpDelta = config.stRCInfo.nIntraQpDelta;
            memcpy(&stVencChnAttr.stRcAttr.stH264Cbr, &stH264Cbr, sizeof(AX_VENC_H264_CBR_S));
        }
        else if (config.stRCInfo.eRCType == VENC_RC_VBR)
        {
            AX_VENC_H264_VBR_S stH264Vbr;
            stVencChnAttr.stRcAttr.enRcMode = VENC_RC_MODE_H264VBR;
            stVencChnAttr.stRcAttr.s32FirstFrameStartQp = -1;
            stH264Vbr.u32Gop = config.nGOP;
            stH264Vbr.u32SrcFrameRate = config.nSrcFrameRate;
            stH264Vbr.fr32DstFrameRate = config.nDstFrameRate;
            stH264Vbr.u32MaxBitRate = config.nBitrate;
            stH264Vbr.u32MinQp = config.stRCInfo.nMinQp;
            stH264Vbr.u32MaxQp = config.stRCInfo.nMaxQp;
            stH264Vbr.u32MinIQp = config.stRCInfo.nMinIQp;
            stH264Vbr.u32MaxIQp = config.stRCInfo.nMaxIQp;
            stH264Vbr.s32IntraQpDelta = config.stRCInfo.nIntraQpDelta;
            memcpy(&stVencChnAttr.stRcAttr.stH264Vbr, &stH264Vbr, sizeof(AX_VENC_H264_VBR_S));
        }
        else if (config.stRCInfo.eRCType == VENC_RC_FIXQP)
        {
            AX_VENC_H264_FIXQP_S stH264FixQp;
            stVencChnAttr.stRcAttr.enRcMode = VENC_RC_MODE_H264FIXQP;
            stH264FixQp.u32Gop = config.nGOP;
            stH264FixQp.u32SrcFrameRate = config.nSrcFrameRate;
            stH264FixQp.fr32DstFrameRate = config.nDstFrameRate;
            stH264FixQp.u32IQp = 25;
            stH264FixQp.u32PQp = 30;
            stH264FixQp.u32BQp = 32;
            memcpy(&stVencChnAttr.stRcAttr.stH264FixQp, &stH264FixQp, sizeof(AX_VENC_H264_FIXQP_S));
        }
        break;
    }
    case PT_MJPEG:
    {
        if (config.stRCInfo.eRCType == VENC_RC_CBR)
        {
            AX_VENC_MJPEG_CBR_S stMjpegCbrAttr;
            memset(&stMjpegCbrAttr, 0, sizeof(stMjpegCbrAttr));
            stVencChnAttr.stRcAttr.enRcMode = VENC_RC_MODE_MJPEGCBR;
            // stVencChnAttr.stRcAttr.s32FirstFrameStartQp = -1;

            stMjpegCbrAttr.u32StatTime = 1;
            stMjpegCbrAttr.u32SrcFrameRate = config.nSrcFrameRate;
            stMjpegCbrAttr.fr32DstFrameRate = config.nDstFrameRate;
            stMjpegCbrAttr.u32BitRate = 4000;
            stMjpegCbrAttr.u32MinQp = 20;
            stMjpegCbrAttr.u32MaxQp = 30;
            memcpy(&stVencChnAttr.stRcAttr.stMjpegCbr, &stMjpegCbrAttr, sizeof(AX_VENC_MJPEG_CBR_S));
        }
        else if (config.stRCInfo.eRCType == VENC_RC_VBR)
        {
            AX_VENC_MJPEG_VBR_S stMjpegVbrAttr;
            memset(&stMjpegVbrAttr, 0, sizeof(stMjpegVbrAttr));
            stVencChnAttr.stRcAttr.enRcMode = VENC_RC_MODE_MJPEGVBR;
            // stVencChnAttr.stRcAttr.s32FirstFrameStartQp = -1;
            stMjpegVbrAttr.u32StatTime = 1;
            stMjpegVbrAttr.u32SrcFrameRate = config.nSrcFrameRate;
            stMjpegVbrAttr.fr32DstFrameRate = config.nDstFrameRate;
            stMjpegVbrAttr.u32MaxBitRate = 4000;
            stMjpegVbrAttr.u32MinQp = 20;
            stMjpegVbrAttr.u32MaxQp = 30;
            memcpy(&stVencChnAttr.stRcAttr.stMjpegVbr, &stMjpegVbrAttr, sizeof(AX_VENC_MJPEG_VBR_S));
        }
        else if (config.stRCInfo.eRCType == VENC_RC_FIXQP)
        {
            AX_VENC_MJPEG_FIXQP_S stMjpegFixQpAttr;
            memset(&stMjpegFixQpAttr, 0, sizeof(stMjpegFixQpAttr));
            stVencChnAttr.stRcAttr.enRcMode = VENC_RC_MODE_MJPEGFIXQP;

            stMjpegFixQpAttr.u32SrcFrameRate = config.nSrcFrameRate;
            stMjpegFixQpAttr.fr32DstFrameRate = config.nDstFrameRate;
            stMjpegFixQpAttr.s32FixedQp = 22;
            memcpy(&stVencChnAttr.stRcAttr.stMjpegFixQp, &stMjpegFixQpAttr, sizeof(AX_VENC_MJPEG_FIXQP_S));
        }
    }
    break;
    default:
        ALOGE("VencChn %d:Payload type unrecognized.", pipe->m_venc_attr.n_venc_chn);
        return -1;
    }

    AX_S32 ret = AX_VENC_CreateChn(pipe->m_venc_attr.n_venc_chn, &stVencChnAttr);
    if (AX_SUCCESS != ret)
    {
        ALOGE("VencChn %d: AX_VENC_CreateChn failed, s32Ret:0x%x", pipe->m_venc_attr.n_venc_chn, ret);
        return -1;
    }

    if (pipe->m_output_type == po_venc_mjpg)
    {
        set_rc_param(pipe, stVencChnAttr.stRcAttr.enRcMode);
        set_jpeg_param(pipe);
    }

    pthread_t tid = 0;
    if (0 != pthread_create(&tid, NULL, _venc_get_frame_thread, pipe))
    {
        return -1;
    }
    pthread_detach(tid);

    return 0;
}

int _destore_venc_grp(pipeline_t *pipe)
{
    AX_S32 s32Ret = 0;

    s32Ret = AX_VENC_StopRecvFrame(pipe->m_venc_attr.n_venc_chn);
    if (0 != s32Ret)
    {
        ALOGE("VencChn %d:AX_VENC_StopRecvFrame failed,s32Ret:0x%x.\n", pipe->m_venc_attr.n_venc_chn, s32Ret);
        return s32Ret;
    }

    s32Ret = AX_VENC_DestroyChn(pipe->m_venc_attr.n_venc_chn);
    if (0 != s32Ret)
    {
        ALOGE("VencChn %d:AX_VENC_DestroyChn failed,s32Ret:0x%x.\n", pipe->m_venc_attr.n_venc_chn, s32Ret);
        return s32Ret;
    }
    return 0;
}

int _create_vdec_grp(pipeline_t *pipe)
{
    AX_VDEC_GRP_ATTR_S gGrpAttr;
    memset(&gGrpAttr, 0, sizeof(AX_VDEC_GRP_ATTR_S));
    gGrpAttr.enType = PT_JPEG;
    gGrpAttr.enMode = VIDEO_MODE_FRAME;
    gGrpAttr.u32PicWidth = 4096;
    gGrpAttr.u32PicHeight = 4096;
    gGrpAttr.u32StreamBufSize = 10 * 1024 * 1024;
    gGrpAttr.u32FrameBufSize = 10 * 1024 * 1024;
    gGrpAttr.u32FrameBufCnt = 10;

    AX_POOL_CONFIG_T stPoolConfig = {0};
    AX_POOL s32PoolId;
    AX_U32 FrameSize = 0;

    FrameSize = AX_VDEC_GetPicBufferSize(1920, 1080, PT_H264);
    ALOGN("Get pool mem size is %d\n", FrameSize);

    memset(&stPoolConfig, 0, sizeof(AX_POOL_CONFIG_T));
    stPoolConfig.MetaSize = 1024;
    stPoolConfig.BlkCnt = 10;
    stPoolConfig.BlkSize = FrameSize;
    stPoolConfig.CacheMode = POOL_CACHE_MODE_NONCACHE;
    memset(stPoolConfig.PartitionName, 0, sizeof(stPoolConfig.PartitionName));
    strcpy((AX_CHAR *)stPoolConfig.PartitionName, "anonymous");

    s32PoolId = AX_POOL_CreatePool(&stPoolConfig);
    if (AX_INVALID_POOLID == s32PoolId)
    {
        ALOGE("AX_POOL_CreatePool err.\n");
        return -1;
    }

    gGrpAttr.u32FrameBufSize = FrameSize;
#if VDEC_LINK_MODE
    gGrpAttr.enLinkMode = AX_LINK_MODE;
#endif

    AX_S32 ret = AX_VDEC_CreateGrp(pipe->n_vdec_grp, &gGrpAttr);
    if (ret != AX_SUCCESS)
    {
        ALOGE("AX_VDEC_CreateGrp error: 0x%x\n", ret);
        return -1;
    }

    /*init pool memory for jdec*/
    ret = AX_VDEC_AttachPool(pipe->n_vdec_grp, s32PoolId);
    if (ret != AX_SUCCESS)
    {
        AX_POOL_MarkDestroyPool(s32PoolId);
        ALOGE("AX_VDEC_AttachPool error: %d\n", ret);
        AX_VDEC_DestroyGrp(pipe->n_vdec_grp);
        return -1;
    }

    ret = AX_VDEC_StartRecvStream(pipe->n_vdec_grp);
    if (ret != AX_SUCCESS)
    {
        ALOGE("AX_VDEC_StartRecvStream error: 0x%x\n", ret);
        AX_VDEC_DestroyGrp(pipe->n_vdec_grp);
        return -1;
    }
#if !VDEC_LINK_MODE
    pthread_t tid = 0;
    if (0 != pthread_create(&tid, NULL, _vdec_get_frame_thread, pipe))
    {
        return -1;
    }
    pthread_detach(tid);
#endif

    return 0;
}

int _destore_vdec_grp(pipeline_t *pipe)
{
    int ret = AX_VDEC_StopRecvStream(pipe->n_vdec_grp);

    ret = AX_VDEC_DetachPool(pipe->n_vdec_grp);

    ret = AX_VDEC_DestroyGrp(pipe->n_vdec_grp);
    return 0;
}

int create_pipeline(pipeline_t *pipe)
{
    if (pipe->enable == 0)
    {
        return -1;
    }

    if (contain(pipeline_handle.pipeid_pipe, pipe->pipeid))
    {
        ALOGE("PIPE-%d has been create", pipe->pipeid);
        return -1;
    }
    pipeline_handle.pipeid_pipe[pipe->pipeid] = pipe;

    switch (pipe->m_input_type)
    {
    case pi_user:
    {
        if (pipeline_handle.ivps_grp.size() == 0)
        {
            int s32Ret = AX_IVPS_Init();
            if (0 != s32Ret)
            {
                ALOGE("AX_IVPS_Init failed,s32Ret:0x%x\n", s32Ret);
                return s32Ret;
            }
        }
        if (contain(pipeline_handle.ivps_grp, pipe->m_ivps_attr.n_ivps_grp))
        {
            ALOGE("IVPS-%d has been create", pipe->m_ivps_attr.n_ivps_grp);
            return -1;
        }
        pipeline_handle.ivps_grp.push_back(pipe->m_ivps_attr.n_ivps_grp);
        int s32Ret = _create_ivps_grp(pipe);
        if (AX_SUCCESS != s32Ret)
        {
            ALOGE("_create_ivps_grp failed,s32Ret:0x%x\n", s32Ret);
            return -1;
        }
    }
    break;
    case pi_vin:
    {
        if (pipeline_handle.ivps_grp.size() == 0)
        {
            int s32Ret = AX_IVPS_Init();
            if (0 != s32Ret)
            {
                ALOGE("AX_IVPS_Init failed,s32Ret:0x%x\n", s32Ret);
                return s32Ret;
            }
        }
        if (contain(pipeline_handle.ivps_grp, pipe->m_ivps_attr.n_ivps_grp))
        {
            ALOGE("IVPS-%d has been create", pipe->m_ivps_attr.n_ivps_grp);
            return -1;
        }
        pipeline_handle.ivps_grp.push_back(pipe->m_ivps_attr.n_ivps_grp);

        int s32Ret = _create_ivps_grp(pipe);
        if (AX_SUCCESS != s32Ret)
        {
            ALOGE("_create_ivps_grp failed,s32Ret:0x%x\n", s32Ret);
            return -1;
        }

        AX_MOD_INFO_S srcMod, dstMod;
        srcMod.enModId = AX_ID_VIN;
        srcMod.s32GrpId = pipe->n_vin_pipe;
        srcMod.s32ChnId = pipe->n_vin_chn;

        dstMod.enModId = AX_ID_IVPS;
        dstMod.s32GrpId = pipe->m_ivps_attr.n_ivps_grp;
        dstMod.s32ChnId = 0;
        AX_SYS_Link(&srcMod, &dstMod);
    }
    break;
    case pi_vdec:
    {
        if (pipeline_handle.ivps_grp.size() == 0)
        {
            int s32Ret = AX_IVPS_Init();
            if (0 != s32Ret)
            {
                ALOGE("AX_IVPS_Init failed,s32Ret:0x%x\n", s32Ret);
                return s32Ret;
            }
        }
        if (contain(pipeline_handle.ivps_grp, pipe->m_ivps_attr.n_ivps_grp))
        {
            ALOGE("IVPS-%d has been create", pipe->m_ivps_attr.n_ivps_grp);
            return -1;
        }
        pipeline_handle.ivps_grp.push_back(pipe->m_ivps_attr.n_ivps_grp);

        if (pipeline_handle.vdec_grp.size() == 0)
        {
            int s32Ret = AX_VDEC_Init();
            if (0 != s32Ret)
            {
                ALOGE("AX_IVPS_Init failed,s32Ret:0x%x\n", s32Ret);
                return s32Ret;
            }
        }

        if (!contain(pipeline_handle.vdec_grp, pipe->n_vdec_grp))
        {
            int s32Ret = _create_vdec_grp(pipe);
            if (AX_SUCCESS != s32Ret)
            {
                ALOGE("_create_vdec_grp failed,s32Ret:0x%x\n", s32Ret);
                return -1;
            }
            pipeline_handle.vdec_grp.push_back(pipe->n_vdec_grp);
        }
#if VDEC_LINK_MODE
        AX_MOD_INFO_S srcMod, dstMod;
        srcMod.enModId = AX_ID_VDEC;
        srcMod.s32GrpId = pipe->n_vdec_grp;
        srcMod.s32ChnId = 0;

        dstMod.enModId = AX_ID_IVPS;
        dstMod.s32GrpId = pipe->m_ivps_attr.n_ivps_grp;
        dstMod.s32ChnId = 0;
        AX_SYS_Link(&srcMod, &dstMod);
#endif

        int s32Ret = _create_ivps_grp(pipe);
        if (AX_SUCCESS != s32Ret)
        {
            ALOGE("_create_ivps_grp failed,s32Ret:0x%x\n", s32Ret);
            return -1;
        }
    }
    break;
    default:
        break;
    }

    switch (pipe->m_output_type)
    {
    case po_venc_mjpg:
    case po_venc_h264:
    case po_venc_h265:
    case po_rtsp_h264:
    case po_rtsp_h265:
    {
        if (pipeline_handle.venc_chn.size() == 0)
        {
            AX_VENC_MOD_ATTR_S stModAttr;
            stModAttr.enVencType = VENC_MULTI_ENCODER;

            int s32Ret = AX_VENC_Init(&stModAttr);
            if (AX_SUCCESS != s32Ret)
            {
                ALOGE("AX_VENC_Init failed, s32Ret:0x%x", s32Ret);
                return s32Ret;
            }
        }

        if (contain(pipeline_handle.venc_chn, pipe->m_venc_attr.n_venc_chn))
        {
            ALOGE("VENC-%d has been create", pipe->m_venc_attr.n_venc_chn);
            return -1;
        }
        pipeline_handle.venc_chn.push_back(pipe->m_venc_attr.n_venc_chn);

        AX_MOD_INFO_S srcMod, dstMod;
        srcMod.enModId = AX_ID_IVPS;
        srcMod.s32GrpId = pipe->m_ivps_attr.n_ivps_grp;
        srcMod.s32ChnId = 0;

        dstMod.enModId = AX_ID_VENC;
        dstMod.s32GrpId = 0;
        dstMod.s32ChnId = pipe->m_venc_attr.n_venc_chn;
        AX_SYS_Link(&srcMod, &dstMod);
        // }

        // pipeline_handle.b_init_venc++;

        int s32Ret = _create_venc_chn(pipe);
        if (AX_SUCCESS != s32Ret)
        {
            ALOGE("_create_venc_chn failed,s32Ret:0x%x\n", s32Ret);
            return -1;
        }

        if (pipe->m_output_type == po_rtsp_h264 || pipe->m_output_type == po_rtsp_h265)
        {
            if (!pipeline_handle.rDemoHandle)
            {
                pipeline_handle.rDemoHandle = rtsp_new_demo(RTSP_PORT);
            }
            std::string end_point = pipe->m_venc_attr.end_point;
            if (end_point.length())
            {
                if (end_point[0] != '/')
                {
                    end_point = "/" + end_point;
                }
            }

            if (!contain(pipeline_handle.rtsp_end_point, end_point) && !contain(pipeline_handle.rtsp_pipeid_sessiones, pipe->pipeid))
            {
                auto rSessionHandle = create_rtsp_session(pipeline_handle.rDemoHandle, end_point.c_str(), pipe->m_output_type == po_rtsp_h264 ? 0 : 1);
                PrintRtsp((char *)end_point.c_str());
                pipeline_handle.rtsp_pipeid_sessiones[pipe->pipeid] = rSessionHandle;
                pipeline_handle.rtsp_end_point.push_back(end_point);
            }
            else
            {
                ALOGE("rtsp end point %s has been create", end_point.c_str());
            }
        }
    }

    break;
    case po_vo_sipeed_maix3_screen:
    {
        if (!pipeline_handle.b_maix3_init)
        {
            AX_MOD_INFO_S srcMod, dstMod;
            srcMod.enModId = AX_ID_IVPS;
            srcMod.s32GrpId = pipe->m_ivps_attr.n_ivps_grp;
            srcMod.s32ChnId = 0;
            dstMod.enModId = AX_ID_VO;
            dstMod.s32GrpId = 0;
            dstMod.s32ChnId = 0;
            AX_SYS_Link(&srcMod, &dstMod);

            int s32Ret = _create_vo("dsi0@480x854@60", pipe);
            if (AX_SUCCESS != s32Ret)
            {
                ALOGE("VoInit failed,s32Ret:0x%x\n", s32Ret);
                return -1;
            }
            pipeline_handle.b_maix3_init = true;
        }
        else
        {
            ALOGE("screen has been init");
        }
    }
    break;
    default:
        break;
    }
    return 0;
}

int destory_pipeline(pipeline_t *pipe)
{
    if (!pipe->enable)
    {
        return -1;
    }

    if (!contain(pipeline_handle.pipeid_pipe, pipe->pipeid))
    {
        return -1;
    }
    pipe->n_loog_exit = 1;
    usleep(200 * 1000);
    erase(pipeline_handle.pipeid_pipe, pipe->pipeid);

    switch (pipe->m_input_type)
    {
    case pi_user:
        break;
    case pi_vin:
    {
        AX_MOD_INFO_S srcMod, dstMod;
        srcMod.enModId = AX_ID_VIN;
        srcMod.s32GrpId = pipe->n_vin_pipe;
        srcMod.s32ChnId = pipe->n_vin_chn;

        dstMod.enModId = AX_ID_IVPS;
        dstMod.s32GrpId = pipe->m_ivps_attr.n_ivps_grp;
        dstMod.s32ChnId = 0;
        AX_SYS_UnLink(&srcMod, &dstMod);

        int s32Ret = _destore_ivps_grp(pipe);

        erase(pipeline_handle.ivps_grp, pipe->m_ivps_attr.n_ivps_grp);

        if (pipeline_handle.ivps_grp.size() == 0)
        {
            ALOGN("AX_IVPS_Deinit");
            AX_IVPS_Deinit();
        }
    }
    break;
    case pi_vdec:
    {
        AX_MOD_INFO_S srcMod, dstMod;
        srcMod.enModId = AX_ID_VDEC;
        srcMod.s32GrpId = pipe->n_vdec_grp;
        srcMod.s32ChnId = 0;

        dstMod.enModId = AX_ID_IVPS;
        dstMod.s32GrpId = pipe->m_ivps_attr.n_ivps_grp;
        dstMod.s32ChnId = 0;
        AX_SYS_UnLink(&srcMod, &dstMod);

        int s32Ret = _destore_vdec_grp(pipe);

        s32Ret = _destore_ivps_grp(pipe);

        erase(pipeline_handle.vdec_grp, pipe->n_vdec_grp);

        if (pipeline_handle.vdec_grp.size() == 0)
        {
            ALOGN("AX_VDEC_DeInit");
            AX_VDEC_DeInit();
        }

        erase(pipeline_handle.ivps_grp, pipe->m_ivps_attr.n_ivps_grp);

        if (pipeline_handle.ivps_grp.size() == 0)
        {
            ALOGN("AX_IVPS_Deinit");
            AX_IVPS_Deinit();
        }
    }
    break;
    default:
        break;
    }

    switch (pipe->m_output_type)
    {
    case po_venc_mjpg:
    case po_venc_h264:
    case po_venc_h265:
    case po_rtsp_h264:
    case po_rtsp_h265:
    {
        AX_MOD_INFO_S srcMod, dstMod;
        srcMod.enModId = AX_ID_IVPS;
        srcMod.s32GrpId = pipe->m_ivps_attr.n_ivps_grp;
        srcMod.s32ChnId = 0;

        dstMod.enModId = AX_ID_VENC;
        dstMod.s32GrpId = 0;
        dstMod.s32ChnId = pipe->m_venc_attr.n_venc_chn;
        AX_SYS_UnLink(&srcMod, &dstMod);

        int s32Ret = _destore_venc_grp(pipe);

        erase(pipeline_handle.venc_chn, pipe->m_venc_attr.n_venc_chn);

        if (pipeline_handle.venc_chn.size() == 0)
        {
            ALOGN("AX_VENC_Deinit");
            AX_VENC_Deinit();
        }

        if (pipe->m_output_type == po_rtsp_h264 || pipe->m_output_type == po_rtsp_h265)
        {
            std::string end_point = pipe->m_venc_attr.end_point;
            if (end_point.length())
            {
                if (end_point[0] != '/')
                {
                    end_point = "/" + end_point;
                }
            }

            rtsp_del_session(pipeline_handle.rtsp_pipeid_sessiones[pipe->pipeid]);
            erase(pipeline_handle.rtsp_pipeid_sessiones, pipe->pipeid);
            erase(pipeline_handle.rtsp_end_point, end_point);

            if (pipeline_handle.rtsp_pipeid_sessiones.size() == 0)
            {
                rtsp_del_demo(pipeline_handle.rDemoHandle);
                ALOGN("rtsp server release");
            }
        }
    }

    break;
    case po_vo_sipeed_maix3_screen:
    {
        AX_MOD_INFO_S srcMod, dstMod;
        srcMod.enModId = AX_ID_IVPS;
        srcMod.s32GrpId = pipe->m_ivps_attr.n_ivps_grp;
        srcMod.s32ChnId = 0;
        dstMod.enModId = AX_ID_VO;
        dstMod.s32GrpId = 0;
        dstMod.s32ChnId = 0;
        AX_SYS_UnLink(&srcMod, &dstMod);
        if (pipeline_handle.b_maix3_init)
        {
            _destory_vo();
            pipeline_handle.b_maix3_init = false;
        }
    }
    break;
    default:
        break;
    }
}

int user_input(pipeline_t *pipe, pipeline_buffer_t *buf)
{
    if (!contain(pipeline_handle.pipeid_pipe, pipe->pipeid))
    {
        ALOGE("pipe-%d haven`t create", pipe->pipeid);
        return -1;
    }

    switch (pipe->m_input_type)
    {
    case pi_user:
    {
        // static tjhandle tjDecInstance = nullptr;
        // if (!tjDecInstance)
        // {
        //     tjDecInstance = tjInitDecompress();
        // }
        // int miDecFlag = 0;
        // miDecFlag |= TJFLAG_FASTUPSAMPLE;
        // int miInSubsamp;
        // int miInColorspace;
        // auto miDecPixelFormat = TJPF::TJPF_BGR;
        // if (tjDecompressHeader3(tjDecInstance, (const unsigned char *)buf->p_vir, buf->n_size, &buf->n_width, &buf->n_height, &miInSubsamp, &miInColorspace) < 0)
        // {
        //     printf("reading JPEG header fail\n");
        //     return -1;
        // }
        // static AX_NPU_CV_Image image = {0}, yuv420 = {0};
        // static AX_U32 poolid = 0;
        // static bool init = false;
        // if (!init)
        // {
        //     init = true;
        //     yuv420.nWidth = yuv420.tStride.nW = image.nWidth = image.tStride.nW = buf->n_width;
        //     yuv420.nHeight = image.nHeight = buf->n_height;
        //     image.eDtype = AX_NPU_CV_FDT_RGB;
        //     yuv420.eDtype = AX_NPU_CV_FDT_NV12;
        //     image.nSize = image.nWidth * image.nHeight * 3;
        //     yuv420.nSize = image.nWidth * image.nHeight * 3 / 2;
        //     // AX_SYS_MemAlloc(&image.pPhy, (void **)&image.pVir, image.nSize, 0x100, (AX_S8 *)"SAMPLE-CV");
        //     // AX_SYS_MemAlloc(&yuv420.pPhy, (void **)&yuv420.pVir, yuv420.nSize, 0x100, (AX_S8 *)"SAMPLE-CV");

        //     AX_POOL_CONFIG_T stPoolCfg = {0};

        //     stPoolCfg.MetaSize = 512;
        //     stPoolCfg.BlkCnt = 10;
        //     stPoolCfg.BlkSize = yuv420.nSize;
        //     stPoolCfg.CacheMode = POOL_CACHE_MODE_NONCACHE;
        //     strcpy((char *)stPoolCfg.PartitionName, "ivps_send");

        //     poolid = AX_POOL_CreatePool(&stPoolCfg);

        //     if (poolid == AX_INVALID_POOLID)
        //     {
        //         SAMPLE_PRT("AX_POOL_CreatePool failed\n");
        //         return -1;
        //     }

        //     // SAMPLE_VO_CREATE_POOL(10, yuv420.nSize, 512, &poolid);
        // }
        // // 0x118380;
        // AX_BLK blkid = AX_POOL_GetBlock(poolid, yuv420.nSize, (AX_S8 *)"ivps_send");
        // yuv420.pPhy = AX_POOL_Handle2PhysAddr(blkid);
        // yuv420.pVir = (AX_U8 *)AX_POOL_GetBlockVirAddr(blkid);

        // if (tjDecompressToYUV(tjDecInstance, (unsigned char *)buf->p_vir, buf->n_size, (unsigned char *)yuv420.pVir, miDecFlag) < 0)
        // {
        //     printf("decompressing JPEG image fail\n");
        //     return -1;
        // }
        // // int ret = AX_NPU_CV_CSC(AX_NPU_MODEL_TYPE_1_1_1, &image, &yuv420);
        // // if (ret != 0)
        // // {
        // //     printf("AX_NPU_CV_CSC fail 0x%x\n", ret);
        // //     // return -1;
        // // }
        // AX_VIDEO_FRAME_S ivpsframe = {0};
        // memset(&ivpsframe, 0, sizeof(AX_VIDEO_FRAME_S));
        // ivpsframe.enImgFormat = AX_YUV420_SEMIPLANAR;
        // ivpsframe.u32Width = yuv420.nWidth;
        // ivpsframe.u32Height = yuv420.nHeight;
        // ivpsframe.u64PhyAddr[0] = yuv420.pPhy;
        // ivpsframe.u64PhyAddr[1] = yuv420.pPhy + ivpsframe.u32Width * ivpsframe.u32Height;
        // ivpsframe.u64VirAddr[0] = (AX_U64)yuv420.pVir;
        // ivpsframe.u64VirAddr[1] = (AX_U64)yuv420.pVir + ivpsframe.u32Width * ivpsframe.u32Height;
        // ivpsframe.u32PicStride[0] = ivpsframe.u32PicStride[1] = ivpsframe.u32Width;
        // ivpsframe.u32FrameSize = yuv420.nSize;
        // ivpsframe.u32BlkId[0] = blkid;
        // int ret = AX_IVPS_SendFrame(pipe->n_vdec_grp, &ivpsframe, 200);
        // if (ret != 0)
        // {
        //     printf("AX_IVPS_SendFrame fail 0x%x\n", ret);
        //     return -1;
        // }
        // AX_POOL_ReleaseBlock(blkid);
    }
    break;
    case pi_vdec:
    {
        AX_VDEC_STREAM_S stream = {0};
        int unsigned long long pts = 0;
        stream.u64PTS = pts++;
        stream.u32Len = buf->n_size;
        stream.pu8Addr = (unsigned char *)buf->p_vir;
        stream.bEndOfFrame = stream.bEndOfStream = stream.bDisplay = AX_FALSE;
        int ret = AX_VDEC_SendStream(pipe->n_vdec_grp, &stream, 0);
        if (ret != 0)
        {
            ALOGE("AX_VDEC_SendStream 0x%x", ret);
        }
        else
        {
            ALOGI("AX_VDEC_SendStream success", ret);
        }
    }

    break;
    default:
        break;
    }

    return 0;
}
# 如何调整图像方向？

比如 [examples/sample_vin_ivps_joint_venc_rtsp_vo/pipe/pipeline_ivps.c](../examples/sample_vin_ivps_joint_venc_rtsp_vo/pipe/pipeline_ivps.c) SampleIvpsInit 函数中，大约 253 行：
```
...
stPipelineAttr.tFilter[nChn + 1][1].bEnable = AX_TRUE;
stPipelineAttr.tFilter[nChn + 1][1].tFRC.nSrcFrameRate = 60;
stPipelineAttr.tFilter[nChn + 1][1].tFRC.nDstFrameRate = 60;
stPipelineAttr.tFilter[nChn + 1][1].nDstPicOffsetX0 = 0;
stPipelineAttr.tFilter[nChn + 1][1].nDstPicOffsetY0 = 0;
stPipelineAttr.tFilter[nChn + 1][1].nDstPicWidth = SAMPLE_MINOR_STREAM_HEIGHT;
stPipelineAttr.tFilter[nChn + 1][1].nDstPicHeight = SAMPLE_MINOR_STREAM_WIDTH;
stPipelineAttr.tFilter[nChn + 1][1].nDstPicStride = ALIGN_UP(stPipelineAttr.tFilter[nChn + 1][0].nDstPicWidth, 64);
stPipelineAttr.tFilter[nChn + 1][1].nDstFrameWidth = SAMPLE_MINOR_STREAM_HEIGHT;
stPipelineAttr.tFilter[nChn + 1][1].nDstFrameHeight = SAMPLE_MINOR_STREAM_WIDTH;
stPipelineAttr.tFilter[nChn + 1][1].eDstPicFormat = AX_YUV420_SEMIPLANAR;
stPipelineAttr.tFilter[nChn + 1][1].eEngine = AX_IVPS_ENGINE_TDP;
stPipelineAttr.tFilter[nChn + 1][1].tTdpCfg.eRotation = AX_IVPS_ROTATION_90;
stPipelineAttr.nOutFifoDepth[nChn] = 0;
...
```
其中 ```stPipelineAttr.tFilter[nChn + 1][1].tTdpCfg.eRotation = AX_IVPS_ROTATION_90;``` 表示 旋转90度，因为 AXera-PI 的屏幕是纵向的，而图像是横向的。

 ```stPipelineAttr.tFilter[nChn + 1][1].tTdpCfg``` 中还有其他可供设置的参数，如上下、左右镜像操作等，用户可以根据需求进行设置，结构体具体定义如下：
 ```
 /*
 * AX_IVPS_TDP_CFG_S
 * This configuration is specific to TDP engine.
 * This engine can support many functions,
 * such as mirror,flip,rotation,scale,mosaic,osd and so on.
 * For AX620, if in eCompressMode, stride and width should be 64 pixels aligned.
 * If NOT in eCompressMode, stride and width should be 32 pixels aligned.
 * 16 alignment is also supported, but the bandwidth will decrease.
 */
typedef struct axIVPS_TDP_CFG_S
{
    AX_BOOL bCrop;
    AX_IVPS_RECT_S tCropRect;
    AX_BOOL bMirror;
    AX_BOOL bFlip;
    AX_IVPS_ROTATION_E eRotation;
    AX_IVPS_ASPECT_RATIO_S tAspectRatio;
    AX_BOOL bDither;
    AX_COMPRESS_MODE_E eCompressMode;
    AX_BOOL bInplace;
} AX_IVPS_TDP_CFG_S;
 ```


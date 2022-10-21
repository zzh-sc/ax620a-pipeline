#ifndef _SAMPLE_RUN_JOINT_H_
#define _SAMPLE_RUN_JOINT_H_

#define SAMPLE_MAX_BBOX_COUNT 16

typedef struct _sample_run_joint_object
{
    float x, y, w, h;
    int label;
    float prob;
    char objname[16];
} sample_run_joint_object;

typedef struct _sample_run_joint_results
{
    int size;
    sample_run_joint_object objects[SAMPLE_MAX_BBOX_COUNT];
} sample_run_joint_results;

#ifdef __cplusplus
extern "C"
{
#endif
    int sample_run_joint_init(char *model_file, void **handle, int *algo_width, int *algo_height);
    // bbox 将映射到 src_width/src_height 上，以便 osd 绘制
    int sample_run_joint_inference(void *handle, const void *pstFrame, sample_run_joint_results *pResults, int src_width, int src_height);
    int sample_run_joint_release(void *handle);
#ifdef __cplusplus
}
#endif

#endif
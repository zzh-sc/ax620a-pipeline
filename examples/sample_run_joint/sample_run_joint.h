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
    int sample_run_joint_inference(void *handle, const void *pstFrame, int src_width, int src_height, sample_run_joint_results *pResults);
    int sample_run_joint_release(void *handle);
#ifdef __cplusplus
}
#endif

#endif
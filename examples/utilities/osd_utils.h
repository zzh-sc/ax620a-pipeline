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

#ifndef _OSD_UTILS_H_
#define _OSD_UTILS_H_
typedef struct _osd_utils_img
{
    unsigned char *data;
    int width, height, channel;
} osd_utils_img;

#ifdef __cplusplus
extern "C"
{
#endif
    void genImg(int charlen, float fontscale, osd_utils_img *out);
    int putText(char *text, float fontscale, osd_utils_img *base, osd_utils_img *out);
    void releaseImg(osd_utils_img *img);
    void drawObjs(osd_utils_img *out, float fontscale, sample_run_joint_results *results);
#ifdef __cplusplus
}
#endif
#endif
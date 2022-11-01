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

#include <vector>
#include <string.h>

#include "sample_run_joint.h"
#include "detection.hpp"

#include "joint.h"

float PROB_THRESHOLD = 0.4f;
float NMS_THRESHOLD = 0.45f;
int YOLOV5_CLASS_NUM = 80;

const float ANCHORS[18] = {10, 13, 16, 30, 33, 23, 30, 61, 62, 45, 59, 119, 116, 90, 156, 198, 373, 326};

const char *CLASS_NAMES[] = {
    "person", "bicycle", "car", "motorcycle", "airplane", "bus", "train", "truck", "boat", "traffic light",
    "fire hydrant", "stop sign", "parking meter", "bench", "bird", "cat", "dog", "horse", "sheep", "cow",
    "elephant", "bear", "zebra", "giraffe", "backpack", "umbrella", "handbag", "tie", "suitcase", "frisbee",
    "skis", "snowboard", "sports ball", "kite", "baseball bat", "baseball glove", "skateboard", "surfboard",
    "tennis racket", "bottle", "wine glass", "cup", "fork", "knife", "spoon", "bowl", "banana", "apple",
    "sandwich", "orange", "broccoli", "carrot", "hot dog", "pizza", "donut", "cake", "chair", "couch",
    "potted plant", "bed", "dining table", "toilet", "tv", "laptop", "mouse", "remote", "keyboard", "cell phone",
    "microwave", "oven", "toaster", "sink", "refrigerator", "book", "clock", "vase", "scissors", "teddy bear",
    "hair drier", "toothbrush"};

void sample_run_joint_post_process(AX_U32 nOutputSize, AX_JOINT_IOMETA_T *pOutputsInfo, AX_JOINT_IO_BUFFER_T *pOutputs, sample_run_joint_results *pResults,
                                   int SAMPLE_ALGO_WIDTH, int SAMPLE_ALGO_HEIGHT, int SAMPLE_MAJOR_STREAM_WIDTH, int SAMPLE_MAJOR_STREAM_HEIGHT)
{
    std::vector<detection::Object> proposals;
    std::vector<detection::Object> objects;

    float prob_threshold_unsigmoid = -1.0f * (float)std::log((1.0f / PROB_THRESHOLD) - 1.0f);
    for (uint32_t i = 0; i < nOutputSize; ++i)
    {
        auto &output = pOutputsInfo[i];
        auto &info = pOutputs[i];

        auto ptr = (float *)info.pVirAddr;

        int32_t stride = (1 << i) * 8;
        generate_proposals_yolov5(stride, ptr, PROB_THRESHOLD, proposals, SAMPLE_ALGO_WIDTH, SAMPLE_ALGO_HEIGHT, ANCHORS, prob_threshold_unsigmoid, YOLOV5_CLASS_NUM);
    }

    detection::get_out_bbox(proposals, objects, NMS_THRESHOLD, SAMPLE_ALGO_HEIGHT, SAMPLE_ALGO_WIDTH, SAMPLE_MAJOR_STREAM_HEIGHT, SAMPLE_MAJOR_STREAM_WIDTH);
    pResults->size = MIN(objects.size(), SAMPLE_MAX_BBOX_COUNT);
    for (size_t i = 0; i < pResults->size; i++)
    {
        const detection::Object &obj = objects[i];
        pResults->objects[i].x = obj.rect.x;
        pResults->objects[i].y = obj.rect.y;
        pResults->objects[i].w = obj.rect.width;
        pResults->objects[i].h = obj.rect.height;
        pResults->objects[i].label = obj.label;
        pResults->objects[i].prob = obj.prob;

        strcpy(pResults->objects[i].objname, CLASS_NAMES[obj.label]);
    }
}
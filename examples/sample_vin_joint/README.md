## 简介
  主要展示了如何 VIN 取图，然后通过 ISP 获得 NV12 的图像，进行 NPU-Yolov5s 检测。

## 流程图
![](../../docs/sample_vin_joint.png)

## 快速体验
```
# wget https://github.com/AXERA-TECH/ax-models/raw/main/ax620/yolov5s_sub_nv12_11.joint
# ./sample_vin_joint -m ./yolov5s_sub_nv12_11.joint -c 0
```
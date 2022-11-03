# 如何部署自己的其他模型

### 阅读文档

仔细阅读 [AXera Pulsar 工具链指导手册](https://pulsar-docs.readthedocs.io/zh_CN/latest/index.html)，学习如何将自定义的 onnx 模型，转换成 AX620 中所用的 Joint 模型。

### 插入后处理代码
  
ax-pipeline 的模型推理基本都是比较标准的操作，前处理是不需要用户在代码中配置的，所以用户基本只需要关注后处理部分即可，并将目标检测的结果赋值到目标检测的结构体里，ax-pipeline 会自动绘制到输出的图像流中。

ax-pipeline 定义了一了一个后处理的函数 ```sample_run_joint_post_process``` ，位于 [examples/sample_run_joint/sample_run_joint_post_process.cpp](../examples/sample_run_joint/sample_run_joint_post_process.cpp)

```
/// @brief 模型后处理函数
/// @param nOutputSize 输出的节点数
/// @param pOutputsInfo 输出的节点对应的信息，包含维度信息、节点名称等
/// @param pOutputs 输出的节点的数据指针，包含物理地址、虚拟地址等
/// @param pResults 目标检测的结果信息
/// @param SAMPLE_ALGO_WIDTH 算法的输入宽
/// @param SAMPLE_ALGO_HEIGHT 算法的输入高
/// @param SAMPLE_MAJOR_STREAM_WIDTH 相机图像的宽
/// @param SAMPLE_MAJOR_STREAM_HEIGHT 相机图像的高
void sample_run_joint_post_process(AX_U32 nOutputSize, AX_JOINT_IOMETA_T *pOutputsInfo, AX_JOINT_IO_BUFFER_T *pOutputs, sample_run_joint_results *pResults,
                                   int SAMPLE_ALGO_WIDTH, int SAMPLE_ALGO_HEIGHT, int SAMPLE_MAJOR_STREAM_WIDTH, int SAMPLE_MAJOR_STREAM_HEIGHT);
```

用户可以将 ax-pipeline 自带的后处理代码进行注释，然后定义自己的后处理的函数，完成自己的模型的后处理。

一些常用模型的后处理代码，可以参考 [ax-samples](https://github.com/AXERA-TECH/ax-samples)
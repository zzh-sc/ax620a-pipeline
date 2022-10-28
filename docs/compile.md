# 源码编译（Linux）

ax-pipeline 的源码编译目前有两种实现路径：

- 基于 AX-Pi 的本地编译，因为 AX-Pi 上集成的完成了软件开发环境，操作简单；
- 嵌入式 Linux 交叉编译。

## 本地编译

### 硬件需求

- AX-Pi（基于 AX620A，面向社区开发者的高性价比开发板）

### 编译环境
- cmake 版本大于等于 3.13
- AX620A/U 配套的交叉编译工具链 `arm-linux-gnueabihf-gxx` 已添加到环境变量中

### 3rdparty 准备

- 下载预编译好的 OpenCV 库文件 [[AX620A/U 匹配](https://github.com/AXERA-TECH/ax-samples/releases/download/v0.1/opencv-arm-linux-gnueabihf-gcc-7.5.0.zip)]；
- 在 ax-pipeline 创建 3rdparty 文件，并将下载好的 OpenCV 库文件压缩包解压到该文件夹中。

### 安装交叉编译工具链

- Arm32 Linux 交叉编译工具链[获取地址](http://releases.linaro.org/components/toolchain/binaries/7.5-2019.12/arm-linux-gnueabihf/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf.tar.xz)



### 编译过程

git clone 下载源码，进入 ax-pipeline 根目录，创建 cmake 编译任务：

```bash
$ git clone --recursive https://github.com/AXERA-TECH/ax-pipeline.git
$ cd ax-pipeline
$ mkdir 3rdparty
$ cd 3rdparty
$ wget https://github.com/AXERA-TECH/ax-samples/releases/download/v0.1/opencv-arm-linux-gnueabihf-gcc-7.5.0.zip
$ unzip opencv-arm-linux-gnueabihf-gcc-7.5.0.zip
$ cd ..
$ mkdir build
$ cd build
$ cmake -DCMAKE_TOOLCHAIN_FILE=../toolchains/arm-linux-gnueabihf.toolchain.cmake -DCMAKE_INSTALL_PREFIX=install ..
$ make install
```

编译完成后，生成的可执行示例存放在 `ax-pipeline/build/install/bin/` 路径下：

```bash
ax-pipeline/build$ tree install
install
└── bin
    ├── sample_vin_ivps_joint_venc_rtsp
    ├── sample_vin_ivps_joint_venc_rtsp_vo
    └── sample_vin_joint
```

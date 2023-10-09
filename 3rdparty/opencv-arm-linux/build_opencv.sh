cmake -DCMAKE_TOOLCHAIN_FILE=../toolchains/arm-linux-gnueabihf.toolchain.cmake \
    -DBUILD_DOCS:BOOL=OFF \
    -DBUILD_SHARED_LIBS:BOOL=OFF \
    -DBUILD_FAT_JAVA_LIB:BOOL=OFF \
    -DBUILD_TESTS:BOOL=OFF \
    -DBUILD_TIFF:BOOL=ON \
    -DBUILD_JASPER:BOOL=ON \
    -DBUILD_JPEG:BOOL=ON \
    -DBUILD_PNG:BOOL=ON \
    -DBUILD_ZLIB:BOOL=ON \
    -DBUILD_PROTOBUF:BOOL=OFF \
    -DBUILD_OPENEXR:BOOL=OFF \
    -DBUILD_opencv_apps:BOOL=OFF \
    -DBUILD_opencv_calib3d:BOOL=OFF \
    -DBUILD_opencv_contrib:BOOL=OFF \
    -DBUILD_opencv_features2d:BOOL=OFF \
    -DBUILD_opencv_flann:BOOL=OFF \
    -DBUILD_opencv_gapi:BOOL=OFF \
    -DBUILD_opencv_dnn:BOOL=OFF \
    -DBUILD_opencv_gpu:BOOL=OFF \
    -DBUILD_opencv_java:BOOL=OFF \
    -DBUILD_opencv_legacy:BOOL=OFF \
    -DBUILD_opencv_ml:BOOL=OFF \
    -DBUILD_opencv_nonfree:BOOL=OFF \
    -DBUILD_opencv_objdetect:BOOL=OFF \
    -DBUILD_opencv_ocl:BOOL=OFF \
    -DBUILD_opencv_photo:BOOL=OFF \
    -DBUILD_opencv_python:BOOL=OFF \
    -DBUILD_opencv_stitching:BOOL=OFF \
    -DBUILD_opencv_superres:BOOL=OFF \
    -DBUILD_opencv_ts:BOOL=OFF \
    -DBUILD_opencv_video:BOOL=OFF \
    -DBUILD_opencv_videostab:BOOL=OFF \
    -DBUILD_opencv_world:BOOL=OFF \
    -DBUILD_opencv_lengcy:BOOL=OFF \
    -DBUILD_opencv_lengcy:BOOL=OFF \
    -DWITH_1394:BOOL=OFF \
    -DWITH_EIGEN:BOOL=OFF \
    -DWITH_FFMPEG:BOOL=OFF \
    -DWITH_GIGEAPI:BOOL=OFF \
    -DWITH_GSTREAMER:BOOL=OFF \
    -DWITH_GTK:BOOL=OFF \
    -DWITH_PVAPI:BOOL=OFF \
    -DWITH_V4L:BOOL=OFF \
    -DWITH_LIBV4L:BOOL=OFF \
    -DWITH_CUDA:BOOL=OFF \
    -DWITH_CUFFT:BOOL=OFF \
    -DWITH_OPENCL:BOOL=OFF \
    -DWITH_OPENCLAMDBLAS:BOOL=OFF \
    -DWITH_OPENCLAMDFFT:BOOL=OFF \
    -DWITH_PROTOBUF:BOOL=OFF \
    -DWITH_QUIRC:BOOL=OFF \
    -DWITH_ADE:BOOL=OFF \
    -DCMAKE_BUILD_TYPE=RELEASE \
    -DCMAKE_INSTALL_PREFIX=./install \
    ..
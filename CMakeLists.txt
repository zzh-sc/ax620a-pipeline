project(ax_pipeline)
# check CMake version
cmake_minimum_required (VERSION 3.13 FATAL_ERROR)

add_subdirectory(examples/sample_vin_ivps_joint_venc_rtsp_vo)
add_subdirectory(examples/sample_vin_ivps_joint_venc_rtsp)
add_subdirectory(examples/sample_vin_joint)
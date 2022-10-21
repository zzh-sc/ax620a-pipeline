file(GLOB SRC_LIST "*.c")
file(GLOB SRC_LIST_COMMON "${BSP_MSP_DIR}/../sample/common/*.c" "${BSP_MSP_DIR}/../sample/common/common_codec/*.c")
file(GLOB SRC_LIST_SAMPLE_RUN_JOINT "../sample_run_joint/*.cpp")

add_executable(sample_vin_joint 
                ${SRC_LIST}
                ${SRC_LIST_COMMON}
                ${SRC_LIST_SAMPLE_RUN_JOINT}
                )

# opencv
set (OpenCV_DIR ${CMAKE_SOURCE_DIR}/3rdparty/opencv-arm-linux/lib/cmake/opencv4)
find_package(OpenCV REQUIRED)
target_include_directories (sample_vin_joint PRIVATE ${OpenCV_INCLUDE_DIRS})
target_link_libraries(sample_vin_joint PRIVATE ${OpenCV_LIBS})


target_include_directories (sample_vin_joint PRIVATE ${BSP_MSP_DIR}/../sample/common)
target_include_directories (sample_vin_joint PRIVATE ${BSP_MSP_DIR}/include)
target_include_directories (sample_vin_joint PRIVATE ${BSP_MSP_DIR}/include/npu_cv_kit)
target_link_directories (sample_vin_joint PRIVATE ${BSP_MSP_DIR}/lib)

target_link_libraries (sample_vin_joint PRIVATE pthread dl) # ax620a use this
# target_link_libraries (sample_vin_joint PRIVATE pthread dl stdc++fs) # ax620u use this
target_link_libraries (sample_vin_joint PRIVATE ax_run_joint ax_interpreter_external ax_interpreter ax_sys axsyslog stdc++fs)
target_link_libraries (sample_vin_joint PRIVATE ax_venc ax_ivps ax_npu_cv_kit ax_3a ax_proton ax_mipi gomp)
target_link_libraries (sample_vin_joint PRIVATE sns_os04a10 sns_os04a10_master sns_os04a10_slave sns_gc4653)

install (TARGETS sample_vin_joint DESTINATION bin)
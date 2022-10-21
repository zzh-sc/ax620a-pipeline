# disable inplace builds to prevent source tree corruption.
if (" ${CMAKE_SOURCE_DIR}" STREQUAL " ${CMAKE_BINARY_DIR}")
    message (FATAL_ERROR "FATAL: Building inplace are not allowed. You should create a separate directory for Building.")
endif ()

# set cmake_install_prefix path
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
    set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/install" CACHE PATH "Installation Directory")
endif()
message(STATUS "CMAKE_INSTALL_PREFIX = ${CMAKE_INSTALL_PREFIX}")


# enable the languages which in use
enable_language (C CXX)

# check toolchain about
if(CMAKE_TOOLCHAIN_FILE)
    set(LIBRARY_OUTPUT_PATH_ROOT ${CMAKE_BINARY_DIR} CACHE PATH "root for library output, set this to change where android libs are compiled to")
    # get absolute path, but get_filename_component ABSOLUTE only refer with source dir, so find_file here :(
    get_filename_component(CMAKE_TOOLCHAIN_FILE_NAME ${CMAKE_TOOLCHAIN_FILE} NAME)
    find_file(CMAKE_TOOLCHAIN_FILE ${CMAKE_TOOLCHAIN_FILE_NAME} PATHS ${CMAKE_SOURCE_DIR} NO_DEFAULT_PATH)
    message(STATUS "CMAKE_TOOLCHAIN_FILE = ${CMAKE_TOOLCHAIN_FILE}")
endif()

# check if building type is not set
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build" FORCE)
endif()

# bsp
if (NOT BSP_MSP_DIR)
    set (BSP_MSP_DIR ${CMAKE_SOURCE_DIR}/axpi_bsp_sdk/msp/out)
endif ()
message(STATUS "BSP_MSP_DIR = ${BSP_MSP_DIR}")


file(GLOB SRC_LIST "*.c" "pipe/*.c" "../utilities/*.cpp")
file(GLOB SRC_LIST_RTSP "../rtsp/src/*.cpp")
file(GLOB SRC_LIST_COMMON "${BSP_MSP_DIR}/../sample/common/*.c" "${BSP_MSP_DIR}/../sample/common/common_codec/*.c" "${BSP_MSP_DIR}/../sample/common/vo/*.c")
file(GLOB SRC_LIST_SAMPLE_RUN_JOINT "../sample_run_joint/*.cpp")

add_executable(sample_vin_ivps_joint_venc_rtsp_vo 
                ${SRC_LIST}
                ${SRC_LIST_RTSP}
                ${SRC_LIST_COMMON}
                ${SRC_LIST_SAMPLE_RUN_JOINT}
                )

# opencv
set (OpenCV_DIR ${CMAKE_SOURCE_DIR}/3rdparty/opencv-arm-linux/lib/cmake/opencv4)
find_package(OpenCV REQUIRED)
target_include_directories (sample_vin_ivps_joint_venc_rtsp_vo PRIVATE ${OpenCV_INCLUDE_DIRS})
target_link_libraries(sample_vin_ivps_joint_venc_rtsp_vo PRIVATE ${OpenCV_LIBS})


# drm
target_link_directories (sample_vin_ivps_joint_venc_rtsp_vo PRIVATE ${BSP_MSP_DIR}/../../third-party/drm/lib)
target_link_libraries (sample_vin_ivps_joint_venc_rtsp_vo PRIVATE drm)

target_include_directories (sample_vin_ivps_joint_venc_rtsp_vo PRIVATE ${BSP_MSP_DIR}/../sample/common)
target_include_directories (sample_vin_ivps_joint_venc_rtsp_vo PRIVATE ${BSP_MSP_DIR}/include)
target_include_directories (sample_vin_ivps_joint_venc_rtsp_vo PRIVATE ${BSP_MSP_DIR}/include/npu_cv_kit)
target_link_directories (sample_vin_ivps_joint_venc_rtsp_vo PRIVATE ${BSP_MSP_DIR}/lib)

target_link_libraries (sample_vin_ivps_joint_venc_rtsp_vo PRIVATE pthread dl) # ax620a use this
# target_link_libraries (sample_vin_ivps_joint_venc_rtsp_vo PRIVATE pthread dl stdc++fs) # ax620u use this
target_link_libraries (sample_vin_ivps_joint_venc_rtsp_vo PRIVATE ax_run_joint ax_interpreter_external ax_interpreter ax_sys axsyslog stdc++fs)
target_link_libraries (sample_vin_ivps_joint_venc_rtsp_vo PRIVATE ax_venc ax_ivps ax_npu_cv_kit ax_3a ax_proton ax_mipi gomp ax_vo)
target_link_libraries (sample_vin_ivps_joint_venc_rtsp_vo PRIVATE sns_os04a10 sns_os04a10_master sns_os04a10_slave sns_gc4653)

# openssl
target_include_directories (sample_vin_ivps_joint_venc_rtsp_vo PRIVATE ${BSP_MSP_DIR}/../../third-party/openssl/include)
target_link_directories (sample_vin_ivps_joint_venc_rtsp_vo PRIVATE ${BSP_MSP_DIR}/../../third-party/openssl/lib)
target_link_libraries (sample_vin_ivps_joint_venc_rtsp_vo PRIVATE ssl crypto)

# rtsp
target_include_directories (sample_vin_ivps_joint_venc_rtsp_vo PRIVATE ../rtsp/inc)
target_include_directories (sample_vin_ivps_joint_venc_rtsp_vo PRIVATE ../rtsp/inc/groupsock)
target_include_directories (sample_vin_ivps_joint_venc_rtsp_vo PRIVATE ../rtsp/inc/liveMedia)
target_include_directories (sample_vin_ivps_joint_venc_rtsp_vo PRIVATE ../rtsp/inc/UsageEnvironment)
target_include_directories (sample_vin_ivps_joint_venc_rtsp_vo PRIVATE ../rtsp/inc/BasicUsageEnvironment)
target_link_directories (sample_vin_ivps_joint_venc_rtsp_vo PRIVATE ../rtsp/lib)
target_link_libraries (sample_vin_ivps_joint_venc_rtsp_vo PRIVATE liveMedia groupsock BasicUsageEnvironment UsageEnvironment)


install (TARGETS sample_vin_ivps_joint_venc_rtsp_vo DESTINATION bin)
# Install script for directory: /home/zzh/Desktop/ax-pipeline

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/zzh/Desktop/ax-pipeline/build/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "TRUE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin/config" TYPE FILE FILES
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/ax_bvc_det.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/ax_person_det.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/ax_pose.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/ax_pose_yolov5s.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/ax_pose_yolov8.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/crowdcount.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/hand_pose.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/hand_pose_yolov7_palm.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/hrnet_animal_pose.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/hrnet_pose.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/hrnet_pose_ax_det.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/hrnet_pose_yolov8.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/license_plate_recognition.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/nanodet.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/palm_hand_detection.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/pp_human_seg.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/scrfd.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/yolo_fastbody.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/yolopv2.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/yolov5_seg.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/yolov5s.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/yolov5s_face.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/yolov5s_face_recognition.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/yolov5s_license_plate.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/yolov6.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/yolov7.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/yolov7_face.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/yolov7_palm_hand.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/yolov8.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/yolov8_pose.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/yolov8_seg.json"
    "/home/zzh/Desktop/ax-pipeline/examples/libaxdl/config/ax620/yolox.json"
    )
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/zzh/Desktop/ax-pipeline/build/third-party/RTSP/cmake_install.cmake")
  include("/home/zzh/Desktop/ax-pipeline/build/third-party/RtspServer/cmake_install.cmake")
  include("/home/zzh/Desktop/ax-pipeline/build/third-party/ByteTrack/cmake_install.cmake")
  include("/home/zzh/Desktop/ax-pipeline/build/third-party/mp4demux/cmake_install.cmake")
  include("/home/zzh/Desktop/ax-pipeline/build/examples/common/common_pipeline/cmake_install.cmake")
  include("/home/zzh/Desktop/ax-pipeline/build/examples/libaxdl/cmake_install.cmake")
  include("/home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp_vo/cmake_install.cmake")
  include("/home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp/cmake_install.cmake")
  include("/home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_vo/cmake_install.cmake")
  include("/home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_vo_h265/cmake_install.cmake")
  include("/home/zzh/Desktop/ax-pipeline/build/examples/sample_v4l2_ivps_npu_vo/cmake_install.cmake")
  include("/home/zzh/Desktop/ax-pipeline/build/examples/sample_v4l2_user_ivps_npu_vo/cmake_install.cmake")
  include("/home/zzh/Desktop/ax-pipeline/build/examples/sample_demux_ivps_npu_vo/cmake_install.cmake")
  include("/home/zzh/Desktop/ax-pipeline/build/examples/sample_demux_ivps_npu_rtsp/cmake_install.cmake")
  include("/home/zzh/Desktop/ax-pipeline/build/examples/sample_demux_ivps_npu_rtsp_vo/cmake_install.cmake")
  include("/home/zzh/Desktop/ax-pipeline/build/examples/sample_multi_demux_ivps_npu_multi_rtsp/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/zzh/Desktop/ax-pipeline/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")

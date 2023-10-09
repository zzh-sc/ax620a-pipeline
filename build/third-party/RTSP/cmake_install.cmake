# Install script for directory: /home/zzh/Desktop/ax-pipeline/third-party/RTSP

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/zzh/Desktop/ax-pipeline/build/third-party/RTSP/librtspclisvr.a")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/rtspclisvr" TYPE FILE FILES
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/AC3RTPSource.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/Base64.hh"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/BasicHashTable.hh"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/BitVector.hh"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/ClientSocket.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/DigestAuthentication.hh"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/Event.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/H264RTPSource.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/H265RTPSource.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/HashTable.hh"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/JPEGRTPSource.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/LiveServerMediaSession.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/MPEG4ESRTPSource.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/MPEG4GenericRTPSource.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/MediaSession.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/Mutex.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/MyList.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/MySemaphore.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/MySock.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/NetAddress.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/NetCommon.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/OnDemandServerMediaSession.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/OutPacketBuffer.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/RTCP.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/RTCPInstance.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/RTPPacketBuffer.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/RTPSource.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/RTSPClient.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/RTSPCommon.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/RTSPCommonEnv.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/RTSPServer.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/ServerMediaSession.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/SockCommon.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/TaskScheduler.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/Thread.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/our_md5.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/rtcp_from_spec.h"
    "/home/zzh/Desktop/ax-pipeline/third-party/RTSP/include/util.h"
    )
endif()


# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.15

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /opt/cmake/bin/cmake

# The command to remove a file.
RM = /opt/cmake/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/zzh/Desktop/ax-pipeline

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/zzh/Desktop/ax-pipeline/build

# Include any dependencies generated for this target.
include examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/depend.make

# Include the progress variables for this target.
include examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/progress.make

# Include the compile flags for this target's objects.
include examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/flags.make

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/utilities/net_utils.c.o: examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/flags.make
examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/utilities/net_utils.c.o: ../examples/utilities/net_utils.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/utilities/net_utils.c.o"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/utilities/net_utils.c.o   -c /home/zzh/Desktop/ax-pipeline/examples/utilities/net_utils.c

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/utilities/net_utils.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/utilities/net_utils.c.i"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/zzh/Desktop/ax-pipeline/examples/utilities/net_utils.c > CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/utilities/net_utils.c.i

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/utilities/net_utils.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/utilities/net_utils.c.s"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/zzh/Desktop/ax-pipeline/examples/utilities/net_utils.c -o CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/utilities/net_utils.c.s

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/sample_vin_ivps_npu_venc_rtsp.cpp.o: examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/flags.make
examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/sample_vin_ivps_npu_venc_rtsp.cpp.o: ../examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/sample_vin_ivps_npu_venc_rtsp.cpp.o"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/sample_vin_ivps_npu_venc_rtsp.cpp.o -c /home/zzh/Desktop/ax-pipeline/examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp.cpp

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/sample_vin_ivps_npu_venc_rtsp.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/sample_vin_ivps_npu_venc_rtsp.cpp.i"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/zzh/Desktop/ax-pipeline/examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp.cpp > CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/sample_vin_ivps_npu_venc_rtsp.cpp.i

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/sample_vin_ivps_npu_venc_rtsp.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/sample_vin_ivps_npu_venc_rtsp.cpp.s"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/zzh/Desktop/ax-pipeline/examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp.cpp -o CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/sample_vin_ivps_npu_venc_rtsp.cpp.s

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_cam.c.o: examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/flags.make
examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_cam.c.o: ../axpi_bsp_sdk/msp/sample/common/common_cam.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_cam.c.o"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_cam.c.o   -c /home/zzh/Desktop/ax-pipeline/axpi_bsp_sdk/msp/sample/common/common_cam.c

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_cam.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_cam.c.i"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/zzh/Desktop/ax-pipeline/axpi_bsp_sdk/msp/sample/common/common_cam.c > CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_cam.c.i

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_cam.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_cam.c.s"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/zzh/Desktop/ax-pipeline/axpi_bsp_sdk/msp/sample/common/common_cam.c -o CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_cam.c.s

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_arg_parse.c.o: examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/flags.make
examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_arg_parse.c.o: ../axpi_bsp_sdk/msp/sample/common/common_codec/common_arg_parse.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_arg_parse.c.o"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_arg_parse.c.o   -c /home/zzh/Desktop/ax-pipeline/axpi_bsp_sdk/msp/sample/common/common_codec/common_arg_parse.c

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_arg_parse.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_arg_parse.c.i"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/zzh/Desktop/ax-pipeline/axpi_bsp_sdk/msp/sample/common/common_codec/common_arg_parse.c > CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_arg_parse.c.i

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_arg_parse.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_arg_parse.c.s"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/zzh/Desktop/ax-pipeline/axpi_bsp_sdk/msp/sample/common/common_codec/common_arg_parse.c -o CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_arg_parse.c.s

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_venc.c.o: examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/flags.make
examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_venc.c.o: ../axpi_bsp_sdk/msp/sample/common/common_codec/common_venc.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building C object examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_venc.c.o"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_venc.c.o   -c /home/zzh/Desktop/ax-pipeline/axpi_bsp_sdk/msp/sample/common/common_codec/common_venc.c

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_venc.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_venc.c.i"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/zzh/Desktop/ax-pipeline/axpi_bsp_sdk/msp/sample/common/common_codec/common_venc.c > CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_venc.c.i

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_venc.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_venc.c.s"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/zzh/Desktop/ax-pipeline/axpi_bsp_sdk/msp/sample/common/common_codec/common_venc.c -o CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_venc.c.s

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_sys.c.o: examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/flags.make
examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_sys.c.o: ../axpi_bsp_sdk/msp/sample/common/common_sys.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building C object examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_sys.c.o"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_sys.c.o   -c /home/zzh/Desktop/ax-pipeline/axpi_bsp_sdk/msp/sample/common/common_sys.c

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_sys.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_sys.c.i"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/zzh/Desktop/ax-pipeline/axpi_bsp_sdk/msp/sample/common/common_sys.c > CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_sys.c.i

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_sys.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_sys.c.s"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/zzh/Desktop/ax-pipeline/axpi_bsp_sdk/msp/sample/common/common_sys.c -o CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_sys.c.s

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_vin.c.o: examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/flags.make
examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_vin.c.o: ../axpi_bsp_sdk/msp/sample/common/common_vin.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building C object examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_vin.c.o"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_vin.c.o   -c /home/zzh/Desktop/ax-pipeline/axpi_bsp_sdk/msp/sample/common/common_vin.c

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_vin.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_vin.c.i"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/zzh/Desktop/ax-pipeline/axpi_bsp_sdk/msp/sample/common/common_vin.c > CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_vin.c.i

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_vin.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_vin.c.s"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/zzh/Desktop/ax-pipeline/axpi_bsp_sdk/msp/sample/common/common_vin.c -o CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_vin.c.s

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_comm_vo.c.o: examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/flags.make
examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_comm_vo.c.o: ../axpi_bsp_sdk/msp/sample/common/vo/sample_comm_vo.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Building C object examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_comm_vo.c.o"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_comm_vo.c.o   -c /home/zzh/Desktop/ax-pipeline/axpi_bsp_sdk/msp/sample/common/vo/sample_comm_vo.c

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_comm_vo.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_comm_vo.c.i"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/zzh/Desktop/ax-pipeline/axpi_bsp_sdk/msp/sample/common/vo/sample_comm_vo.c > CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_comm_vo.c.i

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_comm_vo.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_comm_vo.c.s"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/zzh/Desktop/ax-pipeline/axpi_bsp_sdk/msp/sample/common/vo/sample_comm_vo.c -o CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_comm_vo.c.s

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_vo_pattern.c.o: examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/flags.make
examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_vo_pattern.c.o: ../axpi_bsp_sdk/msp/sample/common/vo/sample_vo_pattern.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_9) "Building C object examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_vo_pattern.c.o"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_vo_pattern.c.o   -c /home/zzh/Desktop/ax-pipeline/axpi_bsp_sdk/msp/sample/common/vo/sample_vo_pattern.c

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_vo_pattern.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_vo_pattern.c.i"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/zzh/Desktop/ax-pipeline/axpi_bsp_sdk/msp/sample/common/vo/sample_vo_pattern.c > CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_vo_pattern.c.i

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_vo_pattern.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_vo_pattern.c.s"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/zzh/Desktop/ax-pipeline/axpi_bsp_sdk/msp/sample/common/vo/sample_vo_pattern.c -o CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_vo_pattern.c.s

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/common/common_func.c.o: examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/flags.make
examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/common/common_func.c.o: ../examples/common/common_func.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_10) "Building C object examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/common/common_func.c.o"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/common/common_func.c.o   -c /home/zzh/Desktop/ax-pipeline/examples/common/common_func.c

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/common/common_func.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/common/common_func.c.i"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/zzh/Desktop/ax-pipeline/examples/common/common_func.c > CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/common/common_func.c.i

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/common/common_func.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/common/common_func.c.s"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/zzh/Desktop/ax-pipeline/examples/common/common_func.c -o CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/common/common_func.c.s

# Object files for target sample_vin_ivps_npu_venc_rtsp
sample_vin_ivps_npu_venc_rtsp_OBJECTS = \
"CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/utilities/net_utils.c.o" \
"CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/sample_vin_ivps_npu_venc_rtsp.cpp.o" \
"CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_cam.c.o" \
"CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_arg_parse.c.o" \
"CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_venc.c.o" \
"CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_sys.c.o" \
"CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_vin.c.o" \
"CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_comm_vo.c.o" \
"CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_vo_pattern.c.o" \
"CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/common/common_func.c.o"

# External object files for target sample_vin_ivps_npu_venc_rtsp
sample_vin_ivps_npu_venc_rtsp_EXTERNAL_OBJECTS =

examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/utilities/net_utils.c.o
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/sample_vin_ivps_npu_venc_rtsp.cpp.o
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_cam.c.o
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_arg_parse.c.o
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_codec/common_venc.c.o
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_sys.c.o
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/common_vin.c.o
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_comm_vo.c.o
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/__/axpi_bsp_sdk/msp/sample/common/vo/sample_vo_pattern.c.o
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/__/common/common_func.c.o
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/build.make
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: ../3rdparty/opencv-arm-linux/lib/libopencv_core.a
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: ../3rdparty/opencv-arm-linux/lib/libopencv_highgui.a
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: ../3rdparty/opencv-arm-linux/lib/libopencv_imgcodecs.a
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: ../3rdparty/opencv-arm-linux/lib/libopencv_imgproc.a
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: ../3rdparty/opencv-arm-linux/lib/libopencv_videoio.a
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: examples/libaxdl/libaxdl.a
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: examples/common/common_pipeline/libcommon_pipeline.a
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: third-party/RtspServer/libRtspServer.a
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: third-party/ByteTrack/libByteTrack.a
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: ../3rdparty/opencv-arm-linux/lib/libopencv_imgcodecs.a
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: ../3rdparty/opencv-arm-linux/lib/opencv4/3rdparty/liblibjpeg-turbo.a
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: ../3rdparty/opencv-arm-linux/lib/opencv4/3rdparty/liblibwebp.a
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: ../3rdparty/opencv-arm-linux/lib/opencv4/3rdparty/liblibpng.a
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: ../3rdparty/opencv-arm-linux/lib/opencv4/3rdparty/liblibtiff.a
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: ../3rdparty/opencv-arm-linux/lib/opencv4/3rdparty/liblibopenjp2.a
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: ../3rdparty/opencv-arm-linux/lib/libopencv_imgproc.a
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: ../3rdparty/opencv-arm-linux/lib/libopencv_core.a
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: ../3rdparty/opencv-arm-linux/lib/opencv4/3rdparty/libzlib.a
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: ../3rdparty/opencv-arm-linux/lib/opencv4/3rdparty/libittnotify.a
examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp: examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_11) "Linking CXX executable sample_vin_ivps_npu_venc_rtsp"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/build: examples/sample_vin_ivps_npu_venc_rtsp/sample_vin_ivps_npu_venc_rtsp

.PHONY : examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/build

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/clean:
	cd /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp && $(CMAKE_COMMAND) -P CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/cmake_clean.cmake
.PHONY : examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/clean

examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/depend:
	cd /home/zzh/Desktop/ax-pipeline/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/zzh/Desktop/ax-pipeline /home/zzh/Desktop/ax-pipeline/examples/sample_vin_ivps_npu_venc_rtsp /home/zzh/Desktop/ax-pipeline/build /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp /home/zzh/Desktop/ax-pipeline/build/examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : examples/sample_vin_ivps_npu_venc_rtsp/CMakeFiles/sample_vin_ivps_npu_venc_rtsp.dir/depend


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
include examples/libaxdl/CMakeFiles/axdl.dir/depend.make

# Include the progress variables for this target.
include examples/libaxdl/CMakeFiles/axdl.dir/progress.make

# Include the compile flags for this target's objects.
include examples/libaxdl/CMakeFiles/axdl.dir/flags.make

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_common_api.cpp.o: examples/libaxdl/CMakeFiles/axdl.dir/flags.make
examples/libaxdl/CMakeFiles/axdl.dir/src/ax_common_api.cpp.o: ../examples/libaxdl/src/ax_common_api.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object examples/libaxdl/CMakeFiles/axdl.dir/src/ax_common_api.cpp.o"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/axdl.dir/src/ax_common_api.cpp.o -c /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_common_api.cpp

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_common_api.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/axdl.dir/src/ax_common_api.cpp.i"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_common_api.cpp > CMakeFiles/axdl.dir/src/ax_common_api.cpp.i

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_common_api.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/axdl.dir/src/ax_common_api.cpp.s"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_common_api.cpp -o CMakeFiles/axdl.dir/src/ax_common_api.cpp.s

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_base.cpp.o: examples/libaxdl/CMakeFiles/axdl.dir/flags.make
examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_base.cpp.o: ../examples/libaxdl/src/ax_model_base.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_base.cpp.o"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/axdl.dir/src/ax_model_base.cpp.o -c /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_base.cpp

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_base.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/axdl.dir/src/ax_model_base.cpp.i"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_base.cpp > CMakeFiles/axdl.dir/src/ax_model_base.cpp.i

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_base.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/axdl.dir/src/ax_model_base.cpp.s"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_base.cpp -o CMakeFiles/axdl.dir/src/ax_model_base.cpp.s

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_crowdcount.cpp.o: examples/libaxdl/CMakeFiles/axdl.dir/flags.make
examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_crowdcount.cpp.o: ../examples/libaxdl/src/ax_model_crowdcount.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_crowdcount.cpp.o"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/axdl.dir/src/ax_model_crowdcount.cpp.o -c /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_crowdcount.cpp

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_crowdcount.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/axdl.dir/src/ax_model_crowdcount.cpp.i"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_crowdcount.cpp > CMakeFiles/axdl.dir/src/ax_model_crowdcount.cpp.i

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_crowdcount.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/axdl.dir/src/ax_model_crowdcount.cpp.s"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_crowdcount.cpp -o CMakeFiles/axdl.dir/src/ax_model_crowdcount.cpp.s

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_det.cpp.o: examples/libaxdl/CMakeFiles/axdl.dir/flags.make
examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_det.cpp.o: ../examples/libaxdl/src/ax_model_det.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_det.cpp.o"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/axdl.dir/src/ax_model_det.cpp.o -c /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_det.cpp

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_det.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/axdl.dir/src/ax_model_det.cpp.i"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_det.cpp > CMakeFiles/axdl.dir/src/ax_model_det.cpp.i

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_det.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/axdl.dir/src/ax_model_det.cpp.s"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_det.cpp -o CMakeFiles/axdl.dir/src/ax_model_det.cpp.s

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_ml_sub.cpp.o: examples/libaxdl/CMakeFiles/axdl.dir/flags.make
examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_ml_sub.cpp.o: ../examples/libaxdl/src/ax_model_ml_sub.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_ml_sub.cpp.o"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/axdl.dir/src/ax_model_ml_sub.cpp.o -c /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_ml_sub.cpp

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_ml_sub.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/axdl.dir/src/ax_model_ml_sub.cpp.i"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_ml_sub.cpp > CMakeFiles/axdl.dir/src/ax_model_ml_sub.cpp.i

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_ml_sub.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/axdl.dir/src/ax_model_ml_sub.cpp.s"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_ml_sub.cpp -o CMakeFiles/axdl.dir/src/ax_model_ml_sub.cpp.s

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_multi_level_model.cpp.o: examples/libaxdl/CMakeFiles/axdl.dir/flags.make
examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_multi_level_model.cpp.o: ../examples/libaxdl/src/ax_model_multi_level_model.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building CXX object examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_multi_level_model.cpp.o"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/axdl.dir/src/ax_model_multi_level_model.cpp.o -c /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_multi_level_model.cpp

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_multi_level_model.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/axdl.dir/src/ax_model_multi_level_model.cpp.i"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_multi_level_model.cpp > CMakeFiles/axdl.dir/src/ax_model_multi_level_model.cpp.i

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_multi_level_model.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/axdl.dir/src/ax_model_multi_level_model.cpp.s"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_multi_level_model.cpp -o CMakeFiles/axdl.dir/src/ax_model_multi_level_model.cpp.s

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_runner_ax620.cpp.o: examples/libaxdl/CMakeFiles/axdl.dir/flags.make
examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_runner_ax620.cpp.o: ../examples/libaxdl/src/ax_model_runner_ax620.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building CXX object examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_runner_ax620.cpp.o"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/axdl.dir/src/ax_model_runner_ax620.cpp.o -c /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_runner_ax620.cpp

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_runner_ax620.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/axdl.dir/src/ax_model_runner_ax620.cpp.i"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_runner_ax620.cpp > CMakeFiles/axdl.dir/src/ax_model_runner_ax620.cpp.i

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_runner_ax620.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/axdl.dir/src/ax_model_runner_ax620.cpp.s"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_runner_ax620.cpp -o CMakeFiles/axdl.dir/src/ax_model_runner_ax620.cpp.s

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_runner_ax650.cpp.o: examples/libaxdl/CMakeFiles/axdl.dir/flags.make
examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_runner_ax650.cpp.o: ../examples/libaxdl/src/ax_model_runner_ax650.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Building CXX object examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_runner_ax650.cpp.o"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/axdl.dir/src/ax_model_runner_ax650.cpp.o -c /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_runner_ax650.cpp

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_runner_ax650.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/axdl.dir/src/ax_model_runner_ax650.cpp.i"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_runner_ax650.cpp > CMakeFiles/axdl.dir/src/ax_model_runner_ax650.cpp.i

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_runner_ax650.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/axdl.dir/src/ax_model_runner_ax650.cpp.s"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_runner_ax650.cpp -o CMakeFiles/axdl.dir/src/ax_model_runner_ax650.cpp.s

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_seg.cpp.o: examples/libaxdl/CMakeFiles/axdl.dir/flags.make
examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_seg.cpp.o: ../examples/libaxdl/src/ax_model_seg.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_9) "Building CXX object examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_seg.cpp.o"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/axdl.dir/src/ax_model_seg.cpp.o -c /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_seg.cpp

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_seg.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/axdl.dir/src/ax_model_seg.cpp.i"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_seg.cpp > CMakeFiles/axdl.dir/src/ax_model_seg.cpp.i

examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_seg.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/axdl.dir/src/ax_model_seg.cpp.s"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/ax_model_seg.cpp -o CMakeFiles/axdl.dir/src/ax_model_seg.cpp.s

examples/libaxdl/CMakeFiles/axdl.dir/src/c_api.cpp.o: examples/libaxdl/CMakeFiles/axdl.dir/flags.make
examples/libaxdl/CMakeFiles/axdl.dir/src/c_api.cpp.o: ../examples/libaxdl/src/c_api.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_10) "Building CXX object examples/libaxdl/CMakeFiles/axdl.dir/src/c_api.cpp.o"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/axdl.dir/src/c_api.cpp.o -c /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/c_api.cpp

examples/libaxdl/CMakeFiles/axdl.dir/src/c_api.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/axdl.dir/src/c_api.cpp.i"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/c_api.cpp > CMakeFiles/axdl.dir/src/c_api.cpp.i

examples/libaxdl/CMakeFiles/axdl.dir/src/c_api.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/axdl.dir/src/c_api.cpp.s"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/c_api.cpp -o CMakeFiles/axdl.dir/src/c_api.cpp.s

examples/libaxdl/CMakeFiles/axdl.dir/src/sample_run_joint.cpp.o: examples/libaxdl/CMakeFiles/axdl.dir/flags.make
examples/libaxdl/CMakeFiles/axdl.dir/src/sample_run_joint.cpp.o: ../examples/libaxdl/src/sample_run_joint.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_11) "Building CXX object examples/libaxdl/CMakeFiles/axdl.dir/src/sample_run_joint.cpp.o"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/axdl.dir/src/sample_run_joint.cpp.o -c /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/sample_run_joint.cpp

examples/libaxdl/CMakeFiles/axdl.dir/src/sample_run_joint.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/axdl.dir/src/sample_run_joint.cpp.i"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/sample_run_joint.cpp > CMakeFiles/axdl.dir/src/sample_run_joint.cpp.i

examples/libaxdl/CMakeFiles/axdl.dir/src/sample_run_joint.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/axdl.dir/src/sample_run_joint.cpp.s"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/sample_run_joint.cpp -o CMakeFiles/axdl.dir/src/sample_run_joint.cpp.s

examples/libaxdl/CMakeFiles/axdl.dir/src/utilities/mat_pixel_affine.cpp.o: examples/libaxdl/CMakeFiles/axdl.dir/flags.make
examples/libaxdl/CMakeFiles/axdl.dir/src/utilities/mat_pixel_affine.cpp.o: ../examples/libaxdl/src/utilities/mat_pixel_affine.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_12) "Building CXX object examples/libaxdl/CMakeFiles/axdl.dir/src/utilities/mat_pixel_affine.cpp.o"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/axdl.dir/src/utilities/mat_pixel_affine.cpp.o -c /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/utilities/mat_pixel_affine.cpp

examples/libaxdl/CMakeFiles/axdl.dir/src/utilities/mat_pixel_affine.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/axdl.dir/src/utilities/mat_pixel_affine.cpp.i"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/utilities/mat_pixel_affine.cpp > CMakeFiles/axdl.dir/src/utilities/mat_pixel_affine.cpp.i

examples/libaxdl/CMakeFiles/axdl.dir/src/utilities/mat_pixel_affine.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/axdl.dir/src/utilities/mat_pixel_affine.cpp.s"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/zzh/Desktop/ax-pipeline/examples/libaxdl/src/utilities/mat_pixel_affine.cpp -o CMakeFiles/axdl.dir/src/utilities/mat_pixel_affine.cpp.s

# Object files for target axdl
axdl_OBJECTS = \
"CMakeFiles/axdl.dir/src/ax_common_api.cpp.o" \
"CMakeFiles/axdl.dir/src/ax_model_base.cpp.o" \
"CMakeFiles/axdl.dir/src/ax_model_crowdcount.cpp.o" \
"CMakeFiles/axdl.dir/src/ax_model_det.cpp.o" \
"CMakeFiles/axdl.dir/src/ax_model_ml_sub.cpp.o" \
"CMakeFiles/axdl.dir/src/ax_model_multi_level_model.cpp.o" \
"CMakeFiles/axdl.dir/src/ax_model_runner_ax620.cpp.o" \
"CMakeFiles/axdl.dir/src/ax_model_runner_ax650.cpp.o" \
"CMakeFiles/axdl.dir/src/ax_model_seg.cpp.o" \
"CMakeFiles/axdl.dir/src/c_api.cpp.o" \
"CMakeFiles/axdl.dir/src/sample_run_joint.cpp.o" \
"CMakeFiles/axdl.dir/src/utilities/mat_pixel_affine.cpp.o"

# External object files for target axdl
axdl_EXTERNAL_OBJECTS =

examples/libaxdl/libaxdl.a: examples/libaxdl/CMakeFiles/axdl.dir/src/ax_common_api.cpp.o
examples/libaxdl/libaxdl.a: examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_base.cpp.o
examples/libaxdl/libaxdl.a: examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_crowdcount.cpp.o
examples/libaxdl/libaxdl.a: examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_det.cpp.o
examples/libaxdl/libaxdl.a: examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_ml_sub.cpp.o
examples/libaxdl/libaxdl.a: examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_multi_level_model.cpp.o
examples/libaxdl/libaxdl.a: examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_runner_ax620.cpp.o
examples/libaxdl/libaxdl.a: examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_runner_ax650.cpp.o
examples/libaxdl/libaxdl.a: examples/libaxdl/CMakeFiles/axdl.dir/src/ax_model_seg.cpp.o
examples/libaxdl/libaxdl.a: examples/libaxdl/CMakeFiles/axdl.dir/src/c_api.cpp.o
examples/libaxdl/libaxdl.a: examples/libaxdl/CMakeFiles/axdl.dir/src/sample_run_joint.cpp.o
examples/libaxdl/libaxdl.a: examples/libaxdl/CMakeFiles/axdl.dir/src/utilities/mat_pixel_affine.cpp.o
examples/libaxdl/libaxdl.a: examples/libaxdl/CMakeFiles/axdl.dir/build.make
examples/libaxdl/libaxdl.a: examples/libaxdl/CMakeFiles/axdl.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_13) "Linking CXX static library libaxdl.a"
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && $(CMAKE_COMMAND) -P CMakeFiles/axdl.dir/cmake_clean_target.cmake
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/axdl.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/libaxdl/CMakeFiles/axdl.dir/build: examples/libaxdl/libaxdl.a

.PHONY : examples/libaxdl/CMakeFiles/axdl.dir/build

examples/libaxdl/CMakeFiles/axdl.dir/clean:
	cd /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl && $(CMAKE_COMMAND) -P CMakeFiles/axdl.dir/cmake_clean.cmake
.PHONY : examples/libaxdl/CMakeFiles/axdl.dir/clean

examples/libaxdl/CMakeFiles/axdl.dir/depend:
	cd /home/zzh/Desktop/ax-pipeline/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/zzh/Desktop/ax-pipeline /home/zzh/Desktop/ax-pipeline/examples/libaxdl /home/zzh/Desktop/ax-pipeline/build /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl /home/zzh/Desktop/ax-pipeline/build/examples/libaxdl/CMakeFiles/axdl.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : examples/libaxdl/CMakeFiles/axdl.dir/depend


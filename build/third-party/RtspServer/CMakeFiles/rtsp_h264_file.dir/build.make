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
include third-party/RtspServer/CMakeFiles/rtsp_h264_file.dir/depend.make

# Include the progress variables for this target.
include third-party/RtspServer/CMakeFiles/rtsp_h264_file.dir/progress.make

# Include the compile flags for this target's objects.
include third-party/RtspServer/CMakeFiles/rtsp_h264_file.dir/flags.make

third-party/RtspServer/CMakeFiles/rtsp_h264_file.dir/RtspServer/example/rtsp_h264_file.cpp.o: third-party/RtspServer/CMakeFiles/rtsp_h264_file.dir/flags.make
third-party/RtspServer/CMakeFiles/rtsp_h264_file.dir/RtspServer/example/rtsp_h264_file.cpp.o: ../third-party/RtspServer/RtspServer/example/rtsp_h264_file.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object third-party/RtspServer/CMakeFiles/rtsp_h264_file.dir/RtspServer/example/rtsp_h264_file.cpp.o"
	cd /home/zzh/Desktop/ax-pipeline/build/third-party/RtspServer && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/rtsp_h264_file.dir/RtspServer/example/rtsp_h264_file.cpp.o -c /home/zzh/Desktop/ax-pipeline/third-party/RtspServer/RtspServer/example/rtsp_h264_file.cpp

third-party/RtspServer/CMakeFiles/rtsp_h264_file.dir/RtspServer/example/rtsp_h264_file.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/rtsp_h264_file.dir/RtspServer/example/rtsp_h264_file.cpp.i"
	cd /home/zzh/Desktop/ax-pipeline/build/third-party/RtspServer && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/zzh/Desktop/ax-pipeline/third-party/RtspServer/RtspServer/example/rtsp_h264_file.cpp > CMakeFiles/rtsp_h264_file.dir/RtspServer/example/rtsp_h264_file.cpp.i

third-party/RtspServer/CMakeFiles/rtsp_h264_file.dir/RtspServer/example/rtsp_h264_file.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/rtsp_h264_file.dir/RtspServer/example/rtsp_h264_file.cpp.s"
	cd /home/zzh/Desktop/ax-pipeline/build/third-party/RtspServer && /opt/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/zzh/Desktop/ax-pipeline/third-party/RtspServer/RtspServer/example/rtsp_h264_file.cpp -o CMakeFiles/rtsp_h264_file.dir/RtspServer/example/rtsp_h264_file.cpp.s

# Object files for target rtsp_h264_file
rtsp_h264_file_OBJECTS = \
"CMakeFiles/rtsp_h264_file.dir/RtspServer/example/rtsp_h264_file.cpp.o"

# External object files for target rtsp_h264_file
rtsp_h264_file_EXTERNAL_OBJECTS =

third-party/RtspServer/rtsp_h264_file: third-party/RtspServer/CMakeFiles/rtsp_h264_file.dir/RtspServer/example/rtsp_h264_file.cpp.o
third-party/RtspServer/rtsp_h264_file: third-party/RtspServer/CMakeFiles/rtsp_h264_file.dir/build.make
third-party/RtspServer/rtsp_h264_file: third-party/RtspServer/libRtspServer.a
third-party/RtspServer/rtsp_h264_file: third-party/RtspServer/CMakeFiles/rtsp_h264_file.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/zzh/Desktop/ax-pipeline/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable rtsp_h264_file"
	cd /home/zzh/Desktop/ax-pipeline/build/third-party/RtspServer && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/rtsp_h264_file.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
third-party/RtspServer/CMakeFiles/rtsp_h264_file.dir/build: third-party/RtspServer/rtsp_h264_file

.PHONY : third-party/RtspServer/CMakeFiles/rtsp_h264_file.dir/build

third-party/RtspServer/CMakeFiles/rtsp_h264_file.dir/clean:
	cd /home/zzh/Desktop/ax-pipeline/build/third-party/RtspServer && $(CMAKE_COMMAND) -P CMakeFiles/rtsp_h264_file.dir/cmake_clean.cmake
.PHONY : third-party/RtspServer/CMakeFiles/rtsp_h264_file.dir/clean

third-party/RtspServer/CMakeFiles/rtsp_h264_file.dir/depend:
	cd /home/zzh/Desktop/ax-pipeline/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/zzh/Desktop/ax-pipeline /home/zzh/Desktop/ax-pipeline/third-party/RtspServer /home/zzh/Desktop/ax-pipeline/build /home/zzh/Desktop/ax-pipeline/build/third-party/RtspServer /home/zzh/Desktop/ax-pipeline/build/third-party/RtspServer/CMakeFiles/rtsp_h264_file.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : third-party/RtspServer/CMakeFiles/rtsp_h264_file.dir/depend


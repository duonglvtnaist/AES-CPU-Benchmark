# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/duong/AES/tiny-AES-c-master

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/duong/AES/tiny-AES-c-master

# Include any dependencies generated for this target.
include CMakeFiles/tiny-aes.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/tiny-aes.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/tiny-aes.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/tiny-aes.dir/flags.make

CMakeFiles/tiny-aes.dir/aes.c.o: CMakeFiles/tiny-aes.dir/flags.make
CMakeFiles/tiny-aes.dir/aes.c.o: aes.c
CMakeFiles/tiny-aes.dir/aes.c.o: CMakeFiles/tiny-aes.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/duong/AES/tiny-AES-c-master/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/tiny-aes.dir/aes.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/tiny-aes.dir/aes.c.o -MF CMakeFiles/tiny-aes.dir/aes.c.o.d -o CMakeFiles/tiny-aes.dir/aes.c.o -c /home/duong/AES/tiny-AES-c-master/aes.c

CMakeFiles/tiny-aes.dir/aes.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/tiny-aes.dir/aes.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/duong/AES/tiny-AES-c-master/aes.c > CMakeFiles/tiny-aes.dir/aes.c.i

CMakeFiles/tiny-aes.dir/aes.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/tiny-aes.dir/aes.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/duong/AES/tiny-AES-c-master/aes.c -o CMakeFiles/tiny-aes.dir/aes.c.s

# Object files for target tiny-aes
tiny__aes_OBJECTS = \
"CMakeFiles/tiny-aes.dir/aes.c.o"

# External object files for target tiny-aes
tiny__aes_EXTERNAL_OBJECTS =

libtiny-aes.a: CMakeFiles/tiny-aes.dir/aes.c.o
libtiny-aes.a: CMakeFiles/tiny-aes.dir/build.make
libtiny-aes.a: CMakeFiles/tiny-aes.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/duong/AES/tiny-AES-c-master/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C static library libtiny-aes.a"
	$(CMAKE_COMMAND) -P CMakeFiles/tiny-aes.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/tiny-aes.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/tiny-aes.dir/build: libtiny-aes.a
.PHONY : CMakeFiles/tiny-aes.dir/build

CMakeFiles/tiny-aes.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/tiny-aes.dir/cmake_clean.cmake
.PHONY : CMakeFiles/tiny-aes.dir/clean

CMakeFiles/tiny-aes.dir/depend:
	cd /home/duong/AES/tiny-AES-c-master && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/duong/AES/tiny-AES-c-master /home/duong/AES/tiny-AES-c-master /home/duong/AES/tiny-AES-c-master /home/duong/AES/tiny-AES-c-master /home/duong/AES/tiny-AES-c-master/CMakeFiles/tiny-aes.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/tiny-aes.dir/depend

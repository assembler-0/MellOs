# SPDX-License-Identifier: Apache-2.0
# Copyright (c) 2026 assembler-0.
# 
# This file is part of ZXFoundation (TM) and is ported to MellOS.
#  
# As part of MellOS, this file can be distributed and/or modified 
# under the terms of the GNU General Public License as published by the Free 
# Software Foundation, either version 3 of the License, or (at your option) 
# any later version.

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR i386)

set(CMAKE_C_COMPILER i386-elf-gcc)
set(CMAKE_CXX_COMPILER i386-elf-g++)
set(CMAKE_ASM_COMPILER i386-elf-gcc)

set(CMAKE_ASM_NASM_COMPILER nasm)
set(CMAKE_ASM_NASM_OBJECT_FORMAT elf)
set(CMAKE_C_LINK_EXECUTABLE "<CMAKE_LINKER> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_CXX_LINK_EXECUTABLE "<CMAKE_LINKER> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_ASM_LINK_EXECUTABLE "<CMAKE_LINKER> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_LINKER s390x-ibm-linux-gnu-ld)
set(CMAKE_AR s390x-ibm-linux-gnu-ar)
set(CMAKE_RANLIB s390x-ibm-linux-gnu-ranlib)
set(CMAKE_OBJCOPY s390x-ibm-linux-gnu-objcopy)
set(ZX_HOST_CC gcc)

set(COMPILER_ID "gcc")

if (NOT DEFINED TARGET_EMULATION_MODE)
    set(TARGET_EMULATION_MODE "elf64_s390" CACHE STRING "Target emulation mode when linking")
endif()

if (NOT DEFINED COMMON_TARGET_TRIPLE)
    set(COMMON_TARGET_TRIPLE "s390x-unknown-none-elf" CACHE STRING "Target triple for z/Architecture (S390X)")
endif()

if (NOT DEFINED MARCH_MODE)
    set(MARCH_MODE "z10" CACHE STRING "Argument for -march= and -mtune=")
endif()

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(CMAKE_C_COMPILER_WORKS 1)
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")
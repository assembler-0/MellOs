# Kernel source files
file(GLOB_RECURSE KERNEL_C_SRCS CONFIGURE_DEPENDS ${CMAKE_SOURCE_DIR}/*.c)
list(FILTER KERNEL_C_SRCS EXCLUDE REGEX ".*/CMakeFiles/.*")
list(FILTER KERNEL_C_SRCS EXCLUDE REGEX ".*/external_modules/.*")

set(INC_DIRS)
# Header files are in same dirs as C files
list(APPEND INC_DIRS ${CMAKE_SOURCE_DIR})
# We will move to a "lib" dir for common code
list(APPEND INC_DIRS ${CMAKE_SOURCE_DIR}/lib)
list(REMOVE_DUPLICATES INC_DIRS)
include_directories(${INC_DIRS})
# Source lists (replicate Makefile selection)
# C sources: all .c files

set(C_SOURCES ${KERNEL_C_SRCS})

# ASM sources
set(ASM_SOURCES
        ${CMAKE_SOURCE_DIR}/cpu/gdt/gdt_loader.asm
        ${CMAKE_SOURCE_DIR}/kernel/kernel_entry.asm
        ${CMAKE_SOURCE_DIR}/processes/processes_asm.asm
)
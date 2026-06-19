# full kernel compilation

set(NASM_DEFS
        -D${VGA}
        -DHRES=${HRES}
        -DVRES=${VRES}
        -DBPP=${BPP}
)

set(NASM_INCS)
foreach(d ${INC_DIRS})
    list(APPEND NASM_INCS -I${d}/)
endforeach()

add_executable(kernel.elf ${C_SOURCES} ${ASM_SOURCES})
set_target_properties(kernel.elf PROPERTIES OUTPUT_NAME kernel)

# Apply NASM flags correctly as a list (each arg stays its own token)
foreach(asm ${ASM_SOURCES})
    set_source_files_properties(${asm} PROPERTIES
        COMPILE_OPTIONS "${NASM_DEFS};${NASM_INCS};-w+regsize"
    )
endforeach()

get_filename_component(LDSCRIPT "${CMAKE_SOURCE_DIR}/kernel/kernel.ld" ABSOLUTE)

target_link_options(kernel.elf PRIVATE
    -T ${LDSCRIPT}
    -nostdlib
    -static
    --no-dynamic-linker
    -ztext
    --no-pie -g
    -m${TARGET_EMULATION_MODE}
)

if (COMPILER_ID STREQUAL "gcc")
    target_link_options(kernel.elf PRIVATE
        --no-warn-rwx-segments
    )
endif()

# Freestanding kernel style build
# add '-DCMAKE_BUILD_TYPE=Debug' to your arguments for debug build
target_compile_options(kernel.elf PRIVATE
        $<$<AND:$<COMPILE_LANGUAGE:C>,$<CONFIG:Debug>>:-Og>
        $<$<AND:$<COMPILE_LANGUAGE:C>,$<CONFIG:Debug>>:-g>
        $<$<AND:$<COMPILE_LANGUAGE:C>,$<NOT:$<CONFIG:Debug>>>:-O${OPT_LEVEL}>
        $<$<AND:$<COMPILE_LANGUAGE:C>,$<NOT:$<BOOL:${USE_CLANG}>>>:-m32>
        $<$<AND:$<COMPILE_LANGUAGE:C>,$<NOT:${DISABLE_SSE}>>:-msse>
        $<$<AND:$<COMPILE_LANGUAGE:C>,$<BOOL:${CONFIG_SSP}>>:-fstack-protector-strong>
        $<$<AND:$<COMPILE_LANGUAGE:C>,$<CONFIG:Debug>>:-DMELLOS_DEBUG>
        $<$<COMPILE_LANGUAGE:C>:-fno-builtin
            -fno-pic
            -Wall
            -Wno-parentheses
            -Wno-incompatible-pointer-types
            -Wno-missing-braces
            -ffreestanding
            -Werror=implicit-function-declaration
            -Werror=return-type
            ${COMMON_DEFS_WITH_D}
        >
)

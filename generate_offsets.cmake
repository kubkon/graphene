cmake_policy(SET CMP0054 NEW)

file(REMOVE ${OUTPUT_FILE})

if(${FORMAT} STREQUAL "C")
    file(APPEND ${OUTPUT_FILE} "/* DO NOT MODIFY. THIS FILE WAS AUTO-GENERATED. */\n")
    file(APPEND ${OUTPUT_FILE} "#ifndef _ASM_OFFSETS_H_\n")
    file(APPEND ${OUTPUT_FILE} "#define _ASM_OFFSETS_H_\n")
    file(APPEND ${OUTPUT_FILE} "\n")
endif()

if(${FORMAT} STREQUAL "python")
    file(APPEND ${OUTPUT_FILE} "# DO NOT MODIFY. THIS FILE WAS AUTO-GENERATED.\n")
    file(APPEND ${OUTPUT_FILE} "\n")
endif()

file(READ ${INPUT_FILE} INPUT)

string(REGEX REPLACE ";" "\\\\;" INPUT "${INPUT}")
string(REGEX REPLACE "\n" ";" INPUT "${INPUT}")

foreach(LINE ${INPUT})
    string(REGEX REPLACE "[ \t\"]+" ";" TOKENS "${LINE}")
    set(LAST_LAST "")
    set(LAST "")
    foreach(THIS ${TOKENS})
        if("${LAST_LAST}" STREQUAL "GENERATED_INTEGER")
            if(${FORMAT} STREQUAL "C")
                file(APPEND ${OUTPUT_FILE} "#ifndef ${LAST}\n")
                file(APPEND ${OUTPUT_FILE} "#define ${LAST} ${THIS}\n")
                file(APPEND ${OUTPUT_FILE} "#endif\n")
            endif()
            if(${FORMAT} STREQUAL "python")
                file(APPEND ${OUTPUT_FILE} "${LAST} = ${THIS}\n")
            endif()
        endif()
        set(LAST_LAST ${LAST})
        set(LAST ${THIS})
    endforeach()
endforeach()

if(${FORMAT} STREQUAL "C")
    file(APPEND ${OUTPUT_FILE} "\n")
    file(APPEND ${OUTPUT_FILE} "#endif\n")
endif()

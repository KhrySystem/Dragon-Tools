macro(subdirlist RESULT CURDIR)
    file(GLOB CHILDREN ${CURDIR}/*) # This was changed
    set(DIRLIST "")
    foreach(CHILD ${CHILDREN})
        if(IS_DIRECTORY ${CHILD}) # This was changed
            list(APPEND DIRLIST ${CHILD})
        endif()
    endforeach()
    set(${RESULT} ${DIRLIST})
ENDMACRO()
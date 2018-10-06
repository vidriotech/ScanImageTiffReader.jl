if(WIN32)
    set(pwd ${CMAKE_CURRENT_LIST_DIR})
    set(SCANIMAGETIFFREADER_ROOT_DIR ${pwd} CACHE PATH "Path to the ScanImage Tiff Reader library")

    message(STATUS "ScanImageTiffReader: ${pwd}")

    set(tgt ScanImageTiffReaderAPIStatic)
    add_library(${tgt} STATIC IMPORTED GLOBAL)
    set_target_properties(${tgt} PROPERTIES
        IMPORTED_LOCATION             ${SCANIMAGETIFFREADER_ROOT_DIR}/lib/ScanImageTiffReaderAPIStatic.lib
        INTERFACE_INCLUDE_DIRECTORIES ${SCANIMAGETIFFREADER_ROOT_DIR}/include
    )
endif()
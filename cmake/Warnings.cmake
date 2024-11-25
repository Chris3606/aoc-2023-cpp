# Enables strict warnings and various analyzers
function(Warnings_Enable TARGET)
    set(MSVC_WARNINGS
        /W4 # Strict warnings
        /permissive- # No C/C++ Standard Extensions
        /WX # Warnings as errors
        /analyze # MSVC code analysis
        /w14265 # class has virtual functions, but destructor is not virtual
        /w14263 # function does not override any base class virtual function
    )

    set(CLANG_WARNINGS
        # MOAR warnings
        -Wall
        -Wextra
        -Werror # Warnings as errors
        -Wshadow # if a variable declaration shadows one from a parent context
        -Wpedantic # warn if non-standard is used
        # C and C++ Warnings
        -Wunused # warn on anything being unused
        # C++ Warnings
        -Wnon-virtual-dtor # if a class with virtual func has a non-virtual dest
        -Wold-style-cast # warn for c-style casts
        -Woverloaded-virtual # if you overload (not override) a virtual function
    )

    set(GCC_WARNINGS
        ${CLANG_WARNINGS}
        -Wduplicated-cond # warn if if / else chain has duplicated conditions
        -Wduplicated-branches # warn if if / else branches have duplicated code
        -Wlogical-op # warn about logical operations being used where bitwise were probably wanted
    )

    if(CMAKE_CXX_COMPILER_ID MATCHES "MSVC")
        set(WARNINGS ${MSVC_WARNINGS})
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
        set(WARNINGS ${CLANG_WARNINGS})
    elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
        set(WARNINGS ${GCC_WARNINGS})
    else()
        message(FATAL_ERROR "Unsupported compiler ${CMAKE_CXX_COMPILER_ID}.")
    endif()

    target_compile_options(${TARGET} PRIVATE ${WARNINGS})
endfunction()

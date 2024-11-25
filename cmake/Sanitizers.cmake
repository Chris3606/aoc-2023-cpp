# Enables address sanitization.
function(Sanitizers_Enable TARGET ADDRESS UNDEF LEAK THREAD COMPILER_DIR)
    if(NOT ADDRESS AND NOT UNDEF AND NOT LEAK AND NOT THREAD)
        return()
    endif()

    if(CMAKE_CXX_COMPILER_ID MATCHES "Clang" OR CMAKE_CXX_COMPILER_ID MATCHES
                                                "GNU")
        target_compile_options(${TARGET} PRIVATE "-fno-omit-frame-pointer")
        target_link_options(${TARGET} PRIVATE "-fno-omit-frame-pointer")
        
        if (ADDRESS)
            target_compile_options(${TARGET} PRIVATE -fsanitize=address -shared-libsan)
            target_link_options(${TARGET} PRIVATE -fsanitize=address -shared-libsan)
        endif()

        if (UNDEF)
            target_compile_options(${TARGET} PRIVATE -fsanitize=undefined)
            target_link_options(${TARGET} PRIVATE -fsanitize=undefined)
        endif()

        if (LEAK)
            if (CMAKE_CXX_SIMULATE_ID MATCHES "MSVC")
                message(AUTHOR_WARNING "Leak sanitizer selected, but this is not supported for clang MSVC targets.")
            else()
                target_compile_options(${TARGET} PRIVATE -fsanitize=leak)
                target_link_options(${TARGET} PRIVATE -fsanitize=leak)
            endif()
        endif()

        if (THREAD)
            if (CMAKE_CXX_SIMULATE_ID MATCHES "MSVC")
                message(AUTHOR_WARNING "Thread sanitizer selected, but this is not supported for clang MSVC targets.")
            else()
                target_compile_options(${TARGET} PRIVATE -fsanitize=thread)
                target_link_options(${TARGET} PRIVATE -fsanitize=thread)
            endif()
        endif()
        
    
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
        if (ADDRESS)
            target_compile_options(${TARGET} PRIVATE /fsanitize=address)

            # Modern MSVC (aka recent releases of VS2022) depend on a single DLL for asan, even for statically
            # linked targets.  So, for executable targets, we'll copy that DLL (and its dependencies) to the output
            # directory so that the resulting executable can find the DLL without being run from within a VS Developer
            # Command Prompt and without Visual C++ redistributable installed.
            #
            # The DLLs we need to copy reside in the same parent directory as cl.exe.  Therefore, we use the compiler path as a base
            # in order to ensure we get the right DLL regardless of what toolset we're using.
            get_target_property(target_type ${TARGET} TYPE)
            if (target_type STREQUAL "EXECUTABLE")
                if(CMAKE_SIZEOF_VOID_P EQUAL 8)
                    set(DLL_NAMES clang_rt.asan_dynamic-x86_64.dll;vcruntime140.dll;vcruntime140_1.dll)
                else()
                    # For x86, we need the x86 vcruntime, so we need to get it from the hostx86 directory.
                    set(DLL_NAMES clang_rt.asan_dynamic-i386.dll;../../Hostx86/x86/vcruntime140.dll)
                endif()

                foreach (dll_path IN LISTS DLL_NAMES)
                    add_custom_command(TARGET ${TARGET} POST_BUILD
                                       COMMAND ${CMAKE_COMMAND} -E
                                       copy_if_different ${COMPILER_DIR}/${dll_path}
                                       ${CMAKE_CFG_INTDIR}/)
                endforeach()
            endif()

        endif()

        if (UNDEF)
            message(AUTHOR_WARNING "Undefined sanitizer selected, but this is not supported in MSVC.")
        endif()

        if (LEAK)
            message(AUTHOR_WARNING "Leak sanitizer selected, but this is not supported in MSVC.")
        endif()

        if (THREAD)
            message(AUTHOR_WARNING "Thread sanitizer selected, but this is not supported in MSVC.")
        endif()
    else()
        message(FATAL_ERROR "Unsupported compiler.")
    endif()
endfunction()

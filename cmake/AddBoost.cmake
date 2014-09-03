function(add_boost)
    include(CMakeParseArguments)
    cmake_parse_arguments(ADD_BOOST "" "" "COMPONENTS" ${ARGN})
    set(BoostVersion ${ARGV0})
    set(BoostSHA ${ARGV1})
    string(REPLACE "." "_" BoostVersUnder ${BoostVersion} )
    set(BoostFolderName "Boost-${BoostVersion}")

    set(BoostSrcDir "${BoostFolderName}_${CMAKE_CXX_COMPILER_ID}_${CMAKE_CXX_COMPILER_VERSION}")
    if(CMAKE_CL_64)
        set(BoostSourceDir "${BoostSourceDir}_Win64")
    endif()

    if(WIN32)
        set(Bootstrap "bootstrap.bat")
    else()
        set(Bootstrap "bootstrap.sh")
    endif()

    set(b2args b2
               link=static
               threading=multi
               runtime-link=shared
               stage)

    if (BOOST_PARALLEL)
        list(APPEND b2args -j${BOOST_PARALLEL})
    endif()

    foreach(Component ${ADD_BOOST_COMPONENTS})
        list(APPEND b2args --with-${Component})
    endforeach()

    if("${CMAKE_BUILD_TYPE}" STREQUAL "Release")
        list(APPEND b2args variant=release)
        set(blibs -mt)
    elseif("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
        list(APPEND b2args variant=debug)
        set(blibs -mt-d)
    endif()

    if(APPLE)
        list(APPEND b2args toolset=clang address-model=32_64)
    elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
        list(APPEND b2args toolset=clang)
    elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
        list(APPEND b2args toolset=gcc)
    elseif(MSVC)
        if(MSVC11)
            list(APPEND b2args toolset=msvc-11.0)
        elseif(MSVC12)
            list(APPEND b2args toolset=msvc-12.0)
        endif()
        if("${TargetArchitecture}" STREQUAL "x86_64")
            list(APPEND b2args address-model=64)
        endif()
    endif()

    include(ExternalProject)
    ExternalProject_Add(Boost
                        URL http://downloads.sourceforge.net/project/boost/boost/${BoostVersion}/boost_${BoostVersUnder}.tar.bz2
                        URL_HASH SHA1=${BoostSHA}
                        UPDATE_COMMAND "${Bootstrap}"
                        CONFIGURE_COMMAND ""
                        BUILD_COMMAND "${b2args}"
                        BUILD_IN_SOURCE 1
                        INSTALL_COMMAND "")

    ExternalProject_Get_Property(Boost BINARY_DIR)
    foreach(Component ${ADD_BOOST_COMPONENTS})
        if (WIN32)
            # TODO: Finish label for MinGW vs Visual Studio.
            list(APPEND BoostLibs ${BINARY_DIR}/stage/lib/libboost_${Component}-mgw48${blibs}-1_55.a)
        else()
            list(APPEND BoostLibs ${BINARY_DIR}/stage/lib/libboost_${Component}.a)
        endif()
    endforeach()
    set(Boost_LIBRARIES ${BoostLibs} PARENT_SCOPE)

    ExternalProject_Get_Property(Boost SOURCE_DIR)
    set(Boost_INCLUDE_DIRS ${SOURCE_DIR} PARENT_SCOPE)

    # Set vars for FindBoost, for other external projects that depend on it.
    set(BOOST_ROOT ${SOURCE_DIR} PARENT_SCOPE)
    set(BOOST_LIBRARYDIR ${BINARY_DIR}/stage/lib PARENT_SCOPE)
endfunction()

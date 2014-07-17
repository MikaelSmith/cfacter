set(LIBFACTER_VERSION_MAJOR 0)
set(LIBFACTER_VERSION_MINOR 2)
set(LIBFACTER_VERSION_PATCH 0)

# Set compiler-specific flags
set(CMAKE_CXX_FLAGS ${FACTER_CXX_FLAGS})

# Add the library target without a prefix (name already has the 'lib')
add_library(libfacter SHARED $<TARGET_OBJECTS:libfacter_common_sources> $<TARGET_OBJECTS:libfacter_posix_sources> $<TARGET_OBJECTS:libfacter_platform_sources>)
set_target_properties(libfacter PROPERTIES PREFIX "" VERSION "${LIBFACTER_VERSION_MAJOR}.${LIBFACTER_VERSION_MINOR}.${LIBFACTER_VERSION_PATCH}")
install(TARGETS libfacter DESTINATION lib)

# Link in additional libraries
target_link_libraries(libfacter
    pthread
    ${RE2_LIBRARIES}
    ${LOG4CXX_LIBRARIES}
    ${Boost_LIBRARIES}
    ${OPENSSL_LIBRARIES}
    ${YAMLCPP_LIBRARIES}
)

# Set include directories
include_directories(
    inc
    ${RE2_INCLUDE_DIRS}
    ${RAPIDJSON_INCLUDE_DIRS}
    ${LOG4CXX_INCLUDE_DIRS}
    ${Boost_INCLUDE_DIRS}
    ${OPENSSL_INCLUDE_DIRS}
    ${YAMLCPP_INCLUDE_DIRS}
)

add_subdirectory(inc)
add_subdirectory(src)
add_subdirectory(tests)

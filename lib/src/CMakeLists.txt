# Set the common (platform-independent) sources
add_library(libfacter_common_sources STATIC
    "${CMAKE_CURRENT_LIST_DIR}/facterlib.cc"
    "${CMAKE_CURRENT_LIST_DIR}/facts/array_value.cc"
    "${CMAKE_CURRENT_LIST_DIR}/facts/external/json_resolver.cc"
    "${CMAKE_CURRENT_LIST_DIR}/facts/external/resolver.cc"
    "${CMAKE_CURRENT_LIST_DIR}/facts/external/text_resolver.cc"
    "${CMAKE_CURRENT_LIST_DIR}/facts/external/yaml_resolver.cc"
    "${CMAKE_CURRENT_LIST_DIR}/facts/collection.cc"
    "${CMAKE_CURRENT_LIST_DIR}/facts/resolver.cc"
    "${CMAKE_CURRENT_LIST_DIR}/facts/map_value.cc"
    "${CMAKE_CURRENT_LIST_DIR}/facts/scalar_value.cc"
    "${CMAKE_CURRENT_LIST_DIR}/facts/value.cc"
    "${CMAKE_CURRENT_LIST_DIR}/util/file.cc"
    "${CMAKE_CURRENT_LIST_DIR}/util/scoped_file.cc"
    "${CMAKE_CURRENT_LIST_DIR}/util/string.cc"
)


# Set the POSIX sources if on a POSIX platform
if (UNIX)
    add_library(libfacter_posix_sources STATIC
        "${CMAKE_CURRENT_LIST_DIR}/execution/posix/execution.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/external/posix/execution_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/posix/dmi_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/posix/kernel_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/posix/networking_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/posix/operating_system_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/posix/collection.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/posix/processor_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/posix/ssh_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/posix/uptime_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/posix/virtualization_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/logging/posix/logging.cc"
        "${CMAKE_CURRENT_LIST_DIR}/util/posix/scoped_addrinfo.cc"
        "${CMAKE_CURRENT_LIST_DIR}/util/posix/scoped_bio.cc"
        "${CMAKE_CURRENT_LIST_DIR}/util/posix/scoped_descriptor.cc"
    )
endif()

# Set the platform-specific sources
if ("${CMAKE_SYSTEM_NAME}" MATCHES "Darwin")
    add_library(libfacter_platform_sources STATIC
        "${CMAKE_CURRENT_LIST_DIR}/facts/osx/dmi_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/bsd/networking_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/bsd/uptime_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/osx/networking_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/osx/collection.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/osx/processor_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/osx/system_profiler_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/osx/software_version_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/osx/virtualization_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/util/bsd/scoped_ifaddrs.cc"
    )
elseif ("${CMAKE_SYSTEM_NAME}" MATCHES "Linux")
    add_library(libfacter_platform_sources STATIC
        "${CMAKE_CURRENT_LIST_DIR}/facts/bsd/networking_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/linux/block_device_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/linux/dmi_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/linux/lsb_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/linux/networking_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/linux/operating_system_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/linux/uptime_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/linux/collection.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/linux/processor_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/linux/selinux_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/facts/linux/virtualization_resolver.cc"
        "${CMAKE_CURRENT_LIST_DIR}/util/bsd/scoped_ifaddrs.cc"
    )
endif()


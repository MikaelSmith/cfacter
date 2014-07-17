# Generate a file containing the above version numbers
configure_file (
    "${CMAKE_CURRENT_LIST_DIR}/facter/version.h.in"
    "${CMAKE_CURRENT_LIST_DIR}/facter/version.h"
)

install(DIRECTORY facter DESTINATION include)

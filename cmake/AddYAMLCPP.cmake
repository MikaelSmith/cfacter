include(ExternalProject)

ExternalProject_Add(
    yamlcpp
    DEPENDS Boost
    URL https://yaml-cpp.googlecode.com/files/yaml-cpp-0.5.1.tar.gz
    URL_HASH SHA1=9c5414b4090491e96d1b808fe8628b31e625fdaa
    CMAKE_ARGS -DBOOST_ROOT=${BOOST_ROOT} -DBOOST_LIBRARYDIR=${BOOST_LIBRARYDIR}
    UPDATE_COMMAND ""
    INSTALL_COMMAND "")

ExternalProject_Get_Property(yamlcpp BINARY_DIR)
set(YAMLCPP_LIBRARIES ${BINARY_DIR}/libyaml-cpp.a)

ExternalProject_Get_Property(yamlcpp SOURCE_DIR)
set(YAMLCPP_INCLUDE_DIRS ${SOURCE_DIR}/include)

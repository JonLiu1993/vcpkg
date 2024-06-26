# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/filesystem
    REF boost-${VERSION}
    SHA512 629b6c0d2dd1aab590d3af3c64427b61c3a6dd09f53026439aa508c9c15a2390d6f24cf80a64d6598a7ae85b35cf1584985d3d380556fb854bd394bf600a67d6
    HEAD_REF master
)

set(FEATURE_OPTIONS "")
boost_configure_and_install(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS ${FEATURE_OPTIONS}
)

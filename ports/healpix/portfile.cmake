set(HEALPIX_PACK_NAME  ${VERSION}_2022Jul28)

vcpkg_from_sourceforge(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO healpix
    REF Healpix_${VERSION}
    FILENAME "Healpix_${HEALPIX_PACK_NAME}.zip"
    SHA512 f77674658edb0f800ca882ab10436efe9c3e0db89d760e9418cfd373383b9f96054fa3f1a6993689698f7b89fd24b03ea3a53d083ad8d5e79de91095c1f16499
)

vcpkg_configure_make(
    AUTOCONFIG
    SOURCE_PATH "${SOURCE_PATH}"
    PROJECT_SUBPATH src/cxx
    COPY_SOURCE
    OPTIONS
        --with-libcfitsio-include=${CURRENT_INSTALLED_DIR}/include/cfitsio
        --with-libcfitsio-lib=${CURRENT_INSTALLED_DIR}/lib
)

vcpkg_build_make(BUILD_TARGET compile_all)

# Install manually because healpix has no install target
set(OBJ_DIR "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/auto")
file(GLOB_RECURSE HEALPIX_LIBS ${OBJ_DIR}/lib/*)
file(INSTALL ${HEALPIX_LIBS} DESTINATION "${CURRENT_PACKAGES_DIR}/lib")

file(GLOB_RECURSE HEALPIX_INCLUDES ${OBJ_DIR}/include/*)
file(INSTALL ${HEALPIX_INCLUDES} DESTINATION "${CURRENT_PACKAGES_DIR}/include")

file(GLOB_RECURSE HEALPIX_TOOLS ${OBJ_DIR}/bin/*)
file(INSTALL ${HEALPIX_TOOLS} DESTINATION "${CURRENT_PACKAGES_DIR}/tools/${PORT}")

if(EXISTS "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/")
    set(OBJ_DIR "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/auto")
    file(GLOB_RECURSE HEALPIX_LIBS ${OBJ_DIR}/lib/*)
    file(INSTALL ${HEALPIX_LIBS} DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
endif()

# Handle copyright
file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

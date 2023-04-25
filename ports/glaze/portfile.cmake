if("eigen" IN_LIST FEATURES)
  set(find_eigen_dep_patch "find-eigen-dep.patch")
else()
  unset(find_eigen_dep_patch)
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO stephenberry/glaze
    REF v1.2.1
    SHA512 7943056d02711fbabddeaa84918171d552b9d17fdfb19e44e3a21cced565ba5ba04cc69257720228f6fd3daff2d7fd4455b0b20165642ae23b6eaafb068102e7
    HEAD_REF main
    PATCHES
      ignore-dev-mode.patch
      ${find_eigen_dep_patch}
)

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}")
vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH "share/${PORT}")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
foreach(extension IN ITEMS "eigen" "jsonrpc")
  if(NOT "${extension}" IN_LIST FEATURES)
    file(REMOVE "${CURRENT_PACKAGES_DIR}/include/${extension}.hpp")
  endif()
endforeach()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

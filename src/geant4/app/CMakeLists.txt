file(GLOB SRC_FILES "*.cc" "src/*.cc")

set(LINK_LIBS dagsolid)
set(LINK_LIBS_EXTERN_NAMES)

include_directories(${CMAKE_CURRENT_LIST_DIR}/include)
include_directories(${CMAKE_SOURCE_DIR}/src/uwuw)
include_directories(${CMAKE_SOURCE_DIR}/src/geant4)

dagmc_install_exe(DagGeant4)

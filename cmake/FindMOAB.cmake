message("")

# Find MOAB cmake config file
# Only used to determine the location of the HDF5 with which MOAB was built
set(MOAB_SEARCH_DIRS)
file(GLOB MOAB_SEARCH_DIRS ${MOAB_SEARCH_DIRS} "${MOAB_DIR}/lib/cmake/MOAB")
if (MOAB_SEARCH_DIRS)
  string(REPLACE "\n" ";" MOAB_SEARCH_DIRS ${MOAB_SEARCH_DIRS})
endif ()
find_path(MOAB_CMAKE_CONFIG
  NAMES MOABConfig.cmake
  PATHS ${MOAB_SEARCH_DIRS}
  NO_DEFAULT_PATH
)
if (MOAB_CMAKE_CONFIG)
  set(MOAB_CMAKE_CONFIG ${MOAB_CMAKE_CONFIG}/MOABConfig.cmake)
  message(STATUS "MOAB_CMAKE_CONFIG: ${MOAB_CMAKE_CONFIG}")
else ()
  message(FATAL_ERROR "Could not find MOAB")
endif ()

# Find HDF5
include(${MOAB_CMAKE_CONFIG})
set(HDF5_ROOT ${HDF5_DIR})
set(ENV{PATH} "${HDF5_ROOT}:$ENV{PATH}")
set(CMAKE_FIND_LIBRARY_SUFFIXES ${SHARED_LIB_SUFFIX})
find_package(HDF5 REQUIRED)
set(HDF5_LIBRARIES_SHARED ${HDF5_LIBRARIES})
# CMake doesn't let you find_package(HDF5) twice so we have to do this instead
string(REPLACE ${SHARED_LIB_SUFFIX} ".a" HDF5_LIBRARIES_STATIC "${HDF5_LIBRARIES_SHARED}")
set(HDF5_LIBRARIES)

message(STATUS "HDF5_INCLUDE_DIRS: ${HDF5_INCLUDE_DIRS}")
message(STATUS "HDF5_LIBRARIES_SHARED: ${HDF5_LIBRARIES_SHARED}")
message(STATUS "HDF5_LIBRARIES_STATIC: ${HDF5_LIBRARIES_STATIC}")

include_directories(${HDF5_INCLUDE_DIRS})

# Find MOAB include directory
find_path(MOAB_INCLUDE_DIRS
  NAMES MBiMesh.hpp
  HINTS ${MOAB_DIR}
  PATHS ENV MOAB_DIR
  PATH_SUFFIXES include
  NO_DEFAULT_PATH
)
if (MOAB_INCLUDE_DIRS)
  get_filename_component(MOAB_INCLUDE_DIRS ${MOAB_INCLUDE_DIRS} ABSOLUTE)
endif ()

# Find MOAB library (shared)
set(CMAKE_FIND_LIBRARY_SUFFIXES ${SHARED_LIB_SUFFIX})
find_library(MOAB_LIBRARIES_SHARED
  NAMES MOAB
  HINTS ${MOAB_DIR}
  PATHS ENV MOAB_DIR
  PATH_SUFFIXES lib
  NO_DEFAULT_PATH
)
if (MOAB_LIBRARIES_SHARED)
  get_filename_component(MOAB_LIBRARIES_SHARED ${MOAB_LIBRARIES_SHARED} ABSOLUTE)
endif ()

# Find MOAB library (static)
set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
find_library(MOAB_LIBRARIES_STATIC
  NAMES MOAB
  HINTS ${MOAB_DIR}
  PATHS ENV MOAB_DIR
  PATH_SUFFIXES lib
  NO_DEFAULT_PATH
)
if (MOAB_LIBRARIES_STATIC)
  get_filename_component(MOAB_LIBRARIES_STATIC ${MOAB_LIBRARIES_STATIC} ABSOLUTE)
endif ()

message(STATUS "MOAB_INCLUDE_DIRS: ${MOAB_INCLUDE_DIRS}")
message(STATUS "MOAB_LIBRARIES_SHARED: ${MOAB_LIBRARIES_SHARED}")
message(STATUS "MOAB_LIBRARIES_STATIC: ${MOAB_LIBRARIES_STATIC}")

if (MOAB_INCLUDE_DIRS AND MOAB_LIBRARIES_SHARED AND MOAB_LIBRARIES_STATIC)
  message(STATUS "Found MOAB")
else ()
  message(FATAL_ERROR "Could not find MOAB")
endif ()

include_directories(${MOAB_INCLUDE_DIRS})

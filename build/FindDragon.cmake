# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
FindDragon
----------

IMPORTED Targets
^^^^^^^^^^^^^^^^

This module defined "prop_tgt:`IMPORTED` targets if Dragon has been found:

``Dragon::Dragon``
	The Main DragonEngine Library.

``Dragon::Tools``
	Provides installer source code and tests, if found. 

Result Variables
^^^^^^^^^^^^^^^^

This module defined the following variables:

``Dragon_FOUND``
	set to true if Dragon was found
``Dragon_INCLUDE_DIRS``
	include directories for Dragon 
``Dragon_LINK_LIBRARIES``
	link against these libraries to use Dragon
``Dragon_VERSION``
	value from ``dragon/predef/core.hpp`` or environment variables
``Dragon_Tools_FOUND``
	True, if the SDK has found the assist tools

The module will also define these cache variables:

``Dragon_INCLUDE_DIR``
	the Dragon include directory
``Dragon_LIBRARY``
	the path to the Dragon library
``Dragon_Tools_PATH``
	the path to Dragon's tools. 

Hints
^^^^^

The ``DG_SDK_PATH`` environment variable optionally specifies the 
location of the DragonEngine SDK root directory for the given 
archirecture. It is typically set either at installation, or by
sourcing the toplevel ``setup-env.sh`` scrupt of the 
DragonEngine SDK directory into the shell environment.

#]=======================================================================]

cmake_policy(PUSH)

find_package(Vulkan REQUIRED)
find_package(Boost REQUIRED)
find_package(OpenCL)

list(APPEND Dragon_INCLUDE_DIRS ${Vulkan_INCLUDE_DIRS} ${Dragon_INCLUDE_DIR} ${Boost_INCLUDE_DIRS})

list(APPEND Dragon_LINK_DIRECTORIES ${Boost_LIBRARY_DIRS})
list(APPEND Dragon_LINK_LIBRARIES ${Vulkan_LIBRARIES} ${Boost_LIBRARIES})

if(OpenCL_FOUND)
	list(APPEND Dragon_INCLUDE_DIRS ${OpenCL_INCLUDE_DIRS})
	list(APPEND Dragon_LINK_LIBRARIES ${OpenCL_LINK_LIBS})
endif()

set(_dragon_hint_binary_search_paths "$ENV{DG_SDK_PATH}/bin")
set(_dragon_hint_header_search_paths "$ENV{DG_SDK_PATH}/include")

find_path(Dragon_INCLUDE_DIR 
	NAMES dragon/dragon.hpp dragon/dragon-0.hpp dragon/dragon-00.hpp
	HINTS 
		${_dragon_hint_header_search_paths}
)

find_library(Dragon_LIBRARY
	NAMES dragon-1 dragon-0 dragon
	HINTS
		${_dragon_hint_binary_search_paths}
)

mark_as_advanced(Dragon_INCLUDE_DIR)
mark_as_advanced(Dragon_LIBRARY)

if(Dragon_INCLUDE_DIR AND Dragon_LIBRARY)
	set(Dragon_FOUND TRUE)
else()
	set(Dragon_FOUND FALSE)
endif()



if(Dragon_FOUND AND NOT TARGET Dragon::Dragon)
	add_library(Dragon::Dragon UNKNOWN IMPORTED)
	set_target_properties(Dragon::Dragon PROPERTIES
		IMPORTED_LOCATION "${Dragon_LIBRARY}"
	)
	list(APPEND Dragon_LINK_LIBRARIES ${Dragon_LIBRARY})
endif()

if(Dragon_FOUND AND Dragon_Firebreath_LIBRARY AND NOT TARGET Dragon::Firebreath)
	add_library(Dragon::Firebreath UNKNOWN IMPORTED)
	set_target_properties(Dragon::Firebreath PROPERTIES
		IMPORTED_LOCATION "${Dragon_Firebreath_LIBRARY}"
	)
	list(APPEND Dragon_LINK_LIBRARIES ${Dragon_Ironbreath_LIBRARY})
endif()

if(Dragon_FOUND AND Dragon_Ironbreath_LIBRARY AND NOT TARGET Dragon::Ironbreath)
	add_library(Dragon::Ironbreath UNKNOWN IMPORTED)
	set_target_properties(Dragon::Ironbreath PROPERTIES
		IMPORTED_LOCATION "${Dragon_Ironbreath_LIBRARY}"
	)
	list(APPEND Dragon_LINK_LIBRARIES ${Dragon_Ironbreath_LIBRARY})
endif()

if(Dragon_FOUND AND Dragon_Lightbreath_LIBRARY AND NOT TARGET Dragon::Lightbreath)
	add_library(Dragon::Lightbreath UNKNOWN IMPORTED)
	set_target_properties(Dragon::Lightbreath PROPERTIES
		IMPORTED_LOCATION "${Dragon_Lightbreath_LIBRARY}"
	)
	list(APPEND Dragon_LINK_LIBRARIES ${Dragon_Lightbreath_LIBRARY})
endif()

if(Dragon_FOUND AND Dragon_Streambreath_LIBRARY AND NOT TARGET Dragon::Streambreath)
	add_library(Dragon::Streambreath UNKNOWN IMPORTED)
	set_target_properties(Dragon::Streambreath PROPERTIES
		IMPORTED_LOCATION "${Dragon_Streambreath_LIBRARY}"
	)
	list(APPEND Dragon_LINK_LIBRARIES ${Dragon_Streambreath_LIBRARY})
endif()

if(Dragon_FOUND AND Dragon_Thunderbreath_LIBRARY AND NOT TARGET Dragon::Thunderbreath)
	add_library(Dragon::Thunderbreath UNKNOWN IMPORTED)
	set_target_properties(Dragon::Thunderbreath PROPERTIES
		IMPORTED_LOCATION "${Dragon_Thunderbreath_LIBRARY}"
	)
	list(APPEND Dragon_LINK_LIBRARIES ${Dragon_Thunderbreath_LIBRARY})
endif()

unset(_dragon_hint_binary_search_paths)
unset(_dragon_hint_header_search_paths)
cmake_policy(POP)
# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
FindDragon
----------

This module respects several optional COMPONENTS.
There are corresponding imported targets for each of these.

``Ironbreath``
	DragonEngine Extension for Apple OSX support through Metal.

``Tools``
	Assisting CMake macros for DragonEngine to use for simplicity.

IMPORTED Targets
^^^^^^^^^^^^^^^^

This module defined "prop_tgt:`IMPORTED` targets if Dragon has been found:

``Dragon::Dragon``
	The Main DragonEngine DLLs.

``Dragon::Headers``
	Provides just DragonEngine include paths, if found. No library is 
	included in this target. This can be useful for applications that
	load DragonEngine in a production environment.  

``Dragon::Ironbreath``
	The DragonEngine Apple OSX Extension, if found. May be found on 
	other systems for cross-compiling. 

``Dragon::Tools``
	Provides helpful macros and a few libraries, if found. 

Result Variables
^^^^^^^^^^^^^^^^

This module defined the following variables:

``Dragon_FOUND``
	set to true if Dragon was found
``Dragon_INCLUDE_DIRS``
	include directories for Dragon 
``Dragon_LIBRARIES``
	link against this library to use Dragon
``Dragon_VERSION``
	value from ``dragon/dg_backend.h`` or environment variables
``Dragon_tools_FOUND``
	True, if the SDK has found the assisting tools
``Dragon_ironbreath_FOUND``
	True, if the SDK has found Dragon's Ironbreath

The module will asl define these cache variables:

``Dragon_INCLUDE_DIR``
	the Dragon include directory
``Dragon_LIBRARY``
	the path to the Dragon library
``Dragon_ironbreath_LIBRARY``
	the path to Dragon's Ironbreath library

Hints
^^^^^

The ``DG_SDK_PATH`` environment variable optionally specifies the 
location of the DragonEngine SDK root directory for the given 
archirecture. It is typically set either at installation, or by
sourcing the toplevel ``setup-env.sh`` scrupt of the 
DragonEngine SDK directory into the shell environment.

#]=======================================================================]

cmake_policy(PUSH)
cmake_policy(SET CMP0057 NEW)

find_package(Vulkan REQUIRED)

if(WIN32)
	set(_Dragon_hint_library_search_paths
		"$ENV{DG_SDK_PATH}/bin"
	)
else()
	set(_Dragon_hint_library_search_paths
	"$ENV{DG_SDK_PATH}/bin32"
	)
endif()

set(_Dragon_hint_include_search_paths
	"$ENV{DG_SDK_PATH}/include"
)

find_path(Dragon_INCLUDE_DIR
	NAMES dragon/dragon.h
	HINTS
		${_Dragon_hint_include_search_paths}
)

find_library(Dragon_LIBRARY
	NAMES dragon
	HINTS
		${_Dragon_hint_library_search_paths}
)

find_library(Dragon_tools_LIBRARY
	NAMES dragon_tools
	HINTS
		${_Dragon_hint_library_search_paths}
)

find_library(Dragon_ironbreath_LIBRARY
	NAMES ironbreath
	HINTS
		${_Dragon_hint_library_search_paths}
)

if(Dragon_LIBRARY)
	set(Dragon_FOUND TRUE)
else()
	set(Dragon_FOUND FALSE)
endif()

if(Dragon_tools_LIBRARY)
	set(Dragon_tools_FOUND TRUE)
else()
	set(Dragon_tools_FOUND FALSE)
endif()

if(Dragon_ironbreath_LIBRARY)
	set(Dragon_ironbreath_FOUND TRUE)
else()
	set(Dragon_ironbreath_FOUND FALSE)
endif()

set(Dragon_VERSION "")
if(Dragon_INCLUDE_DIR)
	set(DRAGON_DG_BACKEND_H ${Dragon_INCLUDE_DIR}/dragon/dg_backend.h)
	if(EXISTS ${DRAGON_DG_BACKEND_H})
		file(STRINGS ${DRAGON_DG_BACKEND_H} DragonHeaderVersionLine REGEX "^#define DG_HEADER_VERSION")
		string(REGEX MATCHALL "[0-9]+" DragonHeaderVersion "${DragonHeaderVersionLine}")
		file(STRINGS  ${DRAGON_DG_BACKEND_H} DragonHeaderVersionLine2 REGEX "^#define DG_HEADER_VERSION_COMPLETE ")
    	string(REGEX MATCHALL "[0-9]+" DragonHeaderVersion2 "${DragonHeaderVersionLine2}")
		list(LENGTH DragonHeaderVersion2 _len)
		# versions follow the Vulkan standard, with an additional number in front of e.g. '0, 1, 2' instead of '1, 2'
		if(_len EQUAL 3)
			list(REMOVE_AT DragonHeaderVersion2 0)
		endif()
		list(APPEND DragonHeaderVersion2 ${DragonHeaderVersion})
		list(JOIN DragonHeaderVersion2 "." Dragon_VERSION)
	endif()
endif()

if(Dragon_FOUND AND NOT TARGET Dragon::Dragon)
	add_library(Dragon::Dragon UNKNOWN IMPORTED)
	set_target_properties(Dragon::Dragon PROPERTIES
		IMPORTED_LOCATION "${Dragon_LIBRARIES}"
		INTERFACE_INCLUDE_DIRECTORIES "{Dragon_INCLUDE_DIRECTORIES}"
	)
	target_link_libraries(Dragon::Dragon Vulkan::Vulkan GLFW)
endif()

if(Dragon_FOUND AND NOT TARGET Dragon::Headers)
	add_library(Dragon::Headers INTERFACE IMPORTED)
	set_target_properties(Dragon::Headers PROPERTIES
	  INTERFACE_INCLUDE_DIRECTORIES "${Dragon_INCLUDE_DIRS}"
	)
endif()

if(Dragon_FOUND AND Dragon_tools_LIBRARY AND NOT TARGET Dragon::Tools)
	add_library(Dragon::Tools STATIC IMPORTED)
	set_target_properties(Dragon::Tools PROPERTIES
		IMPORTED_LOCATION "${Dragon_tools_LIBRARY}"
		INTERFACE_INCLUDE_DIRECTORIES "${Dragon_INCLUDE_DIRS}"
	)
endif()

if(Dragon_FOUND AND Dragon_ironbreath_LIBRARY AND NOT TARGET Dragon::Ironbreath)
	add_library(Dragon::Ironbreath UNKNOWN IMPORTED)
	set_target_properties(Dragon::Ironbreath PROPERTIES
		IMPORTED_LOCATION "${Dragon_ironbreath_LIBRARY}"
		INTERFACE_INCLUDE_DIRECTORIES "${Dragon_INCLUDE_DIRS}"
	)
endif()

unset(_Dragon_hint_library_search_paths)
unset(_Dragon_hint_include_search_paths)

cmake_policy(POP)
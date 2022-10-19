# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
FindDragon
----------

This module respects several optional COMPONENTS.
There are corresponding imported targets for each of these.

``Firebreath``
	DragonEngine Extension for XR through OpenXR.

``Ironbreath``
	DragonEngine Extension for Apple OSX support through Metal.

``Lightbreath``
	DragonEngine Extension for networking using Boost.asio.

``Streambreath``
	DragonEngine Extension for Debug applications through Vulkan 
	Validation Layers.

``Tools``
	Assisting CMake macros for DragonEngine to use for simplicity.

IMPORTED Targets
^^^^^^^^^^^^^^^^

This module defined "prop_tgt:`IMPORTED` targets if Dragon has been found:

``Dragon::Dragon``
	The Main DragonEngine DLL.

``Dragon::Firebreath``
	The DragonEngine XR Extension, if found. Optional-installed piece. 

``Dragon::Ironbreath``
	The DragonEngine Apple OSX Extension, if found. May be found on 
	other systems for cross-compiling. 

``Dragon::Lightbreath``
	The DragonEngine Networking Extension, if found. May not be found on
	minimal distributions, or may be packaged into the main DLL.

``Dragon::Streambreath``
	The DragonEngine Debug Extension, if found. May be packaged into the 
	main library depending on version.

``Dragon::Thunderbreath``
	The DragonEngine GPU Acceleration Extension, if found. 

``Dragon::Tools``
	Provides installer source code and tests, if found. 

Result Variables
^^^^^^^^^^^^^^^^

This module defined the following variables:

``Dragon_FOUND``
	set to true if Dragon was found
``Dragon_INCLUDE_DIRS``
	include directories for Dragon 
``Dragon_LINK_DIRECTORIES``
	link against these directories to use Dragon
``Dragon_LINK_LIBRARIES``
	link against these libraries to use Dragon
``Dragon_VERSION``
	value from ``dragon/dg_backend.h`` or environment variables
``Dragon_Tools_FOUND``
	True, if the SDK has found the assist tools
``Dragon_Firebreath_FOUND``
	True, if the SDKmhas found Dragon's Firebreath library
``Dragon_Ironbreath_FOUND``
	True, if the SDK has found Dragon's Ironbreath library
``Dragon_Lightbreath_FOUND``
	True, if the SDK has found Dragon's Lightbreath library
``Dragon_Streambreath_FOUND``
	True, if the SDK has found Dragon's Streambreath library
``Dragon_Thunderbreath_FOUND``
	True, if the SDK has found Dragon's Thunderbreath library

The module will also define these cache variables:

``Dragon_INCLUDE_DIR``
	the Dragon include directory
``Dragon_LIBRARY``
	the path to the Dragon library
``Dragon_Firebreath_LIBRARY``
	the path to Dragon's Firebreath library
``Dragon_Ironbreath_LIBRARY``
	the path to Dragon's Ironbreath library
``Dragon_Lightbreath_LIBRARY``
	the path to Dragon's Lightbreath library
``Dragon_Streambreath_LIBRARY``
	the path to Dragon's Streambreath library
``Dragon_Thunderbreath_LIBRARY``
	the path to Dragon's Thunderbreath library
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

set(_dragon_hint_binary_search_paths "$ENV{DG_SDK_PATH}/bin")
set(_dragon_hint_header_search_paths "$ENV{DG_SDK_PATH}/include")

find_path(Dragon_INCLUDE_DIR 
	NAMES dragon/dragon.hpp dragon/dragon-0.hpp dragon/dragon-00.hpp
	HINTS 
		${_dragon_hint_header_search_paths}
)
mark_as_advanced(Dragon_INCLUDE_DIR)

find_library(Dragon_LIBRARY
	NAMES dragon-1 dragon-0 dragon
	HINTS
		${_dragon_hint_binary_search_paths}
)
mark_as_advanced(Dragon_LIBRARY)

find_library(Dragon_Firebreath_LIBRARY
	NAMES firebreath
	HINTS
		${_dragon_hint_binary_search_paths}
)
mark_as_advanced(Dragon_Firebreath_LIBRARY)

find_library(Dragon_Ironbreath_LIBRARY
	NAMES ironbreath
	HINTS
		${_dragon_hint_binary_search_paths}
)
mark_as_advanced(Dragon_Ironbreath_LIBRARY)

find_library(Dragon_Lightbreath_LIBRARY
	NAMES lightbreath
	HINTS
		${_dragon_hint_binary_search_paths}
)
mark_as_advanced(Dragon_lightbreath_LIBRARY)

find_library(Dragon_Streambreath_LIBRARY
	NAMES streambreath
	HINTS
		${_dragon_hint_binary_search_paths}
)
mark_as_advanced(Dragon_Streambreath_LIBRARY)

find_library(Dragon_Thunderbreath_LIBRARY
	NAMES thunderbreath
	HINTS
		${_dragon_hint_binary_search_paths}
)
mark_as_advanced(Dragon_Thunderbreath_LIBRARY)

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

if(Vulkan_GLSLangValidator_FOUND)

unset(_dragon_hint_binary_search_paths)
unset(_dragon_hint_header_search_paths)
cmake_policy(POP)
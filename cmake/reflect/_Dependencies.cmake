# This file will be regenerated by `mulle-sourcetree-to-cmake` via
# `mulle-sde reflect` and any edits will be lost.
#
# This file will be included by cmake/share/Files.cmake
#
# Disable generation of this file with:
#
# mulle-sde environment set MULLE_SOURCETREE_TO_CMAKE_DEPENDENCIES_FILE DISABLE
#
if( MULLE_TRACE_INCLUDE)
   message( STATUS "# Include \"${CMAKE_CURRENT_LIST_FILE}\"" )
endif()

#
# Generated from sourcetree: A64E27DF-2A93-43B7-8AA6-DF492E13AABC;mulle-atinit;no-cmake-searchpath,no-descend,no-dynamic-link,no-import,no-intermediate-link,no-public,no-singlephase;
# Disable with : `mulle-sourcetree mark mulle-atinit no-link`
# Disable for this platform: `mulle-sourcetree mark mulle-atinit no-cmake-platform-${MULLE_UNAME}`
# Disable for a sdk: `mulle-sourcetree mark mulle-atinit no-cmake-sdk-<name>`
#
if( NOT MULLE_ATINIT_LIBRARY)
   if( DEPENDENCY_IGNORE_SYSTEM_LIBARIES)
      find_library( MULLE_ATINIT_LIBRARY NAMES
         ${CMAKE_STATIC_LIBRARY_PREFIX}mulle-atinit${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX}
         ${CMAKE_STATIC_LIBRARY_PREFIX}mulle-atinit${CMAKE_STATIC_LIBRARY_SUFFIX}
         NO_CMAKE_SYSTEM_PATH NO_SYSTEM_ENVIRONMENT_PATH
      )
   else()
      find_library( MULLE_ATINIT_LIBRARY NAMES
         ${CMAKE_STATIC_LIBRARY_PREFIX}mulle-atinit${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX}
         ${CMAKE_STATIC_LIBRARY_PREFIX}mulle-atinit${CMAKE_STATIC_LIBRARY_SUFFIX}
      )
   endif()
   message( STATUS "MULLE_ATINIT_LIBRARY is ${MULLE_ATINIT_LIBRARY}")
   #
   # The order looks ascending, but due to the way this file is read
   # it ends up being descending, which is what we need.
   #
   if( MULLE_ATINIT_LIBRARY)
      #
      # Add MULLE_ATINIT_LIBRARY to STARTUP_ALL_LOAD_DEPENDENCY_LIBRARIES list.
      # Disable with: `mulle-sourcetree mark mulle-atinit no-cmake-add`
      #
      list( APPEND STARTUP_ALL_LOAD_DEPENDENCY_LIBRARIES ${MULLE_ATINIT_LIBRARY})
      #
      # Inherit information from dependency.
      # Encompasses: no-cmake-searchpath,no-cmake-dependency,no-cmake-loader
      # Disable with: `mulle-sourcetree mark mulle-atinit no-cmake-inherit`
      #
      # temporarily expand CMAKE_MODULE_PATH
      get_filename_component( _TMP_MULLE_ATINIT_ROOT "${MULLE_ATINIT_LIBRARY}" DIRECTORY)
      get_filename_component( _TMP_MULLE_ATINIT_ROOT "${_TMP_MULLE_ATINIT_ROOT}" DIRECTORY)
      #
      #
      # Search for "Definitions.cmake" and "DependenciesAndLibraries.cmake" to include.
      # Disable with: `mulle-sourcetree mark mulle-atinit no-cmake-dependency`
      #
      foreach( _TMP_MULLE_ATINIT_NAME "mulle-atinit")
         set( _TMP_MULLE_ATINIT_DIR "${_TMP_MULLE_ATINIT_ROOT}/include/${_TMP_MULLE_ATINIT_NAME}/cmake")
         # use explicit path to avoid "surprises"
         if( IS_DIRECTORY "${_TMP_MULLE_ATINIT_DIR}")
            list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_MULLE_ATINIT_DIR}")
            #
            include( "${_TMP_MULLE_ATINIT_DIR}/DependenciesAndLibraries.cmake" OPTIONAL)
            #
            list( REMOVE_ITEM CMAKE_MODULE_PATH "${_TMP_MULLE_ATINIT_DIR}")
            #
            unset( MULLE_ATINIT_DEFINITIONS)
            include( "${_TMP_MULLE_ATINIT_DIR}/Definitions.cmake" OPTIONAL)
            list( APPEND INHERITED_DEFINITIONS ${MULLE_ATINIT_DEFINITIONS})
            break()
         else()
            message( STATUS "${_TMP_MULLE_ATINIT_DIR} not found")
         endif()
      endforeach()
      #
      # Search for "MulleObjCLoader+<name>.h" in include directory.
      # Disable with: `mulle-sourcetree mark mulle-atinit no-cmake-loader`
      #
      if( NOT NO_INHERIT_OBJC_LOADERS)
         foreach( _TMP_MULLE_ATINIT_NAME "mulle-atinit")
            set( _TMP_MULLE_ATINIT_FILE "${_TMP_MULLE_ATINIT_ROOT}/include/${_TMP_MULLE_ATINIT_NAME}/MulleObjCLoader+${_TMP_MULLE_ATINIT_NAME}.h")
            if( EXISTS "${_TMP_MULLE_ATINIT_FILE}")
               list( APPEND INHERITED_OBJC_LOADERS ${_TMP_MULLE_ATINIT_FILE})
               break()
            endif()
         endforeach()
      endif()
   else()
      # Disable with: `mulle-sourcetree mark mulle-atinit no-require-link`
      message( FATAL_ERROR "MULLE_ATINIT_LIBRARY was not found")
   endif()
endif()


#
# Generated from sourcetree: BBA957A1-0339-4EEB-8E7D-EC05F13234F1;mulle-atexit;no-cmake-searchpath,no-descend,no-dynamic-link,no-import,no-intermediate-link,no-public,no-singlephase;
# Disable with : `mulle-sourcetree mark mulle-atexit no-link`
# Disable for this platform: `mulle-sourcetree mark mulle-atexit no-cmake-platform-${MULLE_UNAME}`
# Disable for a sdk: `mulle-sourcetree mark mulle-atexit no-cmake-sdk-<name>`
#
if( NOT MULLE_ATEXIT_LIBRARY)
   if( DEPENDENCY_IGNORE_SYSTEM_LIBARIES)
      find_library( MULLE_ATEXIT_LIBRARY NAMES
         ${CMAKE_STATIC_LIBRARY_PREFIX}mulle-atexit${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX}
         ${CMAKE_STATIC_LIBRARY_PREFIX}mulle-atexit${CMAKE_STATIC_LIBRARY_SUFFIX}
         NO_CMAKE_SYSTEM_PATH NO_SYSTEM_ENVIRONMENT_PATH
      )
   else()
      find_library( MULLE_ATEXIT_LIBRARY NAMES
         ${CMAKE_STATIC_LIBRARY_PREFIX}mulle-atexit${CMAKE_DEBUG_POSTFIX}${CMAKE_STATIC_LIBRARY_SUFFIX}
         ${CMAKE_STATIC_LIBRARY_PREFIX}mulle-atexit${CMAKE_STATIC_LIBRARY_SUFFIX}
      )
   endif()
   message( STATUS "MULLE_ATEXIT_LIBRARY is ${MULLE_ATEXIT_LIBRARY}")
   #
   # The order looks ascending, but due to the way this file is read
   # it ends up being descending, which is what we need.
   #
   if( MULLE_ATEXIT_LIBRARY)
      #
      # Add MULLE_ATEXIT_LIBRARY to STARTUP_ALL_LOAD_DEPENDENCY_LIBRARIES list.
      # Disable with: `mulle-sourcetree mark mulle-atexit no-cmake-add`
      #
      list( APPEND STARTUP_ALL_LOAD_DEPENDENCY_LIBRARIES ${MULLE_ATEXIT_LIBRARY})
      #
      # Inherit information from dependency.
      # Encompasses: no-cmake-searchpath,no-cmake-dependency,no-cmake-loader
      # Disable with: `mulle-sourcetree mark mulle-atexit no-cmake-inherit`
      #
      # temporarily expand CMAKE_MODULE_PATH
      get_filename_component( _TMP_MULLE_ATEXIT_ROOT "${MULLE_ATEXIT_LIBRARY}" DIRECTORY)
      get_filename_component( _TMP_MULLE_ATEXIT_ROOT "${_TMP_MULLE_ATEXIT_ROOT}" DIRECTORY)
      #
      #
      # Search for "Definitions.cmake" and "DependenciesAndLibraries.cmake" to include.
      # Disable with: `mulle-sourcetree mark mulle-atexit no-cmake-dependency`
      #
      foreach( _TMP_MULLE_ATEXIT_NAME "mulle-atexit")
         set( _TMP_MULLE_ATEXIT_DIR "${_TMP_MULLE_ATEXIT_ROOT}/include/${_TMP_MULLE_ATEXIT_NAME}/cmake")
         # use explicit path to avoid "surprises"
         if( IS_DIRECTORY "${_TMP_MULLE_ATEXIT_DIR}")
            list( INSERT CMAKE_MODULE_PATH 0 "${_TMP_MULLE_ATEXIT_DIR}")
            #
            include( "${_TMP_MULLE_ATEXIT_DIR}/DependenciesAndLibraries.cmake" OPTIONAL)
            #
            list( REMOVE_ITEM CMAKE_MODULE_PATH "${_TMP_MULLE_ATEXIT_DIR}")
            #
            unset( MULLE_ATEXIT_DEFINITIONS)
            include( "${_TMP_MULLE_ATEXIT_DIR}/Definitions.cmake" OPTIONAL)
            list( APPEND INHERITED_DEFINITIONS ${MULLE_ATEXIT_DEFINITIONS})
            break()
         else()
            message( STATUS "${_TMP_MULLE_ATEXIT_DIR} not found")
         endif()
      endforeach()
      #
      # Search for "MulleObjCLoader+<name>.h" in include directory.
      # Disable with: `mulle-sourcetree mark mulle-atexit no-cmake-loader`
      #
      if( NOT NO_INHERIT_OBJC_LOADERS)
         foreach( _TMP_MULLE_ATEXIT_NAME "mulle-atexit")
            set( _TMP_MULLE_ATEXIT_FILE "${_TMP_MULLE_ATEXIT_ROOT}/include/${_TMP_MULLE_ATEXIT_NAME}/MulleObjCLoader+${_TMP_MULLE_ATEXIT_NAME}.h")
            if( EXISTS "${_TMP_MULLE_ATEXIT_FILE}")
               list( APPEND INHERITED_OBJC_LOADERS ${_TMP_MULLE_ATEXIT_FILE})
               break()
            endif()
         endforeach()
      endif()
   else()
      # Disable with: `mulle-sourcetree mark mulle-atexit no-require-link`
      message( FATAL_ERROR "MULLE_ATEXIT_LIBRARY was not found")
   endif()
endif()

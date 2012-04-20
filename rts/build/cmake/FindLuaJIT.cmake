# Find the LuaJIT includes and library
#
# LUAJIT_INCLUDE_DIR - where to find lua.h
# LUAJIT_LIBRARIES - List of fully qualified libraries to link against
# LUAJIT_FOUND - Set to TRUE if found

# Copyright (c) 2007, Pau Garcia i Quiles, <pgquiles@elpauer.org>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

# modified for LuaJIT @ 2012, jK

IF(LUAJIT_INCLUDE_DIR AND LUAJIT_LIBRARY)
	SET(LUAJIT_FIND_QUIETLY TRUE)
ENDIF(LUAJIT_INCLUDE_DIR AND LUAJIT_LIBRARY)

FIND_PATH(LUAJIT_INCLUDE_DIR lua.h
	HINTS
	$ENV{LUAJIT_DIR}
	PATH_SUFFIXES include/luajit51 include/luajit5.1 include/luajit-2.0
	PATHS
	~/Library/Frameworks
	/Library/Frameworks
	/usr/local
	/usr
	/sw # Fink
	/opt/local # DarwinPorts
	/opt/csw # Blastwave
	/opt
)

# the "lua" causes that system installed lua library is still preferred to Spring's internal synced Lua
SET(LUAJIT_NAMES luajit luajit-5.1 lua lua51)
FIND_LIBRARY(LUAJIT_LIBRARY NAMES ${LUAJIT_NAMES})

IF(LUAJIT_INCLUDE_DIR AND LUAJIT_LIBRARY)
	SET(LUAJIT_FOUND TRUE)
	INCLUDE(CheckLibraryExists)
	CHECK_LIBRARY_EXISTS(${LUAJIT_LIBRARY} lua_close "" LUAJIT_NEED_PREFIX)
	CHECK_LIBRARY_EXISTS(${LUAJIT_LIBRARY} luaL_argerror "" LUAJIT_NEED_PREFIX_)
ELSE(LUAJIT_INCLUDE_DIR AND LUAJIT_LIBRARY)
	SET(LUAJIT_FOUND FALSE)
ENDIF (LUAJIT_INCLUDE_DIR AND LUAJIT_LIBRARY)

IF(LUAJIT_FOUND)
	IF (NOT LUAJIT_FIND_QUIETLY)
		MESSAGE(STATUS "Found Lua library: ${LUAJIT_LIBRARY}")
		MESSAGE(STATUS "Found Lua headers: ${LUAJIT_INCLUDE_DIR}")
	ENDIF (NOT LUAJIT_FIND_QUIETLY)
ELSE(LUAJIT_FOUND)
	IF(LUAJIT_FIND_REQUIRED)
		MESSAGE(FATAL_ERROR "Could NOT find Lua")
	ENDIF(LUAJIT_FIND_REQUIRED)
ENDIF(LUAJIT_FOUND)

MARK_AS_ADVANCED(LUAJIT_INCLUDE_DIR LUAJIT_LIBRARY)
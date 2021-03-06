cmake_minimum_required(VERSION 2.8.8 FATAL_ERROR)
project(ParaViewCustomApplication)

FIND_PACKAGE(Qt4)

message(STATUS ${CMAKE_MODULE_PATH})

# set (ParaView_DIR "/Users/frederikriedel/Desktop/ParaView Stupro/ParaVIew XCode/Build/"
#       CACHE PATH
#       "Path to ParaView build")

set(CMAKE_MODULE_PATH "${ParaView_DIR};${CMAKE_MODULE_PATH}")

if(EXISTS "${ParaView_DIR}/ParaViewConfig.cmake" OR EXISTS "${ParaView_DIR}/paraview-config.cmake")
   find_package(ParaView REQUIRED)
else()
   message (FATAL_ERROR "ParaView not found, enter the path to a ParaView build dir in ParaView_DIR")
endif()

include(${PARAVIEW_USE_FILE})
if (NOT PARAVIEW_BUILD_QT_GUI)
  message(FATAL_ERROR
    "PV Custom App requires PARAVIEW_BUILD_QT_GUI to be enabled. "
    "Please rebuild ParaView (or point to a different build of ParaView) "
    "with PARAVIEW_BUILD_QT_GUI set to TRUE")
endif()

include(ParaViewBranding)

#------------------------------------------------------------------------------
# Add extra library containing custom code for the client.
IF (PARAVIEW_QT_VERSION VERSION_GREATER "4")
  QT5_WRAP_CPP(MOC_BUILT_SOURCES
    src/myMainWindow.h)
  QT5_WRAP_UI(UI_BUILT_SOURCES
    src/myMainWindow.ui)
ELSE ()
  QT4_WRAP_CPP(MOC_BUILT_SOURCES
    src/myMainWindow.h)
  QT4_WRAP_UI(UI_BUILT_SOURCES
    src/myMainWindow.ui)
ENDIF ()

SOURCE_GROUP("Generated" FILES
  ${MOC_BUILT_SOURCES}
  ${UI_BUILT_SOURCES}
)

SET(ParaView_SOURCE_FILES
  src/myMainWindow.cxx
  src/myMainWindow.h
  ${MOC_BUILT_SOURCES}
  ${UI_BUILT_SOURCES})

INCLUDE_DIRECTORIES(
  ${CMAKE_CURRENT_SOURCE_DIR}/src
  ${CMAKE_CURRENT_BINARY_DIR})

build_paraview_client(paraview_revised
  TITLE "ParaView (ReVisEd)"
  ORGANIZATION  "Kitware Inc."
  VERSION_MAJOR 1
  VERSION_MINOR 1
  VERSION_PATCH 1
  PVMAIN_WINDOW myMainWindow
  PVMAIN_WINDOW_INCLUDE myMainWindow.h
  GUI_CONFIGURATION_XMLS
    ${CMAKE_CURRENT_SOURCE_DIR}/src/ParaViewSources.xml
    ${CMAKE_CURRENT_SOURCE_DIR}/src/ParaViewFilters.xml
    ${CMAKE_CURRENT_SOURCE_DIR}/src/ParaViewWriters.xml
  SOURCES ${ParaView_SOURCE_FILES}
)

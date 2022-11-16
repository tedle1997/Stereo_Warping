cmake_minimum_required (VERSION 3.0)
project (Stereo_Warping)

find_package(OpenGL REQUIRED)

if( CMAKE_BINARY_DIR STREQUAL CMAKE_SOURCE_DIR )
    message( FATAL_ERROR "Please select another Build Directory ! (and give it a clever name, like bin_Visual2012_64bits/)" )
endif()
if( CMAKE_SOURCE_DIR MATCHES " " )
	message( "Your Source Directory contains spaces. If you experience problems when compiling, this can be the cause." )
endif()
if( CMAKE_BINARY_DIR MATCHES " " )
	message( "Your Build Directory contains spaces. If you experience problems when compiling, this can be the cause." )
endif()

add_subdirectory (external)

if(INCLUDE_DISTRIB)
	add_subdirectory(distrib)
endif(INCLUDE_DISTRIB)

include_directories(
	# external/glfw-3.3.8/include/
	external/glfw-3.1.2/include/
	external/glm-0.9.7.1/
	external/glew-1.13.0/include/
	common/
	shaders/
	.
)

set(ALL_LIBS
    ${OPENGL_LIBRARY}
	glfw
	GLEW_1130
)

add_definitions(
	-DTW_STATIC
	-DTW_NO_LIB_PRAGMA
	-DTW_NO_DIRECT3D
	-DGLEW_STATIC
	-D_CRT_SECURE_NO_WARNINGS
)

add_executable(StereoWarping
    StereoWarping/StereoWarping.cpp
    
	common/controls.cpp
	common/controls.hpp
	common/objloader.cpp
	common/objloader.hpp
	common/quaternion_utils.cpp
	common/quaternion_utils.hpp
	common/shader.cpp
	common/shader.hpp
	common/stb_image.cpp
	common/stb_image.h
	common/tangentspace.cpp
	common/tangentspace.hpp
	common/text2D.cpp
	common/text2D.hpp
	common/texture.cpp
	common/texture.hpp
	
	shaders/TFVertex.glsl
	shaders/TFGeometry.glsl
	shaders/AdapGridVertex.glsl
	shaders/AdapGridGeometry.glsl
	shaders/TransformVertexShader.glsl
	shaders/SimpleFragmentShader.glsl
	shaders/DisparityVertexShader.glsl
	shaders/DisparityFragmentShader.glsl
	shaders/MaxPyrVertex.glsl
	shaders/MaxPyrFragmentShader.glsl
	shaders/WarpingVertex.glsl
	shaders/WarpingFragment.glsl
	shaders/OGvertex.glsl
	shaders/OGfragment.glsl
	shaders/MinPyrVertex.glsl
	shaders/MinPyrFragment.glsl
	shaders/PlainVertex.glsl
	shaders/PlainFragment.glsl
	
)

target_link_libraries(StereoWarping
    ${ALL_LIBS}
)

# Xcode and Visual working directories
set_target_properties(StereoWarping PROPERTIES XCODE_ATTRIBUTE_CONFIGURATION_BUILD_DIR "${CMAKE_CURRENT_SOURCE_DIR}/StereoWarping/")
# create_target_launcher(StereoWarping WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/StereoWarping/")

SOURCE_GROUP(common REGULAR_EXPRESSION ".*/common/.*" )
SOURCE_GROUP(shaders REGULAR_EXPRESSION ".*/shaders/.*" )

if (NOT ${CMAKE_GENERATOR} MATCHES "Xcode" )
add_custom_command(
   TARGET StereoWarping POST_BUILD
   COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_CFG_INTDIR}/StereoWarping${CMAKE_EXECUTABLE_SUFFIX}" "${CMAKE_CURRENT_SOURCE_DIR}/StereoWarping/"
)
elseif (${CMAKE_GENERATOR} MATCHES "Xcode" )

endif (NOT ${CMAKE_GENERATOR} MATCHES "Xcode" )
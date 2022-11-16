#ifndef SHADER_HPP
#define SHADER_HPP

GLuint LoadShaders(const char * vertex_file_path,const char * fragment_file_path);
GLuint LoadShadersGeometry(const char * vertex_file_path,const char * fragment_file_path, const char * geometry_file_path);
GLuint LoadShadersTransformFeedback(const char * vertex_file_path,const char * fragment_file_path, const char * geometry_file_path);

#endif

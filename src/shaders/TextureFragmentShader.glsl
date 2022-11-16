#version 460 core

in vec2 UV;

out vec3 color;

uniform sampler2D renderedTexture;
uniform sampler2D adaptivegridTexture;

void main(){
    color = texture( renderedTexture, UV).xyz;
}

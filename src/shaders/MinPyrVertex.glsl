#version 460 core
layout (location = 0) in vec3 aPos;
out vec2 UV;

void main()
{
    gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0);
    UV = (aPos.xy+vec2(1,1))/2.0;
}

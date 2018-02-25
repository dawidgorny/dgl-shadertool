#version 330
#ifdef GL_ARB_shading_language_420pack
#extension GL_ARB_shading_language_420pack : require
#endif

uniform vec4 params[4];
layout(location = 0) in vec4 position;
out vec3 vNormal;
layout(location = 1) in vec3 normal;

void main()
{
    gl_Position = mat4(params[0], params[1], params[2], params[3]) * position;
    vNormal = normal;
}


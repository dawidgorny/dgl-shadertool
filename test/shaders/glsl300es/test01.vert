#version 300 es

uniform vec4 params[4];
layout(location = 0) in vec4 position;
out vec3 vNormal;
layout(location = 1) in vec3 normal;

void main()
{
    gl_Position = mat4(params[0], params[1], params[2], params[3]) * position;
    vNormal = normal;
}


#version 100

uniform vec4 params[4];
attribute vec4 position;
varying vec3 vNormal;
attribute vec3 normal;

void main()
{
    gl_Position = mat4(params[0], params[1], params[2], params[3]) * position;
    vNormal = normal;
}


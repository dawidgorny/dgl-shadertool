#version 300 es
precision mediump float;
precision highp int;

out vec4 fragColor;
in vec4 color;

void main()
{
    fragColor = color;
}


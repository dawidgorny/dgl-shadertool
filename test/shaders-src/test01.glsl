@vs MyShaderVS
layout(std140) uniform params
{
  mat4 uMVP;
};

in vec4 position;
in vec3 normal;
out vec3 vNormal;

void main()
{
  gl_Position = uMVP * position;
  vNormal = normal;
}
@end

@fs MyShaderFS
precision mediump float;
in vec4 color;
out vec4 fragColor;
void main() {
  fragColor = color;
}
@end

@program glsl300es MyShader
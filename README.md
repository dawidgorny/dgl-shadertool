# dgl-shadertool

Set of tools / a pipeline for shader code transpilation: GLSL -> (SPIRV) -> GLSL/HLSL/MLSL

## Build

Works only on **macOS**.

```
brew install glslang
```

```
./build.sh
```

## Usage

```
./bin/glslcompile.sh ./test/shaders-src/test01.glsl ./test/shaders glsl100
```

## Example shader

```glsl
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

@program glsl300es MyShader MyShaderVS MyShaderFS
```

`@vf` `@fs` are followed by the name of a block, but the name is optional.

`@program` tag is optional, as well as its parameters can be skipped.

## Credits

`dgl-spirv-cross` is based on the code from [oryol-shdc](https://github.com/floooh/oryol-tools/blob/master/src/oryol-shdc/) by Andre Weissflog ( [@floooh](https://github.com/floooh) )

Shader .glsl file structure is taken from [oryol-shdc](https://github.com/floooh/oryol-tools/blob/master/src/oryol-shdc/), but parser is my own, so it may behave differently.

Main tools used in the pipeline:

 * [glslang](https://github.com/KhronosGroup/glslang)
 * [Khronos SPIRV-Cross](https://github.com/KhronosGroup/SPIRV-Cross)

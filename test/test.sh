#!/bin/sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$DIR/../bin/glslcompile.sh $DIR/shaders-src/test01.glsl $DIR/shaders glsl100    # WebGL
$DIR/../bin/glslcompile.sh $DIR/shaders-src/test01.glsl $DIR/shaders glsl300es  # WebGL2
$DIR/../bin/glslcompile.sh $DIR/shaders-src/test01.glsl $DIR/shaders glsl330    # OpenGL
$DIR/../bin/glslcompile.sh $DIR/shaders-src/test01.glsl $DIR/shaders hlsl       # HLSL / DirectX11
$DIR/../bin/glslcompile.sh $DIR/shaders-src/test01.glsl $DIR/shaders metal      # Metal

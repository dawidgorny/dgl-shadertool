#!/bin/sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

GLSL_FILE=$1
SHD_OUT_DIR=$2
SHD_OUT_LANG=$3

SHD_SRC_DIR=$(dirname "$GLSL_FILE")
SHD_SRC_DIR="$( cd $SHD_SRC_DIR && pwd )"
SHD_FILENAME=$(basename "$GLSL_FILE")
SHD_NAME="${SHD_FILENAME%.*}"
SHD_SRC_FILE=$SHD_SRC_DIR/$SHD_FILENAME

GLSL_TO_STAGES_EXEC=$DIR/glsl_to_stages
GLSLC_EXEC=glslangValidator
SPIRV_CROSS_EXEC=$DIR/dgl-spirv-cross

function glsl_stage_to_any () {
  local _SHD_STAGE=$1
  local _SHD_IN=$2
  local _SHD_SPV=$3
  local _SHD_OUT=$4
  local _SHD_SRC_LANG=$5
  local _SHD_OUT_LANG=$6

  echo "--- " $_SHD_IN
  $GLSLC_EXEC -s -G -o $_SHD_SPV $_SHD_IN

  echo " -> " $_SHD_SPV " -> " $_SHD_OUT_LANG "..."

  $SPIRV_CROSS_EXEC $_SHD_SPV $_SHD_OUT_LANG $_SHD_OUT
}

function glsl_to_any () {
  local _SHD_SRC_FILE=$1
  local _SHD_NAME=$2
  local _SHD_OUT_DIR=$3
  local _SHD_OUT_LANG=$4

  # Split .glsl shader file into .vert and .frag
  $GLSL_TO_STAGES_EXEC $_SHD_SRC_FILE $_SHD_OUT_DIR/$_SHD_NAME.vert $_SHD_OUT_DIR/$_SHD_NAME.frag

  local _SHD_SRC_LANG="300es" # TODO: get from source .glsl file

  # create output directory if doesnt exist
  mkdir -p $_SHD_OUT_DIR/$_SHD_OUT_LANG

  # vert
  local _SHD_STAGE="vert"
  local _SHD_IN=$_SHD_OUT_DIR/$_SHD_NAME.$_SHD_STAGE
  local _SHD_SPV=$_SHD_OUT_DIR/$_SHD_NAME.$_SHD_STAGE.spv
  local _SHD_OUT=$_SHD_OUT_DIR/$_SHD_OUT_LANG/$_SHD_NAME.$_SHD_STAGE

  glsl_stage_to_any $_SHD_STAGE $_SHD_IN $_SHD_SPV $_SHD_OUT $_SHD_SRC_LANG $_SHD_OUT_LANG

  # frag
  local _SHD_STAGE="frag"
  local _SHD_IN=$_SHD_OUT_DIR/$_SHD_NAME.$_SHD_STAGE
  local _SHD_SPV=$_SHD_OUT_DIR/$_SHD_NAME.$_SHD_STAGE.spv
  local _SHD_OUT=$_SHD_OUT_DIR/$_SHD_OUT_LANG/$_SHD_NAME.$_SHD_STAGE

  glsl_stage_to_any $_SHD_STAGE $_SHD_IN $_SHD_SPV $_SHD_OUT $_SHD_SRC_LANG $_SHD_OUT_LANG

  # clean up
  rm $_SHD_OUT_DIR/$_SHD_NAME.vert.spv
  rm $_SHD_OUT_DIR/$_SHD_NAME.frag.spv
  rm $_SHD_OUT_DIR/$_SHD_NAME.vert
  rm $_SHD_OUT_DIR/$_SHD_NAME.frag
}

glsl_to_any $SHD_SRC_FILE $SHD_NAME $SHD_OUT_DIR $SHD_OUT_LANG

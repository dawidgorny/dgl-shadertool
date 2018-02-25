#!/bin/sh

g++ -std=c++11 -L./3rd/SPIRV-Cross -L./3rd/cJSON/build -lspirv-cross -lcjson -I./3rd/SPIRV-Cross -I./3rd/cJSON dgl-spirv-cross.cpp -o ./bin/dgl-spirv-cross
# g++ -std=c++11 -L./3rd/SPIRV-Cross -L./3rd/cJSON/build -lspirv-cross -lcjson -I./3rd/SPIRV-Cross -I./3rd/cJSON dgl-spirv-cross.cpp -o ./bin/dgl-spirv-cross_d -g # DEBUG

npm install

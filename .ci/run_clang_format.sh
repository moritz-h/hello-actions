#!/bin/bash

echo "::error file=main.cpp,line=5,col=1,endColumn=19::Hello"
clang-format-12 --version
clang-format-12 main.cpp | diff --color=always -u main.cpp -
#clang-format-12 -i main.cpp

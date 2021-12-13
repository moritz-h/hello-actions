#!/bin/bash

echo "Hello"
clang-format-12 --version
clang-format-12 main.cpp | diff --color=always -u main.cpp -
#clang-format-12 -i main.cpp

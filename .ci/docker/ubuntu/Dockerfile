# MegaMol Ubuntu CI Environment

FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
  build-essential \
  cmake \
  ninja-build \
  git \
  clang \
# omp with clang:
  libomp-dev \
# vcpkg:
  curl zip unzip tar \
# glfw:
  xorg-dev \
# gmp:
  autoconf libtool \
# mpfr:
  autoconf-archive \
# glslang:
  python3 \
# vislib:
  libncurses-dev \
# GL/glu.h:
  libglu1-mesa-dev \
# plugin image_gl:
  libjpeg-dev \
  && rm -rf /var/lib/apt/lists/*

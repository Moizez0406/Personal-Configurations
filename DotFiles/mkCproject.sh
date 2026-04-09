#!/bin/bash
# mkproject.sh — C++ project template generator
# Usage: mkproject <project_name>
# Add to ~/.bashrc: alias mkproject='bash ~/scripts/mkproject.sh'

set -e # exit on error

# --- validate input ---
if [ -z "$1" ]; then
  echo "Usage: mkproject <project_name>"
  exit 1
fi

PROJECT=$1

if [ -d "$PROJECT" ]; then
  echo "Error: directory '$PROJECT' already exists"
  exit 1
fi

echo "Creating project: $PROJECT"

# --- create folder structure ---
mkdir -p "$PROJECT"/{include/"$PROJECT",src,main,build}

# --- CMakeLists.txt ---
cat >"$PROJECT/CMakeLists.txt" <<EOF
cmake_minimum_required(VERSION 3.15)
project($PROJECT)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# compiler warnings
add_compile_options(-Wall -Wextra -O2)

# include headers
include_directories(include)

# collect all src/*.cpp files automatically
file(GLOB SRC_FILES src/*.cpp)

# --- main executable ---
add_executable(main main/main.cpp \${SRC_FILES})

# --- add extra executables here ---
# add_executable(ga main/ga.cpp \${SRC_FILES})
EOF

# --- .gitignore ---
cat >"$PROJECT/.gitignore" <<EOF
build/
*.o
*.out
*.exe
EOF

# --- README.md ---
cat >"$PROJECT/README.md" <<EOF
# $PROJECT

## Build
\`\`\`bash
cd build
cmake ..
make
\`\`\`

## Run
\`\`\`bash
./main
\`\`\`
EOF

# --- sample header ---
cat >"$PROJECT/include/$PROJECT/example.h" <<EOF
#ifndef ${PROJECT^^}_EXAMPLE_H
#define ${PROJECT^^}_EXAMPLE_H

namespace $PROJECT {

class Example {
public:
    Example();
    void run();
};

} // namespace $PROJECT

#endif // ${PROJECT^^}_EXAMPLE_H
EOF

# --- sample source ---
cat >"$PROJECT/src/example.cpp" <<EOF
#include "$PROJECT/example.h"
#include <iostream>

namespace $PROJECT {

Example::Example() {}

void Example::run() {
    std::cout << "Hello from $PROJECT!\n";
}

} // namespace $PROJECT
EOF

# --- main.cpp ---
cat >"$PROJECT/main/main.cpp" <<EOF
#include "$PROJECT/example.h"

int main() {
    $PROJECT::Example ex;
    ex.run();
    return 0;
}
EOF

# --- run cmake automatically ---
echo "Running cmake..."
cd "$PROJECT/build"
cmake .. -DCMAKE_BUILD_TYPE=Release >/dev/null
make >/dev/null
cd ../..

echo ""
echo "Project '$PROJECT' created successfully!"
echo ""
echo "Structure:"
find "$PROJECT" -not -path "*/build/*" -not -path "*/.git/*" | sort | sed 's|[^/]*/|  |g'
echo ""
echo "To build:"
echo "  cd $PROJECT/build && make"
echo ""
echo "To run:"
echo "  cd $PROJECT/build && ./main"

@echo off
REM Create and enter the build directory
if not exist build (
    mkdir build
)
cd build

REM Configure the project with CMake
cmake ..

REM Build the project
cmake --build .

REM Ensure execution rights for build.sh (useful for Unix environments via Git Bash)
if exist build.sh (
    bash -c "chmod +x build.sh"
)

cd ..

REM Add all changes to git, commit with a message, and push
git add .
git commit -m "CI: Build and permission update via ci.cmd"
git push
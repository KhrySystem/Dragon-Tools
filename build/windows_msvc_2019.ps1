# Assumes Boost and Vulkan are already installed on the system.

git submodule update --init --recursive
cmake . -Bbin -G"Visual Studio 16 2019"                     `
    --no-warn-unused-cli                                    `
    -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=TRUE               `
    -DCMAKE_BUILD_TYPE=$args[0]                             `
    -DDRAGON_INSTALL_DIR:String=$args[1]                    `
    -DBOOSTROOT:Path=$args[2]                               `
    -DVulkan_INCLUDE_DIR:Path=${VULKAN_SDK}/include         `
    -DVulkan_LIBRARY:Path=${VULKAN_SDK}/bin/vulkan-1.lib    
cmake --build $workspace --config $args[0]
ctest -C $args[0]
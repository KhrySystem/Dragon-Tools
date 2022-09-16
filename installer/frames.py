import platform

import PySimpleGUI as sg

from utils import *

f0 = [
    [
        sg.Text("Vulkan was not found on your system. Build Vulkan alongside Dragon?")
    ]
]

f1 = [
	[
		sg.Text("This installer will guide you through the steps to install DragonEngine on your computer.")
	], 
]

f2 = [
    [
        sg.Text("Select Dragon-Specific Options")
    ],
    [
        sg.Checkbox("Install Dragon Headers", default=True, enable_events=True, key="-DGHI-"), 
        sg.Checkbox("Install Dragon Binaries", default=False, key="-DGBI-"), 
        sg.Checkbox("Install Dragon Source (requires CMake)", default=True, key="-DGSI-")
    ], 
    [
        sg.Text("Dragon Install Path (Default is \"C:\\Program Files\\DragonEngine\\\")"), 
        sg.In("C:\\Program Files\\DragonEngine\\", size=(60, 1), enable_events=True, key="InstallDir"),
        sg.FolderBrowse()
    ],
    [
        sg.HorizontalSeparator()
    ],
    [
        sg.Text("Select Vulkan Options", visible=(not isVulkanInstalled()))
    ],
    [
        sg.Checkbox("Install Vulkan Headers", visible=(not isVulkanInstalled()), default=True, key="-VKHI-"),
        sg.Checkbox("Install Vulkan Validation Layers", visible=(not isVulkanInstalled()), default=True, key="-VKVI-"),
        sg.Checkbox("Install MoltenVK", visible=(not isVulkanInstalled()), default=True, key="-MVKI-"),
        sg.Checkbox("Install Vulkan Loader", visible=(not isVulkanInstalled()), default=True, key="-VKLI-")
    ],
    [
        sg.Checkbox("Install Vulkan Profile Tools (Beta)", visible=(not isVulkanInstalled()), default=False, key="-VKPI-"),
        sg.Checkbox("Install Vulkan Extension Layer", visible=(not isVulkanInstalled()), default=True, key="-VKEI-"),
        sg.Checkbox("Install Vulkan Memory Model", visible=(not isVulkanInstalled()), default=True, key="-VKMI-")
    ],
    [
        sg.Text("Vulkan Install Path (Default is \"C:\\Program Files\\VulkanSDK\\\")", visible=(not isVulkanInstalled())),
        sg.In("C:\\Program Files\\VulkanSDK\\", visible=(not isVulkanInstalled()), key="-VKIP-")
    ],
    [
        sg.HorizontalSeparator(color=(sg.DEFAULT_BACKGROUND_COLOR if not isVulkanInstalled() else '#FFFFFF'))
    ],
    [
        sg.Text("Select SPIRV Options", visible=(not isVulkanInstalled()))
    ],
    [
        sg.Checkbox("Install SPIRV Reflect", visible=(not isVulkanInstalled()), default=True, key="-SPRI-"),
        sg.Checkbox("Install SPIRV Tools", visible=(not isVulkanInstalled()), default=True, key="-SPTI-"),
        sg.Checkbox("Install SPIRV Cross", visible=(not isVulkanInstalled()), default=True, key="-SPCI-"),
        sg.Checkbox("Install SPIRV Headers", visible=(not isVulkanInstalled()), default=True, key="-SPHI-")
    ],
    [
        sg.HorizontalSeparator(color=(sg.DEFAULT_BACKGROUND_COLOR if not isVulkanInstalled() else '#FFFFFF'))
    ], 
    [
        sg.Checkbox("Install Boost", default=True, key="-BSTI-")
    ],
    [
        sg.HorizontalSeparator(color=(sg.DEFAULT_BACKGROUND_COLOR if not isVulkanInstalled() else '#FFFFFF'))
    ],
    [
        sg.Radio("Do not add installs to System PATH", 1, key="-NON-")
    ],
    [
        sg.Radio("Add installs to System PATH for the current user", 1, key="-CUR-")
    ],
    [
        sg.Radio("Add installs to System PATH for all users", 1, key="-ALL-", default=True)
    ]
]

f3 = [
    [
        sg.Text("Installing DragonEngine")
    ],
    [
        sg.Text("")
    ],
    [
        sg.Text("Downloading https://github.com/KhrySystem/Dragon.git...", key="-DPBT-")
    ],
    [
        sg.ProgressBar(max_value=100, orientation='horizontal', size=(80, 20), key="-DPB-")
    ],
    [
        sg.Text("")
    ],
    [
        sg.Text("Extracting https://github.com/KhrySystem/Dragon.git...", key="-EPBT-")
    ],
    [
        sg.ProgressBar(max_value=100, orientation="horizontal", size=(80, 20), key="-EPB-")
    ],
    [
        sg.Text("")
    ],
    [
        sg.Text("Installing https://github.com/KhrySystem/Dragon.git...", key="-IPBT-")
    ],
    [
        sg.ProgressBar(max_value=100, orientation="horizontal", size=(80, 20), key="-IPB-")
    ]
]

layout = [
    [
        sg.Column(f0, key="-F0-",visible=(not isVulkanInstalled())), 
        sg.Column(f1, key="-F1-", visible=isVulkanInstalled()), 
        sg.Column(f2, key='-F2-', visible=False),
        sg.Column(f3, key='-F3-', visible=False)
    ],
    [
        sg.VPush()
    ],
    [
        sg.Button("Cancel"), sg.Push(), sg.Button("Next")
    ]
]

window = sg.Window("Installer for DragonEngine", layout, resizable=False, size=(800, 600))
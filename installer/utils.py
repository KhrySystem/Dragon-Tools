import os

VK_SDK_PATH = os.environ.get("VK_SDK_PATH")

DG_VERSION_VAR = os.environ.get("DG_VERSION_VAR")
DG_VERSION_MAJ = os.environ.get("DG_VERSION_MAJ")
DG_VERSION_MIN = os.environ.get("DG_VERSION_MIN")
DG_VERSION_FIX = os.environ.get("DG_VERSION_FIX")
DG_UPDATE_TYPE = os.environ.get("DG_UPDATE_TYPE")
DG_SDK_PATH = os.environ.get("DG_SDK_PATH")
PATH = os.environ.get("Path").split(os.pathsep)
PATH_EXT = os.environ.get("PATH_EXT")

def isVulkanInstalled():
    return (VK_SDK_PATH != None)

def isDragonInstalled():
    return (DG_VERSION_MAJ != None) or (DG_VERSION_MIN != None) or (DG_VERSION_FIX != None) or (DG_UPDATE_TYPE != None)

def getVulkanVersion():
    if VK_SDK_PATH != None:
        temp = VK_SDK_PATH.split("\\")
        return temp[len(temp) - 1]
    else:
        return None
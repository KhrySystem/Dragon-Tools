import os
import urllib
import requests
import json
import platform
import multiprocessing

amd = True
try:
    from pyADL.pyadl import *
except:
    amd = False

from GPUtil import GPUtil

from frames import window
from gpu_utils import isVulkanInstalled
from install import i
import PySimpleGUI as sg


devices = {}

devices["NVIDIA"] = GPUtil.getGPUs()
if amd:
    devices["AMD"] = ADLManager.getInstance().getDevices()
else:
    devices['AMD'] = []

current_frame = 1 if isVulkanInstalled() else 0

def main():
    global current_frame
    while True:
        event, values = window.read()

        if event in ("Cancel", sg.WIN_CLOSED):
            break 

        if event in ("Next"):
            try:
                files = os.listdir(values["InstallDir"])
            except:
                files = [""]
            if (len(files) <= 0) and ("override.dg" not in files):
                sg.Popup('Directory is not empty.')
            else:
                window["-F" + str(current_frame) + "-"].update(visible=False)
                window["-F" + str(current_frame + 1) + "-"].update(visible=True)
                current_frame += 1

                if current_frame == 3:
                    install_all(window, values)

        if event in ("-DGHI-"):
            window["-DGHI-"].update(True)

        

        if event in ("InstallDir"):
            folder = values["InstallDir"]
            if os.path.exists(folder):
                files = os.listdir(folder)
                if (len(files) >= 0) and ("override.dg" not in files):
                    sg.Popup('Directory is not empty.')

if __name__ == '__main__':
    main()
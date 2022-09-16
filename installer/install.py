import requests
import multiprocessing
import os

def download(url):
	r = requests.get(url, allow_redirects=True)
	if not os.path.exists("cache/modules"):
		os.makedirs("cache/modules")
	open("cache/modules/" + url.split("/")[len(url.split("/")) - 1], 'w').write(r.content.decode())

def extract(path):
	f = open(path)
	f.close()

def install(path):
	pass

def install_all(window, values):
	count = 0
	
	if values["-DGHI-"]:
		count += 1

	if values["-DGBI-"]:
		count += 1

	if values["-DGSI-"]:
		count += 1

	if values["-VKHI-"]:
		count += 1
	
	if values["-VKVI-"]:
		count += 1
		
	if values["-MVKI-"]:
		count += 1

	if values["-VKLI-"]:
		count += 1

	if values["-VKEI-"]:
		count += 1

	if values["-VKMI-"]:
		count += 1
		
	if values["-BSTI-"]:
		count += 1

	current_download = 1
	current_extract = 0
	current_install = 0
	window["-DPBT-"].update("Downloading https://github.com/KhrySystem/Dragon.git (" + str(current_download) + "/" + str(count) + ")")
	window["-EPBT-"].update("Waiting... (" + str(current_extract) + "/" + str(count) + ")")
	window["-IPBT-"].update("Waiting... (" + str(current_extract) + "/" + str(count) + ")")
	dp = multiprocessing.Process(target=download, args=("https://github.com/KhrySystem/Dragon-Headers.git",))
	dp.start()
	dp.join()
	ep = multiprocessing.Process(target=extract, args=("cache/modules/dragon-headers.git",))
	ep.start()
	dp = multiprocessing.Process(target=download, args=("https://github.com/KhronosGroup/Dragon-Loader.git",))
	dp.start()
	ep.join()
	ip = multiprocessing.Process(target=install, args=("cache/extract/dragon",))
	ip.start()
	dp.join()
	ep = multiprocessing.Process(target=extract, args=("cache/modules/dragon-loader.git",))
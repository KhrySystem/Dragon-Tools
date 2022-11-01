#include <dragon/dragon.hpp>
#include <iostream>

#include "general.hpp"

using namespace Dragon;

int main(void) {
	printf("OpenWindow.cpp");
	CreateInfo createInfo{};
	createInfo.name = "openWindow.cpp";
	createInfo.pCallback = &mCallback;

	Engine engine;

	if(createEngine(&engine, &createInfo) != DG_TRUE {
		printf("One Hell of an error occurred.\n");
		terminateEngine(&engine);
	} 

	while(!canEngineBeTerminated(engine)) {
		updateEngine(engine);
	}

	terminateEngine(engine);
}
#include <dragon/dragon.hpp>
#include <iostream>

#include "general.hpp"

using namespace Dragon;

int main(void) {
	printf("OpenWindow.cpp");
	Engine engine = initEngine();

	while(!canEngineBeTerminated(engine)) {
		updateEngine(engine);
	}

	terminateEngine(engine, DRAGON_TERMINATE_ALL);
}
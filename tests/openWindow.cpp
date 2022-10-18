#include <dragon/dragon.hpp>
#include <iostream>

struct App {
	App() {
		Dragon::init("openWindow.cpp");

		Dragon::WindowCreateParams params{};
		params.width = 800;
		params.height = 600;
		if(!Dragon::createNewWindow(params)) {
			throw std::exception("Window creation failed");
		}
	}

	void run() {
		while(!Dragon::shouldWindowClose(0)) {
			Dragon::update();
		}
		Dragon::closeWindow(0);
	}
};

int main(void)
{
	App app;
	try {
		app = App();
		app.run();
	} catch(Dragon::BaseException &e) {
		if(const char** exc_info=boost::get_error_info<Dragon::ExceptionInfo>(e)) {
			std::cerr << "Dragon Error Found: " << *exc_info << std::endl;
		} else {
			std::cerr << "Dragon Error was thrown, but no information was found." << std::endl;
		}
	} catch(std::exception &e) {
		std::cerr << "Non-Dragon Error found: " << e.what() << std::endl;
	}

	Dragon::terminate();
	return 0x0000;
}
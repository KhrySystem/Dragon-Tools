#include <dragon/dragon.hpp>
#include <iostream>

struct App {
	App() {
		dgInit("openWindow.cpp");

		DgWindowCreateParams params{};
		params.width = 800;
		params.height = 600;
		if(!dgCreateNewWindow(params)) {
			throw std::exception("Window creation failed");
		}
	}

	void run() {
		while(!dgShouldWindowClose(0)) {
			dgUpdate();
		}
		dgCloseWindow(0);
	}
};

int main(void)
{
	App app;
	try {
		app = App();
		app.run();
	} catch(DgBaseException_T &e) {
		if(const char** exc_info=boost::get_error_info<DgExceptionInfo>(e)) {
			std::cerr << "Error Found: " << *exc_info << std::endl;
		}
	} catch(std::exception &e) {
		std::cerr << "Non-Dragon Error found: " << e.what() << std::endl;
	}

	dgTerminate();
	return 0x0000;
}
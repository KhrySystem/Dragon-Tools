#include <dragon/dragon.h>

int main(void)
{
	if(dgInit() != DG_TRUE) {
		return false;
	}
	dgWindow window = dgCreateWindow(1080, 960, "openWindow.cpp");
	return 0;
	dgCloseWindow(window);
}
#include "general.hpp"

#include <dragon/dragon.hpp>

using namespace Dragon;

int main(void) {

    setOption(DRAGON_CL_ENABLED, DG_FALSE);
    
    Engine engine = initEngine();
    setMessageCallback(&messageCallback);

    while(!areNoWindowsOpen(engine)) {
        updateEngine(engine);
    }

    terminateEngine();
}
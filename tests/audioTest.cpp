#include "general.hpp"

#include <dragon/dragon.hpp>

using namespace Dragon;

int main(void) {

    setOption(DRAGON_FIREBREATH_ENABLED, DG_FALSE);
    #ifdef DG_PLAT_MACOS
        setOption(DRAGON_IRONBREATH_ENABLED, DG_TRUE);
    #else
        setOption(DRAGON_IRONBREATH_ENABLED, DG_FALSE);
    #endif
    setOption(DRAGON_LIGHTBREATH_ENABLED, DG_FALSE);
    setOption(DRAGON_STREAMBREATH_ENABLED, DG_TRUE);
    setOption(DRAGON_THUNDERBREATH_ENABLED, DG_FALSE);

    init("audioTest.cpp");
    Stream::setErrorCallback(errorCallback);

    terminate();
}
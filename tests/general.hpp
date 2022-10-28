#pragma once

#include <dragon/dragon.hpp>

using namespace Dragon::Error;

void errorCallback(ErrorInfo eInfo) {
    
    printf("Error:\n\tCode:%s\n\tMessage:%s",  eInfo.code, eInfo.message);
}
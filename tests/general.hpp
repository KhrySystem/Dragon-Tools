#pragma once

#include <dragon/dragon.hpp>

using namespace Dragon;

void messageCallback(Message message) {
    printf("Error:\n\tCode:%I64i\n\tMessage:%s",  message.code, message.message.c_str());
}
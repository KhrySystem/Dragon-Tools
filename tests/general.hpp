#pragma once

#include <dragon/dragon.hpp>

using namespace Dragon::Error;

void errorCallback(
    ErrorType eType, 
    ErrorSeverity eSeverity, 
    ErrorInfo eMessage
) {
    std::string output = "";
    switch(eType) {
        case DEBUG:         output += "Debug";
        case GENERAL:       output += "General";
        case SPEC_ERROR:    output += "Specification";
        case NONOPTIMAL:    output += "Non-optimal";
        case WARNING:       output += "Warning";
        case ERROR:         break;
        case FATAL:   output += "Fatal";
        default:            output += "Unknown error type";
    };

    output += " ";

    switch(eSeverity) {
        case STATUS:        output += "status";
        case DEBUG:         output = "Debug message:";
        case WARNING:       output += "warning";
        case ERROR:         output += "error";
        default:            output += "of unknown severity";
    };

    output += ":\n\t";
    printf("%sCode:%i\n\tMessage:%s", output, eMessage.code, eMessage.message);
}
#pragma once

#include <hxcpp.h>
#include <GLFW/glfw3.h>

namespace linc {

    namespace glfw {
        extern void callErrorCb(int error, const char* message);
        extern void setErrorCb(::cpp::Function<void(int, ::String)> func);
    } //glfw namespace

} //linc
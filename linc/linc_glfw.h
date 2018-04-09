#pragma once

#include <hxcpp.h>
#include <GLFW/glfw3.h>
#ifdef HX_WINDOWS
#define GLFW_EXPOSE_NATIVE_WIN32
#include <GLFW/glfw3native.h>
#endif

namespace linc {

    namespace glfw {
        extern void callErrorCb(int error, const char* message);
        extern void setErrorCb(::cpp::Function<void(int, ::String)> func);
    } //glfw namespace

} //linc
#pragma once

#include <hxcpp.h>
#include <GLFW/glfw3.h>
#ifdef HX_WINDOWS
#define GLFW_EXPOSE_NATIVE_WIN32
#include <GLFW/glfw3native.h>
#endif

namespace linc {

    namespace glfw {
        
        typedef cpp::Function<void(cpp::Pointer<GLFWwindow>, int, int, int, int)> KeyCb;
        typedef cpp::Function<void(int, String)> ErrorCb;

        extern void callErrorCb(int error, const char* message);
        extern void setErrorCb(cpp::Pointer<ErrorCb> func);
        extern void setKeyCb(cpp::Pointer<GLFWwindow> win, cpp::Pointer<KeyCb> func);
    } //glfw namespace

} //linc
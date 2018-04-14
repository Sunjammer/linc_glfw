#ifndef LINC_GLFW_INCLUDE
#define LINC_GLFW_INCLUDE
#include "hxcpp.h"
#include <GLFW/glfw3.h>
#ifdef HX_WINDOWS
#define GLFW_EXPOSE_NATIVE_WIN32
#include <GLFW/glfw3native.h>
#endif

namespace linc {

    namespace glfw {

        typedef cpp::Function<void(cpp::Pointer<GLFWwindow>, int, int, int, int)> KeyCb;
        typedef cpp::Function<void(cpp::Pointer<GLFWwindow>, double, double)> MouseMoveCb;
        typedef cpp::Function<void(cpp::Pointer<GLFWwindow>, double, double)> MouseWheelCb;
        typedef cpp::Function<void(cpp::Pointer<GLFWwindow>, int, int, int)> MouseButtonCb;
        typedef cpp::Function<void(int, String)> ErrorCb;

        extern void callErrorCb(int error, const char* message);
        extern void setErrorCb(cpp::Pointer<ErrorCb> func);
        extern void setKeyCb(cpp::Pointer<GLFWwindow> win, cpp::Pointer<KeyCb> func);
        extern void setMouseMoveCb(cpp::Pointer<GLFWwindow> win, cpp::Pointer<MouseMoveCb> func);
        extern void setMouseButtonCb(cpp::Pointer<GLFWwindow> win, cpp::Pointer<MouseButtonCb> func);
        extern void setMouseWheelCb(cpp::Pointer<GLFWwindow> win, cpp::Pointer<MouseWheelCb> func);
    } //glfw namespace

} //linc
#endif
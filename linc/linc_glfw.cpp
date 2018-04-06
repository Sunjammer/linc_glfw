#include <hxcpp.h>
#include "./linc_glfw.h"

namespace linc {

    namespace glfw {

        static ::cpp::Function<void(int, ::String)> * errorCb;
        extern void callErrorCb(int error, const char* message){
            if(errorCb){
                errorCb->call(error, ::String(message));
            }
        }

        extern void setErrorCb(::cpp::Function<void(int, ::String)> func){
            errorCb = &func;
            glfwSetErrorCallback(&callErrorCb);
        }

    } //glfw namespace

} //linc
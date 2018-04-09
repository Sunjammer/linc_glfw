#include <hxcpp.h>
#include "./linc_glfw.h"

namespace linc {

    namespace glfw {
        static ErrorCb * errorCb;
        extern void callErrorCb(int error, const char* message){
            if(errorCb){
                errorCb->call(error, ::String(message));
            }
        }
        extern void setErrorCb(cpp::Pointer<ErrorCb> func){
            errorCb = func;
            glfwSetErrorCallback(&callErrorCb);
        }
        
        static KeyCb * keyCb;
        extern void callKeyCb(GLFWwindow* win, int key, int scancode, int action, int modifier){
            if(keyCb){
                keyCb->call(win, key, scancode, action, modifier);
            }
        }
        extern void setKeyCb(cpp::Pointer<GLFWwindow> win, cpp::Pointer<KeyCb> func){
            keyCb = func;
            glfwSetKeyCallback(win, &callKeyCb);
        }

    } //glfw namespace

} //linc
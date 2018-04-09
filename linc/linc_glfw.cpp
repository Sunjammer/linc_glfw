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
        void callKeyCb(GLFWwindow* win, int key, int scancode, int action, int modifier){
            if(keyCb){
                keyCb->call(win, key, scancode, action, modifier);
            }
        }
        extern void setKeyCb(cpp::Pointer<GLFWwindow> win, cpp::Pointer<KeyCb> func){
            keyCb = func;
            glfwSetKeyCallback(win, &callKeyCb);
        }
        
        static MouseMoveCb * mouseMoveCb;
        void callMouseMoveCb(GLFWwindow* win, double x, double y){
            if(mouseMoveCb){
                mouseMoveCb->call(win, x, y);
            }
        }
        extern void setMouseMoveCb(cpp::Pointer<GLFWwindow> win, cpp::Pointer<MouseMoveCb> func){
            mouseMoveCb = func;
            glfwSetCursorPosCallback(win, &callMouseMoveCb);
        }
        
        static MouseButtonCb * mouseButtonCb;
        void callMouseButtonCb(GLFWwindow* win, int button, int action, int mods){
            if(mouseButtonCb){
                mouseButtonCb->call(win, button, action, mods);
            }
        }
        extern void setMouseButtonCb(cpp::Pointer<GLFWwindow> win, cpp::Pointer<MouseButtonCb> func){
            mouseButtonCb = func;
            glfwSetMouseButtonCallback(win, &callMouseButtonCb);
        }

    } //glfw namespace

} //linc
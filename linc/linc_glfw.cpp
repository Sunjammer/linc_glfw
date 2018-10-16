#include "hxcpp.h"
#include "./linc_glfw.h"

namespace linc {

    namespace glfw {
        //Error callbacks
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
        
        // Key callbacks
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

        //Char callbacks
        static CharCb * charCb;
        void callCharCb(GLFWwindow* win, uint32_t key){
            if(charCb){
                charCb->call(win, key);
            }
        }
        
        extern void setCharCb(cpp::Pointer<GLFWwindow> win, cpp::Pointer<CharCb> func){
            charCb = func;
            glfwSetCharCallback(win, &callCharCb);
        }
        
        //Mouse callbacks
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

        static MouseWheelCb * mouseWheelCb;
        void callMouseWheelCb(GLFWwindow* win, double x, double y){
            if(mouseWheelCb){
                mouseWheelCb->call(win, x, y);
            }
        }
        extern void setMouseWheelCb(cpp::Pointer<GLFWwindow> win, cpp::Pointer<MouseWheelCb> func){
            mouseWheelCb = func;
            glfwSetScrollCallback(win, &callMouseWheelCb);
        }

        extern int glfwGetNumMonitors(){
            int count;
            glfwGetMonitors(&count);
            return count;
        }

        extern String glfwGetMonitorNameHelper(GLFWmonitor* monitor){
            return String(glfwGetMonitorName(monitor));
        }
        
        extern cpp::Pointer<GLFWmonitor> glfwGetMonitorHandle(int index){
            int count;
            GLFWmonitor** outMonitors = glfwGetMonitors(&count);
            return &outMonitors[index];
        }

    } //glfw namespace

} //linc
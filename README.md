# linc_glfw
GLFW bindings for Haxe

## Overview (verbatim from [glfw.org](http://glfw.org))
GLFW is an Open Source, multi-platform library for OpenGL, OpenGL ES and Vulkan development on the desktop. It provides a simple API for creating windows, contexts and surfaces, receiving input and events.

GLFW is written in C and has native support for Windows, macOS and many Unix-like systems using the X Window System, such as Linux and FreeBSD.

GLFW is licensed under the zlib/libpng license.

## Motivation
The linc_sdl bindings are excellent and cover significant ground in game development. However, for some scenarios GLFW is by far the lighter and more direct alternative for windowing, input and OGL rendering. These Haxe bindings enable the creation of a window and opengl context + event loop on windows and osx in the following lines:

```Haxe
import glfw.GLFW.*;
class Test {
        
    public static function main(){
        if(glfwInit() != 0){
            var window = glfwCreateWindow(640, 480, "Hello World", null, null);
            glfwMakeContextCurrent(window);

            while (glfwWindowShouldClose(window) != GLFW_TRUE)
            {
                glfwPollEvents();
                // Render here
            }
        }else{
            throw 'GLFW init fail';
        }
    }

}
```

The bindings are written according to the [linc guidelines](http://snowkit.github.io/linc/), meaning knowledge gleaned from the [official docs](http://www.glfw.org/documentation.html) should apply directly to your Haxe source. 

These bindings are written in a style that foregoes non-c++ targets, meaning liberal reliance on the cpp namespace and hxcpp types. Expect to see (and have to deal with) cpp.Pointers where the official docs specify pointer types.

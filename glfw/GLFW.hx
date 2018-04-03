package glfw;

import cpp.Pointer;

@:keep
@:native("GLFWwindow")
@:include('linc_glfw.h')
extern class GLFWwindow {}

@:keep
@:include('linc_glfw.h')
#if !display
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('glfw'))
#end
extern class GLFW {

    @:native('glfwInit')
    static function glfwInit() : Int;

    @:native('glfwCreateWindow')
    static function glfwCreateWindow(width:Int, height:Int, title:String, monitor:Dynamic /*GLFWmonitor* monitor*/, window:Pointer<GLFWwindow> /*GLFWwindow* share*/):Pointer<GLFWwindow>;

    @:native('glfwMakeContextCurrent')
    static function glfwMakeContextCurrent(window:Pointer<GLFWwindow>):Void;

    @:native('glfwWindowShouldClose')
    static function glfwWindowShouldClose(window:Pointer<GLFWwindow>):Int;

    @:native('glfwPollEvents')
    static function glfwPollEvents():Void;

} //GLFW
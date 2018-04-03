package glfw;

@:keep
@:include('linc_glfw.h')
#if !display
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('glfw'))
#end
extern class GLFW {

    @:native('glfwInit')
    static function glfwInit() : Bool;

} //GLFW
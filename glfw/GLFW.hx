package glfw;
import cpp.Function;
import cpp.Native;
import cpp.Pointer;
import cpp.Star;
import cpp.Reference;
import cpp.Callable;
import haxe.io.BytesData;

typedef HWND = cpp.Pointer<cpp.Void>;

@:keep
@:native("GLFWwindow")
@:include("linc_glfw.h")
extern class GLFWwindow {}

@:keep
@:native("GLFWcursor")
@:include("linc_glfw.h")
extern class GLFWcursor {}

@:keep
@:native("GLFWmonitor")
@:include("linc_glfw.h")
extern class GLFWmonitor {}

typedef GLFWerrorfun = Int -> String -> Void;
@:keep
class GLFWErrorHandler {

    static var cb:GLFWerrorfun;

    static public function nativeCallack(error:Int, message:cpp.ConstCharStar){
        trace(error+": "+message);
        if(cb != null) cb(error, message);
    }

    public static function setCallback(func:GLFWerrorfun){
        cb = func;
    }
}

typedef GLFWcharcb = cpp.UInt32 -> Void;
@:keep
class GLFWCharHandler {

    static var listeners = new Map<String, GLFWcharcb>();

    static public function nativeCallack(win:Star<GLFWwindow>, key:cpp.UInt32):Void{
        var ptr = win+"";
        if(listeners.exists(ptr)){
            listeners[ptr](key);
        }
    }

    public static function setCallback(win:Star<GLFWwindow>, func:GLFWcharcb):Void{
        listeners[win+""] = func;
    }
}

typedef GLFWkeycb = Int -> Int -> Int -> Int -> Void;
@:keep
class GLFWKeyHandler {

    static var listeners = new Map<String, GLFWkeycb>();

    static public function nativeCallack(win:Star<GLFWwindow>, key:Int, scancode:Int, action:Int, mods:Int):Void{
        var ptr = win+"";
        if(listeners.exists(ptr)){
            listeners[ptr](key, scancode, action, mods);
        }
    }

    public static function setCallback(win:Star<GLFWwindow>, func:GLFWkeycb):Void{
        listeners[win+""] = func;
    }
}

typedef GLFWmouseposcb = Float -> Float -> Void;
@:keep
class GLFWMouseMoveHandler {

    static var listeners = new Map<String, GLFWmouseposcb>();

    static public function nativeCallack(win:Star<GLFWwindow>, x:Float, y:Float):Void{
        var ptr = win+"";
        if(listeners.exists(ptr)){
            listeners[ptr](x, y);
        }
    }

    public static function setCallback(win:Star<GLFWwindow>, func:GLFWmouseposcb):Void{
        listeners[win+""] = func;
    }
}

typedef GLFWmousebuttoncb = Int -> Int -> Int -> Void;
@:keep
class GLFWMouseButtonHandler {

    static var listeners = new Map<String, GLFWmousebuttoncb>();

    static public function nativeCallack(win:Star<GLFWwindow>, button:Int, action:Int, mods:Int):Void{
        var ptr = win+"";
        if(listeners.exists(ptr)){
            listeners[ptr](button, action, mods);
        }
    }

    public static function setCallback(win:Star<GLFWwindow>, func:GLFWmousebuttoncb):Void{
        listeners[win+""] = func;
    }
}

typedef GLFWmousewheelcb = Float -> Float -> Void;
@:keep
class GLFWMouseWheelHandler {

    static var listeners = new Map<String, GLFWmousewheelcb>();

    static public function nativeCallack(win:Star<GLFWwindow>, x:Float, y:Float):Void{
        var ptr = win+"";
        if(listeners.exists(ptr)){
            listeners[ptr](x,y);
        }
    }

    public static function setCallback(win:Star<GLFWwindow>, func:GLFWmousewheelcb):Void{
        listeners[win+""] = func;
    }
}


typedef GLFWjoystickcb = Int -> Int -> Void;
@:keep
class GLFWJoystickHandler {

    static var listener:GLFWjoystickcb; 

    static function nativeCallack(joy:Int, event:Int):Void{
        if(listener!=null){
            listener(joy, event);
        }
    }

    public static function setCallback(func:GLFWjoystickcb):Void{
        listener = func;
    }
}

typedef GLFWwindowsizefun = Pointer<GLFWwindow> -> Int -> Int -> Void;
@:keep
class GLFWWindowSizeHandler {

    static var listeners = new Map<String, GLFWwindowsizefun>();

    public static function nativeCallack(win:Star<GLFWwindow>, width:Int, height: Int) {
        var cb = listeners.get('win' + win);
        if (cb != null) cb(cast win, width, height);
    }

    public static function setCallback(win:Star<GLFWwindow>, cb:GLFWwindowsizefun):Void {
        listeners.set('win' + win, cb);
    }

}

@:native("cpp.Struct<GLFWvidmode>")
extern class GLFWvidmode {
    public var width: Int;
    public var height: Int;
    public var redBits: Int;
    public var greenBits: Int;
    public var blueBits: Int;
    public var refreshRate: Int;
}

// See https://www.glfw.org/docs/latest/group__native.html
@:keep
@:include('linc_glfw.h')
#if !display
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('glfw'))
#end
extern class GLFW {
    //Bindings

    @:native('glfwInit')
    static inline function glfwInit() : Int{
        force_include();
        return untyped __cpp__('glfwInit()');
    }

    @:native('glfwTerminate')
    static function glfwTerminate() : Void;

    static inline function glfwSetErrorCallback(cb:GLFWerrorfun):Void{
        GLFWErrorHandler.setCallback(cb);
        untyped __global__.glfwSetErrorCallback(Function.fromStaticFunction(GLFWErrorHandler.nativeCallack));
    }

    static inline function glfwSetKeyCallback(window:Pointer<GLFWwindow>, cb:GLFWkeycb):Void{
        GLFWKeyHandler.setCallback(window.ptr, cb);
        untyped __global__.glfwSetKeyCallback(window, Function.fromStaticFunction(GLFWKeyHandler.nativeCallack));
    }

    static inline function glfwSetCharCallback(window:Pointer<GLFWwindow>, cb:GLFWcharcb):Void{
        GLFWCharHandler.setCallback(window.ptr, cb);
        untyped __global__.glfwSetCharCallback(window, Function.fromStaticFunction(GLFWCharHandler.nativeCallack));
    }

    static inline function glfwSetCursorPosCallback(window:Pointer<GLFWwindow>, cb:GLFWmouseposcb):Void{
        GLFWMouseMoveHandler.setCallback(window.ptr, cb);
        untyped __global__.glfwSetCursorPosCallback(window, Function.fromStaticFunction(GLFWMouseMoveHandler.nativeCallack));
    }

    static inline function glfwSetMouseButtonCallback(window:Pointer<GLFWwindow>, cb:GLFWmousebuttoncb):Void{
        GLFWMouseButtonHandler.setCallback(window.ptr, cb);
        untyped __global__.glfwSetMouseButtonCallback(window, Function.fromStaticFunction(GLFWMouseButtonHandler.nativeCallack));
    }

    static inline function glfwSetScrollCallback(window:Pointer<GLFWwindow>, cb:GLFWmousewheelcb):Void{
        GLFWMouseWheelHandler.setCallback(window.ptr, cb);
        untyped __global__.glfwSetScrollCallback(window, Function.fromStaticFunction(GLFWMouseWheelHandler.nativeCallack));
    }

    static inline function glfwSetWindowSizeCallback(window: Pointer<GLFWwindow>, cb: GLFWwindowsizefun):Void {
        GLFWWindowSizeHandler.setCallback(window.ptr, cb);
        untyped __global__.glfwSetWindowSizeCallback(window, Function.fromStaticFunction(GLFWWindowSizeHandler.nativeCallack));
    }

    static inline function glfwSetJoystickCallback(cb:GLFWjoystickcb):Void{
        GLFWJoystickHandler.setCallback(cb);
        untyped __global__.glfwSetJoystickCallback(Function.fromStaticFunction(GLFWJoystickHandler.nativeCallack));
    }

    @:native('glfwGetPrimaryMonitor')
    static function glfwGetPrimaryMonitor():Pointer<GLFWmonitor>;


    static inline function glfwGetMonitors(): Array<Dynamic> {
        var count = 0;
        var monitorsPtr: cpp.Pointer<cpp.Pointer<GLFWmonitor>> = untyped __global__.glfwGetMonitors(Native.addressOf(count));
        // return monitorsPtr.toUnmanagedArray(count);
        return [for (i in 0...count) monitorsPtr.at(i)];
    }

    static inline function glfwGetVideoModes(monitor: Pointer<GLFWmonitor>):Null<Array<GLFWvidmode>> {
        var count: cpp.Int32 = 0;
        var modesPtr: cpp.Pointer<GLFWvidmode> = untyped __global__.glfwGetVideoModes(monitor, Native.addressOf(count));
        return [for (i in 0...count) modesPtr.at(i)];
    }

    @:native('glfwGetVideoMode')
    static function glfwGetVideoMode(monitor: Pointer<GLFWmonitor>):Pointer<GLFWvidmode>;

    @:native('glfwGetMonitorContentScale')
    static function glfwGetMonitorContentScale(monitor: Pointer<GLFWmonitor>, xscale:Pointer<cpp.Float32>, yscale:Pointer<cpp.Float32>):Void;

    @:native('glfwGetWindowContentScale')
    static function glfwGetWindowContentScale(monitor: Pointer<GLFWwindow>, xscale:Pointer<cpp.Float32>, yscale:Pointer<cpp.Float32>):Void;

    static inline function glfwGetMonitorName(monitor:Pointer<GLFWmonitor>):String {
        var cStr: cpp.ConstCharStar = untyped __global__.glfwGetMonitorName(monitor);
        return cStr.toString();
    }

    @:native('glfwGetWindowMonitor')
    static function glfwGetWindowMonitor(window:Pointer<GLFWwindow>):Pointer<GLFWmonitor>;
    
    @:native('glfwSetWindowMonitor')
    static function glfwSetWindowMonitor(window:Pointer<GLFWwindow>, monitor: Pointer<GLFWmonitor>, xpos: Int, ypos: Int, width: Int, height: Int, refreshRate: Int): Void;

    static inline function glfwGetNumMonitors():Int {
        var count: cpp.Int32 = 0;
        untyped __global__.glfwGetMonitors(Native.addressOf(count));
        return count;
    }

    @:native('glfwSetWindowSize')
    static function glfwSetWindowSize(window:Pointer<GLFWwindow>, width:Int, height:Int):Void;

    @:native('glfwGetWindowSize')
    static function glfwGetWindowSize(window:Pointer<GLFWwindow>, width:Pointer<Int>, height:Pointer<Int>):Void;

    @:native('glfwGetFramebufferSize')
    static function glfwGetFramebufferSize(window:Pointer<GLFWwindow>, width:Pointer<Int>, height:Pointer<Int>):Void;

    @:native('glfwWindowHint')
    static function glfwWindowHint(hint:Int, value:Int):Void;

    @:native('glfwDestroyWindow')
    static function glfwDestroyWindow(window:Pointer<GLFWwindow>):Void;

    @:native('glfwCreateWindow')
    static function glfwCreateWindow(width:Int, height:Int, title:String, monitor:Pointer<GLFWmonitor>, window:Pointer<GLFWwindow>):Pointer<GLFWwindow>;

    @:native('glfwMakeContextCurrent')
    static function glfwMakeContextCurrent(window:Pointer<GLFWwindow>):Void;

    @:native('glfwWindowShouldClose')
    static function glfwWindowShouldClose(window:Pointer<GLFWwindow>):Int;

    @:native('glfwSwapBuffers')
    static function glfwSwapBuffers(window:Pointer<GLFWwindow>):Void;

    @:native('glfwSwapInterval')
    static function glfwSwapInterval(interval:Int):Void;

    @:native('glfwDefaultWindowHints')
    static function glfwDefaultWindowHints():Void;

    // Input shenaningans

    @:native('glfwJoystickPresent')
    static function glfwJoystickPresent(index:Int):Int;

    static inline function glfwGetJoystickAxes(index:Int):Array<cpp.Float32> {
        var count: cpp.Int32 = 0;
        var modesPtr: cpp.Pointer<cpp.Float32> = untyped __global__.glfwGetJoystickAxes(index, Native.addressOf(count));
        return [for (i in 0...count) modesPtr.at(i)];
    }

    static inline function glfwGetJoystickButtons(index:Int): BytesData {
        var count: cpp.Int32 = 0;
        var modesPtr: cpp.Pointer<cpp.UInt8> = untyped __global__.glfwGetJoystickButtons(index, Native.addressOf(count));
        return [for (i in 0...count) modesPtr.at(i)];
    }

    static inline function glfwGetJoystickName(index:Int):String {
        var cStr: cpp.ConstCharStar = untyped __global__.glfwGetJoystickName(index);
        return cStr.toString();
    }

    @:native('glfwGetInputMode')
    static function glfwGetInputMode(window:Pointer<GLFWwindow>, mode:Int):Int;

    @:native('glfwSetInputMode')
    static function glfwSetInputMode(window:Pointer<GLFWwindow>, mode:Int, value:Int):Void;

    @:native('glfwPollEvents')
    static function glfwPollEvents():Void;

    @:native('glfwWaitEvents')
    static function glfwWaitEvents():Void;

    @:native('glfwPostEmptyEvent')
    static function glfwPostEmptyEvent():Void;

    @:native('glfwWaitEventsTimeout')
    static function glfwWaitEventsTimeout(timeout:Float):Void;
    
    @:native("glfwGetWin32Window")
    static function glfwGetWin32Window(window:Pointer<GLFWwindow>):HWND;

    @:native("glfwGetTime")
    static function glfwGetTime():Float;

    @:native("glfwCreateStandardCursor")
    static function glfwCreateStandardCursor(shape:Int):Pointer<GLFWcursor>;

    @:native("glfwSetCursor")
    static function glfwSetCursor(window:Pointer<GLFWwindow>, cursor:Pointer<GLFWcursor>):Void;

    @:native("glfwGetMouseButton")
    static function glfwGetMouseButton(window: Pointer<GLFWwindow>, button: Int): Int;

    @:native("glfwGetCursorPos")
    static function glfwGetCursorPos(window: Pointer<GLFWwindow>,  xpos: cpp.Pointer<Float>, ypos: cpp.Pointer<Float>): Int;


    //Values
    /*************************************************************************
     * GLFW API tokens
     *************************************************************************/

    /*! @name GLFW version macros
     *  @{ */
    /*! @brief The major version number of the GLFW library.
     *
     *  This is incremented when the API is changed in non-compatible ways.
     *  @ingroup init
     */
    static inline final GLFW_VERSION_MAJOR          = 3;
    /*! @brief The minor version number of the GLFW library.
     *
     *  This is incremented when features are added to the API but it remains
     *  backward-compatible.
     *  @ingroup init
     */
    static inline final GLFW_VERSION_MINOR          = 3;
    /*! @brief The revision number of the GLFW library.
     *
     *  This is incremented when a bug fix release is made that does not contain any
     *  API changes.
     *  @ingroup init
     */
    static inline final GLFW_VERSION_REVISION       = 1;
    /*! @} */

    /*! @brief One.
     *
     *  This is only semantic sugar for the number 1.  You can instead use `1` or
     *  `true` or `_True` or `GL_TRUE` or `VK_TRUE` or anything else that is equal
     *  to one.
     *
     *  @ingroup init
     */
    static inline final GLFW_TRUE                   = 1;
    /*! @brief Zero.
     *
     *  This is only semantic sugar for the number 0.  You can instead use `0` or
     *  `false` or `_False` or `GL_FALSE` or `VK_FALSE` or anything else that is
     *  equal to zero.
     *
     *  @ingroup init
     */
    static inline final GLFW_FALSE                  = 0;

    /*! @name Key and button actions
     *  @{ */
    /*! @brief The key or mouse button was released.
     *
     *  The key or mouse button was released.
     *
     *  @ingroup input
     */
    static inline final GLFW_RELEASE                = 0;
    /*! @brief The key or mouse button was pressed.
     *
     *  The key or mouse button was pressed.
     *
     *  @ingroup input
     */
    static inline final GLFW_PRESS                  = 1;
    /*! @brief The key was held down until it repeated.
     *
     *  The key was held down until it repeated.
     *
     *  @ingroup input
     */
    static inline final GLFW_REPEAT                 = 2;
    /*! @} */

    /*! @defgroup hat_state Joystick hat states
     *  @brief Joystick hat states.
     *
     *  See [joystick hat input](@ref joystick_hat) for how these are used.
     *
     *  @ingroup input
     *  @{ */
    static inline final GLFW_HAT_CENTERED           = 0;
    static inline final GLFW_HAT_UP                 = 1;
    static inline final GLFW_HAT_RIGHT              = 2;
    static inline final GLFW_HAT_DOWN               = 4;
    static inline final GLFW_HAT_LEFT               = 8;
    static inline final GLFW_HAT_RIGHT_UP           = ( GLFW_HAT_RIGHT | GLFW_HAT_UP);
    static inline final GLFW_HAT_RIGHT_DOWN         = ( GLFW_HAT_RIGHT | GLFW_HAT_DOWN);
    static inline final GLFW_HAT_LEFT_UP            = ( GLFW_HAT_LEFT  | GLFW_HAT_UP);
    static inline final GLFW_HAT_LEFT_DOWN          = ( GLFW_HAT_LEFT  | GLFW_HAT_DOWN);
    /*! @} */

    /*! @defgroup keys Keyboard keys
     *  @brief Keyboard key IDs.
     *
     *  See [key input](@ref input_key) for how these are used.
     *
     *  These key codes are inspired by the _USB HID Usage Tables v1.12_ (p. 53-60),
     *  but re-arranged to map to 7-bit ASCII for printable keys (function keys are
     *  put in the 256+ range).
     *
     *  The naming of the key codes follow these rules:
     *   - The US keyboard layout is used
     *   - Names of printable alpha-numeric characters are used (e.g. "A", "R",
     *     "3", etc.)
     *   - For non-alphanumeric characters, Unicode:ish names are used (e.g.
     *     "COMMA", "LEFT_SQUARE_BRACKET", etc.). Note that some names do not
     *     correspond to the Unicode standard (usually for brevity)
     *   - Keys that lack a clear US mapping are named "WORLD_x"
     *   - For non-printable keys, custom names are used (e.g. "F4",
     *     "BACKSPACE", etc.)
     *
     *  @ingroup input
     *  @{
     */

    /* The unknown key */
    static inline final GLFW_KEY_UNKNOWN            = 1;

    /* Printable keys */
    static inline final GLFW_KEY_SPACE              = 32;
    static inline final GLFW_KEY_APOSTROPHE         = 39  /* ' */;
    static inline final GLFW_KEY_COMMA              = 44  /* , */;
    static inline final GLFW_KEY_MINUS              = 45  /* - */;
    static inline final GLFW_KEY_PERIOD             = 46  /* . */;
    static inline final GLFW_KEY_SLASH              = 47  /* / */;
    static inline final GLFW_KEY_0                  = 48;
    static inline final GLFW_KEY_1                  = 49;
    static inline final GLFW_KEY_2                  = 50;
    static inline final GLFW_KEY_3                  = 51;
    static inline final GLFW_KEY_4                  = 52;
    static inline final GLFW_KEY_5                  = 53;
    static inline final GLFW_KEY_6                  = 54;
    static inline final GLFW_KEY_7                  = 55;
    static inline final GLFW_KEY_8                  = 56;
    static inline final GLFW_KEY_9                  = 57;
    static inline final GLFW_KEY_SEMICOLON          = 59  /* ; */;
    static inline final GLFW_KEY_EQUAL              = 61  /* = */;
    static inline final GLFW_KEY_A                  = 65;
    static inline final GLFW_KEY_B                  = 66;
    static inline final GLFW_KEY_C                  = 67;
    static inline final GLFW_KEY_D                  = 68;
    static inline final GLFW_KEY_E                  = 69;
    static inline final GLFW_KEY_F                  = 70;
    static inline final GLFW_KEY_G                  = 71;
    static inline final GLFW_KEY_H                  = 72;
    static inline final GLFW_KEY_I                  = 73;
    static inline final GLFW_KEY_J                  = 74;
    static inline final GLFW_KEY_K                  = 75;
    static inline final GLFW_KEY_L                  = 76;
    static inline final GLFW_KEY_M                  = 77;
    static inline final GLFW_KEY_N                  = 78;
    static inline final GLFW_KEY_O                  = 79;
    static inline final GLFW_KEY_P                  = 80;
    static inline final GLFW_KEY_Q                  = 81;
    static inline final GLFW_KEY_R                  = 82;
    static inline final GLFW_KEY_S                  = 83;
    static inline final GLFW_KEY_T                  = 84;
    static inline final GLFW_KEY_U                  = 85;
    static inline final GLFW_KEY_V                  = 86;
    static inline final GLFW_KEY_W                  = 87;
    static inline final GLFW_KEY_X                  = 88;
    static inline final GLFW_KEY_Y                  = 89;
    static inline final GLFW_KEY_Z                  = 90;
    static inline final GLFW_KEY_LEFT_BRACKET       = 91  /* [ */;
    static inline final GLFW_KEY_BACKSLASH          = 92  /* \ */;
    static inline final GLFW_KEY_RIGHT_BRACKET      = 93  /* ] */;
    static inline final GLFW_KEY_GRAVE_ACCENT       = 96  /* ` */;
    static inline final GLFW_KEY_WORLD_1            = 161 /* non-US #1 */;
    static inline final GLFW_KEY_WORLD_2            = 162 /* non-US #2 */;

    /* Function keys */
    static inline final GLFW_KEY_ESCAPE             = 256;
    static inline final GLFW_KEY_ENTER              = 257;
    static inline final GLFW_KEY_TAB                = 258;
    static inline final GLFW_KEY_BACKSPACE          = 259;
    static inline final GLFW_KEY_INSERT             = 260;
    static inline final GLFW_KEY_DELETE             = 261;
    static inline final GLFW_KEY_RIGHT              = 262;
    static inline final GLFW_KEY_LEFT               = 263;
    static inline final GLFW_KEY_DOWN               = 264;
    static inline final GLFW_KEY_UP                 = 265;
    static inline final GLFW_KEY_PAGE_UP            = 266;
    static inline final GLFW_KEY_PAGE_DOWN          = 267;
    static inline final GLFW_KEY_HOME               = 268;
    static inline final GLFW_KEY_END                = 269;
    static inline final GLFW_KEY_CAPS_LOCK          = 280;
    static inline final GLFW_KEY_SCROLL_LOCK        = 281;
    static inline final GLFW_KEY_NUM_LOCK           = 282;
    static inline final GLFW_KEY_PRINT_SCREEN       = 283;
    static inline final GLFW_KEY_PAUSE              = 284;
    static inline final GLFW_KEY_F1                 = 290;
    static inline final GLFW_KEY_F2                 = 291;
    static inline final GLFW_KEY_F3                 = 292;
    static inline final GLFW_KEY_F4                 = 293;
    static inline final GLFW_KEY_F5                 = 294;
    static inline final GLFW_KEY_F6                 = 295;
    static inline final GLFW_KEY_F7                 = 296;
    static inline final GLFW_KEY_F8                 = 297;
    static inline final GLFW_KEY_F9                 = 298;
    static inline final GLFW_KEY_F10                = 299;
    static inline final GLFW_KEY_F11                = 300;
    static inline final GLFW_KEY_F12                = 301;
    static inline final GLFW_KEY_F13                = 302;
    static inline final GLFW_KEY_F14                = 303;
    static inline final GLFW_KEY_F15                = 304;
    static inline final GLFW_KEY_F16                = 305;
    static inline final GLFW_KEY_F17                = 306;
    static inline final GLFW_KEY_F18                = 307;
    static inline final GLFW_KEY_F19                = 308;
    static inline final GLFW_KEY_F20                = 309;
    static inline final GLFW_KEY_F21                = 310;
    static inline final GLFW_KEY_F22                = 311;
    static inline final GLFW_KEY_F23                = 312;
    static inline final GLFW_KEY_F24                = 313;
    static inline final GLFW_KEY_F25                = 314;
    static inline final GLFW_KEY_KP_0               = 320;
    static inline final GLFW_KEY_KP_1               = 321;
    static inline final GLFW_KEY_KP_2               = 322;
    static inline final GLFW_KEY_KP_3               = 323;
    static inline final GLFW_KEY_KP_4               = 324;
    static inline final GLFW_KEY_KP_5               = 325;
    static inline final GLFW_KEY_KP_6               = 326;
    static inline final GLFW_KEY_KP_7               = 327;
    static inline final GLFW_KEY_KP_8               = 328;
    static inline final GLFW_KEY_KP_9               = 329;
    static inline final GLFW_KEY_KP_DECIMAL         = 330;
    static inline final GLFW_KEY_KP_DIVIDE          = 331;
    static inline final GLFW_KEY_KP_MULTIPLY        = 332;
    static inline final GLFW_KEY_KP_SUBTRACT        = 333;
    static inline final GLFW_KEY_KP_ADD             = 334;
    static inline final GLFW_KEY_KP_ENTER           = 335;
    static inline final GLFW_KEY_KP_EQUAL           = 336;
    static inline final GLFW_KEY_LEFT_SHIFT         = 340;
    static inline final GLFW_KEY_LEFT_CONTROL       = 341;
    static inline final GLFW_KEY_LEFT_ALT           = 342;
    static inline final GLFW_KEY_LEFT_SUPER         = 343;
    static inline final GLFW_KEY_RIGHT_SHIFT        = 344;
    static inline final GLFW_KEY_RIGHT_CONTROL      = 345;
    static inline final GLFW_KEY_RIGHT_ALT          = 346;
    static inline final GLFW_KEY_RIGHT_SUPER        = 347;
    static inline final GLFW_KEY_MENU               = 348;

    static inline final GLFW_KEY_LAST               = GLFW_KEY_MENU;

    /*! @} */

    /*! @defgroup mods Modifier key flags
     *  @brief Modifier key flags.
     *
     *  See [key input](@ref input_key) for how these are used.
     *
     *  @ingroup input
     *  @{ */

    /*! @brief If this bit is set one or more Shift keys were held down.
     *
     *  If this bit is set one or more Shift keys were held down.
     */
    static inline final GLFW_MOD_SHIFT           = 0x0001;
    /*! @brief If this bit is set one or more Control keys were held down.
     *
     *  If this bit is set one or more Control keys were held down.
     */
    static inline final GLFW_MOD_CONTROL         = 0x0002;
    /*! @brief If this bit is set one or more Alt keys were held down.
     *
     *  If this bit is set one or more Alt keys were held down.
     */
    static inline final GLFW_MOD_ALT             = 0x0004;
    /*! @brief If this bit is set one or more Super keys were held down.
     *
     *  If this bit is set one or more Super keys were held down.
     */
    static inline final GLFW_MOD_SUPER           = 0x0008;
    /*! @brief If this bit is set the Caps Lock key is enabled.
     *
     *  If this bit is set the Caps Lock key is enabled and the @ref
     *  GLFW_LOCK_KEY_MODS input mode is set.
     */
    static inline final GLFW_MOD_CAPS_LOCK       = 0x0010;
    /*! @brief If this bit is set the Num Lock key is enabled.
     *
     *  If this bit is set the Num Lock key is enabled and the @ref
     *  GLFW_LOCK_KEY_MODS input mode is set.
     */
    static inline final GLFW_MOD_NUM_LOCK        = 0x0020;

    /*! @} */

    /*! @defgroup buttons Mouse buttons
     *  @brief Mouse button IDs.
     *
     *  See [mouse button input](@ref input_mouse_button) for how these are used.
     *
     *  @ingroup input
     *  @{ */
    static inline final GLFW_MOUSE_BUTTON_1         = 0;
    static inline final GLFW_MOUSE_BUTTON_2         = 1;
    static inline final GLFW_MOUSE_BUTTON_3         = 2;
    static inline final GLFW_MOUSE_BUTTON_4         = 3;
    static inline final GLFW_MOUSE_BUTTON_5         = 4;
    static inline final GLFW_MOUSE_BUTTON_6         = 5;
    static inline final GLFW_MOUSE_BUTTON_7         = 6;
    static inline final GLFW_MOUSE_BUTTON_8         = 7;
    static inline final GLFW_MOUSE_BUTTON_LAST      = GLFW_MOUSE_BUTTON_8;
    static inline final GLFW_MOUSE_BUTTON_LEFT      = GLFW_MOUSE_BUTTON_1;
    static inline final GLFW_MOUSE_BUTTON_RIGHT     = GLFW_MOUSE_BUTTON_2;
    static inline final GLFW_MOUSE_BUTTON_MIDDLE    = GLFW_MOUSE_BUTTON_3;
    /*! @} */

    /*! @defgroup joysticks Joysticks
     *  @brief Joystick IDs.
     *
     *  See [joystick input](@ref joystick) for how these are used.
     *
     *  @ingroup input
     *  @{ */
    static inline final GLFW_JOYSTICK_1             = 0;
    static inline final GLFW_JOYSTICK_2             = 1;
    static inline final GLFW_JOYSTICK_3             = 2;
    static inline final GLFW_JOYSTICK_4             = 3;
    static inline final GLFW_JOYSTICK_5             = 4;
    static inline final GLFW_JOYSTICK_6             = 5;
    static inline final GLFW_JOYSTICK_7             = 6;
    static inline final GLFW_JOYSTICK_8             = 7;
    static inline final GLFW_JOYSTICK_9             = 8;
    static inline final GLFW_JOYSTICK_10            = 9;
    static inline final GLFW_JOYSTICK_11            = 10;
    static inline final GLFW_JOYSTICK_12            = 11;
    static inline final GLFW_JOYSTICK_13            = 12;
    static inline final GLFW_JOYSTICK_14            = 13;
    static inline final GLFW_JOYSTICK_15            = 14;
    static inline final GLFW_JOYSTICK_16            = 15;
    static inline final GLFW_JOYSTICK_LAST          = GLFW_JOYSTICK_16;
    /*! @} */

    /*! @defgroup gamepad_buttons Gamepad buttons
     *  @brief Gamepad buttons.
     *
     *  See @ref gamepad for how these are used.
     *
     *  @ingroup input
     *  @{ */
    static inline final GLFW_GAMEPAD_BUTTON_A               = 0;
    static inline final GLFW_GAMEPAD_BUTTON_B               = 1;
    static inline final GLFW_GAMEPAD_BUTTON_X               = 2;
    static inline final GLFW_GAMEPAD_BUTTON_Y               = 3;
    static inline final GLFW_GAMEPAD_BUTTON_LEFT_BUMPER     = 4;
    static inline final GLFW_GAMEPAD_BUTTON_RIGHT_BUMPER    = 5;
    static inline final GLFW_GAMEPAD_BUTTON_BACK            = 6;
    static inline final GLFW_GAMEPAD_BUTTON_START           = 7;
    static inline final GLFW_GAMEPAD_BUTTON_GUIDE           = 8;
    static inline final GLFW_GAMEPAD_BUTTON_LEFT_THUMB      = 9;
    static inline final GLFW_GAMEPAD_BUTTON_RIGHT_THUMB     = 10;
    static inline final GLFW_GAMEPAD_BUTTON_DPAD_UP         = 11;
    static inline final GLFW_GAMEPAD_BUTTON_DPAD_RIGHT      = 12;
    static inline final GLFW_GAMEPAD_BUTTON_DPAD_DOWN       = 13;
    static inline final GLFW_GAMEPAD_BUTTON_DPAD_LEFT       = 14;
    static inline final GLFW_GAMEPAD_BUTTON_LAST            = GLFW_GAMEPAD_BUTTON_DPAD_LEFT;

    static inline final GLFW_GAMEPAD_BUTTON_CROSS       = GLFW_GAMEPAD_BUTTON_A;
    static inline final GLFW_GAMEPAD_BUTTON_CIRCLE      = GLFW_GAMEPAD_BUTTON_B;
    static inline final GLFW_GAMEPAD_BUTTON_SQUARE      = GLFW_GAMEPAD_BUTTON_X;
    static inline final GLFW_GAMEPAD_BUTTON_TRIANGLE    = GLFW_GAMEPAD_BUTTON_Y;
    /*! @} */

    /*! @defgroup gamepad_axes Gamepad axes
     *  @brief Gamepad axes.
     *
     *  See @ref gamepad for how these are used.
     *
     *  @ingroup input
     *  @{ */
    static inline final GLFW_GAMEPAD_AXIS_LEFT_X        = 0;
    static inline final GLFW_GAMEPAD_AXIS_LEFT_Y        = 1;
    static inline final GLFW_GAMEPAD_AXIS_RIGHT_X       = 2;
    static inline final GLFW_GAMEPAD_AXIS_RIGHT_Y       = 3;
    static inline final GLFW_GAMEPAD_AXIS_LEFT_TRIGGER  = 4;
    static inline final GLFW_GAMEPAD_AXIS_RIGHT_TRIGGER = 5;
    static inline final GLFW_GAMEPAD_AXIS_LAST          = GLFW_GAMEPAD_AXIS_RIGHT_TRIGGER;
    /*! @} */

    /*! @defgroup errors Error codes
     *  @brief Error codes.
     *
     *  See [error handling](@ref error_handling) for how these are used.
     *
     *  @ingroup init
     *  @{ */
    /*! @brief No error has occurred.
     *
     *  No error has occurred.
     *
     *  @analysis Yay.
     */
    static inline final GLFW_NO_ERROR               = 0;
    /*! @brief GLFW has not been initialized.
     *
     *  This occurs if a GLFW function was called that must not be called unless the
     *  library is [initialized](@ref intro_init).
     *
     *  @analysis Application programmer error.  Initialize GLFW before calling any
     *  function that requires initialization.
     */
    static inline final GLFW_NOT_INITIALIZED        = 0x00010001;
    /*! @brief No context is current for this thread.
     *
     *  This occurs if a GLFW function was called that needs and operates on the
     *  current OpenGL or OpenGL ES context but no context is current on the calling
     *  thread.  One such function is @ref glfwSwapInterval.
     *
     *  @analysis Application programmer error.  Ensure a context is current before
     *  calling functions that require a current context.
     */
    static inline final GLFW_NO_CURRENT_CONTEXT     = 0x00010002;
    /*! @brief One of the arguments to the function was an invalid enum value.
     *
     *  One of the arguments to the function was an invalid enum value, for example
     *  requesting @ref GLFW_RED_BITS with @ref glfwGetWindowAttrib.
     *
     *  @analysis Application programmer error.  Fix the offending call.
     */
    static inline final GLFW_INVALID_ENUM           = 0x00010003;
    /*! @brief One of the arguments to the function was an invalid value.
     *
     *  One of the arguments to the function was an invalid value, for example
     *  requesting a non-existent OpenGL or OpenGL ES version like 2.7.
     *
     *  Requesting a valid but unavailable OpenGL or OpenGL ES version will instead
     *  result in a @ref GLFW_VERSION_UNAVAILABLE error.
     *
     *  @analysis Application programmer error.  Fix the offending call.
     */
    static inline final GLFW_INVALID_VALUE          = 0x00010004;
    /*! @brief A memory allocation failed.
     *
     *  A memory allocation failed.
     *
     *  @analysis A bug in GLFW or the underlying operating system.  Report the bug
     *  to our [issue tracker](https://github.com/glfw/glfw/issues).
     */
    static inline final GLFW_OUT_OF_MEMORY          = 0x00010005;
    /*! @brief GLFW could not find support for the requested API on the system.
     *
     *  GLFW could not find support for the requested API on the system.
     *
     *  @analysis The installed graphics driver does not support the requested
     *  API, or does not support it via the chosen context creation backend.
     *  Below are a few examples.
     *
     *  @par
     *  Some pre-installed Windows graphics drivers do not support OpenGL.  AMD only
     *  supports OpenGL ES via EGL, while Nvidia and Intel only support it via
     *  a WGL or GLX extension.  macOS does not provide OpenGL ES at all.  The Mesa
     *  EGL, OpenGL and OpenGL ES libraries do not interface with the Nvidia binary
     *  driver.  Older graphics drivers do not support Vulkan.
     */
    static inline final GLFW_API_UNAVAILABLE        = 0x00010006;
    /*! @brief The requested OpenGL or OpenGL ES version is not available.
     *
     *  The requested OpenGL or OpenGL ES version (including any requested context
     *  or framebuffer hints) is not available on this machine.
     *
     *  @analysis The machine does not support your requirements.  If your
     *  application is sufficiently flexible, downgrade your requirements and try
     *  again.  Otherwise, inform the user that their machine does not match your
     *  requirements.
     *
     *  @par
     *  Future invalid OpenGL and OpenGL ES versions, for example OpenGL 4.8 if 5.0
     *  comes out before the 4.x series gets that far, also fail with this error and
     *  not @ref GLFW_INVALID_VALUE, because GLFW cannot know what future versions
     *  will exist.
     */
    static inline final GLFW_VERSION_UNAVAILABLE    = 0x00010007;
    /*! @brief A platform-specific error occurred that does not match any of the
     *  more specific categories.
     *
     *  A platform-specific error occurred that does not match any of the more
     *  specific categories.
     *
     *  @analysis A bug or configuration error in GLFW, the underlying operating
     *  system or its drivers, or a lack of required resources.  Report the issue to
     *  our [issue tracker](https://github.com/glfw/glfw/issues).
     */
    static inline final GLFW_PLATFORM_ERROR         = 0x00010008;
    /*! @brief The requested format is not supported or available.
     *
     *  If emitted during window creation, the requested pixel format is not
     *  supported.
     *
     *  If emitted when querying the clipboard, the contents of the clipboard could
     *  not be converted to the requested format.
     *
     *  @analysis If emitted during window creation, one or more
     *  [hard constraints](@ref window_hints_hard) did not match any of the
     *  available pixel formats.  If your application is sufficiently flexible,
     *  downgrade your requirements and try again.  Otherwise, inform the user that
     *  their machine does not match your requirements.
     *
     *  @par
     *  If emitted when querying the clipboard, ignore the error or report it to
     *  the user, as appropriate.
     */
    static inline final GLFW_FORMAT_UNAVAILABLE     = 0x00010009;
    /*! @brief The specified window does not have an OpenGL or OpenGL ES context.
     *
     *  A window that does not have an OpenGL or OpenGL ES context was passed to
     *  a function that requires it to have one.
     *
     *  @analysis Application programmer error.  Fix the offending call.
     */
    static inline final GLFW_NO_WINDOW_CONTEXT      = 0x0001000A;
    /*! @} */

    /*! @addtogroup window
     *  @{ */
    /*! @brief Input focus window hint and attribute
     *
     *  Input focus [window hint](@ref GLFW_FOCUSED_hint) or
     *  [window attribute](@ref GLFW_FOCUSED_attrib).
     */
    static inline final GLFW_FOCUSED                = 0x00020001;
    /*! @brief Window iconification window attribute
     *
     *  Window iconification [window attribute](@ref GLFW_ICONIFIED_attrib).
     */
    static inline final GLFW_ICONIFIED              = 0x00020002;
    /*! @brief Window resize-ability window hint and attribute
     *
     *  Window resize-ability [window hint](@ref GLFW_RESIZABLE_hint) and
     *  [window attribute](@ref GLFW_RESIZABLE_attrib).
     */
    static inline final GLFW_RESIZABLE              = 0x00020003;
    /*! @brief Window visibility window hint and attribute
     *
     *  Window visibility [window hint](@ref GLFW_VISIBLE_hint) and
     *  [window attribute](@ref GLFW_VISIBLE_attrib).
     */
    static inline final GLFW_VISIBLE                = 0x00020004;
    /*! @brief Window decoration window hint and attribute
     *
     *  Window decoration [window hint](@ref GLFW_DECORATED_hint) and
     *  [window attribute](@ref GLFW_DECORATED_attrib).
     */
    static inline final GLFW_DECORATED              = 0x00020005;
    /*! @brief Window auto-iconification window hint and attribute
     *
     *  Window auto-iconification [window hint](@ref GLFW_AUTO_ICONIFY_hint) and
     *  [window attribute](@ref GLFW_AUTO_ICONIFY_attrib).
     */
    static inline final GLFW_AUTO_ICONIFY           = 0x00020006;
    /*! @brief Window decoration window hint and attribute
     *
     *  Window decoration [window hint](@ref GLFW_FLOATING_hint) and
     *  [window attribute](@ref GLFW_FLOATING_attrib).
     */
    static inline final GLFW_FLOATING               = 0x00020007;
    /*! @brief Window maximization window hint and attribute
     *
     *  Window maximization [window hint](@ref GLFW_MAXIMIZED_hint) and
     *  [window attribute](@ref GLFW_MAXIMIZED_attrib).
     */
    static inline final GLFW_MAXIMIZED              = 0x00020008;
    /*! @brief Cursor centering window hint
     *
     *  Cursor centering [window hint](@ref GLFW_CENTER_CURSOR_hint).
     */
    static inline final GLFW_CENTER_CURSOR          = 0x00020009;
    /*! @brief Window framebuffer transparency hint and attribute
     *
     *  Window framebuffer transparency
     *  [window hint](@ref GLFW_TRANSPARENT_FRAMEBUFFER_hint) and
     *  [window attribute](@ref GLFW_TRANSPARENT_FRAMEBUFFER_attrib).
     */
    static inline final GLFW_TRANSPARENT_FRAMEBUFFER = 0x0002000A;
    /*! @brief Mouse cursor hover window attribute.
     *
     *  Mouse cursor hover [window attribute](@ref GLFW_HOVERED_attrib).
     */
    static inline final GLFW_HOVERED                = 0x0002000B;
    /*! @brief Input focus on calling show window hint and attribute
     *
     *  Input focus [window hint](@ref GLFW_FOCUS_ON_SHOW_hint) or
     *  [window attribute](@ref GLFW_FOCUS_ON_SHOW_attrib).
     */
    static inline final GLFW_FOCUS_ON_SHOW          = 0x0002000C;

    /*! @brief Framebuffer bit depth hint.
     *
     *  Framebuffer bit depth [hint](@ref GLFW_RED_BITS).
     */
    static inline final GLFW_RED_BITS               = 0x00021001;
    /*! @brief Framebuffer bit depth hint.
     *
     *  Framebuffer bit depth [hint](@ref GLFW_GREEN_BITS).
     */
    static inline final GLFW_GREEN_BITS             = 0x00021002;
    /*! @brief Framebuffer bit depth hint.
     *
     *  Framebuffer bit depth [hint](@ref GLFW_BLUE_BITS).
     */
    static inline final GLFW_BLUE_BITS              = 0x00021003;
    /*! @brief Framebuffer bit depth hint.
     *
     *  Framebuffer bit depth [hint](@ref GLFW_ALPHA_BITS).
     */
    static inline final GLFW_ALPHA_BITS             = 0x00021004;
    /*! @brief Framebuffer bit depth hint.
     *
     *  Framebuffer bit depth [hint](@ref GLFW_DEPTH_BITS).
     */
    static inline final GLFW_DEPTH_BITS             = 0x00021005;
    /*! @brief Framebuffer bit depth hint.
     *
     *  Framebuffer bit depth [hint](@ref GLFW_STENCIL_BITS).
     */
    static inline final GLFW_STENCIL_BITS           = 0x00021006;
    /*! @brief Framebuffer bit depth hint.
     *
     *  Framebuffer bit depth [hint](@ref GLFW_ACCUM_RED_BITS).
     */
    static inline final GLFW_ACCUM_RED_BITS         = 0x00021007;
    /*! @brief Framebuffer bit depth hint.
     *
     *  Framebuffer bit depth [hint](@ref GLFW_ACCUM_GREEN_BITS).
     */
    static inline final GLFW_ACCUM_GREEN_BITS       = 0x00021008;
    /*! @brief Framebuffer bit depth hint.
     *
     *  Framebuffer bit depth [hint](@ref GLFW_ACCUM_BLUE_BITS).
     */
    static inline final GLFW_ACCUM_BLUE_BITS        = 0x00021009;
    /*! @brief Framebuffer bit depth hint.
     *
     *  Framebuffer bit depth [hint](@ref GLFW_ACCUM_ALPHA_BITS).
     */
    static inline final GLFW_ACCUM_ALPHA_BITS       = 0x0002100A;
    /*! @brief Framebuffer auxiliary buffer hint.
     *
     *  Framebuffer auxiliary buffer [hint](@ref GLFW_AUX_BUFFERS).
     */
    static inline final GLFW_AUX_BUFFERS            = 0x0002100B;
    /*! @brief OpenGL stereoscopic rendering hint.
     *
     *  OpenGL stereoscopic rendering [hint](@ref GLFW_STEREO).
     */
    static inline final GLFW_STEREO                 = 0x0002100C;
    /*! @brief Framebuffer MSAA samples hint.
     *
     *  Framebuffer MSAA samples [hint](@ref GLFW_SAMPLES).
     */
    static inline final GLFW_SAMPLES                = 0x0002100D;
    /*! @brief Framebuffer sRGB hint.
     *
     *  Framebuffer sRGB [hint](@ref GLFW_SRGB_CAPABLE).
     */
    static inline final GLFW_SRGB_CAPABLE           = 0x0002100E;
    /*! @brief Monitor refresh rate hint.
     *
     *  Monitor refresh rate [hint](@ref GLFW_REFRESH_RATE).
     */
    static inline final GLFW_REFRESH_RATE           = 0x0002100F;
    /*! @brief Framebuffer double buffering hint.
     *
     *  Framebuffer double buffering [hint](@ref GLFW_DOUBLEBUFFER).
     */
    static inline final GLFW_DOUBLEBUFFER           = 0x00021010;

    /*! @brief Context client API hint and attribute.
     *
     *  Context client API [hint](@ref GLFW_CLIENT_API_hint) and
     *  [attribute](@ref GLFW_CLIENT_API_attrib).
     */
    static inline final GLFW_CLIENT_API             = 0x00022001;
    /*! @brief Context client API major version hint and attribute.
     *
     *  Context client API major version [hint](@ref GLFW_CLIENT_API_hint) and
     *  [attribute](@ref GLFW_CLIENT_API_attrib).
     */
    static inline final GLFW_CONTEXT_VERSION_MAJOR  = 0x00022002;
    /*! @brief Context client API minor version hint and attribute.
     *
     *  Context client API minor version [hint](@ref GLFW_CLIENT_API_hint) and
     *  [attribute](@ref GLFW_CLIENT_API_attrib).
     */
    static inline final GLFW_CONTEXT_VERSION_MINOR  = 0x00022003;
    /*! @brief Context client API revision number hint and attribute.
     *
     *  Context client API revision number [hint](@ref GLFW_CLIENT_API_hint) and
     *  [attribute](@ref GLFW_CLIENT_API_attrib).
     */
    static inline final GLFW_CONTEXT_REVISION       = 0x00022004;
    /*! @brief Context robustness hint and attribute.
     *
     *  Context client API revision number [hint](@ref GLFW_CLIENT_API_hint) and
     *  [attribute](@ref GLFW_CLIENT_API_attrib).
     */
    static inline final GLFW_CONTEXT_ROBUSTNESS     = 0x00022005;
    /*! @brief OpenGL forward-compatibility hint and attribute.
     *
     *  OpenGL forward-compatibility [hint](@ref GLFW_CLIENT_API_hint) and
     *  [attribute](@ref GLFW_CLIENT_API_attrib).
     */
    static inline final GLFW_OPENGL_FORWARD_COMPAT  = 0x00022006;
    /*! @brief OpenGL debug context hint and attribute.
     *
     *  OpenGL debug context [hint](@ref GLFW_CLIENT_API_hint) and
     *  [attribute](@ref GLFW_CLIENT_API_attrib).
     */
    static inline final GLFW_OPENGL_DEBUG_CONTEXT   = 0x00022007;
    /*! @brief OpenGL profile hint and attribute.
     *
     *  OpenGL profile [hint](@ref GLFW_CLIENT_API_hint) and
     *  [attribute](@ref GLFW_CLIENT_API_attrib).
     */
    static inline final GLFW_OPENGL_PROFILE         = 0x00022008;
    /*! @brief Context flush-on-release hint and attribute.
     *
     *  Context flush-on-release [hint](@ref GLFW_CLIENT_API_hint) and
     *  [attribute](@ref GLFW_CLIENT_API_attrib).
     */
    static inline final GLFW_CONTEXT_RELEASE_BEHAVIOR = 0x00022009;
    /*! @brief Context error suppression hint and attribute.
     *
     *  Context error suppression [hint](@ref GLFW_CLIENT_API_hint) and
     *  [attribute](@ref GLFW_CLIENT_API_attrib).
     */
    static inline final GLFW_CONTEXT_NO_ERROR       = 0x0002200A;
    /*! @brief Context creation API hint and attribute.
     *
     *  Context creation API [hint](@ref GLFW_CLIENT_API_hint) and
     *  [attribute](@ref GLFW_CLIENT_API_attrib).
     */
    static inline final GLFW_CONTEXT_CREATION_API   = 0x0002200B;
    /*! @brief Window content area scaling window
     *  [window hint](@ref GLFW_SCALE_TO_MONITOR).
     */
    static inline final GLFW_SCALE_TO_MONITOR       = 0x0002200C;
    /*! @brief macOS specific
     *  [window hint](@ref GLFW_COCOA_RETINA_FRAMEBUFFER_hint).
     */
    static inline final GLFW_COCOA_RETINA_FRAMEBUFFER = 0x00023001;
    /*! @brief macOS specific
     *  [window hint](@ref GLFW_COCOA_FRAME_NAME_hint).
     */
    static inline final GLFW_COCOA_FRAME_NAME         = 0x00023002;
    /*! @brief macOS specific
     *  [window hint](@ref GLFW_COCOA_GRAPHICS_SWITCHING_hint).
     */
    static inline final GLFW_COCOA_GRAPHICS_SWITCHING = 0x00023003;
    /*! @brief X11 specific
     *  [window hint](@ref GLFW_X11_CLASS_NAME_hint).
     */
    static inline final GLFW_X11_CLASS_NAME         = 0x00024001;
    /*! @brief X11 specific
     *  [window hint](@ref GLFW_X11_CLASS_NAME_hint).
     */
    static inline final GLFW_X11_INSTANCE_NAME      = 0x00024002;
    /*! @} */

    static inline final GLFW_NO_API                          = 0;
    static inline final GLFW_OPENGL_API             = 0x00030001;
    static inline final GLFW_OPENGL_ES_API          = 0x00030002;

    static inline final GLFW_NO_ROBUSTNESS                   = 0;
    static inline final GLFW_NO_RESET_NOTIFICATION  = 0x00031001;
    static inline final GLFW_LOSE_CONTEXT_ON_RESET  = 0x00031002;

    static inline final GLFW_OPENGL_ANY_PROFILE              = 0;
    static inline final GLFW_OPENGL_CORE_PROFILE    = 0x00032001;
    static inline final GLFW_OPENGL_COMPAT_PROFILE  = 0x00032002;

    static inline final GLFW_CURSOR                 = 0x00033001;
    static inline final GLFW_STICKY_KEYS            = 0x00033002;
    static inline final GLFW_STICKY_MOUSE_BUTTONS   = 0x00033003;
    static inline final GLFW_LOCK_KEY_MODS          = 0x00033004;
    static inline final GLFW_RAW_MOUSE_MOTION       = 0x00033005;

    static inline final GLFW_CURSOR_NORMAL          = 0x00034001;
    static inline final GLFW_CURSOR_HIDDEN          = 0x00034002;
    static inline final GLFW_CURSOR_DISABLED        = 0x00034003;

    static inline final GLFW_ANY_RELEASE_BEHAVIOR            = 0;
    static inline final GLFW_RELEASE_BEHAVIOR_FLUSH = 0x00035001;
    static inline final GLFW_RELEASE_BEHAVIOR_NONE  = 0x00035002;

    static inline final GLFW_NATIVE_CONTEXT_API     = 0x00036001;
    static inline final GLFW_EGL_CONTEXT_API        = 0x00036002;
    static inline final GLFW_OSMESA_CONTEXT_API     = 0x00036003;

    /*! @defgroup shapes Standard cursor shapes
     *  @brief Standard system cursor shapes.
     *
     *  See [standard cursor creation](@ref cursor_standard) for how these are used.
     *
     *  @ingroup input
     *  @{ */

    /*! @brief The regular arrow cursor shape.
     *
     *  The regular arrow cursor.
     */
    static inline final GLFW_ARROW_CURSOR           = 0x00036001;
    /*! @brief The text input I-beam cursor shape.
     *
     *  The text input I-beam cursor shape.
     */
    static inline final GLFW_IBEAM_CURSOR           = 0x00036002;
    /*! @brief The crosshair shape.
     *
     *  The crosshair shape.
     */
    static inline final GLFW_CROSSHAIR_CURSOR       = 0x00036003;
    /*! @brief The hand shape.
     *
     *  The hand shape.
     */
    static inline final GLFW_HAND_CURSOR            = 0x00036004;
    /*! @brief The horizontal resize arrow shape.
     *
     *  The horizontal resize arrow shape.
     */
    static inline final GLFW_HRESIZE_CURSOR         = 0x00036005;
    /*! @brief The vertical resize arrow shape.
     *
     *  The vertical resize arrow shape.
     */
    static inline final GLFW_VRESIZE_CURSOR         = 0x00036006;
    /*! @} */

    static inline final GLFW_CONNECTED              = 0x00040001;
    static inline final GLFW_DISCONNECTED           = 0x00040002;

    /*! @addtogroup init
     *  @{ */
    /*! @brief Joystick hat buttons init hint.
     *
     *  Joystick hat buttons [init hint](@ref GLFW_JOYSTICK_HAT_BUTTONS).
     */
    static inline final GLFW_JOYSTICK_HAT_BUTTONS   = 0x00050001;
    /*! @brief macOS specific init hint.
     *
     *  macOS specific [init hint](@ref GLFW_COCOA_CHDIR_RESOURCES_hint).
     */
    static inline final GLFW_COCOA_CHDIR_RESOURCES  = 0x00051001;
    /*! @brief macOS specific init hint.
     *
     *  macOS specific [init hint](@ref GLFW_COCOA_MENUBAR_hint).
     */
    static inline final GLFW_COCOA_MENUBAR          = 0x00051002;
    /*! @} */

    static inline final GLFW_DONT_CARE              = 1;

	@:native("void") 
	public static function force_include():Void;

} //GLFW
package glfw;

import cpp.Pointer;
import cpp.Reference;
import cpp.Callable;

typedef HWND = cpp.Pointer<cpp.Void>;

@:keep
@:native("GLFWwindow")
@:include('linc_glfw.h')
extern class GLFWwindow {}

@:keep
@:native("GLFWmonitor")
@:include('linc_glfw.h')
extern class GLFWmonitor {}

typedef GLFWerrorfun = Int -> String -> Void;
@:keep
class GLFWErrorHandler {

    static var cb:GLFWerrorfun;

    public static var callable = Callable.fromStaticFunction(GLFWErrorHandler.onError);

    static function onError(error:Int, message:String){
        trace(error+": "+message);
        if(cb != null) cb(error, message);
    }

    public static function setCallback(func:GLFWerrorfun){
        cb = func;
    }
}

typedef GLFWkeycb = Int -> Int -> Int -> Int -> Void;
@:keep
class GLFWKeyHandler {

    static var listeners = new Map<String, GLFWkeycb>();

    public static var callable = Callable.fromStaticFunction(GLFWKeyHandler.onInput);

    static function onInput(win:Pointer<GLFWwindow>, key:Int, scancode:Int, action:Int, mods:Int):Void{
        var ptr = win+"";
        if(listeners.exists(ptr)){
            listeners[ptr](key, scancode, action, mods);
        }
    }

    public static function setCallback(win:Pointer<GLFWwindow>, func:GLFWkeycb):Void{
        listeners[win+""] = func;
    }
}

typedef GLFWmouseposcb = Float -> Float -> Void;
@:keep
class GLFWMouseMoveHandler {

    static var listeners = new Map<String, GLFWmouseposcb>();

    public static var callable = Callable.fromStaticFunction(GLFWMouseMoveHandler.onInput);

    static function onInput(win:Pointer<GLFWwindow>, x:Float, y:Float):Void{
        var ptr = win+"";
        if(listeners.exists(ptr)){
            listeners[ptr](x, y);
        }
    }

    public static function setCallback(win:Pointer<GLFWwindow>, func:GLFWmouseposcb):Void{
        listeners[win+""] = func;
    }
}

typedef GLFWmousebuttoncb = Int -> Int -> Int -> Void;
@:keep
class GLFWMouseButtonHandler {

    static var listeners = new Map<String, GLFWmousebuttoncb>();

    public static var callable = Callable.fromStaticFunction(GLFWMouseButtonHandler.onInput);

    static function onInput(win:Pointer<GLFWwindow>, button:Int, action:Int, mods:Int):Void{
        var ptr = win+"";
        if(listeners.exists(ptr)){
            listeners[ptr](button, action, mods);
        }
    }

    public static function setCallback(win:Pointer<GLFWwindow>, func:GLFWmousebuttoncb):Void{
        listeners[win+""] = func;
    }
}

typedef GLFWmousewheelcb = Float -> Float -> Void;
@:keep
class GLFWMouseWheelHandler {

    static var listeners = new Map<String, GLFWmousewheelcb>();

    public static var callable = Callable.fromStaticFunction(GLFWMouseWheelHandler.onInput);

    static function onInput(win:Pointer<GLFWwindow>, x:Float, y:Float):Void{
        var ptr = win+"";
        if(listeners.exists(ptr)){
            listeners[ptr](x,y);
        }
    }

    public static function setCallback(win:Pointer<GLFWwindow>, func:GLFWmousewheelcb):Void{
        listeners[win+""] = func;
    }
}

@:keep
@:include('linc_glfw.h')
#if !display
@:build(linc.Linc.touch())
@:build(linc.Linc.xml('glfw'))
#end
extern class GLFW {
    //Bindings

    @:native('glfwInit')
    static function glfwInit() : Int;

    @:native('glfwTerminate')
    static function glfwTerminate() : Void;

    static inline function glfwSetErrorCallback(cb:GLFWerrorfun):Void{
        GLFWErrorHandler.setCallback(cb);
        untyped __cpp__("linc::glfw::setErrorCb({0})", cpp.Pointer.addressOf(GLFWErrorHandler.callable));
    }

    static inline function glfwSetKeyCallback(window:Pointer<GLFWwindow>, cb:GLFWkeycb):Void{
        GLFWKeyHandler.setCallback(window, cb);
        untyped __cpp__("linc::glfw::setKeyCb({0}, {1})", window, cpp.Pointer.addressOf(GLFWKeyHandler.callable));
    }

    static inline function glfwSetCursorPosCallback(window:Pointer<GLFWwindow>, cb:GLFWmouseposcb):Void{
        GLFWMouseMoveHandler.setCallback(window, cb);
        untyped __cpp__("linc::glfw::setMouseMoveCb({0}, {1})", window, cpp.Pointer.addressOf(GLFWMouseMoveHandler.callable));
    }

    static inline function glfwSetMouseButtonCallback(window:Pointer<GLFWwindow>, cb:GLFWmousebuttoncb):Void{
        GLFWMouseButtonHandler.setCallback(window, cb);
        untyped __cpp__("linc::glfw::setMouseButtonCb({0}, {1})", window, cpp.Pointer.addressOf(GLFWMouseButtonHandler.callable));
    }

    static inline function glfwSetScrollCallback(window:Pointer<GLFWwindow>, cb:GLFWmousewheelcb):Void{
        GLFWMouseWheelHandler.setCallback(window, cb);
        untyped __cpp__("linc::glfw::setMouseWheelCb({0}, {1})", window, cpp.Pointer.addressOf(GLFWMouseWheelHandler.callable));
    }

    @:native('glfwGetPrimaryMonitor')
    static function glfwGetPrimaryMonitor():Pointer<GLFWmonitor>;

    @:native('glfwSetWindowSize')
    static function glfwSetWindowSize(window:Pointer<GLFWwindow>, width:Int, height:Int):Void;

    @:native('glfwWindowHint')
    static function glfwWindowHint(hint:Int, value:Int):Void;

    @:native('glfwCreateWindow')
    static function glfwCreateWindow(width:Int, height:Int, title:String, monitor:Pointer<GLFWmonitor>, window:Pointer<GLFWwindow>):Pointer<GLFWwindow>;

    @:native('glfwMakeContextCurrent')
    static function glfwMakeContextCurrent(window:Pointer<GLFWwindow>):Void;

    @:native('glfwWindowShouldClose')
    static function glfwWindowShouldClose(window:Pointer<GLFWwindow>):Int;

    @:native('glfwSwapBuffers')
    static function glfwSwapBuffers(window:Pointer<GLFWwindow>):Void;

    @:native('glfwDefaultWindowHints')
    static function glfwDefaultWindowHints():Void;

    // Input shenaningans

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
    static inline var GLFW_VERSION_MAJOR          = 3;
    /*! @brief The minor version number of the GLFW library.
    *
    *  This is incremented when features are added to the API but it remains
    *  backward-compatible.
    *  @ingroup init
    */
    static inline var GLFW_VERSION_MINOR          = 2;
    /*! @brief The revision number of the GLFW library.
    *
    *  This is incremented when a bug fix release is made that does not contain any
    *  API changes.
    *  @ingroup init
    */
    static inline var GLFW_VERSION_REVISION       = 1;
    /*! @} */

    /*! @name Boolean values
    *  @{ */
    /*! @brief One.
    *
    *  One.  Seriously.  You don't _need_ to use this symbol in your code.  It's
    *  just semantic sugar for the number 1.  You can use `1` or `true` or `_True`
    *  or `GL_TRUE` or whatever you want.
    */
    static inline var GLFW_TRUE                   = 1;
    /*! @brief Zero.
    *
    *  Zero.  Seriously.  You don't _need_ to use this symbol in your code.  It's
    *  just just semantic sugar for the number 0.  You can use `0` or `false` or
    *  `_False` or `GL_FALSE` or whatever you want.
    */
    static inline var GLFW_FALSE                  = 0;
    /*! @} */

    /*! @name Key and button actions
    *  @{ */
    /*! @brief The key or mouse button was released.
    *
    *  The key or mouse button was released.
    *
    *  @ingroup input
    */
    static inline var GLFW_RELEASE                = 0;
    /*! @brief The key or mouse button was pressed.
    *
    *  The key or mouse button was pressed.
    *
    *  @ingroup input
    */
    static inline var GLFW_PRESS                  = 1;
    /*! @brief The key was held down until it repeated.
    *
    *  The key was held down until it repeated.
    *
    *  @ingroup input
    */
    static inline var GLFW_REPEAT                 = 2;
    /*! @} */

    /*! @defgroup keys Keyboard keys
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
    static inline var GLFW_KEY_UNKNOWN            = -1;

    /* Printable keys */
    static inline var GLFW_KEY_SPACE              = 32;
    static inline var GLFW_KEY_APOSTROPHE         = 39;  /* ' */
    static inline var GLFW_KEY_COMMA              = 44;  /* , */
    static inline var GLFW_KEY_MINUS              = 45;  /* - */
    static inline var GLFW_KEY_PERIOD             = 46;  /* . */
    static inline var GLFW_KEY_SLASH              = 47;  /* / */
    static inline var GLFW_KEY_0                  = 48;
    static inline var GLFW_KEY_1                  = 49;
    static inline var GLFW_KEY_2                  = 50;
    static inline var GLFW_KEY_3                  = 51;
    static inline var GLFW_KEY_4                  = 52;
    static inline var GLFW_KEY_5                  = 53;
    static inline var GLFW_KEY_6                  = 54;
    static inline var GLFW_KEY_7                  = 55;
    static inline var GLFW_KEY_8                  = 56;
    static inline var GLFW_KEY_9                  = 57;
    static inline var GLFW_KEY_SEMICOLON          = 59;  /* ; */
    static inline var GLFW_KEY_EQUAL              = 61;  /* = */
    static inline var GLFW_KEY_A                  = 65;
    static inline var GLFW_KEY_B                  = 66;
    static inline var GLFW_KEY_C                  = 67;
    static inline var GLFW_KEY_D                  = 68;
    static inline var GLFW_KEY_E                  = 69;
    static inline var GLFW_KEY_F                  = 70;
    static inline var GLFW_KEY_G                  = 71;
    static inline var GLFW_KEY_H                  = 72;
    static inline var GLFW_KEY_I                  = 73;
    static inline var GLFW_KEY_J                  = 74;
    static inline var GLFW_KEY_K                  = 75;
    static inline var GLFW_KEY_L                  = 76;
    static inline var GLFW_KEY_M                  = 77;
    static inline var GLFW_KEY_N                  = 78;
    static inline var GLFW_KEY_O                  = 79;
    static inline var GLFW_KEY_P                  = 80;
    static inline var GLFW_KEY_Q                  = 81;
    static inline var GLFW_KEY_R                  = 82;
    static inline var GLFW_KEY_S                  = 83;
    static inline var GLFW_KEY_T                  = 84;
    static inline var GLFW_KEY_U                  = 85;
    static inline var GLFW_KEY_V                  = 86;
    static inline var GLFW_KEY_W                  = 87;
    static inline var GLFW_KEY_X                  = 88;
    static inline var GLFW_KEY_Y                  = 89;
    static inline var GLFW_KEY_Z                  = 90;
    static inline var GLFW_KEY_LEFT_BRACKET       = 91;  /* [ */
    static inline var GLFW_KEY_BACKSLASH          = 92;  /* \ */
    static inline var GLFW_KEY_RIGHT_BRACKET      = 93;  /* ] */
    static inline var GLFW_KEY_GRAVE_ACCENT       = 96;  /* ` */
    static inline var GLFW_KEY_WORLD_1            = 161; /* non-US #1 */
    static inline var GLFW_KEY_WORLD_2            = 162; /* non-US #2 */

    /* Function keys */
    static inline var GLFW_KEY_ESCAPE             = 256;
    static inline var GLFW_KEY_ENTER              = 257;
    static inline var GLFW_KEY_TAB                = 258;
    static inline var GLFW_KEY_BACKSPACE          = 259;
    static inline var GLFW_KEY_INSERT             = 260;
    static inline var GLFW_KEY_DELETE             = 261;
    static inline var GLFW_KEY_RIGHT              = 262;
    static inline var GLFW_KEY_LEFT               = 263;
    static inline var GLFW_KEY_DOWN               = 264;
    static inline var GLFW_KEY_UP                 = 265;
    static inline var GLFW_KEY_PAGE_UP            = 266;
    static inline var GLFW_KEY_PAGE_DOWN          = 267;
    static inline var GLFW_KEY_HOME               = 268;
    static inline var GLFW_KEY_END                = 269;
    static inline var GLFW_KEY_CAPS_LOCK          = 280;
    static inline var GLFW_KEY_SCROLL_LOCK        = 281;
    static inline var GLFW_KEY_NUM_LOCK           = 282;
    static inline var GLFW_KEY_PRINT_SCREEN       = 283;
    static inline var GLFW_KEY_PAUSE              = 284;
    static inline var GLFW_KEY_F1                 = 290;
    static inline var GLFW_KEY_F2                 = 291;
    static inline var GLFW_KEY_F3                 = 292;
    static inline var GLFW_KEY_F4                 = 293;
    static inline var GLFW_KEY_F5                 = 294;
    static inline var GLFW_KEY_F6                 = 295;
    static inline var GLFW_KEY_F7                 = 296;
    static inline var GLFW_KEY_F8                 = 297;
    static inline var GLFW_KEY_F9                 = 298;
    static inline var GLFW_KEY_F10                = 299;
    static inline var GLFW_KEY_F11                = 300;
    static inline var GLFW_KEY_F12                = 301;
    static inline var GLFW_KEY_F13                = 302;
    static inline var GLFW_KEY_F14                = 303;
    static inline var GLFW_KEY_F15                = 304;
    static inline var GLFW_KEY_F16                = 305;
    static inline var GLFW_KEY_F17                = 306;
    static inline var GLFW_KEY_F18                = 307;
    static inline var GLFW_KEY_F19                = 308;
    static inline var GLFW_KEY_F20                = 309;
    static inline var GLFW_KEY_F21                = 310;
    static inline var GLFW_KEY_F22                = 311;
    static inline var GLFW_KEY_F23                = 312;
    static inline var GLFW_KEY_F24                = 313;
    static inline var GLFW_KEY_F25                = 314;
    static inline var GLFW_KEY_KP_0               = 320;
    static inline var GLFW_KEY_KP_1               = 321;
    static inline var GLFW_KEY_KP_2               = 322;
    static inline var GLFW_KEY_KP_3               = 323;
    static inline var GLFW_KEY_KP_4               = 324;
    static inline var GLFW_KEY_KP_5               = 325;
    static inline var GLFW_KEY_KP_6               = 326;
    static inline var GLFW_KEY_KP_7               = 327;
    static inline var GLFW_KEY_KP_8               = 328;
    static inline var GLFW_KEY_KP_9               = 329;
    static inline var GLFW_KEY_KP_DECIMAL         = 330;
    static inline var GLFW_KEY_KP_DIVIDE          = 331;
    static inline var GLFW_KEY_KP_MULTIPLY        = 332;
    static inline var GLFW_KEY_KP_SUBTRACT        = 333;
    static inline var GLFW_KEY_KP_ADD             = 334;
    static inline var GLFW_KEY_KP_ENTER           = 335;
    static inline var GLFW_KEY_KP_EQUAL           = 336;
    static inline var GLFW_KEY_LEFT_SHIFT         = 340;
    static inline var GLFW_KEY_LEFT_CONTROL       = 341;
    static inline var GLFW_KEY_LEFT_ALT           = 342;
    static inline var GLFW_KEY_LEFT_SUPER         = 343;
    static inline var GLFW_KEY_RIGHT_SHIFT        = 344;
    static inline var GLFW_KEY_RIGHT_CONTROL      = 345;
    static inline var GLFW_KEY_RIGHT_ALT          = 346;
    static inline var GLFW_KEY_RIGHT_SUPER        = 347;
    static inline var GLFW_KEY_MENU               = 348;

    static inline var GLFW_KEY_LAST               = GLFW_KEY_MENU;

    /*! @} */

    /*! @defgroup mods Modifier key flags
    *
    *  See [key input](@ref input_key) for how these are used.
    *
    *  @ingroup input
    *  @{ */

    /*! @brief If this bit is set one or more Shift keys were held down.
    */
    static inline var GLFW_MOD_SHIFT           = 0x0001;
    /*! @brief If this bit is set one or more Control keys were held down.
    */
    static inline var GLFW_MOD_CONTROL         = 0x0002;
    /*! @brief If this bit is set one or more Alt keys were held down.
    */
    static inline var GLFW_MOD_ALT             = 0x0004;
    /*! @brief If this bit is set one or more Super keys were held down.
    */
    static inline var GLFW_MOD_SUPER           = 0x0008;

    /*! @} */

    /*! @defgroup buttons Mouse buttons
    *
    *  See [mouse button input](@ref input_mouse_button) for how these are used.
    *
    *  @ingroup input
    *  @{ */
    static inline var GLFW_MOUSE_BUTTON_1         = 0;
    static inline var GLFW_MOUSE_BUTTON_2         = 1;
    static inline var GLFW_MOUSE_BUTTON_3         = 2;
    static inline var GLFW_MOUSE_BUTTON_4         = 3;
    static inline var GLFW_MOUSE_BUTTON_5         = 4;
    static inline var GLFW_MOUSE_BUTTON_6         = 5;
    static inline var GLFW_MOUSE_BUTTON_7         = 6;
    static inline var GLFW_MOUSE_BUTTON_8         = 7;
    static inline var GLFW_MOUSE_BUTTON_LAST      = GLFW_MOUSE_BUTTON_8;
    static inline var GLFW_MOUSE_BUTTON_LEFT      = GLFW_MOUSE_BUTTON_1;
    static inline var GLFW_MOUSE_BUTTON_RIGHT     = GLFW_MOUSE_BUTTON_2;
    static inline var GLFW_MOUSE_BUTTON_MIDDLE    = GLFW_MOUSE_BUTTON_3;
    /*! @} */

    /*! @defgroup joysticks Joysticks
    *
    *  See [joystick input](@ref joystick) for how these are used.
    *
    *  @ingroup input
    *  @{ */
    static inline var GLFW_JOYSTICK_1             = 0;
    static inline var GLFW_JOYSTICK_2             = 1;
    static inline var GLFW_JOYSTICK_3             = 2;
    static inline var GLFW_JOYSTICK_4             = 3;
    static inline var GLFW_JOYSTICK_5             = 4;
    static inline var GLFW_JOYSTICK_6             = 5;
    static inline var GLFW_JOYSTICK_7             = 6;
    static inline var GLFW_JOYSTICK_8             = 7;
    static inline var GLFW_JOYSTICK_9             = 8;
    static inline var GLFW_JOYSTICK_10            = 9;
    static inline var GLFW_JOYSTICK_11            = 10;
    static inline var GLFW_JOYSTICK_12            = 11;
    static inline var GLFW_JOYSTICK_13            = 12;
    static inline var GLFW_JOYSTICK_14            = 13;
    static inline var GLFW_JOYSTICK_15            = 14;
    static inline var GLFW_JOYSTICK_16            = 15;
    static inline var GLFW_JOYSTICK_LAST          = GLFW_JOYSTICK_16;
    /*! @} */

    /*! @defgroup errors Error codes
    *
    *  See [error handling](@ref error_handling) for how these are used.
    *
    *  @ingroup init
    *  @{ */
    /*! @brief GLFW has not been initialized.
    *
    *  This occurs if a GLFW function was called that must not be called unless the
    *  library is [initialized](@ref intro_init).
    *
    *  @analysis Application programmer error.  Initialize GLFW before calling any
    *  function that requires initialization.
    */
    static inline var GLFW_NOT_INITIALIZED        = 0x00010001;
    /*! @brief No context is current for this thread.
    *
    *  This occurs if a GLFW function was called that needs and operates on the
    *  current OpenGL or OpenGL ES context but no context is current on the calling
    *  thread.  One such function is @ref glfwSwapInterval.
    *
    *  @analysis Application programmer error.  Ensure a context is current before
    *  calling functions that require a current context.
    */
    static inline var GLFW_NO_CURRENT_CONTEXT     = 0x00010002;
    /*! @brief One of the arguments to the function was an invalid enum value.
    *
    *  One of the arguments to the function was an invalid enum value, for example
    *  requesting [GLFW_RED_BITS](@ref window_hints_fb) with @ref
    *  glfwGetWindowAttrib.
    *
    *  @analysis Application programmer error.  Fix the offending call.
    */
    static inline var GLFW_INVALID_ENUM           = 0x00010003;
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
    static inline var GLFW_INVALID_VALUE          = 0x00010004;
    /*! @brief A memory allocation failed.
    *
    *  A memory allocation failed.
    *
    *  @analysis A bug in GLFW or the underlying operating system.  Report the bug
    *  to our [issue tracker](https://github.com/glfw/glfw/issues).
    */
    static inline var GLFW_OUT_OF_MEMORY          = 0x00010005;
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
    *  a WGL or GLX extension.  OS X does not provide OpenGL ES at all.  The Mesa
    *  EGL, OpenGL and OpenGL ES libraries do not interface with the Nvidia binary
    *  driver.  Older graphics drivers do not support Vulkan.
    */
    static inline var GLFW_API_UNAVAILABLE        = 0x00010006;
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
    static inline var GLFW_VERSION_UNAVAILABLE    = 0x00010007;
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
    static inline var GLFW_PLATFORM_ERROR         = 0x00010008;
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
    static inline var GLFW_FORMAT_UNAVAILABLE     = 0x00010009;
    /*! @brief The specified window does not have an OpenGL or OpenGL ES context.
    *
    *  A window that does not have an OpenGL or OpenGL ES context was passed to
    *  a function that requires it to have one.
    *
    *  @analysis Application programmer error.  Fix the offending call.
    */
    static inline var GLFW_NO_WINDOW_CONTEXT      = 0x0001000A;
    /*! @} */

    static inline var GLFW_FOCUSED                = 0x00020001;
    static inline var GLFW_ICONIFIED              = 0x00020002;
    static inline var GLFW_RESIZABLE              = 0x00020003;
    static inline var GLFW_VISIBLE                = 0x00020004;
    static inline var GLFW_DECORATED              = 0x00020005;
    static inline var GLFW_AUTO_ICONIFY           = 0x00020006;
    static inline var GLFW_FLOATING               = 0x00020007;
    static inline var GLFW_MAXIMIZED              = 0x00020008;

    static inline var GLFW_RED_BITS               = 0x00021001;
    static inline var GLFW_GREEN_BITS             = 0x00021002;
    static inline var GLFW_BLUE_BITS              = 0x00021003;
    static inline var GLFW_ALPHA_BITS             = 0x00021004;
    static inline var GLFW_DEPTH_BITS             = 0x00021005;
    static inline var GLFW_STENCIL_BITS           = 0x00021006;
    static inline var GLFW_ACCUM_RED_BITS         = 0x00021007;
    static inline var GLFW_ACCUM_GREEN_BITS       = 0x00021008;
    static inline var GLFW_ACCUM_BLUE_BITS        = 0x00021009;
    static inline var GLFW_ACCUM_ALPHA_BITS       = 0x0002100A;
    static inline var GLFW_AUX_BUFFERS            = 0x0002100B;
    static inline var GLFW_STEREO                 = 0x0002100C;
    static inline var GLFW_SAMPLES                = 0x0002100D;
    static inline var GLFW_SRGB_CAPABLE           = 0x0002100E;
    static inline var GLFW_REFRESH_RATE           = 0x0002100F;
    static inline var GLFW_DOUBLEBUFFER           = 0x00021010;

    static inline var GLFW_CLIENT_API             = 0x00022001;
    static inline var GLFW_CONTEXT_VERSION_MAJOR  = 0x00022002;
    static inline var GLFW_CONTEXT_VERSION_MINOR  = 0x00022003;
    static inline var GLFW_CONTEXT_REVISION       = 0x00022004;
    static inline var GLFW_CONTEXT_ROBUSTNESS     = 0x00022005;
    static inline var GLFW_OPENGL_FORWARD_COMPAT  = 0x00022006;
    static inline var GLFW_OPENGL_DEBUG_CONTEXT   = 0x00022007;
    static inline var GLFW_OPENGL_PROFILE         = 0x00022008;
    static inline var GLFW_CONTEXT_RELEASE_BEHAVIOR = 0x00022009;
    static inline var GLFW_CONTEXT_NO_ERROR       = 0x0002200A;
    static inline var GLFW_CONTEXT_CREATION_API   = 0x0002200B;

    static inline var GLFW_NO_API                          = 0;
    static inline var GLFW_OPENGL_API             = 0x00030001;
    static inline var GLFW_OPENGL_ES_API          = 0x00030002;

    static inline var GLFW_NO_ROBUSTNESS                   = 0;
    static inline var GLFW_NO_RESET_NOTIFICATION  = 0x00031001;
    static inline var GLFW_LOSE_CONTEXT_ON_RESET  = 0x00031002;

    static inline var GLFW_OPENGL_ANY_PROFILE              = 0;
    static inline var GLFW_OPENGL_CORE_PROFILE    = 0x00032001;
    static inline var GLFW_OPENGL_COMPAT_PROFILE  = 0x00032002;

    static inline var GLFW_CURSOR                 = 0x00033001;
    static inline var GLFW_STICKY_KEYS            = 0x00033002;
    static inline var GLFW_STICKY_MOUSE_BUTTONS   = 0x00033003;

    static inline var GLFW_CURSOR_NORMAL          = 0x00034001;
    static inline var GLFW_CURSOR_HIDDEN          = 0x00034002;
    static inline var GLFW_CURSOR_DISABLED        = 0x00034003;

    static inline var GLFW_ANY_RELEASE_BEHAVIOR            = 0;
    static inline var GLFW_RELEASE_BEHAVIOR_FLUSH = 0x00035001;
    static inline var GLFW_RELEASE_BEHAVIOR_NONE  = 0x00035002;

    static inline var GLFW_NATIVE_CONTEXT_API     = 0x00036001;
    static inline var GLFW_EGL_CONTEXT_API        = 0x00036002;

    /*! @defgroup shapes Standard cursor shapes
    *
    *  See [standard cursor creation](@ref cursor_standard) for how these are used.
    *
    *  @ingroup input
    *  @{ */

    /*! @brief The regular arrow cursor shape.
    *
    *  The regular arrow cursor.
    */
    static inline var GLFW_ARROW_CURSOR           = 0x00036001;
    /*! @brief The text input I-beam cursor shape.
    *
    *  The text input I-beam cursor shape.
    */
    static inline var GLFW_IBEAM_CURSOR           = 0x00036002;
    /*! @brief The crosshair shape.
    *
    *  The crosshair shape.
    */
    static inline var GLFW_CROSSHAIR_CURSOR       = 0x00036003;
    /*! @brief The hand shape.
    *
    *  The hand shape.
    */
    static inline var GLFW_HAND_CURSOR            = 0x00036004;
    /*! @brief The horizontal resize arrow shape.
    *
    *  The horizontal resize arrow shape.
    */
    static inline var GLFW_HRESIZE_CURSOR         = 0x00036005;
    /*! @brief The vertical resize arrow shape.
    *
    *  The vertical resize arrow shape.
    */
    static inline var GLFW_VRESIZE_CURSOR         = 0x00036006;
    /*! @} */

    static inline var GLFW_CONNECTED              = 0x00040001;
    static inline var GLFW_DISCONNECTED           = 0x00040002;

    static inline var GLFW_DONT_CARE              = -1;

} //GLFW
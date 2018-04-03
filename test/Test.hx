
class Test {
        
    public static function main(){
        if(glfwInit() != 0){
            var window = glfwCreateWindow(640, 480, "Hello World", null, null);
            glfwMakeContextCurrent(window);

            while (glfwWindowShouldClose(window) != 1)
            {
                glfwPollEvents();
            }
        }else{
            throw 'GLFW init fail';
        }
        trace("Closed");
    }

}
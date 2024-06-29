


//08_load_texture_exercise
#version 330 core
layout(location = 0) in vec3 aPos;
layout(location = 1) in vec3 aColor;
layout(location = 2) in vec2 aTexCoord;

out vec3 ourColor;
out vec2 TexCoord;

void main() {
    gl_Position = vec4(aPos, 1.0f);
    ourColor = aColor;
    TexCoord = aTexCoord * 2.0f;
}
//*/



/* //07_load_texture

#version 330 core
layout(location = 0) in vec3 aPos;
layout(location = 1) in vec3 aColor;
layout(location = 2) in vec2 aTexCoord;

out vec3 ourColor;
out vec2 TexCoord;

void main() {
    gl_Position = vec4(aPos, 1.0f);
    gl_PointSize = 10.0f;
    ourColor = aColor;
    TexCoord = aTexCoord * 2.0;
}


// */

/* //06_glsl_exercise
#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aColor;

out vec3 ourColor;
out vec3 ourPos;

uniform float xOffset;
// vec3(0.0, 0.0, 0.0)

void main(){
    gl_Position = vec4(aPos.x + xOffset, -aPos.y, aPos.z, 1.0f);
    ourColor = aColor;
    ourPos = aPos;
}
// */


/* //05_shader_class
#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aColor;

out vec3 ourColor;

void main(){
    gl_Position = vec4(aPos, 1.0f);
    gl_PointSize = 10.0f;
    ourColor = aColor;
}
// */

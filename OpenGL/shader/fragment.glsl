


//08_load_texture_exercise
#version 330 core
out vec4 FragColor;
in vec3 ourColor;
in vec2 TexCoord;

uniform sampler2D texture1;
uniform sampler2D texture2;

uniform float factor;

void main() {
    FragColor = mix(texture(texture1, TexCoord), texture(texture2, TexCoord), abs(sin(factor * 0.2f)));
    //FragColor = mix(texture(texture1, TexCoord), texture(texture2, TexCoord), 0.2f);
}
//*/

/* //07_load_texture
#version 330 core
in vec3 ourColor;
in vec2 TexCoord;
out vec4 FragColor;

uniform sampler2D texture1;
uniform sampler2D texture2;

void main()
{
    //FragColor = min(texture(texture1,TecCoord),texture(texture2,TexCoord));
    //FragColor = texture(texture1,TexCoord);
    FragColor = texture(texture2,TexCoord);
}
// */


/* //06_glsl_exercise
#version 330 core
out vec4 FracColor;
in vec3 ourColor;
in vec3 ourPos;

void main(){
  FracColor = vec4(ourPos, 1.0f);
}
// */


/* //05_shader_class
#version 330 core
out vec4 FracColor;
in vec3 ourColor;

void main(){
    FracColor = vec4(ourColor, 1.0f);
}
// */
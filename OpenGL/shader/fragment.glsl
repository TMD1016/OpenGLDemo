







//16_use_camera
#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;

uniform sampler2D texture1;
uniform sampler2D texture2;

void main() {
    FragColor = mix(texture(texture1, outTexCoord), texture(texture2, outTexCoord), 0.1);
}

//*/


/*// 15_mvp_matrix_exercise
#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;

uniform sampler2D texture1;
uniform sampler2D texture2;

void main() {
    FragColor = mix(texture(texture1, outTexCoord), texture(texture2, outTexCoord), 0.1);
}
// */

/* //14_use_image_ui

#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;

uniform sampler2D texture1;
uniform sampler2D texture2;

void main() {
    FragColor = mix(texture(texture1, outTexCoord), texture(texture2, outTexCoord), 0.1);
}
//*/

/*// 13_model_view_projection
#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;

uniform sampler2D texture1;
uniform sampler2D texture2;

void main()
{
    FragColor = mix(texture(texture1, outTexCoord), texture(texture2, outTexCoord), 0.1f);
}
// */

/* //12_use_box_geometry
#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;
in float stp;

uniform sampler2D texture1;
uniform sampler2D texture2;

void main() {
    FragColor = mix(texture(texture1, outTexCoord), texture(texture2, outTexCoord), 0.1);

//     vec2 coord = gl_PointCoord - vec2(0.5);
//     float r = float(length(coord) > 0.5);
//     FragColor = vec4(0.0, stp * 0.5, stp, (1 - r) * stp);// 蓝色过度色
}

//*/


/*// 11_use_sphere_geometry
#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;

uniform sampler2D texture1;
uniform sampler2D texture2;

void main() {
    // FragColor = mix(texture(texture1, outTexCoord), texture(texture2, outTexCoord), 0.1);
    // FragColor = vec4(1.0, 0.6, 0.1, 0.3);

    vec2 coord = gl_PointCoord - vec2(1.0);
    float r = float(length(coord) > 0.5);
    FragColor = vec4(0.0, 0.91, 0.9, (1 - r) * 0.9);
}
//*/

/* //10_use_plane_geometry

#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;

uniform sampler2D texture1;
uniform sampler2D texture2;

void main()
{
    //FragColor = mix(texture(texture1, outTexCoord) , texture(texture2, outTexCoord),0.1f);
    FragColor = texture(texture2, outTexCoord);
}


//*/

/* //09_transform

#version 330 core
out vec4 FragColor;
in vec3 ourColor;
in vec3 ourPos;
in vec2 TexCoord;

uniform sampler2D texture1;
uniform sampler2D texture2;

void main() {
    float xy = length(ourPos.xy);
    FragColor = mix(texture(texture1, TexCoord), vec4(ourColor, 1.0f - xy * 2.0f) * texture(texture2, TexCoord), 0.5f);
}
//*/

/* //08_load_texture_exercise
#version 330 core
out vec4 FragColor;
in vec3 ourColor;
in vec2 TexCoord;

uniform sampler2D texture1;
uniform sampler2D texture2;
uniform float factor;

void main() {
    //FragColor = mix(texture(texture1, TexCoord), texture(texture2, TexCoord), abs(sin(factor * 0.2f)));
    FragColor = mix(texture(texture1, TexCoord), texture(texture2, TexCoord), 0.2f);
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
    FragColor = min(texture(texture1,TexCoord),texture(texture2,TexCoord));
    //FragColor = texture(texture1,TexCoord);
    //FragColor = texture(texture2,TexCoord);
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
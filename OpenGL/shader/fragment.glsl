




/*// 19_basic_lighting
#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;
in vec3 outNormal;
in vec3 outFragPos;

uniform vec3 lightColor;
uniform vec3 lightPos;
uniform vec3 viewPos; // 相机位置
uniform float ambientStrength;

uniform sampler2D texture1;
uniform sampler2D texture2;

void main() {

    vec4 objectColor = mix(texture(texture1, outTexCoord), texture(texture2, outTexCoord), 0.1);
    //vec4 objColor = vec4(1.0f, 0.5f, 0.31f, 1.0f);

    vec3 ambient = ambientStrength * lightColor; // 环境光

    vec3 norm = normalize(outNormal);
    vec3 lightDir = normalize(lightPos - outFragPos);

    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = diff * lightColor; // 漫反射

    float specularStrength = 0.9;
    vec3 viewDir = normalize(viewPos - outFragPos);
    vec3 reflectDir = reflect(-lightDir, norm);

    float spec = pow(max(dot(viewDir, reflectDir), 0.0), 256);
    vec3 specular = specularStrength * spec * lightColor; // 镜面光

    vec3 result = (ambient + diffuse + specular) * vec3(objectColor);

    FragColor = vec4(result, 1.0);
}

//*/


/*//18_light_scence

#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;
uniform vec3 lightColor;

uniform sampler2D texture1;
uniform sampler2D texture2;

void main() {
    FragColor = mix(texture(texture1, outTexCoord), texture(texture2, outTexCoord), 0.1);
    // FragColor = vec4(vec3(1.0f, 0.5f, 0.31f) * lightColor, 1.0);
}

//*/

/*//17_use_camera_class

#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;

uniform sampler2D texture1;
uniform sampler2D texture2;

void main() {
    FragColor = mix(texture(texture1, outTexCoord), texture(texture2, outTexCoord), 0.1);
}

//*/

/*//16_use_camera
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

 //12_use_box_geometry
#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;
in float stp;

uniform sampler2D texture1;
uniform sampler2D texture2;

void main()
 {
    //FragColor = mix(texture(texture1, outTexCoord), texture(texture2, outTexCoord), 0.1);

     vec2 coord = gl_PointCoord - vec2(0.5);
     float r = float(length(coord) > 0.5);
     FragColor = vec4(0.0, stp * 0.5,  stp, r * stp);// 蓝色过度色
}

//*/


/*// 11_use_sphere_geometry
#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;

uniform sampler2D texture1;
uniform sampler2D texture2;

void main() {
    //FragColor = mix(texture(texture1, outTexCoord), texture(texture2, outTexCoord), 0.2);
    // FragColor = vec4(1.0, 0.6, 0.1, 0.3);

    vec2 coord = gl_PointCoord - vec2(1.0);
    float r = float(length(coord) > 0.5);
    FragColor = vec4(0.0, 0.91, 0.9, (1 - r) * 0.9);
}
//*/

/* //10_use_plane_geometry

#version 330 core
in vec2 outTexCoord;
out vec4 FragColor;

uniform sampler2D texture1;
uniform sampler2D texture2;

void main()
{
    FragColor = mix(texture(texture1, outTexCoord) , texture(texture2, outTexCoord),0.5f);
    //FragColor = texture(texture2, outTexCoord);
}

//*/

 /*//09_transform

#version 330 core

in vec3 ourPos;
in vec3 ourColor;
in vec2 TexCoord;

out vec4 FragColor;

uniform sampler2D texture1;
uniform sampler2D texture2;

void main() {
    float xy = length(ourPos.xy);
    FragColor = mix(texture(texture1, TexCoord),  vec4(ourColor, 1.0f - xy * 2.0f) *texture(texture2, TexCoord), 0.5f);
    //FragColor = mix(texture(texture1, TexCoord), texture(texture2, TexCoord), 0.5f);
    //FragColor = texture(texture1,TexCoord);
    //FragColor = texture(texture2,TexCoord);
    //FragColor = vec4(ourColor, 1.0f);
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
    //FragColor = vec4(ourColor, 1.0f);
    //FragColor = texture(texture1,TexCoord);
    //FragColor = texture(texture2,TexCoord);
    FragColor = min(texture(texture1,TexCoord),texture(texture2,TexCoord));

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
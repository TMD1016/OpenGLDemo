



/*//20_light_material
#version 330 core
layout(location = 0) in vec3 Position;
layout(location = 1) in vec3 Normal;
layout(location = 2) in vec2 TexCoords;

out vec2 outTexCoord;
out vec3 outNormal;
out vec3 outFragPos;

uniform float factor;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void main() {

    gl_Position = projection * view * model * vec4(Position, 1.0f);

    outFragPos = vec3(model * vec4(Position, 1.0));

    outTexCoord = TexCoords;
    // 解决不等比缩放，对法向量产生的影响
    outNormal = mat3(transpose(inverse(model))) * Normal;
}

//*/

/*// 19_basic_lighting
#version 330 core
layout(location = 0) in vec3 Position;
layout(location = 1) in vec3 Normal;
layout(location = 2) in vec2 TexCoords;

out vec2 outTexCoord;
out vec3 outNormal;
out vec3 outFragPos;

uniform float factor;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void main() {

    gl_Position = projection * view * model * vec4(Position, 1.0f);

    outFragPos = vec3(model * vec4(Position, 1.0));

    outTexCoord = TexCoords;
    // 解决不等比缩放，对法向量产生的影响
    outNormal = mat3(transpose(inverse(model))) * Normal;
}

//*/



/*//18_light_scence

#version 330 core
layout(location = 0) in vec3 Position;
layout(location = 1) in vec3 Normal;
layout(location = 2) in vec2 TexCoords;
out vec2 outTexCoord;

uniform float factor;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void main() {

    gl_Position = projection * view * model * vec4(Position, 1.0f);
    outTexCoord = TexCoords;
}

//*/

/* //17_use_camera_class

#version 330 core
layout(location = 0) in vec3 Position;
layout(location = 1) in vec3 Normal;
layout(location = 2) in vec2 TexCoords;
out vec2 outTexCoord;

uniform float factor;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void main() {

    gl_Position = projection * view * model * vec4(Position, 1.0f);
    outTexCoord = TexCoords;
}

//*/


/*//16_use_camera
#version 330 core
layout(location = 0) in vec3 Position;
layout(location = 1) in vec3 Normal;
layout(location = 2) in vec2 TexCoords;
out vec2 outTexCoord;

uniform float factor;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void main() {

    gl_Position = projection * view * model * vec4(Position, 1.0f);
    outTexCoord = TexCoords;
}

//*/

/* // 15_mvp_matrix_exercise
#version 330 core
layout(location = 0) in vec3 Position;
layout(location = 1) in vec3 Normal;
layout(location = 2) in vec2 TexCoords;
out vec2 outTexCoord;

uniform float factor;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void main() {

    gl_Position = projection * view * model * vec4(Position, 1.0f);
    outTexCoord = TexCoords;
}
// */

/* //14_use_image_ui
#version 330 core
layout(location = 0) in vec3 Position;
layout(location = 1) in vec3 Normal;
layout(location = 2) in vec2 TexCoords;
out vec2 outTexCoord;

uniform float factor;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void main() {

    gl_Position = projection * view * model * vec4(Position, 1.0f);
    outTexCoord = TexCoords;
}

//*/

 /*// 13_model_view_projection
#version 330 core
layout(location = 0) in vec3 Position;
layout(location = 1) in vec3 Normal;
layout(location = 2) in vec2 TexCoords;
out vec2 outTexCoord;

uniform float factor;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void main()
{
    gl_Position = projection * view * model * vec4(Position, 1.0f);
    outTexCoord = TexCoords;
}

// */

 //12_use_box_geometry
#version 330 core
layout (location = 0) in vec3 Position;
layout (location = 1) in vec3 Normal;
layout (location = 2) in vec2 TexCoords;

out vec3 outPosition;
out vec2 outTexCoord;
out float stp;

uniform float factor;


// |  1   0      0     0|    |x|    |         x         |
// |  0   cos0  -sin0  0|  * |y| =  |cos0 * y - sin0 * z|
// |  0   sin0  cos0   0|    |z|    |sin0 * y + cos0 * z|
// |  0   0      0     1|    |w|    |         1         |
mat4 rotateX(float _angle) {
    return mat4(1.0f, 0.0f, 0.0f, 0.0f,
                0.0f, cos(_angle), -sin(_angle), 0.0f,
                0.0f, sin(_angle), cos(_angle), 0.0f,
                0.0f, 0.0f, 0.0f, 1.0f);
}


// |  cos0  0  sin0   0|    |x|    |x * cos0 + z * sin0|
// |  0     0     1   0|  * |y| =  |         y         |
// | -sin0  0  cos0   0|    |z|    |-sinθ *x + cosθ * z|
// |  0     0     0   1|    |w|    |         1         |
mat4 rotateY(float _angle) {
    return mat4(cos(_angle), 0.0f, sin(_angle), 0.0f,
                0.0f, 1.0f, 0.0f, 0.0f,
                -sin(_angle), 0.0f, cos(_angle), 0.0f,
                0.0f, 0.0f, 0.0f, 1.0f);
}


//  |  cos0  -sin0   0   0|    |x|    |x * cos0 - y * sin0|
//  |  sin0   cos0   0   0|  * |y| =  |x * sin0 + y * cos0|
//  |  0       0     1   0|    |z|    |         z         |
//  |  0       0     0   1|    |w|    |         1         |
mat4 rotateZ(float _angle) {
    return mat4(cos(_angle), -sin(_angle), 0.0f, 0.0f,
                sin(_angle), cos(_angle), 0.0f, 0.0f,
                0.0f, 0.0f, 1.0f, 0.0f,
                0.0f, 0.0f, 0.0f, 1.0f);
}

mat4 rotateXYZ(float angle) {
    return rotateZ(angle) * rotateY(angle) * rotateX(angle);
}

void main() {

     mat4 rotate = rotateZ(factor) * rotateY(factor) * rotateX(factor);
     gl_Position = rotate * vec4(Position, 1.0f);

    //gl_Position = rotateXYZ(factor) * vec4(Position, 1.0f);

    stp = length(Position.y - sin(factor * 5.0));
    gl_PointSize = 5.0f * stp;
    outTexCoord = TexCoords;
}


//*/


/*// 11_use_sphere_geometry
#version 330 core
layout(location = 0) in vec3 Position;
layout(location = 1) in vec3 Normal;
layout(location = 2) in vec2 TexCoords;

out vec3 outPosition;
out vec2 outTexCoord;

uniform float factor;

//  |  1   0      0     0|    |x|    |         x         |
//  |  0   cos0  -sin0  0|  * |y| =  |cos0 * y - sin0 * z|
//  |  0   sin0  cos0   0|    |z|    |sin0 * y + cos0 * z|
//  |  0   0      0     1|    |w|    |         1         |
mat4 rotateX(float _angle) {
    return mat4(1.0f, 0.0f, 0.0f, 0.0f,
                0.0f, cos(_angle), -sin(_angle), 0.0f,
                0.0f, sin(_angle), cos(_angle), 0.0f,
                0.0f, 0.0f, 0.0f, 1.0f);
}



//  |  cos0  0  sin0   0|    |x|    |x * cos0 + z * sin0|
//  |  0     0     1   0|  * |y| =  |         y         |
//  | -sin0  0  cos0   0|    |z|    |-sinθ *x + cosθ * z|
//  |  0     0     0   1|    |w|    |         1         |
mat4 rotateY(float _angle) {
    return mat4(cos(_angle), 0.0f, sin(_angle), 0.0f,
                0.0f, 1.0f, 0.0f, 0.0f,
                -sin(_angle), 0.0f, cos(_angle), 0.0f,
                0.0f, 0.0f, 0.0f, 1.0f);
}

//  |  cos0  -sin0   0   0|    |x|    |x * cos0 - y * sin0|
//  |  sin0   cos0   0   0|  * |y| =  |x * sin0 + y * cos0|
//  |  0       0     1   0|    |z|    |         z         |
//  |  0       0     0   1|    |w|    |         1         |
mat4 rotateZ(float _angle) {
    return mat4(cos(_angle), -sin(_angle), 0.0f, 0.0f,
                sin(_angle), cos(_angle), 0.0f, 0.0f,
                0.0f, 0.0f, 1.0f, 0.0f,
                0.0f, 0.0f, 0.0f, 1.0f);
}

mat4 rotateXYZ(float angle) {
    return rotateZ(angle) * rotateY(angle) * rotateX(angle);
}

void main() {

    mat4 rotate = rotateZ(factor) * rotateY(factor) * rotateX(factor);
    gl_Position = rotate * vec4(Position, 1.0f);

    //gl_Position = rotateXYZ(factor) * vec4(Position, 1.0f);
    gl_PointSize = 10.0f;
    outTexCoord = TexCoords;
}
//*/


/*//10_use_plane_geometry

#version 330 core
layout (location = 0) in vec3 Position;
layout (location = 1) in vec3 Normal;
layout (location = 2) in vec2 TexCoords;

out vec3 outPosition;
out vec2 outTexCoord;

uniform float factor;


// |  1   0      0     0|    |x|    |         x         |
// |  0   cos0  -sin0  0|  * |y| =  |cos0 * y - sin0 * z|
// |  0   sin0  cos0   0|    |z|    |sin0 * y + cos0 * z|
// |  0   0      0     1|    |w|    |         1         |
mat4 rotateX(float angle)
{
    return mat4(1.0f, 0.0f, 0.0f, 0.0f,
                0.0f, cos(angle), -sin(angle), 0.0f,
                0.0f, sin(angle), cos(angle), 0.0f,
                0.0f, 0.0f, 0.0f, 1.0f);
}


// |  cos0  0  sin0   0|    |x|    |x * cos0 + z * sin0|
// |  0     0     1   0|  * |y| =  |         y         |
// | -sin0  0  cos0   0|    |z|    |-sinθ *x + cosθ * z|
// |  0     0     0   1|    |w|    |         1         |
mat4 rotateY(float angle) {
    return mat4(cos(angle), 0.0f, sin(angle), 0.0f,
                0.0f, 1.0f, 0.0f, 0.0f,
                -sin(angle), 0.0f, cos(angle), 0.0f,
                0.0f, 0.0f, 0.0f, 1.0f);
}

// |  cos0  -sin0   0   0|    |x|    |x * cos0 - y * sin0|
// |  sin0   cos0   0   0|  * |y| =  |x * sin0 + y * cos0|
// |  0       0     1   0|    |z|    |         z         |
// |  0       0     0   1|    |w|    |         1         |
mat4 rotateZ(float angle) {
    return mat4(cos(angle), -sin(angle), 0.0f, 0.0f,
                sin(angle), cos(angle), 0.0f, 0.0f,
                0.0f, 0.0f, 1.0f, 0.0f,
                0.0f, 0.0f, 0.0f, 1.0f);
}


 mat4 rotateXYZ(float angle) {
     return rotateZ(angle) * rotateY(angle) * rotateX(angle);
 }


void main()
{
    gl_Position = vec4(rotateXYZ(factor) * vec4(Position, 1.0f));
    //gl_Position = vec4(Position, 1.0f);
    gl_PointSize = 10.0f;
    outTexCoord = TexCoords;
}

//*/

/* //09_transform

#version 330 core
layout(location = 0) in vec3 aPos;
layout(location = 1) in vec3 aColor;
layout(location = 2) in vec2 aTexCoord;

out vec3 ourPos;
out vec3 ourColor;
out vec2 TexCoord;

uniform float factor;
uniform mat4 transform;

// |  cos0  -sin0   0   0|    |x|    |x * cos0 - y * sin0|
// |  sin0   cos0   0   0|  * |y| =  |x * sin0 + y * cos0|
// |  0       0     1   0|    |z|    |         z         |
// |  0       0     0   1|    |w|    |         1         |
// 旋转矩阵：可以用矩阵来旋转坐标系统
mat4 rotate3d(float _angle) {
    return mat4(cos(_angle), -sin(_angle), 0.0f, 0.0f,
                sin(_angle), cos(_angle), 0.0f, 0.0f,
                0.0f, 0.0f, 1.0f, 0.0f,
                0.0f, 0.0f, 0.0f, 1.0f);
}


void main() {

    gl_Position = transform * vec4(rotate3d(factor) * vec4(aPos, 1.0f));
    //gl_Position = vec4(rotate3d(factor) * vec4(aPos, 1.0f));
    //gl_Position = transform * vec4(aPos, 1.0f);
    //gl_Position = vec4(aPos, 1.0f);
    gl_PointSize = 10.0f;

    ourPos = aPos;
    ourColor = aColor;
    TexCoord = aTexCoord * 2.0;
}
//*/

/* //08_load_texture_exercise

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

void main(){
    gl_Position = vec4(aPos.x + xOffset, -aPos.y, aPos.z, 1.0f);
    //ourColor = aColor;
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







//27_load_model
#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;

uniform vec3 lightColor;

void main() {
    FragColor = vec4(lightColor, 1.0);
}

//*/


/*//26_multiple_light

#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;

uniform vec3 lightColor;

void main() {
    FragColor = vec4(lightColor, 1.0);
}
//*/


/*// 25_spot_light

#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;

void main() {
    FragColor = vec4(1);
}
//*/


/*// 24_point_light
#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;

void main() {
    FragColor = vec4(1);
}

//*/


/*// 23_direction_light
#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;

void main() {
    FragColor = vec4(1);
}
//*/


/*// 22_light_map_exercise

#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;

void main() {
    FragColor = vec4(1);
}

//*/

/*// 21_light_map
#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;

void main() {
    FragColor = vec4(1);
}
//*/

/*//20_light_material
#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;

void main() {
    FragColor = vec4(1);
}
//*/


/* // 19_basic_lighting
#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;

void main() {
    FragColor = vec4(1);
}

//*/

/*//18_light_scence

#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;

void main() {
  FragColor = vec4(1);
}

//*/
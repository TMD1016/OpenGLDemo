






//27_load_model
#version 330 core
out vec4 FragColor;

// 定向光
struct DirectionLight {
    vec3 direction;

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

// 点光源
struct PointLight {
    vec3 position;

    float constant;
    float linear;
    float quadratic;

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

// 聚光灯
struct SpotLight {
    vec3 position;
    vec3 direction;
    float cutOff;
    float outerCutOff;

    float constant;
    float linear;
    float quadratic;

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

// 材质
struct Material {
    sampler2D diffuse; // 漫反射贴图
    sampler2D specular; // 镜面光贴图
    float shininess; // 高光指数
};

#define NR_POINT_LIGHTS 4

uniform Material material;
uniform DirectionLight directionLight;
uniform PointLight pointLights[NR_POINT_LIGHTS];
uniform SpotLight spotLight;

uniform sampler2D awesomeMap; // 笑脸贴图

in vec2 outTexCoord;
in vec3 outNormal;
in vec3 outFragPos;

uniform vec3 viewPos;
uniform float factor; // 变化值

vec3 CalcDirectionLight(DirectionLight light, vec3 normal, vec3 viewDir);
vec3 CalcPointLight(PointLight light, vec3 normal, vec3 fragPos, vec3 viewDir);
vec3 CalcSpotLight(SpotLight light, vec3 normal, vec3 fragPos, vec3 viewDir);

void main() {

    vec4 objectColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);

    vec3 viewDir = normalize(viewPos - outFragPos);
    vec3 normal = normalize(outNormal);

    // 定向光照
    vec3 result = CalcDirectionLight(directionLight, normal, viewDir);

    // 点光源
    for(int i = 0; i < NR_POINT_LIGHTS; i++) {
        result += CalcPointLight(pointLights[i], normal, outFragPos, viewDir);
    }
    // 聚光光源
    result += CalcSpotLight(spotLight, normal, outFragPos, viewDir) * texture(awesomeMap, outTexCoord).rgb;

    FragColor = vec4(result, 1.0);
}

// 计算定向光
vec3 CalcDirectionLight(DirectionLight light, vec3 normal, vec3 viewDir) {
    vec3 lightDir = normalize(light.direction);
    float diff = max(dot(normal, lightDir), 0.0);
    vec3 reflectDir = reflect(-lightDir, normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);

    // 合并
    vec3 ambient = light.ambient * vec3(texture(material.diffuse, outTexCoord));
    vec3 diffuse = light.diffuse * diff * vec3(texture(material.diffuse, outTexCoord));
    vec3 specular = light.specular * spec * vec3(texture(material.specular, outTexCoord));

    return ambient + diffuse + specular;
}

// 计算点光源
vec3 CalcPointLight(PointLight light, vec3 normal, vec3 fragPos, vec3 viewDir) {
    vec3 lightDir = normalize(light.position - fragPos);
    // 漫反射着色
    float diff = max(dot(normal, lightDir), 0.0);
    // 镜面光着色
    vec3 reflectDir = reflect(-lightDir, normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
    // 衰减
    float distance = length(light.position - fragPos);
    float attenuation = 1.0 / (light.constant + light.linear * distance +
    light.quadratic * (distance * distance));
    // 合并结果
    vec3 ambient = light.ambient * vec3(texture(material.diffuse, outTexCoord));
    vec3 diffuse = light.diffuse * diff * vec3(texture(material.diffuse, outTexCoord));
    vec3 specular = light.specular * spec * vec3(texture(material.specular, outTexCoord));
    ambient *= attenuation;
    diffuse *= attenuation;
    specular *= attenuation;
    return (ambient + diffuse + specular);
}

// 计算聚光灯
vec3 CalcSpotLight(SpotLight light, vec3 normal, vec3 fragPos, vec3 viewDir) {
    vec3 lightDir = normalize(light.position - fragPos);
    float diff = max(dot(normal, lightDir), 0.0);
    vec3 reflectDir = reflect(-lightDir, normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);

    float distance = length(light.position - fragPos);
    float attenuation = 1.0 / (light.constant + light.linear * distance + light.quadratic * (distance * distance));

    float theta = dot(lightDir, normalize(-light.direction));
    float epsilon = light.cutOff - light.outerCutOff;
    float intensity = clamp((theta - light.outerCutOff) / epsilon, 0.0, 1.0);

    vec3 ambient = light.ambient * vec3(texture(material.diffuse, outTexCoord));
    vec3 diffuse = light.diffuse * diff * vec3(texture(material.diffuse, outTexCoord));
    vec3 specular = light.specular * spec * vec3(texture(material.specular, outTexCoord));

    ambient *= attenuation * intensity;
    diffuse *= attenuation * intensity;
    specular *= attenuation * intensity;
    return (ambient + diffuse + specular);
}

//*/


/*//26_multiple_light
#version 330 core
out vec4 FragColor;

// 定向光
struct DirectionLight {
    vec3 direction;

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

// 点光源
struct PointLight {
    vec3 position;

    float constant;
    float linear;
    float quadratic;

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

// 聚光灯
struct SpotLight {
    vec3 position;
    vec3 direction;
    float cutOff;
    float outerCutOff;

    float constant;
    float linear;
    float quadratic;

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

// 材质
struct Material {
    sampler2D diffuse; // 漫反射贴图
    sampler2D specular; // 镜面光贴图
    float shininess; // 高光指数
};

#define NR_POINT_LIGHTS 4

uniform Material material;
uniform DirectionLight directionLight;
uniform PointLight pointLights[NR_POINT_LIGHTS];
uniform SpotLight spotLight;

uniform sampler2D awesomeMap; // 笑脸贴图

in vec2 outTexCoord;
in vec3 outNormal;
in vec3 outFragPos;

uniform vec3 viewPos;
uniform float factor; // 变化值

vec3 CalcDirectionLight(DirectionLight light, vec3 normal, vec3 viewDir);
vec3 CalcPointLight(PointLight light, vec3 normal, vec3 fragPos, vec3 viewDir);
vec3 CalcSpotLight(SpotLight light, vec3 normal, vec3 fragPos, vec3 viewDir);

void main() {

    vec4 objectColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);

    vec3 viewDir = normalize(viewPos - outFragPos);
    vec3 normal = normalize(outNormal);

    // 定向光照
    vec3 result = CalcDirectionLight(directionLight, normal, viewDir);

    // 点光源
    for(int i = 0; i < NR_POINT_LIGHTS; i++) {
        result += CalcPointLight(pointLights[i], normal, outFragPos, viewDir);
    }
    // 聚光光源
    result += CalcSpotLight(spotLight, normal, outFragPos, viewDir) * texture(awesomeMap, outTexCoord).rgb;

    FragColor = vec4(result, 1.0);
}

// 计算定向光
vec3 CalcDirectionLight(DirectionLight light, vec3 normal, vec3 viewDir) {
    vec3 lightDir = normalize(light.direction);
    float diff = max(dot(normal, lightDir), 0.0);
    vec3 reflectDir = reflect(-lightDir, normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);

    // 合并
    vec3 ambient = light.ambient * vec3(texture(material.diffuse, outTexCoord));
    vec3 diffuse = light.diffuse * diff * vec3(texture(material.diffuse, outTexCoord));
    vec3 specular = light.specular * spec * vec3(texture(material.specular, outTexCoord));

    return ambient + diffuse + specular;
}

// 计算点光源
vec3 CalcPointLight(PointLight light, vec3 normal, vec3 fragPos, vec3 viewDir) {
    vec3 lightDir = normalize(light.position - fragPos);
    // 漫反射着色
    float diff = max(dot(normal, lightDir), 0.0);
    // 镜面光着色
    vec3 reflectDir = reflect(-lightDir, normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
    // 衰减
    float distance = length(light.position - fragPos);
    float attenuation = 1.0 / (light.constant + light.linear * distance +
    light.quadratic * (distance * distance));
    // 合并结果
    vec3 ambient = light.ambient * vec3(texture(material.diffuse, outTexCoord));
    vec3 diffuse = light.diffuse * diff * vec3(texture(material.diffuse, outTexCoord));
    vec3 specular = light.specular * spec * vec3(texture(material.specular, outTexCoord));
    ambient *= attenuation;
    diffuse *= attenuation;
    specular *= attenuation;
    return (ambient + diffuse + specular);
}

// 计算聚光灯
vec3 CalcSpotLight(SpotLight light, vec3 normal, vec3 fragPos, vec3 viewDir) {
    vec3 lightDir = normalize(light.position - fragPos);
    float diff = max(dot(normal, lightDir), 0.0);
    vec3 reflectDir = reflect(-lightDir, normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);

    float distance = length(light.position - fragPos);
    float attenuation = 1.0 / (light.constant + light.linear * distance + light.quadratic * (distance * distance));

    float theta = dot(lightDir, normalize(-light.direction));
    float epsilon = light.cutOff - light.outerCutOff;
    float intensity = clamp((theta - light.outerCutOff) / epsilon, 0.0, 1.0);

    vec3 ambient = light.ambient * vec3(texture(material.diffuse, outTexCoord));
    vec3 diffuse = light.diffuse * diff * vec3(texture(material.diffuse, outTexCoord));
    vec3 specular = light.specular * spec * vec3(texture(material.specular, outTexCoord));

    ambient *= attenuation * intensity;
    diffuse *= attenuation * intensity;
    specular *= attenuation * intensity;
    return (ambient + diffuse + specular);
}

//*/


/*// 25_spot_light
#version 330 core
out vec4 FragColor;

// 材质
struct Material {
    sampler2D diffuse; // 漫反射贴图
    sampler2D specular; // 镜面光贴图
    float shininess; // 高光指数
};
uniform Material material;

// 光源
struct Light {
    vec3 position; // 光源位置

    vec3 direction; // 光照方向
    float cutOff; // 切光角
    float outerCutOff; // 外切光角

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;

    float constant; // 常数项
    float linear; // 一次项
    float quadratic; // 二次项
};
uniform Light light;

in vec2 outTexCoord;
in vec3 outNormal;
in vec3 outFragPos;

uniform vec3 viewPos;
uniform float factor; // 变化值

void main() {

    vec3 lightDir = normalize(light.position - outFragPos);

    vec4 objectColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);
    vec3 diffuseTexture = vec3(texture(material.diffuse, outTexCoord));
    vec3 specularTexture = vec3(texture(material.specular, outTexCoord));

    float theta = dot(lightDir, normalize(-light.direction));
    float epsilon = light.cutOff - light.outerCutOff;
    float intensity = clamp((theta - light.outerCutOff) / epsilon, 0.0, 1.0);

    // ambient
    vec3 ambient = light.ambient * diffuseTexture;

    // diffuse
    vec3 norm = normalize(outNormal);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = light.diffuse * diff * diffuseTexture;

    // specular1
    vec3 viewDir = normalize(viewPos - outFragPos);
    vec3 reflectDir = reflect(-lightDir, norm);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
    vec3 specular = light.specular * spec * specularTexture;

    // 软化边缘
    diffuse *= intensity;
    specular *= intensity;

    // 衰减值
    float distance = length(light.position - outFragPos);
    float attenuation = 1.0 / (light.constant + light.linear * distance + light.quadratic * pow(distance, 2.0));
    // ambient *= attenuation;
    diffuse *= attenuation;
    specular *= attenuation;

    vec3 result = (ambient + diffuse + specular) * vec3(objectColor);
    FragColor = vec4(result, 1.0);

}

//*/

/*// 24_point_light

#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;
in vec3 outNormal;
in vec3 outFragPos;

uniform vec3 viewPos; // 相机位置

// 材质
struct Material {
    sampler2D diffuse; // 漫反射贴图
    sampler2D specular; // 镜面光贴图
    float shininess; // 高光指数
};
uniform Material material;

// 光源
struct Light {
    vec3 position; // 光源位置

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;

    float constant; // 常数项
    float linear; // 一次项
    float quadratic; // 二次项
};
uniform Light light;

uniform float factor;

void main() {

    // 计算衰减值
    float distance = length(light.position - outFragPos);
    float attenuation = 1.0 / (light.constant + light.linear * distance + light.quadratic * pow(distance, 2.0));

    vec4 objectColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);
    vec3 diffuseTexture = vec3(texture(material.diffuse, outTexCoord));
    vec3 specularTexture = vec3(texture(material.specular, outTexCoord));

    vec3 ambient = light.ambient * diffuseTexture; // 环境光

    vec3 norm = normalize(outNormal);
    vec3 lightDir = normalize(light.position - outFragPos);
    // vec3 lightDir = normalize(light.position);

    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = light.diffuse * diff * diffuseTexture; // 漫反射

    vec3 viewDir = normalize(viewPos - outFragPos);
    vec3 reflectDir = reflect(-lightDir, norm);

    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
    vec3 specular = light.specular * spec * specularTexture; // 镜面光

    // 将环境光、漫反射、镜面光分别乘以衰减距离
    ambient *= attenuation;
    diffuse *= attenuation;
    specular *= attenuation;

    vec3 result = (ambient + diffuse + specular) * vec3(objectColor);

    FragColor = vec4(result, 1.0);
}

//*/

/*// 23_direction_light
#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;
in vec3 outNormal;
in vec3 outFragPos;

uniform vec3 viewPos; // 相机位置

// 定义材质结构体
struct Material {
    sampler2D diffuse; // 漫反射贴图
    sampler2D specular; // 镜面光贴图
    sampler2D specularColor; // 镜面光贴图
    sampler2D emission; // 发光贴图
    float shininess; // 高光指数
};
uniform Material material;

// 光源属性
struct Light {

    vec3 direction; // 定向光

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

uniform Light light;

uniform float factor;

void main() {

    vec4 objectColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);
    vec3 diffuseTexture = vec3(texture(material.diffuse, outTexCoord));
    vec3 specularTexture = vec3(texture(material.specular, outTexCoord));

    vec3 ambient = light.ambient * diffuseTexture; // 环境光

    vec3 norm = normalize(outNormal);
    // vec3 lightDir = normalize(lightPos - outFragPos);
    vec3 lightDir = normalize(light.direction);

    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = light.diffuse * diff * diffuseTexture; // 漫反射

    vec3 viewDir = normalize(viewPos - outFragPos);
    vec3 reflectDir = reflect(-lightDir, norm);

    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
    vec3 specular = light.specular * spec * specularTexture; // 镜面光

    vec3 result = (ambient + diffuse + specular) * vec3(objectColor);

    FragColor = vec4(result, 1.0);
}
//*/


/*// 22_light_map_exercise
#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;
in vec3 outNormal;
in vec3 outFragPos;

uniform vec3 lightColor;
uniform vec3 lightPos;
uniform vec3 viewPos; // 相机位置

// 定义材质结构体
struct Material {
    sampler2D diffuse; // 漫反射贴图
    sampler2D specular; // 镜面光贴图
    sampler2D specularColor; // 镜面光贴图
    sampler2D emission; // 发光贴图
    float shininess; // 高光指数
};
uniform Material material;

// 光源属性
struct Light {

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

uniform Light light;

uniform float factor;

void main() {

    vec4 objectColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);
    vec3 diffuseTexture = vec3(texture(material.diffuse, outTexCoord));
    vec3 specularTexture = vec3(texture(material.specularColor, outTexCoord));

    vec2 uv = outTexCoord;
    uv.y += factor;
    vec3 emissionTexture = vec3(texture(material.emission, uv));

    vec3 ambient = light.ambient * diffuseTexture; // 环境光

    vec3 norm = normalize(outNormal);
    vec3 lightDir = normalize(lightPos - outFragPos);

    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = light.diffuse * diff * diffuseTexture; // 漫反射

    vec3 viewDir = normalize(viewPos - outFragPos);
    vec3 reflectDir = reflect(-lightDir, norm);

    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
    vec3 specular = light.specular * spec * specularTexture; // 镜面光

    vec3 result = (ambient + diffuse + specular + emissionTexture) * vec3(objectColor);

    FragColor = vec4(result, 1.0);
}

//*/

/*// 21_light_map
#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;
in vec3 outNormal;
in vec3 outFragPos;

uniform vec3 lightColor;
uniform vec3 lightPos;
uniform vec3 viewPos; // 相机位置

// 定义材质结构体
struct Material {
    sampler2D diffuse; // 漫反射贴图
    sampler2D specular; // 镜面光贴图
    float shininess; // 高光指数
};
uniform Material material;

// 光源属性
struct Light {

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

uniform Light light;

void main() {

    vec4 objectColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);
    vec3 diffuseTexture = vec3(texture(material.diffuse, outTexCoord));
    vec3 specularTexture = vec3(texture(material.specular, outTexCoord));

    vec3 ambient = light.ambient * diffuseTexture; // 环境光

    vec3 norm = normalize(outNormal);
    vec3 lightDir = normalize(lightPos - outFragPos);

    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = light.diffuse * diff * diffuseTexture; // 漫反射

    vec3 viewDir = normalize(viewPos - outFragPos);
    vec3 reflectDir = reflect(-lightDir, norm);

    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
    vec3 specular = light.specular * spec * specularTexture; // 镜面光
    // vec3 specular = light.specular * spec; // 镜面光
    vec3 result = (ambient + diffuse + specular) * vec3(objectColor);

    FragColor = vec4(result, 1.0);
}
//*/

/*//20_light_material
#version 330 core
out vec4 FragColor;
in vec2 outTexCoord;
in vec3 outNormal;
in vec3 outFragPos;

uniform vec3 lightColor;
uniform vec3 lightPos;
uniform vec3 viewPos; // 相机位置

uniform sampler2D texture1;
uniform sampler2D texture2;

// 定义材质结构体
struct Material {
    vec3 ambient; // 环境光 颜色
    vec3 diffuse; // 漫反射 颜色
    vec3 specular; // 高光颜色
    float shininess; // 高光指数
};
uniform Material material;

// 光源属性
struct Light {
    vec3 position;

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

uniform Light light;

void main() {

    // vec4 objectColor = mix(texture(texture1, outTexCoord), texture(texture2, outTexCoord), 0.1);
    vec4 objectColor = vec4(1.0f, 1.0f, 1.0f, 1.0f);

    vec3 ambient = light.ambient * material.ambient; // 环境光

    vec3 norm = normalize(outNormal);
    vec3 lightDir = normalize(lightPos - outFragPos);

    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = light.diffuse * diff * material.diffuse; // 漫反射

    vec3 viewDir = normalize(viewPos - outFragPos);
    vec3 reflectDir = reflect(-lightDir, norm);

    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
    vec3 specular = light.specular * spec * material.specular; // 镜面光

    vec3 result = (ambient + diffuse + specular) * vec3(objectColor);

    FragColor = vec4(result, 1.0);
}

//*/

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

 /*//12_use_box_geometry
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
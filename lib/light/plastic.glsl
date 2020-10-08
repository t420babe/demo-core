#ifndef LICHT_PLASTIC
#define LIGHT_PLASTIC
#endif


const float num_mips = 1.0;

/// Book of Shaders ex 01_lighting
vec3 tonemap(const vec3 x) {
  return x / ( x + vec3(1.0) );
  // return x / (x + 0.155) * 1.019;
}

vec3 env_map(vec3 normal, float roughness) {
  vec4 color = mix( textureCube( u_cubeMap, normal, (roughness * num_mips) ),
      textureCube( u_cubeMap, normal, min( (roughness * num_mips) + 1.0, num_mips)),
      fract(roughness * num_mips) );

  return tonemap(color.rgb);
}

vec3 plastic() {
  vec3 color = vec3(1.0);
  vec3 n = normalize(v_normal);
  vec3 l = normalize(u_light);
  vec3 v = normalize(u_camera - v_position.xyz);

  float diffuse = (dot(n, l) + 3.0) * (audio.bandpass + 0.1);
  color *= diffuse;

  if (audio.notch > 1.0) {
    color.b = 0.0;
  } else {
    color.r = 0.0;
  }

  vec3 r = reflect(-v, n);
  vec3 specular = env_map(r, step(-1.0, v_position.x));
  color *= specular;
  return color;

}


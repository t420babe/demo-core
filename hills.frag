/* t420babe - Hill's Spherical Vortex Countours */

// Loop time
float loop_time(float u_time, float limit) {
  float mod_time = mod(u_time, limit);
  if (mod_time < limit / 2.0) {
    return mod_time;
  } else {
    return limit - mod_time;
  }
}

// Crisp lines
float sharp(float f) {
  return smoothstep(-0.75, 0.75, (f - 0.1) / fwidth(f));
}

// Equation for vortex ring
vec2 vortex_ring(vec2 pos, float u_time, out vec3 color) {
  float a = 1.0;
  float u_0 = 10.0;
  float A = 15.0 / 2.0 * u_0 * 1.0 / pow(a, 2.0);

  float u_int = 1.0 / 5.0 * A * pos.y * (pow(a, 2.0) - pow(pos.x, 2.0) - 2.0 * pow(pos.y, 2.0));
  float v_int = 1.0 / 5.0 * A * pos.x * pos.y;

  return vec2(u_int, v_int);
}

// Create contour lines
void vortex_contour(vec2 pos, float u_time, out vec3 color) {
  pos.x += 0.5;
  float loop = loop_time(u_time, 30.0);
    
  vec2 uv_int = vortex_ring(pos, u_time, color);
  float z = (uv_int.x + uv_int.y) / 5.0 + 2.0;
  z *= 4.0 * (loop / 5.0);
    
  float d = fract(z);
    if(mod(z, 2.0) > 1.0) {
      d = 1.0 - d;
    }

  // Slightly thinner lines for slightly different vibe
  // d = d / fwidth(z);
  
  d = sharp(d);
  color = vec3(d);
    
  // Invert colors
  // color = 1.0 - color;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 pos = (2.0 * fragCoord.xy - iResolution.xy) / iResolution.y;

  vec3 color = vec3(1.0);
  vortex_contour(pos, iTime, color);
 
  fragColor = vec4(color, 1.0);
}

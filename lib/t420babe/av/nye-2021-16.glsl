// i had this pill at coachella, feline
#ifndef T420BABE_NYE_2021_16
#define T420BABE_NYE_2021_16

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef COMMON_RANDOM
#include "./lib/common/random.glsl"
#endif

#ifndef COMMON_NOISE
#include "./lib/common/noise.glsl"
#endif

vec2 nye_2021_16_hills_spherical_vortex(vec2 pos, float u_time) {
  float a = 1.0;
  float u_0 = 10.0;
  float A = 15.0 / 2.0 * u_0 * 1.0 / pow(a, 2.0);

  float u_int = 1.0 / 5.0 * A * pos.y * (pow(a, 2.0) - pow(pos.x, 2.0) - 2.0 * pow(pos.y, 2.0));
  float v_int = 1.0 / 5.0 * A * pos.x * pos.y;

  return vec2(u_int, v_int);
}
float nye_2021_16_vc_nyc(vec2 pos, float u_time, peakamp audio) {
  pos = atan(sin(pos.yx) * cos(pos.xy));
  pos  = pos.xx;
  pos.x += 5.0 * abs(tan(u_time * 0.5));
  pos.y -= 1.0 * abs(tan(u_time * 0.5));
  vec2 uv_int = nye_2021_16_hills_spherical_vortex(pos, u_time);
  float z = (5.0 * uv_int.x + 1.0 * uv_int.y) / 5.0 + 2.0;

  float time_wrap = wrap_time(u_time, 20.0);
  z *= 10.0 * (time_wrap / 5.0);
  float d = atan(z * 5.0);
  if(mod(z, 20.0) > 5.0) {
    d = 3.0 +d;
  }

  d = d / fwidth(z);
  // d = atan(d);
  return d;
}
float nye_2021_16_shape(vec2 pos, float radius, float u_time, peakamp audio) {
  float r = length(pos / audio.highpass);
  // float r = length(pos) * 2.0;
  // float theta = atan(pos.y, pos.x);
  float theta = pos.y  * pos.x + audio.notch;
  float m = abs( mod( theta + u_time * 2.0, 3.14 * 2.0) - 3.14 ) / (3.14 * 2.0);
  float f = radius;
  float f1 = radius;

  m += noise( pos + u_time * 0.1) * 0.5;
  f += noise(pos + u_time * 1.0) * 0.1;
  // f1 /= (theta * 50.0) * noise(pos + u_time * 1.0) * 0.05 * audio.bandpass;
  // f1 += sin(theta * 20.0) * 0.1 * pow(m, 2.0);
  f1 = nye_2021_16_vc_nyc(pos, u_time, audio);

  // return 1.0 - smoothstep(f1, f + 1.007, r) / fwidth(f1);
  return 1.0 - sharp(smoothstep(f1, f + 1.007, r) );
}

float nye_2021_16_shape_border(vec2 pos, float radius, float width, float u_time, peakamp audio) {
  return nye_2021_16_shape(pos, radius, u_time, audio) - nye_2021_16_shape(pos, radius - width, u_time, audio);
}
float nye_2021_16_noise_clouds (in vec2 _st) {
    vec2 i = floor(_st);
    vec2 f = fract(_st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

float nye_2021_16_fbm ( in vec2 _st) {
    int onum = 5;
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(100.0);
    // Rotate to reduce axial bias
    mat2 rot = mat2(cos(0.5), sin(0.5),
                    -sin(0.5), cos(0.50));
    for (int i = 0; i < onum; ++i) {
        v += a * nye_2021_16_noise_clouds(_st);
        _st = rot * _st * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}

vec3 nye_2021_16_clouds(vec2 st, float u_time, peakamp audio) {
    // st += st * abs(sin(u_time*0.1)*3.0);
    vec3 color = vec3(0.0);

    vec2 q = vec2(0.);
    q.x = nye_2021_16_fbm( st + 0.00*u_time);
    q.y = nye_2021_16_fbm( st + vec2(1.0));

    vec2 r = vec2(0.);
    r.x = nye_2021_16_fbm( st + 1.0*q + vec2(1.7,9.2)+ 0.15*u_time );
    r.y = nye_2021_16_fbm( st + 1.0*q + vec2(8.3,2.8)+ 0.126*u_time);

    float f = nye_2021_16_fbm(st+r);

    color = mix(vec3(0.101961,0.619608,0.666667),
                vec3(0.666667,0.666667,0.498039),
                clamp((f*f)*4.0,0.0,1.0));

    color = mix(color,
                vec3(0,0,0.164706),
                clamp(length(q),0.0,1.0));

    color = mix(color,
                vec3(0.666667,1,1),
                clamp(length(r.x),0.0,1.0));

    return vec3((f*f*f+.6*f*f+.5*f)*color);
}


vec3 nye_2021_16(vec2 pos, float u_time, peakamp audio) {
  // pos = pos.yx;
  pos *= 1.0;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 2.0;
  audio.highpass  *= 2.0;
  audio.bandpass  *= 2.0;
  audio.notch     *= 2.3;

  // nye_2021_16_shape_color_border(pos, 1.0, 0.10, u_time, audio, color);

  // Color 0
  color.g += audio.lowpass * 1.0;
  vec3 clouds_color = nye_2021_16_clouds(pos, u_time, audio);
  color = clouds_color + 0.2;
  color *= nye_2021_16_shape_border(pos, 3.0, 2.00, u_time, audio) * 1.20 + abs(audio.notch * 0.2);
  color.b *= abs(audio.lowpass * 2.5);
  color.g -= abs(audio.highpass * 1.0);

  // color += clouds_color;
  // color = color.bgr;
  //
  // Color 0
  // color.r += audio.lowpass * 2.0;
  // color /= nye_2021_16_shape_border(pos * 0.8, 1.0, 5.10, u_time, audio);
  // // color.b /= audio.lowpass * 1.0;
  // color.b *= abs(audio.highpass) * 1.5;
  color.r /= abs(audio.notch) * 0.8;
  color.b *= abs(audio.lowpass) * 1.5 - 0.29234;
  //

  // color = color.bgr;

  // color = color.bgr;
  // color = color.grg;

  // color = color.gbg;

  // color = color.gbr;

  // vec3 clouds_color = vec3(1.0);
  // clouds(pos, u_time, audio, clouds_color);
  // color *= clouds_color;

  return color;
}
#endif

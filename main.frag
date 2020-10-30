#ifdef GL_ES
precision highp float;
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef T420BABE_AUDIO_CIRCLE
#include "./lib/t420babe/audio-circle.glsl"
#endif


#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

uniform sampler2D u_tex0;
uniform sampler2D u_tex1;

uniform vec2 u_resolution;
uniform float u_time;

uniform float u_lowpass;
uniform float u_highpass;
uniform float u_bandpass;
uniform float u_notch;

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

vec3 mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec2 mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 permute(vec3 x) { return mod289(((x*34.0)+1.0)*x); }

float snoise(vec2 v) {
  const vec4 C = vec4(0.211324865405187,  // (3.0-sqrt(3.0))/6.0
      0.366025403784439,  // 0.5*(sqrt(3.0)-1.0)
      -0.577350269189626,  // -1.0 + 2.0 * C.x
      0.024390243902439); // 1.0 / 41.0
  vec2 i  = floor(v + dot(v, C.yy) );
  vec2 x0 = v -   i + dot(i, C.xx);
  vec2 i1;
  i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
  vec4 x12 = x0.xyxy + C.xxzz;
  x12.xy -= i1;
  i = mod289(i); // Avoid truncation effects in permutation
  vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 ))
      + i.x + vec3(0.0, i1.x, 1.0 ));

  vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy), dot(x12.zw,x12.zw)), 0.0);
  m = m*m ;
  m = m*m ;
  vec3 x = 2.0 * fract(p * C.www) - 1.0;
  vec3 h = abs(x) - 0.5;
  vec3 ox = floor(x + 0.5);
  vec3 a0 = x - ox;
  m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );
  vec3 g;
  g.x  = a0.x  * x0.x  + h.x  * x0.y;
  g.yz = a0.yz * x12.xz + h.yz * x12.yw;
  return 130.0 * dot(m, g);
}

float lava_lamp(vec2 st) {
  // vec2 st = gl_FragCoord.xy/u_resolution.xy;
  st.x *= u_resolution.x/u_resolution.y;
  vec3 color = vec3(0.0);
  vec2 pos = vec2(st*2.5);

  float DF = 0.0;

  // Add a random position
  float a = 0.0;
  vec2 vel = vec2(u_time*.1);
  DF += snoise(pos+vel)*.25+.25;

  // Add a random position
  a = snoise(pos*vec2(cos(u_time*0.15), sin(u_time*0.1))*0.1)*PI;
  vel = vec2(sin(a), cos(a));
  DF += snoise(pos+vel)*.25+.25;

  return ( smoothstep(.7,.75,fract(DF)) );
}

float spiral_pxl(vec2 st, float t) {
  float r = dot(st,st);
  float a = atan(st.y,st.x);
  return abs(sin(fract(log(r)*t+a*0.159)));
}

float star(vec2 st, int V, float s) {
  st.y += 1.0;
  st.x -= 0.25;
    // float a = sharp((st.y, st.y) );
    float a = 1.0;
  float seg = a * float(V);
  // a = (((floor(seg) + 0.5)/float(V) + mix(s, -s, step( 0.1, (seg)))) * TWO_PI);
  // a = (((floor(seg) + 0.5) / float(V) + mix(s, -s, step( 0.1, (seg)))) * TWO_PI);
  return ((dot(vec2((s*a), (s*a)), st.xy)));
}

float wbl1_hexagon(vec2 pos, float size, peakamp audio) {
  pos = abs(pos * 1.0);
  pos /= size;
  float hexagon = 5.0;
  // if (audio.notch * 100.0 > 100.0) {
  // if (audio.bandpass > 0.9) {
  // if (audio.bandpass > 0.5) {
  // if (audio.notch > 0.5) {
  // if (audio.notch > 0.5) {
  //   hexagon =  (max(abs(pos.y), pos.x * 0.866025 + pos.y * 0.1));
  // }  else {
  //   hexagon =  max(abs(pos.y), pos.x * 0.866025 + pos.y * abs(sin(u_time)));
  // }
    // hexagon = (max(abs(pos.y), pos.x * 0.5 + pos.y * abs(tan((audio.lowpass) * 2.0))));
    hexagon = (max(abs(pos.y), pos.x * 0.5 + pos.y * abs(tan((audio.notch) * 3.0))));
  return hexagon;
}

void main(){
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  peakamp audio = peakamp(u_lowpass, u_highpass, u_bandpass, u_notch);
  vec3 color = vec3(0.0);

  float star_0 = star(pos, 4, 5.0);
  float spiral = spiral_pxl(pos, (u_time));
  float lava = lava_lamp(pos);
  // color = vec3(0.2, 0.243, 0.0234);
  color = vec3(0.4, 0.243, 0.7234);
  color += 0.15;
  color -= vec3(lava); 
  // color += vec3(spiral);

  vec3 orange_circle = vec3(1.0);
  orange_circle_bright_purple_bg_2(pos, u_time, audio, orange_circle);
  // color *= sharp(star_0);

  // // COlor 0
  // color.r += orange_circle.b + audio.notch;
  // color.g *= orange_circle.r + audio.lowpass;
  // color.b += (sharp(wbl1_hexagon(pos, 10.0, audio)));

  // // COlor 0
  // color.r *= orange_circle.b + audio.notch;
  // color.g *= orange_circle.r + audio.lowpass;
  // color.b *= (sharp(wbl1_hexagon(pos, 10.0, audio)));
  //
  // COlor 0
  color.b /= orange_circle.g + audio.notch;
  color.g /= orange_circle.g + audio.lowpass;
  color.b *= (sharp(wbl1_hexagon(pos, 10.0, audio)));
  color.b /= audio.bandpass;

  // // Color 1
  // color.g /= (sharp(wbl1_hexagon(pos, 10.0, audio)));
  // color.g *= orange_circle.r + audio.lowpass;
  // color.r *= orange_circle.b + audio.notch;

  gl_FragColor = vec4( color , 1.0);
}


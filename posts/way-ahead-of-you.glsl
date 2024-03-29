// Like I Don't Exist by Nicky Night Time
// lib/t420babe/choice/choice07.glsl
// https://www.instagram.com/tv/CLiDBB8gGDR/?utm_source=ig_web_copy_link
// https://youtu.be/vBqUDZlm-5c
// Forked from spsherk_: https://www.shadertoy.com/view/wdjSRc

float map(vec3 pos, float time){
  pos.xz *= rotate2d(time * 0.4);
  pos.xy *= rotate2d(time * 0.3);
  vec3 q = pos * 2.0 + time;
  float x0 = length( pos + vec3( sin(time * 0.7) ) );
  float x1 = log(length(pos) + 1.0);
  float x2 = sin(q.x + sin(q.z + sin(q.y) ) ) * 5.5;
  return x0 *  x1 + x2 * 5.0;
}

vec3 way_ahead_of_you(vec2 pos, float time, peakamp audio) {
  vec3 color = vec3(1.0);

  float d = 5.0;

  for(int i = 0; i <= 10; i++)	{
    vec3 pos = vec3(0.0, 0.0, 5.0) + normalize( vec3(pos, -1.0) ) * d;
    pos *= 7.0;
    float rz = map(pos, time);
    float f = clamp( ( rz - map(pos + 0.5, time) ) * 0.5, 0.1, 2.0 );
    float r_mul = 0.2;
    float g_mul = 1.8;
    float b_mul = 2.0;
    vec3 l = vec3(0.5, 0.1, 0.3) + vec3(abs(audio.lowpass) * r_mul, abs(audio.bandpass) * g_mul, abs(audio.highpass) * b_mul) * f;
    color *= l;
    color += ( 1.2 - smoothstep(0.0, 0.1, rz) ) * 0.6 * l * (abs(audio.notch) + 0.3);
  }
  return color;
}


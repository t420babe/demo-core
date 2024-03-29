// Make A Livin' by The African Dream
// lib/t420babe/choice/choice08.glsl
// https://youtu.be/JYxE035g5Zs
// Forked from spsherk_: https://www.shadertoy.com/view/wdjSRc
float map(vec3 pos, float time){
  pos.xz *= rotate2d(time * 0.3);
  pos.xy *= rotate2d(time * 0.2);
  vec3 q = pos * 2.0 + time;
  float x0 = length( pos + vec3( sin(time * 0.7) ) );
  float x1 = log(length(pos) + 1.0);
  float x2 = sin(q.x + atan(q.z + sin(q.y) ) ) * 5.5;
  return x0 *  x1 + x2 * 5.0;
}

vec3 opposite_thought(vec2 pos, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.2;
  audio.highpass  *= 1.2;
  audio.bandpass  *= 1.2;
  audio.notch     *= 1.2;

  float d = 5.0;

  for(int i = 0; i <= 10; i++)	{
    vec3 pos = vec3(0.0, 0.0, 5.0) + normalize( vec3(pos, -1.0) ) * d;
    pos *= sin(time * 0.1) * 30.0 + 10.0;
    float rz = map(pos, time);
    float f = clamp( ( rz - map(pos + 0.5, time) ) * 0.5, 0.1, 2.0 );
    float r_mul = 0.1;
    float g_mul = 2.0;
    float b_mul = 1.5;
    vec3 l = vec3(0.5, 0.1, 0.3) + vec3(abs(audio.lowpass) * r_mul, abs(audio.bandpass) * g_mul, abs(audio.highpass) * b_mul) * f;
    color *= l;
    color += ( 1.2 - smoothstep(0.0, 0.1, rz) ) * 0.6 * l * (abs(audio.notch) + 0.3);
    color = color.bgr;
  }
  return color;
}

// Like I Don't Exist by Nicky Night Time
// lib/t420babe/choice/choice06.glsl
// https://www.instagram.com/tv/CLiDBB8gGDR/?utm_source=ig_web_copy_link
// https://youtu.be/vBqUDZlm-5c

mat2 rot(float theta){
    return mat2(cos(theta), -sin(theta), sin(theta), cos(theta));
}

float map(vec3 pos, float time){
  pos.xz *= rot(time * 0.4);
  pos.xy *= rot(time * 0.3);
  vec3 q = pos * 2.0 + time;
  float x0 = length( pos + vec3( sin(time * 0.7) ) );
  float x1 = log(length(pos) + 1.0);
  float x2 = sin(q.x + atan(q.z + sin(q.y) ) ) * 5.5;
  return x0 *  x1 + x2 * 5.0;
}

vec3 way_ahead_of_you(vec2 pos, float time, peakamp audio) {
  vec3 color = vec3(1.0);

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
  }
  return color;
}

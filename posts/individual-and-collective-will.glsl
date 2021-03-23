// FORKED FROM Ether by nimitz (twitter: @stormoid)
// https://www.shadertoy.com/view/MsjSW3

float map(vec3 pos, float time) {
  pos.xz *= rot(time * 0.4);
  pos.xy *= rot(time * 0.3);
  vec3 q = pos * 2.0 + time;
  float x0 = length( pos + vec3( sin(time * 0.7) ) );
  float x1 = log(length(pos) + 1.0);
  float x2 = sin(q.x + tan(q.z + sin(q.y) ) ) * 5.5;
  return x0 *  x1 + x2 - 1.0;
}
vec3 individual_and_collective_will(vec2 pos, float time) {
  vec3 color = vec3(1.0);
  float d = 0.9;
  for(int i = 0; i <= 10; i++)	{
    vec3 pos = vec3(0.0, 0.0, 5.0) + normalize( vec3(pos, -1.0) ) * d;
    pos *= sin(time * 0.1) * 30.0 + 0.0;
    float rz = map(pos, time);
    float f = clamp( ( rz - map(pos + 0.5, time) ) * 0.5, 0.1, 1.0 );
    float g_mul = wrap_time(time, 5.0);
    float r_mul = 1.5;
    float b_mul = 3.0;
    vec3 l = vec3(0.1, 0.25, 0.3) + vec3(abs(notch) * r_mul, abs(bp) * g_mul, abs(hp) * b_mul) * f;
    color *= l;
    color += ( 1.2 - smoothstep(0.0, 0.1, rz) ) * 0.6 * l;
    d += min(rz, 1.0);
  }
  return color;
}

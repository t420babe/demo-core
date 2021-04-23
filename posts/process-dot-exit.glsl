// Music: Sola by Nina Cobham
// #ifndef T4B_FRACTIONS_22
// lib/t420babe/fractions/fractions-22.glsl
float map(vec3 p3,float time) {
  p3.xz *= rot(time*0.3);
  p3.xy *= rot(time*0.2);
  vec3 q = p3*2.0+time;
  float x0 = length(p3+vec3( sin(time*0.7)));
  float x1 = log(length(p3)+1.0);
  float x2 = sin(q.x+atan(q.z+sin(q.y)))*5.5;
  return x0* x1+x2*5.0;
}
void process_dot_exit(vec3 p3,float time) {
  vec3 color = vec3(1.0);
  p3 *= 10.0;
  float y1 = 1.0*(sin(p3.x+1.0)*sin(p3.x*time));
  float m1 = plot(vec2(p3.x,p3.y),y1,0.10)*1.0;
  p3.xy *= rot(time*0.2)+m1;
  float rot_z = map(p3,time);
  float y = abs(sin(p3.x+1.0)+sin(p3.x*time));
  float m = plot(vec2(p3.x,p3.y),y,1.50)*1.0;
  float f = clamp((rot_z-map(p3+0.5,wrap_time(time,10.0)))*1.0,0.05,10.0);
  vec3 l = vec3(atan(f*p3.y*0.1));
  color *= l;
  gl_FragColor = vec4(color,1.0);
  gl_FragColor += texture2D(u_fb,vec2(p3.yx/2.+.5)+vec2(0.001,0.00))-0.002;
}

#endif

// #shaders #shader #livecode #glsl #gpu #programming #algorithms #frequency #vj #vjing #art #procedural #creativecode #creativecoding #nyc #bushwick #brooklyn


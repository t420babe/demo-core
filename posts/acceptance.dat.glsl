// Go Home by KP Hydes
// #ifndef T4B_ABF_98
mat2 rotate2d(float theta){
    return mat2(cos(theta),-sin(theta),sin(theta),cos(theta));
}
void acceptance_dot_dat(vec3 p3,float time) {
  vec3 color=vec3(1.0);
  time=wrap_time(time,800.0);
  float y1=0.01*(tan(p3.x*10.0)+atan(p3.x*time));
  float m1=plot(vec2(p3.y,p3.x),y1,1.20);
  p3.xz *=rotate2d(time*0.3+0.4)*m1;
  p3.xy *=rotate2d(time*0.2)*m1;
  float y=tan(p3.x*10.0)+cos(p3.x*time);
  float m=plot(vec2(p3.x,2.0*p3.y),y,0.50);
  color=vec3(m);
  color.r*=abs(sin(time*0.1))*u_n*2.0;
  color.b*=abs(tan(time*0.1))*u_n*2.0;
  color.g*=abs(cos(time*0.1))*u_bp*2.0;
  gl_FragColor=vec4(color.brg,1.0);
  gl_FragColor-=texture2D(u_fb,vec2(p3.xy/3.+.5)+vec2(0.002,0.00))-0.002;
  gl_FragColor+=texture2D(u_fb,vec2(p3.yx/2.+.5)+vec2(0.001,0.00))-0.002;
}

// #shaders #shader #livecode #glsl #gpu #programming #algorithms #frequency #vj #vjing #visualart #procedural #creativecode #nyc #bushwick #brooklyn


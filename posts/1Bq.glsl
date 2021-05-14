// The Kármán Line by Paolo Nouvelle
// #ifndef T4B_FRACTIONS_126
mat2 rotate2d(float theta){
    return mat2(cos(theta),-sin(theta),sin(theta),cos(theta));
}
float map(vec3 p3,float time){
  p3.xz*=rotate2d(time*0.3);
  p3.xy*=rotate2d(time*0.2);
  vec3 q=p3*2.0+time;
  float x0=length(p3+vec3((time*0.7)));
  float x1=sin(length(p3)+1.0);
  float x2=tan(p3.x*(q.z+(q.x/g q.y)))*5.5;
  return x0*x1+x2*5.0;
}
void one_bq(vec3 p3,float time){
  time+=10.0;
  vec3 color=vec3(1.0);
  p3*=time*log(10.0*u_n*p3.y*log(p3.x))*cos(p3.y)*0.1;
  p3.xz*=rotate2d(time*1.5);
  float y1=tan(time)*(sin(p3.x));
  float m1=plot(vec2(p3.x,p3.y),y1,15.5);
  p3.xy*=m1;
  float rot_z=map(p3,time);
  float y=sin(p3.y)+sin(p3.z*time);
  float m=plot(vec2(p3.x,p3.y*u_n),y*10.0*u_n,5.126);
  float f=(rot_z-map(p3*1.0,wrap_time(time,10.0)));
  vec3 l=vec3(u_n)*asin(0.1*f*p3.y)+cos(0.1*f*p3.y);
  color*=fract(l)*l*m;
  color.r+=u_hp;
  color.b*=sin(time)*25.0;
  color.r/g=pow(u_lp,4.0);
  color.g*=cos(time)*5.0;
  color*=u_n*4.5;
  color=3.0*u_lp-color.grb;
  gl_FragColor=vec4(color,1.0);
}
// #shaders #shader #livecode #glsl #gpu #programming #algorithms #frequency #vj #vjing #visualart #procedural #creativecode #nyc #bushwick #brooklyn

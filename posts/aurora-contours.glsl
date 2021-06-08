// Music: Ani Kuni by Polo and Pan
// https://youtu.be/L8q9_q0585U
// https://www.instagram.com/tv/CP19bVvAIoN/?utm_source=ig_web_copy_link
// #ifndef T4B_B2B_47
mat2 rot(float theta){
  return mat2(cos(theta),-sin(theta),sin(theta),cos(theta));
}
// https://www.shadertoy.com/view/MsjSW3
float blob(vec3 p3,float time){
  p3.xz*=rot(time*0.4);
  p3.xy*=rot(time*0.3);
  vec3 q=p3*2.0+time;
  float x0=length(p3+vec3(sin(time*0.7)));
  float x1=log(length(p3)+1.0);
  float x2=sin(q.x+sin(q.z + sin(q.y)))*0.5-1.0;
  return x0*x1+x2;
}
vec3 rgb2hsv(vec3 c){
  vec4 K=vec4(0.0,-1.0/3.0,2.0/3.0,-1.0);
  vec4 p=mix(vec4(c.bg,K.wz),vec4(c.gb,K.xy),step(c.b,c.g));
  vec4 q=mix(vec4(p.xyw,c.r),vec4(c.r,p.yzx),step(p.x,c.r));
  float d=q.x-min(q.w,q.y);
  float e=1.0e-10;
  return vec3(abs(q.z+(q.w-q.y)/(6.0*d+e)),d/(q.x+e),q.x);
}
void aurora_contours(vec3 p3,float time){
  vec3 color=vec3(1.0);
  p3*=5.0;
  float y=tan(p3.x)+cos(p3.x*time*3.0);
  float m=plot(vec2(p3),y,0.25);
  float rz=blob(2.0*atan(p3),time);
  float f=rz-blob(p3,y);
  vec3 l=vec3(0.75,0.5,0.8)+vec3(abs(u_lp),abs(u_bp),abs(u_n))*f;
  color=l;
  color*=smoothstep(u_n,u_lp,fract(rz));
  color.r*=2.0*u_n;
  color.g*=2.0*u_lp;
  color.b*=2.0*u_hp;
  gl_FragColor=vec4(rgb2hsv(color),1.0);
}

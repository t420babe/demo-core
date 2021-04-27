// fractoins-67.glsl
// Kings & Queens by Capolla, 2STRANGE
// 2021.04.26
mat2 rot(float theta){
    return mat2(cos(theta),-sin(theta),sin(theta),cos(theta));
}
float map(vec3 p3,float time) {
  p3.xz *=rot(time*0.3);
  p3.xy *=rot(time*0.2);
  vec3 q =tan(p3*2.0+time);
  float x0 =length(p3+vec3((time*0.7)));
  float x1 =sin(length(p3)+1.0);
  float x2 =log(q.x+(q.z+(q.y)))*1.0;
  return x0*x1/x2*1.0;
}
void playing_koi(vec3 p3,float time) {
  vec3 color =vec3(1.0);
  p3.xz *=rot(p3.x*u_n*10.0);
  p3.yx *=-rot(time*0.8);
  p3 *=5.0;
  float y1 =1.0*(sin(p3.x ));
  float m1 =plot(vec2(p3.x,p3.y),y1,1.5);
  p3.xy *=m1;
  float rot_z =map(p3,time);
  float y =1.0*(sin(p3.y*time)+sin(p3.z*time));
  float m =plot(vec2(p3.x,p3.y*u_lp),y*10.0 *u_lp,5.50)*1.0;
  float f = (rot_z*map(p3*1.0,wrap_time(time,10.0)) ) ;
  vec3 l =vec3(u_n)*asin(0.1*f*p3.y)+cos(0.1*f*p3.y);
  color *=fract(l)*m;
  color *=(l);
  color.r *=1.0*u_bp;
  color.g *=8.0*u_n;
  color =1.0-color;
  gl_FragColor =vec4(color,1.0);
}

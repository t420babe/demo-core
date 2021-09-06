// Music: Pink + White by Frank Ocean
// #ifndef T4B_ABF_32
mat2 rot2d(float theta){
    return mat2(cos(theta),-sin(theta),sin(theta),cos(theta));
}
float map(vec3 p3,float time) {
  p3.xz *=rot2d(time*0.3);
  p3.xy *=rot2d(time*0.2);
  vec3 q =p3*2.0+time;
  float x0 =length(p3+vec3(sin(time*0.7)));
  float x1 =log(length(p3)+1.0);
  float x2 =sin(q.x+atan(q.z+sin(q.y)))*5.5;
  return x0* x1+x2*5.0;
}
void immaterial(vec3 p3,float time) {
  vec3 color =vec3(1.0);
  p3 *=100.0*cos(p3.x)*sin(p3.x);
  p3.xz *=rot2d(time*0.1);
  p3.yx *=rot2d(time*0.2);
  float y1 =1.0*(sin(p3.x+1.0));
  float m1 =plot(vec2(p3.x,p3.y),y1,5.10)*1.0;
  p3.xy *=m1;
  float rot_z =map(p3,time);
  float y =1.0*(sin(p3.y+1.0)+sin(p3.z*time));
  float m =plot(vec2(p3.x,p3.z),y,5.50)*1.0;
  float f = (rot_z-map(p3*1.0,wrap_time(time,10.0))) ;
  vec3 l =vec3(1.0,1.0,1.0)*asin(f*p3.y*2.0)+cos(f*p3.y*2.0) ;
  color *=fract(l);
  color.r *=u_no;
  color.g *=u_hp;
  color.b *=u_lp;
  color.b *=500.0;
  gl_FragColor =vec4(color,1.0);
}

#shaders #shader #livecode #glsl #gpu #programming #algorithms #frequency #vj #vjing #art #procedural #creativecode #creativecoding #nyc #bushwick #brooklyn 

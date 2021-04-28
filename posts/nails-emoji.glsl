// Hypnotise Me by Sonny Grin,KP Hydes
// #ifndef T4B_FRACTIONS_11
#define PI 3.14159265358979323846
mat2 rot(float theta){
  return mat2(cos(theta),-sin(theta),sin(theta),cos(theta));
}
void nails_emoji(vec3 p3,float time) {
  time+=1000.0;
  vec3 color =vec3(1.0);
  p3.x/=10.0;
  p3.y*=2.5;
  float y1=1.0*(tan(p3.x*10.0)*cos(p3.x*time));
  float m1=plot(vec2(p3.x,p3.y),y1,u_n*5.0)*0.5;
  p3.xz*=rot(time*PI/6.0+PI/4.0)*m1;
  p3.xy*=rot(time*PI/4.0)*m1;
  float y =0.1*(tan(p3.x*20.0)*cos(p3.y*time));
  float m =plot(vec2(p3.x,2.0*p3.y),y,0.20);
  color*=m;
  color=0.8-color;
  color.r*=u_n*3.0;
  color.g*=u_n*5.0;
  color.b*=u_n*1.0;
  color.g/=u_hp*1.0;
  gl_FragColor=vec4(color.brg,1.0);
  gl_FragColor+=texture2D(u_fb,vec2(p3.x+0.0,p3.y+0.5));
}

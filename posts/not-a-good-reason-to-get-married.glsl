// Music: Biessel Street Freestyle by KP Hydes
// #ifndef T4B_FRACTIONS_94
#define PI 3.14159265358979323846
mat2 rot(float theta){
    return mat2(cos(theta),-sin(theta),sin(theta),cos(theta));
}
void not_a_good_reason_to_get_married(vec3 p3,float time) {
  vec3 color=vec3(1.0);
  p3.y/=1.0;
  p3*=1.0;
  float y1=1.0*(tan(p3.x*10.0)*cos(p3.x*time));
  float m1=plot(vec2(p3.x,p3.y),y1,2.20)*1.0;
  p3.xz*=rot(time*PI/6.0+PI/4.0)*m1;
  p3.xy*=rot(time*PI/4.0)*m1;
  float y=0.1*(tan(p3.x*10.0)*cos(p3.x*time));
  float m=plot(vec2(p3.x,2.0*p3.y),y,0.20);
  color*=m;
  color*=1.1;
  color.r*=1.8*u_n;
  color.b*=1.5*u_hp;
  color.g*=1.5*u_n;
  gl_FragColor=vec4(color,1.0);
  gl_FragColor-=texture2D(u_fb,vec2(p3.yx/2.+.5)+vec2(0.001,0.00))-0.002;
  gl_FragColor+=texture2D(u_fb,vec2(p3.xy+0.5));
}

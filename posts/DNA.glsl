// The Flute Song-Paul Kalkbrenner Remix by Kid Simius
// #ifndef T4B_ABH_13
float map(vec3 p3,float time){
  p3.xz*=rotate2d(time*0.3);
  p3.xy*=rotate2d(time*0.1);
  vec3 q=p3*2.0+time;
  float x0=length(p3+vec3(sin(time*0.7)));
  float x1=length(p3)+1.0;
  float x2=sin(q.x+tan(q.z*sin(q.y)))*5.5;
  return x0*x1+x2*5.0;
}
void DNA(vec3 p3,float time){
  vec3 color=vec3(1.0);
  p3.y+=0.1;
  p3*=5.0;
  float y=tan(PI*p3.x)+sin(p3.y*time*PI/4.0);
  float m=plot(vec2(p3),y,0.35);
  float rz=map(p3,time);
  color=m*color+m*vec3(1.0);
  vec3 l=vec3(m);
  color+=smoothstep(0.5,0.5,rz);
  gl_FragColor=vec4(1.0-color,1.0);
}

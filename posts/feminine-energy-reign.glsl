// Clozee-https://www.youtube.com/watch?v=EnYmqdQA73s&t=1814s
// #ifndef T4B_B2B_05
#define PI 3.14159265358979323846
float plot(vec2 p2,float pct,float bound){
  return smoothstep(pct-bound,pct,p2.y)-smoothstep(pct,pct+bound,p2.y);
}
void feminine_energy_regin(vec3 p3,float time) {
  time+=8.0;
  vec3 color=vec3(1.0);
  p3*=time*0.01;
  p3.y+=0.5;
  float y=tan(2.0*p3.x)+cos(p3.x*time);
  float m=plot(vec2(p3.x,p3.y),y)*50.0;
  color=(1.0-m)*color+m*vec3(u_n,u_hp,u_lp);
  gl_FragColor=vec4(1.0-color,1.0);
}
// #shaders #shader #livecode #glsl #gpu #programming #algorithms #frequency #vj #vjing #visualart #procedural #creativecode #nyc #bushwick #brooklyn #clozee

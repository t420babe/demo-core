// Honeydust - Clozee Remix by Of The Trees Feat. Kala
// https://www.youtube.com/watch?v=EnYmqdQA73s
// #ifndef T4B_B2B_04
#define PI 3.14159265358979323846
float plot(vec2 p2,float pct,float bound){
  return smoothstep(pct-bound,pct,p2.y)-smoothstep(pct,pct+bound,p2.y);
}
void still_here(vec3 p3,float time){
  vec3 color=vec3(1.0);
  p3*=2.0;
  float y=(tan(2.0*p3.x)+cos(p3.y*time));
  float m=plot(p3.xy,y,0.045);
  color=m*color+m*vec3(u_n,u_hp,u_lp);
  gl_FragColor=vec4(color,1.0);
  gl_FragColor+=texture2D(u_fb,vec2(abs(sin(p3.yx/(PI*0.6)+PI))+0.1)+vec2(0.001,0.001))-0.01;
}
// #shaders #shader #livecode #glsl #gpu #programming #algorithms #frequency #vj #vjing #visualart #procedural #creativecode #nyc #bushwick #brooklyn #clozee

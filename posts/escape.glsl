// minor sunrise by elderflower
// post: Escape
// #trippy #rave
// #ifndef T4B_TTT_36

float map(vec2 p) {
  return length(p)+ 0.2;
}
// Forked: https://www.shadertoy.com/view/7sf3z2
vec3 forked_wavez(vec2 p2,float time) {
  vec3 col;
  vec3 color=vec3(1.0);
  for(float j=0.0;j<1.0;j++){
    for(float i=1.0;i<2.0;i++){
      p2.x+=sin(time)*i*j;
      p2.y+=cos(time)*i*j;
      col[int(j)]=-1.0*(p2.x*sin(p2.y/time));
      col[int(j)]=-1.0*(p2.x*tan(p2.y*time));
    }
  }
  vec3 bg=vec3(1.0,1.5*u_hp,1.5*u_n);
  color=mix(col,bg,
      1.0-smoothstep(abs(atan(time)),abs(sin(time*0.05)*1.0/(1.5*u_n)),map(p2*(u_hp)*4.0))*10.0);  
  return color;
}

void escape(vec3 p3,float time) {
  p3.xy*=1.5;
  vec3 color=vec3(0.0);
  color=forked_wavez(p3.yx,time)*2.5;
  gl_FragColor=vec4(color,1.0);
}

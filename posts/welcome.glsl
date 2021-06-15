// Music: Welcome to Slow Air by @stillcorners
// #ifndef T4B_ARRIVAL_23
mat2 rot(float theta){
    return mat2(cos(theta),-sin(theta),sin(theta),cos(theta));
}
void welcome(vec3 p3,float time){
  u_hp*=2.0;
  u_lp*=2.0;
  u_n*=10.5;
  vec3 color=vec3(1.0);
  vec2 rhom_p=p3.xy*2.0;
  float rot_rate=0.05;
  rhom_p*=rot(tan(time*rot_rate)*3.14/1.0);
  p3*=0.835; // comment for less fire
  float flower_size=1.5*u_n;
  float flower=flower_sdf(vec2(rhom_p.x+flower_size/2.0,rhom_p.y+flower_size/2.0)/flower_size,100);
  float rhombus=rhombus_sdf(rhom_p,1.0);
  float hex=hexagon_sdf(rhom_p,wrap_time(time*0.5,15.0)+5.0,u_n*40.0+1.0);
  vec2 rays_p=rhom_p;
  rays_p.y+=1.0;
  float rays=rays_audio(rays_p,20,audio);
  float bri=sharp(flower)-sin(hex);
  bri/=(rhombus)*1.0;
  color=1.5-color;
  color=vec3(bri*u_hp,bri*u_n,bri*u_lp);
  color.r*=abs(sin(time));
  color.g*=abs(cos(time));
  color.b*=abs(tan(time));
  gl_FragColor=vec4(color,bri);
  gl_FragColor+=texture2D(u_fb,vec2(p3.xy/2.0+0.5)-vec2(0.00,0.001))-0.002;
}

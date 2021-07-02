// Tondo - Eko Roosevelt by Disclosure
// #ifndef T4B_TTT_20

// Forked: https://www.shadertoy.com/view/7sf3z2
float map(vec2 p) {
    return length(p) - 0.2;
}

vec3 party_starter(vec2 pos, float time, peakamp audio) {
  vec3 col;
  vec3 color = vec3(1.,1.,1.);

  for(float j = 0.0; j < 3.0; j++){
      for(float i = 1.; i < 7.0; i++){
          pos.x += (1.0 * (0.2 / (i + j) * sin(i * atan(time) * 2.0 * pos.y + (time * 0.1) + i * j)));
          pos.y+= (1.0 * (1.0 / (i + j) * cos(i * 0.6 * pos.x + (time * 0.25) + i * j)));
      col[int(j)] = -1.0 * (pos.x * tan(pos.y / time));
      col[int(j)] = -1.0 * (pos.x * tan(pos.y * time));
      }
  }
  

  vec3 bg = vec3(1.5, 2.0 * abs(audio.bandpass), 2.0 * abs(audio.notch));
  color = mix(
    col,
    bg,
    1.0-smoothstep(0.0,abs(sin(time*0.05)*3.0 / abs(audio.bandpass)), map(pos * abs(audio.notch) * 4.0))
  );   
  return color;
}

void ttt_20(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  float w_time = wrap_time(time, t2s(0.0, 4.0, 23.0)/ 2.0);
  pos *= 3.0;
  vec3 color = vec3(0.0);
  color = party_starter(pos.yx, w_time, audio);

  vec3 hsv_color = rgb2hsv(color);
  gl_FragColor = vec4(color, 1.0);
}
#endif

// Author @patriciogv - 2015
// http://patriciogonzalezvivo.com
#ifndef BOS_IKEDA_03
#define BOS_IKEDA_03

float random (in float x) { return fract(sin(x)*1e4);}
float random (in vec2 pos) { return fract(1e4 * sin(17.0 * pos.x + pos.y * 0.1) * (0.1 + abs(sin(pos.y * 13.0 + pos.x)))); }

float pattern(vec2 pos, vec2 v, float t) {
    vec2 p = floor(pos+v);
    return step(t, random(100.+p*.000001)+random(p.x)*0.5 );
}

void ikeda_03(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
    vec2 grid = vec2(100.0, 50.0);
    pos *= grid;

    vec2 ipos = floor(pos);  // integer
    vec2 fpos = fract(pos);  // fraction

    vec2 vel = vec2(u_time * 2.0 * max(grid.x, grid.y)); // time
    vel *= vec2(-1.0, 0.0) * random(1.0 + ipos.y); // direction

    // Assign a random value base on the integer coord
    vec2 offset = vec2(0.3, 0.0);
    float pct = 0.5;    //u_mouse.x/u_resolution.x;

    color.r = pattern(pos + offset, vel, 0.5 + pct);
    color.g = pattern(pos, vel, 0.5 + pct);
    color.b = pattern(pos - offset, vel, 0.5 + pct);


    // Margins
    color *= step(0.2, fpos.y);

    gl_FragColor = vec4(color,1.0);
}
#endif

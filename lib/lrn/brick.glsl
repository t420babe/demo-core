/// Brick pattern. Determine which square of the checkerboard contains the sample point and then test
/// the parity of the sum of the row and column to determine the color of that square.
// From Chapter 2 of Texturing & Modeling: A Procedural Approach

#ifndef LRN_BRICK
#define LRN_BRICK
vec3 brick(vec2 pos) {
  float brick_width = 0.25;
  float brick_height = 0.08;
  float mortar_thickness = 0.01;

  float bm_width = brick_width + mortar_thickness;
  float bm_height = brick_height + mortar_thickness;

  float mwf = mortar_thickness * 0.5 / bm_width;
  float mhf = mortar_thickness * 0.5 / bm_height;

  vec3 c_brick = vec3(0.5, 0.15, 0.14);
  vec3 c_mortar = vec3(0.5, 0.5, 0.5);

  // Standard coordinates that will become the coordinates of the upper-left corner of the brick
  // containing the point being shaded.
  float scoord = pos.x;
  float tcoord = pos.y;

  // Divide standard coordinates by brick dimension. New coordinates vary between 0 and 1 for each
  // brick.
  float ss = scoord / bm_width;
  float tt = tcoord / bm_height;

  // Alternate rows of bricks are offset by one-half brick width to simulate the usual way bricks
  // are laid.
  if (mod(tt * 0.5, 1.0) > 0.5) {
    ss += 0.5;  // shift alternate rows
  }

  // Identify which brick contains the point being shaded.
  float s_brick = floor(ss);  // Which brick?
  float t_brick = floor(tt);  // Which brick?
  // Identify texture coordinates of the point being shaded.
  ss -= s_brick;
  tt -= t_brick;

  // Determine if the point is in the brick proper or in the mortar between the bricks.
  float w = step(mwf, ss) - step(1.0 - mwf, ss);  // Vertical pulse
  float h = step(mhf, tt) - step(1.0 - mhf, tt);  // Horizontal pulse
  // Multiplying the vertical pulse `w` and the horizontal pulse `h` results in the logical AND of
  // `w` and `h`. That is, `w * h` is nonzero only when the point is within the brick region both
  // horizontally and vertically. In this case, the `mix` function switches from the mortar color
  // `c_mortar` and the brick color `c_brick`.
  vec3 color = mix(c_mortar, c_brick, w * h);
  return color;
}
#endif

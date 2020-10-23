#ifndef EFFECTS_INVERT
#define EFFECTS_INVERT
void invert(out vec3 color) {
  color = 1.0 - color;
}
#endif

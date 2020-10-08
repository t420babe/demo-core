#ifndef COMMON_WRAP_TIME
#define COMMON_WRAP_TIME
float wrap_time(float u_time, float limit) {
  float mod_time = mod(u_time, limit);
  if (mod_time < limit / 2.0) {
    return mod_time;
  } else {
    return limit - mod_time;
  }
}
#endif


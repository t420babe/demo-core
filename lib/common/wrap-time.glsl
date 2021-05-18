#ifndef COMMON_WRAP_TIME
#define COMMON_WRAP_TIME

float wrap_time_neg(float time, float limit) {
  float mod_time = mod(time, limit * 3.0);
  if (mod_time < limit * 2.0) {
    return limit - mod(time, limit);

  } else {
    mod_time = mod(time, limit * 2.0);
    if ( mod_time < limit ) {
      return mod_time;

    } else {
      return limit - mod_time;
    }
  }
}

float wrap_time(float time, float limit) {
  limit *= 2.0;
  float mod_time = mod(time, limit);
  if (mod_time < limit / 2.0) {
    return mod_time;
  } else {
    return limit - mod_time;
  }
}
#endif


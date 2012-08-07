#include "ruby.h"

#ifdef RUBY_19
#include "ruby/intern.h"
#else
#include "intern.h"
#endif

int int_coreloc_enable();
void int_coreloc_get(double* lat, double* log);

VALUE coreloc_enable(VALUE r_self) {
  if(int_coreloc_enable()) {
    return Qtrue;
  }

  return Qfalse;
}

VALUE coreloc_pos(VALUE r_self) {
  double lat, log;

  int_coreloc_get(&lat, &log);

  return rb_ary_new3(2, rb_float_new(lat),
                        rb_float_new(log));
}

void Init_lost() {
  VALUE mod = rb_define_module("Lost");

  rb_define_singleton_method(mod, "coreloc_enable", coreloc_enable, 0);
  rb_define_singleton_method(mod, "current_position", coreloc_pos, 0);
}


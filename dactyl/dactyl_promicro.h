#pragma once

#include "quantum.h"

#ifdef USE_I2C
#include <stddef.h>
#ifdef __AVR__
    #include <avr/io.h>
    #include <avr/interrupt.h>
#endif
#endif


#define LAYOUT_6x6(\
    k00, k01, k02, k03, k04, k05,           k55, k54, k53, k52, k51, k50, \
    k10, k11, k12, k13, k14, k15,           k65, k64, k63, k62, k61, k60, \
    k20, k21, k22, k23, k24, k25,           k75, k74, k73, k72, k71, k70, \
    k30, k31, k32, k33, k34, k35,           k85, k84, k83, k82, k81, k80, \
                   k40, k41, k42,           k95, k94, k93, \
                        k43, k44,           k92, k91 \
)\
{\
    { k05, k04, k03, k02, k01, k00 }, \
    { k15, k14, k13, k12, k11, k10 }, \
    { k25, k24, k23, k22, k21, k20 }, \
    { k35, k34, k33, k32, k31, k30 }, \
    { k42, k41, k40, KC_NO, KC_NO, KC_NO }, \
    { k44, k43, KC_NO, KC_NO, KC_NO, KC_NO }, \
    { k50, k51, k52, k53, k54, k55 }, \
    { k60, k61, k62, k63, k64, k65 }, \
    { k70, k71, k72, k73, k74, k75 }, \
    { k80, k81, k82, k83, k84, k85 }, \
    { KC_NO, KC_NO, KC_NO, k93, k94, k95 }, \
    { KC_NO, KC_NO, KC_NO, KC_NO, k91, k92 }, \
}

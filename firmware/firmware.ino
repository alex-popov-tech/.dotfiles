// -*- mode: c++

#ifndef BUILD_INFORMATION
#define BUILD_INFORMATION "locally built"
#endif

#include "Kaleidoscope.h"
#include "Kaleidoscope-EEPROM-Settings.h"
#include "Kaleidoscope-EEPROM-Keymap.h"
#include "Kaleidoscope-FocusSerial.h"
#include "Kaleidoscope-HostOS.h"
#include "Kaleidoscope-LED-Palette-Theme.h"
#include "Kaleidoscope-LEDEffect-Breathe.h"
#include "Kaleidoscope-LED-Stalker.h"
#include "Kaleidoscope-Colormap.h"
#include "Kaleidoscope-Syster.h"

#include "Kaleidoscope-Macros.h"

enum { MACRO_SCREEN };

enum { COLEMAK };

#define Key_LBracket      Key_LeftBracket
#define Key_RBracket      Key_RightBracket

// *INDENT-OFF*
KEYMAPS(
  [COLEMAK] = KEYMAP_STACKED (
    XXX,          Key_1, Key_2, Key_3, Key_4, Key_5, Key_VolumeUp,
    Key_LBracket, Key_Q, Key_W, Key_F, Key_P, Key_G, Key_VolumeDown,
    Key_Tab,      Key_A, Key_R, Key_S, Key_T, Key_D,
    Key_Backtick, Key_Z, Key_X, Key_C, Key_V, Key_B, Key_Equals,
    Key_Enter, Key_Backspace, Key_LeftGui, Key_LeftControl,
    Key_LeftShift,

    Key_Mute,        Key_6, Key_7, Key_8,     Key_9,      Key_0,     Key_LEDEffectNext,
    M(MACRO_SCREEN), Key_J, Key_L, Key_U,     Key_Y,      Key_Quote, Key_RBracket,
                     Key_H, Key_N, Key_E,     Key_I,      Key_O,     Key_Minus,
    Key_Semicolon,   Key_K, Key_M, Key_Comma, Key_Period, Key_Slash, Key_Backslash,
    Key_RightAlt, Key_RightGui, Key_Spacebar, Key_Escape,
    Key_LeftShift
  )
)
// *INDENT-ON*

const macro_t *macroAction(uint8_t macroIndex, uint8_t keyState) {
  switch (macroIndex) {
    case MACRO_SCREEN:
      // print screen
      return MACRODOWN(D(LeftGui), D(LeftShift), T(4), U(LeftShift), U(LeftGui));
    }
  return MACRO_NONE;
}

KALEIDOSCOPE_INIT_PLUGINS(
  LEDControl,
  HostOS,
  EEPROMSettings,
  EEPROMKeymap,
  ColormapEffect,
  LEDPaletteTheme,
  LEDOff,
  LEDBreatheEffect,
  StalkerEffect,

  Syster,
  Focus,

  Macros
);

void setup() {
  Kaleidoscope.setup();

  ColormapEffect.max_layers(1);
  ColormapEffect.activate();

  // red haunt after press
  StalkerEffect.variant = STALKER(Haunt, (CRGB(255, 0, 0)));
  StalkerEffect.activate();
  // To make the keymap editable without flashing new firmware, we store
  // additional layers in EEPROM. For now, we reserve space for five layers. If
  // one wants to use these layers, just set the default layer to one in EEPROM,
  // by using the `settings.defaultLayer` Focus command.
  EEPROMKeymap.setup(1, EEPROMKeymap.Mode::EXTEND);
}

void loop() {
  Kaleidoscope.loop();
}

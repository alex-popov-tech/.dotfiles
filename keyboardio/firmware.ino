// -*- mode: c++ -*-

#ifndef BUILD_INFORMATION
#define BUILD_INFORMATION "locally built"
#endif

#include "Kaleidoscope.h"
#include "Kaleidoscope-EEPROM-Settings.h"
#include "Kaleidoscope-EEPROM-Keymap.h"
#include "Kaleidoscope-Colormap.h"
#include "Kaleidoscope-FocusSerial.h"
#include "Kaleidoscope-LED-Palette-Theme.h"
#include "Kaleidoscope-OneShot.h"
#include "Kaleidoscope-Escape-OneShot.h"
#include "Kaleidoscope-Qukeys.h"
#include "Kaleidoscope-TapDance.h"
#include "Kaleidoscope-MouseKeys.h"
#include "Kaleidoscope-Macros.h"
#include "Kaleidoscope-LEDControl.h"
#include "Kaleidoscope-LED-ActiveModColor.h"
#include "Kaleidoscope-LEDEffect-BootGreeting.h"
#include "Kaleidoscope-LEDEffect-Breathe.h"
#include "Kaleidoscope-LEDEffect-Rainbow.h"
#include "Kaleidoscope-LED-Stalker.h"
#include "Kaleidoscope-Model01-TestMode.h"

enum { MACRO_TOGGLE_LANG, MACRO_SCREEN };

enum { WORKMAN, DIGITS_AND_PUNCTUATION, MOVEMENT, QWERTY };

// *INDENT-OFF*

KEYMAPS(
  [WORKMAN] = KEYMAP_STACKED (
       ___,        M(MACRO_SCREEN), LSHIFT(Key_Backtick), LSHIFT(Key_Slash), LSHIFT(Key_3), ___,   Key_Mute,
       Key_Tab,    Key_Q,           Key_D,                Key_R,             Key_W,         Key_B, Key_VolumeUp,
                   Key_Escape,      Key_A,                Key_S,             Key_H,         Key_T, Key_G,
       ___,        Key_Z,           Key_X,                Key_M,             Key_C,         Key_V, Key_VolumeDown,
       CTL_T(Escape), Key_Backspace, OSM(LeftGui), OSM(LeftShift),
       LockLayer(DIGITS_AND_PUNCTUATION),

       Key_LEDEffectNext,    ___,   ___,   ___,   LSHIFT(Key_6), ___,    ___,
       ___,                  Key_J, Key_F, Key_U, Key_P,         TD(0),  TD(1),
                             Key_Y, Key_N, Key_E, Key_O,         Key_I,  TD(2),
       M(MACRO_TOGGLE_LANG), Key_K, Key_L, TD(3), TD(4),         TD(5),  ___,
       OSM(LeftShift), OSM(LeftAlt), Key_Spacebar, CTL_T(Enter),
       LockLayer(MOVEMENT)
    ),
  [DIGITS_AND_PUNCTUATION] = KEYMAP_STACKED (
       ___, ___,               ___,             ___,                     ___,               ___,   ___,
       ___, LSHIFT(Key_Minus), Key_Slash,       Key_Minus,               LSHIFT(Key_5),     ___,   ___,
       ___, Key_1,             Key_2,           Key_3,                   Key_4,             Key_5,
       ___, Key_Backslash,     Key_LeftBracket, LSHIFT(Key_LeftBracket), LSHIFT(Key_Comma), ___,   ___,
       ___, ___, ___, ___,
       ___,

       ___, ___,   ___,                ___,                      ___,              ___,                   ___,
       ___, ___,   Key_Equals,         LSHIFT(Key_Equals),       LSHIFT(Key_8),    ___, ___,
            Key_6, Key_7,              Key_8,                    Key_9,            Key_0,                 ___,
       ___, ___,   LSHIFT(Key_Period), LSHIFT(Key_RightBracket), Key_RightBracket, ___,         ___,
       ___, ___,   ___, ___,
       ___
    ),
  [MOVEMENT] = KEYMAP_STACKED (
       ___, ___, ___, ___, ___, ___, ___,
       ___, ___,           Key_mouseWarpNW, Key_mouseUp,      Key_mouseWarpNE, ___,           ___,
       ___, Key_mouseBtnR, Key_mouseL,      Key_mouseDn,      Key_mouseR,      Key_mouseBtnL,
       ___, ___,           Key_mouseWarpSW, Key_mouseWarpEnd, Key_mouseWarpSE, ___,           ___,
       ___, ___, ___, ___,
       ___,

       ___, ___, ___, ___, ___, ___, ___,
       ___, ___, ___, ___, ___, ___, ___,
            Key_LeftArrow,    Key_DownArrow,     Key_UpArrow,       Key_RightArrow,   ___, ___,
       ___, Key_mouseScrollL, Key_mouseScrollDn, Key_mouseScrollUp, Key_mouseScrollR, ___, ___,
       ___, ___, ___, ___,
       ___
    ),
  [QWERTY] = KEYMAP_STACKED (
       ___,           ___,   ___,   ___,   ___,   ___,   ___,
       Key_Backslash, Key_Q, Key_W, Key_E, Key_R, Key_T, ___,
                      ___,   Key_A, Key_S, Key_D, Key_F, Key_G,
       ___,           Key_Z, Key_X, Key_C, Key_V, Key_B, ___,
       ___, ___, ___, ___,
       ___,

       ___,  ___,   ___,   ___,       ___,           ___,           ___,
       ___,  Key_Y, Key_U, Key_I,     Key_O,         Key_P,         Key_LeftBracket,
             Key_H, Key_J, Key_K,     Key_L,         Key_Semicolon, Key_Quote,
       ___,  Key_N, Key_M, Key_Comma, Key_Period,    Key_Slash,     Key_RightBracket,
       ___, ___, ___, ___,
       ___
    )
)

// *INDENT-ON*

const macro_t *macroAction(uint8_t macroIndex, uint8_t keyState) {
  switch (macroIndex) {
    case MACRO_SCREEN:
      // print screen
      return MACRODOWN(D(LeftGui), D(LeftShift), T(4), U(LeftShift), U(LeftGui));
    case MACRO_TOGGLE_LANG:
      // toggle os lang and switch between qwerty-workman
      return MACRODOWN(D(LeftControl), T(Spacebar), U(LeftControl), W(100), Tr(LockLayer(QWERTY)));
    }
  return MACRO_NONE;
}

void tapDanceAction(uint8_t tap_dance_index, byte row, byte col, uint8_t tap_count,
                    kaleidoscope::TapDance::ActionType tap_dance_action) {
  switch (tap_dance_index) {
    case 0:
      return tapDanceActionKeys(tap_count, tap_dance_action, LSHIFT(Key_1), LSHIFT(Key_Slash));
    case 1:
      return tapDanceActionKeys(tap_count, tap_dance_action, LSHIFT(Key_2), LSHIFT(Key_3));
    case 2:
      return tapDanceActionKeys(tap_count, tap_dance_action, LSHIFT(Key_Semicolon), Key_Semicolon);
    case 3:
      return tapDanceActionKeys(tap_count, tap_dance_action, LSHIFT(Key_9), Key_Quote);
    case 4:
      return tapDanceActionKeys(tap_count, tap_dance_action, LSHIFT(Key_0), LSHIFT(Key_Quote));
    case 5:
      return tapDanceActionKeys(tap_count, tap_dance_action, Key_Period, Key_Comma);
    }
}

KALEIDOSCOPE_INIT_PLUGINS(
  EEPROMSettings,
  EEPROMKeymap,
  Focus,
  TestMode,

  LEDControl,
  LEDPaletteTheme,
  ColormapEffect,

  OneShot,
  EscapeOneShot,
  Qukeys,
  TapDance,
  Macros,
  MouseKeys,

  BootGreetingEffect,
  ActiveModColorEffect,
  LEDRainbowWaveEffect,
  LEDBreatheEffect,
  StalkerEffect
);

void setup() {
  Kaleidoscope.setup();
  // Make mouse start moving faster
  MouseKeys.accelSpeed = 3;
  // increase default timeout a bit to do double-tap
  TapDance.time_out = 300;
  LEDRainbowWaveEffect.brightness(150);
  StalkerEffect.variant = STALKER(Haunt, (CRGB(255, 0, 0)));
  StalkerEffect.activate();

  // To make the keymap editable without flashing new firmware, we store
  // additional layers in EEPROM. For now, we reserve space for five layers. If
  // one wants to use these layers, just set the default layer to one in EEPROM,
  // by using the `settings.defaultLayer` Focus command.
  EEPROMKeymap.setup(5, EEPROMKeymap.Mode::EXTEND);
}

void loop() {
  Kaleidoscope.loop();
}

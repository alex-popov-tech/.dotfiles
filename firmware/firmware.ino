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
#include "Kaleidoscope-ModifierLayers.h"
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

enum { PDVORAK, PDVORAK_DIGITS, MOVEMENT, QWERTY };

// *INDENT-OFF*
KEYMAPS(
  [PDVORAK] = KEYMAP_STACKED (
    ___,           Key_LeftBracket, LSHIFT(Key_LeftBracket), LSHIFT(Key_1), LSHIFT(Key_9), Key_Equals, Key_VolumeUp,
    Key_Backtick,  Key_Semicolon,   LSHIFT(Key_4),           Key_Period,    Key_P,         Key_Y,      Key_Mute,
    Key_Tab,       Key_A,           Key_O,                   Key_E,         Key_U,         Key_I,
    LSHIFT(Key_7), Key_Quote,       Key_Q,                   Key_J,         Key_K,         Key_X,      Key_VolumeDown,
    CTL_T(Enter), SFT_T(Backspace), OSM(LeftGui), OSM(LeftShift),
    ShiftToLayer(MOVEMENT),

    Key_LEDEffectNext,    LSHIFT(Key_8), LSHIFT(Key_0), LSHIFT(Key_Slash), LSHIFT(Key_RightBracket), Key_RightBracket, TD(0),
    M(MACRO_SCREEN),      Key_F,         Key_G,         Key_C,             Key_R,                    Key_L,            Key_Slash,
                          Key_D,         Key_H,         Key_T,             Key_N,                    Key_S,            Key_Minus,
    M(MACRO_TOGGLE_LANG), Key_B,         Key_M,         Key_W,             Key_V,                    Key_Z,            LSHIFT(Key_Period),
    OSM(LeftAlt), OSM(LeftControl), SFT_T(Spacebar), GUI_T(Escape),
    ShiftToLayer(MOVEMENT)
  ),
  [PDVORAK_DIGITS] = KEYMAP_STACKED (
    ___,                   Key_7, Key_5,         Key_3,     Key_1, Key_9, ___,
    ___,                   ___,   LSHIFT(Key_5), Key_Comma, ___,   ___,   ___,
    ___,                   ___,   ___,           ___,       ___,   ___,
    LSHIFT(Key_Backslash), ___,   ___,           ___,       ___,   ___,   ___,
    ___, ___, ___, ___,
    ___,

    ___, Key_0, Key_2, Key_4, Key_6, Key_8, ___,
    ___, ___,   ___,   ___,   ___,   ___,   LSHIFT(Key_Equals),
         ___,   ___,   ___,   ___,   ___,   ___,
    ___, ___,   ___,   ___,   ___,   ___,   LSHIFT(Key_Comma),
    ___, ___, ___, ___,
    ___
  ),
  [MOVEMENT] = KEYMAP_STACKED (
    ___, ___, ___,              ___,           ___,              ___, ___,
    ___, ___, Key_mouseScrollL, Key_mouseUp,   Key_mouseScrollR, ___, ___,
    ___, ___, Key_mouseL,       Key_mouseDn,   Key_mouseR,       ___,
    ___, ___, ___,              Key_DownArrow, Key_UpArrow,      ___, ___,
    ___, ___, ___, ___,
    ___,

    ___, ___, ___,           ___,               ___,               ___,            ___,
    ___, ___, ___,           Key_mouseScrollDn, Key_mouseScrollUp, ___,            ___,
         ___, Key_LeftArrow, Key_mouseBtnL,     Key_mouseBtnR,     Key_RightArrow, ___,
    ___, ___, ___,           ___,               ___,               ___,            ___,
    ___, ___, ___, ___,
    ___
  ),
  [QWERTY] = KEYMAP_STACKED (
    ___, ___,   ___,   ___,   ___,   ___,   ___,
    ___, Key_Q, Key_W, Key_E, Key_R, Key_T, ___,
    ___, Key_A, Key_S, Key_D, Key_F, Key_G,
    ___, Key_Z, Key_X, Key_C, Key_V, Key_B, ___,
    ___, ___, ___, ___,
    ___,

    ___,  ___,   ___,   ___,       ___,           ___,           ___,
    ___,  Key_Y, Key_U, Key_I,     Key_O,         Key_P,         Key_LeftBracket,
          Key_H, Key_J, Key_K,     Key_L,         Key_Semicolon, Key_Quote,
    ___,  Key_N, Key_M, Key_Comma, Key_Period,    Key_RightBracket,           ___,
    ___, ___, ___, ___,
    ___
  )
)
// *INDENT-ON*

static const kaleidoscope::ModifierLayers::overlay_t overlays[] = {
  // When either shift key is held, overlay the PDVORAK_NUMBERS layer if the
  // PDVORAK layer is active. Note that keys defined directly in the
  // PDVORAK_NUMBERS will not have the shift modifier applied to them.
  {LAYER_MODIFIER_KEY(Key_LeftShift) | LAYER_MODIFIER_KEY(Key_RightShift), PDVORAK, PDVORAK_DIGITS},
  // The last element must be an all-zero terminator
  {0, 0, 0}
};

const macro_t *macroAction(uint8_t macroIndex, uint8_t keyState) {
  switch (macroIndex) {
    case MACRO_SCREEN:
      // print screen
      return MACRODOWN(D(LeftGui), D(LeftShift), T(4), U(LeftShift), U(LeftGui));
    case MACRO_TOGGLE_LANG:
      // toggle os lang and switch between qwerty-workman
      return MACRODOWN(D(LeftControl), T(Spacebar), U(LeftControl), Tr(LockLayer(3)));
    }
  return MACRO_NONE;
}

void tapDanceAction(uint8_t tap_dance_index, byte row, byte col, uint8_t tap_count, kaleidoscope::TapDance::ActionType tap_dance_action) {
  switch (tap_dance_index) {
    case 0: return tapDanceActionKeys(tap_count, tap_dance_action, LSHIFT(Key_2), LSHIFT(Key_3), LSHIFT(Key_6));
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
  ModifierLayers,
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
  MouseKeys.accelSpeed = 5;
  MouseKeys.setSpeedLimit(100);
  // increase default timeout a bit to do double-tap
  TapDance.time_out = 300;
  // init layers modifier
  ModifierLayers.overlays = overlays;

  // one of default led's - rainbow
  LEDRainbowWaveEffect.brightness(150);
  // red haunt after press
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

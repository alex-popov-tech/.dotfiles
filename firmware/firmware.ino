// -*- mode: c++ -*-

#ifndef BUILD_INFORMATION
#define BUILD_INFORMATION "locally built"
#endif

#include "Kaleidoscope.h"
#include "Kaleidoscope-EEPROM-Settings.h"
#include "Kaleidoscope-EEPROM-Keymap.h"
#include "Kaleidoscope-FocusSerial.h"
#include "Kaleidoscope-OneShot.h"
#include "Kaleidoscope-Escape-OneShot.h"
#include "Kaleidoscope-Qukeys.h"
#include "Kaleidoscope-MouseKeys.h"
#include "Kaleidoscope-Macros.h"
#include "Kaleidoscope-LEDControl.h"
#include "Kaleidoscope-LED-ActiveModColor.h"
#include "Kaleidoscope-LEDEffect-BootGreeting.h"
#include "Kaleidoscope-LEDEffect-Breathe.h"
#include "Kaleidoscope-LEDEffect-Rainbow.h"
#include "Kaleidoscope-LED-Stalker.h"
#include "Kaleidoscope-Model01-TestMode.h"

enum { MACRO_SCREEN };

enum { COLEMAK, FUNC, QWERTY };

#define Key_Exclm         LSHIFT(Key_1)
#define Key_At            LSHIFT(Key_2)
#define Key_Hash          LSHIFT(Key_3)
#define Key_Dollar        LSHIFT(Key_4)
#define Key_Percent       LSHIFT(Key_5)
#define Key_Carret        LSHIFT(Key_6)
#define Key_And           LSHIFT(Key_7)
#define Key_Star          LSHIFT(Key_8)
#define Key_Plus          LSHIFT(Key_Equals)

#define Key_LRoundBracket LSHIFT(Key_9)
#define Key_RRoundBracket LSHIFT(Key_0)
#define Key_LCurlyBracket LSHIFT(Key_LeftBracket)
#define Key_RCurlyBracket LSHIFT(Key_RightBracket)
#define Key_LBracket      Key_LeftBracket
#define Key_RBracket      Key_RightBracket

#define Key_Question      LSHIFT(Key_Slash)
#define Key_Pipe          LSHIFT(Key_Backslash)

#define Key_MUp           Key_mouseUp
#define Key_MDown         Key_mouseDn
#define Key_MLeft         Key_mouseL
#define Key_MRight        Key_mouseR
#define Key_MSUp          Key_mouseScrollUp
#define Key_MSDown        Key_mouseScrollDn
#define Key_MSLeft        Key_mouseScrollL
#define Key_MSRight       Key_mouseScrollR
#define Key_LClick        Key_mouseBtnL
#define Key_RClick        Key_mouseBtnR

#define Key_LEDN          Key_LEDEffectNext

// *INDENT-OFF*
KEYMAPS(
  [COLEMAK] = KEYMAP_STACKED (
    Key_Backtick,      Key_Exclm, Key_At, Key_Hash, Key_Dollar, Key_Percent, XXX,
    Key_LCurlyBracket, Key_Q,     Key_W,  Key_F,    Key_P,      Key_G,       XXX,
    Key_Tab,           Key_A,     Key_R,  Key_S,    Key_T,      Key_D,
    XXX,               Key_Z,     Key_X,  Key_C,    Key_V,      Key_B,       Key_Semicolon,
    SFT_T(Enter), CTL_T(Backspace), OSM(LeftGui), OSM(LeftAlt),
    OSL(FUNC),

    XXX,        Key_Carret, Key_And, Key_Star,  Key_LRoundBracket, Key_RRoundBracket, XXX,
    XXX,        Key_J,      Key_L,   Key_U,     Key_Y,            Key_Quote,         Key_RCurlyBracket,
                Key_H,      Key_N,   Key_E,     Key_I,            Key_O,             Key_Minus,
    Key_Equals, Key_K,      Key_M,   Key_Comma, Key_Period,       Key_Question,      Key_Pipe,
    OSM(RightAlt), OSM(RightGui), CTL_T(Spacebar), SFT_T(Escape),
    OSL(QWERTY)
  ),
  [FUNC] = KEYMAP_STACKED (
    Key_F1, Key_F2,     Key_F3,     Key_F4,      Key_F5,     Key_F6,      Key_VolumeUp,
    XXX,    XXX,        Key_MSUp,   Key_MUp,     Key_MSDown, XXX,         Key_Mute,
    XXX,    Key_MSLeft, Key_MLeft,  Key_MDown,   Key_MRight, Key_MSRight,
    XXX,    XXX,        XXX,        XXX,         XXX,        XXX,         Key_VolumeDown,
    ___, ___, ___, ___,
    ___,

    Key_LEDN,        Key_F7,        Key_F8,         Key_F9,     Key_F10, Key_F11, Key_F12,
    M(MACRO_SCREEN), Key_DownArrow, Key_RightArrow, XXX,        XXX,     XXX,     XXX,
                     Key_LeftArrow, Key_LClick,     Key_RClick, XXX,     XXX,     XXX,
    XXX,             Key_UpArrow,   XXX,            XXX,        XXX,     XXX,     XXX,
    ___, ___, ___, ___,
    ___
  ),
  [QWERTY] = KEYMAP_STACKED (
    ___,          ___,   ___,   ___,   ___,   ___,   XXX,
    Key_Backtick, Key_Q, Key_W, Key_E, Key_R, Key_T, XXX,
    XXX,          Key_A, Key_S, Key_D, Key_F, Key_G,
    ___,          Key_Z, Key_X, Key_C, Key_V, Key_B, XXX,
    ___, ___, ___, ___,
    ___,

    XXX,  ___,   ___,   ___,       ___,        ___,              ___,
    XXX,  Key_Y, Key_U, Key_I,     Key_O,      Key_P,            Key_LeftBracket,
          Key_H, Key_J, Key_K,     Key_L,      Key_Semicolon,    Key_Quote,
    XXX,  Key_N, Key_M, Key_Comma, Key_Period, Key_RightBracket, XXX,
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
    /* case MACRO_TOGGLE_LANG: */
      /* toggle os lang and switch layer */
      /* return MACRODOWN(D(LeftControl), T(Spacebar), U(LeftControl), Tr(LockLayer(3))); */
    }
  return MACRO_NONE;
}

KALEIDOSCOPE_INIT_PLUGINS(
  EEPROMSettings,
  EEPROMKeymap,
  Focus,
  TestMode,

  LEDControl,
  BootGreetingEffect,
  ActiveModColorEffect,
  LEDRainbowWaveEffect,
  LEDBreatheEffect,
  StalkerEffect,

  Qukeys,
  OneShot,
  EscapeOneShot,
  Macros,
  MouseKeys
);

void setup() {
  Kaleidoscope.setup();

  // Make mouse start moving faster
  MouseKeys.accelSpeed = 5;
  MouseKeys.setSpeedLimit(100);

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

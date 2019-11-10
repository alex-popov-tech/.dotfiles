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
#include "Kaleidoscope-Colormap.h"
#include "Kaleidoscope-Syster.h"

#include "Kaleidoscope-OneShot.h"
#include "Kaleidoscope-Escape-OneShot.h"
#include "Kaleidoscope-Qukeys.h"
#include "Kaleidoscope-TopsyTurvy.h"
#include "Kaleidoscope-MouseKeys.h"
#include "Kaleidoscope-Macros.h"

enum { MACRO_SCREEN };

enum { COLEMAK, FUNC };

#define Key_Exclm         TOPSY(1)
#define Key_At            TOPSY(2)
#define Key_Hash          TOPSY(3)
#define Key_Dollar        TOPSY(4)
#define Key_Percent       TOPSY(5)
#define Key_Carret        TOPSY(6)
#define Key_And           TOPSY(7)
#define Key_Star          TOPSY(8)
#define Key_Plus          TOPSY(Equals)

#define Key_LRoundBracket TOPSY(9)
#define Key_RRoundBracket TOPSY(0)
#define Key_LCurlyBracket TOPSY(LeftBracket)
#define Key_RCurlyBracket TOPSY(RightBracket)
#define Key_LBracket      Key_LeftBracket
#define Key_RBracket      Key_RightBracket

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


// *INDENT-OFF*
KEYMAPS(
  [COLEMAK] = KEYMAP_STACKED (
    Key_Backtick,      Key_Exclm, Key_At, Key_Hash, Key_Dollar, Key_Percent, XXX,
    Key_LCurlyBracket, Key_Q,     Key_W,  Key_F,    Key_P,      Key_G,       XXX,
    Key_Tab,           Key_A,     Key_R,  Key_S,    Key_T,      Key_D,
    XXX,               Key_Z,     Key_X,  Key_C,    Key_V,      Key_B,       Key_Equals,
    SFT_T(Enter), CTL_T(Backspace), OSM(LeftGui), OSM(LeftAlt),
    ShiftToLayer(FUNC),

    XXX,           Key_Carret, Key_And, Key_Star,  Key_LRoundBracket, Key_RRoundBracket, XXX,
    XXX,           Key_J,      Key_L,   Key_U,     Key_Y,             Key_Quote,         Key_RCurlyBracket,
                   Key_H,      Key_N,   Key_E,     Key_I,             Key_O,             Key_Minus,
    Key_Semicolon, Key_K,      Key_M,   Key_Comma, Key_Period,        Key_Slash,         Key_Backslash,
    OSM(RightAlt), OSM(RightGui), CTL_T(Spacebar), SFT_T(Escape),
    Key_Spacebar
  ),
  [FUNC] = KEYMAP_STACKED (
    Key_F1, Key_F2,     Key_F3,     Key_F4,      Key_F5,     Key_F6,      Key_VolumeUp,
    XXX,    XXX,        Key_MSUp,   Key_MUp,     Key_MSDown, XXX,         Key_VolumeDown,
    XXX,    Key_RClick, Key_MLeft,  Key_MDown,   Key_MRight, Key_RClick,
    XXX,    XXX,        XXX,        XXX,         XXX,        XXX,         XXX,
    ___, ___, ___, ___,
    ___,

    Key_Mute,        Key_F7,        Key_F8,        Key_F9,      Key_F10,        Key_F11, Key_F12,
    M(MACRO_SCREEN), Key_LeftArrow, Key_DownArrow, Key_UpArrow, Key_RightArrow, XXX,     XXX,
                     Key_H,         Key_J,         Key_K,       Key_L,          XXX,     XXX,
    XXX,             XXX,           XXX,           XXX,         XXX,            XXX,     XXX,
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
  LEDControl,
  LEDOff,
  HostOS,
  EEPROMSettings,
  EEPROMKeymap,
  LEDPaletteTheme,
  ColormapEffect,

  Syster,
  Focus,

  Qukeys,
  TopsyTurvy,
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

  ColormapEffect.max_layers(3);
  ColormapEffect.activate();

  // To make the keymap editable without flashing new firmware, we store
  // additional layers in EEPROM. For now, we reserve space for five layers. If
  // one wants to use these layers, just set the default layer to one in EEPROM,
  // by using the `settings.defaultLayer` Focus command.
  EEPROMKeymap.setup(3, EEPROMKeymap.Mode::EXTEND);
}

void loop() {
  Kaleidoscope.loop();
}

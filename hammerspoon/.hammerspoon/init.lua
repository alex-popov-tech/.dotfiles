-- Switch to English (ABC) on F14
hs.hotkey.bind({}, "f14", function()
  hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
end)

-- Switch to Ukrainian on F15
hs.hotkey.bind({}, "f15", function()
  hs.keycodes.currentSourceID("com.apple.keylayout.Ukrainian-PC")
end)

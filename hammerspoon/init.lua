hs.window.animationDuration = 0
units = {
  right50       = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  left50        = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  maximum       = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 }
}

mash = { 'shift', 'ctrl', 'cmd' }
hs.hotkey.bind(mash, 'right', function() hs.window.focusedWindow():move(hs.layout.right50, nil, true) end)
hs.hotkey.bind(mash, 'left', function() hs.window.focusedWindow():move(hs.layout.left50, nil, true) end)
hs.hotkey.bind(mash, 'up', function() hs.window.focusedWindow():move(hs.layout.maximized, nil, true) end)

layouts = {
  work = {
    { name = 'Firefox',           app = 'Firefox.app',            unit = hs.layout.maximized,  screen = 'Color LCD' },
    { name = 'iTerm2',            app = 'iTerm.app',              unit = hs.layout.maximized, screen = 'Color LCD' },
    { name = 'Slack',             app = 'Slack.app',              unit = hs.layout.maximized,   screen = 'Color LCD' },
    { name = 'WhatsApp',          app = 'WhatsApp.app',           unit = hs.layout.maximized,  screen = 'Color LCD' },
    { name = 'Visual Studio Code',app = 'Visual Studio Code.app', unit = hs.layout.maximized, screen = 'U28E590' }
  },
  home = {
    { name = 'Firefox',           app = 'Firefox.app',           unit = hs.layout.maximized,  screen = 'Color LCD' },
    { name = 'iTerm2',            app = 'iTerm.app',             unit = hs.layout.maximized, screen = 'Color LCD' },
    { name = 'Slack',             app = 'Slack.app',             unit = hs.layout.maximized,   screen = 'Color LCD' },
    { name = 'WhatsApp',          app = 'WhatsApp.app',          unit = hs.layout.maximized,  screen = 'Color LCD' },
    { name = 'Visual Studio Code',app = 'Visual Studio Code.app', unit = hs.layout.maximized, screen = 'Color LCD' }
  },
}

-- Tells me whether or not the machine running Hammerspoon is
-- my work machine or not
function isWorkMachine()
  local allNames = hs.host.names()
  for i=1,#allNames do
    if allNames[i]:match('bulb') or allNames[i]:match('BULB') then
      return true
    end
  end
  return false
end

-- Takes a layout definition (e.g. 'layouts.work') and iterates through
-- each application definition, laying it out as speccified
function runLayout(layout)
  -- local screens = hs.screen.allScreens()
  -- print(screens)
  -- for i=1,#screens do
  --   print("----")
  --   print(screens[i])
  -- end

  for i = 1,#layout do
    local t = layout[i]
    local theapp = hs.application.get(t.name)
    if win == nil then
      hs.application.open(t.app)
      theapp = hs.application.get(t.name)
    end
    local win = theapp:mainWindow()
    local screen = nil
    if t.screen ~= nil then
      screen = hs.screen.find(t.screen)
    end
    win:move(t.unit, screen, true)
  end
end

-- The goal here is to bind mash+0 and mash+9 to the grander layouts
-- but there's a quick difference depending on whether or not I happen
-- to be on my work machine or not
if isWorkMachine() then
  hs.hotkey.bind(mash, '0', function() runLayout(layouts.work) end)
else
  hs.hotkey.bind(mash, '0', function() runLayout(layouts.home) end)
end

-- We need to store the reference to the alert window
appLauncherAlertWindow = nil

-- This is the key mode handle
launchMode = hs.hotkey.modal.new({}, nil, '')

-- Leaves the launch mode, returning the keyboard to its normal
-- state, and closes the alert window, if it's showing
function leaveMode()
  if appLauncherAlertWindow ~= nil then
    hs.alert.closeSpecific(appLauncherAlertWindow, 0)
    appLauncherAlertWindow = nil
  end
  launchMode:exit()
end

-- So simple, so awesome.
function switchToApp(app)
  hs.application.open(app)
  leaveMode()
end

-- Enters launch mode. The bulk of this is geared toward
-- showing a big ugly window that can't be ignored; the
-- keyboard is now in launch mode.
hs.hotkey.bind({ 'ctrl' }, 'space', function()
  launchMode:enter()
  appLauncherAlertWindow = hs.alert.show('App Launcher Mode', {
    strokeColor = hs.drawing.color.x11.orangered,
    fillColor = hs.drawing.color.x11.cyan,
    textColor = hs.drawing.color.x11.black,
    strokeWidth = 20,
    radius = 30,
    textSize = 100,
    fadeInDuration = 0,
    atScreenEdge = 2
  }, 'infinite')
end)

-- When in launch mode, hitting ctrl+space again leaves it
launchMode:bind({ 'ctrl' }, 'space', function() leaveMode() end)

-- Mapped keys
launchMode:bind({}, 'c',  function() switchToApp('Visual Studio Code.app') end)
launchMode:bind({}, 'f',  function() switchToApp('Firefox.app') end)
launchMode:bind({}, 'i',  function() switchToApp('iTerm.app') end)
launchMode:bind({}, 'm',  function() switchToApp('Mail.app') end)
launchMode:bind({}, 'p',  function() switchToApp('Postman.app') end)
launchMode:bind({}, 's',  function() switchToApp('Slack.app') end)
launchMode:bind({}, 't',  function() switchToApp('TablePlus.app') end)
launchMode:bind({}, 'w',  function() switchToApp('WhatsApp.app') end)

-- Unmapped keys
launchMode:bind({}, 'a',  function() leaveMode() end)
launchMode:bind({}, 'b',  function() leaveMode() end)
launchMode:bind({}, 'd',  function() leaveMode() end)
launchMode:bind({}, 'e',  function() leaveMode() end)
launchMode:bind({}, 'g',  function() leaveMode() end)
launchMode:bind({}, 'h',  function() leaveMode() end)
launchMode:bind({}, 'j',  function() leaveMode() end)
launchMode:bind({}, 'k',  function() leaveMode() end)
launchMode:bind({}, 'l',  function() leaveMode() end)
launchMode:bind({}, 'n',  function() leaveMode() end)
launchMode:bind({}, 'o',  function() leaveMode() end)
launchMode:bind({}, 'q',  function() leaveMode() end)
launchMode:bind({}, 'r',  function() leaveMode() end)
launchMode:bind({}, 'u',  function() leaveMode() end)
launchMode:bind({}, 'v',  function() leaveMode() end)
launchMode:bind({}, 'x',  function() leaveMode() end)
launchMode:bind({}, 'y',  function() leaveMode() end)
launchMode:bind({}, 'z',  function() leaveMode() end)

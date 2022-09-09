-- CONFIG RELOAD
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()

-- INSTALL HYPER KEY
local hyper = require('hyper')
hyper.install('F18')

-- WIN MANAGEMENT
hs.loadSpoon("WinWin")
hs.window.animationDuration = 0

-- move left, right, up, down
hyper.bindShiftKey("H", function() 
	spoon.WinWin:moveAndResize("halfleft")
end)
hyper.bindShiftKey("K", function() 
	spoon.WinWin:moveAndResize("halfup")
end)
hyper.bindShiftKey("J", function() 
	spoon.WinWin:moveAndResize("halfdown")
end)
hyper.bindShiftKey("L", function() 
	spoon.WinWin:moveAndResize("halfright")
end)

-- 4x4 grid
hyper.bindKey("1", function() 
	spoon.WinWin:moveAndResize("cornerNW")
end)
hyper.bindKey("2", function() 
	spoon.WinWin:moveAndResize("cornerNE")
end)
hyper.bindKey("3", function() 
	spoon.WinWin:moveAndResize("cornerSW")
end)
hyper.bindKey("4", function() 
	spoon.WinWin:moveAndResize("cornerSE")
end)

-- resizing
hyper.bindCommandShiftKey("H", function()
    spoon.WinWin:stepResize("left")
end)
hyper.bindCommandShiftKey("L", function()
    spoon.WinWin:stepResize("right")
end)
hyper.bindCommandShiftKey("J", function()
    spoon.WinWin:stepResize("down")
end)
hyper.bindCommandShiftKey("K", function()
    spoon.WinWin:stepResize("up")
end)

-- moving to another screen
hyper.bindKey("B", function()
	local win = hs.window.focusedWindow();
	win:moveToScreen(win:screen():next())
end)

-- maximize
hyper.bindKey("M", function()
  local win = hs.window.focusedWindow();
  win:maximize()
end)

local applicationHotkeys = {
  u = 'WhatsApp',
  v = 'Visual Studio Code',
  w = 'Google Chrome',
  s = 'Slack',
  e = 'Mail',
  f = 'Finder',
  l = 'Spotify',
  n = 'Notes',
  c = 'Calendar',
  i = 'Simulator',
  t = "Typora",
}

for key, app in pairs(applicationHotkeys) do
  hyper.bindKey(key, function()
	  hs.application.launchOrFocus(app)
  end)
end
hyper.bindKey('return', function() hs.application.launchOrFocus('iTerm') end)

-- SLEEP and LOCK 
hyper.bindShiftKey("S", function() hs.caffeinate.systemSleep() end)

-- MUTE ON WAKE
function muteOnWake(eventType)
  if (eventType == hs.caffeinate.watcher.systemDidWake) then
    local output = hs.audiodevice.defaultOutputDevice()
    output:setMuted(true)
  end
end
caffeinateWatcher = hs.caffeinate.watcher.new(muteOnWake)
caffeinateWatcher:start()

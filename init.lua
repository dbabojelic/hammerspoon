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

-- focus left, right, up, down
-- does not work as expected
--
-- hyper.bindKey("H", function() 
-- 	hs.window.filter.focusWest()
-- end)
-- hyper.bindKey("K", function() 
-- 	hs.window.filter.focusNorth()
-- end)
-- hyper.bindKey("J", function() 
-- 	hs.window.filter.focusSouth()
-- end)
-- hyper.bindKey("L", function() 
-- 	hs.window.filter.focusEast()
-- end)

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

-- fullscreen
-- hyper.bindKey("F", function()
--   local win = hs.window.focusedWindow();
--   win:toggleFullScreen()
-- end)


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



-- APPLICATION CHOOSER

-- in progress
-- myLaunchOrFocus = function(appName) 
-- 	local win = hs.window.focusedWindow();
-- 	local app = win:application();

-- 	hs.notify.new({title="appName!", informativeText=appName}):send()
-- 	hs.notify.new({title="app:name!", informativeText=app:name()}):send()
-- 	if app:name() == appName then
-- 		local wf = hs.window.filter
-- 		wf_app = wf.new{app:name()}
-- 		wins = wf_app:getWindows(hs.window.filter.sortByFocused)
-- 		wins[2]:focus()
-- 		hs.notify.new({title="OK!", informativeText=wins[1]:title()}):send()
-- 	else
-- 		hs.notify.new({title="NOT OK!", informativeText="bla"}):send()
-- 		if appName ~= "iTerm2" then
-- 			hs.application.launchOrFocus(appName)
-- 		else
-- 			hs.application.launchOrFocus("iTerm")
-- 		end
-- 	end
-- end

-- moras bas stavit puna imena, prava imena
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
	  --myLaunchOrFocus(app)
  end)
end
hyper.bindKey('return', function() hs.application.launchOrFocus('iTerm') end)

-- SLEEP and LOCK 
hyper.bindShiftKey("S", function() hs.caffeinate.systemSleep() end)
hyper.bindShiftKey("9", function() hs.caffeinate.lockScreen() end)

-- MUTE ON WAKE
function muteOnWake(eventType)
  if (eventType == hs.caffeinate.watcher.systemDidWake) then
    local output = hs.audiodevice.defaultOutputDevice()
    output:setMuted(true)
  end
end
caffeinateWatcher = hs.caffeinate.watcher.new(muteOnWake)
caffeinateWatcher:start()

-- MOVE BETWEEN SPACES
require('spaces')
hyper.bindShiftKey("left", function() moveWindowOneSpace("left", true) end)
hyper.bindShiftKey("right", function() moveWindowOneSpace("right", true) end)


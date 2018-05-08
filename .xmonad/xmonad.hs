import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Util.Scratchpad
import XMonad.Util.NamedScratchpad
import XMonad.Hooks.ManageDocks
import XMonad.Layout.ResizableTile
import qualified XMonad.StackSet as W
import qualified Data.Map as M

main = xmonad (defaultConfig
	{ terminal    = "sakura"
	, modMask     = mod4Mask
	, startupHook = do
		spawn "bash ~/.xinitrc"
		spawn "syndaemon -t -k -i 1 -d &"
		spawn "redshift -l 39.9167:116.3833 &"
		spawn "/usr/lib/notification-daemon-1.0/notification-daemon &"
	} `additionalKeysP` myKeysP `additionalKeys` myKeys)

myKeysP =
	[ ("M-o", spawn "xscreensaver-command -lock")
	, ("M-c", spawn "google-chrome-stable")
	, ("M-f", spawn "firefox")
	, ("M-u", spawn "amixer -q sset Master 2%+")
	, ("M-d", spawn "amixer -q sset Master 2%-")
	, ("M-m", spawn "amixer set Master toggle")
	, ("M-s", spawn "~/bin/screenshot")
	, ("M-a", spawn "~/bin/screenshot-edit")
	] 


myKeys =
	[ ((0, 0x1008ff02), spawn "xbacklight -inc 3")
	, ((0, 0x1008ff03), spawn "xbacklight -dec 3")
	]

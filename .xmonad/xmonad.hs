--Imports
--
--Xmonad
import XMonad
--System
import System.Exit
import System.IO
--Utilities
import qualified Data.Map as M
import qualified XMonad.StackSet as W
import Data.Ratio ((%))
import XMonad.Util.Font
--Prompts
import XMonad.Prompt
import XMonad.Prompt.Shell
--Layouts
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.NoBorders(smartBorders)
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile
--Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook

--Keys
--
defKeys = keys defaultConfig
delKeys x = foldr M.delete (defKeys x) (toRemove x)
myKeys x = foldr (uncurry M.insert) (delKeys x) (toAdd x)
--Remove some of the default key bindings
toRemove XConfig {modMask = modm} =
    [ (modm, xK_q)
    --, (etc.)
    ]
--Add more key bindings
toAdd XConfig {modMask = modm} =
    --Prompt
    [ ((modm, xK_p), shellPrompt myXPConfig)
    --ResizableTile expand and shrink
    , ((modm, xK_a), sendMessage MirrorShrink)
    , ((modm, xK_z), sendMessage MirrorExpand)
    --BSP controls
    , ((modm .|. controlMask, xK_l), sendMessage $ ExpandTowards R)
    , ((modm .|. controlMask, xK_h), sendMessage $ ExpandTowards L)
    , ((modm .|. controlMask, xK_j), sendMessage $ ExpandTowards D)
    , ((modm .|. controlMask, xK_k), sendMessage $ ExpandTowards U)
    , ((modm, xK_r), sendMessage Rotate)
    , ((modm, xK_s), sendMessage Swap)
    --Volume controls
    , ((0, 0x1008ff12), spawn "pactl -- set-sink-mute 1 toggle")
    , ((0, 0x1008ff11), spawn "pactl -- set-sink-volume 1 -5%")
    , ((0, 0x1008ff13), spawn "pactl -- set-sink-volume 1 +5%")
    ]
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

--Prompt
--
myXPConfig :: XPConfig
myXPConfig = defaultXPConfig
    { font = "xft:Terminus:bold:size=14"
    , position = Top
    , bgColor = "black"
    , fgColor = "grey"
    , bgHLight = "black"
    , fgHLight = "green"
    , borderColor = "green"
    , promptBorderWidth = 0
    , height = 22
    , historyFilter = deleteConsecutive
    }

--Layout
--
myLayout =
    (renamed [Replace "Tree"] $ emptyBSP) |||
    (renamed [Replace "Tile"] $ ResizableTall 1 (3/100) (1/2) []) |||
    (Full)

--Startup
myStartupHook = do
    --Stuff
    setWMName "LG3D"
    spawn "setxkbmap -option ctrl:nocaps -option terminate:ctrl_alt_bksp"
    --Display and appearance
    spawn "feh --no-fehbg --bg-fill ~/.xmonad/wallpaper*"
    spawn "xsetroot -cursor_name left_ptr"
    spawn "(xset -b) && (xset s 3600) && (xset dpms 7200 7200 7200)"
    spawn "xrdb -merge ~/.Xresources"
    --Music
    spawn "mpd"

--Main
--
main = xmonad =<< statusBar "xmobar ~/.xmonad/xmobar.hs" xmobarPP toggleStrutsKey
    (ewmh $ defaultConfig
        --Appearance
        { borderWidth = 1
        , normalBorderColor = "darkgrey"
        , focusedBorderColor = "red"
        --Keys
        , terminal = "urxvt"
        , modMask = mod4Mask
        , keys = myKeys
        --Hooks
        , layoutHook = avoidStruts $ myLayout
        , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
        , startupHook = myStartupHook
        })

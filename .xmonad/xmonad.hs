--Imports
--
--XMonad
import XMonad
import qualified XMonad.StackSet as W
--System
import System.Exit
import System.IO
--Data
import qualified Data.Map as M
import Data.Ratio ((%))
--Util
import XMonad.Util.Font
import XMonad.Util.Cursor
--Prompt
import XMonad.Prompt
import XMonad.Prompt.RunOrRaise
import XMonad.Prompt.Shell
import XMonad.Prompt.Ssh
--Layout
import XMonad.Layout.BinarySpacePartition
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
    --, (etc., etc.)
    ]
--Add more key bindings
toAdd XConfig {modMask = modm} =
    --Prompt
    [ ((modm, xK_p), shellPrompt myXPConfig)
    , ((modm .|. shiftMask, xK_p), runOrRaisePrompt myXPConfig)
    , ((modm .|. controlMask, xK_p), sshPrompt myXPConfig)
    --Tile/ResizableTile expand and shrink
    , ((modm, xK_a), sendMessage MirrorShrink)
    , ((modm, xK_z), sendMessage MirrorExpand)
    --Tree/BSP controls
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
myLayout = avoidStruts $
    (renamed [Replace "Tile"] $ ResizableTall 1 (3/100) (1/2) []) |||
    (renamed [Replace "Tree"] $ emptyBSP) |||
    (Full)

--Startup
myStartupHook = do
    setWMName "LG3D"
    setDefaultCursor xC_left_ptr
    spawn "feh --no-fehbg --bg-fill ~/.xmonad/wallpaper*"
    spawn "urxvtd -q -o -f"

--Config
--
myConfig = ewmh $ defaultConfig
    --Appearance
    { borderWidth = 1
    , normalBorderColor = "grey40"
    , focusedBorderColor = "red"
    --Keys
    , terminal = "urxvtc"
    , modMask = mod4Mask
    , keys = myKeys
    --Hooks
    , startupHook = myStartupHook
    , layoutHook = myLayout
    , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
    }

--Main
--
main = xmonad =<< statusBar "xmobar ~/.xmonad/xmobar.hs" xmobarPP toggleStrutsKey myConfig

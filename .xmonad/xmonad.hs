--Imports
--
--Xmonad
import XMonad
--System
import System.Exit
import System.IO
--Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
--Layouts
import XMonad.Layout.NoBorders(smartBorders)
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Renamed
import XMonad.Layout.ResizableTile
import XMonad.Layout.BinarySpacePartition
import Data.Ratio ((%))
--Other utilities
import qualified XMonad.StackSet as W
import qualified Data.Map as M

--Keys
--
newKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList
             --Dmenu2 (compiled from source, not in Ubuntu repos)
             [ ((modm, xK_p), spawn "dmenu_run -y 2 -fn 'Terminus-12:bold' -nb '#000000' -nf '#ABABAB' -sb '#000000' -sf '#F0F0F0'")
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
myKeys x  = newKeys x `M.union` keys defaultConfig x

--Layout
--
myLayout =  (renamed [Replace "BSP"] $ emptyBSP) ||| (renamed [Replace "Tile"] $ ResizableTall 1 (3/100) (1/2) []) |||Full

--Config
--
myConfig = ewmh $ defaultConfig
           { terminal = "urxvt"
           , normalBorderColor = "#333333"
           , focusedBorderColor = "#DD4814"
           , modMask = mod4Mask
           , keys = myKeys
           , layoutHook = avoidStruts $ myLayout
           , borderWidth = 1
           , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
           , startupHook = do
                           setWMName "LG3D"
                           spawn "compton -b"
                           spawn "nautilus -n"
           }

--Main
--
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)
main = xmonad =<< statusBar "xmobar" xmobarPP toggleStrutsKey myConfig

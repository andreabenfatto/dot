import XMonad
import System.IO
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.Fullscreen
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Spiral
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Util.SpawnOnce
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import XMonad.Prompt
import XMonad.Prompt.Window
import Data.List

--baseConfig = desktopConfig

yaganesh = "$(yeganesh -x -- -fn \"xft:Dejavu Sans:size=9:antialias=true\")"


myModMask = mod4Mask

myLayout = avoidStruts (
  Grid |||
  ThreeColMid 1 (3/100) (1/2) |||
  Tall 1 (3/100) (1/2) |||
  Mirror (Tall 1 (3/100) (1/2)) |||
  simpleTabbed |||
  spiral (6/7)) |||
  noBorders (fullscreenFull Full)


-- The command to lock the screen or show the screensaver.
myScreensaver = "xscreensaver-command -activate"

myKeys = [ ((myModMask, xK_b), sendMessage ToggleStruts)
           ,((myModMask, xK_p), spawn yaganesh)
           ,((myModMask, xK_f), windowPromptGoto defaultXPConfig {font = "xft:Dejavu Sans:size=9:antialias=true", height = fromIntegral 35, searchPredicate = isInfixOf, autoComplete = Just 100000})
           ,((myModMask, xK_s), spawn myScreensaver)]
------------------------------------------------------------------------
-- Run xmonad with all the defaults we set up.
--
main = do
  xmproc <- spawnPipe "xmobar ~/.xmonad/xmobarrc"
  spawn "xbindkeys"
  spawn "xscreensaver"
  spawn "$HOME/.screenlayout/autorandr.sh"
  xmonad $ baseConfig {
      terminal = "terminator"
      ,modMask = myModMask
      ,logHook = dynamicLogWithPP $ xmobarPP {
            ppOutput = hPutStrLn xmproc
          , ppTitle = xmobarColor "#97C5FF" "" . shorten 50
          , ppCurrent = xmobarColor "#1D995A" ""
          , ppSep = "   "
      } 
      , manageHook = manageDocks <+> manageHook defaultConfig
      , startupHook = setWMName "LG3D"
  } `additionalKeys` myKeys

baseConfig = defaultConfig {
  layoutHook = avoidStruts $ smartBorders $ myLayout 
}

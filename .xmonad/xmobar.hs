Config
    { font = "xft:Terminus:bold:size=14"
    , bgColor = "black"
    , fgColor = "grey"
    , position = Top
    , sepChar = "%"
    , alignSep = "}{"
    , template = " %StdinReader% }{ %wlp2s0wi% : %battery% : %date% "
    , lowerOnStart = True
    , hideOnStart = False
    , allDesktops = True
    , overrideRedirect = True
    , pickBroadest = False
    , persistent = True
    , commands =
        [ Run StdinReader
        , Run Battery
            [ "--template", "<acstatus>"
            , "--Low", "20"
            , "--High", "50"
            , "--low", "red"
            , "--normal", "yellow"
            , "--high", "green"
            , "--"
            , "-o", "<left>%"
            , "-O", "Charging"
            , "-i", "Charged"
            ] 50
        , Run Wireless "wlp2s0" ["--template", "<essid>"] 50
        , Run Date "%F %H:%M" "date" 50
        ]
    }

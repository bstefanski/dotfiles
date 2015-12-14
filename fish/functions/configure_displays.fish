function configure_displays
    set -l scr1
    set -l scr2
    set -l scr3
    set -l scrs eDP1 DP1 DP2 HDMI1 HDMI2 VIRTUAL1

    if test (count $argv) = 1
        set -l enabled --output $argv[1] --auto --primary
        set -l disabled
        for s in $scrs
            if not test $argv[1] = $s
                set disabled $disabled --output $s --off
            end
        end
        xrandr $enabled $disabled
        killall plank >/dev/null 2>&1
        nohup /usr/bin/plank >/dev/null 2>&1 &
        xfconf-query -c xfce4-panel -p /panels/panel-0/output-name -s $argv[1]
    else if test (count $argv) = 2
        set -l enabled --output $argv[1] --auto --output $argv[2] --auto --primary --right-of $argv[1]
        set -l disabled
        for s in $scrs
            if not test $argv[1] = $s -o $argv[2] = $s
                set disabled $disabled --output $s --off
            end
        end
        xrandr $enabled $disabled
        killall plank >/dev/null 2>&1
        nohup /usr/bin/plank >/dev/null 2>&1 &
        xfconf-query -c xfce4-panel -p /panels/panel-0/output-name -s $argv[2]
    else
        set -l enabled --output $argv[1] --auto --left-of $argv[2] --output $argv[2] --auto --primary --output $argv[3] --auto --right-of $argv[2]
        set -l disabled
        for s in $scrs
            if not test $argv[1] = $s -o $argv[2] = $s -o $argv[3] = $s
                set disabled $disabled --output $s --off
            end
        end
        xrandr $enabled $disabled
        killall plank >/dev/null 2>&1
        nohup /usr/bin/plank >/dev/null 2>&1 &
        xfconf-query -c xfce4-panel -p /panels/panel-0/output-name -s $argv[2]
    end
    setxkbmap -option caps:escape
end

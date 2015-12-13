function configure_displays
    set -l scr1
    set -l scr2
    set -l scr3
    set -l scrs DP1 VGA1 LVDS1

    if test (count $argv) = 1
        set -l enabled --output $argv[1] --auto --primary
        set -l disabled
        for s in $scrs
            if not test $argv[1] = $s
                set disabled $disabled --output $s --off
            end
        end
        xrandr $enabled $disabled
    else
        set -l enabled --output $argv[1] --auto --primary --output $argv[2] --auto --right-of $argv[1]
        set -l disabled
        for s in $scrs
            if not test $argv[1] = $s -o $argv[2] = $s
                set disabled $disabled --output $s --off
            end
        end
        xrandr $enabled $disabled
    end
end

#!/usr/bin/env python

# VIKTOR - look here: https://developer.apple.com/documentation/coregraphics/quartz_window_services/window_list_option_constants
# we want all the windows, not just the visible ones!!


def getAllTitles():
    """Returns a list of strings of window titles for all visible windows.
    """

    # Source: https://stackoverflow.com/questions/53237278/obtain-list-of-all-window-titles-on-macos-from-a-python-script/53985082#53985082
    windows = Quartz.CGWindowListCopyWindowInfo(Quartz.kCGWindowListExcludeDesktopElements | Quartz.kCGWindowListOptionOnScreenOnly, Quartz.kCGNullWindowID)
    return['%s %s' % (win[Quartz.kCGWindowOwnerName], win.get(Quartz.kCGWindowName, '')) for win in windows] 



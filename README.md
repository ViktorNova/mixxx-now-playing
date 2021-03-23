# mixxx-now-playing

Little script to help OBS display the currently playing track from Mixxx (or your preferred alternative player)

This script takes the Artist - Title of the currently playing song in the player and writes it to a text file. This is accomplished by reading the window title of the application and reformatting it a bit, which updates every time the crossfader goes towards a playing deck. All Unicode characters are supported (be sure to choose a font in OBS that supports Unicode if you play songs with non-english characters)

## Installation

Just have your OS launch this script upon login - it will check once a minute to see if the player is running. When it is, it will update the text file (which saves to ~/mixxx-now-playing.txt by default) once every 5 seconds based on the currently playing track. If decks stop playing, the text file will be blanked out until a track starts playing again.

The same script will work on Linux or MacOS.
You will need to have `ascii2uni` installed, and Linux users will also need xdotool:

To install ascii2uni and xdotool it on Linux (Ubuntu/Debian):

```
sudo apt install ascii2uni xdotool
```

To install ascii2uni on MacOS via Homebrew:

```
brew install ascii2uni
```

## Windows Notes

First, get yourself [Windows Terminal](https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701) and [Cmder](https://cmder.net/), then follow these instructions to set them up: [Windows Terminal + Cmder = ❤️](https://medium.com/talpor/windows-terminal-cmder-%EF%B8%8F-573e6890d143).

This might be overkill, but there are so many good things incuded.

Having set these up, start Cmder and run Bash, then run the `mixxx-now-playing.sh` script.

## Customization Tips

There are a few customization values at the top of the script. Not using Mixxx? Just change the PROCNAME and TITLEPATTERN values to match your preferred player. You can also change TXTFILE to an alternate output path.

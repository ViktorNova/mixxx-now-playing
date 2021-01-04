# mixxx-now-playing
Little script to help OBS display the currently playing track from Mixxx (Linux & Mac only)

This script takes the Artist - Title of the currently playing song in Mixxx and writes it to a text file. This is accomplished by reading the window title of Mixxx and reformatting it a bit, which updates every time the crossfader goes towards a playing deck.

## Installation
Just have your OS launch this script upon login - it will check once a minute to see if Mixxx is running. When Mixxx is running, it will update the text file once every 5 seconds based on the currently playing track. If decks stop playing, the text file will be blanked out until a track starts playing again. 

The same script will work on Linux or Mac.
On Linux, you need to have xdotool installed. 
On Mac, no external dependencies are used (Python + Quartz)

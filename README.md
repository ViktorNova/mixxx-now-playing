# mixxx-now-playing
Little script to help OBS display the currently playing track from Mixxx (Linux & Mac only)

This script takes the Artist - Title and Year of the currently playing song in Mixxx and writes it to a text file. This is accomplished by querying the sqlite3 db of Mixxx and reformatting it a bit, which updates every time the crossfader goes towards a playing deck. All Unicode characters are supported (be sure to choose a font in OBS that supports Unicode if you play songs with non-english characters)

## Installation
Update the db path if necessary and then have your OS launch this script upon login - it will check once a minute to see if Mixxx is running. When Mixxx is running, it will update the text file (which saves to ~/mixxx-now-playing.txt by default) once every 5 seconds based on the currently playing track. If decks stop playing, the text file will be blanked out until a track starts playing again. 


````


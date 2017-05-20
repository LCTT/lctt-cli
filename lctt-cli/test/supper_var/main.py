import settings
import subfile
#
settings.init()          # Call only once
subfile.stuff()         # Do stuff with global var
print(settings.myList[0]) # Check the result

extends Node

#literally just holds all custom signals
#when the player exits the bad ending
signal bad_ending
# when the player exits the good ending
signal good_ending
# when the player just wants to return to the menu
signal exit_request
# when the player just wants to open settings
signal settings_request

# when the end of the wife interaction happens 
# (collecting the last piece of memorbillia)
signal finished_wife_car

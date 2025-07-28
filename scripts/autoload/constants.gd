extends Node

# Dictates whether the metronome is playing
enum PlaybackState {PLAYING, PAUSED, STOPPED}

# Used to indicate dynamic to play at a level
enum Dynamics      {LOUD, NORMAL, QUIET, SILENT}
enum BeatStrength  {DOWNBEAT, UPBEAT}

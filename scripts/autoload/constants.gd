extends Node

# Dictates whether the metronome is playing
enum PlaybackState {PLAYING, PAUSED, STOPPED}

# Orchestrator Constants
# Generation Mode: Dictates when the orchestrator generates a new bar. These are handled by signals.
#     - ROLLING: New rows are generated as rows are processed.
#	  - TIME: Generate new bars as time has past
#     - BAR: Generate new bars as certain number of bars has past
enum OrchestratorGenerationEvent {ROLLING, TIME, BAR}

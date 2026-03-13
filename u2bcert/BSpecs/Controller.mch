MACHINE
	Controller
INCLUDES Timer
SETS
	State = { AlarmRinging , CountingDown , EdHour , EdMinute , Normal }
DEFINITIONS
	C2 == (seconds = 0 & minutes = 0 & hours = 0);
	C1 == (not(C2));
	Configuration == { Normal } \/ Edition ;
	Edition == { EdMinute , EdHour }
VARIABLES
	state
INVARIANT
	state : State
	&(ring = 1 => C2)/*endinv*/
	&((state = AlarmRinging) <=> (ring = 1))/*endinv*/
INITIALISATION
	state := Normal
OPERATIONS
alarm =
	SELECT state = CountingDown & C2 THEN state := AlarmRinging || setRing
	END ;
decr =
	SELECT state = CountingDown & C1 THEN state := CountingDown || update
	END ;
mode =
	SELECT state = EdMinute THEN state := EdHour
	WHEN state = EdHour THEN state := Normal
	WHEN state = Normal THEN state := EdMinute
	END ;
incr =
	SELECT state = EdHour THEN state := EdHour || setHr
	WHEN state = EdMinute THEN state := EdMinute || setMn
	END ;
on_off =
	SELECT state = CountingDown THEN state := Normal
	WHEN state = AlarmRinging THEN state := Normal || setRing
	WHEN state : Configuration & C1 THEN state := CountingDown
	END
END

/* Timer
 * Author: 
 * Creation date: 16/12/2025
 */
MACHINE
    Timer
VARIABLES
    seconds, minutes, hours, ring 
INVARIANT
    seconds : 0..59
    & minutes : 0..59
    & hours : 0..23
    & ring : 0..1
INITIALISATION
    seconds, minutes, hours, ring := 0,0,0,0
OPERATIONS
reset = 
    BEGIN
        seconds, minutes, hours, ring := 0,0,0,0
    END;
setMn =
  BEGIN
      minutes := (minutes + 1) mod 60 
  END;
setHr =
  BEGIN
      hours := (hours + 1) mod 24
  END;
update =
  BEGIN
      seconds := (seconds + 59) mod 60 ||
      minutes := (minutes + 59 * ((60 - seconds) / 60)) mod 60 ||
      hours   := (hours + 23 * ((60 - minutes) / 60) * ((60 - seconds) / 60)) mod 24
  END;
setRing = 
    BEGIN
        ring := 1 - ring
    END

END

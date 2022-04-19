#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


;^1::
;	d := "7/15/2009"
;	baseDate := TextToTimestamp(d)
;
;	baseDate += 7, Days
;	Send %baseDate%
;	FormatTime, displayDate, %baseDate%, MM/dd/yyyy
;	MsgBox, % displayDate
;
;  Return

; creates a timestamp string from a date
TextToTimestamp(inText) {
	debugScript := 0
	DefaultTimestamp := "19700101000000"
	YYYY := "1970"
	MM := "01"
	DD := "01"
	HH := "00"
	MI := "00"
	SS := "00"

	if (RegExMatch(inText, "^\d{1,2}/\d{1,2}/(\d{2}|\d{4})$")) { ; 08/26/2019, 8/4/2019
		parts := StrSplit(inText, "/")
		DD := Right("0" . parts[2], 2)
		MM := Right("0" . parts[1], 2)
		YYYY := Right("20" . parts[3], 4)
		if (debugScript = 1) {
			MsgBox, MM/DD/YYYY pattern: DD = %DD% / MM = %MM% / YYYY = %YYYY%
		}
	}


	if (MM < 1 || MM > 12 || DD < 1 || DD > 31 ) { ; 31 day months
		return debugScript = 1 ? "Bad Month or Day" : DefaultTimestamp
	}

	if (MM = 2 && ((Mod(YYYY, 4) = 0 && DD > 29) || (Mod(YYYY, 4) != 0 && DD > 28))) { ; february
		return debugScript = 1 ? "Bad February Date" : DefaultTimestamp
	}

	if ((MM = 4 || MM = 6 || MM = 9 || MM = 11) && DD > 30) { ; 30 day months
		return debugScript = 1 ? "Bad 30-Day Month" : DefaultTimestamp
	}

	
	if (debug = 1) {
		return "bottom: " . YYYY . MM . DD . HH . MI . SS
	}
	else {
		return YYYY . MM . DD . HH . MI . SS
	}
}

Right(inString, returnLength) {
	inStringLength := StrLen(inString)

	if (inStringLength <= returnLength) {
		return inString
	}
	
	return SubStr(inString, inStringLength - returnLength + 1)
}






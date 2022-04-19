

; the controls are a little different when handbrake is running 
; set to 1 if handbrake is actively ripping a title
handbrakeIsRunning := 1

episodeNumber := 2
#include DateParse.ahk

; ! Alt
; + Shift
; ^ Ctrl
; # Win

; ctrl-insert --> ctrl-print screen
^Insert::Send {Ctrl down}{PrintScreen}{Ctrl up}

; turn monitors off
#m::
Sleep 1000
SendMessage, 0x112, 0xF170, 2,, Program Manager
; Sleep 50
return

^!d::
	FormatTime, datetime,, yyyyMMddhhmmss
	SendInput, %datetime%
Return

; Zr456
 

#b:: ; Open URL in Browser Chrome
	if (ErrorLevel = 0) {
		EbayDvdSearch()
		
		; move opera to right screen and maximize
		if (1 = 0) {
			Loop, 200 {

				if WinActive("ahk_exe opera.exe") {
					SetKeyDelay, 500
					SendInput +#{Right}#{Up}
					SetKeyDelay, 0
					Break
				}

				Sleep, 100
			}
		}
	}
	else {
		MsgBox,(ZNYTRQ) Encountered ErrorLevel %ErrorLevel%
	}
Return

#If WinActive, ahk_exe explorer.exe ; Windows explorer
	^f:: Send {F2}{Right}{Backspace 13}S0
	Space::_
	+Space::Space


#IfWinActive, ahk_exe Wow.exe ; Warcraft
	-:: ; Fishing - left click bobber and then cast again
		Send {Shift down}{LButton down}
		Sleep, 50
		Send {Shift up}{LButton up}
		Sleep, 1000
		Send {=}
	Return

	Capslock::
		Send {Tab}
	Return

#IfWinActive, ahk_exe opera.exe ; opera
	+^f::
		SendInput ^f
		Sleep, 100
		SendInput Brand New {ASC 250} DVD
	Return 



; #IfWinActive, ahk_class Chrome_WidgetWin_1 ; chrome and opera  ;2022-01-25 - this triggers when the vs code window is active
	~F4 & F4:: 
		SendInput !{F4}
		return
	Right::SendInput {Right}^>
	Left::SendInput {Left}^<
	^+Up::SendInput {Volume_Up}
	^+Down::SendInput {Volume_Down}

#IfWinActive, ahk_class MozillaWindowClass
	Right::SendInput {Right}^>
	Left::SendInput {Left}^<
	^+Up::SendInput {Volume_Up}
	^+Down::SendInput {Volume_Down}


#IfWinActive, ahk_class gdkWindowToplevel
	^+j::
		SetKeyDelay, 1000
		!i 
		Send c 
		^e 
		^a 
		;SendInput ebay.jpg
		!e
		!r
		!e
		^w
		Send #{Down}
		SetKeyDelay, 
	return

#IfWinActive, ahk_class TTOTAL_CMD ; Total Commander
	MButton:: Send {LButton 2}
	^f:: Send {F2}{Right}{Left 4}{Backspace 13}S0
	Space::_
	+Space::Space

#IfWinActive, ahk_exe HandBrake.exe

	; Set episodeNumber
	^Enter::
		global episodeNumber
		SetFormat, float, 02.0
		InputBox, episodeString, "Set EpisodeNumber"
		episodeNumber := episodeString + 0.0
	return


	; from destination textbox, click "add to queue" and advance title dropdown

	+Enter::
		
		global handbrakeIsRunning
		global episodeNumber
		SetFormat, float, 02.0
		episodeNumber += 0.0
		episodeText := episodeNumber . "_"

		if (handbrakeIsRunning == 1) {
			SendInput {Tab 4}
			sleep, 250
			SendInput ^a
			SendInput {Tab 13}
			SendInput {Down 1} ; title number
			SendInput +{Tab 17}
			SendInput ^a^v
			SendInput {Left 4}
			SendInput %episodeText%
		}
		else {
			SendInput {Tab 4}
			sleep, 250
			SendInput ^a
			SendInput {Tab 12}
			SendInput {Down 1}
			SendInput +{Tab 16}
			SendInput ^a^v
			SendInput {Left 4}
			SendInput %episodeText%
		}

		episodeNumber += 1.0
	return
	!a::
	NumpadEnter::
	Enter::
		if (handbrakeIsRunning == 1) {
			SendInput {Tab 4}					
			sleep, 250
			SendInput ^a
			SendInput {Tab 13}
			SendInput {Down 1}
			SendInput +{Tab 17}
			SendInput ^a^v
			SendInput {Left 4}
		}
		else {
			SendInput {Tab 4}					
			sleep, 250
			SendInput ^a
			SendInput {Tab 12}
			SendInput {Down 1}
			SendInput +{Tab 16}
			SendInput ^a^v
			SendInput {Left 4}
		}
	return

	; from destination textbox, advance title dropdown
	;^Down::
	;	SendInput +{Tab}+{Tab}+{Tab}+{Tab}+{Tab}
	;	SendInput {Down}
	;	SendInput {Tab}{Tab}{Tab}{Tab}{Tab}
	;	SendInput ^a^v
	;	SendInput {Left 4}
	;return

	; from destination textbox, decrement title dropdown
	^Up::
		SendInput +{Tab}+{Tab}+{Tab}+{Tab}+{Tab}
		SendInput {Up}
		SendInput {Tab}{Tab}{Tab}{Tab}{Tab}
		SendInput ^a^v
		SendInput {Left 4}
	return

; use underscores instead of spaces for filenames in HandBrake and when saving files
#If WinActive("HandBrake") || WinActive("Export Image") || WinActive("Save As")
	Space::_
	+Space::Space
#If


; hotkey to dvd covers path
^+e:: SendInput \\WHITLEY-202007\h\Images\DvdImages {Enter}



;----- side mouse buttons
	xbutton1::
		if (WinActive("ahk_class PotPlayer64")) {
			; display currently playing title number 
			MouseMove, 40, 20
			MouseClick
			SendInput D {Right}
		}
		else if (WinActive("ahk_exe vlc.exe")) { ; vlc media player
			MsgBox, "West"
			MouseClick, Right
			Send {Down 9}{Right 2}
		}
		else {
			WinGetTitle, title, A
			MouseClick, Left
			Send {End}
		}
	return
	xbutton2::
		if (WinActive("ahk_class PotPlayer64")) {
			Send +^r
		}
		else {
			MouseClick, Left
			Send {Home}
		}
	return

	+xbutton2::
		IfWinActive, ahk_class PotPlayer64
			Send !{Backspace}
		return


; reload ahk script when sublime saves
#IfWinActive ahk_exe notepad++.exe
#IfWinActive ahk_exe sublime_text.exe
	^s::
		Send ^s
		Reload, d:\Users\rgw3\Documents\AutoHotkey\home.ahk 
	return

; Media Monkey File Properties
#IfWinActive ahk_class TFSongProperties
	^f::Send !{Right}

; Media Monkey main window
#IfWinActive ahk_class TFMainWindow
	
	^Enter:: Enter

	;paste next week's date in field below
	^!p::
		Send ^a^c
		Sleep, 500
		baseDate := TextToTimestamp(Clipboard)
		baseDate += 7, Days
		FormatTime, displayDate, %baseDate%, MM/dd/yyyy

		Send {Home}{Enter}{Down}{F2}^a
		Send %displayDate%
		
		Return

	;copy text to field above or below
	^!o::
		Send ^a^c
		Sleep, 500
		Send {Home}{Enter}{Down}{F2}^a^v
		Return
	^+!o::
		Send ^a^c
		Sleep, 500
		Send {Home}{Enter}{Up}{F2}^a^v
		Return

	; prevent MM from playing media
	Click, 2::
	NumpadEnter::
	Enter::
	return
	
	;^b::
	!q:: 
		SendInput {Enter}{Down}{F2}{Home}
		;SendInput {Right 2}.
		SendInput /{Left}
		;SendInput ^a 
		;SendInput ^v{End}{Backspace}
	Return
	^Down:: 
		SetKeyDelay, 50
		SendInput {Enter}{Down}{F2}{Home}^a
		SetKeyDelay, 0
		Return
	+^Down::
		SetKeyDelay, 50
		SendInput ^a^c{End}{Enter}{Down}{F2}{Home}^a^v ; copy value to cell below
		SetKeyDelay, 0
		Return
	^Up:: 
		SetKeyDelay, 50
		SendInput {Enter}{Up}{F2}{Home}^a
		SetKeyDelay, 0
		Return

; New Document from Scanner windows paint
#IfWinActive ahk_class MSPaintApp
	+^N::
		ScanWithMsPaint()
	Return


; adobe acrobat
ifWinActive, AcrobatSDIWindow
{
; turn on Typewriter with ctrl-T
	^T::	
			sendInput !T Y W
	return
}

;------ code signature
;------ ignore if PotPlayer is active
#IfWinNotActive, PotPlayer
	^d::
		FormatTime, TimeString, CurrentDate, yyyy-MM-dd HH:mm
		Send %TimeString% - bwhitley
	return
#IfWinNotActive

;----- paint.net
;----- NOTE: SetTitleMatchMode is used here
SetTitleMatchMode, 2 ;------ A window's title can contain WinTitle anywhere inside it to be a match
#IfWinActive paint.net
	!s:: ; alt-s
		Send ^+s
		Sleep 50
		Send ebay.png{enter}
		Send !y
		Send {enter}
	return
#IfWinActive

GetFirstWord(word, num)
{
	StringSplit, wordArray, word, % A_Space
	return wordArray%num%
}

EbayDvdSearch()
{
	; DVD/Blu-ray, Brand New/Like New, Sort, Item Location, Buy It Now

	ebayBluraySuffix := "&rt=nc&Format=Blu%252Dray%2520Disc&_dcat=617"

	InputBox, searchterms, Search Terms, Enter DVD Search Terms,,,

	terms := StrReplace(searchterms, " ", "+")

	searchType := "dvd"
	
	; prefix terms with "vg" for video games
	if (SubStr(terms, 1, 3) == "vg+") {
		searchType := "videogame"
		terms := SubStr(terms, 3, StrLen(terms))
	}
	
	; prefix terms with "br" for blu-rays
	isBluRay = 0
	if (SubStr(terms, 1, 3) == "br+") {
		isBluRay = 1
		terms := SubStr(terms, 3, StrLen(terms))
	}
	
	StringLower, terms, terms
	walMartTerms := terms
	docsTerms := terms
	eBayTerms := RemoveDeadWords(terms, "+")
	searchToBrowserTerms := GetFirstWord(RemoveDeadWords(searchterms), 1)
	imageTerms := terms
	wikiTerms := terms
	seasonNotationTerms := ""
	termLength := StrLen(terms)
	

	;RunWait, "D:\Users\rgw3\PythonScripts\SearchToBrowser\SearchToBrowser.bat" "%searchToBrowserTerms%"
	RunWait, pyw "D:\Users\rgw3\PythonScripts\SearchToBrowser\SearchToBrowser.py"  "%searchToBrowserTerms%"

	seasonNumber := SubStr(terms, termLength, 1)
	if (seasonNumber is not integer) {
		seasonNumber := -1
	}

	isSeasonNotation := False
	if (SubStr(terms, termLength - 2, 2) = "+s" && seasonNumber is integer) {
		isSeasonNotation := True
		seasonNotationTerms := seasonNumber . "+" . GetOrdinalValue(seasonNumber) . "+season"

		eBayTerms := RemoveDeadWords(SubStr(terms, 1, termLength - 2) . seasonNotationTerms, "+")
		imageTerms := SubStr(terms, 1, termLength - 2) . seasonNotationTerms
		walMartTerms := SubStr(terms, 1, termLength - 2) . seasonNotationTerms
		wikiTerms := SubStr(terms, 1, termLength - 2) . seasonNotationTerms
	}

	albris := "https://www.alibris.com/moviesearch?keyword=" . walMartTerms . "&mtype=V&hs.x=31&hs.y=32"
	walmart := "https://www.walmart.com/search/?cat_id=0&query=" . walMartTerms . "+dvd"
	searchToBrowser := "file:D:\Users\rgw3\PythonScripts\SearchToBrowser\SearchResults.txt"


	ebay_dvd := "https://www.ebay.com/sch/i.html?_from=R40&_trksid=m570.l1313&_nkw=" . ebayTerms . "&_sacat=617&LH_TitleDesc=0&LH_PrefLoc=1&_fsrp=1&_sop=15&_osacat=617&_odkw=" . ebayTerms . "&LH_BIN=1&LH_ItemCondition=1000%7C2750&LH_BIN=1"
	if (isBluRay) {
		brAppendText := "&Format=Blu%252Dray"
		ebay_dvd := StrReplace(ebay_dvd, "+dvd", "") . brAppendText
	}
	
	ebay_videoGame := "https://www.ebay.com/sch/i.html?_from=R40&_trksid=p2334524.m570.l1313&_nkw=" . ebayTerms . "&_sacat=1249&LH_TitleDesc=0&_fsrp=1&LH_PrefLoc=3&_sop=15&LH_BIN=1"

	; strip season info from imdb search terms
	imdbTerms := terms
	if isSeasonNotation {
		imdbTerms := SubStr(terms, 1, termLength - StrLen(" s3"))
	}

	; remove "br" from imdb search
	imdbTerms := StrReplace(imdbTerms, "+br+", "+")	
	if (SubStr(imdbTerms, -3) = "+br") {
		imdbTerms := SubStr(imdbTerms, 1, StrLen(imdbTerms) - 3)
	}
	if (SubStr(imdbTerms, 1, 3) = "br+") {
		imdbTerms := SubStr(imdbTerms, 3)
	}
	imdbTerms := StrReplace(imdbTerms, "blu+ray", "")
		

	images := "https://www.google.com/search?q=" . imageTerms . "%20dvd%20cover&tbm=isch&tbs=isz:l&hl=en-US&sa=X&biw=1865&bih=970"
	imdb := "https://www.imdb.com/find?ref_=nv_sr_fn&q=" . imdbTerms . "&s=all"
	wikipedia := "https://en.wikipedia.org/wiki/Special:Search/" . wikiTerms . "&DVD%3ASearch&go=Go"
	docs := "https://drive.google.com/drive/u/0/search?q=" . docsTerms

	
	if (searchType == "videogame") {
		Run, "C:\Users\rgw3\AppData\Local\Programs\Opera\launcher.exe" --private --new-window %ebay_videoGame%
	} else if (searchType == "dvd") {
		Run, "C:\Users\rgw3\AppData\Local\Programs\Opera\launcher.exe" --private --new-window %ebay_dvd% %searchToBrowser% %images% %imdb%
	}
	else
		MsgBox,unknown search type
}

GetOrdinalValue(inVar) {
	
	if (inVar = 1) 
	{ 
		return "first" 
	}	
	if (inVar = 2) 
	{ 
		return "second" 
	}	
	if (inVar = 3) 
	{ 
		return "third" 
	}	
	if (inVar = 4) 
	{ 
		return "fourth" 
	}	
	if (inVar = 5) 
	{ 
		return "fifth" 
	}	
	if (inVar = 6) 
	{ 
		return "sixth" 
	}	
	if (inVar = 7) 
	{ 
		return "seventh" 
	}	
	if (inVar = 8) 
	{ 
		return "eighth" 
	}	
	if (inVar = 9) 
	{ 
		return "ninth" 
	}	
	if (inVar = 10) 
	{ 
		return "tenth" 
	}	
	return
}

;^1::
;	InputBox, searchterms, Test RemoveDeadWords(), Enter DVD Search Terms,,,
;	MsgBox, % RemoveDeadWords(searchTerms, "+")

return
RemoveDeadWords(inString, delimiter = " ") {
	returnVal := inString
	deadWords := ["the", "a", "for", "an", "in", "of", "by", "and", "on", "from", "is", "as"]

	for i, word in deadWords {
		; in middle
		returnVal := StrReplace(returnVal, delimiter . word . delimiter, delimiter)

		; in front
		if (SubStr(returnVal, 1, strLen(word) + 1) == word . delimiter) {
			returnVal := SubStr(returnVal, -1 * (StrLen(returnVal) - strLen(word) - 2))
		}

		;MsgBox, %  "(" . word . ") (" returnVal . ") [" . SubStr(returnVal, -1 * (StrLen(word))) . "]"
		; in back
		if (SubStr(returnVal, -1 * (StrLen(word))) == delimiter . word) {
			returnVal := SubStr(returnVal, 1, StrLen(returnVal) - StrLen(word) - 1)
		}
	}

	return returnVal
}

ScanWithMsPaint() {
	SetKeyDelay, 400
	Send !F
	Send M 
	Send {Right}{Enter}
	;Send {Tab 2}
	;Send {Space}
	Sleep, 500
	Send {Return}
	SetKeyDelay, -1
}


;  
;  !	{Alt}	
;  +	{Shift}
;  ^	{Ctrl}	
;  #	{LWin}
 

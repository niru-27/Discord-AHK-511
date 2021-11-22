#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

;=========================================================
#IfWinActive, ahk_exe Discord.exe

^Enter::			;Add Unix timestamp for Discord
	found:=0
	
	ClipSave:=ClipboardAll ; store current clipboard
	Send ^a
	Sleep, 100
	Send ^x
	Sleep, 100
	
	;Convert Briefing time
	if(RegexMatch(Clipboard,"Oi)DATE:\s*(\d\d)\s*([a-zA-Z]{3,4})\s*(\d{2,4}).+BRIEFING START:\s*(\d{2,4})", Match))
	{
		;MsgBox, % Match[1] . Match[2] . Match[3] . Match[4]
		DD  := % Match[1]
		MMM := % Match[2]
		YYYY:=% Match[3]
		tod := % Match[4]
		found:=1
		
		if(InStr(MMM,"JAN",false))
			MM:="01"
		else if(InStr(MMM,"FEB",false))
			MM:="02"
		else if(InStr(MMM,"MAR",false))
			MM:="03"
		else if(InStr(MMM,"APR",false))
			MM:="04"
		else if(InStr(MMM,"MAY",false))
			MM:="05"
		else if(InStr(MMM,"JUN",false))
			MM:="06"
		else if(InStr(MMM,"JUL",false))
			MM:="07"
		else if(InStr(MMM,"AUG",false))
			MM:="08"
		else if(InStr(MMM,"SEP",false))
			MM:="09"
		else if(InStr(MMM,"OCT",false))
			MM:="10"
		else if(InStr(MMM,"NOV",false))
			MM:="11"
		else if(InStr(MMM,"DEC",false))
			MM:="12"
		
		if(YYYY<100)
			YYYY=20%YYYY%
		
		Ts=%YYYY%%MM%%DD%%tod%00
		Ts := Time_human2unix(Ts)
		;Clipboard=<t:%Ts%>
		;Send {Right}
		;Send {End} <t:%Ts%>
		
		;MsgBox,	%YYYY%-%MM%-%DD%  %tod%`n`n%Ts%
		
		rep=~~%tod%~~ <t:%Ts%> [<t:%Ts%:R>]
		Clipboard := StrReplace(Clipboard,tod,rep)
		Sleep, 100
	}
	
	;Convert Wheels-up time
	if(RegexMatch(Clipboard,"Oi)DATE:\s*(\d\d)\s*([a-zA-Z]{3,4})\s*(\d{2,4}).+WHEELS UP:\s*(\d{2,4})", Match))
	{
		;MsgBox, % Match[1] . Match[2] . Match[3] . Match[4]
		DD  := % Match[1]
		MMM := % Match[2]
		YYYY:=% Match[3]
		tod := % Match[4]
		found:=1
		
		if(InStr(MMM,"JAN",false))
			MM:="01"
		else if(InStr(MMM,"FEB",false))
			MM:="02"
		else if(InStr(MMM,"MAR",false))
			MM:="03"
		else if(InStr(MMM,"APR",false))
			MM:="04"
		else if(InStr(MMM,"MAY",false))
			MM:="05"
		else if(InStr(MMM,"JUN",false))
			MM:="06"
		else if(InStr(MMM,"JUL",false))
			MM:="07"
		else if(InStr(MMM,"AUG",false))
			MM:="08"
		else if(InStr(MMM,"SEP",false))
			MM:="09"
		else if(InStr(MMM,"OCT",false))
			MM:="10"
		else if(InStr(MMM,"NOV",false))
			MM:="11"
		else if(InStr(MMM,"DEC",false))
			MM:="12"
		
		if(YYYY<100)
			YYYY=20%YYYY%
		
		Ts=%YYYY%%MM%%DD%%tod%00
		Ts := Time_human2unix(Ts)
		;Clipboard=<t:%Ts%>
		;Send {Right}
		;Send {End} <t:%Ts%>
		
		;MsgBox,	%YYYY%-%MM%-%DD%  %tod%`n`n%Ts%
		
		rep=~~%tod%~~ <t:%Ts%> [<t:%Ts%:R>]
		Clipboard := StrReplace(Clipboard,tod,rep)
		Sleep, 100
	}
	
	;Convert YYYY MM DD HH MM
	if(RegexMatch(Clipboard,"O)(\d{4}).?(\d{2}).?(\d{2}).?(\d{2}).?(\d{2}).?(\d{2})?", Match))
	{
		YYYY:= % Match[1]
		MM  := % Match[2]
		DD  :=% Match[3]
		tod := % Match[4] .  Match[5]
		found:=1
		
		Ts=%YYYY%%MM%%DD%%tod%00
		
		if(!Match[6])
			Ts=%YYYY%%MM%%DD%%tod%00
		else
			Ts=%YYYY%%MM%%DD%%tod%
		Ts := Time_human2unix(Ts)
		;Clipboard=<t:%Ts%>
		;Send {Right}
		;Send {End} <t:%Ts%>
		MsgBox,	%YYYY%-%MM%-%DD%  %tod%`n`n%Ts%
		
		rep=~~%tod%~~ <t:%Ts%> [<t:%Ts%:R>]
		;Clipboard:=StrReplace(Clipboard,tod,rep)
		Clipboard=~~%Clipboard%~~ <t:%Ts%> [<t:%Ts%:R>]
		Sleep, 100
	}
	
	if(!found)
	{
		Send ^v
		Sleep, 100
		MsgBox,	Time Not found`n`n%Clipboard%
	}else
	{
		Send ^v
		Sleep, 100
		Send {Enter}
	}
	
	Clipboard:=ClipSave 	; restore old clipboard content
	ClipSave:="" 			; clear variable
return
;=========================================================
^e::			;Convert local to Unix
	found:=0
	
	ClipSave:=ClipboardAll ; store current clipboard
	Send ^x
	Sleep, 100
	
	;Convert YYYY MM DD HH MM
	if(RegexMatch(Clipboard,"O)(\d{4}).?(\d{2}).?(\d{2}).?(\d{2}).?(\d{2}).?(\d{2})?", Match))
	{
		YYYY:= % Match[1]
		MM  := % Match[2]
		DD  :=% Match[3]
		tod := % Match[4] .  Match[5]
		found:=1
		
		Ts=%YYYY%%MM%%DD%%tod%00
		
		if(!Match[6])
			Ts=%YYYY%%MM%%DD%%tod%00
		else
			Ts=%YYYY%%MM%%DD%%tod%

		Ts := Time_human2unix(Ts)
		
		;Clipboard=<t:%Ts%>
		;Send {Right}
		;Send {End} <t:%Ts%>
		;MsgBox,	%YYYY%-%MM%-%DD%  %tod%`n`n%Ts%
		
		rep=~~%tod%~~ <t:%Ts%> [<t:%Ts%:R>]
		;Clipboard:=StrReplace(Clipboard,tod,rep)
		Clipboard=~~%Clipboard%~~ <t:%Ts%> [<t:%Ts%:R>]
		Sleep, 100
	}
	
	Send ^v
	Sleep, 100
	
	if(!found)
	{
		MsgBox,	Time Not found`n`n%Clipboard%
	}
	
	Clipboard:=ClipSave 	; restore old clipboard content
	ClipSave:="" 			; clear variable
return
;=========================================================
^w::			;Convert local to EST
	found:=0
	
	ClipSave:=ClipboardAll ; store current clipboard
	Send ^x
	Sleep, 100
	
	;Convert YYYY MM DD HH MM
	if(RegexMatch(Clipboard,"O)(\d{4}).?(\d{2}).?(\d{2}).?(\d{2}).?(\d{2}).?(\d{2})?", Match))
	{
		YYYY:= % Match[1]
		MM  := % Match[2]
		DD  :=% Match[3]
		tod := % Match[4] .  Match[5]
		found:=1
		
		Ts=%YYYY%%MM%%DD%%tod%00
		
		if(!Match[6])
			Ts=%YYYY%%MM%%DD%%tod%00
		else
			Ts=%YYYY%%MM%%DD%%tod%

		Ts := Time_human2unixEST(Ts)
		Ts := Time_unix2human(Ts)
		;Clipboard=<t:%Ts%>
		;Send {Right}
		;Send {End} <t:%Ts%>
		;MsgBox,	%YYYY%-%MM%-%DD%  %tod%`n`n%Ts%
		
		;rep=~~%tod%~~ <t:%Ts%> [<t:%Ts%:R>]
		;Clipboard:=StrReplace(Clipboard,tod,rep)
		
		RegexMatch(Ts,"O)^(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})", Match)
		;Clipboard=~~%Clipboard%~~ %Ts%
		Clipboard=~~%Clipboard%~~
		Clipboard := % Clipboard . " " . Match[1] . "-" . Match[2] . "-" . Match[3] . " " . Match[4] . ":" . Match[5]
		Sleep, 100
	}
	
	Send ^v
	Sleep, 100
	
	if(!found)
	{
		MsgBox,	Time Not found`n`n%Clipboard%
	}
	
	Clipboard:=ClipSave 	; restore old clipboard content
	ClipSave:="" 			; clear variable
return
;=========================================================
^t::	; TRAINING TEMPLATE
	ClipSave:=ClipboardAll ; store current clipboard
Clipboard:=
(
"DATE: DDMONTHYYYY
FLIGHT CALLSIGN: 
PRIMARY OBJECTIVE: 
SECONDARY OBJECTIVES: 
BRIEFING START: 
WHEELS UP: 
FREQUENCY: 
NET ID/TACAN: "
)
	Send ^v
	Clipboard:=ClipSave 	; restore old clipboard content
	ClipSave:="" 			; clear variable
return

;=========================================================
^d::	; DEPLOYMENT TEMPLATE
	ClipSave:=ClipboardAll ; store current clipboard
Clipboard:=
(
"DATE: DDMONTHYYYY
FLIGHT CALLSIGN: (As assigned)
MISSION NUMBER: 
BRIEFING START: 
STEP TIME: 
FREQUENCY: 
NET ID/TACAN: "
)
	Send ^v
	Clipboard:=ClipSave 	; restore old clipboard content
	ClipSave:="" 			; clear variable
return

;=========================================================
^r::	; AAR TEMPLATE
	ClipSave:=ClipboardAll ; store current clipboard
Clipboard:=
(
"DATE: DDMONTHYYYY
FLIGHT: 
HOURS: 
KILLS: 
WEAPONS: 
TACTICS: 
REMARKS: "
)
	Send ^v
return

;=========================================================

#IfWinActive

Time_unix2human(time)			;2human
{

    human=19700101000000

    u:=A_NowUTC
	n:=A_Now

	StringMid,ah,u,9,2
	StringMid,am,u,11,2
	StringMid,bh,n,9,2
	StringMid,bm,n,11,2

	offset:=(bh*60+bm-ah*60-am)*60
	
	time+=offset
	
    human+=%time%,Seconds

    return human
}

Time_human2unix(time)			;2UNIX
{

    time-=19700101000000,Seconds
	
	u:=A_NowUTC
	n:=A_Now

	StringMid,ah,u,9,2
	StringMid,am,u,11,2
	StringMid,bh,n,9,2
	StringMid,bm,n,11,2

	offset:=(bh*60+bm-ah*60-am)*60
	
	time-=offset

    return time
}

Time_human2unixEST(time)			;2UNIX
{

    time-=19700101000000,Seconds
	
	u:=A_NowUTC
	n:=A_Now

	StringMid,ah,u,9,2
	StringMid,am,u,11,2
	StringMid,bh,n,9,2
	StringMid,bm,n,11,2

	offset:=(bh*60+bm-ah*60-am)*60
	offset+=(10.5)*60*60					;Set time difference to EST from Local
	
	time-=offset

    return time
}
;=========================================================
FormatSeconds(NumberOfSeconds)  ; Convert the specified number of seconds to hh:mm:ss format.
{
    time := 19700101000000  ; *Midnight* of an arbitrary date.
    time += NumberOfSeconds, seconds
    FormatTime, mmss, %time%, mm:ss
    return NumberOfSeconds//3600 ":" mmss
    /*
    ; Unlike the method used above, this would not support more than 24 hours worth of seconds:
    FormatTime, hmmss, %time%, h:mm:ss
    return hmmss
    */
}
#include <MsgBoxConstants.au3>
#include <IE.au3>

; Initiate Script
Main()

Func Main()

Global $sleepSecs=2 , $n=0, $w1,$w2 ;   sleep time in seconds
Local $positions[24];

Global $randoWords[10]=["nick","time","salt","green","5","lazy","fast","diet","white","diamond"]


    ; Infinite loop
    While 0 < 1
        If CheckTime() == true Then
      
            If CheckInternetConnection() == true Then
                ; Internet Connection is true
                ; So no worries
                     ; Internet Connection is false
                ; Perform mouse click
              ;  MouseClick("left")
              $x= Random(1, 1920, 1) ;
              $y= Random(1, 1080, 1) ;
              $sec= Random(1, 3, 1) ;
              $n=$n+1;

              $positions[$n]=$n+":  x=" & $x & " y=" & $y  ;
            MouseMove($x, $y,$sec) ; Move the mouse cursor to the x, y position of 10, 100.
            
            $w1= Random(1, 9, 1)
            $w2= Random(1, 9, 1)
            SeachEngine( $randoWords[$w1] &" " &  $randoWords[$w2] )
           
            Else
                ; Internet Connection is false
         

            EndIf       
        EndIf
        ; Sleep for sleepsecs
        Sleep(1000 * $sleepSecs);
    WEnd
EndFunc

; The function checks if the current time is between 00:00 and 05:00
Func CheckTime()
    If @Hour >= 0 AND @Hour <= 05 Then
        Return true
    Else
        Return false
    EndIf
EndFunc

; The function checks if currently is a internet connection
Func CheckInternetConnection()
    Local $Connected = false
    $ping = Ping("www.yahoo.com")
    If $ping > 0 Then
        $Connected = true
        ;  $result= MsgBox(0,"InternetCheck","Internet Alive" ,1);

    EndIf
    Return $Connected
EndFunc

Func SeachEngine($sSeach)
    Local $oIE = _IECreate("http://www.duckduckgo.com")
    Local $oForm = _IEFormGetCollection($oIE, 0)
    Local $oSearchBox = _IEFormElementGetCollection($oForm, 0)

    _IEFormElementSetValue($oSearchBox, $sSeach)
    _IEFormSubmit($oForm)

     WinWaitActive($sSeach & " at DuckDuckGo")
    $aPos = WinGetPos($sSeach & " at DuckDuckGo","")
    MouseMove($aPos[0]+($aPos[2]/2),$aPos[1]+($aPos[3]/2))

    For $z = 1 To 7
     MouseWheel($MOUSE_WHEEL_DOWN,1*$z)
    sleep(250)
    Next

    Local $sMyString = $randoWords[$w1]
Local $oLinks = _IELinkGetCollection($oIE)
For $oLink In $oLinks
    Local $sLinkText = _IEPropertyGet($oLink, "innerText")
    If StringInStr($sLinkText, $sMyString) Then
        _IEAction($oLink, "click")
        ExitLoop
    Else
        $result= MsgBox($MB_YESNO,"No  Links Found","No MATCHES for " &  $randoWords[$w1]  ,3);

        ExitLoop
    EndIf

Next

      $result= MsgBox($MB_YESNO,"MouseMoved","Quit Script" ,3);

             if ($result=$IDYES) then
                    Exit 0;
               
                Run("notepad.exe")
                WinWaitActive("Untitled - Notepad")
                Send("Mouse Positions for this Run:")
                ;WinWaitActive("Notepad", "Do you want to save") ; When running under Windows XP
                 For $vElement In  $positions
                    Send($vElement) ;
                    Send( @CRLF);
                    Next

                
                Send("!n")
                WinClose("Untitled - Notepad")
                WinWaitActive("Notepad", "Save")
                
                
                EndIf   

    _IEQuit($oIE)

EndFunc   ;==>SeachGoogle
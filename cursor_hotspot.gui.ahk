#NoEnv ; (MW:2022) (MW:2022)
#persistent 
ListLines,Off 
#Singleinstance,	Force
DetectHiddenWindows,On
DetectHiddenText,	On
SetTitleMatchMode,	2
SetTitleMatchMode,	Slow
SetBatchLines,		-1
SetWinDelay,		-1
SetControlDelay,	-1
coordMode,	Tooltip	,	Screen
coordmode,	Mouse	,	Screen 
Setworkingdir,% (ahkexe:= splitpath(A_AhkPath)).dir
#include	<Taskbar> 	;		#Include <GDI+_All>
#include	C:\Script\AHK\- _ _ LiB\GDI+_All.ahk

global  parw_init:=205, Scale_Factor:=1, Marg_Parent:=25, Marg_Cur:= 15, Marg_Hic:=40,

IconPath:="C:\Icon\- Icons\- CuRS0R\cursor(9).cur" ; IconPath:="C:\Icon\- Icons\- CuRS0R\12.cur" IconPath:="C:\Icon\- Icons\- CuRS0R\ALLSEEING.cur" 

(!PtrP? PtrP:=	(A_PtrSize=8)?	"uptr*"	:	"Uint*") 
 (!Ptr?	Ptr:=	(A_PtrSize=8)?	"ptr"	:	"Uint")
 
;OnMessage(0x0054,"WM_EXITSIZEMOVE") ;WM_USERCHANGED ; (!(pToken := Gdip_Startup())?
;OnMessage(0x0232,"WM_EXITSIZEMOVE") ;MsgB("Gdiplus failed to start. Please ensure you have gdiplus on your system")
;OnMessage(0x0006,"WM_EXITSIZEMOVE") ;WM_DESTROY := 0x0002
;OnMessage(0x0010,"WM_CLOSE") 		 ;OnMessage(0x0047,"WM_WINDOWPOSCHANGED") 
;OnMessage(0x0002,"WM_CLOSE") 		 ;WM_DESTROY := 0x0002 
 OnMessage(0x0101,"WM_KEYUP")		 ;ExitApp()) 
 OnMessage(0x0203,"OnDoubleClick") 	 ;OnMessage(0x0047,"WM_WINDOWPOSCHANGED") 
 OnMessage(0x0205,"OnRBUp") 		 ;OnMessage(0x0047,"WM_WINDOWPOSCHANGED") 
 OnMessage(0x0004,"OnRBUp") 		 ;WM_DESTROY := 0x0002
 OnMessage(0x0015,"WM_SYSCOLORCHANGE")
 OnExit("ExitFunc")

loop,parse,% "VarZ,MeNuZ",`,
	 gosub,% a_loopfield

try,pToken:= Gdip_Startup()

if !fileexist(IconPath) {
	MsgB("check	.cur")
	FileSelectFile,IconPath,,C:\Icon\- Icons\- CuRS0R\,% "Open Cur:",*.cur
}
ip:=splitpath(IconPath)

varsetcapacity(fileinfo,(fisize:= A_PtrSize + 688)) 
(!IsObject(File:= FileOpen(IconPath,"r"))? MsgB("error" . exit()))
fileGetSize,szfile,% IconPath
VarSetCapacity(Bin,Sz_Kb:= szfile)
sLen:= file.RawRead(Bin,Sz_Kb) ; RetrievedEncoding := File.Encoding
(sLen<192? ((File.Close()>>192),exitapp()) : Ttip("analyzed " szfile "b"))
Cur_W:= NumGet(Bin,6,"Char"),	sx:= HotSpot_X:= NumGet(Bin,10,"Char") 
Cur_H:= NumGet(Bin,7,"Char"),	sy:= HotSpot_Y:= NumGet(Bin,12,"Char")
;((((((((((((((((((((!!!!!!!!!!!****!!!!!!!!!!!!!!))))))))))))))))))))
titl:=(((ip.ext="cur")? "Cur@" : ip.ext) . Cur_W . "*" . Cur_H)
;((((((((((((((((((((!!!!!!!!!!!****!!!!!!!!!!!!!!))))))))))))))))))))
gui,par: New, +AlwaysOnTop -dpiscale +lastfound -0x20000 +hWndhWnd_Par ,% titl ; +owner
gui,par: Color,% bc:= DllCall("GetSysColor", "Int", 15, "UInt") ; BTNFACE = 15
gui,par: Add, Text, x33 y6,X:
;		hotspot x editbox		****!!!!!!!!!!!!!!))))))))))))))))))))
gui,par: Add, Edit,gEditX vEditX x49 y3 w40 h28 -0x10000 +0x4000000 +hwndhwnd_editX, %HotSpot_X%
gui,par: Add, Text,x105 y6,Y:
;		hotspot y editbox		****!!!!!!!!!!!!!!))))))))))))))))))))
gui,par: Add, Edit, gEditY vEditY y3 x121 w40 h28 -0x10000 +0x4000000 +hwndhwnd_editY,%HotSpot_Y%
gui,par: Margin,% Marg_Parent,% Marg_Parent
;		cursor and magnification Slider	  !!!!!!!!))))))))))))))))))))
SliderOptions:= "Range1-5 AltSubmit reverse NoTicks Thick y220 w200 x1 h40 +hWndpar_slider gpar_slider_glabel vScale_Factor"
gui,par: Add, Slider,% SliderOptions " +0X4030100",slider ;  +E0x80008 (WS_EX_LAYERED := 0x80000),+0x30000 
Gui,par: +Toolwindow
Gui,par: +0x94C80000
Gui,par: -Toolwindow
gui,cur: New,+AlwaysOnTop +hWndG_hWnd -dpiscale -SysMenu +ToolWindow +lastfound -Caption -dpiscale ; +OwnDialogs 
gui,cur: Add,picture, w%Cur_W%  h%Cur_H% +hWndHhicon +0x4000000,% "HICON: " _:=ico2hicon(IconPath) ;0x4000000 draw over siblings
gui,par: Show,na x4000 y1300 w%parw_init%
winset,Transparent,1,ahk_id %hWnd_Par%
gui,par: hide ; Winset,   Style, +0x94C80000,ahk_id %hWnd_Par% 
winset,Transparent,off,ahk_id %hWnd_Par%
gui_titlebar_disable("par") ;  ! MUST BE FIRED B4 GUISHOW !  ;
winminimize,ahk_id %hWnd_Par%
gui,par: Show,  ; Winset, ExStyle, -0x00000080,ahk_id %hWnd_Par%
gui,cur: Show,% "na x" a_screenwidth-100 " y" a_screenheight-100 
winset,Transparent,1,ahk_id %g_hWnd%
 win_move(hWnd_Par, (a_Screenwidth/2)-100, (a_screenheight/2)-160, "","","") ;Win_Animate(hWnd_Par,"activate slide vneg", 380)
 
;((((((((((((((((((((!!!!!!!!!!!****!!!!!!!!!!!!!!))))))))))))))))))))
					; 		GDI fuckry								
;((((((((((((((((((((!!!!!!!!!!!****!!!!!!!!!!!!!!))))))))))))))))))))

HomeDC:= DllCall("GetDC","UInt",hWnd_Par)
hIcoDC:= DllCall("GetDC","UInt",hhicon)
DTopDC:= DllCall("GetDC","UInt",shit)
sTimer("Timertest",-10)
gSub("HotspotMark")
if(200/cur_w)>2.9
	GuiControl,,%par_slider%,+2
gui,par: Submit,Nohide
gSub("Timertest") 
return,

HotspotMark:
Width:= Height:= 9
Hot_Y:= HotSpot_Y*Scale_Factor, Hot_X:= HotSpot_X*Scale_Factor
;center:= CenterOffset()
wingetactivestats, tl,parw,parh,parx,pary
gui,hot:New,-dpiscale -Caption +hWndhWndh0t +E0x80000 ; +parentpar 
gui,hot:+LastFound +AlwaysOnTop +ToolWindow +OwnDialogs
gui,hot:Show,Center w9 h9 NA
winset,Transparent,1,ahk_id %hWndh0t%
hbm:= CreateDIBSection(Width,Height)
hdc:= CreateCompatibleDC()
obm:= SelectObject(hdc,hbm)
G:= Gdip_GraphicsFromHDC(hdc)
Gdip_SetSmoothingMode(G,4)
pPen:= Gdip_CreatePen(0xffff0000,2)
Gdip_DrawEllipse(G,pPen,0,0,Height-1,Height-1)
Gdip_DeletePen(pPen)
UpdateLayeredWindow(hWndh0t,hdc,0,0,Width,Height) 
ty:= pary+Hot_Y+center+Marg_Parent+40
hotsDC:= hdc
return, 

CenterOffset() {
	global parw_init,Cur_W,Scale_Factor
	return,(parw_init-(Cur_SzFactored:= Cur_W*Scale_Factor))-(Scale_Factor>1
	? (((parw_init/Scale_Factor)*0.65)	-((cur_w-32)*0.9)):80)
}

Timertest:
loop,1 {
	gui,par: color,000
	sleep 100
	(!OldFactor? OldFactor:= Scale_Factor)
	(!oldcurw? oldcurw:= Cur_W*Scale_Factor)
	((Cur_SzFactored>parw_init)?	("return",))
	if !init2 {
		init2:= True
		gui,par:Add,picture,x1 y31 w200 h180 +hWndParHicon2 ; 2rem leftover hall-of-mirrors upon draw-area decrease
		gui,par:Show,na
	} else, {
	center:= CenterOffset()

	  DllCall("gdi32.dll\StretchBlt","UInt",	HomeDC
									,"Int",		center
									,"Int",		center+40
									,"Int",		Cur_SzFactored 
									,"Int",		Cur_SzFactored
									,"UInt",	hIcoDC
									,"UInt",	0
									,"UInt",	0
									,"Int",		Cur_W
									,"Int",		Cur_W
									,"UInt",	NOTSRCCOPY	)

	   DllCall("UpdateLayeredWindow","Uint",	hWnd_Par
									,"Uint",	Marg_Parent+Marg_Cur
									,"Uint",	Marg_Parent+Marg_Cur
									,"int64P",	200|200<<32
									,"Uint",	hIcoDC
									,"int64P",	0
									,"Uint",	0
									,"intP",	0xFF<<16|1<<24
									,"Uint",	2	)

	  DllCall("gdi32.dll\StretchBlt","UInt",	HomeDC
									,"Int",		center+(editx*Scale_Factor)
									,"Int",		center+40+(edity*Scale_Factor)
									,"Int",		9 
									,"Int",		9
									,"UInt",	hdc
									,"UInt",	0
									,"UInt",	0
									,"Int",		9
									,"Int",		9
									,"UInt",	NOTSRCCOPY	)

	   DllCall("UpdateLayeredWindow","Uint",	hWnd_Par
									,"Uint",	center+(editx*Scale_Factor)
									,"Uint",	Marg_Parent+Marg_Cur
									,"int64P",	200|200<<32
									,"Uint",	hdc
									,"int64P", 	0
									,"Uint",	0
									,"intP",	0xFF<<16|1<<24
									,"Uint",	2 	)
	hotspotmark2:
	sTimer("ctrls_VisT",-1) 		;	gosub,HotspotMark
	}
}
return,

;((((((((((((((((((((!!!!!!!!!!!****!!!!!!!!!!!!!!))))))))))))))))))))
							; func etc ;							
;((((((((((((((((((((!!!!!!!!!!!****!!!!!!!!!!!!!!))))))))))))))))))))

Par_slider_glabel: 
sTimer("Timertest",-10)
return,

Timertest2:
sTimer("ctrls_VisT",-1)
gSub("Timertest")
gSub("HotspotMark")
return,

EditX:
EditY:
gui,par: Submit,Nohide
ord:= substr(a_thislabel,"ed")
(!(%a_thislabel%)=(%ord%hotspot)? rtn())
(%ord%hot):= ((%ord%hotspot):= (%a_thislabel%)*Scale_Factor):= (ed%ord%)
gSub("HotspotMark")
return,

guiclose:
Win_Animate(hWnd_Par, "hide blend", 1300)
timer("exitfunc",-1230)
exit,

ctrls_VisT:
loop parse,% "hwnd_editx,hwnd_edity,par_slider",`,
{
	winset,style,-0x10000000,%	"ahk_id " %a_loopfield%
	sleep,1
	winset,style,+0x10000000,%	"ahk_id " %a_loopfield%
}
return,

save:
ifwinnotactive,ahk_id %hWnd_Par%
	return,
FileSelectFile,iconpath_New,S8,% ip.path,Save to new file,*.cur
if fileexist(iconpath_New) {
	MsgB("0x4","Overwrite?","Overwrite?")
	ifmsgbox,cancel
		return,
	ifmsgbox,no
		return,
}
NumPut(editx,Bin,10,"char") 
NumPut(edity,Bin,12,"char")
file:= Fileopen(iconpath_New,"W")
file.RawWrite(&Bin,Sz_Kb)
try,(!file=""? file.Close())
return,

;((((((((((((((((((((!!!!!!!!!!!****!!!!!!!!!!!!!!))))))))))))))))))))
							; func etc ;							
;((((((((((((((((((((!!!!!!!!!!!****!!!!!!!!!!!!!!))))))))))))))))))))

WM_KEYUP(wParam, lParam){
global hWnd_Par
	switch wParam {
		case "27 ": ;esc
			settimer,guiclose,-1
			return
		case "13": ;enter
			gui,par: submit,nohide
			gSub("editx")
			gSub("edity")
			gSub("Timertest2")
			send,{tab}
		default:
			tt(wParam "`n" Format("{1:#x}",lParam))

		; case "":
	}
}

OnRBUp(wParam, lParam){
	menu,gui,show
}

WM_CLOSE(wParam, lParam){ 
	msgbox ; testing to find X close butt
	sTimer("guiclose",-1)
	sleep,1000
}

OnDoubleClick(wParam="", lParam="", msg="", hWnd="") { ;sets new HotspotMark		;tx:=parx+(lol*.5)+Hot_X 
	global Cur_H,center
	static STN_DBLCLK:= 1
	loop 1 {
		try {
			try if (Scale_Factor>1) {
				(EditX):= HotSpot_X:= Hot_X:= round(((loword(lParam))/scale_factor)-((center)/scale_factor))
				(EditY):= HotSpot_Y:= Hot_Y:= round((((hiword(lParam))/scale_factor)-((center-Marg_Cur)/scale_factor))-((Marg_Hic+Marg_Cur)/scale_factor))
			} else try {
				(EditX):= HotSpot_X:= Hot_X:= round(((loword(lParam))/scale_factor)-center)
				(EditY):= HotSpot_Y:= Hot_Y:= ((round(hiword(lParam)/scale_factor))-center-40)
			}
			GuiControl,Text,EditX,%EditX%	;gui,par: Edit,gEditX x45 y0, %HotSpot_X%
			GuiControl,Text,EditY,%EditY%	;gui,par: Edit,gEditY vEditY y0 x115,%HotSpot_Y%
			gui,par:submit,nohide	;Ttip((hiword(lParam)"y`n" (loword(lParam) "`n" )HotSpot_Y "`n  " HotSpot_X),1)
			((HotSpot_X<Cur_H)? HsX:= True)
			((HotSpot_Y<Cur_W)? HsY:= True)
			(!(HsX="" && HsY="")? (sTimer("Timertest",-1)) : Ttip("bad hotspot coords"))
		}
		id:= DllCall("GetDlgCtrlID", "ptr", hWnd)		;PostMessage 0x111,id | (STN_DBLCLK << 16), hWnd
	}
	return,0 ; return a value to prevent the default handling of this message.
}


blackouthwnd2(hWnd,full="",gdipstart=false) {	;static tries:= 1
	(!full=""? MsgB(full))
	dcC:= GetDC(hWnd)
	mDC:= Gdi_CreateCompatibleDC(0)
	mBM:= Gdi_CreateDIBSection(mDC,1,1,32)
	oBM:= Gdi_SelectObject( mDC,mBM )
	((full="")? (topOFF:= 28, bot0ff:= 188) : (topOFF:= 0, bot0ff:= 300))
	a:= dllcall("gdi32.dll\SetStretchBltMode","Uint",dcC,"Int",5)
	b:= dllcall("gdi32.dll\StretchBlt","Uint",dcC,"Int",0,"Int",topOFF
	,"Int",500,"Int",bot0ff,"Uint",mdc,"Uint",0
	,"Uint",0,"Int",1,"Int",1,"Uint","0x00CC0020")
	SelectObject(mdc,obm)
	DeleteObject(mbm)
	DeleteDC(mdc)
}

Ttip(TxT="", x:="", y="", dur="") {	;tooltip wrap can also be called with 1 or 2 params, guess which.
	(TxT=""? TxT:= A_now)
	if (x && !isint(x)) { ; allow2declare a_locStr
		isint(y)? (y? dur:= y) transpose potential dur arg
		somethingElseThatMightBeDeclarableLater:=dur?dur:() 
		switch	(tt_loc:= X)	{
			case "center":
				x:=	(A_screenwidth*0.5)-80
				y:=	(A_screenheight*.5)-35
			case "tray":
				x:=	A_screenwidth
				y:=	45
			case "!tray":
				x:=	A_screenwidth
				y:=	A_screenheight
		}
	} else (!y&&!dur? dur:= (x?x:-880))			;default TOuT 880ms (TOuT as param.2 (int or str))
	((dur&&!dur=0)? (dur<100&&dur>-100)? (dur*=1000))
	ToolTip,% TxT,% (x&&y?x:""),% (x&&y? y:""), 1 ; (y="center"?y:=(A_screenheight*.5)-35)
	SetTimer,TOuT,% ((instr(dur,"-")||dur<0)?dur:("-" . dur))
	return,~errOrlevel
 TOuT: 
 tooltip,
 return,
}


sTimer(byref Label,Rate="") {	; Settimer wrapper ; eliminates param flaw.
	(!rate? r:=-1 : r:= Rate)	; (mS)
	if (IsLabel(Label) )&& (!(Label=""))
	 try,SetTimer,% Label,% r	; Param1 req plain var-ref. As above
	 catch,
		 return,"Bad label?"
	else,return,0
	return,1
}

WM_SYSCOLORCHANGE() {
	global
	sTimer("Timertest2",-10000)
}

WM_USERCHANGED() {
	global 
	sTimer("Timertest2",-10000)
}

WM_EXITSIZEMOVE() {
	global
	sTimer("Timertest",-1000) 
}

WM_WINDOWPOSCHANGED() {
	return,init:=sTimer("Timertest2",-2) 
}

gSub(label){ 
	global
	gosub,%label%
	return,
}

rtn(){
	return,exit,
}

MAKELONG(LOWORD,HIWORD,Hex=0){
	BITS:=0x10,WORD:=0xFFFF
	return,(!Hex)?((HIWORD<<BITS)|(LOWORD&WORD)):Format("{1:#x}",((HIWORD<<BITS)|(LOWORD&WORD)))
}

LoWord(Dword,Hex=0){
	WORD:=0xFFFF
	return,(!Hex)?(Dword&WORD):Format("{1:#x}",(Dword&WORD))
}

HiWord(Dword,Hex=0){
	BITS:=0x10,WORD:=0xFFFF
	return,(!Hex)?((Dword>>BITS)&WORD):Format("{1:#x}",((Dword>>BITS)&WORD))
}

MsgB(title="",MsgStr="",timeout="",flags="",NoModality="",icon="") {
	(!MsgStr?(MsgStr:=title,TITLE:=""))
	(!flags)?(flags:=0x43040):(),(!title)?(title:="Attention")  		;	NoTitle	? NoProbs
	(!NoModality="")?(Gui(gui:="_",command   :=  "+OwnDialogs")) 		;	modal	?
	(!icon="")?__:=(SendWM_CoPYData(("mb" . ico2hicon(ICON))
	, "WinEvent.ahk ahk_class AutoHotkey")):("") 						;			? headless 
	msgbox,% flags,% title,% MsgStr,% timeout 							;	Msg	ina pissbottle.	BoWtZ
	(!NoModality="")?(Gui(gui:="_",  command := "Destroy")) 			;	MW:22)
	return,MsgStr 														;	22:WM)
}

ExitFunc(ExitReason, ExitCode) {
	global
	Win_Animate(hWnd_Par, "hide blend", 1300)

	DllCall("ReleaseDC","UInt",G_hWnd,"UInt",hdc)
	SelectObject(hdc,obm)
	DeleteObject(hbm)
	DeleteDC(hdc)
	Gdip_DeleteGraphics(G)	;Thegrahics may now be deleted
	Gdip_Shutdown(pToken) ;	 gdi+ may now be shutdown on exiting the progra
	g_vDD := "" ; Delete this object to unregister it from the super class and release it from the mouse hook.
	if (!(sX=HotSpot_X) || !(sY=HotSpot_Y))
		MsgB("Save","Apply Change?")
		if msgbox,Ok
			exitapp
}

menuz:
menu, Tray, NoStandard
menu, Tray, Add ,% "Open",             ID_VIEW_VARIABLES
try menu, Tray, Icon,% "Open",%			"C:\Icon\24\Gterminal_24_32.ico"
menu, Tray, Add ,% "Open Containing",  S_OpenDir
try menu, Tray, Icon,% "Open Containing",% "C:\Icon\24\explorer24.ico"
menu, Tray, Add ,% "Edit Script",      ID_TRAY_EDITSCRIPT
try menu, Tray, Icon,% "Edit Script",%	"C:\Icon\24\explorer24.ico"
menu, Tray, Add ,% "Reload",           ID_TRAY_RELOADSCRIPT
try menu, Tray, Icon,% "Reload",%		"C:\Icon\24\eaa.bmp"
menu, Tray, Add ,% "Suspend VKs",      ID_TRAY_SUSPEND
try menu, Tray, Icon,% "Suspend VKs",%	"C:\Icon\24\head_fk_a_24_c1.ico"
menu, Tray, Add ,% "Pause",            ID_TRAY_PAUSE
try menu, Tray, Icon,% "Pause",%		"C:\Icon\24\head_fk_a_24_c2b.ico"
menu, Tray, Add ,% "Exit",             ID_TRAY_EXIT
try menu, Tray, Icon,% "Exit",%			"C:\Icon\24\head_fk_a_24_c2b.ico"
menu, gui, add, yourea cunt, exitfunc
return,

ID_TRAY_RELOADSCRIPT:
global ID_TRAY_RELOADSCRIPT:= 65303
ID_TRAY_EDITSCRIPT:
global ID_TRAY_EDITSCRIPT:= 65304
ID_VIEW_VARIABLES:
global ID_VIEW_VARIABLES:= 65407
ID_TRAY_SUSPEND:
global ID_TRAY_SUSPEND:= 65305
ID_TRAY_PAUSE:
global ID_TRAY_PAUSE:= 65306
ID_TRAY_EXIT:
global ID_TRAY_EXIT:= 65307
msgbox % A_ScriptName
PostMessage,0x0111,(%a_thislabel%),,,% A_ScriptName " - AutoHotkey"
return,

AHK_NOTIFYICON(wParam, lParam) {
	switch lParam {	;case 0x205: ; WM_RBUTTONUP ;case 0x206: ; WM_RBUTTONDBLCLK  
	;case 0x020B: ; WM_XBUTTONDOWN 	;case 0x201: ; WM_LBUTTONDOWN ;case 0x202: ; WM_LBUTTONUP
		case 0x203:  ; WM_LBUTTONDBLCLK
			Ttip("Loading Var table...")
			sTimer("ID_VIEW_VARIABLES",-1)
			;PostMessage, 0x0111,%ID_VIEW_VARIABLES%,,,% (A_ScriptName " - AutoHotkey")
		case 0x0208: ; WM_MBUTTONUP  
			Ttip("Reloading")
			sTimer("ID_TRAY_RELOADSCRIPT",-1)
}	}

S_OpenDir:
Ttip("Opening: " a_scriptdir "...", 999)
try Open_Containing(a_scriptFullPath)
return,

varz:
global hdc,bin,DTopDC,HomeDC,G_hWnd,IconPath,hWnd_Par,hWndh0t,Marg_Hic,Cur_SzFactored,tl
global pary,parw,parh,Cur_W,HotSpot_X,HotSpot_Y,ord,EditX,EditY,hwnd_editX,hwnd_editY,
global sx,sy,ParHicon2,init2,hotsDC,SRCCOPY:=0x00330008,NOTSRCCOPY:=0x00CC0020,Sz_Kb,parx
global SliderOptions,hwnd_editx,hwnd_editym, CenterOffset
return,
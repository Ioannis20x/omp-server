CMD:tc(playerid,params[])
{
if(!isAdmin(playerid,0))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein" #SERVERTAG "Mitglied!");
new string[256],nachricht[256];
if(sscanf(params,"s[256]",nachricht))return WPM(playerid,"/tc [nachricht]");
format(string,sizeof(string),"%s %s: %s",AdminRank(playerid),getPlayerName(playerid),nachricht);
SendAdminMessage(1,COLOR_HBLUE,string);
return 1;
}


CMD:ahelp(playerid,params[])
{
if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein Admin/Dein Adminrang ist zu niedrig.");
SendClientMessage(playerid,COLOR_WHITE,":__________________ {4a9edf}Befehle für Moderatoren{FFFFFF} __________________");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** SUPPORT ***{FFFFFF} /w(hisper) /a(dmin) /respawnplayer /arefill /weather");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** SUPPORT ***{FFFFFF} /clearchat /respawnplayer /flip /getcarowner");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** SUPPORT ***{FFFFFF} /o(oc) /spec /specoff /freeze /ban /unfreeze /slap /warn /kick");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** SUPPORT ***{FFFFFF} /setint /setpint /setvw /fixveh /aopen /setskin");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** TELEPORT ***{FFFFFF} /go /gohouse /goto /gethere /ptp /getherecar /gotocar");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** EVENT ***{FFFFFF} /event /flip /addschirm /addschirmex (Alle im Umkreis) /eveh");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** EVENT ***{FFFFFF} /addequipex /cancel event");
SendClientMessage(playerid,COLOR_WHITE,"{4a9edf}*** FRAKTIONEN ***{FFFFFF} /finfo /allfinfo");
if(!isAdmin(playerid,3))return 0;
SendClientMessage(playerid,COLOR_WHITE,"__________________ {df4a4a}Befehle für Administratoren{FFFFFF} __________________");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** SUPPORT ***{FFFFFF} /reviveplayer /sethp /setarmor /gotoxyz /givegun");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** FAHRZEUGE ***{FFFFFF} /delveh /respawnveh /setfill");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** FRAKTIONEN ***{FFFFFF} /ainvite /auninvite /agiverank /aseturank");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** HÄUSER ***{FFFFFF} /createhouse /deletehouse /asellhouse");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** HÄUSER ***{FFFFFF} /sethouselevel /sethouseprice /sethouseinterior");
SendClientMessage(playerid,COLOR_WHITE,"{df4a4a}*** FLYMODE ***{FFFFFF} /fly");
if(!isAdmin(playerid,4))return 0;
SendClientMessage(playerid,COLOR_WHITE,"__________________ {D5E809}Befehle für Super Administratoren{FFFFFF} __________________");
SendClientMessage(playerid,COLOR_WHITE,"{D5E809}*** SYSTEM ***{FFFFFF} /makeleader /showservervehs /checkspawn /settime");
/*SendClientMessage(playerid,COLOR_WHITE,"{D5E809}*** SYSTEM ***{FFFFFF} /asellmbiz /aeditmbiz /enablebizattack");
SendClientMessage(playerid,COLOR_WHITE,"{D5E809}*** CLANMEMBER ***{FFFFFF} /settc (Ernennt/Entfernt einen Clanmember)");
SendClientMessage(playerid,COLOR_WHITE,"{D5E809}*** GAMEDESIGN ***{FFFFFF} /setgd (Ernennt/Entfernt einen Konzepter)");*/
if(!isAdmin(playerid,5))return 0;
SendClientMessage(playerid,COLOR_WHITE,"__________________ {FF0000}Befehle für Manager{FFFFFF} __________________");
SendClientMessage(playerid,COLOR_WHITE,"{FF0000}*** SYSTEM ***{FFFFFF} /fakeme /set /saduty /makeadmin /givelevel");
SendClientMessage(playerid,COLOR_WHITE,"{FF0000}*** SERVER ***{FFFFFF} /stopserver /gmx /netstat /givemoney /minigun");
SendClientMessage(playerid,COLOR_WHITE,"{FF0000}*** SYSTEM ***{FFFFFF} /setfstat /selectaduty");
SendClientMessage(playerid,COLOR_WHITE,"{FF0000}*** FAHRZEUGE ***{FFFFFF} /createfrakcar /setnitro");
SendClientMessage(playerid,COLOR_WHITE,"{FF0000}*** EVENT ***{FFFFFF} /reloadxmas /xmas");
return 1;
}



CMD:supveh(playerid,params[])
{
	new Float:x,Float:y,Float:z,Float:r;
	if(GetPVarInt(playerid,"supveh")==1)return 0;
	if(!isAdmin(playerid,1))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG " Mitglied!");
	SetPVarInt(playerid,"supveh",1);
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,r);
	new vID = CreateVehicle(457,x,y,z,r,-1,-1,false,true);
	PutPlayerInVehicle(playerid, vID, 0);
	SendClientMessage(playerid,COLOR_GREEN,"ERFOLGREICH: {FFFFFF}Du hast dir ein Supportercaddy gespawnt.");
	new string[128];

	format(string,sizeof(string),"%s hat sich ein Supportercaddy gespawnt",getPlayerName(playerid));
	SendAdminMessage(2,COLOR_YELLOW,string);
	return 1;
}

CMD:aduty(playerid,params[]){
	new string[128];
	new name[MAX_PLAYER_NAME];
	if(!isAdmin(playerid,1))return 0;
	if(isaduty(playerid)){
		SetPlayerColor(playerid, 0xFFFFFFFF);
		name = getPlayerName(playerid);
		format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun nicht mehr im Dienst.", name);
		SendClientMessageToAll(COLOR_RED, string);
		if(isAlevel(playerid, 5) || isAlevel(playerid,6)){
			SetPVarInt(playerid,"aduty",1);
		}else{
			SetPVarInt(playerid,"aduty",0);
		}
		TextDrawHideForPlayer(playerid,aduty_text);
		return 1;
	}
	if(isAlevel(playerid, 5) || isAlevel(playerid,6)){
		SetPVarInt(playerid,"aduty",2);
	}else{
		SetPVarInt(playerid,"aduty",1);
	}
	SetPlayerColor(playerid,COLOR_RED);
	format(string,sizeof(string),"SERVER: %s {FFFFFF}ist als %s im Dienst.",getPlayerName(playerid),AdminRank(playerid));
	SendClientMessageToAll(COLOR_RED,string);
	TextDrawShowForPlayer(playerid,aduty_text);
	return 1;
}


CMD:fraks(playerid, params[]) {    
    new string[1024]="";
    new nstring[256];
	
    for (new i = 1; i < MAX_FRAKS; i++) {
        format(nstring, sizeof(nstring),"\n%i: %s",i,fInfo[i][f_name]);
        strcat(string, nstring);
    }

	ShowPlayerDialog(playerid, 7563, DIALOG_STYLE_MSGBOX, "Fraktionen", string, "Okay", "");
    return 1;
}

/*

CMD:aduty(playerid,params[])
{
new name[MAX_PLAYER_NAME + 1],string[MAX_PLAYER_NAME + 23 + 100];

if(isAlevel(playerid,2)&& !isaduty(playerid)){
GetPlayerName(playerid, name, sizeof(name));
SetPlayerColor(playerid, COLOR_RED);
format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun als Moderator im Dienst.", name);
SendClientMessageToAll(COLOR_RED, string);
SetPVarInt(playerid,"aduty",1);
TextDrawShowForPlayer(playerid, aduty_text);
return 1;
}

else if(isAlevel(playerid,3)&& !isaduty(playerid)){
GetPlayerName(playerid, name, sizeof(name));
SetPlayerColor(playerid, COLOR_RED);
format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun als Administrator im Dienst.", name);
SendClientMessageToAll(COLOR_RED, string);
SetPVarInt(playerid,"aduty",1);
TextDrawShowForPlayer(playerid,aduty_text);
return 1;
}

else if(isAlevel(playerid,4)&& !isaduty(playerid)){
GetPlayerName(playerid, name, sizeof(name));
SetPlayerColor(playerid, COLOR_RED);
format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun als Super Administrator im Dienst.", name);
SendClientMessageToAll(COLOR_RED, string);
SetPVarInt(playerid,"aduty",1);
TextDrawShowForPlayer(playerid,aduty_text);

return 1;
}

else if(isAlevel(playerid,5)&& !isaduty(playerid)){
	GetPlayerName(playerid, name, sizeof(name));
	SetPlayerColor(playerid, COLOR_RED);
	format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun als Manager im Dienst.", name);
	SendClientMessageToAll(COLOR_RED, string);
	SetPVarInt(playerid,"aduty",2);
	TextDrawShowForPlayer(playerid,aduty_text);

	return 1;
}
else if(isAlevel(playerid, 6)&& !isaduty(playerid)){
	SetPlayerColor(playerid, COLOR_RED);
	GetPlayerName(playerid, name, sizeof(name));
	format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun als ServerOwner im Dienst.", name);
	SendClientMessageToAll(COLOR_RED, string);
	SetPVarInt(playerid,"aduty",2);
	TextDrawShowForPlayer(playerid,aduty_text);
	return 1;
}

else if(isaduty(playerid)){
SetPlayerColor(playerid, 0xFFFFFFFF);
GetPlayerName(playerid, name, sizeof(name));
format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun nicht mehr im Dienst.", name);
SendClientMessageToAll(COLOR_RED, string);
SetPVarInt(playerid,"aduty",1);
TextDrawHideForPlayer(playerid,aduty_text);
return 1;
}
return 1;
}*/

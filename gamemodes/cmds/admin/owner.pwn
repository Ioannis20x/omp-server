CMD:delallveh(playerid,params[]){
	if(!isAdmin(playerid,5))return SEM(playerid,"Du bist kein Admin/dein Adminrang ist zu niedrig.");
	for(new i=0;i<=MAX_VEHICLES;i++){
	if(IsValidVehicle(i)){
		DestroyVehicle(i);
		}
	}
	return 1;
}

CMD:reloadxmas(playerid,params[])
{
	if(!isAdmin(playerid,5))return SEM(playerid,"Du bist kein Admin/dein Adminrang ist zu niedrig.");
	for(new i=0;i<=MAX_VEHICLES;i++){
	if(IsValidVehicle(i)){
		DestroyVehicle(i);
		}
	}
	SendRconCommand("reloadfs  ");
	return 1;
}

CMD:fakeme(playerid,params[])
{
	if(!isAdmin(playerid,5))return SEM(playerid,"Du bist kein Admin/dein Adminrang ist zu niedrig.");
	new nstring[128],string[128];
	if(sscanf(params,"s[128]",nstring))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /fakeme [Name]");
	format(string,sizeof(string),"ADMIN:{FFFFFF} %s nennt sich nun %s",getPlayerName(playerid),nstring);
	SendAdminMessage(4,COLOR_RED,string);
	SetPlayerName(playerid,nstring);
	return 1;
}


CMD:set(playerid,params[])
{
	if(!isAdmin(playerid,5))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht befugt diesen Befehl zu nutzen.");
	if(!isaduty(playerid))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht befugt diesen Befehl zu nutzen.");
	new pID,thing[256],anzahl,string[265];
	if(sscanf(params,"us[256]i",pID,thing,anzahl))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /set [playerid] [Donut|Green|Gold|LSD|Level|Money|Skin] [Anzahl]");
	if(!strcmp(thing, "Donut", false))
	{
		sInfo[pID][pdonut] = anzahl;
		format(string,sizeof(string),"Du hast dem Spieler %s (ID %i) %i %s gesetzt.",getPlayerName(pID),pID,anzahl,thing);
		SendClientMessage(playerid,COLOR_YELLOW,string);
		return 1;
	}
	if(!strcmp(thing,"Green",false))
	{
		sInfo[pID][pgreen] = anzahl;
		format(string,sizeof(string),"Du hast dem Spieler %s (ID %i) %i %s gesetzt.",getPlayerName(playerid),pID,anzahl,thing);
		SendClientMessage(playerid,COLOR_YELLOW,string);
		return 1;
	}
	if(!strcmp(thing,"Gold",false))
	{
		sInfo[pID][pgold] = anzahl;
		format(string,sizeof(string),"Du hast dem Spieler %s (ID %i) %i %s gesetzt.",getPlayerName(playerid),pID,anzahl,thing);
		SendClientMessage(playerid,COLOR_YELLOW,string);
	 	return 1;
	}
	if(!strcmp(thing,"LSD",false))
	{
		sInfo[pID][plsd] = anzahl;
		format(string,sizeof(string),"Du hast dem Spieler %s (ID %i) %i %s gesetzt.",getPlayerName(playerid),pID,anzahl,thing);
		SendClientMessage(playerid,COLOR_YELLOW,string);
		return 1;
	}
	return 1;
}

CMD:createfrakcar(playerid,params[])
{
	new vID,Float:x,Float:y,Float:z,c1,c2;
	if(!isAdmin(playerid,5))return SendClientMessage(playerid,COLOR_RED,"ADMIN: {FFFFFF}Du bist nicht befugt diese Befehl zu nutzen.");
	if(sscanf(params,"iii",vID,c1,c2))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /createfrakcar [vID] [color1] [color2]");
	GetPlayerPos(playerid,x,y,z);
	createfCar(playerid,vID,x,y,z,0,c1,c2);
	return 1;
}


CMD:setnitro(playerid,params[])
{
	new vID;
	if(!isAdmin(playerid,5)) return SendClientMessage(playerid, COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!.");
	if(sscanf(params,"i",vID))return WPM(playerid,"/setbitro [vehicleid]");
	AddVehicleComponent(vID, 1010);

	return 1;
}


CMD:saduty(playerid,params[])
{
	if(isaduty(playerid)){
		TextDrawHideForPlayer(playerid,aduty_text);
		SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nun nicht mehr silent Aduty.");
		SetPVarInt(playerid,"aduty",0);
		return 1;
	}
	else
	{	SetPVarInt(playerid,"aduty",1);
		TextDrawShowForPlayer(playerid,aduty_text);
		SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nun silent Aduty.");
		return 1;
	}
}


CMD:makeadmin(playerid,params[])
{
	if(!isAdmin(playerid,5))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG " Mitglied!");
	new pID,a_level;
	if(sscanf(params,"ui",pID,a_level))return WPM(playerid,"/makeadmin [playerid] [Adminlevel]");
	sInfo[pID][padminlevel]=a_level;
	SendClientMessage(pID,COLOR_YELLOW,"Dein Adminrang wurde geändert.");
	SendClientMessage(playerid,COLOR_YELLOW,"Du hast den Adminrang geändert.");
	savePlayer(pID);
	return 1;
}


CMD:givelevel(playerid,params[])
{
	new pID;
	if(!isAdmin(playerid,5))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG " Mitglied!");
	if(sscanf(params,"u",pID))return WPM(playerid,"/givelevel [playerid]");
	SetPlayerScore(pID, GetPlayerScore(pID) + 1);
	SendClientMessage(pID,COLOR_RED,"ADMIN: {FFFFFF}Dir wurde ein Level geschenkt.");
	return 1;
}


CMD:stopserver(playerid,params[])
{
	if(!isAdmin(playerid,5))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF} Du bist nicht befugt diesen Befehl zu nutzen!");
	SendClientMessageToAll(COLOR_RED, "SERVER: Der Server wird jetzt heruntergefahren");
	GameTextForAll("~r~"#SERVERTAG "~w~ faehrt runter!",4000,5);
	SendRconCommand("exit");
	return 1;
}


CMD:minigun(playerid,params[])
{
	new string[256];
	if(!isAdmin(playerid,5))return 1;
	GivePlayerWeapon(playerid,WEAPON_MINIGUN,1999);
	format(string,sizeof(string),"ACHTUNG:{FFFFFF} %s hat sich eine Minigun gespawned!",getPlayerName(playerid));
	SendTeamMessage(COLOR_RED,string);
	return 1;
}



CMD:givemoney(playerid,params[])
{
	new pID,geld;
	if(sscanf(params,"ui",pID,geld))return WPM(playerid,"/givemoney [playerid] [money]");
	if(!isAdmin(playerid,6))return 0;
	GivePlayerMoney(pID, geld);
	sInfo[pID][pMoney]=geld;
	return 1;
}



CMD:netstat(playerid,params[])
{
	if(!isAdmin(playerid,5))return 0;
 	gNetStatsPlayerId = playerid;
    NetStatsDisplay();
    gNetStatsTimerId = SetTimer("NetStatsDisplay", 3000, true); // this will refresh the display every 3 seconds
    return 1;
}

CMD:setfstat(playerid,params[])
{
	new fID;
	if(!isAdmin(playerid,5))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG " Mitglied!");
	if(sscanf(params,"i",fID))return SendClientMessage(playerid,COLOR_GREY,"INFO: /setfstat [fID]");
	fInfo[fID][f_green] = 99;
	return 1;
}

CMD:gmx(playerid,params[]){
	if(!isAdmin(playerid,5))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG " Mitglied!");
	SendRconCommand("gmx");
	return 1;
}


CMD:selectaduty(playerid,params[])
{
if(isAlevel(playerid,6)){
ShowPlayerDialog(playerid,DIALOG_ADUTY,DIALOG_STYLE_LIST,"Aduty Menü","ServerOwner\nGroßmogul\nGrößte Instanz\nsilent","Aduty","Abbrechen");
}
return 1;
}



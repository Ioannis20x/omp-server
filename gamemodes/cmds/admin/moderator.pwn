CMD:w(playerid,params[]){
	new nachricht[256],string[256],pID;
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG "Mitglied!");
	if(sscanf(params,"u,s[256]",pID, nachricht))return WPM(playerid,"/w [nachricht]");
	format(string,sizeof(string)," %s flüstert dir: %s ",getPlayerName(playerid),nachricht);
	SendClientMessage(pID,COLOR_YELLOW,string);
	return 1;
}

CMD:a(playerid,params[])
{
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG "Mitglied!");
	new string[256],nachricht[256];
	if(sscanf(params,"s[256]",nachricht))return WPM(playerid,"/a [nachricht]");
	format(string,sizeof(string),"%s %s: %s",AdminRank(playerid),getPlayerName(playerid),nachricht);
	SendAdminMessage(2,COLOR_YELLOW,string);
	return 1;
}

CMD:slap(playerid,params[])
{
	new pID,Float:health, Float:x, Float:y, Float:z;
	if(!isAdmin(playerid,2))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
	if(sscanf(params,"u",pID))return WPM(playerid,"/slap [playerid]");
	GetPlayerPos(pID, x, y, z);
	GetPlayerHealth(pID,health);
	SetPlayerHealth(pID,health-5);
	SetPlayerPos(pID, x, y, z+2);
	PlayerPlaySound(pID,1190,0,0,0);
	return 1;
}

CMD:addschirmex(playerid,params[])
{
    //if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!.");
    if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x,y,z);
    for(new i = 0, j = MAX_PLAYERS; i <= j; i++) //GetPlayerPoolSize ist die höchste online playerid   | i repräsentiert die aktuelle id die gecheckt wird
    {
        if(IsPlayerInRangeOfPoint(i, 7.0, x, y, z))
        {
            GivePlayerWeapon(i, WEAPON_PARACHUTE, 0);
            SetPlayerArmour(i,100);
            SetPlayerHealth(i,100);
       }
    }
    return 1;
}

CMD:addschirm(playerid,params[])
{
	new pID;
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!.");
	if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
	if(sscanf(params,"u",pID))return WPM(playerid,"/addschirm [playerid]");
	GivePlayerWeapon(pID, WEAPON_PARACHUTE, 0);
	SetPlayerArmour(pID,100);
	SetPlayerHealth(pID,100);
	return 1;
}

CMD:addequipex(playerid,params[])
{
    //if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG" Mitglied!.");
    if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x,y,z);
    for(new i = 0, j = MAX_PLAYERS; i <= j; i++) //GetPlayerPoolSize ist die hüchste online playerid   | i reprüsentiert die aktuelle id die gecheckt wird
    {
        if(IsPlayerInRangeOfPoint(i, 7.0, x, y, z))
        {
            GivePlayerWeapon(i, WEAPON_DEAGLE, 350);
            GivePlayerWeapon(i,WEAPON_SHOTGUN,150);
            GivePlayerWeapon(i,WEAPON_MP5,400);
            GivePlayerWeapon(i,WEAPON_M4,400);
            SetPlayerArmour(i,100);
            SetPlayerHealth(i,100);
            SendClientMessage(i,COLOR_YELLOW,"EVENT: Eventausrütung hinzugefügt.");
        }
    }
    return 1;
}

CMD:respawnplayer(playerid,params[])
{
	new pID,string[128];
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!.");
	if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
	if(sscanf(params,"u",pID))return WPM(playerid,"/addequip [playerid]");
	SpawnPlayer(pID);
	SendClientMessage(pID,COLOR_YELLOW,"ADMIN: Du wurdest von einem Supporter respawned.");
	SendClientMessage(playerid,COLOR_RED,"ADMIN: {FFFFFF} Du hast einen Spieler respawned.");
	format(string,sizeof(string),"ADMIN: {FFFFFF} %s hat den Spieler %s respawned!",getPlayerName(playerid),getPlayerName(pID));
	SendAdminMessage(sInfo[playerid][padminlevel],COLOR_RED, string);
	return 0;	
}


CMD:addequip(playerid,params[])
{
	new i;
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!.");
	if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
	if(sscanf(params,"u",i))return WPM(playerid,"/addequip [playerid]");
	GivePlayerWeapon(i, WEAPON_DEAGLE, 350);
	GivePlayerWeapon(i,WEAPON_SHOTGUN,150);
	GivePlayerWeapon(i,WEAPON_MP5,400);
	GivePlayerWeapon(i,WEAPON_M4,400);
	SetPlayerArmour(i,100);
	SetPlayerHealth(i,100);
	SendClientMessage(i,COLOR_YELLOW,"EVENT: Eventausrütung hinzugefügt.");
	return 1;
}


CMD:fixveh(playerid,params[])
{	new vID;
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!.");
	if(IsPlayerInAnyVehicle(playerid)){
	RepairVehicle(GetPlayerVehicleID(playerid));
	return 1;
	}
	if(sscanf(params,"i",vID))return WPM(playerid,"/fixveh [Fahrzeug ID]");
	RepairVehicle(vID);

	return 1;
}

CMD:arefill(playerid,params[])
{
	new vID;
	if(!isAdmin(playerid,3))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht befugt diesen Befehl zu nutzen.");
	if(sscanf(params,"i",vID))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /arefill [vID]");
	tank[vID]=100;
	return 1;
}

CMD:go(playerid,params[])
{
	new item[128],hID;
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: Du bist kein Admin/Dein Adminrang ist zu niedrig.");
	if(sscanf(params,"s[128]",item))return WPM(playerid,"/go [LS | SF | LV]");
	if(!strcmp(item,"ls",false))
	{
	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,0);
	SetPlayerPos(playerid, 1129.4788,-1457.1837,15.7969);
 	SendClientMessage(playerid, COLOR_RED, "ADMIN: {FFFFFF}Du hast dich erfolgreich nach Los Santos teleportiert.");
	return 1;
	}
	if(!strcmp(item,"sf",false))
	{
	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,0);
	SetPlayerPos(playerid, -2028.7434,137.7347,28.8359);
    SendClientMessage(playerid, COLOR_RED, "ADMIN: {FFFFFF}Du hast dich erfolgreich nach San Fierro teleportiert.");
	return 1;
	}
	if(!strcmp(item,"airls",false))
	{
    SetPlayerVirtualWorld(playerid,0);
	SetPlayerInterior(playerid,0);
	SetPlayerPos(playerid,1958.0535,-2182.1360,13.5469);
    SendClientMessage(playerid, COLOR_RED, "ADMIN: {FFFFFF}Du hast dich erfolgreich zum LS Airport teleportiert.");
	return 1;
	}
	if(!strcmp(item,"house",false))
	{
	new Float:x,Float:y,Float:z;
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: Du bist kein Admin/Dein Adminrang ist zu niedrig.");
	if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
	x = hInfo[hID][h_x];
	y = hInfo[hID][h_y];
	z = hInfo[hID][h_z];
	SetPlayerPos(playerid,x,y,z);
	SetPlayerVirtualWorld(playerid,0);
    SetPlayerInterior(playerid,0);
	}
	return 0;
}

CMD:gohouse(playerid,params[])
{
	new hID,Float:x,Float:y,Float:z;
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: Du bist kein Admin/Dein Adminrang ist zu niedrig.");
	if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
	if(sscanf(params,"i",hID))return WPM(playerid,"/gohouse [Haus-ID]");
	if(hID > sizeof(hInfo))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Die Haus-ID ist nicht vergeben");
	x = hInfo[hID][h_x];
	y = hInfo[hID][h_y];
	z = hInfo[hID][h_z];
	SetPlayerPos(playerid,x,y,z);
	SetPlayerVirtualWorld(playerid,0);
    SetPlayerInterior(playerid,0);

	return 1;
}

CMD:goto(playerid,params[])
{
	new pID, Float:x,Float:y,Float:z, adminstring[128],str[256],sint,sworld;
    if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!");
    if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
    if(sscanf(params,"u",pID))return WPM(playerid,"/goto [playerid]");
	if(!IsPlayerConnected(pID)) return SendClientMessage(playerid, COLOR_GREY, "Diese Person ist nicht online/du kannst dich nicht zu dir selber teleportieren.");
	GetPlayerPos(pID, x, y, z);
	sint = GetPlayerInterior(pID);
	sworld = GetPlayerVirtualWorld(pID);
	SetPlayerPos(playerid, x, y, z);
	SetPlayerInterior(playerid,sint);
	SetPlayerVirtualWorld(playerid,sworld);
	format(adminstring,sizeof(adminstring),"ADMIN: {FFFA00}Du hast dich zu %s teleportiert.",getPlayerName(pID));
	SendClientMessage(playerid, COLOR_RED, adminstring);
	format(str,sizeof(str),"* %s hat sich zu dir teleportiert.",getPlayerName(playerid));
	SendClientMessage(pID, COLOR_YELLOW, str);
	return 1;
}


CMD:ptp(playerid,params[])
{
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!");
	new pID,si,sw,sID,Float:x,Float:y,Float:z,pname[128],name[128],string[1024],string2[1024],string3[1024],aname[128];
	if(sscanf(params,"ud",pID,sID))return WPM(playerid,"/ptp [spieler1] [spieler2]");
	pname = getPlayerName(pID);
	name = getPlayerName(sID);
	aname = getPlayerName(playerid);
	GetPlayerPos(sID,x,y,z);
	SetPlayerPos(pID,x,y+2,z);
	sw = GetPlayerVirtualWorld(sID);
	si = GetPlayerInterior(sID);
	SetPlayerVirtualWorld(pID,si);
	SetPlayerInterior(pID,sw);
	format(string,sizeof(string),"%s hat dich zu %s teleportiert.",aname,name);
	SendClientMessage(pID,COLOR_YELLOW,string);
	format(string2,sizeof(string2),"%s hat %s zu dir teleportiert.",aname,pname);
	SendClientMessage(sID,COLOR_YELLOW,string2);
	format(string3,sizeof(string3),"Du hast %s zu %s teleportiert.",pname,name);
	SendClientMessage(sID,COLOR_YELLOW,string3);
	return 1;
}



CMD:clearchat(playerid,params[])
{
	if(isAdmin(playerid,2))
	{
	for(new i = 0; i < 150; i++) SendClientMessageToAll(COLOR_GREY," ");
	SendClientMessageToAll(COLOR_RED,"INFO:{FFFFFF} Der Chat wurde von einem Admin geleert! ");
	}
	else return SendClientMessage(playerid,COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
	return 1;
}




CMD:gotocar(playerid,params[])
{
	new vehID, Float:vehX, Float:vehY,Float:vehZ;
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!");
	if(sscanf(params,"i",vehID))return WPM(playerid,"/gotovehicle [vehicleID]");
	if(!IsValidVehicle(vehID))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Diese FahrzeugID ist nicht vergeben.");
	GetVehiclePos(vehID, vehX, vehY, vehZ);
	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,0);
	SetPlayerPos(playerid, vehX, vehY, vehZ+2);
	return 1;
}


CMD:gethere(playerid,params[])
{
	if(!isAdmin(playerid,2))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
	new pID, Float:x, Float:y, Float:z, name[MAX_PLAYER_NAME],nachricht[128],sint,sworld;
	if(sscanf(params,"u",pID))return WPM(playerid,"/gethere [playerid]");
	GetPlayerPos(playerid, x, y, z);
	sint = GetPlayerInterior(playerid);
	sworld = GetPlayerVirtualWorld(playerid);
	SetPlayerPos(pID, x, y, z);
	GetPlayerName(pID, name, sizeof(name));
	SetPlayerVirtualWorld(pID,sworld);
	SetPlayerInterior(pID,sint);
	format(nachricht,sizeof(nachricht),"ADMIN:{FFFFFF} Du hast %s zu dir teleportiert",name);
	SendClientMessage(playerid,COLOR_RED,nachricht);
	return 1;
}

CMD:getherecar(playerid,params[])
{
	if(!isAdmin(playerid,2))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
	new vID, Float:x, Float:y, Float:z, Float:px, Float:py, Float:pz, nachricht[128];
	if(sscanf(params,"i",vID))return WPM(playerid,"/getherevehicle [vID]");
	if(!IsValidVehicle(vID))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Diese FahrzeugID ist nicht vergeben.");
	format(nachricht,sizeof(nachricht),"Du hast den/die %s (%i) zu dir teleportiert",getVehicleName(GetVehicleModel(vID)), vID);
	SendClientMessage(playerid,COLOR_YELLOW,nachricht);
	GetVehiclePos(vID, x, y, z);
	GetPlayerPos(playerid, px, py, pz);
	SetVehiclePos(vID, px, py, pz);
	return 1;
}


CMD:eveh(playerid,params[])
{
	new item[64];
	if(sscanf(params,"s[64]",item))return WPM(playerid,"INFO: /eveh [add|del|delmy|lock|lockmy]");
	if(!strcmp(item, "add", false))
 	{
  	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!");
	ShowPlayerDialog(playerid,DIALOG_VSPAWN,DIALOG_STYLE_LIST,"Eventsystem","Autos/Motorräder\nBoote\nFlugzeuge/Helis\nsonstige","Weiter","Abbrechen");
	return 1;
	}
	return 1;
}


CMD:o(playerid,params[])
{
	new nachricht[256],string[256];
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!");
	if(sscanf(params,"s[256]",nachricht))return WPM(playerid,"/o [nachricht]");
	format(string,sizeof(string),"(( %s: %s ))",getPlayerName(playerid),nachricht);
	SendClientMessageToAll(COLOR_OCHAT,string);
	return 1;
}


CMD:kick(playerid,params[])
{
	new pID, Grund[256];
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!");
	//if(sInfo[pID][padminlevel]>sInfo[playerid][padminlevel])return SendClientMessage(playerid,COLOR_RED,"FEHLER:{FFFFFF} NEIN!");
	if(sscanf(params,"rs[128]",pID,Grund))return WPM(playerid,"/kick [playerid] [Grund]");
	KickEx(playerid,pID,Grund);
	return 1;
}


//wetter für Person
CMD:weather(playerid,params[])
{
	new weather;
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!");
	if(sscanf(params,"i",weather))return SEM(playerid,"Du bist nicht befugt!");
	if(weather < 0||weather > 45) { SendClientMessage(playerid, COLOR_GREY, "Die WetterID muss zwischen 0 und 45 liegen!"); return 1; }
	SetPlayerWeather(playerid,weather);
	return 1;
}

//wetter für Alle
CMD:weatherall(playerid,params[])
{
	new weather;
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!");
	if(sscanf(params,"i",weather))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /weather [weatherid]");
	if(weather < 0||weather > 45) { SendClientMessage(playerid, COLOR_GREY, "Die WetterID muss zwischen 0 und 45 liegen!"); return 1; }
	changeweather();
	CreateDynamicCP(playerid , 0, 0, 0, 5);
	return 1;
}

//WETTER RANDOM
CMD:randweather(playerid,params[])
{
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!");
	changeweather();
	return 1;
}


CMD:finfo(playerid,params[])
{
	new string[1024],fID;
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht befugt diesen Befehl zu nutzen.");
	if(sscanf(params,"i",fID))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /finfo [Fraktions-ID]");
	format(string,sizeof(string),"Fraktion: %s  Kasse: %i  Green: %i  Gold: %i  LSD: %i",fInfo[fID][f_name],fInfo[fID][f_kasse],fInfo[fID][f_green],fInfo[fID][f_gold],fInfo[fID][f_lsd]);
	SendClientMessage(playerid,COLOR_GREEN,"[___________________________Fraktionsinfo___________________________]");
	SendClientMessage(playerid,COLOR_GREY,string);
	return 1;
}

CMD:allfinfo(playerid,params[])
{
	new fID,string[256];
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht befugt diesen Befehl zu nutzen.");
	if(sscanf(params,"i",fID)){
		for(new i=0; i<sizeof(fInfo); i++){
			format(string,sizeof(string),"Fraktion: %s  Kasse: %i  Green: %i  Gold: %i  LSD: %i",fInfo[i][f_name],fInfo[i][f_kasse],fInfo[i][f_green],fInfo[i][f_gold],fInfo[i][f_lsd]);
			SendClientMessage(playerid,COLOR_GREY,string);
		}
	}
	return 1;
}

CMD:setint(playerid,params[])
{
	new string[64],intid;
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF} Du bist nicht befugt diesen Befehl zu benutzen.");
	if(sscanf(params,"i",intid))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /setint [interiorid]");
	SetPlayerInterior(playerid,intid);
	format(string,sizeof(string),"ADMIN: {FFFFFF}Du hast dein Interior auf  %i  gesetzt.",intid);
	SendClientMessage(playerid,COLOR_RED,string);
	return 1;
}

CMD:setpint(playerid,params[])
{
	new intid,pID;
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF} Du bist nicht befugt diesen Befehl zu benutzen.");
	if(sscanf(params,"ui",pID,intid))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /setpint [playerid] [interiorid]");
	SetPlayerInterior(pID,intid);
	return 1;
}

CMD:freeze(playerid,params[])
{
	new pID;
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: Du bist kein Admin/Dein Adminrang ist zu niedrig.");
	if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"INFO: /freeze [playerid]");
	TogglePlayerControllable(pID,false);
	return 1;
}

CMD:unfreeze(playerid,params[])
{
	new pID;
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: Du bist kein Admin/Dein Adminrang ist zu niedrig.");
	if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"INFO: /unfreeze [playerid]");
	TogglePlayerControllable(pID,true);
	return 1;
}

CMD:setvw(playerid,params[])
{
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!");
	new pID,wID;
	if(sscanf(params,"ui",pID,wID))return SendClientMessage(playerid,COLOR_GREY,"INFO: /setworld [playerid] [worldid]");
	SetPlayerVirtualWorld(pID,wID);
	SetPlayerInterior(playerid,0);
	return 1;
}

CMD:setskin(playerid,params[])
{
	new pID,sID;
	if(sscanf(params,"ui",pID,sID))return WPM(playerid,"/setskin [playerid] [skinid]");
	SetPlayerSkin(pID,sID);
	sInfo[pID][pskin]=sID;
	return 1;
}


CMD:spec(playerid,params[])
{
	new pID,string[128];
	if(sscanf(params,"u",pID))return SendClientMessage(playerid,COLOR_GREY,"/spec [playerid]");
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG " Mitglied!");
	if(!IsPlayerConnected(pID)) return SendClientMessage(playerid, COLOR_GREY, "Diese Person ist nicht online.");
	TogglePlayerSpectating(playerid, true);
	PlayerSpectatePlayer(playerid,pID);
	format(string,sizeof(string),"ADMIN: %s beobachtet nun %s .",getPlayerName(playerid),getPlayerName(pID));
	SendAdminMessage(sInfo[playerid][padminlevel],COLOR_YELLOW,string);
	return 1;
}

CMD:specoff(playerid,params[])
{
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG " Mitglied!");
	TogglePlayerSpectating(playerid,false);
	return 1;
}



CMD:ban(playerid,params[])
{
	new pID, Grund[256];
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!");
	if(sscanf(params,"us[256]",pID,Grund))return SendClientMessage(playerid,COLOR_GREY,"/ban [playerid] [Grund]");
	pBan(playerid,pID,Grund);
	return 1;
}




CMD:givecam(playerid,params[])
{
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG " Mitglied!");
	new pID,ammo;
	if(sscanf(params,"ui",pID,ammo))return WPM(playerid,"/givecam [playerid] [Munition]");
    GivePlayerWeapon(pID, WEAPON_CAMERA, ammo);
	return 1;
}


CMD:ainvite(playerid,params[])
{
	new pID,fID,string[128],spawn[64];
	if(!isAdmin(playerid,3))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist kein Admin/dein Adminrang ist zu niedrig.");
	if(sscanf(params,"ri",pID,fID))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /ainvite [playerid] [frakid]");
	sInfo[pID][pfraktion] = fID;
	format(string,sizeof(string),"ADMIN: Du wurdest von %s administrativ in die Fraktion mit der ID %i invitet!",getPlayerName(playerid),fID);
	SendClientMessage(pID, COLOR_YELLOW,string);
	spawn = "fraktion";
	sInfo[pID][pspawnchange] = spawn;
	SpawnPlayer(pID);
	return 1;
}

CMD:auninvite(playerid,params[])
{
	new pID,string[128],zskin,spawn[64];
	zskin = sInfo[pID][pskin];
	if(!isAdmin(playerid,3))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist kein Admin/dein Adminrang ist zu niedrig.");
	if(sscanf(params,"r",pID))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /auninvite [playerid]");
	sInfo[pID][pfraktion] = 0;
	format(string,sizeof(string),"ADMIN: Du wurdest von %s administrativ aus deiner Fraktion uninvitet!",getPlayerName(playerid));
	SendClientMessage(pID, COLOR_YELLOW,string);
	SetPVarInt(pID,"fduty",0);
	spawn = "noob";
	sInfo[pID][pspawnchange] = spawn;
	SetPlayerSkin(pID,zskin);
	SpawnPlayer(pID);
	return 1;
}


CMD:respawnveh(playerid,params[])
{
	new vID;
	if(!isAdmin(playerid,3))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!");
	if(sscanf(params,"i",vID))return WPM(playerid,"/respawnveh [vehicleid]");
	SetVehicleToRespawn(vID);
	return 1;
}

CMD:delveh(playerid,params[])
{
	if(!isAdmin(playerid,3))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!");
	if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
	new vID;
	if(sscanf(params,"i",vID))return WPM(playerid,"/delveh [vID]");
	if(!IsValidVehicle(vID))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Diese FahrzeugID ist nicht vergeben.");
	DestroyVehicle(vID);
	return 1;
}

CMD:fly(playerid,params[])
{
	if(!isAdmin(playerid,3))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!");
	SendClientMessage(playerid,COLOR_RED,"INFO: Der Befehl ist zur Zeit deaktiviert.");
	/*if(IsPlayerInAnyVehicle(playerid))return SendClientMessage(playerid,COLOR_RED,"FEHLER:{FFFFFF} Du kannst diesen Befehl nicht im Fahrzeug nutzen!");
	if(GetPVarType(playerid, "FlyMode")) CancelFlyMode(playerid);
	else FlyMode(playerid);*/
	return 1;
}

CMD:setfill(playerid,params[])
{
	if(!isAdmin(playerid,3))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!");
	new vID,size;
	if(sscanf(params,"ii",vID,size))return WPM(playerid, "/setfill [vID] [Menge]");
	tank[vID]=size;
	return 1;
}

CMD:reviveplayer(playerid,params[])
{
	new pID,string[128];
	if(!isAdmin(playerid,2))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!.");
	if(!isaduty(playerid))return SendClientMessage(playerid, COLOR_RED,"SERVER: {FFFFFF}Du bist nicht berechtigt diesen Befehl zu nutzen.");
	if(sscanf(params,"u",pID))return WPM(playerid,"/reviveplayer [playerid]");
	SetPlayerPos(pID,sInfo[playerid][dx],sInfo[playerid][dy],sInfo[playerid][dz]);
	SendClientMessage(pID,COLOR_YELLOW,"ADMIN: Du wurdest von einem Supporter reanimiert.");
	SendClientMessage(playerid,COLOR_RED,"ADMIN: {FFFFFF} Du hast einen Spieler reanimiert.");
	format(string,sizeof(string),"ADMIN: {FFFFFF} %s hat den Spieler %s reanimiert!",getPlayerName(playerid),getPlayerName(pID));
	SendAdminMessage(sInfo[playerid][padminlevel],COLOR_RED, string);
	return 0;	
}



CMD:sethp(playerid,params[])
{
	new ahp,pID;
	if(!isAdmin(playerid,3))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!");
	if(sscanf(params,"ui",pID,ahp))return SendClientMessage(playerid,COLOR_GREY,"INFO: /sethp [playerid] [HP]");
	SetPlayerHealth(pID, ahp);
	return 1;

}

CMD:setarmour(playerid,params[])
{
	new aarmour, pID;
	if(!isAdmin(playerid,3))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!");
   	if(sscanf(params,"ui",pID,aarmour))return SendClientMessage(playerid,COLOR_GREY,"INFO: /sethp [playerid] [Armour]");
	SetPlayerArmour(pID, aarmour);
	return 1;
}


CMD:deletehouse(playerid, params[])
{
    if(!isAdmin(playerid, 3))return
	    SendClientMessage(playerid, COLOR_RED, "Dein Adminrang ist zu niedrig.");
    for(new i=0; i<sizeof(hInfo); i++)
	{
	    if(!hInfo[i][h_id])continue;
		if(!IsPlayerInRangeOfPoint(playerid, 5,
		    hInfo[i][h_x], hInfo[i][h_y], hInfo[i][h_z]))continue;
		new query[128];
		mysql_format(dbhandle,query,sizeof(query),
		    "DELETE FROM haus WHERE id='%i'", hInfo[i][h_id]);
		mysql_tquery(dbhandle, query);
		hInfo[i][h_x]=0.0;
		hInfo[i][h_y]=0.0;
		hInfo[i][h_z]=0.0;
		hInfo[i][ih_x]=0.0;
		hInfo[i][ih_y]=0.0;
		hInfo[i][ih_z]=0.0;
		hInfo[i][h_id]=0;
		hInfo[i][h_preis]=0;
		hInfo[i][h_interior]=0;
		hInfo[i][h_level]=0;
		if(hInfo[i][h_pickup])
		{
		    DestroyPickup(hInfo[i][h_pickup]);
		}
		if(hInfo[i][h_text])
		{
		    Delete3DTextLabel(hInfo[i][h_text]);
		}
		return 1;
	}
	return 1;
}

CMD:sethouselevel(playerid,params[])
{

    if(!isAdmin(playerid, 3))return
	    SEM(playerid,"Dein Adminrang ist zu niedrig.");
	new tmp_level;
	if(sscanf(params, "i", tmp_level))return
	    WPM(playerid, "/sethouselevel [level]");
    for(new i=0; i<sizeof(hInfo); i++)
	{
	    if(!hInfo[i][h_id])continue;
		if(!IsPlayerInRangeOfPoint(playerid, 5,
		    hInfo[i][h_x], hInfo[i][h_y], hInfo[i][h_z]))continue;
		hInfo[i][h_level] = tmp_level;
		saveHaus(i);
		updateHaus(i);
		return 1;
	}
	return 1;
}

CMD:sethouseinterior(playerid,params[])
{

    if(!isAdmin(playerid, 3))return
    SEM(playerid,"Dein Adminrang ist zu niedrig.");
	new tmp_int,hID;
	if(sscanf(params, "ii",hID,tmp_int))return
    WPM(playerid,"/sethouseinterior [House-ID] [interior-ID]");
	hInfo[hID][h_interior] = tmp_int;
	saveHaus(hID);
	updateHaus(hID);
	return 1;
}

CMD:sethouseprice(playerid,params[])
{

    if(!isAdmin(playerid, 3))return
	    SEM(playerid, "Dein Adminrang ist zu niedrig.");
	new tmp_preis;
	if(sscanf(params, "i", tmp_preis))return
	    WPM(playerid,"INFO: /sethouseprice [preis]");
    for(new i=0; i<sizeof(hInfo); i++)
	{
	    if(!hInfo[i][h_id])continue;
		if(!IsPlayerInRangeOfPoint(playerid, 5,
		    hInfo[i][h_x], hInfo[i][h_y], hInfo[i][h_z]))continue;
		hInfo[i][h_preis] = tmp_preis;
		saveHaus(i);
		updateHaus(i);
		return 1;
	}
	return 1;
}



CMD:createhouse(playerid, params[])
{
	if(!isAdmin(playerid, 3))return
	    SEM(playerid, "Dein Adminrang ist zu niedrig.");
	new Float:xc, Float:yc, Float:zc;
	GetPlayerPos(playerid, xc, yc, zc);

	new id=getFreeHausID();
	hInfo[id][h_x]=xc;
	hInfo[id][h_y]=yc;
	hInfo[id][h_z]=zc;
	hInfo[id][ih_x]=0.0;
	hInfo[id][ih_y]=0.0;
	hInfo[id][ih_z]=0.0;
	hInfo[id][h_interior]=0;
	hInfo[id][h_level]=999;
	strmid(hInfo[id][h_besitzer], "", 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
	hInfo[id][h_preis]=1;
	updateHaus(id);
	//In Datenbank abspeichern
	new query[256];
	mysql_format(dbhandle,query, sizeof(query),
		"INSERT INTO haus (h_x, h_y, h_z, ih_x, ih_y, ih_z, h_interior, h_preis) VALUES ('%f', '%f', '%f', '0.0', '0.0', '0.0', '0', '1')",
		xc, yc, zc);
	mysql_tquery(dbhandle, query, "OnHausCreated", "i", id);
	return 1;
}



CMD:asellhouse(playerid, params[])
{
	if(!isAdmin(playerid, 3))return SEM(playerid, "Dein Adminrang ist zu niedrig.");
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	for(new i=0; i<sizeof(hInfo); i++)
	{
	    if(!hInfo[i][h_id])continue;
		if(!IsPlayerInRangeOfPoint(playerid, 5,
		    hInfo[i][h_x], hInfo[i][h_y], hInfo[i][h_z]))continue;
		if(!strlen(hInfo[i][h_besitzer]))continue;
		if(!strcmp(hInfo[i][h_besitzer], name, true))
		{
		    hInfo[i][h_preis]=hInfo[i][h_preis]/2;
			GivePlayerMoney(playerid, hInfo[i][h_preis]);
			strmid(hInfo[i][h_besitzer], "", 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
			updateHaus(i);
			saveHaus(i);
		    return 1;
		}
	}
	return 1;
}

CMD:gotoxyz(playerid,params[])
{
	if(!isAdmin(playerid, 3))return SEM(playerid, "Dein Adminrang ist zu niedrig.");
	new Float:x,Float:y,Float:z;
	if(sscanf(params,"fff",x,y,z))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /gotoxyz [x-pos] [y-pos] [zpos]");
	SetPlayerPos(playerid,x,y,z);
	return 1;
}



/*CMD:givegun(playerid,params[])
{
	if(!isAdmin(playerid,3))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein "#SERVERTAG " Mitglied!");
	new pID,gun,ammo;
	if(sscanf(params,"uii",pID,gun,ammo))return WPM(playerid,"/givegun [playerid] [WaffenID] [Munition]");
    GivePlayerWeapon(pID, gun, ammo);
    return 1;
}*/



CMD:makeleader(playerid,params[])
{
	if(!isAdmin(playerid,4))return SendClientMessage(playerid,COLOR_GREY,"Du bist kein " #SERVERTAG " Mitglied!");
	new pID,fID,string[128];
	if(sscanf(params,"ui",pID,fID))return SendClientMessage(playerid, COLOR_GREY, "INFO: /makeleader [playerid] [frakID]");
	if(fID >= MAX_FRAKS) return SendClientMessage(playerid, COLOR_GREY,"Diese Fraktion existiert nicht.");
	sInfo[pID][pfraktion] = fID;
	sInfo[pID][pfrang] = 6;
	sInfo[pID][pfleader]=fID;
	SetPVarInt(pID,"fduty",0);
	SetPlayerSkin(pID,sInfo[pID][pskin]);
	if(fID == 0){
		new spawn[64];
		spawn = "noob";
		sInfo[pID][pspawnchange] = spawn;
	}
	format(string,sizeof(string),"INFO: %s hat dich zum Leader der Fraktion %s ernannt.",getPlayerName(playerid),fInfo[fID][f_name]);
	SendClientMessage(pID, COLOR_YELLOW, string);
	SendClientMessage(playerid,COLOR_RED,"Du hast einen Spieler zum Leader ernannt.");
	return 1;
}

CMD:showservervehs(playerid,params[]){
	new string[64],c;
	if(!isAdmin(playerid,4))return SEM(playerid,"Du bist kein Admin/dein Adminrang ist zu niedrig.");
	for(new i=0; i<=MAX_VEHICLES; i++)
	{
		if(IsValidVehicle(i)){
			c++;	
		}	
	}
	format(string,sizeof(string),"Auf dem Server befinden sich %i Fahrzeuge.",c);
	SendClientMessage(playerid,COLOR_GREY,string);
	return 1;
}

CMD:checkspawn(playerid,params[])
{
	new input,output[64];
	if(!isAdmin(playerid,4))return 0;
	if(sscanf(params,"r",input))return SendClientMessage(playerid,COLOR_GREY,"FEHLER: /checkspawn [playerid]");
	format(output,sizeof(output),"Name: %s Spawn: %s",getPlayerName(input),sInfo[input][pspawnchange]);
	SendClientMessage(playerid,COLOR_GREY,output);
	return 1;
}

CMD:settime(playerid,params[])
{
	new time,string[128];
	if(sscanf(params,"i",time))return SendClientMessage(playerid,COLOR_GREY,"INFO: /settime [Uhrzeit]");
	SetWorldTime(time);
	format(string,sizeof(string),"ADMIN:{FFFFFF} ServerOwner %s hat die Uhrzeit auf %i:00 Uhr gesetzt",getPlayerName(playerid),time);
	SendClientMessageToAll(COLOR_RED,string);
	return 1;
}

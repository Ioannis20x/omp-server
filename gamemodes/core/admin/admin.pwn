//---------[ kick ]---------
stock KickEx(adminID,kickid,reason[256])
{
	new string[128];
	format(string,sizeof(string),"AdmCMD: %s wurde von %s vom Server gekickt. Grund: %s",getPlayerName(kickid),getPlayerName(adminID),reason);
   	SendClientMessage(kickid,COLOR_HRED,string);
	SendClientMessageToAll(COLOR_HRED,string);
	format(string,sizeof(string),"AdmCMD: %s wurde von %s vom Server gekickt. Grund: %s",getPlayerName(kickid),getPlayerName(adminID),reason);
	printf(string);
	Kick(kickid);
	return 1;
}

stock pBan(adminID,banid,reason[256])
{
	new gstring[128],pstring[128],dstring[256];
	format(gstring,sizeof(gstring),"AdmCMD: %s wurde von %s vom Server gebannt. Grund: %s",getPlayerName(banid),getPlayerName(adminID),reason);
	SendClientMessageToAll(COLOR_HRED,gstring);
	format(pstring,sizeof(pstring),"AdmCMD: Du wurdest vom Server gebannt. Grund: %s",reason);
	SendClientMessage(banid,COLOR_HRED,pstring);
	format(dstring,sizeof(dstring),"Du wurdest von %s vom Server gebannt.\n\nGrund: %s\n\nFür weitere Fragen oder Einspruch melde dich im Support auf Discord.",getPlayerName(adminID),reason);
	ShowPlayerDialog(banid, 78542, DIALOG_STYLE_MSGBOX, #SERVERTAG , dstring, "Okay", "");
	Ban(banid);
	return 1;	
}

stock changeweather(){

	new wID = random(sizeof(weatherids));
	SetWeather(weatherids[wID]);
	print("WETTERÄNDERUNG");
	SendClientMessageToAll(COLOR_ORANGE,"NR Bot: Es liegt eine Wetteränderung in ganz San Andreas vor.");
	return 1;
}

stock isAdmin(playerid,a_level)
{
	if(sInfo[playerid][padminlevel]>=a_level)return 1;
	return 0;
}

stock isAlevel(playerid, a_level)
{
	if(sInfo[playerid][padminlevel]==a_level)return 1;
	return 0;
}

stock isaduty(playerid)
{
	if(isAdmin(playerid,5)&& GetPVarInt(playerid,"aduty")<=1)return 0;
	else if(GetPVarInt(playerid,"aduty")==1)return 1;
	else if(isAdmin(playerid,5)&& GetPVarInt(playerid,"aduty")>1)return 1;
	return 0;
}



stock SendAdminMessage(adminlvl, color,  const string[])
{
	for(new i = 0 ; i < MAX_PLAYERS ; i++)
	{
	    if(IsPlayerConnected(i) && sInfo[i][eingeloggt] == 1)
	    {
	        if(sInfo[i][padminlevel] >= adminlvl)
	        {
	            SendClientMessage(i, color, string);
			}
	    }
	}
	return 1;
}


stock SendTeamMessage(color, const string[])
{
	for(new i = 0 ; i < MAX_PLAYERS ; i++)
	{
	    if(IsPlayerConnected(i) && sInfo[i][eingeloggt] == 1)
	    {
	        if(sInfo[i][padminlevel] >= 1)
	        {
	            SendClientMessage(i, color, string);
			}
	    }
	}
	return 1;
}



stock AdminRank(playerid){

	new res[32]="";
	switch(sInfo[playerid][padminlevel])
	{
		case 1: res = "Supporter";
		case 2: res = "Moderator";
		case 3: res = "Administrator";
		case 4: res = "Super Administrator";
		case 5: res = "Management";
		case 6: res = "Serverowner";
	}

	return res;
}

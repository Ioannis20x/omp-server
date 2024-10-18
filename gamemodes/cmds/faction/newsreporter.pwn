CMD:setol(playerid,params[])
{
	new pID,string[128],smstring[128];
	if(!isPlayerInFrak(playerid,9))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist kein Newsreporter.");
	if(sscanf(params,"u",pID))return WPM(playerid,"/setol [playerid]");
	if(isPlayerInFrak(pID,9))return SendClientMessage(playerid,COLOR_GREY,"Fraktionsmitglieder k?nnen nicht auf die schwarze Liste gesetzt werden.");
	if(!IsPlayerConnected(pID)) return SendClientMessage(playerid, COLOR_GREY, "Diese Person ist nicht online.");
	sInfo[pID][pOL]=1;
	format(string,sizeof(string),"%s hat dich auf die Orangelist gesetzt.",getPlayerName(playerid));
	format(smstring,sizeof(smstring),"%s hat %s auf die Orangelist gesetzt.",getPlayerName(playerid),getPlayerName(pID));
	SendFrakMessage(sInfo[playerid][pfraktion],COLOR_YELLOW,smstring);
	SendClientMessage(pID,COLOR_YELLOW,string);
	return 1;
}


CMD:orangelist(playerid,params[])
{
	if(!isPlayerInFrak(playerid,9))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist kein Newsreporter.");

	new string[128];
	SendClientMessage(playerid,COLOR_HBLUE,"Übersicht Orangelist:");
	for(new i = 0 ; i < MAX_PLAYERS ; i++)
		{
		    if(IsPlayerConnected(i) && sInfo[i][eingeloggt] == 1)
		    {
		        if(sInfo[i][pOL] == 1)
		        {
		        format(string,sizeof(string),"%s",getPlayerName(i));
	         	SendClientMessage(playerid, COLOR_YELLOW, string);
				}
		    }
		}
	return 1;
}


CMD:delol(playerid,params[])
{
	new pID, string[128],smstring[128];
	if(!isPlayerInFrak(playerid,9))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist kein Newsreporter.");
	if(sscanf(params,"u",pID))return WPM(playerid,"/delol [playerid]");
	if(!isPlayerOnOrangelist(pID))return SendClientMessage(playerid,COLOR_GREY,"Die Person befindet sich nicht auf der Orangelist.");
	sInfo[pID][pOL]=0;
	format(smstring,sizeof(smstring),"%s hat %s von der Orangelist gel?scht.",getPlayerName(playerid),getPlayerName(pID));
	SendFrakMessage(sInfo[playerid][pfraktion],COLOR_YELLOW,smstring);
	format(string,sizeof(string),"%s hat dich von der Orangelist gel?scht.",getPlayerName(playerid));
	SendClientMessage(pID,COLOR_YELLOW,string);
	return 1;
}




CMD:news(playerid,params[])
{
	new string[256],hour,minute,second;
	if(!isPlayerInFrak(playerid,9))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist kein Newsreporter.");
	if(GetPVarInt(playerid,"fduty")!=1)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht im Dienst.");
	if(sscanf(params,"s[128]",string))return WPM(playerid,"/news [Newstext]");
	format(string,sizeof(string),"NR %s: %s",getPlayerName(playerid),string);
	gettime(hour, minute,second);
	if(hour > 15 && hour < 22)
	{
	SendFrakMessage(9,COLOR_ORANGE,"REICHWEITE:{FFFFFF} Das Ausstrahlen von Nachrichten hat eure Reichweite gesteigert! ( +1EP )");
	fInfo[9][ep] +=1;
	}
	SendClientMessageToAll(COLOR_ORANGE,string);
	return 1;
}

CMD:duty(playerid,params[])
{
new fID = sInfo[playerid][pfraktion];
if(GetPVarInt(playerid,"fduty")==0)
{
switch (fID)
{
	case 0:
	{
	SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist in keiner Fraktion.");
	}
	case 1:
	{
	//SAPD Duty
	if(IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz])){
	SendClientMessage(playerid,COLOR_INFO,"INFO: {FFFFFF}Du bist nun als Beamter des SA:PD im Dienst.");
	SetPlayerSkin(playerid,sInfo[playerid][pfSkin]);
	SetPVarInt(playerid,"fduty",1);
	SetPlayerColor(playerid,COLOR_BLUE);
	return 1;
	}}
	case 2:
	{
	//FBI DUTY
	if(IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz]))
	{
	SendClientMessage(playerid,COLOR_INFO,"INFO: {FFFFFF}Du bist nun als Agent des FBI im Dienst.");
	SetPVarInt(playerid,"fduty",1);
	SetPlayerSkin(playerid,sInfo[playerid][pfSkin]);
	SetPlayerColor(playerid,COLOR_FBI);
 	return 1;
	}}
	case 3:
	{
	//Army Duty
	if(IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz]))
	{
	SendClientMessage(playerid,COLOR_INFO,"INFO: {FFFFFF}Du bist nun als Soldat der SA:Army im Dienst.");
	SetPlayerSkin(playerid,sInfo[playerid][pfSkin]);
	SetPVarInt(playerid,"fduty",1);
	SetPlayerColor(playerid,COLOR_GREEN);
	return 1;
	}}
	case 4:
	{
    if(IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz]))
	{
	//MEIDCS Duty
	SendClientMessage(playerid,COLOR_INFO,"INFO: {FFFFFF}Du bist nun als Arzt im Dienst.");
	SetPVarInt(playerid,"fduty",1);
	SetPlayerSkin(playerid,sInfo[playerid][pfSkin]);
	SetPlayerColor(playerid,COLOR_PINK);
	return 1;
	}}
	case 7:
	{
    if(IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz]))
	{
	//REGIERUNG Duty
	SetPlayerSkin(playerid,sInfo[playerid][pfSkin]);
	SendClientMessage(playerid,COLOR_INFO,"INFO: {FFFFFF}Du bist nun als Beamter der Regierung im Dienst.");
	SetPVarInt(playerid,"fduty",1);
	SetPlayerColor(playerid,fbase[fID][f_color]);
	return 1;
	}}
	case 9:
	{
    if(/*isPlayerinSAMAGCARS(playerid) && GetPVarInt(playerid,"fduty")==0 || */IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz]))
	{
	//SAM AG Duty
	SetPlayerSkin(playerid,sInfo[playerid][pfSkin]);
	SendClientMessage(playerid,COLOR_INFO,"INFO:{FFFFFF} Du bist nun als Reporter der SAM:AG verf?gbar.");
	sInfo[playerid][ptazer]=10;
	SetPVarInt(playerid,"fduty",1);
	SetPlayerColor(playerid,fbase[fID][f_color]);
	return 1;
	}}
	case 18:
	{
	if(IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz]))
	{
	//DMV Duty
	SetPlayerSkin(playerid,sInfo[playerid][pfSkin]);
	new string[128];
	format(string,sizeof(string),"DMV-Mitarbeiter %s ist nun im Dienst. (/fahrlehrer)",getPlayerName(playerid));
	SendClientMessage(playerid,COLOR_INFO,"REGIERUNG: {FFFFFF}Du bist nun als Fahrlehrer im Dienst.");
	SetPVarInt(playerid,"fduty",1);
	sInfo[playerid][ptazer]=10;
	SetPlayerColor(playerid,fbase[fID][f_color]);
	SendClientMessageToAll(COLOR_GREEN,string);
	return 1;
	}}
 	case 19:
	{
    if(IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz]))
	{
	//Taxi Team
	SetPlayerSkin(playerid,sInfo[playerid][pfSkin]);
	new string[128];
	format(string,sizeof(string),"SA-Taxi Team: %s ist nun als Taxifahrer im Dienst. (/taxifahrer)",getPlayerName(playerid));
	SendClientMessage(playerid,COLOR_INFO,"INFO:{FFFFFF} Du bist nun als Taxifahrer der SA:TT verfügbar.");
	sInfo[playerid][ptazer]=10;
	SetPVarInt(playerid,"fduty",1);
	SetPlayerColor(playerid,fbase[fID][f_color]);
	SendClientMessageToAll(COLOR_GREEN,string);
	return 1;
	}}
	default:
	{
	SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht am Dutypunkt deiner Fraktion.");
	return 1;
	}
}
}
else if(GetPVarInt(playerid,"fduty")==1)
{
    switch (fID)
{
	case 0:
	{
	SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist in keiner Fraktion.");
	}
	case 1:
	{
	//SAPD offDuty
	if(IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz])){
	SendClientMessage(playerid,COLOR_INFO,"INFO: {FFFFFF}Du bist nicht mehr als Beamter des SA:PD im Dienst.");
	SetPVarInt(playerid,"fduty",0);
	SetPlayerColor(playerid,COLOR_WHITE);
    SetPlayerSkin(playerid,sInfo[playerid][pskin]);
	return 1;
	}}
	case 2:
	{
	//FBI offDUTY
	if(IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz]))
	{
	SendClientMessage(playerid,COLOR_INFO,"INFO: {FFFFFF}Du bist nicht mehr als Agent des FBI im Dienst.");
	SetPVarInt(playerid,"fduty",0);
	SetPlayerColor(playerid,COLOR_WHITE);
    SetPlayerSkin(playerid,sInfo[playerid][pskin]);
 	return 1;
	}}
	case 3:
	{
	//Army Duty
	if(IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz]))
	{
	SendClientMessage(playerid,COLOR_INFO,"INFO: {FFFFFF}Du bist nicht mehr als Soldat der SA:Army im Dienst.");
	SetPVarInt(playerid,"fduty",0);
	SetPlayerColor(playerid,COLOR_WHITE);
    SetPlayerSkin(playerid,sInfo[playerid][pskin]);
 	return 1;
	}}
	case 4:
	{
    if(IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz]))
	{
	//MEIDCS Duty
	SendClientMessage(playerid,COLOR_INFO,"INFO: {FFFFFF}Du bist nicht mehr als Arzt im Dienst.");
	SetPVarInt(playerid,"fduty",0);
    SetPlayerSkin(playerid,sInfo[playerid][pskin]);
	SetPlayerColor(playerid,COLOR_WHITE);
 	return 1;
	}}
	case 7:
	{
    if(IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz]))
	{
	//REGIERUNG Duty
	SetPlayerSkin(playerid,sInfo[playerid][pskin]);
	SendClientMessage(playerid,COLOR_INFO,"INFO: {FFFFFF}Du bist nicht mehr als Beamter der Regierung im Dienst.");
	SetPVarInt(playerid,"fduty",0);
	SetPlayerColor(playerid,COLOR_WHITE);
 	return 1;
	}}
	case 9:
	{
    if(/*isPlayerinSAMAGCARS(playerid) || */IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz]))
	{
	//SAM AG Duty
	SetPlayerSkin(playerid,sInfo[playerid][pskin]);
	SendClientMessage(playerid,COLOR_INFO,"INFO:{FFFFFF} Du bist nicht mehr als Reporter der SAM:AG verfügbar.");
	SetPVarInt(playerid,"fduty",0);
	SetPlayerColor(playerid,COLOR_WHITE);
 	return 1;
	}}
	case 18:
	{
	if(IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz]))
	{
	//DMV Duty
	SetPlayerSkin(playerid,sInfo[playerid][pskin]);
	SendClientMessage(playerid,COLOR_INFO,"REGIERUNG: {FFFFFF}Du bist nicht mehr als Fahrlehrer im Dienst.");
	SetPVarInt(playerid,"fduty",0);
	SetPlayerColor(playerid,COLOR_WHITE);
 	return 1;
	}}
	case 19:
	{
	if(IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz]))
	{
	//SA:TT Duty
	SetPlayerSkin(playerid,sInfo[playerid][pskin]);
	SendClientMessage(playerid,COLOR_INFO,"SA:TT: {FFFFFF}Du bist nicht mehr als Taxifahrer im Dienst.");
	SetPVarInt(playerid,"fduty",0);
	SetPlayerColor(playerid,COLOR_WHITE);
 	return 1;
	}}
	default:
	{
 	SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht am Dutypunkt deiner Fraktion.");
 	return 1;
	}
}
}
return 1;
}



CMD:suspend(playerid,params[])
{
	new pID,zskin,string[128];
	zskin = sInfo[pID][pskin];
	if(!isLeader(playerid))	return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist kein Leader einer Fraktion!");
	if(sscanf(params,"r",pID))return WPM(playerid,"/setfskin [playerid]");
	if(sInfo[playerid][pfleader] != sInfo[pID][pfraktion])return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Diese Person ist nicht in deiner Fraktion");
	if(GetPVarInt(pID,"fduty")==0)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Die Person befindet sich nicht im Dienst!");
	SetPlayerSkin(pID,zskin);
	SetPVarInt(pID,"fduty",0);
	format(string,sizeof(string),"DUTY: {FFFFFF}Du wurdest von %s suspendiert.",getPlayerName(playerid));
	SendClientMessage(playerid,COLOR_YELLOW,string);
	return 0;
}


CMD:mv(playerid,params[])
{
	new Float:x,Float:y,Float:z;
	new Float:pdx1,Float:pdy1,Float:pdz1;
	new Float:pdx2,Float:pdy2,Float:pdz2;

	//PDschranke
	GetObjectRot(pdschranke,pdx1,pdy1,pdz1);
	if((IsPlayerInRangeOfPoint(playerid,7,1544.3229,-1627.3604,13.3828)) && (pdy1>=90) && (isPlayerinStaat(playerid))){

		MoveObject(pdschranke,1544.68542, -1630.81384, 13.14560,0.60,0.00000, 0.00000, 90.00000);
		GetObjectRot(pdschranke,pdx1,pdy1,pdz1);
	}
	else if(pdy1<=90 && IsPlayerInRangeOfPoint(playerid,7,1544.8815,-1626.7957,13.3828) && isPlayerinStaat(playerid)){
	MoveObject(pdschranke,1544.68542, -1630.81384, 13.14560,0.60,0.00000, 90.00000, 90.00000);
	}

	//PDTOR
	GetObjectPos(pdtor,pdx2,pdy2,pdz2);
	if(IsPlayerInRangeOfPoint(playerid,8, 1588.1302,-1638.4545,13.3697) && isPlayerinStaat(playerid) && pdx2==1584.70374){
	MoveObject(pdtor,1592.6037,-1637.8916,12.56050,2.00,0.0,0.0,0.0);
	GetObjectPos(pdtor,pdx2,pdy2,pdz2);
	}
	else if(IsPlayerInRangeOfPoint(playerid,8, 1588.1302,-1638.4545,13.3697) && isPlayerinStaat(playerid) && pdx2==1592.6037){
	MoveObject(pdtor,1584.70374, -1637.87158, 12.56050,2.00,0.0,0.0,0.0);
	}

	//Pillonen Pier
	if(!IsPlayerInRangeOfPoint(playerid, 10.0, 371.16800, -2038.30005, 6.2000)) {
	}
	else{
	GetObjectPos(p1, x, y, z);
	if(z !=6.200){
	MoveObject(p1, 371.16800, -2038.30005, 6.2000,1.000, 0.0000, 0.0000, 10);
	MoveObject(p2, 369.82370, -2038.30005, 6.2000,1.0000, 0.0000, 0.0000, 10);
	MoveObject(p3, 368.36111, -2038.30005, 6.2000,1.0000, 0.0000, 0.0000, 10);
	}
	else{
	MoveObject(p1, 371.16800, -2038.30005, 7.24000,1.000, 0.0000, 0.0000, 10);
	MoveObject(p2, 369.82370, -2038.30005, 7.2400,1.0000, 0.0000, 0.0000, 10);
	MoveObject(p3, 368.36111, -2038.30005, 7.2400,1.0000, 0.0000, 0.0000, 10);
	}}
	return 1;
}

CMD:equip(playerid,params[])
{
	new fID = sInfo[playerid][pfraktion];

	switch (fID)
	{
		case 0:
		{
		SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist in keiner Fraktion.");
		}
		case 1:
		{
		//SAPD Duty
		if(IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz])){
		SendClientMessage(playerid,COLOR_GREEN,"ERFOLG: {FFFFFF}Du hast dich für den Dienst ausgerüstet!");
		GivePlayerWeapon(playerid,WEAPON_M4,500);
		GivePlayerWeapon(playerid,WEAPON_NITESTICK,1);
		staatsequip(playerid);
		SetPlayerArmour(playerid,100);
		return 1;
		}}
		case 2:
		{
		//FBI DUTY
		if(IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz]))
		{
		SendClientMessage(playerid,COLOR_GREEN,"ERFOLG: {FFFFFF}Du hast dich für den Dienst ausgerüstet!");
		staatsequip(playerid);
		SetPlayerArmour(playerid,100);
	 	return 1;
		}}
		case 3:
		{
		//Army Duty
		if(IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz]))
		{
		SendClientMessage(playerid,COLOR_GREEN,"ERFOLG: {FFFFFF}Du hast dich für den Dienst ausgerüstet!");
		staatsequip(playerid);
		SetPlayerColor(playerid,COLOR_GREEN);
		SetPlayerArmour(playerid,100);
		return 1;
		}}
		case 4:
		{
	    if(IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz]))
		{
		//MEIDCS Duty
		SendClientMessage(playerid,COLOR_GREEN,"ERFOLG: {FFFFFF}Du hast dich für den Dienst ausgerüstet!");
		GivePlayerWeapon(playerid,WEAPON_M4,500);
		sInfo[playerid][ptazer]=10;
		SetPlayerArmour(playerid,100);
		return 1;
		}}
		case 7:
		{
	    if(IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz]))
		{
			if(sInfo[playerid][pfrang]>=5)GivePlayerWeapon(playerid,WEAPON_SPRAYCAN,500);				
			else {GivePlayerWeapon(playerid,WEAPON_SPRAYCAN,500);
				  GivePlayerWeapon(playerid,WEAPON_SHOVEL,1);}
			//REGIERUNG Duty
		   	SendClientMessage(playerid,COLOR_GREEN,"ERFOLG: {FFFFFF}Du hast dich für den Dienst ausgerüstet!");
			SetPlayerArmour(playerid,100);
			return 1;
		}}
		case 9:
		{
	    if(/*isPlayerinSAMAGCARS(playerid) && GetPVarInt(playerid,"fduty")==0 ||*/ IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz]))
		{
		//SAM AG Duty
		SendClientMessage(playerid,COLOR_GREEN,"ERFOLG: {FFFFFF}Du hast dich für den Dienst ausgerüstet!");
		GivePlayerWeapon(playerid,WEAPON_BAT,1);
		GivePlayerWeapon(playerid,WEAPON_CAMERA,100);
		sInfo[playerid][ptazer]=10;
		SetPlayerArmour(playerid,100);
		return 1;
		}}
		case 18:
		{
		if(IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz]))
		{
		SendClientMessage(playerid,COLOR_GREEN,"ERFOLG: {FFFFFF}Du hast dich für den Dienst ausgerüstet!");
		//DMV Duty
		GivePlayerWeapon(playerid,WEAPON_SPRAYCAN,500);
		sInfo[playerid][ptazer]=10;
		SetPlayerArmour(playerid,100);
		return 1;
		}}
		case 19:
		{
		if(IsPlayerInRangeOfPoint(playerid,3.0,fbase[fID][f_dutyx],fbase[fID][f_dutyy],fbase[fID][f_dutyz]))
		{
		SendClientMessage(playerid,COLOR_GREEN,"ERFOLG: {FFFFFF}Du hast dich für den Dienst ausgerüstet!");
		//SA:TT Duty
		GivePlayerWeapon(playerid,WEAPON_M4,500);
		sInfo[playerid][ptazer]=10;
		SetPlayerArmour(playerid,100);
		return 1;
		}}
		default:
		{
		SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht am Equippunkt deiner Fraktion.");
		return 1;
		}

	}
	SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht am Equippunkt deiner Fraktion.");
	return 1;
}


//showfmotd
CMD:showfmotd(playerid,params[])
{
	new string[128];
	if(sInfo[playerid][pfleader]==0)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist kein Leader!");
	format(string,sizeof(string),"FMOTD: %s",fInfo[sInfo[playerid][pfraktion]][fmotd]);
	SendClientMessage(playerid,COLOR_YELLOW,string);
	return 1;
}


//fmotd
CMD:fmotd(playerid,params[])
{
	new string[128];
	new fID = sInfo[playerid][pfraktion];
	if(sInfo[playerid][pfleader]==0)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist kein Leader einer Fraktion");
	if(sscanf(params,"s[128]",fInfo[fID][fmotd]))WPM(playerid,"/fmotd [text]");
	format(string,sizeof(string),"LEADER: Du hast die FMOTD deiner Fraktion geändert");
	SendClientMessage(playerid,COLOR_YELLOW,string);
	return 1;
}


CMD:f(playerid,params[])
{
	new string[1024];
	new input[75];
	new rank[128]="SNNES";
	if(isPlayerinStaat(playerid) || sInfo[playerid][pfraktion]==0)return SEM(playerid,"Du bist nicht befugt!");
	if(sscanf(params,"s[75]",input))return WPM(playerid,"/r [nachricht]");
	new frank = sInfo[playerid][pfrang];
	new fID = sInfo[playerid][pfraktion];
	switch (frank){
		case 0: {format(rank,sizeof(rank),"%s",fInfo[fID][rangnull]);}
		case 1: {format(rank,sizeof(rank),"%s",fInfo[fID][rangeins]);}
        case 2: {format(rank,sizeof(rank),"%s",fInfo[fID][rangzwei]);}
        case 3: {format(rank,sizeof(rank),"%s",fInfo[fID][rangdrei]);}
        case 4: {format(rank,sizeof(rank),"%s",fInfo[fID][rangvier]);}
        case 5: {format(rank,sizeof(rank),"%s",fInfo[fID][rangfunf]);}
        case 6: {format(rank,sizeof(rank),"%s",fInfo[fID][rangsechs]);}
	}
	format(string,sizeof(string),"** %s %s: %s.))**",rank,getPlayerName(playerid),input);
	for(new i =0; i<MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i))continue;
		if(!isPlayerInFrak(i,fID))continue;
		SendClientMessage(i,COLOR_RCHAT,string);
		PlayerPlaySound(i, 3401, 0.0, 0.0, 10.0);

	}
	return 1;
}
//d chat
CMD:d(playerid,params[])
{
	new string[256];
	new rank[128];
	if(!isPlayerinStaat(playerid))return SendClientMessage(playerid,COLOR_RED,"FEHLER:{FFFFFF} Du bist nicht befugt!");
	if(sscanf(params,"s[128]",string))return WPM(playerid, "/d [nachricht]");
	new fID = sInfo[playerid][pfraktion];
	new frank = sInfo[playerid][pfrang];
	switch (frank){
		case 0: {format(rank,sizeof(rank),"%s",fInfo[fID][rangnull]);}
		case 1: {format(rank,sizeof(rank),"%s",fInfo[fID][rangeins]);}
        case 2: {format(rank,sizeof(rank),"%s",fInfo[fID][rangzwei]);}
        case 3: {format(rank,sizeof(rank),"%s",fInfo[fID][rangdrei]);}
        case 4: {format(rank,sizeof(rank),"%s",fInfo[fID][rangvier]);}
        case 5: {format(rank,sizeof(rank),"%s",fInfo[fID][rangfunf]);}
        case 6: {format(rank,sizeof(rank),"%s",fInfo[fID][rangsechs]);}
	}
	format(string,sizeof(string),"**%s %s: %s.))**",rank,getPlayerName(playerid),string);
	for(new i =0; i<MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i))continue;
		if(!isPlayerinStaat(i))continue;
		SendClientMessage(i,COLOR_DCHAT,string);
		PlayerPlaySound(i, 3401, 0.0, 0.0, 10.0);
	}
	return 1;
}

//epbonus
CMD:epbonus(playerid,params[])
{
if(isPlayerInFrak(playerid,0))return SendClientMessage(playerid,COLOR_WHITE,"Du bist nicht in einer Fraktion.");
new string[128];
new fID = sInfo[playerid][pfraktion];
format(string,sizeof(string),"REPUTATION: {FFFFFF}Deine Fraktion besitzt derzeit %i Einflusspunkte.",fInfo[fID][ep]);
SendClientMessage(playerid,COLOR_YELLOW,string);
return 1;
}


CMD:r(playerid,params[])
{
	new string[1024];
	new input[75];
	new rank[128]="SNNES";
	if(!isPlayerinStaat(playerid))return SEM(playerid,"Du bist nicht befugt!");
	if(sscanf(params,"s[75]",input))return WPM(playerid,"/r [nachricht]");
	new frank = sInfo[playerid][pfrang];
	new fID = sInfo[playerid][pfraktion];
	switch (frank){
		case 0: {format(rank,sizeof(rank),"%s",fInfo[fID][rangnull]);}
		case 1: {format(rank,sizeof(rank),"%s",fInfo[fID][rangeins]);}
        case 2: {format(rank,sizeof(rank),"%s",fInfo[fID][rangzwei]);}
        case 3: {format(rank,sizeof(rank),"%s",fInfo[fID][rangdrei]);}
        case 4: {format(rank,sizeof(rank),"%s",fInfo[fID][rangvier]);}
        case 5: {format(rank,sizeof(rank),"%s",fInfo[fID][rangfunf]);}
        case 6: {format(rank,sizeof(rank),"%s",fInfo[fID][rangsechs]);}
	}	/*
	if(frank == 0){
	format(rank,sizeof(rank),"%s",fInfo[fID][rangnull]);
	return 1;
	}if(frank == 1){
    format(rank,sizeof(rank),"%s",fInfo[fID][rangsechs]);
	return 1;
	} if(frank == 2){
    format(rank,sizeof(rank),"%s",fInfo[fID][rangsechs]);
    return 1;
	} if(frank == 3){
    format(rank,sizeof(rank),"%s",fInfo[fID][rangsechs]);
    return 1;
	} if(frank == 4){
    format(rank,sizeof(rank),"%s",fInfo[fID][rangsechs]);
    return 1;
	} if(frank == 5){
 	format(rank,sizeof(rank),"%s",fInfo[fID][rangsechs]);
    return 1;
	} if(frank == 6){
    format(rank,sizeof(rank),"%s",fInfo[fID][rangsechs]);
    return 1;
	}*/
	format(string,sizeof(string),"** %s %s: %s.))**",rank,getPlayerName(playerid),input);
	for(new i =0; i<MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i))continue;
		if(!isPlayerInFrak(i,fID))continue;
		SendClientMessage(i,COLOR_RCHAT,string);
		PlayerPlaySound(i, 3401, 0.0, 0.0, 10.0);

	}
	return 1;
}


CMD:invite(playerid,params[])
{
	if(isPlayerInFrak(playerid, 0))return SEM(playerid, "Du bist in keiner Fraktion.");
	if(sInfo[playerid][pfleader] == 0)return SEM(playerid,"Du bist kein Leader einer Fraktion.");
	new pID;
	if(sscanf(params,"u",pID))return WPM(playerid,"/invite [playerid]");
	if(!isPlayerInFrak(pID,0))return SEM(playerid,"Der Spieler ist bereits in einer Fraktion");
	new string[128],fID;
	fID = sInfo[playerid][pfraktion];
	format(string,sizeof(string),"%s hat dich gefragt ob du die Fraktion %s betreten willst.",getPlayerName(playerid), fInfo[fID][f_name]);
	SendClientMessage(pID, COLOR_ORANGE,string);
	SendClientMessage(pID,COLOR_WHITE,"Gib /annehmen oder /abbrechen ein. Diese Anfrage verfüllt automatisch in 60 Sekunden.");
	SetPVarInt(pID,"inv_frakid",fID);
	SetPVarInt(pID,"inv_inviter",playerid);
	return 1;
}


CMD:uninvite(playerid,params[])
{
	if(isPlayerInFrak(playerid, 0))return SEM(playerid,"Du bist in keiner Fraktion.");
	if(sInfo[playerid][pfleader] == 0)return SEM(playerid,":Du bist kein Leader einer Fraktion.");
	new pID;
	if(sscanf(params,"u",pID))return WPM(playerid,"/uninvite [playerid]");
	if(!isPlayerInFrak(pID,sInfo[playerid][pfraktion]))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Der Spieler ist nicht in deiner Fraktion");
	sInfo[pID][pfraktion] =0;
	sInfo[pID][pfrang] =0;
	new string[128];
	format(string,sizeof(string),"Du wurdest von %s aus der Fraktion geworfen",getPlayerName(playerid));
	SendClientMessage(pID,COLOR_BLUE,string);
	format(string,sizeof(string),"Du hast %s aus der Fraktion geworfen",getPlayerName(pID));
	SendClientMessage(playerid, COLOR_YELLOW,string);
	return 1;
}




CMD:giverank(playerid,params[])
{
	new pID, rank;
	new fID = sInfo[pID][pfraktion];
	if(sInfo[playerid][pfleader] ==0)return SEM(playerid,"Du bist kein Leader!");
	if(sscanf(params,"ui",pID, rank))return WPM(playerid, "/giverank [playerid] [Rang]");
	if(!isPlayerInFrak(playerid,fID))return SEM(playerid,"Der Spieler ist nicht in deiner Fraktion.");
	if((rank >6) || (rank<0))return SEM(playerid,"ungültiger Rang!");
	sInfo[pID][pfrang]=rank;
	SendClientMessage(pID,COLOR_YELLOW,"FRAKTION: Du wurdest befürdert.");
	return 1;
}


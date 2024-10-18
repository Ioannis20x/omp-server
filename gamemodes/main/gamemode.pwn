new stream[128];
new stundentimer;

public OnGameModeInit()
{
 mysql_log(ALL);
 #if defined SERVERPAS
 SendRconCommand("password  " #PASSWORD );
 #endif

 #if defined Weihnachten
 SendRconCommand("hostname "  " | Frohe Weihnachten");
 #else
 SendRconCommand("hostname " #SERVERNAME );
 #endif

	SetGameModeText("German Reallife");
	UsePlayerPedAnims();
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	EnableStuntBonusForAll(false);
	DisableInteriorEnterExits();
	ManualVehicleEngineAndLights();
	CreatePickup(1239,1,1038.0804,-1339.8496,13.7343,0);
	SetTimer ("sekunde",1000,true);
	stundentimer = SetTimer("stunde",3600000,true);
//	SetTimer("FPS", 251, true);
	dbhandle=mysql_connect(DB_HOST,DB_USER,DB_PASS,DB_DB);

	new hour,minute,second;
	gettime(hour,minute,second);
	SetWorldTime(hour);
	
	//Gebäude laden
	loadBizes();

	//Häuser laden
	LoadHouses();

	loadfraks();
	loadJobs();
	loadiraum();
	
	//TEXTDRAWS

	//adutyTD
	aduty_text = TextDrawCreate(575.000000, 55.000000, "Admindienst");
	TextDrawAlignment(aduty_text, TEXT_DRAW_ALIGN_CENTER);
	TextDrawBackgroundColour(aduty_text, 255);
	TextDrawFont(aduty_text, TEXT_DRAW_FONT_1);
	TextDrawLetterSize(aduty_text, 0.280000, 1.000000);
	TextDrawColour(aduty_text, -16776961);
	TextDrawSetOutline(aduty_text, 1);
	TextDrawSetProportional(aduty_text, true);

	//TachoTD
	Tacho = TextDrawCreate(460.000000, 430.000000, "0");

	//KMHTD
	kmhtd = TextDrawCreate(510.000000, 430.000000, "KM/H");
	TextDrawAlignment(kmhtd, TEXT_DRAW_ALIGN_CENTER);
	TextDrawBackgroundColour(kmhtd, 255);
	TextDrawFont(kmhtd, TEXT_DRAW_FONT_1);
	TextDrawLetterSize(kmhtd, 0.500000, 1.000000);
	TextDrawColour(kmhtd, -1);
	TextDrawSetOutline(kmhtd, 0);
	TextDrawSetProportional(kmhtd, true);
	TextDrawSetShadow(kmhtd, 1);
	TextDrawUseBox(kmhtd, false);

	Tachobox = TextDrawCreate(455.000000,455.000000, "_");//tachometer box
	TextDrawUseBox(Tachobox,true);
	TextDrawBoxColour(Tachobox,0x00000067);
	TextDrawBackgroundColour(Tachobox,0x00000067);
	TextDrawTextSize(Tachobox,640,480);
	TextDrawLetterSize(Tachobox,1.000000,-5.000000);
	TextDrawAlignment(Tachobox,TEXT_DRAW_ALIGN_LEFT);


	
	//Uhrzeit
	uhrzeitlabel = TextDrawCreate(549.0000, 14.0000, "00:00");
	TextDrawBackgroundColour(uhrzeitlabel, 255);
	TextDrawFont(uhrzeitlabel, TEXT_DRAW_FONT_3);
	TextDrawLetterSize(uhrzeitlabel, 0.580000, 2.399999);
	TextDrawColour(uhrzeitlabel, -1);
	TextDrawSetOutline(uhrzeitlabel, 1);
	TextDrawSetProportional(uhrzeitlabel, true);



	for(new i=0; i<sizeof(tank); i++)
	{
		tank[i]=100;
	}
	
	//Mapping
	p1 = CreateDynamicObject(1215, 371.16800, -2038.30005, 7.24000,   0.00000, 0.00000, 0.00000);
	p2 = CreateDynamicObject(1215, 369.82370, -2038.30005, 7.24000,   0.00000, 0.00000, 0.00000);
	p3 = CreateDynamicObject(1215, 368.36111, -2038.30005, 7.24000,   0.00000, 0.00000, 0.00000);
	pdschranke=CreateObject(968, 1544.68542, -1630.81384, 13.14560,   0.00000, 90.00000, 90.00000);
	pdtor=CreateObject(976, 1584.70374, -1637.87158, 12.56050,   0.00000, 0.00000, 0.00000);
	
	
	printf("====================================================================");
	printf("Der Server wurde erfolgreich gestartet");
	printf("====================================================================");
	return 1;
}





public OnGameModeExit()
{
	SendClientMessageToAll(COLOR_RED,"SYSTEM: Serverrestart erfolgt jetzt!!!");
	GameTextForAll("Es findet ein ~r~Neustart ~w~ statt!",1000,5);
	savefraks();
	printf("SAVEFRAKS");
	mysql_close(dbhandle);
	printf("SERVER STOPPT");
	return 1;
}




public isPlayerInRangeOfFrakEnterPoint(playerid)
{
    for(new i=0; i<sizeof(fInfo); i++){
		if(!IsPlayerInRangeOfPoint(playerid,1.5,fbase[i][f_enterx],fbase[i][f_entery],fbase[i][f_enterz]))continue;
		SetPlayerInterior(playerid,fbase[i][f_inter]);
		SetPlayerVirtualWorld(playerid,fbase[i][f_world]);
		SetPlayerPos(playerid,fbase[i][f_exitx],fbase[i][f_exity],fbase[i][f_exitz]);
		}
	return 1;
}

public isPlayerInRangeOfFrakExitPoint(playerid)
{
    for(new i=0; i<sizeof(fInfo); i++){
		if(!IsPlayerInRangeOfPoint(playerid,1.5,fbase[i][f_exitx],fbase[i][f_exity],fbase[i][f_exitz]))continue;
		SetPlayerPos(playerid,fbase[i][f_enterx],fbase[i][f_entery],fbase[i][f_enterz]);
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid,0);
		}
	return 1;
}


public sekunde()
{
	if(GetTimerRemaining(stundentimer) == 1800000){
	SendClientMessageToAll(COLOR_WHITE,"[============ SERVERINFO ============]");
	SendClientMessageToAll(COLOR_BLUE,"Ab sofort existiert ein Discord für diesen Server.");
	SendClientMessageToAll(COLOR_BLUE,"In diesem werden Changelogs gepostet, Fragen beantwortet und Vorschläge entgegen genommen.");
	SendClientMessageToAll(COLOR_BLUE,"Falls du eine Idee für den Server hast oder einfach nur auf dem neusten Stand bleiben willst, dann komme auf den Discord.");
	SendClientMessageToAll(COLOR_BLUE,"Serverlink: https://dsc.gg/ioannis");
	SendClientMessageToAll(COLOR_BLUE,"Ich freue mich auf euch! :)");
	}

	new string[128];
	new tstring[128];
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i))continue;
		if(!IsPlayerInAnyVehicle(i))continue;
		format(string,sizeof(string),"%i", getPlayerSpeed(i));
  		TextDrawSetString(Tacho, string);
		new vID = GetPlayerVehicleID(i);
		format(tstring, sizeof(string), "Tank: %i%%~n~%s", tank[vID],getVehicleName(GetVehicleModel(vID)));
		PlayerTextDrawSetString(i, tankLabel[i], tstring);
	}

	tanktimer++;
	if(tanktimer == 15)
	{
	    tanktimer = 0;
		//Tanks reduzieren
		for(new i=1; i<sizeof(tank); i++)
		{
		    if(!hatAutoMotor(i))continue;
		    if(!isMotorOn(i))continue;
		    tank[i]--;
		    if(tank[i]>0)continue;
			stopMotor(i);
		}
 }
	new hour,minute,second;
	gettime(hour,minute,second);
	format(string,sizeof(string),"%02d:%02d",hour,minute);
	TextDrawSetString(uhrzeitlabel,string);
	return 0;
}

public stunde(){
	new hour,minute,second;
	gettime(hour,minute,second);
	SetWorldTime(hour);
	changeweather();
	return 1;
}



public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerVirtualWorld(playerid, 0);
	SetCameraBehindPlayer(playerid);
	return 1;
}



public OnPlayerConnect(playerid)
{
	for(new i = 0; i < 35; i++) SendClientMessage(playerid,COLOR_GREY," ");
	#if defined Weihnachten
	loadxmas();
	stream = "https://ioannisdev.de/musik/xmas.mp3";
	#else
	stream = "https://ioannisdev.de/musik/musik.mp3";
	#endif

	DisablePlayerCheckpoint(playerid);

	//login/register
	new name[MAX_PLAYER_NAME],query[128];
	GetPlayerName(playerid,name,sizeof(name));
	mysql_format(dbhandle,query,sizeof(query),"SELECT id FROM user WHERE username='%s'",name);
	mysql_tquery(dbhandle,query,"OnUserCheck","d",playerid);
	PlayAudioStreamForPlayer(playerid, stream);
	GetPlayerName(playerid,name,sizeof(name));
	mysql_format(dbhandle,query,sizeof(query),"SELECT * FROM user WHERE username='%s'",name);
	mysql_tquery(dbhandle,query,"OnUserCheck","d",playerid);

	KillTimer(payday[playerid]);

	new /*nachricht[128],*/Float:x,Float:y,Float:z;
	SetPlayerCameraPos(playerid,1481.3153,-1722.0088,17.9948);
	SetPlayerCameraLookAt(playerid,1481.5920,-1766.3236,18.7958);
	GetPlayerPos(playerid, x, y, z);
	/*
	format(nachricht,sizeof(nachricht),"Du bist mit der ID %i verbunden.",playerid);
	SendClientMessage(playerid,COLOR_RED,nachricht);
	*/

	//Uhrzeit
	TextDrawShowForPlayer(playerid, uhrzeitlabel);
	SetPlayerColor(playerid, COLOR_WHITE);

	//Textdraw Erstellen
	tankLabel[playerid] = CreatePlayerTextDraw(playerid,547.000000, 418.000000, "Tank:100%");
	PlayerTextDrawBackgroundColour(playerid, tankLabel[playerid], 255);
	PlayerTextDrawFont(playerid, tankLabel[playerid], TEXT_DRAW_FONT_1);
	PlayerTextDrawLetterSize(playerid, tankLabel[playerid], 0.380000, 1.200000);
	PlayerTextDrawColour(playerid, tankLabel[playerid], -1);
	PlayerTextDrawSetOutline(playerid, tankLabel[playerid], 0);
	PlayerTextDrawSetProportional(playerid, tankLabel[playerid], true);
	PlayerTextDrawSetShadow(playerid, tankLabel[playerid], 1);
	PlayerTextDrawHide(playerid, tankLabel[playerid]);

	//noclip
	resetnoclip(playerid);
	return 1;
}


public OnPlayerDisconnect(playerid, reason)
{
	new logoutstamp[128];
	new Year, Month, Day,Hour, Minute, Second;
	gettime(Hour, Minute, Second);
	getdate(Year, Month, Day);

	format(logoutstamp,sizeof(logoutstamp),"%02d/%02d/%d um %02d:%02d:%02d",Day,Month,Year,Hour, Minute, Second);
	sInfo[playerid][logout]=logoutstamp;
	savePlayer(playerid);
	savesession(playerid);
	resetPlayer(playerid);
	SetPlayerColor(playerid, COLOR_WHITE);
	for(new i=0; i<sizeof(cInfo); i++)
	{
		if(cInfo[i][id_x]==0)continue;
		if(cInfo[i][besitzer] != sInfo[playerid][db_id])continue;
		new query[128];
		new debugmsg[64];
		format(debugmsg,sizeof(debugmsg),"%i | %i",cInfo[i][farbe1],cInfo[i][farbe2]);
		mysql_format(dbhandle,query,sizeof(query),"UPDATE autos SET f1='%i', f2='%i', x='%f', y='%f', z='%f' WHERE id='%i'",cInfo[i][farbe1],cInfo[i][farbe2],cInfo[i][c_x],cInfo[i][c_y],cInfo[i][c_z], cInfo[i][db_id]);
		print(debugmsg);
		mysql_tquery(dbhandle,query);
		DestroyVehicle(cInfo[i][id_x]);
		cInfo[i][id_x]=0;
	}
	StopAudioStreamForPlayer(playerid);
	PlayerTextDrawDestroy(playerid, tankLabel[playerid]);
	
	for(new x; x<MAX_PLAYERS; x++)
	{
		if(noclipdata[x][cameramode] == CAMERA_MODE_FLY) CancelFlyMode(x);
	}


	new szString[64],
	playerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playerName, MAX_PLAYER_NAME);

	new szDisconnectReason[3][] =
    {
        "Timeout/Crash",
        "Normal",
        "Kick/Ban"
    };

	format(szString, sizeof szString, "%s hat den Server verlassen (%s).", playerName, szDisconnectReason[reason]);
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid,x,y,z);
	for(new i = 0, j = MAX_PLAYERS; i <= j; i++) //GetPlayerPoolSize ist die höchste online playerid   | i repräsentiert die aktuelle id die gecheckt wird
    {
        if(IsPlayerInRangeOfPoint(i, 7.0, x, y, z))
        {
		SendClientMessage(i,0xC4C4C4FF, szString);
	}}

	

	return 1;
}






stock saveCarToDB(playerid,carid)
{
	new query[128];
 	format(query,sizeof(query),"INSERT INTO autos (besitzer,model,x,y,z,r,dl,tank) VALUES ('%s','%i','%f','%f','%f','%f','%i',%i)",getPlayerName(playerid),cInfo[carid][model],cInfo[carid][c_x],cInfo[carid][c_y],cInfo[carid][c_z],cInfo[carid][c_r],cInfo[carid][dl],tank[carid]);
	mysql_function_query(dbhandle,query,true,"CarSavedToDB","i",carid);
	return 1;
}

public OnPlayerSpawn(playerid)
{
    SetPlayerColor(playerid, 0xFFFFFFFF);
    StopAudioStreamForPlayer(playerid);
    SetPlayerScore(playerid, sInfo[playerid][plevel]);
	new loginstamp[128];
	new Year, Month, Day,Hour, Minute, Second;
	gettime(Hour, Minute, Second);
	getdate(Year, Month, Day);

	format(loginstamp,sizeof(loginstamp),"%02d/%02d/%d um %02d:%02d:%02d",Day,Month,Year,Hour, Minute, Second);
	sInfo[playerid][login]=loginstamp;

        // Fraktion
    if (strcmp(sInfo[playerid][pspawnchange], "fraktion")==0)
        {
            new fID;
            fID = sInfo[playerid][pfraktion];
            SetPlayerPos(playerid, fInfo[fID][f_x], fInfo[fID][f_y], fInfo[fID][f_z]);
            SetPlayerFacingAngle(playerid, fInfo[fID][f_r]);
            SetPlayerInterior(playerid, fbase[fID][f_inter]);
            SetPlayerVirtualWorld(playerid, fbase[fID][f_world]);
        }
        else
            // Haus
            if (strcmp(sInfo[playerid][pspawnchange], "haus")==0)
            {
                for (new i = 0; i < sizeof(hInfo); i++)
                {
                    if (!hInfo[i][h_id])
                        continue;
                    if (!strlen(hInfo[i][h_besitzer]))
                        continue;
                    if (strcmp(hInfo[i][h_besitzer], getPlayerName(playerid), true))
                        continue;
                    // Ist Haus von Spieler
                    if (hInfo[i][h_interior] != 0)
                    {
                        SetPlayerPos(playerid, hInfo[i][ih_x], hInfo[i][ih_y], hInfo[i][ih_z]);
                        SetPlayerInterior(playerid, hInfo[i][h_interior]);
                        SetPlayerVirtualWorld(playerid, i);
                    }
                    else
                    {
                        // Vor dem Haus spawnen
                        SetPlayerPos(playerid, hInfo[i][ih_x], hInfo[i][ih_y], hInfo[i][ih_z]);
                        SetPlayerInterior(playerid, 0);
                        SetPlayerVirtualWorld(playerid, 0);
                    }
                }
            }
			else
                // Noobspawn
                if (strcmp(sInfo[playerid][pspawnchange], "noob")==0)
                {
                    SendClientMessageToAll(COLOR_RED, "noob!");
                    SetPlayerPos(playerid, 1481.59, -1766.32, 18.7958);
                    SetPlayerFacingAngle(playerid, 3.2137);
                    SetPlayerInterior(playerid, 0);
                    SetPlayerVirtualWorld(playerid, 0);
                }
                else
                    // Letzte Position
                    if (strcmp(sInfo[playerid][pspawnchange], "lastpos")==0)
                    {
                        SetPlayerPos(playerid, sInfo[playerid][sx], sInfo[playerid][sy], sInfo[playerid][sz]);
                    }
                    else if (strcmp(sInfo[playerid][pspawnchange], "0"))
                    {
                        SetPlayerPos(playerid, 1481.59, -1766.32, 18.7958);
                        SetPlayerFacingAngle(playerid, 3.2137);
                        SetPlayerInterior(playerid, 0);
                        SetPlayerVirtualWorld(playerid, 0);
                    }

    if (sInfo[playerid][eingeloggt] == 0)
    {
        new string[128],wstring[256];
        format(string, sizeof(string), "{CC210A}SERVER:{FFFFFF} Willkommen %s", getPlayerName(playerid));
        SendClientMessage(playerid, COLOR_RED, string);
        if(sInfo[playerid][padminlevel]>=2){
			SendClientMessage(playerid,COLOR_RED,"SERVER:{FFFFFF} Du bist als Supporter eingeloggt. Vielen Dank für dein Engagement!");
		}
		if(sInfo[playerid][padminlevel]>=5){
			SendClientMessage(playerid,COLOR_RED,"SERVER: {FFFFFF}Du bist als Manager eingeloggt und dauerhaft im Admindienst. Sei vorsichtig!");
		}

		if(sInfo[playerid][pfleader]>0){
			if(sInfo[playerid][pfraktion]==7){
                SendClientMessage(playerid,COLOR_RED,"SERVER:{FFFFFF} Willkommen zurück Herr Präsident.");
			}else{
                SendClientMessage(playerid,COLOR_RED,"SERVER:{FFFFFF} Du bist als Fraktionsleitung eingeloggt. Vielen Dank für dein Engagement!");
			}
		}
		wstring = "{FFFFFF}Willkommen auf "#SERVERNAME "!\n Das Team wünscht dir viel Spaß beim spielen!\n Bei Fragen oder Problemen kannst du uns gerne auf Discord anschreiben {FF0000}(/discord).";
		ShowPlayerDialog(playerid, 563, DIALOG_STYLE_MSGBOX, "Willkommen auf "#SERVERNAME , wstring,"Okay","");
		
		
		
		#if defined Weihnachten
			SendClientMessage(playerid, COLOR_RED, "SERVER: {FFFFFF}" #SERVERNAME " wünscht dir frohe Weihnachten.");
		#endif
		
        if (sInfo[playerid][pfraktion] > 0 && sInfo[playerid][eingeloggt] == 0)
        {
            new fstring[128];
            new fID = sInfo[playerid][pfraktion];
            format(fstring, sizeof(fstring), "FMOTD: %s", fInfo[fID][fmotd]);
            SendClientMessage(playerid, COLOR_YELLOW, fstring);
        }
    }

    sInfo[playerid][eingeloggt] = 1;
    if (isPlayerinBadFrak(playerid))
    {
        SetPlayerSkin(playerid, sInfo[playerid][pfSkin]);
    }
    else
    {
        SetPlayerSkin(playerid, sInfo[playerid][pskin]);
    }
    return 1;
}

stock getPlayerSpeed(playerid)
{
	new Float:x, Float:y, Float:z, Float:rtn;
	if(IsPlayerInAnyVehicle(playerid))
	{
	    GetVehicleVelocity(GetPlayerVehicleID(playerid), x, y, z);
 	}
 	else
 	{
		GetPlayerVelocity(playerid, x, y, z);
 	}
 	//rtn = wurzel(x*x + y*y + z*z);
	rtn = floatsqroot(x*x + y*y + z*z); //Betroffene zeile (840)
	return floatround(rtn * 100 * 1.61); //Betroffene zeile (841)
}

public OnPlayerDeath(playerid, killerid, WEAPON:reason){
	SetPVarInt(playerid,"fduty",0);
 // Declare 3 float variables to store the X, Y and Z coordinates in
 //   new Float:x, Float:y, Float:z;

    // Use GetPlayerPos, passing the 3 float variables we just created
	GetPlayerPos(playerid,sInfo[playerid][dx],sInfo[playerid][dy],sInfo[playerid][dz]);
	new string[64];
	sInfo[playerid][pdeaths]++;
	format(string,sizeof(string),"SERVER: {FFFFFF}Du bist zum %i. Mal gestorben.",sInfo[playerid][pdeaths]);
	SendClientMessage(playerid,COLOR_RED,string);
	SendClientMessage(killerid, COLOR_HRED,"Du hast ein Verbrechen begangen ( Vorsätzlicher Mord ). Reporter: Anonym.");
	SetPlayerArmour(playerid,0);

	   //SetPlayerPos(playerid, x, y, z);
  //  SetPlayerSkin(playerid,sInfo[playerid][skin] );
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{

	if(!cInfo[vehicleid][besitzer]|| !cInfo[vehicleid][fraktion]){
	DestroyVehicle(vehicleid);
	return 1;
	}
	return 0;
}

public OnPlayerText(playerid, text[])
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	new string[128];
 	format(string,sizeof(string), "%s sagt: %s",
			getPlayerName(playerid), text);

	new chat_color;
	new limit = GetPVarInt(playerid,"chat");
	limit++;
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	    if(!IsPlayerConnected(i))continue;
	    if(!IsPlayerInRangeOfPoint(i, CHAT_RADIUS, x, y, z))continue;
	    new Float:distance = GetPlayerDistanceFromPoint(i, x, y, z);
	    if(distance < CHAT_RADIUS / CHAT_FADES)
	    {
			chat_color = COLOR_CHAT;
	    }
		else if(distance < CHAT_RADIUS / CHAT_FADES * 2)
		{
		    chat_color = COLOR_FADE1;
	    }
	    else if(distance < CHAT_RADIUS / CHAT_FADES * 3)
		{
		    chat_color = COLOR_FADE2;
	    }
	    else if(distance < CHAT_RADIUS / CHAT_FADES * 4)
		{
		    chat_color = COLOR_FADE3;
	    }
	    else if(distance <= CHAT_RADIUS / CHAT_FADES * 5)
		{
		    chat_color = COLOR_FADE4;
	    }
	    SendClientMessage(i, chat_color, string);
	}
	return 0;
}

public CarSavedToDB(carid)
{
	cInfo[carid][db_id]=cache_insert_id();
	return 1;
}


stock getFreeHausID()
{
	for(new i=0; i<sizeof(hInfo); i++)
	{
	    if(hInfo[i][h_id]==0)return i;
	}
	return 0;
}


stock createCar(playerid,modelid,Float:x,Float:y,Float:z,Float:r)
{
	for(new i=0; i<sizeof(cInfo); i++)
	{
	    if(cInfo[i][id_x]!=0)continue;
	    GetPlayerName(playerid,cInfo[i][besitzer],MAX_PLAYER_NAME);
		cInfo[i][besitzer]=sInfo[playerid][db_id];
		cInfo[i][c_x]=x;
	    cInfo[i][c_y]=y;
	    cInfo[i][c_z]=z;
	    cInfo[i][c_r]=r;
	    cInfo[i][model]= modelid;
	    cInfo[i][id_x] = CreateVehicle(modelid,x,y,z,r,-1,-1,0);
	    tank[cInfo[i][id_x]] = tank[i];
	    SetVehicleNumberPlate(i,cInfo[i][kennzeichen]);
		SetVehicleHealth(i,cInfo[i][dl]);
	    new string[128];
	    format(string,sizeof(string),"Das Auto cInfo[%i] wurde erstellt.",modelid);
	    SendClientMessage(playerid,COLOR_RED,string);

	    return 1;
	}
	return 1;
}



public unfreezePlayer(playerid)
{
	TogglePlayerControllable(playerid,true);
	return 1;
}


CMD:intinfo(playerid,params[])
{
	new vID,iID,wstring[128],istring[128];
	vID = GetPlayerVirtualWorld(playerid);
	iID= GetPlayerInterior(playerid);
	format(istring,sizeof(istring),"Interior Schlüssel: %i",iID);
	format(wstring,sizeof(wstring),"Virtuelle Welt: %i",vID);
	SendClientMessage(playerid,COLOR_GREY,istring);
	SendClientMessage(playerid,COLOR_GREY,wstring);
	return 1;
}

CMD:play(playerid,params[])
{
	ShowPlayerDialog(playerid,DIALOG_SEIGABE,DIALOG_STYLE_INPUT,"Stream","Gebe die URL des streams ein:","Okay","Abbrechen");
	return 1;
}


CMD:showfill(playerid,params[])
{
	new string[64],vID;
	if(sscanf(params,"i",vID))return SendClientMessage(playerid,COLOR_GREY,"INFO: /showfill [vID]");
	format(string,sizeof(string),"Deine Tankfüllung entspricht %i%",tank[vID]);
	SendClientMessage(playerid, COLOR_YELLOW,string);
	return 1;
}




getPlayerName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid,name,sizeof(name));
	return name;
}

CMD:vcolor(playerid,params[])
{
new vID,c1,c2;
if(sscanf(params,"iii",vID,c1,c2))return SendClientMessage(playerid,COLOR_GREY,"INFO: /vcolor [vID] [c1] [C2]");
for(new i; i<sizeof(cInfo); i++)
{
    if(cInfo[i][id_x] != vID) continue;
    cInfo[i][farbe1] = c1;
    cInfo[i][farbe2] = c2;
	ChangeVehicleColours(vID,c1,c2);
    break;
}
return 1;
}

CMD:time(playerid,params[])
{
	new string[285], Hour, Minute, Second;
	gettime(Hour, Minute, Second);
	format(string,sizeof(string),"Die momentane Uhrzeit: %02d:%02d:%02d", Hour, Minute, Second);
	SendClientMessage(playerid,COLOR_GREY,string);
	return 1;
}


CMD:skininfo(playerid,params[])
{
	new sID,string[128];
	sID = GetPlayerSkin(playerid);
	format(string, sizeof(string),"SkinID:%i",sID);
	SendClientMessage(playerid,COLOR_GREY,string);
	return 1;
}




CMD:suicide(playerid,params[])
{
	SetPlayerHealth(playerid,0.0);
	SetPlayerArmour(playerid,0.0);
	SCM(playerid,COLOR_RED,"SERVER: Selbstmord ist keine Lösung! Oder etwa doch?!");
	return 1;
}


CMD:dropguns(playerid,params[])
{
ResetPlayerWeapons(playerid);
new Float:x, Float:y, Float:z,string[256];
GetPlayerPos(playerid, x,y,z);
for(new i = 0, j = MAX_PLAYERS; i <= j; i++) //GetPlayerPoolSize ist die höchste online playerid   | i repräsentiert die aktuelle id die gecheckt wird
 {
	    if(IsPlayerInRangeOfPoint(i, 7.0, x, y, z))
        {
        format(string,sizeof(string),"%s lässt seine Waffen fallen.",getPlayerName(playerid));
		SendClientMessage(playerid,COLOR_HRED,string);
       }
}
return 1;
}


CMD:showpos(playerid,params[])
{
	new pID, Float:x, Float:y, Float:z, string[200];
	if(sscanf(params,"u",pID))return WPM(playerid,"/showpos [playerid]");
	GetPlayerPos(playerid, x, y, z);
	format(string,sizeof(string),"POSITION: Deine Koordinaten: %f,%f,%f", x,y,z);
	SendClientMessage(playerid, COLOR_GREY,string);
	printf(string);
	return 1;
}

//GMX
stock saveallplayers(){
	for(new i = 0 ; i < MAX_PLAYERS ; i++)
	{
	if(sInfo[i][eingeloggt] == 1){
	savePlayer(i);
	}
	}
}


stock staatsequip(playerid)
{
	GivePlayerWeapon(playerid,WEAPON_DEAGLE,150);
	GivePlayerWeapon(playerid,WEAPON_SHOTGUN,50);
	GivePlayerWeapon(playerid,WEAPON_MP5,250);
	GivePlayerWeapon(playerid,WEAPON_M4,200);
	return 1;
}

//car
CMD:car(playerid,params[])
{
	if(sInfo[playerid][eingeloggt]==0)return SCM(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht eingeloggt!");
	new option[10];
	if(sscanf(params,"s[10]",option))return WPM(playerid,"/car [lock|tow|search]");
	new Float:x,Float:y,Float:z,Float:r;
//	new iEngine, iLights, iAlarm,iDoors, iBonnet, iBoot, iObjective;

//LOCK
	if(strcmp(option,"lock",false)==0)
{
    new Float:vx, Float:vy, Float:vz;
    for (new i = 0; i <= MAX_PLAYER_CARS; i++)
    {
		new string[64];
		GetVehiclePos(i,vx,vy,vz);
		if(IsPlayerInRangeOfPoint(playerid,5.0,vx,vy,vz)){
			format(string,sizeof(string),"%i",sInfo[playerid][pfahrzeuge][i]);
			SCM(playerid, COLOR_BLUE,string);
			return 1;
		}
		return 0;
    }
    printf("Kein gültiges Fahrzeug gefunden!");
    return 1;
}




	if(strcmp(option,"park",false)==0)
	{
	new string[128];
	for(new i=0; i<=MAX_VEHICLES;i++){
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER && cInfo[i][besitzer] == sInfo[playerid][db_id]){
			GetPlayerPos(playerid,x,y,z);
			GetPlayerFacingAngle(playerid,r);
			format(string,sizeof(string), "%f %f %f",cInfo[i][c_x],cInfo[i][c_y],cInfo[i][c_z]);
			SendClientMessage(playerid,COLOR_GREEN,string);
			cInfo[i][c_x]=x;
			cInfo[i][c_y]=y;
			cInfo[i][c_z]=z;
			cInfo[i][c_r]=r;
			SendClientMessage(playerid,COLOR_GREEN,"ERFOLGREICH: {FFFFFF}Du hast das Fahrzeug geparkt!");
			return 1;

   	}else{return SEM(playerid,"Du sitzt in keinem Fahrzeug.");
	}}
	return SEM(playerid,"SNENS");
	}
	return 1;
}

//fcar
CMD:fcar(playerid,params[])
{
if(isPlayerInFrak(playerid,4) && IsPlayerInRangeOfPoint(playerid,2,2026.812133,-1403.623168,17.224706))
{
	ShowPlayerDialog(playerid,DIALOG_FCARRD,DIALOG_STYLE_LIST,"Retungsdienst","Rettungswagen\nPremier\nWayfarer\nRanger","spawnen","abbrechen");
}
return 1;
}

//houses
CMD:houses(playerid,params[])
{
new string[128];
new name[128];
name = getPlayerName(playerid);
SendClientMessage(playerid,COLOR_HBLUE,"[______________Hausübersicht______________]");
for(new i=0;i<=sizeof(hInfo);i++){

	if(strcmp(hInfo[i][h_besitzer], getPlayerName(playerid), false)==0){
	format(string,sizeof(string),"HAUS: {FFFFFF}Hausnummer: %i | Status: Eigentum",i);
	SendClientMessage(playerid,COLOR_HBLUE,string);
		}
	return 1;
	}
return 1;
}

//vehicles
CMD:vehicles(playerid,params[])
{
new string[256];
SendClientMessage(playerid,COLOR_HBLUE,"[______________Fahrzeugübersicht______________]");
for(new i=0;i<=MAX_VEHICLES;i++){
	if(strcmp(cInfo[i][besitzer],getPlayerName(playerid))>=0){
	format(string,sizeof(string),"ID: %i | Model: %s | Tank:%i",i,getVehicleName(i),tank[i]);
	SendClientMessage(playerid,COLOR_WHITE,string);
		}
	return 1;
	}
return 0;
}

//setfskin
CMD:setfskin(playerid,params[])
{
new pID,skinID;
if(sscanf(params,"ui",pID,skinID))return WPM(playerid,"/setfskin [playerid] [skin-ID]");
sInfo[pID][pfSkin]=skinID;
SetPlayerSkin(pID,skinID);
return 1;
}



//hduty
CMD:hduty(playerid,params[])
{
if(sInfo[playerid][pfraktion] != 8)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht befugt diesen Befehl zu nutzen");
new string[128];
GivePlayerWeapon(playerid, WEAPON_SNIPER, 90);
GivePlayerWeapon(playerid, WEAPON_SILENCED, 90);
SetPlayerHealth(playerid,100);
SetPlayerArmour(playerid,100);
format(string,sizeof(string),"HITMAN: %s ist nun als Hitman im Dienst",getPlayerName(playerid));

for(new i = 0 ; i < MAX_PLAYERS ; i++)
	{
	    if(IsPlayerConnected(i) && sInfo[i][eingeloggt] == 1)
	    {
	        if(sInfo[i][pfraktion] == 8)
	        {
	            SendClientMessage(i, COLOR_YELLOW, string);
			}
	    }
	}
return 1;
}



//id
CMD:id(playerid,params[])
{
new Float:health,Float:arm,ping,string[256],level,name[256],pID;
if(sscanf(params,"u",pID))return WPM(playerid,"/id [playerid]");
if(!IsPlayerConnected(pID))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Der Spieler ist nicht online!");
GetPlayerHealth(pID,health);
GetPlayerArmour(pID,arm);
ping = GetPlayerPing(pID);
name = getPlayerName(pID);
level = GetPlayerScore(pID);
format(string,sizeof(string),"Name: %s  Level: %i  Ping: %i  HP: %.0f  Armour: %.0f",name,level,ping,health,arm);
SendClientMessage(playerid,COLOR_WHITE,string);
return 1;
}

//credits
CMD:credits(playerid,params[])
{
SendClientMessage(playerid,COLOR_HGREEN,"[__________ Testserver __________]");
SendClientMessage(playerid,COLOR_HRED,"Gegründet von: "#SERVEROWNER ".");
SendClientMessage(playerid,COLOR_HRED,"Entwickler: "#SERVEROWNER ".");
SendClientMessage(playerid,COLOR_HRED," ");
SendClientMessage(playerid,COLOR_GREY,"* Danke an alle Tester und Helfer.");
return 1;
}

//discord
CMD:discord(playerid,params[]){
	SendClientMessage(playerid, COLOR_GREY, "Discordlink: https://dsc.gg/ioannis");
	return 1;
}


//stopstream
CMD:stopstream(playerid,params[])
{
	StopAudioStreamForPlayer(playerid);
	return 1;
}

//clear
CMD:clear(playerid,params[])
{
	new pID;
	if(sscanf(params,"u",pID))return WPM(playerid,"/clear [playerid]");
	if(!IsPlayerConnected(pID))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Der Spieler ist nicht online!");
	if(GetPlayerWantedLevel(playerid)==0)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Der Spieler wird nicht gesucht!");
	new string[128];

	format(string,sizeof(string),"HQ: An alle Einheiten: Verdächtiger %s wurde von %s freigestellt!",getPlayerName(pID),getPlayerName(playerid));
	SendClientMessage(playerid,COLOR_HBLUE,"INFO: Deine Akten wurden gereinigt.");
	SetPlayerWantedLevel(pID,0);
	sInfo[playerid][pwanteds]=0;
	for(new i=0; i<=MAX_PLAYERS; i++)
	{
		if(isPlayerinStaat(i)){
		SendClientMessage(playerid,COLOR_BLUE,string);
		}else{
		SendClientMessage(playerid,COLOR_BLUE,"SNENS");
		}
	}
	return 1;
}


//setwanted
CMD:su(playerid,params[])
{
new wps,erg, pID;
if(sscanf(params,"ui",pID,wps))return WPM(playerid,"/setwanted [wantedanzahl]");
if(!IsPlayerConnected(pID))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Der Spieler ist nicht online!");
new string[128];
sInfo[pID][pwanteds] = wps;
erg = wps/10;
SetPlayerWantedLevel(pID,erg);
format(string,sizeof(string),"Dein aktuelles Wantedlevel: %i. Deine Wanteds: %i",erg,wps);
SendClientMessage(pID,COLOR_YELLOW,string);
return 1;
}

//Inv
CMD:inv(playerid,params[])
{
	new string[1024];
	format(string,sizeof(string),"Donuts: %i , Green: %i , Gold: %i, LSD: %i",sInfo[playerid][pdonut],sInfo[playerid][pgreen],sInfo[playerid][pgold],sInfo[playerid][plsd]);
	SendClientMessage(playerid,COLOR_GREEN,"_____________________________Inventar____________________________________");
	SendClientMessage(playerid,COLOR_GREY,string);
	return 1;
}

//get
CMD:get(playerid,params[])
{
new anzahl,preis,string[256],item[64];
if(sscanf(params,"s[64]i",item,anzahl))return WPM(playerid,"/get [donut|green|gold|LSD]");
if(!strcmp(item, "donut", false))
{
if(IsPlayerInRangeOfPoint(playerid,10.0,1038.0804,-1339.8496,13.7343)&& isPlayerinStaat(playerid))
{
	sInfo[playerid][pdonut] = sInfo[playerid][pdonut]+anzahl;
	preis = anzahl*7;
    if(GetPlayerMoney(playerid)< preis)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du hast nicht genug Geld dabei.");
 	format(string,sizeof(string),"* Du hast %i Donut(s) für $%i gekauft. (Donuts im Inventar: %i)",anzahl,preis,sInfo[playerid][pdonut]);
	SendClientMessage(playerid,COLOR_YELLOW,string);
	SetPlayerMoney(playerid,GetPlayerMoney(playerid)-preis);
		}
	}else{
	SEM(playerid,"Du bist nicht in einer Staatsfraktion oder in der SAM AG");
	return 1;
		}
return 1;
}

//use
CMD:use(playerid,params[])
{
	new item[64],string[256],Float:health;
	if(sscanf(params,"s[64]",item))return WPM(playerid,"/use [lsd|green|gold|donut]");
	//donut
	if(!strcmp(item,"donut", false))
	{
	if(sInfo[playerid][pdonut] <= 0)return SendClientMessage(playerid, COLOR_RED,"FEHLER: {FFFFFF}Du besitzt keine Donuts.");
    new Float:x, Float:y, Float:z;
    GetPlayerHealth(playerid,health);
    if((health >= 80)&&(health<150)){
	SetPlayerHealth(playerid,150);
	sInfo[playerid][pdonut]--;
 	GetPlayerPos(playerid, x,y,z);
    SendClientMessage(playerid,COLOR_GREY,"Du hast einen Donut gegessen (+80hp)!");
    for(new i = 0, j = MAX_PLAYERS; i <= j; i++) //GetPlayerPoolSize ist die höchste online playerid   | i repräsentiert die aktuelle id die gecheckt wird
    {
        if(IsPlayerInRangeOfPoint(i, 7.0, x, y, z))
        {
   	format(string,sizeof(string),"* %s hat einen Donut gegessen.",getPlayerName(playerid));
	SendClientMessage(i,COLOR_LILA,string);
	}}
	return 1;
		}
	else if(health==150){
	SendClientMessage(playerid,COLOR_GREY,"Du hast bereits einen Donut gegessen!");
	return 1;
	}
    GetPlayerPos(playerid, x,y,z);
    SendClientMessage(playerid,COLOR_GREY,"Du hast einen Donut gegessen (+80hp)!");
    for(new i = 0, j = MAX_PLAYERS; i <= j; i++) //GetPlayerPoolSize ist die höchste online playerid   | i repräsentiert die aktuelle id die gecheckt wird
    {
        if(IsPlayerInRangeOfPoint(i, 7.0, x, y, z))
        {
   	format(string,sizeof(string),"* %s hat einen Donut gegessen.",getPlayerName(playerid));
	SendClientMessage(i,COLOR_LILA,string);
	}}

	SetPlayerHealth(playerid,health+80);

	sInfo[playerid][pdonut]--;
	return 1;
	}
	//green
 	if(!strcmp(item, "green", true))
	{
	if(sInfo[playerid][pgreen] < 2)return SendClientMessage(playerid, COLOR_RED,"FEHLER: {FFFFFF}Du benötigst mindestens 2g Green.");
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x,y,z);
    GetPlayerHealth(playerid,health);
    if(health > 80)return SendClientMessage(playerid,COLOR_GREY,"Du kannst Hawaiian Green erst ab 80HP nutzen.");
    for(new i = 0, j = MAX_PLAYERS; i <= j; i++) //GetPlayerPoolSize ist die höchste online playerid   | i repräsentiert die aktuelle id die gecheckt wird
    {
        if(IsPlayerInRangeOfPoint(i, 7.0, x, y, z))
        {
   	format(string,sizeof(string),"* %s hat Hawaiian Green benutzt.",getPlayerName(playerid));
	SendClientMessage(playerid,COLOR_LILA,string);
	}}
	GetPlayerHealth(playerid,health);
	SetPlayerHealth(playerid,health+35);
 	sInfo[playerid][pgreen]=sInfo[playerid][pgreen]-2;
	return 1;
	}

	if(!strcmp(item,"gold",false))
	{
	if(sInfo[playerid][pgold]<20)return SendClientMessage(playerid,COLOR_GREY,"Du hast nicht genug Acapulco Gold (min. 20g)!");
 	new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x,y,z);
    GetPlayerHealth(playerid,health);
    if(health > 100)return SendClientMessage(playerid,COLOR_GREY,"Du kannst keine Drogen nehmen, da du 100HP hast.");
    for(new i = 0, j = MAX_PLAYERS; i <= j; i++) //GetPlayerPoolSize ist die höchste online playerid   | i repräsentiert die aktuelle id die gecheckt wird
    {
        if(IsPlayerInRangeOfPoint(i, 7.0, x, y, z))
        {
   	format(string,sizeof(string),"* %s hat Acapulco Gold benutzt.",getPlayerName(playerid));
	SendClientMessage(playerid,COLOR_HRED,string);
	}}
	GetPlayerHealth(playerid,health);
	SetPlayerHealth(playerid,health+35);
 	sInfo[playerid][pgold]=sInfo[playerid][pgold]-20;
	SendClientMessage(playerid,COLOR_GREY,"Du hast 20g Acapulco Gold benutzt!");
	return 1;
	}
	return 1;
}



//|----------[Frakzeugs]------------|


//f fchat

//news



//r chat


CMD:getfrang(playerid,params[])
{
new fID = sInfo[playerid][pfrang];
switch (fID){
		case 0: {SendClientMessage(playerid,COLOR_GREY,fInfo[fID][rangnull]);}
		case 1: {SendClientMessage(playerid,COLOR_GREY,fInfo[fID][rangeins]);}
        case 2: {SendClientMessage(playerid,COLOR_GREY,fInfo[fID][rangzwei]);}
        case 3: {SendClientMessage(playerid,COLOR_GREY,fInfo[fID][rangdrei]);}
        case 4: {SendClientMessage(playerid,COLOR_GREY,fInfo[fID][rangvier]);}
        case 5: {SendClientMessage(playerid,COLOR_GREY,fInfo[fID][rangfunf]);}
        case 6: {SendClientMessage(playerid,COLOR_GREY,fInfo[fID][rangsechs]);}
	}

return 1;
}
//invite

//giverank

//accept
CMD:accept(playerid,params[])
{
	new item[64];
	if(sscanf(params,"s[64]",item))return WPM(playerid,"/accept [invite]");
	if(!strcmp(item, "invite", false))
 	{
		if(GetPVarInt(playerid,"inv_frakid") == 0)return SEM(playerid,"Du wurdest in keine Fraktion eingeladen");
		new fID = GetPVarInt(playerid,"inv_frakid");
		sInfo[playerid][pfraktion] = fID;
		sInfo[playerid][pfrang] = 1;
		new string[128];
		format(string,sizeof(string),"Du bist der Fraktion %s beigetreten",fInfo[fID][f_name]);
		SendClientMessage(playerid, COLOR_YELLOW,string);
		format(string,sizeof(string),"%s ist der Fraktion beigetreten",getPlayerName(playerid));
		SendClientMessage(GetPVarInt(playerid,"inv_inviter"),COLOR_YELLOW,string);
		SetPVarInt(playerid, "inv_frakid",0);
		return 1;
	}
	return 1;
}

//annehmen
CMD:annehmen(playerid,params[])
{
		if(GetPVarInt(playerid,"inv_frakid") == 0)return SEM(playerid,"Du wurdest in keine Fraktion eingeladen");
		new fID = GetPVarInt(playerid,"inv_frakid");
		sInfo[playerid][pfraktion] = fID;
		sInfo[playerid][pfrang] = 1;
		new string[128];
		format(string,sizeof(string),"Du bist der Fraktion %s beigetreten",fInfo[fID][f_name]);
		SendClientMessage(playerid, COLOR_YELLOW,string);
		format(string,sizeof(string),"%s ist der Fraktion beigetreten",getPlayerName(playerid));
		SendClientMessage(GetPVarInt(playerid,"inv_inviter"),COLOR_YELLOW,string);
		SetPVarInt(playerid, "inv_frakid",0);
		return 1;
}

//uninvite

//spawnchange
CMD:spawnchange(playerid, params[])
{
ShowPlayerDialog(playerid,DIALOG_SPAWNCHANGE,DIALOG_STYLE_LIST,"Spawnchange","Eigene Fraktion\nEigenes Haus\nNoobspawn\nAktuelle Position","Weiter","Abbrechen");
SendClientMessage(playerid,COLOR_YELLOW,"SPAWNCHANGE: {FFFFFF}Wähle deinen Spawn aus.");
return 1;
}

CMD:startbus(playerid,params[])
{
	for(new i=0; i<sizeof(JPs); i++)
	{
	if(!IsPlayerInRangeOfPoint(playerid, 5, 1080.3252,-1741.1746,13.4900))return SendClientMessage(playerid, COLOR_RED, "Du kannst den Job hier nicht starten.");}
	new Float:xc, Float:yc, Float:zc, Float:ac;
	GetPlayerPos(playerid, xc, yc, zc);
	GetPlayerFacingAngle(playerid, ac);

	new vID = CreateVehicle(431, xc, yc, zc, ac, 1, 2, -1);

	SetPVarInt(playerid, "Bus", vID);
	PutPlayerInVehicle(playerid, vID, 0);

	SetPlayerCheckpoint(playerid, bCPs[0][bj_x], bCPs[0][bj_y], bCPs[0][bj_z], 5);

	SetPVarInt(playerid, "bus_cp", 0);
	SetPVarInt(playerid, "bus_job", 1);

 	return 1;
}




CMD:buyhouse(playerid, params[])
{
	if(hatPlayerHaus(playerid))return
	    SendClientMessage(playerid, COLOR_RED, "Alle deine Hausslots sind belegt!");
	for(new i=0; i<sizeof(hInfo); i++)
	{
	    if(!hInfo[i][h_id])continue;
		if(!IsPlayerInRangeOfPoint(playerid, 5,
		    hInfo[i][h_x], hInfo[i][h_y], hInfo[i][h_z]))continue;
		if(!strlen(hInfo[i][h_besitzer]))
		{
		    if(GetPlayerMoney(playerid)<hInfo[i][h_preis])return
		        SEM(playerid,"Du hast nicht genug Geld.");
			if(GetPlayerScore(playerid)<hInfo[i][h_level])return
			SEM(playerid,"Dein Level ist zu niedrig um dieses Haus zu erwerben.");
			GivePlayerMoney(playerid, -hInfo[i][h_preis]);
			strmid(hInfo[i][h_besitzer], getPlayerName(playerid), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
			updateHaus(i);
			saveHaus(i);
		    return 1;
		}
		return SEM(playerid,
		    "Das Haus steht nicht zum Verkauf.");
	}
	return 1;
}



CMD:v(playerid,params[])
{
new vID, Float:x,Float:y,Float:z;
if(sscanf(params,"i",vID))return WPM(playerid,"/v [vID]");
GetPlayerPos(playerid,x,y,z);
CreateVehicle(vID,x,y,z,0,-1,-1,false,false);
return 1;
}


CMD:flip(playerid,params[])
{
	new vID;
	if(IsPlayerInAnyVehicle(playerid)){
		SendClientMessage(playerid, COLOR_DARK_RED,"INFO: {FFFFFF}Fahrzeug geflipped.");
		vID = GetPlayerVehicleID(playerid);
		SetVehicleZAngle(vID,0);
	}else{
		SEM(playerid,"Du sitzt in keine Fahrzeug.");
	}
	return 1;
}

CMD:cveh(playerid,params[])
{
new item[64];
if(sscanf(params,"s[64]",item))return WPM(playerid,"/cveh [motor|licht|mhaube|kraum|alarm|fenster|signal|limit]");
if(!strcmp(item, "motor", false))
 	{
//motor an
new vID=GetPlayerVehicleID(playerid),
bool:tmp_engine,
bool:tmp_lights,
bool:tmp_alarm,
bool:tmp_doors,
bool:tmp_bonnet,
bool:tmp_boot,
bool:tmp_objective;
if(tank[vID]<1)return
SEM(playerid,"Der Tank ist leer.");
if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)return
SEM(playerid,"Du bist nicht Fahrer eines Fahrzeuges.");
	//Motor an/aus
GetVehicleParamsEx(vID, tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);
if(tmp_engine==true){
		tmp_engine = false;
		SendClientMessage(playerid,COLOR_HBLUE,"INFO: {FFFFFF}Motor ausgeschaltet.");
		}else{
		tmp_engine = true;
		SendClientMessage(playerid,COLOR_HBLUE,"INFO: {FFFFFF}Motor eingeschaltet.");
		}
SetVehicleParamsEx(vID,tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);

}
if(!strcmp(item,"licht",false))
	{
	if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)return
 	SEM(playerid,"Du bist nicht Fahrer eines Fahrzeuges.");

 	new vID=GetPlayerVehicleID(playerid),
	 bool:tmp_engine,
	 bool:tmp_lights,
	 bool:tmp_alarm,
	 bool:tmp_doors,
	 bool:tmp_bonnet,
	 bool:tmp_boot,
	 bool:tmp_objective;
//	 Motor an/aus
	GetVehicleParamsEx(vID, tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);
	if(tmp_lights==true){
		tmp_lights = false;
		SendClientMessage(playerid,COLOR_HBLUE,"INFO: {FFFFFF}Licht ausgeschaltet.");
		}else{
		tmp_lights = true;
		SendClientMessage(playerid,COLOR_HBLUE,"INFO: {FFFFFF}Licht eingeschaltet.");
		}
	SetVehicleParamsEx(vID,tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);
	}

if(!strcmp(item,"mhaube",false))
	{
	if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)return
 	SEM(playerid,"Du bist nicht Fahrer eines Fahrzeuges.");

 	new vID=GetPlayerVehicleID(playerid),
	 bool:tmp_engine,
	 bool:tmp_lights,
	 bool:tmp_alarm,
	 bool:tmp_doors,
	 bool:tmp_bonnet,
	 bool:tmp_boot,
	 bool:tmp_objective;
//	 motorhaube
	GetVehicleParamsEx(vID, tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);
	if(tmp_bonnet==true){
		tmp_bonnet = false;
		SendClientMessage(playerid,COLOR_GREY,"INFO: Motohaube geschlossen.");
		}else{
		tmp_bonnet = true;
		SendClientMessage(playerid,COLOR_GREY,"INFO: Motorhaube geöffnet.");
		}
	SetVehicleParamsEx(vID,tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);



	}
if(!strcmp(item,"kraum",false))
	{
	new vID=GetPlayerVehicleID(playerid),
	bool:tmp_engine,
	 bool:tmp_lights,
	 bool:tmp_alarm,
	 bool:tmp_doors,
	 bool:tmp_bonnet,
	 bool:tmp_boot,
	 bool:tmp_objective;
	if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)return
 	SEM(playerid,"Du bist nicht Fahrer eines Fahrzeuges.");

	GetVehicleParamsEx(vID, tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);

	if(tmp_boot == false){
	tmp_boot=true;
	SetVehicleParamsEx(vID, tmp_engine, tmp_lights,tmp_alarm,tmp_doors,tmp_bonnet,tmp_boot,tmp_objective);
   	SendClientMessage(playerid,COLOR_GREY,"Kofferraum geöffnet.");}
	else{
	if(tmp_boot == true){
	tmp_boot = false;
	SetVehicleParamsEx(vID, tmp_engine, tmp_lights,tmp_alarm,tmp_doors,tmp_bonnet,tmp_boot,tmp_objective);
	SendClientMessage(playerid,COLOR_GREY,"Kofferraum geschlossen.");
		 }
	return 1;
	}}

return 1;
}

CMD:getcarowner(playerid,params[])
{
new string[128];
for(new i=0;i<=MAX_VEHICLES;i++)
{
new Float:x,Float:y,Float:z;
GetVehiclePos(i,x,y,z);
if(IsPlayerInRangeOfPoint(playerid,50,x,y,z))
{
format(string,sizeof(string),"HQ: Der Besitzer des Fahrzeuges ist: %s",cInfo[i][besitzer]);
SendClientMessage(playerid,COLOR_RED,string);
SEM(playerid,"HALLO");
//RANGE
return 1;
}
//FOR
return 1;
}
SEM(playerid,"BYE");
return 1;
}



stock GetPlayerID(name[])
{
    new targetid;
    sscanf(name, "r", targetid);
    return targetid;
}



//stream
CMD:stream(playerid,params[])
{
new ID = GetPVarInt(playerid,"streamon");
if(ID == 1){
				StopAudioStreamForPlayer(playerid);
				SendClientMessage(playerid,COLOR_HGREEN,"Stream beendet.");
				SetPVarInt(playerid,"streamon",0);
				return 1;}
else
{
	ShowPlayerDialog(playerid,DIALOG_STREAM,DIALOG_STYLE_LIST,"Streamliste","Stream stoppen\nBreakzFM\nLogin\nRadio Bollerwagen\n1 Live\n Weihnachtsmusik","Play","Abbrechen");
	return 1;
}
}


public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(GetPVarInt(playerid,"trash_job"))
	{
		SetPVarInt(playerid,"trash_job",0);
		DestroyVehicle(GetPVarInt(playerid,"trash_car"));
		DisablePlayerCheckpoint(playerid);
		SendClientMessage(playerid,COLOR_YELLOW,"MÜLLMANN: {FFFFFF}Route beendet.");
	}
	if(GetPVarInt(playerid,"bus_job"))
	{
		SetPVarInt(playerid,"bus_job",0);
		DestroyVehicle(GetPVarInt(playerid,"Bus"));
		DisablePlayerCheckpoint(playerid);
		SendClientMessage(playerid,COLOR_YELLOW,"BUSFAHRER: {FFFFFF}Route beendet.");
	}
	return 1;
}

public OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate)
{
	if(newstate==PLAYER_STATE_ONFOOT)
	{
    TextDrawHideForPlayer(playerid, Tacho);
 	TextDrawHideForPlayer(playerid, kmhtd);
 	TextDrawHideForPlayer(playerid, Tachobox);
	PlayerTextDrawHide(playerid, tankLabel[playerid]);
	}
	
	if(newstate==PLAYER_STATE_EXIT_VEHICLE)
	{
    TextDrawHideForPlayer(playerid, Tacho);
 	TextDrawHideForPlayer(playerid, kmhtd);
 	TextDrawHideForPlayer(playerid, Tachobox);
	PlayerTextDrawHide(playerid, tankLabel[playerid]);
	}
	
	if(newstate==PLAYER_STATE_WASTED)
	{
	SetPlayerHealth(playerid,100);
	SetPlayerPos(playerid,sInfo[playerid][dx],sInfo[playerid][dy],sInfo[playerid][dz]);
	return 1;
	}
	
	if(newstate==PLAYER_STATE_DRIVER)
 	{
 	    TextDrawShowForPlayer(playerid, Tacho);
 	    TextDrawShowForPlayer(playerid, kmhtd);
  	    TextDrawShowForPlayer(playerid, Tachobox);
        SetPlayerArmedWeapon(playerid,WEAPON_FIST);
        PlayerTextDrawShow(playerid, tankLabel[playerid]);
	    return true;
}

	new vID=GetPlayerVehicleID(playerid);
	new vModel=GetVehicleModel(vID);

 	for(new i=0; i<sizeof(autosOhneMotor); i++)
	{
		if(autosOhneMotor[i]==vModel)continue;
		new bool:tmp_engine,
	 	bool:tmp_lights,
	 	bool:tmp_alarm,
	 	bool:tmp_doors,
	 	bool:tmp_bonnet,
	 	bool:tmp_boot,
	 	bool:tmp_objective;
		//Motor an/aus
		GetVehicleParamsEx(vID, tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);
		SetVehicleParamsEx(vID,true, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);

}

	return 1;
 }



public OnPlayerEnterCheckpoint(playerid)
{
if(GetPVarInt(playerid, "trash_job"))
	{
	    //Wenn trash job ausgeführt wird
		new cID = GetPVarInt(playerid, "trash_cp");
		if(IsPlayerInRangeOfPoint(playerid, 5, tCPs[cID][t_x], tCPs[cID][t_y], tCPs[cID][t_z]))
		{
		    cID++;

		    if(cID >= sizeof(tCPs))
		    {
		        GivePlayerMoney(playerid, 200);
		        SetPVarInt(playerid, "trash_cp", 0);
				SetPlayerCheckpoint(playerid, tCPs[0][t_x], tCPs[0][t_y], tCPs[0][t_z], 5);
		    }
			else
		    {
		        SetPVarInt(playerid, "trash_cp", cID);
				SetPlayerCheckpoint(playerid, tCPs[cID][t_x], tCPs[cID][t_y], tCPs[cID][t_z], 5);
		    }
			return 1;
		}
	}
if(GetPVarInt(playerid, "bus_job"))
	{
	    //Wenn trash job ausgeführt wird
		new cID = GetPVarInt(playerid, "bus_cp");
		if(IsPlayerInRangeOfPoint(playerid, 5, bCPs[cID][bj_x], bCPs[cID][bj_y], bCPs[cID][bj_z]))
		{
		    cID++;

		    if(cID >= sizeof(bCPs))
		    {
		        GivePlayerMoney(playerid, 200);
		        SetPVarInt(playerid, "bus_cp", 0);
				SetPlayerCheckpoint(playerid, bCPs[0][bj_x], bCPs[0][bj_y], bCPs[0][bj_z], 5);
		    }
			else
		    {
		        TogglePlayerControllable(playerid, false);
		        SetPVarInt(playerid, "bus_cp", cID);
				SetPlayerCheckpoint(playerid, bCPs[cID][bj_x], bCPs[cID][bj_y], bCPs[cID][bj_z], 5);
		    }
			return 1;
		}
	}
DisablePlayerCheckpoint(playerid);
return 1;
}


public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}
public OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
if(IsPlayerInAnyVehicle(playerid)){
if(newkeys & KEY_YES){
 	new vID=GetPlayerVehicleID(playerid),
	 bool:tmp_engine,
	 bool:tmp_lights,
	 bool:tmp_alarm,
	 bool:tmp_doors,
	 bool:tmp_bonnet,
	 bool:tmp_boot,
	 bool:tmp_objective;
 	if(tank[vID]<1)return
    SEM(playerid,"Der Tank ist leer.");
	if(GetPlayerState(playerid)!=PLAYER_STATE_DRIVER)return
 	SEM(playerid,"Du bist nicht Fahrer eines Fahrzeuges.");

	//Motor an/aus
	GetVehicleParamsEx(vID, tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);
	if(tmp_engine==true){
		tmp_engine = false;
		SendClientMessage(playerid,COLOR_HBLUE,"INFO: {FFFFFF}Motor ausgeschaltet.");
		}else{
		tmp_engine = true;
		SendClientMessage(playerid,COLOR_HBLUE,"INFO: {FFFFFF}Motor eingeschaltet.");
		}
	SetVehicleParamsEx(vID,tmp_engine, tmp_lights, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);
	return 1;
}
if(newkeys & KEY_ACTION)
{
	if(!IsPlayerInAnyVehicle(playerid))return 1;
	if(GetVehicleModel(GetPlayerVehicleID(playerid))!= 525)return 1;
	//Im Abschlepper
	new vID=GetPlayerVehicleID(playerid);
	if(IsTrailerAttachedToVehicle(vID))
	{
		return 1;
	}
	else
	{
		new carID = INVALID_VEHICLE_ID;
		new Float:abstand = 8;
		new Float:x,Float:y,Float:z;
		GetVehiclePos(vID,x,y,z);
		for(new i=0; i<MAX_VEHICLES; i++)
		{
		if(!IsVehicleStreamedIn(i, playerid))continue;
		if(i==vID)continue;
		if(GetVehicleDistanceFromPoint(i, x,y,z) < abstand)
		{
			abstand = GetVehicleDistanceFromPoint(i,x,y,z);
			carID =i;
		}
		}
		if(carID !=INVALID_VEHICLE_ID)
		{
		AttachTrailerToVehicle(carID,vID);
		}
	}
}
return 1;
}

if(newkeys & KEY_NO)
	{
	//Enterbefehl
	if(GetPlayerInterior(playerid) == 0){
//Bizes
	for(new i=0; i<sizeof(bInfo); i++)
	{
	if(!IsPlayerInRangeOfPoint(playerid,2,bInfo[i][b_x],bInfo[i][b_y],bInfo[i][b_z]))continue;
	SetPlayerPos(playerid,bInfo[i][b_ix],bInfo[i][b_iy],bInfo[i][b_iz]);
	SetPlayerInterior(playerid,bInfo[i][b_interior]);
	SetPlayerVirtualWorld(playerid,i);
	}

	if(IsPlayerInRangeOfPoint(playerid,1.5,1524.7957,-1678.0403,5.8906))
	{
	SetPlayerPos(playerid,208.3992,167.5560,1003.0234);
	SetPlayerInterior(playerid,3);
	}

	//häuser
	for(new i=0; i<sizeof(hInfo); i++)
	{
	if(!hInfo[i][h_id])continue;
	if(hInfo[i][ih_x] == 0)continue;
	if(hInfo[i][h_interior]==0)return SendClientMessage(playerid,COLOR_GREEN,"Dieses Haus besitzt keinen Innenraum");
	if(!IsPlayerInRangeOfPoint(playerid,2,hInfo[i][h_x],hInfo[i][h_y],hInfo[i][h_z]))continue;
	SetPlayerInterior(playerid,hInfo[i][h_interior]);
	SetPlayerPos(playerid,hInfo[i][ih_x],hInfo[i][ih_y],hInfo[i][ih_z]);
	SetPlayerVirtualWorld(playerid,i);
	}

	isPlayerInRangeOfFrakEnterPoint(playerid);
	return 1;
	}
	else if(GetPlayerInterior(playerid) > 0){
	//exitbefehl
	//bizes
	for(new i=0; i<sizeof(bInfo); i++)
	{
	    if(GetPlayerVirtualWorld(playerid)!=i)continue;
	    if(!IsPlayerInRangeOfPoint(playerid,2,bInfo[i][b_ix],bInfo[i][b_iy],bInfo[i][b_iz]))continue;
	    SetPlayerPos(playerid,bInfo[i][b_x],bInfo[i][b_y],bInfo[i][b_z]);
	    SetPlayerInterior(playerid,0);
	    SetPlayerVirtualWorld(playerid,0);
    	return 1;
	}

	if(IsPlayerInRangeOfPoint(playerid,1.5,208.3992,167.5560,1003.0234)&&isPlayerInFrak(playerid,1)){
	SetPlayerPos(playerid,1524.7957,-1678.0403,5.8906);
	SetPlayerInterior(playerid,0);

	 }
//häuser
	for(new i=0; i<sizeof(hInfo); i++)
	{
		if(GetPlayerVirtualWorld(playerid) !=i)continue;
		if(!IsPlayerInRangeOfPoint(playerid,10,hInfo[i][ih_x],hInfo[i][ih_y],hInfo[i][ih_z]))continue;
		SetPlayerPos(playerid,hInfo[i][h_x],hInfo[i][h_y],hInfo[i][h_z]);
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid,0);
	}
	isPlayerInRangeOfFrakExitPoint(playerid);
	return 1;
	}
	return 1;
}

return 1;
}


public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
/*
new params[8];
for(new i = 0; i < MAX_PLAYERS; i++) {
    if(IsPlayerConnected(i) && pVCam[i] == playerid) {
        format(params, sizeof(params), "%d", playerid);
        cmd_vcam(i, params); //oder besser in eine Funktion auslagern, die auch vom Befehl aufgerufen wird
    }
}
*/



//noclip
if(noclipdata[playerid][cameramode] == CAMERA_MODE_FLY)
	{
		new KEY:keys,ud,lr;
		GetPlayerKeys(playerid,keys,ud,lr);

		if(noclipdata[playerid][mode] && (GetTickCount() - noclipdata[playerid][lastmove] > 100))
		{
		    // If the last move was > 100ms ago, process moving the object the players camera is attached to
		    MoveCamera(playerid);
		}

		// Is the players current key state different than their last keystate?
		if(noclipdata[playerid][udold] != ud || noclipdata[playerid][lrold] != lr)
		{
			if((noclipdata[playerid][udold] != 0 || noclipdata[playerid][lrold] != 0) && ud == 0 && lr == 0)
			{   // All keys have been released, stop the object the camera is attached to and reset the acceleration multiplier
				StopPlayerObject(playerid, noclipdata[playerid][flyobject]);
				noclipdata[playerid][mode]      = 0;
				noclipdata[playerid][accelmul]  = 0.0;
			}
			else
			{   // Indicates a new key has been pressed

			    // Get the direction the player wants to move as indicated by the keys
				noclipdata[playerid][mode] = GetMoveDirectionFromKeys(ud, lr);

				// Process moving the object the players camera is attached to
				MoveCamera(playerid);
			}
		}
		noclipdata[playerid][udold] = ud; noclipdata[playerid][lrold] = lr; // Store current keys pressed for comparison next update
		return 1;
	}
return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

SetPlayerMoney(playerid,money)
{
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid,money);
	return 1;
}


//--------------------------------------------------



//--------------------------------------------------


stock getFreeCarID()
{
	for(new i=0; i<sizeof(cInfo); i++)
	{
	    if(cInfo[i][id_x]==0)return i;
	}
	return 0;
}

public OnPlayerCarsLoad(playerid)
{
	new num_fields,num_rows;
	cache_get_row_count(num_rows);
	cache_get_field_count(num_fields);
	if(!num_rows)return 1;
	for(new i=0; i<num_rows; i++)
	{
	new id=getFreeCarID();
	sInfo[playerid][pfahrzeuge] = sInfo[playerid][pfahrzeuge] += id;
	cache_get_value_name_int(i,"model",cInfo[id][model]);
	cache_get_value_name_int(i,"besitzer",cInfo[id][besitzer]);
	cache_get_value_name_float(i,"x",cInfo[id][c_x]);
	cache_get_value_name_float(i,"y",cInfo[id][c_y]);
	cache_get_value_name_float(i,"z",cInfo[id][c_z]);
	cache_get_value_name_float(i,"r",cInfo[id][c_r]);
	cache_get_value_name_int(i,"id",cInfo[id][db_id]);
	cache_get_value_name_int(i,"f1",cInfo[id][farbe1]);
	cache_get_value_name_int(i,"f2",cInfo[id][farbe2]);
	cache_get_value_name_float(i,"dl",cInfo[id][dl]);
	cache_get_value_name(i,"Kennzeichen",cInfo[id][kennzeichen],128);
	cache_get_value_name_int(i,"tank",tank[cInfo[id][id_x]]);
	cInfo[id][abgeschlossen]=1;
	cInfo[id][id_x]=CreateVehicle(cInfo[id][model],cInfo[id][c_x],cInfo[id][c_y],cInfo[id][c_z],cInfo[id][c_r],cInfo[id][farbe1],cInfo[id][farbe2],-1);
	}
	return 1;
}

stock loadPlayerCars(playerid)
{
	new query[128];
	mysql_format(dbhandle,query,sizeof(query),"SELECT * FROM autos WHERE besitzer='%i'",sInfo[playerid][db_id]);
	mysql_tquery(dbhandle,query,"OnPlayerCarsLoad","d",playerid);
	return 1;
}




public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	//Aduty Management
	if(dialogid==DIALOG_FCARRD)
	{
	if(response)
	{
	if(listitem==0){
	CreateVehicle(416,2036.8435,-1423.9692,16.9922,181.0691,1,3,false,true);
	}
	if(listitem==1)
	{
	CreateVehicle(426,2036.8435,-1423.9692,16.9922,181.0691,3,3,0,true);
	}
	if(listitem==2)
	{
    CreateVehicle(586,2036.8435,-1423.9692,16.9922,181.0691,3,3,0,true);
	}
	if(listitem==3)
	{
	CreateVehicle(599,2036.8435,-1423.9692,16.9922,181.0691,3,1,0,true);
	}
	}}
	if(dialogid==DIALOG_SEIGABE)
	{
	if(response)
	{
		if(strlen(inputtext)>0)
		{
        PlayAudioStreamForPlayer(playerid,inputtext);
		}
	}
	}
	if(dialogid==DIALOG_ADUTY)
	{
	new string2[128],string[128],name[MAX_PLAYER_NAME];
	if(response)
 		{
 			if(listitem==0){
 			SetPlayerColor(playerid, COLOR_RED);
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun als ServerOwner im Dienst.", name);
            if(!isaduty(playerid)){
			SendClientMessageToAll(COLOR_RED, string);
			SetPVarInt(playerid,"aduty",1);
			TextDrawShowForPlayer(playerid,aduty_text);
			}
			else{
			format(string2, sizeof(string), "SERVER: %s {FFFFFF}ist nicht mehr im Dienst.", name);
			SendClientMessageToAll(COLOR_RED,string2);
			SetPVarInt(playerid,"aduty",0);
			TextDrawHideForPlayer(playerid,aduty_text);
			return 1;
			}
	 	}
		    if(listitem==1){
 			SetPlayerColor(playerid, COLOR_RED);
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun als Großmogul im Dienst.", name);
            if(!isaduty(playerid)){
			SendClientMessageToAll(COLOR_RED, string);
			SetPVarInt(playerid,"aduty",1);
			TextDrawShowForPlayer(playerid,aduty_text);
			}
			else{
			format(string2, sizeof(string), "SERVER: %s {FFFFFF}ist nicht mehr im Dienst.", name);
			SendClientMessageToAll(COLOR_RED,string2);
			SetPVarInt(playerid,"aduty",0);
			TextDrawHideForPlayer(playerid,aduty_text);
			return 1;
			}
		}
   			if(listitem==2){
 			SetPlayerColor(playerid, COLOR_RED);
            GetPlayerName(playerid, name, sizeof(name));
            format(string, sizeof(string), "SERVER: %s {FFFFFF}ist nun als größte Instanz des Servers im Dienst.", name);
            if(!isaduty(playerid)){
			SendClientMessageToAll(COLOR_RED, string);
			SetPVarInt(playerid,"aduty",1);
			TextDrawShowForPlayer(playerid,aduty_text);
			}
			else{
			format(string2, sizeof(string), "SERVER: %s {FFFFFF}ist nicht mehr im Dienst.", name);
			SendClientMessageToAll(COLOR_RED,string2);
			SetPVarInt(playerid,"aduty",0);
			TextDrawHideForPlayer(playerid,aduty_text);
			return 1;
			}
		}
			if(listitem==3){
			if(!isaduty(playerid)){
 			SetPlayerColor(playerid, COLOR_RED);
 			SendClientMessage(playerid, COLOR_WHITE, "Du bist nun silent Aduty");
			SetPVarInt(playerid,"aduty",1);
			TextDrawShowForPlayer(playerid,aduty_text);
			}
			else{
 			SetPlayerColor(playerid, COLOR_WHITE);
 			SendClientMessage(playerid, COLOR_WHITE, "Du bist nun nicht mehr silent Aduty");
			SetPVarInt(playerid,"aduty",0);
			TextDrawHideForPlayer(playerid,aduty_text);
			}
			return 1;
		}
	}
}

	if(dialogid==DIALOG_AUTOHAUS)
	{
	if(response)
	{
	//Autoverkauf
	new id=GetPVarInt(playerid,"buyCarID");
	if(GetPlayerMoney(playerid)<ahCars[id][c_preis])
	{
        SendClientMessage(playerid,COLOR_GREY,"Du hast nicht genug Geld bei dir.");
        RemovePlayerFromVehicle(playerid);
        return 1;
	}
	GivePlayerMoney(playerid,-ahCars[id][c_preis]);
	createCar(playerid,ahCars[id][model],aHinfo[ahCars[id][autohaus_id]][s_x],aHinfo[ahCars[id][autohaus_id]][s_y],aHinfo[ahCars[id][autohaus_id]][s_z],aHinfo[ahCars[id][autohaus_id]][s_r]);
	SendClientMessage(playerid,COLOR_YELLOW,"Du hast ein Auto erfolgreich gekauft");
	RemovePlayerFromVehicle(playerid);
	}
	else
	{
	RemovePlayerFromVehicle(playerid);
	SendClientMessage(playerid,COLOR_GREY,"Dann eben nicht...");
	}
	return 1;
	}
	if(dialogid==DIALOG_LOGIN)
	{
	    if(response)
	    {
	        new name[MAX_PLAYER_NAME],query[128],passwort[35];
	        GetPlayerName(playerid,name,sizeof(name));
	        if(strlen(inputtext)>0)
	        {
                mysql_escape_string(inputtext,passwort,sizeof(passwort));
	            mysql_format(dbhandle,query,sizeof(query),"SELECT * FROM user WHERE username='%s' AND passwort= MD5('%s')",name,passwort);
	            mysql_tquery(dbhandle,query,"OnPasswordResponse","d",playerid);
	        }
	        else
			{
				//Keine Eingabe
				SendClientMessage(playerid,COLOR_RED,"Gibt bitte dein Passwort ein.");
                ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_PASSWORD,"Login","Gibt bitte dein Passwort ein:","Okay","Abbrechen");
   			}
	    }
	    else
	    {
	        Kick(playerid);
	    }
	    return 1;
	}

	if(dialogid==DIALOG_REGISTER)
	{
	    if(response)
	    {
	        new name[MAX_PLAYER_NAME],query[128],passwort[35];
	        GetPlayerName(playerid,name,sizeof(name));
	        if(strlen(inputtext)>3)
	        {
	            //Registrierungsfunktion
	            mysql_escape_string(inputtext,passwort,sizeof(passwort));
	            mysql_format(dbhandle,query,sizeof(query),"INSERT INTO user (username,passwort) VALUES ('%s',MD5('%s')) ",name,passwort);
	            mysql_tquery(dbhandle,query,"OnPlayerRegister","d",playerid);
	            format(query,sizeof(query),"INSERT INTO pinfo (username,passwort) VALUES ('%s','%s')",name,passwort);
	            mysql_tquery(dbhandle,query,"OnPlayerRegister","r",sInfo[playerid]);

	        }
	        else
	        {
	            //Kleiner als 4 Zeichen
	            SendClientMessage(playerid,COLOR_RED,"Dein Passwort muss mindestens 4 Zeichen lang sein.");
	            ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_INPUT,"Registrierung","Gib bitte dein gewünschtes Passwort an:","Okay","Abbrechen");
	        }
	    }
	    else
	    {
	        Kick(playerid);
	        random(300);
	    }
	    return 1;
	}


	if(dialogid==DIALOG_STREAM)
	{
		if (response)
		{
			if(listitem==0)
			{
				StopAudioStreamForPlayer(playerid);
				SendClientMessage(playerid,COLOR_HGREEN,"Stream beendet.");
				return 1;
			}
			if(listitem==2)
			{
			PlayAudioStreamForPlayer(playerid, stream, 0.0,0.0,0.0, 1);
			SendClientMessage(playerid,COLOR_HGREEN,"Du hast das Radio angeschaltet. Viel Spaß beim Hören!");
			SetPVarInt(playerid,"streamon",1);
			return 1;
			}
			if(listitem==1)
			{
			PlayAudioStreamForPlayer(playerid,"http://radio.breakz.fm/listen.pls",0.0,0.0,0.0, 1);
			SendClientMessage(playerid,COLOR_HGREEN,"Du hast das Radio angeschaltet. Viel Spaß beim Hören!");
			SetPVarInt(playerid,"streamon",1);
			return 1;
			}
			if(listitem==3)
			{
			PlayAudioStreamForPlayer(playerid,"http://stream.ffn.de/radiobollerwagen/mp3-192",0.0,0.0,0.0, 1);
			SendClientMessage(playerid,COLOR_HGREEN,"Du hast das Radio angeschaltet. Viel Spaß beim Hören!");
			SetPVarInt(playerid,"streamon",1);
			return 1;
			}
			if(listitem==4)
			{
			PlayAudioStreamForPlayer(playerid,"	https://wdr-1live-live.icecastssl.wdr.de/wdr/1live/live/mp3/128/stream.mp3",0.0,0.0,0.0, 1);
			SendClientMessage(playerid,COLOR_HGREEN,"Du hast das Radio angeschaltet. Viel Spaß beim Hören!");
  			SetPVarInt(playerid,"streamon",1);
			return 1;
			}
			if(listitem==5)
			{
			PlayAudioStreamForPlayer(playerid, "https://streams.ilovemusic.de/iloveradio8.mp3",0.0,0.0,0.0, 1);
			SendClientMessage(playerid,COLOR_HGREEN,"Du hast das Radio angeschaltet. Viel Spaß beim Hören!");
  			SetPVarInt(playerid,"streamon",1);
			return 1;
			}
			else
			{
				SendClientMessage(playerid,COLOR_GREY,"Vorgang abgebrochen.");
			}
		}
	}





	if(dialogid==DIALOG_VSPAWN)
	{
	    if(response)
	    {
			if(listitem==0)
			{
			ShowPlayerDialog(playerid,DIALOG_ASPAWN,DIALOG_STYLE_LIST,"Eventsystem","Sultan\nInfernus\nHotring\nNRG\nTurismo\nComet","Weiter","Abbrechen");

			}
			if(listitem==1)
			{
            ShowPlayerDialog(playerid,DIALOG_BSPAWN,DIALOG_STYLE_LIST,"Eventsystem","Sqallo\nDinghy\nJetmax","Weiter","Abbrechen");
			}

			if(listitem==2)
			{
			ShowPlayerDialog(playerid,DIALOG_FSPAWN,DIALOG_STYLE_LIST,"Eventsystem","Dodo\nMaverick\nStuntplane\nRustler\nSparrow","Weiter","Abbrechen");
			}
	    }
	    else
	    {
	        SendClientMessage(playerid,COLOR_RED,"Vorgang abgebrochen.");
	    }
		return 1;
	}
	if(dialogid == ADMIN_NETSTATS_DIALOGID) {
		KillTimer(gNetStatsTimerId);
		gNetStatsPlayerId = INVALID_PLAYER_ID;
		return 1;
	}




	if(dialogid==DIALOG_ASPAWN)
	{
		new string[128];
	    if(response)
	    {
			if(listitem==0)
			{
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
            CreateVehicle(560,x,y,z,0,-1,-1,0,true);
            SendClientMessage(playerid, COLOR_GREEN,"ERFOLGREICH: {FFFFFF}Du hast ein Eventfahrzeug gespawnt.");
			format(string,sizeof(string),"ADMIN: {FFFFFF}%s hat ein Eventfahrzeug gespawned.",getPlayerName(playerid));
			SendAdminMessage(2,COLOR_YELLOW,string);
			}
			if(listitem==1)
			{
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
            CreateVehicle(411,x,y,z,0,-1,-1,0,true);
            SendClientMessage(playerid, COLOR_GREEN,"ERFOLGREICH: {FFFFFF}Du hast ein Eventfahrzeug gespawnt.");
			format(string,sizeof(string),"ADMIN: {FFFFFF}%s hat ein Eventfahrzeug gespawned.",getPlayerName(playerid));
			SendAdminMessage(2,COLOR_YELLOW,string);
			}

			if(listitem==2)
			{
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
            CreateVehicle(494,x,y,z,0,-1,-1,0,true);
            SendClientMessage(playerid, COLOR_GREEN,"ERFOLGREICH: {FFFFFF}Du hast ein Eventfahrzeug gespawnt.");
			format(string,sizeof(string),"ADMIN: {FFFFFF}%s hat ein Eventfahrzeug gespawned.",getPlayerName(playerid));
			SendAdminMessage(2,COLOR_YELLOW,string);
			}
			if(listitem==3)
			{
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
            CreateVehicle(522,x,y,z,0,-1,-1,0,false);
            SendClientMessage(playerid, COLOR_GREEN,"ERFOLGREICH: {FFFFFF}Du hast ein Eventfahrzeug gespawnt.");
			format(string,sizeof(string),"ADMIN: {FFFFFF}%s hat ein Eventfahrzeug gespawned.",getPlayerName(playerid));
			}

			if(listitem==4)
			{
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
            CreateVehicle(451,x,y,z,0,-1,-1,0,false);
            SendClientMessage(playerid, COLOR_GREEN,"ERFOLGREICH: {FFFFFF}Du hast ein Eventfahrzeug gespawnt.");
			format(string,sizeof(string),"ADMIN: {FFFFFF}%s hat ein Eventfahrzeug gespawned.",getPlayerName(playerid));
			}

			if(listitem==5)
			{
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
            CreateVehicle(480,x,y,z,0,-1,-1,0,false);
            SendClientMessage(playerid, COLOR_GREEN,"ERFOLGREICH: {FFFFFF}Du hast ein Eventfahrzeug gespawnt.");
			format(string,sizeof(string),"ADMIN: {FFFFFF}%s hat ein Eventfahrzeug gespawned.",getPlayerName(playerid));
			}

	    }
	    else
	    {
	        SendClientMessage(playerid,COLOR_RED,"Vorgang abgebrochen.");
	    }
		return 1;
	}
	if(dialogid==DIALOG_SPAWNCHANGE)
	{
	if(response)
	{
	if(listitem==0)
	{
	if(sInfo[playerid][pfraktion]==0){
	SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist in keiner Fraktion!");
	return 1;
	}
	new string[64] = "fraktion";
	sInfo[playerid][pspawnchange] = string;
	}
	if(listitem==1)
	{
	if(!hatPlayerHaus(playerid)){
	SendClientMessage(playerid,COLOR_RED,"FEHLER:{FFFFFF} Du besitzt kein Haus!");
	}else{
	new string[64] = "haus";
	sInfo[playerid][pspawnchange] = string;
	}}
	if(listitem==2)
	{
	new string[64] = "noob";
	sInfo[playerid][pspawnchange] = string;
	}
	if(listitem==3)
	{
	new string[64] = "lastpos";
	sInfo[playerid][pspawnchange] = string;
	GetPlayerPos(playerid,sInfo[playerid][sx],sInfo[playerid][sy],sInfo[playerid][sz]);
	}
	}
	else{
	SendClientMessage(playerid,COLOR_RED,"FEHLER: Vorgang abgebrochen!");}
	}


	if(dialogid==DIALOG_TP)
	{
	    if(response)
	    {
			if(listitem==0)
			{
			    //Spawn
	      		SetPlayerVirtualWorld(playerid,0);
			    SetPlayerInterior(playerid,0);
			    SetPlayerPos(playerid,199.0846,-150.0331,1.5781);
			}
			if(listitem==1)
			{
			    //Farm
	      		SetPlayerVirtualWorld(playerid,0);
			    SetPlayerInterior(playerid,0);
			    SetPlayerPos(playerid,1199.0903,-901.1480,48.0625);

			}

			if(listitem==2)
			{
			    //LSPD
			      SetPlayerVirtualWorld(playerid,0);
				  SetPlayerInterior(playerid,0);
			      SetPlayerPos(playerid,1539.6733,-1657.0175,13.5491);
			}
			if(listitem==3)
			{
			//Restaurant Blueberry
			SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid,212.1142,-202.1886,1.5781);
			}
			if(listitem==4)
			{
			//Taxijob
			SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid,1222.1434,-1815.5588,16.5938);
			}
			if(listitem==5)
			{
			//Pier
			SetPlayerVirtualWorld(playerid,0);
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid,369.6803,-2030.0925,7.6719);
			}
			if(listitem==6)
			{
			    //LS Airport
			    SetPlayerVirtualWorld(playerid,0);
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,1958.0535,-2182.1360,13.5469);
			}
	    }

	    else
	    {
	        SendClientMessage(playerid,COLOR_RED,"Vorgang abgebrochen.");
	    }
		return 1;
	}

	return 1;
}

CMD:trade(playerid,params[])
{
    ShowPlayerDialog(playerid, DIALOG_TRADE, DIALOG_STYLE_LIST, "Caption", "Item 0\n{FFFF00}Item 1\nItem 2", "Button 1", "Button 2");
	return 1;
}
CMD:nichts(playerid,params[])
{
SendClientMessage(playerid,0xFF9A00FF,"{35793B}GLÜCKWUNSCH: Dieser Befehl macht garnichts!");
return 1;
}
/*
OnPlayerClickPlayer(playerid, clickedplayerid, CLICK_SOURCE:source)
{
	return 0;
}*/

public NetStatsDisplay()
{
	new netstats_str[2048+1];
	GetNetworkStats(netstats_str, 2048);
	ShowPlayerDialog(gNetStatsPlayerId, ADMIN_NETSTATS_DIALOGID, DIALOG_STYLE_MSGBOX, "Server NetStats", netstats_str, "Ok", "");
}


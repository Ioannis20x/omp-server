public OnUserCheck(playerid)
{
	new num_rows,num_fields;
    cache_get_row_count(num_rows);
    cache_get_field_count(num_fields);
	if(num_rows==0)
	{
	    //Registrierung
	    ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_INPUT,"Registrierung","Willkommen auf " #SERVERNAME "\nBitte gebe dein gewünschtes Passwort ein und bestätige mit'Okay'.","Okay","Abbrechen");
	}
	else
	{
		new lstring[256];
		format(lstring,sizeof(lstring),"{00FF00}Dein Name wurde gefunden, bitte logge dich ein!\n\n{ff8800}Benutzername: {FFFFFF}%s\n\n\nBitte gib dein Passwort ein:",getPlayerName(playerid));
		//Login
	 	ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_PASSWORD,"Willkommen auf " #SERVERNAME ".",lstring,"Einloggen","Verlassen");
	}
	return 1;
}


public OnPlayerRegister(playerid)
{
	sInfo[playerid][eingeloggt] = 1;
	sInfo[playerid][pXPMax]=4;
	sInfo[playerid][db_id] = cache_insert_id();
	return 1;
}

stock savePlayer(playerid)
{
	if(sInfo[playerid][eingeloggt]==0)return 1;
	//speichern level,money
	new query[1024], Float:x,Float:y,Float:z;
	GetPlayerPos(playerid, x,y,z);
	mysql_format(dbhandle,query,sizeof(query),"UPDATE user SET level='%i',money='%i',adminlevel='%i',PayDay='%i',XP='%i',XPMax='%i', skin='%i',fraktion='%i',frang='%i',fleader='%i',fskin='%i',spawnchange='%s',x='%f',y='%f',z='%f',donut='%i', deaths='%i', orangelist='%i', green='%i', gold='%i', lsd='%i' WHERE id='%i'",
	GetPlayerScore(playerid),GetPlayerMoney(playerid),sInfo[playerid][padminlevel],sInfo[playerid][pPayDay],sInfo[playerid][pXP],sInfo[playerid][pXPMax],sInfo[playerid][pskin],sInfo[playerid][pfraktion],sInfo[playerid][pfrang],sInfo[playerid][pfleader],sInfo[playerid][pfSkin],sInfo[playerid][pspawnchange],sInfo[playerid][sx],sInfo[playerid][sy],sInfo[playerid][sz],sInfo[playerid][pdonut],sInfo[playerid][pdeaths],sInfo[playerid][pOL],sInfo[playerid][pgreen],sInfo[playerid][pgold],sInfo[playerid][plsd],sInfo[playerid][db_id]);
	mysql_tquery(dbhandle,query);
	return 1;
}

stock savesession(playerid){
	new lquery[1024];
	mysql_format(dbhandle,lquery,sizeof(lquery),"INSERT INTO sessions (playerid, login, logout) VALUES ('%i', '%s', '%s')",sInfo[playerid][db_id], sInfo[playerid][login],sInfo[playerid][logout]);
	mysql_tquery(dbhandle,lquery);
	print(lquery);
	return 1;
}

stock resetPlayer(playerid)
{	for(new i=0; i<sizeof(sInfo[]); i++)
	{
 		sInfo[playerid][playerInfo:i]=0;
	}
	sInfo[playerid][padminlevel] = 0;
	sInfo[playerid][eingeloggt] = 0;
	sInfo[playerid][pskin] = 0;
	KillTimer(payday[playerid]);
	print("SUFFLINE");
	return 1;

}

public OnPasswordResponse(playerid)
{
	new num_fields,num_rows;
	cache_get_row_count(num_rows);
	cache_get_field_count(num_fields);
	if(num_rows==1)
	{
		printf("%i",num_rows);
	    //Passwort richtig Spieler Laden
		cache_get_value_name_int(0,"id",sInfo[playerid][db_id]);
	    cache_get_value_name_int(0,"level",sInfo[playerid][plevel]);
	    SetPlayerScore(playerid,sInfo[playerid][plevel]);
        cache_get_value_name_int(0,"money",sInfo[playerid][pMoney]);
	    SetPlayerMoney(playerid,sInfo[playerid][pMoney]);
	    cache_get_value_name_int(0,"adminlevel",sInfo[playerid][padminlevel]);
        cache_get_value_name_int(0,"skin",sInfo[playerid][pskin]);
        cache_get_value_name_int(0,"fraktion",sInfo[playerid][pfraktion]);
        cache_get_value_name_int(0,"frang",sInfo[playerid][pfrang]);
		cache_get_value_name_int(0,"fleader",sInfo[playerid][pfleader]);
	    cache_get_value_name_int(0,"fskin",sInfo[playerid][pfSkin]);
		//Spawn    
	    cache_get_value_name(0,"spawnchange",sInfo[playerid][pspawnchange],128);
        cache_get_value_name_float(0,"x",sInfo[playerid][sx]);
        cache_get_value_name_float(0,"y",sInfo[playerid][sy]);
        cache_get_value_name_float(0,"z",sInfo[playerid][sz]);
		//Use
        cache_get_value_name_int(0,"green",sInfo[playerid][pgreen]);
        cache_get_value_name_int(0,"gold",sInfo[playerid][pgold]);
        cache_get_value_name_int(0,"lsd",sInfo[playerid][plsd]);
        cache_get_value_name_int(0,"donut",sInfo[playerid][pdonut]);
        cache_get_value_name_int(0,"deaths",sInfo[playerid][pdeaths]);
        cache_get_value_name_int(0,"orangelist",sInfo[playerid][pOL]);
		//Level & PayDay
		cache_get_value_name_int(0,"PayDay",sInfo[playerid][pPayDay]);
		cache_get_value_name_int(0,"XP",sInfo[playerid][pXP]);
		cache_get_value_name_int(0,"XPMax",sInfo[playerid][pXPMax]);
		
		payday[playerid]=SetTimerEx("PayDay",60000-(sInfo[playerid][pPayDay]*1000),true,"i",playerid);
		new skstring[256];
		format(skstring,sizeof(skstring),"%i",60000-(sInfo[playerid][pPayDay]*1000));
		SendClientMessage(playerid,COLOR_RED,skstring);
		SetSpawnInfo(playerid,NO_TEAM,sInfo[playerid][pskin],sInfo[playerid][sx],sInfo[playerid][sy],sInfo[playerid][sz],0,WEAPON_FIST,0,WEAPON_FIST,0,WEAPON_FIST,0);
		SpawnPlayer(playerid);
	   	loadPlayerCars(playerid);
	   	return 1;
	   	}

	else
	{
	    //Passwort falsch
	    SendClientMessage(playerid,COLOR_RED,"Das eingegebene Passwort ist falsch.");
		new lstring[256];
		format(lstring,sizeof(lstring),"{00FF00}Dein Name wurde gefunden, bitte logge dich ein!\n\n{ff8800}Benutzername: {FFFFFF}%s\n\n\nBitte gib dein Passwort ein:",getPlayerName(playerid));
	    //Login
	 	ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_PASSWORD,"Willkommen auf "#SERVERNAME ,lstring,"Einloggen","Verlassen");
		return 1;
	}
}

stock FraktionName(playerid){
	return fInfo[sInfo[playerid][pfraktion]][f_name];
}

forward PayDay(playerid);
public PayDay(playerid){
	new mstring[128];
	if(sInfo[playerid][pPayDay]>=60){
		//PayDay bekommen
		if(sInfo[playerid][pXP]>=sInfo[playerid][pXPMax]){
				
			sInfo[playerid][plevel]++;
			SetPlayerScore(playerid,sInfo[playerid][plevel]);
			sInfo[playerid][pXP]=sInfo[playerid][pXPMax]-sInfo[playerid][pXP];
			sInfo[playerid][pXPMax]=floatround(sInfo[playerid][pXPMax]*1.5,floatround_round);		
			format(mstring,sizeof(mstring),"ERFOLG: {FFFFFF}Du hast bist um ein Level aufgestiegen! Aktuelles Level: %i",sInfo[playerid][plevel]);
			SCM(playerid,COLOR_GREEN,mstring);		
		}
		if(sInfo[playerid][plevel]==10)
		{
			SCM(playerid,COLOR_YELLOW,"BONUS: {FFFFFF}Du hast Level 10 erreicht und erhälst dafür {880808}$10.000");
			SetPlayerMoney(playerid,10000);
		}
		
		SCM(playerid,COLOR_RED,"ACHTUNG: PAYDAY + 25$");
		GivePlayerMoney(playerid,25);
		sInfo[playerid][pPayDay]=0;
		sInfo[playerid][pXP]++;
		savePlayer(playerid);
		return 1;
		
	}else{
		sInfo[playerid][pPayDay]++;
		savePlayer(playerid);
	}
	return 1;
	
}
stock isPlayerinBadFrak(playerid){
	for(new i=0;i<=sizeof(badfraks);i++){
		if(sInfo[playerid][pfraktion]==badfraks[i])return 1;
		else{
		return 0;}
	}
	return 0;
}


stock isPlayerinStaat(playerid){
	if(sInfo[playerid][pfraktion]==1)return 1;
	else if(sInfo[playerid][pfraktion]==2)return 1;
	else if(sInfo[playerid][pfraktion]==3)return 1;
	else if(sInfo[playerid][pfraktion]==4)return 1;
	else if(sInfo[playerid][pfraktion]==7)return 1;
	else return 0;
}


stock isLeader(playerid){
	if(sInfo[playerid][pfleader] > 0)return 1;
	return 0;
}



public loadfraks()
{
	new query[1024];
	mysql_format(dbhandle,query,sizeof(query),"SELECT * FROM fraktionen ORDER BY id");
	mysql_tquery(dbhandle,query,"OnFraksLoad","r",fInfo);
	//loadfrakcars();
	return 1;
}

public OnFraksLoad()
{
    new string[128];
	new num_fields,num_rows;
 	cache_get_row_count(num_rows);
 	cache_get_field_count(num_fields);
	if(!num_rows){
		print("Keine FRAKTIONEN GEFUNDEN");
		SendRconCommand("exit");
		return 1;
	}
	for(new i=0; i<num_rows; i++)
	{
		cache_get_value_name_int(i,"id",fInfo[i][f_ID]);
		cache_get_value_name(i,"Name",fInfo[i][f_name],128);
		cache_get_value_name_float(i,"f_x",fInfo[i][f_x]);
		cache_get_value_name_float(i,"f_y",fInfo[i][f_y]);
		cache_get_value_name_float(i,"f_z",fInfo[i][f_z]);
		cache_get_value_name_int(i,"f_inter",fbase[i][f_inter]);
		cache_get_value_name_int(i,"f_world",fbase[i][f_world]);
		cache_get_value_name(i,"f_color",fbase[i][f_color],128);
		cache_get_value_name_float(i,"f_dutyx",fbase[i][f_dutyx]);
		cache_get_value_name_float(i,"f_dutyy",fbase[i][f_dutyy]);
		cache_get_value_name_float(i,"f_dutyz",fbase[i][f_dutyz]);
        cache_get_value_name_float(i,"f_enterx",fbase[i][f_enterx]);
        cache_get_value_name_float(i,"f_entery",fbase[i][f_entery]);
        cache_get_value_name_float(i,"f_enterz",fbase[i][f_enterz]);
        cache_get_value_name_float(i,"f_exitx",fbase[i][f_exitx]);
        cache_get_value_name_float(i,"f_exity",fbase[i][f_exity]);
        cache_get_value_name_float(i,"f_exitz",fbase[i][f_exitz]);
        cache_get_value_name_int(i,"Bank",fInfo[i][f_kasse]);
        cache_get_value_name_int(i,"Gold",fInfo[i][f_gold]);
        cache_get_value_name_int(i,"LSD",fInfo[i][f_lsd]);
        cache_get_value_name_int(i,"Green",fInfo[i][f_green]);
        cache_get_value_name(i,"FMOTD",fInfo[i][fmotd],128);
        cache_get_value_name(i,"rang0",fInfo[i][rangnull],75);
        cache_get_value_name(i,"rang1",fInfo[i][rangeins],75);
        cache_get_value_name(i,"rang2",fInfo[i][rangzwei],75);
        cache_get_value_name(i,"rang3",fInfo[i][rangdrei],75);
        cache_get_value_name(i,"rang4",fInfo[i][rangvier],75);
        cache_get_value_name(i,"rang5",fInfo[i][rangfunf],75);
        cache_get_value_name(i,"rang6",fInfo[i][rangsechs],75);
        cache_get_value_name_int(i,"ep",fInfo[i][ep]);
 		CreatePickup(1239,1,fbase[i][f_dutyx],fbase[i][f_dutyy],fbase[i][f_dutyz],0);
    	CreatePickup(1239,1,fbase[i][f_enterx],fbase[i][f_entery],fbase[i][f_enterz],0);
    	CreatePickup(1239,1,fbase[i][f_exitx],fbase[i][f_exity],fbase[i][f_exitz],0);
   		format(string,sizeof(string),"Fraktion: %s wurde Geladen",fInfo[i][f_name]);
		printf(string);
	}
	return 1;
}


stock SendFrakMessage(fraktid,color, const string[])
{

	for(new i = 0 ; i < MAX_PLAYERS ; i++)
	{
	    if(IsPlayerConnected(i) && sInfo[i][eingeloggt] == 1)
	    {
	        if(sInfo[i][pfraktion] == fraktid)
	        {
	            SendClientMessage(i, color, string);
			}
	    }
	}
	return 1;
}



stock isPlayerInFrak(playerid,f_id){
	if((sInfo[playerid][pfraktion]==f_id) || (sInfo[playerid][pfleader]==f_id))return 1;
	return 0;
}

stock SFM(playerid,msg[])
{
	new rank[128];
	if(sInfo[playerid][pfraktion]==0)return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du darfst diesen Befehl nicht nutzen.");
	if(isPlayerinStaat(playerid))return SendClientMessage(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du darfst diesen Befehl nicht nutzen.");
	new fID = sInfo[playerid][pfraktion];
	new frank = sInfo[playerid][frang];
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
		if(!isPlayerInFrak(i,fID))continue;
		SendClientMessage(i,COLOR_FCHAT,string);
	}
	return 1;
}



public savefraks()
{
	for(new i = 1; i<MAX_FRAKS;i++)
	{
	  	new query[2048];
		mysql_format(dbhandle,query,sizeof(query),"UPDATE fraktionen SET Bank='%i',Green='%i',Gold='%i',LSD='%i',FMOTD='%s', ep='%i' WHERE id='%i'",
		fInfo[i][f_kasse],fInfo[i][f_green],fInfo[i][f_gold],fInfo[i][f_lsd],fInfo[i][fmotd],fInfo[i][ep],fInfo[i][f_ID]);
		mysql_tquery(dbhandle,query);
		print(query);

	}
	return 1;
}

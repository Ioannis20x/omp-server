CMD:iraum(playerid,params[]){
    if(sInfo[playerid][eingeloggt]==0)return SCM(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht eingeloggt!");
	new option;
	//if(!IsPlayerInRangeOfPoint(playerid,2,-2235.0085,130.5629,1035.4141))return SEM(playerid, "Du bist nicht im IKEA");
	if(sscanf(params,"i",option))return WPM(playerid,"/iraum [iraum-ID]");
	new string[256];
	format(string,sizeof(string),"%i, %f, %f, %f",innenraum[option][i_int], innenraum[option][i_x], innenraum[option][i_y], innenraum[option][i_z]);
	SCM(playerid,COLOR_WHITE,string);
	SetPlayerInterior(playerid,innenraum[option][i_int]);
	SetPlayerVirtualWorld(playerid,innenraum[option][world]);
	SetPVarInt(playerid,"IKEA",option);
	SetPlayerPos(playerid, innenraum[option][i_x], innenraum[option][i_y], innenraum[option][i_z]+1);
	return 1;
}

CMD:exitiraum(playerid,params[])
{
	if(!GetPVarInt(playerid,"IKEA"))return SCM(playerid,COLOR_RED,"FEHLER: {FFFFFF}Du bist nicht in einem Innenraum vom IKEA.");
	SetPlayerVirtualWorld(playerid,2);
	SetPlayerPos(playerid,-2235.0085,130.5629,1035.4141);
	SetPlayerInterior(playerid,6);
	SCM(playerid,COLOR_GREEN,"ERFOLG: {FFFFFF}Du hast den Innenraum verlassen.");
	return 1;
}


CMD:showiraum(playerid,params[])
{
	new string[64];
	format(string,sizeof(string),"%i",sizeof(innenraum));
	SCM(playerid,COLOR_WHITE,string);
	return 1;
}

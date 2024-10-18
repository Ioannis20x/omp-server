CMD:exit(playerid,params[])
{
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
	for(new i=0; i<sizeof(fInfo);i++)
	{
	if(!IsPlayerInRangeOfPoint(playerid,10,fbase[i][f_exitx],fbase[i][f_exity],fbase[i][f_exitz]))continue;
	SetPlayerPos(playerid,fbase[i][f_enterx],fbase[i][f_entery],fbase[i][f_enterz]);
	SetPlayerInterior(playerid,0);
	SetPlayerVirtualWorld(playerid,0);
	}

	for(new i=0; i<sizeof(hInfo); i++)
	{
		if(GetPlayerVirtualWorld(playerid) !=i)continue;
		if(!IsPlayerInRangeOfPoint(playerid,10,hInfo[i][ih_x],hInfo[i][ih_y],hInfo[i][ih_z]))continue;
		SetPlayerPos(playerid,hInfo[i][h_x],hInfo[i][h_y],hInfo[i][h_z]);
		SetPlayerInterior(playerid,0);
		SetPlayerVirtualWorld(playerid,0);
	}
	return 1;
}


CMD:enter(playerid,params[])
{
	for(new i=0; i<sizeof(bInfo); i++)
	{
	if(!IsPlayerInRangeOfPoint(playerid,2,bInfo[i][b_x],bInfo[i][b_y],bInfo[i][b_z]))continue;
	SetPlayerPos(playerid,bInfo[i][b_ix],bInfo[i][b_iy],bInfo[i][b_iz]);
	SetPlayerInterior(playerid,bInfo[i][b_interior]);
	SetPlayerVirtualWorld(playerid,i);
	return 1;
	}

	if(IsPlayerInRangeOfPoint(playerid,1.5,1524.7957,-1678.0403,5.8906))
	{
	SetPlayerPos(playerid,208.3992,167.5560,1003.0234);
	SetPlayerInterior(playerid,3);
	}
	for(new i=0; i<sizeof(fInfo);i++)
	{
	if(!IsPlayerInRangeOfPoint(playerid,10,fbase[i][f_enterx],fbase[i][f_entery],fbase[i][f_enterz]))continue;
	SetPlayerInterior(playerid,fbase[i][f_inter]);
	SetPlayerVirtualWorld(playerid,fbase[i][f_world]);
	SetPlayerPos(playerid,fbase[i][f_exitx],fbase[i][f_exity],fbase[i][f_exitz]);
	}

	for(new i=0; i<sizeof(hInfo); i++)
	{
	if(!hInfo[i][h_id])continue;
	if(hInfo[i][ih_x] == 0)continue;
	if(!hInfo[i][h_interior])return SendClientMessage(playerid,COLOR_GREEN,"Dieses Haus besitzt keinen Innenraum");
	if(!IsPlayerInRangeOfPoint(playerid,2,hInfo[i][h_x],hInfo[i][h_y],hInfo[i][h_z]))continue;
	SetPlayerPos(playerid,hInfo[i][ih_x],hInfo[i][ih_y],hInfo[i][ih_z]);
	SetPlayerInterior(playerid,hInfo[i][h_interior]);
	SetPlayerVirtualWorld(playerid,i);
	return 1;
	}
	return 1;
}

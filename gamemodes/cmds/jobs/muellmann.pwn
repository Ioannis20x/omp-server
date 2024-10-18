//startm‹ll /startmuell
CMD:startmuell(playerid, params[])
{
	for(new i=0; i<sizeof(JPs); i++)
	{
	if(!IsPlayerInRangeOfPoint(playerid, 5, 1448.9958,-1847.5634,13.5469))return SendClientMessage(playerid, COLOR_RED, "Du kannst den Job hier nicht starten.");}
	new Float:xc, Float:yc, Float:zc, Float:ac;
	GetPlayerPos(playerid, xc, yc, zc);
	GetPlayerFacingAngle(playerid, ac);

	new vID = CreateVehicle(408, xc, yc, zc, ac, 1, 1, -1);

	SetPVarInt(playerid, "trash_car", vID);
	PutPlayerInVehicle(playerid, vID, 0);

	SetPlayerCheckpoint(playerid, tCPs[0][t_x], tCPs[0][t_y], tCPs[0][t_z], 5);

	SetPVarInt(playerid, "trash_cp", 0);
	SetPVarInt(playerid, "trash_job", 1);

 	return 1;
}

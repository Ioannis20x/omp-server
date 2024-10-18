enum playerInfo{
 	db_id,
	pName,
	eingeloggt,
	plevel,
 	padminlevel,
 	pskin,
	//Spawn
 	Float:sx,
 	Float:sy,
 	Float:sz,
	//Fraktion
 	pfSkin,
 	pfraktion,
 	pfrang,
 	pfleader,
 	pspawnchange[64],
	//Use
 	pdonut,
 	pgreen,
 	pgold,
 	plsd,
 	pdeaths,
 	pOL,
 	ptazer,
	pMoney,
	pwanteds,
	login[128],
	logout[128],
	pfahrzeuge[MAX_PLAYER_CARS],
	Float:dx,
	Float:dy,
	Float:dz,
	pPayDay,
	pXP,
	pXPMax
}

new payday[MAX_PLAYERS];
new sInfo[MAX_PLAYERS][playerInfo];

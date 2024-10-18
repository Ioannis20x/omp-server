CMD:stats(playerid,params){
	new sstring[2056];
	format(sstring,sizeof(sstring),"Name:\t\t\t%s\nLevel:\t\t\t%i\nPayDay in:\t\t%i Minuten\nRespektpunkte:\t%i/%i\nFraktion:\t\t%s",getPlayerName(playerid),sInfo[playerid][plevel],60-sInfo[playerid][pPayDay],sInfo[playerid][pXP],sInfo[playerid][pXPMax],fInfo[sInfo[playerid][pfraktion]][f_name]);
	ShowPlayerDialog(playerid,DIALOG_STATS,DIALOG_STYLE_LIST,#SERVERTAG " Statistiken",sstring,"Schlieﬂen","");
	return 1;
}

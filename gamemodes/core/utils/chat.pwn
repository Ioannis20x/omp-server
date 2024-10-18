//FEHLERMELDUNG
stock SEM(pID, const msg[])
{
	new string[128];
	format(string,sizeof(string),"FEHLER: {FFFFFF}%s",msg);
	SendClientMessage(pID,COLOR_RED,string);
	return 1;
}

//WPM WRONG PARAMETER MESSAGE
stock WPM(pID, const msg[])
{
	new string[128];
	format(string,sizeof(string),"INFO: %s",msg);
	SendClientMessage(pID,COLOR_GREY,string);
	return 1;
}

//SCM Send Client Message
stock SCM(pID, color, const msg[])
{
	SendClientMessage(pID,color,msg);
	return 1;
}


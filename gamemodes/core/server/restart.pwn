new restartcounter = 0;


stock restart(){
	savefraks();
	saveallplayers();
   	restartcounter = 1;
 	SendClientMessageToAll(COLOR_HRED, "SERVER: Server wird neugestartet.");
	SendRconCommand("gmx");

	return 1;
}



stock resetrestart()
{
restartcounter=0;
return 1;
}

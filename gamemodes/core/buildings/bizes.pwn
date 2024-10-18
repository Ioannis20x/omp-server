stock loadBizes(){
	for(new i=0; i<sizeof(bInfo); i++)
	{
		new string[32];
	 	CreatePickup(1239,1,bInfo[i][b_x],bInfo[i][b_y],bInfo[i][b_z],0);
	 	format(string,sizeof(string),"Geschäft: %s",bInfo[i][b_shopname]);
	    Create3DTextLabel(string,COLOR_ORANGE,bInfo[i][b_x],bInfo[i][b_y],bInfo[i][b_z]+0.25,10,0);
	 	Create3DTextLabel("Zum betreten /enter",COLOR_WHITE,bInfo[i][b_x],bInfo[i][b_y],bInfo[i][b_z],10,0,false);
	}
	return 1;
}
loadJobs()
{
for(new i=0; i<sizeof(JPs); i++)
	{
	new string[256];
	format(string,sizeof(string), "Job: %s",JPs[i][jobname]);
 	CreatePickup(1239,1,JPs[i][j_x],JPs[i][j_y],JPs[i][j_z],0);
    Create3DTextLabel(string,COLOR_ORANGE,JPs[i][j_x],JPs[i][j_y],JPs[i][j_z]+0.25,10,0);
 	Create3DTextLabel("Zum starten /startjob",COLOR_WHITE,JPs[i][j_x],JPs[i][j_y],JPs[i][j_z],10,0);
	return 1;
	 }
return 1;
}


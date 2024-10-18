stock saveFrakCarToDB(frakid,carid)
{
	new query[128];
 	format(query,sizeof(query),"INSERT INTO fvehicles (fraktion,model,x,y,z,r) VALUES ('%i','%i','%f','%f','%f','%f')",fInfo[frakid][db_id],cInfo[carid][model],cInfo[carid][c_x],cInfo[carid][c_y],cInfo[carid][c_z],cInfo[carid][c_r]);
	mysql_function_query(dbhandle,query,true,"","i",carid);
	return 1;
}



stock isPlayerInFrakVehicle(playerid,f_id)
{
	new vID = GetPlayerVehicleID(playerid);
	if(cInfo[vID][fraktion)==f_id)return 1;
	return 0;
}



stock createfCar(playerid,modelid,Float:x,Float:y,Float:z,Float:r,cl1,cl2)
{
	new Float:fcx,Float:fcy,Float:fcz;
	GetPlayerPos(playerid,fcx,fcy,fcz);
	for(new i=0; i<sizeof(cInfo); i++)
	{
	    if(cInfo[i][id_x]!=0)continue;
	    GetPlayerName(playerid,cInfo[i][besitzer],MAX_PLAYER_NAME);
		cInfo[i][fraktion]=sInfo[playerid][pfraktion];
		cInfo[i][c_x]=fcx;
	    cInfo[i][c_y]=fcy;
	    cInfo[i][c_z]=fcz;
	    cInfo[i][c_r]=r;
	    cInfo[i][model]= modelid;
	    cInfo[i][id_x] = CreateVehicle(modelid,x,y,z,r,cl1,cl2,0);
	    tank[cInfo[i][id_x]] = 100;
	    new string[128];
	    format(string,sizeof(string),"Das Auto cInfo[%i] wurde erstellt für die Fraktion %s erstellt.",modelid,fInfo[cInfo[i][fraktion]][f_name]);
	    SendClientMessage(playerid,COLOR_RED,string);

	    return 1;
	}
	return 1;
}

public loadfrakcars(){
	new query[1024];
	format(query,sizeof(query),"SELECT * FROM fvehicles");
	mysql_tquery(dbhandle,query,"OnFraksCarsLoad");
	
	return 1;
}

public OnFrakCarsLoad()
{
	new num_fields,num_rows;
	cache_get_row_count(num_rows);
	cache_get_field_count(num_fields);
	if(!num_rows)return 1;
	for(new i=0; i<num_rows; i++)
	{
		new id=getFreeCarID();
		cache_get_value_name_int(i,"id",fcar[id][fcarid]);
		cache_get_value_name_int(i,"model",fcar[id][model]);
		cache_get_value_name_int(i,"fraktion",fcar[id][fraktion]);
		cache_get_value_name_float(i,"x",fcar[id][fc_x]);
		cache_get_value_name_float(i,"y",fcar[id][fc_y]);
		cache_get_value_name_float(i,"z",fcar[id][fc_z]);
		cache_get_value_name_int(i,"f1",fcar[id][farbe1]);
		cache_get_value_name_int(i,"f2",fcar[id][farbe2]);
		cache_get_value_float(i,"r",fcar[id][fc_r]);
		cInfo[id][id_x]=CreateVehicle(fcar[id][model],fcar[id][fc_x],fcar[id][fc_y],fcar[id][fc_z],fcar[id][fc_r],fcar[id][farbe1],fcar[id][farbe2],0);
		cache_get_value_name(i,"Kennzeichen",fcar[id][kennzeichen],128);
		cache_get_value_int(i,"tank",tank[id]);
	}
	return 1;
}

stock saveHaus(id)
{
	new query[128];
	mysql_format(dbhandle,query, sizeof(query), "UPDATE haus SET besitzer='%s', h_preis='%i', h_interior='%i' WHERE id='%i'", hInfo[id][h_besitzer], hInfo[id][h_preis],hInfo[id][h_interior], hInfo[id][h_id]);
	mysql_tquery(dbhandle, query);
	return 1;
}

public OnHausCreated(id)
{
	hInfo[id][h_id]=cache_insert_id();
}


stock hatPlayerHaus(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	for(new i=0; i<sizeof(hInfo); i++)
	{
	    if(!hInfo[i][h_id])continue;
	    if(!strlen(hInfo[i][h_besitzer]))continue;
	    if(!strcmp(name, hInfo[i][h_besitzer], true))return 1;
	}
	return 0;
}

stock LoadHouses(){
	new query[128];
	mysql_format(dbhandle,query,sizeof(query), "SELECT * FROM haus");
	mysql_tquery(dbhandle,query,"OnHausesLoad");	
	return 1;
}


public OnHausesLoad()
{
    new num_fields,num_rows;
    cache_get_row_count(num_rows);
    cache_get_field_count(num_fields);
	if(!num_rows)return 1;
	for(new i=0; i<num_rows; i++)
	{
		new id=getFreeHausID();
  		cache_get_value_name_float(i,"h_x",hInfo[id][h_x]);
  		cache_get_value_name_float(i,"h_y",hInfo[id][h_y]);
  		cache_get_value_name_float(i,"h_z",hInfo[id][h_z]);
  		cache_get_value_name_float(i,"ih_x",hInfo[id][ih_x]);
  		cache_get_value_name_float(i,"ih_y",hInfo[id][ih_x]);
  		cache_get_value_name_float(i,"ih_z",hInfo[id][ih_x]);
		cache_get_value_name_int(i,"h_interior",hInfo[id][h_interior]);
		new tmp_name[128];
		cache_get_value_name(i,"besitzer",tmp_name,128);
		strmid(hInfo[id][h_besitzer], tmp_name, 0, sizeof(tmp_name), sizeof(tmp_name));
		cache_get_value_name_int(i,"id",hInfo[id][h_id]);
		cache_get_value_name_int(i,"h_preis",hInfo[id][h_preis]);
		cache_get_value_name_int(i,"h_level",hInfo[id][h_level]);
		updateHaus(id);
	}
	return 1;
}





stock updateHaus(id)
{
    new string[128];
	if(hInfo[id][h_pickup])
	{
	    DestroyPickup(hInfo[id][h_pickup]);
	}
	if(hInfo[id][h_text])
	{
	    Delete3DTextLabel(hInfo[id][h_text]);
	}
    if(!strlen(hInfo[id][h_besitzer]))
	{
		hInfo[id][h_pickup]=CreatePickup(1273, 1, hInfo[id][h_x], hInfo[id][h_y], hInfo[id][h_z], -1);
		format(string,sizeof(string), "Zum Verkauf\nKosten: $%i\nLevel: %i\n/buyhouse", hInfo[id][h_preis],hInfo[id][h_level]);
		hInfo[id][h_text]=Create3DTextLabel(string, COLOR_RED, hInfo[id][h_x], hInfo[id][h_y], hInfo[id][h_z], 10, 0, true);
	}
	else
	{
		hInfo[id][h_pickup]=CreatePickup(1239, 1, hInfo[id][h_x], hInfo[id][h_y], hInfo[id][h_z], -1);
		format(string,sizeof(string), "Besitzer: %s\n/enter", hInfo[id][h_besitzer]);
		hInfo[id][h_text]=Create3DTextLabel(string, COLOR_HGREEN, hInfo[id][h_x], hInfo[id][h_y], hInfo[id][h_z], 10, 0, true);
	}
	return 1;
}

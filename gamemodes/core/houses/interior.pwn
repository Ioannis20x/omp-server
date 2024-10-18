public loadiraum()
{
	new query[1024];
	mysql_format(dbhandle,query,sizeof(query),"SELECT * FROM iraum ORDER BY id");
	mysql_tquery(dbhandle,query,"OnIraumLoad","");
	return 1;
}

public OnIraumLoad()
{
	new num_fields,num_rows;
	cache_get_row_count(num_rows);
	cache_get_field_count(num_fields);
	if(!num_rows)return 1;
	for(new i=0; i<num_rows; i++)
	{
		cache_get_value_name_float(i,"x",innenraum[i][i_x]);
		cache_get_value_name_float(i,"y",innenraum[i][i_y]);
		cache_get_value_name_float(i,"z",innenraum[i][i_z]);
		cache_get_value_name_float(i,"r",innenraum[i][i_r]);
		cache_get_value_name_int(i,"world",innenraum[i][world]);
		cache_get_value_name_int(i,"interior",innenraum[i][i_int]);
	}
	return 1;
}


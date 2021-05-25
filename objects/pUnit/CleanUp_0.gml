if(ds_exists(threatTable, ds_type_map))
{
	ds_map_destroy(threatTable);
}

if(ds_exists(actionTable, ds_type_list))
{
	ds_list_destroy(actionTable);
}

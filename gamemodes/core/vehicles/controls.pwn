stock isMotorOn(vID)
{
	new bool:tmp_engine, bool:tmp_light, bool:tmp_alarm, bool:tmp_doors, bool:tmp_bonnet,bool:tmp_boot, bool:tmp_objective;
	GetVehicleParamsEx(vID, tmp_engine, tmp_light, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);
	if(tmp_engine == true)return 1;
	return 0;
}

stock stopMotor(vID)
{
    new bool:tmp_engine, bool:tmp_light, bool:tmp_alarm, bool:tmp_doors, bool:tmp_bonnet, bool:tmp_boot, bool:tmp_objective;
	GetVehicleParamsEx(vID, tmp_engine, tmp_light, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);
	SetVehicleParamsEx(vID, false, tmp_light, tmp_alarm, tmp_doors, tmp_bonnet, tmp_boot, tmp_objective);
	return 1;
}

stock hatAutoMotor(vID)
{
	new vModel = GetVehicleModel(vID);

    for(new i=0; i<sizeof(autosOhneMotor); i++)
    {
   		if(autosOhneMotor[i]!=vModel)continue;
   		return 0;
	}
	return 1;
}


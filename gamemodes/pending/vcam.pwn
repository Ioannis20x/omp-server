new pVCam[MAX_PLAYERS] = {-1, ...};



CMD:vcam(playerid,params[])
{
new pID, Float:x, Float:y, Float:dist = 5.0, Float:z, Float:vehx, Float:vehy, Float:vehz, playerVehicle;
if(sscanf(params,"u",pID))return WPM(playerid,"/vcam [playerid]");
if (!IsPlayerConnected(pID)) return SEM(playerid,"Diese ID geh?rt keinem Spieler.");

if (!IsPlayerInAnyVehicle(pID))
{SEM(playerid, "Der Spieler sitzt in keinem Fahrzeug.");
 SetCameraBehindPlayer(playerid);
 pVCam[playerid] = -1;
 return 1;
}


stock GetPosHinterVeh(vehicleid, Float:dist, &Float:x, &Float:y, &Float:z) //Jeffry
{
new Float:a;
GetVehicleZAngle(vehicleid, a);
GetVehiclePos(vehicleid, x, y, z);
x += (-dist * floatsin(-a, degrees));
y += (-dist * floatcos(-a, degrees));
return true;
}


CMD:vcam(playerid,params[])
{
new pID, Float:x, Float:y, Float:dist = 5.0, Float:z, Float:vehx, Float:vehy, Float:vehz, playerVehicle;
if(sscanf(params,"u",pID))return WPM(playerid,"/vcam [playerid]");
if (!IsPlayerConnected(pID)) return SEM(playerid,"Diese ID geh?rt keinem Spieler.");

if (!IsPlayerInAnyVehicle(pID))
{SEM(playerid, "Der Spieler sitzt in keinem Fahrzeug.");
 SetCameraBehindPlayer(playerid);
 pVCam[playerid] = -1;
 return 1;
}

//Funktion
pVCam[playerid] = pID;
playerVehicle = GetPlayerVehicleID(pID);
GetPlayerPos(pID, x, y, z);
GetPosHinterVeh(playerVehicle, dist, vehx, vehy, vehz);
InterpolateCameraLookAt(playerid, x, y, z, vehx, vehy, vehz,1000, CAMERA_CUT);
InterpolateCameraPos(playerid, vehx, vehy, vehz+1, x, y, z, 1000, CAMERA_CUT);
return 1;
}


CMD:stopvcam(playerid,params[])
{
SetCameraBehindPlayer(playerid);
pVCam[playerid] = -1;
return 1;
}

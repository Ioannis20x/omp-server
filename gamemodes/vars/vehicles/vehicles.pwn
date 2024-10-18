#define MAX_PLAYER_CARS 5

enum carenum{
	model,
	id_x,
	besitzer[MAX_PLAYER_NAME],
	Float:c_x,
	Float:c_y,
	Float:c_z,
	Float:c_r,
 	db_id,
 	farbe1,
 	farbe2,
 	kennzeichen,
 	fraktion,
	Float:dl,
	abgeschlossen
}

new cInfo[50][carenum];
new autosOhneMotor[] = {509,510,481};
new tank[2000];
new tanktimer = 0;

#define MAX_FRAKS 20

enum frakenum{
	f_ID,
	f_name[128],
	Float:f_x,
	Float:f_y,
	Float:f_z,
	Float:f_r,
	f_green,
	f_gold,
	f_lsd,
	f_kasse,
	fmotd[128],
	ep,
	rangnull[75],
	rangeins[75],
	rangzwei[75],
	rangdrei[75],
	rangvier[75],
	rangfunf[75],
	rangsechs[75]
}

new fInfo[MAX_FRAKS][frakenum];

new badfraks[9] = {5,6,10,11,13,14,17,18,19};


enum fbaseenum{
	fb_id,
	f_inter,
	f_world,
	f_color,
	Float:f_dutyx,
	Float:f_dutyy,
	Float:f_dutyz,
	Float:f_enterx,
	Float:f_entery,
	Float:f_enterz,
	Float:f_exitx,
	Float:f_exity,
	Float:f_exitz,
}
new fbase[MAX_FRAKS][fbaseenum];

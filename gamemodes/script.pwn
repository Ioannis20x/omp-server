//Projekt by Ioannis20x(Ioannis_Gutenberg)
//Alle Rechte bei Ioannis20x

//includes
#include <open.mp>
#include <fixes>
#include <streamer>
#include <a_mysql>
#include <zCMD>
#include <sscanf2>
#include <cef>
//#include <color>

//141.11.196.206:7777
/*Fraktionen
0: Zivilisten
1: SAPD
2: FBI
3: San Andreas Army
4: San Andreas Rettungsdienst
5: LCN
6: Yaki
7: Regierung
8: Hitman
9: San Andreas Media AG
10:	Ironbutts
11: Scarfo
12: Ballas Family
13: Grove Street
14: Terrors
15: Triaden
16: Korsakow
17: LV
18: DMV
19: SA:TT
*/

#include "core/server/config.pwn"

new MySQL:dbhandle;

main()
{
	print("Ioannis Testserver");
	print("Copyright (c) 2019 - 2024 by Ioannis20x - Alle Rechte vorbehalten.\n");
}

//UTILS
#include "core/utils/colors"
#include "core/utils/chat"
#include "core/utils/globalfuncs"

//forwards
#include "/main/forwards"


//variablen
#include "vars/ui/basicTD"
#include "vars/ui/dialogs"

#include "vars/server/netstat"
#include "vars/server/mapping"

#include "vars/admin/noclip"

#include "vars/buildings/buildings"
#include "vars/buildings/autohaus"

#include "vars/faction/faction"
#include "vars/faction/fvehicles"

#include "vars/houses/houses"
#include "vars/houses/interior"

#include "vars/jobs/jobs"
#include "vars/jobs/busfahrer"
#include "vars/jobs/muellmann"

#include "vars/vehicles/vehicles"
#include "vars/vehicles/autohaus"

#include "vars/player/player"
#include "vars/player/chat"

//MAIN core

#include "core/general/weather"

#include "core/server/restart"

#include "core/admin/admin"
#include "core/admin/flymode"

#include "core/buildings/autohaus"
#include "core/buildings/bizes"

#include "core/faction/faction"
#include "core/faction/fvehicles"
#include "core/faction/newsreporter"

#include "core/houses/houses"
#include "core/houses/interior"

#include "core/jobs/jobs"

#include "core/player/player"

#include "core/vehicles/vehicles"
#include "core/vehicles/controls"
#include "core/ui/cef"




//COMMANDS
#include "cmds/admin/general"
#include "cmds/admin/admin"
#include "cmds/admin/moderator"
#include "cmds/admin/sadmin"
#include "cmds/admin/owner"
#include "cmds/player/player"


#include "cmds/events/xmas"

#include "cmds/faction/general"
#include "cmds/faction/newsreporter"

#include "cmds/general/ikea"
#include "cmds/general/enterexit"

#include "cmds/jobs/muellmann"

//mappings
#include "mappings/xmas"

#include "main/gamemode"


data
align 4
LABELV MonthAbbrev
address $88
address $89
address $90
address $91
address $92
address $93
address $94
address $95
address $96
address $97
address $98
address $99
align 4
LABELV skillLevels
address $100
address $101
address $102
address $103
address $104
align 4
LABELV numSkillLevels
byte 4 5
align 4
LABELV netSources
address $105
address $106
address $107
address $108
align 4
LABELV numNetSources
byte 4 4
align 4
LABELV serverFilters
address $109
address $110
align 4
LABELV teamArenaGameTypes
address $111
address $112
address $113
address $114
address $115
address $116
address $117
address $118
address $119
address $120
align 4
LABELV numTeamArenaGameTypes
byte 4 10
align 4
LABELV teamArenaGameNames
address $121
address $122
address $123
address $124
address $125
address $126
address $127
address $128
address $129
address $130
align 4
LABELV numTeamArenaGameNames
byte 4 10
align 4
LABELV numServerFilters
byte 4 1
align 4
LABELV sortKeys
address $131
address $132
address $133
address $134
address $135
align 4
LABELV numSortKeys
byte 4 5
align 4
LABELV netnames
address $136
address $137
address $138
byte 4 0
align 4
LABELV gamecodetoui
byte 4 4
byte 4 2
byte 4 3
byte 4 0
byte 4 5
byte 4 1
byte 4 6
align 4
LABELV uitogamecode
byte 4 4
byte 4 6
byte 4 2
byte 4 3
byte 4 1
byte 4 5
byte 4 7
export vmMain
code
proc vmMain 12 8
file "..\..\..\..\code\ui\ui_main.c"
line 140
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/*
;4:=======================================================================
;5:
;6:USER INTERFACE MAIN
;7:
;8:=======================================================================
;9:*/
;10:
;11:// use this to get a demo build without an explicit demo build, i.e. to get the demo ui files to build
;12://#define PRE_RELEASE_TADEMO
;13:
;14:#include "ui_local.h"
;15:
;16:uiInfo_t uiInfo;
;17:
;18:static const char *MonthAbbrev[] = {
;19:	"Jan","Feb","Mar",
;20:	"Apr","May","Jun",
;21:	"Jul","Aug","Sep",
;22:	"Oct","Nov","Dec"
;23:};
;24:
;25:
;26:static const char *skillLevels[] = {
;27:  "I Can Win",
;28:  "Bring It On",
;29:  "Hurt Me Plenty",
;30:  "Hardcore",
;31:  "Nightmare"
;32:};
;33:
;34:static const int numSkillLevels = sizeof(skillLevels) / sizeof(const char *);
;35:
;36:
;37:static const char *netSources[] = {
;38:	"Local",
;39:	"Mplayer",
;40:	"Internet",
;41:	"Favorites"
;42:};
;43:static const int numNetSources = sizeof(netSources) / sizeof(const char *);
;44:
;45:static const serverFilter_t serverFilters[] = {
;46:	{"All", "" }
;47:};
;48:
;49:static const char *teamArenaGameTypes[] = {
;50:	"FFA",
;51:	"TOURNAMENT",
;52:	"SP",
;53:	"TEAM DM",
;54:	"CA",
;55:	"CTF",
;56:	"1FCTF",
;57:	"OVERLOAD",
;58:	"HARVESTER",
;59:	"TEAMTOURNAMENT"
;60:};
;61:
;62:static int const numTeamArenaGameTypes = sizeof(teamArenaGameTypes) / sizeof(const char *);
;63:
;64:
;65:static const char *teamArenaGameNames[] = {
;66:	"Free For All",
;67:	"Tournament",
;68:	"Single Player",
;69:	"Team Deathmatch",
;70:	"Clan Arena",
;71:	"Capture the Flag",
;72:	"One Flag CTF",
;73:	"Overload",
;74:	"Harvester",
;75:	"Team Tournament",
;76:};
;77:
;78:static int const numTeamArenaGameNames = sizeof(teamArenaGameNames) / sizeof(const char *);
;79:
;80:
;81:static const int numServerFilters = sizeof(serverFilters) / sizeof(serverFilter_t);
;82:
;83:static const char *sortKeys[] = {
;84:	"Server Name",
;85:	"Map Name",
;86:	"Open Player Spots",
;87:	"Game Type",
;88:	"Ping Time"
;89:};
;90:static const int numSortKeys = sizeof(sortKeys) / sizeof(const char *);
;91:
;92:static char *netnames[] = {
;93:	"???",
;94:	"UDP",
;95:	"IPX",
;96:	NULL
;97:};
;98:
;99:static int gamecodetoui[] = { 4,2,3,0,5,1,6 };
;100:static int uitogamecode[] = { 4,6,2,3,1,5,7 };
;101:
;102:
;103:static void UI_StartServerRefresh(qboolean full);
;104:static void UI_StopServerRefresh(void);
;105:static void UI_DoServerRefresh(void);
;106:static void UI_FeederSelection(float feederID, int index);
;107:static void UI_BuildServerDisplayList(qboolean force);
;108:static void UI_BuildServerStatus(qboolean force);
;109:static void UI_BuildFindPlayerList(qboolean force);
;110:static int QDECL UI_ServersQsortCompare(const void *arg1, const void *arg2);
;111:static int UI_MapCountByGameType(qboolean singlePlayer);
;112:static int UI_HeadCountByTeam(void);
;113:static void UI_ParseGameInfo(const char *teamFile);
;114:static void UI_ParseTeamInfo(const char *teamFile);
;115:static const char *UI_SelectedMap(int index, int *actual);
;116:static const char *UI_SelectedHead(int index, int *actual);
;117:static int UI_GetIndexFromSelection(int actual);
;118:
;119:int ProcessNewUI(int command, int arg0, int arg1, int arg2, int arg3, int arg4, int arg5, int arg6);
;120:
;121:/*
;122:================
;123:vmMain
;124:
;125:This is the only way control passes into the module.
;126:This must be the very first function compiled into the .qvm file
;127:================
;128:*/
;129:vmCvar_t  ui_new;
;130:vmCvar_t  ui_debug;
;131:vmCvar_t  ui_initialized;
;132:vmCvar_t  ui_teamArenaFirstRun;
;133:
;134:void _UI_Init(qboolean);
;135:void _UI_Shutdown(void);
;136:void _UI_KeyEvent(int key, qboolean down);
;137:void _UI_MouseEvent(int dx, int dy);
;138:void _UI_Refresh(int realtime);
;139:qboolean _UI_IsFullscreen(void);
;140:int vmMain(int command, int arg0, int arg1, int arg2, int arg3, int arg4, int arg5, int arg6, int arg7, int arg8, int arg9, int arg10, int arg11) {
line 141
;141:	switch (command) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $140
ADDRLP4 0
INDIRI4
CNSTI4 10
GTI4 $140
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $153
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $153
address $142
address $143
address $144
address $145
address $146
address $147
address $148
address $149
address $150
address $151
address $152
code
LABELV $142
line 143
;142:	case UI_GETAPIVERSION:
;143:		return UI_API_VERSION;
CNSTI4 6
RETI4
ADDRGP4 $139
JUMPV
LABELV $143
line 146
;144:
;145:	case UI_INIT:
;146:		_UI_Init(arg0);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 _UI_Init
CALLV
pop
line 147
;147:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $139
JUMPV
LABELV $144
line 150
;148:
;149:	case UI_SHUTDOWN:
;150:		_UI_Shutdown();
ADDRGP4 _UI_Shutdown
CALLV
pop
line 151
;151:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $139
JUMPV
LABELV $145
line 154
;152:
;153:	case UI_KEY_EVENT:
;154:		_UI_KeyEvent(arg0, arg1);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 _UI_KeyEvent
CALLV
pop
line 155
;155:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $139
JUMPV
LABELV $146
line 158
;156:
;157:	case UI_MOUSE_EVENT:
;158:		_UI_MouseEvent(arg0, arg1);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 _UI_MouseEvent
CALLV
pop
line 159
;159:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $139
JUMPV
LABELV $147
line 162
;160:
;161:	case UI_REFRESH:
;162:		_UI_Refresh(arg0);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 _UI_Refresh
CALLV
pop
line 163
;163:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $139
JUMPV
LABELV $148
line 166
;164:
;165:	case UI_IS_FULLSCREEN:
;166:		return _UI_IsFullscreen();
ADDRLP4 4
ADDRGP4 _UI_IsFullscreen
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $139
JUMPV
LABELV $149
line 169
;167:
;168:	case UI_SET_ACTIVE_MENU:
;169:		_UI_SetActiveMenu(arg0);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 _UI_SetActiveMenu
CALLV
pop
line 170
;170:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $139
JUMPV
LABELV $150
line 173
;171:
;172:	case UI_CONSOLE_COMMAND:
;173:		return UI_ConsoleCommand(arg0);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 UI_ConsoleCommand
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $139
JUMPV
LABELV $151
line 176
;174:
;175:	case UI_DRAW_CONNECT_SCREEN:
;176:		UI_DrawConnectScreen(arg0);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UI_DrawConnectScreen
CALLV
pop
line 177
;177:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $139
JUMPV
LABELV $152
line 179
;178:	case UI_HASUNIQUECDKEY: // mod authors need to observe this
;179:		return qtrue; // bk010117 - change this to qfalse for mods!
CNSTI4 1
RETI4
ADDRGP4 $139
JUMPV
LABELV $140
line 183
;180:
;181:	}
;182:
;183:	return -1;
CNSTI4 -1
RETI4
LABELV $139
endproc vmMain 12 8
export AssetCache
proc AssetCache 84 8
line 188
;184:}
;185:
;186:
;187:
;188:void AssetCache() {
line 194
;189:	int n;
;190:	//if (Assets.textFont == NULL) {
;191:	//}
;192:	//Assets.background = trap_R_RegisterShaderNoMip( ASSET_BACKGROUND );
;193:	//Com_Printf("Menu Size: %i bytes\n", sizeof(Menus));
;194:	uiInfo.uiDC.Assets.gradientBar = trap_R_RegisterShaderNoMip(ASSET_GRADIENTBAR);
ADDRGP4 $157
ARGP4
ADDRLP4 4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61660
ADDRLP4 4
INDIRI4
ASGNI4
line 195
;195:	uiInfo.uiDC.Assets.fxBasePic = trap_R_RegisterShaderNoMip(ART_FX_BASE);
ADDRGP4 $160
ARGP4
ADDRLP4 8
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61768
ADDRLP4 8
INDIRI4
ASGNI4
line 196
;196:	uiInfo.uiDC.Assets.fxPic[0] = trap_R_RegisterShaderNoMip(ART_FX_RED);
ADDRGP4 $163
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61772
ADDRLP4 12
INDIRI4
ASGNI4
line 197
;197:	uiInfo.uiDC.Assets.fxPic[1] = trap_R_RegisterShaderNoMip(ART_FX_YELLOW);
ADDRGP4 $167
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61772+4
ADDRLP4 16
INDIRI4
ASGNI4
line 198
;198:	uiInfo.uiDC.Assets.fxPic[2] = trap_R_RegisterShaderNoMip(ART_FX_GREEN);
ADDRGP4 $171
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61772+8
ADDRLP4 20
INDIRI4
ASGNI4
line 199
;199:	uiInfo.uiDC.Assets.fxPic[3] = trap_R_RegisterShaderNoMip(ART_FX_TEAL);
ADDRGP4 $175
ARGP4
ADDRLP4 24
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61772+12
ADDRLP4 24
INDIRI4
ASGNI4
line 200
;200:	uiInfo.uiDC.Assets.fxPic[4] = trap_R_RegisterShaderNoMip(ART_FX_BLUE);
ADDRGP4 $179
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61772+16
ADDRLP4 28
INDIRI4
ASGNI4
line 201
;201:	uiInfo.uiDC.Assets.fxPic[5] = trap_R_RegisterShaderNoMip(ART_FX_CYAN);
ADDRGP4 $183
ARGP4
ADDRLP4 32
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61772+20
ADDRLP4 32
INDIRI4
ASGNI4
line 202
;202:	uiInfo.uiDC.Assets.fxPic[6] = trap_R_RegisterShaderNoMip(ART_FX_WHITE);
ADDRGP4 $187
ARGP4
ADDRLP4 36
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61772+24
ADDRLP4 36
INDIRI4
ASGNI4
line 203
;203:	uiInfo.uiDC.Assets.scrollBar = trap_R_RegisterShaderNoMip(ASSET_SCROLLBAR);
ADDRGP4 $190
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61680
ADDRLP4 40
INDIRI4
ASGNI4
line 204
;204:	uiInfo.uiDC.Assets.scrollBarArrowDown = trap_R_RegisterShaderNoMip(ASSET_SCROLLBAR_ARROWDOWN);
ADDRGP4 $193
ARGP4
ADDRLP4 44
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61668
ADDRLP4 44
INDIRI4
ASGNI4
line 205
;205:	uiInfo.uiDC.Assets.scrollBarArrowUp = trap_R_RegisterShaderNoMip(ASSET_SCROLLBAR_ARROWUP);
ADDRGP4 $196
ARGP4
ADDRLP4 48
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61664
ADDRLP4 48
INDIRI4
ASGNI4
line 206
;206:	uiInfo.uiDC.Assets.scrollBarArrowLeft = trap_R_RegisterShaderNoMip(ASSET_SCROLLBAR_ARROWLEFT);
ADDRGP4 $199
ARGP4
ADDRLP4 52
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61672
ADDRLP4 52
INDIRI4
ASGNI4
line 207
;207:	uiInfo.uiDC.Assets.scrollBarArrowRight = trap_R_RegisterShaderNoMip(ASSET_SCROLLBAR_ARROWRIGHT);
ADDRGP4 $202
ARGP4
ADDRLP4 56
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61676
ADDRLP4 56
INDIRI4
ASGNI4
line 208
;208:	uiInfo.uiDC.Assets.scrollBarThumb = trap_R_RegisterShaderNoMip(ASSET_SCROLL_THUMB);
ADDRGP4 $205
ARGP4
ADDRLP4 60
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61684
ADDRLP4 60
INDIRI4
ASGNI4
line 209
;209:	uiInfo.uiDC.Assets.sliderBar = trap_R_RegisterShaderNoMip(ASSET_SLIDER_BAR);
ADDRGP4 $208
ARGP4
ADDRLP4 64
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61700
ADDRLP4 64
INDIRI4
ASGNI4
line 210
;210:	uiInfo.uiDC.Assets.sliderThumb = trap_R_RegisterShaderNoMip(ASSET_SLIDER_THUMB);
ADDRGP4 $211
ARGP4
ADDRLP4 68
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61704
ADDRLP4 68
INDIRI4
ASGNI4
line 212
;211:
;212:	for (n = 0; n < NUM_CROSSHAIRS; n++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $212
line 213
;213:		uiInfo.uiDC.Assets.crosshairShader[n] = trap_R_RegisterShaderNoMip(va("gfx/2d/crosshair%c", 'a' + n));
ADDRGP4 $218
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 97
ADDI4
ARGI4
ADDRLP4 76
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+228+61800
ADDP4
ADDRLP4 80
INDIRI4
ASGNI4
line 214
;214:	}
LABELV $213
line 212
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $212
line 216
;215:
;216:	uiInfo.newHighScoreSound = trap_S_RegisterSound("sound/feedback/voc_newhighscore.wav", qfalse);
ADDRGP4 $220
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 72
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 uiInfo+119484
ADDRLP4 72
INDIRI4
ASGNI4
line 217
;217:}
LABELV $154
endproc AssetCache 84 8
export _UI_DrawSides
proc _UI_DrawSides 4 36
line 219
;218:
;219:void _UI_DrawSides(float x, float y, float w, float h, float size) {
line 220
;220:	UI_AdjustFrom640(&x, &y, &w, &h);
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 UI_AdjustFrom640
CALLV
pop
line 221
;221:	size *= uiInfo.uiDC.xscale;
ADDRFP4 16
ADDRFP4 16
INDIRF4
ADDRGP4 uiInfo+200
INDIRF4
MULF4
ASGNF4
line 222
;222:	trap_R_DrawStretchPic(x, y, size, h, 0, 0, 0, 0, uiInfo.uiDC.whiteShader);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 uiInfo+73400
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 223
;223:	trap_R_DrawStretchPic(x + w - size, y, size, h, 0, 0, 0, 0, uiInfo.uiDC.whiteShader);
ADDRLP4 0
ADDRFP4 16
INDIRF4
ASGNF4
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 uiInfo+73400
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 224
;224:}
LABELV $221
endproc _UI_DrawSides 4 36
export _UI_DrawTopBottom
proc _UI_DrawTopBottom 4 36
line 226
;225:
;226:void _UI_DrawTopBottom(float x, float y, float w, float h, float size) {
line 227
;227:	UI_AdjustFrom640(&x, &y, &w, &h);
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 UI_AdjustFrom640
CALLV
pop
line 228
;228:	size *= uiInfo.uiDC.yscale;
ADDRFP4 16
ADDRFP4 16
INDIRF4
ADDRGP4 uiInfo+196
INDIRF4
MULF4
ASGNF4
line 229
;229:	trap_R_DrawStretchPic(x, y, w, size, 0, 0, 0, 0, uiInfo.uiDC.whiteShader);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 uiInfo+73400
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 230
;230:	trap_R_DrawStretchPic(x, y + h - size, w, size, 0, 0, 0, 0, uiInfo.uiDC.whiteShader);
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 0
ADDRFP4 16
INDIRF4
ASGNF4
ADDRFP4 4
INDIRF4
ADDRFP4 12
INDIRF4
ADDF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 uiInfo+73400
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 231
;231:}
LABELV $225
endproc _UI_DrawTopBottom 4 36
export _UI_DrawRect
proc _UI_DrawRect 0 20
line 239
;232:/*
;233:================
;234:UI_DrawRect
;235:
;236:Coordinates are 640*480 virtual values
;237:=================
;238:*/
;239:void _UI_DrawRect(float x, float y, float width, float height, float size, const float *color) {
line 240
;240:	trap_R_SetColor(color);
ADDRFP4 20
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 242
;241:
;242:	_UI_DrawTopBottom(x, y, width, height, size);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRGP4 _UI_DrawTopBottom
CALLV
pop
line 243
;243:	_UI_DrawSides(x, y, width, height, size);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRGP4 _UI_DrawSides
CALLV
pop
line 245
;244:
;245:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 246
;246:}
LABELV $229
endproc _UI_DrawRect 0 20
export Text_Width
proc Text_Width 40 4
line 248
;247:
;248:int Text_Width(const char *text, float scale, int limit) {
line 253
;249:	int count, len;
;250:	float out;
;251:	glyphInfo_t *glyph;
;252:	float useScale;
;253:	const char *s = text;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 254
;254:	fontInfo_t *font = &uiInfo.uiDC.Assets.textFont;
ADDRLP4 12
ADDRGP4 uiInfo+228+12
ASGNP4
line 255
;255:	if (scale <= ui_smallFont.value) {
ADDRFP4 4
INDIRF4
ADDRGP4 ui_smallFont+8
INDIRF4
GTF4 $233
line 256
;256:		font = &uiInfo.uiDC.Assets.smallFont;
ADDRLP4 12
ADDRGP4 uiInfo+228+20560
ASGNP4
line 257
;257:	} else if (scale >= ui_bigFont.value) {
ADDRGP4 $234
JUMPV
LABELV $233
ADDRFP4 4
INDIRF4
ADDRGP4 ui_bigFont+8
INDIRF4
LTF4 $238
line 258
;258:		font = &uiInfo.uiDC.Assets.bigFont;
ADDRLP4 12
ADDRGP4 uiInfo+228+41108
ASGNP4
line 259
;259:	}
LABELV $238
LABELV $234
line 260
;260:	useScale = scale * font->glyphScale;
ADDRLP4 24
ADDRFP4 4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 20480
ADDP4
INDIRF4
MULF4
ASGNF4
line 261
;261:	out = 0;
ADDRLP4 20
CNSTF4 0
ASGNF4
line 262
;262:	if (text) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $243
line 263
;263:		len = strlen(text);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 28
INDIRI4
ASGNI4
line 264
;264:		if (limit > 0 && len > limit) {
ADDRLP4 32
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
LEI4 $245
ADDRLP4 8
INDIRI4
ADDRLP4 32
INDIRI4
LEI4 $245
line 265
;265:			len = limit;
ADDRLP4 8
ADDRFP4 8
INDIRI4
ASGNI4
line 266
;266:		}
LABELV $245
line 267
;267:		count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $248
JUMPV
LABELV $247
line 268
;268:		while (s && *s && count < len) {
line 269
;269:			if (Q_IsColorString(s)) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $250
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $250
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $250
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $250
line 270
;270:				s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 271
;271:				continue;
ADDRGP4 $248
JUMPV
LABELV $250
line 272
;272:			} else {
line 273
;273:				glyph = &font->glyphs[(int)*s];
ADDRLP4 16
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 80
MULI4
ADDRLP4 12
INDIRP4
ADDP4
ASGNP4
line 274
;274:				out += glyph->xSkip;
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 275
;275:				s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 276
;276:				count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 277
;277:			}
line 278
;278:		}
LABELV $248
line 268
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $253
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $253
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $247
LABELV $253
line 279
;279:	}
LABELV $243
line 280
;280:	return out * useScale;
ADDRLP4 20
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
CVFI4 4
RETI4
LABELV $230
endproc Text_Width 40 4
export Text_Height
proc Text_Height 40 4
line 283
;281:}
;282:
;283:int Text_Height(const char *text, float scale, int limit) {
line 288
;284:	int len, count;
;285:	float max;
;286:	glyphInfo_t *glyph;
;287:	float useScale;
;288:	const char *s = text; // bk001206 - unsigned
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 289
;289:	fontInfo_t *font = &uiInfo.uiDC.Assets.textFont;
ADDRLP4 20
ADDRGP4 uiInfo+228+12
ASGNP4
line 290
;290:	if (scale <= ui_smallFont.value) {
ADDRFP4 4
INDIRF4
ADDRGP4 ui_smallFont+8
INDIRF4
GTF4 $257
line 291
;291:		font = &uiInfo.uiDC.Assets.smallFont;
ADDRLP4 20
ADDRGP4 uiInfo+228+20560
ASGNP4
line 292
;292:	} else if (scale >= ui_bigFont.value) {
ADDRGP4 $258
JUMPV
LABELV $257
ADDRFP4 4
INDIRF4
ADDRGP4 ui_bigFont+8
INDIRF4
LTF4 $262
line 293
;293:		font = &uiInfo.uiDC.Assets.bigFont;
ADDRLP4 20
ADDRGP4 uiInfo+228+41108
ASGNP4
line 294
;294:	}
LABELV $262
LABELV $258
line 295
;295:	useScale = scale * font->glyphScale;
ADDRLP4 24
ADDRFP4 4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 20480
ADDP4
INDIRF4
MULF4
ASGNF4
line 296
;296:	max = 0;
ADDRLP4 16
CNSTF4 0
ASGNF4
line 297
;297:	if (text) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $267
line 298
;298:		len = strlen(text);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 28
INDIRI4
ASGNI4
line 299
;299:		if (limit > 0 && len > limit) {
ADDRLP4 32
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
LEI4 $269
ADDRLP4 8
INDIRI4
ADDRLP4 32
INDIRI4
LEI4 $269
line 300
;300:			len = limit;
ADDRLP4 8
ADDRFP4 8
INDIRI4
ASGNI4
line 301
;301:		}
LABELV $269
line 302
;302:		count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $272
JUMPV
LABELV $271
line 303
;303:		while (s && *s && count < len) {
line 304
;304:			if (Q_IsColorString(s)) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $274
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $274
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $274
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $274
line 305
;305:				s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 306
;306:				continue;
ADDRGP4 $272
JUMPV
LABELV $274
line 307
;307:			} else {
line 308
;308:				glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
ADDRLP4 12
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 80
MULI4
ADDRLP4 20
INDIRP4
ADDP4
ASGNP4
line 309
;309:				if (max < glyph->height) {
ADDRLP4 16
INDIRF4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
GEF4 $276
line 310
;310:					max = glyph->height;
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
line 311
;311:				}
LABELV $276
line 312
;312:				s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 313
;313:				count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 314
;314:			}
line 315
;315:		}
LABELV $272
line 303
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $279
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $279
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $271
LABELV $279
line 316
;316:	}
LABELV $267
line 317
;317:	return max * useScale;
ADDRLP4 16
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
CVFI4 4
RETI4
LABELV $254
endproc Text_Height 40 4
export Text_PaintChar
proc Text_PaintChar 8 36
line 320
;318:}
;319:
;320:void Text_PaintChar(float x, float y, float width, float height, float scale, float s, float t, float s2, float t2, qhandle_t hShader) {
line 322
;321:	float w, h;
;322:	w = width * scale;
ADDRLP4 0
ADDRFP4 8
INDIRF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 323
;323:	h = height * scale;
ADDRLP4 4
ADDRFP4 12
INDIRF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 324
;324:	UI_AdjustFrom640(&x, &y, &w, &h);
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 UI_AdjustFrom640
CALLV
pop
line 325
;325:	trap_R_DrawStretchPic(x, y, w, h, s, t, s2, t2, hShader);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRFP4 20
INDIRF4
ARGF4
ADDRFP4 24
INDIRF4
ARGF4
ADDRFP4 28
INDIRF4
ARGF4
ADDRFP4 32
INDIRF4
ARGF4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 326
;326:}
LABELV $280
endproc Text_PaintChar 8 36
export Text_Paint
proc Text_Paint 76 40
line 328
;327:
;328:void Text_Paint(float x, float y, float scale, vec4_t color, const char *text, float adjust, int limit, int style) {
line 333
;329:	int len, count;
;330:	vec4_t newColor;
;331:	glyphInfo_t *glyph;
;332:	float useScale;
;333:	fontInfo_t *font = &uiInfo.uiDC.Assets.textFont;
ADDRLP4 28
ADDRGP4 uiInfo+228+12
ASGNP4
line 334
;334:	if (scale <= ui_smallFont.value) {
ADDRFP4 8
INDIRF4
ADDRGP4 ui_smallFont+8
INDIRF4
GTF4 $284
line 335
;335:		font = &uiInfo.uiDC.Assets.smallFont;
ADDRLP4 28
ADDRGP4 uiInfo+228+20560
ASGNP4
line 336
;336:	} else if (scale >= ui_bigFont.value) {
ADDRGP4 $285
JUMPV
LABELV $284
ADDRFP4 8
INDIRF4
ADDRGP4 ui_bigFont+8
INDIRF4
LTF4 $289
line 337
;337:		font = &uiInfo.uiDC.Assets.bigFont;
ADDRLP4 28
ADDRGP4 uiInfo+228+41108
ASGNP4
line 338
;338:	}
LABELV $289
LABELV $285
line 339
;339:	useScale = scale * font->glyphScale;
ADDRLP4 20
ADDRFP4 8
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 20480
ADDP4
INDIRF4
MULF4
ASGNF4
line 340
;340:	if (text) {
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $294
line 341
;341:		const char *s = text; // bk001206 - unsigned
ADDRLP4 36
ADDRFP4 16
INDIRP4
ASGNP4
line 342
;342:		trap_R_SetColor(color);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 343
;343:		memcpy(&newColor[0], &color[0], sizeof(vec4_t));
ADDRLP4 4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 344
;344:		len = strlen(text);
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 40
INDIRI4
ASGNI4
line 345
;345:		if (limit > 0 && len > limit) {
ADDRLP4 44
ADDRFP4 24
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
LEI4 $296
ADDRLP4 32
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $296
line 346
;346:			len = limit;
ADDRLP4 32
ADDRFP4 24
INDIRI4
ASGNI4
line 347
;347:		}
LABELV $296
line 348
;348:		count = 0;
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 $299
JUMPV
LABELV $298
line 349
;349:		while (s && *s && count < len) {
line 350
;350:			glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
ADDRLP4 0
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
CNSTI4 80
MULI4
ADDRLP4 28
INDIRP4
ADDP4
ASGNP4
line 353
;351:			//int yadj = Assets.textFont.glyphs[text[i]].bottom + Assets.textFont.glyphs[text[i]].top;
;352:			//float yadj = scale * (Assets.textFont.glyphs[text[i]].imageHeight - Assets.textFont.glyphs[text[i]].height);
;353:			if (Q_IsColorString(s)) {
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $301
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $301
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $301
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $301
line 354
;354:				memcpy(newColor, g_color_table[ColorIndex(*(s + 1))], sizeof(newColor));
ADDRLP4 4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
CNSTI4 7
BANDI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 355
;355:				newColor[3] = color[3];
ADDRLP4 4+12
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 356
;356:				trap_R_SetColor(newColor);
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 357
;357:				s += 2;
ADDRLP4 36
ADDRLP4 36
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 358
;358:				continue;
ADDRGP4 $299
JUMPV
LABELV $301
line 359
;359:			} else {
line 360
;360:				float yadj = useScale * glyph->top;
ADDRLP4 52
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 361
;361:				if (style == ITEM_TEXTSTYLE_SHADOWED || style == ITEM_TEXTSTYLE_SHADOWEDMORE) {
ADDRLP4 56
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 3
EQI4 $306
ADDRLP4 56
INDIRI4
CNSTI4 6
NEI4 $304
LABELV $306
line 362
;362:					int ofs = style == ITEM_TEXTSTYLE_SHADOWED ? 1 : 2;
ADDRFP4 28
INDIRI4
CNSTI4 3
NEI4 $308
ADDRLP4 64
CNSTI4 1
ASGNI4
ADDRGP4 $309
JUMPV
LABELV $308
ADDRLP4 64
CNSTI4 2
ASGNI4
LABELV $309
ADDRLP4 60
ADDRLP4 64
INDIRI4
ASGNI4
line 363
;363:					colorBlack[3] = newColor[3];
ADDRGP4 colorBlack+12
ADDRLP4 4+12
INDIRF4
ASGNF4
line 364
;364:					trap_R_SetColor(colorBlack);
ADDRGP4 colorBlack
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 365
;365:					Text_PaintChar(x + ofs, y - yadj + ofs,
ADDRLP4 68
ADDRLP4 60
INDIRI4
CVIF4 4
ASGNF4
ADDRFP4 0
INDIRF4
ADDRLP4 68
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ADDRLP4 52
INDIRF4
SUBF4
ADDRLP4 68
INDIRF4
ADDF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 Text_PaintChar
CALLV
pop
line 374
;366:						glyph->imageWidth,
;367:						glyph->imageHeight,
;368:						useScale,
;369:						glyph->s,
;370:						glyph->t,
;371:						glyph->s2,
;372:						glyph->t2,
;373:						glyph->glyph);
;374:					trap_R_SetColor(newColor);
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 375
;375:					colorBlack[3] = 1.0;
ADDRGP4 colorBlack+12
CNSTF4 1065353216
ASGNF4
line 376
;376:				}
LABELV $304
line 377
;377:				Text_PaintChar(x, y - yadj,
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ADDRLP4 52
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 Text_PaintChar
CALLV
pop
line 387
;378:					glyph->imageWidth,
;379:					glyph->imageHeight,
;380:					useScale,
;381:					glyph->s,
;382:					glyph->t,
;383:					glyph->s2,
;384:					glyph->t2,
;385:					glyph->glyph);
;386:
;387:				x += (glyph->xSkip * useScale) + adjust;
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 20
INDIRF4
MULF4
ADDRFP4 20
INDIRF4
ADDF4
ADDF4
ASGNF4
line 388
;388:				s++;
ADDRLP4 36
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 389
;389:				count++;
ADDRLP4 24
ADDRLP4 24
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 390
;390:			}
line 391
;391:		}
LABELV $299
line 349
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $314
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $314
ADDRLP4 24
INDIRI4
ADDRLP4 32
INDIRI4
LTI4 $298
LABELV $314
line 392
;392:		trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 393
;393:	}
LABELV $294
line 394
;394:}
LABELV $281
endproc Text_Paint 76 40
export Text_PaintWithCursor
proc Text_PaintWithCursor 80 40
ADDRFP4 24
ADDRFP4 24
INDIRI4
CVII1 4
ASGNI1
line 396
;395:
;396:void Text_PaintWithCursor(float x, float y, float scale, vec4_t color, const char *text, int cursorPos, char cursor, int limit, int style) {
line 402
;397:	int len, count;
;398:	vec4_t newColor;
;399:	glyphInfo_t *glyph, *glyph2;
;400:	float yadj;
;401:	float useScale;
;402:	fontInfo_t *font = &uiInfo.uiDC.Assets.textFont;
ADDRLP4 36
ADDRGP4 uiInfo+228+12
ASGNP4
line 403
;403:	if (scale <= ui_smallFont.value) {
ADDRFP4 8
INDIRF4
ADDRGP4 ui_smallFont+8
INDIRF4
GTF4 $318
line 404
;404:		font = &uiInfo.uiDC.Assets.smallFont;
ADDRLP4 36
ADDRGP4 uiInfo+228+20560
ASGNP4
line 405
;405:	} else if (scale >= ui_bigFont.value) {
ADDRGP4 $319
JUMPV
LABELV $318
ADDRFP4 8
INDIRF4
ADDRGP4 ui_bigFont+8
INDIRF4
LTF4 $323
line 406
;406:		font = &uiInfo.uiDC.Assets.bigFont;
ADDRLP4 36
ADDRGP4 uiInfo+228+41108
ASGNP4
line 407
;407:	}
LABELV $323
LABELV $319
line 408
;408:	useScale = scale * font->glyphScale;
ADDRLP4 4
ADDRFP4 8
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 20480
ADDP4
INDIRF4
MULF4
ASGNF4
line 409
;409:	if (text) {
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $328
line 410
;410:		const char *s = text; // bk001206 - unsigned
ADDRLP4 44
ADDRFP4 16
INDIRP4
ASGNP4
line 411
;411:		trap_R_SetColor(color);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 412
;412:		memcpy(&newColor[0], &color[0], sizeof(vec4_t));
ADDRLP4 12
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 413
;413:		len = strlen(text);
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 48
INDIRI4
ASGNI4
line 414
;414:		if (limit > 0 && len > limit) {
ADDRLP4 52
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
LEI4 $330
ADDRLP4 40
INDIRI4
ADDRLP4 52
INDIRI4
LEI4 $330
line 415
;415:			len = limit;
ADDRLP4 40
ADDRFP4 28
INDIRI4
ASGNI4
line 416
;416:		}
LABELV $330
line 417
;417:		count = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 418
;418:		glyph2 = &font->glyphs[(int)cursor]; // bk001206 - possible signed char
ADDRLP4 8
ADDRFP4 24
INDIRI1
CVII4 1
CNSTI4 80
MULI4
ADDRLP4 36
INDIRP4
ADDP4
ASGNP4
ADDRGP4 $333
JUMPV
LABELV $332
line 419
;419:		while (s && *s && count < len) {
line 420
;420:			glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
ADDRLP4 0
ADDRLP4 44
INDIRP4
INDIRI1
CVII4 1
CNSTI4 80
MULI4
ADDRLP4 36
INDIRP4
ADDP4
ASGNP4
line 423
;421:			//int yadj = Assets.textFont.glyphs[text[i]].bottom + Assets.textFont.glyphs[text[i]].top;
;422:			//float yadj = scale * (Assets.textFont.glyphs[text[i]].imageHeight - Assets.textFont.glyphs[text[i]].height);
;423:			if (Q_IsColorString(s)) {
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $335
ADDRLP4 44
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $335
ADDRLP4 44
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $335
ADDRLP4 44
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $335
line 424
;424:				memcpy(newColor, g_color_table[ColorIndex(*(s + 1))], sizeof(newColor));
ADDRLP4 12
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
CNSTI4 7
BANDI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 425
;425:				newColor[3] = color[3];
ADDRLP4 12+12
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 426
;426:				trap_R_SetColor(newColor);
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 427
;427:				s += 2;
ADDRLP4 44
ADDRLP4 44
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 428
;428:				continue;
ADDRGP4 $333
JUMPV
LABELV $335
line 429
;429:			} else {
line 430
;430:				yadj = useScale * glyph->top;
ADDRLP4 32
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 431
;431:				if (style == ITEM_TEXTSTYLE_SHADOWED || style == ITEM_TEXTSTYLE_SHADOWEDMORE) {
ADDRLP4 60
ADDRFP4 32
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 3
EQI4 $340
ADDRLP4 60
INDIRI4
CNSTI4 6
NEI4 $338
LABELV $340
line 432
;432:					int ofs = style == ITEM_TEXTSTYLE_SHADOWED ? 1 : 2;
ADDRFP4 32
INDIRI4
CNSTI4 3
NEI4 $342
ADDRLP4 68
CNSTI4 1
ASGNI4
ADDRGP4 $343
JUMPV
LABELV $342
ADDRLP4 68
CNSTI4 2
ASGNI4
LABELV $343
ADDRLP4 64
ADDRLP4 68
INDIRI4
ASGNI4
line 433
;433:					colorBlack[3] = newColor[3];
ADDRGP4 colorBlack+12
ADDRLP4 12+12
INDIRF4
ASGNF4
line 434
;434:					trap_R_SetColor(colorBlack);
ADDRGP4 colorBlack
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 435
;435:					Text_PaintChar(x + ofs, y - yadj + ofs,
ADDRLP4 72
ADDRLP4 64
INDIRI4
CVIF4 4
ASGNF4
ADDRFP4 0
INDIRF4
ADDRLP4 72
INDIRF4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
ADDRLP4 72
INDIRF4
ADDF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 Text_PaintChar
CALLV
pop
line 444
;436:						glyph->imageWidth,
;437:						glyph->imageHeight,
;438:						useScale,
;439:						glyph->s,
;440:						glyph->t,
;441:						glyph->s2,
;442:						glyph->t2,
;443:						glyph->glyph);
;444:					colorBlack[3] = 1.0;
ADDRGP4 colorBlack+12
CNSTF4 1065353216
ASGNF4
line 445
;445:					trap_R_SetColor(newColor);
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 446
;446:				}
LABELV $338
line 447
;447:				Text_PaintChar(x, y - yadj,
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 Text_PaintChar
CALLV
pop
line 457
;448:					glyph->imageWidth,
;449:					glyph->imageHeight,
;450:					useScale,
;451:					glyph->s,
;452:					glyph->t,
;453:					glyph->s2,
;454:					glyph->t2,
;455:					glyph->glyph);
;456:
;457:				yadj = useScale * glyph2->top;
ADDRLP4 32
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 458
;458:				if (count == cursorPos && !((uiInfo.uiDC.realTime / BLINK_DIVISOR) & 1)) {
ADDRLP4 28
INDIRI4
ADDRFP4 20
INDIRI4
NEI4 $347
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 200
DIVI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $347
line 459
;459:					Text_PaintChar(x, y - yadj,
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 Text_PaintChar
CALLV
pop
line 468
;460:						glyph2->imageWidth,
;461:						glyph2->imageHeight,
;462:						useScale,
;463:						glyph2->s,
;464:						glyph2->t,
;465:						glyph2->s2,
;466:						glyph2->t2,
;467:						glyph2->glyph);
;468:				}
LABELV $347
line 470
;469:
;470:				x += (glyph->xSkip * useScale);
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
MULF4
ADDF4
ASGNF4
line 471
;471:				s++;
ADDRLP4 44
ADDRLP4 44
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 472
;472:				count++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 473
;473:			}
line 474
;474:		}
LABELV $333
line 419
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $351
ADDRLP4 44
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $351
ADDRLP4 28
INDIRI4
ADDRLP4 40
INDIRI4
LTI4 $332
LABELV $351
line 476
;475:		// need to paint cursor at end of text
;476:		if (cursorPos == len && !((uiInfo.uiDC.realTime / BLINK_DIVISOR) & 1)) {
ADDRFP4 20
INDIRI4
ADDRLP4 40
INDIRI4
NEI4 $352
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 200
DIVI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $352
line 477
;477:			yadj = useScale * glyph2->top;
ADDRLP4 32
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 478
;478:			Text_PaintChar(x, y - yadj,
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 Text_PaintChar
CALLV
pop
line 488
;479:				glyph2->imageWidth,
;480:				glyph2->imageHeight,
;481:				useScale,
;482:				glyph2->s,
;483:				glyph2->t,
;484:				glyph2->s2,
;485:				glyph2->t2,
;486:				glyph2->glyph);
;487:
;488:		}
LABELV $352
line 490
;489:
;490:		trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 491
;491:	}
LABELV $328
line 492
;492:}
LABELV $315
endproc Text_PaintWithCursor 80 40
proc Text_Paint_Limit 68 40
line 495
;493:
;494:
;495:static void Text_Paint_Limit(float *maxX, float x, float y, float scale, vec4_t color, const char *text, float adjust, int limit) {
line 499
;496:	int len, count;
;497:	vec4_t newColor;
;498:	glyphInfo_t *glyph;
;499:	if (text) {
ADDRFP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $356
line 500
;500:		const char *s = text; // bk001206 - unsigned
ADDRLP4 28
ADDRFP4 20
INDIRP4
ASGNP4
line 501
;501:		float max = *maxX;
ADDRLP4 40
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 503
;502:		float useScale;
;503:		fontInfo_t *font = &uiInfo.uiDC.Assets.textFont;
ADDRLP4 36
ADDRGP4 uiInfo+228+12
ASGNP4
line 504
;504:		if (scale <= ui_smallFont.value) {
ADDRFP4 12
INDIRF4
ADDRGP4 ui_smallFont+8
INDIRF4
GTF4 $360
line 505
;505:			font = &uiInfo.uiDC.Assets.smallFont;
ADDRLP4 36
ADDRGP4 uiInfo+228+20560
ASGNP4
line 506
;506:		} else if (scale > ui_bigFont.value) {
ADDRGP4 $361
JUMPV
LABELV $360
ADDRFP4 12
INDIRF4
ADDRGP4 ui_bigFont+8
INDIRF4
LEF4 $365
line 507
;507:			font = &uiInfo.uiDC.Assets.bigFont;
ADDRLP4 36
ADDRGP4 uiInfo+228+41108
ASGNP4
line 508
;508:		}
LABELV $365
LABELV $361
line 509
;509:		useScale = scale * font->glyphScale;
ADDRLP4 32
ADDRFP4 12
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 20480
ADDP4
INDIRF4
MULF4
ASGNF4
line 510
;510:		trap_R_SetColor(color);
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 511
;511:		len = strlen(text);
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 44
INDIRI4
ASGNI4
line 512
;512:		if (limit > 0 && len > limit) {
ADDRLP4 48
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
LEI4 $370
ADDRLP4 24
INDIRI4
ADDRLP4 48
INDIRI4
LEI4 $370
line 513
;513:			len = limit;
ADDRLP4 24
ADDRFP4 28
INDIRI4
ASGNI4
line 514
;514:		}
LABELV $370
line 515
;515:		count = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 $373
JUMPV
LABELV $372
line 516
;516:		while (s && *s && count < len) {
line 517
;517:			glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRI1
CVII4 1
CNSTI4 80
MULI4
ADDRLP4 36
INDIRP4
ADDP4
ASGNP4
line 518
;518:			if (Q_IsColorString(s)) {
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $375
ADDRLP4 28
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $375
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $375
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $375
line 519
;519:				memcpy(newColor, g_color_table[ColorIndex(*(s + 1))], sizeof(newColor));
ADDRLP4 4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
CNSTI4 7
BANDI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 520
;520:				newColor[3] = color[3];
ADDRLP4 4+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 521
;521:				trap_R_SetColor(newColor);
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 522
;522:				s += 2;
ADDRLP4 28
ADDRLP4 28
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 523
;523:				continue;
ADDRGP4 $373
JUMPV
LABELV $375
line 524
;524:			} else {
line 525
;525:				float yadj = useScale * glyph->top;
ADDRLP4 56
ADDRLP4 32
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 526
;526:				if (Text_Width(s, useScale, 1) + x > max) {
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 60
ADDRGP4 Text_Width
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CVIF4 4
ADDRFP4 4
INDIRF4
ADDF4
ADDRLP4 40
INDIRF4
LEF4 $378
line 527
;527:					*maxX = 0;
ADDRFP4 0
INDIRP4
CNSTF4 0
ASGNF4
line 528
;528:					break;
ADDRGP4 $374
JUMPV
LABELV $378
line 530
;529:				}
;530:				Text_PaintChar(x, y - yadj,
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ADDRLP4 56
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 Text_PaintChar
CALLV
pop
line 539
;531:					glyph->imageWidth,
;532:					glyph->imageHeight,
;533:					useScale,
;534:					glyph->s,
;535:					glyph->t,
;536:					glyph->s2,
;537:					glyph->t2,
;538:					glyph->glyph);
;539:				x += (glyph->xSkip * useScale) + adjust;
ADDRFP4 4
ADDRFP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 32
INDIRF4
MULF4
ADDRFP4 24
INDIRF4
ADDF4
ADDF4
ASGNF4
line 540
;540:				*maxX = x;
ADDRFP4 0
INDIRP4
ADDRFP4 4
INDIRF4
ASGNF4
line 541
;541:				count++;
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 542
;542:				s++;
ADDRLP4 28
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 543
;543:			}
line 544
;544:		}
LABELV $373
line 516
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $381
ADDRLP4 28
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $381
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
LTI4 $372
LABELV $381
LABELV $374
line 545
;545:		trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 546
;546:	}
LABELV $356
line 548
;547:
;548:}
LABELV $355
endproc Text_Paint_Limit 68 40
export UI_ShowPostGame
proc UI_ShowPostGame 0 8
line 551
;549:
;550:
;551:void UI_ShowPostGame(qboolean newHigh) {
line 552
;552:	trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $383
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 553
;553:	trap_Cvar_Set("sv_killserver", "1");
ADDRGP4 $385
ARGP4
ADDRGP4 $386
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 554
;554:	uiInfo.soundHighScore = newHigh;
ADDRGP4 uiInfo+73436
ADDRFP4 0
INDIRI4
ASGNI4
line 555
;555:	_UI_SetActiveMenu(UIMENU_POSTGAME);
CNSTI4 6
ARGI4
ADDRGP4 _UI_SetActiveMenu
CALLV
pop
line 556
;556:}
LABELV $382
endproc UI_ShowPostGame 0 8
export UI_DrawCenteredPic
proc UI_DrawCenteredPic 8 20
line 563
;557:/*
;558:=================
;559:_UI_Refresh
;560:=================
;561:*/
;562:
;563:void UI_DrawCenteredPic(qhandle_t image, int w, int h) {
line 565
;564:	int x, y;
;565:	x = (SCREEN_WIDTH - w) / 2;
ADDRLP4 0
CNSTI4 640
ADDRFP4 4
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 566
;566:	y = (SCREEN_HEIGHT - h) / 2;
ADDRLP4 4
CNSTI4 480
ADDRFP4 8
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 567
;567:	UI_DrawHandlePic(x, y, w, h, image);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 568
;568:}
LABELV $388
endproc UI_DrawCenteredPic 8 20
data
export frameCount
align 4
LABELV frameCount
byte 4 0
bss
align 4
LABELV $390
skip 4
align 4
LABELV $391
skip 16
export _UI_Refresh
code
proc _UI_Refresh 12 20
line 574
;569:
;570:int frameCount = 0;
;571:int startTime;
;572:
;573:#define	UI_FPS_FRAMES	4
;574:void _UI_Refresh(int realtime) {
line 582
;575:	static int index;
;576:	static int	previousTimes[UI_FPS_FRAMES];
;577:
;578:	//if ( !( trap_Key_GetCatcher() & KEYCATCH_UI ) ) {
;579:	//	return;
;580:	//}
;581:
;582:	uiInfo.uiDC.frameTime = realtime - uiInfo.uiDC.realTime;
ADDRGP4 uiInfo+212
ADDRFP4 0
INDIRI4
ADDRGP4 uiInfo+208
INDIRI4
SUBI4
ASGNI4
line 583
;583:	uiInfo.uiDC.realTime = realtime;
ADDRGP4 uiInfo+208
ADDRFP4 0
INDIRI4
ASGNI4
line 585
;584:
;585:	previousTimes[index % UI_FPS_FRAMES] = uiInfo.uiDC.frameTime;
ADDRGP4 $390
INDIRI4
CNSTI4 4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 $391
ADDP4
ADDRGP4 uiInfo+212
INDIRI4
ASGNI4
line 586
;586:	index++;
ADDRLP4 0
ADDRGP4 $390
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 587
;587:	if (index > UI_FPS_FRAMES) {
ADDRGP4 $390
INDIRI4
CNSTI4 4
LEI4 $396
line 590
;588:		int i, total;
;589:		// average multiple frames together to smooth changes out a bit
;590:		total = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 591
;591:		for (i = 0; i < UI_FPS_FRAMES; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $398
line 592
;592:			total += previousTimes[i];
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $391
ADDP4
INDIRI4
ADDI4
ASGNI4
line 593
;593:		}
LABELV $399
line 591
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
LTI4 $398
line 594
;594:		if (!total) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $402
line 595
;595:			total = 1;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 596
;596:		}
LABELV $402
line 597
;597:		uiInfo.uiDC.FPS = 1000 * UI_FPS_FRAMES / total;
ADDRGP4 uiInfo+73412
CNSTI4 4000
ADDRLP4 8
INDIRI4
DIVI4
CVIF4 4
ASGNF4
line 598
;598:	}
LABELV $396
line 602
;599:
;600:
;601:
;602:	UI_UpdateCvars();
ADDRGP4 UI_UpdateCvars
CALLV
pop
line 604
;603:
;604:	if (Menu_Count() > 0) {
ADDRLP4 4
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LEI4 $405
line 606
;605:		// paint all the menus
;606:		Menu_PaintAll();
ADDRGP4 Menu_PaintAll
CALLV
pop
line 608
;607:		// refresh server browser list
;608:		UI_DoServerRefresh();
ADDRGP4 UI_DoServerRefresh
CALLV
pop
line 610
;609:		// refresh server status
;610:		UI_BuildServerStatus(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_BuildServerStatus
CALLV
pop
line 612
;611:		// refresh find player list
;612:		UI_BuildFindPlayerList(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_BuildFindPlayerList
CALLV
pop
line 613
;613:	}
LABELV $405
line 616
;614:
;615:	// draw cursor
;616:	UI_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 UI_SetColor
CALLV
pop
line 617
;617:	if (Menu_Count() > 0) {
ADDRLP4 8
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LEI4 $407
line 618
;618:		UI_DrawHandlePic(uiInfo.uiDC.cursorx - 16, uiInfo.uiDC.cursory - 16, 32, 32, uiInfo.uiDC.Assets.cursor);
ADDRGP4 uiInfo+216
INDIRI4
CNSTI4 16
SUBI4
CVIF4 4
ARGF4
ADDRGP4 uiInfo+220
INDIRI4
CNSTI4 16
SUBI4
CVIF4 4
ARGF4
CNSTF4 1107296256
ARGF4
CNSTF4 1107296256
ARGF4
ADDRGP4 uiInfo+228+61656
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 619
;619:	}
LABELV $407
line 622
;620:
;621:#ifndef NDEBUG
;622:	if (uiInfo.uiDC.debug) {
ADDRGP4 uiInfo+224
INDIRI4
CNSTI4 0
EQI4 $413
line 626
;623:		// cursor coordinates
;624:		//FIXME
;625:		//UI_DrawString( 0, 0, va("(%d,%d)",uis.cursorx,uis.cursory), UI_LEFT|UI_SMALLFONT, colorRed );
;626:	}
LABELV $413
line 629
;627:#endif
;628:
;629:}
LABELV $389
endproc _UI_Refresh 12 20
export _UI_Shutdown
proc _UI_Shutdown 0 0
line 636
;630:
;631:/*
;632:=================
;633:_UI_Shutdown
;634:=================
;635:*/
;636:void _UI_Shutdown(void) {
line 637
;637:	trap_LAN_SaveCachedServers();
ADDRGP4 trap_LAN_SaveCachedServers
CALLV
pop
line 638
;638:}
LABELV $416
endproc _UI_Shutdown 0 0
data
export defaultMenu
align 4
LABELV defaultMenu
byte 4 0
bss
align 1
LABELV $418
skip 32768
export GetMenuBuffer
code
proc GetMenuBuffer 16 16
line 642
;639:
;640:char *defaultMenu = NULL;
;641:
;642:char *GetMenuBuffer(const char *filename) {
line 647
;643:	int	len;
;644:	fileHandle_t	f;
;645:	static char buf[MAX_MENUFILE];
;646:
;647:	len = trap_FS_FOpenFile(filename, &f, FS_READ);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 648
;648:	if (!f) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $419
line 649
;649:		trap_Print(va(S_COLOR_RED "menu file not found: %s, using default\n", filename));
ADDRGP4 $421
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 650
;650:		return defaultMenu;
ADDRGP4 defaultMenu
INDIRP4
RETP4
ADDRGP4 $417
JUMPV
LABELV $419
line 652
;651:	}
;652:	if (len >= MAX_MENUFILE) {
ADDRLP4 0
INDIRI4
CNSTI4 32768
LTI4 $422
line 653
;653:		trap_Print(va(S_COLOR_RED "menu file too large: %s is %i, max allowed is %i", filename, len, MAX_MENUFILE));
ADDRGP4 $424
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 32768
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 654
;654:		trap_FS_FCloseFile(f);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 655
;655:		return defaultMenu;
ADDRGP4 defaultMenu
INDIRP4
RETP4
ADDRGP4 $417
JUMPV
LABELV $422
line 658
;656:	}
;657:
;658:	trap_FS_Read(buf, len, f);
ADDRGP4 $418
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 659
;659:	buf[len] = 0;
ADDRLP4 0
INDIRI4
ADDRGP4 $418
ADDP4
CNSTI1 0
ASGNI1
line 660
;660:	trap_FS_FCloseFile(f);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 662
;661:	//COM_Compress(buf);
;662:	return buf;
ADDRGP4 $418
RETP4
LABELV $417
endproc GetMenuBuffer 16 16
export Asset_Parse
proc Asset_Parse 1124 12
line 666
;663:
;664:}
;665:
;666:qboolean Asset_Parse(int handle) {
line 670
;667:	pc_token_t token;
;668:	const char *tempStr;
;669:
;670:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $426
line 671
;671:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $425
JUMPV
LABELV $426
line 672
;672:	if (Q_stricmp(token.string, "{") != 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $431
ARGP4
ADDRLP4 1048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
EQI4 $433
line 673
;673:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $425
JUMPV
LABELV $432
line 676
;674:	}
;675:
;676:	while (1) {
line 678
;677:
;678:		memset(&token, 0, sizeof(pc_token_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1040
ARGI4
ADDRGP4 memset
CALLP4
pop
line 680
;679:
;680:		if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1052
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $435
line 681
;681:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $425
JUMPV
LABELV $435
line 683
;682:
;683:		if (Q_stricmp(token.string, "}") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $440
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $437
line 684
;684:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $425
JUMPV
LABELV $437
line 688
;685:		}
;686:
;687:		// font
;688:		if (Q_stricmp(token.string, "font") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $444
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $441
line 690
;689:			int pointSize;
;690:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 1068
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
EQI4 $447
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1064
ARGP4
ADDRLP4 1072
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $445
LABELV $447
line 691
;691:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $425
JUMPV
LABELV $445
line 693
;692:			}
;693:			trap_R_RegisterFont(tempStr, pointSize, &uiInfo.uiDC.Assets.textFont);
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1064
INDIRI4
ARGI4
ADDRGP4 uiInfo+228+12
ARGP4
ADDRGP4 trap_R_RegisterFont
CALLV
pop
line 694
;694:			uiInfo.uiDC.Assets.fontRegistered = qtrue;
ADDRGP4 uiInfo+228+61764
CNSTI4 1
ASGNI4
line 695
;695:			continue;
ADDRGP4 $433
JUMPV
LABELV $441
line 698
;696:		}
;697:
;698:		if (Q_stricmp(token.string, "smallFont") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $455
ARGP4
ADDRLP4 1064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $452
line 700
;699:			int pointSize;
;700:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 1072
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
EQI4 $458
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1068
ARGP4
ADDRLP4 1076
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
NEI4 $456
LABELV $458
line 701
;701:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $425
JUMPV
LABELV $456
line 703
;702:			}
;703:			trap_R_RegisterFont(tempStr, pointSize, &uiInfo.uiDC.Assets.smallFont);
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1068
INDIRI4
ARGI4
ADDRGP4 uiInfo+228+20560
ARGP4
ADDRGP4 trap_R_RegisterFont
CALLV
pop
line 704
;704:			continue;
ADDRGP4 $433
JUMPV
LABELV $452
line 707
;705:		}
;706:
;707:		if (Q_stricmp(token.string, "bigFont") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $464
ARGP4
ADDRLP4 1068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
NEI4 $461
line 709
;708:			int pointSize;
;709:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 1076
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
EQI4 $467
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1072
ARGP4
ADDRLP4 1080
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 0
NEI4 $465
LABELV $467
line 710
;710:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $425
JUMPV
LABELV $465
line 712
;711:			}
;712:			trap_R_RegisterFont(tempStr, pointSize, &uiInfo.uiDC.Assets.bigFont);
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1072
INDIRI4
ARGI4
ADDRGP4 uiInfo+228+41108
ARGP4
ADDRGP4 trap_R_RegisterFont
CALLV
pop
line 713
;713:			continue;
ADDRGP4 $433
JUMPV
LABELV $461
line 718
;714:		}
;715:
;716:
;717:		// gradientbar
;718:		if (Q_stricmp(token.string, "gradientbar") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $473
ARGP4
ADDRLP4 1072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $470
line 719
;719:			if (!PC_String_Parse(handle, &tempStr)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 1076
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
NEI4 $474
line 720
;720:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $425
JUMPV
LABELV $474
line 722
;721:			}
;722:			uiInfo.uiDC.Assets.gradientBar = trap_R_RegisterShaderNoMip(tempStr);
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1080
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61660
ADDRLP4 1080
INDIRI4
ASGNI4
line 723
;723:			continue;
ADDRGP4 $433
JUMPV
LABELV $470
line 727
;724:		}
;725:
;726:		// enterMenuSound
;727:		if (Q_stricmp(token.string, "menuEnterSound") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $481
ARGP4
ADDRLP4 1076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
NEI4 $478
line 728
;728:			if (!PC_String_Parse(handle, &tempStr)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 1080
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 0
NEI4 $482
line 729
;729:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $425
JUMPV
LABELV $482
line 731
;730:			}
;731:			uiInfo.uiDC.Assets.menuEnterSound = trap_S_RegisterSound(tempStr, qfalse);
ADDRLP4 1040
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1084
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61708
ADDRLP4 1084
INDIRI4
ASGNI4
line 732
;732:			continue;
ADDRGP4 $433
JUMPV
LABELV $478
line 736
;733:		}
;734:
;735:		// exitMenuSound
;736:		if (Q_stricmp(token.string, "menuExitSound") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $489
ARGP4
ADDRLP4 1080
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 0
NEI4 $486
line 737
;737:			if (!PC_String_Parse(handle, &tempStr)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 1084
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 1084
INDIRI4
CNSTI4 0
NEI4 $490
line 738
;738:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $425
JUMPV
LABELV $490
line 740
;739:			}
;740:			uiInfo.uiDC.Assets.menuExitSound = trap_S_RegisterSound(tempStr, qfalse);
ADDRLP4 1040
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1088
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61712
ADDRLP4 1088
INDIRI4
ASGNI4
line 741
;741:			continue;
ADDRGP4 $433
JUMPV
LABELV $486
line 745
;742:		}
;743:
;744:		// itemFocusSound
;745:		if (Q_stricmp(token.string, "itemFocusSound") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $497
ARGP4
ADDRLP4 1084
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1084
INDIRI4
CNSTI4 0
NEI4 $494
line 746
;746:			if (!PC_String_Parse(handle, &tempStr)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 1088
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 1088
INDIRI4
CNSTI4 0
NEI4 $498
line 747
;747:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $425
JUMPV
LABELV $498
line 749
;748:			}
;749:			uiInfo.uiDC.Assets.itemFocusSound = trap_S_RegisterSound(tempStr, qfalse);
ADDRLP4 1040
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1092
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61720
ADDRLP4 1092
INDIRI4
ASGNI4
line 750
;750:			continue;
ADDRGP4 $433
JUMPV
LABELV $494
line 754
;751:		}
;752:
;753:		// menuBuzzSound
;754:		if (Q_stricmp(token.string, "menuBuzzSound") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $505
ARGP4
ADDRLP4 1088
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1088
INDIRI4
CNSTI4 0
NEI4 $502
line 755
;755:			if (!PC_String_Parse(handle, &tempStr)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 1092
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 1092
INDIRI4
CNSTI4 0
NEI4 $506
line 756
;756:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $425
JUMPV
LABELV $506
line 758
;757:			}
;758:			uiInfo.uiDC.Assets.menuBuzzSound = trap_S_RegisterSound(tempStr, qfalse);
ADDRLP4 1040
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1096
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61716
ADDRLP4 1096
INDIRI4
ASGNI4
line 759
;759:			continue;
ADDRGP4 $433
JUMPV
LABELV $502
line 762
;760:		}
;761:
;762:		if (Q_stricmp(token.string, "cursor") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $513
ARGP4
ADDRLP4 1092
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1092
INDIRI4
CNSTI4 0
NEI4 $510
line 763
;763:			if (!PC_String_Parse(handle, &uiInfo.uiDC.Assets.cursorStr)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+228+4
ARGP4
ADDRLP4 1096
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 1096
INDIRI4
CNSTI4 0
NEI4 $514
line 764
;764:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $425
JUMPV
LABELV $514
line 766
;765:			}
;766:			uiInfo.uiDC.Assets.cursor = trap_R_RegisterShaderNoMip(uiInfo.uiDC.Assets.cursorStr);
ADDRGP4 uiInfo+228+4
INDIRP4
ARGP4
ADDRLP4 1100
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+228+61656
ADDRLP4 1100
INDIRI4
ASGNI4
line 767
;767:			continue;
ADDRGP4 $433
JUMPV
LABELV $510
line 770
;768:		}
;769:
;770:		if (Q_stricmp(token.string, "fadeClamp") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $525
ARGP4
ADDRLP4 1096
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1096
INDIRI4
CNSTI4 0
NEI4 $522
line 771
;771:			if (!PC_Float_Parse(handle, &uiInfo.uiDC.Assets.fadeClamp)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+228+61724
ARGP4
ADDRLP4 1100
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 1100
INDIRI4
CNSTI4 0
NEI4 $433
line 772
;772:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $425
JUMPV
line 774
;773:			}
;774:			continue;
LABELV $522
line 777
;775:		}
;776:
;777:		if (Q_stricmp(token.string, "fadeCycle") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $533
ARGP4
ADDRLP4 1100
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1100
INDIRI4
CNSTI4 0
NEI4 $530
line 778
;778:			if (!PC_Int_Parse(handle, &uiInfo.uiDC.Assets.fadeCycle)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+228+61728
ARGP4
ADDRLP4 1104
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 1104
INDIRI4
CNSTI4 0
NEI4 $433
line 779
;779:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $425
JUMPV
line 781
;780:			}
;781:			continue;
LABELV $530
line 784
;782:		}
;783:
;784:		if (Q_stricmp(token.string, "fadeAmount") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $541
ARGP4
ADDRLP4 1104
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1104
INDIRI4
CNSTI4 0
NEI4 $538
line 785
;785:			if (!PC_Float_Parse(handle, &uiInfo.uiDC.Assets.fadeAmount)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+228+61732
ARGP4
ADDRLP4 1108
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 0
NEI4 $433
line 786
;786:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $425
JUMPV
line 788
;787:			}
;788:			continue;
LABELV $538
line 791
;789:		}
;790:
;791:		if (Q_stricmp(token.string, "shadowX") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $549
ARGP4
ADDRLP4 1108
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 0
NEI4 $546
line 792
;792:			if (!PC_Float_Parse(handle, &uiInfo.uiDC.Assets.shadowX)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+228+61736
ARGP4
ADDRLP4 1112
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
NEI4 $433
line 793
;793:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $425
JUMPV
line 795
;794:			}
;795:			continue;
LABELV $546
line 798
;796:		}
;797:
;798:		if (Q_stricmp(token.string, "shadowY") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $557
ARGP4
ADDRLP4 1112
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
NEI4 $554
line 799
;799:			if (!PC_Float_Parse(handle, &uiInfo.uiDC.Assets.shadowY)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+228+61740
ARGP4
ADDRLP4 1116
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
NEI4 $433
line 800
;800:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $425
JUMPV
line 802
;801:			}
;802:			continue;
LABELV $554
line 805
;803:		}
;804:
;805:		if (Q_stricmp(token.string, "shadowColor") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $565
ARGP4
ADDRLP4 1116
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
NEI4 $562
line 806
;806:			if (!PC_Color_Parse(handle, &uiInfo.uiDC.Assets.shadowColor)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+228+61744
ARGP4
ADDRLP4 1120
ADDRGP4 PC_Color_Parse
CALLI4
ASGNI4
ADDRLP4 1120
INDIRI4
CNSTI4 0
NEI4 $566
line 807
;807:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $425
JUMPV
LABELV $566
line 809
;808:			}
;809:			uiInfo.uiDC.Assets.shadowFadeClamp = uiInfo.uiDC.Assets.shadowColor[3];
ADDRGP4 uiInfo+228+61760
ADDRGP4 uiInfo+228+61744+12
INDIRF4
ASGNF4
line 810
;810:			continue;
LABELV $562
line 813
;811:		}
;812:
;813:	}
LABELV $433
line 676
ADDRGP4 $432
JUMPV
line 814
;814:	return qfalse;
CNSTI4 0
RETI4
LABELV $425
endproc Asset_Parse 1124 12
export Font_Report
proc Font_Report 8 12
line 817
;815:}
;816:
;817:void Font_Report() {
line 819
;818:	int i;
;819:	Com_Printf("Font Info\n");
ADDRGP4 $576
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 820
;820:	Com_Printf("=========\n");
ADDRGP4 $577
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 821
;821:	for (i = 32; i < 96; i++) {
ADDRLP4 0
CNSTI4 32
ASGNI4
LABELV $578
line 822
;822:		Com_Printf("Glyph handle %i: %i\n", i, uiInfo.uiDC.Assets.textFont.glyphs[i].glyph);
ADDRGP4 $582
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 80
MULI4
ADDRGP4 uiInfo+228+12+44
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 823
;823:	}
LABELV $579
line 821
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 96
LTI4 $578
line 824
;824:}
LABELV $575
endproc Font_Report 8 12
export UI_Report
proc UI_Report 0 0
line 826
;825:
;826:void UI_Report() {
line 827
;827:	String_Report();
ADDRGP4 String_Report
CALLV
pop
line 830
;828:	//Font_Report();
;829:
;830:}
LABELV $586
endproc UI_Report 0 0
export UI_ParseMenu
proc UI_ParseMenu 1060 12
line 832
;831:
;832:void UI_ParseMenu(const char *menuFile) {
line 836
;833:	int handle;
;834:	pc_token_t token;
;835:
;836:	Com_Printf("Parsing menu file:%s\n", menuFile);
ADDRGP4 $588
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 838
;837:
;838:	handle = trap_PC_LoadSource(menuFile);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_LoadSource
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1044
INDIRI4
ASGNI4
line 839
;839:	if (!handle) {
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $592
line 840
;840:		return;
ADDRGP4 $587
JUMPV
LABELV $591
line 843
;841:	}
;842:
;843:	while (1) {
line 844
;844:		memset(&token, 0, sizeof(pc_token_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1040
ARGI4
ADDRGP4 memset
CALLP4
pop
line 845
;845:		if (!trap_PC_ReadToken(handle, &token)) {
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1048
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $594
line 846
;846:			break;
ADDRGP4 $593
JUMPV
LABELV $594
line 859
;847:		}
;848:
;849:		//if ( Q_stricmp( token, "{" ) ) {
;850:		//	Com_Printf( "Missing { in menu file\n" );
;851:		//	break;
;852:		//}
;853:
;854:		//if ( menuCount == MAX_MENUS ) {
;855:		//	Com_Printf( "Too many menus!\n" );
;856:		//	break;
;857:		//}
;858:
;859:		if (token.string[0] == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $596
line 860
;860:			break;
ADDRGP4 $593
JUMPV
LABELV $596
line 863
;861:		}
;862:
;863:		if (Q_stricmp(token.string, "assetGlobalDef") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $602
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $599
line 864
;864:			if (Asset_Parse(handle)) {
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 1056
ADDRGP4 Asset_Parse
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
EQI4 $593
line 865
;865:				continue;
ADDRGP4 $592
JUMPV
line 866
;866:			} else {
line 867
;867:				break;
LABELV $599
line 871
;868:			}
;869:		}
;870:
;871:		if (Q_stricmp(token.string, "menudef") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $608
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $605
line 873
;872:			// start a new menu
;873:			Menu_New(handle);
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 Menu_New
CALLV
pop
line 874
;874:		}
LABELV $605
line 875
;875:	}
LABELV $592
line 843
ADDRGP4 $591
JUMPV
LABELV $593
line 876
;876:	trap_PC_FreeSource(handle);
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 trap_PC_FreeSource
CALLI4
pop
line 877
;877:}
LABELV $587
endproc UI_ParseMenu 1060 12
export Load_Menu
proc Load_Menu 1048 8
line 879
;878:
;879:qboolean Load_Menu(int handle) {
line 882
;880:	pc_token_t token;
;881:
;882:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1040
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $610
line 883
;883:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $609
JUMPV
LABELV $610
line 884
;884:	if (token.string[0] != '{') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $616
line 885
;885:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $609
JUMPV
LABELV $615
line 888
;886:	}
;887:
;888:	while (1) {
line 890
;889:
;890:		if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $618
line 891
;891:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $609
JUMPV
LABELV $618
line 893
;892:
;893:		if (token.string[0] == 0) {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $620
line 894
;894:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $609
JUMPV
LABELV $620
line 897
;895:		}
;896:
;897:		if (token.string[0] == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $623
line 898
;898:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $609
JUMPV
LABELV $623
line 901
;899:		}
;900:
;901:		UI_ParseMenu(token.string);
ADDRLP4 0+16
ARGP4
ADDRGP4 UI_ParseMenu
CALLV
pop
line 902
;902:	}
LABELV $616
line 888
ADDRGP4 $615
JUMPV
line 903
;903:	return qfalse;
CNSTI4 0
RETI4
LABELV $609
endproc Load_Menu 1048 8
export UI_LoadMenus
proc UI_LoadMenus 1068 8
line 906
;904:}
;905:
;906:void UI_LoadMenus(const char *menuFile, qboolean reset) {
line 911
;907:	pc_token_t token;
;908:	int handle;
;909:	int start;
;910:
;911:	start = trap_Milliseconds();
ADDRLP4 1048
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 1044
ADDRLP4 1048
INDIRI4
ASGNI4
line 913
;912:
;913:	handle = trap_PC_LoadSource(menuFile);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1052
ADDRGP4 trap_PC_LoadSource
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1052
INDIRI4
ASGNI4
line 914
;914:	if (!handle) {
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $628
line 915
;915:		trap_Error(va(S_COLOR_YELLOW "menu file not found: %s, using default\n", menuFile));
ADDRGP4 $630
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1056
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1056
INDIRP4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 916
;916:		handle = trap_PC_LoadSource("ui/menus.txt");
ADDRGP4 $631
ARGP4
ADDRLP4 1060
ADDRGP4 trap_PC_LoadSource
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1060
INDIRI4
ASGNI4
line 917
;917:		if (!handle) {
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $632
line 918
;918:			trap_Error(va(S_COLOR_RED "default menu file not found: ui/menus.txt, unable to continue!\n", menuFile));
ADDRGP4 $634
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1064
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1064
INDIRP4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 919
;919:		}
LABELV $632
line 920
;920:	}
LABELV $628
line 922
;921:
;922:	ui_new.integer = 1;
ADDRGP4 ui_new+12
CNSTI4 1
ASGNI4
line 924
;923:
;924:	if (reset) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $639
line 925
;925:		Menu_Reset();
ADDRGP4 Menu_Reset
CALLV
pop
line 926
;926:	}
ADDRGP4 $639
JUMPV
LABELV $638
line 928
;927:
;928:	while (1) {
line 929
;929:		if (!trap_PC_ReadToken(handle, &token))
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1056
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $641
line 930
;930:			break;
ADDRGP4 $640
JUMPV
LABELV $641
line 931
;931:		if (token.string[0] == 0 || token.string[0] == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $647
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $643
LABELV $647
line 932
;932:			break;
ADDRGP4 $640
JUMPV
LABELV $643
line 935
;933:		}
;934:
;935:		if (token.string[0] == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $648
line 936
;936:			break;
ADDRGP4 $640
JUMPV
LABELV $648
line 939
;937:		}
;938:
;939:		if (Q_stricmp(token.string, "loadmenu") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $654
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $651
line 940
;940:			if (Load_Menu(handle)) {
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 1064
ADDRGP4 Load_Menu
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
EQI4 $640
line 941
;941:				continue;
line 942
;942:			} else {
line 943
;943:				break;
LABELV $651
line 946
;944:			}
;945:		}
;946:	}
LABELV $639
line 928
ADDRGP4 $638
JUMPV
LABELV $640
line 948
;947:
;948:	Com_Printf("UI menu load time = %d milli seconds\n", trap_Milliseconds() - start);
ADDRLP4 1056
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRGP4 $657
ARGP4
ADDRLP4 1056
INDIRI4
ADDRLP4 1044
INDIRI4
SUBI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 950
;949:
;950:	trap_PC_FreeSource(handle);
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 trap_PC_FreeSource
CALLI4
pop
line 951
;951:}
LABELV $627
endproc UI_LoadMenus 1068 8
export UI_Load
proc UI_Load 1048 8
line 953
;952:
;953:void UI_Load() {
line 955
;954:	char lastName[1024];
;955:	menuDef_t *menu = Menu_GetFocused();
ADDRLP4 1032
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 1032
INDIRP4
ASGNP4
line 956
;956:	char *menuSet = UI_Cvar_VariableString("ui_menuFiles");
ADDRGP4 $659
ARGP4
ADDRLP4 1036
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1036
INDIRP4
ASGNP4
line 957
;957:	if (menu && menu->window.name) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $660
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $660
line 958
;958:		strcpy(lastName, menu->window.name);
ADDRLP4 8
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 959
;959:	}
LABELV $660
line 960
;960:	if (menuSet == NULL || menuSet[0] == '\0') {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $664
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $662
LABELV $664
line 961
;961:		menuSet = "ui/menus.txt";
ADDRLP4 0
ADDRGP4 $631
ASGNP4
line 962
;962:	}
LABELV $662
line 964
;963:
;964:	String_Init();
ADDRGP4 String_Init
CALLV
pop
line 969
;965:
;966:#ifdef PRE_RELEASE_TADEMO
;967:	UI_ParseGameInfo("demogameinfo.txt");
;968:#else
;969:	UI_ParseGameInfo("gameinfo.txt");
ADDRGP4 $665
ARGP4
ADDRGP4 UI_ParseGameInfo
CALLV
pop
line 970
;970:	UI_LoadArenas();
ADDRGP4 UI_LoadArenas
CALLV
pop
line 973
;971:#endif
;972:
;973:	UI_LoadMenus(menuSet, qtrue);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 UI_LoadMenus
CALLV
pop
line 974
;974:	Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 975
;975:	Menus_ActivateByName(lastName);
ADDRLP4 8
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 977
;976:
;977:}
LABELV $658
endproc UI_Load 1048 8
data
align 4
LABELV handicapValues
address $666
address $667
address $668
address $669
address $670
address $671
address $672
address $673
address $674
address $675
address $676
address $677
address $678
address $679
address $680
address $681
address $682
address $683
address $684
address $685
byte 4 0
code
proc UI_DrawHandicap 20 32
line 981
;978:
;979:static const char *handicapValues[] = { "None","95","90","85","80","75","70","65","60","55","50","45","40","35","30","25","20","15","10","5",NULL };
;980:
;981:static void UI_DrawHandicap(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 984
;982:	int i, h;
;983:
;984:	h = Com_Clamp(5, 100, trap_Cvar_VariableValue("handicap"));
ADDRGP4 $687
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1084227584
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 985
;985:	i = 20 - h / 5;
ADDRLP4 0
CNSTI4 20
ADDRLP4 4
INDIRI4
CNSTI4 5
DIVI4
SUBI4
ASGNI4
line 987
;986:
;987:	Text_Paint(rect->x, rect->y, scale, color, handicapValues[i], 0, 0, textStyle);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 handicapValues
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 988
;988:}
LABELV $686
endproc UI_DrawHandicap 20 32
proc UI_DrawClanName 8 32
line 990
;989:
;990:static void UI_DrawClanName(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 991
;991:	Text_Paint(rect->x, rect->y, scale, color, UI_Cvar_VariableString("ui_teamName"), 0, 0, textStyle);
ADDRGP4 $689
ARGP4
ADDRLP4 0
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 992
;992:}
LABELV $688
endproc UI_DrawClanName 8 32
proc UI_SetCapFragLimits 16 8
line 995
;993:
;994:
;995:static void UI_SetCapFragLimits(qboolean uiVars) {
line 996
;996:	int cap = 5;
ADDRLP4 0
CNSTI4 5
ASGNI4
line 997
;997:	int frag = 10;
ADDRLP4 4
CNSTI4 10
ASGNI4
line 998
;998:	if (uiInfo.gameTypes[ui_gameType.integer].gtEnum == GT_OBELISK) {
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580+4
ADDP4
INDIRI4
CNSTI4 7
NEI4 $691
line 999
;999:		cap = 4;
ADDRLP4 0
CNSTI4 4
ASGNI4
line 1000
;1000:	} else if (uiInfo.gameTypes[ui_gameType.integer].gtEnum == GT_HARVESTER) {
ADDRGP4 $692
JUMPV
LABELV $691
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580+4
ADDP4
INDIRI4
CNSTI4 8
NEI4 $696
line 1001
;1001:		cap = 15;
ADDRLP4 0
CNSTI4 15
ASGNI4
line 1002
;1002:	}
LABELV $696
LABELV $692
line 1003
;1003:	if (uiVars) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $701
line 1004
;1004:		trap_Cvar_Set("ui_captureLimit", va("%d", cap));
ADDRGP4 $704
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $703
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1005
;1005:		trap_Cvar_Set("ui_fragLimit", va("%d", frag));
ADDRGP4 $704
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $705
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1006
;1006:	} else {
ADDRGP4 $702
JUMPV
LABELV $701
line 1007
;1007:		trap_Cvar_Set("capturelimit", va("%d", cap));
ADDRGP4 $704
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $706
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1008
;1008:		trap_Cvar_Set("fraglimit", va("%d", frag));
ADDRGP4 $704
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $707
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1009
;1009:	}
LABELV $702
line 1010
;1010:}
LABELV $690
endproc UI_SetCapFragLimits 16 8
proc UI_DrawGameType 4 32
line 1012
;1011:// ui_gameType assumes gametype 0 is -1 ALL and will not show
;1012:static void UI_DrawGameType(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1013
;1013:	Text_Paint(rect->x, rect->y, scale, color, uiInfo.gameTypes[ui_gameType.integer].gameType, 0, 0, textStyle);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1014
;1014:}
LABELV $708
endproc UI_DrawGameType 4 32
proc UI_DrawNetGameType 4 32
line 1016
;1015:
;1016:static void UI_DrawNetGameType(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1017
;1017:	if (ui_netGameType.integer < 0 || ui_netGameType.integer > uiInfo.numGameTypes) {
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 0
LTI4 $717
ADDRGP4 ui_netGameType+12
INDIRI4
ADDRGP4 uiInfo+78576
INDIRI4
LEI4 $712
LABELV $717
line 1018
;1018:		trap_Cvar_Set("ui_netGameType", "0");
ADDRGP4 $718
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1019
;1019:		trap_Cvar_Set("ui_actualNetGameType", "0");
ADDRGP4 $719
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1020
;1020:	}
LABELV $712
line 1021
;1021:	Text_Paint(rect->x, rect->y, scale, color, uiInfo.gameTypes[ui_netGameType.integer].gameType, 0, 0, textStyle);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1022
;1022:}
LABELV $711
endproc UI_DrawNetGameType 4 32
proc UI_DrawJoinGameType 4 32
line 1024
;1023:
;1024:static void UI_DrawJoinGameType(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1025
;1025:	if (ui_joinGameType.integer < 0 || ui_joinGameType.integer > uiInfo.numJoinGameTypes) {
ADDRGP4 ui_joinGameType+12
INDIRI4
CNSTI4 0
LTI4 $728
ADDRGP4 ui_joinGameType+12
INDIRI4
ADDRGP4 uiInfo+78708
INDIRI4
LEI4 $723
LABELV $728
line 1026
;1026:		trap_Cvar_Set("ui_joinGameType", "0");
ADDRGP4 $729
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1027
;1027:	}
LABELV $723
line 1028
;1028:	Text_Paint(rect->x, rect->y, scale, color, uiInfo.joinGameTypes[ui_joinGameType.integer].gameType, 0, 0, textStyle);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 ui_joinGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78712
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1029
;1029:}
LABELV $722
endproc UI_DrawJoinGameType 4 32
proc UI_TeamIndexFromName 12 8
line 1033
;1030:
;1031:
;1032:
;1033:static int UI_TeamIndexFromName(const char *name) {
line 1036
;1034:	int i;
;1035:
;1036:	if (name && *name) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $733
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $733
line 1037
;1037:		for (i = 0; i < uiInfo.teamCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $738
JUMPV
LABELV $735
line 1038
;1038:			if (Q_stricmp(name, uiInfo.teamList[i].teamName) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $740
line 1039
;1039:				return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $732
JUMPV
LABELV $740
line 1041
;1040:			}
;1041:		}
LABELV $736
line 1037
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $738
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+75756
INDIRI4
LTI4 $735
line 1042
;1042:	}
LABELV $733
line 1044
;1043:
;1044:	return 0;
CNSTI4 0
RETI4
LABELV $732
endproc UI_TeamIndexFromName 12 8
proc UI_DrawClanLogo 48 20
line 1048
;1045:
;1046:}
;1047:
;1048:static void UI_DrawClanLogo(rectDef_t *rect, float scale, vec4_t color) {
line 1050
;1049:	int i;
;1050:	i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $689
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1051
;1051:	if (i >= 0 && i < uiInfo.teamCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $744
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+75756
INDIRI4
GEI4 $744
line 1052
;1052:		trap_R_SetColor(color);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1054
;1053:
;1054:		if (uiInfo.teamList[i].teamIcon == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+28
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $747
line 1055
;1055:			uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+28
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 1056
;1056:			uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal", uiInfo.teamList[i].imageName));
ADDRGP4 $757
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+32
ADDP4
ADDRLP4 32
INDIRI4
ASGNI4
line 1057
;1057:			uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $762
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+36
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 1058
;1058:		}
LABELV $747
line 1060
;1059:
;1060:		UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+28
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1061
;1061:		trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1062
;1062:	}
LABELV $744
line 1063
;1063:}
LABELV $743
endproc UI_DrawClanLogo 48 20
proc UI_DrawClanCinematic 28 24
line 1065
;1064:
;1065:static void UI_DrawClanCinematic(rectDef_t *rect, float scale, vec4_t color) {
line 1067
;1066:	int i;
;1067:	i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $689
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1068
;1068:	if (i >= 0 && i < uiInfo.teamCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $768
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+75756
INDIRI4
GEI4 $768
line 1070
;1069:
;1070:		if (uiInfo.teamList[i].cinematic >= -2) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+40
ADDP4
INDIRI4
CNSTI4 -2
LTI4 $771
line 1071
;1071:			if (uiInfo.teamList[i].cinematic == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+40
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $775
line 1072
;1072:				uiInfo.teamList[i].cinematic = trap_CIN_PlayCinematic(va("%s.roq", uiInfo.teamList[i].imageName), 0, 0, 0, 0, (CIN_loop | CIN_silent));
ADDRGP4 $781
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 24
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+40
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 1073
;1073:			}
LABELV $775
line 1074
;1074:			if (uiInfo.teamList[i].cinematic >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+40
ADDP4
INDIRI4
CNSTI4 0
LTI4 $784
line 1075
;1075:				trap_CIN_RunCinematic(uiInfo.teamList[i].cinematic);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+40
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_RunCinematic
CALLI4
pop
line 1076
;1076:				trap_CIN_SetExtents(uiInfo.teamList[i].cinematic, rect->x, rect->y, rect->w, rect->h);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+40
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 trap_CIN_SetExtents
CALLV
pop
line 1077
;1077:				trap_CIN_DrawCinematic(uiInfo.teamList[i].cinematic);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+40
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_DrawCinematic
CALLV
pop
line 1078
;1078:			} else {
ADDRGP4 $772
JUMPV
LABELV $784
line 1079
;1079:				trap_R_SetColor(color);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1080
;1080:				UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon_Metal);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+32
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1081
;1081:				trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1082
;1082:				uiInfo.teamList[i].cinematic = -2;
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+40
ADDP4
CNSTI4 -2
ASGNI4
line 1083
;1083:			}
line 1084
;1084:		} else {
ADDRGP4 $772
JUMPV
LABELV $771
line 1085
;1085:			trap_R_SetColor(color);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1086
;1086:			UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+28
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1087
;1087:			trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1088
;1088:		}
LABELV $772
line 1089
;1089:	}
LABELV $768
line 1091
;1090:
;1091:}
LABELV $767
endproc UI_DrawClanCinematic 28 24
proc UI_DrawPreviewCinematic 12 24
line 1093
;1092:
;1093:static void UI_DrawPreviewCinematic(rectDef_t *rect, float scale, vec4_t color) {
line 1094
;1094:	if (uiInfo.previewMovie > -2) {
ADDRGP4 uiInfo+99260
INDIRI4
CNSTI4 -2
LEI4 $801
line 1095
;1095:		uiInfo.previewMovie = trap_CIN_PlayCinematic(va("%s.roq", uiInfo.movieList[uiInfo.movieIndex]), 0, 0, 0, 0, (CIN_loop | CIN_silent));
ADDRGP4 $781
ARGP4
ADDRGP4 uiInfo+99256
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+98228
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 4
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRGP4 uiInfo+99260
ADDRLP4 4
INDIRI4
ASGNI4
line 1096
;1096:		if (uiInfo.previewMovie >= 0) {
ADDRGP4 uiInfo+99260
INDIRI4
CNSTI4 0
LTI4 $807
line 1097
;1097:			trap_CIN_RunCinematic(uiInfo.previewMovie);
ADDRGP4 uiInfo+99260
INDIRI4
ARGI4
ADDRGP4 trap_CIN_RunCinematic
CALLI4
pop
line 1098
;1098:			trap_CIN_SetExtents(uiInfo.previewMovie, rect->x, rect->y, rect->w, rect->h);
ADDRGP4 uiInfo+99260
INDIRI4
ARGI4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 trap_CIN_SetExtents
CALLV
pop
line 1099
;1099:			trap_CIN_DrawCinematic(uiInfo.previewMovie);
ADDRGP4 uiInfo+99260
INDIRI4
ARGI4
ADDRGP4 trap_CIN_DrawCinematic
CALLV
pop
line 1100
;1100:		} else {
ADDRGP4 $808
JUMPV
LABELV $807
line 1101
;1101:			uiInfo.previewMovie = -2;
ADDRGP4 uiInfo+99260
CNSTI4 -2
ASGNI4
line 1102
;1102:		}
LABELV $808
line 1103
;1103:	}
LABELV $801
line 1105
;1104:
;1105:}
LABELV $800
endproc UI_DrawPreviewCinematic 12 24
proc UI_DrawSkill 16 32
line 1109
;1106:
;1107:
;1108:
;1109:static void UI_DrawSkill(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1111
;1110:	int i;
;1111:	i = trap_Cvar_VariableValue("g_spSkill");
ADDRGP4 $815
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 1112
;1112:	if (i < 1 || i > numSkillLevels) {
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $818
ADDRLP4 0
INDIRI4
ADDRGP4 numSkillLevels
INDIRI4
LEI4 $816
LABELV $818
line 1113
;1113:		i = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1114
;1114:	}
LABELV $816
line 1115
;1115:	Text_Paint(rect->x, rect->y, scale, color, skillLevels[i - 1], 0, 0, textStyle);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 skillLevels-4
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1116
;1116:}
LABELV $814
endproc UI_DrawSkill 16 32
proc UI_DrawTeamName 32 32
line 1119
;1117:
;1118:
;1119:static void UI_DrawTeamName(rectDef_t *rect, float scale, vec4_t color, qboolean blue, int textStyle) {
line 1121
;1120:	int i;
;1121:	i = UI_TeamIndexFromName(UI_Cvar_VariableString((blue) ? "ui_blueTeam" : "ui_redTeam"));
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $824
ADDRLP4 4
ADDRGP4 $821
ASGNP4
ADDRGP4 $825
JUMPV
LABELV $824
ADDRLP4 4
ADDRGP4 $822
ASGNP4
LABELV $825
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 1122
;1122:	if (i >= 0 && i < uiInfo.teamCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $826
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+75756
INDIRI4
GEI4 $826
line 1123
;1123:		Text_Paint(rect->x, rect->y, scale, color, va("%s: %s", (blue) ? "Blue" : "Red", uiInfo.teamList[i].teamName), 0, 0, textStyle);
ADDRGP4 $829
ARGP4
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $834
ADDRLP4 20
ADDRGP4 $830
ASGNP4
ADDRGP4 $835
JUMPV
LABELV $834
ADDRLP4 20
ADDRGP4 $831
ASGNP4
LABELV $835
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1124
;1124:	}
LABELV $826
line 1125
;1125:}
LABELV $820
endproc UI_DrawTeamName 32 32
proc UI_DrawTeamMember 28 32
line 1127
;1126:
;1127:static void UI_DrawTeamMember(rectDef_t *rect, float scale, vec4_t color, qboolean blue, int num, int textStyle) {
line 1131
;1128:	// 0 - None
;1129:	// 1 - Human
;1130:	// 2..NumCharacters - Bot
;1131:	int value = trap_Cvar_VariableValue(va(blue ? "ui_blueteam%i" : "ui_redteam%i", num));
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $840
ADDRLP4 8
ADDRGP4 $837
ASGNP4
ADDRGP4 $841
JUMPV
LABELV $840
ADDRLP4 8
ADDRGP4 $838
ASGNP4
LABELV $841
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
line 1133
;1132:	const char *text;
;1133:	if (value <= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $842
line 1134
;1134:		text = "Closed";
ADDRLP4 4
ADDRGP4 $844
ASGNP4
line 1135
;1135:	} else if (value == 1) {
ADDRGP4 $843
JUMPV
LABELV $842
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $845
line 1136
;1136:		text = "Human";
ADDRLP4 4
ADDRGP4 $847
ASGNP4
line 1137
;1137:	} else {
ADDRGP4 $846
JUMPV
LABELV $845
line 1138
;1138:		value -= 2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 1140
;1139:
;1140:		if (ui_actualNetGameType.integer >= GT_TEAM) {
ADDRGP4 ui_actualNetGameType+12
INDIRI4
CNSTI4 3
LTI4 $848
line 1141
;1141:			if (value >= uiInfo.characterCount) {
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+73440
INDIRI4
LTI4 $851
line 1142
;1142:				value = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1143
;1143:			}
LABELV $851
line 1144
;1144:			text = uiInfo.characterList[value].name;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448
ADDP4
INDIRP4
ASGNP4
line 1145
;1145:		} else {
ADDRGP4 $849
JUMPV
LABELV $848
line 1146
;1146:			if (value >= UI_GetNumBots()) {
ADDRLP4 20
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 20
INDIRI4
LTI4 $855
line 1147
;1147:				value = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1148
;1148:			}
LABELV $855
line 1149
;1149:			text = UI_GetBotNameByNumber(value);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 UI_GetBotNameByNumber
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 1150
;1150:		}
LABELV $849
line 1151
;1151:	}
LABELV $846
LABELV $843
line 1152
;1152:	Text_Paint(rect->x, rect->y, scale, color, text, 0, 0, textStyle);
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 20
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1153
;1153:}
LABELV $836
endproc UI_DrawTeamMember 28 32
proc UI_DrawEffects 8 20
line 1155
;1154:
;1155:static void UI_DrawEffects(rectDef_t *rect, float scale, vec4_t color) {
line 1156
;1156:	UI_DrawHandlePic(rect->x, rect->y - 14, 128, 8, uiInfo.uiDC.Assets.fxBasePic);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1096810496
SUBF4
ARGF4
CNSTF4 1124073472
ARGF4
CNSTF4 1090519040
ARGF4
ADDRGP4 uiInfo+228+61768
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1157
;1157:	UI_DrawHandlePic(rect->x + uiInfo.effectsColor * 16 + 8, rect->y - 16, 16, 12, uiInfo.uiDC.Assets.fxPic[uiInfo.effectsColor]);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 uiInfo+136904
INDIRI4
CNSTI4 4
LSHI4
CVIF4 4
ADDF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
ARGF4
CNSTF4 1098907648
ARGF4
CNSTF4 1094713344
ARGF4
ADDRGP4 uiInfo+136904
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+228+61772
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1158
;1158:}
LABELV $857
endproc UI_DrawEffects 8 20
proc UI_DrawMapPreview 20 20
line 1160
;1159:
;1160:static void UI_DrawMapPreview(rectDef_t *rect, float scale, vec4_t color, qboolean net) {
line 1161
;1161:	int map = (net) ? ui_currentNetMap.integer : ui_currentMap.integer;
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $868
ADDRLP4 4
ADDRGP4 ui_currentNetMap+12
INDIRI4
ASGNI4
ADDRGP4 $869
JUMPV
LABELV $868
ADDRLP4 4
ADDRGP4 ui_currentMap+12
INDIRI4
ASGNI4
LABELV $869
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1162
;1162:	if (map < 0 || map > uiInfo.mapCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $873
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+83224
INDIRI4
LEI4 $870
LABELV $873
line 1163
;1163:		if (net) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $874
line 1164
;1164:			ui_currentNetMap.integer = 0;
ADDRGP4 ui_currentNetMap+12
CNSTI4 0
ASGNI4
line 1165
;1165:			trap_Cvar_Set("ui_currentNetMap", "0");
ADDRGP4 $877
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1166
;1166:		} else {
ADDRGP4 $875
JUMPV
LABELV $874
line 1167
;1167:			ui_currentMap.integer = 0;
ADDRGP4 ui_currentMap+12
CNSTI4 0
ASGNI4
line 1168
;1168:			trap_Cvar_Set("ui_currentMap", "0");
ADDRGP4 $879
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1169
;1169:		}
LABELV $875
line 1170
;1170:		map = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1171
;1171:	}
LABELV $870
line 1173
;1172:
;1173:	if (uiInfo.mapList[map].levelShot == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+92
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $880
line 1174
;1174:		uiInfo.mapList[map].levelShot = trap_R_RegisterShaderNoMip(uiInfo.mapList[map].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+8
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+92
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1175
;1175:	}
LABELV $880
line 1177
;1176:
;1177:	if (uiInfo.mapList[map].levelShot > 0) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+92
ADDP4
INDIRI4
CNSTI4 0
LEI4 $888
line 1178
;1178:		UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.mapList[map].levelShot);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+92
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1179
;1179:	} else {
ADDRGP4 $889
JUMPV
LABELV $888
line 1180
;1180:		UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, trap_R_RegisterShaderNoMip("menu/art/unknownmap"));
ADDRGP4 $894
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1181
;1181:	}
LABELV $889
line 1182
;1182:}
LABELV $864
endproc UI_DrawMapPreview 20 20
proc UI_DrawMapTimeToBeat 20 32
line 1185
;1183:
;1184:
;1185:static void UI_DrawMapTimeToBeat(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1187
;1186:	int minutes, seconds, time;
;1187:	if (ui_currentMap.integer < 0 || ui_currentMap.integer > uiInfo.mapCount) {
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 0
LTI4 $901
ADDRGP4 ui_currentMap+12
INDIRI4
ADDRGP4 uiInfo+83224
INDIRI4
LEI4 $896
LABELV $901
line 1188
;1188:		ui_currentMap.integer = 0;
ADDRGP4 ui_currentMap+12
CNSTI4 0
ASGNI4
line 1189
;1189:		trap_Cvar_Set("ui_currentMap", "0");
ADDRGP4 $879
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1190
;1190:	}
LABELV $896
line 1192
;1191:
;1192:	time = uiInfo.mapList[ui_currentMap.integer].timeToBeat[uiInfo.gameTypes[ui_gameType.integer].gtEnum];
ADDRLP4 0
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580+4
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+28
ADDP4
ADDP4
INDIRI4
ASGNI4
line 1194
;1193:
;1194:	minutes = time / 60;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 60
DIVI4
ASGNI4
line 1195
;1195:	seconds = time % 60;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 60
MODI4
ASGNI4
line 1197
;1196:
;1197:	Text_Paint(rect->x, rect->y, scale, color, va("%02i:%02i", minutes, seconds), 0, 0, textStyle);
ADDRGP4 $909
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1198
;1198:}
LABELV $895
endproc UI_DrawMapTimeToBeat 20 32
proc UI_DrawMapCinematic 24 24
line 1202
;1199:
;1200:
;1201:
;1202:static void UI_DrawMapCinematic(rectDef_t *rect, float scale, vec4_t color, qboolean net) {
line 1204
;1203:
;1204:	int map = (net) ? ui_currentNetMap.integer : ui_currentMap.integer;
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $914
ADDRLP4 4
ADDRGP4 ui_currentNetMap+12
INDIRI4
ASGNI4
ADDRGP4 $915
JUMPV
LABELV $914
ADDRLP4 4
ADDRGP4 ui_currentMap+12
INDIRI4
ASGNI4
LABELV $915
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1205
;1205:	if (map < 0 || map > uiInfo.mapCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $919
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+83224
INDIRI4
LEI4 $916
LABELV $919
line 1206
;1206:		if (net) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $920
line 1207
;1207:			ui_currentNetMap.integer = 0;
ADDRGP4 ui_currentNetMap+12
CNSTI4 0
ASGNI4
line 1208
;1208:			trap_Cvar_Set("ui_currentNetMap", "0");
ADDRGP4 $877
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1209
;1209:		} else {
ADDRGP4 $921
JUMPV
LABELV $920
line 1210
;1210:			ui_currentMap.integer = 0;
ADDRGP4 ui_currentMap+12
CNSTI4 0
ASGNI4
line 1211
;1211:			trap_Cvar_Set("ui_currentMap", "0");
ADDRGP4 $879
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1212
;1212:		}
LABELV $921
line 1213
;1213:		map = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1214
;1214:	}
LABELV $916
line 1216
;1215:
;1216:	if (uiInfo.mapList[map].cinematic >= -1) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+24
ADDP4
INDIRI4
CNSTI4 -1
LTI4 $924
line 1217
;1217:		if (uiInfo.mapList[map].cinematic == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+24
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $928
line 1218
;1218:			uiInfo.mapList[map].cinematic = trap_CIN_PlayCinematic(va("%s.roq", uiInfo.mapList[map].mapLoadName), 0, 0, 0, 0, (CIN_loop | CIN_silent));
ADDRGP4 $781
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 20
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+24
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 1219
;1219:		}
LABELV $928
line 1220
;1220:		if (uiInfo.mapList[map].cinematic >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+24
ADDP4
INDIRI4
CNSTI4 0
LTI4 $936
line 1221
;1221:			trap_CIN_RunCinematic(uiInfo.mapList[map].cinematic);
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+24
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_RunCinematic
CALLI4
pop
line 1222
;1222:			trap_CIN_SetExtents(uiInfo.mapList[map].cinematic, rect->x, rect->y, rect->w, rect->h);
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+24
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 trap_CIN_SetExtents
CALLV
pop
line 1223
;1223:			trap_CIN_DrawCinematic(uiInfo.mapList[map].cinematic);
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+24
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_DrawCinematic
CALLV
pop
line 1224
;1224:		} else {
ADDRGP4 $925
JUMPV
LABELV $936
line 1225
;1225:			uiInfo.mapList[map].cinematic = -2;
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+24
ADDP4
CNSTI4 -2
ASGNI4
line 1226
;1226:		}
line 1227
;1227:	} else {
ADDRGP4 $925
JUMPV
LABELV $924
line 1228
;1228:		UI_DrawMapPreview(rect, scale, color, net);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 UI_DrawMapPreview
CALLV
pop
line 1229
;1229:	}
LABELV $925
line 1230
;1230:}
LABELV $910
endproc UI_DrawMapCinematic 24 24
data
align 4
LABELV updateModel
byte 4 1
align 4
LABELV q3Model
byte 4 0
bss
align 4
LABELV $949
skip 1276
code
proc UI_DrawPlayerModel 616 28
line 1237
;1231:
;1232:
;1233:
;1234:static qboolean updateModel = qtrue;
;1235:static qboolean q3Model = qfalse;
;1236:
;1237:static void UI_DrawPlayerModel(rectDef_t *rect) {
line 1245
;1238:	static playerInfo_t info;
;1239:	char model[MAX_QPATH];
;1240:	char team[256];
;1241:	char head[256];
;1242:	vec3_t	viewangles;
;1243:	vec3_t	moveangles;
;1244:
;1245:	if (trap_Cvar_VariableValue("ui_Q3Model")) {
ADDRGP4 $952
ARGP4
ADDRLP4 600
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 600
INDIRF4
CNSTF4 0
EQF4 $950
line 1246
;1246:		strcpy(model, UI_Cvar_VariableString("model"));
ADDRGP4 $953
ARGP4
ADDRLP4 604
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 12
ARGP4
ADDRLP4 604
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1247
;1247:		strcpy(head, UI_Cvar_VariableString("headmodel"));
ADDRGP4 $954
ARGP4
ADDRLP4 608
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 332
ARGP4
ADDRLP4 608
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1248
;1248:		if (!q3Model) {
ADDRGP4 q3Model
INDIRI4
CNSTI4 0
NEI4 $955
line 1249
;1249:			q3Model = qtrue;
ADDRGP4 q3Model
CNSTI4 1
ASGNI4
line 1250
;1250:			updateModel = qtrue;
ADDRGP4 updateModel
CNSTI4 1
ASGNI4
line 1251
;1251:		}
LABELV $955
line 1252
;1252:		team[0] = '\0';
ADDRLP4 76
CNSTI1 0
ASGNI1
line 1253
;1253:	} else {
ADDRGP4 $951
JUMPV
LABELV $950
line 1255
;1254:
;1255:		strcpy(team, UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $689
ARGP4
ADDRLP4 604
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 76
ARGP4
ADDRLP4 604
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1256
;1256:		strcpy(model, UI_Cvar_VariableString("team_model"));
ADDRGP4 $957
ARGP4
ADDRLP4 608
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 12
ARGP4
ADDRLP4 608
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1257
;1257:		strcpy(head, UI_Cvar_VariableString("team_headmodel"));
ADDRGP4 $958
ARGP4
ADDRLP4 612
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 332
ARGP4
ADDRLP4 612
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1258
;1258:		if (q3Model) {
ADDRGP4 q3Model
INDIRI4
CNSTI4 0
EQI4 $959
line 1259
;1259:			q3Model = qfalse;
ADDRGP4 q3Model
CNSTI4 0
ASGNI4
line 1260
;1260:			updateModel = qtrue;
ADDRGP4 updateModel
CNSTI4 1
ASGNI4
line 1261
;1261:		}
LABELV $959
line 1262
;1262:	}
LABELV $951
line 1263
;1263:	if (updateModel) {
ADDRGP4 updateModel
INDIRI4
CNSTI4 0
EQI4 $961
line 1264
;1264:		memset(&info, 0, sizeof(playerInfo_t));
ADDRGP4 $949
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1276
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1265
;1265:		viewangles[YAW] = 180 - 10;
ADDRLP4 0+4
CNSTF4 1126825984
ASGNF4
line 1266
;1266:		viewangles[PITCH] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1267
;1267:		viewangles[ROLL] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1268
;1268:		VectorClear(moveangles);
ADDRLP4 588
CNSTF4 0
ASGNF4
ADDRLP4 588+4
CNSTF4 0
ASGNF4
ADDRLP4 588+8
CNSTF4 0
ASGNF4
line 1269
;1269:		UI_PlayerInfo_SetModel(&info, model, head, team);
ADDRGP4 $949
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 332
ARGP4
ADDRLP4 76
ARGP4
ADDRGP4 UI_PlayerInfo_SetModel
CALLV
pop
line 1270
;1270:		UI_PlayerInfo_SetInfo(&info, LEGS_IDLE, TORSO_STAND, viewangles, vec3_origin, WP_MACHINEGUN, qfalse);
ADDRGP4 $949
ARGP4
CNSTI4 22
ARGI4
CNSTI4 11
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 vec3_origin
ARGP4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_PlayerInfo_SetInfo
CALLV
pop
line 1272
;1271:		//		UI_RegisterClientModelname( &info, model, head, team);
;1272:		updateModel = qfalse;
ADDRGP4 updateModel
CNSTI4 0
ASGNI4
line 1273
;1273:	}
LABELV $961
line 1275
;1274:
;1275:	UI_DrawPlayer(rect->x, rect->y, rect->w, rect->h, &info, uiInfo.uiDC.realTime / 2);
ADDRLP4 604
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 604
INDIRP4
INDIRF4
ARGF4
ADDRLP4 604
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 604
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 604
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 $949
ARGP4
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 2
DIVI4
ARGI4
ADDRGP4 UI_DrawPlayer
CALLV
pop
line 1277
;1276:
;1277:}
LABELV $948
endproc UI_DrawPlayerModel 616 28
proc UI_DrawNetSource 8 32
line 1279
;1278:
;1279:static void UI_DrawNetSource(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1280
;1280:	if (ui_netSource.integer < 0 || ui_netSource.integer > numNetSources) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
LTI4 $973
ADDRGP4 ui_netSource+12
INDIRI4
ADDRGP4 numNetSources
INDIRI4
LEI4 $969
LABELV $973
line 1281
;1281:		ui_netSource.integer = 0;
ADDRGP4 ui_netSource+12
CNSTI4 0
ASGNI4
line 1282
;1282:	}
LABELV $969
line 1283
;1283:	Text_Paint(rect->x, rect->y, scale, color, va("Source: %s", netSources[ui_netSource.integer]), 0, 0, textStyle);
ADDRGP4 $975
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 netSources
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1284
;1284:}
LABELV $968
endproc UI_DrawNetSource 8 32
proc UI_DrawNetMapPreview 8 20
line 1286
;1285:
;1286:static void UI_DrawNetMapPreview(rectDef_t *rect, float scale, vec4_t color) {
line 1288
;1287:
;1288:	if (uiInfo.serverStatus.currentServerPreview > 0) {
ADDRGP4 uiInfo+99264+10428
INDIRI4
CNSTI4 0
LEI4 $978
line 1289
;1289:		UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.serverStatus.currentServerPreview);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 uiInfo+99264+10428
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1290
;1290:	} else {
ADDRGP4 $979
JUMPV
LABELV $978
line 1291
;1291:		UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, trap_R_RegisterShaderNoMip("menu/art/unknownmap"));
ADDRGP4 $894
ARGP4
ADDRLP4 0
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1292
;1292:	}
LABELV $979
line 1293
;1293:}
LABELV $977
endproc UI_DrawNetMapPreview 8 20
proc UI_DrawNetMapCinematic 4 20
line 1295
;1294:
;1295:static void UI_DrawNetMapCinematic(rectDef_t *rect, float scale, vec4_t color) {
line 1296
;1296:	if (ui_currentNetMap.integer < 0 || ui_currentNetMap.integer > uiInfo.mapCount) {
ADDRGP4 ui_currentNetMap+12
INDIRI4
CNSTI4 0
LTI4 $990
ADDRGP4 ui_currentNetMap+12
INDIRI4
ADDRGP4 uiInfo+83224
INDIRI4
LEI4 $985
LABELV $990
line 1297
;1297:		ui_currentNetMap.integer = 0;
ADDRGP4 ui_currentNetMap+12
CNSTI4 0
ASGNI4
line 1298
;1298:		trap_Cvar_Set("ui_currentNetMap", "0");
ADDRGP4 $877
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1299
;1299:	}
LABELV $985
line 1301
;1300:
;1301:	if (uiInfo.serverStatus.currentServerCinematic >= 0) {
ADDRGP4 uiInfo+99264+10432
INDIRI4
CNSTI4 0
LTI4 $992
line 1302
;1302:		trap_CIN_RunCinematic(uiInfo.serverStatus.currentServerCinematic);
ADDRGP4 uiInfo+99264+10432
INDIRI4
ARGI4
ADDRGP4 trap_CIN_RunCinematic
CALLI4
pop
line 1303
;1303:		trap_CIN_SetExtents(uiInfo.serverStatus.currentServerCinematic, rect->x, rect->y, rect->w, rect->h);
ADDRGP4 uiInfo+99264+10432
INDIRI4
ARGI4
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 trap_CIN_SetExtents
CALLV
pop
line 1304
;1304:		trap_CIN_DrawCinematic(uiInfo.serverStatus.currentServerCinematic);
ADDRGP4 uiInfo+99264+10432
INDIRI4
ARGI4
ADDRGP4 trap_CIN_DrawCinematic
CALLV
pop
line 1305
;1305:	} else {
ADDRGP4 $993
JUMPV
LABELV $992
line 1306
;1306:		UI_DrawNetMapPreview(rect, scale, color);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 UI_DrawNetMapPreview
CALLV
pop
line 1307
;1307:	}
LABELV $993
line 1308
;1308:}
LABELV $984
endproc UI_DrawNetMapCinematic 4 20
proc UI_DrawNetFilter 8 32
line 1312
;1309:
;1310:
;1311:
;1312:static void UI_DrawNetFilter(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1313
;1313:	if (ui_serverFilterType.integer < 0 || ui_serverFilterType.integer > numServerFilters) {
ADDRGP4 ui_serverFilterType+12
INDIRI4
CNSTI4 0
LTI4 $1007
ADDRGP4 ui_serverFilterType+12
INDIRI4
ADDRGP4 numServerFilters
INDIRI4
LEI4 $1003
LABELV $1007
line 1314
;1314:		ui_serverFilterType.integer = 0;
ADDRGP4 ui_serverFilterType+12
CNSTI4 0
ASGNI4
line 1315
;1315:	}
LABELV $1003
line 1316
;1316:	Text_Paint(rect->x, rect->y, scale, color, va("Filter: %s", serverFilters[ui_serverFilterType.integer].description), 0, 0, textStyle);
ADDRGP4 $1009
ARGP4
ADDRGP4 ui_serverFilterType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 serverFilters
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1317
;1317:}
LABELV $1002
endproc UI_DrawNetFilter 8 32
proc UI_DrawTier 20 32
line 1320
;1318:
;1319:
;1320:static void UI_DrawTier(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1322
;1321:	int i;
;1322:	i = trap_Cvar_VariableValue("ui_currentTier");
ADDRGP4 $1012
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 1323
;1323:	if (i < 0 || i >= uiInfo.tierCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1016
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+96028
INDIRI4
LTI4 $1013
LABELV $1016
line 1324
;1324:		i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1325
;1325:	}
LABELV $1013
line 1326
;1326:	Text_Paint(rect->x, rect->y, scale, color, va("Tier: %s", uiInfo.tierList[i].tierName), 0, 0, textStyle);
ADDRGP4 $1017
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 uiInfo+96032
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1327
;1327:}
LABELV $1011
endproc UI_DrawTier 20 32
proc UI_DrawTierMap 28 20
line 1329
;1328:
;1329:static void UI_DrawTierMap(rectDef_t *rect, int index) {
line 1331
;1330:	int i;
;1331:	i = trap_Cvar_VariableValue("ui_currentTier");
ADDRGP4 $1012
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 1332
;1332:	if (i < 0 || i >= uiInfo.tierCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1023
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+96028
INDIRI4
LTI4 $1020
LABELV $1023
line 1333
;1333:		i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1334
;1334:	}
LABELV $1020
line 1336
;1335:
;1336:	if (uiInfo.tierList[i].mapHandles[index] == -1) {
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 uiInfo+96032+28
ADDP4
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1024
line 1337
;1337:		uiInfo.tierList[i].mapHandles[index] = trap_R_RegisterShaderNoMip(va("levelshots/%s", uiInfo.tierList[i].maps[index]));
ADDRGP4 $1030
ARGP4
ADDRLP4 12
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 uiInfo+96032+4
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 uiInfo+96032+28
ADDP4
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 1338
;1338:	}
LABELV $1024
line 1340
;1339:
;1340:	UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.tierList[i].mapHandles[index]);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 uiInfo+96032+28
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1341
;1341:}
LABELV $1019
endproc UI_DrawTierMap 28 20
proc UI_EnglishMapName 8 8
line 1343
;1342:
;1343:static const char *UI_EnglishMapName(const char *map) {
line 1345
;1344:	int i;
;1345:	for (i = 0; i < uiInfo.mapCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1039
JUMPV
LABELV $1036
line 1346
;1346:		if (Q_stricmp(map, uiInfo.mapList[i].mapLoadName) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1041
line 1347
;1347:			return uiInfo.mapList[i].mapName;
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228
ADDP4
INDIRP4
RETP4
ADDRGP4 $1035
JUMPV
LABELV $1041
line 1349
;1348:		}
;1349:	}
LABELV $1037
line 1345
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1039
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+83224
INDIRI4
LTI4 $1036
line 1350
;1350:	return "";
ADDRGP4 $110
RETP4
LABELV $1035
endproc UI_EnglishMapName 8 8
proc UI_DrawTierMapName 32 32
line 1353
;1351:}
;1352:
;1353:static void UI_DrawTierMapName(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1355
;1354:	int i, j;
;1355:	i = trap_Cvar_VariableValue("ui_currentTier");
ADDRGP4 $1012
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
CVFI4 4
ASGNI4
line 1356
;1356:	if (i < 0 || i >= uiInfo.tierCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1050
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+96028
INDIRI4
LTI4 $1047
LABELV $1050
line 1357
;1357:		i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1358
;1358:	}
LABELV $1047
line 1359
;1359:	j = trap_Cvar_VariableValue("ui_currentMap");
ADDRGP4 $879
ARGP4
ADDRLP4 16
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
line 1360
;1360:	if (j < 0 || j > MAPS_PER_TIER) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $1053
ADDRLP4 4
INDIRI4
CNSTI4 3
LEI4 $1051
LABELV $1053
line 1361
;1361:		j = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1362
;1362:	}
LABELV $1051
line 1364
;1363:
;1364:	Text_Paint(rect->x, rect->y, scale, color, UI_EnglishMapName(uiInfo.tierList[i].maps[j]), 0, 0, textStyle);
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 uiInfo+96032+4
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 UI_EnglishMapName
CALLP4
ASGNP4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1365
;1365:}
LABELV $1046
endproc UI_DrawTierMapName 32 32
proc UI_DrawTierGameType 28 32
line 1367
;1366:
;1367:static void UI_DrawTierGameType(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1369
;1368:	int i, j;
;1369:	i = trap_Cvar_VariableValue("ui_currentTier");
ADDRGP4 $1012
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
CVFI4 4
ASGNI4
line 1370
;1370:	if (i < 0 || i >= uiInfo.tierCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1060
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+96028
INDIRI4
LTI4 $1057
LABELV $1060
line 1371
;1371:		i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1372
;1372:	}
LABELV $1057
line 1373
;1373:	j = trap_Cvar_VariableValue("ui_currentMap");
ADDRGP4 $879
ARGP4
ADDRLP4 16
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
line 1374
;1374:	if (j < 0 || j > MAPS_PER_TIER) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $1063
ADDRLP4 4
INDIRI4
CNSTI4 3
LEI4 $1061
LABELV $1063
line 1375
;1375:		j = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1376
;1376:	}
LABELV $1061
line 1378
;1377:
;1378:	Text_Paint(rect->x, rect->y, scale, color, uiInfo.gameTypes[uiInfo.tierList[i].gameTypes[j]].gameType, 0, 0, textStyle);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 uiInfo+96032+16
ADDP4
ADDP4
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1379
;1379:}
LABELV $1056
endproc UI_DrawTierGameType 28 32
proc UI_AIFromName 8 8
line 1381
;1380:
;1381:static const char *UI_AIFromName(const char *name) {
line 1383
;1382:	int j;
;1383:	for (j = 0; j < uiInfo.aliasCount; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1071
JUMPV
LABELV $1068
line 1384
;1384:		if (Q_stricmp(uiInfo.aliasList[j].name, name) == 0) {
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+74988
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1073
line 1385
;1385:			return uiInfo.aliasList[j].ai;
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+74988+4
ADDP4
INDIRP4
RETP4
ADDRGP4 $1067
JUMPV
LABELV $1073
line 1387
;1386:		}
;1387:	}
LABELV $1069
line 1383
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1071
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+74984
INDIRI4
LTI4 $1068
line 1388
;1388:	return "James";
ADDRGP4 $1078
RETP4
LABELV $1067
endproc UI_AIFromName 8 8
data
align 4
LABELV updateOpponentModel
byte 4 1
bss
align 4
LABELV $1080
skip 1276
code
proc UI_DrawOpponent 416 28
line 1392
;1389:}
;1390:
;1391:static qboolean updateOpponentModel = qtrue;
;1392:static void UI_DrawOpponent(rectDef_t *rect) {
line 1400
;1393:	static playerInfo_t info2;
;1394:	char model[MAX_QPATH];
;1395:	char headmodel[MAX_QPATH];
;1396:	char team[256];
;1397:	vec3_t	viewangles;
;1398:	vec3_t	moveangles;
;1399:
;1400:	if (updateOpponentModel) {
ADDRGP4 updateOpponentModel
INDIRI4
CNSTI4 0
EQI4 $1081
line 1402
;1401:
;1402:		strcpy(model, UI_Cvar_VariableString("ui_opponentModel"));
ADDRGP4 $1083
ARGP4
ADDRLP4 408
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 12
ARGP4
ADDRLP4 408
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1403
;1403:		strcpy(headmodel, UI_Cvar_VariableString("ui_opponentModel"));
ADDRGP4 $1083
ARGP4
ADDRLP4 412
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 76
ARGP4
ADDRLP4 412
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1404
;1404:		team[0] = '\0';
ADDRLP4 152
CNSTI1 0
ASGNI1
line 1406
;1405:
;1406:		memset(&info2, 0, sizeof(playerInfo_t));
ADDRGP4 $1080
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1276
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1407
;1407:		viewangles[YAW] = 180 - 10;
ADDRLP4 0+4
CNSTF4 1126825984
ASGNF4
line 1408
;1408:		viewangles[PITCH] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1409
;1409:		viewangles[ROLL] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1410
;1410:		VectorClear(moveangles);
ADDRLP4 140
CNSTF4 0
ASGNF4
ADDRLP4 140+4
CNSTF4 0
ASGNF4
ADDRLP4 140+8
CNSTF4 0
ASGNF4
line 1411
;1411:		UI_PlayerInfo_SetModel(&info2, model, headmodel, "");
ADDRGP4 $1080
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 76
ARGP4
ADDRGP4 $110
ARGP4
ADDRGP4 UI_PlayerInfo_SetModel
CALLV
pop
line 1412
;1412:		UI_PlayerInfo_SetInfo(&info2, LEGS_IDLE, TORSO_STAND, viewangles, vec3_origin, WP_MACHINEGUN, qfalse);
ADDRGP4 $1080
ARGP4
CNSTI4 22
ARGI4
CNSTI4 11
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 vec3_origin
ARGP4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_PlayerInfo_SetInfo
CALLV
pop
line 1413
;1413:		UI_RegisterClientModelname(&info2, model, headmodel, team);
ADDRGP4 $1080
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 152
ARGP4
ADDRGP4 UI_RegisterClientModelname
CALLI4
pop
line 1414
;1414:		updateOpponentModel = qfalse;
ADDRGP4 updateOpponentModel
CNSTI4 0
ASGNI4
line 1415
;1415:	}
LABELV $1081
line 1417
;1416:
;1417:	UI_DrawPlayer(rect->x, rect->y, rect->w, rect->h, &info2, uiInfo.uiDC.realTime / 2);
ADDRLP4 408
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 408
INDIRP4
INDIRF4
ARGF4
ADDRLP4 408
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 408
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 408
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 $1080
ARGP4
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 2
DIVI4
ARGI4
ADDRGP4 UI_DrawPlayer
CALLV
pop
line 1419
;1418:
;1419:}
LABELV $1079
endproc UI_DrawOpponent 416 28
proc UI_NextOpponent 24 8
line 1421
;1420:
;1421:static void UI_NextOpponent() {
line 1422
;1422:	int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1090
ARGP4
ADDRLP4 8
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 1423
;1423:	int j = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $689
ARGP4
ADDRLP4 16
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
ASGNI4
line 1424
;1424:	i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1425
;1425:	if (i >= uiInfo.teamCount) {
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+75756
INDIRI4
LTI4 $1091
line 1426
;1426:		i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1427
;1427:	}
LABELV $1091
line 1428
;1428:	if (i == j) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $1094
line 1429
;1429:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1430
;1430:		if (i >= uiInfo.teamCount) {
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+75756
INDIRI4
LTI4 $1096
line 1431
;1431:			i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1432
;1432:		}
LABELV $1096
line 1433
;1433:	}
LABELV $1094
line 1434
;1434:	trap_Cvar_Set("ui_opponentName", uiInfo.teamList[i].teamName);
ADDRGP4 $1090
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1435
;1435:}
LABELV $1089
endproc UI_NextOpponent 24 8
proc UI_PriorOpponent 24 8
line 1437
;1436:
;1437:static void UI_PriorOpponent() {
line 1438
;1438:	int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1090
ARGP4
ADDRLP4 8
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 1439
;1439:	int j = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $689
ARGP4
ADDRLP4 16
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
ASGNI4
line 1440
;1440:	i--;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1441
;1441:	if (i < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1101
line 1442
;1442:		i = uiInfo.teamCount - 1;
ADDRLP4 0
ADDRGP4 uiInfo+75756
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1443
;1443:	}
LABELV $1101
line 1444
;1444:	if (i == j) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $1104
line 1445
;1445:		i--;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1446
;1446:		if (i < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1106
line 1447
;1447:			i = uiInfo.teamCount - 1;
ADDRLP4 0
ADDRGP4 uiInfo+75756
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1448
;1448:		}
LABELV $1106
line 1449
;1449:	}
LABELV $1104
line 1450
;1450:	trap_Cvar_Set("ui_opponentName", uiInfo.teamList[i].teamName);
ADDRGP4 $1090
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1451
;1451:}
LABELV $1100
endproc UI_PriorOpponent 24 8
proc UI_DrawPlayerLogo 44 20
line 1453
;1452:
;1453:static void	UI_DrawPlayerLogo(rectDef_t *rect, vec3_t color) {
line 1454
;1454:	int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $689
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1456
;1455:
;1456:	if (uiInfo.teamList[i].teamIcon == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+28
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1111
line 1457
;1457:		uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+28
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1458
;1458:		uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal", uiInfo.teamList[i].imageName));
ADDRGP4 $757
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+32
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1459
;1459:		uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $762
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+36
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1460
;1460:	}
LABELV $1111
line 1462
;1461:
;1462:	trap_R_SetColor(color);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1463
;1463:	UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+28
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1464
;1464:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1465
;1465:}
LABELV $1110
endproc UI_DrawPlayerLogo 44 20
proc UI_DrawPlayerLogoMetal 44 20
line 1467
;1466:
;1467:static void	UI_DrawPlayerLogoMetal(rectDef_t *rect, vec3_t color) {
line 1468
;1468:	int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $689
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1469
;1469:	if (uiInfo.teamList[i].teamIcon == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+28
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1130
line 1470
;1470:		uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+28
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1471
;1471:		uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal", uiInfo.teamList[i].imageName));
ADDRGP4 $757
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+32
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1472
;1472:		uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $762
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+36
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1473
;1473:	}
LABELV $1130
line 1475
;1474:
;1475:	trap_R_SetColor(color);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1476
;1476:	UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon_Metal);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+32
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1477
;1477:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1478
;1478:}
LABELV $1129
endproc UI_DrawPlayerLogoMetal 44 20
proc UI_DrawPlayerLogoName 44 20
line 1480
;1479:
;1480:static void	UI_DrawPlayerLogoName(rectDef_t *rect, vec3_t color) {
line 1481
;1481:	int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $689
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1482
;1482:	if (uiInfo.teamList[i].teamIcon == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+28
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1149
line 1483
;1483:		uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+28
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1484
;1484:		uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal", uiInfo.teamList[i].imageName));
ADDRGP4 $757
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+32
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1485
;1485:		uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $762
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+36
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1486
;1486:	}
LABELV $1149
line 1488
;1487:
;1488:	trap_R_SetColor(color);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1489
;1489:	UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon_Name);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+36
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1490
;1490:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1491
;1491:}
LABELV $1148
endproc UI_DrawPlayerLogoName 44 20
proc UI_DrawOpponentLogo 44 20
line 1493
;1492:
;1493:static void	UI_DrawOpponentLogo(rectDef_t *rect, vec3_t color) {
line 1494
;1494:	int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1090
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1495
;1495:	if (uiInfo.teamList[i].teamIcon == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+28
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1168
line 1496
;1496:		uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+28
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1497
;1497:		uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal", uiInfo.teamList[i].imageName));
ADDRGP4 $757
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+32
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1498
;1498:		uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $762
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+36
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1499
;1499:	}
LABELV $1168
line 1501
;1500:
;1501:	trap_R_SetColor(color);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1502
;1502:	UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+28
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1503
;1503:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1504
;1504:}
LABELV $1167
endproc UI_DrawOpponentLogo 44 20
proc UI_DrawOpponentLogoMetal 44 20
line 1506
;1505:
;1506:static void	UI_DrawOpponentLogoMetal(rectDef_t *rect, vec3_t color) {
line 1507
;1507:	int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1090
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1508
;1508:	if (uiInfo.teamList[i].teamIcon == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+28
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1187
line 1509
;1509:		uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+28
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1510
;1510:		uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal", uiInfo.teamList[i].imageName));
ADDRGP4 $757
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+32
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1511
;1511:		uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $762
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+36
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1512
;1512:	}
LABELV $1187
line 1514
;1513:
;1514:	trap_R_SetColor(color);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1515
;1515:	UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon_Metal);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+32
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1516
;1516:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1517
;1517:}
LABELV $1186
endproc UI_DrawOpponentLogoMetal 44 20
proc UI_DrawOpponentLogoName 44 20
line 1519
;1518:
;1519:static void	UI_DrawOpponentLogoName(rectDef_t *rect, vec3_t color) {
line 1520
;1520:	int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1090
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1521
;1521:	if (uiInfo.teamList[i].teamIcon == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+28
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1206
line 1522
;1522:		uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+28
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1523
;1523:		uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal", uiInfo.teamList[i].imageName));
ADDRGP4 $757
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+32
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1524
;1524:		uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $762
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+36
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1525
;1525:	}
LABELV $1206
line 1527
;1526:
;1527:	trap_R_SetColor(color);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1528
;1528:	UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon_Name);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+36
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1529
;1529:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1530
;1530:}
LABELV $1205
endproc UI_DrawOpponentLogoName 44 20
proc UI_DrawAllMapsSelection 16 32
line 1532
;1531:
;1532:static void UI_DrawAllMapsSelection(rectDef_t *rect, float scale, vec4_t color, int textStyle, qboolean net) {
line 1533
;1533:	int map = (net) ? ui_currentNetMap.integer : ui_currentMap.integer;
ADDRFP4 16
INDIRI4
CNSTI4 0
EQI4 $1228
ADDRLP4 4
ADDRGP4 ui_currentNetMap+12
INDIRI4
ASGNI4
ADDRGP4 $1229
JUMPV
LABELV $1228
ADDRLP4 4
ADDRGP4 ui_currentMap+12
INDIRI4
ASGNI4
LABELV $1229
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1534
;1534:	if (map >= 0 && map < uiInfo.mapCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1230
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+83224
INDIRI4
GEI4 $1230
line 1535
;1535:		Text_Paint(rect->x, rect->y, scale, color, uiInfo.mapList[map].mapName, 0, 0, textStyle);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1536
;1536:	}
LABELV $1230
line 1537
;1537:}
LABELV $1224
endproc UI_DrawAllMapsSelection 16 32
proc UI_DrawOpponentName 8 32
line 1539
;1538:
;1539:static void UI_DrawOpponentName(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1540
;1540:	Text_Paint(rect->x, rect->y, scale, color, UI_Cvar_VariableString("ui_opponentName"), 0, 0, textStyle);
ADDRGP4 $1090
ARGP4
ADDRLP4 0
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1541
;1541:}
LABELV $1234
endproc UI_DrawOpponentName 8 32
proc UI_OwnerDrawWidth 112 12
line 1544
;1542:
;1543:
;1544:static int UI_OwnerDrawWidth(int ownerDraw, float scale) {
line 1547
;1545:	int i, h, value;
;1546:	const char *text;
;1547:	const char *s = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 1549
;1548:
;1549:	switch (ownerDraw) {
ADDRLP4 20
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 200
LTI4 $1237
ADDRLP4 20
INDIRI4
CNSTI4 247
GTI4 $1307
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1308-800
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1308
address $1238
address $1237
address $1237
address $1239
address $1237
address $1240
address $1237
address $1243
address $1248
address $1253
address $1258
address $1258
address $1258
address $1258
address $1258
address $1268
address $1268
address $1268
address $1268
address $1268
address $1277
address $1237
address $1286
address $1237
address $1237
address $1237
address $1237
address $1237
address $1237
address $1237
address $1237
address $1237
address $1237
address $1237
address $1237
address $1237
address $1237
address $1237
address $1237
address $1237
address $1237
address $1237
address $1237
address $1237
address $1237
address $1237
address $1237
address $1304
code
LABELV $1307
ADDRFP4 0
INDIRI4
CNSTI4 250
EQI4 $1299
ADDRGP4 $1237
JUMPV
LABELV $1238
line 1551
;1550:	case UI_HANDICAP:
;1551:		h = Com_Clamp(5, 100, trap_Cvar_VariableValue("handicap"));
ADDRGP4 $687
ARGP4
ADDRLP4 24
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1084227584
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 28
INDIRF4
CVFI4 4
ASGNI4
line 1552
;1552:		i = 20 - h / 5;
ADDRLP4 4
CNSTI4 20
ADDRLP4 16
INDIRI4
CNSTI4 5
DIVI4
SUBI4
ASGNI4
line 1553
;1553:		s = handicapValues[i];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 handicapValues
ADDP4
INDIRP4
ASGNP4
line 1554
;1554:		break;
ADDRGP4 $1237
JUMPV
LABELV $1239
line 1556
;1555:	case UI_CLANNAME:
;1556:		s = UI_Cvar_VariableString("ui_teamName");
ADDRGP4 $689
ARGP4
ADDRLP4 32
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 1557
;1557:		break;
ADDRGP4 $1237
JUMPV
LABELV $1240
line 1559
;1558:	case UI_GAMETYPE:
;1559:		s = uiInfo.gameTypes[ui_gameType.integer].gameType;
ADDRLP4 0
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580
ADDP4
INDIRP4
ASGNP4
line 1560
;1560:		break;
ADDRGP4 $1237
JUMPV
LABELV $1243
line 1562
;1561:	case UI_SKILL:
;1562:		i = trap_Cvar_VariableValue("g_spSkill");
ADDRGP4 $815
ARGP4
ADDRLP4 36
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 36
INDIRF4
CVFI4 4
ASGNI4
line 1563
;1563:		if (i < 1 || i > numSkillLevels) {
ADDRLP4 40
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 1
LTI4 $1246
ADDRLP4 40
INDIRI4
ADDRGP4 numSkillLevels
INDIRI4
LEI4 $1244
LABELV $1246
line 1564
;1564:			i = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1565
;1565:		}
LABELV $1244
line 1566
;1566:		s = skillLevels[i - 1];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 skillLevels-4
ADDP4
INDIRP4
ASGNP4
line 1567
;1567:		break;
ADDRGP4 $1237
JUMPV
LABELV $1248
line 1569
;1568:	case UI_BLUETEAMNAME:
;1569:		i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_blueTeam"));
ADDRGP4 $821
ARGP4
ADDRLP4 44
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 48
INDIRI4
ASGNI4
line 1570
;1570:		if (i >= 0 && i < uiInfo.teamCount) {
ADDRLP4 52
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
LTI4 $1237
ADDRLP4 52
INDIRI4
ADDRGP4 uiInfo+75756
INDIRI4
GEI4 $1237
line 1571
;1571:			s = va("%s: %s", "Blue", uiInfo.teamList[i].teamName);
ADDRGP4 $829
ARGP4
ADDRGP4 $830
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760
ADDP4
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
ASGNP4
line 1572
;1572:		}
line 1573
;1573:		break;
ADDRGP4 $1237
JUMPV
LABELV $1253
line 1575
;1574:	case UI_REDTEAMNAME:
;1575:		i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_redTeam"));
ADDRGP4 $822
ARGP4
ADDRLP4 56
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 60
INDIRI4
ASGNI4
line 1576
;1576:		if (i >= 0 && i < uiInfo.teamCount) {
ADDRLP4 64
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
LTI4 $1237
ADDRLP4 64
INDIRI4
ADDRGP4 uiInfo+75756
INDIRI4
GEI4 $1237
line 1577
;1577:			s = va("%s: %s", "Red", uiInfo.teamList[i].teamName);
ADDRGP4 $829
ARGP4
ADDRGP4 $831
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760
ADDP4
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 68
INDIRP4
ASGNP4
line 1578
;1578:		}
line 1579
;1579:		break;
ADDRGP4 $1237
JUMPV
LABELV $1258
line 1585
;1580:	case UI_BLUETEAM1:
;1581:	case UI_BLUETEAM2:
;1582:	case UI_BLUETEAM3:
;1583:	case UI_BLUETEAM4:
;1584:	case UI_BLUETEAM5:
;1585:		value = trap_Cvar_VariableValue(va("ui_blueteam%i", ownerDraw - UI_BLUETEAM1 + 1));
ADDRGP4 $837
ARGP4
ADDRFP4 0
INDIRI4
CNSTI4 210
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 68
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 72
INDIRF4
CVFI4 4
ASGNI4
line 1586
;1586:		if (value <= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
GTI4 $1259
line 1587
;1587:			text = "Closed";
ADDRLP4 12
ADDRGP4 $844
ASGNP4
line 1588
;1588:		} else if (value == 1) {
ADDRGP4 $1260
JUMPV
LABELV $1259
ADDRLP4 8
INDIRI4
CNSTI4 1
NEI4 $1261
line 1589
;1589:			text = "Human";
ADDRLP4 12
ADDRGP4 $847
ASGNP4
line 1590
;1590:		} else {
ADDRGP4 $1262
JUMPV
LABELV $1261
line 1591
;1591:			value -= 2;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 1592
;1592:			if (value >= uiInfo.aliasCount) {
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+74984
INDIRI4
LTI4 $1263
line 1593
;1593:				value = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1594
;1594:			}
LABELV $1263
line 1595
;1595:			text = uiInfo.aliasList[value].name;
ADDRLP4 12
ADDRLP4 8
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+74988
ADDP4
INDIRP4
ASGNP4
line 1596
;1596:		}
LABELV $1262
LABELV $1260
line 1597
;1597:		s = va("%i. %s", ownerDraw - UI_BLUETEAM1 + 1, text);
ADDRGP4 $1267
ARGP4
ADDRFP4 0
INDIRI4
CNSTI4 210
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 76
INDIRP4
ASGNP4
line 1598
;1598:		break;
ADDRGP4 $1237
JUMPV
LABELV $1268
line 1604
;1599:	case UI_REDTEAM1:
;1600:	case UI_REDTEAM2:
;1601:	case UI_REDTEAM3:
;1602:	case UI_REDTEAM4:
;1603:	case UI_REDTEAM5:
;1604:		value = trap_Cvar_VariableValue(va("ui_redteam%i", ownerDraw - UI_REDTEAM1 + 1));
ADDRGP4 $838
ARGP4
ADDRFP4 0
INDIRI4
CNSTI4 215
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 80
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 84
INDIRF4
CVFI4 4
ASGNI4
line 1605
;1605:		if (value <= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
GTI4 $1269
line 1606
;1606:			text = "Closed";
ADDRLP4 12
ADDRGP4 $844
ASGNP4
line 1607
;1607:		} else if (value == 1) {
ADDRGP4 $1270
JUMPV
LABELV $1269
ADDRLP4 8
INDIRI4
CNSTI4 1
NEI4 $1271
line 1608
;1608:			text = "Human";
ADDRLP4 12
ADDRGP4 $847
ASGNP4
line 1609
;1609:		} else {
ADDRGP4 $1272
JUMPV
LABELV $1271
line 1610
;1610:			value -= 2;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 1611
;1611:			if (value >= uiInfo.aliasCount) {
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+74984
INDIRI4
LTI4 $1273
line 1612
;1612:				value = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1613
;1613:			}
LABELV $1273
line 1614
;1614:			text = uiInfo.aliasList[value].name;
ADDRLP4 12
ADDRLP4 8
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+74988
ADDP4
INDIRP4
ASGNP4
line 1615
;1615:		}
LABELV $1272
LABELV $1270
line 1616
;1616:		s = va("%i. %s", ownerDraw - UI_REDTEAM1 + 1, text);
ADDRGP4 $1267
ARGP4
ADDRFP4 0
INDIRI4
CNSTI4 215
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 88
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 88
INDIRP4
ASGNP4
line 1617
;1617:		break;
ADDRGP4 $1237
JUMPV
LABELV $1277
line 1619
;1618:	case UI_NETSOURCE:
;1619:		if (ui_netSource.integer < 0 || ui_netSource.integer > uiInfo.numJoinGameTypes) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
LTI4 $1283
ADDRGP4 ui_netSource+12
INDIRI4
ADDRGP4 uiInfo+78708
INDIRI4
LEI4 $1278
LABELV $1283
line 1620
;1620:			ui_netSource.integer = 0;
ADDRGP4 ui_netSource+12
CNSTI4 0
ASGNI4
line 1621
;1621:		}
LABELV $1278
line 1622
;1622:		s = va("Source: %s", netSources[ui_netSource.integer]);
ADDRGP4 $975
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 netSources
ADDP4
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 92
INDIRP4
ASGNP4
line 1623
;1623:		break;
ADDRGP4 $1237
JUMPV
LABELV $1286
line 1625
;1624:	case UI_NETFILTER:
;1625:		if (ui_serverFilterType.integer < 0 || ui_serverFilterType.integer > numServerFilters) {
ADDRGP4 ui_serverFilterType+12
INDIRI4
CNSTI4 0
LTI4 $1291
ADDRGP4 ui_serverFilterType+12
INDIRI4
ADDRGP4 numServerFilters
INDIRI4
LEI4 $1287
LABELV $1291
line 1626
;1626:			ui_serverFilterType.integer = 0;
ADDRGP4 ui_serverFilterType+12
CNSTI4 0
ASGNI4
line 1627
;1627:		}
LABELV $1287
line 1628
;1628:		s = va("Filter: %s", serverFilters[ui_serverFilterType.integer].description);
ADDRGP4 $1009
ARGP4
ADDRGP4 ui_serverFilterType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 serverFilters
ADDP4
INDIRP4
ARGP4
ADDRLP4 96
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 96
INDIRP4
ASGNP4
line 1629
;1629:		break;
ADDRGP4 $1237
JUMPV
line 1631
;1630:	case UI_TIER:
;1631:		break;
line 1633
;1632:	case UI_TIER_MAPNAME:
;1633:		break;
line 1635
;1634:	case UI_TIER_GAMETYPE:
;1635:		break;
line 1637
;1636:	case UI_ALLMAPS_SELECTION:
;1637:		break;
line 1639
;1638:	case UI_OPPONENT_NAME:
;1639:		break;
LABELV $1299
line 1641
;1640:	case UI_KEYBINDSTATUS:
;1641:		if (Display_KeyBindPending()) {
ADDRLP4 100
ADDRGP4 Display_KeyBindPending
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
EQI4 $1300
line 1642
;1642:			s = "Waiting for new key... Press ESCAPE to cancel";
ADDRLP4 0
ADDRGP4 $1302
ASGNP4
line 1643
;1643:		} else {
ADDRGP4 $1237
JUMPV
LABELV $1300
line 1644
;1644:			s = "Press ENTER or CLICK to change, Press BACKSPACE to clear";
ADDRLP4 0
ADDRGP4 $1303
ASGNP4
line 1645
;1645:		}
line 1646
;1646:		break;
ADDRGP4 $1237
JUMPV
LABELV $1304
line 1648
;1647:	case UI_SERVERREFRESHDATE:
;1648:		s = UI_Cvar_VariableString(va("ui_lastServerRefresh_%i", ui_netSource.integer));
ADDRGP4 $1305
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 104
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 108
INDIRP4
ASGNP4
line 1649
;1649:		break;
line 1651
;1650:	default:
;1651:		break;
LABELV $1237
line 1654
;1652:	}
;1653:
;1654:	if (s) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1310
line 1655
;1655:		return Text_Width(s, scale, 0);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 24
ADDRGP4 Text_Width
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
RETI4
ADDRGP4 $1235
JUMPV
LABELV $1310
line 1657
;1656:	}
;1657:	return 0;
CNSTI4 0
RETI4
LABELV $1235
endproc UI_OwnerDrawWidth 112 12
proc UI_DrawBotName 24 32
line 1660
;1658:}
;1659:
;1660:static void UI_DrawBotName(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1661
;1661:	int value = uiInfo.botIndex;
ADDRLP4 0
ADDRGP4 uiInfo+73444
INDIRI4
ASGNI4
line 1662
;1662:	int game = trap_Cvar_VariableValue("g_gametype");
ADDRGP4 $1314
ARGP4
ADDRLP4 12
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 1663
;1663:	const char *text = "";
ADDRLP4 4
ADDRGP4 $110
ASGNP4
line 1664
;1664:	if (game >= GT_TEAM) {
ADDRLP4 8
INDIRI4
CNSTI4 3
LTI4 $1315
line 1665
;1665:		if (value >= uiInfo.characterCount) {
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+73440
INDIRI4
LTI4 $1317
line 1666
;1666:			value = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1667
;1667:		}
LABELV $1317
line 1668
;1668:		text = uiInfo.characterList[value].name;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448
ADDP4
INDIRP4
ASGNP4
line 1669
;1669:	} else {
ADDRGP4 $1316
JUMPV
LABELV $1315
line 1670
;1670:		if (value >= UI_GetNumBots()) {
ADDRLP4 16
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $1321
line 1671
;1671:			value = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1672
;1672:		}
LABELV $1321
line 1673
;1673:		text = UI_GetBotNameByNumber(value);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 UI_GetBotNameByNumber
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 1674
;1674:	}
LABELV $1316
line 1675
;1675:	Text_Paint(rect->x, rect->y, scale, color, text, 0, 0, textStyle);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1676
;1676:}
LABELV $1312
endproc UI_DrawBotName 24 32
proc UI_DrawBotSkill 4 32
line 1678
;1677:
;1678:static void UI_DrawBotSkill(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1679
;1679:	if (uiInfo.skillIndex >= 0 && uiInfo.skillIndex < numSkillLevels) {
ADDRGP4 uiInfo+96672
INDIRI4
CNSTI4 0
LTI4 $1324
ADDRGP4 uiInfo+96672
INDIRI4
ADDRGP4 numSkillLevels
INDIRI4
GEI4 $1324
line 1680
;1680:		Text_Paint(rect->x, rect->y, scale, color, skillLevels[uiInfo.skillIndex], 0, 0, textStyle);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 uiInfo+96672
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 skillLevels
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1681
;1681:	}
LABELV $1324
line 1682
;1682:}
LABELV $1323
endproc UI_DrawBotSkill 4 32
proc UI_DrawRedBlue 8 32
line 1684
;1683:
;1684:static void UI_DrawRedBlue(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1685
;1685:	Text_Paint(rect->x, rect->y, scale, color, (uiInfo.redBlue == 0) ? "Red" : "Blue", 0, 0, textStyle);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 uiInfo+78840
INDIRI4
CNSTI4 0
NEI4 $1332
ADDRLP4 0
ADDRGP4 $831
ASGNP4
ADDRGP4 $1333
JUMPV
LABELV $1332
ADDRLP4 0
ADDRGP4 $830
ASGNP4
LABELV $1333
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1686
;1686:}
LABELV $1329
endproc UI_DrawRedBlue 8 32
proc UI_DrawCrosshair 4 20
line 1688
;1687:
;1688:static void UI_DrawCrosshair(rectDef_t *rect, float scale, vec4_t color) {
line 1689
;1689:	trap_R_SetColor(color);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1690
;1690:	if (uiInfo.currentCrosshair < 0 || uiInfo.currentCrosshair >= NUM_CROSSHAIRS) {
ADDRGP4 uiInfo+119476
INDIRI4
CNSTI4 0
LTI4 $1339
ADDRGP4 uiInfo+119476
INDIRI4
CNSTI4 10
LTI4 $1335
LABELV $1339
line 1691
;1691:		uiInfo.currentCrosshair = 0;
ADDRGP4 uiInfo+119476
CNSTI4 0
ASGNI4
line 1692
;1692:	}
LABELV $1335
line 1693
;1693:	UI_DrawHandlePic(rect->x, rect->y - rect->h, rect->w, rect->h, uiInfo.uiDC.Assets.crosshairShader[uiInfo.currentCrosshair]);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 uiInfo+119476
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+228+61800
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1694
;1694:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1695
;1695:}
LABELV $1334
endproc UI_DrawCrosshair 4 20
proc UI_BuildPlayerList 4176 12
line 1702
;1696:
;1697:/*
;1698:===============
;1699:UI_BuildPlayerList
;1700:===============
;1701:*/
;1702:static void UI_BuildPlayerList() {
line 1707
;1703:	uiClientState_t	cs;
;1704:	int		n, count, team, team2, playerTeamNumber;
;1705:	char	info[MAX_INFO_STRING];
;1706:
;1707:	trap_GetClientState(&cs);
ADDRLP4 1040
ARGP4
ADDRGP4 trap_GetClientState
CALLV
pop
line 1708
;1708:	trap_GetConfigString(CS_PLAYERS + cs.clientNum, info, MAX_INFO_STRING);
ADDRLP4 1040+8
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 1709
;1709:	uiInfo.playerNumber = cs.clientNum;
ADDRGP4 uiInfo+78864
ADDRLP4 1040+8
INDIRI4
ASGNI4
line 1710
;1710:	uiInfo.teamLeader = atoi(Info_ValueForKey(info, "tl"));
ADDRLP4 4
ARGP4
ADDRGP4 $1349
ARGP4
ADDRLP4 4128
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4128
INDIRP4
ARGP4
ADDRLP4 4132
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 uiInfo+78868
ADDRLP4 4132
INDIRI4
ASGNI4
line 1711
;1711:	team = atoi(Info_ValueForKey(info, "t"));
ADDRLP4 4
ARGP4
ADDRGP4 $1350
ARGP4
ADDRLP4 4136
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4136
INDIRP4
ARGP4
ADDRLP4 4140
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1036
ADDRLP4 4140
INDIRI4
ASGNI4
line 1712
;1712:	trap_GetConfigString(CS_SERVERINFO, info, sizeof(info));
CNSTI4 0
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 1713
;1713:	count = atoi(Info_ValueForKey(info, "sv_maxclients"));
ADDRLP4 4
ARGP4
ADDRGP4 $1351
ARGP4
ADDRLP4 4144
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4144
INDIRP4
ARGP4
ADDRLP4 4148
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 4148
INDIRI4
ASGNI4
line 1714
;1714:	uiInfo.playerCount = 0;
ADDRGP4 uiInfo+78844
CNSTI4 0
ASGNI4
line 1715
;1715:	uiInfo.myTeamCount = 0;
ADDRGP4 uiInfo+78848
CNSTI4 0
ASGNI4
line 1716
;1716:	playerTeamNumber = 0;
ADDRLP4 4124
CNSTI4 0
ASGNI4
line 1717
;1717:	for (n = 0; n < count; n++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1357
JUMPV
LABELV $1354
line 1718
;1718:		trap_GetConfigString(CS_PLAYERS + n, info, MAX_INFO_STRING);
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 1720
;1719:
;1720:		if (info[0]) {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1358
line 1721
;1721:			Q_strncpyz(uiInfo.playerNames[uiInfo.playerCount], Info_ValueForKey(info, "n"), MAX_NAME_LENGTH);
ADDRLP4 4
ARGP4
ADDRGP4 $1362
ARGP4
ADDRLP4 4152
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 uiInfo+78844
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+78872
ADDP4
ARGP4
ADDRLP4 4152
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1722
;1722:			Q_CleanStr(uiInfo.playerNames[uiInfo.playerCount]);
ADDRGP4 uiInfo+78844
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+78872
ADDP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1723
;1723:			uiInfo.playerCount++;
ADDRLP4 4156
ADDRGP4 uiInfo+78844
ASGNP4
ADDRLP4 4156
INDIRP4
ADDRLP4 4156
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1724
;1724:			team2 = atoi(Info_ValueForKey(info, "t"));
ADDRLP4 4
ARGP4
ADDRGP4 $1350
ARGP4
ADDRLP4 4160
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4160
INDIRP4
ARGP4
ADDRLP4 4164
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 4164
INDIRI4
ASGNI4
line 1725
;1725:			if (team2 == team) {
ADDRLP4 1032
INDIRI4
ADDRLP4 1036
INDIRI4
NEI4 $1366
line 1726
;1726:				Q_strncpyz(uiInfo.teamNames[uiInfo.myTeamCount], Info_ValueForKey(info, "n"), MAX_NAME_LENGTH);
ADDRLP4 4
ARGP4
ADDRGP4 $1362
ARGP4
ADDRLP4 4168
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 uiInfo+78848
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+80920
ADDP4
ARGP4
ADDRLP4 4168
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1727
;1727:				Q_CleanStr(uiInfo.teamNames[uiInfo.myTeamCount]);
ADDRGP4 uiInfo+78848
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+80920
ADDP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1728
;1728:				uiInfo.teamClientNums[uiInfo.myTeamCount] = n;
ADDRGP4 uiInfo+78848
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+82968
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1729
;1729:				if (uiInfo.playerNumber == n) {
ADDRGP4 uiInfo+78864
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1374
line 1730
;1730:					playerTeamNumber = uiInfo.myTeamCount;
ADDRLP4 4124
ADDRGP4 uiInfo+78848
INDIRI4
ASGNI4
line 1731
;1731:				}
LABELV $1374
line 1732
;1732:				uiInfo.myTeamCount++;
ADDRLP4 4172
ADDRGP4 uiInfo+78848
ASGNP4
ADDRLP4 4172
INDIRP4
ADDRLP4 4172
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1733
;1733:			}
LABELV $1366
line 1734
;1734:		}
LABELV $1358
line 1735
;1735:	}
LABELV $1355
line 1717
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1357
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $1354
line 1737
;1736:
;1737:	if (!uiInfo.teamLeader) {
ADDRGP4 uiInfo+78868
INDIRI4
CNSTI4 0
NEI4 $1379
line 1738
;1738:		trap_Cvar_Set("cg_selectedPlayer", va("%d", playerTeamNumber));
ADDRGP4 $704
ARGP4
ADDRLP4 4124
INDIRI4
ARGI4
ADDRLP4 4152
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1382
ARGP4
ADDRLP4 4152
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1739
;1739:	}
LABELV $1379
line 1741
;1740:
;1741:	n = trap_Cvar_VariableValue("cg_selectedPlayer");
ADDRGP4 $1382
ARGP4
ADDRLP4 4152
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4152
INDIRF4
CVFI4 4
ASGNI4
line 1742
;1742:	if (n < 0 || n > uiInfo.myTeamCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1386
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+78848
INDIRI4
LEI4 $1383
LABELV $1386
line 1743
;1743:		n = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1744
;1744:	}
LABELV $1383
line 1745
;1745:	if (n < uiInfo.myTeamCount) {
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+78848
INDIRI4
GEI4 $1387
line 1746
;1746:		trap_Cvar_Set("cg_selectedPlayerName", uiInfo.teamNames[n]);
ADDRGP4 $1390
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+80920
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1747
;1747:	}
LABELV $1387
line 1748
;1748:}
LABELV $1344
endproc UI_BuildPlayerList 4176 12
proc UI_DrawSelectedPlayer 16 32
line 1751
;1749:
;1750:
;1751:static void UI_DrawSelectedPlayer(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1752
;1752:	if (uiInfo.uiDC.realTime > uiInfo.playerRefresh) {
ADDRGP4 uiInfo+208
INDIRI4
ADDRGP4 uiInfo+78856
INDIRI4
LEI4 $1393
line 1753
;1753:		uiInfo.playerRefresh = uiInfo.uiDC.realTime + 3000;
ADDRGP4 uiInfo+78856
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 1754
;1754:		UI_BuildPlayerList();
ADDRGP4 UI_BuildPlayerList
CALLV
pop
line 1755
;1755:	}
LABELV $1393
line 1756
;1756:	Text_Paint(rect->x, rect->y, scale, color, (uiInfo.teamLeader) ? UI_Cvar_VariableString("cg_selectedPlayerName") : UI_Cvar_VariableString("name"), 0, 0, textStyle);
ADDRGP4 uiInfo+78868
INDIRI4
CNSTI4 0
EQI4 $1402
ADDRGP4 $1390
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRGP4 $1403
JUMPV
LABELV $1402
ADDRGP4 $1400
ARGP4
ADDRLP4 8
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
LABELV $1403
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1757
;1757:}
LABELV $1392
endproc UI_DrawSelectedPlayer 16 32
proc UI_DrawServerRefreshDate 80 32
line 1759
;1758:
;1759:static void UI_DrawServerRefreshDate(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1760
;1760:	if (uiInfo.serverStatus.refreshActive) {
ADDRGP4 uiInfo+99264+2212
INDIRI4
CNSTI4 0
EQI4 $1405
line 1762
;1761:		vec4_t lowLight, newColor;
;1762:		lowLight[0] = 0.8 * color[0];
ADDRLP4 0
ADDRFP4 8
INDIRP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 1763
;1763:		lowLight[1] = 0.8 * color[1];
ADDRLP4 0+4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 1764
;1764:		lowLight[2] = 0.8 * color[2];
ADDRLP4 0+8
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 1765
;1765:		lowLight[3] = 0.8 * color[3];
ADDRLP4 0+12
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 1766
;1766:		LerpColor(color, lowLight, newColor, 0.5 + 0.5 * sin(uiInfo.uiDC.realTime / PULSE_DIVISOR));
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 32
ADDRGP4 sin
CALLF4
ASGNF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 32
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 1767
;1767:		Text_Paint(rect->x, rect->y, scale, newColor, va("Getting info for %d servers (ESC to cancel)", trap_LAN_GetServerCount(ui_netSource.integer)), 0, 0, textStyle);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRGP4 $1413
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 16
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1768
;1768:	} else {
ADDRGP4 $1406
JUMPV
LABELV $1405
line 1770
;1769:		char buff[64];
;1770:		Q_strncpyz(buff, UI_Cvar_VariableString(va("ui_lastServerRefresh_%i", ui_netSource.integer)), 64);
ADDRGP4 $1305
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1771
;1771:		Text_Paint(rect->x, rect->y, scale, color, va("Refresh Time: %s", buff), 0, 0, textStyle);
ADDRGP4 $1416
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 72
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
INDIRF4
ARGF4
ADDRLP4 76
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1772
;1772:	}
LABELV $1406
line 1773
;1773:}
LABELV $1404
endproc UI_DrawServerRefreshDate 80 32
proc UI_DrawServerMOTD 24 32
line 1775
;1774:
;1775:static void UI_DrawServerMOTD(rectDef_t *rect, float scale, vec4_t color) {
line 1776
;1776:	if (uiInfo.serverStatus.motdLen) {
ADDRGP4 uiInfo+99264+10436
INDIRI4
CNSTI4 0
EQI4 $1418
line 1779
;1777:		float maxX;
;1778:
;1779:		if (uiInfo.serverStatus.motdWidth == -1) {
ADDRGP4 uiInfo+99264+10440
INDIRI4
CNSTI4 -1
NEI4 $1422
line 1780
;1780:			uiInfo.serverStatus.motdWidth = 0;
ADDRGP4 uiInfo+99264+10440
CNSTI4 0
ASGNI4
line 1781
;1781:			uiInfo.serverStatus.motdPaintX = rect->x + 1;
ADDRGP4 uiInfo+99264+10444
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1782
;1782:			uiInfo.serverStatus.motdPaintX2 = -1;
ADDRGP4 uiInfo+99264+10448
CNSTI4 -1
ASGNI4
line 1783
;1783:		}
LABELV $1422
line 1785
;1784:
;1785:		if (uiInfo.serverStatus.motdOffset > uiInfo.serverStatus.motdLen) {
ADDRGP4 uiInfo+99264+10452
INDIRI4
ADDRGP4 uiInfo+99264+10436
INDIRI4
LEI4 $1432
line 1786
;1786:			uiInfo.serverStatus.motdOffset = 0;
ADDRGP4 uiInfo+99264+10452
CNSTI4 0
ASGNI4
line 1787
;1787:			uiInfo.serverStatus.motdPaintX = rect->x + 1;
ADDRGP4 uiInfo+99264+10444
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1788
;1788:			uiInfo.serverStatus.motdPaintX2 = -1;
ADDRGP4 uiInfo+99264+10448
CNSTI4 -1
ASGNI4
line 1789
;1789:		}
LABELV $1432
line 1791
;1790:
;1791:		if (uiInfo.uiDC.realTime > uiInfo.serverStatus.motdTime) {
ADDRGP4 uiInfo+208
INDIRI4
ADDRGP4 uiInfo+99264+10456
INDIRI4
LEI4 $1444
line 1792
;1792:			uiInfo.serverStatus.motdTime = uiInfo.uiDC.realTime + 10;
ADDRGP4 uiInfo+99264+10456
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 10
ADDI4
ASGNI4
line 1793
;1793:			if (uiInfo.serverStatus.motdPaintX <= rect->x + 2) {
ADDRGP4 uiInfo+99264+10444
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
GTF4 $1452
line 1794
;1794:				if (uiInfo.serverStatus.motdOffset < uiInfo.serverStatus.motdLen) {
ADDRGP4 uiInfo+99264+10452
INDIRI4
ADDRGP4 uiInfo+99264+10436
INDIRI4
GEI4 $1456
line 1795
;1795:					uiInfo.serverStatus.motdPaintX += Text_Width(&uiInfo.serverStatus.motd[uiInfo.serverStatus.motdOffset], scale, 1) - 1;
ADDRGP4 uiInfo+99264+10452
INDIRI4
ADDRGP4 uiInfo+99264+10460
ADDP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 Text_Width
CALLI4
ASGNI4
ADDRLP4 8
ADDRGP4 uiInfo+99264+10444
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ADDI4
ASGNI4
line 1796
;1796:					uiInfo.serverStatus.motdOffset++;
ADDRLP4 12
ADDRGP4 uiInfo+99264+10452
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1797
;1797:				} else {
ADDRGP4 $1453
JUMPV
LABELV $1456
line 1798
;1798:					uiInfo.serverStatus.motdOffset = 0;
ADDRGP4 uiInfo+99264+10452
CNSTI4 0
ASGNI4
line 1799
;1799:					if (uiInfo.serverStatus.motdPaintX2 >= 0) {
ADDRGP4 uiInfo+99264+10448
INDIRI4
CNSTI4 0
LTI4 $1472
line 1800
;1800:						uiInfo.serverStatus.motdPaintX = uiInfo.serverStatus.motdPaintX2;
ADDRGP4 uiInfo+99264+10444
ADDRGP4 uiInfo+99264+10448
INDIRI4
ASGNI4
line 1801
;1801:					} else {
ADDRGP4 $1473
JUMPV
LABELV $1472
line 1802
;1802:						uiInfo.serverStatus.motdPaintX = rect->x + rect->w - 2;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 uiInfo+99264+10444
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
SUBF4
CVFI4 4
ASGNI4
line 1803
;1803:					}
LABELV $1473
line 1804
;1804:					uiInfo.serverStatus.motdPaintX2 = -1;
ADDRGP4 uiInfo+99264+10448
CNSTI4 -1
ASGNI4
line 1805
;1805:				}
line 1806
;1806:			} else {
ADDRGP4 $1453
JUMPV
LABELV $1452
line 1808
;1807:				//serverStatus.motdPaintX--;
;1808:				uiInfo.serverStatus.motdPaintX -= 2;
ADDRLP4 4
ADDRGP4 uiInfo+99264+10444
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 1809
;1809:				if (uiInfo.serverStatus.motdPaintX2 >= 0) {
ADDRGP4 uiInfo+99264+10448
INDIRI4
CNSTI4 0
LTI4 $1486
line 1811
;1810:					//serverStatus.motdPaintX2--;
;1811:					uiInfo.serverStatus.motdPaintX2 -= 2;
ADDRLP4 8
ADDRGP4 uiInfo+99264+10448
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 1812
;1812:				}
LABELV $1486
line 1813
;1813:			}
LABELV $1453
line 1814
;1814:		}
LABELV $1444
line 1816
;1815:
;1816:		maxX = rect->x + rect->w - 2;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 1817
;1817:		Text_Paint_Limit(&maxX, uiInfo.serverStatus.motdPaintX, rect->y + rect->h - 3, scale, color, &uiInfo.serverStatus.motd[uiInfo.serverStatus.motdOffset], 0, 0);
ADDRLP4 0
ARGP4
ADDRGP4 uiInfo+99264+10444
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1077936128
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 uiInfo+99264+10452
INDIRI4
ADDRGP4 uiInfo+99264+10460
ADDP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint_Limit
CALLV
pop
line 1818
;1818:		if (uiInfo.serverStatus.motdPaintX2 >= 0) {
ADDRGP4 uiInfo+99264+10448
INDIRI4
CNSTI4 0
LTI4 $1498
line 1819
;1819:			float maxX2 = rect->x + rect->w - 2;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 1820
;1820:			Text_Paint_Limit(&maxX2, uiInfo.serverStatus.motdPaintX2, rect->y + rect->h - 3, scale, color, uiInfo.serverStatus.motd, 0, uiInfo.serverStatus.motdOffset);
ADDRLP4 12
ARGP4
ADDRGP4 uiInfo+99264+10448
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1077936128
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 uiInfo+99264+10460
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 uiInfo+99264+10452
INDIRI4
ARGI4
ADDRGP4 Text_Paint_Limit
CALLV
pop
line 1821
;1821:		}
LABELV $1498
line 1822
;1822:		if (uiInfo.serverStatus.motdOffset && maxX > 0) {
ADDRGP4 uiInfo+99264+10452
INDIRI4
CNSTI4 0
EQI4 $1508
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $1508
line 1824
;1823:			// if we have an offset ( we are skipping the first part of the string ) and we fit the string
;1824:			if (uiInfo.serverStatus.motdPaintX2 == -1) {
ADDRGP4 uiInfo+99264+10448
INDIRI4
CNSTI4 -1
NEI4 $1509
line 1825
;1825:				uiInfo.serverStatus.motdPaintX2 = rect->x + rect->w - 2;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 uiInfo+99264+10448
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
SUBF4
CVFI4 4
ASGNI4
line 1826
;1826:			}
line 1827
;1827:		} else {
ADDRGP4 $1509
JUMPV
LABELV $1508
line 1828
;1828:			uiInfo.serverStatus.motdPaintX2 = -1;
ADDRGP4 uiInfo+99264+10448
CNSTI4 -1
ASGNI4
line 1829
;1829:		}
LABELV $1509
line 1831
;1830:
;1831:	}
LABELV $1418
line 1832
;1832:}
LABELV $1417
endproc UI_DrawServerMOTD 24 32
proc UI_DrawKeyBindStatus 8 32
line 1834
;1833:
;1834:static void UI_DrawKeyBindStatus(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1836
;1835:	//	int ofs = 0; TTimo: unused
;1836:	if (Display_KeyBindPending()) {
ADDRLP4 0
ADDRGP4 Display_KeyBindPending
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1521
line 1837
;1837:		Text_Paint(rect->x, rect->y, scale, color, "Waiting for new key... Press ESCAPE to cancel", 0, 0, textStyle);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 $1302
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1838
;1838:	} else {
ADDRGP4 $1522
JUMPV
LABELV $1521
line 1839
;1839:		Text_Paint(rect->x, rect->y, scale, color, "Press ENTER or CLICK to change, Press BACKSPACE to clear", 0, 0, textStyle);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 $1303
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1840
;1840:	}
LABELV $1522
line 1841
;1841:}
LABELV $1520
endproc UI_DrawKeyBindStatus 8 32
proc UI_DrawGLInfo 1336 32
line 1843
;1842:
;1843:static void UI_DrawGLInfo(rectDef_t *rect, float scale, vec4_t color, int textStyle) {
line 1849
;1844:	char *eptr;
;1845:	char buff[1024];
;1846:	const char *lines[64];
;1847:	int y, numLines, i;
;1848:
;1849:	Text_Paint(rect->x + 2, rect->y, scale, color, va("VENDOR: %s", uiInfo.uiDC.glconfig.vendor_string), 0, 30, textStyle);
ADDRGP4 $1524
ARGP4
ADDRGP4 uiInfo+62068+1024
ARGP4
ADDRLP4 1296
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1300
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1300
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
ARGF4
ADDRLP4 1300
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 1296
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 30
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1850
;1850:	Text_Paint(rect->x + 2, rect->y + 15, scale, color, va("VERSION: %s: %s", uiInfo.uiDC.glconfig.version_string, uiInfo.uiDC.glconfig.renderer_string), 0, 30, textStyle);
ADDRGP4 $1527
ARGP4
ADDRGP4 uiInfo+62068+2048
ARGP4
ADDRGP4 uiInfo+62068
ARGP4
ADDRLP4 1304
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1308
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1308
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
ARGF4
ADDRLP4 1308
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1097859072
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 1304
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 30
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1851
;1851:	Text_Paint(rect->x + 2, rect->y + 30, scale, color, va("PIXELFORMAT: color(%d-bits) Z(%d-bits) stencil(%d-bits)", uiInfo.uiDC.glconfig.colorBits, uiInfo.uiDC.glconfig.depthBits, uiInfo.uiDC.glconfig.stencilBits), 0, 30, textStyle);
ADDRGP4 $1531
ARGP4
ADDRGP4 uiInfo+62068+11272
INDIRI4
ARGI4
ADDRGP4 uiInfo+62068+11276
INDIRI4
ARGI4
ADDRGP4 uiInfo+62068+11280
INDIRI4
ARGI4
ADDRLP4 1312
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1316
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1316
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
ARGF4
ADDRLP4 1316
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1106247680
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 1312
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 30
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1857
;1852:
;1853:	// build null terminated extension strings
;1854:  // TTimo: https://zerowing.idsoftware.com/bugzilla/show_bug.cgi?id=399
;1855:  // in TA this was not directly crashing, but displaying a nasty broken shader right in the middle
;1856:  // brought down the string size to 1024, there's not much that can be shown on the screen anyway
;1857:	Q_strncpyz(buff, uiInfo.uiDC.glconfig.extensions_string, 1024);
ADDRLP4 272
ARGP4
ADDRGP4 uiInfo+62068+3072
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1858
;1858:	eptr = buff;
ADDRLP4 0
ADDRLP4 272
ASGNP4
line 1859
;1859:	y = rect->y + 45;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1110704128
ADDF4
CVFI4 4
ASGNI4
line 1860
;1860:	numLines = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $1541
JUMPV
line 1861
;1861:	while (y < rect->y + rect->h && *eptr) {
LABELV $1543
line 1863
;1862:		while (*eptr && *eptr == ' ')
;1863:			*eptr++ = '\0';
ADDRLP4 1320
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 1320
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 1320
INDIRP4
CNSTI1 0
ASGNI1
LABELV $1544
line 1862
ADDRLP4 1324
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1324
INDIRI4
CNSTI4 0
EQI4 $1546
ADDRLP4 1324
INDIRI4
CNSTI4 32
EQI4 $1543
LABELV $1546
line 1866
;1864:
;1865:		// track start of valid string
;1866:		if (*eptr && *eptr != ' ') {
ADDRLP4 1328
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1328
INDIRI4
CNSTI4 0
EQI4 $1550
ADDRLP4 1328
INDIRI4
CNSTI4 32
EQI4 $1550
line 1867
;1867:			lines[numLines++] = eptr;
ADDRLP4 1332
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 12
ADDRLP4 1332
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1332
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 1868
;1868:		}
ADDRGP4 $1550
JUMPV
LABELV $1549
line 1871
;1869:
;1870:		while (*eptr && *eptr != ' ')
;1871:			eptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $1550
line 1870
ADDRLP4 1332
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1332
INDIRI4
CNSTI4 0
EQI4 $1552
ADDRLP4 1332
INDIRI4
CNSTI4 32
NEI4 $1549
LABELV $1552
line 1872
;1872:	}
LABELV $1541
line 1861
ADDRLP4 1320
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 1320
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 1320
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
GEF4 $1553
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1544
LABELV $1553
line 1874
;1873:
;1874:	i = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $1555
JUMPV
LABELV $1554
line 1875
;1875:	while (i < numLines) {
line 1876
;1876:		Text_Paint(rect->x + 2, y, scale, color, lines[i++], 0, 20, textStyle);
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 1324
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 1324
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1324
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 20
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1877
;1877:		if (i < numLines) {
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
GEI4 $1557
line 1878
;1878:			Text_Paint(rect->x + rect->w / 2, y, scale, color, lines[i++], 0, 20, textStyle);
ADDRLP4 1332
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1332
INDIRP4
INDIRF4
ADDRLP4 1332
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1056964608
MULF4
ADDF4
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 1328
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 1328
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1328
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 20
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1879
;1879:		}
LABELV $1557
line 1880
;1880:		y += 10;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 10
ADDI4
ASGNI4
line 1881
;1881:		if (y > rect->y + rect->h - 11) {
ADDRLP4 1328
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 1328
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 1328
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1093664768
SUBF4
LEF4 $1559
line 1882
;1882:			break;
ADDRGP4 $1556
JUMPV
LABELV $1559
line 1884
;1883:		}
;1884:	}
LABELV $1555
line 1875
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $1554
LABELV $1556
line 1887
;1885:
;1886:
;1887:}
LABELV $1523
endproc UI_DrawGLInfo 1336 32
proc UI_OwnerDraw 20 24
line 1891
;1888:
;1889:// FIXME: table drive
;1890://
;1891:static void UI_OwnerDraw(float x, float y, float w, float h, float text_x, float text_y, int ownerDraw, int ownerDrawFlags, int align, float special, float scale, vec4_t color, qhandle_t shader, int textStyle) {
line 1894
;1892:	rectDef_t rect;
;1893:
;1894:	rect.x = x + text_x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
ADDRFP4 16
INDIRF4
ADDF4
ASGNF4
line 1895
;1895:	rect.y = y + text_y;
ADDRLP4 0+4
ADDRFP4 4
INDIRF4
ADDRFP4 20
INDIRF4
ADDF4
ASGNF4
line 1896
;1896:	rect.w = w;
ADDRLP4 0+8
ADDRFP4 8
INDIRF4
ASGNF4
line 1897
;1897:	rect.h = h;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
ASGNF4
line 1899
;1898:
;1899:	switch (ownerDraw) {
ADDRLP4 16
ADDRFP4 24
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 200
LTI4 $1566
ADDRLP4 16
INDIRI4
CNSTI4 256
GTI4 $1566
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1615-800
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1615
address $1567
address $1568
address $1569
address $1570
address $1571
address $1574
address $1577
address $1581
address $1582
address $1583
address $1584
address $1584
address $1584
address $1584
address $1584
address $1585
address $1585
address $1585
address $1585
address $1585
address $1586
address $1587
address $1589
address $1590
address $1591
address $1592
address $1593
address $1594
address $1595
address $1598
address $1596
address $1599
address $1597
address $1600
address $1601
address $1602
address $1603
address $1605
address $1566
address $1606
address $1607
address $1608
address $1609
address $1610
address $1579
address $1575
address $1588
address $1611
address $1612
address $1613
address $1614
address $1572
address $1578
address $1576
address $1573
address $1580
address $1604
code
LABELV $1567
line 1901
;1900:	case UI_HANDICAP:
;1901:		UI_DrawHandicap(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandicap
CALLV
pop
line 1902
;1902:		break;
ADDRGP4 $1566
JUMPV
LABELV $1568
line 1904
;1903:	case UI_EFFECTS:
;1904:		UI_DrawEffects(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawEffects
CALLV
pop
line 1905
;1905:		break;
ADDRGP4 $1566
JUMPV
LABELV $1569
line 1907
;1906:	case UI_PLAYERMODEL:
;1907:		UI_DrawPlayerModel(&rect);
ADDRLP4 0
ARGP4
ADDRGP4 UI_DrawPlayerModel
CALLV
pop
line 1908
;1908:		break;
ADDRGP4 $1566
JUMPV
LABELV $1570
line 1910
;1909:	case UI_CLANNAME:
;1910:		UI_DrawClanName(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawClanName
CALLV
pop
line 1911
;1911:		break;
ADDRGP4 $1566
JUMPV
LABELV $1571
line 1913
;1912:	case UI_CLANLOGO:
;1913:		UI_DrawClanLogo(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawClanLogo
CALLV
pop
line 1914
;1914:		break;
ADDRGP4 $1566
JUMPV
LABELV $1572
line 1916
;1915:	case UI_CLANCINEMATIC:
;1916:		UI_DrawClanCinematic(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawClanCinematic
CALLV
pop
line 1917
;1917:		break;
ADDRGP4 $1566
JUMPV
LABELV $1573
line 1919
;1918:	case UI_PREVIEWCINEMATIC:
;1919:		UI_DrawPreviewCinematic(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawPreviewCinematic
CALLV
pop
line 1920
;1920:		break;
ADDRGP4 $1566
JUMPV
LABELV $1574
line 1922
;1921:	case UI_GAMETYPE:
;1922:		UI_DrawGameType(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawGameType
CALLV
pop
line 1923
;1923:		break;
ADDRGP4 $1566
JUMPV
LABELV $1575
line 1925
;1924:	case UI_NETGAMETYPE:
;1925:		UI_DrawNetGameType(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawNetGameType
CALLV
pop
line 1926
;1926:		break;
ADDRGP4 $1566
JUMPV
LABELV $1576
line 1928
;1927:	case UI_JOINGAMETYPE:
;1928:		UI_DrawJoinGameType(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawJoinGameType
CALLV
pop
line 1929
;1929:		break;
ADDRGP4 $1566
JUMPV
LABELV $1577
line 1931
;1930:	case UI_MAPPREVIEW:
;1931:		UI_DrawMapPreview(&rect, scale, color, qtrue);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 UI_DrawMapPreview
CALLV
pop
line 1932
;1932:		break;
ADDRGP4 $1566
JUMPV
LABELV $1578
line 1934
;1933:	case UI_MAP_TIMETOBEAT:
;1934:		UI_DrawMapTimeToBeat(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawMapTimeToBeat
CALLV
pop
line 1935
;1935:		break;
ADDRGP4 $1566
JUMPV
LABELV $1579
line 1937
;1936:	case UI_MAPCINEMATIC:
;1937:		UI_DrawMapCinematic(&rect, scale, color, qfalse);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawMapCinematic
CALLV
pop
line 1938
;1938:		break;
ADDRGP4 $1566
JUMPV
LABELV $1580
line 1940
;1939:	case UI_STARTMAPCINEMATIC:
;1940:		UI_DrawMapCinematic(&rect, scale, color, qtrue);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 UI_DrawMapCinematic
CALLV
pop
line 1941
;1941:		break;
ADDRGP4 $1566
JUMPV
LABELV $1581
line 1943
;1942:	case UI_SKILL:
;1943:		UI_DrawSkill(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawSkill
CALLV
pop
line 1944
;1944:		break;
ADDRGP4 $1566
JUMPV
LABELV $1582
line 1946
;1945:	case UI_BLUETEAMNAME:
;1946:		UI_DrawTeamName(&rect, scale, color, qtrue, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawTeamName
CALLV
pop
line 1947
;1947:		break;
ADDRGP4 $1566
JUMPV
LABELV $1583
line 1949
;1948:	case UI_REDTEAMNAME:
;1949:		UI_DrawTeamName(&rect, scale, color, qfalse, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawTeamName
CALLV
pop
line 1950
;1950:		break;
ADDRGP4 $1566
JUMPV
LABELV $1584
line 1956
;1951:	case UI_BLUETEAM1:
;1952:	case UI_BLUETEAM2:
;1953:	case UI_BLUETEAM3:
;1954:	case UI_BLUETEAM4:
;1955:	case UI_BLUETEAM5:
;1956:		UI_DrawTeamMember(&rect, scale, color, qtrue, ownerDraw - UI_BLUETEAM1 + 1, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRFP4 24
INDIRI4
CNSTI4 210
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawTeamMember
CALLV
pop
line 1957
;1957:		break;
ADDRGP4 $1566
JUMPV
LABELV $1585
line 1963
;1958:	case UI_REDTEAM1:
;1959:	case UI_REDTEAM2:
;1960:	case UI_REDTEAM3:
;1961:	case UI_REDTEAM4:
;1962:	case UI_REDTEAM5:
;1963:		UI_DrawTeamMember(&rect, scale, color, qfalse, ownerDraw - UI_REDTEAM1 + 1, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRFP4 24
INDIRI4
CNSTI4 215
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawTeamMember
CALLV
pop
line 1964
;1964:		break;
ADDRGP4 $1566
JUMPV
LABELV $1586
line 1966
;1965:	case UI_NETSOURCE:
;1966:		UI_DrawNetSource(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawNetSource
CALLV
pop
line 1967
;1967:		break;
ADDRGP4 $1566
JUMPV
LABELV $1587
line 1969
;1968:	case UI_NETMAPPREVIEW:
;1969:		UI_DrawNetMapPreview(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawNetMapPreview
CALLV
pop
line 1970
;1970:		break;
ADDRGP4 $1566
JUMPV
LABELV $1588
line 1972
;1971:	case UI_NETMAPCINEMATIC:
;1972:		UI_DrawNetMapCinematic(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawNetMapCinematic
CALLV
pop
line 1973
;1973:		break;
ADDRGP4 $1566
JUMPV
LABELV $1589
line 1975
;1974:	case UI_NETFILTER:
;1975:		UI_DrawNetFilter(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawNetFilter
CALLV
pop
line 1976
;1976:		break;
ADDRGP4 $1566
JUMPV
LABELV $1590
line 1978
;1977:	case UI_TIER:
;1978:		UI_DrawTier(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawTier
CALLV
pop
line 1979
;1979:		break;
ADDRGP4 $1566
JUMPV
LABELV $1591
line 1981
;1980:	case UI_OPPONENTMODEL:
;1981:		UI_DrawOpponent(&rect);
ADDRLP4 0
ARGP4
ADDRGP4 UI_DrawOpponent
CALLV
pop
line 1982
;1982:		break;
ADDRGP4 $1566
JUMPV
LABELV $1592
line 1984
;1983:	case UI_TIERMAP1:
;1984:		UI_DrawTierMap(&rect, 0);
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawTierMap
CALLV
pop
line 1985
;1985:		break;
ADDRGP4 $1566
JUMPV
LABELV $1593
line 1987
;1986:	case UI_TIERMAP2:
;1987:		UI_DrawTierMap(&rect, 1);
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 UI_DrawTierMap
CALLV
pop
line 1988
;1988:		break;
ADDRGP4 $1566
JUMPV
LABELV $1594
line 1990
;1989:	case UI_TIERMAP3:
;1990:		UI_DrawTierMap(&rect, 2);
ADDRLP4 0
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 UI_DrawTierMap
CALLV
pop
line 1991
;1991:		break;
ADDRGP4 $1566
JUMPV
LABELV $1595
line 1993
;1992:	case UI_PLAYERLOGO:
;1993:		UI_DrawPlayerLogo(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawPlayerLogo
CALLV
pop
line 1994
;1994:		break;
ADDRGP4 $1566
JUMPV
LABELV $1596
line 1996
;1995:	case UI_PLAYERLOGO_METAL:
;1996:		UI_DrawPlayerLogoMetal(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawPlayerLogoMetal
CALLV
pop
line 1997
;1997:		break;
ADDRGP4 $1566
JUMPV
LABELV $1597
line 1999
;1998:	case UI_PLAYERLOGO_NAME:
;1999:		UI_DrawPlayerLogoName(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawPlayerLogoName
CALLV
pop
line 2000
;2000:		break;
ADDRGP4 $1566
JUMPV
LABELV $1598
line 2002
;2001:	case UI_OPPONENTLOGO:
;2002:		UI_DrawOpponentLogo(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawOpponentLogo
CALLV
pop
line 2003
;2003:		break;
ADDRGP4 $1566
JUMPV
LABELV $1599
line 2005
;2004:	case UI_OPPONENTLOGO_METAL:
;2005:		UI_DrawOpponentLogoMetal(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawOpponentLogoMetal
CALLV
pop
line 2006
;2006:		break;
ADDRGP4 $1566
JUMPV
LABELV $1600
line 2008
;2007:	case UI_OPPONENTLOGO_NAME:
;2008:		UI_DrawOpponentLogoName(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawOpponentLogoName
CALLV
pop
line 2009
;2009:		break;
ADDRGP4 $1566
JUMPV
LABELV $1601
line 2011
;2010:	case UI_TIER_MAPNAME:
;2011:		UI_DrawTierMapName(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawTierMapName
CALLV
pop
line 2012
;2012:		break;
ADDRGP4 $1566
JUMPV
LABELV $1602
line 2014
;2013:	case UI_TIER_GAMETYPE:
;2014:		UI_DrawTierGameType(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawTierGameType
CALLV
pop
line 2015
;2015:		break;
ADDRGP4 $1566
JUMPV
LABELV $1603
line 2017
;2016:	case UI_ALLMAPS_SELECTION:
;2017:		UI_DrawAllMapsSelection(&rect, scale, color, textStyle, qtrue);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 UI_DrawAllMapsSelection
CALLV
pop
line 2018
;2018:		break;
ADDRGP4 $1566
JUMPV
LABELV $1604
line 2020
;2019:	case UI_MAPS_SELECTION:
;2020:		UI_DrawAllMapsSelection(&rect, scale, color, textStyle, qfalse);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawAllMapsSelection
CALLV
pop
line 2021
;2021:		break;
ADDRGP4 $1566
JUMPV
LABELV $1605
line 2023
;2022:	case UI_OPPONENT_NAME:
;2023:		UI_DrawOpponentName(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawOpponentName
CALLV
pop
line 2024
;2024:		break;
ADDRGP4 $1566
JUMPV
LABELV $1606
line 2026
;2025:	case UI_BOTNAME:
;2026:		UI_DrawBotName(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawBotName
CALLV
pop
line 2027
;2027:		break;
ADDRGP4 $1566
JUMPV
LABELV $1607
line 2029
;2028:	case UI_BOTSKILL:
;2029:		UI_DrawBotSkill(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawBotSkill
CALLV
pop
line 2030
;2030:		break;
ADDRGP4 $1566
JUMPV
LABELV $1608
line 2032
;2031:	case UI_REDBLUE:
;2032:		UI_DrawRedBlue(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawRedBlue
CALLV
pop
line 2033
;2033:		break;
ADDRGP4 $1566
JUMPV
LABELV $1609
line 2035
;2034:	case UI_CROSSHAIR:
;2035:		UI_DrawCrosshair(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawCrosshair
CALLV
pop
line 2036
;2036:		break;
ADDRGP4 $1566
JUMPV
LABELV $1610
line 2038
;2037:	case UI_SELECTEDPLAYER:
;2038:		UI_DrawSelectedPlayer(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawSelectedPlayer
CALLV
pop
line 2039
;2039:		break;
ADDRGP4 $1566
JUMPV
LABELV $1611
line 2041
;2040:	case UI_SERVERREFRESHDATE:
;2041:		UI_DrawServerRefreshDate(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawServerRefreshDate
CALLV
pop
line 2042
;2042:		break;
ADDRGP4 $1566
JUMPV
LABELV $1612
line 2044
;2043:	case UI_SERVERMOTD:
;2044:		UI_DrawServerMOTD(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawServerMOTD
CALLV
pop
line 2045
;2045:		break;
ADDRGP4 $1566
JUMPV
LABELV $1613
line 2047
;2046:	case UI_GLINFO:
;2047:		UI_DrawGLInfo(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawGLInfo
CALLV
pop
line 2048
;2048:		break;
ADDRGP4 $1566
JUMPV
LABELV $1614
line 2050
;2049:	case UI_KEYBINDSTATUS:
;2050:		UI_DrawKeyBindStatus(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 UI_DrawKeyBindStatus
CALLV
pop
line 2051
;2051:		break;
line 2053
;2052:	default:
;2053:		break;
LABELV $1566
line 2056
;2054:	}
;2055:
;2056:}
LABELV $1561
endproc UI_OwnerDraw 20 24
proc UI_OwnerDrawVisible 8 8
line 2058
;2057:
;2058:static qboolean UI_OwnerDrawVisible(int flags) {
line 2059
;2059:	qboolean vis = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1619
JUMPV
LABELV $1618
line 2061
;2060:
;2061:	while (flags) {
line 2063
;2062:
;2063:		if (flags & UI_SHOW_FFA) {
ADDRFP4 0
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $1621
line 2064
;2064:			if (trap_Cvar_VariableValue("g_gametype") != GT_FFA) {
ADDRGP4 $1314
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 0
EQF4 $1623
line 2065
;2065:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2066
;2066:			}
LABELV $1623
line 2067
;2067:			flags &= ~UI_SHOW_FFA;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 2068
;2068:		}
LABELV $1621
line 2070
;2069:
;2070:		if (flags & UI_SHOW_NOTFFA) {
ADDRFP4 0
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1625
line 2071
;2071:			if (trap_Cvar_VariableValue("g_gametype") == GT_FFA) {
ADDRGP4 $1314
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $1627
line 2072
;2072:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2073
;2073:			}
LABELV $1627
line 2074
;2074:			flags &= ~UI_SHOW_NOTFFA;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -513
BANDI4
ASGNI4
line 2075
;2075:		}
LABELV $1625
line 2077
;2076:
;2077:		if (flags & UI_SHOW_LEADER) {
ADDRFP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1629
line 2079
;2078:			// these need to show when this client can give orders to a player or a group
;2079:			if (!uiInfo.teamLeader) {
ADDRGP4 uiInfo+78868
INDIRI4
CNSTI4 0
NEI4 $1631
line 2080
;2080:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2081
;2081:			} else {
ADDRGP4 $1632
JUMPV
LABELV $1631
line 2083
;2082:				// if showing yourself
;2083:				if (ui_selectedPlayer.integer < uiInfo.myTeamCount && uiInfo.teamClientNums[ui_selectedPlayer.integer] == uiInfo.playerNumber) {
ADDRGP4 ui_selectedPlayer+12
INDIRI4
ADDRGP4 uiInfo+78848
INDIRI4
GEI4 $1634
ADDRGP4 ui_selectedPlayer+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+82968
ADDP4
INDIRI4
ADDRGP4 uiInfo+78864
INDIRI4
NEI4 $1634
line 2084
;2084:					vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2085
;2085:				}
LABELV $1634
line 2086
;2086:			}
LABELV $1632
line 2087
;2087:			flags &= ~UI_SHOW_LEADER;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 2088
;2088:		}
LABELV $1629
line 2089
;2089:		if (flags & UI_SHOW_NOTLEADER) {
ADDRFP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1641
line 2091
;2090:			// these need to show when this client is assigning their own status or they are NOT the leader
;2091:			if (uiInfo.teamLeader) {
ADDRGP4 uiInfo+78868
INDIRI4
CNSTI4 0
EQI4 $1643
line 2093
;2092:				// if not showing yourself
;2093:				if (!(ui_selectedPlayer.integer < uiInfo.myTeamCount && uiInfo.teamClientNums[ui_selectedPlayer.integer] == uiInfo.playerNumber)) {
ADDRGP4 ui_selectedPlayer+12
INDIRI4
ADDRGP4 uiInfo+78848
INDIRI4
GEI4 $1653
ADDRGP4 ui_selectedPlayer+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+82968
ADDP4
INDIRI4
ADDRGP4 uiInfo+78864
INDIRI4
EQI4 $1646
LABELV $1653
line 2094
;2094:					vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2095
;2095:				}
LABELV $1646
line 2097
;2096:				// these need to show when this client can give orders to a player or a group
;2097:			}
LABELV $1643
line 2098
;2098:			flags &= ~UI_SHOW_NOTLEADER;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 2099
;2099:		}
LABELV $1641
line 2100
;2100:		if (flags & UI_SHOW_FAVORITESERVERS) {
ADDRFP4 0
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1654
line 2102
;2101:			// this assumes you only put this type of display flag on something showing in the proper context
;2102:			if (ui_netSource.integer != AS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 3
EQI4 $1656
line 2103
;2103:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2104
;2104:			}
LABELV $1656
line 2105
;2105:			flags &= ~UI_SHOW_FAVORITESERVERS;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -5
BANDI4
ASGNI4
line 2106
;2106:		}
LABELV $1654
line 2107
;2107:		if (flags & UI_SHOW_NOTFAVORITESERVERS) {
ADDRFP4 0
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1659
line 2109
;2108:			// this assumes you only put this type of display flag on something showing in the proper context
;2109:			if (ui_netSource.integer == AS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 3
NEI4 $1661
line 2110
;2110:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2111
;2111:			}
LABELV $1661
line 2112
;2112:			flags &= ~UI_SHOW_NOTFAVORITESERVERS;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -4097
BANDI4
ASGNI4
line 2113
;2113:		}
LABELV $1659
line 2114
;2114:		if (flags & UI_SHOW_ANYTEAMGAME) {
ADDRFP4 0
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1664
line 2115
;2115:			if (uiInfo.gameTypes[ui_gameType.integer].gtEnum <= GT_TEAM) {
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580+4
ADDP4
INDIRI4
CNSTI4 3
GTI4 $1666
line 2116
;2116:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2117
;2117:			}
LABELV $1666
line 2118
;2118:			flags &= ~UI_SHOW_ANYTEAMGAME;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 2119
;2119:		}
LABELV $1664
line 2120
;2120:		if (flags & UI_SHOW_ANYNONTEAMGAME) {
ADDRFP4 0
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1671
line 2121
;2121:			if (uiInfo.gameTypes[ui_gameType.integer].gtEnum > GT_TEAM) {
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580+4
ADDP4
INDIRI4
CNSTI4 3
LEI4 $1673
line 2122
;2122:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2123
;2123:			}
LABELV $1673
line 2124
;2124:			flags &= ~UI_SHOW_ANYNONTEAMGAME;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 2125
;2125:		}
LABELV $1671
line 2126
;2126:		if (flags & UI_SHOW_NETANYTEAMGAME) {
ADDRFP4 0
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1678
line 2127
;2127:			if (uiInfo.gameTypes[ui_netGameType.integer].gtEnum <= GT_TEAM) {
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580+4
ADDP4
INDIRI4
CNSTI4 3
GTI4 $1680
line 2128
;2128:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2129
;2129:			}
LABELV $1680
line 2130
;2130:			flags &= ~UI_SHOW_NETANYTEAMGAME;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 2131
;2131:		}
LABELV $1678
line 2132
;2132:		if (flags & UI_SHOW_NETANYNONTEAMGAME) {
ADDRFP4 0
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1685
line 2133
;2133:			if (uiInfo.gameTypes[ui_netGameType.integer].gtEnum > GT_TEAM) {
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580+4
ADDP4
INDIRI4
CNSTI4 3
LEI4 $1687
line 2134
;2134:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2135
;2135:			}
LABELV $1687
line 2136
;2136:			flags &= ~UI_SHOW_NETANYNONTEAMGAME;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 2137
;2137:		}
LABELV $1685
line 2138
;2138:		if (flags & UI_SHOW_NEWHIGHSCORE) {
ADDRFP4 0
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1692
line 2139
;2139:			if (uiInfo.newHighScoreTime < uiInfo.uiDC.realTime) {
ADDRGP4 uiInfo+73416
INDIRI4
ADDRGP4 uiInfo+208
INDIRI4
GEI4 $1694
line 2140
;2140:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2141
;2141:			} else {
ADDRGP4 $1695
JUMPV
LABELV $1694
line 2142
;2142:				if (uiInfo.soundHighScore) {
ADDRGP4 uiInfo+73436
INDIRI4
CNSTI4 0
EQI4 $1698
line 2143
;2143:					if (trap_Cvar_VariableValue("sv_killserver") == 0) {
ADDRGP4 $385
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $1701
line 2145
;2144:						// wait on server to go down before playing sound
;2145:						trap_S_StartLocalSound(uiInfo.newHighScoreSound, CHAN_ANNOUNCER);
ADDRGP4 uiInfo+119484
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2146
;2146:						uiInfo.soundHighScore = qfalse;
ADDRGP4 uiInfo+73436
CNSTI4 0
ASGNI4
line 2147
;2147:					}
LABELV $1701
line 2148
;2148:				}
LABELV $1698
line 2149
;2149:			}
LABELV $1695
line 2150
;2150:			flags &= ~UI_SHOW_NEWHIGHSCORE;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -33
BANDI4
ASGNI4
line 2151
;2151:		}
LABELV $1692
line 2152
;2152:		if (flags & UI_SHOW_NEWBESTTIME) {
ADDRFP4 0
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $1705
line 2153
;2153:			if (uiInfo.newBestTime < uiInfo.uiDC.realTime) {
ADDRGP4 uiInfo+73420
INDIRI4
ADDRGP4 uiInfo+208
INDIRI4
GEI4 $1707
line 2154
;2154:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2155
;2155:			}
LABELV $1707
line 2156
;2156:			flags &= ~UI_SHOW_NEWBESTTIME;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 2157
;2157:		}
LABELV $1705
line 2158
;2158:		if (flags & UI_SHOW_DEMOAVAILABLE) {
ADDRFP4 0
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $1711
line 2159
;2159:			if (!uiInfo.demoAvailable) {
ADDRGP4 uiInfo+73432
INDIRI4
CNSTI4 0
NEI4 $1713
line 2160
;2160:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2161
;2161:			}
LABELV $1713
line 2162
;2162:			flags &= ~UI_SHOW_DEMOAVAILABLE;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -65
BANDI4
ASGNI4
line 2163
;2163:		} else {
ADDRGP4 $1712
JUMPV
LABELV $1711
line 2164
;2164:			flags = 0;
ADDRFP4 0
CNSTI4 0
ASGNI4
line 2165
;2165:		}
LABELV $1712
line 2166
;2166:	}
LABELV $1619
line 2061
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $1618
line 2167
;2167:	return vis;
ADDRLP4 0
INDIRI4
RETI4
LABELV $1617
endproc UI_OwnerDrawVisible 8 8
proc UI_Handicap_HandleKey 20 12
line 2170
;2168:}
;2169:
;2170:static qboolean UI_Handicap_HandleKey(int flags, float *special, int key) {
line 2171
;2171:	if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1721
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1721
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1721
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1717
LABELV $1721
line 2173
;2172:		int h;
;2173:		h = Com_Clamp(5, 100, trap_Cvar_VariableValue("handicap"));
ADDRGP4 $687
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1084227584
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 2174
;2174:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1722
line 2175
;2175:			h -= 5;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 5
SUBI4
ASGNI4
line 2176
;2176:		} else {
ADDRGP4 $1723
JUMPV
LABELV $1722
line 2177
;2177:			h += 5;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 5
ADDI4
ASGNI4
line 2178
;2178:		}
LABELV $1723
line 2179
;2179:		if (h > 100) {
ADDRLP4 4
INDIRI4
CNSTI4 100
LEI4 $1724
line 2180
;2180:			h = 5;
ADDRLP4 4
CNSTI4 5
ASGNI4
line 2181
;2181:		} else if (h < 0) {
ADDRGP4 $1725
JUMPV
LABELV $1724
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1726
line 2182
;2182:			h = 100;
ADDRLP4 4
CNSTI4 100
ASGNI4
line 2183
;2183:		}
LABELV $1726
LABELV $1725
line 2184
;2184:		trap_Cvar_Set("handicap", va("%i", h));
ADDRGP4 $1728
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $687
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2185
;2185:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1716
JUMPV
LABELV $1717
line 2187
;2186:	}
;2187:	return qfalse;
CNSTI4 0
RETI4
LABELV $1716
endproc UI_Handicap_HandleKey 20 12
proc UI_Effects_HandleKey 8 8
line 2190
;2188:}
;2189:
;2190:static qboolean UI_Effects_HandleKey(int flags, float *special, int key) {
line 2191
;2191:	if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1734
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1734
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1734
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1730
LABELV $1734
line 2193
;2192:
;2193:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1735
line 2194
;2194:			uiInfo.effectsColor--;
ADDRLP4 4
ADDRGP4 uiInfo+136904
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2195
;2195:		} else {
ADDRGP4 $1736
JUMPV
LABELV $1735
line 2196
;2196:			uiInfo.effectsColor++;
ADDRLP4 4
ADDRGP4 uiInfo+136904
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2197
;2197:		}
LABELV $1736
line 2199
;2198:
;2199:		if (uiInfo.effectsColor > 6) {
ADDRGP4 uiInfo+136904
INDIRI4
CNSTI4 6
LEI4 $1739
line 2200
;2200:			uiInfo.effectsColor = 0;
ADDRGP4 uiInfo+136904
CNSTI4 0
ASGNI4
line 2201
;2201:		} else if (uiInfo.effectsColor < 0) {
ADDRGP4 $1740
JUMPV
LABELV $1739
ADDRGP4 uiInfo+136904
INDIRI4
CNSTI4 0
GEI4 $1743
line 2202
;2202:			uiInfo.effectsColor = 6;
ADDRGP4 uiInfo+136904
CNSTI4 6
ASGNI4
line 2203
;2203:		}
LABELV $1743
LABELV $1740
line 2205
;2204:
;2205:		trap_Cvar_SetValue("color1", uitogamecode[uiInfo.effectsColor]);
ADDRGP4 $1747
ARGP4
ADDRGP4 uiInfo+136904
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uitogamecode
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2206
;2206:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1729
JUMPV
LABELV $1730
line 2208
;2207:	}
;2208:	return qfalse;
CNSTI4 0
RETI4
LABELV $1729
endproc UI_Effects_HandleKey 8 8
proc UI_ClanName_HandleKey 16 8
line 2211
;2209:}
;2210:
;2211:static qboolean UI_ClanName_HandleKey(int flags, float *special, int key) {
line 2212
;2212:	if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1754
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1754
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1754
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1750
LABELV $1754
line 2214
;2213:		int i;
;2214:		i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $689
ARGP4
ADDRLP4 8
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 2215
;2215:		if (uiInfo.teamList[i].cinematic >= 0) {
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+40
ADDP4
INDIRI4
CNSTI4 0
LTI4 $1755
line 2216
;2216:			trap_CIN_StopCinematic(uiInfo.teamList[i].cinematic);
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+40
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 2217
;2217:			uiInfo.teamList[i].cinematic = -1;
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+40
ADDP4
CNSTI4 -1
ASGNI4
line 2218
;2218:		}
LABELV $1755
line 2219
;2219:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1763
line 2220
;2220:			i--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2221
;2221:		} else {
ADDRGP4 $1764
JUMPV
LABELV $1763
line 2222
;2222:			i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2223
;2223:		}
LABELV $1764
line 2224
;2224:		if (i >= uiInfo.teamCount) {
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+75756
INDIRI4
LTI4 $1765
line 2225
;2225:			i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2226
;2226:		} else if (i < 0) {
ADDRGP4 $1766
JUMPV
LABELV $1765
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1768
line 2227
;2227:			i = uiInfo.teamCount - 1;
ADDRLP4 4
ADDRGP4 uiInfo+75756
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2228
;2228:		}
LABELV $1768
LABELV $1766
line 2229
;2229:		trap_Cvar_Set("ui_teamName", uiInfo.teamList[i].teamName);
ADDRGP4 $689
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2230
;2230:		UI_HeadCountByTeam();
ADDRGP4 UI_HeadCountByTeam
CALLI4
pop
line 2231
;2231:		UI_FeederSelection(FEEDER_HEADS, 0);
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 UI_FeederSelection
CALLV
pop
line 2232
;2232:		updateModel = qtrue;
ADDRGP4 updateModel
CNSTI4 1
ASGNI4
line 2233
;2233:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1749
JUMPV
LABELV $1750
line 2235
;2234:	}
;2235:	return qfalse;
CNSTI4 0
RETI4
LABELV $1749
endproc UI_ClanName_HandleKey 16 8
proc UI_GameType_HandleKey 20 16
line 2238
;2236:}
;2237:
;2238:static qboolean UI_GameType_HandleKey(int flags, float *special, int key, qboolean resetMap) {
line 2239
;2239:	if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1777
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1777
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1777
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1773
LABELV $1777
line 2240
;2240:		int oldCount = UI_MapCountByGameType(qtrue);
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 UI_MapCountByGameType
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 2243
;2241:
;2242:		// hard coded mess here
;2243:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1778
line 2244
;2244:			ui_gameType.integer--;
ADDRLP4 12
ADDRGP4 ui_gameType+12
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2245
;2245:			if (ui_gameType.integer == 2) {
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 2
NEI4 $1781
line 2246
;2246:				ui_gameType.integer = 1;
ADDRGP4 ui_gameType+12
CNSTI4 1
ASGNI4
line 2247
;2247:			} else if (ui_gameType.integer < 2) {
ADDRGP4 $1779
JUMPV
LABELV $1781
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 2
GEI4 $1779
line 2248
;2248:				ui_gameType.integer = uiInfo.numGameTypes - 1;
ADDRGP4 ui_gameType+12
ADDRGP4 uiInfo+78576
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2249
;2249:			}
line 2250
;2250:		} else {
ADDRGP4 $1779
JUMPV
LABELV $1778
line 2251
;2251:			ui_gameType.integer++;
ADDRLP4 12
ADDRGP4 ui_gameType+12
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2252
;2252:			if (ui_gameType.integer >= uiInfo.numGameTypes) {
ADDRGP4 ui_gameType+12
INDIRI4
ADDRGP4 uiInfo+78576
INDIRI4
LTI4 $1791
line 2253
;2253:				ui_gameType.integer = 1;
ADDRGP4 ui_gameType+12
CNSTI4 1
ASGNI4
line 2254
;2254:			} else if (ui_gameType.integer == 2) {
ADDRGP4 $1792
JUMPV
LABELV $1791
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 2
NEI4 $1796
line 2255
;2255:				ui_gameType.integer = 3;
ADDRGP4 ui_gameType+12
CNSTI4 3
ASGNI4
line 2256
;2256:			}
LABELV $1796
LABELV $1792
line 2257
;2257:		}
LABELV $1779
line 2259
;2258:
;2259:		if (uiInfo.gameTypes[ui_gameType.integer].gtEnum == GT_TOURNAMENT) {
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580+4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1800
line 2260
;2260:			trap_Cvar_Set("ui_Q3Model", "1");
ADDRGP4 $952
ARGP4
ADDRGP4 $386
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2261
;2261:		} else {
ADDRGP4 $1801
JUMPV
LABELV $1800
line 2262
;2262:			trap_Cvar_Set("ui_Q3Model", "0");
ADDRGP4 $952
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2263
;2263:		}
LABELV $1801
line 2265
;2264:
;2265:		trap_Cvar_Set("ui_gameType", va("%d", ui_gameType.integer));
ADDRGP4 $704
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1805
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2266
;2266:		UI_SetCapFragLimits(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_SetCapFragLimits
CALLV
pop
line 2267
;2267:		UI_LoadBestScores(uiInfo.mapList[ui_currentMap.integer].mapLoadName, uiInfo.gameTypes[ui_gameType.integer].gtEnum);
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580+4
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_LoadBestScores
CALLV
pop
line 2268
;2268:		if (resetMap && oldCount != UI_MapCountByGameType(qtrue)) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $1813
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 UI_MapCountByGameType
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $1813
line 2269
;2269:			trap_Cvar_Set("ui_currentMap", "0");
ADDRGP4 $879
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2270
;2270:			Menu_SetFeederSelection(NULL, FEEDER_MAPS, 0, NULL);
CNSTP4 0
ARGP4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 2271
;2271:		}
LABELV $1813
line 2272
;2272:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1772
JUMPV
LABELV $1773
line 2274
;2273:	}
;2274:	return qfalse;
CNSTI4 0
RETI4
LABELV $1772
endproc UI_GameType_HandleKey 20 16
proc UI_NetGameType_HandleKey 12 16
line 2277
;2275:}
;2276:
;2277:static qboolean UI_NetGameType_HandleKey(int flags, float *special, int key) {
line 2278
;2278:	if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1820
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1820
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1820
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1816
LABELV $1820
line 2280
;2279:
;2280:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1821
line 2281
;2281:			ui_netGameType.integer--;
ADDRLP4 4
ADDRGP4 ui_netGameType+12
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2282
;2282:		} else {
ADDRGP4 $1822
JUMPV
LABELV $1821
line 2283
;2283:			ui_netGameType.integer++;
ADDRLP4 4
ADDRGP4 ui_netGameType+12
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2284
;2284:		}
LABELV $1822
line 2286
;2285:
;2286:		if (ui_netGameType.integer < 0) {
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 0
GEI4 $1825
line 2287
;2287:			ui_netGameType.integer = uiInfo.numGameTypes - 1;
ADDRGP4 ui_netGameType+12
ADDRGP4 uiInfo+78576
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2288
;2288:		} else if (ui_netGameType.integer >= uiInfo.numGameTypes) {
ADDRGP4 $1826
JUMPV
LABELV $1825
ADDRGP4 ui_netGameType+12
INDIRI4
ADDRGP4 uiInfo+78576
INDIRI4
LTI4 $1830
line 2289
;2289:			ui_netGameType.integer = 0;
ADDRGP4 ui_netGameType+12
CNSTI4 0
ASGNI4
line 2290
;2290:		}
LABELV $1830
LABELV $1826
line 2292
;2291:
;2292:		trap_Cvar_Set("ui_netGameType", va("%d", ui_netGameType.integer));
ADDRGP4 $704
ARGP4
ADDRGP4 ui_netGameType+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $718
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2293
;2293:		trap_Cvar_Set("ui_actualnetGameType", va("%d", uiInfo.gameTypes[ui_netGameType.integer].gtEnum));
ADDRGP4 $704
ARGP4
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580+4
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1836
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2294
;2294:		trap_Cvar_Set("ui_currentNetMap", "0");
ADDRGP4 $877
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2295
;2295:		UI_MapCountByGameType(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_MapCountByGameType
CALLI4
pop
line 2296
;2296:		Menu_SetFeederSelection(NULL, FEEDER_ALLMAPS, 0, NULL);
CNSTP4 0
ARGP4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 2297
;2297:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1815
JUMPV
LABELV $1816
line 2299
;2298:	}
;2299:	return qfalse;
CNSTI4 0
RETI4
LABELV $1815
endproc UI_NetGameType_HandleKey 12 16
proc UI_JoinGameType_HandleKey 8 8
line 2302
;2300:}
;2301:
;2302:static qboolean UI_JoinGameType_HandleKey(int flags, float *special, int key) {
line 2303
;2303:	if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1845
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1845
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1845
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1841
LABELV $1845
line 2305
;2304:
;2305:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1846
line 2306
;2306:			ui_joinGameType.integer--;
ADDRLP4 4
ADDRGP4 ui_joinGameType+12
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2307
;2307:		} else {
ADDRGP4 $1847
JUMPV
LABELV $1846
line 2308
;2308:			ui_joinGameType.integer++;
ADDRLP4 4
ADDRGP4 ui_joinGameType+12
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2309
;2309:		}
LABELV $1847
line 2311
;2310:
;2311:		if (ui_joinGameType.integer < 0) {
ADDRGP4 ui_joinGameType+12
INDIRI4
CNSTI4 0
GEI4 $1850
line 2312
;2312:			ui_joinGameType.integer = uiInfo.numJoinGameTypes - 1;
ADDRGP4 ui_joinGameType+12
ADDRGP4 uiInfo+78708
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2313
;2313:		} else if (ui_joinGameType.integer >= uiInfo.numJoinGameTypes) {
ADDRGP4 $1851
JUMPV
LABELV $1850
ADDRGP4 ui_joinGameType+12
INDIRI4
ADDRGP4 uiInfo+78708
INDIRI4
LTI4 $1855
line 2314
;2314:			ui_joinGameType.integer = 0;
ADDRGP4 ui_joinGameType+12
CNSTI4 0
ASGNI4
line 2315
;2315:		}
LABELV $1855
LABELV $1851
line 2317
;2316:
;2317:		trap_Cvar_Set("ui_joinGameType", va("%d", ui_joinGameType.integer));
ADDRGP4 $704
ARGP4
ADDRGP4 ui_joinGameType+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $729
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2318
;2318:		UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 2319
;2319:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1840
JUMPV
LABELV $1841
line 2321
;2320:	}
;2321:	return qfalse;
CNSTI4 0
RETI4
LABELV $1840
endproc UI_JoinGameType_HandleKey 8 8
proc UI_Skill_HandleKey 16 8
line 2326
;2322:}
;2323:
;2324:
;2325:
;2326:static qboolean UI_Skill_HandleKey(int flags, float *special, int key) {
line 2327
;2327:	if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1866
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1866
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1866
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1862
LABELV $1866
line 2328
;2328:		int i = trap_Cvar_VariableValue("g_spSkill");
ADDRGP4 $815
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 8
INDIRF4
CVFI4 4
ASGNI4
line 2330
;2329:
;2330:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1867
line 2331
;2331:			i--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2332
;2332:		} else {
ADDRGP4 $1868
JUMPV
LABELV $1867
line 2333
;2333:			i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2334
;2334:		}
LABELV $1868
line 2336
;2335:
;2336:		if (i < 1) {
ADDRLP4 4
INDIRI4
CNSTI4 1
GEI4 $1869
line 2337
;2337:			i = numSkillLevels;
ADDRLP4 4
ADDRGP4 numSkillLevels
INDIRI4
ASGNI4
line 2338
;2338:		} else if (i > numSkillLevels) {
ADDRGP4 $1870
JUMPV
LABELV $1869
ADDRLP4 4
INDIRI4
ADDRGP4 numSkillLevels
INDIRI4
LEI4 $1871
line 2339
;2339:			i = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 2340
;2340:		}
LABELV $1871
LABELV $1870
line 2342
;2341:
;2342:		trap_Cvar_Set("g_spSkill", va("%i", i));
ADDRGP4 $1728
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $815
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2343
;2343:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1861
JUMPV
LABELV $1862
line 2345
;2344:	}
;2345:	return qfalse;
CNSTI4 0
RETI4
LABELV $1861
endproc UI_Skill_HandleKey 16 8
proc UI_TeamName_HandleKey 24 8
line 2348
;2346:}
;2347:
;2348:static qboolean UI_TeamName_HandleKey(int flags, float *special, int key, qboolean blue) {
line 2349
;2349:	if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1878
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1878
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1878
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1874
LABELV $1878
line 2351
;2350:		int i;
;2351:		i = UI_TeamIndexFromName(UI_Cvar_VariableString((blue) ? "ui_blueTeam" : "ui_redTeam"));
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $1880
ADDRLP4 8
ADDRGP4 $821
ASGNP4
ADDRGP4 $1881
JUMPV
LABELV $1880
ADDRLP4 8
ADDRGP4 $822
ASGNP4
LABELV $1881
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 2353
;2352:
;2353:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1882
line 2354
;2354:			i--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2355
;2355:		} else {
ADDRGP4 $1883
JUMPV
LABELV $1882
line 2356
;2356:			i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2357
;2357:		}
LABELV $1883
line 2359
;2358:
;2359:		if (i >= uiInfo.teamCount) {
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+75756
INDIRI4
LTI4 $1884
line 2360
;2360:			i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2361
;2361:		} else if (i < 0) {
ADDRGP4 $1885
JUMPV
LABELV $1884
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1887
line 2362
;2362:			i = uiInfo.teamCount - 1;
ADDRLP4 4
ADDRGP4 uiInfo+75756
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2363
;2363:		}
LABELV $1887
LABELV $1885
line 2365
;2364:
;2365:		trap_Cvar_Set((blue) ? "ui_blueTeam" : "ui_redTeam", uiInfo.teamList[i].teamName);
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $1892
ADDRLP4 20
ADDRGP4 $821
ASGNP4
ADDRGP4 $1893
JUMPV
LABELV $1892
ADDRLP4 20
ADDRGP4 $822
ASGNP4
LABELV $1893
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2367
;2366:
;2367:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1873
JUMPV
LABELV $1874
line 2369
;2368:	}
;2369:	return qfalse;
CNSTI4 0
RETI4
LABELV $1873
endproc UI_TeamName_HandleKey 24 8
proc UI_TeamMember_HandleKey 32 8
line 2372
;2370:}
;2371:
;2372:static qboolean UI_TeamMember_HandleKey(int flags, float *special, int key, qboolean blue, int num) {
line 2373
;2373:	if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1899
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1899
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1899
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1895
LABELV $1899
line 2377
;2374:		// 0 - None
;2375:		// 1 - Human
;2376:		// 2..NumCharacters - Bot
;2377:		char *cvar = va(blue ? "ui_blueteam%i" : "ui_redteam%i", num);
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $1901
ADDRLP4 12
ADDRGP4 $837
ASGNP4
ADDRGP4 $1902
JUMPV
LABELV $1901
ADDRLP4 12
ADDRGP4 $838
ASGNP4
LABELV $1902
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 2378
;2378:		int value = trap_Cvar_VariableValue(cvar);
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 20
INDIRF4
CVFI4 4
ASGNI4
line 2380
;2379:
;2380:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1903
line 2381
;2381:			value--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2382
;2382:		} else {
ADDRGP4 $1904
JUMPV
LABELV $1903
line 2383
;2383:			value++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2384
;2384:		}
LABELV $1904
line 2386
;2385:
;2386:		if (ui_actualNetGameType.integer >= GT_TEAM) {
ADDRGP4 ui_actualNetGameType+12
INDIRI4
CNSTI4 3
LTI4 $1905
line 2387
;2387:			if (value >= uiInfo.characterCount + 2) {
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+73440
INDIRI4
CNSTI4 2
ADDI4
LTI4 $1908
line 2388
;2388:				value = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2389
;2389:			} else if (value < 0) {
ADDRGP4 $1906
JUMPV
LABELV $1908
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1906
line 2390
;2390:				value = uiInfo.characterCount + 2 - 1;
ADDRLP4 4
ADDRGP4 uiInfo+73440
INDIRI4
CNSTI4 2
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 2391
;2391:			}
line 2392
;2392:		} else {
ADDRGP4 $1906
JUMPV
LABELV $1905
line 2393
;2393:			if (value >= UI_GetNumBots() + 2) {
ADDRLP4 24
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 24
INDIRI4
CNSTI4 2
ADDI4
LTI4 $1914
line 2394
;2394:				value = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2395
;2395:			} else if (value < 0) {
ADDRGP4 $1915
JUMPV
LABELV $1914
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1916
line 2396
;2396:				value = UI_GetNumBots() + 2 - 1;
ADDRLP4 28
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 28
INDIRI4
CNSTI4 2
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 2397
;2397:			}
LABELV $1916
LABELV $1915
line 2398
;2398:		}
LABELV $1906
line 2400
;2399:
;2400:		trap_Cvar_Set(cvar, va("%i", value));
ADDRGP4 $1728
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2401
;2401:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1894
JUMPV
LABELV $1895
line 2403
;2402:	}
;2403:	return qfalse;
CNSTI4 0
RETI4
LABELV $1894
endproc UI_TeamMember_HandleKey 32 8
proc UI_NetSource_HandleKey 12 8
line 2406
;2404:}
;2405:
;2406:static qboolean UI_NetSource_HandleKey(int flags, float *special, int key) {
line 2407
;2407:	if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1923
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1923
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1923
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1919
LABELV $1923
line 2409
;2408:
;2409:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1924
line 2410
;2410:			ui_netSource.integer--;
ADDRLP4 4
ADDRGP4 ui_netSource+12
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2411
;2411:			if (ui_netSource.integer == AS_MPLAYER)
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 1
NEI4 $1925
line 2412
;2412:				ui_netSource.integer--;
ADDRLP4 8
ADDRGP4 ui_netSource+12
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2413
;2413:		} else {
ADDRGP4 $1925
JUMPV
LABELV $1924
line 2414
;2414:			ui_netSource.integer++;
ADDRLP4 4
ADDRGP4 ui_netSource+12
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2415
;2415:			if (ui_netSource.integer == AS_MPLAYER)
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 1
NEI4 $1932
line 2416
;2416:				ui_netSource.integer++;
ADDRLP4 8
ADDRGP4 ui_netSource+12
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1932
line 2417
;2417:		}
LABELV $1925
line 2419
;2418:
;2419:		if (ui_netSource.integer >= numNetSources) {
ADDRGP4 ui_netSource+12
INDIRI4
ADDRGP4 numNetSources
INDIRI4
LTI4 $1936
line 2420
;2420:			ui_netSource.integer = 0;
ADDRGP4 ui_netSource+12
CNSTI4 0
ASGNI4
line 2421
;2421:		} else if (ui_netSource.integer < 0) {
ADDRGP4 $1937
JUMPV
LABELV $1936
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
GEI4 $1940
line 2422
;2422:			ui_netSource.integer = numNetSources - 1;
ADDRGP4 ui_netSource+12
ADDRGP4 numNetSources
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2423
;2423:		}
LABELV $1940
LABELV $1937
line 2425
;2424:
;2425:		UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 2426
;2426:		if (ui_netSource.integer != AS_GLOBAL) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 2
EQI4 $1944
line 2427
;2427:			UI_StartServerRefresh(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_StartServerRefresh
CALLV
pop
line 2428
;2428:		}
LABELV $1944
line 2429
;2429:		trap_Cvar_Set("ui_netSource", va("%d", ui_netSource.integer));
ADDRGP4 $704
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1947
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2430
;2430:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1918
JUMPV
LABELV $1919
line 2432
;2431:	}
;2432:	return qfalse;
CNSTI4 0
RETI4
LABELV $1918
endproc UI_NetSource_HandleKey 12 8
proc UI_NetFilter_HandleKey 8 4
line 2435
;2433:}
;2434:
;2435:static qboolean UI_NetFilter_HandleKey(int flags, float *special, int key) {
line 2436
;2436:	if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1954
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1954
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1954
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1950
LABELV $1954
line 2438
;2437:
;2438:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1955
line 2439
;2439:			ui_serverFilterType.integer--;
ADDRLP4 4
ADDRGP4 ui_serverFilterType+12
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2440
;2440:		} else {
ADDRGP4 $1956
JUMPV
LABELV $1955
line 2441
;2441:			ui_serverFilterType.integer++;
ADDRLP4 4
ADDRGP4 ui_serverFilterType+12
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2442
;2442:		}
LABELV $1956
line 2444
;2443:
;2444:		if (ui_serverFilterType.integer >= numServerFilters) {
ADDRGP4 ui_serverFilterType+12
INDIRI4
ADDRGP4 numServerFilters
INDIRI4
LTI4 $1959
line 2445
;2445:			ui_serverFilterType.integer = 0;
ADDRGP4 ui_serverFilterType+12
CNSTI4 0
ASGNI4
line 2446
;2446:		} else if (ui_serverFilterType.integer < 0) {
ADDRGP4 $1960
JUMPV
LABELV $1959
ADDRGP4 ui_serverFilterType+12
INDIRI4
CNSTI4 0
GEI4 $1963
line 2447
;2447:			ui_serverFilterType.integer = numServerFilters - 1;
ADDRGP4 ui_serverFilterType+12
ADDRGP4 numServerFilters
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2448
;2448:		}
LABELV $1963
LABELV $1960
line 2449
;2449:		UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 2450
;2450:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1949
JUMPV
LABELV $1950
line 2452
;2451:	}
;2452:	return qfalse;
CNSTI4 0
RETI4
LABELV $1949
endproc UI_NetFilter_HandleKey 8 4
proc UI_OpponentName_HandleKey 4 0
line 2455
;2453:}
;2454:
;2455:static qboolean UI_OpponentName_HandleKey(int flags, float *special, int key) {
line 2456
;2456:	if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1972
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1972
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1972
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1968
LABELV $1972
line 2457
;2457:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1973
line 2458
;2458:			UI_PriorOpponent();
ADDRGP4 UI_PriorOpponent
CALLV
pop
line 2459
;2459:		} else {
ADDRGP4 $1974
JUMPV
LABELV $1973
line 2460
;2460:			UI_NextOpponent();
ADDRGP4 UI_NextOpponent
CALLV
pop
line 2461
;2461:		}
LABELV $1974
line 2462
;2462:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1967
JUMPV
LABELV $1968
line 2464
;2463:	}
;2464:	return qfalse;
CNSTI4 0
RETI4
LABELV $1967
endproc UI_OpponentName_HandleKey 4 0
proc UI_BotName_HandleKey 24 4
line 2467
;2465:}
;2466:
;2467:static qboolean UI_BotName_HandleKey(int flags, float *special, int key) {
line 2468
;2468:	if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1980
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1980
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1980
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1976
LABELV $1980
line 2469
;2469:		int game = trap_Cvar_VariableValue("g_gametype");
ADDRGP4 $1314
ARGP4
ADDRLP4 12
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 2470
;2470:		int value = uiInfo.botIndex;
ADDRLP4 4
ADDRGP4 uiInfo+73444
INDIRI4
ASGNI4
line 2472
;2471:
;2472:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1982
line 2473
;2473:			value--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2474
;2474:		} else {
ADDRGP4 $1983
JUMPV
LABELV $1982
line 2475
;2475:			value++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2476
;2476:		}
LABELV $1983
line 2478
;2477:
;2478:		if (game >= GT_TEAM) {
ADDRLP4 8
INDIRI4
CNSTI4 3
LTI4 $1984
line 2479
;2479:			if (value >= uiInfo.characterCount + 2) {
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+73440
INDIRI4
CNSTI4 2
ADDI4
LTI4 $1986
line 2480
;2480:				value = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2481
;2481:			} else if (value < 0) {
ADDRGP4 $1985
JUMPV
LABELV $1986
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1985
line 2482
;2482:				value = uiInfo.characterCount + 2 - 1;
ADDRLP4 4
ADDRGP4 uiInfo+73440
INDIRI4
CNSTI4 2
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 2483
;2483:			}
line 2484
;2484:		} else {
ADDRGP4 $1985
JUMPV
LABELV $1984
line 2485
;2485:			if (value >= UI_GetNumBots() + 2) {
ADDRLP4 16
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 16
INDIRI4
CNSTI4 2
ADDI4
LTI4 $1992
line 2486
;2486:				value = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2487
;2487:			} else if (value < 0) {
ADDRGP4 $1993
JUMPV
LABELV $1992
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1994
line 2488
;2488:				value = UI_GetNumBots() + 2 - 1;
ADDRLP4 20
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
CNSTI4 2
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 2489
;2489:			}
LABELV $1994
LABELV $1993
line 2490
;2490:		}
LABELV $1985
line 2491
;2491:		uiInfo.botIndex = value;
ADDRGP4 uiInfo+73444
ADDRLP4 4
INDIRI4
ASGNI4
line 2492
;2492:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1975
JUMPV
LABELV $1976
line 2494
;2493:	}
;2494:	return qfalse;
CNSTI4 0
RETI4
LABELV $1975
endproc UI_BotName_HandleKey 24 4
proc UI_BotSkill_HandleKey 8 0
line 2497
;2495:}
;2496:
;2497:static qboolean UI_BotSkill_HandleKey(int flags, float *special, int key) {
line 2498
;2498:	if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $2002
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $2002
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $2002
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1998
LABELV $2002
line 2499
;2499:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $2003
line 2500
;2500:			uiInfo.skillIndex--;
ADDRLP4 4
ADDRGP4 uiInfo+96672
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2501
;2501:		} else {
ADDRGP4 $2004
JUMPV
LABELV $2003
line 2502
;2502:			uiInfo.skillIndex++;
ADDRLP4 4
ADDRGP4 uiInfo+96672
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2503
;2503:		}
LABELV $2004
line 2504
;2504:		if (uiInfo.skillIndex >= numSkillLevels) {
ADDRGP4 uiInfo+96672
INDIRI4
ADDRGP4 numSkillLevels
INDIRI4
LTI4 $2007
line 2505
;2505:			uiInfo.skillIndex = 0;
ADDRGP4 uiInfo+96672
CNSTI4 0
ASGNI4
line 2506
;2506:		} else if (uiInfo.skillIndex < 0) {
ADDRGP4 $2008
JUMPV
LABELV $2007
ADDRGP4 uiInfo+96672
INDIRI4
CNSTI4 0
GEI4 $2011
line 2507
;2507:			uiInfo.skillIndex = numSkillLevels - 1;
ADDRGP4 uiInfo+96672
ADDRGP4 numSkillLevels
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2508
;2508:		}
LABELV $2011
LABELV $2008
line 2509
;2509:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1997
JUMPV
LABELV $1998
line 2511
;2510:	}
;2511:	return qfalse;
CNSTI4 0
RETI4
LABELV $1997
endproc UI_BotSkill_HandleKey 8 0
proc UI_RedBlue_HandleKey 8 0
line 2514
;2512:}
;2513:
;2514:static qboolean UI_RedBlue_HandleKey(int flags, float *special, int key) {
line 2515
;2515:	if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $2020
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $2020
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $2020
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $2016
LABELV $2020
line 2516
;2516:		uiInfo.redBlue ^= 1;
ADDRLP4 4
ADDRGP4 uiInfo+78840
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 2517
;2517:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2015
JUMPV
LABELV $2016
line 2519
;2518:	}
;2519:	return qfalse;
CNSTI4 0
RETI4
LABELV $2015
endproc UI_RedBlue_HandleKey 8 0
proc UI_Crosshair_HandleKey 8 8
line 2522
;2520:}
;2521:
;2522:static qboolean UI_Crosshair_HandleKey(int flags, float *special, int key) {
line 2523
;2523:	if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $2027
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $2027
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $2027
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $2023
LABELV $2027
line 2524
;2524:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $2028
line 2525
;2525:			uiInfo.currentCrosshair--;
ADDRLP4 4
ADDRGP4 uiInfo+119476
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2526
;2526:		} else {
ADDRGP4 $2029
JUMPV
LABELV $2028
line 2527
;2527:			uiInfo.currentCrosshair++;
ADDRLP4 4
ADDRGP4 uiInfo+119476
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2528
;2528:		}
LABELV $2029
line 2530
;2529:
;2530:		if (uiInfo.currentCrosshair >= NUM_CROSSHAIRS) {
ADDRGP4 uiInfo+119476
INDIRI4
CNSTI4 10
LTI4 $2032
line 2531
;2531:			uiInfo.currentCrosshair = 0;
ADDRGP4 uiInfo+119476
CNSTI4 0
ASGNI4
line 2532
;2532:		} else if (uiInfo.currentCrosshair < 0) {
ADDRGP4 $2033
JUMPV
LABELV $2032
ADDRGP4 uiInfo+119476
INDIRI4
CNSTI4 0
GEI4 $2036
line 2533
;2533:			uiInfo.currentCrosshair = NUM_CROSSHAIRS - 1;
ADDRGP4 uiInfo+119476
CNSTI4 9
ASGNI4
line 2534
;2534:		}
LABELV $2036
LABELV $2033
line 2535
;2535:		trap_Cvar_Set("cg_drawCrosshair", va("%d", uiInfo.currentCrosshair));
ADDRGP4 $704
ARGP4
ADDRGP4 uiInfo+119476
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2040
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2536
;2536:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2022
JUMPV
LABELV $2023
line 2538
;2537:	}
;2538:	return qfalse;
CNSTI4 0
RETI4
LABELV $2022
endproc UI_Crosshair_HandleKey 8 8
proc UI_SelectedPlayer_HandleKey 16 8
line 2543
;2539:}
;2540:
;2541:
;2542:
;2543:static qboolean UI_SelectedPlayer_HandleKey(int flags, float *special, int key) {
line 2544
;2544:	if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $2047
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $2047
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $2047
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $2043
LABELV $2047
line 2547
;2545:		int selected;
;2546:
;2547:		UI_BuildPlayerList();
ADDRGP4 UI_BuildPlayerList
CALLV
pop
line 2548
;2548:		if (!uiInfo.teamLeader) {
ADDRGP4 uiInfo+78868
INDIRI4
CNSTI4 0
NEI4 $2048
line 2549
;2549:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2042
JUMPV
LABELV $2048
line 2551
;2550:		}
;2551:		selected = trap_Cvar_VariableValue("cg_selectedPlayer");
ADDRGP4 $1382
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 8
INDIRF4
CVFI4 4
ASGNI4
line 2553
;2552:
;2553:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $2051
line 2554
;2554:			selected--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2555
;2555:		} else {
ADDRGP4 $2052
JUMPV
LABELV $2051
line 2556
;2556:			selected++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2557
;2557:		}
LABELV $2052
line 2559
;2558:
;2559:		if (selected > uiInfo.myTeamCount) {
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+78848
INDIRI4
LEI4 $2053
line 2560
;2560:			selected = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2561
;2561:		} else if (selected < 0) {
ADDRGP4 $2054
JUMPV
LABELV $2053
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $2056
line 2562
;2562:			selected = uiInfo.myTeamCount;
ADDRLP4 4
ADDRGP4 uiInfo+78848
INDIRI4
ASGNI4
line 2563
;2563:		}
LABELV $2056
LABELV $2054
line 2565
;2564:
;2565:		if (selected == uiInfo.myTeamCount) {
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+78848
INDIRI4
NEI4 $2059
line 2566
;2566:			trap_Cvar_Set("cg_selectedPlayerName", "Everyone");
ADDRGP4 $1390
ARGP4
ADDRGP4 $2062
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2567
;2567:		} else {
ADDRGP4 $2060
JUMPV
LABELV $2059
line 2568
;2568:			trap_Cvar_Set("cg_selectedPlayerName", uiInfo.teamNames[selected]);
ADDRGP4 $1390
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+80920
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2569
;2569:		}
LABELV $2060
line 2570
;2570:		trap_Cvar_Set("cg_selectedPlayer", va("%d", selected));
ADDRGP4 $704
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1382
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2571
;2571:	}
LABELV $2043
line 2572
;2572:	return qfalse;
CNSTI4 0
RETI4
LABELV $2042
endproc UI_SelectedPlayer_HandleKey 16 8
proc UI_OwnerDrawHandleKey 48 20
line 2576
;2573:}
;2574:
;2575:
;2576:static qboolean UI_OwnerDrawHandleKey(int ownerDraw, int flags, float *special, int key) {
line 2577
;2577:	switch (ownerDraw) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 200
LTI4 $2066
ADDRLP4 0
INDIRI4
CNSTI4 253
GTI4 $2066
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2086-800
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $2086
address $2067
address $2068
address $2066
address $2069
address $2066
address $2070
address $2066
address $2073
address $2074
address $2075
address $2076
address $2076
address $2076
address $2076
address $2076
address $2077
address $2077
address $2077
address $2077
address $2077
address $2078
address $2066
address $2079
address $2066
address $2066
address $2066
address $2066
address $2066
address $2066
address $2066
address $2066
address $2066
address $2066
address $2066
address $2066
address $2066
address $2066
address $2080
address $2066
address $2081
address $2082
address $2083
address $2084
address $2085
address $2066
address $2071
address $2066
address $2066
address $2066
address $2066
address $2066
address $2066
address $2066
address $2072
code
LABELV $2067
line 2579
;2578:	case UI_HANDICAP:
;2579:		return UI_Handicap_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 UI_Handicap_HandleKey
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $2064
JUMPV
line 2580
;2580:		break;
LABELV $2068
line 2582
;2581:	case UI_EFFECTS:
;2582:		return UI_Effects_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 UI_Effects_HandleKey
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $2064
JUMPV
line 2583
;2583:		break;
LABELV $2069
line 2585
;2584:	case UI_CLANNAME:
;2585:		return UI_ClanName_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 UI_ClanName_HandleKey
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $2064
JUMPV
line 2586
;2586:		break;
LABELV $2070
line 2588
;2587:	case UI_GAMETYPE:
;2588:		return UI_GameType_HandleKey(flags, special, key, qtrue);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 UI_GameType_HandleKey
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
RETI4
ADDRGP4 $2064
JUMPV
line 2589
;2589:		break;
LABELV $2071
line 2591
;2590:	case UI_NETGAMETYPE:
;2591:		return UI_NetGameType_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 UI_NetGameType_HandleKey
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $2064
JUMPV
line 2592
;2592:		break;
LABELV $2072
line 2594
;2593:	case UI_JOINGAMETYPE:
;2594:		return UI_JoinGameType_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 UI_JoinGameType_HandleKey
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
RETI4
ADDRGP4 $2064
JUMPV
line 2595
;2595:		break;
LABELV $2073
line 2597
;2596:	case UI_SKILL:
;2597:		return UI_Skill_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 UI_Skill_HandleKey
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
RETI4
ADDRGP4 $2064
JUMPV
line 2598
;2598:		break;
LABELV $2074
line 2600
;2599:	case UI_BLUETEAMNAME:
;2600:		return UI_TeamName_HandleKey(flags, special, key, qtrue);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 32
ADDRGP4 UI_TeamName_HandleKey
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
RETI4
ADDRGP4 $2064
JUMPV
line 2601
;2601:		break;
LABELV $2075
line 2603
;2602:	case UI_REDTEAMNAME:
;2603:		return UI_TeamName_HandleKey(flags, special, key, qfalse);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 36
ADDRGP4 UI_TeamName_HandleKey
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
RETI4
ADDRGP4 $2064
JUMPV
line 2604
;2604:		break;
LABELV $2076
line 2610
;2605:	case UI_BLUETEAM1:
;2606:	case UI_BLUETEAM2:
;2607:	case UI_BLUETEAM3:
;2608:	case UI_BLUETEAM4:
;2609:	case UI_BLUETEAM5:
;2610:		UI_TeamMember_HandleKey(flags, special, key, qtrue, ownerDraw - UI_BLUETEAM1 + 1);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRFP4 0
INDIRI4
CNSTI4 210
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 UI_TeamMember_HandleKey
CALLI4
pop
line 2611
;2611:		break;
ADDRGP4 $2066
JUMPV
LABELV $2077
line 2617
;2612:	case UI_REDTEAM1:
;2613:	case UI_REDTEAM2:
;2614:	case UI_REDTEAM3:
;2615:	case UI_REDTEAM4:
;2616:	case UI_REDTEAM5:
;2617:		UI_TeamMember_HandleKey(flags, special, key, qfalse, ownerDraw - UI_REDTEAM1 + 1);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRFP4 0
INDIRI4
CNSTI4 215
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 UI_TeamMember_HandleKey
CALLI4
pop
line 2618
;2618:		break;
ADDRGP4 $2066
JUMPV
LABELV $2078
line 2620
;2619:	case UI_NETSOURCE:
;2620:		UI_NetSource_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 UI_NetSource_HandleKey
CALLI4
pop
line 2621
;2621:		break;
ADDRGP4 $2066
JUMPV
LABELV $2079
line 2623
;2622:	case UI_NETFILTER:
;2623:		UI_NetFilter_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 UI_NetFilter_HandleKey
CALLI4
pop
line 2624
;2624:		break;
ADDRGP4 $2066
JUMPV
LABELV $2080
line 2626
;2625:	case UI_OPPONENT_NAME:
;2626:		UI_OpponentName_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 UI_OpponentName_HandleKey
CALLI4
pop
line 2627
;2627:		break;
ADDRGP4 $2066
JUMPV
LABELV $2081
line 2629
;2628:	case UI_BOTNAME:
;2629:		return UI_BotName_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 UI_BotName_HandleKey
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
RETI4
ADDRGP4 $2064
JUMPV
line 2630
;2630:		break;
LABELV $2082
line 2632
;2631:	case UI_BOTSKILL:
;2632:		return UI_BotSkill_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 UI_BotSkill_HandleKey
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
RETI4
ADDRGP4 $2064
JUMPV
line 2633
;2633:		break;
LABELV $2083
line 2635
;2634:	case UI_REDBLUE:
;2635:		UI_RedBlue_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 UI_RedBlue_HandleKey
CALLI4
pop
line 2636
;2636:		break;
ADDRGP4 $2066
JUMPV
LABELV $2084
line 2638
;2637:	case UI_CROSSHAIR:
;2638:		UI_Crosshair_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 UI_Crosshair_HandleKey
CALLI4
pop
line 2639
;2639:		break;
ADDRGP4 $2066
JUMPV
LABELV $2085
line 2641
;2640:	case UI_SELECTEDPLAYER:
;2641:		UI_SelectedPlayer_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 UI_SelectedPlayer_HandleKey
CALLI4
pop
line 2642
;2642:		break;
line 2644
;2643:	default:
;2644:		break;
LABELV $2066
line 2647
;2645:	}
;2646:
;2647:	return qfalse;
CNSTI4 0
RETI4
LABELV $2064
endproc UI_OwnerDrawHandleKey 48 20
proc UI_GetValue 0 0
line 2651
;2648:}
;2649:
;2650:
;2651:static float UI_GetValue(int ownerDraw) {
line 2652
;2652:	return 0;
CNSTF4 0
RETF4
LABELV $2088
endproc UI_GetValue 0 0
proc UI_ServersQsortCompare 4 20
line 2660
;2653:}
;2654:
;2655:/*
;2656:=================
;2657:UI_ServersQsortCompare
;2658:=================
;2659:*/
;2660:static int QDECL UI_ServersQsortCompare(const void *arg1, const void *arg2) {
line 2661
;2661:	return trap_LAN_CompareServers(ui_netSource.integer, uiInfo.serverStatus.sortKey, uiInfo.serverStatus.sortDir, *(int *)arg1, *(int *)arg2);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+99264+2200
INDIRI4
ARGI4
ADDRGP4 uiInfo+99264+2204
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 trap_LAN_CompareServers
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $2089
endproc UI_ServersQsortCompare 4 20
export UI_ServersSort
proc UI_ServersSort 0 16
line 2670
;2662:}
;2663:
;2664:
;2665:/*
;2666:=================
;2667:UI_ServersSort
;2668:=================
;2669:*/
;2670:void UI_ServersSort(int column, qboolean force) {
line 2672
;2671:
;2672:	if (!force) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $2096
line 2673
;2673:		if (uiInfo.serverStatus.sortKey == column) {
ADDRGP4 uiInfo+99264+2200
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $2098
line 2674
;2674:			return;
ADDRGP4 $2095
JUMPV
LABELV $2098
line 2676
;2675:		}
;2676:	}
LABELV $2096
line 2678
;2677:
;2678:	uiInfo.serverStatus.sortKey = column;
ADDRGP4 uiInfo+99264+2200
ADDRFP4 0
INDIRI4
ASGNI4
line 2679
;2679:	qsort(&uiInfo.serverStatus.displayServers[0], uiInfo.serverStatus.numDisplayServers, sizeof(int), UI_ServersQsortCompare);
ADDRGP4 uiInfo+99264+2220
ARGP4
ADDRGP4 uiInfo+99264+10412
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 UI_ServersQsortCompare
ARGP4
ADDRGP4 qsort
CALLV
pop
line 2680
;2680:}
LABELV $2095
endproc UI_ServersSort 0 16
proc UI_LoadMods 2092 16
line 2727
;2681:
;2682:/*
;2683:static void UI_StartSinglePlayer() {
;2684:	int i,j, k, skill;
;2685:	char buff[1024];
;2686:	i = trap_Cvar_VariableValue( "ui_currentTier" );
;2687:  if (i < 0 || i >= tierCount) {
;2688:	i = 0;
;2689:  }
;2690:	j = trap_Cvar_VariableValue("ui_currentMap");
;2691:	if (j < 0 || j > MAPS_PER_TIER) {
;2692:		j = 0;
;2693:	}
;2694:
;2695:	trap_Cvar_SetValue( "singleplayer", 1 );
;2696:	trap_Cvar_SetValue( "g_gametype", Com_Clamp( 0, 7, tierList[i].gameTypes[j] ) );
;2697:	trap_Cmd_ExecuteText( EXEC_APPEND, va( "wait ; wait ; map %s\n", tierList[i].maps[j] ) );
;2698:	skill = trap_Cvar_VariableValue( "g_spSkill" );
;2699:
;2700:	if (j == MAPS_PER_TIER-1) {
;2701:		k = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
;2702:		Com_sprintf( buff, sizeof(buff), "wait ; addbot %s %i %s 250 %s\n", UI_AIFromName(teamList[k].teamMembers[0]), skill, "", teamList[k].teamMembers[0]);
;2703:	} else {
;2704:		k = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
;2705:		for (i = 0; i < PLAYERS_PER_TEAM; i++) {
;2706:			Com_sprintf( buff, sizeof(buff), "wait ; addbot %s %i %s 250 %s\n", UI_AIFromName(teamList[k].teamMembers[i]), skill, "Blue", teamList[k].teamMembers[i]);
;2707:			trap_Cmd_ExecuteText( EXEC_APPEND, buff );
;2708:		}
;2709:
;2710:		k = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
;2711:		for (i = 1; i < PLAYERS_PER_TEAM; i++) {
;2712:			Com_sprintf( buff, sizeof(buff), "wait ; addbot %s %i %s 250 %s\n", UI_AIFromName(teamList[k].teamMembers[i]), skill, "Red", teamList[k].teamMembers[i]);
;2713:			trap_Cmd_ExecuteText( EXEC_APPEND, buff );
;2714:		}
;2715:		trap_Cmd_ExecuteText( EXEC_APPEND, "wait 5; team Red\n" );
;2716:	}
;2717:
;2718:
;2719:}
;2720:*/
;2721:
;2722:/*
;2723:===============
;2724:UI_LoadMods
;2725:===============
;2726:*/
;2727:static void UI_LoadMods() {
line 2735
;2728:	int		numdirs;
;2729:	char	dirlist[2048];
;2730:	char *dirptr;
;2731:	char *descptr;
;2732:	int		i;
;2733:	int		dirlen;
;2734:
;2735:	uiInfo.modCount = 0;
ADDRGP4 uiInfo+97188
CNSTI4 0
ASGNI4
line 2736
;2736:	numdirs = trap_FS_GetFileList("$modlist", "", dirlist, sizeof(dirlist));
ADDRGP4 $2110
ARGP4
ADDRGP4 $110
ARGP4
ADDRLP4 20
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 2068
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 2068
INDIRI4
ASGNI4
line 2737
;2737:	dirptr = dirlist;
ADDRLP4 0
ADDRLP4 20
ASGNP4
line 2738
;2738:	for (i = 0; i < numdirs; i++) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $2114
JUMPV
LABELV $2111
line 2739
;2739:		dirlen = strlen(dirptr) + 1;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 2072
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 2072
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2740
;2740:		descptr = dirptr + dirlen;
ADDRLP4 4
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 2741
;2741:		uiInfo.modList[uiInfo.modCount].modName = String_Alloc(dirptr);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 2076
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+97188
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+96676
ADDP4
ADDRLP4 2076
INDIRP4
ASGNP4
line 2742
;2742:		uiInfo.modList[uiInfo.modCount].modDescr = String_Alloc(descptr);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 2080
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+97188
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+96676+4
ADDP4
ADDRLP4 2080
INDIRP4
ASGNP4
line 2743
;2743:		dirptr += dirlen + strlen(descptr) + 1;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 2084
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ADDRLP4 2084
INDIRI4
ADDI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 2744
;2744:		uiInfo.modCount++;
ADDRLP4 2088
ADDRGP4 uiInfo+97188
ASGNP4
ADDRLP4 2088
INDIRP4
ADDRLP4 2088
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2745
;2745:		if (uiInfo.modCount >= MAX_MODS) {
ADDRGP4 uiInfo+97188
INDIRI4
CNSTI4 64
LTI4 $2121
line 2746
;2746:			break;
ADDRGP4 $2113
JUMPV
LABELV $2121
line 2748
;2747:		}
;2748:	}
LABELV $2112
line 2738
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2114
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $2111
LABELV $2113
line 2750
;2749:
;2750:}
LABELV $2108
endproc UI_LoadMods 2092 16
proc UI_LoadTeams 4120 16
line 2758
;2751:
;2752:
;2753:/*
;2754:===============
;2755:UI_LoadTeams
;2756:===============
;2757:*/
;2758:static void UI_LoadTeams() {
line 2763
;2759:	char	teamList[4096];
;2760:	char *teamName;
;2761:	int		i, len, count;
;2762:
;2763:	count = trap_FS_GetFileList("", "team", teamList, 4096);
ADDRGP4 $110
ARGP4
ADDRGP4 $2125
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 4096
ARGI4
ADDRLP4 4112
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 4112
INDIRI4
ASGNI4
line 2765
;2764:
;2765:	if (count) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2126
line 2766
;2766:		teamName = teamList;
ADDRLP4 0
ADDRLP4 16
ASGNP4
line 2767
;2767:		for (i = 0; i < count; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2131
JUMPV
LABELV $2128
line 2768
;2768:			len = strlen(teamName);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4116
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 4116
INDIRI4
ASGNI4
line 2769
;2769:			UI_ParseTeamInfo(teamName);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 UI_ParseTeamInfo
CALLV
pop
line 2770
;2770:			teamName += len + 1;
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 2771
;2771:		}
LABELV $2129
line 2767
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2131
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $2128
line 2772
;2772:	}
LABELV $2126
line 2774
;2773:
;2774:}
LABELV $2124
endproc UI_LoadTeams 4120 16
proc UI_LoadMovies 4124 16
line 2782
;2775:
;2776:
;2777:/*
;2778:===============
;2779:UI_LoadMovies
;2780:===============
;2781:*/
;2782:static void UI_LoadMovies() {
line 2787
;2783:	char	movielist[4096];
;2784:	char *moviename;
;2785:	int		i, len;
;2786:
;2787:	uiInfo.movieCount = trap_FS_GetFileList("video", "roq", movielist, 4096);
ADDRGP4 $2134
ARGP4
ADDRGP4 $2135
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 4096
ARGI4
ADDRLP4 4108
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRGP4 uiInfo+99252
ADDRLP4 4108
INDIRI4
ASGNI4
line 2789
;2788:
;2789:	if (uiInfo.movieCount) {
ADDRGP4 uiInfo+99252
INDIRI4
CNSTI4 0
EQI4 $2136
line 2790
;2790:		if (uiInfo.movieCount > MAX_MOVIES) {
ADDRGP4 uiInfo+99252
INDIRI4
CNSTI4 256
LEI4 $2139
line 2791
;2791:			uiInfo.movieCount = MAX_MOVIES;
ADDRGP4 uiInfo+99252
CNSTI4 256
ASGNI4
line 2792
;2792:		}
LABELV $2139
line 2793
;2793:		moviename = movielist;
ADDRLP4 0
ADDRLP4 12
ASGNP4
line 2794
;2794:		for (i = 0; i < uiInfo.movieCount; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $2146
JUMPV
LABELV $2143
line 2795
;2795:			len = strlen(moviename);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4112
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 4112
INDIRI4
ASGNI4
line 2796
;2796:			if (!Q_stricmp(moviename + len - 4, ".roq")) {
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
CNSTI4 -4
ADDP4
ARGP4
ADDRGP4 $2150
ARGP4
ADDRLP4 4116
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4116
INDIRI4
CNSTI4 0
NEI4 $2148
line 2797
;2797:				moviename[len - 4] = '\0';
ADDRLP4 4
INDIRI4
CNSTI4 4
SUBI4
ADDRLP4 0
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 2798
;2798:			}
LABELV $2148
line 2799
;2799:			Q_strupr(moviename);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 2800
;2800:			uiInfo.movieList[i] = String_Alloc(moviename);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4120
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+98228
ADDP4
ADDRLP4 4120
INDIRP4
ASGNP4
line 2801
;2801:			moviename += len + 1;
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 2802
;2802:		}
LABELV $2144
line 2794
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2146
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+99252
INDIRI4
LTI4 $2143
line 2803
;2803:	}
LABELV $2136
line 2805
;2804:
;2805:}
LABELV $2132
endproc UI_LoadMovies 4124 16
proc UI_LoadDemos 4168 16
line 2814
;2806:
;2807:
;2808:
;2809:/*
;2810:===============
;2811:UI_LoadDemos
;2812:===============
;2813:*/
;2814:static void UI_LoadDemos() {
line 2820
;2815:	char	demolist[4096];
;2816:	char demoExt[32];
;2817:	char *demoname;
;2818:	int		i, len;
;2819:
;2820:	Com_sprintf(demoExt, sizeof(demoExt), "dm_%d", (int)trap_Cvar_VariableValue("protocol"));
ADDRGP4 $2154
ARGP4
ADDRLP4 4140
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $2153
ARGP4
ADDRLP4 4140
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 2822
;2821:
;2822:	uiInfo.demoCount = trap_FS_GetFileList("demos", demoExt, demolist, 4096);
ADDRGP4 $2156
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 44
ARGP4
CNSTI4 4096
ARGI4
ADDRLP4 4144
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRGP4 uiInfo+98220
ADDRLP4 4144
INDIRI4
ASGNI4
line 2824
;2823:
;2824:	Com_sprintf(demoExt, sizeof(demoExt), ".dm_%d", (int)trap_Cvar_VariableValue("protocol"));
ADDRGP4 $2154
ARGP4
ADDRLP4 4148
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $2157
ARGP4
ADDRLP4 4148
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 2826
;2825:
;2826:	if (uiInfo.demoCount) {
ADDRGP4 uiInfo+98220
INDIRI4
CNSTI4 0
EQI4 $2158
line 2827
;2827:		if (uiInfo.demoCount > MAX_DEMOS) {
ADDRGP4 uiInfo+98220
INDIRI4
CNSTI4 256
LEI4 $2161
line 2828
;2828:			uiInfo.demoCount = MAX_DEMOS;
ADDRGP4 uiInfo+98220
CNSTI4 256
ASGNI4
line 2829
;2829:		}
LABELV $2161
line 2830
;2830:		demoname = demolist;
ADDRLP4 0
ADDRLP4 44
ASGNP4
line 2831
;2831:		for (i = 0; i < uiInfo.demoCount; i++) {
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRGP4 $2168
JUMPV
LABELV $2165
line 2832
;2832:			len = strlen(demoname);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4152
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 4152
INDIRI4
ASGNI4
line 2833
;2833:			if (!Q_stricmp(demoname + len - strlen(demoExt), demoExt)) {
ADDRLP4 4
ARGP4
ADDRLP4 4156
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
ADDRLP4 4156
INDIRI4
SUBP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 4160
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4160
INDIRI4
CNSTI4 0
NEI4 $2170
line 2834
;2834:				demoname[len - strlen(demoExt)] = '\0';
ADDRLP4 4
ARGP4
ADDRLP4 4164
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
ADDRLP4 4164
INDIRI4
SUBI4
ADDRLP4 0
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 2835
;2835:			}
LABELV $2170
line 2836
;2836:			Q_strupr(demoname);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 2837
;2837:			uiInfo.demoList[i] = String_Alloc(demoname);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4164
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 40
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+97196
ADDP4
ADDRLP4 4164
INDIRP4
ASGNP4
line 2838
;2838:			demoname += len + 1;
ADDRLP4 0
ADDRLP4 36
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 2839
;2839:		}
LABELV $2166
line 2831
ADDRLP4 40
ADDRLP4 40
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2168
ADDRLP4 40
INDIRI4
ADDRGP4 uiInfo+98220
INDIRI4
LTI4 $2165
line 2840
;2840:	}
LABELV $2158
line 2842
;2841:
;2842:}
LABELV $2152
endproc UI_LoadDemos 4168 16
proc UI_SetNextMap 4 16
line 2845
;2843:
;2844:
;2845:static qboolean UI_SetNextMap(int actual, int index) {
line 2847
;2846:	int i;
;2847:	for (i = actual + 1; i < uiInfo.mapCount; i++) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $2177
JUMPV
LABELV $2174
line 2848
;2848:		if (uiInfo.mapList[i].active) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+96
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2179
line 2849
;2849:			Menu_SetFeederSelection(NULL, FEEDER_MAPS, index + 1, "skirmish");
CNSTP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 $2183
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 2850
;2850:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2173
JUMPV
LABELV $2179
line 2852
;2851:		}
;2852:	}
LABELV $2175
line 2847
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2177
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+83224
INDIRI4
LTI4 $2174
line 2853
;2853:	return qfalse;
CNSTI4 0
RETI4
LABELV $2173
endproc UI_SetNextMap 4 16
proc UI_StartSkirmish 1160 32
line 2857
;2854:}
;2855:
;2856:
;2857:static void UI_StartSkirmish(qboolean next) {
line 2862
;2858:	int i, k, g, delay, temp;
;2859:	float skill;
;2860:	char buff[MAX_STRING_CHARS];
;2861:
;2862:	if (next) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $2185
line 2864
;2863:		int actual;
;2864:		int index = trap_Cvar_VariableValue("ui_mapIndex");
ADDRGP4 $2187
ARGP4
ADDRLP4 1056
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1048
ADDRLP4 1056
INDIRF4
CVFI4 4
ASGNI4
line 2865
;2865:		UI_MapCountByGameType(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_MapCountByGameType
CALLI4
pop
line 2866
;2866:		UI_SelectedMap(index, &actual);
ADDRLP4 1048
INDIRI4
ARGI4
ADDRLP4 1052
ARGP4
ADDRGP4 UI_SelectedMap
CALLP4
pop
line 2867
;2867:		if (UI_SetNextMap(actual, index)) {
ADDRLP4 1052
INDIRI4
ARGI4
ADDRLP4 1048
INDIRI4
ARGI4
ADDRLP4 1060
ADDRGP4 UI_SetNextMap
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
EQI4 $2188
line 2868
;2868:		} else {
ADDRGP4 $2189
JUMPV
LABELV $2188
line 2869
;2869:			UI_GameType_HandleKey(0, 0, K_MOUSE1, qfalse);
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
CNSTI4 178
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_GameType_HandleKey
CALLI4
pop
line 2870
;2870:			UI_MapCountByGameType(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_MapCountByGameType
CALLI4
pop
line 2871
;2871:			Menu_SetFeederSelection(NULL, FEEDER_MAPS, 0, "skirmish");
CNSTP4 0
ARGP4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 $2183
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 2872
;2872:		}
LABELV $2189
line 2873
;2873:	}
LABELV $2185
line 2875
;2874:
;2875:	g = uiInfo.gameTypes[ui_gameType.integer].gtEnum;
ADDRLP4 1040
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580+4
ADDP4
INDIRI4
ASGNI4
line 2876
;2876:	trap_Cvar_SetValue("g_gametype", g);
ADDRGP4 $1314
ARGP4
ADDRLP4 1040
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2877
;2877:	trap_Cmd_ExecuteText(EXEC_APPEND, va("wait ; wait ; map %s\n", uiInfo.mapList[ui_currentMap.integer].mapLoadName));
ADDRGP4 $2193
ARGP4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1048
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 2878
;2878:	skill = trap_Cvar_VariableValue("g_spSkill");
ADDRGP4 $815
ARGP4
ADDRLP4 1052
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1044
ADDRLP4 1052
INDIRF4
ASGNF4
line 2879
;2879:	trap_Cvar_Set("ui_scoreMap", uiInfo.mapList[ui_currentMap.integer].mapName);
ADDRGP4 $2197
ARGP4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2881
;2880:
;2881:	k = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1090
ARGP4
ADDRLP4 1056
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 1056
INDIRP4
ARGP4
ADDRLP4 1060
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 1060
INDIRI4
ASGNI4
line 2883
;2882:
;2883:	trap_Cvar_Set("ui_singlePlayerActive", "1");
ADDRGP4 $2200
ARGP4
ADDRGP4 $386
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2886
;2884:
;2885:	// set up sp overrides, will be replaced on postgame
;2886:	temp = trap_Cvar_VariableValue("capturelimit");
ADDRGP4 $706
ARGP4
ADDRLP4 1064
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1036
ADDRLP4 1064
INDIRF4
CVFI4 4
ASGNI4
line 2887
;2887:	trap_Cvar_Set("ui_saveCaptureLimit", va("%i", temp));
ADDRGP4 $1728
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1068
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2201
ARGP4
ADDRLP4 1068
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2888
;2888:	temp = trap_Cvar_VariableValue("fraglimit");
ADDRGP4 $707
ARGP4
ADDRLP4 1072
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1036
ADDRLP4 1072
INDIRF4
CVFI4 4
ASGNI4
line 2889
;2889:	trap_Cvar_Set("ui_saveFragLimit", va("%i", temp));
ADDRGP4 $1728
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1076
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2202
ARGP4
ADDRLP4 1076
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2891
;2890:
;2891:	UI_SetCapFragLimits(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_SetCapFragLimits
CALLV
pop
line 2893
;2892:
;2893:	temp = trap_Cvar_VariableValue("cg_drawTimer");
ADDRGP4 $2203
ARGP4
ADDRLP4 1080
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1036
ADDRLP4 1080
INDIRF4
CVFI4 4
ASGNI4
line 2894
;2894:	trap_Cvar_Set("ui_drawTimer", va("%i", temp));
ADDRGP4 $1728
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1084
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2204
ARGP4
ADDRLP4 1084
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2895
;2895:	temp = trap_Cvar_VariableValue("g_doWarmup");
ADDRGP4 $2205
ARGP4
ADDRLP4 1088
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1036
ADDRLP4 1088
INDIRF4
CVFI4 4
ASGNI4
line 2896
;2896:	trap_Cvar_Set("ui_doWarmup", va("%i", temp));
ADDRGP4 $1728
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1092
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2206
ARGP4
ADDRLP4 1092
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2897
;2897:	temp = trap_Cvar_VariableValue("g_friendlyFire");
ADDRGP4 $2207
ARGP4
ADDRLP4 1096
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1036
ADDRLP4 1096
INDIRF4
CVFI4 4
ASGNI4
line 2898
;2898:	trap_Cvar_Set("ui_friendlyFire", va("%i", temp));
ADDRGP4 $1728
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1100
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2208
ARGP4
ADDRLP4 1100
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2899
;2899:	temp = trap_Cvar_VariableValue("sv_maxClients");
ADDRGP4 $2209
ARGP4
ADDRLP4 1104
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1036
ADDRLP4 1104
INDIRF4
CVFI4 4
ASGNI4
line 2900
;2900:	trap_Cvar_Set("ui_maxClients", va("%i", temp));
ADDRGP4 $1728
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1108
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2210
ARGP4
ADDRLP4 1108
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2901
;2901:	temp = trap_Cvar_VariableValue("g_warmup");
ADDRGP4 $2211
ARGP4
ADDRLP4 1112
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1036
ADDRLP4 1112
INDIRF4
CVFI4 4
ASGNI4
line 2902
;2902:	trap_Cvar_Set("ui_Warmup", va("%i", temp));
ADDRGP4 $1728
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1116
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2212
ARGP4
ADDRLP4 1116
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2903
;2903:	temp = trap_Cvar_VariableValue("sv_pure");
ADDRGP4 $2213
ARGP4
ADDRLP4 1120
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1036
ADDRLP4 1120
INDIRF4
CVFI4 4
ASGNI4
line 2904
;2904:	trap_Cvar_Set("ui_pure", va("%i", temp));
ADDRGP4 $1728
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1124
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2214
ARGP4
ADDRLP4 1124
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2906
;2905:
;2906:	trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $383
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2907
;2907:	trap_Cvar_Set("cg_drawTimer", "1");
ADDRGP4 $2203
ARGP4
ADDRGP4 $386
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2908
;2908:	trap_Cvar_Set("g_doWarmup", "1");
ADDRGP4 $2205
ARGP4
ADDRGP4 $386
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2909
;2909:	trap_Cvar_Set("g_warmup", "15");
ADDRGP4 $2211
ARGP4
ADDRGP4 $683
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2910
;2910:	trap_Cvar_Set("sv_pure", "0");
ADDRGP4 $2213
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2911
;2911:	trap_Cvar_Set("g_friendlyFire", "0");
ADDRGP4 $2207
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2912
;2912:	trap_Cvar_Set("g_redTeam", UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $689
ARGP4
ADDRLP4 1128
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2215
ARGP4
ADDRLP4 1128
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2913
;2913:	trap_Cvar_Set("g_blueTeam", UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1090
ARGP4
ADDRLP4 1132
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2216
ARGP4
ADDRLP4 1132
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2915
;2914:
;2915:	if (trap_Cvar_VariableValue("ui_recordSPDemo")) {
ADDRGP4 $2219
ARGP4
ADDRLP4 1136
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1136
INDIRF4
CNSTF4 0
EQF4 $2217
line 2916
;2916:		Com_sprintf(buff, MAX_STRING_CHARS, "%s_%i", uiInfo.mapList[ui_currentMap.integer].mapLoadName, g);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2220
ARGP4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 2917
;2917:		trap_Cvar_Set("ui_recordSPDemoName", buff);
ADDRGP4 $2224
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2918
;2918:	}
LABELV $2217
line 2920
;2919:
;2920:	delay = 500;
ADDRLP4 1032
CNSTI4 500
ASGNI4
line 2922
;2921:
;2922:	if (g == GT_TOURNAMENT) {
ADDRLP4 1040
INDIRI4
CNSTI4 1
NEI4 $2225
line 2923
;2923:		trap_Cvar_Set("sv_maxClients", "2");
ADDRGP4 $2209
ARGP4
ADDRGP4 $2227
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2924
;2924:		Com_sprintf(buff, sizeof(buff), "wait ; addbot %s %f "", %i \n", uiInfo.mapList[ui_currentMap.integer].opponentName, skill, delay);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2228
ARGP4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+12
ADDP4
INDIRP4
ARGP4
ADDRLP4 1044
INDIRF4
ARGF4
ADDRLP4 1032
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 2925
;2925:		trap_Cmd_ExecuteText(EXEC_APPEND, buff);
CNSTI4 2
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 2926
;2926:	} else {
ADDRGP4 $2226
JUMPV
LABELV $2225
line 2927
;2927:		temp = uiInfo.mapList[ui_currentMap.integer].teamMembers * 2;
ADDRLP4 1036
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+16
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 2928
;2928:		trap_Cvar_Set("sv_maxClients", va("%d", temp));
ADDRGP4 $704
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1140
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2209
ARGP4
ADDRLP4 1140
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2929
;2929:		for (i = 0; i < uiInfo.mapList[ui_currentMap.integer].teamMembers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2238
JUMPV
LABELV $2235
line 2930
;2930:			Com_sprintf(buff, sizeof(buff), "addbot %s %f %s %i %s\n", UI_AIFromName(uiInfo.teamList[k].teamMembers[i]), skill, (g == GT_FFA) ? "" : "Blue", delay, uiInfo.teamList[k].teamMembers[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1028
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+8
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1148
ADDRGP4 UI_AIFromName
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2242
ARGP4
ADDRLP4 1148
INDIRP4
ARGP4
ADDRLP4 1044
INDIRF4
ARGF4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $2248
ADDRLP4 1144
ADDRGP4 $110
ASGNP4
ADDRGP4 $2249
JUMPV
LABELV $2248
ADDRLP4 1144
ADDRGP4 $830
ASGNP4
LABELV $2249
ADDRLP4 1144
INDIRP4
ARGP4
ADDRLP4 1032
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1028
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+8
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 2931
;2931:			trap_Cmd_ExecuteText(EXEC_APPEND, buff);
CNSTI4 2
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 2932
;2932:			delay += 500;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 2933
;2933:		}
LABELV $2236
line 2929
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2238
ADDRLP4 0
INDIRI4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+16
ADDP4
INDIRI4
LTI4 $2235
line 2934
;2934:		k = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $689
ARGP4
ADDRLP4 1144
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 1144
INDIRP4
ARGP4
ADDRLP4 1148
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 1148
INDIRI4
ASGNI4
line 2935
;2935:		for (i = 0; i < uiInfo.mapList[ui_currentMap.integer].teamMembers - 1; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2253
JUMPV
LABELV $2250
line 2936
;2936:			Com_sprintf(buff, sizeof(buff), "addbot %s %f %s %i %s\n", UI_AIFromName(uiInfo.teamList[k].teamMembers[i]), skill, (g == GT_FFA) ? "" : "Red", delay, uiInfo.teamList[k].teamMembers[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1028
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+8
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1156
ADDRGP4 UI_AIFromName
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2242
ARGP4
ADDRLP4 1156
INDIRP4
ARGP4
ADDRLP4 1044
INDIRF4
ARGF4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $2262
ADDRLP4 1152
ADDRGP4 $110
ASGNP4
ADDRGP4 $2263
JUMPV
LABELV $2262
ADDRLP4 1152
ADDRGP4 $831
ASGNP4
LABELV $2263
ADDRLP4 1152
INDIRP4
ARGP4
ADDRLP4 1032
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1028
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+8
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 2937
;2937:			trap_Cmd_ExecuteText(EXEC_APPEND, buff);
CNSTI4 2
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 2938
;2938:			delay += 500;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 2939
;2939:		}
LABELV $2251
line 2935
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2253
ADDRLP4 0
INDIRI4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+16
ADDP4
INDIRI4
CNSTI4 1
SUBI4
LTI4 $2250
line 2940
;2940:	}
LABELV $2226
line 2941
;2941:	if (g >= GT_TEAM) {
ADDRLP4 1040
INDIRI4
CNSTI4 3
LTI4 $2264
line 2942
;2942:		trap_Cmd_ExecuteText(EXEC_APPEND, "wait 5; team Red\n");
CNSTI4 2
ARGI4
ADDRGP4 $2266
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 2943
;2943:	}
LABELV $2264
line 2944
;2944:}
LABELV $2184
endproc UI_StartSkirmish 1160 32
proc UI_Update 36 8
line 2946
;2945:
;2946:static void UI_Update(const char *name) {
line 2947
;2947:	int	val = trap_Cvar_VariableValue(name);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 2949
;2948:
;2949:	if (Q_stricmp(name, "ui_SetName") == 0) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2270
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2268
line 2950
;2950:		trap_Cvar_Set("name", UI_Cvar_VariableString("ui_Name"));
ADDRGP4 $2271
ARGP4
ADDRLP4 12
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $1400
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2951
;2951:	} else if (Q_stricmp(name, "ui_setRate") == 0) {
ADDRGP4 $2269
JUMPV
LABELV $2268
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2274
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2272
line 2952
;2952:		float rate = trap_Cvar_VariableValue("rate");
ADDRGP4 $2275
ARGP4
ADDRLP4 20
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 20
INDIRF4
ASGNF4
line 2953
;2953:		if (rate >= 5000) {
ADDRLP4 16
INDIRF4
CNSTF4 1167867904
LTF4 $2276
line 2954
;2954:			trap_Cvar_Set("cl_maxpackets", "30");
ADDRGP4 $2278
ARGP4
ADDRGP4 $680
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2955
;2955:			trap_Cvar_Set("cl_packetdup", "1");
ADDRGP4 $2279
ARGP4
ADDRGP4 $386
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2956
;2956:		} else if (rate >= 4000) {
ADDRGP4 $2273
JUMPV
LABELV $2276
ADDRLP4 16
INDIRF4
CNSTF4 1165623296
LTF4 $2280
line 2957
;2957:			trap_Cvar_Set("cl_maxpackets", "15");
ADDRGP4 $2278
ARGP4
ADDRGP4 $683
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2958
;2958:			trap_Cvar_Set("cl_packetdup", "2");		// favor less prediction errors when there's packet loss
ADDRGP4 $2279
ARGP4
ADDRGP4 $2227
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2959
;2959:		} else {
ADDRGP4 $2273
JUMPV
LABELV $2280
line 2960
;2960:			trap_Cvar_Set("cl_maxpackets", "15");
ADDRGP4 $2278
ARGP4
ADDRGP4 $683
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2961
;2961:			trap_Cvar_Set("cl_packetdup", "1");		// favor lower bandwidth
ADDRGP4 $2279
ARGP4
ADDRGP4 $386
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2962
;2962:		}
line 2963
;2963:	} else if (Q_stricmp(name, "ui_GetName") == 0) {
ADDRGP4 $2273
JUMPV
LABELV $2272
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2284
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $2282
line 2964
;2964:		trap_Cvar_Set("ui_Name", UI_Cvar_VariableString("name"));
ADDRGP4 $1400
ARGP4
ADDRLP4 20
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2271
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2965
;2965:	} else if (Q_stricmp(name, "r_colorbits") == 0) {
ADDRGP4 $2283
JUMPV
LABELV $2282
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2287
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $2285
line 2966
;2966:		switch (val) {
ADDRLP4 24
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 16
EQI4 $2293
ADDRLP4 24
INDIRI4
CNSTI4 16
GTI4 $2296
LABELV $2295
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2290
ADDRGP4 $2286
JUMPV
LABELV $2296
ADDRLP4 0
INDIRI4
CNSTI4 32
EQI4 $2294
ADDRGP4 $2286
JUMPV
LABELV $2290
line 2968
;2967:		case 0:
;2968:			trap_Cvar_SetValue("r_depthbits", 0);
ADDRGP4 $2291
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2969
;2969:			trap_Cvar_SetValue("r_stencilbits", 0);
ADDRGP4 $2292
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2970
;2970:			break;
ADDRGP4 $2286
JUMPV
LABELV $2293
line 2972
;2971:		case 16:
;2972:			trap_Cvar_SetValue("r_depthbits", 16);
ADDRGP4 $2291
ARGP4
CNSTF4 1098907648
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2973
;2973:			trap_Cvar_SetValue("r_stencilbits", 0);
ADDRGP4 $2292
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2974
;2974:			break;
ADDRGP4 $2286
JUMPV
LABELV $2294
line 2976
;2975:		case 32:
;2976:			trap_Cvar_SetValue("r_depthbits", 24);
ADDRGP4 $2291
ARGP4
CNSTF4 1103101952
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2977
;2977:			break;
line 2979
;2978:		}
;2979:	} else if (Q_stricmp(name, "r_lodbias") == 0) {
ADDRGP4 $2286
JUMPV
LABELV $2285
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2299
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $2297
line 2980
;2980:		switch (val) {
ADDRLP4 28
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2302
ADDRLP4 28
INDIRI4
CNSTI4 1
EQI4 $2304
ADDRLP4 28
INDIRI4
CNSTI4 2
EQI4 $2305
ADDRGP4 $2298
JUMPV
LABELV $2302
line 2982
;2981:		case 0:
;2982:			trap_Cvar_SetValue("r_subdivisions", 4);
ADDRGP4 $2303
ARGP4
CNSTF4 1082130432
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2983
;2983:			break;
ADDRGP4 $2298
JUMPV
LABELV $2304
line 2985
;2984:		case 1:
;2985:			trap_Cvar_SetValue("r_subdivisions", 12);
ADDRGP4 $2303
ARGP4
CNSTF4 1094713344
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2986
;2986:			break;
ADDRGP4 $2298
JUMPV
LABELV $2305
line 2988
;2987:		case 2:
;2988:			trap_Cvar_SetValue("r_subdivisions", 20);
ADDRGP4 $2303
ARGP4
CNSTF4 1101004800
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2989
;2989:			break;
line 2991
;2990:		}
;2991:	} else if (Q_stricmp(name, "ui_glCustom") == 0) {
ADDRGP4 $2298
JUMPV
LABELV $2297
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2308
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $2306
line 2992
;2992:		switch (val) {
ADDRLP4 32
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
LTI4 $2307
ADDRLP4 32
INDIRI4
CNSTI4 3
GTI4 $2307
ADDRLP4 32
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2327
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $2327
address $2311
address $2323
address $2324
address $2326
code
LABELV $2311
line 2994
;2993:		case 0:	// high quality
;2994:			trap_Cvar_SetValue("r_fullScreen", 1);
ADDRGP4 $2312
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2995
;2995:			trap_Cvar_SetValue("r_subdivisions", 4);
ADDRGP4 $2303
ARGP4
CNSTF4 1082130432
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2996
;2996:			trap_Cvar_SetValue("r_vertexlight", 0);
ADDRGP4 $2313
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2997
;2997:			trap_Cvar_SetValue("r_lodbias", 0);
ADDRGP4 $2299
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2998
;2998:			trap_Cvar_SetValue("r_colorbits", 32);
ADDRGP4 $2287
ARGP4
CNSTF4 1107296256
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2999
;2999:			trap_Cvar_SetValue("r_depthbits", 24);
ADDRGP4 $2291
ARGP4
CNSTF4 1103101952
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3000
;3000:			trap_Cvar_SetValue("r_picmip", 0);
ADDRGP4 $2314
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3001
;3001:			trap_Cvar_SetValue("r_mode", 4);
ADDRGP4 $2315
ARGP4
CNSTF4 1082130432
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3002
;3002:			trap_Cvar_SetValue("r_texturebits", 32);
ADDRGP4 $2316
ARGP4
CNSTF4 1107296256
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3003
;3003:			trap_Cvar_SetValue("r_fastSky", 0);
ADDRGP4 $2317
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3004
;3004:			trap_Cvar_SetValue("r_inGameVideo", 1);
ADDRGP4 $2318
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3005
;3005:			trap_Cvar_SetValue("cg_shadows", 1);
ADDRGP4 $2319
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3006
;3006:			trap_Cvar_SetValue("cg_brassTime", 2500);
ADDRGP4 $2320
ARGP4
CNSTF4 1159479296
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3007
;3007:			trap_Cvar_Set("r_texturemode", "GL_LINEAR_MIPMAP_LINEAR");
ADDRGP4 $2321
ARGP4
ADDRGP4 $2322
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3008
;3008:			break;
ADDRGP4 $2307
JUMPV
LABELV $2323
line 3010
;3009:		case 1: // normal 
;3010:			trap_Cvar_SetValue("r_fullScreen", 1);
ADDRGP4 $2312
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3011
;3011:			trap_Cvar_SetValue("r_subdivisions", 12);
ADDRGP4 $2303
ARGP4
CNSTF4 1094713344
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3012
;3012:			trap_Cvar_SetValue("r_vertexlight", 0);
ADDRGP4 $2313
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3013
;3013:			trap_Cvar_SetValue("r_lodbias", 0);
ADDRGP4 $2299
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3014
;3014:			trap_Cvar_SetValue("r_colorbits", 0);
ADDRGP4 $2287
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3015
;3015:			trap_Cvar_SetValue("r_depthbits", 24);
ADDRGP4 $2291
ARGP4
CNSTF4 1103101952
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3016
;3016:			trap_Cvar_SetValue("r_picmip", 1);
ADDRGP4 $2314
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3017
;3017:			trap_Cvar_SetValue("r_mode", 3);
ADDRGP4 $2315
ARGP4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3018
;3018:			trap_Cvar_SetValue("r_texturebits", 0);
ADDRGP4 $2316
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3019
;3019:			trap_Cvar_SetValue("r_fastSky", 0);
ADDRGP4 $2317
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3020
;3020:			trap_Cvar_SetValue("r_inGameVideo", 1);
ADDRGP4 $2318
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3021
;3021:			trap_Cvar_SetValue("cg_brassTime", 2500);
ADDRGP4 $2320
ARGP4
CNSTF4 1159479296
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3022
;3022:			trap_Cvar_Set("r_texturemode", "GL_LINEAR_MIPMAP_LINEAR");
ADDRGP4 $2321
ARGP4
ADDRGP4 $2322
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3023
;3023:			trap_Cvar_SetValue("cg_shadows", 0);
ADDRGP4 $2319
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3024
;3024:			break;
ADDRGP4 $2307
JUMPV
LABELV $2324
line 3026
;3025:		case 2: // fast
;3026:			trap_Cvar_SetValue("r_fullScreen", 1);
ADDRGP4 $2312
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3027
;3027:			trap_Cvar_SetValue("r_subdivisions", 8);
ADDRGP4 $2303
ARGP4
CNSTF4 1090519040
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3028
;3028:			trap_Cvar_SetValue("r_vertexlight", 0);
ADDRGP4 $2313
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3029
;3029:			trap_Cvar_SetValue("r_lodbias", 1);
ADDRGP4 $2299
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3030
;3030:			trap_Cvar_SetValue("r_colorbits", 0);
ADDRGP4 $2287
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3031
;3031:			trap_Cvar_SetValue("r_depthbits", 0);
ADDRGP4 $2291
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3032
;3032:			trap_Cvar_SetValue("r_picmip", 1);
ADDRGP4 $2314
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3033
;3033:			trap_Cvar_SetValue("r_mode", 3);
ADDRGP4 $2315
ARGP4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3034
;3034:			trap_Cvar_SetValue("r_texturebits", 0);
ADDRGP4 $2316
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3035
;3035:			trap_Cvar_SetValue("cg_shadows", 0);
ADDRGP4 $2319
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3036
;3036:			trap_Cvar_SetValue("r_fastSky", 1);
ADDRGP4 $2317
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3037
;3037:			trap_Cvar_SetValue("r_inGameVideo", 0);
ADDRGP4 $2318
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3038
;3038:			trap_Cvar_SetValue("cg_brassTime", 0);
ADDRGP4 $2320
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3039
;3039:			trap_Cvar_Set("r_texturemode", "GL_LINEAR_MIPMAP_NEAREST");
ADDRGP4 $2321
ARGP4
ADDRGP4 $2325
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3040
;3040:			break;
ADDRGP4 $2307
JUMPV
LABELV $2326
line 3042
;3041:		case 3: // fastest
;3042:			trap_Cvar_SetValue("r_fullScreen", 1);
ADDRGP4 $2312
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3043
;3043:			trap_Cvar_SetValue("r_subdivisions", 20);
ADDRGP4 $2303
ARGP4
CNSTF4 1101004800
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3044
;3044:			trap_Cvar_SetValue("r_vertexlight", 1);
ADDRGP4 $2313
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3045
;3045:			trap_Cvar_SetValue("r_lodbias", 2);
ADDRGP4 $2299
ARGP4
CNSTF4 1073741824
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3046
;3046:			trap_Cvar_SetValue("r_colorbits", 16);
ADDRGP4 $2287
ARGP4
CNSTF4 1098907648
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3047
;3047:			trap_Cvar_SetValue("r_depthbits", 16);
ADDRGP4 $2291
ARGP4
CNSTF4 1098907648
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3048
;3048:			trap_Cvar_SetValue("r_mode", 3);
ADDRGP4 $2315
ARGP4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3049
;3049:			trap_Cvar_SetValue("r_picmip", 2);
ADDRGP4 $2314
ARGP4
CNSTF4 1073741824
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3050
;3050:			trap_Cvar_SetValue("r_texturebits", 16);
ADDRGP4 $2316
ARGP4
CNSTF4 1098907648
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3051
;3051:			trap_Cvar_SetValue("cg_shadows", 0);
ADDRGP4 $2319
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3052
;3052:			trap_Cvar_SetValue("cg_brassTime", 0);
ADDRGP4 $2320
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3053
;3053:			trap_Cvar_SetValue("r_fastSky", 1);
ADDRGP4 $2317
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3054
;3054:			trap_Cvar_SetValue("r_inGameVideo", 0);
ADDRGP4 $2318
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3055
;3055:			trap_Cvar_Set("r_texturemode", "GL_LINEAR_MIPMAP_NEAREST");
ADDRGP4 $2321
ARGP4
ADDRGP4 $2325
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3056
;3056:			break;
line 3058
;3057:		}
;3058:	} else if (Q_stricmp(name, "ui_mousePitch") == 0) {
ADDRGP4 $2307
JUMPV
LABELV $2306
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2330
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $2328
line 3059
;3059:		if (val == 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2331
line 3060
;3060:			trap_Cvar_SetValue("m_pitch", 0.022f);
ADDRGP4 $2333
ARGP4
CNSTF4 1018444120
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3061
;3061:		} else {
ADDRGP4 $2332
JUMPV
LABELV $2331
line 3062
;3062:			trap_Cvar_SetValue("m_pitch", -0.022f);
ADDRGP4 $2333
ARGP4
CNSTF4 3165927768
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3063
;3063:		}
LABELV $2332
line 3064
;3064:	}
LABELV $2328
LABELV $2307
LABELV $2298
LABELV $2286
LABELV $2283
LABELV $2273
LABELV $2269
line 3065
;3065:}
LABELV $2267
endproc UI_Update 36 8
proc UI_RunMenuScript 1304 24
line 3067
;3066:
;3067:static void UI_RunMenuScript(char **args) {
line 3071
;3068:	const char *name, *name2;
;3069:	char buff[1024];
;3070:
;3071:	if (String_Parse(args, &name)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1024
ARGP4
ADDRLP4 1032
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
EQI4 $2335
line 3072
;3072:		if (Q_stricmp(name, "StartServer") == 0) {
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2339
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $2337
line 3075
;3073:			int i, clients, oldclients;
;3074:			float skill;
;3075:			trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $383
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3076
;3076:			trap_Cvar_Set("ui_singlePlayerActive", "0");
ADDRGP4 $2200
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3077
;3077:			trap_Cvar_SetValue("dedicated", Com_Clamp(0, 2, ui_dedicated.integer));
CNSTF4 0
ARGF4
CNSTF4 1073741824
ARGF4
ADDRGP4 ui_dedicated+12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 1056
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $2340
ARGP4
ADDRLP4 1056
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3078
;3078:			trap_Cvar_SetValue("g_gametype", Com_Clamp(0, 8, uiInfo.gameTypes[ui_netGameType.integer].gtEnum));
CNSTF4 0
ARGF4
CNSTF4 1090519040
ARGF4
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580+4
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 1060
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $1314
ARGP4
ADDRLP4 1060
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3079
;3079:			trap_Cvar_Set("g_redTeam", UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $689
ARGP4
ADDRLP4 1064
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2215
ARGP4
ADDRLP4 1064
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3080
;3080:			trap_Cvar_Set("g_blueTeam", UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1090
ARGP4
ADDRLP4 1068
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2216
ARGP4
ADDRLP4 1068
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3081
;3081:			trap_Cmd_ExecuteText(EXEC_APPEND, va("wait ; wait ; map %s\n", uiInfo.mapList[ui_currentNetMap.integer].mapLoadName));
ADDRGP4 $2193
ARGP4
ADDRGP4 ui_currentNetMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1072
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1072
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3082
;3082:			skill = trap_Cvar_VariableValue("g_spSkill");
ADDRGP4 $815
ARGP4
ADDRLP4 1076
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1048
ADDRLP4 1076
INDIRF4
ASGNF4
line 3084
;3083:			// set max clients based on spots
;3084:			oldclients = trap_Cvar_VariableValue("sv_maxClients");
ADDRGP4 $2209
ARGP4
ADDRLP4 1080
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1052
ADDRLP4 1080
INDIRF4
CVFI4 4
ASGNI4
line 3085
;3085:			clients = 0;
ADDRLP4 1044
CNSTI4 0
ASGNI4
line 3086
;3086:			for (i = 0; i < PLAYERS_PER_TEAM; i++) {
ADDRLP4 1040
CNSTI4 0
ASGNI4
LABELV $2348
line 3087
;3087:				int bot = trap_Cvar_VariableValue(va("ui_blueteam%i", i + 1));
ADDRGP4 $837
ARGP4
ADDRLP4 1040
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 1088
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1088
INDIRP4
ARGP4
ADDRLP4 1092
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1084
ADDRLP4 1092
INDIRF4
CVFI4 4
ASGNI4
line 3088
;3088:				if (bot >= 0) {
ADDRLP4 1084
INDIRI4
CNSTI4 0
LTI4 $2352
line 3089
;3089:					clients++;
ADDRLP4 1044
ADDRLP4 1044
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3090
;3090:				}
LABELV $2352
line 3091
;3091:				bot = trap_Cvar_VariableValue(va("ui_redteam%i", i + 1));
ADDRGP4 $838
ARGP4
ADDRLP4 1040
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 1096
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1096
INDIRP4
ARGP4
ADDRLP4 1100
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1084
ADDRLP4 1100
INDIRF4
CVFI4 4
ASGNI4
line 3092
;3092:				if (bot >= 0) {
ADDRLP4 1084
INDIRI4
CNSTI4 0
LTI4 $2354
line 3093
;3093:					clients++;
ADDRLP4 1044
ADDRLP4 1044
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3094
;3094:				}
LABELV $2354
line 3095
;3095:			}
LABELV $2349
line 3086
ADDRLP4 1040
ADDRLP4 1040
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 5
LTI4 $2348
line 3096
;3096:			if (clients == 0) {
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $2356
line 3097
;3097:				clients = 8;
ADDRLP4 1044
CNSTI4 8
ASGNI4
line 3098
;3098:			}
LABELV $2356
line 3100
;3099:
;3100:			if (oldclients > clients) {
ADDRLP4 1052
INDIRI4
ADDRLP4 1044
INDIRI4
LEI4 $2358
line 3101
;3101:				clients = oldclients;
ADDRLP4 1044
ADDRLP4 1052
INDIRI4
ASGNI4
line 3102
;3102:			}
LABELV $2358
line 3104
;3103:
;3104:			trap_Cvar_Set("sv_maxClients", va("%d", clients));
ADDRGP4 $704
ARGP4
ADDRLP4 1044
INDIRI4
ARGI4
ADDRLP4 1084
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2209
ARGP4
ADDRLP4 1084
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3106
;3105:
;3106:			for (i = 0; i < PLAYERS_PER_TEAM; i++) {
ADDRLP4 1040
CNSTI4 0
ASGNI4
LABELV $2360
line 3107
;3107:				int bot = trap_Cvar_VariableValue(va("ui_blueteam%i", i + 1));
ADDRGP4 $837
ARGP4
ADDRLP4 1040
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 1092
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1092
INDIRP4
ARGP4
ADDRLP4 1096
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1088
ADDRLP4 1096
INDIRF4
CVFI4 4
ASGNI4
line 3108
;3108:				if (bot > 1) {
ADDRLP4 1088
INDIRI4
CNSTI4 1
LEI4 $2364
line 3109
;3109:					if (ui_actualNetGameType.integer >= GT_TEAM) {
ADDRGP4 ui_actualNetGameType+12
INDIRI4
CNSTI4 3
LTI4 $2366
line 3110
;3110:						Com_sprintf(buff, sizeof(buff), "addbot %s %f %s\n", uiInfo.characterList[bot - 2].name, skill, "Blue");
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2369
ARGP4
ADDRLP4 1088
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448-48
ADDP4
INDIRP4
ARGP4
ADDRLP4 1048
INDIRF4
ARGF4
ADDRGP4 $830
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3111
;3111:					} else {
ADDRGP4 $2367
JUMPV
LABELV $2366
line 3112
;3112:						Com_sprintf(buff, sizeof(buff), "addbot %s %f \n", UI_GetBotNameByNumber(bot - 2), skill);
ADDRLP4 1088
INDIRI4
CNSTI4 2
SUBI4
ARGI4
ADDRLP4 1100
ADDRGP4 UI_GetBotNameByNumber
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2372
ARGP4
ADDRLP4 1100
INDIRP4
ARGP4
ADDRLP4 1048
INDIRF4
ARGF4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3113
;3113:					}
LABELV $2367
line 3114
;3114:					trap_Cmd_ExecuteText(EXEC_APPEND, buff);
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3115
;3115:				}
LABELV $2364
line 3116
;3116:				bot = trap_Cvar_VariableValue(va("ui_redteam%i", i + 1));
ADDRGP4 $838
ARGP4
ADDRLP4 1040
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 1100
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1100
INDIRP4
ARGP4
ADDRLP4 1104
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1088
ADDRLP4 1104
INDIRF4
CVFI4 4
ASGNI4
line 3117
;3117:				if (bot > 1) {
ADDRLP4 1088
INDIRI4
CNSTI4 1
LEI4 $2373
line 3118
;3118:					if (ui_actualNetGameType.integer >= GT_TEAM) {
ADDRGP4 ui_actualNetGameType+12
INDIRI4
CNSTI4 3
LTI4 $2375
line 3119
;3119:						Com_sprintf(buff, sizeof(buff), "addbot %s %f %s\n", uiInfo.characterList[bot - 2].name, skill, "Red");
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2369
ARGP4
ADDRLP4 1088
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448-48
ADDP4
INDIRP4
ARGP4
ADDRLP4 1048
INDIRF4
ARGF4
ADDRGP4 $831
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3120
;3120:					} else {
ADDRGP4 $2376
JUMPV
LABELV $2375
line 3121
;3121:						Com_sprintf(buff, sizeof(buff), "addbot %s %f \n", UI_GetBotNameByNumber(bot - 2), skill);
ADDRLP4 1088
INDIRI4
CNSTI4 2
SUBI4
ARGI4
ADDRLP4 1108
ADDRGP4 UI_GetBotNameByNumber
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2372
ARGP4
ADDRLP4 1108
INDIRP4
ARGP4
ADDRLP4 1048
INDIRF4
ARGF4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3122
;3122:					}
LABELV $2376
line 3123
;3123:					trap_Cmd_ExecuteText(EXEC_APPEND, buff);
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3124
;3124:				}
LABELV $2373
line 3125
;3125:			}
LABELV $2361
line 3106
ADDRLP4 1040
ADDRLP4 1040
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 5
LTI4 $2360
line 3126
;3126:		} else if (Q_stricmp(name, "updateSPMenu") == 0) {
ADDRGP4 $2338
JUMPV
LABELV $2337
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2382
ARGP4
ADDRLP4 1040
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $2380
line 3127
;3127:			UI_SetCapFragLimits(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_SetCapFragLimits
CALLV
pop
line 3128
;3128:			UI_MapCountByGameType(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_MapCountByGameType
CALLI4
pop
line 3129
;3129:			ui_mapIndex.integer = UI_GetIndexFromSelection(ui_currentMap.integer);
ADDRGP4 ui_currentMap+12
INDIRI4
ARGI4
ADDRLP4 1044
ADDRGP4 UI_GetIndexFromSelection
CALLI4
ASGNI4
ADDRGP4 ui_mapIndex+12
ADDRLP4 1044
INDIRI4
ASGNI4
line 3130
;3130:			trap_Cvar_Set("ui_mapIndex", va("%d", ui_mapIndex.integer));
ADDRGP4 $704
ARGP4
ADDRGP4 ui_mapIndex+12
INDIRI4
ARGI4
ADDRLP4 1048
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2187
ARGP4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3131
;3131:			Menu_SetFeederSelection(NULL, FEEDER_MAPS, ui_mapIndex.integer, "skirmish");
CNSTP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 ui_mapIndex+12
INDIRI4
ARGI4
ADDRGP4 $2183
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 3132
;3132:			UI_GameType_HandleKey(0, 0, K_MOUSE1, qfalse);
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
CNSTI4 178
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_GameType_HandleKey
CALLI4
pop
line 3133
;3133:			UI_GameType_HandleKey(0, 0, K_MOUSE2, qfalse);
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
CNSTI4 179
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_GameType_HandleKey
CALLI4
pop
line 3134
;3134:		} else if (Q_stricmp(name, "resetDefaults") == 0) {
ADDRGP4 $2381
JUMPV
LABELV $2380
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2389
ARGP4
ADDRLP4 1044
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $2387
line 3135
;3135:			trap_Cmd_ExecuteText(EXEC_APPEND, "exec default.cfg\n");
CNSTI4 2
ARGI4
ADDRGP4 $2390
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3136
;3136:			trap_Cmd_ExecuteText(EXEC_APPEND, "cvar_restart\n");
CNSTI4 2
ARGI4
ADDRGP4 $2391
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3137
;3137:			Controls_SetDefaults();
ADDRGP4 Controls_SetDefaults
CALLV
pop
line 3138
;3138:			trap_Cvar_Set("com_introPlayed", "1");
ADDRGP4 $2392
ARGP4
ADDRGP4 $386
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3139
;3139:			trap_Cmd_ExecuteText(EXEC_APPEND, "vid_restart\n");
CNSTI4 2
ARGI4
ADDRGP4 $2393
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3140
;3140:		} else if (Q_stricmp(name, "getCDKey") == 0) {
ADDRGP4 $2388
JUMPV
LABELV $2387
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2396
ARGP4
ADDRLP4 1048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $2394
line 3142
;3141:			char out[17];
;3142:			trap_GetCDKey(buff, 17);
ADDRLP4 0
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 trap_GetCDKey
CALLV
pop
line 3143
;3143:			trap_Cvar_Set("cdkey1", "");
ADDRGP4 $2397
ARGP4
ADDRGP4 $110
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3144
;3144:			trap_Cvar_Set("cdkey2", "");
ADDRGP4 $2398
ARGP4
ADDRGP4 $110
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3145
;3145:			trap_Cvar_Set("cdkey3", "");
ADDRGP4 $2399
ARGP4
ADDRGP4 $110
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3146
;3146:			trap_Cvar_Set("cdkey4", "");
ADDRGP4 $2400
ARGP4
ADDRGP4 $110
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3147
;3147:			if (strlen(buff) == CDKEY_LEN) {
ADDRLP4 0
ARGP4
ADDRLP4 1072
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 16
NEI4 $2395
line 3148
;3148:				Q_strncpyz(out, buff, 5);
ADDRLP4 1052
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3149
;3149:				trap_Cvar_Set("cdkey1", out);
ADDRGP4 $2397
ARGP4
ADDRLP4 1052
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3150
;3150:				Q_strncpyz(out, buff + 4, 5);
ADDRLP4 1052
ARGP4
ADDRLP4 0+4
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3151
;3151:				trap_Cvar_Set("cdkey2", out);
ADDRGP4 $2398
ARGP4
ADDRLP4 1052
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3152
;3152:				Q_strncpyz(out, buff + 8, 5);
ADDRLP4 1052
ARGP4
ADDRLP4 0+8
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3153
;3153:				trap_Cvar_Set("cdkey3", out);
ADDRGP4 $2399
ARGP4
ADDRLP4 1052
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3154
;3154:				Q_strncpyz(out, buff + 12, 5);
ADDRLP4 1052
ARGP4
ADDRLP4 0+12
ARGP4
CNSTI4 5
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3155
;3155:				trap_Cvar_Set("cdkey4", out);
ADDRGP4 $2400
ARGP4
ADDRLP4 1052
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3156
;3156:			}
line 3158
;3157:
;3158:		} else if (Q_stricmp(name, "verifyCDKey") == 0) {
ADDRGP4 $2395
JUMPV
LABELV $2394
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2408
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $2406
line 3159
;3159:			buff[0] = '\0';
ADDRLP4 0
CNSTI1 0
ASGNI1
line 3160
;3160:			Q_strcat(buff, 1024, UI_Cvar_VariableString("cdkey1"));
ADDRGP4 $2397
ARGP4
ADDRLP4 1056
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1056
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 3161
;3161:			Q_strcat(buff, 1024, UI_Cvar_VariableString("cdkey2"));
ADDRGP4 $2398
ARGP4
ADDRLP4 1060
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1060
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 3162
;3162:			Q_strcat(buff, 1024, UI_Cvar_VariableString("cdkey3"));
ADDRGP4 $2399
ARGP4
ADDRLP4 1064
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1064
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 3163
;3163:			Q_strcat(buff, 1024, UI_Cvar_VariableString("cdkey4"));
ADDRGP4 $2400
ARGP4
ADDRLP4 1068
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1068
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 3164
;3164:			trap_Cvar_Set("cdkey", buff);
ADDRGP4 $2409
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3165
;3165:			if (trap_VerifyCDKey(buff, UI_Cvar_VariableString("cdkeychecksum"))) {
ADDRGP4 $2412
ARGP4
ADDRLP4 1072
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 1072
INDIRP4
ARGP4
ADDRLP4 1076
ADDRGP4 trap_VerifyCDKey
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
EQI4 $2410
line 3166
;3166:				trap_Cvar_Set("ui_cdkeyvalid", "CD Key Appears to be valid.");
ADDRGP4 $2413
ARGP4
ADDRGP4 $2414
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3167
;3167:				trap_SetCDKey(buff);
ADDRLP4 0
ARGP4
ADDRGP4 trap_SetCDKey
CALLV
pop
line 3168
;3168:			} else {
ADDRGP4 $2407
JUMPV
LABELV $2410
line 3169
;3169:				trap_Cvar_Set("ui_cdkeyvalid", "CD Key does not appear to be valid.");
ADDRGP4 $2413
ARGP4
ADDRGP4 $2415
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3170
;3170:			}
line 3171
;3171:		} else if (Q_stricmp(name, "loadArenas") == 0) {
ADDRGP4 $2407
JUMPV
LABELV $2406
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2418
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $2416
line 3172
;3172:			UI_LoadArenas();
ADDRGP4 UI_LoadArenas
CALLV
pop
line 3173
;3173:			UI_MapCountByGameType(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_MapCountByGameType
CALLI4
pop
line 3174
;3174:			Menu_SetFeederSelection(NULL, FEEDER_ALLMAPS, 0, "createserver");
CNSTP4 0
ARGP4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 $2419
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 3175
;3175:		} else if (Q_stricmp(name, "saveControls") == 0) {
ADDRGP4 $2417
JUMPV
LABELV $2416
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2422
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $2420
line 3176
;3176:			Controls_SetConfig(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 Controls_SetConfig
CALLV
pop
line 3177
;3177:		} else if (Q_stricmp(name, "loadControls") == 0) {
ADDRGP4 $2421
JUMPV
LABELV $2420
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2425
ARGP4
ADDRLP4 1064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $2423
line 3178
;3178:			Controls_GetConfig();
ADDRGP4 Controls_GetConfig
CALLV
pop
line 3179
;3179:		} else if (Q_stricmp(name, "clearError") == 0) {
ADDRGP4 $2424
JUMPV
LABELV $2423
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2428
ARGP4
ADDRLP4 1068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
NEI4 $2426
line 3180
;3180:			trap_Cvar_Set("com_errorMessage", "");
ADDRGP4 $2429
ARGP4
ADDRGP4 $110
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3181
;3181:		} else if (Q_stricmp(name, "loadGameInfo") == 0) {
ADDRGP4 $2427
JUMPV
LABELV $2426
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2432
ARGP4
ADDRLP4 1072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $2430
line 3185
;3182:#ifdef PRE_RELEASE_TADEMO
;3183:			UI_ParseGameInfo("demogameinfo.txt");
;3184:#else
;3185:			UI_ParseGameInfo("gameinfo.txt");
ADDRGP4 $665
ARGP4
ADDRGP4 UI_ParseGameInfo
CALLV
pop
line 3187
;3186:#endif
;3187:			UI_LoadBestScores(uiInfo.mapList[ui_currentMap.integer].mapLoadName, uiInfo.gameTypes[ui_gameType.integer].gtEnum);
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580+4
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_LoadBestScores
CALLV
pop
line 3188
;3188:		} else if (Q_stricmp(name, "resetScores") == 0) {
ADDRGP4 $2431
JUMPV
LABELV $2430
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2441
ARGP4
ADDRLP4 1076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
NEI4 $2439
line 3189
;3189:			UI_ClearScores();
ADDRGP4 UI_ClearScores
CALLV
pop
line 3190
;3190:		} else if (Q_stricmp(name, "RefreshServers") == 0) {
ADDRGP4 $2440
JUMPV
LABELV $2439
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2444
ARGP4
ADDRLP4 1080
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 0
NEI4 $2442
line 3191
;3191:			UI_StartServerRefresh(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_StartServerRefresh
CALLV
pop
line 3192
;3192:			UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 3193
;3193:		} else if (Q_stricmp(name, "RefreshFilter") == 0) {
ADDRGP4 $2443
JUMPV
LABELV $2442
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2447
ARGP4
ADDRLP4 1084
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1084
INDIRI4
CNSTI4 0
NEI4 $2445
line 3194
;3194:			UI_StartServerRefresh(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_StartServerRefresh
CALLV
pop
line 3195
;3195:			UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 3196
;3196:		} else if (Q_stricmp(name, "RunSPDemo") == 0) {
ADDRGP4 $2446
JUMPV
LABELV $2445
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2450
ARGP4
ADDRLP4 1088
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1088
INDIRI4
CNSTI4 0
NEI4 $2448
line 3197
;3197:			if (uiInfo.demoAvailable) {
ADDRGP4 uiInfo+73432
INDIRI4
CNSTI4 0
EQI4 $2449
line 3198
;3198:				trap_Cmd_ExecuteText(EXEC_APPEND, va("demo %s_%i\n", uiInfo.mapList[ui_currentMap.integer].mapLoadName, uiInfo.gameTypes[ui_gameType.integer].gtEnum));
ADDRGP4 $2454
ARGP4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580+4
ADDP4
INDIRI4
ARGI4
ADDRLP4 1092
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1092
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3199
;3199:			}
line 3200
;3200:		} else if (Q_stricmp(name, "LoadDemos") == 0) {
ADDRGP4 $2449
JUMPV
LABELV $2448
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2463
ARGP4
ADDRLP4 1092
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1092
INDIRI4
CNSTI4 0
NEI4 $2461
line 3201
;3201:			UI_LoadDemos();
ADDRGP4 UI_LoadDemos
CALLV
pop
line 3202
;3202:		} else if (Q_stricmp(name, "LoadMovies") == 0) {
ADDRGP4 $2462
JUMPV
LABELV $2461
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2466
ARGP4
ADDRLP4 1096
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1096
INDIRI4
CNSTI4 0
NEI4 $2464
line 3203
;3203:			UI_LoadMovies();
ADDRGP4 UI_LoadMovies
CALLV
pop
line 3204
;3204:		} else if (Q_stricmp(name, "LoadMods") == 0) {
ADDRGP4 $2465
JUMPV
LABELV $2464
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2469
ARGP4
ADDRLP4 1100
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1100
INDIRI4
CNSTI4 0
NEI4 $2467
line 3205
;3205:			UI_LoadMods();
ADDRGP4 UI_LoadMods
CALLV
pop
line 3206
;3206:		} else if (Q_stricmp(name, "playMovie") == 0) {
ADDRGP4 $2468
JUMPV
LABELV $2467
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2472
ARGP4
ADDRLP4 1104
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1104
INDIRI4
CNSTI4 0
NEI4 $2470
line 3207
;3207:			if (uiInfo.previewMovie >= 0) {
ADDRGP4 uiInfo+99260
INDIRI4
CNSTI4 0
LTI4 $2473
line 3208
;3208:				trap_CIN_StopCinematic(uiInfo.previewMovie);
ADDRGP4 uiInfo+99260
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 3209
;3209:			}
LABELV $2473
line 3210
;3210:			trap_Cmd_ExecuteText(EXEC_APPEND, va("cinematic %s.roq 2\n", uiInfo.movieList[uiInfo.movieIndex]));
ADDRGP4 $2477
ARGP4
ADDRGP4 uiInfo+99256
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+98228
ADDP4
INDIRP4
ARGP4
ADDRLP4 1108
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1108
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3211
;3211:		} else if (Q_stricmp(name, "RunMod") == 0) {
ADDRGP4 $2471
JUMPV
LABELV $2470
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2482
ARGP4
ADDRLP4 1108
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 0
NEI4 $2480
line 3212
;3212:			trap_Cvar_Set("fs_game", uiInfo.modList[uiInfo.modIndex].modName);
ADDRGP4 $2483
ARGP4
ADDRGP4 uiInfo+97192
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+96676
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3213
;3213:			trap_Cmd_ExecuteText(EXEC_APPEND, "vid_restart;");
CNSTI4 2
ARGI4
ADDRGP4 $2486
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3214
;3214:		} else if (Q_stricmp(name, "RunDemo") == 0) {
ADDRGP4 $2481
JUMPV
LABELV $2480
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2489
ARGP4
ADDRLP4 1112
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
NEI4 $2487
line 3215
;3215:			trap_Cmd_ExecuteText(EXEC_APPEND, va("demo %s\n", uiInfo.demoList[uiInfo.demoIndex]));
ADDRGP4 $2490
ARGP4
ADDRGP4 uiInfo+98224
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+97196
ADDP4
INDIRP4
ARGP4
ADDRLP4 1116
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1116
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3216
;3216:		} else if (Q_stricmp(name, "Quake3") == 0) {
ADDRGP4 $2488
JUMPV
LABELV $2487
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2495
ARGP4
ADDRLP4 1116
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
NEI4 $2493
line 3217
;3217:			trap_Cvar_Set("fs_game", "");
ADDRGP4 $2483
ARGP4
ADDRGP4 $110
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3218
;3218:			trap_Cmd_ExecuteText(EXEC_APPEND, "vid_restart;");
CNSTI4 2
ARGI4
ADDRGP4 $2486
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3219
;3219:		} else if (Q_stricmp(name, "closeJoin") == 0) {
ADDRGP4 $2494
JUMPV
LABELV $2493
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2498
ARGP4
ADDRLP4 1120
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1120
INDIRI4
CNSTI4 0
NEI4 $2496
line 3220
;3220:			if (uiInfo.serverStatus.refreshActive) {
ADDRGP4 uiInfo+99264+2212
INDIRI4
CNSTI4 0
EQI4 $2499
line 3221
;3221:				UI_StopServerRefresh();
ADDRGP4 UI_StopServerRefresh
CALLV
pop
line 3222
;3222:				uiInfo.serverStatus.nextDisplayRefresh = 0;
ADDRGP4 uiInfo+99264+10420
CNSTI4 0
ASGNI4
line 3223
;3223:				uiInfo.nextServerStatusRefresh = 0;
ADDRGP4 uiInfo+114144
CNSTI4 0
ASGNI4
line 3224
;3224:				uiInfo.nextFindPlayerRefresh = 0;
ADDRGP4 uiInfo+119472
CNSTI4 0
ASGNI4
line 3225
;3225:				UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 3226
;3226:			} else {
ADDRGP4 $2497
JUMPV
LABELV $2499
line 3227
;3227:				Menus_CloseByName("joinserver");
ADDRGP4 $2507
ARGP4
ADDRGP4 Menus_CloseByName
CALLV
pop
line 3228
;3228:				Menus_OpenByName("main");
ADDRGP4 $2508
ARGP4
ADDRGP4 Menus_OpenByName
CALLV
pop
line 3229
;3229:			}
line 3230
;3230:		} else if (Q_stricmp(name, "StopRefresh") == 0) {
ADDRGP4 $2497
JUMPV
LABELV $2496
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2511
ARGP4
ADDRLP4 1124
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1124
INDIRI4
CNSTI4 0
NEI4 $2509
line 3231
;3231:			UI_StopServerRefresh();
ADDRGP4 UI_StopServerRefresh
CALLV
pop
line 3232
;3232:			uiInfo.serverStatus.nextDisplayRefresh = 0;
ADDRGP4 uiInfo+99264+10420
CNSTI4 0
ASGNI4
line 3233
;3233:			uiInfo.nextServerStatusRefresh = 0;
ADDRGP4 uiInfo+114144
CNSTI4 0
ASGNI4
line 3234
;3234:			uiInfo.nextFindPlayerRefresh = 0;
ADDRGP4 uiInfo+119472
CNSTI4 0
ASGNI4
line 3235
;3235:		} else if (Q_stricmp(name, "UpdateFilter") == 0) {
ADDRGP4 $2510
JUMPV
LABELV $2509
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2518
ARGP4
ADDRLP4 1128
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1128
INDIRI4
CNSTI4 0
NEI4 $2516
line 3236
;3236:			if (ui_netSource.integer == AS_LOCAL) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
NEI4 $2519
line 3237
;3237:				UI_StartServerRefresh(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_StartServerRefresh
CALLV
pop
line 3238
;3238:			}
LABELV $2519
line 3239
;3239:			UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 3240
;3240:			UI_FeederSelection(FEEDER_SERVERS, 0);
CNSTF4 1073741824
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 UI_FeederSelection
CALLV
pop
line 3241
;3241:		} else if (Q_stricmp(name, "ServerStatus") == 0) {
ADDRGP4 $2517
JUMPV
LABELV $2516
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2524
ARGP4
ADDRLP4 1132
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1132
INDIRI4
CNSTI4 0
NEI4 $2522
line 3242
;3242:			trap_LAN_GetServerAddressString(ui_netSource.integer, uiInfo.serverStatus.displayServers[uiInfo.serverStatus.currentServer], uiInfo.serverStatusAddress, sizeof(uiInfo.serverStatusAddress));
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+99264+2216
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99264+2220
ADDP4
INDIRI4
ARGI4
ADDRGP4 uiInfo+110748
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_LAN_GetServerAddressString
CALLV
pop
line 3243
;3243:			UI_BuildServerStatus(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerStatus
CALLV
pop
line 3244
;3244:		} else if (Q_stricmp(name, "FoundPlayerServerStatus") == 0) {
ADDRGP4 $2523
JUMPV
LABELV $2522
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2534
ARGP4
ADDRLP4 1136
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1136
INDIRI4
CNSTI4 0
NEI4 $2532
line 3245
;3245:			Q_strncpyz(uiInfo.serverStatusAddress, uiInfo.foundPlayerServerAddresses[uiInfo.currentFoundPlayerServer], sizeof(uiInfo.serverStatusAddress));
ADDRGP4 uiInfo+110748
ARGP4
ADDRGP4 uiInfo+119464
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+117416
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3246
;3246:			UI_BuildServerStatus(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerStatus
CALLV
pop
line 3247
;3247:			Menu_SetFeederSelection(NULL, FEEDER_FINDPLAYER, 0, NULL);
CNSTP4 0
ARGP4
CNSTI4 14
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 3248
;3248:		} else if (Q_stricmp(name, "FindPlayer") == 0) {
ADDRGP4 $2533
JUMPV
LABELV $2532
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2541
ARGP4
ADDRLP4 1140
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1140
INDIRI4
CNSTI4 0
NEI4 $2539
line 3249
;3249:			UI_BuildFindPlayerList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildFindPlayerList
CALLV
pop
line 3251
;3250:			// clear the displayed server status info
;3251:			uiInfo.serverStatusInfo.numLines = 0;
ADDRGP4 uiInfo+110812+3328
CNSTI4 0
ASGNI4
line 3252
;3252:			Menu_SetFeederSelection(NULL, FEEDER_FINDPLAYER, 0, NULL);
CNSTP4 0
ARGP4
CNSTI4 14
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 3253
;3253:		} else if (Q_stricmp(name, "JoinServer") == 0) {
ADDRGP4 $2540
JUMPV
LABELV $2539
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2546
ARGP4
ADDRLP4 1144
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1144
INDIRI4
CNSTI4 0
NEI4 $2544
line 3254
;3254:			trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $383
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3255
;3255:			trap_Cvar_Set("ui_singlePlayerActive", "0");
ADDRGP4 $2200
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3256
;3256:			if (uiInfo.serverStatus.currentServer >= 0 && uiInfo.serverStatus.currentServer < uiInfo.serverStatus.numDisplayServers) {
ADDRGP4 uiInfo+99264+2216
INDIRI4
CNSTI4 0
LTI4 $2545
ADDRGP4 uiInfo+99264+2216
INDIRI4
ADDRGP4 uiInfo+99264+10412
INDIRI4
GEI4 $2545
line 3257
;3257:				trap_LAN_GetServerAddressString(ui_netSource.integer, uiInfo.serverStatus.displayServers[uiInfo.serverStatus.currentServer], buff, 1024);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+99264+2216
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99264+2220
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerAddressString
CALLV
pop
line 3258
;3258:				trap_Cmd_ExecuteText(EXEC_APPEND, va("connect %s\n", buff));
ADDRGP4 $2560
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1148
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1148
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3259
;3259:			}
line 3260
;3260:		} else if (Q_stricmp(name, "FoundPlayerJoinServer") == 0) {
ADDRGP4 $2545
JUMPV
LABELV $2544
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2563
ARGP4
ADDRLP4 1148
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1148
INDIRI4
CNSTI4 0
NEI4 $2561
line 3261
;3261:			trap_Cvar_Set("ui_singlePlayerActive", "0");
ADDRGP4 $2200
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3262
;3262:			if (uiInfo.currentFoundPlayerServer >= 0 && uiInfo.currentFoundPlayerServer < uiInfo.numFoundPlayerServers) {
ADDRGP4 uiInfo+119464
INDIRI4
CNSTI4 0
LTI4 $2562
ADDRGP4 uiInfo+119464
INDIRI4
ADDRGP4 uiInfo+119468
INDIRI4
GEI4 $2562
line 3263
;3263:				trap_Cmd_ExecuteText(EXEC_APPEND, va("connect %s\n", uiInfo.foundPlayerServerAddresses[uiInfo.currentFoundPlayerServer]));
ADDRGP4 $2560
ARGP4
ADDRGP4 uiInfo+119464
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+117416
ADDP4
ARGP4
ADDRLP4 1152
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1152
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3264
;3264:			}
line 3265
;3265:		} else if (Q_stricmp(name, "Quit") == 0) {
ADDRGP4 $2562
JUMPV
LABELV $2561
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2573
ARGP4
ADDRLP4 1152
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1152
INDIRI4
CNSTI4 0
NEI4 $2571
line 3266
;3266:			trap_Cvar_Set("ui_singlePlayerActive", "0");
ADDRGP4 $2200
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3267
;3267:			trap_Cmd_ExecuteText(EXEC_NOW, "quit");
CNSTI4 0
ARGI4
ADDRGP4 $2574
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3268
;3268:		} else if (Q_stricmp(name, "Controls") == 0) {
ADDRGP4 $2572
JUMPV
LABELV $2571
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2577
ARGP4
ADDRLP4 1156
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1156
INDIRI4
CNSTI4 0
NEI4 $2575
line 3269
;3269:			trap_Cvar_Set("cl_paused", "1");
ADDRGP4 $2578
ARGP4
ADDRGP4 $386
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3270
;3270:			trap_Key_SetCatcher(KEYCATCH_UI);
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 3271
;3271:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 3272
;3272:			Menus_ActivateByName("setup_menu2");
ADDRGP4 $2579
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 3273
;3273:		} else if (Q_stricmp(name, "Leave") == 0) {
ADDRGP4 $2576
JUMPV
LABELV $2575
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2582
ARGP4
ADDRLP4 1160
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1160
INDIRI4
CNSTI4 0
NEI4 $2580
line 3274
;3274:			trap_Cmd_ExecuteText(EXEC_APPEND, "disconnect\n");
CNSTI4 2
ARGI4
ADDRGP4 $2583
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3275
;3275:			trap_Key_SetCatcher(KEYCATCH_UI);
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 3276
;3276:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 3277
;3277:			Menus_ActivateByName("main");
ADDRGP4 $2508
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 3278
;3278:		} else if (Q_stricmp(name, "ServerSort") == 0) {
ADDRGP4 $2581
JUMPV
LABELV $2580
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2586
ARGP4
ADDRLP4 1164
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1164
INDIRI4
CNSTI4 0
NEI4 $2584
line 3280
;3279:			int sortColumn;
;3280:			if (Int_Parse(args, &sortColumn)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1168
ARGP4
ADDRLP4 1172
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 1172
INDIRI4
CNSTI4 0
EQI4 $2585
line 3282
;3281:				// if same column we're already sorting on then flip the direction
;3282:				if (sortColumn == uiInfo.serverStatus.sortKey) {
ADDRLP4 1168
INDIRI4
ADDRGP4 uiInfo+99264+2200
INDIRI4
NEI4 $2589
line 3283
;3283:					uiInfo.serverStatus.sortDir = !uiInfo.serverStatus.sortDir;
ADDRGP4 uiInfo+99264+2204
INDIRI4
CNSTI4 0
NEI4 $2598
ADDRLP4 1176
CNSTI4 1
ASGNI4
ADDRGP4 $2599
JUMPV
LABELV $2598
ADDRLP4 1176
CNSTI4 0
ASGNI4
LABELV $2599
ADDRGP4 uiInfo+99264+2204
ADDRLP4 1176
INDIRI4
ASGNI4
line 3284
;3284:				}
LABELV $2589
line 3286
;3285:				// make sure we sort again
;3286:				UI_ServersSort(sortColumn, qtrue);
ADDRLP4 1168
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 UI_ServersSort
CALLV
pop
line 3287
;3287:			}
line 3288
;3288:		} else if (Q_stricmp(name, "nextSkirmish") == 0) {
ADDRGP4 $2585
JUMPV
LABELV $2584
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2602
ARGP4
ADDRLP4 1168
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1168
INDIRI4
CNSTI4 0
NEI4 $2600
line 3289
;3289:			UI_StartSkirmish(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_StartSkirmish
CALLV
pop
line 3290
;3290:		} else if (Q_stricmp(name, "SkirmishStart") == 0) {
ADDRGP4 $2601
JUMPV
LABELV $2600
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2605
ARGP4
ADDRLP4 1172
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1172
INDIRI4
CNSTI4 0
NEI4 $2603
line 3291
;3291:			UI_StartSkirmish(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_StartSkirmish
CALLV
pop
line 3292
;3292:		} else if (Q_stricmp(name, "closeingame") == 0) {
ADDRGP4 $2604
JUMPV
LABELV $2603
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2608
ARGP4
ADDRLP4 1176
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1176
INDIRI4
CNSTI4 0
NEI4 $2606
line 3293
;3293:			trap_Key_SetCatcher(trap_Key_GetCatcher() & ~KEYCATCH_UI);
ADDRLP4 1180
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 1180
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 3294
;3294:			trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 3295
;3295:			trap_Cvar_Set("cl_paused", "0");
ADDRGP4 $2578
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3296
;3296:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 3297
;3297:		} else if (Q_stricmp(name, "voteMap") == 0) {
ADDRGP4 $2607
JUMPV
LABELV $2606
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2611
ARGP4
ADDRLP4 1180
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1180
INDIRI4
CNSTI4 0
NEI4 $2609
line 3298
;3298:			if (ui_currentNetMap.integer >= 0 && ui_currentNetMap.integer < uiInfo.mapCount) {
ADDRGP4 ui_currentNetMap+12
INDIRI4
CNSTI4 0
LTI4 $2610
ADDRGP4 ui_currentNetMap+12
INDIRI4
ADDRGP4 uiInfo+83224
INDIRI4
GEI4 $2610
line 3299
;3299:				trap_Cmd_ExecuteText(EXEC_APPEND, va("callvote map %s\n", uiInfo.mapList[ui_currentNetMap.integer].mapLoadName));
ADDRGP4 $2617
ARGP4
ADDRGP4 ui_currentNetMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1184
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1184
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3300
;3300:			}
line 3301
;3301:		} else if (Q_stricmp(name, "voteKick") == 0) {
ADDRGP4 $2610
JUMPV
LABELV $2609
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2623
ARGP4
ADDRLP4 1184
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1184
INDIRI4
CNSTI4 0
NEI4 $2621
line 3302
;3302:			if (uiInfo.playerIndex >= 0 && uiInfo.playerIndex < uiInfo.playerCount) {
ADDRGP4 uiInfo+78860
INDIRI4
CNSTI4 0
LTI4 $2622
ADDRGP4 uiInfo+78860
INDIRI4
ADDRGP4 uiInfo+78844
INDIRI4
GEI4 $2622
line 3303
;3303:				trap_Cmd_ExecuteText(EXEC_APPEND, va("callvote kick %s\n", uiInfo.playerNames[uiInfo.playerIndex]));
ADDRGP4 $2629
ARGP4
ADDRGP4 uiInfo+78860
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+78872
ADDP4
ARGP4
ADDRLP4 1188
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1188
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3304
;3304:			}
line 3305
;3305:		} else if (Q_stricmp(name, "voteGame") == 0) {
ADDRGP4 $2622
JUMPV
LABELV $2621
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2634
ARGP4
ADDRLP4 1188
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1188
INDIRI4
CNSTI4 0
NEI4 $2632
line 3306
;3306:			if (ui_netGameType.integer >= 0 && ui_netGameType.integer < uiInfo.numGameTypes) {
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 0
LTI4 $2633
ADDRGP4 ui_netGameType+12
INDIRI4
ADDRGP4 uiInfo+78576
INDIRI4
GEI4 $2633
line 3307
;3307:				trap_Cmd_ExecuteText(EXEC_APPEND, va("callvote g_gametype %i\n", uiInfo.gameTypes[ui_netGameType.integer].gtEnum));
ADDRGP4 $2640
ARGP4
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580+4
ADDP4
INDIRI4
ARGI4
ADDRLP4 1192
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1192
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3308
;3308:			}
line 3309
;3309:		} else if (Q_stricmp(name, "voteLeader") == 0) {
ADDRGP4 $2633
JUMPV
LABELV $2632
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2646
ARGP4
ADDRLP4 1192
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1192
INDIRI4
CNSTI4 0
NEI4 $2644
line 3311
;3310:
;3311:		} else if (Q_stricmp(name, "addBot") == 0) {
ADDRGP4 $2645
JUMPV
LABELV $2644
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2649
ARGP4
ADDRLP4 1196
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1196
INDIRI4
CNSTI4 0
NEI4 $2647
line 3312
;3312:			if (trap_Cvar_VariableValue("g_gametype") >= GT_TEAM) {
ADDRGP4 $1314
ARGP4
ADDRLP4 1200
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1200
INDIRF4
CNSTF4 1077936128
LTF4 $2650
line 3313
;3313:				trap_Cmd_ExecuteText(EXEC_APPEND, va("addbot %s %i %s\n", uiInfo.characterList[uiInfo.botIndex].name, uiInfo.skillIndex + 1, (uiInfo.redBlue == 0) ? "Red" : "Blue"));
ADDRGP4 $2652
ARGP4
ADDRGP4 uiInfo+73444
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448
ADDP4
INDIRP4
ARGP4
ADDRGP4 uiInfo+96672
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 uiInfo+78840
INDIRI4
CNSTI4 0
NEI4 $2658
ADDRLP4 1204
ADDRGP4 $831
ASGNP4
ADDRGP4 $2659
JUMPV
LABELV $2658
ADDRLP4 1204
ADDRGP4 $830
ASGNP4
LABELV $2659
ADDRLP4 1204
INDIRP4
ARGP4
ADDRLP4 1208
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1208
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3314
;3314:			} else {
ADDRGP4 $2648
JUMPV
LABELV $2650
line 3315
;3315:				trap_Cmd_ExecuteText(EXEC_APPEND, va("addbot %s %i %s\n", UI_GetBotNameByNumber(uiInfo.botIndex), uiInfo.skillIndex + 1, (uiInfo.redBlue == 0) ? "Red" : "Blue"));
ADDRGP4 uiInfo+73444
INDIRI4
ARGI4
ADDRLP4 1208
ADDRGP4 UI_GetBotNameByNumber
CALLP4
ASGNP4
ADDRGP4 $2652
ARGP4
ADDRLP4 1208
INDIRP4
ARGP4
ADDRGP4 uiInfo+96672
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 uiInfo+78840
INDIRI4
CNSTI4 0
NEI4 $2664
ADDRLP4 1204
ADDRGP4 $831
ASGNP4
ADDRGP4 $2665
JUMPV
LABELV $2664
ADDRLP4 1204
ADDRGP4 $830
ASGNP4
LABELV $2665
ADDRLP4 1204
INDIRP4
ARGP4
ADDRLP4 1212
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1212
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3316
;3316:			}
line 3317
;3317:		} else if (Q_stricmp(name, "addFavorite") == 0) {
ADDRGP4 $2648
JUMPV
LABELV $2647
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2668
ARGP4
ADDRLP4 1200
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1200
INDIRI4
CNSTI4 0
NEI4 $2666
line 3318
;3318:			if (ui_netSource.integer != AS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 3
EQI4 $2667
line 3323
;3319:				char name[MAX_NAME_LENGTH];
;3320:				char addr[MAX_NAME_LENGTH];
;3321:				int res;
;3322:
;3323:				trap_LAN_GetServerInfo(ui_netSource.integer, uiInfo.serverStatus.displayServers[uiInfo.serverStatus.currentServer], buff, MAX_STRING_CHARS);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+99264+2216
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99264+2220
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerInfo
CALLV
pop
line 3324
;3324:				name[0] = addr[0] = '\0';
ADDRLP4 1272
CNSTI1 0
ASGNI1
ADDRLP4 1204
ADDRLP4 1272
INDIRI1
ASGNI1
ADDRLP4 1236
ADDRLP4 1272
INDIRI1
ASGNI1
line 3325
;3325:				Q_strncpyz(name, Info_ValueForKey(buff, "hostname"), MAX_NAME_LENGTH);
ADDRLP4 0
ARGP4
ADDRGP4 $2677
ARGP4
ADDRLP4 1276
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1236
ARGP4
ADDRLP4 1276
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3326
;3326:				Q_strncpyz(addr, Info_ValueForKey(buff, "addr"), MAX_NAME_LENGTH);
ADDRLP4 0
ARGP4
ADDRGP4 $2678
ARGP4
ADDRLP4 1280
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1204
ARGP4
ADDRLP4 1280
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3327
;3327:				if (strlen(name) > 0 && strlen(addr) > 0) {
ADDRLP4 1236
ARGP4
ADDRLP4 1284
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1284
INDIRI4
CNSTI4 0
LEI4 $2667
ADDRLP4 1204
ARGP4
ADDRLP4 1288
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1288
INDIRI4
CNSTI4 0
LEI4 $2667
line 3328
;3328:					res = trap_LAN_AddServer(AS_FAVORITES, name, addr);
CNSTI4 3
ARGI4
ADDRLP4 1236
ARGP4
ADDRLP4 1204
ARGP4
ADDRLP4 1292
ADDRGP4 trap_LAN_AddServer
CALLI4
ASGNI4
ADDRLP4 1268
ADDRLP4 1292
INDIRI4
ASGNI4
line 3329
;3329:					if (res == 0) {
ADDRLP4 1268
INDIRI4
CNSTI4 0
NEI4 $2681
line 3331
;3330:						// server already in the list
;3331:						Com_Printf("Favorite already in list\n");
ADDRGP4 $2683
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 3332
;3332:					} else if (res == -1) {
ADDRGP4 $2667
JUMPV
LABELV $2681
ADDRLP4 1268
INDIRI4
CNSTI4 -1
NEI4 $2684
line 3334
;3333:						// list full
;3334:						Com_Printf("Favorite list full\n");
ADDRGP4 $2686
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 3335
;3335:					} else {
ADDRGP4 $2667
JUMPV
LABELV $2684
line 3337
;3336:						// successfully added
;3337:						Com_Printf("Added favorite server %s\n", addr);
ADDRGP4 $2687
ARGP4
ADDRLP4 1204
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 3338
;3338:					}
line 3339
;3339:				}
line 3340
;3340:			}
line 3341
;3341:		} else if (Q_stricmp(name, "deleteFavorite") == 0) {
ADDRGP4 $2667
JUMPV
LABELV $2666
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2690
ARGP4
ADDRLP4 1204
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1204
INDIRI4
CNSTI4 0
NEI4 $2688
line 3342
;3342:			if (ui_netSource.integer == AS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 3
NEI4 $2689
line 3344
;3343:				char addr[MAX_NAME_LENGTH];
;3344:				trap_LAN_GetServerInfo(ui_netSource.integer, uiInfo.serverStatus.displayServers[uiInfo.serverStatus.currentServer], buff, MAX_STRING_CHARS);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+99264+2216
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99264+2220
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerInfo
CALLV
pop
line 3345
;3345:				addr[0] = '\0';
ADDRLP4 1208
CNSTI1 0
ASGNI1
line 3346
;3346:				Q_strncpyz(addr, Info_ValueForKey(buff, "addr"), MAX_NAME_LENGTH);
ADDRLP4 0
ARGP4
ADDRGP4 $2678
ARGP4
ADDRLP4 1240
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1208
ARGP4
ADDRLP4 1240
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3347
;3347:				if (strlen(addr) > 0) {
ADDRLP4 1208
ARGP4
ADDRLP4 1244
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1244
INDIRI4
CNSTI4 0
LEI4 $2689
line 3348
;3348:					trap_LAN_RemoveServer(AS_FAVORITES, addr);
CNSTI4 3
ARGI4
ADDRLP4 1208
ARGP4
ADDRGP4 trap_LAN_RemoveServer
CALLV
pop
line 3349
;3349:				}
line 3350
;3350:			}
line 3351
;3351:		} else if (Q_stricmp(name, "createFavorite") == 0) {
ADDRGP4 $2689
JUMPV
LABELV $2688
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2703
ARGP4
ADDRLP4 1208
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1208
INDIRI4
CNSTI4 0
NEI4 $2701
line 3352
;3352:			if (ui_netSource.integer == AS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 3
NEI4 $2702
line 3357
;3353:				char name[MAX_NAME_LENGTH];
;3354:				char addr[MAX_NAME_LENGTH];
;3355:				int res;
;3356:
;3357:				name[0] = addr[0] = '\0';
ADDRLP4 1280
CNSTI1 0
ASGNI1
ADDRLP4 1212
ADDRLP4 1280
INDIRI1
ASGNI1
ADDRLP4 1244
ADDRLP4 1280
INDIRI1
ASGNI1
line 3358
;3358:				Q_strncpyz(name, UI_Cvar_VariableString("ui_favoriteName"), MAX_NAME_LENGTH);
ADDRGP4 $2707
ARGP4
ADDRLP4 1284
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 1244
ARGP4
ADDRLP4 1284
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3359
;3359:				Q_strncpyz(addr, UI_Cvar_VariableString("ui_favoriteAddress"), MAX_NAME_LENGTH);
ADDRGP4 $2708
ARGP4
ADDRLP4 1288
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 1212
ARGP4
ADDRLP4 1288
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3360
;3360:				if (strlen(name) > 0 && strlen(addr) > 0) {
ADDRLP4 1244
ARGP4
ADDRLP4 1292
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1292
INDIRI4
CNSTI4 0
LEI4 $2702
ADDRLP4 1212
ARGP4
ADDRLP4 1296
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1296
INDIRI4
CNSTI4 0
LEI4 $2702
line 3361
;3361:					res = trap_LAN_AddServer(AS_FAVORITES, name, addr);
CNSTI4 3
ARGI4
ADDRLP4 1244
ARGP4
ADDRLP4 1212
ARGP4
ADDRLP4 1300
ADDRGP4 trap_LAN_AddServer
CALLI4
ASGNI4
ADDRLP4 1276
ADDRLP4 1300
INDIRI4
ASGNI4
line 3362
;3362:					if (res == 0) {
ADDRLP4 1276
INDIRI4
CNSTI4 0
NEI4 $2711
line 3364
;3363:						// server already in the list
;3364:						Com_Printf("Favorite already in list\n");
ADDRGP4 $2683
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 3365
;3365:					} else if (res == -1) {
ADDRGP4 $2702
JUMPV
LABELV $2711
ADDRLP4 1276
INDIRI4
CNSTI4 -1
NEI4 $2713
line 3367
;3366:						// list full
;3367:						Com_Printf("Favorite list full\n");
ADDRGP4 $2686
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 3368
;3368:					} else {
ADDRGP4 $2702
JUMPV
LABELV $2713
line 3370
;3369:						// successfully added
;3370:						Com_Printf("Added favorite server %s\n", addr);
ADDRGP4 $2687
ARGP4
ADDRLP4 1212
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 3371
;3371:					}
line 3372
;3372:				}
line 3373
;3373:			}
line 3374
;3374:		} else if (Q_stricmp(name, "orders") == 0) {
ADDRGP4 $2702
JUMPV
LABELV $2701
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2717
ARGP4
ADDRLP4 1212
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1212
INDIRI4
CNSTI4 0
NEI4 $2715
line 3376
;3375:			const char *orders;
;3376:			if (String_Parse(args, &orders)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1216
ARGP4
ADDRLP4 1220
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1220
INDIRI4
CNSTI4 0
EQI4 $2716
line 3377
;3377:				int selectedPlayer = trap_Cvar_VariableValue("cg_selectedPlayer");
ADDRGP4 $1382
ARGP4
ADDRLP4 1228
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1224
ADDRLP4 1228
INDIRF4
CVFI4 4
ASGNI4
line 3378
;3378:				if (selectedPlayer < uiInfo.myTeamCount) {
ADDRLP4 1224
INDIRI4
ADDRGP4 uiInfo+78848
INDIRI4
GEI4 $2720
line 3379
;3379:					strcpy(buff, orders);
ADDRLP4 0
ARGP4
ADDRLP4 1216
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 3380
;3380:					trap_Cmd_ExecuteText(EXEC_APPEND, va(buff, uiInfo.teamClientNums[selectedPlayer]));
ADDRLP4 0
ARGP4
ADDRLP4 1224
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+82968
ADDP4
INDIRI4
ARGI4
ADDRLP4 1232
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1232
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3381
;3381:					trap_Cmd_ExecuteText(EXEC_APPEND, "\n");
CNSTI4 2
ARGI4
ADDRGP4 $2724
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3382
;3382:				} else {
ADDRGP4 $2721
JUMPV
LABELV $2720
line 3384
;3383:					int i;
;3384:					for (i = 0; i < uiInfo.myTeamCount; i++) {
ADDRLP4 1232
CNSTI4 0
ASGNI4
ADDRGP4 $2728
JUMPV
LABELV $2725
line 3385
;3385:						if (Q_stricmp(UI_Cvar_VariableString("name"), uiInfo.teamNames[i]) == 0) {
ADDRGP4 $1400
ARGP4
ADDRLP4 1236
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 1236
INDIRP4
ARGP4
ADDRLP4 1232
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+80920
ADDP4
ARGP4
ADDRLP4 1240
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1240
INDIRI4
CNSTI4 0
NEI4 $2730
line 3386
;3386:							continue;
ADDRGP4 $2726
JUMPV
LABELV $2730
line 3388
;3387:						}
;3388:						strcpy(buff, orders);
ADDRLP4 0
ARGP4
ADDRLP4 1216
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 3389
;3389:						trap_Cmd_ExecuteText(EXEC_APPEND, va(buff, uiInfo.teamNames[i]));
ADDRLP4 0
ARGP4
ADDRLP4 1232
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+80920
ADDP4
ARGP4
ADDRLP4 1244
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1244
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3390
;3390:						trap_Cmd_ExecuteText(EXEC_APPEND, "\n");
CNSTI4 2
ARGI4
ADDRGP4 $2724
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3391
;3391:					}
LABELV $2726
line 3384
ADDRLP4 1232
ADDRLP4 1232
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2728
ADDRLP4 1232
INDIRI4
ADDRGP4 uiInfo+78848
INDIRI4
LTI4 $2725
line 3392
;3392:				}
LABELV $2721
line 3393
;3393:				trap_Key_SetCatcher(trap_Key_GetCatcher() & ~KEYCATCH_UI);
ADDRLP4 1232
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 1232
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 3394
;3394:				trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 3395
;3395:				trap_Cvar_Set("cl_paused", "0");
ADDRGP4 $2578
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3396
;3396:				Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 3397
;3397:			}
line 3398
;3398:		} else if (Q_stricmp(name, "voiceOrdersTeam") == 0) {
ADDRGP4 $2716
JUMPV
LABELV $2715
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2736
ARGP4
ADDRLP4 1216
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1216
INDIRI4
CNSTI4 0
NEI4 $2734
line 3400
;3399:
;3400:		} else if (Q_stricmp(name, "voiceOrders") == 0) {
ADDRGP4 $2735
JUMPV
LABELV $2734
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2739
ARGP4
ADDRLP4 1220
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1220
INDIRI4
CNSTI4 0
NEI4 $2737
line 3402
;3401:
;3402:		} else if (Q_stricmp(name, "glCustom") == 0) {
ADDRGP4 $2738
JUMPV
LABELV $2737
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2742
ARGP4
ADDRLP4 1224
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1224
INDIRI4
CNSTI4 0
NEI4 $2740
line 3403
;3403:			trap_Cvar_Set("ui_glCustom", "4");
ADDRGP4 $2308
ARGP4
ADDRGP4 $2743
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3404
;3404:		} else if (Q_stricmp(name, "update") == 0) {
ADDRGP4 $2741
JUMPV
LABELV $2740
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2746
ARGP4
ADDRLP4 1228
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1228
INDIRI4
CNSTI4 0
NEI4 $2744
line 3405
;3405:			if (String_Parse(args, &name2)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1028
ARGP4
ADDRLP4 1232
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1232
INDIRI4
CNSTI4 0
EQI4 $2745
line 3406
;3406:				UI_Update(name2);
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 UI_Update
CALLV
pop
line 3407
;3407:			}
line 3408
;3408:		} else if (Q_stricmp(name, "setPbClStatus") == 0) {
ADDRGP4 $2745
JUMPV
LABELV $2744
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2751
ARGP4
ADDRLP4 1232
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1232
INDIRI4
CNSTI4 0
NEI4 $2749
line 3410
;3409:			int stat;
;3410:			if (Int_Parse(args, &stat))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1236
ARGP4
ADDRLP4 1240
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 1240
INDIRI4
CNSTI4 0
EQI4 $2750
line 3411
;3411:				trap_SetPbClStatus(stat);
ADDRLP4 1236
INDIRI4
ARGI4
ADDRGP4 trap_SetPbClStatus
CALLV
pop
line 3412
;3412:		} else {
ADDRGP4 $2750
JUMPV
LABELV $2749
line 3413
;3413:			Com_Printf("unknown UI script %s\n", name);
ADDRGP4 $2754
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 3414
;3414:		}
LABELV $2750
LABELV $2745
LABELV $2741
LABELV $2738
LABELV $2735
LABELV $2716
LABELV $2702
LABELV $2689
LABELV $2667
LABELV $2648
LABELV $2645
LABELV $2633
LABELV $2622
LABELV $2610
LABELV $2607
LABELV $2604
LABELV $2601
LABELV $2585
LABELV $2581
LABELV $2576
LABELV $2572
LABELV $2562
LABELV $2545
LABELV $2540
LABELV $2533
LABELV $2523
LABELV $2517
LABELV $2510
LABELV $2497
LABELV $2494
LABELV $2488
LABELV $2481
LABELV $2471
LABELV $2468
LABELV $2465
LABELV $2462
LABELV $2449
LABELV $2446
LABELV $2443
LABELV $2440
LABELV $2431
LABELV $2427
LABELV $2424
LABELV $2421
LABELV $2417
LABELV $2407
LABELV $2395
LABELV $2388
LABELV $2381
LABELV $2338
line 3415
;3415:	}
LABELV $2335
line 3416
;3416:}
LABELV $2334
endproc UI_RunMenuScript 1304 24
proc UI_GetTeamColor 0 0
line 3418
;3417:
;3418:static void UI_GetTeamColor(vec4_t *color) {}
LABELV $2755
endproc UI_GetTeamColor 0 0
proc UI_MapCountByGameType 16 0
line 3425
;3419:
;3420:/*
;3421:==================
;3422:UI_MapCountByGameType
;3423:==================
;3424:*/
;3425:static int UI_MapCountByGameType(qboolean singlePlayer) {
line 3427
;3426:	int i, c, game;
;3427:	c = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 3428
;3428:	game = singlePlayer ? uiInfo.gameTypes[ui_gameType.integer].gtEnum : uiInfo.gameTypes[ui_netGameType.integer].gtEnum;
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $2764
ADDRLP4 12
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580+4
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $2765
JUMPV
LABELV $2764
ADDRLP4 12
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580+4
ADDP4
INDIRI4
ASGNI4
LABELV $2765
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 3429
;3429:	if (game == GT_SINGLE_PLAYER) {
ADDRLP4 4
INDIRI4
CNSTI4 2
NEI4 $2766
line 3430
;3430:		game++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3431
;3431:	}
LABELV $2766
line 3432
;3432:	if (game == GT_TEAM) {
ADDRLP4 4
INDIRI4
CNSTI4 3
NEI4 $2768
line 3433
;3433:		game = GT_FFA;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3434
;3434:	}
LABELV $2768
line 3436
;3435:
;3436:	for (i = 0; i < uiInfo.mapCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2773
JUMPV
LABELV $2770
line 3437
;3437:		uiInfo.mapList[i].active = qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+96
ADDP4
CNSTI4 0
ASGNI4
line 3438
;3438:		if (uiInfo.mapList[i].typeBits & (1 << game)) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+20
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 4
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $2777
line 3439
;3439:			if (singlePlayer) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $2781
line 3440
;3440:				if (!(uiInfo.mapList[i].typeBits & (1 << GT_SINGLE_PLAYER))) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+20
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $2783
line 3441
;3441:					continue;
ADDRGP4 $2771
JUMPV
LABELV $2783
line 3443
;3442:				}
;3443:			}
LABELV $2781
line 3444
;3444:			c++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3445
;3445:			uiInfo.mapList[i].active = qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+96
ADDP4
CNSTI4 1
ASGNI4
line 3446
;3446:		}
LABELV $2777
line 3447
;3447:	}
LABELV $2771
line 3436
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2773
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+83224
INDIRI4
LTI4 $2770
line 3448
;3448:	return c;
ADDRLP4 8
INDIRI4
RETI4
LABELV $2756
endproc UI_MapCountByGameType 16 0
export UI_hasSkinForBase
proc UI_hasSkinForBase 1032 20
line 3451
;3449:}
;3450:
;3451:qboolean UI_hasSkinForBase(const char *base, const char *team) {
line 3454
;3452:	char	test[1024];
;3453:
;3454:	Com_sprintf(test, sizeof(test), "models/players/%s/%s/lower_default.skin", base, team);
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2790
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3456
;3455:
;3456:	if (trap_FS_FOpenFile(test, 0, FS_READ)) {
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1024
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 0
EQI4 $2791
line 3457
;3457:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2789
JUMPV
LABELV $2791
line 3459
;3458:	}
;3459:	Com_sprintf(test, sizeof(test), "models/players/characters/%s/%s/lower_default.skin", base, team);
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2793
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3461
;3460:
;3461:	if (trap_FS_FOpenFile(test, 0, FS_READ)) {
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1028
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
EQI4 $2794
line 3462
;3462:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2789
JUMPV
LABELV $2794
line 3464
;3463:	}
;3464:	return qfalse;
CNSTI4 0
RETI4
LABELV $2789
endproc UI_hasSkinForBase 1032 20
data
align 4
LABELV $2797
byte 4 0
code
proc UI_HeadCountByTeam 40 8
line 3472
;3465:}
;3466:
;3467:/*
;3468:==================
;3469:UI_MapCountByTeam
;3470:==================
;3471:*/
;3472:static int UI_HeadCountByTeam() {
line 3476
;3473:	static int init = 0;
;3474:	int i, j, k, c, tIndex;
;3475:
;3476:	c = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 3477
;3477:	if (!init) {
ADDRGP4 $2797
INDIRI4
CNSTI4 0
NEI4 $2798
line 3478
;3478:		for (i = 0; i < uiInfo.characterCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2803
JUMPV
LABELV $2800
line 3479
;3479:			uiInfo.characterList[i].reference = 0;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448+20
ADDP4
CNSTI4 0
ASGNI4
line 3480
;3480:			for (j = 0; j < uiInfo.teamCount; j++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $2810
JUMPV
LABELV $2807
line 3481
;3481:				if (UI_hasSkinForBase(uiInfo.characterList[i].base, uiInfo.teamList[j].teamName)) {
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448+12
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 UI_hasSkinForBase
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $2812
line 3482
;3482:					uiInfo.characterList[i].reference |= (1 << j);
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448+20
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDRLP4 8
INDIRI4
LSHI4
BORI4
ASGNI4
line 3483
;3483:				}
LABELV $2812
line 3484
;3484:			}
LABELV $2808
line 3480
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2810
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+75756
INDIRI4
LTI4 $2807
line 3485
;3485:		}
LABELV $2801
line 3478
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2803
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+73440
INDIRI4
LTI4 $2800
line 3486
;3486:		init = 1;
ADDRGP4 $2797
CNSTI4 1
ASGNI4
line 3487
;3487:	}
LABELV $2798
line 3489
;3488:
;3489:	tIndex = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $689
ARGP4
ADDRLP4 20
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 24
INDIRI4
ASGNI4
line 3492
;3490:
;3491:	// do names
;3492:	for (i = 0; i < uiInfo.characterCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2822
JUMPV
LABELV $2819
line 3493
;3493:		uiInfo.characterList[i].active = qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448+16
ADDP4
CNSTI4 0
ASGNI4
line 3494
;3494:		for (j = 0; j < TEAM_MEMBERS; j++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $2826
line 3495
;3495:			if (uiInfo.teamList[tIndex].teamMembers[j] != NULL) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+8
ADDP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2830
line 3496
;3496:				if (uiInfo.characterList[i].reference & (1 << tIndex)) {// && Q_stricmp(uiInfo.teamList[tIndex].teamMembers[j], uiInfo.characterList[i].name)==0) {
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448+20
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 12
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $2834
line 3497
;3497:					uiInfo.characterList[i].active = qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448+16
ADDP4
CNSTI4 1
ASGNI4
line 3498
;3498:					c++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3499
;3499:					break;
ADDRGP4 $2828
JUMPV
LABELV $2834
line 3501
;3500:				}
;3501:			}
LABELV $2830
line 3502
;3502:		}
LABELV $2827
line 3494
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 5
LTI4 $2826
LABELV $2828
line 3503
;3503:	}
LABELV $2820
line 3492
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2822
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+73440
INDIRI4
LTI4 $2819
line 3506
;3504:
;3505:	// and then aliases
;3506:	for (j = 0; j < TEAM_MEMBERS; j++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $2840
line 3507
;3507:		for (k = 0; k < uiInfo.aliasCount; k++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2847
JUMPV
LABELV $2844
line 3508
;3508:			if (uiInfo.aliasList[k].name != NULL) {
ADDRLP4 4
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+74988
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2849
line 3509
;3509:				if (Q_stricmp(uiInfo.teamList[tIndex].teamMembers[j], uiInfo.aliasList[k].name) == 0) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+8
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+74988
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $2852
line 3510
;3510:					for (i = 0; i < uiInfo.characterCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2860
JUMPV
LABELV $2857
line 3511
;3511:						if (uiInfo.characterList[i].headImage != -1 && uiInfo.characterList[i].reference & (1 << tIndex) && Q_stricmp(uiInfo.aliasList[k].ai, uiInfo.characterList[i].name) == 0) {
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448+8
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $2862
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448+20
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 12
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $2862
ADDRLP4 4
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+74988+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $2862
line 3512
;3512:							if (uiInfo.characterList[i].active == qfalse) {
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448+16
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2859
line 3513
;3513:								uiInfo.characterList[i].active = qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448+16
ADDP4
CNSTI4 1
ASGNI4
line 3514
;3514:								c++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3515
;3515:							}
line 3516
;3516:							break;
ADDRGP4 $2859
JUMPV
LABELV $2862
line 3518
;3517:						}
;3518:					}
LABELV $2858
line 3510
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2860
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+73440
INDIRI4
LTI4 $2857
LABELV $2859
line 3519
;3519:				}
LABELV $2852
line 3520
;3520:			}
LABELV $2849
line 3521
;3521:		}
LABELV $2845
line 3507
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2847
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+74984
INDIRI4
LTI4 $2844
line 3522
;3522:	}
LABELV $2841
line 3506
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 5
LTI4 $2840
line 3523
;3523:	return c;
ADDRLP4 16
INDIRI4
RETI4
LABELV $2796
endproc UI_HeadCountByTeam 40 8
proc UI_InsertServerIntoDisplayList 16 0
line 3531
;3524:}
;3525:
;3526:/*
;3527:==================
;3528:UI_InsertServerIntoDisplayList
;3529:==================
;3530:*/
;3531:static void UI_InsertServerIntoDisplayList(int num, int position) {
line 3534
;3532:	int i;
;3533:
;3534:	if (position < 0 || position > uiInfo.serverStatus.numDisplayServers) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $2882
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+99264+10412
INDIRI4
LEI4 $2878
LABELV $2882
line 3535
;3535:		return;
ADDRGP4 $2877
JUMPV
LABELV $2878
line 3538
;3536:	}
;3537:	//
;3538:	uiInfo.serverStatus.numDisplayServers++;
ADDRLP4 8
ADDRGP4 uiInfo+99264+10412
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3539
;3539:	for (i = uiInfo.serverStatus.numDisplayServers; i > position; i--) {
ADDRLP4 0
ADDRGP4 uiInfo+99264+10412
INDIRI4
ASGNI4
ADDRGP4 $2888
JUMPV
LABELV $2885
line 3540
;3540:		uiInfo.serverStatus.displayServers[i] = uiInfo.serverStatus.displayServers[i - 1];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99264+2220
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99264+2220-4
ADDP4
INDIRI4
ASGNI4
line 3541
;3541:	}
LABELV $2886
line 3539
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $2888
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
GTI4 $2885
line 3542
;3542:	uiInfo.serverStatus.displayServers[position] = num;
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99264+2220
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 3543
;3543:}
LABELV $2877
endproc UI_InsertServerIntoDisplayList 16 0
proc UI_RemoveServerFromDisplayList 16 0
line 3550
;3544:
;3545:/*
;3546:==================
;3547:UI_RemoveServerFromDisplayList
;3548:==================
;3549:*/
;3550:static void UI_RemoveServerFromDisplayList(int num) {
line 3553
;3551:	int i, j;
;3552:
;3553:	for (i = 0; i < uiInfo.serverStatus.numDisplayServers; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2902
JUMPV
LABELV $2899
line 3554
;3554:		if (uiInfo.serverStatus.displayServers[i] == num) {
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99264+2220
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $2905
line 3555
;3555:			uiInfo.serverStatus.numDisplayServers--;
ADDRLP4 8
ADDRGP4 uiInfo+99264+10412
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3556
;3556:			for (j = i; j < uiInfo.serverStatus.numDisplayServers; j++) {
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $2914
JUMPV
LABELV $2911
line 3557
;3557:				uiInfo.serverStatus.displayServers[j] = uiInfo.serverStatus.displayServers[j + 1];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99264+2220
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99264+2220+4
ADDP4
INDIRI4
ASGNI4
line 3558
;3558:			}
LABELV $2912
line 3556
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2914
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+99264+10412
INDIRI4
LTI4 $2911
line 3559
;3559:			return;
ADDRGP4 $2898
JUMPV
LABELV $2905
line 3561
;3560:		}
;3561:	}
LABELV $2900
line 3553
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2902
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+99264+10412
INDIRI4
LTI4 $2899
line 3562
;3562:}
LABELV $2898
endproc UI_RemoveServerFromDisplayList 16 0
proc UI_BinaryServerInsertion 20 20
line 3569
;3563:
;3564:/*
;3565:==================
;3566:UI_BinaryServerInsertion
;3567:==================
;3568:*/
;3569:static void UI_BinaryServerInsertion(int num) {
line 3573
;3570:	int mid, offset, res, len;
;3571:
;3572:	// use binary search to insert server
;3573:	len = uiInfo.serverStatus.numDisplayServers;
ADDRLP4 12
ADDRGP4 uiInfo+99264+10412
INDIRI4
ASGNI4
line 3574
;3574:	mid = len;
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 3575
;3575:	offset = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 3576
;3576:	res = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2926
JUMPV
LABELV $2925
line 3577
;3577:	while (mid > 0) {
line 3578
;3578:		mid = len >> 1;
ADDRLP4 0
ADDRLP4 12
INDIRI4
CNSTI4 1
RSHI4
ASGNI4
line 3580
;3579:		//
;3580:		res = trap_LAN_CompareServers(ui_netSource.integer, uiInfo.serverStatus.sortKey,
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+99264+2200
INDIRI4
ARGI4
ADDRGP4 uiInfo+99264+2204
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99264+2220
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 trap_LAN_CompareServers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 3583
;3581:			uiInfo.serverStatus.sortDir, num, uiInfo.serverStatus.displayServers[offset + mid]);
;3582:		// if equal
;3583:		if (res == 0) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2935
line 3584
;3584:			UI_InsertServerIntoDisplayList(num, offset + mid);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ARGI4
ADDRGP4 UI_InsertServerIntoDisplayList
CALLV
pop
line 3585
;3585:			return;
ADDRGP4 $2922
JUMPV
LABELV $2935
line 3588
;3586:		}
;3587:		// if larger
;3588:		else if (res == 1) {
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $2937
line 3589
;3589:			offset += mid;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 3590
;3590:			len -= mid;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ASGNI4
line 3591
;3591:		}
ADDRGP4 $2938
JUMPV
LABELV $2937
line 3593
;3592:		// if smaller
;3593:		else {
line 3594
;3594:			len -= mid;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ASGNI4
line 3595
;3595:		}
LABELV $2938
line 3596
;3596:	}
LABELV $2926
line 3577
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $2925
line 3597
;3597:	if (res == 1) {
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $2939
line 3598
;3598:		offset++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3599
;3599:	}
LABELV $2939
line 3600
;3600:	UI_InsertServerIntoDisplayList(num, offset);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 UI_InsertServerIntoDisplayList
CALLV
pop
line 3601
;3601:}
LABELV $2922
endproc UI_BinaryServerInsertion 20 20
bss
align 4
LABELV $2942
skip 4
code
proc UI_BuildServerDisplayList 1096 16
line 3608
;3602:
;3603:/*
;3604:==================
;3605:UI_BuildServerDisplayList
;3606:==================
;3607:*/
;3608:static void UI_BuildServerDisplayList(qboolean force) {
line 3614
;3609:	int i, count, clients, maxClients, ping, game, len, visible;
;3610:	char info[MAX_STRING_CHARS];
;3611:	//	qboolean startRefresh = qtrue; TTimo: unused
;3612:	static int numinvisible;
;3613:
;3614:	if (!(force || uiInfo.uiDC.realTime > uiInfo.serverStatus.nextDisplayRefresh)) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $2943
ADDRGP4 uiInfo+208
INDIRI4
ADDRGP4 uiInfo+99264+10420
INDIRI4
GTI4 $2943
line 3615
;3615:		return;
ADDRGP4 $2941
JUMPV
LABELV $2943
line 3618
;3616:	}
;3617:	// if we shouldn't reset
;3618:	if (force == 2) {
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $2948
line 3619
;3619:		force = 0;
ADDRFP4 0
CNSTI4 0
ASGNI4
line 3620
;3620:	}
LABELV $2948
line 3623
;3621:
;3622:	// do motd updates here too
;3623:	trap_Cvar_VariableStringBuffer("cl_motdString", uiInfo.serverStatus.motd, sizeof(uiInfo.serverStatus.motd));
ADDRGP4 $2950
ARGP4
ADDRGP4 uiInfo+99264+10460
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 3624
;3624:	len = strlen(uiInfo.serverStatus.motd);
ADDRGP4 uiInfo+99264+10460
ARGP4
ADDRLP4 1056
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1052
ADDRLP4 1056
INDIRI4
ASGNI4
line 3625
;3625:	if (len == 0) {
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $2957
line 3626
;3626:		strcpy(uiInfo.serverStatus.motd, "Welcome to Team Arena!");
ADDRGP4 uiInfo+99264+10460
ARGP4
ADDRGP4 $2961
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 3627
;3627:		len = strlen(uiInfo.serverStatus.motd);
ADDRGP4 uiInfo+99264+10460
ARGP4
ADDRLP4 1060
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1052
ADDRLP4 1060
INDIRI4
ASGNI4
line 3628
;3628:	}
LABELV $2957
line 3629
;3629:	if (len != uiInfo.serverStatus.motdLen) {
ADDRLP4 1052
INDIRI4
ADDRGP4 uiInfo+99264+10436
INDIRI4
EQI4 $2964
line 3630
;3630:		uiInfo.serverStatus.motdLen = len;
ADDRGP4 uiInfo+99264+10436
ADDRLP4 1052
INDIRI4
ASGNI4
line 3631
;3631:		uiInfo.serverStatus.motdWidth = -1;
ADDRGP4 uiInfo+99264+10440
CNSTI4 -1
ASGNI4
line 3632
;3632:	}
LABELV $2964
line 3634
;3633:
;3634:	if (force) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $2972
line 3635
;3635:		numinvisible = 0;
ADDRGP4 $2942
CNSTI4 0
ASGNI4
line 3637
;3636:		// clear number of displayed servers
;3637:		uiInfo.serverStatus.numDisplayServers = 0;
ADDRGP4 uiInfo+99264+10412
CNSTI4 0
ASGNI4
line 3638
;3638:		uiInfo.serverStatus.numPlayersOnServers = 0;
ADDRGP4 uiInfo+99264+10416
CNSTI4 0
ASGNI4
line 3640
;3639:		// set list box index to zero
;3640:		Menu_SetFeederSelection(NULL, FEEDER_SERVERS, 0, NULL);
CNSTP4 0
ARGP4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 3642
;3641:		// mark all servers as visible so we store ping updates for them
;3642:		trap_LAN_MarkServerVisible(ui_netSource.integer, -1, qtrue);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_LAN_MarkServerVisible
CALLV
pop
line 3643
;3643:	}
LABELV $2972
line 3646
;3644:
;3645:	// get the server count (comes from the master)
;3646:	count = trap_LAN_GetServerCount(ui_netSource.integer);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 1060
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRLP4 1036
ADDRLP4 1060
INDIRI4
ASGNI4
line 3647
;3647:	if (count == -1 || (ui_netSource.integer == AS_LOCAL && count == 0)) {
ADDRLP4 1036
INDIRI4
CNSTI4 -1
EQI4 $2983
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
NEI4 $2980
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $2980
LABELV $2983
line 3649
;3648:		// still waiting on a response from the master
;3649:		uiInfo.serverStatus.numDisplayServers = 0;
ADDRGP4 uiInfo+99264+10412
CNSTI4 0
ASGNI4
line 3650
;3650:		uiInfo.serverStatus.numPlayersOnServers = 0;
ADDRGP4 uiInfo+99264+10416
CNSTI4 0
ASGNI4
line 3651
;3651:		uiInfo.serverStatus.nextDisplayRefresh = uiInfo.uiDC.realTime + 500;
ADDRGP4 uiInfo+99264+10420
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 3652
;3652:		return;
ADDRGP4 $2941
JUMPV
LABELV $2980
line 3655
;3653:	}
;3654:
;3655:	visible = qfalse;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 3656
;3656:	for (i = 0; i < count; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2994
JUMPV
LABELV $2991
line 3658
;3657:		// if we already got info for this server
;3658:		if (!trap_LAN_ServerIsVisible(ui_netSource.integer, i)) {
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1068
ADDRGP4 trap_LAN_ServerIsVisible
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
NEI4 $2995
line 3659
;3659:			continue;
ADDRGP4 $2992
JUMPV
LABELV $2995
line 3661
;3660:		}
;3661:		visible = qtrue;
ADDRLP4 1040
CNSTI4 1
ASGNI4
line 3663
;3662:		// get the ping for this server
;3663:		ping = trap_LAN_GetServerPing(ui_netSource.integer, i);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1072
ADDRGP4 trap_LAN_GetServerPing
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 1072
INDIRI4
ASGNI4
line 3664
;3664:		if (ping > 0 || ui_netSource.integer == AS_FAVORITES) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GTI4 $3002
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 3
NEI4 $2999
LABELV $3002
line 3666
;3665:
;3666:			trap_LAN_GetServerInfo(ui_netSource.integer, i, info, MAX_STRING_CHARS);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerInfo
CALLV
pop
line 3668
;3667:
;3668:			clients = atoi(Info_ValueForKey(info, "clients"));
ADDRLP4 8
ARGP4
ADDRGP4 $3004
ARGP4
ADDRLP4 1076
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1076
INDIRP4
ARGP4
ADDRLP4 1080
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1080
INDIRI4
ASGNI4
line 3669
;3669:			uiInfo.serverStatus.numPlayersOnServers += clients;
ADDRLP4 1084
ADDRGP4 uiInfo+99264+10416
ASGNP4
ADDRLP4 1084
INDIRP4
ADDRLP4 1084
INDIRP4
INDIRI4
ADDRLP4 1032
INDIRI4
ADDI4
ASGNI4
line 3671
;3670:
;3671:			if (ui_browserShowEmpty.integer == 0) {
ADDRGP4 ui_browserShowEmpty+12
INDIRI4
CNSTI4 0
NEI4 $3007
line 3672
;3672:				if (clients == 0) {
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $3010
line 3673
;3673:					trap_LAN_MarkServerVisible(ui_netSource.integer, i, qfalse);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_MarkServerVisible
CALLV
pop
line 3674
;3674:					continue;
ADDRGP4 $2992
JUMPV
LABELV $3010
line 3676
;3675:				}
;3676:			}
LABELV $3007
line 3678
;3677:
;3678:			if (ui_browserShowFull.integer == 0) {
ADDRGP4 ui_browserShowFull+12
INDIRI4
CNSTI4 0
NEI4 $3013
line 3679
;3679:				maxClients = atoi(Info_ValueForKey(info, "sv_maxclients"));
ADDRLP4 8
ARGP4
ADDRGP4 $1351
ARGP4
ADDRLP4 1088
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1088
INDIRP4
ARGP4
ADDRLP4 1092
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1044
ADDRLP4 1092
INDIRI4
ASGNI4
line 3680
;3680:				if (clients == maxClients) {
ADDRLP4 1032
INDIRI4
ADDRLP4 1044
INDIRI4
NEI4 $3016
line 3681
;3681:					trap_LAN_MarkServerVisible(ui_netSource.integer, i, qfalse);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_MarkServerVisible
CALLV
pop
line 3682
;3682:					continue;
ADDRGP4 $2992
JUMPV
LABELV $3016
line 3684
;3683:				}
;3684:			}
LABELV $3013
line 3686
;3685:
;3686:			if (uiInfo.joinGameTypes[ui_joinGameType.integer].gtEnum != -1) {
ADDRGP4 ui_joinGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78712+4
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $3019
line 3687
;3687:				game = atoi(Info_ValueForKey(info, "gametype"));
ADDRLP4 8
ARGP4
ADDRGP4 $3024
ARGP4
ADDRLP4 1088
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1088
INDIRP4
ARGP4
ADDRLP4 1092
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1048
ADDRLP4 1092
INDIRI4
ASGNI4
line 3688
;3688:				if (game != uiInfo.joinGameTypes[ui_joinGameType.integer].gtEnum) {
ADDRLP4 1048
INDIRI4
ADDRGP4 ui_joinGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78712+4
ADDP4
INDIRI4
EQI4 $3025
line 3689
;3689:					trap_LAN_MarkServerVisible(ui_netSource.integer, i, qfalse);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_MarkServerVisible
CALLV
pop
line 3690
;3690:					continue;
ADDRGP4 $2992
JUMPV
LABELV $3025
line 3692
;3691:				}
;3692:			}
LABELV $3019
line 3694
;3693:
;3694:			if (ui_serverFilterType.integer > 0) {
ADDRGP4 ui_serverFilterType+12
INDIRI4
CNSTI4 0
LEI4 $3031
line 3695
;3695:				if (Q_stricmp(Info_ValueForKey(info, "game"), serverFilters[ui_serverFilterType.integer].basedir) != 0) {
ADDRLP4 8
ARGP4
ADDRGP4 $3036
ARGP4
ADDRLP4 1088
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1088
INDIRP4
ARGP4
ADDRGP4 ui_serverFilterType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 serverFilters+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1092
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1092
INDIRI4
CNSTI4 0
EQI4 $3034
line 3696
;3696:					trap_LAN_MarkServerVisible(ui_netSource.integer, i, qfalse);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_MarkServerVisible
CALLV
pop
line 3697
;3697:					continue;
ADDRGP4 $2992
JUMPV
LABELV $3034
line 3699
;3698:				}
;3699:			}
LABELV $3031
line 3701
;3700:			// make sure we never add a favorite server twice
;3701:			if (ui_netSource.integer == AS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 3
NEI4 $3040
line 3702
;3702:				UI_RemoveServerFromDisplayList(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 UI_RemoveServerFromDisplayList
CALLV
pop
line 3703
;3703:			}
LABELV $3040
line 3705
;3704:			// insert the server into the list
;3705:			UI_BinaryServerInsertion(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 UI_BinaryServerInsertion
CALLV
pop
line 3707
;3706:			// done with this server
;3707:			if (ping > 0) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LEI4 $3043
line 3708
;3708:				trap_LAN_MarkServerVisible(ui_netSource.integer, i, qfalse);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_MarkServerVisible
CALLV
pop
line 3709
;3709:				numinvisible++;
ADDRLP4 1088
ADDRGP4 $2942
ASGNP4
ADDRLP4 1088
INDIRP4
ADDRLP4 1088
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3710
;3710:			}
LABELV $3043
line 3711
;3711:		}
LABELV $2999
line 3712
;3712:	}
LABELV $2992
line 3656
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2994
ADDRLP4 0
INDIRI4
ADDRLP4 1036
INDIRI4
LTI4 $2991
line 3714
;3713:
;3714:	uiInfo.serverStatus.refreshtime = uiInfo.uiDC.realTime;
ADDRGP4 uiInfo+99264+2192
ADDRGP4 uiInfo+208
INDIRI4
ASGNI4
line 3717
;3715:
;3716:	// if there were no servers visible for ping updates
;3717:	if (!visible) {
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $3049
line 3720
;3718:		//		UI_StopServerRefresh();
;3719:		//		uiInfo.serverStatus.nextDisplayRefresh = 0;
;3720:	}
LABELV $3049
line 3721
;3721:}
LABELV $2941
endproc UI_BuildServerDisplayList 1096 16
data
export serverStatusCvars
align 4
LABELV serverStatusCvars
address $3052
address $3053
address $3054
address $110
address $3055
address $3056
address $1314
address $3057
address $3058
address $3059
address $3060
address $110
address $2154
address $110
address $3061
address $110
address $707
address $110
byte 4 0
byte 4 0
code
proc UI_SortServerStatusInfo 44 8
line 3745
;3722:
;3723:typedef struct {
;3724:	char *name, *altName;
;3725:} serverStatusCvar_t;
;3726:
;3727:serverStatusCvar_t serverStatusCvars[] = {
;3728:	{"sv_hostname", "Name"},
;3729:	{"Address", ""},
;3730:	{"gamename", "Game name"},
;3731:	{"g_gametype", "Game type"},
;3732:	{"mapname", "Map"},
;3733:	{"version", ""},
;3734:	{"protocol", ""},
;3735:	{"timelimit", ""},
;3736:	{"fraglimit", ""},
;3737:	{NULL, NULL}
;3738:};
;3739:
;3740:/*
;3741:==================
;3742:UI_SortServerStatusInfo
;3743:==================
;3744:*/
;3745:static void UI_SortServerStatusInfo(serverStatusInfo_t *info) {
line 3752
;3746:	int i, j, index;
;3747:	char *tmp1, *tmp2;
;3748:
;3749:	// FIXME: if "gamename" == "baseq3" or "missionpack" then
;3750:	// replace the gametype number by FFA, CTF etc.
;3751:	//
;3752:	index = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3753
;3753:	for (i = 0; serverStatusCvars[i].name; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $3066
JUMPV
LABELV $3063
line 3754
;3754:		for (j = 0; j < info->numLines; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3070
JUMPV
LABELV $3067
line 3755
;3755:			if (!info->lines[j][1] || info->lines[j][1][0]) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3073
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3071
LABELV $3073
line 3756
;3756:				continue;
ADDRGP4 $3068
JUMPV
LABELV $3071
line 3758
;3757:			}
;3758:			if (!Q_stricmp(serverStatusCvars[i].name, info->lines[j][0])) {
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 serverStatusCvars
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $3074
line 3760
;3759:				// swap lines
;3760:				tmp1 = info->lines[index][0];
ADDRLP4 12
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDP4
INDIRP4
ASGNP4
line 3761
;3761:				tmp2 = info->lines[index][3];
ADDRLP4 16
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
INDIRP4
ASGNP4
line 3762
;3762:				info->lines[index][0] = info->lines[j][0];
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 64
ADDP4
ADDP4
INDIRP4
ASGNP4
line 3763
;3763:				info->lines[index][3] = info->lines[j][3];
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 36
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 36
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
INDIRP4
ASGNP4
line 3764
;3764:				info->lines[j][0] = tmp1;
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRLP4 12
INDIRP4
ASGNP4
line 3765
;3765:				info->lines[j][3] = tmp2;
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 16
INDIRP4
ASGNP4
line 3767
;3766:				//
;3767:				if (strlen(serverStatusCvars[i].altName)) {
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 serverStatusCvars+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $3076
line 3768
;3768:					info->lines[index][0] = serverStatusCvars[i].altName;
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 serverStatusCvars+4
ADDP4
INDIRP4
ASGNP4
line 3769
;3769:				}
LABELV $3076
line 3770
;3770:				index++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3771
;3771:			}
LABELV $3074
line 3772
;3772:		}
LABELV $3068
line 3754
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3070
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
LTI4 $3067
line 3773
;3773:	}
LABELV $3064
line 3753
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3066
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 serverStatusCvars
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3063
line 3774
;3774:}
LABELV $3062
endproc UI_SortServerStatusInfo 44 8
proc UI_GetServerStatusInfo 152 16
line 3781
;3775:
;3776:/*
;3777:==================
;3778:UI_GetServerStatusInfo
;3779:==================
;3780:*/
;3781:static int UI_GetServerStatusInfo(const char *serverAddress, serverStatusInfo_t *info) {
line 3785
;3782:	char *p, *score, *ping, *name;
;3783:	int i, len;
;3784:
;3785:	if (!info) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3081
line 3786
;3786:		trap_LAN_ServerStatus(serverAddress, NULL, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_ServerStatus
CALLI4
pop
line 3787
;3787:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3080
JUMPV
LABELV $3081
line 3789
;3788:	}
;3789:	memset(info, 0, sizeof(*info));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 3332
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3790
;3790:	if (trap_LAN_ServerStatus(serverAddress, info->text, sizeof(info->text))) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 2112
ADDP4
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 24
ADDRGP4 trap_LAN_ServerStatus
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $3083
line 3791
;3791:		Q_strncpyz(info->address, serverAddress, sizeof(info->address));
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3792
;3792:		p = info->text;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 2112
ADDP4
ASGNP4
line 3793
;3793:		info->numLines = 0;
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
CNSTI4 0
ASGNI4
line 3794
;3794:		info->lines[info->numLines][0] = "Address";
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 28
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRGP4 $3054
ASGNP4
line 3795
;3795:		info->lines[info->numLines][1] = "";
ADDRLP4 32
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRGP4 $110
ASGNP4
line 3796
;3796:		info->lines[info->numLines][2] = "";
ADDRLP4 36
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 36
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRGP4 $110
ASGNP4
line 3797
;3797:		info->lines[info->numLines][3] = info->address;
ADDRLP4 40
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 40
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 40
INDIRP4
ASGNP4
line 3798
;3798:		info->numLines++;
ADDRLP4 44
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $3086
JUMPV
LABELV $3085
line 3800
;3799:		// get the cvars
;3800:		while (p && *p) {
line 3801
;3801:			p = strchr(p, '\\');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 48
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 48
INDIRP4
ASGNP4
line 3802
;3802:			if (!p) break;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3088
ADDRGP4 $3087
JUMPV
LABELV $3088
line 3803
;3803:			*p++ = '\0';
ADDRLP4 52
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 52
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI1 0
ASGNI1
line 3804
;3804:			if (*p == '\\')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $3090
line 3805
;3805:				break;
ADDRGP4 $3087
JUMPV
LABELV $3090
line 3806
;3806:			info->lines[info->numLines][0] = p;
ADDRLP4 56
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 56
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 3807
;3807:			info->lines[info->numLines][1] = "";
ADDRLP4 60
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 60
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRGP4 $110
ASGNP4
line 3808
;3808:			info->lines[info->numLines][2] = "";
ADDRLP4 64
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 64
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRGP4 $110
ASGNP4
line 3809
;3809:			p = strchr(p, '\\');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 68
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 68
INDIRP4
ASGNP4
line 3810
;3810:			if (!p) break;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3092
ADDRGP4 $3087
JUMPV
LABELV $3092
line 3811
;3811:			*p++ = '\0';
ADDRLP4 72
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 72
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI1 0
ASGNI1
line 3812
;3812:			info->lines[info->numLines][3] = p;
ADDRLP4 76
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 76
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 3814
;3813:
;3814:			info->numLines++;
ADDRLP4 80
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3815
;3815:			if (info->numLines >= MAX_SERVERSTATUS_LINES)
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 128
LTI4 $3094
line 3816
;3816:				break;
ADDRGP4 $3087
JUMPV
LABELV $3094
line 3817
;3817:		}
LABELV $3086
line 3800
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3096
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3085
LABELV $3096
LABELV $3087
line 3819
;3818:		// get the player list
;3819:		if (info->numLines < MAX_SERVERSTATUS_LINES - 3) {
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 125
GEI4 $3097
line 3821
;3820:			// empty line
;3821:			info->lines[info->numLines][0] = "";
ADDRLP4 52
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 52
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRGP4 $110
ASGNP4
line 3822
;3822:			info->lines[info->numLines][1] = "";
ADDRLP4 56
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 56
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRGP4 $110
ASGNP4
line 3823
;3823:			info->lines[info->numLines][2] = "";
ADDRLP4 60
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 60
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRGP4 $110
ASGNP4
line 3824
;3824:			info->lines[info->numLines][3] = "";
ADDRLP4 64
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 64
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRGP4 $110
ASGNP4
line 3825
;3825:			info->numLines++;
ADDRLP4 68
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3827
;3826:			// header
;3827:			info->lines[info->numLines][0] = "num";
ADDRLP4 72
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 72
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRGP4 $3099
ASGNP4
line 3828
;3828:			info->lines[info->numLines][1] = "score";
ADDRLP4 76
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 76
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRGP4 $3100
ASGNP4
line 3829
;3829:			info->lines[info->numLines][2] = "ping";
ADDRLP4 80
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 80
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRGP4 $3101
ASGNP4
line 3830
;3830:			info->lines[info->numLines][3] = "name";
ADDRLP4 84
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 84
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRGP4 $1400
ASGNP4
line 3831
;3831:			info->numLines++;
ADDRLP4 88
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3833
;3832:			// parse players
;3833:			i = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 3834
;3834:			len = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $3103
JUMPV
LABELV $3102
line 3835
;3835:			while (p && *p) {
line 3836
;3836:				if (*p == '\\')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $3105
line 3837
;3837:					*p++ = '\0';
ADDRLP4 92
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 92
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI1 0
ASGNI1
LABELV $3105
line 3838
;3838:				if (!p)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3107
line 3839
;3839:					break;
ADDRGP4 $3104
JUMPV
LABELV $3107
line 3840
;3840:				score = p;
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
line 3841
;3841:				p = strchr(p, ' ');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 96
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 96
INDIRP4
ASGNP4
line 3842
;3842:				if (!p)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3109
line 3843
;3843:					break;
ADDRGP4 $3104
JUMPV
LABELV $3109
line 3844
;3844:				*p++ = '\0';
ADDRLP4 100
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 100
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI1 0
ASGNI1
line 3845
;3845:				ping = p;
ADDRLP4 16
ADDRLP4 0
INDIRP4
ASGNP4
line 3846
;3846:				p = strchr(p, ' ');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 104
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 104
INDIRP4
ASGNP4
line 3847
;3847:				if (!p)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3111
line 3848
;3848:					break;
ADDRGP4 $3104
JUMPV
LABELV $3111
line 3849
;3849:				*p++ = '\0';
ADDRLP4 108
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 108
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
CNSTI1 0
ASGNI1
line 3850
;3850:				name = p;
ADDRLP4 20
ADDRLP4 0
INDIRP4
ASGNP4
line 3851
;3851:				Com_sprintf(&info->pings[len], sizeof(info->pings) - len, "%d", i);
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 3136
ADDP4
ADDP4
ARGP4
CNSTU4 192
ADDRLP4 4
INDIRI4
CVIU4 4
SUBU4
CVUI4 4
ARGI4
ADDRGP4 $704
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3852
;3852:				info->lines[info->numLines][0] = &info->pings[len];
ADDRLP4 116
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 116
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 116
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRLP4 4
INDIRI4
ADDRLP4 116
INDIRP4
CNSTI4 3136
ADDP4
ADDP4
ASGNP4
line 3853
;3853:				len += strlen(&info->pings[len]) + 1;
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 3136
ADDP4
ADDP4
ARGP4
ADDRLP4 124
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 124
INDIRI4
CNSTI4 1
ADDI4
ADDI4
ASGNI4
line 3854
;3854:				info->lines[info->numLines][1] = score;
ADDRLP4 128
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 128
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 128
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRP4
ASGNP4
line 3855
;3855:				info->lines[info->numLines][2] = ping;
ADDRLP4 132
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 132
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 132
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 16
INDIRP4
ASGNP4
line 3856
;3856:				info->lines[info->numLines][3] = name;
ADDRLP4 136
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 136
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 20
INDIRP4
ASGNP4
line 3857
;3857:				info->numLines++;
ADDRLP4 140
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
ASGNP4
ADDRLP4 140
INDIRP4
ADDRLP4 140
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3858
;3858:				if (info->numLines >= MAX_SERVERSTATUS_LINES)
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 128
LTI4 $3113
line 3859
;3859:					break;
ADDRGP4 $3104
JUMPV
LABELV $3113
line 3860
;3860:				p = strchr(p, '\\');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 144
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 144
INDIRP4
ASGNP4
line 3861
;3861:				if (!p)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3115
line 3862
;3862:					break;
ADDRGP4 $3104
JUMPV
LABELV $3115
line 3863
;3863:				*p++ = '\0';
ADDRLP4 148
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 148
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
CNSTI1 0
ASGNI1
line 3865
;3864:				//
;3865:				i++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3866
;3866:			}
LABELV $3103
line 3835
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3117
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3102
LABELV $3117
LABELV $3104
line 3867
;3867:		}
LABELV $3097
line 3868
;3868:		UI_SortServerStatusInfo(info);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 UI_SortServerStatusInfo
CALLV
pop
line 3869
;3869:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3080
JUMPV
LABELV $3083
line 3871
;3870:	}
;3871:	return qfalse;
CNSTI4 0
RETI4
LABELV $3080
endproc UI_GetServerStatusInfo 152 16
proc stristr 12 4
line 3879
;3872:}
;3873:
;3874:/*
;3875:==================
;3876:stristr
;3877:==================
;3878:*/
;3879:static char *stristr(char *str, char *charset) {
ADDRGP4 $3120
JUMPV
LABELV $3119
line 3882
;3880:	int i;
;3881:
;3882:	while (*str) {
line 3883
;3883:		for (i = 0; charset[i] && str[i]; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3125
JUMPV
LABELV $3122
line 3884
;3884:			if (toupper(charset[i]) != toupper(str[i])) break;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 4
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $3126
ADDRGP4 $3124
JUMPV
LABELV $3126
line 3885
;3885:		}
LABELV $3123
line 3883
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3125
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3128
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3122
LABELV $3128
LABELV $3124
line 3886
;3886:		if (!charset[i]) return str;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3129
ADDRFP4 0
INDIRP4
RETP4
ADDRGP4 $3118
JUMPV
LABELV $3129
line 3887
;3887:		str++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 3888
;3888:	}
LABELV $3120
line 3882
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3119
line 3889
;3889:	return NULL;
CNSTP4 0
RETP4
LABELV $3118
endproc stristr 12 4
bss
align 4
LABELV $3132
skip 4
align 4
LABELV $3133
skip 4
code
proc UI_BuildFindPlayerList 4424 24
line 3897
;3890:}
;3891:
;3892:/*
;3893:==================
;3894:UI_BuildFindPlayerList
;3895:==================
;3896:*/
;3897:static void UI_BuildFindPlayerList(qboolean force) {
line 3904
;3898:	static int numFound, numTimeOuts;
;3899:	int i, j, resend;
;3900:	serverStatusInfo_t info;
;3901:	char name[MAX_NAME_LENGTH + 2];
;3902:	char infoString[MAX_STRING_CHARS];
;3903:
;3904:	if (!force) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $3134
line 3905
;3905:		if (!uiInfo.nextFindPlayerRefresh || uiInfo.nextFindPlayerRefresh > uiInfo.uiDC.realTime) {
ADDRGP4 uiInfo+119472
INDIRI4
CNSTI4 0
EQI4 $3141
ADDRGP4 uiInfo+119472
INDIRI4
ADDRGP4 uiInfo+208
INDIRI4
LEI4 $3135
LABELV $3141
line 3906
;3906:			return;
ADDRGP4 $3131
JUMPV
line 3908
;3907:		}
;3908:	} else {
LABELV $3134
line 3909
;3909:		memset(&uiInfo.pendingServerStatus, 0, sizeof(uiInfo.pendingServerStatus));
ADDRGP4 uiInfo+114148
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2244
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3910
;3910:		uiInfo.numFoundPlayerServers = 0;
ADDRGP4 uiInfo+119468
CNSTI4 0
ASGNI4
line 3911
;3911:		uiInfo.currentFoundPlayerServer = 0;
ADDRGP4 uiInfo+119464
CNSTI4 0
ASGNI4
line 3912
;3912:		trap_Cvar_VariableStringBuffer("ui_findPlayer", uiInfo.findPlayerName, sizeof(uiInfo.findPlayerName));
ADDRGP4 $3146
ARGP4
ADDRGP4 uiInfo+116392
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 3913
;3913:		Q_CleanStr(uiInfo.findPlayerName);
ADDRGP4 uiInfo+116392
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 3915
;3914:		// should have a string of some length
;3915:		if (!strlen(uiInfo.findPlayerName)) {
ADDRGP4 uiInfo+116392
ARGP4
ADDRLP4 4404
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4404
INDIRI4
CNSTI4 0
NEI4 $3150
line 3916
;3916:			uiInfo.nextFindPlayerRefresh = 0;
ADDRGP4 uiInfo+119472
CNSTI4 0
ASGNI4
line 3917
;3917:			return;
ADDRGP4 $3131
JUMPV
LABELV $3150
line 3920
;3918:		}
;3919:		// set resend time
;3920:		resend = ui_serverStatusTimeOut.integer / 2 - 10;
ADDRLP4 4400
ADDRGP4 ui_serverStatusTimeOut+12
INDIRI4
CNSTI4 2
DIVI4
CNSTI4 10
SUBI4
ASGNI4
line 3921
;3921:		if (resend < 50) {
ADDRLP4 4400
INDIRI4
CNSTI4 50
GEI4 $3155
line 3922
;3922:			resend = 50;
ADDRLP4 4400
CNSTI4 50
ASGNI4
line 3923
;3923:		}
LABELV $3155
line 3924
;3924:		trap_Cvar_Set("cl_serverStatusResendTime", va("%d", resend));
ADDRGP4 $704
ARGP4
ADDRLP4 4400
INDIRI4
ARGI4
ADDRLP4 4408
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $3157
ARGP4
ADDRLP4 4408
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3926
;3925:		// reset all server status requests
;3926:		trap_LAN_ServerStatus(NULL, NULL, 0);
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_ServerStatus
CALLI4
pop
line 3928
;3927:		//
;3928:		uiInfo.numFoundPlayerServers = 1;
ADDRGP4 uiInfo+119468
CNSTI4 1
ASGNI4
line 3929
;3929:		Com_sprintf(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers - 1],
ADDRGP4 uiInfo+119468
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+118440-64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $3165
ARGP4
ADDRGP4 uiInfo+114148
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3932
;3930:			sizeof(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers - 1]),
;3931:			"searching %d...", uiInfo.pendingServerStatus.num);
;3932:		numFound = 0;
ADDRGP4 $3132
CNSTI4 0
ASGNI4
line 3933
;3933:		numTimeOuts++;
ADDRLP4 4412
ADDRGP4 $3133
ASGNP4
ADDRLP4 4412
INDIRP4
ADDRLP4 4412
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3934
;3934:	}
LABELV $3135
line 3935
;3935:	for (i = 0; i < MAX_SERVERSTATUSREQUESTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $3167
line 3937
;3936:		// if this pending server is valid
;3937:		if (uiInfo.pendingServerStatus.server[i].valid) {
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114148+4+136
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3171
line 3939
;3938:			// try to get the server status for this server
;3939:			if (UI_GetServerStatusInfo(uiInfo.pendingServerStatus.server[i].adrstr, &info)) {
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114148+4
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 4404
ADDRGP4 UI_GetServerStatusInfo
CALLI4
ASGNI4
ADDRLP4 4404
INDIRI4
CNSTI4 0
EQI4 $3176
line 3941
;3940:				//
;3941:				numFound++;
ADDRLP4 4408
ADDRGP4 $3132
ASGNP4
ADDRLP4 4408
INDIRP4
ADDRLP4 4408
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3943
;3942:				// parse through the server status lines
;3943:				for (j = 0; j < info.numLines; j++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $3183
JUMPV
LABELV $3180
line 3945
;3944:					// should have ping info
;3945:					if (!info.lines[j][2] || !info.lines[j][2][0]) {
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 8+64+8
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3191
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 8+64+8
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3185
LABELV $3191
line 3946
;3946:						continue;
ADDRGP4 $3181
JUMPV
LABELV $3185
line 3949
;3947:					}
;3948:					// clean string first
;3949:					Q_strncpyz(name, info.lines[j][3], sizeof(name));
ADDRLP4 3340
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 8+64+12
ADDP4
INDIRP4
ARGP4
CNSTI4 34
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3950
;3950:					Q_CleanStr(name);
ADDRLP4 3340
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 3952
;3951:					// if the player name is a substring
;3952:					if (stristr(name, uiInfo.findPlayerName)) {
ADDRLP4 3340
ARGP4
ADDRGP4 uiInfo+116392
ARGP4
ADDRLP4 4416
ADDRGP4 stristr
CALLP4
ASGNP4
ADDRLP4 4416
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3194
line 3954
;3953:						// add to found server list if we have space (always leave space for a line with the number found)
;3954:						if (uiInfo.numFoundPlayerServers < MAX_FOUNDPLAYER_SERVERS - 1) {
ADDRGP4 uiInfo+119468
INDIRI4
CNSTI4 15
GEI4 $3197
line 3956
;3955:							//
;3956:							Q_strncpyz(uiInfo.foundPlayerServerAddresses[uiInfo.numFoundPlayerServers - 1],
ADDRGP4 uiInfo+119468
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+117416-64
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114148+4
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3959
;3957:								uiInfo.pendingServerStatus.server[i].adrstr,
;3958:								sizeof(uiInfo.foundPlayerServerAddresses[0]));
;3959:							Q_strncpyz(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers - 1],
ADDRGP4 uiInfo+119468
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+118440-64
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114148+4+64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3962
;3960:								uiInfo.pendingServerStatus.server[i].name,
;3961:								sizeof(uiInfo.foundPlayerServerNames[0]));
;3962:							uiInfo.numFoundPlayerServers++;
ADDRLP4 4420
ADDRGP4 uiInfo+119468
ASGNP4
ADDRLP4 4420
INDIRP4
ADDRLP4 4420
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3963
;3963:						} else {
ADDRGP4 $3198
JUMPV
LABELV $3197
line 3965
;3964:							// can't add any more so we're done
;3965:							uiInfo.pendingServerStatus.num = uiInfo.serverStatus.numDisplayServers;
ADDRGP4 uiInfo+114148
ADDRGP4 uiInfo+99264+10412
INDIRI4
ASGNI4
line 3966
;3966:						}
LABELV $3198
line 3967
;3967:					}
LABELV $3194
line 3968
;3968:				}
LABELV $3181
line 3943
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3183
ADDRLP4 4
INDIRI4
ADDRLP4 8+3328
INDIRI4
LTI4 $3180
line 3969
;3969:				Com_sprintf(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers - 1],
ADDRGP4 uiInfo+119468
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+118440-64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $3223
ARGP4
ADDRGP4 uiInfo+114148
INDIRI4
ARGI4
ADDRGP4 $3132
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3973
;3970:					sizeof(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers - 1]),
;3971:					"searching %d/%d...", uiInfo.pendingServerStatus.num, numFound);
;3972:				// retrieved the server status so reuse this spot
;3973:				uiInfo.pendingServerStatus.server[i].valid = qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114148+4+136
ADDP4
CNSTI4 0
ASGNI4
line 3974
;3974:			}
LABELV $3176
line 3975
;3975:		}
LABELV $3171
line 3977
;3976:		// if empty pending slot or timed out
;3977:		if (!uiInfo.pendingServerStatus.server[i].valid ||
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114148+4+136
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3238
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114148+4+128
ADDP4
INDIRI4
ADDRGP4 uiInfo+208
INDIRI4
ADDRGP4 ui_serverStatusTimeOut+12
INDIRI4
SUBI4
GEI4 $3228
LABELV $3238
line 3978
;3978:			uiInfo.pendingServerStatus.server[i].startTime < uiInfo.uiDC.realTime - ui_serverStatusTimeOut.integer) {
line 3979
;3979:			if (uiInfo.pendingServerStatus.server[i].valid) {
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114148+4+136
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3239
line 3980
;3980:				numTimeOuts++;
ADDRLP4 4408
ADDRGP4 $3133
ASGNP4
ADDRLP4 4408
INDIRP4
ADDRLP4 4408
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3981
;3981:			}
LABELV $3239
line 3983
;3982:			// reset server status request for this address
;3983:			UI_GetServerStatusInfo(uiInfo.pendingServerStatus.server[i].adrstr, NULL);
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114148+4
ADDP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 UI_GetServerStatusInfo
CALLI4
pop
line 3985
;3984:			// reuse pending slot
;3985:			uiInfo.pendingServerStatus.server[i].valid = qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114148+4+136
ADDP4
CNSTI4 0
ASGNI4
line 3987
;3986:			// if we didn't try to get the status of all servers in the main browser yet
;3987:			if (uiInfo.pendingServerStatus.num < uiInfo.serverStatus.numDisplayServers) {
ADDRGP4 uiInfo+114148
INDIRI4
ADDRGP4 uiInfo+99264+10412
INDIRI4
GEI4 $3249
line 3988
;3988:				uiInfo.pendingServerStatus.server[i].startTime = uiInfo.uiDC.realTime;
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114148+4+128
ADDP4
ADDRGP4 uiInfo+208
INDIRI4
ASGNI4
line 3989
;3989:				trap_LAN_GetServerAddressString(ui_netSource.integer, uiInfo.serverStatus.displayServers[uiInfo.pendingServerStatus.num],
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+114148
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99264+2220
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114148+4
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_LAN_GetServerAddressString
CALLV
pop
line 3991
;3990:					uiInfo.pendingServerStatus.server[i].adrstr, sizeof(uiInfo.pendingServerStatus.server[i].adrstr));
;3991:				trap_LAN_GetServerInfo(ui_netSource.integer, uiInfo.serverStatus.displayServers[uiInfo.pendingServerStatus.num], infoString, sizeof(infoString));
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+114148
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99264+2220
ADDP4
INDIRI4
ARGI4
ADDRLP4 3374
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerInfo
CALLV
pop
line 3992
;3992:				Q_strncpyz(uiInfo.pendingServerStatus.server[i].name, Info_ValueForKey(infoString, "hostname"), sizeof(uiInfo.pendingServerStatus.server[0].name));
ADDRLP4 3374
ARGP4
ADDRGP4 $2677
ARGP4
ADDRLP4 4408
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114148+4+64
ADDP4
ARGP4
ADDRLP4 4408
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3993
;3993:				uiInfo.pendingServerStatus.server[i].valid = qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114148+4+136
ADDP4
CNSTI4 1
ASGNI4
line 3994
;3994:				uiInfo.pendingServerStatus.num++;
ADDRLP4 4412
ADDRGP4 uiInfo+114148
ASGNP4
ADDRLP4 4412
INDIRP4
ADDRLP4 4412
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3995
;3995:				Com_sprintf(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers - 1],
ADDRGP4 uiInfo+119468
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+118440-64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $3223
ARGP4
ADDRGP4 uiInfo+114148
INDIRI4
ARGI4
ADDRGP4 $3132
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3998
;3996:					sizeof(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers - 1]),
;3997:					"searching %d/%d...", uiInfo.pendingServerStatus.num, numFound);
;3998:			}
LABELV $3249
line 3999
;3999:		}
LABELV $3228
line 4000
;4000:	}
LABELV $3168
line 3935
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $3167
line 4001
;4001:	for (i = 0; i < MAX_SERVERSTATUSREQUESTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $3287
line 4002
;4002:		if (uiInfo.pendingServerStatus.server[i].valid) {
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+114148+4+136
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3291
line 4003
;4003:			break;
ADDRGP4 $3289
JUMPV
LABELV $3291
line 4005
;4004:		}
;4005:	}
LABELV $3288
line 4001
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $3287
LABELV $3289
line 4007
;4006:	// if still trying to retrieve server status info
;4007:	if (i < MAX_SERVERSTATUSREQUESTS) {
ADDRLP4 0
INDIRI4
CNSTI4 16
GEI4 $3296
line 4008
;4008:		uiInfo.nextFindPlayerRefresh = uiInfo.uiDC.realTime + 25;
ADDRGP4 uiInfo+119472
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 25
ADDI4
ASGNI4
line 4009
;4009:	} else {
ADDRGP4 $3297
JUMPV
LABELV $3296
line 4011
;4010:		// add a line that shows the number of servers found
;4011:		if (!uiInfo.numFoundPlayerServers) {
ADDRGP4 uiInfo+119468
INDIRI4
CNSTI4 0
NEI4 $3300
line 4012
;4012:			Com_sprintf(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers - 1], sizeof(uiInfo.foundPlayerServerAddresses[0]), "no servers found");
ADDRGP4 uiInfo+119468
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+118440-64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $3307
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4013
;4013:		} else {
ADDRGP4 $3301
JUMPV
LABELV $3300
line 4014
;4014:			Com_sprintf(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers - 1], sizeof(uiInfo.foundPlayerServerAddresses[0]),
ADDRGP4 uiInfo+119468
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+118440-64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $3312
ARGP4
ADDRGP4 uiInfo+119468
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 uiInfo+119468
INDIRI4
CNSTI4 2
NEI4 $3318
ADDRLP4 4404
ADDRGP4 $110
ASGNP4
ADDRGP4 $3319
JUMPV
LABELV $3318
ADDRLP4 4404
ADDRGP4 $3315
ASGNP4
LABELV $3319
ADDRLP4 4404
INDIRP4
ARGP4
ADDRGP4 uiInfo+116392
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4017
;4015:				"%d server%s found with player %s", uiInfo.numFoundPlayerServers - 1,
;4016:				uiInfo.numFoundPlayerServers == 2 ? "" : "s", uiInfo.findPlayerName);
;4017:		}
LABELV $3301
line 4018
;4018:		uiInfo.nextFindPlayerRefresh = 0;
ADDRGP4 uiInfo+119472
CNSTI4 0
ASGNI4
line 4020
;4019:		// show the server status info for the selected server
;4020:		UI_FeederSelection(FEEDER_FINDPLAYER, uiInfo.currentFoundPlayerServer);
CNSTF4 1096810496
ARGF4
ADDRGP4 uiInfo+119464
INDIRI4
ARGI4
ADDRGP4 UI_FeederSelection
CALLV
pop
line 4021
;4021:	}
LABELV $3297
line 4022
;4022:}
LABELV $3131
endproc UI_BuildFindPlayerList 4424 24
proc UI_BuildServerStatus 4 16
line 4029
;4023:
;4024:/*
;4025:==================
;4026:UI_BuildServerStatus
;4027:==================
;4028:*/
;4029:static void UI_BuildServerStatus(qboolean force) {
line 4031
;4030:
;4031:	if (uiInfo.nextFindPlayerRefresh) {
ADDRGP4 uiInfo+119472
INDIRI4
CNSTI4 0
EQI4 $3323
line 4032
;4032:		return;
ADDRGP4 $3322
JUMPV
LABELV $3323
line 4034
;4033:	}
;4034:	if (!force) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $3326
line 4035
;4035:		if (!uiInfo.nextServerStatusRefresh || uiInfo.nextServerStatusRefresh > uiInfo.uiDC.realTime) {
ADDRGP4 uiInfo+114144
INDIRI4
CNSTI4 0
EQI4 $3333
ADDRGP4 uiInfo+114144
INDIRI4
ADDRGP4 uiInfo+208
INDIRI4
LEI4 $3327
LABELV $3333
line 4036
;4036:			return;
ADDRGP4 $3322
JUMPV
line 4038
;4037:		}
;4038:	} else {
LABELV $3326
line 4039
;4039:		Menu_SetFeederSelection(NULL, FEEDER_SERVERSTATUS, 0, NULL);
CNSTP4 0
ARGP4
CNSTI4 13
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 4040
;4040:		uiInfo.serverStatusInfo.numLines = 0;
ADDRGP4 uiInfo+110812+3328
CNSTI4 0
ASGNI4
line 4042
;4041:		// reset all server status requests
;4042:		trap_LAN_ServerStatus(NULL, NULL, 0);
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_ServerStatus
CALLI4
pop
line 4043
;4043:	}
LABELV $3327
line 4044
;4044:	if (uiInfo.serverStatus.currentServer < 0 || uiInfo.serverStatus.currentServer > uiInfo.serverStatus.numDisplayServers || uiInfo.serverStatus.numDisplayServers == 0) {
ADDRGP4 uiInfo+99264+2216
INDIRI4
CNSTI4 0
LTI4 $3347
ADDRGP4 uiInfo+99264+2216
INDIRI4
ADDRGP4 uiInfo+99264+10412
INDIRI4
GTI4 $3347
ADDRGP4 uiInfo+99264+10412
INDIRI4
CNSTI4 0
NEI4 $3336
LABELV $3347
line 4045
;4045:		return;
ADDRGP4 $3322
JUMPV
LABELV $3336
line 4047
;4046:	}
;4047:	if (UI_GetServerStatusInfo(uiInfo.serverStatusAddress, &uiInfo.serverStatusInfo)) {
ADDRGP4 uiInfo+110748
ARGP4
ADDRGP4 uiInfo+110812
ARGP4
ADDRLP4 0
ADDRGP4 UI_GetServerStatusInfo
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $3348
line 4048
;4048:		uiInfo.nextServerStatusRefresh = 0;
ADDRGP4 uiInfo+114144
CNSTI4 0
ASGNI4
line 4049
;4049:		UI_GetServerStatusInfo(uiInfo.serverStatusAddress, NULL);
ADDRGP4 uiInfo+110748
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 UI_GetServerStatusInfo
CALLI4
pop
line 4050
;4050:	} else {
ADDRGP4 $3349
JUMPV
LABELV $3348
line 4051
;4051:		uiInfo.nextServerStatusRefresh = uiInfo.uiDC.realTime + 500;
ADDRGP4 uiInfo+114144
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 4052
;4052:	}
LABELV $3349
line 4053
;4053:}
LABELV $3322
endproc UI_BuildServerStatus 4 16
proc UI_FeederCount 12 4
line 4060
;4054:
;4055:/*
;4056:==================
;4057:UI_FeederCount
;4058:==================
;4059:*/
;4060:static int UI_FeederCount(float feederID) {
line 4061
;4061:	if (feederID == FEEDER_HEADS) {
ADDRFP4 0
INDIRF4
CNSTF4 0
NEF4 $3357
line 4062
;4062:		return UI_HeadCountByTeam();
ADDRLP4 0
ADDRGP4 UI_HeadCountByTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $3356
JUMPV
LABELV $3357
line 4063
;4063:	} else if (feederID == FEEDER_Q3HEADS) {
ADDRFP4 0
INDIRF4
CNSTF4 1094713344
NEF4 $3359
line 4064
;4064:		return uiInfo.q3HeadCount;
ADDRGP4 uiInfo+119488
INDIRI4
RETI4
ADDRGP4 $3356
JUMPV
LABELV $3359
line 4065
;4065:	} else if (feederID == FEEDER_CINEMATICS) {
ADDRFP4 0
INDIRF4
CNSTF4 1097859072
NEF4 $3362
line 4066
;4066:		return uiInfo.movieCount;
ADDRGP4 uiInfo+99252
INDIRI4
RETI4
ADDRGP4 $3356
JUMPV
LABELV $3362
line 4067
;4067:	} else if (feederID == FEEDER_MAPS || feederID == FEEDER_ALLMAPS) {
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
EQF4 $3367
ADDRLP4 0
INDIRF4
CNSTF4 1082130432
NEF4 $3365
LABELV $3367
line 4068
;4068:		return UI_MapCountByGameType(feederID == FEEDER_MAPS ? qtrue : qfalse);
ADDRFP4 0
INDIRF4
CNSTF4 1065353216
NEF4 $3369
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $3370
JUMPV
LABELV $3369
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $3370
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 UI_MapCountByGameType
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $3356
JUMPV
LABELV $3365
line 4069
;4069:	} else if (feederID == FEEDER_SERVERS) {
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
NEF4 $3371
line 4070
;4070:		return uiInfo.serverStatus.numDisplayServers;
ADDRGP4 uiInfo+99264+10412
INDIRI4
RETI4
ADDRGP4 $3356
JUMPV
LABELV $3371
line 4071
;4071:	} else if (feederID == FEEDER_SERVERSTATUS) {
ADDRFP4 0
INDIRF4
CNSTF4 1095761920
NEF4 $3375
line 4072
;4072:		return uiInfo.serverStatusInfo.numLines;
ADDRGP4 uiInfo+110812+3328
INDIRI4
RETI4
ADDRGP4 $3356
JUMPV
LABELV $3375
line 4073
;4073:	} else if (feederID == FEEDER_FINDPLAYER) {
ADDRFP4 0
INDIRF4
CNSTF4 1096810496
NEF4 $3379
line 4074
;4074:		return uiInfo.numFoundPlayerServers;
ADDRGP4 uiInfo+119468
INDIRI4
RETI4
ADDRGP4 $3356
JUMPV
LABELV $3379
line 4075
;4075:	} else if (feederID == FEEDER_PLAYER_LIST) {
ADDRFP4 0
INDIRF4
CNSTF4 1088421888
NEF4 $3382
line 4076
;4076:		if (uiInfo.uiDC.realTime > uiInfo.playerRefresh) {
ADDRGP4 uiInfo+208
INDIRI4
ADDRGP4 uiInfo+78856
INDIRI4
LEI4 $3384
line 4077
;4077:			uiInfo.playerRefresh = uiInfo.uiDC.realTime + 3000;
ADDRGP4 uiInfo+78856
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 4078
;4078:			UI_BuildPlayerList();
ADDRGP4 UI_BuildPlayerList
CALLV
pop
line 4079
;4079:		}
LABELV $3384
line 4080
;4080:		return uiInfo.playerCount;
ADDRGP4 uiInfo+78844
INDIRI4
RETI4
ADDRGP4 $3356
JUMPV
LABELV $3382
line 4081
;4081:	} else if (feederID == FEEDER_TEAM_LIST) {
ADDRFP4 0
INDIRF4
CNSTF4 1090519040
NEF4 $3391
line 4082
;4082:		if (uiInfo.uiDC.realTime > uiInfo.playerRefresh) {
ADDRGP4 uiInfo+208
INDIRI4
ADDRGP4 uiInfo+78856
INDIRI4
LEI4 $3393
line 4083
;4083:			uiInfo.playerRefresh = uiInfo.uiDC.realTime + 3000;
ADDRGP4 uiInfo+78856
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 4084
;4084:			UI_BuildPlayerList();
ADDRGP4 UI_BuildPlayerList
CALLV
pop
line 4085
;4085:		}
LABELV $3393
line 4086
;4086:		return uiInfo.myTeamCount;
ADDRGP4 uiInfo+78848
INDIRI4
RETI4
ADDRGP4 $3356
JUMPV
LABELV $3391
line 4087
;4087:	} else if (feederID == FEEDER_MODS) {
ADDRFP4 0
INDIRF4
CNSTF4 1091567616
NEF4 $3400
line 4088
;4088:		return uiInfo.modCount;
ADDRGP4 uiInfo+97188
INDIRI4
RETI4
ADDRGP4 $3356
JUMPV
LABELV $3400
line 4089
;4089:	} else if (feederID == FEEDER_DEMOS) {
ADDRFP4 0
INDIRF4
CNSTF4 1092616192
NEF4 $3403
line 4090
;4090:		return uiInfo.demoCount;
ADDRGP4 uiInfo+98220
INDIRI4
RETI4
ADDRGP4 $3356
JUMPV
LABELV $3403
line 4092
;4091:	}
;4092:	return 0;
CNSTI4 0
RETI4
LABELV $3356
endproc UI_FeederCount 12 4
proc UI_SelectedMap 8 0
line 4095
;4093:}
;4094:
;4095:static const char *UI_SelectedMap(int index, int *actual) {
line 4097
;4096:	int i, c;
;4097:	c = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 4098
;4098:	*actual = 0;
ADDRFP4 4
INDIRP4
CNSTI4 0
ASGNI4
line 4099
;4099:	for (i = 0; i < uiInfo.mapCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3410
JUMPV
LABELV $3407
line 4100
;4100:		if (uiInfo.mapList[i].active) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+96
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3412
line 4101
;4101:			if (c == index) {
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $3416
line 4102
;4102:				*actual = i;
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ASGNI4
line 4103
;4103:				return uiInfo.mapList[i].mapName;
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228
ADDP4
INDIRP4
RETP4
ADDRGP4 $3406
JUMPV
LABELV $3416
line 4104
;4104:			} else {
line 4105
;4105:				c++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4106
;4106:			}
line 4107
;4107:		}
LABELV $3412
line 4108
;4108:	}
LABELV $3408
line 4099
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3410
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+83224
INDIRI4
LTI4 $3407
line 4109
;4109:	return "";
ADDRGP4 $110
RETP4
LABELV $3406
endproc UI_SelectedMap 8 0
proc UI_SelectedHead 8 0
line 4112
;4110:}
;4111:
;4112:static const char *UI_SelectedHead(int index, int *actual) {
line 4114
;4113:	int i, c;
;4114:	c = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 4115
;4115:	*actual = 0;
ADDRFP4 4
INDIRP4
CNSTI4 0
ASGNI4
line 4116
;4116:	for (i = 0; i < uiInfo.characterCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3423
JUMPV
LABELV $3420
line 4117
;4117:		if (uiInfo.characterList[i].active) {
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448+16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3425
line 4118
;4118:			if (c == index) {
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $3429
line 4119
;4119:				*actual = i;
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ASGNI4
line 4120
;4120:				return uiInfo.characterList[i].name;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448
ADDP4
INDIRP4
RETP4
ADDRGP4 $3419
JUMPV
LABELV $3429
line 4121
;4121:			} else {
line 4122
;4122:				c++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4123
;4123:			}
line 4124
;4124:		}
LABELV $3425
line 4125
;4125:	}
LABELV $3421
line 4116
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3423
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+73440
INDIRI4
LTI4 $3420
line 4126
;4126:	return "";
ADDRGP4 $110
RETP4
LABELV $3419
endproc UI_SelectedHead 8 0
proc UI_GetIndexFromSelection 8 0
line 4129
;4127:}
;4128:
;4129:static int UI_GetIndexFromSelection(int actual) {
line 4131
;4130:	int i, c;
;4131:	c = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 4132
;4132:	for (i = 0; i < uiInfo.mapCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3436
JUMPV
LABELV $3433
line 4133
;4133:		if (uiInfo.mapList[i].active) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+96
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3438
line 4134
;4134:			if (i == actual) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $3442
line 4135
;4135:				return c;
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $3432
JUMPV
LABELV $3442
line 4137
;4136:			}
;4137:			c++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4138
;4138:		}
LABELV $3438
line 4139
;4139:	}
LABELV $3434
line 4132
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3436
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+83224
INDIRI4
LTI4 $3433
line 4140
;4140:	return 0;
CNSTI4 0
RETI4
LABELV $3432
endproc UI_GetIndexFromSelection 8 0
proc UI_UpdatePendingPings 0 4
line 4143
;4141:}
;4142:
;4143:static void UI_UpdatePendingPings() {
line 4144
;4144:	trap_LAN_ResetPings(ui_netSource.integer);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 trap_LAN_ResetPings
CALLV
pop
line 4145
;4145:	uiInfo.serverStatus.refreshActive = qtrue;
ADDRGP4 uiInfo+99264+2212
CNSTI4 1
ASGNI4
line 4146
;4146:	uiInfo.serverStatus.refreshtime = uiInfo.uiDC.realTime + 1000;
ADDRGP4 uiInfo+99264+2192
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 4148
;4147:
;4148:}
LABELV $3444
endproc UI_UpdatePendingPings 0 4
bss
align 1
LABELV $3452
skip 1024
align 1
LABELV $3453
skip 1024
align 1
LABELV $3454
skip 32
data
align 4
LABELV $3455
byte 4 -1
align 4
LABELV $3456
byte 4 0
code
proc UI_FeederItemText 64 20
line 4150
;4149:
;4150:static const char *UI_FeederItemText(float feederID, int index, int column, qhandle_t *handle) {
line 4156
;4151:	static char info[MAX_STRING_CHARS];
;4152:	static char hostname[1024];
;4153:	static char clientBuff[32];
;4154:	static int lastColumn = -1;
;4155:	static int lastTime = 0;
;4156:	*handle = -1;
ADDRFP4 12
INDIRP4
CNSTI4 -1
ASGNI4
line 4157
;4157:	if (feederID == FEEDER_HEADS) {
ADDRFP4 0
INDIRF4
CNSTF4 0
NEF4 $3457
line 4159
;4158:		int actual;
;4159:		return UI_SelectedHead(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 UI_SelectedHead
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
RETP4
ADDRGP4 $3451
JUMPV
LABELV $3457
line 4160
;4160:	} else if (feederID == FEEDER_Q3HEADS) {
ADDRFP4 0
INDIRF4
CNSTF4 1094713344
NEF4 $3459
line 4161
;4161:		if (index >= 0 && index < uiInfo.q3HeadCount) {
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $3460
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+119488
INDIRI4
GEI4 $3460
line 4162
;4162:			return uiInfo.q3HeadNames[index];
ADDRFP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+119492
ADDP4
RETP4
ADDRGP4 $3451
JUMPV
line 4164
;4163:		}
;4164:	} else if (feederID == FEEDER_MAPS || feederID == FEEDER_ALLMAPS) {
LABELV $3459
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
EQF4 $3467
ADDRLP4 0
INDIRF4
CNSTF4 1082130432
NEF4 $3465
LABELV $3467
line 4166
;4165:		int actual;
;4166:		return UI_SelectedMap(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 UI_SelectedMap
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
RETP4
ADDRGP4 $3451
JUMPV
LABELV $3465
line 4167
;4167:	} else if (feederID == FEEDER_SERVERS) {
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
NEF4 $3468
line 4168
;4168:		if (index >= 0 && index < uiInfo.serverStatus.numDisplayServers) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3469
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+99264+10412
INDIRI4
GEI4 $3469
line 4170
;4169:			int ping, game, punkbuster;
;4170:			if (lastColumn != column || lastTime > uiInfo.uiDC.realTime + 5000) {
ADDRGP4 $3455
INDIRI4
ADDRFP4 8
INDIRI4
NEI4 $3477
ADDRGP4 $3456
INDIRI4
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 5000
ADDI4
LEI4 $3474
LABELV $3477
line 4171
;4171:				trap_LAN_GetServerInfo(ui_netSource.integer, uiInfo.serverStatus.displayServers[index], info, MAX_STRING_CHARS);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99264+2220
ADDP4
INDIRI4
ARGI4
ADDRGP4 $3452
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerInfo
CALLV
pop
line 4172
;4172:				lastColumn = column;
ADDRGP4 $3455
ADDRFP4 8
INDIRI4
ASGNI4
line 4173
;4173:				lastTime = uiInfo.uiDC.realTime;
ADDRGP4 $3456
ADDRGP4 uiInfo+208
INDIRI4
ASGNI4
line 4174
;4174:			}
LABELV $3474
line 4175
;4175:			ping = atoi(Info_ValueForKey(info, "ping"));
ADDRGP4 $3452
ARGP4
ADDRGP4 $3101
ARGP4
ADDRLP4 20
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 24
INDIRI4
ASGNI4
line 4176
;4176:			if (ping == -1) {
ADDRLP4 8
INDIRI4
CNSTI4 -1
NEI4 $3482
line 4179
;4177:				// if we ever see a ping that is out of date, do a server refresh
;4178:				// UI_UpdatePendingPings();
;4179:			}
LABELV $3482
line 4180
;4180:			switch (column) {
ADDRLP4 28
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $3469
ADDRLP4 28
INDIRI4
CNSTI4 5
GTI4 $3469
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $3512
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $3512
address $3486
address $3495
address $3496
address $3498
address $3502
address $3506
code
LABELV $3486
line 4182
;4181:			case SORT_HOST:
;4182:				if (ping <= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
GTI4 $3487
line 4183
;4183:					return Info_ValueForKey(info, "addr");
ADDRGP4 $3452
ARGP4
ADDRGP4 $2678
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
RETP4
ADDRGP4 $3451
JUMPV
LABELV $3487
line 4184
;4184:				} else {
line 4185
;4185:					if (ui_netSource.integer == AS_LOCAL) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
NEI4 $3489
line 4186
;4186:						Com_sprintf(hostname, sizeof(hostname), "%s [%s]",
ADDRGP4 $3452
ARGP4
ADDRGP4 $2677
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $3452
ARGP4
ADDRGP4 $3493
ARGP4
ADDRLP4 36
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 $3453
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $3492
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 40
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 netnames
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4189
;4187:							Info_ValueForKey(info, "hostname"),
;4188:							netnames[atoi(Info_ValueForKey(info, "nettype"))]);
;4189:						return hostname;
ADDRGP4 $3453
RETP4
ADDRGP4 $3451
JUMPV
LABELV $3489
line 4190
;4190:					} else {
line 4191
;4191:						Com_sprintf(hostname, sizeof(hostname), "%s", Info_ValueForKey(info, "hostname"));
ADDRGP4 $3452
ARGP4
ADDRGP4 $2677
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $3453
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $3494
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4192
;4192:						return hostname;
ADDRGP4 $3453
RETP4
ADDRGP4 $3451
JUMPV
LABELV $3495
line 4195
;4193:					}
;4194:				}
;4195:			case SORT_MAP: return Info_ValueForKey(info, "mapname");
ADDRGP4 $3452
ARGP4
ADDRGP4 $3058
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
RETP4
ADDRGP4 $3451
JUMPV
LABELV $3496
line 4197
;4196:			case SORT_CLIENTS:
;4197:				Com_sprintf(clientBuff, sizeof(clientBuff), "%s (%s)", Info_ValueForKey(info, "clients"), Info_ValueForKey(info, "sv_maxclients"));
ADDRGP4 $3452
ARGP4
ADDRGP4 $3004
ARGP4
ADDRLP4 36
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $3452
ARGP4
ADDRGP4 $1351
ARGP4
ADDRLP4 40
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $3454
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $3497
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4198
;4198:				return clientBuff;
ADDRGP4 $3454
RETP4
ADDRGP4 $3451
JUMPV
LABELV $3498
line 4200
;4199:			case SORT_GAME:
;4200:				game = atoi(Info_ValueForKey(info, "gametype"));
ADDRGP4 $3452
ARGP4
ADDRGP4 $3024
ARGP4
ADDRLP4 44
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 48
INDIRI4
ASGNI4
line 4201
;4201:				if (game >= 0 && game < numTeamArenaGameTypes) {
ADDRLP4 52
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
LTI4 $3499
ADDRLP4 52
INDIRI4
ADDRGP4 numTeamArenaGameTypes
INDIRI4
GEI4 $3499
line 4202
;4202:					return teamArenaGameTypes[game];
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 teamArenaGameTypes
ADDP4
INDIRP4
RETP4
ADDRGP4 $3451
JUMPV
LABELV $3499
line 4203
;4203:				} else {
line 4204
;4204:					return "Unknown";
ADDRGP4 $3501
RETP4
ADDRGP4 $3451
JUMPV
LABELV $3502
line 4207
;4205:				}
;4206:			case SORT_PING:
;4207:				if (ping <= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
GTI4 $3503
line 4208
;4208:					return "...";
ADDRGP4 $3505
RETP4
ADDRGP4 $3451
JUMPV
LABELV $3503
line 4209
;4209:				} else {
line 4210
;4210:					return Info_ValueForKey(info, "ping");
ADDRGP4 $3452
ARGP4
ADDRGP4 $3101
ARGP4
ADDRLP4 56
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 56
INDIRP4
RETP4
ADDRGP4 $3451
JUMPV
LABELV $3506
line 4213
;4211:				}
;4212:			case SORT_PUNKBUSTER:
;4213:				punkbuster = atoi(Info_ValueForKey(info, "punkbuster"));
ADDRGP4 $3452
ARGP4
ADDRGP4 $3507
ARGP4
ADDRLP4 56
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 60
INDIRI4
ASGNI4
line 4214
;4214:				if (punkbuster) {
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $3508
line 4215
;4215:					return "Yes";
ADDRGP4 $3510
RETP4
ADDRGP4 $3451
JUMPV
LABELV $3508
line 4216
;4216:				} else {
line 4217
;4217:					return "No";
ADDRGP4 $3511
RETP4
ADDRGP4 $3451
JUMPV
line 4220
;4218:				}
;4219:			}
;4220:		}
line 4221
;4221:	} else if (feederID == FEEDER_SERVERSTATUS) {
LABELV $3468
ADDRFP4 0
INDIRF4
CNSTF4 1095761920
NEF4 $3513
line 4222
;4222:		if (index >= 0 && index < uiInfo.serverStatusInfo.numLines) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3514
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+110812+3328
INDIRI4
GEI4 $3514
line 4223
;4223:			if (column >= 0 && column < 4) {
ADDRLP4 8
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $3514
ADDRLP4 8
INDIRI4
CNSTI4 4
GEI4 $3514
line 4224
;4224:				return uiInfo.serverStatusInfo.lines[index][column];
ADDRFP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 uiInfo+110812+64
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $3451
JUMPV
line 4226
;4225:			}
;4226:		}
line 4227
;4227:	} else if (feederID == FEEDER_FINDPLAYER) {
LABELV $3513
ADDRFP4 0
INDIRF4
CNSTF4 1096810496
NEF4 $3523
line 4228
;4228:		if (index >= 0 && index < uiInfo.numFoundPlayerServers) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3524
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+119468
INDIRI4
GEI4 $3524
line 4230
;4229:			//return uiInfo.foundPlayerServerAddresses[index];
;4230:			return uiInfo.foundPlayerServerNames[index];
ADDRFP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+118440
ADDP4
RETP4
ADDRGP4 $3451
JUMPV
line 4232
;4231:		}
;4232:	} else if (feederID == FEEDER_PLAYER_LIST) {
LABELV $3523
ADDRFP4 0
INDIRF4
CNSTF4 1088421888
NEF4 $3529
line 4233
;4233:		if (index >= 0 && index < uiInfo.playerCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3530
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+78844
INDIRI4
GEI4 $3530
line 4234
;4234:			return uiInfo.playerNames[index];
ADDRFP4 4
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+78872
ADDP4
RETP4
ADDRGP4 $3451
JUMPV
line 4236
;4235:		}
;4236:	} else if (feederID == FEEDER_TEAM_LIST) {
LABELV $3529
ADDRFP4 0
INDIRF4
CNSTF4 1090519040
NEF4 $3535
line 4237
;4237:		if (index >= 0 && index < uiInfo.myTeamCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3536
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+78848
INDIRI4
GEI4 $3536
line 4238
;4238:			return uiInfo.teamNames[index];
ADDRFP4 4
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+80920
ADDP4
RETP4
ADDRGP4 $3451
JUMPV
line 4240
;4239:		}
;4240:	} else if (feederID == FEEDER_MODS) {
LABELV $3535
ADDRFP4 0
INDIRF4
CNSTF4 1091567616
NEF4 $3541
line 4241
;4241:		if (index >= 0 && index < uiInfo.modCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3542
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+97188
INDIRI4
GEI4 $3542
line 4242
;4242:			if (uiInfo.modList[index].modDescr && *uiInfo.modList[index].modDescr) {
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+96676+4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3546
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+96676+4
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3546
line 4243
;4243:				return uiInfo.modList[index].modDescr;
ADDRFP4 4
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+96676+4
ADDP4
INDIRP4
RETP4
ADDRGP4 $3451
JUMPV
LABELV $3546
line 4244
;4244:			} else {
line 4245
;4245:				return uiInfo.modList[index].modName;
ADDRFP4 4
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+96676
ADDP4
INDIRP4
RETP4
ADDRGP4 $3451
JUMPV
line 4248
;4246:			}
;4247:		}
;4248:	} else if (feederID == FEEDER_CINEMATICS) {
LABELV $3541
ADDRFP4 0
INDIRF4
CNSTF4 1097859072
NEF4 $3555
line 4249
;4249:		if (index >= 0 && index < uiInfo.movieCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3556
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+99252
INDIRI4
GEI4 $3556
line 4250
;4250:			return uiInfo.movieList[index];
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+98228
ADDP4
INDIRP4
RETP4
ADDRGP4 $3451
JUMPV
line 4252
;4251:		}
;4252:	} else if (feederID == FEEDER_DEMOS) {
LABELV $3555
ADDRFP4 0
INDIRF4
CNSTF4 1092616192
NEF4 $3561
line 4253
;4253:		if (index >= 0 && index < uiInfo.demoCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3563
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+98220
INDIRI4
GEI4 $3563
line 4254
;4254:			return uiInfo.demoList[index];
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+97196
ADDP4
INDIRP4
RETP4
ADDRGP4 $3451
JUMPV
LABELV $3563
line 4256
;4255:		}
;4256:	}
LABELV $3561
LABELV $3556
LABELV $3542
LABELV $3536
LABELV $3530
LABELV $3524
LABELV $3514
LABELV $3469
LABELV $3460
line 4257
;4257:	return "";
ADDRGP4 $110
RETP4
LABELV $3451
endproc UI_FeederItemText 64 20
proc UI_FeederItemImage 20 8
line 4261
;4258:}
;4259:
;4260:
;4261:static qhandle_t UI_FeederItemImage(float feederID, int index) {
line 4262
;4262:	if (feederID == FEEDER_HEADS) {
ADDRFP4 0
INDIRF4
CNSTF4 0
NEF4 $3568
line 4264
;4263:		int actual;
;4264:		UI_SelectedHead(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 UI_SelectedHead
CALLP4
pop
line 4265
;4265:		index = actual;
ADDRFP4 4
ADDRLP4 0
INDIRI4
ASGNI4
line 4266
;4266:		if (index >= 0 && index < uiInfo.characterCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3569
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+73440
INDIRI4
GEI4 $3569
line 4267
;4267:			if (uiInfo.characterList[index].headImage == -1) {
ADDRFP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448+8
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $3573
line 4268
;4268:				uiInfo.characterList[index].headImage = trap_R_RegisterShaderNoMip(uiInfo.characterList[index].imageName);
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448+8
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 4269
;4269:			}
LABELV $3573
line 4270
;4270:			return uiInfo.characterList[index].headImage;
ADDRFP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448+8
ADDP4
INDIRI4
RETI4
ADDRGP4 $3567
JUMPV
line 4272
;4271:		}
;4272:	} else if (feederID == FEEDER_Q3HEADS) {
LABELV $3568
ADDRFP4 0
INDIRF4
CNSTF4 1094713344
NEF4 $3583
line 4273
;4273:		if (index >= 0 && index < uiInfo.q3HeadCount) {
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $3584
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+119488
INDIRI4
GEI4 $3584
line 4274
;4274:			return uiInfo.q3HeadIcons[index];
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+135876
ADDP4
INDIRI4
RETI4
ADDRGP4 $3567
JUMPV
line 4276
;4275:		}
;4276:	} else if (feederID == FEEDER_ALLMAPS || feederID == FEEDER_MAPS) {
LABELV $3583
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 1082130432
EQF4 $3591
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
NEF4 $3589
LABELV $3591
line 4278
;4277:		int actual;
;4278:		UI_SelectedMap(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 UI_SelectedMap
CALLP4
pop
line 4279
;4279:		index = actual;
ADDRFP4 4
ADDRLP4 4
INDIRI4
ASGNI4
line 4280
;4280:		if (index >= 0 && index < uiInfo.mapCount) {
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $3592
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+83224
INDIRI4
GEI4 $3592
line 4281
;4281:			if (uiInfo.mapList[index].levelShot == -1) {
ADDRFP4 4
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+92
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $3595
line 4282
;4282:				uiInfo.mapList[index].levelShot = trap_R_RegisterShaderNoMip(uiInfo.mapList[index].imageName);
ADDRLP4 12
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+8
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+92
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 4283
;4283:			}
LABELV $3595
line 4284
;4284:			return uiInfo.mapList[index].levelShot;
ADDRFP4 4
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+92
ADDP4
INDIRI4
RETI4
ADDRGP4 $3567
JUMPV
LABELV $3592
line 4286
;4285:		}
;4286:	}
LABELV $3589
LABELV $3584
LABELV $3569
line 4287
;4287:	return 0;
CNSTI4 0
RETI4
LABELV $3567
endproc UI_FeederItemImage 20 8
bss
align 1
LABELV $3606
skip 1024
code
proc UI_FeederSelection 36 24
line 4290
;4288:}
;4289:
;4290:static void UI_FeederSelection(float feederID, int index) {
line 4292
;4291:	static char info[MAX_STRING_CHARS];
;4292:	if (feederID == FEEDER_HEADS) {
ADDRFP4 0
INDIRF4
CNSTF4 0
NEF4 $3607
line 4294
;4293:		int actual;
;4294:		UI_SelectedHead(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 UI_SelectedHead
CALLP4
pop
line 4295
;4295:		index = actual;
ADDRFP4 4
ADDRLP4 0
INDIRI4
ASGNI4
line 4296
;4296:		if (index >= 0 && index < uiInfo.characterCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3608
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+73440
INDIRI4
GEI4 $3608
line 4297
;4297:			trap_Cvar_Set("team_model", va("%s", uiInfo.characterList[index].base));
ADDRGP4 $3494
ARGP4
ADDRFP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448+12
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $957
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4298
;4298:			trap_Cvar_Set("team_headmodel", va("*%s", uiInfo.characterList[index].name));
ADDRGP4 $3614
ARGP4
ADDRFP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $958
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4299
;4299:			updateModel = qtrue;
ADDRGP4 updateModel
CNSTI4 1
ASGNI4
line 4300
;4300:		}
line 4301
;4301:	} else if (feederID == FEEDER_Q3HEADS) {
ADDRGP4 $3608
JUMPV
LABELV $3607
ADDRFP4 0
INDIRF4
CNSTF4 1094713344
NEF4 $3616
line 4302
;4302:		if (index >= 0 && index < uiInfo.q3HeadCount) {
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $3617
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+119488
INDIRI4
GEI4 $3617
line 4303
;4303:			trap_Cvar_Set("model", uiInfo.q3HeadNames[index]);
ADDRGP4 $953
ARGP4
ADDRFP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+119492
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4304
;4304:			trap_Cvar_Set("headmodel", uiInfo.q3HeadNames[index]);
ADDRGP4 $954
ARGP4
ADDRFP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+119492
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4305
;4305:			updateModel = qtrue;
ADDRGP4 updateModel
CNSTI4 1
ASGNI4
line 4306
;4306:		}
line 4307
;4307:	} else if (feederID == FEEDER_MAPS || feederID == FEEDER_ALLMAPS) {
ADDRGP4 $3617
JUMPV
LABELV $3616
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
EQF4 $3625
ADDRLP4 0
INDIRF4
CNSTF4 1082130432
NEF4 $3623
LABELV $3625
line 4309
;4308:		int actual, map;
;4309:		map = (feederID == FEEDER_ALLMAPS) ? ui_currentNetMap.integer : ui_currentMap.integer;
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
NEF4 $3629
ADDRLP4 12
ADDRGP4 ui_currentNetMap+12
INDIRI4
ASGNI4
ADDRGP4 $3630
JUMPV
LABELV $3629
ADDRLP4 12
ADDRGP4 ui_currentMap+12
INDIRI4
ASGNI4
LABELV $3630
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 4310
;4310:		if (uiInfo.mapList[map].cinematic >= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+24
ADDP4
INDIRI4
CNSTI4 0
LTI4 $3631
line 4311
;4311:			trap_CIN_StopCinematic(uiInfo.mapList[map].cinematic);
ADDRLP4 8
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+24
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 4312
;4312:			uiInfo.mapList[map].cinematic = -1;
ADDRLP4 8
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+24
ADDP4
CNSTI4 -1
ASGNI4
line 4313
;4313:		}
LABELV $3631
line 4314
;4314:		UI_SelectedMap(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 UI_SelectedMap
CALLP4
pop
line 4315
;4315:		trap_Cvar_Set("ui_mapIndex", va("%d", index));
ADDRGP4 $704
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2187
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4316
;4316:		ui_mapIndex.integer = index;
ADDRGP4 ui_mapIndex+12
ADDRFP4 4
INDIRI4
ASGNI4
line 4318
;4317:
;4318:		if (feederID == FEEDER_MAPS) {
ADDRFP4 0
INDIRF4
CNSTF4 1065353216
NEF4 $3640
line 4319
;4319:			ui_currentMap.integer = actual;
ADDRGP4 ui_currentMap+12
ADDRLP4 4
INDIRI4
ASGNI4
line 4320
;4320:			trap_Cvar_Set("ui_currentMap", va("%d", actual));
ADDRGP4 $704
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $879
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4321
;4321:			uiInfo.mapList[ui_currentMap.integer].cinematic = trap_CIN_PlayCinematic(va("%s.roq", uiInfo.mapList[ui_currentMap.integer].mapLoadName), 0, 0, 0, 0, (CIN_loop | CIN_silent));
ADDRGP4 $781
ARGP4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 28
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+24
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 4322
;4322:			UI_LoadBestScores(uiInfo.mapList[ui_currentMap.integer].mapLoadName, uiInfo.gameTypes[ui_gameType.integer].gtEnum);
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580+4
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_LoadBestScores
CALLV
pop
line 4323
;4323:			trap_Cvar_Set("ui_opponentModel", uiInfo.mapList[ui_currentMap.integer].opponentName);
ADDRGP4 $1083
ARGP4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+12
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4324
;4324:			updateOpponentModel = qtrue;
ADDRGP4 updateOpponentModel
CNSTI4 1
ASGNI4
line 4325
;4325:		} else {
ADDRGP4 $3624
JUMPV
LABELV $3640
line 4326
;4326:			ui_currentNetMap.integer = actual;
ADDRGP4 ui_currentNetMap+12
ADDRLP4 4
INDIRI4
ASGNI4
line 4327
;4327:			trap_Cvar_Set("ui_currentNetMap", va("%d", actual));
ADDRGP4 $704
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $877
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4328
;4328:			uiInfo.mapList[ui_currentNetMap.integer].cinematic = trap_CIN_PlayCinematic(va("%s.roq", uiInfo.mapList[ui_currentNetMap.integer].mapLoadName), 0, 0, 0, 0, (CIN_loop | CIN_silent));
ADDRGP4 $781
ARGP4
ADDRGP4 ui_currentNetMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 28
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRGP4 ui_currentNetMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+24
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 4329
;4329:		}
line 4331
;4330:
;4331:	} else if (feederID == FEEDER_SERVERS) {
ADDRGP4 $3624
JUMPV
LABELV $3623
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
NEF4 $3665
line 4332
;4332:		const char *mapName = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 4333
;4333:		uiInfo.serverStatus.currentServer = index;
ADDRGP4 uiInfo+99264+2216
ADDRFP4 4
INDIRI4
ASGNI4
line 4334
;4334:		trap_LAN_GetServerInfo(ui_netSource.integer, uiInfo.serverStatus.displayServers[index], info, MAX_STRING_CHARS);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+99264+2220
ADDP4
INDIRI4
ARGI4
ADDRGP4 $3606
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerInfo
CALLV
pop
line 4335
;4335:		uiInfo.serverStatus.currentServerPreview = trap_R_RegisterShaderNoMip(va("levelshots/%s", Info_ValueForKey(info, "mapname")));
ADDRGP4 $3606
ARGP4
ADDRGP4 $3058
ARGP4
ADDRLP4 8
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $1030
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+99264+10428
ADDRLP4 16
INDIRI4
ASGNI4
line 4336
;4336:		if (uiInfo.serverStatus.currentServerCinematic >= 0) {
ADDRGP4 uiInfo+99264+10432
INDIRI4
CNSTI4 0
LTI4 $3674
line 4337
;4337:			trap_CIN_StopCinematic(uiInfo.serverStatus.currentServerCinematic);
ADDRGP4 uiInfo+99264+10432
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 4338
;4338:			uiInfo.serverStatus.currentServerCinematic = -1;
ADDRGP4 uiInfo+99264+10432
CNSTI4 -1
ASGNI4
line 4339
;4339:		}
LABELV $3674
line 4340
;4340:		mapName = Info_ValueForKey(info, "mapname");
ADDRGP4 $3606
ARGP4
ADDRGP4 $3058
ARGP4
ADDRLP4 20
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 4341
;4341:		if (mapName && *mapName) {
ADDRLP4 24
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3666
ADDRLP4 24
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3666
line 4342
;4342:			uiInfo.serverStatus.currentServerCinematic = trap_CIN_PlayCinematic(va("%s.roq", mapName), 0, 0, 0, 0, (CIN_loop | CIN_silent));
ADDRGP4 $781
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 32
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRGP4 uiInfo+99264+10432
ADDRLP4 32
INDIRI4
ASGNI4
line 4343
;4343:		}
line 4344
;4344:	} else if (feederID == FEEDER_SERVERSTATUS) {
ADDRGP4 $3666
JUMPV
LABELV $3665
ADDRFP4 0
INDIRF4
CNSTF4 1095761920
NEF4 $3686
line 4346
;4345:		//
;4346:	} else if (feederID == FEEDER_FINDPLAYER) {
ADDRGP4 $3687
JUMPV
LABELV $3686
ADDRFP4 0
INDIRF4
CNSTF4 1096810496
NEF4 $3688
line 4347
;4347:		uiInfo.currentFoundPlayerServer = index;
ADDRGP4 uiInfo+119464
ADDRFP4 4
INDIRI4
ASGNI4
line 4349
;4348:		//
;4349:		if (index < uiInfo.numFoundPlayerServers - 1) {
ADDRFP4 4
INDIRI4
ADDRGP4 uiInfo+119468
INDIRI4
CNSTI4 1
SUBI4
GEI4 $3689
line 4351
;4350:			// build a new server status for this server
;4351:			Q_strncpyz(uiInfo.serverStatusAddress, uiInfo.foundPlayerServerAddresses[uiInfo.currentFoundPlayerServer], sizeof(uiInfo.serverStatusAddress));
ADDRGP4 uiInfo+110748
ARGP4
ADDRGP4 uiInfo+119464
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+117416
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4352
;4352:			Menu_SetFeederSelection(NULL, FEEDER_SERVERSTATUS, 0, NULL);
CNSTP4 0
ARGP4
CNSTI4 13
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 4353
;4353:			UI_BuildServerStatus(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerStatus
CALLV
pop
line 4354
;4354:		}
line 4355
;4355:	} else if (feederID == FEEDER_PLAYER_LIST) {
ADDRGP4 $3689
JUMPV
LABELV $3688
ADDRFP4 0
INDIRF4
CNSTF4 1088421888
NEF4 $3698
line 4356
;4356:		uiInfo.playerIndex = index;
ADDRGP4 uiInfo+78860
ADDRFP4 4
INDIRI4
ASGNI4
line 4357
;4357:	} else if (feederID == FEEDER_TEAM_LIST) {
ADDRGP4 $3699
JUMPV
LABELV $3698
ADDRFP4 0
INDIRF4
CNSTF4 1090519040
NEF4 $3701
line 4358
;4358:		uiInfo.teamIndex = index;
ADDRGP4 uiInfo+78852
ADDRFP4 4
INDIRI4
ASGNI4
line 4359
;4359:	} else if (feederID == FEEDER_MODS) {
ADDRGP4 $3702
JUMPV
LABELV $3701
ADDRFP4 0
INDIRF4
CNSTF4 1091567616
NEF4 $3704
line 4360
;4360:		uiInfo.modIndex = index;
ADDRGP4 uiInfo+97192
ADDRFP4 4
INDIRI4
ASGNI4
line 4361
;4361:	} else if (feederID == FEEDER_CINEMATICS) {
ADDRGP4 $3705
JUMPV
LABELV $3704
ADDRFP4 0
INDIRF4
CNSTF4 1097859072
NEF4 $3707
line 4362
;4362:		uiInfo.movieIndex = index;
ADDRGP4 uiInfo+99256
ADDRFP4 4
INDIRI4
ASGNI4
line 4363
;4363:		if (uiInfo.previewMovie >= 0) {
ADDRGP4 uiInfo+99260
INDIRI4
CNSTI4 0
LTI4 $3710
line 4364
;4364:			trap_CIN_StopCinematic(uiInfo.previewMovie);
ADDRGP4 uiInfo+99260
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 4365
;4365:		}
LABELV $3710
line 4366
;4366:		uiInfo.previewMovie = -1;
ADDRGP4 uiInfo+99260
CNSTI4 -1
ASGNI4
line 4367
;4367:	} else if (feederID == FEEDER_DEMOS) {
ADDRGP4 $3708
JUMPV
LABELV $3707
ADDRFP4 0
INDIRF4
CNSTF4 1092616192
NEF4 $3715
line 4368
;4368:		uiInfo.demoIndex = index;
ADDRGP4 uiInfo+98224
ADDRFP4 4
INDIRI4
ASGNI4
line 4369
;4369:	}
LABELV $3715
LABELV $3708
LABELV $3705
LABELV $3702
LABELV $3699
LABELV $3689
LABELV $3687
LABELV $3666
LABELV $3624
LABELV $3617
LABELV $3608
line 4370
;4370:}
LABELV $3605
endproc UI_FeederSelection 36 24
proc Team_Parse 60 12
line 4372
;4371:
;4372:static qboolean Team_Parse(char **p) {
line 4377
;4373:	char *token;
;4374:	const char *tempStr;
;4375:	int i;
;4376:
;4377:	token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 12
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
ASGNP4
line 4379
;4378:
;4379:	if (token[0] != '{') {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $3722
line 4380
;4380:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3718
JUMPV
LABELV $3721
line 4383
;4381:	}
;4382:
;4383:	while (1) {
line 4385
;4384:
;4385:		token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 4387
;4386:
;4387:		if (Q_stricmp(token, "}") == 0) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $440
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $3724
line 4388
;4388:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3718
JUMPV
LABELV $3724
line 4391
;4389:		}
;4390:
;4391:		if (!token || token[0] == 0) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3728
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3726
LABELV $3728
line 4392
;4392:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3718
JUMPV
LABELV $3726
line 4395
;4393:		}
;4394:
;4395:		if (token[0] == '{') {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $3729
line 4397
;4396:			// seven tokens per line, team name and icon, and 5 team member names
;4397:			if (!String_Parse(p, &uiInfo.teamList[uiInfo.teamCount].teamName) || !String_Parse(p, &tempStr)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+75756
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $3735
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 32
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $3731
LABELV $3735
line 4398
;4398:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3718
JUMPV
LABELV $3731
line 4402
;4399:			}
;4400:
;4401:
;4402:			uiInfo.teamList[uiInfo.teamCount].imageName = tempStr;
ADDRGP4 uiInfo+75756
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
ADDRLP4 8
INDIRP4
ASGNP4
line 4403
;4403:			uiInfo.teamList[uiInfo.teamCount].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[uiInfo.teamCount].imageName);
ADDRGP4 uiInfo+75756
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+75756
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+28
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 4404
;4404:			uiInfo.teamList[uiInfo.teamCount].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal", uiInfo.teamList[uiInfo.teamCount].imageName));
ADDRGP4 $757
ARGP4
ADDRGP4 uiInfo+75756
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+75756
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+32
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 4405
;4405:			uiInfo.teamList[uiInfo.teamCount].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[uiInfo.teamCount].imageName));
ADDRGP4 $762
ARGP4
ADDRGP4 uiInfo+75756
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+75756
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+36
ADDP4
ADDRLP4 52
INDIRI4
ASGNI4
line 4407
;4406:
;4407:			uiInfo.teamList[uiInfo.teamCount].cinematic = -1;
ADDRGP4 uiInfo+75756
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+40
ADDP4
CNSTI4 -1
ASGNI4
line 4409
;4408:
;4409:			for (i = 0; i < TEAM_MEMBERS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $3760
line 4410
;4410:				uiInfo.teamList[uiInfo.teamCount].teamMembers[i] = NULL;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+75756
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+8
ADDP4
ADDP4
CNSTP4 0
ASGNP4
line 4411
;4411:				if (!String_Parse(p, &uiInfo.teamList[uiInfo.teamCount].teamMembers[i])) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+75756
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+8
ADDP4
ADDP4
ARGP4
ADDRLP4 56
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $3767
line 4412
;4412:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3718
JUMPV
LABELV $3767
line 4414
;4413:				}
;4414:			}
LABELV $3761
line 4409
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 5
LTI4 $3760
line 4416
;4415:
;4416:			Com_Printf("Loaded team %s with team icon %s.\n", uiInfo.teamList[uiInfo.teamCount].teamName, tempStr);
ADDRGP4 $3772
ARGP4
ADDRGP4 uiInfo+75756
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4417
;4417:			if (uiInfo.teamCount < MAX_TEAMS) {
ADDRGP4 uiInfo+75756
INDIRI4
CNSTI4 64
GEI4 $3775
line 4418
;4418:				uiInfo.teamCount++;
ADDRLP4 56
ADDRGP4 uiInfo+75756
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4419
;4419:			} else {
ADDRGP4 $3776
JUMPV
LABELV $3775
line 4420
;4420:				Com_Printf("Too many teams, last team replaced!\n");
ADDRGP4 $3779
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4421
;4421:			}
LABELV $3776
line 4422
;4422:			token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 56
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 56
INDIRP4
ASGNP4
line 4423
;4423:			if (token[0] != '}') {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
EQI4 $3780
line 4424
;4424:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3718
JUMPV
LABELV $3780
line 4426
;4425:			}
;4426:		}
LABELV $3729
line 4427
;4427:	}
LABELV $3722
line 4383
ADDRGP4 $3721
JUMPV
line 4429
;4428:
;4429:	return qfalse;
CNSTI4 0
RETI4
LABELV $3718
endproc Team_Parse 60 12
proc Character_Parse 64 12
line 4432
;4430:}
;4431:
;4432:static qboolean Character_Parse(char **p) {
line 4436
;4433:	char *token;
;4434:	const char *tempStr;
;4435:
;4436:	token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 4438
;4437:
;4438:	if (token[0] != '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $3786
line 4439
;4439:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3782
JUMPV
LABELV $3785
line 4443
;4440:	}
;4441:
;4442:
;4443:	while (1) {
line 4444
;4444:		token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 12
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 4446
;4445:
;4446:		if (Q_stricmp(token, "}") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $440
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $3788
line 4447
;4447:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3782
JUMPV
LABELV $3788
line 4450
;4448:		}
;4449:
;4450:		if (!token || token[0] == 0) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3792
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3790
LABELV $3792
line 4451
;4451:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3782
JUMPV
LABELV $3790
line 4454
;4452:		}
;4453:
;4454:		if (token[0] == '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $3793
line 4456
;4455:			// two tokens per line, character name and sex
;4456:			if (!String_Parse(p, &uiInfo.characterList[uiInfo.characterCount].name) || !String_Parse(p, &tempStr)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+73440
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $3799
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 28
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $3795
LABELV $3799
line 4457
;4457:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3782
JUMPV
LABELV $3795
line 4460
;4458:			}
;4459:
;4460:			uiInfo.characterList[uiInfo.characterCount].headImage = -1;
ADDRGP4 uiInfo+73440
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448+8
ADDP4
CNSTI4 -1
ASGNI4
line 4461
;4461:			uiInfo.characterList[uiInfo.characterCount].imageName = String_Alloc(va("models/players/heads/%s/icon_default.tga", uiInfo.characterList[uiInfo.characterCount].name));
ADDRGP4 $3806
ARGP4
ADDRGP4 uiInfo+73440
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+73440
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448+4
ADDP4
ADDRLP4 36
INDIRP4
ASGNP4
line 4463
;4462:
;4463:			if (tempStr && (!Q_stricmp(tempStr, "female"))) {
ADDRLP4 40
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3809
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 $3811
ARGP4
ADDRLP4 44
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $3809
line 4464
;4464:				uiInfo.characterList[uiInfo.characterCount].base = String_Alloc(va("Janet"));
ADDRGP4 $3815
ARGP4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+73440
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448+12
ADDP4
ADDRLP4 52
INDIRP4
ASGNP4
line 4465
;4465:			} else if (tempStr && (!Q_stricmp(tempStr, "male"))) {
ADDRGP4 $3810
JUMPV
LABELV $3809
ADDRLP4 48
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3816
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 $3818
ARGP4
ADDRLP4 52
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $3816
line 4466
;4466:				uiInfo.characterList[uiInfo.characterCount].base = String_Alloc(va("James"));
ADDRGP4 $1078
ARGP4
ADDRLP4 56
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+73440
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448+12
ADDP4
ADDRLP4 60
INDIRP4
ASGNP4
line 4467
;4467:			} else {
ADDRGP4 $3817
JUMPV
LABELV $3816
line 4468
;4468:				uiInfo.characterList[uiInfo.characterCount].base = String_Alloc(va("%s", tempStr));
ADDRGP4 $3494
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+73440
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448+12
ADDP4
ADDRLP4 60
INDIRP4
ASGNP4
line 4469
;4469:			}
LABELV $3817
LABELV $3810
line 4471
;4470:
;4471:			Com_Printf("Loaded %s character %s.\n", uiInfo.characterList[uiInfo.characterCount].base, uiInfo.characterList[uiInfo.characterCount].name);
ADDRGP4 $3825
ARGP4
ADDRGP4 uiInfo+73440
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448+12
ADDP4
INDIRP4
ARGP4
ADDRGP4 uiInfo+73440
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+73448
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4472
;4472:			if (uiInfo.characterCount < MAX_HEADS) {
ADDRGP4 uiInfo+73440
INDIRI4
CNSTI4 64
GEI4 $3831
line 4473
;4473:				uiInfo.characterCount++;
ADDRLP4 56
ADDRGP4 uiInfo+73440
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4474
;4474:			} else {
ADDRGP4 $3832
JUMPV
LABELV $3831
line 4475
;4475:				Com_Printf("Too many characters, last character replaced!\n");
ADDRGP4 $3835
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4476
;4476:			}
LABELV $3832
line 4478
;4477:
;4478:			token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 56
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
ASGNP4
line 4479
;4479:			if (token[0] != '}') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
EQI4 $3836
line 4480
;4480:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3782
JUMPV
LABELV $3836
line 4482
;4481:			}
;4482:		}
LABELV $3793
line 4483
;4483:	}
LABELV $3786
line 4443
ADDRGP4 $3785
JUMPV
line 4485
;4484:
;4485:	return qfalse;
CNSTI4 0
RETI4
LABELV $3782
endproc Character_Parse 64 12
proc Alias_Parse 36 12
line 4489
;4486:}
;4487:
;4488:
;4489:static qboolean Alias_Parse(char **p) {
line 4492
;4490:	char *token;
;4491:
;4492:	token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 4494
;4493:
;4494:	if (token[0] != '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $3842
line 4495
;4495:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3838
JUMPV
LABELV $3841
line 4498
;4496:	}
;4497:
;4498:	while (1) {
line 4499
;4499:		token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 4501
;4500:
;4501:		if (Q_stricmp(token, "}") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $440
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $3844
line 4502
;4502:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3838
JUMPV
LABELV $3844
line 4505
;4503:		}
;4504:
;4505:		if (!token || token[0] == 0) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3848
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3846
LABELV $3848
line 4506
;4506:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3838
JUMPV
LABELV $3846
line 4509
;4507:		}
;4508:
;4509:		if (token[0] == '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $3849
line 4511
;4510:			// three tokens per line, character name, bot alias, and preferred action a - all purpose, d - defense, o - offense
;4511:			if (!String_Parse(p, &uiInfo.aliasList[uiInfo.aliasCount].name) || !String_Parse(p, &uiInfo.aliasList[uiInfo.aliasCount].ai) || !String_Parse(p, &uiInfo.aliasList[uiInfo.aliasCount].action)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+74984
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+74988
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $3862
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+74984
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+74988+4
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $3862
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+74984
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+74988+8
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $3851
LABELV $3862
line 4512
;4512:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3838
JUMPV
LABELV $3851
line 4515
;4513:			}
;4514:
;4515:			Com_Printf("Loaded character alias %s using character ai %s.\n", uiInfo.aliasList[uiInfo.aliasCount].name, uiInfo.aliasList[uiInfo.aliasCount].ai);
ADDRGP4 $3863
ARGP4
ADDRGP4 uiInfo+74984
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+74988
ADDP4
INDIRP4
ARGP4
ADDRGP4 uiInfo+74984
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+74988+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4516
;4516:			if (uiInfo.aliasCount < MAX_ALIASES) {
ADDRGP4 uiInfo+74984
INDIRI4
CNSTI4 64
GEI4 $3869
line 4517
;4517:				uiInfo.aliasCount++;
ADDRLP4 32
ADDRGP4 uiInfo+74984
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4518
;4518:			} else {
ADDRGP4 $3870
JUMPV
LABELV $3869
line 4519
;4519:				Com_Printf("Too many aliases, last alias replaced!\n");
ADDRGP4 $3873
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4520
;4520:			}
LABELV $3870
line 4522
;4521:
;4522:			token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 32
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 4523
;4523:			if (token[0] != '}') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
EQI4 $3874
line 4524
;4524:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3838
JUMPV
LABELV $3874
line 4526
;4525:			}
;4526:		}
LABELV $3849
line 4527
;4527:	}
LABELV $3842
line 4498
ADDRGP4 $3841
JUMPV
line 4529
;4528:
;4529:	return qfalse;
CNSTI4 0
RETI4
LABELV $3838
endproc Alias_Parse 36 12
proc UI_ParseTeamInfo 44 8
line 4538
;4530:}
;4531:
;4532:
;4533:
;4534:// mode 
;4535:// 0 - high level parsing
;4536:// 1 - team parsing
;4537:// 2 - character parsing
;4538:static void UI_ParseTeamInfo(const char *teamFile) {
line 4541
;4539:	char *token;
;4540:	char *p;
;4541:	char *buff = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 4544
;4542:	//static int mode = 0; TTimo: unused
;4543:
;4544:	buff = GetMenuBuffer(teamFile);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 GetMenuBuffer
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 4545
;4545:	if (!buff) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3877
line 4546
;4546:		return;
ADDRGP4 $3876
JUMPV
LABELV $3877
line 4549
;4547:	}
;4548:
;4549:	p = buff;
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $3880
JUMPV
LABELV $3879
line 4551
;4550:
;4551:	while (1) {
line 4552
;4552:		token = COM_ParseExt(&p, qtrue);
ADDRLP4 4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 4553
;4553:		if (!token || token[0] == 0 || token[0] == '}') {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3885
ADDRLP4 24
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $3885
ADDRLP4 24
INDIRI4
CNSTI4 125
NEI4 $3882
LABELV $3885
line 4554
;4554:			break;
ADDRGP4 $3881
JUMPV
LABELV $3882
line 4557
;4555:		}
;4556:
;4557:		if (Q_stricmp(token, "}") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $440
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $3886
line 4558
;4558:			break;
ADDRGP4 $3881
JUMPV
LABELV $3886
line 4561
;4559:		}
;4560:
;4561:		if (Q_stricmp(token, "teams") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $3890
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $3888
line 4563
;4562:
;4563:			if (Team_Parse(&p)) {
ADDRLP4 4
ARGP4
ADDRLP4 36
ADDRGP4 Team_Parse
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $3881
line 4564
;4564:				continue;
ADDRGP4 $3880
JUMPV
line 4565
;4565:			} else {
line 4566
;4566:				break;
LABELV $3888
line 4570
;4567:			}
;4568:		}
;4569:
;4570:		if (Q_stricmp(token, "characters") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $3895
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $3893
line 4571
;4571:			Character_Parse(&p);
ADDRLP4 4
ARGP4
ADDRGP4 Character_Parse
CALLI4
pop
line 4572
;4572:		}
LABELV $3893
line 4574
;4573:
;4574:		if (Q_stricmp(token, "aliases") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $3898
ARGP4
ADDRLP4 40
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $3896
line 4575
;4575:			Alias_Parse(&p);
ADDRLP4 4
ARGP4
ADDRGP4 Alias_Parse
CALLI4
pop
line 4576
;4576:		}
LABELV $3896
line 4578
;4577:
;4578:	}
LABELV $3880
line 4551
ADDRGP4 $3879
JUMPV
LABELV $3881
line 4580
;4579:
;4580:}
LABELV $3876
endproc UI_ParseTeamInfo 44 8
proc GameType_Parse 28 8
line 4583
;4581:
;4582:
;4583:static qboolean GameType_Parse(char **p, qboolean join) {
line 4586
;4584:	char *token;
;4585:
;4586:	token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 4588
;4587:
;4588:	if (token[0] != '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $3900
line 4589
;4589:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3899
JUMPV
LABELV $3900
line 4592
;4590:	}
;4591:
;4592:	if (join) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $3902
line 4593
;4593:		uiInfo.numJoinGameTypes = 0;
ADDRGP4 uiInfo+78708
CNSTI4 0
ASGNI4
line 4594
;4594:	} else {
ADDRGP4 $3907
JUMPV
LABELV $3902
line 4595
;4595:		uiInfo.numGameTypes = 0;
ADDRGP4 uiInfo+78576
CNSTI4 0
ASGNI4
line 4596
;4596:	}
ADDRGP4 $3907
JUMPV
LABELV $3906
line 4598
;4597:
;4598:	while (1) {
line 4599
;4599:		token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 4601
;4600:
;4601:		if (Q_stricmp(token, "}") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $440
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $3909
line 4602
;4602:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3899
JUMPV
LABELV $3909
line 4605
;4603:		}
;4604:
;4605:		if (!token || token[0] == 0) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3913
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3911
LABELV $3913
line 4606
;4606:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3899
JUMPV
LABELV $3911
line 4609
;4607:		}
;4608:
;4609:		if (token[0] == '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $3914
line 4611
;4610:			// two tokens per line, character name and sex
;4611:			if (join) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $3916
line 4612
;4612:				if (!String_Parse(p, &uiInfo.joinGameTypes[uiInfo.numJoinGameTypes].gameType) || !Int_Parse(p, &uiInfo.joinGameTypes[uiInfo.numJoinGameTypes].gtEnum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+78708
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78712
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $3925
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+78708
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78712+4
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $3917
LABELV $3925
line 4613
;4613:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3899
JUMPV
line 4615
;4614:				}
;4615:			} else {
LABELV $3916
line 4616
;4616:				if (!String_Parse(p, &uiInfo.gameTypes[uiInfo.numGameTypes].gameType) || !Int_Parse(p, &uiInfo.gameTypes[uiInfo.numGameTypes].gtEnum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+78576
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $3933
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+78576
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580+4
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $3926
LABELV $3933
line 4617
;4617:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3899
JUMPV
LABELV $3926
line 4619
;4618:				}
;4619:			}
LABELV $3917
line 4621
;4620:
;4621:			if (join) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $3934
line 4622
;4622:				if (uiInfo.numJoinGameTypes < MAX_GAMETYPES) {
ADDRGP4 uiInfo+78708
INDIRI4
CNSTI4 16
GEI4 $3936
line 4623
;4623:					uiInfo.numJoinGameTypes++;
ADDRLP4 20
ADDRGP4 uiInfo+78708
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4624
;4624:				} else {
ADDRGP4 $3935
JUMPV
LABELV $3936
line 4625
;4625:					Com_Printf("Too many net game types, last one replace!\n");
ADDRGP4 $3940
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4626
;4626:				}
line 4627
;4627:			} else {
ADDRGP4 $3935
JUMPV
LABELV $3934
line 4628
;4628:				if (uiInfo.numGameTypes < MAX_GAMETYPES) {
ADDRGP4 uiInfo+78576
INDIRI4
CNSTI4 16
GEI4 $3941
line 4629
;4629:					uiInfo.numGameTypes++;
ADDRLP4 20
ADDRGP4 uiInfo+78576
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4630
;4630:				} else {
ADDRGP4 $3942
JUMPV
LABELV $3941
line 4631
;4631:					Com_Printf("Too many game types, last one replace!\n");
ADDRGP4 $3945
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4632
;4632:				}
LABELV $3942
line 4633
;4633:			}
LABELV $3935
line 4635
;4634:
;4635:			token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 20
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 4636
;4636:			if (token[0] != '}') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
EQI4 $3946
line 4637
;4637:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3899
JUMPV
LABELV $3946
line 4639
;4638:			}
;4639:		}
LABELV $3914
line 4640
;4640:	}
LABELV $3907
line 4598
ADDRGP4 $3906
JUMPV
line 4641
;4641:	return qfalse;
CNSTI4 0
RETI4
LABELV $3899
endproc GameType_Parse 28 8
proc MapList_Parse 52 8
line 4644
;4642:}
;4643:
;4644:static qboolean MapList_Parse(char **p) {
line 4647
;4645:	char *token;
;4646:
;4647:	token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 4649
;4648:
;4649:	if (token[0] != '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $3949
line 4650
;4650:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3948
JUMPV
LABELV $3949
line 4653
;4651:	}
;4652:
;4653:	uiInfo.mapCount = 0;
ADDRGP4 uiInfo+83224
CNSTI4 0
ASGNI4
ADDRGP4 $3953
JUMPV
LABELV $3952
line 4655
;4654:
;4655:	while (1) {
line 4656
;4656:		token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 4658
;4657:
;4658:		if (Q_stricmp(token, "}") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $440
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $3955
line 4659
;4659:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3948
JUMPV
LABELV $3955
line 4662
;4660:		}
;4661:
;4662:		if (!token || token[0] == 0) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3959
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3957
LABELV $3959
line 4663
;4663:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3948
JUMPV
LABELV $3957
line 4666
;4664:		}
;4665:
;4666:		if (token[0] == '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $3960
line 4667
;4667:			if (!String_Parse(p, &uiInfo.mapList[uiInfo.mapCount].mapName) || !String_Parse(p, &uiInfo.mapList[uiInfo.mapCount].mapLoadName)
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $3973
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+4
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $3973
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+16
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $3962
LABELV $3973
line 4668
;4668:				|| !Int_Parse(p, &uiInfo.mapList[uiInfo.mapCount].teamMembers)) {
line 4669
;4669:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3948
JUMPV
LABELV $3962
line 4672
;4670:			}
;4671:
;4672:			if (!String_Parse(p, &uiInfo.mapList[uiInfo.mapCount].opponentName)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+12
ADDP4
ARGP4
ADDRLP4 32
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $3974
line 4673
;4673:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3948
JUMPV
LABELV $3974
line 4676
;4674:			}
;4675:
;4676:			uiInfo.mapList[uiInfo.mapCount].typeBits = 0;
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+20
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $3983
JUMPV
LABELV $3982
line 4678
;4677:
;4678:			while (1) {
line 4679
;4679:				token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 36
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
line 4680
;4680:				if (token[0] >= '0' && token[0] <= '9') {
ADDRLP4 40
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 48
LTI4 $3984
ADDRLP4 40
INDIRI4
CNSTI4 57
GTI4 $3984
line 4681
;4681:					uiInfo.mapList[uiInfo.mapCount].typeBits |= (1 << (token[0] - 0x030));
ADDRLP4 44
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+20
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
LSHI4
BORI4
ASGNI4
line 4682
;4682:					if (!Int_Parse(p, &uiInfo.mapList[uiInfo.mapCount].timeToBeat[token[0] - 0x30])) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 2
LSHI4
CNSTI4 192
SUBI4
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+28
ADDP4
ADDP4
ARGP4
ADDRLP4 48
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $3986
line 4683
;4683:						return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3948
JUMPV
line 4685
;4684:					}
;4685:				} else {
line 4686
;4686:					break;
LABELV $3986
line 4688
;4687:				}
;4688:			}
LABELV $3983
line 4678
ADDRGP4 $3982
JUMPV
LABELV $3984
line 4695
;4689:
;4690:			//mapList[mapCount].imageName = String_Alloc(va("levelshots/%s", mapList[mapCount].mapLoadName));
;4691:			//if (uiInfo.mapCount == 0) {
;4692:			  // only load the first cinematic, selection loads the others
;4693:			//  uiInfo.mapList[uiInfo.mapCount].cinematic = trap_CIN_PlayCinematic(va("%s.roq",uiInfo.mapList[uiInfo.mapCount].mapLoadName), qfalse, qfalse, qtrue, 0, 0, 0, 0);
;4694:			//}
;4695:			uiInfo.mapList[uiInfo.mapCount].cinematic = -1;
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+24
ADDP4
CNSTI4 -1
ASGNI4
line 4696
;4696:			uiInfo.mapList[uiInfo.mapCount].levelShot = trap_R_RegisterShaderNoMip(va("levelshots/%s_small", uiInfo.mapList[uiInfo.mapCount].mapLoadName));
ADDRGP4 $4001
ARGP4
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+92
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 4698
;4697:
;4698:			if (uiInfo.mapCount < MAX_MAPS) {
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 128
GEI4 $4005
line 4699
;4699:				uiInfo.mapCount++;
ADDRLP4 44
ADDRGP4 uiInfo+83224
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4700
;4700:			} else {
ADDRGP4 $4006
JUMPV
LABELV $4005
line 4701
;4701:				Com_Printf("Too many maps, last one replaced!\n");
ADDRGP4 $4009
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4702
;4702:			}
LABELV $4006
line 4703
;4703:		}
LABELV $3960
line 4704
;4704:	}
LABELV $3953
line 4655
ADDRGP4 $3952
JUMPV
line 4705
;4705:	return qfalse;
CNSTI4 0
RETI4
LABELV $3948
endproc MapList_Parse 52 8
proc UI_ParseGameInfo 44 8
line 4708
;4706:}
;4707:
;4708:static void UI_ParseGameInfo(const char *teamFile) {
line 4711
;4709:	char *token;
;4710:	char *p;
;4711:	char *buff = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 4714
;4712:	//int mode = 0; TTimo: unused
;4713:
;4714:	buff = GetMenuBuffer(teamFile);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 GetMenuBuffer
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 4715
;4715:	if (!buff) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $4011
line 4716
;4716:		return;
ADDRGP4 $4010
JUMPV
LABELV $4011
line 4719
;4717:	}
;4718:
;4719:	p = buff;
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $4014
JUMPV
LABELV $4013
line 4721
;4720:
;4721:	while (1) {
line 4722
;4722:		token = COM_ParseExt(&p, qtrue);
ADDRLP4 4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 4723
;4723:		if (!token || token[0] == 0 || token[0] == '}') {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4019
ADDRLP4 24
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $4019
ADDRLP4 24
INDIRI4
CNSTI4 125
NEI4 $4016
LABELV $4019
line 4724
;4724:			break;
ADDRGP4 $4015
JUMPV
LABELV $4016
line 4727
;4725:		}
;4726:
;4727:		if (Q_stricmp(token, "}") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $440
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $4020
line 4728
;4728:			break;
ADDRGP4 $4015
JUMPV
LABELV $4020
line 4731
;4729:		}
;4730:
;4731:		if (Q_stricmp(token, "gametypes") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $4024
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $4022
line 4733
;4732:
;4733:			if (GameType_Parse(&p, qfalse)) {
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 36
ADDRGP4 GameType_Parse
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $4015
line 4734
;4734:				continue;
ADDRGP4 $4014
JUMPV
line 4735
;4735:			} else {
line 4736
;4736:				break;
LABELV $4022
line 4740
;4737:			}
;4738:		}
;4739:
;4740:		if (Q_stricmp(token, "joingametypes") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $4029
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $4027
line 4742
;4741:
;4742:			if (GameType_Parse(&p, qtrue)) {
ADDRLP4 4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 40
ADDRGP4 GameType_Parse
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $4015
line 4743
;4743:				continue;
ADDRGP4 $4014
JUMPV
line 4744
;4744:			} else {
line 4745
;4745:				break;
LABELV $4027
line 4749
;4746:			}
;4747:		}
;4748:
;4749:		if (Q_stricmp(token, "maps") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $4034
ARGP4
ADDRLP4 40
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $4032
line 4751
;4750:			// start a new menu
;4751:			MapList_Parse(&p);
ADDRLP4 4
ARGP4
ADDRGP4 MapList_Parse
CALLI4
pop
line 4752
;4752:		}
LABELV $4032
line 4754
;4753:
;4754:	}
LABELV $4014
line 4721
ADDRGP4 $4013
JUMPV
LABELV $4015
line 4755
;4755:}
LABELV $4010
endproc UI_ParseGameInfo 44 8
proc UI_Pause 4 8
line 4757
;4756:
;4757:static void UI_Pause(qboolean b) {
line 4758
;4758:	if (b) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $4036
line 4760
;4759:		// pause the game and set the ui keycatcher
;4760:		trap_Cvar_Set("cl_paused", "1");
ADDRGP4 $2578
ARGP4
ADDRGP4 $386
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4761
;4761:		trap_Key_SetCatcher(KEYCATCH_UI);
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 4762
;4762:	} else {
ADDRGP4 $4037
JUMPV
LABELV $4036
line 4764
;4763:		// unpause the game and clear the ui keycatcher
;4764:		trap_Key_SetCatcher(trap_Key_GetCatcher() & ~KEYCATCH_UI);
ADDRLP4 0
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 4765
;4765:		trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 4766
;4766:		trap_Cvar_Set("cl_paused", "0");
ADDRGP4 $2578
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4767
;4767:	}
LABELV $4037
line 4768
;4768:}
LABELV $4035
endproc UI_Pause 4 8
proc UI_PlayCinematic 4 24
line 4770
;4769:
;4770:static int UI_PlayCinematic(const char *name, float x, float y, float w, float h) {
line 4771
;4771:	return trap_CIN_PlayCinematic(name, x, y, w, h, (CIN_loop | CIN_silent));
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 8
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 12
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 16
INDIRF4
CVFI4 4
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 0
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $4038
endproc UI_PlayCinematic 4 24
proc UI_StopCinematic 20 4
line 4774
;4772:}
;4773:
;4774:static void UI_StopCinematic(int handle) {
line 4775
;4775:	if (handle >= 0) {
ADDRFP4 0
INDIRI4
CNSTI4 0
LTI4 $4040
line 4776
;4776:		trap_CIN_StopCinematic(handle);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 4777
;4777:	} else {
ADDRGP4 $4041
JUMPV
LABELV $4040
line 4778
;4778:		handle = abs(handle);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 abs
CALLI4
ASGNI4
ADDRFP4 0
ADDRLP4 0
INDIRI4
ASGNI4
line 4779
;4779:		if (handle == UI_MAPCINEMATIC) {
ADDRFP4 0
INDIRI4
CNSTI4 244
NEI4 $4042
line 4780
;4780:			if (uiInfo.mapList[ui_currentMap.integer].cinematic >= 0) {
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+24
ADDP4
INDIRI4
CNSTI4 0
LTI4 $4043
line 4781
;4781:				trap_CIN_StopCinematic(uiInfo.mapList[ui_currentMap.integer].cinematic);
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+24
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 4782
;4782:				uiInfo.mapList[ui_currentMap.integer].cinematic = -1;
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+24
ADDP4
CNSTI4 -1
ASGNI4
line 4783
;4783:			}
line 4784
;4784:		} else if (handle == UI_NETMAPCINEMATIC) {
ADDRGP4 $4043
JUMPV
LABELV $4042
ADDRFP4 0
INDIRI4
CNSTI4 246
NEI4 $4055
line 4785
;4785:			if (uiInfo.serverStatus.currentServerCinematic >= 0) {
ADDRGP4 uiInfo+99264+10432
INDIRI4
CNSTI4 0
LTI4 $4056
line 4786
;4786:				trap_CIN_StopCinematic(uiInfo.serverStatus.currentServerCinematic);
ADDRGP4 uiInfo+99264+10432
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 4787
;4787:				uiInfo.serverStatus.currentServerCinematic = -1;
ADDRGP4 uiInfo+99264+10432
CNSTI4 -1
ASGNI4
line 4788
;4788:			}
line 4789
;4789:		} else if (handle == UI_CLANCINEMATIC) {
ADDRGP4 $4056
JUMPV
LABELV $4055
ADDRFP4 0
INDIRI4
CNSTI4 251
NEI4 $4065
line 4790
;4790:			int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $689
ARGP4
ADDRLP4 8
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 4791
;4791:			if (i >= 0 && i < uiInfo.teamCount) {
ADDRLP4 16
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
LTI4 $4067
ADDRLP4 16
INDIRI4
ADDRGP4 uiInfo+75756
INDIRI4
GEI4 $4067
line 4792
;4792:				if (uiInfo.teamList[i].cinematic >= 0) {
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+40
ADDP4
INDIRI4
CNSTI4 0
LTI4 $4070
line 4793
;4793:					trap_CIN_StopCinematic(uiInfo.teamList[i].cinematic);
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+40
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 4794
;4794:					uiInfo.teamList[i].cinematic = -1;
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+75760+40
ADDP4
CNSTI4 -1
ASGNI4
line 4795
;4795:				}
LABELV $4070
line 4796
;4796:			}
LABELV $4067
line 4797
;4797:		}
LABELV $4065
LABELV $4056
LABELV $4043
line 4798
;4798:	}
LABELV $4041
line 4799
;4799:}
LABELV $4039
endproc UI_StopCinematic 20 4
proc UI_DrawCinematic 0 20
line 4801
;4800:
;4801:static void UI_DrawCinematic(int handle, float x, float y, float w, float h) {
line 4802
;4802:	trap_CIN_SetExtents(handle, x, y, w, h);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 8
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 12
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 16
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 trap_CIN_SetExtents
CALLV
pop
line 4803
;4803:	trap_CIN_DrawCinematic(handle);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 trap_CIN_DrawCinematic
CALLV
pop
line 4804
;4804:}
LABELV $4078
endproc UI_DrawCinematic 0 20
proc UI_RunCinematicFrame 0 4
line 4806
;4805:
;4806:static void UI_RunCinematicFrame(int handle) {
line 4807
;4807:	trap_CIN_RunCinematic(handle);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 trap_CIN_RunCinematic
CALLI4
pop
line 4808
;4808:}
LABELV $4079
endproc UI_RunCinematicFrame 0 4
proc UI_BuildQ3Model_List 4520 20
line 4817
;4809:
;4810:
;4811:
;4812:/*
;4813:=================
;4814:PlayerModel_BuildList
;4815:=================
;4816:*/
;4817:static void UI_BuildQ3Model_List(void) {
line 4831
;4818:	int		numdirs;
;4819:	int		numfiles;
;4820:	char	dirlist[2048];
;4821:	char	filelist[2048];
;4822:	char	skinname[64];
;4823:	char	scratch[256];
;4824:	char *dirptr;
;4825:	char *fileptr;
;4826:	int		i;
;4827:	int		j, k, dirty;
;4828:	int		dirlen;
;4829:	int		filelen;
;4830:
;4831:	uiInfo.q3HeadCount = 0;
ADDRGP4 uiInfo+119488
CNSTI4 0
ASGNI4
line 4834
;4832:
;4833:	// iterate directory of all player models
;4834:	numdirs = trap_FS_GetFileList("models/players", "/", dirlist, 2048);
ADDRGP4 $4082
ARGP4
ADDRGP4 $4083
ARGP4
ADDRLP4 2408
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 4456
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 2404
ADDRLP4 4456
INDIRI4
ASGNI4
line 4835
;4835:	dirptr = dirlist;
ADDRLP4 340
ADDRLP4 2408
ASGNP4
line 4836
;4836:	for (i = 0; i < numdirs && uiInfo.q3HeadCount < MAX_PLAYERMODELS; i++, dirptr += dirlen + 1) {
ADDRLP4 352
CNSTI4 0
ASGNI4
ADDRGP4 $4087
JUMPV
LABELV $4084
line 4837
;4837:		dirlen = strlen(dirptr);
ADDRLP4 340
INDIRP4
ARGP4
ADDRLP4 4460
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 348
ADDRLP4 4460
INDIRI4
ASGNI4
line 4839
;4838:
;4839:		if (dirlen && dirptr[dirlen - 1] == '/') dirptr[dirlen - 1] = '\0';
ADDRLP4 348
INDIRI4
CNSTI4 0
EQI4 $4089
ADDRLP4 348
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 340
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $4089
ADDRLP4 348
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 340
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
LABELV $4089
line 4841
;4840:
;4841:		if (!strcmp(dirptr, ".") || !strcmp(dirptr, ".."))
ADDRLP4 340
INDIRP4
ARGP4
ADDRGP4 $4093
ARGP4
ADDRLP4 4468
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 4468
INDIRI4
CNSTI4 0
EQI4 $4095
ADDRLP4 340
INDIRP4
ARGP4
ADDRGP4 $4094
ARGP4
ADDRLP4 4472
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 4472
INDIRI4
CNSTI4 0
NEI4 $4091
LABELV $4095
line 4842
;4842:			continue;
ADDRGP4 $4085
JUMPV
LABELV $4091
line 4845
;4843:
;4844:		// iterate all skin files in directory
;4845:		numfiles = trap_FS_GetFileList(va("models/players/%s", dirptr), "tga", filelist, 2048);
ADDRGP4 $4096
ARGP4
ADDRLP4 340
INDIRP4
ARGP4
ADDRLP4 4476
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4476
INDIRP4
ARGP4
ADDRGP4 $4097
ARGP4
ADDRLP4 356
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 4480
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 344
ADDRLP4 4480
INDIRI4
ASGNI4
line 4846
;4846:		fileptr = filelist;
ADDRLP4 328
ADDRLP4 356
ASGNP4
line 4847
;4847:		for (j = 0; j < numfiles && uiInfo.q3HeadCount < MAX_PLAYERMODELS; j++, fileptr += filelen + 1) {
ADDRLP4 332
CNSTI4 0
ASGNI4
ADDRGP4 $4101
JUMPV
LABELV $4098
line 4848
;4848:			filelen = strlen(fileptr);
ADDRLP4 328
INDIRP4
ARGP4
ADDRLP4 4484
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 336
ADDRLP4 4484
INDIRI4
ASGNI4
line 4850
;4849:
;4850:			COM_StripExtension(fileptr, skinname, sizeof(skinname));
ADDRLP4 328
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 COM_StripExtension
CALLV
pop
line 4853
;4851:
;4852:			// look for icon_????
;4853:			if (Q_stricmpn(skinname, "icon_", 5) == 0 && !(Q_stricmp(skinname, "icon_blue") == 0 || Q_stricmp(skinname, "icon_red") == 0)) {
ADDRLP4 260
ARGP4
ADDRGP4 $4105
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 4488
ADDRGP4 Q_stricmpn
CALLI4
ASGNI4
ADDRLP4 4488
INDIRI4
CNSTI4 0
NEI4 $4103
ADDRLP4 260
ARGP4
ADDRGP4 $4106
ARGP4
ADDRLP4 4492
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4492
INDIRI4
CNSTI4 0
EQI4 $4103
ADDRLP4 260
ARGP4
ADDRGP4 $4107
ARGP4
ADDRLP4 4496
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4496
INDIRI4
CNSTI4 0
EQI4 $4103
line 4854
;4854:				if (Q_stricmp(skinname, "icon_default") == 0) {
ADDRLP4 260
ARGP4
ADDRGP4 $4110
ARGP4
ADDRLP4 4500
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4500
INDIRI4
CNSTI4 0
NEI4 $4108
line 4855
;4855:					Com_sprintf(scratch, sizeof(scratch), dirptr);
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 340
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4856
;4856:				} else {
ADDRGP4 $4109
JUMPV
LABELV $4108
line 4857
;4857:					Com_sprintf(scratch, sizeof(scratch), "%s/%s", dirptr, skinname + 5);
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $4111
ARGP4
ADDRLP4 340
INDIRP4
ARGP4
ADDRLP4 260+5
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4858
;4858:				}
LABELV $4109
line 4859
;4859:				dirty = 0;
ADDRLP4 324
CNSTI4 0
ASGNI4
line 4860
;4860:				for (k = 0; k < uiInfo.q3HeadCount; k++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $4116
JUMPV
LABELV $4113
line 4861
;4861:					if (!Q_stricmp(scratch, uiInfo.q3HeadNames[uiInfo.q3HeadCount])) {
ADDRLP4 4
ARGP4
ADDRGP4 uiInfo+119488
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+119492
ADDP4
ARGP4
ADDRLP4 4504
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4504
INDIRI4
CNSTI4 0
NEI4 $4118
line 4862
;4862:						dirty = 1;
ADDRLP4 324
CNSTI4 1
ASGNI4
line 4863
;4863:						break;
ADDRGP4 $4115
JUMPV
LABELV $4118
line 4865
;4864:					}
;4865:				}
LABELV $4114
line 4860
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $4116
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+119488
INDIRI4
LTI4 $4113
LABELV $4115
line 4866
;4866:				if (!dirty) {
ADDRLP4 324
INDIRI4
CNSTI4 0
NEI4 $4122
line 4867
;4867:					Com_sprintf(uiInfo.q3HeadNames[uiInfo.q3HeadCount], sizeof(uiInfo.q3HeadNames[uiInfo.q3HeadCount]), scratch);
ADDRGP4 uiInfo+119488
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+119492
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4868
;4868:					uiInfo.q3HeadIcons[uiInfo.q3HeadCount++] = trap_R_RegisterShaderNoMip(va("models/players/%s/%s", dirptr, skinname));
ADDRLP4 4508
ADDRGP4 uiInfo+119488
ASGNP4
ADDRLP4 4504
ADDRLP4 4508
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 4508
INDIRP4
ADDRLP4 4504
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $4130
ARGP4
ADDRLP4 340
INDIRP4
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 4512
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4512
INDIRP4
ARGP4
ADDRLP4 4516
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 4504
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+135876
ADDP4
ADDRLP4 4516
INDIRI4
ASGNI4
line 4869
;4869:				}
LABELV $4122
line 4870
;4870:			}
LABELV $4103
line 4872
;4871:
;4872:		}
LABELV $4099
line 4847
ADDRLP4 332
ADDRLP4 332
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 328
ADDRLP4 336
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 328
INDIRP4
ADDP4
ASGNP4
LABELV $4101
ADDRLP4 332
INDIRI4
ADDRLP4 344
INDIRI4
GEI4 $4131
ADDRGP4 uiInfo+119488
INDIRI4
CNSTI4 256
LTI4 $4098
LABELV $4131
line 4873
;4873:	}
LABELV $4085
line 4836
ADDRLP4 352
ADDRLP4 352
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 340
ADDRLP4 348
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 340
INDIRP4
ADDP4
ASGNP4
LABELV $4087
ADDRLP4 352
INDIRI4
ADDRLP4 2404
INDIRI4
GEI4 $4132
ADDRGP4 uiInfo+119488
INDIRI4
CNSTI4 256
LTI4 $4084
LABELV $4132
line 4875
;4874:
;4875:}
LABELV $4080
endproc UI_BuildQ3Model_List 4520 20
export _UI_Init
proc _UI_Init 52 16
line 4884
;4876:
;4877:
;4878:
;4879:/*
;4880:=================
;4881:UI_Init
;4882:=================
;4883:*/
;4884:void _UI_Init(qboolean inGameLoad) {
line 4890
;4885:	const char *menuSet;
;4886:	int start;
;4887:
;4888:	//uiInfo.inGameLoad = inGameLoad;
;4889:
;4890:	UI_RegisterCvars();
ADDRGP4 UI_RegisterCvars
CALLV
pop
line 4891
;4891:	UI_InitMemory();
ADDRGP4 UI_InitMemory
CALLV
pop
line 4894
;4892:
;4893:	// cache redundant calulations
;4894:	trap_GetGlconfig(&uiInfo.uiDC.glconfig);
ADDRGP4 uiInfo+62068
ARGP4
ADDRGP4 trap_GetGlconfig
CALLV
pop
line 4897
;4895:
;4896:	// for 640x480 virtualized screen
;4897:	uiInfo.uiDC.yscale = uiInfo.uiDC.glconfig.vidHeight * (1.0 / 480.0);
ADDRGP4 uiInfo+196
ADDRGP4 uiInfo+62068+11308
INDIRI4
CVIF4 4
CNSTF4 990414985
MULF4
ASGNF4
line 4898
;4898:	uiInfo.uiDC.xscale = uiInfo.uiDC.glconfig.vidWidth * (1.0 / 640.0);
ADDRGP4 uiInfo+200
ADDRGP4 uiInfo+62068+11304
INDIRI4
CVIF4 4
CNSTF4 986500301
MULF4
ASGNF4
line 4899
;4899:	if (uiInfo.uiDC.glconfig.vidWidth * 480 > uiInfo.uiDC.glconfig.vidHeight * 640) {
ADDRGP4 uiInfo+62068+11304
INDIRI4
CNSTI4 480
MULI4
ADDRGP4 uiInfo+62068+11308
INDIRI4
CNSTI4 640
MULI4
LEI4 $4141
line 4901
;4900:		// wide screen
;4901:		uiInfo.uiDC.bias = 0.5 * (uiInfo.uiDC.glconfig.vidWidth - (uiInfo.uiDC.glconfig.vidHeight * (640.0 / 480.0)));
ADDRGP4 uiInfo+204
ADDRGP4 uiInfo+62068+11304
INDIRI4
CVIF4 4
ADDRGP4 uiInfo+62068+11308
INDIRI4
CVIF4 4
CNSTF4 1068149419
MULF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 4902
;4902:	} else {
ADDRGP4 $4142
JUMPV
LABELV $4141
line 4904
;4903:		// no wide screen
;4904:		uiInfo.uiDC.bias = 0;
ADDRGP4 uiInfo+204
CNSTF4 0
ASGNF4
line 4905
;4905:	}
LABELV $4142
line 4909
;4906:
;4907:
;4908:	//UI_Load();
;4909:	uiInfo.uiDC.registerShaderNoMip = &trap_R_RegisterShaderNoMip;
ADDRGP4 uiInfo
ADDRGP4 trap_R_RegisterShaderNoMip
ASGNP4
line 4910
;4910:	uiInfo.uiDC.setColor = &UI_SetColor;
ADDRGP4 uiInfo+4
ADDRGP4 UI_SetColor
ASGNP4
line 4911
;4911:	uiInfo.uiDC.drawHandlePic = &UI_DrawHandlePic;
ADDRGP4 uiInfo+8
ADDRGP4 UI_DrawHandlePic
ASGNP4
line 4912
;4912:	uiInfo.uiDC.drawStretchPic = &trap_R_DrawStretchPic;
ADDRGP4 uiInfo+12
ADDRGP4 trap_R_DrawStretchPic
ASGNP4
line 4913
;4913:	uiInfo.uiDC.drawText = &Text_Paint;
ADDRGP4 uiInfo+16
ADDRGP4 Text_Paint
ASGNP4
line 4914
;4914:	uiInfo.uiDC.textWidth = &Text_Width;
ADDRGP4 uiInfo+20
ADDRGP4 Text_Width
ASGNP4
line 4915
;4915:	uiInfo.uiDC.textHeight = &Text_Height;
ADDRGP4 uiInfo+24
ADDRGP4 Text_Height
ASGNP4
line 4916
;4916:	uiInfo.uiDC.registerModel = &trap_R_RegisterModel;
ADDRGP4 uiInfo+28
ADDRGP4 trap_R_RegisterModel
ASGNP4
line 4917
;4917:	uiInfo.uiDC.modelBounds = &trap_R_ModelBounds;
ADDRGP4 uiInfo+32
ADDRGP4 trap_R_ModelBounds
ASGNP4
line 4918
;4918:	uiInfo.uiDC.fillRect = &UI_FillRect;
ADDRGP4 uiInfo+36
ADDRGP4 UI_FillRect
ASGNP4
line 4919
;4919:	uiInfo.uiDC.drawRect = &_UI_DrawRect;
ADDRGP4 uiInfo+40
ADDRGP4 _UI_DrawRect
ASGNP4
line 4920
;4920:	uiInfo.uiDC.drawSides = &_UI_DrawSides;
ADDRGP4 uiInfo+44
ADDRGP4 _UI_DrawSides
ASGNP4
line 4921
;4921:	uiInfo.uiDC.drawTopBottom = &_UI_DrawTopBottom;
ADDRGP4 uiInfo+48
ADDRGP4 _UI_DrawTopBottom
ASGNP4
line 4922
;4922:	uiInfo.uiDC.clearScene = &trap_R_ClearScene;
ADDRGP4 uiInfo+52
ADDRGP4 trap_R_ClearScene
ASGNP4
line 4923
;4923:	uiInfo.uiDC.drawSides = &_UI_DrawSides;
ADDRGP4 uiInfo+44
ADDRGP4 _UI_DrawSides
ASGNP4
line 4924
;4924:	uiInfo.uiDC.addRefEntityToScene = &trap_R_AddRefEntityToScene;
ADDRGP4 uiInfo+56
ADDRGP4 trap_R_AddRefEntityToScene
ASGNP4
line 4925
;4925:	uiInfo.uiDC.renderScene = &trap_R_RenderScene;
ADDRGP4 uiInfo+60
ADDRGP4 trap_R_RenderScene
ASGNP4
line 4926
;4926:	uiInfo.uiDC.registerFont = &trap_R_RegisterFont;
ADDRGP4 uiInfo+64
ADDRGP4 trap_R_RegisterFont
ASGNP4
line 4927
;4927:	uiInfo.uiDC.ownerDrawItem = &UI_OwnerDraw;
ADDRGP4 uiInfo+68
ADDRGP4 UI_OwnerDraw
ASGNP4
line 4928
;4928:	uiInfo.uiDC.getValue = &UI_GetValue;
ADDRGP4 uiInfo+72
ADDRGP4 UI_GetValue
ASGNP4
line 4929
;4929:	uiInfo.uiDC.ownerDrawVisible = &UI_OwnerDrawVisible;
ADDRGP4 uiInfo+76
ADDRGP4 UI_OwnerDrawVisible
ASGNP4
line 4930
;4930:	uiInfo.uiDC.runScript = &UI_RunMenuScript;
ADDRGP4 uiInfo+80
ADDRGP4 UI_RunMenuScript
ASGNP4
line 4931
;4931:	uiInfo.uiDC.getTeamColor = &UI_GetTeamColor;
ADDRGP4 uiInfo+84
ADDRGP4 UI_GetTeamColor
ASGNP4
line 4932
;4932:	uiInfo.uiDC.setCVar = trap_Cvar_Set;
ADDRGP4 uiInfo+96
ADDRGP4 trap_Cvar_Set
ASGNP4
line 4933
;4933:	uiInfo.uiDC.getCVarString = trap_Cvar_VariableStringBuffer;
ADDRGP4 uiInfo+88
ADDRGP4 trap_Cvar_VariableStringBuffer
ASGNP4
line 4934
;4934:	uiInfo.uiDC.getCVarValue = trap_Cvar_VariableValue;
ADDRGP4 uiInfo+92
ADDRGP4 trap_Cvar_VariableValue
ASGNP4
line 4935
;4935:	uiInfo.uiDC.drawTextWithCursor = &Text_PaintWithCursor;
ADDRGP4 uiInfo+100
ADDRGP4 Text_PaintWithCursor
ASGNP4
line 4936
;4936:	uiInfo.uiDC.setOverstrikeMode = &trap_Key_SetOverstrikeMode;
ADDRGP4 uiInfo+104
ADDRGP4 trap_Key_SetOverstrikeMode
ASGNP4
line 4937
;4937:	uiInfo.uiDC.getOverstrikeMode = &trap_Key_GetOverstrikeMode;
ADDRGP4 uiInfo+108
ADDRGP4 trap_Key_GetOverstrikeMode
ASGNP4
line 4938
;4938:	uiInfo.uiDC.startLocalSound = &trap_S_StartLocalSound;
ADDRGP4 uiInfo+112
ADDRGP4 trap_S_StartLocalSound
ASGNP4
line 4939
;4939:	uiInfo.uiDC.ownerDrawHandleKey = &UI_OwnerDrawHandleKey;
ADDRGP4 uiInfo+116
ADDRGP4 UI_OwnerDrawHandleKey
ASGNP4
line 4940
;4940:	uiInfo.uiDC.feederCount = &UI_FeederCount;
ADDRGP4 uiInfo+120
ADDRGP4 UI_FeederCount
ASGNP4
line 4941
;4941:	uiInfo.uiDC.feederItemImage = &UI_FeederItemImage;
ADDRGP4 uiInfo+128
ADDRGP4 UI_FeederItemImage
ASGNP4
line 4942
;4942:	uiInfo.uiDC.feederItemText = &UI_FeederItemText;
ADDRGP4 uiInfo+124
ADDRGP4 UI_FeederItemText
ASGNP4
line 4943
;4943:	uiInfo.uiDC.feederSelection = &UI_FeederSelection;
ADDRGP4 uiInfo+132
ADDRGP4 UI_FeederSelection
ASGNP4
line 4944
;4944:	uiInfo.uiDC.setBinding = &trap_Key_SetBinding;
ADDRGP4 uiInfo+144
ADDRGP4 trap_Key_SetBinding
ASGNP4
line 4945
;4945:	uiInfo.uiDC.getBindingBuf = &trap_Key_GetBindingBuf;
ADDRGP4 uiInfo+140
ADDRGP4 trap_Key_GetBindingBuf
ASGNP4
line 4946
;4946:	uiInfo.uiDC.keynumToStringBuf = &trap_Key_KeynumToStringBuf;
ADDRGP4 uiInfo+136
ADDRGP4 trap_Key_KeynumToStringBuf
ASGNP4
line 4947
;4947:	uiInfo.uiDC.executeText = &trap_Cmd_ExecuteText;
ADDRGP4 uiInfo+148
ADDRGP4 trap_Cmd_ExecuteText
ASGNP4
line 4948
;4948:	uiInfo.uiDC.Error = &Com_Error;
ADDRGP4 uiInfo+152
ADDRGP4 Com_Error
ASGNP4
line 4949
;4949:	uiInfo.uiDC.Print = &Com_Printf;
ADDRGP4 uiInfo+156
ADDRGP4 Com_Printf
ASGNP4
line 4950
;4950:	uiInfo.uiDC.Pause = &UI_Pause;
ADDRGP4 uiInfo+160
ADDRGP4 UI_Pause
ASGNP4
line 4951
;4951:	uiInfo.uiDC.ownerDrawWidth = &UI_OwnerDrawWidth;
ADDRGP4 uiInfo+164
ADDRGP4 UI_OwnerDrawWidth
ASGNP4
line 4952
;4952:	uiInfo.uiDC.registerSound = &trap_S_RegisterSound;
ADDRGP4 uiInfo+168
ADDRGP4 trap_S_RegisterSound
ASGNP4
line 4953
;4953:	uiInfo.uiDC.startBackgroundTrack = &trap_S_StartBackgroundTrack;
ADDRGP4 uiInfo+172
ADDRGP4 trap_S_StartBackgroundTrack
ASGNP4
line 4954
;4954:	uiInfo.uiDC.stopBackgroundTrack = &trap_S_StopBackgroundTrack;
ADDRGP4 uiInfo+176
ADDRGP4 trap_S_StopBackgroundTrack
ASGNP4
line 4955
;4955:	uiInfo.uiDC.playCinematic = &UI_PlayCinematic;
ADDRGP4 uiInfo+180
ADDRGP4 UI_PlayCinematic
ASGNP4
line 4956
;4956:	uiInfo.uiDC.stopCinematic = &UI_StopCinematic;
ADDRGP4 uiInfo+184
ADDRGP4 UI_StopCinematic
ASGNP4
line 4957
;4957:	uiInfo.uiDC.drawCinematic = &UI_DrawCinematic;
ADDRGP4 uiInfo+188
ADDRGP4 UI_DrawCinematic
ASGNP4
line 4958
;4958:	uiInfo.uiDC.runCinematicFrame = &UI_RunCinematicFrame;
ADDRGP4 uiInfo+192
ADDRGP4 UI_RunCinematicFrame
ASGNP4
line 4960
;4959:
;4960:	Init_Display(&uiInfo.uiDC);
ADDRGP4 uiInfo
ARGP4
ADDRGP4 Init_Display
CALLV
pop
line 4962
;4961:
;4962:	String_Init();
ADDRGP4 String_Init
CALLV
pop
line 4964
;4963:
;4964:	uiInfo.uiDC.cursor = trap_R_RegisterShaderNoMip("menu/art/3_cursor2");
ADDRGP4 $4203
ARGP4
ADDRLP4 8
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+73408
ADDRLP4 8
INDIRI4
ASGNI4
line 4965
;4965:	uiInfo.uiDC.whiteShader = trap_R_RegisterShaderNoMip("white");
ADDRGP4 $4205
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+73400
ADDRLP4 12
INDIRI4
ASGNI4
line 4967
;4966:
;4967:	AssetCache();
ADDRGP4 AssetCache
CALLV
pop
line 4969
;4968:
;4969:	start = trap_Milliseconds();
ADDRLP4 16
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 4971
;4970:
;4971:	uiInfo.teamCount = 0;
ADDRGP4 uiInfo+75756
CNSTI4 0
ASGNI4
line 4972
;4972:	uiInfo.characterCount = 0;
ADDRGP4 uiInfo+73440
CNSTI4 0
ASGNI4
line 4973
;4973:	uiInfo.aliasCount = 0;
ADDRGP4 uiInfo+74984
CNSTI4 0
ASGNI4
line 4979
;4974:
;4975:#ifdef PRE_RELEASE_TADEMO
;4976:	UI_ParseTeamInfo("demoteaminfo.txt");
;4977:	UI_ParseGameInfo("demogameinfo.txt");
;4978:#else
;4979:	UI_ParseTeamInfo("teaminfo.txt");
ADDRGP4 $4209
ARGP4
ADDRGP4 UI_ParseTeamInfo
CALLV
pop
line 4980
;4980:	UI_LoadTeams();
ADDRGP4 UI_LoadTeams
CALLV
pop
line 4981
;4981:	UI_ParseGameInfo("gameinfo.txt");
ADDRGP4 $665
ARGP4
ADDRGP4 UI_ParseGameInfo
CALLV
pop
line 4984
;4982:#endif
;4983:
;4984:	menuSet = UI_Cvar_VariableString("ui_menuFiles");
ADDRGP4 $659
ARGP4
ADDRLP4 20
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 4985
;4985:	if (menuSet == NULL || menuSet[0] == '\0') {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4212
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $4210
LABELV $4212
line 4986
;4986:		menuSet = "ui/menus.txt";
ADDRLP4 0
ADDRGP4 $631
ASGNP4
line 4987
;4987:	}
LABELV $4210
line 4995
;4988:
;4989:#if 0
;4990:	if (uiInfo.inGameLoad) {
;4991:		UI_LoadMenus("ui/ingame.txt", qtrue);
;4992:	} else { // bk010222: left this: UI_LoadMenus(menuSet, qtrue);
;4993:	}
;4994:#else 
;4995:	UI_LoadMenus(menuSet, qtrue);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 UI_LoadMenus
CALLV
pop
line 4996
;4996:	UI_LoadMenus("ui/ingame.txt", qfalse);
ADDRGP4 $4213
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 UI_LoadMenus
CALLV
pop
line 4999
;4997:#endif
;4998:
;4999:	Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 5001
;5000:
;5001:	trap_LAN_LoadCachedServers();
ADDRGP4 trap_LAN_LoadCachedServers
CALLV
pop
line 5002
;5002:	UI_LoadBestScores(uiInfo.mapList[ui_currentMap.integer].mapLoadName, uiInfo.gameTypes[ui_gameType.integer].gtEnum);
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+78580+4
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_LoadBestScores
CALLV
pop
line 5004
;5003:
;5004:	UI_BuildQ3Model_List();
ADDRGP4 UI_BuildQ3Model_List
CALLV
pop
line 5005
;5005:	UI_LoadBots();
ADDRGP4 UI_LoadBots
CALLV
pop
line 5008
;5006:
;5007:	// sets defaults for ui temp cvars
;5008:	uiInfo.effectsColor = gamecodetoui[(int)trap_Cvar_VariableValue("color1") - 1];
ADDRGP4 $1747
ARGP4
ADDRLP4 28
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRGP4 uiInfo+136904
ADDRLP4 28
INDIRF4
CVFI4 4
CNSTI4 2
LSHI4
ADDRGP4 gamecodetoui-4
ADDP4
INDIRI4
ASGNI4
line 5009
;5009:	uiInfo.currentCrosshair = (int)trap_Cvar_VariableValue("cg_drawCrosshair");
ADDRGP4 $2040
ARGP4
ADDRLP4 32
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRGP4 uiInfo+119476
ADDRLP4 32
INDIRF4
CVFI4 4
ASGNI4
line 5010
;5010:	trap_Cvar_Set("ui_mousePitch", (trap_Cvar_VariableValue("m_pitch") >= 0) ? "0" : "1");
ADDRGP4 $2333
ARGP4
ADDRLP4 40
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 40
INDIRF4
CNSTF4 0
LTF4 $4224
ADDRLP4 36
ADDRGP4 $384
ASGNP4
ADDRGP4 $4225
JUMPV
LABELV $4224
ADDRLP4 36
ADDRGP4 $386
ASGNP4
LABELV $4225
ADDRGP4 $2330
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5012
;5011:
;5012:	uiInfo.serverStatus.currentServerCinematic = -1;
ADDRGP4 uiInfo+99264+10432
CNSTI4 -1
ASGNI4
line 5013
;5013:	uiInfo.previewMovie = -1;
ADDRGP4 uiInfo+99260
CNSTI4 -1
ASGNI4
line 5015
;5014:
;5015:	if (trap_Cvar_VariableValue("ui_TeamArenaFirstRun") == 0) {
ADDRGP4 $4231
ARGP4
ADDRLP4 44
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 44
INDIRF4
CNSTF4 0
NEF4 $4229
line 5016
;5016:		trap_Cvar_Set("s_volume", "0.8");
ADDRGP4 $4232
ARGP4
ADDRGP4 $4233
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5017
;5017:		trap_Cvar_Set("s_musicvolume", "0.5");
ADDRGP4 $4234
ARGP4
ADDRGP4 $4235
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5018
;5018:		trap_Cvar_Set("ui_TeamArenaFirstRun", "1");
ADDRGP4 $4231
ARGP4
ADDRGP4 $386
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5019
;5019:	}
LABELV $4229
line 5021
;5020:
;5021:	trap_Cvar_Register(NULL, "debug_protocol", "", 0);
CNSTP4 0
ARGP4
ADDRGP4 $4236
ARGP4
ADDRGP4 $110
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5023
;5022:
;5023:	trap_Cvar_Set("ui_actualNetGameType", va("%d", ui_netGameType.integer));
ADDRGP4 $704
ARGP4
ADDRGP4 ui_netGameType+12
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $719
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5024
;5024:}
LABELV $4133
endproc _UI_Init 52 16
export _UI_KeyEvent
proc _UI_KeyEvent 16 12
line 5032
;5025:
;5026:
;5027:/*
;5028:=================
;5029:UI_KeyEvent
;5030:=================
;5031:*/
;5032:void _UI_KeyEvent(int key, qboolean down) {
line 5034
;5033:
;5034:	if (Menu_Count() > 0) {
ADDRLP4 0
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $4239
line 5035
;5035:		menuDef_t *menu = Menu_GetFocused();
ADDRLP4 8
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 5036
;5036:		if (menu) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4241
line 5037
;5037:			if (key == K_ESCAPE && down && !Menus_AnyFullScreenVisible()) {
ADDRFP4 0
INDIRI4
CNSTI4 27
NEI4 $4243
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $4243
ADDRLP4 12
ADDRGP4 Menus_AnyFullScreenVisible
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $4243
line 5038
;5038:				Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 5039
;5039:			} else {
ADDRGP4 $4242
JUMPV
LABELV $4243
line 5040
;5040:				Menu_HandleKey(menu, key, down);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 Menu_HandleKey
CALLV
pop
line 5041
;5041:			}
line 5042
;5042:		} else {
ADDRGP4 $4242
JUMPV
LABELV $4241
line 5043
;5043:			trap_Key_SetCatcher(trap_Key_GetCatcher() & ~KEYCATCH_UI);
ADDRLP4 12
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 5044
;5044:			trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 5045
;5045:			trap_Cvar_Set("cl_paused", "0");
ADDRGP4 $2578
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5046
;5046:		}
LABELV $4242
line 5047
;5047:	}
LABELV $4239
line 5052
;5048:
;5049:	//if ((s > 0) && (s != menu_null_sound)) {
;5050:	  //  trap_S_StartLocalSound( s, CHAN_LOCAL_SOUND );
;5051:	//}
;5052:}
LABELV $4238
endproc _UI_KeyEvent 16 12
export _UI_MouseEvent
proc _UI_MouseEvent 12 12
line 5059
;5053:
;5054:/*
;5055:=================
;5056:UI_MouseEvent
;5057:=================
;5058:*/
;5059:void _UI_MouseEvent(int dx, int dy) {
line 5061
;5060:	// update mouse screen position
;5061:	uiInfo.uiDC.cursorx += dx;
ADDRLP4 0
ADDRGP4 uiInfo+216
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 0
INDIRI4
ADDI4
ASGNI4
line 5062
;5062:	if (uiInfo.uiDC.cursorx < 0)
ADDRGP4 uiInfo+216
INDIRI4
CNSTI4 0
GEI4 $4247
line 5063
;5063:		uiInfo.uiDC.cursorx = 0;
ADDRGP4 uiInfo+216
CNSTI4 0
ASGNI4
ADDRGP4 $4248
JUMPV
LABELV $4247
line 5064
;5064:	else if (uiInfo.uiDC.cursorx > SCREEN_WIDTH)
ADDRGP4 uiInfo+216
INDIRI4
CNSTI4 640
LEI4 $4251
line 5065
;5065:		uiInfo.uiDC.cursorx = SCREEN_WIDTH;
ADDRGP4 uiInfo+216
CNSTI4 640
ASGNI4
LABELV $4251
LABELV $4248
line 5067
;5066:
;5067:	uiInfo.uiDC.cursory += dy;
ADDRLP4 4
ADDRGP4 uiInfo+220
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 5068
;5068:	if (uiInfo.uiDC.cursory < 0)
ADDRGP4 uiInfo+220
INDIRI4
CNSTI4 0
GEI4 $4256
line 5069
;5069:		uiInfo.uiDC.cursory = 0;
ADDRGP4 uiInfo+220
CNSTI4 0
ASGNI4
ADDRGP4 $4257
JUMPV
LABELV $4256
line 5070
;5070:	else if (uiInfo.uiDC.cursory > SCREEN_HEIGHT)
ADDRGP4 uiInfo+220
INDIRI4
CNSTI4 480
LEI4 $4260
line 5071
;5071:		uiInfo.uiDC.cursory = SCREEN_HEIGHT;
ADDRGP4 uiInfo+220
CNSTI4 480
ASGNI4
LABELV $4260
LABELV $4257
line 5073
;5072:
;5073:	if (Menu_Count() > 0) {
ADDRLP4 8
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LEI4 $4264
line 5076
;5074:		//menuDef_t *menu = Menu_GetFocused();
;5075:		//Menu_HandleMouseMove(menu, uiInfo.uiDC.cursorx, uiInfo.uiDC.cursory);
;5076:		Display_MouseMove(NULL, uiInfo.uiDC.cursorx, uiInfo.uiDC.cursory);
CNSTP4 0
ARGP4
ADDRGP4 uiInfo+216
INDIRI4
ARGI4
ADDRGP4 uiInfo+220
INDIRI4
ARGI4
ADDRGP4 Display_MouseMove
CALLI4
pop
line 5077
;5077:	}
LABELV $4264
line 5079
;5078:
;5079:}
LABELV $4245
endproc _UI_MouseEvent 12 12
export UI_LoadNonIngame
proc UI_LoadNonIngame 12 8
line 5081
;5080:
;5081:void UI_LoadNonIngame() {
line 5082
;5082:	const char *menuSet = UI_Cvar_VariableString("ui_menuFiles");
ADDRGP4 $659
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 5083
;5083:	if (menuSet == NULL || menuSet[0] == '\0') {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4271
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $4269
LABELV $4271
line 5084
;5084:		menuSet = "ui/menus.txt";
ADDRLP4 0
ADDRGP4 $631
ASGNP4
line 5085
;5085:	}
LABELV $4269
line 5086
;5086:	UI_LoadMenus(menuSet, qfalse);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 UI_LoadMenus
CALLV
pop
line 5087
;5087:	uiInfo.inGameLoad = qfalse;
ADDRGP4 uiInfo+136908
CNSTI4 0
ASGNI4
line 5088
;5088:}
LABELV $4268
endproc UI_LoadNonIngame 12 8
export _UI_SetActiveMenu
proc _UI_SetActiveMenu 292 12
line 5090
;5089:
;5090:void _UI_SetActiveMenu(uiMenuCommand_t menu) {
line 5095
;5091:	char buf[256];
;5092:
;5093:	// this should be the ONLY way the menu system is brought up
;5094:	// enusure minumum menu data is cached
;5095:	if (Menu_Count() > 0) {
ADDRLP4 256
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 256
INDIRI4
CNSTI4 0
LEI4 $4274
line 5097
;5096:		vec3_t v;
;5097:		v[0] = v[1] = v[2] = 0;
ADDRLP4 272
CNSTF4 0
ASGNF4
ADDRLP4 260+8
ADDRLP4 272
INDIRF4
ASGNF4
ADDRLP4 260+4
ADDRLP4 272
INDIRF4
ASGNF4
ADDRLP4 260
ADDRLP4 272
INDIRF4
ASGNF4
line 5098
;5098:		switch (menu) {
ADDRLP4 276
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 276
INDIRI4
CNSTI4 0
LTI4 $4278
ADDRLP4 276
INDIRI4
CNSTI4 6
GTI4 $4278
ADDRLP4 276
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $4302
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $4302
address $4281
address $4282
address $4300
address $4273
address $4273
address $4292
address $4295
code
LABELV $4281
line 5100
;5099:		case UIMENU_NONE:
;5100:			trap_Key_SetCatcher(trap_Key_GetCatcher() & ~KEYCATCH_UI);
ADDRLP4 284
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 5101
;5101:			trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 5102
;5102:			trap_Cvar_Set("cl_paused", "0");
ADDRGP4 $2578
ARGP4
ADDRGP4 $384
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5103
;5103:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 5105
;5104:
;5105:			return;
ADDRGP4 $4273
JUMPV
LABELV $4282
line 5108
;5106:		case UIMENU_MAIN:
;5107:			//trap_Cvar_Set( "sv_killserver", "1" );
;5108:			trap_Key_SetCatcher(KEYCATCH_UI);
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 5111
;5109:			//trap_S_StartLocalSound( trap_S_RegisterSound("sound/misc/menu_background.wav", qfalse) , CHAN_LOCAL_SOUND );
;5110:			//trap_S_StartBackgroundTrack("sound/misc/menu_background.wav", NULL);
;5111:			if (uiInfo.inGameLoad) {
ADDRGP4 uiInfo+136908
INDIRI4
CNSTI4 0
EQI4 $4283
line 5112
;5112:				UI_LoadNonIngame();
ADDRGP4 UI_LoadNonIngame
CALLV
pop
line 5113
;5113:			}
LABELV $4283
line 5114
;5114:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 5115
;5115:			Menus_ActivateByName("main");
ADDRGP4 $2508
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 5116
;5116:			trap_Cvar_VariableStringBuffer("com_errorMessage", buf, sizeof(buf));
ADDRGP4 $2429
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 5117
;5117:			if (strlen(buf)) {
ADDRLP4 0
ARGP4
ADDRLP4 288
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
EQI4 $4273
line 5118
;5118:				if (!ui_singlePlayerActive.integer) {
ADDRGP4 ui_singlePlayerActive+12
INDIRI4
CNSTI4 0
NEI4 $4288
line 5119
;5119:					Menus_ActivateByName("error_popmenu");
ADDRGP4 $4291
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 5120
;5120:				} else {
ADDRGP4 $4273
JUMPV
LABELV $4288
line 5121
;5121:					trap_Cvar_Set("com_errorMessage", "");
ADDRGP4 $2429
ARGP4
ADDRGP4 $110
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5122
;5122:				}
line 5123
;5123:			}
line 5124
;5124:			return;
ADDRGP4 $4273
JUMPV
LABELV $4292
line 5126
;5125:		case UIMENU_TEAM:
;5126:			trap_Key_SetCatcher(KEYCATCH_UI);
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 5127
;5127:			Menus_ActivateByName("team");
ADDRGP4 $2125
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 5128
;5128:			return;
ADDRGP4 $4273
JUMPV
line 5134
;5129:		case UIMENU_NEED_CD:
;5130:			// no cd check in TA
;5131:			//trap_Key_SetCatcher( KEYCATCH_UI );
;5132:	  //Menus_ActivateByName("needcd");
;5133:		  //UI_ConfirmMenu( "Insert the CD", NULL, NeedCDAction );
;5134:			return;
line 5140
;5135:		case UIMENU_BAD_CD_KEY:
;5136:			// no cd check in TA
;5137:			//trap_Key_SetCatcher( KEYCATCH_UI );
;5138:	  //Menus_ActivateByName("badcd");
;5139:		  //UI_ConfirmMenu( "Bad CD Key", NULL, NeedCDKeyAction );
;5140:			return;
LABELV $4295
line 5143
;5141:		case UIMENU_POSTGAME:
;5142:			//trap_Cvar_Set( "sv_killserver", "1" );
;5143:			trap_Key_SetCatcher(KEYCATCH_UI);
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 5144
;5144:			if (uiInfo.inGameLoad) {
ADDRGP4 uiInfo+136908
INDIRI4
CNSTI4 0
EQI4 $4296
line 5145
;5145:				UI_LoadNonIngame();
ADDRGP4 UI_LoadNonIngame
CALLV
pop
line 5146
;5146:			}
LABELV $4296
line 5147
;5147:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 5148
;5148:			Menus_ActivateByName("endofgame");
ADDRGP4 $4299
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 5150
;5149:			//UI_ConfirmMenu( "Bad CD Key", NULL, NeedCDKeyAction );
;5150:			return;
ADDRGP4 $4273
JUMPV
LABELV $4300
line 5152
;5151:		case UIMENU_INGAME:
;5152:			trap_Cvar_Set("cl_paused", "1");
ADDRGP4 $2578
ARGP4
ADDRGP4 $386
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5153
;5153:			trap_Key_SetCatcher(KEYCATCH_UI);
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 5154
;5154:			UI_BuildPlayerList();
ADDRGP4 UI_BuildPlayerList
CALLV
pop
line 5155
;5155:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 5156
;5156:			Menus_ActivateByName("ingame");
ADDRGP4 $4301
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 5157
;5157:			return;
LABELV $4278
line 5159
;5158:		}
;5159:	}
LABELV $4274
line 5160
;5160:}
LABELV $4273
endproc _UI_SetActiveMenu 292 12
export _UI_IsFullscreen
proc _UI_IsFullscreen 4 0
line 5162
;5161:
;5162:qboolean _UI_IsFullscreen(void) {
line 5163
;5163:	return Menus_AnyFullScreenVisible();
ADDRLP4 0
ADDRGP4 Menus_AnyFullScreenVisible
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $4303
endproc _UI_IsFullscreen 4 0
proc UI_ReadableSize 12 16
line 5171
;5164:}
;5165:
;5166:
;5167:
;5168:static connstate_t	lastConnState;
;5169:static char			lastLoadingText[MAX_INFO_VALUE];
;5170:
;5171:static void UI_ReadableSize(char *buf, int bufsize, int value) {
line 5172
;5172:	if (value > 1024 * 1024 * 1024) { // gigs
ADDRFP4 8
INDIRI4
CNSTI4 1073741824
LEI4 $4305
line 5173
;5173:		Com_sprintf(buf, bufsize, "%d", value / (1024 * 1024 * 1024));
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $704
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1073741824
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5174
;5174:		Com_sprintf(buf + strlen(buf), bufsize - strlen(buf), ".%02d GB",
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ARGI4
ADDRGP4 $4307
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1073741824
MODI4
CNSTI4 100
MULI4
CNSTI4 1073741824
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5176
;5175:			(value % (1024 * 1024 * 1024)) * 100 / (1024 * 1024 * 1024));
;5176:	} else if (value > 1024 * 1024) { // megs
ADDRGP4 $4306
JUMPV
LABELV $4305
ADDRFP4 8
INDIRI4
CNSTI4 1048576
LEI4 $4308
line 5177
;5177:		Com_sprintf(buf, bufsize, "%d", value / (1024 * 1024));
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $704
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1048576
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5178
;5178:		Com_sprintf(buf + strlen(buf), bufsize - strlen(buf), ".%02d MB",
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ARGI4
ADDRGP4 $4310
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1048576
MODI4
CNSTI4 100
MULI4
CNSTI4 1048576
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5180
;5179:			(value % (1024 * 1024)) * 100 / (1024 * 1024));
;5180:	} else if (value > 1024) { // kilos
ADDRGP4 $4309
JUMPV
LABELV $4308
ADDRFP4 8
INDIRI4
CNSTI4 1024
LEI4 $4311
line 5181
;5181:		Com_sprintf(buf, bufsize, "%d KB", value / 1024);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $4313
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1024
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5182
;5182:	} else { // bytes
ADDRGP4 $4312
JUMPV
LABELV $4311
line 5183
;5183:		Com_sprintf(buf, bufsize, "%d bytes", value);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $4314
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5184
;5184:	}
LABELV $4312
LABELV $4309
LABELV $4306
line 5185
;5185:}
LABELV $4304
endproc UI_ReadableSize 12 16
proc UI_PrintTime 4 20
line 5188
;5186:
;5187:// Assumes time is in msec
;5188:static void UI_PrintTime(char *buf, int bufsize, int time) {
line 5189
;5189:	time /= 1000;  // change to seconds
ADDRFP4 8
ADDRFP4 8
INDIRI4
CNSTI4 1000
DIVI4
ASGNI4
line 5191
;5190:
;5191:	if (time > 3600) { // in the hours range
ADDRFP4 8
INDIRI4
CNSTI4 3600
LEI4 $4316
line 5192
;5192:		Com_sprintf(buf, bufsize, "%d hr %d min", time / 3600, (time % 3600) / 60);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $4318
ARGP4
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3600
DIVI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 3600
MODI4
CNSTI4 60
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5193
;5193:	} else if (time > 60) { // mins
ADDRGP4 $4317
JUMPV
LABELV $4316
ADDRFP4 8
INDIRI4
CNSTI4 60
LEI4 $4319
line 5194
;5194:		Com_sprintf(buf, bufsize, "%d min %d sec", time / 60, time % 60);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $4321
ARGP4
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 60
DIVI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 60
MODI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5195
;5195:	} else { // secs
ADDRGP4 $4320
JUMPV
LABELV $4319
line 5196
;5196:		Com_sprintf(buf, bufsize, "%d sec", time);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $4322
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5197
;5197:	}
LABELV $4320
LABELV $4317
line 5198
;5198:}
LABELV $4315
endproc UI_PrintTime 4 20
export Text_PaintCenter
proc Text_PaintCenter 8 32
line 5200
;5199:
;5200:void Text_PaintCenter(float x, float y, float scale, vec4_t color, const char *text, float adjust) {
line 5201
;5201:	int len = Text_Width(text, scale, 0);
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 8
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 Text_Width
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 5202
;5202:	Text_Paint(x - len / 2, y, scale, color, text, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
ADDRFP4 0
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
DIVI4
CVIF4 4
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 5203
;5203:}
LABELV $4323
endproc Text_PaintCenter 8 32
export Text_PaintCenter_AutoWrapped
proc Text_PaintCenter_AutoWrapped 1056 24
line 5205
;5204:
;5205:void Text_PaintCenter_AutoWrapped(float x, float y, float xmax, float ystep, float scale, vec4_t color, const char *str, float adjust) {
line 5211
;5206:	int width;
;5207:	char *s1, *s2, *s3;
;5208:	char c_bcp;
;5209:	char buf[1024];
;5210:
;5211:	if (!str || str[0] == '\0')
ADDRLP4 1044
ADDRFP4 24
INDIRP4
ASGNP4
ADDRLP4 1044
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4327
ADDRLP4 1044
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $4325
LABELV $4327
line 5212
;5212:		return;
ADDRGP4 $4324
JUMPV
LABELV $4325
line 5214
;5213:
;5214:	Q_strncpyz(buf, str, sizeof(buf));
ADDRLP4 20
ARGP4
ADDRFP4 24
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 5215
;5215:	s1 = s2 = s3 = buf;
ADDRLP4 0
ADDRLP4 20
ASGNP4
ADDRLP4 4
ADDRLP4 20
ASGNP4
ADDRLP4 12
ADDRLP4 20
ASGNP4
ADDRGP4 $4329
JUMPV
LABELV $4328
line 5217
;5216:
;5217:	while (1) {
LABELV $4331
line 5218
;5218:		do {
line 5219
;5219:			s3++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 5220
;5220:		} while (*s3 != ' ' && *s3 != '\0');
LABELV $4332
ADDRLP4 1048
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 32
EQI4 $4334
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $4331
LABELV $4334
line 5221
;5221:		c_bcp = *s3;
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI1
ASGNI1
line 5222
;5222:		*s3 = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 5223
;5223:		width = Text_Width(s1, scale, 0);
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 1052
ADDRGP4 Text_Width
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 1052
INDIRI4
ASGNI4
line 5224
;5224:		*s3 = c_bcp;
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI1
ASGNI1
line 5225
;5225:		if (width > xmax) {
ADDRLP4 16
INDIRI4
CVIF4 4
ADDRFP4 8
INDIRF4
LEF4 $4335
line 5226
;5226:			if (s1 == s2) {
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
NEU4 $4337
line 5228
;5227:				// fuck, don't have a clean cut, we'll overflow
;5228:				s2 = s3;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 5229
;5229:			}
LABELV $4337
line 5230
;5230:			*s2 = '\0';
ADDRLP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 5231
;5231:			Text_PaintCenter(x, y, scale, color, s1, adjust);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 28
INDIRF4
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5232
;5232:			y += ystep;
ADDRFP4 4
ADDRFP4 4
INDIRF4
ADDRFP4 12
INDIRF4
ADDF4
ASGNF4
line 5233
;5233:			if (c_bcp == '\0') {
ADDRLP4 8
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $4339
line 5238
;5234:				// that was the last word
;5235:		// we could start a new loop, but that wouldn't be much use
;5236:		// even if the word is too long, we would overflow it (see above)
;5237:		// so just print it now if needed
;5238:				s2++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 5239
;5239:				if (*s2 != '\0') // if we are printing an overflowing line we have s2 == s3
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $4330
line 5240
;5240:					Text_PaintCenter(x, y, scale, color, s2, adjust);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 28
INDIRF4
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5241
;5241:				break;
ADDRGP4 $4330
JUMPV
LABELV $4339
line 5243
;5242:			}
;5243:			s2++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 5244
;5244:			s1 = s2;
ADDRLP4 12
ADDRLP4 4
INDIRP4
ASGNP4
line 5245
;5245:			s3 = s2;
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 5246
;5246:		} else {
ADDRGP4 $4336
JUMPV
LABELV $4335
line 5247
;5247:			s2 = s3;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 5248
;5248:			if (c_bcp == '\0') // we reached the end
ADDRLP4 8
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $4343
line 5249
;5249:			{
line 5250
;5250:				Text_PaintCenter(x, y, scale, color, s1, adjust);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 28
INDIRF4
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5251
;5251:				break;
ADDRGP4 $4330
JUMPV
LABELV $4343
line 5253
;5252:			}
;5253:		}
LABELV $4336
line 5254
;5254:	}
LABELV $4329
line 5217
ADDRGP4 $4328
JUMPV
LABELV $4330
line 5255
;5255:}
LABELV $4324
endproc Text_PaintCenter_AutoWrapped 1056 24
lit
align 1
LABELV $4346
byte 1 68
byte 1 111
byte 1 119
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 0
align 1
LABELV $4347
byte 1 69
byte 1 115
byte 1 116
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 58
byte 1 0
align 1
LABELV $4348
byte 1 84
byte 1 114
byte 1 97
byte 1 110
byte 1 115
byte 1 102
byte 1 101
byte 1 114
byte 1 32
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 58
byte 1 0
code
proc UI_DisplayDownloadInfo 304 24
line 5257
;5256:
;5257:static void UI_DisplayDownloadInfo(const char *downloadName, float centerPoint, float yStart, float scale) {
line 5268
;5258:	static char dlText[] = "Downloading:";
;5259:	static char etaText[] = "Estimated time left:";
;5260:	static char xferText[] = "Transfer rate:";
;5261:
;5262:	int downloadSize, downloadCount, downloadTime;
;5263:	char dlSizeBuf[64], totalSizeBuf[64], xferRateBuf[64], dlTimeBuf[64];
;5264:	int xferRate;
;5265:	int leftWidth;
;5266:	const char *s;
;5267:
;5268:	downloadSize = trap_Cvar_VariableValue("cl_downloadSize");
ADDRGP4 $4349
ARGP4
ADDRLP4 280
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 280
INDIRF4
CVFI4 4
ASGNI4
line 5269
;5269:	downloadCount = trap_Cvar_VariableValue("cl_downloadCount");
ADDRGP4 $4350
ARGP4
ADDRLP4 284
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 284
INDIRF4
CVFI4 4
ASGNI4
line 5270
;5270:	downloadTime = trap_Cvar_VariableValue("cl_downloadTime");
ADDRGP4 $4351
ARGP4
ADDRLP4 288
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 140
ADDRLP4 288
INDIRF4
CVFI4 4
ASGNI4
line 5272
;5271:
;5272:	leftWidth = 320;
ADDRLP4 8
CNSTI4 320
ASGNI4
line 5274
;5273:
;5274:	UI_SetColor(colorWhite);
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_SetColor
CALLV
pop
line 5275
;5275:	Text_PaintCenter(centerPoint, yStart + 112, scale, colorWhite, dlText, 0);
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1121976320
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 $4346
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5276
;5276:	Text_PaintCenter(centerPoint, yStart + 192, scale, colorWhite, etaText, 0);
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1128267776
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 $4347
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5277
;5277:	Text_PaintCenter(centerPoint, yStart + 248, scale, colorWhite, xferText, 0);
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1131937792
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 $4348
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5279
;5278:
;5279:	if (downloadSize > 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $4352
line 5280
;5280:		s = va("%s (%d%%)", downloadName, downloadCount * 100 / downloadSize);
ADDRGP4 $4354
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 100
MULI4
ADDRLP4 0
INDIRI4
DIVI4
ARGI4
ADDRLP4 292
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 148
ADDRLP4 292
INDIRP4
ASGNP4
line 5281
;5281:	} else {
ADDRGP4 $4353
JUMPV
LABELV $4352
line 5282
;5282:		s = downloadName;
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
line 5283
;5283:	}
LABELV $4353
line 5285
;5284:
;5285:	Text_PaintCenter(centerPoint, yStart + 136, scale, colorWhite, s, 0);
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1124597760
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 148
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5287
;5286:
;5287:	UI_ReadableSize(dlSizeBuf, sizeof dlSizeBuf, downloadCount);
ADDRLP4 12
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 UI_ReadableSize
CALLV
pop
line 5288
;5288:	UI_ReadableSize(totalSizeBuf, sizeof totalSizeBuf, downloadSize);
ADDRLP4 76
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 UI_ReadableSize
CALLV
pop
line 5290
;5289:
;5290:	if (downloadCount < 4096 || !downloadTime) {
ADDRLP4 4
INDIRI4
CNSTI4 4096
LTI4 $4357
ADDRLP4 140
INDIRI4
CNSTI4 0
NEI4 $4355
LABELV $4357
line 5291
;5291:		Text_PaintCenter(leftWidth, yStart + 216, scale, colorWhite, "estimating", 0);
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1129840640
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 $4358
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5292
;5292:		Text_PaintCenter(leftWidth, yStart + 160, scale, colorWhite, va("(%s of %s copied)", dlSizeBuf, totalSizeBuf), 0);
ADDRGP4 $4359
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 292
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1126170624
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 292
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5293
;5293:	} else {
ADDRGP4 $4356
JUMPV
LABELV $4355
line 5294
;5294:		if ((uiInfo.uiDC.realTime - downloadTime) / 1000) {
ADDRGP4 uiInfo+208
INDIRI4
ADDRLP4 140
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
CNSTI4 0
EQI4 $4360
line 5295
;5295:			xferRate = downloadCount / ((uiInfo.uiDC.realTime - downloadTime) / 1000);
ADDRLP4 144
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+208
INDIRI4
ADDRLP4 140
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
DIVI4
ASGNI4
line 5296
;5296:		} else {
ADDRGP4 $4361
JUMPV
LABELV $4360
line 5297
;5297:			xferRate = 0;
ADDRLP4 144
CNSTI4 0
ASGNI4
line 5298
;5298:		}
LABELV $4361
line 5299
;5299:		UI_ReadableSize(xferRateBuf, sizeof xferRateBuf, xferRate);
ADDRLP4 152
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 144
INDIRI4
ARGI4
ADDRGP4 UI_ReadableSize
CALLV
pop
line 5302
;5300:
;5301:		// Extrapolate estimated completion time
;5302:		if (downloadSize && xferRate) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $4364
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $4364
line 5303
;5303:			int n = downloadSize / xferRate; // estimated time for entire d/l in secs
ADDRLP4 292
ADDRLP4 0
INDIRI4
ADDRLP4 144
INDIRI4
DIVI4
ASGNI4
line 5306
;5304:
;5305:			// We do it in K (/1024) because we'd overflow around 4MB
;5306:			UI_PrintTime(dlTimeBuf, sizeof dlTimeBuf,
ADDRLP4 216
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 296
ADDRLP4 292
INDIRI4
ASGNI4
ADDRLP4 296
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 1024
DIVI4
ADDRLP4 296
INDIRI4
MULI4
ADDRLP4 0
INDIRI4
CNSTI4 1024
DIVI4
DIVI4
SUBI4
CNSTI4 1000
MULI4
ARGI4
ADDRGP4 UI_PrintTime
CALLV
pop
line 5309
;5307:				(n - (((downloadCount / 1024) * n) / (downloadSize / 1024))) * 1000);
;5308:
;5309:			Text_PaintCenter(leftWidth, yStart + 216, scale, colorWhite, dlTimeBuf, 0);
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1129840640
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 216
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5310
;5310:			Text_PaintCenter(leftWidth, yStart + 160, scale, colorWhite, va("(%s of %s copied)", dlSizeBuf, totalSizeBuf), 0);
ADDRGP4 $4359
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 300
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1126170624
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 300
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5311
;5311:		} else {
ADDRGP4 $4365
JUMPV
LABELV $4364
line 5312
;5312:			Text_PaintCenter(leftWidth, yStart + 216, scale, colorWhite, "estimating", 0);
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1129840640
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 $4358
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5313
;5313:			if (downloadSize) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $4366
line 5314
;5314:				Text_PaintCenter(leftWidth, yStart + 160, scale, colorWhite, va("(%s of %s copied)", dlSizeBuf, totalSizeBuf), 0);
ADDRGP4 $4359
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 292
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1126170624
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 292
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5315
;5315:			} else {
ADDRGP4 $4367
JUMPV
LABELV $4366
line 5316
;5316:				Text_PaintCenter(leftWidth, yStart + 160, scale, colorWhite, va("(%s copied)", dlSizeBuf), 0);
ADDRGP4 $4368
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 292
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1126170624
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 292
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5317
;5317:			}
LABELV $4367
line 5318
;5318:		}
LABELV $4365
line 5320
;5319:
;5320:		if (xferRate) {
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $4369
line 5321
;5321:			Text_PaintCenter(leftWidth, yStart + 272, scale, colorWhite, va("%s/Sec", xferRateBuf), 0);
ADDRGP4 $4371
ARGP4
ADDRLP4 152
ARGP4
ADDRLP4 292
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1132986368
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 292
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5322
;5322:		}
LABELV $4369
line 5323
;5323:	}
LABELV $4356
line 5324
;5324:}
LABELV $4345
endproc UI_DisplayDownloadInfo 304 24
export UI_DrawConnectScreen
proc UI_DrawConnectScreen 5440 32
line 5334
;5325:
;5326:/*
;5327:========================
;5328:UI_DrawConnectScreen
;5329:
;5330:This will also be overlaid on the cgame info screen during loading
;5331:to prevent it from blinking away too rapidly on local or lan games.
;5332:========================
;5333:*/
;5334:void UI_DrawConnectScreen(qboolean overlay) {
line 5341
;5335:	char *s;
;5336:	uiClientState_t	cstate;
;5337:	char			info[MAX_INFO_VALUE];
;5338:	char text[256];
;5339:	float centerPoint, yStart, scale;
;5340:
;5341:	menuDef_t *menu = Menus_FindByName("Connect");
ADDRGP4 $4373
ARGP4
ADDRLP4 4384
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRLP4 4120
ADDRLP4 4384
INDIRP4
ASGNP4
line 5344
;5342:
;5343:
;5344:	if (!overlay && menu) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $4374
ADDRLP4 4120
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4374
line 5345
;5345:		Menu_Paint(menu, qtrue);
ADDRLP4 4120
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_Paint
CALLV
pop
line 5346
;5346:	}
LABELV $4374
line 5348
;5347:
;5348:	if (!overlay) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $4376
line 5349
;5349:		centerPoint = 320;
ADDRLP4 3084
CNSTF4 1134559232
ASGNF4
line 5350
;5350:		yStart = 130;
ADDRLP4 3092
CNSTF4 1124204544
ASGNF4
line 5351
;5351:		scale = 0.5f;
ADDRLP4 3088
CNSTF4 1056964608
ASGNF4
line 5352
;5352:	} else {
ADDRGP4 $4377
JUMPV
LABELV $4376
line 5353
;5353:		centerPoint = 320;
ADDRLP4 3084
CNSTF4 1134559232
ASGNF4
line 5354
;5354:		yStart = 32;
ADDRLP4 3092
CNSTF4 1107296256
ASGNF4
line 5355
;5355:		scale = 0.6f;
ADDRLP4 3088
CNSTF4 1058642330
ASGNF4
line 5356
;5356:		return;
ADDRGP4 $4372
JUMPV
LABELV $4377
line 5360
;5357:	}
;5358:
;5359:	// see what information we should display
;5360:	trap_GetClientState(&cstate);
ADDRLP4 0
ARGP4
ADDRGP4 trap_GetClientState
CALLV
pop
line 5362
;5361:
;5362:	info[0] = '\0';
ADDRLP4 3096
CNSTI1 0
ASGNI1
line 5363
;5363:	if (trap_GetConfigString(CS_SERVERINFO, info, sizeof(info))) {
CNSTI4 0
ARGI4
ADDRLP4 3096
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4388
ADDRGP4 trap_GetConfigString
CALLI4
ASGNI4
ADDRLP4 4388
INDIRI4
CNSTI4 0
EQI4 $4378
line 5364
;5364:		Text_PaintCenter(centerPoint, yStart, scale, colorWhite, va("Loading %s", Info_ValueForKey(info, "mapname")), 0);
ADDRLP4 3096
ARGP4
ADDRGP4 $3058
ARGP4
ADDRLP4 4392
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $4380
ARGP4
ADDRLP4 4392
INDIRP4
ARGP4
ADDRLP4 4396
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 3084
INDIRF4
ARGF4
ADDRLP4 3092
INDIRF4
ARGF4
ADDRLP4 3088
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 4396
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5365
;5365:	}
LABELV $4378
line 5367
;5366:
;5367:	if (!Q_stricmp(cstate.servername, "localhost")) {
ADDRLP4 0+12
ARGP4
ADDRGP4 $4384
ARGP4
ADDRLP4 4392
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4392
INDIRI4
CNSTI4 0
NEI4 $4381
line 5368
;5368:		Text_PaintCenter(centerPoint, yStart + 48, scale, colorWhite, va("Starting up..."), ITEM_TEXTSTYLE_SHADOWEDMORE);
ADDRGP4 $4385
ARGP4
ADDRLP4 4396
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 3084
INDIRF4
ARGF4
ADDRLP4 3092
INDIRF4
CNSTF4 1111490560
ADDF4
ARGF4
ADDRLP4 3088
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 4396
INDIRP4
ARGP4
CNSTF4 1086324736
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5369
;5369:	} else {
ADDRGP4 $4382
JUMPV
LABELV $4381
line 5370
;5370:		strcpy(text, va("Connecting to %s", cstate.servername));
ADDRGP4 $4386
ARGP4
ADDRLP4 0+12
ARGP4
ADDRLP4 4396
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4124
ARGP4
ADDRLP4 4396
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 5371
;5371:		Text_PaintCenter(centerPoint, yStart + 48, scale, colorWhite, text, ITEM_TEXTSTYLE_SHADOWEDMORE);
ADDRLP4 3084
INDIRF4
ARGF4
ADDRLP4 3092
INDIRF4
CNSTF4 1111490560
ADDF4
ARGF4
ADDRLP4 3088
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 4124
ARGP4
CNSTF4 1086324736
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5372
;5372:	}
LABELV $4382
line 5375
;5373:
;5374:	// display global MOTD at bottom
;5375:	Text_PaintCenter(centerPoint, 600, scale, colorWhite, Info_ValueForKey(cstate.updateInfoString, "motd"), 0);
ADDRLP4 0+1036
ARGP4
ADDRGP4 $4389
ARGP4
ADDRLP4 4396
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 3084
INDIRF4
ARGF4
CNSTF4 1142292480
ARGF4
ADDRLP4 3088
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 4396
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5377
;5376:	// print any server info (server full, bad version, etc)
;5377:	if (cstate.connState < CA_CONNECTED) {
ADDRLP4 0
INDIRI4
CNSTI4 5
GEI4 $4390
line 5378
;5378:		Text_PaintCenter_AutoWrapped(centerPoint, yStart + 176, 630, 20, scale, colorWhite, cstate.messageString, 0);
ADDRLP4 3084
INDIRF4
ARGF4
ADDRLP4 3092
INDIRF4
CNSTF4 1127219200
ADDF4
ARGF4
CNSTF4 1142784000
ARGF4
CNSTF4 1101004800
ARGF4
ADDRLP4 3088
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 0+2060
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter_AutoWrapped
CALLV
pop
line 5379
;5379:	}
LABELV $4390
line 5381
;5380:
;5381:	if (lastConnState > cstate.connState) {
ADDRGP4 lastConnState
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $4393
line 5382
;5382:		lastLoadingText[0] = '\0';
ADDRGP4 lastLoadingText
CNSTI1 0
ASGNI1
line 5383
;5383:	}
LABELV $4393
line 5384
;5384:	lastConnState = cstate.connState;
ADDRGP4 lastConnState
ADDRLP4 0
INDIRI4
ASGNI4
line 5386
;5385:
;5386:	switch (cstate.connState) {
ADDRLP4 4400
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 4400
INDIRI4
CNSTI4 3
LTI4 $4372
ADDRLP4 4400
INDIRI4
CNSTI4 7
GTI4 $4372
ADDRLP4 4400
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $4411-12
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $4411
address $4398
address $4401
address $4404
address $4372
address $4372
code
LABELV $4398
line 5388
;5387:	case CA_CONNECTING:
;5388:		s = va("Awaiting connection...%i", cstate.connectPacketCount);
ADDRGP4 $4399
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 4408
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4380
ADDRLP4 4408
INDIRP4
ASGNP4
line 5389
;5389:		break;
ADDRGP4 $4396
JUMPV
LABELV $4401
line 5391
;5390:	case CA_CHALLENGING:
;5391:		s = va("Awaiting challenge...%i", cstate.connectPacketCount);
ADDRGP4 $4402
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 4412
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4380
ADDRLP4 4412
INDIRP4
ASGNP4
line 5392
;5392:		break;
ADDRGP4 $4396
JUMPV
LABELV $4404
line 5393
;5393:	case CA_CONNECTED: {
line 5396
;5394:		char downloadName[MAX_INFO_VALUE];
;5395:
;5396:		trap_Cvar_VariableStringBuffer("cl_downloadName", downloadName, sizeof(downloadName));
ADDRGP4 $4405
ARGP4
ADDRLP4 4416
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 5397
;5397:		if (*downloadName) {
ADDRLP4 4416
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $4406
line 5398
;5398:			UI_DisplayDownloadInfo(downloadName, centerPoint, yStart, scale);
ADDRLP4 4416
ARGP4
ADDRLP4 3084
INDIRF4
ARGF4
ADDRLP4 3092
INDIRF4
ARGF4
ADDRLP4 3088
INDIRF4
ARGF4
ADDRGP4 UI_DisplayDownloadInfo
CALLV
pop
line 5399
;5399:			return;
ADDRGP4 $4372
JUMPV
LABELV $4406
line 5401
;5400:		}
;5401:	}
line 5402
;5402:					 s = "Awaiting gamestate...";
ADDRLP4 4380
ADDRGP4 $4408
ASGNP4
line 5403
;5403:					 break;
line 5405
;5404:	case CA_LOADING:
;5405:		return;
line 5407
;5406:	case CA_PRIMED:
;5407:		return;
line 5409
;5408:	default:
;5409:		return;
LABELV $4396
line 5413
;5410:	}
;5411:
;5412:
;5413:	if (Q_stricmp(cstate.servername, "localhost")) {
ADDRLP4 0+12
ARGP4
ADDRGP4 $4384
ARGP4
ADDRLP4 4408
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4408
INDIRI4
CNSTI4 0
EQI4 $4413
line 5414
;5414:		Text_PaintCenter(centerPoint, yStart + 80, scale, colorWhite, s, 0);
ADDRLP4 3084
INDIRF4
ARGF4
ADDRLP4 3092
INDIRF4
CNSTF4 1117782016
ADDF4
ARGF4
ADDRLP4 3088
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 4380
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5415
;5415:	}
LABELV $4413
line 5418
;5416:
;5417:	// password required / connection rejected information goes here
;5418:}
LABELV $4372
endproc UI_DrawConnectScreen 5440 32
data
align 4
LABELV cvarTable
address ui_ffa_fraglimit
address $4417
address $682
byte 4 1
address ui_ffa_timelimit
address $4418
address $384
byte 4 1
address ui_tourney_fraglimit
address $4419
address $384
byte 4 1
address ui_tourney_timelimit
address $4420
address $683
byte 4 1
address ui_team_fraglimit
address $4421
address $384
byte 4 1
address ui_team_timelimit
address $4422
address $682
byte 4 1
address ui_team_friendly
address $4423
address $386
byte 4 1
address ui_ctf_capturelimit
address $4424
address $4425
byte 4 1
address ui_ctf_timelimit
address $4426
address $680
byte 4 1
address ui_ctf_friendly
address $4427
address $384
byte 4 1
address ui_arenasFile
address $4428
address $110
byte 4 80
address ui_botsFile
address $4429
address $110
byte 4 80
address ui_spScores1
address $4430
address $110
byte 4 65
address ui_spScores2
address $4431
address $110
byte 4 65
address ui_spScores3
address $4432
address $110
byte 4 65
address ui_spScores4
address $4433
address $110
byte 4 65
address ui_spScores5
address $4434
address $110
byte 4 65
address ui_spAwards
address $4435
address $110
byte 4 65
address ui_spVideos
address $4436
address $110
byte 4 65
address ui_spSkill
address $815
address $2227
byte 4 1
address ui_spSelection
address $4437
address $110
byte 4 64
address ui_browserMaster
address $4438
address $384
byte 4 1
address ui_browserGameType
address $4439
address $384
byte 4 1
address ui_browserSortKey
address $4440
address $2743
byte 4 1
address ui_browserShowFull
address $4441
address $386
byte 4 1
address ui_browserShowEmpty
address $4442
address $386
byte 4 1
address ui_brassTime
address $2320
address $4443
byte 4 1
address ui_drawCrosshair
address $2040
address $2743
byte 4 1
address ui_drawCrosshairNames
address $4444
address $386
byte 4 1
address ui_marks
address $4445
address $386
byte 4 1
address ui_server1
address $4446
address $110
byte 4 1
address ui_server2
address $4447
address $110
byte 4 1
address ui_server3
address $4448
address $110
byte 4 1
address ui_server4
address $4449
address $110
byte 4 1
address ui_server5
address $4450
address $110
byte 4 1
address ui_server6
address $4451
address $110
byte 4 1
address ui_server7
address $4452
address $110
byte 4 1
address ui_server8
address $4453
address $110
byte 4 1
address ui_server9
address $4454
address $110
byte 4 1
address ui_server10
address $4455
address $110
byte 4 1
address ui_server11
address $4456
address $110
byte 4 1
address ui_server12
address $4457
address $110
byte 4 1
address ui_server13
address $4458
address $110
byte 4 1
address ui_server14
address $4459
address $110
byte 4 1
address ui_server15
address $4460
address $110
byte 4 1
address ui_server16
address $4461
address $110
byte 4 1
address ui_cdkeychecked
address $4462
address $384
byte 4 64
address ui_new
address $4463
address $384
byte 4 256
address ui_debug
address $4464
address $384
byte 4 256
address ui_initialized
address $4465
address $384
byte 4 256
address ui_teamName
address $689
address $4466
byte 4 1
address ui_opponentName
address $1090
address $4467
byte 4 1
address ui_redteam
address $4468
address $4466
byte 4 1
address ui_blueteam
address $4469
address $4467
byte 4 1
address ui_dedicated
address $4470
address $384
byte 4 1
address ui_gameType
address $4471
address $4472
byte 4 1
address ui_joinGameType
address $4473
address $384
byte 4 1
address ui_netGameType
address $4474
address $4472
byte 4 1
address ui_actualNetGameType
address $4475
address $4472
byte 4 1
address ui_redteam1
address $4476
address $384
byte 4 1
address ui_redteam2
address $4477
address $384
byte 4 1
address ui_redteam3
address $4478
address $384
byte 4 1
address ui_redteam4
address $4479
address $384
byte 4 1
address ui_redteam5
address $4480
address $384
byte 4 1
address ui_blueteam1
address $4481
address $384
byte 4 1
address ui_blueteam2
address $4482
address $384
byte 4 1
address ui_blueteam3
address $4483
address $384
byte 4 1
address ui_blueteam4
address $4484
address $384
byte 4 1
address ui_blueteam5
address $4485
address $384
byte 4 1
address ui_netSource
address $1947
address $384
byte 4 1
address ui_serverFilterType
address $4486
address $384
byte 4 1
address ui_menuFiles
address $659
address $631
byte 4 1
address ui_currentTier
address $1012
address $384
byte 4 1
address ui_currentMap
address $879
address $384
byte 4 1
address ui_currentNetMap
address $877
address $384
byte 4 1
address ui_mapIndex
address $2187
address $384
byte 4 1
address ui_currentOpponent
address $4487
address $384
byte 4 1
address ui_selectedPlayer
address $1382
address $384
byte 4 1
address ui_selectedPlayerName
address $1390
address $110
byte 4 1
address ui_lastServerRefresh_0
address $4488
address $110
byte 4 1
address ui_lastServerRefresh_1
address $4489
address $110
byte 4 1
address ui_lastServerRefresh_2
address $4490
address $110
byte 4 1
address ui_lastServerRefresh_3
address $4491
address $110
byte 4 1
address ui_singlePlayerActive
address $2200
address $384
byte 4 0
address ui_scoreAccuracy
address $4492
address $384
byte 4 1
address ui_scoreImpressives
address $4493
address $384
byte 4 1
address ui_scoreExcellents
address $4494
address $384
byte 4 1
address ui_scoreCaptures
address $4495
address $384
byte 4 1
address ui_scoreDefends
address $4496
address $384
byte 4 1
address ui_scoreAssists
address $4497
address $384
byte 4 1
address ui_scoreGauntlets
address $4498
address $384
byte 4 1
address ui_scoreScore
address $4499
address $384
byte 4 1
address ui_scorePerfect
address $4500
address $384
byte 4 1
address ui_scoreTeam
address $4501
address $4502
byte 4 1
address ui_scoreBase
address $4503
address $384
byte 4 1
address ui_scoreTime
address $4504
address $4505
byte 4 1
address ui_scoreTimeBonus
address $4506
address $384
byte 4 1
address ui_scoreSkillBonus
address $4507
address $384
byte 4 1
address ui_scoreShutoutBonus
address $4508
address $384
byte 4 1
address ui_fragLimit
address $705
address $684
byte 4 0
address ui_captureLimit
address $703
address $685
byte 4 0
address ui_smallFont
address $4509
address $4510
byte 4 1
address ui_bigFont
address $4511
address $4512
byte 4 1
address ui_findPlayer
address $3146
address $4513
byte 4 1
address ui_Q3Model
address $4514
address $384
byte 4 1
address ui_hudFiles
address $4515
address $4516
byte 4 1
address ui_recordSPDemo
address $2219
address $384
byte 4 1
address ui_teamArenaFirstRun
address $4517
address $384
byte 4 1
address ui_realWarmUp
address $2211
address $682
byte 4 1
address ui_realCaptureLimit
address $706
address $4425
byte 4 1029
address ui_serverStatusTimeOut
address $4518
address $4519
byte 4 1
align 4
LABELV cvarTableSize
byte 4 111
export UI_RegisterCvars
code
proc UI_RegisterCvars 12 16
line 5456
;5419:
;5420:
;5421:/*
;5422:================
;5423:cvars
;5424:================
;5425:*/
;5426:
;5427:typedef struct {
;5428:	vmCvar_t *vmCvar;
;5429:	char *cvarName;
;5430:	char *defaultString;
;5431:	int			cvarFlags;
;5432:} cvarTable_t;
;5433:
;5434:#define DECLARE_UI_CVAR
;5435:#include "ui_cvar.h"
;5436:#undef DECLARE_UI_CVAR
;5437:
;5438:// bk001129 - made static to avoid aliasing
;5439:static cvarTable_t		cvarTable[] = {
;5440:
;5441:#define UI_CVAR_LIST
;5442:	#include "ui_cvar.h"
;5443:#undef UI_CVAR_LIST
;5444:
;5445:};
;5446:
;5447:// bk001129 - made static to avoid aliasing
;5448:static int		cvarTableSize = sizeof(cvarTable) / sizeof(cvarTable[0]);
;5449:
;5450:
;5451:/*
;5452:=================
;5453:UI_RegisterCvars
;5454:=================
;5455:*/
;5456:void UI_RegisterCvars(void) {
line 5460
;5457:	int			i;
;5458:	cvarTable_t *cv;
;5459:
;5460:	for (i = 0, cv = cvarTable; i < cvarTableSize; i++, cv++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $4524
JUMPV
LABELV $4521
line 5461
;5461:		trap_Cvar_Register(cv->vmCvar, cv->cvarName, cv->defaultString, cv->cvarFlags);
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5462
;5462:	}
LABELV $4522
line 5460
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
LABELV $4524
ADDRLP4 4
INDIRI4
ADDRGP4 cvarTableSize
INDIRI4
LTI4 $4521
line 5463
;5463:}
LABELV $4520
endproc UI_RegisterCvars 12 16
export UI_UpdateCvars
proc UI_UpdateCvars 8 4
line 5470
;5464:
;5465:/*
;5466:=================
;5467:UI_UpdateCvars
;5468:=================
;5469:*/
;5470:void UI_UpdateCvars(void) {
line 5474
;5471:	int			i;
;5472:	cvarTable_t *cv;
;5473:
;5474:	for (i = 0, cv = cvarTable; i < cvarTableSize; i++, cv++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 4
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $4529
JUMPV
LABELV $4526
line 5475
;5475:		trap_Cvar_Update(cv->vmCvar);
ADDRLP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 5476
;5476:	}
LABELV $4527
line 5474
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
LABELV $4529
ADDRLP4 0
INDIRI4
ADDRGP4 cvarTableSize
INDIRI4
LTI4 $4526
line 5477
;5477:}
LABELV $4525
endproc UI_UpdateCvars 8 4
proc UI_StopServerRefresh 12 12
line 5485
;5478:
;5479:
;5480:/*
;5481:=================
;5482:ArenaServers_StopRefresh
;5483:=================
;5484:*/
;5485:static void UI_StopServerRefresh(void) {
line 5488
;5486:	int count;
;5487:
;5488:	if (!uiInfo.serverStatus.refreshActive) {
ADDRGP4 uiInfo+99264+2212
INDIRI4
CNSTI4 0
NEI4 $4531
line 5490
;5489:		// not currently refreshing
;5490:		return;
ADDRGP4 $4530
JUMPV
LABELV $4531
line 5492
;5491:	}
;5492:	uiInfo.serverStatus.refreshActive = qfalse;
ADDRGP4 uiInfo+99264+2212
CNSTI4 0
ASGNI4
line 5493
;5493:	Com_Printf("%d servers listed in browser with %d players.\n",
ADDRGP4 $4537
ARGP4
ADDRGP4 uiInfo+99264+10412
INDIRI4
ARGI4
ADDRGP4 uiInfo+99264+10416
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 5496
;5494:		uiInfo.serverStatus.numDisplayServers,
;5495:		uiInfo.serverStatus.numPlayersOnServers);
;5496:	count = trap_LAN_GetServerCount(ui_netSource.integer);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 5497
;5497:	if (count - uiInfo.serverStatus.numDisplayServers > 0) {
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+99264+10412
INDIRI4
SUBI4
CNSTI4 0
LEI4 $4543
line 5498
;5498:		Com_Printf("%d servers not listed due to packet loss or pings higher than %d\n",
ADDRGP4 $4550
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRGP4 $4547
ARGP4
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+99264+10412
INDIRI4
SUBI4
ARGI4
ADDRLP4 8
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 5501
;5499:			count - uiInfo.serverStatus.numDisplayServers,
;5500:			(int)trap_Cvar_VariableValue("cl_maxPing"));
;5501:	}
LABELV $4543
line 5503
;5502:
;5503:}
LABELV $4530
endproc UI_StopServerRefresh 12 12
proc UI_DoServerRefresh 8 4
line 5510
;5504:
;5505:/*
;5506:=================
;5507:UI_DoServerRefresh
;5508:=================
;5509:*/
;5510:static void UI_DoServerRefresh(void) {
line 5511
;5511:	qboolean wait = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 5513
;5512:
;5513:	if (!uiInfo.serverStatus.refreshActive) {
ADDRGP4 uiInfo+99264+2212
INDIRI4
CNSTI4 0
NEI4 $4552
line 5514
;5514:		return;
ADDRGP4 $4551
JUMPV
LABELV $4552
line 5516
;5515:	}
;5516:	if (ui_netSource.integer != AS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 3
EQI4 $4556
line 5517
;5517:		if (ui_netSource.integer == AS_LOCAL) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
NEI4 $4559
line 5518
;5518:			if (!trap_LAN_GetServerCount(ui_netSource.integer)) {
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $4560
line 5519
;5519:				wait = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 5520
;5520:			}
line 5521
;5521:		} else {
ADDRGP4 $4560
JUMPV
LABELV $4559
line 5522
;5522:			if (trap_LAN_GetServerCount(ui_netSource.integer) < 0) {
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $4565
line 5523
;5523:				wait = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 5524
;5524:			}
LABELV $4565
line 5525
;5525:		}
LABELV $4560
line 5526
;5526:	}
LABELV $4556
line 5528
;5527:
;5528:	if (uiInfo.uiDC.realTime < uiInfo.serverStatus.refreshtime) {
ADDRGP4 uiInfo+208
INDIRI4
ADDRGP4 uiInfo+99264+2192
INDIRI4
GEI4 $4568
line 5529
;5529:		if (wait) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $4573
line 5530
;5530:			return;
ADDRGP4 $4551
JUMPV
LABELV $4573
line 5532
;5531:		}
;5532:	}
LABELV $4568
line 5535
;5533:
;5534:	// if still trying to retrieve pings
;5535:	if (trap_LAN_UpdateVisiblePings(ui_netSource.integer)) {
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 trap_LAN_UpdateVisiblePings
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $4575
line 5536
;5536:		uiInfo.serverStatus.refreshtime = uiInfo.uiDC.realTime + 1000;
ADDRGP4 uiInfo+99264+2192
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 5537
;5537:	} else if (!wait) {
ADDRGP4 $4576
JUMPV
LABELV $4575
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $4581
line 5539
;5538:		// get the last servers in the list
;5539:		UI_BuildServerDisplayList(2);
CNSTI4 2
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 5541
;5540:		// stop the refresh
;5541:		UI_StopServerRefresh();
ADDRGP4 UI_StopServerRefresh
CALLV
pop
line 5542
;5542:	}
LABELV $4581
LABELV $4576
line 5544
;5543:	//
;5544:	UI_BuildServerDisplayList(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 5545
;5545:}
LABELV $4551
endproc UI_DoServerRefresh 8 4
proc UI_StartServerRefresh 68 24
line 5552
;5546:
;5547:/*
;5548:=================
;5549:UI_StartServerRefresh
;5550:=================
;5551:*/
;5552:static void UI_StartServerRefresh(qboolean full) {
line 5557
;5553:	int		i;
;5554:	char *ptr;
;5555:
;5556:	qtime_t q;
;5557:	trap_RealTime(&q);
ADDRLP4 0
ARGP4
ADDRGP4 trap_RealTime
CALLI4
pop
line 5558
;5558:	trap_Cvar_Set(va("ui_lastServerRefresh_%i", ui_netSource.integer), va("%s-%i, %i at %i:%i", MonthAbbrev[q.tm_mon], q.tm_mday, 1900 + q.tm_year, q.tm_hour, q.tm_min));
ADDRGP4 $1305
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $4585
ARGP4
ADDRLP4 0+16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 MonthAbbrev
ADDP4
INDIRP4
ARGP4
ADDRLP4 0+12
INDIRI4
ARGI4
ADDRLP4 0+20
INDIRI4
CNSTI4 1900
ADDI4
ARGI4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5560
;5559:
;5560:	if (!full) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $4591
line 5561
;5561:		UI_UpdatePendingPings();
ADDRGP4 UI_UpdatePendingPings
CALLV
pop
line 5562
;5562:		return;
ADDRGP4 $4583
JUMPV
LABELV $4591
line 5565
;5563:	}
;5564:
;5565:	uiInfo.serverStatus.refreshActive = qtrue;
ADDRGP4 uiInfo+99264+2212
CNSTI4 1
ASGNI4
line 5566
;5566:	uiInfo.serverStatus.nextDisplayRefresh = uiInfo.uiDC.realTime + 1000;
ADDRGP4 uiInfo+99264+10420
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 5568
;5567:	// clear number of displayed servers
;5568:	uiInfo.serverStatus.numDisplayServers = 0;
ADDRGP4 uiInfo+99264+10412
CNSTI4 0
ASGNI4
line 5569
;5569:	uiInfo.serverStatus.numPlayersOnServers = 0;
ADDRGP4 uiInfo+99264+10416
CNSTI4 0
ASGNI4
line 5571
;5570:	// mark all servers as visible so we store ping updates for them
;5571:	trap_LAN_MarkServerVisible(ui_netSource.integer, -1, qtrue);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_LAN_MarkServerVisible
CALLV
pop
line 5573
;5572:	// reset all the pings
;5573:	trap_LAN_ResetPings(ui_netSource.integer);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 trap_LAN_ResetPings
CALLV
pop
line 5575
;5574:	//
;5575:	if (ui_netSource.integer == AS_LOCAL) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
NEI4 $4604
line 5576
;5576:		trap_Cmd_ExecuteText(EXEC_NOW, "localservers\n");
CNSTI4 0
ARGI4
ADDRGP4 $4607
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 5577
;5577:		uiInfo.serverStatus.refreshtime = uiInfo.uiDC.realTime + 1000;
ADDRGP4 uiInfo+99264+2192
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 5578
;5578:		return;
ADDRGP4 $4583
JUMPV
LABELV $4604
line 5581
;5579:	}
;5580:
;5581:	uiInfo.serverStatus.refreshtime = uiInfo.uiDC.realTime + 5000;
ADDRGP4 uiInfo+99264+2192
ADDRGP4 uiInfo+208
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 5582
;5582:	if (ui_netSource.integer == AS_GLOBAL || ui_netSource.integer == AS_MPLAYER) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 2
EQI4 $4618
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 1
NEI4 $4614
LABELV $4618
line 5583
;5583:		if (ui_netSource.integer == AS_GLOBAL) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 2
NEI4 $4619
line 5584
;5584:			i = 0;
ADDRLP4 40
CNSTI4 0
ASGNI4
line 5585
;5585:		} else {
ADDRGP4 $4620
JUMPV
LABELV $4619
line 5586
;5586:			i = 1;
ADDRLP4 40
CNSTI4 1
ASGNI4
line 5587
;5587:		}
LABELV $4620
line 5589
;5588:
;5589:		ptr = UI_Cvar_VariableString("debug_protocol");
ADDRGP4 $4236
ARGP4
ADDRLP4 52
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 36
ADDRLP4 52
INDIRP4
ASGNP4
line 5590
;5590:		if (strlen(ptr)) {
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $4622
line 5591
;5591:			trap_Cmd_ExecuteText(EXEC_NOW, va("globalservers %d %s full empty\n", i, ptr));
ADDRGP4 $4624
ARGP4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 0
ARGI4
ADDRLP4 60
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 5592
;5592:		} else {
ADDRGP4 $4623
JUMPV
LABELV $4622
line 5593
;5593:			trap_Cmd_ExecuteText(EXEC_NOW, va("globalservers %d %d full empty\n", i, (int)trap_Cvar_VariableValue("protocol")));
ADDRGP4 $2154
ARGP4
ADDRLP4 60
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRGP4 $4625
ARGP4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 60
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 64
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 0
ARGI4
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 5594
;5594:		}
LABELV $4623
line 5595
;5595:	}
LABELV $4614
line 5596
;5596:}
LABELV $4583
endproc UI_StartServerRefresh 68 24
bss
align 1
LABELV lastLoadingText
skip 1024
align 4
LABELV lastConnState
skip 4
export startTime
align 4
LABELV startTime
skip 4
import ProcessNewUI
import UI_RankStatusMenu
import RankStatus_Cache
import UI_SignupMenu
import Signup_Cache
import UI_LoginMenu
import Login_Cache
import UI_InitGameinfo
import UI_SPUnlockMedals_f
import UI_SPUnlock_f
import UI_GetAwardLevel
import UI_LogAwardData
import UI_NewGame
import UI_GetCurrentGame
import UI_CanShowTierVideo
import UI_ShowTierVideo
import UI_TierCompleted
import UI_SetBestScore
import UI_GetBestScore
import UI_GetBotNameByNumber
import UI_LoadBots
import UI_GetNumBots
import UI_GetBotInfoByName
import UI_GetBotInfoByNumber
import UI_GetNumSPTiers
import UI_GetNumSPArenas
import UI_GetNumArenas
import UI_GetSpecialArenaInfo
import UI_GetArenaInfoByMap
import UI_GetArenaInfoByNumber
import UI_NetworkOptionsMenu
import UI_NetworkOptionsMenu_Cache
import UI_SoundOptionsMenu
import UI_SoundOptionsMenu_Cache
import UI_DisplayOptionsMenu
import UI_DisplayOptionsMenu_Cache
import UI_SaveConfigMenu
import UI_SaveConfigMenu_Cache
import UI_LoadConfigMenu
import UI_LoadConfig_Cache
import UI_TeamOrdersMenu_Cache
import UI_TeamOrdersMenu_f
import UI_TeamOrdersMenu
import UI_RemoveBotsMenu
import UI_RemoveBots_Cache
import UI_AddBotsMenu
import UI_AddBots_Cache
import trap_SetPbClStatus
import trap_VerifyCDKey
import trap_R_RemapShader
import trap_RealTime
import trap_CIN_SetExtents
import trap_CIN_DrawCinematic
import trap_CIN_RunCinematic
import trap_CIN_StopCinematic
import trap_CIN_PlayCinematic
import trap_S_StartBackgroundTrack
import trap_S_StopBackgroundTrack
import trap_R_RegisterFont
import trap_SetCDKey
import trap_GetCDKey
import trap_MemoryRemaining
import trap_LAN_CompareServers
import trap_LAN_ServerStatus
import trap_LAN_ResetPings
import trap_LAN_RemoveServer
import trap_LAN_AddServer
import trap_LAN_UpdateVisiblePings
import trap_LAN_ServerIsVisible
import trap_LAN_MarkServerVisible
import trap_LAN_SaveCachedServers
import trap_LAN_LoadCachedServers
import trap_LAN_GetPingInfo
import trap_LAN_GetPing
import trap_LAN_ClearPing
import trap_LAN_GetPingQueueCount
import trap_LAN_GetServerPing
import trap_LAN_GetServerInfo
import trap_LAN_GetServerAddressString
import trap_LAN_GetServerCount
import trap_GetConfigString
import trap_GetGlconfig
import trap_GetClientState
import trap_GetClipboardData
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_ClearStates
import trap_Key_SetOverstrikeMode
import trap_Key_GetOverstrikeMode
import trap_Key_IsDown
import trap_Key_SetBinding
import trap_Key_GetBindingBuf
import trap_Key_KeynumToStringBuf
import trap_S_RegisterSound
import trap_S_StartLocalSound
import trap_CM_LerpTag
import trap_UpdateScreen
import trap_R_ModelBounds
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_AddLightToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Cmd_ExecuteText
import trap_Argv
import trap_Argc
import trap_Cvar_InfoStringBuffer
import trap_Cvar_Create
import trap_Cvar_Reset
import trap_Cvar_SetValue
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import UI_SPSkillMenu_Cache
import UI_SPSkillMenu
import UI_SPPostgameMenu_f
import UI_SPPostgameMenu_Cache
import UI_SPArena_Start
import UI_SPLevelMenu_ReInit
import UI_SPLevelMenu_f
import UI_SPLevelMenu
import UI_SPLevelMenu_Cache
import uis
import UI_LoadBestScores
import m_entersound
import UI_StartDemoLoop
import UI_Cvar_VariableString
import UI_Argv
import UI_ForceMenuOff
import UI_PopMenu
import UI_PushMenu
import UI_SetActiveMenu
import UI_IsFullscreen
import UI_DrawTextBox
import UI_AdjustFrom640
import UI_CursorInRect
import UI_DrawChar
import UI_DrawString
import UI_ProportionalStringWidth
import UI_DrawProportionalString
import UI_ProportionalSizeScale
import UI_DrawBannerString
import UI_LerpColor
import UI_SetColor
import UI_UpdateScreen
import UI_DrawSides
import UI_DrawTopBottom
import UI_DrawRect
import UI_FillRect
import UI_DrawHandlePic
import UI_DrawNamedPic
import UI_ClampCvar
import UI_ConsoleCommand
import UI_Refresh
import UI_MouseEvent
import UI_KeyEvent
import UI_Shutdown
import UI_Init
export uiInfo
align 4
LABELV uiInfo
skip 136912
import UI_RegisterClientModelname
import UI_PlayerInfo_SetInfo
import UI_PlayerInfo_SetModel
import UI_DrawPlayer
import DriverInfo_Cache
import GraphicsOptions_Cache
import UI_GraphicsOptionsMenu
import ServerInfo_Cache
import UI_ServerInfoMenu
import UI_BotSelectMenu_Cache
import UI_BotSelectMenu
import ServerOptions_Cache
import StartServer_Cache
import UI_StartServerMenu
import ArenaServers_Cache
import UI_ArenaServersMenu
import SpecifyServer_Cache
import UI_SpecifyServerMenu
import SpecifyLeague_Cache
import UI_SpecifyLeagueMenu
import Preferences_Cache
import UI_PreferencesMenu
import PlayerSettings_Cache
import UI_PlayerSettingsMenu
import PlayerModel_Cache
import UI_PlayerModelMenu
import UI_CDKeyMenu_f
import UI_CDKeyMenu_Cache
import UI_CDKeyMenu
import UI_ModsMenu_Cache
import UI_ModsMenu
import UI_CinematicsMenu_Cache
import UI_CinematicsMenu_f
import UI_CinematicsMenu
import Demos_Cache
import UI_DemosMenu
import Controls_Cache
import UI_ControlsMenu
import TeamMain_Cache
import UI_TeamMainMenu
import UI_SetupMenu
import UI_SetupMenu_Cache
import UI_ConfirmMenu
import ConfirmMenu_Cache
import UI_InGameMenu
import InGame_Cache
import UI_CreditMenu
import UI_MainMenu
import MainMenu_Cache
import UI_LoadArenas
import UI_ClearScores
import UI_AdjustTimeByGame
import MenuField_Key
import MenuField_Draw
import MenuField_Init
import MField_Draw
import MField_CharEvent
import MField_KeyDownEvent
import MField_Clear
import ui_medalSounds
import ui_medalPicNames
import ui_medalNames
import text_color_highlight
import text_color_normal
import text_color_disabled
import listbar_color
import list_color
import name_color
import color_dim
import color_red
import color_orange
import color_blue
import color_yellow
import color_white
import color_black
import menu_dim_color
import menu_black_color
import menu_red_color
import menu_highlight_color
import menu_dark_color
import menu_grayed_color
import menu_text_color
import weaponChangeSound
import menu_null_sound
import menu_buzz_sound
import menu_out_sound
import menu_move_sound
import menu_in_sound
import ScrollList_Key
import ScrollList_Draw
import Bitmap_Draw
import Bitmap_Init
import Menu_DefaultKey
import Menu_SetCursorToItem
import Menu_SetCursor
import Menu_ActivateItem
import Menu_ItemAtCursor
import Menu_Draw
import Menu_AdjustCursor
import Menu_AddItem
import Menu_Focus
import Menu_Cache
export ui_serverStatusTimeOut
align 4
LABELV ui_serverStatusTimeOut
skip 272
export ui_realCaptureLimit
align 4
LABELV ui_realCaptureLimit
skip 272
export ui_realWarmUp
align 4
LABELV ui_realWarmUp
skip 272
export ui_teamArenaFirstRun
align 4
LABELV ui_teamArenaFirstRun
skip 272
export ui_recordSPDemo
align 4
LABELV ui_recordSPDemo
skip 272
export ui_hudFiles
align 4
LABELV ui_hudFiles
skip 272
export ui_Q3Model
align 4
LABELV ui_Q3Model
skip 272
export ui_findPlayer
align 4
LABELV ui_findPlayer
skip 272
export ui_bigFont
align 4
LABELV ui_bigFont
skip 272
export ui_smallFont
align 4
LABELV ui_smallFont
skip 272
export ui_captureLimit
align 4
LABELV ui_captureLimit
skip 272
export ui_fragLimit
align 4
LABELV ui_fragLimit
skip 272
export ui_scoreShutoutBonus
align 4
LABELV ui_scoreShutoutBonus
skip 272
export ui_scoreSkillBonus
align 4
LABELV ui_scoreSkillBonus
skip 272
export ui_scoreTimeBonus
align 4
LABELV ui_scoreTimeBonus
skip 272
export ui_scoreTime
align 4
LABELV ui_scoreTime
skip 272
export ui_scoreBase
align 4
LABELV ui_scoreBase
skip 272
export ui_scoreTeam
align 4
LABELV ui_scoreTeam
skip 272
export ui_scorePerfect
align 4
LABELV ui_scorePerfect
skip 272
export ui_scoreScore
align 4
LABELV ui_scoreScore
skip 272
export ui_scoreGauntlets
align 4
LABELV ui_scoreGauntlets
skip 272
export ui_scoreAssists
align 4
LABELV ui_scoreAssists
skip 272
export ui_scoreDefends
align 4
LABELV ui_scoreDefends
skip 272
export ui_scoreCaptures
align 4
LABELV ui_scoreCaptures
skip 272
export ui_scoreExcellents
align 4
LABELV ui_scoreExcellents
skip 272
export ui_scoreImpressives
align 4
LABELV ui_scoreImpressives
skip 272
export ui_scoreAccuracy
align 4
LABELV ui_scoreAccuracy
skip 272
export ui_singlePlayerActive
align 4
LABELV ui_singlePlayerActive
skip 272
export ui_lastServerRefresh_3
align 4
LABELV ui_lastServerRefresh_3
skip 272
export ui_lastServerRefresh_2
align 4
LABELV ui_lastServerRefresh_2
skip 272
export ui_lastServerRefresh_1
align 4
LABELV ui_lastServerRefresh_1
skip 272
export ui_lastServerRefresh_0
align 4
LABELV ui_lastServerRefresh_0
skip 272
export ui_selectedPlayerName
align 4
LABELV ui_selectedPlayerName
skip 272
export ui_selectedPlayer
align 4
LABELV ui_selectedPlayer
skip 272
export ui_currentOpponent
align 4
LABELV ui_currentOpponent
skip 272
export ui_mapIndex
align 4
LABELV ui_mapIndex
skip 272
export ui_currentNetMap
align 4
LABELV ui_currentNetMap
skip 272
export ui_currentMap
align 4
LABELV ui_currentMap
skip 272
export ui_currentTier
align 4
LABELV ui_currentTier
skip 272
export ui_menuFiles
align 4
LABELV ui_menuFiles
skip 272
export ui_serverFilterType
align 4
LABELV ui_serverFilterType
skip 272
export ui_netSource
align 4
LABELV ui_netSource
skip 272
export ui_blueteam5
align 4
LABELV ui_blueteam5
skip 272
export ui_blueteam4
align 4
LABELV ui_blueteam4
skip 272
export ui_blueteam3
align 4
LABELV ui_blueteam3
skip 272
export ui_blueteam2
align 4
LABELV ui_blueteam2
skip 272
export ui_blueteam1
align 4
LABELV ui_blueteam1
skip 272
export ui_redteam5
align 4
LABELV ui_redteam5
skip 272
export ui_redteam4
align 4
LABELV ui_redteam4
skip 272
export ui_redteam3
align 4
LABELV ui_redteam3
skip 272
export ui_redteam2
align 4
LABELV ui_redteam2
skip 272
export ui_redteam1
align 4
LABELV ui_redteam1
skip 272
export ui_actualNetGameType
align 4
LABELV ui_actualNetGameType
skip 272
export ui_netGameType
align 4
LABELV ui_netGameType
skip 272
export ui_joinGameType
align 4
LABELV ui_joinGameType
skip 272
export ui_gameType
align 4
LABELV ui_gameType
skip 272
export ui_dedicated
align 4
LABELV ui_dedicated
skip 272
export ui_blueteam
align 4
LABELV ui_blueteam
skip 272
export ui_redteam
align 4
LABELV ui_redteam
skip 272
export ui_opponentName
align 4
LABELV ui_opponentName
skip 272
export ui_teamName
align 4
LABELV ui_teamName
skip 272
export ui_initialized
align 4
LABELV ui_initialized
skip 272
export ui_debug
align 4
LABELV ui_debug
skip 272
export ui_new
align 4
LABELV ui_new
skip 272
export ui_cdkeychecked
align 4
LABELV ui_cdkeychecked
skip 272
export ui_server16
align 4
LABELV ui_server16
skip 272
export ui_server15
align 4
LABELV ui_server15
skip 272
export ui_server14
align 4
LABELV ui_server14
skip 272
export ui_server13
align 4
LABELV ui_server13
skip 272
export ui_server12
align 4
LABELV ui_server12
skip 272
export ui_server11
align 4
LABELV ui_server11
skip 272
export ui_server10
align 4
LABELV ui_server10
skip 272
export ui_server9
align 4
LABELV ui_server9
skip 272
export ui_server8
align 4
LABELV ui_server8
skip 272
export ui_server7
align 4
LABELV ui_server7
skip 272
export ui_server6
align 4
LABELV ui_server6
skip 272
export ui_server5
align 4
LABELV ui_server5
skip 272
export ui_server4
align 4
LABELV ui_server4
skip 272
export ui_server3
align 4
LABELV ui_server3
skip 272
export ui_server2
align 4
LABELV ui_server2
skip 272
export ui_server1
align 4
LABELV ui_server1
skip 272
export ui_marks
align 4
LABELV ui_marks
skip 272
export ui_drawCrosshairNames
align 4
LABELV ui_drawCrosshairNames
skip 272
export ui_drawCrosshair
align 4
LABELV ui_drawCrosshair
skip 272
export ui_brassTime
align 4
LABELV ui_brassTime
skip 272
export ui_browserShowEmpty
align 4
LABELV ui_browserShowEmpty
skip 272
export ui_browserShowFull
align 4
LABELV ui_browserShowFull
skip 272
export ui_browserSortKey
align 4
LABELV ui_browserSortKey
skip 272
export ui_browserGameType
align 4
LABELV ui_browserGameType
skip 272
export ui_browserMaster
align 4
LABELV ui_browserMaster
skip 272
export ui_spSelection
align 4
LABELV ui_spSelection
skip 272
export ui_spSkill
align 4
LABELV ui_spSkill
skip 272
export ui_spVideos
align 4
LABELV ui_spVideos
skip 272
export ui_spAwards
align 4
LABELV ui_spAwards
skip 272
export ui_spScores5
align 4
LABELV ui_spScores5
skip 272
export ui_spScores4
align 4
LABELV ui_spScores4
skip 272
export ui_spScores3
align 4
LABELV ui_spScores3
skip 272
export ui_spScores2
align 4
LABELV ui_spScores2
skip 272
export ui_spScores1
align 4
LABELV ui_spScores1
skip 272
export ui_botsFile
align 4
LABELV ui_botsFile
skip 272
export ui_arenasFile
align 4
LABELV ui_arenasFile
skip 272
export ui_ctf_friendly
align 4
LABELV ui_ctf_friendly
skip 272
export ui_ctf_timelimit
align 4
LABELV ui_ctf_timelimit
skip 272
export ui_ctf_capturelimit
align 4
LABELV ui_ctf_capturelimit
skip 272
export ui_team_friendly
align 4
LABELV ui_team_friendly
skip 272
export ui_team_timelimit
align 4
LABELV ui_team_timelimit
skip 272
export ui_team_fraglimit
align 4
LABELV ui_team_fraglimit
skip 272
export ui_tourney_timelimit
align 4
LABELV ui_tourney_timelimit
skip 272
export ui_tourney_fraglimit
align 4
LABELV ui_tourney_fraglimit
skip 272
export ui_ffa_timelimit
align 4
LABELV ui_ffa_timelimit
skip 272
export ui_ffa_fraglimit
align 4
LABELV ui_ffa_fraglimit
skip 272
import trap_PC_SourceFileAndLine
import trap_PC_ReadToken
import trap_PC_FreeSource
import trap_PC_LoadSource
import trap_PC_AddGlobalDefine
import Controls_SetDefaults
import Controls_SetConfig
import Controls_GetConfig
import UI_OutOfMemory
import UI_InitMemory
import UI_Alloc
import Display_CacheAll
import Menu_SetFeederSelection
import Menu_Paint
import Menus_CloseAll
import LerpColor
import Display_HandleKey
import Menus_CloseByName
import Menus_ShowByName
import Menus_FindByName
import Menus_OpenByName
import Display_KeyBindPending
import Display_CursorType
import Display_MouseMove
import Display_CaptureItem
import Display_GetContext
import Menus_Activate
import Menus_AnyFullScreenVisible
import Menu_Reset
import Menus_ActivateByName
import Menu_PaintAll
import Menu_New
import Menu_Count
import PC_Script_Parse
import PC_String_Parse
import PC_Rect_Parse
import PC_Int_Parse
import PC_Color_Parse
import PC_Float_Parse
import String_Parse
import Rect_Parse
import Int_Parse
import Color_Parse
import Float_Parse
import Menu_ScrollFeeder
import Menu_HandleMouseMove
import Menu_HandleKey
import Menu_GetFocused
import Menu_PostParse
import Item_Init
import Menu_Init
import Init_Display
import String_Report
import String_Init
import String_Alloc
import BigEndian
import replace1
import Q_stradd
import Q_strcpy
import BG_StripColor
import BG_CleanName
import DecodedString
import EncodedString
import strtok
import Q_stristr
import BG_sprintf
import BG_PlayerTouchesItem
import BG_PlayerStateToEntityStateExtraPolate
import BG_PlayerStateToEntityState
import BG_TouchJumpPad
import BG_AddPredictableEventToPlayerstate
import BG_EvaluateTrajectoryDelta
import BG_EvaluateTrajectory
import BG_CanItemBeGrabbed
import BG_FindItemForHoldable
import BG_FindItemForPowerup
import BG_FindItemForWeapon
import BG_FindItem
import bg_numItems
import bg_itemlist
import Pmove
import PM_UpdateViewAngles
import Com_Printf
import Com_Error
import Info_NextPair
import Info_ValidateKeyValue
import Info_Validate
import Info_SetValueForKey_Big
import Info_SetValueForKey
import Info_ValueForKey
import va
import Q_CleanStr
import Q_PrintStrlen
import Q_strcat
import Q_strncpyz
import Q_strrchr
import Q_strupr
import Q_strlwr
import Q_stricmpn
import Q_strncmp
import Q_stricmp
import Q_isalpha
import Q_isupper
import Q_islower
import Q_isprint
import locase
import Com_sprintf
import Parse3DMatrix
import Parse2DMatrix
import Parse1DMatrix
import SkipRestOfLine
import SkipBracedSection
import COM_MatchToken
import Com_Split
import COM_ParseSep
import Com_InitSeparators
import SkipTillSeparators
import COM_ParseWarning
import COM_ParseError
import COM_Compress
import COM_ParseExt
import COM_Parse
import COM_GetCurrentParseLine
import COM_BeginParseSession
import COM_DefaultExtension
import COM_StripExtension
import COM_SkipPath
import Com_Clamp
import PerpendicularVector
import AngleVectors
import MatrixMultiply
import MakeNormalVectors
import RotateAroundDirection
import RotatePointAroundVector
import ProjectPointOnPlane
import PlaneFromPoints
import AngleDelta
import AngleNormalize180
import AngleNormalize360
import AnglesSubtract
import AngleSubtract
import LerpAngle
import AngleMod
import BoxOnPlaneSide
import SetPlaneSignbits
import AxisCopy
import AxisClear
import AnglesToAxis
import vectoangles
import Q_crandom
import Q_random
import Q_rand
import Q_acos
import Q_log2
import VectorRotate
import Vector4Scale
import VectorNormalize2
import VectorNormalize
import CrossProduct
import VectorInverse
import VectorNormalizeFast
import DistanceSquared
import Distance
import VectorLengthSquared
import VectorLength
import VectorCompare
import AddPointToBounds
import ClearBounds
import RadiusFromBounds
import NormalizeColor
import ColorBytes4
import ColorBytes3
import _VectorMA
import _VectorScale
import _VectorCopy
import _VectorAdd
import _VectorSubtract
import _DotProduct
import ByteToDir
import DirToByte
import ClampShort
import ClampChar
import Q_rsqrt
import Q_fabs
import axisDefault
import vec3_origin
import g_color_table
import colorDkGrey
import colorMdGrey
import colorLtGrey
import colorWhite
import colorCyan
import colorMagenta
import colorYellow
import colorBlue
import colorGreen
import colorRed
import colorBlack
import bytedirs
import Hunk_Alloc
import acos
import fabs
import abs
import tan
import atan2
import cos
import sin
import sqrt
import floor
import ceil
import memcpy
import memset
import memmove
import Q_sscanf
import ED_vsprintf
import atoi
import atof
import toupper
import tolower
import strncpy
import strstr
import strchr
import strcmp
import strcpy
import strcat
import strlen
import rand
import srand
import qsort
lit
align 1
LABELV $4625
byte 1 103
byte 1 108
byte 1 111
byte 1 98
byte 1 97
byte 1 108
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 32
byte 1 101
byte 1 109
byte 1 112
byte 1 116
byte 1 121
byte 1 10
byte 1 0
align 1
LABELV $4624
byte 1 103
byte 1 108
byte 1 111
byte 1 98
byte 1 97
byte 1 108
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 32
byte 1 101
byte 1 109
byte 1 112
byte 1 116
byte 1 121
byte 1 10
byte 1 0
align 1
LABELV $4607
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $4585
byte 1 37
byte 1 115
byte 1 45
byte 1 37
byte 1 105
byte 1 44
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $4550
byte 1 99
byte 1 108
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 80
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $4547
byte 1 37
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 100
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 32
byte 1 108
byte 1 111
byte 1 115
byte 1 115
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 115
byte 1 32
byte 1 104
byte 1 105
byte 1 103
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $4537
byte 1 37
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $4519
byte 1 55
byte 1 48
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $4518
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 79
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $4517
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 70
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 82
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $4516
byte 1 117
byte 1 105
byte 1 47
byte 1 104
byte 1 117
byte 1 100
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $4515
byte 1 99
byte 1 103
byte 1 95
byte 1 104
byte 1 117
byte 1 100
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $4514
byte 1 117
byte 1 105
byte 1 95
byte 1 113
byte 1 51
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $4513
byte 1 83
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $4512
byte 1 48
byte 1 46
byte 1 52
byte 1 0
align 1
LABELV $4511
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 105
byte 1 103
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $4510
byte 1 48
byte 1 46
byte 1 50
byte 1 53
byte 1 0
align 1
LABELV $4509
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $4508
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 83
byte 1 104
byte 1 117
byte 1 116
byte 1 111
byte 1 117
byte 1 116
byte 1 66
byte 1 111
byte 1 110
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $4507
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 83
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 66
byte 1 111
byte 1 110
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $4506
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 66
byte 1 111
byte 1 110
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $4505
byte 1 48
byte 1 48
byte 1 58
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $4504
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $4503
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 66
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $4502
byte 1 48
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 48
byte 1 0
align 1
LABELV $4501
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $4500
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 80
byte 1 101
byte 1 114
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $4499
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $4498
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 71
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $4497
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 65
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $4496
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 68
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $4495
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $4494
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 69
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $4493
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 73
byte 1 109
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $4492
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 65
byte 1 99
byte 1 99
byte 1 117
byte 1 114
byte 1 97
byte 1 99
byte 1 121
byte 1 0
align 1
LABELV $4491
byte 1 117
byte 1 105
byte 1 95
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 82
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 95
byte 1 51
byte 1 0
align 1
LABELV $4490
byte 1 117
byte 1 105
byte 1 95
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 82
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 95
byte 1 50
byte 1 0
align 1
LABELV $4489
byte 1 117
byte 1 105
byte 1 95
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 82
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $4488
byte 1 117
byte 1 105
byte 1 95
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 82
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $4487
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 79
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $4486
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 70
byte 1 105
byte 1 108
byte 1 116
byte 1 101
byte 1 114
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $4485
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 53
byte 1 0
align 1
LABELV $4484
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 52
byte 1 0
align 1
LABELV $4483
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 51
byte 1 0
align 1
LABELV $4482
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 50
byte 1 0
align 1
LABELV $4481
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 49
byte 1 0
align 1
LABELV $4480
byte 1 117
byte 1 105
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 53
byte 1 0
align 1
LABELV $4479
byte 1 117
byte 1 105
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 52
byte 1 0
align 1
LABELV $4478
byte 1 117
byte 1 105
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 51
byte 1 0
align 1
LABELV $4477
byte 1 117
byte 1 105
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 50
byte 1 0
align 1
LABELV $4476
byte 1 117
byte 1 105
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 49
byte 1 0
align 1
LABELV $4475
byte 1 117
byte 1 105
byte 1 95
byte 1 97
byte 1 99
byte 1 116
byte 1 117
byte 1 97
byte 1 108
byte 1 78
byte 1 101
byte 1 116
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $4474
byte 1 117
byte 1 105
byte 1 95
byte 1 110
byte 1 101
byte 1 116
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $4473
byte 1 117
byte 1 105
byte 1 95
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $4472
byte 1 51
byte 1 0
align 1
LABELV $4471
byte 1 117
byte 1 105
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $4470
byte 1 117
byte 1 105
byte 1 95
byte 1 100
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $4469
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $4468
byte 1 117
byte 1 105
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $4467
byte 1 83
byte 1 116
byte 1 114
byte 1 111
byte 1 103
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $4466
byte 1 80
byte 1 97
byte 1 103
byte 1 97
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $4465
byte 1 117
byte 1 105
byte 1 95
byte 1 105
byte 1 110
byte 1 105
byte 1 116
byte 1 105
byte 1 97
byte 1 108
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $4464
byte 1 117
byte 1 105
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 0
align 1
LABELV $4463
byte 1 117
byte 1 105
byte 1 95
byte 1 110
byte 1 101
byte 1 119
byte 1 0
align 1
LABELV $4462
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 100
byte 1 107
byte 1 101
byte 1 121
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $4461
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 54
byte 1 0
align 1
LABELV $4460
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 53
byte 1 0
align 1
LABELV $4459
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 52
byte 1 0
align 1
LABELV $4458
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 51
byte 1 0
align 1
LABELV $4457
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 50
byte 1 0
align 1
LABELV $4456
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 49
byte 1 0
align 1
LABELV $4455
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $4454
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 57
byte 1 0
align 1
LABELV $4453
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 56
byte 1 0
align 1
LABELV $4452
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 55
byte 1 0
align 1
LABELV $4451
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 54
byte 1 0
align 1
LABELV $4450
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 53
byte 1 0
align 1
LABELV $4449
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 52
byte 1 0
align 1
LABELV $4448
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 51
byte 1 0
align 1
LABELV $4447
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $4446
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $4445
byte 1 99
byte 1 103
byte 1 95
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 115
byte 1 0
align 1
LABELV $4444
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 67
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $4443
byte 1 50
byte 1 53
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $4442
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 83
byte 1 104
byte 1 111
byte 1 119
byte 1 69
byte 1 109
byte 1 112
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $4441
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 83
byte 1 104
byte 1 111
byte 1 119
byte 1 70
byte 1 117
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $4440
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 83
byte 1 111
byte 1 114
byte 1 116
byte 1 75
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $4439
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $4438
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 114
byte 1 111
byte 1 119
byte 1 115
byte 1 101
byte 1 114
byte 1 77
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $4437
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $4436
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 86
byte 1 105
byte 1 100
byte 1 101
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $4435
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 65
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $4434
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 53
byte 1 0
align 1
LABELV $4433
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 52
byte 1 0
align 1
LABELV $4432
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 51
byte 1 0
align 1
LABELV $4431
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 50
byte 1 0
align 1
LABELV $4430
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 49
byte 1 0
align 1
LABELV $4429
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $4428
byte 1 103
byte 1 95
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $4427
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $4426
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $4425
byte 1 56
byte 1 0
align 1
LABELV $4424
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 116
byte 1 102
byte 1 95
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $4423
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $4422
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $4421
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $4420
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $4419
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $4418
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $4417
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 102
byte 1 97
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $4408
byte 1 65
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 101
byte 1 46
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $4405
byte 1 99
byte 1 108
byte 1 95
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $4402
byte 1 65
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 101
byte 1 46
byte 1 46
byte 1 46
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $4399
byte 1 65
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 46
byte 1 46
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $4389
byte 1 109
byte 1 111
byte 1 116
byte 1 100
byte 1 0
align 1
LABELV $4386
byte 1 67
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $4385
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 117
byte 1 112
byte 1 46
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $4384
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 104
byte 1 111
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $4380
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $4373
byte 1 67
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $4371
byte 1 37
byte 1 115
byte 1 47
byte 1 83
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $4368
byte 1 40
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 112
byte 1 105
byte 1 101
byte 1 100
byte 1 41
byte 1 0
align 1
LABELV $4359
byte 1 40
byte 1 37
byte 1 115
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 112
byte 1 105
byte 1 101
byte 1 100
byte 1 41
byte 1 0
align 1
LABELV $4358
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $4354
byte 1 37
byte 1 115
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 37
byte 1 37
byte 1 41
byte 1 0
align 1
LABELV $4351
byte 1 99
byte 1 108
byte 1 95
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $4350
byte 1 99
byte 1 108
byte 1 95
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 67
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $4349
byte 1 99
byte 1 108
byte 1 95
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 83
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $4322
byte 1 37
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $4321
byte 1 37
byte 1 100
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $4318
byte 1 37
byte 1 100
byte 1 32
byte 1 104
byte 1 114
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $4314
byte 1 37
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 116
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $4313
byte 1 37
byte 1 100
byte 1 32
byte 1 75
byte 1 66
byte 1 0
align 1
LABELV $4310
byte 1 46
byte 1 37
byte 1 48
byte 1 50
byte 1 100
byte 1 32
byte 1 77
byte 1 66
byte 1 0
align 1
LABELV $4307
byte 1 46
byte 1 37
byte 1 48
byte 1 50
byte 1 100
byte 1 32
byte 1 71
byte 1 66
byte 1 0
align 1
LABELV $4301
byte 1 105
byte 1 110
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $4299
byte 1 101
byte 1 110
byte 1 100
byte 1 111
byte 1 102
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $4291
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 95
byte 1 112
byte 1 111
byte 1 112
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 0
align 1
LABELV $4236
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 116
byte 1 111
byte 1 99
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $4235
byte 1 48
byte 1 46
byte 1 53
byte 1 0
align 1
LABELV $4234
byte 1 115
byte 1 95
byte 1 109
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 118
byte 1 111
byte 1 108
byte 1 117
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $4233
byte 1 48
byte 1 46
byte 1 56
byte 1 0
align 1
LABELV $4232
byte 1 115
byte 1 95
byte 1 118
byte 1 111
byte 1 108
byte 1 117
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $4231
byte 1 117
byte 1 105
byte 1 95
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 70
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 82
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $4213
byte 1 117
byte 1 105
byte 1 47
byte 1 105
byte 1 110
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $4209
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $4205
byte 1 119
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $4203
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 51
byte 1 95
byte 1 99
byte 1 117
byte 1 114
byte 1 115
byte 1 111
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $4130
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $4111
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $4110
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $4107
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $4106
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $4105
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 0
align 1
LABELV $4097
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $4096
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $4094
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $4093
byte 1 46
byte 1 0
align 1
LABELV $4083
byte 1 47
byte 1 0
align 1
LABELV $4082
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $4034
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $4029
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $4024
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $4009
byte 1 84
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 44
byte 1 32
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $4001
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $3945
byte 1 84
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 115
byte 1 44
byte 1 32
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $3940
byte 1 84
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 110
byte 1 101
byte 1 116
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 115
byte 1 44
byte 1 32
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $3898
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $3895
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $3890
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $3873
byte 1 84
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 101
byte 1 115
byte 1 44
byte 1 32
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $3863
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 117
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 97
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $3835
byte 1 84
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 44
byte 1 32
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $3825
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $3818
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $3815
byte 1 74
byte 1 97
byte 1 110
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $3811
byte 1 102
byte 1 101
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $3806
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $3779
byte 1 84
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 44
byte 1 32
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 100
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $3772
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $3614
byte 1 42
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $3511
byte 1 78
byte 1 111
byte 1 0
align 1
LABELV $3510
byte 1 89
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $3507
byte 1 112
byte 1 117
byte 1 110
byte 1 107
byte 1 98
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $3505
byte 1 46
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $3501
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $3497
byte 1 37
byte 1 115
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 0
align 1
LABELV $3494
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $3493
byte 1 110
byte 1 101
byte 1 116
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $3492
byte 1 37
byte 1 115
byte 1 32
byte 1 91
byte 1 37
byte 1 115
byte 1 93
byte 1 0
align 1
LABELV $3315
byte 1 115
byte 1 0
align 1
LABELV $3312
byte 1 37
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $3307
byte 1 110
byte 1 111
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $3223
byte 1 115
byte 1 101
byte 1 97
byte 1 114
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 100
byte 1 47
byte 1 37
byte 1 100
byte 1 46
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $3165
byte 1 115
byte 1 101
byte 1 97
byte 1 114
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 100
byte 1 46
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $3157
byte 1 99
byte 1 108
byte 1 95
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 82
byte 1 101
byte 1 115
byte 1 101
byte 1 110
byte 1 100
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $3146
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $3101
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $3100
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $3099
byte 1 110
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $3061
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $3060
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $3059
byte 1 77
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $3058
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $3057
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $3056
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $3055
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $3054
byte 1 65
byte 1 100
byte 1 100
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $3053
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $3052
byte 1 115
byte 1 118
byte 1 95
byte 1 104
byte 1 111
byte 1 115
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $3036
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $3024
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $3004
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $2961
byte 1 87
byte 1 101
byte 1 108
byte 1 99
byte 1 111
byte 1 109
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 33
byte 1 0
align 1
LABELV $2950
byte 1 99
byte 1 108
byte 1 95
byte 1 109
byte 1 111
byte 1 116
byte 1 100
byte 1 83
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $2793
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $2790
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $2754
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 85
byte 1 73
byte 1 32
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2751
byte 1 115
byte 1 101
byte 1 116
byte 1 80
byte 1 98
byte 1 67
byte 1 108
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $2746
byte 1 117
byte 1 112
byte 1 100
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $2743
byte 1 52
byte 1 0
align 1
LABELV $2742
byte 1 103
byte 1 108
byte 1 67
byte 1 117
byte 1 115
byte 1 116
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $2739
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $2736
byte 1 118
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 115
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $2724
byte 1 10
byte 1 0
align 1
LABELV $2717
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $2708
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 97
byte 1 118
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 65
byte 1 100
byte 1 100
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $2707
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 97
byte 1 118
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2703
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 70
byte 1 97
byte 1 118
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $2690
byte 1 100
byte 1 101
byte 1 108
byte 1 101
byte 1 116
byte 1 101
byte 1 70
byte 1 97
byte 1 118
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $2687
byte 1 65
byte 1 100
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 97
byte 1 118
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2686
byte 1 70
byte 1 97
byte 1 118
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 32
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $2683
byte 1 70
byte 1 97
byte 1 118
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $2678
byte 1 97
byte 1 100
byte 1 100
byte 1 114
byte 1 0
align 1
LABELV $2677
byte 1 104
byte 1 111
byte 1 115
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2668
byte 1 97
byte 1 100
byte 1 100
byte 1 70
byte 1 97
byte 1 118
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $2652
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2649
byte 1 97
byte 1 100
byte 1 100
byte 1 66
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $2646
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 76
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2640
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 103
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $2634
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2629
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2623
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 75
byte 1 105
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $2617
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2611
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 77
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $2608
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 105
byte 1 110
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2605
byte 1 83
byte 1 107
byte 1 105
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 104
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $2602
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 83
byte 1 107
byte 1 105
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $2586
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 83
byte 1 111
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $2583
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $2582
byte 1 76
byte 1 101
byte 1 97
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $2579
byte 1 115
byte 1 101
byte 1 116
byte 1 117
byte 1 112
byte 1 95
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 50
byte 1 0
align 1
LABELV $2578
byte 1 99
byte 1 108
byte 1 95
byte 1 112
byte 1 97
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $2577
byte 1 67
byte 1 111
byte 1 110
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $2574
byte 1 113
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $2573
byte 1 81
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $2563
byte 1 70
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 74
byte 1 111
byte 1 105
byte 1 110
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2560
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2546
byte 1 74
byte 1 111
byte 1 105
byte 1 110
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2541
byte 1 70
byte 1 105
byte 1 110
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2534
byte 1 70
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $2524
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $2518
byte 1 85
byte 1 112
byte 1 100
byte 1 97
byte 1 116
byte 1 101
byte 1 70
byte 1 105
byte 1 108
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2511
byte 1 83
byte 1 116
byte 1 111
byte 1 112
byte 1 82
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $2508
byte 1 109
byte 1 97
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $2507
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2498
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 74
byte 1 111
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $2495
byte 1 81
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 51
byte 1 0
align 1
LABELV $2490
byte 1 100
byte 1 101
byte 1 109
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2489
byte 1 82
byte 1 117
byte 1 110
byte 1 68
byte 1 101
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $2486
byte 1 118
byte 1 105
byte 1 100
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 59
byte 1 0
align 1
LABELV $2483
byte 1 102
byte 1 115
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2482
byte 1 82
byte 1 117
byte 1 110
byte 1 77
byte 1 111
byte 1 100
byte 1 0
align 1
LABELV $2477
byte 1 99
byte 1 105
byte 1 110
byte 1 101
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 99
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 114
byte 1 111
byte 1 113
byte 1 32
byte 1 50
byte 1 10
byte 1 0
align 1
LABELV $2472
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 77
byte 1 111
byte 1 118
byte 1 105
byte 1 101
byte 1 0
align 1
LABELV $2469
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 77
byte 1 111
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $2466
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 77
byte 1 111
byte 1 118
byte 1 105
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $2463
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 68
byte 1 101
byte 1 109
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $2454
byte 1 100
byte 1 101
byte 1 109
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $2450
byte 1 82
byte 1 117
byte 1 110
byte 1 83
byte 1 80
byte 1 68
byte 1 101
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $2447
byte 1 82
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 70
byte 1 105
byte 1 108
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2444
byte 1 82
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $2441
byte 1 114
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $2432
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 0
align 1
LABELV $2429
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 77
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $2428
byte 1 99
byte 1 108
byte 1 101
byte 1 97
byte 1 114
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $2425
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 67
byte 1 111
byte 1 110
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $2422
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 67
byte 1 111
byte 1 110
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 115
byte 1 0
align 1
LABELV $2419
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2418
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 0
align 1
LABELV $2415
byte 1 67
byte 1 68
byte 1 32
byte 1 75
byte 1 101
byte 1 121
byte 1 32
byte 1 100
byte 1 111
byte 1 101
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 112
byte 1 112
byte 1 101
byte 1 97
byte 1 114
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 46
byte 1 0
align 1
LABELV $2414
byte 1 67
byte 1 68
byte 1 32
byte 1 75
byte 1 101
byte 1 121
byte 1 32
byte 1 65
byte 1 112
byte 1 112
byte 1 101
byte 1 97
byte 1 114
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 46
byte 1 0
align 1
LABELV $2413
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 100
byte 1 107
byte 1 101
byte 1 121
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $2412
byte 1 99
byte 1 100
byte 1 107
byte 1 101
byte 1 121
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 115
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $2409
byte 1 99
byte 1 100
byte 1 107
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $2408
byte 1 118
byte 1 101
byte 1 114
byte 1 105
byte 1 102
byte 1 121
byte 1 67
byte 1 68
byte 1 75
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $2400
byte 1 99
byte 1 100
byte 1 107
byte 1 101
byte 1 121
byte 1 52
byte 1 0
align 1
LABELV $2399
byte 1 99
byte 1 100
byte 1 107
byte 1 101
byte 1 121
byte 1 51
byte 1 0
align 1
LABELV $2398
byte 1 99
byte 1 100
byte 1 107
byte 1 101
byte 1 121
byte 1 50
byte 1 0
align 1
LABELV $2397
byte 1 99
byte 1 100
byte 1 107
byte 1 101
byte 1 121
byte 1 49
byte 1 0
align 1
LABELV $2396
byte 1 103
byte 1 101
byte 1 116
byte 1 67
byte 1 68
byte 1 75
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $2393
byte 1 118
byte 1 105
byte 1 100
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $2392
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 114
byte 1 111
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $2391
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $2390
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $2389
byte 1 114
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 68
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $2382
byte 1 117
byte 1 112
byte 1 100
byte 1 97
byte 1 116
byte 1 101
byte 1 83
byte 1 80
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 0
align 1
LABELV $2372
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $2369
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2340
byte 1 100
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $2339
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2333
byte 1 109
byte 1 95
byte 1 112
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $2330
byte 1 117
byte 1 105
byte 1 95
byte 1 109
byte 1 111
byte 1 117
byte 1 115
byte 1 101
byte 1 80
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $2325
byte 1 71
byte 1 76
byte 1 95
byte 1 76
byte 1 73
byte 1 78
byte 1 69
byte 1 65
byte 1 82
byte 1 95
byte 1 77
byte 1 73
byte 1 80
byte 1 77
byte 1 65
byte 1 80
byte 1 95
byte 1 78
byte 1 69
byte 1 65
byte 1 82
byte 1 69
byte 1 83
byte 1 84
byte 1 0
align 1
LABELV $2322
byte 1 71
byte 1 76
byte 1 95
byte 1 76
byte 1 73
byte 1 78
byte 1 69
byte 1 65
byte 1 82
byte 1 95
byte 1 77
byte 1 73
byte 1 80
byte 1 77
byte 1 65
byte 1 80
byte 1 95
byte 1 76
byte 1 73
byte 1 78
byte 1 69
byte 1 65
byte 1 82
byte 1 0
align 1
LABELV $2321
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $2320
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 114
byte 1 97
byte 1 115
byte 1 115
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2319
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 115
byte 1 0
align 1
LABELV $2318
byte 1 114
byte 1 95
byte 1 105
byte 1 110
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 86
byte 1 105
byte 1 100
byte 1 101
byte 1 111
byte 1 0
align 1
LABELV $2317
byte 1 114
byte 1 95
byte 1 102
byte 1 97
byte 1 115
byte 1 116
byte 1 83
byte 1 107
byte 1 121
byte 1 0
align 1
LABELV $2316
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 98
byte 1 105
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $2315
byte 1 114
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $2314
byte 1 114
byte 1 95
byte 1 112
byte 1 105
byte 1 99
byte 1 109
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $2313
byte 1 114
byte 1 95
byte 1 118
byte 1 101
byte 1 114
byte 1 116
byte 1 101
byte 1 120
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $2312
byte 1 114
byte 1 95
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 83
byte 1 99
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $2308
byte 1 117
byte 1 105
byte 1 95
byte 1 103
byte 1 108
byte 1 67
byte 1 117
byte 1 115
byte 1 116
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $2303
byte 1 114
byte 1 95
byte 1 115
byte 1 117
byte 1 98
byte 1 100
byte 1 105
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $2299
byte 1 114
byte 1 95
byte 1 108
byte 1 111
byte 1 100
byte 1 98
byte 1 105
byte 1 97
byte 1 115
byte 1 0
align 1
LABELV $2292
byte 1 114
byte 1 95
byte 1 115
byte 1 116
byte 1 101
byte 1 110
byte 1 99
byte 1 105
byte 1 108
byte 1 98
byte 1 105
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $2291
byte 1 114
byte 1 95
byte 1 100
byte 1 101
byte 1 112
byte 1 116
byte 1 104
byte 1 98
byte 1 105
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $2287
byte 1 114
byte 1 95
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 98
byte 1 105
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $2284
byte 1 117
byte 1 105
byte 1 95
byte 1 71
byte 1 101
byte 1 116
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2279
byte 1 99
byte 1 108
byte 1 95
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 100
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $2278
byte 1 99
byte 1 108
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 112
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $2275
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $2274
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 101
byte 1 116
byte 1 82
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $2271
byte 1 117
byte 1 105
byte 1 95
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2270
byte 1 117
byte 1 105
byte 1 95
byte 1 83
byte 1 101
byte 1 116
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2266
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 32
byte 1 53
byte 1 59
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 82
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $2242
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2228
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 32
byte 1 59
byte 1 32
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 44
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 10
byte 1 0
align 1
LABELV $2227
byte 1 50
byte 1 0
align 1
LABELV $2224
byte 1 117
byte 1 105
byte 1 95
byte 1 114
byte 1 101
byte 1 99
byte 1 111
byte 1 114
byte 1 100
byte 1 83
byte 1 80
byte 1 68
byte 1 101
byte 1 109
byte 1 111
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2220
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $2219
byte 1 117
byte 1 105
byte 1 95
byte 1 114
byte 1 101
byte 1 99
byte 1 111
byte 1 114
byte 1 100
byte 1 83
byte 1 80
byte 1 68
byte 1 101
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $2216
byte 1 103
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $2215
byte 1 103
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $2214
byte 1 117
byte 1 105
byte 1 95
byte 1 112
byte 1 117
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $2213
byte 1 115
byte 1 118
byte 1 95
byte 1 112
byte 1 117
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $2212
byte 1 117
byte 1 105
byte 1 95
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $2211
byte 1 103
byte 1 95
byte 1 119
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $2210
byte 1 117
byte 1 105
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $2209
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $2208
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $2207
byte 1 103
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $2206
byte 1 117
byte 1 105
byte 1 95
byte 1 100
byte 1 111
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $2205
byte 1 103
byte 1 95
byte 1 100
byte 1 111
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $2204
byte 1 117
byte 1 105
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2203
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2202
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 70
byte 1 114
byte 1 97
byte 1 103
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $2201
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $2200
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $2197
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 77
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $2193
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 32
byte 1 59
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 32
byte 1 59
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2187
byte 1 117
byte 1 105
byte 1 95
byte 1 109
byte 1 97
byte 1 112
byte 1 73
byte 1 110
byte 1 100
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $2183
byte 1 115
byte 1 107
byte 1 105
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $2157
byte 1 46
byte 1 100
byte 1 109
byte 1 95
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $2156
byte 1 100
byte 1 101
byte 1 109
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $2154
byte 1 112
byte 1 114
byte 1 111
byte 1 116
byte 1 111
byte 1 99
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $2153
byte 1 100
byte 1 109
byte 1 95
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $2150
byte 1 46
byte 1 114
byte 1 111
byte 1 113
byte 1 0
align 1
LABELV $2135
byte 1 114
byte 1 111
byte 1 113
byte 1 0
align 1
LABELV $2134
byte 1 118
byte 1 105
byte 1 100
byte 1 101
byte 1 111
byte 1 0
align 1
LABELV $2125
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $2110
byte 1 36
byte 1 109
byte 1 111
byte 1 100
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $2062
byte 1 69
byte 1 118
byte 1 101
byte 1 114
byte 1 121
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $2040
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 67
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $1947
byte 1 117
byte 1 105
byte 1 95
byte 1 110
byte 1 101
byte 1 116
byte 1 83
byte 1 111
byte 1 117
byte 1 114
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $1836
byte 1 117
byte 1 105
byte 1 95
byte 1 97
byte 1 99
byte 1 116
byte 1 117
byte 1 97
byte 1 108
byte 1 110
byte 1 101
byte 1 116
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $1805
byte 1 117
byte 1 105
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $1747
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $1728
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1531
byte 1 80
byte 1 73
byte 1 88
byte 1 69
byte 1 76
byte 1 70
byte 1 79
byte 1 82
byte 1 77
byte 1 65
byte 1 84
byte 1 58
byte 1 32
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 40
byte 1 37
byte 1 100
byte 1 45
byte 1 98
byte 1 105
byte 1 116
byte 1 115
byte 1 41
byte 1 32
byte 1 90
byte 1 40
byte 1 37
byte 1 100
byte 1 45
byte 1 98
byte 1 105
byte 1 116
byte 1 115
byte 1 41
byte 1 32
byte 1 115
byte 1 116
byte 1 101
byte 1 110
byte 1 99
byte 1 105
byte 1 108
byte 1 40
byte 1 37
byte 1 100
byte 1 45
byte 1 98
byte 1 105
byte 1 116
byte 1 115
byte 1 41
byte 1 0
align 1
LABELV $1527
byte 1 86
byte 1 69
byte 1 82
byte 1 83
byte 1 73
byte 1 79
byte 1 78
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1524
byte 1 86
byte 1 69
byte 1 78
byte 1 68
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1416
byte 1 82
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 32
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1413
byte 1 71
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 32
byte 1 40
byte 1 69
byte 1 83
byte 1 67
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 108
byte 1 41
byte 1 0
align 1
LABELV $1400
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $1390
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $1382
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1362
byte 1 110
byte 1 0
align 1
LABELV $1351
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $1350
byte 1 116
byte 1 0
align 1
LABELV $1349
byte 1 116
byte 1 108
byte 1 0
align 1
LABELV $1314
byte 1 103
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $1305
byte 1 117
byte 1 105
byte 1 95
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 82
byte 1 101
byte 1 102
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 95
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1303
byte 1 80
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 69
byte 1 78
byte 1 84
byte 1 69
byte 1 82
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 67
byte 1 76
byte 1 73
byte 1 67
byte 1 75
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 44
byte 1 32
byte 1 80
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 66
byte 1 65
byte 1 67
byte 1 75
byte 1 83
byte 1 80
byte 1 65
byte 1 67
byte 1 69
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 101
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $1302
byte 1 87
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 110
byte 1 101
byte 1 119
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 80
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 69
byte 1 83
byte 1 67
byte 1 65
byte 1 80
byte 1 69
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 99
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $1267
byte 1 37
byte 1 105
byte 1 46
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1090
byte 1 117
byte 1 105
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $1083
byte 1 117
byte 1 105
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $1078
byte 1 74
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $1030
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1017
byte 1 84
byte 1 105
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1012
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 84
byte 1 105
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1009
byte 1 70
byte 1 105
byte 1 108
byte 1 116
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $975
byte 1 83
byte 1 111
byte 1 117
byte 1 114
byte 1 99
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $958
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $957
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $954
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $953
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $952
byte 1 117
byte 1 105
byte 1 95
byte 1 81
byte 1 51
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $909
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 58
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 0
align 1
LABELV $894
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $879
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 77
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $877
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 117
byte 1 114
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 78
byte 1 101
byte 1 116
byte 1 77
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $847
byte 1 72
byte 1 117
byte 1 109
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $844
byte 1 67
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $838
byte 1 117
byte 1 105
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $837
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $831
byte 1 82
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $830
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $829
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $822
byte 1 117
byte 1 105
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $821
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $815
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $781
byte 1 37
byte 1 115
byte 1 46
byte 1 114
byte 1 111
byte 1 113
byte 1 0
align 1
LABELV $762
byte 1 37
byte 1 115
byte 1 95
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $757
byte 1 37
byte 1 115
byte 1 95
byte 1 109
byte 1 101
byte 1 116
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $729
byte 1 117
byte 1 105
byte 1 95
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $719
byte 1 117
byte 1 105
byte 1 95
byte 1 97
byte 1 99
byte 1 116
byte 1 117
byte 1 97
byte 1 108
byte 1 78
byte 1 101
byte 1 116
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $718
byte 1 117
byte 1 105
byte 1 95
byte 1 110
byte 1 101
byte 1 116
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $707
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $706
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $705
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $704
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $703
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $689
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $687
byte 1 104
byte 1 97
byte 1 110
byte 1 100
byte 1 105
byte 1 99
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $685
byte 1 53
byte 1 0
align 1
LABELV $684
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $683
byte 1 49
byte 1 53
byte 1 0
align 1
LABELV $682
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $681
byte 1 50
byte 1 53
byte 1 0
align 1
LABELV $680
byte 1 51
byte 1 48
byte 1 0
align 1
LABELV $679
byte 1 51
byte 1 53
byte 1 0
align 1
LABELV $678
byte 1 52
byte 1 48
byte 1 0
align 1
LABELV $677
byte 1 52
byte 1 53
byte 1 0
align 1
LABELV $676
byte 1 53
byte 1 48
byte 1 0
align 1
LABELV $675
byte 1 53
byte 1 53
byte 1 0
align 1
LABELV $674
byte 1 54
byte 1 48
byte 1 0
align 1
LABELV $673
byte 1 54
byte 1 53
byte 1 0
align 1
LABELV $672
byte 1 55
byte 1 48
byte 1 0
align 1
LABELV $671
byte 1 55
byte 1 53
byte 1 0
align 1
LABELV $670
byte 1 56
byte 1 48
byte 1 0
align 1
LABELV $669
byte 1 56
byte 1 53
byte 1 0
align 1
LABELV $668
byte 1 57
byte 1 48
byte 1 0
align 1
LABELV $667
byte 1 57
byte 1 53
byte 1 0
align 1
LABELV $666
byte 1 78
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $665
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $659
byte 1 117
byte 1 105
byte 1 95
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 70
byte 1 105
byte 1 108
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $657
byte 1 85
byte 1 73
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 61
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 109
byte 1 105
byte 1 108
byte 1 108
byte 1 105
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $654
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 0
align 1
LABELV $634
byte 1 94
byte 1 49
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 117
byte 1 105
byte 1 47
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 115
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 44
byte 1 32
byte 1 117
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 116
byte 1 105
byte 1 110
byte 1 117
byte 1 101
byte 1 33
byte 1 10
byte 1 0
align 1
LABELV $631
byte 1 117
byte 1 105
byte 1 47
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 115
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $630
byte 1 94
byte 1 51
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 117
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $608
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 100
byte 1 101
byte 1 102
byte 1 0
align 1
LABELV $602
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 71
byte 1 108
byte 1 111
byte 1 98
byte 1 97
byte 1 108
byte 1 68
byte 1 101
byte 1 102
byte 1 0
align 1
LABELV $588
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $582
byte 1 71
byte 1 108
byte 1 121
byte 1 112
byte 1 104
byte 1 32
byte 1 104
byte 1 97
byte 1 110
byte 1 100
byte 1 108
byte 1 101
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $577
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 10
byte 1 0
align 1
LABELV $576
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 32
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 10
byte 1 0
align 1
LABELV $565
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $557
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 89
byte 1 0
align 1
LABELV $549
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 88
byte 1 0
align 1
LABELV $541
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 65
byte 1 109
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $533
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 67
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $525
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 67
byte 1 108
byte 1 97
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $513
byte 1 99
byte 1 117
byte 1 114
byte 1 115
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $505
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 66
byte 1 117
byte 1 122
byte 1 122
byte 1 83
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $497
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 70
byte 1 111
byte 1 99
byte 1 117
byte 1 115
byte 1 83
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $489
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 69
byte 1 120
byte 1 105
byte 1 116
byte 1 83
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $481
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 69
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 83
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $473
byte 1 103
byte 1 114
byte 1 97
byte 1 100
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 98
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $464
byte 1 98
byte 1 105
byte 1 103
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $455
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $444
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $440
byte 1 125
byte 1 0
align 1
LABELV $431
byte 1 123
byte 1 0
align 1
LABELV $424
byte 1 94
byte 1 49
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 108
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 44
byte 1 32
byte 1 109
byte 1 97
byte 1 120
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $421
byte 1 94
byte 1 49
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 117
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $386
byte 1 49
byte 1 0
align 1
LABELV $385
byte 1 115
byte 1 118
byte 1 95
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $384
byte 1 48
byte 1 0
align 1
LABELV $383
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $220
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 110
byte 1 101
byte 1 119
byte 1 104
byte 1 105
byte 1 103
byte 1 104
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $218
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 37
byte 1 99
byte 1 0
align 1
LABELV $211
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 108
byte 1 105
byte 1 100
byte 1 101
byte 1 114
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 95
byte 1 49
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $208
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 108
byte 1 105
byte 1 100
byte 1 101
byte 1 114
byte 1 50
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $205
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 99
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 116
byte 1 104
byte 1 117
byte 1 109
byte 1 98
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $202
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 99
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 95
byte 1 114
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $199
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 99
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 95
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $196
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 99
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 95
byte 1 117
byte 1 112
byte 1 95
byte 1 97
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $193
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 99
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 98
byte 1 97
byte 1 114
byte 1 95
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 95
byte 1 100
byte 1 119
byte 1 110
byte 1 95
byte 1 97
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $190
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 115
byte 1 99
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 98
byte 1 97
byte 1 114
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $187
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 120
byte 1 95
byte 1 119
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $183
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 120
byte 1 95
byte 1 99
byte 1 121
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $179
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 120
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $175
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 120
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $171
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 120
byte 1 95
byte 1 103
byte 1 114
byte 1 110
byte 1 0
align 1
LABELV $167
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 120
byte 1 95
byte 1 121
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $163
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 120
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $160
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 120
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $157
byte 1 117
byte 1 105
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 97
byte 1 100
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 98
byte 1 97
byte 1 114
byte 1 50
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $138
byte 1 73
byte 1 80
byte 1 88
byte 1 0
align 1
LABELV $137
byte 1 85
byte 1 68
byte 1 80
byte 1 0
align 1
LABELV $136
byte 1 63
byte 1 63
byte 1 63
byte 1 0
align 1
LABELV $135
byte 1 80
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $134
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 84
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $133
byte 1 79
byte 1 112
byte 1 101
byte 1 110
byte 1 32
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 83
byte 1 112
byte 1 111
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $132
byte 1 77
byte 1 97
byte 1 112
byte 1 32
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $131
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $130
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 84
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $129
byte 1 72
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $128
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $127
byte 1 79
byte 1 110
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 32
byte 1 67
byte 1 84
byte 1 70
byte 1 0
align 1
LABELV $126
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $125
byte 1 67
byte 1 108
byte 1 97
byte 1 110
byte 1 32
byte 1 65
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 0
align 1
LABELV $124
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $123
byte 1 83
byte 1 105
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 32
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $122
byte 1 84
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $121
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 70
byte 1 111
byte 1 114
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $120
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 84
byte 1 79
byte 1 85
byte 1 82
byte 1 78
byte 1 65
byte 1 77
byte 1 69
byte 1 78
byte 1 84
byte 1 0
align 1
LABELV $119
byte 1 72
byte 1 65
byte 1 82
byte 1 86
byte 1 69
byte 1 83
byte 1 84
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $118
byte 1 79
byte 1 86
byte 1 69
byte 1 82
byte 1 76
byte 1 79
byte 1 65
byte 1 68
byte 1 0
align 1
LABELV $117
byte 1 49
byte 1 70
byte 1 67
byte 1 84
byte 1 70
byte 1 0
align 1
LABELV $116
byte 1 67
byte 1 84
byte 1 70
byte 1 0
align 1
LABELV $115
byte 1 67
byte 1 65
byte 1 0
align 1
LABELV $114
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 32
byte 1 68
byte 1 77
byte 1 0
align 1
LABELV $113
byte 1 83
byte 1 80
byte 1 0
align 1
LABELV $112
byte 1 84
byte 1 79
byte 1 85
byte 1 82
byte 1 78
byte 1 65
byte 1 77
byte 1 69
byte 1 78
byte 1 84
byte 1 0
align 1
LABELV $111
byte 1 70
byte 1 70
byte 1 65
byte 1 0
align 1
LABELV $110
byte 1 0
align 1
LABELV $109
byte 1 65
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $108
byte 1 70
byte 1 97
byte 1 118
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $107
byte 1 73
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 110
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $106
byte 1 77
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $105
byte 1 76
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $104
byte 1 78
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 109
byte 1 97
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $103
byte 1 72
byte 1 97
byte 1 114
byte 1 100
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $102
byte 1 72
byte 1 117
byte 1 114
byte 1 116
byte 1 32
byte 1 77
byte 1 101
byte 1 32
byte 1 80
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $101
byte 1 66
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 73
byte 1 116
byte 1 32
byte 1 79
byte 1 110
byte 1 0
align 1
LABELV $100
byte 1 73
byte 1 32
byte 1 67
byte 1 97
byte 1 110
byte 1 32
byte 1 87
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $99
byte 1 68
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $98
byte 1 78
byte 1 111
byte 1 118
byte 1 0
align 1
LABELV $97
byte 1 79
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $96
byte 1 83
byte 1 101
byte 1 112
byte 1 0
align 1
LABELV $95
byte 1 65
byte 1 117
byte 1 103
byte 1 0
align 1
LABELV $94
byte 1 74
byte 1 117
byte 1 108
byte 1 0
align 1
LABELV $93
byte 1 74
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $92
byte 1 77
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $91
byte 1 65
byte 1 112
byte 1 114
byte 1 0
align 1
LABELV $90
byte 1 77
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $89
byte 1 70
byte 1 101
byte 1 98
byte 1 0
align 1
LABELV $88
byte 1 74
byte 1 97
byte 1 110
byte 1 0

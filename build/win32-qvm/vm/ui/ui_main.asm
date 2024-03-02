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
address $109
address $110
address $111
address $112
align 4
LABELV numNetSources
byte 4 8
align 4
LABELV serverFilters
address $113
address $114
align 4
LABELV teamArenaGameTypes
address $115
address $116
address $117
address $118
address $119
address $120
address $121
address $122
address $123
address $124
address $125
address $126
address $127
align 4
LABELV numTeamArenaGameTypes
byte 4 13
align 4
LABELV teamArenaGameNames
address $128
address $129
address $130
address $131
address $132
address $133
address $134
address $135
address $136
address $137
address $138
address $139
address $140
align 4
LABELV numTeamArenaGameNames
byte 4 13
align 4
LABELV numServerFilters
byte 4 1
align 4
LABELV sortKeys
address $141
address $142
address $143
address $144
address $145
align 4
LABELV numSortKeys
byte 4 5
align 4
LABELV netnames
address $146
address $147
address $148
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
proc vmMain 12 12
file "..\..\..\..\code\ui\ui_main.c"
line 149
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
;11:#include "ui_local.h"
;12:
;13:uiInfo_t uiInfo;
;14:
;15:static const char *MonthAbbrev[] = {
;16:	"Jan","Feb","Mar",
;17:	"Apr","May","Jun",
;18:	"Jul","Aug","Sep",
;19:	"Oct","Nov","Dec"
;20:};
;21:
;22:static const char *skillLevels[] = {
;23:  "I Can Win",
;24:  "Bring It On",
;25:  "Hurt Me Plenty",
;26:  "Hardcore",
;27:  "Nightmare"
;28:};
;29:static const int numSkillLevels = sizeof(skillLevels) / sizeof(const char *);
;30:
;31:#define UIAS_LOCAL                             0
;32:#define UIAS_GLOBAL0				   1
;33:#define UIAS_GLOBAL1                   2
;34:#define UIAS_GLOBAL2                   3
;35:#define UIAS_GLOBAL3                   4
;36:#define UIAS_GLOBAL4                   5
;37:#define UIAS_GLOBAL5                   6
;38:#define UIAS_FAVORITES                 7
;39:
;40:static const char *netSources[] = {
;41:	"Local",
;42:	"Internet",
;43:	"Master1",
;44:	"Master2",
;45:	"Master3",
;46:	"Master4",
;47:	"Master5",
;48:	"Favorites"
;49:};
;50:static const int numNetSources = ARRAY_LEN(netSources);
;51:
;52:static const serverFilter_t serverFilters[] = {
;53:	{"All", "" }
;54:};
;55:
;56:static const char *teamArenaGameTypes[] = {
;57:	"FFA",
;58:	"DUEL",
;59:	"RACE",
;60:	"TDM",
;61:	"CA",
;62:	"CTF",
;63:	"1FLAG",
;64:	"OBELISK",
;65:	"HARVESTER",
;66:	"FREEZETAG",
;67:	"DOMINATION",
;68:	"ATTACK AND DEFEND",
;69:	"RED ROVER"
;70:};
;71:static int const numTeamArenaGameTypes = sizeof(teamArenaGameTypes) / sizeof(const char *);
;72:
;73:
;74:static const char *teamArenaGameNames[] = {
;75:	"Free For All",
;76:	"Duel",
;77:	"Race",
;78:	"Team Deathmatch",
;79:	"Clan Arena",
;80:	"Capture the Flag",
;81:	"One Flag",
;82:	"Overload",
;83:	"Harvester",
;84:	"Freeze Tag",
;85:	"Domination",
;86:	"Attack and Defend",
;87:	"Red Rover"
;88:};
;89:static int const numTeamArenaGameNames = sizeof(teamArenaGameNames) / sizeof(const char *);
;90:
;91:
;92:static const int numServerFilters = sizeof(serverFilters) / sizeof(serverFilter_t);
;93:
;94:static const char *sortKeys[] = {
;95:	"Server Name",
;96:	"Map Name",
;97:	"Open Player Spots",
;98:	"Game Type",
;99:	"Ping Time"
;100:};
;101:static const int numSortKeys = sizeof(sortKeys) / sizeof(const char *);
;102:
;103:static char *netnames[] = {
;104:	"???",
;105:	"UDP",
;106:	"IPX",
;107:	NULL
;108:};
;109:
;110:static int gamecodetoui[] = { 4,2,3,0,5,1,6 };
;111:static int uitogamecode[] = { 4,6,2,3,1,5,7 };
;112:
;113:static void UI_StartServerRefresh(qboolean full, qboolean force);
;114:static void UI_StopServerRefresh(void);
;115:static void UI_DoServerRefresh(void);
;116:static void UI_FeederSelection(float feederID, int index);
;117:static void UI_BuildServerDisplayList(int force);
;118:static void UI_BuildServerStatus(qboolean force);
;119:static void UI_BuildFindPlayerList(qboolean force);
;120:static int QDECL UI_ServersQsortCompare(const void *arg1, const void *arg2);
;121:static int UI_MapCountByGameType(void);
;122:static int UI_HeadCountByTeam(void);
;123:static void UI_ParseGameInfo(const char *teamFile);
;124:static void UI_ParseTeamInfo(const char *teamFile);
;125:static const char *UI_SelectedMap(int index, int *actual);
;126:static const char *UI_SelectedHead(int index, int *actual);
;127:static int UI_GetIndexFromSelection(int actual);
;128:
;129:/*
;130:================
;131:vmMain
;132:
;133:This is the only way control passes into the module.
;134:This must be the very first function compiled into the .qvm file
;135:================
;136:*/
;137:vmCvar_t  ui_new;
;138:vmCvar_t  ui_debug;
;139:vmCvar_t  ui_initialized;
;140:vmCvar_t  ui_teamArenaFirstRun;
;141:
;142:void _UI_Init(qboolean);
;143:void _UI_Shutdown(void);
;144:void _UI_KeyEvent(int key, qboolean down);
;145:void _UI_MouseEvent(int dx, int dy, qboolean active);
;146:void _UI_Refresh(int realtime);
;147:qboolean _UI_IsFullscreen(void);
;148:
;149:int vmMain(int command, int arg0, int arg1, int arg2, int arg3, int arg4, int arg5, int arg6, int arg7, int arg8, int arg9, int arg10, int arg11) {
line 150
;150:	switch (command) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $150
ADDRLP4 0
INDIRI4
CNSTI4 10
GTI4 $150
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $163
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $163
address $152
address $153
address $154
address $155
address $156
address $157
address $158
address $159
address $160
address $161
address $162
code
LABELV $152
line 152
;151:	case UI_GETAPIVERSION:
;152:		return UI_API_VERSION;
CNSTI4 6
RETI4
ADDRGP4 $149
JUMPV
LABELV $153
line 155
;153:
;154:	case UI_INIT:
;155:		_UI_Init(arg0);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 _UI_Init
CALLV
pop
line 156
;156:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $149
JUMPV
LABELV $154
line 159
;157:
;158:	case UI_SHUTDOWN:
;159:		_UI_Shutdown();
ADDRGP4 _UI_Shutdown
CALLV
pop
line 160
;160:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $149
JUMPV
LABELV $155
line 163
;161:
;162:	case UI_KEY_EVENT:
;163:		_UI_KeyEvent(arg0, arg1);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 _UI_KeyEvent
CALLV
pop
line 164
;164:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $149
JUMPV
LABELV $156
line 167
;165:
;166:	case UI_MOUSE_EVENT:
;167:		_UI_MouseEvent(arg0, arg1, qfalse);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 _UI_MouseEvent
CALLV
pop
line 168
;168:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $149
JUMPV
LABELV $157
line 171
;169:
;170:	case UI_REFRESH:
;171:		_UI_Refresh(arg0);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 _UI_Refresh
CALLV
pop
line 172
;172:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $149
JUMPV
LABELV $158
line 175
;173:
;174:	case UI_IS_FULLSCREEN:
;175:		return _UI_IsFullscreen();
ADDRLP4 4
ADDRGP4 _UI_IsFullscreen
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $149
JUMPV
LABELV $159
line 178
;176:
;177:	case UI_SET_ACTIVE_MENU:
;178:		_UI_SetActiveMenu(arg0);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 _UI_SetActiveMenu
CALLV
pop
line 179
;179:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $149
JUMPV
LABELV $160
line 182
;180:
;181:	case UI_CONSOLE_COMMAND:
;182:		return UI_ConsoleCommand(arg0);
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
ADDRGP4 $149
JUMPV
LABELV $161
line 185
;183:
;184:	case UI_DRAW_CONNECT_SCREEN:
;185:		UI_DrawConnectScreen(arg0);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UI_DrawConnectScreen
CALLV
pop
line 186
;186:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $149
JUMPV
LABELV $162
line 189
;187:
;188:	case UI_HASUNIQUECDKEY: // mod authors need to observe this
;189:		return qtrue; // bk010117 - change this to qfalse for mods!
CNSTI4 1
RETI4
ADDRGP4 $149
JUMPV
LABELV $150
line 193
;190:
;191:	}
;192:
;193:	return -1;
CNSTI4 -1
RETI4
LABELV $149
endproc vmMain 12 12
export AssetCache
proc AssetCache 84 8
line 197
;194:}
;195:
;196:
;197:void AssetCache() {
line 200
;198:	int n;
;199:
;200:	uiInfo.uiDC.Assets.gradientBar = trap_R_RegisterShaderNoMip(ASSET_GRADIENTBAR);
ADDRGP4 $167
ARGP4
ADDRLP4 4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342500
ADDRLP4 4
INDIRI4
ASGNI4
line 201
;201:	uiInfo.uiDC.Assets.fxBasePic = trap_R_RegisterShaderNoMip(ART_FX_BASE);
ADDRGP4 $170
ARGP4
ADDRLP4 8
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342608
ADDRLP4 8
INDIRI4
ASGNI4
line 202
;202:	uiInfo.uiDC.Assets.fxPic[0] = trap_R_RegisterShaderNoMip(ART_FX_RED);
ADDRGP4 $173
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342612
ADDRLP4 12
INDIRI4
ASGNI4
line 203
;203:	uiInfo.uiDC.Assets.fxPic[1] = trap_R_RegisterShaderNoMip(ART_FX_YELLOW);
ADDRGP4 $177
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342612+4
ADDRLP4 16
INDIRI4
ASGNI4
line 204
;204:	uiInfo.uiDC.Assets.fxPic[2] = trap_R_RegisterShaderNoMip(ART_FX_GREEN);
ADDRGP4 $181
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342612+8
ADDRLP4 20
INDIRI4
ASGNI4
line 205
;205:	uiInfo.uiDC.Assets.fxPic[3] = trap_R_RegisterShaderNoMip(ART_FX_TEAL);
ADDRGP4 $185
ARGP4
ADDRLP4 24
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342612+12
ADDRLP4 24
INDIRI4
ASGNI4
line 206
;206:	uiInfo.uiDC.Assets.fxPic[4] = trap_R_RegisterShaderNoMip(ART_FX_BLUE);
ADDRGP4 $189
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342612+16
ADDRLP4 28
INDIRI4
ASGNI4
line 207
;207:	uiInfo.uiDC.Assets.fxPic[5] = trap_R_RegisterShaderNoMip(ART_FX_CYAN);
ADDRGP4 $193
ARGP4
ADDRLP4 32
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342612+20
ADDRLP4 32
INDIRI4
ASGNI4
line 208
;208:	uiInfo.uiDC.Assets.fxPic[6] = trap_R_RegisterShaderNoMip(ART_FX_WHITE);
ADDRGP4 $197
ARGP4
ADDRLP4 36
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342612+24
ADDRLP4 36
INDIRI4
ASGNI4
line 209
;209:	uiInfo.uiDC.Assets.scrollBar = trap_R_RegisterShaderNoMip(ASSET_SCROLLBAR);
ADDRGP4 $200
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342520
ADDRLP4 40
INDIRI4
ASGNI4
line 210
;210:	uiInfo.uiDC.Assets.scrollBarArrowDown = trap_R_RegisterShaderNoMip(ASSET_SCROLLBAR_ARROWDOWN);
ADDRGP4 $203
ARGP4
ADDRLP4 44
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342508
ADDRLP4 44
INDIRI4
ASGNI4
line 211
;211:	uiInfo.uiDC.Assets.scrollBarArrowUp = trap_R_RegisterShaderNoMip(ASSET_SCROLLBAR_ARROWUP);
ADDRGP4 $206
ARGP4
ADDRLP4 48
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342504
ADDRLP4 48
INDIRI4
ASGNI4
line 212
;212:	uiInfo.uiDC.Assets.scrollBarArrowLeft = trap_R_RegisterShaderNoMip(ASSET_SCROLLBAR_ARROWLEFT);
ADDRGP4 $209
ARGP4
ADDRLP4 52
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342512
ADDRLP4 52
INDIRI4
ASGNI4
line 213
;213:	uiInfo.uiDC.Assets.scrollBarArrowRight = trap_R_RegisterShaderNoMip(ASSET_SCROLLBAR_ARROWRIGHT);
ADDRGP4 $212
ARGP4
ADDRLP4 56
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342516
ADDRLP4 56
INDIRI4
ASGNI4
line 214
;214:	uiInfo.uiDC.Assets.scrollBarThumb = trap_R_RegisterShaderNoMip(ASSET_SCROLL_THUMB);
ADDRGP4 $215
ARGP4
ADDRLP4 60
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342524
ADDRLP4 60
INDIRI4
ASGNI4
line 215
;215:	uiInfo.uiDC.Assets.sliderBar = trap_R_RegisterShaderNoMip(ASSET_SLIDER_BAR);
ADDRGP4 $218
ARGP4
ADDRLP4 64
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342540
ADDRLP4 64
INDIRI4
ASGNI4
line 216
;216:	uiInfo.uiDC.Assets.sliderThumb = trap_R_RegisterShaderNoMip(ASSET_SLIDER_THUMB);
ADDRGP4 $221
ARGP4
ADDRLP4 68
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342544
ADDRLP4 68
INDIRI4
ASGNI4
line 218
;217:
;218:	for (n = 0; n < NUM_CROSSHAIRS; n++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $222
line 219
;219:		uiInfo.uiDC.Assets.crosshairShader[n] = trap_R_RegisterShaderNoMip(va("gfx/2d/crosshair%c", 'a' + n));
ADDRGP4 $228
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
ADDRGP4 uiInfo+236+5342640
ADDP4
ADDRLP4 80
INDIRI4
ASGNI4
line 220
;220:	}
LABELV $223
line 218
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 30
LTI4 $222
line 222
;221:
;222:	uiInfo.newHighScoreSound = trap_S_RegisterSound("sound/feedback/voc_newhighscore.wav", qfalse);
ADDRGP4 $230
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 72
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 uiInfo+5407584
ADDRLP4 72
INDIRI4
ASGNI4
line 223
;223:}
LABELV $164
endproc AssetCache 84 8
export _UI_DrawSides
proc _UI_DrawSides 4 36
line 225
;224:
;225:void _UI_DrawSides(float x, float y, float w, float h, float size, int widescreen) { //, rectDef_t menuRect) {
line 226
;226:	UI_AdjustFrom640(&x, &y, &w, &h);
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
line 227
;227:	size *= uiInfo.uiDC.xscale;
ADDRFP4 16
ADDRFP4 16
INDIRF4
ADDRGP4 uiInfo+204
INDIRF4
MULF4
ASGNF4
line 228
;228:	trap_R_DrawStretchPic(x, y, size, h, 0, 0, 0, 0, uiInfo.uiDC.whiteShader);
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
ADDRGP4 uiInfo+5354328
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 229
;229:	trap_R_DrawStretchPic(x + w - size, y, size, h, 0, 0, 0, 0, uiInfo.uiDC.whiteShader);
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
ADDRGP4 uiInfo+5354328
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 230
;230:}
LABELV $231
endproc _UI_DrawSides 4 36
proc _UI_DrawTopBottom 4 36
line 232
;231:
;232:static void _UI_DrawTopBottom(float x, float y, float w, float h, float size, int widescreen) { //, rectDef_t menuRect) {
line 233
;233:	UI_AdjustFrom640(&x, &y, &w, &h);
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
line 234
;234:	size *= uiInfo.uiDC.yscale;
ADDRFP4 16
ADDRFP4 16
INDIRF4
ADDRGP4 uiInfo+200
INDIRF4
MULF4
ASGNF4
line 235
;235:	trap_R_DrawStretchPic(x, y, w, size, 0, 0, 0, 0, uiInfo.uiDC.whiteShader);
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
ADDRGP4 uiInfo+5354328
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 236
;236:	trap_R_DrawStretchPic(x, y + h - size, w, size, 0, 0, 0, 0, uiInfo.uiDC.whiteShader);
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
ADDRGP4 uiInfo+5354328
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 237
;237:}
LABELV $235
endproc _UI_DrawTopBottom 4 36
export _UI_DrawRect
proc _UI_DrawRect 0 24
line 245
;238:/*
;239:================
;240:UI_DrawRect
;241:
;242:Coordinates are SCREEN_WIDTH*SCREEN_HEIGHT virtual values
;243:=================
;244:*/
;245:void _UI_DrawRect(float x, float y, float w, float h, float size, const vec4_t color, int widescreen) { //, rectDef_t menuRect) {
line 246
;246:	trap_R_SetColor(color);
ADDRFP4 20
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 248
;247:
;248:	_UI_DrawTopBottom(x, y, w, h, size, widescreen); //, menuRect);
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
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 _UI_DrawTopBottom
CALLV
pop
line 249
;249:	_UI_DrawSides(x, y, w, h, size, widescreen); //, menuRect);
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
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 _UI_DrawSides
CALLV
pop
line 251
;250:
;251:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 252
;252:}
LABELV $239
endproc _UI_DrawRect 0 24
proc Text_Width 40 4
line 254
;253:
;254:static float Text_Width(const char *text, float scale, int limit, int fontIndex, int widescreen) { //, rectDef_t menuRect) {
line 259
;255:	int count, len;
;256:	float out;
;257:	glyphInfo_t *glyph;
;258:	float useScale;
;259:	const char *s = text;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 260
;260:	fontInfo_t *font = &uiInfo.uiDC.Assets.textFont;
ADDRLP4 12
ADDRGP4 uiInfo+236+12
ASGNP4
line 261
;261:	if (scale <= ui_smallFont.value) {
ADDRFP4 4
INDIRF4
ADDRGP4 ui_smallFont+8
INDIRF4
GTF4 $243
line 262
;262:		font = &uiInfo.uiDC.Assets.smallFont;
ADDRLP4 12
ADDRGP4 uiInfo+236+20560
ASGNP4
line 263
;263:	} else if (scale >= ui_bigFont.value) {
ADDRGP4 $244
JUMPV
LABELV $243
ADDRFP4 4
INDIRF4
ADDRGP4 ui_bigFont+8
INDIRF4
LTF4 $248
line 264
;264:		font = &uiInfo.uiDC.Assets.bigFont;
ADDRLP4 12
ADDRGP4 uiInfo+236+41108
ASGNP4
line 265
;265:	}
LABELV $248
LABELV $244
line 266
;266:	useScale = scale * font->glyphScale;
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
line 267
;267:	out = 0;
ADDRLP4 20
CNSTF4 0
ASGNF4
line 268
;268:	if (text) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $253
line 269
;269:		len = strlen(text);
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
line 270
;270:		if (limit > 0 && len > limit) {
ADDRLP4 32
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
LEI4 $255
ADDRLP4 8
INDIRI4
ADDRLP4 32
INDIRI4
LEI4 $255
line 271
;271:			len = limit;
ADDRLP4 8
ADDRFP4 8
INDIRI4
ASGNI4
line 272
;272:		}
LABELV $255
line 273
;273:		count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $258
JUMPV
LABELV $257
line 274
;274:		while (s && *s && count < len) {
line 275
;275:			if (Q_IsColorString(s)) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $260
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $260
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $260
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $260
line 276
;276:				s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 277
;277:				continue;
ADDRGP4 $258
JUMPV
LABELV $260
line 278
;278:			} else {
line 279
;279:				glyph = &font->glyphs[*s & 255];
ADDRLP4 16
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 255
BANDI4
CNSTI4 80
MULI4
ADDRLP4 12
INDIRP4
ADDP4
ASGNP4
line 280
;280:				out += glyph->xSkip;
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
line 281
;281:				s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 282
;282:				count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 283
;283:			}
line 284
;284:		}
LABELV $258
line 274
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $263
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $263
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $257
LABELV $263
line 285
;285:	}
LABELV $253
line 286
;286:	return out * useScale;
ADDRLP4 20
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
RETF4
LABELV $240
endproc Text_Width 40 4
proc Text_Height 40 4
line 289
;287:}
;288:
;289:static float Text_Height(const char *text, float scale, int limit, int fontIndex, int widescreen) { //, rectDef_t menuRect) {
line 294
;290:	int len, count;
;291:	float max;
;292:	glyphInfo_t *glyph;
;293:	float useScale;
;294:	const char *s = text;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 295
;295:	fontInfo_t *font = &uiInfo.uiDC.Assets.textFont;
ADDRLP4 20
ADDRGP4 uiInfo+236+12
ASGNP4
line 296
;296:	if (scale <= ui_smallFont.value) {
ADDRFP4 4
INDIRF4
ADDRGP4 ui_smallFont+8
INDIRF4
GTF4 $267
line 297
;297:		font = &uiInfo.uiDC.Assets.smallFont;
ADDRLP4 20
ADDRGP4 uiInfo+236+20560
ASGNP4
line 298
;298:	} else if (scale >= ui_bigFont.value) {
ADDRGP4 $268
JUMPV
LABELV $267
ADDRFP4 4
INDIRF4
ADDRGP4 ui_bigFont+8
INDIRF4
LTF4 $272
line 299
;299:		font = &uiInfo.uiDC.Assets.bigFont;
ADDRLP4 20
ADDRGP4 uiInfo+236+41108
ASGNP4
line 300
;300:	}
LABELV $272
LABELV $268
line 301
;301:	useScale = scale * font->glyphScale;
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
line 302
;302:	max = 0;
ADDRLP4 16
CNSTF4 0
ASGNF4
line 303
;303:	if (text) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $277
line 304
;304:		len = strlen(text);
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
line 305
;305:		if (limit > 0 && len > limit) {
ADDRLP4 32
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
LEI4 $279
ADDRLP4 8
INDIRI4
ADDRLP4 32
INDIRI4
LEI4 $279
line 306
;306:			len = limit;
ADDRLP4 8
ADDRFP4 8
INDIRI4
ASGNI4
line 307
;307:		}
LABELV $279
line 308
;308:		count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $282
JUMPV
LABELV $281
line 309
;309:		while (s && *s && count < len) {
line 310
;310:			if (Q_IsColorString(s)) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $284
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $284
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $284
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $284
line 311
;311:				s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 312
;312:				continue;
ADDRGP4 $282
JUMPV
LABELV $284
line 313
;313:			} else {
line 314
;314:				glyph = &font->glyphs[*s & 255];
ADDRLP4 12
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 255
BANDI4
CNSTI4 80
MULI4
ADDRLP4 20
INDIRP4
ADDP4
ASGNP4
line 315
;315:				if (max < glyph->height) {
ADDRLP4 16
INDIRF4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
GEF4 $286
line 316
;316:					max = glyph->height;
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
line 317
;317:				}
LABELV $286
line 318
;318:				s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 319
;319:				count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 320
;320:			}
line 321
;321:		}
LABELV $282
line 309
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $289
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $289
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $281
LABELV $289
line 322
;322:	}
LABELV $277
line 323
;323:	return max * useScale;
ADDRLP4 16
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
RETF4
LABELV $264
endproc Text_Height 40 4
export Text_PaintChar
proc Text_PaintChar 8 36
line 326
;324:}
;325:
;326:void Text_PaintChar(float x, float y, float width, float height, float scale, float s, float t, float s2, float t2, qhandle_t hShader) {
line 328
;327:	float w, h;
;328:	w = width * scale;
ADDRLP4 0
ADDRFP4 8
INDIRF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 329
;329:	h = height * scale;
ADDRLP4 4
ADDRFP4 12
INDIRF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 330
;330:	UI_AdjustFrom640(&x, &y, &w, &h);
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
line 331
;331:	trap_R_DrawStretchPic(x, y, w, h, s, t, s2, t2, hShader);
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
line 332
;332:}
LABELV $290
endproc Text_PaintChar 8 36
proc Text_Paint 76 40
line 334
;333:
;334:static void Text_Paint(float x, float y, float scale, const vec4_t color, const char *text, float adjust, int limit, int style, int fontIndex, int widescreen) { //, rectDef_t menuRect) {
line 339
;335:	int len, count;
;336:	vec4_t newColor;
;337:	glyphInfo_t *glyph;
;338:	float useScale;
;339:	fontInfo_t *font = &uiInfo.uiDC.Assets.textFont;
ADDRLP4 28
ADDRGP4 uiInfo+236+12
ASGNP4
line 340
;340:	if (scale <= ui_smallFont.value) {
ADDRFP4 8
INDIRF4
ADDRGP4 ui_smallFont+8
INDIRF4
GTF4 $294
line 341
;341:		font = &uiInfo.uiDC.Assets.smallFont;
ADDRLP4 28
ADDRGP4 uiInfo+236+20560
ASGNP4
line 342
;342:	} else if (scale >= ui_bigFont.value) {
ADDRGP4 $295
JUMPV
LABELV $294
ADDRFP4 8
INDIRF4
ADDRGP4 ui_bigFont+8
INDIRF4
LTF4 $299
line 343
;343:		font = &uiInfo.uiDC.Assets.bigFont;
ADDRLP4 28
ADDRGP4 uiInfo+236+41108
ASGNP4
line 344
;344:	}
LABELV $299
LABELV $295
line 345
;345:	useScale = scale * font->glyphScale;
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
line 346
;346:	if (text) {
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $304
line 347
;347:		const char *s = text; // bk001206 - unsigned
ADDRLP4 36
ADDRFP4 16
INDIRP4
ASGNP4
line 348
;348:		trap_R_SetColor(color);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 349
;349:		memcpy(&newColor[0], &color[0], sizeof(vec4_t));
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
line 350
;350:		len = strlen(text);
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
line 351
;351:		if (limit > 0 && len > limit) {
ADDRLP4 44
ADDRFP4 24
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
LEI4 $306
ADDRLP4 32
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $306
line 352
;352:			len = limit;
ADDRLP4 32
ADDRFP4 24
INDIRI4
ASGNI4
line 353
;353:		}
LABELV $306
line 354
;354:		count = 0;
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 $309
JUMPV
LABELV $308
line 355
;355:		while (s && *s && count < len) {
line 356
;356:			glyph = &font->glyphs[*s & 255];
ADDRLP4 0
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
CNSTI4 255
BANDI4
CNSTI4 80
MULI4
ADDRLP4 28
INDIRP4
ADDP4
ASGNP4
line 359
;357:			//int yadj = Assets.textFont.glyphs[text[i]].bottom + Assets.textFont.glyphs[text[i]].top;
;358:			//float yadj = scale * (Assets.textFont.glyphs[text[i]].imageHeight - Assets.textFont.glyphs[text[i]].height);
;359:			if (Q_IsColorString(s)) {
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $311
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $311
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $311
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $311
line 360
;360:				memcpy(newColor, g_color_table[ColorIndex(*(s + 1))], sizeof(newColor));
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
line 361
;361:				newColor[3] = color[3];
ADDRLP4 4+12
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 362
;362:				trap_R_SetColor(newColor);
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 363
;363:				s += 2;
ADDRLP4 36
ADDRLP4 36
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 364
;364:				continue;
ADDRGP4 $309
JUMPV
LABELV $311
line 365
;365:			} else {
line 366
;366:				float yadj = useScale * glyph->top;
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
line 367
;367:				if (style == ITEM_TEXTSTYLE_SHADOWED || style == ITEM_TEXTSTYLE_SHADOWEDMORE) {
ADDRLP4 56
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 3
EQI4 $316
ADDRLP4 56
INDIRI4
CNSTI4 6
NEI4 $314
LABELV $316
line 368
;368:					int ofs = style == ITEM_TEXTSTYLE_SHADOWED ? 1 : 2;
ADDRFP4 28
INDIRI4
CNSTI4 3
NEI4 $318
ADDRLP4 64
CNSTI4 1
ASGNI4
ADDRGP4 $319
JUMPV
LABELV $318
ADDRLP4 64
CNSTI4 2
ASGNI4
LABELV $319
ADDRLP4 60
ADDRLP4 64
INDIRI4
ASGNI4
line 369
;369:					colorBlack[3] = newColor[3];
ADDRGP4 colorBlack+12
ADDRLP4 4+12
INDIRF4
ASGNF4
line 370
;370:					trap_R_SetColor(colorBlack);
ADDRGP4 colorBlack
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 371
;371:					Text_PaintChar(x + ofs, y - yadj + ofs,
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
line 380
;372:						glyph->imageWidth,
;373:						glyph->imageHeight,
;374:						useScale,
;375:						glyph->s,
;376:						glyph->t,
;377:						glyph->s2,
;378:						glyph->t2,
;379:						glyph->glyph);
;380:					trap_R_SetColor(newColor);
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 381
;381:					colorBlack[3] = 1.0;
ADDRGP4 colorBlack+12
CNSTF4 1065353216
ASGNF4
line 382
;382:				}
LABELV $314
line 383
;383:				Text_PaintChar(x, y - yadj,
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
line 393
;384:					glyph->imageWidth,
;385:					glyph->imageHeight,
;386:					useScale,
;387:					glyph->s,
;388:					glyph->t,
;389:					glyph->s2,
;390:					glyph->t2,
;391:					glyph->glyph);
;392:
;393:				x += (glyph->xSkip * useScale) + adjust;
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
line 394
;394:				s++;
ADDRLP4 36
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 395
;395:				count++;
ADDRLP4 24
ADDRLP4 24
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 396
;396:			}
line 397
;397:		}
LABELV $309
line 355
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $324
ADDRLP4 36
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $324
ADDRLP4 24
INDIRI4
ADDRLP4 32
INDIRI4
LTI4 $308
LABELV $324
line 398
;398:		trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 399
;399:	}
LABELV $304
line 400
;400:}
LABELV $291
endproc Text_Paint 76 40
proc Text_PaintWithCursor 80 40
ADDRFP4 24
ADDRFP4 24
INDIRI4
CVII1 4
ASGNI1
line 402
;401:
;402:static void Text_PaintWithCursor(float x, float y, float scale, const vec4_t color, const char *text, int cursorPos, char cursor, int limit, int style, int fontIndex, int widescreen) { //, rectDef_t menuRect) {
line 408
;403:	int len, count;
;404:	vec4_t newColor;
;405:	glyphInfo_t *glyph, *glyph2;
;406:	float yadj;
;407:	float useScale;
;408:	fontInfo_t *font = &uiInfo.uiDC.Assets.textFont;
ADDRLP4 36
ADDRGP4 uiInfo+236+12
ASGNP4
line 409
;409:	if (scale <= ui_smallFont.value) {
ADDRFP4 8
INDIRF4
ADDRGP4 ui_smallFont+8
INDIRF4
GTF4 $328
line 410
;410:		font = &uiInfo.uiDC.Assets.smallFont;
ADDRLP4 36
ADDRGP4 uiInfo+236+20560
ASGNP4
line 411
;411:	} else if (scale >= ui_bigFont.value) {
ADDRGP4 $329
JUMPV
LABELV $328
ADDRFP4 8
INDIRF4
ADDRGP4 ui_bigFont+8
INDIRF4
LTF4 $333
line 412
;412:		font = &uiInfo.uiDC.Assets.bigFont;
ADDRLP4 36
ADDRGP4 uiInfo+236+41108
ASGNP4
line 413
;413:	}
LABELV $333
LABELV $329
line 414
;414:	useScale = scale * font->glyphScale;
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
line 415
;415:	if (text) {
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $338
line 416
;416:		const char *s = text;
ADDRLP4 44
ADDRFP4 16
INDIRP4
ASGNP4
line 417
;417:		trap_R_SetColor(color);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 418
;418:		memcpy(&newColor[0], &color[0], sizeof(vec4_t));
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
line 419
;419:		len = strlen(text);
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
line 420
;420:		if (limit > 0 && len > limit) {
ADDRLP4 52
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
LEI4 $340
ADDRLP4 40
INDIRI4
ADDRLP4 52
INDIRI4
LEI4 $340
line 421
;421:			len = limit;
ADDRLP4 40
ADDRFP4 28
INDIRI4
ASGNI4
line 422
;422:		}
LABELV $340
line 423
;423:		count = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 424
;424:		glyph2 = &font->glyphs[cursor & 255];
ADDRLP4 8
ADDRFP4 24
INDIRI1
CVII4 1
CNSTI4 255
BANDI4
CNSTI4 80
MULI4
ADDRLP4 36
INDIRP4
ADDP4
ASGNP4
ADDRGP4 $343
JUMPV
LABELV $342
line 425
;425:		while (s && *s && count < len) {
line 426
;426:			glyph = &font->glyphs[*s & 255];
ADDRLP4 0
ADDRLP4 44
INDIRP4
INDIRI1
CVII4 1
CNSTI4 255
BANDI4
CNSTI4 80
MULI4
ADDRLP4 36
INDIRP4
ADDP4
ASGNP4
line 429
;427:			//int yadj = Assets.textFont.glyphs[text[i]].bottom + Assets.textFont.glyphs[text[i]].top;
;428:			//float yadj = scale * (Assets.textFont.glyphs[text[i]].imageHeight - Assets.textFont.glyphs[text[i]].height);
;429:			if (Q_IsColorString(s)) {
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $345
ADDRLP4 44
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $345
ADDRLP4 44
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $345
ADDRLP4 44
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $345
line 430
;430:				memcpy(newColor, g_color_table[ColorIndex(*(s + 1))], sizeof(newColor));
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
line 431
;431:				newColor[3] = color[3];
ADDRLP4 12+12
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 432
;432:				trap_R_SetColor(newColor);
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 433
;433:				s += 2;
ADDRLP4 44
ADDRLP4 44
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 434
;434:				continue;
ADDRGP4 $343
JUMPV
LABELV $345
line 435
;435:			} else {
line 436
;436:				yadj = useScale * glyph->top;
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
line 437
;437:				if (style == ITEM_TEXTSTYLE_SHADOWED || style == ITEM_TEXTSTYLE_SHADOWEDMORE) {
ADDRLP4 60
ADDRFP4 32
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 3
EQI4 $350
ADDRLP4 60
INDIRI4
CNSTI4 6
NEI4 $348
LABELV $350
line 438
;438:					int ofs = style == ITEM_TEXTSTYLE_SHADOWED ? 1 : 2;
ADDRFP4 32
INDIRI4
CNSTI4 3
NEI4 $352
ADDRLP4 68
CNSTI4 1
ASGNI4
ADDRGP4 $353
JUMPV
LABELV $352
ADDRLP4 68
CNSTI4 2
ASGNI4
LABELV $353
ADDRLP4 64
ADDRLP4 68
INDIRI4
ASGNI4
line 439
;439:					colorBlack[3] = newColor[3];
ADDRGP4 colorBlack+12
ADDRLP4 12+12
INDIRF4
ASGNF4
line 440
;440:					trap_R_SetColor(colorBlack);
ADDRGP4 colorBlack
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 441
;441:					Text_PaintChar(x + ofs, y - yadj + ofs,
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
line 450
;442:						glyph->imageWidth,
;443:						glyph->imageHeight,
;444:						useScale,
;445:						glyph->s,
;446:						glyph->t,
;447:						glyph->s2,
;448:						glyph->t2,
;449:						glyph->glyph);
;450:					colorBlack[3] = 1.0;
ADDRGP4 colorBlack+12
CNSTF4 1065353216
ASGNF4
line 451
;451:					trap_R_SetColor(newColor);
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 452
;452:				}
LABELV $348
line 453
;453:				Text_PaintChar(x, y - yadj,
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
line 463
;454:					glyph->imageWidth,
;455:					glyph->imageHeight,
;456:					useScale,
;457:					glyph->s,
;458:					glyph->t,
;459:					glyph->s2,
;460:					glyph->t2,
;461:					glyph->glyph);
;462:
;463:				yadj = useScale * glyph2->top;
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
line 464
;464:				if (count == cursorPos && !((uiInfo.uiDC.realTime / BLINK_DIVISOR) & 1)) {
ADDRLP4 28
INDIRI4
ADDRFP4 20
INDIRI4
NEI4 $357
ADDRGP4 uiInfo+212
INDIRI4
CNSTI4 200
DIVI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $357
line 465
;465:					Text_PaintChar(x, y - yadj,
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
line 474
;466:						glyph2->imageWidth,
;467:						glyph2->imageHeight,
;468:						useScale,
;469:						glyph2->s,
;470:						glyph2->t,
;471:						glyph2->s2,
;472:						glyph2->t2,
;473:						glyph2->glyph);
;474:				}
LABELV $357
line 476
;475:
;476:				x += (glyph->xSkip * useScale);
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
line 477
;477:				s++;
ADDRLP4 44
ADDRLP4 44
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 478
;478:				count++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 479
;479:			}
line 480
;480:		}
LABELV $343
line 425
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $361
ADDRLP4 44
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $361
ADDRLP4 28
INDIRI4
ADDRLP4 40
INDIRI4
LTI4 $342
LABELV $361
line 482
;481:		// need to paint cursor at end of text
;482:		if (cursorPos == len && !((uiInfo.uiDC.realTime / BLINK_DIVISOR) & 1)) {
ADDRFP4 20
INDIRI4
ADDRLP4 40
INDIRI4
NEI4 $362
ADDRGP4 uiInfo+212
INDIRI4
CNSTI4 200
DIVI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $362
line 483
;483:			yadj = useScale * glyph2->top;
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
line 484
;484:			Text_PaintChar(x, y - yadj,
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
line 494
;485:				glyph2->imageWidth,
;486:				glyph2->imageHeight,
;487:				useScale,
;488:				glyph2->s,
;489:				glyph2->t,
;490:				glyph2->s2,
;491:				glyph2->t2,
;492:				glyph2->glyph);
;493:
;494:		}
LABELV $362
line 496
;495:
;496:		trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 497
;497:	}
LABELV $338
line 498
;498:}
LABELV $325
endproc Text_PaintWithCursor 80 40
proc Text_Paint_Limit 68 40
line 501
;499:
;500:
;501:static void Text_Paint_Limit(float *maxX, float x, float y, float scale, const vec4_t color, const char *text, float adjust, int limit) {
line 505
;502:	int len, count;
;503:	vec4_t newColor;
;504:	glyphInfo_t *glyph;
;505:	if (text) {
ADDRFP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $366
line 506
;506:		const char *s = text;
ADDRLP4 28
ADDRFP4 20
INDIRP4
ASGNP4
line 507
;507:		float max = *maxX;
ADDRLP4 40
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 509
;508:		float useScale;
;509:		fontInfo_t *font = &uiInfo.uiDC.Assets.textFont;
ADDRLP4 36
ADDRGP4 uiInfo+236+12
ASGNP4
line 510
;510:		if (scale <= ui_smallFont.value) {
ADDRFP4 12
INDIRF4
ADDRGP4 ui_smallFont+8
INDIRF4
GTF4 $370
line 511
;511:			font = &uiInfo.uiDC.Assets.smallFont;
ADDRLP4 36
ADDRGP4 uiInfo+236+20560
ASGNP4
line 512
;512:		} else if (scale > ui_bigFont.value) {
ADDRGP4 $371
JUMPV
LABELV $370
ADDRFP4 12
INDIRF4
ADDRGP4 ui_bigFont+8
INDIRF4
LEF4 $375
line 513
;513:			font = &uiInfo.uiDC.Assets.bigFont;
ADDRLP4 36
ADDRGP4 uiInfo+236+41108
ASGNP4
line 514
;514:		}
LABELV $375
LABELV $371
line 515
;515:		useScale = scale * font->glyphScale;
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
line 516
;516:		trap_R_SetColor(color);
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 517
;517:		len = strlen(text);
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
line 518
;518:		if (limit > 0 && len > limit) {
ADDRLP4 48
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
LEI4 $380
ADDRLP4 24
INDIRI4
ADDRLP4 48
INDIRI4
LEI4 $380
line 519
;519:			len = limit;
ADDRLP4 24
ADDRFP4 28
INDIRI4
ASGNI4
line 520
;520:		}
LABELV $380
line 521
;521:		count = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 $383
JUMPV
LABELV $382
line 522
;522:		while (s && *s && count < len) {
line 523
;523:			glyph = &font->glyphs[*s & 255];
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRI1
CVII4 1
CNSTI4 255
BANDI4
CNSTI4 80
MULI4
ADDRLP4 36
INDIRP4
ADDP4
ASGNP4
line 524
;524:			if (Q_IsColorString(s)) {
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $385
ADDRLP4 28
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $385
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $385
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $385
line 525
;525:				memcpy(newColor, g_color_table[ColorIndex(*(s + 1))], sizeof(newColor));
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
line 526
;526:				newColor[3] = color[3];
ADDRLP4 4+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 527
;527:				trap_R_SetColor(newColor);
ADDRLP4 4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 528
;528:				s += 2;
ADDRLP4 28
ADDRLP4 28
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 529
;529:				continue;
ADDRGP4 $383
JUMPV
LABELV $385
line 530
;530:			} else {
line 531
;531:				float yadj = useScale * glyph->top;
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
line 532
;532:				if (Text_Width(s, scale, 1, 1, WIDESCREEN_STRETCH) + x > max) {
ADDRLP4 28
INDIRP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
CNSTI4 1
ARGI4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 60
ADDRGP4 Text_Width
CALLF4
ASGNF4
ADDRLP4 60
INDIRF4
ADDRFP4 4
INDIRF4
ADDF4
ADDRLP4 40
INDIRF4
LEF4 $388
line 533
;533:					*maxX = 0;
ADDRFP4 0
INDIRP4
CNSTF4 0
ASGNF4
line 534
;534:					break;
ADDRGP4 $384
JUMPV
LABELV $388
line 536
;535:				}
;536:				Text_PaintChar(x, y - yadj,
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
line 545
;537:					glyph->imageWidth,
;538:					glyph->imageHeight,
;539:					useScale,
;540:					glyph->s,
;541:					glyph->t,
;542:					glyph->s2,
;543:					glyph->t2,
;544:					glyph->glyph);
;545:				x += (glyph->xSkip * useScale) + adjust;
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
line 546
;546:				*maxX = x;
ADDRFP4 0
INDIRP4
ADDRFP4 4
INDIRF4
ASGNF4
line 547
;547:				count++;
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 548
;548:				s++;
ADDRLP4 28
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 549
;549:			}
line 550
;550:		}
LABELV $383
line 522
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $391
ADDRLP4 28
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $391
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
LTI4 $382
LABELV $391
LABELV $384
line 551
;551:		trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 552
;552:	}
LABELV $366
line 554
;553:
;554:}
LABELV $365
endproc Text_Paint_Limit 68 40
export UI_ShowPostGame
proc UI_ShowPostGame 0 8
line 557
;555:
;556:
;557:void UI_ShowPostGame(qboolean newHigh) {
line 558
;558:	trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $393
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 559
;559:	trap_Cvar_Set("sv_killserver", "1");
ADDRGP4 $395
ARGP4
ADDRGP4 $396
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 560
;560:	uiInfo.soundHighScore = newHigh;
ADDRGP4 uiInfo+5354368
ADDRFP4 0
INDIRI4
ASGNI4
line 561
;561:	_UI_SetActiveMenu(UIMENU_POSTGAME);
CNSTI4 6
ARGI4
ADDRGP4 _UI_SetActiveMenu
CALLV
pop
line 562
;562:}
LABELV $392
endproc UI_ShowPostGame 0 8
export UI_DrawCenteredPic
proc UI_DrawCenteredPic 8 24
line 569
;563:/*
;564:=================
;565:_UI_Refresh
;566:=================
;567:*/
;568:
;569:void UI_DrawCenteredPic(qhandle_t image, int w, int h) {
line 571
;570:	int x, y;
;571:	x = (SCREEN_WIDTH - w) / 2;
ADDRLP4 0
CNSTI4 640
ADDRFP4 4
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 572
;572:	y = (SCREEN_HEIGHT - h) / 2;
ADDRLP4 4
CNSTI4 480
ADDRFP4 8
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 573
;573:	UI_DrawHandlePic(x, y, w, h, image, WIDESCREEN_STRETCH);
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
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 574
;574:}
LABELV $398
endproc UI_DrawCenteredPic 8 24
data
export frameCount
align 4
LABELV frameCount
byte 4 0
bss
align 4
LABELV $400
skip 4
align 4
LABELV $401
skip 16
export _UI_Refresh
code
proc _UI_Refresh 20 24
line 580
;575:
;576:int frameCount = 0;
;577:int startTime;
;578:
;579:#define	UI_FPS_FRAMES	4
;580:void _UI_Refresh(int realtime) {
line 588
;581:	static int index;
;582:	static int	previousTimes[UI_FPS_FRAMES];
;583:
;584:	//if ( !( trap_Key_GetCatcher() & KEYCATCH_UI ) ) {
;585:	//	return;
;586:	//}
;587:
;588:	uiInfo.uiDC.frameTime = realtime - uiInfo.uiDC.realTime;
ADDRGP4 uiInfo+220
ADDRFP4 0
INDIRI4
ADDRGP4 uiInfo+212
INDIRI4
SUBI4
ASGNI4
line 589
;589:	uiInfo.uiDC.realTime = realtime;
ADDRGP4 uiInfo+212
ADDRFP4 0
INDIRI4
ASGNI4
line 591
;590:
;591:	previousTimes[index % UI_FPS_FRAMES] = uiInfo.uiDC.frameTime;
ADDRGP4 $400
INDIRI4
CNSTI4 4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 $401
ADDP4
ADDRGP4 uiInfo+220
INDIRI4
ASGNI4
line 592
;592:	index++;
ADDRLP4 0
ADDRGP4 $400
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 593
;593:	if (index > UI_FPS_FRAMES) {
ADDRGP4 $400
INDIRI4
CNSTI4 4
LEI4 $406
line 596
;594:		int i, total;
;595:		// average multiple frames together to smooth changes out a bit
;596:		total = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 597
;597:		for (i = 0; i < UI_FPS_FRAMES; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $408
line 598
;598:			total += previousTimes[i];
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $401
ADDP4
INDIRI4
ADDI4
ASGNI4
line 599
;599:		}
LABELV $409
line 597
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
LTI4 $408
line 600
;600:		if (!total) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $412
line 601
;601:			total = 1;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 602
;602:		}
LABELV $412
line 603
;603:		uiInfo.uiDC.FPS = 1000 * UI_FPS_FRAMES / total;
ADDRGP4 uiInfo+5354340
CNSTI4 4000
ADDRLP4 8
INDIRI4
DIVI4
CVIF4 4
ASGNF4
line 604
;604:	}
LABELV $406
line 608
;605:
;606:
;607:
;608:	UI_UpdateCvars();
ADDRGP4 UI_UpdateCvars
CALLV
pop
line 612
;609:
;610:	//trap_R_BeginHud();//WOLFCAM
;611:
;612:	if (Menu_Count() > 0) {
ADDRLP4 4
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LEI4 $415
line 614
;613:		// paint all the menus
;614:		Menu_PaintAll();
ADDRGP4 Menu_PaintAll
CALLV
pop
line 616
;615:		// refresh server browser list
;616:		UI_DoServerRefresh();
ADDRGP4 UI_DoServerRefresh
CALLV
pop
line 618
;617:		// refresh server status
;618:		UI_BuildServerStatus(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_BuildServerStatus
CALLV
pop
line 620
;619:		// refresh find player list
;620:		UI_BuildFindPlayerList(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_BuildFindPlayerList
CALLV
pop
line 621
;621:	}
LABELV $415
line 624
;622:
;623:	// draw cursor
;624:	UI_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 UI_SetColor
CALLV
pop
line 625
;625:	if (uiInfo.uiDC.glconfig.isFullscreen || (int)trap_Cvar_VariableValue("in_nograb") == 0) {
ADDRGP4 uiInfo+5342996+11320
INDIRI4
CNSTI4 0
NEI4 $422
ADDRGP4 $421
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 8
INDIRF4
CVFI4 4
CNSTI4 0
NEI4 $417
LABELV $422
line 626
;626:		if (Menu_Count() > 0 && (trap_Key_GetCatcher() & KEYCATCH_UI)) {
ADDRLP4 12
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
LEI4 $423
ADDRLP4 16
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $423
line 627
;627:			UI_DrawHandlePic(uiInfo.uiDC.cursorx - 16, uiInfo.uiDC.cursory - 16, 32, 32, uiInfo.uiDC.Assets.cursor, WIDESCREEN_STRETCH);
ADDRGP4 uiInfo+224
INDIRI4
CNSTI4 16
SUBI4
CVIF4 4
ARGF4
ADDRGP4 uiInfo+228
INDIRI4
CNSTI4 16
SUBI4
CVIF4 4
ARGF4
CNSTF4 1107296256
ARGF4
CNSTF4 1107296256
ARGF4
ADDRGP4 uiInfo+236+5342496
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 628
;628:		}
LABELV $423
line 629
;629:	}
LABELV $417
line 632
;630:
;631:#ifndef NDEBUG
;632:	if (uiInfo.uiDC.debug) {
ADDRGP4 uiInfo+232
INDIRI4
CNSTI4 0
EQI4 $429
line 636
;633:		// cursor coordinates
;634:		//FIXME
;635:		//UI_DrawString( 0, 0, va("(%d,%d)",uis.cursorx,uis.cursory), UI_LEFT|UI_SMALLFONT, colorRed );
;636:	}
LABELV $429
line 639
;637:#endif
;638:
;639:}
LABELV $399
endproc _UI_Refresh 20 24
export _UI_Shutdown
proc _UI_Shutdown 0 0
line 646
;640:
;641:/*
;642:=================
;643:_UI_Shutdown
;644:=================
;645:*/
;646:void _UI_Shutdown(void) {
line 647
;647:	trap_LAN_SaveCachedServers();
ADDRGP4 trap_LAN_SaveCachedServers
CALLV
pop
line 648
;648:}
LABELV $432
endproc _UI_Shutdown 0 0
data
export defaultMenu
align 4
LABELV defaultMenu
byte 4 0
bss
align 1
LABELV $434
skip 32768
export GetMenuBuffer
code
proc GetMenuBuffer 16 16
line 652
;649:
;650:char *defaultMenu = NULL;
;651:
;652:char *GetMenuBuffer(const char *filename) {
line 657
;653:	int	len;
;654:	fileHandle_t	f;
;655:	static char buf[MAX_MENUFILE];
;656:
;657:	len = trap_FS_FOpenFile(filename, &f, FS_READ);
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
line 658
;658:	if (!f) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $435
line 659
;659:		trap_Print(va(S_COLOR_RED "menu file not found: %s, using default\n", filename));
ADDRGP4 $437
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
line 660
;660:		return defaultMenu;
ADDRGP4 defaultMenu
INDIRP4
RETP4
ADDRGP4 $433
JUMPV
LABELV $435
line 662
;661:	}
;662:	if (len >= MAX_MENUFILE) {
ADDRLP4 0
INDIRI4
CNSTI4 32768
LTI4 $438
line 663
;663:		trap_Print(va(S_COLOR_RED "menu file too large: %s is %i, max allowed is %i\n", filename, len, MAX_MENUFILE));
ADDRGP4 $440
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
line 664
;664:		trap_FS_FCloseFile(f);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 665
;665:		return defaultMenu;
ADDRGP4 defaultMenu
INDIRP4
RETP4
ADDRGP4 $433
JUMPV
LABELV $438
line 668
;666:	}
;667:
;668:	trap_FS_Read(buf, len, f);
ADDRGP4 $434
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
line 669
;669:	buf[len] = 0;
ADDRLP4 0
INDIRI4
ADDRGP4 $434
ADDP4
CNSTI1 0
ASGNI1
line 670
;670:	trap_FS_FCloseFile(f);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 672
;671:	//COM_Compress(buf);
;672:	return buf;
ADDRGP4 $434
RETP4
LABELV $433
endproc GetMenuBuffer 16 16
export Asset_Parse
proc Asset_Parse 1124 12
line 676
;673:
;674:}
;675:
;676:qboolean Asset_Parse(int handle) {
line 680
;677:	pc_token_t token;
;678:	const char *tempStr;
;679:
;680:	if (!trap_PC_ReadToken(handle, &token))
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
NEI4 $442
line 681
;681:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $441
JUMPV
LABELV $442
line 682
;682:	if (Q_stricmp(token.string, "{") != 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $447
ARGP4
ADDRLP4 1048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
EQI4 $449
line 683
;683:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $441
JUMPV
LABELV $448
line 686
;684:	}
;685:
;686:	while (1) {
line 688
;687:
;688:		memset(&token, 0, sizeof(pc_token_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1040
ARGI4
ADDRGP4 memset
CALLP4
pop
line 690
;689:
;690:		if (!trap_PC_ReadToken(handle, &token))
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
NEI4 $451
line 691
;691:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $441
JUMPV
LABELV $451
line 693
;692:
;693:		if (Q_stricmp(token.string, "}") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $456
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $453
line 694
;694:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $441
JUMPV
LABELV $453
line 698
;695:		}
;696:
;697:		// font
;698:		if (Q_stricmp(token.string, "font") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $460
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $457
line 700
;699:			int pointSize;
;700:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
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
EQI4 $463
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
NEI4 $461
LABELV $463
line 701
;701:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $441
JUMPV
LABELV $461
line 703
;702:			}
;703:			trap_R_RegisterFont(tempStr, pointSize, &uiInfo.uiDC.Assets.textFont);
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1064
INDIRI4
ARGI4
ADDRGP4 uiInfo+236+12
ARGP4
ADDRGP4 trap_R_RegisterFont
CALLV
pop
line 704
;704:			uiInfo.uiDC.Assets.fontRegistered = qtrue;
ADDRGP4 uiInfo+236+5342604
CNSTI4 1
ASGNI4
line 705
;705:			continue;
ADDRGP4 $449
JUMPV
LABELV $457
line 708
;706:		}
;707:
;708:		if (Q_stricmp(token.string, "smallFont") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $471
ARGP4
ADDRLP4 1064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $468
line 710
;709:			int pointSize;
;710:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
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
EQI4 $474
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
NEI4 $472
LABELV $474
line 711
;711:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $441
JUMPV
LABELV $472
line 713
;712:			}
;713:			trap_R_RegisterFont(tempStr, pointSize, &uiInfo.uiDC.Assets.smallFont);
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1068
INDIRI4
ARGI4
ADDRGP4 uiInfo+236+20560
ARGP4
ADDRGP4 trap_R_RegisterFont
CALLV
pop
line 714
;714:			continue;
ADDRGP4 $449
JUMPV
LABELV $468
line 717
;715:		}
;716:
;717:		if (Q_stricmp(token.string, "bigFont") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $480
ARGP4
ADDRLP4 1068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
NEI4 $477
line 719
;718:			int pointSize;
;719:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
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
EQI4 $483
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
NEI4 $481
LABELV $483
line 720
;720:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $441
JUMPV
LABELV $481
line 722
;721:			}
;722:			trap_R_RegisterFont(tempStr, pointSize, &uiInfo.uiDC.Assets.bigFont);
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1072
INDIRI4
ARGI4
ADDRGP4 uiInfo+236+41108
ARGP4
ADDRGP4 trap_R_RegisterFont
CALLV
pop
line 723
;723:			continue;
ADDRGP4 $449
JUMPV
LABELV $477
line 728
;724:		}
;725:
;726:
;727:		// gradientbar
;728:		if (Q_stricmp(token.string, "gradientbar") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $489
ARGP4
ADDRLP4 1072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $486
line 729
;729:			if (!PC_String_Parse(handle, &tempStr)) {
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
NEI4 $490
line 730
;730:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $441
JUMPV
LABELV $490
line 732
;731:			}
;732:			uiInfo.uiDC.Assets.gradientBar = trap_R_RegisterShaderNoMip(tempStr);
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1080
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342500
ADDRLP4 1080
INDIRI4
ASGNI4
line 733
;733:			continue;
ADDRGP4 $449
JUMPV
LABELV $486
line 737
;734:		}
;735:
;736:		// enterMenuSound
;737:		if (Q_stricmp(token.string, "menuEnterSound") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $497
ARGP4
ADDRLP4 1076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
NEI4 $494
line 738
;738:			if (!PC_String_Parse(handle, &tempStr)) {
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
NEI4 $498
line 739
;739:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $441
JUMPV
LABELV $498
line 741
;740:			}
;741:			uiInfo.uiDC.Assets.menuEnterSound = trap_S_RegisterSound(tempStr, qfalse);
ADDRLP4 1040
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1084
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342548
ADDRLP4 1084
INDIRI4
ASGNI4
line 742
;742:			continue;
ADDRGP4 $449
JUMPV
LABELV $494
line 746
;743:		}
;744:
;745:		// exitMenuSound
;746:		if (Q_stricmp(token.string, "menuExitSound") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $505
ARGP4
ADDRLP4 1080
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 0
NEI4 $502
line 747
;747:			if (!PC_String_Parse(handle, &tempStr)) {
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
NEI4 $506
line 748
;748:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $441
JUMPV
LABELV $506
line 750
;749:			}
;750:			uiInfo.uiDC.Assets.menuExitSound = trap_S_RegisterSound(tempStr, qfalse);
ADDRLP4 1040
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1088
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342552
ADDRLP4 1088
INDIRI4
ASGNI4
line 751
;751:			continue;
ADDRGP4 $449
JUMPV
LABELV $502
line 755
;752:		}
;753:
;754:		// itemFocusSound
;755:		if (Q_stricmp(token.string, "itemFocusSound") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $513
ARGP4
ADDRLP4 1084
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1084
INDIRI4
CNSTI4 0
NEI4 $510
line 756
;756:			if (!PC_String_Parse(handle, &tempStr)) {
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
NEI4 $514
line 757
;757:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $441
JUMPV
LABELV $514
line 759
;758:			}
;759:			uiInfo.uiDC.Assets.itemFocusSound = trap_S_RegisterSound(tempStr, qfalse);
ADDRLP4 1040
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1092
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342560
ADDRLP4 1092
INDIRI4
ASGNI4
line 760
;760:			continue;
ADDRGP4 $449
JUMPV
LABELV $510
line 764
;761:		}
;762:
;763:		// menuBuzzSound
;764:		if (Q_stricmp(token.string, "menuBuzzSound") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $521
ARGP4
ADDRLP4 1088
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1088
INDIRI4
CNSTI4 0
NEI4 $518
line 765
;765:			if (!PC_String_Parse(handle, &tempStr)) {
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
NEI4 $522
line 766
;766:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $441
JUMPV
LABELV $522
line 768
;767:			}
;768:			uiInfo.uiDC.Assets.menuBuzzSound = trap_S_RegisterSound(tempStr, qfalse);
ADDRLP4 1040
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1096
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342556
ADDRLP4 1096
INDIRI4
ASGNI4
line 769
;769:			continue;
ADDRGP4 $449
JUMPV
LABELV $518
line 772
;770:		}
;771:
;772:		if (Q_stricmp(token.string, "cursor") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $529
ARGP4
ADDRLP4 1092
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1092
INDIRI4
CNSTI4 0
NEI4 $526
line 773
;773:			if (!PC_String_Parse(handle, &uiInfo.uiDC.Assets.cursorStr)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+236+4
ARGP4
ADDRLP4 1096
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 1096
INDIRI4
CNSTI4 0
NEI4 $530
line 774
;774:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $441
JUMPV
LABELV $530
line 776
;775:			}
;776:			uiInfo.uiDC.Assets.cursor = trap_R_RegisterShaderNoMip(uiInfo.uiDC.Assets.cursorStr);
ADDRGP4 uiInfo+236+4
INDIRP4
ARGP4
ADDRLP4 1100
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+236+5342496
ADDRLP4 1100
INDIRI4
ASGNI4
line 777
;777:			continue;
ADDRGP4 $449
JUMPV
LABELV $526
line 780
;778:		}
;779:
;780:		if (Q_stricmp(token.string, "fadeClamp") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $541
ARGP4
ADDRLP4 1096
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1096
INDIRI4
CNSTI4 0
NEI4 $538
line 781
;781:			if (!PC_Float_Parse(handle, &uiInfo.uiDC.Assets.fadeClamp)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+236+5342564
ARGP4
ADDRLP4 1100
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 1100
INDIRI4
CNSTI4 0
NEI4 $449
line 782
;782:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $441
JUMPV
line 784
;783:			}
;784:			continue;
LABELV $538
line 787
;785:		}
;786:
;787:		if (Q_stricmp(token.string, "fadeCycle") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $549
ARGP4
ADDRLP4 1100
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1100
INDIRI4
CNSTI4 0
NEI4 $546
line 788
;788:			if (!PC_Int_Parse(handle, &uiInfo.uiDC.Assets.fadeCycle)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+236+5342568
ARGP4
ADDRLP4 1104
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 1104
INDIRI4
CNSTI4 0
NEI4 $449
line 789
;789:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $441
JUMPV
line 791
;790:			}
;791:			continue;
LABELV $546
line 794
;792:		}
;793:
;794:		if (Q_stricmp(token.string, "fadeAmount") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $557
ARGP4
ADDRLP4 1104
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1104
INDIRI4
CNSTI4 0
NEI4 $554
line 795
;795:			if (!PC_Float_Parse(handle, &uiInfo.uiDC.Assets.fadeAmount)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+236+5342572
ARGP4
ADDRLP4 1108
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 0
NEI4 $449
line 796
;796:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $441
JUMPV
line 798
;797:			}
;798:			continue;
LABELV $554
line 801
;799:		}
;800:
;801:		if (Q_stricmp(token.string, "shadowX") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $565
ARGP4
ADDRLP4 1108
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 0
NEI4 $562
line 802
;802:			if (!PC_Float_Parse(handle, &uiInfo.uiDC.Assets.shadowX)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+236+5342576
ARGP4
ADDRLP4 1112
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
NEI4 $449
line 803
;803:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $441
JUMPV
line 805
;804:			}
;805:			continue;
LABELV $562
line 808
;806:		}
;807:
;808:		if (Q_stricmp(token.string, "shadowY") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $573
ARGP4
ADDRLP4 1112
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
NEI4 $570
line 809
;809:			if (!PC_Float_Parse(handle, &uiInfo.uiDC.Assets.shadowY)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+236+5342580
ARGP4
ADDRLP4 1116
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
NEI4 $449
line 810
;810:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $441
JUMPV
line 812
;811:			}
;812:			continue;
LABELV $570
line 815
;813:		}
;814:
;815:		if (Q_stricmp(token.string, "shadowColor") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $581
ARGP4
ADDRLP4 1116
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
NEI4 $578
line 816
;816:			if (!PC_Color_Parse(handle, &uiInfo.uiDC.Assets.shadowColor)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+236+5342584
ARGP4
ADDRLP4 1120
ADDRGP4 PC_Color_Parse
CALLI4
ASGNI4
ADDRLP4 1120
INDIRI4
CNSTI4 0
NEI4 $582
line 817
;817:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $441
JUMPV
LABELV $582
line 819
;818:			}
;819:			uiInfo.uiDC.Assets.shadowFadeClamp = uiInfo.uiDC.Assets.shadowColor[3];
ADDRGP4 uiInfo+236+5342600
ADDRGP4 uiInfo+236+5342584+12
INDIRF4
ASGNF4
line 820
;820:			continue;
LABELV $578
line 823
;821:		}
;822:
;823:	}
LABELV $449
line 686
ADDRGP4 $448
JUMPV
line 824
;824:	return qfalse;
CNSTI4 0
RETI4
LABELV $441
endproc Asset_Parse 1124 12
export Font_Report
proc Font_Report 8 12
line 827
;825:}
;826:
;827:void Font_Report() {
line 829
;828:	int i;
;829:	Com_Printf("Font Info\n");
ADDRGP4 $592
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 830
;830:	Com_Printf("=========\n");
ADDRGP4 $593
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 831
;831:	for (i = 32; i < 96; i++) {
ADDRLP4 0
CNSTI4 32
ASGNI4
LABELV $594
line 832
;832:		Com_Printf("Glyph handle %i: %i\n", i, uiInfo.uiDC.Assets.textFont.glyphs[i].glyph);
ADDRGP4 $598
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 80
MULI4
ADDRGP4 uiInfo+236+12+44
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 833
;833:	}
LABELV $595
line 831
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 96
LTI4 $594
line 834
;834:}
LABELV $591
endproc Font_Report 8 12
export UI_Report
proc UI_Report 0 0
line 836
;835:
;836:void UI_Report() {
line 837
;837:	String_Report();
ADDRGP4 String_Report
CALLV
pop
line 840
;838:	//Font_Report();
;839:
;840:}
LABELV $602
endproc UI_Report 0 0
export UI_ParseMenu
proc UI_ParseMenu 1060 12
line 842
;841:
;842:void UI_ParseMenu(const char *menuFile) {
line 846
;843:	int handle;
;844:	pc_token_t token;
;845:
;846:	Com_Printf("Parsing menu file:%s\n", menuFile);
ADDRGP4 $604
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 848
;847:
;848:	handle = trap_PC_LoadSource(menuFile);
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
line 849
;849:	if (!handle) {
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $608
line 850
;850:		return;
ADDRGP4 $603
JUMPV
LABELV $607
line 853
;851:	}
;852:
;853:	while (1) {
line 854
;854:		memset(&token, 0, sizeof(pc_token_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1040
ARGI4
ADDRGP4 memset
CALLP4
pop
line 855
;855:		if (!trap_PC_ReadToken(handle, &token)) {
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
NEI4 $610
line 856
;856:			break;
ADDRGP4 $609
JUMPV
LABELV $610
line 869
;857:		}
;858:
;859:		//if ( Q_stricmp( token, "{" ) ) {
;860:		//	Com_Printf( "Missing { in menu file\n" );
;861:		//	break;
;862:		//}
;863:
;864:		//if ( menuCount == MAX_MENUS ) {
;865:		//	Com_Printf( "Too many menus!\n" );
;866:		//	break;
;867:		//}
;868:
;869:		if (token.string[0] == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $612
line 870
;870:			break;
ADDRGP4 $609
JUMPV
LABELV $612
line 873
;871:		}
;872:
;873:		if (Q_stricmp(token.string, "assetGlobalDef") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $618
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $615
line 874
;874:			if (Asset_Parse(handle)) {
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
EQI4 $609
line 875
;875:				continue;
ADDRGP4 $608
JUMPV
line 876
;876:			} else {
line 877
;877:				break;
LABELV $615
line 881
;878:			}
;879:		}
;880:
;881:		if (Q_stricmp(token.string, "menudef") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $624
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $621
line 883
;882:			// start a new menu
;883:			Menu_New(handle);
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 Menu_New
CALLV
pop
line 884
;884:		}
LABELV $621
line 885
;885:	}
LABELV $608
line 853
ADDRGP4 $607
JUMPV
LABELV $609
line 886
;886:	trap_PC_FreeSource(handle);
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 trap_PC_FreeSource
CALLI4
pop
line 887
;887:}
LABELV $603
endproc UI_ParseMenu 1060 12
export Load_Menu
proc Load_Menu 1048 8
line 889
;888:
;889:qboolean Load_Menu(int handle) {
line 892
;890:	pc_token_t token;
;891:
;892:	if (!trap_PC_ReadToken(handle, &token))
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
NEI4 $626
line 893
;893:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $625
JUMPV
LABELV $626
line 894
;894:	if (token.string[0] != '{') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $632
line 895
;895:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $625
JUMPV
LABELV $631
line 898
;896:	}
;897:
;898:	while (1) {
line 900
;899:
;900:		if (!trap_PC_ReadToken(handle, &token))
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
NEI4 $634
line 901
;901:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $625
JUMPV
LABELV $634
line 903
;902:
;903:		if (token.string[0] == 0) {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $636
line 904
;904:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $625
JUMPV
LABELV $636
line 907
;905:		}
;906:
;907:		if (token.string[0] == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $639
line 908
;908:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $625
JUMPV
LABELV $639
line 911
;909:		}
;910:
;911:		UI_ParseMenu(token.string);
ADDRLP4 0+16
ARGP4
ADDRGP4 UI_ParseMenu
CALLV
pop
line 912
;912:	}
LABELV $632
line 898
ADDRGP4 $631
JUMPV
line 913
;913:	return qfalse;
CNSTI4 0
RETI4
LABELV $625
endproc Load_Menu 1048 8
export UI_LoadMenus
proc UI_LoadMenus 1068 8
line 916
;914:}
;915:
;916:void UI_LoadMenus(const char *menuFile, qboolean reset) {
line 921
;917:	pc_token_t token;
;918:	int handle;
;919:	int start;
;920:
;921:	start = trap_Milliseconds();
ADDRLP4 1048
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 1044
ADDRLP4 1048
INDIRI4
ASGNI4
line 925
;922:
;923:	//trap_Print(va("UI_LoadMenus(%s, %d)\n", menuFile, reset));
;924:
;925:	handle = trap_PC_LoadSource(menuFile);
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
line 926
;926:	if (!handle) {
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $644
line 929
;927:		//trap_Error( va( S_COLOR_YELLOW "menu file not found: %s, using default\n", menuFile ) );
;928:		//trap_Print( va( S_COLOR_YELLOW "menu file not found: %s, using default\n", menuFile ) );
;929:		handle = trap_PC_LoadSource("ui/menus.txt");
ADDRGP4 $646
ARGP4
ADDRLP4 1056
ADDRGP4 trap_PC_LoadSource
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1056
INDIRI4
ASGNI4
line 930
;930:		if (!handle) {
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $647
line 931
;931:			trap_Error(S_COLOR_RED "default menu file not found: ui/menus.txt, unable to continue!\n");
ADDRGP4 $649
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 932
;932:		}
LABELV $647
line 933
;933:	}
LABELV $644
line 935
;934:
;935:	ui_new.integer = 1;
ADDRGP4 ui_new+12
CNSTI4 1
ASGNI4
line 937
;936:
;937:	if (reset) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $654
line 938
;938:		Menu_Reset();
ADDRGP4 Menu_Reset
CALLV
pop
line 939
;939:	}
ADDRGP4 $654
JUMPV
LABELV $653
line 941
;940:
;941:	while (1) {
line 942
;942:		if (!trap_PC_ReadToken(handle, &token))
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
NEI4 $656
line 943
;943:			break;
ADDRGP4 $655
JUMPV
LABELV $656
line 944
;944:		if (token.string[0] == 0 || token.string[0] == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $662
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $658
LABELV $662
line 945
;945:			break;
ADDRGP4 $655
JUMPV
LABELV $658
line 948
;946:		}
;947:
;948:		if (token.string[0] == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $663
line 949
;949:			break;
ADDRGP4 $655
JUMPV
LABELV $663
line 952
;950:		}
;951:
;952:		if (Q_stricmp(token.string, "loadmenu") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $669
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $666
line 953
;953:			if (Load_Menu(handle)) {
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
EQI4 $655
line 954
;954:				continue;
line 955
;955:			} else {
line 956
;956:				break;
LABELV $666
line 959
;957:			}
;958:		}
;959:	}
LABELV $654
line 941
ADDRGP4 $653
JUMPV
LABELV $655
line 961
;960:
;961:	Com_Printf("UI menu load time = %d milli seconds\n", trap_Milliseconds() - start);
ADDRLP4 1056
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRGP4 $672
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
line 963
;962:
;963:	trap_PC_FreeSource(handle);
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 trap_PC_FreeSource
CALLI4
pop
line 964
;964:}
LABELV $643
endproc UI_LoadMenus 1068 8
export UI_Load
proc UI_Load 1048 12
line 966
;965:
;966:void UI_Load() {
line 968
;967:	char lastName[1024];
;968:	menuDef_t *menu = Menu_GetFocused();
ADDRLP4 1032
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 1032
INDIRP4
ASGNP4
line 969
;969:	char *menuSet = UI_Cvar_VariableString("ui_menuFiles");
ADDRGP4 $674
ARGP4
ADDRLP4 1036
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1036
INDIRP4
ASGNP4
line 972
;970:
;971:	//trap_Print("UI_Load()\n");
;972:	if (menu && menu->window.name) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $675
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $675
line 973
;973:		Q_strncpyz(lastName, menu->window.name, sizeof(lastName));
ADDRLP4 8
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 974
;974:	}
LABELV $675
line 975
;975:	if (menuSet == NULL || menuSet[0] == '\0') {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $679
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $677
LABELV $679
line 976
;976:		menuSet = "ui/menus.txt";
ADDRLP4 0
ADDRGP4 $646
ASGNP4
line 977
;977:	}
LABELV $677
line 979
;978:
;979:	String_Init();
ADDRGP4 String_Init
CALLV
pop
line 981
;980:
;981:	UI_ParseGameInfo("gameinfo.txt");
ADDRGP4 $680
ARGP4
ADDRGP4 UI_ParseGameInfo
CALLV
pop
line 982
;982:	UI_LoadArenas();
ADDRGP4 UI_LoadArenas
CALLV
pop
line 984
;983:
;984:	UI_LoadMenus(menuSet, qtrue);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 UI_LoadMenus
CALLV
pop
line 985
;985:	Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 986
;986:	Menus_ActivateByName(lastName);
ADDRLP4 8
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 988
;987:
;988:}
LABELV $673
endproc UI_Load 1048 12
proc UI_SourceForLAN 4 0
line 991
;989:
;990:// Convert ui's net source to AS_* used by trap calls.
;991:static int UI_SourceForLAN(void) {
line 992
;992:	switch (ui_netSource.integer) {
ADDRLP4 0
ADDRGP4 ui_netSource+12
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $682
ADDRLP4 0
INDIRI4
CNSTI4 7
GTI4 $682
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $688
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $688
address $685
address $686
address $686
address $686
address $686
address $686
address $686
address $687
code
LABELV $682
LABELV $685
line 995
;993:	default:
;994:	case UIAS_LOCAL:
;995:		return AS_LOCAL;
CNSTI4 0
RETI4
ADDRGP4 $681
JUMPV
LABELV $686
line 1002
;996:	case UIAS_GLOBAL0:
;997:	case UIAS_GLOBAL1:
;998:	case UIAS_GLOBAL2:
;999:	case UIAS_GLOBAL3:
;1000:	case UIAS_GLOBAL4:
;1001:	case UIAS_GLOBAL5:
;1002:		return AS_GLOBAL;
CNSTI4 2
RETI4
ADDRGP4 $681
JUMPV
LABELV $687
line 1004
;1003:	case UIAS_FAVORITES:
;1004:		return AS_FAVORITES;
CNSTI4 3
RETI4
LABELV $681
endproc UI_SourceForLAN 4 0
data
align 4
LABELV handicapValues
address $689
address $690
address $691
address $692
address $693
address $694
address $695
address $696
address $697
address $698
address $699
address $700
address $701
address $702
address $703
address $704
address $705
address $706
address $707
address $708
byte 4 0
code
proc UI_DrawHandicap 20 40
line 1011
;1005:	}
;1006:}
;1007:
;1008:
;1009:static const char *handicapValues[] = { "None","95","90","85","80","75","70","65","60","55","50","45","40","35","30","25","20","15","10","5",NULL };
;1010:
;1011:static void UI_DrawHandicap(rectDef_t *rect, float scale, const vec4_t color, int textStyle) {
line 1014
;1012:	int i, h;
;1013:
;1014:	h = Com_Clamp(5, 100, trap_Cvar_VariableValue("handicap"));
ADDRGP4 $710
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
line 1015
;1015:	i = 20 - h / 5;
ADDRLP4 0
CNSTI4 20
ADDRLP4 4
INDIRI4
CNSTI4 5
DIVI4
SUBI4
ASGNI4
line 1017
;1016:
;1017:	Text_Paint(rect->x, rect->y, scale, color, handicapValues[i], 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1018
;1018:}
LABELV $709
endproc UI_DrawHandicap 20 40
proc UI_DrawClanName 8 40
line 1020
;1019:
;1020:static void UI_DrawClanName(rectDef_t *rect, float scale, const vec4_t color, int textStyle) {
line 1021
;1021:	Text_Paint(rect->x, rect->y, scale, color, UI_Cvar_VariableString("ui_teamName"), 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
ADDRGP4 $712
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1022
;1022:}
LABELV $711
endproc UI_DrawClanName 8 40
proc UI_SetCapFragLimits 16 8
line 1025
;1023:
;1024:
;1025:static void UI_SetCapFragLimits(qboolean uiVars) {
line 1026
;1026:	int cap = 5;
ADDRLP4 0
CNSTI4 5
ASGNI4
line 1027
;1027:	int frag = 10;
ADDRLP4 4
CNSTI4 10
ASGNI4
line 1028
;1028:	if (uiInfo.gameTypes[ui_gameType.integer].gtEnum == GT_OBELISK) {
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359512+4
ADDP4
INDIRI4
CNSTI4 7
NEI4 $714
line 1029
;1029:		cap = 4;
ADDRLP4 0
CNSTI4 4
ASGNI4
line 1030
;1030:	} else if (uiInfo.gameTypes[ui_gameType.integer].gtEnum == GT_HARVESTER) {
ADDRGP4 $715
JUMPV
LABELV $714
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359512+4
ADDP4
INDIRI4
CNSTI4 8
NEI4 $719
line 1031
;1031:		cap = 15;
ADDRLP4 0
CNSTI4 15
ASGNI4
line 1032
;1032:	}
LABELV $719
LABELV $715
line 1033
;1033:	if (uiVars) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $724
line 1034
;1034:		trap_Cvar_Set("ui_captureLimit", va("%d", cap));
ADDRGP4 $727
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $726
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1035
;1035:		trap_Cvar_Set("ui_fragLimit", va("%d", frag));
ADDRGP4 $727
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $728
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1036
;1036:	} else {
ADDRGP4 $725
JUMPV
LABELV $724
line 1037
;1037:		trap_Cvar_Set("capturelimit", va("%d", cap));
ADDRGP4 $727
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $729
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1038
;1038:		trap_Cvar_Set("fraglimit", va("%d", frag));
ADDRGP4 $727
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $730
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1039
;1039:	}
LABELV $725
line 1040
;1040:}
LABELV $713
endproc UI_SetCapFragLimits 16 8
proc UI_DrawGameType 4 40
line 1042
;1041:// ui_gameType assumes gametype 0 is -1 ALL and will not show
;1042:static void UI_DrawGameType(rectDef_t *rect, float scale, const vec4_t color, int textStyle) {
line 1043
;1043:	Text_Paint(rect->x, rect->y, scale, color, uiInfo.gameTypes[ui_gameType.integer].gameType, 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
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
ADDRGP4 uiInfo+5359512
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1044
;1044:}
LABELV $731
endproc UI_DrawGameType 4 40
proc UI_DrawNetGameType 4 40
line 1046
;1045:
;1046:static void UI_DrawNetGameType(rectDef_t *rect, float scale, const vec4_t color, int textStyle) {
line 1047
;1047:	if (ui_netGameType.integer < 0 || ui_netGameType.integer > uiInfo.numGameTypes) {
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 0
LTI4 $740
ADDRGP4 ui_netGameType+12
INDIRI4
ADDRGP4 uiInfo+5359508
INDIRI4
LEI4 $735
LABELV $740
line 1048
;1048:		trap_Cvar_Set("ui_netGameType", "0");
ADDRGP4 $741
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1049
;1049:		trap_Cvar_Set("ui_actualNetGameType", "0");
ADDRGP4 $742
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1050
;1050:	}
LABELV $735
line 1051
;1051:	Text_Paint(rect->x, rect->y, scale, color, uiInfo.gameTypes[ui_netGameType.integer].gameType, 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
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
ADDRGP4 uiInfo+5359512
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1052
;1052:}
LABELV $734
endproc UI_DrawNetGameType 4 40
proc UI_DrawJoinGameType 4 40
line 1054
;1053:
;1054:static void UI_DrawJoinGameType(rectDef_t *rect, float scale, const vec4_t color, int textStyle) {
line 1055
;1055:	if (ui_joinGameType.integer < 0 || ui_joinGameType.integer > uiInfo.numJoinGameTypes) {
ADDRGP4 ui_joinGameType+12
INDIRI4
CNSTI4 0
LTI4 $751
ADDRGP4 ui_joinGameType+12
INDIRI4
ADDRGP4 uiInfo+5359640
INDIRI4
LEI4 $746
LABELV $751
line 1056
;1056:		trap_Cvar_Set("ui_joinGameType", "0");
ADDRGP4 $752
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1057
;1057:	}
LABELV $746
line 1058
;1058:	Text_Paint(rect->x, rect->y, scale, color, uiInfo.joinGameTypes[ui_joinGameType.integer].gameType, 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
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
ADDRGP4 uiInfo+5359644
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1059
;1059:}
LABELV $745
endproc UI_DrawJoinGameType 4 40
proc UI_TeamIndexFromName 12 8
line 1063
;1060:
;1061:
;1062:
;1063:static int UI_TeamIndexFromName(const char *name) {
line 1066
;1064:	int i;
;1065:
;1066:	if (name && *name) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $756
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $756
line 1067
;1067:		for (i = 0; i < uiInfo.teamCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $761
JUMPV
LABELV $758
line 1068
;1068:			if (Q_stricmp(name, uiInfo.teamList[i].teamName) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692
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
NEI4 $763
line 1069
;1069:				return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $755
JUMPV
LABELV $763
line 1071
;1070:			}
;1071:		}
LABELV $759
line 1067
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $761
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5356688
INDIRI4
LTI4 $758
line 1072
;1072:	}
LABELV $756
line 1074
;1073:
;1074:	return 0;
CNSTI4 0
RETI4
LABELV $755
endproc UI_TeamIndexFromName 12 8
proc UI_DrawClanLogo 48 24
line 1078
;1075:
;1076:}
;1077:
;1078:static void UI_DrawClanLogo(rectDef_t *rect, float scale, vec4_t color) {
line 1080
;1079:	int i;
;1080:	i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $712
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
line 1081
;1081:	if (i >= 0 && i < uiInfo.teamCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $767
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5356688
INDIRI4
GEI4 $767
line 1082
;1082:		trap_R_SetColor(color);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1084
;1083:
;1084:		if (uiInfo.teamList[i].teamIcon == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+28
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $770
line 1085
;1085:			uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356692+28
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 1086
;1086:			uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal", uiInfo.teamList[i].imageName));
ADDRGP4 $780
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356692+32
ADDP4
ADDRLP4 32
INDIRI4
ASGNI4
line 1087
;1087:			uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $785
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356692+36
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 1088
;1088:		}
LABELV $770
line 1090
;1089:
;1090:		UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon, WIDESCREEN_STRETCH);
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
ADDRGP4 uiInfo+5356692+28
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1091
;1091:		trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1092
;1092:	}
LABELV $767
line 1093
;1093:}
LABELV $766
endproc UI_DrawClanLogo 48 24
proc UI_PlayCinematic 4 24
line 1097
;1094:
;1095:
;1096:
;1097:static int UI_PlayCinematic(const char *name, float x, float y, float w, float h, int widescreen) {
line 1098
;1098:	return trap_CIN_PlayCinematic(name, x, y, w, h, (CIN_loop | CIN_silent));
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
LABELV $790
endproc UI_PlayCinematic 4 24
proc UI_StopCinematic 20 4
line 1101
;1099:}
;1100:
;1101:static void UI_StopCinematic(int handle) {
line 1102
;1102:	if (handle >= 0) {
ADDRFP4 0
INDIRI4
CNSTI4 0
LTI4 $792
line 1103
;1103:		trap_CIN_StopCinematic(handle);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 1104
;1104:	} else {
ADDRGP4 $793
JUMPV
LABELV $792
line 1105
;1105:		handle = abs(handle);
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
line 1106
;1106:		if (handle == UI_MAPCINEMATIC) {
ADDRFP4 0
INDIRI4
CNSTI4 536
NEI4 $794
line 1107
;1107:			if (uiInfo.mapList[ui_currentMap.integer].cinematic >= 0) {
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+24
ADDP4
INDIRI4
CNSTI4 0
LTI4 $795
line 1108
;1108:				trap_CIN_StopCinematic(uiInfo.mapList[ui_currentMap.integer].cinematic);
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+24
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 1109
;1109:				uiInfo.mapList[ui_currentMap.integer].cinematic = -1;
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+24
ADDP4
CNSTI4 -1
ASGNI4
line 1110
;1110:			}
line 1111
;1111:		} else if (handle == UI_NETMAPCINEMATIC) {
ADDRGP4 $795
JUMPV
LABELV $794
ADDRFP4 0
INDIRI4
CNSTI4 538
NEI4 $807
line 1112
;1112:			if (uiInfo.serverStatus.currentServerCinematic >= 0) {
ADDRGP4 uiInfo+5387364+10432
INDIRI4
CNSTI4 0
LTI4 $808
line 1113
;1113:				trap_CIN_StopCinematic(uiInfo.serverStatus.currentServerCinematic);
ADDRGP4 uiInfo+5387364+10432
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 1114
;1114:				uiInfo.serverStatus.currentServerCinematic = -1;
ADDRGP4 uiInfo+5387364+10432
CNSTI4 -1
ASGNI4
line 1115
;1115:			}
line 1116
;1116:		} else if (handle == UI_CLANCINEMATIC) {
ADDRGP4 $808
JUMPV
LABELV $807
ADDRFP4 0
INDIRI4
CNSTI4 543
NEI4 $817
line 1117
;1117:			int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $712
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
line 1118
;1118:			if (i >= 0 && i < uiInfo.teamCount) {
ADDRLP4 16
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
LTI4 $819
ADDRLP4 16
INDIRI4
ADDRGP4 uiInfo+5356688
INDIRI4
GEI4 $819
line 1119
;1119:				if (uiInfo.teamList[i].cinematic >= 0) {
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+40
ADDP4
INDIRI4
CNSTI4 0
LTI4 $822
line 1120
;1120:					trap_CIN_StopCinematic(uiInfo.teamList[i].cinematic);
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+40
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 1121
;1121:					uiInfo.teamList[i].cinematic = -1;
ADDRLP4 4
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+40
ADDP4
CNSTI4 -1
ASGNI4
line 1122
;1122:				}
LABELV $822
line 1123
;1123:			}
LABELV $819
line 1124
;1124:		}
LABELV $817
LABELV $808
LABELV $795
line 1125
;1125:	}
LABELV $793
line 1126
;1126:}
LABELV $791
endproc UI_StopCinematic 20 4
proc UI_DrawCinematic 0 20
line 1128
;1127:
;1128:static void UI_DrawCinematic(int handle, float x, float y, float w, float h, int widescreen) {
line 1130
;1129:	// adjust coords to get correct placement in wide screen
;1130:	UI_AdjustFrom640(&x, &y, &w, &h);
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRFP4 16
ARGP4
ADDRGP4 UI_AdjustFrom640
CALLV
pop
line 1133
;1131:
;1132:	// CIN_SetExtents takes stretched 640x480 virtualized coords
;1133:	x *= SCREEN_WIDTH / (float)uiInfo.uiDC.glconfig.vidWidth;
ADDRFP4 4
ADDRFP4 4
INDIRF4
CNSTF4 1142947840
ADDRGP4 uiInfo+5342996+11304
INDIRI4
CVIF4 4
DIVF4
MULF4
ASGNF4
line 1134
;1134:	w *= SCREEN_WIDTH / (float)uiInfo.uiDC.glconfig.vidWidth;
ADDRFP4 12
ADDRFP4 12
INDIRF4
CNSTF4 1142947840
ADDRGP4 uiInfo+5342996+11304
INDIRI4
CVIF4 4
DIVF4
MULF4
ASGNF4
line 1135
;1135:	y *= SCREEN_HEIGHT / (float)uiInfo.uiDC.glconfig.vidHeight;
ADDRFP4 8
ADDRFP4 8
INDIRF4
CNSTF4 1139802112
ADDRGP4 uiInfo+5342996+11308
INDIRI4
CVIF4 4
DIVF4
MULF4
ASGNF4
line 1136
;1136:	h *= SCREEN_HEIGHT / (float)uiInfo.uiDC.glconfig.vidHeight;
ADDRFP4 16
ADDRFP4 16
INDIRF4
CNSTF4 1139802112
ADDRGP4 uiInfo+5342996+11308
INDIRI4
CVIF4 4
DIVF4
MULF4
ASGNF4
line 1138
;1137:
;1138:	trap_CIN_SetExtents(handle, x, y, w, h);
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
line 1139
;1139:	trap_CIN_DrawCinematic(handle);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 trap_CIN_DrawCinematic
CALLV
pop
line 1140
;1140:}
LABELV $830
endproc UI_DrawCinematic 0 20
proc UI_RunCinematicFrame 0 4
line 1142
;1141:
;1142:static void UI_RunCinematicFrame(int handle) {
line 1143
;1143:	trap_CIN_RunCinematic(handle);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 trap_CIN_RunCinematic
CALLI4
pop
line 1144
;1144:}
LABELV $839
endproc UI_RunCinematicFrame 0 4
proc UI_DrawClanCinematic 28 24
line 1146
;1145:
;1146:static void UI_DrawClanCinematic(rectDef_t *rect, float scale, const vec4_t color) {
line 1148
;1147:	int i;
;1148:	i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $712
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
line 1149
;1149:	if (i >= 0 && i < uiInfo.teamCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $841
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5356688
INDIRI4
GEI4 $841
line 1151
;1150:
;1151:		if (uiInfo.teamList[i].cinematic >= -2) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+40
ADDP4
INDIRI4
CNSTI4 -2
LTI4 $844
line 1152
;1152:			if (uiInfo.teamList[i].cinematic == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+40
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $848
line 1153
;1153:				uiInfo.teamList[i].cinematic = trap_CIN_PlayCinematic(va("%s.roq", uiInfo.teamList[i].imageName), 0, 0, 0, 0, (CIN_loop | CIN_silent));
ADDRGP4 $854
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356692+40
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 1154
;1154:			}
LABELV $848
line 1155
;1155:			if (uiInfo.teamList[i].cinematic >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+40
ADDP4
INDIRI4
CNSTI4 0
LTI4 $857
line 1156
;1156:				trap_CIN_RunCinematic(uiInfo.teamList[i].cinematic);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+40
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_RunCinematic
CALLI4
pop
line 1157
;1157:				UI_DrawCinematic(uiInfo.teamList[i].cinematic, rect->x, rect->y, rect->w, rect->h, WIDESCREEN_STRETCH);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+40
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
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawCinematic
CALLV
pop
line 1158
;1158:			} else {
ADDRGP4 $845
JUMPV
LABELV $857
line 1159
;1159:				trap_R_SetColor(color);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1160
;1160:				UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon_Metal, WIDESCREEN_STRETCH);
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
ADDRGP4 uiInfo+5356692+32
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1161
;1161:				trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1162
;1162:				uiInfo.teamList[i].cinematic = -2;
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+40
ADDP4
CNSTI4 -2
ASGNI4
line 1163
;1163:			}
line 1164
;1164:		} else {
ADDRGP4 $845
JUMPV
LABELV $844
line 1165
;1165:			trap_R_SetColor(color);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1166
;1166:			UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon, WIDESCREEN_STRETCH);
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
ADDRGP4 uiInfo+5356692+28
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1167
;1167:			trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1168
;1168:		}
LABELV $845
line 1169
;1169:	}
LABELV $841
line 1171
;1170:
;1171:}
LABELV $840
endproc UI_DrawClanCinematic 28 24
proc UI_DrawPreviewCinematic 12 24
line 1173
;1172:
;1173:static void UI_DrawPreviewCinematic(rectDef_t *rect, float scale, const vec4_t color) {
line 1174
;1174:	if (uiInfo.previewMovie > -2) {
ADDRGP4 uiInfo+5387360
INDIRI4
CNSTI4 -2
LEI4 $872
line 1175
;1175:		uiInfo.previewMovie = trap_CIN_PlayCinematic(va("%s.roq", uiInfo.movieList[uiInfo.movieIndex]), 0, 0, 0, 0, (CIN_loop | CIN_silent));
ADDRGP4 $854
ARGP4
ADDRGP4 uiInfo+5387356
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5386328
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
ADDRGP4 uiInfo+5387360
ADDRLP4 4
INDIRI4
ASGNI4
line 1176
;1176:		if (uiInfo.previewMovie >= 0) {
ADDRGP4 uiInfo+5387360
INDIRI4
CNSTI4 0
LTI4 $878
line 1177
;1177:			trap_CIN_RunCinematic(uiInfo.previewMovie);
ADDRGP4 uiInfo+5387360
INDIRI4
ARGI4
ADDRGP4 trap_CIN_RunCinematic
CALLI4
pop
line 1178
;1178:			UI_DrawCinematic(uiInfo.previewMovie, rect->x, rect->y, rect->w, rect->h, WIDESCREEN_STRETCH);
ADDRGP4 uiInfo+5387360
INDIRI4
ARGI4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawCinematic
CALLV
pop
line 1179
;1179:		} else {
ADDRGP4 $879
JUMPV
LABELV $878
line 1180
;1180:			uiInfo.previewMovie = -2;
ADDRGP4 uiInfo+5387360
CNSTI4 -2
ASGNI4
line 1181
;1181:		}
LABELV $879
line 1182
;1182:	}
LABELV $872
line 1184
;1183:
;1184:}
LABELV $871
endproc UI_DrawPreviewCinematic 12 24
proc UI_DrawSkill 16 40
line 1188
;1185:
;1186:
;1187:
;1188:static void UI_DrawSkill(rectDef_t *rect, float scale, const vec4_t color, int textStyle) {
line 1190
;1189:	int i;
;1190:	i = trap_Cvar_VariableValue("g_spSkill");
ADDRGP4 $885
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
line 1191
;1191:	if (i < 1 || i > numSkillLevels) {
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $888
ADDRLP4 0
INDIRI4
ADDRGP4 numSkillLevels
INDIRI4
LEI4 $886
LABELV $888
line 1192
;1192:		i = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1193
;1193:	}
LABELV $886
line 1194
;1194:	Text_Paint(rect->x, rect->y, scale, color, skillLevels[i - 1], 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1195
;1195:}
LABELV $884
endproc UI_DrawSkill 16 40
proc UI_DrawTeamName 32 40
line 1198
;1196:
;1197:
;1198:static void UI_DrawTeamName(rectDef_t *rect, float scale, const vec4_t color, qboolean blue, int textStyle) {
line 1200
;1199:	int i;
;1200:	i = UI_TeamIndexFromName(UI_Cvar_VariableString((blue) ? "ui_blueTeam" : "ui_redTeam"));
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $894
ADDRLP4 4
ADDRGP4 $891
ASGNP4
ADDRGP4 $895
JUMPV
LABELV $894
ADDRLP4 4
ADDRGP4 $892
ASGNP4
LABELV $895
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
line 1201
;1201:	if (i >= 0 && i < uiInfo.teamCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $896
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5356688
INDIRI4
GEI4 $896
line 1202
;1202:		Text_Paint(rect->x, rect->y, scale, color, va("%s: %s", (blue) ? "Blue" : "Red", uiInfo.teamList[i].teamName), 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
ADDRGP4 $899
ARGP4
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $904
ADDRLP4 20
ADDRGP4 $900
ASGNP4
ADDRGP4 $905
JUMPV
LABELV $904
ADDRLP4 20
ADDRGP4 $901
ASGNP4
LABELV $905
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1203
;1203:	}
LABELV $896
line 1204
;1204:}
LABELV $890
endproc UI_DrawTeamName 32 40
proc UI_DrawTeamMember 28 40
line 1206
;1205:
;1206:static void UI_DrawTeamMember(rectDef_t *rect, float scale, const vec4_t color, qboolean blue, int num, int textStyle) {
line 1210
;1207:	// 0 - None
;1208:	// 1 - Human
;1209:	// 2..NumCharacters - Bot
;1210:	int value = trap_Cvar_VariableValue(va(blue ? "ui_blueteam%i" : "ui_redteam%i", num));
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $910
ADDRLP4 8
ADDRGP4 $907
ASGNP4
ADDRGP4 $911
JUMPV
LABELV $910
ADDRLP4 8
ADDRGP4 $908
ASGNP4
LABELV $911
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
line 1212
;1211:	const char *text;
;1212:	if (value <= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $912
line 1213
;1213:		text = "Closed";
ADDRLP4 4
ADDRGP4 $914
ASGNP4
line 1214
;1214:	} else if (value == 1) {
ADDRGP4 $913
JUMPV
LABELV $912
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $915
line 1215
;1215:		text = "Human";
ADDRLP4 4
ADDRGP4 $917
ASGNP4
line 1216
;1216:	} else {
ADDRGP4 $916
JUMPV
LABELV $915
line 1217
;1217:		value -= 2;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 1219
;1218:
;1219:		if (ui_actualNetGameType.integer >= GT_TEAM) {
ADDRGP4 ui_actualNetGameType+12
INDIRI4
CNSTI4 3
LTI4 $918
line 1220
;1220:			if (value >= uiInfo.characterCount) {
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5354372
INDIRI4
LTI4 $921
line 1221
;1221:				value = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1222
;1222:			}
LABELV $921
line 1223
;1223:			text = uiInfo.characterList[value].name;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380
ADDP4
INDIRP4
ASGNP4
line 1224
;1224:		} else {
ADDRGP4 $919
JUMPV
LABELV $918
line 1225
;1225:			if (value >= UI_GetNumBots()) {
ADDRLP4 20
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 20
INDIRI4
LTI4 $925
line 1226
;1226:				value = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1227
;1227:			}
LABELV $925
line 1228
;1228:			text = UI_GetBotNameByNumber(value);
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
line 1229
;1229:		}
LABELV $919
line 1230
;1230:	}
LABELV $916
LABELV $913
line 1231
;1231:	Text_Paint(rect->x, rect->y, scale, color, text, 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1232
;1232:}
LABELV $906
endproc UI_DrawTeamMember 28 40
proc UI_DrawEffects 8 24
line 1234
;1233:
;1234:static void UI_DrawEffects(rectDef_t *rect, float scale, const vec4_t color) {
line 1235
;1235:	UI_DrawHandlePic(rect->x, rect->y - 14, 128, 8, uiInfo.uiDC.Assets.fxBasePic, WIDESCREEN_STRETCH);
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
ADDRGP4 uiInfo+236+5342608
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1236
;1236:	UI_DrawHandlePic(rect->x + uiInfo.effectsColor * 16 + 8, rect->y - 16, 16, 12, uiInfo.uiDC.Assets.fxPic[uiInfo.effectsColor], WIDESCREEN_STRETCH);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 uiInfo+5425004
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
ADDRGP4 uiInfo+5425004
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+236+5342612
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1237
;1237:}
LABELV $927
endproc UI_DrawEffects 8 24
proc UI_DrawMapPreview 20 24
line 1239
;1238:
;1239:static void UI_DrawMapPreview(rectDef_t *rect, float scale, const vec4_t color, qboolean net) {
line 1240
;1240:	int map = (net) ? ui_currentNetMap.integer : ui_currentMap.integer;
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $938
ADDRLP4 4
ADDRGP4 ui_currentNetMap+12
INDIRI4
ASGNI4
ADDRGP4 $939
JUMPV
LABELV $938
ADDRLP4 4
ADDRGP4 ui_currentMap+12
INDIRI4
ASGNI4
LABELV $939
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1241
;1241:	if (map < 0 || map > uiInfo.mapCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $943
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5364156
INDIRI4
LEI4 $940
LABELV $943
line 1242
;1242:		if (net) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $944
line 1243
;1243:			ui_currentNetMap.integer = 0;
ADDRGP4 ui_currentNetMap+12
CNSTI4 0
ASGNI4
line 1244
;1244:			trap_Cvar_Set("ui_currentNetMap", "0");
ADDRGP4 $947
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1245
;1245:		} else {
ADDRGP4 $945
JUMPV
LABELV $944
line 1246
;1246:			ui_currentMap.integer = 0;
ADDRGP4 ui_currentMap+12
CNSTI4 0
ASGNI4
line 1247
;1247:			trap_Cvar_Set("ui_currentMap", "0");
ADDRGP4 $949
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1248
;1248:		}
LABELV $945
line 1249
;1249:		map = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1250
;1250:	}
LABELV $940
line 1252
;1251:
;1252:	if (uiInfo.mapList[map].levelShot == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+92
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $950
line 1253
;1253:		uiInfo.mapList[map].levelShot = trap_R_RegisterShaderNoMip(uiInfo.mapList[map].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+8
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
ADDRGP4 uiInfo+5364160+92
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1254
;1254:	}
LABELV $950
line 1256
;1255:
;1256:	if (uiInfo.mapList[map].levelShot > 0) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+92
ADDP4
INDIRI4
CNSTI4 0
LEI4 $958
line 1257
;1257:		UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.mapList[map].levelShot, WIDESCREEN_STRETCH);
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
ADDRGP4 uiInfo+5364160+92
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1258
;1258:	} else {
ADDRGP4 $959
JUMPV
LABELV $958
line 1259
;1259:		UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, trap_R_RegisterShaderNoMip("menu/art/unknownmap"), WIDESCREEN_STRETCH);
ADDRGP4 $964
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
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1260
;1260:	}
LABELV $959
line 1261
;1261:}
LABELV $934
endproc UI_DrawMapPreview 20 24
proc UI_DrawMapTimeToBeat 20 40
line 1264
;1262:
;1263:
;1264:static void UI_DrawMapTimeToBeat(rectDef_t *rect, float scale, const vec4_t color, int textStyle) {
line 1266
;1265:	int minutes, seconds, time;
;1266:	if (ui_currentMap.integer < 0 || ui_currentMap.integer > uiInfo.mapCount) {
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 0
LTI4 $971
ADDRGP4 ui_currentMap+12
INDIRI4
ADDRGP4 uiInfo+5364156
INDIRI4
LEI4 $966
LABELV $971
line 1267
;1267:		ui_currentMap.integer = 0;
ADDRGP4 ui_currentMap+12
CNSTI4 0
ASGNI4
line 1268
;1268:		trap_Cvar_Set("ui_currentMap", "0");
ADDRGP4 $949
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1269
;1269:	}
LABELV $966
line 1271
;1270:
;1271:	time = uiInfo.mapList[ui_currentMap.integer].timeToBeat[uiInfo.gameTypes[ui_gameType.integer].gtEnum];
ADDRLP4 0
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359512+4
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+28
ADDP4
ADDP4
INDIRI4
ASGNI4
line 1273
;1272:
;1273:	minutes = time / 60;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 60
DIVI4
ASGNI4
line 1274
;1274:	seconds = time % 60;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 60
MODI4
ASGNI4
line 1276
;1275:
;1276:	Text_Paint(rect->x, rect->y, scale, color, va("%02i:%02i", minutes, seconds), 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
ADDRGP4 $979
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1277
;1277:}
LABELV $965
endproc UI_DrawMapTimeToBeat 20 40
proc UI_DrawMapCinematic 24 24
line 1281
;1278:
;1279:
;1280:
;1281:static void UI_DrawMapCinematic(rectDef_t *rect, float scale, const vec4_t color, qboolean net) {
line 1283
;1282:
;1283:	int map = (net) ? ui_currentNetMap.integer : ui_currentMap.integer;
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $984
ADDRLP4 4
ADDRGP4 ui_currentNetMap+12
INDIRI4
ASGNI4
ADDRGP4 $985
JUMPV
LABELV $984
ADDRLP4 4
ADDRGP4 ui_currentMap+12
INDIRI4
ASGNI4
LABELV $985
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1284
;1284:	if (map < 0 || map > uiInfo.mapCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $989
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5364156
INDIRI4
LEI4 $986
LABELV $989
line 1285
;1285:		if (net) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $990
line 1286
;1286:			ui_currentNetMap.integer = 0;
ADDRGP4 ui_currentNetMap+12
CNSTI4 0
ASGNI4
line 1287
;1287:			trap_Cvar_Set("ui_currentNetMap", "0");
ADDRGP4 $947
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1288
;1288:		} else {
ADDRGP4 $991
JUMPV
LABELV $990
line 1289
;1289:			ui_currentMap.integer = 0;
ADDRGP4 ui_currentMap+12
CNSTI4 0
ASGNI4
line 1290
;1290:			trap_Cvar_Set("ui_currentMap", "0");
ADDRGP4 $949
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1291
;1291:		}
LABELV $991
line 1292
;1292:		map = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1293
;1293:	}
LABELV $986
line 1295
;1294:
;1295:	if (uiInfo.mapList[map].cinematic >= -1) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+24
ADDP4
INDIRI4
CNSTI4 -1
LTI4 $994
line 1296
;1296:		if (uiInfo.mapList[map].cinematic == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+24
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $998
line 1297
;1297:			uiInfo.mapList[map].cinematic = trap_CIN_PlayCinematic(va("%s.roq", uiInfo.mapList[map].mapLoadName), 0, 0, 0, 0, (CIN_loop | CIN_silent));
ADDRGP4 $854
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+4
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
ADDRGP4 uiInfo+5364160+24
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 1298
;1298:		}
LABELV $998
line 1299
;1299:		if (uiInfo.mapList[map].cinematic >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+24
ADDP4
INDIRI4
CNSTI4 0
LTI4 $1006
line 1300
;1300:			trap_CIN_RunCinematic(uiInfo.mapList[map].cinematic);
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+24
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_RunCinematic
CALLI4
pop
line 1301
;1301:			UI_DrawCinematic(uiInfo.mapList[map].cinematic, rect->x, rect->y, rect->w, rect->h, WIDESCREEN_STRETCH);
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+24
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
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawCinematic
CALLV
pop
line 1302
;1302:		} else {
ADDRGP4 $995
JUMPV
LABELV $1006
line 1303
;1303:			uiInfo.mapList[map].cinematic = -2;
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+24
ADDP4
CNSTI4 -2
ASGNI4
line 1304
;1304:		}
line 1305
;1305:	} else {
ADDRGP4 $995
JUMPV
LABELV $994
line 1306
;1306:		UI_DrawMapPreview(rect, scale, color, net);
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
line 1307
;1307:	}
LABELV $995
line 1308
;1308:}
LABELV $980
endproc UI_DrawMapCinematic 24 24
data
align 4
LABELV updateModel
byte 4 1
bss
align 4
LABELV $1017
skip 1276
code
proc UI_DrawPlayerModel 612 28
line 1314
;1309:
;1310:
;1311:
;1312:static qboolean updateModel = qtrue;
;1313:
;1314:static void UI_DrawPlayerModel(rectDef_t *rect) {
line 1322
;1315:	static playerInfo_t info;
;1316:	char model[MAX_QPATH];
;1317:	char team[256];
;1318:	char head[256];
;1319:	vec3_t	viewangles;
;1320:	vec3_t	moveangles;
;1321:
;1322:	Q_strncpyz(model, UI_Cvar_VariableString("model"), sizeof(model));
ADDRGP4 $1018
ARGP4
ADDRLP4 600
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 600
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1323
;1323:	Q_strncpyz(head, UI_Cvar_VariableString("headmodel"), sizeof(head));
ADDRGP4 $1019
ARGP4
ADDRLP4 604
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 64
ARGP4
ADDRLP4 604
INDIRP4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1324
;1324:	team[0] = '\0';
ADDRLP4 332
CNSTI1 0
ASGNI1
line 1326
;1325:
;1326:	if (updateModel) {
ADDRGP4 updateModel
INDIRI4
CNSTI4 0
EQI4 $1020
line 1327
;1327:		memset(&info, 0, sizeof(playerInfo_t));
ADDRGP4 $1017
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1276
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1328
;1328:		viewangles[YAW] = 180 - 10;
ADDRLP4 320+4
CNSTF4 1126825984
ASGNF4
line 1329
;1329:		viewangles[PITCH] = 0;
ADDRLP4 320
CNSTF4 0
ASGNF4
line 1330
;1330:		viewangles[ROLL] = 0;
ADDRLP4 320+8
CNSTF4 0
ASGNF4
line 1331
;1331:		VectorClear(moveangles);
ADDRLP4 588
CNSTF4 0
ASGNF4
ADDRLP4 588+4
CNSTF4 0
ASGNF4
ADDRLP4 588+8
CNSTF4 0
ASGNF4
line 1332
;1332:		UI_PlayerInfo_SetModel(&info, model, head, team);
ADDRGP4 $1017
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 64
ARGP4
ADDRLP4 332
ARGP4
ADDRGP4 UI_PlayerInfo_SetModel
CALLV
pop
line 1333
;1333:		UI_PlayerInfo_SetInfo(&info, LEGS_IDLE, TORSO_STAND, viewangles, vec3_origin, WP_MACHINEGUN, qfalse);
ADDRGP4 $1017
ARGP4
CNSTI4 22
ARGI4
CNSTI4 11
ARGI4
ADDRLP4 320
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
line 1335
;1334:		//		UI_RegisterClientModelname( &info, model, head, team);
;1335:		updateModel = qfalse;
ADDRGP4 updateModel
CNSTI4 0
ASGNI4
line 1336
;1336:	}
LABELV $1020
line 1338
;1337:
;1338:	UI_DrawPlayer(rect->x, rect->y, rect->w, rect->h, &info, uiInfo.uiDC.realTime / 2);
ADDRLP4 608
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 608
INDIRP4
INDIRF4
ARGF4
ADDRLP4 608
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 608
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 608
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 $1017
ARGP4
ADDRGP4 uiInfo+212
INDIRI4
CNSTI4 2
DIVI4
ARGI4
ADDRGP4 UI_DrawPlayer
CALLV
pop
line 1340
;1339:
;1340:}
LABELV $1016
endproc UI_DrawPlayerModel 612 28
proc UI_DrawNetSource 8 40
line 1342
;1341:
;1342:static void UI_DrawNetSource(rectDef_t *rect, float scale, const vec4_t color, int textStyle) {
line 1343
;1343:	if (ui_netSource.integer < 0 || ui_netSource.integer >= numNetSources) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
LTI4 $1032
ADDRGP4 ui_netSource+12
INDIRI4
ADDRGP4 numNetSources
INDIRI4
LTI4 $1028
LABELV $1032
line 1344
;1344:		ui_netSource.integer = 0;
ADDRGP4 ui_netSource+12
CNSTI4 0
ASGNI4
line 1345
;1345:	}
LABELV $1028
line 1346
;1346:	Text_Paint(rect->x, rect->y, scale, color, va("Source: %s", netSources[ui_netSource.integer]), 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
ADDRGP4 $1034
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1347
;1347:}
LABELV $1027
endproc UI_DrawNetSource 8 40
proc UI_DrawNetMapPreview 8 24
line 1349
;1348:
;1349:static void UI_DrawNetMapPreview(rectDef_t *rect, float scale, const vec4_t color) {
line 1351
;1350:
;1351:	if (uiInfo.serverStatus.currentServerPreview > 0) {
ADDRGP4 uiInfo+5387364+10428
INDIRI4
CNSTI4 0
LEI4 $1037
line 1352
;1352:		UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.serverStatus.currentServerPreview, WIDESCREEN_STRETCH);
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
ADDRGP4 uiInfo+5387364+10428
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1353
;1353:	} else {
ADDRGP4 $1038
JUMPV
LABELV $1037
line 1354
;1354:		UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, trap_R_RegisterShaderNoMip("menu/art/unknownmap"), WIDESCREEN_STRETCH);
ADDRGP4 $964
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
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1355
;1355:	}
LABELV $1038
line 1356
;1356:}
LABELV $1036
endproc UI_DrawNetMapPreview 8 24
proc UI_DrawNetMapCinematic 4 24
line 1358
;1357:
;1358:static void UI_DrawNetMapCinematic(rectDef_t *rect, float scale, const vec4_t color) {
line 1359
;1359:	if (ui_currentNetMap.integer < 0 || ui_currentNetMap.integer > uiInfo.mapCount) {
ADDRGP4 ui_currentNetMap+12
INDIRI4
CNSTI4 0
LTI4 $1049
ADDRGP4 ui_currentNetMap+12
INDIRI4
ADDRGP4 uiInfo+5364156
INDIRI4
LEI4 $1044
LABELV $1049
line 1360
;1360:		ui_currentNetMap.integer = 0;
ADDRGP4 ui_currentNetMap+12
CNSTI4 0
ASGNI4
line 1361
;1361:		trap_Cvar_Set("ui_currentNetMap", "0");
ADDRGP4 $947
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1362
;1362:	}
LABELV $1044
line 1364
;1363:	
;1364:	if (uiInfo.serverStatus.currentServerCinematic >= 0) {
ADDRGP4 uiInfo+5387364+10432
INDIRI4
CNSTI4 0
LTI4 $1051
line 1365
;1365:		trap_CIN_RunCinematic(uiInfo.serverStatus.currentServerCinematic);
ADDRGP4 uiInfo+5387364+10432
INDIRI4
ARGI4
ADDRGP4 trap_CIN_RunCinematic
CALLI4
pop
line 1366
;1366:		UI_DrawCinematic(uiInfo.serverStatus.currentServerCinematic, rect->x, rect->y, rect->w, rect->h, WIDESCREEN_STRETCH);
ADDRGP4 uiInfo+5387364+10432
INDIRI4
ARGI4
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
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawCinematic
CALLV
pop
line 1367
;1367:	} else {
ADDRGP4 $1052
JUMPV
LABELV $1051
line 1368
;1368:		UI_DrawNetMapPreview(rect, scale, color);
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
line 1369
;1369:	}
LABELV $1052
line 1370
;1370:}
LABELV $1043
endproc UI_DrawNetMapCinematic 4 24
proc UI_DrawNetFilter 8 40
line 1374
;1371:
;1372:
;1373:
;1374:static void UI_DrawNetFilter(rectDef_t *rect, float scale, const vec4_t color, int textStyle) {
line 1375
;1375:	if (ui_serverFilterType.integer < 0 || ui_serverFilterType.integer >= numServerFilters) {
ADDRGP4 ui_serverFilterType+12
INDIRI4
CNSTI4 0
LTI4 $1064
ADDRGP4 ui_serverFilterType+12
INDIRI4
ADDRGP4 numServerFilters
INDIRI4
LTI4 $1060
LABELV $1064
line 1376
;1376:		ui_serverFilterType.integer = 0;
ADDRGP4 ui_serverFilterType+12
CNSTI4 0
ASGNI4
line 1377
;1377:	}
LABELV $1060
line 1378
;1378:	Text_Paint(rect->x, rect->y, scale, color, va("Filter: %s", serverFilters[ui_serverFilterType.integer].description), 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
ADDRGP4 $1066
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1379
;1379:}
LABELV $1059
endproc UI_DrawNetFilter 8 40
proc UI_DrawTier 20 40
line 1382
;1380:
;1381:
;1382:static void UI_DrawTier(rectDef_t *rect, float scale, const vec4_t color, int textStyle) {
line 1384
;1383:	int i;
;1384:	i = trap_Cvar_VariableValue("ui_currentTier");
ADDRGP4 $1069
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
line 1385
;1385:	if (i < 0 || i >= uiInfo.tierCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1073
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5376960
INDIRI4
LTI4 $1070
LABELV $1073
line 1386
;1386:		i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1387
;1387:	}
LABELV $1070
line 1388
;1388:	Text_Paint(rect->x, rect->y, scale, color, va("Tier: %s", uiInfo.tierList[i].tierName), 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
ADDRGP4 $1074
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 uiInfo+5376964
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1389
;1389:}
LABELV $1068
endproc UI_DrawTier 20 40
proc UI_DrawTierMap 28 24
line 1391
;1390:
;1391:static void UI_DrawTierMap(rectDef_t *rect, int index) {
line 1393
;1392:	int i;
;1393:	i = trap_Cvar_VariableValue("ui_currentTier");
ADDRGP4 $1069
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
line 1394
;1394:	if (i < 0 || i >= uiInfo.tierCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1080
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5376960
INDIRI4
LTI4 $1077
LABELV $1080
line 1395
;1395:		i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1396
;1396:	}
LABELV $1077
line 1398
;1397:
;1398:	if (uiInfo.tierList[i].mapHandles[index] == -1) {
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 uiInfo+5376964+28
ADDP4
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1081
line 1399
;1399:		uiInfo.tierList[i].mapHandles[index] = trap_R_RegisterShaderNoMip(va("levelshots/%s", uiInfo.tierList[i].maps[index]));
ADDRGP4 $1087
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
ADDRGP4 uiInfo+5376964+4
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
ADDRGP4 uiInfo+5376964+28
ADDP4
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 1400
;1400:	}
LABELV $1081
line 1402
;1401:
;1402:	UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.tierList[i].mapHandles[index], WIDESCREEN_STRETCH);
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
ADDRGP4 uiInfo+5376964+28
ADDP4
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1403
;1403:}
LABELV $1076
endproc UI_DrawTierMap 28 24
proc UI_EnglishMapName 8 8
line 1405
;1404:
;1405:static const char *UI_EnglishMapName(const char *map) {
line 1407
;1406:	int i;
;1407:	for (i = 0; i < uiInfo.mapCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1096
JUMPV
LABELV $1093
line 1408
;1408:		if (Q_stricmp(map, uiInfo.mapList[i].mapLoadName) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+4
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
NEI4 $1098
line 1409
;1409:			return uiInfo.mapList[i].mapName;
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160
ADDP4
INDIRP4
RETP4
ADDRGP4 $1092
JUMPV
LABELV $1098
line 1411
;1410:		}
;1411:	}
LABELV $1094
line 1407
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1096
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5364156
INDIRI4
LTI4 $1093
line 1412
;1412:	return "";
ADDRGP4 $114
RETP4
LABELV $1092
endproc UI_EnglishMapName 8 8
proc UI_DrawTierMapName 32 40
line 1415
;1413:}
;1414:
;1415:static void UI_DrawTierMapName(rectDef_t *rect, float scale, const vec4_t color, int textStyle) {
line 1417
;1416:	int i, j;
;1417:	i = trap_Cvar_VariableValue("ui_currentTier");
ADDRGP4 $1069
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
line 1418
;1418:	if (i < 0 || i >= uiInfo.tierCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1107
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5376960
INDIRI4
LTI4 $1104
LABELV $1107
line 1419
;1419:		i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1420
;1420:	}
LABELV $1104
line 1421
;1421:	j = trap_Cvar_VariableValue("ui_currentMap");
ADDRGP4 $949
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
line 1422
;1422:	if (j < 0 || j >= MAPS_PER_TIER) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $1110
ADDRLP4 4
INDIRI4
CNSTI4 3
LTI4 $1108
LABELV $1110
line 1423
;1423:		j = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1424
;1424:	}
LABELV $1108
line 1426
;1425:
;1426:	Text_Paint(rect->x, rect->y, scale, color, UI_EnglishMapName(uiInfo.tierList[i].maps[j]), 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 40
MULI4
ADDRGP4 uiInfo+5376964+4
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1427
;1427:}
LABELV $1103
endproc UI_DrawTierMapName 32 40
proc UI_DrawTierGameType 28 40
line 1429
;1428:
;1429:static void UI_DrawTierGameType(rectDef_t *rect, float scale, const vec4_t color, int textStyle) {
line 1431
;1430:	int i, j;
;1431:	i = trap_Cvar_VariableValue("ui_currentTier");
ADDRGP4 $1069
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
line 1432
;1432:	if (i < 0 || i >= uiInfo.tierCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1117
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5376960
INDIRI4
LTI4 $1114
LABELV $1117
line 1433
;1433:		i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1434
;1434:	}
LABELV $1114
line 1435
;1435:	j = trap_Cvar_VariableValue("ui_currentMap");
ADDRGP4 $949
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
line 1436
;1436:	if (j < 0 || j >= MAPS_PER_TIER) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $1120
ADDRLP4 4
INDIRI4
CNSTI4 3
LTI4 $1118
LABELV $1120
line 1437
;1437:		j = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1438
;1438:	}
LABELV $1118
line 1440
;1439:
;1440:	Text_Paint(rect->x, rect->y, scale, color, uiInfo.gameTypes[uiInfo.tierList[i].gameTypes[j]].gameType, 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
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
ADDRGP4 uiInfo+5376964+16
ADDP4
ADDP4
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359512
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1441
;1441:}
LABELV $1113
endproc UI_DrawTierGameType 28 40
proc UI_AIFromName 8 8
line 1443
;1442:
;1443:static const char *UI_AIFromName(const char *name) {
line 1445
;1444:	int j;
;1445:	for (j = 0; j < uiInfo.aliasCount; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1128
JUMPV
LABELV $1125
line 1446
;1446:		if (Q_stricmp(uiInfo.aliasList[j].name, name) == 0) {
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+5355920
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
NEI4 $1130
line 1447
;1447:			return uiInfo.aliasList[j].ai;
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+5355920+4
ADDP4
INDIRP4
RETP4
ADDRGP4 $1124
JUMPV
LABELV $1130
line 1449
;1448:		}
;1449:	}
LABELV $1126
line 1445
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1128
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5355916
INDIRI4
LTI4 $1125
line 1450
;1450:	return "Sarge";
ADDRGP4 $1135
RETP4
LABELV $1124
endproc UI_AIFromName 8 8
data
align 4
LABELV updateOpponentModel
byte 4 1
bss
align 4
LABELV $1137
skip 1276
code
proc UI_DrawOpponent 416 28
line 1454
;1451:}
;1452:
;1453:static qboolean updateOpponentModel = qtrue;
;1454:static void UI_DrawOpponent(rectDef_t *rect) {
line 1462
;1455:	static playerInfo_t info2;
;1456:	char model[MAX_QPATH];
;1457:	char headmodel[MAX_QPATH];
;1458:	char team[256];
;1459:	vec3_t	viewangles;
;1460:	vec3_t	moveangles;
;1461:
;1462:	if (updateOpponentModel) {
ADDRGP4 updateOpponentModel
INDIRI4
CNSTI4 0
EQI4 $1138
line 1464
;1463:
;1464:		Q_strncpyz(model, UI_Cvar_VariableString("ui_opponentModel"), sizeof(model));
ADDRGP4 $1140
ARGP4
ADDRLP4 408
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 408
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1465
;1465:		Q_strncpyz(headmodel, UI_Cvar_VariableString("ui_opponentModel"), sizeof(headmodel));
ADDRGP4 $1140
ARGP4
ADDRLP4 412
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 64
ARGP4
ADDRLP4 412
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1466
;1466:		team[0] = '\0';
ADDRLP4 152
CNSTI1 0
ASGNI1
line 1468
;1467:
;1468:		memset(&info2, 0, sizeof(playerInfo_t));
ADDRGP4 $1137
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1276
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1469
;1469:		viewangles[YAW] = 180 - 10;
ADDRLP4 128+4
CNSTF4 1126825984
ASGNF4
line 1470
;1470:		viewangles[PITCH] = 0;
ADDRLP4 128
CNSTF4 0
ASGNF4
line 1471
;1471:		viewangles[ROLL] = 0;
ADDRLP4 128+8
CNSTF4 0
ASGNF4
line 1472
;1472:		VectorClear(moveangles);
ADDRLP4 140
CNSTF4 0
ASGNF4
ADDRLP4 140+4
CNSTF4 0
ASGNF4
ADDRLP4 140+8
CNSTF4 0
ASGNF4
line 1473
;1473:		UI_PlayerInfo_SetModel(&info2, model, headmodel, "");
ADDRGP4 $1137
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 64
ARGP4
ADDRGP4 $114
ARGP4
ADDRGP4 UI_PlayerInfo_SetModel
CALLV
pop
line 1474
;1474:		UI_PlayerInfo_SetInfo(&info2, LEGS_IDLE, TORSO_STAND, viewangles, vec3_origin, WP_MACHINEGUN, qfalse);
ADDRGP4 $1137
ARGP4
CNSTI4 22
ARGI4
CNSTI4 11
ARGI4
ADDRLP4 128
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
line 1475
;1475:		UI_RegisterClientModelname(&info2, model, headmodel, team);
ADDRGP4 $1137
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 64
ARGP4
ADDRLP4 152
ARGP4
ADDRGP4 UI_RegisterClientModelname
CALLI4
pop
line 1476
;1476:		updateOpponentModel = qfalse;
ADDRGP4 updateOpponentModel
CNSTI4 0
ASGNI4
line 1477
;1477:	}
LABELV $1138
line 1479
;1478:
;1479:	UI_DrawPlayer(rect->x, rect->y, rect->w, rect->h, &info2, uiInfo.uiDC.realTime / 2);
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
ADDRGP4 $1137
ARGP4
ADDRGP4 uiInfo+212
INDIRI4
CNSTI4 2
DIVI4
ARGI4
ADDRGP4 UI_DrawPlayer
CALLV
pop
line 1481
;1480:
;1481:}
LABELV $1136
endproc UI_DrawOpponent 416 28
proc UI_NextOpponent 24 8
line 1483
;1482:
;1483:static void UI_NextOpponent() {
line 1484
;1484:	int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1147
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
line 1485
;1485:	int j = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $712
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
line 1486
;1486:	i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1487
;1487:	if (i >= uiInfo.teamCount) {
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5356688
INDIRI4
LTI4 $1148
line 1488
;1488:		i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1489
;1489:	}
LABELV $1148
line 1490
;1490:	if (i == j) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $1151
line 1491
;1491:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1492
;1492:		if (i >= uiInfo.teamCount) {
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5356688
INDIRI4
LTI4 $1153
line 1493
;1493:			i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1494
;1494:		}
LABELV $1153
line 1495
;1495:	}
LABELV $1151
line 1496
;1496:	trap_Cvar_Set("ui_opponentName", uiInfo.teamList[i].teamName);
ADDRGP4 $1147
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1497
;1497:}
LABELV $1146
endproc UI_NextOpponent 24 8
proc UI_PriorOpponent 24 8
line 1499
;1498:
;1499:static void UI_PriorOpponent() {
line 1500
;1500:	int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1147
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
line 1501
;1501:	int j = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $712
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
line 1502
;1502:	i--;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1503
;1503:	if (i < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1158
line 1504
;1504:		i = uiInfo.teamCount - 1;
ADDRLP4 0
ADDRGP4 uiInfo+5356688
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1505
;1505:	}
LABELV $1158
line 1506
;1506:	if (i == j) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $1161
line 1507
;1507:		i--;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1508
;1508:		if (i < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1163
line 1509
;1509:			i = uiInfo.teamCount - 1;
ADDRLP4 0
ADDRGP4 uiInfo+5356688
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1510
;1510:		}
LABELV $1163
line 1511
;1511:	}
LABELV $1161
line 1512
;1512:	trap_Cvar_Set("ui_opponentName", uiInfo.teamList[i].teamName);
ADDRGP4 $1147
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1513
;1513:}
LABELV $1157
endproc UI_PriorOpponent 24 8
proc UI_DrawPlayerLogo 44 24
line 1515
;1514:
;1515:static void	UI_DrawPlayerLogo(rectDef_t *rect, const vec3_t color) {
line 1516
;1516:	int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $712
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
line 1518
;1517:
;1518:	if (uiInfo.teamList[i].teamIcon == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+28
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1168
line 1519
;1519:		uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356692+28
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1520
;1520:		uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal", uiInfo.teamList[i].imageName));
ADDRGP4 $780
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356692+32
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1521
;1521:		uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $785
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356692+36
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1522
;1522:	}
LABELV $1168
line 1524
;1523:
;1524:	trap_R_SetColor(color);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1525
;1525:	UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon, WIDESCREEN_STRETCH);
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
ADDRGP4 uiInfo+5356692+28
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1526
;1526:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1527
;1527:}
LABELV $1167
endproc UI_DrawPlayerLogo 44 24
proc UI_DrawPlayerLogoMetal 44 24
line 1529
;1528:
;1529:static void	UI_DrawPlayerLogoMetal(rectDef_t *rect, const vec3_t color) {
line 1530
;1530:	int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $712
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
line 1531
;1531:	if (uiInfo.teamList[i].teamIcon == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+28
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1187
line 1532
;1532:		uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356692+28
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1533
;1533:		uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal", uiInfo.teamList[i].imageName));
ADDRGP4 $780
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356692+32
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1534
;1534:		uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $785
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356692+36
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1535
;1535:	}
LABELV $1187
line 1537
;1536:
;1537:	trap_R_SetColor(color);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1538
;1538:	UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon_Metal, WIDESCREEN_STRETCH);
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
ADDRGP4 uiInfo+5356692+32
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1539
;1539:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1540
;1540:}
LABELV $1186
endproc UI_DrawPlayerLogoMetal 44 24
proc UI_DrawPlayerLogoName 44 24
line 1542
;1541:
;1542:static void	UI_DrawPlayerLogoName(rectDef_t *rect, const vec3_t color) {
line 1543
;1543:	int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $712
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
line 1544
;1544:	if (uiInfo.teamList[i].teamIcon == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+28
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1206
line 1545
;1545:		uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356692+28
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1546
;1546:		uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal", uiInfo.teamList[i].imageName));
ADDRGP4 $780
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356692+32
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1547
;1547:		uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $785
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356692+36
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1548
;1548:	}
LABELV $1206
line 1550
;1549:
;1550:	trap_R_SetColor(color);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1551
;1551:	UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon_Name, WIDESCREEN_STRETCH);
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
ADDRGP4 uiInfo+5356692+36
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1552
;1552:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1553
;1553:}
LABELV $1205
endproc UI_DrawPlayerLogoName 44 24
proc UI_DrawOpponentLogo 44 24
line 1555
;1554:
;1555:static void	UI_DrawOpponentLogo(rectDef_t *rect, const vec3_t color) {
line 1556
;1556:	int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1147
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
line 1557
;1557:	if (uiInfo.teamList[i].teamIcon == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+28
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1225
line 1558
;1558:		uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356692+28
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1559
;1559:		uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal", uiInfo.teamList[i].imageName));
ADDRGP4 $780
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356692+32
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1560
;1560:		uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $785
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356692+36
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1561
;1561:	}
LABELV $1225
line 1563
;1562:
;1563:	trap_R_SetColor(color);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1564
;1564:	UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon, WIDESCREEN_STRETCH);
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
ADDRGP4 uiInfo+5356692+28
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1565
;1565:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1566
;1566:}
LABELV $1224
endproc UI_DrawOpponentLogo 44 24
proc UI_DrawOpponentLogoMetal 44 24
line 1568
;1567:
;1568:static void	UI_DrawOpponentLogoMetal(rectDef_t *rect, const vec3_t color) {
line 1569
;1569:	int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1147
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
line 1570
;1570:	if (uiInfo.teamList[i].teamIcon == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+28
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1244
line 1571
;1571:		uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356692+28
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1572
;1572:		uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal", uiInfo.teamList[i].imageName));
ADDRGP4 $780
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356692+32
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1573
;1573:		uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $785
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356692+36
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1574
;1574:	}
LABELV $1244
line 1576
;1575:
;1576:	trap_R_SetColor(color);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1577
;1577:	UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon_Metal, WIDESCREEN_STRETCH);
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
ADDRGP4 uiInfo+5356692+32
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1578
;1578:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1579
;1579:}
LABELV $1243
endproc UI_DrawOpponentLogoMetal 44 24
proc UI_DrawOpponentLogoName 44 24
line 1581
;1580:
;1581:static void	UI_DrawOpponentLogoName(rectDef_t *rect, const vec3_t color) {
line 1582
;1582:	int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1147
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
line 1583
;1583:	if (uiInfo.teamList[i].teamIcon == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+28
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1263
line 1584
;1584:		uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356692+28
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1585
;1585:		uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal", uiInfo.teamList[i].imageName));
ADDRGP4 $780
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356692+32
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1586
;1586:		uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $785
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356692+36
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1587
;1587:	}
LABELV $1263
line 1589
;1588:
;1589:	trap_R_SetColor(color);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1590
;1590:	UI_DrawHandlePic(rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon_Name, WIDESCREEN_STRETCH);
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
ADDRGP4 uiInfo+5356692+36
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1591
;1591:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1592
;1592:}
LABELV $1262
endproc UI_DrawOpponentLogoName 44 24
proc UI_DrawAllMapsSelection 16 40
line 1594
;1593:
;1594:static void UI_DrawAllMapsSelection(rectDef_t *rect, float scale, const vec4_t color, int textStyle, qboolean net) {
line 1595
;1595:	int map = (net) ? ui_currentNetMap.integer : ui_currentMap.integer;
ADDRFP4 16
INDIRI4
CNSTI4 0
EQI4 $1285
ADDRLP4 4
ADDRGP4 ui_currentNetMap+12
INDIRI4
ASGNI4
ADDRGP4 $1286
JUMPV
LABELV $1285
ADDRLP4 4
ADDRGP4 ui_currentMap+12
INDIRI4
ASGNI4
LABELV $1286
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1596
;1596:	if (map >= 0 && map < uiInfo.mapCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1287
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5364156
INDIRI4
GEI4 $1287
line 1597
;1597:		Text_Paint(rect->x, rect->y, scale, color, uiInfo.mapList[map].mapName, 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
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
ADDRGP4 uiInfo+5364160
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1598
;1598:	}
LABELV $1287
line 1599
;1599:}
LABELV $1281
endproc UI_DrawAllMapsSelection 16 40
proc UI_DrawOpponentName 8 40
line 1601
;1600:
;1601:static void UI_DrawOpponentName(rectDef_t *rect, float scale, const vec4_t color, int textStyle) {
line 1602
;1602:	Text_Paint(rect->x, rect->y, scale, color, UI_Cvar_VariableString("ui_opponentName"), 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
ADDRGP4 $1147
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1603
;1603:}
LABELV $1291
endproc UI_DrawOpponentName 8 40
proc UI_OwnerDrawWidth 64 20
line 1606
;1604:
;1605:
;1606:static float UI_OwnerDrawWidth(int ownerDraw, float scale, int fontIndex, int widescreen) { //, rectDef_t menuRect) {
line 1609
;1607:	int i, h, value;
;1608:	const char *text;
;1609:	const char *s = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 1611
;1610:
;1611:	switch (ownerDraw) {
ADDRLP4 20
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 513
LTI4 $1294
ADDRLP4 20
INDIRI4
CNSTI4 529
GTI4 $1333
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1334-2052
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1334
address $1295
address $1294
address $1296
address $1294
address $1299
address $1304
address $1294
address $1312
address $1294
address $1294
address $1294
address $1294
address $1294
address $1294
address $1294
address $1294
address $1294
code
LABELV $1333
ADDRLP4 24
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 539
EQI4 $1330
ADDRLP4 24
INDIRI4
CNSTI4 542
EQI4 $1325
ADDRGP4 $1294
JUMPV
LABELV $1295
line 1613
;1612:	case UI_HANDICAP:
;1613:		h = Com_Clamp(5, 100, trap_Cvar_VariableValue("handicap"));
ADDRGP4 $710
ARGP4
ADDRLP4 28
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1084227584
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 32
INDIRF4
CVFI4 4
ASGNI4
line 1614
;1614:		i = 20 - h / 5;
ADDRLP4 4
CNSTI4 20
ADDRLP4 8
INDIRI4
CNSTI4 5
DIVI4
SUBI4
ASGNI4
line 1615
;1615:		s = handicapValues[i];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 handicapValues
ADDP4
INDIRP4
ASGNP4
line 1616
;1616:		break;
ADDRGP4 $1294
JUMPV
LABELV $1296
line 1618
;1617:	case UI_GAMETYPE:
;1618:		s = uiInfo.gameTypes[ui_gameType.integer].gameType;
ADDRLP4 0
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359512
ADDP4
INDIRP4
ASGNP4
line 1619
;1619:		break;
ADDRGP4 $1294
JUMPV
LABELV $1299
line 1621
;1620:	case UI_SKILL:
;1621:		i = trap_Cvar_VariableValue("g_spSkill");
ADDRGP4 $885
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
line 1622
;1622:		if (i < 1 || i > numSkillLevels) {
ADDRLP4 40
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 1
LTI4 $1302
ADDRLP4 40
INDIRI4
ADDRGP4 numSkillLevels
INDIRI4
LEI4 $1300
LABELV $1302
line 1623
;1623:			i = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1624
;1624:		}
LABELV $1300
line 1625
;1625:		s = skillLevels[i - 1];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 skillLevels-4
ADDP4
INDIRP4
ASGNP4
line 1626
;1626:		break;
ADDRGP4 $1294
JUMPV
LABELV $1304
line 1628
;1627:	case UI_NETSOURCE:
;1628:		if (ui_netSource.integer < 0 || ui_netSource.integer >= numNetSources) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
LTI4 $1309
ADDRGP4 ui_netSource+12
INDIRI4
ADDRGP4 numNetSources
INDIRI4
LTI4 $1305
LABELV $1309
line 1629
;1629:			ui_netSource.integer = 0;
ADDRGP4 ui_netSource+12
CNSTI4 0
ASGNI4
line 1630
;1630:		}
LABELV $1305
line 1631
;1631:		s = va("Source: %s", netSources[ui_netSource.integer]);
ADDRGP4 $1034
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 netSources
ADDP4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 44
INDIRP4
ASGNP4
line 1632
;1632:		break;
ADDRGP4 $1294
JUMPV
LABELV $1312
line 1634
;1633:	case UI_NETFILTER:
;1634:		if (ui_serverFilterType.integer < 0 || ui_serverFilterType.integer >= numServerFilters) {
ADDRGP4 ui_serverFilterType+12
INDIRI4
CNSTI4 0
LTI4 $1317
ADDRGP4 ui_serverFilterType+12
INDIRI4
ADDRGP4 numServerFilters
INDIRI4
LTI4 $1313
LABELV $1317
line 1635
;1635:			ui_serverFilterType.integer = 0;
ADDRGP4 ui_serverFilterType+12
CNSTI4 0
ASGNI4
line 1636
;1636:		}
LABELV $1313
line 1637
;1637:		s = va("Filter: %s", serverFilters[ui_serverFilterType.integer].description);
ADDRGP4 $1066
ARGP4
ADDRGP4 ui_serverFilterType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 serverFilters
ADDP4
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 48
INDIRP4
ASGNP4
line 1638
;1638:		break;
ADDRGP4 $1294
JUMPV
line 1640
;1639:	case UI_TIER:
;1640:		break;
line 1642
;1641:	case UI_TIER_MAPNAME:
;1642:		break;
line 1644
;1643:	case UI_TIER_GAMETYPE:
;1644:		break;
line 1646
;1645:	case UI_ALLMAPS_SELECTION:
;1646:		break;
line 1648
;1647:	case UI_OPPONENT_NAME:
;1648:		break;
LABELV $1325
line 1650
;1649:	case UI_KEYBINDSTATUS:
;1650:		if (Display_KeyBindPending()) {
ADDRLP4 52
ADDRGP4 Display_KeyBindPending
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $1326
line 1651
;1651:			s = "Waiting for new key... Press ESCAPE to cancel";
ADDRLP4 0
ADDRGP4 $1328
ASGNP4
line 1652
;1652:		} else {
ADDRGP4 $1294
JUMPV
LABELV $1326
line 1653
;1653:			s = "Press ENTER or CLICK to change, Press BACKSPACE to clear";
ADDRLP4 0
ADDRGP4 $1329
ASGNP4
line 1654
;1654:		}
line 1655
;1655:		break;
ADDRGP4 $1294
JUMPV
LABELV $1330
line 1657
;1656:	case UI_SERVERREFRESHDATE:
;1657:		s = UI_Cvar_VariableString(va("ui_lastServerRefresh_%i", ui_netSource.integer));
ADDRGP4 $1331
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 60
INDIRP4
ASGNP4
line 1658
;1658:		break;
line 1660
;1659:	default:
;1660:		break;
LABELV $1294
line 1663
;1661:	}
;1662:
;1663:	if (s) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1336
line 1664
;1664:		return Text_Width(s, scale, 0, 1, WIDESCREEN_STRETCH);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 28
ADDRGP4 Text_Width
CALLF4
ASGNF4
ADDRLP4 28
INDIRF4
RETF4
ADDRGP4 $1292
JUMPV
LABELV $1336
line 1666
;1665:	}
;1666:	return 0;
CNSTF4 0
RETF4
LABELV $1292
endproc UI_OwnerDrawWidth 64 20
proc UI_DrawBotName 20 40
line 1669
;1667:}
;1668:
;1669:static void UI_DrawBotName(rectDef_t *rect, float scale, const vec4_t color, int textStyle) {
line 1670
;1670:	int value = uiInfo.botIndex;
ADDRLP4 0
ADDRGP4 uiInfo+5354376
INDIRI4
ASGNI4
line 1671
;1671:	int game = trap_Cvar_VariableValue("g_gametype");
ADDRGP4 $1340
ARGP4
ADDRLP4 12
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 1673
;1672:	const char *text;
;1673:	if (game >= GT_TEAM) {
ADDRLP4 4
INDIRI4
CNSTI4 3
LTI4 $1341
line 1674
;1674:		text = uiInfo.characterList[value].name;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380
ADDP4
INDIRP4
ASGNP4
line 1675
;1675:	} else {
ADDRGP4 $1342
JUMPV
LABELV $1341
line 1676
;1676:		text = UI_GetBotNameByNumber(value);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 UI_GetBotNameByNumber
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 1677
;1677:	}
LABELV $1342
line 1678
;1678:	Text_Paint(rect->x, rect->y, scale, color, text, 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
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
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1679
;1679:}
LABELV $1338
endproc UI_DrawBotName 20 40
proc UI_DrawBotSkill 4 40
line 1681
;1680:
;1681:static void UI_DrawBotSkill(rectDef_t *rect, float scale, const vec4_t color, int textStyle) {
line 1682
;1682:	if (uiInfo.skillIndex >= 0 && uiInfo.skillIndex < numSkillLevels) {
ADDRGP4 uiInfo+5377604
INDIRI4
CNSTI4 0
LTI4 $1345
ADDRGP4 uiInfo+5377604
INDIRI4
ADDRGP4 numSkillLevels
INDIRI4
GEI4 $1345
line 1683
;1683:		Text_Paint(rect->x, rect->y, scale, color, skillLevels[uiInfo.skillIndex], 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
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
ADDRGP4 uiInfo+5377604
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1684
;1684:	}
LABELV $1345
line 1685
;1685:}
LABELV $1344
endproc UI_DrawBotSkill 4 40
proc UI_DrawRedBlue 8 40
line 1687
;1686:
;1687:static void UI_DrawRedBlue(rectDef_t *rect, float scale, const vec4_t color, int textStyle) {
line 1688
;1688:	Text_Paint(rect->x, rect->y, scale, color, (uiInfo.redBlue == 0) ? "Red" : "Blue", 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
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
ADDRGP4 uiInfo+5359772
INDIRI4
CNSTI4 0
NEI4 $1353
ADDRLP4 0
ADDRGP4 $901
ASGNP4
ADDRGP4 $1354
JUMPV
LABELV $1353
ADDRLP4 0
ADDRGP4 $900
ASGNP4
LABELV $1354
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1689
;1689:}
LABELV $1350
endproc UI_DrawRedBlue 8 40
proc UI_DrawCrosshair 4 24
line 1691
;1690:
;1691:static void UI_DrawCrosshair(rectDef_t *rect, float scale, const vec4_t color) {
line 1692
;1692:	if (!uiInfo.currentCrosshair) {
ADDRGP4 uiInfo+5407576
INDIRI4
CNSTI4 0
NEI4 $1356
line 1693
;1693:		return;
ADDRGP4 $1355
JUMPV
LABELV $1356
line 1695
;1694:	}
;1695:	trap_R_SetColor(color);
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1696
;1696:	if (uiInfo.currentCrosshair < 0 || uiInfo.currentCrosshair >= NUM_CROSSHAIRS) {
ADDRGP4 uiInfo+5407576
INDIRI4
CNSTI4 0
LTI4 $1363
ADDRGP4 uiInfo+5407576
INDIRI4
CNSTI4 30
LTI4 $1359
LABELV $1363
line 1697
;1697:		uiInfo.currentCrosshair = 0;
ADDRGP4 uiInfo+5407576
CNSTI4 0
ASGNI4
line 1698
;1698:	}
LABELV $1359
line 1699
;1699:	UI_DrawHandlePic(rect->x, rect->y - rect->h, rect->w, rect->h, uiInfo.uiDC.Assets.crosshairShader[uiInfo.currentCrosshair], WIDESCREEN_STRETCH);
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
ADDRGP4 uiInfo+5407576
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+236+5342640
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1700
;1700:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1701
;1701:}
LABELV $1355
endproc UI_DrawCrosshair 4 24
proc UI_BuildPlayerList 4176 12
line 1708
;1702:
;1703:/*
;1704:===============
;1705:UI_BuildPlayerList
;1706:===============
;1707:*/
;1708:static void UI_BuildPlayerList() {
line 1713
;1709:	uiClientState_t	cs;
;1710:	int		n, count, team, team2, playerTeamNumber;
;1711:	char	info[MAX_INFO_STRING];
;1712:
;1713:	trap_GetClientState(&cs);
ADDRLP4 1040
ARGP4
ADDRGP4 trap_GetClientState
CALLV
pop
line 1714
;1714:	trap_GetConfigString(CS_PLAYERS + cs.clientNum, info, MAX_INFO_STRING);
ADDRLP4 1040+8
INDIRI4
CNSTI4 529
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 1715
;1715:	uiInfo.playerNumber = cs.clientNum;
ADDRGP4 uiInfo+5359796
ADDRLP4 1040+8
INDIRI4
ASGNI4
line 1716
;1716:	uiInfo.teamLeader = atoi(Info_ValueForKey(info, "tl"));
ADDRLP4 4
ARGP4
ADDRGP4 $1373
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
ADDRGP4 uiInfo+5359800
ADDRLP4 4132
INDIRI4
ASGNI4
line 1717
;1717:	team = atoi(Info_ValueForKey(info, "t"));
ADDRLP4 4
ARGP4
ADDRGP4 $1374
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
line 1718
;1718:	trap_GetConfigString(CS_SERVERINFO, info, sizeof(info));
CNSTI4 0
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 1719
;1719:	count = atoi(Info_ValueForKey(info, "sv_maxclients"));
ADDRLP4 4
ARGP4
ADDRGP4 $1375
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
line 1720
;1720:	uiInfo.playerCount = 0;
ADDRGP4 uiInfo+5359776
CNSTI4 0
ASGNI4
line 1721
;1721:	uiInfo.myTeamCount = 0;
ADDRGP4 uiInfo+5359780
CNSTI4 0
ASGNI4
line 1722
;1722:	playerTeamNumber = 0;
ADDRLP4 4124
CNSTI4 0
ASGNI4
line 1723
;1723:	for (n = 0; n < count; n++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1381
JUMPV
LABELV $1378
line 1724
;1724:		trap_GetConfigString(CS_PLAYERS + n, info, MAX_INFO_STRING);
ADDRLP4 0
INDIRI4
CNSTI4 529
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 1726
;1725:
;1726:		if (info[0]) {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1382
line 1727
;1727:			Q_strncpyz(uiInfo.playerNames[uiInfo.playerCount], Info_ValueForKey(info, "n"), MAX_NAME_LENGTH);
ADDRLP4 4
ARGP4
ADDRGP4 $1386
ARGP4
ADDRLP4 4152
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 uiInfo+5359776
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+5359804
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
line 1728
;1728:			Q_CleanStr(uiInfo.playerNames[uiInfo.playerCount]);
ADDRGP4 uiInfo+5359776
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+5359804
ADDP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1729
;1729:			uiInfo.playerCount++;
ADDRLP4 4156
ADDRGP4 uiInfo+5359776
ASGNP4
ADDRLP4 4156
INDIRP4
ADDRLP4 4156
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1730
;1730:			team2 = atoi(Info_ValueForKey(info, "t"));
ADDRLP4 4
ARGP4
ADDRGP4 $1374
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
line 1731
;1731:			if (team2 == team) {
ADDRLP4 1032
INDIRI4
ADDRLP4 1036
INDIRI4
NEI4 $1390
line 1732
;1732:				Q_strncpyz(uiInfo.teamNames[uiInfo.myTeamCount], Info_ValueForKey(info, "n"), MAX_NAME_LENGTH);
ADDRLP4 4
ARGP4
ADDRGP4 $1386
ARGP4
ADDRLP4 4168
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 uiInfo+5359780
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+5361852
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
line 1733
;1733:				Q_CleanStr(uiInfo.teamNames[uiInfo.myTeamCount]);
ADDRGP4 uiInfo+5359780
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+5361852
ADDP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1734
;1734:				uiInfo.teamClientNums[uiInfo.myTeamCount] = n;
ADDRGP4 uiInfo+5359780
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5363900
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1735
;1735:				if (uiInfo.playerNumber == n) {
ADDRGP4 uiInfo+5359796
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1398
line 1736
;1736:					playerTeamNumber = uiInfo.myTeamCount;
ADDRLP4 4124
ADDRGP4 uiInfo+5359780
INDIRI4
ASGNI4
line 1737
;1737:				}
LABELV $1398
line 1738
;1738:				uiInfo.myTeamCount++;
ADDRLP4 4172
ADDRGP4 uiInfo+5359780
ASGNP4
ADDRLP4 4172
INDIRP4
ADDRLP4 4172
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1739
;1739:			}
LABELV $1390
line 1740
;1740:		}
LABELV $1382
line 1741
;1741:	}
LABELV $1379
line 1723
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1381
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $1378
line 1743
;1742:
;1743:	if (!uiInfo.teamLeader) {
ADDRGP4 uiInfo+5359800
INDIRI4
CNSTI4 0
NEI4 $1403
line 1744
;1744:		trap_Cvar_Set("cg_selectedPlayer", va("%d", playerTeamNumber));
ADDRGP4 $727
ARGP4
ADDRLP4 4124
INDIRI4
ARGI4
ADDRLP4 4152
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1406
ARGP4
ADDRLP4 4152
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1745
;1745:	}
LABELV $1403
line 1747
;1746:
;1747:	n = trap_Cvar_VariableValue("cg_selectedPlayer");
ADDRGP4 $1406
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
line 1748
;1748:	if (n < 0 || n > uiInfo.myTeamCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1410
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5359780
INDIRI4
LEI4 $1407
LABELV $1410
line 1749
;1749:		n = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1750
;1750:	}
LABELV $1407
line 1751
;1751:	if (n < uiInfo.myTeamCount) {
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5359780
INDIRI4
GEI4 $1411
line 1752
;1752:		trap_Cvar_Set("cg_selectedPlayerName", uiInfo.teamNames[n]);
ADDRGP4 $1414
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+5361852
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1753
;1753:	}
LABELV $1411
line 1754
;1754:}
LABELV $1368
endproc UI_BuildPlayerList 4176 12
proc UI_DrawSelectedPlayer 16 40
line 1757
;1755:
;1756:
;1757:static void UI_DrawSelectedPlayer(rectDef_t *rect, float scale, const vec4_t color, int textStyle) {
line 1758
;1758:	if (uiInfo.uiDC.realTime > uiInfo.playerRefresh) {
ADDRGP4 uiInfo+212
INDIRI4
ADDRGP4 uiInfo+5359788
INDIRI4
LEI4 $1417
line 1759
;1759:		uiInfo.playerRefresh = uiInfo.uiDC.realTime + 3000;
ADDRGP4 uiInfo+5359788
ADDRGP4 uiInfo+212
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 1760
;1760:		UI_BuildPlayerList();
ADDRGP4 UI_BuildPlayerList
CALLV
pop
line 1761
;1761:	}
LABELV $1417
line 1762
;1762:	Text_Paint(rect->x, rect->y, scale, color, (uiInfo.teamLeader) ? UI_Cvar_VariableString("cg_selectedPlayerName") : UI_Cvar_VariableString("name"), 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
ADDRGP4 uiInfo+5359800
INDIRI4
CNSTI4 0
EQI4 $1426
ADDRGP4 $1414
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
ADDRGP4 $1427
JUMPV
LABELV $1426
ADDRGP4 $1424
ARGP4
ADDRLP4 8
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
LABELV $1427
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1763
;1763:}
LABELV $1416
endproc UI_DrawSelectedPlayer 16 40
proc UI_DrawServerRefreshDate 80 40
line 1765
;1764:
;1765:static void UI_DrawServerRefreshDate(rectDef_t *rect, float scale, const vec4_t color, int textStyle) {
line 1766
;1766:	if (uiInfo.serverStatus.refreshActive) {
ADDRGP4 uiInfo+5387364+2212
INDIRI4
CNSTI4 0
EQI4 $1429
line 1768
;1767:		vec4_t lowLight, newColor;
;1768:		lowLight[0] = 0.8 * color[0];
ADDRLP4 0
ADDRFP4 8
INDIRP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 1769
;1769:		lowLight[1] = 0.8 * color[1];
ADDRLP4 0+4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 1770
;1770:		lowLight[2] = 0.8 * color[2];
ADDRLP4 0+8
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 1771
;1771:		lowLight[3] = 0.8 * color[3];
ADDRLP4 0+12
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 1772
;1772:		LerpColor((vec_t *)color, lowLight, newColor, 0.5 + 0.5 * sin(uiInfo.uiDC.realTime / PULSE_DIVISOR));
ADDRGP4 uiInfo+212
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
line 1773
;1773:		Text_Paint(rect->x, rect->y, scale, newColor, va("Getting info for %d servers (ESC to cancel)", trap_LAN_GetServerCount(UI_SourceForLAN())), 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
ADDRLP4 36
ADDRGP4 UI_SourceForLAN
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRGP4 $1437
ARGP4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
INDIRF4
ARGF4
ADDRLP4 48
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
ADDRLP4 44
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1774
;1774:	} else {
ADDRGP4 $1430
JUMPV
LABELV $1429
line 1776
;1775:		char buff[64];
;1776:		Q_strncpyz(buff, UI_Cvar_VariableString(va("ui_lastServerRefresh_%i", ui_netSource.integer)), 64);
ADDRGP4 $1331
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
line 1777
;1777:		Text_Paint(rect->x, rect->y, scale, color, va("Refresh Time: %s", buff), 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
ADDRGP4 $1439
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1778
;1778:	}
LABELV $1430
line 1779
;1779:}
LABELV $1428
endproc UI_DrawServerRefreshDate 80 40
proc UI_DrawServerMOTD 24 32
line 1781
;1780:
;1781:static void UI_DrawServerMOTD(rectDef_t *rect, float scale, const vec4_t color) {
line 1782
;1782:	if (uiInfo.serverStatus.motdLen) {
ADDRGP4 uiInfo+5387364+10436
INDIRI4
CNSTI4 0
EQI4 $1441
line 1785
;1783:		float maxX;
;1784:
;1785:		if (uiInfo.serverStatus.motdWidth == -1) {
ADDRGP4 uiInfo+5387364+10440
INDIRI4
CNSTI4 -1
NEI4 $1445
line 1786
;1786:			uiInfo.serverStatus.motdWidth = 0;
ADDRGP4 uiInfo+5387364+10440
CNSTI4 0
ASGNI4
line 1787
;1787:			uiInfo.serverStatus.motdPaintX = rect->x + 1;
ADDRGP4 uiInfo+5387364+10444
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1788
;1788:			uiInfo.serverStatus.motdPaintX2 = -1;
ADDRGP4 uiInfo+5387364+10448
CNSTI4 -1
ASGNI4
line 1789
;1789:		}
LABELV $1445
line 1791
;1790:
;1791:		if (uiInfo.serverStatus.motdOffset > uiInfo.serverStatus.motdLen) {
ADDRGP4 uiInfo+5387364+10452
INDIRI4
ADDRGP4 uiInfo+5387364+10436
INDIRI4
LEI4 $1455
line 1792
;1792:			uiInfo.serverStatus.motdOffset = 0;
ADDRGP4 uiInfo+5387364+10452
CNSTI4 0
ASGNI4
line 1793
;1793:			uiInfo.serverStatus.motdPaintX = rect->x + 1;
ADDRGP4 uiInfo+5387364+10444
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1794
;1794:			uiInfo.serverStatus.motdPaintX2 = -1;
ADDRGP4 uiInfo+5387364+10448
CNSTI4 -1
ASGNI4
line 1795
;1795:		}
LABELV $1455
line 1797
;1796:
;1797:		if (uiInfo.uiDC.realTime > uiInfo.serverStatus.motdTime) {
ADDRGP4 uiInfo+212
INDIRI4
ADDRGP4 uiInfo+5387364+10456
INDIRI4
LEI4 $1467
line 1798
;1798:			uiInfo.serverStatus.motdTime = uiInfo.uiDC.realTime + 10;
ADDRGP4 uiInfo+5387364+10456
ADDRGP4 uiInfo+212
INDIRI4
CNSTI4 10
ADDI4
ASGNI4
line 1799
;1799:			if (uiInfo.serverStatus.motdPaintX <= rect->x + 2) {
ADDRGP4 uiInfo+5387364+10444
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
GTF4 $1475
line 1800
;1800:				if (uiInfo.serverStatus.motdOffset < uiInfo.serverStatus.motdLen) {
ADDRGP4 uiInfo+5387364+10452
INDIRI4
ADDRGP4 uiInfo+5387364+10436
INDIRI4
GEI4 $1479
line 1801
;1801:					uiInfo.serverStatus.motdPaintX += Text_Width(&uiInfo.serverStatus.motd[uiInfo.serverStatus.motdOffset], scale, 1, 1, WIDESCREEN_STRETCH) - 1;
ADDRGP4 uiInfo+5387364+10452
INDIRI4
ADDRGP4 uiInfo+5387364+10460
ADDP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 1
ARGI4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 Text_Width
CALLF4
ASGNF4
ADDRLP4 8
ADDRGP4 uiInfo+5387364+10444
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
SUBF4
ADDF4
CVFI4 4
ASGNI4
line 1802
;1802:					uiInfo.serverStatus.motdOffset++;
ADDRLP4 12
ADDRGP4 uiInfo+5387364+10452
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1803
;1803:				} else {
ADDRGP4 $1476
JUMPV
LABELV $1479
line 1804
;1804:					uiInfo.serverStatus.motdOffset = 0;
ADDRGP4 uiInfo+5387364+10452
CNSTI4 0
ASGNI4
line 1805
;1805:					if (uiInfo.serverStatus.motdPaintX2 >= 0) {
ADDRGP4 uiInfo+5387364+10448
INDIRI4
CNSTI4 0
LTI4 $1495
line 1806
;1806:						uiInfo.serverStatus.motdPaintX = uiInfo.serverStatus.motdPaintX2;
ADDRGP4 uiInfo+5387364+10444
ADDRGP4 uiInfo+5387364+10448
INDIRI4
ASGNI4
line 1807
;1807:					} else {
ADDRGP4 $1496
JUMPV
LABELV $1495
line 1808
;1808:						uiInfo.serverStatus.motdPaintX = rect->x + rect->w - 2;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 uiInfo+5387364+10444
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
line 1809
;1809:					}
LABELV $1496
line 1810
;1810:					uiInfo.serverStatus.motdPaintX2 = -1;
ADDRGP4 uiInfo+5387364+10448
CNSTI4 -1
ASGNI4
line 1811
;1811:				}
line 1812
;1812:			} else {
ADDRGP4 $1476
JUMPV
LABELV $1475
line 1814
;1813:				//serverStatus.motdPaintX--;
;1814:				uiInfo.serverStatus.motdPaintX -= 2;
ADDRLP4 4
ADDRGP4 uiInfo+5387364+10444
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 1815
;1815:				if (uiInfo.serverStatus.motdPaintX2 >= 0) {
ADDRGP4 uiInfo+5387364+10448
INDIRI4
CNSTI4 0
LTI4 $1509
line 1817
;1816:					//serverStatus.motdPaintX2--;
;1817:					uiInfo.serverStatus.motdPaintX2 -= 2;
ADDRLP4 8
ADDRGP4 uiInfo+5387364+10448
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 1818
;1818:				}
LABELV $1509
line 1819
;1819:			}
LABELV $1476
line 1820
;1820:		}
LABELV $1467
line 1822
;1821:
;1822:		maxX = rect->x + rect->w - 2;
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
line 1823
;1823:		Text_Paint_Limit(&maxX, uiInfo.serverStatus.motdPaintX, rect->y + rect->h - 3, scale, color, &uiInfo.serverStatus.motd[uiInfo.serverStatus.motdOffset], 0, 0);
ADDRLP4 0
ARGP4
ADDRGP4 uiInfo+5387364+10444
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
ADDRGP4 uiInfo+5387364+10452
INDIRI4
ADDRGP4 uiInfo+5387364+10460
ADDP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint_Limit
CALLV
pop
line 1824
;1824:		if (uiInfo.serverStatus.motdPaintX2 >= 0) {
ADDRGP4 uiInfo+5387364+10448
INDIRI4
CNSTI4 0
LTI4 $1521
line 1825
;1825:			float maxX2 = rect->x + rect->w - 2;
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
line 1826
;1826:			Text_Paint_Limit(&maxX2, uiInfo.serverStatus.motdPaintX2, rect->y + rect->h - 3, scale, color, uiInfo.serverStatus.motd, 0, uiInfo.serverStatus.motdOffset);
ADDRLP4 12
ARGP4
ADDRGP4 uiInfo+5387364+10448
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
ADDRGP4 uiInfo+5387364+10460
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 uiInfo+5387364+10452
INDIRI4
ARGI4
ADDRGP4 Text_Paint_Limit
CALLV
pop
line 1827
;1827:		}
LABELV $1521
line 1828
;1828:		if (uiInfo.serverStatus.motdOffset && maxX > 0) {
ADDRGP4 uiInfo+5387364+10452
INDIRI4
CNSTI4 0
EQI4 $1531
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $1531
line 1830
;1829:			// if we have an offset ( we are skipping the first part of the string ) and we fit the string
;1830:			if (uiInfo.serverStatus.motdPaintX2 == -1) {
ADDRGP4 uiInfo+5387364+10448
INDIRI4
CNSTI4 -1
NEI4 $1532
line 1831
;1831:				uiInfo.serverStatus.motdPaintX2 = rect->x + rect->w - 2;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 uiInfo+5387364+10448
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
line 1832
;1832:			}
line 1833
;1833:		} else {
ADDRGP4 $1532
JUMPV
LABELV $1531
line 1834
;1834:			uiInfo.serverStatus.motdPaintX2 = -1;
ADDRGP4 uiInfo+5387364+10448
CNSTI4 -1
ASGNI4
line 1835
;1835:		}
LABELV $1532
line 1837
;1836:
;1837:	}
LABELV $1441
line 1838
;1838:}
LABELV $1440
endproc UI_DrawServerMOTD 24 32
proc UI_DrawKeyBindStatus 8 40
line 1840
;1839:
;1840:static void UI_DrawKeyBindStatus(rectDef_t *rect, float scale, const vec4_t color, int textStyle) {
line 1842
;1841:	//	int ofs = 0; TTimo: unused
;1842:	if (Display_KeyBindPending()) {
ADDRLP4 0
ADDRGP4 Display_KeyBindPending
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1544
line 1843
;1843:		Text_Paint(rect->x, rect->y, scale, color, "Waiting for new key... Press ESCAPE to cancel", 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
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
ADDRGP4 $1328
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1844
;1844:	} else {
ADDRGP4 $1545
JUMPV
LABELV $1544
line 1845
;1845:		Text_Paint(rect->x, rect->y, scale, color, "Press ENTER or CLICK to change, Press BACKSPACE to clear", 0, 0, textStyle, 1, WIDESCREEN_STRETCH);
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
ADDRGP4 $1329
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1846
;1846:	}
LABELV $1545
line 1847
;1847:}
LABELV $1543
endproc UI_DrawKeyBindStatus 8 40
proc UI_DrawGLInfo 1336 40
line 1849
;1848:
;1849:static void UI_DrawGLInfo(rectDef_t *rect, float scale, const vec4_t color, int textStyle) {
line 1855
;1850:	char *eptr;
;1851:	char buff[1024];
;1852:	const char *lines[64];
;1853:	int y, numLines, i;
;1854:
;1855:	Text_Paint(rect->x + 2, rect->y, scale, color, va("VENDOR: %s", uiInfo.uiDC.glconfig.vendor_string), 0, 30, textStyle, 1, WIDESCREEN_STRETCH);
ADDRGP4 $1547
ARGP4
ADDRGP4 uiInfo+5342996+1024
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1856
;1856:	Text_Paint(rect->x + 2, rect->y + 15, scale, color, va("VERSION: %s: %s", uiInfo.uiDC.glconfig.version_string, uiInfo.uiDC.glconfig.renderer_string), 0, 30, textStyle, 1, WIDESCREEN_STRETCH);
ADDRGP4 $1550
ARGP4
ADDRGP4 uiInfo+5342996+2048
ARGP4
ADDRGP4 uiInfo+5342996
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1857
;1857:	Text_Paint(rect->x + 2, rect->y + 30, scale, color, va("PIXELFORMAT: color(%d-bits) Z(%d-bits) stencil(%d-bits)", uiInfo.uiDC.glconfig.colorBits, uiInfo.uiDC.glconfig.depthBits, uiInfo.uiDC.glconfig.stencilBits), 0, 30, textStyle, 1, WIDESCREEN_STRETCH);
ADDRGP4 $1554
ARGP4
ADDRGP4 uiInfo+5342996+11272
INDIRI4
ARGI4
ADDRGP4 uiInfo+5342996+11276
INDIRI4
ARGI4
ADDRGP4 uiInfo+5342996+11280
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1863
;1858:
;1859:	// build null terminated extension strings
;1860:  // TTimo: https://zerowing.idsoftware.com/bugzilla/show_bug.cgi?id=399
;1861:  // in TA this was not directly crashing, but displaying a nasty broken shader right in the middle
;1862:  // brought down the string size to 1024, there's not much that can be shown on the screen anyway
;1863:	Q_strncpyz(buff, uiInfo.uiDC.glconfig.extensions_string, 1024);
ADDRLP4 272
ARGP4
ADDRGP4 uiInfo+5342996+3072
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1864
;1864:	eptr = buff;
ADDRLP4 0
ADDRLP4 272
ASGNP4
line 1865
;1865:	y = rect->y + 45;
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
line 1866
;1866:	numLines = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $1564
JUMPV
line 1867
;1867:	while (y < rect->y + rect->h && *eptr) {
LABELV $1566
line 1869
;1868:		while (*eptr && *eptr == ' ')
;1869:			*eptr++ = '\0';
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
LABELV $1567
line 1868
ADDRLP4 1324
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1324
INDIRI4
CNSTI4 0
EQI4 $1569
ADDRLP4 1324
INDIRI4
CNSTI4 32
EQI4 $1566
LABELV $1569
line 1872
;1870:
;1871:		// track start of valid string
;1872:		if (*eptr && *eptr != ' ') {
ADDRLP4 1328
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1328
INDIRI4
CNSTI4 0
EQI4 $1573
ADDRLP4 1328
INDIRI4
CNSTI4 32
EQI4 $1573
line 1873
;1873:			lines[numLines++] = eptr;
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
line 1874
;1874:		}
ADDRGP4 $1573
JUMPV
LABELV $1572
line 1877
;1875:
;1876:		while (*eptr && *eptr != ' ')
;1877:			eptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $1573
line 1876
ADDRLP4 1332
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1332
INDIRI4
CNSTI4 0
EQI4 $1575
ADDRLP4 1332
INDIRI4
CNSTI4 32
NEI4 $1572
LABELV $1575
line 1878
;1878:	}
LABELV $1564
line 1867
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
GEF4 $1576
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1567
LABELV $1576
line 1880
;1879:
;1880:	i = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $1578
JUMPV
LABELV $1577
line 1881
;1881:	while (i < numLines) {
line 1882
;1882:		Text_Paint(rect->x + 2, y, scale, color, lines[i++], 0, 20, textStyle, 1, WIDESCREEN_STRETCH);
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1883
;1883:		if (i < numLines) {
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
GEI4 $1580
line 1884
;1884:			Text_Paint(rect->x + rect->w / 2, y, scale, color, lines[i++], 0, 20, textStyle, 1, WIDESCREEN_STRETCH);
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1885
;1885:		}
LABELV $1580
line 1886
;1886:		y += 10;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 10
ADDI4
ASGNI4
line 1887
;1887:		if (y > rect->y + rect->h - 11) {
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
LEF4 $1582
line 1888
;1888:			break;
ADDRGP4 $1579
JUMPV
LABELV $1582
line 1890
;1889:		}
;1890:	}
LABELV $1578
line 1881
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $1577
LABELV $1579
line 1893
;1891:
;1892:
;1893:}
LABELV $1546
endproc UI_DrawGLInfo 1336 40
proc UI_OwnerDraw 24 20
line 1897
;1894:
;1895:// FIXME: table drive
;1896://
;1897:static void UI_OwnerDraw(float x, float y, float w, float h, float text_x, float text_y, int ownerDraw, int ownerDrawFlags, int ownerDrawFlags2, int align, float special, float scale, const vec4_t color, qhandle_t shader, int textStyle, int fontIndex, int menuWidescreen, int itemWidescreen) { //, rectDef_t menuRect) {
line 1900
;1898:	rectDef_t rect;
;1899:
;1900:	rect.x = x + text_x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
ADDRFP4 16
INDIRF4
ADDF4
ASGNF4
line 1901
;1901:	rect.y = y + text_y;
ADDRLP4 0+4
ADDRFP4 4
INDIRF4
ADDRFP4 20
INDIRF4
ADDF4
ASGNF4
line 1902
;1902:	rect.w = w;
ADDRLP4 0+8
ADDRFP4 8
INDIRF4
ASGNF4
line 1903
;1903:	rect.h = h;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
ASGNF4
line 1905
;1904:
;1905:	switch (ownerDraw) {
ADDRLP4 16
ADDRFP4 24
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 513
LTI4 $1588
ADDRLP4 16
INDIRI4
CNSTI4 548
GTI4 $1632
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1633-2052
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1633
address $1590
address $1591
address $1594
address $1597
address $1601
address $1602
address $1603
address $1605
address $1606
address $1607
address $1608
address $1609
address $1610
address $1617
address $1618
address $1619
address $1621
address $1588
address $1622
address $1623
address $1624
address $1625
address $1626
address $1599
address $1595
address $1604
address $1627
address $1628
address $1629
address $1630
address $1592
address $1598
address $1596
address $1593
address $1600
address $1620
code
LABELV $1632
ADDRLP4 20
ADDRFP4 24
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 6682
LTI4 $1588
ADDRLP4 20
INDIRI4
CNSTI4 6687
GTI4 $1588
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1635-26728
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1635
address $1611
address $1614
address $1612
address $1615
address $1613
address $1616
code
LABELV $1590
line 1907
;1906:	case UI_HANDICAP:
;1907:		UI_DrawHandicap(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandicap
CALLV
pop
line 1908
;1908:		break;
ADDRGP4 $1589
JUMPV
LABELV $1591
line 1910
;1909:	case UI_PLAYERMODEL:
;1910:		UI_DrawPlayerModel(&rect);
ADDRLP4 0
ARGP4
ADDRGP4 UI_DrawPlayerModel
CALLV
pop
line 1911
;1911:		break;
ADDRGP4 $1589
JUMPV
LABELV $1592
line 1913
;1912:	case UI_CLANCINEMATIC:
;1913:		UI_DrawClanCinematic(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRGP4 UI_DrawClanCinematic
CALLV
pop
line 1914
;1914:		break;
ADDRGP4 $1589
JUMPV
LABELV $1593
line 1916
;1915:	case UI_PREVIEWCINEMATIC:
;1916:		UI_DrawPreviewCinematic(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRGP4 UI_DrawPreviewCinematic
CALLV
pop
line 1917
;1917:		break;
ADDRGP4 $1589
JUMPV
LABELV $1594
line 1919
;1918:	case UI_GAMETYPE:
;1919:		UI_DrawGameType(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawGameType
CALLV
pop
line 1920
;1920:		break;
ADDRGP4 $1589
JUMPV
LABELV $1595
line 1922
;1921:	case UI_NETGAMETYPE:
;1922:		UI_DrawNetGameType(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawNetGameType
CALLV
pop
line 1923
;1923:		break;
ADDRGP4 $1589
JUMPV
LABELV $1596
line 1925
;1924:	case UI_JOINGAMETYPE:
;1925:		UI_DrawJoinGameType(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawJoinGameType
CALLV
pop
line 1926
;1926:		break;
ADDRGP4 $1589
JUMPV
LABELV $1597
line 1928
;1927:	case UI_MAPPREVIEW:
;1928:		UI_DrawMapPreview(&rect, scale, color, qtrue);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 UI_DrawMapPreview
CALLV
pop
line 1929
;1929:		break;
ADDRGP4 $1589
JUMPV
LABELV $1598
line 1931
;1930:	case UI_MAP_TIMETOBEAT:
;1931:		UI_DrawMapTimeToBeat(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawMapTimeToBeat
CALLV
pop
line 1932
;1932:		break;
ADDRGP4 $1589
JUMPV
LABELV $1599
line 1934
;1933:	case UI_MAPCINEMATIC:
;1934:		UI_DrawMapCinematic(&rect, scale, color, qfalse);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawMapCinematic
CALLV
pop
line 1935
;1935:		break;
ADDRGP4 $1589
JUMPV
LABELV $1600
line 1937
;1936:	case UI_STARTMAPCINEMATIC:
;1937:		UI_DrawMapCinematic(&rect, scale, color, qtrue);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 UI_DrawMapCinematic
CALLV
pop
line 1938
;1938:		break;
ADDRGP4 $1589
JUMPV
LABELV $1601
line 1940
;1939:	case UI_SKILL:
;1940:		UI_DrawSkill(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawSkill
CALLV
pop
line 1941
;1941:		break;
ADDRGP4 $1589
JUMPV
LABELV $1602
line 1943
;1942:	case UI_NETSOURCE:
;1943:		UI_DrawNetSource(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawNetSource
CALLV
pop
line 1944
;1944:		break;
ADDRGP4 $1589
JUMPV
LABELV $1603
line 1946
;1945:	case UI_NETMAPPREVIEW:
;1946:		UI_DrawNetMapPreview(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRGP4 UI_DrawNetMapPreview
CALLV
pop
line 1947
;1947:		break;
ADDRGP4 $1589
JUMPV
LABELV $1604
line 1949
;1948:	case UI_NETMAPCINEMATIC:
;1949:		UI_DrawNetMapCinematic(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRGP4 UI_DrawNetMapCinematic
CALLV
pop
line 1950
;1950:		break;
ADDRGP4 $1589
JUMPV
LABELV $1605
line 1952
;1951:	case UI_NETFILTER:
;1952:		UI_DrawNetFilter(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawNetFilter
CALLV
pop
line 1953
;1953:		break;
ADDRGP4 $1589
JUMPV
LABELV $1606
line 1955
;1954:	case UI_TIER:
;1955:		UI_DrawTier(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawTier
CALLV
pop
line 1956
;1956:		break;
ADDRGP4 $1589
JUMPV
LABELV $1607
line 1958
;1957:	case UI_OPPONENTMODEL:
;1958:		UI_DrawOpponent(&rect);
ADDRLP4 0
ARGP4
ADDRGP4 UI_DrawOpponent
CALLV
pop
line 1959
;1959:		break;
ADDRGP4 $1589
JUMPV
LABELV $1608
line 1961
;1960:	case UI_TIERMAP1:
;1961:		UI_DrawTierMap(&rect, 0);
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawTierMap
CALLV
pop
line 1962
;1962:		break;
ADDRGP4 $1589
JUMPV
LABELV $1609
line 1964
;1963:	case UI_TIERMAP2:
;1964:		UI_DrawTierMap(&rect, 1);
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 UI_DrawTierMap
CALLV
pop
line 1965
;1965:		break;
ADDRGP4 $1589
JUMPV
LABELV $1610
line 1967
;1966:	case UI_TIERMAP3:
;1967:		UI_DrawTierMap(&rect, 2);
ADDRLP4 0
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 UI_DrawTierMap
CALLV
pop
line 1968
;1968:		break;
ADDRGP4 $1589
JUMPV
LABELV $1611
line 1970
;1969:	case UI_PLAYERLOGO:
;1970:		UI_DrawPlayerLogo(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 48
INDIRP4
ARGP4
ADDRGP4 UI_DrawPlayerLogo
CALLV
pop
line 1971
;1971:		break;
ADDRGP4 $1589
JUMPV
LABELV $1612
line 1973
;1972:	case UI_PLAYERLOGO_METAL:
;1973:		UI_DrawPlayerLogoMetal(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 48
INDIRP4
ARGP4
ADDRGP4 UI_DrawPlayerLogoMetal
CALLV
pop
line 1974
;1974:		break;
ADDRGP4 $1589
JUMPV
LABELV $1613
line 1976
;1975:	case UI_PLAYERLOGO_NAME:
;1976:		UI_DrawPlayerLogoName(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 48
INDIRP4
ARGP4
ADDRGP4 UI_DrawPlayerLogoName
CALLV
pop
line 1977
;1977:		break;
ADDRGP4 $1589
JUMPV
LABELV $1614
line 1979
;1978:	case UI_OPPONENTLOGO:
;1979:		UI_DrawOpponentLogo(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 48
INDIRP4
ARGP4
ADDRGP4 UI_DrawOpponentLogo
CALLV
pop
line 1980
;1980:		break;
ADDRGP4 $1589
JUMPV
LABELV $1615
line 1982
;1981:	case UI_OPPONENTLOGO_METAL:
;1982:		UI_DrawOpponentLogoMetal(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 48
INDIRP4
ARGP4
ADDRGP4 UI_DrawOpponentLogoMetal
CALLV
pop
line 1983
;1983:		break;
ADDRGP4 $1589
JUMPV
LABELV $1616
line 1985
;1984:	case UI_OPPONENTLOGO_NAME:
;1985:		UI_DrawOpponentLogoName(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 48
INDIRP4
ARGP4
ADDRGP4 UI_DrawOpponentLogoName
CALLV
pop
line 1986
;1986:		break;
ADDRGP4 $1589
JUMPV
LABELV $1617
line 1988
;1987:	case UI_TIER_MAPNAME:
;1988:		UI_DrawTierMapName(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawTierMapName
CALLV
pop
line 1989
;1989:		break;
ADDRGP4 $1589
JUMPV
LABELV $1618
line 1991
;1990:	case UI_TIER_GAMETYPE:
;1991:		UI_DrawTierGameType(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawTierGameType
CALLV
pop
line 1992
;1992:		break;
ADDRGP4 $1589
JUMPV
LABELV $1619
line 1994
;1993:	case UI_ALLMAPS_SELECTION:
;1994:		UI_DrawAllMapsSelection(&rect, scale, color, textStyle, qtrue);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 UI_DrawAllMapsSelection
CALLV
pop
line 1995
;1995:		break;
ADDRGP4 $1589
JUMPV
LABELV $1620
line 1997
;1996:	case UI_MAPS_SELECTION:
;1997:		UI_DrawAllMapsSelection(&rect, scale, color, textStyle, qfalse);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawAllMapsSelection
CALLV
pop
line 1998
;1998:		break;
ADDRGP4 $1589
JUMPV
LABELV $1621
line 2000
;1999:	case UI_OPPONENT_NAME:
;2000:		UI_DrawOpponentName(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawOpponentName
CALLV
pop
line 2001
;2001:		break;
ADDRGP4 $1589
JUMPV
LABELV $1622
line 2003
;2002:	case UI_BOTNAME:
;2003:		UI_DrawBotName(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawBotName
CALLV
pop
line 2004
;2004:		break;
ADDRGP4 $1589
JUMPV
LABELV $1623
line 2006
;2005:	case UI_BOTSKILL:
;2006:		UI_DrawBotSkill(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawBotSkill
CALLV
pop
line 2007
;2007:		break;
ADDRGP4 $1589
JUMPV
LABELV $1624
line 2009
;2008:	case UI_REDBLUE:
;2009:		UI_DrawRedBlue(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawRedBlue
CALLV
pop
line 2010
;2010:		break;
ADDRGP4 $1589
JUMPV
LABELV $1625
line 2012
;2011:	case UI_CROSSHAIR:
;2012:		UI_DrawCrosshair(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRGP4 UI_DrawCrosshair
CALLV
pop
line 2013
;2013:		break;
ADDRGP4 $1589
JUMPV
LABELV $1626
line 2015
;2014:	case UI_SELECTEDPLAYER:
;2015:		UI_DrawSelectedPlayer(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawSelectedPlayer
CALLV
pop
line 2016
;2016:		break;
ADDRGP4 $1589
JUMPV
LABELV $1627
line 2018
;2017:	case UI_SERVERREFRESHDATE:
;2018:		UI_DrawServerRefreshDate(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawServerRefreshDate
CALLV
pop
line 2019
;2019:		break;
ADDRGP4 $1589
JUMPV
LABELV $1628
line 2021
;2020:	case UI_SERVERMOTD:
;2021:		UI_DrawServerMOTD(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRGP4 UI_DrawServerMOTD
CALLV
pop
line 2022
;2022:		break;
ADDRGP4 $1589
JUMPV
LABELV $1629
line 2024
;2023:	case UI_GLINFO:
;2024:		UI_DrawGLInfo(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawGLInfo
CALLV
pop
line 2025
;2025:		break;
ADDRGP4 $1589
JUMPV
LABELV $1630
line 2027
;2026:	case UI_KEYBINDSTATUS:
;2027:		UI_DrawKeyBindStatus(&rect, scale, color, textStyle);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRF4
ARGF4
ADDRFP4 48
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawKeyBindStatus
CALLV
pop
line 2028
;2028:		break;
ADDRGP4 $1589
JUMPV
LABELV $1588
line 2038
;2029:
;2030:		//////////////////////////////////////////////
;2031:
;2032:		//+#define UI_ADVERT  257
;2033:		//+#define UI_CROSSHAIR_COLOR 258
;2034:		//+#define UI_NEXTMAP 259
;2035:		//+#define UI_VOTESTRING 260
;2036:
;2037:	default:
;2038:		Com_Printf("UI_OwnerDraw unknown owner draw %d\n", ownerDraw);
ADDRGP4 $1631
ARGP4
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 2039
;2039:		break;
LABELV $1589
line 2042
;2040:	}
;2041:
;2042:}
LABELV $1584
endproc UI_OwnerDraw 24 20
proc UI_OwnerDrawVisible 8 8
line 2044
;2043:
;2044:static qboolean UI_OwnerDrawVisible(int flags, int flags2) {
line 2045
;2045:	qboolean vis = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1639
JUMPV
LABELV $1638
line 2047
;2046:
;2047:	while (flags) {
line 2049
;2048:
;2049:		if (flags & UI_SHOW_FFA) {
ADDRFP4 0
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $1641
line 2050
;2050:			if (trap_Cvar_VariableValue("g_gametype") != GT_FFA) {
ADDRGP4 $1340
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 0
EQF4 $1643
line 2051
;2051:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2052
;2052:			}
LABELV $1643
line 2053
;2053:			flags &= ~UI_SHOW_FFA;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 2054
;2054:		}
LABELV $1641
line 2056
;2055:
;2056:		if (flags & UI_SHOW_NOTFFA) {
ADDRFP4 0
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1645
line 2057
;2057:			if (trap_Cvar_VariableValue("g_gametype") == GT_FFA) {
ADDRGP4 $1340
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $1647
line 2058
;2058:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2059
;2059:			}
LABELV $1647
line 2060
;2060:			flags &= ~UI_SHOW_NOTFFA;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -513
BANDI4
ASGNI4
line 2061
;2061:		}
LABELV $1645
line 2063
;2062:
;2063:		if (flags & UI_SHOW_LEADER) {
ADDRFP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1649
line 2065
;2064:			// these need to show when this client can give orders to a player or a group
;2065:			if (!uiInfo.teamLeader) {
ADDRGP4 uiInfo+5359800
INDIRI4
CNSTI4 0
NEI4 $1651
line 2066
;2066:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2067
;2067:			} else {
ADDRGP4 $1652
JUMPV
LABELV $1651
line 2069
;2068:				// if showing yourself
;2069:				if (ui_selectedPlayer.integer < uiInfo.myTeamCount && uiInfo.teamClientNums[ui_selectedPlayer.integer] == uiInfo.playerNumber) {
ADDRGP4 ui_selectedPlayer+12
INDIRI4
ADDRGP4 uiInfo+5359780
INDIRI4
GEI4 $1654
ADDRGP4 ui_selectedPlayer+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5363900
ADDP4
INDIRI4
ADDRGP4 uiInfo+5359796
INDIRI4
NEI4 $1654
line 2070
;2070:					vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2071
;2071:				}
LABELV $1654
line 2072
;2072:			}
LABELV $1652
line 2073
;2073:			flags &= ~UI_SHOW_LEADER;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 2074
;2074:		}
LABELV $1649
line 2075
;2075:		if (flags & UI_SHOW_NOTLEADER) {
ADDRFP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1661
line 2077
;2076:			// these need to show when this client is assigning their own status or they are NOT the leader
;2077:			if (uiInfo.teamLeader) {
ADDRGP4 uiInfo+5359800
INDIRI4
CNSTI4 0
EQI4 $1663
line 2079
;2078:				// if not showing yourself
;2079:				if (!(ui_selectedPlayer.integer < uiInfo.myTeamCount && uiInfo.teamClientNums[ui_selectedPlayer.integer] == uiInfo.playerNumber)) {
ADDRGP4 ui_selectedPlayer+12
INDIRI4
ADDRGP4 uiInfo+5359780
INDIRI4
GEI4 $1673
ADDRGP4 ui_selectedPlayer+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5363900
ADDP4
INDIRI4
ADDRGP4 uiInfo+5359796
INDIRI4
EQI4 $1666
LABELV $1673
line 2080
;2080:					vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2081
;2081:				}
LABELV $1666
line 2083
;2082:				// these need to show when this client can give orders to a player or a group
;2083:			}
LABELV $1663
line 2084
;2084:			flags &= ~UI_SHOW_NOTLEADER;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 2085
;2085:		}
LABELV $1661
line 2086
;2086:		if (flags & UI_SHOW_FAVORITESERVERS) {
ADDRFP4 0
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1674
line 2088
;2087:			// this assumes you only put this type of display flag on something showing in the proper context
;2088:			if (ui_netSource.integer != UIAS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 7
EQI4 $1676
line 2089
;2089:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2090
;2090:			}
LABELV $1676
line 2091
;2091:			flags &= ~UI_SHOW_FAVORITESERVERS;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -5
BANDI4
ASGNI4
line 2092
;2092:		}
LABELV $1674
line 2093
;2093:		if (flags & UI_SHOW_NOTFAVORITESERVERS) {
ADDRFP4 0
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1679
line 2095
;2094:			// this assumes you only put this type of display flag on something showing in the proper context
;2095:			if (ui_netSource.integer == UIAS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 7
NEI4 $1681
line 2096
;2096:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2097
;2097:			}
LABELV $1681
line 2098
;2098:			flags &= ~UI_SHOW_NOTFAVORITESERVERS;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -4097
BANDI4
ASGNI4
line 2099
;2099:		}
LABELV $1679
line 2100
;2100:		if (flags & UI_SHOW_ANYTEAMGAME) {
ADDRFP4 0
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1684
line 2101
;2101:			if (uiInfo.gameTypes[ui_gameType.integer].gtEnum <= GT_TEAM) {
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359512+4
ADDP4
INDIRI4
CNSTI4 3
GTI4 $1686
line 2102
;2102:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2103
;2103:			}
LABELV $1686
line 2104
;2104:			flags &= ~UI_SHOW_ANYTEAMGAME;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 2105
;2105:		}
LABELV $1684
line 2106
;2106:		if (flags & UI_SHOW_ANYNONTEAMGAME) {
ADDRFP4 0
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1691
line 2107
;2107:			if (uiInfo.gameTypes[ui_gameType.integer].gtEnum > GT_TEAM) {
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359512+4
ADDP4
INDIRI4
CNSTI4 3
LEI4 $1693
line 2108
;2108:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2109
;2109:			}
LABELV $1693
line 2110
;2110:			flags &= ~UI_SHOW_ANYNONTEAMGAME;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 2111
;2111:		}
LABELV $1691
line 2112
;2112:		if (flags & UI_SHOW_NETANYTEAMGAME) {
ADDRFP4 0
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1698
line 2113
;2113:			if (uiInfo.gameTypes[ui_netGameType.integer].gtEnum <= GT_TEAM) {
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359512+4
ADDP4
INDIRI4
CNSTI4 3
GTI4 $1700
line 2114
;2114:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2115
;2115:			}
LABELV $1700
line 2116
;2116:			flags &= ~UI_SHOW_NETANYTEAMGAME;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 2117
;2117:		}
LABELV $1698
line 2118
;2118:		if (flags & UI_SHOW_NETANYNONTEAMGAME) {
ADDRFP4 0
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1705
line 2119
;2119:			if (uiInfo.gameTypes[ui_netGameType.integer].gtEnum > GT_TEAM) {
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359512+4
ADDP4
INDIRI4
CNSTI4 3
LEI4 $1707
line 2120
;2120:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2121
;2121:			}
LABELV $1707
line 2122
;2122:			flags &= ~UI_SHOW_NETANYNONTEAMGAME;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 2123
;2123:		}
LABELV $1705
line 2124
;2124:		if (flags & UI_SHOW_NEWHIGHSCORE) {
ADDRFP4 0
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1712
line 2125
;2125:			if (uiInfo.newHighScoreTime < uiInfo.uiDC.realTime) {
ADDRGP4 uiInfo+5354348
INDIRI4
ADDRGP4 uiInfo+212
INDIRI4
GEI4 $1714
line 2126
;2126:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2127
;2127:			} else {
ADDRGP4 $1715
JUMPV
LABELV $1714
line 2128
;2128:				if (uiInfo.soundHighScore) {
ADDRGP4 uiInfo+5354368
INDIRI4
CNSTI4 0
EQI4 $1718
line 2129
;2129:					if (trap_Cvar_VariableValue("sv_killserver") == 0) {
ADDRGP4 $395
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $1721
line 2131
;2130:						// wait on server to go down before playing sound
;2131:						trap_S_StartLocalSound(uiInfo.newHighScoreSound, CHAN_ANNOUNCER);
ADDRGP4 uiInfo+5407584
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2132
;2132:						uiInfo.soundHighScore = qfalse;
ADDRGP4 uiInfo+5354368
CNSTI4 0
ASGNI4
line 2133
;2133:					}
LABELV $1721
line 2134
;2134:				}
LABELV $1718
line 2135
;2135:			}
LABELV $1715
line 2136
;2136:			flags &= ~UI_SHOW_NEWHIGHSCORE;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -33
BANDI4
ASGNI4
line 2137
;2137:		}
LABELV $1712
line 2138
;2138:		if (flags & UI_SHOW_NEWBESTTIME) {
ADDRFP4 0
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $1725
line 2139
;2139:			if (uiInfo.newBestTime < uiInfo.uiDC.realTime) {
ADDRGP4 uiInfo+5354352
INDIRI4
ADDRGP4 uiInfo+212
INDIRI4
GEI4 $1727
line 2140
;2140:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2141
;2141:			}
LABELV $1727
line 2142
;2142:			flags &= ~UI_SHOW_NEWBESTTIME;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 2143
;2143:		}
LABELV $1725
line 2144
;2144:		if (flags & UI_SHOW_DEMOAVAILABLE) {
ADDRFP4 0
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $1731
line 2145
;2145:			if (!uiInfo.demoAvailable) {
ADDRGP4 uiInfo+5354364
INDIRI4
CNSTI4 0
NEI4 $1733
line 2146
;2146:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2147
;2147:			}
LABELV $1733
line 2148
;2148:			flags &= ~UI_SHOW_DEMOAVAILABLE;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -65
BANDI4
ASGNI4
line 2149
;2149:		} else {
ADDRGP4 $1732
JUMPV
LABELV $1731
line 2150
;2150:			flags = 0;
ADDRFP4 0
CNSTI4 0
ASGNI4
line 2151
;2151:		}
LABELV $1732
line 2152
;2152:	}
LABELV $1639
line 2047
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $1638
line 2153
;2153:	return vis;
ADDRLP4 0
INDIRI4
RETI4
LABELV $1637
endproc UI_OwnerDrawVisible 8 8
proc UI_Handicap_HandleKey 20 12
line 2156
;2154:}
;2155:
;2156:static qboolean UI_Handicap_HandleKey(int flags, float *special, int key) {
line 2157
;2157:	int select = UI_SelectForKey(key);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 UI_SelectForKey
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 2158
;2158:	if (select != 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1737
line 2161
;2159:		int h;
;2160:
;2161:		h = Com_Clamp(5, 100, trap_Cvar_VariableValue("handicap"));
ADDRGP4 $710
ARGP4
ADDRLP4 12
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1084227584
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
line 2162
;2162:		h += 5 * select;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 5
MULI4
ADDI4
ASGNI4
line 2164
;2163:
;2164:		if (h > 100) {
ADDRLP4 8
INDIRI4
CNSTI4 100
LEI4 $1739
line 2165
;2165:			h = 5;
ADDRLP4 8
CNSTI4 5
ASGNI4
line 2166
;2166:		} else if (h < 5) {
ADDRGP4 $1740
JUMPV
LABELV $1739
ADDRLP4 8
INDIRI4
CNSTI4 5
GEI4 $1741
line 2167
;2167:			h = 100;
ADDRLP4 8
CNSTI4 100
ASGNI4
line 2168
;2168:		}
LABELV $1741
LABELV $1740
line 2170
;2169:
;2170:		trap_Cvar_SetValue("handicap", h);
ADDRGP4 $710
ARGP4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2171
;2171:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1736
JUMPV
LABELV $1737
line 2173
;2172:	}
;2173:	return qfalse;
CNSTI4 0
RETI4
LABELV $1736
endproc UI_Handicap_HandleKey 20 12
proc UI_Effects_HandleKey 12 8
line 2176
;2174:}
;2175:
;2176:static qboolean UI_Effects_HandleKey(int flags, float *special, int key) {
line 2177
;2177:	int select = UI_SelectForKey(key);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 UI_SelectForKey
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 2178
;2178:	if (select != 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1744
line 2179
;2179:		uiInfo.effectsColor += select;
ADDRLP4 8
ADDRGP4 uiInfo+5425004
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 2181
;2180:
;2181:		if (uiInfo.effectsColor > 6) {
ADDRGP4 uiInfo+5425004
INDIRI4
CNSTI4 6
LEI4 $1747
line 2182
;2182:			uiInfo.effectsColor = 0;
ADDRGP4 uiInfo+5425004
CNSTI4 0
ASGNI4
line 2183
;2183:		} else if (uiInfo.effectsColor < 0) {
ADDRGP4 $1748
JUMPV
LABELV $1747
ADDRGP4 uiInfo+5425004
INDIRI4
CNSTI4 0
GEI4 $1751
line 2184
;2184:			uiInfo.effectsColor = 6;
ADDRGP4 uiInfo+5425004
CNSTI4 6
ASGNI4
line 2185
;2185:		}
LABELV $1751
LABELV $1748
line 2187
;2186:
;2187:		trap_Cvar_SetValue("color1", uitogamecode[uiInfo.effectsColor]);
ADDRGP4 $1755
ARGP4
ADDRGP4 uiInfo+5425004
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
line 2188
;2188:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1743
JUMPV
LABELV $1744
line 2190
;2189:	}
;2190:	return qfalse;
CNSTI4 0
RETI4
LABELV $1743
endproc UI_Effects_HandleKey 12 8
proc UI_ClanName_HandleKey 20 8
line 2193
;2191:}
;2192:
;2193:static qboolean UI_ClanName_HandleKey(int flags, float *special, int key) {
line 2194
;2194:	int select = UI_SelectForKey(key);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 UI_SelectForKey
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 2195
;2195:	if (select != 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1758
line 2198
;2196:		int i;
;2197:
;2198:		i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $712
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
ADDRLP4 8
ADDRLP4 16
INDIRI4
ASGNI4
line 2200
;2199:
;2200:		if (uiInfo.teamList[i].cinematic >= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+40
ADDP4
INDIRI4
CNSTI4 0
LTI4 $1760
line 2201
;2201:			trap_CIN_StopCinematic(uiInfo.teamList[i].cinematic);
ADDRLP4 8
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+40
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 2202
;2202:			uiInfo.teamList[i].cinematic = -1;
ADDRLP4 8
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+40
ADDP4
CNSTI4 -1
ASGNI4
line 2203
;2203:		}
LABELV $1760
line 2205
;2204:
;2205:		i += select;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 2207
;2206:
;2207:		if (i >= uiInfo.teamCount) {
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+5356688
INDIRI4
LTI4 $1768
line 2208
;2208:			i = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2209
;2209:		} else if (i < 0) {
ADDRGP4 $1769
JUMPV
LABELV $1768
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $1771
line 2210
;2210:			i = uiInfo.teamCount - 1;
ADDRLP4 8
ADDRGP4 uiInfo+5356688
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2211
;2211:		}
LABELV $1771
LABELV $1769
line 2213
;2212:
;2213:		trap_Cvar_Set("ui_teamName", uiInfo.teamList[i].teamName);
ADDRGP4 $712
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2214
;2214:		UI_HeadCountByTeam();
ADDRGP4 UI_HeadCountByTeam
CALLI4
pop
line 2215
;2215:		UI_FeederSelection(FEEDER_HEADS, 0);
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 UI_FeederSelection
CALLV
pop
line 2216
;2216:		updateModel = qtrue;
ADDRGP4 updateModel
CNSTI4 1
ASGNI4
line 2217
;2217:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1757
JUMPV
LABELV $1758
line 2219
;2218:	}
;2219:	return qfalse;
CNSTI4 0
RETI4
LABELV $1757
endproc UI_ClanName_HandleKey 20 8
proc UI_GameType_HandleKey 24 16
line 2222
;2220:}
;2221:
;2222:static qboolean UI_GameType_HandleKey(int flags, float *special, int key, qboolean resetMap) {
line 2223
;2223:	int select = UI_SelectForKey(key);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 UI_SelectForKey
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 2224
;2224:	if (select != 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1776
line 2225
;2225:		int oldCount = UI_MapCountByGameType();
ADDRLP4 12
ADDRGP4 UI_MapCountByGameType
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 2228
;2226:
;2227:		// hard coded mess here
;2228:		if (select < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1778
line 2229
;2229:			ui_gameType.integer--;
ADDRLP4 16
ADDRGP4 ui_gameType+12
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2230
;2230:			if (ui_gameType.integer == 2) {
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 2
NEI4 $1781
line 2231
;2231:				ui_gameType.integer = 1;
ADDRGP4 ui_gameType+12
CNSTI4 1
ASGNI4
line 2232
;2232:			} else if (ui_gameType.integer < 2) {
ADDRGP4 $1779
JUMPV
LABELV $1781
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 2
GEI4 $1779
line 2233
;2233:				ui_gameType.integer = uiInfo.numGameTypes - 1;
ADDRGP4 ui_gameType+12
ADDRGP4 uiInfo+5359508
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2234
;2234:			}
line 2235
;2235:		} else {
ADDRGP4 $1779
JUMPV
LABELV $1778
line 2236
;2236:			ui_gameType.integer++;
ADDRLP4 16
ADDRGP4 ui_gameType+12
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2237
;2237:			if (ui_gameType.integer >= uiInfo.numGameTypes) {
ADDRGP4 ui_gameType+12
INDIRI4
ADDRGP4 uiInfo+5359508
INDIRI4
LTI4 $1791
line 2238
;2238:				ui_gameType.integer = 1;
ADDRGP4 ui_gameType+12
CNSTI4 1
ASGNI4
line 2239
;2239:			} else if (ui_gameType.integer == 2) {
ADDRGP4 $1792
JUMPV
LABELV $1791
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 2
NEI4 $1796
line 2240
;2240:				ui_gameType.integer = 3;
ADDRGP4 ui_gameType+12
CNSTI4 3
ASGNI4
line 2241
;2241:			}
LABELV $1796
LABELV $1792
line 2242
;2242:		}
LABELV $1779
line 2244
;2243:
;2244:		trap_Cvar_Set("ui_gameType", va("%d", ui_gameType.integer));
ADDRGP4 $727
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1800
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2245
;2245:		UI_SetCapFragLimits(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_SetCapFragLimits
CALLV
pop
line 2246
;2246:		UI_LoadBestScores(uiInfo.mapList[ui_currentMap.integer].mapLoadName, uiInfo.gameTypes[ui_gameType.integer].gtEnum);
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359512+4
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_LoadBestScores
CALLV
pop
line 2247
;2247:		if (resetMap && oldCount != UI_MapCountByGameType()) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $1808
ADDRLP4 20
ADDRGP4 UI_MapCountByGameType
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $1808
line 2248
;2248:			trap_Cvar_Set("ui_currentMap", "0");
ADDRGP4 $949
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2249
;2249:			Menu_SetFeederSelection(NULL, FEEDER_MAPS, 0, NULL);
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
line 2250
;2250:		}
LABELV $1808
line 2251
;2251:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1775
JUMPV
LABELV $1776
line 2253
;2252:	}
;2253:	return qfalse;
CNSTI4 0
RETI4
LABELV $1775
endproc UI_GameType_HandleKey 24 16
proc UI_NetGameType_HandleKey 20 16
line 2256
;2254:}
;2255:
;2256:static qboolean UI_NetGameType_HandleKey(int flags, float *special, int key) {
line 2257
;2257:	int select = UI_SelectForKey(key);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 UI_SelectForKey
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 2258
;2258:	if (select != 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1811
line 2259
;2259:		ui_netGameType.integer += select;
ADDRLP4 8
ADDRGP4 ui_netGameType+12
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 2261
;2260:
;2261:		if (ui_netGameType.integer < 0) {
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 0
GEI4 $1814
line 2262
;2262:			ui_netGameType.integer = uiInfo.numGameTypes - 1;
ADDRGP4 ui_netGameType+12
ADDRGP4 uiInfo+5359508
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2263
;2263:		} else if (ui_netGameType.integer >= uiInfo.numGameTypes) {
ADDRGP4 $1815
JUMPV
LABELV $1814
ADDRGP4 ui_netGameType+12
INDIRI4
ADDRGP4 uiInfo+5359508
INDIRI4
LTI4 $1819
line 2264
;2264:			ui_netGameType.integer = 0;
ADDRGP4 ui_netGameType+12
CNSTI4 0
ASGNI4
line 2265
;2265:		}
LABELV $1819
LABELV $1815
line 2267
;2266:
;2267:		trap_Cvar_Set("ui_netGameType", va("%d", ui_netGameType.integer));
ADDRGP4 $727
ARGP4
ADDRGP4 ui_netGameType+12
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $741
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2268
;2268:		trap_Cvar_Set("ui_actualnetGameType", va("%d", uiInfo.gameTypes[ui_netGameType.integer].gtEnum));
ADDRGP4 $727
ARGP4
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359512+4
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1825
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2269
;2269:		trap_Cvar_Set("ui_currentNetMap", "0");
ADDRGP4 $947
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2270
;2270:		UI_MapCountByGameType();
ADDRGP4 UI_MapCountByGameType
CALLI4
pop
line 2271
;2271:		Menu_SetFeederSelection(NULL, FEEDER_ALLMAPS, 0, NULL);
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
line 2272
;2272:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1810
JUMPV
LABELV $1811
line 2274
;2273:	}
;2274:	return qfalse;
CNSTI4 0
RETI4
LABELV $1810
endproc UI_NetGameType_HandleKey 20 16
proc UI_JoinGameType_HandleKey 16 8
line 2277
;2275:}
;2276:
;2277:static qboolean UI_JoinGameType_HandleKey(int flags, float *special, int key) {
line 2278
;2278:	int select = UI_SelectForKey(key);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 UI_SelectForKey
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 2279
;2279:	if (select != 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1830
line 2280
;2280:		ui_joinGameType.integer += select;
ADDRLP4 8
ADDRGP4 ui_joinGameType+12
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 2282
;2281:
;2282:		if (ui_joinGameType.integer < 0) {
ADDRGP4 ui_joinGameType+12
INDIRI4
CNSTI4 0
GEI4 $1833
line 2283
;2283:			ui_joinGameType.integer = uiInfo.numJoinGameTypes - 1;
ADDRGP4 ui_joinGameType+12
ADDRGP4 uiInfo+5359640
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2284
;2284:		} else if (ui_joinGameType.integer >= uiInfo.numJoinGameTypes) {
ADDRGP4 $1834
JUMPV
LABELV $1833
ADDRGP4 ui_joinGameType+12
INDIRI4
ADDRGP4 uiInfo+5359640
INDIRI4
LTI4 $1838
line 2285
;2285:			ui_joinGameType.integer = 0;
ADDRGP4 ui_joinGameType+12
CNSTI4 0
ASGNI4
line 2286
;2286:		}
LABELV $1838
LABELV $1834
line 2288
;2287:
;2288:		trap_Cvar_Set("ui_joinGameType", va("%d", ui_joinGameType.integer));
ADDRGP4 $727
ARGP4
ADDRGP4 ui_joinGameType+12
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $752
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2289
;2289:		UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 2290
;2290:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1829
JUMPV
LABELV $1830
line 2292
;2291:	}
;2292:	return qfalse;
CNSTI4 0
RETI4
LABELV $1829
endproc UI_JoinGameType_HandleKey 16 8
proc UI_Skill_HandleKey 20 8
line 2295
;2293:}
;2294:
;2295:static qboolean UI_Skill_HandleKey(int flags, float *special, int key) {
line 2296
;2296:	int select = UI_SelectForKey(key);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 UI_SelectForKey
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 2297
;2297:	if (select != 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1845
line 2298
;2298:		int i = trap_Cvar_VariableValue("g_spSkill");
ADDRGP4 $885
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
line 2300
;2299:
;2300:		i += select;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 2302
;2301:
;2302:		if (i < 1) {
ADDRLP4 8
INDIRI4
CNSTI4 1
GEI4 $1847
line 2303
;2303:			i = numSkillLevels;
ADDRLP4 8
ADDRGP4 numSkillLevels
INDIRI4
ASGNI4
line 2304
;2304:		} else if (i > numSkillLevels) {
ADDRGP4 $1848
JUMPV
LABELV $1847
ADDRLP4 8
INDIRI4
ADDRGP4 numSkillLevels
INDIRI4
LEI4 $1849
line 2305
;2305:			i = 1;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 2306
;2306:		}
LABELV $1849
LABELV $1848
line 2308
;2307:
;2308:		trap_Cvar_Set("g_spSkill", va("%i", i));
ADDRGP4 $1851
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $885
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2309
;2309:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1844
JUMPV
LABELV $1845
line 2311
;2310:	}
;2311:	return qfalse;
CNSTI4 0
RETI4
LABELV $1844
endproc UI_Skill_HandleKey 20 8
proc UI_TeamName_HandleKey 28 8
line 2314
;2312:}
;2313:
;2314:static qboolean UI_TeamName_HandleKey(int flags, float *special, int key, qboolean blue) {
line 2315
;2315:	int select = UI_SelectForKey(key);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 UI_SelectForKey
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 2316
;2316:	if (select != 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1853
line 2319
;2317:		int i;
;2318:
;2319:		i = UI_TeamIndexFromName(UI_Cvar_VariableString((blue) ? "ui_blueTeam" : "ui_redTeam"));
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $1856
ADDRLP4 12
ADDRGP4 $891
ASGNP4
ADDRGP4 $1857
JUMPV
LABELV $1856
ADDRLP4 12
ADDRGP4 $892
ASGNP4
LABELV $1857
ADDRLP4 12
INDIRP4
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
ADDRLP4 8
ADDRLP4 20
INDIRI4
ASGNI4
line 2320
;2320:		i += select;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 2322
;2321:
;2322:		if (i >= uiInfo.teamCount) {
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+5356688
INDIRI4
LTI4 $1858
line 2323
;2323:			i = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2324
;2324:		} else if (i < 0) {
ADDRGP4 $1859
JUMPV
LABELV $1858
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $1861
line 2325
;2325:			i = uiInfo.teamCount - 1;
ADDRLP4 8
ADDRGP4 uiInfo+5356688
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2326
;2326:		}
LABELV $1861
LABELV $1859
line 2328
;2327:
;2328:		trap_Cvar_Set((blue) ? "ui_blueTeam" : "ui_redTeam", uiInfo.teamList[i].teamName);
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $1866
ADDRLP4 24
ADDRGP4 $891
ASGNP4
ADDRGP4 $1867
JUMPV
LABELV $1866
ADDRLP4 24
ADDRGP4 $892
ASGNP4
LABELV $1867
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2329
;2329:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1852
JUMPV
LABELV $1853
line 2331
;2330:	}
;2331:	return qfalse;
CNSTI4 0
RETI4
LABELV $1852
endproc UI_TeamName_HandleKey 28 8
proc UI_TeamMember_HandleKey 36 8
line 2334
;2332:}
;2333:
;2334:static qboolean UI_TeamMember_HandleKey(int flags, float *special, int key, qboolean blue, int num) {
line 2335
;2335:	int select = UI_SelectForKey(key);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 UI_SelectForKey
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 2336
;2336:	if (select != 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1869
line 2340
;2337:		// 0 - None
;2338:		// 1 - Human
;2339:		// 2..NumCharacters - Bot
;2340:		char *cvar = va(blue ? "ui_blueteam%i" : "ui_redteam%i", num);
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $1872
ADDRLP4 16
ADDRGP4 $907
ASGNP4
ADDRGP4 $1873
JUMPV
LABELV $1872
ADDRLP4 16
ADDRGP4 $908
ASGNP4
LABELV $1873
ADDRLP4 16
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 20
INDIRP4
ASGNP4
line 2341
;2341:		int value = trap_Cvar_VariableValue(cvar);
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 24
INDIRF4
CVFI4 4
ASGNI4
line 2343
;2342:
;2343:		value += select;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 2345
;2344:
;2345:		if (ui_actualNetGameType.integer >= GT_TEAM) {
ADDRGP4 ui_actualNetGameType+12
INDIRI4
CNSTI4 3
LTI4 $1874
line 2346
;2346:			if (value >= uiInfo.characterCount + 2) {
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+5354372
INDIRI4
CNSTI4 2
ADDI4
LTI4 $1877
line 2347
;2347:				value = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2348
;2348:			} else if (value < 0) {
ADDRGP4 $1875
JUMPV
LABELV $1877
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $1875
line 2349
;2349:				value = uiInfo.characterCount + 2 - 1;
ADDRLP4 8
ADDRGP4 uiInfo+5354372
INDIRI4
CNSTI4 2
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 2350
;2350:			}
line 2351
;2351:		} else {
ADDRGP4 $1875
JUMPV
LABELV $1874
line 2352
;2352:			if (value >= UI_GetNumBots() + 2) {
ADDRLP4 28
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 28
INDIRI4
CNSTI4 2
ADDI4
LTI4 $1883
line 2353
;2353:				value = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2354
;2354:			} else if (value < 0) {
ADDRGP4 $1884
JUMPV
LABELV $1883
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $1885
line 2355
;2355:				value = UI_GetNumBots() + 2 - 1;
ADDRLP4 32
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 32
INDIRI4
CNSTI4 2
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 2356
;2356:			}
LABELV $1885
LABELV $1884
line 2357
;2357:		}
LABELV $1875
line 2359
;2358:
;2359:		trap_Cvar_SetValue(cvar, value);
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2360
;2360:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1868
JUMPV
LABELV $1869
line 2362
;2361:	}
;2362:	return qfalse;
CNSTI4 0
RETI4
LABELV $1868
endproc UI_TeamMember_HandleKey 36 8
proc UI_NetSource_HandleKey 32 16
line 2365
;2363:}
;2364:
;2365:static qboolean UI_NetSource_HandleKey(int flags, float *special, int key) {
line 2366
;2366:	int select = UI_SelectForKey(key);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 UI_SelectForKey
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 2367
;2367:	if (select != 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1888
line 2368
;2368:		ui_netSource.integer += select;
ADDRLP4 8
ADDRGP4 ui_netSource+12
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 2370
;2369:
;2370:		if (ui_netSource.integer >= UIAS_GLOBAL1 && ui_netSource.integer <= UIAS_GLOBAL5) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 2
LTI4 $1891
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 6
GTI4 $1891
ADDRGP4 $1897
JUMPV
LABELV $1896
line 2373
;2371:			char masterstr[2], cvarname[sizeof("sv_master1")];
;2372:
;2373:			while (ui_netSource.integer >= UIAS_GLOBAL1 && ui_netSource.integer <= UIAS_GLOBAL5) {
line 2374
;2374:				Com_sprintf(cvarname, sizeof(cvarname), "sv_master%d", ui_netSource.integer - UIAS_GLOBAL0);
ADDRLP4 14
ARGP4
CNSTI4 11
ARGI4
ADDRGP4 $1901
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 2375
;2375:				trap_Cvar_VariableStringBuffer(cvarname, masterstr, sizeof(masterstr));
ADDRLP4 14
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 2376
;2376:				if (*masterstr)
ADDRLP4 12
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1903
line 2377
;2377:					break;
ADDRGP4 $1898
JUMPV
LABELV $1903
line 2379
;2378:
;2379:				ui_netSource.integer += select;
ADDRLP4 28
ADDRGP4 ui_netSource+12
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 2380
;2380:			}
LABELV $1897
line 2373
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 2
LTI4 $1906
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 6
LEI4 $1896
LABELV $1906
LABELV $1898
line 2381
;2381:		}
LABELV $1891
line 2383
;2382:
;2383:		if (ui_netSource.integer >= numNetSources) {
ADDRGP4 ui_netSource+12
INDIRI4
ADDRGP4 numNetSources
INDIRI4
LTI4 $1907
line 2384
;2384:			ui_netSource.integer = 0;
ADDRGP4 ui_netSource+12
CNSTI4 0
ASGNI4
line 2385
;2385:		} else if (ui_netSource.integer < 0) {
ADDRGP4 $1908
JUMPV
LABELV $1907
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
GEI4 $1911
line 2386
;2386:			ui_netSource.integer = numNetSources - 1;
ADDRGP4 ui_netSource+12
ADDRGP4 numNetSources
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2387
;2387:		}
LABELV $1911
LABELV $1908
line 2389
;2388:
;2389:		UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 2390
;2390:		UI_StartServerRefresh(qtrue, qfalse);
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_StartServerRefresh
CALLV
pop
line 2391
;2391:		trap_Cvar_SetValue("ui_netSource", ui_netSource.integer);
ADDRGP4 $1915
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2392
;2392:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1887
JUMPV
LABELV $1888
line 2394
;2393:	}
;2394:	return qfalse;
CNSTI4 0
RETI4
LABELV $1887
endproc UI_NetSource_HandleKey 32 16
proc UI_NetFilter_HandleKey 12 4
line 2397
;2395:}
;2396:
;2397:static qboolean UI_NetFilter_HandleKey(int flags, float *special, int key) {
line 2398
;2398:	int select = UI_SelectForKey(key);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 UI_SelectForKey
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 2399
;2399:	if (select != 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1918
line 2400
;2400:		ui_serverFilterType.integer += select;
ADDRLP4 8
ADDRGP4 ui_serverFilterType+12
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 2402
;2401:
;2402:		if (ui_serverFilterType.integer >= numServerFilters) {
ADDRGP4 ui_serverFilterType+12
INDIRI4
ADDRGP4 numServerFilters
INDIRI4
LTI4 $1921
line 2403
;2403:			ui_serverFilterType.integer = 0;
ADDRGP4 ui_serverFilterType+12
CNSTI4 0
ASGNI4
line 2404
;2404:		} else if (ui_serverFilterType.integer < 0) {
ADDRGP4 $1922
JUMPV
LABELV $1921
ADDRGP4 ui_serverFilterType+12
INDIRI4
CNSTI4 0
GEI4 $1925
line 2405
;2405:			ui_serverFilterType.integer = numServerFilters - 1;
ADDRGP4 ui_serverFilterType+12
ADDRGP4 numServerFilters
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2406
;2406:		}
LABELV $1925
LABELV $1922
line 2407
;2407:		UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 2408
;2408:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1917
JUMPV
LABELV $1918
line 2410
;2409:	}
;2410:	return qfalse;
CNSTI4 0
RETI4
LABELV $1917
endproc UI_NetFilter_HandleKey 12 4
proc UI_OpponentName_HandleKey 8 4
line 2413
;2411:}
;2412:
;2413:static qboolean UI_OpponentName_HandleKey(int flags, float *special, int key) {
line 2414
;2414:	int select = UI_SelectForKey(key);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 UI_SelectForKey
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 2415
;2415:	if (select != 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1930
line 2416
;2416:		if (select < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1932
line 2417
;2417:			UI_PriorOpponent();
ADDRGP4 UI_PriorOpponent
CALLV
pop
line 2418
;2418:		} else {
ADDRGP4 $1933
JUMPV
LABELV $1932
line 2419
;2419:			UI_NextOpponent();
ADDRGP4 UI_NextOpponent
CALLV
pop
line 2420
;2420:		}
LABELV $1933
line 2421
;2421:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1929
JUMPV
LABELV $1930
line 2423
;2422:	}
;2423:	return qfalse;
CNSTI4 0
RETI4
LABELV $1929
endproc UI_OpponentName_HandleKey 8 4
proc UI_BotName_HandleKey 28 4
line 2426
;2424:}
;2425:
;2426:static qboolean UI_BotName_HandleKey(int flags, float *special, int key) {
line 2427
;2427:	int select = UI_SelectForKey(key);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 UI_SelectForKey
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 2428
;2428:	if (select != 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1935
line 2429
;2429:		int game = trap_Cvar_VariableValue("g_gametype");
ADDRGP4 $1340
ARGP4
ADDRLP4 16
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
line 2430
;2430:		int value = uiInfo.botIndex;
ADDRLP4 8
ADDRGP4 uiInfo+5354376
INDIRI4
ASGNI4
line 2432
;2431:
;2432:		value += select;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 2434
;2433:
;2434:		if (game >= GT_TEAM) {
ADDRLP4 12
INDIRI4
CNSTI4 3
LTI4 $1938
line 2435
;2435:			if (value >= uiInfo.characterCount) {
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+5354372
INDIRI4
LTI4 $1940
line 2436
;2436:				value = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2437
;2437:			} else if (value < 0) {
ADDRGP4 $1939
JUMPV
LABELV $1940
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $1939
line 2438
;2438:				value = uiInfo.characterCount - 1;
ADDRLP4 8
ADDRGP4 uiInfo+5354372
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2439
;2439:			}
line 2440
;2440:		} else {
ADDRGP4 $1939
JUMPV
LABELV $1938
line 2441
;2441:			if (value >= UI_GetNumBots()) {
ADDRLP4 20
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRLP4 20
INDIRI4
LTI4 $1946
line 2442
;2442:				value = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2443
;2443:			} else if (value < 0) {
ADDRGP4 $1947
JUMPV
LABELV $1946
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $1948
line 2444
;2444:				value = UI_GetNumBots() - 1;
ADDRLP4 24
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 24
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2445
;2445:			}
LABELV $1948
LABELV $1947
line 2446
;2446:		}
LABELV $1939
line 2447
;2447:		uiInfo.botIndex = value;
ADDRGP4 uiInfo+5354376
ADDRLP4 8
INDIRI4
ASGNI4
line 2448
;2448:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1934
JUMPV
LABELV $1935
line 2450
;2449:	}
;2450:	return qfalse;
CNSTI4 0
RETI4
LABELV $1934
endproc UI_BotName_HandleKey 28 4
proc UI_BotSkill_HandleKey 12 4
line 2453
;2451:}
;2452:
;2453:static qboolean UI_BotSkill_HandleKey(int flags, float *special, int key) {
line 2454
;2454:	int select = UI_SelectForKey(key);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 UI_SelectForKey
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 2455
;2455:	if (select != 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1952
line 2456
;2456:		uiInfo.skillIndex += select;
ADDRLP4 8
ADDRGP4 uiInfo+5377604
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 2458
;2457:
;2458:		if (uiInfo.skillIndex >= numSkillLevels) {
ADDRGP4 uiInfo+5377604
INDIRI4
ADDRGP4 numSkillLevels
INDIRI4
LTI4 $1955
line 2459
;2459:			uiInfo.skillIndex = 0;
ADDRGP4 uiInfo+5377604
CNSTI4 0
ASGNI4
line 2460
;2460:		} else if (uiInfo.skillIndex < 0) {
ADDRGP4 $1956
JUMPV
LABELV $1955
ADDRGP4 uiInfo+5377604
INDIRI4
CNSTI4 0
GEI4 $1959
line 2461
;2461:			uiInfo.skillIndex = numSkillLevels - 1;
ADDRGP4 uiInfo+5377604
ADDRGP4 numSkillLevels
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2462
;2462:		}
LABELV $1959
LABELV $1956
line 2463
;2463:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1951
JUMPV
LABELV $1952
line 2465
;2464:	}
;2465:	return qfalse;
CNSTI4 0
RETI4
LABELV $1951
endproc UI_BotSkill_HandleKey 12 4
proc UI_RedBlue_HandleKey 12 4
line 2468
;2466:}
;2467:
;2468:static qboolean UI_RedBlue_HandleKey(int flags, float *special, int key) {
line 2469
;2469:	int select = UI_SelectForKey(key);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 UI_SelectForKey
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 2470
;2470:	if (select != 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1964
line 2471
;2471:		uiInfo.redBlue ^= 1;
ADDRLP4 8
ADDRGP4 uiInfo+5359772
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 2472
;2472:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1963
JUMPV
LABELV $1964
line 2474
;2473:	}
;2474:	return qfalse;
CNSTI4 0
RETI4
LABELV $1963
endproc UI_RedBlue_HandleKey 12 4
proc UI_Crosshair_HandleKey 16 8
line 2477
;2475:}
;2476:
;2477:static qboolean UI_Crosshair_HandleKey(int flags, float *special, int key) {
line 2478
;2478:	int select = UI_SelectForKey(key);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 UI_SelectForKey
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 2479
;2479:	if (select != 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1968
line 2480
;2480:		uiInfo.currentCrosshair += select;
ADDRLP4 8
ADDRGP4 uiInfo+5407576
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 2482
;2481:
;2482:		if (uiInfo.currentCrosshair >= NUM_CROSSHAIRS) {
ADDRGP4 uiInfo+5407576
INDIRI4
CNSTI4 30
LTI4 $1971
line 2483
;2483:			uiInfo.currentCrosshair = 0;
ADDRGP4 uiInfo+5407576
CNSTI4 0
ASGNI4
line 2484
;2484:		} else if (uiInfo.currentCrosshair < 0) {
ADDRGP4 $1972
JUMPV
LABELV $1971
ADDRGP4 uiInfo+5407576
INDIRI4
CNSTI4 0
GEI4 $1975
line 2485
;2485:			uiInfo.currentCrosshair = NUM_CROSSHAIRS - 1;
ADDRGP4 uiInfo+5407576
CNSTI4 29
ASGNI4
line 2486
;2486:		}
LABELV $1975
LABELV $1972
line 2487
;2487:		trap_Cvar_Set("cg_drawCrosshair", va("%d", uiInfo.currentCrosshair));
ADDRGP4 $727
ARGP4
ADDRGP4 uiInfo+5407576
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1979
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2488
;2488:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1967
JUMPV
LABELV $1968
line 2490
;2489:	}
;2490:	return qfalse;
CNSTI4 0
RETI4
LABELV $1967
endproc UI_Crosshair_HandleKey 16 8
proc UI_SelectedPlayer_HandleKey 20 8
line 2495
;2491:}
;2492:
;2493:
;2494:
;2495:static qboolean UI_SelectedPlayer_HandleKey(int flags, float *special, int key) {
line 2496
;2496:	int select = UI_SelectForKey(key);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 UI_SelectForKey
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 2497
;2497:	if (select != 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1982
line 2500
;2498:		int selected;
;2499:
;2500:		UI_BuildPlayerList();
ADDRGP4 UI_BuildPlayerList
CALLV
pop
line 2501
;2501:		if (!uiInfo.teamLeader) {
ADDRGP4 uiInfo+5359800
INDIRI4
CNSTI4 0
NEI4 $1984
line 2502
;2502:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1981
JUMPV
LABELV $1984
line 2504
;2503:		}
;2504:		selected = trap_Cvar_VariableValue("cg_selectedPlayer");
ADDRGP4 $1406
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
line 2506
;2505:
;2506:		selected += select;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 2508
;2507:
;2508:		if (selected > uiInfo.myTeamCount) {
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+5359780
INDIRI4
LEI4 $1987
line 2509
;2509:			selected = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2510
;2510:		} else if (selected < 0) {
ADDRGP4 $1988
JUMPV
LABELV $1987
ADDRLP4 8
INDIRI4
CNSTI4 0
GEI4 $1990
line 2511
;2511:			selected = uiInfo.myTeamCount;
ADDRLP4 8
ADDRGP4 uiInfo+5359780
INDIRI4
ASGNI4
line 2512
;2512:		}
LABELV $1990
LABELV $1988
line 2514
;2513:
;2514:		if (selected == uiInfo.myTeamCount) {
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+5359780
INDIRI4
NEI4 $1993
line 2515
;2515:			trap_Cvar_Set("cg_selectedPlayerName", "Everyone");
ADDRGP4 $1414
ARGP4
ADDRGP4 $1996
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2516
;2516:		} else {
ADDRGP4 $1994
JUMPV
LABELV $1993
line 2517
;2517:			trap_Cvar_Set("cg_selectedPlayerName", uiInfo.teamNames[selected]);
ADDRGP4 $1414
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+5361852
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2518
;2518:		}
LABELV $1994
line 2519
;2519:		trap_Cvar_Set("cg_selectedPlayer", va("%d", selected));
ADDRGP4 $727
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1406
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2520
;2520:	}
LABELV $1982
line 2521
;2521:	return qfalse;
CNSTI4 0
RETI4
LABELV $1981
endproc UI_SelectedPlayer_HandleKey 20 8
proc UI_OwnerDrawHandleKey 36 16
line 2525
;2522:}
;2523:
;2524:
;2525:static qboolean UI_OwnerDrawHandleKey(int ownerDraw, int flags, int flags2, float *special, int key) {
line 2526
;2526:	switch (ownerDraw) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 529
LTI4 $2014
ADDRLP4 0
INDIRI4
CNSTI4 537
GTI4 $2015
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2016-2116
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $2016
address $2008
address $2000
address $2009
address $2010
address $2011
address $2012
address $2013
address $2000
address $2003
code
LABELV $2014
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 513
LTI4 $2000
ADDRLP4 4
INDIRI4
CNSTI4 520
GTI4 $2000
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2018-2052
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $2018
address $2001
address $2000
address $2002
address $2000
address $2005
address $2006
address $2000
address $2007
code
LABELV $2015
ADDRFP4 0
INDIRI4
CNSTI4 545
EQI4 $2004
ADDRGP4 $2000
JUMPV
LABELV $2001
line 2528
;2527:	case UI_HANDICAP:
;2528:		return UI_Handicap_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 UI_Handicap_HandleKey
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $1998
JUMPV
line 2529
;2529:		break;
LABELV $2002
line 2531
;2530:	case UI_GAMETYPE:
;2531:		return UI_GameType_HandleKey(flags, special, key, qtrue);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 12
ADDRGP4 UI_GameType_HandleKey
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $1998
JUMPV
line 2532
;2532:		break;
LABELV $2003
line 2534
;2533:	case UI_NETGAMETYPE:
;2534:		return UI_NetGameType_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 UI_NetGameType_HandleKey
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
RETI4
ADDRGP4 $1998
JUMPV
line 2535
;2535:		break;
LABELV $2004
line 2537
;2536:	case UI_JOINGAMETYPE:
;2537:		return UI_JoinGameType_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 UI_JoinGameType_HandleKey
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $1998
JUMPV
line 2538
;2538:		break;
LABELV $2005
line 2540
;2539:	case UI_SKILL:
;2540:		return UI_Skill_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 UI_Skill_HandleKey
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
RETI4
ADDRGP4 $1998
JUMPV
line 2541
;2541:		break;
LABELV $2006
line 2543
;2542:	case UI_NETSOURCE:
;2543:		UI_NetSource_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 UI_NetSource_HandleKey
CALLI4
pop
line 2544
;2544:		break;
ADDRGP4 $2000
JUMPV
LABELV $2007
line 2546
;2545:	case UI_NETFILTER:
;2546:		UI_NetFilter_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 UI_NetFilter_HandleKey
CALLI4
pop
line 2547
;2547:		break;
ADDRGP4 $2000
JUMPV
LABELV $2008
line 2549
;2548:	case UI_OPPONENT_NAME:
;2549:		UI_OpponentName_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 UI_OpponentName_HandleKey
CALLI4
pop
line 2550
;2550:		break;
ADDRGP4 $2000
JUMPV
LABELV $2009
line 2552
;2551:	case UI_BOTNAME:
;2552:		return UI_BotName_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 UI_BotName_HandleKey
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
RETI4
ADDRGP4 $1998
JUMPV
line 2553
;2553:		break;
LABELV $2010
line 2555
;2554:	case UI_BOTSKILL:
;2555:		return UI_BotSkill_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 UI_BotSkill_HandleKey
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
RETI4
ADDRGP4 $1998
JUMPV
line 2556
;2556:		break;
LABELV $2011
line 2558
;2557:	case UI_REDBLUE:
;2558:		UI_RedBlue_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 UI_RedBlue_HandleKey
CALLI4
pop
line 2559
;2559:		break;
ADDRGP4 $2000
JUMPV
LABELV $2012
line 2561
;2560:	case UI_CROSSHAIR:
;2561:		UI_Crosshair_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 UI_Crosshair_HandleKey
CALLI4
pop
line 2562
;2562:		break;
ADDRGP4 $2000
JUMPV
LABELV $2013
line 2564
;2563:	case UI_SELECTEDPLAYER:
;2564:		UI_SelectedPlayer_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 UI_SelectedPlayer_HandleKey
CALLI4
pop
line 2565
;2565:		break;
line 2567
;2566:	default:
;2567:		break;
LABELV $2000
line 2570
;2568:	}
;2569:
;2570:	return qfalse;
CNSTI4 0
RETI4
LABELV $1998
endproc UI_OwnerDrawHandleKey 36 16
proc UI_GetValue 0 0
line 2574
;2571:}
;2572:
;2573:
;2574:static float UI_GetValue(int ownerDraw) {
line 2575
;2575:	return 0;
CNSTF4 0
RETF4
LABELV $2020
endproc UI_GetValue 0 0
proc UI_ServersQsortCompare 8 20
line 2583
;2576:}
;2577:
;2578:/*
;2579:=================
;2580:UI_ServersQsortCompare
;2581:=================
;2582:*/
;2583:static int QDECL UI_ServersQsortCompare(const void *arg1, const void *arg2) {
line 2584
;2584:	return trap_LAN_CompareServers(UI_SourceForLAN(), uiInfo.serverStatus.sortKey, uiInfo.serverStatus.sortDir, *(int *)arg1, *(int *)arg2);
ADDRLP4 0
ADDRGP4 UI_SourceForLAN
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+5387364+2200
INDIRI4
ARGI4
ADDRGP4 uiInfo+5387364+2204
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
ADDRLP4 4
ADDRGP4 trap_LAN_CompareServers
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
LABELV $2021
endproc UI_ServersQsortCompare 8 20
export UI_ServersSort
proc UI_ServersSort 0 16
line 2593
;2585:}
;2586:
;2587:
;2588:/*
;2589:=================
;2590:UI_ServersSort
;2591:=================
;2592:*/
;2593:void UI_ServersSort(int column, qboolean force) {
line 2595
;2594:
;2595:	if (!force) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $2027
line 2596
;2596:		if (uiInfo.serverStatus.sortKey == column) {
ADDRGP4 uiInfo+5387364+2200
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $2029
line 2597
;2597:			return;
ADDRGP4 $2026
JUMPV
LABELV $2029
line 2599
;2598:		}
;2599:	}
LABELV $2027
line 2601
;2600:
;2601:	uiInfo.serverStatus.sortKey = column;
ADDRGP4 uiInfo+5387364+2200
ADDRFP4 0
INDIRI4
ASGNI4
line 2602
;2602:	qsort(&uiInfo.serverStatus.displayServers[0], uiInfo.serverStatus.numDisplayServers, sizeof(int), UI_ServersQsortCompare);
ADDRGP4 uiInfo+5387364+2220
ARGP4
ADDRGP4 uiInfo+5387364+10412
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 UI_ServersQsortCompare
ARGP4
ADDRGP4 qsort
CALLV
pop
line 2605
;2603:
;2604:	// update displayed levelshot
;2605:	UI_FeederSelection(FEEDER_SERVERS, uiInfo.serverStatus.currentServer);
CNSTF4 1073741824
ARGF4
ADDRGP4 uiInfo+5387364+2216
INDIRI4
ARGI4
ADDRGP4 UI_FeederSelection
CALLV
pop
line 2606
;2606:}
LABELV $2026
endproc UI_ServersSort 0 16
proc UI_LoadMods 2092 16
line 2653
;2607:
;2608:/*
;2609:static void UI_StartSinglePlayer() {
;2610:	int i,j, k, skill;
;2611:	char buff[1024];
;2612:	i = trap_Cvar_VariableValue( "ui_currentTier" );
;2613:  if (i < 0 || i >= tierCount) {
;2614:	i = 0;
;2615:  }
;2616:	j = trap_Cvar_VariableValue("ui_currentMap");
;2617:	if (j < 0 || j >= MAPS_PER_TIER) {
;2618:		j = 0;
;2619:	}
;2620:
;2621:	trap_Cvar_SetValue( "singleplayer", 1 );
;2622:	trap_Cvar_SetValue( "g_gametype", Com_Clamp( 0, GT_MAX_GAME_TYPE-1, tierList[i].gameTypes[j] ) );
;2623:	trap_Cmd_ExecuteText( EXEC_APPEND, va( "wait ; wait ; map %s\n", tierList[i].maps[j] ) );
;2624:	skill = trap_Cvar_VariableValue( "g_spSkill" );
;2625:
;2626:	if (j == MAPS_PER_TIER-1) {
;2627:		k = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
;2628:		Com_sprintf( buff, sizeof(buff), "wait ; addbot %s %i %s 250 %s\n", UI_AIFromName(teamList[k].teamMembers[0]), skill, "", teamList[k].teamMembers[0]);
;2629:	} else {
;2630:		k = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
;2631:		for (i = 0; i < PLAYERS_PER_TEAM; i++) {
;2632:			Com_sprintf( buff, sizeof(buff), "wait ; addbot %s %i %s 250 %s\n", UI_AIFromName(teamList[k].teamMembers[i]), skill, "Blue", teamList[k].teamMembers[i]);
;2633:			trap_Cmd_ExecuteText( EXEC_APPEND, buff );
;2634:		}
;2635:
;2636:		k = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
;2637:		for (i = 1; i < PLAYERS_PER_TEAM; i++) {
;2638:			Com_sprintf( buff, sizeof(buff), "wait ; addbot %s %i %s 250 %s\n", UI_AIFromName(teamList[k].teamMembers[i]), skill, "Red", teamList[k].teamMembers[i]);
;2639:			trap_Cmd_ExecuteText( EXEC_APPEND, buff );
;2640:		}
;2641:		trap_Cmd_ExecuteText( EXEC_APPEND, "wait 5; team Red\n" );
;2642:	}
;2643:
;2644:
;2645:}
;2646:*/
;2647:
;2648:/*
;2649:===============
;2650:UI_LoadMods
;2651:===============
;2652:*/
;2653:static void UI_LoadMods() {
line 2661
;2654:	int		numdirs;
;2655:	char	dirlist[2048];
;2656:	char *dirptr;
;2657:	char *descptr;
;2658:	int		i;
;2659:	int		dirlen;
;2660:
;2661:	uiInfo.modCount = 0;
ADDRGP4 uiInfo+5378120
CNSTI4 0
ASGNI4
line 2662
;2662:	numdirs = trap_FS_GetFileList("$modlist", "", dirlist, sizeof(dirlist));
ADDRGP4 $2043
ARGP4
ADDRGP4 $114
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
line 2663
;2663:	dirptr = dirlist;
ADDRLP4 0
ADDRLP4 20
ASGNP4
line 2664
;2664:	for (i = 0; i < numdirs; i++) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $2047
JUMPV
LABELV $2044
line 2665
;2665:		dirlen = strlen(dirptr) + 1;
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
line 2666
;2666:		descptr = dirptr + dirlen;
ADDRLP4 4
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 2667
;2667:		uiInfo.modList[uiInfo.modCount].modName = String_Alloc(dirptr);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 2076
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+5378120
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5377608
ADDP4
ADDRLP4 2076
INDIRP4
ASGNP4
line 2668
;2668:		uiInfo.modList[uiInfo.modCount].modDescr = String_Alloc(descptr);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 2080
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+5378120
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5377608+4
ADDP4
ADDRLP4 2080
INDIRP4
ASGNP4
line 2669
;2669:		dirptr += dirlen + strlen(descptr) + 1;
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
line 2670
;2670:		uiInfo.modCount++;
ADDRLP4 2088
ADDRGP4 uiInfo+5378120
ASGNP4
ADDRLP4 2088
INDIRP4
ADDRLP4 2088
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2671
;2671:		if (uiInfo.modCount >= MAX_MODS) {
ADDRGP4 uiInfo+5378120
INDIRI4
CNSTI4 64
LTI4 $2054
line 2672
;2672:			break;
ADDRGP4 $2046
JUMPV
LABELV $2054
line 2674
;2673:		}
;2674:	}
LABELV $2045
line 2664
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2047
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $2044
LABELV $2046
line 2676
;2675:
;2676:}
LABELV $2041
endproc UI_LoadMods 2092 16
proc UI_LoadTeams 4120 16
line 2684
;2677:
;2678:
;2679:/*
;2680:===============
;2681:UI_LoadTeams
;2682:===============
;2683:*/
;2684:static void UI_LoadTeams() {
line 2689
;2685:	char	teamList[4096];
;2686:	char *teamName;
;2687:	int		i, len, count;
;2688:
;2689:	count = trap_FS_GetFileList("", "team", teamList, 4096);
ADDRGP4 $114
ARGP4
ADDRGP4 $2058
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
line 2691
;2690:
;2691:	if (count) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2059
line 2692
;2692:		teamName = teamList;
ADDRLP4 0
ADDRLP4 16
ASGNP4
line 2693
;2693:		for (i = 0; i < count; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2064
JUMPV
LABELV $2061
line 2694
;2694:			len = strlen(teamName);
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
line 2695
;2695:			UI_ParseTeamInfo(teamName);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 UI_ParseTeamInfo
CALLV
pop
line 2696
;2696:			teamName += len + 1;
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 2697
;2697:		}
LABELV $2062
line 2693
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2064
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $2061
line 2698
;2698:	}
LABELV $2059
line 2700
;2699:
;2700:}
LABELV $2057
endproc UI_LoadTeams 4120 16
proc UI_LoadMovies 4124 16
line 2708
;2701:
;2702:
;2703:/*
;2704:===============
;2705:UI_LoadMovies
;2706:===============
;2707:*/
;2708:static void UI_LoadMovies() {
line 2713
;2709:	char	movielist[4096];
;2710:	char *moviename;
;2711:	int		i, len;
;2712:
;2713:	uiInfo.movieCount = trap_FS_GetFileList("video", "roq", movielist, 4096);
ADDRGP4 $2067
ARGP4
ADDRGP4 $2068
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 4096
ARGI4
ADDRLP4 4108
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRGP4 uiInfo+5387352
ADDRLP4 4108
INDIRI4
ASGNI4
line 2715
;2714:
;2715:	if (uiInfo.movieCount) {
ADDRGP4 uiInfo+5387352
INDIRI4
CNSTI4 0
EQI4 $2069
line 2716
;2716:		if (uiInfo.movieCount > MAX_MOVIES) {
ADDRGP4 uiInfo+5387352
INDIRI4
CNSTI4 256
LEI4 $2072
line 2717
;2717:			uiInfo.movieCount = MAX_MOVIES;
ADDRGP4 uiInfo+5387352
CNSTI4 256
ASGNI4
line 2718
;2718:		}
LABELV $2072
line 2719
;2719:		moviename = movielist;
ADDRLP4 0
ADDRLP4 12
ASGNP4
line 2720
;2720:		for (i = 0; i < uiInfo.movieCount; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $2079
JUMPV
LABELV $2076
line 2721
;2721:			len = strlen(moviename);
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
line 2722
;2722:			if (!Q_stricmp(moviename + len - 4, ".roq")) {
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
CNSTI4 -4
ADDP4
ARGP4
ADDRGP4 $2083
ARGP4
ADDRLP4 4116
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4116
INDIRI4
CNSTI4 0
NEI4 $2081
line 2723
;2723:				moviename[len - 4] = '\0';
ADDRLP4 4
INDIRI4
CNSTI4 4
SUBI4
ADDRLP4 0
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 2724
;2724:			}
LABELV $2081
line 2725
;2725:			Q_strupr(moviename);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 2726
;2726:			uiInfo.movieList[i] = String_Alloc(moviename);
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
ADDRGP4 uiInfo+5386328
ADDP4
ADDRLP4 4120
INDIRP4
ASGNP4
line 2727
;2727:			moviename += len + 1;
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 2728
;2728:		}
LABELV $2077
line 2720
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2079
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+5387352
INDIRI4
LTI4 $2076
line 2729
;2729:	}
LABELV $2069
line 2731
;2730:
;2731:}
LABELV $2065
endproc UI_LoadMovies 4124 16
proc UI_LoadDemos 4168 16
line 2740
;2732:
;2733:
;2734:
;2735:/*
;2736:===============
;2737:UI_LoadDemos
;2738:===============
;2739:*/
;2740:static void UI_LoadDemos() {
line 2746
;2741:	char	demolist[4096];
;2742:	char demoExt[32];
;2743:	char *demoname;
;2744:	int		i, len;
;2745:
;2746:	Com_sprintf(demoExt, sizeof(demoExt), "dm_%d", (int)trap_Cvar_VariableValue("protocol"));
ADDRGP4 $2087
ARGP4
ADDRLP4 4140
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $2086
ARGP4
ADDRLP4 4140
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 2748
;2747:
;2748:	uiInfo.demoCount = trap_FS_GetFileList("demos", demoExt, demolist, 4096);
ADDRGP4 $2089
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
ADDRGP4 uiInfo+5386320
ADDRLP4 4144
INDIRI4
ASGNI4
line 2750
;2749:
;2750:	Com_sprintf(demoExt, sizeof(demoExt), ".dm_%d", (int)trap_Cvar_VariableValue("protocol"));
ADDRGP4 $2087
ARGP4
ADDRLP4 4148
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $2090
ARGP4
ADDRLP4 4148
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 2752
;2751:
;2752:	if (uiInfo.demoCount) {
ADDRGP4 uiInfo+5386320
INDIRI4
CNSTI4 0
EQI4 $2091
line 2753
;2753:		if (uiInfo.demoCount > MAX_DEMOS) {
ADDRGP4 uiInfo+5386320
INDIRI4
CNSTI4 2048
LEI4 $2094
line 2754
;2754:			uiInfo.demoCount = MAX_DEMOS;
ADDRGP4 uiInfo+5386320
CNSTI4 2048
ASGNI4
line 2755
;2755:		}
LABELV $2094
line 2756
;2756:		demoname = demolist;
ADDRLP4 0
ADDRLP4 44
ASGNP4
line 2757
;2757:		for (i = 0; i < uiInfo.demoCount; i++) {
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRGP4 $2101
JUMPV
LABELV $2098
line 2758
;2758:			len = strlen(demoname);
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
line 2759
;2759:			if (!Q_stricmp(demoname + len - strlen(demoExt), demoExt)) {
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
NEI4 $2103
line 2760
;2760:				demoname[len - strlen(demoExt)] = '\0';
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
line 2761
;2761:			}
LABELV $2103
line 2762
;2762:			Q_strupr(demoname);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 2763
;2763:			uiInfo.demoList[i] = String_Alloc(demoname);
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
ADDRGP4 uiInfo+5378128
ADDP4
ADDRLP4 4164
INDIRP4
ASGNP4
line 2764
;2764:			demoname += len + 1;
ADDRLP4 0
ADDRLP4 36
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 2765
;2765:		}
LABELV $2099
line 2757
ADDRLP4 40
ADDRLP4 40
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2101
ADDRLP4 40
INDIRI4
ADDRGP4 uiInfo+5386320
INDIRI4
LTI4 $2098
line 2766
;2766:	}
LABELV $2091
line 2768
;2767:
;2768:}
LABELV $2085
endproc UI_LoadDemos 4168 16
proc UI_SetNextMap 4 16
line 2771
;2769:
;2770:
;2771:static qboolean UI_SetNextMap(int actual, int index) {
line 2773
;2772:	int i;
;2773:	for (i = actual + 1; i < uiInfo.mapCount; i++) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $2110
JUMPV
LABELV $2107
line 2774
;2774:		if (uiInfo.mapList[i].active) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+96
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2112
line 2775
;2775:			Menu_SetFeederSelection(NULL, FEEDER_MAPS, index + 1, "skirmish");
CNSTP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 $2116
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 2776
;2776:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2106
JUMPV
LABELV $2112
line 2778
;2777:		}
;2778:	}
LABELV $2108
line 2773
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2110
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5364156
INDIRI4
LTI4 $2107
line 2779
;2779:	return qfalse;
CNSTI4 0
RETI4
LABELV $2106
endproc UI_SetNextMap 4 16
proc UI_StartSkirmish 1160 32
line 2783
;2780:}
;2781:
;2782:
;2783:static void UI_StartSkirmish(qboolean next) {
line 2788
;2784:	int i, k, g, delay, temp;
;2785:	float skill;
;2786:	char buff[MAX_STRING_CHARS];
;2787:
;2788:	if (next) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $2118
line 2790
;2789:		int actual;
;2790:		int index = trap_Cvar_VariableValue("ui_mapIndex");
ADDRGP4 $2120
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
line 2791
;2791:		UI_MapCountByGameType();
ADDRGP4 UI_MapCountByGameType
CALLI4
pop
line 2792
;2792:		UI_SelectedMap(index, &actual);
ADDRLP4 1048
INDIRI4
ARGI4
ADDRLP4 1052
ARGP4
ADDRGP4 UI_SelectedMap
CALLP4
pop
line 2793
;2793:		if (UI_SetNextMap(actual, index)) {
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
EQI4 $2121
line 2794
;2794:		} else {
ADDRGP4 $2122
JUMPV
LABELV $2121
line 2795
;2795:			UI_GameType_HandleKey(0, NULL, K_MOUSE1, qfalse);
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
line 2796
;2796:			UI_MapCountByGameType();
ADDRGP4 UI_MapCountByGameType
CALLI4
pop
line 2797
;2797:			Menu_SetFeederSelection(NULL, FEEDER_MAPS, 0, "skirmish");
CNSTP4 0
ARGP4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 $2116
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 2798
;2798:		}
LABELV $2122
line 2799
;2799:	}
LABELV $2118
line 2801
;2800:
;2801:	g = uiInfo.gameTypes[ui_gameType.integer].gtEnum;
ADDRLP4 1040
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359512+4
ADDP4
INDIRI4
ASGNI4
line 2802
;2802:	trap_Cvar_SetValue("g_gametype", g);
ADDRGP4 $1340
ARGP4
ADDRLP4 1040
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2803
;2803:	trap_Cmd_ExecuteText(EXEC_APPEND, va("wait ; wait ; map %s\n", uiInfo.mapList[ui_currentMap.integer].mapLoadName));
ADDRGP4 $2126
ARGP4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+4
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
line 2804
;2804:	skill = trap_Cvar_VariableValue("g_spSkill");
ADDRGP4 $885
ARGP4
ADDRLP4 1052
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1044
ADDRLP4 1052
INDIRF4
ASGNF4
line 2805
;2805:	trap_Cvar_Set("ui_scoreMap", uiInfo.mapList[ui_currentMap.integer].mapName);
ADDRGP4 $2130
ARGP4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2807
;2806:
;2807:	k = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1147
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
line 2809
;2808:
;2809:	trap_Cvar_Set("ui_singlePlayerActive", "1");
ADDRGP4 $2133
ARGP4
ADDRGP4 $396
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2812
;2810:
;2811:	// set up sp overrides, will be replaced on postgame
;2812:	temp = trap_Cvar_VariableValue("capturelimit");
ADDRGP4 $729
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
line 2813
;2813:	trap_Cvar_Set("ui_saveCaptureLimit", va("%i", temp));
ADDRGP4 $1851
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1068
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2134
ARGP4
ADDRLP4 1068
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2814
;2814:	temp = trap_Cvar_VariableValue("fraglimit");
ADDRGP4 $730
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
line 2815
;2815:	trap_Cvar_Set("ui_saveFragLimit", va("%i", temp));
ADDRGP4 $1851
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1076
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2135
ARGP4
ADDRLP4 1076
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2817
;2816:
;2817:	UI_SetCapFragLimits(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_SetCapFragLimits
CALLV
pop
line 2819
;2818:
;2819:	temp = trap_Cvar_VariableValue("cg_drawTimer");
ADDRGP4 $2136
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
line 2820
;2820:	trap_Cvar_Set("ui_drawTimer", va("%i", temp));
ADDRGP4 $1851
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1084
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2137
ARGP4
ADDRLP4 1084
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2821
;2821:	temp = trap_Cvar_VariableValue("g_doWarmup");
ADDRGP4 $2138
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
line 2822
;2822:	trap_Cvar_Set("ui_doWarmup", va("%i", temp));
ADDRGP4 $1851
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1092
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2139
ARGP4
ADDRLP4 1092
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2823
;2823:	temp = trap_Cvar_VariableValue("g_friendlyFire");
ADDRGP4 $2140
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
line 2824
;2824:	trap_Cvar_Set("ui_friendlyFire", va("%i", temp));
ADDRGP4 $1851
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1100
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2141
ARGP4
ADDRLP4 1100
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2825
;2825:	temp = trap_Cvar_VariableValue("sv_maxClients");
ADDRGP4 $2142
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
line 2826
;2826:	trap_Cvar_Set("ui_maxClients", va("%i", temp));
ADDRGP4 $1851
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1108
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2143
ARGP4
ADDRLP4 1108
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2827
;2827:	temp = trap_Cvar_VariableValue("g_warmup");
ADDRGP4 $2144
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
line 2828
;2828:	trap_Cvar_Set("ui_Warmup", va("%i", temp));
ADDRGP4 $1851
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1116
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2145
ARGP4
ADDRLP4 1116
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2829
;2829:	temp = trap_Cvar_VariableValue("sv_pure");
ADDRGP4 $2146
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
line 2830
;2830:	trap_Cvar_Set("ui_pure", va("%i", temp));
ADDRGP4 $1851
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1124
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2147
ARGP4
ADDRLP4 1124
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2832
;2831:
;2832:	trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $393
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2833
;2833:	trap_Cvar_Set("cg_drawTimer", "1");
ADDRGP4 $2136
ARGP4
ADDRGP4 $396
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2834
;2834:	trap_Cvar_Set("g_doWarmup", "1");
ADDRGP4 $2138
ARGP4
ADDRGP4 $396
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2835
;2835:	trap_Cvar_Set("g_warmup", "15");
ADDRGP4 $2144
ARGP4
ADDRGP4 $706
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2836
;2836:	trap_Cvar_Set("sv_pure", "0");
ADDRGP4 $2146
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2837
;2837:	trap_Cvar_Set("g_friendlyFire", "0");
ADDRGP4 $2140
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2838
;2838:	trap_Cvar_Set("g_redTeam", UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $712
ARGP4
ADDRLP4 1128
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2148
ARGP4
ADDRLP4 1128
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2839
;2839:	trap_Cvar_Set("g_blueTeam", UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1147
ARGP4
ADDRLP4 1132
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2149
ARGP4
ADDRLP4 1132
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2841
;2840:
;2841:	if (trap_Cvar_VariableValue("ui_recordSPDemo")) {
ADDRGP4 $2152
ARGP4
ADDRLP4 1136
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1136
INDIRF4
CNSTF4 0
EQF4 $2150
line 2842
;2842:		Com_sprintf(buff, MAX_STRING_CHARS, "%s_%i", uiInfo.mapList[ui_currentMap.integer].mapLoadName, g);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2153
ARGP4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 2843
;2843:		trap_Cvar_Set("ui_recordSPDemoName", buff);
ADDRGP4 $2157
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2844
;2844:	}
LABELV $2150
line 2846
;2845:
;2846:	delay = 500;
ADDRLP4 1032
CNSTI4 500
ASGNI4
line 2848
;2847:
;2848:	if (g == GT_DUEL) {
ADDRLP4 1040
INDIRI4
CNSTI4 1
NEI4 $2158
line 2849
;2849:		trap_Cvar_Set("sv_maxClients", "2");
ADDRGP4 $2142
ARGP4
ADDRGP4 $2160
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2850
;2850:		Com_sprintf(buff, sizeof(buff), "wait ; addbot %s %f "", %i \n", uiInfo.mapList[ui_currentMap.integer].opponentName, skill, delay);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2161
ARGP4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+12
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
line 2851
;2851:		trap_Cmd_ExecuteText(EXEC_APPEND, buff);
CNSTI4 2
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 2852
;2852:	} else {
ADDRGP4 $2159
JUMPV
LABELV $2158
line 2853
;2853:		temp = uiInfo.mapList[ui_currentMap.integer].teamMembers * 2;
ADDRLP4 1036
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+16
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 2854
;2854:		trap_Cvar_Set("sv_maxClients", va("%d", temp));
ADDRGP4 $727
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 1140
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2142
ARGP4
ADDRLP4 1140
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2855
;2855:		for (i = 0; i < uiInfo.mapList[ui_currentMap.integer].teamMembers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2171
JUMPV
LABELV $2168
line 2856
;2856:			Com_sprintf(buff, sizeof(buff), "addbot %s %f %s %i %s\n", UI_AIFromName(uiInfo.teamList[k].teamMembers[i]), skill, (g == GT_FFA) ? "" : "Blue", delay, uiInfo.teamList[k].teamMembers[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1028
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+8
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
ADDRGP4 $2175
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
NEI4 $2181
ADDRLP4 1144
ADDRGP4 $114
ASGNP4
ADDRGP4 $2182
JUMPV
LABELV $2181
ADDRLP4 1144
ADDRGP4 $900
ASGNP4
LABELV $2182
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
ADDRGP4 uiInfo+5356692+8
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 2857
;2857:			trap_Cmd_ExecuteText(EXEC_APPEND, buff);
CNSTI4 2
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 2858
;2858:			delay += 500;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 2859
;2859:		}
LABELV $2169
line 2855
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2171
ADDRLP4 0
INDIRI4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+16
ADDP4
INDIRI4
LTI4 $2168
line 2860
;2860:		k = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $712
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
line 2861
;2861:		for (i = 0; i < uiInfo.mapList[ui_currentMap.integer].teamMembers - 1; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2186
JUMPV
LABELV $2183
line 2862
;2862:			Com_sprintf(buff, sizeof(buff), "addbot %s %f %s %i %s\n", UI_AIFromName(uiInfo.teamList[k].teamMembers[i]), skill, (g == GT_FFA) ? "" : "Red", delay, uiInfo.teamList[k].teamMembers[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1028
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+8
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
ADDRGP4 $2175
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
NEI4 $2195
ADDRLP4 1152
ADDRGP4 $114
ASGNP4
ADDRGP4 $2196
JUMPV
LABELV $2195
ADDRLP4 1152
ADDRGP4 $901
ASGNP4
LABELV $2196
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
ADDRGP4 uiInfo+5356692+8
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 2863
;2863:			trap_Cmd_ExecuteText(EXEC_APPEND, buff);
CNSTI4 2
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 2864
;2864:			delay += 500;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 2865
;2865:		}
LABELV $2184
line 2861
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2186
ADDRLP4 0
INDIRI4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+16
ADDP4
INDIRI4
CNSTI4 1
SUBI4
LTI4 $2183
line 2866
;2866:	}
LABELV $2159
line 2867
;2867:	if (g >= GT_TEAM) {
ADDRLP4 1040
INDIRI4
CNSTI4 3
LTI4 $2197
line 2868
;2868:		trap_Cmd_ExecuteText(EXEC_APPEND, "wait 5; team Red\n");
CNSTI4 2
ARGI4
ADDRGP4 $2199
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 2869
;2869:	}
LABELV $2197
line 2870
;2870:}
LABELV $2117
endproc UI_StartSkirmish 1160 32
proc UI_Update 36 8
line 2872
;2871:
;2872:static void UI_Update(const char *name) {
line 2873
;2873:	int	val = trap_Cvar_VariableValue(name);
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
line 2875
;2874:
;2875:	if (Q_stricmp(name, "ui_SetName") == 0) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2203
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2201
line 2876
;2876:		trap_Cvar_Set("name", UI_Cvar_VariableString("ui_Name"));
ADDRGP4 $2204
ARGP4
ADDRLP4 12
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $1424
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2877
;2877:	} else if (Q_stricmp(name, "ui_setRate") == 0) {
ADDRGP4 $2202
JUMPV
LABELV $2201
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2207
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2205
line 2878
;2878:		float rate = trap_Cvar_VariableValue("rate");
ADDRGP4 $2208
ARGP4
ADDRLP4 20
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 20
INDIRF4
ASGNF4
line 2879
;2879:		if (rate >= 5000) {
ADDRLP4 16
INDIRF4
CNSTF4 1167867904
LTF4 $2209
line 2880
;2880:			trap_Cvar_Set("cl_maxpackets", "30");
ADDRGP4 $2211
ARGP4
ADDRGP4 $703
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2881
;2881:			trap_Cvar_Set("cl_packetdup", "1");
ADDRGP4 $2212
ARGP4
ADDRGP4 $396
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2882
;2882:		} else if (rate >= 4000) {
ADDRGP4 $2206
JUMPV
LABELV $2209
ADDRLP4 16
INDIRF4
CNSTF4 1165623296
LTF4 $2213
line 2883
;2883:			trap_Cvar_Set("cl_maxpackets", "15");
ADDRGP4 $2211
ARGP4
ADDRGP4 $706
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2884
;2884:			trap_Cvar_Set("cl_packetdup", "2");		// favor less prediction errors when there's packet loss
ADDRGP4 $2212
ARGP4
ADDRGP4 $2160
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2885
;2885:		} else {
ADDRGP4 $2206
JUMPV
LABELV $2213
line 2886
;2886:			trap_Cvar_Set("cl_maxpackets", "15");
ADDRGP4 $2211
ARGP4
ADDRGP4 $706
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2887
;2887:			trap_Cvar_Set("cl_packetdup", "1");		// favor lower bandwidth
ADDRGP4 $2212
ARGP4
ADDRGP4 $396
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2888
;2888:		}
line 2889
;2889:	} else if (Q_stricmp(name, "ui_GetName") == 0) {
ADDRGP4 $2206
JUMPV
LABELV $2205
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2217
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $2215
line 2890
;2890:		trap_Cvar_Set("ui_Name", UI_Cvar_VariableString("name"));
ADDRGP4 $1424
ARGP4
ADDRLP4 20
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2204
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2891
;2891:	} else if (Q_stricmp(name, "r_colorbits") == 0) {
ADDRGP4 $2216
JUMPV
LABELV $2215
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2220
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $2218
line 2892
;2892:		switch (val) {
ADDRLP4 24
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 16
EQI4 $2226
ADDRLP4 24
INDIRI4
CNSTI4 16
GTI4 $2229
LABELV $2228
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2223
ADDRGP4 $2219
JUMPV
LABELV $2229
ADDRLP4 0
INDIRI4
CNSTI4 32
EQI4 $2227
ADDRGP4 $2219
JUMPV
LABELV $2223
line 2894
;2893:		case 0:
;2894:			trap_Cvar_SetValue("r_depthbits", 0);
ADDRGP4 $2224
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2895
;2895:			trap_Cvar_SetValue("r_stencilbits", 0);
ADDRGP4 $2225
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2896
;2896:			break;
ADDRGP4 $2219
JUMPV
LABELV $2226
line 2898
;2897:		case 16:
;2898:			trap_Cvar_SetValue("r_depthbits", 16);
ADDRGP4 $2224
ARGP4
CNSTF4 1098907648
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2899
;2899:			trap_Cvar_SetValue("r_stencilbits", 0);
ADDRGP4 $2225
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2900
;2900:			break;
ADDRGP4 $2219
JUMPV
LABELV $2227
line 2902
;2901:		case 32:
;2902:			trap_Cvar_SetValue("r_depthbits", 24);
ADDRGP4 $2224
ARGP4
CNSTF4 1103101952
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2903
;2903:			break;
line 2905
;2904:		}
;2905:	} else if (Q_stricmp(name, "r_lodbias") == 0) {
ADDRGP4 $2219
JUMPV
LABELV $2218
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2232
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $2230
line 2906
;2906:		switch (val) {
ADDRLP4 28
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2235
ADDRLP4 28
INDIRI4
CNSTI4 1
EQI4 $2237
ADDRLP4 28
INDIRI4
CNSTI4 2
EQI4 $2238
ADDRGP4 $2231
JUMPV
LABELV $2235
line 2908
;2907:		case 0:
;2908:			trap_Cvar_SetValue("r_subdivisions", 4);
ADDRGP4 $2236
ARGP4
CNSTF4 1082130432
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2909
;2909:			break;
ADDRGP4 $2231
JUMPV
LABELV $2237
line 2911
;2910:		case 1:
;2911:			trap_Cvar_SetValue("r_subdivisions", 12);
ADDRGP4 $2236
ARGP4
CNSTF4 1094713344
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2912
;2912:			break;
ADDRGP4 $2231
JUMPV
LABELV $2238
line 2914
;2913:		case 2:
;2914:			trap_Cvar_SetValue("r_subdivisions", 20);
ADDRGP4 $2236
ARGP4
CNSTF4 1101004800
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2915
;2915:			break;
line 2917
;2916:		}
;2917:	} else if (Q_stricmp(name, "ui_glCustom") == 0) {
ADDRGP4 $2231
JUMPV
LABELV $2230
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2241
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $2239
line 2918
;2918:		switch (val) {
ADDRLP4 32
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
LTI4 $2240
ADDRLP4 32
INDIRI4
CNSTI4 3
GTI4 $2240
ADDRLP4 32
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2263
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $2263
address $2244
address $2258
address $2260
address $2262
code
LABELV $2244
line 2920
;2919:		case 0:	// high quality
;2920:			trap_Cvar_SetValue("r_fullScreen", 1);
ADDRGP4 $2245
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2921
;2921:			trap_Cvar_SetValue("r_subdivisions", 4);
ADDRGP4 $2236
ARGP4
CNSTF4 1082130432
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2922
;2922:			trap_Cvar_SetValue("r_vertexlight", 0);
ADDRGP4 $2246
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2923
;2923:			trap_Cvar_SetValue("r_lodbias", 0);
ADDRGP4 $2232
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2924
;2924:			trap_Cvar_SetValue("r_colorbits", 32);
ADDRGP4 $2220
ARGP4
CNSTF4 1107296256
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2925
;2925:			trap_Cvar_SetValue("r_depthbits", 24);
ADDRGP4 $2224
ARGP4
CNSTF4 1103101952
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2926
;2926:			trap_Cvar_SetValue("r_stencilbits", 8);
ADDRGP4 $2225
ARGP4
CNSTF4 1090519040
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2927
;2927:			trap_Cvar_SetValue("r_picmip", 0);
ADDRGP4 $2247
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2928
;2928:			trap_Cvar_SetValue("r_mode", 4);
ADDRGP4 $2248
ARGP4
CNSTF4 1082130432
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2929
;2929:			trap_Cvar_Set("ui_videomode", "800x600");
ADDRGP4 $2249
ARGP4
ADDRGP4 $2250
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2930
;2930:			trap_Cvar_SetValue("r_texturebits", 32);
ADDRGP4 $2251
ARGP4
CNSTF4 1107296256
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2931
;2931:			trap_Cvar_SetValue("r_fastSky", 0);
ADDRGP4 $2252
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2932
;2932:			trap_Cvar_SetValue("r_inGameVideo", 1);
ADDRGP4 $2253
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2933
;2933:			trap_Cvar_SetValue("cg_shadows", 1);
ADDRGP4 $2254
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2934
;2934:			trap_Cvar_SetValue("cg_brassTime", 2500);
ADDRGP4 $2255
ARGP4
CNSTF4 1159479296
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2935
;2935:			trap_Cvar_Set("r_texturemode", "GL_LINEAR_MIPMAP_LINEAR");
ADDRGP4 $2256
ARGP4
ADDRGP4 $2257
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2936
;2936:			break;
ADDRGP4 $2240
JUMPV
LABELV $2258
line 2938
;2937:		case 1: // normal 
;2938:			trap_Cvar_SetValue("r_fullScreen", 1);
ADDRGP4 $2245
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2939
;2939:			trap_Cvar_SetValue("r_subdivisions", 12);
ADDRGP4 $2236
ARGP4
CNSTF4 1094713344
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2940
;2940:			trap_Cvar_SetValue("r_vertexlight", 0);
ADDRGP4 $2246
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2941
;2941:			trap_Cvar_SetValue("r_lodbias", 0);
ADDRGP4 $2232
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2942
;2942:			trap_Cvar_SetValue("r_colorbits", 0);
ADDRGP4 $2220
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2943
;2943:			trap_Cvar_SetValue("r_depthbits", 0);
ADDRGP4 $2224
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2944
;2944:			trap_Cvar_Reset("r_stencilbits");
ADDRGP4 $2225
ARGP4
ADDRGP4 trap_Cvar_Reset
CALLV
pop
line 2945
;2945:			trap_Cvar_SetValue("r_picmip", 1);
ADDRGP4 $2247
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2946
;2946:			trap_Cvar_SetValue("r_mode", 3);
ADDRGP4 $2248
ARGP4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2947
;2947:			trap_Cvar_Set("ui_videomode", "640x480");
ADDRGP4 $2249
ARGP4
ADDRGP4 $2259
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2948
;2948:			trap_Cvar_SetValue("r_texturebits", 0);
ADDRGP4 $2251
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2949
;2949:			trap_Cvar_SetValue("r_fastSky", 0);
ADDRGP4 $2252
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2950
;2950:			trap_Cvar_SetValue("r_inGameVideo", 1);
ADDRGP4 $2253
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2951
;2951:			trap_Cvar_SetValue("cg_brassTime", 2500);
ADDRGP4 $2255
ARGP4
CNSTF4 1159479296
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2952
;2952:			trap_Cvar_Set("r_texturemode", "GL_LINEAR_MIPMAP_LINEAR");
ADDRGP4 $2256
ARGP4
ADDRGP4 $2257
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2953
;2953:			trap_Cvar_SetValue("cg_shadows", 0);
ADDRGP4 $2254
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2954
;2954:			break;
ADDRGP4 $2240
JUMPV
LABELV $2260
line 2956
;2955:		case 2: // fast
;2956:			trap_Cvar_SetValue("r_fullScreen", 1);
ADDRGP4 $2245
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2957
;2957:			trap_Cvar_SetValue("r_subdivisions", 8);
ADDRGP4 $2236
ARGP4
CNSTF4 1090519040
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2958
;2958:			trap_Cvar_SetValue("r_vertexlight", 0);
ADDRGP4 $2246
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2959
;2959:			trap_Cvar_SetValue("r_lodbias", 1);
ADDRGP4 $2232
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2960
;2960:			trap_Cvar_SetValue("r_colorbits", 0);
ADDRGP4 $2220
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2961
;2961:			trap_Cvar_SetValue("r_depthbits", 0);
ADDRGP4 $2224
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2962
;2962:			trap_Cvar_Reset("r_stencilbits");
ADDRGP4 $2225
ARGP4
ADDRGP4 trap_Cvar_Reset
CALLV
pop
line 2963
;2963:			trap_Cvar_SetValue("r_picmip", 1);
ADDRGP4 $2247
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2964
;2964:			trap_Cvar_SetValue("r_mode", 3);
ADDRGP4 $2248
ARGP4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2965
;2965:			trap_Cvar_Set("ui_videomode", "640x480");
ADDRGP4 $2249
ARGP4
ADDRGP4 $2259
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2966
;2966:			trap_Cvar_SetValue("r_texturebits", 0);
ADDRGP4 $2251
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2967
;2967:			trap_Cvar_SetValue("cg_shadows", 0);
ADDRGP4 $2254
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2968
;2968:			trap_Cvar_SetValue("r_fastSky", 1);
ADDRGP4 $2252
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2969
;2969:			trap_Cvar_SetValue("r_inGameVideo", 0);
ADDRGP4 $2253
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2970
;2970:			trap_Cvar_SetValue("cg_brassTime", 0);
ADDRGP4 $2255
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2971
;2971:			trap_Cvar_Set("r_texturemode", "GL_LINEAR_MIPMAP_NEAREST");
ADDRGP4 $2256
ARGP4
ADDRGP4 $2261
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2972
;2972:			break;
ADDRGP4 $2240
JUMPV
LABELV $2262
line 2974
;2973:		case 3: // fastest
;2974:			trap_Cvar_SetValue("r_fullScreen", 1);
ADDRGP4 $2245
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2975
;2975:			trap_Cvar_SetValue("r_subdivisions", 20);
ADDRGP4 $2236
ARGP4
CNSTF4 1101004800
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2976
;2976:			trap_Cvar_SetValue("r_vertexlight", 1);
ADDRGP4 $2246
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2977
;2977:			trap_Cvar_SetValue("r_lodbias", 2);
ADDRGP4 $2232
ARGP4
CNSTF4 1073741824
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2978
;2978:			trap_Cvar_SetValue("r_colorbits", 16);
ADDRGP4 $2220
ARGP4
CNSTF4 1098907648
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2979
;2979:			trap_Cvar_SetValue("r_depthbits", 16);
ADDRGP4 $2224
ARGP4
CNSTF4 1098907648
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2980
;2980:			trap_Cvar_SetValue("r_stencilbits", 0);
ADDRGP4 $2225
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2981
;2981:			trap_Cvar_SetValue("r_mode", 3);
ADDRGP4 $2248
ARGP4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2982
;2982:			trap_Cvar_Set("ui_videomode", "640x480");
ADDRGP4 $2249
ARGP4
ADDRGP4 $2259
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2983
;2983:			trap_Cvar_SetValue("r_picmip", 2);
ADDRGP4 $2247
ARGP4
CNSTF4 1073741824
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2984
;2984:			trap_Cvar_SetValue("r_texturebits", 16);
ADDRGP4 $2251
ARGP4
CNSTF4 1098907648
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2985
;2985:			trap_Cvar_SetValue("cg_shadows", 0);
ADDRGP4 $2254
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2986
;2986:			trap_Cvar_SetValue("cg_brassTime", 0);
ADDRGP4 $2255
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2987
;2987:			trap_Cvar_SetValue("r_fastSky", 1);
ADDRGP4 $2252
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2988
;2988:			trap_Cvar_SetValue("r_inGameVideo", 0);
ADDRGP4 $2253
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2989
;2989:			trap_Cvar_Set("r_texturemode", "GL_LINEAR_MIPMAP_NEAREST");
ADDRGP4 $2256
ARGP4
ADDRGP4 $2261
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2990
;2990:			break;
line 2992
;2991:		}
;2992:	} else if (Q_stricmp(name, "ui_mousePitch") == 0) {
ADDRGP4 $2240
JUMPV
LABELV $2239
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2266
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $2264
line 2993
;2993:		if (val == 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2267
line 2994
;2994:			trap_Cvar_SetValue("m_pitch", 0.022f);
ADDRGP4 $2269
ARGP4
CNSTF4 1018444120
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2995
;2995:		} else {
ADDRGP4 $2268
JUMPV
LABELV $2267
line 2996
;2996:			trap_Cvar_SetValue("m_pitch", -0.022f);
ADDRGP4 $2269
ARGP4
CNSTF4 3165927768
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2997
;2997:		}
LABELV $2268
line 2998
;2998:	}
LABELV $2264
LABELV $2240
LABELV $2231
LABELV $2219
LABELV $2216
LABELV $2206
LABELV $2202
line 2999
;2999:}
LABELV $2200
endproc UI_Update 36 8
proc UI_RunMenuScript 1336 24
line 3001
;3000:
;3001:static void UI_RunMenuScript(char **args) {
line 3005
;3002:	const char *name, *name2;
;3003:	char buff[1024];
;3004:
;3005:	if (String_Parse(args, &name)) {
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
EQI4 $2271
line 3006
;3006:		if (Q_stricmp(name, "StartServer") == 0) {
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2275
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $2273
line 3009
;3007:			int i, clients, oldclients;
;3008:			float skill;
;3009:			trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $393
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3010
;3010:			trap_Cvar_Set("ui_singlePlayerActive", "0");
ADDRGP4 $2133
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3011
;3011:			trap_Cvar_SetValue("dedicated", Com_Clamp(0, 2, ui_dedicated.integer));
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
ADDRGP4 $2276
ARGP4
ADDRLP4 1056
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3012
;3012:			trap_Cvar_SetValue("g_gametype", Com_Clamp(0, GT_MAX_GAME_TYPE - 1, uiInfo.gameTypes[ui_netGameType.integer].gtEnum));
CNSTF4 0
ARGF4
CNSTF4 1094713344
ARGF4
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359512+4
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 1060
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $1340
ARGP4
ADDRLP4 1060
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3013
;3013:			trap_Cvar_Set("g_redTeam", UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $712
ARGP4
ADDRLP4 1064
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2148
ARGP4
ADDRLP4 1064
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3014
;3014:			trap_Cvar_Set("g_blueTeam", UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1147
ARGP4
ADDRLP4 1068
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2149
ARGP4
ADDRLP4 1068
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3015
;3015:			trap_Cmd_ExecuteText(EXEC_APPEND, va("wait ; wait ; map %s\n", uiInfo.mapList[ui_currentNetMap.integer].mapLoadName));
ADDRGP4 $2126
ARGP4
ADDRGP4 ui_currentNetMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+4
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
line 3016
;3016:			skill = trap_Cvar_VariableValue("g_spSkill");
ADDRGP4 $885
ARGP4
ADDRLP4 1076
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1048
ADDRLP4 1076
INDIRF4
ASGNF4
line 3018
;3017:			// set max clients based on spots
;3018:			oldclients = trap_Cvar_VariableValue("sv_maxClients");
ADDRGP4 $2142
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
line 3019
;3019:			clients = 0;
ADDRLP4 1044
CNSTI4 0
ASGNI4
line 3020
;3020:			for (i = 0; i < PLAYERS_PER_TEAM; i++) {
ADDRLP4 1040
CNSTI4 0
ASGNI4
LABELV $2284
line 3021
;3021:				int bot = trap_Cvar_VariableValue(va("ui_blueteam%i", i + 1));
ADDRGP4 $907
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
line 3022
;3022:				if (bot >= 0) {
ADDRLP4 1084
INDIRI4
CNSTI4 0
LTI4 $2288
line 3023
;3023:					clients++;
ADDRLP4 1044
ADDRLP4 1044
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3024
;3024:				}
LABELV $2288
line 3025
;3025:				bot = trap_Cvar_VariableValue(va("ui_redteam%i", i + 1));
ADDRGP4 $908
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
line 3026
;3026:				if (bot >= 0) {
ADDRLP4 1084
INDIRI4
CNSTI4 0
LTI4 $2290
line 3027
;3027:					clients++;
ADDRLP4 1044
ADDRLP4 1044
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3028
;3028:				}
LABELV $2290
line 3029
;3029:			}
LABELV $2285
line 3020
ADDRLP4 1040
ADDRLP4 1040
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 5
LTI4 $2284
line 3030
;3030:			if (clients == 0) {
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $2292
line 3031
;3031:				clients = 8;
ADDRLP4 1044
CNSTI4 8
ASGNI4
line 3032
;3032:			}
LABELV $2292
line 3034
;3033:
;3034:			if (oldclients > clients) {
ADDRLP4 1052
INDIRI4
ADDRLP4 1044
INDIRI4
LEI4 $2294
line 3035
;3035:				clients = oldclients;
ADDRLP4 1044
ADDRLP4 1052
INDIRI4
ASGNI4
line 3036
;3036:			}
LABELV $2294
line 3038
;3037:
;3038:			trap_Cvar_Set("sv_maxClients", va("%d", clients));
ADDRGP4 $727
ARGP4
ADDRLP4 1044
INDIRI4
ARGI4
ADDRLP4 1084
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2142
ARGP4
ADDRLP4 1084
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3040
;3039:
;3040:			for (i = 0; i < PLAYERS_PER_TEAM; i++) {
ADDRLP4 1040
CNSTI4 0
ASGNI4
LABELV $2296
line 3041
;3041:				int bot = trap_Cvar_VariableValue(va("ui_blueteam%i", i + 1));
ADDRGP4 $907
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
line 3042
;3042:				if (bot > 1) {
ADDRLP4 1088
INDIRI4
CNSTI4 1
LEI4 $2300
line 3043
;3043:					if (ui_actualNetGameType.integer >= GT_TEAM) {
ADDRGP4 ui_actualNetGameType+12
INDIRI4
CNSTI4 3
LTI4 $2302
line 3044
;3044:						Com_sprintf(buff, sizeof(buff), "addbot %s %f %s\n", uiInfo.characterList[bot - 2].name, skill, "Blue");
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2305
ARGP4
ADDRLP4 1088
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380-48
ADDP4
INDIRP4
ARGP4
ADDRLP4 1048
INDIRF4
ARGF4
ADDRGP4 $900
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3045
;3045:					} else {
ADDRGP4 $2303
JUMPV
LABELV $2302
line 3046
;3046:						Com_sprintf(buff, sizeof(buff), "addbot %s %f \n", UI_GetBotNameByNumber(bot - 2), skill);
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
ADDRGP4 $2308
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
line 3047
;3047:					}
LABELV $2303
line 3048
;3048:					trap_Cmd_ExecuteText(EXEC_APPEND, buff);
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3049
;3049:				}
LABELV $2300
line 3050
;3050:				bot = trap_Cvar_VariableValue(va("ui_redteam%i", i + 1));
ADDRGP4 $908
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
line 3051
;3051:				if (bot > 1) {
ADDRLP4 1088
INDIRI4
CNSTI4 1
LEI4 $2309
line 3052
;3052:					if (ui_actualNetGameType.integer >= GT_TEAM) {
ADDRGP4 ui_actualNetGameType+12
INDIRI4
CNSTI4 3
LTI4 $2311
line 3053
;3053:						Com_sprintf(buff, sizeof(buff), "addbot %s %f %s\n", uiInfo.characterList[bot - 2].name, skill, "Red");
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2305
ARGP4
ADDRLP4 1088
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380-48
ADDP4
INDIRP4
ARGP4
ADDRLP4 1048
INDIRF4
ARGF4
ADDRGP4 $901
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3054
;3054:					} else {
ADDRGP4 $2312
JUMPV
LABELV $2311
line 3055
;3055:						Com_sprintf(buff, sizeof(buff), "addbot %s %f \n", UI_GetBotNameByNumber(bot - 2), skill);
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
ADDRGP4 $2308
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
line 3056
;3056:					}
LABELV $2312
line 3057
;3057:					trap_Cmd_ExecuteText(EXEC_APPEND, buff);
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3058
;3058:				}
LABELV $2309
line 3059
;3059:			}
LABELV $2297
line 3040
ADDRLP4 1040
ADDRLP4 1040
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 5
LTI4 $2296
line 3060
;3060:		} else if (Q_stricmp(name, "updateSPMenu") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2273
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2318
ARGP4
ADDRLP4 1040
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $2316
line 3061
;3061:			UI_SetCapFragLimits(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_SetCapFragLimits
CALLV
pop
line 3062
;3062:			UI_MapCountByGameType();
ADDRGP4 UI_MapCountByGameType
CALLI4
pop
line 3063
;3063:			ui_mapIndex.integer = UI_GetIndexFromSelection(ui_currentMap.integer);
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
line 3064
;3064:			trap_Cvar_Set("ui_mapIndex", va("%d", ui_mapIndex.integer));
ADDRGP4 $727
ARGP4
ADDRGP4 ui_mapIndex+12
INDIRI4
ARGI4
ADDRLP4 1048
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2120
ARGP4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3065
;3065:			Menu_SetFeederSelection(NULL, FEEDER_MAPS, ui_mapIndex.integer, "skirmish");
CNSTP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 ui_mapIndex+12
INDIRI4
ARGI4
ADDRGP4 $2116
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 3066
;3066:			UI_GameType_HandleKey(0, NULL, K_MOUSE1, qfalse);
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
line 3067
;3067:			UI_GameType_HandleKey(0, NULL, K_MOUSE2, qfalse);
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
line 3068
;3068:		} else if (Q_stricmp(name, "resetDefaults") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2316
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2325
ARGP4
ADDRLP4 1044
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $2323
line 3069
;3069:			trap_Cmd_ExecuteText(EXEC_APPEND, "exec default.cfg\n");
CNSTI4 2
ARGI4
ADDRGP4 $2326
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3070
;3070:			trap_Cmd_ExecuteText(EXEC_APPEND, "cvar_restart\n");
CNSTI4 2
ARGI4
ADDRGP4 $2327
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3071
;3071:			Controls_SetDefaults();
ADDRGP4 Controls_SetDefaults
CALLV
pop
line 3072
;3072:			trap_Cvar_Set("com_introPlayed", "1");
ADDRGP4 $2328
ARGP4
ADDRGP4 $396
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3073
;3073:			trap_Cmd_ExecuteText(EXEC_APPEND, "vid_restart\n");
CNSTI4 2
ARGI4
ADDRGP4 $2329
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3074
;3074:		} else if (Q_stricmp(name, "getCDKey") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2323
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2332
ARGP4
ADDRLP4 1048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $2330
line 3076
;3075:
;3076:		} else if (Q_stricmp(name, "verifyCDKey") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2330
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2335
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $2333
line 3078
;3077:
;3078:		} else if (Q_stricmp(name, "loadArenas") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2333
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2338
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $2336
line 3080
;3079:			//UI_LoadArenasIntoMapList();
;3080:			UI_MapCountByGameType();
ADDRGP4 UI_MapCountByGameType
CALLI4
pop
line 3081
;3081:			Menu_SetFeederSelection(NULL, FEEDER_ALLMAPS, 0, "createserver");
CNSTP4 0
ARGP4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 $2339
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 3082
;3082:		} else if (Q_stricmp(name, "saveControls") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2336
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2342
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $2340
line 3083
;3083:			Controls_SetConfig(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 Controls_SetConfig
CALLV
pop
line 3084
;3084:		} else if (Q_stricmp(name, "loadControls") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2340
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2345
ARGP4
ADDRLP4 1064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $2343
line 3085
;3085:			Controls_GetConfig();
ADDRGP4 Controls_GetConfig
CALLV
pop
line 3086
;3086:		} else if (Q_stricmp(name, "clearError") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2343
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2348
ARGP4
ADDRLP4 1068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
NEI4 $2346
line 3087
;3087:			trap_Cvar_Set("com_errorMessage", "");
ADDRGP4 $2349
ARGP4
ADDRGP4 $114
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3088
;3088:		} else if (Q_stricmp(name, "loadGameInfo") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2346
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2352
ARGP4
ADDRLP4 1072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $2350
line 3089
;3089:			UI_ParseGameInfo("gameinfo.txt");
ADDRGP4 $680
ARGP4
ADDRGP4 UI_ParseGameInfo
CALLV
pop
line 3090
;3090:			UI_LoadBestScores(uiInfo.mapList[ui_currentMap.integer].mapLoadName, uiInfo.gameTypes[ui_gameType.integer].gtEnum);
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359512+4
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_LoadBestScores
CALLV
pop
line 3091
;3091:		} else if (Q_stricmp(name, "resetScores") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2350
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2361
ARGP4
ADDRLP4 1076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
NEI4 $2359
line 3092
;3092:			UI_ClearScores();
ADDRGP4 UI_ClearScores
CALLV
pop
line 3093
;3093:		} else if (Q_stricmp(name, "RefreshServers") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2359
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2364
ARGP4
ADDRLP4 1080
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 0
NEI4 $2362
line 3094
;3094:			UI_StartServerRefresh(qtrue, qtrue);
CNSTI4 1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 UI_StartServerRefresh
CALLV
pop
line 3095
;3095:			UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 3096
;3096:		} else if (Q_stricmp(name, "RefreshFilter") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2362
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2367
ARGP4
ADDRLP4 1084
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1084
INDIRI4
CNSTI4 0
NEI4 $2365
line 3097
;3097:			UI_StartServerRefresh(qfalse, qtrue);
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 UI_StartServerRefresh
CALLV
pop
line 3098
;3098:			UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 3099
;3099:		} else if (Q_stricmp(name, "RunSPDemo") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2365
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2370
ARGP4
ADDRLP4 1088
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1088
INDIRI4
CNSTI4 0
NEI4 $2368
line 3100
;3100:			if (uiInfo.demoAvailable) {
ADDRGP4 uiInfo+5354364
INDIRI4
CNSTI4 0
EQI4 $2272
line 3101
;3101:				trap_Cmd_ExecuteText(EXEC_APPEND, va("demo %s_%i\n", uiInfo.mapList[ui_currentMap.integer].mapLoadName, uiInfo.gameTypes[ui_gameType.integer].gtEnum));
ADDRGP4 $2374
ARGP4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359512+4
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
line 3102
;3102:			}
line 3103
;3103:		} else if (Q_stricmp(name, "LoadDemos") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2368
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2383
ARGP4
ADDRLP4 1092
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1092
INDIRI4
CNSTI4 0
NEI4 $2381
line 3104
;3104:			UI_LoadDemos();
ADDRGP4 UI_LoadDemos
CALLV
pop
line 3105
;3105:		} else if (Q_stricmp(name, "LoadMovies") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2381
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2386
ARGP4
ADDRLP4 1096
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1096
INDIRI4
CNSTI4 0
NEI4 $2384
line 3106
;3106:			UI_LoadMovies();
ADDRGP4 UI_LoadMovies
CALLV
pop
line 3107
;3107:		} else if (Q_stricmp(name, "LoadMods") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2384
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2389
ARGP4
ADDRLP4 1100
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1100
INDIRI4
CNSTI4 0
NEI4 $2387
line 3108
;3108:			UI_LoadMods();
ADDRGP4 UI_LoadMods
CALLV
pop
line 3109
;3109:		} else if (Q_stricmp(name, "playMovie") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2387
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2392
ARGP4
ADDRLP4 1104
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1104
INDIRI4
CNSTI4 0
NEI4 $2390
line 3110
;3110:			if (uiInfo.previewMovie >= 0) {
ADDRGP4 uiInfo+5387360
INDIRI4
CNSTI4 0
LTI4 $2393
line 3111
;3111:				trap_CIN_StopCinematic(uiInfo.previewMovie);
ADDRGP4 uiInfo+5387360
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 3112
;3112:			}
LABELV $2393
line 3113
;3113:			trap_Cmd_ExecuteText(EXEC_APPEND, va("cinematic %s.roq 2\n", uiInfo.movieList[uiInfo.movieIndex]));
ADDRGP4 $2397
ARGP4
ADDRGP4 uiInfo+5387356
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5386328
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
line 3114
;3114:		} else if (Q_stricmp(name, "RunMod") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2390
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2402
ARGP4
ADDRLP4 1108
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 0
NEI4 $2400
line 3115
;3115:			trap_Cvar_Set("fs_game", uiInfo.modList[uiInfo.modIndex].modName);
ADDRGP4 $2403
ARGP4
ADDRGP4 uiInfo+5378124
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5377608
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3116
;3116:			trap_Cmd_ExecuteText(EXEC_APPEND, "vid_restart;");
CNSTI4 2
ARGI4
ADDRGP4 $2406
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3117
;3117:		} else if (Q_stricmp(name, "RunDemo") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2400
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2409
ARGP4
ADDRLP4 1112
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
NEI4 $2407
line 3118
;3118:			trap_Cmd_ExecuteText(EXEC_APPEND, va("demo %s\n", uiInfo.demoList[uiInfo.demoIndex]));
ADDRGP4 $2410
ARGP4
ADDRGP4 uiInfo+5386324
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5378128
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
line 3119
;3119:		} else if (Q_stricmp(name, "Quake3") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2407
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2415
ARGP4
ADDRLP4 1116
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
NEI4 $2413
line 3120
;3120:			trap_Cvar_Set("fs_game", "");
ADDRGP4 $2403
ARGP4
ADDRGP4 $114
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3121
;3121:			trap_Cmd_ExecuteText(EXEC_APPEND, "vid_restart;");
CNSTI4 2
ARGI4
ADDRGP4 $2406
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3122
;3122:		} else if (Q_stricmp(name, "closeJoin") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2413
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2418
ARGP4
ADDRLP4 1120
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1120
INDIRI4
CNSTI4 0
NEI4 $2416
line 3123
;3123:			if (uiInfo.serverStatus.refreshActive) {
ADDRGP4 uiInfo+5387364+2212
INDIRI4
CNSTI4 0
EQI4 $2419
line 3124
;3124:				UI_StopServerRefresh();
ADDRGP4 UI_StopServerRefresh
CALLV
pop
line 3125
;3125:				uiInfo.serverStatus.nextDisplayRefresh = 0;
ADDRGP4 uiInfo+5387364+10420
CNSTI4 0
ASGNI4
line 3126
;3126:				uiInfo.nextServerStatusRefresh = 0;
ADDRGP4 uiInfo+5402244
CNSTI4 0
ASGNI4
line 3127
;3127:				uiInfo.nextFindPlayerRefresh = 0;
ADDRGP4 uiInfo+5407572
CNSTI4 0
ASGNI4
line 3128
;3128:				UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 3129
;3129:			} else {
ADDRGP4 $2272
JUMPV
LABELV $2419
line 3130
;3130:				Menus_CloseByName("joinserver");
ADDRGP4 $2427
ARGP4
ADDRGP4 Menus_CloseByName
CALLV
pop
line 3131
;3131:				Menus_OpenByName("main");
ADDRGP4 $2428
ARGP4
ADDRGP4 Menus_OpenByName
CALLV
pop
line 3132
;3132:			}
line 3133
;3133:		} else if (Q_stricmp(name, "StopRefresh") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2416
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2431
ARGP4
ADDRLP4 1124
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1124
INDIRI4
CNSTI4 0
NEI4 $2429
line 3134
;3134:			UI_StopServerRefresh();
ADDRGP4 UI_StopServerRefresh
CALLV
pop
line 3135
;3135:			uiInfo.serverStatus.nextDisplayRefresh = 0;
ADDRGP4 uiInfo+5387364+10420
CNSTI4 0
ASGNI4
line 3136
;3136:			uiInfo.nextServerStatusRefresh = 0;
ADDRGP4 uiInfo+5402244
CNSTI4 0
ASGNI4
line 3137
;3137:			uiInfo.nextFindPlayerRefresh = 0;
ADDRGP4 uiInfo+5407572
CNSTI4 0
ASGNI4
line 3138
;3138:		} else if (Q_stricmp(name, "UpdateFilter") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2429
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2438
ARGP4
ADDRLP4 1128
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1128
INDIRI4
CNSTI4 0
NEI4 $2436
line 3140
;3139:			// UpdateFilter is called when server browser menu is opened and when a favorite server is deleted.
;3140:			UI_StartServerRefresh(qtrue, qfalse);
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 UI_StartServerRefresh
CALLV
pop
line 3141
;3141:			UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 3142
;3142:			UI_FeederSelection(FEEDER_SERVERS, 0);
CNSTF4 1073741824
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 UI_FeederSelection
CALLV
pop
line 3143
;3143:		} else if (Q_stricmp(name, "ServerStatus") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2436
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2441
ARGP4
ADDRLP4 1132
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1132
INDIRI4
CNSTI4 0
NEI4 $2439
line 3144
;3144:			trap_LAN_GetServerAddressString(UI_SourceForLAN(), uiInfo.serverStatus.displayServers[uiInfo.serverStatus.currentServer], uiInfo.serverStatusAddress, sizeof(uiInfo.serverStatusAddress));
ADDRLP4 1136
ADDRGP4 UI_SourceForLAN
CALLI4
ASGNI4
ADDRLP4 1136
INDIRI4
ARGI4
ADDRGP4 uiInfo+5387364+2216
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5387364+2220
ADDP4
INDIRI4
ARGI4
ADDRGP4 uiInfo+5398848
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_LAN_GetServerAddressString
CALLV
pop
line 3145
;3145:			UI_BuildServerStatus(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerStatus
CALLV
pop
line 3146
;3146:		} else if (Q_stricmp(name, "FoundPlayerServerStatus") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2439
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2450
ARGP4
ADDRLP4 1136
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1136
INDIRI4
CNSTI4 0
NEI4 $2448
line 3147
;3147:			Q_strncpyz(uiInfo.serverStatusAddress, uiInfo.foundPlayerServerAddresses[uiInfo.currentFoundPlayerServer], sizeof(uiInfo.serverStatusAddress));
ADDRGP4 uiInfo+5398848
ARGP4
ADDRGP4 uiInfo+5407564
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+5405516
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3148
;3148:			UI_BuildServerStatus(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerStatus
CALLV
pop
line 3149
;3149:			Menu_SetFeederSelection(NULL, FEEDER_FINDPLAYER, 0, NULL);
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
line 3150
;3150:		} else if (Q_stricmp(name, "FindPlayer") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2448
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2457
ARGP4
ADDRLP4 1140
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1140
INDIRI4
CNSTI4 0
NEI4 $2455
line 3151
;3151:			UI_BuildFindPlayerList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildFindPlayerList
CALLV
pop
line 3153
;3152:			// clear the displayed server status info
;3153:			uiInfo.serverStatusInfo.numLines = 0;
ADDRGP4 uiInfo+5398912+3328
CNSTI4 0
ASGNI4
line 3154
;3154:			Menu_SetFeederSelection(NULL, FEEDER_FINDPLAYER, 0, NULL);
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
line 3155
;3155:		} else if (Q_stricmp(name, "JoinServer") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2455
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2462
ARGP4
ADDRLP4 1144
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1144
INDIRI4
CNSTI4 0
NEI4 $2460
line 3156
;3156:			trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $393
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3157
;3157:			trap_Cvar_Set("ui_singlePlayerActive", "0");
ADDRGP4 $2133
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3158
;3158:			if (uiInfo.serverStatus.currentServer >= 0 && uiInfo.serverStatus.currentServer < uiInfo.serverStatus.numDisplayServers) {
ADDRGP4 uiInfo+5387364+2216
INDIRI4
CNSTI4 0
LTI4 $2272
ADDRGP4 uiInfo+5387364+2216
INDIRI4
ADDRGP4 uiInfo+5387364+10412
INDIRI4
GEI4 $2272
line 3159
;3159:				trap_LAN_GetServerAddressString(UI_SourceForLAN(), uiInfo.serverStatus.displayServers[uiInfo.serverStatus.currentServer], buff, 1024);
ADDRLP4 1148
ADDRGP4 UI_SourceForLAN
CALLI4
ASGNI4
ADDRLP4 1148
INDIRI4
ARGI4
ADDRGP4 uiInfo+5387364+2216
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5387364+2220
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
line 3160
;3160:				trap_Cmd_ExecuteText(EXEC_APPEND, va("connect %s\n", buff));
ADDRGP4 $2475
ARGP4
ADDRLP4 0
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
line 3161
;3161:			}
line 3162
;3162:		} else if (Q_stricmp(name, "FoundPlayerJoinServer") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2460
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2478
ARGP4
ADDRLP4 1148
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1148
INDIRI4
CNSTI4 0
NEI4 $2476
line 3163
;3163:			trap_Cvar_Set("ui_singlePlayerActive", "0");
ADDRGP4 $2133
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3164
;3164:			if (uiInfo.currentFoundPlayerServer >= 0 && uiInfo.currentFoundPlayerServer < uiInfo.numFoundPlayerServers) {
ADDRGP4 uiInfo+5407564
INDIRI4
CNSTI4 0
LTI4 $2272
ADDRGP4 uiInfo+5407564
INDIRI4
ADDRGP4 uiInfo+5407568
INDIRI4
GEI4 $2272
line 3165
;3165:				trap_Cmd_ExecuteText(EXEC_APPEND, va("connect %s\n", uiInfo.foundPlayerServerAddresses[uiInfo.currentFoundPlayerServer]));
ADDRGP4 $2475
ARGP4
ADDRGP4 uiInfo+5407564
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+5405516
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
line 3166
;3166:			}
line 3167
;3167:		} else if (Q_stricmp(name, "Quit") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2476
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2488
ARGP4
ADDRLP4 1152
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1152
INDIRI4
CNSTI4 0
NEI4 $2486
line 3168
;3168:			trap_Cvar_Set("ui_singlePlayerActive", "0");
ADDRGP4 $2133
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3169
;3169:			trap_Cmd_ExecuteText(EXEC_NOW, "quit");
CNSTI4 0
ARGI4
ADDRGP4 $2489
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3170
;3170:		} else if (Q_stricmp(name, "Controls") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2486
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2492
ARGP4
ADDRLP4 1156
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1156
INDIRI4
CNSTI4 0
NEI4 $2490
line 3171
;3171:			trap_Cvar_Set("cl_paused", "1");
ADDRGP4 $2493
ARGP4
ADDRGP4 $396
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3172
;3172:			trap_Key_SetCatcher(KEYCATCH_UI);
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 3173
;3173:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 3174
;3174:			Menus_ActivateByName("setup_menu2");
ADDRGP4 $2494
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 3175
;3175:		} else if (Q_stricmp(name, "Leave") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2490
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2497
ARGP4
ADDRLP4 1160
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1160
INDIRI4
CNSTI4 0
NEI4 $2495
line 3176
;3176:			trap_Cmd_ExecuteText(EXEC_APPEND, "disconnect\n");
CNSTI4 2
ARGI4
ADDRGP4 $2498
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3177
;3177:			trap_Key_SetCatcher(KEYCATCH_UI);
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 3178
;3178:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 3179
;3179:			Menus_ActivateByName("main");
ADDRGP4 $2428
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 3180
;3180:		} else if (Q_stricmp(name, "ServerSort") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2495
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2501
ARGP4
ADDRLP4 1164
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1164
INDIRI4
CNSTI4 0
NEI4 $2499
line 3182
;3181:			int sortColumn;
;3182:			if (Int_Parse(args, &sortColumn)) {
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
EQI4 $2272
line 3184
;3183:				// if same column we're already sorting on then flip the direction
;3184:				if (sortColumn == uiInfo.serverStatus.sortKey) {
ADDRLP4 1168
INDIRI4
ADDRGP4 uiInfo+5387364+2200
INDIRI4
NEI4 $2504
line 3185
;3185:					uiInfo.serverStatus.sortDir = !uiInfo.serverStatus.sortDir;
ADDRGP4 uiInfo+5387364+2204
INDIRI4
CNSTI4 0
NEI4 $2513
ADDRLP4 1176
CNSTI4 1
ASGNI4
ADDRGP4 $2514
JUMPV
LABELV $2513
ADDRLP4 1176
CNSTI4 0
ASGNI4
LABELV $2514
ADDRGP4 uiInfo+5387364+2204
ADDRLP4 1176
INDIRI4
ASGNI4
line 3186
;3186:				}
LABELV $2504
line 3188
;3187:				// make sure we sort again
;3188:				UI_ServersSort(sortColumn, qtrue);
ADDRLP4 1168
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 UI_ServersSort
CALLV
pop
line 3189
;3189:			}
line 3190
;3190:		} else if (Q_stricmp(name, "nextSkirmish") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2499
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2517
ARGP4
ADDRLP4 1168
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1168
INDIRI4
CNSTI4 0
NEI4 $2515
line 3191
;3191:			UI_StartSkirmish(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_StartSkirmish
CALLV
pop
line 3192
;3192:		} else if (Q_stricmp(name, "SkirmishStart") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2515
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2520
ARGP4
ADDRLP4 1172
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1172
INDIRI4
CNSTI4 0
NEI4 $2518
line 3193
;3193:			UI_StartSkirmish(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_StartSkirmish
CALLV
pop
line 3194
;3194:		} else if (Q_stricmp(name, "closeingame") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2518
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2523
ARGP4
ADDRLP4 1176
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1176
INDIRI4
CNSTI4 0
NEI4 $2521
line 3195
;3195:			trap_Key_SetCatcher(trap_Key_GetCatcher() & ~KEYCATCH_UI);
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
line 3196
;3196:			trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 3197
;3197:			trap_Cvar_Set("cl_paused", "0");
ADDRGP4 $2493
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3198
;3198:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 3199
;3199:		} else if (Q_stricmp(name, "voteMap") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2521
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2526
ARGP4
ADDRLP4 1180
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1180
INDIRI4
CNSTI4 0
NEI4 $2524
line 3200
;3200:			if (ui_currentNetMap.integer >= 0 && ui_currentNetMap.integer < uiInfo.mapCount) {
ADDRGP4 ui_currentNetMap+12
INDIRI4
CNSTI4 0
LTI4 $2272
ADDRGP4 ui_currentNetMap+12
INDIRI4
ADDRGP4 uiInfo+5364156
INDIRI4
GEI4 $2272
line 3201
;3201:				trap_Cmd_ExecuteText(EXEC_APPEND, va("callvote map %s\n", uiInfo.mapList[ui_currentNetMap.integer].mapLoadName));
ADDRGP4 $2532
ARGP4
ADDRGP4 ui_currentNetMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+4
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
line 3202
;3202:			}
line 3203
;3203:		} else if (Q_stricmp(name, "voteKick") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2524
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2538
ARGP4
ADDRLP4 1184
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1184
INDIRI4
CNSTI4 0
NEI4 $2536
line 3204
;3204:			if (uiInfo.playerIndex >= 0 && uiInfo.playerIndex < uiInfo.playerCount) {
ADDRGP4 uiInfo+5359792
INDIRI4
CNSTI4 0
LTI4 $2272
ADDRGP4 uiInfo+5359792
INDIRI4
ADDRGP4 uiInfo+5359776
INDIRI4
GEI4 $2272
line 3205
;3205:				trap_Cmd_ExecuteText(EXEC_APPEND, va("callvote kick %s\n", uiInfo.playerNames[uiInfo.playerIndex]));
ADDRGP4 $2544
ARGP4
ADDRGP4 uiInfo+5359792
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+5359804
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
line 3206
;3206:			}
line 3207
;3207:		} else if (Q_stricmp(name, "voteGame") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2536
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2549
ARGP4
ADDRLP4 1188
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1188
INDIRI4
CNSTI4 0
NEI4 $2547
line 3208
;3208:			if (ui_netGameType.integer >= 0 && ui_netGameType.integer < uiInfo.numGameTypes) {
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 0
LTI4 $2272
ADDRGP4 ui_netGameType+12
INDIRI4
ADDRGP4 uiInfo+5359508
INDIRI4
GEI4 $2272
line 3209
;3209:				trap_Cmd_ExecuteText(EXEC_APPEND, va("callvote g_gametype %i\n", uiInfo.gameTypes[ui_netGameType.integer].gtEnum));
ADDRGP4 $2555
ARGP4
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359512+4
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
line 3210
;3210:			}
line 3211
;3211:		} else if (Q_stricmp(name, "voteLeader") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2547
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2561
ARGP4
ADDRLP4 1192
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1192
INDIRI4
CNSTI4 0
NEI4 $2559
line 3212
;3212:			if (uiInfo.teamIndex >= 0 && uiInfo.teamIndex < uiInfo.myTeamCount) {
ADDRGP4 uiInfo+5359784
INDIRI4
CNSTI4 0
LTI4 $2272
ADDRGP4 uiInfo+5359784
INDIRI4
ADDRGP4 uiInfo+5359780
INDIRI4
GEI4 $2272
line 3213
;3213:				trap_Cmd_ExecuteText(EXEC_APPEND, va("callteamvote leader %s\n", uiInfo.teamNames[uiInfo.teamIndex]));
ADDRGP4 $2567
ARGP4
ADDRGP4 uiInfo+5359784
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+5361852
ADDP4
ARGP4
ADDRLP4 1196
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1196
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3214
;3214:			}
line 3215
;3215:		} else if (Q_stricmp(name, "addBot") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2559
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2572
ARGP4
ADDRLP4 1196
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1196
INDIRI4
CNSTI4 0
NEI4 $2570
line 3216
;3216:			if (trap_Cvar_VariableValue("g_gametype") >= GT_TEAM) {
ADDRGP4 $1340
ARGP4
ADDRLP4 1200
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1200
INDIRF4
CNSTF4 1077936128
LTF4 $2573
line 3217
;3217:				trap_Cmd_ExecuteText(EXEC_APPEND, va("addbot %s %i %s\n", uiInfo.characterList[uiInfo.botIndex].name, uiInfo.skillIndex + 1, (uiInfo.redBlue == 0) ? "Red" : "Blue"));
ADDRGP4 $2575
ARGP4
ADDRGP4 uiInfo+5354376
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380
ADDP4
INDIRP4
ARGP4
ADDRGP4 uiInfo+5377604
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 uiInfo+5359772
INDIRI4
CNSTI4 0
NEI4 $2581
ADDRLP4 1204
ADDRGP4 $901
ASGNP4
ADDRGP4 $2582
JUMPV
LABELV $2581
ADDRLP4 1204
ADDRGP4 $900
ASGNP4
LABELV $2582
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
line 3218
;3218:			} else {
ADDRGP4 $2272
JUMPV
LABELV $2573
line 3219
;3219:				trap_Cmd_ExecuteText(EXEC_APPEND, va("addbot %s %i %s\n", UI_GetBotNameByNumber(uiInfo.botIndex), uiInfo.skillIndex + 1, (uiInfo.redBlue == 0) ? "Red" : "Blue"));
ADDRGP4 uiInfo+5354376
INDIRI4
ARGI4
ADDRLP4 1208
ADDRGP4 UI_GetBotNameByNumber
CALLP4
ASGNP4
ADDRGP4 $2575
ARGP4
ADDRLP4 1208
INDIRP4
ARGP4
ADDRGP4 uiInfo+5377604
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 uiInfo+5359772
INDIRI4
CNSTI4 0
NEI4 $2587
ADDRLP4 1204
ADDRGP4 $901
ASGNP4
ADDRGP4 $2588
JUMPV
LABELV $2587
ADDRLP4 1204
ADDRGP4 $900
ASGNP4
LABELV $2588
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
line 3220
;3220:			}
line 3221
;3221:		} else if (Q_stricmp(name, "addFavorite") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2570
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2591
ARGP4
ADDRLP4 1200
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1200
INDIRI4
CNSTI4 0
NEI4 $2589
line 3222
;3222:			if (ui_netSource.integer != UIAS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 7
EQI4 $2272
line 3227
;3223:				char name[MAX_NAME_LENGTH];
;3224:				char addr[MAX_ADDRESSLENGTH];
;3225:				int res;
;3226:
;3227:				trap_LAN_GetServerInfo(UI_SourceForLAN(), uiInfo.serverStatus.displayServers[uiInfo.serverStatus.currentServer], buff, MAX_STRING_CHARS);
ADDRLP4 1304
ADDRGP4 UI_SourceForLAN
CALLI4
ASGNI4
ADDRLP4 1304
INDIRI4
ARGI4
ADDRGP4 uiInfo+5387364+2216
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5387364+2220
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
line 3228
;3228:				name[0] = addr[0] = '\0';
ADDRLP4 1308
CNSTI1 0
ASGNI1
ADDRLP4 1204
ADDRLP4 1308
INDIRI1
ASGNI1
ADDRLP4 1268
ADDRLP4 1308
INDIRI1
ASGNI1
line 3229
;3229:				Q_strncpyz(name, Info_ValueForKey(buff, "hostname"), sizeof(name));
ADDRLP4 0
ARGP4
ADDRGP4 $2599
ARGP4
ADDRLP4 1312
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1268
ARGP4
ADDRLP4 1312
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3230
;3230:				Q_strncpyz(addr, Info_ValueForKey(buff, "addr"), sizeof(addr));
ADDRLP4 0
ARGP4
ADDRGP4 $2600
ARGP4
ADDRLP4 1316
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1204
ARGP4
ADDRLP4 1316
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3231
;3231:				if (strlen(name) > 0 && strlen(addr) > 0) {
ADDRLP4 1268
ARGP4
ADDRLP4 1320
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1320
INDIRI4
CNSTI4 0
LEI4 $2272
ADDRLP4 1204
ARGP4
ADDRLP4 1324
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1324
INDIRI4
CNSTI4 0
LEI4 $2272
line 3232
;3232:					res = trap_LAN_AddServer(AS_FAVORITES, name, addr);
CNSTI4 3
ARGI4
ADDRLP4 1268
ARGP4
ADDRLP4 1204
ARGP4
ADDRLP4 1328
ADDRGP4 trap_LAN_AddServer
CALLI4
ASGNI4
ADDRLP4 1300
ADDRLP4 1328
INDIRI4
ASGNI4
line 3233
;3233:					if (res == 0) {
ADDRLP4 1300
INDIRI4
CNSTI4 0
NEI4 $2603
line 3235
;3234:						// server already in the list
;3235:						Com_Printf("Favorite already in list\n");
ADDRGP4 $2605
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 3236
;3236:					} else if (res == -1) {
ADDRGP4 $2272
JUMPV
LABELV $2603
ADDRLP4 1300
INDIRI4
CNSTI4 -1
NEI4 $2606
line 3238
;3237:						// list full
;3238:						Com_Printf("Favorite list full\n");
ADDRGP4 $2608
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 3239
;3239:					} else {
ADDRGP4 $2272
JUMPV
LABELV $2606
line 3241
;3240:						// successfully added
;3241:						Com_Printf("Added favorite server %s\n", addr);
ADDRGP4 $2609
ARGP4
ADDRLP4 1204
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 3242
;3242:					}
line 3243
;3243:				}
line 3244
;3244:			}
line 3245
;3245:		} else if (Q_stricmp(name, "deleteFavorite") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2589
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2612
ARGP4
ADDRLP4 1204
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1204
INDIRI4
CNSTI4 0
NEI4 $2610
line 3246
;3246:			if (ui_netSource.integer == UIAS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 7
NEI4 $2272
line 3248
;3247:				char addr[MAX_ADDRESSLENGTH];
;3248:				trap_LAN_GetServerInfo(AS_FAVORITES, uiInfo.serverStatus.displayServers[uiInfo.serverStatus.currentServer], buff, MAX_STRING_CHARS);
CNSTI4 3
ARGI4
ADDRGP4 uiInfo+5387364+2216
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5387364+2220
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
line 3249
;3249:				addr[0] = '\0';
ADDRLP4 1208
CNSTI1 0
ASGNI1
line 3250
;3250:				Q_strncpyz(addr, Info_ValueForKey(buff, "addr"), sizeof(addr));
ADDRLP4 0
ARGP4
ADDRGP4 $2600
ARGP4
ADDRLP4 1272
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1208
ARGP4
ADDRLP4 1272
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3251
;3251:				if (strlen(addr) > 0) {
ADDRLP4 1208
ARGP4
ADDRLP4 1276
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1276
INDIRI4
CNSTI4 0
LEI4 $2272
line 3252
;3252:					trap_LAN_RemoveServer(AS_FAVORITES, addr);
CNSTI4 3
ARGI4
ADDRLP4 1208
ARGP4
ADDRGP4 trap_LAN_RemoveServer
CALLV
pop
line 3253
;3253:				}
line 3254
;3254:			}
line 3255
;3255:		} else if (Q_stricmp(name, "createFavorite") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2610
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2624
ARGP4
ADDRLP4 1208
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1208
INDIRI4
CNSTI4 0
NEI4 $2272
line 3260
;3256:			char name[MAX_NAME_LENGTH];
;3257:			char addr[MAX_ADDRESSLENGTH];
;3258:			int res;
;3259:
;3260:			name[0] = addr[0] = '\0';
ADDRLP4 1312
CNSTI1 0
ASGNI1
ADDRLP4 1212
ADDRLP4 1312
INDIRI1
ASGNI1
ADDRLP4 1276
ADDRLP4 1312
INDIRI1
ASGNI1
line 3261
;3261:			Q_strncpyz(name, UI_Cvar_VariableString("ui_favoriteName"), sizeof(name));
ADDRGP4 $2625
ARGP4
ADDRLP4 1316
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 1276
ARGP4
ADDRLP4 1316
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3262
;3262:			Q_strncpyz(addr, UI_Cvar_VariableString("ui_favoriteAddress"), sizeof(addr));
ADDRGP4 $2626
ARGP4
ADDRLP4 1320
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 1212
ARGP4
ADDRLP4 1320
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3263
;3263:			if (strlen(name) > 0 && strlen(addr) > 0) {
ADDRLP4 1276
ARGP4
ADDRLP4 1324
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1324
INDIRI4
CNSTI4 0
LEI4 $2272
ADDRLP4 1212
ARGP4
ADDRLP4 1328
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1328
INDIRI4
CNSTI4 0
LEI4 $2272
line 3264
;3264:				res = trap_LAN_AddServer(AS_FAVORITES, name, addr);
CNSTI4 3
ARGI4
ADDRLP4 1276
ARGP4
ADDRLP4 1212
ARGP4
ADDRLP4 1332
ADDRGP4 trap_LAN_AddServer
CALLI4
ASGNI4
ADDRLP4 1308
ADDRLP4 1332
INDIRI4
ASGNI4
line 3265
;3265:				if (res == 0) {
ADDRLP4 1308
INDIRI4
CNSTI4 0
NEI4 $2629
line 3267
;3266:					// server already in the list
;3267:					Com_Printf("Favorite already in list\n");
ADDRGP4 $2605
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 3268
;3268:				} else if (res == -1) {
ADDRGP4 $2272
JUMPV
LABELV $2629
ADDRLP4 1308
INDIRI4
CNSTI4 -1
NEI4 $2631
line 3270
;3269:					// list full
;3270:					Com_Printf("Favorite list full\n");
ADDRGP4 $2608
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 3271
;3271:				} else {
ADDRGP4 $2272
JUMPV
LABELV $2631
line 3273
;3272:					// successfully added
;3273:					Com_Printf("Added favorite server %s\n", addr);
ADDRGP4 $2609
ARGP4
ADDRLP4 1212
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 3274
;3274:				}
line 3275
;3275:			}
line 3276
;3276:		}
line 3277
;3277:	} else if (Q_stricmp(name, "orders") == 0) {
ADDRGP4 $2272
JUMPV
LABELV $2271
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2635
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $2633
line 3279
;3278:		const char *orders;
;3279:		if (String_Parse(args, &orders)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1040
ARGP4
ADDRLP4 1044
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
EQI4 $2634
line 3280
;3280:			int selectedPlayer = trap_Cvar_VariableValue("cg_selectedPlayer");
ADDRGP4 $1406
ARGP4
ADDRLP4 1052
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1048
ADDRLP4 1052
INDIRF4
CVFI4 4
ASGNI4
line 3281
;3281:			if (selectedPlayer < uiInfo.myTeamCount) {
ADDRLP4 1048
INDIRI4
ADDRGP4 uiInfo+5359780
INDIRI4
GEI4 $2638
line 3282
;3282:				Com_sprintf(buff, sizeof(buff), orders, uiInfo.teamClientNums[selectedPlayer]);
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1048
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5363900
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3283
;3283:				trap_Cmd_ExecuteText(EXEC_APPEND, buff);
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3284
;3284:				trap_Cmd_ExecuteText(EXEC_APPEND, "\n");
CNSTI4 2
ARGI4
ADDRGP4 $2642
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3285
;3285:			} else {
ADDRGP4 $2639
JUMPV
LABELV $2638
line 3287
;3286:				int i;
;3287:				for (i = 0; i < uiInfo.myTeamCount; i++) {
ADDRLP4 1056
CNSTI4 0
ASGNI4
ADDRGP4 $2646
JUMPV
LABELV $2643
line 3288
;3288:					if (uiInfo.playerNumber == uiInfo.teamClientNums[i]) {
ADDRGP4 uiInfo+5359796
INDIRI4
ADDRLP4 1056
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5363900
ADDP4
INDIRI4
NEI4 $2648
line 3289
;3289:						continue;
ADDRGP4 $2644
JUMPV
LABELV $2648
line 3291
;3290:					}
;3291:					Com_sprintf(buff, sizeof(buff), orders, uiInfo.teamClientNums[i]);
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1056
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5363900
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3292
;3292:					trap_Cmd_ExecuteText(EXEC_APPEND, buff);
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3293
;3293:					trap_Cmd_ExecuteText(EXEC_APPEND, "\n");
CNSTI4 2
ARGI4
ADDRGP4 $2642
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3294
;3294:				}
LABELV $2644
line 3287
ADDRLP4 1056
ADDRLP4 1056
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2646
ADDRLP4 1056
INDIRI4
ADDRGP4 uiInfo+5359780
INDIRI4
LTI4 $2643
line 3295
;3295:			}
LABELV $2639
line 3296
;3296:			trap_Key_SetCatcher(trap_Key_GetCatcher() & ~KEYCATCH_UI);
ADDRLP4 1056
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 3297
;3297:			trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 3298
;3298:			trap_Cvar_Set("cl_paused", "0");
ADDRGP4 $2493
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3299
;3299:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 3300
;3300:		}
line 3301
;3301:	} else if (Q_stricmp(name, "voiceOrdersTeam") == 0) {
ADDRGP4 $2634
JUMPV
LABELV $2633
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2655
ARGP4
ADDRLP4 1040
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $2653
line 3303
;3302:
;3303:	} else if (Q_stricmp(name, "voiceOrders") == 0) {
ADDRGP4 $2654
JUMPV
LABELV $2653
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2658
ARGP4
ADDRLP4 1044
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $2656
line 3305
;3304:
;3305:	} else if (Q_stricmp(name, "glCustom") == 0) {
ADDRGP4 $2657
JUMPV
LABELV $2656
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2661
ARGP4
ADDRLP4 1048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $2659
line 3306
;3306:		trap_Cvar_Set("ui_glCustom", "4");
ADDRGP4 $2241
ARGP4
ADDRGP4 $2662
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3307
;3307:	} else if (Q_stricmp(name, "update") == 0) {
ADDRGP4 $2660
JUMPV
LABELV $2659
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2665
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $2663
line 3308
;3308:		if (String_Parse(args, &name2)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1028
ARGP4
ADDRLP4 1056
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
EQI4 $2664
line 3309
;3309:			UI_Update(name2);
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 UI_Update
CALLV
pop
line 3310
;3310:		}
line 3311
;3311:	} else if (Q_stricmp(name, "setPbClStatus") == 0) {
ADDRGP4 $2664
JUMPV
LABELV $2663
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2670
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $2668
line 3313
;3312:
;3313:	} else {
ADDRGP4 $2669
JUMPV
LABELV $2668
line 3314
;3314:		Com_Printf("unknown UI script %s\n", name);
ADDRGP4 $2671
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 3315
;3315:	}
LABELV $2669
LABELV $2664
LABELV $2660
LABELV $2657
LABELV $2654
LABELV $2634
LABELV $2272
line 3316
;3316:}
LABELV $2270
endproc UI_RunMenuScript 1336 24
proc UI_GetTeamColor 0 0
line 3318
;3317:
;3318:static void UI_GetTeamColor(vec4_t *color) {}
LABELV $2672
endproc UI_GetTeamColor 0 0
proc UI_MapCountByGameType 12 0
line 3325
;3319:
;3320:/*
;3321:==================
;3322:UI_MapCountByGameType
;3323:==================
;3324:*/
;3325:static int UI_MapCountByGameType(void) {
line 3327
;3326:	int i, c, game;
;3327:	c = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 3328
;3328:	game = uiInfo.gameTypes[ui_netGameType.integer].gtEnum;
ADDRLP4 4
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359512+4
ADDP4
INDIRI4
ASGNI4
line 3329
;3329:	if (game == GT_TEAM) {
ADDRLP4 4
INDIRI4
CNSTI4 3
NEI4 $2677
line 3330
;3330:		game = GT_FFA;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3331
;3331:	}
LABELV $2677
line 3333
;3332:
;3333:	for (i = 0; i < uiInfo.mapCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2682
JUMPV
LABELV $2679
line 3334
;3334:		uiInfo.mapList[i].active = qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+96
ADDP4
CNSTI4 0
ASGNI4
line 3335
;3335:		if (uiInfo.mapList[i].typeBits & (1 << game)) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+20
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 4
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $2686
line 3336
;3336:			c++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3337
;3337:			uiInfo.mapList[i].active = qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+96
ADDP4
CNSTI4 1
ASGNI4
line 3338
;3338:		}
LABELV $2686
line 3339
;3339:	}
LABELV $2680
line 3333
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2682
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5364156
INDIRI4
LTI4 $2679
line 3340
;3340:	return c;
ADDRLP4 8
INDIRI4
RETI4
LABELV $2673
endproc UI_MapCountByGameType 12 0
export UI_hasSkinForBase
proc UI_hasSkinForBase 72 20
line 3343
;3341:}
;3342:
;3343:qboolean UI_hasSkinForBase(const char *base, const char *team) {
line 3346
;3344:	char	test[MAX_QPATH];
;3345:
;3346:	Com_sprintf(test, sizeof(test), "models/players/%s/%s/lower_default.skin", base, team);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $2693
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
line 3348
;3347:
;3348:	if (trap_FS_FOpenFile(test, NULL, FS_READ)) {
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 64
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $2694
line 3349
;3349:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2692
JUMPV
LABELV $2694
line 3351
;3350:	}
;3351:	Com_sprintf(test, sizeof(test), "models/players/characters/%s/%s/lower_default.skin", base, team);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $2696
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
line 3353
;3352:
;3353:	if (trap_FS_FOpenFile(test, NULL, FS_READ)) {
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 68
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $2697
line 3354
;3354:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2692
JUMPV
LABELV $2697
line 3356
;3355:	}
;3356:	return qfalse;
CNSTI4 0
RETI4
LABELV $2692
endproc UI_hasSkinForBase 72 20
data
align 4
LABELV $2700
byte 4 0
code
proc UI_HeadCountByTeam 40 8
line 3364
;3357:}
;3358:
;3359:/*
;3360:==================
;3361:UI_MapCountByTeam
;3362:==================
;3363:*/
;3364:static int UI_HeadCountByTeam() {
line 3368
;3365:	static int init = 0;
;3366:	int i, j, k, c, tIndex;
;3367:
;3368:	c = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 3369
;3369:	if (!init) {
ADDRGP4 $2700
INDIRI4
CNSTI4 0
NEI4 $2701
line 3370
;3370:		for (i = 0; i < uiInfo.characterCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2706
JUMPV
LABELV $2703
line 3371
;3371:			uiInfo.characterList[i].reference = 0;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380+20
ADDP4
CNSTI4 0
ASGNI4
line 3372
;3372:			for (j = 0; j < uiInfo.teamCount; j++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $2713
JUMPV
LABELV $2710
line 3373
;3373:				if (UI_hasSkinForBase(uiInfo.characterList[i].base, uiInfo.teamList[j].teamName)) {
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380+12
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692
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
EQI4 $2715
line 3374
;3374:					uiInfo.characterList[i].reference |= (1 << j);
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380+20
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
line 3375
;3375:				}
LABELV $2715
line 3376
;3376:			}
LABELV $2711
line 3372
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2713
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+5356688
INDIRI4
LTI4 $2710
line 3377
;3377:		}
LABELV $2704
line 3370
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2706
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5354372
INDIRI4
LTI4 $2703
line 3378
;3378:		init = 1;
ADDRGP4 $2700
CNSTI4 1
ASGNI4
line 3379
;3379:	}
LABELV $2701
line 3381
;3380:
;3381:	tIndex = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $712
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
line 3384
;3382:
;3383:	// do names
;3384:	for (i = 0; i < uiInfo.characterCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2725
JUMPV
LABELV $2722
line 3385
;3385:		uiInfo.characterList[i].active = qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380+16
ADDP4
CNSTI4 0
ASGNI4
line 3386
;3386:		for (j = 0; j < TEAM_MEMBERS; j++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $2729
line 3387
;3387:			if (uiInfo.teamList[tIndex].teamMembers[j] != NULL) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+8
ADDP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2733
line 3388
;3388:				if (uiInfo.characterList[i].reference & (1 << tIndex)) {// && Q_stricmp(uiInfo.teamList[tIndex].teamMembers[j], uiInfo.characterList[i].name)==0) {
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380+20
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 12
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $2737
line 3389
;3389:					uiInfo.characterList[i].active = qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380+16
ADDP4
CNSTI4 1
ASGNI4
line 3390
;3390:					c++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3391
;3391:					break;
ADDRGP4 $2731
JUMPV
LABELV $2737
line 3393
;3392:				}
;3393:			}
LABELV $2733
line 3394
;3394:		}
LABELV $2730
line 3386
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 5
LTI4 $2729
LABELV $2731
line 3395
;3395:	}
LABELV $2723
line 3384
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2725
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5354372
INDIRI4
LTI4 $2722
line 3398
;3396:
;3397:	// and then aliases
;3398:	for (j = 0; j < TEAM_MEMBERS; j++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $2743
line 3399
;3399:		for (k = 0; k < uiInfo.aliasCount; k++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2750
JUMPV
LABELV $2747
line 3400
;3400:			if (uiInfo.aliasList[k].name != NULL) {
ADDRLP4 4
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+5355920
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2752
line 3401
;3401:				if (Q_stricmp(uiInfo.teamList[tIndex].teamMembers[j], uiInfo.aliasList[k].name) == 0) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+8
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+5355920
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
NEI4 $2755
line 3402
;3402:					for (i = 0; i < uiInfo.characterCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2763
JUMPV
LABELV $2760
line 3403
;3403:						if (uiInfo.characterList[i].headImage != -1 && uiInfo.characterList[i].reference & (1 << tIndex) && Q_stricmp(uiInfo.aliasList[k].ai, uiInfo.characterList[i].name) == 0) {
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380+8
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $2765
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380+20
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 12
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $2765
ADDRLP4 4
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+5355920+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380
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
NEI4 $2765
line 3404
;3404:							if (uiInfo.characterList[i].active == qfalse) {
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380+16
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2762
line 3405
;3405:								uiInfo.characterList[i].active = qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380+16
ADDP4
CNSTI4 1
ASGNI4
line 3406
;3406:								c++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3407
;3407:							}
line 3408
;3408:							break;
ADDRGP4 $2762
JUMPV
LABELV $2765
line 3410
;3409:						}
;3410:					}
LABELV $2761
line 3402
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2763
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5354372
INDIRI4
LTI4 $2760
LABELV $2762
line 3411
;3411:				}
LABELV $2755
line 3412
;3412:			}
LABELV $2752
line 3413
;3413:		}
LABELV $2748
line 3399
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2750
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+5355916
INDIRI4
LTI4 $2747
line 3414
;3414:	}
LABELV $2744
line 3398
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 5
LTI4 $2743
line 3415
;3415:	return c;
ADDRLP4 16
INDIRI4
RETI4
LABELV $2699
endproc UI_HeadCountByTeam 40 8
proc UI_InsertServerIntoDisplayList 16 8
line 3423
;3416:}
;3417:
;3418:/*
;3419:==================
;3420:UI_InsertServerIntoDisplayList
;3421:==================
;3422:*/
;3423:static void UI_InsertServerIntoDisplayList(int num, int position) {
line 3426
;3424:	int i;
;3425:
;3426:	if (position < 0 || position > uiInfo.serverStatus.numDisplayServers) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $2785
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+5387364+10412
INDIRI4
LEI4 $2781
LABELV $2785
line 3427
;3427:		return;
ADDRGP4 $2780
JUMPV
LABELV $2781
line 3430
;3428:	}
;3429:	//
;3430:	uiInfo.serverStatus.numDisplayServers++;
ADDRLP4 8
ADDRGP4 uiInfo+5387364+10412
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3431
;3431:	for (i = uiInfo.serverStatus.numDisplayServers; i > position; i--) {
ADDRLP4 0
ADDRGP4 uiInfo+5387364+10412
INDIRI4
ASGNI4
ADDRGP4 $2791
JUMPV
LABELV $2788
line 3432
;3432:		uiInfo.serverStatus.displayServers[i] = uiInfo.serverStatus.displayServers[i - 1];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5387364+2220
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5387364+2220-4
ADDP4
INDIRI4
ASGNI4
line 3433
;3433:	}
LABELV $2789
line 3431
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $2791
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
GTI4 $2788
line 3434
;3434:	uiInfo.serverStatus.displayServers[position] = num;
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5387364+2220
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 3437
;3435:
;3436:	// update displayed levelshot
;3437:	if (position == uiInfo.serverStatus.currentServer) {
ADDRFP4 4
INDIRI4
ADDRGP4 uiInfo+5387364+2216
INDIRI4
NEI4 $2801
line 3438
;3438:		UI_FeederSelection(FEEDER_SERVERS, uiInfo.serverStatus.currentServer);
CNSTF4 1073741824
ARGF4
ADDRGP4 uiInfo+5387364+2216
INDIRI4
ARGI4
ADDRGP4 UI_FeederSelection
CALLV
pop
line 3439
;3439:	}
LABELV $2801
line 3440
;3440:}
LABELV $2780
endproc UI_InsertServerIntoDisplayList 16 8
proc UI_RemoveServerFromDisplayList 16 0
line 3447
;3441:
;3442:/*
;3443:==================
;3444:UI_RemoveServerFromDisplayList
;3445:==================
;3446:*/
;3447:static void UI_RemoveServerFromDisplayList(int num) {
line 3450
;3448:	int i, j;
;3449:
;3450:	for (i = 0; i < uiInfo.serverStatus.numDisplayServers; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2811
JUMPV
LABELV $2808
line 3451
;3451:		if (uiInfo.serverStatus.displayServers[i] == num) {
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5387364+2220
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $2814
line 3452
;3452:			uiInfo.serverStatus.numDisplayServers--;
ADDRLP4 8
ADDRGP4 uiInfo+5387364+10412
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3453
;3453:			for (j = i; j < uiInfo.serverStatus.numDisplayServers; j++) {
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $2823
JUMPV
LABELV $2820
line 3454
;3454:				uiInfo.serverStatus.displayServers[j] = uiInfo.serverStatus.displayServers[j + 1];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5387364+2220
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5387364+2220+4
ADDP4
INDIRI4
ASGNI4
line 3455
;3455:			}
LABELV $2821
line 3453
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2823
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5387364+10412
INDIRI4
LTI4 $2820
line 3456
;3456:			return;
ADDRGP4 $2807
JUMPV
LABELV $2814
line 3458
;3457:		}
;3458:	}
LABELV $2809
line 3450
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2811
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+5387364+10412
INDIRI4
LTI4 $2808
line 3459
;3459:}
LABELV $2807
endproc UI_RemoveServerFromDisplayList 16 0
proc UI_BinaryServerInsertion 24 20
line 3466
;3460:
;3461:/*
;3462:==================
;3463:UI_BinaryServerInsertion
;3464:==================
;3465:*/
;3466:static void UI_BinaryServerInsertion(int num) {
line 3470
;3467:	int mid, offset, res, len;
;3468:
;3469:	// use binary search to insert server
;3470:	len = uiInfo.serverStatus.numDisplayServers;
ADDRLP4 12
ADDRGP4 uiInfo+5387364+10412
INDIRI4
ASGNI4
line 3471
;3471:	mid = len;
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 3472
;3472:	offset = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 3473
;3473:	res = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2835
JUMPV
LABELV $2834
line 3474
;3474:	while (mid > 0) {
line 3475
;3475:		mid = len >> 1;
ADDRLP4 0
ADDRLP4 12
INDIRI4
CNSTI4 1
RSHI4
ASGNI4
line 3477
;3476:		//
;3477:		res = trap_LAN_CompareServers(UI_SourceForLAN(), uiInfo.serverStatus.sortKey,
ADDRLP4 16
ADDRGP4 UI_SourceForLAN
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 uiInfo+5387364+2200
INDIRI4
ARGI4
ADDRGP4 uiInfo+5387364+2204
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
ADDRGP4 uiInfo+5387364+2220
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 trap_LAN_CompareServers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
ASGNI4
line 3480
;3478:			uiInfo.serverStatus.sortDir, num, uiInfo.serverStatus.displayServers[offset + mid]);
;3479:		// if equal
;3480:		if (res == 0) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2843
line 3481
;3481:			UI_InsertServerIntoDisplayList(num, offset + mid);
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
line 3482
;3482:			return;
ADDRGP4 $2831
JUMPV
LABELV $2843
line 3485
;3483:		}
;3484:		// if larger
;3485:		else if (res == 1) {
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $2845
line 3486
;3486:			offset += mid;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 3487
;3487:			len -= mid;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ASGNI4
line 3488
;3488:		}
ADDRGP4 $2846
JUMPV
LABELV $2845
line 3490
;3489:		// if smaller
;3490:		else {
line 3491
;3491:			len -= mid;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ASGNI4
line 3492
;3492:		}
LABELV $2846
line 3493
;3493:	}
LABELV $2835
line 3474
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $2834
line 3494
;3494:	if (res == 1) {
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $2847
line 3495
;3495:		offset++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3496
;3496:	}
LABELV $2847
line 3497
;3497:	UI_InsertServerIntoDisplayList(num, offset);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 UI_InsertServerIntoDisplayList
CALLV
pop
line 3498
;3498:}
LABELV $2831
endproc UI_BinaryServerInsertion 24 20
bss
align 4
LABELV $2850
skip 4
code
proc UI_BuildServerDisplayList 1100 16
line 3505
;3499:
;3500:/*
;3501:==================
;3502:UI_BuildServerDisplayList
;3503:==================
;3504:*/
;3505:static void UI_BuildServerDisplayList(int force) {
line 3511
;3506:	int i, count, clients, maxClients, ping, game, len, visible;
;3507:	char info[MAX_STRING_CHARS];
;3508:	static int numinvisible;
;3509:	int	lanSource;
;3510:
;3511:	if (!(force || uiInfo.uiDC.realTime > uiInfo.serverStatus.nextDisplayRefresh)) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $2851
ADDRGP4 uiInfo+212
INDIRI4
ADDRGP4 uiInfo+5387364+10420
INDIRI4
GTI4 $2851
line 3512
;3512:		return;
ADDRGP4 $2849
JUMPV
LABELV $2851
line 3515
;3513:	}
;3514:	// if we shouldn't reset
;3515:	if (force == 2) {
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $2856
line 3516
;3516:		force = 0;
ADDRFP4 0
CNSTI4 0
ASGNI4
line 3517
;3517:	}
LABELV $2856
line 3520
;3518:
;3519:	// do motd updates here too
;3520:	trap_Cvar_VariableStringBuffer("cl_motdString", uiInfo.serverStatus.motd, sizeof(uiInfo.serverStatus.motd));
ADDRGP4 $2858
ARGP4
ADDRGP4 uiInfo+5387364+10460
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 3521
;3521:	len = strlen(uiInfo.serverStatus.motd);
ADDRGP4 uiInfo+5387364+10460
ARGP4
ADDRLP4 1060
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1056
ADDRLP4 1060
INDIRI4
ASGNI4
line 3522
;3522:	if (len == 0) {
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $2865
line 3523
;3523:		strcpy(uiInfo.serverStatus.motd, "Welcome to Team Arena!");
ADDRGP4 uiInfo+5387364+10460
ARGP4
ADDRGP4 $2869
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 3524
;3524:		len = strlen(uiInfo.serverStatus.motd);
ADDRGP4 uiInfo+5387364+10460
ARGP4
ADDRLP4 1064
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1056
ADDRLP4 1064
INDIRI4
ASGNI4
line 3525
;3525:	}
LABELV $2865
line 3526
;3526:	if (len != uiInfo.serverStatus.motdLen) {
ADDRLP4 1056
INDIRI4
ADDRGP4 uiInfo+5387364+10436
INDIRI4
EQI4 $2872
line 3527
;3527:		uiInfo.serverStatus.motdLen = len;
ADDRGP4 uiInfo+5387364+10436
ADDRLP4 1056
INDIRI4
ASGNI4
line 3528
;3528:		uiInfo.serverStatus.motdWidth = -1;
ADDRGP4 uiInfo+5387364+10440
CNSTI4 -1
ASGNI4
line 3529
;3529:	}
LABELV $2872
line 3531
;3530:
;3531:	lanSource = UI_SourceForLAN();
ADDRLP4 1064
ADDRGP4 UI_SourceForLAN
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 1064
INDIRI4
ASGNI4
line 3533
;3532:
;3533:	if (force) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $2880
line 3534
;3534:		numinvisible = 0;
ADDRGP4 $2850
CNSTI4 0
ASGNI4
line 3536
;3535:		// clear number of displayed servers
;3536:		uiInfo.serverStatus.numDisplayServers = 0;
ADDRGP4 uiInfo+5387364+10412
CNSTI4 0
ASGNI4
line 3537
;3537:		uiInfo.serverStatus.numPlayersOnServers = 0;
ADDRGP4 uiInfo+5387364+10416
CNSTI4 0
ASGNI4
line 3539
;3538:		// set list box index to zero
;3539:		Menu_SetFeederSelection(NULL, FEEDER_SERVERS, 0, NULL);
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
line 3541
;3540:		// mark all servers as visible so we store ping updates for them
;3541:		trap_LAN_MarkServerVisible(lanSource, -1, qtrue);
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_LAN_MarkServerVisible
CALLV
pop
line 3542
;3542:	}
LABELV $2880
line 3545
;3543:
;3544:	// get the server count (comes from the master)
;3545:	count = trap_LAN_GetServerCount(lanSource);
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 1068
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRLP4 1036
ADDRLP4 1068
INDIRI4
ASGNI4
line 3546
;3546:	if (count == -1 || (ui_netSource.integer == UIAS_LOCAL && count == 0)) {
ADDRLP4 1036
INDIRI4
CNSTI4 -1
EQI4 $2889
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
NEI4 $2886
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $2886
LABELV $2889
line 3548
;3547:		// still waiting on a response from the master
;3548:		uiInfo.serverStatus.numDisplayServers = 0;
ADDRGP4 uiInfo+5387364+10412
CNSTI4 0
ASGNI4
line 3549
;3549:		uiInfo.serverStatus.numPlayersOnServers = 0;
ADDRGP4 uiInfo+5387364+10416
CNSTI4 0
ASGNI4
line 3550
;3550:		uiInfo.serverStatus.nextDisplayRefresh = uiInfo.uiDC.realTime + 500;
ADDRGP4 uiInfo+5387364+10420
ADDRGP4 uiInfo+212
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 3551
;3551:		return;
ADDRGP4 $2849
JUMPV
LABELV $2886
line 3554
;3552:	}
;3553:
;3554:	visible = qfalse;
ADDRLP4 1044
CNSTI4 0
ASGNI4
line 3555
;3555:	for (i = 0; i < count; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2900
JUMPV
LABELV $2897
line 3557
;3556:		// if we already got info for this server
;3557:		if (!trap_LAN_ServerIsVisible(lanSource, i)) {
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1076
ADDRGP4 trap_LAN_ServerIsVisible
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
NEI4 $2901
line 3558
;3558:			continue;
ADDRGP4 $2898
JUMPV
LABELV $2901
line 3560
;3559:		}
;3560:		visible = qtrue;
ADDRLP4 1044
CNSTI4 1
ASGNI4
line 3562
;3561:		// get the ping for this server
;3562:		ping = trap_LAN_GetServerPing(lanSource, i);
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1080
ADDRGP4 trap_LAN_GetServerPing
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 1080
INDIRI4
ASGNI4
line 3563
;3563:		if (ping > 0 || ui_netSource.integer == UIAS_FAVORITES) {
ADDRLP4 8
INDIRI4
CNSTI4 0
GTI4 $2906
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 7
NEI4 $2903
LABELV $2906
line 3567
;3564:			// Remove favorite servers so they do not appear multiple times
;3565:			// or appear when the cached server info was not filtered out
;3566:			// but the new server info is filtered out.
;3567:			if (ui_netSource.integer == UIAS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 7
NEI4 $2907
line 3568
;3568:				UI_RemoveServerFromDisplayList(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 UI_RemoveServerFromDisplayList
CALLV
pop
line 3569
;3569:			}
LABELV $2907
line 3571
;3570:
;3571:			trap_LAN_GetServerInfo(lanSource, i, info, MAX_STRING_CHARS);
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerInfo
CALLV
pop
line 3573
;3572:
;3573:			clients = atoi(Info_ValueForKey(info, "clients"));
ADDRLP4 12
ARGP4
ADDRGP4 $2910
ARGP4
ADDRLP4 1084
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1084
INDIRP4
ARGP4
ADDRLP4 1088
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1088
INDIRI4
ASGNI4
line 3575
;3574:
;3575:			if (ui_browserShowEmpty.integer == 0) {
ADDRGP4 ui_browserShowEmpty+12
INDIRI4
CNSTI4 0
NEI4 $2911
line 3576
;3576:				if (clients == 0) {
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $2914
line 3577
;3577:					if (ping > 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LEI4 $2898
line 3578
;3578:						trap_LAN_MarkServerVisible(lanSource, i, qfalse);
ADDRLP4 4
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
line 3579
;3579:					}
line 3580
;3580:					continue;
ADDRGP4 $2898
JUMPV
LABELV $2914
line 3582
;3581:				}
;3582:			}
LABELV $2911
line 3584
;3583:
;3584:			if (ui_browserShowFull.integer == 0) {
ADDRGP4 ui_browserShowFull+12
INDIRI4
CNSTI4 0
NEI4 $2918
line 3585
;3585:				maxClients = atoi(Info_ValueForKey(info, "sv_maxclients"));
ADDRLP4 12
ARGP4
ADDRGP4 $1375
ARGP4
ADDRLP4 1092
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1092
INDIRP4
ARGP4
ADDRLP4 1096
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1048
ADDRLP4 1096
INDIRI4
ASGNI4
line 3586
;3586:				if (clients == maxClients) {
ADDRLP4 1040
INDIRI4
ADDRLP4 1048
INDIRI4
NEI4 $2921
line 3587
;3587:					if (ping > 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LEI4 $2898
line 3588
;3588:						trap_LAN_MarkServerVisible(lanSource, i, qfalse);
ADDRLP4 4
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
line 3589
;3589:					}
line 3590
;3590:					continue;
ADDRGP4 $2898
JUMPV
LABELV $2921
line 3592
;3591:				}
;3592:			}
LABELV $2918
line 3594
;3593:
;3594:			if (uiInfo.joinGameTypes[ui_joinGameType.integer].gtEnum != -1) {
ADDRGP4 ui_joinGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359644+4
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $2925
line 3595
;3595:				game = atoi(Info_ValueForKey(info, "gametype"));
ADDRLP4 12
ARGP4
ADDRGP4 $2930
ARGP4
ADDRLP4 1092
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1092
INDIRP4
ARGP4
ADDRLP4 1096
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1052
ADDRLP4 1096
INDIRI4
ASGNI4
line 3596
;3596:				if (game != uiInfo.joinGameTypes[ui_joinGameType.integer].gtEnum) {
ADDRLP4 1052
INDIRI4
ADDRGP4 ui_joinGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359644+4
ADDP4
INDIRI4
EQI4 $2931
line 3597
;3597:					if (ping > 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LEI4 $2898
line 3598
;3598:						trap_LAN_MarkServerVisible(lanSource, i, qfalse);
ADDRLP4 4
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
line 3599
;3599:					}
line 3600
;3600:					continue;
ADDRGP4 $2898
JUMPV
LABELV $2931
line 3602
;3601:				}
;3602:			}
LABELV $2925
line 3604
;3603:
;3604:			if (ui_serverFilterType.integer > 0) {
ADDRGP4 ui_serverFilterType+12
INDIRI4
CNSTI4 0
LEI4 $2938
line 3605
;3605:				if (Q_stricmp(Info_ValueForKey(info, "game"), serverFilters[ui_serverFilterType.integer].basedir) != 0) {
ADDRLP4 12
ARGP4
ADDRGP4 $2943
ARGP4
ADDRLP4 1092
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1092
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
ADDRLP4 1096
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1096
INDIRI4
CNSTI4 0
EQI4 $2941
line 3606
;3606:					if (ping > 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LEI4 $2898
line 3607
;3607:						trap_LAN_MarkServerVisible(lanSource, i, qfalse);
ADDRLP4 4
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
line 3608
;3608:					}
line 3609
;3609:					continue;
ADDRGP4 $2898
JUMPV
LABELV $2941
line 3611
;3610:				}
;3611:			}
LABELV $2938
line 3613
;3612:			// insert the server into the list
;3613:			UI_BinaryServerInsertion(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 UI_BinaryServerInsertion
CALLV
pop
line 3615
;3614:			// done with this server
;3615:			if (ping > 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LEI4 $2948
line 3616
;3616:				trap_LAN_MarkServerVisible(lanSource, i, qfalse);
ADDRLP4 4
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
line 3617
;3617:				uiInfo.serverStatus.numPlayersOnServers += clients;
ADDRLP4 1092
ADDRGP4 uiInfo+5387364+10416
ASGNP4
ADDRLP4 1092
INDIRP4
ADDRLP4 1092
INDIRP4
INDIRI4
ADDRLP4 1040
INDIRI4
ADDI4
ASGNI4
line 3618
;3618:				numinvisible++;
ADDRLP4 1096
ADDRGP4 $2850
ASGNP4
ADDRLP4 1096
INDIRP4
ADDRLP4 1096
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3619
;3619:			}
LABELV $2948
line 3620
;3620:		}
LABELV $2903
line 3621
;3621:	}
LABELV $2898
line 3555
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2900
ADDRLP4 0
INDIRI4
ADDRLP4 1036
INDIRI4
LTI4 $2897
line 3623
;3622:
;3623:	uiInfo.serverStatus.refreshtime = uiInfo.uiDC.realTime;
ADDRGP4 uiInfo+5387364+2192
ADDRGP4 uiInfo+212
INDIRI4
ASGNI4
line 3626
;3624:
;3625:	// if there were no servers visible for ping updates
;3626:	if (!visible) {
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $2955
line 3629
;3627:		//		UI_StopServerRefresh();
;3628:		//		uiInfo.serverStatus.nextDisplayRefresh = 0;
;3629:	}
LABELV $2955
line 3630
;3630:}
LABELV $2849
endproc UI_BuildServerDisplayList 1100 16
data
export serverStatusCvars
align 4
LABELV serverStatusCvars
address $2958
address $2959
address $2960
address $114
address $2961
address $2962
address $1340
address $2963
address $2964
address $2965
address $2966
address $114
address $2087
address $114
address $2967
address $114
address $730
address $114
byte 4 0
byte 4 0
code
proc UI_SortServerStatusInfo 44 8
line 3654
;3631:
;3632:typedef struct {
;3633:	char *name, *altName;
;3634:} serverStatusCvar_t;
;3635:
;3636:serverStatusCvar_t serverStatusCvars[] = {
;3637:	{"sv_hostname", "Name"},
;3638:	{"Address", ""},
;3639:	{"gamename", "Game name"},
;3640:	{"g_gametype", "Game type"},
;3641:	{"mapname", "Map"},
;3642:	{"version", ""},
;3643:	{"protocol", ""},
;3644:	{"timelimit", ""},
;3645:	{"fraglimit", ""},
;3646:	{NULL, NULL}
;3647:};
;3648:
;3649:/*
;3650:==================
;3651:UI_SortServerStatusInfo
;3652:==================
;3653:*/
;3654:static void UI_SortServerStatusInfo(serverStatusInfo_t *info) {
line 3661
;3655:	int i, j, index;
;3656:	char *tmp1, *tmp2;
;3657:
;3658:	// FIXME: if "gamename" == "baseq3" or "missionpack" then
;3659:	// replace the gametype number by FFA, CTF etc.
;3660:	//
;3661:	index = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3662
;3662:	for (i = 0; serverStatusCvars[i].name; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $2972
JUMPV
LABELV $2969
line 3663
;3663:		for (j = 0; j < info->numLines; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2976
JUMPV
LABELV $2973
line 3664
;3664:			if (!info->lines[j][1] || info->lines[j][1][0]) {
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
EQU4 $2979
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
EQI4 $2977
LABELV $2979
line 3665
;3665:				continue;
ADDRGP4 $2974
JUMPV
LABELV $2977
line 3667
;3666:			}
;3667:			if (!Q_stricmp(serverStatusCvars[i].name, info->lines[j][0])) {
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
NEI4 $2980
line 3669
;3668:				// swap lines
;3669:				tmp1 = info->lines[index][0];
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
line 3670
;3670:				tmp2 = info->lines[index][3];
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
line 3671
;3671:				info->lines[index][0] = info->lines[j][0];
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
line 3672
;3672:				info->lines[index][3] = info->lines[j][3];
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
line 3673
;3673:				info->lines[j][0] = tmp1;
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
line 3674
;3674:				info->lines[j][3] = tmp2;
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
line 3676
;3675:				//
;3676:				if (strlen(serverStatusCvars[i].altName)) {
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
EQI4 $2982
line 3677
;3677:					info->lines[index][0] = serverStatusCvars[i].altName;
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
line 3678
;3678:				}
LABELV $2982
line 3679
;3679:				index++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3680
;3680:			}
LABELV $2980
line 3681
;3681:		}
LABELV $2974
line 3663
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2976
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
LTI4 $2973
line 3682
;3682:	}
LABELV $2970
line 3662
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2972
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 serverStatusCvars
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2969
line 3683
;3683:}
LABELV $2968
endproc UI_SortServerStatusInfo 44 8
proc UI_GetServerStatusInfo 156 16
line 3690
;3684:
;3685:/*
;3686:==================
;3687:UI_GetServerStatusInfo
;3688:==================
;3689:*/
;3690:static int UI_GetServerStatusInfo(const char *serverAddress, serverStatusInfo_t *info) {
line 3694
;3691:	char *p, *score, *ping, *name;
;3692:	int i, len;
;3693:
;3694:	if (info) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2987
line 3695
;3695:		memset(info, 0, sizeof(*info));
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
line 3696
;3696:	}
LABELV $2987
line 3699
;3697:
;3698:	// ignore initial unset addresses
;3699:	if (serverAddress && *serverAddress == '\0') {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2989
ADDRLP4 24
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2989
line 3700
;3700:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2986
JUMPV
LABELV $2989
line 3704
;3701:	}
;3702:
;3703:	// reset server status request for this address
;3704:	if (!info) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2991
line 3705
;3705:		trap_LAN_ServerStatus(serverAddress, NULL, 0);
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
line 3706
;3706:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2986
JUMPV
LABELV $2991
line 3709
;3707:	}
;3708:
;3709:	if (trap_LAN_ServerStatus(serverAddress, info->text, sizeof(info->text))) {
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
ADDRLP4 28
ADDRGP4 trap_LAN_ServerStatus
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2993
line 3710
;3710:		Q_strncpyz(info->address, serverAddress, sizeof(info->address));
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
line 3711
;3711:		p = info->text;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 2112
ADDP4
ASGNP4
line 3712
;3712:		info->numLines = 0;
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
CNSTI4 0
ASGNI4
line 3713
;3713:		info->lines[info->numLines][0] = "Address";
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
ADDRGP4 $2960
ASGNP4
line 3714
;3714:		info->lines[info->numLines][1] = "";
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
CNSTI4 4
ADDP4
ADDRGP4 $114
ASGNP4
line 3715
;3715:		info->lines[info->numLines][2] = "";
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
CNSTI4 8
ADDP4
ADDRGP4 $114
ASGNP4
line 3716
;3716:		info->lines[info->numLines][3] = info->address;
ADDRLP4 44
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 44
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 44
INDIRP4
ASGNP4
line 3717
;3717:		info->numLines++;
ADDRLP4 48
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $2996
JUMPV
LABELV $2995
line 3719
;3718:		// get the cvars
;3719:		while (p && *p) {
line 3720
;3720:			p = strchr(p, '\\');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 52
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 52
INDIRP4
ASGNP4
line 3721
;3721:			if (!p) break;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2998
ADDRGP4 $2997
JUMPV
LABELV $2998
line 3722
;3722:			*p++ = '\0';
ADDRLP4 56
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI1 0
ASGNI1
line 3723
;3723:			if (*p == '\\')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $3000
line 3724
;3724:				break;
ADDRGP4 $2997
JUMPV
LABELV $3000
line 3725
;3725:			info->lines[info->numLines][0] = p;
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
ADDRLP4 0
INDIRP4
ASGNP4
line 3726
;3726:			info->lines[info->numLines][1] = "";
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
CNSTI4 4
ADDP4
ADDRGP4 $114
ASGNP4
line 3727
;3727:			info->lines[info->numLines][2] = "";
ADDRLP4 68
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 68
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRGP4 $114
ASGNP4
line 3728
;3728:			p = strchr(p, '\\');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 72
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 72
INDIRP4
ASGNP4
line 3729
;3729:			if (!p) break;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3002
ADDRGP4 $2997
JUMPV
LABELV $3002
line 3730
;3730:			*p++ = '\0';
ADDRLP4 76
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 76
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI1 0
ASGNI1
line 3731
;3731:			info->lines[info->numLines][3] = p;
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
CNSTI4 12
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 3733
;3732:
;3733:			info->numLines++;
ADDRLP4 84
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3734
;3734:			if (info->numLines >= MAX_SERVERSTATUS_LINES)
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 128
LTI4 $3004
line 3735
;3735:				break;
ADDRGP4 $2997
JUMPV
LABELV $3004
line 3736
;3736:		}
LABELV $2996
line 3719
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3006
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2995
LABELV $3006
LABELV $2997
line 3738
;3737:		// get the player list
;3738:		if (info->numLines < MAX_SERVERSTATUS_LINES - 3) {
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 125
GEI4 $3007
line 3740
;3739:			// empty line
;3740:			info->lines[info->numLines][0] = "";
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
ADDRGP4 $114
ASGNP4
line 3741
;3741:			info->lines[info->numLines][1] = "";
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
ADDRGP4 $114
ASGNP4
line 3742
;3742:			info->lines[info->numLines][2] = "";
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
ADDRGP4 $114
ASGNP4
line 3743
;3743:			info->lines[info->numLines][3] = "";
ADDRLP4 68
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 68
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRGP4 $114
ASGNP4
line 3744
;3744:			info->numLines++;
ADDRLP4 72
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3746
;3745:			// header
;3746:			info->lines[info->numLines][0] = "num";
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
ADDRGP4 $3009
ASGNP4
line 3747
;3747:			info->lines[info->numLines][1] = "score";
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
CNSTI4 4
ADDP4
ADDRGP4 $3010
ASGNP4
line 3748
;3748:			info->lines[info->numLines][2] = "ping";
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
CNSTI4 8
ADDP4
ADDRGP4 $3011
ASGNP4
line 3749
;3749:			info->lines[info->numLines][3] = "name";
ADDRLP4 88
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 88
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRGP4 $1424
ASGNP4
line 3750
;3750:			info->numLines++;
ADDRLP4 92
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3752
;3751:			// parse players
;3752:			i = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 3753
;3753:			len = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $3013
JUMPV
LABELV $3012
line 3754
;3754:			while (p && *p) {
line 3755
;3755:				if (*p == '\\')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $3015
line 3756
;3756:					*p++ = '\0';
ADDRLP4 96
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 96
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI1 0
ASGNI1
LABELV $3015
line 3757
;3757:				score = p;
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
line 3758
;3758:				p = strchr(p, ' ');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 100
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 100
INDIRP4
ASGNP4
line 3759
;3759:				if (!p)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3017
line 3760
;3760:					break;
ADDRGP4 $3014
JUMPV
LABELV $3017
line 3761
;3761:				*p++ = '\0';
ADDRLP4 104
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 104
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
CNSTI1 0
ASGNI1
line 3762
;3762:				ping = p;
ADDRLP4 16
ADDRLP4 0
INDIRP4
ASGNP4
line 3763
;3763:				p = strchr(p, ' ');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 108
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 108
INDIRP4
ASGNP4
line 3764
;3764:				if (!p)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3019
line 3765
;3765:					break;
ADDRGP4 $3014
JUMPV
LABELV $3019
line 3766
;3766:				*p++ = '\0';
ADDRLP4 112
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 112
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
CNSTI1 0
ASGNI1
line 3767
;3767:				name = p;
ADDRLP4 20
ADDRLP4 0
INDIRP4
ASGNP4
line 3768
;3768:				Com_sprintf(&info->pings[len], sizeof(info->pings) - len, "%d", i);
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
ADDRGP4 $727
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3769
;3769:				info->lines[info->numLines][0] = &info->pings[len];
ADDRLP4 120
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 120
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 120
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRLP4 4
INDIRI4
ADDRLP4 120
INDIRP4
CNSTI4 3136
ADDP4
ADDP4
ASGNP4
line 3770
;3770:				len += strlen(&info->pings[len]) + 1;
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 3136
ADDP4
ADDP4
ARGP4
ADDRLP4 128
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 128
INDIRI4
CNSTI4 1
ADDI4
ADDI4
ASGNI4
line 3771
;3771:				info->lines[info->numLines][1] = score;
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
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRP4
ASGNP4
line 3772
;3772:				info->lines[info->numLines][2] = ping;
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
CNSTI4 8
ADDP4
ADDRLP4 16
INDIRP4
ASGNP4
line 3773
;3773:				info->lines[info->numLines][3] = name;
ADDRLP4 140
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 140
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 140
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 20
INDIRP4
ASGNP4
line 3774
;3774:				info->numLines++;
ADDRLP4 144
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
ASGNP4
ADDRLP4 144
INDIRP4
ADDRLP4 144
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3775
;3775:				if (info->numLines >= MAX_SERVERSTATUS_LINES)
ADDRFP4 4
INDIRP4
CNSTI4 3328
ADDP4
INDIRI4
CNSTI4 128
LTI4 $3021
line 3776
;3776:					break;
ADDRGP4 $3014
JUMPV
LABELV $3021
line 3777
;3777:				p = strchr(p, '\\');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 148
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 148
INDIRP4
ASGNP4
line 3778
;3778:				if (!p)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3023
line 3779
;3779:					break;
ADDRGP4 $3014
JUMPV
LABELV $3023
line 3780
;3780:				*p++ = '\0';
ADDRLP4 152
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 152
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 152
INDIRP4
CNSTI1 0
ASGNI1
line 3782
;3781:				//
;3782:				i++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3783
;3783:			}
LABELV $3013
line 3754
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3025
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3012
LABELV $3025
LABELV $3014
line 3784
;3784:		}
LABELV $3007
line 3785
;3785:		UI_SortServerStatusInfo(info);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 UI_SortServerStatusInfo
CALLV
pop
line 3786
;3786:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2986
JUMPV
LABELV $2993
line 3788
;3787:	}
;3788:	return qfalse;
CNSTI4 0
RETI4
LABELV $2986
endproc UI_GetServerStatusInfo 156 16
proc stristr 12 4
line 3796
;3789:}
;3790:
;3791:/*
;3792:==================
;3793:stristr
;3794:==================
;3795:*/
;3796:static char *stristr(char *str, char *charset) {
ADDRGP4 $3028
JUMPV
LABELV $3027
line 3799
;3797:	int i;
;3798:
;3799:	while (*str) {
line 3800
;3800:		for (i = 0; charset[i] && str[i]; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3033
JUMPV
LABELV $3030
line 3801
;3801:			if (toupper(charset[i]) != toupper(str[i])) break;
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
EQI4 $3034
ADDRGP4 $3032
JUMPV
LABELV $3034
line 3802
;3802:		}
LABELV $3031
line 3800
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3033
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3036
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3030
LABELV $3036
LABELV $3032
line 3803
;3803:		if (!charset[i]) return str;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3037
ADDRFP4 0
INDIRP4
RETP4
ADDRGP4 $3026
JUMPV
LABELV $3037
line 3804
;3804:		str++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 3805
;3805:	}
LABELV $3028
line 3799
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3027
line 3806
;3806:	return NULL;
CNSTP4 0
RETP4
LABELV $3026
endproc stristr 12 4
bss
align 4
LABELV $3040
skip 4
align 4
LABELV $3041
skip 4
code
proc UI_BuildFindPlayerList 4428 24
line 3814
;3807:}
;3808:
;3809:/*
;3810:==================
;3811:UI_BuildFindPlayerList
;3812:==================
;3813:*/
;3814:static void UI_BuildFindPlayerList(qboolean force) {
line 3822
;3815:	static int numFound, numTimeOuts;
;3816:	int i, j, resend;
;3817:	serverStatusInfo_t info;
;3818:	char name[MAX_NAME_LENGTH + 2];
;3819:	char infoString[MAX_STRING_CHARS];
;3820:	int	lanSource;
;3821:
;3822:	if (!force) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $3042
line 3823
;3823:		if (!uiInfo.nextFindPlayerRefresh || uiInfo.nextFindPlayerRefresh > uiInfo.uiDC.realTime) {
ADDRGP4 uiInfo+5407572
INDIRI4
CNSTI4 0
EQI4 $3049
ADDRGP4 uiInfo+5407572
INDIRI4
ADDRGP4 uiInfo+212
INDIRI4
LEI4 $3043
LABELV $3049
line 3824
;3824:			return;
ADDRGP4 $3039
JUMPV
line 3826
;3825:		}
;3826:	} else {
LABELV $3042
line 3827
;3827:		memset(&uiInfo.pendingServerStatus, 0, sizeof(uiInfo.pendingServerStatus));
ADDRGP4 uiInfo+5402248
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2244
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3828
;3828:		uiInfo.numFoundPlayerServers = 0;
ADDRGP4 uiInfo+5407568
CNSTI4 0
ASGNI4
line 3829
;3829:		uiInfo.currentFoundPlayerServer = 0;
ADDRGP4 uiInfo+5407564
CNSTI4 0
ASGNI4
line 3830
;3830:		trap_Cvar_VariableStringBuffer("ui_findPlayer", uiInfo.findPlayerName, sizeof(uiInfo.findPlayerName));
ADDRGP4 $3054
ARGP4
ADDRGP4 uiInfo+5404492
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 3831
;3831:		Q_CleanStr(uiInfo.findPlayerName);
ADDRGP4 uiInfo+5404492
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 3833
;3832:		// should have a string of some length
;3833:		if (!strlen(uiInfo.findPlayerName)) {
ADDRGP4 uiInfo+5404492
ARGP4
ADDRLP4 4408
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4408
INDIRI4
CNSTI4 0
NEI4 $3058
line 3834
;3834:			uiInfo.nextFindPlayerRefresh = 0;
ADDRGP4 uiInfo+5407572
CNSTI4 0
ASGNI4
line 3835
;3835:			return;
ADDRGP4 $3039
JUMPV
LABELV $3058
line 3838
;3836:		}
;3837:		// set resend time
;3838:		resend = ui_serverStatusTimeOut.integer / 2 - 10;
ADDRLP4 4404
ADDRGP4 ui_serverStatusTimeOut+12
INDIRI4
CNSTI4 2
DIVI4
CNSTI4 10
SUBI4
ASGNI4
line 3839
;3839:		if (resend < 50) {
ADDRLP4 4404
INDIRI4
CNSTI4 50
GEI4 $3063
line 3840
;3840:			resend = 50;
ADDRLP4 4404
CNSTI4 50
ASGNI4
line 3841
;3841:		}
LABELV $3063
line 3842
;3842:		trap_Cvar_Set("cl_serverStatusResendTime", va("%d", resend));
ADDRGP4 $727
ARGP4
ADDRLP4 4404
INDIRI4
ARGI4
ADDRLP4 4412
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $3065
ARGP4
ADDRLP4 4412
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3844
;3843:		// reset all server status requests
;3844:		trap_LAN_ServerStatus(NULL, NULL, 0);
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_ServerStatus
CALLI4
pop
line 3846
;3845:		//
;3846:		uiInfo.numFoundPlayerServers = 1;
ADDRGP4 uiInfo+5407568
CNSTI4 1
ASGNI4
line 3847
;3847:		Com_sprintf(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers - 1],
ADDRGP4 uiInfo+5407568
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+5406540-64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $3073
ARGP4
ADDRGP4 uiInfo+5402248
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3850
;3848:			sizeof(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers - 1]),
;3849:			"searching %d...", uiInfo.pendingServerStatus.num);
;3850:		numFound = 0;
ADDRGP4 $3040
CNSTI4 0
ASGNI4
line 3851
;3851:		numTimeOuts++;
ADDRLP4 4416
ADDRGP4 $3041
ASGNP4
ADDRLP4 4416
INDIRP4
ADDRLP4 4416
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3852
;3852:	}
LABELV $3043
line 3853
;3853:	for (i = 0; i < MAX_SERVERSTATUSREQUESTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $3075
line 3855
;3854:		// if this pending server is valid
;3855:		if (uiInfo.pendingServerStatus.server[i].valid) {
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+5402248+4+136
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3079
line 3857
;3856:			// try to get the server status for this server
;3857:			if (UI_GetServerStatusInfo(uiInfo.pendingServerStatus.server[i].adrstr, &info)) {
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+5402248+4
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 4408
ADDRGP4 UI_GetServerStatusInfo
CALLI4
ASGNI4
ADDRLP4 4408
INDIRI4
CNSTI4 0
EQI4 $3084
line 3859
;3858:				//
;3859:				numFound++;
ADDRLP4 4412
ADDRGP4 $3040
ASGNP4
ADDRLP4 4412
INDIRP4
ADDRLP4 4412
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3861
;3860:				// parse through the server status lines
;3861:				for (j = 0; j < info.numLines; j++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $3091
JUMPV
LABELV $3088
line 3863
;3862:					// should have ping info
;3863:					if (!info.lines[j][2] || !info.lines[j][2][0]) {
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 8+64+8
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3099
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
NEI4 $3093
LABELV $3099
line 3864
;3864:						continue;
ADDRGP4 $3089
JUMPV
LABELV $3093
line 3867
;3865:					}
;3866:					// clean string first
;3867:					Q_strncpyz(name, info.lines[j][3], sizeof(name));
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
line 3868
;3868:					Q_CleanStr(name);
ADDRLP4 3340
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 3870
;3869:					// if the player name is a substring
;3870:					if (stristr(name, uiInfo.findPlayerName)) {
ADDRLP4 3340
ARGP4
ADDRGP4 uiInfo+5404492
ARGP4
ADDRLP4 4420
ADDRGP4 stristr
CALLP4
ASGNP4
ADDRLP4 4420
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3102
line 3872
;3871:						// add to found server list if we have space (always leave space for a line with the number found)
;3872:						if (uiInfo.numFoundPlayerServers < MAX_FOUNDPLAYER_SERVERS - 1) {
ADDRGP4 uiInfo+5407568
INDIRI4
CNSTI4 15
GEI4 $3105
line 3874
;3873:							//
;3874:							Q_strncpyz(uiInfo.foundPlayerServerAddresses[uiInfo.numFoundPlayerServers - 1],
ADDRGP4 uiInfo+5407568
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+5405516-64
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+5402248+4
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3877
;3875:								uiInfo.pendingServerStatus.server[i].adrstr,
;3876:								sizeof(uiInfo.foundPlayerServerAddresses[0]));
;3877:							Q_strncpyz(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers - 1],
ADDRGP4 uiInfo+5407568
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+5406540-64
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+5402248+4+64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3880
;3878:								uiInfo.pendingServerStatus.server[i].name,
;3879:								sizeof(uiInfo.foundPlayerServerNames[0]));
;3880:							uiInfo.numFoundPlayerServers++;
ADDRLP4 4424
ADDRGP4 uiInfo+5407568
ASGNP4
ADDRLP4 4424
INDIRP4
ADDRLP4 4424
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3881
;3881:						} else {
ADDRGP4 $3106
JUMPV
LABELV $3105
line 3883
;3882:							// can't add any more so we're done
;3883:							uiInfo.pendingServerStatus.num = uiInfo.serverStatus.numDisplayServers;
ADDRGP4 uiInfo+5402248
ADDRGP4 uiInfo+5387364+10412
INDIRI4
ASGNI4
line 3884
;3884:						}
LABELV $3106
line 3885
;3885:					}
LABELV $3102
line 3886
;3886:				}
LABELV $3089
line 3861
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3091
ADDRLP4 4
INDIRI4
ADDRLP4 8+3328
INDIRI4
LTI4 $3088
line 3887
;3887:				Com_sprintf(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers - 1],
ADDRGP4 uiInfo+5407568
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+5406540-64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $3131
ARGP4
ADDRGP4 uiInfo+5402248
INDIRI4
ARGI4
ADDRGP4 $3040
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3891
;3888:					sizeof(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers - 1]),
;3889:					"searching %d/%d...", uiInfo.pendingServerStatus.num, numFound);
;3890:				// retrieved the server status so reuse this spot
;3891:				uiInfo.pendingServerStatus.server[i].valid = qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+5402248+4+136
ADDP4
CNSTI4 0
ASGNI4
line 3892
;3892:			}
LABELV $3084
line 3893
;3893:		}
LABELV $3079
line 3895
;3894:		// if empty pending slot or timed out
;3895:		if (!uiInfo.pendingServerStatus.server[i].valid ||
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+5402248+4+136
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3146
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+5402248+4+128
ADDP4
INDIRI4
ADDRGP4 uiInfo+212
INDIRI4
ADDRGP4 ui_serverStatusTimeOut+12
INDIRI4
SUBI4
GEI4 $3136
LABELV $3146
line 3896
;3896:			uiInfo.pendingServerStatus.server[i].startTime < uiInfo.uiDC.realTime - ui_serverStatusTimeOut.integer) {
line 3897
;3897:			if (uiInfo.pendingServerStatus.server[i].valid) {
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+5402248+4+136
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3147
line 3898
;3898:				numTimeOuts++;
ADDRLP4 4412
ADDRGP4 $3041
ASGNP4
ADDRLP4 4412
INDIRP4
ADDRLP4 4412
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3899
;3899:			}
LABELV $3147
line 3901
;3900:			// reset server status request for this address
;3901:			UI_GetServerStatusInfo(uiInfo.pendingServerStatus.server[i].adrstr, NULL);
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+5402248+4
ADDP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 UI_GetServerStatusInfo
CALLI4
pop
line 3903
;3902:			// reuse pending slot
;3903:			uiInfo.pendingServerStatus.server[i].valid = qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+5402248+4+136
ADDP4
CNSTI4 0
ASGNI4
line 3905
;3904:			// if we didn't try to get the status of all servers in the main browser yet
;3905:			if (uiInfo.pendingServerStatus.num < uiInfo.serverStatus.numDisplayServers) {
ADDRGP4 uiInfo+5402248
INDIRI4
ADDRGP4 uiInfo+5387364+10412
INDIRI4
GEI4 $3157
line 3906
;3906:				uiInfo.pendingServerStatus.server[i].startTime = uiInfo.uiDC.realTime;
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+5402248+4+128
ADDP4
ADDRGP4 uiInfo+212
INDIRI4
ASGNI4
line 3907
;3907:				lanSource = UI_SourceForLAN();
ADDRLP4 4412
ADDRGP4 UI_SourceForLAN
CALLI4
ASGNI4
ADDRLP4 4400
ADDRLP4 4412
INDIRI4
ASGNI4
line 3908
;3908:				trap_LAN_GetServerAddressString(lanSource, uiInfo.serverStatus.displayServers[uiInfo.pendingServerStatus.num],
ADDRLP4 4400
INDIRI4
ARGI4
ADDRGP4 uiInfo+5402248
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5387364+2220
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+5402248+4
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_LAN_GetServerAddressString
CALLV
pop
line 3910
;3909:					uiInfo.pendingServerStatus.server[i].adrstr, sizeof(uiInfo.pendingServerStatus.server[i].adrstr));
;3910:				trap_LAN_GetServerInfo(lanSource, uiInfo.serverStatus.displayServers[uiInfo.pendingServerStatus.num], infoString, sizeof(infoString));
ADDRLP4 4400
INDIRI4
ARGI4
ADDRGP4 uiInfo+5402248
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5387364+2220
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
line 3911
;3911:				Q_strncpyz(uiInfo.pendingServerStatus.server[i].name, Info_ValueForKey(infoString, "hostname"), sizeof(uiInfo.pendingServerStatus.server[0].name));
ADDRLP4 3374
ARGP4
ADDRGP4 $2599
ARGP4
ADDRLP4 4416
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+5402248+4+64
ADDP4
ARGP4
ADDRLP4 4416
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 3912
;3912:				uiInfo.pendingServerStatus.server[i].valid = qtrue;
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+5402248+4+136
ADDP4
CNSTI4 1
ASGNI4
line 3913
;3913:				uiInfo.pendingServerStatus.num++;
ADDRLP4 4420
ADDRGP4 uiInfo+5402248
ASGNP4
ADDRLP4 4420
INDIRP4
ADDRLP4 4420
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3914
;3914:				Com_sprintf(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers - 1],
ADDRGP4 uiInfo+5407568
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+5406540-64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $3131
ARGP4
ADDRGP4 uiInfo+5402248
INDIRI4
ARGI4
ADDRGP4 $3040
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3917
;3915:					sizeof(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers - 1]),
;3916:					"searching %d/%d...", uiInfo.pendingServerStatus.num, numFound);
;3917:			}
LABELV $3157
line 3918
;3918:		}
LABELV $3136
line 3919
;3919:	}
LABELV $3076
line 3853
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $3075
line 3920
;3920:	for (i = 0; i < MAX_SERVERSTATUSREQUESTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $3193
line 3921
;3921:		if (uiInfo.pendingServerStatus.server[i].valid) {
ADDRLP4 0
INDIRI4
CNSTI4 140
MULI4
ADDRGP4 uiInfo+5402248+4+136
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3197
line 3922
;3922:			break;
ADDRGP4 $3195
JUMPV
LABELV $3197
line 3924
;3923:		}
;3924:	}
LABELV $3194
line 3920
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $3193
LABELV $3195
line 3926
;3925:	// if still trying to retrieve server status info
;3926:	if (i < MAX_SERVERSTATUSREQUESTS) {
ADDRLP4 0
INDIRI4
CNSTI4 16
GEI4 $3202
line 3927
;3927:		uiInfo.nextFindPlayerRefresh = uiInfo.uiDC.realTime + 25;
ADDRGP4 uiInfo+5407572
ADDRGP4 uiInfo+212
INDIRI4
CNSTI4 25
ADDI4
ASGNI4
line 3928
;3928:	} else {
ADDRGP4 $3203
JUMPV
LABELV $3202
line 3930
;3929:		// add a line that shows the number of servers found
;3930:		if (!uiInfo.numFoundPlayerServers) {
ADDRGP4 uiInfo+5407568
INDIRI4
CNSTI4 0
NEI4 $3206
line 3931
;3931:			Com_sprintf(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers - 1], sizeof(uiInfo.foundPlayerServerAddresses[0]), "no servers found");
ADDRGP4 uiInfo+5407568
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+5406540-64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $3213
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3932
;3932:		} else {
ADDRGP4 $3207
JUMPV
LABELV $3206
line 3933
;3933:			Com_sprintf(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers - 1], sizeof(uiInfo.foundPlayerServerAddresses[0]),
ADDRGP4 uiInfo+5407568
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+5406540-64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $3218
ARGP4
ADDRGP4 uiInfo+5407568
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 uiInfo+5407568
INDIRI4
CNSTI4 2
NEI4 $3224
ADDRLP4 4408
ADDRGP4 $114
ASGNP4
ADDRGP4 $3225
JUMPV
LABELV $3224
ADDRLP4 4408
ADDRGP4 $3221
ASGNP4
LABELV $3225
ADDRLP4 4408
INDIRP4
ARGP4
ADDRGP4 uiInfo+5404492
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 3936
;3934:				"%d server%s found with player %s", uiInfo.numFoundPlayerServers - 1,
;3935:				uiInfo.numFoundPlayerServers == 2 ? "" : "s", uiInfo.findPlayerName);
;3936:		}
LABELV $3207
line 3937
;3937:		uiInfo.nextFindPlayerRefresh = 0;
ADDRGP4 uiInfo+5407572
CNSTI4 0
ASGNI4
line 3939
;3938:		// show the server status info for the selected server
;3939:		UI_FeederSelection(FEEDER_FINDPLAYER, uiInfo.currentFoundPlayerServer);
CNSTF4 1096810496
ARGF4
ADDRGP4 uiInfo+5407564
INDIRI4
ARGI4
ADDRGP4 UI_FeederSelection
CALLV
pop
line 3940
;3940:	}
LABELV $3203
line 3941
;3941:}
LABELV $3039
endproc UI_BuildFindPlayerList 4428 24
proc UI_BuildServerStatus 4 16
line 3948
;3942:
;3943:/*
;3944:==================
;3945:UI_BuildServerStatus
;3946:==================
;3947:*/
;3948:static void UI_BuildServerStatus(qboolean force) {
line 3950
;3949:
;3950:	if (uiInfo.nextFindPlayerRefresh) {
ADDRGP4 uiInfo+5407572
INDIRI4
CNSTI4 0
EQI4 $3229
line 3951
;3951:		return;
ADDRGP4 $3228
JUMPV
LABELV $3229
line 3953
;3952:	}
;3953:	if (!force) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $3232
line 3954
;3954:		if (!uiInfo.nextServerStatusRefresh || uiInfo.nextServerStatusRefresh > uiInfo.uiDC.realTime) {
ADDRGP4 uiInfo+5402244
INDIRI4
CNSTI4 0
EQI4 $3239
ADDRGP4 uiInfo+5402244
INDIRI4
ADDRGP4 uiInfo+212
INDIRI4
LEI4 $3233
LABELV $3239
line 3955
;3955:			return;
ADDRGP4 $3228
JUMPV
line 3957
;3956:		}
;3957:	} else {
LABELV $3232
line 3958
;3958:		Menu_SetFeederSelection(NULL, FEEDER_SERVERSTATUS, 0, NULL);
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
line 3959
;3959:		uiInfo.serverStatusInfo.numLines = 0;
ADDRGP4 uiInfo+5398912+3328
CNSTI4 0
ASGNI4
line 3961
;3960:		// reset all server status requests
;3961:		trap_LAN_ServerStatus(NULL, NULL, 0);
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_ServerStatus
CALLI4
pop
line 3962
;3962:	}
LABELV $3233
line 3963
;3963:	if (uiInfo.serverStatus.currentServer < 0 || uiInfo.serverStatus.currentServer > uiInfo.serverStatus.numDisplayServers || uiInfo.serverStatus.numDisplayServers == 0) {
ADDRGP4 uiInfo+5387364+2216
INDIRI4
CNSTI4 0
LTI4 $3253
ADDRGP4 uiInfo+5387364+2216
INDIRI4
ADDRGP4 uiInfo+5387364+10412
INDIRI4
GTI4 $3253
ADDRGP4 uiInfo+5387364+10412
INDIRI4
CNSTI4 0
NEI4 $3242
LABELV $3253
line 3964
;3964:		return;
ADDRGP4 $3228
JUMPV
LABELV $3242
line 3966
;3965:	}
;3966:	if (UI_GetServerStatusInfo(uiInfo.serverStatusAddress, &uiInfo.serverStatusInfo)) {
ADDRGP4 uiInfo+5398848
ARGP4
ADDRGP4 uiInfo+5398912
ARGP4
ADDRLP4 0
ADDRGP4 UI_GetServerStatusInfo
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $3254
line 3967
;3967:		uiInfo.nextServerStatusRefresh = 0;
ADDRGP4 uiInfo+5402244
CNSTI4 0
ASGNI4
line 3968
;3968:		UI_GetServerStatusInfo(uiInfo.serverStatusAddress, NULL);
ADDRGP4 uiInfo+5398848
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 UI_GetServerStatusInfo
CALLI4
pop
line 3969
;3969:	} else {
ADDRGP4 $3255
JUMPV
LABELV $3254
line 3970
;3970:		uiInfo.nextServerStatusRefresh = uiInfo.uiDC.realTime + 500;
ADDRGP4 uiInfo+5402244
ADDRGP4 uiInfo+212
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 3971
;3971:	}
LABELV $3255
line 3972
;3972:}
LABELV $3228
endproc UI_BuildServerStatus 4 16
proc UI_FeederCount 8 0
line 3979
;3973:
;3974:/*
;3975:==================
;3976:UI_FeederCount
;3977:==================
;3978:*/
;3979:static int UI_FeederCount(float feederID) {
line 3980
;3980:	if (feederID == FEEDER_HEADS) {
ADDRFP4 0
INDIRF4
CNSTF4 0
NEF4 $3263
line 3981
;3981:		return UI_HeadCountByTeam();
ADDRLP4 0
ADDRGP4 UI_HeadCountByTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $3262
JUMPV
LABELV $3263
line 3982
;3982:	} else if (feederID == FEEDER_Q3HEADS) {
ADDRFP4 0
INDIRF4
CNSTF4 1094713344
NEF4 $3265
line 3983
;3983:		return uiInfo.q3HeadCount;
ADDRGP4 uiInfo+5407588
INDIRI4
RETI4
ADDRGP4 $3262
JUMPV
LABELV $3265
line 3984
;3984:	} else if (feederID == FEEDER_CINEMATICS) {
ADDRFP4 0
INDIRF4
CNSTF4 1097859072
NEF4 $3268
line 3985
;3985:		return uiInfo.movieCount;
ADDRGP4 uiInfo+5387352
INDIRI4
RETI4
ADDRGP4 $3262
JUMPV
LABELV $3268
line 3986
;3986:	} else if (feederID == FEEDER_MAPS || feederID == FEEDER_ALLMAPS) {
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
EQF4 $3273
ADDRLP4 0
INDIRF4
CNSTF4 1082130432
NEF4 $3271
LABELV $3273
line 3987
;3987:		return UI_MapCountByGameType();
ADDRLP4 4
ADDRGP4 UI_MapCountByGameType
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $3262
JUMPV
LABELV $3271
line 3988
;3988:	} else if (feederID == FEEDER_SERVERS) {
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
NEF4 $3274
line 3989
;3989:		return uiInfo.serverStatus.numDisplayServers;
ADDRGP4 uiInfo+5387364+10412
INDIRI4
RETI4
ADDRGP4 $3262
JUMPV
LABELV $3274
line 3990
;3990:	} else if (feederID == FEEDER_SERVERSTATUS) {
ADDRFP4 0
INDIRF4
CNSTF4 1095761920
NEF4 $3278
line 3991
;3991:		return uiInfo.serverStatusInfo.numLines;
ADDRGP4 uiInfo+5398912+3328
INDIRI4
RETI4
ADDRGP4 $3262
JUMPV
LABELV $3278
line 3992
;3992:	} else if (feederID == FEEDER_FINDPLAYER) {
ADDRFP4 0
INDIRF4
CNSTF4 1096810496
NEF4 $3282
line 3993
;3993:		return uiInfo.numFoundPlayerServers;
ADDRGP4 uiInfo+5407568
INDIRI4
RETI4
ADDRGP4 $3262
JUMPV
LABELV $3282
line 3994
;3994:	} else if (feederID == FEEDER_PLAYER_LIST) {
ADDRFP4 0
INDIRF4
CNSTF4 1088421888
NEF4 $3285
line 3995
;3995:		if (uiInfo.uiDC.realTime > uiInfo.playerRefresh) {
ADDRGP4 uiInfo+212
INDIRI4
ADDRGP4 uiInfo+5359788
INDIRI4
LEI4 $3287
line 3996
;3996:			uiInfo.playerRefresh = uiInfo.uiDC.realTime + 3000;
ADDRGP4 uiInfo+5359788
ADDRGP4 uiInfo+212
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 3997
;3997:			UI_BuildPlayerList();
ADDRGP4 UI_BuildPlayerList
CALLV
pop
line 3998
;3998:		}
LABELV $3287
line 3999
;3999:		return uiInfo.playerCount;
ADDRGP4 uiInfo+5359776
INDIRI4
RETI4
ADDRGP4 $3262
JUMPV
LABELV $3285
line 4000
;4000:	} else if (feederID == FEEDER_TEAM_LIST) {
ADDRFP4 0
INDIRF4
CNSTF4 1090519040
NEF4 $3294
line 4001
;4001:		if (uiInfo.uiDC.realTime > uiInfo.playerRefresh) {
ADDRGP4 uiInfo+212
INDIRI4
ADDRGP4 uiInfo+5359788
INDIRI4
LEI4 $3296
line 4002
;4002:			uiInfo.playerRefresh = uiInfo.uiDC.realTime + 3000;
ADDRGP4 uiInfo+5359788
ADDRGP4 uiInfo+212
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 4003
;4003:			UI_BuildPlayerList();
ADDRGP4 UI_BuildPlayerList
CALLV
pop
line 4004
;4004:		}
LABELV $3296
line 4005
;4005:		return uiInfo.myTeamCount;
ADDRGP4 uiInfo+5359780
INDIRI4
RETI4
ADDRGP4 $3262
JUMPV
LABELV $3294
line 4006
;4006:	} else if (feederID == FEEDER_MODS) {
ADDRFP4 0
INDIRF4
CNSTF4 1091567616
NEF4 $3303
line 4007
;4007:		return uiInfo.modCount;
ADDRGP4 uiInfo+5378120
INDIRI4
RETI4
ADDRGP4 $3262
JUMPV
LABELV $3303
line 4008
;4008:	} else if (feederID == FEEDER_DEMOS) {
ADDRFP4 0
INDIRF4
CNSTF4 1092616192
NEF4 $3306
line 4009
;4009:		return uiInfo.demoCount;
ADDRGP4 uiInfo+5386320
INDIRI4
RETI4
ADDRGP4 $3262
JUMPV
LABELV $3306
line 4011
;4010:	}
;4011:	return 0;
CNSTI4 0
RETI4
LABELV $3262
endproc UI_FeederCount 8 0
proc UI_SelectedMap 8 0
line 4014
;4012:}
;4013:
;4014:static const char *UI_SelectedMap(int index, int *actual) {
line 4016
;4015:	int i, c;
;4016:	c = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 4017
;4017:	*actual = 0;
ADDRFP4 4
INDIRP4
CNSTI4 0
ASGNI4
line 4018
;4018:	for (i = 0; i < uiInfo.mapCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3313
JUMPV
LABELV $3310
line 4019
;4019:		if (uiInfo.mapList[i].active) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+96
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3315
line 4020
;4020:			if (c == index) {
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $3319
line 4021
;4021:				*actual = i;
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ASGNI4
line 4022
;4022:				return uiInfo.mapList[i].mapName;
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160
ADDP4
INDIRP4
RETP4
ADDRGP4 $3309
JUMPV
LABELV $3319
line 4023
;4023:			} else {
line 4024
;4024:				c++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4025
;4025:			}
line 4026
;4026:		}
LABELV $3315
line 4027
;4027:	}
LABELV $3311
line 4018
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3313
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5364156
INDIRI4
LTI4 $3310
line 4028
;4028:	return "";
ADDRGP4 $114
RETP4
LABELV $3309
endproc UI_SelectedMap 8 0
proc UI_SelectedHead 8 0
line 4031
;4029:}
;4030:
;4031:static const char *UI_SelectedHead(int index, int *actual) {
line 4033
;4032:	int i, c;
;4033:	c = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 4034
;4034:	*actual = 0;
ADDRFP4 4
INDIRP4
CNSTI4 0
ASGNI4
line 4035
;4035:	for (i = 0; i < uiInfo.characterCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3326
JUMPV
LABELV $3323
line 4036
;4036:		if (uiInfo.characterList[i].active) {
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380+16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3328
line 4037
;4037:			if (c == index) {
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $3332
line 4038
;4038:				*actual = i;
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ASGNI4
line 4039
;4039:				return uiInfo.characterList[i].name;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380
ADDP4
INDIRP4
RETP4
ADDRGP4 $3322
JUMPV
LABELV $3332
line 4040
;4040:			} else {
line 4041
;4041:				c++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4042
;4042:			}
line 4043
;4043:		}
LABELV $3328
line 4044
;4044:	}
LABELV $3324
line 4035
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3326
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5354372
INDIRI4
LTI4 $3323
line 4045
;4045:	return "";
ADDRGP4 $114
RETP4
LABELV $3322
endproc UI_SelectedHead 8 0
proc UI_GetIndexFromSelection 8 0
line 4048
;4046:}
;4047:
;4048:static int UI_GetIndexFromSelection(int actual) {
line 4050
;4049:	int i, c;
;4050:	c = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 4051
;4051:	for (i = 0; i < uiInfo.mapCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3339
JUMPV
LABELV $3336
line 4052
;4052:		if (uiInfo.mapList[i].active) {
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+96
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3341
line 4053
;4053:			if (i == actual) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $3345
line 4054
;4054:				return c;
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $3335
JUMPV
LABELV $3345
line 4056
;4055:			}
;4056:			c++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4057
;4057:		}
LABELV $3341
line 4058
;4058:	}
LABELV $3337
line 4051
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3339
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5364156
INDIRI4
LTI4 $3336
line 4059
;4059:	return 0;
CNSTI4 0
RETI4
LABELV $3335
endproc UI_GetIndexFromSelection 8 0
proc UI_UpdatePendingPings 4 4
line 4062
;4060:}
;4061:
;4062:static void UI_UpdatePendingPings(void) {
line 4063
;4063:	trap_LAN_ResetPings(UI_SourceForLAN());
ADDRLP4 0
ADDRGP4 UI_SourceForLAN
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 trap_LAN_ResetPings
CALLV
pop
line 4064
;4064:	uiInfo.serverStatus.refreshActive = qtrue;
ADDRGP4 uiInfo+5387364+2212
CNSTI4 1
ASGNI4
line 4065
;4065:	uiInfo.serverStatus.refreshtime = uiInfo.uiDC.realTime + 1000;
ADDRGP4 uiInfo+5387364+2192
ADDRGP4 uiInfo+212
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 4067
;4066:
;4067:}
LABELV $3347
endproc UI_UpdatePendingPings 4 4
bss
align 1
LABELV $3354
skip 1024
align 1
LABELV $3355
skip 1024
align 1
LABELV $3356
skip 32
data
align 4
LABELV $3357
byte 4 -1
align 4
LABELV $3358
byte 4 0
code
proc UI_FeederItemText 64 20
line 4069
;4068:
;4069:static const char *UI_FeederItemText(float feederID, int index, int column, qhandle_t *handle) {
line 4075
;4070:	static char info[MAX_STRING_CHARS];
;4071:	static char hostname[1024];
;4072:	static char clientBuff[32];
;4073:	static int lastColumn = -1;
;4074:	static int lastTime = 0;
;4075:	*handle = -1;
ADDRFP4 12
INDIRP4
CNSTI4 -1
ASGNI4
line 4076
;4076:	if (feederID == FEEDER_HEADS) {
ADDRFP4 0
INDIRF4
CNSTF4 0
NEF4 $3359
line 4078
;4077:		int actual;
;4078:		return UI_SelectedHead(index, &actual);
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
ADDRGP4 $3353
JUMPV
LABELV $3359
line 4079
;4079:	} else if (feederID == FEEDER_Q3HEADS) {
ADDRFP4 0
INDIRF4
CNSTF4 1094713344
NEF4 $3361
line 4080
;4080:		if (index >= 0 && index < uiInfo.q3HeadCount) {
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $3362
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5407588
INDIRI4
GEI4 $3362
line 4081
;4081:			return uiInfo.q3HeadNames[index];
ADDRFP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+5407592
ADDP4
RETP4
ADDRGP4 $3353
JUMPV
line 4083
;4082:		}
;4083:	} else if (feederID == FEEDER_MAPS || feederID == FEEDER_ALLMAPS) {
LABELV $3361
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
EQF4 $3369
ADDRLP4 0
INDIRF4
CNSTF4 1082130432
NEF4 $3367
LABELV $3369
line 4085
;4084:		int actual;
;4085:		return UI_SelectedMap(index, &actual);
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
ADDRGP4 $3353
JUMPV
LABELV $3367
line 4086
;4086:	} else if (feederID == FEEDER_SERVERS) {
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
NEF4 $3370
line 4087
;4087:		if (index >= 0 && index < uiInfo.serverStatus.numDisplayServers) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3371
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+5387364+10412
INDIRI4
GEI4 $3371
line 4089
;4088:			int ping, game, punkbuster;
;4089:			if (lastColumn != column || lastTime > uiInfo.uiDC.realTime + 5000) {
ADDRGP4 $3357
INDIRI4
ADDRFP4 8
INDIRI4
NEI4 $3379
ADDRGP4 $3358
INDIRI4
ADDRGP4 uiInfo+212
INDIRI4
CNSTI4 5000
ADDI4
LEI4 $3376
LABELV $3379
line 4090
;4090:				trap_LAN_GetServerInfo(UI_SourceForLAN(), uiInfo.serverStatus.displayServers[index], info, MAX_STRING_CHARS);
ADDRLP4 20
ADDRGP4 UI_SourceForLAN
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5387364+2220
ADDP4
INDIRI4
ARGI4
ADDRGP4 $3354
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerInfo
CALLV
pop
line 4091
;4091:				lastColumn = column;
ADDRGP4 $3357
ADDRFP4 8
INDIRI4
ASGNI4
line 4092
;4092:				lastTime = uiInfo.uiDC.realTime;
ADDRGP4 $3358
ADDRGP4 uiInfo+212
INDIRI4
ASGNI4
line 4093
;4093:			}
LABELV $3376
line 4094
;4094:			ping = atoi(Info_ValueForKey(info, "ping"));
ADDRGP4 $3354
ARGP4
ADDRGP4 $3011
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
line 4095
;4095:			if (ping == -1) {
ADDRLP4 8
INDIRI4
CNSTI4 -1
NEI4 $3383
line 4098
;4096:				// if we ever see a ping that is out of date, do a server refresh
;4097:				// UI_UpdatePendingPings();
;4098:			}
LABELV $3383
line 4099
;4099:			switch (column) {
ADDRLP4 28
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $3371
ADDRLP4 28
INDIRI4
CNSTI4 5
GTI4 $3371
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $3416
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $3416
address $3387
address $3399
address $3400
address $3402
address $3406
address $3410
code
LABELV $3387
line 4101
;4100:			case SORT_HOST:
;4101:				if (ping <= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
GTI4 $3388
line 4102
;4102:					return Info_ValueForKey(info, "addr");
ADDRGP4 $3354
ARGP4
ADDRGP4 $2600
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
RETP4
ADDRGP4 $3353
JUMPV
LABELV $3388
line 4103
;4103:				} else {
line 4104
;4104:					if (ui_netSource.integer == UIAS_LOCAL) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
NEI4 $3390
line 4105
;4105:						int nettype = atoi(Info_ValueForKey(info, "nettype"));
ADDRGP4 $3354
ARGP4
ADDRGP4 $3393
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
ADDRLP4 32
ADDRLP4 40
INDIRI4
ASGNI4
line 4107
;4106:
;4107:						if (nettype < 0 || nettype >= ARRAY_LEN(netnames)) {
ADDRLP4 44
ADDRLP4 32
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
LTI4 $3396
ADDRLP4 44
INDIRI4
CVIU4 4
CNSTU4 4
LTU4 $3394
LABELV $3396
line 4108
;4108:							nettype = 0;
ADDRLP4 32
CNSTI4 0
ASGNI4
line 4109
;4109:						}
LABELV $3394
line 4111
;4110:
;4111:						Com_sprintf(hostname, sizeof(hostname), "%s [%s]",
ADDRGP4 $3354
ARGP4
ADDRGP4 $2599
ARGP4
ADDRLP4 48
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $3355
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $3397
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 32
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
line 4114
;4112:							Info_ValueForKey(info, "hostname"),
;4113:							netnames[nettype]);
;4114:						return hostname;
ADDRGP4 $3355
RETP4
ADDRGP4 $3353
JUMPV
LABELV $3390
line 4115
;4115:					} else {
line 4116
;4116:						Com_sprintf(hostname, sizeof(hostname), "%s", Info_ValueForKey(info, "hostname"));
ADDRGP4 $3354
ARGP4
ADDRGP4 $2599
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $3355
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $3398
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4117
;4117:						return hostname;
ADDRGP4 $3355
RETP4
ADDRGP4 $3353
JUMPV
LABELV $3399
line 4120
;4118:					}
;4119:				}
;4120:			case SORT_MAP: return Info_ValueForKey(info, "mapname");
ADDRGP4 $3354
ARGP4
ADDRGP4 $2964
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
RETP4
ADDRGP4 $3353
JUMPV
LABELV $3400
line 4122
;4121:			case SORT_CLIENTS:
;4122:				Com_sprintf(clientBuff, sizeof(clientBuff), "%s (%s)", Info_ValueForKey(info, "clients"), Info_ValueForKey(info, "sv_maxclients"));
ADDRGP4 $3354
ARGP4
ADDRGP4 $2910
ARGP4
ADDRLP4 36
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $3354
ARGP4
ADDRGP4 $1375
ARGP4
ADDRLP4 40
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $3356
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $3401
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
line 4123
;4123:				return clientBuff;
ADDRGP4 $3356
RETP4
ADDRGP4 $3353
JUMPV
LABELV $3402
line 4125
;4124:			case SORT_GAME:
;4125:				game = atoi(Info_ValueForKey(info, "gametype"));
ADDRGP4 $3354
ARGP4
ADDRGP4 $2930
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
line 4126
;4126:				if (game >= 0 && game < numTeamArenaGameTypes) {
ADDRLP4 52
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
LTI4 $3403
ADDRLP4 52
INDIRI4
ADDRGP4 numTeamArenaGameTypes
INDIRI4
GEI4 $3403
line 4127
;4127:					return teamArenaGameTypes[game];
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 teamArenaGameTypes
ADDP4
INDIRP4
RETP4
ADDRGP4 $3353
JUMPV
LABELV $3403
line 4128
;4128:				} else {
line 4129
;4129:					return "Unknown";
ADDRGP4 $3405
RETP4
ADDRGP4 $3353
JUMPV
LABELV $3406
line 4132
;4130:				}
;4131:			case SORT_PING:
;4132:				if (ping <= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
GTI4 $3407
line 4133
;4133:					return "...";
ADDRGP4 $3409
RETP4
ADDRGP4 $3353
JUMPV
LABELV $3407
line 4134
;4134:				} else {
line 4135
;4135:					return Info_ValueForKey(info, "ping");
ADDRGP4 $3354
ARGP4
ADDRGP4 $3011
ARGP4
ADDRLP4 56
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 56
INDIRP4
RETP4
ADDRGP4 $3353
JUMPV
LABELV $3410
line 4138
;4136:				}
;4137:			case SORT_PUNKBUSTER:
;4138:				punkbuster = atoi(Info_ValueForKey(info, "punkbuster"));
ADDRGP4 $3354
ARGP4
ADDRGP4 $3411
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
line 4139
;4139:				if (punkbuster) {
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $3412
line 4140
;4140:					return "Yes";
ADDRGP4 $3414
RETP4
ADDRGP4 $3353
JUMPV
LABELV $3412
line 4141
;4141:				} else {
line 4142
;4142:					return "No";
ADDRGP4 $3415
RETP4
ADDRGP4 $3353
JUMPV
line 4145
;4143:				}
;4144:			}
;4145:		}
line 4146
;4146:	} else if (feederID == FEEDER_SERVERSTATUS) {
LABELV $3370
ADDRFP4 0
INDIRF4
CNSTF4 1095761920
NEF4 $3417
line 4147
;4147:		if (index >= 0 && index < uiInfo.serverStatusInfo.numLines) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3418
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+5398912+3328
INDIRI4
GEI4 $3418
line 4148
;4148:			if (column >= 0 && column < 4) {
ADDRLP4 8
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $3418
ADDRLP4 8
INDIRI4
CNSTI4 4
GEI4 $3418
line 4149
;4149:				return uiInfo.serverStatusInfo.lines[index][column];
ADDRFP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 uiInfo+5398912+64
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $3353
JUMPV
line 4151
;4150:			}
;4151:		}
line 4152
;4152:	} else if (feederID == FEEDER_FINDPLAYER) {
LABELV $3417
ADDRFP4 0
INDIRF4
CNSTF4 1096810496
NEF4 $3427
line 4153
;4153:		if (index >= 0 && index < uiInfo.numFoundPlayerServers) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3428
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+5407568
INDIRI4
GEI4 $3428
line 4155
;4154:			//return uiInfo.foundPlayerServerAddresses[index];
;4155:			return uiInfo.foundPlayerServerNames[index];
ADDRFP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+5406540
ADDP4
RETP4
ADDRGP4 $3353
JUMPV
line 4157
;4156:		}
;4157:	} else if (feederID == FEEDER_PLAYER_LIST) {
LABELV $3427
ADDRFP4 0
INDIRF4
CNSTF4 1088421888
NEF4 $3433
line 4158
;4158:		if (index >= 0 && index < uiInfo.playerCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3434
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+5359776
INDIRI4
GEI4 $3434
line 4159
;4159:			return uiInfo.playerNames[index];
ADDRFP4 4
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+5359804
ADDP4
RETP4
ADDRGP4 $3353
JUMPV
line 4161
;4160:		}
;4161:	} else if (feederID == FEEDER_TEAM_LIST) {
LABELV $3433
ADDRFP4 0
INDIRF4
CNSTF4 1090519040
NEF4 $3439
line 4162
;4162:		if (index >= 0 && index < uiInfo.myTeamCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3440
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+5359780
INDIRI4
GEI4 $3440
line 4163
;4163:			return uiInfo.teamNames[index];
ADDRFP4 4
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+5361852
ADDP4
RETP4
ADDRGP4 $3353
JUMPV
line 4165
;4164:		}
;4165:	} else if (feederID == FEEDER_MODS) {
LABELV $3439
ADDRFP4 0
INDIRF4
CNSTF4 1091567616
NEF4 $3445
line 4166
;4166:		if (index >= 0 && index < uiInfo.modCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3446
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+5378120
INDIRI4
GEI4 $3446
line 4167
;4167:			if (uiInfo.modList[index].modDescr && *uiInfo.modList[index].modDescr) {
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5377608+4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3450
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5377608+4
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3450
line 4168
;4168:				return uiInfo.modList[index].modDescr;
ADDRFP4 4
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5377608+4
ADDP4
INDIRP4
RETP4
ADDRGP4 $3353
JUMPV
LABELV $3450
line 4169
;4169:			} else {
line 4170
;4170:				return uiInfo.modList[index].modName;
ADDRFP4 4
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5377608
ADDP4
INDIRP4
RETP4
ADDRGP4 $3353
JUMPV
line 4173
;4171:			}
;4172:		}
;4173:	} else if (feederID == FEEDER_CINEMATICS) {
LABELV $3445
ADDRFP4 0
INDIRF4
CNSTF4 1097859072
NEF4 $3459
line 4174
;4174:		if (index >= 0 && index < uiInfo.movieCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3460
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+5387352
INDIRI4
GEI4 $3460
line 4175
;4175:			return uiInfo.movieList[index];
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5386328
ADDP4
INDIRP4
RETP4
ADDRGP4 $3353
JUMPV
line 4177
;4176:		}
;4177:	} else if (feederID == FEEDER_DEMOS) {
LABELV $3459
ADDRFP4 0
INDIRF4
CNSTF4 1092616192
NEF4 $3465
line 4178
;4178:		if (index >= 0 && index < uiInfo.demoCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3467
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+5386320
INDIRI4
GEI4 $3467
line 4179
;4179:			return uiInfo.demoList[index];
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5378128
ADDP4
INDIRP4
RETP4
ADDRGP4 $3353
JUMPV
LABELV $3467
line 4181
;4180:		}
;4181:	}
LABELV $3465
LABELV $3460
LABELV $3446
LABELV $3440
LABELV $3434
LABELV $3428
LABELV $3418
LABELV $3371
LABELV $3362
line 4182
;4182:	return "";
ADDRGP4 $114
RETP4
LABELV $3353
endproc UI_FeederItemText 64 20
proc UI_FeederItemImage 20 8
line 4186
;4183:}
;4184:
;4185:
;4186:static qhandle_t UI_FeederItemImage(float feederID, int index) {
line 4187
;4187:	if (feederID == FEEDER_HEADS) {
ADDRFP4 0
INDIRF4
CNSTF4 0
NEF4 $3472
line 4189
;4188:		int actual;
;4189:		UI_SelectedHead(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 UI_SelectedHead
CALLP4
pop
line 4190
;4190:		index = actual;
ADDRFP4 4
ADDRLP4 0
INDIRI4
ASGNI4
line 4191
;4191:		if (index >= 0 && index < uiInfo.characterCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3473
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+5354372
INDIRI4
GEI4 $3473
line 4192
;4192:			if (uiInfo.characterList[index].headImage == -1) {
ADDRFP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380+8
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $3477
line 4193
;4193:				uiInfo.characterList[index].headImage = trap_R_RegisterShaderNoMip(uiInfo.characterList[index].imageName);
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380+4
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
ADDRGP4 uiInfo+5354380+8
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 4194
;4194:			}
LABELV $3477
line 4195
;4195:			return uiInfo.characterList[index].headImage;
ADDRFP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380+8
ADDP4
INDIRI4
RETI4
ADDRGP4 $3471
JUMPV
line 4197
;4196:		}
;4197:	} else if (feederID == FEEDER_Q3HEADS) {
LABELV $3472
ADDRFP4 0
INDIRF4
CNSTF4 1094713344
NEF4 $3487
line 4198
;4198:		if (index >= 0 && index < uiInfo.q3HeadCount) {
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $3488
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5407588
INDIRI4
GEI4 $3488
line 4199
;4199:			return uiInfo.q3HeadIcons[index];
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5423976
ADDP4
INDIRI4
RETI4
ADDRGP4 $3471
JUMPV
line 4201
;4200:		}
;4201:	} else if (feederID == FEEDER_ALLMAPS || feederID == FEEDER_MAPS) {
LABELV $3487
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 1082130432
EQF4 $3495
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
NEF4 $3493
LABELV $3495
line 4203
;4202:		int actual;
;4203:		UI_SelectedMap(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 UI_SelectedMap
CALLP4
pop
line 4204
;4204:		index = actual;
ADDRFP4 4
ADDRLP4 4
INDIRI4
ASGNI4
line 4205
;4205:		if (index >= 0 && index < uiInfo.mapCount) {
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $3496
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+5364156
INDIRI4
GEI4 $3496
line 4206
;4206:			if (uiInfo.mapList[index].levelShot == -1) {
ADDRFP4 4
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+92
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $3499
line 4207
;4207:				uiInfo.mapList[index].levelShot = trap_R_RegisterShaderNoMip(uiInfo.mapList[index].imageName);
ADDRLP4 12
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+8
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
ADDRGP4 uiInfo+5364160+92
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 4208
;4208:			}
LABELV $3499
line 4209
;4209:			return uiInfo.mapList[index].levelShot;
ADDRFP4 4
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+92
ADDP4
INDIRI4
RETI4
ADDRGP4 $3471
JUMPV
LABELV $3496
line 4211
;4210:		}
;4211:	}
LABELV $3493
LABELV $3488
LABELV $3473
line 4212
;4212:	return 0;
CNSTI4 0
RETI4
LABELV $3471
endproc UI_FeederItemImage 20 8
bss
align 1
LABELV $3510
skip 1024
code
proc UI_FeederSelection 40 24
line 4215
;4213:}
;4214:
;4215:static void UI_FeederSelection(float feederID, int index) {
line 4217
;4216:	static char info[MAX_STRING_CHARS];
;4217:	if (feederID == FEEDER_HEADS) {
ADDRFP4 0
INDIRF4
CNSTF4 0
NEF4 $3511
line 4219
;4218:		int actual;
;4219:		UI_SelectedHead(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 UI_SelectedHead
CALLP4
pop
line 4220
;4220:		index = actual;
ADDRFP4 4
ADDRLP4 0
INDIRI4
ASGNI4
line 4221
;4221:		if (index >= 0 && index < uiInfo.characterCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3512
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+5354372
INDIRI4
GEI4 $3512
line 4222
;4222:			trap_Cvar_Set("team_model", uiInfo.characterList[index].base);
ADDRGP4 $3516
ARGP4
ADDRFP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380+12
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4223
;4223:			trap_Cvar_Set("team_headmodel", va("*%s", uiInfo.characterList[index].name));
ADDRGP4 $3520
ARGP4
ADDRFP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $3519
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4224
;4224:			updateModel = qtrue;
ADDRGP4 updateModel
CNSTI4 1
ASGNI4
line 4225
;4225:		}
line 4226
;4226:	} else if (feederID == FEEDER_Q3HEADS) {
ADDRGP4 $3512
JUMPV
LABELV $3511
ADDRFP4 0
INDIRF4
CNSTF4 1094713344
NEF4 $3522
line 4227
;4227:		if (index >= 0 && index < uiInfo.q3HeadCount) {
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $3523
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5407588
INDIRI4
GEI4 $3523
line 4228
;4228:			trap_Cvar_Set("model", uiInfo.q3HeadNames[index]);
ADDRGP4 $1018
ARGP4
ADDRFP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+5407592
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4229
;4229:			trap_Cvar_Set("headmodel", uiInfo.q3HeadNames[index]);
ADDRGP4 $1019
ARGP4
ADDRFP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+5407592
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4230
;4230:			updateModel = qtrue;
ADDRGP4 updateModel
CNSTI4 1
ASGNI4
line 4231
;4231:		}
line 4232
;4232:	} else if (feederID == FEEDER_MAPS || feederID == FEEDER_ALLMAPS) {
ADDRGP4 $3523
JUMPV
LABELV $3522
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
EQF4 $3531
ADDRLP4 0
INDIRF4
CNSTF4 1082130432
NEF4 $3529
LABELV $3531
line 4234
;4233:		int actual, map;
;4234:		map = (feederID == FEEDER_ALLMAPS) ? ui_currentNetMap.integer : ui_currentMap.integer;
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
NEF4 $3535
ADDRLP4 12
ADDRGP4 ui_currentNetMap+12
INDIRI4
ASGNI4
ADDRGP4 $3536
JUMPV
LABELV $3535
ADDRLP4 12
ADDRGP4 ui_currentMap+12
INDIRI4
ASGNI4
LABELV $3536
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 4235
;4235:		if (uiInfo.mapList[map].cinematic >= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+24
ADDP4
INDIRI4
CNSTI4 0
LTI4 $3537
line 4236
;4236:			trap_CIN_StopCinematic(uiInfo.mapList[map].cinematic);
ADDRLP4 8
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+24
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 4237
;4237:			uiInfo.mapList[map].cinematic = -1;
ADDRLP4 8
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+24
ADDP4
CNSTI4 -1
ASGNI4
line 4238
;4238:		}
LABELV $3537
line 4239
;4239:		UI_SelectedMap(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 UI_SelectedMap
CALLP4
pop
line 4240
;4240:		trap_Cvar_Set("ui_mapIndex", va("%d", index));
ADDRGP4 $727
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2120
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4241
;4241:		ui_mapIndex.integer = index;
ADDRGP4 ui_mapIndex+12
ADDRFP4 4
INDIRI4
ASGNI4
line 4243
;4242:
;4243:		if (feederID == FEEDER_MAPS) {
ADDRFP4 0
INDIRF4
CNSTF4 1065353216
NEF4 $3546
line 4244
;4244:			ui_currentMap.integer = actual;
ADDRGP4 ui_currentMap+12
ADDRLP4 4
INDIRI4
ASGNI4
line 4245
;4245:			trap_Cvar_Set("ui_currentMap", va("%d", actual));
ADDRGP4 $727
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $949
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4246
;4246:			uiInfo.mapList[ui_currentMap.integer].cinematic = trap_CIN_PlayCinematic(va("%s.roq", uiInfo.mapList[ui_currentMap.integer].mapLoadName), 0, 0, 0, 0, (CIN_loop | CIN_silent));
ADDRGP4 $854
ARGP4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+4
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
ADDRGP4 uiInfo+5364160+24
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 4247
;4247:			UI_LoadBestScores(uiInfo.mapList[ui_currentMap.integer].mapLoadName, uiInfo.gameTypes[ui_gameType.integer].gtEnum);
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359512+4
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_LoadBestScores
CALLV
pop
line 4248
;4248:			trap_Cvar_Set("ui_opponentModel", uiInfo.mapList[ui_currentMap.integer].opponentName);
ADDRGP4 $1140
ARGP4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+12
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4249
;4249:			updateOpponentModel = qtrue;
ADDRGP4 updateOpponentModel
CNSTI4 1
ASGNI4
line 4250
;4250:		} else {
ADDRGP4 $3530
JUMPV
LABELV $3546
line 4251
;4251:			ui_currentNetMap.integer = actual;
ADDRGP4 ui_currentNetMap+12
ADDRLP4 4
INDIRI4
ASGNI4
line 4252
;4252:			trap_Cvar_Set("ui_currentNetMap", va("%d", actual));
ADDRGP4 $727
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $947
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4253
;4253:			uiInfo.mapList[ui_currentNetMap.integer].cinematic = trap_CIN_PlayCinematic(va("%s.roq", uiInfo.mapList[ui_currentNetMap.integer].mapLoadName), 0, 0, 0, 0, (CIN_loop | CIN_silent));
ADDRGP4 $854
ARGP4
ADDRGP4 ui_currentNetMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+4
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
ADDRGP4 uiInfo+5364160+24
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 4254
;4254:		}
line 4256
;4255:
;4256:	} else if (feederID == FEEDER_SERVERS) {
ADDRGP4 $3530
JUMPV
LABELV $3529
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
NEF4 $3571
line 4257
;4257:		const char *mapName = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 4258
;4258:		uiInfo.serverStatus.currentServer = index;
ADDRGP4 uiInfo+5387364+2216
ADDRFP4 4
INDIRI4
ASGNI4
line 4259
;4259:		trap_LAN_GetServerInfo(UI_SourceForLAN(), uiInfo.serverStatus.displayServers[index], info, MAX_STRING_CHARS);
ADDRLP4 8
ADDRGP4 UI_SourceForLAN
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5387364+2220
ADDP4
INDIRI4
ARGI4
ADDRGP4 $3510
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerInfo
CALLV
pop
line 4260
;4260:		uiInfo.serverStatus.currentServerPreview = trap_R_RegisterShaderNoMip(va("levelshots/%s", Info_ValueForKey(info, "mapname")));
ADDRGP4 $3510
ARGP4
ADDRGP4 $2964
ARGP4
ADDRLP4 12
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $1087
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+5387364+10428
ADDRLP4 20
INDIRI4
ASGNI4
line 4261
;4261:		if (uiInfo.serverStatus.currentServerCinematic >= 0) {
ADDRGP4 uiInfo+5387364+10432
INDIRI4
CNSTI4 0
LTI4 $3579
line 4262
;4262:			trap_CIN_StopCinematic(uiInfo.serverStatus.currentServerCinematic);
ADDRGP4 uiInfo+5387364+10432
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 4263
;4263:			uiInfo.serverStatus.currentServerCinematic = -1;
ADDRGP4 uiInfo+5387364+10432
CNSTI4 -1
ASGNI4
line 4264
;4264:		}
LABELV $3579
line 4265
;4265:		mapName = Info_ValueForKey(info, "mapname");
ADDRGP4 $3510
ARGP4
ADDRGP4 $2964
ARGP4
ADDRLP4 24
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 4266
;4266:		if (mapName && *mapName) {
ADDRLP4 28
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3572
ADDRLP4 28
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3572
line 4267
;4267:			uiInfo.serverStatus.currentServerCinematic = trap_CIN_PlayCinematic(va("%s.roq", mapName), 0, 0, 0, 0, (CIN_loop | CIN_silent));
ADDRGP4 $854
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 32
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
ADDRLP4 36
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRGP4 uiInfo+5387364+10432
ADDRLP4 36
INDIRI4
ASGNI4
line 4268
;4268:		}
line 4269
;4269:	} else if (feederID == FEEDER_SERVERSTATUS) {
ADDRGP4 $3572
JUMPV
LABELV $3571
ADDRFP4 0
INDIRF4
CNSTF4 1095761920
NEF4 $3591
line 4271
;4270:		//
;4271:	} else if (feederID == FEEDER_FINDPLAYER) {
ADDRGP4 $3592
JUMPV
LABELV $3591
ADDRFP4 0
INDIRF4
CNSTF4 1096810496
NEF4 $3593
line 4272
;4272:		uiInfo.currentFoundPlayerServer = index;
ADDRGP4 uiInfo+5407564
ADDRFP4 4
INDIRI4
ASGNI4
line 4274
;4273:		//
;4274:		if (index < uiInfo.numFoundPlayerServers - 1) {
ADDRFP4 4
INDIRI4
ADDRGP4 uiInfo+5407568
INDIRI4
CNSTI4 1
SUBI4
GEI4 $3594
line 4276
;4275:			// build a new server status for this server
;4276:			Q_strncpyz(uiInfo.serverStatusAddress, uiInfo.foundPlayerServerAddresses[uiInfo.currentFoundPlayerServer], sizeof(uiInfo.serverStatusAddress));
ADDRGP4 uiInfo+5398848
ARGP4
ADDRGP4 uiInfo+5407564
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+5405516
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4277
;4277:			Menu_SetFeederSelection(NULL, FEEDER_SERVERSTATUS, 0, NULL);
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
line 4278
;4278:			UI_BuildServerStatus(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerStatus
CALLV
pop
line 4279
;4279:		}
line 4280
;4280:	} else if (feederID == FEEDER_PLAYER_LIST) {
ADDRGP4 $3594
JUMPV
LABELV $3593
ADDRFP4 0
INDIRF4
CNSTF4 1088421888
NEF4 $3603
line 4281
;4281:		uiInfo.playerIndex = index;
ADDRGP4 uiInfo+5359792
ADDRFP4 4
INDIRI4
ASGNI4
line 4282
;4282:	} else if (feederID == FEEDER_TEAM_LIST) {
ADDRGP4 $3604
JUMPV
LABELV $3603
ADDRFP4 0
INDIRF4
CNSTF4 1090519040
NEF4 $3606
line 4283
;4283:		uiInfo.teamIndex = index;
ADDRGP4 uiInfo+5359784
ADDRFP4 4
INDIRI4
ASGNI4
line 4284
;4284:	} else if (feederID == FEEDER_MODS) {
ADDRGP4 $3607
JUMPV
LABELV $3606
ADDRFP4 0
INDIRF4
CNSTF4 1091567616
NEF4 $3609
line 4285
;4285:		uiInfo.modIndex = index;
ADDRGP4 uiInfo+5378124
ADDRFP4 4
INDIRI4
ASGNI4
line 4286
;4286:	} else if (feederID == FEEDER_CINEMATICS) {
ADDRGP4 $3610
JUMPV
LABELV $3609
ADDRFP4 0
INDIRF4
CNSTF4 1097859072
NEF4 $3612
line 4287
;4287:		uiInfo.movieIndex = index;
ADDRGP4 uiInfo+5387356
ADDRFP4 4
INDIRI4
ASGNI4
line 4288
;4288:		if (uiInfo.previewMovie >= 0) {
ADDRGP4 uiInfo+5387360
INDIRI4
CNSTI4 0
LTI4 $3615
line 4289
;4289:			trap_CIN_StopCinematic(uiInfo.previewMovie);
ADDRGP4 uiInfo+5387360
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 4290
;4290:		}
LABELV $3615
line 4291
;4291:		uiInfo.previewMovie = -1;
ADDRGP4 uiInfo+5387360
CNSTI4 -1
ASGNI4
line 4292
;4292:	} else if (feederID == FEEDER_DEMOS) {
ADDRGP4 $3613
JUMPV
LABELV $3612
ADDRFP4 0
INDIRF4
CNSTF4 1092616192
NEF4 $3620
line 4293
;4293:		uiInfo.demoIndex = index;
ADDRGP4 uiInfo+5386324
ADDRFP4 4
INDIRI4
ASGNI4
line 4294
;4294:	}
LABELV $3620
LABELV $3613
LABELV $3610
LABELV $3607
LABELV $3604
LABELV $3594
LABELV $3592
LABELV $3572
LABELV $3530
LABELV $3523
LABELV $3512
line 4295
;4295:}
LABELV $3509
endproc UI_FeederSelection 40 24
proc Team_Parse 60 12
line 4297
;4296:
;4297:static qboolean Team_Parse(char **p) {
line 4302
;4298:	char *token;
;4299:	const char *tempStr;
;4300:	int i;
;4301:
;4302:	token = COM_ParseExt(p, qtrue);
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
line 4304
;4303:
;4304:	if (token[0] != '{') {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $3627
line 4305
;4305:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3623
JUMPV
LABELV $3626
line 4308
;4306:	}
;4307:
;4308:	while (1) {
line 4310
;4309:
;4310:		token = COM_ParseExt(p, qtrue);
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
line 4312
;4311:
;4312:		if (Q_stricmp(token, "}") == 0) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $456
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $3629
line 4313
;4313:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3623
JUMPV
LABELV $3629
line 4316
;4314:		}
;4315:
;4316:		if (!token[0]) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3631
line 4317
;4317:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3623
JUMPV
LABELV $3631
line 4320
;4318:		}
;4319:
;4320:		if (token[0] == '{') {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $3633
line 4321
;4321:			if (uiInfo.teamCount == MAX_TEAMS) {
ADDRGP4 uiInfo+5356688
INDIRI4
CNSTI4 64
NEI4 $3635
line 4322
;4322:				uiInfo.teamCount--;
ADDRLP4 24
ADDRGP4 uiInfo+5356688
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 4323
;4323:				Com_Printf("Too many teams, last team replaced!\n");
ADDRGP4 $3639
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4324
;4324:			}
LABELV $3635
line 4327
;4325:
;4326:			// seven tokens per line, team name and icon, and 5 team member names
;4327:			if (!String_Parse(p, &uiInfo.teamList[uiInfo.teamCount].teamName) || !String_Parse(p, &tempStr)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+5356688
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $3644
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 28
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $3640
LABELV $3644
line 4328
;4328:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3623
JUMPV
LABELV $3640
line 4332
;4329:			}
;4330:
;4331:
;4332:			uiInfo.teamList[uiInfo.teamCount].imageName = tempStr;
ADDRGP4 uiInfo+5356688
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
ADDP4
ADDRLP4 8
INDIRP4
ASGNP4
line 4333
;4333:			uiInfo.teamList[uiInfo.teamCount].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[uiInfo.teamCount].imageName);
ADDRGP4 uiInfo+5356688
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+5356688
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+28
ADDP4
ADDRLP4 32
INDIRI4
ASGNI4
line 4334
;4334:			uiInfo.teamList[uiInfo.teamCount].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal", uiInfo.teamList[uiInfo.teamCount].imageName));
ADDRGP4 $780
ARGP4
ADDRGP4 uiInfo+5356688
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
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
ADDRGP4 uiInfo+5356688
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+32
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 4335
;4335:			uiInfo.teamList[uiInfo.teamCount].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[uiInfo.teamCount].imageName));
ADDRGP4 $785
ARGP4
ADDRGP4 uiInfo+5356688
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+5356688
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+36
ADDP4
ADDRLP4 48
INDIRI4
ASGNI4
line 4337
;4336:
;4337:			uiInfo.teamList[uiInfo.teamCount].cinematic = -1;
ADDRGP4 uiInfo+5356688
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+40
ADDP4
CNSTI4 -1
ASGNI4
line 4339
;4338:
;4339:			for (i = 0; i < TEAM_MEMBERS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $3669
line 4340
;4340:				uiInfo.teamList[uiInfo.teamCount].teamMembers[i] = NULL;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5356688
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+8
ADDP4
ADDP4
CNSTP4 0
ASGNP4
line 4341
;4341:				if (!String_Parse(p, &uiInfo.teamList[uiInfo.teamCount].teamMembers[i])) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+5356688
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692+8
ADDP4
ADDP4
ARGP4
ADDRLP4 52
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $3676
line 4342
;4342:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3623
JUMPV
LABELV $3676
line 4344
;4343:				}
;4344:			}
LABELV $3670
line 4339
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 5
LTI4 $3669
line 4346
;4345:
;4346:			Com_Printf("Loaded team %s with team icon %s.\n", uiInfo.teamList[uiInfo.teamCount].teamName, tempStr);
ADDRGP4 $3681
ARGP4
ADDRGP4 uiInfo+5356688
INDIRI4
CNSTI4 44
MULI4
ADDRGP4 uiInfo+5356692
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4347
;4347:			uiInfo.teamCount++;
ADDRLP4 52
ADDRGP4 uiInfo+5356688
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4349
;4348:
;4349:			token = COM_ParseExt(p, qtrue);
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
line 4350
;4350:			if (token[0] != '}') {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
EQI4 $3685
line 4351
;4351:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3623
JUMPV
LABELV $3685
line 4353
;4352:			}
;4353:		}
LABELV $3633
line 4354
;4354:	}
LABELV $3627
line 4308
ADDRGP4 $3626
JUMPV
line 4356
;4355:
;4356:	return qfalse;
CNSTI4 0
RETI4
LABELV $3623
endproc Team_Parse 60 12
proc Character_Parse 60 12
line 4359
;4357:}
;4358:
;4359:static qboolean Character_Parse(char **p) {
line 4363
;4360:	char *token;
;4361:	const char *tempStr;
;4362:
;4363:	token = COM_ParseExt(p, qtrue);
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
line 4365
;4364:
;4365:	if (token[0] != '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $3691
line 4366
;4366:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3687
JUMPV
LABELV $3690
line 4370
;4367:	}
;4368:
;4369:
;4370:	while (1) {
line 4371
;4371:		token = COM_ParseExt(p, qtrue);
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
line 4373
;4372:
;4373:		if (Q_stricmp(token, "}") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $456
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $3693
line 4374
;4374:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3687
JUMPV
LABELV $3693
line 4377
;4375:		}
;4376:
;4377:		if (!token[0]) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3695
line 4378
;4378:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3687
JUMPV
LABELV $3695
line 4381
;4379:		}
;4380:
;4381:		if (token[0] == '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $3697
line 4382
;4382:			if (uiInfo.characterCount == MAX_HEADS) {
ADDRGP4 uiInfo+5354372
INDIRI4
CNSTI4 64
NEI4 $3699
line 4383
;4383:				uiInfo.characterCount--;
ADDRLP4 20
ADDRGP4 uiInfo+5354372
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 4384
;4384:				Com_Printf("Too many characters, last character replaced!\n");
ADDRGP4 $3703
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4385
;4385:			}
LABELV $3699
line 4388
;4386:
;4387:			// two tokens per line, character name and sex
;4388:			if (!String_Parse(p, &uiInfo.characterList[uiInfo.characterCount].name) || !String_Parse(p, &tempStr)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+5354372
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $3708
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 24
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $3704
LABELV $3708
line 4389
;4389:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3687
JUMPV
LABELV $3704
line 4392
;4390:			}
;4391:
;4392:			uiInfo.characterList[uiInfo.characterCount].headImage = -1;
ADDRGP4 uiInfo+5354372
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380+8
ADDP4
CNSTI4 -1
ASGNI4
line 4393
;4393:			uiInfo.characterList[uiInfo.characterCount].imageName = String_Alloc(va("models/players/heads/%s/icon_default.tga", uiInfo.characterList[uiInfo.characterCount].name));
ADDRGP4 $3715
ARGP4
ADDRGP4 uiInfo+5354372
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380
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
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+5354372
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380+4
ADDP4
ADDRLP4 32
INDIRP4
ASGNP4
line 4395
;4394:
;4395:			if (tempStr && (!Q_stricmp(tempStr, "female"))) {
ADDRLP4 36
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3718
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 $3720
ARGP4
ADDRLP4 40
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $3718
line 4396
;4396:				uiInfo.characterList[uiInfo.characterCount].base = String_Alloc("crash");
ADDRGP4 $3724
ARGP4
ADDRLP4 44
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+5354372
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380+12
ADDP4
ADDRLP4 44
INDIRP4
ASGNP4
line 4397
;4397:			} else if (tempStr && (!Q_stricmp(tempStr, "male"))) {
ADDRGP4 $3719
JUMPV
LABELV $3718
ADDRLP4 44
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3725
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 $3727
ARGP4
ADDRLP4 48
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $3725
line 4398
;4398:				uiInfo.characterList[uiInfo.characterCount].base = String_Alloc("sarge");
ADDRGP4 $3731
ARGP4
ADDRLP4 52
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+5354372
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380+12
ADDP4
ADDRLP4 52
INDIRP4
ASGNP4
line 4399
;4399:			} else {
ADDRGP4 $3726
JUMPV
LABELV $3725
line 4400
;4400:				uiInfo.characterList[uiInfo.characterCount].base = String_Alloc(tempStr);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+5354372
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380+12
ADDP4
ADDRLP4 52
INDIRP4
ASGNP4
line 4401
;4401:			}
LABELV $3726
LABELV $3719
line 4403
;4402:
;4403:			Com_Printf("Loaded %s character %s.\n", uiInfo.characterList[uiInfo.characterCount].base, uiInfo.characterList[uiInfo.characterCount].name);
ADDRGP4 $3735
ARGP4
ADDRGP4 uiInfo+5354372
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380+12
ADDP4
INDIRP4
ARGP4
ADDRGP4 uiInfo+5354372
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 uiInfo+5354380
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4404
;4404:			uiInfo.characterCount++;
ADDRLP4 52
ADDRGP4 uiInfo+5354372
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4406
;4405:
;4406:			token = COM_ParseExt(p, qtrue);
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
line 4407
;4407:			if (token[0] != '}') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
EQI4 $3742
line 4408
;4408:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3687
JUMPV
LABELV $3742
line 4410
;4409:			}
;4410:		}
LABELV $3697
line 4411
;4411:	}
LABELV $3691
line 4370
ADDRGP4 $3690
JUMPV
line 4413
;4412:
;4413:	return qfalse;
CNSTI4 0
RETI4
LABELV $3687
endproc Character_Parse 60 12
proc Alias_Parse 36 12
line 4417
;4414:}
;4415:
;4416:
;4417:static qboolean Alias_Parse(char **p) {
line 4420
;4418:	char *token;
;4419:
;4420:	token = COM_ParseExt(p, qtrue);
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
line 4422
;4421:
;4422:	if (token[0] != '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $3748
line 4423
;4423:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3744
JUMPV
LABELV $3747
line 4426
;4424:	}
;4425:
;4426:	while (1) {
line 4427
;4427:		token = COM_ParseExt(p, qtrue);
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
line 4429
;4428:
;4429:		if (Q_stricmp(token, "}") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $456
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $3750
line 4430
;4430:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3744
JUMPV
LABELV $3750
line 4433
;4431:		}
;4432:
;4433:		if (!token[0]) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3752
line 4434
;4434:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3744
JUMPV
LABELV $3752
line 4437
;4435:		}
;4436:
;4437:		if (token[0] == '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $3754
line 4438
;4438:			if (uiInfo.aliasCount == MAX_ALIASES) {
ADDRGP4 uiInfo+5355916
INDIRI4
CNSTI4 64
NEI4 $3756
line 4439
;4439:				uiInfo.aliasCount--;
ADDRLP4 16
ADDRGP4 uiInfo+5355916
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 4440
;4440:				Com_Printf("Too many aliases, last alias replaced!\n");
ADDRGP4 $3760
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4441
;4441:			}
LABELV $3756
line 4444
;4442:
;4443:			// three tokens per line, character name, bot alias, and preferred action a - all purpose, d - defense, o - offense
;4444:			if (!String_Parse(p, &uiInfo.aliasList[uiInfo.aliasCount].name) || !String_Parse(p, &uiInfo.aliasList[uiInfo.aliasCount].ai) || !String_Parse(p, &uiInfo.aliasList[uiInfo.aliasCount].action)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+5355916
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+5355920
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $3772
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+5355916
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+5355920+4
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $3772
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+5355916
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+5355920+8
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $3761
LABELV $3772
line 4445
;4445:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3744
JUMPV
LABELV $3761
line 4448
;4446:			}
;4447:
;4448:			Com_Printf("Loaded character alias %s using character ai %s.\n", uiInfo.aliasList[uiInfo.aliasCount].name, uiInfo.aliasList[uiInfo.aliasCount].ai);
ADDRGP4 $3773
ARGP4
ADDRGP4 uiInfo+5355916
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+5355920
ADDP4
INDIRP4
ARGP4
ADDRGP4 uiInfo+5355916
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 uiInfo+5355920+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4449
;4449:			uiInfo.aliasCount++;
ADDRLP4 28
ADDRGP4 uiInfo+5355916
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4451
;4450:
;4451:			token = COM_ParseExt(p, qtrue);
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
line 4452
;4452:			if (token[0] != '}') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
EQI4 $3780
line 4453
;4453:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3744
JUMPV
LABELV $3780
line 4455
;4454:			}
;4455:		}
LABELV $3754
line 4456
;4456:	}
LABELV $3748
line 4426
ADDRGP4 $3747
JUMPV
line 4458
;4457:
;4458:	return qfalse;
CNSTI4 0
RETI4
LABELV $3744
endproc Alias_Parse 36 12
proc UI_ParseTeamInfo 40 8
line 4467
;4459:}
;4460:
;4461:
;4462:
;4463:// mode 
;4464:// 0 - high level parsing
;4465:// 1 - team parsing
;4466:// 2 - character parsing
;4467:static void UI_ParseTeamInfo(const char *teamFile) {
line 4470
;4468:	char *token;
;4469:	char *p;
;4470:	char *buff = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 4473
;4471:	//static int mode = 0; TTimo: unused
;4472:
;4473:	buff = GetMenuBuffer(teamFile);
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
line 4474
;4474:	if (!buff) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3783
line 4475
;4475:		return;
ADDRGP4 $3782
JUMPV
LABELV $3783
line 4478
;4476:	}
;4477:
;4478:	p = buff;
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $3786
JUMPV
LABELV $3785
line 4480
;4479:
;4480:	while (1) {
line 4481
;4481:		token = COM_ParseExt(&p, qtrue);
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
line 4482
;4482:		if (!token[0] || token[0] == '}') {
ADDRLP4 20
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $3790
ADDRLP4 20
INDIRI4
CNSTI4 125
NEI4 $3788
LABELV $3790
line 4483
;4483:			break;
ADDRGP4 $3787
JUMPV
LABELV $3788
line 4486
;4484:		}
;4485:
;4486:		if (Q_stricmp(token, "}") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $456
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $3791
line 4487
;4487:			break;
ADDRGP4 $3787
JUMPV
LABELV $3791
line 4490
;4488:		}
;4489:
;4490:		if (Q_stricmp(token, "teams") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $3795
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $3793
line 4492
;4491:
;4492:			if (Team_Parse(&p)) {
ADDRLP4 4
ARGP4
ADDRLP4 32
ADDRGP4 Team_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $3787
line 4493
;4493:				continue;
ADDRGP4 $3786
JUMPV
line 4494
;4494:			} else {
line 4495
;4495:				break;
LABELV $3793
line 4499
;4496:			}
;4497:		}
;4498:
;4499:		if (Q_stricmp(token, "characters") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $3800
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $3798
line 4500
;4500:			Character_Parse(&p);
ADDRLP4 4
ARGP4
ADDRGP4 Character_Parse
CALLI4
pop
line 4501
;4501:		}
LABELV $3798
line 4503
;4502:
;4503:		if (Q_stricmp(token, "aliases") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $3803
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $3801
line 4504
;4504:			Alias_Parse(&p);
ADDRLP4 4
ARGP4
ADDRGP4 Alias_Parse
CALLI4
pop
line 4505
;4505:		}
LABELV $3801
line 4507
;4506:
;4507:	}
LABELV $3786
line 4480
ADDRGP4 $3785
JUMPV
LABELV $3787
line 4509
;4508:
;4509:}
LABELV $3782
endproc UI_ParseTeamInfo 40 8
proc GameType_Parse 24 8
line 4512
;4510:
;4511:
;4512:static qboolean GameType_Parse(char **p, qboolean join) {
line 4515
;4513:	char *token;
;4514:
;4515:	token = COM_ParseExt(p, qtrue);
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
line 4517
;4516:
;4517:	if (token[0] != '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $3805
line 4518
;4518:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3804
JUMPV
LABELV $3805
line 4521
;4519:	}
;4520:
;4521:	if (join) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $3807
line 4522
;4522:		uiInfo.numJoinGameTypes = 0;
ADDRGP4 uiInfo+5359640
CNSTI4 0
ASGNI4
line 4523
;4523:	} else {
ADDRGP4 $3812
JUMPV
LABELV $3807
line 4524
;4524:		uiInfo.numGameTypes = 0;
ADDRGP4 uiInfo+5359508
CNSTI4 0
ASGNI4
line 4525
;4525:	}
ADDRGP4 $3812
JUMPV
LABELV $3811
line 4527
;4526:
;4527:	while (1) {
line 4528
;4528:		token = COM_ParseExt(p, qtrue);
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
line 4530
;4529:
;4530:		if (Q_stricmp(token, "}") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $456
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $3814
line 4531
;4531:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3804
JUMPV
LABELV $3814
line 4534
;4532:		}
;4533:
;4534:		if (!token[0]) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3816
line 4535
;4535:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3804
JUMPV
LABELV $3816
line 4538
;4536:		}
;4537:
;4538:		if (token[0] == '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $3818
line 4540
;4539:			// two tokens per line, gametype name and number
;4540:			if (join) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $3820
line 4541
;4541:				if (!String_Parse(p, &uiInfo.joinGameTypes[uiInfo.numJoinGameTypes].gameType) || !Int_Parse(p, &uiInfo.joinGameTypes[uiInfo.numJoinGameTypes].gtEnum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+5359640
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359644
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $3829
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+5359640
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359644+4
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $3821
LABELV $3829
line 4542
;4542:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3804
JUMPV
line 4544
;4543:				}
;4544:			} else {
LABELV $3820
line 4545
;4545:				if (!String_Parse(p, &uiInfo.gameTypes[uiInfo.numGameTypes].gameType) || !Int_Parse(p, &uiInfo.gameTypes[uiInfo.numGameTypes].gtEnum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+5359508
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359512
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $3837
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+5359508
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359512+4
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $3830
LABELV $3837
line 4546
;4546:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3804
JUMPV
LABELV $3830
line 4548
;4547:				}
;4548:			}
LABELV $3821
line 4550
;4549:
;4550:			if (join) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $3838
line 4551
;4551:				if (uiInfo.numJoinGameTypes < MAX_GAMETYPES) {
ADDRGP4 uiInfo+5359640
INDIRI4
CNSTI4 16
GEI4 $3840
line 4552
;4552:					uiInfo.numJoinGameTypes++;
ADDRLP4 16
ADDRGP4 uiInfo+5359640
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4553
;4553:				} else {
ADDRGP4 $3839
JUMPV
LABELV $3840
line 4554
;4554:					Com_Printf("Too many net game types, last one replace!\n");
ADDRGP4 $3844
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4555
;4555:				}
line 4556
;4556:			} else {
ADDRGP4 $3839
JUMPV
LABELV $3838
line 4557
;4557:				if (uiInfo.numGameTypes < MAX_GAMETYPES) {
ADDRGP4 uiInfo+5359508
INDIRI4
CNSTI4 16
GEI4 $3845
line 4558
;4558:					uiInfo.numGameTypes++;
ADDRLP4 16
ADDRGP4 uiInfo+5359508
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4559
;4559:				} else {
ADDRGP4 $3846
JUMPV
LABELV $3845
line 4560
;4560:					Com_Printf("Too many game types, last one replace!\n");
ADDRGP4 $3849
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4561
;4561:				}
LABELV $3846
line 4562
;4562:			}
LABELV $3839
line 4564
;4563:
;4564:			token = COM_ParseExt(p, qtrue);
ADDRFP4 0
INDIRP4
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
line 4565
;4565:			if (token[0] != '}') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
EQI4 $3850
line 4566
;4566:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3804
JUMPV
LABELV $3850
line 4568
;4567:			}
;4568:		}
LABELV $3818
line 4569
;4569:	}
LABELV $3812
line 4527
ADDRGP4 $3811
JUMPV
line 4570
;4570:	return qfalse;
CNSTI4 0
RETI4
LABELV $3804
endproc GameType_Parse 24 8
proc MapList_Parse 48 8
line 4573
;4571:}
;4572:
;4573:static qboolean MapList_Parse(char **p) {
line 4576
;4574:	char *token;
;4575:
;4576:	token = COM_ParseExt(p, qtrue);
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
line 4578
;4577:
;4578:	if (token[0] != '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $3853
line 4579
;4579:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3852
JUMPV
LABELV $3853
line 4582
;4580:	}
;4581:
;4582:	uiInfo.mapCount = 0;
ADDRGP4 uiInfo+5364156
CNSTI4 0
ASGNI4
ADDRGP4 $3857
JUMPV
LABELV $3856
line 4584
;4583:
;4584:	while (1) {
line 4585
;4585:		token = COM_ParseExt(p, qtrue);
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
line 4587
;4586:
;4587:		if (Q_stricmp(token, "}") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $456
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $3859
line 4588
;4588:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3852
JUMPV
LABELV $3859
line 4591
;4589:		}
;4590:
;4591:		if (!token[0]) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3861
line 4592
;4592:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3852
JUMPV
LABELV $3861
line 4595
;4593:		}
;4594:
;4595:		if (token[0] == '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $3863
line 4596
;4596:			if (!String_Parse(p, &uiInfo.mapList[uiInfo.mapCount].mapName) || !String_Parse(p, &uiInfo.mapList[uiInfo.mapCount].mapLoadName)
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+5364156
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $3876
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+5364156
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+4
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $3876
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+5364156
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+16
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $3865
LABELV $3876
line 4597
;4597:				|| !Int_Parse(p, &uiInfo.mapList[uiInfo.mapCount].teamMembers)) {
line 4598
;4598:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3852
JUMPV
LABELV $3865
line 4601
;4599:			}
;4600:
;4601:			if (!String_Parse(p, &uiInfo.mapList[uiInfo.mapCount].opponentName)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+5364156
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+12
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $3877
line 4602
;4602:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3852
JUMPV
LABELV $3877
line 4605
;4603:			}
;4604:
;4605:			uiInfo.mapList[uiInfo.mapCount].typeBits = 0;
ADDRGP4 uiInfo+5364156
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+20
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $3886
JUMPV
LABELV $3885
line 4607
;4606:
;4607:			while (1) {
line 4608
;4608:				token = COM_ParseExt(p, qtrue);
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
line 4609
;4609:				if (token[0] >= '0' && token[0] <= '9') {
ADDRLP4 36
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 48
LTI4 $3887
ADDRLP4 36
INDIRI4
CNSTI4 57
GTI4 $3887
line 4610
;4610:					uiInfo.mapList[uiInfo.mapCount].typeBits |= (1 << (token[0] - 0x030));
ADDRLP4 40
ADDRGP4 uiInfo+5364156
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+20
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
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
line 4611
;4611:					if (!Int_Parse(p, &uiInfo.mapList[uiInfo.mapCount].timeToBeat[token[0] - 0x30])) {
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
ADDRGP4 uiInfo+5364156
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+28
ADDP4
ADDP4
ARGP4
ADDRLP4 44
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $3889
line 4612
;4612:						return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3852
JUMPV
line 4614
;4613:					}
;4614:				} else {
line 4615
;4615:					break;
LABELV $3889
line 4617
;4616:				}
;4617:			}
LABELV $3886
line 4607
ADDRGP4 $3885
JUMPV
LABELV $3887
line 4624
;4618:
;4619:			//mapList[mapCount].imageName = String_Alloc(va("levelshots/%s", mapList[mapCount].mapLoadName));
;4620:			//if (uiInfo.mapCount == 0) {
;4621:			  // only load the first cinematic, selection loads the others
;4622:			//  uiInfo.mapList[uiInfo.mapCount].cinematic = trap_CIN_PlayCinematic(va("%s.roq",uiInfo.mapList[uiInfo.mapCount].mapLoadName), qfalse, qfalse, qtrue, 0, 0, 0, 0);
;4623:			//}
;4624:			uiInfo.mapList[uiInfo.mapCount].cinematic = -1;
ADDRGP4 uiInfo+5364156
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+24
ADDP4
CNSTI4 -1
ASGNI4
line 4625
;4625:			uiInfo.mapList[uiInfo.mapCount].levelShot = trap_R_RegisterShaderNoMip(va("levelshots/%s_small", uiInfo.mapList[uiInfo.mapCount].mapLoadName));
ADDRGP4 $3904
ARGP4
ADDRGP4 uiInfo+5364156
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+4
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
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+5364156
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+92
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 4627
;4626:
;4627:			if (uiInfo.mapCount < MAX_MAPS) {
ADDRGP4 uiInfo+5364156
INDIRI4
CNSTI4 128
GEI4 $3908
line 4628
;4628:				uiInfo.mapCount++;
ADDRLP4 40
ADDRGP4 uiInfo+5364156
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4629
;4629:			} else {
ADDRGP4 $3909
JUMPV
LABELV $3908
line 4630
;4630:				Com_Printf("Too many maps, last one replaced!\n");
ADDRGP4 $3912
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4631
;4631:			}
LABELV $3909
line 4632
;4632:		}
LABELV $3863
line 4633
;4633:	}
LABELV $3857
line 4584
ADDRGP4 $3856
JUMPV
line 4634
;4634:	return qfalse;
CNSTI4 0
RETI4
LABELV $3852
endproc MapList_Parse 48 8
proc UI_ParseGameInfo 40 8
line 4637
;4635:}
;4636:
;4637:static void UI_ParseGameInfo(const char *teamFile) {
line 4640
;4638:	char *token;
;4639:	char *p;
;4640:	char *buff = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 4643
;4641:	//int mode = 0; TTimo: unused
;4642:
;4643:	buff = GetMenuBuffer(teamFile);
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
line 4644
;4644:	if (!buff) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3914
line 4645
;4645:		return;
ADDRGP4 $3913
JUMPV
LABELV $3914
line 4648
;4646:	}
;4647:
;4648:	p = buff;
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $3917
JUMPV
LABELV $3916
line 4650
;4649:
;4650:	while (1) {
line 4651
;4651:		token = COM_ParseExt(&p, qtrue);
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
line 4652
;4652:		if (!token[0] || token[0] == '}') {
ADDRLP4 20
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $3921
ADDRLP4 20
INDIRI4
CNSTI4 125
NEI4 $3919
LABELV $3921
line 4653
;4653:			break;
ADDRGP4 $3918
JUMPV
LABELV $3919
line 4656
;4654:		}
;4655:
;4656:		if (Q_stricmp(token, "}") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $456
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $3922
line 4657
;4657:			break;
ADDRGP4 $3918
JUMPV
LABELV $3922
line 4660
;4658:		}
;4659:
;4660:		if (Q_stricmp(token, "gametypes") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $3926
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $3924
line 4662
;4661:
;4662:			if (GameType_Parse(&p, qfalse)) {
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 32
ADDRGP4 GameType_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $3918
line 4663
;4663:				continue;
ADDRGP4 $3917
JUMPV
line 4664
;4664:			} else {
line 4665
;4665:				break;
LABELV $3924
line 4669
;4666:			}
;4667:		}
;4668:
;4669:		if (Q_stricmp(token, "joingametypes") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $3931
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $3929
line 4671
;4670:
;4671:			if (GameType_Parse(&p, qtrue)) {
ADDRLP4 4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 36
ADDRGP4 GameType_Parse
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $3918
line 4672
;4672:				continue;
ADDRGP4 $3917
JUMPV
line 4673
;4673:			} else {
line 4674
;4674:				break;
LABELV $3929
line 4678
;4675:			}
;4676:		}
;4677:
;4678:		if (Q_stricmp(token, "maps") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $3936
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $3934
line 4680
;4679:			// start a new menu
;4680:			MapList_Parse(&p);
ADDRLP4 4
ARGP4
ADDRGP4 MapList_Parse
CALLI4
pop
line 4681
;4681:		}
LABELV $3934
line 4683
;4682:
;4683:	}
LABELV $3917
line 4650
ADDRGP4 $3916
JUMPV
LABELV $3918
line 4684
;4684:}
LABELV $3913
endproc UI_ParseGameInfo 40 8
proc UI_Pause 4 8
line 4686
;4685:
;4686:static void UI_Pause(qboolean b) {
line 4687
;4687:	if (b) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $3938
line 4689
;4688:		// pause the game and set the ui keycatcher
;4689:		trap_Cvar_Set("cl_paused", "1");
ADDRGP4 $2493
ARGP4
ADDRGP4 $396
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4690
;4690:		trap_Key_SetCatcher(KEYCATCH_UI);
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 4691
;4691:	} else {
ADDRGP4 $3939
JUMPV
LABELV $3938
line 4693
;4692:		// unpause the game and clear the ui keycatcher
;4693:		trap_Key_SetCatcher(trap_Key_GetCatcher() & ~KEYCATCH_UI);
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
line 4694
;4694:		trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 4695
;4695:		trap_Cvar_Set("cl_paused", "0");
ADDRGP4 $2493
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4696
;4696:	}
LABELV $3939
line 4697
;4697:}
LABELV $3937
endproc UI_Pause 4 8
proc UI_BuildQ3Model_List 4520 20
line 4704
;4698:
;4699:/*
;4700:=================
;4701:PlayerModel_BuildList
;4702:=================
;4703:*/
;4704:static void UI_BuildQ3Model_List(void) {
line 4718
;4705:	int		numdirs;
;4706:	int		numfiles;
;4707:	char	dirlist[2048];
;4708:	char	filelist[2048];
;4709:	char	skinname[MAX_QPATH];
;4710:	char	scratch[256];
;4711:	char *dirptr;
;4712:	char *fileptr;
;4713:	int		i;
;4714:	int		j, k, dirty;
;4715:	int		dirlen;
;4716:	int		filelen;
;4717:
;4718:	uiInfo.q3HeadCount = 0;
ADDRGP4 uiInfo+5407588
CNSTI4 0
ASGNI4
line 4721
;4719:
;4720:	// iterate directory of all player models
;4721:	numdirs = trap_FS_GetFileList("models/players", "/", dirlist, 2048);
ADDRGP4 $3942
ARGP4
ADDRGP4 $3943
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
line 4722
;4722:	dirptr = dirlist;
ADDRLP4 340
ADDRLP4 2408
ASGNP4
line 4723
;4723:	for (i = 0; i < numdirs && uiInfo.q3HeadCount < MAX_PLAYERMODELS; i++, dirptr += dirlen + 1) {
ADDRLP4 352
CNSTI4 0
ASGNI4
ADDRGP4 $3947
JUMPV
LABELV $3944
line 4724
;4724:		dirlen = strlen(dirptr);
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
line 4726
;4725:
;4726:		if (dirlen && dirptr[dirlen - 1] == '/') dirptr[dirlen - 1] = '\0';
ADDRLP4 348
INDIRI4
CNSTI4 0
EQI4 $3949
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
NEI4 $3949
ADDRLP4 348
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 340
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
LABELV $3949
line 4728
;4727:
;4728:		if (!strcmp(dirptr, ".") || !strcmp(dirptr, ".."))
ADDRLP4 340
INDIRP4
ARGP4
ADDRGP4 $3953
ARGP4
ADDRLP4 4468
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 4468
INDIRI4
CNSTI4 0
EQI4 $3955
ADDRLP4 340
INDIRP4
ARGP4
ADDRGP4 $3954
ARGP4
ADDRLP4 4472
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 4472
INDIRI4
CNSTI4 0
NEI4 $3951
LABELV $3955
line 4729
;4729:			continue;
ADDRGP4 $3945
JUMPV
LABELV $3951
line 4732
;4730:
;4731:		// iterate all skin files in directory
;4732:		numfiles = trap_FS_GetFileList(va("models/players/%s", dirptr), "tga", filelist, 2048);
ADDRGP4 $3956
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
ADDRGP4 $3957
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
line 4733
;4733:		fileptr = filelist;
ADDRLP4 328
ADDRLP4 356
ASGNP4
line 4734
;4734:		for (j = 0; j < numfiles && uiInfo.q3HeadCount < MAX_PLAYERMODELS; j++, fileptr += filelen + 1) {
ADDRLP4 332
CNSTI4 0
ASGNI4
ADDRGP4 $3961
JUMPV
LABELV $3958
line 4735
;4735:			filelen = strlen(fileptr);
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
line 4737
;4736:
;4737:			COM_StripExtension(fileptr, skinname, sizeof(skinname));
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
line 4740
;4738:
;4739:			// look for icon_????
;4740:			if (Q_stricmpn(skinname, "icon_", 5) == 0 && !(Q_stricmp(skinname, "icon_blue") == 0 || Q_stricmp(skinname, "icon_red") == 0)) {
ADDRLP4 260
ARGP4
ADDRGP4 $3965
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
NEI4 $3963
ADDRLP4 260
ARGP4
ADDRGP4 $3966
ARGP4
ADDRLP4 4492
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4492
INDIRI4
CNSTI4 0
EQI4 $3963
ADDRLP4 260
ARGP4
ADDRGP4 $3967
ARGP4
ADDRLP4 4496
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4496
INDIRI4
CNSTI4 0
EQI4 $3963
line 4741
;4741:				if (Q_stricmp(skinname, "icon_default") == 0) {
ADDRLP4 260
ARGP4
ADDRGP4 $3970
ARGP4
ADDRLP4 4500
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4500
INDIRI4
CNSTI4 0
NEI4 $3968
line 4742
;4742:					Com_sprintf(scratch, sizeof(scratch), "%s", dirptr);
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $3398
ARGP4
ADDRLP4 340
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4743
;4743:				} else {
ADDRGP4 $3969
JUMPV
LABELV $3968
line 4744
;4744:					Com_sprintf(scratch, sizeof(scratch), "%s/%s", dirptr, skinname + 5);
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $3971
ARGP4
ADDRLP4 340
INDIRP4
ARGP4
ADDRLP4 260+5
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4745
;4745:				}
LABELV $3969
line 4746
;4746:				dirty = 0;
ADDRLP4 324
CNSTI4 0
ASGNI4
line 4747
;4747:				for (k = 0; k < uiInfo.q3HeadCount; k++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3976
JUMPV
LABELV $3973
line 4748
;4748:					if (!Q_stricmp(scratch, uiInfo.q3HeadNames[uiInfo.q3HeadCount])) {
ADDRLP4 4
ARGP4
ADDRGP4 uiInfo+5407588
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+5407592
ADDP4
ARGP4
ADDRLP4 4504
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4504
INDIRI4
CNSTI4 0
NEI4 $3978
line 4749
;4749:						dirty = 1;
ADDRLP4 324
CNSTI4 1
ASGNI4
line 4750
;4750:						break;
ADDRGP4 $3975
JUMPV
LABELV $3978
line 4752
;4751:					}
;4752:				}
LABELV $3974
line 4747
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3976
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5407588
INDIRI4
LTI4 $3973
LABELV $3975
line 4753
;4753:				if (!dirty) {
ADDRLP4 324
INDIRI4
CNSTI4 0
NEI4 $3982
line 4754
;4754:					Com_sprintf(uiInfo.q3HeadNames[uiInfo.q3HeadCount], sizeof(uiInfo.q3HeadNames[uiInfo.q3HeadCount]), "%s", scratch);
ADDRGP4 uiInfo+5407588
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+5407592
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $3398
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4755
;4755:					uiInfo.q3HeadIcons[uiInfo.q3HeadCount++] = trap_R_RegisterShaderNoMip(va("models/players/%s/%s", dirptr, skinname));
ADDRLP4 4508
ADDRGP4 uiInfo+5407588
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
ADDRGP4 $3990
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
ADDRGP4 uiInfo+5423976
ADDP4
ADDRLP4 4516
INDIRI4
ASGNI4
line 4756
;4756:				}
LABELV $3982
line 4757
;4757:			}
LABELV $3963
line 4759
;4758:
;4759:		}
LABELV $3959
line 4734
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
LABELV $3961
ADDRLP4 332
INDIRI4
ADDRLP4 344
INDIRI4
GEI4 $3991
ADDRGP4 uiInfo+5407588
INDIRI4
CNSTI4 256
LTI4 $3958
LABELV $3991
line 4760
;4760:	}
LABELV $3945
line 4723
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
LABELV $3947
ADDRLP4 352
INDIRI4
ADDRLP4 2404
INDIRI4
GEI4 $3992
ADDRGP4 uiInfo+5407588
INDIRI4
CNSTI4 256
LTI4 $3944
LABELV $3992
line 4762
;4761:
;4762:}
LABELV $3940
endproc UI_BuildQ3Model_List 4520 20
export _UI_Init
proc _UI_Init 48 16
line 4771
;4763:
;4764:
;4765:
;4766:/*
;4767:=================
;4768:UI_Init
;4769:=================
;4770:*/
;4771:void _UI_Init(qboolean inGameLoad) {
line 4776
;4772:	const char *menuSet;
;4773:
;4774:	//uiInfo.inGameLoad = inGameLoad;
;4775:
;4776:	UI_RegisterCvars();
ADDRGP4 UI_RegisterCvars
CALLV
pop
line 4777
;4777:	UI_InitMemory();
ADDRGP4 UI_InitMemory
CALLV
pop
line 4780
;4778:
;4779:	// cache redundant calulations
;4780:	trap_GetGlconfig(&uiInfo.uiDC.glconfig);
ADDRGP4 uiInfo+5342996
ARGP4
ADDRGP4 trap_GetGlconfig
CALLV
pop
line 4782
;4781:
;4782:	trap_Cvar_Set("ui_videomode", va("%dx%d", uiInfo.uiDC.glconfig.vidWidth, uiInfo.uiDC.glconfig.vidHeight));
ADDRGP4 $3995
ARGP4
ADDRGP4 uiInfo+5342996+11304
INDIRI4
ARGI4
ADDRGP4 uiInfo+5342996+11308
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2249
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4785
;4783:
;4784:	// for 640x480 virtualized screen
;4785:	uiInfo.uiDC.yscale = uiInfo.uiDC.glconfig.vidHeight * (1.0 / (float)SCREEN_HEIGHT);
ADDRGP4 uiInfo+200
ADDRGP4 uiInfo+5342996+11308
INDIRI4
CVIF4 4
CNSTF4 990414985
MULF4
ASGNF4
line 4786
;4786:	uiInfo.uiDC.xscale = uiInfo.uiDC.glconfig.vidWidth * (1.0 / (float)SCREEN_WIDTH);
ADDRGP4 uiInfo+204
ADDRGP4 uiInfo+5342996+11304
INDIRI4
CVIF4 4
CNSTF4 986500301
MULF4
ASGNF4
line 4787
;4787:	if (uiInfo.uiDC.glconfig.vidWidth * SCREEN_HEIGHT > uiInfo.uiDC.glconfig.vidHeight * SCREEN_WIDTH) {
ADDRGP4 uiInfo+5342996+11304
INDIRI4
CNSTI4 480
MULI4
ADDRGP4 uiInfo+5342996+11308
INDIRI4
CNSTI4 640
MULI4
LEI4 $4006
line 4789
;4788:		// wide screen
;4789:		uiInfo.uiDC.bias = 0.5 * (uiInfo.uiDC.glconfig.vidWidth - (uiInfo.uiDC.glconfig.vidHeight * ((float)SCREEN_WIDTH / (float)SCREEN_HEIGHT)));
ADDRGP4 uiInfo+208
ADDRGP4 uiInfo+5342996+11304
INDIRI4
CVIF4 4
ADDRGP4 uiInfo+5342996+11308
INDIRI4
CVIF4 4
CNSTF4 1068149419
MULF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 4790
;4790:		uiInfo.uiDC.xscale = uiInfo.uiDC.yscale;
ADDRGP4 uiInfo+204
ADDRGP4 uiInfo+200
INDIRF4
ASGNF4
line 4791
;4791:	} else {
ADDRGP4 $4007
JUMPV
LABELV $4006
line 4793
;4792:		// no wide screen
;4793:		uiInfo.uiDC.bias = 0;
ADDRGP4 uiInfo+208
CNSTF4 0
ASGNF4
line 4794
;4794:	}
LABELV $4007
line 4798
;4795:
;4796:
;4797:	//UI_Load();
;4798:	uiInfo.uiDC.registerShaderNoMip = &trap_R_RegisterShaderNoMip;
ADDRGP4 uiInfo
ADDRGP4 trap_R_RegisterShaderNoMip
ASGNP4
line 4799
;4799:	uiInfo.uiDC.setColor = &UI_SetColor;
ADDRGP4 uiInfo+4
ADDRGP4 UI_SetColor
ASGNP4
line 4800
;4800:	uiInfo.uiDC.drawHandlePic = &UI_DrawHandlePic;
ADDRGP4 uiInfo+8
ADDRGP4 UI_DrawHandlePic
ASGNP4
line 4801
;4801:	uiInfo.uiDC.drawStretchPic = &UI_DrawStretchPic;
ADDRGP4 uiInfo+12
ADDRGP4 UI_DrawStretchPic
ASGNP4
line 4802
;4802:	uiInfo.uiDC.drawText = &Text_Paint;
ADDRGP4 uiInfo+16
ADDRGP4 Text_Paint
ASGNP4
line 4803
;4803:	uiInfo.uiDC.textWidth = &Text_Width;
ADDRGP4 uiInfo+20
ADDRGP4 Text_Width
ASGNP4
line 4804
;4804:	uiInfo.uiDC.textHeight = &Text_Height;
ADDRGP4 uiInfo+24
ADDRGP4 Text_Height
ASGNP4
line 4805
;4805:	uiInfo.uiDC.registerModel = &trap_R_RegisterModel;
ADDRGP4 uiInfo+28
ADDRGP4 trap_R_RegisterModel
ASGNP4
line 4806
;4806:	uiInfo.uiDC.modelBounds = &trap_R_ModelBounds;
ADDRGP4 uiInfo+32
ADDRGP4 trap_R_ModelBounds
ASGNP4
line 4807
;4807:	uiInfo.uiDC.fillRect = &UI_FillRect;
ADDRGP4 uiInfo+36
ADDRGP4 UI_FillRect
ASGNP4
line 4808
;4808:	uiInfo.uiDC.drawRect = &_UI_DrawRect;
ADDRGP4 uiInfo+40
ADDRGP4 _UI_DrawRect
ASGNP4
line 4809
;4809:	uiInfo.uiDC.drawSides = &_UI_DrawSides;
ADDRGP4 uiInfo+44
ADDRGP4 _UI_DrawSides
ASGNP4
line 4810
;4810:	uiInfo.uiDC.drawTopBottom = &_UI_DrawTopBottom;
ADDRGP4 uiInfo+48
ADDRGP4 _UI_DrawTopBottom
ASGNP4
line 4811
;4811:	uiInfo.uiDC.clearScene = &trap_R_ClearScene;
ADDRGP4 uiInfo+52
ADDRGP4 trap_R_ClearScene
ASGNP4
line 4812
;4812:	uiInfo.uiDC.addRefEntityToScene = &trap_R_AddRefEntityToScene;
ADDRGP4 uiInfo+56
ADDRGP4 trap_R_AddRefEntityToScene
ASGNP4
line 4813
;4813:	uiInfo.uiDC.renderScene = &trap_R_RenderScene;
ADDRGP4 uiInfo+60
ADDRGP4 trap_R_RenderScene
ASGNP4
line 4814
;4814:	uiInfo.uiDC.registerFont = &trap_R_RegisterFont;
ADDRGP4 uiInfo+64
ADDRGP4 trap_R_RegisterFont
ASGNP4
line 4815
;4815:	uiInfo.uiDC.ownerDrawItem = &UI_OwnerDraw;
ADDRGP4 uiInfo+68
ADDRGP4 UI_OwnerDraw
ASGNP4
line 4816
;4816:	uiInfo.uiDC.getValue = &UI_GetValue;
ADDRGP4 uiInfo+72
ADDRGP4 UI_GetValue
ASGNP4
line 4817
;4817:	uiInfo.uiDC.ownerDrawVisible = &UI_OwnerDrawVisible;
ADDRGP4 uiInfo+76
ADDRGP4 UI_OwnerDrawVisible
ASGNP4
line 4818
;4818:	uiInfo.uiDC.runScript = &UI_RunMenuScript;
ADDRGP4 uiInfo+80
ADDRGP4 UI_RunMenuScript
ASGNP4
line 4819
;4819:	uiInfo.uiDC.setCVar = trap_Cvar_Set;
ADDRGP4 uiInfo+96
ADDRGP4 trap_Cvar_Set
ASGNP4
line 4820
;4820:	uiInfo.uiDC.getCVarString = trap_Cvar_VariableStringBuffer;
ADDRGP4 uiInfo+88
ADDRGP4 trap_Cvar_VariableStringBuffer
ASGNP4
line 4821
;4821:	uiInfo.uiDC.getCVarValue = trap_Cvar_VariableValue;
ADDRGP4 uiInfo+92
ADDRGP4 trap_Cvar_VariableValue
ASGNP4
line 4822
;4822:	uiInfo.uiDC.drawTextWithCursor = &Text_PaintWithCursor;
ADDRGP4 uiInfo+104
ADDRGP4 Text_PaintWithCursor
ASGNP4
line 4823
;4823:	uiInfo.uiDC.setOverstrikeMode = &trap_Key_SetOverstrikeMode;
ADDRGP4 uiInfo+108
ADDRGP4 trap_Key_SetOverstrikeMode
ASGNP4
line 4824
;4824:	uiInfo.uiDC.getOverstrikeMode = &trap_Key_GetOverstrikeMode;
ADDRGP4 uiInfo+112
ADDRGP4 trap_Key_GetOverstrikeMode
ASGNP4
line 4825
;4825:	uiInfo.uiDC.startLocalSound = &trap_S_StartLocalSound;
ADDRGP4 uiInfo+116
ADDRGP4 trap_S_StartLocalSound
ASGNP4
line 4826
;4826:	uiInfo.uiDC.ownerDrawHandleKey = &UI_OwnerDrawHandleKey;
ADDRGP4 uiInfo+120
ADDRGP4 UI_OwnerDrawHandleKey
ASGNP4
line 4827
;4827:	uiInfo.uiDC.feederCount = &UI_FeederCount;
ADDRGP4 uiInfo+124
ADDRGP4 UI_FeederCount
ASGNP4
line 4828
;4828:	uiInfo.uiDC.feederItemImage = &UI_FeederItemImage;
ADDRGP4 uiInfo+132
ADDRGP4 UI_FeederItemImage
ASGNP4
line 4829
;4829:	uiInfo.uiDC.feederItemText = &UI_FeederItemText;
ADDRGP4 uiInfo+128
ADDRGP4 UI_FeederItemText
ASGNP4
line 4830
;4830:	uiInfo.uiDC.feederSelection = &UI_FeederSelection;
ADDRGP4 uiInfo+136
ADDRGP4 UI_FeederSelection
ASGNP4
line 4831
;4831:	uiInfo.uiDC.setBinding = &trap_Key_SetBinding;
ADDRGP4 uiInfo+148
ADDRGP4 trap_Key_SetBinding
ASGNP4
line 4832
;4832:	uiInfo.uiDC.getBindingBuf = &trap_Key_GetBindingBuf;
ADDRGP4 uiInfo+144
ADDRGP4 trap_Key_GetBindingBuf
ASGNP4
line 4833
;4833:	uiInfo.uiDC.keynumToStringBuf = &trap_Key_KeynumToStringBuf;
ADDRGP4 uiInfo+140
ADDRGP4 trap_Key_KeynumToStringBuf
ASGNP4
line 4834
;4834:	uiInfo.uiDC.executeText = &trap_Cmd_ExecuteText;
ADDRGP4 uiInfo+152
ADDRGP4 trap_Cmd_ExecuteText
ASGNP4
line 4835
;4835:	uiInfo.uiDC.Error = &Com_Error;
ADDRGP4 uiInfo+156
ADDRGP4 Com_Error
ASGNP4
line 4836
;4836:	uiInfo.uiDC.Print = &Com_Printf;
ADDRGP4 uiInfo+160
ADDRGP4 Com_Printf
ASGNP4
line 4837
;4837:	uiInfo.uiDC.Pause = &UI_Pause;
ADDRGP4 uiInfo+164
ADDRGP4 UI_Pause
ASGNP4
line 4838
;4838:	uiInfo.uiDC.ownerDrawWidth = &UI_OwnerDrawWidth;
ADDRGP4 uiInfo+168
ADDRGP4 UI_OwnerDrawWidth
ASGNP4
line 4839
;4839:	uiInfo.uiDC.registerSound = &trap_S_RegisterSound;
ADDRGP4 uiInfo+172
ADDRGP4 trap_S_RegisterSound
ASGNP4
line 4840
;4840:	uiInfo.uiDC.startBackgroundTrack = &trap_S_StartBackgroundTrack;
ADDRGP4 uiInfo+176
ADDRGP4 trap_S_StartBackgroundTrack
ASGNP4
line 4841
;4841:	uiInfo.uiDC.stopBackgroundTrack = &trap_S_StopBackgroundTrack;
ADDRGP4 uiInfo+180
ADDRGP4 trap_S_StopBackgroundTrack
ASGNP4
line 4842
;4842:	uiInfo.uiDC.playCinematic = &UI_PlayCinematic;
ADDRGP4 uiInfo+184
ADDRGP4 UI_PlayCinematic
ASGNP4
line 4843
;4843:	uiInfo.uiDC.stopCinematic = &UI_StopCinematic;
ADDRGP4 uiInfo+188
ADDRGP4 UI_StopCinematic
ASGNP4
line 4844
;4844:	uiInfo.uiDC.drawCinematic = &UI_DrawCinematic;
ADDRGP4 uiInfo+192
ADDRGP4 UI_DrawCinematic
ASGNP4
line 4845
;4845:	uiInfo.uiDC.runCinematicFrame = &UI_RunCinematicFrame;
ADDRGP4 uiInfo+196
ADDRGP4 UI_RunCinematicFrame
ASGNP4
line 4847
;4846:
;4847:	Init_Display(&uiInfo.uiDC);
ADDRGP4 uiInfo
ARGP4
ADDRGP4 Init_Display
CALLV
pop
line 4849
;4848:
;4849:	String_Init();
ADDRGP4 String_Init
CALLV
pop
line 4851
;4850:
;4851:	uiInfo.uiDC.cursor = trap_R_RegisterShaderNoMip("menu/art/3_cursor2");
ADDRGP4 $4068
ARGP4
ADDRLP4 8
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+5354336
ADDRLP4 8
INDIRI4
ASGNI4
line 4852
;4852:	uiInfo.uiDC.whiteShader = trap_R_RegisterShaderNoMip("white");
ADDRGP4 $4070
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+5354328
ADDRLP4 12
INDIRI4
ASGNI4
line 4854
;4853:
;4854:	AssetCache();
ADDRGP4 AssetCache
CALLV
pop
line 4856
;4855:
;4856:	uiInfo.teamCount = 0;
ADDRGP4 uiInfo+5356688
CNSTI4 0
ASGNI4
line 4857
;4857:	uiInfo.characterCount = 0;
ADDRGP4 uiInfo+5354372
CNSTI4 0
ASGNI4
line 4858
;4858:	uiInfo.aliasCount = 0;
ADDRGP4 uiInfo+5355916
CNSTI4 0
ASGNI4
line 4860
;4859:
;4860:	UI_ParseTeamInfo("teaminfo.txt");
ADDRGP4 $4074
ARGP4
ADDRGP4 UI_ParseTeamInfo
CALLV
pop
line 4861
;4861:	UI_LoadTeams();
ADDRGP4 UI_LoadTeams
CALLV
pop
line 4862
;4862:	UI_ParseGameInfo("gameinfo.txt");
ADDRGP4 $680
ARGP4
ADDRGP4 UI_ParseGameInfo
CALLV
pop
line 4863
;4863:	UI_LoadArenas();
ADDRGP4 UI_LoadArenas
CALLV
pop
line 4865
;4864:
;4865:	menuSet = UI_Cvar_VariableString("ui_menuFiles");
ADDRGP4 $674
ARGP4
ADDRLP4 16
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 4866
;4866:	if (menuSet == NULL || menuSet[0] == '\0') {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4077
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $4075
LABELV $4077
line 4867
;4867:		menuSet = "ui/menus.txt";
ADDRLP4 0
ADDRGP4 $646
ASGNP4
line 4868
;4868:	}
LABELV $4075
line 4876
;4869:
;4870:#if 0
;4871:	if (uiInfo.inGameLoad) {
;4872:		UI_LoadMenus("ui/ingame.txt", qtrue);
;4873:	} else {
;4874:	}
;4875:#else 
;4876:	UI_LoadMenus(menuSet, qtrue);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 UI_LoadMenus
CALLV
pop
line 4877
;4877:	UI_LoadMenus("ui/ingame.txt", qfalse);
ADDRGP4 $4078
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 UI_LoadMenus
CALLV
pop
line 4880
;4878:#endif
;4879:
;4880:	Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 4882
;4881:
;4882:	trap_LAN_LoadCachedServers();
ADDRGP4 trap_LAN_LoadCachedServers
CALLV
pop
line 4883
;4883:	UI_LoadBestScores(uiInfo.mapList[ui_currentMap.integer].mapLoadName, uiInfo.gameTypes[ui_gameType.integer].gtEnum);
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+5359512+4
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_LoadBestScores
CALLV
pop
line 4885
;4884:
;4885:	UI_BuildQ3Model_List();
ADDRGP4 UI_BuildQ3Model_List
CALLV
pop
line 4886
;4886:	UI_LoadBots();
ADDRGP4 UI_LoadBots
CALLV
pop
line 4889
;4887:
;4888:	// sets defaults for ui temp cvars
;4889:	uiInfo.effectsColor = gamecodetoui[(int)trap_Cvar_VariableValue("color1") - 1];
ADDRGP4 $1755
ARGP4
ADDRLP4 24
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRGP4 uiInfo+5425004
ADDRLP4 24
INDIRF4
CVFI4 4
CNSTI4 2
LSHI4
ADDRGP4 gamecodetoui-4
ADDP4
INDIRI4
ASGNI4
line 4890
;4890:	uiInfo.currentCrosshair = (int)trap_Cvar_VariableValue("cg_drawCrosshair") % NUM_CROSSHAIRS;
ADDRGP4 $1979
ARGP4
ADDRLP4 28
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRGP4 uiInfo+5407576
ADDRLP4 28
INDIRF4
CVFI4 4
CNSTI4 30
MODI4
ASGNI4
line 4891
;4891:	if (uiInfo.currentCrosshair < 0) {
ADDRGP4 uiInfo+5407576
INDIRI4
CNSTI4 0
GEI4 $4088
line 4892
;4892:		uiInfo.currentCrosshair = 0;
ADDRGP4 uiInfo+5407576
CNSTI4 0
ASGNI4
line 4893
;4893:	}
LABELV $4088
line 4894
;4894:	trap_Cvar_Set("ui_mousePitch", (trap_Cvar_VariableValue("m_pitch") >= 0) ? "0" : "1");
ADDRGP4 $2269
ARGP4
ADDRLP4 36
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 36
INDIRF4
CNSTF4 0
LTF4 $4093
ADDRLP4 32
ADDRGP4 $394
ASGNP4
ADDRGP4 $4094
JUMPV
LABELV $4093
ADDRLP4 32
ADDRGP4 $396
ASGNP4
LABELV $4094
ADDRGP4 $2266
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4896
;4895:
;4896:	uiInfo.serverStatus.currentServerCinematic = -1;
ADDRGP4 uiInfo+5387364+10432
CNSTI4 -1
ASGNI4
line 4897
;4897:	uiInfo.previewMovie = -1;
ADDRGP4 uiInfo+5387360
CNSTI4 -1
ASGNI4
line 4899
;4898:
;4899:	if (trap_Cvar_VariableValue("ui_TeamArenaFirstRun") == 0) {
ADDRGP4 $4100
ARGP4
ADDRLP4 40
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 40
INDIRF4
CNSTF4 0
NEF4 $4098
line 4900
;4900:		trap_Cvar_Set("s_volume", "0.8");
ADDRGP4 $4101
ARGP4
ADDRGP4 $4102
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4901
;4901:		trap_Cvar_Set("s_musicvolume", "0.5");
ADDRGP4 $4103
ARGP4
ADDRGP4 $4104
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4902
;4902:		trap_Cvar_Set("ui_TeamArenaFirstRun", "1");
ADDRGP4 $4100
ARGP4
ADDRGP4 $396
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4903
;4903:	}
LABELV $4098
line 4905
;4904:
;4905:	trap_Cvar_Register(NULL, "debug_protocol", "", 0);
CNSTP4 0
ARGP4
ADDRGP4 $4105
ARGP4
ADDRGP4 $114
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 4907
;4906:
;4907:	trap_Cvar_Set("ui_actualNetGameType", va("%d", ui_netGameType.integer));
ADDRGP4 $727
ARGP4
ADDRGP4 ui_netGameType+12
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $742
ARGP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4908
;4908:}
LABELV $3993
endproc _UI_Init 48 16
export _UI_KeyEvent
proc _UI_KeyEvent 16 12
line 4916
;4909:
;4910:
;4911:/*
;4912:=================
;4913:_UI_KeyEvent
;4914:=================
;4915:*/
;4916:void _UI_KeyEvent(int key, qboolean down) {
line 4918
;4917:
;4918:	if (Menu_Count() > 0) {
ADDRLP4 0
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $4108
line 4919
;4919:		menuDef_t *menu = Menu_GetFocused();
ADDRLP4 8
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 4920
;4920:		if (menu) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4110
line 4921
;4921:			if (key == K_ESCAPE && down && !Menus_AnyFullScreenVisible()) {
ADDRFP4 0
INDIRI4
CNSTI4 27
NEI4 $4112
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $4112
ADDRLP4 12
ADDRGP4 Menus_AnyFullScreenVisible
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $4112
line 4922
;4922:				Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 4923
;4923:			} else {
ADDRGP4 $4111
JUMPV
LABELV $4112
line 4924
;4924:				Menu_HandleKey(menu, key, down);
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
line 4925
;4925:			}
line 4926
;4926:		} else {
ADDRGP4 $4111
JUMPV
LABELV $4110
line 4927
;4927:			trap_Key_SetCatcher(trap_Key_GetCatcher() & ~KEYCATCH_UI);
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
line 4928
;4928:			trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 4929
;4929:			trap_Cvar_Set("cl_paused", "0");
ADDRGP4 $2493
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4930
;4930:		}
LABELV $4111
line 4931
;4931:	}
LABELV $4108
line 4936
;4932:
;4933:	//if ((s > 0) && (s != menu_null_sound)) {
;4934:	  //  trap_S_StartLocalSound( s, CHAN_LOCAL_SOUND );
;4935:	//}
;4936:}
LABELV $4107
endproc _UI_KeyEvent 16 12
export _UI_MouseEvent
proc _UI_MouseEvent 12 12
line 4943
;4937:
;4938:/*
;4939:=================
;4940:UI_MouseEvent
;4941:=================
;4942:*/
;4943:void _UI_MouseEvent(int dx, int dy, qboolean active) {
line 4946
;4944:	int bias;
;4945:
;4946:	if (active) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $4115
line 4948
;4947:		// convert X bias to SCREEN_WIDTH coords
;4948:		bias = uiInfo.uiDC.bias / uiInfo.uiDC.xscale;
ADDRLP4 0
ADDRGP4 uiInfo+208
INDIRF4
ADDRGP4 uiInfo+204
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 4951
;4949:
;4950:		// update mouse screen position
;4951:		uiInfo.uiDC.cursorx += dx;
ADDRLP4 4
ADDRGP4 uiInfo+224
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRI4
ADDI4
ASGNI4
line 4952
;4952:		if (uiInfo.uiDC.cursorx < -bias)
ADDRGP4 uiInfo+224
INDIRI4
ADDRLP4 0
INDIRI4
NEGI4
GEI4 $4120
line 4953
;4953:			uiInfo.uiDC.cursorx = -bias;
ADDRGP4 uiInfo+224
ADDRLP4 0
INDIRI4
NEGI4
ASGNI4
ADDRGP4 $4121
JUMPV
LABELV $4120
line 4954
;4954:		else if (uiInfo.uiDC.cursorx > SCREEN_WIDTH + bias)
ADDRGP4 uiInfo+224
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 640
ADDI4
LEI4 $4124
line 4955
;4955:			uiInfo.uiDC.cursorx = SCREEN_WIDTH + bias;
ADDRGP4 uiInfo+224
ADDRLP4 0
INDIRI4
CNSTI4 640
ADDI4
ASGNI4
LABELV $4124
LABELV $4121
line 4957
;4956:
;4957:		uiInfo.uiDC.cursory += dy;
ADDRLP4 8
ADDRGP4 uiInfo+228
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 4958
;4958:		if (uiInfo.uiDC.cursory < 0)
ADDRGP4 uiInfo+228
INDIRI4
CNSTI4 0
GEI4 $4129
line 4959
;4959:			uiInfo.uiDC.cursory = 0;
ADDRGP4 uiInfo+228
CNSTI4 0
ASGNI4
ADDRGP4 $4116
JUMPV
LABELV $4129
line 4960
;4960:		else if (uiInfo.uiDC.cursory > SCREEN_HEIGHT)
ADDRGP4 uiInfo+228
INDIRI4
CNSTI4 480
LEI4 $4116
line 4961
;4961:			uiInfo.uiDC.cursory = SCREEN_HEIGHT;
ADDRGP4 uiInfo+228
CNSTI4 480
ASGNI4
line 4962
;4962:	} else {
ADDRGP4 $4116
JUMPV
LABELV $4115
line 4963
;4963:		uiInfo.uiDC.cursorx = -bias + (dx * (float)((float)(SCREEN_WIDTH + 2 * bias) / (float)uiInfo.uiDC.glconfig.vidWidth));
ADDRLP4 4
ADDRLP4 0
INDIRI4
ASGNI4
ADDRGP4 uiInfo+224
ADDRLP4 4
INDIRI4
NEGI4
CVIF4 4
ADDRFP4 0
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
LSHI4
CNSTI4 640
ADDI4
CVIF4 4
ADDRGP4 uiInfo+5342996+11304
INDIRI4
CVIF4 4
DIVF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 4964
;4964:		uiInfo.uiDC.cursory = dy * (float)((float)SCREEN_HEIGHT / (float)uiInfo.uiDC.glconfig.vidHeight);
ADDRGP4 uiInfo+228
ADDRFP4 4
INDIRI4
CVIF4 4
CNSTF4 1139802112
ADDRGP4 uiInfo+5342996+11308
INDIRI4
CVIF4 4
DIVF4
MULF4
CVFI4 4
ASGNI4
line 4965
;4965:	}
LABELV $4116
line 4967
;4966:
;4967:	if (Menu_Count() > 0) {
ADDRLP4 4
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LEI4 $4143
line 4970
;4968:		//menuDef_t *menu = Menu_GetFocused();
;4969:		//Menu_HandleMouseMove(menu, uiInfo.uiDC.cursorx, uiInfo.uiDC.cursory);
;4970:		Display_MouseMove(NULL, uiInfo.uiDC.cursorx, uiInfo.uiDC.cursory);
CNSTP4 0
ARGP4
ADDRGP4 uiInfo+224
INDIRI4
ARGI4
ADDRGP4 uiInfo+228
INDIRI4
ARGI4
ADDRGP4 Display_MouseMove
CALLI4
pop
line 4971
;4971:	}
LABELV $4143
line 4972
;4972:}
LABELV $4114
endproc _UI_MouseEvent 12 12
export UI_LoadNonIngame
proc UI_LoadNonIngame 12 8
line 4974
;4973:
;4974:void UI_LoadNonIngame(void) {
line 4975
;4975:	const char *menuSet = UI_Cvar_VariableString("ui_menuFiles");
ADDRGP4 $674
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 4976
;4976:	if (menuSet == NULL || menuSet[0] == '\0') {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4150
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $4148
LABELV $4150
line 4977
;4977:		menuSet = "ui/menus.txt";
ADDRLP4 0
ADDRGP4 $646
ASGNP4
line 4978
;4978:	}
LABELV $4148
line 4979
;4979:	UI_LoadMenus(menuSet, qfalse);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 UI_LoadMenus
CALLV
pop
line 4980
;4980:	uiInfo.inGameLoad = qfalse;
ADDRGP4 uiInfo+5425008
CNSTI4 0
ASGNI4
line 4981
;4981:}
LABELV $4147
endproc UI_LoadNonIngame 12 8
export _UI_SetActiveMenu
proc _UI_SetActiveMenu 292 12
line 4983
;4982:
;4983:void _UI_SetActiveMenu(uiMenuCommand_t menu) {
line 4988
;4984:	char buf[256];
;4985:
;4986:	// this should be the ONLY way the menu system is brought up
;4987:	// ensure minimum menu data is cached
;4988:	if (Menu_Count() > 0) {
ADDRLP4 256
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 256
INDIRI4
CNSTI4 0
LEI4 $4153
line 4990
;4989:		vec3_t v;
;4990:		v[0] = v[1] = v[2] = 0;
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
line 4991
;4991:		switch (menu) {
ADDRLP4 276
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 276
INDIRI4
CNSTI4 0
LTI4 $4157
ADDRLP4 276
INDIRI4
CNSTI4 6
GTI4 $4157
ADDRLP4 276
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $4181
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $4181
address $4160
address $4161
address $4179
address $4152
address $4152
address $4171
address $4174
code
LABELV $4160
line 4993
;4992:		case UIMENU_NONE:
;4993:			trap_Key_SetCatcher(trap_Key_GetCatcher() & ~KEYCATCH_UI);
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
line 4994
;4994:			trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 4995
;4995:			trap_Cvar_Set("cl_paused", "0");
ADDRGP4 $2493
ARGP4
ADDRGP4 $394
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4996
;4996:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 4998
;4997:
;4998:			return;
ADDRGP4 $4152
JUMPV
LABELV $4161
line 5000
;4999:		case UIMENU_MAIN:
;5000:			trap_Cvar_Set("sv_killserver", "1");
ADDRGP4 $395
ARGP4
ADDRGP4 $396
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5001
;5001:			trap_Key_SetCatcher(KEYCATCH_UI);
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 5004
;5002:			//trap_S_StartLocalSound( trap_S_RegisterSound("sound/misc/menu_background.wav", qfalse) , CHAN_LOCAL_SOUND );
;5003:			//trap_S_StartBackgroundTrack("sound/misc/menu_background.wav", NULL);
;5004:			if (uiInfo.inGameLoad) {
ADDRGP4 uiInfo+5425008
INDIRI4
CNSTI4 0
EQI4 $4162
line 5005
;5005:				UI_LoadNonIngame();
ADDRGP4 UI_LoadNonIngame
CALLV
pop
line 5006
;5006:			}
LABELV $4162
line 5007
;5007:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 5008
;5008:			Menus_ActivateByName("main");
ADDRGP4 $2428
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 5009
;5009:			trap_Cvar_VariableStringBuffer("com_errorMessage", buf, sizeof(buf));
ADDRGP4 $2349
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 5010
;5010:			if (strlen(buf)) {
ADDRLP4 0
ARGP4
ADDRLP4 288
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
EQI4 $4152
line 5011
;5011:				if (!ui_singlePlayerActive.integer) {
ADDRGP4 ui_singlePlayerActive+12
INDIRI4
CNSTI4 0
NEI4 $4167
line 5012
;5012:					Menus_ActivateByName("error_popmenu");
ADDRGP4 $4170
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 5013
;5013:				} else {
ADDRGP4 $4152
JUMPV
LABELV $4167
line 5014
;5014:					trap_Cvar_Set("com_errorMessage", "");
ADDRGP4 $2349
ARGP4
ADDRGP4 $114
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5015
;5015:				}
line 5016
;5016:			}
line 5017
;5017:			return;
ADDRGP4 $4152
JUMPV
LABELV $4171
line 5019
;5018:		case UIMENU_TEAM:
;5019:			trap_Key_SetCatcher(KEYCATCH_UI);
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 5020
;5020:			Menus_ActivateByName("team");
ADDRGP4 $2058
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 5021
;5021:			return;
ADDRGP4 $4152
JUMPV
line 5023
;5022:		case UIMENU_NEED_CD:
;5023:			return;
line 5025
;5024:		case UIMENU_BAD_CD_KEY:
;5025:			return;
LABELV $4174
line 5027
;5026:		case UIMENU_POSTGAME:
;5027:			trap_Cvar_Set("sv_killserver", "1");
ADDRGP4 $395
ARGP4
ADDRGP4 $396
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5028
;5028:			trap_Key_SetCatcher(KEYCATCH_UI);
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 5029
;5029:			if (uiInfo.inGameLoad) {
ADDRGP4 uiInfo+5425008
INDIRI4
CNSTI4 0
EQI4 $4175
line 5030
;5030:				UI_LoadNonIngame();
ADDRGP4 UI_LoadNonIngame
CALLV
pop
line 5031
;5031:			}
LABELV $4175
line 5032
;5032:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 5033
;5033:			Menus_ActivateByName("endofgame");
ADDRGP4 $4178
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 5034
;5034:			return;
ADDRGP4 $4152
JUMPV
LABELV $4179
line 5036
;5035:		case UIMENU_INGAME:
;5036:			trap_Cvar_Set("cl_paused", "1");
ADDRGP4 $2493
ARGP4
ADDRGP4 $396
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5037
;5037:			trap_Key_SetCatcher(KEYCATCH_UI);
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 5038
;5038:			UI_BuildPlayerList();
ADDRGP4 UI_BuildPlayerList
CALLV
pop
line 5039
;5039:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 5040
;5040:			Menus_ActivateByName("ingame");
ADDRGP4 $4180
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 5041
;5041:			return;
LABELV $4157
line 5043
;5042:		}
;5043:	}
LABELV $4153
line 5044
;5044:}
LABELV $4152
endproc _UI_SetActiveMenu 292 12
export _UI_IsFullscreen
proc _UI_IsFullscreen 4 0
line 5046
;5045:
;5046:qboolean _UI_IsFullscreen(void) {
line 5047
;5047:	return Menus_AnyFullScreenVisible();
ADDRLP4 0
ADDRGP4 Menus_AnyFullScreenVisible
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $4182
endproc _UI_IsFullscreen 4 0
proc UI_ReadableSize 12 16
line 5055
;5048:}
;5049:
;5050:
;5051:
;5052:static connstate_t	lastConnState;
;5053:static char			lastLoadingText[MAX_INFO_VALUE];
;5054:
;5055:static void UI_ReadableSize(char *buf, int bufsize, int value) {
line 5056
;5056:	if (value > 1024 * 1024 * 1024) { // gigs
ADDRFP4 8
INDIRI4
CNSTI4 1073741824
LEI4 $4184
line 5057
;5057:		Com_sprintf(buf, bufsize, "%d", value / (1024 * 1024 * 1024));
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $727
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1073741824
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5058
;5058:		Com_sprintf(buf + strlen(buf), bufsize - strlen(buf), ".%02d GB",
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
ADDRGP4 $4186
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
line 5060
;5059:			(value % (1024 * 1024 * 1024)) * 100 / (1024 * 1024 * 1024));
;5060:	} else if (value > 1024 * 1024) { // megs
ADDRGP4 $4185
JUMPV
LABELV $4184
ADDRFP4 8
INDIRI4
CNSTI4 1048576
LEI4 $4187
line 5061
;5061:		Com_sprintf(buf, bufsize, "%d", value / (1024 * 1024));
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $727
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1048576
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5062
;5062:		Com_sprintf(buf + strlen(buf), bufsize - strlen(buf), ".%02d MB",
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
ADDRGP4 $4189
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
line 5064
;5063:			(value % (1024 * 1024)) * 100 / (1024 * 1024));
;5064:	} else if (value > 1024) { // kilos
ADDRGP4 $4188
JUMPV
LABELV $4187
ADDRFP4 8
INDIRI4
CNSTI4 1024
LEI4 $4190
line 5065
;5065:		Com_sprintf(buf, bufsize, "%d KB", value / 1024);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $4192
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1024
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5066
;5066:	} else { // bytes
ADDRGP4 $4191
JUMPV
LABELV $4190
line 5067
;5067:		Com_sprintf(buf, bufsize, "%d bytes", value);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $4193
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5068
;5068:	}
LABELV $4191
LABELV $4188
LABELV $4185
line 5069
;5069:}
LABELV $4183
endproc UI_ReadableSize 12 16
proc UI_PrintTime 4 20
line 5072
;5070:
;5071:// Assumes time is in msec
;5072:static void UI_PrintTime(char *buf, int bufsize, int time) {
line 5073
;5073:	time /= 1000;  // change to seconds
ADDRFP4 8
ADDRFP4 8
INDIRI4
CNSTI4 1000
DIVI4
ASGNI4
line 5075
;5074:
;5075:	if (time > 3600) { // in the hours range
ADDRFP4 8
INDIRI4
CNSTI4 3600
LEI4 $4195
line 5076
;5076:		Com_sprintf(buf, bufsize, "%d hr %d min", time / 3600, (time % 3600) / 60);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $4197
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
line 5077
;5077:	} else if (time > 60) { // mins
ADDRGP4 $4196
JUMPV
LABELV $4195
ADDRFP4 8
INDIRI4
CNSTI4 60
LEI4 $4198
line 5078
;5078:		Com_sprintf(buf, bufsize, "%d min %d sec", time / 60, time % 60);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $4200
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
line 5079
;5079:	} else { // secs
ADDRGP4 $4199
JUMPV
LABELV $4198
line 5080
;5080:		Com_sprintf(buf, bufsize, "%d sec", time);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $4201
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5081
;5081:	}
LABELV $4199
LABELV $4196
line 5082
;5082:}
LABELV $4194
endproc UI_PrintTime 4 20
export Text_PaintCenter
proc Text_PaintCenter 8 40
line 5084
;5083:
;5084:void Text_PaintCenter(float x, float y, float scale, const vec4_t color, const char *text, float adjust) {
line 5085
;5085:	float len = Text_Width(text, scale, 0, 1, WIDESCREEN_STRETCH);
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 8
INDIRF4
ARGF4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 Text_Width
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 5086
;5086:	Text_Paint(x - len / 2, y, scale, color, text, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE, 1, WIDESCREEN_STRETCH);
ADDRFP4 0
INDIRF4
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
MULF4
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
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 5087
;5087:}
LABELV $4202
endproc Text_PaintCenter 8 40
proc Text_PaintCenter_AutoWrapped 1056 24
line 5089
;5088:
;5089:static void Text_PaintCenter_AutoWrapped(float x, float y, float xmax, float ystep, float scale, const vec4_t color, const char *str, float adjust) {
line 5095
;5090:	float width;
;5091:	char *s1, *s2, *s3;
;5092:	char c_bcp;
;5093:	char buf[1024];
;5094:
;5095:	if (!str || str[0] == '\0')
ADDRLP4 1044
ADDRFP4 24
INDIRP4
ASGNP4
ADDRLP4 1044
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4206
ADDRLP4 1044
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $4204
LABELV $4206
line 5096
;5096:		return;
ADDRGP4 $4203
JUMPV
LABELV $4204
line 5098
;5097:
;5098:	Q_strncpyz(buf, str, sizeof(buf));
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
line 5099
;5099:	s1 = s2 = s3 = buf;
ADDRLP4 0
ADDRLP4 20
ASGNP4
ADDRLP4 4
ADDRLP4 20
ASGNP4
ADDRLP4 12
ADDRLP4 20
ASGNP4
ADDRGP4 $4208
JUMPV
LABELV $4207
line 5101
;5100:
;5101:	while (1) {
LABELV $4210
line 5102
;5102:		do {
line 5103
;5103:			s3++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 5104
;5104:		} while (*s3 != ' ' && *s3 != '\0');
LABELV $4211
ADDRLP4 1048
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 32
EQI4 $4213
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $4210
LABELV $4213
line 5105
;5105:		c_bcp = *s3;
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI1
ASGNI1
line 5106
;5106:		*s3 = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 5107
;5107:		width = Text_Width(s1, scale, 0, 1, WIDESCREEN_STRETCH);
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRF4
ARGF4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 1052
ADDRGP4 Text_Width
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 1052
INDIRF4
ASGNF4
line 5108
;5108:		*s3 = c_bcp;
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI1
ASGNI1
line 5109
;5109:		if (width > xmax) {
ADDRLP4 16
INDIRF4
ADDRFP4 8
INDIRF4
LEF4 $4214
line 5110
;5110:			if (s1 == s2) {
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
NEU4 $4216
line 5112
;5111:				// fuck, don't have a clean cut, we'll overflow
;5112:				s2 = s3;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 5113
;5113:			}
LABELV $4216
line 5114
;5114:			*s2 = '\0';
ADDRLP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 5115
;5115:			Text_PaintCenter(x, y, scale, color, s1, adjust);
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
line 5116
;5116:			y += ystep;
ADDRFP4 4
ADDRFP4 4
INDIRF4
ADDRFP4 12
INDIRF4
ADDF4
ASGNF4
line 5117
;5117:			if (c_bcp == '\0') {
ADDRLP4 8
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $4218
line 5122
;5118:				// that was the last word
;5119:		// we could start a new loop, but that wouldn't be much use
;5120:		// even if the word is too long, we would overflow it (see above)
;5121:		// so just print it now if needed
;5122:				s2++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 5123
;5123:				if (*s2 != '\0') // if we are printing an overflowing line we have s2 == s3
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $4209
line 5124
;5124:					Text_PaintCenter(x, y, scale, color, s2, adjust);
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
line 5125
;5125:				break;
ADDRGP4 $4209
JUMPV
LABELV $4218
line 5127
;5126:			}
;5127:			s2++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 5128
;5128:			s1 = s2;
ADDRLP4 12
ADDRLP4 4
INDIRP4
ASGNP4
line 5129
;5129:			s3 = s2;
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 5130
;5130:		} else {
ADDRGP4 $4215
JUMPV
LABELV $4214
line 5131
;5131:			s2 = s3;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 5132
;5132:			if (c_bcp == '\0') // we reached the end
ADDRLP4 8
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $4222
line 5133
;5133:			{
line 5134
;5134:				Text_PaintCenter(x, y, scale, color, s1, adjust);
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
line 5135
;5135:				break;
ADDRGP4 $4209
JUMPV
LABELV $4222
line 5137
;5136:			}
;5137:		}
LABELV $4215
line 5138
;5138:	}
LABELV $4208
line 5101
ADDRGP4 $4207
JUMPV
LABELV $4209
line 5139
;5139:}
LABELV $4203
endproc Text_PaintCenter_AutoWrapped 1056 24
lit
align 1
LABELV $4225
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
LABELV $4226
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
LABELV $4227
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
line 5141
;5140:
;5141:static void UI_DisplayDownloadInfo(const char *downloadName, float centerPoint, float yStart, float scale) {
line 5152
;5142:	static char dlText[] = "Downloading:";
;5143:	static char etaText[] = "Estimated time left:";
;5144:	static char xferText[] = "Transfer rate:";
;5145:
;5146:	int downloadSize, downloadCount, downloadTime;
;5147:	char dlSizeBuf[64], totalSizeBuf[64], xferRateBuf[64], dlTimeBuf[64];
;5148:	int xferRate;
;5149:	int leftWidth;
;5150:	const char *s;
;5151:
;5152:	downloadSize = trap_Cvar_VariableValue("cl_downloadSize");
ADDRGP4 $4228
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
line 5153
;5153:	downloadCount = trap_Cvar_VariableValue("cl_downloadCount");
ADDRGP4 $4229
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
line 5154
;5154:	downloadTime = trap_Cvar_VariableValue("cl_downloadTime");
ADDRGP4 $4230
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
line 5156
;5155:
;5156:	leftWidth = HALFSCR_WIDTH;
ADDRLP4 8
CNSTI4 320
ASGNI4
line 5158
;5157:
;5158:	UI_SetColor(colorWhite);
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_SetColor
CALLV
pop
line 5159
;5159:	Text_PaintCenter(centerPoint, yStart + 112, scale, colorWhite, dlText, 0);
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
ADDRGP4 $4225
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5160
;5160:	Text_PaintCenter(centerPoint, yStart + 192, scale, colorWhite, etaText, 0);
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
ADDRGP4 $4226
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5161
;5161:	Text_PaintCenter(centerPoint, yStart + 248, scale, colorWhite, xferText, 0);
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
ADDRGP4 $4227
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5163
;5162:
;5163:	if (downloadSize > 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $4231
line 5164
;5164:		s = va("%s (%d%%)", downloadName,
ADDRGP4 $4233
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
CVIF4 4
CNSTF4 1120403456
MULF4
ADDRLP4 0
INDIRI4
CVIF4 4
DIVF4
CVFI4 4
ARGI4
ADDRLP4 292
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 148
ADDRLP4 292
INDIRP4
ASGNP4
line 5166
;5165:			(int)((float)downloadCount * 100.0f / downloadSize));
;5166:	} else {
ADDRGP4 $4232
JUMPV
LABELV $4231
line 5167
;5167:		s = downloadName;
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
line 5168
;5168:	}
LABELV $4232
line 5170
;5169:
;5170:	Text_PaintCenter(centerPoint, yStart + 136, scale, colorWhite, s, 0);
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
line 5172
;5171:
;5172:	UI_ReadableSize(dlSizeBuf, sizeof dlSizeBuf, downloadCount);
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
line 5173
;5173:	UI_ReadableSize(totalSizeBuf, sizeof totalSizeBuf, downloadSize);
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
line 5175
;5174:
;5175:	if (downloadCount < 4096 || !downloadTime) {
ADDRLP4 4
INDIRI4
CNSTI4 4096
LTI4 $4236
ADDRLP4 140
INDIRI4
CNSTI4 0
NEI4 $4234
LABELV $4236
line 5176
;5176:		Text_PaintCenter(leftWidth, yStart + 216, scale, colorWhite, "estimating", 0);
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
ADDRGP4 $4237
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5177
;5177:		Text_PaintCenter(leftWidth, yStart + 160, scale, colorWhite, va("(%s of %s copied)", dlSizeBuf, totalSizeBuf), 0);
ADDRGP4 $4238
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
line 5178
;5178:	} else {
ADDRGP4 $4235
JUMPV
LABELV $4234
line 5179
;5179:		if ((uiInfo.uiDC.realTime - downloadTime) / 1000) {
ADDRGP4 uiInfo+212
INDIRI4
ADDRLP4 140
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
CNSTI4 0
EQI4 $4239
line 5180
;5180:			xferRate = downloadCount / ((uiInfo.uiDC.realTime - downloadTime) / 1000);
ADDRLP4 144
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+212
INDIRI4
ADDRLP4 140
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
DIVI4
ASGNI4
line 5181
;5181:		} else {
ADDRGP4 $4240
JUMPV
LABELV $4239
line 5182
;5182:			xferRate = 0;
ADDRLP4 144
CNSTI4 0
ASGNI4
line 5183
;5183:		}
LABELV $4240
line 5184
;5184:		UI_ReadableSize(xferRateBuf, sizeof xferRateBuf, xferRate);
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
line 5187
;5185:
;5186:		// Extrapolate estimated completion time
;5187:		if (downloadSize && xferRate) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $4243
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $4243
line 5188
;5188:			int n = downloadSize / xferRate; // estimated time for entire d/l in secs
ADDRLP4 292
ADDRLP4 0
INDIRI4
ADDRLP4 144
INDIRI4
DIVI4
ASGNI4
line 5191
;5189:
;5190:			// We do it in K (/1024) because we'd overflow around 4MB
;5191:			UI_PrintTime(dlTimeBuf, sizeof dlTimeBuf,
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
line 5194
;5192:				(n - (((downloadCount / 1024) * n) / (downloadSize / 1024))) * 1000);
;5193:
;5194:			Text_PaintCenter(leftWidth, yStart + 216, scale, colorWhite, dlTimeBuf, 0);
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
line 5195
;5195:			Text_PaintCenter(leftWidth, yStart + 160, scale, colorWhite, va("(%s of %s copied)", dlSizeBuf, totalSizeBuf), 0);
ADDRGP4 $4238
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
line 5196
;5196:		} else {
ADDRGP4 $4244
JUMPV
LABELV $4243
line 5197
;5197:			Text_PaintCenter(leftWidth, yStart + 216, scale, colorWhite, "estimating", 0);
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
ADDRGP4 $4237
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5198
;5198:			if (downloadSize) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $4245
line 5199
;5199:				Text_PaintCenter(leftWidth, yStart + 160, scale, colorWhite, va("(%s of %s copied)", dlSizeBuf, totalSizeBuf), 0);
ADDRGP4 $4238
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
line 5200
;5200:			} else {
ADDRGP4 $4246
JUMPV
LABELV $4245
line 5201
;5201:				Text_PaintCenter(leftWidth, yStart + 160, scale, colorWhite, va("(%s copied)", dlSizeBuf), 0);
ADDRGP4 $4247
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
line 5202
;5202:			}
LABELV $4246
line 5203
;5203:		}
LABELV $4244
line 5205
;5204:
;5205:		if (xferRate) {
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $4248
line 5206
;5206:			Text_PaintCenter(leftWidth, yStart + 272, scale, colorWhite, va("%s/Sec", xferRateBuf), 0);
ADDRGP4 $4250
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
line 5207
;5207:		}
LABELV $4248
line 5208
;5208:	}
LABELV $4235
line 5209
;5209:}
LABELV $4224
endproc UI_DisplayDownloadInfo 304 24
export UI_DrawConnectScreen
proc UI_DrawConnectScreen 5440 32
line 5219
;5210:
;5211:/*
;5212:========================
;5213:UI_DrawConnectScreen
;5214:
;5215:This will also be overlaid on the cgame info screen during loading
;5216:to prevent it from blinking away too rapidly on local or lan games.
;5217:========================
;5218:*/
;5219:void UI_DrawConnectScreen(qboolean overlay) {
line 5226
;5220:	char *s;
;5221:	uiClientState_t	cstate;
;5222:	char			info[MAX_INFO_VALUE];
;5223:	char text[256];
;5224:	float centerPoint, yStart, scale;
;5225:
;5226:	menuDef_t *menu = Menus_FindByName("Connect");
ADDRGP4 $4252
ARGP4
ADDRLP4 4384
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRLP4 4120
ADDRLP4 4384
INDIRP4
ASGNP4
line 5229
;5227:
;5228:
;5229:	if (!overlay && menu) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $4253
ADDRLP4 4120
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4253
line 5230
;5230:		Menu_Paint(menu, qtrue);
ADDRLP4 4120
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_Paint
CALLV
pop
line 5231
;5231:	}
LABELV $4253
line 5233
;5232:
;5233:	if (!overlay) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $4251
line 5234
;5234:		centerPoint = HALFSCR_WIDTH;
ADDRLP4 3084
CNSTF4 1134559232
ASGNF4
line 5235
;5235:		yStart = 130;
ADDRLP4 4116
CNSTF4 1124204544
ASGNF4
line 5236
;5236:		scale = 0.5f;
ADDRLP4 3088
CNSTF4 1056964608
ASGNF4
line 5237
;5237:	} else {
line 5238
;5238:		return;
LABELV $4256
line 5242
;5239:	}
;5240:
;5241:	// see what information we should display
;5242:	trap_GetClientState(&cstate);
ADDRLP4 0
ARGP4
ADDRGP4 trap_GetClientState
CALLV
pop
line 5244
;5243:
;5244:	info[0] = '\0';
ADDRLP4 3092
CNSTI1 0
ASGNI1
line 5245
;5245:	if (trap_GetConfigString(CS_SERVERINFO, info, sizeof(info))) {
CNSTI4 0
ARGI4
ADDRLP4 3092
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
EQI4 $4257
line 5246
;5246:		Text_PaintCenter(centerPoint, yStart, scale, colorWhite, va("Loading %s", Info_ValueForKey(info, "mapname")), 0);
ADDRLP4 3092
ARGP4
ADDRGP4 $2964
ARGP4
ADDRLP4 4392
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $4259
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
ADDRLP4 4116
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
line 5247
;5247:	}
LABELV $4257
line 5249
;5248:
;5249:	if (!Q_stricmp(cstate.servername, "localhost")) {
ADDRLP4 0+12
ARGP4
ADDRGP4 $4263
ARGP4
ADDRLP4 4392
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4392
INDIRI4
CNSTI4 0
NEI4 $4260
line 5250
;5250:		Text_PaintCenter(centerPoint, yStart + 48, scale, colorWhite, "Starting up...", ITEM_TEXTSTYLE_SHADOWEDMORE);
ADDRLP4 3084
INDIRF4
ARGF4
ADDRLP4 4116
INDIRF4
CNSTF4 1111490560
ADDF4
ARGF4
ADDRLP4 3088
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 $4264
ARGP4
CNSTF4 1086324736
ARGF4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 5251
;5251:	} else {
ADDRGP4 $4261
JUMPV
LABELV $4260
line 5252
;5252:		Com_sprintf(text, sizeof(text), "Connecting to %s", cstate.servername);
ADDRLP4 4124
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $4265
ARGP4
ADDRLP4 0+12
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5253
;5253:		Text_PaintCenter(centerPoint, yStart + 48, scale, colorWhite, text, ITEM_TEXTSTYLE_SHADOWEDMORE);
ADDRLP4 3084
INDIRF4
ARGF4
ADDRLP4 4116
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
line 5254
;5254:	}
LABELV $4261
line 5257
;5255:
;5256:	// display global MOTD at bottom
;5257:	Text_PaintCenter(centerPoint, 600, scale, colorWhite, Info_ValueForKey(cstate.updateInfoString, "motd"), 0);
ADDRLP4 0+1036
ARGP4
ADDRGP4 $4268
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
line 5259
;5258:	// print any server info (server full, bad version, etc)
;5259:	if (cstate.connState < CA_CONNECTED) {
ADDRLP4 0
INDIRI4
CNSTI4 5
GEI4 $4269
line 5260
;5260:		Text_PaintCenter_AutoWrapped(centerPoint, yStart + 176, 630, 20, scale, colorWhite, cstate.messageString, 0);
ADDRLP4 3084
INDIRF4
ARGF4
ADDRLP4 4116
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
line 5261
;5261:	}
LABELV $4269
line 5263
;5262:
;5263:	if (lastConnState > cstate.connState) {
ADDRGP4 lastConnState
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $4272
line 5264
;5264:		lastLoadingText[0] = '\0';
ADDRGP4 lastLoadingText
CNSTI1 0
ASGNI1
line 5265
;5265:	}
LABELV $4272
line 5266
;5266:	lastConnState = cstate.connState;
ADDRGP4 lastConnState
ADDRLP4 0
INDIRI4
ASGNI4
line 5268
;5267:
;5268:	switch (cstate.connState) {
ADDRLP4 4400
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 4400
INDIRI4
CNSTI4 3
LTI4 $4251
ADDRLP4 4400
INDIRI4
CNSTI4 7
GTI4 $4251
ADDRLP4 4400
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $4290-12
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $4290
address $4277
address $4280
address $4283
address $4251
address $4251
code
LABELV $4277
line 5270
;5269:	case CA_CONNECTING:
;5270:		s = va("Awaiting connection...%i", cstate.connectPacketCount);
ADDRGP4 $4278
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
line 5271
;5271:		break;
ADDRGP4 $4275
JUMPV
LABELV $4280
line 5273
;5272:	case CA_CHALLENGING:
;5273:		s = va("Awaiting challenge...%i", cstate.connectPacketCount);
ADDRGP4 $4281
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
line 5274
;5274:		break;
ADDRGP4 $4275
JUMPV
LABELV $4283
line 5275
;5275:	case CA_CONNECTED: {
line 5278
;5276:		char downloadName[MAX_INFO_VALUE];
;5277:
;5278:		trap_Cvar_VariableStringBuffer("cl_downloadName", downloadName, sizeof(downloadName));
ADDRGP4 $4284
ARGP4
ADDRLP4 4416
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 5279
;5279:		if (*downloadName) {
ADDRLP4 4416
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $4285
line 5280
;5280:			UI_DisplayDownloadInfo(downloadName, centerPoint, yStart, scale);
ADDRLP4 4416
ARGP4
ADDRLP4 3084
INDIRF4
ARGF4
ADDRLP4 4116
INDIRF4
ARGF4
ADDRLP4 3088
INDIRF4
ARGF4
ADDRGP4 UI_DisplayDownloadInfo
CALLV
pop
line 5281
;5281:			return;
ADDRGP4 $4251
JUMPV
LABELV $4285
line 5283
;5282:		}
;5283:	}
line 5284
;5284:					 s = "Awaiting gamestate...";
ADDRLP4 4380
ADDRGP4 $4287
ASGNP4
line 5285
;5285:					 break;
line 5287
;5286:	case CA_LOADING:
;5287:		return;
line 5289
;5288:	case CA_PRIMED:
;5289:		return;
line 5291
;5290:	default:
;5291:		return;
LABELV $4275
line 5295
;5292:	}
;5293:
;5294:
;5295:	if (Q_stricmp(cstate.servername, "localhost")) {
ADDRLP4 0+12
ARGP4
ADDRGP4 $4263
ARGP4
ADDRLP4 4408
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4408
INDIRI4
CNSTI4 0
EQI4 $4292
line 5296
;5296:		Text_PaintCenter(centerPoint, yStart + 80, scale, colorWhite, s, 0);
ADDRLP4 3084
INDIRF4
ARGF4
ADDRLP4 4116
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
line 5297
;5297:	}
LABELV $4292
line 5300
;5298:
;5299:	// password required / connection rejected information goes here
;5300:}
LABELV $4251
endproc UI_DrawConnectScreen 5440 32
data
align 4
LABELV cvarTable
address ui_ffa_fraglimit
address $4296
address $705
byte 4 1
address ui_ffa_timelimit
address $4297
address $394
byte 4 1
address ui_tourney_fraglimit
address $4298
address $394
byte 4 1
address ui_tourney_timelimit
address $4299
address $706
byte 4 1
address ui_team_fraglimit
address $4300
address $394
byte 4 1
address ui_team_timelimit
address $4301
address $705
byte 4 1
address ui_team_friendly
address $4302
address $396
byte 4 1
address ui_ctf_capturelimit
address $4303
address $4304
byte 4 1
address ui_ctf_timelimit
address $4305
address $703
byte 4 1
address ui_ctf_friendly
address $4306
address $394
byte 4 1
address ui_arenasFile
address $4307
address $114
byte 4 80
address ui_botsFile
address $4308
address $114
byte 4 80
address ui_spScores1
address $4309
address $114
byte 4 65
address ui_spScores2
address $4310
address $114
byte 4 65
address ui_spScores3
address $4311
address $114
byte 4 65
address ui_spScores4
address $4312
address $114
byte 4 65
address ui_spScores5
address $4313
address $114
byte 4 65
address ui_spAwards
address $4314
address $114
byte 4 65
address ui_spVideos
address $4315
address $114
byte 4 65
address ui_spSkill
address $885
address $2160
byte 4 1
address ui_spSelection
address $4316
address $114
byte 4 64
address ui_browserMaster
address $4317
address $394
byte 4 1
address ui_browserGameType
address $4318
address $394
byte 4 1
address ui_browserSortKey
address $4319
address $2662
byte 4 1
address ui_browserShowFull
address $4320
address $396
byte 4 1
address ui_browserShowEmpty
address $4321
address $396
byte 4 1
address ui_brassTime
address $2255
address $4322
byte 4 1
address ui_drawCrosshair
address $1979
address $2662
byte 4 1
address ui_drawCrosshairNames
address $4323
address $396
byte 4 1
address ui_marks
address $4324
address $396
byte 4 1
address ui_server1
address $4325
address $114
byte 4 1
address ui_server2
address $4326
address $114
byte 4 1
address ui_server3
address $4327
address $114
byte 4 1
address ui_server4
address $4328
address $114
byte 4 1
address ui_server5
address $4329
address $114
byte 4 1
address ui_server6
address $4330
address $114
byte 4 1
address ui_server7
address $4331
address $114
byte 4 1
address ui_server8
address $4332
address $114
byte 4 1
address ui_server9
address $4333
address $114
byte 4 1
address ui_server10
address $4334
address $114
byte 4 1
address ui_server11
address $4335
address $114
byte 4 1
address ui_server12
address $4336
address $114
byte 4 1
address ui_server13
address $4337
address $114
byte 4 1
address ui_server14
address $4338
address $114
byte 4 1
address ui_server15
address $4339
address $114
byte 4 1
address ui_server16
address $4340
address $114
byte 4 1
address ui_new
address $4341
address $394
byte 4 256
address ui_debug
address $4342
address $394
byte 4 256
address ui_initialized
address $4343
address $394
byte 4 256
address ui_teamName
address $712
address $4344
byte 4 1
address ui_opponentName
address $1147
address $4345
byte 4 1
address ui_redteam
address $4346
address $4344
byte 4 1
address ui_blueteam
address $4347
address $4345
byte 4 1
address ui_dedicated
address $4348
address $394
byte 4 1
address ui_gameType
address $4349
address $4350
byte 4 1
address ui_joinGameType
address $4351
address $394
byte 4 1
address ui_netGameType
address $4352
address $4350
byte 4 1
address ui_actualNetGameType
address $4353
address $4350
byte 4 1
address ui_redteam1
address $4354
address $394
byte 4 1
address ui_redteam2
address $4355
address $394
byte 4 1
address ui_redteam3
address $4356
address $394
byte 4 1
address ui_redteam4
address $4357
address $394
byte 4 1
address ui_redteam5
address $4358
address $394
byte 4 1
address ui_blueteam1
address $4359
address $394
byte 4 1
address ui_blueteam2
address $4360
address $394
byte 4 1
address ui_blueteam3
address $4361
address $394
byte 4 1
address ui_blueteam4
address $4362
address $394
byte 4 1
address ui_blueteam5
address $4363
address $394
byte 4 1
address ui_netSource
address $1915
address $394
byte 4 1
address ui_serverFilterType
address $4364
address $394
byte 4 1
address ui_menuFiles
address $674
address $646
byte 4 1
address ui_currentTier
address $1069
address $394
byte 4 1
address ui_currentMap
address $949
address $394
byte 4 1
address ui_currentNetMap
address $947
address $394
byte 4 1
address ui_mapIndex
address $2120
address $394
byte 4 1
address ui_currentOpponent
address $4365
address $394
byte 4 1
address ui_selectedPlayer
address $1406
address $394
byte 4 1
address ui_selectedPlayerName
address $1414
address $114
byte 4 1
address ui_lastServerRefresh_0
address $4366
address $114
byte 4 1
address ui_lastServerRefresh_1
address $4367
address $114
byte 4 1
address ui_lastServerRefresh_2
address $4368
address $114
byte 4 1
address ui_lastServerRefresh_3
address $4369
address $114
byte 4 1
address ui_singlePlayerActive
address $2133
address $394
byte 4 0
address ui_scoreAccuracy
address $4370
address $394
byte 4 1
address ui_scoreImpressives
address $4371
address $394
byte 4 1
address ui_scoreExcellents
address $4372
address $394
byte 4 1
address ui_scoreCaptures
address $4373
address $394
byte 4 1
address ui_scoreDefends
address $4374
address $394
byte 4 1
address ui_scoreAssists
address $4375
address $394
byte 4 1
address ui_scoreGauntlets
address $4376
address $394
byte 4 1
address ui_scoreScore
address $4377
address $394
byte 4 1
address ui_scorePerfect
address $4378
address $394
byte 4 1
address ui_scoreTeam
address $4379
address $4380
byte 4 1
address ui_scoreBase
address $4381
address $394
byte 4 1
address ui_scoreTime
address $4382
address $4383
byte 4 1
address ui_scoreTimeBonus
address $4384
address $394
byte 4 1
address ui_scoreSkillBonus
address $4385
address $394
byte 4 1
address ui_scoreShutoutBonus
address $4386
address $394
byte 4 1
address ui_fragLimit
address $728
address $707
byte 4 0
address ui_captureLimit
address $726
address $708
byte 4 0
address ui_smallFont
address $4387
address $4388
byte 4 1
address ui_bigFont
address $4389
address $4390
byte 4 1
address ui_findPlayer
address $3054
address $1135
byte 4 1
address ui_hudFiles
address $4391
address $4392
byte 4 1
address ui_recordSPDemo
address $2152
address $394
byte 4 1
address ui_teamArenaFirstRun
address $4393
address $394
byte 4 1
address ui_realWarmUp
address $2144
address $705
byte 4 1
address ui_realCaptureLimit
address $729
address $4304
byte 4 1029
address ui_serverStatusTimeOut
address $4394
address $4395
byte 4 1
align 4
LABELV cvarTableSize
byte 4 109
export UI_RegisterCvars
code
proc UI_RegisterCvars 12 16
line 5338
;5301:
;5302:
;5303:/*
;5304:================
;5305:cvars
;5306:================
;5307:*/
;5308:
;5309:typedef struct {
;5310:	vmCvar_t *vmCvar;
;5311:	char *cvarName;
;5312:	char *defaultString;
;5313:	int			cvarFlags;
;5314:} cvarTable_t;
;5315:
;5316:#define DECLARE_UI_CVAR
;5317:#include "ui_cvar.h"
;5318:#undef DECLARE_UI_CVAR
;5319:
;5320:// bk001129 - made static to avoid aliasing
;5321:static cvarTable_t		cvarTable[] = {
;5322:
;5323:#define UI_CVAR_LIST
;5324:	#include "ui_cvar.h"
;5325:#undef UI_CVAR_LIST
;5326:
;5327:};
;5328:
;5329:// bk001129 - made static to avoid aliasing
;5330:static int		cvarTableSize = sizeof(cvarTable) / sizeof(cvarTable[0]);
;5331:
;5332:
;5333:/*
;5334:=================
;5335:UI_RegisterCvars
;5336:=================
;5337:*/
;5338:void UI_RegisterCvars(void) {
line 5342
;5339:	int			i;
;5340:	cvarTable_t *cv;
;5341:
;5342:	for (i = 0, cv = cvarTable; i < cvarTableSize; i++, cv++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $4400
JUMPV
LABELV $4397
line 5343
;5343:		trap_Cvar_Register(cv->vmCvar, cv->cvarName, cv->defaultString, cv->cvarFlags);
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
line 5344
;5344:	}
LABELV $4398
line 5342
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
LABELV $4400
ADDRLP4 4
INDIRI4
ADDRGP4 cvarTableSize
INDIRI4
LTI4 $4397
line 5345
;5345:}
LABELV $4396
endproc UI_RegisterCvars 12 16
export UI_UpdateCvars
proc UI_UpdateCvars 8 4
line 5352
;5346:
;5347:/*
;5348:=================
;5349:UI_UpdateCvars
;5350:=================
;5351:*/
;5352:void UI_UpdateCvars(void) {
line 5356
;5353:	int			i;
;5354:	cvarTable_t *cv;
;5355:
;5356:	for (i = 0, cv = cvarTable; i < cvarTableSize; i++, cv++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 4
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $4405
JUMPV
LABELV $4402
line 5357
;5357:		trap_Cvar_Update(cv->vmCvar);
ADDRLP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 5358
;5358:	}
LABELV $4403
line 5356
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
LABELV $4405
ADDRLP4 0
INDIRI4
ADDRGP4 cvarTableSize
INDIRI4
LTI4 $4402
line 5359
;5359:}
LABELV $4401
endproc UI_UpdateCvars 8 4
proc UI_StopServerRefresh 16 12
line 5367
;5360:
;5361:
;5362:/*
;5363:=================
;5364:ArenaServers_StopRefresh
;5365:=================
;5366:*/
;5367:static void UI_StopServerRefresh(void) {
line 5370
;5368:	int count;
;5369:
;5370:	if (!uiInfo.serverStatus.refreshActive) {
ADDRGP4 uiInfo+5387364+2212
INDIRI4
CNSTI4 0
NEI4 $4407
line 5372
;5371:		// not currently refreshing
;5372:		return;
ADDRGP4 $4406
JUMPV
LABELV $4407
line 5374
;5373:	}
;5374:	uiInfo.serverStatus.refreshActive = qfalse;
ADDRGP4 uiInfo+5387364+2212
CNSTI4 0
ASGNI4
line 5375
;5375:	Com_Printf("%d servers listed in browser with %d players.\n",
ADDRGP4 $4413
ARGP4
ADDRGP4 uiInfo+5387364+10412
INDIRI4
ARGI4
ADDRGP4 uiInfo+5387364+10416
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 5378
;5376:		uiInfo.serverStatus.numDisplayServers,
;5377:		uiInfo.serverStatus.numPlayersOnServers);
;5378:	count = trap_LAN_GetServerCount(UI_SourceForLAN());
ADDRLP4 4
ADDRGP4 UI_SourceForLAN
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 5379
;5379:	if (count - uiInfo.serverStatus.numDisplayServers > 0) {
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5387364+10412
INDIRI4
SUBI4
CNSTI4 0
LEI4 $4418
line 5380
;5380:		Com_Printf("%d servers not listed due to packet loss or pings higher than %d\n",
ADDRGP4 $4425
ARGP4
ADDRLP4 12
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRGP4 $4422
ARGP4
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+5387364+10412
INDIRI4
SUBI4
ARGI4
ADDRLP4 12
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 5383
;5381:			count - uiInfo.serverStatus.numDisplayServers,
;5382:			(int)trap_Cvar_VariableValue("cl_maxPing"));
;5383:	}
LABELV $4418
line 5385
;5384:
;5385:}
LABELV $4406
endproc UI_StopServerRefresh 16 12
proc UI_DoServerRefresh 12 8
line 5392
;5386:
;5387:/*
;5388:=================
;5389:UI_DoServerRefresh
;5390:=================
;5391:*/
;5392:static void UI_DoServerRefresh(void) {
line 5393
;5393:	qboolean wait = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 5395
;5394:
;5395:	if (!uiInfo.serverStatus.refreshActive) {
ADDRGP4 uiInfo+5387364+2212
INDIRI4
CNSTI4 0
NEI4 $4427
line 5396
;5396:		return;
ADDRGP4 $4426
JUMPV
LABELV $4427
line 5398
;5397:	}
;5398:	if (ui_netSource.integer != UIAS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 7
EQI4 $4431
line 5399
;5399:		if (ui_netSource.integer == UIAS_LOCAL) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
NEI4 $4434
line 5400
;5400:			if (!trap_LAN_GetServerCount(AS_LOCAL)) {
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $4435
line 5401
;5401:				wait = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 5402
;5402:			}
line 5403
;5403:		} else {
ADDRGP4 $4435
JUMPV
LABELV $4434
line 5404
;5404:			if (trap_LAN_GetServerCount(AS_GLOBAL) < 0) {
CNSTI4 2
ARGI4
ADDRLP4 4
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $4439
line 5405
;5405:				wait = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 5406
;5406:			}
LABELV $4439
line 5407
;5407:		}
LABELV $4435
line 5408
;5408:	}
LABELV $4431
line 5410
;5409:
;5410:	if (uiInfo.uiDC.realTime < uiInfo.serverStatus.refreshtime) {
ADDRGP4 uiInfo+212
INDIRI4
ADDRGP4 uiInfo+5387364+2192
INDIRI4
GEI4 $4441
line 5411
;5411:		if (wait) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $4446
line 5412
;5412:			return;
ADDRGP4 $4426
JUMPV
LABELV $4446
line 5414
;5413:		}
;5414:	}
LABELV $4441
line 5417
;5415:
;5416:	// if still trying to retrieve pings
;5417:	if (trap_LAN_UpdateVisiblePings(UI_SourceForLAN())) {
ADDRLP4 4
ADDRGP4 UI_SourceForLAN
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 trap_LAN_UpdateVisiblePings
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $4448
line 5418
;5418:		uiInfo.serverStatus.refreshtime = uiInfo.uiDC.realTime + 1000;
ADDRGP4 uiInfo+5387364+2192
ADDRGP4 uiInfo+212
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 5419
;5419:	} else if (!wait) {
ADDRGP4 $4449
JUMPV
LABELV $4448
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $4453
line 5421
;5420:		// get the last servers in the list
;5421:		UI_BuildServerDisplayList(2);
CNSTI4 2
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 5423
;5422:		// stop the refresh
;5423:		UI_StopServerRefresh();
ADDRGP4 UI_StopServerRefresh
CALLV
pop
line 5424
;5424:	} else if (ui_netSource.integer == UIAS_LOCAL) {
ADDRGP4 $4454
JUMPV
LABELV $4453
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
NEI4 $4455
line 5426
;5425:		// no local servers found, check again
;5426:		trap_Cmd_ExecuteText(EXEC_NOW, "localservers\n");
CNSTI4 0
ARGI4
ADDRGP4 $4458
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 5427
;5427:		uiInfo.serverStatus.refreshtime = uiInfo.uiDC.realTime + 5000;
ADDRGP4 uiInfo+5387364+2192
ADDRGP4 uiInfo+212
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 5428
;5428:	}
LABELV $4455
LABELV $4454
LABELV $4449
line 5430
;5429:	//
;5430:	UI_BuildServerDisplayList(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 5431
;5431:}
LABELV $4426
endproc UI_DoServerRefresh 12 8
proc UI_StartServerRefresh 72 24
line 5438
;5432:
;5433:/*
;5434:=================
;5435:UI_StartServerRefresh
;5436:=================
;5437:*/
;5438:static void UI_StartServerRefresh(qboolean full, qboolean force) {
line 5446
;5439:	char *ptr;
;5440:	int	lanSource;
;5441:	qtime_t q;
;5442:
;5443:	// This function is called with force=qfalse when server browser menu opens or net source changes.
;5444:	// Automatically update local and favorite servers.
;5445:	// Only auto update master server list if there is no server info cache.
;5446:	if (!force && (ui_netSource.integer >= UIAS_GLOBAL0 && ui_netSource.integer <= UIAS_GLOBAL5)) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $4463
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 1
LTI4 $4463
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 6
GTI4 $4463
line 5447
;5447:		if (trap_LAN_GetServerCount(UI_SourceForLAN()) > 0) {
ADDRLP4 44
ADDRGP4 UI_SourceForLAN
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
LEI4 $4467
line 5448
;5448:			return; // have cached list
ADDRGP4 $4462
JUMPV
LABELV $4467
line 5450
;5449:		}
;5450:	}
LABELV $4463
line 5452
;5451:
;5452:	trap_RealTime(&q); // , qtrue, 0);
ADDRLP4 0
ARGP4
ADDRGP4 trap_RealTime
CALLI4
pop
line 5453
;5453:	trap_Cvar_Set(va("ui_lastServerRefresh_%i", ui_netSource.integer), va("%s-%i, %i at %i:%02i", MonthAbbrev[q.tm_mon], q.tm_mday, 1900 + q.tm_year, q.tm_hour, q.tm_min));
ADDRGP4 $1331
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $4470
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
line 5455
;5454:
;5455:	if (!full) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $4476
line 5456
;5456:		UI_UpdatePendingPings();
ADDRGP4 UI_UpdatePendingPings
CALLV
pop
line 5457
;5457:		return;
ADDRGP4 $4462
JUMPV
LABELV $4476
line 5460
;5458:	}
;5459:
;5460:	uiInfo.serverStatus.refreshActive = qtrue;
ADDRGP4 uiInfo+5387364+2212
CNSTI4 1
ASGNI4
line 5461
;5461:	uiInfo.serverStatus.nextDisplayRefresh = uiInfo.uiDC.realTime + 1000;
ADDRGP4 uiInfo+5387364+10420
ADDRGP4 uiInfo+212
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 5463
;5462:	// clear number of displayed servers
;5463:	uiInfo.serverStatus.numDisplayServers = 0;
ADDRGP4 uiInfo+5387364+10412
CNSTI4 0
ASGNI4
line 5464
;5464:	uiInfo.serverStatus.numPlayersOnServers = 0;
ADDRGP4 uiInfo+5387364+10416
CNSTI4 0
ASGNI4
line 5466
;5465:
;5466:	lanSource = UI_SourceForLAN();
ADDRLP4 52
ADDRGP4 UI_SourceForLAN
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 52
INDIRI4
ASGNI4
line 5468
;5467:	// mark all servers as visible so we store ping updates for them
;5468:	trap_LAN_MarkServerVisible(lanSource, -1, qtrue);
ADDRLP4 36
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_LAN_MarkServerVisible
CALLV
pop
line 5470
;5469:	// reset all the pings
;5470:	trap_LAN_ResetPings(lanSource);
ADDRLP4 36
INDIRI4
ARGI4
ADDRGP4 trap_LAN_ResetPings
CALLV
pop
line 5472
;5471:	//
;5472:	if (ui_netSource.integer == UIAS_LOCAL) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
NEI4 $4487
line 5473
;5473:		trap_Cmd_ExecuteText(EXEC_NOW, "localservers\n");
CNSTI4 0
ARGI4
ADDRGP4 $4458
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 5474
;5474:		uiInfo.serverStatus.refreshtime = uiInfo.uiDC.realTime + 5000;
ADDRGP4 uiInfo+5387364+2192
ADDRGP4 uiInfo+212
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 5475
;5475:		return;
ADDRGP4 $4462
JUMPV
LABELV $4487
line 5478
;5476:	}
;5477:
;5478:	uiInfo.serverStatus.refreshtime = uiInfo.uiDC.realTime + 5000;
ADDRGP4 uiInfo+5387364+2192
ADDRGP4 uiInfo+212
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 5479
;5479:	if (ui_netSource.integer >= UIAS_GLOBAL0 && ui_netSource.integer <= UIAS_GLOBAL5) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 1
LTI4 $4496
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 6
GTI4 $4496
line 5481
;5480:
;5481:		ptr = UI_Cvar_VariableString("debug_protocol");
ADDRGP4 $4105
ARGP4
ADDRLP4 56
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 40
ADDRLP4 56
INDIRP4
ASGNP4
line 5482
;5482:		if (strlen(ptr)) {
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $4500
line 5483
;5483:			trap_Cmd_ExecuteText(EXEC_NOW, va("globalservers %d %s full empty\n", ui_netSource.integer - UIAS_GLOBAL0, ptr));
ADDRGP4 $4502
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRLP4 40
INDIRP4
ARGP4
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
line 5484
;5484:		} else {
ADDRGP4 $4501
JUMPV
LABELV $4500
line 5485
;5485:			trap_Cmd_ExecuteText(EXEC_NOW, va("globalservers %d %d full empty\n", ui_netSource.integer - UIAS_GLOBAL0, (int)trap_Cvar_VariableValue("protocol")));
ADDRGP4 $2087
ARGP4
ADDRLP4 64
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRGP4 $4504
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRLP4 64
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 68
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 0
ARGI4
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 5486
;5486:		}
LABELV $4501
line 5487
;5487:	}
LABELV $4496
line 5488
;5488:}
LABELV $4462
endproc UI_StartServerRefresh 72 24
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
import UI_DrawStretchPic
import UI_DrawHandlePic
import UI_DrawNamedPic
import UI_ClampCvar
import UI_ConsoleCommand
import UI_Refresh
import UI_MouseEvent
import UI_Shutdown
import UI_Init
export uiInfo
align 4
LABELV uiInfo
skip 5425012
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
import UI_SelectForKey
import Menus_Activate
import Menus_AnyFullScreenVisible
import Menu_Reset
import Menus_ActivateByName
import Menu_PaintAll
import Menu_HandleCapture
import Menu_New
import Menu_Count
import Q_MathScript
import MenuVar_Get
import MenuVar_Set
import PC_Parenthesis_Parse
import PC_Script_Parse
import PC_String_Parse
import PC_Rect_Parse
import PC_Int_Parse
import PC_Color_Parse
import PC_Float_Parse
import Script_Parse
import String_Parse
import Rect_Parse
import Int_Parse
import Color_Parse
import Float_Parse
import Menu_ScrollFeeder
import Menu_HandleMouseMove
import Menu_HandleKey
import Menu_GetFocused
import Item_Init
import Menu_Init
import Init_Display
import String_Report
import String_Init
import String_Alloc
import DefaultWideScreenValue
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
import bgWeapons
import bgArmor
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
LABELV $4504
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
LABELV $4502
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
LABELV $4470
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
byte 1 48
byte 1 50
byte 1 105
byte 1 0
align 1
LABELV $4458
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
LABELV $4425
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
LABELV $4422
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
LABELV $4413
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
LABELV $4395
byte 1 55
byte 1 48
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $4394
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
LABELV $4393
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
LABELV $4392
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
LABELV $4391
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
LABELV $4390
byte 1 48
byte 1 46
byte 1 52
byte 1 0
align 1
LABELV $4389
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
LABELV $4388
byte 1 48
byte 1 46
byte 1 50
byte 1 53
byte 1 0
align 1
LABELV $4387
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
LABELV $4386
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
LABELV $4385
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
LABELV $4384
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
LABELV $4383
byte 1 48
byte 1 48
byte 1 58
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $4382
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
LABELV $4381
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
LABELV $4380
byte 1 48
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 48
byte 1 0
align 1
LABELV $4379
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
LABELV $4378
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
LABELV $4377
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
LABELV $4376
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
LABELV $4375
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
LABELV $4374
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
LABELV $4373
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
LABELV $4372
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
LABELV $4371
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
LABELV $4370
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
LABELV $4369
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
LABELV $4368
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
LABELV $4367
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
LABELV $4366
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
LABELV $4365
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
LABELV $4364
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
LABELV $4363
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
LABELV $4362
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
LABELV $4361
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
LABELV $4360
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
LABELV $4359
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
LABELV $4358
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
LABELV $4357
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
LABELV $4356
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
LABELV $4355
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
LABELV $4354
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
LABELV $4353
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
LABELV $4352
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
LABELV $4351
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
LABELV $4350
byte 1 51
byte 1 0
align 1
LABELV $4349
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
LABELV $4348
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
LABELV $4347
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
LABELV $4346
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
LABELV $4345
byte 1 83
byte 1 116
byte 1 114
byte 1 111
byte 1 103
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $4344
byte 1 80
byte 1 97
byte 1 103
byte 1 97
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $4343
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
LABELV $4342
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
LABELV $4341
byte 1 117
byte 1 105
byte 1 95
byte 1 110
byte 1 101
byte 1 119
byte 1 0
align 1
LABELV $4340
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
LABELV $4339
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
LABELV $4338
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
LABELV $4337
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
LABELV $4336
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
LABELV $4335
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
LABELV $4334
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
LABELV $4333
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 57
byte 1 0
align 1
LABELV $4332
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 56
byte 1 0
align 1
LABELV $4331
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 55
byte 1 0
align 1
LABELV $4330
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 54
byte 1 0
align 1
LABELV $4329
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 53
byte 1 0
align 1
LABELV $4328
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 52
byte 1 0
align 1
LABELV $4327
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 51
byte 1 0
align 1
LABELV $4326
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $4325
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $4324
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
LABELV $4323
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
LABELV $4322
byte 1 50
byte 1 53
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $4321
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
LABELV $4320
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
LABELV $4319
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
LABELV $4318
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
LABELV $4317
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
LABELV $4316
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
LABELV $4315
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
LABELV $4314
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
LABELV $4313
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
LABELV $4312
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
LABELV $4311
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
LABELV $4310
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
LABELV $4309
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
LABELV $4308
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
LABELV $4307
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
LABELV $4306
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
LABELV $4305
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
LABELV $4304
byte 1 56
byte 1 0
align 1
LABELV $4303
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
LABELV $4302
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
LABELV $4301
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
LABELV $4300
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
LABELV $4299
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
LABELV $4298
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
LABELV $4297
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
LABELV $4296
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
LABELV $4287
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
LABELV $4284
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
LABELV $4281
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
LABELV $4278
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
LABELV $4268
byte 1 109
byte 1 111
byte 1 116
byte 1 100
byte 1 0
align 1
LABELV $4265
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
LABELV $4264
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
LABELV $4263
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
LABELV $4259
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
LABELV $4252
byte 1 67
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $4250
byte 1 37
byte 1 115
byte 1 47
byte 1 83
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $4247
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
LABELV $4238
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
LABELV $4237
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
LABELV $4233
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
LABELV $4230
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
LABELV $4229
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
LABELV $4228
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
LABELV $4201
byte 1 37
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $4200
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
LABELV $4197
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
LABELV $4193
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
LABELV $4192
byte 1 37
byte 1 100
byte 1 32
byte 1 75
byte 1 66
byte 1 0
align 1
LABELV $4189
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
LABELV $4186
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
LABELV $4180
byte 1 105
byte 1 110
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $4178
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
LABELV $4170
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
LABELV $4105
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
LABELV $4104
byte 1 48
byte 1 46
byte 1 53
byte 1 0
align 1
LABELV $4103
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
LABELV $4102
byte 1 48
byte 1 46
byte 1 56
byte 1 0
align 1
LABELV $4101
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
LABELV $4100
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
LABELV $4078
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
LABELV $4074
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
LABELV $4070
byte 1 119
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $4068
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
LABELV $3995
byte 1 37
byte 1 100
byte 1 120
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $3990
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
LABELV $3971
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $3970
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
LABELV $3967
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
LABELV $3966
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
LABELV $3965
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 0
align 1
LABELV $3957
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $3956
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
LABELV $3954
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $3953
byte 1 46
byte 1 0
align 1
LABELV $3943
byte 1 47
byte 1 0
align 1
LABELV $3942
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
LABELV $3936
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $3931
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
LABELV $3926
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
LABELV $3912
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
LABELV $3904
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
LABELV $3849
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
LABELV $3844
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
LABELV $3803
byte 1 97
byte 1 108
byte 1 105
byte 1 97
byte 1 115
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $3800
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
LABELV $3795
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $3773
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
LABELV $3760
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
LABELV $3735
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
LABELV $3731
byte 1 115
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $3727
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $3724
byte 1 99
byte 1 114
byte 1 97
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $3720
byte 1 102
byte 1 101
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $3715
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
LABELV $3703
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
LABELV $3681
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
LABELV $3639
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
LABELV $3520
byte 1 42
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $3519
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
LABELV $3516
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
LABELV $3415
byte 1 78
byte 1 111
byte 1 0
align 1
LABELV $3414
byte 1 89
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $3411
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
LABELV $3409
byte 1 46
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $3405
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $3401
byte 1 37
byte 1 115
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 0
align 1
LABELV $3398
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $3397
byte 1 37
byte 1 115
byte 1 32
byte 1 91
byte 1 37
byte 1 115
byte 1 93
byte 1 0
align 1
LABELV $3393
byte 1 110
byte 1 101
byte 1 116
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $3221
byte 1 115
byte 1 0
align 1
LABELV $3218
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
LABELV $3213
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
LABELV $3131
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
LABELV $3073
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
LABELV $3065
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
LABELV $3054
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
LABELV $3011
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $3010
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $3009
byte 1 110
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $2967
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
LABELV $2966
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $2965
byte 1 77
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $2964
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2963
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
LABELV $2962
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
LABELV $2961
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
LABELV $2960
byte 1 65
byte 1 100
byte 1 100
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $2959
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2958
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
LABELV $2943
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2930
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
LABELV $2910
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $2869
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
LABELV $2858
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
LABELV $2696
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
LABELV $2693
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
LABELV $2671
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
LABELV $2670
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
LABELV $2665
byte 1 117
byte 1 112
byte 1 100
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $2662
byte 1 52
byte 1 0
align 1
LABELV $2661
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
LABELV $2658
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
LABELV $2655
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
LABELV $2642
byte 1 10
byte 1 0
align 1
LABELV $2635
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $2626
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
LABELV $2625
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
LABELV $2624
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
LABELV $2612
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
LABELV $2609
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
LABELV $2608
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
LABELV $2605
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
LABELV $2600
byte 1 97
byte 1 100
byte 1 100
byte 1 114
byte 1 0
align 1
LABELV $2599
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
LABELV $2591
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
LABELV $2575
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
LABELV $2572
byte 1 97
byte 1 100
byte 1 100
byte 1 66
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $2567
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2561
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
LABELV $2555
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
LABELV $2549
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
LABELV $2544
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
LABELV $2538
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
LABELV $2532
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
LABELV $2526
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 77
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $2523
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
LABELV $2520
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
LABELV $2517
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
LABELV $2501
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
LABELV $2498
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
LABELV $2497
byte 1 76
byte 1 101
byte 1 97
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $2494
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
LABELV $2493
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
LABELV $2492
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
LABELV $2489
byte 1 113
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $2488
byte 1 81
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $2478
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
LABELV $2475
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
LABELV $2462
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
LABELV $2457
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
LABELV $2450
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
LABELV $2441
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
LABELV $2438
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
LABELV $2431
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
LABELV $2428
byte 1 109
byte 1 97
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $2427
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
LABELV $2418
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
LABELV $2415
byte 1 81
byte 1 117
byte 1 97
byte 1 107
byte 1 101
byte 1 51
byte 1 0
align 1
LABELV $2410
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
LABELV $2409
byte 1 82
byte 1 117
byte 1 110
byte 1 68
byte 1 101
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $2406
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
LABELV $2403
byte 1 102
byte 1 115
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2402
byte 1 82
byte 1 117
byte 1 110
byte 1 77
byte 1 111
byte 1 100
byte 1 0
align 1
LABELV $2397
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
LABELV $2392
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
LABELV $2389
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
LABELV $2386
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
LABELV $2383
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
LABELV $2374
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
LABELV $2370
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
LABELV $2367
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
LABELV $2364
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
LABELV $2361
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
LABELV $2352
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
LABELV $2349
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
LABELV $2348
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
LABELV $2345
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
LABELV $2342
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
LABELV $2339
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
LABELV $2338
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
LABELV $2335
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
LABELV $2332
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
LABELV $2329
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
LABELV $2328
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
LABELV $2327
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
LABELV $2326
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
LABELV $2325
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
LABELV $2318
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
LABELV $2308
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
LABELV $2305
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
LABELV $2276
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
LABELV $2275
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
LABELV $2269
byte 1 109
byte 1 95
byte 1 112
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $2266
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
LABELV $2261
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
LABELV $2259
byte 1 54
byte 1 52
byte 1 48
byte 1 120
byte 1 52
byte 1 56
byte 1 48
byte 1 0
align 1
LABELV $2257
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
LABELV $2256
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
LABELV $2255
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
LABELV $2254
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
LABELV $2253
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
LABELV $2252
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
LABELV $2251
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
LABELV $2250
byte 1 56
byte 1 48
byte 1 48
byte 1 120
byte 1 54
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $2249
byte 1 117
byte 1 105
byte 1 95
byte 1 118
byte 1 105
byte 1 100
byte 1 101
byte 1 111
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $2248
byte 1 114
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $2247
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
LABELV $2246
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
LABELV $2245
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
LABELV $2241
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
LABELV $2236
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
LABELV $2232
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
LABELV $2225
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
LABELV $2224
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
LABELV $2220
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
LABELV $2217
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
LABELV $2212
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
LABELV $2211
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
LABELV $2208
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $2207
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
LABELV $2204
byte 1 117
byte 1 105
byte 1 95
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2203
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
LABELV $2199
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
LABELV $2175
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
LABELV $2161
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
LABELV $2160
byte 1 50
byte 1 0
align 1
LABELV $2157
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
LABELV $2153
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $2152
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
LABELV $2149
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
LABELV $2148
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
LABELV $2147
byte 1 117
byte 1 105
byte 1 95
byte 1 112
byte 1 117
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $2146
byte 1 115
byte 1 118
byte 1 95
byte 1 112
byte 1 117
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $2145
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
LABELV $2144
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
LABELV $2143
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
LABELV $2142
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
LABELV $2141
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
LABELV $2140
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
LABELV $2139
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
LABELV $2138
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
LABELV $2137
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
LABELV $2136
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
LABELV $2135
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
LABELV $2134
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
LABELV $2133
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
LABELV $2130
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
LABELV $2126
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
LABELV $2120
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
LABELV $2116
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
LABELV $2090
byte 1 46
byte 1 100
byte 1 109
byte 1 95
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $2089
byte 1 100
byte 1 101
byte 1 109
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $2087
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
LABELV $2086
byte 1 100
byte 1 109
byte 1 95
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $2083
byte 1 46
byte 1 114
byte 1 111
byte 1 113
byte 1 0
align 1
LABELV $2068
byte 1 114
byte 1 111
byte 1 113
byte 1 0
align 1
LABELV $2067
byte 1 118
byte 1 105
byte 1 100
byte 1 101
byte 1 111
byte 1 0
align 1
LABELV $2058
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $2043
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
LABELV $1996
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
LABELV $1979
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
LABELV $1915
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
LABELV $1901
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $1895
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $1851
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1825
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
LABELV $1800
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
LABELV $1755
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $1631
byte 1 85
byte 1 73
byte 1 95
byte 1 79
byte 1 119
byte 1 110
byte 1 101
byte 1 114
byte 1 68
byte 1 114
byte 1 97
byte 1 119
byte 1 32
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 101
byte 1 114
byte 1 32
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $1554
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
LABELV $1550
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
LABELV $1547
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
LABELV $1439
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
LABELV $1437
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
LABELV $1424
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $1414
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
LABELV $1406
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
LABELV $1386
byte 1 110
byte 1 0
align 1
LABELV $1375
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
LABELV $1374
byte 1 116
byte 1 0
align 1
LABELV $1373
byte 1 116
byte 1 108
byte 1 0
align 1
LABELV $1340
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
LABELV $1331
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
LABELV $1329
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
LABELV $1328
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
LABELV $1147
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
LABELV $1140
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
LABELV $1135
byte 1 83
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $1087
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
LABELV $1074
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
LABELV $1069
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
LABELV $1066
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
LABELV $1034
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
LABELV $1019
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
LABELV $1018
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $979
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
LABELV $964
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
LABELV $949
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
LABELV $947
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
LABELV $917
byte 1 72
byte 1 117
byte 1 109
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $914
byte 1 67
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $908
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
LABELV $907
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
LABELV $901
byte 1 82
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $900
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $899
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $892
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
LABELV $891
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
LABELV $885
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
LABELV $854
byte 1 37
byte 1 115
byte 1 46
byte 1 114
byte 1 111
byte 1 113
byte 1 0
align 1
LABELV $785
byte 1 37
byte 1 115
byte 1 95
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $780
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
LABELV $752
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
LABELV $742
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
LABELV $741
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
LABELV $730
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
LABELV $729
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
LABELV $728
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
LABELV $727
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $726
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
LABELV $712
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
LABELV $710
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
LABELV $708
byte 1 53
byte 1 0
align 1
LABELV $707
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $706
byte 1 49
byte 1 53
byte 1 0
align 1
LABELV $705
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $704
byte 1 50
byte 1 53
byte 1 0
align 1
LABELV $703
byte 1 51
byte 1 48
byte 1 0
align 1
LABELV $702
byte 1 51
byte 1 53
byte 1 0
align 1
LABELV $701
byte 1 52
byte 1 48
byte 1 0
align 1
LABELV $700
byte 1 52
byte 1 53
byte 1 0
align 1
LABELV $699
byte 1 53
byte 1 48
byte 1 0
align 1
LABELV $698
byte 1 53
byte 1 53
byte 1 0
align 1
LABELV $697
byte 1 54
byte 1 48
byte 1 0
align 1
LABELV $696
byte 1 54
byte 1 53
byte 1 0
align 1
LABELV $695
byte 1 55
byte 1 48
byte 1 0
align 1
LABELV $694
byte 1 55
byte 1 53
byte 1 0
align 1
LABELV $693
byte 1 56
byte 1 48
byte 1 0
align 1
LABELV $692
byte 1 56
byte 1 53
byte 1 0
align 1
LABELV $691
byte 1 57
byte 1 48
byte 1 0
align 1
LABELV $690
byte 1 57
byte 1 53
byte 1 0
align 1
LABELV $689
byte 1 78
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $680
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
LABELV $674
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
LABELV $672
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
LABELV $669
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
LABELV $649
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
LABELV $646
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
LABELV $624
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 100
byte 1 101
byte 1 102
byte 1 0
align 1
LABELV $618
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
LABELV $604
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
LABELV $598
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
LABELV $593
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
LABELV $592
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
LABELV $581
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
LABELV $573
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 89
byte 1 0
align 1
LABELV $565
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 88
byte 1 0
align 1
LABELV $557
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
LABELV $549
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
LABELV $541
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
LABELV $529
byte 1 99
byte 1 117
byte 1 114
byte 1 115
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $521
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
LABELV $513
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
LABELV $505
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
LABELV $497
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
LABELV $489
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
LABELV $480
byte 1 98
byte 1 105
byte 1 103
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $471
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
LABELV $460
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $456
byte 1 125
byte 1 0
align 1
LABELV $447
byte 1 123
byte 1 0
align 1
LABELV $440
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
byte 1 10
byte 1 0
align 1
LABELV $437
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
LABELV $421
byte 1 105
byte 1 110
byte 1 95
byte 1 110
byte 1 111
byte 1 103
byte 1 114
byte 1 97
byte 1 98
byte 1 0
align 1
LABELV $396
byte 1 49
byte 1 0
align 1
LABELV $395
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
LABELV $394
byte 1 48
byte 1 0
align 1
LABELV $393
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
LABELV $230
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
LABELV $228
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
LABELV $221
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
LABELV $218
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
LABELV $215
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
LABELV $212
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
LABELV $209
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
LABELV $206
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
LABELV $203
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
LABELV $200
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
LABELV $197
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
LABELV $193
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
LABELV $189
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
LABELV $185
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
LABELV $181
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
LABELV $177
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
LABELV $173
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
LABELV $170
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
LABELV $167
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
LABELV $148
byte 1 73
byte 1 80
byte 1 88
byte 1 0
align 1
LABELV $147
byte 1 85
byte 1 68
byte 1 80
byte 1 0
align 1
LABELV $146
byte 1 63
byte 1 63
byte 1 63
byte 1 0
align 1
LABELV $145
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
LABELV $144
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
LABELV $143
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
LABELV $142
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
LABELV $141
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
LABELV $140
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 82
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $139
byte 1 65
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 68
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $138
byte 1 68
byte 1 111
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $137
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 122
byte 1 101
byte 1 32
byte 1 84
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $136
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
LABELV $135
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
LABELV $134
byte 1 79
byte 1 110
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $133
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
LABELV $132
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
LABELV $131
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
LABELV $130
byte 1 82
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $129
byte 1 68
byte 1 117
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $128
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
LABELV $127
byte 1 82
byte 1 69
byte 1 68
byte 1 32
byte 1 82
byte 1 79
byte 1 86
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $126
byte 1 65
byte 1 84
byte 1 84
byte 1 65
byte 1 67
byte 1 75
byte 1 32
byte 1 65
byte 1 78
byte 1 68
byte 1 32
byte 1 68
byte 1 69
byte 1 70
byte 1 69
byte 1 78
byte 1 68
byte 1 0
align 1
LABELV $125
byte 1 68
byte 1 79
byte 1 77
byte 1 73
byte 1 78
byte 1 65
byte 1 84
byte 1 73
byte 1 79
byte 1 78
byte 1 0
align 1
LABELV $124
byte 1 70
byte 1 82
byte 1 69
byte 1 69
byte 1 90
byte 1 69
byte 1 84
byte 1 65
byte 1 71
byte 1 0
align 1
LABELV $123
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
LABELV $122
byte 1 79
byte 1 66
byte 1 69
byte 1 76
byte 1 73
byte 1 83
byte 1 75
byte 1 0
align 1
LABELV $121
byte 1 49
byte 1 70
byte 1 76
byte 1 65
byte 1 71
byte 1 0
align 1
LABELV $120
byte 1 67
byte 1 84
byte 1 70
byte 1 0
align 1
LABELV $119
byte 1 67
byte 1 65
byte 1 0
align 1
LABELV $118
byte 1 84
byte 1 68
byte 1 77
byte 1 0
align 1
LABELV $117
byte 1 82
byte 1 65
byte 1 67
byte 1 69
byte 1 0
align 1
LABELV $116
byte 1 68
byte 1 85
byte 1 69
byte 1 76
byte 1 0
align 1
LABELV $115
byte 1 70
byte 1 70
byte 1 65
byte 1 0
align 1
LABELV $114
byte 1 0
align 1
LABELV $113
byte 1 65
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $112
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
LABELV $111
byte 1 77
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 53
byte 1 0
align 1
LABELV $110
byte 1 77
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 52
byte 1 0
align 1
LABELV $109
byte 1 77
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 51
byte 1 0
align 1
LABELV $108
byte 1 77
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $107
byte 1 77
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $106
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

data
export mRect
align 4
LABELV mRect
byte 4 0
skip 12
export forceModelModificationCount
align 4
LABELV forceModelModificationCount
byte 4 -1
export enemyModelModificationCount
align 4
LABELV enemyModelModificationCount
byte 4 -1
export enemyColorsModificationCount
align 4
LABELV enemyColorsModificationCount
byte 4 -1
export teamModelModificationCount
align 4
LABELV teamModelModificationCount
byte 4 -1
export teamColorsModificationCount
align 4
LABELV teamColorsModificationCount
byte 4 -1
export gametypeString
align 4
LABELV gametypeString
address $81
address $82
address $83
address $84
address $85
address $86
address $87
address $88
address $89
address $90
address $91
address $92
skip 4
export intShaderTime
align 4
LABELV intShaderTime
byte 4 0
export linearLight
align 4
LABELV linearLight
byte 4 0
export vmMain
code
proc vmMain 16 12
file "..\..\..\..\code\cgame\cg_main.c"
line 56
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_main.c -- initialization and primary entry point for cgame
;4:
;5:#include "cg_local.h"
;6:// display context for new ui stuff
;7:displayContextDef_t cgDC;
;8:
;9:rectDef_t mRect = { 0 };
;10:
;11:int forceModelModificationCount = -1;
;12:int enemyModelModificationCount = -1;
;13:int	enemyColorsModificationCount = -1;
;14:int teamModelModificationCount = -1;
;15:int	teamColorsModificationCount = -1;
;16:
;17:const char *gametypeString[GT_MAX_GAME_TYPE] = {
;18:	"Free For All",
;19:	"Duel",
;20:	"Race",
;21:	"Team Deathmatch",
;22:	"Capture the Flag",
;23:	"One Flag",
;24:	"Overload",
;25:	"Harvester",
;26:	"Freeze Tag",
;27:	"Domination",
;28:	"Attack and Defend",
;29:	"Red Rover" };
;30:
;31:void CG_Init(int serverMessageNum, int serverCommandSequence, int clientNum);
;32:void CG_Shutdown(void);
;33:
;34:// extension interface
;35:qboolean intShaderTime = qfalse;
;36:qboolean linearLight = qfalse;
;37:
;38:#ifdef Q3_VM
;39:qboolean(*trap_GetValue)(char *value, int valueSize, const char *key);
;40:void (*trap_R_AddRefEntityToScene2)(const refEntity_t *re);
;41:void (*trap_R_AddLinearLightToScene)(const vec3_t start, const vec3_t end, float intensity, float r, float g, float b);
;42:#else
;43:int dll_com_trapGetValue;
;44:int dll_trap_R_AddRefEntityToScene2;
;45:int dll_trap_R_AddLinearLightToScene;
;46:#endif
;47:
;48:/*
;49:================
;50:vmMain
;51:
;52:This is the only way control passes into the module.
;53:This must be the very first function compiled into the .q3vm file
;54:================
;55:*/
;56:DLLEXPORT intptr_t vmMain(int command, int arg0, int arg1, int arg2) {
line 58
;57:
;58:	switch (command) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $94
ADDRLP4 0
INDIRI4
CNSTI4 8
GTI4 $94
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $110
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $110
address $96
address $97
address $98
address $99
address $100
address $101
address $102
address $103
address $108
code
LABELV $96
line 60
;59:	case CG_INIT:
;60:		CG_Init(arg0, arg1, arg2);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_Init
CALLV
pop
line 61
;61:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $93
JUMPV
LABELV $97
line 63
;62:	case CG_SHUTDOWN:
;63:		CG_Shutdown();
ADDRGP4 CG_Shutdown
CALLV
pop
line 64
;64:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $93
JUMPV
LABELV $98
line 66
;65:	case CG_CONSOLE_COMMAND:
;66:		return CG_ConsoleCommand();
ADDRLP4 4
ADDRGP4 CG_ConsoleCommand
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $93
JUMPV
LABELV $99
line 68
;67:	case CG_DRAW_ACTIVE_FRAME:
;68:		CG_DrawActiveFrame(arg0, arg1, arg2);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_DrawActiveFrame
CALLV
pop
line 69
;69:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $93
JUMPV
LABELV $100
line 71
;70:	case CG_CROSSHAIR_PLAYER:
;71:		return CG_CrosshairPlayer();
ADDRLP4 8
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $93
JUMPV
LABELV $101
line 73
;72:	case CG_LAST_ATTACKER:
;73:		return CG_LastAttacker();
ADDRLP4 12
ADDRGP4 CG_LastAttacker
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $93
JUMPV
LABELV $102
line 75
;74:	case CG_KEY_EVENT:
;75:		CG_KeyEvent(arg0, arg1);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_KeyEvent
CALLV
pop
line 76
;76:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $93
JUMPV
LABELV $103
line 78
;77:	case CG_MOUSE_EVENT:
;78:		cgDC.cursorx = cgs.cursorX;
ADDRGP4 cgDC+224
ADDRGP4 cgs+146612
INDIRI4
ASGNI4
line 79
;79:		cgDC.cursory = cgs.cursorY;
ADDRGP4 cgDC+228
ADDRGP4 cgs+146616
INDIRI4
ASGNI4
line 80
;80:		CG_MouseEvent(arg0, arg1);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_MouseEvent
CALLV
pop
line 81
;81:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $93
JUMPV
LABELV $108
line 83
;82:	case CG_EVENT_HANDLING:
;83:		CG_EventHandling(arg0);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 CG_EventHandling
CALLV
pop
line 84
;84:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $93
JUMPV
LABELV $94
line 86
;85:	default:
;86:		CG_Error("vmMain: unknown command %i", command);
ADDRGP4 $109
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 87
;87:		break;
LABELV $95
line 89
;88:	}
;89:	return -1;
CNSTI4 -1
RETI4
LABELV $93
endproc vmMain 16 12
data
align 4
LABELV cvarTable
address cg_ignore
address $112
address $113
byte 4 0
address cg_autoswitch
address $114
address $115
byte 4 1
address cg_drawGun
address $116
address $115
byte 4 1
address cg_zoomFov
address $117
address $118
byte 4 1
address cg_fov
address $119
address $120
byte 4 1
address cg_viewsize
address $121
address $122
byte 4 1
address cg_shadows
address $123
address $115
byte 4 1
address cg_gibs
address $124
address $115
byte 4 1
address cg_draw2D
address $125
address $115
byte 4 1
address cg_drawStatus
address $126
address $115
byte 4 1
address cg_drawTimer
address $127
address $113
byte 4 1
address cg_drawFPS
address $128
address $113
byte 4 1
address cg_drawSnapshot
address $129
address $113
byte 4 1
address cg_draw3dIcons
address $130
address $115
byte 4 1
address cg_drawIcons
address $131
address $115
byte 4 1
address cg_drawAmmoWarning
address $132
address $115
byte 4 1
address cg_drawAttacker
address $133
address $115
byte 4 1
address cg_drawSpeed
address $134
address $113
byte 4 1
address cg_drawCrosshair
address $135
address $136
byte 4 1
address cg_drawCrosshairNames
address $137
address $115
byte 4 1
address cg_drawRewards
address $138
address $115
byte 4 1
address cg_drawWeaponSelect
address $139
address $115
byte 4 1
address cg_crosshairSize
address $140
address $141
byte 4 1
address cg_crosshairHealth
address $142
address $115
byte 4 1
address cg_crosshairX
address $143
address $113
byte 4 1
address cg_crosshairY
address $144
address $113
byte 4 1
address cg_brassTime
address $145
address $146
byte 4 1
address cg_simpleItems
address $147
address $113
byte 4 1
address cg_addMarks
address $148
address $115
byte 4 1
address cg_lagometer
address $149
address $115
byte 4 1
address cg_railTrailTime
address $150
address $151
byte 4 1
address cg_railTrailRadius
address $152
address $113
byte 4 1
address cg_gun_frame
address $153
address $154
byte 4 64
address cg_gun_x
address $155
address $113
byte 4 1
address cg_gun_y
address $156
address $113
byte 4 1
address cg_gun_z
address $157
address $113
byte 4 1
address cg_centertime
address $158
address $159
byte 4 512
address cg_runpitch
address $160
address $161
byte 4 1
address cg_runroll
address $162
address $163
byte 4 1
address cg_bobup
address $164
address $163
byte 4 1
address cg_bobpitch
address $165
address $161
byte 4 1
address cg_bobroll
address $166
address $161
byte 4 1
address cg_swingSpeed
address $167
address $168
byte 4 512
address cg_animSpeed
address $169
address $115
byte 4 512
address cg_debugAnim
address $170
address $113
byte 4 512
address cg_debugPosition
address $171
address $113
byte 4 512
address cg_debugEvents
address $172
address $113
byte 4 512
address cg_errorDecay
address $173
address $122
byte 4 0
address cg_nopredict
address $174
address $113
byte 4 0
address cg_noPlayerAnims
address $175
address $113
byte 4 512
address cg_showmiss
address $176
address $113
byte 4 0
address cg_footsteps
address $177
address $115
byte 4 512
address cg_tracerChance
address $178
address $179
byte 4 512
address cg_tracerWidth
address $180
address $115
byte 4 512
address cg_tracerLength
address $181
address $122
byte 4 512
address cg_thirdPersonRange
address $182
address $183
byte 4 512
address cg_thirdPersonAngle
address $184
address $113
byte 4 512
address cg_thirdPerson
address $185
address $113
byte 4 0
address cg_teamChatTime
address $186
address $187
byte 4 1
address cg_teamChatHeight
address $188
address $113
byte 4 1
address cg_forceModel
address $189
address $113
byte 4 1
address cg_predictItems
address $190
address $115
byte 4 1
address cg_deferPlayers
address $191
address $115
byte 4 1
address cg_drawTeamOverlay
address $192
address $113
byte 4 1
address cg_teamOverlayUserinfo
address $193
address $113
byte 4 66
address cg_stats
address $194
address $113
byte 4 0
address cg_drawFriend
address $195
address $115
byte 4 1
address cg_teamChatsOnly
address $196
address $113
byte 4 1
address cg_buildScript
address $197
address $113
byte 4 0
address cg_paused
address $198
address $113
byte 4 64
address cg_blood
address $199
address $115
byte 4 1
address cg_redTeamName
address $200
address $201
byte 4 7
address cg_blueTeamName
address $202
address $203
byte 4 7
address cg_hudFiles
address $204
address $205
byte 4 1
address cg_enableDust
address $206
address $113
byte 4 4
address cg_enableBreath
address $207
address $113
byte 4 4
address cg_obeliskRespawnDelay
address $208
address $209
byte 4 4
address cg_timescaleFadeEnd
address $210
address $115
byte 4 0
address cg_timescaleFadeSpeed
address $211
address $113
byte 4 0
address cg_timescale
address $212
address $115
byte 4 0
address cg_scorePlum
address $213
address $115
byte 4 3
address cg_smoothClients
address $214
address $113
byte 4 3
address cg_cameraMode
address $215
address $113
byte 4 512
address cg_noTaunt
address $216
address $113
byte 4 1
address cg_noProjectileTrail
address $217
address $113
byte 4 1
address cg_smallFont
address $218
address $219
byte 4 1
address cg_bigFont
address $220
address $179
byte 4 1
address cg_oldRail
address $221
address $115
byte 4 1
address cg_oldRocket
address $222
address $115
byte 4 1
address cg_oldPlasma
address $223
address $115
byte 4 1
address cg_trueLightning
address $224
address $225
byte 4 1
address cg_hitSounds
address $226
address $113
byte 4 1
address cg_enemyModel
address $227
address $154
byte 4 1
address cg_enemyColors
address $228
address $154
byte 4 1
address cg_teamModel
address $229
address $154
byte 4 1
address cg_teamColors
address $230
address $154
byte 4 1
address cg_deadBodyDarken
address $231
address $115
byte 4 1
address cg_followKiller
address $232
address $113
byte 4 1
address cg_armorTiered
address $233
address $113
byte 4 0
export CG_RegisterCvars
code
proc CG_RegisterCvars 1036 16
line 124
;90:}
;91:
;92:
;93:cg_t				cg;
;94:cgs_t				cgs;
;95:centity_t			cg_entities[MAX_GENTITIES];
;96:weaponInfo_t		cg_weapons[MAX_WEAPONS];
;97:itemInfo_t			cg_items[MAX_ITEMS];
;98:
;99:#define DECLARE_CG_CVAR
;100:#include "cg_cvar.h"
;101:#undef DECLARE_CG_CVAR
;102:
;103:typedef struct {
;104:	vmCvar_t *vmCvar;
;105:	const char *cvarName;
;106:	const char *defaultString;
;107:	const int	cvarFlags;
;108:} cvarTable_t;
;109:
;110:static const cvarTable_t cvarTable[] = {
;111:
;112:#define CG_CVAR_LIST
;113:	#include "cg_cvar.h"
;114:#undef CG_CVAR_LIST
;115:
;116:};
;117:
;118:
;119:/*
;120:=================
;121:CG_RegisterCvars
;122:=================
;123:*/
;124:void CG_RegisterCvars(void) {
line 129
;125:	int			i;
;126:	const cvarTable_t *cv;
;127:	char		var[MAX_TOKEN_CHARS];
;128:
;129:	for (i = 0, cv = cvarTable; i < ARRAY_LEN(cvarTable); i++, cv++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $238
JUMPV
LABELV $235
line 130
;130:		trap_Cvar_Register(cv->vmCvar, cv->cvarName,
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
line 132
;131:			cv->defaultString, cv->cvarFlags);
;132:	}
LABELV $236
line 129
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
LABELV $238
ADDRLP4 4
INDIRI4
CVIU4 4
CNSTU4 99
LTU4 $235
line 135
;133:
;134:	// see if we are also running the server on this machine
;135:	trap_Cvar_VariableStringBuffer("sv_running", var, sizeof(var));
ADDRGP4 $239
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 136
;136:	cgs.localServer = atoi(var);
ADDRLP4 8
ARGP4
ADDRLP4 1032
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31476
ADDRLP4 1032
INDIRI4
ASGNI4
line 138
;137:
;138:	forceModelModificationCount = cg_forceModel.modificationCount;
ADDRGP4 forceModelModificationCount
ADDRGP4 cg_forceModel+4
INDIRI4
ASGNI4
line 139
;139:	enemyModelModificationCount = cg_enemyModel.modificationCount;
ADDRGP4 enemyModelModificationCount
ADDRGP4 cg_enemyModel+4
INDIRI4
ASGNI4
line 140
;140:	enemyColorsModificationCount = cg_enemyColors.modificationCount;
ADDRGP4 enemyColorsModificationCount
ADDRGP4 cg_enemyColors+4
INDIRI4
ASGNI4
line 141
;141:	teamModelModificationCount = cg_teamModel.modificationCount;
ADDRGP4 teamModelModificationCount
ADDRGP4 cg_teamModel+4
INDIRI4
ASGNI4
line 142
;142:	teamColorsModificationCount = cg_teamColors.modificationCount;
ADDRGP4 teamColorsModificationCount
ADDRGP4 cg_teamColors+4
INDIRI4
ASGNI4
line 145
;143:
;144:
;145:	trap_Cvar_Register(NULL, "model", DEFAULT_MODEL, CVAR_USERINFO | CVAR_ARCHIVE);
CNSTP4 0
ARGP4
ADDRGP4 $246
ARGP4
ADDRGP4 $247
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 146
;146:	trap_Cvar_Register(NULL, "headmodel", DEFAULT_MODEL, CVAR_USERINFO | CVAR_ARCHIVE);
CNSTP4 0
ARGP4
ADDRGP4 $248
ARGP4
ADDRGP4 $247
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 149
;147:	//trap_Cvar_Register(NULL, "team_model", DEFAULT_TEAM_MODEL, CVAR_USERINFO | CVAR_ARCHIVE );
;148:	//trap_Cvar_Register(NULL, "team_headmodel", DEFAULT_TEAM_HEAD, CVAR_USERINFO | CVAR_ARCHIVE );
;149:}
LABELV $234
endproc CG_RegisterCvars 1036 16
export CG_ForceModelChange
proc CG_ForceModelChange 12 4
line 157
;150:
;151:
;152:/*
;153:===================
;154:CG_ForceModelChange
;155:===================
;156:*/
;157:void CG_ForceModelChange(void) {
line 161
;158:	const char *clientInfo;
;159:	int	i;
;160:
;161:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $250
line 162
;162:		clientInfo = CG_ConfigString(CS_PLAYERS + i);
ADDRLP4 0
INDIRI4
CNSTI4 529
ADDI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 163
;163:		if (!clientInfo[0]) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $254
line 164
;164:			continue;
ADDRGP4 $251
JUMPV
LABELV $254
line 166
;165:		}
;166:		CG_NewClientInfo(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_NewClientInfo
CALLV
pop
line 167
;167:	}
LABELV $251
line 161
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $250
line 168
;168:}
LABELV $249
endproc CG_ForceModelChange 12 4
export CG_UpdateCvars
proc CG_UpdateCvars 8 8
line 176
;169:
;170:
;171:/*
;172:=================
;173:CG_UpdateCvars
;174:=================
;175:*/
;176:void CG_UpdateCvars(void) {
line 180
;177:	int			i;
;178:	const cvarTable_t *cv;
;179:
;180:	for (i = 0, cv = cvarTable; i < ARRAY_LEN(cvarTable); i++, cv++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 4
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $260
JUMPV
LABELV $257
line 181
;181:		trap_Cvar_Update(cv->vmCvar);
ADDRLP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 182
;182:	}
LABELV $258
line 180
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
LABELV $260
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 99
LTU4 $257
line 188
;183:
;184:	// check for modications here
;185:
;186:	// If team overlay is on, ask for updates from the server.  If its off,
;187:	// let the server know so we don't receive it
;188:	if (drawTeamOverlayModificationCount != cg_drawTeamOverlay.modificationCount) {
ADDRGP4 drawTeamOverlayModificationCount
INDIRI4
ADDRGP4 cg_drawTeamOverlay+4
INDIRI4
EQI4 $261
line 189
;189:		drawTeamOverlayModificationCount = cg_drawTeamOverlay.modificationCount;
ADDRGP4 drawTeamOverlayModificationCount
ADDRGP4 cg_drawTeamOverlay+4
INDIRI4
ASGNI4
line 198
;190:#if 0
;191:		if (cg_drawTeamOverlay.integer > 0) {
;192:			trap_Cvar_Set("teamoverlay", "1");
;193:		} else {
;194:			trap_Cvar_Set("teamoverlay", "0");
;195:		}
;196:#endif
;197:		// FIXME E3 HACK
;198:		trap_Cvar_Set("teamoverlay", "1");
ADDRGP4 $193
ARGP4
ADDRGP4 $115
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 199
;199:	}
LABELV $261
line 202
;200:
;201:	// if model changed
;202:	if (forceModelModificationCount != cg_forceModel.modificationCount
ADDRGP4 forceModelModificationCount
INDIRI4
ADDRGP4 cg_forceModel+4
INDIRI4
NEI4 $275
ADDRGP4 enemyModelModificationCount
INDIRI4
ADDRGP4 cg_enemyModel+4
INDIRI4
NEI4 $275
ADDRGP4 enemyColorsModificationCount
INDIRI4
ADDRGP4 cg_enemyColors+4
INDIRI4
NEI4 $275
ADDRGP4 teamModelModificationCount
INDIRI4
ADDRGP4 cg_teamModel+4
INDIRI4
NEI4 $275
ADDRGP4 teamColorsModificationCount
INDIRI4
ADDRGP4 cg_teamColors+4
INDIRI4
EQI4 $265
LABELV $275
line 206
;203:		|| enemyModelModificationCount != cg_enemyModel.modificationCount
;204:		|| enemyColorsModificationCount != cg_enemyColors.modificationCount
;205:		|| teamModelModificationCount != cg_teamModel.modificationCount
;206:		|| teamColorsModificationCount != cg_teamColors.modificationCount) {
line 208
;207:
;208:		forceModelModificationCount = cg_forceModel.modificationCount;
ADDRGP4 forceModelModificationCount
ADDRGP4 cg_forceModel+4
INDIRI4
ASGNI4
line 209
;209:		enemyModelModificationCount = cg_enemyModel.modificationCount;
ADDRGP4 enemyModelModificationCount
ADDRGP4 cg_enemyModel+4
INDIRI4
ASGNI4
line 210
;210:		enemyColorsModificationCount = cg_enemyColors.modificationCount;
ADDRGP4 enemyColorsModificationCount
ADDRGP4 cg_enemyColors+4
INDIRI4
ASGNI4
line 211
;211:		teamModelModificationCount = cg_teamModel.modificationCount;
ADDRGP4 teamModelModificationCount
ADDRGP4 cg_teamModel+4
INDIRI4
ASGNI4
line 212
;212:		teamColorsModificationCount = cg_teamColors.modificationCount;
ADDRGP4 teamColorsModificationCount
ADDRGP4 cg_teamColors+4
INDIRI4
ASGNI4
line 214
;213:
;214:		CG_ForceModelChange();
ADDRGP4 CG_ForceModelChange
CALLV
pop
line 215
;215:	}
LABELV $265
line 216
;216:}
LABELV $256
endproc CG_UpdateCvars 8 8
export CG_CrosshairPlayer
proc CG_CrosshairPlayer 0 0
line 219
;217:
;218:
;219:int CG_CrosshairPlayer(void) {
line 220
;220:	if (cg.time > (cg.crosshairClientTime + 1000)) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+125476
INDIRI4
CNSTI4 1000
ADDI4
LEI4 $282
line 221
;221:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $281
JUMPV
LABELV $282
line 223
;222:	}
;223:	return cg.crosshairClientNum;
ADDRGP4 cg+125472
INDIRI4
RETI4
LABELV $281
endproc CG_CrosshairPlayer 0 0
export CG_LastAttacker
proc CG_LastAttacker 0 0
line 226
;224:}
;225:
;226:int CG_LastAttacker(void) {
line 227
;227:	if (!cg.attackerTime) {
ADDRGP4 cg+125524
INDIRI4
CNSTI4 0
NEI4 $288
line 228
;228:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $287
JUMPV
LABELV $288
line 230
;229:	}
;230:	return cg.snap->ps.persistant[PERS_ATTACKER];
ADDRGP4 cg+36
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
RETI4
LABELV $287
endproc CG_LastAttacker 0 0
export CG_Printf
proc CG_Printf 1028 12
line 233
;231:}
;232:
;233:void QDECL CG_Printf(const char *msg, ...) {
line 237
;234:	va_list		argptr;
;235:	char		text[1024];
;236:
;237:	va_start(argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 238
;238:	ED_vsprintf(text, msg, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ED_vsprintf
CALLI4
pop
line 239
;239:	va_end(argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 241
;240:
;241:	trap_Print(text);
ADDRLP4 4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 242
;242:}
LABELV $292
endproc CG_Printf 1028 12
export CG_Error
proc CG_Error 1028 12
line 244
;243:
;244:void QDECL CG_Error(const char *msg, ...) {
line 248
;245:	va_list		argptr;
;246:	char		text[1024];
;247:
;248:	va_start(argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 249
;249:	ED_vsprintf(text, msg, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ED_vsprintf
CALLI4
pop
line 250
;250:	va_end(argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 252
;251:
;252:	trap_Error(text);
ADDRLP4 4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 253
;253:}
LABELV $294
endproc CG_Error 1028 12
export Com_Error
proc Com_Error 1028 12
line 258
;254:
;255:#ifndef CGAME_HARD_LINKED
;256:// this is only here so the functions in q_shared.c and bg_*.c can link (FIXME)
;257:
;258:void QDECL Com_Error(int level, const char *error, ...) {
line 262
;259:	va_list		argptr;
;260:	char		text[1024];
;261:
;262:	va_start(argptr, error);
ADDRLP4 0
ADDRFP4 4+4
ASGNP4
line 263
;263:	ED_vsprintf(text, error, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ED_vsprintf
CALLI4
pop
line 264
;264:	va_end(argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 266
;265:
;266:	trap_Error(text);
ADDRLP4 4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 267
;267:}
LABELV $296
endproc Com_Error 1028 12
export Com_Printf
proc Com_Printf 1028 12
line 269
;268:
;269:void QDECL Com_Printf(const char *msg, ...) {
line 273
;270:	va_list		argptr;
;271:	char		text[1024];
;272:
;273:	va_start(argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 274
;274:	ED_vsprintf(text, msg, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ED_vsprintf
CALLI4
pop
line 275
;275:	va_end(argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 277
;276:
;277:	trap_Print(text);
ADDRLP4 4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 278
;278:}
LABELV $298
endproc Com_Printf 1028 12
bss
align 1
LABELV $301
skip 2048
data
align 4
LABELV $302
byte 4 0
export CG_Argv
code
proc CG_Argv 4 12
line 287
;279:
;280:#endif
;281:
;282:/*
;283:================
;284:CG_Argv
;285:================
;286:*/
;287:const char *CG_Argv(int arg) {
line 291
;288:	static char	buffer[2][MAX_STRING_CHARS];
;289:	static int index = 0;
;290:
;291:	index ^= 1;
ADDRLP4 0
ADDRGP4 $302
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 292
;292:	trap_Argv(arg, buffer[index], sizeof(buffer[0]));
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $302
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 $301
ADDP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 294
;293:
;294:	return buffer[index];
ADDRGP4 $302
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 $301
ADDP4
RETP4
LABELV $300
endproc CG_Argv 4 12
proc CG_RegisterItemSounds 96 12
line 307
;295:}
;296:
;297:
;298://========================================================================
;299:
;300:/*
;301:=================
;302:CG_RegisterItemSounds
;303:
;304:The server says this item is used on this level
;305:=================
;306:*/
;307:static void CG_RegisterItemSounds(int itemNum) {
line 313
;308:	gitem_t *item;
;309:	char			data[MAX_QPATH];
;310:	const char *s, *start;
;311:	int				len;
;312:
;313:	item = &bg_itemlist[itemNum];
ADDRLP4 76
ADDRFP4 0
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 315
;314:
;315:	if (item->pickup_sound) {
ADDRLP4 76
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $304
line 316
;316:		trap_S_RegisterSound(item->pickup_sound, qfalse);
ADDRLP4 76
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 317
;317:	}
LABELV $304
line 320
;318:
;319:	// parse the space seperated precache string for other media
;320:	s = item->sounds;
ADDRLP4 0
ADDRLP4 76
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
ASGNP4
line 321
;321:	if (!s || !s[0])
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $308
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $310
LABELV $308
line 322
;322:		return;
ADDRGP4 $303
JUMPV
LABELV $309
line 324
;323:
;324:	while (*s) {
line 325
;325:		start = s;
ADDRLP4 72
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $313
JUMPV
LABELV $312
line 326
;326:		while (*s && *s != ' ') {
line 327
;327:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 328
;328:		}
LABELV $313
line 326
ADDRLP4 84
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $315
ADDRLP4 84
INDIRI4
CNSTI4 32
NEI4 $312
LABELV $315
line 330
;329:
;330:		len = s - start;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 72
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 331
;331:		if (len >= MAX_QPATH || len < 5) {
ADDRLP4 4
INDIRI4
CNSTI4 64
GEI4 $318
ADDRLP4 4
INDIRI4
CNSTI4 5
GEI4 $316
LABELV $318
line 332
;332:			CG_Error("PrecacheItem: %s has bad precache string",
ADDRGP4 $319
ARGP4
ADDRLP4 76
INDIRP4
INDIRP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 334
;333:				item->classname);
;334:			return;
ADDRGP4 $303
JUMPV
LABELV $316
line 336
;335:		}
;336:		memcpy(data, start, len);
ADDRLP4 8
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 337
;337:		data[len] = 0;
ADDRLP4 4
INDIRI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 338
;338:		if (*s) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $320
line 339
;339:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 340
;340:		}
LABELV $320
line 342
;341:
;342:		if (!strcmp(data + len - 3, "wav")) {
ADDRLP4 4
INDIRI4
ADDRLP4 8-3
ADDP4
ARGP4
ADDRGP4 $325
ARGP4
ADDRLP4 92
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $322
line 343
;343:			trap_S_RegisterSound(data, qfalse);
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 344
;344:		}
LABELV $322
line 345
;345:	}
LABELV $310
line 324
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $309
line 346
;346:}
LABELV $303
endproc CG_RegisterItemSounds 96 12
proc CG_RegisterSounds 712 16
line 356
;347:
;348:
;349:/*
;350:=================
;351:CG_RegisterSounds
;352:
;353:called during a precache command
;354:=================
;355:*/
;356:static void CG_RegisterSounds(void) {
line 362
;357:	int		i;
;358:	char	items[MAX_ITEMS + 1];
;359:	char	name[MAX_QPATH];
;360:	const char *soundName;
;361:
;362:	cgs.media.oneMinuteSound = trap_S_RegisterSound("sound/feedback/1_minute.wav", qtrue);
ADDRGP4 $329
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 332
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+996
ADDRLP4 332
INDIRI4
ASGNI4
line 363
;363:	cgs.media.fiveMinuteSound = trap_S_RegisterSound("sound/feedback/5_minute.wav", qtrue);
ADDRGP4 $332
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 336
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1000
ADDRLP4 336
INDIRI4
ASGNI4
line 364
;364:	cgs.media.suddenDeathSound = trap_S_RegisterSound("sound/feedback/sudden_death.wav", qtrue);
ADDRGP4 $335
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 340
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1004
ADDRLP4 340
INDIRI4
ASGNI4
line 365
;365:	cgs.media.oneFragSound = trap_S_RegisterSound("sound/feedback/1_frag.wav", qtrue);
ADDRGP4 $338
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 344
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1016
ADDRLP4 344
INDIRI4
ASGNI4
line 366
;366:	cgs.media.twoFragSound = trap_S_RegisterSound("sound/feedback/2_frags.wav", qtrue);
ADDRGP4 $341
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 348
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1012
ADDRLP4 348
INDIRI4
ASGNI4
line 367
;367:	cgs.media.threeFragSound = trap_S_RegisterSound("sound/feedback/3_frags.wav", qtrue);
ADDRGP4 $344
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 352
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1008
ADDRLP4 352
INDIRI4
ASGNI4
line 368
;368:	cgs.media.count3Sound = trap_S_RegisterSound("sound/feedback/three.wav", qtrue);
ADDRGP4 $347
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 356
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1220
ADDRLP4 356
INDIRI4
ASGNI4
line 369
;369:	cgs.media.count2Sound = trap_S_RegisterSound("sound/feedback/two.wav", qtrue);
ADDRGP4 $350
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 360
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1224
ADDRLP4 360
INDIRI4
ASGNI4
line 370
;370:	cgs.media.count1Sound = trap_S_RegisterSound("sound/feedback/one.wav", qtrue);
ADDRGP4 $353
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 364
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1228
ADDRLP4 364
INDIRI4
ASGNI4
line 371
;371:	cgs.media.countFightSound = trap_S_RegisterSound("sound/feedback/fight.wav", qtrue);
ADDRGP4 $356
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 368
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1232
ADDRLP4 368
INDIRI4
ASGNI4
line 372
;372:	cgs.media.countPrepareSound = trap_S_RegisterSound("sound/feedback/prepare.wav", qtrue);
ADDRGP4 $359
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 372
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1236
ADDRLP4 372
INDIRI4
ASGNI4
line 373
;373:	cgs.media.countPrepareTeamSound = trap_S_RegisterSound("sound/feedback/prepare_team.wav", qtrue);
ADDRGP4 $362
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 376
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1252
ADDRLP4 376
INDIRI4
ASGNI4
line 375
;374:
;375:	if (cgs.gametype >= GT_TEAM || cg_buildScript.integer) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
GEI4 $367
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $363
LABELV $367
line 377
;376:
;377:		cgs.media.captureAwardSound = trap_S_RegisterSound("sound/teamplay/flagcapture_yourteam.wav", qtrue);
ADDRGP4 $370
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 380
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1132
ADDRLP4 380
INDIRI4
ASGNI4
line 378
;378:		cgs.media.redLeadsSound = trap_S_RegisterSound("sound/feedback/redleads.wav", qtrue);
ADDRGP4 $373
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 384
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1144
ADDRLP4 384
INDIRI4
ASGNI4
line 379
;379:		cgs.media.blueLeadsSound = trap_S_RegisterSound("sound/feedback/blueleads.wav", qtrue);
ADDRGP4 $376
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 388
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1148
ADDRLP4 388
INDIRI4
ASGNI4
line 380
;380:		cgs.media.teamsTiedSound = trap_S_RegisterSound("sound/feedback/teamstied.wav", qtrue);
ADDRGP4 $379
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 392
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1152
ADDRLP4 392
INDIRI4
ASGNI4
line 381
;381:		cgs.media.hitTeamSound = trap_S_RegisterSound("sound/feedback/hit_teammate.wav", qtrue);
ADDRGP4 $382
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 396
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1048
ADDRLP4 396
INDIRI4
ASGNI4
line 383
;382:
;383:		cgs.media.redScoredSound = trap_S_RegisterSound("sound/teamplay/voc_red_scores.wav", qtrue);
ADDRGP4 $385
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 400
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1136
ADDRLP4 400
INDIRI4
ASGNI4
line 384
;384:		cgs.media.blueScoredSound = trap_S_RegisterSound("sound/teamplay/voc_blue_scores.wav", qtrue);
ADDRGP4 $388
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 404
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1140
ADDRLP4 404
INDIRI4
ASGNI4
line 386
;385:
;386:		cgs.media.captureYourTeamSound = trap_S_RegisterSound("sound/teamplay/flagcapture_yourteam.wav", qtrue);
ADDRGP4 $370
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 408
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1156
ADDRLP4 408
INDIRI4
ASGNI4
line 387
;387:		cgs.media.captureOpponentSound = trap_S_RegisterSound("sound/teamplay/flagcapture_opponent.wav", qtrue);
ADDRGP4 $393
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 412
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1160
ADDRLP4 412
INDIRI4
ASGNI4
line 389
;388:
;389:		cgs.media.returnYourTeamSound = trap_S_RegisterSound("sound/teamplay/flagreturn_yourteam.wav", qtrue);
ADDRGP4 $396
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 416
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1164
ADDRLP4 416
INDIRI4
ASGNI4
line 390
;390:		cgs.media.returnOpponentSound = trap_S_RegisterSound("sound/teamplay/flagreturn_opponent.wav", qtrue);
ADDRGP4 $399
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 420
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1168
ADDRLP4 420
INDIRI4
ASGNI4
line 392
;391:
;392:		cgs.media.takenYourTeamSound = trap_S_RegisterSound("sound/teamplay/flagtaken_yourteam.wav", qtrue);
ADDRGP4 $402
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 424
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1172
ADDRLP4 424
INDIRI4
ASGNI4
line 393
;393:		cgs.media.takenOpponentSound = trap_S_RegisterSound("sound/teamplay/flagtaken_opponent.wav", qtrue);
ADDRGP4 $405
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 428
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1176
ADDRLP4 428
INDIRI4
ASGNI4
line 395
;394:
;395:		if (cgs.gametype == GT_CTF || cg_buildScript.integer) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
EQI4 $410
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $406
LABELV $410
line 396
;396:			cgs.media.redFlagReturnedSound = trap_S_RegisterSound("sound/teamplay/voc_red_returned.wav", qtrue);
ADDRGP4 $413
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 432
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1180
ADDRLP4 432
INDIRI4
ASGNI4
line 397
;397:			cgs.media.blueFlagReturnedSound = trap_S_RegisterSound("sound/teamplay/voc_blue_returned.wav", qtrue);
ADDRGP4 $416
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 436
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1184
ADDRLP4 436
INDIRI4
ASGNI4
line 398
;398:			cgs.media.enemyTookYourFlagSound = trap_S_RegisterSound("sound/teamplay/voc_enemy_flag.wav", qtrue);
ADDRGP4 $419
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 440
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1192
ADDRLP4 440
INDIRI4
ASGNI4
line 399
;399:			cgs.media.yourTeamTookEnemyFlagSound = trap_S_RegisterSound("sound/teamplay/voc_team_flag.wav", qtrue);
ADDRGP4 $422
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 444
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1200
ADDRLP4 444
INDIRI4
ASGNI4
line 400
;400:		}
LABELV $406
line 402
;401:
;402:		if (cgs.gametype == GT_ONEFLAG || cg_buildScript.integer) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 6
EQI4 $427
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $423
LABELV $427
line 404
;403:			// FIXME: get a replacement for this sound ?
;404:			cgs.media.neutralFlagReturnedSound = trap_S_RegisterSound("sound/teamplay/flagreturn_opponent.wav", qtrue);
ADDRGP4 $399
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 432
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1188
ADDRLP4 432
INDIRI4
ASGNI4
line 405
;405:			cgs.media.yourTeamTookTheFlagSound = trap_S_RegisterSound("sound/teamplay/voc_team_1flag.wav", qtrue);
ADDRGP4 $432
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 436
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1204
ADDRLP4 436
INDIRI4
ASGNI4
line 406
;406:			cgs.media.enemyTookTheFlagSound = trap_S_RegisterSound("sound/teamplay/voc_enemy_1flag.wav", qtrue);
ADDRGP4 $435
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 440
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1196
ADDRLP4 440
INDIRI4
ASGNI4
line 407
;407:		}
LABELV $423
line 409
;408:
;409:		if (cgs.gametype == GT_ONEFLAG || cgs.gametype == GT_CTF || cg_buildScript.integer) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 6
EQI4 $442
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
EQI4 $442
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $436
LABELV $442
line 410
;410:			cgs.media.youHaveFlagSound = trap_S_RegisterSound("sound/teamplay/voc_you_flag.wav", qtrue);
ADDRGP4 $445
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 432
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1208
ADDRLP4 432
INDIRI4
ASGNI4
line 411
;411:			cgs.media.holyShitSound = trap_S_RegisterSound("sound/feedback/voc_holyshit.wav", qtrue);
ADDRGP4 $448
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 436
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1216
ADDRLP4 436
INDIRI4
ASGNI4
line 412
;412:		}
LABELV $436
line 414
;413:
;414:		if (cgs.gametype == GT_OBELISK || cg_buildScript.integer) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 7
EQI4 $453
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $449
LABELV $453
line 415
;415:			cgs.media.yourBaseIsUnderAttackSound = trap_S_RegisterSound("sound/teamplay/voc_base_attack.wav", qtrue);
ADDRGP4 $456
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 432
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1212
ADDRLP4 432
INDIRI4
ASGNI4
line 416
;416:		}
LABELV $449
line 417
;417:		cgs.media.neutralFlagReturnedSound = trap_S_RegisterSound("sound/teamplay/flagreturn_opponent.wav", qtrue);
ADDRGP4 $399
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 432
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1188
ADDRLP4 432
INDIRI4
ASGNI4
line 418
;418:		cgs.media.youHaveFlagSound = trap_S_RegisterSound("sound/teamplay/voc_you_flag.wav", qtrue);
ADDRGP4 $445
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 436
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1208
ADDRLP4 436
INDIRI4
ASGNI4
line 419
;419:		cgs.media.holyShitSound = trap_S_RegisterSound("sound/feedback/voc_holyshit.wav", qtrue);
ADDRGP4 $448
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 440
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1216
ADDRLP4 440
INDIRI4
ASGNI4
line 420
;420:		cgs.media.yourTeamTookTheFlagSound = trap_S_RegisterSound("sound/teamplay/voc_team_1flag.wav", qtrue);
ADDRGP4 $432
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 444
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1204
ADDRLP4 444
INDIRI4
ASGNI4
line 421
;421:		cgs.media.enemyTookTheFlagSound = trap_S_RegisterSound("sound/teamplay/voc_enemy_1flag.wav", qtrue);
ADDRGP4 $435
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 448
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1196
ADDRLP4 448
INDIRI4
ASGNI4
line 422
;422:	}
LABELV $363
line 424
;423:
;424:	cgs.media.tracerSound = trap_S_RegisterSound("sound/weapons/machinegun/buletby1.wav", qfalse);
ADDRGP4 $469
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 380
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+704
ADDRLP4 380
INDIRI4
ASGNI4
line 425
;425:	cgs.media.selectSound = trap_S_RegisterSound("sound/weapons/change.wav", qfalse);
ADDRGP4 $472
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 384
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+708
ADDRLP4 384
INDIRI4
ASGNI4
line 426
;426:	cgs.media.wearOffSound = trap_S_RegisterSound("sound/items/wearoff.wav", qfalse);
ADDRGP4 $475
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 388
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+716
ADDRLP4 388
INDIRI4
ASGNI4
line 427
;427:	cgs.media.useNothingSound = trap_S_RegisterSound("sound/items/use_nothing.wav", qfalse);
ADDRGP4 $478
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 392
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+712
ADDRLP4 392
INDIRI4
ASGNI4
line 428
;428:	cgs.media.gibSound = trap_S_RegisterSound("sound/player/gibsplt1.wav", qfalse);
ADDRGP4 $481
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 396
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+952
ADDRLP4 396
INDIRI4
ASGNI4
line 429
;429:	cgs.media.gibBounce1Sound = trap_S_RegisterSound("sound/player/gibimp1.wav", qfalse);
ADDRGP4 $484
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 400
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+956
ADDRLP4 400
INDIRI4
ASGNI4
line 430
;430:	cgs.media.gibBounce2Sound = trap_S_RegisterSound("sound/player/gibimp2.wav", qfalse);
ADDRGP4 $487
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 404
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+960
ADDRLP4 404
INDIRI4
ASGNI4
line 431
;431:	cgs.media.gibBounce3Sound = trap_S_RegisterSound("sound/player/gibimp3.wav", qfalse);
ADDRGP4 $490
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 408
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+964
ADDRLP4 408
INDIRI4
ASGNI4
line 433
;432:
;433:	cgs.media.useInvulnerabilitySound = trap_S_RegisterSound("sound/items/invul_activate.wav", qfalse);
ADDRGP4 $493
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 412
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+908
ADDRLP4 412
INDIRI4
ASGNI4
line 434
;434:	cgs.media.invulnerabilityImpactSound1 = trap_S_RegisterSound("sound/items/invul_impact_01.wav", qfalse);
ADDRGP4 $496
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 416
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+912
ADDRLP4 416
INDIRI4
ASGNI4
line 435
;435:	cgs.media.invulnerabilityImpactSound2 = trap_S_RegisterSound("sound/items/invul_impact_02.wav", qfalse);
ADDRGP4 $499
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 420
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+916
ADDRLP4 420
INDIRI4
ASGNI4
line 436
;436:	cgs.media.invulnerabilityImpactSound3 = trap_S_RegisterSound("sound/items/invul_impact_03.wav", qfalse);
ADDRGP4 $502
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 424
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+920
ADDRLP4 424
INDIRI4
ASGNI4
line 437
;437:	cgs.media.invulnerabilityJuicedSound = trap_S_RegisterSound("sound/items/invul_juiced.wav", qfalse);
ADDRGP4 $505
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 428
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+924
ADDRLP4 428
INDIRI4
ASGNI4
line 438
;438:	cgs.media.obeliskHitSound1 = trap_S_RegisterSound("sound/items/obelisk_hit_01.wav", qfalse);
ADDRGP4 $508
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 432
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+928
ADDRLP4 432
INDIRI4
ASGNI4
line 439
;439:	cgs.media.obeliskHitSound2 = trap_S_RegisterSound("sound/items/obelisk_hit_02.wav", qfalse);
ADDRGP4 $511
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 436
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+932
ADDRLP4 436
INDIRI4
ASGNI4
line 440
;440:	cgs.media.obeliskHitSound3 = trap_S_RegisterSound("sound/items/obelisk_hit_03.wav", qfalse);
ADDRGP4 $514
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 440
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+936
ADDRLP4 440
INDIRI4
ASGNI4
line 441
;441:	cgs.media.obeliskRespawnSound = trap_S_RegisterSound("sound/items/obelisk_respawn.wav", qfalse);
ADDRGP4 $517
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 444
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+940
ADDRLP4 444
INDIRI4
ASGNI4
line 443
;442:
;443:	cgs.media.ammoregenSound = trap_S_RegisterSound("sound/items/cl_ammoregen.wav", qfalse);
ADDRGP4 $520
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 448
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1256
ADDRLP4 448
INDIRI4
ASGNI4
line 444
;444:	cgs.media.doublerSound = trap_S_RegisterSound("sound/items/cl_doubler.wav", qfalse);
ADDRGP4 $523
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 452
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1260
ADDRLP4 452
INDIRI4
ASGNI4
line 445
;445:	cgs.media.guardSound = trap_S_RegisterSound("sound/items/cl_guard.wav", qfalse);
ADDRGP4 $526
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 456
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1264
ADDRLP4 456
INDIRI4
ASGNI4
line 446
;446:	cgs.media.scoutSound = trap_S_RegisterSound("sound/items/cl_scout.wav", qfalse);
ADDRGP4 $529
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 460
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1268
ADDRLP4 460
INDIRI4
ASGNI4
line 448
;447:
;448:	cgs.media.teleInSound = trap_S_RegisterSound("sound/world/telein.wav", qfalse);
ADDRGP4 $532
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 464
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+968
ADDRLP4 464
INDIRI4
ASGNI4
line 449
;449:	cgs.media.teleOutSound = trap_S_RegisterSound("sound/world/teleout.wav", qfalse);
ADDRGP4 $535
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 468
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+972
ADDRLP4 468
INDIRI4
ASGNI4
line 450
;450:	cgs.media.respawnSound = trap_S_RegisterSound("sound/items/respawn1.wav", qfalse);
ADDRGP4 $538
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 472
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+980
ADDRLP4 472
INDIRI4
ASGNI4
line 452
;451:
;452:	cgs.media.noAmmoSound = trap_S_RegisterSound("sound/weapons/noammo.wav", qfalse);
ADDRGP4 $541
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 476
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+976
ADDRLP4 476
INDIRI4
ASGNI4
line 454
;453:
;454:	cgs.media.talkSound = trap_S_RegisterSound("sound/player/talk.wav", qfalse);
ADDRGP4 $544
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 480
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+984
ADDRLP4 480
INDIRI4
ASGNI4
line 455
;455:	cgs.media.landSound = trap_S_RegisterSound("sound/player/land1.wav", qfalse);
ADDRGP4 $547
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 484
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+988
ADDRLP4 484
INDIRI4
ASGNI4
line 457
;456:
;457:	cgs.media.hitSounds[0] = trap_S_RegisterSound("sound/feedback/hit25.wav", qfalse);
ADDRGP4 $550
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 488
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1024
ADDRLP4 488
INDIRI4
ASGNI4
line 458
;458:	cgs.media.hitSounds[1] = trap_S_RegisterSound("sound/feedback/hit50.wav", qfalse);
ADDRGP4 $554
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 492
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1024+4
ADDRLP4 492
INDIRI4
ASGNI4
line 459
;459:	cgs.media.hitSounds[2] = trap_S_RegisterSound("sound/feedback/hit75.wav", qfalse);
ADDRGP4 $558
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 496
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1024+8
ADDRLP4 496
INDIRI4
ASGNI4
line 460
;460:	cgs.media.hitSounds[3] = trap_S_RegisterSound("sound/feedback/hit100.wav", qfalse);
ADDRGP4 $562
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 500
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1024+12
ADDRLP4 500
INDIRI4
ASGNI4
line 462
;461:
;462:	cgs.media.hitSound = trap_S_RegisterSound("sound/feedback/hit.wav", qfalse);
ADDRGP4 $565
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 504
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1020
ADDRLP4 504
INDIRI4
ASGNI4
line 464
;463:
;464:	cgs.media.hitSoundHighArmor = trap_S_RegisterSound("sound/feedback/hithi.wav", qfalse);
ADDRGP4 $568
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 508
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1040
ADDRLP4 508
INDIRI4
ASGNI4
line 465
;465:	cgs.media.hitSoundLowArmor = trap_S_RegisterSound("sound/feedback/hitlo.wav", qfalse);
ADDRGP4 $571
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 512
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1044
ADDRLP4 512
INDIRI4
ASGNI4
line 467
;466:
;467:	cgs.media.impressiveSound = trap_S_RegisterSound("sound/feedback/impressive.wav", qtrue);
ADDRGP4 $574
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 516
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1052
ADDRLP4 516
INDIRI4
ASGNI4
line 468
;468:	cgs.media.excellentSound = trap_S_RegisterSound("sound/feedback/excellent.wav", qtrue);
ADDRGP4 $577
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 520
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1056
ADDRLP4 520
INDIRI4
ASGNI4
line 469
;469:	cgs.media.deniedSound = trap_S_RegisterSound("sound/feedback/denied.wav", qtrue);
ADDRGP4 $580
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 524
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1060
ADDRLP4 524
INDIRI4
ASGNI4
line 470
;470:	cgs.media.humiliationSound = trap_S_RegisterSound("sound/feedback/humiliation.wav", qtrue);
ADDRGP4 $583
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 528
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1064
ADDRLP4 528
INDIRI4
ASGNI4
line 471
;471:	cgs.media.assistSound = trap_S_RegisterSound("sound/feedback/assist.wav", qtrue);
ADDRGP4 $586
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 532
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1068
ADDRLP4 532
INDIRI4
ASGNI4
line 472
;472:	cgs.media.defendSound = trap_S_RegisterSound("sound/feedback/defense.wav", qtrue);
ADDRGP4 $589
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 536
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1072
ADDRLP4 536
INDIRI4
ASGNI4
line 473
;473:	cgs.media.firstImpressiveSound = trap_S_RegisterSound("sound/feedback/first_impressive.wav", qtrue);
ADDRGP4 $592
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 540
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1076
ADDRLP4 540
INDIRI4
ASGNI4
line 474
;474:	cgs.media.firstExcellentSound = trap_S_RegisterSound("sound/feedback/first_excellent.wav", qtrue);
ADDRGP4 $595
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 544
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1080
ADDRLP4 544
INDIRI4
ASGNI4
line 475
;475:	cgs.media.firstHumiliationSound = trap_S_RegisterSound("sound/feedback/first_gauntlet.wav", qtrue);
ADDRGP4 $598
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 548
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1084
ADDRLP4 548
INDIRI4
ASGNI4
line 477
;476:
;477:	cgs.media.takenLeadSound = trap_S_RegisterSound("sound/feedback/takenlead.wav", qtrue);
ADDRGP4 $601
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 552
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1088
ADDRLP4 552
INDIRI4
ASGNI4
line 478
;478:	cgs.media.tiedLeadSound = trap_S_RegisterSound("sound/feedback/tiedlead.wav", qtrue);
ADDRGP4 $604
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 556
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1092
ADDRLP4 556
INDIRI4
ASGNI4
line 479
;479:	cgs.media.lostLeadSound = trap_S_RegisterSound("sound/feedback/lostlead.wav", qtrue);
ADDRGP4 $607
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 560
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1096
ADDRLP4 560
INDIRI4
ASGNI4
line 481
;480:
;481:	cgs.media.voteNow = trap_S_RegisterSound("sound/feedback/vote_now.wav", qtrue);
ADDRGP4 $610
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 564
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1100
ADDRLP4 564
INDIRI4
ASGNI4
line 482
;482:	cgs.media.votePassed = trap_S_RegisterSound("sound/feedback/vote_passed.wav", qtrue);
ADDRGP4 $613
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 568
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1104
ADDRLP4 568
INDIRI4
ASGNI4
line 483
;483:	cgs.media.voteFailed = trap_S_RegisterSound("sound/feedback/vote_failed.wav", qtrue);
ADDRGP4 $616
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 572
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1108
ADDRLP4 572
INDIRI4
ASGNI4
line 485
;484:
;485:	cgs.media.watrInSound = trap_S_RegisterSound("sound/player/watr_in.wav", qfalse);
ADDRGP4 $619
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 576
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1112
ADDRLP4 576
INDIRI4
ASGNI4
line 486
;486:	cgs.media.watrOutSound = trap_S_RegisterSound("sound/player/watr_out.wav", qfalse);
ADDRGP4 $622
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 580
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1116
ADDRLP4 580
INDIRI4
ASGNI4
line 487
;487:	cgs.media.watrUnSound = trap_S_RegisterSound("sound/player/watr_un.wav", qfalse);
ADDRGP4 $625
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 584
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1120
ADDRLP4 584
INDIRI4
ASGNI4
line 489
;488:
;489:	cgs.media.jumpPadSound = trap_S_RegisterSound("sound/world/jumppad.wav", qfalse);
ADDRGP4 $628
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 588
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+992
ADDRLP4 588
INDIRI4
ASGNI4
line 491
;490:
;491:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $629
line 492
;492:		Com_sprintf(name, sizeof(name), "sound/player/footsteps/step%i.wav", i + 1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $633
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 493
;493:		cgs.media.footsteps[FOOTSTEP_NORMAL][i] = trap_S_RegisterSound(name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 592
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+146664+720
ADDP4
ADDRLP4 592
INDIRI4
ASGNI4
line 495
;494:
;495:		Com_sprintf(name, sizeof(name), "sound/player/footsteps/boot%i.wav", i + 1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $636
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 496
;496:		cgs.media.footsteps[FOOTSTEP_BOOT][i] = trap_S_RegisterSound(name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 596
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+146664+720+16
ADDP4
ADDRLP4 596
INDIRI4
ASGNI4
line 498
;497:
;498:		Com_sprintf(name, sizeof(name), "sound/player/footsteps/flesh%i.wav", i + 1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $640
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 499
;499:		cgs.media.footsteps[FOOTSTEP_FLESH][i] = trap_S_RegisterSound(name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 600
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+146664+720+32
ADDP4
ADDRLP4 600
INDIRI4
ASGNI4
line 501
;500:
;501:		Com_sprintf(name, sizeof(name), "sound/player/footsteps/mech%i.wav", i + 1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $644
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 502
;502:		cgs.media.footsteps[FOOTSTEP_MECH][i] = trap_S_RegisterSound(name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 604
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+146664+720+48
ADDP4
ADDRLP4 604
INDIRI4
ASGNI4
line 504
;503:
;504:		Com_sprintf(name, sizeof(name), "sound/player/footsteps/energy%i.wav", i + 1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $648
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 505
;505:		cgs.media.footsteps[FOOTSTEP_ENERGY][i] = trap_S_RegisterSound(name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 608
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+146664+720+64
ADDP4
ADDRLP4 608
INDIRI4
ASGNI4
line 507
;506:
;507:		Com_sprintf(name, sizeof(name), "sound/player/footsteps/splash%i.wav", i + 1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $652
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 508
;508:		cgs.media.footsteps[FOOTSTEP_SPLASH][i] = trap_S_RegisterSound(name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 612
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+146664+720+96
ADDP4
ADDRLP4 612
INDIRI4
ASGNI4
line 510
;509:
;510:		Com_sprintf(name, sizeof(name), "sound/player/footsteps/clank%i.wav", i + 1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $656
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 511
;511:		cgs.media.footsteps[FOOTSTEP_METAL][i] = trap_S_RegisterSound(name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 616
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+146664+720+80
ADDP4
ADDRLP4 616
INDIRI4
ASGNI4
line 512
;512:	}
LABELV $630
line 491
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $629
line 515
;513:
;514:	// only register the items that the server says we need
;515:	Q_strncpyz(items, CG_ConfigString(CS_ITEMS), sizeof(items));
CNSTI4 15
ARGI4
ADDRLP4 592
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 72
ARGP4
ADDRLP4 592
INDIRP4
ARGP4
CNSTI4 257
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 517
;516:
;517:	for (i = 1; i < bg_numItems; i++) {
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $663
JUMPV
LABELV $660
line 519
;518:		//		if ( items[ i ] == '1' || cg_buildScript.integer ) {
;519:		CG_RegisterItemSounds(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemSounds
CALLV
pop
line 521
;520:		//		}
;521:	}
LABELV $661
line 517
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $663
ADDRLP4 0
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $660
line 523
;522:
;523:	for (i = 1; i < MAX_SOUNDS; i++) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $664
line 524
;524:		soundName = CG_ConfigString(CS_SOUNDS + i);
ADDRLP4 0
INDIRI4
CNSTI4 273
ADDI4
ARGI4
ADDRLP4 596
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 68
ADDRLP4 596
INDIRP4
ASGNP4
line 525
;525:		if (!soundName[0]) {
ADDRLP4 68
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $668
line 526
;526:			break;
ADDRGP4 $666
JUMPV
LABELV $668
line 528
;527:		}
;528:		if (soundName[0] == '*') {
ADDRLP4 68
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $670
line 529
;529:			continue;	// custom sound
ADDRGP4 $665
JUMPV
LABELV $670
line 531
;530:		}
;531:		cgs.gameSounds[i] = trap_S_RegisterSound(soundName, qfalse);
ADDRLP4 68
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 600
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+33792
ADDP4
ADDRLP4 600
INDIRI4
ASGNI4
line 532
;532:	}
LABELV $665
line 523
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 256
LTI4 $664
LABELV $666
line 535
;533:
;534:	// FIXME: only needed with item
;535:	cgs.media.flightSound = trap_S_RegisterSound("sound/items/flight.wav", qfalse);
ADDRGP4 $675
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 596
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1124
ADDRLP4 596
INDIRI4
ASGNI4
line 536
;536:	cgs.media.medkitSound = trap_S_RegisterSound("sound/items/use_medkit.wav", qfalse);
ADDRGP4 $678
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 600
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1128
ADDRLP4 600
INDIRI4
ASGNI4
line 537
;537:	cgs.media.quadSound = trap_S_RegisterSound("sound/items/damage3.wav", qfalse);
ADDRGP4 $681
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 604
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+700
ADDRLP4 604
INDIRI4
ASGNI4
line 538
;538:	cgs.media.sfx_ric1 = trap_S_RegisterSound("sound/weapons/machinegun/ric1.wav", qfalse);
ADDRGP4 $684
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 608
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+844
ADDRLP4 608
INDIRI4
ASGNI4
line 539
;539:	cgs.media.sfx_ric2 = trap_S_RegisterSound("sound/weapons/machinegun/ric2.wav", qfalse);
ADDRGP4 $687
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 612
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+848
ADDRLP4 612
INDIRI4
ASGNI4
line 540
;540:	cgs.media.sfx_ric3 = trap_S_RegisterSound("sound/weapons/machinegun/ric3.wav", qfalse);
ADDRGP4 $690
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 616
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+852
ADDRLP4 616
INDIRI4
ASGNI4
line 542
;541:	//cgs.media.sfx_railg = trap_S_RegisterSound ("sound/weapons/railgun/railgf1a.wav", qfalse);
;542:	cgs.media.sfx_rockexp = trap_S_RegisterSound("sound/weapons/rocket/rocklx1a.wav", qfalse);
ADDRGP4 $693
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 620
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+860
ADDRLP4 620
INDIRI4
ASGNI4
line 543
;543:	cgs.media.sfx_plasmaexp = trap_S_RegisterSound("sound/weapons/plasma/plasmx1a.wav", qfalse);
ADDRGP4 $696
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 624
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+864
ADDRLP4 624
INDIRI4
ASGNI4
line 545
;544:
;545:	cgs.media.sfx_proxexp = trap_S_RegisterSound("sound/weapons/proxmine/wstbexpl.wav", qfalse);
ADDRGP4 $699
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 628
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+868
ADDRLP4 628
INDIRI4
ASGNI4
line 546
;546:	cgs.media.sfx_nghit = trap_S_RegisterSound("sound/weapons/nailgun/wnalimpd.wav", qfalse);
ADDRGP4 $702
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 632
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+872
ADDRLP4 632
INDIRI4
ASGNI4
line 547
;547:	cgs.media.sfx_nghitflesh = trap_S_RegisterSound("sound/weapons/nailgun/wnalimpl.wav", qfalse);
ADDRGP4 $705
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 636
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+876
ADDRLP4 636
INDIRI4
ASGNI4
line 548
;548:	cgs.media.sfx_nghitmetal = trap_S_RegisterSound("sound/weapons/nailgun/wnalimpm.wav", qfalse);
ADDRGP4 $708
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 640
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+880
ADDRLP4 640
INDIRI4
ASGNI4
line 549
;549:	cgs.media.sfx_chghit = trap_S_RegisterSound("sound/weapons/vulcan/wvulimpd.wav", qfalse);
ADDRGP4 $711
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 644
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+884
ADDRLP4 644
INDIRI4
ASGNI4
line 550
;550:	cgs.media.sfx_chghitflesh = trap_S_RegisterSound("sound/weapons/vulcan/wvulimpl.wav", qfalse);
ADDRGP4 $714
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 648
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+888
ADDRLP4 648
INDIRI4
ASGNI4
line 551
;551:	cgs.media.sfx_chghitmetal = trap_S_RegisterSound("sound/weapons/vulcan/wvulimpm.wav", qfalse);
ADDRGP4 $717
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 652
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+892
ADDRLP4 652
INDIRI4
ASGNI4
line 552
;552:	cgs.media.kamikazeExplodeSound = trap_S_RegisterSound("sound/items/kam_explode.wav", qfalse);
ADDRGP4 $720
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 656
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+896
ADDRLP4 656
INDIRI4
ASGNI4
line 553
;553:	cgs.media.kamikazeImplodeSound = trap_S_RegisterSound("sound/items/kam_implode.wav", qfalse);
ADDRGP4 $723
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 660
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+900
ADDRLP4 660
INDIRI4
ASGNI4
line 554
;554:	cgs.media.kamikazeFarSound = trap_S_RegisterSound("sound/items/kam_explode_far.wav", qfalse);
ADDRGP4 $726
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 664
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+904
ADDRLP4 664
INDIRI4
ASGNI4
line 555
;555:	cgs.media.winnerSound = trap_S_RegisterSound("sound/feedback/voc_youwin.wav", qfalse);
ADDRGP4 $729
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 668
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+944
ADDRLP4 668
INDIRI4
ASGNI4
line 556
;556:	cgs.media.loserSound = trap_S_RegisterSound("sound/feedback/voc_youlose.wav", qfalse);
ADDRGP4 $732
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 672
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+948
ADDRLP4 672
INDIRI4
ASGNI4
line 558
;557:
;558:	cgs.media.wstbimplSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbimpl.wav", qfalse);
ADDRGP4 $735
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 676
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1304
ADDRLP4 676
INDIRI4
ASGNI4
line 559
;559:	cgs.media.wstbimpmSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbimpm.wav", qfalse);
ADDRGP4 $738
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 680
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1308
ADDRLP4 680
INDIRI4
ASGNI4
line 560
;560:	cgs.media.wstbimpdSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbimpd.wav", qfalse);
ADDRGP4 $741
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 684
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1312
ADDRLP4 684
INDIRI4
ASGNI4
line 561
;561:	cgs.media.wstbactvSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbactv.wav", qfalse);
ADDRGP4 $744
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 688
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1316
ADDRLP4 688
INDIRI4
ASGNI4
line 563
;562:
;563:	cgs.media.regenSound = trap_S_RegisterSound("sound/items/regen.wav", qfalse);
ADDRGP4 $747
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 692
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1284
ADDRLP4 692
INDIRI4
ASGNI4
line 564
;564:	cgs.media.protectSound = trap_S_RegisterSound("sound/items/protect3.wav", qfalse);
ADDRGP4 $750
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 696
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1288
ADDRLP4 696
INDIRI4
ASGNI4
line 565
;565:	cgs.media.n_healthSound = trap_S_RegisterSound("sound/items/n_health.wav", qfalse);
ADDRGP4 $753
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 700
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1292
ADDRLP4 700
INDIRI4
ASGNI4
line 566
;566:	cgs.media.hgrenb1aSound = trap_S_RegisterSound("sound/weapons/grenade/hgrenb1a.wav", qfalse);
ADDRGP4 $756
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 704
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1296
ADDRLP4 704
INDIRI4
ASGNI4
line 567
;567:	cgs.media.hgrenb2aSound = trap_S_RegisterSound("sound/weapons/grenade/hgrenb2a.wav", qfalse);
ADDRGP4 $759
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 708
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1300
ADDRLP4 708
INDIRI4
ASGNI4
line 568
;568:}
LABELV $326
endproc CG_RegisterSounds 712 16
data
align 4
LABELV $761
address $762
address $763
address $764
address $765
address $766
address $767
address $768
address $769
address $770
address $771
address $772
code
proc CG_RegisterGraphics 640 16
line 581
;569:
;570:
;571://===================================================================================
;572:
;573:
;574:/*
;575:=================
;576:CG_RegisterGraphics
;577:
;578:This function may execute for a couple of minutes with a slow disk.
;579:=================
;580:*/
;581:static void CG_RegisterGraphics(void) {
line 599
;582:	int			i;
;583:	char		items[MAX_ITEMS + 1];
;584:	static char *sb_nums[11] = {
;585:		"gfx/2d/numbers/zero_32b",
;586:		"gfx/2d/numbers/one_32b",
;587:		"gfx/2d/numbers/two_32b",
;588:		"gfx/2d/numbers/three_32b",
;589:		"gfx/2d/numbers/four_32b",
;590:		"gfx/2d/numbers/five_32b",
;591:		"gfx/2d/numbers/six_32b",
;592:		"gfx/2d/numbers/seven_32b",
;593:		"gfx/2d/numbers/eight_32b",
;594:		"gfx/2d/numbers/nine_32b",
;595:		"gfx/2d/numbers/minus_32b",
;596:	};
;597:
;598:	// clear any references to old media
;599:	memset(&cg.refdef, 0, sizeof(cg.refdef));
ADDRGP4 cg+109056
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 600
;600:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 602
;601:
;602:	CG_LoadingString(cgs.mapname);
ADDRGP4 cgs+31508
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 604
;603:
;604:	trap_R_LoadWorldMap(cgs.mapname);
ADDRGP4 cgs+31508
ARGP4
ADDRGP4 trap_R_LoadWorldMap
CALLV
pop
line 607
;605:
;606:	// precache status bar pics
;607:	CG_LoadingString("game media");
ADDRGP4 $777
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 609
;608:
;609:	for (i = 0; i < ARRAY_LEN(sb_nums); i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $781
JUMPV
LABELV $778
line 610
;610:		cgs.media.numberShaders[i] = trap_R_RegisterShader(sb_nums[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $761
ADDP4
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+146664+420
ADDP4
ADDRLP4 268
INDIRI4
ASGNI4
line 611
;611:	}
LABELV $779
line 609
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $781
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 11
LTU4 $778
line 613
;612:
;613:	cgs.media.botSkillShaders[0] = trap_R_RegisterShader("menu/art/skill1.tga");
ADDRGP4 $786
ARGP4
ADDRLP4 264
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+468
ADDRLP4 264
INDIRI4
ASGNI4
line 614
;614:	cgs.media.botSkillShaders[1] = trap_R_RegisterShader("menu/art/skill2.tga");
ADDRGP4 $790
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+468+4
ADDRLP4 268
INDIRI4
ASGNI4
line 615
;615:	cgs.media.botSkillShaders[2] = trap_R_RegisterShader("menu/art/skill3.tga");
ADDRGP4 $794
ARGP4
ADDRLP4 272
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+468+8
ADDRLP4 272
INDIRI4
ASGNI4
line 616
;616:	cgs.media.botSkillShaders[3] = trap_R_RegisterShader("menu/art/skill4.tga");
ADDRGP4 $798
ARGP4
ADDRLP4 276
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+468+12
ADDRLP4 276
INDIRI4
ASGNI4
line 617
;617:	cgs.media.botSkillShaders[4] = trap_R_RegisterShader("menu/art/skill5.tga");
ADDRGP4 $802
ARGP4
ADDRLP4 280
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+468+16
ADDRLP4 280
INDIRI4
ASGNI4
line 619
;618:
;619:	cgs.media.viewBloodShader = trap_R_RegisterShader("viewBloodBlend");
ADDRGP4 $805
ARGP4
ADDRLP4 284
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+248
ADDRLP4 284
INDIRI4
ASGNI4
line 621
;620:
;621:	cgs.media.deferShader = trap_R_RegisterShaderNoMip("gfx/2d/defer.tga");
ADDRGP4 $808
ARGP4
ADDRLP4 288
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+164
ADDRLP4 288
INDIRI4
ASGNI4
line 623
;622:
;623:	cgs.media.scoreboardName = trap_R_RegisterShaderNoMip("menu/tab/name.tga");
ADDRGP4 $811
ARGP4
ADDRLP4 292
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+660
ADDRLP4 292
INDIRI4
ASGNI4
line 624
;624:	cgs.media.scoreboardPing = trap_R_RegisterShaderNoMip("menu/tab/ping.tga");
ADDRGP4 $814
ARGP4
ADDRLP4 296
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+664
ADDRLP4 296
INDIRI4
ASGNI4
line 625
;625:	cgs.media.scoreboardScore = trap_R_RegisterShaderNoMip("menu/tab/score.tga");
ADDRGP4 $817
ARGP4
ADDRLP4 300
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+668
ADDRLP4 300
INDIRI4
ASGNI4
line 626
;626:	cgs.media.scoreboardTime = trap_R_RegisterShaderNoMip("menu/tab/time.tga");
ADDRGP4 $820
ARGP4
ADDRLP4 304
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+672
ADDRLP4 304
INDIRI4
ASGNI4
line 628
;627:
;628:	cgs.media.smokePuffShader = trap_R_RegisterShader("smokePuff");
ADDRGP4 $823
ARGP4
ADDRLP4 308
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+388
ADDRLP4 308
INDIRI4
ASGNI4
line 629
;629:	cgs.media.smokePuffRageProShader = trap_R_RegisterShader("smokePuffRagePro");
ADDRGP4 $826
ARGP4
ADDRLP4 312
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+392
ADDRLP4 312
INDIRI4
ASGNI4
line 630
;630:	cgs.media.shotgunSmokePuffShader = trap_R_RegisterShader("shotgunSmokePuff");
ADDRGP4 $829
ARGP4
ADDRLP4 316
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+396
ADDRLP4 316
INDIRI4
ASGNI4
line 631
;631:	cgs.media.nailPuffShader = trap_R_RegisterShader("nailtrail");
ADDRGP4 $832
ARGP4
ADDRLP4 320
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+412
ADDRLP4 320
INDIRI4
ASGNI4
line 632
;632:	cgs.media.blueProxMine = trap_R_RegisterModel("models/weaphits/proxmineb.md3");
ADDRGP4 $835
ARGP4
ADDRLP4 324
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+416
ADDRLP4 324
INDIRI4
ASGNI4
line 634
;633:
;634:	cgs.media.plasmaBallShader = trap_R_RegisterShader("sprites/plasma1");
ADDRGP4 $838
ARGP4
ADDRLP4 328
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+400
ADDRLP4 328
INDIRI4
ASGNI4
line 635
;635:	cgs.media.bloodTrailShader = trap_R_RegisterShader("bloodTrail");
ADDRGP4 $841
ARGP4
ADDRLP4 332
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+408
ADDRLP4 332
INDIRI4
ASGNI4
line 636
;636:	cgs.media.lagometerShader = trap_R_RegisterShader("lagometer");
ADDRGP4 $844
ARGP4
ADDRLP4 336
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+376
ADDRLP4 336
INDIRI4
ASGNI4
line 637
;637:	cgs.media.connectionShader = trap_R_RegisterShader("disconnected");
ADDRGP4 $847
ARGP4
ADDRLP4 340
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+240
ADDRLP4 340
INDIRI4
ASGNI4
line 639
;638:
;639:	cgs.media.waterBubbleShader = trap_R_RegisterShader("waterBubble");
ADDRGP4 $850
ARGP4
ADDRLP4 344
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+404
ADDRLP4 344
INDIRI4
ASGNI4
line 641
;640:
;641:	cgs.media.tracerShader = trap_R_RegisterShader("gfx/misc/tracer");
ADDRGP4 $853
ARGP4
ADDRLP4 348
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+252
ADDRLP4 348
INDIRI4
ASGNI4
line 642
;642:	cgs.media.selectShader = trap_R_RegisterShader("gfx/2d/select");
ADDRGP4 $856
ARGP4
ADDRLP4 352
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+244
ADDRLP4 352
INDIRI4
ASGNI4
line 644
;643:
;644:	for (i = 0; i < NUM_CROSSHAIRS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $857
line 645
;645:		cgs.media.crosshairShader[i] = trap_R_RegisterShader(va("gfx/2d/crosshair%c", 'a' + i));
ADDRGP4 $863
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 97
ADDI4
ARGI4
ADDRLP4 360
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 360
INDIRP4
ARGP4
ADDRLP4 364
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+146664+256
ADDP4
ADDRLP4 364
INDIRI4
ASGNI4
line 646
;646:	}
LABELV $858
line 644
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 30
LTI4 $857
line 648
;647:
;648:	cgs.media.backTileShader = trap_R_RegisterShader("gfx/2d/backtile");
ADDRGP4 $866
ARGP4
ADDRLP4 356
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+380
ADDRLP4 356
INDIRI4
ASGNI4
line 649
;649:	cgs.media.noammoShader = trap_R_RegisterShader("icons/noammo");
ADDRGP4 $869
ARGP4
ADDRLP4 360
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+384
ADDRLP4 360
INDIRI4
ASGNI4
line 652
;650:
;651:	// powerup shaders
;652:	cgs.media.quadShader = trap_R_RegisterShader("powerups/quad");
ADDRGP4 $872
ARGP4
ADDRLP4 364
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+512
ADDRLP4 364
INDIRI4
ASGNI4
line 653
;653:	cgs.media.quadWeaponShader = trap_R_RegisterShader("powerups/quadWeapon");
ADDRGP4 $875
ARGP4
ADDRLP4 368
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+520
ADDRLP4 368
INDIRI4
ASGNI4
line 654
;654:	cgs.media.battleSuitShader = trap_R_RegisterShader("powerups/battleSuit");
ADDRGP4 $878
ARGP4
ADDRLP4 372
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+532
ADDRLP4 372
INDIRI4
ASGNI4
line 655
;655:	cgs.media.battleWeaponShader = trap_R_RegisterShader("powerups/battleWeapon");
ADDRGP4 $881
ARGP4
ADDRLP4 376
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+536
ADDRLP4 376
INDIRI4
ASGNI4
line 656
;656:	cgs.media.invisShader = trap_R_RegisterShader("powerups/invisibility");
ADDRGP4 $884
ARGP4
ADDRLP4 380
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+524
ADDRLP4 380
INDIRI4
ASGNI4
line 657
;657:	cgs.media.regenShader = trap_R_RegisterShader("powerups/regen");
ADDRGP4 $887
ARGP4
ADDRLP4 384
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+528
ADDRLP4 384
INDIRI4
ASGNI4
line 658
;658:	cgs.media.hastePuffShader = trap_R_RegisterShader("hasteSmokePuff");
ADDRGP4 $890
ARGP4
ADDRLP4 388
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+540
ADDRLP4 388
INDIRI4
ASGNI4
line 660
;659:
;660:	if (cgs.gametype == GT_CTF || cgs.gametype == GT_ONEFLAG || cgs.gametype == GT_HARVESTER || cg_buildScript.integer) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
EQI4 $899
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 6
EQI4 $899
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 8
EQI4 $899
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $891
LABELV $899
line 661
;661:		cgs.media.redSkullModel = trap_R_RegisterModel("models/powerups/orb/r_orb.md3");
ADDRGP4 $902
ARGP4
ADDRLP4 392
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+20
ADDRLP4 392
INDIRI4
ASGNI4
line 662
;662:		cgs.media.blueSkullModel = trap_R_RegisterModel("models/powerups/orb/b_orb.md3");
ADDRGP4 $905
ARGP4
ADDRLP4 396
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+24
ADDRLP4 396
INDIRI4
ASGNI4
line 663
;663:		cgs.media.redSkullIcon = trap_R_RegisterShader("icons/skull_red");
ADDRGP4 $908
ARGP4
ADDRLP4 400
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+28
ADDRLP4 400
INDIRI4
ASGNI4
line 664
;664:		cgs.media.blueSkullIcon = trap_R_RegisterShader("icons/skull_blue");
ADDRGP4 $911
ARGP4
ADDRLP4 404
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+32
ADDRLP4 404
INDIRI4
ASGNI4
line 665
;665:	}
LABELV $891
line 667
;666:
;667:	if (cgs.gametype == GT_CTF || cgs.gametype == GT_ONEFLAG || cgs.gametype == GT_HARVESTER || cg_buildScript.integer) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
EQI4 $920
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 6
EQI4 $920
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 8
EQI4 $920
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $912
LABELV $920
line 668
;668:		cgs.media.redFlagModel = trap_R_RegisterModel("models/flags/r_flag.md3");
ADDRGP4 $923
ARGP4
ADDRLP4 392
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+36
ADDRLP4 392
INDIRI4
ASGNI4
line 669
;669:		cgs.media.blueFlagModel = trap_R_RegisterModel("models/flags/b_flag.md3");
ADDRGP4 $926
ARGP4
ADDRLP4 396
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+40
ADDRLP4 396
INDIRI4
ASGNI4
line 670
;670:		cgs.media.redFlagShader[0] = trap_R_RegisterShaderNoMip("icons/iconf_red1");
ADDRGP4 $929
ARGP4
ADDRLP4 400
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+48
ADDRLP4 400
INDIRI4
ASGNI4
line 671
;671:		cgs.media.redFlagShader[1] = trap_R_RegisterShaderNoMip("icons/iconf_red2");
ADDRGP4 $933
ARGP4
ADDRLP4 404
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+48+4
ADDRLP4 404
INDIRI4
ASGNI4
line 672
;672:		cgs.media.redFlagShader[2] = trap_R_RegisterShaderNoMip("icons/iconf_red3");
ADDRGP4 $937
ARGP4
ADDRLP4 408
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+48+8
ADDRLP4 408
INDIRI4
ASGNI4
line 673
;673:		cgs.media.blueFlagShader[0] = trap_R_RegisterShaderNoMip("icons/iconf_blu1");
ADDRGP4 $940
ARGP4
ADDRLP4 412
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+60
ADDRLP4 412
INDIRI4
ASGNI4
line 674
;674:		cgs.media.blueFlagShader[1] = trap_R_RegisterShaderNoMip("icons/iconf_blu2");
ADDRGP4 $944
ARGP4
ADDRLP4 416
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+60+4
ADDRLP4 416
INDIRI4
ASGNI4
line 675
;675:		cgs.media.blueFlagShader[2] = trap_R_RegisterShaderNoMip("icons/iconf_blu3");
ADDRGP4 $948
ARGP4
ADDRLP4 420
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+60+8
ADDRLP4 420
INDIRI4
ASGNI4
line 677
;676:
;677:		cgs.media.flagPoleModel = trap_R_RegisterModel("models/flag2/flagpole.md3");
ADDRGP4 $951
ARGP4
ADDRLP4 424
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+88
ADDRLP4 424
INDIRI4
ASGNI4
line 678
;678:		cgs.media.flagFlapModel = trap_R_RegisterModel("models/flag2/flagflap3.md3");
ADDRGP4 $954
ARGP4
ADDRLP4 428
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+92
ADDRLP4 428
INDIRI4
ASGNI4
line 680
;679:
;680:		cgs.media.redFlagFlapSkin = trap_R_RegisterSkin("models/flag2/red.skin");
ADDRGP4 $957
ARGP4
ADDRLP4 432
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRGP4 cgs+146664+96
ADDRLP4 432
INDIRI4
ASGNI4
line 681
;681:		cgs.media.blueFlagFlapSkin = trap_R_RegisterSkin("models/flag2/blue.skin");
ADDRGP4 $960
ARGP4
ADDRLP4 436
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRGP4 cgs+146664+100
ADDRLP4 436
INDIRI4
ASGNI4
line 682
;682:		cgs.media.neutralFlagFlapSkin = trap_R_RegisterSkin("models/flag2/white.skin");
ADDRGP4 $963
ARGP4
ADDRLP4 440
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRGP4 cgs+146664+104
ADDRLP4 440
INDIRI4
ASGNI4
line 684
;683:
;684:		cgs.media.redFlagBaseModel = trap_R_RegisterModel("models/mapobjects/flagbase/red_base.md3");
ADDRGP4 $966
ARGP4
ADDRLP4 444
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+108
ADDRLP4 444
INDIRI4
ASGNI4
line 685
;685:		cgs.media.blueFlagBaseModel = trap_R_RegisterModel("models/mapobjects/flagbase/blue_base.md3");
ADDRGP4 $969
ARGP4
ADDRLP4 448
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+112
ADDRLP4 448
INDIRI4
ASGNI4
line 686
;686:		cgs.media.neutralFlagBaseModel = trap_R_RegisterModel("models/mapobjects/flagbase/ntrl_base.md3");
ADDRGP4 $972
ARGP4
ADDRLP4 452
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+116
ADDRLP4 452
INDIRI4
ASGNI4
line 687
;687:	}
LABELV $912
line 689
;688:
;689:	if (cgs.gametype == GT_ONEFLAG || cg_buildScript.integer) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 6
EQI4 $977
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $973
LABELV $977
line 690
;690:		cgs.media.neutralFlagModel = trap_R_RegisterModel("models/flags/n_flag.md3");
ADDRGP4 $980
ARGP4
ADDRLP4 392
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+44
ADDRLP4 392
INDIRI4
ASGNI4
line 691
;691:		cgs.media.flagShader[0] = trap_R_RegisterShaderNoMip("icons/iconf_neutral1");
ADDRGP4 $983
ARGP4
ADDRLP4 396
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+72
ADDRLP4 396
INDIRI4
ASGNI4
line 692
;692:		cgs.media.flagShader[1] = trap_R_RegisterShaderNoMip("icons/iconf_red2");
ADDRGP4 $933
ARGP4
ADDRLP4 400
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+72+4
ADDRLP4 400
INDIRI4
ASGNI4
line 693
;693:		cgs.media.flagShader[2] = trap_R_RegisterShaderNoMip("icons/iconf_blu2");
ADDRGP4 $944
ARGP4
ADDRLP4 404
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+72+8
ADDRLP4 404
INDIRI4
ASGNI4
line 694
;694:		cgs.media.flagShader[3] = trap_R_RegisterShaderNoMip("icons/iconf_neutral3");
ADDRGP4 $993
ARGP4
ADDRLP4 408
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+72+12
ADDRLP4 408
INDIRI4
ASGNI4
line 695
;695:	}
LABELV $973
line 697
;696:
;697:	if (cgs.gametype == GT_OBELISK || cg_buildScript.integer) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 7
EQI4 $998
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $994
LABELV $998
line 698
;698:		cgs.media.overloadBaseModel = trap_R_RegisterModel("models/powerups/overload_base.md3");
ADDRGP4 $1001
ARGP4
ADDRLP4 392
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+120
ADDRLP4 392
INDIRI4
ASGNI4
line 699
;699:		cgs.media.overloadTargetModel = trap_R_RegisterModel("models/powerups/overload_target.md3");
ADDRGP4 $1004
ARGP4
ADDRLP4 396
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+124
ADDRLP4 396
INDIRI4
ASGNI4
line 700
;700:		cgs.media.overloadLightsModel = trap_R_RegisterModel("models/powerups/overload_lights.md3");
ADDRGP4 $1007
ARGP4
ADDRLP4 400
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+128
ADDRLP4 400
INDIRI4
ASGNI4
line 701
;701:		cgs.media.overloadEnergyModel = trap_R_RegisterModel("models/powerups/overload_energy.md3");
ADDRGP4 $1010
ARGP4
ADDRLP4 404
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+132
ADDRLP4 404
INDIRI4
ASGNI4
line 702
;702:	}
LABELV $994
line 704
;703:
;704:	if (cgs.gametype == GT_HARVESTER || cg_buildScript.integer) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 8
EQI4 $1015
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $1011
LABELV $1015
line 705
;705:		cgs.media.harvesterModel = trap_R_RegisterModel("models/powerups/harvester/harvester.md3");
ADDRGP4 $1018
ARGP4
ADDRLP4 392
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+136
ADDRLP4 392
INDIRI4
ASGNI4
line 706
;706:		cgs.media.harvesterRedSkin = trap_R_RegisterSkin("models/powerups/harvester/red.skin");
ADDRGP4 $1021
ARGP4
ADDRLP4 396
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRGP4 cgs+146664+140
ADDRLP4 396
INDIRI4
ASGNI4
line 707
;707:		cgs.media.harvesterBlueSkin = trap_R_RegisterSkin("models/powerups/harvester/blue.skin");
ADDRGP4 $1024
ARGP4
ADDRLP4 400
ADDRGP4 trap_R_RegisterSkin
CALLI4
ASGNI4
ADDRGP4 cgs+146664+144
ADDRLP4 400
INDIRI4
ASGNI4
line 708
;708:		cgs.media.harvesterNeutralModel = trap_R_RegisterModel("models/powerups/obelisk/obelisk.md3");
ADDRGP4 $1027
ARGP4
ADDRLP4 404
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+148
ADDRLP4 404
INDIRI4
ASGNI4
line 709
;709:	}
LABELV $1011
line 711
;710:
;711:	cgs.media.redKamikazeShader = trap_R_RegisterShader("models/weaphits/kamikred");
ADDRGP4 $1030
ARGP4
ADDRLP4 392
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+544
ADDRLP4 392
INDIRI4
ASGNI4
line 712
;712:	cgs.media.dustPuffShader = trap_R_RegisterShader("hasteSmokePuff");
ADDRGP4 $890
ARGP4
ADDRLP4 396
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+648
ADDRLP4 396
INDIRI4
ASGNI4
line 714
;713:
;714:	if (cgs.gametype >= GT_TEAM || cg_buildScript.integer) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
GEI4 $1037
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $1033
LABELV $1037
line 715
;715:		cgs.media.friendShader = trap_R_RegisterShader("sprites/foe");
ADDRGP4 $1040
ARGP4
ADDRLP4 400
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+232
ADDRLP4 400
INDIRI4
ASGNI4
line 716
;716:		cgs.media.redQuadShader = trap_R_RegisterShader("powerups/blueflag");
ADDRGP4 $1043
ARGP4
ADDRLP4 404
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+516
ADDRLP4 404
INDIRI4
ASGNI4
line 717
;717:		cgs.media.teamStatusBar = trap_R_RegisterShader("gfx/2d/colorbar.tga");
ADDRGP4 $1046
ARGP4
ADDRLP4 408
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+160
ADDRLP4 408
INDIRI4
ASGNI4
line 718
;718:		cgs.media.blueKamikazeShader = trap_R_RegisterShader("models/weaphits/kamikblu");
ADDRGP4 $1049
ARGP4
ADDRLP4 412
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+548
ADDRLP4 412
INDIRI4
ASGNI4
line 719
;719:	}
LABELV $1033
line 721
;720:
;721:	cgs.media.armorModel = trap_R_RegisterModel("models/powerups/armor/armor_yel.md3");
ADDRGP4 $1052
ARGP4
ADDRLP4 400
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+152
ADDRLP4 400
INDIRI4
ASGNI4
line 722
;722:	cgs.media.armorIcon = trap_R_RegisterShaderNoMip("icons/iconr_yellow");
ADDRGP4 $1055
ARGP4
ADDRLP4 404
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+156
ADDRLP4 404
INDIRI4
ASGNI4
line 724
;723:
;724:	cgs.media.machinegunBrassModel = trap_R_RegisterModel("models/weapons2/shells/m_shell.md3");
ADDRGP4 $1058
ARGP4
ADDRLP4 408
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+212
ADDRLP4 408
INDIRI4
ASGNI4
line 725
;725:	cgs.media.shotgunBrassModel = trap_R_RegisterModel("models/weapons2/shells/s_shell.md3");
ADDRGP4 $1061
ARGP4
ADDRLP4 412
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+216
ADDRLP4 412
INDIRI4
ASGNI4
line 727
;726:
;727:	cgs.media.gibAbdomen = trap_R_RegisterModel("models/gibs/abdomen.md3");
ADDRGP4 $1064
ARGP4
ADDRLP4 416
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+168
ADDRLP4 416
INDIRI4
ASGNI4
line 728
;728:	cgs.media.gibArm = trap_R_RegisterModel("models/gibs/arm.md3");
ADDRGP4 $1067
ARGP4
ADDRLP4 420
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+172
ADDRLP4 420
INDIRI4
ASGNI4
line 729
;729:	cgs.media.gibChest = trap_R_RegisterModel("models/gibs/chest.md3");
ADDRGP4 $1070
ARGP4
ADDRLP4 424
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+176
ADDRLP4 424
INDIRI4
ASGNI4
line 730
;730:	cgs.media.gibFist = trap_R_RegisterModel("models/gibs/fist.md3");
ADDRGP4 $1073
ARGP4
ADDRLP4 428
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+180
ADDRLP4 428
INDIRI4
ASGNI4
line 731
;731:	cgs.media.gibFoot = trap_R_RegisterModel("models/gibs/foot.md3");
ADDRGP4 $1076
ARGP4
ADDRLP4 432
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+184
ADDRLP4 432
INDIRI4
ASGNI4
line 732
;732:	cgs.media.gibForearm = trap_R_RegisterModel("models/gibs/forearm.md3");
ADDRGP4 $1079
ARGP4
ADDRLP4 436
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+188
ADDRLP4 436
INDIRI4
ASGNI4
line 733
;733:	cgs.media.gibIntestine = trap_R_RegisterModel("models/gibs/intestine.md3");
ADDRGP4 $1082
ARGP4
ADDRLP4 440
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+192
ADDRLP4 440
INDIRI4
ASGNI4
line 734
;734:	cgs.media.gibLeg = trap_R_RegisterModel("models/gibs/leg.md3");
ADDRGP4 $1085
ARGP4
ADDRLP4 444
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+196
ADDRLP4 444
INDIRI4
ASGNI4
line 735
;735:	cgs.media.gibSkull = trap_R_RegisterModel("models/gibs/skull.md3");
ADDRGP4 $1088
ARGP4
ADDRLP4 448
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+200
ADDRLP4 448
INDIRI4
ASGNI4
line 736
;736:	cgs.media.gibBrain = trap_R_RegisterModel("models/gibs/brain.md3");
ADDRGP4 $1091
ARGP4
ADDRLP4 452
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+204
ADDRLP4 452
INDIRI4
ASGNI4
line 738
;737:
;738:	cgs.media.smoke2 = trap_R_RegisterModel("models/weapons2/shells/s_shell.md3");
ADDRGP4 $1061
ARGP4
ADDRLP4 456
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+208
ADDRLP4 456
INDIRI4
ASGNI4
line 740
;739:
;740:	cgs.media.balloonShader = trap_R_RegisterShader("sprites/balloon3");
ADDRGP4 $1096
ARGP4
ADDRLP4 460
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+236
ADDRLP4 460
INDIRI4
ASGNI4
line 742
;741:
;742:	cgs.media.bloodExplosionShader = trap_R_RegisterShader("bloodExplosion");
ADDRGP4 $1099
ARGP4
ADDRLP4 464
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+592
ADDRLP4 464
INDIRI4
ASGNI4
line 744
;743:
;744:	cgs.media.bulletFlashModel = trap_R_RegisterModel("models/weaphits/bullet.md3");
ADDRGP4 $1102
ARGP4
ADDRLP4 468
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+552
ADDRLP4 468
INDIRI4
ASGNI4
line 745
;745:	cgs.media.ringFlashModel = trap_R_RegisterModel("models/weaphits/ring02.md3");
ADDRGP4 $1105
ARGP4
ADDRLP4 472
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+556
ADDRLP4 472
INDIRI4
ASGNI4
line 746
;746:	cgs.media.dishFlashModel = trap_R_RegisterModel("models/weaphits/boom01.md3");
ADDRGP4 $1108
ARGP4
ADDRLP4 476
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+560
ADDRLP4 476
INDIRI4
ASGNI4
line 747
;747:	cgs.media.teleportEffectModel = trap_R_RegisterModel("models/powerups/pop.md3");
ADDRGP4 $1111
ARGP4
ADDRLP4 480
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+596
ADDRLP4 480
INDIRI4
ASGNI4
line 749
;748:
;749:	cgs.media.kamikazeEffectModel = trap_R_RegisterModel("models/weaphits/kamboom2.md3");
ADDRGP4 $1114
ARGP4
ADDRLP4 484
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+604
ADDRLP4 484
INDIRI4
ASGNI4
line 750
;750:	cgs.media.kamikazeShockWave = trap_R_RegisterModel("models/weaphits/kamwave.md3");
ADDRGP4 $1117
ARGP4
ADDRLP4 488
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+608
ADDRLP4 488
INDIRI4
ASGNI4
line 751
;751:	cgs.media.kamikazeHeadModel = trap_R_RegisterModel("models/powerups/kamikazi.md3");
ADDRGP4 $1120
ARGP4
ADDRLP4 492
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+612
ADDRLP4 492
INDIRI4
ASGNI4
line 752
;752:	cgs.media.kamikazeHeadTrail = trap_R_RegisterModel("models/powerups/trailtest.md3");
ADDRGP4 $1123
ARGP4
ADDRLP4 496
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+616
ADDRLP4 496
INDIRI4
ASGNI4
line 753
;753:	cgs.media.guardPowerupModel = trap_R_RegisterModel("models/powerups/guard_player.md3");
ADDRGP4 $1126
ARGP4
ADDRLP4 500
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+620
ADDRLP4 500
INDIRI4
ASGNI4
line 754
;754:	cgs.media.scoutPowerupModel = trap_R_RegisterModel("models/powerups/scout_player.md3");
ADDRGP4 $1129
ARGP4
ADDRLP4 504
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+624
ADDRLP4 504
INDIRI4
ASGNI4
line 755
;755:	cgs.media.doublerPowerupModel = trap_R_RegisterModel("models/powerups/doubler_player.md3");
ADDRGP4 $1132
ARGP4
ADDRLP4 508
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+628
ADDRLP4 508
INDIRI4
ASGNI4
line 756
;756:	cgs.media.ammoRegenPowerupModel = trap_R_RegisterModel("models/powerups/ammo_player.md3");
ADDRGP4 $1135
ARGP4
ADDRLP4 512
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+632
ADDRLP4 512
INDIRI4
ASGNI4
line 757
;757:	cgs.media.invulnerabilityImpactModel = trap_R_RegisterModel("models/powerups/shield/impact.md3");
ADDRGP4 $1138
ARGP4
ADDRLP4 516
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+636
ADDRLP4 516
INDIRI4
ASGNI4
line 758
;758:	cgs.media.invulnerabilityJuicedModel = trap_R_RegisterModel("models/powerups/shield/juicer.md3");
ADDRGP4 $1141
ARGP4
ADDRLP4 520
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+640
ADDRLP4 520
INDIRI4
ASGNI4
line 759
;759:	cgs.media.medkitUsageModel = trap_R_RegisterModel("models/powerups/regen.md3");
ADDRGP4 $1144
ARGP4
ADDRLP4 524
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+644
ADDRLP4 524
INDIRI4
ASGNI4
line 760
;760:	cgs.media.invulnerabilityPowerupModel = trap_R_RegisterModel("models/powerups/shield/shield.md3");
ADDRGP4 $1147
ARGP4
ADDRLP4 528
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+146664+656
ADDRLP4 528
INDIRI4
ASGNI4
line 762
;761:
;762:	cgs.media.medalImpressive = trap_R_RegisterShaderNoMip("medal_impressive");
ADDRGP4 $1150
ARGP4
ADDRLP4 532
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+676
ADDRLP4 532
INDIRI4
ASGNI4
line 763
;763:	cgs.media.medalExcellent = trap_R_RegisterShaderNoMip("medal_excellent");
ADDRGP4 $1153
ARGP4
ADDRLP4 536
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+680
ADDRLP4 536
INDIRI4
ASGNI4
line 764
;764:	cgs.media.medalGauntlet = trap_R_RegisterShaderNoMip("medal_gauntlet");
ADDRGP4 $1156
ARGP4
ADDRLP4 540
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+684
ADDRLP4 540
INDIRI4
ASGNI4
line 765
;765:	cgs.media.medalDefend = trap_R_RegisterShaderNoMip("medal_defend");
ADDRGP4 $1159
ARGP4
ADDRLP4 544
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+688
ADDRLP4 544
INDIRI4
ASGNI4
line 766
;766:	cgs.media.medalAssist = trap_R_RegisterShaderNoMip("medal_assist");
ADDRGP4 $1162
ARGP4
ADDRLP4 548
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+692
ADDRLP4 548
INDIRI4
ASGNI4
line 767
;767:	cgs.media.medalCapture = trap_R_RegisterShaderNoMip("medal_capture");
ADDRGP4 $1165
ARGP4
ADDRLP4 552
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+696
ADDRLP4 552
INDIRI4
ASGNI4
line 770
;768:
;769:
;770:	memset(cg_items, 0, sizeof(cg_items));
ADDRGP4 cg_items
ARGP4
CNSTI4 0
ARGI4
CNSTI4 7168
ARGI4
ADDRGP4 memset
CALLP4
pop
line 771
;771:	memset(cg_weapons, 0, sizeof(cg_weapons));
ADDRGP4 cg_weapons
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 774
;772:
;773:	// only register the items that the server says we need
;774:	Q_strncpyz(items, CG_ConfigString(CS_ITEMS), sizeof(items));
CNSTI4 15
ARGI4
ADDRLP4 556
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 556
INDIRP4
ARGP4
CNSTI4 257
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 776
;775:
;776:	for (i = 1; i < bg_numItems; i++) {
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1169
JUMPV
LABELV $1166
line 777
;777:		if (items[i] == '1' || cg_buildScript.integer) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
CNSTI4 49
EQI4 $1173
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $1170
LABELV $1173
line 778
;778:			CG_LoadingItem(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_LoadingItem
CALLV
pop
line 779
;779:			CG_RegisterItemVisuals(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 780
;780:		}
LABELV $1170
line 781
;781:	}
LABELV $1167
line 776
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1169
ADDRLP4 0
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $1166
line 783
;782:
;783:	cg.skipDFshaders = qfalse;
ADDRGP4 cg+157016
CNSTI4 0
ASGNI4
line 786
;784:
;785:	// wall marks
;786:	cgs.media.bulletMarkShader = trap_R_RegisterShader("gfx/damage/bullet_mrk");
ADDRGP4 $1177
ARGP4
ADDRLP4 560
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+496
ADDRLP4 560
INDIRI4
ASGNI4
line 787
;787:	cgs.media.burnMarkShader = trap_R_RegisterShader("gfx/damage/burn_med_mrk");
ADDRGP4 $1180
ARGP4
ADDRLP4 564
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+500
ADDRLP4 564
INDIRI4
ASGNI4
line 788
;788:	cgs.media.holeMarkShader = trap_R_RegisterShader("gfx/damage/hole_lg_mrk");
ADDRGP4 $1183
ARGP4
ADDRLP4 568
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+504
ADDRLP4 568
INDIRI4
ASGNI4
line 789
;789:	cgs.media.energyMarkShader = trap_R_RegisterShader("gfx/damage/plasma_mrk");
ADDRGP4 $1186
ARGP4
ADDRLP4 572
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+508
ADDRLP4 572
INDIRI4
ASGNI4
line 790
;790:	cgs.media.shadowMarkShader = trap_R_RegisterShader("markShadow");
ADDRGP4 $1189
ARGP4
ADDRLP4 576
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+464
ADDRLP4 576
INDIRI4
ASGNI4
line 791
;791:	cgs.media.wakeMarkShader = trap_R_RegisterShader("wake");
ADDRGP4 $1192
ARGP4
ADDRLP4 580
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+488
ADDRLP4 580
INDIRI4
ASGNI4
line 792
;792:	cgs.media.bloodMarkShader = trap_R_RegisterShader("bloodMark");
ADDRGP4 $1195
ARGP4
ADDRLP4 584
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+492
ADDRLP4 584
INDIRI4
ASGNI4
line 795
;793:
;794:	// register the inline models
;795:	cgs.numInlineModels = trap_CM_NumInlineModels();
ADDRLP4 588
ADDRGP4 trap_CM_NumInlineModels
CALLI4
ASGNI4
ADDRGP4 cgs+34816
ADDRLP4 588
INDIRI4
ASGNI4
line 796
;796:	for (i = 1; i < cgs.numInlineModels; i++) {
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1200
JUMPV
LABELV $1197
line 801
;797:		char	name[10];
;798:		vec3_t			mins, maxs;
;799:		int				j;
;800:
;801:		Com_sprintf(name, sizeof(name), "*%i", i);
ADDRLP4 620
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $1202
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 802
;802:		cgs.inlineDrawModel[i] = trap_R_RegisterModel(name);
ADDRLP4 620
ARGP4
ADDRLP4 632
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+34820
ADDP4
ADDRLP4 632
INDIRI4
ASGNI4
line 803
;803:		trap_R_ModelBounds(cgs.inlineDrawModel[i], mins, maxs);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+34820
ADDP4
INDIRI4
ARGI4
ADDRLP4 596
ARGP4
ADDRLP4 608
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 804
;804:		for (j = 0; j < 3; j++) {
ADDRLP4 592
CNSTI4 0
ASGNI4
LABELV $1205
line 805
;805:			cgs.inlineModelMidpoints[i][j] = mins[j] + 0.5 * (maxs[j] - mins[j]);
ADDRLP4 592
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 cgs+35844
ADDP4
ADDP4
ADDRLP4 592
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 596
ADDP4
INDIRF4
ADDRLP4 592
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 608
ADDP4
INDIRF4
ADDRLP4 592
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 596
ADDP4
INDIRF4
SUBF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
line 806
;806:		}
LABELV $1206
line 804
ADDRLP4 592
ADDRLP4 592
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 592
INDIRI4
CNSTI4 3
LTI4 $1205
line 807
;807:	}
LABELV $1198
line 796
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1200
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+34816
INDIRI4
LTI4 $1197
line 810
;808:
;809:	// register all the server specified models
;810:	for (i = 1; i < MAX_MODELS; i++) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $1210
line 813
;811:		const char *modelName;
;812:
;813:		modelName = CG_ConfigString(CS_MODELS + i);
ADDRLP4 0
INDIRI4
CNSTI4 17
ADDI4
ARGI4
ADDRLP4 596
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 592
ADDRLP4 596
INDIRP4
ASGNP4
line 814
;814:		if (!modelName[0]) {
ADDRLP4 592
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1214
line 815
;815:			break;
ADDRGP4 $1212
JUMPV
LABELV $1214
line 817
;816:		}
;817:		cgs.gameModels[i] = trap_R_RegisterModel(modelName);
ADDRLP4 592
INDIRP4
ARGP4
ADDRLP4 600
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32768
ADDP4
ADDRLP4 600
INDIRI4
ASGNI4
line 818
;818:	}
LABELV $1211
line 810
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 256
LTI4 $1210
LABELV $1212
line 820
;819:
;820:	cgs.media.cursor = trap_R_RegisterShaderNoMip("menu/art/3_cursor2");
ADDRGP4 $1219
ARGP4
ADDRLP4 592
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1272
ADDRLP4 592
INDIRI4
ASGNI4
line 822
;821:
;822:	cgs.media.sizeCursor = trap_R_RegisterShaderNoMip("ui/assets/sizecursor.tga");
ADDRGP4 $1222
ARGP4
ADDRLP4 596
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1280
ADDRLP4 596
INDIRI4
ASGNI4
line 823
;823:	cgs.media.selectCursor = trap_R_RegisterShaderNoMip("ui/assets/selectcursor.tga");
ADDRGP4 $1225
ARGP4
ADDRLP4 600
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+1276
ADDRLP4 600
INDIRI4
ASGNI4
line 825
;824:
;825:	CG_ClearParticles();
ADDRGP4 CG_ClearParticles
CALLV
pop
line 826
;826:}
LABELV $760
endproc CG_RegisterGraphics 640 16
export CG_BuildSpectatorString
proc CG_BuildSpectatorString 12 12
line 835
;827:
;828:
;829:/*
;830:=======================
;831:CG_BuildSpectatorString
;832:
;833:=======================
;834:*/
;835:void CG_BuildSpectatorString(void) {
line 837
;836:	int i;
;837:	cg.spectatorList[0] = 0;
ADDRGP4 cg+115436
CNSTI1 0
ASGNI1
line 838
;838:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1228
line 839
;839:		if (cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_SPECTATOR) {
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+38916
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1232
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+38916+36
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1232
line 840
;840:			Q_strcat(cg.spectatorList, sizeof(cg.spectatorList), va("%s     ", cgs.clientinfo[i].name));
ADDRGP4 $1239
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+38916+4
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 cg+115436
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 841
;841:		}
LABELV $1232
line 842
;842:	}
LABELV $1229
line 838
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1228
line 843
;843:	i = strlen(cg.spectatorList);
ADDRGP4 cg+115436
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 844
;844:	if (i != cg.spectatorLen) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+116460
INDIRI4
EQI4 $1243
line 845
;845:		cg.spectatorLen = i;
ADDRGP4 cg+116460
ADDRLP4 0
INDIRI4
ASGNI4
line 846
;846:		cg.spectatorWidth = -1;
ADDRGP4 cg+116464
CNSTF4 3212836864
ASGNF4
line 847
;847:	}
LABELV $1243
line 848
;848:}
LABELV $1226
endproc CG_BuildSpectatorString 12 12
proc CG_RegisterClients 12 4
line 856
;849:
;850:
;851:/*
;852:===================
;853:CG_RegisterClients
;854:===================
;855:*/
;856:static void CG_RegisterClients(void) {
line 859
;857:	int		i;
;858:
;859:	CG_LoadingClient(cg.clientNum);
ADDRGP4 cg+4
INDIRI4
ARGI4
ADDRGP4 CG_LoadingClient
CALLV
pop
line 860
;860:	CG_NewClientInfo(cg.clientNum);
ADDRGP4 cg+4
INDIRI4
ARGI4
ADDRGP4 CG_NewClientInfo
CALLV
pop
line 862
;861:
;862:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1251
line 865
;863:		const char *clientInfo;
;864:
;865:		if (cg.clientNum == i) {
ADDRGP4 cg+4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1255
line 866
;866:			continue;
ADDRGP4 $1252
JUMPV
LABELV $1255
line 869
;867:		}
;868:
;869:		clientInfo = CG_ConfigString(CS_PLAYERS + i);
ADDRLP4 0
INDIRI4
CNSTI4 529
ADDI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 870
;870:		if (!clientInfo[0]) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1258
line 871
;871:			continue;
ADDRGP4 $1252
JUMPV
LABELV $1258
line 873
;872:		}
;873:		CG_LoadingClient(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_LoadingClient
CALLV
pop
line 874
;874:		CG_NewClientInfo(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_NewClientInfo
CALLV
pop
line 875
;875:	}
LABELV $1252
line 862
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $1251
line 876
;876:	CG_BuildSpectatorString();
ADDRGP4 CG_BuildSpectatorString
CALLV
pop
line 877
;877:}
LABELV $1248
endproc CG_RegisterClients 12 4
export CG_ConfigString
proc CG_ConfigString 4 8
line 886
;878:
;879://===========================================================================
;880:
;881:/*
;882:=================
;883:CG_ConfigString
;884:=================
;885:*/
;886:const char *CG_ConfigString(int index) {
line 887
;887:	if (index < 0 || index >= MAX_CONFIGSTRINGS) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1263
ADDRLP4 0
INDIRI4
CNSTI4 1024
LTI4 $1261
LABELV $1263
line 888
;888:		CG_Error("CG_ConfigString: bad index: %i", index);
ADDRGP4 $1264
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 889
;889:		return "";
ADDRGP4 $154
RETP4
ADDRGP4 $1260
JUMPV
LABELV $1261
line 891
;890:	}
;891:	return cgs.gameState.stringData + cgs.gameState.stringOffsets[index];
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs
ADDP4
INDIRI4
ADDRGP4 cgs+4096
ADDP4
RETP4
LABELV $1260
endproc CG_ConfigString 4 8
export CG_StartMusic
proc CG_StartMusic 144 12
line 902
;892:}
;893:
;894://==================================================================
;895:
;896:/*
;897:======================
;898:CG_StartMusic
;899:
;900:======================
;901:*/
;902:void CG_StartMusic(void) {
line 907
;903:	char *s;
;904:	char	parm1[MAX_QPATH], parm2[MAX_QPATH];
;905:
;906:	// start the background music
;907:	s = (char *)CG_ConfigString(CS_MUSIC);
CNSTI4 2
ARGI4
ADDRLP4 132
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 132
INDIRP4
ASGNP4
line 908
;908:	Q_strncpyz(parm1, COM_Parse(&s), sizeof(parm1));
ADDRLP4 0
ARGP4
ADDRLP4 136
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 136
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 909
;909:	Q_strncpyz(parm2, COM_Parse(&s), sizeof(parm2));
ADDRLP4 0
ARGP4
ADDRLP4 140
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 68
ARGP4
ADDRLP4 140
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 911
;910:
;911:	trap_S_StartBackgroundTrack(parm1, parm2);
ADDRLP4 4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 trap_S_StartBackgroundTrack
CALLV
pop
line 912
;912:}
LABELV $1266
endproc CG_StartMusic 144 12
bss
align 1
LABELV $1268
skip 32768
export CG_GetMenuBuffer
code
proc CG_GetMenuBuffer 16 16
line 914
;913:
;914:char *CG_GetMenuBuffer(const char *filename) {
line 919
;915:	int	len;
;916:	fileHandle_t	f;
;917:	static char buf[MAX_MENUFILE];
;918:
;919:	len = trap_FS_FOpenFile(filename, &f, FS_READ);
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
line 920
;920:	if (!f) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1269
line 921
;921:		trap_Print(va(S_COLOR_RED "menu file not found: %s, using default\n", filename));
ADDRGP4 $1271
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
line 922
;922:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $1267
JUMPV
LABELV $1269
line 924
;923:	}
;924:	if (len >= MAX_MENUFILE) {
ADDRLP4 0
INDIRI4
CNSTI4 32768
LTI4 $1272
line 925
;925:		trap_Print(va(S_COLOR_RED "menu file too large: %s is %i, max allowed is %i\n", filename, len, MAX_MENUFILE));
ADDRGP4 $1274
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
line 926
;926:		trap_FS_FCloseFile(f);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 927
;927:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $1267
JUMPV
LABELV $1272
line 930
;928:	}
;929:
;930:	trap_FS_Read(buf, len, f);
ADDRGP4 $1268
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
line 931
;931:	buf[len] = 0;
ADDRLP4 0
INDIRI4
ADDRGP4 $1268
ADDP4
CNSTI1 0
ASGNI1
line 932
;932:	trap_FS_FCloseFile(f);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 934
;933:
;934:	return buf;
ADDRGP4 $1268
RETP4
LABELV $1267
endproc CG_GetMenuBuffer 16 16
export CG_Asset_Parse
proc CG_Asset_Parse 1124 12
line 942
;935:}
;936:
;937://
;938:// ==============================
;939:// new hud stuff ( mission pack )
;940:// ==============================
;941://
;942:qboolean CG_Asset_Parse(int handle) {
line 946
;943:	pc_token_t token;
;944:	const char *tempStr;
;945:
;946:	if (!trap_PC_ReadToken(handle, &token))
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
NEI4 $1276
line 947
;947:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1275
JUMPV
LABELV $1276
line 948
;948:	if (Q_stricmp(token.string, "{") != 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $1281
ARGP4
ADDRLP4 1048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
EQI4 $1283
line 949
;949:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1275
JUMPV
LABELV $1282
line 952
;950:	}
;951:
;952:	while (1) {
line 953
;953:		if (!trap_PC_ReadToken(handle, &token))
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
NEI4 $1285
line 954
;954:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1275
JUMPV
LABELV $1285
line 956
;955:
;956:		if (Q_stricmp(token.string, "}") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $1290
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $1287
line 957
;957:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1275
JUMPV
LABELV $1287
line 961
;958:		}
;959:
;960:		// font
;961:		if (Q_stricmp(token.string, "font") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $1294
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $1291
line 963
;962:			int pointSize;
;963:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
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
EQI4 $1297
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
NEI4 $1295
LABELV $1297
line 964
;964:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1275
JUMPV
LABELV $1295
line 966
;965:			}
;966:			cgDC.registerFont(tempStr, pointSize, &cgDC.Assets.textFont);
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1064
INDIRI4
ARGI4
ADDRGP4 cgDC+236+12
ARGP4
ADDRGP4 cgDC+64
INDIRP4
CALLV
pop
line 967
;967:			continue;
ADDRGP4 $1283
JUMPV
LABELV $1291
line 971
;968:		}
;969:
;970:		// smallFont
;971:		if (Q_stricmp(token.string, "smallFont") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $1304
ARGP4
ADDRLP4 1064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $1301
line 973
;972:			int pointSize;
;973:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
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
EQI4 $1307
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
NEI4 $1305
LABELV $1307
line 974
;974:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1275
JUMPV
LABELV $1305
line 976
;975:			}
;976:			cgDC.registerFont(tempStr, pointSize, &cgDC.Assets.smallFont);
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1068
INDIRI4
ARGI4
ADDRGP4 cgDC+236+20560
ARGP4
ADDRGP4 cgDC+64
INDIRP4
CALLV
pop
line 977
;977:			continue;
ADDRGP4 $1283
JUMPV
LABELV $1301
line 981
;978:		}
;979:
;980:		// font
;981:		if (Q_stricmp(token.string, "bigfont") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $1314
ARGP4
ADDRLP4 1068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
NEI4 $1311
line 983
;982:			int pointSize;
;983:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
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
EQI4 $1317
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
NEI4 $1315
LABELV $1317
line 984
;984:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1275
JUMPV
LABELV $1315
line 986
;985:			}
;986:			cgDC.registerFont(tempStr, pointSize, &cgDC.Assets.bigFont);
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1072
INDIRI4
ARGI4
ADDRGP4 cgDC+236+41108
ARGP4
ADDRGP4 cgDC+64
INDIRP4
CALLV
pop
line 987
;987:			continue;
ADDRGP4 $1283
JUMPV
LABELV $1311
line 991
;988:		}
;989:
;990:		// gradientbar
;991:		if (Q_stricmp(token.string, "gradientbar") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $1324
ARGP4
ADDRLP4 1072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $1321
line 992
;992:			if (!PC_String_Parse(handle, &tempStr)) {
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
NEI4 $1325
line 993
;993:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1275
JUMPV
LABELV $1325
line 995
;994:			}
;995:			cgDC.Assets.gradientBar = trap_R_RegisterShaderNoMip(tempStr);
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1080
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342500
ADDRLP4 1080
INDIRI4
ASGNI4
line 996
;996:			continue;
ADDRGP4 $1283
JUMPV
LABELV $1321
line 1000
;997:		}
;998:
;999:		// enterMenuSound
;1000:		if (Q_stricmp(token.string, "menuEnterSound") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $1332
ARGP4
ADDRLP4 1076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
NEI4 $1329
line 1001
;1001:			if (!PC_String_Parse(handle, &tempStr)) {
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
NEI4 $1333
line 1002
;1002:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1275
JUMPV
LABELV $1333
line 1004
;1003:			}
;1004:			cgDC.Assets.menuEnterSound = trap_S_RegisterSound(tempStr, qfalse);
ADDRLP4 1040
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1084
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342548
ADDRLP4 1084
INDIRI4
ASGNI4
line 1005
;1005:			continue;
ADDRGP4 $1283
JUMPV
LABELV $1329
line 1009
;1006:		}
;1007:
;1008:		// exitMenuSound
;1009:		if (Q_stricmp(token.string, "menuExitSound") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $1340
ARGP4
ADDRLP4 1080
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 0
NEI4 $1337
line 1010
;1010:			if (!PC_String_Parse(handle, &tempStr)) {
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
NEI4 $1341
line 1011
;1011:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1275
JUMPV
LABELV $1341
line 1013
;1012:			}
;1013:			cgDC.Assets.menuExitSound = trap_S_RegisterSound(tempStr, qfalse);
ADDRLP4 1040
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1088
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342552
ADDRLP4 1088
INDIRI4
ASGNI4
line 1014
;1014:			continue;
ADDRGP4 $1283
JUMPV
LABELV $1337
line 1018
;1015:		}
;1016:
;1017:		// itemFocusSound
;1018:		if (Q_stricmp(token.string, "itemFocusSound") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $1348
ARGP4
ADDRLP4 1084
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1084
INDIRI4
CNSTI4 0
NEI4 $1345
line 1019
;1019:			if (!PC_String_Parse(handle, &tempStr)) {
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
NEI4 $1349
line 1020
;1020:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1275
JUMPV
LABELV $1349
line 1022
;1021:			}
;1022:			cgDC.Assets.itemFocusSound = trap_S_RegisterSound(tempStr, qfalse);
ADDRLP4 1040
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1092
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342560
ADDRLP4 1092
INDIRI4
ASGNI4
line 1023
;1023:			continue;
ADDRGP4 $1283
JUMPV
LABELV $1345
line 1027
;1024:		}
;1025:
;1026:		// menuBuzzSound
;1027:		if (Q_stricmp(token.string, "menuBuzzSound") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $1356
ARGP4
ADDRLP4 1088
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1088
INDIRI4
CNSTI4 0
NEI4 $1353
line 1028
;1028:			if (!PC_String_Parse(handle, &tempStr)) {
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
NEI4 $1357
line 1029
;1029:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1275
JUMPV
LABELV $1357
line 1031
;1030:			}
;1031:			cgDC.Assets.menuBuzzSound = trap_S_RegisterSound(tempStr, qfalse);
ADDRLP4 1040
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1096
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342556
ADDRLP4 1096
INDIRI4
ASGNI4
line 1032
;1032:			continue;
ADDRGP4 $1283
JUMPV
LABELV $1353
line 1035
;1033:		}
;1034:
;1035:		if (Q_stricmp(token.string, "cursor") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $1364
ARGP4
ADDRLP4 1092
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1092
INDIRI4
CNSTI4 0
NEI4 $1361
line 1036
;1036:			if (!PC_String_Parse(handle, &cgDC.Assets.cursorStr)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 cgDC+236+4
ARGP4
ADDRLP4 1096
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 1096
INDIRI4
CNSTI4 0
NEI4 $1365
line 1037
;1037:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1275
JUMPV
LABELV $1365
line 1039
;1038:			}
;1039:			cgDC.Assets.cursor = trap_R_RegisterShaderNoMip(cgDC.Assets.cursorStr);
ADDRGP4 cgDC+236+4
INDIRP4
ARGP4
ADDRLP4 1100
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342496
ADDRLP4 1100
INDIRI4
ASGNI4
line 1040
;1040:			continue;
ADDRGP4 $1283
JUMPV
LABELV $1361
line 1043
;1041:		}
;1042:
;1043:		if (Q_stricmp(token.string, "fadeClamp") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $1376
ARGP4
ADDRLP4 1096
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1096
INDIRI4
CNSTI4 0
NEI4 $1373
line 1044
;1044:			if (!PC_Float_Parse(handle, &cgDC.Assets.fadeClamp)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 cgDC+236+5342564
ARGP4
ADDRLP4 1100
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 1100
INDIRI4
CNSTI4 0
NEI4 $1283
line 1045
;1045:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1275
JUMPV
line 1047
;1046:			}
;1047:			continue;
LABELV $1373
line 1050
;1048:		}
;1049:
;1050:		if (Q_stricmp(token.string, "fadeCycle") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $1384
ARGP4
ADDRLP4 1100
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1100
INDIRI4
CNSTI4 0
NEI4 $1381
line 1051
;1051:			if (!PC_Int_Parse(handle, &cgDC.Assets.fadeCycle)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 cgDC+236+5342568
ARGP4
ADDRLP4 1104
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 1104
INDIRI4
CNSTI4 0
NEI4 $1283
line 1052
;1052:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1275
JUMPV
line 1054
;1053:			}
;1054:			continue;
LABELV $1381
line 1057
;1055:		}
;1056:
;1057:		if (Q_stricmp(token.string, "fadeAmount") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $1392
ARGP4
ADDRLP4 1104
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1104
INDIRI4
CNSTI4 0
NEI4 $1389
line 1058
;1058:			if (!PC_Float_Parse(handle, &cgDC.Assets.fadeAmount)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 cgDC+236+5342572
ARGP4
ADDRLP4 1108
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 0
NEI4 $1283
line 1059
;1059:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1275
JUMPV
line 1061
;1060:			}
;1061:			continue;
LABELV $1389
line 1064
;1062:		}
;1063:
;1064:		if (Q_stricmp(token.string, "shadowX") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $1400
ARGP4
ADDRLP4 1108
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 0
NEI4 $1397
line 1065
;1065:			if (!PC_Float_Parse(handle, &cgDC.Assets.shadowX)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 cgDC+236+5342576
ARGP4
ADDRLP4 1112
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
NEI4 $1283
line 1066
;1066:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1275
JUMPV
line 1068
;1067:			}
;1068:			continue;
LABELV $1397
line 1071
;1069:		}
;1070:
;1071:		if (Q_stricmp(token.string, "shadowY") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $1408
ARGP4
ADDRLP4 1112
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
NEI4 $1405
line 1072
;1072:			if (!PC_Float_Parse(handle, &cgDC.Assets.shadowY)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 cgDC+236+5342580
ARGP4
ADDRLP4 1116
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
NEI4 $1283
line 1073
;1073:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1275
JUMPV
line 1075
;1074:			}
;1075:			continue;
LABELV $1405
line 1078
;1076:		}
;1077:
;1078:		if (Q_stricmp(token.string, "shadowColor") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $1416
ARGP4
ADDRLP4 1116
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
NEI4 $1413
line 1079
;1079:			if (!PC_Color_Parse(handle, &cgDC.Assets.shadowColor)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 cgDC+236+5342584
ARGP4
ADDRLP4 1120
ADDRGP4 PC_Color_Parse
CALLI4
ASGNI4
ADDRLP4 1120
INDIRI4
CNSTI4 0
NEI4 $1417
line 1080
;1080:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1275
JUMPV
LABELV $1417
line 1082
;1081:			}
;1082:			cgDC.Assets.shadowFadeClamp = cgDC.Assets.shadowColor[3];
ADDRGP4 cgDC+236+5342600
ADDRGP4 cgDC+236+5342584+12
INDIRF4
ASGNF4
line 1083
;1083:			continue;
LABELV $1413
line 1085
;1084:		}
;1085:	}
LABELV $1283
line 952
ADDRGP4 $1282
JUMPV
line 1086
;1086:	return qfalse;
CNSTI4 0
RETI4
LABELV $1275
endproc CG_Asset_Parse 1124 12
export CG_ParseMenu
proc CG_ParseMenu 1064 8
line 1089
;1087:}
;1088:
;1089:void CG_ParseMenu(const char *menuFile) {
line 1093
;1090:	pc_token_t token;
;1091:	int handle;
;1092:
;1093:	handle = trap_PC_LoadSource(menuFile);
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
line 1094
;1094:	if (!handle)
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $1427
line 1095
;1095:		handle = trap_PC_LoadSource("ui/testhud.menu");
ADDRGP4 $1429
ARGP4
ADDRLP4 1048
ADDRGP4 trap_PC_LoadSource
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1048
INDIRI4
ASGNI4
LABELV $1427
line 1096
;1096:	if (!handle)
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $1433
line 1097
;1097:		return;
ADDRGP4 $1426
JUMPV
LABELV $1432
line 1099
;1098:
;1099:	while (1) {
line 1100
;1100:		if (!trap_PC_ReadToken(handle, &token)) {
ADDRLP4 1040
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
NEI4 $1435
line 1101
;1101:			break;
ADDRGP4 $1434
JUMPV
LABELV $1435
line 1114
;1102:		}
;1103:
;1104:		//if ( Q_stricmp( token, "{" ) ) {
;1105:		//	Com_Printf( "Missing { in menu file\n" );
;1106:		//	break;
;1107:		//}
;1108:
;1109:		//if ( menuCount == MAX_MENUS ) {
;1110:		//	Com_Printf( "Too many menus!\n" );
;1111:		//	break;
;1112:		//}
;1113:
;1114:		if (token.string[0] == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $1437
line 1115
;1115:			break;
ADDRGP4 $1434
JUMPV
LABELV $1437
line 1118
;1116:		}
;1117:
;1118:		if (Q_stricmp(token.string, "assetGlobalDef") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $1443
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $1440
line 1119
;1119:			if (CG_Asset_Parse(handle)) {
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 1060
ADDRGP4 CG_Asset_Parse
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
EQI4 $1434
line 1120
;1120:				continue;
ADDRGP4 $1433
JUMPV
line 1121
;1121:			} else {
line 1122
;1122:				break;
LABELV $1440
line 1127
;1123:			}
;1124:		}
;1125:
;1126:
;1127:		if (Q_stricmp(token.string, "menudef") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $1449
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $1446
line 1129
;1128:			// start a new menu
;1129:			Menu_New(handle);
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 Menu_New
CALLV
pop
line 1130
;1130:		}
LABELV $1446
line 1131
;1131:	}
LABELV $1433
line 1099
ADDRGP4 $1432
JUMPV
LABELV $1434
line 1132
;1132:	trap_PC_FreeSource(handle);
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 trap_PC_FreeSource
CALLI4
pop
line 1133
;1133:}
LABELV $1426
endproc CG_ParseMenu 1064 8
export CG_Load_Menu
proc CG_Load_Menu 20 8
line 1135
;1134:
;1135:qboolean CG_Load_Menu(char **p) {
line 1138
;1136:	char *token;
;1137:
;1138:	token = COM_ParseExt(p, qtrue);
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
line 1140
;1139:
;1140:	if (token[0] != '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $1454
line 1141
;1141:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1450
JUMPV
LABELV $1453
line 1144
;1142:	}
;1143:
;1144:	while (1) {
line 1146
;1145:
;1146:		token = COM_ParseExt(p, qtrue);
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
line 1148
;1147:
;1148:		if (Q_stricmp(token, "}") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1290
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $1456
line 1149
;1149:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1450
JUMPV
LABELV $1456
line 1152
;1150:		}
;1151:
;1152:		if (!token || token[0] == 0) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1460
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1458
LABELV $1460
line 1153
;1153:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1450
JUMPV
LABELV $1458
line 1156
;1154:		}
;1155:
;1156:		CG_ParseMenu(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_ParseMenu
CALLV
pop
line 1157
;1157:	}
LABELV $1454
line 1144
ADDRGP4 $1453
JUMPV
line 1158
;1158:	return qfalse;
CNSTI4 0
RETI4
LABELV $1450
endproc CG_Load_Menu 20 8
bss
align 1
LABELV $1462
skip 4096
export CG_LoadMenus
code
proc CG_LoadMenus 52 16
line 1163
;1159:}
;1160:
;1161:
;1162:
;1163:void CG_LoadMenus(const char *menuFile) {
line 1170
;1164:	char *token;
;1165:	char *p;
;1166:	int	len, start;
;1167:	fileHandle_t	f;
;1168:	static char buf[MAX_MENUDEFFILE];
;1169:
;1170:	start = trap_Milliseconds();
ADDRLP4 20
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 20
INDIRI4
ASGNI4
line 1172
;1171:
;1172:	len = trap_FS_FOpenFile(menuFile, &f, FS_READ);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 24
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 24
INDIRI4
ASGNI4
line 1173
;1173:	if (!f) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $1463
line 1174
;1174:		trap_Error(va(S_COLOR_YELLOW "menu file not found: %s, using default\n", menuFile));
ADDRGP4 $1465
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 1175
;1175:		len = trap_FS_FOpenFile("ui/hud.txt", &f, FS_READ);
ADDRGP4 $205
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 32
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 32
INDIRI4
ASGNI4
line 1176
;1176:		if (!f) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $1466
line 1177
;1177:			trap_Error(va(S_COLOR_RED "default menu file not found: ui/hud.txt, unable to continue!\n", menuFile));
ADDRGP4 $1468
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 1178
;1178:		}
LABELV $1466
line 1179
;1179:	}
LABELV $1463
line 1181
;1180:
;1181:	if (len >= MAX_MENUDEFFILE) {
ADDRLP4 12
INDIRI4
CNSTI4 4096
LTI4 $1469
line 1182
;1182:		trap_FS_FCloseFile(f);
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 1183
;1183:		trap_Error(va(S_COLOR_RED "menu file too large: %s is %i, max allowed is %i", menuFile, len, MAX_MENUDEFFILE));
ADDRGP4 $1471
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
CNSTI4 4096
ARGI4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 1184
;1184:		return;
ADDRGP4 $1461
JUMPV
LABELV $1469
line 1187
;1185:	}
;1186:
;1187:	trap_FS_Read(buf, len, f);
ADDRGP4 $1462
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 1188
;1188:	buf[len] = 0;
ADDRLP4 12
INDIRI4
ADDRGP4 $1462
ADDP4
CNSTI1 0
ASGNI1
line 1189
;1189:	trap_FS_FCloseFile(f);
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 1191
;1190:
;1191:	COM_Compress(buf);
ADDRGP4 $1462
ARGP4
ADDRGP4 COM_Compress
CALLI4
pop
line 1193
;1192:
;1193:	Menu_Reset();
ADDRGP4 Menu_Reset
CALLV
pop
line 1195
;1194:
;1195:	p = buf;
ADDRLP4 4
ADDRGP4 $1462
ASGNP4
ADDRGP4 $1473
JUMPV
LABELV $1472
line 1197
;1196:
;1197:	while (1) {
line 1198
;1198:		token = COM_ParseExt(&p, qtrue);
ADDRLP4 4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 28
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 1199
;1199:		if (!token || token[0] == 0 || token[0] == '}') {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1478
ADDRLP4 36
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $1478
ADDRLP4 36
INDIRI4
CNSTI4 125
NEI4 $1475
LABELV $1478
line 1200
;1200:			break;
ADDRGP4 $1474
JUMPV
LABELV $1475
line 1203
;1201:		}
;1202:
;1203:		if (Q_stricmp(token, "}") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1290
ARGP4
ADDRLP4 40
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $1479
line 1204
;1204:			break;
ADDRGP4 $1474
JUMPV
LABELV $1479
line 1207
;1205:		}
;1206:
;1207:		if (Q_stricmp(token, "loadmenu") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1483
ARGP4
ADDRLP4 44
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $1481
line 1208
;1208:			if (CG_Load_Menu(&p)) {
ADDRLP4 4
ARGP4
ADDRLP4 48
ADDRGP4 CG_Load_Menu
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $1474
line 1209
;1209:				continue;
line 1210
;1210:			} else {
line 1211
;1211:				break;
LABELV $1481
line 1214
;1212:			}
;1213:		}
;1214:	}
LABELV $1473
line 1197
ADDRGP4 $1472
JUMPV
LABELV $1474
line 1216
;1215:
;1216:	Com_Printf("UI menu load time = %d milli seconds\n", trap_Milliseconds() - start);
ADDRLP4 28
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRGP4 $1486
ARGP4
ADDRLP4 28
INDIRI4
ADDRLP4 16
INDIRI4
SUBI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1218
;1217:
;1218:}
LABELV $1461
endproc CG_LoadMenus 52 16
proc CG_OwnerDrawHandleKey 0 0
line 1222
;1219:
;1220:
;1221:
;1222:static qboolean CG_OwnerDrawHandleKey(int ownerDraw, int flags, int flags2, float *special, int key) {
line 1223
;1223:	return qfalse;
CNSTI4 0
RETI4
LABELV $1487
endproc CG_OwnerDrawHandleKey 0 0
proc CG_FeederCount 8 0
line 1227
;1224:}
;1225:
;1226:
;1227:static int CG_FeederCount(float feederID) {
line 1229
;1228:	int i, count;
;1229:	count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1230
;1230:	if (feederID == FEEDER_REDTEAM_LIST) {
ADDRFP4 0
INDIRF4
CNSTF4 1084227584
NEF4 $1489
line 1231
;1231:		for (i = 0; i < cg.numScores; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1494
JUMPV
LABELV $1491
line 1232
;1232:			if (cg.scores[i].team == TEAM_RED) {
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492+56
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1496
line 1233
;1233:				count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1234
;1234:			}
LABELV $1496
line 1235
;1235:		}
LABELV $1492
line 1231
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1494
ADDRLP4 0
INDIRI4
ADDRGP4 cg+110476
INDIRI4
LTI4 $1491
line 1236
;1236:	} else if (feederID == FEEDER_BLUETEAM_LIST) {
ADDRGP4 $1490
JUMPV
LABELV $1489
ADDRFP4 0
INDIRF4
CNSTF4 1086324736
NEF4 $1500
line 1237
;1237:		for (i = 0; i < cg.numScores; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1505
JUMPV
LABELV $1502
line 1238
;1238:			if (cg.scores[i].team == TEAM_BLUE) {
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492+56
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1507
line 1239
;1239:				count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1240
;1240:			}
LABELV $1507
line 1241
;1241:		}
LABELV $1503
line 1237
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1505
ADDRLP4 0
INDIRI4
ADDRGP4 cg+110476
INDIRI4
LTI4 $1502
line 1242
;1242:	} else if (feederID == FEEDER_SCOREBOARD) {
ADDRGP4 $1501
JUMPV
LABELV $1500
ADDRFP4 0
INDIRF4
CNSTF4 1093664768
NEF4 $1511
line 1243
;1243:		return cg.numScores;
ADDRGP4 cg+110476
INDIRI4
RETI4
ADDRGP4 $1488
JUMPV
LABELV $1511
LABELV $1501
LABELV $1490
line 1245
;1244:	}
;1245:	return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $1488
endproc CG_FeederCount 8 0
export CG_SetScoreSelection
proc CG_SetScoreSelection 28 16
line 1249
;1246:}
;1247:
;1248:
;1249:void CG_SetScoreSelection(void *p) {
line 1250
;1250:	menuDef_t *menu = (menuDef_t *)p;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
line 1251
;1251:	playerState_t *ps = &cg.snap->ps;
ADDRLP4 4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 1253
;1252:	int i, red, blue;
;1253:	red = blue = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 12
ADDRLP4 20
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 20
INDIRI4
ASGNI4
line 1254
;1254:	for (i = 0; i < cg.numScores; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1519
JUMPV
LABELV $1516
line 1255
;1255:		if (cg.scores[i].team == TEAM_RED) {
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492+56
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1521
line 1256
;1256:			red++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1257
;1257:		} else if (cg.scores[i].team == TEAM_BLUE) {
ADDRGP4 $1522
JUMPV
LABELV $1521
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492+56
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1525
line 1258
;1258:			blue++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1259
;1259:		}
LABELV $1525
LABELV $1522
line 1260
;1260:		if (ps->clientNum == cg.scores[i].client) {
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492
ADDP4
INDIRI4
NEI4 $1529
line 1261
;1261:			cg.selectedScore = i;
ADDRGP4 cg+110480
ADDRLP4 0
INDIRI4
ASGNI4
line 1262
;1262:		}
LABELV $1529
line 1263
;1263:	}
LABELV $1517
line 1254
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1519
ADDRLP4 0
INDIRI4
ADDRGP4 cg+110476
INDIRI4
LTI4 $1516
line 1265
;1264:
;1265:	if (menu == NULL) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1533
line 1267
;1266:		// just interested in setting the selected score
;1267:		return;
ADDRGP4 $1514
JUMPV
LABELV $1533
line 1270
;1268:	}
;1269:
;1270:	if (cgs.gametype >= GT_TEAM) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $1535
line 1271
;1271:		int feeder = FEEDER_REDTEAM_LIST;
ADDRLP4 24
CNSTI4 5
ASGNI4
line 1272
;1272:		i = red;
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1273
;1273:		if (cg.scores[cg.selectedScore].team == TEAM_BLUE) {
ADDRGP4 cg+110480
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492+56
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1538
line 1274
;1274:			feeder = FEEDER_BLUETEAM_LIST;
ADDRLP4 24
CNSTI4 6
ASGNI4
line 1275
;1275:			i = blue;
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 1276
;1276:		}
LABELV $1538
line 1277
;1277:		Menu_SetFeederSelection(menu, feeder, i, NULL);
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 1278
;1278:	} else {
ADDRGP4 $1536
JUMPV
LABELV $1535
line 1279
;1279:		Menu_SetFeederSelection(menu, FEEDER_SCOREBOARD, cg.selectedScore, NULL);
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 11
ARGI4
ADDRGP4 cg+110480
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 1280
;1280:	}
LABELV $1536
line 1281
;1281:}
LABELV $1514
endproc CG_SetScoreSelection 28 16
proc CG_InfoFromScoreIndex 8 0
line 1284
;1282:
;1283:// FIXME: might need to cache this info
;1284:static clientInfo_t *CG_InfoFromScoreIndex(int index, int team, int *scoreIndex) {
line 1286
;1285:	int i, count;
;1286:	if (cgs.gametype >= GT_TEAM) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $1545
line 1287
;1287:		count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1288
;1288:		for (i = 0; i < cg.numScores; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1551
JUMPV
LABELV $1548
line 1289
;1289:			if (cg.scores[i].team == team) {
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492+56
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1553
line 1290
;1290:				if (count == index) {
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $1557
line 1291
;1291:					*scoreIndex = i;
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1292
;1292:					return &cgs.clientinfo[cg.scores[i].client];
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+38916
ADDP4
RETP4
ADDRGP4 $1544
JUMPV
LABELV $1557
line 1294
;1293:				}
;1294:				count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1295
;1295:			}
LABELV $1553
line 1296
;1296:		}
LABELV $1549
line 1288
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1551
ADDRLP4 0
INDIRI4
ADDRGP4 cg+110476
INDIRI4
LTI4 $1548
line 1297
;1297:	}
LABELV $1545
line 1298
;1298:	*scoreIndex = index;
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1299
;1299:	return &cgs.clientinfo[cg.scores[index].client];
ADDRFP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492
ADDP4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+38916
ADDP4
RETP4
LABELV $1544
endproc CG_InfoFromScoreIndex 8 0
proc CG_FeederItemText 44 12
line 1302
;1300:}
;1301:
;1302:static const char *CG_FeederItemText(float feederID, int index, int column, qhandle_t *handle) {
line 1304
;1303:	gitem_t *item;
;1304:	int scoreIndex = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1305
;1305:	clientInfo_t *info = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 1306
;1306:	int team = -1;
ADDRLP4 8
CNSTI4 -1
ASGNI4
line 1307
;1307:	score_t *sp = NULL;
ADDRLP4 12
CNSTP4 0
ASGNP4
line 1309
;1308:
;1309:	*handle = -1;
ADDRFP4 12
INDIRP4
CNSTI4 -1
ASGNI4
line 1311
;1310:
;1311:	if (feederID == FEEDER_REDTEAM_LIST) {
ADDRFP4 0
INDIRF4
CNSTF4 1084227584
NEF4 $1564
line 1312
;1312:		team = TEAM_RED;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 1313
;1313:	} else if (feederID == FEEDER_BLUETEAM_LIST) {
ADDRGP4 $1565
JUMPV
LABELV $1564
ADDRFP4 0
INDIRF4
CNSTF4 1086324736
NEF4 $1566
line 1314
;1314:		team = TEAM_BLUE;
ADDRLP4 8
CNSTI4 2
ASGNI4
line 1315
;1315:	}
LABELV $1566
LABELV $1565
line 1317
;1316:
;1317:	info = CG_InfoFromScoreIndex(index, team, &scoreIndex);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 20
ADDRGP4 CG_InfoFromScoreIndex
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 1318
;1318:	sp = &cg.scores[scoreIndex];
ADDRLP4 12
ADDRLP4 4
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492
ADDP4
ASGNP4
line 1320
;1319:
;1320:	if (info && info->infoValid) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1569
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $1569
line 1321
;1321:		switch (column) {
ADDRLP4 28
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $1571
ADDRLP4 28
INDIRI4
CNSTI4 6
GTI4 $1571
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1619
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1619
address $1573
address $1591
address $1594
address $1611
address $1612
address $1613
address $1615
code
LABELV $1573
line 1323
;1322:		case 0:
;1323:			if (info->powerups & (1 << PW_NEUTRALFLAG)) {
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1574
line 1324
;1324:				item = BG_FindItemForPowerup(PW_NEUTRALFLAG);
CNSTI4 9
ARGI4
ADDRLP4 32
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 32
INDIRP4
ASGNP4
line 1325
;1325:				*handle = cg_items[ITEM_INDEX(item)].icon;
ADDRFP4 12
INDIRP4
ADDRLP4 16
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 28
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ASGNI4
line 1326
;1326:			} else if (info->powerups & (1 << PW_REDFLAG)) {
ADDRGP4 $1572
JUMPV
LABELV $1574
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $1577
line 1327
;1327:				item = BG_FindItemForPowerup(PW_REDFLAG);
CNSTI4 7
ARGI4
ADDRLP4 32
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 32
INDIRP4
ASGNP4
line 1328
;1328:				*handle = cg_items[ITEM_INDEX(item)].icon;
ADDRFP4 12
INDIRP4
ADDRLP4 16
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 28
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ASGNI4
line 1329
;1329:			} else if (info->powerups & (1 << PW_BLUEFLAG)) {
ADDRGP4 $1572
JUMPV
LABELV $1577
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $1580
line 1330
;1330:				item = BG_FindItemForPowerup(PW_BLUEFLAG);
CNSTI4 8
ARGI4
ADDRLP4 32
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 32
INDIRP4
ASGNP4
line 1331
;1331:				*handle = cg_items[ITEM_INDEX(item)].icon;
ADDRFP4 12
INDIRP4
ADDRLP4 16
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
CNSTI4 28
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ASGNI4
line 1332
;1332:			} else {
ADDRGP4 $1572
JUMPV
LABELV $1580
line 1333
;1333:				if (info->botSkill > 0 && info->botSkill <= 5) {
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1583
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 5
GTI4 $1583
line 1334
;1334:					*handle = cgs.media.botSkillShaders[info->botSkill - 1];
ADDRFP4 12
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+146664+468-4
ADDP4
INDIRI4
ASGNI4
line 1335
;1335:				} else if (info->handicap < 100) {
ADDRGP4 $1572
JUMPV
LABELV $1583
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 100
GEI4 $1572
line 1336
;1336:					return va("%i", info->handicap);
ADDRGP4 $1590
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
RETP4
ADDRGP4 $1563
JUMPV
line 1338
;1337:				}
;1338:			}
line 1339
;1339:			break;
LABELV $1591
line 1341
;1340:		case 1:
;1341:			if (team == -1) {
ADDRLP4 8
INDIRI4
CNSTI4 -1
NEI4 $1592
line 1342
;1342:				return "";
ADDRGP4 $154
RETP4
ADDRGP4 $1563
JUMPV
LABELV $1592
line 1343
;1343:			} else {
line 1344
;1344:				*handle = CG_StatusHandle(info->teamTask);
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 CG_StatusHandle
CALLI4
ASGNI4
ADDRFP4 12
INDIRP4
ADDRLP4 32
INDIRI4
ASGNI4
line 1345
;1345:			}
line 1346
;1346:			break;
ADDRGP4 $1572
JUMPV
LABELV $1594
line 1348
;1347:		case 2:
;1348:			if (cg.snap->ps.stats[STAT_CLIENTS_READY] & (1 << sp->client)) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 12
INDIRP4
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $1595
line 1349
;1349:				return "Ready";
ADDRGP4 $1598
RETP4
ADDRGP4 $1563
JUMPV
LABELV $1595
line 1351
;1350:			}
;1351:			if (team == -1) {
ADDRLP4 8
INDIRI4
CNSTI4 -1
NEI4 $1599
line 1352
;1352:				if (cgs.gametype == GT_DUEL) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 1
NEI4 $1601
line 1353
;1353:					return va("%i/%i", info->wins, info->losses);
ADDRGP4 $1604
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
RETP4
ADDRGP4 $1563
JUMPV
LABELV $1601
line 1354
;1354:				} else if (info->infoValid && info->team == TEAM_SPECTATOR) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $1605
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1605
line 1355
;1355:					return "Spectator";
ADDRGP4 $1607
RETP4
ADDRGP4 $1563
JUMPV
LABELV $1605
line 1356
;1356:				} else {
line 1357
;1357:					return "";
ADDRGP4 $154
RETP4
ADDRGP4 $1563
JUMPV
LABELV $1599
line 1359
;1358:				}
;1359:			} else {
line 1360
;1360:				if (info->teamLeader) {
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1572
line 1361
;1361:					return "Leader";
ADDRGP4 $1610
RETP4
ADDRGP4 $1563
JUMPV
line 1363
;1362:				}
;1363:			}
line 1364
;1364:			break;
LABELV $1611
line 1366
;1365:		case 3:
;1366:			return info->name;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
RETP4
ADDRGP4 $1563
JUMPV
line 1367
;1367:			break;
LABELV $1612
line 1369
;1368:		case 4:
;1369:			return va("%i", info->score);
ADDRGP4 $1590
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
RETP4
ADDRGP4 $1563
JUMPV
line 1370
;1370:			break;
LABELV $1613
line 1372
;1371:		case 5:
;1372:			return va("%4i", sp->time);
ADDRGP4 $1614
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
RETP4
ADDRGP4 $1563
JUMPV
line 1373
;1373:			break;
LABELV $1615
line 1375
;1374:		case 6:
;1375:			if (sp->ping == -1) {
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1616
line 1376
;1376:				return "connecting";
ADDRGP4 $1618
RETP4
ADDRGP4 $1563
JUMPV
LABELV $1616
line 1378
;1377:			}
;1378:			return va("%4i", sp->ping);
ADDRGP4 $1614
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 40
INDIRP4
RETP4
ADDRGP4 $1563
JUMPV
line 1379
;1379:			break;
LABELV $1571
LABELV $1572
line 1381
;1380:		}
;1381:	}
LABELV $1569
line 1383
;1382:
;1383:	return "";
ADDRGP4 $154
RETP4
LABELV $1563
endproc CG_FeederItemText 44 12
proc CG_FeederItemImage 0 0
line 1386
;1384:}
;1385:
;1386:static qhandle_t CG_FeederItemImage(float feederID, int index) {
line 1387
;1387:	return 0;
CNSTI4 0
RETI4
LABELV $1620
endproc CG_FeederItemImage 0 0
proc CG_FeederSelection 16 0
line 1390
;1388:}
;1389:
;1390:static void CG_FeederSelection(float feederID, int index) {
line 1391
;1391:	if (cgs.gametype >= GT_TEAM) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
LTI4 $1622
line 1393
;1392:		int i, count;
;1393:		int team = (feederID == FEEDER_REDTEAM_LIST) ? TEAM_RED : TEAM_BLUE;
ADDRFP4 0
INDIRF4
CNSTF4 1084227584
NEF4 $1626
ADDRLP4 12
CNSTI4 1
ASGNI4
ADDRGP4 $1627
JUMPV
LABELV $1626
ADDRLP4 12
CNSTI4 2
ASGNI4
LABELV $1627
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 1394
;1394:		count = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1395
;1395:		for (i = 0; i < cg.numScores; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1631
JUMPV
LABELV $1628
line 1396
;1396:			if (cg.scores[i].team == team) {
ADDRLP4 0
INDIRI4
CNSTI4 76
MULI4
ADDRGP4 cg+110492+56
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $1633
line 1397
;1397:				if (index == count) {
ADDRFP4 4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $1637
line 1398
;1398:					cg.selectedScore = i;
ADDRGP4 cg+110480
ADDRLP4 0
INDIRI4
ASGNI4
line 1399
;1399:				}
LABELV $1637
line 1400
;1400:				count++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1401
;1401:			}
LABELV $1633
line 1402
;1402:		}
LABELV $1629
line 1395
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1631
ADDRLP4 0
INDIRI4
ADDRGP4 cg+110476
INDIRI4
LTI4 $1628
line 1403
;1403:	} else {
ADDRGP4 $1623
JUMPV
LABELV $1622
line 1404
;1404:		cg.selectedScore = index;
ADDRGP4 cg+110480
ADDRFP4 4
INDIRI4
ASGNI4
line 1405
;1405:	}
LABELV $1623
line 1406
;1406:}
LABELV $1621
endproc CG_FeederSelection 16 0
proc CG_Cvar_Get 132 12
line 1409
;1407:
;1408:
;1409:static float CG_Cvar_Get(const char *cvar) {
line 1411
;1410:	char buff[128];
;1411:	memset(buff, 0, sizeof(buff));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 128
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1412
;1412:	trap_Cvar_VariableStringBuffer(cvar, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1413
;1413:	return atof(buff);
ADDRLP4 0
ARGP4
ADDRLP4 128
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 128
INDIRF4
RETF4
LABELV $1641
endproc CG_Cvar_Get 132 12
export CG_Text_PaintWithCursor
proc CG_Text_PaintWithCursor 0 40
ADDRFP4 24
ADDRFP4 24
INDIRI4
CVII1 4
ASGNI1
line 1416
;1414:}
;1415:
;1416:void CG_Text_PaintWithCursor(float x, float y, float scale, const vec4_t color, const char *text, int cursorPos, char cursor, int limit, int style, int fontIndex, int widescreen) { //, rectDef_t menuRect) {
line 1417
;1417:	CG_Text_Paint(x, y, scale, color, text, 0, limit, style, fontIndex, widescreen); //, menuRect);
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
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRFP4 28
INDIRI4
ARGI4
ADDRFP4 32
INDIRI4
ARGI4
ADDRFP4 36
INDIRI4
ARGI4
ADDRFP4 40
INDIRI4
ARGI4
ADDRGP4 CG_Text_Paint
CALLV
pop
line 1418
;1418:}
LABELV $1642
endproc CG_Text_PaintWithCursor 0 40
proc CG_OwnerDrawWidth 40 20
line 1420
;1419:
;1420:static float CG_OwnerDrawWidth(int ownerDraw, float scale, int fontIndex, int widescreen) { //, rectDef_t menuRect) {
line 1421
;1421:	switch (ownerDraw) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 63
EQI4 $1649
ADDRLP4 0
INDIRI4
CNSTI4 63
GTI4 $1655
LABELV $1654
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
EQI4 $1646
ADDRLP4 4
INDIRI4
CNSTI4 7
EQI4 $1648
ADDRGP4 $1644
JUMPV
LABELV $1655
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 285
EQI4 $1650
ADDRLP4 8
INDIRI4
CNSTI4 285
LTI4 $1644
LABELV $1656
ADDRFP4 0
INDIRI4
CNSTI4 311
EQI4 $1652
ADDRGP4 $1644
JUMPV
LABELV $1646
line 1423
;1422:	case CG_GAME_TYPE:
;1423:		return CG_Text_Width(gametypeString[cgs.gametype], scale, 0, fontIndex, widescreen); //, menuRect);
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gametypeString
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 CG_Text_Width
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
RETF4
ADDRGP4 $1643
JUMPV
LABELV $1648
line 1425
;1424:	case CG_GAME_STATUS:
;1425:		return CG_Text_Width(CG_GetGameStatusText(), scale, 0, fontIndex, widescreen); //, menuRect);
ADDRLP4 16
ADDRGP4 CG_GetGameStatusText
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 CG_Text_Width
CALLF4
ASGNF4
ADDRLP4 20
INDIRF4
RETF4
ADDRGP4 $1643
JUMPV
line 1426
;1426:		break;
LABELV $1649
line 1428
;1427:	case CG_KILLER:
;1428:		return CG_Text_Width(CG_GetKillerText(), scale, 0, fontIndex, widescreen); //, menuRect);
ADDRLP4 24
ADDRGP4 CG_GetKillerText
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 CG_Text_Width
CALLF4
ASGNF4
ADDRLP4 28
INDIRF4
RETF4
ADDRGP4 $1643
JUMPV
line 1429
;1429:		break;
LABELV $1650
line 1431
;1430:	case CG_RED_NAME:
;1431:		return CG_Text_Width(cg_redTeamName.string, scale, 0, fontIndex, widescreen); //, menuRect);
ADDRGP4 cg_redTeamName+16
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 CG_Text_Width
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
RETF4
ADDRGP4 $1643
JUMPV
line 1432
;1432:		break;
LABELV $1652
line 1434
;1433:	case CG_BLUE_NAME:
;1434:		return CG_Text_Width(cg_blueTeamName.string, scale, 0, fontIndex, widescreen); //, menuRect);
ADDRGP4 cg_blueTeamName+16
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 CG_Text_Width
CALLF4
ASGNF4
ADDRLP4 36
INDIRF4
RETF4
ADDRGP4 $1643
JUMPV
line 1435
;1435:		break;
LABELV $1644
line 1437
;1436:	}
;1437:	return 0;
CNSTF4 0
RETF4
LABELV $1643
endproc CG_OwnerDrawWidth 40 20
proc CG_PlayCinematic 4 24
line 1440
;1438:}
;1439:
;1440:static int CG_PlayCinematic(const char *name, float x, float y, float w, float h, int widescreen) { //, rectDef_t menuRect) {
line 1441
;1441:	return trap_CIN_PlayCinematic(name, x, y, w, h, CIN_loop);
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
CNSTI4 2
ARGI4
ADDRLP4 0
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $1657
endproc CG_PlayCinematic 4 24
proc CG_StopCinematic 0 4
line 1444
;1442:}
;1443:
;1444:static void CG_StopCinematic(int handle) {
line 1445
;1445:	trap_CIN_StopCinematic(handle);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 1446
;1446:}
LABELV $1658
endproc CG_StopCinematic 0 4
proc CG_DrawCinematic 0 20
line 1448
;1447:
;1448:static void CG_DrawCinematic(int handle, float x, float y, float w, float h, int widescreen) { //, rectDef_t menuRect) {
line 1449
;1449:	trap_CIN_SetExtents(handle, x, y, w, h);
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
line 1450
;1450:	trap_CIN_DrawCinematic(handle);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 trap_CIN_DrawCinematic
CALLV
pop
line 1451
;1451:}
LABELV $1659
endproc CG_DrawCinematic 0 20
proc CG_RunCinematicFrame 0 4
line 1453
;1452:
;1453:static void CG_RunCinematicFrame(int handle) {
line 1454
;1454:	trap_CIN_RunCinematic(handle);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 trap_CIN_RunCinematic
CALLI4
pop
line 1455
;1455:}
LABELV $1660
endproc CG_RunCinematicFrame 0 4
proc CG_LoadHudMenu 1028 12
line 1463
;1456:
;1457:/*
;1458:=================
;1459:CG_LoadHudMenu();
;1460:
;1461:=================
;1462:*/
;1463:static void CG_LoadHudMenu(void) {
line 1467
;1464:	char buff[1024];
;1465:	const char *hudSet;
;1466:
;1467:	cgDC.registerShaderNoMip = &trap_R_RegisterShaderNoMip;
ADDRGP4 cgDC
ADDRGP4 trap_R_RegisterShaderNoMip
ASGNP4
line 1468
;1468:	cgDC.setColor = &trap_R_SetColor;
ADDRGP4 cgDC+4
ADDRGP4 trap_R_SetColor
ASGNP4
line 1469
;1469:	cgDC.drawHandlePic = &CG_DrawPic;
ADDRGP4 cgDC+8
ADDRGP4 CG_DrawPic
ASGNP4
line 1470
;1470:	cgDC.drawStretchPic = &CG_DrawStretchPic;
ADDRGP4 cgDC+12
ADDRGP4 CG_DrawStretchPic
ASGNP4
line 1471
;1471:	cgDC.drawText = &CG_Text_Paint;
ADDRGP4 cgDC+16
ADDRGP4 CG_Text_Paint
ASGNP4
line 1472
;1472:	cgDC.textWidth = &CG_Text_Width;
ADDRGP4 cgDC+20
ADDRGP4 CG_Text_Width
ASGNP4
line 1473
;1473:	cgDC.textHeight = &CG_Text_Height;
ADDRGP4 cgDC+24
ADDRGP4 CG_Text_Height
ASGNP4
line 1474
;1474:	cgDC.registerModel = &trap_R_RegisterModel;
ADDRGP4 cgDC+28
ADDRGP4 trap_R_RegisterModel
ASGNP4
line 1475
;1475:	cgDC.modelBounds = &trap_R_ModelBounds;
ADDRGP4 cgDC+32
ADDRGP4 trap_R_ModelBounds
ASGNP4
line 1476
;1476:	cgDC.fillRect = &CG_FillRect;
ADDRGP4 cgDC+36
ADDRGP4 CG_FillRect
ASGNP4
line 1477
;1477:	cgDC.drawRect = &CG_DrawRect;
ADDRGP4 cgDC+40
ADDRGP4 CG_DrawRect
ASGNP4
line 1478
;1478:	cgDC.drawSides = &CG_DrawSides;
ADDRGP4 cgDC+44
ADDRGP4 CG_DrawSides
ASGNP4
line 1479
;1479:	cgDC.drawTopBottom = &CG_DrawTopBottom;
ADDRGP4 cgDC+48
ADDRGP4 CG_DrawTopBottom
ASGNP4
line 1480
;1480:	cgDC.clearScene = &trap_R_ClearScene;
ADDRGP4 cgDC+52
ADDRGP4 trap_R_ClearScene
ASGNP4
line 1481
;1481:	cgDC.addRefEntityToScene = &trap_R_AddRefEntityToScene;
ADDRGP4 cgDC+56
ADDRGP4 trap_R_AddRefEntityToScene
ASGNP4
line 1482
;1482:	cgDC.renderScene = &trap_R_RenderScene;
ADDRGP4 cgDC+60
ADDRGP4 trap_R_RenderScene
ASGNP4
line 1483
;1483:	cgDC.registerFont = &trap_R_RegisterFont;
ADDRGP4 cgDC+64
ADDRGP4 trap_R_RegisterFont
ASGNP4
line 1484
;1484:	cgDC.ownerDrawItem = &CG_OwnerDraw;
ADDRGP4 cgDC+68
ADDRGP4 CG_OwnerDraw
ASGNP4
line 1485
;1485:	cgDC.getValue = &CG_GetValue;
ADDRGP4 cgDC+72
ADDRGP4 CG_GetValue
ASGNP4
line 1486
;1486:	cgDC.ownerDrawVisible = &CG_OwnerDrawVisible;
ADDRGP4 cgDC+76
ADDRGP4 CG_OwnerDrawVisible
ASGNP4
line 1487
;1487:	cgDC.runScript = &CG_RunMenuScript;
ADDRGP4 cgDC+80
ADDRGP4 CG_RunMenuScript
ASGNP4
line 1488
;1488:	cgDC.getTeamColor = &CG_GetTeamColor;
ADDRGP4 cgDC+84
ADDRGP4 CG_GetTeamColor
ASGNP4
line 1489
;1489:	cgDC.setCVar = trap_Cvar_Set;
ADDRGP4 cgDC+96
ADDRGP4 trap_Cvar_Set
ASGNP4
line 1490
;1490:	cgDC.getCVarString = trap_Cvar_VariableStringBuffer;
ADDRGP4 cgDC+88
ADDRGP4 trap_Cvar_VariableStringBuffer
ASGNP4
line 1491
;1491:	cgDC.getCVarValue = CG_Cvar_Get;
ADDRGP4 cgDC+92
ADDRGP4 CG_Cvar_Get
ASGNP4
line 1492
;1492:	cgDC.drawTextWithCursor = &CG_Text_PaintWithCursor;
ADDRGP4 cgDC+104
ADDRGP4 CG_Text_PaintWithCursor
ASGNP4
line 1495
;1493:	//cgDC.setOverstrikeMode = &trap_Key_SetOverstrikeMode;
;1494:	//cgDC.getOverstrikeMode = &trap_Key_GetOverstrikeMode;
;1495:	cgDC.startLocalSound = &trap_S_StartLocalSound;
ADDRGP4 cgDC+116
ADDRGP4 trap_S_StartLocalSound
ASGNP4
line 1496
;1496:	cgDC.ownerDrawHandleKey = &CG_OwnerDrawHandleKey;
ADDRGP4 cgDC+120
ADDRGP4 CG_OwnerDrawHandleKey
ASGNP4
line 1497
;1497:	cgDC.feederCount = &CG_FeederCount;
ADDRGP4 cgDC+124
ADDRGP4 CG_FeederCount
ASGNP4
line 1498
;1498:	cgDC.feederItemImage = &CG_FeederItemImage;
ADDRGP4 cgDC+132
ADDRGP4 CG_FeederItemImage
ASGNP4
line 1499
;1499:	cgDC.feederItemText = &CG_FeederItemText;
ADDRGP4 cgDC+128
ADDRGP4 CG_FeederItemText
ASGNP4
line 1500
;1500:	cgDC.feederSelection = &CG_FeederSelection;
ADDRGP4 cgDC+136
ADDRGP4 CG_FeederSelection
ASGNP4
line 1505
;1501:	//cgDC.setBinding = &trap_Key_SetBinding;
;1502:	//cgDC.getBindingBuf = &trap_Key_GetBindingBuf;
;1503:	//cgDC.keynumToStringBuf = &trap_Key_KeynumToStringBuf;
;1504:	//cgDC.executeText = &trap_Cmd_ExecuteText;
;1505:	cgDC.Error = &Com_Error;
ADDRGP4 cgDC+156
ADDRGP4 Com_Error
ASGNP4
line 1506
;1506:	cgDC.Print = &Com_Printf;
ADDRGP4 cgDC+160
ADDRGP4 Com_Printf
ASGNP4
line 1507
;1507:	cgDC.ownerDrawWidth = &CG_OwnerDrawWidth;
ADDRGP4 cgDC+168
ADDRGP4 CG_OwnerDrawWidth
ASGNP4
line 1509
;1508:	//cgDC.Pause = &CG_Pause;
;1509:	cgDC.registerSound = &trap_S_RegisterSound;
ADDRGP4 cgDC+172
ADDRGP4 trap_S_RegisterSound
ASGNP4
line 1510
;1510:	cgDC.startBackgroundTrack = &trap_S_StartBackgroundTrack;
ADDRGP4 cgDC+176
ADDRGP4 trap_S_StartBackgroundTrack
ASGNP4
line 1511
;1511:	cgDC.stopBackgroundTrack = &trap_S_StopBackgroundTrack;
ADDRGP4 cgDC+180
ADDRGP4 trap_S_StopBackgroundTrack
ASGNP4
line 1512
;1512:	cgDC.playCinematic = &CG_PlayCinematic;
ADDRGP4 cgDC+184
ADDRGP4 CG_PlayCinematic
ASGNP4
line 1513
;1513:	cgDC.stopCinematic = &CG_StopCinematic;
ADDRGP4 cgDC+188
ADDRGP4 CG_StopCinematic
ASGNP4
line 1514
;1514:	cgDC.drawCinematic = &CG_DrawCinematic;
ADDRGP4 cgDC+192
ADDRGP4 CG_DrawCinematic
ASGNP4
line 1515
;1515:	cgDC.runCinematicFrame = &CG_RunCinematicFrame;
ADDRGP4 cgDC+196
ADDRGP4 CG_RunCinematicFrame
ASGNP4
line 1517
;1516:
;1517:	Init_Display(&cgDC);
ADDRGP4 cgDC
ARGP4
ADDRGP4 Init_Display
CALLV
pop
line 1519
;1518:
;1519:	Menu_Reset();
ADDRGP4 Menu_Reset
CALLV
pop
line 1521
;1520:
;1521:	trap_Cvar_VariableStringBuffer("cg_hudFiles", buff, sizeof(buff));
ADDRGP4 $204
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1522
;1522:	hudSet = buff;
ADDRLP4 0
ADDRLP4 4
ASGNP4
line 1523
;1523:	if (hudSet[0] == '\0') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1703
line 1524
;1524:		hudSet = "ui/hud.txt";
ADDRLP4 0
ADDRGP4 $205
ASGNP4
line 1525
;1525:	}
LABELV $1703
line 1527
;1526:
;1527:	CG_LoadMenus(hudSet);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_LoadMenus
CALLV
pop
line 1528
;1528:}
LABELV $1661
endproc CG_LoadHudMenu 1028 12
proc CG_AssetCache 68 12
line 1530
;1529:
;1530:static void CG_AssetCache(void) {
line 1531
;1531:	if (!&cgDC.Assets.textFont) {
ADDRGP4 cgDC+236+12
CVPU4 4
CNSTU4 0
NEU4 $1706
line 1532
;1532:		trap_R_RegisterFont("fonts/arial.ttf", 72, &cgDC.Assets.textFont);
ADDRGP4 $1710
ARGP4
CNSTI4 72
ARGI4
ADDRGP4 cgDC+236+12
ARGP4
ADDRGP4 trap_R_RegisterFont
CALLV
pop
line 1533
;1533:	}
LABELV $1706
line 1535
;1534:
;1535:	cgDC.Assets.gradientBar = trap_R_RegisterShaderNoMip(ASSET_GRADIENTBAR);
ADDRGP4 $1715
ARGP4
ADDRLP4 0
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342500
ADDRLP4 0
INDIRI4
ASGNI4
line 1536
;1536:	cgDC.Assets.fxBasePic = trap_R_RegisterShaderNoMip(ART_FX_BASE);
ADDRGP4 $1718
ARGP4
ADDRLP4 4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342608
ADDRLP4 4
INDIRI4
ASGNI4
line 1537
;1537:	cgDC.Assets.fxPic[0] = trap_R_RegisterShaderNoMip(ART_FX_RED);
ADDRGP4 $1721
ARGP4
ADDRLP4 8
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342612
ADDRLP4 8
INDIRI4
ASGNI4
line 1538
;1538:	cgDC.Assets.fxPic[1] = trap_R_RegisterShaderNoMip(ART_FX_YELLOW);
ADDRGP4 $1725
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342612+4
ADDRLP4 12
INDIRI4
ASGNI4
line 1539
;1539:	cgDC.Assets.fxPic[2] = trap_R_RegisterShaderNoMip(ART_FX_GREEN);
ADDRGP4 $1729
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342612+8
ADDRLP4 16
INDIRI4
ASGNI4
line 1540
;1540:	cgDC.Assets.fxPic[3] = trap_R_RegisterShaderNoMip(ART_FX_TEAL);
ADDRGP4 $1733
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342612+12
ADDRLP4 20
INDIRI4
ASGNI4
line 1541
;1541:	cgDC.Assets.fxPic[4] = trap_R_RegisterShaderNoMip(ART_FX_BLUE);
ADDRGP4 $1737
ARGP4
ADDRLP4 24
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342612+16
ADDRLP4 24
INDIRI4
ASGNI4
line 1542
;1542:	cgDC.Assets.fxPic[5] = trap_R_RegisterShaderNoMip(ART_FX_CYAN);
ADDRGP4 $1741
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342612+20
ADDRLP4 28
INDIRI4
ASGNI4
line 1543
;1543:	cgDC.Assets.fxPic[6] = trap_R_RegisterShaderNoMip(ART_FX_WHITE);
ADDRGP4 $1745
ARGP4
ADDRLP4 32
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342612+24
ADDRLP4 32
INDIRI4
ASGNI4
line 1544
;1544:	cgDC.Assets.scrollBar = trap_R_RegisterShaderNoMip(ASSET_SCROLLBAR);
ADDRGP4 $1748
ARGP4
ADDRLP4 36
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342520
ADDRLP4 36
INDIRI4
ASGNI4
line 1545
;1545:	cgDC.Assets.scrollBarArrowDown = trap_R_RegisterShaderNoMip(ASSET_SCROLLBAR_ARROWDOWN);
ADDRGP4 $1751
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342508
ADDRLP4 40
INDIRI4
ASGNI4
line 1546
;1546:	cgDC.Assets.scrollBarArrowUp = trap_R_RegisterShaderNoMip(ASSET_SCROLLBAR_ARROWUP);
ADDRGP4 $1754
ARGP4
ADDRLP4 44
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342504
ADDRLP4 44
INDIRI4
ASGNI4
line 1547
;1547:	cgDC.Assets.scrollBarArrowLeft = trap_R_RegisterShaderNoMip(ASSET_SCROLLBAR_ARROWLEFT);
ADDRGP4 $1757
ARGP4
ADDRLP4 48
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342512
ADDRLP4 48
INDIRI4
ASGNI4
line 1548
;1548:	cgDC.Assets.scrollBarArrowRight = trap_R_RegisterShaderNoMip(ASSET_SCROLLBAR_ARROWRIGHT);
ADDRGP4 $1760
ARGP4
ADDRLP4 52
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342516
ADDRLP4 52
INDIRI4
ASGNI4
line 1549
;1549:	cgDC.Assets.scrollBarThumb = trap_R_RegisterShaderNoMip(ASSET_SCROLL_THUMB);
ADDRGP4 $1763
ARGP4
ADDRLP4 56
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342524
ADDRLP4 56
INDIRI4
ASGNI4
line 1550
;1550:	cgDC.Assets.sliderBar = trap_R_RegisterShaderNoMip(ASSET_SLIDER_BAR);
ADDRGP4 $1766
ARGP4
ADDRLP4 60
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342540
ADDRLP4 60
INDIRI4
ASGNI4
line 1551
;1551:	cgDC.Assets.sliderThumb = trap_R_RegisterShaderNoMip(ASSET_SLIDER_THUMB);
ADDRGP4 $1769
ARGP4
ADDRLP4 64
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgDC+236+5342544
ADDRLP4 64
INDIRI4
ASGNI4
line 1552
;1552:}
LABELV $1705
endproc CG_AssetCache 68 12
export CG_Init
proc CG_Init 312 12
line 1562
;1553:
;1554:/*
;1555:=================
;1556:CG_Init
;1557:
;1558:Called after every level change or subsystem restart
;1559:Will perform callbacks to make the loading info screen update.
;1560:=================
;1561:*/
;1562:void CG_Init(int serverMessageNum, int serverCommandSequence, int clientNum) {
line 1567
;1563:	char  value[MAX_CVAR_VALUE_STRING];
;1564:	const char *s;
;1565:
;1566:	// clear everything
;1567:	memset(&cgs, 0, sizeof(cgs));
ADDRGP4 cgs
ARGP4
CNSTI4 0
ARGI4
CNSTI4 148028
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1568
;1568:	memset(&cg, 0, sizeof(cg));
ADDRGP4 cg
ARGP4
CNSTI4 0
ARGI4
CNSTI4 157020
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1569
;1569:	memset(cg_entities, 0, sizeof(cg_entities));
ADDRGP4 cg_entities
ARGP4
CNSTI4 0
ARGI4
CNSTI4 757760
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1570
;1570:	memset(cg_weapons, 0, sizeof(cg_weapons));
ADDRGP4 cg_weapons
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1571
;1571:	memset(cg_items, 0, sizeof(cg_items));
ADDRGP4 cg_items
ARGP4
CNSTI4 0
ARGI4
CNSTI4 7168
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1573
;1572:
;1573:	cg.clientNum = clientNum;
ADDRGP4 cg+4
ADDRFP4 8
INDIRI4
ASGNI4
line 1575
;1574:
;1575:	cgs.processedSnapshotNum = serverMessageNum;
ADDRGP4 cgs+31472
ADDRFP4 0
INDIRI4
ASGNI4
line 1576
;1576:	cgs.serverCommandSequence = serverCommandSequence;
ADDRGP4 cgs+31468
ADDRFP4 4
INDIRI4
ASGNI4
line 1578
;1577:
;1578:	trap_Cvar_VariableStringBuffer("//trap_GetValue", value, sizeof(value));
ADDRGP4 $1774
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1579
;1579:	if (value[0]) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1775
line 1581
;1580:#ifdef Q3_VM
;1581:		trap_GetValue = (void *)~atoi(value);
ADDRLP4 0
ARGP4
ADDRLP4 260
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 trap_GetValue
ADDRLP4 260
INDIRI4
BCOMI4
CVIU4 4
CVUP4 4
ASGNP4
line 1582
;1582:		if (trap_GetValue(value, sizeof(value), "trap_R_AddRefEntityToScene2")) {
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1779
ARGP4
ADDRLP4 264
ADDRGP4 trap_GetValue
INDIRP4
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
EQI4 $1777
line 1583
;1583:			trap_R_AddRefEntityToScene2 = (void *)~atoi(value);
ADDRLP4 0
ARGP4
ADDRLP4 268
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 trap_R_AddRefEntityToScene2
ADDRLP4 268
INDIRI4
BCOMI4
CVIU4 4
CVUP4 4
ASGNP4
line 1584
;1584:			intShaderTime = qtrue;
ADDRGP4 intShaderTime
CNSTI4 1
ASGNI4
line 1585
;1585:		}
LABELV $1777
line 1586
;1586:		if (trap_GetValue(value, sizeof(value), "trap_R_AddLinearLightToScene_Q3E")) {
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $1782
ARGP4
ADDRLP4 268
ADDRGP4 trap_GetValue
INDIRP4
CALLI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 0
EQI4 $1780
line 1587
;1587:			trap_R_AddLinearLightToScene = (void *)~atoi(value);
ADDRLP4 0
ARGP4
ADDRLP4 272
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 trap_R_AddLinearLightToScene
ADDRLP4 272
INDIRI4
BCOMI4
CVIU4 4
CVUP4 4
ASGNP4
line 1588
;1588:			linearLight = qtrue;
ADDRGP4 linearLight
CNSTI4 1
ASGNI4
line 1589
;1589:		}
LABELV $1780
line 1601
;1590:#else
;1591:		dll_com_trapGetValue = atoi(value);
;1592:		if (trap_GetValue(value, sizeof(value), "trap_R_AddRefEntityToScene2")) {
;1593:			dll_trap_R_AddRefEntityToScene2 = atoi(value);
;1594:			intShaderTime = qtrue;
;1595:		}
;1596:		if (trap_GetValue(value, sizeof(value), "trap_R_AddLinearLightToScene_Q3E")) {
;1597:			dll_trap_R_AddLinearLightToScene = atoi(value);
;1598:			linearLight = qtrue;
;1599:		}
;1600:#endif
;1601:	}
LABELV $1775
line 1604
;1602:
;1603:	// load a few needed things before we do any screen updates
;1604:	cgs.media.charsetShader = trap_R_RegisterShader("gfx/2d/bigchars");
ADDRGP4 $1784
ARGP4
ADDRLP4 260
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664
ADDRLP4 260
INDIRI4
ASGNI4
line 1605
;1605:	cgs.media.whiteShader = trap_R_RegisterShader("white");
ADDRGP4 $1787
ARGP4
ADDRLP4 264
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+146664+16
ADDRLP4 264
INDIRI4
ASGNI4
line 1606
;1606:	cgs.media.charsetProp = trap_R_RegisterShaderNoMip("menu/art/font1_prop.tga");
ADDRGP4 $1790
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+4
ADDRLP4 268
INDIRI4
ASGNI4
line 1607
;1607:	cgs.media.charsetPropGlow = trap_R_RegisterShaderNoMip("menu/art/font1_prop_glo.tga");
ADDRGP4 $1793
ARGP4
ADDRLP4 272
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+8
ADDRLP4 272
INDIRI4
ASGNI4
line 1608
;1608:	cgs.media.charsetPropB = trap_R_RegisterShaderNoMip("menu/art/font2_prop.tga");
ADDRGP4 $1796
ARGP4
ADDRLP4 276
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+146664+12
ADDRLP4 276
INDIRI4
ASGNI4
line 1610
;1609:
;1610:	CG_RegisterCvars();
ADDRGP4 CG_RegisterCvars
CALLV
pop
line 1612
;1611:
;1612:	CG_InitConsoleCommands();
ADDRGP4 CG_InitConsoleCommands
CALLV
pop
line 1614
;1613:
;1614:	cg.weaponSelect = WP_MACHINEGUN;
ADDRGP4 cg+108956
CNSTI4 2
ASGNI4
line 1616
;1615:
;1616:	cgs.redflag = cgs.blueflag = -1; // For compatibily, default to unset for
ADDRLP4 280
CNSTI4 -1
ASGNI4
ADDRGP4 cgs+32756
ADDRLP4 280
INDIRI4
ASGNI4
ADDRGP4 cgs+32752
ADDRLP4 280
INDIRI4
ASGNI4
line 1617
;1617:	cgs.flagStatus = -1;
ADDRGP4 cgs+32760
CNSTI4 -1
ASGNI4
line 1621
;1618:	// old servers
;1619:
;1620:	// get the rendering configuration from the client system
;1621:	trap_GetGlconfig(&cgs.glconfig);
ADDRGP4 cgs+20100
ARGP4
ADDRGP4 trap_GetGlconfig
CALLV
pop
line 1623
;1622:
;1623:	cgs.screenXBias = 0.0;
ADDRGP4 cgs+31444
CNSTF4 0
ASGNF4
line 1624
;1624:	cgs.screenYBias = 0.0;
ADDRGP4 cgs+31448
CNSTF4 0
ASGNF4
line 1626
;1625:
;1626:	if (cgs.glconfig.vidWidth * SCREEN_HEIGHT > cgs.glconfig.vidHeight * SCREEN_WIDTH) {
ADDRGP4 cgs+20100+11304
INDIRI4
CNSTI4 480
MULI4
ADDRGP4 cgs+20100+11308
INDIRI4
CNSTI4 640
MULI4
LEI4 $1804
line 1628
;1627:		// wide screen, scale by height
;1628:		cgs.screenXScale = cgs.screenYScale = cgs.glconfig.vidHeight * (1.0 / (float)SCREEN_HEIGHT);
ADDRLP4 284
ADDRGP4 cgs+20100+11308
INDIRI4
CVIF4 4
CNSTF4 990414985
MULF4
ASGNF4
ADDRGP4 cgs+31436
ADDRLP4 284
INDIRF4
ASGNF4
ADDRGP4 cgs+31432
ADDRLP4 284
INDIRF4
ASGNF4
line 1629
;1629:		cgs.screenXBias = 0.5 * (cgs.glconfig.vidWidth - (cgs.glconfig.vidHeight * ((float)SCREEN_WIDTH / (float)SCREEN_HEIGHT)));
ADDRGP4 cgs+31444
ADDRGP4 cgs+20100+11304
INDIRI4
CVIF4 4
ADDRGP4 cgs+20100+11308
INDIRI4
CVIF4 4
CNSTF4 1068149419
MULF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 1630
;1630:	} else {
ADDRGP4 $1805
JUMPV
LABELV $1804
line 1632
;1631:		// no wide screen, scale by width
;1632:		cgs.screenXScale = cgs.screenYScale = cgs.glconfig.vidWidth * (1.0 / (float)SCREEN_WIDTH);
ADDRLP4 284
ADDRGP4 cgs+20100+11304
INDIRI4
CVIF4 4
CNSTF4 986500301
MULF4
ASGNF4
ADDRGP4 cgs+31436
ADDRLP4 284
INDIRF4
ASGNF4
ADDRGP4 cgs+31432
ADDRLP4 284
INDIRF4
ASGNF4
line 1633
;1633:		cgs.screenYBias = 0.5 * (cgs.glconfig.vidHeight - (cgs.glconfig.vidWidth * ((float)SCREEN_HEIGHT / (float)SCREEN_WIDTH)));
ADDRGP4 cgs+31448
ADDRGP4 cgs+20100+11308
INDIRI4
CVIF4 4
ADDRGP4 cgs+20100+11304
INDIRI4
CVIF4 4
CNSTF4 1061158912
MULF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 1634
;1634:	}
LABELV $1805
line 1636
;1635:
;1636:	cgs.screenXmin = 0.0 - (cgs.screenXBias / cgs.screenXScale);
ADDRGP4 cgs+31452
CNSTF4 0
ADDRGP4 cgs+31444
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
DIVF4
SUBF4
ASGNF4
line 1637
;1637:	cgs.screenXmax = (float)SCREEN_WIDTH + (cgs.screenXBias / cgs.screenXScale);
ADDRGP4 cgs+31456
ADDRGP4 cgs+31444
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
DIVF4
CNSTF4 1142947840
ADDF4
ASGNF4
line 1639
;1638:
;1639:	cgs.screenYmin = 0.0 - (cgs.screenYBias / cgs.screenYScale);
ADDRGP4 cgs+31460
CNSTF4 0
ADDRGP4 cgs+31448
INDIRF4
ADDRGP4 cgs+31436
INDIRF4
DIVF4
SUBF4
ASGNF4
line 1640
;1640:	cgs.screenYmax = (float)SCREEN_HEIGHT + (cgs.screenYBias / cgs.screenYScale);
ADDRGP4 cgs+31464
ADDRGP4 cgs+31448
INDIRF4
ADDRGP4 cgs+31436
INDIRF4
DIVF4
CNSTF4 1139802112
ADDF4
ASGNF4
line 1642
;1641:
;1642:	cgs.cursorScaleR = 1.0 / cgs.screenXScale;
ADDRGP4 cgs+31440
CNSTF4 1065353216
ADDRGP4 cgs+31432
INDIRF4
DIVF4
ASGNF4
line 1643
;1643:	if (cgs.cursorScaleR < 0.5) {
ADDRGP4 cgs+31440
INDIRF4
CNSTF4 1056964608
GEF4 $1842
line 1644
;1644:		cgs.cursorScaleR = 0.5;
ADDRGP4 cgs+31440
CNSTF4 1056964608
ASGNF4
line 1645
;1645:	}
LABELV $1842
line 1648
;1646:
;1647:#ifdef USE_NEW_FONT_RENDERER
;1648:	CG_LoadFonts();
ADDRGP4 CG_LoadFonts
CALLV
pop
line 1652
;1649:#endif
;1650:
;1651:	// get the gamestate from the client system
;1652:	trap_GetGameState(&cgs.gameState);
ADDRGP4 cgs
ARGP4
ADDRGP4 trap_GetGameState
CALLV
pop
line 1655
;1653:
;1654:	// check version
;1655:	s = CG_ConfigString(CS_GAME_VERSION);
CNSTI4 12
ARGI4
ADDRLP4 284
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 256
ADDRLP4 284
INDIRP4
ASGNP4
line 1656
;1656:	if (strstr(s, "defrag-")) {
ADDRLP4 256
INDIRP4
ARGP4
ADDRGP4 $1848
ARGP4
ADDRLP4 288
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 288
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1846
line 1657
;1657:		cgs.defrag = qtrue;
ADDRGP4 cgs+148008
CNSTI4 1
ASGNI4
line 1658
;1658:	} else if (strcmp(s, GAME_VERSION)) {
ADDRGP4 $1847
JUMPV
LABELV $1846
ADDRLP4 256
INDIRP4
ARGP4
ADDRGP4 $1852
ARGP4
ADDRLP4 292
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 0
EQI4 $1850
line 1659
;1659:		CG_Error("Client/Server game mismatch: %s/%s", GAME_VERSION, s);
ADDRGP4 $1853
ARGP4
ADDRGP4 $1852
ARGP4
ADDRLP4 256
INDIRP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 1660
;1660:	}
LABELV $1850
LABELV $1847
line 1662
;1661:
;1662:	cgs.ospEnc = atoi(CG_ConfigString(872)) & 1;
CNSTI4 872
ARGI4
ADDRLP4 296
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 296
INDIRP4
ARGP4
ADDRLP4 300
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+148004
ADDRLP4 300
INDIRI4
CNSTI4 1
BANDI4
ASGNI4
line 1664
;1663:
;1664:	s = CG_ConfigString(CS_LEVEL_START_TIME);
CNSTI4 13
ARGI4
ADDRLP4 304
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 256
ADDRLP4 304
INDIRP4
ASGNP4
line 1665
;1665:	cgs.levelStartTime = atoi(s);
ADDRLP4 256
INDIRP4
ARGP4
ADDRLP4 308
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+32740
ADDRLP4 308
INDIRI4
ASGNI4
line 1667
;1666:
;1667:	CG_ParseServerinfo();
ADDRGP4 CG_ParseServerinfo
CALLV
pop
line 1668
;1668:	CG_ParseSysteminfo();
ADDRGP4 CG_ParseSysteminfo
CALLV
pop
line 1670
;1669:
;1670:	CG_ParseArmorTiered();
ADDRGP4 CG_ParseArmorTiered
CALLV
pop
line 1673
;1671:
;1672:	// load the new map
;1673:	CG_LoadingString("collision map");
ADDRGP4 $1856
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 1675
;1674:
;1675:	trap_CM_LoadMap("campgrounds");	// cgs.mapname);
ADDRGP4 $1857
ARGP4
ADDRGP4 trap_CM_LoadMap
CALLV
pop
line 1677
;1676:
;1677:	String_Init();
ADDRGP4 String_Init
CALLV
pop
line 1679
;1678:
;1679:	cg.loading = qtrue;		// force players to load instead of defer
ADDRGP4 cg+20
CNSTI4 1
ASGNI4
line 1681
;1680:
;1681:	CG_LoadingString("sounds");
ADDRGP4 $1859
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 1682
;1682:	CG_RegisterSounds();
ADDRGP4 CG_RegisterSounds
CALLV
pop
line 1684
;1683:
;1684:	CG_LoadingString("graphics");
ADDRGP4 $1860
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 1685
;1685:	CG_RegisterGraphics();
ADDRGP4 CG_RegisterGraphics
CALLV
pop
line 1687
;1686:
;1687:	CG_LoadingString("clients");
ADDRGP4 $1861
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 1688
;1688:	CG_RegisterClients();		// if low on memory, some clients will be deferred
ADDRGP4 CG_RegisterClients
CALLV
pop
line 1690
;1689:
;1690:	CG_AssetCache();
ADDRGP4 CG_AssetCache
CALLV
pop
line 1691
;1691:	CG_LoadHudMenu();      // load new hud stuff
ADDRGP4 CG_LoadHudMenu
CALLV
pop
line 1693
;1692:
;1693:	cg.loading = qfalse;	// future players will be deferred
ADDRGP4 cg+20
CNSTI4 0
ASGNI4
line 1695
;1694:
;1695:	CG_InitLocalEntities();
ADDRGP4 CG_InitLocalEntities
CALLV
pop
line 1697
;1696:
;1697:	CG_InitMarkPolys();
ADDRGP4 CG_InitMarkPolys
CALLV
pop
line 1700
;1698:
;1699:	// remove the last loading update
;1700:	cg.infoScreenText[0] = 0;
ADDRGP4 cg+109448
CNSTI1 0
ASGNI1
line 1705
;1701:
;1702:	// Make sure we have update values (scores)
;1703:	// CG_SetConfigValues();
;1704:
;1705:	CG_StartMusic();
ADDRGP4 CG_StartMusic
CALLV
pop
line 1707
;1706:
;1707:	CG_LoadingString("");
ADDRGP4 $154
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 1709
;1708:
;1709:	CG_ShaderStateChanged();
ADDRGP4 CG_ShaderStateChanged
CALLV
pop
line 1711
;1710:
;1711:	trap_S_ClearLoopingSounds(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 trap_S_ClearLoopingSounds
CALLV
pop
line 1712
;1712:}
LABELV $1770
endproc CG_Init 312 12
export CG_Shutdown
proc CG_Shutdown 0 0
line 1722
;1713:
;1714:
;1715:/*
;1716:=================
;1717:CG_Shutdown
;1718:
;1719:Called before every level change or subsystem restart
;1720:=================
;1721:*/
;1722:void CG_Shutdown(void) {
line 1725
;1723:	// some mods may need to do cleanup work here,
;1724:	// like closing files or archiving session data
;1725:}
LABELV $1864
endproc CG_Shutdown 0 0
bss
export trap_GetValue
align 4
LABELV trap_GetValue
skip 4
export cgDC
align 4
LABELV cgDC
skip 5354348
export trap_R_AddLinearLightToScene
align 4
LABELV trap_R_AddLinearLightToScene
skip 4
export trap_R_AddRefEntityToScene2
align 4
LABELV trap_R_AddRefEntityToScene2
skip 4
import CG_NewParticleArea
import initparticles
import CG_ParticleExplosion
import CG_ParticleMisc
import CG_ParticleDust
import CG_ParticleSparks
import CG_ParticleBulletDebris
import CG_ParticleSnowFlurry
import CG_AddParticleShrapnel
import CG_ParticleSmoke
import CG_ParticleSnow
import CG_AddParticles
import CG_ClearParticles
import trap_GetEntityToken
import trap_getCameraInfo
import trap_startCamera
import trap_loadCamera
import trap_SnapVector
import trap_CIN_SetExtents
import trap_CIN_DrawCinematic
import trap_CIN_RunCinematic
import trap_CIN_StopCinematic
import trap_CIN_PlayCinematic
import trap_Key_GetKey
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_IsDown
import trap_R_RegisterFont
import trap_MemoryRemaining
import testPrintFloat
import testPrintInt
import trap_SetUserCmdValue
import trap_GetUserCmd
import trap_GetCurrentCmdNumber
import trap_GetServerCommand
import trap_GetSnapshot
import trap_GetCurrentSnapshotNumber
import trap_GetGameState
import trap_GetGlconfig
import trap_R_inPVS
import trap_R_RemapShader
import trap_R_LerpTag
import trap_R_ModelBounds
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_LightForPoint
import trap_R_AddAdditiveLightToScene
import trap_R_AddLightToScene
import trap_R_AddPolysToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterShader
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_R_LoadWorldMap
import trap_S_StopBackgroundTrack
import trap_S_StartBackgroundTrack
import trap_S_RegisterSound
import trap_S_Respatialize
import trap_S_UpdateEntityPosition
import trap_S_AddRealLoopingSound
import trap_S_AddLoopingSound
import trap_S_ClearLoopingSounds
import trap_S_StartLocalSound
import trap_S_StopLoopingSound
import trap_S_StartSound
import trap_CM_MarkFragments
import trap_CM_TransformedCapsuleTrace
import trap_CM_TransformedBoxTrace
import trap_CM_CapsuleTrace
import trap_CM_BoxTrace
import trap_CM_TransformedPointContents
import trap_CM_PointContents
import trap_CM_TempBoxModel
import trap_CM_InlineModel
import trap_CM_NumInlineModels
import trap_CM_LoadMap
import trap_UpdateScreen
import trap_SendClientCommand
import trap_RemoveCommand
import trap_AddCommand
import trap_RealTime
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Cvar_VariableStringBuffer
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import CG_CheckChangedPredictableEvents
import CG_TransitionPlayerState
import CG_Respawn
import CG_ShaderStateChanged
import CG_SetConfigValues
import CG_ParseArmorTiered
import CG_ParseSysteminfo
import CG_ParseServerinfo
import CG_ExecuteNewServerCommands
import CG_InitConsoleCommands
import CG_ConsoleCommand
import CG_ScoreboardClick
import CG_DrawOldTourneyScoreboard
import CG_DrawOldScoreboard
import CG_DrawInformation
import CG_LoadingClient
import CG_LoadingItem
import CG_LoadingString
import CG_ProcessSnapshots
import CG_MakeExplosion
import CG_Bleed
import CG_BigExplode
import CG_GibPlayer
import CG_ScorePlum
import CG_LightningBoltBeam
import CG_InvulnerabilityJuiced
import CG_InvulnerabilityImpact
import CG_ObeliskPain
import CG_ObeliskExplode
import CG_KamikazeEffect
import CG_SpawnEffect
import CG_BubbleTrail
import CG_SmokePuff
import CG_AddLocalEntities
import CG_AllocLocalEntity
import CG_InitLocalEntities
import CG_ImpactMark
import CG_AddMarks
import CG_InitMarkPolys
import CG_OutOfAmmoChange
import CG_DrawWeaponSelect
import CG_AddPlayerWeapon
import CG_AddViewWeapon
import CG_GrappleTrail
import CG_RailTrail
import CG_Bullet
import CG_ShotgunFire
import CG_MissileHitPlayer
import CG_MissileHitWall
import CG_FireWeapon
import CG_RegisterItemVisuals
import CG_RegisterWeapon
import CG_Weapon_f
import CG_PrevWeapon_f
import CG_NextWeapon_f
import CG_PositionRotatedEntityOnTag
import CG_PositionEntityOnTag
import CG_AdjustPositionForMover
import CG_Beam
import CG_AddPacketEntities
import CG_SetEntitySoundPosition
import CG_PainEvent
import CG_EntityEvent
import CG_PlaceString
import CG_CheckEvents
import CG_PlayDroppedEvents
import CG_LoadDeferredPlayers
import CG_PredictPlayerState
import CG_Trace
import CG_PointContents
import CG_BuildSolidList
import CG_CustomSound
import CG_NewClientInfo
import CG_AddRefEntityWithPowerups
import CG_ResetPlayerEntity
import CG_Player
import CG_TrackClientTeamChange
import CG_StatusHandle
import CG_OtherTeamHasFlag
import CG_YourTeamHasFlag
import CG_Text_PaintChar
import CG_Draw3DModel
import CG_GetKillerText
import CG_GetGameStatusText
import CG_GetTeamColor
import CG_RunMenuScript
import CG_OwnerDrawVisible
import CG_GetValue
import CG_Text_Height
import CG_Text_Width
import CG_Text_Paint
import CG_OwnerDraw
import CG_DrawTeamBackground
import CG_DrawFlagModel
import CG_DrawActive
import CG_DrawHead
import CG_CenterPrint
import CG_AddLagometerSnapshotInfo
import CG_AddLagometerFrameInfo
import teamChat2
import teamChat1
import systemChat
import drawTeamOverlayModificationCount
import numSortedTeamPlayers
import sortedTeamPlayers
import CG_SelectFont
import CG_LoadFonts
import CG_DrawString
import CG_DrawTopBottom
import CG_DrawSides
import CG_DrawRect
import UI_DrawProportionalString
import CG_GetColorForHealth
import CG_ColorForHealth
import CG_TileClear
import CG_TeamColor
import CG_FadeColorTime
import CG_FadeColor
import CG_DrawStrlen
import CG_DrawStringExt
import CG_DrawStretchPic
import CG_DrawPic
import CG_FillScreen
import CG_FillRect
import CG_AdjustFrom640
import CG_DrawActiveFrame
import CG_AddBufferedSound
import CG_ZoomUp_f
import CG_ZoomDown_f
import CG_TestModelPrevSkin_f
import CG_TestModelNextSkin_f
import CG_TestModelPrevFrame_f
import CG_TestModelNextFrame_f
import CG_TestGun_f
import CG_TestModel_f
import CG_SetScoreCatcher
import CG_EventHandling
import CG_MouseEvent
import CG_KeyEvent
import eventnames
export cg_armorTiered
align 4
LABELV cg_armorTiered
skip 272
export cg_followKiller
align 4
LABELV cg_followKiller
skip 272
export cg_deadBodyDarken
align 4
LABELV cg_deadBodyDarken
skip 272
export cg_teamColors
align 4
LABELV cg_teamColors
skip 272
export cg_teamModel
align 4
LABELV cg_teamModel
skip 272
export cg_enemyColors
align 4
LABELV cg_enemyColors
skip 272
export cg_enemyModel
align 4
LABELV cg_enemyModel
skip 272
export cg_hitSounds
align 4
LABELV cg_hitSounds
skip 272
export cg_trueLightning
align 4
LABELV cg_trueLightning
skip 272
export cg_oldPlasma
align 4
LABELV cg_oldPlasma
skip 272
export cg_oldRocket
align 4
LABELV cg_oldRocket
skip 272
export cg_oldRail
align 4
LABELV cg_oldRail
skip 272
export cg_bigFont
align 4
LABELV cg_bigFont
skip 272
export cg_smallFont
align 4
LABELV cg_smallFont
skip 272
export cg_noProjectileTrail
align 4
LABELV cg_noProjectileTrail
skip 272
export cg_noTaunt
align 4
LABELV cg_noTaunt
skip 272
export cg_cameraMode
align 4
LABELV cg_cameraMode
skip 272
export cg_smoothClients
align 4
LABELV cg_smoothClients
skip 272
export cg_scorePlum
align 4
LABELV cg_scorePlum
skip 272
export cg_timescale
align 4
LABELV cg_timescale
skip 272
export cg_timescaleFadeSpeed
align 4
LABELV cg_timescaleFadeSpeed
skip 272
export cg_timescaleFadeEnd
align 4
LABELV cg_timescaleFadeEnd
skip 272
export cg_obeliskRespawnDelay
align 4
LABELV cg_obeliskRespawnDelay
skip 272
export cg_enableBreath
align 4
LABELV cg_enableBreath
skip 272
export cg_enableDust
align 4
LABELV cg_enableDust
skip 272
export cg_hudFiles
align 4
LABELV cg_hudFiles
skip 272
export cg_blueTeamName
align 4
LABELV cg_blueTeamName
skip 272
export cg_redTeamName
align 4
LABELV cg_redTeamName
skip 272
export cg_blood
align 4
LABELV cg_blood
skip 272
export cg_paused
align 4
LABELV cg_paused
skip 272
export cg_buildScript
align 4
LABELV cg_buildScript
skip 272
export cg_teamChatsOnly
align 4
LABELV cg_teamChatsOnly
skip 272
export cg_drawFriend
align 4
LABELV cg_drawFriend
skip 272
export cg_stats
align 4
LABELV cg_stats
skip 272
export cg_teamOverlayUserinfo
align 4
LABELV cg_teamOverlayUserinfo
skip 272
export cg_drawTeamOverlay
align 4
LABELV cg_drawTeamOverlay
skip 272
export cg_deferPlayers
align 4
LABELV cg_deferPlayers
skip 272
export cg_predictItems
align 4
LABELV cg_predictItems
skip 272
export cg_forceModel
align 4
LABELV cg_forceModel
skip 272
export cg_teamChatHeight
align 4
LABELV cg_teamChatHeight
skip 272
export cg_teamChatTime
align 4
LABELV cg_teamChatTime
skip 272
export cg_thirdPerson
align 4
LABELV cg_thirdPerson
skip 272
export cg_thirdPersonAngle
align 4
LABELV cg_thirdPersonAngle
skip 272
export cg_thirdPersonRange
align 4
LABELV cg_thirdPersonRange
skip 272
export cg_tracerLength
align 4
LABELV cg_tracerLength
skip 272
export cg_tracerWidth
align 4
LABELV cg_tracerWidth
skip 272
export cg_tracerChance
align 4
LABELV cg_tracerChance
skip 272
export cg_footsteps
align 4
LABELV cg_footsteps
skip 272
export cg_showmiss
align 4
LABELV cg_showmiss
skip 272
export cg_noPlayerAnims
align 4
LABELV cg_noPlayerAnims
skip 272
export cg_nopredict
align 4
LABELV cg_nopredict
skip 272
export cg_errorDecay
align 4
LABELV cg_errorDecay
skip 272
export cg_debugEvents
align 4
LABELV cg_debugEvents
skip 272
export cg_debugPosition
align 4
LABELV cg_debugPosition
skip 272
export cg_debugAnim
align 4
LABELV cg_debugAnim
skip 272
export cg_animSpeed
align 4
LABELV cg_animSpeed
skip 272
export cg_swingSpeed
align 4
LABELV cg_swingSpeed
skip 272
export cg_bobroll
align 4
LABELV cg_bobroll
skip 272
export cg_bobpitch
align 4
LABELV cg_bobpitch
skip 272
export cg_bobup
align 4
LABELV cg_bobup
skip 272
export cg_runroll
align 4
LABELV cg_runroll
skip 272
export cg_runpitch
align 4
LABELV cg_runpitch
skip 272
export cg_centertime
align 4
LABELV cg_centertime
skip 272
export cg_gun_z
align 4
LABELV cg_gun_z
skip 272
export cg_gun_y
align 4
LABELV cg_gun_y
skip 272
export cg_gun_x
align 4
LABELV cg_gun_x
skip 272
export cg_gun_frame
align 4
LABELV cg_gun_frame
skip 272
export cg_railTrailRadius
align 4
LABELV cg_railTrailRadius
skip 272
export cg_railTrailTime
align 4
LABELV cg_railTrailTime
skip 272
export cg_lagometer
align 4
LABELV cg_lagometer
skip 272
export cg_addMarks
align 4
LABELV cg_addMarks
skip 272
export cg_simpleItems
align 4
LABELV cg_simpleItems
skip 272
export cg_brassTime
align 4
LABELV cg_brassTime
skip 272
export cg_crosshairY
align 4
LABELV cg_crosshairY
skip 272
export cg_crosshairX
align 4
LABELV cg_crosshairX
skip 272
export cg_crosshairHealth
align 4
LABELV cg_crosshairHealth
skip 272
export cg_crosshairSize
align 4
LABELV cg_crosshairSize
skip 272
export cg_drawWeaponSelect
align 4
LABELV cg_drawWeaponSelect
skip 272
export cg_drawRewards
align 4
LABELV cg_drawRewards
skip 272
export cg_drawCrosshairNames
align 4
LABELV cg_drawCrosshairNames
skip 272
export cg_drawCrosshair
align 4
LABELV cg_drawCrosshair
skip 272
export cg_drawSpeed
align 4
LABELV cg_drawSpeed
skip 272
export cg_drawAttacker
align 4
LABELV cg_drawAttacker
skip 272
export cg_drawAmmoWarning
align 4
LABELV cg_drawAmmoWarning
skip 272
export cg_drawIcons
align 4
LABELV cg_drawIcons
skip 272
export cg_draw3dIcons
align 4
LABELV cg_draw3dIcons
skip 272
export cg_drawSnapshot
align 4
LABELV cg_drawSnapshot
skip 272
export cg_drawFPS
align 4
LABELV cg_drawFPS
skip 272
export cg_drawTimer
align 4
LABELV cg_drawTimer
skip 272
export cg_drawStatus
align 4
LABELV cg_drawStatus
skip 272
export cg_draw2D
align 4
LABELV cg_draw2D
skip 272
export cg_gibs
align 4
LABELV cg_gibs
skip 272
export cg_shadows
align 4
LABELV cg_shadows
skip 272
export cg_viewsize
align 4
LABELV cg_viewsize
skip 272
export cg_fov
align 4
LABELV cg_fov
skip 272
export cg_zoomFov
align 4
LABELV cg_zoomFov
skip 272
export cg_drawGun
align 4
LABELV cg_drawGun
skip 272
export cg_autoswitch
align 4
LABELV cg_autoswitch
skip 272
export cg_ignore
align 4
LABELV cg_ignore
skip 272
import cg_markPolys
export cg_items
align 4
LABELV cg_items
skip 7168
export cg_weapons
align 4
LABELV cg_weapons
skip 2176
export cg_entities
align 4
LABELV cg_entities
skip 757760
export cg
align 4
LABELV cg
skip 157020
export cgs
align 4
LABELV cgs
skip 148028
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
LABELV $1861
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $1860
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 99
byte 1 115
byte 1 0
align 1
LABELV $1859
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $1857
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $1856
byte 1 99
byte 1 111
byte 1 108
byte 1 108
byte 1 105
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $1853
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 47
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1852
byte 1 100
byte 1 109
byte 1 45
byte 1 113
byte 1 108
byte 1 0
align 1
LABELV $1848
byte 1 100
byte 1 101
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 45
byte 1 0
align 1
LABELV $1796
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
byte 1 111
byte 1 110
byte 1 116
byte 1 50
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 112
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1793
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
byte 1 111
byte 1 110
byte 1 116
byte 1 49
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 112
byte 1 95
byte 1 103
byte 1 108
byte 1 111
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1790
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
byte 1 111
byte 1 110
byte 1 116
byte 1 49
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 112
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1787
byte 1 119
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $1784
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 98
byte 1 105
byte 1 103
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $1782
byte 1 116
byte 1 114
byte 1 97
byte 1 112
byte 1 95
byte 1 82
byte 1 95
byte 1 65
byte 1 100
byte 1 100
byte 1 76
byte 1 105
byte 1 110
byte 1 101
byte 1 97
byte 1 114
byte 1 76
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 84
byte 1 111
byte 1 83
byte 1 99
byte 1 101
byte 1 110
byte 1 101
byte 1 95
byte 1 81
byte 1 51
byte 1 69
byte 1 0
align 1
LABELV $1779
byte 1 116
byte 1 114
byte 1 97
byte 1 112
byte 1 95
byte 1 82
byte 1 95
byte 1 65
byte 1 100
byte 1 100
byte 1 82
byte 1 101
byte 1 102
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 84
byte 1 111
byte 1 83
byte 1 99
byte 1 101
byte 1 110
byte 1 101
byte 1 50
byte 1 0
align 1
LABELV $1774
byte 1 47
byte 1 47
byte 1 116
byte 1 114
byte 1 97
byte 1 112
byte 1 95
byte 1 71
byte 1 101
byte 1 116
byte 1 86
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $1769
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
LABELV $1766
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
LABELV $1763
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
LABELV $1760
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
LABELV $1757
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
LABELV $1754
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
LABELV $1751
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
LABELV $1748
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
LABELV $1745
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
LABELV $1741
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
LABELV $1737
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
LABELV $1733
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
LABELV $1729
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
LABELV $1725
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
LABELV $1721
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
LABELV $1718
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
LABELV $1715
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
LABELV $1710
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 105
byte 1 97
byte 1 108
byte 1 46
byte 1 116
byte 1 116
byte 1 102
byte 1 0
align 1
LABELV $1618
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $1614
byte 1 37
byte 1 52
byte 1 105
byte 1 0
align 1
LABELV $1610
byte 1 76
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1607
byte 1 83
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $1604
byte 1 37
byte 1 105
byte 1 47
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1598
byte 1 82
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 0
align 1
LABELV $1590
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1486
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
LABELV $1483
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
LABELV $1471
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
LABELV $1468
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
byte 1 104
byte 1 117
byte 1 100
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
LABELV $1465
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
LABELV $1449
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 100
byte 1 101
byte 1 102
byte 1 0
align 1
LABELV $1443
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
LABELV $1429
byte 1 117
byte 1 105
byte 1 47
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 104
byte 1 117
byte 1 100
byte 1 46
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 0
align 1
LABELV $1416
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
LABELV $1408
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 89
byte 1 0
align 1
LABELV $1400
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 88
byte 1 0
align 1
LABELV $1392
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
LABELV $1384
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
LABELV $1376
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
LABELV $1364
byte 1 99
byte 1 117
byte 1 114
byte 1 115
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $1356
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
LABELV $1348
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
LABELV $1340
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
LABELV $1332
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
LABELV $1324
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
LABELV $1314
byte 1 98
byte 1 105
byte 1 103
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $1304
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
LABELV $1294
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $1290
byte 1 125
byte 1 0
align 1
LABELV $1281
byte 1 123
byte 1 0
align 1
LABELV $1274
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
LABELV $1271
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
LABELV $1264
byte 1 67
byte 1 71
byte 1 95
byte 1 67
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 83
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 100
byte 1 101
byte 1 120
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1239
byte 1 37
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $1225
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
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 99
byte 1 117
byte 1 114
byte 1 115
byte 1 111
byte 1 114
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1222
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
byte 1 105
byte 1 122
byte 1 101
byte 1 99
byte 1 117
byte 1 114
byte 1 115
byte 1 111
byte 1 114
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1219
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
LABELV $1202
byte 1 42
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1195
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 77
byte 1 97
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $1192
byte 1 119
byte 1 97
byte 1 107
byte 1 101
byte 1 0
align 1
LABELV $1189
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 83
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $1186
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $1183
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 104
byte 1 111
byte 1 108
byte 1 101
byte 1 95
byte 1 108
byte 1 103
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $1180
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 98
byte 1 117
byte 1 114
byte 1 110
byte 1 95
byte 1 109
byte 1 101
byte 1 100
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $1177
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $1165
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $1162
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 97
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $1159
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $1156
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $1153
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $1150
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 105
byte 1 109
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $1147
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 104
byte 1 105
byte 1 101
byte 1 108
byte 1 100
byte 1 47
byte 1 115
byte 1 104
byte 1 105
byte 1 101
byte 1 108
byte 1 100
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1144
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 114
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1141
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 104
byte 1 105
byte 1 101
byte 1 108
byte 1 100
byte 1 47
byte 1 106
byte 1 117
byte 1 105
byte 1 99
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1138
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 104
byte 1 105
byte 1 101
byte 1 108
byte 1 100
byte 1 47
byte 1 105
byte 1 109
byte 1 112
byte 1 97
byte 1 99
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1135
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1132
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 100
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 114
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1129
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 99
byte 1 111
byte 1 117
byte 1 116
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1126
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 103
byte 1 117
byte 1 97
byte 1 114
byte 1 100
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1123
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 116
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1120
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 107
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 105
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1117
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 107
byte 1 97
byte 1 109
byte 1 119
byte 1 97
byte 1 118
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1114
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 107
byte 1 97
byte 1 109
byte 1 98
byte 1 111
byte 1 111
byte 1 109
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1111
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 112
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1108
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 111
byte 1 109
byte 1 48
byte 1 49
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1105
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 48
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1102
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1099
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 69
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1096
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 111
byte 1 110
byte 1 51
byte 1 0
align 1
LABELV $1091
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 98
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1088
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1085
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 108
byte 1 101
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1082
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1079
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 114
byte 1 101
byte 1 97
byte 1 114
byte 1 109
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1076
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1073
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 102
byte 1 105
byte 1 115
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1070
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 101
byte 1 115
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1067
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1064
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 97
byte 1 98
byte 1 100
byte 1 111
byte 1 109
byte 1 101
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1061
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 50
byte 1 47
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 47
byte 1 115
byte 1 95
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1058
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 50
byte 1 47
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 95
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1055
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 114
byte 1 95
byte 1 121
byte 1 101
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $1052
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 95
byte 1 121
byte 1 101
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1049
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 107
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 98
byte 1 108
byte 1 117
byte 1 0
align 1
LABELV $1046
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 98
byte 1 97
byte 1 114
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $1043
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $1040
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 101
byte 1 0
align 1
LABELV $1030
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 107
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1027
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 47
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1024
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 47
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $1021
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 47
byte 1 114
byte 1 101
byte 1 100
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $1018
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 47
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1010
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 95
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 103
byte 1 121
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1007
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 95
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 115
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1004
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 95
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $1001
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $993
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 51
byte 1 0
align 1
LABELV $983
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 49
byte 1 0
align 1
LABELV $980
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 47
byte 1 110
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $972
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 112
byte 1 111
byte 1 98
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 47
byte 1 110
byte 1 116
byte 1 114
byte 1 108
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $969
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 112
byte 1 111
byte 1 98
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 47
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $966
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 112
byte 1 111
byte 1 98
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 47
byte 1 114
byte 1 101
byte 1 100
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $963
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 50
byte 1 47
byte 1 119
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $960
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 50
byte 1 47
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $957
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 50
byte 1 47
byte 1 114
byte 1 101
byte 1 100
byte 1 46
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $954
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 50
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 102
byte 1 108
byte 1 97
byte 1 112
byte 1 51
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $951
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 50
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 112
byte 1 111
byte 1 108
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $948
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 51
byte 1 0
align 1
LABELV $944
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 50
byte 1 0
align 1
LABELV $940
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 49
byte 1 0
align 1
LABELV $937
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $933
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 50
byte 1 0
align 1
LABELV $929
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 49
byte 1 0
align 1
LABELV $926
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $923
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 47
byte 1 114
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $911
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $908
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $905
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 111
byte 1 114
byte 1 98
byte 1 47
byte 1 98
byte 1 95
byte 1 111
byte 1 114
byte 1 98
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $902
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 111
byte 1 114
byte 1 98
byte 1 47
byte 1 114
byte 1 95
byte 1 111
byte 1 114
byte 1 98
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $890
byte 1 104
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 83
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $887
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 114
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $884
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $881
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $878
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 83
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $875
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 113
byte 1 117
byte 1 97
byte 1 100
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $872
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 113
byte 1 117
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $869
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 110
byte 1 111
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $866
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 116
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $863
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
LABELV $856
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $853
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $850
byte 1 119
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 66
byte 1 117
byte 1 98
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $847
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
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $844
byte 1 108
byte 1 97
byte 1 103
byte 1 111
byte 1 109
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $841
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $838
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 49
byte 1 0
align 1
LABELV $835
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 98
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $832
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 116
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $829
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 83
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $826
byte 1 115
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 82
byte 1 97
byte 1 103
byte 1 101
byte 1 80
byte 1 114
byte 1 111
byte 1 0
align 1
LABELV $823
byte 1 115
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $820
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $817
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $814
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $811
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $808
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $805
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 66
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 66
byte 1 108
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $802
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 53
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $798
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 52
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $794
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 51
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $790
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 50
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $786
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 49
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $777
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 97
byte 1 0
align 1
LABELV $772
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 115
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $771
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 110
byte 1 105
byte 1 110
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $770
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $769
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 115
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $768
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 115
byte 1 105
byte 1 120
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $767
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 102
byte 1 105
byte 1 118
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $766
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 117
byte 1 114
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $765
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 116
byte 1 104
byte 1 114
byte 1 101
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $764
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 116
byte 1 119
byte 1 111
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $763
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 111
byte 1 110
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $762
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 122
byte 1 101
byte 1 114
byte 1 111
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $759
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 47
byte 1 104
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 98
byte 1 50
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $756
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 47
byte 1 104
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 98
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $753
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 110
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $750
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $747
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 114
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $744
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 47
byte 1 119
byte 1 115
byte 1 116
byte 1 98
byte 1 97
byte 1 99
byte 1 116
byte 1 118
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $741
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 47
byte 1 119
byte 1 115
byte 1 116
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $738
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 47
byte 1 119
byte 1 115
byte 1 116
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $735
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 47
byte 1 119
byte 1 115
byte 1 116
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 108
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $732
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
byte 1 121
byte 1 111
byte 1 117
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $729
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
byte 1 121
byte 1 111
byte 1 117
byte 1 119
byte 1 105
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $726
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 107
byte 1 97
byte 1 109
byte 1 95
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 100
byte 1 101
byte 1 95
byte 1 102
byte 1 97
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $723
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 107
byte 1 97
byte 1 109
byte 1 95
byte 1 105
byte 1 109
byte 1 112
byte 1 108
byte 1 111
byte 1 100
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $720
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 107
byte 1 97
byte 1 109
byte 1 95
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 100
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $717
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 118
byte 1 117
byte 1 108
byte 1 99
byte 1 97
byte 1 110
byte 1 47
byte 1 119
byte 1 118
byte 1 117
byte 1 108
byte 1 105
byte 1 109
byte 1 112
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $714
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 118
byte 1 117
byte 1 108
byte 1 99
byte 1 97
byte 1 110
byte 1 47
byte 1 119
byte 1 118
byte 1 117
byte 1 108
byte 1 105
byte 1 109
byte 1 112
byte 1 108
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $711
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 118
byte 1 117
byte 1 108
byte 1 99
byte 1 97
byte 1 110
byte 1 47
byte 1 119
byte 1 118
byte 1 117
byte 1 108
byte 1 105
byte 1 109
byte 1 112
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $708
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 119
byte 1 110
byte 1 97
byte 1 108
byte 1 105
byte 1 109
byte 1 112
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $705
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 119
byte 1 110
byte 1 97
byte 1 108
byte 1 105
byte 1 109
byte 1 112
byte 1 108
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $702
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 119
byte 1 110
byte 1 97
byte 1 108
byte 1 105
byte 1 109
byte 1 112
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $699
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 47
byte 1 119
byte 1 115
byte 1 116
byte 1 98
byte 1 101
byte 1 120
byte 1 112
byte 1 108
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $696
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 120
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $693
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 47
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 108
byte 1 120
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $690
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $687
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $684
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $681
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $678
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 117
byte 1 115
byte 1 101
byte 1 95
byte 1 109
byte 1 101
byte 1 100
byte 1 107
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $675
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $656
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 99
byte 1 108
byte 1 97
byte 1 110
byte 1 107
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $652
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $648
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 103
byte 1 121
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $644
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 109
byte 1 101
byte 1 99
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $640
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 101
byte 1 115
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $636
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 111
byte 1 116
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $633
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $628
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 47
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 112
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $625
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 119
byte 1 97
byte 1 116
byte 1 114
byte 1 95
byte 1 117
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $622
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 119
byte 1 97
byte 1 116
byte 1 114
byte 1 95
byte 1 111
byte 1 117
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $619
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 119
byte 1 97
byte 1 116
byte 1 114
byte 1 95
byte 1 105
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $616
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
byte 1 116
byte 1 101
byte 1 95
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $613
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
byte 1 116
byte 1 101
byte 1 95
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $610
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
byte 1 116
byte 1 101
byte 1 95
byte 1 110
byte 1 111
byte 1 119
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $607
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
byte 1 108
byte 1 111
byte 1 115
byte 1 116
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $604
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
byte 1 116
byte 1 105
byte 1 101
byte 1 100
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $601
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
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 110
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $598
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
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 95
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $595
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
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 95
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $592
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
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 95
byte 1 105
byte 1 109
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $589
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
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $586
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
byte 1 97
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $583
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
byte 1 104
byte 1 117
byte 1 109
byte 1 105
byte 1 108
byte 1 105
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $580
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
byte 1 100
byte 1 101
byte 1 110
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $577
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
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $574
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
byte 1 105
byte 1 109
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $571
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
byte 1 104
byte 1 105
byte 1 116
byte 1 108
byte 1 111
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $568
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
byte 1 104
byte 1 105
byte 1 116
byte 1 104
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $565
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
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $562
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
byte 1 104
byte 1 105
byte 1 116
byte 1 49
byte 1 48
byte 1 48
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $558
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
byte 1 104
byte 1 105
byte 1 116
byte 1 55
byte 1 53
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $554
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
byte 1 104
byte 1 105
byte 1 116
byte 1 53
byte 1 48
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $550
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
byte 1 104
byte 1 105
byte 1 116
byte 1 50
byte 1 53
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $547
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 108
byte 1 97
byte 1 110
byte 1 100
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $544
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 116
byte 1 97
byte 1 108
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $541
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 110
byte 1 111
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $538
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $535
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 111
byte 1 117
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $532
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 105
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $529
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 99
byte 1 108
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 117
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $526
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 99
byte 1 108
byte 1 95
byte 1 103
byte 1 117
byte 1 97
byte 1 114
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $523
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 99
byte 1 108
byte 1 95
byte 1 100
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 114
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $520
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 99
byte 1 108
byte 1 95
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $517
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $514
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 95
byte 1 104
byte 1 105
byte 1 116
byte 1 95
byte 1 48
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $511
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 95
byte 1 104
byte 1 105
byte 1 116
byte 1 95
byte 1 48
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $508
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 95
byte 1 104
byte 1 105
byte 1 116
byte 1 95
byte 1 48
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $505
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 118
byte 1 117
byte 1 108
byte 1 95
byte 1 106
byte 1 117
byte 1 105
byte 1 99
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $502
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 118
byte 1 117
byte 1 108
byte 1 95
byte 1 105
byte 1 109
byte 1 112
byte 1 97
byte 1 99
byte 1 116
byte 1 95
byte 1 48
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $499
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 118
byte 1 117
byte 1 108
byte 1 95
byte 1 105
byte 1 109
byte 1 112
byte 1 97
byte 1 99
byte 1 116
byte 1 95
byte 1 48
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $496
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 118
byte 1 117
byte 1 108
byte 1 95
byte 1 105
byte 1 109
byte 1 112
byte 1 97
byte 1 99
byte 1 116
byte 1 95
byte 1 48
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $493
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 118
byte 1 117
byte 1 108
byte 1 95
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $490
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $487
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $484
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $481
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 112
byte 1 108
byte 1 116
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $478
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 117
byte 1 115
byte 1 101
byte 1 95
byte 1 110
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $475
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 114
byte 1 111
byte 1 102
byte 1 102
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $472
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $469
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 98
byte 1 117
byte 1 108
byte 1 101
byte 1 116
byte 1 98
byte 1 121
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $456
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 95
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $448
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
byte 1 104
byte 1 111
byte 1 108
byte 1 121
byte 1 115
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $445
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $435
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 95
byte 1 49
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $432
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 49
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $422
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $419
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $416
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 95
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $413
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 95
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $405
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 110
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $402
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 110
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $399
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $396
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $393
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $388
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $385
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $382
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
byte 1 104
byte 1 105
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $379
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
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 116
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $376
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
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $373
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
byte 1 114
byte 1 101
byte 1 100
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $370
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $362
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
byte 1 112
byte 1 114
byte 1 101
byte 1 112
byte 1 97
byte 1 114
byte 1 101
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $359
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
byte 1 112
byte 1 114
byte 1 101
byte 1 112
byte 1 97
byte 1 114
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $356
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
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $353
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
byte 1 111
byte 1 110
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $350
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
byte 1 116
byte 1 119
byte 1 111
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $347
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
byte 1 116
byte 1 104
byte 1 114
byte 1 101
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $344
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
byte 1 51
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $341
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
byte 1 50
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $338
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
byte 1 49
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $335
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
byte 1 115
byte 1 117
byte 1 100
byte 1 100
byte 1 101
byte 1 110
byte 1 95
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $332
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
byte 1 53
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $329
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
byte 1 49
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $325
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $319
byte 1 80
byte 1 114
byte 1 101
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $248
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
LABELV $247
byte 1 115
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $246
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $239
byte 1 115
byte 1 118
byte 1 95
byte 1 114
byte 1 117
byte 1 110
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $233
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 84
byte 1 105
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $232
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 75
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $231
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 97
byte 1 100
byte 1 66
byte 1 111
byte 1 100
byte 1 121
byte 1 68
byte 1 97
byte 1 114
byte 1 107
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $230
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $229
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $228
byte 1 99
byte 1 103
byte 1 95
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $227
byte 1 99
byte 1 103
byte 1 95
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $226
byte 1 99
byte 1 103
byte 1 95
byte 1 104
byte 1 105
byte 1 116
byte 1 83
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $225
byte 1 48
byte 1 46
byte 1 48
byte 1 0
align 1
LABELV $224
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 117
byte 1 101
byte 1 76
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $223
byte 1 99
byte 1 103
byte 1 95
byte 1 111
byte 1 108
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 0
align 1
LABELV $222
byte 1 99
byte 1 103
byte 1 95
byte 1 111
byte 1 108
byte 1 100
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $221
byte 1 99
byte 1 103
byte 1 95
byte 1 111
byte 1 108
byte 1 100
byte 1 82
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $220
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
LABELV $219
byte 1 48
byte 1 46
byte 1 50
byte 1 53
byte 1 0
align 1
LABELV $218
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
LABELV $217
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 80
byte 1 114
byte 1 111
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 108
byte 1 101
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $216
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 84
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $215
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 97
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $214
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 109
byte 1 111
byte 1 111
byte 1 116
byte 1 104
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $213
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 80
byte 1 108
byte 1 117
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $212
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $211
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 70
byte 1 97
byte 1 100
byte 1 101
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $210
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 70
byte 1 97
byte 1 100
byte 1 101
byte 1 69
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $209
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $208
byte 1 103
byte 1 95
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 82
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 68
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $207
byte 1 103
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 66
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $206
byte 1 103
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 68
byte 1 117
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $205
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
LABELV $204
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
LABELV $203
byte 1 80
byte 1 97
byte 1 103
byte 1 97
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $202
byte 1 103
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
LABELV $201
byte 1 83
byte 1 116
byte 1 114
byte 1 111
byte 1 103
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $200
byte 1 103
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
LABELV $199
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 0
align 1
LABELV $198
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
LABELV $197
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 0
align 1
LABELV $196
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 115
byte 1 79
byte 1 110
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $195
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 70
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $194
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $193
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $192
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $191
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $190
byte 1 99
byte 1 103
byte 1 95
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $189
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $188
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 72
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $187
byte 1 51
byte 1 48
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $186
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $185
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
LABELV $184
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
byte 1 65
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $183
byte 1 52
byte 1 48
byte 1 0
align 1
LABELV $182
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
byte 1 82
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $181
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $180
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 119
byte 1 105
byte 1 100
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $179
byte 1 48
byte 1 46
byte 1 52
byte 1 0
align 1
LABELV $178
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $177
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $176
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $175
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $174
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $173
byte 1 99
byte 1 103
byte 1 95
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 99
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $172
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $171
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 112
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $170
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 0
align 1
LABELV $169
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $168
byte 1 48
byte 1 46
byte 1 51
byte 1 0
align 1
LABELV $167
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $166
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $165
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 112
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $164
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $163
byte 1 48
byte 1 46
byte 1 48
byte 1 48
byte 1 53
byte 1 0
align 1
LABELV $162
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 117
byte 1 110
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $161
byte 1 48
byte 1 46
byte 1 48
byte 1 48
byte 1 50
byte 1 0
align 1
LABELV $160
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 117
byte 1 110
byte 1 112
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $159
byte 1 51
byte 1 0
align 1
LABELV $158
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $157
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 117
byte 1 110
byte 1 90
byte 1 0
align 1
LABELV $156
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 117
byte 1 110
byte 1 89
byte 1 0
align 1
LABELV $155
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 117
byte 1 110
byte 1 88
byte 1 0
align 1
LABELV $154
byte 1 0
align 1
LABELV $153
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 117
byte 1 110
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $152
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 82
byte 1 97
byte 1 100
byte 1 105
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $151
byte 1 52
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $150
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $149
byte 1 99
byte 1 103
byte 1 95
byte 1 108
byte 1 97
byte 1 103
byte 1 111
byte 1 109
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $148
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
LABELV $147
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 105
byte 1 109
byte 1 112
byte 1 108
byte 1 101
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $146
byte 1 50
byte 1 53
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $145
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
LABELV $144
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 89
byte 1 0
align 1
LABELV $143
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 88
byte 1 0
align 1
LABELV $142
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $141
byte 1 50
byte 1 52
byte 1 0
align 1
LABELV $140
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 83
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $139
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 83
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $138
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 82
byte 1 101
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $137
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
LABELV $136
byte 1 52
byte 1 0
align 1
LABELV $135
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
LABELV $134
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $133
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 65
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $132
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $131
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 73
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $130
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 51
byte 1 100
byte 1 73
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $129
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $128
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 70
byte 1 80
byte 1 83
byte 1 0
align 1
LABELV $127
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
LABELV $126
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $125
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 50
byte 1 68
byte 1 0
align 1
LABELV $124
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 0
align 1
LABELV $123
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
LABELV $122
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $121
byte 1 99
byte 1 103
byte 1 95
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $120
byte 1 57
byte 1 48
byte 1 0
align 1
LABELV $119
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 118
byte 1 0
align 1
LABELV $118
byte 1 50
byte 1 50
byte 1 46
byte 1 53
byte 1 0
align 1
LABELV $117
byte 1 99
byte 1 103
byte 1 95
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 102
byte 1 111
byte 1 118
byte 1 0
align 1
LABELV $116
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 71
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $115
byte 1 49
byte 1 0
align 1
LABELV $114
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $113
byte 1 48
byte 1 0
align 1
LABELV $112
byte 1 99
byte 1 103
byte 1 95
byte 1 105
byte 1 103
byte 1 110
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $109
byte 1 118
byte 1 109
byte 1 77
byte 1 97
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $92
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
LABELV $91
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
LABELV $90
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
LABELV $89
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
LABELV $88
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
LABELV $87
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
LABELV $86
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
LABELV $85
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
LABELV $84
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
LABELV $83
byte 1 82
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $82
byte 1 68
byte 1 117
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $81
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

code
proc CG_TargetCommand_f 20 12
file "..\..\..\..\code\cgame\cg_consolecmds.c"
line 15
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_consolecmds.c -- text commands typed in at the local console, or
;4:// executed by a key binding
;5:
;6:#include "cg_local.h"
;7:#include "../ui/ui_shared.h"
;8:extern menuDef_t *menuScoreboard;
;9:
;10:/*
;11:=================
;12:CG_TargetCommand_f
;13:=================
;14:*/
;15:static void CG_TargetCommand_f(void) {
line 19
;16:	int		targetNum;
;17:	char	cmd[4];
;18:
;19:	targetNum = CG_CrosshairPlayer();
ADDRLP4 8
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 20
;20:	if (targetNum == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $82
line 21
;21:		return;
ADDRGP4 $81
JUMPV
LABELV $82
line 24
;22:	}
;23:
;24:	trap_Argv(1, cmd, sizeof(cmd));
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 25
;25:	trap_SendConsoleCommand(va("gc %i %i", targetNum, atoi(cmd)));
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 $84
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 26
;26:}
LABELV $81
endproc CG_TargetCommand_f 20 12
proc CG_SizeUp_f 4 8
line 37
;27:
;28:
;29:
;30:/*
;31:=================
;32:CG_SizeUp_f
;33:
;34:Keybinding command
;35:=================
;36:*/
;37:static void CG_SizeUp_f(void) {
line 38
;38:	trap_Cvar_Set("cg_viewsize", va("%i", (int)(cg_viewsize.integer + 10)));
ADDRGP4 $87
ARGP4
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 10
ADDI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $86
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 39
;39:}
LABELV $85
endproc CG_SizeUp_f 4 8
proc CG_SizeDown_f 4 8
line 49
;40:
;41:
;42:/*
;43:=================
;44:CG_SizeDown_f
;45:
;46:Keybinding command
;47:=================
;48:*/
;49:static void CG_SizeDown_f(void) {
line 50
;50:	trap_Cvar_Set("cg_viewsize", va("%i", (int)(cg_viewsize.integer - 10)));
ADDRGP4 $87
ARGP4
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 10
SUBI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $86
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 51
;51:}
LABELV $89
endproc CG_SizeDown_f 4 8
proc CG_Viewpos_f 0 20
line 61
;52:
;53:
;54:/*
;55:=============
;56:CG_Viewpos_f
;57:
;58:Debugging command to print the current position
;59:=============
;60:*/
;61:static void CG_Viewpos_f(void) {
line 62
;62:	CG_Printf("(%i %i %i) : %i\n", (int)cg.refdef.vieworg[0],
ADDRGP4 $92
ARGP4
ADDRGP4 cg+109056+24
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cg+109056+24+4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cg+109056+24+8
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 cg+109424+4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 65
;63:		(int)cg.refdef.vieworg[1], (int)cg.refdef.vieworg[2],
;64:		(int)cg.refdefViewAngles[YAW]);
;65:}
LABELV $91
endproc CG_Viewpos_f 0 20
proc CG_ScoresDown_f 0 4
line 68
;66:
;67:
;68:static void CG_ScoresDown_f(void) {
line 70
;69:
;70:	CG_BuildSpectatorString();
ADDRGP4 CG_BuildSpectatorString
CALLV
pop
line 72
;71:
;72:	if (cg.scoresRequestTime + 2000 < cg.time && !cg.demoPlayback) {
ADDRGP4 cg+110472
INDIRI4
CNSTI4 2000
ADDI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $104
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
NEI4 $104
line 75
;73:		// the scores are more than two seconds out of data,
;74:		// so request new ones
;75:		cg.scoresRequestTime = cg.time;
ADDRGP4 cg+110472
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 76
;76:		trap_SendClientCommand("score");
ADDRGP4 $111
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 80
;77:
;78:		// leave the current scores up if they were already
;79:		// displayed, but if this is the first hit, clear them out
;80:		if (!cg.showScores) {
ADDRGP4 cg+115356
INDIRI4
CNSTI4 0
NEI4 $105
line 81
;81:			cg.showScores = qtrue;
ADDRGP4 cg+115356
CNSTI4 1
ASGNI4
line 82
;82:			cg.numScores = 0;
ADDRGP4 cg+110476
CNSTI4 0
ASGNI4
line 83
;83:		}
line 84
;84:	} else {
ADDRGP4 $105
JUMPV
LABELV $104
line 87
;85:		// show the cached contents even if they just pressed if it
;86:		// is within two seconds
;87:		cg.showScores = qtrue;
ADDRGP4 cg+115356
CNSTI4 1
ASGNI4
line 88
;88:	}
LABELV $105
line 90
;89:
;90:	CG_SetScoreCatcher(cg.showScores);
ADDRGP4 cg+115356
INDIRI4
ARGI4
ADDRGP4 CG_SetScoreCatcher
CALLV
pop
line 91
;91:}
LABELV $103
endproc CG_ScoresDown_f 0 4
proc CG_ScoresUp_f 0 4
line 94
;92:
;93:
;94:static void CG_ScoresUp_f(void) {
line 96
;95:
;96:	if (cgs.filterKeyUpEvent) {
ADDRGP4 cgs+147932
INDIRI4
CNSTI4 0
EQI4 $120
line 97
;97:		cgs.filterKeyUpEvent = qfalse;
ADDRGP4 cgs+147932
CNSTI4 0
ASGNI4
line 98
;98:		return;
ADDRGP4 $119
JUMPV
LABELV $120
line 101
;99:	}
;100:
;101:	if (cg.showScores) {
ADDRGP4 cg+115356
INDIRI4
CNSTI4 0
EQI4 $124
line 102
;102:		cg.showScores = qfalse;
ADDRGP4 cg+115356
CNSTI4 0
ASGNI4
line 103
;103:		cg.scoreFadeTime = cg.time;
ADDRGP4 cg+115364
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 104
;104:	}
LABELV $124
line 106
;105:
;106:	CG_SetScoreCatcher(cg.showScores);
ADDRGP4 cg+115356
INDIRI4
ARGI4
ADDRGP4 CG_SetScoreCatcher
CALLV
pop
line 107
;107:}
LABELV $119
endproc CG_ScoresUp_f 0 4
proc CG_LoadHud_f 1028 12
line 113
;108:
;109:
;110:extern menuDef_t *menuScoreboard;
;111:void Menu_Reset(void);			// FIXME: add to right include file
;112:
;113:static void CG_LoadHud_f(void) {
line 116
;114:	char buff[1024];
;115:	const char *hudSet;
;116:	memset(buff, 0, sizeof(buff));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 118
;117:
;118:	String_Init();
ADDRGP4 String_Init
CALLV
pop
line 119
;119:	Menu_Reset();
ADDRGP4 Menu_Reset
CALLV
pop
line 121
;120:
;121:	trap_Cvar_VariableStringBuffer("cg_hudFiles", buff, sizeof(buff));
ADDRGP4 $132
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 122
;122:	hudSet = buff;
ADDRLP4 1024
ADDRLP4 0
ASGNP4
line 123
;123:	if (hudSet[0] == '\0') {
ADDRLP4 1024
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $133
line 124
;124:		hudSet = "ui/hud.txt";
ADDRLP4 1024
ADDRGP4 $135
ASGNP4
line 125
;125:	}
LABELV $133
line 127
;126:
;127:	CG_LoadMenus(hudSet);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 CG_LoadMenus
CALLV
pop
line 128
;128:	menuScoreboard = NULL;
ADDRGP4 menuScoreboard
CNSTP4 0
ASGNP4
line 129
;129:}
LABELV $131
endproc CG_LoadHud_f 1028 12
proc CG_scrollScoresDown_f 0 12
line 132
;130:
;131:
;132:static void CG_scrollScoresDown_f(void) {
line 133
;133:	if (menuScoreboard && cg.scoreBoardShowing) {
ADDRGP4 menuScoreboard
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $137
ADDRGP4 cg+115360
INDIRI4
CNSTI4 0
EQI4 $137
line 134
;134:		Menu_ScrollFeeder(menuScoreboard, FEEDER_SCOREBOARD, qtrue);
ADDRGP4 menuScoreboard
INDIRP4
ARGP4
CNSTI4 11
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ScrollFeeder
CALLV
pop
line 135
;135:		Menu_ScrollFeeder(menuScoreboard, FEEDER_REDTEAM_LIST, qtrue);
ADDRGP4 menuScoreboard
INDIRP4
ARGP4
CNSTI4 5
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ScrollFeeder
CALLV
pop
line 136
;136:		Menu_ScrollFeeder(menuScoreboard, FEEDER_BLUETEAM_LIST, qtrue);
ADDRGP4 menuScoreboard
INDIRP4
ARGP4
CNSTI4 6
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ScrollFeeder
CALLV
pop
line 137
;137:	}
LABELV $137
line 138
;138:}
LABELV $136
endproc CG_scrollScoresDown_f 0 12
proc CG_scrollScoresUp_f 0 12
line 141
;139:
;140:
;141:static void CG_scrollScoresUp_f(void) {
line 142
;142:	if (menuScoreboard && cg.scoreBoardShowing) {
ADDRGP4 menuScoreboard
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $141
ADDRGP4 cg+115360
INDIRI4
CNSTI4 0
EQI4 $141
line 143
;143:		Menu_ScrollFeeder(menuScoreboard, FEEDER_SCOREBOARD, qfalse);
ADDRGP4 menuScoreboard
INDIRP4
ARGP4
CNSTI4 11
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ScrollFeeder
CALLV
pop
line 144
;144:		Menu_ScrollFeeder(menuScoreboard, FEEDER_REDTEAM_LIST, qfalse);
ADDRGP4 menuScoreboard
INDIRP4
ARGP4
CNSTI4 5
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ScrollFeeder
CALLV
pop
line 145
;145:		Menu_ScrollFeeder(menuScoreboard, FEEDER_BLUETEAM_LIST, qfalse);
ADDRGP4 menuScoreboard
INDIRP4
ARGP4
CNSTI4 6
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ScrollFeeder
CALLV
pop
line 146
;146:	}
LABELV $141
line 147
;147:}
LABELV $140
endproc CG_scrollScoresUp_f 0 12
proc CG_TellTarget_f 264 20
line 155
;148:
;149:
;150:/*
;151:==================
;152:CG_TellTarget_f
;153:==================
;154:*/
;155:static void CG_TellTarget_f(void) {
line 160
;156:	int		clientNum;
;157:	char	command[128];
;158:	char	message[128];
;159:
;160:	clientNum = CG_CrosshairPlayer();
ADDRLP4 260
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 161
;161:	if (clientNum == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $145
line 162
;162:		return;
ADDRGP4 $144
JUMPV
LABELV $145
line 165
;163:	}
;164:
;165:	trap_Args(message, sizeof(message));
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 166
;166:	Com_sprintf(command, sizeof(command), "tell %i %s", clientNum, message);
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $147
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 167
;167:	trap_SendClientCommand(command);
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 168
;168:}
LABELV $144
endproc CG_TellTarget_f 264 20
proc CG_TellAttacker_f 264 20
line 176
;169:
;170:
;171:/*
;172:==================
;173:CG_TellAttacker_f
;174:==================
;175:*/
;176:static void CG_TellAttacker_f(void) {
line 181
;177:	int		clientNum;
;178:	char	command[128];
;179:	char	message[128];
;180:
;181:	clientNum = CG_LastAttacker();
ADDRLP4 260
ADDRGP4 CG_LastAttacker
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 182
;182:	if (clientNum == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $149
line 183
;183:		return;
ADDRGP4 $148
JUMPV
LABELV $149
line 186
;184:	}
;185:
;186:	trap_Args(message, sizeof(message));
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 187
;187:	Com_sprintf(command, sizeof(command), "tell %i %s", clientNum, message);
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $147
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 188
;188:	trap_SendClientCommand(command);
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 189
;189:}
LABELV $148
endproc CG_TellAttacker_f 264 20
proc CG_ConfirmOrder_f 4 8
line 195
;190:
;191:
;192:// ASS U ME's enumeration order as far as task specific orders, OFFENSE is zero, CAMP is last
;193://
;194:
;195:static void CG_ConfirmOrder_f(void) {
line 196
;196:	trap_SendConsoleCommand("+button5; wait; -button5");
ADDRGP4 $152
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 197
;197:	if (cg.time < cgs.acceptOrderTime) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+146652
INDIRI4
GEI4 $153
line 198
;198:		trap_SendClientCommand(va("teamtask %d\n", cgs.acceptTask));
ADDRGP4 $157
ARGP4
ADDRGP4 cgs+146656
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 199
;199:		cgs.acceptOrderTime = 0;
ADDRGP4 cgs+146652
CNSTI4 0
ASGNI4
line 200
;200:	}
LABELV $153
line 201
;201:}
LABELV $151
endproc CG_ConfirmOrder_f 4 8
proc CG_DenyOrder_f 0 4
line 203
;202:
;203:static void CG_DenyOrder_f(void) {
line 204
;204:	trap_SendConsoleCommand("+button6; wait; -button6");
ADDRGP4 $161
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 205
;205:	if (cg.time < cgs.acceptOrderTime) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+146652
INDIRI4
GEI4 $162
line 206
;206:		cgs.acceptOrderTime = 0;
ADDRGP4 cgs+146652
CNSTI4 0
ASGNI4
line 207
;207:	}
LABELV $162
line 208
;208:}
LABELV $160
endproc CG_DenyOrder_f 0 4
proc CG_TaskOffense_f 4 8
line 210
;209:
;210:static void CG_TaskOffense_f(void) {
line 211
;211:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_OFFENSE));
ADDRGP4 $157
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 212
;212:}
LABELV $167
endproc CG_TaskOffense_f 4 8
proc CG_TaskDefense_f 4 8
line 214
;213:
;214:static void CG_TaskDefense_f(void) {
line 215
;215:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_DEFENSE));
ADDRGP4 $157
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 216
;216:}
LABELV $168
endproc CG_TaskDefense_f 4 8
proc CG_TaskPatrol_f 4 8
line 218
;217:
;218:static void CG_TaskPatrol_f(void) {
line 219
;219:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_PATROL));
ADDRGP4 $157
ARGP4
CNSTI4 3
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 220
;220:}
LABELV $169
endproc CG_TaskPatrol_f 4 8
proc CG_TaskCamp_f 4 8
line 222
;221:
;222:static void CG_TaskCamp_f(void) {
line 223
;223:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_CAMP));
ADDRGP4 $157
ARGP4
CNSTI4 7
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 224
;224:}
LABELV $170
endproc CG_TaskCamp_f 4 8
proc CG_TaskFollow_f 4 8
line 226
;225:
;226:static void CG_TaskFollow_f(void) {
line 227
;227:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_FOLLOW));
ADDRGP4 $157
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 228
;228:}
LABELV $171
endproc CG_TaskFollow_f 4 8
proc CG_TaskRetrieve_f 4 8
line 230
;229:
;230:static void CG_TaskRetrieve_f(void) {
line 231
;231:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_RETRIEVE));
ADDRGP4 $157
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 232
;232:}
LABELV $172
endproc CG_TaskRetrieve_f 4 8
proc CG_TaskEscort_f 4 8
line 234
;233:
;234:static void CG_TaskEscort_f(void) {
line 235
;235:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_ESCORT));
ADDRGP4 $157
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 236
;236:}
LABELV $173
endproc CG_TaskEscort_f 4 8
proc CG_TaskOwnFlag_f 0 0
line 238
;237:
;238:static void CG_TaskOwnFlag_f(void) {}
LABELV $174
endproc CG_TaskOwnFlag_f 0 0
proc CG_TaskSuicide_f 136 16
line 240
;239:
;240:static void CG_TaskSuicide_f(void) {
line 244
;241:	int		clientNum;
;242:	char	command[128];
;243:
;244:	clientNum = CG_CrosshairPlayer();
ADDRLP4 132
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 132
INDIRI4
ASGNI4
line 245
;245:	if (clientNum == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $176
line 246
;246:		return;
ADDRGP4 $175
JUMPV
LABELV $176
line 249
;247:	}
;248:
;249:	Com_sprintf(command, 128, "tell %i suicide", clientNum);
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $178
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 250
;250:	trap_SendClientCommand(command);
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 251
;251:}
LABELV $175
endproc CG_TaskSuicide_f 136 16
data
align 4
LABELV commands
address $180
address CG_TestGun_f
address $181
address CG_TestModel_f
address $182
address CG_TestModelNextFrame_f
address $183
address CG_TestModelPrevFrame_f
address $184
address CG_TestModelNextSkin_f
address $185
address CG_TestModelPrevSkin_f
address $186
address CG_Viewpos_f
address $187
address CG_ScoresDown_f
address $188
address CG_ScoresUp_f
address $189
address CG_ZoomDown_f
address $190
address CG_ZoomUp_f
address $191
address CG_SizeUp_f
address $192
address CG_SizeDown_f
address $193
address CG_NextWeapon_f
address $194
address CG_PrevWeapon_f
address $195
address CG_Weapon_f
address $196
address CG_TargetCommand_f
address $197
address CG_TellTarget_f
address $198
address CG_TellAttacker_f
address $199
address CG_LoadHud_f
address $200
address CG_ConfirmOrder_f
address $201
address CG_DenyOrder_f
address $202
address CG_TaskOffense_f
address $203
address CG_TaskDefense_f
address $204
address CG_TaskPatrol_f
address $205
address CG_TaskCamp_f
address $206
address CG_TaskFollow_f
address $207
address CG_TaskRetrieve_f
address $208
address CG_TaskEscort_f
address $209
address CG_TaskSuicide_f
address $210
address CG_TaskOwnFlag_f
address $211
address CG_scrollScoresDown_f
address $212
address CG_scrollScoresUp_f
address $213
address CG_LoadDeferredPlayers
export CG_ConsoleCommand
code
proc CG_ConsoleCommand 16 8
line 306
;252:
;253:
;254:typedef struct {
;255:	const char *cmd;
;256:	void	(*function)(void);
;257:} consoleCommand_t;
;258:
;259:static consoleCommand_t	commands[] = {
;260:	{ "testgun", CG_TestGun_f },
;261:	{ "testmodel", CG_TestModel_f },
;262:	{ "nextframe", CG_TestModelNextFrame_f },
;263:	{ "prevframe", CG_TestModelPrevFrame_f },
;264:	{ "nextskin", CG_TestModelNextSkin_f },
;265:	{ "prevskin", CG_TestModelPrevSkin_f },
;266:	{ "viewpos", CG_Viewpos_f },
;267:	{ "+scores", CG_ScoresDown_f },
;268:	{ "-scores", CG_ScoresUp_f },
;269:	{ "+zoom", CG_ZoomDown_f },
;270:	{ "-zoom", CG_ZoomUp_f },
;271:	{ "sizeup", CG_SizeUp_f },
;272:	{ "sizedown", CG_SizeDown_f },
;273:	{ "weapnext", CG_NextWeapon_f },
;274:	{ "weapprev", CG_PrevWeapon_f },
;275:	{ "weapon", CG_Weapon_f },
;276:	{ "tcmd", CG_TargetCommand_f },
;277:	{ "tell_target", CG_TellTarget_f },
;278:	{ "tell_attacker", CG_TellAttacker_f },
;279:	{ "loadhud", CG_LoadHud_f },
;280:	{ "confirmOrder", CG_ConfirmOrder_f },
;281:	{ "denyOrder", CG_DenyOrder_f },
;282:	{ "taskOffense", CG_TaskOffense_f },
;283:	{ "taskDefense", CG_TaskDefense_f },
;284:	{ "taskPatrol", CG_TaskPatrol_f },
;285:	{ "taskCamp", CG_TaskCamp_f },
;286:	{ "taskFollow", CG_TaskFollow_f },
;287:	{ "taskRetrieve", CG_TaskRetrieve_f },
;288:	{ "taskEscort", CG_TaskEscort_f },
;289:	{ "taskSuicide", CG_TaskSuicide_f },
;290:	{ "taskOwnFlag", CG_TaskOwnFlag_f },
;291:	{ "scoresDown", CG_scrollScoresDown_f },
;292:	{ "scoresUp", CG_scrollScoresUp_f },
;293:	//{ "camera", CG_Camera_f },
;294:	{ "loaddeferred", CG_LoadDeferredPlayers }
;295:};
;296:
;297:
;298:/*
;299:=================
;300:CG_ConsoleCommand
;301:
;302:The string has been tokenized and can be retrieved with
;303:Cmd_Argc() / Cmd_Argv()
;304:=================
;305:*/
;306:qboolean CG_ConsoleCommand(void) {
line 310
;307:	const char *cmd;
;308:	int		i;
;309:
;310:	cmd = CG_Argv(0);
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 312
;311:
;312:	for (i = 0; i < ARRAY_LEN(commands); i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $218
JUMPV
LABELV $215
line 313
;313:		if (!Q_stricmp(cmd, commands[i].cmd)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commands
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $219
line 314
;314:			commands[i].function();
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commands+4
ADDP4
INDIRP4
CALLV
pop
line 315
;315:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $214
JUMPV
LABELV $219
line 317
;316:		}
;317:	}
LABELV $216
line 312
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $218
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 34
LTU4 $215
line 319
;318:
;319:	return qfalse;
CNSTI4 0
RETI4
LABELV $214
endproc CG_ConsoleCommand 16 8
export CG_InitConsoleCommands
proc CG_InitConsoleCommands 4 4
line 331
;320:}
;321:
;322:
;323:/*
;324:=================
;325:CG_InitConsoleCommands
;326:
;327:Let the client system know about all of our commands
;328:so it can perform tab completion
;329:=================
;330:*/
;331:void CG_InitConsoleCommands(void) {
line 334
;332:	int		i;
;333:
;334:	for (i = 0; i < ARRAY_LEN(commands); i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $226
JUMPV
LABELV $223
line 335
;335:		trap_AddCommand(commands[i].cmd);
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commands
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 336
;336:	}
LABELV $224
line 334
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $226
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 34
LTU4 $223
line 342
;337:
;338:	//
;339:	// the game server will interpret these commands, which will be automatically
;340:	// forwarded to the server after they are not recognized locally
;341:	//
;342:	trap_AddCommand("kill");
ADDRGP4 $227
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 343
;343:	trap_AddCommand("say");
ADDRGP4 $228
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 344
;344:	trap_AddCommand("say_team");
ADDRGP4 $229
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 345
;345:	trap_AddCommand("tell");
ADDRGP4 $230
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 346
;346:	trap_AddCommand("give");
ADDRGP4 $231
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 347
;347:	trap_AddCommand("god");
ADDRGP4 $232
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 348
;348:	trap_AddCommand("notarget");
ADDRGP4 $233
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 349
;349:	trap_AddCommand("noclip");
ADDRGP4 $234
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 350
;350:	trap_AddCommand("team");
ADDRGP4 $235
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 351
;351:	trap_AddCommand("follow");
ADDRGP4 $236
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 352
;352:	trap_AddCommand("levelshot");
ADDRGP4 $237
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 353
;353:	trap_AddCommand("addbot");
ADDRGP4 $238
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 354
;354:	trap_AddCommand("setviewpos");
ADDRGP4 $239
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 355
;355:	trap_AddCommand("callvote");
ADDRGP4 $240
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 356
;356:	trap_AddCommand("vote");
ADDRGP4 $241
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 357
;357:	trap_AddCommand("stats");
ADDRGP4 $242
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 358
;358:	trap_AddCommand("teamtask");
ADDRGP4 $243
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 359
;359:	trap_AddCommand("loaddefered");	// spelled wrong, but not changing for demo
ADDRGP4 $244
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 360
;360:}
LABELV $222
endproc CG_InitConsoleCommands 4 4
import menuScoreboard
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
import trap_R_AddLinearLightToScene
import trap_R_AddRefEntityToScene2
import linearLight
import intShaderTime
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
import CG_ParseSysteminfo
import CG_ParseServerinfo
import CG_ExecuteNewServerCommands
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
import CG_ForceModelChange
import CG_StatusHandle
import CG_OtherTeamHasFlag
import CG_YourTeamHasFlag
import CG_GameTypeString
import CG_Text_PaintChar
import CG_Draw3DModel
import CG_GetKillerText
import CG_GetGameStatusText
import CG_GetTeamColor
import CG_ShowResponseHead
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
import CG_BuildSpectatorString
import CG_SetScoreSelection
import CG_EventHandling
import CG_MouseEvent
import CG_KeyEvent
import CG_LoadMenus
import CG_LastAttacker
import CG_CrosshairPlayer
import CG_UpdateCvars
import CG_StartMusic
import CG_Error
import CG_Printf
import CG_Argv
import CG_ConfigString
import eventnames
import cg_followKiller
import cg_deadBodyDarken
import cg_teamColors
import cg_teamModel
import cg_enemyColors
import cg_enemyModel
import cg_hitSounds
import cg_trueLightning
import cg_oldPlasma
import cg_oldRocket
import cg_oldRail
import cg_bigFont
import cg_smallFont
import cg_noProjectileTrail
import cg_noTaunt
import cg_cameraMode
import cg_smoothClients
import cg_scorePlum
import cg_timescale
import cg_timescaleFadeSpeed
import cg_timescaleFadeEnd
import cg_obeliskRespawnDelay
import cg_enableBreath
import cg_enableDust
import cg_hudFiles
import cg_blueTeamName
import cg_redTeamName
import cg_blood
import cg_paused
import cg_buildScript
import cg_teamChatsOnly
import cg_drawFriend
import cg_stats
import cg_teamOverlayUserinfo
import cg_drawTeamOverlay
import cg_deferPlayers
import cg_predictItems
import cg_forceModel
import cg_teamChatHeight
import cg_teamChatTime
import cg_thirdPerson
import cg_thirdPersonAngle
import cg_thirdPersonRange
import cg_tracerLength
import cg_tracerWidth
import cg_tracerChance
import cg_footsteps
import cg_showmiss
import cg_noPlayerAnims
import cg_nopredict
import cg_errorDecay
import cg_debugEvents
import cg_debugPosition
import cg_debugAnim
import cg_animSpeed
import cg_swingSpeed
import cg_bobroll
import cg_bobpitch
import cg_bobup
import cg_runroll
import cg_runpitch
import cg_centertime
import cg_gun_z
import cg_gun_y
import cg_gun_x
import cg_gun_frame
import cg_railTrailRadius
import cg_railTrailTime
import cg_lagometer
import cg_addMarks
import cg_simpleItems
import cg_brassTime
import cg_crosshairY
import cg_crosshairX
import cg_crosshairHealth
import cg_crosshairSize
import cg_drawWeaponSelect
import cg_drawRewards
import cg_drawCrosshairNames
import cg_drawCrosshair
import cg_drawSpeed
import cg_drawAttacker
import cg_drawAmmoWarning
import cg_drawIcons
import cg_draw3dIcons
import cg_drawSnapshot
import cg_drawFPS
import cg_drawTimer
import cg_drawStatus
import cg_draw2D
import cg_gibs
import cg_shadows
import cg_viewsize
import cg_fov
import cg_zoomFov
import cg_drawGun
import cg_autoswitch
import cg_ignore
import cg_markPolys
import cg_items
import cg_weapons
import cg_entities
import cg
import cgs
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
LABELV $244
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $243
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $242
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $241
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $240
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $239
byte 1 115
byte 1 101
byte 1 116
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 112
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $238
byte 1 97
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $237
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $236
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $235
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $234
byte 1 110
byte 1 111
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $233
byte 1 110
byte 1 111
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $232
byte 1 103
byte 1 111
byte 1 100
byte 1 0
align 1
LABELV $231
byte 1 103
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $230
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $229
byte 1 115
byte 1 97
byte 1 121
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $228
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $227
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $213
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $212
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 85
byte 1 112
byte 1 0
align 1
LABELV $211
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 68
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $210
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 79
byte 1 119
byte 1 110
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $209
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 83
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $208
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 69
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $207
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 82
byte 1 101
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $206
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 70
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $205
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 67
byte 1 97
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $204
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 80
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $203
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 68
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $202
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 79
byte 1 102
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $201
byte 1 100
byte 1 101
byte 1 110
byte 1 121
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $200
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 114
byte 1 109
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $199
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 104
byte 1 117
byte 1 100
byte 1 0
align 1
LABELV $198
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $197
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 95
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $196
byte 1 116
byte 1 99
byte 1 109
byte 1 100
byte 1 0
align 1
LABELV $195
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $194
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 0
align 1
LABELV $193
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $192
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $191
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $190
byte 1 45
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $189
byte 1 43
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $188
byte 1 45
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $187
byte 1 43
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $186
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 112
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $185
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $184
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $183
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $182
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $181
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $180
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $178
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 115
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $161
byte 1 43
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 54
byte 1 59
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 59
byte 1 32
byte 1 45
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 54
byte 1 0
align 1
LABELV $157
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $152
byte 1 43
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 53
byte 1 59
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 59
byte 1 32
byte 1 45
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 53
byte 1 0
align 1
LABELV $147
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $135
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
LABELV $132
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
LABELV $111
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $92
byte 1 40
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 41
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $87
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $86
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
LABELV $84
byte 1 103
byte 1 99
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 0

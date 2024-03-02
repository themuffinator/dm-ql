code
proc CG_TargetCommand_f 20 12
file "..\..\..\..\code\cgame\cg_consolecmds.c"
line 14
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_consolecmds.c -- text commands typed in at the local console, or
;4:// executed by a key binding
;5:
;6:#include "cg_local.h"
;7:extern menuDef_t *menuScoreboard;
;8:
;9:/*
;10:=================
;11:CG_TargetCommand_f
;12:=================
;13:*/
;14:static void CG_TargetCommand_f(void) {
line 18
;15:	int		targetNum;
;16:	char	cmd[4];
;17:
;18:	targetNum = CG_CrosshairPlayer();
ADDRLP4 8
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 19
;19:	if (targetNum == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $82
line 20
;20:		return;
ADDRGP4 $81
JUMPV
LABELV $82
line 23
;21:	}
;22:
;23:	trap_Argv(1, cmd, sizeof(cmd));
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 24
;24:	trap_SendConsoleCommand(va("gc %i %i", targetNum, atoi(cmd)));
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
line 25
;25:}
LABELV $81
endproc CG_TargetCommand_f 20 12
proc CG_SizeUp_f 4 8
line 36
;26:
;27:
;28:
;29:/*
;30:=================
;31:CG_SizeUp_f
;32:
;33:Keybinding command
;34:=================
;35:*/
;36:static void CG_SizeUp_f(void) {
line 37
;37:	trap_Cvar_Set("cg_viewsize", va("%i", (int)(cg_viewsize.integer + 10)));
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
line 38
;38:}
LABELV $85
endproc CG_SizeUp_f 4 8
proc CG_SizeDown_f 4 8
line 48
;39:
;40:
;41:/*
;42:=================
;43:CG_SizeDown_f
;44:
;45:Keybinding command
;46:=================
;47:*/
;48:static void CG_SizeDown_f(void) {
line 49
;49:	trap_Cvar_Set("cg_viewsize", va("%i", (int)(cg_viewsize.integer - 10)));
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
line 50
;50:}
LABELV $89
endproc CG_SizeDown_f 4 8
proc CG_Viewpos_f 0 20
line 60
;51:
;52:
;53:/*
;54:=============
;55:CG_Viewpos_f
;56:
;57:Debugging command to print the current position
;58:=============
;59:*/
;60:static void CG_Viewpos_f(void) {
line 61
;61:	CG_Printf("(%i %i %i) : %i\n", (int)cg.refdef.vieworg[0],
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
line 64
;62:		(int)cg.refdef.vieworg[1], (int)cg.refdef.vieworg[2],
;63:		(int)cg.refdefViewAngles[YAW]);
;64:}
LABELV $91
endproc CG_Viewpos_f 0 20
proc CG_ScoresDown_f 0 4
line 67
;65:
;66:
;67:static void CG_ScoresDown_f(void) {
line 69
;68:
;69:	CG_BuildSpectatorString();
ADDRGP4 CG_BuildSpectatorString
CALLV
pop
line 71
;70:
;71:	if (cg.scoresRequestTime + 2000 < cg.time && !cg.demoPlayback) {
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
line 74
;72:		// the scores are more than two seconds out of data,
;73:		// so request new ones
;74:		cg.scoresRequestTime = cg.time;
ADDRGP4 cg+110472
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 75
;75:		trap_SendClientCommand("score");
ADDRGP4 $111
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 79
;76:
;77:		// leave the current scores up if they were already
;78:		// displayed, but if this is the first hit, clear them out
;79:		if (!cg.showScores) {
ADDRGP4 cg+115356
INDIRI4
CNSTI4 0
NEI4 $105
line 80
;80:			cg.showScores = qtrue;
ADDRGP4 cg+115356
CNSTI4 1
ASGNI4
line 81
;81:			cg.numScores = 0;
ADDRGP4 cg+110476
CNSTI4 0
ASGNI4
line 82
;82:		}
line 83
;83:	} else {
ADDRGP4 $105
JUMPV
LABELV $104
line 86
;84:		// show the cached contents even if they just pressed if it
;85:		// is within two seconds
;86:		cg.showScores = qtrue;
ADDRGP4 cg+115356
CNSTI4 1
ASGNI4
line 87
;87:	}
LABELV $105
line 89
;88:
;89:	CG_SetScoreCatcher(cg.showScores);
ADDRGP4 cg+115356
INDIRI4
ARGI4
ADDRGP4 CG_SetScoreCatcher
CALLV
pop
line 90
;90:}
LABELV $103
endproc CG_ScoresDown_f 0 4
proc CG_ScoresUp_f 0 4
line 93
;91:
;92:
;93:static void CG_ScoresUp_f(void) {
line 95
;94:
;95:	if (cgs.filterKeyUpEvent) {
ADDRGP4 cgs+148012
INDIRI4
CNSTI4 0
EQI4 $120
line 96
;96:		cgs.filterKeyUpEvent = qfalse;
ADDRGP4 cgs+148012
CNSTI4 0
ASGNI4
line 97
;97:		return;
ADDRGP4 $119
JUMPV
LABELV $120
line 100
;98:	}
;99:
;100:	if (cg.showScores) {
ADDRGP4 cg+115356
INDIRI4
CNSTI4 0
EQI4 $124
line 101
;101:		cg.showScores = qfalse;
ADDRGP4 cg+115356
CNSTI4 0
ASGNI4
line 102
;102:		cg.scoreFadeTime = cg.time;
ADDRGP4 cg+115364
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 103
;103:	}
LABELV $124
line 105
;104:
;105:	CG_SetScoreCatcher(cg.showScores);
ADDRGP4 cg+115356
INDIRI4
ARGI4
ADDRGP4 CG_SetScoreCatcher
CALLV
pop
line 106
;106:}
LABELV $119
endproc CG_ScoresUp_f 0 4
proc CG_LoadHud_f 1028 12
line 112
;107:
;108:
;109:extern menuDef_t *menuScoreboard;
;110:void Menu_Reset(void);			// FIXME: add to right include file
;111:
;112:static void CG_LoadHud_f(void) {
line 115
;113:	char buff[1024];
;114:	const char *hudSet;
;115:	memset(buff, 0, sizeof(buff));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 117
;116:
;117:	String_Init();
ADDRGP4 String_Init
CALLV
pop
line 118
;118:	Menu_Reset();
ADDRGP4 Menu_Reset
CALLV
pop
line 120
;119:
;120:	trap_Cvar_VariableStringBuffer("cg_hudFiles", buff, sizeof(buff));
ADDRGP4 $132
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 121
;121:	hudSet = buff;
ADDRLP4 1024
ADDRLP4 0
ASGNP4
line 122
;122:	if (hudSet[0] == '\0') {
ADDRLP4 1024
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $133
line 123
;123:		hudSet = "ui/hud.txt";
ADDRLP4 1024
ADDRGP4 $135
ASGNP4
line 124
;124:	}
LABELV $133
line 126
;125:
;126:	CG_LoadMenus(hudSet);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 CG_LoadMenus
CALLV
pop
line 127
;127:	menuScoreboard = NULL;
ADDRGP4 menuScoreboard
CNSTP4 0
ASGNP4
line 128
;128:}
LABELV $131
endproc CG_LoadHud_f 1028 12
proc CG_scrollScoresDown_f 0 12
line 131
;129:
;130:
;131:static void CG_scrollScoresDown_f(void) {
line 132
;132:	if (menuScoreboard && cg.scoreBoardShowing) {
ADDRGP4 menuScoreboard
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $137
ADDRGP4 cg+115360
INDIRI4
CNSTI4 0
EQI4 $137
line 133
;133:		Menu_ScrollFeeder(menuScoreboard, FEEDER_SCOREBOARD, qtrue);
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
line 134
;134:		Menu_ScrollFeeder(menuScoreboard, FEEDER_REDTEAM_LIST, qtrue);
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
line 135
;135:		Menu_ScrollFeeder(menuScoreboard, FEEDER_BLUETEAM_LIST, qtrue);
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
line 136
;136:	}
LABELV $137
line 137
;137:}
LABELV $136
endproc CG_scrollScoresDown_f 0 12
proc CG_scrollScoresUp_f 0 12
line 140
;138:
;139:
;140:static void CG_scrollScoresUp_f(void) {
line 141
;141:	if (menuScoreboard && cg.scoreBoardShowing) {
ADDRGP4 menuScoreboard
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $141
ADDRGP4 cg+115360
INDIRI4
CNSTI4 0
EQI4 $141
line 142
;142:		Menu_ScrollFeeder(menuScoreboard, FEEDER_SCOREBOARD, qfalse);
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
line 143
;143:		Menu_ScrollFeeder(menuScoreboard, FEEDER_REDTEAM_LIST, qfalse);
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
line 144
;144:		Menu_ScrollFeeder(menuScoreboard, FEEDER_BLUETEAM_LIST, qfalse);
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
line 145
;145:	}
LABELV $141
line 146
;146:}
LABELV $140
endproc CG_scrollScoresUp_f 0 12
proc CG_TellTarget_f 264 20
line 154
;147:
;148:
;149:/*
;150:==================
;151:CG_TellTarget_f
;152:==================
;153:*/
;154:static void CG_TellTarget_f(void) {
line 159
;155:	int		clientNum;
;156:	char	command[128];
;157:	char	message[128];
;158:
;159:	clientNum = CG_CrosshairPlayer();
ADDRLP4 260
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 160
;160:	if (clientNum == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $145
line 161
;161:		return;
ADDRGP4 $144
JUMPV
LABELV $145
line 164
;162:	}
;163:
;164:	trap_Args(message, sizeof(message));
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 165
;165:	Com_sprintf(command, sizeof(command), "tell %i %s", clientNum, message);
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
line 166
;166:	trap_SendClientCommand(command);
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 167
;167:}
LABELV $144
endproc CG_TellTarget_f 264 20
proc CG_TellAttacker_f 264 20
line 175
;168:
;169:
;170:/*
;171:==================
;172:CG_TellAttacker_f
;173:==================
;174:*/
;175:static void CG_TellAttacker_f(void) {
line 180
;176:	int		clientNum;
;177:	char	command[128];
;178:	char	message[128];
;179:
;180:	clientNum = CG_LastAttacker();
ADDRLP4 260
ADDRGP4 CG_LastAttacker
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 260
INDIRI4
ASGNI4
line 181
;181:	if (clientNum == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $149
line 182
;182:		return;
ADDRGP4 $148
JUMPV
LABELV $149
line 185
;183:	}
;184:
;185:	trap_Args(message, sizeof(message));
ADDRLP4 132
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_Args
CALLV
pop
line 186
;186:	Com_sprintf(command, sizeof(command), "tell %i %s", clientNum, message);
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
line 187
;187:	trap_SendClientCommand(command);
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 188
;188:}
LABELV $148
endproc CG_TellAttacker_f 264 20
proc CG_ConfirmOrder_f 4 8
line 194
;189:
;190:
;191:// ASS U ME's enumeration order as far as task specific orders, OFFENSE is zero, CAMP is last
;192://
;193:
;194:static void CG_ConfirmOrder_f(void) {
line 195
;195:	trap_SendConsoleCommand("+button5; wait; -button5");
ADDRGP4 $152
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 196
;196:	if (cg.time < cgs.acceptOrderTime) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+146652
INDIRI4
GEI4 $153
line 197
;197:		trap_SendClientCommand(va("teamtask %d\n", cgs.acceptTask));
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
line 198
;198:		cgs.acceptOrderTime = 0;
ADDRGP4 cgs+146652
CNSTI4 0
ASGNI4
line 199
;199:	}
LABELV $153
line 200
;200:}
LABELV $151
endproc CG_ConfirmOrder_f 4 8
proc CG_DenyOrder_f 0 4
line 202
;201:
;202:static void CG_DenyOrder_f(void) {
line 203
;203:	trap_SendConsoleCommand("+button6; wait; -button6");
ADDRGP4 $161
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 204
;204:	if (cg.time < cgs.acceptOrderTime) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+146652
INDIRI4
GEI4 $162
line 205
;205:		cgs.acceptOrderTime = 0;
ADDRGP4 cgs+146652
CNSTI4 0
ASGNI4
line 206
;206:	}
LABELV $162
line 207
;207:}
LABELV $160
endproc CG_DenyOrder_f 0 4
proc CG_TaskOffense_f 4 8
line 209
;208:
;209:static void CG_TaskOffense_f(void) {
line 210
;210:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_OFFENSE));
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
line 211
;211:}
LABELV $167
endproc CG_TaskOffense_f 4 8
proc CG_TaskDefense_f 4 8
line 213
;212:
;213:static void CG_TaskDefense_f(void) {
line 214
;214:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_DEFENSE));
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
line 215
;215:}
LABELV $168
endproc CG_TaskDefense_f 4 8
proc CG_TaskPatrol_f 4 8
line 217
;216:
;217:static void CG_TaskPatrol_f(void) {
line 218
;218:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_PATROL));
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
line 219
;219:}
LABELV $169
endproc CG_TaskPatrol_f 4 8
proc CG_TaskCamp_f 4 8
line 221
;220:
;221:static void CG_TaskCamp_f(void) {
line 222
;222:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_CAMP));
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
line 223
;223:}
LABELV $170
endproc CG_TaskCamp_f 4 8
proc CG_TaskFollow_f 4 8
line 225
;224:
;225:static void CG_TaskFollow_f(void) {
line 226
;226:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_FOLLOW));
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
line 227
;227:}
LABELV $171
endproc CG_TaskFollow_f 4 8
proc CG_TaskRetrieve_f 4 8
line 229
;228:
;229:static void CG_TaskRetrieve_f(void) {
line 230
;230:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_RETRIEVE));
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
line 231
;231:}
LABELV $172
endproc CG_TaskRetrieve_f 4 8
proc CG_TaskEscort_f 4 8
line 233
;232:
;233:static void CG_TaskEscort_f(void) {
line 234
;234:	trap_SendClientCommand(va("teamtask %d\n", TEAMTASK_ESCORT));
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
line 235
;235:}
LABELV $173
endproc CG_TaskEscort_f 4 8
proc CG_TaskOwnFlag_f 0 0
line 237
;236:
;237:static void CG_TaskOwnFlag_f(void) {}
LABELV $174
endproc CG_TaskOwnFlag_f 0 0
proc CG_TaskSuicide_f 136 16
line 239
;238:
;239:static void CG_TaskSuicide_f(void) {
line 243
;240:	int		clientNum;
;241:	char	command[128];
;242:
;243:	clientNum = CG_CrosshairPlayer();
ADDRLP4 132
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 132
INDIRI4
ASGNI4
line 244
;244:	if (clientNum == -1) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $176
line 245
;245:		return;
ADDRGP4 $175
JUMPV
LABELV $176
line 248
;246:	}
;247:
;248:	Com_sprintf(command, 128, "tell %i suicide", clientNum);
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
line 249
;249:	trap_SendClientCommand(command);
ADDRLP4 4
ARGP4
ADDRGP4 trap_SendClientCommand
CALLV
pop
line 250
;250:}
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
line 305
;251:
;252:
;253:typedef struct {
;254:	const char *cmd;
;255:	void	(*function)(void);
;256:} consoleCommand_t;
;257:
;258:static consoleCommand_t	commands[] = {
;259:	{ "testgun", CG_TestGun_f },
;260:	{ "testmodel", CG_TestModel_f },
;261:	{ "nextframe", CG_TestModelNextFrame_f },
;262:	{ "prevframe", CG_TestModelPrevFrame_f },
;263:	{ "nextskin", CG_TestModelNextSkin_f },
;264:	{ "prevskin", CG_TestModelPrevSkin_f },
;265:	{ "viewpos", CG_Viewpos_f },
;266:	{ "+scores", CG_ScoresDown_f },
;267:	{ "-scores", CG_ScoresUp_f },
;268:	{ "+zoom", CG_ZoomDown_f },
;269:	{ "-zoom", CG_ZoomUp_f },
;270:	{ "sizeup", CG_SizeUp_f },
;271:	{ "sizedown", CG_SizeDown_f },
;272:	{ "weapnext", CG_NextWeapon_f },
;273:	{ "weapprev", CG_PrevWeapon_f },
;274:	{ "weapon", CG_Weapon_f },
;275:	{ "tcmd", CG_TargetCommand_f },
;276:	{ "tell_target", CG_TellTarget_f },
;277:	{ "tell_attacker", CG_TellAttacker_f },
;278:	{ "loadhud", CG_LoadHud_f },
;279:	{ "confirmOrder", CG_ConfirmOrder_f },
;280:	{ "denyOrder", CG_DenyOrder_f },
;281:	{ "taskOffense", CG_TaskOffense_f },
;282:	{ "taskDefense", CG_TaskDefense_f },
;283:	{ "taskPatrol", CG_TaskPatrol_f },
;284:	{ "taskCamp", CG_TaskCamp_f },
;285:	{ "taskFollow", CG_TaskFollow_f },
;286:	{ "taskRetrieve", CG_TaskRetrieve_f },
;287:	{ "taskEscort", CG_TaskEscort_f },
;288:	{ "taskSuicide", CG_TaskSuicide_f },
;289:	{ "taskOwnFlag", CG_TaskOwnFlag_f },
;290:	{ "scoresDown", CG_scrollScoresDown_f },
;291:	{ "scoresUp", CG_scrollScoresUp_f },
;292:	//{ "camera", CG_Camera_f },
;293:	{ "loaddeferred", CG_LoadDeferredPlayers }
;294:};
;295:
;296:
;297:/*
;298:=================
;299:CG_ConsoleCommand
;300:
;301:The string has been tokenized and can be retrieved with
;302:Cmd_Argc() / Cmd_Argv()
;303:=================
;304:*/
;305:qboolean CG_ConsoleCommand(void) {
line 309
;306:	const char *cmd;
;307:	int		i;
;308:
;309:	cmd = CG_Argv(0);
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
line 311
;310:
;311:	for (i = 0; i < ARRAY_LEN(commands); i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $218
JUMPV
LABELV $215
line 312
;312:		if (!Q_stricmp(cmd, commands[i].cmd)) {
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
line 313
;313:			commands[i].function();
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commands+4
ADDP4
INDIRP4
CALLV
pop
line 314
;314:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $214
JUMPV
LABELV $219
line 316
;315:		}
;316:	}
LABELV $216
line 311
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
line 318
;317:
;318:	return qfalse;
CNSTI4 0
RETI4
LABELV $214
endproc CG_ConsoleCommand 16 8
export CG_InitConsoleCommands
proc CG_InitConsoleCommands 4 4
line 330
;319:}
;320:
;321:
;322:/*
;323:=================
;324:CG_InitConsoleCommands
;325:
;326:Let the client system know about all of our commands
;327:so it can perform tab completion
;328:=================
;329:*/
;330:void CG_InitConsoleCommands(void) {
line 333
;331:	int		i;
;332:
;333:	for (i = 0; i < ARRAY_LEN(commands); i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $226
JUMPV
LABELV $223
line 334
;334:		trap_AddCommand(commands[i].cmd);
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
line 335
;335:	}
LABELV $224
line 333
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
line 341
;336:
;337:	//
;338:	// the game server will interpret these commands, which will be automatically
;339:	// forwarded to the server after they are not recognized locally
;340:	//
;341:	trap_AddCommand("kill");
ADDRGP4 $227
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 342
;342:	trap_AddCommand("say");
ADDRGP4 $228
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 343
;343:	trap_AddCommand("say_team");
ADDRGP4 $229
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 344
;344:	trap_AddCommand("tell");
ADDRGP4 $230
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 345
;345:	trap_AddCommand("give");
ADDRGP4 $231
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 346
;346:	trap_AddCommand("god");
ADDRGP4 $232
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 347
;347:	trap_AddCommand("notarget");
ADDRGP4 $233
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 348
;348:	trap_AddCommand("noclip");
ADDRGP4 $234
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 349
;349:	trap_AddCommand("team");
ADDRGP4 $235
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 350
;350:	trap_AddCommand("follow");
ADDRGP4 $236
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 351
;351:	trap_AddCommand("levelshot");
ADDRGP4 $237
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 352
;352:	trap_AddCommand("addbot");
ADDRGP4 $238
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 353
;353:	trap_AddCommand("setviewpos");
ADDRGP4 $239
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 354
;354:	trap_AddCommand("callvote");
ADDRGP4 $240
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 355
;355:	trap_AddCommand("vote");
ADDRGP4 $241
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 356
;356:	trap_AddCommand("stats");
ADDRGP4 $242
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 357
;357:	trap_AddCommand("teamtask");
ADDRGP4 $243
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 358
;358:	trap_AddCommand("loaddefered");	// spelled wrong, but not changing for demo
ADDRGP4 $244
ARGP4
ADDRGP4 trap_AddCommand
CALLV
pop
line 359
;359:}
LABELV $222
endproc CG_InitConsoleCommands 4 4
import menuScoreboard
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
import CG_ParseArmorTiered
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
import cg_armorTiered
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
import gametypeString
import mRect
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

bss
align 1
LABELV $73
skip 64
export CG_PlaceString
code
proc CG_PlaceString 12 20
file "..\..\..\..\code\cgame\cg_event.c"
line 16
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_event.c -- handle entity events at snapshot or playerstate transitions
;4:
;5:#include "cg_local.h"
;6:
;7://==========================================================================
;8:
;9:/*
;10:===================
;11:CG_PlaceString
;12:
;13:Also called by scoreboard drawing
;14:===================
;15:*/
;16:const char *CG_PlaceString(int rank) {
line 20
;17:	static char	str[64];
;18:	char *s, *t;
;19:
;20:	if (rank & RANK_TIED_FLAG) {
ADDRFP4 0
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $74
line 21
;21:		rank &= ~RANK_TIED_FLAG;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 22
;22:		t = "Tied for ";
ADDRLP4 4
ADDRGP4 $76
ASGNP4
line 23
;23:	} else {
ADDRGP4 $75
JUMPV
LABELV $74
line 24
;24:		t = "";
ADDRLP4 4
ADDRGP4 $77
ASGNP4
line 25
;25:	}
LABELV $75
line 27
;26:
;27:	if (rank == 1) {
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $78
line 28
;28:		s = S_COLOR_BLUE "1st" S_COLOR_WHITE;		// draw in blue
ADDRLP4 0
ADDRGP4 $80
ASGNP4
line 29
;29:	} else if (rank == 2) {
ADDRGP4 $79
JUMPV
LABELV $78
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $81
line 30
;30:		s = S_COLOR_RED "2nd" S_COLOR_WHITE;		// draw in red
ADDRLP4 0
ADDRGP4 $83
ASGNP4
line 31
;31:	} else if (rank == 3) {
ADDRGP4 $82
JUMPV
LABELV $81
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $84
line 32
;32:		s = S_COLOR_YELLOW "3rd" S_COLOR_WHITE;		// draw in yellow
ADDRLP4 0
ADDRGP4 $86
ASGNP4
line 33
;33:	} else if (rank == 11) {
ADDRGP4 $85
JUMPV
LABELV $84
ADDRFP4 0
INDIRI4
CNSTI4 11
NEI4 $87
line 34
;34:		s = "11th";
ADDRLP4 0
ADDRGP4 $89
ASGNP4
line 35
;35:	} else if (rank == 12) {
ADDRGP4 $88
JUMPV
LABELV $87
ADDRFP4 0
INDIRI4
CNSTI4 12
NEI4 $90
line 36
;36:		s = "12th";
ADDRLP4 0
ADDRGP4 $92
ASGNP4
line 37
;37:	} else if (rank == 13) {
ADDRGP4 $91
JUMPV
LABELV $90
ADDRFP4 0
INDIRI4
CNSTI4 13
NEI4 $93
line 38
;38:		s = "13th";
ADDRLP4 0
ADDRGP4 $95
ASGNP4
line 39
;39:	} else if (rank % 10 == 1) {
ADDRGP4 $94
JUMPV
LABELV $93
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 1
NEI4 $96
line 40
;40:		s = va("%ist", rank);
ADDRGP4 $98
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 41
;41:	} else if (rank % 10 == 2) {
ADDRGP4 $97
JUMPV
LABELV $96
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 2
NEI4 $99
line 42
;42:		s = va("%ind", rank);
ADDRGP4 $101
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 43
;43:	} else if (rank % 10 == 3) {
ADDRGP4 $100
JUMPV
LABELV $99
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 3
NEI4 $102
line 44
;44:		s = va("%ird", rank);
ADDRGP4 $104
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 45
;45:	} else {
ADDRGP4 $103
JUMPV
LABELV $102
line 46
;46:		s = va("%ith", rank);
ADDRGP4 $105
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 47
;47:	}
LABELV $103
LABELV $100
LABELV $97
LABELV $94
LABELV $91
LABELV $88
LABELV $85
LABELV $82
LABELV $79
line 49
;48:
;49:	Com_sprintf(str, sizeof(str), "%s%s", t, s);
ADDRGP4 $73
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $106
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 50
;50:	return str;
ADDRGP4 $73
RETP4
LABELV $72
endproc CG_PlaceString 12 20
proc CG_Obituary 136 20
line 59
;51:}
;52:
;53:
;54:/*
;55:=============
;56:CG_Obituary
;57:=============
;58:*/
;59:static void CG_Obituary(entityState_t *ent) {
line 72
;60:	int			mod;
;61:	int			target, attacker;
;62:	char *message;
;63:	char *message2;
;64:	const char *targetInfo;
;65:	const char *attackerInfo;
;66:	char		targetName[32];
;67:	char		attackerName[32];
;68:	gender_t	gender;
;69:	clientInfo_t *ci;
;70:	qboolean	following;
;71:
;72:	target = ent->otherEntityNum;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 73
;73:	attacker = ent->otherEntityNum2;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 74
;74:	mod = ent->eventParm;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 76
;75:
;76:	if (target < 0 || target >= MAX_CLIENTS) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $110
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $108
LABELV $110
line 77
;77:		CG_Error("CG_Obituary: target out of range");
ADDRGP4 $111
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 78
;78:	}
LABELV $108
line 79
;79:	ci = &cgs.clientinfo[target];
ADDRLP4 92
ADDRLP4 4
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+38916
ADDP4
ASGNP4
line 81
;80:
;81:	if (attacker < 0 || attacker >= MAX_CLIENTS) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $115
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $113
LABELV $115
line 82
;82:		attacker = ENTITYNUM_WORLD;
ADDRLP4 0
CNSTI4 1022
ASGNI4
line 83
;83:		attackerInfo = NULL;
ADDRLP4 84
CNSTP4 0
ASGNP4
line 84
;84:	} else {
ADDRGP4 $114
JUMPV
LABELV $113
line 85
;85:		attackerInfo = CG_ConfigString(CS_PLAYERS + attacker);
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 112
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 84
ADDRLP4 112
INDIRP4
ASGNP4
line 86
;86:	}
LABELV $114
line 88
;87:
;88:	targetInfo = CG_ConfigString(CS_PLAYERS + target);
ADDRLP4 4
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 112
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 48
ADDRLP4 112
INDIRP4
ASGNP4
line 89
;89:	if (!targetInfo[0]) {
ADDRLP4 48
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $116
line 90
;90:		return;
ADDRGP4 $107
JUMPV
LABELV $116
line 92
;91:	}
;92:	Q_strncpyz(targetName, Info_ValueForKey(targetInfo, "n"), sizeof(targetName) - 2);
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 $118
ARGP4
ADDRLP4 116
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ARGP4
ADDRLP4 116
INDIRP4
ARGP4
CNSTI4 30
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 93
;93:	strcat(targetName, S_COLOR_WHITE);
ADDRLP4 8
ARGP4
ADDRGP4 $119
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 95
;94:
;95:	following = cg.snap->ps.pm_flags & PMF_FOLLOW;
ADDRLP4 96
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
ASGNI4
line 97
;96:
;97:	message2 = "";
ADDRLP4 88
ADDRGP4 $77
ASGNP4
line 101
;98:
;99:	// check for single client messages
;100:
;101:	switch (mod) {
ADDRLP4 44
INDIRI4
CNSTI4 14
LTI4 $121
ADDRLP4 44
INDIRI4
CNSTI4 22
GTI4 $121
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $139-56
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $139
address $129
address $131
address $133
address $127
address $121
address $125
address $123
address $135
address $137
code
LABELV $123
line 103
;102:	case MOD_SUICIDE:
;103:		message = "suicides";
ADDRLP4 40
ADDRGP4 $124
ASGNP4
line 104
;104:		break;
ADDRGP4 $122
JUMPV
LABELV $125
line 106
;105:	case MOD_FALLING:
;106:		message = "cratered";
ADDRLP4 40
ADDRGP4 $126
ASGNP4
line 107
;107:		break;
ADDRGP4 $122
JUMPV
LABELV $127
line 109
;108:	case MOD_CRUSH:
;109:		message = "was squished";
ADDRLP4 40
ADDRGP4 $128
ASGNP4
line 110
;110:		break;
ADDRGP4 $122
JUMPV
LABELV $129
line 112
;111:	case MOD_WATER:
;112:		message = "sank like a rock";
ADDRLP4 40
ADDRGP4 $130
ASGNP4
line 113
;113:		break;
ADDRGP4 $122
JUMPV
LABELV $131
line 115
;114:	case MOD_SLIME:
;115:		message = "melted";
ADDRLP4 40
ADDRGP4 $132
ASGNP4
line 116
;116:		break;
ADDRGP4 $122
JUMPV
LABELV $133
line 118
;117:	case MOD_LAVA:
;118:		message = "does a back flip into the lava";
ADDRLP4 40
ADDRGP4 $134
ASGNP4
line 119
;119:		break;
ADDRGP4 $122
JUMPV
LABELV $135
line 121
;120:	case MOD_TARGET_LASER:
;121:		message = "saw the light";
ADDRLP4 40
ADDRGP4 $136
ASGNP4
line 122
;122:		break;
ADDRGP4 $122
JUMPV
LABELV $137
line 124
;123:	case MOD_TRIGGER_HURT:
;124:		message = "was in the wrong place";
ADDRLP4 40
ADDRGP4 $138
ASGNP4
line 125
;125:		break;
ADDRGP4 $122
JUMPV
LABELV $121
line 127
;126:	default:
;127:		message = NULL;
ADDRLP4 40
CNSTP4 0
ASGNP4
line 128
;128:		break;
LABELV $122
line 131
;129:	}
;130:
;131:	if (attacker == target) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $141
line 132
;132:		gender = ci->gender;
ADDRLP4 100
ADDRLP4 92
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
ASGNI4
line 133
;133:		switch (mod) {
ADDRLP4 44
INDIRI4
CNSTI4 13
EQI4 $171
ADDRLP4 44
INDIRI4
CNSTI4 13
GTI4 $189
LABELV $188
ADDRLP4 44
INDIRI4
CNSTI4 5
EQI4 $147
ADDRLP4 44
INDIRI4
CNSTI4 7
EQI4 $155
ADDRLP4 44
INDIRI4
CNSTI4 9
EQI4 $163
ADDRGP4 $143
JUMPV
LABELV $189
ADDRLP4 44
INDIRI4
CNSTI4 25
EQI4 $173
ADDRLP4 44
INDIRI4
CNSTI4 26
EQI4 $145
ADDRGP4 $143
JUMPV
LABELV $145
line 135
;134:		case MOD_KAMIKAZE:
;135:			message = "goes out with a bang";
ADDRLP4 40
ADDRGP4 $146
ASGNP4
line 136
;136:			break;
ADDRGP4 $144
JUMPV
LABELV $147
line 138
;137:		case MOD_GRENADE_SPLASH:
;138:			if (gender == GENDER_FEMALE)
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $148
line 139
;139:				message = "tripped on her own grenade";
ADDRLP4 40
ADDRGP4 $150
ASGNP4
ADDRGP4 $144
JUMPV
LABELV $148
line 140
;140:			else if (gender == GENDER_NEUTER)
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $151
line 141
;141:				message = "tripped on its own grenade";
ADDRLP4 40
ADDRGP4 $153
ASGNP4
ADDRGP4 $144
JUMPV
LABELV $151
line 143
;142:			else
;143:				message = "tripped on his own grenade";
ADDRLP4 40
ADDRGP4 $154
ASGNP4
line 144
;144:			break;
ADDRGP4 $144
JUMPV
LABELV $155
line 146
;145:		case MOD_ROCKET_SPLASH:
;146:			if (gender == GENDER_FEMALE)
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $156
line 147
;147:				message = "blew herself up";
ADDRLP4 40
ADDRGP4 $158
ASGNP4
ADDRGP4 $144
JUMPV
LABELV $156
line 148
;148:			else if (gender == GENDER_NEUTER)
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $159
line 149
;149:				message = "blew itself up";
ADDRLP4 40
ADDRGP4 $161
ASGNP4
ADDRGP4 $144
JUMPV
LABELV $159
line 151
;150:			else
;151:				message = "blew himself up";
ADDRLP4 40
ADDRGP4 $162
ASGNP4
line 152
;152:			break;
ADDRGP4 $144
JUMPV
LABELV $163
line 154
;153:		case MOD_PLASMA_SPLASH:
;154:			if (gender == GENDER_FEMALE)
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $164
line 155
;155:				message = "melted herself";
ADDRLP4 40
ADDRGP4 $166
ASGNP4
ADDRGP4 $144
JUMPV
LABELV $164
line 156
;156:			else if (gender == GENDER_NEUTER)
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $167
line 157
;157:				message = "melted itself";
ADDRLP4 40
ADDRGP4 $169
ASGNP4
ADDRGP4 $144
JUMPV
LABELV $167
line 159
;158:			else
;159:				message = "melted himself";
ADDRLP4 40
ADDRGP4 $170
ASGNP4
line 160
;160:			break;
ADDRGP4 $144
JUMPV
LABELV $171
line 162
;161:		case MOD_BFG_SPLASH:
;162:			message = "should have used a smaller gun";
ADDRLP4 40
ADDRGP4 $172
ASGNP4
line 163
;163:			break;
ADDRGP4 $144
JUMPV
LABELV $173
line 165
;164:		case MOD_PROXIMITY_MINE:
;165:			if (gender == GENDER_FEMALE) {
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $174
line 166
;166:				message = "found her prox mine";
ADDRLP4 40
ADDRGP4 $176
ASGNP4
line 167
;167:			} else if (gender == GENDER_NEUTER) {
ADDRGP4 $144
JUMPV
LABELV $174
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $177
line 168
;168:				message = "found its prox mine";
ADDRLP4 40
ADDRGP4 $179
ASGNP4
line 169
;169:			} else {
ADDRGP4 $144
JUMPV
LABELV $177
line 170
;170:				message = "found his prox mine";
ADDRLP4 40
ADDRGP4 $180
ASGNP4
line 171
;171:			}
line 172
;172:			break;
ADDRGP4 $144
JUMPV
LABELV $143
line 174
;173:		default:
;174:			if (gender == GENDER_FEMALE)
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $181
line 175
;175:				message = "killed herself";
ADDRLP4 40
ADDRGP4 $183
ASGNP4
ADDRGP4 $144
JUMPV
LABELV $181
line 176
;176:			else if (gender == GENDER_NEUTER)
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $184
line 177
;177:				message = "killed itself";
ADDRLP4 40
ADDRGP4 $186
ASGNP4
ADDRGP4 $144
JUMPV
LABELV $184
line 179
;178:			else
;179:				message = "killed himself";
ADDRLP4 40
ADDRGP4 $187
ASGNP4
line 180
;180:			break;
LABELV $144
line 182
;181:		}
;182:	}
LABELV $141
line 184
;183:
;184:	if (message) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $190
line 185
;185:		CG_Printf("%s %s.\n", targetName, message);
ADDRGP4 $192
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 187
;186:		// switch to first killer if not following anyone
;187:		if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR && cg_followKiller.integer) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $107
ADDRGP4 cg_followKiller+12
INDIRI4
CNSTI4 0
EQI4 $107
line 188
;188:			if (!cg.followTime && attacker != cg.snap->ps.clientNum && attacker < MAX_CLIENTS) {
ADDRGP4 cg+157008
INDIRI4
CNSTI4 0
NEI4 $107
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $107
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $107
line 189
;189:				cg.followClient = attacker;
ADDRGP4 cg+157012
ADDRLP4 0
INDIRI4
ASGNI4
line 190
;190:				cg.followTime = cg.time;
ADDRGP4 cg+157008
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 191
;191:			}
line 192
;192:		}
line 193
;193:		return;
ADDRGP4 $107
JUMPV
LABELV $190
line 197
;194:	}
;195:
;196:	// check for kill messages from the current clientNum
;197:	if (attacker == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $204
line 200
;198:		char *s;
;199:
;200:		if (cgs.gametype < GT_TEAM) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
GEI4 $207
line 201
;201:			s = va("You fragged %s\n%s place with %i", targetName,
ADDRGP4 cg+36
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 128
ADDRGP4 CG_PlaceString
CALLP4
ASGNP4
ADDRGP4 $210
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRLP4 132
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 124
ADDRLP4 132
INDIRP4
ASGNP4
line 204
;202:				CG_PlaceString(cg.snap->ps.persistant[PERS_RANK] + 1),
;203:				cg.snap->ps.persistant[PERS_SCORE]);
;204:		} else {
ADDRGP4 $208
JUMPV
LABELV $207
line 205
;205:			s = va("You fragged %s", targetName);
ADDRGP4 $213
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 128
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 124
ADDRLP4 128
INDIRP4
ASGNP4
line 206
;206:		}
LABELV $208
line 208
;207:
;208:		CG_CenterPrint(s, SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH);
ADDRLP4 124
INDIRP4
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 211
;209:
;210:		// print the text message as well
;211:	}
LABELV $204
line 214
;212:
;213:	// check for double client messages
;214:	if (!attackerInfo) {
ADDRLP4 84
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $214
line 215
;215:		attacker = ENTITYNUM_WORLD;
ADDRLP4 0
CNSTI4 1022
ASGNI4
line 216
;216:		strcpy(attackerName, "noname");
ADDRLP4 52
ARGP4
ADDRGP4 $216
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 217
;217:	} else {
ADDRGP4 $215
JUMPV
LABELV $214
line 218
;218:		Q_strncpyz(attackerName, Info_ValueForKey(attackerInfo, "n"), sizeof(attackerName) - 2);
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 $118
ARGP4
ADDRLP4 124
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 52
ARGP4
ADDRLP4 124
INDIRP4
ARGP4
CNSTI4 30
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 219
;219:		Q_CleanStr(attackerName);
ADDRLP4 52
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 220
;220:		strcat(attackerName, S_COLOR_WHITE);
ADDRLP4 52
ARGP4
ADDRGP4 $119
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 222
;221:		// check for kill messages about the current clientNum
;222:		if (target == cg.snap->ps.clientNum) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $217
line 223
;223:			Q_strncpyz(cg.killerName, attackerName, sizeof(cg.killerName));
ADDRGP4 cg+115368
ARGP4
ADDRLP4 52
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 225
;224:			// follow killer
;225:			if (following && cg_followKiller.integer) {
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $222
ADDRGP4 cg_followKiller+12
INDIRI4
CNSTI4 0
EQI4 $222
line 226
;226:				if (!cg.followTime && attacker != cg.snap->ps.clientNum && attacker < MAX_CLIENTS) {
ADDRGP4 cg+157008
INDIRI4
CNSTI4 0
NEI4 $225
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $225
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $225
line 227
;227:					cg.followClient = attacker;
ADDRGP4 cg+157012
ADDRLP4 0
INDIRI4
ASGNI4
line 228
;228:					cg.followTime = cg.time + 1100;
ADDRGP4 cg+157008
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1100
ADDI4
ASGNI4
line 229
;229:				}
LABELV $225
line 230
;230:			}
LABELV $222
line 231
;231:		}
LABELV $217
line 232
;232:	}
LABELV $215
line 234
;233:
;234:	if (attacker != ENTITYNUM_WORLD) {
ADDRLP4 0
INDIRI4
CNSTI4 1022
EQI4 $232
line 235
;235:		switch (mod) {
ADDRLP4 44
INDIRI4
CNSTI4 1
LTI4 $234
ADDRLP4 44
INDIRI4
CNSTI4 28
GTI4 $234
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $282-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $282
address $242
address $238
address $240
address $244
address $247
address $250
address $252
address $254
address $257
address $258
address $260
address $262
address $262
address $234
address $234
address $234
address $234
address $278
address $234
address $234
address $234
address $234
address $265
address $267
address $270
address $273
address $276
address $236
code
LABELV $236
line 237
;236:		case MOD_GRAPPLE:
;237:			message = "was caught by";
ADDRLP4 40
ADDRGP4 $237
ASGNP4
line 238
;238:			break;
ADDRGP4 $235
JUMPV
LABELV $238
line 240
;239:		case MOD_GAUNTLET:
;240:			message = "was pummeled by";
ADDRLP4 40
ADDRGP4 $239
ASGNP4
line 241
;241:			break;
ADDRGP4 $235
JUMPV
LABELV $240
line 243
;242:		case MOD_MACHINEGUN:
;243:			message = "was machinegunned by";
ADDRLP4 40
ADDRGP4 $241
ASGNP4
line 244
;244:			break;
ADDRGP4 $235
JUMPV
LABELV $242
line 246
;245:		case MOD_SHOTGUN:
;246:			message = "was gunned down by";
ADDRLP4 40
ADDRGP4 $243
ASGNP4
line 247
;247:			break;
ADDRGP4 $235
JUMPV
LABELV $244
line 249
;248:		case MOD_GRENADE:
;249:			message = "ate";
ADDRLP4 40
ADDRGP4 $245
ASGNP4
line 250
;250:			message2 = "'s grenade";
ADDRLP4 88
ADDRGP4 $246
ASGNP4
line 251
;251:			break;
ADDRGP4 $235
JUMPV
LABELV $247
line 253
;252:		case MOD_GRENADE_SPLASH:
;253:			message = "was shredded by";
ADDRLP4 40
ADDRGP4 $248
ASGNP4
line 254
;254:			message2 = "'s shrapnel";
ADDRLP4 88
ADDRGP4 $249
ASGNP4
line 255
;255:			break;
ADDRGP4 $235
JUMPV
LABELV $250
line 257
;256:		case MOD_ROCKET:
;257:			message = "ate";
ADDRLP4 40
ADDRGP4 $245
ASGNP4
line 258
;258:			message2 = "'s rocket";
ADDRLP4 88
ADDRGP4 $251
ASGNP4
line 259
;259:			break;
ADDRGP4 $235
JUMPV
LABELV $252
line 261
;260:		case MOD_ROCKET_SPLASH:
;261:			message = "almost dodged";
ADDRLP4 40
ADDRGP4 $253
ASGNP4
line 262
;262:			message2 = "'s rocket";
ADDRLP4 88
ADDRGP4 $251
ASGNP4
line 263
;263:			break;
ADDRGP4 $235
JUMPV
LABELV $254
line 265
;264:		case MOD_PLASMA:
;265:			message = "was melted by";
ADDRLP4 40
ADDRGP4 $255
ASGNP4
line 266
;266:			message2 = "'s plasmagun";
ADDRLP4 88
ADDRGP4 $256
ASGNP4
line 267
;267:			break;
ADDRGP4 $235
JUMPV
LABELV $257
line 269
;268:		case MOD_PLASMA_SPLASH:
;269:			message = "was melted by";
ADDRLP4 40
ADDRGP4 $255
ASGNP4
line 270
;270:			message2 = "'s plasmagun";
ADDRLP4 88
ADDRGP4 $256
ASGNP4
line 271
;271:			break;
ADDRGP4 $235
JUMPV
LABELV $258
line 273
;272:		case MOD_RAILGUN:
;273:			message = "was railed by";
ADDRLP4 40
ADDRGP4 $259
ASGNP4
line 274
;274:			break;
ADDRGP4 $235
JUMPV
LABELV $260
line 276
;275:		case MOD_LIGHTNING:
;276:			message = "was electrocuted by";
ADDRLP4 40
ADDRGP4 $261
ASGNP4
line 277
;277:			break;
ADDRGP4 $235
JUMPV
LABELV $262
line 280
;278:		case MOD_BFG:
;279:		case MOD_BFG_SPLASH:
;280:			message = "was blasted by";
ADDRLP4 40
ADDRGP4 $263
ASGNP4
line 281
;281:			message2 = "'s BFG";
ADDRLP4 88
ADDRGP4 $264
ASGNP4
line 282
;282:			break;
ADDRGP4 $235
JUMPV
LABELV $265
line 284
;283:		case MOD_NAIL:
;284:			message = "was nailed by";
ADDRLP4 40
ADDRGP4 $266
ASGNP4
line 285
;285:			break;
ADDRGP4 $235
JUMPV
LABELV $267
line 287
;286:		case MOD_CHAINGUN:
;287:			message = "got lead poisoning from";
ADDRLP4 40
ADDRGP4 $268
ASGNP4
line 288
;288:			message2 = "'s Chaingun";
ADDRLP4 88
ADDRGP4 $269
ASGNP4
line 289
;289:			break;
ADDRGP4 $235
JUMPV
LABELV $270
line 291
;290:		case MOD_PROXIMITY_MINE:
;291:			message = "was too close to";
ADDRLP4 40
ADDRGP4 $271
ASGNP4
line 292
;292:			message2 = "'s Prox Mine";
ADDRLP4 88
ADDRGP4 $272
ASGNP4
line 293
;293:			break;
ADDRGP4 $235
JUMPV
LABELV $273
line 295
;294:		case MOD_KAMIKAZE:
;295:			message = "falls to";
ADDRLP4 40
ADDRGP4 $274
ASGNP4
line 296
;296:			message2 = "'s Kamikaze blast";
ADDRLP4 88
ADDRGP4 $275
ASGNP4
line 297
;297:			break;
ADDRGP4 $235
JUMPV
LABELV $276
line 299
;298:		case MOD_JUICED:
;299:			message = "was juiced by";
ADDRLP4 40
ADDRGP4 $277
ASGNP4
line 300
;300:			break;
ADDRGP4 $235
JUMPV
LABELV $278
line 302
;301:		case MOD_TELEFRAG:
;302:			message = "tried to invade";
ADDRLP4 40
ADDRGP4 $279
ASGNP4
line 303
;303:			message2 = "'s personal space";
ADDRLP4 88
ADDRGP4 $280
ASGNP4
line 304
;304:			break;
ADDRGP4 $235
JUMPV
LABELV $234
line 306
;305:		default:
;306:			message = "was killed by";
ADDRLP4 40
ADDRGP4 $281
ASGNP4
line 307
;307:			break;
LABELV $235
line 310
;308:		}
;309:
;310:		if (message) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $284
line 311
;311:			CG_Printf("%s %s %s%s\n", targetName, message, attackerName, message2);
ADDRGP4 $286
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 52
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 313
;312:			// switch to first killer if not following anyone
;313:			if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR && cg_followKiller.integer) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $107
ADDRGP4 cg_followKiller+12
INDIRI4
CNSTI4 0
EQI4 $107
line 314
;314:				if (!cg.followTime && attacker != cg.snap->ps.clientNum && attacker < MAX_CLIENTS) {
ADDRGP4 cg+157008
INDIRI4
CNSTI4 0
NEI4 $107
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $107
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $107
line 315
;315:					cg.followClient = attacker;
ADDRGP4 cg+157012
ADDRLP4 0
INDIRI4
ASGNI4
line 316
;316:					cg.followTime = cg.time;
ADDRGP4 cg+157008
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 317
;317:				}
line 318
;318:			}
line 319
;319:			return;
ADDRGP4 $107
JUMPV
LABELV $284
line 321
;320:		}
;321:	}
LABELV $232
line 324
;322:
;323:	// we don't know what it was
;324:	CG_Printf("%s "S_COLOR_STRIP"died.\n", targetName);
ADDRGP4 $298
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 325
;325:}
LABELV $107
endproc CG_Obituary 136 20
proc CG_UseItem 32 16
line 334
;326://==========================================================================
;327:
;328:
;329:/*
;330:===============
;331:CG_UseItem
;332:===============
;333:*/
;334:static void CG_UseItem(centity_t *cent) {
line 340
;335:	clientInfo_t *ci;
;336:	int			itemNum, clientNum;
;337:	gitem_t *item;
;338:	entityState_t *es;
;339:
;340:	es = &cent->currentState;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 342
;341:
;342:	itemNum = (es->event & ~EV_EVENT_BITS) - EV_USE_ITEM0;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
CNSTI4 24
SUBI4
ASGNI4
line 343
;343:	if (itemNum < 0 || itemNum > HI_NUM_HOLDABLE) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $302
ADDRLP4 0
INDIRI4
CNSTI4 9
LEI4 $300
LABELV $302
line 344
;344:		itemNum = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 345
;345:	}
LABELV $300
line 348
;346:
;347:	// print a message if the local player
;348:	if (es->number == cg.snap->ps.clientNum) {
ADDRLP4 4
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $303
line 349
;349:		if (!itemNum) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $306
line 350
;350:			CG_CenterPrint("No item to use", SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH);
ADDRGP4 $308
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 351
;351:		} else {
ADDRGP4 $307
JUMPV
LABELV $306
line 352
;352:			item = BG_FindItemForHoldable(itemNum);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 BG_FindItemForHoldable
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 24
INDIRP4
ASGNP4
line 353
;353:			CG_CenterPrint(va("Use %s", item->pickup_name), SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH);
ADDRGP4 $309
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 28
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
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 354
;354:		}
LABELV $307
line 355
;355:	}
LABELV $303
line 357
;356:
;357:	switch (itemNum) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $310
ADDRLP4 0
INDIRI4
CNSTI4 5
GTI4 $310
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $328
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $328
address $312
address $311
address $316
address $311
address $311
address $325
code
LABELV $310
LABELV $312
line 360
;358:	default:
;359:	case HI_NONE:
;360:		trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.useNothingSound);
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+146664+632
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 361
;361:		break;
ADDRGP4 $311
JUMPV
line 364
;362:
;363:	case HI_TELEPORTER:
;364:		break;
LABELV $316
line 367
;365:
;366:	case HI_MEDKIT:
;367:		clientNum = cent->currentState.clientNum;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 368
;368:		if (clientNum >= 0 && clientNum < MAX_CLIENTS) {
ADDRLP4 28
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $317
ADDRLP4 28
INDIRI4
CNSTI4 64
GEI4 $317
line 369
;369:			ci = &cgs.clientinfo[clientNum];
ADDRLP4 16
ADDRLP4 12
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+38916
ADDP4
ASGNP4
line 370
;370:			ci->medkitUsageTime = cg.time;
ADDRLP4 16
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 371
;371:		}
LABELV $317
line 372
;372:		trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.medkitSound);
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+146664+1048
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 373
;373:		break;
ADDRGP4 $311
JUMPV
line 376
;374:
;375:	case HI_KAMIKAZE:
;376:		break;
line 379
;377:
;378:	case HI_PORTAL:
;379:		break;
LABELV $325
line 382
;380:
;381:	case HI_INVULNERABILITY:
;382:		trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.useInvulnerabilitySound);
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+146664+828
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 383
;383:		break;
LABELV $311
line 385
;384:	}
;385:}
LABELV $299
endproc CG_UseItem 32 16
data
align 4
LABELV $330
byte 4 -1
code
proc CG_ItemPickup 4 0
line 395
;386:
;387:
;388:/*
;389:================
;390:CG_ItemPickup
;391:
;392:A new item was picked up this frame
;393:================
;394:*/
;395:static void CG_ItemPickup(int itemNum) {
line 398
;396:	static int oldItem = -1;
;397:
;398:	cg.itemPickup = itemNum;
ADDRGP4 cg+125764
ADDRFP4 0
INDIRI4
ASGNI4
line 399
;399:	cg.itemPickupTime = cg.time;
ADDRGP4 cg+125772
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 400
;400:	cg.itemPickupBlendTime = cg.time;
ADDRGP4 cg+125776
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 402
;401:
;402:	if (oldItem != itemNum)
ADDRGP4 $330
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $336
line 403
;403:		cg.itemPickupCount = 1;
ADDRGP4 cg+125768
CNSTI4 1
ASGNI4
ADDRGP4 $337
JUMPV
LABELV $336
line 405
;404:	else
;405:		cg.itemPickupCount++;
ADDRLP4 0
ADDRGP4 cg+125768
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $337
line 407
;406:
;407:	oldItem = itemNum;
ADDRGP4 $330
ADDRFP4 0
INDIRI4
ASGNI4
line 410
;408:
;409:	// see if it should be the grabbed weapon
;410:	if (bg_itemlist[itemNum].giType == IT_WEAPON) {
ADDRFP4 0
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $340
line 412
;411:		// select it immediately
;412:		if (cg_autoswitch.integer && bg_itemlist[itemNum].giTag != WP_MACHINEGUN) {
ADDRGP4 cg_autoswitch+12
INDIRI4
CNSTI4 0
EQI4 $343
ADDRFP4 0
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 2
EQI4 $343
line 413
;413:			cg.weaponSelectTime = cg.time;
ADDRGP4 cg+125780
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 414
;414:			cg.weaponSelect = bg_itemlist[itemNum].giTag;
ADDRGP4 cg+108956
ADDRFP4 0
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
ASGNI4
line 415
;415:		}
LABELV $343
line 416
;416:	}
LABELV $340
line 418
;417:
;418:}
LABELV $329
endproc CG_ItemPickup 4 0
export CG_WaterLevel
proc CG_WaterLevel 52 8
line 428
;419:
;420:
;421:/*
;422:================
;423:CG_WaterLevel
;424:
;425:Returns waterlevel for entity origin
;426:================
;427:*/
;428:int CG_WaterLevel(centity_t *cent) {
line 433
;429:	vec3_t point;
;430:	int contents, sample1, sample2, anim, waterlevel;
;431:	int viewheight;
;432:
;433:	anim = cent->currentState.legsAnim & ~ANIM_TOGGLEBIT;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 435
;434:
;435:	if (anim == LEGS_WALKCR || anim == LEGS_IDLECR) {
ADDRLP4 16
INDIRI4
CNSTI4 13
EQI4 $354
ADDRLP4 16
INDIRI4
CNSTI4 23
NEI4 $352
LABELV $354
line 436
;436:		viewheight = CROUCH_VIEWHEIGHT;
ADDRLP4 24
CNSTI4 12
ASGNI4
line 437
;437:	} else {
ADDRGP4 $353
JUMPV
LABELV $352
line 438
;438:		viewheight = DEFAULT_VIEWHEIGHT;
ADDRLP4 24
CNSTI4 26
ASGNI4
line 439
;439:	}
LABELV $353
line 444
;440:
;441:	//
;442:	// get waterlevel, accounting for ducking
;443:	//
;444:	waterlevel = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 446
;445:
;446:	point[0] = cent->lerpOrigin[0];
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRF4
ASGNF4
line 447
;447:	point[1] = cent->lerpOrigin[1];
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
INDIRF4
ASGNF4
line 448
;448:	point[2] = cent->lerpOrigin[2] + MINS_Z + 1;
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 449
;449:	contents = CG_PointContents(point, -1);
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 40
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 40
INDIRI4
ASGNI4
line 451
;450:
;451:	if (contents & MASK_WATER) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $357
line 452
;452:		sample2 = viewheight - MINS_Z;
ADDRLP4 28
ADDRLP4 24
INDIRI4
CNSTI4 -24
SUBI4
ASGNI4
line 453
;453:		sample1 = sample2 / 2;
ADDRLP4 32
ADDRLP4 28
INDIRI4
CNSTI4 2
DIVI4
ASGNI4
line 454
;454:		waterlevel = 1;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 455
;455:		point[2] = cent->lerpOrigin[2] + MINS_Z + sample1;
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
ADDRLP4 32
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 456
;456:		contents = CG_PointContents(point, -1);
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 44
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 44
INDIRI4
ASGNI4
line 458
;457:
;458:		if (contents & MASK_WATER) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $360
line 459
;459:			waterlevel = 2;
ADDRLP4 20
CNSTI4 2
ASGNI4
line 460
;460:			point[2] = cent->lerpOrigin[2] + MINS_Z + sample2;
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 724
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
ADDRLP4 28
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 461
;461:			contents = CG_PointContents(point, -1);
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 48
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 48
INDIRI4
ASGNI4
line 463
;462:
;463:			if (contents & MASK_WATER) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $363
line 464
;464:				waterlevel = 3;
ADDRLP4 20
CNSTI4 3
ASGNI4
line 465
;465:			}
LABELV $363
line 466
;466:		}
LABELV $360
line 467
;467:	}
LABELV $357
line 469
;468:
;469:	return waterlevel;
ADDRLP4 20
INDIRI4
RETI4
LABELV $351
endproc CG_WaterLevel 52 8
export CG_PainEvent
proc CG_PainEvent 16 16
line 479
;470:}
;471:
;472:/*
;473:================
;474:CG_PainEvent
;475:
;476:Also called by playerstate transition
;477:================
;478:*/
;479:void CG_PainEvent(centity_t *cent, int health) {
line 483
;480:	const char *snd;
;481:
;482:	// don't do more than two pain sounds a second
;483:	if (cg.time - cent->pe.painTime < 500) {
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
SUBI4
CNSTI4 500
GEI4 $366
line 484
;484:		cent->pe.painIgnore = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 0
ASGNI4
line 485
;485:		return;
ADDRGP4 $365
JUMPV
LABELV $366
line 488
;486:	}
;487:
;488:	if (cent->pe.painIgnore) {
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
INDIRI4
CNSTI4 0
EQI4 $369
line 489
;489:		cent->pe.painIgnore = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 0
ASGNI4
line 490
;490:		return;
ADDRGP4 $365
JUMPV
LABELV $369
line 493
;491:	}
;492:
;493:	if (health < 25) {
ADDRFP4 4
INDIRI4
CNSTI4 25
GEI4 $371
line 494
;494:		snd = "*pain25_1.wav";
ADDRLP4 0
ADDRGP4 $373
ASGNP4
line 495
;495:	} else if (health < 50) {
ADDRGP4 $372
JUMPV
LABELV $371
ADDRFP4 4
INDIRI4
CNSTI4 50
GEI4 $374
line 496
;496:		snd = "*pain50_1.wav";
ADDRLP4 0
ADDRGP4 $376
ASGNP4
line 497
;497:	} else if (health < 75) {
ADDRGP4 $375
JUMPV
LABELV $374
ADDRFP4 4
INDIRI4
CNSTI4 75
GEI4 $377
line 498
;498:		snd = "*pain75_1.wav";
ADDRLP4 0
ADDRGP4 $379
ASGNP4
line 499
;499:	} else {
ADDRGP4 $378
JUMPV
LABELV $377
line 500
;500:		snd = "*pain100_1.wav";
ADDRLP4 0
ADDRGP4 $380
ASGNP4
line 501
;501:	}
LABELV $378
LABELV $375
LABELV $372
line 504
;502:
;503:	// play a gurp sound instead of a normal pain sound
;504:	if (CG_WaterLevel(cent) == 3) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 CG_WaterLevel
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 3
NEI4 $381
line 505
;505:		if (rand() & 1) {
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $383
line 506
;506:			trap_S_StartSound(NULL, cent->currentState.number, CHAN_VOICE, CG_CustomSound(cent->currentState.number, "sound/player/gurp1.wav"));
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $385
ARGP4
ADDRLP4 12
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 507
;507:		} else {
ADDRGP4 $382
JUMPV
LABELV $383
line 508
;508:			trap_S_StartSound(NULL, cent->currentState.number, CHAN_VOICE, CG_CustomSound(cent->currentState.number, "sound/player/gurp2.wav"));
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $386
ARGP4
ADDRLP4 12
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 509
;509:		}
line 510
;510:	} else {
ADDRGP4 $382
JUMPV
LABELV $381
line 511
;511:		trap_S_StartSound(NULL, cent->currentState.number, CHAN_VOICE, CG_CustomSound(cent->currentState.number, snd));
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 512
;512:	}
LABELV $382
line 515
;513:
;514:	// save pain time for programitic twitch animation
;515:	cent->pe.painTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 516
;516:	cent->pe.painDirection ^= 1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 608
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 517
;517:}
LABELV $365
endproc CG_PainEvent 16 16
data
align 4
LABELV $494
byte 4 0
byte 4 0
byte 4 1065353216
export CG_EntityEvent
code
proc CG_EntityEvent 124 48
line 529
;518:
;519:
;520:
;521:/*
;522:==============
;523:CG_EntityEvent
;524:
;525:An entity has an event value
;526:also called by CG_CheckPlayerstateEvents
;527:==============
;528:*/
;529:void CG_EntityEvent(centity_t *cent, vec3_t position, int entityNum) {
line 540
;530:	entityState_t *es;
;531:	entity_event_t	event;
;532:	vec3_t			dir;
;533:	const char *s;
;534:	int				clientNum;
;535:	clientInfo_t *ci;
;536:	vec3_t			vec;
;537:	float			fovOffset;
;538:	centity_t *ce;
;539:
;540:	es = &cent->currentState;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 541
;541:	event = es->event & ~EV_EVENT_BITS;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
ASGNI4
line 543
;542:
;543:	if ((unsigned)event >= EV_MAX) {
ADDRLP4 4
INDIRI4
CVIU4 4
CNSTU4 83
LTU4 $389
line 544
;544:		CG_Error("Unknown event: %i", event);
ADDRGP4 $391
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 545
;545:		return;
ADDRGP4 $388
JUMPV
LABELV $389
line 548
;546:	}
;547:
;548:	if (cg_debugEvents.integer) {
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $392
line 549
;549:		CG_Printf("ent:%3i  event:%3i %s", es->number, event, eventnames[event]);
ADDRGP4 $395
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 eventnames
ADDP4
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 550
;550:	}
LABELV $392
line 552
;551:
;552:	if (!event) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $396
line 553
;553:		return;
ADDRGP4 $388
JUMPV
LABELV $396
line 556
;554:	}
;555:
;556:	clientNum = es->clientNum;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 557
;557:	if ((unsigned)clientNum >= MAX_CLIENTS) {
ADDRLP4 8
INDIRI4
CVIU4 4
CNSTU4 64
LTU4 $398
line 558
;558:		clientNum = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 559
;559:	}
LABELV $398
line 560
;560:	ci = &cgs.clientinfo[clientNum];
ADDRLP4 12
ADDRLP4 8
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+38916
ADDP4
ASGNP4
line 562
;561:
;562:	switch (event) {
ADDRLP4 52
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 1
LTI4 $401
ADDRLP4 52
INDIRI4
CNSTI4 76
GTI4 $401
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $869-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $869
address $404
address $410
address $417
address $424
address $431
address $467
address $467
address $467
address $467
address $438
address $448
address $457
address $493
address $501
address $507
address $510
address $513
address $516
address $518
address $556
address $573
address $577
address $580
address $581
address $581
address $581
address $581
address $581
address $581
address $581
address $581
address $581
address $581
address $581
address $581
address $581
address $581
address $581
address $581
address $591
address $588
address $582
address $585
address $595
address $690
address $695
address $702
address $688
address $687
address $623
address $624
address $625
address $626
address $689
address $401
address $825
address $829
address $829
address $829
address $834
address $835
address $844
address $853
address $862
address $622
address $602
address $613
address $616
address $617
address $618
address $619
address $620
address $621
address $868
address $867
address $505
code
LABELV $404
line 567
;563:		//
;564:		// movement generated events
;565:		//
;566:	case EV_FOOTSTEP:
;567:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $402
line 568
;568:			trap_S_StartSound(NULL, es->number, CHAN_BODY,
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 60
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 cgs+146664+640
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 570
;569:				cgs.media.footsteps[ci->footsteps][rand() & 3]);
;570:		}
line 571
;571:		break;
ADDRGP4 $402
JUMPV
LABELV $410
line 574
;572:
;573:	case EV_FOOTSTEP_METAL:
;574:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $402
line 575
;575:			trap_S_StartSound(NULL, es->number, CHAN_BODY,
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 60
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+146664+640+80
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 577
;576:				cgs.media.footsteps[FOOTSTEP_METAL][rand() & 3]);
;577:		}
line 578
;578:		break;
ADDRGP4 $402
JUMPV
LABELV $417
line 581
;579:
;580:	case EV_FOOTSPLASH:
;581:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $402
line 582
;582:			trap_S_StartSound(NULL, es->number, CHAN_BODY,
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 60
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+146664+640+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 584
;583:				cgs.media.footsteps[FOOTSTEP_SPLASH][rand() & 3]);
;584:		}
line 585
;585:		break;
ADDRGP4 $402
JUMPV
LABELV $424
line 588
;586:
;587:	case EV_FOOTWADE:
;588:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $402
line 589
;589:			trap_S_StartSound(NULL, es->number, CHAN_BODY,
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 60
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+146664+640+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 591
;590:				cgs.media.footsteps[FOOTSTEP_SPLASH][rand() & 3]);
;591:		}
line 592
;592:		break;
ADDRGP4 $402
JUMPV
LABELV $431
line 595
;593:
;594:	case EV_SWIM:
;595:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $402
line 596
;596:			trap_S_StartSound(NULL, es->number, CHAN_BODY,
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRLP4 60
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+146664+640+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 598
;597:				cgs.media.footsteps[FOOTSTEP_SPLASH][rand() & 3]);
;598:		}
line 599
;599:		break;
ADDRGP4 $402
JUMPV
LABELV $438
line 602
;600:
;601:	case EV_FALL_SHORT:
;602:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.landSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+908
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 603
;603:		if (clientNum == cg.predictedPlayerState.clientNum) {
ADDRLP4 8
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $402
line 605
;604:			// smooth landing z changes
;605:			cg.landChange = -8;
ADDRGP4 cg+108948
CNSTF4 3238002688
ASGNF4
line 606
;606:			cg.landTime = cg.time;
ADDRGP4 cg+108952
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 607
;607:		}
line 608
;608:		break;
ADDRGP4 $402
JUMPV
LABELV $448
line 612
;609:
;610:	case EV_FALL_MEDIUM:
;611:		// use normal pain sound
;612:		trap_S_StartSound(NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, "*pain100_1.wav"));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $380
ARGP4
ADDRLP4 60
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 613
;613:		cent->pe.painIgnore = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 1
ASGNI4
line 614
;614:		cent->pe.painTime = cg.time;	// don't play a pain sound right after this
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 615
;615:		if (clientNum == cg.predictedPlayerState.clientNum) {
ADDRLP4 8
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $402
line 617
;616:			// smooth landing z changes
;617:			cg.landChange = -16;
ADDRGP4 cg+108948
CNSTF4 3246391296
ASGNF4
line 618
;618:			cg.landTime = cg.time;
ADDRGP4 cg+108952
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 619
;619:		}
line 620
;620:		break;
ADDRGP4 $402
JUMPV
LABELV $457
line 623
;621:
;622:	case EV_FALL_FAR:
;623:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, CG_CustomSound(es->number, "*fall1.wav"));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $458
ARGP4
ADDRLP4 64
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 624
;624:		cent->pe.painIgnore = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 1
ASGNI4
line 625
;625:		cent->pe.painTime = cg.time;	// don't play a pain sound right after this
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 626
;626:		if (clientNum == cg.predictedPlayerState.clientNum) {
ADDRLP4 8
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $402
line 628
;627:			// smooth landing z changes
;628:			cg.landChange = -24;
ADDRGP4 cg+108948
CNSTF4 3250585600
ASGNF4
line 629
;629:			cg.landTime = cg.time;
ADDRGP4 cg+108952
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 630
;630:		}
line 631
;631:		break;
ADDRGP4 $402
JUMPV
LABELV $467
line 637
;632:
;633:	case EV_STEP_4:
;634:	case EV_STEP_8:
;635:	case EV_STEP_12:
;636:	case EV_STEP_16:		// smooth out step up transitions
;637:	{
line 642
;638:		float	oldStep;
;639:		int		delta;
;640:		int		step;
;641:
;642:		if (clientNum != cg.predictedPlayerState.clientNum) {
ADDRLP4 8
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
EQI4 $468
line 643
;643:			break;
ADDRGP4 $402
JUMPV
LABELV $468
line 646
;644:		}
;645:		// if we are interpolating, we don't need to smooth steps
;646:		if (cg.demoPlayback || (cg.snap->ps.pm_flags & PMF_FOLLOW) ||
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
NEI4 $480
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $480
ADDRGP4 cg_nopredict+12
INDIRI4
CNSTI4 0
NEI4 $480
ADDRGP4 cgs+147920
INDIRI4
CNSTI4 0
EQI4 $472
LABELV $480
line 647
;647:			cg_nopredict.integer || cgs.synchronousClients) {
line 648
;648:			break;
ADDRGP4 $402
JUMPV
LABELV $472
line 651
;649:		}
;650:		// check for stepping up before a previous step is completed
;651:		delta = cg.time - cg.stepTime;
ADDRLP4 68
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+108936
INDIRI4
SUBI4
ASGNI4
line 652
;652:		if (delta < STEP_TIME) {
ADDRLP4 68
INDIRI4
CNSTI4 200
GEI4 $483
line 653
;653:			oldStep = cg.stepChange * (STEP_TIME - delta) / STEP_TIME;
ADDRLP4 72
ADDRGP4 cg+108932
INDIRF4
CNSTI4 200
ADDRLP4 68
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1000593162
MULF4
ASGNF4
line 654
;654:		} else {
ADDRGP4 $484
JUMPV
LABELV $483
line 655
;655:			oldStep = 0;
ADDRLP4 72
CNSTF4 0
ASGNF4
line 656
;656:		}
LABELV $484
line 659
;657:
;658:		// add this amount
;659:		step = 4 * (event - EV_STEP_4 + 1);
ADDRLP4 76
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 24
SUBI4
CNSTI4 4
ADDI4
ASGNI4
line 660
;660:		cg.stepChange = oldStep + step;
ADDRGP4 cg+108932
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 661
;661:		if (cg.stepChange > MAX_STEP_CHANGE) {
ADDRGP4 cg+108932
INDIRF4
CNSTF4 1107296256
LEF4 $487
line 662
;662:			cg.stepChange = MAX_STEP_CHANGE;
ADDRGP4 cg+108932
CNSTF4 1107296256
ASGNF4
line 663
;663:		}
LABELV $487
line 664
;664:		cg.stepTime = cg.time;
ADDRGP4 cg+108936
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 665
;665:		break;
ADDRGP4 $402
JUMPV
LABELV $493
line 670
;666:	}
;667:
;668:	case EV_JUMP_PAD:
;669:		//		CG_Printf( "EV_JUMP_PAD w/effect #%i\n", es->eventParm );
;670:	{
line 671
;671:		vec3_t			up = { 0, 0, 1 };
ADDRLP4 68
ADDRGP4 $494
INDIRB
ASGNB 12
line 674
;672:
;673:
;674:		CG_SmokePuff(cent->lerpOrigin, up,
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 68
ARGP4
CNSTF4 1107296256
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1051260355
ARGF4
CNSTF4 1148846080
ARGF4
ADDRGP4 cg+107604
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cgs+146664+308
INDIRI4
ARGI4
ADDRGP4 CG_SmokePuff
CALLP4
pop
line 681
;675:			32,
;676:			1, 1, 1, 0.33f,
;677:			1000,
;678:			cg.time, 0,
;679:			LEF_PUFF_DONT_SCALE,
;680:			cgs.media.smokePuffShader);
;681:	}
line 684
;682:
;683:	// boing sound at origin, jump sound on player
;684:	trap_S_StartSound(cent->lerpOrigin, -1, CHAN_VOICE, cgs.media.jumpPadSound);
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 cgs+146664+912
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 685
;685:	trap_S_StartSound(NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, "*jump1.wav"));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $500
ARGP4
ADDRLP4 68
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 68
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 686
;686:	break;
ADDRGP4 $402
JUMPV
LABELV $501
line 690
;687:
;688:	case EV_JUMP:
;689:		// pain event with fast sequential jump just creates sound distortion
;690:		if (cg.time - cent->pe.painTime > 50)
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
SUBI4
CNSTI4 50
LEI4 $402
line 691
;691:			trap_S_StartSound(NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, "*jump1.wav"));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $500
ARGP4
ADDRLP4 72
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 692
;692:		break;
ADDRGP4 $402
JUMPV
LABELV $505
line 695
;693:
;694:	case EV_TAUNT:
;695:		trap_S_StartSound(NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, "*taunt.wav"));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $506
ARGP4
ADDRLP4 76
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 696
;696:		break;
ADDRGP4 $402
JUMPV
LABELV $507
line 699
;697:
;698:	case EV_WATER_TOUCH:
;699:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.watrInSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1032
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 700
;700:		break;
ADDRGP4 $402
JUMPV
LABELV $510
line 703
;701:
;702:	case EV_WATER_LEAVE:
;703:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.watrOutSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1036
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 704
;704:		break;
ADDRGP4 $402
JUMPV
LABELV $513
line 707
;705:
;706:	case EV_WATER_UNDER:
;707:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.watrUnSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1040
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 708
;708:		break;
ADDRGP4 $402
JUMPV
LABELV $516
line 711
;709:
;710:	case EV_WATER_CLEAR:
;711:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, CG_CustomSound(es->number, "*gasp.wav"));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $517
ARGP4
ADDRLP4 80
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 80
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 712
;712:		break;
ADDRGP4 $402
JUMPV
LABELV $518
line 715
;713:
;714:	case EV_ITEM_PICKUP:
;715:	{
line 719
;716:		gitem_t *item;
;717:		int		index;
;718:
;719:		index = es->eventParm;		// player predicted
ADDRLP4 84
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 721
;720:
;721:		if (index < 1 || index >= bg_numItems) {
ADDRLP4 92
ADDRLP4 84
INDIRI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 1
LTI4 $521
ADDRLP4 92
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $519
LABELV $521
line 722
;722:			break;
ADDRGP4 $402
JUMPV
LABELV $519
line 725
;723:		}
;724:
;725:		if (entityNum >= 0) {
ADDRFP4 8
INDIRI4
CNSTI4 0
LTI4 $522
line 727
;726:			// our predicted entity
;727:			ce = cg_entities + entityNum;
ADDRLP4 40
ADDRFP4 8
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 728
;728:			if (ce->delaySpawn > cg.time && ce->delaySpawnPlayed) {
ADDRLP4 96
ADDRLP4 40
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 448
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $523
ADDRLP4 96
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
CNSTI4 0
EQI4 $523
line 729
;729:				break; // delay item pickup
ADDRGP4 $402
JUMPV
line 731
;730:			}
;731:		} else {
LABELV $522
line 732
;732:			ce = NULL;
ADDRLP4 40
CNSTP4 0
ASGNP4
line 733
;733:		}
LABELV $523
line 735
;734:
;735:		item = &bg_itemlist[index];
ADDRLP4 88
ADDRLP4 84
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 739
;736:
;737:		// powerups and team items will have a separate global sound, this one
;738:		// will be played at prediction time
;739:		if (item->giType == IT_POWERUP || item->giType == IT_TEAM) {
ADDRLP4 96
ADDRLP4 88
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
EQI4 $529
ADDRLP4 96
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $527
LABELV $529
line 740
;740:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.n_healthSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1212
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 741
;741:		} else if (item->giType == IT_PERSISTANT_POWERUP) {
ADDRGP4 $528
JUMPV
LABELV $527
ADDRLP4 88
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 7
NEI4 $532
line 742
;742:			switch (item->giTag) {
ADDRLP4 100
ADDRLP4 88
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 10
LTI4 $533
ADDRLP4 100
INDIRI4
CNSTI4 13
GTI4 $533
ADDRLP4 100
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $549-40
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $549
address $537
address $540
address $543
address $546
code
LABELV $537
line 744
;743:			case PW_SCOUT:
;744:				trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.scoutSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1188
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 745
;745:				break;
ADDRGP4 $533
JUMPV
LABELV $540
line 747
;746:			case PW_GUARD:
;747:				trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.guardSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1184
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 748
;748:				break;
ADDRGP4 $533
JUMPV
LABELV $543
line 750
;749:			case PW_DOUBLER:
;750:				trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.doublerSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1180
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 751
;751:				break;
ADDRGP4 $533
JUMPV
LABELV $546
line 753
;752:			case PW_ARMORREGEN:
;753:				trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.ammoregenSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1176
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 754
;754:				break;
line 756
;755:			}
;756:		} else {
ADDRGP4 $533
JUMPV
LABELV $532
line 757
;757:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, trap_S_RegisterSound(item->pickup_sound, qfalse));
ADDRLP4 88
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 100
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 758
;758:		}
LABELV $533
LABELV $528
line 761
;759:
;760:		// show icon and name on status bar
;761:		if (es->number == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $551
line 762
;762:			CG_ItemPickup(index);
ADDRLP4 84
INDIRI4
ARGI4
ADDRGP4 CG_ItemPickup
CALLV
pop
line 763
;763:		}
LABELV $551
line 765
;764:
;765:		if (ce) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $402
line 766
;766:			ce->delaySpawnPlayed = qtrue;
ADDRLP4 40
INDIRP4
CNSTI4 452
ADDP4
CNSTI4 1
ASGNI4
line 767
;767:		}
line 768
;768:	}
line 769
;769:	break;
ADDRGP4 $402
JUMPV
LABELV $556
line 772
;770:
;771:	case EV_GLOBAL_ITEM_PICKUP:
;772:	{
line 776
;773:		gitem_t *item;
;774:		int		index;
;775:
;776:		index = es->eventParm;		// player predicted
ADDRLP4 84
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 778
;777:
;778:		if (index < 1 || index >= bg_numItems) {
ADDRLP4 92
ADDRLP4 84
INDIRI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 1
LTI4 $559
ADDRLP4 92
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $557
LABELV $559
line 779
;779:			break;
ADDRGP4 $402
JUMPV
LABELV $557
line 782
;780:		}
;781:
;782:		if (entityNum >= 0) {
ADDRFP4 8
INDIRI4
CNSTI4 0
LTI4 $560
line 784
;783:			// our predicted entity
;784:			ce = cg_entities + entityNum;
ADDRLP4 40
ADDRFP4 8
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 785
;785:			if (ce->delaySpawn > cg.time && ce->delaySpawnPlayed) {
ADDRLP4 96
ADDRLP4 40
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 448
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $561
ADDRLP4 96
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
CNSTI4 0
EQI4 $561
line 786
;786:				break;
ADDRGP4 $402
JUMPV
line 788
;787:			}
;788:		} else {
LABELV $560
line 789
;789:			ce = NULL;
ADDRLP4 40
CNSTP4 0
ASGNP4
line 790
;790:		}
LABELV $561
line 792
;791:
;792:		item = &bg_itemlist[index];
ADDRLP4 88
ADDRLP4 84
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 794
;793:		// powerup pickups are global
;794:		if (item->pickup_sound) {
ADDRLP4 88
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $565
line 795
;795:			trap_S_StartSound(NULL, cg.snap->ps.clientNum, CHAN_AUTO, trap_S_RegisterSound(item->pickup_sound, qfalse));
ADDRLP4 88
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 96
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 96
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 796
;796:		}
LABELV $565
line 799
;797:
;798:		// show icon and name on status bar
;799:		if (es->number == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $568
line 800
;800:			CG_ItemPickup(index);
ADDRLP4 84
INDIRI4
ARGI4
ADDRGP4 CG_ItemPickup
CALLV
pop
line 801
;801:		}
LABELV $568
line 803
;802:
;803:		if (ce) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $402
line 804
;804:			ce->delaySpawnPlayed = qtrue;
ADDRLP4 40
INDIRP4
CNSTI4 452
ADDP4
CNSTI4 1
ASGNI4
line 805
;805:		}
line 806
;806:	}
line 807
;807:	break;
ADDRGP4 $402
JUMPV
LABELV $573
line 814
;808:
;809:	//
;810:	// weapon events
;811:	//
;812:	case EV_NOAMMO:
;813:		//		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.noAmmoSound );
;814:		if (es->number == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $402
line 815
;815:			CG_OutOfAmmoChange();
ADDRGP4 CG_OutOfAmmoChange
CALLV
pop
line 816
;816:		}
line 817
;817:		break;
ADDRGP4 $402
JUMPV
LABELV $577
line 820
;818:
;819:	case EV_CHANGE_WEAPON:
;820:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.selectSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+628
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 821
;821:		break;
ADDRGP4 $402
JUMPV
LABELV $580
line 824
;822:
;823:	case EV_FIRE_WEAPON:
;824:		CG_FireWeapon(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FireWeapon
CALLV
pop
line 825
;825:		break;
ADDRGP4 $402
JUMPV
LABELV $581
line 843
;826:
;827:	case EV_USE_ITEM0:
;828:	case EV_USE_ITEM1:
;829:	case EV_USE_ITEM2:
;830:	case EV_USE_ITEM3:
;831:	case EV_USE_ITEM4:
;832:	case EV_USE_ITEM5:
;833:	case EV_USE_ITEM6:
;834:	case EV_USE_ITEM7:
;835:	case EV_USE_ITEM8:
;836:	case EV_USE_ITEM9:
;837:	case EV_USE_ITEM10:
;838:	case EV_USE_ITEM11:
;839:	case EV_USE_ITEM12:
;840:	case EV_USE_ITEM13:
;841:	case EV_USE_ITEM14:
;842:	case EV_USE_ITEM15:
;843:		CG_UseItem(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 844
;844:		break;
ADDRGP4 $402
JUMPV
LABELV $582
line 852
;845:
;846:		//=================================================================
;847:
;848:		//
;849:		// other events
;850:		//
;851:	case EV_PLAYER_TELEPORT_IN:
;852:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.teleInSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+888
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 853
;853:		CG_SpawnEffect(position);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_SpawnEffect
CALLV
pop
line 854
;854:		break;
ADDRGP4 $402
JUMPV
LABELV $585
line 857
;855:
;856:	case EV_PLAYER_TELEPORT_OUT:
;857:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.teleOutSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+892
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 858
;858:		CG_SpawnEffect(position);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_SpawnEffect
CALLV
pop
line 859
;859:		break;
ADDRGP4 $402
JUMPV
LABELV $588
line 862
;860:
;861:	case EV_ITEM_POP:
;862:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.respawnSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+900
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 863
;863:		break;
ADDRGP4 $402
JUMPV
LABELV $591
line 866
;864:
;865:	case EV_ITEM_RESPAWN:
;866:		cent->miscTime = cg.time;	// scale up from this
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 867
;867:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.respawnSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+900
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 868
;868:		break;
ADDRGP4 $402
JUMPV
LABELV $595
line 871
;869:
;870:	case EV_GRENADE_BOUNCE:
;871:		if (rand() & 1) {
ADDRLP4 84
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $596
line 872
;872:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.hgrenb1aSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1216
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 873
;873:		} else {
ADDRGP4 $402
JUMPV
LABELV $596
line 874
;874:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.hgrenb2aSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1220
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 875
;875:		}
line 876
;876:		break;
ADDRGP4 $402
JUMPV
LABELV $602
line 879
;877:
;878:	case EV_PROXIMITY_MINE_STICK:
;879:		if (es->eventParm & SURF_FLESH) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $603
line 880
;880:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.wstbimplSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1224
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 881
;881:		} else 	if (es->eventParm & SURF_METALSTEPS) {
ADDRGP4 $402
JUMPV
LABELV $603
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $607
line 882
;882:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.wstbimpmSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1228
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 883
;883:		} else {
ADDRGP4 $402
JUMPV
LABELV $607
line 884
;884:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.wstbimpdSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1232
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 885
;885:		}
line 886
;886:		break;
ADDRGP4 $402
JUMPV
LABELV $613
line 889
;887:
;888:	case EV_PROXIMITY_MINE_TRIGGER:
;889:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.wstbactvSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1236
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 890
;890:		break;
ADDRGP4 $402
JUMPV
LABELV $616
line 893
;891:
;892:	case EV_KAMIKAZE:
;893:		CG_KamikazeEffect(cent->lerpOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 CG_KamikazeEffect
CALLV
pop
line 894
;894:		break;
ADDRGP4 $402
JUMPV
LABELV $617
line 897
;895:
;896:	case EV_OBELISKEXPLODE:
;897:		CG_ObeliskExplode(cent->lerpOrigin, es->eventParm);
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ObeliskExplode
CALLV
pop
line 898
;898:		break;
ADDRGP4 $402
JUMPV
LABELV $618
line 901
;899:
;900:	case EV_OBELISKPAIN:
;901:		CG_ObeliskPain(cent->lerpOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 CG_ObeliskPain
CALLV
pop
line 902
;902:		break;
ADDRGP4 $402
JUMPV
LABELV $619
line 905
;903:
;904:	case EV_INVUL_IMPACT:
;905:		CG_InvulnerabilityImpact(cent->lerpOrigin, cent->currentState.angles);
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 88
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRGP4 CG_InvulnerabilityImpact
CALLV
pop
line 906
;906:		break;
ADDRGP4 $402
JUMPV
LABELV $620
line 909
;907:
;908:	case EV_JUICED:
;909:		CG_InvulnerabilityJuiced(cent->lerpOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 CG_InvulnerabilityJuiced
CALLV
pop
line 910
;910:		break;
ADDRGP4 $402
JUMPV
LABELV $621
line 913
;911:
;912:	case EV_LIGHTNINGBOLT:
;913:		CG_LightningBoltBeam(es->origin2, es->pos.trBase);
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 CG_LightningBoltBeam
CALLV
pop
line 914
;914:		break;
ADDRGP4 $402
JUMPV
LABELV $622
line 917
;915:
;916:	case EV_SCOREPLUM:
;917:		CG_ScorePlum(cent->currentState.otherEntityNum, cent->lerpOrigin, cent->currentState.time);
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 96
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_ScorePlum
CALLV
pop
line 918
;918:		break;
ADDRGP4 $402
JUMPV
LABELV $623
line 924
;919:
;920:		//
;921:		// missile impacts
;922:		//
;923:	case EV_MISSILE_HIT:
;924:		ByteToDir(es->eventParm, dir);
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 925
;925:		CG_MissileHitPlayer(es->weapon, position, dir, es->otherEntityNum);
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_MissileHitPlayer
CALLV
pop
line 926
;926:		break;
ADDRGP4 $402
JUMPV
LABELV $624
line 929
;927:
;928:	case EV_MISSILE_MISS:
;929:		ByteToDir(es->eventParm, dir);
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 930
;930:		CG_MissileHitWall(es->weapon, 0, position, dir, IMPACTSOUND_DEFAULT);
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 931
;931:		break;
ADDRGP4 $402
JUMPV
LABELV $625
line 934
;932:
;933:	case EV_MISSILE_MISS_METAL:
;934:		ByteToDir(es->eventParm, dir);
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 935
;935:		CG_MissileHitWall(es->weapon, 0, position, dir, IMPACTSOUND_METAL);
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 936
;936:		break;
ADDRGP4 $402
JUMPV
LABELV $626
line 939
;937:
;938:	case EV_RAILTRAIL:
;939:		cent->currentState.weapon = WP_RAILGUN;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 7
ASGNI4
line 941
;940:
;941:		if (cent->currentState.clientNum == cg.snap->ps.clientNum && !cg_thirdPerson.integer) {
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $627
ADDRGP4 cg_thirdPerson+12
INDIRI4
CNSTI4 0
NEI4 $627
line 942
;942:			VectorCopy(cg.refdef.vieworg, vec);
ADDRLP4 16
ADDRGP4 cg+109056+24
INDIRB
ASGNB 12
line 943
;943:			fovOffset = -0.2f * (cgs.fov - 90.0f);
ADDRLP4 48
ADDRGP4 cgs+147904
INDIRF4
CNSTF4 1119092736
SUBF4
CNSTF4 3192704205
MULF4
ASGNF4
line 946
;944:
;945:			// 13.5, -5.5, -6.0
;946:			VectorMA(vec, cg_gun_x.value + 13.5f, cg.refdef.viewaxis[0], vec);
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRGP4 cg+109056+36
INDIRF4
ADDRGP4 cg_gun_x+8
INDIRF4
CNSTF4 1096286208
ADDF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 16+4
INDIRF4
ADDRGP4 cg+109056+36+4
INDIRF4
ADDRGP4 cg_gun_x+8
INDIRF4
CNSTF4 1096286208
ADDF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
ADDRGP4 cg+109056+36+8
INDIRF4
ADDRGP4 cg_gun_x+8
INDIRF4
CNSTF4 1096286208
ADDF4
MULF4
ADDF4
ASGNF4
line 947
;947:			VectorMA(vec, cg_gun_y.value - 5.5f, cg.refdef.viewaxis[1], vec);
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRGP4 cg+109056+36+12
INDIRF4
ADDRGP4 cg_gun_y+8
INDIRF4
CNSTF4 1085276160
SUBF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 16+4
INDIRF4
ADDRGP4 cg+109056+36+12+4
INDIRF4
ADDRGP4 cg_gun_y+8
INDIRF4
CNSTF4 1085276160
SUBF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
ADDRGP4 cg+109056+36+12+8
INDIRF4
ADDRGP4 cg_gun_y+8
INDIRF4
CNSTF4 1085276160
SUBF4
MULF4
ADDF4
ASGNF4
line 948
;948:			VectorMA(vec, cg_gun_z.value + fovOffset - 6.0f, cg.refdef.viewaxis[2], vec);
ADDRLP4 104
ADDRLP4 48
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRGP4 cg+109056+36+24
INDIRF4
ADDRGP4 cg_gun_z+8
INDIRF4
ADDRLP4 104
INDIRF4
ADDF4
CNSTF4 1086324736
SUBF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 16+4
INDIRF4
ADDRGP4 cg+109056+36+24+4
INDIRF4
ADDRGP4 cg_gun_z+8
INDIRF4
ADDRLP4 104
INDIRF4
ADDF4
CNSTF4 1086324736
SUBF4
MULF4
ADDF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
ADDRGP4 cg+109056+36+24+8
INDIRF4
ADDRGP4 cg_gun_z+8
INDIRF4
ADDRLP4 48
INDIRF4
ADDF4
CNSTF4 1086324736
SUBF4
MULF4
ADDF4
ASGNF4
line 949
;949:		} else
ADDRGP4 $628
JUMPV
LABELV $627
line 950
;950:			VectorCopy(es->origin2, vec);
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
LABELV $628
line 953
;951:
;952:		// if the end was on a nomark surface, don't make an explosion
;953:		CG_RailTrail(ci, vec, es->pos.trBase);
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRGP4 CG_RailTrail
CALLV
pop
line 955
;954:
;955:		if (es->eventParm != 255) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 255
EQI4 $402
line 956
;956:			ByteToDir(es->eventParm, dir);
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 957
;957:			CG_MissileHitWall(es->weapon, es->clientNum, position, dir, IMPACTSOUND_DEFAULT);
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 CG_MissileHitWall
CALLV
pop
line 958
;958:		}
line 959
;959:		break;
ADDRGP4 $402
JUMPV
LABELV $687
line 962
;960:
;961:	case EV_BULLET_HIT_WALL:
;962:		ByteToDir(es->eventParm, dir);
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRGP4 ByteToDir
CALLV
pop
line 963
;963:		CG_Bullet(es->pos.trBase, es->otherEntityNum, dir, qfalse, ENTITYNUM_WORLD);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1022
ARGI4
ADDRGP4 CG_Bullet
CALLV
pop
line 964
;964:		break;
ADDRGP4 $402
JUMPV
LABELV $688
line 967
;965:
;966:	case EV_BULLET_HIT_FLESH:
;967:		CG_Bullet(es->pos.trBase, es->otherEntityNum, dir, qtrue, es->eventParm);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Bullet
CALLV
pop
line 968
;968:		break;
ADDRGP4 $402
JUMPV
LABELV $689
line 971
;969:
;970:	case EV_SHOTGUN:
;971:		CG_ShotgunFire(es);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_ShotgunFire
CALLV
pop
line 972
;972:		break;
ADDRGP4 $402
JUMPV
LABELV $690
line 975
;973:
;974:	case EV_GENERAL_SOUND:
;975:		if (cgs.gameSounds[es->eventParm]) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+33792
ADDP4
INDIRI4
CNSTI4 0
EQI4 $691
line 976
;976:			trap_S_StartSound(NULL, es->number, CHAN_VOICE, cgs.gameSounds[es->eventParm]);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+33792
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 977
;977:		} else {
ADDRGP4 $402
JUMPV
LABELV $691
line 978
;978:			s = CG_ConfigString(CS_SOUNDS + es->eventParm);
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 112
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 44
ADDRLP4 112
INDIRP4
ASGNP4
line 979
;979:			trap_S_StartSound(NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, s));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 116
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 116
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 980
;980:		}
line 981
;981:		break;
ADDRGP4 $402
JUMPV
LABELV $695
line 984
;982:
;983:	case EV_GLOBAL_SOUND:	// play from the player's head so it never diminishes
;984:		if (cgs.gameSounds[es->eventParm]) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+33792
ADDP4
INDIRI4
CNSTI4 0
EQI4 $696
line 985
;985:			trap_S_StartSound(NULL, cg.snap->ps.clientNum, CHAN_AUTO, cgs.gameSounds[es->eventParm]);
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+33792
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 986
;986:		} else {
ADDRGP4 $402
JUMPV
LABELV $696
line 987
;987:			s = CG_ConfigString(CS_SOUNDS + es->eventParm);
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 112
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 44
ADDRLP4 112
INDIRP4
ASGNP4
line 988
;988:			trap_S_StartSound(NULL, cg.snap->ps.clientNum, CHAN_AUTO, CG_CustomSound(es->number, s));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 116
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 116
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 989
;989:		}
line 990
;990:		break;
ADDRGP4 $402
JUMPV
LABELV $702
line 993
;991:
;992:	case EV_GLOBAL_TEAM_SOUND:	// play from the player's head so it never diminishes
;993:	{
line 994
;994:		switch (es->eventParm) {
ADDRLP4 112
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
LTI4 $402
ADDRLP4 112
INDIRI4
CNSTI4 13
GTI4 $402
ADDRLP4 112
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $824
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $824
address $706
address $714
address $722
address $732
address $742
address $768
address $794
address $800
address $806
address $809
address $812
address $815
address $818
address $821
code
LABELV $706
line 996
;995:		case GTS_RED_CAPTURE: // CTF: red team captured the blue flag, 1FCTF: red team captured the neutral flag
;996:			if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED)
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $707
line 997
;997:				CG_AddBufferedSound(cgs.media.captureYourTeamSound);
ADDRGP4 cgs+146664+1076
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $402
JUMPV
LABELV $707
line 999
;998:			else
;999:				CG_AddBufferedSound(cgs.media.captureOpponentSound);
ADDRGP4 cgs+146664+1080
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1000
;1000:			break;
ADDRGP4 $402
JUMPV
LABELV $714
line 1002
;1001:		case GTS_BLUE_CAPTURE: // CTF: blue team captured the red flag, 1FCTF: blue team captured the neutral flag
;1002:			if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE)
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $715
line 1003
;1003:				CG_AddBufferedSound(cgs.media.captureYourTeamSound);
ADDRGP4 cgs+146664+1076
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $402
JUMPV
LABELV $715
line 1005
;1004:			else
;1005:				CG_AddBufferedSound(cgs.media.captureOpponentSound);
ADDRGP4 cgs+146664+1080
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1006
;1006:			break;
ADDRGP4 $402
JUMPV
LABELV $722
line 1008
;1007:		case GTS_RED_RETURN: // CTF: blue flag returned, 1FCTF: never used
;1008:			if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED)
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $723
line 1009
;1009:				CG_AddBufferedSound(cgs.media.returnYourTeamSound);
ADDRGP4 cgs+146664+1084
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $724
JUMPV
LABELV $723
line 1011
;1010:			else
;1011:				CG_AddBufferedSound(cgs.media.returnOpponentSound);
ADDRGP4 cgs+146664+1088
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
LABELV $724
line 1013
;1012:			//
;1013:			CG_AddBufferedSound(cgs.media.blueFlagReturnedSound);
ADDRGP4 cgs+146664+1104
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1014
;1014:			break;
ADDRGP4 $402
JUMPV
LABELV $732
line 1016
;1015:		case GTS_BLUE_RETURN: // CTF red flag returned, 1FCTF: neutral flag returned
;1016:			if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE)
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $733
line 1017
;1017:				CG_AddBufferedSound(cgs.media.returnYourTeamSound);
ADDRGP4 cgs+146664+1084
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $734
JUMPV
LABELV $733
line 1019
;1018:			else
;1019:				CG_AddBufferedSound(cgs.media.returnOpponentSound);
ADDRGP4 cgs+146664+1088
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
LABELV $734
line 1021
;1020:			//
;1021:			CG_AddBufferedSound(cgs.media.redFlagReturnedSound);
ADDRGP4 cgs+146664+1100
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1022
;1022:			break;
ADDRGP4 $402
JUMPV
LABELV $742
line 1026
;1023:
;1024:		case GTS_RED_TAKEN: // CTF: red team took blue flag, 1FCTF: blue team took the neutral flag
;1025:			// if this player picked up the flag then a sound is played in CG_CheckLocalSounds
;1026:			if (cg.snap->ps.powerups[PW_BLUEFLAG] || cg.snap->ps.powerups[PW_NEUTRALFLAG]) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
NEI4 $747
ADDRGP4 cg+36
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
CNSTI4 0
EQI4 $743
LABELV $747
line 1027
;1027:			} else {
ADDRGP4 $402
JUMPV
LABELV $743
line 1028
;1028:				if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $748
line 1029
;1029:					if (cgs.gametype == GT_1FCTF)
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 6
NEI4 $751
line 1030
;1030:						CG_AddBufferedSound(cgs.media.yourTeamTookTheFlagSound);
ADDRGP4 cgs+146664+1124
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $402
JUMPV
LABELV $751
line 1032
;1031:					else
;1032:						CG_AddBufferedSound(cgs.media.enemyTookYourFlagSound);
ADDRGP4 cgs+146664+1112
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1033
;1033:				} else if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
ADDRGP4 $402
JUMPV
LABELV $748
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $402
line 1034
;1034:					if (cgs.gametype == GT_1FCTF)
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 6
NEI4 $761
line 1035
;1035:						CG_AddBufferedSound(cgs.media.enemyTookTheFlagSound);
ADDRGP4 cgs+146664+1116
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $402
JUMPV
LABELV $761
line 1037
;1036:					else
;1037:						CG_AddBufferedSound(cgs.media.yourTeamTookEnemyFlagSound);
ADDRGP4 cgs+146664+1120
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1038
;1038:				}
line 1039
;1039:			}
line 1040
;1040:			break;
ADDRGP4 $402
JUMPV
LABELV $768
line 1043
;1041:		case GTS_BLUE_TAKEN: // CTF: blue team took the red flag, 1FCTF red team took the neutral flag
;1042:			// if this player picked up the flag then a sound is played in CG_CheckLocalSounds
;1043:			if (cg.snap->ps.powerups[PW_REDFLAG] || cg.snap->ps.powerups[PW_NEUTRALFLAG]) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
NEI4 $773
ADDRGP4 cg+36
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
CNSTI4 0
EQI4 $769
LABELV $773
line 1044
;1044:			} else {
ADDRGP4 $402
JUMPV
LABELV $769
line 1045
;1045:				if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $774
line 1046
;1046:					if (cgs.gametype == GT_1FCTF)
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 6
NEI4 $777
line 1047
;1047:						CG_AddBufferedSound(cgs.media.yourTeamTookTheFlagSound);
ADDRGP4 cgs+146664+1124
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $402
JUMPV
LABELV $777
line 1049
;1048:					else
;1049:						CG_AddBufferedSound(cgs.media.enemyTookYourFlagSound);
ADDRGP4 cgs+146664+1112
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1050
;1050:				} else if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
ADDRGP4 $402
JUMPV
LABELV $774
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $402
line 1051
;1051:					if (cgs.gametype == GT_1FCTF)
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 6
NEI4 $787
line 1052
;1052:						CG_AddBufferedSound(cgs.media.enemyTookTheFlagSound);
ADDRGP4 cgs+146664+1116
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $402
JUMPV
LABELV $787
line 1054
;1053:					else
;1054:						CG_AddBufferedSound(cgs.media.yourTeamTookEnemyFlagSound);
ADDRGP4 cgs+146664+1120
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1055
;1055:				}
line 1056
;1056:			}
line 1057
;1057:			break;
ADDRGP4 $402
JUMPV
LABELV $794
line 1060
;1058:
;1059:		case GTS_REDOBELISK_ATTACKED: // Overload: red obelisk is being attacked
;1060:			if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $402
line 1061
;1061:				CG_AddBufferedSound(cgs.media.yourBaseIsUnderAttackSound);
ADDRGP4 cgs+146664+1132
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1062
;1062:			}
line 1063
;1063:			break;
ADDRGP4 $402
JUMPV
LABELV $800
line 1065
;1064:		case GTS_BLUEOBELISK_ATTACKED: // Overload: blue obelisk is being attacked
;1065:			if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $402
line 1066
;1066:				CG_AddBufferedSound(cgs.media.yourBaseIsUnderAttackSound);
ADDRGP4 cgs+146664+1132
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1067
;1067:			}
line 1068
;1068:			break;
ADDRGP4 $402
JUMPV
LABELV $806
line 1071
;1069:
;1070:		case GTS_REDTEAM_SCORED:
;1071:			CG_AddBufferedSound(cgs.media.redScoredSound);
ADDRGP4 cgs+146664+1056
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1072
;1072:			break;
ADDRGP4 $402
JUMPV
LABELV $809
line 1074
;1073:		case GTS_BLUETEAM_SCORED:
;1074:			CG_AddBufferedSound(cgs.media.blueScoredSound);
ADDRGP4 cgs+146664+1060
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1075
;1075:			break;
ADDRGP4 $402
JUMPV
LABELV $812
line 1077
;1076:		case GTS_REDTEAM_TOOK_LEAD:
;1077:			CG_AddBufferedSound(cgs.media.redLeadsSound);
ADDRGP4 cgs+146664+1064
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1078
;1078:			break;
ADDRGP4 $402
JUMPV
LABELV $815
line 1080
;1079:		case GTS_BLUETEAM_TOOK_LEAD:
;1080:			CG_AddBufferedSound(cgs.media.blueLeadsSound);
ADDRGP4 cgs+146664+1068
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1081
;1081:			break;
ADDRGP4 $402
JUMPV
LABELV $818
line 1083
;1082:		case GTS_TEAMS_ARE_TIED:
;1083:			CG_AddBufferedSound(cgs.media.teamsTiedSound);
ADDRGP4 cgs+146664+1072
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1084
;1084:			break;
ADDRGP4 $402
JUMPV
LABELV $821
line 1086
;1085:		case GTS_KAMIKAZE:
;1086:			trap_S_StartLocalSound(cgs.media.kamikazeFarSound, CHAN_ANNOUNCER);
ADDRGP4 cgs+146664+824
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1087
;1087:			break;
line 1089
;1088:		default:
;1089:			break;
line 1091
;1090:		}
;1091:		break;
ADDRGP4 $402
JUMPV
LABELV $825
line 1097
;1092:	}
;1093:
;1094:	case EV_PAIN:
;1095:		// local player sounds are triggered in CG_CheckLocalSounds,
;1096:		// so ignore events on the player
;1097:		if (cent->currentState.number != cg.snap->ps.clientNum) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $402
line 1098
;1098:			CG_PainEvent(cent, es->eventParm);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_PainEvent
CALLV
pop
line 1099
;1099:		}
line 1100
;1100:		break;
ADDRGP4 $402
JUMPV
LABELV $829
line 1105
;1101:
;1102:	case EV_DEATH1:
;1103:	case EV_DEATH2:
;1104:	case EV_DEATH3:
;1105:		if (CG_WaterLevel(cent) == 3) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 CG_WaterLevel
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 3
NEI4 $830
line 1106
;1106:			trap_S_StartSound(NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, "*drown.wav"));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $832
ARGP4
ADDRLP4 116
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 116
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1107
;1107:		} else {
ADDRGP4 $402
JUMPV
LABELV $830
line 1108
;1108:			trap_S_StartSound(NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, va("*death%i.wav", event - EV_DEATH1 + 1)));
ADDRGP4 $833
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 57
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 116
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 CG_CustomSound
CALLI4
ASGNI4
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 120
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1109
;1109:		}
line 1111
;1110:
;1111:		break;
ADDRGP4 $402
JUMPV
LABELV $834
line 1114
;1112:
;1113:	case EV_OBITUARY:
;1114:		CG_Obituary(es);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Obituary
CALLV
pop
line 1115
;1115:		break;
ADDRGP4 $402
JUMPV
LABELV $835
line 1121
;1116:
;1117:		//
;1118:		// powerup events
;1119:		//
;1120:	case EV_POWERUP_QUAD:
;1121:		if (es->number == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $836
line 1122
;1122:			cg.powerupActive = PW_QUAD;
ADDRGP4 cg+125480
CNSTI4 1
ASGNI4
line 1123
;1123:			cg.powerupTime = cg.time;
ADDRGP4 cg+125484
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1124
;1124:		}
LABELV $836
line 1125
;1125:		trap_S_StartSound(NULL, es->number, CHAN_ITEM, cgs.media.quadSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+146664+620
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1126
;1126:		break;
ADDRGP4 $402
JUMPV
LABELV $844
line 1129
;1127:
;1128:	case EV_POWERUP_BATTLESUIT:
;1129:		if (es->number == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $845
line 1130
;1130:			cg.powerupActive = PW_BATTLESUIT;
ADDRGP4 cg+125480
CNSTI4 2
ASGNI4
line 1131
;1131:			cg.powerupTime = cg.time;
ADDRGP4 cg+125484
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1132
;1132:		}
LABELV $845
line 1133
;1133:		trap_S_StartSound(NULL, es->number, CHAN_ITEM, cgs.media.protectSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+146664+1208
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1134
;1134:		break;
ADDRGP4 $402
JUMPV
LABELV $853
line 1137
;1135:
;1136:	case EV_POWERUP_REGEN:
;1137:		if (es->number == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $854
line 1138
;1138:			cg.powerupActive = PW_REGEN;
ADDRGP4 cg+125480
CNSTI4 5
ASGNI4
line 1139
;1139:			cg.powerupTime = cg.time;
ADDRGP4 cg+125484
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1140
;1140:		}
LABELV $854
line 1141
;1141:		trap_S_StartSound(NULL, es->number, CHAN_ITEM, cgs.media.regenSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+146664+1204
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1142
;1142:		break;
ADDRGP4 $402
JUMPV
LABELV $862
line 1148
;1143:
;1144:	case EV_GIB_PLAYER:
;1145:		// don't play gib sound when using the kamikaze because it interferes
;1146:		// with the kamikaze sound, downside is that the gib sound will also
;1147:		// not be played when someone is gibbed while just carrying the kamikaze
;1148:		if (!(es->eFlags & EF_KAMIKAZE)) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $863
line 1149
;1149:			trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.gibSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+146664+872
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1150
;1150:		}
LABELV $863
line 1151
;1151:		CG_GibPlayer(cent->lerpOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 CG_GibPlayer
CALLV
pop
line 1152
;1152:		break;
ADDRGP4 $402
JUMPV
LABELV $867
line 1155
;1153:
;1154:	case EV_STOPLOOPINGSOUND:
;1155:		trap_S_StopLoopingSound(es->number);
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StopLoopingSound
CALLV
pop
line 1156
;1156:		es->loopSound = 0;
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 1157
;1157:		break;
ADDRGP4 $402
JUMPV
LABELV $868
line 1160
;1158:
;1159:	case EV_DEBUG_LINE:
;1160:		CG_Beam(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Beam
CALLV
pop
line 1161
;1161:		break;
ADDRGP4 $402
JUMPV
LABELV $401
line 1164
;1162:
;1163:	default:
;1164:		CG_Error("Unknown event: %i", event);
ADDRGP4 $391
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1165
;1165:		break;
LABELV $402
line 1167
;1166:	}
;1167:}
LABELV $388
endproc CG_EntityEvent 124 48
export CG_CheckEvents
proc CG_CheckEvents 8 12
line 1176
;1168:
;1169:
;1170:/*
;1171:==============
;1172:CG_CheckEvents
;1173:
;1174:==============
;1175:*/
;1176:void CG_CheckEvents(centity_t *cent) {
line 1178
;1177:	// check for event-only entities
;1178:	if (cent->currentState.eType > ET_EVENTS) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
LEI4 $872
line 1179
;1179:		if (cent->previousEvent) {
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
CNSTI4 0
EQI4 $874
line 1180
;1180:			return;	// already fired
ADDRGP4 $871
JUMPV
LABELV $874
line 1183
;1181:		}
;1182:		// if this is a player event set the entity number of the client entity number
;1183:		if (cent->currentState.eFlags & EF_PLAYER_EVENT) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $876
line 1184
;1184:			cent->currentState.number = cent->currentState.otherEntityNum;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 1185
;1185:		}
LABELV $876
line 1187
;1186:
;1187:		cent->previousEvent = 1;
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
CNSTI4 1
ASGNI4
line 1189
;1188:
;1189:		cent->currentState.event = cent->currentState.eType - ET_EVENTS;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
SUBI4
ASGNI4
line 1190
;1190:	} else {
ADDRGP4 $873
JUMPV
LABELV $872
line 1192
;1191:		// check for events riding with another entity
;1192:		if (cent->currentState.event == cent->previousEvent) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
NEI4 $878
line 1193
;1193:			return;
ADDRGP4 $871
JUMPV
LABELV $878
line 1195
;1194:		}
;1195:		cent->previousEvent = cent->currentState.event;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 428
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ASGNI4
line 1196
;1196:		if ((cent->currentState.event & ~EV_EVENT_BITS) == 0) {
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
CNSTI4 0
NEI4 $880
line 1197
;1197:			return;
ADDRGP4 $871
JUMPV
LABELV $880
line 1199
;1198:		}
;1199:	}
LABELV $873
line 1202
;1200:
;1201:	// calculate the position at exactly the frame time
;1202:	BG_EvaluateTrajectory(&cent->currentState.pos, cg.snap->serverTime, cent->lerpOrigin);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 1203
;1203:	CG_SetEntitySoundPosition(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetEntitySoundPosition
CALLV
pop
line 1205
;1204:
;1205:	CG_EntityEvent(cent, cent->lerpOrigin, -1);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 716
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 CG_EntityEvent
CALLV
pop
line 1206
;1206:}
LABELV $871
endproc CG_CheckEvents 8 12
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
LABELV $833
byte 1 42
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $832
byte 1 42
byte 1 100
byte 1 114
byte 1 111
byte 1 119
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $517
byte 1 42
byte 1 103
byte 1 97
byte 1 115
byte 1 112
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $506
byte 1 42
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $500
byte 1 42
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $458
byte 1 42
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $395
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $391
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $386
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
byte 1 117
byte 1 114
byte 1 112
byte 1 50
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
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 117
byte 1 114
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $380
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 49
byte 1 48
byte 1 48
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $379
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 55
byte 1 53
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $376
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 53
byte 1 48
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $373
byte 1 42
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 50
byte 1 53
byte 1 95
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $309
byte 1 85
byte 1 115
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $308
byte 1 78
byte 1 111
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $298
byte 1 37
byte 1 115
byte 1 32
byte 1 94
byte 1 55
byte 1 100
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $286
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $281
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $280
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 97
byte 1 108
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $279
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $277
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 106
byte 1 117
byte 1 105
byte 1 99
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $275
byte 1 39
byte 1 115
byte 1 32
byte 1 75
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
byte 1 32
byte 1 98
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $274
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 0
align 1
LABELV $272
byte 1 39
byte 1 115
byte 1 32
byte 1 80
byte 1 114
byte 1 111
byte 1 120
byte 1 32
byte 1 77
byte 1 105
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $271
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 0
align 1
LABELV $269
byte 1 39
byte 1 115
byte 1 32
byte 1 67
byte 1 104
byte 1 97
byte 1 105
byte 1 110
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $268
byte 1 103
byte 1 111
byte 1 116
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 115
byte 1 111
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $266
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $264
byte 1 39
byte 1 115
byte 1 32
byte 1 66
byte 1 70
byte 1 71
byte 1 0
align 1
LABELV $263
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $261
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 114
byte 1 111
byte 1 99
byte 1 117
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $259
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $256
byte 1 39
byte 1 115
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $255
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $253
byte 1 97
byte 1 108
byte 1 109
byte 1 111
byte 1 115
byte 1 116
byte 1 32
byte 1 100
byte 1 111
byte 1 100
byte 1 103
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $251
byte 1 39
byte 1 115
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $249
byte 1 39
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 114
byte 1 97
byte 1 112
byte 1 110
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $248
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 104
byte 1 114
byte 1 101
byte 1 100
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $246
byte 1 39
byte 1 115
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $245
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $243
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $241
byte 1 119
byte 1 97
byte 1 115
byte 1 32
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
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $239
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 112
byte 1 117
byte 1 109
byte 1 109
byte 1 101
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $237
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 117
byte 1 103
byte 1 104
byte 1 116
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $216
byte 1 110
byte 1 111
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $213
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $210
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 37
byte 1 115
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $192
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $187
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $186
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $183
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $180
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $179
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $176
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 120
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $172
byte 1 115
byte 1 104
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $170
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $169
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $166
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 0
align 1
LABELV $162
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 104
byte 1 105
byte 1 109
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $161
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $158
byte 1 98
byte 1 108
byte 1 101
byte 1 119
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 115
byte 1 101
byte 1 108
byte 1 102
byte 1 32
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $154
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $153
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 105
byte 1 116
byte 1 115
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $150
byte 1 116
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 32
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $146
byte 1 103
byte 1 111
byte 1 101
byte 1 115
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 97
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $138
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 119
byte 1 114
byte 1 111
byte 1 110
byte 1 103
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $136
byte 1 115
byte 1 97
byte 1 119
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $134
byte 1 100
byte 1 111
byte 1 101
byte 1 115
byte 1 32
byte 1 97
byte 1 32
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 32
byte 1 102
byte 1 108
byte 1 105
byte 1 112
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 97
byte 1 118
byte 1 97
byte 1 0
align 1
LABELV $132
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $130
byte 1 115
byte 1 97
byte 1 110
byte 1 107
byte 1 32
byte 1 108
byte 1 105
byte 1 107
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $128
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 113
byte 1 117
byte 1 105
byte 1 115
byte 1 104
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $126
byte 1 99
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $124
byte 1 115
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $119
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $118
byte 1 110
byte 1 0
align 1
LABELV $111
byte 1 67
byte 1 71
byte 1 95
byte 1 79
byte 1 98
byte 1 105
byte 1 116
byte 1 117
byte 1 97
byte 1 114
byte 1 121
byte 1 58
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $106
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $105
byte 1 37
byte 1 105
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $104
byte 1 37
byte 1 105
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $101
byte 1 37
byte 1 105
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $98
byte 1 37
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $95
byte 1 49
byte 1 51
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $92
byte 1 49
byte 1 50
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $89
byte 1 49
byte 1 49
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $86
byte 1 94
byte 1 51
byte 1 51
byte 1 114
byte 1 100
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $83
byte 1 94
byte 1 49
byte 1 50
byte 1 110
byte 1 100
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $80
byte 1 94
byte 1 52
byte 1 49
byte 1 115
byte 1 116
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $77
byte 1 0
align 1
LABELV $76
byte 1 84
byte 1 105
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 0

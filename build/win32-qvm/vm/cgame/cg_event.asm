bss
align 1
LABELV $82
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
EQI4 $83
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
ADDRGP4 $85
ASGNP4
line 23
;23:	} else {
ADDRGP4 $84
JUMPV
LABELV $83
line 24
;24:		t = "";
ADDRLP4 4
ADDRGP4 $86
ASGNP4
line 25
;25:	}
LABELV $84
line 27
;26:
;27:	if (rank == 1) {
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $87
line 28
;28:		s = S_COLOR_BLUE "1st" S_COLOR_WHITE;		// draw in blue
ADDRLP4 0
ADDRGP4 $89
ASGNP4
line 29
;29:	} else if (rank == 2) {
ADDRGP4 $88
JUMPV
LABELV $87
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $90
line 30
;30:		s = S_COLOR_RED "2nd" S_COLOR_WHITE;		// draw in red
ADDRLP4 0
ADDRGP4 $92
ASGNP4
line 31
;31:	} else if (rank == 3) {
ADDRGP4 $91
JUMPV
LABELV $90
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $93
line 32
;32:		s = S_COLOR_YELLOW "3rd" S_COLOR_WHITE;		// draw in yellow
ADDRLP4 0
ADDRGP4 $95
ASGNP4
line 33
;33:	} else if (rank == 11) {
ADDRGP4 $94
JUMPV
LABELV $93
ADDRFP4 0
INDIRI4
CNSTI4 11
NEI4 $96
line 34
;34:		s = "11th";
ADDRLP4 0
ADDRGP4 $98
ASGNP4
line 35
;35:	} else if (rank == 12) {
ADDRGP4 $97
JUMPV
LABELV $96
ADDRFP4 0
INDIRI4
CNSTI4 12
NEI4 $99
line 36
;36:		s = "12th";
ADDRLP4 0
ADDRGP4 $101
ASGNP4
line 37
;37:	} else if (rank == 13) {
ADDRGP4 $100
JUMPV
LABELV $99
ADDRFP4 0
INDIRI4
CNSTI4 13
NEI4 $102
line 38
;38:		s = "13th";
ADDRLP4 0
ADDRGP4 $104
ASGNP4
line 39
;39:	} else if (rank % 10 == 1) {
ADDRGP4 $103
JUMPV
LABELV $102
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 1
NEI4 $105
line 40
;40:		s = va("%ist", rank);
ADDRGP4 $107
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
ADDRGP4 $106
JUMPV
LABELV $105
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 2
NEI4 $108
line 42
;42:		s = va("%ind", rank);
ADDRGP4 $110
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
ADDRGP4 $109
JUMPV
LABELV $108
ADDRFP4 0
INDIRI4
CNSTI4 10
MODI4
CNSTI4 3
NEI4 $111
line 44
;44:		s = va("%ird", rank);
ADDRGP4 $113
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
ADDRGP4 $112
JUMPV
LABELV $111
line 46
;46:		s = va("%ith", rank);
ADDRGP4 $114
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
LABELV $112
LABELV $109
LABELV $106
LABELV $103
LABELV $100
LABELV $97
LABELV $94
LABELV $91
LABELV $88
line 49
;48:
;49:	Com_sprintf(str, sizeof(str), "%s%s", t, s);
ADDRGP4 $82
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $115
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
ADDRGP4 $82
RETP4
LABELV $81
endproc CG_PlaceString 12 20
proc CG_Obituary 148 20
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
LTI4 $119
ADDRLP4 4
INDIRI4
CNSTI4 64
LTI4 $117
LABELV $119
line 77
;77:		CG_Error("CG_Obituary: target out of range");
ADDRGP4 $120
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 78
;78:	}
LABELV $117
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
LTI4 $124
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $122
LABELV $124
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
ADDRGP4 $123
JUMPV
LABELV $122
line 85
;85:		attackerInfo = CG_ConfigString(CS_PLAYERS + attacker);
ADDRLP4 0
INDIRI4
CNSTI4 529
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
LABELV $123
line 88
;87:
;88:	targetInfo = CG_ConfigString(CS_PLAYERS + target);
ADDRLP4 4
INDIRI4
CNSTI4 529
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
NEI4 $125
line 90
;90:		return;
ADDRGP4 $116
JUMPV
LABELV $125
line 92
;91:	}
;92:	Q_strncpyz(targetName, Info_ValueForKey(targetInfo, "n"), sizeof(targetName) - 2);
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 $127
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
ADDRGP4 $128
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
ADDRGP4 $86
ASGNP4
line 101
;98:
;99:	// check for single client messages
;100:
;101:	switch (mod) {
ADDRLP4 44
INDIRI4
CNSTI4 14
LTI4 $130
ADDRLP4 44
INDIRI4
CNSTI4 30
GTI4 $130
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $152-56
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $152
address $138
address $140
address $142
address $136
address $130
address $134
address $132
address $148
address $150
address $130
address $130
address $130
address $130
address $130
address $130
address $144
address $146
code
LABELV $132
line 103
;102:	case MOD_SUICIDE:
;103:		message = "suicides";
ADDRLP4 40
ADDRGP4 $133
ASGNP4
line 104
;104:		break;
ADDRGP4 $131
JUMPV
LABELV $134
line 106
;105:	case MOD_FALLING:
;106:		message = "cratered";
ADDRLP4 40
ADDRGP4 $135
ASGNP4
line 107
;107:		break;
ADDRGP4 $131
JUMPV
LABELV $136
line 109
;108:	case MOD_CRUSH:
;109:		message = "was squished";
ADDRLP4 40
ADDRGP4 $137
ASGNP4
line 110
;110:		break;
ADDRGP4 $131
JUMPV
LABELV $138
line 112
;111:	case MOD_WATER:
;112:		message = "sank like a rock";
ADDRLP4 40
ADDRGP4 $139
ASGNP4
line 113
;113:		break;
ADDRGP4 $131
JUMPV
LABELV $140
line 115
;114:	case MOD_SLIME:
;115:		message = "melted";
ADDRLP4 40
ADDRGP4 $141
ASGNP4
line 116
;116:		break;
ADDRGP4 $131
JUMPV
LABELV $142
line 118
;117:	case MOD_LAVA:
;118:		message = "does a back flip into the lava";
ADDRLP4 40
ADDRGP4 $143
ASGNP4
line 119
;119:		break;
ADDRGP4 $131
JUMPV
LABELV $144
line 121
;120:	case MOD_SWITCHTEAM:
;121:		message = "switched teams";
ADDRLP4 40
ADDRGP4 $145
ASGNP4
line 122
;122:		break;
ADDRGP4 $131
JUMPV
LABELV $146
line 124
;123:	case MOD_THAW:
;124:		message = "was auto-thawed";
ADDRLP4 40
ADDRGP4 $147
ASGNP4
line 125
;125:		break;
ADDRGP4 $131
JUMPV
LABELV $148
line 127
;126:	case MOD_TARGET_LASER:
;127:		message = "saw the light";
ADDRLP4 40
ADDRGP4 $149
ASGNP4
line 128
;128:		break;
ADDRGP4 $131
JUMPV
LABELV $150
line 130
;129:	case MOD_TRIGGER_HURT:
;130:		message = "was in the wrong place";
ADDRLP4 40
ADDRGP4 $151
ASGNP4
line 131
;131:		break;
ADDRGP4 $131
JUMPV
LABELV $130
line 133
;132:	default:
;133:		message = NULL;
ADDRLP4 40
CNSTP4 0
ASGNP4
line 134
;134:		break;
LABELV $131
line 137
;135:	}
;136:
;137:	if (attacker == target) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $154
line 138
;138:		gender = ci->gender;
ADDRLP4 100
ADDRLP4 92
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
ASGNI4
line 139
;139:		switch (mod) {
ADDRLP4 44
INDIRI4
CNSTI4 13
EQI4 $192
ADDRLP4 44
INDIRI4
CNSTI4 13
GTI4 $210
LABELV $209
ADDRLP4 44
INDIRI4
CNSTI4 5
EQI4 $160
ADDRLP4 44
INDIRI4
CNSTI4 7
EQI4 $168
ADDRLP4 44
INDIRI4
CNSTI4 9
EQI4 $184
ADDRGP4 $156
JUMPV
LABELV $210
ADDRLP4 44
INDIRI4
CNSTI4 25
EQI4 $194
ADDRLP4 44
INDIRI4
CNSTI4 26
EQI4 $158
ADDRLP4 44
INDIRI4
CNSTI4 25
LTI4 $156
LABELV $211
ADDRLP4 44
INDIRI4
CNSTI4 31
EQI4 $176
ADDRGP4 $156
JUMPV
LABELV $158
line 141
;140:		case MOD_KAMIKAZE:
;141:			message = "goes out with a bang";
ADDRLP4 40
ADDRGP4 $159
ASGNP4
line 142
;142:			break;
ADDRGP4 $157
JUMPV
LABELV $160
line 144
;143:		case MOD_GRENADE_SPLASH:
;144:			if (gender == GENDER_FEMALE)
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $161
line 145
;145:				message = "tripped on her own grenade";
ADDRLP4 40
ADDRGP4 $163
ASGNP4
ADDRGP4 $157
JUMPV
LABELV $161
line 146
;146:			else if (gender == GENDER_NEUTER)
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $164
line 147
;147:				message = "tripped on its own grenade";
ADDRLP4 40
ADDRGP4 $166
ASGNP4
ADDRGP4 $157
JUMPV
LABELV $164
line 149
;148:			else
;149:				message = "tripped on his own grenade";
ADDRLP4 40
ADDRGP4 $167
ASGNP4
line 150
;150:			break;
ADDRGP4 $157
JUMPV
LABELV $168
line 152
;151:		case MOD_ROCKET_SPLASH:
;152:			if (gender == GENDER_FEMALE)
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $169
line 153
;153:				message = "blew herself up";
ADDRLP4 40
ADDRGP4 $171
ASGNP4
ADDRGP4 $157
JUMPV
LABELV $169
line 154
;154:			else if (gender == GENDER_NEUTER)
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $172
line 155
;155:				message = "blew itself up";
ADDRLP4 40
ADDRGP4 $174
ASGNP4
ADDRGP4 $157
JUMPV
LABELV $172
line 157
;156:			else
;157:				message = "blew himself up";
ADDRLP4 40
ADDRGP4 $175
ASGNP4
line 158
;158:			break;
ADDRGP4 $157
JUMPV
LABELV $176
line 160
;159:		case MOD_LIGHTNING_DISCHARGE:
;160:			if (gender == GENDER_FEMALE)
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $177
line 161
;161:				message = "discharged herself";
ADDRLP4 40
ADDRGP4 $179
ASGNP4
ADDRGP4 $157
JUMPV
LABELV $177
line 162
;162:			else if (gender == GENDER_NEUTER)
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $180
line 163
;163:				message = "discharged itself";
ADDRLP4 40
ADDRGP4 $182
ASGNP4
ADDRGP4 $157
JUMPV
LABELV $180
line 165
;164:			else
;165:				message = "discharged himself";
ADDRLP4 40
ADDRGP4 $183
ASGNP4
line 166
;166:			break;
ADDRGP4 $157
JUMPV
LABELV $184
line 168
;167:		case MOD_PLASMA_SPLASH:
;168:			if (gender == GENDER_FEMALE)
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $185
line 169
;169:				message = "melted herself";
ADDRLP4 40
ADDRGP4 $187
ASGNP4
ADDRGP4 $157
JUMPV
LABELV $185
line 170
;170:			else if (gender == GENDER_NEUTER)
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $188
line 171
;171:				message = "melted itself";
ADDRLP4 40
ADDRGP4 $190
ASGNP4
ADDRGP4 $157
JUMPV
LABELV $188
line 173
;172:			else
;173:				message = "melted himself";
ADDRLP4 40
ADDRGP4 $191
ASGNP4
line 174
;174:			break;
ADDRGP4 $157
JUMPV
LABELV $192
line 176
;175:		case MOD_BFG_SPLASH:
;176:			message = "should have used a smaller gun";
ADDRLP4 40
ADDRGP4 $193
ASGNP4
line 177
;177:			break;
ADDRGP4 $157
JUMPV
LABELV $194
line 179
;178:		case MOD_PROXIMITY_MINE:
;179:			if (gender == GENDER_FEMALE) {
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $195
line 180
;180:				message = "found her prox mine";
ADDRLP4 40
ADDRGP4 $197
ASGNP4
line 181
;181:			} else if (gender == GENDER_NEUTER) {
ADDRGP4 $157
JUMPV
LABELV $195
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $198
line 182
;182:				message = "found its prox mine";
ADDRLP4 40
ADDRGP4 $200
ASGNP4
line 183
;183:			} else {
ADDRGP4 $157
JUMPV
LABELV $198
line 184
;184:				message = "found his prox mine";
ADDRLP4 40
ADDRGP4 $201
ASGNP4
line 185
;185:			}
line 186
;186:			break;
ADDRGP4 $157
JUMPV
LABELV $156
line 188
;187:		default:
;188:			if (gender == GENDER_FEMALE)
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $202
line 189
;189:				message = "killed herself";
ADDRLP4 40
ADDRGP4 $204
ASGNP4
ADDRGP4 $157
JUMPV
LABELV $202
line 190
;190:			else if (gender == GENDER_NEUTER)
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $205
line 191
;191:				message = "killed itself";
ADDRLP4 40
ADDRGP4 $207
ASGNP4
ADDRGP4 $157
JUMPV
LABELV $205
line 193
;192:			else
;193:				message = "killed himself";
ADDRLP4 40
ADDRGP4 $208
ASGNP4
line 194
;194:			break;
LABELV $157
line 196
;195:		}
;196:	}
LABELV $154
line 198
;197:
;198:	if (message) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $212
line 199
;199:		CG_Printf("%s %s.\n", targetName, message);
ADDRGP4 $214
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 201
;200:		// switch to first killer if not following anyone
;201:		if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR && cg_followKiller.integer) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $116
ADDRGP4 cg_followKiller+12
INDIRI4
CNSTI4 0
EQI4 $116
line 202
;202:			if (!cg.followTime && attacker != cg.snap->ps.clientNum && attacker < MAX_CLIENTS) {
ADDRGP4 cg+157008
INDIRI4
CNSTI4 0
NEI4 $116
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $116
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $116
line 203
;203:				cg.followClient = attacker;
ADDRGP4 cg+157012
ADDRLP4 0
INDIRI4
ASGNI4
line 204
;204:				cg.followTime = cg.time;
ADDRGP4 cg+157008
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 205
;205:			}
line 206
;206:		}
line 207
;207:		return;
ADDRGP4 $116
JUMPV
LABELV $212
line 211
;208:	}
;209:
;210:	// check for kill messages from the current clientNum
;211:	if (attacker == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $226
line 213
;212:		char *s;
;213:		char *mode = cgs.gametype == GT_FREEZE ? (mod == MOD_THAW ? "thawed" : "froze") : "fragged";
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 9
NEI4 $235
ADDRLP4 44
INDIRI4
CNSTI4 30
NEI4 $237
ADDRLP4 136
ADDRGP4 $230
ASGNP4
ADDRGP4 $238
JUMPV
LABELV $237
ADDRLP4 136
ADDRGP4 $231
ASGNP4
LABELV $238
ADDRLP4 132
ADDRLP4 136
INDIRP4
ASGNP4
ADDRGP4 $236
JUMPV
LABELV $235
ADDRLP4 132
ADDRGP4 $233
ASGNP4
LABELV $236
ADDRLP4 124
ADDRLP4 132
INDIRP4
ASGNP4
line 215
;214:
;215:		if (cgs.gametype < GT_TEAM) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
GEI4 $239
line 216
;216:			s = va("You %s %s\n%s place with %i", mode, targetName,
ADDRGP4 cg+36
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 140
ADDRGP4 CG_PlaceString
CALLP4
ASGNP4
ADDRGP4 $242
ARGP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 140
INDIRP4
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRLP4 144
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 128
ADDRLP4 144
INDIRP4
ASGNP4
line 219
;217:				CG_PlaceString(cg.snap->ps.persistant[PERS_RANK] + 1),
;218:				cg.snap->ps.persistant[PERS_SCORE]);
;219:		} else {
ADDRGP4 $240
JUMPV
LABELV $239
line 221
;220:			//TODO: add "your teammate." if on same team
;221:			s = va("You %s %s", mode, targetName);
ADDRGP4 $245
ARGP4
ADDRLP4 124
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 140
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 128
ADDRLP4 140
INDIRP4
ASGNP4
line 222
;222:		}
LABELV $240
line 224
;223:
;224:		CG_CenterPrint(s, SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH);
ADDRLP4 128
INDIRP4
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 227
;225:
;226:		// print the text message as well
;227:	}
LABELV $226
line 230
;228:
;229:	// check for double client messages
;230:	if (!attackerInfo) {
ADDRLP4 84
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $246
line 231
;231:		attacker = ENTITYNUM_WORLD;
ADDRLP4 0
CNSTI4 1022
ASGNI4
line 232
;232:		strcpy(attackerName, "noname");
ADDRLP4 52
ARGP4
ADDRGP4 $248
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 233
;233:	} else {
ADDRGP4 $247
JUMPV
LABELV $246
line 234
;234:		Q_strncpyz(attackerName, Info_ValueForKey(attackerInfo, "n"), sizeof(attackerName) - 2);
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 $127
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
line 235
;235:		Q_CleanStr(attackerName);
ADDRLP4 52
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 236
;236:		strcat(attackerName, S_COLOR_WHITE);
ADDRLP4 52
ARGP4
ADDRGP4 $128
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 238
;237:		// check for kill messages about the current clientNum
;238:		if (target == cg.snap->ps.clientNum) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $249
line 239
;239:			Q_strncpyz(cg.killerName, attackerName, sizeof(cg.killerName));
ADDRGP4 cg+115368
ARGP4
ADDRLP4 52
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 241
;240:			// follow killer
;241:			if (following && cg_followKiller.integer) {
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $254
ADDRGP4 cg_followKiller+12
INDIRI4
CNSTI4 0
EQI4 $254
line 242
;242:				if (!cg.followTime && attacker != cg.snap->ps.clientNum && attacker < MAX_CLIENTS) {
ADDRGP4 cg+157008
INDIRI4
CNSTI4 0
NEI4 $257
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $257
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $257
line 243
;243:					cg.followClient = attacker;
ADDRGP4 cg+157012
ADDRLP4 0
INDIRI4
ASGNI4
line 244
;244:					cg.followTime = cg.time + 1100;
ADDRGP4 cg+157008
ADDRGP4 cg+107604
INDIRI4
CNSTI4 1100
ADDI4
ASGNI4
line 245
;245:				}
LABELV $257
line 246
;246:			}
LABELV $254
line 247
;247:		}
LABELV $249
line 248
;248:	}
LABELV $247
line 250
;249:
;250:	if (attacker != ENTITYNUM_WORLD) {
ADDRLP4 0
INDIRI4
CNSTI4 1022
EQI4 $264
line 251
;251:		switch (mod) {
ADDRLP4 44
INDIRI4
CNSTI4 1
LTI4 $266
ADDRLP4 44
INDIRI4
CNSTI4 32
GTI4 $266
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $321-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $321
address $277
address $270
address $272
address $279
address $282
address $285
address $287
address $289
address $292
address $293
address $295
address $299
address $299
address $266
address $266
address $266
address $266
address $315
address $266
address $266
address $266
address $266
address $302
address $304
address $307
address $310
address $313
address $268
address $266
address $318
address $297
address $274
code
LABELV $268
line 253
;252:		case MOD_GRAPPLE:
;253:			message = "was caught by";
ADDRLP4 40
ADDRGP4 $269
ASGNP4
line 254
;254:			break;
ADDRGP4 $267
JUMPV
LABELV $270
line 256
;255:		case MOD_GAUNTLET:
;256:			message = "was pummeled by";
ADDRLP4 40
ADDRGP4 $271
ASGNP4
line 257
;257:			break;
ADDRGP4 $267
JUMPV
LABELV $272
line 259
;258:		case MOD_MACHINEGUN:
;259:			message = "was machinegunned by";
ADDRLP4 40
ADDRGP4 $273
ASGNP4
line 260
;260:			break;
ADDRGP4 $267
JUMPV
LABELV $274
line 262
;261:		case MOD_HMG:
;262:			message = "was ripped up by";
ADDRLP4 40
ADDRGP4 $275
ASGNP4
line 263
;263:			message2 = "'s HMG";
ADDRLP4 88
ADDRGP4 $276
ASGNP4
line 264
;264:			break;
ADDRGP4 $267
JUMPV
LABELV $277
line 266
;265:		case MOD_SHOTGUN:
;266:			message = "was gunned down by";
ADDRLP4 40
ADDRGP4 $278
ASGNP4
line 267
;267:			break;
ADDRGP4 $267
JUMPV
LABELV $279
line 269
;268:		case MOD_GRENADE:
;269:			message = "ate";
ADDRLP4 40
ADDRGP4 $280
ASGNP4
line 270
;270:			message2 = "'s grenade";
ADDRLP4 88
ADDRGP4 $281
ASGNP4
line 271
;271:			break;
ADDRGP4 $267
JUMPV
LABELV $282
line 273
;272:		case MOD_GRENADE_SPLASH:
;273:			message = "was shredded by";
ADDRLP4 40
ADDRGP4 $283
ASGNP4
line 274
;274:			message2 = "'s shrapnel";
ADDRLP4 88
ADDRGP4 $284
ASGNP4
line 275
;275:			break;
ADDRGP4 $267
JUMPV
LABELV $285
line 277
;276:		case MOD_ROCKET:
;277:			message = "ate";
ADDRLP4 40
ADDRGP4 $280
ASGNP4
line 278
;278:			message2 = "'s rocket";
ADDRLP4 88
ADDRGP4 $286
ASGNP4
line 279
;279:			break;
ADDRGP4 $267
JUMPV
LABELV $287
line 281
;280:		case MOD_ROCKET_SPLASH:
;281:			message = "almost dodged";
ADDRLP4 40
ADDRGP4 $288
ASGNP4
line 282
;282:			message2 = "'s rocket";
ADDRLP4 88
ADDRGP4 $286
ASGNP4
line 283
;283:			break;
ADDRGP4 $267
JUMPV
LABELV $289
line 285
;284:		case MOD_PLASMA:
;285:			message = "was melted by";
ADDRLP4 40
ADDRGP4 $290
ASGNP4
line 286
;286:			message2 = "'s plasmagun";
ADDRLP4 88
ADDRGP4 $291
ASGNP4
line 287
;287:			break;
ADDRGP4 $267
JUMPV
LABELV $292
line 289
;288:		case MOD_PLASMA_SPLASH:
;289:			message = "was melted by";
ADDRLP4 40
ADDRGP4 $290
ASGNP4
line 290
;290:			message2 = "'s plasmagun";
ADDRLP4 88
ADDRGP4 $291
ASGNP4
line 291
;291:			break;
ADDRGP4 $267
JUMPV
LABELV $293
line 293
;292:		case MOD_RAILGUN:
;293:			message = "was railed by";
ADDRLP4 40
ADDRGP4 $294
ASGNP4
line 294
;294:			break;
ADDRGP4 $267
JUMPV
LABELV $295
line 296
;295:		case MOD_LIGHTNING:
;296:			message = "was electrocuted by";
ADDRLP4 40
ADDRGP4 $296
ASGNP4
line 297
;297:			break;
ADDRGP4 $267
JUMPV
LABELV $297
line 299
;298:		case MOD_LIGHTNING_DISCHARGE:
;299:			message = "was discharged by";
ADDRLP4 40
ADDRGP4 $298
ASGNP4
line 300
;300:			break;
ADDRGP4 $267
JUMPV
LABELV $299
line 303
;301:		case MOD_BFG:
;302:		case MOD_BFG_SPLASH:
;303:			message = "was blasted by";
ADDRLP4 40
ADDRGP4 $300
ASGNP4
line 304
;304:			message2 = "'s BFG";
ADDRLP4 88
ADDRGP4 $301
ASGNP4
line 305
;305:			break;
ADDRGP4 $267
JUMPV
LABELV $302
line 307
;306:		case MOD_NAIL:
;307:			message = "was nailed by";
ADDRLP4 40
ADDRGP4 $303
ASGNP4
line 308
;308:			break;
ADDRGP4 $267
JUMPV
LABELV $304
line 310
;309:		case MOD_CHAINGUN:
;310:			message = "got lead poisoning from";
ADDRLP4 40
ADDRGP4 $305
ASGNP4
line 311
;311:			message2 = "'s Chaingun";
ADDRLP4 88
ADDRGP4 $306
ASGNP4
line 312
;312:			break;
ADDRGP4 $267
JUMPV
LABELV $307
line 314
;313:		case MOD_PROXIMITY_MINE:
;314:			message = "was too close to";
ADDRLP4 40
ADDRGP4 $308
ASGNP4
line 315
;315:			message2 = "'s Prox Mine";
ADDRLP4 88
ADDRGP4 $309
ASGNP4
line 316
;316:			break;
ADDRGP4 $267
JUMPV
LABELV $310
line 318
;317:		case MOD_KAMIKAZE:
;318:			message = "falls to";
ADDRLP4 40
ADDRGP4 $311
ASGNP4
line 319
;319:			message2 = "'s Kamikaze blast";
ADDRLP4 88
ADDRGP4 $312
ASGNP4
line 320
;320:			break;
ADDRGP4 $267
JUMPV
LABELV $313
line 322
;321:		case MOD_JUICED:
;322:			message = "was juiced by";
ADDRLP4 40
ADDRGP4 $314
ASGNP4
line 323
;323:			break;
ADDRGP4 $267
JUMPV
LABELV $315
line 325
;324:		case MOD_TELEFRAG:
;325:			message = "tried to invade";
ADDRLP4 40
ADDRGP4 $316
ASGNP4
line 326
;326:			message2 = "'s personal space";
ADDRLP4 88
ADDRGP4 $317
ASGNP4
line 327
;327:			break;
ADDRGP4 $267
JUMPV
LABELV $318
line 329
;328:		case MOD_THAW:
;329:			message = "was thawed by";
ADDRLP4 40
ADDRGP4 $319
ASGNP4
line 330
;330:			break;
ADDRGP4 $267
JUMPV
LABELV $266
line 332
;331:		default:
;332:			message = "was killed by";
ADDRLP4 40
ADDRGP4 $320
ASGNP4
line 333
;333:			break;
LABELV $267
line 336
;334:		}
;335:
;336:		if (message) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $323
line 337
;337:			CG_Printf("%s %s %s%s\n", targetName, message, attackerName, message2);
ADDRGP4 $325
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
line 339
;338:			// switch to first killer if not following anyone
;339:			if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR && cg_followKiller.integer) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $116
ADDRGP4 cg_followKiller+12
INDIRI4
CNSTI4 0
EQI4 $116
line 340
;340:				if (!cg.followTime && attacker != cg.snap->ps.clientNum && attacker < MAX_CLIENTS) {
ADDRGP4 cg+157008
INDIRI4
CNSTI4 0
NEI4 $116
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $116
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $116
line 341
;341:					cg.followClient = attacker;
ADDRGP4 cg+157012
ADDRLP4 0
INDIRI4
ASGNI4
line 342
;342:					cg.followTime = cg.time;
ADDRGP4 cg+157008
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 343
;343:				}
line 344
;344:			}
line 345
;345:			return;
ADDRGP4 $116
JUMPV
LABELV $323
line 347
;346:		}
;347:	}
LABELV $264
line 350
;348:
;349:	// we don't know what it was
;350:	CG_Printf("%s "S_COLOR_STRIP"died.\n", targetName);
ADDRGP4 $337
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 351
;351:}
LABELV $116
endproc CG_Obituary 148 20
proc CG_UseItem 32 16
line 360
;352://==========================================================================
;353:
;354:
;355:/*
;356:===============
;357:CG_UseItem
;358:===============
;359:*/
;360:static void CG_UseItem(centity_t *cent) {
line 366
;361:	clientInfo_t *ci;
;362:	int			itemNum, clientNum;
;363:	gitem_t *item;
;364:	entityState_t *es;
;365:
;366:	es = &cent->currentState;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 368
;367:
;368:	itemNum = (es->event & ~EV_EVENT_BITS) - EV_USE_ITEM0;
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
line 369
;369:	if (itemNum < 0 || itemNum > HI_NUM_HOLDABLE) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $341
ADDRLP4 0
INDIRI4
CNSTI4 9
LEI4 $339
LABELV $341
line 370
;370:		itemNum = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 371
;371:	}
LABELV $339
line 374
;372:
;373:	// print a message if the local player
;374:	if (es->number == cg.snap->ps.clientNum) {
ADDRLP4 4
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $342
line 375
;375:		if (!itemNum) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $345
line 376
;376:			CG_CenterPrint("No item to use", SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH);
ADDRGP4 $347
ARGP4
CNSTI4 144
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_CenterPrint
CALLV
pop
line 377
;377:		} else {
ADDRGP4 $346
JUMPV
LABELV $345
line 378
;378:			item = BG_FindItemForHoldable(itemNum);
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
line 379
;379:			CG_CenterPrint(va("Use %s", item->pickup_name), SCREEN_HEIGHT * 0.30, BIGCHAR_WIDTH);
ADDRGP4 $348
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
line 380
;380:		}
LABELV $346
line 381
;381:	}
LABELV $342
line 383
;382:
;383:	switch (itemNum) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $349
ADDRLP4 0
INDIRI4
CNSTI4 5
GTI4 $349
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $367
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $367
address $351
address $350
address $355
address $350
address $350
address $364
code
LABELV $349
LABELV $351
line 386
;384:	default:
;385:	case HI_NONE:
;386:		trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.useNothingSound);
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+146664+712
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 387
;387:		break;
ADDRGP4 $350
JUMPV
line 390
;388:
;389:	case HI_TELEPORTER:
;390:		break;
LABELV $355
line 393
;391:
;392:	case HI_MEDKIT:
;393:		clientNum = cent->currentState.clientNum;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 394
;394:		if (clientNum >= 0 && clientNum < MAX_CLIENTS) {
ADDRLP4 28
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $356
ADDRLP4 28
INDIRI4
CNSTI4 64
GEI4 $356
line 395
;395:			ci = &cgs.clientinfo[clientNum];
ADDRLP4 16
ADDRLP4 12
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+38916
ADDP4
ASGNP4
line 396
;396:			ci->medkitUsageTime = cg.time;
ADDRLP4 16
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 397
;397:		}
LABELV $356
line 398
;398:		trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.medkitSound);
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+146664+1128
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 399
;399:		break;
ADDRGP4 $350
JUMPV
line 402
;400:
;401:	case HI_KAMIKAZE:
;402:		break;
line 405
;403:
;404:	case HI_PORTAL:
;405:		break;
LABELV $364
line 408
;406:
;407:	case HI_INVULNERABILITY:
;408:		trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.useInvulnerabilitySound);
CNSTP4 0
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+146664+908
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 409
;409:		break;
LABELV $350
line 411
;410:	}
;411:}
LABELV $338
endproc CG_UseItem 32 16
data
align 4
LABELV $369
byte 4 -1
code
proc CG_ItemPickup 4 0
line 421
;412:
;413:
;414:/*
;415:================
;416:CG_ItemPickup
;417:
;418:A new item was picked up this frame
;419:================
;420:*/
;421:static void CG_ItemPickup(int itemNum) {
line 424
;422:	static int oldItem = -1;
;423:
;424:	cg.itemPickup = itemNum;
ADDRGP4 cg+125764
ADDRFP4 0
INDIRI4
ASGNI4
line 425
;425:	cg.itemPickupTime = cg.time;
ADDRGP4 cg+125772
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 426
;426:	cg.itemPickupBlendTime = cg.time;
ADDRGP4 cg+125776
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 428
;427:
;428:	if (oldItem != itemNum)
ADDRGP4 $369
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $375
line 429
;429:		cg.itemPickupCount = 1;
ADDRGP4 cg+125768
CNSTI4 1
ASGNI4
ADDRGP4 $376
JUMPV
LABELV $375
line 431
;430:	else
;431:		cg.itemPickupCount++;
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
LABELV $376
line 433
;432:
;433:	oldItem = itemNum;
ADDRGP4 $369
ADDRFP4 0
INDIRI4
ASGNI4
line 436
;434:
;435:	// see if it should be the grabbed weapon
;436:	if (bg_itemlist[itemNum].giType == IT_WEAPON) {
ADDRFP4 0
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $379
line 438
;437:		// select it immediately
;438:		if (cg_autoswitch.integer && bg_itemlist[itemNum].giTag != WP_MACHINEGUN) {
ADDRGP4 cg_autoswitch+12
INDIRI4
CNSTI4 0
EQI4 $382
ADDRFP4 0
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 2
EQI4 $382
line 439
;439:			cg.weaponSelectTime = cg.time;
ADDRGP4 cg+125780
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 440
;440:			cg.weaponSelect = bg_itemlist[itemNum].giTag;
ADDRGP4 cg+108956
ADDRFP4 0
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
ASGNI4
line 441
;441:		}
LABELV $382
line 442
;442:	}
LABELV $379
line 444
;443:
;444:}
LABELV $368
endproc CG_ItemPickup 4 0
export CG_WaterLevel
proc CG_WaterLevel 52 8
line 454
;445:
;446:
;447:/*
;448:================
;449:CG_WaterLevel
;450:
;451:Returns waterlevel for entity origin
;452:================
;453:*/
;454:int CG_WaterLevel(centity_t *cent) {
line 459
;455:	vec3_t point;
;456:	int contents, sample1, sample2, anim, waterlevel;
;457:	int viewheight;
;458:
;459:	anim = cent->currentState.legsAnim & ~ANIM_TOGGLEBIT;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 461
;460:
;461:	if (anim == LEGS_WALKCR || anim == LEGS_IDLECR) {
ADDRLP4 16
INDIRI4
CNSTI4 13
EQI4 $393
ADDRLP4 16
INDIRI4
CNSTI4 23
NEI4 $391
LABELV $393
line 462
;462:		viewheight = CROUCH_VIEWHEIGHT;
ADDRLP4 24
CNSTI4 12
ASGNI4
line 463
;463:	} else {
ADDRGP4 $392
JUMPV
LABELV $391
line 464
;464:		viewheight = DEFAULT_VIEWHEIGHT;
ADDRLP4 24
CNSTI4 26
ASGNI4
line 465
;465:	}
LABELV $392
line 470
;466:
;467:	//
;468:	// get waterlevel, accounting for ducking
;469:	//
;470:	waterlevel = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 472
;471:
;472:	point[0] = cent->lerpOrigin[0];
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRF4
ASGNF4
line 473
;473:	point[1] = cent->lerpOrigin[1];
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 720
ADDP4
INDIRF4
ASGNF4
line 474
;474:	point[2] = cent->lerpOrigin[2] + MINS_Z + 1;
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
line 475
;475:	contents = CG_PointContents(point, -1);
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
line 477
;476:
;477:	if (contents & MASK_WATER) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $396
line 478
;478:		sample2 = viewheight - MINS_Z;
ADDRLP4 28
ADDRLP4 24
INDIRI4
CNSTI4 -24
SUBI4
ASGNI4
line 479
;479:		sample1 = sample2 / 2;
ADDRLP4 32
ADDRLP4 28
INDIRI4
CNSTI4 2
DIVI4
ASGNI4
line 480
;480:		waterlevel = 1;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 481
;481:		point[2] = cent->lerpOrigin[2] + MINS_Z + sample1;
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
line 482
;482:		contents = CG_PointContents(point, -1);
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
line 484
;483:
;484:		if (contents & MASK_WATER) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $399
line 485
;485:			waterlevel = 2;
ADDRLP4 20
CNSTI4 2
ASGNI4
line 486
;486:			point[2] = cent->lerpOrigin[2] + MINS_Z + sample2;
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
line 487
;487:			contents = CG_PointContents(point, -1);
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
line 489
;488:
;489:			if (contents & MASK_WATER) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $402
line 490
;490:				waterlevel = 3;
ADDRLP4 20
CNSTI4 3
ASGNI4
line 491
;491:			}
LABELV $402
line 492
;492:		}
LABELV $399
line 493
;493:	}
LABELV $396
line 495
;494:
;495:	return waterlevel;
ADDRLP4 20
INDIRI4
RETI4
LABELV $390
endproc CG_WaterLevel 52 8
export CG_PainEvent
proc CG_PainEvent 16 16
line 505
;496:}
;497:
;498:/*
;499:================
;500:CG_PainEvent
;501:
;502:Also called by playerstate transition
;503:================
;504:*/
;505:void CG_PainEvent(centity_t *cent, int health) {
line 509
;506:	const char *snd;
;507:
;508:	// don't do more than two pain sounds a second
;509:	if (cg.time - cent->pe.painTime < 500) {
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
SUBI4
CNSTI4 500
GEI4 $405
line 510
;510:		cent->pe.painIgnore = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 0
ASGNI4
line 511
;511:		return;
ADDRGP4 $404
JUMPV
LABELV $405
line 514
;512:	}
;513:
;514:	if (cent->pe.painIgnore) {
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
INDIRI4
CNSTI4 0
EQI4 $408
line 515
;515:		cent->pe.painIgnore = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 0
ASGNI4
line 516
;516:		return;
ADDRGP4 $404
JUMPV
LABELV $408
line 519
;517:	}
;518:
;519:	if (health < 25) {
ADDRFP4 4
INDIRI4
CNSTI4 25
GEI4 $410
line 520
;520:		snd = "*pain25_1.wav";
ADDRLP4 0
ADDRGP4 $412
ASGNP4
line 521
;521:	} else if (health < 50) {
ADDRGP4 $411
JUMPV
LABELV $410
ADDRFP4 4
INDIRI4
CNSTI4 50
GEI4 $413
line 522
;522:		snd = "*pain50_1.wav";
ADDRLP4 0
ADDRGP4 $415
ASGNP4
line 523
;523:	} else if (health < 75) {
ADDRGP4 $414
JUMPV
LABELV $413
ADDRFP4 4
INDIRI4
CNSTI4 75
GEI4 $416
line 524
;524:		snd = "*pain75_1.wav";
ADDRLP4 0
ADDRGP4 $418
ASGNP4
line 525
;525:	} else {
ADDRGP4 $417
JUMPV
LABELV $416
line 526
;526:		snd = "*pain100_1.wav";
ADDRLP4 0
ADDRGP4 $419
ASGNP4
line 527
;527:	}
LABELV $417
LABELV $414
LABELV $411
line 530
;528:
;529:	// play a gurp sound instead of a normal pain sound
;530:	if (CG_WaterLevel(cent) == 3) {
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
NEI4 $420
line 531
;531:		if (rand() & 1) {
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $422
line 532
;532:			trap_S_StartSound(NULL, cent->currentState.number, CHAN_VOICE, CG_CustomSound(cent->currentState.number, "sound/player/gurp1.wav"));
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $424
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
line 533
;533:		} else {
ADDRGP4 $421
JUMPV
LABELV $422
line 534
;534:			trap_S_StartSound(NULL, cent->currentState.number, CHAN_VOICE, CG_CustomSound(cent->currentState.number, "sound/player/gurp2.wav"));
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $425
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
line 535
;535:		}
line 536
;536:	} else {
ADDRGP4 $421
JUMPV
LABELV $420
line 537
;537:		trap_S_StartSound(NULL, cent->currentState.number, CHAN_VOICE, CG_CustomSound(cent->currentState.number, snd));
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
line 538
;538:	}
LABELV $421
line 541
;539:
;540:	// save pain time for programitic twitch animation
;541:	cent->pe.painTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 542
;542:	cent->pe.painDirection ^= 1;
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
line 543
;543:}
LABELV $404
endproc CG_PainEvent 16 16
data
align 4
LABELV $533
byte 4 0
byte 4 0
byte 4 1065353216
export CG_EntityEvent
code
proc CG_EntityEvent 124 48
line 555
;544:
;545:
;546:
;547:/*
;548:==============
;549:CG_EntityEvent
;550:
;551:An entity has an event value
;552:also called by CG_CheckPlayerstateEvents
;553:==============
;554:*/
;555:void CG_EntityEvent(centity_t *cent, vec3_t position, int entityNum) {
line 566
;556:	entityState_t *es;
;557:	entity_event_t	event;
;558:	vec3_t			dir;
;559:	const char *s;
;560:	int				clientNum;
;561:	clientInfo_t *ci;
;562:	vec3_t			vec;
;563:	float			fovOffset;
;564:	centity_t *ce;
;565:
;566:	es = &cent->currentState;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 567
;567:	event = es->event & ~EV_EVENT_BITS;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
ASGNI4
line 569
;568:
;569:	if ((unsigned)event >= EV_MAX) {
ADDRLP4 4
INDIRI4
CVIU4 4
CNSTU4 83
LTU4 $428
line 570
;570:		CG_Error("Unknown event: %i", event);
ADDRGP4 $430
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 571
;571:		return;
ADDRGP4 $427
JUMPV
LABELV $428
line 574
;572:	}
;573:
;574:	if (cg_debugEvents.integer) {
ADDRGP4 cg_debugEvents+12
INDIRI4
CNSTI4 0
EQI4 $431
line 575
;575:		CG_Printf("ent:%3i  event:%3i %s", es->number, event, eventnames[event]);
ADDRGP4 $434
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
line 576
;576:	}
LABELV $431
line 578
;577:
;578:	if (!event) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $435
line 579
;579:		return;
ADDRGP4 $427
JUMPV
LABELV $435
line 582
;580:	}
;581:
;582:	clientNum = es->clientNum;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 583
;583:	if ((unsigned)clientNum >= MAX_CLIENTS) {
ADDRLP4 8
INDIRI4
CVIU4 4
CNSTU4 64
LTU4 $437
line 584
;584:		clientNum = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 585
;585:	}
LABELV $437
line 586
;586:	ci = &cgs.clientinfo[clientNum];
ADDRLP4 12
ADDRLP4 8
INDIRI4
CNSTI4 1652
MULI4
ADDRGP4 cgs+38916
ADDP4
ASGNP4
line 588
;587:
;588:	switch (event) {
ADDRLP4 52
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 1
LTI4 $440
ADDRLP4 52
INDIRI4
CNSTI4 76
GTI4 $440
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $908-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $908
address $443
address $449
address $456
address $463
address $470
address $506
address $506
address $506
address $506
address $477
address $487
address $496
address $532
address $540
address $546
address $549
address $552
address $555
address $557
address $595
address $612
address $616
address $619
address $620
address $620
address $620
address $620
address $620
address $620
address $620
address $620
address $620
address $620
address $620
address $620
address $620
address $620
address $620
address $620
address $630
address $627
address $621
address $624
address $634
address $729
address $734
address $741
address $727
address $726
address $662
address $663
address $664
address $665
address $728
address $440
address $864
address $868
address $868
address $868
address $873
address $874
address $883
address $892
address $901
address $661
address $641
address $652
address $655
address $656
address $657
address $658
address $659
address $660
address $907
address $906
address $544
code
LABELV $443
line 593
;589:		//
;590:		// movement generated events
;591:		//
;592:	case EV_FOOTSTEP:
;593:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $441
line 594
;594:			trap_S_StartSound(NULL, es->number, CHAN_BODY,
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
ADDRGP4 cgs+146664+720
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 596
;595:				cgs.media.footsteps[ci->footsteps][rand() & 3]);
;596:		}
line 597
;597:		break;
ADDRGP4 $441
JUMPV
LABELV $449
line 600
;598:
;599:	case EV_FOOTSTEP_METAL:
;600:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $441
line 601
;601:			trap_S_StartSound(NULL, es->number, CHAN_BODY,
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
ADDRGP4 cgs+146664+720+80
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 603
;602:				cgs.media.footsteps[FOOTSTEP_METAL][rand() & 3]);
;603:		}
line 604
;604:		break;
ADDRGP4 $441
JUMPV
LABELV $456
line 607
;605:
;606:	case EV_FOOTSPLASH:
;607:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $441
line 608
;608:			trap_S_StartSound(NULL, es->number, CHAN_BODY,
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
ADDRGP4 cgs+146664+720+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 610
;609:				cgs.media.footsteps[FOOTSTEP_SPLASH][rand() & 3]);
;610:		}
line 611
;611:		break;
ADDRGP4 $441
JUMPV
LABELV $463
line 614
;612:
;613:	case EV_FOOTWADE:
;614:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $441
line 615
;615:			trap_S_StartSound(NULL, es->number, CHAN_BODY,
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
ADDRGP4 cgs+146664+720+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 617
;616:				cgs.media.footsteps[FOOTSTEP_SPLASH][rand() & 3]);
;617:		}
line 618
;618:		break;
ADDRGP4 $441
JUMPV
LABELV $470
line 621
;619:
;620:	case EV_SWIM:
;621:		if (cg_footsteps.integer) {
ADDRGP4 cg_footsteps+12
INDIRI4
CNSTI4 0
EQI4 $441
line 622
;622:			trap_S_StartSound(NULL, es->number, CHAN_BODY,
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
ADDRGP4 cgs+146664+720+96
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 624
;623:				cgs.media.footsteps[FOOTSTEP_SPLASH][rand() & 3]);
;624:		}
line 625
;625:		break;
ADDRGP4 $441
JUMPV
LABELV $477
line 628
;626:
;627:	case EV_FALL_SHORT:
;628:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.landSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+988
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 629
;629:		if (clientNum == cg.predictedPlayerState.clientNum) {
ADDRLP4 8
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $441
line 631
;630:			// smooth landing z changes
;631:			cg.landChange = -8;
ADDRGP4 cg+108948
CNSTF4 3238002688
ASGNF4
line 632
;632:			cg.landTime = cg.time;
ADDRGP4 cg+108952
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 633
;633:		}
line 634
;634:		break;
ADDRGP4 $441
JUMPV
LABELV $487
line 638
;635:
;636:	case EV_FALL_MEDIUM:
;637:		// use normal pain sound
;638:		trap_S_StartSound(NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, "*pain100_1.wav"));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $419
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
line 639
;639:		cent->pe.painIgnore = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 1
ASGNI4
line 640
;640:		cent->pe.painTime = cg.time;	// don't play a pain sound right after this
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 641
;641:		if (clientNum == cg.predictedPlayerState.clientNum) {
ADDRLP4 8
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $441
line 643
;642:			// smooth landing z changes
;643:			cg.landChange = -16;
ADDRGP4 cg+108948
CNSTF4 3246391296
ASGNF4
line 644
;644:			cg.landTime = cg.time;
ADDRGP4 cg+108952
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 645
;645:		}
line 646
;646:		break;
ADDRGP4 $441
JUMPV
LABELV $496
line 649
;647:
;648:	case EV_FALL_FAR:
;649:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, CG_CustomSound(es->number, "*fall1.wav"));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $497
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
line 650
;650:		cent->pe.painIgnore = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 1
ASGNI4
line 651
;651:		cent->pe.painTime = cg.time;	// don't play a pain sound right after this
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 652
;652:		if (clientNum == cg.predictedPlayerState.clientNum) {
ADDRLP4 8
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
NEI4 $441
line 654
;653:			// smooth landing z changes
;654:			cg.landChange = -24;
ADDRGP4 cg+108948
CNSTF4 3250585600
ASGNF4
line 655
;655:			cg.landTime = cg.time;
ADDRGP4 cg+108952
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 656
;656:		}
line 657
;657:		break;
ADDRGP4 $441
JUMPV
LABELV $506
line 663
;658:
;659:	case EV_STEP_4:
;660:	case EV_STEP_8:
;661:	case EV_STEP_12:
;662:	case EV_STEP_16:		// smooth out step up transitions
;663:	{
line 668
;664:		float	oldStep;
;665:		int		delta;
;666:		int		step;
;667:
;668:		if (clientNum != cg.predictedPlayerState.clientNum) {
ADDRLP4 8
INDIRI4
ADDRGP4 cg+107636+140
INDIRI4
EQI4 $507
line 669
;669:			break;
ADDRGP4 $441
JUMPV
LABELV $507
line 672
;670:		}
;671:		// if we are interpolating, we don't need to smooth steps
;672:		if (cg.demoPlayback || (cg.snap->ps.pm_flags & PMF_FOLLOW) ||
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
NEI4 $519
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $519
ADDRGP4 cg_nopredict+12
INDIRI4
CNSTI4 0
NEI4 $519
ADDRGP4 cgs+148000
INDIRI4
CNSTI4 0
EQI4 $511
LABELV $519
line 673
;673:			cg_nopredict.integer || cgs.synchronousClients) {
line 674
;674:			break;
ADDRGP4 $441
JUMPV
LABELV $511
line 677
;675:		}
;676:		// check for stepping up before a previous step is completed
;677:		delta = cg.time - cg.stepTime;
ADDRLP4 68
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+108936
INDIRI4
SUBI4
ASGNI4
line 678
;678:		if (delta < STEP_TIME) {
ADDRLP4 68
INDIRI4
CNSTI4 200
GEI4 $522
line 679
;679:			oldStep = cg.stepChange * (STEP_TIME - delta) / STEP_TIME;
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
line 680
;680:		} else {
ADDRGP4 $523
JUMPV
LABELV $522
line 681
;681:			oldStep = 0;
ADDRLP4 72
CNSTF4 0
ASGNF4
line 682
;682:		}
LABELV $523
line 685
;683:
;684:		// add this amount
;685:		step = 4 * (event - EV_STEP_4 + 1);
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
line 686
;686:		cg.stepChange = oldStep + step;
ADDRGP4 cg+108932
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 687
;687:		if (cg.stepChange > MAX_STEP_CHANGE) {
ADDRGP4 cg+108932
INDIRF4
CNSTF4 1107296256
LEF4 $526
line 688
;688:			cg.stepChange = MAX_STEP_CHANGE;
ADDRGP4 cg+108932
CNSTF4 1107296256
ASGNF4
line 689
;689:		}
LABELV $526
line 690
;690:		cg.stepTime = cg.time;
ADDRGP4 cg+108936
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 691
;691:		break;
ADDRGP4 $441
JUMPV
LABELV $532
line 696
;692:	}
;693:
;694:	case EV_JUMP_PAD:
;695:		//		CG_Printf( "EV_JUMP_PAD w/effect #%i\n", es->eventParm );
;696:	{
line 697
;697:		vec3_t			up = { 0, 0, 1 };
ADDRLP4 68
ADDRGP4 $533
INDIRB
ASGNB 12
line 700
;698:
;699:
;700:		CG_SmokePuff(cent->lerpOrigin, up,
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
ADDRGP4 cgs+146664+388
INDIRI4
ARGI4
ADDRGP4 CG_SmokePuff
CALLP4
pop
line 707
;701:			32,
;702:			1, 1, 1, 0.33f,
;703:			1000,
;704:			cg.time, 0,
;705:			LEF_PUFF_DONT_SCALE,
;706:			cgs.media.smokePuffShader);
;707:	}
line 710
;708:
;709:	// boing sound at origin, jump sound on player
;710:	trap_S_StartSound(cent->lerpOrigin, -1, CHAN_VOICE, cgs.media.jumpPadSound);
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 cgs+146664+992
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 711
;711:	trap_S_StartSound(NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, "*jump1.wav"));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $539
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
line 712
;712:	break;
ADDRGP4 $441
JUMPV
LABELV $540
line 716
;713:
;714:	case EV_JUMP:
;715:		// pain event with fast sequential jump just creates sound distortion
;716:		if (cg.time - cent->pe.painTime > 50)
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
SUBI4
CNSTI4 50
LEI4 $441
line 717
;717:			trap_S_StartSound(NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, "*jump1.wav"));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $539
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
line 718
;718:		break;
ADDRGP4 $441
JUMPV
LABELV $544
line 721
;719:
;720:	case EV_TAUNT:
;721:		trap_S_StartSound(NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, "*taunt.wav"));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $545
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
line 722
;722:		break;
ADDRGP4 $441
JUMPV
LABELV $546
line 725
;723:
;724:	case EV_WATER_TOUCH:
;725:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.watrInSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1112
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 726
;726:		break;
ADDRGP4 $441
JUMPV
LABELV $549
line 729
;727:
;728:	case EV_WATER_LEAVE:
;729:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.watrOutSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1116
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 730
;730:		break;
ADDRGP4 $441
JUMPV
LABELV $552
line 733
;731:
;732:	case EV_WATER_UNDER:
;733:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.watrUnSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1120
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 734
;734:		break;
ADDRGP4 $441
JUMPV
LABELV $555
line 737
;735:
;736:	case EV_WATER_CLEAR:
;737:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, CG_CustomSound(es->number, "*gasp.wav"));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $556
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
line 738
;738:		break;
ADDRGP4 $441
JUMPV
LABELV $557
line 741
;739:
;740:	case EV_ITEM_PICKUP:
;741:	{
line 745
;742:		gitem_t *item;
;743:		int		index;
;744:
;745:		index = es->eventParm;		// player predicted
ADDRLP4 84
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 747
;746:
;747:		if (index < 1 || index >= bg_numItems) {
ADDRLP4 92
ADDRLP4 84
INDIRI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 1
LTI4 $560
ADDRLP4 92
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $558
LABELV $560
line 748
;748:			break;
ADDRGP4 $441
JUMPV
LABELV $558
line 751
;749:		}
;750:
;751:		if (entityNum >= 0) {
ADDRFP4 8
INDIRI4
CNSTI4 0
LTI4 $561
line 753
;752:			// our predicted entity
;753:			ce = cg_entities + entityNum;
ADDRLP4 40
ADDRFP4 8
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 754
;754:			if (ce->delaySpawn > cg.time && ce->delaySpawnPlayed) {
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
LEI4 $562
ADDRLP4 96
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
CNSTI4 0
EQI4 $562
line 755
;755:				break; // delay item pickup
ADDRGP4 $441
JUMPV
line 757
;756:			}
;757:		} else {
LABELV $561
line 758
;758:			ce = NULL;
ADDRLP4 40
CNSTP4 0
ASGNP4
line 759
;759:		}
LABELV $562
line 761
;760:
;761:		item = &bg_itemlist[index];
ADDRLP4 88
ADDRLP4 84
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 765
;762:
;763:		// powerups and team items will have a separate global sound, this one
;764:		// will be played at prediction time
;765:		if (item->giType == IT_POWERUP || item->giType == IT_TEAM) {
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
EQI4 $568
ADDRLP4 96
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $566
LABELV $568
line 766
;766:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.n_healthSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1292
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 767
;767:		} else if (item->giType == IT_PERSISTANT_POWERUP) {
ADDRGP4 $567
JUMPV
LABELV $566
ADDRLP4 88
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 7
NEI4 $571
line 768
;768:			switch (item->giTag) {
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
LTI4 $572
ADDRLP4 100
INDIRI4
CNSTI4 13
GTI4 $572
ADDRLP4 100
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $588-40
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $588
address $576
address $579
address $582
address $585
code
LABELV $576
line 770
;769:			case PW_SCOUT:
;770:				trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.scoutSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1268
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 771
;771:				break;
ADDRGP4 $572
JUMPV
LABELV $579
line 773
;772:			case PW_GUARD:
;773:				trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.guardSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1264
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 774
;774:				break;
ADDRGP4 $572
JUMPV
LABELV $582
line 776
;775:			case PW_DOUBLER:
;776:				trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.doublerSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1260
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 777
;777:				break;
ADDRGP4 $572
JUMPV
LABELV $585
line 779
;778:			case PW_ARMORREGEN:
;779:				trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.ammoregenSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1256
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 780
;780:				break;
line 782
;781:			}
;782:		} else {
ADDRGP4 $572
JUMPV
LABELV $571
line 783
;783:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, trap_S_RegisterSound(item->pickup_sound, qfalse));
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
line 784
;784:		}
LABELV $572
LABELV $567
line 787
;785:
;786:		// show icon and name on status bar
;787:		if (es->number == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $590
line 788
;788:			CG_ItemPickup(index);
ADDRLP4 84
INDIRI4
ARGI4
ADDRGP4 CG_ItemPickup
CALLV
pop
line 789
;789:		}
LABELV $590
line 791
;790:
;791:		if (ce) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $441
line 792
;792:			ce->delaySpawnPlayed = qtrue;
ADDRLP4 40
INDIRP4
CNSTI4 452
ADDP4
CNSTI4 1
ASGNI4
line 793
;793:		}
line 794
;794:	}
line 795
;795:	break;
ADDRGP4 $441
JUMPV
LABELV $595
line 798
;796:
;797:	case EV_GLOBAL_ITEM_PICKUP:
;798:	{
line 802
;799:		gitem_t *item;
;800:		int		index;
;801:
;802:		index = es->eventParm;		// player predicted
ADDRLP4 84
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 804
;803:
;804:		if (index < 1 || index >= bg_numItems) {
ADDRLP4 92
ADDRLP4 84
INDIRI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 1
LTI4 $598
ADDRLP4 92
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $596
LABELV $598
line 805
;805:			break;
ADDRGP4 $441
JUMPV
LABELV $596
line 808
;806:		}
;807:
;808:		if (entityNum >= 0) {
ADDRFP4 8
INDIRI4
CNSTI4 0
LTI4 $599
line 810
;809:			// our predicted entity
;810:			ce = cg_entities + entityNum;
ADDRLP4 40
ADDRFP4 8
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 811
;811:			if (ce->delaySpawn > cg.time && ce->delaySpawnPlayed) {
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
LEI4 $600
ADDRLP4 96
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
CNSTI4 0
EQI4 $600
line 812
;812:				break;
ADDRGP4 $441
JUMPV
line 814
;813:			}
;814:		} else {
LABELV $599
line 815
;815:			ce = NULL;
ADDRLP4 40
CNSTP4 0
ASGNP4
line 816
;816:		}
LABELV $600
line 818
;817:
;818:		item = &bg_itemlist[index];
ADDRLP4 88
ADDRLP4 84
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 820
;819:		// powerup pickups are global
;820:		if (item->pickup_sound) {
ADDRLP4 88
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $604
line 821
;821:			trap_S_StartSound(NULL, cg.snap->ps.clientNum, CHAN_AUTO, trap_S_RegisterSound(item->pickup_sound, qfalse));
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
line 822
;822:		}
LABELV $604
line 825
;823:
;824:		// show icon and name on status bar
;825:		if (es->number == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $607
line 826
;826:			CG_ItemPickup(index);
ADDRLP4 84
INDIRI4
ARGI4
ADDRGP4 CG_ItemPickup
CALLV
pop
line 827
;827:		}
LABELV $607
line 829
;828:
;829:		if (ce) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $441
line 830
;830:			ce->delaySpawnPlayed = qtrue;
ADDRLP4 40
INDIRP4
CNSTI4 452
ADDP4
CNSTI4 1
ASGNI4
line 831
;831:		}
line 832
;832:	}
line 833
;833:	break;
ADDRGP4 $441
JUMPV
LABELV $612
line 840
;834:
;835:	//
;836:	// weapon events
;837:	//
;838:	case EV_NOAMMO:
;839:		//		trap_S_StartSound (NULL, es->number, CHAN_AUTO, cgs.media.noAmmoSound );
;840:		if (es->number == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $441
line 841
;841:			CG_OutOfAmmoChange();
ADDRGP4 CG_OutOfAmmoChange
CALLV
pop
line 842
;842:		}
line 843
;843:		break;
ADDRGP4 $441
JUMPV
LABELV $616
line 846
;844:
;845:	case EV_CHANGE_WEAPON:
;846:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.selectSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+708
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 847
;847:		break;
ADDRGP4 $441
JUMPV
LABELV $619
line 850
;848:
;849:	case EV_FIRE_WEAPON:
;850:		CG_FireWeapon(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_FireWeapon
CALLV
pop
line 851
;851:		break;
ADDRGP4 $441
JUMPV
LABELV $620
line 869
;852:
;853:	case EV_USE_ITEM0:
;854:	case EV_USE_ITEM1:
;855:	case EV_USE_ITEM2:
;856:	case EV_USE_ITEM3:
;857:	case EV_USE_ITEM4:
;858:	case EV_USE_ITEM5:
;859:	case EV_USE_ITEM6:
;860:	case EV_USE_ITEM7:
;861:	case EV_USE_ITEM8:
;862:	case EV_USE_ITEM9:
;863:	case EV_USE_ITEM10:
;864:	case EV_USE_ITEM11:
;865:	case EV_USE_ITEM12:
;866:	case EV_USE_ITEM13:
;867:	case EV_USE_ITEM14:
;868:	case EV_USE_ITEM15:
;869:		CG_UseItem(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_UseItem
CALLV
pop
line 870
;870:		break;
ADDRGP4 $441
JUMPV
LABELV $621
line 878
;871:
;872:		//=================================================================
;873:
;874:		//
;875:		// other events
;876:		//
;877:	case EV_PLAYER_TELEPORT_IN:
;878:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.teleInSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+968
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 879
;879:		CG_SpawnEffect(position);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_SpawnEffect
CALLV
pop
line 880
;880:		break;
ADDRGP4 $441
JUMPV
LABELV $624
line 883
;881:
;882:	case EV_PLAYER_TELEPORT_OUT:
;883:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.teleOutSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+972
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 884
;884:		CG_SpawnEffect(position);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_SpawnEffect
CALLV
pop
line 885
;885:		break;
ADDRGP4 $441
JUMPV
LABELV $627
line 888
;886:
;887:	case EV_ITEM_POP:
;888:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.respawnSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+980
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 889
;889:		break;
ADDRGP4 $441
JUMPV
LABELV $630
line 892
;890:
;891:	case EV_ITEM_RESPAWN:
;892:		cent->miscTime = cg.time;	// scale up from this
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 893
;893:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.respawnSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+980
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 894
;894:		break;
ADDRGP4 $441
JUMPV
LABELV $634
line 897
;895:
;896:	case EV_GRENADE_BOUNCE:
;897:		if (rand() & 1) {
ADDRLP4 84
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $635
line 898
;898:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.hgrenb1aSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1296
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 899
;899:		} else {
ADDRGP4 $441
JUMPV
LABELV $635
line 900
;900:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.hgrenb2aSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1300
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 901
;901:		}
line 902
;902:		break;
ADDRGP4 $441
JUMPV
LABELV $641
line 905
;903:
;904:	case EV_PROXIMITY_MINE_STICK:
;905:		if (es->eventParm & SURF_FLESH) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $642
line 906
;906:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.wstbimplSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1304
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 907
;907:		} else 	if (es->eventParm & SURF_METALSTEPS) {
ADDRGP4 $441
JUMPV
LABELV $642
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $646
line 908
;908:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.wstbimpmSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1308
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 909
;909:		} else {
ADDRGP4 $441
JUMPV
LABELV $646
line 910
;910:			trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.wstbimpdSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1312
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 911
;911:		}
line 912
;912:		break;
ADDRGP4 $441
JUMPV
LABELV $652
line 915
;913:
;914:	case EV_PROXIMITY_MINE_TRIGGER:
;915:		trap_S_StartSound(NULL, es->number, CHAN_AUTO, cgs.media.wstbactvSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 cgs+146664+1316
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 916
;916:		break;
ADDRGP4 $441
JUMPV
LABELV $655
line 919
;917:
;918:	case EV_KAMIKAZE:
;919:		CG_KamikazeEffect(cent->lerpOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 CG_KamikazeEffect
CALLV
pop
line 920
;920:		break;
ADDRGP4 $441
JUMPV
LABELV $656
line 923
;921:
;922:	case EV_OBELISKEXPLODE:
;923:		CG_ObeliskExplode(cent->lerpOrigin, es->eventParm);
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
line 924
;924:		break;
ADDRGP4 $441
JUMPV
LABELV $657
line 927
;925:
;926:	case EV_OBELISKPAIN:
;927:		CG_ObeliskPain(cent->lerpOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 CG_ObeliskPain
CALLV
pop
line 928
;928:		break;
ADDRGP4 $441
JUMPV
LABELV $658
line 931
;929:
;930:	case EV_INVUL_IMPACT:
;931:		CG_InvulnerabilityImpact(cent->lerpOrigin, cent->currentState.angles);
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
line 932
;932:		break;
ADDRGP4 $441
JUMPV
LABELV $659
line 935
;933:
;934:	case EV_JUICED:
;935:		CG_InvulnerabilityJuiced(cent->lerpOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 CG_InvulnerabilityJuiced
CALLV
pop
line 936
;936:		break;
ADDRGP4 $441
JUMPV
LABELV $660
line 939
;937:
;938:	case EV_LIGHTNINGBOLT:
;939:		CG_LightningBoltBeam(es->origin2, es->pos.trBase);
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
line 940
;940:		break;
ADDRGP4 $441
JUMPV
LABELV $661
line 943
;941:
;942:	case EV_SCOREPLUM:
;943:		CG_ScorePlum(cent->currentState.otherEntityNum, cent->lerpOrigin, cent->currentState.time);
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
line 944
;944:		break;
ADDRGP4 $441
JUMPV
LABELV $662
line 950
;945:
;946:		//
;947:		// missile impacts
;948:		//
;949:	case EV_MISSILE_HIT:
;950:		ByteToDir(es->eventParm, dir);
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
line 951
;951:		CG_MissileHitPlayer(es->weapon, position, dir, es->otherEntityNum);
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
line 952
;952:		break;
ADDRGP4 $441
JUMPV
LABELV $663
line 955
;953:
;954:	case EV_MISSILE_MISS:
;955:		ByteToDir(es->eventParm, dir);
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
line 956
;956:		CG_MissileHitWall(es->weapon, 0, position, dir, IMPACTSOUND_DEFAULT);
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
line 957
;957:		break;
ADDRGP4 $441
JUMPV
LABELV $664
line 960
;958:
;959:	case EV_MISSILE_MISS_METAL:
;960:		ByteToDir(es->eventParm, dir);
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
line 961
;961:		CG_MissileHitWall(es->weapon, 0, position, dir, IMPACTSOUND_METAL);
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
line 962
;962:		break;
ADDRGP4 $441
JUMPV
LABELV $665
line 965
;963:
;964:	case EV_RAILTRAIL:
;965:		cent->currentState.weapon = WP_RAILGUN;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 7
ASGNI4
line 967
;966:
;967:		if (cent->currentState.clientNum == cg.snap->ps.clientNum && !cg_thirdPerson.integer) {
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
NEI4 $666
ADDRGP4 cg_thirdPerson+12
INDIRI4
CNSTI4 0
NEI4 $666
line 968
;968:			VectorCopy(cg.refdef.vieworg, vec);
ADDRLP4 16
ADDRGP4 cg+109056+24
INDIRB
ASGNB 12
line 969
;969:			fovOffset = -0.2f * (cgs.fov - 90.0f);
ADDRLP4 48
ADDRGP4 cgs+147984
INDIRF4
CNSTF4 1119092736
SUBF4
CNSTF4 3192704205
MULF4
ASGNF4
line 972
;970:
;971:			// 13.5, -5.5, -6.0
;972:			VectorMA(vec, cg_gun_x.value + 13.5f, cg.refdef.viewaxis[0], vec);
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
line 973
;973:			VectorMA(vec, cg_gun_y.value - 5.5f, cg.refdef.viewaxis[1], vec);
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
line 974
;974:			VectorMA(vec, cg_gun_z.value + fovOffset - 6.0f, cg.refdef.viewaxis[2], vec);
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
line 975
;975:		} else
ADDRGP4 $667
JUMPV
LABELV $666
line 976
;976:			VectorCopy(es->origin2, vec);
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
LABELV $667
line 979
;977:
;978:		// if the end was on a nomark surface, don't make an explosion
;979:		CG_RailTrail(ci, vec, es->pos.trBase);
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
line 981
;980:
;981:		if (es->eventParm != 255) {
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 255
EQI4 $441
line 982
;982:			ByteToDir(es->eventParm, dir);
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
line 983
;983:			CG_MissileHitWall(es->weapon, es->clientNum, position, dir, IMPACTSOUND_DEFAULT);
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
line 984
;984:		}
line 985
;985:		break;
ADDRGP4 $441
JUMPV
LABELV $726
line 988
;986:
;987:	case EV_BULLET_HIT_WALL:
;988:		ByteToDir(es->eventParm, dir);
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
line 989
;989:		CG_Bullet(es->pos.trBase, es->otherEntityNum, dir, qfalse, ENTITYNUM_WORLD);
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
line 990
;990:		break;
ADDRGP4 $441
JUMPV
LABELV $727
line 993
;991:
;992:	case EV_BULLET_HIT_FLESH:
;993:		CG_Bullet(es->pos.trBase, es->otherEntityNum, dir, qtrue, es->eventParm);
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
line 994
;994:		break;
ADDRGP4 $441
JUMPV
LABELV $728
line 997
;995:
;996:	case EV_SHOTGUN:
;997:		CG_ShotgunFire(es);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_ShotgunFire
CALLV
pop
line 998
;998:		break;
ADDRGP4 $441
JUMPV
LABELV $729
line 1001
;999:
;1000:	case EV_GENERAL_SOUND:
;1001:		if (cgs.gameSounds[es->eventParm]) {
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
EQI4 $730
line 1002
;1002:			trap_S_StartSound(NULL, es->number, CHAN_VOICE, cgs.gameSounds[es->eventParm]);
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
line 1003
;1003:		} else {
ADDRGP4 $441
JUMPV
LABELV $730
line 1004
;1004:			s = CG_ConfigString(CS_SOUNDS + es->eventParm);
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 273
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
line 1005
;1005:			trap_S_StartSound(NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, s));
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
line 1006
;1006:		}
line 1007
;1007:		break;
ADDRGP4 $441
JUMPV
LABELV $734
line 1010
;1008:
;1009:	case EV_GLOBAL_SOUND:	// play from the player's head so it never diminishes
;1010:		if (cgs.gameSounds[es->eventParm]) {
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
EQI4 $735
line 1011
;1011:			trap_S_StartSound(NULL, cg.snap->ps.clientNum, CHAN_AUTO, cgs.gameSounds[es->eventParm]);
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
line 1012
;1012:		} else {
ADDRGP4 $441
JUMPV
LABELV $735
line 1013
;1013:			s = CG_ConfigString(CS_SOUNDS + es->eventParm);
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 273
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
line 1014
;1014:			trap_S_StartSound(NULL, cg.snap->ps.clientNum, CHAN_AUTO, CG_CustomSound(es->number, s));
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
line 1015
;1015:		}
line 1016
;1016:		break;
ADDRGP4 $441
JUMPV
LABELV $741
line 1019
;1017:
;1018:	case EV_GLOBAL_TEAM_SOUND:	// play from the player's head so it never diminishes
;1019:	{
line 1020
;1020:		switch (es->eventParm) {
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
LTI4 $441
ADDRLP4 112
INDIRI4
CNSTI4 13
GTI4 $441
ADDRLP4 112
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $863
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $863
address $745
address $753
address $761
address $771
address $781
address $807
address $833
address $839
address $845
address $848
address $851
address $854
address $857
address $860
code
LABELV $745
line 1022
;1021:		case GTS_RED_CAPTURE: // CTF: red team captured the blue flag, 1FCTF: red team captured the neutral flag
;1022:			if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED)
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $746
line 1023
;1023:				CG_AddBufferedSound(cgs.media.captureYourTeamSound);
ADDRGP4 cgs+146664+1156
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $441
JUMPV
LABELV $746
line 1025
;1024:			else
;1025:				CG_AddBufferedSound(cgs.media.captureOpponentSound);
ADDRGP4 cgs+146664+1160
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1026
;1026:			break;
ADDRGP4 $441
JUMPV
LABELV $753
line 1028
;1027:		case GTS_BLUE_CAPTURE: // CTF: blue team captured the red flag, 1FCTF: blue team captured the neutral flag
;1028:			if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE)
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $754
line 1029
;1029:				CG_AddBufferedSound(cgs.media.captureYourTeamSound);
ADDRGP4 cgs+146664+1156
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $441
JUMPV
LABELV $754
line 1031
;1030:			else
;1031:				CG_AddBufferedSound(cgs.media.captureOpponentSound);
ADDRGP4 cgs+146664+1160
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1032
;1032:			break;
ADDRGP4 $441
JUMPV
LABELV $761
line 1034
;1033:		case GTS_RED_RETURN: // CTF: blue flag returned, 1FCTF: never used
;1034:			if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED)
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $762
line 1035
;1035:				CG_AddBufferedSound(cgs.media.returnYourTeamSound);
ADDRGP4 cgs+146664+1164
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $763
JUMPV
LABELV $762
line 1037
;1036:			else
;1037:				CG_AddBufferedSound(cgs.media.returnOpponentSound);
ADDRGP4 cgs+146664+1168
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
LABELV $763
line 1039
;1038:			//
;1039:			CG_AddBufferedSound(cgs.media.blueFlagReturnedSound);
ADDRGP4 cgs+146664+1184
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1040
;1040:			break;
ADDRGP4 $441
JUMPV
LABELV $771
line 1042
;1041:		case GTS_BLUE_RETURN: // CTF red flag returned, 1FCTF: neutral flag returned
;1042:			if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE)
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $772
line 1043
;1043:				CG_AddBufferedSound(cgs.media.returnYourTeamSound);
ADDRGP4 cgs+146664+1164
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $773
JUMPV
LABELV $772
line 1045
;1044:			else
;1045:				CG_AddBufferedSound(cgs.media.returnOpponentSound);
ADDRGP4 cgs+146664+1168
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
LABELV $773
line 1047
;1046:			//
;1047:			CG_AddBufferedSound(cgs.media.redFlagReturnedSound);
ADDRGP4 cgs+146664+1180
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1048
;1048:			break;
ADDRGP4 $441
JUMPV
LABELV $781
line 1052
;1049:
;1050:		case GTS_RED_TAKEN: // CTF: red team took blue flag, 1FCTF: blue team took the neutral flag
;1051:			// if this player picked up the flag then a sound is played in CG_CheckLocalSounds
;1052:			if (cg.snap->ps.powerups[PW_BLUEFLAG] || cg.snap->ps.powerups[PW_NEUTRALFLAG]) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
NEI4 $786
ADDRGP4 cg+36
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
CNSTI4 0
EQI4 $782
LABELV $786
line 1053
;1053:			} else {
ADDRGP4 $441
JUMPV
LABELV $782
line 1054
;1054:				if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $787
line 1055
;1055:					if (cgs.gametype == GT_ONEFLAG)
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 6
NEI4 $790
line 1056
;1056:						CG_AddBufferedSound(cgs.media.yourTeamTookTheFlagSound);
ADDRGP4 cgs+146664+1204
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $441
JUMPV
LABELV $790
line 1058
;1057:					else
;1058:						CG_AddBufferedSound(cgs.media.enemyTookYourFlagSound);
ADDRGP4 cgs+146664+1192
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1059
;1059:				} else if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
ADDRGP4 $441
JUMPV
LABELV $787
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $441
line 1060
;1060:					if (cgs.gametype == GT_ONEFLAG)
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 6
NEI4 $800
line 1061
;1061:						CG_AddBufferedSound(cgs.media.enemyTookTheFlagSound);
ADDRGP4 cgs+146664+1196
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $441
JUMPV
LABELV $800
line 1063
;1062:					else
;1063:						CG_AddBufferedSound(cgs.media.yourTeamTookEnemyFlagSound);
ADDRGP4 cgs+146664+1200
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1064
;1064:				}
line 1065
;1065:			}
line 1066
;1066:			break;
ADDRGP4 $441
JUMPV
LABELV $807
line 1069
;1067:		case GTS_BLUE_TAKEN: // CTF: blue team took the red flag, 1FCTF red team took the neutral flag
;1068:			// if this player picked up the flag then a sound is played in CG_CheckLocalSounds
;1069:			if (cg.snap->ps.powerups[PW_REDFLAG] || cg.snap->ps.powerups[PW_NEUTRALFLAG]) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
NEI4 $812
ADDRGP4 cg+36
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
CNSTI4 0
EQI4 $808
LABELV $812
line 1070
;1070:			} else {
ADDRGP4 $441
JUMPV
LABELV $808
line 1071
;1071:				if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $813
line 1072
;1072:					if (cgs.gametype == GT_ONEFLAG)
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 6
NEI4 $816
line 1073
;1073:						CG_AddBufferedSound(cgs.media.yourTeamTookTheFlagSound);
ADDRGP4 cgs+146664+1204
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $441
JUMPV
LABELV $816
line 1075
;1074:					else
;1075:						CG_AddBufferedSound(cgs.media.enemyTookYourFlagSound);
ADDRGP4 cgs+146664+1192
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1076
;1076:				} else if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
ADDRGP4 $441
JUMPV
LABELV $813
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $441
line 1077
;1077:					if (cgs.gametype == GT_ONEFLAG)
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 6
NEI4 $826
line 1078
;1078:						CG_AddBufferedSound(cgs.media.enemyTookTheFlagSound);
ADDRGP4 cgs+146664+1196
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
ADDRGP4 $441
JUMPV
LABELV $826
line 1080
;1079:					else
;1080:						CG_AddBufferedSound(cgs.media.yourTeamTookEnemyFlagSound);
ADDRGP4 cgs+146664+1200
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1081
;1081:				}
line 1082
;1082:			}
line 1083
;1083:			break;
ADDRGP4 $441
JUMPV
LABELV $833
line 1086
;1084:
;1085:		case GTS_REDOBELISK_ATTACKED: // Overload: red obelisk is being attacked
;1086:			if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $441
line 1087
;1087:				CG_AddBufferedSound(cgs.media.yourBaseIsUnderAttackSound);
ADDRGP4 cgs+146664+1212
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1088
;1088:			}
line 1089
;1089:			break;
ADDRGP4 $441
JUMPV
LABELV $839
line 1091
;1090:		case GTS_BLUEOBELISK_ATTACKED: // Overload: blue obelisk is being attacked
;1091:			if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $441
line 1092
;1092:				CG_AddBufferedSound(cgs.media.yourBaseIsUnderAttackSound);
ADDRGP4 cgs+146664+1212
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1093
;1093:			}
line 1094
;1094:			break;
ADDRGP4 $441
JUMPV
LABELV $845
line 1097
;1095:
;1096:		case GTS_REDTEAM_SCORED:
;1097:			CG_AddBufferedSound(cgs.media.redScoredSound);
ADDRGP4 cgs+146664+1136
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1098
;1098:			break;
ADDRGP4 $441
JUMPV
LABELV $848
line 1100
;1099:		case GTS_BLUETEAM_SCORED:
;1100:			CG_AddBufferedSound(cgs.media.blueScoredSound);
ADDRGP4 cgs+146664+1140
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1101
;1101:			break;
ADDRGP4 $441
JUMPV
LABELV $851
line 1103
;1102:		case GTS_REDTEAM_TOOK_LEAD:
;1103:			CG_AddBufferedSound(cgs.media.redLeadsSound);
ADDRGP4 cgs+146664+1144
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1104
;1104:			break;
ADDRGP4 $441
JUMPV
LABELV $854
line 1106
;1105:		case GTS_BLUETEAM_TOOK_LEAD:
;1106:			CG_AddBufferedSound(cgs.media.blueLeadsSound);
ADDRGP4 cgs+146664+1148
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1107
;1107:			break;
ADDRGP4 $441
JUMPV
LABELV $857
line 1109
;1108:		case GTS_TEAMS_ARE_TIED:
;1109:			CG_AddBufferedSound(cgs.media.teamsTiedSound);
ADDRGP4 cgs+146664+1152
INDIRI4
ARGI4
ADDRGP4 CG_AddBufferedSound
CALLV
pop
line 1110
;1110:			break;
ADDRGP4 $441
JUMPV
LABELV $860
line 1112
;1111:		case GTS_KAMIKAZE:
;1112:			trap_S_StartLocalSound(cgs.media.kamikazeFarSound, CHAN_ANNOUNCER);
ADDRGP4 cgs+146664+904
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1113
;1113:			break;
line 1115
;1114:		default:
;1115:			break;
line 1117
;1116:		}
;1117:		break;
ADDRGP4 $441
JUMPV
LABELV $864
line 1123
;1118:	}
;1119:
;1120:	case EV_PAIN:
;1121:		// local player sounds are triggered in CG_CheckLocalSounds,
;1122:		// so ignore events on the player
;1123:		if (cent->currentState.number != cg.snap->ps.clientNum) {
ADDRFP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
EQI4 $441
line 1124
;1124:			CG_PainEvent(cent, es->eventParm);
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
line 1125
;1125:		}
line 1126
;1126:		break;
ADDRGP4 $441
JUMPV
LABELV $868
line 1131
;1127:
;1128:	case EV_DEATH1:
;1129:	case EV_DEATH2:
;1130:	case EV_DEATH3:
;1131:		if (CG_WaterLevel(cent) == 3) {
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
NEI4 $869
line 1132
;1132:			trap_S_StartSound(NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, "*drown.wav"));
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 $871
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
line 1133
;1133:		} else {
ADDRGP4 $441
JUMPV
LABELV $869
line 1134
;1134:			trap_S_StartSound(NULL, es->number, CHAN_VOICE, CG_CustomSound(es->number, va("*death%i.wav", event - EV_DEATH1 + 1)));
ADDRGP4 $872
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
line 1135
;1135:		}
line 1137
;1136:
;1137:		break;
ADDRGP4 $441
JUMPV
LABELV $873
line 1140
;1138:
;1139:	case EV_OBITUARY:
;1140:		CG_Obituary(es);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Obituary
CALLV
pop
line 1141
;1141:		break;
ADDRGP4 $441
JUMPV
LABELV $874
line 1147
;1142:
;1143:		//
;1144:		// powerup events
;1145:		//
;1146:	case EV_POWERUP_QUAD:
;1147:		if (es->number == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $875
line 1148
;1148:			cg.powerupActive = PW_QUAD;
ADDRGP4 cg+125480
CNSTI4 1
ASGNI4
line 1149
;1149:			cg.powerupTime = cg.time;
ADDRGP4 cg+125484
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1150
;1150:		}
LABELV $875
line 1151
;1151:		trap_S_StartSound(NULL, es->number, CHAN_ITEM, cgs.media.quadSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+146664+700
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1152
;1152:		break;
ADDRGP4 $441
JUMPV
LABELV $883
line 1155
;1153:
;1154:	case EV_POWERUP_BATTLESUIT:
;1155:		if (es->number == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $884
line 1156
;1156:			cg.powerupActive = PW_BATTLESUIT;
ADDRGP4 cg+125480
CNSTI4 2
ASGNI4
line 1157
;1157:			cg.powerupTime = cg.time;
ADDRGP4 cg+125484
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1158
;1158:		}
LABELV $884
line 1159
;1159:		trap_S_StartSound(NULL, es->number, CHAN_ITEM, cgs.media.protectSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+146664+1288
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1160
;1160:		break;
ADDRGP4 $441
JUMPV
LABELV $892
line 1163
;1161:
;1162:	case EV_POWERUP_REGEN:
;1163:		if (es->number == cg.snap->ps.clientNum) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $893
line 1164
;1164:			cg.powerupActive = PW_REGEN;
ADDRGP4 cg+125480
CNSTI4 5
ASGNI4
line 1165
;1165:			cg.powerupTime = cg.time;
ADDRGP4 cg+125484
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1166
;1166:		}
LABELV $893
line 1167
;1167:		trap_S_StartSound(NULL, es->number, CHAN_ITEM, cgs.media.regenSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+146664+1284
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1168
;1168:		break;
ADDRGP4 $441
JUMPV
LABELV $901
line 1174
;1169:
;1170:	case EV_GIB_PLAYER:
;1171:		// don't play gib sound when using the kamikaze because it interferes
;1172:		// with the kamikaze sound, downside is that the gib sound will also
;1173:		// not be played when someone is gibbed while just carrying the kamikaze
;1174:		if (!(es->eFlags & EF_KAMIKAZE)) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $902
line 1175
;1175:			trap_S_StartSound(NULL, es->number, CHAN_BODY, cgs.media.gibSound);
CNSTP4 0
ARGP4
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
ADDRGP4 cgs+146664+952
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 1176
;1176:		}
LABELV $902
line 1177
;1177:		CG_GibPlayer(cent->lerpOrigin);
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRGP4 CG_GibPlayer
CALLV
pop
line 1178
;1178:		break;
ADDRGP4 $441
JUMPV
LABELV $906
line 1181
;1179:
;1180:	case EV_STOPLOOPINGSOUND:
;1181:		trap_S_StopLoopingSound(es->number);
ADDRLP4 0
INDIRP4
INDIRI4
ARGI4
ADDRGP4 trap_S_StopLoopingSound
CALLV
pop
line 1182
;1182:		es->loopSound = 0;
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 1183
;1183:		break;
ADDRGP4 $441
JUMPV
LABELV $907
line 1186
;1184:
;1185:	case EV_DEBUG_LINE:
;1186:		CG_Beam(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Beam
CALLV
pop
line 1187
;1187:		break;
ADDRGP4 $441
JUMPV
LABELV $440
line 1190
;1188:
;1189:	default:
;1190:		CG_Error("Unknown event: %i", event);
ADDRGP4 $430
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1191
;1191:		break;
LABELV $441
line 1193
;1192:	}
;1193:}
LABELV $427
endproc CG_EntityEvent 124 48
export CG_CheckEvents
proc CG_CheckEvents 8 12
line 1202
;1194:
;1195:
;1196:/*
;1197:==============
;1198:CG_CheckEvents
;1199:
;1200:==============
;1201:*/
;1202:void CG_CheckEvents(centity_t *cent) {
line 1204
;1203:	// check for event-only entities
;1204:	if (cent->currentState.eType > ET_EVENTS) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
LEI4 $911
line 1205
;1205:		if (cent->previousEvent) {
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
CNSTI4 0
EQI4 $913
line 1206
;1206:			return;	// already fired
ADDRGP4 $910
JUMPV
LABELV $913
line 1209
;1207:		}
;1208:		// if this is a player event set the entity number of the client entity number
;1209:		if (cent->currentState.eFlags & EF_PLAYER_EVENT) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $915
line 1210
;1210:			cent->currentState.number = cent->currentState.otherEntityNum;
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
line 1211
;1211:		}
LABELV $915
line 1213
;1212:
;1213:		cent->previousEvent = 1;
ADDRFP4 0
INDIRP4
CNSTI4 428
ADDP4
CNSTI4 1
ASGNI4
line 1215
;1214:
;1215:		cent->currentState.event = cent->currentState.eType - ET_EVENTS;
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
line 1216
;1216:	} else {
ADDRGP4 $912
JUMPV
LABELV $911
line 1218
;1217:		// check for events riding with another entity
;1218:		if (cent->currentState.event == cent->previousEvent) {
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
NEI4 $917
line 1219
;1219:			return;
ADDRGP4 $910
JUMPV
LABELV $917
line 1221
;1220:		}
;1221:		cent->previousEvent = cent->currentState.event;
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
line 1222
;1222:		if ((cent->currentState.event & ~EV_EVENT_BITS) == 0) {
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
CNSTI4 0
NEI4 $919
line 1223
;1223:			return;
ADDRGP4 $910
JUMPV
LABELV $919
line 1225
;1224:		}
;1225:	}
LABELV $912
line 1228
;1226:
;1227:	// calculate the position at exactly the frame time
;1228:	BG_EvaluateTrajectory(&cent->currentState.pos, cg.snap->serverTime, cent->lerpOrigin);
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
line 1229
;1229:	CG_SetEntitySoundPosition(cent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_SetEntitySoundPosition
CALLV
pop
line 1231
;1230:
;1231:	CG_EntityEvent(cent, cent->lerpOrigin, -1);
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
line 1232
;1232:}
LABELV $910
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
LABELV $872
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
LABELV $871
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
LABELV $556
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
LABELV $545
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
LABELV $539
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
LABELV $497
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
LABELV $434
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
LABELV $430
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
LABELV $425
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
LABELV $424
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
LABELV $419
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
LABELV $418
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
LABELV $415
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
LABELV $412
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
LABELV $348
byte 1 85
byte 1 115
byte 1 101
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $347
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
LABELV $337
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
LABELV $325
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
LABELV $320
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
LABELV $319
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $317
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
LABELV $316
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
LABELV $314
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
LABELV $312
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
LABELV $311
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
LABELV $309
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
LABELV $308
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
LABELV $306
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
LABELV $305
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
LABELV $303
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
LABELV $301
byte 1 39
byte 1 115
byte 1 32
byte 1 66
byte 1 70
byte 1 71
byte 1 0
align 1
LABELV $300
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
LABELV $298
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $296
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
LABELV $294
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
LABELV $291
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
LABELV $290
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
LABELV $288
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
LABELV $286
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
LABELV $284
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
LABELV $283
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
LABELV $281
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
LABELV $280
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $278
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
LABELV $276
byte 1 39
byte 1 115
byte 1 32
byte 1 72
byte 1 77
byte 1 71
byte 1 0
align 1
LABELV $275
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 114
byte 1 105
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 117
byte 1 112
byte 1 32
byte 1 98
byte 1 121
byte 1 0
align 1
LABELV $273
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
LABELV $271
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
LABELV $269
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
LABELV $248
byte 1 110
byte 1 111
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $245
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $242
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 37
byte 1 115
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
LABELV $233
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $231
byte 1 102
byte 1 114
byte 1 111
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $230
byte 1 116
byte 1 104
byte 1 97
byte 1 119
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $214
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $208
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
LABELV $207
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
LABELV $204
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
LABELV $201
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
LABELV $200
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
LABELV $197
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
LABELV $193
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
LABELV $191
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
LABELV $190
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
LABELV $187
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
LABELV $183
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 103
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
LABELV $182
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 103
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
LABELV $179
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 103
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
LABELV $175
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
LABELV $174
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
LABELV $171
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
LABELV $167
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
LABELV $166
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
LABELV $163
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
LABELV $159
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
LABELV $151
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
LABELV $149
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
LABELV $147
byte 1 119
byte 1 97
byte 1 115
byte 1 32
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 45
byte 1 116
byte 1 104
byte 1 97
byte 1 119
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $145
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $143
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
LABELV $141
byte 1 109
byte 1 101
byte 1 108
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $139
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
LABELV $137
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
LABELV $135
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
LABELV $133
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
LABELV $128
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $127
byte 1 110
byte 1 0
align 1
LABELV $120
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
LABELV $115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $114
byte 1 37
byte 1 105
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $113
byte 1 37
byte 1 105
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $110
byte 1 37
byte 1 105
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $107
byte 1 37
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $104
byte 1 49
byte 1 51
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $101
byte 1 49
byte 1 50
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $98
byte 1 49
byte 1 49
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $95
byte 1 94
byte 1 51
byte 1 51
byte 1 114
byte 1 100
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $92
byte 1 94
byte 1 49
byte 1 50
byte 1 110
byte 1 100
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $89
byte 1 94
byte 1 52
byte 1 49
byte 1 115
byte 1 116
byte 1 94
byte 1 55
byte 1 0
align 1
LABELV $86
byte 1 0
align 1
LABELV $85
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

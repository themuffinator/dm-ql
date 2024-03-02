export BotAI_Print
code
proc BotAI_Print 2056 12
file "..\..\..\..\code\game\ai_main.c"
line 75
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:/*****************************************************************************
;5: * name:		ai_main.c
;6: *
;7: * desc:		Quake3 bot AI
;8: *
;9: * $Archive: /MissionPack/code/game/ai_main.c $
;10: *
;11: *****************************************************************************/
;12:
;13:
;14:#include "g_local.h"
;15:#include "q_shared.h"
;16:#include "botlib.h"		//bot lib interface
;17:#include "be_aas.h"
;18:#include "be_ea.h"
;19:#include "be_ai_char.h"
;20:#include "be_ai_chat.h"
;21:#include "be_ai_gen.h"
;22:#include "be_ai_goal.h"
;23:#include "be_ai_move.h"
;24:#include "be_ai_weap.h"
;25://
;26:#include "ai_main.h"
;27:#include "ai_dmq3.h"
;28:#include "ai_chat.h"
;29:#include "ai_cmd.h"
;30:#include "ai_dmnet.h"
;31:#include "ai_vcmd.h"
;32:
;33://
;34:#include "chars.h"
;35:#include "inv.h"
;36:#include "syn.h"
;37:
;38:#define MAX_PATH		144
;39:
;40://bot states
;41:bot_state_t	*botstates[MAX_CLIENTS];
;42://number of bots
;43:int numbots;
;44://floating point time
;45:float floattime;
;46://time to do a regular update
;47:float regularupdate_time;
;48://
;49:int bot_interbreed;
;50:int bot_interbreedmatchcount;
;51://
;52:vmCvar_t bot_thinktime;
;53:vmCvar_t bot_memorydump;
;54:vmCvar_t bot_saveroutingcache;
;55:vmCvar_t bot_pause;
;56:vmCvar_t bot_report;
;57:vmCvar_t bot_testsolid;
;58:vmCvar_t bot_testclusters;
;59:vmCvar_t bot_developer;
;60:vmCvar_t bot_interbreedchar;
;61:vmCvar_t bot_interbreedbots;
;62:vmCvar_t bot_interbreedcycle;
;63:vmCvar_t bot_interbreedwrite;
;64:
;65:char mapname[MAX_QPATH];
;66:
;67:void ExitLevel( void );
;68:
;69:
;70:/*
;71:==================
;72:BotAI_Print
;73:==================
;74:*/
;75:void QDECL BotAI_Print( int type, const char *fmt, ... ) {
line 79
;76:	char str[2048];
;77:	va_list ap;
;78:
;79:	va_start(ap, fmt);
ADDRLP4 0
ADDRFP4 4+4
ASGNP4
line 80
;80:	ED_vsprintf(str, fmt, ap);
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
line 81
;81:	va_end(ap);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 83
;82:
;83:	switch(type) {
ADDRLP4 2052
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 2052
INDIRI4
CNSTI4 1
LTI4 $58
ADDRLP4 2052
INDIRI4
CNSTI4 5
GTI4 $58
ADDRLP4 2052
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $71-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $71
address $60
address $62
address $64
address $66
address $68
code
LABELV $60
line 84
;84:		case PRT_MESSAGE: {
line 85
;85:			G_Printf("%s", str);
ADDRGP4 $61
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 86
;86:			break;
ADDRGP4 $59
JUMPV
LABELV $62
line 88
;87:		}
;88:		case PRT_WARNING: {
line 89
;89:			G_Printf( S_COLOR_YELLOW "Warning: %s", str );
ADDRGP4 $63
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 90
;90:			break;
ADDRGP4 $59
JUMPV
LABELV $64
line 92
;91:		}
;92:		case PRT_ERROR: {
line 93
;93:			G_Printf( S_COLOR_RED "Error: %s", str );
ADDRGP4 $65
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 94
;94:			break;
ADDRGP4 $59
JUMPV
LABELV $66
line 96
;95:		}
;96:		case PRT_FATAL: {
line 97
;97:			G_Printf( S_COLOR_RED "Fatal: %s", str );
ADDRGP4 $67
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 98
;98:			break;
ADDRGP4 $59
JUMPV
LABELV $68
line 100
;99:		}
;100:		case PRT_EXIT: {
line 101
;101:			G_Error( S_COLOR_RED "Exit: %s", str );
ADDRGP4 $69
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 102
;102:			break;
ADDRGP4 $59
JUMPV
LABELV $58
line 104
;103:		}
;104:		default: {
line 105
;105:			G_Printf( "unknown print type\n" );
ADDRGP4 $70
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 106
;106:			break;
LABELV $59
line 109
;107:		}
;108:	}
;109:}
LABELV $56
endproc BotAI_Print 2056 12
export BotAI_Trace
proc BotAI_Trace 56 28
line 117
;110:
;111:
;112:/*
;113:==================
;114:BotAI_Trace
;115:==================
;116:*/
;117:void BotAI_Trace(bsp_trace_t *bsptrace, vec3_t start, vec3_t mins, vec3_t maxs, vec3_t end, int passent, int contentmask) {
line 120
;118:	trace_t trace;
;119:
;120:	trap_Trace(&trace, start, mins, maxs, end, passent, contentmask);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 122
;121:	//copy the trace information
;122:	bsptrace->allsolid = trace.allsolid;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRI4
ASGNI4
line 123
;123:	bsptrace->startsolid = trace.startsolid;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0+4
INDIRI4
ASGNI4
line 124
;124:	bsptrace->fraction = trace.fraction;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0+8
INDIRF4
ASGNF4
line 125
;125:	VectorCopy(trace.endpos, bsptrace->endpos);
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 0+12
INDIRB
ASGNB 12
line 126
;126:	bsptrace->plane.dist = trace.plane.dist;
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 0+24+12
INDIRF4
ASGNF4
line 127
;127:	VectorCopy(trace.plane.normal, bsptrace->plane.normal);
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 128
;128:	bsptrace->plane.signbits = trace.plane.signbits;
ADDRFP4 0
INDIRP4
CNSTI4 41
ADDP4
ADDRLP4 0+24+17
INDIRU1
ASGNU1
line 129
;129:	bsptrace->plane.type = trace.plane.type;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 0+24+16
INDIRU1
ASGNU1
line 130
;130:	bsptrace->surface.value = 0;
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 131
;131:	bsptrace->surface.flags = trace.surfaceFlags;
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 0+44
INDIRI4
ASGNI4
line 132
;132:	bsptrace->ent = trace.entityNum;
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 0+52
INDIRI4
ASGNI4
line 133
;133:	bsptrace->exp_dist = 0;
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTF4 0
ASGNF4
line 134
;134:	bsptrace->sidenum = 0;
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 135
;135:	bsptrace->contents = trace.contents;
ADDRFP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 0+48
INDIRI4
ASGNI4
line 136
;136:}
LABELV $73
endproc BotAI_Trace 56 28
export BotAI_GetClientState
proc BotAI_GetClientState 4 12
line 143
;137:
;138:/*
;139:==================
;140:BotAI_GetClientState
;141:==================
;142:*/
;143:int BotAI_GetClientState( int clientNum, playerState_t *state ) {
line 146
;144:	gentity_t	*ent;
;145:
;146:	ent = &g_entities[clientNum];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 832
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 147
;147:	if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $88
line 148
;148:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $87
JUMPV
LABELV $88
line 150
;149:	}
;150:	if ( !ent->client ) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $90
line 151
;151:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $87
JUMPV
LABELV $90
line 154
;152:	}
;153:
;154:	memcpy( state, &ent->client->ps, sizeof(playerState_t) );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
CNSTI4 468
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 155
;155:	return qtrue;
CNSTI4 1
RETI4
LABELV $87
endproc BotAI_GetClientState 4 12
export BotAI_GetEntityState
proc BotAI_GetEntityState 8 12
line 164
;156:}
;157:
;158:
;159:/*
;160:==================
;161:BotAI_GetEntityState
;162:==================
;163:*/
;164:qboolean BotAI_GetEntityState( int entityNum, entityState_t *state ) {
line 167
;165:	const gentity_t *ent;
;166:
;167:	ent = g_entities + entityNum;
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 832
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 169
;168:
;169:	if ( !ent->inuse || !ent->r.linked ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $95
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
NEI4 $93
LABELV $95
line 170
;170:		memset( state, 0, sizeof( entityState_t ) );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 208
ARGI4
ADDRGP4 memset
CALLP4
pop
line 171
;171:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $92
JUMPV
LABELV $93
line 174
;172:	}
;173:
;174:	if ( ent->r.svFlags & SVF_NOCLIENT ) {
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $96
line 175
;175:		memset( state, 0, sizeof( entityState_t ) );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 208
ARGI4
ADDRGP4 memset
CALLP4
pop
line 176
;176:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $92
JUMPV
LABELV $96
line 179
;177:	}
;178:
;179:	memcpy( state, &ent->s, sizeof(entityState_t) );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 208
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 180
;180:	return qtrue;
CNSTI4 1
RETI4
LABELV $92
endproc BotAI_GetEntityState 8 12
export BotAI_GetSnapshotEntity
proc BotAI_GetSnapshotEntity 8 12
line 189
;181:}
;182:
;183:
;184:/*
;185:==================
;186:BotAI_GetSnapshotEntity
;187:==================
;188:*/
;189:int BotAI_GetSnapshotEntity( int clientNum, int sequence, entityState_t *state ) {
line 192
;190:	int		entNum;
;191:
;192:	entNum = trap_BotGetSnapshotEntity( clientNum, sequence );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 trap_BotGetSnapshotEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 193
;193:	if ( entNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $99
line 194
;194:		memset(state, 0, sizeof(entityState_t));
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 208
ARGI4
ADDRGP4 memset
CALLP4
pop
line 195
;195:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $98
JUMPV
LABELV $99
line 198
;196:	}
;197:
;198:	BotAI_GetEntityState( entNum, state );
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 BotAI_GetEntityState
CALLI4
pop
line 200
;199:
;200:	return sequence + 1;
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
RETI4
LABELV $98
endproc BotAI_GetSnapshotEntity 8 12
export BotAI_BotInitialChat
proc BotAI_BotInitialChat 56 44
line 209
;201:}
;202:
;203:
;204:/*
;205:==================
;206:BotAI_BotInitialChat
;207:==================
;208:*/
;209:void QDECL BotAI_BotInitialChat( bot_state_t *bs, char *type, ... ) {
line 215
;210:	int		i, mcontext;
;211:	va_list	ap;
;212:	char	*p;
;213:	char	*vars[MAX_MATCHVARIABLES];
;214:
;215:	memset(vars, 0, sizeof(vars));
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 memset
CALLP4
pop
line 216
;216:	va_start(ap, type);
ADDRLP4 40
ADDRFP4 4+4
ASGNP4
line 217
;217:	p = va_arg(ap, char *);
ADDRLP4 48
ADDRLP4 40
INDIRP4
CNSTU4 4
ADDP4
ASGNP4
ADDRLP4 40
ADDRLP4 48
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 48
INDIRP4
CNSTI4 -4
ADDP4
INDIRP4
ASGNP4
line 218
;218:	for (i = 0; i < MAX_MATCHVARIABLES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $103
line 219
;219:		if( !p ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $107
line 220
;220:			break;
ADDRGP4 $105
JUMPV
LABELV $107
line 222
;221:		}
;222:		vars[i] = p;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 223
;223:		p = va_arg(ap, char *);
ADDRLP4 52
ADDRLP4 40
INDIRP4
CNSTU4 4
ADDP4
ASGNP4
ADDRLP4 40
ADDRLP4 52
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 52
INDIRP4
CNSTI4 -4
ADDP4
INDIRP4
ASGNP4
line 224
;224:	}
LABELV $104
line 218
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $103
LABELV $105
line 225
;225:	va_end(ap);
ADDRLP4 40
CNSTP4 0
ASGNP4
line 227
;226:
;227:	mcontext = BotSynonymContext(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 BotSynonymContext
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 52
INDIRI4
ASGNI4
line 229
;228:
;229:	trap_BotInitialChat( bs->cs, type, mcontext, vars[0], vars[1], vars[2], vars[3], vars[4], vars[5], vars[6], vars[7] );
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8+4
INDIRP4
ARGP4
ADDRLP4 8+8
INDIRP4
ARGP4
ADDRLP4 8+12
INDIRP4
ARGP4
ADDRLP4 8+16
INDIRP4
ARGP4
ADDRLP4 8+20
INDIRP4
ARGP4
ADDRLP4 8+24
INDIRP4
ARGP4
ADDRLP4 8+28
INDIRP4
ARGP4
ADDRGP4 trap_BotInitialChat
CALLV
pop
line 230
;230:}
LABELV $101
endproc BotAI_BotInitialChat 56 44
export BotTestAAS
proc BotTestAAS 64 16
line 238
;231:
;232:
;233:/*
;234:==================
;235:BotTestAAS
;236:==================
;237:*/
;238:void BotTestAAS(vec3_t origin) {
line 242
;239:	int areanum;
;240:	aas_areainfo_t info;
;241:
;242:	trap_Cvar_Update(&bot_testsolid);
ADDRGP4 bot_testsolid
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 243
;243:	trap_Cvar_Update(&bot_testclusters);
ADDRGP4 bot_testclusters
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 244
;244:	if (bot_testsolid.integer) {
ADDRGP4 bot_testsolid+12
INDIRI4
CNSTI4 0
EQI4 $117
line 245
;245:		if (!trap_AAS_Initialized()) return;
ADDRLP4 56
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $120
ADDRGP4 $116
JUMPV
LABELV $120
line 246
;246:		areanum = BotPointAreaNum(origin);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 60
INDIRI4
ASGNI4
line 247
;247:		if (areanum) BotAI_Print(PRT_MESSAGE, "\rempty area");
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $122
CNSTI4 1
ARGI4
ADDRGP4 $124
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
ADDRGP4 $118
JUMPV
LABELV $122
line 248
;248:		else BotAI_Print(PRT_MESSAGE, "\r^1SOLID area");
CNSTI4 1
ARGI4
ADDRGP4 $125
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 249
;249:	}
ADDRGP4 $118
JUMPV
LABELV $117
line 250
;250:	else if (bot_testclusters.integer) {
ADDRGP4 bot_testclusters+12
INDIRI4
CNSTI4 0
EQI4 $126
line 251
;251:		if (!trap_AAS_Initialized()) return;
ADDRLP4 56
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $129
ADDRGP4 $116
JUMPV
LABELV $129
line 252
;252:		areanum = BotPointAreaNum(origin);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 60
INDIRI4
ASGNI4
line 253
;253:		if (!areanum)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $131
line 254
;254:			BotAI_Print(PRT_MESSAGE, "\r^1Solid!                              ");
CNSTI4 1
ARGI4
ADDRGP4 $133
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
ADDRGP4 $132
JUMPV
LABELV $131
line 255
;255:		else {
line 256
;256:			trap_AAS_AreaInfo(areanum, &info);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_AAS_AreaInfo
CALLI4
pop
line 257
;257:			BotAI_Print(PRT_MESSAGE, "\rarea %d, cluster %d       ", areanum, info.cluster);
CNSTI4 1
ARGI4
ADDRGP4 $134
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4+12
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 258
;258:		}
LABELV $132
line 259
;259:	}
LABELV $126
LABELV $118
line 260
;260:}
LABELV $116
endproc BotTestAAS 64 16
export BotReportStatus
proc BotReportStatus 560 24
line 267
;261:
;262:/*
;263:==================
;264:BotReportStatus
;265:==================
;266:*/
;267:void BotReportStatus(bot_state_t *bs) {
line 272
;268:	char goalname[MAX_MESSAGE_SIZE];
;269:	char netname[MAX_MESSAGE_SIZE];
;270:	char *leader, flagstatus[32];
;271:	//
;272:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 273
;273:	if (Q_stricmp(netname, bs->teamleader) == 0) leader = "L";
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 548
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 548
INDIRI4
CNSTI4 0
NEI4 $137
ADDRLP4 288
ADDRGP4 $139
ASGNP4
ADDRGP4 $138
JUMPV
LABELV $137
line 274
;274:	else leader = " ";
ADDRLP4 288
ADDRGP4 $140
ASGNP4
LABELV $138
line 276
;275:
;276:	strcpy(flagstatus, "  ");
ADDRLP4 256
ARGP4
ADDRGP4 $141
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 277
;277:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $142
line 278
;278:		if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 552
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 552
INDIRI4
CNSTI4 0
EQI4 $143
line 279
;279:			if (BotTeam(bs) == TEAM_RED) strcpy(flagstatus, S_COLOR_RED"F ");
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 556
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 556
INDIRI4
CNSTI4 1
NEI4 $146
ADDRLP4 256
ARGP4
ADDRGP4 $148
ARGP4
ADDRGP4 strcpy
CALLP4
pop
ADDRGP4 $143
JUMPV
LABELV $146
line 280
;280:			else strcpy(flagstatus, S_COLOR_BLUE"F ");
ADDRLP4 256
ARGP4
ADDRGP4 $149
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 281
;281:		}
line 282
;282:	} else if (gametype == GT_ONEFLAG) {
ADDRGP4 $143
JUMPV
LABELV $142
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $150
line 283
;283:		if (Bot1FCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 552
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 552
INDIRI4
CNSTI4 0
EQI4 $151
line 284
;284:			if (BotTeam(bs) == TEAM_RED) strcpy(flagstatus, S_COLOR_RED"F ");
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 556
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 556
INDIRI4
CNSTI4 1
NEI4 $154
ADDRLP4 256
ARGP4
ADDRGP4 $148
ARGP4
ADDRGP4 strcpy
CALLP4
pop
ADDRGP4 $151
JUMPV
LABELV $154
line 285
;285:			else strcpy(flagstatus, S_COLOR_BLUE"F ");
ADDRLP4 256
ARGP4
ADDRGP4 $149
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 286
;286:		}
line 287
;287:	} else if (gametype == GT_HARVESTER) {
ADDRGP4 $151
JUMPV
LABELV $150
ADDRGP4 gametype
INDIRI4
CNSTI4 8
NEI4 $156
line 288
;288:		if (BotHarvesterCarryingSkulls(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 552
ADDRGP4 BotHarvesterCarryingSkulls
CALLI4
ASGNI4
ADDRLP4 552
INDIRI4
CNSTI4 0
EQI4 $158
line 289
;289:			if (BotTeam(bs) == TEAM_RED) Com_sprintf(flagstatus, sizeof(flagstatus), S_COLOR_RED"%2d", bs->inventory[INVENTORY_RED_SKULL]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 556
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 556
INDIRI4
CNSTI4 1
NEI4 $160
ADDRLP4 256
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $162
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 5168
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
ADDRGP4 $161
JUMPV
LABELV $160
line 290
;290:			else Com_sprintf(flagstatus, sizeof(flagstatus), S_COLOR_BLUE"%2d", bs->inventory[INVENTORY_BLUE_SKULL]);
ADDRLP4 256
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $163
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 5172
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
LABELV $161
line 291
;291:		}
LABELV $158
line 292
;292:	}
LABELV $156
LABELV $151
LABELV $143
line 294
;293:
;294:	switch(bs->ltgtype) {
ADDRLP4 552
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
ADDRLP4 552
INDIRI4
CNSTI4 1
LTI4 $164
ADDRLP4 552
INDIRI4
CNSTI4 13
GTI4 $164
ADDRLP4 552
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $192-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $192
address $167
address $169
address $171
address $181
address $183
address $185
address $177
address $177
address $179
address $173
address $175
address $189
address $187
code
LABELV $167
line 296
;295:		case LTG_TEAMHELP:
;296:		{
line 297
;297:			EasyClientName(bs->teammate, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 298
;298:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: helping %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $168
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 299
;299:			break;
ADDRGP4 $165
JUMPV
LABELV $169
line 302
;300:		}
;301:		case LTG_TEAMACCOMPANY:
;302:		{
line 303
;303:			EasyClientName(bs->teammate, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 304
;304:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: accompanying %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $170
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 305
;305:			break;
ADDRGP4 $165
JUMPV
LABELV $171
line 308
;306:		}
;307:		case LTG_DEFENDKEYAREA:
;308:		{
line 309
;309:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 310
;310:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: defending %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $172
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 311
;311:			break;
ADDRGP4 $165
JUMPV
LABELV $173
line 314
;312:		}
;313:		case LTG_GETITEM:
;314:		{
line 315
;315:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 316
;316:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: getting item %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $174
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 317
;317:			break;
ADDRGP4 $165
JUMPV
LABELV $175
line 320
;318:		}
;319:		case LTG_KILL:
;320:		{
line 321
;321:			ClientName(bs->teamgoal.entitynum, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6664
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 322
;322:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: killing %s\n", netname, leader, flagstatus, goalname);
CNSTI4 1
ARGI4
ADDRGP4 $176
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 323
;323:			break;
ADDRGP4 $165
JUMPV
LABELV $177
line 327
;324:		}
;325:		case LTG_CAMP:
;326:		case LTG_CAMPORDER:
;327:		{
line 328
;328:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: camping\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $178
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 329
;329:			break;
ADDRGP4 $165
JUMPV
LABELV $179
line 332
;330:		}
;331:		case LTG_PATROL:
;332:		{
line 333
;333:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: patrolling\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $180
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 334
;334:			break;
ADDRGP4 $165
JUMPV
LABELV $181
line 337
;335:		}
;336:		case LTG_GETFLAG:
;337:		{
line 338
;338:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: capturing flag\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $182
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 339
;339:			break;
ADDRGP4 $165
JUMPV
LABELV $183
line 342
;340:		}
;341:		case LTG_RUSHBASE:
;342:		{
line 343
;343:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: rushing base\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $184
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 344
;344:			break;
ADDRGP4 $165
JUMPV
LABELV $185
line 347
;345:		}
;346:		case LTG_RETURNFLAG:
;347:		{
line 348
;348:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: returning flag\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $186
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 349
;349:			break;
ADDRGP4 $165
JUMPV
LABELV $187
line 352
;350:		}
;351:		case LTG_ATTACKENEMYBASE:
;352:		{
line 353
;353:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: attacking the enemy base\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $188
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 354
;354:			break;
ADDRGP4 $165
JUMPV
LABELV $189
line 357
;355:		}
;356:		case LTG_HARVEST:
;357:		{
line 358
;358:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: harvesting\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $190
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 359
;359:			break;
ADDRGP4 $165
JUMPV
LABELV $164
line 362
;360:		}
;361:		default:
;362:		{
line 363
;363:			BotAI_Print(PRT_MESSAGE, "%-20s%s%s: roaming\n", netname, leader, flagstatus);
CNSTI4 1
ARGI4
ADDRGP4 $191
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 288
INDIRP4
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 364
;364:			break;
LABELV $165
line 367
;365:		}
;366:	}
;367:}
LABELV $136
endproc BotReportStatus 560 24
export BotTeamplayReport
proc BotTeamplayReport 1048 12
line 374
;368:
;369:/*
;370:==================
;371:BotTeamplayReport
;372:==================
;373:*/
;374:void BotTeamplayReport(void) {
line 378
;375:	int i;
;376:	char buf[MAX_INFO_STRING];
;377:
;378:	BotAI_Print(PRT_MESSAGE, S_COLOR_RED"RED\n");
CNSTI4 1
ARGI4
ADDRGP4 $195
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 379
;379:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $199
JUMPV
LABELV $196
line 381
;380:		//
;381:		if ( !botstates[i] || !botstates[i]->inuse ) continue;
ADDRLP4 1032
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1032
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $203
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1032
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $201
LABELV $203
ADDRGP4 $197
JUMPV
LABELV $201
line 383
;382:		//
;383:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
CNSTI4 529
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 385
;384:		//if no config string or no name
;385:		if (!buf[0] || !*Info_ValueForKey(buf, "n")) continue;
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $207
ADDRLP4 4
ARGP4
ADDRGP4 $206
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $204
LABELV $207
ADDRGP4 $197
JUMPV
LABELV $204
line 387
;386:		//skip spectators
;387:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_RED) {
ADDRLP4 4
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 1040
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1044
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 1
NEI4 $208
line 388
;388:			BotReportStatus(botstates[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotReportStatus
CALLV
pop
line 389
;389:		}
LABELV $208
line 390
;390:	}
LABELV $197
line 379
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $199
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $196
line 391
;391:	BotAI_Print(PRT_MESSAGE, S_COLOR_BLUE"BLUE\n");
CNSTI4 1
ARGI4
ADDRGP4 $211
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 392
;392:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $215
JUMPV
LABELV $212
line 394
;393:		//
;394:		if ( !botstates[i] || !botstates[i]->inuse ) continue;
ADDRLP4 1032
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1032
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $219
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1032
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $217
LABELV $219
ADDRGP4 $213
JUMPV
LABELV $217
line 396
;395:		//
;396:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
CNSTI4 529
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 398
;397:		//if no config string or no name
;398:		if (!buf[0] || !*Info_ValueForKey(buf, "n")) continue;
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $222
ADDRLP4 4
ARGP4
ADDRGP4 $206
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $220
LABELV $222
ADDRGP4 $213
JUMPV
LABELV $220
line 400
;399:		//skip spectators
;400:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_BLUE) {
ADDRLP4 4
ARGP4
ADDRGP4 $210
ARGP4
ADDRLP4 1040
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1044
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 2
NEI4 $223
line 401
;401:			BotReportStatus(botstates[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotReportStatus
CALLV
pop
line 402
;402:		}
LABELV $223
line 403
;403:	}
LABELV $213
line 392
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $215
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $212
line 404
;404:}
LABELV $194
endproc BotTeamplayReport 1048 12
export BotSetInfoConfigString
proc BotSetInfoConfigString 880 16
line 411
;405:
;406:/*
;407:==================
;408:BotSetInfoConfigString
;409:==================
;410:*/
;411:void BotSetInfoConfigString(bot_state_t *bs) {
line 418
;412:	char goalname[MAX_MESSAGE_SIZE];
;413:	char netname[MAX_MESSAGE_SIZE];
;414:	char action[MAX_MESSAGE_SIZE];
;415:	char *leader, carrying[32], *cs;
;416:	bot_goal_t goal;
;417:	//
;418:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 256
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 419
;419:	if (Q_stricmp(netname, bs->teamleader) == 0) leader = "L";
ADDRLP4 256
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 864
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 864
INDIRI4
CNSTI4 0
NEI4 $226
ADDRLP4 544
ADDRGP4 $139
ASGNP4
ADDRGP4 $227
JUMPV
LABELV $226
line 420
;420:	else leader = " ";
ADDRLP4 544
ADDRGP4 $140
ASGNP4
LABELV $227
line 422
;421:
;422:	strcpy(carrying, "  ");
ADDRLP4 512
ARGP4
ADDRGP4 $141
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 423
;423:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $228
line 424
;424:		if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 868
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 868
INDIRI4
CNSTI4 0
EQI4 $229
line 425
;425:			strcpy(carrying, "F ");
ADDRLP4 512
ARGP4
ADDRGP4 $232
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 426
;426:		}
line 427
;427:	} else if (gametype == GT_ONEFLAG) {
ADDRGP4 $229
JUMPV
LABELV $228
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $233
line 428
;428:		if (Bot1FCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 868
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 868
INDIRI4
CNSTI4 0
EQI4 $234
line 429
;429:			strcpy(carrying, "F ");
ADDRLP4 512
ARGP4
ADDRGP4 $232
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 430
;430:		}
line 431
;431:	} else if (gametype == GT_HARVESTER) {
ADDRGP4 $234
JUMPV
LABELV $233
ADDRGP4 gametype
INDIRI4
CNSTI4 8
NEI4 $237
line 432
;432:		if (BotHarvesterCarryingSkulls(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 868
ADDRGP4 BotHarvesterCarryingSkulls
CALLI4
ASGNI4
ADDRLP4 868
INDIRI4
CNSTI4 0
EQI4 $239
line 433
;433:			if (BotTeam(bs) == TEAM_RED) Com_sprintf(carrying, sizeof(carrying), "%2d", bs->inventory[INVENTORY_RED_SKULL]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 872
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 872
INDIRI4
CNSTI4 1
NEI4 $241
ADDRLP4 512
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $243
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 5168
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
ADDRGP4 $242
JUMPV
LABELV $241
line 434
;434:			else Com_sprintf(carrying, sizeof(carrying), "%2d", bs->inventory[INVENTORY_BLUE_SKULL]);
ADDRLP4 512
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $243
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 5172
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
LABELV $242
line 435
;435:		}
LABELV $239
line 436
;436:	}
LABELV $237
LABELV $234
LABELV $229
line 438
;437:
;438:	switch(bs->ltgtype) {
ADDRLP4 868
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
ADDRLP4 868
INDIRI4
CNSTI4 1
LTI4 $244
ADDRLP4 868
INDIRI4
CNSTI4 13
GTI4 $244
ADDRLP4 868
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $273-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $273
address $247
address $249
address $251
address $261
address $263
address $265
address $257
address $257
address $259
address $253
address $255
address $269
address $267
code
LABELV $247
line 440
;439:		case LTG_TEAMHELP:
;440:		{
line 441
;441:			EasyClientName(bs->teammate, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 442
;442:			Com_sprintf(action, sizeof(action), "helping %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $248
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 443
;443:			break;
ADDRGP4 $245
JUMPV
LABELV $249
line 446
;444:		}
;445:		case LTG_TEAMACCOMPANY:
;446:		{
line 447
;447:			EasyClientName(bs->teammate, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 EasyClientName
CALLP4
pop
line 448
;448:			Com_sprintf(action, sizeof(action), "accompanying %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $250
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 449
;449:			break;
ADDRGP4 $245
JUMPV
LABELV $251
line 452
;450:		}
;451:		case LTG_DEFENDKEYAREA:
;452:		{
line 453
;453:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 454
;454:			Com_sprintf(action, sizeof(action), "defending %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $252
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 455
;455:			break;
ADDRGP4 $245
JUMPV
LABELV $253
line 458
;456:		}
;457:		case LTG_GETITEM:
;458:		{
line 459
;459:			trap_BotGoalName(bs->teamgoal.number, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 460
;460:			Com_sprintf(action, sizeof(action), "getting item %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $254
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 461
;461:			break;
ADDRGP4 $245
JUMPV
LABELV $255
line 464
;462:		}
;463:		case LTG_KILL:
;464:		{
line 465
;465:			ClientName(bs->teamgoal.entitynum, goalname, sizeof(goalname));
ADDRFP4 0
INDIRP4
CNSTI4 6664
ADDP4
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 466
;466:			Com_sprintf(action, sizeof(action), "killing %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $256
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 467
;467:			break;
ADDRGP4 $245
JUMPV
LABELV $257
line 471
;468:		}
;469:		case LTG_CAMP:
;470:		case LTG_CAMPORDER:
;471:		{
line 472
;472:			Com_sprintf(action, sizeof(action), "camping");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $258
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 473
;473:			break;
ADDRGP4 $245
JUMPV
LABELV $259
line 476
;474:		}
;475:		case LTG_PATROL:
;476:		{
line 477
;477:			Com_sprintf(action, sizeof(action), "patrolling");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $260
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 478
;478:			break;
ADDRGP4 $245
JUMPV
LABELV $261
line 481
;479:		}
;480:		case LTG_GETFLAG:
;481:		{
line 482
;482:			Com_sprintf(action, sizeof(action), "capturing flag");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $262
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 483
;483:			break;
ADDRGP4 $245
JUMPV
LABELV $263
line 486
;484:		}
;485:		case LTG_RUSHBASE:
;486:		{
line 487
;487:			Com_sprintf(action, sizeof(action), "rushing base");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $264
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 488
;488:			break;
ADDRGP4 $245
JUMPV
LABELV $265
line 491
;489:		}
;490:		case LTG_RETURNFLAG:
;491:		{
line 492
;492:			Com_sprintf(action, sizeof(action), "returning flag");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $266
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 493
;493:			break;
ADDRGP4 $245
JUMPV
LABELV $267
line 496
;494:		}
;495:		case LTG_ATTACKENEMYBASE:
;496:		{
line 497
;497:			Com_sprintf(action, sizeof(action), "attacking the enemy base");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $268
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 498
;498:			break;
ADDRGP4 $245
JUMPV
LABELV $269
line 501
;499:		}
;500:		case LTG_HARVEST:
;501:		{
line 502
;502:			Com_sprintf(action, sizeof(action), "harvesting");
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $270
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 503
;503:			break;
ADDRGP4 $245
JUMPV
LABELV $244
line 506
;504:		}
;505:		default:
;506:		{
line 507
;507:			trap_BotGetTopGoal(bs->gs, &goal);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRLP4 808
ARGP4
ADDRGP4 trap_BotGetTopGoal
CALLI4
pop
line 508
;508:			trap_BotGoalName(goal.number, goalname, sizeof(goalname));
ADDRLP4 808+44
INDIRI4
ARGI4
ADDRLP4 552
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGoalName
CALLV
pop
line 509
;509:			Com_sprintf(action, sizeof(action), "roaming %s", goalname);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $272
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 510
;510:			break;
LABELV $245
line 513
;511:		}
;512:	}
;513:  	cs = va("l\\%s\\c\\%s\\a\\%s",
ADDRGP4 $275
ARGP4
ADDRLP4 544
INDIRP4
ARGP4
ADDRLP4 512
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 876
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 548
ADDRLP4 876
INDIRP4
ASGNP4
line 517
;514:				leader,
;515:				carrying,
;516:				action);
;517:  	trap_SetConfigstring (CS_BOTINFO + bs->client, cs);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 714
ADDI4
ARGI4
ADDRLP4 548
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 518
;518:}
LABELV $225
endproc BotSetInfoConfigString 880 16
export BotUpdateInfoConfigStrings
proc BotUpdateInfoConfigStrings 1040 12
line 525
;519:
;520:/*
;521:==============
;522:BotUpdateInfoConfigStrings
;523:==============
;524:*/
;525:void BotUpdateInfoConfigStrings(void) {
line 529
;526:	int i;
;527:	char buf[MAX_INFO_STRING];
;528:
;529:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $280
JUMPV
LABELV $277
line 531
;530:		//
;531:		if ( !botstates[i] || !botstates[i]->inuse )
ADDRLP4 1032
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1032
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $284
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1032
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $282
LABELV $284
line 532
;532:			continue;
ADDRGP4 $278
JUMPV
LABELV $282
line 534
;533:		//
;534:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
CNSTI4 529
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 536
;535:		//if no config string or no name
;536:		if (!buf[0] || !*Info_ValueForKey(buf, "n"))
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $287
ADDRLP4 4
ARGP4
ADDRGP4 $206
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $285
LABELV $287
line 537
;537:			continue;
ADDRGP4 $278
JUMPV
LABELV $285
line 538
;538:		BotSetInfoConfigString(botstates[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotSetInfoConfigString
CALLV
pop
line 539
;539:	}
LABELV $278
line 529
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $280
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $277
line 540
;540:}
LABELV $276
endproc BotUpdateInfoConfigStrings 1040 12
export BotInterbreedBots
proc BotInterbreedBots 288 20
line 547
;541:
;542:/*
;543:==============
;544:BotInterbreedBots
;545:==============
;546:*/
;547:void BotInterbreedBots(void) {
line 553
;548:	float ranks[MAX_CLIENTS];
;549:	int parent1, parent2, child;
;550:	int i;
;551:
;552:	// get rankings for all the bots
;553:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $289
line 554
;554:		if ( botstates[i] && botstates[i]->inuse ) {
ADDRLP4 276
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 276
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $293
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 276
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $293
line 555
;555:			ranks[i] = botstates[i]->num_kills * 2 - botstates[i]->num_deaths;
ADDRLP4 284
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 284
INDIRP4
ADDP4
INDIRP4
CNSTI4 6032
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 284
INDIRP4
ADDP4
INDIRP4
CNSTI4 6028
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 556
;556:		}
ADDRGP4 $294
JUMPV
LABELV $293
line 557
;557:		else {
line 558
;558:			ranks[i] = -1;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 3212836864
ASGNF4
line 559
;559:		}
LABELV $294
line 560
;560:	}
LABELV $290
line 553
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $289
line 562
;561:
;562:	if (trap_GeneticParentsAndChildSelection(MAX_CLIENTS, ranks, &parent1, &parent2, &child)) {
CNSTI4 64
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 264
ARGP4
ADDRLP4 268
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 272
ADDRGP4 trap_GeneticParentsAndChildSelection
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
EQI4 $295
line 563
;563:		trap_BotInterbreedGoalFuzzyLogic(botstates[parent1]->gs, botstates[parent2]->gs, botstates[child]->gs);
ADDRLP4 276
ADDRGP4 botstates
ASGNP4
ADDRLP4 264
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 276
INDIRP4
ADDP4
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRLP4 268
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 276
INDIRP4
ADDP4
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 276
INDIRP4
ADDP4
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotInterbreedGoalFuzzyLogic
CALLV
pop
line 564
;564:		trap_BotMutateGoalFuzzyLogic(botstates[child]->gs, 1);
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_BotMutateGoalFuzzyLogic
CALLV
pop
line 565
;565:	}
LABELV $295
line 567
;566:	// reset the kills and deaths
;567:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $297
line 568
;568:		if (botstates[i] && botstates[i]->inuse) {
ADDRLP4 280
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 280
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $301
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 280
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $301
line 569
;569:			botstates[i]->num_kills = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 6032
ADDP4
CNSTI4 0
ASGNI4
line 570
;570:			botstates[i]->num_deaths = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 6028
ADDP4
CNSTI4 0
ASGNI4
line 571
;571:		}
LABELV $301
line 572
;572:	}
LABELV $298
line 567
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $297
line 573
;573:}
LABELV $288
endproc BotInterbreedBots 288 20
export BotWriteInterbreeded
proc BotWriteInterbreeded 32 8
line 580
;574:
;575:/*
;576:==============
;577:BotWriteInterbreeded
;578:==============
;579:*/
;580:void BotWriteInterbreeded(char *filename) {
line 584
;581:	float rank, bestrank;
;582:	int i, bestbot;
;583:
;584:	bestrank = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 585
;585:	bestbot = -1;
ADDRLP4 12
CNSTI4 -1
ASGNI4
line 587
;586:	// get the best bot
;587:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $304
line 588
;588:		if ( botstates[i] && botstates[i]->inuse ) {
ADDRLP4 20
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $308
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $308
line 589
;589:			rank = botstates[i]->num_kills * 2 - botstates[i]->num_deaths;
ADDRLP4 28
ADDRGP4 botstates
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
ADDP4
INDIRP4
CNSTI4 6032
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
ADDP4
INDIRP4
CNSTI4 6028
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 590
;590:		}
ADDRGP4 $309
JUMPV
LABELV $308
line 591
;591:		else {
line 592
;592:			rank = -1;
ADDRLP4 4
CNSTF4 3212836864
ASGNF4
line 593
;593:		}
LABELV $309
line 594
;594:		if (rank > bestrank) {
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $310
line 595
;595:			bestrank = rank;
ADDRLP4 8
ADDRLP4 4
INDIRF4
ASGNF4
line 596
;596:			bestbot = i;
ADDRLP4 12
ADDRLP4 0
INDIRI4
ASGNI4
line 597
;597:		}
LABELV $310
line 598
;598:	}
LABELV $305
line 587
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $304
line 599
;599:	if (bestbot >= 0) {
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $312
line 601
;600:		//write out the new goal fuzzy logic
;601:		trap_BotSaveGoalFuzzyLogic(botstates[bestbot]->gs, filename);
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_BotSaveGoalFuzzyLogic
CALLV
pop
line 602
;602:	}
LABELV $312
line 603
;603:}
LABELV $303
endproc BotWriteInterbreeded 32 8
export BotInterbreedEndMatch
proc BotInterbreedEndMatch 8 8
line 612
;604:
;605:/*
;606:==============
;607:BotInterbreedEndMatch
;608:
;609:add link back into ExitLevel?
;610:==============
;611:*/
;612:void BotInterbreedEndMatch(void) {
line 614
;613:
;614:	if (!bot_interbreed) return;
ADDRGP4 bot_interbreed
INDIRI4
CNSTI4 0
NEI4 $315
ADDRGP4 $314
JUMPV
LABELV $315
line 615
;615:	bot_interbreedmatchcount++;
ADDRLP4 0
ADDRGP4 bot_interbreedmatchcount
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 616
;616:	if (bot_interbreedmatchcount >= bot_interbreedcycle.integer) {
ADDRGP4 bot_interbreedmatchcount
INDIRI4
ADDRGP4 bot_interbreedcycle+12
INDIRI4
LTI4 $317
line 617
;617:		bot_interbreedmatchcount = 0;
ADDRGP4 bot_interbreedmatchcount
CNSTI4 0
ASGNI4
line 619
;618:		//
;619:		trap_Cvar_Update(&bot_interbreedwrite);
ADDRGP4 bot_interbreedwrite
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 620
;620:		if (strlen(bot_interbreedwrite.string)) {
ADDRGP4 bot_interbreedwrite+16
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $320
line 621
;621:			BotWriteInterbreeded(bot_interbreedwrite.string);
ADDRGP4 bot_interbreedwrite+16
ARGP4
ADDRGP4 BotWriteInterbreeded
CALLV
pop
line 622
;622:			trap_Cvar_Set("bot_interbreedwrite", "");
ADDRGP4 $324
ARGP4
ADDRGP4 $325
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 623
;623:		}
LABELV $320
line 624
;624:		BotInterbreedBots();
ADDRGP4 BotInterbreedBots
CALLV
pop
line 625
;625:	}
LABELV $317
line 626
;626:}
LABELV $314
endproc BotInterbreedEndMatch 8 8
export BotInterbreeding
proc BotInterbreeding 16 20
line 633
;627:
;628:/*
;629:==============
;630:BotInterbreeding
;631:==============
;632:*/
;633:void BotInterbreeding(void) {
line 636
;634:	int i;
;635:
;636:	trap_Cvar_Update(&bot_interbreedchar);
ADDRGP4 bot_interbreedchar
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 637
;637:	if (!strlen(bot_interbreedchar.string)) return;
ADDRGP4 bot_interbreedchar+16
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $327
ADDRGP4 $326
JUMPV
LABELV $327
line 639
;638:	//make sure we are in tournament mode
;639:	if (gametype != GT_DUEL) {
ADDRGP4 gametype
INDIRI4
CNSTI4 1
EQI4 $330
line 640
;640:		trap_Cvar_Set("g_gametype", va("%d", GT_DUEL));
ADDRGP4 $333
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $332
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 641
;641:		ExitLevel();
ADDRGP4 ExitLevel
CALLV
pop
line 642
;642:		return;
ADDRGP4 $326
JUMPV
LABELV $330
line 645
;643:	}
;644:	//shutdown all the bots
;645:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $337
JUMPV
LABELV $334
line 646
;646:		if (botstates[i] && botstates[i]->inuse) {
ADDRLP4 12
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $339
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $339
line 647
;647:			BotAIShutdownClient(botstates[i]->client, qfalse);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 BotAIShutdownClient
CALLI4
pop
line 648
;648:		}
LABELV $339
line 649
;649:	}
LABELV $335
line 645
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $337
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $334
line 651
;650:	//make sure all item weight configs are reloaded and Not shared
;651:	trap_BotLibVarSet("bot_reloadcharacters", "1");
ADDRGP4 $341
ARGP4
ADDRGP4 $342
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 653
;652:	//add a number of bots using the desired bot character
;653:	for (i = 0; i < bot_interbreedbots.integer; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $346
JUMPV
LABELV $343
line 654
;654:		trap_SendConsoleCommand( EXEC_INSERT, va("addbot %s 4 free %i %s%d\n",
ADDRGP4 $348
ARGP4
ADDRGP4 bot_interbreedchar+16
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 50
MULI4
ARGI4
ADDRGP4 bot_interbreedchar+16
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 656
;655:						bot_interbreedchar.string, i * 50, bot_interbreedchar.string, i) );
;656:	}
LABELV $344
line 653
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $346
ADDRLP4 0
INDIRI4
ADDRGP4 bot_interbreedbots+12
INDIRI4
LTI4 $343
line 658
;657:	//
;658:	trap_Cvar_Set("bot_interbreedchar", "");
ADDRGP4 $351
ARGP4
ADDRGP4 $325
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 659
;659:	bot_interbreed = qtrue;
ADDRGP4 bot_interbreed
CNSTI4 1
ASGNI4
line 660
;660:}
LABELV $326
endproc BotInterbreeding 16 20
export BotEntityInfo
proc BotEntityInfo 0 8
line 667
;661:
;662:/*
;663:==============
;664:BotEntityInfo
;665:==============
;666:*/
;667:void BotEntityInfo(int entnum, aas_entityinfo_t *info) {
line 668
;668:	trap_AAS_EntityInfo(entnum, info);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_AAS_EntityInfo
CALLV
pop
line 669
;669:}
LABELV $352
endproc BotEntityInfo 0 8
export NumBots
proc NumBots 0 0
line 676
;670:
;671:/*
;672:==============
;673:NumBots
;674:==============
;675:*/
;676:int NumBots(void) {
line 677
;677:	return numbots;
ADDRGP4 numbots
INDIRI4
RETI4
LABELV $353
endproc NumBots 0 0
export BotTeamLeader
proc BotTeamLeader 16 4
line 685
;678:}
;679:
;680:/*
;681:==============
;682:BotTeamLeader
;683:==============
;684:*/
;685:int BotTeamLeader(bot_state_t *bs) {
line 688
;686:	int leader;
;687:
;688:	leader = ClientFromName(bs->teamleader);
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 689
;689:	if (leader < 0) return qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $355
CNSTI4 0
RETI4
ADDRGP4 $354
JUMPV
LABELV $355
line 690
;690:	if (!botstates[leader] || !botstates[leader]->inuse) return qfalse;
ADDRLP4 12
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $359
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $357
LABELV $359
CNSTI4 0
RETI4
ADDRGP4 $354
JUMPV
LABELV $357
line 691
;691:	return qtrue;
CNSTI4 1
RETI4
LABELV $354
endproc BotTeamLeader 16 4
export AngleDifference
proc AngleDifference 4 0
line 699
;692:}
;693:
;694:/*
;695:==============
;696:AngleDifference
;697:==============
;698:*/
;699:float AngleDifference(float ang1, float ang2) {
line 702
;700:	float diff;
;701:
;702:	diff = ang1 - ang2;
ADDRLP4 0
ADDRFP4 0
INDIRF4
ADDRFP4 4
INDIRF4
SUBF4
ASGNF4
line 703
;703:	if (ang1 > ang2) {
ADDRFP4 0
INDIRF4
ADDRFP4 4
INDIRF4
LEF4 $361
line 704
;704:		if (diff > 180.0) diff -= 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 1127481344
LEF4 $362
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 705
;705:	}
ADDRGP4 $362
JUMPV
LABELV $361
line 706
;706:	else {
line 707
;707:		if (diff < -180.0) diff += 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 3274964992
GEF4 $365
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $365
line 708
;708:	}
LABELV $362
line 709
;709:	return diff;
ADDRLP4 0
INDIRF4
RETF4
LABELV $360
endproc AngleDifference 4 0
export BotChangeViewAngle
proc BotChangeViewAngle 16 4
line 717
;710:}
;711:
;712:/*
;713:==============
;714:BotChangeViewAngle
;715:==============
;716:*/
;717:float BotChangeViewAngle(float angle, float ideal_angle, float speed) {
line 720
;718:	float move;
;719:
;720:	angle = AngleMod(angle);
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 721
;721:	ideal_angle = AngleMod(ideal_angle);
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 722
;722:	if (angle == ideal_angle) return angle;
ADDRFP4 0
INDIRF4
ADDRFP4 4
INDIRF4
NEF4 $368
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $367
JUMPV
LABELV $368
line 723
;723:	move = ideal_angle - angle;
ADDRLP4 0
ADDRFP4 4
INDIRF4
ADDRFP4 0
INDIRF4
SUBF4
ASGNF4
line 724
;724:	if (ideal_angle > angle) {
ADDRFP4 4
INDIRF4
ADDRFP4 0
INDIRF4
LEF4 $370
line 725
;725:		if (move > 180.0) move -= 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 1127481344
LEF4 $371
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 726
;726:	}
ADDRGP4 $371
JUMPV
LABELV $370
line 727
;727:	else {
line 728
;728:		if (move < -180.0) move += 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 3274964992
GEF4 $374
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $374
line 729
;729:	}
LABELV $371
line 730
;730:	if (move > 0) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $376
line 731
;731:		if (move > speed) move = speed;
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
LEF4 $377
ADDRLP4 0
ADDRFP4 8
INDIRF4
ASGNF4
line 732
;732:	}
ADDRGP4 $377
JUMPV
LABELV $376
line 733
;733:	else {
line 734
;734:		if (move < -speed) move = -speed;
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
NEGF4
GEF4 $380
ADDRLP4 0
ADDRFP4 8
INDIRF4
NEGF4
ASGNF4
LABELV $380
line 735
;735:	}
LABELV $377
line 736
;736:	return AngleMod(angle + move);
ADDRFP4 0
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
RETF4
LABELV $367
endproc BotChangeViewAngle 16 4
export BotChangeViewAngles
proc BotChangeViewAngles 96 16
line 744
;737:}
;738:
;739:/*
;740:==============
;741:BotChangeViewAngles
;742:==============
;743:*/
;744:void BotChangeViewAngles(bot_state_t *bs, float thinktime) {
line 748
;745:	float diff, factor, maxchange, anglespeed, disired_speed;
;746:	int i;
;747:
;748:	if (bs->ideal_viewangles[PITCH] > 180) bs->ideal_viewangles[PITCH] -= 360;
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $383
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $383
line 750
;749:	//
;750:	if (bs->enemy >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
CNSTI4 0
LTI4 $385
line 751
;751:		factor = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_VIEW_FACTOR, 0.01f, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTF4 1008981770
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 28
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 28
INDIRF4
ASGNF4
line 752
;752:		maxchange = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_VIEW_MAXCHANGE, 1, 1800);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 5
ARGI4
CNSTF4 1065353216
ARGF4
CNSTF4 1155596288
ARGF4
ADDRLP4 32
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 32
INDIRF4
ASGNF4
line 753
;753:	}
ADDRGP4 $386
JUMPV
LABELV $385
line 754
;754:	else {
line 755
;755:		factor = 0.05f;
ADDRLP4 16
CNSTF4 1028443341
ASGNF4
line 756
;756:		maxchange = 360;
ADDRLP4 8
CNSTF4 1135869952
ASGNF4
line 757
;757:	}
LABELV $386
line 758
;758:	if (maxchange < 240) maxchange = 240;
ADDRLP4 8
INDIRF4
CNSTF4 1131413504
GEF4 $387
ADDRLP4 8
CNSTF4 1131413504
ASGNF4
LABELV $387
line 759
;759:	maxchange *= thinktime;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 760
;760:	for (i = 0; i < 2; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $389
line 762
;761:		//
;762:		if (bot_challenge.integer) {
ADDRGP4 bot_challenge+12
INDIRI4
CNSTI4 0
EQI4 $393
line 764
;763:			//smooth slowdown view model
;764:			diff = fabs(AngleDifference(bs->viewangles[i], bs->ideal_viewangles[i]));
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 6576
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 AngleDifference
CALLF4
ASGNF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 40
INDIRF4
ASGNF4
line 765
;765:			anglespeed = diff * factor;
ADDRLP4 4
ADDRLP4 12
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 766
;766:			if (anglespeed > maxchange) anglespeed = maxchange;
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $396
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $396
line 767
;767:			bs->viewangles[i] = BotChangeViewAngle(bs->viewangles[i],
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 48
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 48
INDIRP4
CNSTI4 6576
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 52
ADDRGP4 BotChangeViewAngle
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 48
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ADDRLP4 52
INDIRF4
ASGNF4
line 769
;768:											bs->ideal_viewangles[i], anglespeed);
;769:		}
ADDRGP4 $394
JUMPV
LABELV $393
line 770
;770:		else {
line 772
;771:			//over reaction view model
;772:			bs->viewangles[i] = AngleMod(bs->viewangles[i]);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ADDRLP4 36
INDIRF4
ASGNF4
line 773
;773:			bs->ideal_viewangles[i] = AngleMod(bs->ideal_viewangles[i]);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 44
INDIRP4
CNSTI4 6576
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 44
INDIRP4
CNSTI4 6576
ADDP4
ADDP4
ADDRLP4 48
INDIRF4
ASGNF4
line 774
;774:			diff = AngleDifference(bs->viewangles[i], bs->ideal_viewangles[i]);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 56
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 56
INDIRP4
CNSTI4 6576
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 AngleDifference
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 60
INDIRF4
ASGNF4
line 775
;775:			disired_speed = diff * factor;
ADDRLP4 20
ADDRLP4 12
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 776
;776:			bs->viewanglespeed[i] += (bs->viewanglespeed[i] - disired_speed);
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
ADDF4
ASGNF4
line 777
;777:			if (bs->viewanglespeed[i] > 180) bs->viewanglespeed[i] = maxchange;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $398
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $398
line 778
;778:			if (bs->viewanglespeed[i] < -180) bs->viewanglespeed[i] = -maxchange;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
INDIRF4
CNSTF4 3274964992
GEF4 $400
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
ADDRLP4 8
INDIRF4
NEGF4
ASGNF4
LABELV $400
line 779
;779:			anglespeed = bs->viewanglespeed[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
INDIRF4
ASGNF4
line 780
;780:			if (anglespeed > maxchange) anglespeed = maxchange;
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $402
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $402
line 781
;781:			if (anglespeed < -maxchange) anglespeed = -maxchange;
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
NEGF4
GEF4 $404
ADDRLP4 4
ADDRLP4 8
INDIRF4
NEGF4
ASGNF4
LABELV $404
line 782
;782:			bs->viewangles[i] += anglespeed;
ADDRLP4 76
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 783
;783:			bs->viewangles[i] = AngleMod(bs->viewangles[i]);
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 84
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 88
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 84
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ADDRLP4 88
INDIRF4
ASGNF4
line 785
;784:			//demping
;785:			bs->viewanglespeed[i] *= 0.45 * (1 - factor);
ADDRLP4 92
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 6588
ADDP4
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDRLP4 16
INDIRF4
SUBF4
CNSTF4 1055286886
MULF4
MULF4
ASGNF4
line 786
;786:		}
LABELV $394
line 789
;787:		//BotAI_Print(PRT_MESSAGE, "ideal_angles %f %f\n", bs->ideal_viewangles[0], bs->ideal_viewangles[1], bs->ideal_viewangles[2]);`
;788:		//bs->viewangles[i] = bs->ideal_viewangles[i];
;789:	}
LABELV $390
line 760
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $389
line 791
;790:	//bs->viewangles[PITCH] = 0;
;791:	if (bs->viewangles[PITCH] > 180) bs->viewangles[PITCH] -= 360;
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $406
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $406
line 793
;792:	//elementary action: view
;793:	trap_EA_View(bs->client, bs->viewangles);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRGP4 trap_EA_View
CALLV
pop
line 794
;794:}
LABELV $382
endproc BotChangeViewAngles 96 16
export BotInputToUserCommand
proc BotInputToUserCommand 136 16
line 801
;795:
;796:/*
;797:==============
;798:BotInputToUserCommand
;799:==============
;800:*/
;801:void BotInputToUserCommand(bot_input_t *bi, usercmd_t *ucmd, int delta_angles[3], int time) {
line 808
;802:	vec3_t angles, forward, right;
;803:	short temp;
;804:	int j;
;805:	float f, r, u, m;
;806:
;807:	//clear the whole structure
;808:	memset(ucmd, 0, sizeof(usercmd_t));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 24
ARGI4
ADDRGP4 memset
CALLP4
pop
line 812
;809:	//
;810:	//Com_Printf("dir = %f %f %f speed = %f\n", bi->dir[0], bi->dir[1], bi->dir[2], bi->speed);
;811:	//the duration for the user command in milli seconds
;812:	ucmd->serverTime = time;
ADDRFP4 4
INDIRP4
ADDRFP4 12
INDIRI4
ASGNI4
line 814
;813:	//
;814:	if (bi->actionflags & ACTION_DELAYEDJUMP) {
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $409
line 815
;815:		bi->actionflags |= ACTION_JUMP;
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 816
;816:		bi->actionflags &= ~ACTION_DELAYEDJUMP;
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 -32769
BANDI4
ASGNI4
line 817
;817:	}
LABELV $409
line 819
;818:	//set the buttons
;819:	if (bi->actionflags & ACTION_RESPAWN) ucmd->buttons = BUTTON_ATTACK;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $411
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 1
ASGNI4
LABELV $411
line 820
;820:	if (bi->actionflags & ACTION_ATTACK) ucmd->buttons |= BUTTON_ATTACK;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $413
ADDRLP4 60
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
LABELV $413
line 821
;821:	if (bi->actionflags & ACTION_TALK) ucmd->buttons |= BUTTON_TALK;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 65536
BANDI4
CNSTI4 0
EQI4 $415
ADDRLP4 64
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
LABELV $415
line 822
;822:	if (bi->actionflags & ACTION_GESTURE) ucmd->buttons |= BUTTON_GESTURE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $417
ADDRLP4 68
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
LABELV $417
line 823
;823:	if (bi->actionflags & ACTION_USE) ucmd->buttons |= BUTTON_USE_HOLDABLE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $419
ADDRLP4 72
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
LABELV $419
line 824
;824:	if (bi->actionflags & ACTION_WALK) ucmd->buttons |= BUTTON_WALKING;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 524288
BANDI4
CNSTI4 0
EQI4 $421
ADDRLP4 76
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
LABELV $421
line 825
;825:	if (bi->actionflags & ACTION_AFFIRMATIVE) ucmd->buttons |= BUTTON_AFFIRMATIVE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 1048576
BANDI4
CNSTI4 0
EQI4 $423
ADDRLP4 80
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
LABELV $423
line 826
;826:	if (bi->actionflags & ACTION_NEGATIVE) ucmd->buttons |= BUTTON_NEGATIVE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 2097152
BANDI4
CNSTI4 0
EQI4 $425
ADDRLP4 84
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
LABELV $425
line 827
;827:	if (bi->actionflags & ACTION_GETFLAG) ucmd->buttons |= BUTTON_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 8388608
BANDI4
CNSTI4 0
EQI4 $427
ADDRLP4 88
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
LABELV $427
line 828
;828:	if (bi->actionflags & ACTION_GUARDBASE) ucmd->buttons |= BUTTON_GUARDBASE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 16777216
BANDI4
CNSTI4 0
EQI4 $429
ADDRLP4 92
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
LABELV $429
line 829
;829:	if (bi->actionflags & ACTION_PATROL) ucmd->buttons |= BUTTON_PATROL;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 33554432
BANDI4
CNSTI4 0
EQI4 $431
ADDRLP4 96
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
LABELV $431
line 830
;830:	if (bi->actionflags & ACTION_FOLLOWME) ucmd->buttons |= BUTTON_FOLLOWME;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 134217728
BANDI4
CNSTI4 0
EQI4 $433
ADDRLP4 100
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
LABELV $433
line 832
;831:	//
;832:	ucmd->weapon = bi->weapon;
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 835
;833:	//set the view angles
;834:	//NOTE: the ucmd->angles are the angles WITHOUT the delta angles
;835:	ucmd->angles[PITCH] = ANGLE2SHORT(bi->viewangles[PITCH]);
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1127615329
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
ASGNI4
line 836
;836:	ucmd->angles[YAW] = ANGLE2SHORT(bi->viewangles[YAW]);
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
CNSTF4 1127615329
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
ASGNI4
line 837
;837:	ucmd->angles[ROLL] = ANGLE2SHORT(bi->viewangles[ROLL]);
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1127615329
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
ASGNI4
line 839
;838:	//subtract the delta angles
;839:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $435
line 840
;840:		temp = ucmd->angles[j] - delta_angles[j];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRI4
SUBI4
CVII2 4
ASGNI2
line 848
;841:		/*NOTE: disabled because temp should be mod first
;842:		if ( j == PITCH ) {
;843:			// don't let the player look up or down more than 90 degrees
;844:			if ( temp > 16000 ) temp = 16000;
;845:			else if ( temp < -16000 ) temp = -16000;
;846:		}
;847:		*/
;848:		ucmd->angles[j] = temp;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
ADDRLP4 4
INDIRI2
CVII4 2
ASGNI4
line 849
;849:	}
LABELV $436
line 839
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $435
line 853
;850:	//NOTE: movement is relative to the REAL view angles
;851:	//get the horizontal forward and right vector
;852:	//get the pitch in the range [-180, 180]
;853:	if (bi->dir[2]) angles[PITCH] = bi->viewangles[PITCH];
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 0
EQF4 $439
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
ADDRGP4 $440
JUMPV
LABELV $439
line 854
;854:	else angles[PITCH] = 0;
ADDRLP4 24
CNSTF4 0
ASGNF4
LABELV $440
line 855
;855:	angles[YAW] = bi->viewangles[YAW];
ADDRLP4 24+4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 856
;856:	angles[ROLL] = 0;
ADDRLP4 24+8
CNSTF4 0
ASGNF4
line 857
;857:	AngleVectors(angles, forward, right, NULL);
ADDRLP4 24
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 36
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 859
;858:	//bot input speed is in the range [0, 400]
;859:	bi->speed = bi->speed * 127 / 400;
ADDRLP4 104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 104
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 104
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 1050840924
MULF4
ASGNF4
line 862
;860:
;861:	//set the view independent movement
;862:	f = DotProduct( forward, bi->dir );
ADDRLP4 108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 12
INDIRF4
ADDRLP4 108
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 108
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 12+8
INDIRF4
ADDRLP4 108
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 863
;863:	r = DotProduct( right, bi->dir );
ADDRLP4 112
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
ADDRLP4 36
INDIRF4
ADDRLP4 112
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 36+4
INDIRF4
ADDRLP4 112
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 36+8
INDIRF4
ADDRLP4 112
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 864
;864:	u = fabs( forward[2] ) * bi->dir[2];
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 116
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 52
ADDRLP4 116
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ASGNF4
line 865
;865:	m = fabs( f );
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 120
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 120
INDIRF4
ASGNF4
line 867
;866:
;867:	if ( fabs( r ) > m ) {
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 124
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 124
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $448
line 868
;868:		m = fabs( r );
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 128
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 128
INDIRF4
ASGNF4
line 869
;869:	}
LABELV $448
line 871
;870:
;871:	if ( fabs( u ) > m) {
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 128
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 128
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $450
line 872
;872:		m = fabs( u );
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 132
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 132
INDIRF4
ASGNF4
line 873
;873:	}
LABELV $450
line 875
;874:
;875:	if ( m > 0 ) {
ADDRLP4 8
INDIRF4
CNSTF4 0
LEF4 $452
line 876
;876:		f *= bi->speed / m;
ADDRLP4 56
ADDRLP4 56
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
MULF4
ASGNF4
line 877
;877:		r *= bi->speed / m;
ADDRLP4 48
ADDRLP4 48
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
MULF4
ASGNF4
line 878
;878:		u *= bi->speed / m;
ADDRLP4 52
ADDRLP4 52
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
MULF4
ASGNF4
line 879
;879:	}
LABELV $452
line 881
;880:
;881:	ucmd->forwardmove = f;
ADDRFP4 4
INDIRP4
CNSTI4 21
ADDP4
ADDRLP4 56
INDIRF4
CVFI4 4
CVII1 4
ASGNI1
line 882
;882:	ucmd->rightmove = r;
ADDRFP4 4
INDIRP4
CNSTI4 22
ADDP4
ADDRLP4 48
INDIRF4
CVFI4 4
CVII1 4
ASGNI1
line 883
;883:	ucmd->upmove = u;
ADDRFP4 4
INDIRP4
CNSTI4 23
ADDP4
ADDRLP4 52
INDIRF4
CVFI4 4
CVII1 4
ASGNI1
line 885
;884:
;885:	if (bi->actionflags & ACTION_MOVEFORWARD) ucmd->forwardmove = 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $454
ADDRFP4 4
INDIRP4
CNSTI4 21
ADDP4
CNSTI1 127
ASGNI1
LABELV $454
line 886
;886:	if (bi->actionflags & ACTION_MOVEBACK) ucmd->forwardmove = -127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $456
ADDRFP4 4
INDIRP4
CNSTI4 21
ADDP4
CNSTI1 -127
ASGNI1
LABELV $456
line 887
;887:	if (bi->actionflags & ACTION_MOVELEFT) ucmd->rightmove = -127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $458
ADDRFP4 4
INDIRP4
CNSTI4 22
ADDP4
CNSTI1 -127
ASGNI1
LABELV $458
line 888
;888:	if (bi->actionflags & ACTION_MOVERIGHT) ucmd->rightmove = 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $460
ADDRFP4 4
INDIRP4
CNSTI4 22
ADDP4
CNSTI1 127
ASGNI1
LABELV $460
line 890
;889:	//jump/moveup
;890:	if (bi->actionflags & ACTION_JUMP) ucmd->upmove = 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $462
ADDRFP4 4
INDIRP4
CNSTI4 23
ADDP4
CNSTI1 127
ASGNI1
LABELV $462
line 892
;891:	//crouch/movedown
;892:	if (bi->actionflags & ACTION_CROUCH) ucmd->upmove = -127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $464
ADDRFP4 4
INDIRP4
CNSTI4 23
ADDP4
CNSTI1 -127
ASGNI1
LABELV $464
line 893
;893:}
LABELV $408
endproc BotInputToUserCommand 136 16
export BotUpdateInput
proc BotUpdateInput 60 16
line 900
;894:
;895:/*
;896:==============
;897:BotUpdateInput
;898:==============
;899:*/
;900:void BotUpdateInput(bot_state_t *bs, int time, int elapsed_time) {
line 905
;901:	bot_input_t bi;
;902:	int j;
;903:
;904:	//add the delta angles to the bot's current view angles
;905:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $467
line 906
;906:		bs->viewangles[j] = AngleMod(bs->viewangles[j] + SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 48
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 48
INDIRP4
CNSTI4 72
ADDP4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1001652224
MULF4
ADDF4
ARGF4
ADDRLP4 52
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 48
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ADDRLP4 52
INDIRF4
ASGNF4
line 907
;907:	}
LABELV $468
line 905
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $467
line 909
;908:	//change the bot view angles
;909:	BotChangeViewAngles(bs, (float) elapsed_time / 1000);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ARGF4
ADDRGP4 BotChangeViewAngles
CALLV
pop
line 911
;910:	//retrieve the bot input
;911:	trap_EA_GetInput(bs->client, (float) time / 1000, &bi);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 trap_EA_GetInput
CALLV
pop
line 913
;912:	//respawn hack
;913:	if (bi.actionflags & ACTION_RESPAWN) {
ADDRLP4 4+32
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $471
line 914
;914:		if (bs->lastucmd.buttons & BUTTON_ATTACK) bi.actionflags &= ~(ACTION_RESPAWN|ACTION_ATTACK);
ADDRFP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $474
ADDRLP4 4+32
ADDRLP4 4+32
INDIRI4
CNSTI4 -10
BANDI4
ASGNI4
LABELV $474
line 915
;915:	}
LABELV $471
line 917
;916:	//convert the bot input to a usercmd
;917:	BotInputToUserCommand(&bi, &bs->lastucmd, bs->cur_ps.delta_angles, time);
ADDRLP4 4
ARGP4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 72
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 BotInputToUserCommand
CALLV
pop
line 919
;918:	//subtract the delta angles
;919:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $477
line 920
;920:		bs->viewangles[j] = AngleMod(bs->viewangles[j] - SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 52
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 52
INDIRP4
CNSTI4 72
ADDP4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1001652224
MULF4
SUBF4
ARGF4
ADDRLP4 56
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 52
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ADDRLP4 56
INDIRF4
ASGNF4
line 921
;921:	}
LABELV $478
line 919
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $477
line 922
;922:}
LABELV $466
endproc BotUpdateInput 60 16
export BotAIRegularUpdate
proc BotAIRegularUpdate 0 0
line 929
;923:
;924:/*
;925:==============
;926:BotAIRegularUpdate
;927:==============
;928:*/
;929:void BotAIRegularUpdate(void) {
line 930
;930:	if (regularupdate_time < FloatTime()) {
ADDRGP4 regularupdate_time
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $482
line 931
;931:		trap_BotUpdateEntityItems();
ADDRGP4 trap_BotUpdateEntityItems
CALLV
pop
line 932
;932:		regularupdate_time = FloatTime() + 0.3;
ADDRGP4 regularupdate_time
ADDRGP4 floattime
INDIRF4
CNSTF4 1050253722
ADDF4
ASGNF4
line 933
;933:	}
LABELV $482
line 934
;934:}
LABELV $481
endproc BotAIRegularUpdate 0 0
export RemoveColorEscapeSequences
proc RemoveColorEscapeSequences 20 0
line 941
;935:
;936:/*
;937:==============
;938:RemoveColorEscapeSequences
;939:==============
;940:*/
;941:void RemoveColorEscapeSequences( char *text ) {
line 944
;942:	int i, l;
;943:
;944:	l = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 945
;945:	for ( i = 0; text[i]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $488
JUMPV
LABELV $485
line 946
;946:		if (Q_IsColorString(&text[i])) {
ADDRLP4 8
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $489
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $489
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $489
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $489
line 947
;947:			i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 948
;948:			continue;
ADDRGP4 $486
JUMPV
LABELV $489
line 950
;949:		}
;950:		if (text[i] > 0x7E)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 126
LEI4 $491
line 951
;951:			continue;
ADDRGP4 $486
JUMPV
LABELV $491
line 952
;952:		text[l++] = text[i];
ADDRLP4 12
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 953
;953:	}
LABELV $486
line 945
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $488
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $485
line 954
;954:	text[l] = '\0';
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 955
;955:}
LABELV $484
endproc RemoveColorEscapeSequences 20 0
export BotAI
proc BotAI 1088 12
line 962
;956:
;957:/*
;958:==============
;959:BotAI
;960:==============
;961:*/
;962:int BotAI(int client, float thinktime) {
line 967
;963:	bot_state_t *bs;
;964:	char buf[1024], *args;
;965:	int j;
;966:
;967:	trap_EA_ResetInput(client);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 trap_EA_ResetInput
CALLV
pop
line 969
;968:	//
;969:	bs = botstates[client];
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 970
;970:	if (!bs || !bs->inuse) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $496
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $494
LABELV $496
line 971
;971:		BotAI_Print(PRT_FATAL, "BotAI: client %d is not setup\n", client);
CNSTI4 4
ARGI4
ADDRGP4 $497
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 972
;972:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $493
JUMPV
LABELV $494
line 976
;973:	}
;974:
;975:	//retrieve the current client state
;976:	BotAI_GetClientState( client, &bs->cur_ps );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
ADDRGP4 $499
JUMPV
LABELV $498
line 979
;977:
;978:	//retrieve any waiting server commands
;979:	while( trap_BotGetServerCommand(client, buf, sizeof(buf)) ) {
line 981
;980:		//have buf point to the command and args to the command arguments
;981:		args = strchr( buf, ' ');
ADDRLP4 12
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 1040
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 1040
INDIRP4
ASGNP4
line 982
;982:		if (!args) continue;
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $501
ADDRGP4 $499
JUMPV
LABELV $501
line 983
;983:		*args++ = '\0';
ADDRLP4 1044
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 1044
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 1044
INDIRP4
CNSTI1 0
ASGNI1
line 986
;984:
;985:		//remove color espace sequences from the arguments
;986:		RemoveColorEscapeSequences( args );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 RemoveColorEscapeSequences
CALLV
pop
line 988
;987:
;988:		if (!Q_stricmp(buf, "cp "))
ADDRLP4 12
ARGP4
ADDRGP4 $505
ARGP4
ADDRLP4 1048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $503
line 989
;989:			{ /*CenterPrintf*/ }
ADDRGP4 $504
JUMPV
LABELV $503
line 990
;990:		else if (!Q_stricmp(buf, "cs"))
ADDRLP4 12
ARGP4
ADDRGP4 $508
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $506
line 991
;991:			{ /*ConfigStringModified*/ }
ADDRGP4 $507
JUMPV
LABELV $506
line 992
;992:		else if (!Q_stricmp(buf, "print")) {
ADDRLP4 12
ARGP4
ADDRGP4 $511
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $509
line 994
;993:			//remove first and last quote from the chat message
;994:			memmove(args, args+1, strlen(args));
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1060
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 1060
INDIRI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 995
;995:			args[strlen(args)-1] = '\0';
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1068
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 996
;996:			trap_BotQueueConsoleMessage(bs->cs, CMS_NORMAL, args);
ADDRLP4 4
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_BotQueueConsoleMessage
CALLV
pop
line 997
;997:		}
ADDRGP4 $510
JUMPV
LABELV $509
line 998
;998:		else if (!Q_stricmp(buf, "chat")) {
ADDRLP4 12
ARGP4
ADDRGP4 $514
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $512
line 1000
;999:			//remove first and last quote from the chat message
;1000:			memmove(args, args+1, strlen(args));
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1064
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 1064
INDIRI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1001
;1001:			args[strlen(args)-1] = '\0';
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1072
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1002
;1002:			trap_BotQueueConsoleMessage(bs->cs, CMS_CHAT, args);
ADDRLP4 4
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_BotQueueConsoleMessage
CALLV
pop
line 1003
;1003:		}
ADDRGP4 $513
JUMPV
LABELV $512
line 1004
;1004:		else if (!Q_stricmp(buf, "tchat")) {
ADDRLP4 12
ARGP4
ADDRGP4 $517
ARGP4
ADDRLP4 1064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $515
line 1006
;1005:			//remove first and last quote from the chat message
;1006:			memmove(args, args+1, strlen(args));
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1068
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 1068
INDIRI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1007
;1007:			args[strlen(args)-1] = '\0';
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1076
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 8
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 1008
;1008:			trap_BotQueueConsoleMessage(bs->cs, CMS_CHAT, args);
ADDRLP4 4
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_BotQueueConsoleMessage
CALLV
pop
line 1009
;1009:		}
ADDRGP4 $516
JUMPV
LABELV $515
line 1010
;1010:		else if (!Q_stricmp(buf, "scores"))
ADDRLP4 12
ARGP4
ADDRGP4 $520
ARGP4
ADDRLP4 1068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
NEI4 $518
line 1011
;1011:			{ /*FIXME: parse scores?*/ }
ADDRGP4 $519
JUMPV
LABELV $518
line 1012
;1012:		else if (!Q_stricmp(buf, "clientLevelShot"))
ADDRLP4 12
ARGP4
ADDRGP4 $523
ARGP4
ADDRLP4 1072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $521
line 1013
;1013:			{ /*ignore*/ }
LABELV $521
LABELV $519
LABELV $516
LABELV $513
LABELV $510
LABELV $507
LABELV $504
line 1014
;1014:	}
LABELV $499
line 979
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1040
ADDRGP4 trap_BotGetServerCommand
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $498
line 1016
;1015:	//add the delta angles to the bot's current view angles
;1016:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $524
line 1017
;1017:		bs->viewangles[j] = AngleMod(bs->viewangles[j] + SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1001652224
MULF4
ADDF4
ARGF4
ADDRLP4 1052
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ADDRLP4 1052
INDIRF4
ASGNF4
line 1018
;1018:	}
LABELV $525
line 1016
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $524
line 1020
;1019:	//increase the local time of the bot
;1020:	bs->ltime += thinktime;
ADDRLP4 1044
ADDRLP4 4
INDIRP4
CNSTI4 6060
ADDP4
ASGNP4
ADDRLP4 1044
INDIRP4
ADDRLP4 1044
INDIRP4
INDIRF4
ADDRFP4 4
INDIRF4
ADDF4
ASGNF4
line 1022
;1021:	//
;1022:	bs->thinktime = thinktime;
ADDRLP4 4
INDIRP4
CNSTI4 4904
ADDP4
ADDRFP4 4
INDIRF4
ASGNF4
line 1024
;1023:	//origin of the bot
;1024:	VectorCopy(bs->cur_ps.origin, bs->origin);
ADDRLP4 4
INDIRP4
CNSTI4 4908
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1026
;1025:	//eye coordinates of the bot
;1026:	VectorCopy(bs->cur_ps.origin, bs->eye);
ADDRLP4 4
INDIRP4
CNSTI4 4936
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1027
;1027:	bs->eye[2] += bs->cur_ps.viewheight;
ADDRLP4 1060
ADDRLP4 4
INDIRP4
CNSTI4 4944
ADDP4
ASGNP4
ADDRLP4 1060
INDIRP4
ADDRLP4 1060
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1029
;1028:	//get the area the bot is in
;1029:	bs->areanum = BotPointAreaNum(bs->origin);
ADDRLP4 4
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 1068
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 4948
ADDP4
ADDRLP4 1068
INDIRI4
ASGNI4
line 1031
;1030:	//the real AI
;1031:	BotDeathmatchAI(bs, thinktime);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRGP4 BotDeathmatchAI
CALLV
pop
line 1033
;1032:	//set the weapon selection every AI frame
;1033:	trap_EA_SelectWeapon(bs->client, bs->weaponnum);
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_SelectWeapon
CALLV
pop
line 1035
;1034:	//subtract the delta angles
;1035:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $528
line 1036
;1036:		bs->viewangles[j] = AngleMod(bs->viewangles[j] - SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1001652224
MULF4
SUBF4
ARGF4
ADDRLP4 1084
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 6564
ADDP4
ADDP4
ADDRLP4 1084
INDIRF4
ASGNF4
line 1037
;1037:	}
LABELV $529
line 1035
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $528
line 1039
;1038:	//everything was ok
;1039:	return qtrue;
CNSTI4 1
RETI4
LABELV $493
endproc BotAI 1088 12
export BotScheduleBotThink
proc BotScheduleBotThink 16 0
line 1047
;1040:}
;1041:
;1042:/*
;1043:==================
;1044:BotScheduleBotThink
;1045:==================
;1046:*/
;1047:void BotScheduleBotThink(void) {
line 1050
;1048:	int i, botnum;
;1049:
;1050:	botnum = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1052
;1051:
;1052:	for( i = 0; i < MAX_CLIENTS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $533
line 1053
;1053:		if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 12
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $539
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $537
LABELV $539
line 1054
;1054:			continue;
ADDRGP4 $534
JUMPV
LABELV $537
line 1057
;1055:		}
;1056:		//initialize the bot think residual time
;1057:		botstates[i]->botthink_residual = bot_thinktime.integer * botnum / numbots;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 bot_thinktime+12
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 numbots
INDIRI4
DIVI4
ASGNI4
line 1058
;1058:		botnum++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1059
;1059:	}
LABELV $534
line 1052
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $533
line 1060
;1060:}
LABELV $532
endproc BotScheduleBotThink 16 0
export BotWriteSessionData
proc BotWriteSessionData 20 72
line 1067
;1061:
;1062:/*
;1063:==============
;1064:BotWriteSessionData
;1065:==============
;1066:*/
;1067:void BotWriteSessionData(bot_state_t *bs) {
line 1071
;1068:	const char	*s;
;1069:	const char	*var;
;1070:
;1071:	s = va(
ADDRGP4 $542
ARGP4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6756
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6764
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6780
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6808
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6816
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6820
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6812
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6768
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6772
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6776
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6784
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6788
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6792
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6796
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6800
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 6804
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1095
;1072:			"%i %i %i %i %i %i %i %i"
;1073:			" %f %f %f"
;1074:			" %f %f %f"
;1075:			" %f %f %f",
;1076:		bs->lastgoal_decisionmaker,
;1077:		bs->lastgoal_ltgtype,
;1078:		bs->lastgoal_teammate,
;1079:		bs->lastgoal_teamgoal.areanum,
;1080:		bs->lastgoal_teamgoal.entitynum,
;1081:		bs->lastgoal_teamgoal.flags,
;1082:		bs->lastgoal_teamgoal.iteminfo,
;1083:		bs->lastgoal_teamgoal.number,
;1084:		bs->lastgoal_teamgoal.origin[0],
;1085:		bs->lastgoal_teamgoal.origin[1],
;1086:		bs->lastgoal_teamgoal.origin[2],
;1087:		bs->lastgoal_teamgoal.mins[0],
;1088:		bs->lastgoal_teamgoal.mins[1],
;1089:		bs->lastgoal_teamgoal.mins[2],
;1090:		bs->lastgoal_teamgoal.maxs[0],
;1091:		bs->lastgoal_teamgoal.maxs[1],
;1092:		bs->lastgoal_teamgoal.maxs[2]
;1093:		);
;1094:
;1095:	var = va( "botsession%i", bs->client );
ADDRGP4 $543
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 1097
;1096:
;1097:	trap_Cvar_Set( var, s );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1098
;1098:}
LABELV $541
endproc BotWriteSessionData 20 72
export BotReadSessionData
proc BotReadSessionData 1036 76
line 1105
;1099:
;1100:/*
;1101:==============
;1102:BotReadSessionData
;1103:==============
;1104:*/
;1105:void BotReadSessionData(bot_state_t *bs) {
line 1109
;1106:	char	s[MAX_STRING_CHARS];
;1107:	const char	*var;
;1108:
;1109:	var = va( "botsession%i", bs->client );
ADDRGP4 $543
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1028
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1024
ADDRLP4 1028
INDIRP4
ASGNP4
line 1110
;1110:	trap_Cvar_VariableStringBuffer( var, s, sizeof(s) );
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1112
;1111:
;1112:	Q_sscanf(s,
ADDRLP4 0
ARGP4
ADDRGP4 $542
ARGP4
ADDRLP4 1032
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1032
INDIRP4
CNSTI4 6756
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6760
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6764
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6780
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6808
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6816
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6820
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6812
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6768
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6772
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6776
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6784
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6788
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6792
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6796
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6800
ADDP4
ARGP4
ADDRLP4 1032
INDIRP4
CNSTI4 6804
ADDP4
ARGP4
ADDRGP4 Q_sscanf
CALLI4
pop
line 1135
;1113:			"%i %i %i %i %i %i %i %i"
;1114:			" %f %f %f"
;1115:			" %f %f %f"
;1116:			" %f %f %f",
;1117:		&bs->lastgoal_decisionmaker,
;1118:		&bs->lastgoal_ltgtype,
;1119:		&bs->lastgoal_teammate,
;1120:		&bs->lastgoal_teamgoal.areanum,
;1121:		&bs->lastgoal_teamgoal.entitynum,
;1122:		&bs->lastgoal_teamgoal.flags,
;1123:		&bs->lastgoal_teamgoal.iteminfo,
;1124:		&bs->lastgoal_teamgoal.number,
;1125:		&bs->lastgoal_teamgoal.origin[0],
;1126:		&bs->lastgoal_teamgoal.origin[1],
;1127:		&bs->lastgoal_teamgoal.origin[2],
;1128:		&bs->lastgoal_teamgoal.mins[0],
;1129:		&bs->lastgoal_teamgoal.mins[1],
;1130:		&bs->lastgoal_teamgoal.mins[2],
;1131:		&bs->lastgoal_teamgoal.maxs[0],
;1132:		&bs->lastgoal_teamgoal.maxs[1],
;1133:		&bs->lastgoal_teamgoal.maxs[2]
;1134:		);
;1135:}
LABELV $544
endproc BotReadSessionData 1036 76
export BotAISetupClient
proc BotAISetupClient 512 16
line 1142
;1136:
;1137:/*
;1138:==============
;1139:BotAISetupClient
;1140:==============
;1141:*/
;1142:qboolean BotAISetupClient( int client, struct bot_settings_s *settings, qboolean restart ) {
line 1147
;1143:	char filename[MAX_PATH], name[MAX_PATH], gender[MAX_PATH];
;1144:	bot_state_t *bs;
;1145:	int errnum;
;1146:
;1147:	if (!botstates[client]) botstates[client] = G_Alloc(sizeof(bot_state_t));
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $546
CNSTI4 9092
ARGI4
ADDRLP4 440
ADDRGP4 G_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
ADDRLP4 440
INDIRP4
ASGNP4
LABELV $546
line 1148
;1148:	bs = botstates[client];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 1149
;1149:	if ( bs == NULL ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $548
line 1150
;1150:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $545
JUMPV
LABELV $548
line 1153
;1151:	}
;1152:
;1153:	if (bs && bs->inuse) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $550
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $550
line 1154
;1154:		BotAI_Print(PRT_FATAL, "BotAISetupClient: client %d already setup\n", client);
CNSTI4 4
ARGI4
ADDRGP4 $552
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 1155
;1155:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $545
JUMPV
LABELV $550
line 1158
;1156:	}
;1157:
;1158:	if (!trap_AAS_Initialized()) {
ADDRLP4 448
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 448
INDIRI4
CNSTI4 0
NEI4 $553
line 1159
;1159:		BotAI_Print(PRT_FATAL, "AAS not initialized\n");
CNSTI4 4
ARGI4
ADDRGP4 $555
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1160
;1160:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $545
JUMPV
LABELV $553
line 1164
;1161:	}
;1162:
;1163:	//load the bot character
;1164:	bs->character = trap_BotLoadCharacter(settings->characterfile, settings->skill);
ADDRLP4 452
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 452
INDIRP4
ARGP4
ADDRLP4 452
INDIRP4
CNSTI4 144
ADDP4
INDIRF4
ARGF4
ADDRLP4 456
ADDRGP4 trap_BotLoadCharacter
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
ADDRLP4 456
INDIRI4
ASGNI4
line 1165
;1165:	if (!bs->character) {
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $556
line 1166
;1166:		BotAI_Print(PRT_FATAL, "couldn't load skill %f from %s\n", settings->skill, settings->characterfile);
CNSTI4 4
ARGI4
ADDRGP4 $558
ARGP4
ADDRLP4 460
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 460
INDIRP4
CNSTI4 144
ADDP4
INDIRF4
ARGF4
ADDRLP4 460
INDIRP4
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1167
;1167:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $545
JUMPV
LABELV $556
line 1170
;1168:	}
;1169:	//copy the settings
;1170:	memcpy(&bs->settings, settings, sizeof(bot_settings_t));
ADDRLP4 0
INDIRP4
CNSTI4 4608
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 292
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1172
;1171:	//allocate a goal state
;1172:	bs->gs = trap_BotAllocGoalState(client);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 460
ADDRGP4 trap_BotAllocGoalState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 6528
ADDP4
ADDRLP4 460
INDIRI4
ASGNI4
line 1174
;1173:	//load the item weights
;1174:	trap_Characteristic_String(bs->character, CHARACTERISTIC_ITEMWEIGHTS, filename, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 40
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1175
;1175:	errnum = trap_BotLoadItemWeights(bs->gs, filename);
ADDRLP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 464
ADDRGP4 trap_BotLoadItemWeights
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 464
INDIRI4
ASGNI4
line 1176
;1176:	if (errnum != BLERR_NOERROR) {
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $559
line 1177
;1177:		trap_BotFreeGoalState(bs->gs);
ADDRLP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeGoalState
CALLV
pop
line 1178
;1178:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $545
JUMPV
LABELV $559
line 1181
;1179:	}
;1180:	//allocate a weapon state
;1181:	bs->ws = trap_BotAllocWeaponState();
ADDRLP4 468
ADDRGP4 trap_BotAllocWeaponState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 6536
ADDP4
ADDRLP4 468
INDIRI4
ASGNI4
line 1183
;1182:	//load the weapon weights
;1183:	trap_Characteristic_String(bs->character, CHARACTERISTIC_WEAPONWEIGHTS, filename, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1184
;1184:	errnum = trap_BotLoadWeaponWeights(bs->ws, filename);
ADDRLP4 0
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 472
ADDRGP4 trap_BotLoadWeaponWeights
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 472
INDIRI4
ASGNI4
line 1185
;1185:	if (errnum != BLERR_NOERROR) {
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $561
line 1186
;1186:		trap_BotFreeGoalState(bs->gs);
ADDRLP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeGoalState
CALLV
pop
line 1187
;1187:		trap_BotFreeWeaponState(bs->ws);
ADDRLP4 0
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeWeaponState
CALLV
pop
line 1188
;1188:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $545
JUMPV
LABELV $561
line 1191
;1189:	}
;1190:	//allocate a chat state
;1191:	bs->cs = trap_BotAllocChatState();
ADDRLP4 476
ADDRGP4 trap_BotAllocChatState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 6532
ADDP4
ADDRLP4 476
INDIRI4
ASGNI4
line 1193
;1192:	//load the chat file
;1193:	trap_Characteristic_String(bs->character, CHARACTERISTIC_CHAT_FILE, filename, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 21
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1194
;1194:	trap_Characteristic_String(bs->character, CHARACTERISTIC_CHAT_NAME, name, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 22
ARGI4
ADDRLP4 296
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1195
;1195:	errnum = trap_BotLoadChatFile(bs->cs, filename, name);
ADDRLP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 296
ARGP4
ADDRLP4 480
ADDRGP4 trap_BotLoadChatFile
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 480
INDIRI4
ASGNI4
line 1196
;1196:	if (errnum != BLERR_NOERROR) {
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $563
line 1197
;1197:		trap_BotFreeChatState(bs->cs);
ADDRLP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeChatState
CALLV
pop
line 1198
;1198:		trap_BotFreeGoalState(bs->gs);
ADDRLP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeGoalState
CALLV
pop
line 1199
;1199:		trap_BotFreeWeaponState(bs->ws);
ADDRLP4 0
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeWeaponState
CALLV
pop
line 1200
;1200:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $545
JUMPV
LABELV $563
line 1203
;1201:	}
;1202:	//get the gender characteristic
;1203:	trap_Characteristic_String(bs->character, CHARACTERISTIC_GENDER, gender, MAX_PATH);
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 152
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 1205
;1204:	//set the chat gender
;1205:	if (*gender == 'f' || *gender == 'F') trap_BotSetChatGender(bs->cs, CHAT_GENDERFEMALE);
ADDRLP4 484
ADDRLP4 152
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 484
INDIRI4
CNSTI4 102
EQI4 $567
ADDRLP4 484
INDIRI4
CNSTI4 70
NEI4 $565
LABELV $567
ADDRLP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
ADDRGP4 $566
JUMPV
LABELV $565
line 1206
;1206:	else if (*gender == 'm' || *gender == 'M') trap_BotSetChatGender(bs->cs, CHAT_GENDERMALE);
ADDRLP4 488
ADDRLP4 152
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 488
INDIRI4
CNSTI4 109
EQI4 $570
ADDRLP4 488
INDIRI4
CNSTI4 77
NEI4 $568
LABELV $570
ADDRLP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
ADDRGP4 $569
JUMPV
LABELV $568
line 1207
;1207:	else trap_BotSetChatGender(bs->cs, CHAT_GENDERLESS);
ADDRLP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotSetChatGender
CALLV
pop
LABELV $569
LABELV $566
line 1209
;1208:
;1209:	bs->inuse = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 1
ASGNI4
line 1210
;1210:	bs->client = client;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1211
;1211:	bs->entitynum = client;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1212
;1212:	bs->setupcount = 4;
ADDRLP4 0
INDIRP4
CNSTI4 6016
ADDP4
CNSTI4 4
ASGNI4
line 1213
;1213:	bs->entergame_time = FloatTime();
ADDRLP4 0
INDIRP4
CNSTI4 6064
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1214
;1214:	bs->ms = trap_BotAllocMoveState();
ADDRLP4 492
ADDRGP4 trap_BotAllocMoveState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 6524
ADDP4
ADDRLP4 492
INDIRI4
ASGNI4
line 1215
;1215:	bs->walker = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_WALKER, 0, 1);
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 48
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 500
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 6056
ADDP4
ADDRLP4 500
INDIRF4
ASGNF4
line 1216
;1216:	numbots++;
ADDRLP4 504
ADDRGP4 numbots
ASGNP4
ADDRLP4 504
INDIRP4
ADDRLP4 504
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1218
;1217:
;1218:	if (trap_Cvar_VariableIntegerValue("bot_testichat")) {
ADDRGP4 $573
ARGP4
ADDRLP4 508
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 508
INDIRI4
CNSTI4 0
EQI4 $571
line 1219
;1219:		trap_BotLibVarSet("bot_testichat", "1");
ADDRGP4 $573
ARGP4
ADDRGP4 $342
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1220
;1220:		BotChatTest(bs);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BotChatTest
CALLV
pop
line 1221
;1221:	}
LABELV $571
line 1223
;1222:	//NOTE: reschedule the bot thinking
;1223:	BotScheduleBotThink();
ADDRGP4 BotScheduleBotThink
CALLV
pop
line 1225
;1224:	//if interbreeding start with a mutation
;1225:	if (bot_interbreed) {
ADDRGP4 bot_interbreed
INDIRI4
CNSTI4 0
EQI4 $574
line 1226
;1226:		trap_BotMutateGoalFuzzyLogic(bs->gs, 1);
ADDRLP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_BotMutateGoalFuzzyLogic
CALLV
pop
line 1227
;1227:	}
LABELV $574
line 1229
;1228:	// if we kept the bot client
;1229:	if (restart) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $576
line 1230
;1230:		BotReadSessionData(bs);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BotReadSessionData
CALLV
pop
line 1231
;1231:	}
LABELV $576
line 1233
;1232:	//bot has been setup succesfully
;1233:	return qtrue;
CNSTI4 1
RETI4
LABELV $545
endproc BotAISetupClient 512 16
export BotAIShutdownClient
proc BotAIShutdownClient 16 12
line 1241
;1234:}
;1235:
;1236:/*
;1237:==============
;1238:BotAIShutdownClient
;1239:==============
;1240:*/
;1241:int BotAIShutdownClient(int client, qboolean restart) {
line 1244
;1242:	bot_state_t *bs;
;1243:
;1244:	bs = botstates[client];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 1245
;1245:	if (!bs || !bs->inuse) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $581
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $579
LABELV $581
line 1247
;1246:		//BotAI_Print(PRT_ERROR, "BotAIShutdownClient: client %d already shutdown\n", client);
;1247:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $578
JUMPV
LABELV $579
line 1250
;1248:	}
;1249:
;1250:	if (restart) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $582
line 1251
;1251:		BotWriteSessionData(bs);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BotWriteSessionData
CALLV
pop
line 1252
;1252:	}
LABELV $582
line 1254
;1253:
;1254:	if (BotChat_ExitGame(bs)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotChat_ExitGame
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $584
line 1255
;1255:		trap_BotEnterChat(bs->cs, bs->client, CHAT_ALL);
ADDRLP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1256
;1256:	}
LABELV $584
line 1258
;1257:
;1258:	trap_BotFreeMoveState(bs->ms);
ADDRLP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeMoveState
CALLV
pop
line 1260
;1259:	//free the goal state
;1260:	trap_BotFreeGoalState(bs->gs);
ADDRLP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeGoalState
CALLV
pop
line 1262
;1261:	//free the chat file
;1262:	trap_BotFreeChatState(bs->cs);
ADDRLP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeChatState
CALLV
pop
line 1264
;1263:	//free the weapon weights
;1264:	trap_BotFreeWeaponState(bs->ws);
ADDRLP4 0
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeWeaponState
CALLV
pop
line 1266
;1265:	//free the bot character
;1266:	trap_BotFreeCharacter(bs->character);
ADDRLP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeCharacter
CALLV
pop
line 1268
;1267:	//
;1268:	BotFreeWaypoints(bs->checkpoints);
ADDRLP4 0
INDIRP4
CNSTI4 9076
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 1269
;1269:	BotFreeWaypoints(bs->patrolpoints);
ADDRLP4 0
INDIRP4
CNSTI4 9080
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 1271
;1270:	//clear activate goal stack
;1271:	BotClearActivateGoalStack(bs);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BotClearActivateGoalStack
CALLV
pop
line 1273
;1272:	//clear the bot state
;1273:	memset(bs, 0, sizeof(bot_state_t));
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 9092
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1275
;1274:	//set the inuse flag to qfalse
;1275:	bs->inuse = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1277
;1276:	//there's one bot less
;1277:	numbots--;
ADDRLP4 12
ADDRGP4 numbots
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1279
;1278:	//everything went ok
;1279:	return qtrue;
CNSTI4 1
RETI4
LABELV $578
endproc BotAIShutdownClient 16 12
export BotResetState
proc BotResetState 796 12
line 1291
;1280:}
;1281:
;1282:
;1283:/*
;1284:==============
;1285:BotResetState
;1286:
;1287:called when a bot enters the intermission or observer mode and
;1288:when the level is changed
;1289:==============
;1290:*/
;1291:void BotResetState(bot_state_t *bs) {
line 1300
;1292:	int client, entitynum, inuse;
;1293:	int movestate, goalstate, chatstate, weaponstate;
;1294:	bot_settings_t settings;
;1295:	int character;
;1296:	playerState_t ps;							//current player state
;1297:	float entergame_time;
;1298:
;1299:	//save some things that should not be reset here
;1300:	memcpy(&settings, &bs->settings, sizeof(bot_settings_t));
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4608
ADDP4
ARGP4
CNSTI4 292
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1301
;1301:	memcpy(&ps, &bs->cur_ps, sizeof(playerState_t));
ADDRLP4 324
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 468
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1302
;1302:	inuse = bs->inuse;
ADDRLP4 8
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 1303
;1303:	client = bs->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1304
;1304:	entitynum = bs->entitynum;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1305
;1305:	character = bs->character;
ADDRLP4 320
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ASGNI4
line 1306
;1306:	movestate = bs->ms;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ASGNI4
line 1307
;1307:	goalstate = bs->gs;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ASGNI4
line 1308
;1308:	chatstate = bs->cs;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ASGNI4
line 1309
;1309:	weaponstate = bs->ws;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ASGNI4
line 1310
;1310:	entergame_time = bs->entergame_time;
ADDRLP4 792
ADDRFP4 0
INDIRP4
CNSTI4 6064
ADDP4
INDIRF4
ASGNF4
line 1312
;1311:	//free checkpoints and patrol points
;1312:	BotFreeWaypoints(bs->checkpoints);
ADDRFP4 0
INDIRP4
CNSTI4 9076
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 1313
;1313:	BotFreeWaypoints(bs->patrolpoints);
ADDRFP4 0
INDIRP4
CNSTI4 9080
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotFreeWaypoints
CALLV
pop
line 1315
;1314:	//reset the whole state
;1315:	memset(bs, 0, sizeof(bot_state_t));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 9092
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1317
;1316:	//copy back some state stuff that should not be reset
;1317:	bs->ms = movestate;
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1318
;1318:	bs->gs = goalstate;
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1319
;1319:	bs->cs = chatstate;
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 1320
;1320:	bs->ws = weaponstate;
ADDRFP4 0
INDIRP4
CNSTI4 6536
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 1321
;1321:	memcpy(&bs->cur_ps, &ps, sizeof(playerState_t));
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 324
ARGP4
CNSTI4 468
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1322
;1322:	memcpy(&bs->settings, &settings, sizeof(bot_settings_t));
ADDRFP4 0
INDIRP4
CNSTI4 4608
ADDP4
ARGP4
ADDRLP4 28
ARGP4
CNSTI4 292
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1323
;1323:	bs->inuse = inuse;
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ASGNI4
line 1324
;1324:	bs->client = client;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1325
;1325:	bs->entitynum = entitynum;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 1326
;1326:	bs->character = character;
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
ADDRLP4 320
INDIRI4
ASGNI4
line 1327
;1327:	bs->entergame_time = entergame_time;
ADDRFP4 0
INDIRP4
CNSTI4 6064
ADDP4
ADDRLP4 792
INDIRF4
ASGNF4
line 1329
;1328:	//reset several states
;1329:	if (bs->ms) trap_BotResetMoveState(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
CNSTI4 0
EQI4 $587
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetMoveState
CALLV
pop
LABELV $587
line 1330
;1330:	if (bs->gs) trap_BotResetGoalState(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
CNSTI4 0
EQI4 $589
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetGoalState
CALLV
pop
LABELV $589
line 1331
;1331:	if (bs->ws) trap_BotResetWeaponState(bs->ws);
ADDRFP4 0
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
CNSTI4 0
EQI4 $591
ADDRFP4 0
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetWeaponState
CALLV
pop
LABELV $591
line 1332
;1332:	if (bs->gs) trap_BotResetAvoidGoals(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
CNSTI4 0
EQI4 $593
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidGoals
CALLV
pop
LABELV $593
line 1333
;1333:	if (bs->ms) trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
CNSTI4 0
EQI4 $595
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
LABELV $595
line 1334
;1334:}
LABELV $586
endproc BotResetState 796 12
export BotAILoadMap
proc BotAILoadMap 1040 12
line 1341
;1335:
;1336:/*
;1337:==============
;1338:BotAILoadMap
;1339:==============
;1340:*/
;1341:int BotAILoadMap( int restart ) {
line 1345
;1342:	char		serverinfo[MAX_INFO_STRING];
;1343:	int			i;
;1344:
;1345:	trap_GetServerinfo( serverinfo, sizeof( serverinfo ) );
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetServerinfo
CALLV
pop
line 1346
;1346:	Q_strncpyz( mapname, Info_ValueForKey( serverinfo, "mapname" ), sizeof( mapname ) );
ADDRLP4 4
ARGP4
ADDRGP4 $598
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 mapname
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1348
;1347:
;1348:	if ( !restart ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $599
line 1349
;1349:		trap_BotLibLoadMap( mapname );
ADDRGP4 mapname
ARGP4
ADDRGP4 trap_BotLibLoadMap
CALLI4
pop
line 1350
;1350:	}
LABELV $599
line 1352
;1351:
;1352:	for ( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $604
JUMPV
LABELV $601
line 1353
;1353:		if ( botstates[i] && botstates[i]->inuse ) {
ADDRLP4 1036
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1036
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $606
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1036
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $606
line 1354
;1354:			BotResetState( botstates[i] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotResetState
CALLV
pop
line 1355
;1355:			botstates[i]->setupcount = 4;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 6016
ADDP4
CNSTI4 4
ASGNI4
line 1356
;1356:		}
LABELV $606
line 1357
;1357:	}
LABELV $602
line 1352
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $604
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $601
line 1359
;1358:
;1359:	BotSetupDeathmatchAI();
ADDRGP4 BotSetupDeathmatchAI
CALLV
pop
line 1361
;1360:
;1361:	return qtrue;
CNSTI4 1
RETI4
LABELV $597
endproc BotAILoadMap 1040 12
bss
align 4
LABELV $609
skip 4
align 4
LABELV $610
skip 4
align 4
LABELV $611
skip 4
align 4
LABELV $612
skip 4096
align 4
LABELV $613
skip 4
export BotAIStartFrame
code
proc BotAIStartFrame 156 12
line 1371
;1362:}
;1363:
;1364:void ProximityMine_Trigger( gentity_t *trigger, gentity_t *other, trace_t *trace );
;1365:
;1366:/*
;1367:==================
;1368:BotAIStartFrame
;1369:==================
;1370:*/
;1371:int BotAIStartFrame(int time) {
line 1381
;1372:	int i;
;1373:	gentity_t	*ent;
;1374:	bot_entitystate_t state;
;1375:	int elapsed_time, thinktime;
;1376:	static int local_time;
;1377:	static int botlib_residual;
;1378:	static int lastbotthink_time;
;1379:	static qboolean skip[MAX_GENTITIES], *s;
;1380:
;1381:	G_CheckBotSpawn();
ADDRGP4 G_CheckBotSpawn
CALLV
pop
line 1383
;1382:
;1383:	trap_Cvar_Update(&bot_rocketjump);
ADDRGP4 bot_rocketjump
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1384
;1384:	trap_Cvar_Update(&bot_grapple);
ADDRGP4 bot_grapple
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1385
;1385:	trap_Cvar_Update(&bot_fastchat);
ADDRGP4 bot_fastchat
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1386
;1386:	trap_Cvar_Update(&bot_nochat);
ADDRGP4 bot_nochat
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1387
;1387:	trap_Cvar_Update(&bot_testrchat);
ADDRGP4 bot_testrchat
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1388
;1388:	trap_Cvar_Update(&bot_thinktime);
ADDRGP4 bot_thinktime
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1389
;1389:	trap_Cvar_Update(&bot_memorydump);
ADDRGP4 bot_memorydump
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1390
;1390:	trap_Cvar_Update(&bot_saveroutingcache);
ADDRGP4 bot_saveroutingcache
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1391
;1391:	trap_Cvar_Update(&bot_pause);
ADDRGP4 bot_pause
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1392
;1392:	trap_Cvar_Update(&bot_report);
ADDRGP4 bot_report
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1394
;1393:
;1394:	if (bot_report.integer) {
ADDRGP4 bot_report+12
INDIRI4
CNSTI4 0
EQI4 $614
line 1397
;1395://		BotTeamplayReport();
;1396://		trap_Cvar_Set("bot_report", "0");
;1397:		BotUpdateInfoConfigStrings();
ADDRGP4 BotUpdateInfoConfigStrings
CALLV
pop
line 1398
;1398:	}
LABELV $614
line 1400
;1399:
;1400:	if (bot_pause.integer) {
ADDRGP4 bot_pause+12
INDIRI4
CNSTI4 0
EQI4 $617
line 1402
;1401:		// execute bot user commands every frame
;1402:		for( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $623
JUMPV
LABELV $620
line 1403
;1403:			if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 132
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 132
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $627
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 132
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $625
LABELV $627
line 1404
;1404:				continue;
ADDRGP4 $621
JUMPV
LABELV $625
line 1406
;1405:			}
;1406:			if( g_entities[i].client->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRI4
CNSTI4 832
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $628
line 1407
;1407:				continue;
ADDRGP4 $621
JUMPV
LABELV $628
line 1409
;1408:			}
;1409:			botstates[i]->lastucmd.forwardmove = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 509
ADDP4
CNSTI1 0
ASGNI1
line 1410
;1410:			botstates[i]->lastucmd.rightmove = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 510
ADDP4
CNSTI1 0
ASGNI1
line 1411
;1411:			botstates[i]->lastucmd.upmove = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 511
ADDP4
CNSTI1 0
ASGNI1
line 1412
;1412:			botstates[i]->lastucmd.buttons = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 504
ADDP4
CNSTI4 0
ASGNI4
line 1413
;1413:			botstates[i]->lastucmd.serverTime = time;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 488
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 1414
;1414:			trap_BotUserCommand(botstates[i]->client, &botstates[i]->lastucmd);
ADDRLP4 140
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 140
INDIRP4
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 140
INDIRP4
ADDP4
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRGP4 trap_BotUserCommand
CALLV
pop
line 1415
;1415:		}
LABELV $621
line 1402
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $623
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $620
line 1416
;1416:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $608
JUMPV
LABELV $617
line 1419
;1417:	}
;1418:
;1419:	if (bot_memorydump.integer) {
ADDRGP4 bot_memorydump+12
INDIRI4
CNSTI4 0
EQI4 $631
line 1420
;1420:		trap_BotLibVarSet("memorydump", "1");
ADDRGP4 $634
ARGP4
ADDRGP4 $342
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1421
;1421:		trap_Cvar_Set("bot_memorydump", "0");
ADDRGP4 $635
ARGP4
ADDRGP4 $636
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1422
;1422:	}
LABELV $631
line 1423
;1423:	if (bot_saveroutingcache.integer) {
ADDRGP4 bot_saveroutingcache+12
INDIRI4
CNSTI4 0
EQI4 $637
line 1424
;1424:		trap_BotLibVarSet("saveroutingcache", "1");
ADDRGP4 $640
ARGP4
ADDRGP4 $342
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1425
;1425:		trap_Cvar_Set("bot_saveroutingcache", "0");
ADDRGP4 $641
ARGP4
ADDRGP4 $636
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1426
;1426:	}
LABELV $637
line 1428
;1427:	//check if bot interbreeding is activated
;1428:	BotInterbreeding();
ADDRGP4 BotInterbreeding
CALLV
pop
line 1430
;1429:	//cap the bot think time
;1430:	if (bot_thinktime.integer > 200) {
ADDRGP4 bot_thinktime+12
INDIRI4
CNSTI4 200
LEI4 $642
line 1431
;1431:		trap_Cvar_Set("bot_thinktime", "200");
ADDRGP4 $645
ARGP4
ADDRGP4 $646
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1432
;1432:	}
LABELV $642
line 1434
;1433:	//if the bot think time changed we should reschedule the bots
;1434:	if (bot_thinktime.integer != lastbotthink_time) {
ADDRGP4 bot_thinktime+12
INDIRI4
ADDRGP4 $611
INDIRI4
EQI4 $647
line 1435
;1435:		lastbotthink_time = bot_thinktime.integer;
ADDRGP4 $611
ADDRGP4 bot_thinktime+12
INDIRI4
ASGNI4
line 1436
;1436:		BotScheduleBotThink();
ADDRGP4 BotScheduleBotThink
CALLV
pop
line 1437
;1437:	}
LABELV $647
line 1439
;1438:
;1439:	elapsed_time = time - local_time;
ADDRLP4 120
ADDRFP4 0
INDIRI4
ADDRGP4 $609
INDIRI4
SUBI4
ASGNI4
line 1440
;1440:	local_time = time;
ADDRGP4 $609
ADDRFP4 0
INDIRI4
ASGNI4
line 1442
;1441:
;1442:	botlib_residual += elapsed_time;
ADDRLP4 128
ADDRGP4 $610
ASGNP4
ADDRLP4 128
INDIRP4
ADDRLP4 128
INDIRP4
INDIRI4
ADDRLP4 120
INDIRI4
ADDI4
ASGNI4
line 1444
;1443:
;1444:	if (elapsed_time > bot_thinktime.integer) thinktime = elapsed_time;
ADDRLP4 120
INDIRI4
ADDRGP4 bot_thinktime+12
INDIRI4
LEI4 $651
ADDRLP4 124
ADDRLP4 120
INDIRI4
ASGNI4
ADDRGP4 $652
JUMPV
LABELV $651
line 1445
;1445:	else thinktime = bot_thinktime.integer;
ADDRLP4 124
ADDRGP4 bot_thinktime+12
INDIRI4
ASGNI4
LABELV $652
line 1448
;1446:
;1447:	// update the bot library
;1448:	if ( botlib_residual >= thinktime ) {
ADDRGP4 $610
INDIRI4
ADDRLP4 124
INDIRI4
LTI4 $655
line 1449
;1449:		botlib_residual -= thinktime;
ADDRLP4 132
ADDRGP4 $610
ASGNP4
ADDRLP4 132
INDIRP4
ADDRLP4 132
INDIRP4
INDIRI4
ADDRLP4 124
INDIRI4
SUBI4
ASGNI4
line 1451
;1450:
;1451:		trap_BotLibStartFrame((float) time / 1000);
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ARGF4
ADDRGP4 trap_BotLibStartFrame
CALLI4
pop
line 1453
;1452:
;1453:		if (!trap_AAS_Initialized()) return qfalse;
ADDRLP4 136
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
NEI4 $657
CNSTI4 0
RETI4
ADDRGP4 $608
JUMPV
LABELV $657
line 1456
;1454:
;1455:		//update entities in the botlib
;1456:		s = skip;
ADDRGP4 $613
ADDRGP4 $612
ASGNP4
line 1457
;1457:		ent = g_entities;
ADDRLP4 4
ADDRGP4 g_entities
ASGNP4
line 1458
;1458:		for ( i = 0; i < level.num_entities; i++, s++, ent++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $662
JUMPV
LABELV $659
line 1459
;1459:			ent = &g_entities[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 832
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1460
;1460:			if ( !ent->inuse || !ent->r.linked || ent->r.svFlags & SVF_NOCLIENT ) {
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $667
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
EQI4 $667
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $664
LABELV $667
line 1461
;1461:				if ( *s == qfalse ) {
ADDRGP4 $613
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $660
line 1462
;1462:					*s = qtrue;
ADDRGP4 $613
INDIRP4
CNSTI4 1
ASGNI4
line 1463
;1463:					trap_BotLibUpdateEntity( i, NULL );
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1464
;1464:				}
line 1465
;1465:				continue;
ADDRGP4 $660
JUMPV
LABELV $664
line 1468
;1466:			}
;1467:			// do not update missiles
;1468:			if ( ent->s.eType == ET_MISSILE && ent->s.weapon != WP_GRAPPLING_HOOK ) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $670
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 10
EQI4 $670
line 1469
;1469:				if ( *s == qfalse ) {
ADDRGP4 $613
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $660
line 1470
;1470:					*s = qtrue;
ADDRGP4 $613
INDIRP4
CNSTI4 1
ASGNI4
line 1471
;1471:					trap_BotLibUpdateEntity( i, NULL );
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1472
;1472:				}
line 1473
;1473:				continue;
ADDRGP4 $660
JUMPV
LABELV $670
line 1476
;1474:			}
;1475:			// do not update event only entities
;1476:			if ( ent->s.eType > ET_EVENTS ) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
LEI4 $674
line 1477
;1477:				if ( *s == qfalse ) {
ADDRGP4 $613
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $660
line 1478
;1478:					*s = qtrue;
ADDRGP4 $613
INDIRP4
CNSTI4 1
ASGNI4
line 1479
;1479:					trap_BotLibUpdateEntity( i, NULL );
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1480
;1480:				}
line 1481
;1481:				continue;
ADDRGP4 $660
JUMPV
LABELV $674
line 1484
;1482:			}
;1483:			// never link prox mine triggers
;1484:			if (ent->r.contents == CONTENTS_TRIGGER) {
ADDRLP4 4
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
CNSTI4 1073741824
NEI4 $678
line 1485
;1485:				if (ent->touch == ProximityMine_Trigger) {
ADDRLP4 4
INDIRP4
CNSTI4 704
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 ProximityMine_Trigger
CVPU4 4
NEU4 $680
line 1486
;1486:					trap_BotLibUpdateEntity(i, NULL);
ADDRLP4 0
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1487
;1487:					continue;
ADDRGP4 $660
JUMPV
LABELV $680
line 1489
;1488:				}
;1489:			}
LABELV $678
line 1491
;1490:			//
;1491:			memset(&state, 0, sizeof(bot_entitystate_t));
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
CNSTI4 112
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1493
;1492:			//
;1493:			VectorCopy(ent->r.currentOrigin, state.origin);
ADDRLP4 8+8
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 1494
;1494:			if (i < MAX_CLIENTS) {
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $683
line 1495
;1495:				VectorCopy(ent->s.apos.trBase, state.angles);
ADDRLP4 8+20
ADDRLP4 4
INDIRP4
CNSTI4 60
ADDP4
INDIRB
ASGNB 12
line 1496
;1496:			} else {
ADDRGP4 $684
JUMPV
LABELV $683
line 1497
;1497:				VectorCopy(ent->r.currentAngles, state.angles);
ADDRLP4 8+20
ADDRLP4 4
INDIRP4
CNSTI4 500
ADDP4
INDIRB
ASGNB 12
line 1498
;1498:			}
LABELV $684
line 1499
;1499:			VectorCopy(ent->s.origin2, state.old_origin);
ADDRLP4 8+32
ADDRLP4 4
INDIRP4
CNSTI4 104
ADDP4
INDIRB
ASGNB 12
line 1500
;1500:			VectorCopy(ent->r.mins, state.mins);
ADDRLP4 8+44
ADDRLP4 4
INDIRP4
CNSTI4 436
ADDP4
INDIRB
ASGNB 12
line 1501
;1501:			VectorCopy(ent->r.maxs, state.maxs);
ADDRLP4 8+56
ADDRLP4 4
INDIRP4
CNSTI4 448
ADDP4
INDIRB
ASGNB 12
line 1502
;1502:			state.type = ent->s.eType;
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1503
;1503:			state.flags = ent->s.eFlags;
ADDRLP4 8+4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1504
;1504:			if (ent->r.bmodel) state.solid = SOLID_BSP;
ADDRLP4 4
INDIRP4
CNSTI4 432
ADDP4
INDIRI4
CNSTI4 0
EQI4 $691
ADDRLP4 8+72
CNSTI4 3
ASGNI4
ADDRGP4 $692
JUMPV
LABELV $691
line 1505
;1505:			else state.solid = SOLID_BBOX;
ADDRLP4 8+72
CNSTI4 2
ASGNI4
LABELV $692
line 1506
;1506:			state.groundent = ent->s.groundEntityNum;
ADDRLP4 8+68
ADDRLP4 4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ASGNI4
line 1507
;1507:			state.modelindex = ent->s.modelindex;
ADDRLP4 8+76
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
line 1508
;1508:			state.modelindex2 = ent->s.modelindex2;
ADDRLP4 8+80
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ASGNI4
line 1509
;1509:			state.frame = ent->s.frame;
ADDRLP4 8+84
ADDRLP4 4
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ASGNI4
line 1510
;1510:			state.event = ent->s.event;
ADDRLP4 8+88
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ASGNI4
line 1511
;1511:			state.eventParm = ent->s.eventParm;
ADDRLP4 8+92
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 1512
;1512:			state.powerups = ent->s.powerups;
ADDRLP4 8+96
ADDRLP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
ASGNI4
line 1513
;1513:			state.legsAnim = ent->s.legsAnim;
ADDRLP4 8+104
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 1514
;1514:			state.torsoAnim = ent->s.torsoAnim;
ADDRLP4 8+108
ADDRLP4 4
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ASGNI4
line 1515
;1515:			state.weapon = ent->s.weapon;
ADDRLP4 8+100
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
line 1517
;1516:			//
;1517:			*s = qfalse;
ADDRGP4 $613
INDIRP4
CNSTI4 0
ASGNI4
line 1518
;1518:			trap_BotLibUpdateEntity( i, &state );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 trap_BotLibUpdateEntity
CALLI4
pop
line 1519
;1519:		}
LABELV $660
line 1458
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 140
ADDRGP4 $613
ASGNP4
ADDRLP4 140
INDIRP4
ADDRLP4 140
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 832
ADDP4
ASGNP4
LABELV $662
ADDRLP4 0
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $659
line 1521
;1520:
;1521:		BotAIRegularUpdate();
ADDRGP4 BotAIRegularUpdate
CALLV
pop
line 1522
;1522:	}
LABELV $655
line 1524
;1523:
;1524:	floattime = trap_AAS_Time();
ADDRLP4 132
ADDRGP4 trap_AAS_Time
CALLF4
ASGNF4
ADDRGP4 floattime
ADDRLP4 132
INDIRF4
ASGNF4
line 1527
;1525:
;1526:	// execute scheduled bot AI
;1527:	for( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $708
JUMPV
LABELV $705
line 1528
;1528:		if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 140
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 140
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $712
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 140
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $710
LABELV $712
line 1529
;1529:			continue;
ADDRGP4 $706
JUMPV
LABELV $710
line 1532
;1530:		}
;1531:		//
;1532:		botstates[i]->botthink_residual += elapsed_time;
ADDRLP4 144
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 144
INDIRP4
ADDRLP4 144
INDIRP4
INDIRI4
ADDRLP4 120
INDIRI4
ADDI4
ASGNI4
line 1534
;1533:		//
;1534:		if ( botstates[i]->botthink_residual >= thinktime ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 124
INDIRI4
LTI4 $713
line 1535
;1535:			botstates[i]->botthink_residual -= thinktime;
ADDRLP4 148
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRI4
ADDRLP4 124
INDIRI4
SUBI4
ASGNI4
line 1537
;1536:
;1537:			if (!trap_AAS_Initialized()) return qfalse;
ADDRLP4 152
ADDRGP4 trap_AAS_Initialized
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $715
CNSTI4 0
RETI4
ADDRGP4 $608
JUMPV
LABELV $715
line 1539
;1538:
;1539:			if (g_entities[i].client->pers.connected == CON_CONNECTED) {
ADDRLP4 0
INDIRI4
CNSTI4 832
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $717
line 1540
;1540:				BotAI(i, (float) thinktime / 1000);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 124
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ARGF4
ADDRGP4 BotAI
CALLI4
pop
line 1541
;1541:			}
LABELV $717
line 1542
;1542:		}
LABELV $713
line 1543
;1543:	}
LABELV $706
line 1527
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $708
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $705
line 1547
;1544:
;1545:
;1546:	// execute bot user commands every frame
;1547:	for( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $723
JUMPV
LABELV $720
line 1548
;1548:		if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 140
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 140
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $727
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 140
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $725
LABELV $727
line 1549
;1549:			continue;
ADDRGP4 $721
JUMPV
LABELV $725
line 1551
;1550:		}
;1551:		if( g_entities[i].client->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRI4
CNSTI4 832
MULI4
ADDRGP4 g_entities+516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $728
line 1552
;1552:			continue;
ADDRGP4 $721
JUMPV
LABELV $728
line 1555
;1553:		}
;1554:
;1555:		BotUpdateInput(botstates[i], time, elapsed_time);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 120
INDIRI4
ARGI4
ADDRGP4 BotUpdateInput
CALLV
pop
line 1556
;1556:		trap_BotUserCommand(botstates[i]->client, &botstates[i]->lastucmd);
ADDRLP4 148
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
INDIRP4
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
INDIRP4
ADDP4
INDIRP4
CNSTI4 488
ADDP4
ARGP4
ADDRGP4 trap_BotUserCommand
CALLV
pop
line 1557
;1557:	}
LABELV $721
line 1547
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $723
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $720
line 1559
;1558:
;1559:	return qtrue;
CNSTI4 1
RETI4
LABELV $608
endproc BotAIStartFrame 156 12
export BotInitLibrary
proc BotInitLibrary 260 16
line 1567
;1560:}
;1561:
;1562:/*
;1563:==============
;1564:BotInitLibrary
;1565:==============
;1566:*/
;1567:int BotInitLibrary( void ) {
line 1571
;1568:	char buf[MAX_CVAR_VALUE_STRING];
;1569:
;1570:	//set the maxclients and maxentities library variables before calling BotSetupLibrary
;1571:	trap_Cvar_VariableStringBuffer( "sv_maxclients", buf, sizeof( buf ) );
ADDRGP4 $732
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1572
;1572:	if ( !buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $733
line 1573
;1573:		strcpy( buf, "8" );
ADDRLP4 0
ARGP4
ADDRGP4 $735
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $733
line 1574
;1574:	trap_BotLibVarSet( "maxclients", buf );
ADDRGP4 $736
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1576
;1575:
;1576:	Com_sprintf(buf, sizeof(buf), "%d", MAX_GENTITIES);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $333
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1577
;1577:	trap_BotLibVarSet("maxentities", buf);
ADDRGP4 $737
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1579
;1578:	//bsp checksum
;1579:	trap_Cvar_VariableStringBuffer("sv_mapChecksum", buf, sizeof(buf));
ADDRGP4 $738
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1580
;1580:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $739
line 1581
;1581:		trap_BotLibVarSet( "sv_mapChecksum", buf );
ADDRGP4 $738
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $739
line 1584
;1582:
;1583:	//maximum number of aas links
;1584:	trap_Cvar_VariableStringBuffer("max_aaslinks", buf, sizeof(buf));
ADDRGP4 $741
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1585
;1585:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $742
line 1586
;1586:		trap_BotLibVarSet( "max_aaslinks", buf );
ADDRGP4 $741
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $742
line 1589
;1587:
;1588:	//maximum number of items in a level
;1589:	trap_Cvar_VariableStringBuffer("max_levelitems", buf, sizeof(buf));
ADDRGP4 $744
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1590
;1590:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $745
line 1591
;1591:		trap_BotLibVarSet( "max_levelitems", buf );
ADDRGP4 $744
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $745
line 1594
;1592:
;1593:	//game type
;1594:	trap_Cvar_VariableStringBuffer("g_gametype", buf, sizeof(buf));
ADDRGP4 $332
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1595
;1595:	if ( !buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $747
line 1596
;1596:		strcpy( buf, "0" );
ADDRLP4 0
ARGP4
ADDRGP4 $636
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $747
line 1597
;1597:	trap_BotLibVarSet("g_gametype", buf);
ADDRGP4 $332
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1599
;1598:	//bot developer mode and log file
;1599:	trap_BotLibVarSet("bot_developer", bot_developer.string);
ADDRGP4 $749
ARGP4
ADDRGP4 bot_developer+16
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1600
;1600:	trap_BotLibVarSet("log", buf);
ADDRGP4 $751
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1602
;1601:	//no chatting
;1602:	trap_Cvar_VariableStringBuffer("bot_nochat", buf, sizeof(buf));
ADDRGP4 $752
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1603
;1603:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $753
line 1604
;1604:		trap_BotLibVarSet( "nochat", "0" );
ADDRGP4 $755
ARGP4
ADDRGP4 $636
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $753
line 1607
;1605:
;1606:	//visualize jump pads
;1607:	trap_Cvar_VariableStringBuffer("bot_visualizejumppads", buf, sizeof(buf));
ADDRGP4 $756
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1608
;1608:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $757
line 1609
;1609:		trap_BotLibVarSet( "bot_visualizejumppads", buf );
ADDRGP4 $756
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $757
line 1612
;1610:	
;1611:	//forced clustering calculations
;1612:	trap_Cvar_VariableStringBuffer("bot_forceclustering", buf, sizeof(buf));
ADDRGP4 $759
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1613
;1613:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $760
line 1614
;1614:		trap_BotLibVarSet( "forceclustering", buf );
ADDRGP4 $762
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $760
line 1617
;1615:	
;1616:	//forced reachability calculations
;1617:	trap_Cvar_VariableStringBuffer("bot_forcereachability", buf, sizeof(buf));
ADDRGP4 $763
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1618
;1618:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $764
line 1619
;1619:		trap_BotLibVarSet( "forcereachability", buf );
ADDRGP4 $766
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $764
line 1622
;1620:	
;1621:	//force writing of AAS to file
;1622:	trap_Cvar_VariableStringBuffer("bot_forcewrite", buf, sizeof(buf));
ADDRGP4 $767
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1623
;1623:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $768
line 1624
;1624:		trap_BotLibVarSet( "forcewrite", buf );
ADDRGP4 $770
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $768
line 1627
;1625:	
;1626:	//no AAS optimization
;1627:	trap_Cvar_VariableStringBuffer("bot_aasoptimize", buf, sizeof(buf));
ADDRGP4 $771
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1628
;1628:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $772
line 1629
;1629:		trap_BotLibVarSet( "aasoptimize", buf );
ADDRGP4 $774
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $772
line 1632
;1630:	
;1631:	//
;1632:	trap_Cvar_VariableStringBuffer("bot_saveroutingcache", buf, sizeof(buf));
ADDRGP4 $641
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1633
;1633:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $775
line 1634
;1634:		trap_BotLibVarSet( "saveroutingcache", buf );
ADDRGP4 $640
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $775
line 1637
;1635:	
;1636:	//reload instead of cache bot character files
;1637:	trap_Cvar_VariableStringBuffer("bot_reloadcharacters", buf, sizeof(buf));
ADDRGP4 $341
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1638
;1638:	if ( !buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $777
line 1639
;1639:		strcpy( buf, "0" );
ADDRLP4 0
ARGP4
ADDRGP4 $636
ARGP4
ADDRGP4 strcpy
CALLP4
pop
LABELV $777
line 1640
;1640:	trap_BotLibVarSet("bot_reloadcharacters", buf);
ADDRGP4 $341
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 1642
;1641:	//base directory
;1642:	trap_Cvar_VariableStringBuffer("fs_basepath", buf, sizeof(buf));
ADDRGP4 $779
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1643
;1643:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $780
line 1644
;1644:		trap_BotLibVarSet( "basedir", buf );
ADDRGP4 $782
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $780
line 1647
;1645:
;1646:	//home directory
;1647:	trap_Cvar_VariableStringBuffer("fs_homepath", buf, sizeof(buf));
ADDRGP4 $783
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1648
;1648:	if ( buf[0] )
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $784
line 1649
;1649:		trap_BotLibVarSet( "homedir", buf );
ADDRGP4 $786
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $784
line 1652
;1650:
;1651:	//game directory
;1652:	trap_Cvar_VariableStringBuffer( "fs_game", buf, sizeof( buf ) );
ADDRGP4 $787
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 1653
;1653:	if ( buf[0] ) 
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $788
line 1654
;1654:		trap_BotLibVarSet( "gamedir", buf );
ADDRGP4 $790
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
LABELV $788
line 1656
;1655:
;1656:	trap_BotLibDefine("MISSIONPACK");
ADDRGP4 $791
ARGP4
ADDRGP4 trap_BotLibDefine
CALLI4
pop
line 1659
;1657:
;1658:	//setup the bot library
;1659:	return trap_BotLibSetup();
ADDRLP4 256
ADDRGP4 trap_BotLibSetup
CALLI4
ASGNI4
ADDRLP4 256
INDIRI4
RETI4
LABELV $731
endproc BotInitLibrary 260 16
export BotAISetup
proc BotAISetup 8 16
line 1667
;1660:}
;1661:
;1662:/*
;1663:==============
;1664:BotAISetup
;1665:==============
;1666:*/
;1667:int BotAISetup( int restart ) {
line 1670
;1668:	int			errnum;
;1669:
;1670:	trap_Cvar_Register(&bot_thinktime, "bot_thinktime", "100", CVAR_CHEAT);
ADDRGP4 bot_thinktime
ARGP4
ADDRGP4 $645
ARGP4
ADDRGP4 $793
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1671
;1671:	trap_Cvar_Register(&bot_memorydump, "bot_memorydump", "0", CVAR_CHEAT);
ADDRGP4 bot_memorydump
ARGP4
ADDRGP4 $635
ARGP4
ADDRGP4 $636
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1672
;1672:	trap_Cvar_Register(&bot_saveroutingcache, "bot_saveroutingcache", "0", CVAR_CHEAT);
ADDRGP4 bot_saveroutingcache
ARGP4
ADDRGP4 $641
ARGP4
ADDRGP4 $636
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1673
;1673:	trap_Cvar_Register(&bot_pause, "bot_pause", "0", CVAR_CHEAT);
ADDRGP4 bot_pause
ARGP4
ADDRGP4 $794
ARGP4
ADDRGP4 $636
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1674
;1674:	trap_Cvar_Register(&bot_report, "bot_report", "0", CVAR_CHEAT);
ADDRGP4 bot_report
ARGP4
ADDRGP4 $795
ARGP4
ADDRGP4 $636
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1675
;1675:	trap_Cvar_Register(&bot_testsolid, "bot_testsolid", "0", CVAR_CHEAT);
ADDRGP4 bot_testsolid
ARGP4
ADDRGP4 $796
ARGP4
ADDRGP4 $636
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1676
;1676:	trap_Cvar_Register(&bot_testclusters, "bot_testclusters", "0", CVAR_CHEAT);
ADDRGP4 bot_testclusters
ARGP4
ADDRGP4 $797
ARGP4
ADDRGP4 $636
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1677
;1677:	trap_Cvar_Register(&bot_developer, "bot_developer", "0", CVAR_CHEAT);
ADDRGP4 bot_developer
ARGP4
ADDRGP4 $749
ARGP4
ADDRGP4 $636
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1678
;1678:	trap_Cvar_Register(&bot_interbreedchar, "bot_interbreedchar", "", 0);
ADDRGP4 bot_interbreedchar
ARGP4
ADDRGP4 $351
ARGP4
ADDRGP4 $325
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1679
;1679:	trap_Cvar_Register(&bot_interbreedbots, "bot_interbreedbots", "10", 0);
ADDRGP4 bot_interbreedbots
ARGP4
ADDRGP4 $798
ARGP4
ADDRGP4 $799
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1680
;1680:	trap_Cvar_Register(&bot_interbreedcycle, "bot_interbreedcycle", "20", 0);
ADDRGP4 bot_interbreedcycle
ARGP4
ADDRGP4 $800
ARGP4
ADDRGP4 $801
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1681
;1681:	trap_Cvar_Register(&bot_interbreedwrite, "bot_interbreedwrite", "", 0);
ADDRGP4 bot_interbreedwrite
ARGP4
ADDRGP4 $324
ARGP4
ADDRGP4 $325
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 1684
;1682:
;1683:	//if the game is restarted for a tournament
;1684:	if (restart) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $802
line 1685
;1685:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $792
JUMPV
LABELV $802
line 1689
;1686:	}
;1687:
;1688:	//initialize the bot states
;1689:	memset( botstates, 0, sizeof(botstates) );
ADDRGP4 botstates
ARGP4
CNSTI4 0
ARGI4
CNSTI4 256
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1691
;1690:
;1691:	errnum = BotInitLibrary();
ADDRLP4 4
ADDRGP4 BotInitLibrary
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1692
;1692:	if ( errnum != BLERR_NOERROR )
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $804
line 1693
;1693:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $792
JUMPV
LABELV $804
line 1695
;1694:
;1695:	return qtrue;
CNSTI4 1
RETI4
LABELV $792
endproc BotAISetup 8 16
export BotAIShutdown
proc BotAIShutdown 12 8
line 1703
;1696:}
;1697:
;1698:/*
;1699:==============
;1700:BotAIShutdown
;1701:==============
;1702:*/
;1703:int BotAIShutdown( int restart ) {
line 1708
;1704:
;1705:	int i;
;1706:
;1707:	//if the game is restarted for a tournament
;1708:	if ( restart ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $807
line 1710
;1709:		//shutdown all the bots in the botlib
;1710:		for ( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $812
JUMPV
LABELV $809
line 1711
;1711:			if ( botstates[i] && botstates[i]->inuse ) {
ADDRLP4 8
ADDRGP4 botstates
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $814
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $814
line 1712
;1712:				BotAIShutdownClient(botstates[i]->client, restart);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 BotAIShutdownClient
CALLI4
pop
line 1713
;1713:			}
LABELV $814
line 1714
;1714:		}
LABELV $810
line 1710
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $812
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $809
line 1716
;1715:		//don't shutdown the bot library
;1716:	}
ADDRGP4 $808
JUMPV
LABELV $807
line 1717
;1717:	else {
line 1718
;1718:		trap_BotLibShutdown();
ADDRGP4 trap_BotLibShutdown
CALLI4
pop
line 1719
;1719:	}
LABELV $808
line 1720
;1720:	return qtrue;
CNSTI4 1
RETI4
LABELV $806
endproc BotAIShutdown 12 8
import ProximityMine_Trigger
import ExitLevel
bss
export bot_interbreedwrite
align 4
LABELV bot_interbreedwrite
skip 272
export bot_interbreedcycle
align 4
LABELV bot_interbreedcycle
skip 272
export bot_interbreedbots
align 4
LABELV bot_interbreedbots
skip 272
export bot_interbreedchar
align 4
LABELV bot_interbreedchar
skip 272
export bot_developer
align 4
LABELV bot_developer
skip 272
export bot_testclusters
align 4
LABELV bot_testclusters
skip 272
export bot_testsolid
align 4
LABELV bot_testsolid
skip 272
export bot_report
align 4
LABELV bot_report
skip 272
export bot_pause
align 4
LABELV bot_pause
skip 272
export bot_saveroutingcache
align 4
LABELV bot_saveroutingcache
skip 272
export bot_memorydump
align 4
LABELV bot_memorydump
skip 272
export bot_thinktime
align 4
LABELV bot_thinktime
skip 272
export bot_interbreedmatchcount
align 4
LABELV bot_interbreedmatchcount
skip 4
export bot_interbreed
align 4
LABELV bot_interbreed
skip 4
export regularupdate_time
align 4
LABELV regularupdate_time
skip 4
export numbots
align 4
LABELV numbots
skip 4
export botstates
align 4
LABELV botstates
skip 256
import BotDumpNodeSwitches
import BotResetNodeSwitches
import AINode_Battle_NBG
import AINode_Battle_Retreat
import AINode_Battle_Chase
import AINode_Battle_Fight
import AINode_Seek_LTG
import AINode_Seek_NBG
import AINode_Seek_ActivateEntity
import AINode_Stand
import AINode_Respawn
import AINode_Observer
import AINode_Intermission
import AIEnter_Battle_NBG
import AIEnter_Battle_Retreat
import AIEnter_Battle_Chase
import AIEnter_Battle_Fight
import AIEnter_Seek_Camp
import AIEnter_Seek_LTG
import AIEnter_Seek_NBG
import AIEnter_Seek_ActivateEntity
import AIEnter_Stand
import AIEnter_Respawn
import AIEnter_Observer
import AIEnter_Intermission
import BotPrintTeamGoal
import BotMatchMessage
import notleader
import BotChatTest
import BotValidChatPosition
import BotChatTime
import BotChat_Random
import BotChat_EnemySuicide
import BotChat_Kill
import BotChat_Death
import BotChat_HitNoKill
import BotChat_HitNoDeath
import BotChat_HitTalking
import BotChat_EndLevel
import BotChat_StartLevel
import BotChat_ExitGame
import BotChat_EnterGame
import neutralobelisk
import blueobelisk
import redobelisk
import ctf_neutralflag
import ctf_blueflag
import ctf_redflag
import bot_challenge
import bot_testrchat
import bot_nochat
import bot_fastchat
import bot_rocketjump
import bot_grapple
export mapname
align 1
LABELV mapname
skip 64
import gametype
import BotMapScripts
import BotPointAreaNum
import ClientOnSameTeamFromName
import ClientFromName
import stristr
import BotFindWayPoint
import BotCreateWayPoint
import BotAlternateRoute
import BotGetAlternateRouteGoal
import BotEnemySkullCarrierVisible
import BotTeamSkullCarrierVisible
import BotHarvesterRetreatGoals
import BotHarvesterSeekGoals
import BotGoHarvest
import BotObeliskRetreatGoals
import BotObeliskSeekGoals
import Bot1FCTFRetreatGoals
import Bot1FCTFSeekGoals
import BotHarvesterCarryingSkulls
import Bot1FCTFCarryingFlag
import BotCTFRetreatGoals
import BotCTFSeekGoals
import BotRememberLastOrderedTask
import BotCTFCarryingFlag
import BotOppositeTeam
import BotTeam
import BotClearActivateGoalStack
import BotPopFromActivateGoalStack
import BotEnableActivateGoalAreas
import BotAIPredictObstacles
import BotAIBlocked
import BotCheckAttack
import BotAimAtEnemy
import BotEntityVisible
import BotRoamGoal
import BotFindEnemy
import InFieldOfVision
import BotVisibleTeamMatesAndEnemies
import BotEnemyFlagCarrierVisible
import BotTeamFlagCarrierVisible
import BotTeamFlagCarrier
import TeamPlayIsOn
import BotSameTeam
import BotAttackMove
import BotWantsToCamp
import BotHasPersistantPowerupAndWeapon
import BotCanAndWantsToRocketJump
import BotWantsToHelp
import BotWantsToChase
import BotWantsToRetreat
import BotFeelingBad
import BotAggression
import BotTeamGoals
import BotSetLastOrderedTask
import BotSynonymContext
import ClientSkin
import EasyClientName
import ClientName
import BotSetTeamStatus
import EntityHasKamikaze
import EntityIsShooting
import EntityIsInvisible
import EntityIsDead
import BotInLavaOrSlime
import BotIntermission
import BotIsObserver
import BotIsDead
import BotBattleUseItems
import BotUpdateBattleInventory
import BotUpdateInventory
import BotSetupForMovement
import BotChooseWeapon
import BotFreeWaypoints
import BotDeathmatchAI
import BotShutdownDeathmatchAI
import BotSetupDeathmatchAI
export floattime
align 4
LABELV floattime
skip 4
import BotResetWeaponState
import BotFreeWeaponState
import BotAllocWeaponState
import BotLoadWeaponWeights
import BotGetWeaponInfo
import BotChooseBestFightWeapon
import BotShutdownWeaponAI
import BotSetupWeaponAI
import BotShutdownMoveAI
import BotSetupMoveAI
import BotSetBrushModelTypes
import BotAddAvoidSpot
import BotInitMoveState
import BotFreeMoveState
import BotAllocMoveState
import BotPredictVisiblePosition
import BotMovementViewTarget
import BotReachabilityArea
import BotResetLastAvoidReach
import BotResetAvoidReach
import BotMoveInDirection
import BotMoveToGoal
import BotResetMoveState
import BotShutdownGoalAI
import BotSetupGoalAI
import BotFreeGoalState
import BotAllocGoalState
import BotFreeItemWeights
import BotLoadItemWeights
import BotMutateGoalFuzzyLogic
import BotSaveGoalFuzzyLogic
import BotInterbreedGoalFuzzyLogic
import BotUpdateEntityItems
import BotInitLevelItems
import BotSetAvoidGoalTime
import BotAvoidGoalTime
import BotGetMapLocationGoal
import BotGetNextCampSpotGoal
import BotGetLevelItemGoal
import BotItemGoalInVisButNotVisible
import BotTouchingGoal
import BotChooseNBGItem
import BotChooseLTGItem
import BotGetSecondGoal
import BotGetTopGoal
import BotGoalName
import BotDumpGoalStack
import BotDumpAvoidGoals
import BotEmptyGoalStack
import BotPopGoal
import BotPushGoal
import BotRemoveFromAvoidGoals
import BotResetAvoidGoals
import BotResetGoalState
import GeneticParentsAndChildSelection
import BotSetChatName
import BotSetChatGender
import BotLoadChatFile
import BotReplaceSynonyms
import UnifyWhiteSpaces
import BotMatchVariable
import BotFindMatch
import StringContains
import BotGetChatMessage
import BotEnterChat
import BotChatLength
import BotReplyChat
import BotNumInitialChats
import BotInitialChat
import BotNumConsoleMessages
import BotNextConsoleMessage
import BotRemoveConsoleMessage
import BotQueueConsoleMessage
import BotFreeChatState
import BotAllocChatState
import BotShutdownChatAI
import BotSetupChatAI
import BotShutdownCharacters
import Characteristic_String
import Characteristic_BInteger
import Characteristic_Integer
import Characteristic_BFloat
import Characteristic_Float
import BotFreeCharacter
import BotLoadCharacter
import EA_Shutdown
import EA_Setup
import EA_ResetInput
import EA_GetInput
import EA_EndRegular
import EA_View
import EA_Move
import EA_DelayedJump
import EA_Jump
import EA_SelectWeapon
import EA_Use
import EA_Gesture
import EA_Talk
import EA_Respawn
import EA_Attack
import EA_MoveRight
import EA_MoveLeft
import EA_MoveBack
import EA_MoveForward
import EA_MoveDown
import EA_MoveUp
import EA_Walk
import EA_Crouch
import EA_Action
import EA_Command
import EA_SayTeam
import EA_Say
import GetBotLibAPI
import svf_self_portal2
import trap_SnapVector
import trap_GeneticParentsAndChildSelection
import trap_BotResetWeaponState
import trap_BotFreeWeaponState
import trap_BotAllocWeaponState
import trap_BotLoadWeaponWeights
import trap_BotGetWeaponInfo
import trap_BotChooseBestFightWeapon
import trap_BotAddAvoidSpot
import trap_BotInitMoveState
import trap_BotFreeMoveState
import trap_BotAllocMoveState
import trap_BotPredictVisiblePosition
import trap_BotMovementViewTarget
import trap_BotReachabilityArea
import trap_BotResetLastAvoidReach
import trap_BotResetAvoidReach
import trap_BotMoveInDirection
import trap_BotMoveToGoal
import trap_BotResetMoveState
import trap_BotFreeGoalState
import trap_BotAllocGoalState
import trap_BotMutateGoalFuzzyLogic
import trap_BotSaveGoalFuzzyLogic
import trap_BotInterbreedGoalFuzzyLogic
import trap_BotFreeItemWeights
import trap_BotLoadItemWeights
import trap_BotUpdateEntityItems
import trap_BotInitLevelItems
import trap_BotSetAvoidGoalTime
import trap_BotAvoidGoalTime
import trap_BotGetLevelItemGoal
import trap_BotGetMapLocationGoal
import trap_BotGetNextCampSpotGoal
import trap_BotItemGoalInVisButNotVisible
import trap_BotTouchingGoal
import trap_BotChooseNBGItem
import trap_BotChooseLTGItem
import trap_BotGetSecondGoal
import trap_BotGetTopGoal
import trap_BotGoalName
import trap_BotDumpGoalStack
import trap_BotDumpAvoidGoals
import trap_BotEmptyGoalStack
import trap_BotPopGoal
import trap_BotPushGoal
import trap_BotResetAvoidGoals
import trap_BotRemoveFromAvoidGoals
import trap_BotResetGoalState
import trap_BotSetChatName
import trap_BotSetChatGender
import trap_BotLoadChatFile
import trap_BotReplaceSynonyms
import trap_UnifyWhiteSpaces
import trap_BotMatchVariable
import trap_BotFindMatch
import trap_StringContains
import trap_BotGetChatMessage
import trap_BotEnterChat
import trap_BotChatLength
import trap_BotReplyChat
import trap_BotNumInitialChats
import trap_BotInitialChat
import trap_BotNumConsoleMessages
import trap_BotNextConsoleMessage
import trap_BotRemoveConsoleMessage
import trap_BotQueueConsoleMessage
import trap_BotFreeChatState
import trap_BotAllocChatState
import trap_Characteristic_String
import trap_Characteristic_BInteger
import trap_Characteristic_Integer
import trap_Characteristic_BFloat
import trap_Characteristic_Float
import trap_BotFreeCharacter
import trap_BotLoadCharacter
import trap_EA_ResetInput
import trap_EA_GetInput
import trap_EA_EndRegular
import trap_EA_View
import trap_EA_Move
import trap_EA_DelayedJump
import trap_EA_Jump
import trap_EA_SelectWeapon
import trap_EA_MoveRight
import trap_EA_MoveLeft
import trap_EA_MoveBack
import trap_EA_MoveForward
import trap_EA_MoveDown
import trap_EA_MoveUp
import trap_EA_Crouch
import trap_EA_Respawn
import trap_EA_Use
import trap_EA_Attack
import trap_EA_Talk
import trap_EA_Gesture
import trap_EA_Action
import trap_EA_Command
import trap_EA_SayTeam
import trap_EA_Say
import trap_AAS_PredictClientMovement
import trap_AAS_Swimming
import trap_AAS_AlternativeRouteGoals
import trap_AAS_PredictRoute
import trap_AAS_EnableRoutingArea
import trap_AAS_AreaTravelTimeToGoalArea
import trap_AAS_AreaReachability
import trap_AAS_IntForBSPEpairKey
import trap_AAS_FloatForBSPEpairKey
import trap_AAS_VectorForBSPEpairKey
import trap_AAS_ValueForBSPEpairKey
import trap_AAS_NextBSPEntity
import trap_AAS_PointContents
import trap_AAS_TraceAreas
import trap_AAS_PointReachabilityAreaIndex
import trap_AAS_PointAreaNum
import trap_AAS_Time
import trap_AAS_PresenceTypeBoundingBox
import trap_AAS_Initialized
import trap_AAS_EntityInfo
import trap_AAS_AreaInfo
import trap_AAS_BBoxAreas
import trap_BotUserCommand
import trap_BotGetServerCommand
import trap_BotGetSnapshotEntity
import trap_BotLibTest
import trap_BotLibUpdateEntity
import trap_BotLibLoadMap
import trap_BotLibStartFrame
import trap_BotLibDefine
import trap_BotLibVarGet
import trap_BotLibVarSet
import trap_BotLibShutdown
import trap_BotLibSetup
import trap_DebugPolygonDelete
import trap_DebugPolygonCreate
import trap_GetEntityToken
import trap_GetUsercmd
import trap_BotFreeClient
import trap_BotAllocateClient
import trap_EntityContact
import trap_EntitiesInBox
import trap_UnlinkEntity
import trap_LinkEntity
import trap_AreasConnected
import trap_AdjustAreaPortalState
import trap_InPVSIgnorePortals
import trap_InPVS
import trap_PointContents
import trap_TraceCapsule
import trap_Trace
import trap_SetBrushModel
import trap_GetServerinfo
import trap_SetUserinfo
import trap_GetUserinfo
import trap_GetConfigstring
import trap_SetConfigstring
import trap_SendServerCommand
import trap_DropClient
import trap_LocateGameData
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_VariableIntegerValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_RealTime
import trap_Milliseconds
import trap_Error
import trap_Print
import g_training
import g_knockback_z_self
import g_knockback_z
import g_knockback_hmg
import g_knockback_cg
import g_knockback_pl
import g_knockback_ng
import g_knockback_gh
import g_knockback_bfg
import g_knockback_pg_self
import g_knockback_pg
import g_knockback_rg
import g_knockback_lg
import g_knockback_rl_self
import g_knockback_rl
import g_knockback_gl
import g_knockback_sg
import g_knockback_mg
import g_knockback_g
import g_velocity_rl
import g_velocity_pl
import g_velocity_pg
import g_velocity_gh
import g_velocity_gl
import g_velocity_bfg
import g_splashdamage_rl
import g_splashdamage_pl
import g_splashdamage_pg
import g_splashdamage_gl
import g_splashdamage_bfg
import g_splashradius_rl
import g_splashradius_pl
import g_splashradius_pg
import g_splashradius_gl
import g_splashradius_bfg
import g_damage_hmg
import g_damage_cg
import g_damage_pl
import g_damage_ng
import g_damage_gh
import g_damage_bfg
import g_damage_pg
import g_damage_rg
import g_damage_lg
import g_damage_rl
import g_damage_gl
import g_damage_sg
import g_damage_mg
import g_damage_g
import g_ammoPack
import g_ammoRespawn
import g_startingAmmo_hmg
import g_startingAmmo_cg
import g_startingAmmo_pl
import g_startingAmmo_ng
import g_startingAmmo_gh
import g_startingAmmo_bfg
import g_startingAmmo_pg
import g_startingAmmo_rg
import g_startingAmmo_lg
import g_startingAmmo_rl
import g_startingAmmo_gl
import g_startingAmmo_sg
import g_startingAmmo_mg
import g_startingAmmo_g
import g_startingWeapons
import armor_tiered
import g_rotation
import pmove_msec
import pmove_fixed
import g_smoothClients
import g_proxMineTimeout
import g_enableBreath
import g_enableDust
import g_blueteam
import g_redteam
import g_cubeTimeout
import g_obeliskRespawnDelay
import g_obeliskRegenAmount
import g_obeliskRegenPeriod
import g_obeliskHealth
import g_predictPVS
import g_unlagged
import g_listEntity
import g_voteDelay
import g_voteLimit
import g_allowVoteMidGame
import g_allowSpecVote
import g_allowVote
import g_allowKill
import g_blood
import g_motd
import g_debugAlloc
import g_debugDamage
import g_debugMove
import g_inactivity
import g_respawn_delay_max
import g_respawn_delay_min
import g_weaponTeamRespawn
import g_weaponRespawn
import g_quadDamageFactor
import g_knockback
import g_gravity
import g_speed
import g_dedicated
import g_needpass
import g_filterBan
import g_banIPs
import g_password
import g_logSync
import g_log
import g_warmup
import g_teamForceBalance
import g_autoJoin
import g_friendlyFire
import g_synchronousClients
import g_capturelimit
import g_timelimit
import g_fraglimit
import g_dmflags
import g_maxGameClients
import g_maxclients
import g_gametype
import sv_fps
import g_mapname
import g_cheats
import g_entities
import level
import AddTeamScore
import Pickup_Team
import CheckTeamStatus
import TeamplayInfoMessage
import Team_GetLocationMsg
import Team_GetLocation
import SelectCTFSpawnPoint
import Team_FreeEntity
import Team_ReturnFlag
import Team_InitGame
import Team_CheckHurtCarrier
import Team_FragBonuses
import Team_DroppedFlagThink
import TeamColorString
import OtherTeamName
import TeamName
import OtherTeam
import G_MapExist
import G_LoadMap
import ParseMapRotation
import Svcmd_BotList_f
import Svcmd_AddBot_f
import G_BotConnect
import G_RemoveQueuedBotBegin
import G_CheckBotSpawn
import G_GetBotInfoByName
import G_GetBotInfoByNumber
import G_InitBots
import G_PredictPlayerMove
import G_UnTimeShiftClient
import G_UndoTimeShiftFor
import G_DoTimeShiftFor
import G_UnTimeShiftAllClients
import G_TimeShiftAllClients
import G_StoreHistory
import G_ResetHistory
import UpdateTournamentInfo
import G_ClearClientSessionData
import G_WriteClientSessionData
import G_ReadClientSessionData
import G_InitSessionData
import G_WriteSessionData
import G_InitWorldSession
import Svcmd_GameMem_f
import G_InitMemory
import G_Alloc
import Team_ResetFlags
import CheckObeliskAttack
import Team_CheckDroppedItem
import OnSameTeam
import G_RunClient
import ClientEndFrame
import ClientThink
import ClientCommand
import ClientBegin
import ClientDisconnect
import ClientUserinfoChanged
import ClientConnect
import G_BroadcastServerCommand
import G_Error
import G_Printf
import G_LogPrintf
import G_RunThink
import CheckTeamLeader
import SetLeader
import FindIntermissionPoint
import MoveClientToIntermission
import DeathmatchScoreboardMessage
import G_StartKamikaze
import FireWeapon
import G_FilterPacket
import G_ProcessIPBans
import ConsoleCommand
import SpotWouldTelefrag
import CalculateRanks
import AddScore
import player_die
import ClientSpawn
import InitBodyQue
import BeginIntermission
import respawn
import CopyToBodyQue
import SelectSpawnPoint
import SetClientViewAngle
import PickTeam
import TeamLeader
import TeamConnectedCount
import TeamCount
import Weapon_HookThink
import Weapon_HookFree
import CheckGauntletAttack
import SnapVectorTowards
import CalcMuzzlePoint
import LogAccuracyHit
import DropPortalDestination
import DropPortalSource
import TeleportPlayer
import trigger_teleporter_touch
import Touch_DoorTrigger
import G_RunMover
import fire_prox
import fire_nail
import fire_grapple
import fire_bfg
import fire_rocket
import fire_grenade
import fire_plasma
import fire_blaster
import G_RunMissile
import TossClientSkulls
import TossClientPersistantPowerups
import TossClientItems
import body_die
import G_InvulnerabilityEffect
import G_RadiusDamage
import G_Damage
import CanDamage
import BuildShaderStateConfig
import AddRemap
import G_SetOrigin
import G_AddEvent
import G_AddPredictableEvent
import vectoyaw
import vtos
import tv
import G_TouchSolids
import G_TouchTriggers
import G_EntitiesFree
import G_FreeEntity
import G_Sound
import G_TempEntity
import G_Spawn
import G_InitGentity
import G_SetMovedir
import G_UseTargets
import G_PickTarget
import G_Find
import G_KillBox
import G_TeamCommand
import G_SoundIndex
import G_ModelIndex
import SaveRegisteredItems
import RegisterItem
import ClearRegisteredItems
import Add_Ammo
import Touch_Item
import FinishSpawningItem
import G_SpawnItem
import LaunchItem
import Drop_Item
import SpawnTime
import RespawnItem
import G_RunItem
import G_CheckTeamItems
import G_RevertVote
import Cmd_FollowCycle_f
import SetTeam
import BroadcastTeamChange
import StopFollowing
import Cmd_Score_f
import G_NewString
import G_SpawnEntitiesFromString
import G_SpawnVector
import G_SpawnInt
import G_SpawnFloat
import G_SpawnString
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
LABELV $801
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $800
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 98
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 99
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $799
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $798
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 98
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $797
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 99
byte 1 108
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $796
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 115
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 0
align 1
LABELV $795
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $794
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 112
byte 1 97
byte 1 117
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $793
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $791
byte 1 77
byte 1 73
byte 1 83
byte 1 83
byte 1 73
byte 1 79
byte 1 78
byte 1 80
byte 1 65
byte 1 67
byte 1 75
byte 1 0
align 1
LABELV $790
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $787
byte 1 102
byte 1 115
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $786
byte 1 104
byte 1 111
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $783
byte 1 102
byte 1 115
byte 1 95
byte 1 104
byte 1 111
byte 1 109
byte 1 101
byte 1 112
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $782
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 100
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $779
byte 1 102
byte 1 115
byte 1 95
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 112
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $774
byte 1 97
byte 1 97
byte 1 115
byte 1 111
byte 1 112
byte 1 116
byte 1 105
byte 1 109
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $771
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 97
byte 1 97
byte 1 115
byte 1 111
byte 1 112
byte 1 116
byte 1 105
byte 1 109
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $770
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 119
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $767
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 119
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $766
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 101
byte 1 97
byte 1 99
byte 1 104
byte 1 97
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $763
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 101
byte 1 97
byte 1 99
byte 1 104
byte 1 97
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $762
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 99
byte 1 108
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $759
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 99
byte 1 108
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $756
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 118
byte 1 105
byte 1 115
byte 1 117
byte 1 97
byte 1 108
byte 1 105
byte 1 122
byte 1 101
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 112
byte 1 97
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $755
byte 1 110
byte 1 111
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $752
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 110
byte 1 111
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $751
byte 1 108
byte 1 111
byte 1 103
byte 1 0
align 1
LABELV $749
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 100
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 111
byte 1 112
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $744
byte 1 109
byte 1 97
byte 1 120
byte 1 95
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $741
byte 1 109
byte 1 97
byte 1 120
byte 1 95
byte 1 97
byte 1 97
byte 1 115
byte 1 108
byte 1 105
byte 1 110
byte 1 107
byte 1 115
byte 1 0
align 1
LABELV $738
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 112
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 115
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $737
byte 1 109
byte 1 97
byte 1 120
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 105
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $736
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
LABELV $735
byte 1 56
byte 1 0
align 1
LABELV $732
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
LABELV $646
byte 1 50
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $645
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 107
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $641
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 114
byte 1 111
byte 1 117
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 0
align 1
LABELV $640
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 114
byte 1 111
byte 1 117
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 0
align 1
LABELV $636
byte 1 48
byte 1 0
align 1
LABELV $635
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 100
byte 1 117
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $634
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 100
byte 1 117
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $598
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $573
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $558
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $555
byte 1 65
byte 1 65
byte 1 83
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
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
byte 1 10
byte 1 0
align 1
LABELV $552
byte 1 66
byte 1 111
byte 1 116
byte 1 65
byte 1 73
byte 1 83
byte 1 101
byte 1 116
byte 1 117
byte 1 112
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 117
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $543
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $542
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 0
align 1
LABELV $523
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 76
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $520
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $517
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $514
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $511
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $508
byte 1 99
byte 1 115
byte 1 0
align 1
LABELV $505
byte 1 99
byte 1 112
byte 1 32
byte 1 0
align 1
LABELV $497
byte 1 66
byte 1 111
byte 1 116
byte 1 65
byte 1 73
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 117
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $351
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 98
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $348
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
byte 1 52
byte 1 32
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $342
byte 1 49
byte 1 0
align 1
LABELV $341
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 108
byte 1 111
byte 1 97
byte 1 100
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
LABELV $333
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $332
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
LABELV $325
byte 1 0
align 1
LABELV $324
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 98
byte 1 114
byte 1 101
byte 1 101
byte 1 100
byte 1 119
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $275
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 99
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 97
byte 1 92
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $272
byte 1 114
byte 1 111
byte 1 97
byte 1 109
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $270
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $268
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $266
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $264
byte 1 114
byte 1 117
byte 1 115
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $262
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $260
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $258
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $256
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $254
byte 1 103
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $252
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $250
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $248
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $243
byte 1 37
byte 1 50
byte 1 100
byte 1 0
align 1
LABELV $232
byte 1 70
byte 1 32
byte 1 0
align 1
LABELV $211
byte 1 94
byte 1 52
byte 1 66
byte 1 76
byte 1 85
byte 1 69
byte 1 10
byte 1 0
align 1
LABELV $210
byte 1 116
byte 1 0
align 1
LABELV $206
byte 1 110
byte 1 0
align 1
LABELV $195
byte 1 94
byte 1 49
byte 1 82
byte 1 69
byte 1 68
byte 1 10
byte 1 0
align 1
LABELV $191
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 114
byte 1 111
byte 1 97
byte 1 109
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $190
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 104
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $188
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $186
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $184
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 114
byte 1 117
byte 1 115
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $182
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $180
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 112
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $178
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $176
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $174
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $172
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $170
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $168
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 104
byte 1 101
byte 1 108
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $163
byte 1 94
byte 1 52
byte 1 37
byte 1 50
byte 1 100
byte 1 0
align 1
LABELV $162
byte 1 94
byte 1 49
byte 1 37
byte 1 50
byte 1 100
byte 1 0
align 1
LABELV $149
byte 1 94
byte 1 52
byte 1 70
byte 1 32
byte 1 0
align 1
LABELV $148
byte 1 94
byte 1 49
byte 1 70
byte 1 32
byte 1 0
align 1
LABELV $141
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $140
byte 1 32
byte 1 0
align 1
LABELV $139
byte 1 76
byte 1 0
align 1
LABELV $134
byte 1 13
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 32
byte 1 37
byte 1 100
byte 1 44
byte 1 32
byte 1 99
byte 1 108
byte 1 117
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $133
byte 1 13
byte 1 94
byte 1 49
byte 1 83
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 33
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $125
byte 1 13
byte 1 94
byte 1 49
byte 1 83
byte 1 79
byte 1 76
byte 1 73
byte 1 68
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 0
align 1
LABELV $124
byte 1 13
byte 1 101
byte 1 109
byte 1 112
byte 1 116
byte 1 121
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 0
align 1
LABELV $70
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $69
byte 1 94
byte 1 49
byte 1 69
byte 1 120
byte 1 105
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $67
byte 1 94
byte 1 49
byte 1 70
byte 1 97
byte 1 116
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $65
byte 1 94
byte 1 49
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $63
byte 1 94
byte 1 51
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $61
byte 1 37
byte 1 115
byte 1 0

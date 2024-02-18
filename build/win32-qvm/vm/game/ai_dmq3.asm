code
proc BotSetUserInfo 1024 12
file "..\..\..\..\code\game\ai_dmq3.c"
line 91
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:/*****************************************************************************
;5: * name:		ai_dmq3.c
;6: *
;7: * desc:		Quake3 bot AI
;8: *
;9: * $Archive: /MissionPack/code/game/ai_dmq3.c $
;10: *
;11: *****************************************************************************/
;12:
;13:
;14:#include "g_local.h"
;15:#include "botlib.h"
;16:#include "be_aas.h"
;17:#include "be_ea.h"
;18:#include "be_ai_char.h"
;19:#include "be_ai_chat.h"
;20:#include "be_ai_gen.h"
;21:#include "be_ai_goal.h"
;22:#include "be_ai_move.h"
;23:#include "be_ai_weap.h"
;24://
;25:#include "ai_main.h"
;26:#include "ai_dmq3.h"
;27:#include "ai_chat.h"
;28:#include "ai_cmd.h"
;29:#include "ai_dmnet.h"
;30:#include "ai_team.h"
;31://
;32:#include "chars.h"				//characteristics
;33:#include "inv.h"				//indexes into the inventory
;34:#include "syn.h"				//synonyms
;35:#include "match.h"				//string matching types and vars
;36:
;37:// from aasfile.h
;38:#define AREACONTENTS_MOVER				1024
;39:#define AREACONTENTS_MODELNUMSHIFT		24
;40:#define AREACONTENTS_MAXMODELNUM		0xFF
;41:#define AREACONTENTS_MODELNUM			(AREACONTENTS_MAXMODELNUM << AREACONTENTS_MODELNUMSHIFT)
;42:
;43:#define IDEAL_ATTACKDIST			140
;44:
;45:#define MAX_WAYPOINTS		128
;46://
;47:bot_waypoint_t botai_waypoints[MAX_WAYPOINTS];
;48:bot_waypoint_t *botai_freewaypoints;
;49:
;50://NOTE: not using a cvars which can be updated because the game should be reloaded anyway
;51:int gametype;		//game type
;52://int maxclients;	//maximum number of clients
;53:
;54:vmCvar_t bot_grapple;
;55:vmCvar_t bot_rocketjump;
;56:vmCvar_t bot_fastchat;
;57:vmCvar_t bot_nochat;
;58:vmCvar_t bot_testrchat;
;59:vmCvar_t bot_challenge;
;60:vmCvar_t bot_predictobstacles;
;61:vmCvar_t g_spSkill;
;62:
;63:extern vmCvar_t bot_developer;
;64:
;65:vec3_t lastteleport_origin;		//last teleport event origin
;66:float lastteleport_time;		//last teleport event time
;67:int max_bspmodelindex;			//maximum BSP model index
;68:
;69://CTF flag goals
;70:bot_goal_t ctf_redflag;
;71:bot_goal_t ctf_blueflag;
;72:bot_goal_t ctf_neutralflag;
;73:bot_goal_t redobelisk;
;74:bot_goal_t blueobelisk;
;75:bot_goal_t neutralobelisk;
;76:
;77:#define MAX_ALTROUTEGOALS		32
;78:
;79:int altroutegoals_setup;
;80:aas_altroutegoal_t red_altroutegoals[MAX_ALTROUTEGOALS];
;81:int red_numaltroutegoals;
;82:aas_altroutegoal_t blue_altroutegoals[MAX_ALTROUTEGOALS];
;83:int blue_numaltroutegoals;
;84:
;85:
;86:/*
;87:==================
;88:BotSetUserInfo
;89:==================
;90:*/
;91:static void BotSetUserInfo( bot_state_t *bs, const char *key, const char *value ) {
line 94
;92:	char userinfo[MAX_INFO_STRING];
;93:
;94:	trap_GetUserinfo( bs->client, userinfo, sizeof( userinfo ) );
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 95
;95:	Info_SetValueForKey( userinfo, key, value );
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 96
;96:	trap_SetUserinfo( bs->client, userinfo );
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 97
;97:	ClientUserinfoChanged( bs->client );
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLI4
pop
line 98
;98:}
LABELV $56
endproc BotSetUserInfo 1024 12
export BotCTFCarryingFlag
proc BotCTFCarryingFlag 0 0
line 106
;99:
;100:
;101:/*
;102:==================
;103:BotCTFCarryingFlag
;104:==================
;105:*/
;106:int BotCTFCarryingFlag(bot_state_t *bs) {
line 107
;107:	if (gametype != GT_CTF) return CTF_FLAG_NONE;
ADDRGP4 gametype
INDIRI4
CNSTI4 5
EQI4 $58
CNSTI4 0
RETI4
ADDRGP4 $57
JUMPV
LABELV $58
line 109
;108:
;109:	if (bs->inventory[INVENTORY_REDFLAG] > 0) return CTF_FLAG_RED;
ADDRFP4 0
INDIRP4
CNSTI4 5156
ADDP4
INDIRI4
CNSTI4 0
LEI4 $60
CNSTI4 1
RETI4
ADDRGP4 $57
JUMPV
LABELV $60
line 110
;110:	else if (bs->inventory[INVENTORY_BLUEFLAG] > 0) return CTF_FLAG_BLUE;
ADDRFP4 0
INDIRP4
CNSTI4 5160
ADDP4
INDIRI4
CNSTI4 0
LEI4 $62
CNSTI4 2
RETI4
ADDRGP4 $57
JUMPV
LABELV $62
line 111
;111:	return CTF_FLAG_NONE;
CNSTI4 0
RETI4
LABELV $57
endproc BotCTFCarryingFlag 0 0
export BotTeam
proc BotTeam 1044 12
line 119
;112:}
;113:
;114:/*
;115:==================
;116:BotTeam
;117:==================
;118:*/
;119:int BotTeam(bot_state_t *bs) {
line 122
;120:	char info[1024];
;121:
;122:	if (bs->client < 0 || bs->client >= MAX_CLIENTS) {
ADDRLP4 1024
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1024
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
LTI4 $67
ADDRLP4 1024
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 64
LTI4 $65
LABELV $67
line 124
;123:		//BotAI_Print(PRT_ERROR, "BotCTFTeam: client out of range\n");
;124:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $64
JUMPV
LABELV $65
line 126
;125:	}
;126:	trap_GetConfigstring(CS_PLAYERS+bs->client, info, sizeof(info));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 529
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 128
;127:	//
;128:	if (atoi(Info_ValueForKey(info, "t")) == TEAM_RED) return TEAM_RED;
ADDRLP4 0
ARGP4
ADDRGP4 $70
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 1
NEI4 $68
CNSTI4 1
RETI4
ADDRGP4 $64
JUMPV
LABELV $68
line 129
;129:	else if (atoi(Info_ValueForKey(info, "t")) == TEAM_BLUE) return TEAM_BLUE;
ADDRLP4 0
ARGP4
ADDRGP4 $70
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 2
NEI4 $71
CNSTI4 2
RETI4
ADDRGP4 $64
JUMPV
LABELV $71
line 130
;130:	return TEAM_FREE;
CNSTI4 0
RETI4
LABELV $64
endproc BotTeam 1044 12
export BotOppositeTeam
proc BotOppositeTeam 12 4
line 138
;131:}
;132:
;133:/*
;134:==================
;135:BotOppositeTeam
;136:==================
;137:*/
;138:int BotOppositeTeam(bot_state_t *bs) {
line 139
;139:	switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $77
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $78
ADDRGP4 $74
JUMPV
LABELV $77
line 140
;140:		case TEAM_RED: return TEAM_BLUE;
CNSTI4 2
RETI4
ADDRGP4 $73
JUMPV
LABELV $78
line 141
;141:		case TEAM_BLUE: return TEAM_RED;
CNSTI4 1
RETI4
ADDRGP4 $73
JUMPV
LABELV $74
line 142
;142:		default: return TEAM_FREE;
CNSTI4 0
RETI4
LABELV $73
endproc BotOppositeTeam 12 4
export BotEnemyFlag
proc BotEnemyFlag 4 4
line 151
;143:	}
;144:}
;145:
;146:/*
;147:==================
;148:BotEnemyFlag
;149:==================
;150:*/
;151:bot_goal_t *BotEnemyFlag(bot_state_t *bs) {
line 152
;152:	if (BotTeam(bs) == TEAM_RED) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $80
line 153
;153:		return &ctf_blueflag;
ADDRGP4 ctf_blueflag
RETP4
ADDRGP4 $79
JUMPV
LABELV $80
line 155
;154:	}
;155:	else {
line 156
;156:		return &ctf_redflag;
ADDRGP4 ctf_redflag
RETP4
LABELV $79
endproc BotEnemyFlag 4 4
export BotTeamFlag
proc BotTeamFlag 4 4
line 165
;157:	}
;158:}
;159:
;160:/*
;161:==================
;162:BotTeamFlag
;163:==================
;164:*/
;165:bot_goal_t *BotTeamFlag(bot_state_t *bs) {
line 166
;166:	if (BotTeam(bs) == TEAM_RED) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $83
line 167
;167:		return &ctf_redflag;
ADDRGP4 ctf_redflag
RETP4
ADDRGP4 $82
JUMPV
LABELV $83
line 169
;168:	}
;169:	else {
line 170
;170:		return &ctf_blueflag;
ADDRGP4 ctf_blueflag
RETP4
LABELV $82
endproc BotTeamFlag 4 4
export EntityIsDead
proc EntityIsDead 472 8
line 180
;171:	}
;172:}
;173:
;174:
;175:/*
;176:==================
;177:EntityIsDead
;178:==================
;179:*/
;180:qboolean EntityIsDead(aas_entityinfo_t *entinfo) {
line 183
;181:	playerState_t ps;
;182:
;183:	if (entinfo->number >= 0 && entinfo->number < MAX_CLIENTS) {
ADDRLP4 468
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 468
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
LTI4 $86
ADDRLP4 468
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 64
GEI4 $86
line 185
;184:		//retrieve the current client state
;185:		BotAI_GetClientState( entinfo->number, &ps );
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
line 186
;186:		if (ps.pm_type != PM_NORMAL) return qtrue;
ADDRLP4 0+4
INDIRI4
CNSTI4 0
EQI4 $88
CNSTI4 1
RETI4
ADDRGP4 $85
JUMPV
LABELV $88
line 187
;187:	}
LABELV $86
line 188
;188:	return qfalse;
CNSTI4 0
RETI4
LABELV $85
endproc EntityIsDead 472 8
export EntityCarriesFlag
proc EntityCarriesFlag 0 0
line 196
;189:}
;190:
;191:/*
;192:==================
;193:EntityCarriesFlag
;194:==================
;195:*/
;196:qboolean EntityCarriesFlag(aas_entityinfo_t *entinfo) {
line 197
;197:	if ( entinfo->powerups & ( 1 << PW_REDFLAG ) )
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $92
line 198
;198:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $91
JUMPV
LABELV $92
line 199
;199:	if ( entinfo->powerups & ( 1 << PW_BLUEFLAG ) )
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $94
line 200
;200:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $91
JUMPV
LABELV $94
line 201
;201:	if ( entinfo->powerups & ( 1 << PW_NEUTRALFLAG ) )
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $96
line 202
;202:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $91
JUMPV
LABELV $96
line 203
;203:	return qfalse;
CNSTI4 0
RETI4
LABELV $91
endproc EntityCarriesFlag 0 0
export EntityIsInvisible
proc EntityIsInvisible 4 4
line 211
;204:}
;205:
;206:/*
;207:==================
;208:EntityIsInvisible
;209:==================
;210:*/
;211:qboolean EntityIsInvisible(aas_entityinfo_t *entinfo) {
line 213
;212:	// the flag is always visible
;213:	if (EntityCarriesFlag(entinfo)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $99
line 214
;214:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $98
JUMPV
LABELV $99
line 216
;215:	}
;216:	if (entinfo->powerups & (1 << PW_INVIS)) {
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $101
line 217
;217:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $98
JUMPV
LABELV $101
line 219
;218:	}
;219:	return qfalse;
CNSTI4 0
RETI4
LABELV $98
endproc EntityIsInvisible 4 4
export EntityIsShooting
proc EntityIsShooting 0 0
line 227
;220:}
;221:
;222:/*
;223:==================
;224:EntityIsShooting
;225:==================
;226:*/
;227:qboolean EntityIsShooting(aas_entityinfo_t *entinfo) {
line 228
;228:	if (entinfo->flags & EF_FIRING) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $104
line 229
;229:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $103
JUMPV
LABELV $104
line 231
;230:	}
;231:	return qfalse;
CNSTI4 0
RETI4
LABELV $103
endproc EntityIsShooting 0 0
export EntityIsChatting
proc EntityIsChatting 0 0
line 239
;232:}
;233:
;234:/*
;235:==================
;236:EntityIsChatting
;237:==================
;238:*/
;239:qboolean EntityIsChatting(aas_entityinfo_t *entinfo) {
line 240
;240:	if (entinfo->flags & EF_TALK) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $107
line 241
;241:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $106
JUMPV
LABELV $107
line 243
;242:	}
;243:	return qfalse;
CNSTI4 0
RETI4
LABELV $106
endproc EntityIsChatting 0 0
export EntityHasQuad
proc EntityHasQuad 0 0
line 251
;244:}
;245:
;246:/*
;247:==================
;248:EntityHasQuad
;249:==================
;250:*/
;251:qboolean EntityHasQuad(aas_entityinfo_t *entinfo) {
line 252
;252:	if (entinfo->powerups & (1 << PW_QUAD)) {
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $110
line 253
;253:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $109
JUMPV
LABELV $110
line 255
;254:	}
;255:	return qfalse;
CNSTI4 0
RETI4
LABELV $109
endproc EntityHasQuad 0 0
export EntityHasKamikaze
proc EntityHasKamikaze 0 0
line 263
;256:}
;257:
;258:/*
;259:==================
;260:EntityHasKamikze
;261:==================
;262:*/
;263:qboolean EntityHasKamikaze(aas_entityinfo_t *entinfo) {
line 264
;264:	if (entinfo->flags & EF_KAMIKAZE) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $113
line 265
;265:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $112
JUMPV
LABELV $113
line 267
;266:	}
;267:	return qfalse;
CNSTI4 0
RETI4
LABELV $112
endproc EntityHasKamikaze 0 0
export EntityCarriesSkulls
proc EntityCarriesSkulls 208 8
line 275
;268:}
;269:
;270:/*
;271:==================
;272:EntityCarriesSkulls
;273:==================
;274:*/
;275:qboolean EntityCarriesSkulls(aas_entityinfo_t *entinfo) {
line 278
;276:	entityState_t state;
;277:
;278:	if (gametype != GT_HARVESTER)
ADDRGP4 gametype
INDIRI4
CNSTI4 8
EQI4 $116
line 279
;279:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $115
JUMPV
LABELV $116
line 281
;280:	//FIXME: get this info from the aas_entityinfo_t ?
;281:	BotAI_GetEntityState(entinfo->number, &state);
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotAI_GetEntityState
CALLI4
pop
line 282
;282:	if (state.generic1 > 0)
ADDRLP4 0+204
INDIRI4
CNSTI4 0
LEI4 $118
line 283
;283:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $115
JUMPV
LABELV $118
line 284
;284:	return qfalse;
CNSTI4 0
RETI4
LABELV $115
endproc EntityCarriesSkulls 208 8
export Bot1FCTFCarryingFlag
proc Bot1FCTFCarryingFlag 0 0
line 292
;285:}
;286:
;287:/*
;288:==================
;289:Bot1FCTFCarryingFlag
;290:==================
;291:*/
;292:int Bot1FCTFCarryingFlag(bot_state_t *bs) {
line 293
;293:	if (gametype != GT_1FCTF) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 6
EQI4 $122
CNSTI4 0
RETI4
ADDRGP4 $121
JUMPV
LABELV $122
line 295
;294:
;295:	if (bs->inventory[INVENTORY_NEUTRALFLAG] > 0) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 5164
ADDP4
INDIRI4
CNSTI4 0
LEI4 $124
CNSTI4 1
RETI4
ADDRGP4 $121
JUMPV
LABELV $124
line 296
;296:	return qfalse;
CNSTI4 0
RETI4
LABELV $121
endproc Bot1FCTFCarryingFlag 0 0
export BotHarvesterCarryingSkulls
proc BotHarvesterCarryingSkulls 0 0
line 304
;297:}
;298:
;299:/*
;300:==================
;301:BotHarvesterCarryingSkulls
;302:==================
;303:*/
;304:int BotHarvesterCarryingSkulls(bot_state_t *bs) {
line 305
;305:	if (gametype != GT_HARVESTER) return qfalse;
ADDRGP4 gametype
INDIRI4
CNSTI4 8
EQI4 $127
CNSTI4 0
RETI4
ADDRGP4 $126
JUMPV
LABELV $127
line 307
;306:
;307:	if (bs->inventory[INVENTORY_RED_SKULL] > 0) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 5168
ADDP4
INDIRI4
CNSTI4 0
LEI4 $129
CNSTI4 1
RETI4
ADDRGP4 $126
JUMPV
LABELV $129
line 308
;308:	if (bs->inventory[INVENTORY_BLUE_SKULL] > 0) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 5172
ADDP4
INDIRI4
CNSTI4 0
LEI4 $131
CNSTI4 1
RETI4
ADDRGP4 $126
JUMPV
LABELV $131
line 309
;309:	return qfalse;
CNSTI4 0
RETI4
LABELV $126
endproc BotHarvesterCarryingSkulls 0 0
export BotRememberLastOrderedTask
proc BotRememberLastOrderedTask 16 12
line 317
;310:}
;311:
;312:/*
;313:==================
;314:BotRememberLastOrderedTask
;315:==================
;316:*/
;317:void BotRememberLastOrderedTask(bot_state_t *bs) {
line 318
;318:	if (!bs->ordered) {
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $134
line 319
;319:		return;
ADDRGP4 $133
JUMPV
LABELV $134
line 321
;320:	}
;321:	bs->lastgoal_decisionmaker = bs->decisionmaker;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 6756
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 6608
ADDP4
INDIRI4
ASGNI4
line 322
;322:	bs->lastgoal_ltgtype = bs->ltgtype;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6760
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
line 323
;323:	memcpy(&bs->lastgoal_teamgoal, &bs->teamgoal, sizeof(bot_goal_t));
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6768
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 324
;324:	bs->lastgoal_teammate = bs->teammate;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 6764
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ASGNI4
line 325
;325:}
LABELV $133
endproc BotRememberLastOrderedTask 16 12
export BotSetTeamStatus
proc BotSetTeamStatus 164 12
line 332
;326:
;327:/*
;328:==================
;329:BotSetTeamStatus
;330:==================
;331:*/
;332:void BotSetTeamStatus(bot_state_t *bs) {
line 336
;333:	int teamtask;
;334:	aas_entityinfo_t entinfo;
;335:
;336:	teamtask = TEAMTASK_PATROL;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 338
;337:
;338:	switch(bs->ltgtype) {
ADDRLP4 144
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 1
LTI4 $137
ADDRLP4 144
INDIRI4
CNSTI4 13
GTI4 $137
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $157-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $157
address $138
address $141
address $147
address $148
address $149
address $150
address $151
address $151
address $152
address $153
address $154
address $155
address $156
code
line 340
;339:		case LTG_TEAMHELP:
;340:			break;
LABELV $141
line 342
;341:		case LTG_TEAMACCOMPANY:
;342:			BotEntityInfo(bs->teammate, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 343
;343:			if ( ( (gametype == GT_CTF || gametype == GT_1FCTF) && EntityCarriesFlag(&entinfo))
ADDRLP4 152
ADDRGP4 gametype
INDIRI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 5
EQI4 $146
ADDRLP4 152
INDIRI4
CNSTI4 6
NEI4 $145
LABELV $146
ADDRLP4 4
ARGP4
ADDRLP4 156
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
NEI4 $144
LABELV $145
ADDRGP4 gametype
INDIRI4
CNSTI4 8
NEI4 $142
ADDRLP4 4
ARGP4
ADDRLP4 160
ADDRGP4 EntityCarriesSkulls
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
EQI4 $142
LABELV $144
line 344
;344:				|| ( gametype == GT_HARVESTER && EntityCarriesSkulls(&entinfo)) ) {
line 345
;345:				teamtask = TEAMTASK_ESCORT;
ADDRLP4 0
CNSTI4 6
ASGNI4
line 346
;346:			}
ADDRGP4 $138
JUMPV
LABELV $142
line 347
;347:			else {
line 348
;348:				teamtask = TEAMTASK_FOLLOW;
ADDRLP4 0
CNSTI4 4
ASGNI4
line 349
;349:			}
line 350
;350:			break;
ADDRGP4 $138
JUMPV
LABELV $147
line 352
;351:		case LTG_DEFENDKEYAREA:
;352:			teamtask = TEAMTASK_DEFENSE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 353
;353:			break;
ADDRGP4 $138
JUMPV
LABELV $148
line 355
;354:		case LTG_GETFLAG:
;355:			teamtask = TEAMTASK_OFFENSE;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 356
;356:			break;
ADDRGP4 $138
JUMPV
LABELV $149
line 358
;357:		case LTG_RUSHBASE:
;358:			teamtask = TEAMTASK_DEFENSE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 359
;359:			break;
ADDRGP4 $138
JUMPV
LABELV $150
line 361
;360:		case LTG_RETURNFLAG:
;361:			teamtask = TEAMTASK_RETRIEVE;
ADDRLP4 0
CNSTI4 5
ASGNI4
line 362
;362:			break;
ADDRGP4 $138
JUMPV
LABELV $151
line 365
;363:		case LTG_CAMP:
;364:		case LTG_CAMPORDER:
;365:			teamtask = TEAMTASK_CAMP;
ADDRLP4 0
CNSTI4 7
ASGNI4
line 366
;366:			break;
ADDRGP4 $138
JUMPV
LABELV $152
line 368
;367:		case LTG_PATROL:
;368:			teamtask = TEAMTASK_PATROL;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 369
;369:			break;
ADDRGP4 $138
JUMPV
LABELV $153
line 371
;370:		case LTG_GETITEM:
;371:			teamtask = TEAMTASK_PATROL;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 372
;372:			break;
ADDRGP4 $138
JUMPV
LABELV $154
line 374
;373:		case LTG_KILL:
;374:			teamtask = TEAMTASK_PATROL;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 375
;375:			break;
ADDRGP4 $138
JUMPV
LABELV $155
line 377
;376:		case LTG_HARVEST:
;377:			teamtask = TEAMTASK_OFFENSE;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 378
;378:			break;
ADDRGP4 $138
JUMPV
LABELV $156
line 380
;379:		case LTG_ATTACKENEMYBASE:
;380:			teamtask = TEAMTASK_OFFENSE;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 381
;381:			break;
ADDRGP4 $138
JUMPV
LABELV $137
line 383
;382:		default:
;383:			teamtask = TEAMTASK_PATROL;
ADDRLP4 0
CNSTI4 3
ASGNI4
line 384
;384:			break;
LABELV $138
line 386
;385:	}
;386:	BotSetUserInfo(bs, "teamtask", va("%d", teamtask));
ADDRGP4 $160
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $159
ARGP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRGP4 BotSetUserInfo
CALLV
pop
line 387
;387:}
LABELV $136
endproc BotSetTeamStatus 164 12
export BotSetLastOrderedTask
proc BotSetLastOrderedTask 60 16
line 394
;388:
;389:/*
;390:==================
;391:BotSetLastOrderedTask
;392:==================
;393:*/
;394:int BotSetLastOrderedTask(bot_state_t *bs) {
line 396
;395:
;396:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $162
line 398
;397:		// don't go back to returning the flag if it's at the base
;398:		if ( bs->lastgoal_ltgtype == LTG_RETURNFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 6
NEI4 $164
line 399
;399:			if ( BotTeam(bs) == TEAM_RED ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $166
line 400
;400:				if ( bs->redflagstatus == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
CNSTI4 0
NEI4 $167
line 401
;401:					bs->lastgoal_ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
CNSTI4 0
ASGNI4
line 402
;402:				}
line 403
;403:			}
ADDRGP4 $167
JUMPV
LABELV $166
line 404
;404:			else {
line 405
;405:				if ( bs->blueflagstatus == 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 6960
ADDP4
INDIRI4
CNSTI4 0
NEI4 $170
line 406
;406:					bs->lastgoal_ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
CNSTI4 0
ASGNI4
line 407
;407:				}
LABELV $170
line 408
;408:			}
LABELV $167
line 409
;409:		}
LABELV $164
line 410
;410:	}
LABELV $162
line 412
;411:
;412:	if ( bs->lastgoal_ltgtype ) {
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $172
line 413
;413:		bs->decisionmaker = bs->lastgoal_decisionmaker;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 6756
ADDP4
INDIRI4
ASGNI4
line 414
;414:		bs->ordered = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 1
ASGNI4
line 415
;415:		bs->ltgtype = bs->lastgoal_ltgtype;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6600
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
ASGNI4
line 416
;416:		memcpy(&bs->teamgoal, &bs->lastgoal_teamgoal, sizeof(bot_goal_t));
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 6768
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 417
;417:		bs->teammate = bs->lastgoal_teammate;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 6604
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 6764
ADDP4
INDIRI4
ASGNI4
line 418
;418:		bs->teamgoal_time = FloatTime() + 300;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1133903872
ADDF4
ASGNF4
line 419
;419:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 421
;420:		//
;421:		if ( gametype == GT_CTF ) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $174
line 422
;422:			if ( bs->ltgtype == LTG_GETFLAG ) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
NEI4 $176
line 426
;423:				bot_goal_t *tb, *eb;
;424:				int tt, et;
;425:
;426:				tb = BotTeamFlag(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 BotTeamFlag
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 32
INDIRP4
ASGNP4
line 427
;427:				eb = BotEnemyFlag(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 BotEnemyFlag
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 36
INDIRP4
ASGNP4
line 428
;428:				tt = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, tb->areanum, TFL_DEFAULT);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 44
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 44
INDIRI4
ASGNI4
line 429
;429:				et = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, eb->areanum, TFL_DEFAULT);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 52
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 52
INDIRI4
ASGNI4
line 431
;430:				// if the travel time towards the enemy base is larger than towards our base
;431:				if (et > tt) {
ADDRLP4 28
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $178
line 433
;432:					//get an alternative route goal towards the enemy base
;433:					BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 434
;434:				}
LABELV $178
line 435
;435:			}
LABELV $176
line 436
;436:		}
LABELV $174
line 437
;437:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $161
JUMPV
LABELV $172
line 439
;438:	}
;439:	return qfalse;
CNSTI4 0
RETI4
LABELV $161
endproc BotSetLastOrderedTask 60 16
export BotRefuseOrder
proc BotRefuseOrder 4 8
line 447
;440:}
;441:
;442:/*
;443:==================
;444:BotRefuseOrder
;445:==================
;446:*/
;447:void BotRefuseOrder(bot_state_t *bs) {
line 448
;448:	if (!bs->ordered)
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $181
line 449
;449:		return;
ADDRGP4 $180
JUMPV
LABELV $181
line 451
;450:	// if the bot was ordered to do something
;451:	if ( bs->order_time && bs->order_time > FloatTime() - 10 ) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 6616
ADDP4
INDIRF4
CNSTF4 0
EQF4 $183
ADDRLP4 0
INDIRP4
CNSTI4 6616
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
SUBF4
LEF4 $183
line 452
;452:		trap_EA_Action(bs->client, ACTION_NEGATIVE);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 2097152
ARGI4
ADDRGP4 trap_EA_Action
CALLV
pop
line 453
;453:		bs->order_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
CNSTF4 0
ASGNF4
line 454
;454:	}
LABELV $183
line 455
;455:}
LABELV $180
endproc BotRefuseOrder 4 8
export BotCTFSeekGoals
proc BotCTFSeekGoals 228 12
line 462
;456:
;457:/*
;458:==================
;459:BotCTFSeekGoals
;460:==================
;461:*/
;462:void BotCTFSeekGoals(bot_state_t *bs) {
line 469
;463:	float rnd, l1, l2;
;464:	int flagstatus, c;
;465:	vec3_t dir;
;466:	aas_entityinfo_t entinfo;
;467:
;468:	//when carrying a flag in ctf the bot should rush to the base
;469:	if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 172
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $186
line 471
;470:		//if not already rushing to the base
;471:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $188
line 472
;472:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 473
;473:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 5
ASGNI4
line 474
;474:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 475
;475:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 476
;476:			bs->decisionmaker = bs->client;
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 176
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 176
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 477
;477:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 479
;478:			//
;479:			switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 184
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 180
ADDRLP4 184
INDIRI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 1
EQI4 $193
ADDRLP4 180
INDIRI4
CNSTI4 2
EQI4 $198
ADDRGP4 $190
JUMPV
LABELV $193
line 480
;480:				case TEAM_RED: VectorSubtract(bs->origin, ctf_blueflag.origin, dir); break;
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
ADDRLP4 192
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRGP4 ctf_blueflag
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+4
ADDRLP4 192
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRGP4 ctf_blueflag+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRGP4 ctf_blueflag+8
INDIRF4
SUBF4
ASGNF4
ADDRGP4 $191
JUMPV
LABELV $198
line 481
;481:				case TEAM_BLUE: VectorSubtract(bs->origin, ctf_redflag.origin, dir); break;
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
ADDRLP4 196
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRGP4 ctf_redflag
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+4
ADDRLP4 196
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRGP4 ctf_redflag+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 160+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRGP4 ctf_redflag+8
INDIRF4
SUBF4
ASGNF4
ADDRGP4 $191
JUMPV
LABELV $190
line 482
;482:				default: VectorSet(dir, 999, 999, 999); break;
ADDRLP4 160
CNSTF4 1148829696
ASGNF4
ADDRLP4 160+4
CNSTF4 1148829696
ASGNF4
ADDRLP4 160+8
CNSTF4 1148829696
ASGNF4
LABELV $191
line 485
;483:			}
;484:			// if the bot picked up the flag very close to the enemy base
;485:			if ( VectorLength(dir) < 128 ) {
ADDRLP4 160
ARGP4
ADDRLP4 192
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 192
INDIRF4
CNSTF4 1124073472
GEF4 $205
line 487
;486:				// get an alternative route goal through the enemy base
;487:				BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 488
;488:			} else {
ADDRGP4 $206
JUMPV
LABELV $205
line 490
;489:				// don't use any alt route goal, just get the hell out of the base
;490:				bs->altroutegoal.areanum = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6692
ADDP4
CNSTI4 0
ASGNI4
line 491
;491:			}
LABELV $206
line 492
;492:			BotSetUserInfo(bs, "teamtask", va("%d", TEAMTASK_OFFENSE));
ADDRGP4 $160
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 196
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $159
ARGP4
ADDRLP4 196
INDIRP4
ARGP4
ADDRGP4 BotSetUserInfo
CALLV
pop
line 493
;493:		}
ADDRGP4 $185
JUMPV
LABELV $188
line 494
;494:		else if (bs->rushbaseaway_time > FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $185
line 495
;495:			if (BotTeam(bs) == TEAM_RED) flagstatus = bs->redflagstatus;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 176
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 1
NEI4 $209
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $210
JUMPV
LABELV $209
line 496
;496:			else flagstatus = bs->blueflagstatus;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6960
ADDP4
INDIRI4
ASGNI4
LABELV $210
line 498
;497:			//if the flag is back
;498:			if (flagstatus == 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $185
line 499
;499:				bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 500
;500:			}
line 501
;501:		}
line 502
;502:		return;
ADDRGP4 $185
JUMPV
LABELV $186
line 505
;503:	}
;504:	// if the bot decided to follow someone
;505:	if ( bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered ) {
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 176
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
NEI4 $213
ADDRLP4 176
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $213
line 507
;506:		// if the team mate being accompanied no longer carries the flag
;507:		BotEntityInfo(bs->teammate, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 508
;508:		if (!EntityCarriesFlag(&entinfo)) {
ADDRLP4 16
ARGP4
ADDRLP4 180
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 0
NEI4 $215
line 509
;509:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 510
;510:		}
LABELV $215
line 511
;511:	}
LABELV $213
line 513
;512:	//
;513:	if (BotTeam(bs) == TEAM_RED) flagstatus = bs->redflagstatus * 2 + bs->blueflagstatus;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 180
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 1
NEI4 $217
ADDRLP4 184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 184
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 184
INDIRP4
CNSTI4 6960
ADDP4
INDIRI4
ADDI4
ASGNI4
ADDRGP4 $218
JUMPV
LABELV $217
line 514
;514:	else flagstatus = bs->blueflagstatus * 2 + bs->redflagstatus;
ADDRLP4 188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 188
INDIRP4
CNSTI4 6960
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 188
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
ADDI4
ASGNI4
LABELV $218
line 516
;515:	//if our team has the enemy flag and our flag is at the base
;516:	if (flagstatus == 1) {
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $219
line 518
;517:		//
;518:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $185
line 520
;519:			//if Not defending the base already
;520:			if (!(bs->ltgtype == LTG_DEFENDKEYAREA &&
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
NEI4 $227
ADDRLP4 192
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ADDRGP4 ctf_redflag+44
INDIRI4
EQI4 $185
ADDRLP4 192
INDIRP4
CNSTI4 6668
ADDP4
INDIRI4
ADDRGP4 ctf_blueflag+44
INDIRI4
EQI4 $185
LABELV $227
line 522
;521:					(bs->teamgoal.number == ctf_redflag.number ||
;522:					bs->teamgoal.number == ctf_blueflag.number))) {
line 524
;523:				//if there is a visible team mate flag carrier
;524:				c = BotTeamFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotTeamFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 156
ADDRLP4 196
INDIRI4
ASGNI4
line 525
;525:				if (c >= 0 &&
ADDRLP4 200
ADDRLP4 156
INDIRI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 0
LTI4 $185
ADDRLP4 204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 204
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
NEI4 $230
ADDRLP4 204
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ADDRLP4 200
INDIRI4
EQI4 $185
LABELV $230
line 527
;526:						// and not already following the team mate flag carrier
;527:						(bs->ltgtype != LTG_TEAMACCOMPANY || bs->teammate != c)) {
line 529
;528:					//
;529:					BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 531
;530:					//follow the flag carrier
;531:					bs->decisionmaker = bs->client;
ADDRLP4 208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 208
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 208
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 532
;532:					bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 534
;533:					//the team mate
;534:					bs->teammate = c;
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRLP4 156
INDIRI4
ASGNI4
line 536
;535:					//last time the team mate was visible
;536:					bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6748
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 538
;537:					//no message
;538:					bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 540
;539:					//no arrive message
;540:					bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6172
ADDP4
CNSTF4 1065353216
ASGNF4
line 542
;541:					//get the team goal time
;542:					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 543
;543:					bs->ltgtype = LTG_TEAMACCOMPANY;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 2
ASGNI4
line 544
;544:					bs->formation_dist = 3.5 * 32;		//3.5 meter
ADDRFP4 0
INDIRP4
CNSTI4 7016
ADDP4
CNSTF4 1121976320
ASGNF4
line 545
;545:					BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 546
;546:					bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 547
;547:				}
line 548
;548:			}
line 549
;549:		}
line 550
;550:		return;
ADDRGP4 $185
JUMPV
LABELV $219
line 553
;551:	}
;552:	//if the enemy has our flag
;553:	else if (flagstatus == 2) {
ADDRLP4 0
INDIRI4
CNSTI4 2
NEI4 $231
line 555
;554:		//
;555:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $185
line 557
;556:			//if enemy flag carrier is visible
;557:			c = BotEnemyFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 BotEnemyFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 156
ADDRLP4 192
INDIRI4
ASGNI4
line 558
;558:			if (c >= 0) {
ADDRLP4 156
INDIRI4
CNSTI4 0
LTI4 $235
line 560
;559:				//FIXME: fight enemy flag carrier
;560:			}
LABELV $235
line 562
;561:			//if not already doing something important
;562:			if (bs->ltgtype != LTG_GETFLAG &&
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 196
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
EQI4 $185
ADDRLP4 196
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 6
EQI4 $185
ADDRLP4 196
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 1
EQI4 $185
ADDRLP4 196
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $185
ADDRLP4 196
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 8
EQI4 $185
ADDRLP4 196
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 9
EQI4 $185
ADDRLP4 196
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 10
EQI4 $185
line 568
;563:				bs->ltgtype != LTG_RETURNFLAG &&
;564:				bs->ltgtype != LTG_TEAMHELP &&
;565:				bs->ltgtype != LTG_TEAMACCOMPANY &&
;566:				bs->ltgtype != LTG_CAMPORDER &&
;567:				bs->ltgtype != LTG_PATROL &&
;568:				bs->ltgtype != LTG_GETITEM) {
line 570
;569:
;570:				BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 571
;571:				bs->decisionmaker = bs->client;
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 572
;572:				bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 574
;573:				//
;574:				if (random() < 0.5) {
ADDRLP4 204
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
GEF4 $239
line 576
;575:					//go for the enemy flag
;576:					bs->ltgtype = LTG_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 4
ASGNI4
line 577
;577:				}
ADDRGP4 $240
JUMPV
LABELV $239
line 578
;578:				else {
line 579
;579:					bs->ltgtype = LTG_RETURNFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 6
ASGNI4
line 580
;580:				}
LABELV $240
line 582
;581:				//no team message
;582:				bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 584
;583:				//set the time the bot will stop getting the flag
;584:				bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 586
;585:				//get an alternative route goal towards the enemy base
;586:				BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 588
;587:				//
;588:				BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 589
;589:				bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 590
;590:			}
line 591
;591:		}
line 592
;592:		return;
ADDRGP4 $185
JUMPV
LABELV $231
line 595
;593:	}
;594:	//if both flags Not at their bases
;595:	else if (flagstatus == 3) {
ADDRLP4 0
INDIRI4
CNSTI4 3
NEI4 $241
line 597
;596:		//
;597:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $185
line 599
;598:			// if not trying to return the flag and not following the team flag carrier
;599:			if ( bs->ltgtype != LTG_RETURNFLAG && bs->ltgtype != LTG_TEAMACCOMPANY ) {
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 6
EQI4 $185
ADDRLP4 192
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $185
line 601
;600:				//
;601:				c = BotTeamFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotTeamFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 156
ADDRLP4 196
INDIRI4
ASGNI4
line 603
;602:				// if there is a visible team mate flag carrier
;603:				if (c >= 0) {
ADDRLP4 156
INDIRI4
CNSTI4 0
LTI4 $247
line 604
;604:					BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 606
;605:					//follow the flag carrier
;606:					bs->decisionmaker = bs->client;
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 607
;607:					bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 609
;608:					//the team mate
;609:					bs->teammate = c;
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRLP4 156
INDIRI4
ASGNI4
line 611
;610:					//last time the team mate was visible
;611:					bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6748
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 613
;612:					//no message
;613:					bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 615
;614:					//no arrive message
;615:					bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6172
ADDP4
CNSTF4 1065353216
ASGNF4
line 617
;616:					//get the team goal time
;617:					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 618
;618:					bs->ltgtype = LTG_TEAMACCOMPANY;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 2
ASGNI4
line 619
;619:					bs->formation_dist = 3.5 * 32;		//3.5 meter
ADDRFP4 0
INDIRP4
CNSTI4 7016
ADDP4
CNSTF4 1121976320
ASGNF4
line 621
;620:					//
;621:					BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 622
;622:					bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 623
;623:				}
ADDRGP4 $185
JUMPV
LABELV $247
line 624
;624:				else {
line 625
;625:					BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 626
;626:					bs->decisionmaker = bs->client;
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 627
;627:					bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 629
;628:					//get the enemy flag
;629:					bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 204
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 204
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1073741824
MULF4
ADDF4
ASGNF4
line 631
;630:					//get the flag
;631:					bs->ltgtype = LTG_RETURNFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 6
ASGNI4
line 633
;632:					//set the time the bot will stop getting the flag
;633:					bs->teamgoal_time = FloatTime() + CTF_RETURNFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 635
;634:					//get an alternative route goal towards the enemy base
;635:					BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 637
;636:					//
;637:					BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 638
;638:					bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 639
;639:				}
line 640
;640:			}
line 641
;641:		}
line 642
;642:		return;
ADDRGP4 $185
JUMPV
LABELV $241
line 645
;643:	}
;644:	// don't just do something wait for the bot team leader to give orders
;645:	if (BotTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 192
ADDRGP4 BotTeamLeader
CALLI4
ASGNI4
ADDRLP4 192
INDIRI4
CNSTI4 0
EQI4 $249
line 646
;646:		return;
ADDRGP4 $185
JUMPV
LABELV $249
line 649
;647:	}
;648:	// if the bot is ordered to do something
;649:	if ( bs->lastgoal_ltgtype ) {
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $251
line 650
;650:		bs->teamgoal_time += 60;
ADDRLP4 196
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ASGNP4
ADDRLP4 196
INDIRP4
ADDRLP4 196
INDIRP4
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 651
;651:	}
LABELV $251
line 653
;652:	// if the bot decided to do something on it's own and has a last ordered goal
;653:	if ( !bs->ordered && bs->lastgoal_ltgtype ) {
ADDRLP4 196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 196
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $253
ADDRLP4 196
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $253
line 654
;654:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 655
;655:	}
LABELV $253
line 657
;656:	//if already a CTF or team goal
;657:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 1
EQI4 $266
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $266
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
EQI4 $266
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
EQI4 $266
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $266
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 6
EQI4 $266
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 8
EQI4 $266
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 9
EQI4 $266
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 10
EQI4 $266
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 14
EQI4 $266
ADDRLP4 200
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 15
NEI4 $255
LABELV $266
line 667
;658:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;659:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;660:			bs->ltgtype == LTG_GETFLAG ||
;661:			bs->ltgtype == LTG_RUSHBASE ||
;662:			bs->ltgtype == LTG_RETURNFLAG ||
;663:			bs->ltgtype == LTG_CAMPORDER ||
;664:			bs->ltgtype == LTG_PATROL ||
;665:			bs->ltgtype == LTG_GETITEM ||
;666:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;667:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
line 668
;668:		return;
ADDRGP4 $185
JUMPV
LABELV $255
line 671
;669:	}
;670:	//
;671:	if (BotSetLastOrderedTask(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 204
ADDRGP4 BotSetLastOrderedTask
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
EQI4 $267
line 672
;672:		return;
ADDRGP4 $185
JUMPV
LABELV $267
line 674
;673:	//
;674:	if (bs->owndecision_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
LEF4 $269
line 675
;675:		return;;
ADDRGP4 $185
JUMPV
LABELV $269
line 677
;676:	//if the bot is roaming
;677:	if (bs->ctfroam_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6164
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $271
line 678
;678:		return;
ADDRGP4 $185
JUMPV
LABELV $271
line 680
;679:	//if the bot has anough aggression to decide what to do
;680:	if (BotAggression(bs) < 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 208
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 208
INDIRF4
CNSTF4 1112014848
GEF4 $273
line 681
;681:		return;
ADDRGP4 $185
JUMPV
LABELV $273
line 683
;682:	//set the time to send a message to the team mates
;683:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 212
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 212
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1073741824
MULF4
ADDF4
ASGNF4
line 685
;684:	//
;685:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $275
line 686
;686:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $277
line 687
;687:			l1 = 0.7f;
ADDRLP4 8
CNSTF4 1060320051
ASGNF4
line 688
;688:		}
ADDRGP4 $278
JUMPV
LABELV $277
line 689
;689:		else {
line 690
;690:			l1 = 0.2f;
ADDRLP4 8
CNSTF4 1045220557
ASGNF4
line 691
;691:		}
LABELV $278
line 692
;692:		l2 = 0.9f;
ADDRLP4 12
CNSTF4 1063675494
ASGNF4
line 693
;693:	}
ADDRGP4 $276
JUMPV
LABELV $275
line 694
;694:	else {
line 695
;695:		l1 = 0.4f;
ADDRLP4 8
CNSTF4 1053609165
ASGNF4
line 696
;696:		l2 = 0.7f;
ADDRLP4 12
CNSTF4 1060320051
ASGNF4
line 697
;697:	}
LABELV $276
line 699
;698:	//get the flag or defend the base
;699:	rnd = random();
ADDRLP4 216
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 216
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ASGNF4
line 700
;700:	if (rnd < l1 && ctf_redflag.areanum && ctf_blueflag.areanum) {
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
GEF4 $279
ADDRGP4 ctf_redflag+12
INDIRI4
CNSTI4 0
EQI4 $279
ADDRGP4 ctf_blueflag+12
INDIRI4
CNSTI4 0
EQI4 $279
line 701
;701:		bs->decisionmaker = bs->client;
ADDRLP4 220
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 220
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 220
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 702
;702:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 703
;703:		bs->ltgtype = LTG_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 4
ASGNI4
line 705
;704:		//set the time the bot will stop getting the flag
;705:		bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 707
;706:		//get an alternative route goal towards the enemy base
;707:		BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 224
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 224
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 708
;708:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 709
;709:	}
ADDRGP4 $280
JUMPV
LABELV $279
line 710
;710:	else if (rnd < l2 && ctf_redflag.areanum && ctf_blueflag.areanum) {
ADDRLP4 4
INDIRF4
ADDRLP4 12
INDIRF4
GEF4 $283
ADDRGP4 ctf_redflag+12
INDIRI4
CNSTI4 0
EQI4 $283
ADDRGP4 ctf_blueflag+12
INDIRI4
CNSTI4 0
EQI4 $283
line 711
;711:		bs->decisionmaker = bs->client;
ADDRLP4 220
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 220
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 220
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 712
;712:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 714
;713:		//
;714:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 224
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 224
INDIRI4
CNSTI4 1
NEI4 $287
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $288
JUMPV
LABELV $287
line 715
;715:		else memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $288
line 717
;716:		//set the ltg type
;717:		bs->ltgtype = LTG_DEFENDKEYAREA;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 3
ASGNI4
line 719
;718:		//set the time the bot stops defending the base
;719:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 720
;720:		bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6144
ADDP4
CNSTF4 0
ASGNF4
line 721
;721:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 722
;722:	}
ADDRGP4 $284
JUMPV
LABELV $283
line 723
;723:	else {
line 724
;724:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 726
;725:		//set the time the bot will stop roaming
;726:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6164
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 727
;727:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 728
;728:	}
LABELV $284
LABELV $280
line 729
;729:	bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 733
;730:#ifdef DEBUG
;731:	BotPrintTeamGoal(bs);
;732:#endif //DEBUG
;733:}
LABELV $185
endproc BotCTFSeekGoals 228 12
export BotCTFRetreatGoals
proc BotCTFRetreatGoals 8 4
line 740
;734:
;735:/*
;736:==================
;737:BotCTFRetreatGoals
;738:==================
;739:*/
;740:void BotCTFRetreatGoals(bot_state_t *bs) {
line 742
;741:	//when carrying a flag in ctf the bot should rush to the base
;742:	if (BotCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $290
line 744
;743:		//if not already rushing to the base
;744:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $292
line 745
;745:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 746
;746:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 5
ASGNI4
line 747
;747:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 748
;748:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 749
;749:			bs->decisionmaker = bs->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 750
;750:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 751
;751:			BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 752
;752:		}
LABELV $292
line 753
;753:	}
LABELV $290
line 754
;754:}
LABELV $289
endproc BotCTFRetreatGoals 8 4
export Bot1FCTFSeekGoals
proc Bot1FCTFSeekGoals 200 12
line 761
;755:
;756:/*
;757:==================
;758:Bot1FCTFSeekGoals
;759:==================
;760:*/
;761:void Bot1FCTFSeekGoals(bot_state_t *bs) {
line 767
;762:	aas_entityinfo_t entinfo;
;763:	float rnd, l1, l2;
;764:	int c;
;765:
;766:	//when carrying a flag in ctf the bot should rush to the base
;767:	if (Bot1FCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 156
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $295
line 769
;768:		//if not already rushing to the base
;769:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $294
line 770
;770:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 771
;771:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 5
ASGNI4
line 772
;772:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 773
;773:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 774
;774:			bs->decisionmaker = bs->client;
ADDRLP4 160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 160
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 775
;775:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 777
;776:			//get an alternative route goal towards the enemy base
;777:			BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 779
;778:			//
;779:			BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 780
;780:		}
line 781
;781:		return;
ADDRGP4 $294
JUMPV
LABELV $295
line 784
;782:	}
;783:	// if the bot decided to follow someone
;784:	if ( bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered ) {
ADDRLP4 160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
NEI4 $299
ADDRLP4 160
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $299
line 786
;785:		// if the team mate being accompanied no longer carries the flag
;786:		BotEntityInfo(bs->teammate, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 787
;787:		if (!EntityCarriesFlag(&entinfo)) {
ADDRLP4 12
ARGP4
ADDRLP4 164
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
NEI4 $301
line 788
;788:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 789
;789:		}
LABELV $301
line 790
;790:	}
LABELV $299
line 792
;791:	//our team has the flag
;792:	if (bs->neutralflagstatus == 1) {
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
INDIRI4
CNSTI4 1
NEI4 $303
line 793
;793:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $294
line 795
;794:			// if not already following someone
;795:			if (bs->ltgtype != LTG_TEAMACCOMPANY) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $307
line 797
;796:				//if there is a visible team mate flag carrier
;797:				c = BotTeamFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotTeamFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 152
ADDRLP4 164
INDIRI4
ASGNI4
line 798
;798:				if (c >= 0) {
ADDRLP4 152
INDIRI4
CNSTI4 0
LTI4 $309
line 799
;799:					BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 801
;800:					//follow the flag carrier
;801:					bs->decisionmaker = bs->client;
ADDRLP4 168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 168
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 168
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 802
;802:					bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 804
;803:					//the team mate
;804:					bs->teammate = c;
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRLP4 152
INDIRI4
ASGNI4
line 806
;805:					//last time the team mate was visible
;806:					bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6748
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 808
;807:					//no message
;808:					bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 810
;809:					//no arrive message
;810:					bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6172
ADDP4
CNSTF4 1065353216
ASGNF4
line 812
;811:					//get the team goal time
;812:					bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 813
;813:					bs->ltgtype = LTG_TEAMACCOMPANY;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 2
ASGNI4
line 814
;814:					bs->formation_dist = 3.5 * 32;		//3.5 meter
ADDRFP4 0
INDIRP4
CNSTI4 7016
ADDP4
CNSTF4 1121976320
ASGNF4
line 815
;815:					BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 816
;816:					bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 817
;817:					return;
ADDRGP4 $294
JUMPV
LABELV $309
line 819
;818:				}
;819:			}
LABELV $307
line 821
;820:			//if already a CTF or team goal
;821:			if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 1
EQI4 $322
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $322
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
EQI4 $322
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
EQI4 $322
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $322
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 8
EQI4 $322
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 9
EQI4 $322
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 13
EQI4 $322
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 10
EQI4 $322
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 14
EQI4 $322
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 15
NEI4 $311
LABELV $322
line 831
;822:					bs->ltgtype == LTG_TEAMACCOMPANY ||
;823:					bs->ltgtype == LTG_DEFENDKEYAREA ||
;824:					bs->ltgtype == LTG_GETFLAG ||
;825:					bs->ltgtype == LTG_RUSHBASE ||
;826:					bs->ltgtype == LTG_CAMPORDER ||
;827:					bs->ltgtype == LTG_PATROL ||
;828:					bs->ltgtype == LTG_ATTACKENEMYBASE ||
;829:					bs->ltgtype == LTG_GETITEM ||
;830:					bs->ltgtype == LTG_MAKELOVE_UNDER ||
;831:					bs->ltgtype == LTG_MAKELOVE_ONTOP) {
line 832
;832:				return;
ADDRGP4 $294
JUMPV
LABELV $311
line 835
;833:			}
;834:			//if not already attacking the enemy base
;835:			if (bs->ltgtype != LTG_ATTACKENEMYBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 13
EQI4 $294
line 836
;836:				BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 837
;837:				bs->decisionmaker = bs->client;
ADDRLP4 168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 168
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 168
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 838
;838:				bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 840
;839:				//
;840:				if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 172
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 1
NEI4 $325
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $326
JUMPV
LABELV $325
line 841
;841:				else memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $326
line 843
;842:				//set the ltg type
;843:				bs->ltgtype = LTG_ATTACKENEMYBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 13
ASGNI4
line 845
;844:				//set the time the bot will stop getting the flag
;845:				bs->teamgoal_time = FloatTime() + TEAM_ATTACKENEMYBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 846
;846:				BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 847
;847:				bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 848
;848:			}
line 849
;849:		}
line 850
;850:		return;
ADDRGP4 $294
JUMPV
LABELV $303
line 853
;851:	}
;852:	//enemy team has the flag
;853:	else if (bs->neutralflagstatus == 2) {
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
INDIRI4
CNSTI4 2
NEI4 $327
line 854
;854:		if (bs->owndecision_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
GEF4 $294
line 855
;855:			c = BotEnemyFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotEnemyFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 152
ADDRLP4 164
INDIRI4
ASGNI4
line 856
;856:			if (c >= 0) {
ADDRLP4 152
INDIRI4
CNSTI4 0
LTI4 $331
line 858
;857:				//FIXME: attack enemy flag carrier
;858:			}
LABELV $331
line 860
;859:			//if already a CTF or team goal
;860:			if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 1
EQI4 $338
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $338
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 8
EQI4 $338
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 9
EQI4 $338
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 10
NEI4 $333
LABELV $338
line 864
;861:					bs->ltgtype == LTG_TEAMACCOMPANY ||
;862:					bs->ltgtype == LTG_CAMPORDER ||
;863:					bs->ltgtype == LTG_PATROL ||
;864:					bs->ltgtype == LTG_GETITEM) {
line 865
;865:				return;
ADDRGP4 $294
JUMPV
LABELV $333
line 868
;866:			}
;867:			// if not already defending the base
;868:			if (bs->ltgtype != LTG_DEFENDKEYAREA) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
EQI4 $294
line 869
;869:				BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 870
;870:				bs->decisionmaker = bs->client;
ADDRLP4 172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 172
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 172
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 871
;871:				bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 873
;872:				//
;873:				if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 176
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 1
NEI4 $341
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $342
JUMPV
LABELV $341
line 874
;874:				else memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $342
line 876
;875:				//set the ltg type
;876:				bs->ltgtype = LTG_DEFENDKEYAREA;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 3
ASGNI4
line 878
;877:				//set the time the bot stops defending the base
;878:				bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 879
;879:				bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6144
ADDP4
CNSTF4 0
ASGNF4
line 880
;880:				BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 881
;881:				bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 882
;882:			}
line 883
;883:		}
line 884
;884:		return;
ADDRGP4 $294
JUMPV
LABELV $327
line 887
;885:	}
;886:	// don't just do something wait for the bot team leader to give orders
;887:	if (BotTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotTeamLeader
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
EQI4 $343
line 888
;888:		return;
ADDRGP4 $294
JUMPV
LABELV $343
line 891
;889:	}
;890:	// if the bot is ordered to do something
;891:	if ( bs->lastgoal_ltgtype ) {
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $345
line 892
;892:		bs->teamgoal_time += 60;
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 893
;893:	}
LABELV $345
line 895
;894:	// if the bot decided to do something on it's own and has a last ordered goal
;895:	if ( !bs->ordered && bs->lastgoal_ltgtype ) {
ADDRLP4 168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 168
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $347
ADDRLP4 168
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $347
line 896
;896:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 897
;897:	}
LABELV $347
line 899
;898:	//if already a CTF or team goal
;899:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 1
EQI4 $361
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $361
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
EQI4 $361
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
EQI4 $361
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $361
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 6
EQI4 $361
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 8
EQI4 $361
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 9
EQI4 $361
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 13
EQI4 $361
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 10
EQI4 $361
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 14
EQI4 $361
ADDRLP4 172
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 15
NEI4 $349
LABELV $361
line 910
;900:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;901:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;902:			bs->ltgtype == LTG_GETFLAG ||
;903:			bs->ltgtype == LTG_RUSHBASE ||
;904:			bs->ltgtype == LTG_RETURNFLAG ||
;905:			bs->ltgtype == LTG_CAMPORDER ||
;906:			bs->ltgtype == LTG_PATROL ||
;907:			bs->ltgtype == LTG_ATTACKENEMYBASE ||
;908:			bs->ltgtype == LTG_GETITEM ||
;909:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;910:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
line 911
;911:		return;
ADDRGP4 $294
JUMPV
LABELV $349
line 914
;912:	}
;913:	//
;914:	if (BotSetLastOrderedTask(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 176
ADDRGP4 BotSetLastOrderedTask
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 0
EQI4 $362
line 915
;915:		return;
ADDRGP4 $294
JUMPV
LABELV $362
line 917
;916:	//
;917:	if (bs->owndecision_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 floattime
INDIRF4
LEF4 $364
line 918
;918:		return;;
ADDRGP4 $294
JUMPV
LABELV $364
line 920
;919:	//if the bot is roaming
;920:	if (bs->ctfroam_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6164
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $366
line 921
;921:		return;
ADDRGP4 $294
JUMPV
LABELV $366
line 923
;922:	//if the bot has anough aggression to decide what to do
;923:	if (BotAggression(bs) < 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 180
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 180
INDIRF4
CNSTF4 1112014848
GEF4 $368
line 924
;924:		return;
ADDRGP4 $294
JUMPV
LABELV $368
line 926
;925:	//set the time to send a message to the team mates
;926:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 184
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 184
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1073741824
MULF4
ADDF4
ASGNF4
line 928
;927:	//
;928:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $370
line 929
;929:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $372
line 930
;930:			l1 = 0.7f;
ADDRLP4 4
CNSTF4 1060320051
ASGNF4
line 931
;931:		}
ADDRGP4 $373
JUMPV
LABELV $372
line 932
;932:		else {
line 933
;933:			l1 = 0.2f;
ADDRLP4 4
CNSTF4 1045220557
ASGNF4
line 934
;934:		}
LABELV $373
line 935
;935:		l2 = 0.9f;
ADDRLP4 8
CNSTF4 1063675494
ASGNF4
line 936
;936:	}
ADDRGP4 $371
JUMPV
LABELV $370
line 937
;937:	else {
line 938
;938:		l1 = 0.4f;
ADDRLP4 4
CNSTF4 1053609165
ASGNF4
line 939
;939:		l2 = 0.7f;
ADDRLP4 8
CNSTF4 1060320051
ASGNF4
line 940
;940:	}
LABELV $371
line 942
;941:	//get the flag or defend the base
;942:	rnd = random();
ADDRLP4 188
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 188
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ASGNF4
line 943
;943:	if (rnd < l1 && ctf_neutralflag.areanum) {
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
GEF4 $374
ADDRGP4 ctf_neutralflag+12
INDIRI4
CNSTI4 0
EQI4 $374
line 944
;944:		bs->decisionmaker = bs->client;
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 192
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 945
;945:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 946
;946:		bs->ltgtype = LTG_GETFLAG;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 4
ASGNI4
line 948
;947:		//set the time the bot will stop getting the flag
;948:		bs->teamgoal_time = FloatTime() + CTF_GETFLAG_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 949
;949:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 950
;950:	}
ADDRGP4 $375
JUMPV
LABELV $374
line 951
;951:	else if (rnd < l2 && ctf_redflag.areanum && ctf_blueflag.areanum) {
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
GEF4 $377
ADDRGP4 ctf_redflag+12
INDIRI4
CNSTI4 0
EQI4 $377
ADDRGP4 ctf_blueflag+12
INDIRI4
CNSTI4 0
EQI4 $377
line 952
;952:		bs->decisionmaker = bs->client;
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 192
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 953
;953:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 955
;954:		//
;955:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &ctf_redflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 1
NEI4 $381
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 ctf_redflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $382
JUMPV
LABELV $381
line 956
;956:		else memcpy(&bs->teamgoal, &ctf_blueflag, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $382
line 958
;957:		//set the ltg type
;958:		bs->ltgtype = LTG_DEFENDKEYAREA;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 3
ASGNI4
line 960
;959:		//set the time the bot stops defending the base
;960:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 961
;961:		bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6144
ADDP4
CNSTF4 0
ASGNF4
line 962
;962:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 963
;963:	}
ADDRGP4 $378
JUMPV
LABELV $377
line 964
;964:	else {
line 965
;965:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 967
;966:		//set the time the bot will stop roaming
;967:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6164
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 968
;968:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 969
;969:	}
LABELV $378
LABELV $375
line 970
;970:	bs->owndecision_time = FloatTime() + 5;
ADDRFP4 0
INDIRP4
CNSTI4 6620
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CVFI4 4
ASGNI4
line 974
;971:#ifdef DEBUG
;972:	BotPrintTeamGoal(bs);
;973:#endif //DEBUG
;974:}
LABELV $294
endproc Bot1FCTFSeekGoals 200 12
export Bot1FCTFRetreatGoals
proc Bot1FCTFRetreatGoals 12 8
line 981
;975:
;976:/*
;977:==================
;978:Bot1FCTFRetreatGoals
;979:==================
;980:*/
;981:void Bot1FCTFRetreatGoals(bot_state_t *bs) {
line 983
;982:	//when carrying a flag in ctf the bot should rush to the enemy base
;983:	if (Bot1FCTFCarryingFlag(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $384
line 985
;984:		//if not already rushing to the base
;985:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $386
line 986
;986:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 987
;987:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 5
ASGNI4
line 988
;988:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 989
;989:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 990
;990:			bs->decisionmaker = bs->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 991
;991:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 993
;992:			//get an alternative route goal towards the enemy base
;993:			BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 994
;994:			BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 995
;995:		}
LABELV $386
line 996
;996:	}
LABELV $384
line 997
;997:}
LABELV $383
endproc Bot1FCTFRetreatGoals 12 8
export BotObeliskSeekGoals
proc BotObeliskSeekGoals 48 12
line 1004
;998:
;999:/*
;1000:==================
;1001:BotObeliskSeekGoals
;1002:==================
;1003:*/
;1004:void BotObeliskSeekGoals(bot_state_t *bs) {
line 1008
;1005:	float rnd, l1, l2;
;1006:
;1007:	// don't just do something wait for the bot team leader to give orders
;1008:	if (BotTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 BotTeamLeader
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $389
line 1009
;1009:		return;
ADDRGP4 $388
JUMPV
LABELV $389
line 1012
;1010:	}
;1011:	// if the bot is ordered to do something
;1012:	if ( bs->lastgoal_ltgtype ) {
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $391
line 1013
;1013:		bs->teamgoal_time += 60;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 1014
;1014:	}
LABELV $391
line 1016
;1015:	//if already a team goal
;1016:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 1
EQI4 $405
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $405
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
EQI4 $405
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
EQI4 $405
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $405
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 6
EQI4 $405
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 8
EQI4 $405
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 9
EQI4 $405
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 13
EQI4 $405
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 10
EQI4 $405
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 14
EQI4 $405
ADDRLP4 16
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 15
NEI4 $393
LABELV $405
line 1027
;1017:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;1018:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;1019:			bs->ltgtype == LTG_GETFLAG ||
;1020:			bs->ltgtype == LTG_RUSHBASE ||
;1021:			bs->ltgtype == LTG_RETURNFLAG ||
;1022:			bs->ltgtype == LTG_CAMPORDER ||
;1023:			bs->ltgtype == LTG_PATROL ||
;1024:			bs->ltgtype == LTG_ATTACKENEMYBASE ||
;1025:			bs->ltgtype == LTG_GETITEM ||
;1026:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;1027:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
line 1028
;1028:		return;
ADDRGP4 $388
JUMPV
LABELV $393
line 1031
;1029:	}
;1030:	//
;1031:	if (BotSetLastOrderedTask(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 BotSetLastOrderedTask
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $406
line 1032
;1032:		return;
ADDRGP4 $388
JUMPV
LABELV $406
line 1034
;1033:	//if the bot is roaming
;1034:	if (bs->ctfroam_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6164
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $408
line 1035
;1035:		return;
ADDRGP4 $388
JUMPV
LABELV $408
line 1037
;1036:	//if the bot has anough aggression to decide what to do
;1037:	if (BotAggression(bs) < 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 24
INDIRF4
CNSTF4 1112014848
GEF4 $410
line 1038
;1038:		return;
ADDRGP4 $388
JUMPV
LABELV $410
line 1040
;1039:	//set the time to send a message to the team mates
;1040:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 28
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 28
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1073741824
MULF4
ADDF4
ASGNF4
line 1042
;1041:	//
;1042:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $412
line 1043
;1043:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $414
line 1044
;1044:			l1 = 0.7f;
ADDRLP4 4
CNSTF4 1060320051
ASGNF4
line 1045
;1045:		}
ADDRGP4 $415
JUMPV
LABELV $414
line 1046
;1046:		else {
line 1047
;1047:			l1 = 0.2f;
ADDRLP4 4
CNSTF4 1045220557
ASGNF4
line 1048
;1048:		}
LABELV $415
line 1049
;1049:		l2 = 0.9f;
ADDRLP4 8
CNSTF4 1063675494
ASGNF4
line 1050
;1050:	}
ADDRGP4 $413
JUMPV
LABELV $412
line 1051
;1051:	else {
line 1052
;1052:		l1 = 0.4f;
ADDRLP4 4
CNSTF4 1053609165
ASGNF4
line 1053
;1053:		l2 = 0.7f;
ADDRLP4 8
CNSTF4 1060320051
ASGNF4
line 1054
;1054:	}
LABELV $413
line 1056
;1055:	//get the flag or defend the base
;1056:	rnd = random();
ADDRLP4 32
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 32
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ASGNF4
line 1057
;1057:	if (rnd < l1 && redobelisk.areanum && blueobelisk.areanum) {
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRF4
GEF4 $416
ADDRGP4 redobelisk+12
INDIRI4
CNSTI4 0
EQI4 $416
ADDRGP4 blueobelisk+12
INDIRI4
CNSTI4 0
EQI4 $416
line 1058
;1058:		bs->decisionmaker = bs->client;
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1059
;1059:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 1061
;1060:		//
;1061:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 1
NEI4 $420
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 blueobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $421
JUMPV
LABELV $420
line 1062
;1062:		else memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 redobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $421
line 1064
;1063:		//set the ltg type
;1064:		bs->ltgtype = LTG_ATTACKENEMYBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 13
ASGNI4
line 1066
;1065:		//set the time the bot will stop attacking the enemy base
;1066:		bs->teamgoal_time = FloatTime() + TEAM_ATTACKENEMYBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 1068
;1067:		//get an alternate route goal towards the enemy base
;1068:		BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 1069
;1069:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1070
;1070:	}
ADDRGP4 $417
JUMPV
LABELV $416
line 1071
;1071:	else if (rnd < l2 && redobelisk.areanum && blueobelisk.areanum) {
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
GEF4 $422
ADDRGP4 redobelisk+12
INDIRI4
CNSTI4 0
EQI4 $422
ADDRGP4 blueobelisk+12
INDIRI4
CNSTI4 0
EQI4 $422
line 1072
;1072:		bs->decisionmaker = bs->client;
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1073
;1073:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 1075
;1074:		//
;1075:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 1
NEI4 $426
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 redobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $427
JUMPV
LABELV $426
line 1076
;1076:		else memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 blueobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $427
line 1078
;1077:		//set the ltg type
;1078:		bs->ltgtype = LTG_DEFENDKEYAREA;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 3
ASGNI4
line 1080
;1079:		//set the time the bot stops defending the base
;1080:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 1081
;1081:		bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6144
ADDP4
CNSTF4 0
ASGNF4
line 1082
;1082:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1083
;1083:	}
ADDRGP4 $423
JUMPV
LABELV $422
line 1084
;1084:	else {
line 1085
;1085:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 1087
;1086:		//set the time the bot will stop roaming
;1087:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6164
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 1088
;1088:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1089
;1089:	}
LABELV $423
LABELV $417
line 1090
;1090:}
LABELV $388
endproc BotObeliskSeekGoals 48 12
export BotGoHarvest
proc BotGoHarvest 4 12
line 1097
;1091:
;1092:/*
;1093:==================
;1094:BotGoHarvest
;1095:==================
;1096:*/
;1097:void BotGoHarvest(bot_state_t *bs) {
line 1099
;1098:	//
;1099:	if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
NEI4 $429
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 blueobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $430
JUMPV
LABELV $429
line 1100
;1100:	else memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 redobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $430
line 1102
;1101:	//set the ltg type
;1102:	bs->ltgtype = LTG_HARVEST;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 12
ASGNI4
line 1104
;1103:	//set the time the bot will stop harvesting
;1104:	bs->teamgoal_time = FloatTime() + TEAM_HARVEST_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 1105
;1105:	bs->harvestaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6160
ADDP4
CNSTF4 0
ASGNF4
line 1106
;1106:	BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1107
;1107:}
LABELV $428
endproc BotGoHarvest 4 12
export BotObeliskRetreatGoals
proc BotObeliskRetreatGoals 0 0
line 1114
;1108:
;1109:/*
;1110:==================
;1111:BotObeliskRetreatGoals
;1112:==================
;1113:*/
;1114:void BotObeliskRetreatGoals(bot_state_t *bs) {
line 1116
;1115:	//nothing special
;1116:}
LABELV $431
endproc BotObeliskRetreatGoals 0 0
export BotHarvesterSeekGoals
proc BotHarvesterSeekGoals 200 12
line 1123
;1117:
;1118:/*
;1119:==================
;1120:BotHarvesterSeekGoals
;1121:==================
;1122:*/
;1123:void BotHarvesterSeekGoals(bot_state_t *bs) {
line 1129
;1124:	aas_entityinfo_t entinfo;
;1125:	float rnd, l1, l2;
;1126:	int c;
;1127:
;1128:	//when carrying cubes in harvester the bot should rush to the base
;1129:	if (BotHarvesterCarryingSkulls(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 156
ADDRGP4 BotHarvesterCarryingSkulls
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $433
line 1131
;1130:		//if not already rushing to the base
;1131:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $432
line 1132
;1132:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 1133
;1133:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 5
ASGNI4
line 1134
;1134:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 1135
;1135:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 1136
;1136:			bs->decisionmaker = bs->client;
ADDRLP4 160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 160
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1137
;1137:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 1139
;1138:			//get an alternative route goal towards the enemy base
;1139:			BotGetAlternateRouteGoal(bs, BotOppositeTeam(bs));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
ADDRGP4 BotOppositeTeam
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 164
INDIRI4
ARGI4
ADDRGP4 BotGetAlternateRouteGoal
CALLI4
pop
line 1141
;1140:			//
;1141:			BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1142
;1142:		}
line 1143
;1143:		return;
ADDRGP4 $432
JUMPV
LABELV $433
line 1146
;1144:	}
;1145:	// don't just do something wait for the bot team leader to give orders
;1146:	if (BotTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 160
ADDRGP4 BotTeamLeader
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
EQI4 $437
line 1147
;1147:		return;
ADDRGP4 $432
JUMPV
LABELV $437
line 1150
;1148:	}
;1149:	// if the bot decided to follow someone
;1150:	if ( bs->ltgtype == LTG_TEAMACCOMPANY && !bs->ordered ) {
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 164
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
NEI4 $439
ADDRLP4 164
INDIRP4
CNSTI4 6612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $439
line 1152
;1151:		// if the team mate being accompanied no longer carries the flag
;1152:		BotEntityInfo(bs->teammate, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1153
;1153:		if (!EntityCarriesSkulls(&entinfo)) {
ADDRLP4 16
ARGP4
ADDRLP4 168
ADDRGP4 EntityCarriesSkulls
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
NEI4 $441
line 1154
;1154:			bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 1155
;1155:		}
LABELV $441
line 1156
;1156:	}
LABELV $439
line 1158
;1157:	// if the bot is ordered to do something
;1158:	if ( bs->lastgoal_ltgtype ) {
ADDRFP4 0
INDIRP4
CNSTI4 6760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $443
line 1159
;1159:		bs->teamgoal_time += 60;
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 1160
;1160:	}
LABELV $443
line 1162
;1161:	//if not yet doing something
;1162:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 1
EQI4 $456
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $456
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
EQI4 $456
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
EQI4 $456
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 8
EQI4 $456
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 9
EQI4 $456
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 13
EQI4 $456
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 12
EQI4 $456
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 10
EQI4 $456
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 14
EQI4 $456
ADDRLP4 168
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 15
NEI4 $445
LABELV $456
line 1172
;1163:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;1164:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;1165:			bs->ltgtype == LTG_GETFLAG ||
;1166:			bs->ltgtype == LTG_CAMPORDER ||
;1167:			bs->ltgtype == LTG_PATROL ||
;1168:			bs->ltgtype == LTG_ATTACKENEMYBASE ||
;1169:			bs->ltgtype == LTG_HARVEST ||
;1170:			bs->ltgtype == LTG_GETITEM ||
;1171:			bs->ltgtype == LTG_MAKELOVE_UNDER ||
;1172:			bs->ltgtype == LTG_MAKELOVE_ONTOP) {
line 1173
;1173:		return;
ADDRGP4 $432
JUMPV
LABELV $445
line 1176
;1174:	}
;1175:	//
;1176:	if (BotSetLastOrderedTask(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 172
ADDRGP4 BotSetLastOrderedTask
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $457
line 1177
;1177:		return;
ADDRGP4 $432
JUMPV
LABELV $457
line 1179
;1178:	//if the bot is roaming
;1179:	if (bs->ctfroam_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6164
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $459
line 1180
;1180:		return;
ADDRGP4 $432
JUMPV
LABELV $459
line 1182
;1181:	//if the bot has anough aggression to decide what to do
;1182:	if (BotAggression(bs) < 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 176
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 176
INDIRF4
CNSTF4 1112014848
GEF4 $461
line 1183
;1183:		return;
ADDRGP4 $432
JUMPV
LABELV $461
line 1185
;1184:	//set the time to send a message to the team mates
;1185:	bs->teammessage_time = FloatTime() + 2 * random();
ADDRLP4 180
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 180
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1073741824
MULF4
ADDF4
ASGNF4
line 1187
;1186:	//
;1187:	c = BotEnemySkullCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 184
ADDRGP4 BotEnemySkullCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 184
INDIRI4
ASGNI4
line 1188
;1188:	if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $463
line 1190
;1189:		//FIXME: attack enemy cube carrier
;1190:	}
LABELV $463
line 1191
;1191:	if (bs->ltgtype != LTG_TEAMACCOMPANY) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $465
line 1193
;1192:		//if there is a visible team mate carrying cubes
;1193:		c = BotTeamSkullCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 188
ADDRGP4 BotTeamSkullCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 188
INDIRI4
ASGNI4
line 1194
;1194:		if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $467
line 1196
;1195:			//follow the team mate carrying cubes
;1196:			bs->decisionmaker = bs->client;
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 192
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1197
;1197:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 1199
;1198:			//the team mate
;1199:			bs->teammate = c;
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1201
;1200:			//last time the team mate was visible
;1201:			bs->teammatevisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6748
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1203
;1202:			//no message
;1203:			bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 1205
;1204:			//no arrive message
;1205:			bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6172
ADDP4
CNSTF4 1065353216
ASGNF4
line 1207
;1206:			//get the team goal time
;1207:			bs->teamgoal_time = FloatTime() + TEAM_ACCOMPANY_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 1208
;1208:			bs->ltgtype = LTG_TEAMACCOMPANY;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 2
ASGNI4
line 1209
;1209:			bs->formation_dist = 3.5 * 32;		//3.5 meter
ADDRFP4 0
INDIRP4
CNSTI4 7016
ADDP4
CNSTF4 1121976320
ASGNF4
line 1210
;1210:			BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1211
;1211:			return;
ADDRGP4 $432
JUMPV
LABELV $467
line 1213
;1212:		}
;1213:	}
LABELV $465
line 1215
;1214:	//
;1215:	if (bs->teamtaskpreference & (TEAMTP_ATTACKER|TEAMTP_DEFENDER)) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $469
line 1216
;1216:		if (bs->teamtaskpreference & TEAMTP_ATTACKER) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $471
line 1217
;1217:			l1 = 0.7f;
ADDRLP4 8
CNSTF4 1060320051
ASGNF4
line 1218
;1218:		}
ADDRGP4 $472
JUMPV
LABELV $471
line 1219
;1219:		else {
line 1220
;1220:			l1 = 0.2f;
ADDRLP4 8
CNSTF4 1045220557
ASGNF4
line 1221
;1221:		}
LABELV $472
line 1222
;1222:		l2 = 0.9f;
ADDRLP4 12
CNSTF4 1063675494
ASGNF4
line 1223
;1223:	}
ADDRGP4 $470
JUMPV
LABELV $469
line 1224
;1224:	else {
line 1225
;1225:		l1 = 0.4f;
ADDRLP4 8
CNSTF4 1053609165
ASGNF4
line 1226
;1226:		l2 = 0.7f;
ADDRLP4 12
CNSTF4 1060320051
ASGNF4
line 1227
;1227:	}
LABELV $470
line 1229
;1228:	//
;1229:	rnd = random();
ADDRLP4 188
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 188
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ASGNF4
line 1230
;1230:	if (rnd < l1 && redobelisk.areanum && blueobelisk.areanum) {
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
GEF4 $473
ADDRGP4 redobelisk+12
INDIRI4
CNSTI4 0
EQI4 $473
ADDRGP4 blueobelisk+12
INDIRI4
CNSTI4 0
EQI4 $473
line 1231
;1231:		bs->decisionmaker = bs->client;
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 192
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1232
;1232:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 1233
;1233:		BotGoHarvest(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotGoHarvest
CALLV
pop
line 1234
;1234:	}
ADDRGP4 $474
JUMPV
LABELV $473
line 1235
;1235:	else if (rnd < l2 && redobelisk.areanum && blueobelisk.areanum) {
ADDRLP4 4
INDIRF4
ADDRLP4 12
INDIRF4
GEF4 $477
ADDRGP4 redobelisk+12
INDIRI4
CNSTI4 0
EQI4 $477
ADDRGP4 blueobelisk+12
INDIRI4
CNSTI4 0
EQI4 $477
line 1236
;1236:		bs->decisionmaker = bs->client;
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 192
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1237
;1237:		bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 1239
;1238:		//
;1239:		if (BotTeam(bs) == TEAM_RED) memcpy(&bs->teamgoal, &redobelisk, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 1
NEI4 $481
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 redobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
ADDRGP4 $482
JUMPV
LABELV $481
line 1240
;1240:		else memcpy(&bs->teamgoal, &blueobelisk, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRGP4 blueobelisk
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
LABELV $482
line 1242
;1241:		//set the ltg type
;1242:		bs->ltgtype = LTG_DEFENDKEYAREA;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 3
ASGNI4
line 1244
;1243:		//set the time the bot stops defending the base
;1244:		bs->teamgoal_time = FloatTime() + TEAM_DEFENDKEYAREA_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1142292480
ADDF4
ASGNF4
line 1245
;1245:		bs->defendaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6144
ADDP4
CNSTF4 0
ASGNF4
line 1246
;1246:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1247
;1247:	}
ADDRGP4 $478
JUMPV
LABELV $477
line 1248
;1248:	else {
line 1249
;1249:		bs->ltgtype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 0
ASGNI4
line 1251
;1250:		//set the time the bot will stop roaming
;1251:		bs->ctfroam_time = FloatTime() + CTF_ROAM_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6164
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
ADDF4
ASGNF4
line 1252
;1252:		BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1253
;1253:	}
LABELV $478
LABELV $474
line 1254
;1254:}
LABELV $432
endproc BotHarvesterSeekGoals 200 12
export BotHarvesterRetreatGoals
proc BotHarvesterRetreatGoals 8 4
line 1261
;1255:
;1256:/*
;1257:==================
;1258:BotHarvesterRetreatGoals
;1259:==================
;1260:*/
;1261:void BotHarvesterRetreatGoals(bot_state_t *bs) {
line 1263
;1262:	//when carrying cubes in harvester the bot should rush to the base
;1263:	if (BotHarvesterCarryingSkulls(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotHarvesterCarryingSkulls
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $484
line 1265
;1264:		//if not already rushing to the base
;1265:		if (bs->ltgtype != LTG_RUSHBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $483
line 1266
;1266:			BotRefuseOrder(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotRefuseOrder
CALLV
pop
line 1267
;1267:			bs->ltgtype = LTG_RUSHBASE;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 5
ASGNI4
line 1268
;1268:			bs->teamgoal_time = FloatTime() + CTF_RUSHBASE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 1269
;1269:			bs->rushbaseaway_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6152
ADDP4
CNSTF4 0
ASGNF4
line 1270
;1270:			bs->decisionmaker = bs->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1271
;1271:			bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 1272
;1272:			BotSetTeamStatus(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeamStatus
CALLV
pop
line 1273
;1273:		}
line 1274
;1274:		return;
LABELV $484
line 1276
;1275:	}
;1276:}
LABELV $483
endproc BotHarvesterRetreatGoals 8 4
export BotTeamGoals
proc BotTeamGoals 0 4
line 1284
;1277:
;1278:
;1279:/*
;1280:==================
;1281:BotTeamGoals
;1282:==================
;1283:*/
;1284:void BotTeamGoals(bot_state_t *bs, int retreat) {
line 1286
;1285:
;1286:	if ( retreat ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $489
line 1287
;1287:		if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $491
line 1288
;1288:			BotCTFRetreatGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFRetreatGoals
CALLV
pop
line 1289
;1289:		} else if (gametype == GT_1FCTF) {
ADDRGP4 $490
JUMPV
LABELV $491
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $493
line 1290
;1290:			Bot1FCTFRetreatGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Bot1FCTFRetreatGoals
CALLV
pop
line 1291
;1291:		} else if (gametype == GT_OBELISK) {
ADDRGP4 $490
JUMPV
LABELV $493
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $495
line 1292
;1292:			BotObeliskRetreatGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotObeliskRetreatGoals
CALLV
pop
line 1293
;1293:		} else if (gametype == GT_HARVESTER) {
ADDRGP4 $490
JUMPV
LABELV $495
ADDRGP4 gametype
INDIRI4
CNSTI4 8
NEI4 $490
line 1294
;1294:			BotHarvesterRetreatGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotHarvesterRetreatGoals
CALLV
pop
line 1295
;1295:		}
line 1296
;1296:	}
ADDRGP4 $490
JUMPV
LABELV $489
line 1297
;1297:	else {
line 1298
;1298:		if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $499
line 1300
;1299:			//decide what to do in CTF mode
;1300:			BotCTFSeekGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFSeekGoals
CALLV
pop
line 1301
;1301:		} else if (gametype == GT_1FCTF) {
ADDRGP4 $500
JUMPV
LABELV $499
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $501
line 1302
;1302:			Bot1FCTFSeekGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Bot1FCTFSeekGoals
CALLV
pop
line 1303
;1303:		} else if (gametype == GT_OBELISK) {
ADDRGP4 $502
JUMPV
LABELV $501
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $503
line 1304
;1304:			BotObeliskSeekGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotObeliskSeekGoals
CALLV
pop
line 1305
;1305:		} else if (gametype == GT_HARVESTER) {
ADDRGP4 $504
JUMPV
LABELV $503
ADDRGP4 gametype
INDIRI4
CNSTI4 8
NEI4 $505
line 1306
;1306:			BotHarvesterSeekGoals(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotHarvesterSeekGoals
CALLV
pop
line 1307
;1307:		}
LABELV $505
LABELV $504
LABELV $502
LABELV $500
line 1308
;1308:	}
LABELV $490
line 1311
;1309:	// reset the order time which is used to see if
;1310:	// we decided to refuse an order
;1311:	bs->order_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6616
ADDP4
CNSTF4 0
ASGNF4
line 1312
;1312:}
LABELV $488
endproc BotTeamGoals 0 4
export BotPointAreaNum
proc BotPointAreaNum 68 20
line 1319
;1313:
;1314:/*
;1315:==================
;1316:BotPointAreaNum
;1317:==================
;1318:*/
;1319:int BotPointAreaNum(vec3_t origin) {
line 1323
;1320:	int areanum, numareas, areas[10];
;1321:	vec3_t end;
;1322:
;1323:	areanum = trap_AAS_PointAreaNum(origin);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 trap_AAS_PointAreaNum
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 60
INDIRI4
ASGNI4
line 1324
;1324:	if (areanum) return areanum;
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $508
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $507
JUMPV
LABELV $508
line 1325
;1325:	VectorCopy(origin, end);
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 1326
;1326:	end[2] += 10;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
line 1327
;1327:	numareas = trap_AAS_TraceAreas(origin, end, areas, NULL, 10);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 20
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 64
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 64
INDIRI4
ASGNI4
line 1328
;1328:	if (numareas > 0) return areas[0];
ADDRLP4 16
INDIRI4
CNSTI4 0
LEI4 $511
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $507
JUMPV
LABELV $511
line 1329
;1329:	return 0;
CNSTI4 0
RETI4
LABELV $507
endproc BotPointAreaNum 68 20
export ClientName
proc ClientName 1028 12
line 1338
;1330:}
;1331:
;1332:
;1333:/*
;1334:==================
;1335:ClientName
;1336:==================
;1337:*/
;1338:char *ClientName( int client, char *name, int size ) {
line 1341
;1339:	char buf[ MAX_INFO_STRING ];
;1340:
;1341:	if ( (unsigned) client >= MAX_CLIENTS ) {
ADDRFP4 0
INDIRI4
CVIU4 4
CNSTU4 64
LTU4 $514
line 1342
;1342:		BotAI_Print( PRT_ERROR, "ClientName: client out of range\n" );
CNSTI4 3
ARGI4
ADDRGP4 $516
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1343
;1343:		Q_strncpyz( name, "[client out of range]", size );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $517
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1344
;1344:		return name;
ADDRFP4 4
INDIRP4
RETP4
ADDRGP4 $513
JUMPV
LABELV $514
line 1347
;1345:	}
;1346:
;1347:	trap_GetConfigstring( CS_PLAYERS + client, buf, sizeof( buf ) );
ADDRFP4 0
INDIRI4
CNSTI4 529
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1348
;1348:	Q_strncpyz( name, Info_ValueForKey( buf, "n" ), size );
ADDRLP4 0
ARGP4
ADDRGP4 $518
ARGP4
ADDRLP4 1024
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1349
;1349:	Q_CleanStr( name );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1351
;1350:
;1351:	return name;
ADDRFP4 4
INDIRP4
RETP4
LABELV $513
endproc ClientName 1028 12
export ClientSkin
proc ClientSkin 1028 12
line 1360
;1352:}
;1353:
;1354:
;1355:/*
;1356:==================
;1357:ClientSkin
;1358:==================
;1359:*/
;1360:char *ClientSkin( int client, char *skin, int size ) {
line 1363
;1361:	char buf[ MAX_INFO_STRING ];
;1362:
;1363:	if ( (unsigned) client >= MAX_CLIENTS ) {
ADDRFP4 0
INDIRI4
CVIU4 4
CNSTU4 64
LTU4 $520
line 1364
;1364:		BotAI_Print(PRT_ERROR, "ClientSkin: client out of range\n");
CNSTI4 3
ARGI4
ADDRGP4 $522
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 1365
;1365:		return "[client out of range]";
ADDRGP4 $517
RETP4
ADDRGP4 $519
JUMPV
LABELV $520
line 1368
;1366:	}
;1367:
;1368:	trap_GetConfigstring( CS_PLAYERS + client, buf, sizeof( buf ) );
ADDRFP4 0
INDIRI4
CNSTI4 529
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1369
;1369:	Q_strncpyz( skin, Info_ValueForKey( buf, "model" ), size );
ADDRLP4 0
ARGP4
ADDRGP4 $523
ARGP4
ADDRLP4 1024
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1371
;1370:
;1371:	return skin;
ADDRFP4 4
INDIRP4
RETP4
LABELV $519
endproc ClientSkin 1028 12
export ClientFromName
proc ClientFromName 1036 12
line 1380
;1372:}
;1373:
;1374:
;1375:/*
;1376:==================
;1377:ClientFromName
;1378:==================
;1379:*/
;1380:int ClientFromName( const char *name ) {
line 1384
;1381:	int i;
;1382:	char buf[ MAX_INFO_STRING ];
;1383:
;1384:	for ( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 1024
CNSTI4 0
ASGNI4
ADDRGP4 $528
JUMPV
LABELV $525
line 1385
;1385:		trap_GetConfigstring( CS_PLAYERS + i, buf, sizeof( buf ) );
ADDRLP4 1024
INDIRI4
CNSTI4 529
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 1386
;1386:		Q_CleanStr( buf );
ADDRLP4 0
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1387
;1387:		if ( !Q_stricmp( Info_ValueForKey( buf, "n" ), name ) )
ADDRLP4 0
ARGP4
ADDRGP4 $518
ARGP4
ADDRLP4 1028
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $530
line 1388
;1388:			return i;
ADDRLP4 1024
INDIRI4
RETI4
ADDRGP4 $524
JUMPV
LABELV $530
line 1389
;1389:	}
LABELV $526
line 1384
ADDRLP4 1024
ADDRLP4 1024
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $528
ADDRLP4 1024
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $525
line 1390
;1390:	return -1;
CNSTI4 -1
RETI4
LABELV $524
endproc ClientFromName 1036 12
export ClientOnSameTeamFromName
proc ClientOnSameTeamFromName 1040 12
line 1399
;1391:}
;1392:
;1393:
;1394:/*
;1395:==================
;1396:ClientOnSameTeamFromName
;1397:==================
;1398:*/
;1399:int ClientOnSameTeamFromName( bot_state_t *bs, const char *name ) {
line 1403
;1400:	char buf[MAX_INFO_STRING];
;1401:	int i;
;1402:
;1403:	for ( i = 0; i < level.maxclients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $536
JUMPV
LABELV $533
line 1404
;1404:		if ( !BotSameTeam( bs, i ) )
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1028
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
NEI4 $538
line 1405
;1405:			continue;
ADDRGP4 $534
JUMPV
LABELV $538
line 1406
;1406:		trap_GetConfigstring( CS_PLAYERS + i, buf, sizeof( buf ) );
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
line 1407
;1407:		Q_CleanStr( buf );
ADDRLP4 4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 1408
;1408:		if ( !Q_stricmp( Info_ValueForKey( buf, "n" ), name ) )
ADDRLP4 4
ARGP4
ADDRGP4 $518
ARGP4
ADDRLP4 1032
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $540
line 1409
;1409:			return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $532
JUMPV
LABELV $540
line 1410
;1410:	}
LABELV $534
line 1403
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $536
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $533
line 1412
;1411:
;1412:	return -1;
CNSTI4 -1
RETI4
LABELV $532
endproc ClientOnSameTeamFromName 1040 12
export stristr
proc stristr 12 4
line 1421
;1413:}
;1414:
;1415:
;1416:/*
;1417:==================
;1418:stristr
;1419:==================
;1420:*/
;1421:const char *stristr(const char *str, const char *charset) {
ADDRGP4 $544
JUMPV
LABELV $543
line 1424
;1422:	int i;
;1423:
;1424:	while(*str) {
line 1425
;1425:		for (i = 0; charset[i] && str[i]; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $549
JUMPV
LABELV $546
line 1426
;1426:			if (toupper(charset[i]) != toupper(str[i])) break;
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
EQI4 $550
ADDRGP4 $548
JUMPV
LABELV $550
line 1427
;1427:		}
LABELV $547
line 1425
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $549
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $552
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $546
LABELV $552
LABELV $548
line 1428
;1428:		if (!charset[i]) return str;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $553
ADDRFP4 0
INDIRP4
RETP4
ADDRGP4 $542
JUMPV
LABELV $553
line 1429
;1429:		str++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1430
;1430:	}
LABELV $544
line 1424
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $543
line 1431
;1431:	return NULL;
CNSTP4 0
RETP4
LABELV $542
endproc stristr 12 4
export EasyClientName
proc EasyClientName 192 12
line 1440
;1432:}
;1433:
;1434:
;1435:/*
;1436:==================
;1437:EasyClientName
;1438:==================
;1439:*/
;1440:char *EasyClientName(int client, char *buf, int size) {
line 1445
;1441:	int i;
;1442:	char *str1, *str2, *ptr, c;
;1443:	char name[128];
;1444:
;1445:	ClientName( client, name, sizeof( name ) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 5
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1446
;1446:	for (i = 0; name[i]; i++) name[i] &= 127;
ADDRLP4 136
CNSTI4 0
ASGNI4
ADDRGP4 $559
JUMPV
LABELV $556
ADDRLP4 148
ADDRLP4 136
INDIRI4
ADDRLP4 5
ADDP4
ASGNP4
ADDRLP4 148
INDIRP4
ADDRLP4 148
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
CVII1 4
ASGNI1
LABELV $557
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $559
ADDRLP4 136
INDIRI4
ADDRLP4 5
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $556
line 1448
;1447:	//remove all spaces
;1448:	for (ptr = strchr(name, ' '); ptr; ptr = strchr(name, ' ')) {
ADDRLP4 5
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 152
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 152
INDIRP4
ASGNP4
ADDRGP4 $563
JUMPV
LABELV $560
line 1449
;1449:		memmove(ptr, ptr+1, strlen(ptr+1)+1);
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 156
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 156
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1450
;1450:	}
LABELV $561
line 1448
ADDRLP4 5
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 156
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 156
INDIRP4
ASGNP4
LABELV $563
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $560
line 1452
;1451:	//check for [x] and ]x[ clan names
;1452:	str1 = strchr(name, '[');
ADDRLP4 5
ARGP4
CNSTI4 91
ARGI4
ADDRLP4 160
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 140
ADDRLP4 160
INDIRP4
ASGNP4
line 1453
;1453:	str2 = strchr(name, ']');
ADDRLP4 5
ARGP4
CNSTI4 93
ARGI4
ADDRLP4 164
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 144
ADDRLP4 164
INDIRP4
ASGNP4
line 1454
;1454:	if (str1 && str2) {
ADDRLP4 140
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $564
ADDRLP4 144
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $564
line 1455
;1455:		if (str2 > str1) memmove(str1, str2+1, strlen(str2+1)+1);
ADDRLP4 144
INDIRP4
CVPU4 4
ADDRLP4 140
INDIRP4
CVPU4 4
LEU4 $566
ADDRLP4 144
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 168
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 140
INDIRP4
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 168
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
ADDRGP4 $567
JUMPV
LABELV $566
line 1456
;1456:		else memmove(str2, str1+1, strlen(str1+1)+1);
ADDRLP4 140
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 172
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 144
INDIRP4
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 172
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
LABELV $567
line 1457
;1457:	}
LABELV $564
line 1459
;1458:	//remove Mr prefix
;1459:	if ((name[0] == 'm' || name[0] == 'M') &&
ADDRLP4 168
ADDRLP4 5
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 109
EQI4 $572
ADDRLP4 168
INDIRI4
CNSTI4 77
NEI4 $568
LABELV $572
ADDRLP4 5+1
INDIRI1
CVII4 1
CNSTI4 114
EQI4 $573
ADDRLP4 5+1
INDIRI1
CVII4 1
CNSTI4 82
NEI4 $568
LABELV $573
line 1460
;1460:			(name[1] == 'r' || name[1] == 'R')) {
line 1461
;1461:		memmove(name, name+2, strlen(name+2)+1);
ADDRLP4 5+2
ARGP4
ADDRLP4 172
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 5
ARGP4
ADDRLP4 5+2
ARGP4
ADDRLP4 172
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1462
;1462:	}
LABELV $568
line 1464
;1463:	//only allow lower case alphabet characters
;1464:	ptr = name;
ADDRLP4 0
ADDRLP4 5
ASGNP4
ADDRGP4 $577
JUMPV
LABELV $576
line 1465
;1465:	while(*ptr) {
line 1466
;1466:		c = *ptr;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
ASGNI1
line 1467
;1467:		if ((c >= 'a' && c <= 'z') ||
ADDRLP4 172
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 97
LTI4 $582
ADDRLP4 172
INDIRI4
CNSTI4 122
LEI4 $583
LABELV $582
ADDRLP4 176
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 48
LTI4 $584
ADDRLP4 176
INDIRI4
CNSTI4 57
LEI4 $583
LABELV $584
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 95
NEI4 $579
LABELV $583
line 1468
;1468:				(c >= '0' && c <= '9') || c == '_') {
line 1469
;1469:			ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1470
;1470:		}
ADDRGP4 $580
JUMPV
LABELV $579
line 1471
;1471:		else if (c >= 'A' && c <= 'Z') {
ADDRLP4 180
ADDRLP4 4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 180
INDIRI4
CNSTI4 65
LTI4 $585
ADDRLP4 180
INDIRI4
CNSTI4 90
GTI4 $585
line 1472
;1472:			*ptr += 'a' - 'A';
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
ADDI4
CVII1 4
ASGNI1
line 1473
;1473:			ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1474
;1474:		}
ADDRGP4 $586
JUMPV
LABELV $585
line 1475
;1475:		else {
line 1476
;1476:			memmove(ptr, ptr+1, strlen(ptr + 1)+1);
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 184
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
ADDRLP4 184
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1477
;1477:		}
LABELV $586
LABELV $580
line 1478
;1478:	}
LABELV $577
line 1465
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $576
line 1480
;1479:	
;1480:	Q_strncpyz( buf, name, size );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 5
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1482
;1481:
;1482:	return buf;
ADDRFP4 4
INDIRP4
RETP4
LABELV $555
endproc EasyClientName 192 12
export BotSynonymContext
proc BotSynonymContext 12 4
line 1490
;1483:}
;1484:
;1485:/*
;1486:==================
;1487:BotSynonymContext
;1488:==================
;1489:*/
;1490:int BotSynonymContext(bot_state_t *bs) {
line 1493
;1491:	int context;
;1492:
;1493:	context = CONTEXT_NORMAL|CONTEXT_NEARBYITEM|CONTEXT_NAMES;
ADDRLP4 0
CNSTI4 1027
ASGNI4
line 1495
;1494:	//
;1495:	if (gametype == GT_CTF || gametype == GT_1FCTF) {
ADDRLP4 4
ADDRGP4 gametype
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 5
EQI4 $590
ADDRLP4 4
INDIRI4
CNSTI4 6
NEI4 $588
LABELV $590
line 1496
;1496:		if (BotTeam(bs) == TEAM_RED) context |= CONTEXT_CTFREDTEAM;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
NEI4 $591
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 4
BORI4
ASGNI4
ADDRGP4 $589
JUMPV
LABELV $591
line 1497
;1497:		else context |= CONTEXT_CTFBLUETEAM;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1498
;1498:	} else if (gametype == GT_OBELISK) {
ADDRGP4 $589
JUMPV
LABELV $588
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $593
line 1499
;1499:		if (BotTeam(bs) == TEAM_RED) context |= CONTEXT_OBELISKREDTEAM;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
NEI4 $595
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 32
BORI4
ASGNI4
ADDRGP4 $594
JUMPV
LABELV $595
line 1500
;1500:		else context |= CONTEXT_OBELISKBLUETEAM;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 1501
;1501:	} else if (gametype == GT_HARVESTER) {
ADDRGP4 $594
JUMPV
LABELV $593
ADDRGP4 gametype
INDIRI4
CNSTI4 8
NEI4 $597
line 1502
;1502:		if (BotTeam(bs) == TEAM_RED) context |= CONTEXT_HARVESTERREDTEAM;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
NEI4 $599
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 128
BORI4
ASGNI4
ADDRGP4 $600
JUMPV
LABELV $599
line 1503
;1503:		else context |= CONTEXT_HARVESTERBLUETEAM;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
BORI4
ASGNI4
LABELV $600
line 1504
;1504:	}
LABELV $597
LABELV $594
LABELV $589
line 1505
;1505:	return context;
ADDRLP4 0
INDIRI4
RETI4
LABELV $587
endproc BotSynonymContext 12 4
export BotChooseWeapon
proc BotChooseWeapon 20 8
line 1513
;1506:}
;1507:
;1508:/*
;1509:==================
;1510:BotChooseWeapon
;1511:==================
;1512:*/
;1513:void BotChooseWeapon(bot_state_t *bs) {
line 1516
;1514:	int newweaponnum;
;1515:
;1516:	if (bs->cur_ps.weaponstate == WEAPON_RAISING ||
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 1
EQI4 $604
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 2
NEI4 $602
LABELV $604
line 1517
;1517:			bs->cur_ps.weaponstate == WEAPON_DROPPING) {
line 1518
;1518:		trap_EA_SelectWeapon(bs->client, bs->weaponnum);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_SelectWeapon
CALLV
pop
line 1519
;1519:	}
ADDRGP4 $603
JUMPV
LABELV $602
line 1520
;1520:	else {
line 1521
;1521:		newweaponnum = trap_BotChooseBestFightWeapon(bs->ws, bs->inventory);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
CNSTI4 4952
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 trap_BotChooseBestFightWeapon
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 1522
;1522:		if (bs->weaponnum != newweaponnum) bs->weaponchange_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $605
ADDRFP4 0
INDIRP4
CNSTI4 6192
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
LABELV $605
line 1523
;1523:		bs->weaponnum = newweaponnum;
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1525
;1524:		//BotAI_Print(PRT_MESSAGE, "bs->weaponnum = %d\n", bs->weaponnum);
;1525:		trap_EA_SelectWeapon(bs->client, bs->weaponnum);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_SelectWeapon
CALLV
pop
line 1526
;1526:	}
LABELV $603
line 1527
;1527:}
LABELV $601
endproc BotChooseWeapon 20 8
export BotSetupForMovement
proc BotSetupForMovement 76 12
line 1534
;1528:
;1529:/*
;1530:==================
;1531:BotSetupForMovement
;1532:==================
;1533:*/
;1534:void BotSetupForMovement(bot_state_t *bs) {
line 1537
;1535:	bot_initmove_t initmove;
;1536:
;1537:	memset(&initmove, 0, sizeof(bot_initmove_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 68
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1538
;1538:	VectorCopy(bs->cur_ps.origin, initmove.origin);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 1539
;1539:	VectorCopy(bs->cur_ps.velocity, initmove.velocity);
ADDRLP4 0+12
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRB
ASGNB 12
line 1540
;1540:	VectorClear(initmove.viewoffset);
ADDRLP4 0+24
CNSTF4 0
ASGNF4
ADDRLP4 0+24+4
CNSTF4 0
ASGNF4
ADDRLP4 0+24+8
CNSTF4 0
ASGNF4
line 1541
;1541:	initmove.viewoffset[2] += bs->cur_ps.viewheight;
ADDRLP4 0+24+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1542
;1542:	initmove.entitynum = bs->entitynum;
ADDRLP4 0+36
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1543
;1543:	initmove.client = bs->client;
ADDRLP4 0+40
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1544
;1544:	initmove.thinktime = bs->thinktime;
ADDRLP4 0+44
ADDRFP4 0
INDIRP4
CNSTI4 4904
ADDP4
INDIRF4
ASGNF4
line 1546
;1545:	//set the onground flag
;1546:	if (bs->cur_ps.groundEntityNum != ENTITYNUM_NONE) initmove.or_moveflags |= MFL_ONGROUND;
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $619
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 2
BORI4
ASGNI4
LABELV $619
line 1548
;1547:	//set the teleported flag
;1548:	if ((bs->cur_ps.pm_flags & PMF_TIME_KNOCKBACK) && (bs->cur_ps.pm_time > 0)) {
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $622
ADDRLP4 68
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
LEI4 $622
line 1549
;1549:		initmove.or_moveflags |= MFL_TELEPORTED;
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 1550
;1550:	}
LABELV $622
line 1552
;1551:	//set the waterjump flag
;1552:	if ((bs->cur_ps.pm_flags & PMF_TIME_WATERJUMP) && (bs->cur_ps.pm_time > 0)) {
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $625
ADDRLP4 72
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
LEI4 $625
line 1553
;1553:		initmove.or_moveflags |= MFL_WATERJUMP;
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 1554
;1554:	}
LABELV $625
line 1556
;1555:	//set presence type
;1556:	if (bs->cur_ps.pm_flags & PMF_DUCKED) initmove.presencetype = PRESENCE_CROUCH;
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $628
ADDRLP4 0+48
CNSTI4 4
ASGNI4
ADDRGP4 $629
JUMPV
LABELV $628
line 1557
;1557:	else initmove.presencetype = PRESENCE_NORMAL;
ADDRLP4 0+48
CNSTI4 2
ASGNI4
LABELV $629
line 1559
;1558:	//
;1559:	if (bs->walker > 0.5) initmove.or_moveflags |= MFL_WALK;
ADDRFP4 0
INDIRP4
CNSTI4 6056
ADDP4
INDIRF4
CNSTF4 1056964608
LEF4 $632
ADDRLP4 0+64
ADDRLP4 0+64
INDIRI4
CNSTI4 512
BORI4
ASGNI4
LABELV $632
line 1561
;1560:	//
;1561:	VectorCopy(bs->viewangles, initmove.viewangles);
ADDRLP4 0+52
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
INDIRB
ASGNB 12
line 1563
;1562:	//
;1563:	trap_BotInitMoveState(bs->ms, &initmove);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotInitMoveState
CALLV
pop
line 1564
;1564:}
LABELV $607
endproc BotSetupForMovement 76 12
export BotCheckItemPickup
proc BotCheckItemPickup 28 4
line 1571
;1565:
;1566:/*
;1567:==================
;1568:BotCheckItemPickup
;1569:==================
;1570:*/
;1571:void BotCheckItemPickup(bot_state_t *bs, int *oldinventory) {
line 1574
;1572:	int offence, leader;
;1573:
;1574:	if (gametype <= GT_TEAM)
ADDRGP4 gametype
INDIRI4
CNSTI4 3
GTI4 $637
line 1575
;1575:		return;
ADDRGP4 $636
JUMPV
LABELV $637
line 1577
;1576:
;1577:	offence = -1;
ADDRLP4 0
CNSTI4 -1
ASGNI4
line 1579
;1578:	// go into offence if picked up the kamikaze or invulnerability
;1579:	if (!oldinventory[INVENTORY_KAMIKAZE] && bs->inventory[INVENTORY_KAMIKAZE] >= 1) {
ADDRFP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 0
NEI4 $639
ADDRFP4 0
INDIRP4
CNSTI4 5092
ADDP4
INDIRI4
CNSTI4 1
LTI4 $639
line 1580
;1580:		offence = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1581
;1581:	}
LABELV $639
line 1582
;1582:	if (!oldinventory[INVENTORY_INVULNERABILITY] && bs->inventory[INVENTORY_INVULNERABILITY] >= 1) {
ADDRFP4 4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 0
NEI4 $641
ADDRFP4 0
INDIRP4
CNSTI4 5100
ADDP4
INDIRI4
CNSTI4 1
LTI4 $641
line 1583
;1583:		offence = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1584
;1584:	}
LABELV $641
line 1586
;1585:	// if not already wearing the kamikaze or invulnerability
;1586:	if (!bs->inventory[INVENTORY_KAMIKAZE] && !bs->inventory[INVENTORY_INVULNERABILITY]) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 5092
ADDP4
INDIRI4
CNSTI4 0
NEI4 $643
ADDRLP4 8
INDIRP4
CNSTI4 5100
ADDP4
INDIRI4
CNSTI4 0
NEI4 $643
line 1587
;1587:		if (!oldinventory[INVENTORY_SCOUT] && bs->inventory[INVENTORY_SCOUT] >= 1) {
ADDRFP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 0
NEI4 $645
ADDRFP4 0
INDIRP4
CNSTI4 5140
ADDP4
INDIRI4
CNSTI4 1
LTI4 $645
line 1588
;1588:			offence = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1589
;1589:		}
LABELV $645
line 1590
;1590:		if (!oldinventory[INVENTORY_GUARD] && bs->inventory[INVENTORY_GUARD] >= 1) {
ADDRFP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 0
NEI4 $647
ADDRFP4 0
INDIRP4
CNSTI4 5144
ADDP4
INDIRI4
CNSTI4 1
LTI4 $647
line 1591
;1591:			offence = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1592
;1592:		}
LABELV $647
line 1593
;1593:		if (!oldinventory[INVENTORY_DAMAGE] && bs->inventory[INVENTORY_DAMAGE] >= 1) {
ADDRFP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
NEI4 $649
ADDRFP4 0
INDIRP4
CNSTI4 5148
ADDP4
INDIRI4
CNSTI4 1
LTI4 $649
line 1594
;1594:			offence = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1595
;1595:		}
LABELV $649
line 1596
;1596:		if (!oldinventory[INVENTORY_ARMORREGEN] && bs->inventory[INVENTORY_ARMORREGEN] >= 1) {
ADDRFP4 4
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 0
NEI4 $651
ADDRFP4 0
INDIRP4
CNSTI4 5152
ADDP4
INDIRI4
CNSTI4 1
LTI4 $651
line 1597
;1597:			offence = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1598
;1598:		}
LABELV $651
line 1599
;1599:	}
LABELV $643
line 1601
;1600:
;1601:	if (offence >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $653
line 1602
;1602:		leader = ClientFromName(bs->teamleader);
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 1603
;1603:		if (offence) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $655
line 1604
;1604:			if (!(bs->teamtaskpreference & TEAMTP_ATTACKER)) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $657
line 1606
;1605:				// if we have a bot team leader
;1606:				if (BotTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 BotTeamLeader
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $659
line 1610
;1607:					// tell the leader we want to be on offence
;1608:					//BotAI_BotInitialChat(bs, "wantoffence", NULL);
;1609:					//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1610:				}
ADDRGP4 $660
JUMPV
LABELV $659
line 1611
;1611:				else if (g_spSkill.integer <= 3) {
ADDRGP4 g_spSkill+12
INDIRI4
CNSTI4 3
GTI4 $661
line 1612
;1612:					if ( bs->ltgtype != LTG_GETFLAG &&
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
EQI4 $664
ADDRLP4 20
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 13
EQI4 $664
ADDRLP4 20
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 12
EQI4 $664
line 1614
;1613:						 bs->ltgtype != LTG_ATTACKENEMYBASE &&
;1614:						 bs->ltgtype != LTG_HARVEST ) {
line 1616
;1615:						//
;1616:						if ((gametype != GT_CTF || (bs->redflagstatus == 0 && bs->blueflagstatus == 0)) &&
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $668
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
CNSTI4 0
NEI4 $666
ADDRLP4 24
INDIRP4
CNSTI4 6960
ADDP4
INDIRI4
CNSTI4 0
NEI4 $666
LABELV $668
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $669
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
INDIRI4
CNSTI4 0
NEI4 $666
LABELV $669
line 1617
;1617:							(gametype != GT_1FCTF || bs->neutralflagstatus == 0) ) {
line 1621
;1618:							// tell the leader we want to be on offence
;1619:							//BotAI_BotInitialChat(bs, "wantoffence", NULL);
;1620:							//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1621:						}
LABELV $666
line 1622
;1622:					}
LABELV $664
line 1623
;1623:				}
LABELV $661
LABELV $660
line 1624
;1624:				bs->teamtaskpreference |= TEAMTP_ATTACKER;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1625
;1625:			}
LABELV $657
line 1626
;1626:			bs->teamtaskpreference &= ~TEAMTP_DEFENDER;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 1627
;1627:		}
ADDRGP4 $656
JUMPV
LABELV $655
line 1628
;1628:		else {
line 1629
;1629:			if (!(bs->teamtaskpreference & TEAMTP_DEFENDER)) {
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $670
line 1631
;1630:				// if we have a bot team leader
;1631:				if (BotTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 BotTeamLeader
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $672
line 1635
;1632:					// tell the leader we want to be on defense
;1633:					//BotAI_BotInitialChat(bs, "wantdefence", NULL);
;1634:					//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1635:				}
ADDRGP4 $673
JUMPV
LABELV $672
line 1636
;1636:				else if (g_spSkill.integer <= 3) {
ADDRGP4 g_spSkill+12
INDIRI4
CNSTI4 3
GTI4 $674
line 1637
;1637:					if ( bs->ltgtype != LTG_DEFENDKEYAREA ) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
EQI4 $677
line 1639
;1638:						//
;1639:						if ((gametype != GT_CTF || (bs->redflagstatus == 0 && bs->blueflagstatus == 0)) &&
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $681
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
CNSTI4 0
NEI4 $679
ADDRLP4 20
INDIRP4
CNSTI4 6960
ADDP4
INDIRI4
CNSTI4 0
NEI4 $679
LABELV $681
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $682
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
INDIRI4
CNSTI4 0
NEI4 $679
LABELV $682
line 1640
;1640:							(gametype != GT_1FCTF || bs->neutralflagstatus == 0) ) {
line 1644
;1641:							// tell the leader we want to be on defense
;1642:							//BotAI_BotInitialChat(bs, "wantdefence", NULL);
;1643:							//trap_BotEnterChat(bs->cs, leader, CHAT_TELL);
;1644:						}
LABELV $679
line 1645
;1645:					}
LABELV $677
line 1646
;1646:				}
LABELV $674
LABELV $673
line 1647
;1647:				bs->teamtaskpreference |= TEAMTP_DEFENDER;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1648
;1648:			}
LABELV $670
line 1649
;1649:			bs->teamtaskpreference &= ~TEAMTP_ATTACKER;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 6752
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 1650
;1650:		}
LABELV $656
line 1651
;1651:	}
LABELV $653
line 1652
;1652:}
LABELV $636
endproc BotCheckItemPickup 28 4
export BotUpdateInventory
proc BotUpdateInventory 1340 12
line 1659
;1653:
;1654:/*
;1655:==================
;1656:BotUpdateInventory
;1657:==================
;1658:*/
;1659:void BotUpdateInventory(bot_state_t *bs) {
line 1662
;1660:	int oldinventory[MAX_ITEMS];
;1661:
;1662:	memcpy(oldinventory, bs->inventory, sizeof(oldinventory));
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4952
ADDP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1664
;1663:	//armor
;1664:	bs->inventory[INVENTORY_ARMOR] = bs->cur_ps.stats[STAT_ARMOR];
ADDRLP4 1024
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1024
INDIRP4
CNSTI4 4956
ADDP4
ADDRLP4 1024
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
ASGNI4
line 1666
;1665:	//weapons
;1666:	bs->inventory[INVENTORY_GAUNTLET] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GAUNTLET)) != 0;
ADDRLP4 1032
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1032
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $685
ADDRLP4 1028
CNSTI4 1
ASGNI4
ADDRGP4 $686
JUMPV
LABELV $685
ADDRLP4 1028
CNSTI4 0
ASGNI4
LABELV $686
ADDRLP4 1032
INDIRP4
CNSTI4 4968
ADDP4
ADDRLP4 1028
INDIRI4
ASGNI4
line 1667
;1667:	bs->inventory[INVENTORY_SHOTGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_SHOTGUN)) != 0;
ADDRLP4 1040
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1040
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $688
ADDRLP4 1036
CNSTI4 1
ASGNI4
ADDRGP4 $689
JUMPV
LABELV $688
ADDRLP4 1036
CNSTI4 0
ASGNI4
LABELV $689
ADDRLP4 1040
INDIRP4
CNSTI4 4972
ADDP4
ADDRLP4 1036
INDIRI4
ASGNI4
line 1668
;1668:	bs->inventory[INVENTORY_MACHINEGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_MACHINEGUN)) != 0;
ADDRLP4 1048
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $691
ADDRLP4 1044
CNSTI4 1
ASGNI4
ADDRGP4 $692
JUMPV
LABELV $691
ADDRLP4 1044
CNSTI4 0
ASGNI4
LABELV $692
ADDRLP4 1048
INDIRP4
CNSTI4 4976
ADDP4
ADDRLP4 1044
INDIRI4
ASGNI4
line 1669
;1669:	bs->inventory[INVENTORY_GRENADELAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GRENADE_LAUNCHER)) != 0;
ADDRLP4 1056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $694
ADDRLP4 1052
CNSTI4 1
ASGNI4
ADDRGP4 $695
JUMPV
LABELV $694
ADDRLP4 1052
CNSTI4 0
ASGNI4
LABELV $695
ADDRLP4 1056
INDIRP4
CNSTI4 4980
ADDP4
ADDRLP4 1052
INDIRI4
ASGNI4
line 1670
;1670:	bs->inventory[INVENTORY_ROCKETLAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_ROCKET_LAUNCHER)) != 0;
ADDRLP4 1064
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1064
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $697
ADDRLP4 1060
CNSTI4 1
ASGNI4
ADDRGP4 $698
JUMPV
LABELV $697
ADDRLP4 1060
CNSTI4 0
ASGNI4
LABELV $698
ADDRLP4 1064
INDIRP4
CNSTI4 4984
ADDP4
ADDRLP4 1060
INDIRI4
ASGNI4
line 1671
;1671:	bs->inventory[INVENTORY_LIGHTNING] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_LIGHTNING)) != 0;
ADDRLP4 1072
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1072
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $700
ADDRLP4 1068
CNSTI4 1
ASGNI4
ADDRGP4 $701
JUMPV
LABELV $700
ADDRLP4 1068
CNSTI4 0
ASGNI4
LABELV $701
ADDRLP4 1072
INDIRP4
CNSTI4 4988
ADDP4
ADDRLP4 1068
INDIRI4
ASGNI4
line 1672
;1672:	bs->inventory[INVENTORY_RAILGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_RAILGUN)) != 0;
ADDRLP4 1080
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1080
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $703
ADDRLP4 1076
CNSTI4 1
ASGNI4
ADDRGP4 $704
JUMPV
LABELV $703
ADDRLP4 1076
CNSTI4 0
ASGNI4
LABELV $704
ADDRLP4 1080
INDIRP4
CNSTI4 4992
ADDP4
ADDRLP4 1076
INDIRI4
ASGNI4
line 1673
;1673:	bs->inventory[INVENTORY_PLASMAGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_PLASMAGUN)) != 0;
ADDRLP4 1088
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1088
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $706
ADDRLP4 1084
CNSTI4 1
ASGNI4
ADDRGP4 $707
JUMPV
LABELV $706
ADDRLP4 1084
CNSTI4 0
ASGNI4
LABELV $707
ADDRLP4 1088
INDIRP4
CNSTI4 4996
ADDP4
ADDRLP4 1084
INDIRI4
ASGNI4
line 1674
;1674:	bs->inventory[INVENTORY_BFG10K] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_BFG)) != 0;
ADDRLP4 1096
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1096
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $709
ADDRLP4 1092
CNSTI4 1
ASGNI4
ADDRGP4 $710
JUMPV
LABELV $709
ADDRLP4 1092
CNSTI4 0
ASGNI4
LABELV $710
ADDRLP4 1096
INDIRP4
CNSTI4 5004
ADDP4
ADDRLP4 1092
INDIRI4
ASGNI4
line 1675
;1675:	bs->inventory[INVENTORY_GRAPPLINGHOOK] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_GRAPPLING_HOOK)) != 0;
ADDRLP4 1104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1104
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $712
ADDRLP4 1100
CNSTI4 1
ASGNI4
ADDRGP4 $713
JUMPV
LABELV $712
ADDRLP4 1100
CNSTI4 0
ASGNI4
LABELV $713
ADDRLP4 1104
INDIRP4
CNSTI4 5008
ADDP4
ADDRLP4 1100
INDIRI4
ASGNI4
line 1676
;1676:	bs->inventory[INVENTORY_NAILGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_NAILGUN)) != 0;
ADDRLP4 1112
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1112
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $715
ADDRLP4 1108
CNSTI4 1
ASGNI4
ADDRGP4 $716
JUMPV
LABELV $715
ADDRLP4 1108
CNSTI4 0
ASGNI4
LABELV $716
ADDRLP4 1112
INDIRP4
CNSTI4 5012
ADDP4
ADDRLP4 1108
INDIRI4
ASGNI4
line 1677
;1677:	bs->inventory[INVENTORY_PROXLAUNCHER] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_PROX_LAUNCHER)) != 0;
ADDRLP4 1120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1120
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $718
ADDRLP4 1116
CNSTI4 1
ASGNI4
ADDRGP4 $719
JUMPV
LABELV $718
ADDRLP4 1116
CNSTI4 0
ASGNI4
LABELV $719
ADDRLP4 1120
INDIRP4
CNSTI4 5016
ADDP4
ADDRLP4 1116
INDIRI4
ASGNI4
line 1678
;1678:	bs->inventory[INVENTORY_CHAINGUN] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_CHAINGUN)) != 0;
ADDRLP4 1128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1128
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $721
ADDRLP4 1124
CNSTI4 1
ASGNI4
ADDRGP4 $722
JUMPV
LABELV $721
ADDRLP4 1124
CNSTI4 0
ASGNI4
LABELV $722
ADDRLP4 1128
INDIRP4
CNSTI4 5020
ADDP4
ADDRLP4 1124
INDIRI4
ASGNI4
line 1679
;1679:	bs->inventory[INVENTORY_HMG] = (bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_HMG)) != 0;
ADDRLP4 1136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1136
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $724
ADDRLP4 1132
CNSTI4 1
ASGNI4
ADDRGP4 $725
JUMPV
LABELV $724
ADDRLP4 1132
CNSTI4 0
ASGNI4
LABELV $725
ADDRLP4 1136
INDIRP4
CNSTI4 5024
ADDP4
ADDRLP4 1132
INDIRI4
ASGNI4
line 1681
;1680:	//ammo
;1681:	bs->inventory[INVENTORY_SHELLS] = bs->cur_ps.ammo[WP_SHOTGUN];
ADDRLP4 1140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1140
INDIRP4
CNSTI4 5028
ADDP4
ADDRLP4 1140
INDIRP4
CNSTI4 404
ADDP4
INDIRI4
ASGNI4
line 1682
;1682:	bs->inventory[INVENTORY_BULLETS] = bs->cur_ps.ammo[WP_MACHINEGUN];
ADDRLP4 1144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1144
INDIRP4
CNSTI4 5032
ADDP4
ADDRLP4 1144
INDIRP4
CNSTI4 400
ADDP4
INDIRI4
ASGNI4
line 1683
;1683:	bs->inventory[INVENTORY_GRENADES] = bs->cur_ps.ammo[WP_GRENADE_LAUNCHER];
ADDRLP4 1148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1148
INDIRP4
CNSTI4 5036
ADDP4
ADDRLP4 1148
INDIRP4
CNSTI4 408
ADDP4
INDIRI4
ASGNI4
line 1684
;1684:	bs->inventory[INVENTORY_CELLS] = bs->cur_ps.ammo[WP_PLASMAGUN];
ADDRLP4 1152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1152
INDIRP4
CNSTI4 5040
ADDP4
ADDRLP4 1152
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
ASGNI4
line 1685
;1685:	bs->inventory[INVENTORY_LIGHTNINGAMMO] = bs->cur_ps.ammo[WP_LIGHTNING];
ADDRLP4 1156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1156
INDIRP4
CNSTI4 5044
ADDP4
ADDRLP4 1156
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
ASGNI4
line 1686
;1686:	bs->inventory[INVENTORY_ROCKETS] = bs->cur_ps.ammo[WP_ROCKET_LAUNCHER];
ADDRLP4 1160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1160
INDIRP4
CNSTI4 5048
ADDP4
ADDRLP4 1160
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
ASGNI4
line 1687
;1687:	bs->inventory[INVENTORY_SLUGS] = bs->cur_ps.ammo[WP_RAILGUN];
ADDRLP4 1164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1164
INDIRP4
CNSTI4 5052
ADDP4
ADDRLP4 1164
INDIRP4
CNSTI4 420
ADDP4
INDIRI4
ASGNI4
line 1688
;1688:	bs->inventory[INVENTORY_BFGAMMO] = bs->cur_ps.ammo[WP_BFG];
ADDRLP4 1168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1168
INDIRP4
CNSTI4 5056
ADDP4
ADDRLP4 1168
INDIRP4
CNSTI4 428
ADDP4
INDIRI4
ASGNI4
line 1689
;1689:	bs->inventory[INVENTORY_NAILS] = bs->cur_ps.ammo[WP_NAILGUN];
ADDRLP4 1172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1172
INDIRP4
CNSTI4 5060
ADDP4
ADDRLP4 1172
INDIRP4
CNSTI4 436
ADDP4
INDIRI4
ASGNI4
line 1690
;1690:	bs->inventory[INVENTORY_MINES] = bs->cur_ps.ammo[WP_PROX_LAUNCHER];
ADDRLP4 1176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1176
INDIRP4
CNSTI4 5064
ADDP4
ADDRLP4 1176
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
ASGNI4
line 1691
;1691:	bs->inventory[INVENTORY_BELT] = bs->cur_ps.ammo[WP_CHAINGUN];
ADDRLP4 1180
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1180
INDIRP4
CNSTI4 5068
ADDP4
ADDRLP4 1180
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
ASGNI4
line 1693
;1692:	//powerups
;1693:	bs->inventory[INVENTORY_HEALTH] = bs->cur_ps.stats[STAT_HEALTH];
ADDRLP4 1184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1184
INDIRP4
CNSTI4 5080
ADDP4
ADDRLP4 1184
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ASGNI4
line 1694
;1694:	bs->inventory[INVENTORY_TELEPORTER] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_TELEPORTER;
ADDRLP4 1192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1192
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 26
NEI4 $727
ADDRLP4 1188
CNSTI4 1
ASGNI4
ADDRGP4 $728
JUMPV
LABELV $727
ADDRLP4 1188
CNSTI4 0
ASGNI4
LABELV $728
ADDRLP4 1192
INDIRP4
CNSTI4 5084
ADDP4
ADDRLP4 1188
INDIRI4
ASGNI4
line 1695
;1695:	bs->inventory[INVENTORY_MEDKIT] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_MEDKIT;
ADDRLP4 1200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1200
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 27
NEI4 $730
ADDRLP4 1196
CNSTI4 1
ASGNI4
ADDRGP4 $731
JUMPV
LABELV $730
ADDRLP4 1196
CNSTI4 0
ASGNI4
LABELV $731
ADDRLP4 1200
INDIRP4
CNSTI4 5088
ADDP4
ADDRLP4 1196
INDIRI4
ASGNI4
line 1696
;1696:	bs->inventory[INVENTORY_KAMIKAZE] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_KAMIKAZE;
ADDRLP4 1208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1208
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 36
NEI4 $733
ADDRLP4 1204
CNSTI4 1
ASGNI4
ADDRGP4 $734
JUMPV
LABELV $733
ADDRLP4 1204
CNSTI4 0
ASGNI4
LABELV $734
ADDRLP4 1208
INDIRP4
CNSTI4 5092
ADDP4
ADDRLP4 1204
INDIRI4
ASGNI4
line 1697
;1697:	bs->inventory[INVENTORY_PORTAL] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_PORTAL;
ADDRLP4 1216
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1216
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 37
NEI4 $736
ADDRLP4 1212
CNSTI4 1
ASGNI4
ADDRGP4 $737
JUMPV
LABELV $736
ADDRLP4 1212
CNSTI4 0
ASGNI4
LABELV $737
ADDRLP4 1216
INDIRP4
CNSTI4 5096
ADDP4
ADDRLP4 1212
INDIRI4
ASGNI4
line 1698
;1698:	bs->inventory[INVENTORY_INVULNERABILITY] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM] == MODELINDEX_INVULNERABILITY;
ADDRLP4 1224
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1224
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 38
NEI4 $739
ADDRLP4 1220
CNSTI4 1
ASGNI4
ADDRGP4 $740
JUMPV
LABELV $739
ADDRLP4 1220
CNSTI4 0
ASGNI4
LABELV $740
ADDRLP4 1224
INDIRP4
CNSTI4 5100
ADDP4
ADDRLP4 1220
INDIRI4
ASGNI4
line 1700
;1699:
;1700:	bs->inventory[INVENTORY_QUAD] = bs->cur_ps.powerups[PW_QUAD] != 0;
ADDRLP4 1232
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1232
INDIRP4
CNSTI4 332
ADDP4
INDIRI4
CNSTI4 0
EQI4 $742
ADDRLP4 1228
CNSTI4 1
ASGNI4
ADDRGP4 $743
JUMPV
LABELV $742
ADDRLP4 1228
CNSTI4 0
ASGNI4
LABELV $743
ADDRLP4 1232
INDIRP4
CNSTI4 5120
ADDP4
ADDRLP4 1228
INDIRI4
ASGNI4
line 1701
;1701:	bs->inventory[INVENTORY_ENVIRONMENTSUIT] = bs->cur_ps.powerups[PW_BATTLESUIT] != 0;
ADDRLP4 1240
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1240
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $745
ADDRLP4 1236
CNSTI4 1
ASGNI4
ADDRGP4 $746
JUMPV
LABELV $745
ADDRLP4 1236
CNSTI4 0
ASGNI4
LABELV $746
ADDRLP4 1240
INDIRP4
CNSTI4 5124
ADDP4
ADDRLP4 1236
INDIRI4
ASGNI4
line 1702
;1702:	bs->inventory[INVENTORY_HASTE] = bs->cur_ps.powerups[PW_HASTE] != 0;
ADDRLP4 1248
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1248
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $748
ADDRLP4 1244
CNSTI4 1
ASGNI4
ADDRGP4 $749
JUMPV
LABELV $748
ADDRLP4 1244
CNSTI4 0
ASGNI4
LABELV $749
ADDRLP4 1248
INDIRP4
CNSTI4 5128
ADDP4
ADDRLP4 1244
INDIRI4
ASGNI4
line 1703
;1703:	bs->inventory[INVENTORY_INVISIBILITY] = bs->cur_ps.powerups[PW_INVIS] != 0;
ADDRLP4 1256
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1256
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $751
ADDRLP4 1252
CNSTI4 1
ASGNI4
ADDRGP4 $752
JUMPV
LABELV $751
ADDRLP4 1252
CNSTI4 0
ASGNI4
LABELV $752
ADDRLP4 1256
INDIRP4
CNSTI4 5132
ADDP4
ADDRLP4 1252
INDIRI4
ASGNI4
line 1704
;1704:	bs->inventory[INVENTORY_REGEN] = bs->cur_ps.powerups[PW_REGEN] != 0;
ADDRLP4 1264
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1264
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $754
ADDRLP4 1260
CNSTI4 1
ASGNI4
ADDRGP4 $755
JUMPV
LABELV $754
ADDRLP4 1260
CNSTI4 0
ASGNI4
LABELV $755
ADDRLP4 1264
INDIRP4
CNSTI4 5136
ADDP4
ADDRLP4 1260
INDIRI4
ASGNI4
line 1705
;1705:	bs->inventory[INVENTORY_FLIGHT] = bs->cur_ps.powerups[PW_FLIGHT] != 0;
ADDRLP4 1272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1272
INDIRP4
CNSTI4 352
ADDP4
INDIRI4
CNSTI4 0
EQI4 $757
ADDRLP4 1268
CNSTI4 1
ASGNI4
ADDRGP4 $758
JUMPV
LABELV $757
ADDRLP4 1268
CNSTI4 0
ASGNI4
LABELV $758
ADDRLP4 1272
INDIRP4
CNSTI4 5116
ADDP4
ADDRLP4 1268
INDIRI4
ASGNI4
line 1707
;1706:
;1707:	bs->inventory[INVENTORY_SCOUT] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_SCOUT;
ADDRLP4 1280
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1280
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 42
NEI4 $760
ADDRLP4 1276
CNSTI4 1
ASGNI4
ADDRGP4 $761
JUMPV
LABELV $760
ADDRLP4 1276
CNSTI4 0
ASGNI4
LABELV $761
ADDRLP4 1280
INDIRP4
CNSTI4 5140
ADDP4
ADDRLP4 1276
INDIRI4
ASGNI4
line 1708
;1708:	bs->inventory[INVENTORY_GUARD] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_GUARD;
ADDRLP4 1288
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1288
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 43
NEI4 $763
ADDRLP4 1284
CNSTI4 1
ASGNI4
ADDRGP4 $764
JUMPV
LABELV $763
ADDRLP4 1284
CNSTI4 0
ASGNI4
LABELV $764
ADDRLP4 1288
INDIRP4
CNSTI4 5144
ADDP4
ADDRLP4 1284
INDIRI4
ASGNI4
line 1709
;1709:	bs->inventory[INVENTORY_DAMAGE] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_DAMAGE;
ADDRLP4 1296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1296
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 44
NEI4 $766
ADDRLP4 1292
CNSTI4 1
ASGNI4
ADDRGP4 $767
JUMPV
LABELV $766
ADDRLP4 1292
CNSTI4 0
ASGNI4
LABELV $767
ADDRLP4 1296
INDIRP4
CNSTI4 5148
ADDP4
ADDRLP4 1292
INDIRI4
ASGNI4
line 1710
;1710:	bs->inventory[INVENTORY_ARMORREGEN] = bs->cur_ps.stats[STAT_PERSISTANT_POWERUP] == MODELINDEX_ARMORREGEN;
ADDRLP4 1304
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1304
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 45
NEI4 $769
ADDRLP4 1300
CNSTI4 1
ASGNI4
ADDRGP4 $770
JUMPV
LABELV $769
ADDRLP4 1300
CNSTI4 0
ASGNI4
LABELV $770
ADDRLP4 1304
INDIRP4
CNSTI4 5152
ADDP4
ADDRLP4 1300
INDIRI4
ASGNI4
line 1712
;1711:
;1712:	bs->inventory[INVENTORY_REDFLAG] = bs->cur_ps.powerups[PW_REDFLAG] != 0;
ADDRLP4 1312
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1312
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
EQI4 $772
ADDRLP4 1308
CNSTI4 1
ASGNI4
ADDRGP4 $773
JUMPV
LABELV $772
ADDRLP4 1308
CNSTI4 0
ASGNI4
LABELV $773
ADDRLP4 1312
INDIRP4
CNSTI4 5156
ADDP4
ADDRLP4 1308
INDIRI4
ASGNI4
line 1713
;1713:	bs->inventory[INVENTORY_BLUEFLAG] = bs->cur_ps.powerups[PW_BLUEFLAG] != 0;
ADDRLP4 1320
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1320
INDIRP4
CNSTI4 360
ADDP4
INDIRI4
CNSTI4 0
EQI4 $775
ADDRLP4 1316
CNSTI4 1
ASGNI4
ADDRGP4 $776
JUMPV
LABELV $775
ADDRLP4 1316
CNSTI4 0
ASGNI4
LABELV $776
ADDRLP4 1320
INDIRP4
CNSTI4 5160
ADDP4
ADDRLP4 1316
INDIRI4
ASGNI4
line 1715
;1714:
;1715:	bs->inventory[INVENTORY_NEUTRALFLAG] = bs->cur_ps.powerups[PW_NEUTRALFLAG] != 0;
ADDRLP4 1328
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1328
INDIRP4
CNSTI4 364
ADDP4
INDIRI4
CNSTI4 0
EQI4 $778
ADDRLP4 1324
CNSTI4 1
ASGNI4
ADDRGP4 $779
JUMPV
LABELV $778
ADDRLP4 1324
CNSTI4 0
ASGNI4
LABELV $779
ADDRLP4 1328
INDIRP4
CNSTI4 5164
ADDP4
ADDRLP4 1324
INDIRI4
ASGNI4
line 1716
;1716:	if (BotTeam(bs) == TEAM_RED) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1332
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 1332
INDIRI4
CNSTI4 1
NEI4 $780
line 1717
;1717:		bs->inventory[INVENTORY_RED_SKULL] = bs->cur_ps.generic1;
ADDRLP4 1336
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1336
INDIRP4
CNSTI4 5168
ADDP4
ADDRLP4 1336
INDIRP4
CNSTI4 456
ADDP4
INDIRI4
ASGNI4
line 1718
;1718:		bs->inventory[INVENTORY_BLUE_SKULL] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5172
ADDP4
CNSTI4 0
ASGNI4
line 1719
;1719:	}
ADDRGP4 $781
JUMPV
LABELV $780
line 1720
;1720:	else {
line 1721
;1721:		bs->inventory[INVENTORY_RED_SKULL] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 5168
ADDP4
CNSTI4 0
ASGNI4
line 1722
;1722:		bs->inventory[INVENTORY_BLUE_SKULL] = bs->cur_ps.generic1;
ADDRLP4 1336
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1336
INDIRP4
CNSTI4 5172
ADDP4
ADDRLP4 1336
INDIRP4
CNSTI4 456
ADDP4
INDIRI4
ASGNI4
line 1723
;1723:	}
LABELV $781
line 1724
;1724:	BotCheckItemPickup(bs, oldinventory);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckItemPickup
CALLV
pop
line 1725
;1725:}
LABELV $683
endproc BotUpdateInventory 1340 12
export BotUpdateBattleInventory
proc BotUpdateBattleInventory 160 8
line 1732
;1726:
;1727:/*
;1728:==================
;1729:BotUpdateBattleInventory
;1730:==================
;1731:*/
;1732:void BotUpdateBattleInventory(bot_state_t *bs, int enemy) {
line 1736
;1733:	vec3_t dir;
;1734:	aas_entityinfo_t entinfo;
;1735:
;1736:	BotEntityInfo(enemy, &entinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1737
;1737:	VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12+24
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12+24+4
INDIRF4
ADDRLP4 152
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 12+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1738
;1738:	bs->inventory[ENEMY_HEIGHT] = (int) dir[2];
ADDRFP4 0
INDIRP4
CNSTI4 5756
ADDP4
ADDRLP4 0+8
INDIRF4
CVFI4 4
ASGNI4
line 1739
;1739:	dir[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1740
;1740:	bs->inventory[ENEMY_HORIZONTAL_DIST] = (int) VectorLength(dir);
ADDRLP4 0
ARGP4
ADDRLP4 156
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 5752
ADDP4
ADDRLP4 156
INDIRF4
CVFI4 4
ASGNI4
line 1742
;1741:	//FIXME: add num visible enemies and num visible team mates to the inventory
;1742:}
LABELV $782
endproc BotUpdateBattleInventory 160 8
export BotUseKamikaze
proc BotUseKamikaze 284 28
line 1751
;1743:
;1744:/*
;1745:==================
;1746:BotUseKamikaze
;1747:==================
;1748:*/
;1749:#define KAMIKAZE_DIST		1024
;1750:
;1751:void BotUseKamikaze(bot_state_t *bs) {
line 1759
;1752:	int c, teammates, enemies;
;1753:	aas_entityinfo_t entinfo;
;1754:	vec3_t dir, target;
;1755:	bot_goal_t *goal;
;1756:	bsp_trace_t trace;
;1757:
;1758:	//if the bot has no kamikaze
;1759:	if (bs->inventory[INVENTORY_KAMIKAZE] <= 0)
ADDRFP4 0
INDIRP4
CNSTI4 5092
ADDP4
INDIRI4
CNSTI4 0
GTI4 $793
line 1760
;1760:		return;
ADDRGP4 $792
JUMPV
LABELV $793
line 1761
;1761:	if (bs->kamikaze_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6104
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $795
line 1762
;1762:		return;
ADDRGP4 $792
JUMPV
LABELV $795
line 1763
;1763:	bs->kamikaze_time = FloatTime() + 0.2;
ADDRFP4 0
INDIRP4
CNSTI4 6104
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 1764
;1764:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $797
line 1766
;1765:		//never use kamikaze if the team flag carrier is visible
;1766:		if (BotCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
EQI4 $799
line 1767
;1767:			return;
ADDRGP4 $792
JUMPV
LABELV $799
line 1768
;1768:		c = BotTeamFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 BotTeamFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 268
INDIRI4
ASGNI4
line 1769
;1769:		if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $801
line 1770
;1770:			BotEntityInfo(c, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1771
;1771:			VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16+24
INDIRF4
ADDRLP4 272
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16+24+4
INDIRF4
ADDRLP4 272
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 16+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1772
;1772:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST))
ADDRLP4 4
ARGP4
ADDRLP4 276
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 276
INDIRF4
CNSTF4 1233125376
GEF4 $810
line 1773
;1773:				return;
ADDRGP4 $792
JUMPV
LABELV $810
line 1774
;1774:		}
LABELV $801
line 1775
;1775:		c = BotEnemyFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 BotEnemyFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 272
INDIRI4
ASGNI4
line 1776
;1776:		if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $798
line 1777
;1777:			BotEntityInfo(c, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1778
;1778:			VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 276
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16+24
INDIRF4
ADDRLP4 276
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16+24+4
INDIRF4
ADDRLP4 276
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 16+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1779
;1779:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST)) {
ADDRLP4 4
ARGP4
ADDRLP4 280
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 280
INDIRF4
CNSTF4 1233125376
GEF4 $798
line 1780
;1780:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1781
;1781:				return;
ADDRGP4 $792
JUMPV
line 1783
;1782:			}
;1783:		}
line 1784
;1784:	}
LABELV $797
line 1785
;1785:	else if (gametype == GT_1FCTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $823
line 1787
;1786:		//never use kamikaze if the team flag carrier is visible
;1787:		if (Bot1FCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
EQI4 $825
line 1788
;1788:			return;
ADDRGP4 $792
JUMPV
LABELV $825
line 1789
;1789:		c = BotTeamFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 BotTeamFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 268
INDIRI4
ASGNI4
line 1790
;1790:		if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $827
line 1791
;1791:			BotEntityInfo(c, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1792
;1792:			VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16+24
INDIRF4
ADDRLP4 272
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16+24+4
INDIRF4
ADDRLP4 272
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 16+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1793
;1793:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST))
ADDRLP4 4
ARGP4
ADDRLP4 276
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 276
INDIRF4
CNSTF4 1233125376
GEF4 $836
line 1794
;1794:				return;
ADDRGP4 $792
JUMPV
LABELV $836
line 1795
;1795:		}
LABELV $827
line 1796
;1796:		c = BotEnemyFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 BotEnemyFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 272
INDIRI4
ASGNI4
line 1797
;1797:		if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $824
line 1798
;1798:			BotEntityInfo(c, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1799
;1799:			VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 276
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16+24
INDIRF4
ADDRLP4 276
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16+24+4
INDIRF4
ADDRLP4 276
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 16+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1800
;1800:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST)) {
ADDRLP4 4
ARGP4
ADDRLP4 280
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 280
INDIRF4
CNSTF4 1233125376
GEF4 $824
line 1801
;1801:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1802
;1802:				return;
ADDRGP4 $792
JUMPV
line 1804
;1803:			}
;1804:		}
line 1805
;1805:	}
LABELV $823
line 1806
;1806:	else if (gametype == GT_OBELISK) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $849
line 1807
;1807:		switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 264
ADDRLP4 268
INDIRI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 1
EQI4 $854
ADDRGP4 $851
JUMPV
LABELV $854
line 1808
;1808:			case TEAM_RED: goal = &blueobelisk; break;
ADDRLP4 176
ADDRGP4 blueobelisk
ASGNP4
ADDRGP4 $852
JUMPV
LABELV $851
line 1809
;1809:			default: goal = &redobelisk; break;
ADDRLP4 176
ADDRGP4 redobelisk
ASGNP4
LABELV $852
line 1812
;1810:		}
;1811:		//if the obelisk is visible
;1812:		VectorCopy(goal->origin, target);
ADDRLP4 164
ADDRLP4 176
INDIRP4
INDIRB
ASGNB 12
line 1813
;1813:		target[2] += 1;
ADDRLP4 164+8
ADDRLP4 164+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1814
;1814:		VectorSubtract(bs->origin, target, dir);
ADDRLP4 272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 272
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 164
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 272
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 164+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 164+8
INDIRF4
SUBF4
ASGNF4
line 1815
;1815:		if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST * 0.9)) {
ADDRLP4 4
ARGP4
ADDRLP4 276
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 276
INDIRF4
CNSTF4 1229937705
GEF4 $850
line 1816
;1816:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
ADDRLP4 180
ARGP4
ADDRLP4 280
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 280
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 164
ARGP4
ADDRLP4 280
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 1817
;1817:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
ADDRLP4 180+8
INDIRF4
CNSTF4 1065353216
GEF4 $866
ADDRLP4 180+80
INDIRI4
ADDRLP4 176
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $850
LABELV $866
line 1818
;1818:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1819
;1819:				return;
ADDRGP4 $792
JUMPV
line 1821
;1820:			}
;1821:		}
line 1822
;1822:	}
LABELV $849
line 1823
;1823:	else if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 8
NEI4 $867
line 1825
;1824:		//
;1825:		if (BotHarvesterCarryingSkulls(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 264
ADDRGP4 BotHarvesterCarryingSkulls
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 0
EQI4 $869
line 1826
;1826:			return;
ADDRGP4 $792
JUMPV
LABELV $869
line 1828
;1827:		//never use kamikaze if a team mate carrying cubes is visible
;1828:		c = BotTeamSkullCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 BotTeamSkullCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 268
INDIRI4
ASGNI4
line 1829
;1829:		if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $871
line 1830
;1830:			BotEntityInfo(c, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1831
;1831:			VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16+24
INDIRF4
ADDRLP4 272
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16+24+4
INDIRF4
ADDRLP4 272
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 16+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1832
;1832:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST))
ADDRLP4 4
ARGP4
ADDRLP4 276
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 276
INDIRF4
CNSTF4 1233125376
GEF4 $880
line 1833
;1833:				return;
ADDRGP4 $792
JUMPV
LABELV $880
line 1834
;1834:		}
LABELV $871
line 1835
;1835:		c = BotEnemySkullCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 BotEnemySkullCarrierVisible
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 272
INDIRI4
ASGNI4
line 1836
;1836:		if (c >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $882
line 1837
;1837:			BotEntityInfo(c, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 1838
;1838:			VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 276
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16+24
INDIRF4
ADDRLP4 276
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16+24+4
INDIRF4
ADDRLP4 276
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 16+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1839
;1839:			if (VectorLengthSquared(dir) < Square(KAMIKAZE_DIST)) {
ADDRLP4 4
ARGP4
ADDRLP4 280
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 280
INDIRF4
CNSTF4 1233125376
GEF4 $891
line 1840
;1840:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1841
;1841:				return;
ADDRGP4 $792
JUMPV
LABELV $891
line 1843
;1842:			}
;1843:		}
LABELV $882
line 1844
;1844:	}
LABELV $867
LABELV $850
LABELV $824
LABELV $798
line 1846
;1845:	//
;1846:	BotVisibleTeamMatesAndEnemies(bs, &teammates, &enemies, KAMIKAZE_DIST);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 160
ARGP4
ADDRLP4 156
ARGP4
CNSTF4 1149239296
ARGF4
ADDRGP4 BotVisibleTeamMatesAndEnemies
CALLV
pop
line 1848
;1847:	//
;1848:	if (enemies > 2 && enemies > teammates+1) {
ADDRLP4 264
ADDRLP4 156
INDIRI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 2
LEI4 $893
ADDRLP4 264
INDIRI4
ADDRLP4 160
INDIRI4
CNSTI4 1
ADDI4
LEI4 $893
line 1849
;1849:		trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1850
;1850:		return;
LABELV $893
line 1852
;1851:	}
;1852:}
LABELV $792
endproc BotUseKamikaze 284 28
export BotUseInvulnerability
proc BotUseInvulnerability 144 28
line 1859
;1853:
;1854:/*
;1855:==================
;1856:BotUseInvulnerability
;1857:==================
;1858:*/
;1859:void BotUseInvulnerability(bot_state_t *bs) {
line 1866
;1860:	int c;
;1861:	vec3_t dir, target;
;1862:	bot_goal_t *goal;
;1863:	bsp_trace_t trace;
;1864:
;1865:	//if the bot has no invulnerability
;1866:	if (bs->inventory[INVENTORY_INVULNERABILITY] <= 0)
ADDRFP4 0
INDIRP4
CNSTI4 5100
ADDP4
INDIRI4
CNSTI4 0
GTI4 $896
line 1867
;1867:		return;
ADDRGP4 $895
JUMPV
LABELV $896
line 1868
;1868:	if (bs->invulnerability_time > FloatTime())
ADDRFP4 0
INDIRP4
CNSTI4 6108
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $898
line 1869
;1869:		return;
ADDRGP4 $895
JUMPV
LABELV $898
line 1870
;1870:	bs->invulnerability_time = FloatTime() + 0.2;
ADDRFP4 0
INDIRP4
CNSTI4 6108
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 1871
;1871:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $900
line 1873
;1872:		//never use kamikaze if the team flag carrier is visible
;1873:		if (BotCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 116
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
EQI4 $902
line 1874
;1874:			return;
ADDRGP4 $895
JUMPV
LABELV $902
line 1875
;1875:		c = BotEnemyFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 BotEnemyFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 120
INDIRI4
ASGNI4
line 1876
;1876:		if (c >= 0)
ADDRLP4 24
INDIRI4
CNSTI4 0
LTI4 $904
line 1877
;1877:			return;
ADDRGP4 $895
JUMPV
LABELV $904
line 1879
;1878:		//if near enemy flag and the flag is visible
;1879:		switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 124
ADDRLP4 128
INDIRI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 1
EQI4 $909
ADDRGP4 $906
JUMPV
LABELV $909
line 1880
;1880:			case TEAM_RED: goal = &ctf_blueflag; break;
ADDRLP4 28
ADDRGP4 ctf_blueflag
ASGNP4
ADDRGP4 $907
JUMPV
LABELV $906
line 1881
;1881:			default: goal = &ctf_redflag; break;
ADDRLP4 28
ADDRGP4 ctf_redflag
ASGNP4
LABELV $907
line 1884
;1882:		}
;1883:		//if the obelisk is visible
;1884:		VectorCopy(goal->origin, target);
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRB
ASGNB 12
line 1885
;1885:		target[2] += 1;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1886
;1886:		VectorSubtract(bs->origin, target, dir);
ADDRLP4 132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 132
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 132
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 1887
;1887:		if (VectorLengthSquared(dir) < Square(200)) {
ADDRLP4 12
ARGP4
ADDRLP4 136
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 136
INDIRF4
CNSTF4 1193033728
GEF4 $901
line 1888
;1888:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
ADDRLP4 32
ARGP4
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 1889
;1889:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
ADDRLP4 32+8
INDIRF4
CNSTF4 1065353216
GEF4 $921
ADDRLP4 32+80
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $901
LABELV $921
line 1890
;1890:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1891
;1891:				return;
ADDRGP4 $895
JUMPV
line 1893
;1892:			}
;1893:		}
line 1894
;1894:	}
LABELV $900
line 1895
;1895:	else if (gametype == GT_1FCTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $922
line 1897
;1896:		//never use kamikaze if the team flag carrier is visible
;1897:		if (Bot1FCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 116
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
EQI4 $924
line 1898
;1898:			return;
ADDRGP4 $895
JUMPV
LABELV $924
line 1899
;1899:		c = BotEnemyFlagCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 BotEnemyFlagCarrierVisible
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 120
INDIRI4
ASGNI4
line 1900
;1900:		if (c >= 0)
ADDRLP4 24
INDIRI4
CNSTI4 0
LTI4 $926
line 1901
;1901:			return;
ADDRGP4 $895
JUMPV
LABELV $926
line 1903
;1902:		//if near enemy flag and the flag is visible
;1903:		switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 124
ADDRLP4 128
INDIRI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 1
EQI4 $931
ADDRGP4 $928
JUMPV
LABELV $931
line 1904
;1904:			case TEAM_RED: goal = &ctf_blueflag; break;
ADDRLP4 28
ADDRGP4 ctf_blueflag
ASGNP4
ADDRGP4 $929
JUMPV
LABELV $928
line 1905
;1905:			default: goal = &ctf_redflag; break;
ADDRLP4 28
ADDRGP4 ctf_redflag
ASGNP4
LABELV $929
line 1908
;1906:		}
;1907:		//if the obelisk is visible
;1908:		VectorCopy(goal->origin, target);
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRB
ASGNB 12
line 1909
;1909:		target[2] += 1;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1910
;1910:		VectorSubtract(bs->origin, target, dir);
ADDRLP4 132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 132
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 132
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 1911
;1911:		if (VectorLengthSquared(dir) < Square(200)) {
ADDRLP4 12
ARGP4
ADDRLP4 136
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 136
INDIRF4
CNSTF4 1193033728
GEF4 $923
line 1912
;1912:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
ADDRLP4 32
ARGP4
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 1913
;1913:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
ADDRLP4 32+8
INDIRF4
CNSTF4 1065353216
GEF4 $943
ADDRLP4 32+80
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $923
LABELV $943
line 1914
;1914:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1915
;1915:				return;
ADDRGP4 $895
JUMPV
line 1917
;1916:			}
;1917:		}
line 1918
;1918:	}
LABELV $922
line 1919
;1919:	else if (gametype == GT_OBELISK) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $944
line 1920
;1920:		switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 116
ADDRLP4 120
INDIRI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 1
EQI4 $949
ADDRGP4 $946
JUMPV
LABELV $949
line 1921
;1921:			case TEAM_RED: goal = &blueobelisk; break;
ADDRLP4 28
ADDRGP4 blueobelisk
ASGNP4
ADDRGP4 $947
JUMPV
LABELV $946
line 1922
;1922:			default: goal = &redobelisk; break;
ADDRLP4 28
ADDRGP4 redobelisk
ASGNP4
LABELV $947
line 1925
;1923:		}
;1924:		//if the obelisk is visible
;1925:		VectorCopy(goal->origin, target);
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRB
ASGNB 12
line 1926
;1926:		target[2] += 1;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1927
;1927:		VectorSubtract(bs->origin, target, dir);
ADDRLP4 124
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 124
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 124
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 1928
;1928:		if (VectorLengthSquared(dir) < Square(300)) {
ADDRLP4 12
ARGP4
ADDRLP4 128
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 128
INDIRF4
CNSTF4 1202702336
GEF4 $945
line 1929
;1929:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
ADDRLP4 32
ARGP4
ADDRLP4 132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 132
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 132
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 1930
;1930:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
ADDRLP4 32+8
INDIRF4
CNSTF4 1065353216
GEF4 $961
ADDRLP4 32+80
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $945
LABELV $961
line 1931
;1931:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1932
;1932:				return;
ADDRGP4 $895
JUMPV
line 1934
;1933:			}
;1934:		}
line 1935
;1935:	}
LABELV $944
line 1936
;1936:	else if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 8
NEI4 $962
line 1938
;1937:		//
;1938:		if (BotHarvesterCarryingSkulls(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 116
ADDRGP4 BotHarvesterCarryingSkulls
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
EQI4 $964
line 1939
;1939:			return;
ADDRGP4 $895
JUMPV
LABELV $964
line 1940
;1940:		c = BotEnemySkullCarrierVisible(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 BotEnemySkullCarrierVisible
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 120
INDIRI4
ASGNI4
line 1941
;1941:		if (c >= 0)
ADDRLP4 24
INDIRI4
CNSTI4 0
LTI4 $966
line 1942
;1942:			return;
ADDRGP4 $895
JUMPV
LABELV $966
line 1944
;1943:		//if near enemy base and enemy base is visible
;1944:		switch(BotTeam(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 124
ADDRLP4 128
INDIRI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 1
EQI4 $971
ADDRGP4 $968
JUMPV
LABELV $971
line 1945
;1945:			case TEAM_RED: goal = &blueobelisk; break;
ADDRLP4 28
ADDRGP4 blueobelisk
ASGNP4
ADDRGP4 $969
JUMPV
LABELV $968
line 1946
;1946:			default: goal = &redobelisk; break;
ADDRLP4 28
ADDRGP4 redobelisk
ASGNP4
LABELV $969
line 1949
;1947:		}
;1948:		//if the obelisk is visible
;1949:		VectorCopy(goal->origin, target);
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRB
ASGNB 12
line 1950
;1950:		target[2] += 1;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1951
;1951:		VectorSubtract(bs->origin, target, dir);
ADDRLP4 132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 132
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 132
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 1952
;1952:		if (VectorLengthSquared(dir) < Square(200)) {
ADDRLP4 12
ARGP4
ADDRLP4 136
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 136
INDIRF4
CNSTF4 1193033728
GEF4 $977
line 1953
;1953:			BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
ADDRLP4 32
ARGP4
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 140
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 1954
;1954:			if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
ADDRLP4 32+8
INDIRF4
CNSTF4 1065353216
GEF4 $983
ADDRLP4 32+80
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $979
LABELV $983
line 1955
;1955:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1956
;1956:				return;
LABELV $979
line 1958
;1957:			}
;1958:		}
LABELV $977
line 1959
;1959:	}
LABELV $962
LABELV $945
LABELV $923
LABELV $901
line 1960
;1960:}
LABELV $895
endproc BotUseInvulnerability 144 28
export BotBattleUseItems
proc BotBattleUseItems 12 4
line 1967
;1961:
;1962:/*
;1963:==================
;1964:BotBattleUseItems
;1965:==================
;1966:*/
;1967:void BotBattleUseItems(bot_state_t *bs) {
line 1968
;1968:	if (bs->inventory[INVENTORY_HEALTH] < 40) {
ADDRFP4 0
INDIRP4
CNSTI4 5080
ADDP4
INDIRI4
CNSTI4 40
GEI4 $985
line 1969
;1969:		if (bs->inventory[INVENTORY_TELEPORTER] > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5084
ADDP4
INDIRI4
CNSTI4 0
LEI4 $987
line 1970
;1970:			if (!BotCTFCarryingFlag(bs) && !Bot1FCTFCarryingFlag(bs) && !BotHarvesterCarryingSkulls(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $989
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $989
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotHarvesterCarryingSkulls
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $989
line 1971
;1971:				trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1972
;1972:			}
LABELV $989
line 1973
;1973:		}
LABELV $987
line 1974
;1974:	}
LABELV $985
line 1975
;1975:	if (bs->inventory[INVENTORY_HEALTH] < 60) {
ADDRFP4 0
INDIRP4
CNSTI4 5080
ADDP4
INDIRI4
CNSTI4 60
GEI4 $991
line 1976
;1976:		if (bs->inventory[INVENTORY_MEDKIT] > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5088
ADDP4
INDIRI4
CNSTI4 0
LEI4 $993
line 1977
;1977:			trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 1978
;1978:		}
LABELV $993
line 1979
;1979:	}
LABELV $991
line 1980
;1980:	BotUseKamikaze(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotUseKamikaze
CALLV
pop
line 1981
;1981:	BotUseInvulnerability(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotUseInvulnerability
CALLV
pop
line 1982
;1982:}
LABELV $984
endproc BotBattleUseItems 12 4
export BotSetTeleportTime
proc BotSetTeleportTime 8 0
line 1989
;1983:
;1984:/*
;1985:==================
;1986:BotSetTeleportTime
;1987:==================
;1988:*/
;1989:void BotSetTeleportTime(bot_state_t *bs) {
line 1990
;1990:	if ((bs->cur_ps.eFlags ^ bs->last_eFlags) & EF_TELEPORT_BIT) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 484
ADDP4
INDIRI4
BXORI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $996
line 1991
;1991:		bs->teleport_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6180
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1992
;1992:	}
LABELV $996
line 1993
;1993:	bs->last_eFlags = bs->cur_ps.eFlags;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 484
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 120
ADDP4
INDIRI4
ASGNI4
line 1994
;1994:}
LABELV $995
endproc BotSetTeleportTime 8 0
export BotIsDead
proc BotIsDead 4 0
line 2001
;1995:
;1996:/*
;1997:==================
;1998:BotIsDead
;1999:==================
;2000:*/
;2001:qboolean BotIsDead(bot_state_t *bs) {
line 2002
;2002:	return (bs->cur_ps.pm_type == PM_DEAD);
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1000
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1001
JUMPV
LABELV $1000
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1001
ADDRLP4 0
INDIRI4
RETI4
LABELV $998
endproc BotIsDead 4 0
export BotIsObserver
proc BotIsObserver 1032 12
line 2010
;2003:}
;2004:
;2005:/*
;2006:==================
;2007:BotIsObserver
;2008:==================
;2009:*/
;2010:qboolean BotIsObserver(bot_state_t *bs) {
line 2012
;2011:	char buf[MAX_INFO_STRING];
;2012:	if (bs->cur_ps.pm_type == PM_SPECTATOR) return qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1003
CNSTI4 1
RETI4
ADDRGP4 $1002
JUMPV
LABELV $1003
line 2013
;2013:	trap_GetConfigstring(CS_PLAYERS+bs->client, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 529
ADDI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 2014
;2014:	if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) return qtrue;
ADDRLP4 0
ARGP4
ADDRGP4 $70
ARGP4
ADDRLP4 1024
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 1028
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 3
NEI4 $1005
CNSTI4 1
RETI4
ADDRGP4 $1002
JUMPV
LABELV $1005
line 2015
;2015:	return qfalse;
CNSTI4 0
RETI4
LABELV $1002
endproc BotIsObserver 1032 12
export BotIntermission
proc BotIntermission 8 0
line 2023
;2016:}
;2017:
;2018:/*
;2019:==================
;2020:BotIntermission
;2021:==================
;2022:*/
;2023:qboolean BotIntermission(bot_state_t *bs) {
line 2025
;2024:	//NOTE: we shouldn't be looking at the game code...
;2025:	if (level.intermissiontime) return qtrue;
ADDRGP4 level+5516
INDIRI4
CNSTI4 0
EQI4 $1008
CNSTI4 1
RETI4
ADDRGP4 $1007
JUMPV
LABELV $1008
line 2026
;2026:	return (bs->cur_ps.pm_type == PM_FREEZE || bs->cur_ps.pm_type == PM_INTERMISSION);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 4
EQI4 $1014
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1012
LABELV $1014
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1013
JUMPV
LABELV $1012
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1013
ADDRLP4 0
INDIRI4
RETI4
LABELV $1007
endproc BotIntermission 8 0
export BotInLavaOrSlime
proc BotInLavaOrSlime 16 4
line 2034
;2027:}
;2028:
;2029:/*
;2030:==================
;2031:BotInLavaOrSlime
;2032:==================
;2033:*/
;2034:qboolean BotInLavaOrSlime(bot_state_t *bs) {
line 2037
;2035:	vec3_t feet;
;2036:
;2037:	VectorCopy(bs->origin, feet);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 2038
;2038:	feet[2] -= 23;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1102577664
SUBF4
ASGNF4
line 2039
;2039:	return (trap_AAS_PointContents(feet) & (CONTENTS_LAVA|CONTENTS_SLIME));
ADDRLP4 0
ARGP4
ADDRLP4 12
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 24
BANDI4
RETI4
LABELV $1015
endproc BotInLavaOrSlime 16 4
data
align 4
LABELV $1018
byte 4 3238002688
byte 4 3238002688
byte 4 3238002688
align 4
LABELV $1019
byte 4 1090519040
byte 4 1090519040
byte 4 1090519040
export BotCreateWayPoint
code
proc BotCreateWayPoint 32 12
line 2047
;2040:}
;2041:
;2042:/*
;2043:==================
;2044:BotCreateWayPoint
;2045:==================
;2046:*/
;2047:bot_waypoint_t *BotCreateWayPoint(char *name, vec3_t origin, int areanum) {
line 2049
;2048:	bot_waypoint_t *wp;
;2049:	vec3_t waypointmins = {-8, -8, -8}, waypointmaxs = {8, 8, 8};
ADDRLP4 4
ADDRGP4 $1018
INDIRB
ASGNB 12
ADDRLP4 16
ADDRGP4 $1019
INDIRB
ASGNB 12
line 2051
;2050:
;2051:	wp = botai_freewaypoints;
ADDRLP4 0
ADDRGP4 botai_freewaypoints
INDIRP4
ASGNP4
line 2052
;2052:	if ( !wp ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1020
line 2053
;2053:		BotAI_Print( PRT_WARNING, "BotCreateWayPoint: Out of waypoints\n" );
CNSTI4 2
ARGI4
ADDRGP4 $1022
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 2054
;2054:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $1017
JUMPV
LABELV $1020
line 2056
;2055:	}
;2056:	botai_freewaypoints = botai_freewaypoints->next;
ADDRLP4 28
ADDRGP4 botai_freewaypoints
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
line 2058
;2057:
;2058:	Q_strncpyz( wp->name, name, sizeof(wp->name) );
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2059
;2059:	VectorCopy(origin, wp->goal.origin);
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2060
;2060:	VectorCopy(waypointmins, wp->goal.mins);
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 2061
;2061:	VectorCopy(waypointmaxs, wp->goal.maxs);
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDRLP4 16
INDIRB
ASGNB 12
line 2062
;2062:	wp->goal.areanum = areanum;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 2063
;2063:	wp->next = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
CNSTP4 0
ASGNP4
line 2064
;2064:	wp->prev = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
CNSTP4 0
ASGNP4
line 2065
;2065:	return wp;
ADDRLP4 0
INDIRP4
RETP4
LABELV $1017
endproc BotCreateWayPoint 32 12
export BotFindWayPoint
proc BotFindWayPoint 8 8
line 2073
;2066:}
;2067:
;2068:/*
;2069:==================
;2070:BotFindWayPoint
;2071:==================
;2072:*/
;2073:bot_waypoint_t *BotFindWayPoint(bot_waypoint_t *waypoints, char *name) {
line 2076
;2074:	bot_waypoint_t *wp;
;2075:
;2076:	for (wp = waypoints; wp; wp = wp->next) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $1027
JUMPV
LABELV $1024
line 2077
;2077:		if (!Q_stricmp(wp->name, name)) return wp;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1028
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $1023
JUMPV
LABELV $1028
line 2078
;2078:	}
LABELV $1025
line 2076
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
LABELV $1027
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1024
line 2079
;2079:	return NULL;
CNSTP4 0
RETP4
LABELV $1023
endproc BotFindWayPoint 8 8
export BotFreeWaypoints
proc BotFreeWaypoints 4 0
line 2087
;2080:}
;2081:
;2082:/*
;2083:==================
;2084:BotFreeWaypoints
;2085:==================
;2086:*/
;2087:void BotFreeWaypoints(bot_waypoint_t *wp) {
line 2090
;2088:	bot_waypoint_t *nextwp;
;2089:
;2090:	for (; wp; wp = nextwp) {
ADDRGP4 $1034
JUMPV
LABELV $1031
line 2091
;2091:		nextwp = wp->next;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
ASGNP4
line 2092
;2092:		wp->next = botai_freewaypoints;
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRGP4 botai_freewaypoints
INDIRP4
ASGNP4
line 2093
;2093:		botai_freewaypoints = wp;
ADDRGP4 botai_freewaypoints
ADDRFP4 0
INDIRP4
ASGNP4
line 2094
;2094:	}
LABELV $1032
line 2090
ADDRFP4 0
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $1034
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1031
line 2095
;2095:}
LABELV $1030
endproc BotFreeWaypoints 4 0
export BotInitWaypoints
proc BotInitWaypoints 4 0
line 2102
;2096:
;2097:/*
;2098:==================
;2099:BotInitWaypoints
;2100:==================
;2101:*/
;2102:void BotInitWaypoints(void) {
line 2105
;2103:	int i;
;2104:
;2105:	botai_freewaypoints = NULL;
ADDRGP4 botai_freewaypoints
CNSTP4 0
ASGNP4
line 2106
;2106:	for (i = 0; i < MAX_WAYPOINTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1036
line 2107
;2107:		botai_waypoints[i].next = botai_freewaypoints;
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 botai_waypoints+92
ADDP4
ADDRGP4 botai_freewaypoints
INDIRP4
ASGNP4
line 2108
;2108:		botai_freewaypoints = &botai_waypoints[i];
ADDRGP4 botai_freewaypoints
ADDRLP4 0
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 botai_waypoints
ADDP4
ASGNP4
line 2109
;2109:	}
LABELV $1037
line 2106
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 128
LTI4 $1036
line 2110
;2110:}
LABELV $1035
endproc BotInitWaypoints 4 0
export TeamPlayIsOn
proc TeamPlayIsOn 4 0
line 2117
;2111:
;2112:/*
;2113:==================
;2114:TeamPlayIsOn
;2115:==================
;2116:*/
;2117:int TeamPlayIsOn(void) {
line 2118
;2118:	return ( gametype >= GT_TEAM );
ADDRGP4 gametype
INDIRI4
CNSTI4 3
LTI4 $1043
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1044
JUMPV
LABELV $1043
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1044
ADDRLP4 0
INDIRI4
RETI4
LABELV $1041
endproc TeamPlayIsOn 4 0
export BotAggression
proc BotAggression 28 0
line 2126
;2119:}
;2120:
;2121:/*
;2122:==================
;2123:BotAggression
;2124:==================
;2125:*/
;2126:float BotAggression(bot_state_t *bs) {
line 2128
;2127:	//if the bot has quad
;2128:	if (bs->inventory[INVENTORY_QUAD]) {
ADDRFP4 0
INDIRP4
CNSTI4 5120
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1046
line 2130
;2129:		//if the bot is not holding the gauntlet or the enemy is really nearby
;2130:		if (bs->weaponnum != WP_GAUNTLET ||
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1050
ADDRLP4 0
INDIRP4
CNSTI4 5752
ADDP4
INDIRI4
CNSTI4 80
GEI4 $1048
LABELV $1050
line 2131
;2131:			bs->inventory[ENEMY_HORIZONTAL_DIST] < 80) {
line 2132
;2132:			return 70;
CNSTF4 1116471296
RETF4
ADDRGP4 $1045
JUMPV
LABELV $1048
line 2134
;2133:		}
;2134:	}
LABELV $1046
line 2136
;2135:	//if the enemy is located way higher than the bot
;2136:	if (bs->inventory[ENEMY_HEIGHT] > 200) return 0;
ADDRFP4 0
INDIRP4
CNSTI4 5756
ADDP4
INDIRI4
CNSTI4 200
LEI4 $1051
CNSTF4 0
RETF4
ADDRGP4 $1045
JUMPV
LABELV $1051
line 2138
;2137:	//if the bot is very low on health
;2138:	if (bs->inventory[INVENTORY_HEALTH] < 60) return 0;
ADDRFP4 0
INDIRP4
CNSTI4 5080
ADDP4
INDIRI4
CNSTI4 60
GEI4 $1053
CNSTF4 0
RETF4
ADDRGP4 $1045
JUMPV
LABELV $1053
line 2140
;2139:	//if the bot is low on health
;2140:	if (bs->inventory[INVENTORY_HEALTH] < 80) {
ADDRFP4 0
INDIRP4
CNSTI4 5080
ADDP4
INDIRI4
CNSTI4 80
GEI4 $1055
line 2142
;2141:		//if the bot has insufficient armor
;2142:		if (bs->inventory[INVENTORY_ARMOR] < 40) return 0;
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
CNSTI4 40
GEI4 $1057
CNSTF4 0
RETF4
ADDRGP4 $1045
JUMPV
LABELV $1057
line 2143
;2143:	}
LABELV $1055
line 2145
;2144:	//if the bot can use the bfg
;2145:	if (bs->inventory[INVENTORY_BFG10K] > 0 &&
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1059
ADDRLP4 0
INDIRP4
CNSTI4 5056
ADDP4
INDIRI4
CNSTI4 7
LEI4 $1059
line 2146
;2146:			bs->inventory[INVENTORY_BFGAMMO] > 7) return 100;
CNSTF4 1120403456
RETF4
ADDRGP4 $1045
JUMPV
LABELV $1059
line 2148
;2147:	//if the bot can use the railgun
;2148:	if (bs->inventory[INVENTORY_RAILGUN] > 0 &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4992
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1061
ADDRLP4 4
INDIRP4
CNSTI4 5052
ADDP4
INDIRI4
CNSTI4 5
LEI4 $1061
line 2149
;2149:			bs->inventory[INVENTORY_SLUGS] > 5) return 95;
CNSTF4 1119748096
RETF4
ADDRGP4 $1045
JUMPV
LABELV $1061
line 2151
;2150:	//if the bot can use the lightning gun
;2151:	if (bs->inventory[INVENTORY_LIGHTNING] > 0 &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4988
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1063
ADDRLP4 8
INDIRP4
CNSTI4 5044
ADDP4
INDIRI4
CNSTI4 50
LEI4 $1063
line 2152
;2152:			bs->inventory[INVENTORY_LIGHTNINGAMMO] > 50) return 90;
CNSTF4 1119092736
RETF4
ADDRGP4 $1045
JUMPV
LABELV $1063
line 2154
;2153:	//if the bot can use the rocketlauncher
;2154:	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 &&
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1065
ADDRLP4 12
INDIRP4
CNSTI4 5048
ADDP4
INDIRI4
CNSTI4 5
LEI4 $1065
line 2155
;2155:			bs->inventory[INVENTORY_ROCKETS] > 5) return 90;
CNSTF4 1119092736
RETF4
ADDRGP4 $1045
JUMPV
LABELV $1065
line 2157
;2156:	//if the bot can use the plasmagun
;2157:	if (bs->inventory[INVENTORY_PLASMAGUN] > 0 &&
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 4996
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1067
ADDRLP4 16
INDIRP4
CNSTI4 5040
ADDP4
INDIRI4
CNSTI4 40
LEI4 $1067
line 2158
;2158:			bs->inventory[INVENTORY_CELLS] > 40) return 85;
CNSTF4 1118437376
RETF4
ADDRGP4 $1045
JUMPV
LABELV $1067
line 2160
;2159:	//if the bot can use the grenade launcher
;2160:	if (bs->inventory[INVENTORY_GRENADELAUNCHER] > 0 &&
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 4980
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1069
ADDRLP4 20
INDIRP4
CNSTI4 5036
ADDP4
INDIRI4
CNSTI4 10
LEI4 $1069
line 2161
;2161:			bs->inventory[INVENTORY_GRENADES] > 10) return 80;
CNSTF4 1117782016
RETF4
ADDRGP4 $1045
JUMPV
LABELV $1069
line 2163
;2162:	//if the bot can use the shotgun
;2163:	if (bs->inventory[INVENTORY_SHOTGUN] > 0 &&
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 4972
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1071
ADDRLP4 24
INDIRP4
CNSTI4 5028
ADDP4
INDIRI4
CNSTI4 10
LEI4 $1071
line 2164
;2164:			bs->inventory[INVENTORY_SHELLS] > 10) return 50;
CNSTF4 1112014848
RETF4
ADDRGP4 $1045
JUMPV
LABELV $1071
line 2166
;2165:	//otherwise the bot is not feeling too good
;2166:	return 0;
CNSTF4 0
RETF4
LABELV $1045
endproc BotAggression 28 0
export BotFeelingBad
proc BotFeelingBad 0 0
line 2174
;2167:}
;2168:
;2169:/*
;2170:==================
;2171:BotFeelingBad
;2172:==================
;2173:*/
;2174:float BotFeelingBad(bot_state_t *bs) {
line 2175
;2175:	if (bs->weaponnum == WP_GAUNTLET) {
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1074
line 2176
;2176:		return 100;
CNSTF4 1120403456
RETF4
ADDRGP4 $1073
JUMPV
LABELV $1074
line 2178
;2177:	}
;2178:	if (bs->inventory[INVENTORY_HEALTH] < 40) {
ADDRFP4 0
INDIRP4
CNSTI4 5080
ADDP4
INDIRI4
CNSTI4 40
GEI4 $1076
line 2179
;2179:		return 100;
CNSTF4 1120403456
RETF4
ADDRGP4 $1073
JUMPV
LABELV $1076
line 2181
;2180:	}
;2181:	if (bs->weaponnum == WP_MACHINEGUN) {
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1078
line 2182
;2182:		return 90;
CNSTF4 1119092736
RETF4
ADDRGP4 $1073
JUMPV
LABELV $1078
line 2184
;2183:	}
;2184:	if (bs->inventory[INVENTORY_HEALTH] < 60) {
ADDRFP4 0
INDIRP4
CNSTI4 5080
ADDP4
INDIRI4
CNSTI4 60
GEI4 $1080
line 2185
;2185:		return 80;
CNSTF4 1117782016
RETF4
ADDRGP4 $1073
JUMPV
LABELV $1080
line 2187
;2186:	}
;2187:	return 0;
CNSTF4 0
RETF4
LABELV $1073
endproc BotFeelingBad 0 0
export BotWantsToRetreat
proc BotWantsToRetreat 144 8
line 2195
;2188:}
;2189:
;2190:/*
;2191:==================
;2192:BotWantsToRetreat
;2193:==================
;2194:*/
;2195:int BotWantsToRetreat(bot_state_t *bs) {
line 2198
;2196:	aas_entityinfo_t entinfo;
;2197:
;2198:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $1083
line 2200
;2199:		//always retreat when carrying a CTF flag
;2200:		if (BotCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1084
line 2201
;2201:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1082
JUMPV
line 2202
;2202:	} else if (gametype == GT_1FCTF) {
LABELV $1083
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $1087
line 2204
;2203:		//if carrying the flag then always retreat
;2204:		if (Bot1FCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1088
line 2205
;2205:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1082
JUMPV
line 2206
;2206:	} else if (gametype == GT_OBELISK) {
LABELV $1087
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $1091
line 2208
;2207:		//the bots should be dedicated to attacking the enemy obelisk
;2208:		if (bs->ltgtype == LTG_ATTACKENEMYBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 13
NEI4 $1093
line 2209
;2209:			if (bs->enemy != redobelisk.entitynum &&
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ADDRGP4 redobelisk+40
INDIRI4
EQI4 $1095
ADDRLP4 140
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ADDRGP4 blueobelisk+40
INDIRI4
EQI4 $1095
line 2210
;2210:						bs->enemy != blueobelisk.entitynum) {
line 2211
;2211:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1082
JUMPV
LABELV $1095
line 2213
;2212:			}
;2213:		}
LABELV $1093
line 2214
;2214:		if (BotFeelingBad(bs) > 50) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotFeelingBad
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 1112014848
LEF4 $1099
line 2215
;2215:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1082
JUMPV
LABELV $1099
line 2217
;2216:		}
;2217:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1082
JUMPV
LABELV $1091
line 2218
;2218:	} else if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 8
NEI4 $1101
line 2220
;2219:		//if carrying cubes then always retreat
;2220:		if (BotHarvesterCarryingSkulls(bs)) return qtrue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotHarvesterCarryingSkulls
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1103
CNSTI4 1
RETI4
ADDRGP4 $1082
JUMPV
LABELV $1103
line 2221
;2221:	}
LABELV $1101
LABELV $1088
LABELV $1084
line 2223
;2222:	//
;2223:	if (bs->enemy >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
CNSTI4 0
LTI4 $1105
line 2225
;2224:		//if the enemy is carrying a flag
;2225:		BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2226
;2226:		if (EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 140
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1107
line 2227
;2227:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1082
JUMPV
LABELV $1107
line 2228
;2228:	}
LABELV $1105
line 2230
;2229:	//if the bot is getting the flag
;2230:	if (bs->ltgtype == LTG_GETFLAG)
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1109
line 2231
;2231:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1082
JUMPV
LABELV $1109
line 2233
;2232:	//
;2233:	if (BotAggression(bs) < 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 1112014848
GEF4 $1111
line 2234
;2234:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1082
JUMPV
LABELV $1111
line 2235
;2235:	return qfalse;
CNSTI4 0
RETI4
LABELV $1082
endproc BotWantsToRetreat 144 8
export BotWantsToChase
proc BotWantsToChase 148 8
line 2243
;2236:}
;2237:
;2238:/*
;2239:==================
;2240:BotWantsToChase
;2241:==================
;2242:*/
;2243:int BotWantsToChase(bot_state_t *bs) {
line 2246
;2244:	aas_entityinfo_t entinfo;
;2245:
;2246:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $1114
line 2248
;2247:		//never chase when carrying a CTF flag
;2248:		if (BotCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1116
line 2249
;2249:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1113
JUMPV
LABELV $1116
line 2251
;2250:		//always chase if the enemy is carrying a flag
;2251:		BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2252
;2252:		if (EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 144
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $1115
line 2253
;2253:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1113
JUMPV
line 2254
;2254:	} else if (gametype == GT_1FCTF) {
LABELV $1114
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $1120
line 2256
;2255:		//never chase if carrying the flag
;2256:		if (Bot1FCTFCarryingFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 Bot1FCTFCarryingFlag
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1122
line 2257
;2257:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1113
JUMPV
LABELV $1122
line 2259
;2258:		//always chase if the enemy is carrying a flag
;2259:		BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2260
;2260:		if (EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 144
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $1121
line 2261
;2261:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1113
JUMPV
line 2262
;2262:	} else if (gametype == GT_OBELISK) {
LABELV $1120
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $1126
line 2264
;2263:		//the bots should be dedicated to attacking the enemy obelisk
;2264:		if (bs->ltgtype == LTG_ATTACKENEMYBASE) {
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 13
NEI4 $1127
line 2265
;2265:			if (bs->enemy != redobelisk.entitynum &&
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ADDRGP4 redobelisk+40
INDIRI4
EQI4 $1127
ADDRLP4 140
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ADDRGP4 blueobelisk+40
INDIRI4
EQI4 $1127
line 2266
;2266:						bs->enemy != blueobelisk.entitynum) {
line 2267
;2267:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1113
JUMPV
line 2269
;2268:			}
;2269:		}
line 2270
;2270:	} else if (gametype == GT_HARVESTER) {
LABELV $1126
ADDRGP4 gametype
INDIRI4
CNSTI4 8
NEI4 $1134
line 2272
;2271:		//never chase if carrying cubes
;2272:		if (BotHarvesterCarryingSkulls(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotHarvesterCarryingSkulls
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $1136
line 2273
;2273:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1113
JUMPV
LABELV $1136
line 2274
;2274:	}
LABELV $1134
LABELV $1127
LABELV $1121
LABELV $1115
line 2276
;2275:	//if the bot is getting the flag
;2276:	if (bs->ltgtype == LTG_GETFLAG)
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1138
line 2277
;2277:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1113
JUMPV
LABELV $1138
line 2279
;2278:	//
;2279:	if (BotAggression(bs) > 50)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 1112014848
LEF4 $1140
line 2280
;2280:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1113
JUMPV
LABELV $1140
line 2281
;2281:	return qfalse;
CNSTI4 0
RETI4
LABELV $1113
endproc BotWantsToChase 148 8
export BotWantsToHelp
proc BotWantsToHelp 0 0
line 2289
;2282:}
;2283:
;2284:/*
;2285:==================
;2286:BotWantsToHelp
;2287:==================
;2288:*/
;2289:int BotWantsToHelp(bot_state_t *bs) {
line 2290
;2290:	return qtrue;
CNSTI4 1
RETI4
LABELV $1142
endproc BotWantsToHelp 0 0
export BotCanAndWantsToRocketJump
proc BotCanAndWantsToRocketJump 8 16
line 2298
;2291:}
;2292:
;2293:/*
;2294:==================
;2295:BotCanAndWantsToRocketJump
;2296:==================
;2297:*/
;2298:int BotCanAndWantsToRocketJump(bot_state_t *bs) {
line 2302
;2299:	float rocketjumper;
;2300:
;2301:	//if rocket jumping is disabled
;2302:	if (!bot_rocketjump.integer) return qfalse;
ADDRGP4 bot_rocketjump+12
INDIRI4
CNSTI4 0
NEI4 $1144
CNSTI4 0
RETI4
ADDRGP4 $1143
JUMPV
LABELV $1144
line 2304
;2303:	//if no rocket launcher
;2304:	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] <= 0) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 0
GTI4 $1147
CNSTI4 0
RETI4
ADDRGP4 $1143
JUMPV
LABELV $1147
line 2306
;2305:	//if low on rockets
;2306:	if (bs->inventory[INVENTORY_ROCKETS] < 3) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5048
ADDP4
INDIRI4
CNSTI4 3
GEI4 $1149
CNSTI4 0
RETI4
ADDRGP4 $1143
JUMPV
LABELV $1149
line 2308
;2307:	//never rocket jump with the Quad
;2308:	if (bs->inventory[INVENTORY_QUAD]) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5120
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1151
CNSTI4 0
RETI4
ADDRGP4 $1143
JUMPV
LABELV $1151
line 2310
;2309:	//if low on health
;2310:	if (bs->inventory[INVENTORY_HEALTH] < 60) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5080
ADDP4
INDIRI4
CNSTI4 60
GEI4 $1153
CNSTI4 0
RETI4
ADDRGP4 $1143
JUMPV
LABELV $1153
line 2312
;2311:	//if not full health
;2312:	if (bs->inventory[INVENTORY_HEALTH] < 90) {
ADDRFP4 0
INDIRP4
CNSTI4 5080
ADDP4
INDIRI4
CNSTI4 90
GEI4 $1155
line 2314
;2313:		//if the bot has insufficient armor
;2314:		if (bs->inventory[INVENTORY_ARMOR] < 40) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
CNSTI4 40
GEI4 $1157
CNSTI4 0
RETI4
ADDRGP4 $1143
JUMPV
LABELV $1157
line 2315
;2315:	}
LABELV $1155
line 2316
;2316:	rocketjumper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_WEAPONJUMPING, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 38
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 4
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 2317
;2317:	if (rocketjumper < 0.5) return qfalse;
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
GEF4 $1159
CNSTI4 0
RETI4
ADDRGP4 $1143
JUMPV
LABELV $1159
line 2318
;2318:	return qtrue;
CNSTI4 1
RETI4
LABELV $1143
endproc BotCanAndWantsToRocketJump 8 16
export BotHasPersistantPowerupAndWeapon
proc BotHasPersistantPowerupAndWeapon 36 0
line 2326
;2319:}
;2320:
;2321:/*
;2322:==================
;2323:BotHasPersistantPowerupAndWeapon
;2324:==================
;2325:*/
;2326:int BotHasPersistantPowerupAndWeapon(bot_state_t *bs) {
line 2328
;2327:	// if the bot does not have a persistant powerup
;2328:	if (!bs->inventory[INVENTORY_SCOUT] &&
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 5140
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1162
ADDRLP4 0
INDIRP4
CNSTI4 5144
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1162
ADDRLP4 0
INDIRP4
CNSTI4 5148
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1162
ADDRLP4 0
INDIRP4
CNSTI4 5152
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1162
line 2331
;2329:		!bs->inventory[INVENTORY_GUARD] &&
;2330:		!bs->inventory[INVENTORY_DAMAGE] &&
;2331:		!bs->inventory[INVENTORY_ARMORREGEN] ) {
line 2332
;2332:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1161
JUMPV
LABELV $1162
line 2335
;2333:	}
;2334:	//if the bot is very low on health
;2335:	if (bs->inventory[INVENTORY_HEALTH] < 60) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 5080
ADDP4
INDIRI4
CNSTI4 60
GEI4 $1164
CNSTI4 0
RETI4
ADDRGP4 $1161
JUMPV
LABELV $1164
line 2337
;2336:	//if the bot is low on health
;2337:	if (bs->inventory[INVENTORY_HEALTH] < 80) {
ADDRFP4 0
INDIRP4
CNSTI4 5080
ADDP4
INDIRI4
CNSTI4 80
GEI4 $1166
line 2339
;2338:		//if the bot has insufficient armor
;2339:		if (bs->inventory[INVENTORY_ARMOR] < 40) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4956
ADDP4
INDIRI4
CNSTI4 40
GEI4 $1168
CNSTI4 0
RETI4
ADDRGP4 $1161
JUMPV
LABELV $1168
line 2340
;2340:	}
LABELV $1166
line 2342
;2341:	//if the bot can use the bfg
;2342:	if (bs->inventory[INVENTORY_BFG10K] > 0 &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1170
ADDRLP4 4
INDIRP4
CNSTI4 5056
ADDP4
INDIRI4
CNSTI4 7
LEI4 $1170
line 2343
;2343:			bs->inventory[INVENTORY_BFGAMMO] > 7) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1161
JUMPV
LABELV $1170
line 2345
;2344:	//if the bot can use the railgun
;2345:	if (bs->inventory[INVENTORY_RAILGUN] > 0 &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4992
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1172
ADDRLP4 8
INDIRP4
CNSTI4 5052
ADDP4
INDIRI4
CNSTI4 5
LEI4 $1172
line 2346
;2346:			bs->inventory[INVENTORY_SLUGS] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1161
JUMPV
LABELV $1172
line 2348
;2347:	//if the bot can use the lightning gun
;2348:	if (bs->inventory[INVENTORY_LIGHTNING] > 0 &&
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4988
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1174
ADDRLP4 12
INDIRP4
CNSTI4 5044
ADDP4
INDIRI4
CNSTI4 50
LEI4 $1174
line 2349
;2349:			bs->inventory[INVENTORY_LIGHTNINGAMMO] > 50) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1161
JUMPV
LABELV $1174
line 2351
;2350:	//if the bot can use the rocketlauncher
;2351:	if (bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 &&
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1176
ADDRLP4 16
INDIRP4
CNSTI4 5048
ADDP4
INDIRI4
CNSTI4 5
LEI4 $1176
line 2352
;2352:			bs->inventory[INVENTORY_ROCKETS] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1161
JUMPV
LABELV $1176
line 2354
;2353:	//
;2354:	if (bs->inventory[INVENTORY_NAILGUN] > 0 &&
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 5012
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1178
ADDRLP4 20
INDIRP4
CNSTI4 5060
ADDP4
INDIRI4
CNSTI4 5
LEI4 $1178
line 2355
;2355:			bs->inventory[INVENTORY_NAILS] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1161
JUMPV
LABELV $1178
line 2357
;2356:	//
;2357:	if (bs->inventory[INVENTORY_PROXLAUNCHER] > 0 &&
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 5016
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1180
ADDRLP4 24
INDIRP4
CNSTI4 5064
ADDP4
INDIRI4
CNSTI4 5
LEI4 $1180
line 2358
;2358:			bs->inventory[INVENTORY_MINES] > 5) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1161
JUMPV
LABELV $1180
line 2360
;2359:	//
;2360:	if (bs->inventory[INVENTORY_CHAINGUN] > 0 &&
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 5020
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1182
ADDRLP4 28
INDIRP4
CNSTI4 5068
ADDP4
INDIRI4
CNSTI4 40
LEI4 $1182
line 2361
;2361:			bs->inventory[INVENTORY_BELT] > 40) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1161
JUMPV
LABELV $1182
line 2363
;2362:	//if the bot can use the plasmagun
;2363:	if (bs->inventory[INVENTORY_PLASMAGUN] > 0 &&
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 4996
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1184
ADDRLP4 32
INDIRP4
CNSTI4 5040
ADDP4
INDIRI4
CNSTI4 20
LEI4 $1184
line 2364
;2364:			bs->inventory[INVENTORY_CELLS] > 20) return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1161
JUMPV
LABELV $1184
line 2365
;2365:	return qfalse;
CNSTI4 0
RETI4
LABELV $1161
endproc BotHasPersistantPowerupAndWeapon 36 0
export BotGoCamp
proc BotGoCamp 16 16
line 2373
;2366:}
;2367:
;2368:/*
;2369:==================
;2370:BotGoCamp
;2371:==================
;2372:*/
;2373:void BotGoCamp(bot_state_t *bs, bot_goal_t *goal) {
line 2376
;2374:	float camper;
;2375:
;2376:	bs->decisionmaker = bs->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 6608
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 2378
;2377:	//set message time to zero so bot will NOT show any message
;2378:	bs->teammessage_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6740
ADDP4
CNSTF4 0
ASGNF4
line 2380
;2379:	//set the ltg type
;2380:	bs->ltgtype = LTG_CAMP;
ADDRFP4 0
INDIRP4
CNSTI4 6600
ADDP4
CNSTI4 7
ASGNI4
line 2382
;2381:	//set the team goal
;2382:	memcpy(&bs->teamgoal, goal, sizeof(bot_goal_t));
ADDRFP4 0
INDIRP4
CNSTI4 6624
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2384
;2383:	//get the team goal time
;2384:	camper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CAMPER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 44
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 8
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 2385
;2385:	if (camper > 0.99) bs->teamgoal_time = FloatTime() + 99999;
ADDRLP4 0
INDIRF4
CNSTF4 1065185444
LEF4 $1187
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1203982208
ADDF4
ASGNF4
ADDRGP4 $1188
JUMPV
LABELV $1187
line 2386
;2386:	else bs->teamgoal_time = FloatTime() + 120 + 180 * camper + random() * 15;
ADDRLP4 12
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6744
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ADDRLP4 0
INDIRF4
CNSTF4 1127481344
MULF4
ADDF4
ADDRLP4 12
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 972030432
MULF4
ADDF4
ASGNF4
LABELV $1188
line 2388
;2387:	//set the last time the bot started camping
;2388:	bs->camp_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6184
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2390
;2389:	//the teammate that requested the camping
;2390:	bs->teammate = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6604
ADDP4
CNSTI4 0
ASGNI4
line 2392
;2391:	//do NOT type arrive message
;2392:	bs->arrive_time = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6172
ADDP4
CNSTF4 1065353216
ASGNF4
line 2393
;2393:}
LABELV $1186
endproc BotGoCamp 16 16
export BotWantsToCamp
proc BotWantsToCamp 172 16
line 2400
;2394:
;2395:/*
;2396:==================
;2397:BotWantsToCamp
;2398:==================
;2399:*/
;2400:int BotWantsToCamp(bot_state_t *bs) {
line 2405
;2401:	float camper;
;2402:	int cs, traveltime, besttraveltime;
;2403:	bot_goal_t goal, bestgoal;
;2404:
;2405:	camper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CAMPER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 44
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 128
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 124
ADDRLP4 128
INDIRF4
ASGNF4
line 2406
;2406:	if (camper < 0.1) return qfalse;
ADDRLP4 124
INDIRF4
CNSTF4 1036831949
GEF4 $1190
CNSTI4 0
RETI4
ADDRGP4 $1189
JUMPV
LABELV $1190
line 2408
;2407:	//if the bot has a team goal
;2408:	if (bs->ltgtype == LTG_TEAMHELP ||
ADDRLP4 132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 1
EQI4 $1200
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1200
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 3
EQI4 $1200
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 4
EQI4 $1200
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 5
EQI4 $1200
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 7
EQI4 $1200
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 8
EQI4 $1200
ADDRLP4 132
INDIRP4
CNSTI4 6600
ADDP4
INDIRI4
CNSTI4 9
NEI4 $1192
LABELV $1200
line 2415
;2409:			bs->ltgtype == LTG_TEAMACCOMPANY ||
;2410:			bs->ltgtype == LTG_DEFENDKEYAREA ||
;2411:			bs->ltgtype == LTG_GETFLAG ||
;2412:			bs->ltgtype == LTG_RUSHBASE ||
;2413:			bs->ltgtype == LTG_CAMP ||
;2414:			bs->ltgtype == LTG_CAMPORDER ||
;2415:			bs->ltgtype == LTG_PATROL) {
line 2416
;2416:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1189
JUMPV
LABELV $1192
line 2419
;2417:	}
;2418:	//if camped recently
;2419:	if (bs->camp_time > FloatTime() - 60 + 300 * (1-camper)) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6184
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1114636288
SUBF4
CNSTF4 1065353216
ADDRLP4 124
INDIRF4
SUBF4
CNSTF4 1133903872
MULF4
ADDF4
LEF4 $1201
CNSTI4 0
RETI4
ADDRGP4 $1189
JUMPV
LABELV $1201
line 2421
;2420:	//
;2421:	if (random() > camper) {
ADDRLP4 136
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ADDRLP4 124
INDIRF4
LEF4 $1203
line 2422
;2422:		bs->camp_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6184
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2423
;2423:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1189
JUMPV
LABELV $1203
line 2426
;2424:	}
;2425:	//if the bot isn't healthy anough
;2426:	if (BotAggression(bs) < 50) return qfalse;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotAggression
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 1112014848
GEF4 $1205
CNSTI4 0
RETI4
ADDRGP4 $1189
JUMPV
LABELV $1205
line 2428
;2427:	//the bot should have at least have the rocket launcher, the railgun or the bfg10k with some ammo
;2428:	if ((bs->inventory[INVENTORY_ROCKETLAUNCHER] <= 0 || bs->inventory[INVENTORY_ROCKETS] < 10) &&
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1209
ADDRLP4 144
INDIRP4
CNSTI4 5048
ADDP4
INDIRI4
CNSTI4 10
GEI4 $1207
LABELV $1209
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
CNSTI4 4992
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1210
ADDRLP4 148
INDIRP4
CNSTI4 5052
ADDP4
INDIRI4
CNSTI4 10
GEI4 $1207
LABELV $1210
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 152
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1211
ADDRLP4 152
INDIRP4
CNSTI4 5056
ADDP4
INDIRI4
CNSTI4 10
GEI4 $1207
LABELV $1211
line 2430
;2429:		(bs->inventory[INVENTORY_RAILGUN] <= 0 || bs->inventory[INVENTORY_SLUGS] < 10) &&
;2430:		(bs->inventory[INVENTORY_BFG10K] <= 0 || bs->inventory[INVENTORY_BFGAMMO] < 10)) {
line 2431
;2431:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1189
JUMPV
LABELV $1207
line 2434
;2432:	}
;2433:	//find the closest camp spot
;2434:	besttraveltime = 99999;
ADDRLP4 64
CNSTI4 99999
ASGNI4
line 2435
;2435:	for (cs = trap_BotGetNextCampSpotGoal(0, &goal); cs; cs = trap_BotGetNextCampSpotGoal(cs, &goal)) {
CNSTI4 0
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 156
ADDRGP4 trap_BotGetNextCampSpotGoal
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 156
INDIRI4
ASGNI4
ADDRGP4 $1215
JUMPV
LABELV $1212
line 2436
;2436:		traveltime = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, goal.areanum, TFL_DEFAULT);
ADDRLP4 160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 160
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 160
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 8+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 164
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 164
INDIRI4
ASGNI4
line 2437
;2437:		if (traveltime && traveltime < besttraveltime) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1217
ADDRLP4 0
INDIRI4
ADDRLP4 64
INDIRI4
GEI4 $1217
line 2438
;2438:			besttraveltime = traveltime;
ADDRLP4 64
ADDRLP4 0
INDIRI4
ASGNI4
line 2439
;2439:			memcpy(&bestgoal, &goal, sizeof(bot_goal_t));
ADDRLP4 68
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2440
;2440:		}
LABELV $1217
line 2441
;2441:	}
LABELV $1213
line 2435
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 160
ADDRGP4 trap_BotGetNextCampSpotGoal
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 160
INDIRI4
ASGNI4
LABELV $1215
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1212
line 2442
;2442:	if (besttraveltime > 150) return qfalse;
ADDRLP4 64
INDIRI4
CNSTI4 150
LEI4 $1219
CNSTI4 0
RETI4
ADDRGP4 $1189
JUMPV
LABELV $1219
line 2444
;2443:	//ok found a camp spot, go camp there
;2444:	BotGoCamp(bs, &bestgoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 BotGoCamp
CALLV
pop
line 2445
;2445:	bs->ordered = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6612
ADDP4
CNSTI4 0
ASGNI4
line 2447
;2446:	//
;2447:	return qtrue;
CNSTI4 1
RETI4
LABELV $1189
endproc BotWantsToCamp 172 16
export BotDontAvoid
proc BotDontAvoid 68 12
line 2455
;2448:}
;2449:
;2450:/*
;2451:==================
;2452:BotDontAvoid
;2453:==================
;2454:*/
;2455:void BotDontAvoid(bot_state_t *bs, char *itemname) {
line 2459
;2456:	bot_goal_t goal;
;2457:	int num;
;2458:
;2459:	num = trap_BotGetLevelItemGoal(-1, itemname, &goal);
CNSTI4 -1
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 60
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 60
INDIRI4
ASGNI4
ADDRGP4 $1223
JUMPV
LABELV $1222
line 2460
;2460:	while(num >= 0) {
line 2461
;2461:		trap_BotRemoveFromAvoidGoals(bs->gs, goal.number);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRLP4 4+44
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveFromAvoidGoals
CALLV
pop
line 2462
;2462:		num = trap_BotGetLevelItemGoal(num, itemname, &goal);
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 64
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 64
INDIRI4
ASGNI4
line 2463
;2463:	}
LABELV $1223
line 2460
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1222
line 2464
;2464:}
LABELV $1221
endproc BotDontAvoid 68 12
export BotGoForPowerups
proc BotGoForPowerups 0 8
line 2471
;2465:
;2466:/*
;2467:==================
;2468:BotGoForPowerups
;2469:==================
;2470:*/
;2471:void BotGoForPowerups(bot_state_t *bs) {
line 2474
;2472:
;2473:	//don't avoid any of the powerups anymore
;2474:	BotDontAvoid(bs, "Quad Damage");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1227
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2475
;2475:	BotDontAvoid(bs, "Regeneration");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1228
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2476
;2476:	BotDontAvoid(bs, "Battle Suit");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1229
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2477
;2477:	BotDontAvoid(bs, "Speed");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1230
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2478
;2478:	BotDontAvoid(bs, "Invisibility");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $1231
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 2482
;2479:	//BotDontAvoid(bs, "Flight");
;2480:	//reset the long term goal time so the bot will go for the powerup
;2481:	//NOTE: the long term goal type doesn't change
;2482:	bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6068
ADDP4
CNSTF4 0
ASGNF4
line 2483
;2483:}
LABELV $1226
endproc BotGoForPowerups 0 8
export BotRoamGoal
proc BotRoamGoal 168 28
line 2490
;2484:
;2485:/*
;2486:==================
;2487:BotRoamGoal
;2488:==================
;2489:*/
;2490:void BotRoamGoal(bot_state_t *bs, vec3_t goal) {
line 2496
;2491:	int pc, i;
;2492:	float len, rnd;
;2493:	vec3_t dir, bestorg, belowbestorg;
;2494:	bsp_trace_t trace;
;2495:
;2496:	for (i = 0; i < 10; i++) {
ADDRLP4 116
CNSTI4 0
ASGNI4
LABELV $1233
line 2498
;2497:		//start at the bot origin
;2498:		VectorCopy(bs->origin, bestorg);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 2499
;2499:		rnd = random();
ADDRLP4 136
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 112
ADDRLP4 136
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ASGNF4
line 2500
;2500:		if (rnd > 0.25) {
ADDRLP4 112
INDIRF4
CNSTF4 1048576000
LEF4 $1237
line 2502
;2501:			//add a random value to the x-coordinate
;2502:			if (random() < 0.5) bestorg[0] -= 800 * random() + 100;
ADDRLP4 140
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
GEF4 $1239
ADDRLP4 144
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 144
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1145569280
MULF4
CNSTF4 1120403456
ADDF4
SUBF4
ASGNF4
ADDRGP4 $1240
JUMPV
LABELV $1239
line 2503
;2503:			else bestorg[0] += 800 * random() + 100;
ADDRLP4 148
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 148
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1145569280
MULF4
CNSTF4 1120403456
ADDF4
ADDF4
ASGNF4
LABELV $1240
line 2504
;2504:		}
LABELV $1237
line 2505
;2505:		if (rnd < 0.75) {
ADDRLP4 112
INDIRF4
CNSTF4 1061158912
GEF4 $1241
line 2507
;2506:			//add a random value to the y-coordinate
;2507:			if (random() < 0.5) bestorg[1] -= 800 * random() + 100;
ADDRLP4 140
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
GEF4 $1243
ADDRLP4 144
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 144
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1145569280
MULF4
CNSTF4 1120403456
ADDF4
SUBF4
ASGNF4
ADDRGP4 $1244
JUMPV
LABELV $1243
line 2508
;2508:			else bestorg[1] += 800 * random() + 100;
ADDRLP4 148
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 148
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1145569280
MULF4
CNSTF4 1120403456
ADDF4
ADDF4
ASGNF4
LABELV $1244
line 2509
;2509:		}
LABELV $1241
line 2511
;2510:		//add a random value to the z-coordinate (NOTE: 48 = maxjump?)
;2511:		bestorg[2] += 2 * 48 * crandom();
ADDRLP4 140
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 140
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1119879168
MULF4
ADDF4
ASGNF4
line 2513
;2512:		//trace a line from the origin to the roam target
;2513:		BotAI_Trace(&trace, bs->origin, NULL, NULL, bestorg, bs->entitynum, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 144
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2515
;2514:		//direction and length towards the roam target
;2515:		VectorSubtract(trace.endpos, bs->origin, dir);
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 24+12
INDIRF4
ADDRLP4 148
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 24+12+4
INDIRF4
ADDRLP4 148
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 24+12+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2516
;2516:		len = VectorNormalize(dir);
ADDRLP4 0
ARGP4
ADDRLP4 152
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 108
ADDRLP4 152
INDIRF4
ASGNF4
line 2518
;2517:		//if the roam target is far away anough
;2518:		if (len > 200) {
ADDRLP4 108
INDIRF4
CNSTF4 1128792064
LEF4 $1255
line 2520
;2519:			//the roam target is in the given direction before walls
;2520:			VectorScale(dir, len * trace.fraction - 40, dir);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
CNSTF4 1109393408
SUBF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
CNSTF4 1109393408
SUBF4
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 108
INDIRF4
ADDRLP4 24+8
INDIRF4
MULF4
CNSTF4 1109393408
SUBF4
MULF4
ASGNF4
line 2521
;2521:			VectorAdd(bs->origin, dir, bestorg);
ADDRLP4 160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 160
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 160
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 0+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 0+8
INDIRF4
ADDF4
ASGNF4
line 2523
;2522:			//get the coordinates of the floor below the roam target
;2523:			belowbestorg[0] = bestorg[0];
ADDRLP4 120
ADDRLP4 12
INDIRF4
ASGNF4
line 2524
;2524:			belowbestorg[1] = bestorg[1];
ADDRLP4 120+4
ADDRLP4 12+4
INDIRF4
ASGNF4
line 2525
;2525:			belowbestorg[2] = bestorg[2] - 800;
ADDRLP4 120+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1145569280
SUBF4
ASGNF4
line 2526
;2526:			BotAI_Trace(&trace, bestorg, NULL, NULL, belowbestorg, bs->entitynum, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRLP4 12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 120
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2528
;2527:			//
;2528:			if (!trace.startsolid) {
ADDRLP4 24+4
INDIRI4
CNSTI4 0
NEI4 $1272
line 2529
;2529:				trace.endpos[2]++;
ADDRLP4 24+12+8
ADDRLP4 24+12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2530
;2530:				pc = trap_PointContents(trace.endpos, bs->entitynum);
ADDRLP4 24+12
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 164
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 132
ADDRLP4 164
INDIRI4
ASGNI4
line 2531
;2531:				if (!(pc & (CONTENTS_LAVA | CONTENTS_SLIME))) {
ADDRLP4 132
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
NEI4 $1278
line 2532
;2532:					VectorCopy(bestorg, goal);
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRB
ASGNB 12
line 2533
;2533:					return;
ADDRGP4 $1232
JUMPV
LABELV $1278
line 2535
;2534:				}
;2535:			}
LABELV $1272
line 2536
;2536:		}
LABELV $1255
line 2537
;2537:	}
LABELV $1234
line 2496
ADDRLP4 116
ADDRLP4 116
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 10
LTI4 $1233
line 2538
;2538:	VectorCopy(bestorg, goal);
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRB
ASGNB 12
line 2539
;2539:}
LABELV $1232
endproc BotRoamGoal 168 28
data
align 4
LABELV $1282
byte 4 0
byte 4 0
byte 4 1065353216
export BotAttackMove
code
proc BotAttackMove 392 16
line 2546
;2540:
;2541:/*
;2542:==================
;2543:BotAttackMove
;2544:==================
;2545:*/
;2546:bot_moveresult_t BotAttackMove(bot_state_t *bs, int tfl) {
line 2550
;2547:	int movetype, i, attackentity;
;2548:	float attack_skill, jumper, croucher, dist, strafechange_time;
;2549:	float attack_dist, attack_range;
;2550:	vec3_t forward, backward, sideward, hordir, up = {0, 0, 1};
ADDRLP4 56
ADDRGP4 $1282
INDIRB
ASGNB 12
line 2555
;2551:	aas_entityinfo_t entinfo;
;2552:	bot_moveresult_t moveresult;
;2553:	bot_goal_t goal;
;2554:
;2555:	attackentity = bs->enemy;
ADDRLP4 332
ADDRFP4 4
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ASGNI4
line 2557
;2556:	//
;2557:	if (bs->attackchase_time > FloatTime()) {
ADDRFP4 4
INDIRP4
CNSTI4 6124
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $1283
line 2559
;2558:		//create the chase goal
;2559:		goal.entitynum = attackentity;
ADDRLP4 136+40
ADDRLP4 332
INDIRI4
ASGNI4
line 2560
;2560:		goal.areanum = bs->lastenemyareanum;
ADDRLP4 136+12
ADDRFP4 4
INDIRP4
CNSTI4 6544
ADDP4
INDIRI4
ASGNI4
line 2561
;2561:		VectorCopy(bs->lastenemyorigin, goal.origin);
ADDRLP4 136
ADDRFP4 4
INDIRP4
CNSTI4 6548
ADDP4
INDIRB
ASGNB 12
line 2562
;2562:		VectorSet(goal.mins, -8, -8, -8);
ADDRLP4 136+16
CNSTF4 3238002688
ASGNF4
ADDRLP4 136+16+4
CNSTF4 3238002688
ASGNF4
ADDRLP4 136+16+8
CNSTF4 3238002688
ASGNF4
line 2563
;2563:		VectorSet(goal.maxs, 8, 8, 8);
ADDRLP4 136+28
CNSTF4 1090519040
ASGNF4
ADDRLP4 136+28+4
CNSTF4 1090519040
ASGNF4
ADDRLP4 136+28+8
CNSTF4 1090519040
ASGNF4
line 2565
;2564:		//initialize the movement state
;2565:		BotSetupForMovement(bs);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 2567
;2566:		//move towards the goal
;2567:		trap_BotMoveToGoal(&moveresult, bs->ms, &goal, tfl);
ADDRLP4 80
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 136
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveToGoal
CALLV
pop
line 2568
;2568:		return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $1280
JUMPV
LABELV $1283
line 2571
;2569:	}
;2570:	//
;2571:	memset(&moveresult, 0, sizeof(bot_moveresult_t));
ADDRLP4 80
ARGP4
CNSTI4 0
ARGI4
CNSTI4 52
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2573
;2572:	//
;2573:	attack_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ATTACK_SKILL, 0, 1);
ADDRFP4 4
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 348
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 132
ADDRLP4 348
INDIRF4
ASGNF4
line 2574
;2574:	jumper = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_JUMPER, 0, 1);
ADDRFP4 4
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 37
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 352
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 340
ADDRLP4 352
INDIRF4
ASGNF4
line 2575
;2575:	croucher = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CROUCHER, 0, 1);
ADDRFP4 4
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 36
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 356
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 344
ADDRLP4 356
INDIRF4
ASGNF4
line 2577
;2576:	//if the bot is really stupid
;2577:	if (attack_skill < 0.2) return moveresult;
ADDRLP4 132
INDIRF4
CNSTF4 1045220557
GEF4 $1297
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $1280
JUMPV
LABELV $1297
line 2579
;2578:	//initialize the movement state
;2579:	BotSetupForMovement(bs);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotSetupForMovement
CALLV
pop
line 2581
;2580:	//get the enemy entity info
;2581:	BotEntityInfo(attackentity, &entinfo);
ADDRLP4 332
INDIRI4
ARGI4
ADDRLP4 192
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2583
;2582:	//direction towards the enemy
;2583:	VectorSubtract(entinfo.origin, bs->origin, forward);
ADDRLP4 360
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 192+24
INDIRF4
ADDRLP4 360
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 192+24+4
INDIRF4
ADDRLP4 360
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 192+24+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2585
;2584:	//the distance towards the enemy
;2585:	dist = VectorNormalize(forward);
ADDRLP4 24
ARGP4
ADDRLP4 364
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 68
ADDRLP4 364
INDIRF4
ASGNF4
line 2586
;2586:	VectorNegate(forward, backward);
ADDRLP4 36
ADDRLP4 24
INDIRF4
NEGF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 24+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 36+8
ADDRLP4 24+8
INDIRF4
NEGF4
ASGNF4
line 2588
;2587:	//walk, crouch or jump
;2588:	movetype = MOVE_WALK;
ADDRLP4 52
CNSTI4 1
ASGNI4
line 2590
;2589:	//
;2590:	if (bs->attackcrouch_time < FloatTime() - 1) {
ADDRFP4 4
INDIRP4
CNSTI4 6120
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $1310
line 2591
;2591:		if (random() < jumper) {
ADDRLP4 368
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ADDRLP4 340
INDIRF4
GEF4 $1312
line 2592
;2592:			movetype = MOVE_JUMP;
ADDRLP4 52
CNSTI4 4
ASGNI4
line 2593
;2593:		}
ADDRGP4 $1313
JUMPV
LABELV $1312
line 2595
;2594:		//wait at least one second before crouching again
;2595:		else if (bs->attackcrouch_time < FloatTime() - 1 && random() < croucher) {
ADDRFP4 4
INDIRP4
CNSTI4 6120
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $1314
ADDRLP4 372
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 372
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ADDRLP4 344
INDIRF4
GEF4 $1314
line 2596
;2596:			bs->attackcrouch_time = FloatTime() + croucher * 5;
ADDRFP4 4
INDIRP4
CNSTI4 6120
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 344
INDIRF4
CNSTF4 1084227584
MULF4
ADDF4
ASGNF4
line 2597
;2597:		}
LABELV $1314
LABELV $1313
line 2598
;2598:	}
LABELV $1310
line 2599
;2599:	if (bs->attackcrouch_time > FloatTime()) movetype = MOVE_CROUCH;
ADDRFP4 4
INDIRP4
CNSTI4 6120
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $1316
ADDRLP4 52
CNSTI4 2
ASGNI4
LABELV $1316
line 2601
;2600:	//if the bot should jump
;2601:	if (movetype == MOVE_JUMP) {
ADDRLP4 52
INDIRI4
CNSTI4 4
NEI4 $1318
line 2603
;2602:		//if jumped last frame
;2603:		if (bs->attackjump_time > FloatTime()) {
ADDRFP4 4
INDIRP4
CNSTI4 6128
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $1320
line 2604
;2604:			movetype = MOVE_WALK;
ADDRLP4 52
CNSTI4 1
ASGNI4
line 2605
;2605:		}
ADDRGP4 $1321
JUMPV
LABELV $1320
line 2606
;2606:		else {
line 2607
;2607:			bs->attackjump_time = FloatTime() + 1;
ADDRFP4 4
INDIRP4
CNSTI4 6128
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2608
;2608:		}
LABELV $1321
line 2609
;2609:	}
LABELV $1318
line 2610
;2610:	if (bs->cur_ps.weapon == WP_GAUNTLET) {
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1322
line 2611
;2611:		attack_dist = 0;
ADDRLP4 72
CNSTF4 0
ASGNF4
line 2612
;2612:		attack_range = 0;
ADDRLP4 76
CNSTF4 0
ASGNF4
line 2613
;2613:	}
ADDRGP4 $1323
JUMPV
LABELV $1322
line 2614
;2614:	else {
line 2615
;2615:		attack_dist = IDEAL_ATTACKDIST;
ADDRLP4 72
CNSTF4 1124859904
ASGNF4
line 2616
;2616:		attack_range = 40;
ADDRLP4 76
CNSTF4 1109393408
ASGNF4
line 2617
;2617:	}
LABELV $1323
line 2619
;2618:	//if the bot is stupid
;2619:	if (attack_skill <= 0.4) {
ADDRLP4 132
INDIRF4
CNSTF4 1053609165
GTF4 $1324
line 2621
;2620:		//just walk to or away from the enemy
;2621:		if (dist > attack_dist + attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
ADDF4
LEF4 $1326
line 2622
;2622:			if (trap_BotMoveInDirection(bs->ms, forward, 400, movetype)) return moveresult;
ADDRFP4 4
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 368
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
EQI4 $1328
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $1280
JUMPV
LABELV $1328
line 2623
;2623:		}
LABELV $1326
line 2624
;2624:		if (dist < attack_dist - attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
SUBF4
GEF4 $1330
line 2625
;2625:			if (trap_BotMoveInDirection(bs->ms, backward, 400, movetype)) return moveresult;
ADDRFP4 4
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 368
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
EQI4 $1332
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $1280
JUMPV
LABELV $1332
line 2626
;2626:		}
LABELV $1330
line 2627
;2627:		return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $1280
JUMPV
LABELV $1324
line 2630
;2628:	}
;2629:	//increase the strafe time
;2630:	bs->attackstrafe_time += bs->thinktime;
ADDRLP4 368
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 372
ADDRLP4 368
INDIRP4
CNSTI4 6116
ADDP4
ASGNP4
ADDRLP4 372
INDIRP4
ADDRLP4 372
INDIRP4
INDIRF4
ADDRLP4 368
INDIRP4
CNSTI4 4904
ADDP4
INDIRF4
ADDF4
ASGNF4
line 2632
;2631:	//get the strafe change time
;2632:	strafechange_time = 0.4 + (1 - attack_skill) * 0.2;
ADDRLP4 336
CNSTF4 1065353216
ADDRLP4 132
INDIRF4
SUBF4
CNSTF4 1045220557
MULF4
CNSTF4 1053609165
ADDF4
ASGNF4
line 2633
;2633:	if (attack_skill > 0.7) strafechange_time += crandom() * 0.2;
ADDRLP4 132
INDIRF4
CNSTF4 1060320051
LEF4 $1334
ADDRLP4 376
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 336
ADDRLP4 336
INDIRF4
ADDRLP4 376
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1053609165
MULF4
ADDF4
ASGNF4
LABELV $1334
line 2635
;2634:	//if the strafe direction should be changed
;2635:	if (bs->attackstrafe_time > strafechange_time) {
ADDRFP4 4
INDIRP4
CNSTI4 6116
ADDP4
INDIRF4
ADDRLP4 336
INDIRF4
LEF4 $1336
line 2637
;2636:		//some magic number :)
;2637:		if (random() > 0.935) {
ADDRLP4 380
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 380
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1064262697
LEF4 $1338
line 2639
;2638:			//flip the strafe direction
;2639:			bs->flags ^= BFL_STRAFERIGHT;
ADDRLP4 384
ADDRFP4 4
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 384
INDIRP4
ADDRLP4 384
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 2640
;2640:			bs->attackstrafe_time = 0;
ADDRFP4 4
INDIRP4
CNSTI4 6116
ADDP4
CNSTF4 0
ASGNF4
line 2641
;2641:		}
LABELV $1338
line 2642
;2642:	}
LABELV $1336
line 2644
;2643:	//
;2644:	for (i = 0; i < 2; i++) {
ADDRLP4 48
CNSTI4 0
ASGNI4
LABELV $1340
line 2645
;2645:		hordir[0] = forward[0];
ADDRLP4 12
ADDRLP4 24
INDIRF4
ASGNF4
line 2646
;2646:		hordir[1] = forward[1];
ADDRLP4 12+4
ADDRLP4 24+4
INDIRF4
ASGNF4
line 2647
;2647:		hordir[2] = 0;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 2648
;2648:		VectorNormalize(hordir);
ADDRLP4 12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 2650
;2649:		//get the sideward vector
;2650:		CrossProduct(hordir, up, sideward);
ADDRLP4 12
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 2652
;2651:		//reverse the vector depending on the strafe direction
;2652:		if (bs->flags & BFL_STRAFERIGHT) VectorNegate(sideward, sideward);
ADDRFP4 4
INDIRP4
CNSTI4 5980
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1347
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
NEGF4
ASGNF4
LABELV $1347
line 2654
;2653:		//randomly go back a little
;2654:		if (random() > 0.9) {
ADDRLP4 380
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 380
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1063675494
LEF4 $1353
line 2655
;2655:			VectorAdd(sideward, backward, sideward);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
ASGNF4
line 2656
;2656:		}
ADDRGP4 $1354
JUMPV
LABELV $1353
line 2657
;2657:		else {
line 2659
;2658:			//walk forward or backward to get at the ideal attack distance
;2659:			if (dist > attack_dist + attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
ADDF4
LEF4 $1361
line 2660
;2660:				VectorAdd(sideward, forward, sideward);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDF4
ASGNF4
line 2661
;2661:			}
ADDRGP4 $1362
JUMPV
LABELV $1361
line 2662
;2662:			else if (dist < attack_dist - attack_range) {
ADDRLP4 68
INDIRF4
ADDRLP4 72
INDIRF4
ADDRLP4 76
INDIRF4
SUBF4
GEF4 $1369
line 2663
;2663:				VectorAdd(sideward, backward, sideward);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
ASGNF4
line 2664
;2664:			}
LABELV $1369
LABELV $1362
line 2665
;2665:		}
LABELV $1354
line 2667
;2666:		//perform the movement
;2667:		if (trap_BotMoveInDirection(bs->ms, sideward, 400, movetype))
ADDRFP4 4
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 384
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 384
INDIRI4
CNSTI4 0
EQI4 $1377
line 2668
;2668:			return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
ADDRGP4 $1280
JUMPV
LABELV $1377
line 2670
;2669:		//movement failed, flip the strafe direction
;2670:		bs->flags ^= BFL_STRAFERIGHT;
ADDRLP4 388
ADDRFP4 4
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 388
INDIRP4
ADDRLP4 388
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 2671
;2671:		bs->attackstrafe_time = 0;
ADDRFP4 4
INDIRP4
CNSTI4 6116
ADDP4
CNSTF4 0
ASGNF4
line 2672
;2672:	}
LABELV $1341
line 2644
ADDRLP4 48
ADDRLP4 48
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 2
LTI4 $1340
line 2675
;2673:	//bot couldn't do any usefull movement
;2674://	bs->attackchase_time = AAS_Time() + 6;
;2675:	return moveresult;
ADDRFP4 0
INDIRP4
ADDRLP4 80
INDIRB
ASGNB 52
LABELV $1280
endproc BotAttackMove 392 16
export BotSameTeam
proc BotSameTeam 0 0
line 2683
;2676:}
;2677:
;2678:/*
;2679:==================
;2680:BotSameTeam
;2681:==================
;2682:*/
;2683:int BotSameTeam(bot_state_t *bs, int entnum) {
line 2687
;2684:
;2685:	extern gclient_t g_clients[ MAX_CLIENTS ];
;2686:
;2687:	if ( (unsigned) bs->client >= MAX_CLIENTS ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CVIU4 4
CNSTU4 64
LTU4 $1380
line 2689
;2688:		//BotAI_Print(PRT_ERROR, "BotSameTeam: client out of range\n");
;2689:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1379
JUMPV
LABELV $1380
line 2691
;2690:	}
;2691:	if ( (unsigned) entnum >= MAX_CLIENTS ) {
ADDRFP4 4
INDIRI4
CVIU4 4
CNSTU4 64
LTU4 $1382
line 2693
;2692:		//BotAI_Print(PRT_ERROR, "BotSameTeam: client out of range\n");
;2693:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1379
JUMPV
LABELV $1382
line 2695
;2694:	}
;2695:	if ( gametype >= GT_TEAM ) {
ADDRGP4 gametype
INDIRI4
CNSTI4 3
LTI4 $1384
line 2696
;2696:		if ( g_clients[bs->client].sess.sessionTeam == g_clients[entnum].sess.sessionTeam )
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 g_clients+616
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 g_clients+616
ADDP4
INDIRI4
NEI4 $1386
line 2697
;2697:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1379
JUMPV
LABELV $1386
line 2698
;2698:	}
LABELV $1384
line 2699
;2699:	return qfalse;
CNSTI4 0
RETI4
LABELV $1379
endproc BotSameTeam 0 0
export InFieldOfVision
proc InFieldOfVision 28 4
line 2708
;2700:}
;2701:
;2702:/*
;2703:==================
;2704:InFieldOfVision
;2705:==================
;2706:*/
;2707:qboolean InFieldOfVision(vec3_t viewangles, float fov, vec3_t angles)
;2708:{
line 2712
;2709:	int i;
;2710:	float diff, angle;
;2711:
;2712:	for (i = 0; i < 2; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1391
line 2713
;2713:		angle = AngleMod(viewangles[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 12
INDIRF4
ASGNF4
line 2714
;2714:		angles[i] = AngleMod(angles[i]);
ADDRLP4 20
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
ADDP4
ADDRLP4 24
INDIRF4
ASGNF4
line 2715
;2715:		diff = angles[i] - angle;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
ASGNF4
line 2716
;2716:		if (angles[i] > angle) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $1395
line 2717
;2717:			if (diff > 180.0) diff -= 360.0;
ADDRLP4 4
INDIRF4
CNSTF4 1127481344
LEF4 $1396
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 2718
;2718:		}
ADDRGP4 $1396
JUMPV
LABELV $1395
line 2719
;2719:		else {
line 2720
;2720:			if (diff < -180.0) diff += 360.0;
ADDRLP4 4
INDIRF4
CNSTF4 3274964992
GEF4 $1399
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $1399
line 2721
;2721:		}
LABELV $1396
line 2722
;2722:		if (diff > 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $1401
line 2723
;2723:			if (diff > fov * 0.5) return qfalse;
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRF4
CNSTF4 1056964608
MULF4
LEF4 $1402
CNSTI4 0
RETI4
ADDRGP4 $1390
JUMPV
line 2724
;2724:		}
LABELV $1401
line 2725
;2725:		else {
line 2726
;2726:			if (diff < -fov * 0.5) return qfalse;
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRF4
NEGF4
CNSTF4 1056964608
MULF4
GEF4 $1405
CNSTI4 0
RETI4
ADDRGP4 $1390
JUMPV
LABELV $1405
line 2727
;2727:		}
LABELV $1402
line 2728
;2728:	}
LABELV $1392
line 2712
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $1391
line 2729
;2729:	return qtrue;
CNSTI4 1
RETI4
LABELV $1390
endproc InFieldOfVision 28 4
export BotEntityVisible
proc BotEntityVisible 360 28
line 2739
;2730:}
;2731:
;2732:/*
;2733:==================
;2734:BotEntityVisible
;2735:
;2736:returns visibility in the range [0, 1] taking fog and water surfaces into account
;2737:==================
;2738:*/
;2739:float BotEntityVisible(int viewer, vec3_t eye, vec3_t viewangles, float fov, int ent) {
line 2747
;2740:	int i, contents_mask, passent, hitent, infog, inwater, otherinfog, pc;
;2741:	float squaredfogdist, waterfactor, vis, bestvis;
;2742:	bsp_trace_t trace;
;2743:	aas_entityinfo_t entinfo;
;2744:	vec3_t dir, entangles, start, end, middle;
;2745:
;2746:	//calculate middle of bounding box
;2747:	BotEntityInfo(ent, &entinfo);
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 148
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2748
;2748:	if (!entinfo.valid)
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1408
line 2749
;2749:		return 0;
CNSTF4 0
RETF4
ADDRGP4 $1407
JUMPV
LABELV $1408
line 2750
;2750:	VectorAdd(entinfo.mins, entinfo.maxs, middle);
ADDRLP4 84
ADDRLP4 148+72
INDIRF4
ADDRLP4 148+84
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 148+72+4
INDIRF4
ADDRLP4 148+84+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+8
ADDRLP4 148+72+8
INDIRF4
ADDRLP4 148+84+8
INDIRF4
ADDF4
ASGNF4
line 2751
;2751:	VectorScale(middle, 0.5, middle);
ADDRLP4 84
ADDRLP4 84
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 84+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 84+8
ADDRLP4 84+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 2752
;2752:	VectorAdd(entinfo.origin, middle, middle);
ADDRLP4 84
ADDRLP4 148+24
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+4
ADDRLP4 148+24+4
INDIRF4
ADDRLP4 84+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84+8
ADDRLP4 148+24+8
INDIRF4
ADDRLP4 84+8
INDIRF4
ADDF4
ASGNF4
line 2754
;2753:	//check if entity is within field of vision
;2754:	VectorSubtract(middle, eye, dir);
ADDRLP4 332
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
ADDRLP4 84
INDIRF4
ADDRLP4 332
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 84+4
INDIRF4
ADDRLP4 332
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRLP4 84+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2755
;2755:	vectoangles(dir, entangles);
ADDRLP4 136
ARGP4
ADDRLP4 320
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2756
;2756:	if (!InFieldOfVision(viewangles, fov, entangles)) return 0;
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 320
ARGP4
ADDRLP4 336
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 336
INDIRI4
CNSTI4 0
NEI4 $1439
CNSTF4 0
RETF4
ADDRGP4 $1407
JUMPV
LABELV $1439
line 2758
;2757:	//
;2758:	pc = trap_AAS_PointContents(eye);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 340
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 316
ADDRLP4 340
INDIRI4
ASGNI4
line 2759
;2759:	infog = (pc & CONTENTS_FOG);
ADDRLP4 312
ADDRLP4 316
INDIRI4
CNSTI4 64
BANDI4
ASGNI4
line 2760
;2760:	inwater = (pc & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER));
ADDRLP4 308
ADDRLP4 316
INDIRI4
CNSTI4 56
BANDI4
ASGNI4
line 2762
;2761:	//
;2762:	bestvis = 0;
ADDRLP4 296
CNSTF4 0
ASGNF4
line 2763
;2763:	for (i = 0; i < 3; i++) {
ADDRLP4 100
CNSTI4 0
ASGNI4
LABELV $1441
line 2767
;2764:		//if the point is not in potential visible sight
;2765:		//if (!AAS_inPVS(eye, middle)) continue;
;2766:		//
;2767:		contents_mask = CONTENTS_SOLID|CONTENTS_PLAYERCLIP;
ADDRLP4 96
CNSTI4 65537
ASGNI4
line 2768
;2768:		passent = viewer;
ADDRLP4 116
ADDRFP4 0
INDIRI4
ASGNI4
line 2769
;2769:		hitent = ent;
ADDRLP4 132
ADDRFP4 16
INDIRI4
ASGNI4
line 2770
;2770:		VectorCopy(eye, start);
ADDRLP4 120
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2771
;2771:		VectorCopy(middle, end);
ADDRLP4 104
ADDRLP4 84
INDIRB
ASGNB 12
line 2773
;2772:		//if the entity is in water, lava or slime
;2773:		if (trap_AAS_PointContents(middle) & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER)) {
ADDRLP4 84
ARGP4
ADDRLP4 344
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 344
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $1445
line 2774
;2774:			contents_mask |= (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER);
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 56
BORI4
ASGNI4
line 2775
;2775:		}
LABELV $1445
line 2777
;2776:		//if eye is in water, lava or slime
;2777:		if (inwater) {
ADDRLP4 308
INDIRI4
CNSTI4 0
EQI4 $1447
line 2778
;2778:			if (!(contents_mask & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER))) {
ADDRLP4 96
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
NEI4 $1449
line 2779
;2779:				passent = ent;
ADDRLP4 116
ADDRFP4 16
INDIRI4
ASGNI4
line 2780
;2780:				hitent = viewer;
ADDRLP4 132
ADDRFP4 0
INDIRI4
ASGNI4
line 2781
;2781:				VectorCopy(middle, start);
ADDRLP4 120
ADDRLP4 84
INDIRB
ASGNB 12
line 2782
;2782:				VectorCopy(eye, end);
ADDRLP4 104
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 2783
;2783:			}
LABELV $1449
line 2784
;2784:			contents_mask ^= (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER);
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 56
BXORI4
ASGNI4
line 2785
;2785:		}
LABELV $1447
line 2787
;2786:		//trace from start to end
;2787:		BotAI_Trace(&trace, start, NULL, NULL, end, passent, contents_mask);
ADDRLP4 0
ARGP4
ADDRLP4 120
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 116
INDIRI4
ARGI4
ADDRLP4 96
INDIRI4
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2789
;2788:		//if water was hit
;2789:		waterfactor = 1.0;
ADDRLP4 288
CNSTF4 1065353216
ASGNF4
line 2790
;2790:		if (trace.contents & (CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER)) {
ADDRLP4 0+76
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $1451
line 2792
;2791:			//if the water surface is translucent
;2792:			if (1) {
line 2794
;2793:				//trace through the water
;2794:				contents_mask &= ~(CONTENTS_LAVA|CONTENTS_SLIME|CONTENTS_WATER);
ADDRLP4 96
ADDRLP4 96
INDIRI4
CNSTI4 -57
BANDI4
ASGNI4
line 2795
;2795:				BotAI_Trace(&trace, trace.endpos, NULL, NULL, end, passent, contents_mask);
ADDRLP4 0
ARGP4
ADDRLP4 0+12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 116
INDIRI4
ARGI4
ADDRLP4 96
INDIRI4
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2796
;2796:				waterfactor = 0.5;
ADDRLP4 288
CNSTF4 1056964608
ASGNF4
line 2797
;2797:			}
LABELV $1454
line 2798
;2798:		}
LABELV $1451
line 2800
;2799:		//if a full trace or the hitent was hit
;2800:		if (trace.fraction >= 1 || trace.ent == hitent) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
GEF4 $1461
ADDRLP4 0+80
INDIRI4
ADDRLP4 132
INDIRI4
NEI4 $1457
LABELV $1461
line 2803
;2801:			//check for fog, assuming there's only one fog brush where
;2802:			//either the viewer or the entity is in or both are in
;2803:			otherinfog = (trap_AAS_PointContents(middle) & CONTENTS_FOG);
ADDRLP4 84
ARGP4
ADDRLP4 348
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 304
ADDRLP4 348
INDIRI4
CNSTI4 64
BANDI4
ASGNI4
line 2804
;2804:			if (infog && otherinfog) {
ADDRLP4 312
INDIRI4
CNSTI4 0
EQI4 $1462
ADDRLP4 304
INDIRI4
CNSTI4 0
EQI4 $1462
line 2805
;2805:				VectorSubtract(trace.endpos, eye, dir);
ADDRLP4 352
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
ADDRLP4 0+12
INDIRF4
ADDRLP4 352
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 0+12+4
INDIRF4
ADDRLP4 352
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRLP4 0+12+8
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2806
;2806:				squaredfogdist = VectorLengthSquared(dir);
ADDRLP4 136
ARGP4
ADDRLP4 356
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 300
ADDRLP4 356
INDIRF4
ASGNF4
line 2807
;2807:			}
ADDRGP4 $1463
JUMPV
LABELV $1462
line 2808
;2808:			else if (infog) {
ADDRLP4 312
INDIRI4
CNSTI4 0
EQI4 $1471
line 2809
;2809:				VectorCopy(trace.endpos, start);
ADDRLP4 120
ADDRLP4 0+12
INDIRB
ASGNB 12
line 2810
;2810:				BotAI_Trace(&trace, start, NULL, NULL, eye, viewer, CONTENTS_FOG);
ADDRLP4 0
ARGP4
ADDRLP4 120
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2811
;2811:				VectorSubtract(eye, trace.endpos, dir);
ADDRLP4 352
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
ADDRLP4 352
INDIRP4
INDIRF4
ADDRLP4 0+12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 352
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0+12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0+12+8
INDIRF4
SUBF4
ASGNF4
line 2812
;2812:				squaredfogdist = VectorLengthSquared(dir);
ADDRLP4 136
ARGP4
ADDRLP4 356
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 300
ADDRLP4 356
INDIRF4
ASGNF4
line 2813
;2813:			}
ADDRGP4 $1472
JUMPV
LABELV $1471
line 2814
;2814:			else if (otherinfog) {
ADDRLP4 304
INDIRI4
CNSTI4 0
EQI4 $1481
line 2815
;2815:				VectorCopy(trace.endpos, end);
ADDRLP4 104
ADDRLP4 0+12
INDIRB
ASGNB 12
line 2816
;2816:				BotAI_Trace(&trace, eye, NULL, NULL, end, viewer, CONTENTS_FOG);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 104
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2817
;2817:				VectorSubtract(end, trace.endpos, dir);
ADDRLP4 136
ADDRLP4 104
INDIRF4
ADDRLP4 0+12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+4
ADDRLP4 104+4
INDIRF4
ADDRLP4 0+12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 136+8
ADDRLP4 104+8
INDIRF4
ADDRLP4 0+12+8
INDIRF4
SUBF4
ASGNF4
line 2818
;2818:				squaredfogdist = VectorLengthSquared(dir);
ADDRLP4 136
ARGP4
ADDRLP4 352
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 300
ADDRLP4 352
INDIRF4
ASGNF4
line 2819
;2819:			}
ADDRGP4 $1482
JUMPV
LABELV $1481
line 2820
;2820:			else {
line 2822
;2821:				//if the entity and the viewer are not in fog assume there's no fog in between
;2822:				squaredfogdist = 0;
ADDRLP4 300
CNSTF4 0
ASGNF4
line 2823
;2823:			}
LABELV $1482
LABELV $1472
LABELV $1463
line 2825
;2824:			//decrease visibility with the view distance through fog
;2825:			vis = 1 / ((squaredfogdist * 0.001) < 1 ? 1 : (squaredfogdist * 0.001));
ADDRLP4 300
INDIRF4
CNSTF4 981668463
MULF4
CNSTF4 1065353216
GEF4 $1494
ADDRLP4 352
CNSTF4 1065353216
ASGNF4
ADDRGP4 $1495
JUMPV
LABELV $1494
ADDRLP4 352
ADDRLP4 300
INDIRF4
CNSTF4 981668463
MULF4
ASGNF4
LABELV $1495
ADDRLP4 292
CNSTF4 1065353216
ADDRLP4 352
INDIRF4
DIVF4
ASGNF4
line 2827
;2826:			//if entering water visibility is reduced
;2827:			vis *= waterfactor;
ADDRLP4 292
ADDRLP4 292
INDIRF4
ADDRLP4 288
INDIRF4
MULF4
ASGNF4
line 2829
;2828:			//
;2829:			if (vis > bestvis) bestvis = vis;
ADDRLP4 292
INDIRF4
ADDRLP4 296
INDIRF4
LEF4 $1496
ADDRLP4 296
ADDRLP4 292
INDIRF4
ASGNF4
LABELV $1496
line 2831
;2830:			//if pretty much no fog
;2831:			if (bestvis >= 0.95) return bestvis;
ADDRLP4 296
INDIRF4
CNSTF4 1064514355
LTF4 $1498
ADDRLP4 296
INDIRF4
RETF4
ADDRGP4 $1407
JUMPV
LABELV $1498
line 2832
;2832:		}
LABELV $1457
line 2834
;2833:		//check bottom and top of bounding box as well
;2834:		if (i == 0) middle[2] += entinfo.mins[2];
ADDRLP4 100
INDIRI4
CNSTI4 0
NEI4 $1500
ADDRLP4 84+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 148+72+8
INDIRF4
ADDF4
ASGNF4
ADDRGP4 $1501
JUMPV
LABELV $1500
line 2835
;2835:		else if (i == 1) middle[2] += entinfo.maxs[2] - entinfo.mins[2];
ADDRLP4 100
INDIRI4
CNSTI4 1
NEI4 $1505
ADDRLP4 84+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 148+84+8
INDIRF4
ADDRLP4 148+72+8
INDIRF4
SUBF4
ADDF4
ASGNF4
LABELV $1505
LABELV $1501
line 2836
;2836:	}
LABELV $1442
line 2763
ADDRLP4 100
ADDRLP4 100
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 3
LTI4 $1441
line 2837
;2837:	return bestvis;
ADDRLP4 296
INDIRF4
RETF4
LABELV $1407
endproc BotEntityVisible 360 28
export BotFindEnemy
proc BotFindEnemy 464 28
line 2845
;2838:}
;2839:
;2840:/*
;2841:==================
;2842:BotFindEnemy
;2843:==================
;2844:*/
;2845:int BotFindEnemy(bot_state_t *bs, int curenemy) {
line 2852
;2846:	int i, healthdecrease;
;2847:	float f, alertness, easyfragger, vis;
;2848:	float squaredist, cursquaredist;
;2849:	aas_entityinfo_t entinfo, curenemyinfo;
;2850:	vec3_t dir, angles;
;2851:
;2852:	alertness = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_ALERTNESS, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 46
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 336
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 164
ADDRLP4 336
INDIRF4
ASGNF4
line 2853
;2853:	easyfragger = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_EASY_FRAGGER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 45
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 340
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 176
ADDRLP4 340
INDIRF4
ASGNF4
line 2855
;2854:	//check if the health decreased
;2855:	healthdecrease = bs->lasthealth > bs->inventory[INVENTORY_HEALTH];
ADDRLP4 348
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 348
INDIRP4
CNSTI4 5988
ADDP4
INDIRI4
ADDRLP4 348
INDIRP4
CNSTI4 5080
ADDP4
INDIRI4
LEI4 $1514
ADDRLP4 344
CNSTI4 1
ASGNI4
ADDRGP4 $1515
JUMPV
LABELV $1514
ADDRLP4 344
CNSTI4 0
ASGNI4
LABELV $1515
ADDRLP4 160
ADDRLP4 344
INDIRI4
ASGNI4
line 2857
;2856:	//remember the current health value
;2857:	bs->lasthealth = bs->inventory[INVENTORY_HEALTH];
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 352
INDIRP4
CNSTI4 5988
ADDP4
ADDRLP4 352
INDIRP4
CNSTI4 5080
ADDP4
INDIRI4
ASGNI4
line 2859
;2858:	//
;2859:	if (curenemy >= 0) {
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $1516
line 2860
;2860:		BotEntityInfo(curenemy, &curenemyinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 196
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2861
;2861:		if (EntityCarriesFlag(&curenemyinfo)) return qfalse;
ADDRLP4 196
ARGP4
ADDRLP4 356
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 356
INDIRI4
CNSTI4 0
EQI4 $1518
CNSTI4 0
RETI4
ADDRGP4 $1512
JUMPV
LABELV $1518
line 2862
;2862:		VectorSubtract(curenemyinfo.origin, bs->origin, dir);
ADDRLP4 360
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 196+24
INDIRF4
ADDRLP4 360
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 196+24+4
INDIRF4
ADDRLP4 360
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 196+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2863
;2863:		cursquaredist = VectorLengthSquared(dir);
ADDRLP4 144
ARGP4
ADDRLP4 364
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 192
ADDRLP4 364
INDIRF4
ASGNF4
line 2864
;2864:	}
ADDRGP4 $1517
JUMPV
LABELV $1516
line 2865
;2865:	else {
line 2866
;2866:		cursquaredist = 0;
ADDRLP4 192
CNSTF4 0
ASGNF4
line 2867
;2867:	}
LABELV $1517
line 2869
;2868:
;2869:	if (gametype == GT_OBELISK) {
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $1527
line 2874
;2870:		vec3_t target;
;2871:		bot_goal_t *goal;
;2872:		bsp_trace_t trace;
;2873:
;2874:		if (BotTeam(bs) == TEAM_RED)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 456
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 456
INDIRI4
CNSTI4 1
NEI4 $1529
line 2875
;2875:			goal = &blueobelisk;
ADDRLP4 356
ADDRGP4 blueobelisk
ASGNP4
ADDRGP4 $1530
JUMPV
LABELV $1529
line 2877
;2876:		else
;2877:			goal = &redobelisk;
ADDRLP4 356
ADDRGP4 redobelisk
ASGNP4
LABELV $1530
line 2879
;2878:		//if the obelisk is visible
;2879:		VectorCopy(goal->origin, target);
ADDRLP4 360
ADDRLP4 356
INDIRP4
INDIRB
ASGNB 12
line 2880
;2880:		target[2] += 1;
ADDRLP4 360+8
ADDRLP4 360+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2881
;2881:		BotAI_Trace(&trace, bs->eye, NULL, NULL, target, bs->client, CONTENTS_SOLID);
ADDRLP4 372
ARGP4
ADDRLP4 460
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 460
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 360
ARGP4
ADDRLP4 460
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 2882
;2882:		if (trace.fraction >= 1 || trace.ent == goal->entitynum) {
ADDRLP4 372+8
INDIRF4
CNSTF4 1065353216
GEF4 $1536
ADDRLP4 372+80
INDIRI4
ADDRLP4 356
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
NEI4 $1532
LABELV $1536
line 2883
;2883:			if (goal->entitynum == bs->enemy) {
ADDRLP4 356
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
NEI4 $1537
line 2884
;2884:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1512
JUMPV
LABELV $1537
line 2886
;2885:			}
;2886:			bs->enemy = goal->entitynum;
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
ADDRLP4 356
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ASGNI4
line 2887
;2887:			bs->enemysight_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2888
;2888:			bs->enemysuicide = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
CNSTI4 0
ASGNI4
line 2889
;2889:			bs->enemydeath_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6136
ADDP4
CNSTF4 0
ASGNF4
line 2890
;2890:			bs->enemyvisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6088
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2891
;2891:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1512
JUMPV
LABELV $1532
line 2893
;2892:		}
;2893:	}
LABELV $1527
line 2896
;2894:
;2895:	//
;2896:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRGP4 $1542
JUMPV
LABELV $1539
line 2898
;2897:
;2898:		if (i == bs->client) continue;
ADDRLP4 140
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1544
ADDRGP4 $1540
JUMPV
LABELV $1544
line 2900
;2899:		//if it's the current enemy
;2900:		if (i == curenemy) continue;
ADDRLP4 140
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1546
ADDRGP4 $1540
JUMPV
LABELV $1546
line 2902
;2901:		//if the enemy has targeting disabled
;2902:		if (g_entities[i].flags & FL_NOTARGET) continue;
ADDRLP4 140
INDIRI4
CNSTI4 832
MULI4
ADDRGP4 g_entities+536
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1548
ADDRGP4 $1540
JUMPV
LABELV $1548
line 2904
;2903:		//
;2904:		BotEntityInfo(i, &entinfo);
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2906
;2905:		//
;2906:		if (!entinfo.valid) continue;
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1551
ADDRGP4 $1540
JUMPV
LABELV $1551
line 2908
;2907:		//if the enemy isn't dead and the enemy isn't the bot self
;2908:		if (EntityIsDead(&entinfo) || entinfo.number == bs->entitynum) continue;
ADDRLP4 0
ARGP4
ADDRLP4 356
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 356
INDIRI4
CNSTI4 0
NEI4 $1556
ADDRLP4 0+20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $1553
LABELV $1556
ADDRGP4 $1540
JUMPV
LABELV $1553
line 2910
;2909:		//if the enemy is invisible and not shooting
;2910:		if (EntityIsInvisible(&entinfo) && !EntityIsShooting(&entinfo)) {
ADDRLP4 0
ARGP4
ADDRLP4 360
ADDRGP4 EntityIsInvisible
CALLI4
ASGNI4
ADDRLP4 360
INDIRI4
CNSTI4 0
EQI4 $1557
ADDRLP4 0
ARGP4
ADDRLP4 364
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 364
INDIRI4
CNSTI4 0
NEI4 $1557
line 2911
;2911:			continue;
ADDRGP4 $1540
JUMPV
LABELV $1557
line 2914
;2912:		}
;2913:		//if not an easy fragger don't shoot at chatting players
;2914:		if (easyfragger < 0.5 && EntityIsChatting(&entinfo)) continue;
ADDRLP4 176
INDIRF4
CNSTF4 1056964608
GEF4 $1559
ADDRLP4 0
ARGP4
ADDRLP4 368
ADDRGP4 EntityIsChatting
CALLI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
EQI4 $1559
ADDRGP4 $1540
JUMPV
LABELV $1559
line 2916
;2915:		//
;2916:		if (lastteleport_time > FloatTime() - 3) {
ADDRGP4 lastteleport_time
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
SUBF4
LEF4 $1561
line 2917
;2917:			VectorSubtract(entinfo.origin, lastteleport_origin, dir);
ADDRLP4 144
ADDRLP4 0+24
INDIRF4
ADDRGP4 lastteleport_origin
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 0+24+4
INDIRF4
ADDRGP4 lastteleport_origin+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 0+24+8
INDIRF4
ADDRGP4 lastteleport_origin+8
INDIRF4
SUBF4
ASGNF4
line 2918
;2918:			if (VectorLengthSquared(dir) < Square(70)) continue;
ADDRLP4 144
ARGP4
ADDRLP4 372
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 372
INDIRF4
CNSTF4 1167663104
GEF4 $1572
ADDRGP4 $1540
JUMPV
LABELV $1572
line 2919
;2919:		}
LABELV $1561
line 2921
;2920:		//calculate the distance towards the enemy
;2921:		VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 372
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 0+24
INDIRF4
ADDRLP4 372
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 372
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2922
;2922:		squaredist = VectorLengthSquared(dir);
ADDRLP4 144
ARGP4
ADDRLP4 376
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 376
INDIRF4
ASGNF4
line 2924
;2923:		//if this entity is not carrying a flag
;2924:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 0
ARGP4
ADDRLP4 380
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 380
INDIRI4
CNSTI4 0
NEI4 $1581
line 2925
;2925:		{
line 2927
;2926:			//if this enemy is further away than the current one
;2927:			if (curenemy >= 0 && squaredist > cursquaredist) continue;
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $1583
ADDRLP4 156
INDIRF4
ADDRLP4 192
INDIRF4
LEF4 $1583
ADDRGP4 $1540
JUMPV
LABELV $1583
line 2928
;2928:		} //end if
LABELV $1581
line 2930
;2929:		//if the bot has no
;2930:		if (squaredist > Square(900.0 + alertness * 4000.0)) continue;
ADDRLP4 156
INDIRF4
ADDRLP4 164
INDIRF4
CNSTF4 1165623296
MULF4
CNSTF4 1147207680
ADDF4
ADDRLP4 164
INDIRF4
CNSTF4 1165623296
MULF4
CNSTF4 1147207680
ADDF4
MULF4
LEF4 $1585
ADDRGP4 $1540
JUMPV
LABELV $1585
line 2932
;2931:		//if on the same team
;2932:		if (BotSameTeam(bs, i)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 388
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 388
INDIRI4
CNSTI4 0
EQI4 $1587
ADDRGP4 $1540
JUMPV
LABELV $1587
line 2934
;2933:		//if the bot's health decreased or the enemy is shooting
;2934:		if (curenemy < 0 && (healthdecrease || EntityIsShooting(&entinfo)))
ADDRFP4 4
INDIRI4
CNSTI4 0
GEI4 $1589
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $1591
ADDRLP4 0
ARGP4
ADDRLP4 392
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 392
INDIRI4
CNSTI4 0
EQI4 $1589
LABELV $1591
line 2935
;2935:			f = 360;
ADDRLP4 168
CNSTF4 1135869952
ASGNF4
ADDRGP4 $1590
JUMPV
LABELV $1589
line 2937
;2936:		else
;2937:			f = 90 + 90 - (90 - (squaredist > Square(810) ? Square(810) : squaredist) / (810 * 9));
ADDRLP4 156
INDIRF4
CNSTF4 1226845760
LEF4 $1593
ADDRLP4 396
CNSTF4 1226845760
ASGNF4
ADDRGP4 $1594
JUMPV
LABELV $1593
ADDRLP4 396
ADDRLP4 156
INDIRF4
ASGNF4
LABELV $1594
ADDRLP4 168
CNSTF4 1127481344
CNSTF4 1119092736
ADDRLP4 396
INDIRF4
CNSTF4 957339244
MULF4
SUBF4
SUBF4
ASGNF4
LABELV $1590
line 2939
;2938:		//check if the enemy is visible
;2939:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, f, i);
ADDRLP4 400
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 400
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 400
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 400
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRLP4 168
INDIRF4
ARGF4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 404
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 172
ADDRLP4 404
INDIRF4
ASGNF4
line 2940
;2940:		if (vis <= 0) continue;
ADDRLP4 172
INDIRF4
CNSTF4 0
GTF4 $1595
ADDRGP4 $1540
JUMPV
LABELV $1595
line 2942
;2941:		//if the enemy is quite far away, not shooting and the bot is not damaged
;2942:		if (curenemy < 0 && squaredist > Square(100) && !healthdecrease && !EntityIsShooting(&entinfo))
ADDRFP4 4
INDIRI4
CNSTI4 0
GEI4 $1597
ADDRLP4 156
INDIRF4
CNSTF4 1176256512
LEF4 $1597
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $1597
ADDRLP4 0
ARGP4
ADDRLP4 408
ADDRGP4 EntityIsShooting
CALLI4
ASGNI4
ADDRLP4 408
INDIRI4
CNSTI4 0
NEI4 $1597
line 2943
;2943:		{
line 2945
;2944:			//check if we can avoid this enemy
;2945:			VectorSubtract(bs->origin, entinfo.origin, dir);
ADDRLP4 412
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 412
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 0+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 412
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 0+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 0+24+8
INDIRF4
SUBF4
ASGNF4
line 2946
;2946:			vectoangles(dir, angles);
ADDRLP4 144
ARGP4
ADDRLP4 180
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2948
;2947:			//if the bot isn't in the fov of the enemy
;2948:			if (!InFieldOfVision(entinfo.angles, 90, angles)) {
ADDRLP4 0+36
ARGP4
CNSTF4 1119092736
ARGF4
ADDRLP4 180
ARGP4
ADDRLP4 416
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 416
INDIRI4
CNSTI4 0
NEI4 $1606
line 2950
;2949:				//update some stuff for this enemy
;2950:				BotUpdateBattleInventory(bs, i);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRGP4 BotUpdateBattleInventory
CALLV
pop
line 2952
;2951:				//if the bot doesn't really want to fight
;2952:				if (BotWantsToRetreat(bs)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 420
ADDRGP4 BotWantsToRetreat
CALLI4
ASGNI4
ADDRLP4 420
INDIRI4
CNSTI4 0
EQI4 $1609
ADDRGP4 $1540
JUMPV
LABELV $1609
line 2953
;2953:			}
LABELV $1606
line 2954
;2954:		}
LABELV $1597
line 2956
;2955:		//found an enemy
;2956:		bs->enemy = entinfo.number;
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
ADDRLP4 0+20
INDIRI4
ASGNI4
line 2957
;2957:		if (curenemy >= 0) bs->enemysight_time = FloatTime() - 2;
ADDRFP4 4
INDIRI4
CNSTI4 0
LTI4 $1612
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
ADDRGP4 $1613
JUMPV
LABELV $1612
line 2958
;2958:		else bs->enemysight_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
LABELV $1613
line 2959
;2959:		bs->enemysuicide = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
CNSTI4 0
ASGNI4
line 2960
;2960:		bs->enemydeath_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6136
ADDP4
CNSTF4 0
ASGNF4
line 2961
;2961:		bs->enemyvisible_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6088
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 2962
;2962:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1512
JUMPV
LABELV $1540
line 2896
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1542
ADDRLP4 140
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1539
line 2964
;2963:	}
;2964:	return qfalse;
CNSTI4 0
RETI4
LABELV $1512
endproc BotFindEnemy 464 28
export BotTeamFlagCarrierVisible
proc BotTeamFlagCarrierVisible 164 20
line 2972
;2965:}
;2966:
;2967:/*
;2968:==================
;2969:BotTeamFlagCarrierVisible
;2970:==================
;2971:*/
;2972:int BotTeamFlagCarrierVisible(bot_state_t *bs) {
line 2977
;2973:	int i;
;2974:	float vis;
;2975:	aas_entityinfo_t entinfo;
;2976:
;2977:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1618
JUMPV
LABELV $1615
line 2978
;2978:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1620
line 2979
;2979:			continue;
ADDRGP4 $1616
JUMPV
LABELV $1620
line 2981
;2980:		//
;2981:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 2983
;2982:		//if this player is active
;2983:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1622
line 2984
;2984:			continue;
ADDRGP4 $1616
JUMPV
LABELV $1622
line 2986
;2985:		//if this player is carrying a flag
;2986:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1624
line 2987
;2987:			continue;
ADDRGP4 $1616
JUMPV
LABELV $1624
line 2989
;2988:		//if the flag carrier is not on the same team
;2989:		if (!BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $1626
line 2990
;2990:			continue;
ADDRGP4 $1616
JUMPV
LABELV $1626
line 2992
;2991:		//if the flag carrier is not visible
;2992:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 156
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 160
INDIRF4
ASGNF4
line 2993
;2993:		if (vis <= 0)
ADDRLP4 144
INDIRF4
CNSTF4 0
GTF4 $1628
line 2994
;2994:			continue;
ADDRGP4 $1616
JUMPV
LABELV $1628
line 2996
;2995:		//
;2996:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1614
JUMPV
LABELV $1616
line 2977
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1618
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1615
line 2998
;2997:	}
;2998:	return -1;
CNSTI4 -1
RETI4
LABELV $1614
endproc BotTeamFlagCarrierVisible 164 20
export BotTeamFlagCarrier
proc BotTeamFlagCarrier 152 8
line 3006
;2999:}
;3000:
;3001:/*
;3002:==================
;3003:BotTeamFlagCarrier
;3004:==================
;3005:*/
;3006:int BotTeamFlagCarrier(bot_state_t *bs) {
line 3010
;3007:	int i;
;3008:	aas_entityinfo_t entinfo;
;3009:
;3010:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1634
JUMPV
LABELV $1631
line 3011
;3011:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1636
line 3012
;3012:			continue;
ADDRGP4 $1632
JUMPV
LABELV $1636
line 3014
;3013:		//
;3014:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3016
;3015:		//if this player is active
;3016:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1638
line 3017
;3017:			continue;
ADDRGP4 $1632
JUMPV
LABELV $1638
line 3019
;3018:		//if this player is carrying a flag
;3019:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 144
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $1640
line 3020
;3020:			continue;
ADDRGP4 $1632
JUMPV
LABELV $1640
line 3022
;3021:		//if the flag carrier is not on the same team
;3022:		if (!BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 148
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1642
line 3023
;3023:			continue;
ADDRGP4 $1632
JUMPV
LABELV $1642
line 3025
;3024:		//
;3025:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1630
JUMPV
LABELV $1632
line 3010
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1634
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1631
line 3027
;3026:	}
;3027:	return -1;
CNSTI4 -1
RETI4
LABELV $1630
endproc BotTeamFlagCarrier 152 8
export BotEnemyFlagCarrierVisible
proc BotEnemyFlagCarrierVisible 164 20
line 3035
;3028:}
;3029:
;3030:/*
;3031:==================
;3032:BotEnemyFlagCarrierVisible
;3033:==================
;3034:*/
;3035:int BotEnemyFlagCarrierVisible(bot_state_t *bs) {
line 3040
;3036:	int i;
;3037:	float vis;
;3038:	aas_entityinfo_t entinfo;
;3039:
;3040:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1648
JUMPV
LABELV $1645
line 3041
;3041:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1650
line 3042
;3042:			continue;
ADDRGP4 $1646
JUMPV
LABELV $1650
line 3044
;3043:		//
;3044:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3046
;3045:		//if this player is active
;3046:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1652
line 3047
;3047:			continue;
ADDRGP4 $1646
JUMPV
LABELV $1652
line 3049
;3048:		//if this player is carrying a flag
;3049:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1654
line 3050
;3050:			continue;
ADDRGP4 $1646
JUMPV
LABELV $1654
line 3052
;3051:		//if the flag carrier is on the same team
;3052:		if (BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $1656
line 3053
;3053:			continue;
ADDRGP4 $1646
JUMPV
LABELV $1656
line 3055
;3054:		//if the flag carrier is not visible
;3055:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 156
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 160
INDIRF4
ASGNF4
line 3056
;3056:		if (vis <= 0)
ADDRLP4 144
INDIRF4
CNSTF4 0
GTF4 $1658
line 3057
;3057:			continue;
ADDRGP4 $1646
JUMPV
LABELV $1658
line 3059
;3058:		//
;3059:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1644
JUMPV
LABELV $1646
line 3040
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1648
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1645
line 3061
;3060:	}
;3061:	return -1;
CNSTI4 -1
RETI4
LABELV $1644
endproc BotEnemyFlagCarrierVisible 164 20
export BotVisibleTeamMatesAndEnemies
proc BotVisibleTeamMatesAndEnemies 192 20
line 3069
;3062:}
;3063:
;3064:/*
;3065:==================
;3066:BotVisibleTeamMatesAndEnemies
;3067:==================
;3068:*/
;3069:void BotVisibleTeamMatesAndEnemies(bot_state_t *bs, int *teammates, int *enemies, float range) {
line 3075
;3070:	int i;
;3071:	float vis;
;3072:	aas_entityinfo_t entinfo;
;3073:	vec3_t dir;
;3074:
;3075:	if (teammates)
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1661
line 3076
;3076:		*teammates = 0;
ADDRFP4 4
INDIRP4
CNSTI4 0
ASGNI4
LABELV $1661
line 3077
;3077:	if (enemies)
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1663
line 3078
;3078:		*enemies = 0;
ADDRFP4 8
INDIRP4
CNSTI4 0
ASGNI4
LABELV $1663
line 3079
;3079:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1668
JUMPV
LABELV $1665
line 3080
;3080:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1670
line 3081
;3081:			continue;
ADDRGP4 $1666
JUMPV
LABELV $1670
line 3083
;3082:		//
;3083:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3085
;3084:		//if this player is active
;3085:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1672
line 3086
;3086:			continue;
ADDRGP4 $1666
JUMPV
LABELV $1672
line 3088
;3087:		//if this player is carrying a flag
;3088:		if (!EntityCarriesFlag(&entinfo))
ADDRLP4 4
ARGP4
ADDRLP4 160
ADDRGP4 EntityCarriesFlag
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
NEI4 $1674
line 3089
;3089:			continue;
ADDRGP4 $1666
JUMPV
LABELV $1674
line 3091
;3090:		//if not within range
;3091:		VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
ADDRLP4 4+24
INDIRF4
ADDRLP4 164
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+4
ADDRLP4 4+24+4
INDIRF4
ADDRLP4 164
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 144+8
ADDRLP4 4+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3092
;3092:		if (VectorLengthSquared(dir) > Square(range))
ADDRLP4 144
ARGP4
ADDRLP4 168
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 172
ADDRFP4 12
INDIRF4
ASGNF4
ADDRLP4 168
INDIRF4
ADDRLP4 172
INDIRF4
ADDRLP4 172
INDIRF4
MULF4
LEF4 $1683
line 3093
;3093:			continue;
ADDRGP4 $1666
JUMPV
LABELV $1683
line 3095
;3094:		//if the flag carrier is not visible
;3095:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 176
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 176
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 176
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 180
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 180
INDIRF4
ASGNF4
line 3096
;3096:		if (vis <= 0)
ADDRLP4 156
INDIRF4
CNSTF4 0
GTF4 $1685
line 3097
;3097:			continue;
ADDRGP4 $1666
JUMPV
LABELV $1685
line 3099
;3098:		//if the flag carrier is on the same team
;3099:		if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 184
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 0
EQI4 $1687
line 3100
;3100:			if (teammates)
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1688
line 3101
;3101:				(*teammates)++;
ADDRLP4 188
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 188
INDIRP4
ADDRLP4 188
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3102
;3102:		}
ADDRGP4 $1688
JUMPV
LABELV $1687
line 3103
;3103:		else {
line 3104
;3104:			if (enemies)
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1691
line 3105
;3105:				(*enemies)++;
ADDRLP4 188
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 188
INDIRP4
ADDRLP4 188
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1691
line 3106
;3106:		}
LABELV $1688
line 3107
;3107:	}
LABELV $1666
line 3079
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1668
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1665
line 3108
;3108:}
LABELV $1660
endproc BotVisibleTeamMatesAndEnemies 192 20
export BotTeamSkullCarrierVisible
proc BotTeamSkullCarrierVisible 164 20
line 3115
;3109:
;3110:/*
;3111:==================
;3112:BotTeamSkullCarrierVisible
;3113:==================
;3114:*/
;3115:int BotTeamSkullCarrierVisible(bot_state_t *bs) {
line 3120
;3116:	int i;
;3117:	float vis;
;3118:	aas_entityinfo_t entinfo;
;3119:
;3120:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1697
JUMPV
LABELV $1694
line 3121
;3121:		if (i == bs->client) continue;
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1699
ADDRGP4 $1695
JUMPV
LABELV $1699
line 3123
;3122:		//
;3123:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3125
;3124:		//if this player is active
;3125:		if (!entinfo.valid) continue;
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1701
ADDRGP4 $1695
JUMPV
LABELV $1701
line 3127
;3126:		//if this player is carrying a flag
;3127:		if (!EntityCarriesSkulls(&entinfo)) continue;
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityCarriesSkulls
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1703
ADDRGP4 $1695
JUMPV
LABELV $1703
line 3129
;3128:		//if the flag carrier is not on the same team
;3129:		if (!BotSameTeam(bs, i)) continue;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $1705
ADDRGP4 $1695
JUMPV
LABELV $1705
line 3131
;3130:		//if the flag carrier is not visible
;3131:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 156
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 160
INDIRF4
ASGNF4
line 3132
;3132:		if (vis <= 0) continue;
ADDRLP4 144
INDIRF4
CNSTF4 0
GTF4 $1707
ADDRGP4 $1695
JUMPV
LABELV $1707
line 3134
;3133:		//
;3134:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1693
JUMPV
LABELV $1695
line 3120
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1697
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1694
line 3136
;3135:	}
;3136:	return -1;
CNSTI4 -1
RETI4
LABELV $1693
endproc BotTeamSkullCarrierVisible 164 20
export BotEnemySkullCarrierVisible
proc BotEnemySkullCarrierVisible 164 20
line 3144
;3137:}
;3138:
;3139:/*
;3140:==================
;3141:BotEnemySkullCarrierVisible
;3142:==================
;3143:*/
;3144:int BotEnemySkullCarrierVisible(bot_state_t *bs) {
line 3149
;3145:	int i;
;3146:	float vis;
;3147:	aas_entityinfo_t entinfo;
;3148:
;3149:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1713
JUMPV
LABELV $1710
line 3150
;3150:		if (i == bs->client)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $1715
line 3151
;3151:			continue;
ADDRGP4 $1711
JUMPV
LABELV $1715
line 3153
;3152:		//
;3153:		BotEntityInfo(i, &entinfo);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3155
;3154:		//if this player is active
;3155:		if (!entinfo.valid)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1717
line 3156
;3156:			continue;
ADDRGP4 $1711
JUMPV
LABELV $1717
line 3158
;3157:		//if this player is carrying a flag
;3158:		if (!EntityCarriesSkulls(&entinfo)) continue;
ADDRLP4 4
ARGP4
ADDRLP4 148
ADDRGP4 EntityCarriesSkulls
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $1719
ADDRGP4 $1711
JUMPV
LABELV $1719
line 3160
;3159:		//if the flag carrier is on the same team
;3160:		if (BotSameTeam(bs, i))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 152
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $1721
line 3161
;3161:			continue;
ADDRGP4 $1711
JUMPV
LABELV $1721
line 3163
;3162:		//if the flag carrier is not visible
;3163:		vis = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, i);
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 156
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 156
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 156
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 160
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 144
ADDRLP4 160
INDIRF4
ASGNF4
line 3164
;3164:		if (vis <= 0)
ADDRLP4 144
INDIRF4
CNSTF4 0
GTF4 $1723
line 3165
;3165:			continue;
ADDRGP4 $1711
JUMPV
LABELV $1723
line 3167
;3166:		//
;3167:		return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1709
JUMPV
LABELV $1711
line 3149
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1713
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $1710
line 3169
;3168:	}
;3169:	return -1;
CNSTI4 -1
RETI4
LABELV $1709
endproc BotEnemySkullCarrierVisible 164 20
data
align 4
LABELV $1726
byte 4 3229614080
byte 4 3229614080
byte 4 3229614080
align 4
LABELV $1727
byte 4 1082130432
byte 4 1082130432
byte 4 1082130432
export BotAimAtEnemy
code
proc BotAimAtEnemy 1128 52
line 3177
;3170:}
;3171:
;3172:/*
;3173:==================
;3174:BotAimAtEnemy
;3175:==================
;3176:*/
;3177:void BotAimAtEnemy(bot_state_t *bs) {
line 3181
;3178:	int i, enemyvisible;
;3179:	float dist, f, aim_skill, aim_accuracy, speed, reactiontime;
;3180:	vec3_t dir, bestorigin, end, start, groundtarget, cmdmove, enemyvelocity;
;3181:	vec3_t mins = {-4,-4,-4}, maxs = {4, 4, 4};
ADDRLP4 860
ADDRGP4 $1726
INDIRB
ASGNB 12
ADDRLP4 872
ADDRGP4 $1727
INDIRB
ASGNB 12
line 3189
;3182:	weaponinfo_t wi;
;3183:	aas_entityinfo_t entinfo;
;3184:	bot_goal_t goal;
;3185:	bsp_trace_t trace;
;3186:	vec3_t target;
;3187:
;3188:	//if the bot has no enemy
;3189:	if (bs->enemy < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1728
line 3190
;3190:		return;
ADDRGP4 $1725
JUMPV
LABELV $1728
line 3193
;3191:	}
;3192:	//get the enemy entity information
;3193:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3195
;3194:	//if this is not a player (should be an obelisk)
;3195:	if (bs->enemy >= MAX_CLIENTS) {
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
CNSTI4 64
LTI4 $1730
line 3197
;3196:		//if the obelisk is visible
;3197:		VectorCopy(entinfo.origin, target);
ADDRLP4 824
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3199
;3198:		// if attacking an obelisk
;3199:		if ( bs->enemy == redobelisk.entitynum ||
ADDRLP4 984
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 984
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ADDRGP4 redobelisk+40
INDIRI4
EQI4 $1737
ADDRLP4 984
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ADDRGP4 blueobelisk+40
INDIRI4
NEI4 $1733
LABELV $1737
line 3200
;3200:			bs->enemy == blueobelisk.entitynum ) {
line 3201
;3201:			target[2] += 32;
ADDRLP4 824+8
ADDRLP4 824+8
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 3202
;3202:		}
LABELV $1733
line 3204
;3203:		//aim at the obelisk
;3204:		VectorSubtract(target, bs->eye, dir);
ADDRLP4 988
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 824
INDIRF4
ADDRLP4 988
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 824+4
INDIRF4
ADDRLP4 988
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 824+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3205
;3205:		vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 140
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3207
;3206:		//set the aim target before trying to attack
;3207:		VectorCopy(target, bs->aimtarget);
ADDRFP4 0
INDIRP4
CNSTI4 6220
ADDP4
ADDRLP4 824
INDIRB
ASGNB 12
line 3208
;3208:		return;
ADDRGP4 $1725
JUMPV
LABELV $1730
line 3213
;3209:	}
;3210:	//
;3211:	//BotAI_Print(PRT_MESSAGE, "client %d: aiming at client %d\n", bs->entitynum, bs->enemy);
;3212:	//
;3213:	aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 16
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 984
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 984
INDIRF4
ASGNF4
line 3214
;3214:	aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 7
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 988
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 988
INDIRF4
ASGNF4
line 3216
;3215:	//
;3216:	if (aim_skill > 0.95) {
ADDRLP4 736
INDIRF4
CNSTF4 1064514355
LEF4 $1743
line 3218
;3217:		//don't aim too early
;3218:		reactiontime = 0.5 * trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_REACTIONTIME, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 992
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 856
ADDRLP4 992
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3219
;3219:		if (bs->enemysight_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 856
INDIRF4
SUBF4
LEF4 $1745
ADDRGP4 $1725
JUMPV
LABELV $1745
line 3220
;3220:		if (bs->teleport_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 6180
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 856
INDIRF4
SUBF4
LEF4 $1747
ADDRGP4 $1725
JUMPV
LABELV $1747
line 3221
;3221:	}
LABELV $1743
line 3224
;3222:
;3223:	//get the weapon information
;3224:	trap_BotGetWeaponInfo(bs->ws, bs->weaponnum, &wi);
ADDRLP4 992
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 992
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRLP4 992
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRLP4 160
ARGP4
ADDRGP4 trap_BotGetWeaponInfo
CALLV
pop
line 3226
;3225:	//get the weapon specific aim accuracy and or aim skill
;3226:	if (wi.number == WP_MACHINEGUN) {
ADDRLP4 160+4
INDIRI4
CNSTI4 2
NEI4 $1749
line 3227
;3227:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_MACHINEGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 8
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3228
;3228:	}
LABELV $1749
line 3229
;3229:	if (wi.number == WP_HMG) {
ADDRLP4 160+4
INDIRI4
CNSTI4 14
NEI4 $1752
line 3230
;3230:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_MACHINEGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 8
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3231
;3231:	}
ADDRGP4 $1753
JUMPV
LABELV $1752
line 3232
;3232:	else if (wi.number == WP_SHOTGUN) {
ADDRLP4 160+4
INDIRI4
CNSTI4 3
NEI4 $1755
line 3233
;3233:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_SHOTGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 9
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3234
;3234:	}
ADDRGP4 $1756
JUMPV
LABELV $1755
line 3235
;3235:	else if (wi.number == WP_GRENADE_LAUNCHER) {
ADDRLP4 160+4
INDIRI4
CNSTI4 4
NEI4 $1758
line 3236
;3236:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_GRENADELAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 11
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3237
;3237:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_GRENADELAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 18
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3238
;3238:	}
ADDRGP4 $1759
JUMPV
LABELV $1758
line 3239
;3239:	else if (wi.number == WP_ROCKET_LAUNCHER) {
ADDRLP4 160+4
INDIRI4
CNSTI4 5
NEI4 $1761
line 3240
;3240:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_ROCKETLAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 10
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3241
;3241:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_ROCKETLAUNCHER, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 17
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3242
;3242:	}
ADDRGP4 $1762
JUMPV
LABELV $1761
line 3243
;3243:	else if (wi.number == WP_LIGHTNING) {
ADDRLP4 160+4
INDIRI4
CNSTI4 6
NEI4 $1764
line 3244
;3244:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_LIGHTNING, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 12
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3245
;3245:	}
ADDRGP4 $1765
JUMPV
LABELV $1764
line 3246
;3246:	else if (wi.number == WP_RAILGUN) {
ADDRLP4 160+4
INDIRI4
CNSTI4 7
NEI4 $1767
line 3247
;3247:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_RAILGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 14
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3248
;3248:	}
ADDRGP4 $1768
JUMPV
LABELV $1767
line 3249
;3249:	else if (wi.number == WP_PLASMAGUN) {
ADDRLP4 160+4
INDIRI4
CNSTI4 8
NEI4 $1770
line 3250
;3250:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_PLASMAGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 13
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3251
;3251:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_PLASMAGUN, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 19
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3252
;3252:	}
ADDRGP4 $1771
JUMPV
LABELV $1770
line 3253
;3253:	else if (wi.number == WP_BFG) {
ADDRLP4 160+4
INDIRI4
CNSTI4 9
NEI4 $1773
line 3254
;3254:		aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY_BFG10K, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 15
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 996
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 156
ADDRLP4 996
INDIRF4
ASGNF4
line 3255
;3255:		aim_skill = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_SKILL_BFG10K, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 20
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 1000
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 736
ADDRLP4 1000
INDIRF4
ASGNF4
line 3256
;3256:	}
LABELV $1773
LABELV $1771
LABELV $1768
LABELV $1765
LABELV $1762
LABELV $1759
LABELV $1756
LABELV $1753
line 3258
;3257:	//
;3258:	if (aim_accuracy <= 0) aim_accuracy = 0.0001f;
ADDRLP4 156
INDIRF4
CNSTF4 0
GTF4 $1776
ADDRLP4 156
CNSTF4 953267991
ASGNF4
LABELV $1776
line 3260
;3259:	//get the enemy entity information
;3260:	BotEntityInfo(bs->enemy, &entinfo);
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3262
;3261:	//if the enemy is invisible then shoot crappy most of the time
;3262:	if (EntityIsInvisible(&entinfo)) {
ADDRLP4 0
ARGP4
ADDRLP4 996
ADDRGP4 EntityIsInvisible
CALLI4
ASGNI4
ADDRLP4 996
INDIRI4
CNSTI4 0
EQI4 $1778
line 3263
;3263:		if (random() > 0.1) aim_accuracy *= 0.4f;
ADDRLP4 1000
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1000
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1036831949
LEF4 $1780
ADDRLP4 156
ADDRLP4 156
INDIRF4
CNSTF4 1053609165
MULF4
ASGNF4
LABELV $1780
line 3264
;3264:	}
LABELV $1778
line 3266
;3265:	//
;3266:	VectorSubtract(entinfo.origin, entinfo.lastvisorigin, enemyvelocity);
ADDRLP4 712
ADDRLP4 0+24
INDIRF4
ADDRLP4 0+60
INDIRF4
SUBF4
ASGNF4
ADDRLP4 712+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 0+60+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 712+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 0+60+8
INDIRF4
SUBF4
ASGNF4
line 3267
;3267:	VectorScale(enemyvelocity, 1 / entinfo.update_time, enemyvelocity);
ADDRLP4 712
ADDRLP4 712
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 712+4
ADDRLP4 712+4
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 712+8
ADDRLP4 712+8
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
line 3269
;3268:	//enemy origin and velocity is remembered every 0.5 seconds
;3269:	if (bs->enemyposition_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6140
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $1801
line 3271
;3270:		//
;3271:		bs->enemyposition_time = FloatTime() + 0.5;
ADDRFP4 0
INDIRP4
CNSTI4 6140
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 3272
;3272:		VectorCopy(enemyvelocity, bs->enemyvelocity);
ADDRFP4 0
INDIRP4
CNSTI4 6232
ADDP4
ADDRLP4 712
INDIRB
ASGNB 12
line 3273
;3273:		VectorCopy(entinfo.origin, bs->enemyorigin);
ADDRFP4 0
INDIRP4
CNSTI4 6244
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3274
;3274:	}
LABELV $1801
line 3276
;3275:	//if not extremely skilled
;3276:	if (aim_skill < 0.9) {
ADDRLP4 736
INDIRF4
CNSTF4 1063675494
GEF4 $1804
line 3277
;3277:		VectorSubtract(entinfo.origin, bs->enemyorigin, dir);
ADDRLP4 1000
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1000
INDIRP4
CNSTI4 6244
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1000
INDIRP4
CNSTI4 6248
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 6252
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3279
;3278:		//if the enemy moved a bit
;3279:		if (VectorLengthSquared(dir) > Square(48)) {
ADDRLP4 140
ARGP4
ADDRLP4 1004
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1004
INDIRF4
CNSTF4 1158676480
LEF4 $1813
line 3281
;3280:			//if the enemy changed direction
;3281:			if (DotProduct(bs->enemyvelocity, enemyvelocity) < 0) {
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1008
INDIRP4
CNSTI4 6232
ADDP4
INDIRF4
ADDRLP4 712
INDIRF4
MULF4
ADDRLP4 1008
INDIRP4
CNSTI4 6236
ADDP4
INDIRF4
ADDRLP4 712+4
INDIRF4
MULF4
ADDF4
ADDRLP4 1008
INDIRP4
CNSTI4 6240
ADDP4
INDIRF4
ADDRLP4 712+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
GEF4 $1815
line 3283
;3282:				//aim accuracy should be worse now
;3283:				aim_accuracy *= 0.7f;
ADDRLP4 156
ADDRLP4 156
INDIRF4
CNSTF4 1060320051
MULF4
ASGNF4
line 3284
;3284:			}
LABELV $1815
line 3285
;3285:		}
LABELV $1813
line 3286
;3286:	}
LABELV $1804
line 3288
;3287:	//check visibility of enemy
;3288:	enemyvisible = BotEntityVisible(bs->entitynum, bs->eye, bs->viewangles, 360, bs->enemy);
ADDRLP4 1000
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1000
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 1000
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 1000
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1135869952
ARGF4
ADDRLP4 1000
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 1004
ADDRGP4 BotEntityVisible
CALLF4
ASGNF4
ADDRLP4 836
ADDRLP4 1004
INDIRF4
CVFI4 4
ASGNI4
line 3290
;3289:	//if the enemy is visible
;3290:	if (enemyvisible) {
ADDRLP4 836
INDIRI4
CNSTI4 0
EQI4 $1819
line 3292
;3291:		//
;3292:		VectorCopy(entinfo.origin, bestorigin);
ADDRLP4 724
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3293
;3293:		bestorigin[2] += 8;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 3296
;3294:		//get the start point shooting from
;3295:		//NOTE: the x and y projectile start offsets are ignored
;3296:		VectorCopy(bs->origin, start);
ADDRLP4 844
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 3297
;3297:		start[2] += bs->cur_ps.viewheight;
ADDRLP4 844+8
ADDRLP4 844+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 3298
;3298:		start[2] += wi.offset[2];
ADDRLP4 844+8
ADDRLP4 844+8
INDIRF4
ADDRLP4 160+292+8
INDIRF4
ADDF4
ASGNF4
line 3300
;3299:		//
;3300:		BotAI_Trace(&trace, start, mins, maxs, bestorigin, bs->entitynum, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 844
ARGP4
ADDRLP4 860
ARGP4
ADDRLP4 872
ARGP4
ADDRLP4 724
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3302
;3301:		//if the enemy is NOT hit
;3302:		if (trace.fraction <= 1 && trace.ent != entinfo.number) {
ADDRLP4 740+8
INDIRF4
CNSTF4 1065353216
GTF4 $1827
ADDRLP4 740+80
INDIRI4
ADDRLP4 0+20
INDIRI4
EQI4 $1827
line 3303
;3303:			bestorigin[2] += 16;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 3304
;3304:		}
LABELV $1827
line 3306
;3305:		//if it is not an instant hit weapon the bot might want to predict the enemy
;3306:		if (wi.speed) {
ADDRLP4 160+272
INDIRF4
CNSTF4 0
EQF4 $1833
line 3308
;3307:			//
;3308:			VectorSubtract(bestorigin, bs->origin, dir);
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 724
INDIRF4
ADDRLP4 1008
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 724+4
INDIRF4
ADDRLP4 1008
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 724+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3309
;3309:			dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1012
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1012
INDIRF4
ASGNF4
line 3310
;3310:			VectorSubtract(entinfo.origin, bs->enemyorigin, dir);
ADDRLP4 1016
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1016
INDIRP4
CNSTI4 6244
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1016
INDIRP4
CNSTI4 6248
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 6252
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3312
;3311:			//if the enemy is NOT pretty far away and strafing just small steps left and right
;3312:			if (!(dist > 100 && VectorLengthSquared(dir) < Square(32))) {
ADDRLP4 840
INDIRF4
CNSTF4 1120403456
LEF4 $1849
ADDRLP4 140
ARGP4
ADDRLP4 1020
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1020
INDIRF4
CNSTF4 1149239296
LTF4 $1847
LABELV $1849
line 3314
;3313:				//if skilled anough do exact prediction
;3314:				if (aim_skill > 0.8 &&
ADDRLP4 736
INDIRF4
CNSTF4 1061997773
LEF4 $1850
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1850
line 3316
;3315:						//if the weapon is ready to fire
;3316:						bs->cur_ps.weaponstate == WEAPON_READY) {
line 3320
;3317:					aas_clientmove_t move;
;3318:					vec3_t origin;
;3319:
;3320:					VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 1120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1120
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1120
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3322
;3321:					//distance towards the enemy
;3322:					dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1124
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1124
INDIRF4
ASGNF4
line 3324
;3323:					//direction the enemy is moving in
;3324:					VectorSubtract(entinfo.origin, entinfo.lastvisorigin, dir);
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 0+60
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 0+60+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 0+60+8
INDIRF4
SUBF4
ASGNF4
line 3326
;3325:					//
;3326:					VectorScale(dir, 1 / entinfo.update_time, dir);
ADDRLP4 140
ADDRLP4 140
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 140+4
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 140+8
INDIRF4
CNSTF4 1065353216
ADDRLP4 0+16
INDIRF4
DIVF4
MULF4
ASGNF4
line 3328
;3327:					//
;3328:					VectorCopy(entinfo.origin, origin);
ADDRLP4 1024
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3329
;3329:					origin[2] += 1;
ADDRLP4 1024+8
ADDRLP4 1024+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3331
;3330:					//
;3331:					VectorClear(cmdmove);
ADDRLP4 968
CNSTF4 0
ASGNF4
ADDRLP4 968+4
CNSTF4 0
ASGNF4
ADDRLP4 968+8
CNSTF4 0
ASGNF4
line 3333
;3332:					//AAS_ClearShownDebugLines();
;3333:					trap_AAS_PredictClientMovement(&move, bs->enemy, origin,
ADDRLP4 1036
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ARGI4
ADDRLP4 1024
ARGP4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 140
ARGP4
ADDRLP4 968
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 840
INDIRF4
CNSTF4 1092616192
MULF4
ADDRLP4 160+272
INDIRF4
DIVF4
CVFI4 4
ARGI4
CNSTF4 1036831949
ARGF4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_AAS_PredictClientMovement
CALLI4
pop
line 3337
;3334:														PRESENCE_CROUCH, qfalse,
;3335:														dir, cmdmove, 0,
;3336:														dist * 10 / wi.speed, 0.1f, 0, 0, qfalse);
;3337:					VectorCopy(move.endpos, bestorigin);
ADDRLP4 724
ADDRLP4 1036
INDIRB
ASGNB 12
line 3339
;3338:					//BotAI_Print(PRT_MESSAGE, "%1.1f predicted speed = %f, frames = %f\n", FloatTime(), VectorLength(dir), dist * 10 / wi.speed);
;3339:				}
ADDRGP4 $1851
JUMPV
LABELV $1850
line 3341
;3340:				//if not that skilled do linear prediction
;3341:				else if (aim_skill > 0.4) {
ADDRLP4 736
INDIRF4
CNSTF4 1053609165
LEF4 $1883
line 3342
;3342:					VectorSubtract(entinfo.origin, bs->origin, dir);
ADDRLP4 1024
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 1024
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 1024
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3344
;3343:					//distance towards the enemy
;3344:					dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1028
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1028
INDIRF4
ASGNF4
line 3346
;3345:					//direction the enemy is moving in
;3346:					VectorSubtract(entinfo.origin, entinfo.lastvisorigin, dir);
ADDRLP4 140
ADDRLP4 0+24
INDIRF4
ADDRLP4 0+60
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 0+60+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 0+60+8
INDIRF4
SUBF4
ASGNF4
line 3347
;3347:					dir[2] = 0;
ADDRLP4 140+8
CNSTF4 0
ASGNF4
line 3349
;3348:					//
;3349:					speed = VectorNormalize(dir) / entinfo.update_time;
ADDRLP4 140
ARGP4
ADDRLP4 1032
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 980
ADDRLP4 1032
INDIRF4
ADDRLP4 0+16
INDIRF4
DIVF4
ASGNF4
line 3352
;3350:					//botimport.Print(PRT_MESSAGE, "speed = %f, wi->speed = %f\n", speed, wi->speed);
;3351:					//best spot to aim at
;3352:					VectorMA(entinfo.origin, (dist / wi.speed) * speed, dir, bestorigin);
ADDRLP4 1036
ADDRLP4 840
INDIRF4
ASGNF4
ADDRLP4 1040
ADDRLP4 980
INDIRF4
ASGNF4
ADDRLP4 724
ADDRLP4 0+24
INDIRF4
ADDRLP4 140
INDIRF4
ADDRLP4 1036
INDIRF4
ADDRLP4 160+272
INDIRF4
DIVF4
ADDRLP4 1040
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 724+4
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 140+4
INDIRF4
ADDRLP4 1036
INDIRF4
ADDRLP4 160+272
INDIRF4
DIVF4
ADDRLP4 1040
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 724+8
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 140+8
INDIRF4
ADDRLP4 840
INDIRF4
ADDRLP4 160+272
INDIRF4
DIVF4
ADDRLP4 980
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 3353
;3353:				}
LABELV $1883
LABELV $1851
line 3354
;3354:			}
LABELV $1847
line 3355
;3355:		}
LABELV $1833
line 3357
;3356:		//if the projectile does radial damage
;3357:		if (aim_skill > 0.6 && wi.proj.damagetype & DAMAGETYPE_RADIAL) {
ADDRLP4 736
INDIRF4
CNSTF4 1058642330
LEF4 $1918
ADDRLP4 160+344+180
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1918
line 3359
;3358:			//if the enemy isn't standing significantly higher than the bot
;3359:			if (entinfo.origin[2] < bs->origin[2] + 16) {
ADDRLP4 0+24+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
GEF4 $1922
line 3361
;3360:				//try to aim at the ground in front of the enemy
;3361:				VectorCopy(entinfo.origin, end);
ADDRLP4 956
ADDRLP4 0+24
INDIRB
ASGNB 12
line 3362
;3362:				end[2] -= 64;
ADDRLP4 956+8
ADDRLP4 956+8
INDIRF4
CNSTF4 1115684864
SUBF4
ASGNF4
line 3363
;3363:				BotAI_Trace(&trace, entinfo.origin, NULL, NULL, end, entinfo.number, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 0+24
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 956
ARGP4
ADDRLP4 0+20
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3365
;3364:				//
;3365:				VectorCopy(bestorigin, groundtarget);
ADDRLP4 944
ADDRLP4 724
INDIRB
ASGNB 12
line 3366
;3366:				if (trace.startsolid) groundtarget[2] = entinfo.origin[2] - 16;
ADDRLP4 740+4
INDIRI4
CNSTI4 0
EQI4 $1930
ADDRLP4 944+8
ADDRLP4 0+24+8
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
ADDRGP4 $1931
JUMPV
LABELV $1930
line 3367
;3367:				else groundtarget[2] = trace.endpos[2] - 8;
ADDRLP4 944+8
ADDRLP4 740+12+8
INDIRF4
CNSTF4 1090519040
SUBF4
ASGNF4
LABELV $1931
line 3369
;3368:				//trace a line from projectile start to ground target
;3369:				BotAI_Trace(&trace, start, NULL, NULL, groundtarget, bs->entitynum, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 844
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 944
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3371
;3370:				//if hitpoint is not vertically too far from the ground target
;3371:				if (fabs(trace.endpos[2] - groundtarget[2]) < 50) {
ADDRLP4 740+12+8
INDIRF4
ADDRLP4 944+8
INDIRF4
SUBF4
ARGF4
ADDRLP4 1008
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 1008
INDIRF4
CNSTF4 1112014848
GEF4 $1939
line 3372
;3372:					VectorSubtract(trace.endpos, groundtarget, dir);
ADDRLP4 140
ADDRLP4 740+12
INDIRF4
ADDRLP4 944
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 740+12+4
INDIRF4
ADDRLP4 944+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 740+12+8
INDIRF4
ADDRLP4 944+8
INDIRF4
SUBF4
ASGNF4
line 3374
;3373:					//if the hitpoint is near enough the ground target
;3374:					if (VectorLengthSquared(dir) < Square(60)) {
ADDRLP4 140
ARGP4
ADDRLP4 1012
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1012
INDIRF4
CNSTF4 1163984896
GEF4 $1953
line 3375
;3375:						VectorSubtract(trace.endpos, start, dir);
ADDRLP4 140
ADDRLP4 740+12
INDIRF4
ADDRLP4 844
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 740+12+4
INDIRF4
ADDRLP4 844+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 740+12+8
INDIRF4
ADDRLP4 844+8
INDIRF4
SUBF4
ASGNF4
line 3377
;3376:						//if the hitpoint is far enough from the bot
;3377:						if (VectorLengthSquared(dir) > Square(100)) {
ADDRLP4 140
ARGP4
ADDRLP4 1016
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1016
INDIRF4
CNSTF4 1176256512
LEF4 $1964
line 3379
;3378:							//check if the bot is visible from the ground target
;3379:							trace.endpos[2] += 1;
ADDRLP4 740+12+8
ADDRLP4 740+12+8
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3380
;3380:							BotAI_Trace(&trace, trace.endpos, NULL, NULL, entinfo.origin, entinfo.number, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 740+12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0+24
ARGP4
ADDRLP4 0+20
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3381
;3381:							if (trace.fraction >= 1) {
ADDRLP4 740+8
INDIRF4
CNSTF4 1065353216
LTF4 $1971
line 3383
;3382:								//botimport.Print(PRT_MESSAGE, "%1.1f aiming at ground\n", AAS_Time());
;3383:								VectorCopy(groundtarget, bestorigin);
ADDRLP4 724
ADDRLP4 944
INDIRB
ASGNB 12
line 3384
;3384:							}
LABELV $1971
line 3385
;3385:						}
LABELV $1964
line 3386
;3386:					}
LABELV $1953
line 3387
;3387:				}
LABELV $1939
line 3388
;3388:			}
LABELV $1922
line 3389
;3389:		}
LABELV $1918
line 3390
;3390:		bestorigin[0] += 20 * crandom() * (1 - aim_accuracy);
ADDRLP4 1008
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 724
ADDRLP4 724
INDIRF4
ADDRLP4 1008
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1101004800
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3391
;3391:		bestorigin[1] += 20 * crandom() * (1 - aim_accuracy);
ADDRLP4 1012
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 724+4
ADDRLP4 724+4
INDIRF4
ADDRLP4 1012
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1101004800
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3392
;3392:		bestorigin[2] += 10 * crandom() * (1 - aim_accuracy);
ADDRLP4 1016
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
ADDRLP4 1016
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1092616192
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3393
;3393:	}
ADDRGP4 $1820
JUMPV
LABELV $1819
line 3394
;3394:	else {
line 3396
;3395:		//
;3396:		VectorCopy(bs->lastenemyorigin, bestorigin);
ADDRLP4 724
ADDRFP4 0
INDIRP4
CNSTI4 6548
ADDP4
INDIRB
ASGNB 12
line 3397
;3397:		bestorigin[2] += 8;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 3399
;3398:		//if the bot is skilled enough
;3399:		if (aim_skill > 0.5) {
ADDRLP4 736
INDIRF4
CNSTF4 1056964608
LEF4 $1977
line 3401
;3400:			//do prediction shots around corners
;3401:			if (wi.number == WP_BFG ||
ADDRLP4 160+4
INDIRI4
CNSTI4 9
EQI4 $1985
ADDRLP4 160+4
INDIRI4
CNSTI4 5
EQI4 $1985
ADDRLP4 160+4
INDIRI4
CNSTI4 4
NEI4 $1979
LABELV $1985
line 3403
;3402:				wi.number == WP_ROCKET_LAUNCHER ||
;3403:				wi.number == WP_GRENADE_LAUNCHER) {
line 3405
;3404:				//create the chase goal
;3405:				goal.entitynum = bs->client;
ADDRLP4 884+40
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 3406
;3406:				goal.areanum = bs->areanum;
ADDRLP4 884+12
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ASGNI4
line 3407
;3407:				VectorCopy(bs->eye, goal.origin);
ADDRLP4 884
ADDRFP4 0
INDIRP4
CNSTI4 4936
ADDP4
INDIRB
ASGNB 12
line 3408
;3408:				VectorSet(goal.mins, -8, -8, -8);
ADDRLP4 884+16
CNSTF4 3238002688
ASGNF4
ADDRLP4 884+16+4
CNSTF4 3238002688
ASGNF4
ADDRLP4 884+16+8
CNSTF4 3238002688
ASGNF4
line 3409
;3409:				VectorSet(goal.maxs, 8, 8, 8);
ADDRLP4 884+28
CNSTF4 1090519040
ASGNF4
ADDRLP4 884+28+4
CNSTF4 1090519040
ASGNF4
ADDRLP4 884+28+8
CNSTF4 1090519040
ASGNF4
line 3411
;3410:				//
;3411:				if (trap_BotPredictVisiblePosition(bs->lastenemyorigin, bs->lastenemyareanum, &goal, TFL_DEFAULT, target)) {
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1008
INDIRP4
CNSTI4 6548
ADDP4
ARGP4
ADDRLP4 1008
INDIRP4
CNSTI4 6544
ADDP4
INDIRI4
ARGI4
ADDRLP4 884
ARGP4
CNSTI4 18616254
ARGI4
ADDRLP4 824
ARGP4
ADDRLP4 1012
ADDRGP4 trap_BotPredictVisiblePosition
CALLI4
ASGNI4
ADDRLP4 1012
INDIRI4
CNSTI4 0
EQI4 $1998
line 3412
;3412:					VectorSubtract(target, bs->eye, dir);
ADDRLP4 1016
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 824
INDIRF4
ADDRLP4 1016
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 824+4
INDIRF4
ADDRLP4 1016
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 824+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3413
;3413:					if (VectorLengthSquared(dir) > Square(80)) {
ADDRLP4 140
ARGP4
ADDRLP4 1020
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 1020
INDIRF4
CNSTF4 1170735104
LEF4 $2004
line 3414
;3414:						VectorCopy(target, bestorigin);
ADDRLP4 724
ADDRLP4 824
INDIRB
ASGNB 12
line 3415
;3415:						bestorigin[2] -= 20;
ADDRLP4 724+8
ADDRLP4 724+8
INDIRF4
CNSTF4 1101004800
SUBF4
ASGNF4
line 3416
;3416:					}
LABELV $2004
line 3417
;3417:				}
LABELV $1998
line 3418
;3418:				aim_accuracy = 1;
ADDRLP4 156
CNSTF4 1065353216
ASGNF4
line 3419
;3419:			}
LABELV $1979
line 3420
;3420:		}
LABELV $1977
line 3421
;3421:	}
LABELV $1820
line 3423
;3422:	//
;3423:	if (enemyvisible) {
ADDRLP4 836
INDIRI4
CNSTI4 0
EQI4 $2007
line 3424
;3424:		BotAI_Trace(&trace, bs->eye, NULL, NULL, bestorigin, bs->entitynum, MASK_SHOT);
ADDRLP4 740
ARGP4
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1008
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 724
ARGP4
ADDRLP4 1008
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3425
;3425:		VectorCopy(trace.endpos, bs->aimtarget);
ADDRFP4 0
INDIRP4
CNSTI4 6220
ADDP4
ADDRLP4 740+12
INDIRB
ASGNB 12
line 3426
;3426:	}
ADDRGP4 $2008
JUMPV
LABELV $2007
line 3427
;3427:	else {
line 3428
;3428:		VectorCopy(bestorigin, bs->aimtarget);
ADDRFP4 0
INDIRP4
CNSTI4 6220
ADDP4
ADDRLP4 724
INDIRB
ASGNB 12
line 3429
;3429:	}
LABELV $2008
line 3431
;3430:	//get aim direction
;3431:	VectorSubtract(bestorigin, bs->eye, dir);
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 140
ADDRLP4 724
INDIRF4
ADDRLP4 1008
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+4
ADDRLP4 724+4
INDIRF4
ADDRLP4 1008
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 140+8
ADDRLP4 724+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3433
;3432:	//
;3433:	if (wi.number == WP_MACHINEGUN ||
ADDRLP4 160+4
INDIRI4
CNSTI4 2
EQI4 $2026
ADDRLP4 160+4
INDIRI4
CNSTI4 3
EQI4 $2026
ADDRLP4 160+4
INDIRI4
CNSTI4 14
EQI4 $2026
ADDRLP4 160+4
INDIRI4
CNSTI4 13
EQI4 $2026
ADDRLP4 160+4
INDIRI4
CNSTI4 6
EQI4 $2026
ADDRLP4 160+4
INDIRI4
CNSTI4 7
NEI4 $2014
LABELV $2026
line 3438
;3434:		wi.number == WP_SHOTGUN ||
;3435:		wi.number == WP_HMG ||
;3436:		wi.number == WP_CHAINGUN ||
;3437:		wi.number == WP_LIGHTNING ||
;3438:		wi.number == WP_RAILGUN) {
line 3440
;3439:		//distance towards the enemy
;3440:		dist = VectorLength(dir);
ADDRLP4 140
ARGP4
ADDRLP4 1012
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 840
ADDRLP4 1012
INDIRF4
ASGNF4
line 3441
;3441:		if (dist > 150) dist = 150;
ADDRLP4 840
INDIRF4
CNSTF4 1125515264
LEF4 $2027
ADDRLP4 840
CNSTF4 1125515264
ASGNF4
LABELV $2027
line 3442
;3442:		f = 0.6 + dist / 150 * 0.4;
ADDRLP4 940
ADDRLP4 840
INDIRF4
CNSTF4 992920382
MULF4
CNSTF4 1058642330
ADDF4
ASGNF4
line 3443
;3443:		aim_accuracy *= f;
ADDRLP4 156
ADDRLP4 156
INDIRF4
ADDRLP4 940
INDIRF4
MULF4
ASGNF4
line 3444
;3444:	}
LABELV $2014
line 3446
;3445:	//add some random stuff to the aim direction depending on the aim accuracy
;3446:	if (aim_accuracy < 0.8) {
ADDRLP4 156
INDIRF4
CNSTF4 1061997773
GEF4 $2029
line 3447
;3447:		VectorNormalize(dir);
ADDRLP4 140
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 3448
;3448:		for (i = 0; i < 3; i++) dir[i] += 0.3 * crandom() * (1 - aim_accuracy);
ADDRLP4 152
CNSTI4 0
ASGNI4
LABELV $2031
ADDRLP4 1012
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1016
ADDRLP4 152
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 140
ADDP4
ASGNP4
ADDRLP4 1016
INDIRP4
ADDRLP4 1016
INDIRP4
INDIRF4
ADDRLP4 1012
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1050253722
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
LABELV $2032
ADDRLP4 152
ADDRLP4 152
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 3
LTI4 $2031
line 3449
;3449:	}
LABELV $2029
line 3451
;3450:	//set the ideal view angles
;3451:	vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 140
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3453
;3452:	//take the weapon spread into account for lower skilled bots
;3453:	bs->ideal_viewangles[PITCH] += 6 * wi.vspread * crandom() * (1 - aim_accuracy);
ADDRLP4 1012
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1016
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ASGNP4
ADDRLP4 1016
INDIRP4
ADDRLP4 1016
INDIRP4
INDIRF4
ADDRLP4 160+268
INDIRF4
CNSTF4 1086324736
MULF4
ADDRLP4 1012
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3454
;3454:	bs->ideal_viewangles[PITCH] = AngleMod(bs->ideal_viewangles[PITCH]);
ADDRLP4 1020
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1020
INDIRP4
CNSTI4 6576
ADDP4
INDIRF4
ARGF4
ADDRLP4 1024
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1020
INDIRP4
CNSTI4 6576
ADDP4
ADDRLP4 1024
INDIRF4
ASGNF4
line 3455
;3455:	bs->ideal_viewangles[YAW] += 6 * wi.hspread * crandom() * (1 - aim_accuracy);
ADDRLP4 1028
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1032
ADDRFP4 0
INDIRP4
CNSTI4 6580
ADDP4
ASGNP4
ADDRLP4 1032
INDIRP4
ADDRLP4 1032
INDIRP4
INDIRF4
ADDRLP4 160+264
INDIRF4
CNSTF4 1086324736
MULF4
ADDRLP4 1028
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
MULF4
CNSTF4 1065353216
ADDRLP4 156
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3456
;3456:	bs->ideal_viewangles[YAW] = AngleMod(bs->ideal_viewangles[YAW]);
ADDRLP4 1036
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1036
INDIRP4
CNSTI4 6580
ADDP4
INDIRF4
ARGF4
ADDRLP4 1040
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1036
INDIRP4
CNSTI4 6580
ADDP4
ADDRLP4 1040
INDIRF4
ASGNF4
line 3458
;3457:	//if the bots should be really challenging
;3458:	if (bot_challenge.integer) {
ADDRGP4 bot_challenge+12
INDIRI4
CNSTI4 0
EQI4 $2037
line 3460
;3459:		//if the bot is really accurate and has the enemy in view for some time
;3460:		if (aim_accuracy > 0.9 && bs->enemysight_time < FloatTime() - 1) {
ADDRLP4 156
INDIRF4
CNSTF4 1063675494
LEF4 $2040
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
SUBF4
GEF4 $2040
line 3462
;3461:			//set the view angles directly
;3462:			if (bs->ideal_viewangles[PITCH] > 180) bs->ideal_viewangles[PITCH] -= 360;
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $2042
ADDRLP4 1044
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ASGNP4
ADDRLP4 1044
INDIRP4
ADDRLP4 1044
INDIRP4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $2042
line 3463
;3463:			VectorCopy(bs->ideal_viewangles, bs->viewangles);
ADDRLP4 1048
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
CNSTI4 6564
ADDP4
ADDRLP4 1048
INDIRP4
CNSTI4 6576
ADDP4
INDIRB
ASGNB 12
line 3464
;3464:			trap_EA_View(bs->client, bs->viewangles);
ADDRLP4 1052
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1052
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1052
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRGP4 trap_EA_View
CALLV
pop
line 3465
;3465:		}
LABELV $2040
line 3466
;3466:	}
LABELV $2037
line 3467
;3467:}
LABELV $1725
endproc BotAimAtEnemy 1128 52
data
align 4
LABELV $2045
byte 4 3238002688
byte 4 3238002688
byte 4 3238002688
align 4
LABELV $2046
byte 4 1090519040
byte 4 1090519040
byte 4 1090519040
export BotCheckAttack
code
proc BotCheckAttack 1024 28
line 3474
;3468:
;3469:/*
;3470:==================
;3471:BotCheckAttack
;3472:==================
;3473:*/
;3474:void BotCheckAttack(bot_state_t *bs) {
line 3484
;3475:	float points, reactiontime, fov, firethrottle;
;3476:	int attackentity;
;3477:	bsp_trace_t bsptrace;
;3478:	//float selfpreservation;
;3479:	vec3_t forward, right, start, end, dir, angles;
;3480:	weaponinfo_t wi;
;3481:	bsp_trace_t trace;
;3482:	aas_entityinfo_t entinfo;
;3483:	weapon_t weapon;
;3484:	vec3_t mins = {-8, -8, -8}, maxs = {8, 8, 8};
ADDRLP4 952
ADDRGP4 $2045
INDIRB
ASGNB 12
ADDRLP4 964
ADDRGP4 $2046
INDIRB
ASGNB 12
line 3486
;3485:
;3486:	attackentity = bs->enemy;
ADDRLP4 576
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
ASGNI4
line 3488
;3487:	//
;3488:	BotEntityInfo(attackentity, &entinfo);
ADDRLP4 576
INDIRI4
ARGI4
ADDRLP4 792
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3490
;3489:	// if not attacking a player
;3490:	if (attackentity >= MAX_CLIENTS) {
ADDRLP4 576
INDIRI4
CNSTI4 64
LTI4 $2047
line 3492
;3491:		// if attacking an obelisk
;3492:		if ( entinfo.number == redobelisk.entitynum ||
ADDRLP4 792+20
INDIRI4
ADDRGP4 redobelisk+40
INDIRI4
EQI4 $2055
ADDRLP4 792+20
INDIRI4
ADDRGP4 blueobelisk+40
INDIRI4
NEI4 $2049
LABELV $2055
line 3493
;3493:			entinfo.number == blueobelisk.entitynum ) {
line 3495
;3494:			// if obelisk is respawning return
;3495:			if ( g_entities[entinfo.number].activator &&
ADDRLP4 792+20
INDIRI4
CNSTI4 832
MULI4
ADDRGP4 g_entities+772
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2056
ADDRLP4 792+20
INDIRI4
CNSTI4 832
MULI4
ADDRGP4 g_entities+772
ADDP4
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
CNSTI4 2
NEI4 $2056
line 3496
;3496:				g_entities[entinfo.number].activator->s.frame == 2 ) {
line 3497
;3497:				return;
ADDRGP4 $2044
JUMPV
LABELV $2056
line 3499
;3498:			}
;3499:		}
LABELV $2049
line 3500
;3500:	}
LABELV $2047
line 3502
;3501:	//
;3502:	reactiontime = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_REACTIONTIME, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 980
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 704
ADDRLP4 980
INDIRF4
ASGNF4
line 3503
;3503:	if (bs->enemysight_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 6132
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 704
INDIRF4
SUBF4
LEF4 $2062
ADDRGP4 $2044
JUMPV
LABELV $2062
line 3504
;3504:	if (bs->teleport_time > FloatTime() - reactiontime) return;
ADDRFP4 0
INDIRP4
CNSTI4 6180
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 704
INDIRF4
SUBF4
LEF4 $2064
ADDRGP4 $2044
JUMPV
LABELV $2064
line 3506
;3505:	//if changing weapons
;3506:	if (bs->weaponchange_time > FloatTime() - 0.1) return;
ADDRFP4 0
INDIRP4
CNSTI4 6192
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1036831949
SUBF4
LEF4 $2066
ADDRGP4 $2044
JUMPV
LABELV $2066
line 3508
;3507:	//check fire throttle characteristic
;3508:	if (bs->firethrottlewait_time > FloatTime()) return;
ADDRFP4 0
INDIRP4
CNSTI4 6196
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
LEF4 $2068
ADDRGP4 $2044
JUMPV
LABELV $2068
line 3509
;3509:	firethrottle = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_FIRETHROTTLE, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 47
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 984
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 936
ADDRLP4 984
INDIRF4
ASGNF4
line 3510
;3510:	if (bs->firethrottleshoot_time < FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6200
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $2070
line 3511
;3511:		if (random() > firethrottle) {
ADDRLP4 988
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 988
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ADDRLP4 936
INDIRF4
LEF4 $2072
line 3512
;3512:			bs->firethrottlewait_time = FloatTime() + firethrottle;
ADDRFP4 0
INDIRP4
CNSTI4 6196
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 936
INDIRF4
ADDF4
ASGNF4
line 3513
;3513:			bs->firethrottleshoot_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6200
ADDP4
CNSTF4 0
ASGNF4
line 3514
;3514:		}
ADDRGP4 $2073
JUMPV
LABELV $2072
line 3515
;3515:		else {
line 3516
;3516:			bs->firethrottleshoot_time = FloatTime() + 1 - firethrottle;
ADDRFP4 0
INDIRP4
CNSTI4 6200
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1065353216
ADDF4
ADDRLP4 936
INDIRF4
SUBF4
ASGNF4
line 3517
;3517:			bs->firethrottlewait_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6196
ADDP4
CNSTF4 0
ASGNF4
line 3518
;3518:		}
LABELV $2073
line 3519
;3519:	}
LABELV $2070
line 3522
;3520:	//
;3521:	//
;3522:	VectorSubtract(bs->aimtarget, bs->eye, dir);
ADDRLP4 988
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 580
ADDRLP4 988
INDIRP4
CNSTI4 6220
ADDP4
INDIRF4
ADDRLP4 988
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 580+4
ADDRLP4 988
INDIRP4
CNSTI4 6224
ADDP4
INDIRF4
ADDRLP4 988
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 992
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 580+8
ADDRLP4 992
INDIRP4
CNSTI4 6228
ADDP4
INDIRF4
ADDRLP4 992
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3524
;3523:	//
;3524:	if (bs->weaponnum == WP_GAUNTLET) {
ADDRFP4 0
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
CNSTI4 1
NEI4 $2076
line 3525
;3525:		if (VectorLengthSquared(dir) > Square(60)) {
ADDRLP4 580
ARGP4
ADDRLP4 996
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 996
INDIRF4
CNSTF4 1163984896
LEF4 $2078
line 3526
;3526:			return;
ADDRGP4 $2044
JUMPV
LABELV $2078
line 3528
;3527:		}
;3528:	}
LABELV $2076
line 3529
;3529:	if (VectorLengthSquared(dir) < Square(100))
ADDRLP4 580
ARGP4
ADDRLP4 996
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 996
INDIRF4
CNSTF4 1176256512
GEF4 $2080
line 3530
;3530:		fov = 120;
ADDRLP4 932
CNSTF4 1123024896
ASGNF4
ADDRGP4 $2081
JUMPV
LABELV $2080
line 3532
;3531:	else
;3532:		fov = 50;
ADDRLP4 932
CNSTF4 1112014848
ASGNF4
LABELV $2081
line 3534
;3533:	//
;3534:	vectoangles(dir, angles);
ADDRLP4 580
ARGP4
ADDRLP4 940
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3535
;3535:	if (!InFieldOfVision(bs->viewangles, fov, angles))
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRLP4 932
INDIRF4
ARGF4
ADDRLP4 940
ARGP4
ADDRLP4 1000
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 1000
INDIRI4
CNSTI4 0
NEI4 $2082
line 3536
;3536:		return;
ADDRGP4 $2044
JUMPV
LABELV $2082
line 3537
;3537:	BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, bs->aimtarget, bs->client, CONTENTS_SOLID|CONTENTS_PLAYERCLIP);
ADDRLP4 708
ARGP4
ADDRLP4 1004
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1004
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 1004
INDIRP4
CNSTI4 6220
ADDP4
ARGP4
ADDRLP4 1004
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 65537
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3538
;3538:	if (bsptrace.fraction < 1 && bsptrace.ent != attackentity)
ADDRLP4 708+8
INDIRF4
CNSTF4 1065353216
GEF4 $2084
ADDRLP4 708+80
INDIRI4
ADDRLP4 576
INDIRI4
EQI4 $2084
line 3539
;3539:		return;
ADDRGP4 $2044
JUMPV
LABELV $2084
line 3542
;3540:
;3541:	//get the weapon info
;3542:	trap_BotGetWeaponInfo(bs->ws, bs->weaponnum, &wi);
ADDRLP4 1008
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1008
INDIRP4
CNSTI4 6536
ADDP4
INDIRI4
ARGI4
ADDRLP4 1008
INDIRP4
CNSTI4 6560
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRGP4 trap_BotGetWeaponInfo
CALLV
pop
line 3544
;3543:	//get the start point shooting from
;3544:	VectorCopy(bs->origin, start);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 3545
;3545:	start[2] += bs->cur_ps.viewheight;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 3546
;3546:	AngleVectors(bs->viewangles, forward, right, NULL);
ADDRFP4 0
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 676
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 3547
;3547:	start[0] += forward[0] * wi.offset[0] + right[0] * wi.offset[1];
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
ADDRLP4 24+292
INDIRF4
MULF4
ADDRLP4 676
INDIRF4
ADDRLP4 24+292+4
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 3548
;3548:	start[1] += forward[1] * wi.offset[0] + right[1] * wi.offset[1];
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 24+292
INDIRF4
MULF4
ADDRLP4 676+4
INDIRF4
ADDRLP4 24+292+4
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 3549
;3549:	start[2] += forward[2] * wi.offset[0] + right[2] * wi.offset[1] + wi.offset[2];
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDRLP4 24+292
INDIRF4
MULF4
ADDRLP4 676+8
INDIRF4
ADDRLP4 24+292+4
INDIRF4
MULF4
ADDF4
ADDRLP4 24+292+8
INDIRF4
ADDF4
ADDF4
ASGNF4
line 3551
;3550:	//end point aiming at
;3551:	VectorMA(start, 1000, forward, end);
ADDRLP4 688
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 1148846080
MULF4
ADDF4
ASGNF4
ADDRLP4 688+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
CNSTF4 1148846080
MULF4
ADDF4
ASGNF4
ADDRLP4 688+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
CNSTF4 1148846080
MULF4
ADDF4
ASGNF4
line 3553
;3552:	//a little back to make sure not inside a very close enemy
;3553:	VectorMA(start, -12, forward, start);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 3242196992
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
CNSTF4 3242196992
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
CNSTF4 3242196992
MULF4
ADDF4
ASGNF4
line 3554
;3554:	BotAI_Trace(&trace, start, mins, maxs, end, bs->entitynum, MASK_SHOT);
ADDRLP4 592
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 952
ARGP4
ADDRLP4 964
ARGP4
ADDRLP4 688
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3556
;3555:	//if the entity is a client
;3556:	if (trace.ent >= 0 && trace.ent < MAX_CLIENTS) {
ADDRLP4 592+80
INDIRI4
CNSTI4 0
LTI4 $2118
ADDRLP4 592+80
INDIRI4
CNSTI4 64
GEI4 $2118
line 3557
;3557:		if (trace.ent != attackentity) {
ADDRLP4 592+80
INDIRI4
ADDRLP4 576
INDIRI4
EQI4 $2122
line 3559
;3558:			//if a teammate is hit
;3559:			if (BotSameTeam(bs, trace.ent))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 592+80
INDIRI4
ARGI4
ADDRLP4 1012
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1012
INDIRI4
CNSTI4 0
EQI4 $2125
line 3560
;3560:				return;
ADDRGP4 $2044
JUMPV
LABELV $2125
line 3561
;3561:		}
LABELV $2122
line 3562
;3562:	}
LABELV $2118
line 3564
;3563:	//if won't hit the enemy or not attacking a player (obelisk)
;3564:	if (trace.ent != attackentity || attackentity >= MAX_CLIENTS) {
ADDRLP4 592+80
INDIRI4
ADDRLP4 576
INDIRI4
NEI4 $2131
ADDRLP4 576
INDIRI4
CNSTI4 64
LTI4 $2128
LABELV $2131
line 3566
;3565:		//if the projectile does radial damage
;3566:		if (wi.proj.damagetype & DAMAGETYPE_RADIAL) {
ADDRLP4 24+344+180
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $2132
line 3567
;3567:			if (trace.fraction * 1000 < wi.proj.radius) {
ADDRLP4 592+8
INDIRF4
CNSTF4 1148846080
MULF4
ADDRLP4 24+344+172
INDIRF4
GEF4 $2136
line 3568
;3568:				points = (wi.proj.damage - 0.5 * trace.fraction * 1000) * 0.5;
ADDRLP4 976
ADDRLP4 24+344+168
INDIRI4
CVIF4 4
ADDRLP4 592+8
INDIRF4
CNSTF4 1140457472
MULF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3569
;3569:				if (points > 0) {
ADDRLP4 976
INDIRF4
CNSTF4 0
LEF4 $2144
line 3570
;3570:					return;
ADDRGP4 $2044
JUMPV
LABELV $2144
line 3572
;3571:				}
;3572:			}
LABELV $2136
line 3574
;3573:			//FIXME: check if a teammate gets radial damage
;3574:		}
LABELV $2132
line 3575
;3575:	}
LABELV $2128
line 3577
;3576:
;3577:	weapon = bs->cur_ps.weapon;
ADDRLP4 700
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ASGNI4
line 3578
;3578:	if ( weapon >= WP_MACHINEGUN && weapon <= WP_BFG && !bs->cur_ps.ammo[ weapon ] ) {
ADDRLP4 700
INDIRI4
CNSTI4 2
LTI4 $2146
ADDRLP4 700
INDIRI4
CNSTI4 9
GTI4 $2146
ADDRLP4 700
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 392
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2146
line 3579
;3579:		return;
ADDRGP4 $2044
JUMPV
LABELV $2146
line 3583
;3580:	}
;3581:
;3582:	//if fire has to be release to activate weapon
;3583:	if (wi.flags & WFL_FIRERELEASED) {
ADDRLP4 24+176
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2148
line 3584
;3584:		if (bs->flags & BFL_ATTACKED) {
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $2149
line 3585
;3585:			trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 3586
;3586:		}
line 3587
;3587:	}
ADDRGP4 $2149
JUMPV
LABELV $2148
line 3588
;3588:	else {
line 3589
;3589:		trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 3590
;3590:	}
LABELV $2149
line 3591
;3591:	bs->flags ^= BFL_ATTACKED;
ADDRLP4 1020
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 1020
INDIRP4
ADDRLP4 1020
INDIRP4
INDIRI4
CNSTI4 2
BXORI4
ASGNI4
line 3592
;3592:}
LABELV $2044
endproc BotCheckAttack 1024 28
data
align 4
LABELV $2157
byte 4 1143930880
byte 4 1129054208
byte 4 1143472128
align 4
LABELV $2158
byte 4 1148256256
byte 4 1139408896
byte 4 1143603200
align 4
LABELV $2159
byte 4 1134034944
byte 4 1135607808
byte 4 1147535360
export BotMapScripts
code
proc BotMapScripts 264 16
line 3599
;3593:
;3594:/*
;3595:==================
;3596:BotMapScripts
;3597:==================
;3598:*/
;3599:void BotMapScripts(bot_state_t *bs) {
line 3605
;3600:	int i, shootbutton;
;3601:	float aim_accuracy;
;3602:	aas_entityinfo_t entinfo;
;3603:	vec3_t dir;
;3604:
;3605:	if (!Q_stricmp(mapname, "q3tourney6")) {
ADDRGP4 mapname
ARGP4
ADDRGP4 $2156
ARGP4
ADDRLP4 164
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
NEI4 $2154
line 3606
;3606:		vec3_t mins = {700, 204, 672}, maxs = {964, 468, 680};
ADDRLP4 168
ADDRGP4 $2157
INDIRB
ASGNB 12
ADDRLP4 180
ADDRGP4 $2158
INDIRB
ASGNB 12
line 3607
;3607:		vec3_t buttonorg = {304, 352, 920};
ADDRLP4 192
ADDRGP4 $2159
INDIRB
ASGNB 12
line 3609
;3608:		//NOTE: NEVER use the func_bobbing in q3tourney6
;3609:		bs->tfl &= ~TFL_FUNCBOB;
ADDRLP4 204
ADDRFP4 0
INDIRP4
CNSTI4 5976
ADDP4
ASGNP4
ADDRLP4 204
INDIRP4
ADDRLP4 204
INDIRP4
INDIRI4
CNSTI4 -16777217
BANDI4
ASGNI4
line 3611
;3610:		//if the bot is below the bounding box
;3611:		if (bs->origin[0] > mins[0] && bs->origin[0] < maxs[0]) {
ADDRLP4 208
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 208
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 168
INDIRF4
LEF4 $2160
ADDRLP4 208
INDIRP4
CNSTI4 4908
ADDP4
INDIRF4
ADDRLP4 180
INDIRF4
GEF4 $2160
line 3612
;3612:			if (bs->origin[1] > mins[1] && bs->origin[1] < maxs[1]) {
ADDRLP4 212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 212
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 168+4
INDIRF4
LEF4 $2162
ADDRLP4 212
INDIRP4
CNSTI4 4912
ADDP4
INDIRF4
ADDRLP4 180+4
INDIRF4
GEF4 $2162
line 3613
;3613:				if (bs->origin[2] < mins[2]) {
ADDRFP4 0
INDIRP4
CNSTI4 4916
ADDP4
INDIRF4
ADDRLP4 168+8
INDIRF4
GEF4 $2166
line 3614
;3614:					return;
ADDRGP4 $2153
JUMPV
LABELV $2166
line 3616
;3615:				}
;3616:			}
LABELV $2162
line 3617
;3617:		}
LABELV $2160
line 3618
;3618:		shootbutton = qfalse;
ADDRLP4 144
CNSTI4 0
ASGNI4
line 3620
;3619:		//if an enemy is below this bounding box then shoot the button
;3620:		for (i = 0; i < level.maxclients; i++) {
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRGP4 $2172
JUMPV
LABELV $2169
line 3622
;3621:
;3622:			if (i == bs->client) continue;
ADDRLP4 140
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2174
ADDRGP4 $2170
JUMPV
LABELV $2174
line 3624
;3623:			//
;3624:			BotEntityInfo(i, &entinfo);
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 3626
;3625:			//
;3626:			if (!entinfo.valid) continue;
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2176
ADDRGP4 $2170
JUMPV
LABELV $2176
line 3628
;3627:			//if the enemy isn't dead and the enemy isn't the bot self
;3628:			if (EntityIsDead(&entinfo) || entinfo.number == bs->entitynum) continue;
ADDRLP4 0
ARGP4
ADDRLP4 212
ADDRGP4 EntityIsDead
CALLI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 0
NEI4 $2181
ADDRLP4 0+20
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $2178
LABELV $2181
ADDRGP4 $2170
JUMPV
LABELV $2178
line 3630
;3629:			//
;3630:			if (entinfo.origin[0] > mins[0] && entinfo.origin[0] < maxs[0]) {
ADDRLP4 0+24
INDIRF4
ADDRLP4 168
INDIRF4
LEF4 $2182
ADDRLP4 0+24
INDIRF4
ADDRLP4 180
INDIRF4
GEF4 $2182
line 3631
;3631:				if (entinfo.origin[1] > mins[1] && entinfo.origin[1] < maxs[1]) {
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 168+4
INDIRF4
LEF4 $2186
ADDRLP4 0+24+4
INDIRF4
ADDRLP4 180+4
INDIRF4
GEF4 $2186
line 3632
;3632:					if (entinfo.origin[2] < mins[2]) {
ADDRLP4 0+24+8
INDIRF4
ADDRLP4 168+8
INDIRF4
GEF4 $2194
line 3634
;3633:						//if there's a team mate below the crusher
;3634:						if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 140
INDIRI4
ARGI4
ADDRLP4 216
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 216
INDIRI4
CNSTI4 0
EQI4 $2199
line 3635
;3635:							shootbutton = qfalse;
ADDRLP4 144
CNSTI4 0
ASGNI4
line 3636
;3636:							break;
ADDRGP4 $2171
JUMPV
LABELV $2199
line 3638
;3637:						}
;3638:						else {
line 3639
;3639:							shootbutton = qtrue;
ADDRLP4 144
CNSTI4 1
ASGNI4
line 3640
;3640:						}
line 3641
;3641:					}
LABELV $2194
line 3642
;3642:				}
LABELV $2186
line 3643
;3643:			}
LABELV $2182
line 3644
;3644:		}
LABELV $2170
line 3620
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2172
ADDRLP4 140
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $2169
LABELV $2171
line 3645
;3645:		if (shootbutton) {
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $2155
line 3646
;3646:			bs->flags |= BFL_IDEALVIEWSET;
ADDRLP4 212
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 212
INDIRP4
ADDRLP4 212
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 3647
;3647:			VectorSubtract(buttonorg, bs->eye, dir);
ADDRLP4 216
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
ADDRLP4 192
INDIRF4
ADDRLP4 216
INDIRP4
CNSTI4 4936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 148+4
ADDRLP4 192+4
INDIRF4
ADDRLP4 216
INDIRP4
CNSTI4 4940
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 148+8
ADDRLP4 192+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 4944
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3648
;3648:			vectoangles(dir, bs->ideal_viewangles);
ADDRLP4 148
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 3649
;3649:			aim_accuracy = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_AIM_ACCURACY, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 7
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 220
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 160
ADDRLP4 220
INDIRF4
ASGNF4
line 3650
;3650:			bs->ideal_viewangles[PITCH] += 8 * crandom() * (1 - aim_accuracy);
ADDRLP4 224
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 228
ADDRFP4 0
INDIRP4
CNSTI4 6576
ADDP4
ASGNP4
ADDRLP4 228
INDIRP4
ADDRLP4 228
INDIRP4
INDIRF4
ADDRLP4 224
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1090519040
MULF4
CNSTF4 1065353216
ADDRLP4 160
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3651
;3651:			bs->ideal_viewangles[PITCH] = AngleMod(bs->ideal_viewangles[PITCH]);
ADDRLP4 232
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 232
INDIRP4
CNSTI4 6576
ADDP4
INDIRF4
ARGF4
ADDRLP4 236
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 232
INDIRP4
CNSTI4 6576
ADDP4
ADDRLP4 236
INDIRF4
ASGNF4
line 3652
;3652:			bs->ideal_viewangles[YAW] += 8 * crandom() * (1 - aim_accuracy);
ADDRLP4 240
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 244
ADDRFP4 0
INDIRP4
CNSTI4 6580
ADDP4
ASGNP4
ADDRLP4 244
INDIRP4
ADDRLP4 244
INDIRP4
INDIRF4
ADDRLP4 240
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1073741824
MULF4
CNSTF4 1090519040
MULF4
CNSTF4 1065353216
ADDRLP4 160
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 3653
;3653:			bs->ideal_viewangles[YAW] = AngleMod(bs->ideal_viewangles[YAW]);
ADDRLP4 248
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 248
INDIRP4
CNSTI4 6580
ADDP4
INDIRF4
ARGF4
ADDRLP4 252
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 248
INDIRP4
CNSTI4 6580
ADDP4
ADDRLP4 252
INDIRF4
ASGNF4
line 3655
;3654:			//
;3655:			if (InFieldOfVision(bs->viewangles, 20, bs->ideal_viewangles)) {
ADDRLP4 256
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 256
INDIRP4
CNSTI4 6564
ADDP4
ARGP4
CNSTF4 1101004800
ARGF4
ADDRLP4 256
INDIRP4
CNSTI4 6576
ADDP4
ARGP4
ADDRLP4 260
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
EQI4 $2155
line 3656
;3656:				trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 3657
;3657:			}
line 3658
;3658:		}
line 3659
;3659:	}
ADDRGP4 $2155
JUMPV
LABELV $2154
line 3660
;3660:	else if (!Q_stricmp(mapname, "mpq3tourney6")) {
ADDRGP4 mapname
ARGP4
ADDRGP4 $2211
ARGP4
ADDRLP4 168
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
NEI4 $2209
line 3662
;3661:		//NOTE: NEVER use the func_bobbing in mpq3tourney6
;3662:		bs->tfl &= ~TFL_FUNCBOB;
ADDRLP4 172
ADDRFP4 0
INDIRP4
CNSTI4 5976
ADDP4
ASGNP4
ADDRLP4 172
INDIRP4
ADDRLP4 172
INDIRP4
INDIRI4
CNSTI4 -16777217
BANDI4
ASGNI4
line 3663
;3663:	}
LABELV $2209
LABELV $2155
line 3664
;3664:}
LABELV $2153
endproc BotMapScripts 264 16
data
align 4
LABELV VEC_UP
byte 4 0
byte 4 3212836864
byte 4 0
align 4
LABELV MOVEDIR_UP
byte 4 0
byte 4 0
byte 4 1065353216
align 4
LABELV VEC_DOWN
byte 4 0
byte 4 3221225472
byte 4 0
align 4
LABELV MOVEDIR_DOWN
byte 4 0
byte 4 0
byte 4 3212836864
export BotSetMovedir
code
proc BotSetMovedir 8 16
line 3677
;3665:
;3666:/*
;3667:==================
;3668:BotSetMovedir
;3669:==================
;3670:*/
;3671:// bk001205 - made these static
;3672:static vec3_t VEC_UP		= {0, -1,  0};
;3673:static vec3_t MOVEDIR_UP	= {0,  0,  1};
;3674:static vec3_t VEC_DOWN		= {0, -2,  0};
;3675:static vec3_t MOVEDIR_DOWN	= {0,  0, -1};
;3676:
;3677:void BotSetMovedir(vec3_t angles, vec3_t movedir) {
line 3678
;3678:	if (VectorCompare(angles, VEC_UP)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 VEC_UP
ARGP4
ADDRLP4 0
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2213
line 3679
;3679:		VectorCopy(MOVEDIR_UP, movedir);
ADDRFP4 4
INDIRP4
ADDRGP4 MOVEDIR_UP
INDIRB
ASGNB 12
line 3680
;3680:	}
ADDRGP4 $2214
JUMPV
LABELV $2213
line 3681
;3681:	else if (VectorCompare(angles, VEC_DOWN)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 VEC_DOWN
ARGP4
ADDRLP4 4
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2215
line 3682
;3682:		VectorCopy(MOVEDIR_DOWN, movedir);
ADDRFP4 4
INDIRP4
ADDRGP4 MOVEDIR_DOWN
INDIRB
ASGNB 12
line 3683
;3683:	}
ADDRGP4 $2216
JUMPV
LABELV $2215
line 3684
;3684:	else {
line 3685
;3685:		AngleVectors(angles, movedir, NULL, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 3686
;3686:	}
LABELV $2216
LABELV $2214
line 3687
;3687:}
LABELV $2212
endproc BotSetMovedir 8 16
export BotModelMinsMaxs
proc BotModelMinsMaxs 40 0
line 3696
;3688:
;3689:/*
;3690:==================
;3691:BotModelMinsMaxs
;3692:
;3693:this is ugly
;3694:==================
;3695:*/
;3696:int BotModelMinsMaxs(int modelindex, int eType, int contents, vec3_t mins, vec3_t maxs) {
line 3700
;3697:	gentity_t *ent;
;3698:	int i;
;3699:
;3700:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 3701
;3701:	for (i = 0; i < level.num_entities; i++, ent++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2221
JUMPV
LABELV $2218
line 3702
;3702:		if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2223
line 3703
;3703:			continue;
ADDRGP4 $2219
JUMPV
LABELV $2223
line 3705
;3704:		}
;3705:		if ( eType && ent->s.eType != eType) {
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $2225
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $2225
line 3706
;3706:			continue;
ADDRGP4 $2219
JUMPV
LABELV $2225
line 3708
;3707:		}
;3708:		if ( contents && ent->r.contents != contents) {
ADDRLP4 12
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2227
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $2227
line 3709
;3709:			continue;
ADDRGP4 $2219
JUMPV
LABELV $2227
line 3711
;3710:		}
;3711:		if (ent->s.modelindex == modelindex) {
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $2229
line 3712
;3712:			if (mins)
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2231
line 3713
;3713:				VectorAdd(ent->r.currentOrigin, ent->r.mins, mins);
ADDRFP4 12
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDF4
ASGNF4
LABELV $2231
line 3714
;3714:			if (maxs)
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2233
line 3715
;3715:				VectorAdd(ent->r.currentOrigin, ent->r.maxs, maxs);
ADDRFP4 16
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
ASGNF4
LABELV $2233
line 3716
;3716:			return i;
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $2217
JUMPV
LABELV $2229
line 3718
;3717:		}
;3718:	}
LABELV $2219
line 3701
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 832
ADDP4
ASGNP4
LABELV $2221
ADDRLP4 4
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $2218
line 3719
;3719:	if (mins)
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2235
line 3720
;3720:		VectorClear(mins);
ADDRFP4 12
INDIRP4
CNSTF4 0
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
LABELV $2235
line 3721
;3721:	if (maxs)
ADDRFP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2237
line 3722
;3722:		VectorClear(maxs);
ADDRFP4 16
INDIRP4
CNSTF4 0
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
LABELV $2237
line 3723
;3723:	return 0;
CNSTI4 0
RETI4
LABELV $2217
endproc BotModelMinsMaxs 40 0
data
align 4
LABELV $2240
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
align 4
LABELV $2241
byte 4 3212836864
byte 4 3212836864
byte 4 3212836864
export BotFuncButtonActivateGoal
code
proc BotFuncButtonActivateGoal 628 28
line 3731
;3724:}
;3725:
;3726:/*
;3727:==================
;3728:BotFuncButtonGoal
;3729:==================
;3730:*/
;3731:int BotFuncButtonActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
line 3737
;3732:	int i, areas[10], numareas, modelindex, entitynum;
;3733:	char model[128];
;3734:	float lip, dist, health, angle;
;3735:	vec3_t size, start, end, mins, maxs, angles, points[10];
;3736:	vec3_t movedir, origin, goalorigin, bboxmins, bboxmaxs;
;3737:	vec3_t extramins = {1, 1, 1}, extramaxs = {-1, -1, -1};
ADDRLP4 304
ADDRGP4 $2240
INDIRB
ASGNB 12
ADDRLP4 316
ADDRGP4 $2241
INDIRB
ASGNB 12
line 3740
;3738:	bsp_trace_t bsptrace;
;3739:
;3740:	activategoal->shoot = qfalse;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 3741
;3741:	VectorClear(activategoal->target);
ADDRFP4 8
INDIRP4
CNSTI4 80
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 84
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 88
ADDP4
CNSTF4 0
ASGNF4
line 3743
;3742:	//create a bot goal towards the button
;3743:	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof(model));
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $523
ARGP4
ADDRLP4 160
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 3744
;3744:	if (!*model)
ADDRLP4 160
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2242
line 3745
;3745:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2239
JUMPV
LABELV $2242
line 3746
;3746:	modelindex = atoi(model+1);
ADDRLP4 160+1
ARGP4
ADDRLP4 560
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 288
ADDRLP4 560
INDIRI4
ASGNI4
line 3747
;3747:	if (!modelindex)
ADDRLP4 288
INDIRI4
CNSTI4 0
NEI4 $2245
line 3748
;3748:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2239
JUMPV
LABELV $2245
line 3749
;3749:	VectorClear(angles);
ADDRLP4 96
CNSTF4 0
ASGNF4
ADDRLP4 96+4
CNSTF4 0
ASGNF4
ADDRLP4 96+8
CNSTF4 0
ASGNF4
line 3750
;3750:	entitynum = BotModelMinsMaxs(modelindex, ET_MOVER, 0, mins, maxs);
ADDRLP4 288
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 72
ARGP4
ADDRLP4 84
ARGP4
ADDRLP4 564
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 344
ADDRLP4 564
INDIRI4
ASGNI4
line 3752
;3751:	//get the lip of the button
;3752:	trap_AAS_FloatForBSPEpairKey(bspent, "lip", &lip);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $2249
ARGP4
ADDRLP4 328
ARGP4
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
pop
line 3753
;3753:	if (!lip) lip = 4;
ADDRLP4 328
INDIRF4
CNSTF4 0
NEF4 $2250
ADDRLP4 328
CNSTF4 1082130432
ASGNF4
LABELV $2250
line 3755
;3754:	//get the move direction from the angle
;3755:	trap_AAS_FloatForBSPEpairKey(bspent, "angle", &angle);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $2252
ARGP4
ADDRLP4 352
ARGP4
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
pop
line 3756
;3756:	VectorSet(angles, 0, angle, 0);
ADDRLP4 96
CNSTF4 0
ASGNF4
ADDRLP4 96+4
ADDRLP4 352
INDIRF4
ASGNF4
ADDRLP4 96+8
CNSTF4 0
ASGNF4
line 3757
;3757:	BotSetMovedir(angles, movedir);
ADDRLP4 96
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 BotSetMovedir
CALLV
pop
line 3759
;3758:	//button size
;3759:	VectorSubtract(maxs, mins, size);
ADDRLP4 112
ADDRLP4 84
INDIRF4
ADDRLP4 72
INDIRF4
SUBF4
ASGNF4
ADDRLP4 112+4
ADDRLP4 84+4
INDIRF4
ADDRLP4 72+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 112+8
ADDRLP4 84+8
INDIRF4
ADDRLP4 72+8
INDIRF4
SUBF4
ASGNF4
line 3761
;3760:	//button origin
;3761:	VectorAdd(mins, maxs, origin);
ADDRLP4 16
ADDRLP4 72
INDIRF4
ADDRLP4 84
INDIRF4
ADDF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 72+4
INDIRF4
ADDRLP4 84+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 72+8
INDIRF4
ADDRLP4 84+8
INDIRF4
ADDF4
ASGNF4
line 3762
;3762:	VectorScale(origin, 0.5, origin);
ADDRLP4 16
ADDRLP4 16
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 16+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 16+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3764
;3763:	//touch distance of the button
;3764:	dist = fabs(movedir[0]) * size[0] + fabs(movedir[1]) * size[1] + fabs(movedir[2]) * size[2];
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 568
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4+4
INDIRF4
ARGF4
ADDRLP4 572
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 4+8
INDIRF4
ARGF4
ADDRLP4 576
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 568
INDIRF4
ADDRLP4 112
INDIRF4
MULF4
ADDRLP4 572
INDIRF4
ADDRLP4 112+4
INDIRF4
MULF4
ADDF4
ADDRLP4 576
INDIRF4
ADDRLP4 112+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 3765
;3765:	dist *= 0.5;
ADDRLP4 28
ADDRLP4 28
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3767
;3766:	//
;3767:	trap_AAS_FloatForBSPEpairKey(bspent, "health", &health);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $2275
ARGP4
ADDRLP4 348
ARGP4
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
pop
line 3769
;3768:	//if the button is shootable
;3769:	if (health) {
ADDRLP4 348
INDIRF4
CNSTF4 0
EQF4 $2276
line 3771
;3770:		//calculate the shoot target
;3771:		VectorMA(origin, -dist, movedir, goalorigin);
ADDRLP4 580
ADDRLP4 28
INDIRF4
NEGF4
ASGNF4
ADDRLP4 124
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 580
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 580
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 3773
;3772:		//
;3773:		VectorCopy(goalorigin, activategoal->target);
ADDRFP4 8
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 124
INDIRB
ASGNB 12
line 3774
;3774:		activategoal->shoot = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 1
ASGNI4
line 3776
;3775:		//
;3776:		BotAI_Trace(&bsptrace, bs->eye, NULL, NULL, goalorigin, bs->entitynum, MASK_SHOT);
ADDRLP4 356
ARGP4
ADDRLP4 584
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 584
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 124
ARGP4
ADDRLP4 584
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 BotAI_Trace
CALLV
pop
line 3778
;3777:		// if the button is visible from the current position
;3778:		if (bsptrace.fraction >= 1.0 || bsptrace.ent == entitynum) {
ADDRLP4 356+8
INDIRF4
CNSTF4 1065353216
GEF4 $2288
ADDRLP4 356+80
INDIRI4
ADDRLP4 344
INDIRI4
NEI4 $2284
LABELV $2288
line 3780
;3779:			//
;3780:			activategoal->goal.entitynum = entitynum; //NOTE: this is the entity number of the shootable button
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 344
INDIRI4
ASGNI4
line 3781
;3781:			activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 3782
;3782:			activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 3783
;3783:			VectorCopy(bs->origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 3784
;3784:			activategoal->goal.areanum = bs->areanum;
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ASGNI4
line 3785
;3785:			VectorSet(activategoal->goal.mins, -8, -8, -8);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 3238002688
ASGNF4
line 3786
;3786:			VectorSet(activategoal->goal.maxs, 8, 8, 8);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1090519040
ASGNF4
line 3788
;3787:			//
;3788:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2239
JUMPV
LABELV $2284
line 3790
;3789:		}
;3790:		else {
line 3793
;3791:			//create a goal from where the button is visible and shoot at the button from there
;3792:			//add bounding box size to the dist
;3793:			trap_AAS_PresenceTypeBoundingBox(PRESENCE_CROUCH, bboxmins, bboxmaxs);
CNSTI4 4
ARGI4
ADDRLP4 136
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 trap_AAS_PresenceTypeBoundingBox
CALLV
pop
line 3794
;3794:			for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2289
line 3795
;3795:				if (movedir[i] < 0) dist += fabs(movedir[i]) * fabs(bboxmaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $2293
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 588
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
ADDP4
INDIRF4
ARGF4
ADDRLP4 592
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 588
INDIRF4
ADDRLP4 592
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $2294
JUMPV
LABELV $2293
line 3796
;3796:				else dist += fabs(movedir[i]) * fabs(bboxmins[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 596
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 136
ADDP4
INDIRF4
ARGF4
ADDRLP4 600
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 596
INDIRF4
ADDRLP4 600
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $2294
line 3797
;3797:			}
LABELV $2290
line 3794
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $2289
line 3799
;3798:			//calculate the goal origin
;3799:			VectorMA(origin, -dist, movedir, goalorigin);
ADDRLP4 588
ADDRLP4 28
INDIRF4
NEGF4
ASGNF4
ADDRLP4 124
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 588
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 588
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 3801
;3800:			//
;3801:			VectorCopy(goalorigin, start);
ADDRLP4 292
ADDRLP4 124
INDIRB
ASGNB 12
line 3802
;3802:			start[2] += 24;
ADDRLP4 292+8
ADDRLP4 292+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 3803
;3803:			VectorCopy(start, end);
ADDRLP4 332
ADDRLP4 292
INDIRB
ASGNB 12
line 3804
;3804:			end[2] -= 512;
ADDRLP4 332+8
ADDRLP4 332+8
INDIRF4
CNSTF4 1140850688
SUBF4
ASGNF4
line 3805
;3805:			numareas = trap_AAS_TraceAreas(start, end, areas, points, 10);
ADDRLP4 292
ARGP4
ADDRLP4 332
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 440
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 592
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 108
ADDRLP4 592
INDIRI4
ASGNI4
line 3807
;3806:			//
;3807:			for (i = numareas-1; i >= 0; i--) {
ADDRLP4 0
ADDRLP4 108
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $2306
JUMPV
LABELV $2303
line 3808
;3808:				if (trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ARGI4
ADDRLP4 596
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 596
INDIRI4
CNSTI4 0
EQI4 $2307
line 3809
;3809:					break;
ADDRGP4 $2305
JUMPV
LABELV $2307
line 3811
;3810:				}
;3811:			}
LABELV $2304
line 3807
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $2306
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $2303
LABELV $2305
line 3812
;3812:			if (i < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $2309
line 3814
;3813:				// FIXME: trace forward and maybe in other directions to find a valid area
;3814:			}
LABELV $2309
line 3815
;3815:			if (i >= 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $2311
line 3817
;3816:				//
;3817:				VectorCopy(points[i], activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 440
ADDP4
INDIRB
ASGNB 12
line 3818
;3818:				activategoal->goal.areanum = areas[i];
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ASGNI4
line 3819
;3819:				VectorSet(activategoal->goal.mins, 8, 8, 8);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1090519040
ASGNF4
line 3820
;3820:				VectorSet(activategoal->goal.maxs, -8, -8, -8);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 3238002688
ASGNF4
line 3822
;3821:				//
;3822:				for (i = 0; i < 3; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2313
line 3823
;3823:				{
line 3824
;3824:					if (movedir[i] < 0) activategoal->goal.maxs[i] += fabs(movedir[i]) * fabs(extramaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $2317
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 600
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 316
ADDP4
INDIRF4
ARGF4
ADDRLP4 604
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 608
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 608
INDIRP4
ADDRLP4 608
INDIRP4
INDIRF4
ADDRLP4 600
INDIRF4
ADDRLP4 604
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $2318
JUMPV
LABELV $2317
line 3825
;3825:					else activategoal->goal.mins[i] += fabs(movedir[i]) * fabs(extramins[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 616
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 304
ADDP4
INDIRF4
ARGF4
ADDRLP4 620
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 624
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDP4
ASGNP4
ADDRLP4 624
INDIRP4
ADDRLP4 624
INDIRP4
INDIRF4
ADDRLP4 616
INDIRF4
ADDRLP4 620
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $2318
line 3826
;3826:				} //end for
LABELV $2314
line 3822
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $2313
line 3828
;3827:				//
;3828:				activategoal->goal.entitynum = entitynum;
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 344
INDIRI4
ASGNI4
line 3829
;3829:				activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 3830
;3830:				activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 3831
;3831:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2239
JUMPV
LABELV $2311
line 3833
;3832:			}
;3833:		}
line 3834
;3834:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2239
JUMPV
LABELV $2276
line 3836
;3835:	}
;3836:	else {
line 3838
;3837:		//add bounding box size to the dist
;3838:		trap_AAS_PresenceTypeBoundingBox(PRESENCE_CROUCH, bboxmins, bboxmaxs);
CNSTI4 4
ARGI4
ADDRLP4 136
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 trap_AAS_PresenceTypeBoundingBox
CALLV
pop
line 3839
;3839:		for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2319
line 3840
;3840:			if (movedir[i] < 0) dist += fabs(movedir[i]) * fabs(bboxmaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $2323
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 580
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
ADDP4
INDIRF4
ARGF4
ADDRLP4 584
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 580
INDIRF4
ADDRLP4 584
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $2324
JUMPV
LABELV $2323
line 3841
;3841:			else dist += fabs(movedir[i]) * fabs(bboxmins[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 588
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 136
ADDP4
INDIRF4
ARGF4
ADDRLP4 592
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 588
INDIRF4
ADDRLP4 592
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $2324
line 3842
;3842:		}
LABELV $2320
line 3839
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $2319
line 3844
;3843:		//calculate the goal origin
;3844:		VectorMA(origin, -dist, movedir, goalorigin);
ADDRLP4 580
ADDRLP4 28
INDIRF4
NEGF4
ASGNF4
ADDRLP4 124
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 580
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+4
ADDRLP4 16+4
INDIRF4
ADDRLP4 4+4
INDIRF4
ADDRLP4 580
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 124+8
ADDRLP4 16+8
INDIRF4
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 3846
;3845:		//
;3846:		VectorCopy(goalorigin, start);
ADDRLP4 292
ADDRLP4 124
INDIRB
ASGNB 12
line 3847
;3847:		start[2] += 24;
ADDRLP4 292+8
ADDRLP4 292+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 3848
;3848:		VectorCopy(start, end);
ADDRLP4 332
ADDRLP4 292
INDIRB
ASGNB 12
line 3849
;3849:		end[2] -= 100;
ADDRLP4 332+8
ADDRLP4 332+8
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 3850
;3850:		numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
ADDRLP4 292
ARGP4
ADDRLP4 332
ARGP4
ADDRLP4 32
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 584
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 108
ADDRLP4 584
INDIRI4
ASGNI4
line 3852
;3851:		//
;3852:		for (i = 0; i < numareas; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2336
JUMPV
LABELV $2333
line 3853
;3853:			if (trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ARGI4
ADDRLP4 588
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 588
INDIRI4
CNSTI4 0
EQI4 $2337
line 3854
;3854:				break;
ADDRGP4 $2335
JUMPV
LABELV $2337
line 3856
;3855:			}
;3856:		}
LABELV $2334
line 3852
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2336
ADDRLP4 0
INDIRI4
ADDRLP4 108
INDIRI4
LTI4 $2333
LABELV $2335
line 3857
;3857:		if (i < numareas) {
ADDRLP4 0
INDIRI4
ADDRLP4 108
INDIRI4
GEI4 $2339
line 3859
;3858:			//
;3859:			VectorCopy(origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 16
INDIRB
ASGNB 12
line 3860
;3860:			activategoal->goal.areanum = areas[i];
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
ADDP4
INDIRI4
ASGNI4
line 3861
;3861:			VectorSubtract(mins, origin, activategoal->goal.mins);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 72
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 72+4
INDIRF4
ADDRLP4 16+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 72+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
ASGNF4
line 3862
;3862:			VectorSubtract(maxs, origin, activategoal->goal.maxs);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 84
INDIRF4
ADDRLP4 16
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 84+4
INDIRF4
ADDRLP4 16+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 84+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
ASGNF4
line 3864
;3863:			//
;3864:			for (i = 0; i < 3; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2349
line 3865
;3865:			{
line 3866
;3866:				if (movedir[i] < 0) activategoal->goal.maxs[i] += fabs(movedir[i]) * fabs(extramaxs[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $2353
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 592
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 316
ADDP4
INDIRF4
ARGF4
ADDRLP4 596
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 600
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 600
INDIRP4
ADDRLP4 600
INDIRP4
INDIRF4
ADDRLP4 592
INDIRF4
ADDRLP4 596
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 $2354
JUMPV
LABELV $2353
line 3867
;3867:				else activategoal->goal.mins[i] += fabs(movedir[i]) * fabs(extramins[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 608
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 304
ADDP4
INDIRF4
ARGF4
ADDRLP4 612
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 616
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDP4
ASGNP4
ADDRLP4 616
INDIRP4
ADDRLP4 616
INDIRP4
INDIRF4
ADDRLP4 608
INDIRF4
ADDRLP4 612
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $2354
line 3868
;3868:			} //end for
LABELV $2350
line 3864
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $2349
line 3870
;3869:			//
;3870:			activategoal->goal.entitynum = entitynum;
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 344
INDIRI4
ASGNI4
line 3871
;3871:			activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 3872
;3872:			activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 3873
;3873:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2239
JUMPV
LABELV $2339
line 3875
;3874:		}
;3875:	}
line 3876
;3876:	return qfalse;
CNSTI4 0
RETI4
LABELV $2239
endproc BotFuncButtonActivateGoal 628 28
export BotFuncDoorActivateGoal
proc BotFuncDoorActivateGoal 1076 20
line 3884
;3877:}
;3878:
;3879:/*
;3880:==================
;3881:BotFuncDoorGoal
;3882:==================
;3883:*/
;3884:int BotFuncDoorActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
line 3891
;3885:	int modelindex, entitynum;
;3886:	char model[MAX_INFO_STRING];
;3887:	vec3_t mins, maxs, origin;
;3888:	//vec3_t angles;
;3889:
;3890:	//shoot at the shootable door
;3891:	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof(model));
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $523
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 3892
;3892:	if (!*model)
ADDRLP4 12
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2356
line 3893
;3893:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2355
JUMPV
LABELV $2356
line 3894
;3894:	modelindex = atoi(model+1);
ADDRLP4 12+1
ARGP4
ADDRLP4 1068
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1060
ADDRLP4 1068
INDIRI4
ASGNI4
line 3895
;3895:	if (!modelindex)
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $2359
line 3896
;3896:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2355
JUMPV
LABELV $2359
line 3898
;3897:	//VectorClear(angles);
;3898:	entitynum = BotModelMinsMaxs(modelindex, ET_MOVER, 0, mins, maxs);
ADDRLP4 1060
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 1036
ARGP4
ADDRLP4 1048
ARGP4
ADDRLP4 1072
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 1064
ADDRLP4 1072
INDIRI4
ASGNI4
line 3900
;3899:	//door origin
;3900:	VectorAdd(mins, maxs, origin);
ADDRLP4 0
ADDRLP4 1036
INDIRF4
ADDRLP4 1048
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 1036+4
INDIRF4
ADDRLP4 1048+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 1036+8
INDIRF4
ADDRLP4 1048+8
INDIRF4
ADDF4
ASGNF4
line 3901
;3901:	VectorScale(origin, 0.5, origin);
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3902
;3902:	VectorCopy(origin, activategoal->target);
ADDRFP4 8
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 3903
;3903:	activategoal->shoot = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 1
ASGNI4
line 3905
;3904:	//
;3905:	activategoal->goal.entitynum = entitynum; //NOTE: this is the entity number of the shootable door
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 1064
INDIRI4
ASGNI4
line 3906
;3906:	activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 3907
;3907:	activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 3908
;3908:	VectorCopy(bs->origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 3909
;3909:	activategoal->goal.areanum = bs->areanum;
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ASGNI4
line 3910
;3910:	VectorSet(activategoal->goal.mins, -8, -8, -8);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 3238002688
ASGNF4
line 3911
;3911:	VectorSet(activategoal->goal.maxs, 8, 8, 8);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1090519040
ASGNF4
line 3912
;3912:	return qtrue;
CNSTI4 1
RETI4
LABELV $2355
endproc BotFuncDoorActivateGoal 1076 20
export BotTriggerMultipleActivateGoal
proc BotTriggerMultipleActivateGoal 272 20
line 3920
;3913:}
;3914:
;3915:/*
;3916:==================
;3917:BotTriggerMultipleGoal
;3918:==================
;3919:*/
;3920:int BotTriggerMultipleActivateGoal(bot_state_t *bs, int bspent, bot_activategoal_t *activategoal) {
line 3927
;3921:	int i, areas[10], numareas, modelindex, entitynum;
;3922:	char model[128];
;3923:	vec3_t start, end, mins, maxs;
;3924:	//vec3_t angles;
;3925:	vec3_t origin, goalorigin;
;3926:
;3927:	activategoal->shoot = qfalse;
ADDRFP4 8
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 3928
;3928:	VectorClear(activategoal->target);
ADDRFP4 8
INDIRP4
CNSTI4 80
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 84
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 88
ADDP4
CNSTF4 0
ASGNF4
line 3930
;3929:	//create a bot goal towards the trigger
;3930:	trap_AAS_ValueForBSPEpairKey(bspent, "model", model, sizeof(model));
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $523
ARGP4
ADDRLP4 84
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 3931
;3931:	if (!*model)
ADDRLP4 84
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2372
line 3932
;3932:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2371
JUMPV
LABELV $2372
line 3933
;3933:	modelindex = atoi(model+1);
ADDRLP4 84+1
ARGP4
ADDRLP4 256
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 224
ADDRLP4 256
INDIRI4
ASGNI4
line 3934
;3934:	if (!modelindex)
ADDRLP4 224
INDIRI4
CNSTI4 0
NEI4 $2375
line 3935
;3935:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2371
JUMPV
LABELV $2375
line 3937
;3936:	//VectorClear(angles);
;3937:	entitynum = BotModelMinsMaxs(modelindex, 0, CONTENTS_TRIGGER, mins, maxs);
ADDRLP4 224
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1073741824
ARGI4
ADDRLP4 60
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 260
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 252
ADDRLP4 260
INDIRI4
ASGNI4
line 3939
;3938:	//trigger origin
;3939:	VectorAdd(mins, maxs, origin);
ADDRLP4 4
ADDRLP4 60
INDIRF4
ADDRLP4 72
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 60+4
INDIRF4
ADDRLP4 72+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 60+8
INDIRF4
ADDRLP4 72+8
INDIRF4
ADDF4
ASGNF4
line 3940
;3940:	VectorScale(origin, 0.5, origin);
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3941
;3941:	VectorCopy(origin, goalorigin);
ADDRLP4 240
ADDRLP4 4
INDIRB
ASGNB 12
line 3943
;3942:	//
;3943:	VectorCopy(goalorigin, start);
ADDRLP4 212
ADDRLP4 240
INDIRB
ASGNB 12
line 3944
;3944:	start[2] += 24;
ADDRLP4 212+8
ADDRLP4 212+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 3945
;3945:	VectorCopy(start, end);
ADDRLP4 228
ADDRLP4 212
INDIRB
ASGNB 12
line 3946
;3946:	end[2] -= 100;
ADDRLP4 228+8
ADDRLP4 228+8
INDIRF4
CNSTF4 1120403456
SUBF4
ASGNF4
line 3947
;3947:	numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
ADDRLP4 212
ARGP4
ADDRLP4 228
ARGP4
ADDRLP4 20
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 264
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 264
INDIRI4
ASGNI4
line 3949
;3948:	//
;3949:	for (i = 0; i < numareas; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2392
JUMPV
LABELV $2389
line 3950
;3950:		if (trap_AAS_AreaReachability(areas[i])) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 268
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 0
EQI4 $2393
line 3951
;3951:			break;
ADDRGP4 $2391
JUMPV
LABELV $2393
line 3953
;3952:		}
;3953:	}
LABELV $2390
line 3949
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2392
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $2389
LABELV $2391
line 3954
;3954:	if (i < numareas) {
ADDRLP4 0
INDIRI4
ADDRLP4 16
INDIRI4
GEI4 $2395
line 3955
;3955:		VectorCopy(origin, activategoal->goal.origin);
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 3956
;3956:		activategoal->goal.areanum = areas[i];
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
ADDP4
INDIRI4
ASGNI4
line 3957
;3957:		VectorSubtract(mins, origin, activategoal->goal.mins);
ADDRFP4 8
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 60
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 60+4
INDIRF4
ADDRLP4 4+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 60+8
INDIRF4
ADDRLP4 4+8
INDIRF4
SUBF4
ASGNF4
line 3958
;3958:		VectorSubtract(maxs, origin, activategoal->goal.maxs);
ADDRFP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 72
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 72+4
INDIRF4
ADDRLP4 4+4
INDIRF4
SUBF4
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 72+8
INDIRF4
ADDRLP4 4+8
INDIRF4
SUBF4
ASGNF4
line 3960
;3959:		//
;3960:		activategoal->goal.entitynum = entitynum;
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 252
INDIRI4
ASGNI4
line 3961
;3961:		activategoal->goal.number = 0;
ADDRFP4 8
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 3962
;3962:		activategoal->goal.flags = 0;
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 3963
;3963:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2371
JUMPV
LABELV $2395
line 3965
;3964:	}
;3965:	return qfalse;
CNSTI4 0
RETI4
LABELV $2371
endproc BotTriggerMultipleActivateGoal 272 20
export BotPopFromActivateGoalStack
proc BotPopFromActivateGoalStack 4 8
line 3973
;3966:}
;3967:
;3968:/*
;3969:==================
;3970:BotPopFromActivateGoalStack
;3971:==================
;3972:*/
;3973:int BotPopFromActivateGoalStack(bot_state_t *bs) {
line 3974
;3974:	if (!bs->activatestack)
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2406
line 3975
;3975:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2405
JUMPV
LABELV $2406
line 3976
;3976:	BotEnableActivateGoalAreas(bs->activatestack, qtrue);
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 3977
;3977:	bs->activatestack->inuse = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 0
ASGNI4
line 3978
;3978:	bs->activatestack->justused_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 68
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 3979
;3979:	bs->activatestack = bs->activatestack->next;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 7120
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 3980
;3980:	return qtrue;
CNSTI4 1
RETI4
LABELV $2405
endproc BotPopFromActivateGoalStack 4 8
export BotPushOntoActivateGoalStack
proc BotPushOntoActivateGoalStack 20 12
line 3988
;3981:}
;3982:
;3983:/*
;3984:==================
;3985:BotPushOntoActivateGoalStack
;3986:==================
;3987:*/
;3988:int BotPushOntoActivateGoalStack(bot_state_t *bs, bot_activategoal_t *activategoal) {
line 3992
;3989:	int i, best;
;3990:	float besttime;
;3991:
;3992:	best = -1;
ADDRLP4 8
CNSTI4 -1
ASGNI4
line 3993
;3993:	besttime = FloatTime() + 9999;
ADDRLP4 4
ADDRGP4 floattime
INDIRF4
CNSTF4 1176255488
ADDF4
ASGNF4
line 3995
;3994:	//
;3995:	for (i = 0; i < MAX_ACTIVATESTACK; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2409
line 3996
;3996:		if (!bs->activategoalheap[i].inuse) {
ADDRLP4 0
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2413
line 3997
;3997:			if (bs->activategoalheap[i].justused_time < besttime) {
ADDRLP4 0
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
CNSTI4 68
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
GEF4 $2415
line 3998
;3998:				besttime = bs->activategoalheap[i].justused_time;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
CNSTI4 68
ADDP4
INDIRF4
ASGNF4
line 3999
;3999:				best = i;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ASGNI4
line 4000
;4000:			}
LABELV $2415
line 4001
;4001:		}
LABELV $2413
line 4002
;4002:	}
LABELV $2410
line 3995
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 8
LTI4 $2409
line 4003
;4003:	if (best != -1) {
ADDRLP4 8
INDIRI4
CNSTI4 -1
EQI4 $2417
line 4004
;4004:		memcpy(&bs->activategoalheap[best], activategoal, sizeof(bot_activategoal_t));
ADDRLP4 8
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 244
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 4005
;4005:		bs->activategoalheap[best].inuse = qtrue;
ADDRLP4 8
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
CNSTI4 1
ASGNI4
line 4006
;4006:		bs->activategoalheap[best].next = bs->activatestack;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRI4
CNSTI4 244
MULI4
ADDRLP4 12
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
CNSTI4 240
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
ASGNP4
line 4007
;4007:		bs->activatestack = &bs->activategoalheap[best];
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 7120
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 244
MULI4
ADDRLP4 16
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
ASGNP4
line 4008
;4008:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2408
JUMPV
LABELV $2417
line 4010
;4009:	}
;4010:	return qfalse;
CNSTI4 0
RETI4
LABELV $2408
endproc BotPushOntoActivateGoalStack 20 12
export BotClearActivateGoalStack
proc BotClearActivateGoalStack 0 4
line 4018
;4011:}
;4012:
;4013:/*
;4014:==================
;4015:BotClearActivateGoalStack
;4016:==================
;4017:*/
;4018:void BotClearActivateGoalStack(bot_state_t *bs) {
ADDRGP4 $2421
JUMPV
LABELV $2420
line 4020
;4019:	while(bs->activatestack)
;4020:		BotPopFromActivateGoalStack(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotPopFromActivateGoalStack
CALLI4
pop
LABELV $2421
line 4019
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2420
line 4021
;4021:}
LABELV $2419
endproc BotClearActivateGoalStack 0 4
export BotEnableActivateGoalAreas
proc BotEnableActivateGoalAreas 12 8
line 4028
;4022:
;4023:/*
;4024:==================
;4025:BotEnableActivateGoalAreas
;4026:==================
;4027:*/
;4028:void BotEnableActivateGoalAreas(bot_activategoal_t *activategoal, int enable) {
line 4031
;4029:	int i;
;4030:
;4031:	if (activategoal->areasdisabled == !enable)
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $2427
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $2428
JUMPV
LABELV $2427
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $2428
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $2424
line 4032
;4032:		return;
ADDRGP4 $2423
JUMPV
LABELV $2424
line 4033
;4033:	for (i = 0; i < activategoal->numareas; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2432
JUMPV
LABELV $2429
line 4034
;4034:		trap_AAS_EnableRoutingArea( activategoal->areas[i], enable );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 trap_AAS_EnableRoutingArea
CALLI4
pop
LABELV $2430
line 4033
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2432
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
LTI4 $2429
line 4035
;4035:	activategoal->areasdisabled = !enable;
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $2434
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $2435
JUMPV
LABELV $2434
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $2435
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 4036
;4036:}
LABELV $2423
endproc BotEnableActivateGoalAreas 12 8
export BotIsGoingToActivateEntity
proc BotIsGoingToActivateEntity 8 0
line 4043
;4037:
;4038:/*
;4039:==================
;4040:BotIsGoingToActivateEntity
;4041:==================
;4042:*/
;4043:int BotIsGoingToActivateEntity(bot_state_t *bs, int entitynum) {
line 4047
;4044:	bot_activategoal_t *a;
;4045:	int i;
;4046:
;4047:	for (a = bs->activatestack; a; a = a->next) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $2440
JUMPV
LABELV $2437
line 4048
;4048:		if (a->time < FloatTime())
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $2441
line 4049
;4049:			continue;
ADDRGP4 $2438
JUMPV
LABELV $2441
line 4050
;4050:		if (a->goal.entitynum == entitynum)
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $2443
line 4051
;4051:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2436
JUMPV
LABELV $2443
line 4052
;4052:	}
LABELV $2438
line 4047
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
LABELV $2440
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2437
line 4053
;4053:	for (i = 0; i < MAX_ACTIVATESTACK; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $2445
line 4054
;4054:		if (bs->activategoalheap[i].inuse)
ADDRLP4 4
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2449
line 4055
;4055:			continue;
ADDRGP4 $2446
JUMPV
LABELV $2449
line 4057
;4056:		//
;4057:		if (bs->activategoalheap[i].goal.entitynum == entitynum) {
ADDRLP4 4
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
CNSTI4 44
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $2451
line 4059
;4058:			// if the bot went for this goal less than 2 seconds ago
;4059:			if (bs->activategoalheap[i].justused_time > FloatTime() - 2)
ADDRLP4 4
INDIRI4
CNSTI4 244
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 7124
ADDP4
ADDP4
CNSTI4 68
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1073741824
SUBF4
LEF4 $2453
line 4060
;4060:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2436
JUMPV
LABELV $2453
line 4061
;4061:		}
LABELV $2451
line 4062
;4062:	}
LABELV $2446
line 4053
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 8
LTI4 $2445
line 4063
;4063:	return qfalse;
CNSTI4 0
RETI4
LABELV $2436
endproc BotIsGoingToActivateEntity 8 0
export BotGetActivateGoal
proc BotGetActivateGoal 3304 20
line 4076
;4064:}
;4065:
;4066:/*
;4067:==================
;4068:BotGetActivateGoal
;4069:
;4070:  returns the number of the bsp entity to activate
;4071:  goal->entitynum will be set to the game entity to activate
;4072:==================
;4073:*/
;4074://#define OBSTACLEDEBUG
;4075:
;4076:int BotGetActivateGoal(bot_state_t *bs, int entitynum, bot_activategoal_t *activategoal) {
line 4087
;4077:	int i, ent, cur_entities[10], spawnflags, modelindex, areas[MAX_ACTIVATEAREAS*2], numareas, t;
;4078:	char model[MAX_INFO_STRING], tmpmodel[128];
;4079:	char target[128], classname[128];
;4080:	float health;
;4081:	char targetname[10][128];
;4082:	aas_entityinfo_t entinfo;
;4083:	aas_areainfo_t areainfo;
;4084:	vec3_t origin, absmins, absmaxs;
;4085:	//vec3_t angles;
;4086:
;4087:	memset(activategoal, 0, sizeof(bot_activategoal_t));
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 244
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4088
;4088:	BotEntityInfo(entitynum, &entinfo);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 3052
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4089
;4089:	Com_sprintf(model, sizeof( model ), "*%d", entinfo.modelindex);
ADDRLP4 1712
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2456
ARGP4
ADDRLP4 3052+104
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4090
;4090:	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
CNSTI4 0
ARGI4
ADDRLP4 3240
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 3240
INDIRI4
ASGNI4
ADDRGP4 $2461
JUMPV
LABELV $2458
line 4091
;4091:		if (!trap_AAS_ValueForBSPEpairKey(ent, "model", tmpmodel, sizeof(tmpmodel))) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $523
ARGP4
ADDRLP4 1584
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3244
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3244
INDIRI4
CNSTI4 0
NEI4 $2462
ADDRGP4 $2459
JUMPV
LABELV $2462
line 4092
;4092:		if (!strcmp(model, tmpmodel)) break;
ADDRLP4 1712
ARGP4
ADDRLP4 1584
ARGP4
ADDRLP4 3248
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3248
INDIRI4
CNSTI4 0
NEI4 $2464
ADDRGP4 $2460
JUMPV
LABELV $2464
line 4093
;4093:	}
LABELV $2459
line 4090
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 3244
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 3244
INDIRI4
ASGNI4
LABELV $2461
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2458
LABELV $2460
line 4094
;4094:	if (!ent) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2466
line 4095
;4095:		BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no entity found with model %s\n", model);
CNSTI4 3
ARGI4
ADDRGP4 $2468
ARGP4
ADDRLP4 1712
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4096
;4096:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2455
JUMPV
LABELV $2466
line 4098
;4097:	}
;4098:	trap_AAS_ValueForBSPEpairKey(ent, "classname", classname, sizeof(classname));
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2469
ARGP4
ADDRLP4 1456
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4099
;4099:	if (!*classname) {
ADDRLP4 1456
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2470
line 4100
;4100:		BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with model %s has no classname\n", model);
CNSTI4 3
ARGI4
ADDRGP4 $2472
ARGP4
ADDRLP4 1712
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4101
;4101:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2455
JUMPV
LABELV $2470
line 4104
;4102:	}
;4103:	//if it is a door
;4104:	if (!strcmp(classname, "func_door")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2475
ARGP4
ADDRLP4 3248
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3248
INDIRI4
CNSTI4 0
NEI4 $2473
line 4105
;4105:		if (trap_AAS_FloatForBSPEpairKey(ent, "health", &health)) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2275
ARGP4
ADDRLP4 3208
ARGP4
ADDRLP4 3252
ADDRGP4 trap_AAS_FloatForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3252
INDIRI4
CNSTI4 0
EQI4 $2476
line 4107
;4106:			//if the door has health then the door must be shot to open
;4107:			if (health) {
ADDRLP4 3208
INDIRF4
CNSTF4 0
EQF4 $2478
line 4108
;4108:				BotFuncDoorActivateGoal(bs, ent, activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 BotFuncDoorActivateGoal
CALLI4
pop
line 4109
;4109:				return ent;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $2455
JUMPV
LABELV $2478
line 4111
;4110:			}
;4111:		}
LABELV $2476
line 4113
;4112:		//
;4113:		trap_AAS_IntForBSPEpairKey(ent, "spawnflags", &spawnflags);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2480
ARGP4
ADDRLP4 3204
ARGP4
ADDRGP4 trap_AAS_IntForBSPEpairKey
CALLI4
pop
line 4115
;4114:		// if the door starts open then just wait for the door to return
;4115:		if ( spawnflags & 1 )
ADDRLP4 3204
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2481
line 4116
;4116:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $2455
JUMPV
LABELV $2481
line 4118
;4117:		//get the door origin
;4118:		if (!trap_AAS_VectorForBSPEpairKey(ent, "origin", origin)) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2485
ARGP4
ADDRLP4 3192
ARGP4
ADDRLP4 3256
ADDRGP4 trap_AAS_VectorForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3256
INDIRI4
CNSTI4 0
NEI4 $2483
line 4119
;4119:			VectorClear(origin);
ADDRLP4 3192
CNSTF4 0
ASGNF4
ADDRLP4 3192+4
CNSTF4 0
ASGNF4
ADDRLP4 3192+8
CNSTF4 0
ASGNF4
line 4120
;4120:		}
LABELV $2483
line 4122
;4121:		//if the door is open or opening already
;4122:		if (!VectorCompare(origin, entinfo.origin))
ADDRLP4 3192
ARGP4
ADDRLP4 3052+24
ARGP4
ADDRLP4 3260
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 3260
INDIRI4
CNSTI4 0
NEI4 $2488
line 4123
;4123:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $2455
JUMPV
LABELV $2488
line 4125
;4124:		// store all the areas the door is in
;4125:		trap_AAS_ValueForBSPEpairKey(ent, "model", model, sizeof(model));
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $523
ARGP4
ADDRLP4 1712
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4126
;4126:		if (*model) {
ADDRLP4 1712
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $2491
line 4127
;4127:			modelindex = atoi(model+1);
ADDRLP4 1712+1
ARGP4
ADDRLP4 3264
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 3212
ADDRLP4 3264
INDIRI4
ASGNI4
line 4128
;4128:			if (modelindex) {
ADDRLP4 3212
INDIRI4
CNSTI4 0
EQI4 $2494
line 4130
;4129:				//VectorClear(angles);
;4130:				BotModelMinsMaxs(modelindex, ET_MOVER, 0, absmins, absmaxs);
ADDRLP4 3212
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 3216
ARGP4
ADDRLP4 3228
ARGP4
ADDRGP4 BotModelMinsMaxs
CALLI4
pop
line 4132
;4131:				//
;4132:				numareas = trap_AAS_BBoxAreas(absmins, absmaxs, areas, MAX_ACTIVATEAREAS*2);
ADDRLP4 3216
ARGP4
ADDRLP4 3228
ARGP4
ADDRLP4 2740
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 3268
ADDRGP4 trap_AAS_BBoxAreas
CALLI4
ASGNI4
ADDRLP4 3048
ADDRLP4 3268
INDIRI4
ASGNI4
line 4134
;4133:				// store the areas with reachabilities first
;4134:				for (i = 0; i < numareas; i++) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $2499
JUMPV
LABELV $2496
line 4135
;4135:					if (activategoal->numareas >= MAX_ACTIVATEAREAS)
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 32
LTI4 $2500
line 4136
;4136:						break;
ADDRGP4 $2498
JUMPV
LABELV $2500
line 4137
;4137:					if ( !trap_AAS_AreaReachability(areas[i]) ) {
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 3272
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3272
INDIRI4
CNSTI4 0
NEI4 $2502
line 4138
;4138:						continue;
ADDRGP4 $2497
JUMPV
LABELV $2502
line 4140
;4139:					}
;4140:					trap_AAS_AreaInfo(areas[i], &areainfo);
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 2996
ARGP4
ADDRGP4 trap_AAS_AreaInfo
CALLI4
pop
line 4141
;4141:					if (areainfo.contents & AREACONTENTS_MOVER) {
ADDRLP4 2996
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $2504
line 4142
;4142:						activategoal->areas[activategoal->numareas++] = areas[i];
ADDRLP4 3280
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 3276
ADDRLP4 3280
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 3280
INDIRP4
ADDRLP4 3276
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 3276
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 104
ADDP4
ADDP4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ASGNI4
line 4143
;4143:					}
LABELV $2504
line 4144
;4144:				}
LABELV $2497
line 4134
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2499
ADDRLP4 132
INDIRI4
ADDRLP4 3048
INDIRI4
LTI4 $2496
LABELV $2498
line 4146
;4145:				// store any remaining areas
;4146:				for (i = 0; i < numareas; i++) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $2509
JUMPV
LABELV $2506
line 4147
;4147:					if (activategoal->numareas >= MAX_ACTIVATEAREAS)
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
CNSTI4 32
LTI4 $2510
line 4148
;4148:						break;
ADDRGP4 $2508
JUMPV
LABELV $2510
line 4149
;4149:					if ( trap_AAS_AreaReachability(areas[i]) ) {
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 3272
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3272
INDIRI4
CNSTI4 0
EQI4 $2512
line 4150
;4150:						continue;
ADDRGP4 $2507
JUMPV
LABELV $2512
line 4152
;4151:					}
;4152:					trap_AAS_AreaInfo(areas[i], &areainfo);
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ARGI4
ADDRLP4 2996
ARGP4
ADDRGP4 trap_AAS_AreaInfo
CALLI4
pop
line 4153
;4153:					if (areainfo.contents & AREACONTENTS_MOVER) {
ADDRLP4 2996
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $2514
line 4154
;4154:						activategoal->areas[activategoal->numareas++] = areas[i];
ADDRLP4 3280
ADDRFP4 8
INDIRP4
CNSTI4 232
ADDP4
ASGNP4
ADDRLP4 3276
ADDRLP4 3280
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 3280
INDIRP4
ADDRLP4 3276
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 3276
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
CNSTI4 104
ADDP4
ADDP4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 2740
ADDP4
INDIRI4
ASGNI4
line 4155
;4155:					}
LABELV $2514
line 4156
;4156:				}
LABELV $2507
line 4146
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2509
ADDRLP4 132
INDIRI4
ADDRLP4 3048
INDIRI4
LTI4 $2506
LABELV $2508
line 4157
;4157:			}
LABELV $2494
line 4158
;4158:		}
LABELV $2491
line 4159
;4159:	}
LABELV $2473
line 4161
;4160:	// if the bot is blocked by or standing on top of a button
;4161:	if (!strcmp(classname, "func_button")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2518
ARGP4
ADDRLP4 3252
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3252
INDIRI4
CNSTI4 0
NEI4 $2516
line 4162
;4162:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2455
JUMPV
LABELV $2516
line 4165
;4163:	}
;4164:	// get the targetname so we can find an entity with a matching target
;4165:	if (!trap_AAS_ValueForBSPEpairKey(ent, "targetname", targetname[0], sizeof(targetname[0]))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2521
ARGP4
ADDRLP4 136
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3256
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3256
INDIRI4
CNSTI4 0
NEI4 $2519
line 4166
;4166:		if (bot_developer.integer) {
ADDRGP4 bot_developer+12
INDIRI4
CNSTI4 0
EQI4 $2522
line 4167
;4167:			BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with model \"%s\" has no targetname\n", model);
CNSTI4 3
ARGI4
ADDRGP4 $2525
ARGP4
ADDRLP4 1712
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4168
;4168:		}
LABELV $2522
line 4169
;4169:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2455
JUMPV
LABELV $2519
line 4172
;4170:	}
;4171:	// allow tree-like activation
;4172:	cur_entities[0] = trap_AAS_NextBSPEntity(0);
CNSTI4 0
ARGI4
ADDRLP4 3260
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 1416
ADDRLP4 3260
INDIRI4
ASGNI4
line 4173
;4173:	for (i = 0; i >= 0 && i < 10;) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $2529
JUMPV
LABELV $2526
line 4174
;4174:		for (ent = cur_entities[i]; ent; ent = trap_AAS_NextBSPEntity(ent)) {
ADDRLP4 0
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1416
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $2533
JUMPV
LABELV $2530
line 4175
;4175:			if (!trap_AAS_ValueForBSPEpairKey(ent, "target", target, sizeof(target))) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2536
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3264
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3264
INDIRI4
CNSTI4 0
NEI4 $2534
ADDRGP4 $2531
JUMPV
LABELV $2534
line 4176
;4176:			if (!strcmp(targetname[i], target)) {
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 3268
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3268
INDIRI4
CNSTI4 0
NEI4 $2537
line 4177
;4177:				cur_entities[i] = trap_AAS_NextBSPEntity(ent);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 3272
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1416
ADDP4
ADDRLP4 3272
INDIRI4
ASGNI4
line 4178
;4178:				break;
ADDRGP4 $2532
JUMPV
LABELV $2537
line 4180
;4179:			}
;4180:		}
LABELV $2531
line 4174
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 3264
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 3264
INDIRI4
ASGNI4
LABELV $2533
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2530
LABELV $2532
line 4181
;4181:		if (!ent) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2539
line 4182
;4182:			if (bot_developer.integer) {
ADDRGP4 bot_developer+12
INDIRI4
CNSTI4 0
EQI4 $2541
line 4183
;4183:				BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no entity with target \"%s\"\n", targetname[i]);
CNSTI4 3
ARGI4
ADDRGP4 $2544
ARGP4
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136
ADDP4
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4184
;4184:			}
LABELV $2541
line 4185
;4185:			i--;
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 4186
;4186:			continue;
ADDRGP4 $2527
JUMPV
LABELV $2539
line 4188
;4187:		}
;4188:		if (!trap_AAS_ValueForBSPEpairKey(ent, "classname", classname, sizeof(classname))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2469
ARGP4
ADDRLP4 1456
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3268
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3268
INDIRI4
CNSTI4 0
NEI4 $2545
line 4189
;4189:			if (bot_developer.integer) {
ADDRGP4 bot_developer+12
INDIRI4
CNSTI4 0
EQI4 $2527
line 4190
;4190:				BotAI_Print(PRT_ERROR, "BotGetActivateGoal: entity with target \"%s\" has no classname\n", targetname[i]);
CNSTI4 3
ARGI4
ADDRGP4 $2550
ARGP4
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136
ADDP4
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4191
;4191:			}
line 4192
;4192:			continue;
ADDRGP4 $2527
JUMPV
LABELV $2545
line 4195
;4193:		}
;4194:		// BSP button model
;4195:		if (!strcmp(classname, "func_button")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2518
ARGP4
ADDRLP4 3272
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3272
INDIRI4
CNSTI4 0
NEI4 $2551
line 4197
;4196:			//
;4197:			if (!BotFuncButtonActivateGoal(bs, ent, activategoal))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 3276
ADDRGP4 BotFuncButtonActivateGoal
CALLI4
ASGNI4
ADDRLP4 3276
INDIRI4
CNSTI4 0
NEI4 $2553
line 4198
;4198:				continue;
ADDRGP4 $2527
JUMPV
LABELV $2553
line 4200
;4199:			// if the bot tries to activate this button already
;4200:			if ( bs->activatestack && bs->activatestack->inuse &&
ADDRLP4 3280
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 3280
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2555
ADDRLP4 3280
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $2555
ADDRLP4 3280
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
NEI4 $2555
ADDRLP4 3284
ADDRGP4 floattime
INDIRF4
ASGNF4
ADDRLP4 3280
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRLP4 3284
INDIRF4
LEF4 $2555
ADDRLP4 3280
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDRLP4 3284
INDIRF4
CNSTF4 1073741824
SUBF4
GEF4 $2555
line 4204
;4201:				 bs->activatestack->goal.entitynum == activategoal->goal.entitynum &&
;4202:				 bs->activatestack->time > FloatTime() &&
;4203:				 bs->activatestack->start_time < FloatTime() - 2)
;4204:				continue;
ADDRGP4 $2527
JUMPV
LABELV $2555
line 4206
;4205:			// if the bot is in a reachability area
;4206:			if ( trap_AAS_AreaReachability(bs->areanum) ) {
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 3288
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3288
INDIRI4
CNSTI4 0
EQI4 $2557
line 4208
;4207:				// disable all areas the blocking entity is in
;4208:				BotEnableActivateGoalAreas( activategoal, qfalse );
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4210
;4209:				//
;4210:				t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, activategoal->goal.areanum, bs->tfl);
ADDRLP4 3292
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 3292
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 3292
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 3292
INDIRP4
CNSTI4 5976
ADDP4
INDIRI4
ARGI4
ADDRLP4 3296
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 2736
ADDRLP4 3296
INDIRI4
ASGNI4
line 4212
;4211:				// if the button is not reachable
;4212:				if (!t) {
ADDRLP4 2736
INDIRI4
CNSTI4 0
NEI4 $2559
line 4213
;4213:					continue;
ADDRGP4 $2527
JUMPV
LABELV $2559
line 4215
;4214:				}
;4215:				activategoal->time = FloatTime() + t * 0.01 + 5;
ADDRFP4 8
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 2736
INDIRI4
CVIF4 4
CNSTF4 1008981770
MULF4
ADDF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 4216
;4216:			}
LABELV $2557
line 4217
;4217:			return ent;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $2455
JUMPV
LABELV $2551
line 4220
;4218:		}
;4219:		// invisible trigger multiple box
;4220:		else if (!strcmp(classname, "trigger_multiple")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2563
ARGP4
ADDRLP4 3276
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3276
INDIRI4
CNSTI4 0
NEI4 $2561
line 4222
;4221:			//
;4222:			if (!BotTriggerMultipleActivateGoal(bs, ent, activategoal))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 3280
ADDRGP4 BotTriggerMultipleActivateGoal
CALLI4
ASGNI4
ADDRLP4 3280
INDIRI4
CNSTI4 0
NEI4 $2564
line 4223
;4223:				continue;
ADDRGP4 $2527
JUMPV
LABELV $2564
line 4225
;4224:			// if the bot tries to activate this trigger already
;4225:			if ( bs->activatestack && bs->activatestack->inuse &&
ADDRLP4 3284
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 3284
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2566
ADDRLP4 3284
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $2566
ADDRLP4 3284
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
NEI4 $2566
ADDRLP4 3288
ADDRGP4 floattime
INDIRF4
ASGNF4
ADDRLP4 3284
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
ADDRLP4 3288
INDIRF4
LEF4 $2566
ADDRLP4 3284
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDRLP4 3288
INDIRF4
CNSTF4 1073741824
SUBF4
GEF4 $2566
line 4229
;4226:				 bs->activatestack->goal.entitynum == activategoal->goal.entitynum &&
;4227:				 bs->activatestack->time > FloatTime() &&
;4228:				 bs->activatestack->start_time < FloatTime() - 2)
;4229:				continue;
ADDRGP4 $2527
JUMPV
LABELV $2566
line 4231
;4230:			// if the bot is in a reachability area
;4231:			if ( trap_AAS_AreaReachability(bs->areanum) ) {
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 3292
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 3292
INDIRI4
CNSTI4 0
EQI4 $2568
line 4233
;4232:				// disable all areas the blocking entity is in
;4233:				BotEnableActivateGoalAreas( activategoal, qfalse );
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4235
;4234:				//
;4235:				t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, activategoal->goal.areanum, bs->tfl);
ADDRLP4 3296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 3296
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 3296
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 3296
INDIRP4
CNSTI4 5976
ADDP4
INDIRI4
ARGI4
ADDRLP4 3300
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 2736
ADDRLP4 3300
INDIRI4
ASGNI4
line 4237
;4236:				// if the trigger is not reachable
;4237:				if (!t) {
ADDRLP4 2736
INDIRI4
CNSTI4 0
NEI4 $2570
line 4238
;4238:					continue;
ADDRGP4 $2527
JUMPV
LABELV $2570
line 4240
;4239:				}
;4240:				activategoal->time = FloatTime() + t * 0.01 + 5;
ADDRFP4 8
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 2736
INDIRI4
CVIF4 4
CNSTF4 1008981770
MULF4
ADDF4
CNSTF4 1084227584
ADDF4
ASGNF4
line 4241
;4241:			}
LABELV $2568
line 4242
;4242:			return ent;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $2455
JUMPV
LABELV $2561
line 4244
;4243:		}
;4244:		else if (!strcmp(classname, "func_timer")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2574
ARGP4
ADDRLP4 3280
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3280
INDIRI4
CNSTI4 0
NEI4 $2572
line 4246
;4245:			// just skip the func_timer
;4246:			continue;
ADDRGP4 $2527
JUMPV
LABELV $2572
line 4249
;4247:		}
;4248:		// the actual button or trigger might be linked through a target_relay or target_delay
;4249:		else if (!strcmp(classname, "target_relay") || !strcmp(classname, "target_delay")) {
ADDRLP4 1456
ARGP4
ADDRGP4 $2577
ARGP4
ADDRLP4 3284
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3284
INDIRI4
CNSTI4 0
EQI4 $2579
ADDRLP4 1456
ARGP4
ADDRGP4 $2578
ARGP4
ADDRLP4 3288
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 3288
INDIRI4
CNSTI4 0
NEI4 $2575
LABELV $2579
line 4250
;4250:			if (trap_AAS_ValueForBSPEpairKey(ent, "targetname", targetname[i+1], sizeof(targetname[0]))) {
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2521
ARGP4
ADDRLP4 132
INDIRI4
CNSTI4 7
LSHI4
ADDRLP4 136+128
ADDP4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 3292
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 3292
INDIRI4
CNSTI4 0
EQI4 $2580
line 4251
;4251:				i++;
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4252
;4252:				cur_entities[i] = trap_AAS_NextBSPEntity(0);
CNSTI4 0
ARGI4
ADDRLP4 3296
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1416
ADDP4
ADDRLP4 3296
INDIRI4
ASGNI4
line 4253
;4253:			}
LABELV $2580
line 4254
;4254:		}
LABELV $2575
line 4255
;4255:	}
LABELV $2527
line 4173
LABELV $2529
ADDRLP4 132
INDIRI4
CNSTI4 0
LTI4 $2583
ADDRLP4 132
INDIRI4
CNSTI4 10
LTI4 $2526
LABELV $2583
line 4259
;4256:#ifdef OBSTACLEDEBUG
;4257:	BotAI_Print(PRT_ERROR, "BotGetActivateGoal: no valid activator for entity with target \"%s\"\n", targetname[0]);
;4258:#endif
;4259:	return 0;
CNSTI4 0
RETI4
LABELV $2455
endproc BotGetActivateGoal 3304 20
export BotGoForActivateGoal
proc BotGoForActivateGoal 144 8
line 4267
;4260:}
;4261:
;4262:/*
;4263:==================
;4264:BotGoForActivateGoal
;4265:==================
;4266:*/
;4267:int BotGoForActivateGoal(bot_state_t *bs, bot_activategoal_t *activategoal) {
line 4270
;4268:	aas_entityinfo_t activateinfo;
;4269:
;4270:	activategoal->inuse = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 1
ASGNI4
line 4271
;4271:	if (!activategoal->time)
ADDRFP4 4
INDIRP4
CNSTI4 60
ADDP4
INDIRF4
CNSTF4 0
NEF4 $2585
line 4272
;4272:		activategoal->time = FloatTime() + 10;
ADDRFP4 4
INDIRP4
CNSTI4 60
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1092616192
ADDF4
ASGNF4
LABELV $2585
line 4273
;4273:	activategoal->start_time = FloatTime();
ADDRFP4 4
INDIRP4
CNSTI4 64
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4274
;4274:	BotEntityInfo(activategoal->goal.entitynum, &activateinfo);
ADDRFP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4275
;4275:	VectorCopy(activateinfo.origin, activategoal->origin);
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 0+24
INDIRB
ASGNB 12
line 4277
;4276:	//
;4277:	if (BotPushOntoActivateGoalStack(bs, activategoal)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 BotPushOntoActivateGoalStack
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $2588
line 4279
;4278:		// enter the activate entity AI node
;4279:		AIEnter_Seek_ActivateEntity(bs, "BotGoForActivateGoal");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2590
ARGP4
ADDRGP4 AIEnter_Seek_ActivateEntity
CALLV
pop
line 4280
;4280:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2584
JUMPV
LABELV $2588
line 4282
;4281:	}
;4282:	else {
line 4284
;4283:		// enable any routing areas that were disabled
;4284:		BotEnableActivateGoalAreas(activategoal, qtrue);
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4285
;4285:		return qfalse;
CNSTI4 0
RETI4
LABELV $2584
endproc BotGoForActivateGoal 144 8
export BotPrintActivateGoalInfo
proc BotPrintActivateGoalInfo 296 36
line 4294
;4286:	}
;4287:}
;4288:
;4289:/*
;4290:==================
;4291:BotPrintActivateGoalInfo
;4292:==================
;4293:*/
;4294:void BotPrintActivateGoalInfo(bot_state_t *bs, bot_activategoal_t *activategoal, int bspent) {
line 4299
;4295:	char netname[MAX_NETNAME];
;4296:	char classname[128];
;4297:	char buf[128];
;4298:
;4299:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 4300
;4300:	trap_AAS_ValueForBSPEpairKey(bspent, "classname", classname, sizeof(classname));
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $2469
ARGP4
ADDRLP4 36
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
pop
line 4301
;4301:	if (activategoal->shoot) {
ADDRFP4 4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2592
line 4302
;4302:		Com_sprintf(buf, sizeof(buf), "%s: I have to shoot at a %s from %1.1f %1.1f %1.1f in area %d\n",
ADDRLP4 164
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $2594
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 292
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4308
;4303:						netname, classname,
;4304:						activategoal->goal.origin[0],
;4305:						activategoal->goal.origin[1],
;4306:						activategoal->goal.origin[2],
;4307:						activategoal->goal.areanum);
;4308:	}
ADDRGP4 $2593
JUMPV
LABELV $2592
line 4309
;4309:	else {
line 4310
;4310:		Com_sprintf(buf, sizeof(buf), "%s: I have to activate a %s at %1.1f %1.1f %1.1f in area %d\n",
ADDRLP4 164
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $2595
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 292
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 292
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 4316
;4311:						netname, classname,
;4312:						activategoal->goal.origin[0],
;4313:						activategoal->goal.origin[1],
;4314:						activategoal->goal.origin[2],
;4315:						activategoal->goal.areanum);
;4316:	}
LABELV $2593
line 4317
;4317:	trap_EA_Say(bs->client, buf);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 164
ARGP4
ADDRGP4 trap_EA_Say
CALLV
pop
line 4318
;4318:}
LABELV $2591
endproc BotPrintActivateGoalInfo 296 36
export BotRandomMove
proc BotRandomMove 28 16
line 4325
;4319:
;4320:/*
;4321:==================
;4322:BotRandomMove
;4323:==================
;4324:*/
;4325:void BotRandomMove(bot_state_t *bs, bot_moveresult_t *moveresult) {
line 4328
;4326:	vec3_t dir, angles;
;4327:
;4328:	angles[0] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 4329
;4329:	angles[1] = random() * 360;
ADDRLP4 24
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
ADDRLP4 24
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1010041192
MULF4
ASGNF4
line 4330
;4330:	angles[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 4331
;4331:	AngleVectors(angles, dir, NULL, NULL);
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 4333
;4332:
;4333:	trap_BotMoveInDirection(bs->ms, dir, 400, MOVE_WALK);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTF4 1137180672
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotMoveInDirection
CALLI4
pop
line 4335
;4334:
;4335:	moveresult->failure = qfalse;
ADDRFP4 4
INDIRP4
CNSTI4 0
ASGNI4
line 4336
;4336:	VectorCopy(dir, moveresult->movedir);
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 12
INDIRB
ASGNB 12
line 4337
;4337:}
LABELV $2596
endproc BotRandomMove 28 16
data
align 4
LABELV $2600
byte 4 0
byte 4 0
byte 4 1065353216
export BotAIBlocked
code
proc BotAIBlocked 468 16
line 4350
;4338:
;4339:/*
;4340:==================
;4341:BotAIBlocked
;4342:
;4343:Very basic handling of bots being blocked by other entities.
;4344:Check what kind of entity is blocking the bot and try to activate
;4345:it. If that's not an option then try to walk around or over the entity.
;4346:Before the bot ends in this part of the AI it should predict which doors to
;4347:open, which buttons to activate etc.
;4348:==================
;4349:*/
;4350:void BotAIBlocked(bot_state_t *bs, bot_moveresult_t *moveresult, int activate) {
line 4352
;4351:	int movetype, bspent;
;4352:	vec3_t hordir, start, /*end, mins, maxs,*/ sideward, angles, up = {0, 0, 1};
ADDRLP4 192
ADDRGP4 $2600
INDIRB
ASGNB 12
line 4357
;4353:	aas_entityinfo_t entinfo;
;4354:	bot_activategoal_t activategoal;
;4355:
;4356:	// if the bot is not blocked by anything
;4357:	if (!moveresult->blocked) {
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2601
line 4358
;4358:		bs->notblocked_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6204
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4359
;4359:		return;
ADDRGP4 $2599
JUMPV
LABELV $2601
line 4362
;4360:	}
;4361:	// if stuck in a solid area
;4362:	if ( moveresult->type == RESULTTYPE_INSOLIDAREA ) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 8
NEI4 $2603
line 4364
;4363:		// move in a random direction in the hope to get out
;4364:		BotRandomMove(bs, moveresult);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 BotRandomMove
CALLV
pop
line 4366
;4365:		//
;4366:		return;
ADDRGP4 $2599
JUMPV
LABELV $2603
line 4369
;4367:	}
;4368:	// get info for the entity that is blocking the bot
;4369:	BotEntityInfo(moveresult->blockentity, &entinfo);
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4375
;4370:#ifdef OBSTACLEDEBUG
;4371:	ClientName(bs->client, netname, sizeof(netname));
;4372:	BotAI_Print(PRT_MESSAGE, "%s: I'm blocked by model %d\n", netname, entinfo.modelindex);
;4373:#endif
;4374:	// if blocked by a bsp model and the bot wants to activate it
;4375:	if (activate && entinfo.modelindex > 0 && entinfo.modelindex <= max_bspmodelindex) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $2605
ADDRLP4 24+104
INDIRI4
CNSTI4 0
LEI4 $2605
ADDRLP4 24+104
INDIRI4
ADDRGP4 max_bspmodelindex
INDIRI4
GTI4 $2605
line 4377
;4376:		// find the bsp entity which should be activated in order to get the blocking entity out of the way
;4377:		bspent = BotGetActivateGoal(bs, entinfo.number, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24+20
INDIRI4
ARGI4
ADDRLP4 204
ARGP4
ADDRLP4 452
ADDRGP4 BotGetActivateGoal
CALLI4
ASGNI4
ADDRLP4 448
ADDRLP4 452
INDIRI4
ASGNI4
line 4378
;4378:		if (bspent) {
ADDRLP4 448
INDIRI4
CNSTI4 0
EQI4 $2610
line 4380
;4379:			//
;4380:			if (bs->activatestack && !bs->activatestack->inuse)
ADDRLP4 456
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 456
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2612
ADDRLP4 456
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $2612
line 4381
;4381:				bs->activatestack = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
CNSTP4 0
ASGNP4
LABELV $2612
line 4383
;4382:			// if not already trying to activate this entity
;4383:			if (!BotIsGoingToActivateEntity(bs, activategoal.goal.entitynum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 204+4+40
INDIRI4
ARGI4
ADDRLP4 460
ADDRGP4 BotIsGoingToActivateEntity
CALLI4
ASGNI4
ADDRLP4 460
INDIRI4
CNSTI4 0
NEI4 $2614
line 4385
;4384:				//
;4385:				BotGoForActivateGoal(bs, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 204
ARGP4
ADDRGP4 BotGoForActivateGoal
CALLI4
pop
line 4386
;4386:			}
LABELV $2614
line 4390
;4387:			// if ontop of an obstacle or
;4388:			// if the bot is not in a reachability area it'll still
;4389:			// need some dynamic obstacle avoidance, otherwise return
;4390:			if (!(moveresult->flags & MOVERESULT_ONTOPOFOBSTACLE) &&
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $2611
ADDRFP4 0
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 464
ADDRGP4 trap_AAS_AreaReachability
CALLI4
ASGNI4
ADDRLP4 464
INDIRI4
CNSTI4 0
EQI4 $2611
line 4392
;4391:				trap_AAS_AreaReachability(bs->areanum))
;4392:				return;
ADDRGP4 $2599
JUMPV
line 4393
;4393:		}
LABELV $2610
line 4394
;4394:		else {
line 4396
;4395:			// enable any routing areas that were disabled
;4396:			BotEnableActivateGoalAreas(&activategoal, qtrue);
ADDRLP4 204
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4397
;4397:		}
LABELV $2611
line 4398
;4398:	}
LABELV $2605
line 4400
;4399:	// just some basic dynamic obstacle avoidance code
;4400:	hordir[0] = moveresult->movedir[0];
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ASGNF4
line 4401
;4401:	hordir[1] = moveresult->movedir[1];
ADDRLP4 0+4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ASGNF4
line 4402
;4402:	hordir[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 4404
;4403:	// if no direction just take a random direction
;4404:	if (VectorNormalize(hordir) < 0.1) {
ADDRLP4 0
ARGP4
ADDRLP4 452
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 452
INDIRF4
CNSTF4 1036831949
GEF4 $2622
line 4405
;4405:		VectorSet(angles, 0, 360 * random(), 0);
ADDRLP4 180
CNSTF4 0
ASGNF4
ADDRLP4 456
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 180+4
ADDRLP4 456
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1135869952
MULF4
ASGNF4
ADDRLP4 180+8
CNSTF4 0
ASGNF4
line 4406
;4406:		AngleVectors(angles, hordir, NULL, NULL);
ADDRLP4 180
ARGP4
ADDRLP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 4407
;4407:	}
LABELV $2622
line 4411
;4408:	//
;4409:	//if (moveresult->flags & MOVERESULT_ONTOPOFOBSTACLE) movetype = MOVE_JUMP;
;4410:	//else
;4411:	movetype = MOVE_WALK;
ADDRLP4 164
CNSTI4 1
ASGNI4
line 4414
;4412:	// if there's an obstacle at the bot's feet and head then
;4413:	// the bot might be able to crouch through
;4414:	VectorCopy(bs->origin, start);
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 4908
ADDP4
INDIRB
ASGNB 12
line 4415
;4415:	start[2] += 18;
ADDRLP4 168+8
ADDRLP4 168+8
INDIRF4
CNSTF4 1099956224
ADDF4
ASGNF4
line 4423
;4416:	//VectorMA(start, 5, hordir, end);
;4417:	//VectorSet(mins, -16, -16, -24);
;4418:	//VectorSet(maxs, 16, 16, 4);
;4419:	//
;4420:	//bsptrace = AAS_Trace(start, mins, maxs, end, bs->entitynum, MASK_PLAYERSOLID);
;4421:	//if (bsptrace.fraction >= 1) movetype = MOVE_CROUCH;
;4422:	// get the sideward vector
;4423:	CrossProduct(hordir, up, sideward);
ADDRLP4 0
ARGP4
ADDRLP4 192
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 4425
;4424:	//
;4425:	if (bs->flags & BFL_AVOIDRIGHT) VectorNegate(sideward, sideward);
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $2627
ADDRLP4 12
ADDRLP4 12
INDIRF4
NEGF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
NEGF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
NEGF4
ASGNF4
LABELV $2627
line 4427
;4426:	// try to crouch straight forward?
;4427:	if (!trap_BotMoveInDirection(bs->ms, hordir, 400, movetype)) {
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 164
INDIRI4
ARGI4
ADDRLP4 456
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 456
INDIRI4
CNSTI4 0
NEI4 $2633
line 4429
;4428:		// perform the movement
;4429:		if (!trap_BotMoveInDirection(bs->ms, sideward, 400, movetype)) {
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 164
INDIRI4
ARGI4
ADDRLP4 460
ADDRGP4 trap_BotMoveInDirection
CALLI4
ASGNI4
ADDRLP4 460
INDIRI4
CNSTI4 0
NEI4 $2635
line 4431
;4430:			// flip the avoid direction flag
;4431:			bs->flags ^= BFL_AVOIDRIGHT;
ADDRLP4 464
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 464
INDIRP4
ADDRLP4 464
INDIRP4
INDIRI4
CNSTI4 16
BXORI4
ASGNI4
line 4434
;4432:			// flip the direction
;4433:			// VectorNegate(sideward, sideward);
;4434:			VectorMA(sideward, -1, hordir, sideward);
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRF4
CNSTF4 3212836864
MULF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 0+4
INDIRF4
CNSTF4 3212836864
MULF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 0+8
INDIRF4
CNSTF4 3212836864
MULF4
ADDF4
ASGNF4
line 4436
;4435:			// move in the other direction
;4436:			trap_BotMoveInDirection(bs->ms, sideward, 400, movetype);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 164
INDIRI4
ARGI4
ADDRGP4 trap_BotMoveInDirection
CALLI4
pop
line 4437
;4437:		}
LABELV $2635
line 4438
;4438:	}
LABELV $2633
line 4440
;4439:	//
;4440:	if (bs->notblocked_time < FloatTime() - 0.4) {
ADDRFP4 0
INDIRP4
CNSTI4 6204
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1053609165
SUBF4
GEF4 $2643
line 4443
;4441:		// just reset goals and hope the bot will go into another direction?
;4442:		// is this still needed??
;4443:		if (bs->ainode == AINode_Seek_NBG) bs->nbg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 AINode_Seek_NBG
CVPU4 4
NEU4 $2645
ADDRFP4 0
INDIRP4
CNSTI4 6072
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $2646
JUMPV
LABELV $2645
line 4444
;4444:		else if (bs->ainode == AINode_Seek_LTG) bs->ltg_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 AINode_Seek_LTG
CVPU4 4
NEU4 $2647
ADDRFP4 0
INDIRP4
CNSTI4 6068
ADDP4
CNSTF4 0
ASGNF4
LABELV $2647
LABELV $2646
line 4445
;4445:	}
LABELV $2643
line 4446
;4446:}
LABELV $2599
endproc BotAIBlocked 468 16
export BotAIPredictObstacles
proc BotAIPredictObstacles 316 44
line 4458
;4447:
;4448:/*
;4449:==================
;4450:BotAIPredictObstacles
;4451:
;4452:Predict the route towards the goal and check if the bot
;4453:will be blocked by certain obstacles. When the bot has obstacles
;4454:on it's path the bot should figure out if they can be removed
;4455:by activating certain entities.
;4456:==================
;4457:*/
;4458:int BotAIPredictObstacles(bot_state_t *bs, bot_goal_t *goal) {
line 4463
;4459:	int modelnum, entitynum, bspent;
;4460:	bot_activategoal_t activategoal;
;4461:	aas_predictroute_t route;
;4462:
;4463:	if (!bot_predictobstacles.integer)
ADDRGP4 bot_predictobstacles+12
INDIRI4
CNSTI4 0
NEI4 $2650
line 4464
;4464:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2649
JUMPV
LABELV $2650
line 4467
;4465:
;4466:	// always predict when the goal change or at regular intervals
;4467:	if (bs->predictobstacles_goalareanum == goal->areanum &&
ADDRLP4 292
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 6216
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
NEI4 $2653
ADDRLP4 292
INDIRP4
CNSTI4 6212
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1086324736
SUBF4
LEF4 $2653
line 4468
;4468:		bs->predictobstacles_time > FloatTime() - 6) {
line 4469
;4469:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2649
JUMPV
LABELV $2653
line 4471
;4470:	}
;4471:	bs->predictobstacles_goalareanum = goal->areanum;
ADDRFP4 0
INDIRP4
CNSTI4 6216
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 4472
;4472:	bs->predictobstacles_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6212
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4475
;4473:
;4474:	// predict at most 100 areas or 10 seconds ahead
;4475:	trap_AAS_PredictRoute(&route, bs->areanum, bs->origin,
ADDRLP4 0
ARGP4
ADDRLP4 296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 296
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 296
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 296
INDIRP4
CNSTI4 5976
ADDP4
INDIRI4
ARGI4
CNSTI4 100
ARGI4
CNSTI4 1000
ARGI4
CNSTI4 6
ARGI4
CNSTI4 1024
ARGI4
CNSTI4 67108864
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_AAS_PredictRoute
CALLI4
pop
line 4480
;4476:							goal->areanum, bs->tfl, 100, 1000,
;4477:							RSE_USETRAVELTYPE|RSE_ENTERCONTENTS,
;4478:							AREACONTENTS_MOVER, TFL_BRIDGE, 0);
;4479:	// if bot has to travel through an area with a mover
;4480:	if (route.stopevent & RSE_ENTERCONTENTS) {
ADDRLP4 0+16
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $2655
line 4482
;4481:		// if the bot will run into a mover
;4482:		if (route.endcontents & AREACONTENTS_MOVER) {
ADDRLP4 0+20
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $2656
line 4484
;4483:			//NOTE: this only works with bspc 2.1 or higher
;4484:			modelnum = (route.endcontents & AREACONTENTS_MODELNUM) >> AREACONTENTS_MODELNUMSHIFT;
ADDRLP4 36
ADDRLP4 0+20
INDIRI4
CNSTI4 255
CNSTI4 24
LSHI4
BANDI4
CNSTI4 24
RSHI4
ASGNI4
line 4485
;4485:			if (modelnum) {
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $2656
line 4487
;4486:				//
;4487:				entitynum = BotModelMinsMaxs(modelnum, ET_MOVER, 0, NULL, NULL);
ADDRLP4 36
INDIRI4
ARGI4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 300
ADDRGP4 BotModelMinsMaxs
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 300
INDIRI4
ASGNI4
line 4488
;4488:				if (entitynum) {
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $2656
line 4490
;4489:					//NOTE: BotGetActivateGoal already checks if the door is open or not
;4490:					bspent = BotGetActivateGoal(bs, entitynum, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 48
ARGP4
ADDRLP4 304
ADDRGP4 BotGetActivateGoal
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 304
INDIRI4
ASGNI4
line 4491
;4491:					if (bspent) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $2656
line 4493
;4492:						//
;4493:						if (bs->activatestack && !bs->activatestack->inuse)
ADDRLP4 308
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 308
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2668
ADDRLP4 308
INDIRP4
CNSTI4 7120
ADDP4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $2668
line 4494
;4494:							bs->activatestack = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 7120
ADDP4
CNSTP4 0
ASGNP4
LABELV $2668
line 4496
;4495:						// if not already trying to activate this entity
;4496:						if (!BotIsGoingToActivateEntity(bs, activategoal.goal.entitynum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48+4+40
INDIRI4
ARGI4
ADDRLP4 312
ADDRGP4 BotIsGoingToActivateEntity
CALLI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 0
NEI4 $2670
line 4500
;4497:							//
;4498:							//BotAI_Print(PRT_MESSAGE, "blocked by mover model %d, entity %d ?\n", modelnum, entitynum);
;4499:							//
;4500:							BotGoForActivateGoal(bs, &activategoal);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ARGP4
ADDRGP4 BotGoForActivateGoal
CALLI4
pop
line 4501
;4501:							return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2649
JUMPV
LABELV $2670
line 4503
;4502:						}
;4503:						else {
line 4505
;4504:							// enable any routing areas that were disabled
;4505:							BotEnableActivateGoalAreas(&activategoal, qtrue);
ADDRLP4 48
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotEnableActivateGoalAreas
CALLV
pop
line 4506
;4506:						}
line 4507
;4507:					}
line 4508
;4508:				}
line 4509
;4509:			}
line 4510
;4510:		}
line 4511
;4511:	}
ADDRGP4 $2656
JUMPV
LABELV $2655
line 4512
;4512:	else if (route.stopevent & RSE_USETRAVELTYPE) {
ADDRLP4 0+16
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $2674
line 4513
;4513:		if (route.endtravelflags & TFL_BRIDGE) {
ADDRLP4 0+24
INDIRI4
CNSTI4 67108864
BANDI4
CNSTI4 0
EQI4 $2677
line 4515
;4514:			//FIXME: check if the bridge is available to travel over
;4515:		}
LABELV $2677
line 4516
;4516:	}
LABELV $2674
LABELV $2656
line 4517
;4517:	return qfalse;
CNSTI4 0
RETI4
LABELV $2649
endproc BotAIPredictObstacles 316 44
export BotCheckConsoleMessages
proc BotCheckConsoleMessages 1008 48
line 4525
;4518:}
;4519:
;4520:/*
;4521:==================
;4522:BotCheckConsoleMessages
;4523:==================
;4524:*/
;4525:void BotCheckConsoleMessages(bot_state_t *bs) {
line 4533
;4526:	char botname[MAX_NETNAME], message[MAX_MESSAGE_SIZE], netname[MAX_NETNAME], *ptr;
;4527:	float chat_reply;
;4528:	int context, handle;
;4529:	bot_consolemessage_t m;
;4530:	bot_match_t match;
;4531:
;4532:	//the name of this bot
;4533:	ClientName(bs->client, botname, sizeof(botname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 908
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
ADDRGP4 $2682
JUMPV
LABELV $2681
line 4535
;4534:	//
;4535:	while((handle = trap_BotNextConsoleMessage(bs->cs, &m)) != 0) {
line 4537
;4536:		//if the chat state is flooded with messages the bot will read them quickly
;4537:		if (trap_BotNumConsoleMessages(bs->cs) < 10) {
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 948
ADDRGP4 trap_BotNumConsoleMessages
CALLI4
ASGNI4
ADDRLP4 948
INDIRI4
CNSTI4 10
GEI4 $2684
line 4539
;4538:			//if it is a chat message the bot needs some time to read it
;4539:			if (m.type == CMS_CHAT && m.time > FloatTime() - (1 + random())) break;
ADDRLP4 0+8
INDIRI4
CNSTI4 1
NEI4 $2686
ADDRLP4 952
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0+4
INDIRF4
ADDRGP4 floattime
INDIRF4
ADDRLP4 952
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1065353216
ADDF4
SUBF4
LEF4 $2686
ADDRGP4 $2683
JUMPV
LABELV $2686
line 4540
;4540:		}
LABELV $2684
line 4542
;4541:		//
;4542:		ptr = m.message;
ADDRLP4 276
ADDRLP4 0+12
ASGNP4
line 4545
;4543:		//if it is a chat message then don't unify white spaces and don't
;4544:		//replace synonyms in the netname
;4545:		if (m.type == CMS_CHAT) {
ADDRLP4 0+8
INDIRI4
CNSTI4 1
NEI4 $2691
line 4547
;4546:			//
;4547:			if (trap_BotFindMatch(m.message, &match, MTCONTEXT_REPLYCHAT)) {
ADDRLP4 0+12
ARGP4
ADDRLP4 288
ARGP4
CNSTU4 128
ARGU4
ADDRLP4 952
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 952
INDIRI4
CNSTI4 0
EQI4 $2694
line 4548
;4548:				ptr = m.message + match.variables[MESSAGE].offset;
ADDRLP4 276
ADDRLP4 288+264+16
INDIRI1
CVII4 1
ADDRLP4 0+12
ADDP4
ASGNP4
line 4549
;4549:			}
LABELV $2694
line 4550
;4550:		}
LABELV $2691
line 4552
;4551:		//unify the white spaces in the message
;4552:		trap_UnifyWhiteSpaces(ptr);
ADDRLP4 276
INDIRP4
ARGP4
ADDRGP4 trap_UnifyWhiteSpaces
CALLV
pop
line 4554
;4553:		//replace synonyms in the right context
;4554:		context = BotSynonymContext(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 952
ADDRGP4 BotSynonymContext
CALLI4
ASGNI4
ADDRLP4 284
ADDRLP4 952
INDIRI4
ASGNI4
line 4555
;4555:		trap_BotReplaceSynonyms(ptr, context);
ADDRLP4 276
INDIRP4
ARGP4
ADDRLP4 284
INDIRI4
CVIU4 4
ARGU4
ADDRGP4 trap_BotReplaceSynonyms
CALLV
pop
line 4557
;4556:		//if there's no match
;4557:		if (!BotMatchMessage(bs, m.message)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+12
ARGP4
ADDRLP4 956
ADDRGP4 BotMatchMessage
CALLI4
ASGNI4
ADDRLP4 956
INDIRI4
CNSTI4 0
NEI4 $2700
line 4559
;4558:			//if it is a chat message
;4559:			if (m.type == CMS_CHAT && !bot_nochat.integer) {
ADDRLP4 0+8
INDIRI4
CNSTI4 1
NEI4 $2703
ADDRGP4 bot_nochat+12
INDIRI4
CNSTI4 0
NEI4 $2703
line 4561
;4560:				//
;4561:				if (!trap_BotFindMatch(m.message, &match, MTCONTEXT_REPLYCHAT)) {
ADDRLP4 0+12
ARGP4
ADDRLP4 288
ARGP4
CNSTU4 128
ARGU4
ADDRLP4 960
ADDRGP4 trap_BotFindMatch
CALLI4
ASGNI4
ADDRLP4 960
INDIRI4
CNSTI4 0
NEI4 $2707
line 4562
;4562:					trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4563
;4563:					continue;
ADDRGP4 $2682
JUMPV
LABELV $2707
line 4566
;4564:				}
;4565:				//don't use eliza chats with team messages
;4566:				if (match.subtype & ST_TEAM) {
ADDRLP4 288+260
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $2710
line 4567
;4567:					trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4568
;4568:					continue;
ADDRGP4 $2682
JUMPV
LABELV $2710
line 4571
;4569:				}
;4570:				//
;4571:				trap_BotMatchVariable(&match, NETNAME, netname, sizeof(netname));
ADDRLP4 288
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 872
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 4572
;4572:				trap_BotMatchVariable(&match, MESSAGE, message, sizeof(message));
ADDRLP4 288
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 616
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotMatchVariable
CALLV
pop
line 4574
;4573:				//if this is a message from the bot self
;4574:				if (bs->client == ClientFromName(netname)) {
ADDRLP4 872
ARGP4
ADDRLP4 964
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 964
INDIRI4
NEI4 $2713
line 4575
;4575:					trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4576
;4576:					continue;
ADDRGP4 $2682
JUMPV
LABELV $2713
line 4579
;4577:				}
;4578:				//unify the message
;4579:				trap_UnifyWhiteSpaces(message);
ADDRLP4 616
ARGP4
ADDRGP4 trap_UnifyWhiteSpaces
CALLV
pop
line 4581
;4580:				//
;4581:				trap_Cvar_Update(&bot_testrchat);
ADDRGP4 bot_testrchat
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 4582
;4582:				if (bot_testrchat.integer) {
ADDRGP4 bot_testrchat+12
INDIRI4
CNSTI4 0
EQI4 $2715
line 4584
;4583:					//
;4584:					trap_BotLibVarSet("bot_testrchat", "1");
ADDRGP4 $2718
ARGP4
ADDRGP4 $2719
ARGP4
ADDRGP4 trap_BotLibVarSet
CALLI4
pop
line 4586
;4585:					//if bot replies with a chat message
;4586:					if (trap_BotReplyChat(bs->cs, message, context, CONTEXT_REPLY,
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 616
ARGP4
ADDRLP4 284
INDIRI4
ARGI4
CNSTI4 16
ARGI4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 908
ARGP4
ADDRLP4 872
ARGP4
ADDRLP4 968
ADDRGP4 trap_BotReplyChat
CALLI4
ASGNI4
ADDRLP4 968
INDIRI4
CNSTI4 0
EQI4 $2720
line 4590
;4587:															NULL, NULL,
;4588:															NULL, NULL,
;4589:															NULL, NULL,
;4590:															botname, netname)) {
line 4591
;4591:						BotAI_Print(PRT_MESSAGE, "------------------------\n");
CNSTI4 1
ARGI4
ADDRGP4 $2722
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4592
;4592:					}
ADDRGP4 $2716
JUMPV
LABELV $2720
line 4593
;4593:					else {
line 4594
;4594:						BotAI_Print(PRT_MESSAGE, "**** no valid reply ****\n");
CNSTI4 1
ARGI4
ADDRGP4 $2723
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 4595
;4595:					}
line 4596
;4596:				}
ADDRGP4 $2716
JUMPV
LABELV $2715
line 4598
;4597:				//if at a valid chat position and not chatting already and not in teamplay
;4598:				else if (bs->ainode != AINode_Stand && BotValidChatPosition(bs) && !TeamPlayIsOn()) {
ADDRLP4 968
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 968
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 AINode_Stand
CVPU4 4
EQU4 $2724
ADDRLP4 968
INDIRP4
ARGP4
ADDRLP4 972
ADDRGP4 BotValidChatPosition
CALLI4
ASGNI4
ADDRLP4 972
INDIRI4
CNSTI4 0
EQI4 $2724
ADDRLP4 976
ADDRGP4 TeamPlayIsOn
CALLI4
ASGNI4
ADDRLP4 976
INDIRI4
CNSTI4 0
NEI4 $2724
line 4599
;4599:					chat_reply = trap_Characteristic_BFloat(bs->character, CHARACTERISTIC_CHAT_REPLY, 0, 1);
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 35
ARGI4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 980
ADDRGP4 trap_Characteristic_BFloat
CALLF4
ASGNF4
ADDRLP4 944
ADDRLP4 980
INDIRF4
ASGNF4
line 4600
;4600:					if (random() < 1.5 / (NumBots()+1) && random() < chat_reply) {
ADDRLP4 984
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 988
ADDRGP4 NumBots
CALLI4
ASGNI4
ADDRLP4 984
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1069547520
ADDRLP4 988
INDIRI4
CNSTI4 1
ADDI4
CVIF4 4
DIVF4
GEF4 $2726
ADDRLP4 992
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 992
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ADDRLP4 944
INDIRF4
GEF4 $2726
line 4602
;4601:						//if bot replies with a chat message
;4602:						if (trap_BotReplyChat(bs->cs, message, context, CONTEXT_REPLY,
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 616
ARGP4
ADDRLP4 284
INDIRI4
ARGI4
CNSTI4 16
ARGI4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 908
ARGP4
ADDRLP4 872
ARGP4
ADDRLP4 996
ADDRGP4 trap_BotReplyChat
CALLI4
ASGNI4
ADDRLP4 996
INDIRI4
CNSTI4 0
EQI4 $2728
line 4606
;4603:																NULL, NULL,
;4604:																NULL, NULL,
;4605:																NULL, NULL,
;4606:																botname, netname)) {
line 4608
;4607:							//remove the console message
;4608:							trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4609
;4609:							bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 1000
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1000
INDIRP4
ARGP4
ADDRLP4 1004
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 1000
INDIRP4
CNSTI4 6096
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 1004
INDIRF4
ADDF4
ASGNF4
line 4610
;4610:							AIEnter_Stand(bs, "BotCheckConsoleMessages: reply chat");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2730
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 4612
;4611:							//EA_Say(bs->client, bs->cs.chatmessage);
;4612:							break;
ADDRGP4 $2683
JUMPV
LABELV $2728
line 4614
;4613:						}
;4614:					}
LABELV $2726
line 4615
;4615:				}
LABELV $2724
LABELV $2716
line 4616
;4616:			}
LABELV $2703
line 4617
;4617:		}
LABELV $2700
line 4619
;4618:		//remove the console message
;4619:		trap_BotRemoveConsoleMessage(bs->cs, handle);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
INDIRI4
ARGI4
ADDRGP4 trap_BotRemoveConsoleMessage
CALLV
pop
line 4620
;4620:	}
LABELV $2682
line 4535
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 948
ADDRGP4 trap_BotNextConsoleMessage
CALLI4
ASGNI4
ADDRLP4 280
ADDRLP4 948
INDIRI4
ASGNI4
ADDRLP4 948
INDIRI4
CNSTI4 0
NEI4 $2681
LABELV $2683
line 4621
;4621:}
LABELV $2680
endproc BotCheckConsoleMessages 1008 48
export BotCheckForGrenades
proc BotCheckForGrenades 4 16
line 4628
;4622:
;4623:/*
;4624:==================
;4625:BotCheckEvents
;4626:==================
;4627:*/
;4628:void BotCheckForGrenades(bot_state_t *bs, entityState_t *state) {
line 4630
;4629:	// if this is not a grenade
;4630:	if (state->eType != ET_MISSILE || state->weapon != WP_GRENADE_LAUNCHER)
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $2734
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 4
EQI4 $2732
LABELV $2734
line 4631
;4631:		return;
ADDRGP4 $2731
JUMPV
LABELV $2732
line 4633
;4632:	// try to avoid the grenade
;4633:	trap_BotAddAvoidSpot(bs->ms, state->pos.trBase, 160, AVOID_ALWAYS);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTF4 1126170624
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotAddAvoidSpot
CALLV
pop
line 4634
;4634:}
LABELV $2731
endproc BotCheckForGrenades 4 16
export BotCheckForProxMines
proc BotCheckForProxMines 28 16
line 4641
;4635:
;4636:/*
;4637:==================
;4638:BotCheckForProxMines
;4639:==================
;4640:*/
;4641:void BotCheckForProxMines(bot_state_t *bs, entityState_t *state) {
line 4643
;4642:	// if this is not a prox mine
;4643:	if (state->eType != ET_MISSILE || state->weapon != WP_PROX_LAUNCHER)
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $2738
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 12
EQI4 $2736
LABELV $2738
line 4644
;4644:		return;
ADDRGP4 $2735
JUMPV
LABELV $2736
line 4646
;4645:	// if this prox mine is from someone on our own team
;4646:	if (state->generic1 == BotTeam(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $2739
line 4647
;4647:		return;
ADDRGP4 $2735
JUMPV
LABELV $2739
line 4649
;4648:	// if the bot doesn't have a weapon to deactivate the mine
;4649:	if (!(bs->inventory[INVENTORY_PLASMAGUN] > 0 && bs->inventory[INVENTORY_CELLS] > 0) &&
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4996
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2743
ADDRLP4 8
INDIRP4
CNSTI4 5040
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2741
LABELV $2743
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4984
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2744
ADDRLP4 12
INDIRP4
CNSTI4 5048
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2741
LABELV $2744
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 5004
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2745
ADDRLP4 16
INDIRP4
CNSTI4 5056
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2741
LABELV $2745
line 4651
;4650:		!(bs->inventory[INVENTORY_ROCKETLAUNCHER] > 0 && bs->inventory[INVENTORY_ROCKETS] > 0) &&
;4651:		!(bs->inventory[INVENTORY_BFG10K] > 0 && bs->inventory[INVENTORY_BFGAMMO] > 0) ) {
line 4652
;4652:		return;
ADDRGP4 $2735
JUMPV
LABELV $2741
line 4655
;4653:	}
;4654:	// try to avoid the prox mine
;4655:	trap_BotAddAvoidSpot(bs->ms, state->pos.trBase, 160, AVOID_ALWAYS);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
CNSTF4 1126170624
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotAddAvoidSpot
CALLV
pop
line 4657
;4656:	//
;4657:	if (bs->numproxmines >= MAX_PROXMINES)
ADDRFP4 0
INDIRP4
CNSTI4 6516
ADDP4
INDIRI4
CNSTI4 64
LTI4 $2746
line 4658
;4658:		return;
ADDRGP4 $2735
JUMPV
LABELV $2746
line 4659
;4659:	bs->proxmines[bs->numproxmines] = state->number;
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 6516
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
CNSTI4 6260
ADDP4
ADDP4
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
line 4660
;4660:	bs->numproxmines++;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 6516
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4661
;4661:}
LABELV $2735
endproc BotCheckForProxMines 28 16
export BotCheckForKamikazeBody
proc BotCheckForKamikazeBody 0 0
line 4668
;4662:
;4663:/*
;4664:==================
;4665:BotCheckForKamikazeBody
;4666:==================
;4667:*/
;4668:void BotCheckForKamikazeBody(bot_state_t *bs, entityState_t *state) {
line 4670
;4669:	// if this entity is not wearing the kamikaze
;4670:	if (!(state->eFlags & EF_KAMIKAZE))
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $2749
line 4671
;4671:		return;
ADDRGP4 $2748
JUMPV
LABELV $2749
line 4673
;4672:	// if this entity isn't dead
;4673:	if (!(state->eFlags & EF_DEAD))
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $2751
line 4674
;4674:		return;
ADDRGP4 $2748
JUMPV
LABELV $2751
line 4676
;4675:	//remember this kamikaze body
;4676:	bs->kamikazebody = state->number;
ADDRFP4 0
INDIRP4
CNSTI4 6256
ADDP4
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
line 4677
;4677:}
LABELV $2748
endproc BotCheckForKamikazeBody 0 0
export BotCheckEvents
proc BotCheckEvents 316 12
line 4684
;4678:
;4679:/*
;4680:==================
;4681:BotCheckEvents
;4682:==================
;4683:*/
;4684:void BotCheckEvents(bot_state_t *bs, entityState_t *state) {
line 4691
;4685:	int event;
;4686:	char buf[128];
;4687:	aas_entityinfo_t entinfo;
;4688:
;4689:	//NOTE: this sucks, we're accessing the gentity_t directly
;4690:	//but there's no other fast way to do it right now
;4691:	if (bs->entityeventTime[state->number] == g_entities[state->number].eventTime) {
ADDRLP4 272
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDP4
INDIRI4
ADDRLP4 272
INDIRI4
CNSTI4 832
MULI4
ADDRGP4 g_entities+552
ADDP4
INDIRI4
NEI4 $2754
line 4692
;4692:		return;
ADDRGP4 $2753
JUMPV
LABELV $2754
line 4694
;4693:	}
;4694:	bs->entityeventTime[state->number] = g_entities[state->number].eventTime;
ADDRLP4 276
ADDRFP4 4
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 276
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDP4
ADDRLP4 276
INDIRI4
CNSTI4 832
MULI4
ADDRGP4 g_entities+552
ADDP4
INDIRI4
ASGNI4
line 4696
;4695:	//if it's an event only entity
;4696:	if (state->eType > ET_EVENTS) {
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
LEI4 $2758
line 4697
;4697:		event = (state->eType - ET_EVENTS) & ~EV_EVENT_BITS;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
SUBI4
CNSTI4 -769
BANDI4
ASGNI4
line 4698
;4698:	}
ADDRGP4 $2759
JUMPV
LABELV $2758
line 4699
;4699:	else {
line 4700
;4700:		event = state->event & ~EV_EVENT_BITS;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 -769
BANDI4
ASGNI4
line 4701
;4701:	}
LABELV $2759
line 4703
;4702:	//
;4703:	switch(event) {
ADDRLP4 280
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 1
LTI4 $2760
ADDRLP4 280
INDIRI4
CNSTI4 76
GTI4 $2760
ADDRLP4 280
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2838-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $2838
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2761
address $2760
address $2760
address $2823
address $2760
address $2760
address $2824
address $2780
address $2792
address $2760
address $2760
address $2760
address $2760
address $2760
address $2760
address $2760
address $2760
address $2760
address $2760
address $2760
address $2760
address $2762
address $2760
address $2760
address $2760
address $2760
address $2760
address $2760
address $2760
address $2760
address $2760
address $2760
address $2760
address $2760
address $2760
address $2760
address $2760
address $2761
code
LABELV $2762
line 4706
;4704:		//client obituary event
;4705:		case EV_OBITUARY:
;4706:		{
line 4709
;4707:			int target, attacker, mod;
;4708:
;4709:			target = state->otherEntityNum;
ADDRLP4 284
ADDRFP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ASGNI4
line 4710
;4710:			attacker = state->otherEntityNum2;
ADDRLP4 288
ADDRFP4 4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 4711
;4711:			mod = state->eventParm;
ADDRLP4 292
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 4713
;4712:			//
;4713:			if (target == bs->client) {
ADDRLP4 284
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2763
line 4714
;4714:				bs->botdeathtype = mod;
ADDRFP4 0
INDIRP4
CNSTI4 6000
ADDP4
ADDRLP4 292
INDIRI4
ASGNI4
line 4715
;4715:				bs->lastkilledby = attacker;
ADDRFP4 0
INDIRP4
CNSTI4 5996
ADDP4
ADDRLP4 288
INDIRI4
ASGNI4
line 4717
;4716:				//
;4717:				if (target == attacker ||
ADDRLP4 296
ADDRLP4 284
INDIRI4
ASGNI4
ADDRLP4 296
INDIRI4
ADDRLP4 288
INDIRI4
EQI4 $2768
ADDRLP4 296
INDIRI4
CNSTI4 1023
EQI4 $2768
ADDRLP4 296
INDIRI4
CNSTI4 1022
NEI4 $2765
LABELV $2768
line 4719
;4718:					target == ENTITYNUM_NONE ||
;4719:					target == ENTITYNUM_WORLD) bs->botsuicide = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6008
ADDP4
CNSTI4 1
ASGNI4
ADDRGP4 $2766
JUMPV
LABELV $2765
line 4720
;4720:				else bs->botsuicide = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6008
ADDP4
CNSTI4 0
ASGNI4
LABELV $2766
line 4722
;4721:				//
;4722:				bs->num_deaths++;
ADDRLP4 300
ADDRFP4 0
INDIRP4
CNSTI4 6028
ADDP4
ASGNP4
ADDRLP4 300
INDIRP4
ADDRLP4 300
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4723
;4723:			}
ADDRGP4 $2764
JUMPV
LABELV $2763
line 4725
;4724:			//else if this client was killed by the bot
;4725:			else if (attacker == bs->client) {
ADDRLP4 288
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2769
line 4726
;4726:				bs->enemydeathtype = mod;
ADDRFP4 0
INDIRP4
CNSTI4 6004
ADDP4
ADDRLP4 292
INDIRI4
ASGNI4
line 4727
;4727:				bs->lastkilledplayer = target;
ADDRFP4 0
INDIRP4
CNSTI4 5992
ADDP4
ADDRLP4 284
INDIRI4
ASGNI4
line 4728
;4728:				bs->killedenemy_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6168
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4730
;4729:				//
;4730:				bs->num_kills++;
ADDRLP4 296
ADDRFP4 0
INDIRP4
CNSTI4 6032
ADDP4
ASGNP4
ADDRLP4 296
INDIRP4
ADDRLP4 296
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4731
;4731:			}
ADDRGP4 $2770
JUMPV
LABELV $2769
line 4732
;4732:			else if (attacker == bs->enemy && target == attacker) {
ADDRLP4 296
ADDRLP4 288
INDIRI4
ASGNI4
ADDRLP4 296
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6540
ADDP4
INDIRI4
NEI4 $2771
ADDRLP4 284
INDIRI4
ADDRLP4 296
INDIRI4
NEI4 $2771
line 4733
;4733:				bs->enemysuicide = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6012
ADDP4
CNSTI4 1
ASGNI4
line 4734
;4734:			}
LABELV $2771
LABELV $2770
LABELV $2764
line 4736
;4735:			//
;4736:			if (gametype == GT_1FCTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $2761
line 4738
;4737:				//
;4738:				BotEntityInfo(target, &entinfo);
ADDRLP4 284
INDIRI4
ARGI4
ADDRLP4 132
ARGP4
ADDRGP4 BotEntityInfo
CALLV
pop
line 4739
;4739:				if ( entinfo.powerups & ( 1 << PW_NEUTRALFLAG ) ) {
ADDRLP4 132+124
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $2761
line 4740
;4740:					if (!BotSameTeam(bs, target)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 284
INDIRI4
ARGI4
ADDRLP4 300
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 300
INDIRI4
CNSTI4 0
NEI4 $2761
line 4741
;4741:						bs->neutralflagstatus = 3;	//enemy dropped the flag
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 3
ASGNI4
line 4742
;4742:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4743
;4743:					}
line 4744
;4744:				}
line 4745
;4745:			}
line 4746
;4746:			break;
ADDRGP4 $2761
JUMPV
LABELV $2780
line 4749
;4747:		}
;4748:		case EV_GLOBAL_SOUND:
;4749:		{
line 4750
;4750:			if (state->eventParm < 0 || state->eventParm >= MAX_SOUNDS) {
ADDRLP4 284
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 284
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LTI4 $2783
ADDRLP4 284
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 256
LTI4 $2781
LABELV $2783
line 4751
;4751:				BotAI_Print(PRT_ERROR, "EV_GLOBAL_SOUND: eventParm (%d) out of range\n", state->eventParm);
CNSTI4 3
ARGI4
ADDRGP4 $2784
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 4752
;4752:				break;
ADDRGP4 $2761
JUMPV
LABELV $2781
line 4754
;4753:			}
;4754:			trap_GetConfigstring(CS_SOUNDS + state->eventParm, buf, sizeof(buf));
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 273
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 4755
;4755:			if (!strcmp(buf, "sound/items/kamikazerespawn.wav" )) {
ADDRLP4 4
ARGP4
ADDRGP4 $2787
ARGP4
ADDRLP4 288
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
NEI4 $2785
line 4757
;4756:				//the kamikaze respawned so dont avoid it
;4757:				BotDontAvoid(bs, "Kamikaze");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2788
ARGP4
ADDRGP4 BotDontAvoid
CALLV
pop
line 4758
;4758:			} else if (!strcmp(buf, "sound/items/poweruprespawn.wav")) {
ADDRGP4 $2761
JUMPV
LABELV $2785
ADDRLP4 4
ARGP4
ADDRGP4 $2791
ARGP4
ADDRLP4 292
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 0
NEI4 $2761
line 4760
;4759:				//powerup respawned... go get it
;4760:				BotGoForPowerups(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotGoForPowerups
CALLV
pop
line 4761
;4761:			}
line 4762
;4762:			break;
ADDRGP4 $2761
JUMPV
LABELV $2792
line 4765
;4763:		}
;4764:		case EV_GLOBAL_TEAM_SOUND:
;4765:		{
line 4766
;4766:			if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $2793
line 4767
;4767:				switch(state->eventParm) {
ADDRLP4 284
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 0
LTI4 $2761
ADDRLP4 284
INDIRI4
CNSTI4 5
GTI4 $2761
ADDRLP4 284
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2804
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $2804
address $2798
address $2799
address $2800
address $2801
address $2802
address $2803
code
LABELV $2798
line 4769
;4768:					case GTS_RED_CAPTURE:
;4769:						bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6960
ADDP4
CNSTI4 0
ASGNI4
line 4770
;4770:						bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 0
ASGNI4
line 4771
;4771:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4772
;4772:						break; //see BotMatch_CTF
ADDRGP4 $2761
JUMPV
LABELV $2799
line 4774
;4773:					case GTS_BLUE_CAPTURE:
;4774:						bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6960
ADDP4
CNSTI4 0
ASGNI4
line 4775
;4775:						bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 0
ASGNI4
line 4776
;4776:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4777
;4777:						break; //see BotMatch_CTF
ADDRGP4 $2761
JUMPV
LABELV $2800
line 4780
;4778:					case GTS_RED_RETURN:
;4779:						//blue flag is returned
;4780:						bs->blueflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6960
ADDP4
CNSTI4 0
ASGNI4
line 4781
;4781:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4782
;4782:						break;
ADDRGP4 $2761
JUMPV
LABELV $2801
line 4785
;4783:					case GTS_BLUE_RETURN:
;4784:						//red flag is returned
;4785:						bs->redflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 0
ASGNI4
line 4786
;4786:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4787
;4787:						break;
ADDRGP4 $2761
JUMPV
LABELV $2802
line 4790
;4788:					case GTS_RED_TAKEN:
;4789:						//blue flag is taken
;4790:						bs->blueflagstatus = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6960
ADDP4
CNSTI4 1
ASGNI4
line 4791
;4791:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4792
;4792:						break; //see BotMatch_CTF
ADDRGP4 $2761
JUMPV
LABELV $2803
line 4795
;4793:					case GTS_BLUE_TAKEN:
;4794:						//red flag is taken
;4795:						bs->redflagstatus = 1;
ADDRFP4 0
INDIRP4
CNSTI4 6956
ADDP4
CNSTI4 1
ASGNI4
line 4796
;4796:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4797
;4797:						break; //see BotMatch_CTF
line 4799
;4798:				}
;4799:			} else if (gametype == GT_1FCTF) {
ADDRGP4 $2761
JUMPV
LABELV $2793
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $2761
line 4800
;4800:				switch(state->eventParm) {
ADDRLP4 284
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 0
LTI4 $2761
ADDRLP4 284
INDIRI4
CNSTI4 5
GTI4 $2761
ADDRLP4 284
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2822
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $2822
address $2810
address $2811
address $2812
address $2813
address $2814
address $2818
code
LABELV $2810
line 4802
;4801:					case GTS_RED_CAPTURE:
;4802:						bs->neutralflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 0
ASGNI4
line 4803
;4803:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4804
;4804:						break;
ADDRGP4 $2761
JUMPV
LABELV $2811
line 4806
;4805:					case GTS_BLUE_CAPTURE:
;4806:						bs->neutralflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 0
ASGNI4
line 4807
;4807:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4808
;4808:						break;
ADDRGP4 $2761
JUMPV
LABELV $2812
line 4811
;4809:					case GTS_RED_RETURN:
;4810:						//flag has returned
;4811:						bs->neutralflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 0
ASGNI4
line 4812
;4812:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4813
;4813:						break;
ADDRGP4 $2761
JUMPV
LABELV $2813
line 4816
;4814:					case GTS_BLUE_RETURN:
;4815:						//flag has returned
;4816:						bs->neutralflagstatus = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 0
ASGNI4
line 4817
;4817:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4818
;4818:						break;
ADDRGP4 $2761
JUMPV
LABELV $2814
line 4820
;4819:					case GTS_RED_TAKEN:
;4820:						bs->neutralflagstatus = BotTeam(bs) == TEAM_RED ? 2 : 1; //FIXME: check Team_TakeFlagSound in g_team.c
ADDRLP4 296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 296
INDIRP4
ARGP4
ADDRLP4 300
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 300
INDIRI4
CNSTI4 1
NEI4 $2816
ADDRLP4 292
CNSTI4 2
ASGNI4
ADDRGP4 $2817
JUMPV
LABELV $2816
ADDRLP4 292
CNSTI4 1
ASGNI4
LABELV $2817
ADDRLP4 296
INDIRP4
CNSTI4 6964
ADDP4
ADDRLP4 292
INDIRI4
ASGNI4
line 4821
;4821:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4822
;4822:						break;
ADDRGP4 $2761
JUMPV
LABELV $2818
line 4824
;4823:					case GTS_BLUE_TAKEN:
;4824:						bs->neutralflagstatus = BotTeam(bs) == TEAM_BLUE ? 2 : 1; //FIXME: check Team_TakeFlagSound in g_team.c
ADDRLP4 308
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 308
INDIRP4
ARGP4
ADDRLP4 312
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 2
NEI4 $2820
ADDRLP4 304
CNSTI4 2
ASGNI4
ADDRGP4 $2821
JUMPV
LABELV $2820
ADDRLP4 304
CNSTI4 1
ASGNI4
LABELV $2821
ADDRLP4 308
INDIRP4
CNSTI4 6964
ADDP4
ADDRLP4 304
INDIRI4
ASGNI4
line 4825
;4825:						bs->flagstatuschanged = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 1
ASGNI4
line 4826
;4826:						break;
line 4828
;4827:				}
;4828:			}
line 4829
;4829:			break;
ADDRGP4 $2761
JUMPV
LABELV $2823
line 4832
;4830:		}
;4831:		case EV_PLAYER_TELEPORT_IN:
;4832:		{
line 4833
;4833:			VectorCopy(state->origin, lastteleport_origin);
ADDRGP4 lastteleport_origin
ADDRFP4 4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 4834
;4834:			lastteleport_time = FloatTime();
ADDRGP4 lastteleport_time
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4835
;4835:			break;
ADDRGP4 $2761
JUMPV
LABELV $2824
line 4838
;4836:		}
;4837:		case EV_GENERAL_SOUND:
;4838:		{
line 4840
;4839:			//if this sound is played on the bot
;4840:			if (state->number == bs->client) {
ADDRFP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2761
line 4841
;4841:				if (state->eventParm < 0 || state->eventParm >= MAX_SOUNDS) {
ADDRLP4 284
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 284
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LTI4 $2829
ADDRLP4 284
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 256
LTI4 $2827
LABELV $2829
line 4842
;4842:					BotAI_Print(PRT_ERROR, "EV_GENERAL_SOUND: eventParm (%d) out of range\n", state->eventParm);
CNSTI4 3
ARGI4
ADDRGP4 $2830
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 4843
;4843:					break;
ADDRGP4 $2761
JUMPV
LABELV $2827
line 4846
;4844:				}
;4845:				//check out the sound
;4846:				trap_GetConfigstring(CS_SOUNDS + state->eventParm, buf, sizeof(buf));
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 273
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 4848
;4847:				//if falling into a death pit
;4848:				if (!strcmp(buf, "*falling1.wav")) {
ADDRLP4 4
ARGP4
ADDRGP4 $2833
ARGP4
ADDRLP4 288
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
NEI4 $2761
line 4850
;4849:					//if the bot has a personal teleporter
;4850:					if (bs->inventory[INVENTORY_TELEPORTER] > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5084
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2761
line 4852
;4851:						//use the holdable item
;4852:						trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 4853
;4853:					}
line 4854
;4854:				}
line 4855
;4855:			}
line 4856
;4856:			break;
line 4883
;4857:		}
;4858:		case EV_FOOTSTEP:
;4859:		case EV_FOOTSTEP_METAL:
;4860:		case EV_FOOTSPLASH:
;4861:		case EV_FOOTWADE:
;4862:		case EV_SWIM:
;4863:		case EV_FALL_SHORT:
;4864:		case EV_FALL_MEDIUM:
;4865:		case EV_FALL_FAR:
;4866:		case EV_STEP_4:
;4867:		case EV_STEP_8:
;4868:		case EV_STEP_12:
;4869:		case EV_STEP_16:
;4870:		case EV_JUMP_PAD:
;4871:		case EV_JUMP:
;4872:		case EV_TAUNT:
;4873:		case EV_WATER_TOUCH:
;4874:		case EV_WATER_LEAVE:
;4875:		case EV_WATER_UNDER:
;4876:		case EV_WATER_CLEAR:
;4877:		case EV_ITEM_PICKUP:
;4878:		case EV_GLOBAL_ITEM_PICKUP:
;4879:		case EV_NOAMMO:
;4880:		case EV_CHANGE_WEAPON:
;4881:		case EV_FIRE_WEAPON:
;4882:			//FIXME: either add to sound queue or mark player as someone making noise
;4883:			break;
line 4900
;4884:		case EV_USE_ITEM0:
;4885:		case EV_USE_ITEM1:
;4886:		case EV_USE_ITEM2:
;4887:		case EV_USE_ITEM3:
;4888:		case EV_USE_ITEM4:
;4889:		case EV_USE_ITEM5:
;4890:		case EV_USE_ITEM6:
;4891:		case EV_USE_ITEM7:
;4892:		case EV_USE_ITEM8:
;4893:		case EV_USE_ITEM9:
;4894:		case EV_USE_ITEM10:
;4895:		case EV_USE_ITEM11:
;4896:		case EV_USE_ITEM12:
;4897:		case EV_USE_ITEM13:
;4898:		case EV_USE_ITEM14:
;4899:		case EV_USE_ITEM15:
;4900:			break;
LABELV $2760
LABELV $2761
line 4902
;4901:	}
;4902:}
LABELV $2753
endproc BotCheckEvents 316 12
export BotCheckSnapshot
proc BotCheckSnapshot 216 16
line 4909
;4903:
;4904:/*
;4905:==================
;4906:BotCheckSnapshot
;4907:==================
;4908:*/
;4909:void BotCheckSnapshot(bot_state_t *bs) {
line 4914
;4910:	int ent;
;4911:	entityState_t state;
;4912:
;4913:	//remove all avoid spots
;4914:	trap_BotAddAvoidSpot(bs->ms, vec3_origin, 0, AVOID_CLEAR);
ADDRFP4 0
INDIRP4
CNSTI4 6524
ADDP4
INDIRI4
ARGI4
ADDRGP4 vec3_origin
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 trap_BotAddAvoidSpot
CALLV
pop
line 4916
;4915:	//reset kamikaze body
;4916:	bs->kamikazebody = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6256
ADDP4
CNSTI4 0
ASGNI4
line 4918
;4917:	//reset number of proxmines
;4918:	bs->numproxmines = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6516
ADDP4
CNSTI4 0
ASGNI4
line 4920
;4919:	//
;4920:	ent = 0;
ADDRLP4 208
CNSTI4 0
ASGNI4
ADDRGP4 $2842
JUMPV
LABELV $2841
line 4921
;4921:	while( ( ent = BotAI_GetSnapshotEntity( bs->client, ent, &state ) ) != -1 ) {
line 4923
;4922:		//check the entity state for events
;4923:		BotCheckEvents(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckEvents
CALLV
pop
line 4925
;4924:		//check for grenades the bot should avoid
;4925:		BotCheckForGrenades(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckForGrenades
CALLV
pop
line 4927
;4926:		//check for proximity mines which the bot should deactivate
;4927:		BotCheckForProxMines(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckForProxMines
CALLV
pop
line 4929
;4928:		//check for dead bodies with the kamikaze effect which should be gibbed
;4929:		BotCheckForKamikazeBody(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckForKamikazeBody
CALLV
pop
line 4930
;4930:	}
LABELV $2842
line 4921
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 208
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 212
ADDRGP4 BotAI_GetSnapshotEntity
CALLI4
ASGNI4
ADDRLP4 208
ADDRLP4 212
INDIRI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 -1
NEI4 $2841
line 4932
;4931:	//check the player state for events
;4932:	BotAI_GetEntityState(bs->client, &state);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotAI_GetEntityState
CALLI4
pop
line 4934
;4933:	//copy the player state events to the entity state
;4934:	state.event = bs->cur_ps.externalEvent;
ADDRLP4 0+180
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 4935
;4935:	state.eventParm = bs->cur_ps.externalEventParm;
ADDRLP4 0+184
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ASGNI4
line 4937
;4936:	//
;4937:	BotCheckEvents(bs, &state);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 BotCheckEvents
CALLV
pop
line 4938
;4938:}
LABELV $2840
endproc BotCheckSnapshot 216 16
export BotCheckAir
proc BotCheckAir 4 4
line 4945
;4939:
;4940:/*
;4941:==================
;4942:BotCheckAir
;4943:==================
;4944:*/
;4945:void BotCheckAir(bot_state_t *bs) {
line 4946
;4946:	if (bs->inventory[INVENTORY_ENVIRONMENTSUIT] <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 5124
ADDP4
INDIRI4
CNSTI4 0
GTI4 $2847
line 4947
;4947:		if (trap_AAS_PointContents(bs->eye) & (CONTENTS_WATER|CONTENTS_SLIME|CONTENTS_LAVA)) {
ADDRFP4 0
INDIRP4
CNSTI4 4936
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 trap_AAS_PointContents
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $2849
line 4948
;4948:			return;
ADDRGP4 $2846
JUMPV
LABELV $2849
line 4950
;4949:		}
;4950:	}
LABELV $2847
line 4951
;4951:	bs->lastair_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6176
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4952
;4952:}
LABELV $2846
endproc BotCheckAir 4 4
export BotAlternateRoute
proc BotAlternateRoute 16 16
line 4959
;4953:
;4954:/*
;4955:==================
;4956:BotAlternateRoute
;4957:==================
;4958:*/
;4959:bot_goal_t *BotAlternateRoute(bot_state_t *bs, bot_goal_t *goal) {
line 4963
;4960:	int t;
;4961:
;4962:	// if the bot has an alternative route goal
;4963:	if (bs->altroutegoal.areanum) {
ADDRFP4 0
INDIRP4
CNSTI4 6692
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2852
line 4965
;4964:		//
;4965:		if (bs->reachedaltroutegoal_time)
ADDRFP4 0
INDIRP4
CNSTI4 6736
ADDP4
INDIRF4
CNSTF4 0
EQF4 $2854
line 4966
;4966:			return goal;
ADDRFP4 4
INDIRP4
RETP4
ADDRGP4 $2851
JUMPV
LABELV $2854
line 4968
;4967:		// travel time towards alternative route goal
;4968:		t = trap_AAS_AreaTravelTimeToGoalArea(bs->areanum, bs->origin, bs->altroutegoal.areanum, bs->tfl);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4948
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 4908
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 6692
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 5976
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 4969
;4969:		if (t && t < 20) {
ADDRLP4 12
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2856
ADDRLP4 12
INDIRI4
CNSTI4 20
GEI4 $2856
line 4971
;4970:			//BotAI_Print(PRT_MESSAGE, "reached alternate route goal\n");
;4971:			bs->reachedaltroutegoal_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6736
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 4972
;4972:		}
LABELV $2856
line 4973
;4973:		memcpy(goal, &bs->altroutegoal, sizeof(bot_goal_t));
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6680
ADDP4
ARGP4
CNSTI4 56
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 4974
;4974:		return &bs->altroutegoal;
ADDRFP4 0
INDIRP4
CNSTI4 6680
ADDP4
RETP4
ADDRGP4 $2851
JUMPV
LABELV $2852
line 4976
;4975:	}
;4976:	return goal;
ADDRFP4 4
INDIRP4
RETP4
LABELV $2851
endproc BotAlternateRoute 16 16
export BotGetAlternateRouteGoal
proc BotGetAlternateRouteGoal 20 0
line 4984
;4977:}
;4978:
;4979:/*
;4980:==================
;4981:BotGetAlternateRouteGoal
;4982:==================
;4983:*/
;4984:int BotGetAlternateRouteGoal(bot_state_t *bs, int base) {
line 4989
;4985:	aas_altroutegoal_t *altroutegoals;
;4986:	bot_goal_t *goal;
;4987:	int numaltroutegoals, rnd;
;4988:
;4989:	if (base == TEAM_RED) {
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $2859
line 4990
;4990:		altroutegoals = red_altroutegoals;
ADDRLP4 12
ADDRGP4 red_altroutegoals
ASGNP4
line 4991
;4991:		numaltroutegoals = red_numaltroutegoals;
ADDRLP4 4
ADDRGP4 red_numaltroutegoals
INDIRI4
ASGNI4
line 4992
;4992:	}
ADDRGP4 $2860
JUMPV
LABELV $2859
line 4993
;4993:	else {
line 4994
;4994:		altroutegoals = blue_altroutegoals;
ADDRLP4 12
ADDRGP4 blue_altroutegoals
ASGNP4
line 4995
;4995:		numaltroutegoals = blue_numaltroutegoals;
ADDRLP4 4
ADDRGP4 blue_numaltroutegoals
INDIRI4
ASGNI4
line 4996
;4996:	}
LABELV $2860
line 4997
;4997:	if (!numaltroutegoals)
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2861
line 4998
;4998:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2858
JUMPV
LABELV $2861
line 4999
;4999:	rnd = (float) random() * numaltroutegoals;
ADDRLP4 16
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ADDRLP4 4
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 5000
;5000:	if (rnd >= numaltroutegoals)
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $2863
line 5001
;5001:		rnd = numaltroutegoals-1;
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $2863
line 5002
;5002:	goal = &bs->altroutegoal;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 6680
ADDP4
ASGNP4
line 5003
;5003:	goal->areanum = altroutegoals[rnd].areanum;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 24
MULI4
ADDRLP4 12
INDIRP4
ADDP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 5004
;5004:	VectorCopy(altroutegoals[rnd].origin, goal->origin);
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
CNSTI4 24
MULI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRB
ASGNB 12
line 5005
;5005:	VectorSet(goal->mins, -8, -8, -8);
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTF4 3238002688
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTF4 3238002688
ASGNF4
line 5006
;5006:	VectorSet(goal->maxs, 8, 8, 8);
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1090519040
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1090519040
ASGNF4
line 5007
;5007:	goal->entitynum = 0;
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
CNSTI4 0
ASGNI4
line 5008
;5008:	goal->iteminfo = 0;
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
CNSTI4 0
ASGNI4
line 5009
;5009:	goal->number = 0;
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 5010
;5010:	goal->flags = 0;
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
CNSTI4 0
ASGNI4
line 5012
;5011:	//
;5012:	bs->reachedaltroutegoal_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6736
ADDP4
CNSTF4 0
ASGNF4
line 5013
;5013:	return qtrue;
CNSTI4 1
RETI4
LABELV $2858
endproc BotGetAlternateRouteGoal 20 0
export BotSetupAlternativeRouteGoals
proc BotSetupAlternativeRouteGoals 12 32
line 5021
;5014:}
;5015:
;5016:/*
;5017:==================
;5018:BotSetupAlternateRouteGoals
;5019:==================
;5020:*/
;5021:void BotSetupAlternativeRouteGoals(void) {
line 5023
;5022:
;5023:	if (altroutegoals_setup)
ADDRGP4 altroutegoals_setup
INDIRI4
CNSTI4 0
EQI4 $2866
line 5024
;5024:		return;
ADDRGP4 $2865
JUMPV
LABELV $2866
line 5026
;5025:
;5026:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $2868
line 5027
;5027:		if (trap_BotGetLevelItemGoal(-1, "Neutral Flag", &ctf_neutralflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2872
ARGP4
ADDRGP4 ctf_neutralflag
ARGP4
ADDRLP4 0
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $2870
line 5028
;5028:			BotAI_Print(PRT_WARNING, "no alt routes without Neutral Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $2873
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $2870
line 5029
;5029:		if (ctf_neutralflag.areanum) {
ADDRGP4 ctf_neutralflag+12
INDIRI4
CNSTI4 0
EQI4 $2869
line 5031
;5030:			//
;5031:			red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 ctf_neutralflag
ARGP4
ADDRGP4 ctf_neutralflag+12
INDIRI4
ARGI4
ADDRGP4 ctf_redflag
ARGP4
ADDRGP4 ctf_redflag+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 red_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 4
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 red_numaltroutegoals
ADDRLP4 4
INDIRI4
ASGNI4
line 5037
;5032:										ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5033:										ctf_redflag.origin, ctf_redflag.areanum, TFL_DEFAULT,
;5034:										red_altroutegoals, MAX_ALTROUTEGOALS,
;5035:										ALTROUTEGOAL_CLUSTERPORTALS|
;5036:										ALTROUTEGOAL_VIEWPORTALS);
;5037:			blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 ctf_neutralflag
ARGP4
ADDRGP4 ctf_neutralflag+12
INDIRI4
ARGI4
ADDRGP4 ctf_blueflag
ARGP4
ADDRGP4 ctf_blueflag+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 blue_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 8
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 blue_numaltroutegoals
ADDRLP4 8
INDIRI4
ASGNI4
line 5043
;5038:										ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5039:										ctf_blueflag.origin, ctf_blueflag.areanum, TFL_DEFAULT,
;5040:										blue_altroutegoals, MAX_ALTROUTEGOALS,
;5041:										ALTROUTEGOAL_CLUSTERPORTALS|
;5042:										ALTROUTEGOAL_VIEWPORTALS);
;5043:		}
line 5044
;5044:	} else if (gametype == GT_1FCTF) {
ADDRGP4 $2869
JUMPV
LABELV $2868
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $2881
line 5046
;5045:		//
;5046:		red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 ctf_neutralflag
ARGP4
ADDRGP4 ctf_neutralflag+12
INDIRI4
ARGI4
ADDRGP4 ctf_redflag
ARGP4
ADDRGP4 ctf_redflag+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 red_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 0
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 red_numaltroutegoals
ADDRLP4 0
INDIRI4
ASGNI4
line 5052
;5047:									ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5048:									ctf_redflag.origin, ctf_redflag.areanum, TFL_DEFAULT,
;5049:									red_altroutegoals, MAX_ALTROUTEGOALS,
;5050:									ALTROUTEGOAL_CLUSTERPORTALS|
;5051:									ALTROUTEGOAL_VIEWPORTALS);
;5052:		blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 ctf_neutralflag
ARGP4
ADDRGP4 ctf_neutralflag+12
INDIRI4
ARGI4
ADDRGP4 ctf_blueflag
ARGP4
ADDRGP4 ctf_blueflag+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 blue_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 4
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 blue_numaltroutegoals
ADDRLP4 4
INDIRI4
ASGNI4
line 5058
;5053:									ctf_neutralflag.origin, ctf_neutralflag.areanum,
;5054:									ctf_blueflag.origin, ctf_blueflag.areanum, TFL_DEFAULT,
;5055:									blue_altroutegoals, MAX_ALTROUTEGOALS,
;5056:									ALTROUTEGOAL_CLUSTERPORTALS|
;5057:									ALTROUTEGOAL_VIEWPORTALS);
;5058:	} else if (gametype == GT_OBELISK) {
ADDRGP4 $2882
JUMPV
LABELV $2881
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $2887
line 5059
;5059:		if (trap_BotGetLevelItemGoal(-1, "Neutral Obelisk", &neutralobelisk) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2891
ARGP4
ADDRGP4 neutralobelisk
ARGP4
ADDRLP4 0
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $2889
line 5060
;5060:			BotAI_Print(PRT_WARNING, "Harvester without neutral obelisk\n");
CNSTI4 2
ARGI4
ADDRGP4 $2892
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $2889
line 5062
;5061:		//
;5062:		red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 neutralobelisk
ARGP4
ADDRGP4 neutralobelisk+12
INDIRI4
ARGI4
ADDRGP4 redobelisk
ARGP4
ADDRGP4 redobelisk+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 red_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 4
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 red_numaltroutegoals
ADDRLP4 4
INDIRI4
ASGNI4
line 5068
;5063:									neutralobelisk.origin, neutralobelisk.areanum,
;5064:									redobelisk.origin, redobelisk.areanum, TFL_DEFAULT,
;5065:									red_altroutegoals, MAX_ALTROUTEGOALS,
;5066:									ALTROUTEGOAL_CLUSTERPORTALS|
;5067:									ALTROUTEGOAL_VIEWPORTALS);
;5068:		blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 neutralobelisk
ARGP4
ADDRGP4 neutralobelisk+12
INDIRI4
ARGI4
ADDRGP4 blueobelisk
ARGP4
ADDRGP4 blueobelisk+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 blue_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 8
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 blue_numaltroutegoals
ADDRLP4 8
INDIRI4
ASGNI4
line 5074
;5069:									neutralobelisk.origin, neutralobelisk.areanum,
;5070:									blueobelisk.origin, blueobelisk.areanum, TFL_DEFAULT,
;5071:									blue_altroutegoals, MAX_ALTROUTEGOALS,
;5072:									ALTROUTEGOAL_CLUSTERPORTALS|
;5073:									ALTROUTEGOAL_VIEWPORTALS);
;5074:	} else if (gametype == GT_HARVESTER) {
ADDRGP4 $2888
JUMPV
LABELV $2887
ADDRGP4 gametype
INDIRI4
CNSTI4 8
NEI4 $2897
line 5076
;5075:		//
;5076:		red_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 neutralobelisk
ARGP4
ADDRGP4 neutralobelisk+12
INDIRI4
ARGI4
ADDRGP4 redobelisk
ARGP4
ADDRGP4 redobelisk+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 red_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 0
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 red_numaltroutegoals
ADDRLP4 0
INDIRI4
ASGNI4
line 5082
;5077:									neutralobelisk.origin, neutralobelisk.areanum,
;5078:									redobelisk.origin, redobelisk.areanum, TFL_DEFAULT,
;5079:									red_altroutegoals, MAX_ALTROUTEGOALS,
;5080:									ALTROUTEGOAL_CLUSTERPORTALS|
;5081:									ALTROUTEGOAL_VIEWPORTALS);
;5082:		blue_numaltroutegoals = trap_AAS_AlternativeRouteGoals(
ADDRGP4 neutralobelisk
ARGP4
ADDRGP4 neutralobelisk+12
INDIRI4
ARGI4
ADDRGP4 blueobelisk
ARGP4
ADDRGP4 blueobelisk+12
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRGP4 blue_altroutegoals
ARGP4
CNSTI4 32
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 4
ADDRGP4 trap_AAS_AlternativeRouteGoals
CALLI4
ASGNI4
ADDRGP4 blue_numaltroutegoals
ADDRLP4 4
INDIRI4
ASGNI4
line 5088
;5083:									neutralobelisk.origin, neutralobelisk.areanum,
;5084:									blueobelisk.origin, blueobelisk.areanum, TFL_DEFAULT,
;5085:									blue_altroutegoals, MAX_ALTROUTEGOALS,
;5086:									ALTROUTEGOAL_CLUSTERPORTALS|
;5087:									ALTROUTEGOAL_VIEWPORTALS);
;5088:	}
LABELV $2897
LABELV $2888
LABELV $2882
LABELV $2869
line 5090
;5089:
;5090:	altroutegoals_setup = qtrue;
ADDRGP4 altroutegoals_setup
CNSTI4 1
ASGNI4
line 5091
;5091:}
LABELV $2865
endproc BotSetupAlternativeRouteGoals 12 32
export BotDeathmatchAI
proc BotDeathmatchAI 1492 20
line 5098
;5092:
;5093:/*
;5094:==================
;5095:BotDeathmatchAI
;5096:==================
;5097:*/
;5098:void BotDeathmatchAI(bot_state_t *bs, float thinktime) {
line 5104
;5099:	char gender[144], name[144], buf[144];
;5100:	char userinfo[MAX_INFO_STRING];
;5101:	int i;
;5102:
;5103:	//if the bot has just been setup
;5104:	if (bs->setupcount > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2904
line 5105
;5105:		bs->setupcount--;
ADDRLP4 1460
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
ASGNP4
ADDRLP4 1460
INDIRP4
ADDRLP4 1460
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 5106
;5106:		if (bs->setupcount > 0) return;
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2906
ADDRGP4 $2903
JUMPV
LABELV $2906
line 5108
;5107:		//get the gender characteristic
;5108:		trap_Characteristic_String(bs->character, CHARACTERISTIC_GENDER, gender, sizeof(gender));
ADDRFP4 0
INDIRP4
CNSTI4 6520
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 148
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 trap_Characteristic_String
CALLV
pop
line 5110
;5109:		//set the bot gender
;5110:		trap_GetUserinfo(bs->client, userinfo, sizeof(userinfo));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 5111
;5111:		Info_SetValueForKey(userinfo, "sex", gender);
ADDRLP4 292
ARGP4
ADDRGP4 $2908
ARGP4
ADDRLP4 148
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 5112
;5112:		trap_SetUserinfo(bs->client, userinfo);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 5114
;5113:		//set the team
;5114:		if ( !bs->map_restart && g_gametype.integer != GT_DUEL ) {
ADDRFP4 0
INDIRP4
CNSTI4 6020
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2909
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
EQI4 $2909
line 5115
;5115:			Com_sprintf(buf, sizeof(buf), "team %s", bs->settings.team);
ADDRLP4 1316
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 $2912
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 4756
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 5116
;5116:			trap_EA_Command(bs->client, buf);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 1316
ARGP4
ADDRGP4 trap_EA_Command
CALLV
pop
line 5117
;5117:		}
LABELV $2909
line 5119
;5118:		//set the chat gender
;5119:		if (gender[0] == 'm') trap_BotSetChatGender(bs->cs, CHAT_GENDERMALE);
ADDRLP4 148
INDIRI1
CVII4 1
CNSTI4 109
NEI4 $2913
ADDRFP4 0
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
ADDRGP4 $2914
JUMPV
LABELV $2913
line 5120
;5120:		else if (gender[0] == 'f')  trap_BotSetChatGender(bs->cs, CHAT_GENDERFEMALE);
ADDRLP4 148
INDIRI1
CVII4 1
CNSTI4 102
NEI4 $2915
ADDRFP4 0
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
ADDRGP4 $2916
JUMPV
LABELV $2915
line 5121
;5121:		else  trap_BotSetChatGender(bs->cs, CHAT_GENDERLESS);
ADDRFP4 0
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
LABELV $2916
LABELV $2914
line 5123
;5122:		//set the chat name
;5123:		ClientName(bs->client, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 5124
;5124:		trap_BotSetChatName(bs->cs, name, bs->client);
ADDRLP4 1464
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1464
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 1464
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotSetChatName
CALLV
pop
line 5126
;5125:		//
;5126:		bs->lastframe_health = bs->inventory[INVENTORY_HEALTH];
ADDRLP4 1468
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1468
INDIRP4
CNSTI4 6044
ADDP4
ADDRLP4 1468
INDIRP4
CNSTI4 5080
ADDP4
INDIRI4
ASGNI4
line 5127
;5127:		bs->lasthitcount = bs->cur_ps.persistant[PERS_HITS];
ADDRLP4 1472
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1472
INDIRP4
CNSTI4 6048
ADDP4
ADDRLP4 1472
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
ASGNI4
line 5129
;5128:		//
;5129:		bs->setupcount = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6016
ADDP4
CNSTI4 0
ASGNI4
line 5131
;5130:		//
;5131:		BotSetupAlternativeRouteGoals();
ADDRGP4 BotSetupAlternativeRouteGoals
CALLV
pop
line 5132
;5132:	}
LABELV $2904
line 5134
;5133:	//no ideal view set
;5134:	bs->flags &= ~BFL_IDEALVIEWSET;
ADDRLP4 1460
ADDRFP4 0
INDIRP4
CNSTI4 5980
ADDP4
ASGNP4
ADDRLP4 1460
INDIRP4
ADDRLP4 1460
INDIRP4
INDIRI4
CNSTI4 -33
BANDI4
ASGNI4
line 5136
;5135:	//
;5136:	if (!BotIntermission(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1464
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 1464
INDIRI4
CNSTI4 0
NEI4 $2917
line 5138
;5137:		//set the teleport time
;5138:		BotSetTeleportTime(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotSetTeleportTime
CALLV
pop
line 5140
;5139:		//update some inventory values
;5140:		BotUpdateInventory(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotUpdateInventory
CALLV
pop
line 5142
;5141:		//check out the snapshot
;5142:		BotCheckSnapshot(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckSnapshot
CALLV
pop
line 5144
;5143:		//check for air
;5144:		BotCheckAir(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckAir
CALLV
pop
line 5145
;5145:	}
LABELV $2917
line 5147
;5146:	//check the console messages
;5147:	BotCheckConsoleMessages(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckConsoleMessages
CALLV
pop
line 5149
;5148:	//if not in the intermission and not in observer mode
;5149:	if (!BotIntermission(bs) && !BotIsObserver(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1468
ADDRGP4 BotIntermission
CALLI4
ASGNI4
ADDRLP4 1468
INDIRI4
CNSTI4 0
NEI4 $2919
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1472
ADDRGP4 BotIsObserver
CALLI4
ASGNI4
ADDRLP4 1472
INDIRI4
CNSTI4 0
NEI4 $2919
line 5151
;5150:		//do team AI
;5151:		BotTeamAI(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotTeamAI
CALLV
pop
line 5152
;5152:	}
LABELV $2919
line 5154
;5153:	//if the bot has no ai node
;5154:	if (!bs->ainode) {
ADDRFP4 0
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2921
line 5155
;5155:		AIEnter_Seek_LTG(bs, "BotDeathmatchAI: no ai node");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2923
ARGP4
ADDRGP4 AIEnter_Seek_LTG
CALLV
pop
line 5156
;5156:	}
LABELV $2921
line 5158
;5157:	//if the bot entered the game less than 8 seconds ago
;5158:	if (!bs->entergamechat && bs->entergame_time > FloatTime() - 8) {
ADDRLP4 1476
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1476
INDIRP4
CNSTI4 6024
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2924
ADDRLP4 1476
INDIRP4
CNSTI4 6064
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1090519040
SUBF4
LEF4 $2924
line 5159
;5159:		if (BotChat_EnterGame(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1480
ADDRGP4 BotChat_EnterGame
CALLI4
ASGNI4
ADDRLP4 1480
INDIRI4
CNSTI4 0
EQI4 $2926
line 5160
;5160:			bs->stand_time = FloatTime() + BotChatTime(bs);
ADDRLP4 1484
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1484
INDIRP4
ARGP4
ADDRLP4 1488
ADDRGP4 BotChatTime
CALLF4
ASGNF4
ADDRLP4 1484
INDIRP4
CNSTI4 6096
ADDP4
ADDRGP4 floattime
INDIRF4
ADDRLP4 1488
INDIRF4
ADDF4
ASGNF4
line 5161
;5161:			AIEnter_Stand(bs, "BotDeathmatchAI: chat enter game");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2928
ARGP4
ADDRGP4 AIEnter_Stand
CALLV
pop
line 5162
;5162:		}
LABELV $2926
line 5163
;5163:		bs->entergamechat = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 6024
ADDP4
CNSTI4 1
ASGNI4
line 5164
;5164:	}
LABELV $2924
line 5166
;5165:	//reset the node switches from the previous frame
;5166:	BotResetNodeSwitches();
ADDRGP4 BotResetNodeSwitches
CALLV
pop
line 5168
;5167:	//execute AI nodes
;5168:	for (i = 0; i < MAX_NODESWITCHES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2929
line 5169
;5169:		if (bs->ainode(bs)) break;
ADDRLP4 1480
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1480
INDIRP4
ARGP4
ADDRLP4 1484
ADDRLP4 1480
INDIRP4
CNSTI4 4900
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1484
INDIRI4
CNSTI4 0
EQI4 $2933
ADDRGP4 $2931
JUMPV
LABELV $2933
line 5170
;5170:	}
LABELV $2930
line 5168
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 50
LTI4 $2929
LABELV $2931
line 5172
;5171:	//if the bot removed itself :)
;5172:	if (!bs->inuse) return;
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $2935
ADDRGP4 $2903
JUMPV
LABELV $2935
line 5174
;5173:	//if the bot executed too many AI nodes
;5174:	if (i >= MAX_NODESWITCHES) {
ADDRLP4 0
INDIRI4
CNSTI4 50
LTI4 $2937
line 5175
;5175:		trap_BotDumpGoalStack(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotDumpGoalStack
CALLV
pop
line 5176
;5176:		trap_BotDumpAvoidGoals(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 6528
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotDumpAvoidGoals
CALLV
pop
line 5177
;5177:		BotDumpNodeSwitches(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotDumpNodeSwitches
CALLV
pop
line 5178
;5178:		ClientName(bs->client, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 5179
;5179:		BotAI_Print(PRT_ERROR, "%s at %1.1f switched more than %d AI nodes\n", name, FloatTime(), MAX_NODESWITCHES);
CNSTI4 3
ARGI4
ADDRGP4 $2939
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 floattime
INDIRF4
ARGF4
CNSTI4 50
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 5180
;5180:	}
LABELV $2937
line 5182
;5181:	//
;5182:	bs->lastframe_health = bs->inventory[INVENTORY_HEALTH];
ADDRLP4 1480
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1480
INDIRP4
CNSTI4 6044
ADDP4
ADDRLP4 1480
INDIRP4
CNSTI4 5080
ADDP4
INDIRI4
ASGNI4
line 5183
;5183:	bs->lasthitcount = bs->cur_ps.persistant[PERS_HITS];
ADDRLP4 1484
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1484
INDIRP4
CNSTI4 6048
ADDP4
ADDRLP4 1484
INDIRP4
CNSTI4 268
ADDP4
INDIRI4
ASGNI4
line 5184
;5184:}
LABELV $2903
endproc BotDeathmatchAI 1492 20
export BotSetEntityNumForGoalWithModel
proc BotSetEntityNumForGoalWithModel 44 4
line 5191
;5185:
;5186:/*
;5187:==================
;5188:BotSetEntityNumForGoalWithModel
;5189:==================
;5190:*/
;5191:void BotSetEntityNumForGoalWithModel(bot_goal_t *goal, int eType, char *modelname) {
line 5196
;5192:	gentity_t *ent;
;5193:	int i, modelindex;
;5194:	vec3_t dir;
;5195:
;5196:	modelindex = G_ModelIndex( modelname );
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 G_ModelIndex
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 5197
;5197:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 5198
;5198:	for (i = 0; i < level.num_entities; i++, ent++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $2944
JUMPV
LABELV $2941
line 5199
;5199:		if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2946
line 5200
;5200:			continue;
ADDRGP4 $2942
JUMPV
LABELV $2946
line 5202
;5201:		}
;5202:		if ( eType && ent->s.eType != eType) {
ADDRLP4 28
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2948
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $2948
line 5203
;5203:			continue;
ADDRGP4 $2942
JUMPV
LABELV $2948
line 5205
;5204:		}
;5205:		if (ent->s.modelindex != modelindex) {
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $2950
line 5206
;5206:			continue;
ADDRGP4 $2942
JUMPV
LABELV $2950
line 5208
;5207:		}
;5208:		VectorSubtract(goal->origin, ent->s.origin, dir);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5209
;5209:		if (VectorLengthSquared(dir) < Square(10)) {
ADDRLP4 4
ARGP4
ADDRLP4 40
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 40
INDIRF4
CNSTF4 1120403456
GEF4 $2954
line 5210
;5210:			goal->entitynum = i;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 5211
;5211:			return;
ADDRGP4 $2940
JUMPV
LABELV $2954
line 5213
;5212:		}
;5213:	}
LABELV $2942
line 5198
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 832
ADDP4
ASGNP4
LABELV $2944
ADDRLP4 16
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $2941
line 5214
;5214:}
LABELV $2940
endproc BotSetEntityNumForGoalWithModel 44 4
export BotSetEntityNumForGoal
proc BotSetEntityNumForGoal 36 8
line 5221
;5215:
;5216:/*
;5217:==================
;5218:BotSetEntityNumForGoal
;5219:==================
;5220:*/
;5221:void BotSetEntityNumForGoal(bot_goal_t *goal, char *classname) {
line 5226
;5222:	gentity_t *ent;
;5223:	int i;
;5224:	vec3_t dir;
;5225:
;5226:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 5227
;5227:	for (i = 0; i < level.num_entities; i++, ent++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRGP4 $2960
JUMPV
LABELV $2957
line 5228
;5228:		if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2962
line 5229
;5229:			continue;
ADDRGP4 $2958
JUMPV
LABELV $2962
line 5231
;5230:		}
;5231:		if ( !Q_stricmp(ent->classname, classname) ) {
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $2964
line 5232
;5232:			continue;
ADDRGP4 $2958
JUMPV
LABELV $2964
line 5234
;5233:		}
;5234:		VectorSubtract(goal->origin, ent->s.origin, dir);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5235
;5235:		if (VectorLengthSquared(dir) < Square(10)) {
ADDRLP4 4
ARGP4
ADDRLP4 32
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 1120403456
GEF4 $2968
line 5236
;5236:			goal->entitynum = i;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 5237
;5237:			return;
ADDRGP4 $2956
JUMPV
LABELV $2968
line 5239
;5238:		}
;5239:	}
LABELV $2958
line 5227
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 832
ADDP4
ASGNP4
LABELV $2960
ADDRLP4 16
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $2957
line 5240
;5240:}
LABELV $2956
endproc BotSetEntityNumForGoal 36 8
export BotGoalForBSPEntity
proc BotGoalForBSPEntity 1128 20
line 5247
;5241:
;5242:/*
;5243:==================
;5244:BotGoalForBSPEntity
;5245:==================
;5246:*/
;5247:int BotGoalForBSPEntity( char *classname, bot_goal_t *goal ) {
line 5252
;5248:	char value[MAX_INFO_STRING];
;5249:	vec3_t origin, start, end;
;5250:	int ent, numareas, areas[10];
;5251:
;5252:	memset(goal, 0, sizeof(bot_goal_t));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 5253
;5253:	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
CNSTI4 0
ARGI4
ADDRLP4 1108
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1108
INDIRI4
ASGNI4
ADDRGP4 $2974
JUMPV
LABELV $2971
line 5254
;5254:		if (!trap_AAS_ValueForBSPEpairKey(ent, "classname", value, sizeof(value)))
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2469
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1112
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
NEI4 $2975
line 5255
;5255:			continue;
ADDRGP4 $2972
JUMPV
LABELV $2975
line 5256
;5256:		if (!strcmp(value, classname)) {
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1116
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
NEI4 $2977
line 5257
;5257:			if (!trap_AAS_VectorForBSPEpairKey(ent, "origin", origin))
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $2485
ARGP4
ADDRLP4 1028
ARGP4
ADDRLP4 1120
ADDRGP4 trap_AAS_VectorForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 1120
INDIRI4
CNSTI4 0
NEI4 $2979
line 5258
;5258:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2970
JUMPV
LABELV $2979
line 5259
;5259:			VectorCopy(origin, goal->origin);
ADDRFP4 4
INDIRP4
ADDRLP4 1028
INDIRB
ASGNB 12
line 5260
;5260:			VectorCopy(origin, start);
ADDRLP4 1040
ADDRLP4 1028
INDIRB
ASGNB 12
line 5261
;5261:			start[2] -= 32;
ADDRLP4 1040+8
ADDRLP4 1040+8
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 5262
;5262:			VectorCopy(origin, end);
ADDRLP4 1052
ADDRLP4 1028
INDIRB
ASGNB 12
line 5263
;5263:			end[2] += 32;
ADDRLP4 1052+8
ADDRLP4 1052+8
INDIRF4
CNSTF4 1107296256
ADDF4
ASGNF4
line 5264
;5264:			numareas = trap_AAS_TraceAreas(start, end, areas, NULL, 10);
ADDRLP4 1040
ARGP4
ADDRLP4 1052
ARGP4
ADDRLP4 1068
ARGP4
CNSTP4 0
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 1124
ADDRGP4 trap_AAS_TraceAreas
CALLI4
ASGNI4
ADDRLP4 1064
ADDRLP4 1124
INDIRI4
ASGNI4
line 5265
;5265:			if (!numareas)
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $2983
line 5266
;5266:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2970
JUMPV
LABELV $2983
line 5267
;5267:			goal->areanum = areas[0];
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 1068
INDIRI4
ASGNI4
line 5268
;5268:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2970
JUMPV
LABELV $2977
line 5270
;5269:		}
;5270:	}
LABELV $2972
line 5253
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1112
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1112
INDIRI4
ASGNI4
LABELV $2974
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2971
line 5271
;5271:	return qfalse;
CNSTI4 0
RETI4
LABELV $2970
endproc BotGoalForBSPEntity 1128 20
export BotSetupDeathmatchAI
proc BotSetupDeathmatchAI 152 16
line 5279
;5272:}
;5273:
;5274:/*
;5275:==================
;5276:BotSetupDeathmatchAI
;5277:==================
;5278:*/
;5279:void BotSetupDeathmatchAI(void) {
line 5283
;5280:	int ent, modelnum;
;5281:	char model[128];
;5282:
;5283:	gametype = trap_Cvar_VariableIntegerValue( "g_gametype" );
ADDRGP4 $2986
ARGP4
ADDRLP4 136
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 gametype
ADDRLP4 136
INDIRI4
ASGNI4
line 5285
;5284:
;5285:	trap_Cvar_Register(&bot_rocketjump, "bot_rocketjump", "1", 0);
ADDRGP4 bot_rocketjump
ARGP4
ADDRGP4 $2987
ARGP4
ADDRGP4 $2719
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5286
;5286:	trap_Cvar_Register(&bot_grapple, "bot_grapple", "0", 0);
ADDRGP4 bot_grapple
ARGP4
ADDRGP4 $2988
ARGP4
ADDRGP4 $2989
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5287
;5287:	trap_Cvar_Register(&bot_fastchat, "bot_fastchat", "0", 0);
ADDRGP4 bot_fastchat
ARGP4
ADDRGP4 $2990
ARGP4
ADDRGP4 $2989
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5288
;5288:	trap_Cvar_Register(&bot_nochat, "bot_nochat", "0", 0);
ADDRGP4 bot_nochat
ARGP4
ADDRGP4 $2991
ARGP4
ADDRGP4 $2989
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5289
;5289:	trap_Cvar_Register(&bot_testrchat, "bot_testrchat", "0", 0);
ADDRGP4 bot_testrchat
ARGP4
ADDRGP4 $2718
ARGP4
ADDRGP4 $2989
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5290
;5290:	trap_Cvar_Register(&bot_challenge, "bot_challenge", "0", 0);
ADDRGP4 bot_challenge
ARGP4
ADDRGP4 $2992
ARGP4
ADDRGP4 $2989
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5291
;5291:	trap_Cvar_Register(&bot_predictobstacles, "bot_predictobstacles", "1", 0);
ADDRGP4 bot_predictobstacles
ARGP4
ADDRGP4 $2993
ARGP4
ADDRGP4 $2719
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5292
;5292:	trap_Cvar_Register(&g_spSkill, "g_spSkill", "2", 0);
ADDRGP4 g_spSkill
ARGP4
ADDRGP4 $2994
ARGP4
ADDRGP4 $2995
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 5294
;5293:	//
;5294:	if (gametype == GT_CTF) {
ADDRGP4 gametype
INDIRI4
CNSTI4 5
NEI4 $2996
line 5295
;5295:		if (trap_BotGetLevelItemGoal(-1, "Red Flag", &ctf_redflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $3000
ARGP4
ADDRGP4 ctf_redflag
ARGP4
ADDRLP4 140
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
GEI4 $2998
line 5296
;5296:			BotAI_Print(PRT_WARNING, "CTF without Red Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $3001
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $2998
line 5297
;5297:		if (trap_BotGetLevelItemGoal(-1, "Blue Flag", &ctf_blueflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $3004
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
ADDRLP4 144
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
GEI4 $2997
line 5298
;5298:			BotAI_Print(PRT_WARNING, "CTF without Blue Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $3005
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 5299
;5299:	} else if (gametype == GT_1FCTF) {
ADDRGP4 $2997
JUMPV
LABELV $2996
ADDRGP4 gametype
INDIRI4
CNSTI4 6
NEI4 $3006
line 5300
;5300:		if (trap_BotGetLevelItemGoal(-1, "Neutral Flag", &ctf_neutralflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2872
ARGP4
ADDRGP4 ctf_neutralflag
ARGP4
ADDRLP4 140
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
GEI4 $3008
line 5301
;5301:			BotAI_Print(PRT_WARNING, "One Flag CTF without Neutral Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $3010
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3008
line 5302
;5302:		if (trap_BotGetLevelItemGoal(-1, "Red Flag", &ctf_redflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $3000
ARGP4
ADDRGP4 ctf_redflag
ARGP4
ADDRLP4 144
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
GEI4 $3011
line 5303
;5303:			BotAI_Print(PRT_WARNING, "One Flag CTF without Red Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $3013
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3011
line 5304
;5304:		if (trap_BotGetLevelItemGoal(-1, "Blue Flag", &ctf_blueflag) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $3004
ARGP4
ADDRGP4 ctf_blueflag
ARGP4
ADDRLP4 148
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
GEI4 $3007
line 5305
;5305:			BotAI_Print(PRT_WARNING, "One Flag CTF without Blue Flag\n");
CNSTI4 2
ARGI4
ADDRGP4 $3016
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
line 5306
;5306:	} else if (gametype == GT_OBELISK) {
ADDRGP4 $3007
JUMPV
LABELV $3006
ADDRGP4 gametype
INDIRI4
CNSTI4 7
NEI4 $3017
line 5307
;5307:		if (trap_BotGetLevelItemGoal(-1, "Red Obelisk", &redobelisk) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $3021
ARGP4
ADDRGP4 redobelisk
ARGP4
ADDRLP4 140
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
GEI4 $3019
line 5308
;5308:			BotAI_Print(PRT_WARNING, "Obelisk without red obelisk\n");
CNSTI4 2
ARGI4
ADDRGP4 $3022
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3019
line 5309
;5309:		BotSetEntityNumForGoal(&redobelisk, "team_redobelisk");
ADDRGP4 redobelisk
ARGP4
ADDRGP4 $3023
ARGP4
ADDRGP4 BotSetEntityNumForGoal
CALLV
pop
line 5310
;5310:		if (trap_BotGetLevelItemGoal(-1, "Blue Obelisk", &blueobelisk) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $3026
ARGP4
ADDRGP4 blueobelisk
ARGP4
ADDRLP4 144
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
GEI4 $3024
line 5311
;5311:			BotAI_Print(PRT_WARNING, "Obelisk without blue obelisk\n");
CNSTI4 2
ARGI4
ADDRGP4 $3027
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3024
line 5312
;5312:		BotSetEntityNumForGoal(&blueobelisk, "team_blueobelisk");
ADDRGP4 blueobelisk
ARGP4
ADDRGP4 $3028
ARGP4
ADDRGP4 BotSetEntityNumForGoal
CALLV
pop
line 5313
;5313:	}
ADDRGP4 $3018
JUMPV
LABELV $3017
line 5314
;5314:	else if (gametype == GT_HARVESTER) {
ADDRGP4 gametype
INDIRI4
CNSTI4 8
NEI4 $3029
line 5315
;5315:		if (trap_BotGetLevelItemGoal(-1, "Red Obelisk", &redobelisk) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $3021
ARGP4
ADDRGP4 redobelisk
ARGP4
ADDRLP4 140
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
GEI4 $3031
line 5316
;5316:			BotAI_Print(PRT_WARNING, "Harvester without red obelisk\n");
CNSTI4 2
ARGI4
ADDRGP4 $3033
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3031
line 5317
;5317:		BotSetEntityNumForGoal(&redobelisk, "team_redobelisk");
ADDRGP4 redobelisk
ARGP4
ADDRGP4 $3023
ARGP4
ADDRGP4 BotSetEntityNumForGoal
CALLV
pop
line 5318
;5318:		if (trap_BotGetLevelItemGoal(-1, "Blue Obelisk", &blueobelisk) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $3026
ARGP4
ADDRGP4 blueobelisk
ARGP4
ADDRLP4 144
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
GEI4 $3034
line 5319
;5319:			BotAI_Print(PRT_WARNING, "Harvester without blue obelisk\n");
CNSTI4 2
ARGI4
ADDRGP4 $3036
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3034
line 5320
;5320:		BotSetEntityNumForGoal(&blueobelisk, "team_blueobelisk");
ADDRGP4 blueobelisk
ARGP4
ADDRGP4 $3028
ARGP4
ADDRGP4 BotSetEntityNumForGoal
CALLV
pop
line 5321
;5321:		if (trap_BotGetLevelItemGoal(-1, "Neutral Obelisk", &neutralobelisk) < 0)
CNSTI4 -1
ARGI4
ADDRGP4 $2891
ARGP4
ADDRGP4 neutralobelisk
ARGP4
ADDRLP4 148
ADDRGP4 trap_BotGetLevelItemGoal
CALLI4
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 0
GEI4 $3037
line 5322
;5322:			BotAI_Print(PRT_WARNING, "Harvester without neutral obelisk\n");
CNSTI4 2
ARGI4
ADDRGP4 $2892
ARGP4
ADDRGP4 BotAI_Print
CALLV
pop
LABELV $3037
line 5323
;5323:		BotSetEntityNumForGoal(&neutralobelisk, "team_neutralobelisk");
ADDRGP4 neutralobelisk
ARGP4
ADDRGP4 $3039
ARGP4
ADDRGP4 BotSetEntityNumForGoal
CALLV
pop
line 5324
;5324:	}
LABELV $3029
LABELV $3018
LABELV $3007
LABELV $2997
line 5326
;5325:
;5326:	max_bspmodelindex = 0;
ADDRGP4 max_bspmodelindex
CNSTI4 0
ASGNI4
line 5327
;5327:	for (ent = trap_AAS_NextBSPEntity(0); ent; ent = trap_AAS_NextBSPEntity(ent)) {
CNSTI4 0
ARGI4
ADDRLP4 140
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 140
INDIRI4
ASGNI4
ADDRGP4 $3043
JUMPV
LABELV $3040
line 5328
;5328:		if (!trap_AAS_ValueForBSPEpairKey(ent, "model", model, sizeof(model))) continue;
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $523
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 144
ADDRGP4 trap_AAS_ValueForBSPEpairKey
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $3044
ADDRGP4 $3041
JUMPV
LABELV $3044
line 5329
;5329:		if (model[0] == '*') {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $3046
line 5330
;5330:			modelnum = atoi(model+1);
ADDRLP4 4+1
ARGP4
ADDRLP4 148
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 132
ADDRLP4 148
INDIRI4
ASGNI4
line 5331
;5331:			if (modelnum > max_bspmodelindex)
ADDRLP4 132
INDIRI4
ADDRGP4 max_bspmodelindex
INDIRI4
LEI4 $3049
line 5332
;5332:				max_bspmodelindex = modelnum;
ADDRGP4 max_bspmodelindex
ADDRLP4 132
INDIRI4
ASGNI4
LABELV $3049
line 5333
;5333:		}
LABELV $3046
line 5334
;5334:	}
LABELV $3041
line 5327
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 144
ADDRGP4 trap_AAS_NextBSPEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 144
INDIRI4
ASGNI4
LABELV $3043
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $3040
line 5336
;5335:	//initialize the waypoint heap
;5336:	BotInitWaypoints();
ADDRGP4 BotInitWaypoints
CALLV
pop
line 5337
;5337:}
LABELV $2985
endproc BotSetupDeathmatchAI 152 16
export BotShutdownDeathmatchAI
proc BotShutdownDeathmatchAI 0 0
line 5344
;5338:
;5339:/*
;5340:==================
;5341:BotShutdownDeathmatchAI
;5342:==================
;5343:*/
;5344:void BotShutdownDeathmatchAI(void) {
line 5345
;5345:	altroutegoals_setup = qfalse;
ADDRGP4 altroutegoals_setup
CNSTI4 0
ASGNI4
line 5346
;5346:}
LABELV $3051
endproc BotShutdownDeathmatchAI 0 0
import g_clients
bss
export blue_numaltroutegoals
align 4
LABELV blue_numaltroutegoals
skip 4
export blue_altroutegoals
align 4
LABELV blue_altroutegoals
skip 768
export red_numaltroutegoals
align 4
LABELV red_numaltroutegoals
skip 4
export red_altroutegoals
align 4
LABELV red_altroutegoals
skip 768
export altroutegoals_setup
align 4
LABELV altroutegoals_setup
skip 4
export max_bspmodelindex
align 4
LABELV max_bspmodelindex
skip 4
export lastteleport_time
align 4
LABELV lastteleport_time
skip 4
export lastteleport_origin
align 4
LABELV lastteleport_origin
skip 12
import bot_developer
export g_spSkill
align 4
LABELV g_spSkill
skip 272
export bot_predictobstacles
align 4
LABELV bot_predictobstacles
skip 272
export botai_freewaypoints
align 4
LABELV botai_freewaypoints
skip 4
export botai_waypoints
align 4
LABELV botai_waypoints
skip 12800
import BotSetTeamMateTaskPreference
import BotGetTeamMateTaskPreference
import BotTeamAI
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
export neutralobelisk
align 4
LABELV neutralobelisk
skip 56
export blueobelisk
align 4
LABELV blueobelisk
skip 56
export redobelisk
align 4
LABELV redobelisk
skip 56
export ctf_neutralflag
align 4
LABELV ctf_neutralflag
skip 56
export ctf_blueflag
align 4
LABELV ctf_blueflag
skip 56
export ctf_redflag
align 4
LABELV ctf_redflag
skip 56
export bot_challenge
align 4
LABELV bot_challenge
skip 272
export bot_testrchat
align 4
LABELV bot_testrchat
skip 272
export bot_nochat
align 4
LABELV bot_nochat
skip 272
export bot_fastchat
align 4
LABELV bot_fastchat
skip 272
export bot_rocketjump
align 4
LABELV bot_rocketjump
skip 272
export bot_grapple
align 4
LABELV bot_grapple
skip 272
import mapname
export gametype
align 4
LABELV gametype
skip 4
import BotTeamLeader
import BotAI_GetSnapshotEntity
import BotAI_GetEntityState
import BotAI_GetClientState
import BotAI_Trace
import BotAI_BotInitialChat
import BotAI_Print
import floattime
import BotEntityInfo
import NumBots
import BotResetState
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
import BotTestAAS
import BotAIStartFrame
import BotAIShutdownClient
import BotAISetupClient
import BotAILoadMap
import BotAIShutdown
import BotAISetup
import BotInterbreedEndMatch
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
LABELV $3039
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $3036
byte 1 72
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 10
byte 1 0
align 1
LABELV $3033
byte 1 72
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 10
byte 1 0
align 1
LABELV $3028
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $3027
byte 1 79
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 10
byte 1 0
align 1
LABELV $3026
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 79
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $3023
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $3022
byte 1 79
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 10
byte 1 0
align 1
LABELV $3021
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 79
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $3016
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
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $3013
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
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $3010
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
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 78
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $3005
byte 1 67
byte 1 84
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $3004
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $3001
byte 1 67
byte 1 84
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $3000
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $2995
byte 1 50
byte 1 0
align 1
LABELV $2994
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
LABELV $2993
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 111
byte 1 98
byte 1 115
byte 1 116
byte 1 97
byte 1 99
byte 1 108
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $2992
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 99
byte 1 104
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $2991
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
LABELV $2990
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 102
byte 1 97
byte 1 115
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2989
byte 1 48
byte 1 0
align 1
LABELV $2988
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2987
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $2986
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
LABELV $2939
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 101
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 97
byte 1 110
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 65
byte 1 73
byte 1 32
byte 1 110
byte 1 111
byte 1 100
byte 1 101
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2928
byte 1 66
byte 1 111
byte 1 116
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
byte 1 65
byte 1 73
byte 1 58
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2923
byte 1 66
byte 1 111
byte 1 116
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
byte 1 65
byte 1 73
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 97
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $2912
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $2908
byte 1 115
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $2892
byte 1 72
byte 1 97
byte 1 114
byte 1 118
byte 1 101
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 32
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 10
byte 1 0
align 1
LABELV $2891
byte 1 78
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 32
byte 1 79
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $2873
byte 1 110
byte 1 111
byte 1 32
byte 1 97
byte 1 108
byte 1 116
byte 1 32
byte 1 114
byte 1 111
byte 1 117
byte 1 116
byte 1 101
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 78
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $2872
byte 1 78
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $2833
byte 1 42
byte 1 102
byte 1 97
byte 1 108
byte 1 108
byte 1 105
byte 1 110
byte 1 103
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $2830
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 69
byte 1 78
byte 1 69
byte 1 82
byte 1 65
byte 1 76
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 58
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 80
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
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
byte 1 10
byte 1 0
align 1
LABELV $2791
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
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
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
LABELV $2788
byte 1 75
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $2787
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
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
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
LABELV $2784
byte 1 69
byte 1 86
byte 1 95
byte 1 71
byte 1 76
byte 1 79
byte 1 66
byte 1 65
byte 1 76
byte 1 95
byte 1 83
byte 1 79
byte 1 85
byte 1 78
byte 1 68
byte 1 58
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 80
byte 1 97
byte 1 114
byte 1 109
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
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
byte 1 10
byte 1 0
align 1
LABELV $2730
byte 1 66
byte 1 111
byte 1 116
byte 1 67
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 67
byte 1 111
byte 1 110
byte 1 115
byte 1 111
byte 1 108
byte 1 101
byte 1 77
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 115
byte 1 58
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 121
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2723
byte 1 42
byte 1 42
byte 1 42
byte 1 42
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 121
byte 1 32
byte 1 42
byte 1 42
byte 1 42
byte 1 42
byte 1 10
byte 1 0
align 1
LABELV $2722
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 10
byte 1 0
align 1
LABELV $2719
byte 1 49
byte 1 0
align 1
LABELV $2718
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 114
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2595
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 73
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $2594
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 73
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 115
byte 1 104
byte 1 111
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 97
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 37
byte 1 49
byte 1 46
byte 1 49
byte 1 102
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 97
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $2590
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 111
byte 1 70
byte 1 111
byte 1 114
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $2578
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $2577
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $2574
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2563
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 109
byte 1 117
byte 1 108
byte 1 116
byte 1 105
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2550
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2544
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 10
byte 1 0
align 1
LABELV $2536
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $2525
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2521
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2518
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $2485
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $2480
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $2475
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $2472
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $2469
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2468
byte 1 66
byte 1 111
byte 1 116
byte 1 71
byte 1 101
byte 1 116
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 71
byte 1 111
byte 1 97
byte 1 108
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
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
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $2456
byte 1 42
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $2275
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $2252
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2249
byte 1 108
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $2211
byte 1 109
byte 1 112
byte 1 113
byte 1 51
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 54
byte 1 0
align 1
LABELV $2156
byte 1 113
byte 1 51
byte 1 116
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 121
byte 1 54
byte 1 0
align 1
LABELV $1231
byte 1 73
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
LABELV $1230
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1229
byte 1 66
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 32
byte 1 83
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $1228
byte 1 82
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $1227
byte 1 81
byte 1 117
byte 1 97
byte 1 100
byte 1 32
byte 1 68
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $1022
byte 1 66
byte 1 111
byte 1 116
byte 1 67
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 87
byte 1 97
byte 1 121
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 79
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 119
byte 1 97
byte 1 121
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $523
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $522
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 83
byte 1 107
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
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
byte 1 10
byte 1 0
align 1
LABELV $518
byte 1 110
byte 1 0
align 1
LABELV $517
byte 1 91
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
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
byte 1 93
byte 1 0
align 1
LABELV $516
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
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
byte 1 10
byte 1 0
align 1
LABELV $160
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $159
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
LABELV $70
byte 1 116
byte 1 0

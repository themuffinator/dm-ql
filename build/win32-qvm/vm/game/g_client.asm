data
export playerMins
align 4
LABELV playerMins
byte 4 3245342720
byte 4 3245342720
byte 4 3250585600
export playerMaxs
align 4
LABELV playerMaxs
byte 4 1097859072
byte 4 1097859072
byte 4 1107296256
export SP_info_player_deathmatch
code
proc SP_info_player_deathmatch 8 12
file "..\..\..\..\code\game\g_client.c"
line 19
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:#include "g_local.h"
;4:
;5:// g_client.c -- client functions that don't happen every frame
;6:
;7:const vec3_t	playerMins = {-15, -15, -24};
;8:const vec3_t	playerMaxs = { 15,  15,  32};
;9:
;10:static char	ban_reason[MAX_CVAR_VALUE_STRING];
;11:
;12:/*QUAKED info_player_deathmatch (1 0 1) (-16 -16 -24) (16 16 32) initial
;13:potential spawning position for deathmatch games.
;14:The first time a player enters the game, they will be at an 'initial' spot.
;15:Targets will be fired when someone spawns in on them.
;16:"nobots" will prevent bots from using this spot.
;17:"nohumans" will prevent non-bots from using this spot.
;18:*/
;19:void SP_info_player_deathmatch( gentity_t *ent ) {
line 22
;20:	int		i;
;21:
;22:	G_SpawnInt( "nobots", "0", &i);
ADDRGP4 $55
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 23
;23:	if ( i ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $57
line 24
;24:		ent->flags |= FL_NO_BOTS;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 8192
BORI4
ASGNI4
line 25
;25:	}
LABELV $57
line 26
;26:	G_SpawnInt( "nohumans", "0", &i );
ADDRGP4 $59
ARGP4
ADDRGP4 $56
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 27
;27:	if ( i ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $60
line 28
;28:		ent->flags |= FL_NO_HUMANS;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 29
;29:	}
LABELV $60
line 30
;30:}
LABELV $54
endproc SP_info_player_deathmatch 8 12
export SP_info_player_start
proc SP_info_player_start 0 4
line 35
;31:
;32:/*QUAKED info_player_start (1 0 0) (-16 -16 -24) (16 16 32)
;33:equivelant to info_player_deathmatch
;34:*/
;35:void SP_info_player_start(gentity_t *ent) {
line 36
;36:	ent->classname = "info_player_deathmatch";
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $63
ASGNP4
line 37
;37:	SP_info_player_deathmatch( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 SP_info_player_deathmatch
CALLV
pop
line 38
;38:}
LABELV $62
endproc SP_info_player_start 0 4
export SP_info_player_intermission
proc SP_info_player_intermission 0 0
line 43
;39:
;40:/*QUAKED info_player_intermission (1 0 1) (-16 -16 -24) (16 16 32)
;41:The intermission will be viewed from this point.  Target an info_notnull for the view direction.
;42:*/
;43:void SP_info_player_intermission( gentity_t *ent ) {
line 45
;44:
;45:}
LABELV $64
endproc SP_info_player_intermission 0 0
export SpotWouldTelefrag
proc SpotWouldTelefrag 4144 16
line 63
;46:
;47:
;48:
;49:/*
;50:=======================================================================
;51:
;52:  SelectSpawnPoint
;53:
;54:=======================================================================
;55:*/
;56:
;57:/*
;58:================
;59:SpotWouldTelefrag
;60:
;61:================
;62:*/
;63:qboolean SpotWouldTelefrag( gentity_t *spot ) {
line 69
;64:	int			i, num;
;65:	int			touch[MAX_GENTITIES];
;66:	gentity_t	*hit;
;67:	vec3_t		mins, maxs;
;68:
;69:	VectorAdd( spot->s.origin, playerMins, mins );
ADDRLP4 4132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4108
ADDRLP4 4132
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRGP4 playerMins
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4108+4
ADDRLP4 4132
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRGP4 playerMins+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4108+8
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRGP4 playerMins+8
INDIRF4
ADDF4
ASGNF4
line 70
;70:	VectorAdd( spot->s.origin, playerMaxs, maxs );
ADDRLP4 4136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4120
ADDRLP4 4136
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRGP4 playerMaxs
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4120+4
ADDRLP4 4136
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRGP4 playerMaxs+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4120+8
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRGP4 playerMaxs+8
INDIRF4
ADDF4
ASGNF4
line 71
;71:	num = trap_EntitiesInBox( mins, maxs, touch, MAX_GENTITIES );
ADDRLP4 4108
ARGP4
ADDRLP4 4120
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4140
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 4140
INDIRI4
ASGNI4
line 73
;72:
;73:	for (i=0 ; i<num ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $77
JUMPV
LABELV $74
line 74
;74:		hit = &g_entities[touch[i]];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 76
;75:		//if ( hit->client && hit->client->ps.stats[STAT_HEALTH] > 0 ) {
;76:		if ( hit->client) {
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $78
line 77
;77:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $65
JUMPV
LABELV $78
line 80
;78:		}
;79:
;80:	}
LABELV $75
line 73
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $77
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $74
line 82
;81:
;82:	return qfalse;
CNSTI4 0
RETI4
LABELV $65
endproc SpotWouldTelefrag 4144 16
proc SelectRandomFurthestSpawnPoint 596 4
line 94
;83:}
;84:
;85:
;86:/*
;87:===========
;88:SelectRandomFurthestSpawnPoint
;89:
;90:Chooses a player start, deathmatch start, etc
;91:============
;92:*/
;93:#define	MAX_SPAWN_POINTS 64
;94:static gentity_t *SelectRandomFurthestSpawnPoint( const gentity_t *ent, vec3_t avoidPoint, vec3_t origin, vec3_t angles ) {
line 107
;95:	gentity_t	*spot;
;96:	vec3_t		delta;
;97:	float		dist;
;98:	float		list_dist[MAX_SPAWN_POINTS];
;99:	gentity_t	*list_spot[MAX_SPAWN_POINTS];
;100:	int			numSpots, i, j, n;
;101:	int			selection;
;102:	int			checkTelefrag;
;103:	int			checkType;
;104:	int			checkMask;
;105:	qboolean	isBot;
;106:
;107:	checkType = qtrue;
ADDRLP4 552
CNSTI4 1
ASGNI4
line 108
;108:	checkTelefrag = qtrue;
ADDRLP4 548
CNSTI4 1
ASGNI4
line 110
;109:
;110:	if ( ent )
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $81
line 111
;111:		isBot = ((ent->r.svFlags & SVF_BOT) == SVF_BOT); 
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 8
NEI4 $84
ADDRLP4 568
CNSTI4 1
ASGNI4
ADDRGP4 $85
JUMPV
LABELV $84
ADDRLP4 568
CNSTI4 0
ASGNI4
LABELV $85
ADDRLP4 556
ADDRLP4 568
INDIRI4
ASGNI4
ADDRGP4 $82
JUMPV
LABELV $81
line 113
;112:	else
;113:		isBot = qfalse;
ADDRLP4 556
CNSTI4 0
ASGNI4
LABELV $82
line 115
;114:
;115:	checkMask = 3;
ADDRLP4 560
CNSTI4 3
ASGNI4
LABELV $86
line 119
;116:
;117:__search:
;118:
;119:	checkTelefrag = checkMask & 1;
ADDRLP4 548
ADDRLP4 560
INDIRI4
CNSTI4 1
BANDI4
ASGNI4
line 120
;120:	checkType = checkMask & 2;
ADDRLP4 552
ADDRLP4 560
INDIRI4
CNSTI4 2
BANDI4
ASGNI4
line 122
;121:
;122:	numSpots = 0;
ADDRLP4 520
CNSTI4 0
ASGNI4
line 123
;123:	for ( n = 0 ; n < level.numSpawnSpots ; n++ ) {
ADDRLP4 544
CNSTI4 0
ASGNI4
ADDRGP4 $90
JUMPV
LABELV $87
line 124
;124:		spot = level.spawnSpots[n];
ADDRLP4 528
ADDRLP4 544
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+5604
ADDP4
INDIRP4
ASGNP4
line 126
;125:
;126:		if ( spot->fteam != TEAM_FREE && level.numSpawnSpotsFFA > 0 )
ADDRLP4 528
INDIRP4
CNSTI4 816
ADDP4
INDIRI4
CNSTI4 0
EQI4 $93
ADDRGP4 level+9708
INDIRI4
CNSTI4 0
LEI4 $93
line 127
;127:			continue;
ADDRGP4 $88
JUMPV
LABELV $93
line 129
;128:
;129:		if ( checkTelefrag && SpotWouldTelefrag( spot ) )
ADDRLP4 548
INDIRI4
CNSTI4 0
EQI4 $96
ADDRLP4 528
INDIRP4
ARGP4
ADDRLP4 572
ADDRGP4 SpotWouldTelefrag
CALLI4
ASGNI4
ADDRLP4 572
INDIRI4
CNSTI4 0
EQI4 $96
line 130
;130:			continue;
ADDRGP4 $88
JUMPV
LABELV $96
line 132
;131:
;132:		if ( checkType ) 
ADDRLP4 552
INDIRI4
CNSTI4 0
EQI4 $98
line 133
;133:		{
line 134
;134:			if ( (spot->flags & FL_NO_BOTS) && isBot )
ADDRLP4 528
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $100
ADDRLP4 556
INDIRI4
CNSTI4 0
EQI4 $100
line 135
;135:				continue;
ADDRGP4 $88
JUMPV
LABELV $100
line 136
;136:			if ( (spot->flags & FL_NO_HUMANS) && !isBot )
ADDRLP4 528
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $102
ADDRLP4 556
INDIRI4
CNSTI4 0
NEI4 $102
line 137
;137:				continue;
ADDRGP4 $88
JUMPV
LABELV $102
line 138
;138:		}
LABELV $98
line 140
;139:
;140:		VectorSubtract( spot->s.origin, avoidPoint, delta );
ADDRLP4 580
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 532
ADDRLP4 528
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 580
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 532+4
ADDRLP4 528
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 580
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 532+8
ADDRLP4 528
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 141
;141:		dist = VectorLength( delta );
ADDRLP4 532
ARGP4
ADDRLP4 584
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 524
ADDRLP4 584
INDIRF4
ASGNF4
line 143
;142:
;143:		for ( i = 0; i < numSpots; i++ )
ADDRLP4 516
CNSTI4 0
ASGNI4
ADDRGP4 $109
JUMPV
LABELV $106
line 144
;144:		{
line 145
;145:			if( dist > list_dist[i] )
ADDRLP4 524
INDIRF4
ADDRLP4 516
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
LEF4 $110
line 146
;146:			{
line 147
;147:				if (numSpots >= MAX_SPAWN_POINTS)
ADDRLP4 520
INDIRI4
CNSTI4 64
LTI4 $112
line 148
;148:					numSpots = MAX_SPAWN_POINTS - 1;
ADDRLP4 520
CNSTI4 63
ASGNI4
LABELV $112
line 150
;149:
;150:				for( j = numSpots; j > i; j-- )
ADDRLP4 0
ADDRLP4 520
INDIRI4
ASGNI4
ADDRGP4 $117
JUMPV
LABELV $114
line 151
;151:				{
line 152
;152:					list_dist[j] = list_dist[j-1];
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
ADDRLP4 4-4
ADDP4
INDIRF4
ASGNF4
line 153
;153:					list_spot[j] = list_spot[j-1];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 260
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 260-4
ADDP4
INDIRP4
ASGNP4
line 154
;154:				}
LABELV $115
line 150
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $117
ADDRLP4 0
INDIRI4
ADDRLP4 516
INDIRI4
GTI4 $114
line 156
;155:
;156:				list_dist[i] = dist;
ADDRLP4 516
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 524
INDIRF4
ASGNF4
line 157
;157:				list_spot[i] = spot;
ADDRLP4 516
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 260
ADDP4
ADDRLP4 528
INDIRP4
ASGNP4
line 159
;158:
;159:				numSpots++;
ADDRLP4 520
ADDRLP4 520
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 160
;160:				break;
ADDRGP4 $108
JUMPV
LABELV $110
line 162
;161:			}
;162:		}
LABELV $107
line 143
ADDRLP4 516
ADDRLP4 516
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $109
ADDRLP4 516
INDIRI4
ADDRLP4 520
INDIRI4
LTI4 $106
LABELV $108
line 164
;163:
;164:		if(i >= numSpots && numSpots < MAX_SPAWN_POINTS)
ADDRLP4 516
INDIRI4
ADDRLP4 520
INDIRI4
LTI4 $120
ADDRLP4 520
INDIRI4
CNSTI4 64
GEI4 $120
line 165
;165:		{
line 166
;166:			list_dist[numSpots] = dist;
ADDRLP4 520
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 524
INDIRF4
ASGNF4
line 167
;167:			list_spot[numSpots] = spot;
ADDRLP4 520
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 260
ADDP4
ADDRLP4 528
INDIRP4
ASGNP4
line 168
;168:			numSpots++;
ADDRLP4 520
ADDRLP4 520
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 169
;169:		}
LABELV $120
line 170
;170:	}
LABELV $88
line 123
ADDRLP4 544
ADDRLP4 544
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $90
ADDRLP4 544
INDIRI4
ADDRGP4 level+9700
INDIRI4
LTI4 $87
line 172
;171:
;172:	if ( !numSpots ) {
ADDRLP4 520
INDIRI4
CNSTI4 0
NEI4 $122
line 173
;173:		if ( checkMask <= 0 ) {
ADDRLP4 560
INDIRI4
CNSTI4 0
GTI4 $124
line 174
;174:			G_Error( "Couldn't find a spawn point" );
ADDRGP4 $126
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 175
;175:			return NULL;
CNSTP4 0
RETP4
ADDRGP4 $80
JUMPV
LABELV $124
line 177
;176:		}
;177:		checkMask--;
ADDRLP4 560
ADDRLP4 560
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 178
;178:		goto __search; // next attempt with different flags
ADDRGP4 $86
JUMPV
LABELV $122
line 182
;179:	}
;180:
;181:	// select a random spot from the spawn points furthest away
;182:	selection = random() * (numSpots / 2);
ADDRLP4 572
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 564
ADDRLP4 572
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ADDRLP4 520
INDIRI4
CNSTI4 2
DIVI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 183
;183:	spot = list_spot[ selection ];
ADDRLP4 528
ADDRLP4 564
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 260
ADDP4
INDIRP4
ASGNP4
line 185
;184:
;185:	VectorCopy( spot->s.angles, angles );
ADDRFP4 12
INDIRP4
ADDRLP4 528
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 186
;186:	VectorCopy( spot->s.origin, origin );
ADDRFP4 8
INDIRP4
ADDRLP4 528
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 187
;187:	origin[2] += 9.0f;
ADDRLP4 576
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 576
INDIRP4
ADDRLP4 576
INDIRP4
INDIRF4
CNSTF4 1091567616
ADDF4
ASGNF4
line 189
;188:
;189:	return spot;
ADDRLP4 528
INDIRP4
RETP4
LABELV $80
endproc SelectRandomFurthestSpawnPoint 596 4
export SelectSpawnPoint
proc SelectSpawnPoint 4 16
line 200
;190:}
;191:
;192:
;193:/*
;194:===========
;195:SelectSpawnPoint
;196:
;197:Chooses a player start, deathmatch start, etc
;198:============
;199:*/
;200:gentity_t *SelectSpawnPoint( gentity_t *ent, vec3_t avoidPoint, vec3_t origin, vec3_t angles ) {
line 201
;201:	return SelectRandomFurthestSpawnPoint( ent, avoidPoint, origin, angles );
ADDRFP4 0
INDIRP4
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
ADDRLP4 0
ADDRGP4 SelectRandomFurthestSpawnPoint
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
RETP4
LABELV $127
endproc SelectSpawnPoint 4 16
export SelectInitialSpawnPoint
proc SelectInitialSpawnPoint 20 16
line 213
;202:}
;203:
;204:
;205:/*
;206:===========
;207:SelectInitialSpawnPoint
;208:
;209:Try to find a spawn point marked 'initial', otherwise
;210:use normal spawn selection.
;211:============
;212:*/
;213:gentity_t *SelectInitialSpawnPoint( gentity_t *ent, vec3_t origin, vec3_t angles ) {
line 217
;214:	gentity_t	*spot;
;215:	int n;
;216:
;217:	spot = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 219
;218:
;219:	for ( n = 0; n < level.numSpawnSpotsFFA; n++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $132
JUMPV
LABELV $129
line 220
;220:		spot = level.spawnSpots[ n ];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+5604
ADDP4
INDIRP4
ASGNP4
line 221
;221:		if ( spot->fteam != TEAM_FREE )
ADDRLP4 0
INDIRP4
CNSTI4 816
ADDP4
INDIRI4
CNSTI4 0
EQI4 $135
line 222
;222:			continue;
ADDRGP4 $130
JUMPV
LABELV $135
line 223
;223:		if ( spot->spawnflags & 1 )
ADDRLP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $137
line 224
;224:			break;
ADDRGP4 $131
JUMPV
LABELV $137
line 226
;225:		else
;226:			spot = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 227
;227:	}
LABELV $130
line 219
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $132
ADDRLP4 4
INDIRI4
ADDRGP4 level+9708
INDIRI4
LTI4 $129
LABELV $131
line 229
;228:
;229:	if ( !spot || SpotWouldTelefrag( spot ) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $141
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 SpotWouldTelefrag
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $139
LABELV $141
line 230
;230:		return SelectSpawnPoint( ent, vec3_origin, origin, angles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 vec3_origin
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 SelectSpawnPoint
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
RETP4
ADDRGP4 $128
JUMPV
LABELV $139
line 233
;231:	}
;232:
;233:	VectorCopy( spot->s.angles, angles );
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 234
;234:	VectorCopy( spot->s.origin, origin );
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 235
;235:	origin[2] += 9.0f;
ADDRLP4 16
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRF4
CNSTF4 1091567616
ADDF4
ASGNF4
line 237
;236:
;237:	return spot;
ADDRLP4 0
INDIRP4
RETP4
LABELV $128
endproc SelectInitialSpawnPoint 20 16
export SelectSpectatorSpawnPoint
proc SelectSpectatorSpawnPoint 0 0
line 247
;238:}
;239:
;240:
;241:/*
;242:===========
;243:SelectSpectatorSpawnPoint
;244:
;245:============
;246:*/
;247:gentity_t *SelectSpectatorSpawnPoint( vec3_t origin, vec3_t angles ) {
line 248
;248:	FindIntermissionPoint();
ADDRGP4 FindIntermissionPoint
CALLV
pop
line 250
;249:
;250:	VectorCopy( level.intermission_origin, origin );
ADDRFP4 0
INDIRP4
ADDRGP4 level+5528
INDIRB
ASGNB 12
line 251
;251:	VectorCopy( level.intermission_angle, angles );
ADDRFP4 4
INDIRP4
ADDRGP4 level+5540
INDIRB
ASGNB 12
line 253
;252:
;253:	return level.spawnSpots[ SPAWN_SPOT_INTERMISSION ]; // was NULL
ADDRGP4 level+5604+4092
INDIRP4
RETP4
LABELV $142
endproc SelectSpectatorSpawnPoint 0 0
export InitBodyQue
proc InitBodyQue 12 0
line 270
;254:}
;255:
;256:
;257:/*
;258:=======================================================================
;259:
;260:BODYQUE
;261:
;262:=======================================================================
;263:*/
;264:
;265:/*
;266:===============
;267:InitBodyQue
;268:===============
;269:*/
;270:void InitBodyQue (void) {
line 274
;271:	int		i;
;272:	gentity_t	*ent;
;273:
;274:	level.bodyQueIndex = 0;
ADDRGP4 level+5564
CNSTI4 0
ASGNI4
line 275
;275:	for (i=0; i<BODY_QUEUE_SIZE ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $149
line 276
;276:		ent = G_Spawn();
ADDRLP4 8
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 277
;277:		ent->classname = "bodyque";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $153
ASGNP4
line 278
;278:		ent->neverFree = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 1
ASGNI4
line 279
;279:		level.bodyQue[i] = ent;
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+5568
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 280
;280:	}
LABELV $150
line 275
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 8
LTI4 $149
line 281
;281:}
LABELV $147
endproc InitBodyQue 12 0
export BodySink
proc BodySink 4 4
line 290
;282:
;283:/*
;284:=============
;285:BodySink
;286:
;287:After sitting around for five seconds, fall into the ground and dissapear
;288:=============
;289:*/
;290:void BodySink( gentity_t *ent ) {
line 291
;291:	if ( level.time - ent->timestamp > 6500 ) {
ADDRGP4 level+32
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
SUBI4
CNSTI4 6500
LEI4 $156
line 293
;292:		// the body ques are never actually freed, they are just unlinked
;293:		trap_UnlinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 294
;294:		ent->physicsObject = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
CNSTI4 0
ASGNI4
line 295
;295:		return;	
ADDRGP4 $155
JUMPV
LABELV $156
line 297
;296:	}
;297:	ent->nextthink = level.time + FRAMETIME;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 298
;298:	ent->s.pos.trBase[2] -= 1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 299
;299:}
LABELV $155
endproc BodySink 4 4
export CopyToBodyQue
proc CopyToBodyQue 56 8
line 310
;300:
;301:
;302:/*
;303:=============
;304:CopyToBodyQue
;305:
;306:A player is respawning, so make an entity that looks
;307:just like the existing corpse to leave behind.
;308:=============
;309:*/
;310:void CopyToBodyQue( gentity_t *ent ) {
line 316
;311:	gentity_t	*e;
;312:	int i;
;313:	gentity_t		*body;
;314:	int			contents;
;315:
;316:	trap_UnlinkEntity (ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 319
;317:
;318:	// if client is in a nodrop area, don't leave the body
;319:	contents = trap_PointContents( ent->s.origin, -1 );
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 16
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 16
INDIRI4
ASGNI4
line 320
;320:	if ( contents & CONTENTS_NODROP ) {
ADDRLP4 12
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
EQU4 $161
line 321
;321:		return;
ADDRGP4 $160
JUMPV
LABELV $161
line 325
;322:	}
;323:
;324:	// grab a body que and cycle to the next one
;325:	body = level.bodyQue[ level.bodyQueIndex ];
ADDRLP4 0
ADDRGP4 level+5564
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+5568
ADDP4
INDIRP4
ASGNP4
line 326
;326:	level.bodyQueIndex = (level.bodyQueIndex + 1) % BODY_QUEUE_SIZE;
ADDRGP4 level+5564
ADDRGP4 level+5564
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 8
MODI4
ASGNI4
line 328
;327:
;328:	trap_UnlinkEntity (body);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 330
;329:
;330:	body->s = ent->s;
ADDRLP4 0
INDIRP4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 208
line 331
;331:	body->s.eFlags = EF_DEAD;		// clear EF_TALK, etc
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 1
ASGNI4
line 333
;332:
;333:	if ( ent->s.eFlags & EF_KAMIKAZE ) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $167
line 334
;334:		body->s.eFlags |= EF_KAMIKAZE;
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 337
;335:
;336:		// check if there is a kamikaze timer around for this owner
;337:		for (i = 0; i < level.num_entities; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $172
JUMPV
LABELV $169
line 338
;338:			e = &g_entities[i];
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 339
;339:			if (!e->inuse)
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $174
line 340
;340:				continue;
ADDRGP4 $170
JUMPV
LABELV $174
line 341
;341:			if (e->activator != ent)
ADDRLP4 4
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $176
line 342
;342:				continue;
ADDRGP4 $170
JUMPV
LABELV $176
line 343
;343:			if (strcmp(e->classname, "kamikaze timer"))
ADDRLP4 4
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $180
ARGP4
ADDRLP4 24
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $178
line 344
;344:				continue;
ADDRGP4 $170
JUMPV
LABELV $178
line 345
;345:			e->activator = body;
ADDRLP4 4
INDIRP4
CNSTI4 772
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 346
;346:			break;
ADDRGP4 $171
JUMPV
LABELV $170
line 337
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $172
ADDRLP4 8
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $169
LABELV $171
line 348
;347:		}
;348:	}
LABELV $167
line 350
;349:
;350:	body->s.powerups = 0;	// clear powerups
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 351
;351:	body->s.loopSound = 0;	// clear lava burning
ADDRLP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 352
;352:	body->s.number = body - g_entities;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 824
DIVI4
ASGNI4
line 353
;353:	body->timestamp = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 640
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 354
;354:	body->physicsObject = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 564
ADDP4
CNSTI4 1
ASGNI4
line 355
;355:	body->physicsBounce = 0;		// don't bounce
ADDRLP4 0
INDIRP4
CNSTI4 568
ADDP4
CNSTF4 0
ASGNF4
line 356
;356:	if ( body->s.groundEntityNum == ENTITYNUM_NONE ) {
ADDRLP4 0
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $182
line 357
;357:		body->s.pos.trType = TR_GRAVITY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 5
ASGNI4
line 358
;358:		body->s.pos.trTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 359
;359:		VectorCopy( ent->client->ps.velocity, body->s.pos.trDelta );
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRB
ASGNB 12
line 360
;360:	} else {
ADDRGP4 $183
JUMPV
LABELV $182
line 361
;361:		body->s.pos.trType = TR_STATIONARY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 362
;362:	}
LABELV $183
line 363
;363:	body->s.event = 0;
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTI4 0
ASGNI4
line 367
;364:
;365:	// change the animation to the last-frame only, so the sequence
;366:	// doesn't repeat anew for the body
;367:	switch ( body->s.legsAnim & ~ANIM_TOGGLEBIT ) {
ADDRLP4 24
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
LTI4 $185
ADDRLP4 24
INDIRI4
CNSTI4 5
GTI4 $185
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $191
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $191
address $188
address $188
address $189
address $189
address $190
address $190
code
LABELV $188
line 370
;368:	case BOTH_DEATH1:
;369:	case BOTH_DEAD1:
;370:		body->s.torsoAnim = body->s.legsAnim = BOTH_DEAD1;
ADDRLP4 36
CNSTI4 1
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 371
;371:		break;
ADDRGP4 $186
JUMPV
LABELV $189
line 374
;372:	case BOTH_DEATH2:
;373:	case BOTH_DEAD2:
;374:		body->s.torsoAnim = body->s.legsAnim = BOTH_DEAD2;
ADDRLP4 44
CNSTI4 3
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 375
;375:		break;
ADDRGP4 $186
JUMPV
LABELV $190
LABELV $185
line 379
;376:	case BOTH_DEATH3:
;377:	case BOTH_DEAD3:
;378:	default:
;379:		body->s.torsoAnim = body->s.legsAnim = BOTH_DEAD3;
ADDRLP4 52
CNSTI4 5
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 52
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 52
INDIRI4
ASGNI4
line 380
;380:		break;
LABELV $186
line 383
;381:	}
;382:
;383:	body->r.svFlags = ent->r.svFlags;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
ASGNI4
line 384
;384:	VectorCopy (ent->r.mins, body->r.mins);
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
INDIRB
ASGNB 12
line 385
;385:	VectorCopy (ent->r.maxs, body->r.maxs);
ADDRLP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRB
ASGNB 12
line 386
;386:	VectorCopy (ent->r.absmin, body->r.absmin);
ADDRLP4 0
INDIRP4
CNSTI4 464
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
INDIRB
ASGNB 12
line 387
;387:	VectorCopy (ent->r.absmax, body->r.absmax);
ADDRLP4 0
INDIRP4
CNSTI4 476
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 476
ADDP4
INDIRB
ASGNB 12
line 389
;388:
;389:	body->clipmask = CONTENTS_SOLID | CONTENTS_PLAYERCLIP;
ADDRLP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 65537
ASGNI4
line 390
;390:	body->r.contents = CONTENTS_CORPSE;
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 67108864
ASGNI4
line 391
;391:	body->r.ownerNum = ent->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 393
;392:
;393:	body->nextthink = level.time + 5000;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 394
;394:	body->think = BodySink;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 BodySink
ASGNP4
line 396
;395:
;396:	body->die = body_die;
ADDRLP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 body_die
ASGNP4
line 399
;397:
;398:	// don't take more damage if already gibbed
;399:	if ( ent->health <= GIB_HEALTH ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 -40
GTI4 $193
line 400
;400:		body->takedamage = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 0
ASGNI4
line 401
;401:	} else {
ADDRGP4 $194
JUMPV
LABELV $193
line 402
;402:		body->takedamage = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 403
;403:	}
LABELV $194
line 405
;404:
;405:	VectorCopy ( body->s.pos.trBase, body->r.currentOrigin );
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 406
;406:	trap_LinkEntity( body );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 407
;407:}
LABELV $160
endproc CopyToBodyQue 56 8
export SetClientViewAngle
proc SetClientViewAngle 20 0
line 417
;408:
;409:
;410://======================================================================
;411:
;412:/*
;413:==================
;414:SetClientViewAngle
;415:==================
;416:*/
;417:void SetClientViewAngle( gentity_t *ent, vec3_t angle ) {
line 421
;418:	int	i, cmdAngle;
;419:	gclient_t	*client;
;420:
;421:	client = ent->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 424
;422:
;423:	// set the delta angle
;424:	for (i = 0 ; i < 3 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $196
line 425
;425:		cmdAngle = ANGLE2SHORT(angle[i]);
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
CNSTF4 1127615329
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
ASGNI4
line 426
;426:		client->ps.delta_angles[i] = cmdAngle - client->pers.cmd.angles[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 56
ADDP4
ADDP4
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRI4
SUBI4
ASGNI4
line 427
;427:	}
LABELV $197
line 424
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $196
line 428
;428:	VectorCopy( angle, ent->s.angles );
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 429
;429:	VectorCopy( ent->s.angles, client->ps.viewangles );
ADDRLP4 4
INDIRP4
CNSTI4 152
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 430
;430:}
LABELV $195
endproc SetClientViewAngle 20 0
export respawn
proc respawn 8 8
line 438
;431:
;432:
;433:/*
;434:================
;435:respawn
;436:================
;437:*/
;438:void respawn( gentity_t *ent ) {
line 441
;439:	gentity_t	*tent;
;440:
;441:	if ( ent->health <= 0 )
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
GTI4 $201
line 442
;442:		CopyToBodyQue( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CopyToBodyQue
CALLV
pop
LABELV $201
line 444
;443:
;444:	ClientSpawn( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ClientSpawn
CALLV
pop
line 447
;445:
;446:	// bots doesn't need to see any effects
;447:	if ( level.intermissiontime && ent->r.svFlags & SVF_BOT )
ADDRGP4 level+5516
INDIRI4
CNSTI4 0
EQI4 $203
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $203
line 448
;448:		return;
ADDRGP4 $200
JUMPV
LABELV $203
line 451
;449:
;450:	// add a teleportation effect
;451:	tent = G_TempEntity( ent->client->ps.origin, EV_PLAYER_TELEPORT_IN );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 42
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 452
;452:	tent->s.clientNum = ent->s.clientNum;
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 455
;453:
;454:	// optimize bandwidth
;455:	if ( level.intermissiontime ) {
ADDRGP4 level+5516
INDIRI4
CNSTI4 0
EQI4 $206
line 456
;456:		tent->r.svFlags = SVF_SINGLECLIENT;
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
CNSTI4 256
ASGNI4
line 457
;457:		tent->r.singleClient = ent->s.clientNum;
ADDRLP4 0
INDIRP4
CNSTI4 428
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 458
;458:	}
LABELV $206
line 459
;459:}
LABELV $200
endproc respawn 8 8
export TeamCount
proc TeamCount 8 0
line 469
;460:
;461:
;462:/*
;463:================
;464:TeamCount
;465:
;466:Returns number of players on a team
;467:================
;468:*/
;469:int TeamCount( int ignoreClientNum, team_t team ) {
line 471
;470:	int		i;
;471:	int		count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 473
;472:
;473:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $213
JUMPV
LABELV $210
line 474
;474:		if ( i == ignoreClientNum ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $215
line 475
;475:			continue;
ADDRGP4 $211
JUMPV
LABELV $215
line 477
;476:		}
;477:		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
ADDRLP4 0
INDIRI4
CNSTI4 1632
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $217
line 478
;478:			continue;
ADDRGP4 $211
JUMPV
LABELV $217
line 480
;479:		}
;480:		if ( level.clients[i].sess.sessionTeam == team ) {
ADDRLP4 0
INDIRI4
CNSTI4 1632
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $219
line 481
;481:			count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 482
;482:		}
LABELV $219
line 483
;483:	}
LABELV $211
line 473
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $213
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $210
line 485
;484:
;485:	return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $209
endproc TeamCount 8 0
export TeamConnectedCount
proc TeamConnectedCount 8 0
line 496
;486:}
;487:
;488:
;489:/*
;490:================
;491:TeamConnectedCount
;492:
;493:Returns number of active players on a team
;494:================
;495:*/
;496:int TeamConnectedCount( int ignoreClientNum, team_t team ) {
line 498
;497:	int		i;
;498:	int		count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 500
;499:
;500:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $225
JUMPV
LABELV $222
line 501
;501:		if ( i == ignoreClientNum ) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $227
line 502
;502:			continue;
ADDRGP4 $223
JUMPV
LABELV $227
line 504
;503:		}
;504:		if ( level.clients[i].pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRI4
CNSTI4 1632
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $229
line 505
;505:			continue;
ADDRGP4 $223
JUMPV
LABELV $229
line 507
;506:		}
;507:		if ( level.clients[i].sess.sessionTeam == team ) {
ADDRLP4 0
INDIRI4
CNSTI4 1632
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $231
line 508
;508:			count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 509
;509:		}
LABELV $231
line 510
;510:	}
LABELV $223
line 500
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $225
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $222
line 512
;511:
;512:	return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $221
endproc TeamConnectedCount 8 0
export TeamLeader
proc TeamLeader 4 0
line 523
;513:}
;514:
;515:
;516:/*
;517:================
;518:TeamLeader
;519:
;520:Returns the client number of the team leader
;521:================
;522:*/
;523:int TeamLeader( team_t team ) {
line 526
;524:	int		i;
;525:
;526:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $237
JUMPV
LABELV $234
line 527
;527:		if ( level.clients[i].pers.connected == CON_DISCONNECTED ) {
ADDRLP4 0
INDIRI4
CNSTI4 1632
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $239
line 528
;528:			continue;
ADDRGP4 $235
JUMPV
LABELV $239
line 530
;529:		}
;530:		if ( level.clients[i].sess.sessionTeam == team ) {
ADDRLP4 0
INDIRI4
CNSTI4 1632
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $241
line 531
;531:			if ( level.clients[i].sess.teamLeader )
ADDRLP4 0
INDIRI4
CNSTI4 1632
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 640
ADDP4
INDIRI4
CNSTI4 0
EQI4 $243
line 532
;532:				return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $233
JUMPV
LABELV $243
line 533
;533:		}
LABELV $241
line 534
;534:	}
LABELV $235
line 526
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $237
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $234
line 536
;535:
;536:	return -1;
CNSTI4 -1
RETI4
LABELV $233
endproc TeamLeader 4 0
export PickTeam
proc PickTeam 24 8
line 545
;537:}
;538:
;539:
;540:/*
;541:================
;542:PickTeam
;543:================
;544:*/
;545:team_t PickTeam( int ignoreClientNum ) {
line 548
;546:	int		counts[TEAM_NUM_TEAMS];
;547:
;548:	counts[TEAM_BLUE] = TeamCount( ignoreClientNum, TEAM_BLUE );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 16
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 16
INDIRI4
ASGNI4
line 549
;549:	counts[TEAM_RED] = TeamCount( ignoreClientNum, TEAM_RED );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 20
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 0+4
ADDRLP4 20
INDIRI4
ASGNI4
line 551
;550:
;551:	if ( counts[TEAM_BLUE] > counts[TEAM_RED] ) {
ADDRLP4 0+8
INDIRI4
ADDRLP4 0+4
INDIRI4
LEI4 $248
line 552
;552:		return TEAM_RED;
CNSTI4 1
RETI4
ADDRGP4 $245
JUMPV
LABELV $248
line 554
;553:	}
;554:	if ( counts[TEAM_RED] > counts[TEAM_BLUE] ) {
ADDRLP4 0+4
INDIRI4
ADDRLP4 0+8
INDIRI4
LEI4 $252
line 555
;555:		return TEAM_BLUE;
CNSTI4 2
RETI4
ADDRGP4 $245
JUMPV
LABELV $252
line 558
;556:	}
;557:	// equal team count, so join the team with the lowest score
;558:	if ( level.teamScores[TEAM_BLUE] > level.teamScores[TEAM_RED] ) {
ADDRGP4 level+48+8
INDIRI4
ADDRGP4 level+48+4
INDIRI4
LEI4 $256
line 559
;559:		return TEAM_RED;
CNSTI4 1
RETI4
ADDRGP4 $245
JUMPV
LABELV $256
line 561
;560:	}
;561:	return TEAM_BLUE;
CNSTI4 2
RETI4
LABELV $245
endproc PickTeam 24 8
export ClientUserinfoChanged
proc ClientUserinfoChanged 1292 52
line 578
;562:}
;563:
;564:
;565:/*
;566:===========
;567:ClientUserInfoChanged
;568:
;569:Called from ClientConnect when the player first connects and
;570:directly by the server system when the player updates a userinfo variable.
;571:
;572:The game can override any of the settings and call trap_SetUserinfo
;573:if desired.
;574:
;575:returns qfalse in case of invalid userinfo
;576:============
;577:*/
;578:qboolean ClientUserinfoChanged( int clientNum ) {
line 590
;579:	gentity_t *ent;
;580:	int		teamTask, teamLeader, health;
;581:	char	*s;
;582:	char	model[MAX_QPATH];
;583:	char	headModel[MAX_QPATH];
;584:	char	oldname[MAX_NETNAME];
;585:	gclient_t	*client;
;586:	char	c1[8];
;587:	char	c2[8];
;588:	char	userinfo[MAX_INFO_STRING];
;589:
;590:	ent = g_entities + clientNum;
ADDRLP4 1032
ADDRFP4 0
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 591
;591:	client = ent->client;
ADDRLP4 0
ADDRLP4 1032
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 593
;592:
;593:	trap_GetUserinfo( clientNum, userinfo, sizeof( userinfo ) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 596
;594:
;595:	// check for malformed or illegal info strings
;596:	if ( !Info_Validate( userinfo ) ) {
ADDRLP4 4
ARGP4
ADDRLP4 1228
ADDRGP4 Info_Validate
CALLI4
ASGNI4
ADDRLP4 1228
INDIRI4
CNSTI4 0
NEI4 $263
line 597
;597:		Q_strcpy( ban_reason, "bad userinfo" );
ADDRGP4 ban_reason
ARGP4
ADDRGP4 $265
ARGP4
ADDRGP4 Q_strcpy
CALLV
pop
line 598
;598:		if ( client && client->pers.connected != CON_DISCONNECTED )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $266
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
EQI4 $266
line 599
;599:			trap_DropClient( clientNum, ban_reason );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 ban_reason
ARGP4
ADDRGP4 trap_DropClient
CALLV
pop
LABELV $266
line 600
;600:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $262
JUMPV
LABELV $263
line 603
;601:	}
;602:
;603:	if ( client->pers.connected == CON_DISCONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $268
line 606
;604:		// we just checked if connecting player can join server
;605:		// so quit now as some important data like player team is still not set
;606:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $262
JUMPV
LABELV $268
line 610
;607:	}
;608:
;609:	// check for local client
;610:	s = Info_ValueForKey( userinfo, "ip" );
ADDRLP4 4
ARGP4
ADDRGP4 $270
ARGP4
ADDRLP4 1232
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1232
INDIRP4
ASGNP4
line 611
;611:	if ( !strcmp( s, "localhost" ) ) {
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 $273
ARGP4
ADDRLP4 1236
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1236
INDIRI4
CNSTI4 0
NEI4 $271
line 612
;612:		client->pers.localClient = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
CNSTI4 1
ASGNI4
line 613
;613:	} else {
ADDRGP4 $272
JUMPV
LABELV $271
line 614
;614:		client->pers.localClient = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
CNSTI4 0
ASGNI4
line 615
;615:	}
LABELV $272
line 618
;616:
;617:	// check the item prediction
;618:	s = Info_ValueForKey( userinfo, "cg_predictItems" );
ADDRLP4 4
ARGP4
ADDRGP4 $274
ARGP4
ADDRLP4 1240
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1240
INDIRP4
ASGNP4
line 619
;619:	if ( !atoi( s ) ) {
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 1244
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1244
INDIRI4
CNSTI4 0
NEI4 $275
line 620
;620:		client->pers.predictItemPickup = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
CNSTI4 0
ASGNI4
line 621
;621:	} else {
ADDRGP4 $276
JUMPV
LABELV $275
line 622
;622:		client->pers.predictItemPickup = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
CNSTI4 1
ASGNI4
line 623
;623:	}
LABELV $276
line 626
;624:
;625:	// set name
;626:	Q_strncpyz( oldname, client->pers.netname, sizeof( oldname ) );
ADDRLP4 1180
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 627
;627:	s = Info_ValueForKey( userinfo, "name" );
ADDRLP4 4
ARGP4
ADDRGP4 $277
ARGP4
ADDRLP4 1248
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1248
INDIRP4
ASGNP4
line 628
;628:	BG_CleanName( s, client->pers.netname, sizeof( client->pers.netname ), "UnnamedPlayer" );
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 $278
ARGP4
ADDRGP4 BG_CleanName
CALLV
pop
line 630
;629:
;630:	if ( client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
NEI4 $279
line 631
;631:		if ( client->sess.spectatorState == SPECTATOR_SCOREBOARD ) {
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
NEI4 $281
line 632
;632:			Q_strncpyz( client->pers.netname, "scoreboard", sizeof(client->pers.netname) );
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRGP4 $283
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 633
;633:		}
LABELV $281
line 634
;634:	}
LABELV $279
line 636
;635:
;636:	if ( client->pers.connected == CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $284
line 637
;637:		if ( strcmp( oldname, client->pers.netname ) ) {
ADDRLP4 1180
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 1252
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1252
INDIRI4
CNSTI4 0
EQI4 $286
line 638
;638:			G_BroadcastServerCommand( -1, va("print \"%s" S_COLOR_WHITE " renamed to %s\n\"", oldname, client->pers.netname) );
ADDRGP4 $288
ARGP4
ADDRLP4 1180
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 1256
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 1256
INDIRP4
ARGP4
ADDRGP4 G_BroadcastServerCommand
CALLV
pop
line 639
;639:		}
LABELV $286
line 640
;640:	}
LABELV $284
line 643
;641:
;642:	// set max health
;643:	if (client->ps.powerups[PW_GUARD]) {
ADDRLP4 0
INDIRP4
CNSTI4 356
ADDP4
INDIRI4
CNSTI4 0
EQI4 $289
line 644
;644:		client->pers.maxHealth = HEALTH_SOFT_LIMIT*2;
ADDRLP4 0
INDIRP4
CNSTI4 544
ADDP4
CNSTI4 200
ASGNI4
line 645
;645:	} else {
ADDRGP4 $290
JUMPV
LABELV $289
line 646
;646:		health = atoi( Info_ValueForKey( userinfo, "handicap" ) );
ADDRLP4 4
ARGP4
ADDRGP4 $291
ARGP4
ADDRLP4 1252
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1252
INDIRP4
ARGP4
ADDRLP4 1256
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1224
ADDRLP4 1256
INDIRI4
ASGNI4
line 647
;647:		client->pers.maxHealth = health;
ADDRLP4 0
INDIRP4
CNSTI4 544
ADDP4
ADDRLP4 1224
INDIRI4
ASGNI4
line 648
;648:		if ( client->pers.maxHealth < 1 || client->pers.maxHealth > HEALTH_SOFT_LIMIT ) {
ADDRLP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 1
LTI4 $294
ADDRLP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 100
LEI4 $292
LABELV $294
line 649
;649:			client->pers.maxHealth = HEALTH_SOFT_LIMIT;
ADDRLP4 0
INDIRP4
CNSTI4 544
ADDP4
CNSTI4 100
ASGNI4
line 650
;650:		}
LABELV $292
line 651
;651:	}
LABELV $290
line 653
;652:
;653:	client->ps.stats[STAT_MAX_HEALTH] = client->pers.maxHealth;
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ASGNI4
line 655
;654:
;655:	if (g_gametype.integer >= GT_TEAM) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $295
line 656
;656:		client->pers.teamInfo = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
CNSTI4 1
ASGNI4
line 657
;657:	} else {
ADDRGP4 $296
JUMPV
LABELV $295
line 658
;658:		s = Info_ValueForKey( userinfo, "teamoverlay" );
ADDRLP4 4
ARGP4
ADDRGP4 $298
ARGP4
ADDRLP4 1256
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1256
INDIRP4
ASGNP4
line 659
;659:		if ( ! *s || atoi( s ) != 0 ) {
ADDRLP4 1028
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $301
ADDRLP4 1028
INDIRP4
ARGP4
ADDRLP4 1264
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1264
INDIRI4
CNSTI4 0
EQI4 $299
LABELV $301
line 660
;660:			client->pers.teamInfo = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
CNSTI4 1
ASGNI4
line 661
;661:		} else {
ADDRGP4 $300
JUMPV
LABELV $299
line 662
;662:			client->pers.teamInfo = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 604
ADDP4
CNSTI4 0
ASGNI4
line 663
;663:		}
LABELV $300
line 664
;664:	}
LABELV $296
line 667
;665:
;666:	// set model
;667:	Q_strncpyz( model, Info_ValueForKey( userinfo, "model" ), sizeof( model ) );
ADDRLP4 4
ARGP4
ADDRGP4 $302
ARGP4
ADDRLP4 1256
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1036
ARGP4
ADDRLP4 1256
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 668
;668:	Q_strncpyz( headModel, Info_ValueForKey( userinfo, "headmodel" ), sizeof( headModel ) );
ADDRLP4 4
ARGP4
ADDRGP4 $303
ARGP4
ADDRLP4 1260
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1100
ARGP4
ADDRLP4 1260
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 671
;669:
;670:	// team task (0 = none, 1 = offence, 2 = defence)
;671:	teamTask = atoi(Info_ValueForKey(userinfo, "teamtask"));
ADDRLP4 4
ARGP4
ADDRGP4 $304
ARGP4
ADDRLP4 1264
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1264
INDIRP4
ARGP4
ADDRLP4 1268
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1216
ADDRLP4 1268
INDIRI4
ASGNI4
line 673
;672:	// team Leader (1 = leader, 0 is normal player)
;673:	teamLeader = client->sess.teamLeader;
ADDRLP4 1220
ADDRLP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
ASGNI4
line 676
;674:
;675:	// colors
;676:	Q_strncpyz( c1, Info_ValueForKey( userinfo, "color1" ), sizeof( c1 ) );
ADDRLP4 4
ARGP4
ADDRGP4 $305
ARGP4
ADDRLP4 1272
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1164
ARGP4
ADDRLP4 1272
INDIRP4
ARGP4
CNSTI4 8
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 677
;677:	Q_strncpyz( c2, Info_ValueForKey( userinfo, "color2" ), sizeof( c2 ) );
ADDRLP4 4
ARGP4
ADDRGP4 $306
ARGP4
ADDRLP4 1276
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1172
ARGP4
ADDRLP4 1276
INDIRP4
ARGP4
CNSTI4 8
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 681
;678:
;679:	// send over a subset of the userinfo keys so other clients can
;680:	// print scoreboards, display models, and play custom sounds
;681:	if ( ent->r.svFlags & SVF_BOT ) {
ADDRLP4 1032
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $307
line 682
;682:		s = va("n\\%s\\t\\%i\\model\\%s\\hmodel\\%s\\c1\\%s\\c2\\%s\\hc\\%i\\w\\%i\\l\\%i\\skill\\%s\\tt\\%d\\tl\\%d",
ADDRLP4 4
ARGP4
ADDRGP4 $310
ARGP4
ADDRLP4 1280
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $309
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
ARGI4
ADDRLP4 1036
ARGP4
ADDRLP4 1100
ARGP4
ADDRLP4 1164
ARGP4
ADDRLP4 1172
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 632
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRI4
ARGI4
ADDRLP4 1280
INDIRP4
ARGP4
ADDRLP4 1216
INDIRI4
ARGI4
ADDRLP4 1220
INDIRI4
ARGI4
ADDRLP4 1288
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1288
INDIRP4
ASGNP4
line 686
;683:			client->pers.netname, client->sess.sessionTeam, model, headModel, c1, c2,
;684:			client->pers.maxHealth, client->sess.wins, client->sess.losses,
;685:			Info_ValueForKey( userinfo, "skill" ), teamTask, teamLeader );
;686:	} else {
ADDRGP4 $308
JUMPV
LABELV $307
line 687
;687:		s = va("n\\%s\\t\\%i\\model\\%s\\hmodel\\%s\\c1\\%s\\c2\\%s\\hc\\%i\\w\\%i\\l\\%i\\tt\\%d\\tl\\%d",
ADDRGP4 $311
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
ARGI4
ADDRLP4 1036
ARGP4
ADDRLP4 1100
ARGP4
ADDRLP4 1164
ARGP4
ADDRLP4 1172
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 632
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 636
ADDP4
INDIRI4
ARGI4
ADDRLP4 1216
INDIRI4
ARGI4
ADDRLP4 1220
INDIRI4
ARGI4
ADDRLP4 1284
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1284
INDIRP4
ASGNP4
line 690
;688:			client->pers.netname, client->sess.sessionTeam, model, headModel, c1, c2, 
;689:			client->pers.maxHealth, client->sess.wins, client->sess.losses, teamTask, teamLeader );
;690:	}
LABELV $308
line 692
;691:
;692:	trap_SetConfigstring( CS_PLAYERS+clientNum, s );
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 695
;693:
;694:	// this is not the userinfo, more like the configstring actually
;695:	G_LogPrintf( "ClientUserinfoChanged: %i %s\n", clientNum, s );
ADDRGP4 $312
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 697
;696:
;697:	return qtrue;
CNSTI4 1
RETI4
LABELV $262
endproc ClientUserinfoChanged 1292 52
export ClientConnect
proc ClientConnect 1072 12
line 721
;698:}
;699:
;700:
;701:/*
;702:===========
;703:ClientConnect
;704:
;705:Called when a player begins connecting to the server.
;706:Called again for every map change or tournement restart.
;707:
;708:The session information will be valid after exit.
;709:
;710:Return NULL if the client should be allowed, otherwise return
;711:a string with the reason for denial.
;712:
;713:Otherwise, the client will be sent the current gamestate
;714:and will eventually get to ClientBegin.
;715:
;716:firstTime will be qtrue the very first time a client connects
;717:to the server machine, but qfalse on map changes and tournement
;718:restarts.
;719:============
;720:*/
;721:const char *ClientConnect( int clientNum, qboolean firstTime, qboolean isBot ) {
line 729
;722:	char		*value;
;723://	char		*areabits;
;724:	gclient_t	*client;
;725:	char		userinfo[MAX_INFO_STRING];
;726:	gentity_t	*ent;
;727:	qboolean	isAdmin;
;728:
;729:	if ( clientNum >= level.maxclients ) {
ADDRFP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $314
line 730
;730:		return "Bad connection slot.";
ADDRGP4 $317
RETP4
ADDRGP4 $313
JUMPV
LABELV $314
line 733
;731:	}
;732:
;733:	ent = &g_entities[ clientNum ];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 734
;734:	ent->client = level.clients + clientNum;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
ADDRFP4 0
INDIRI4
CNSTI4 1632
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 736
;735:
;736:	if ( firstTime ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $318
line 739
;737:		// cleanup previous data manually
;738:		// because client may silently (re)connect without ClientDisconnect in case of crash for example
;739:		if ( level.clients[ clientNum ].pers.connected != CON_DISCONNECTED )
ADDRFP4 0
INDIRI4
CNSTI4 1632
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
EQI4 $320
line 740
;740:			ClientDisconnect( clientNum );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 ClientDisconnect
CALLV
pop
LABELV $320
line 743
;741:
;742:		// remove old entity from the world
;743:		trap_UnlinkEntity( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 744
;744:		ent->r.contents = 0;
ADDRLP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 745
;745:		ent->s.eType = ET_INVISIBLE;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 10
ASGNI4
line 746
;746:		ent->s.eFlags = 0;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 0
ASGNI4
line 747
;747:		ent->s.modelindex = 0;
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 0
ASGNI4
line 748
;748:		ent->s.clientNum = clientNum;
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 749
;749:		ent->s.number = clientNum;
ADDRLP4 0
INDIRP4
ADDRFP4 0
INDIRI4
ASGNI4
line 750
;750:		ent->takedamage = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 0
ASGNI4
line 751
;751:	}
LABELV $318
line 753
;752:
;753:	ent->r.svFlags &= ~SVF_BOT;
ADDRLP4 1040
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 1040
INDIRP4
ADDRLP4 1040
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 754
;754:	ent->inuse = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
CNSTI4 0
ASGNI4
line 756
;755:
;756:	trap_GetUserinfo( clientNum, userinfo, sizeof( userinfo ) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 762
;757:
;758: 	// IP filtering
;759: 	// https://zerowing.idsoftware.com/bugzilla/show_bug.cgi?id=500
;760: 	// recommanding PB based IP / GUID banning, the builtin system is pretty limited
;761: 	// check to see if they are on the banned IP list
;762:	value = Info_ValueForKey( userinfo, "ip" );
ADDRLP4 12
ARGP4
ADDRGP4 $270
ARGP4
ADDRLP4 1044
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 1044
INDIRP4
ASGNP4
line 764
;763:
;764:	if ( !strcmp( value, "localhost" ) && !isBot )
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $273
ARGP4
ADDRLP4 1048
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $322
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $322
line 765
;765:		isAdmin = qtrue;
ADDRLP4 1036
CNSTI4 1
ASGNI4
ADDRGP4 $323
JUMPV
LABELV $322
line 767
;766:	else
;767:		isAdmin = qfalse;
ADDRLP4 1036
CNSTI4 0
ASGNI4
LABELV $323
line 769
;768:
;769:	if ( !isAdmin && G_FilterPacket( value ) ) {
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $324
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1052
ADDRGP4 G_FilterPacket
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
EQI4 $324
line 770
;770:		return "You are banned from this server.";
ADDRGP4 $326
RETP4
ADDRGP4 $313
JUMPV
LABELV $324
line 776
;771:	}
;772:
;773:	// we don't check password for bots and local client
;774:	// NOTE: local client <-> "ip" "localhost"
;775:	// this means this client is not running in our current process
;776:	if ( !isBot && !isAdmin ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $327
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $327
line 778
;777:		// check for a password
;778:		if ( g_password.string[0] && Q_stricmp( g_password.string, "none" ) ) {
ADDRGP4 g_password+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $329
ADDRGP4 g_password+16
ARGP4
ADDRGP4 $333
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
EQI4 $329
line 779
;779:			value = Info_ValueForKey( userinfo, "password" );
ADDRLP4 12
ARGP4
ADDRGP4 $334
ARGP4
ADDRLP4 1060
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 1060
INDIRP4
ASGNP4
line 780
;780:			if ( strcmp( g_password.string, value ) )
ADDRGP4 g_password+16
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1064
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
EQI4 $335
line 781
;781:				return "Invalid password";
ADDRGP4 $338
RETP4
ADDRGP4 $313
JUMPV
LABELV $335
line 782
;782:		}
LABELV $329
line 783
;783:	}
LABELV $327
line 786
;784:
;785:	// they can connect
;786:	ent->client = level.clients + clientNum;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
ADDRFP4 0
INDIRI4
CNSTI4 1632
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 787
;787:	client = ent->client;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 790
;788:
;789://	areabits = client->areabits;
;790:	memset( client, 0, sizeof( *client ) );
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1632
ARGI4
ADDRGP4 memset
CALLP4
pop
line 792
;791:
;792:	client->ps.clientNum = clientNum;
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 794
;793:
;794:	if ( !ClientUserinfoChanged( clientNum ) ) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1056
ADDRGP4 ClientUserinfoChanged
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $339
line 795
;795:		return ban_reason;
ADDRGP4 ban_reason
RETP4
ADDRGP4 $313
JUMPV
LABELV $339
line 799
;796:	}
;797:
;798:	// read or initialize the session data
;799:	if ( firstTime || level.newSession ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $344
ADDRGP4 level+68
INDIRI4
CNSTI4 0
EQI4 $341
LABELV $344
line 800
;800:		value = Info_ValueForKey( userinfo, "team" );
ADDRLP4 12
ARGP4
ADDRGP4 $345
ARGP4
ADDRLP4 1060
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 1060
INDIRP4
ASGNP4
line 801
;801:		G_InitSessionData( client, value, isBot );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 G_InitSessionData
CALLV
pop
line 802
;802:		G_WriteClientSessionData( client );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_WriteClientSessionData
CALLV
pop
line 803
;803:	}
LABELV $341
line 805
;804:
;805:	G_ReadClientSessionData( client );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_ReadClientSessionData
CALLV
pop
line 807
;806:
;807:	if( isBot ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $346
line 808
;808:		if( !G_BotConnect( clientNum, !firstTime ) ) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $351
ADDRLP4 1060
CNSTI4 1
ASGNI4
ADDRGP4 $352
JUMPV
LABELV $351
ADDRLP4 1060
CNSTI4 0
ASGNI4
LABELV $352
ADDRLP4 1060
INDIRI4
ARGI4
ADDRLP4 1064
ADDRGP4 G_BotConnect
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $348
line 809
;809:			return "BotConnectfailed";
ADDRGP4 $353
RETP4
ADDRGP4 $313
JUMPV
LABELV $348
line 811
;810:		}
;811:		ent->r.svFlags |= SVF_BOT;
ADDRLP4 1068
ADDRLP4 0
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 1068
INDIRP4
ADDRLP4 1068
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 812
;812:		client->sess.spectatorClient = clientNum;
ADDRLP4 4
INDIRP4
CNSTI4 628
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 813
;813:	}
LABELV $346
line 814
;814:	ent->inuse = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
CNSTI4 1
ASGNI4
line 817
;815:
;816:	// get and distribute relevant paramters
;817:	G_LogPrintf( "ClientConnect: %i\n", clientNum );
ADDRGP4 $354
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 819
;818:
;819:	client->pers.connected = CON_CONNECTING;
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
CNSTI4 1
ASGNI4
line 821
;820:
;821:	ClientUserinfoChanged( clientNum );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLI4
pop
line 824
;822:
;823:	// don't do the "xxx connected" messages if they were caried over from previous level
;824:	if ( firstTime ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $355
line 825
;825:		G_BroadcastServerCommand( -1, va( "print \"%s" S_COLOR_WHITE " connected\n\"", client->pers.netname ) );
ADDRGP4 $357
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 1060
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 1060
INDIRP4
ARGP4
ADDRGP4 G_BroadcastServerCommand
CALLV
pop
line 828
;826:
;827:		// mute all prints until completely in game
;828:		client->pers.inGame = qfalse;
ADDRLP4 4
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 0
ASGNI4
line 829
;829:	} else {
ADDRGP4 $356
JUMPV
LABELV $355
line 830
;830:		client->pers.inGame = qtrue; // FIXME: read from session data?
ADDRLP4 4
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 1
ASGNI4
line 831
;831:	}
LABELV $356
line 834
;832:
;833:	// count current clients and rank for scoreboard
;834:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 841
;835:
;836:	// for statistics
;837://	client->areabits = areabits;
;838://	if ( !client->areabits )
;839://		client->areabits = G_Alloc( (trap_AAS_PointReachabilityAreaIndex( NULL ) + 7) / 8 );
;840:
;841:	return NULL;
CNSTP4 0
RETP4
LABELV $313
endproc ClientConnect 1072 12
export ClientBegin
proc ClientBegin 28 12
line 854
;842:}
;843:
;844:
;845:/*
;846:===========
;847:ClientBegin
;848:
;849:called when a client has finished connecting, and is ready
;850:to be placed into the level.  This will happen every level load,
;851:and on transition between teams, but doesn't happen on respawns
;852:============
;853:*/
;854:void ClientBegin( int clientNum ) {
line 861
;855:	gentity_t	*ent;
;856:	gclient_t	*client;
;857:	gentity_t	*tent;
;858:	int			flags;
;859:	int			spawns;
;860:
;861:	ent = g_entities + clientNum;
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 863
;862:
;863:	client = level.clients + clientNum;
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 1632
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 865
;864:
;865:	if ( ent->r.linked ) {
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
CNSTI4 0
EQI4 $359
line 866
;866:		trap_UnlinkEntity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 867
;867:	}
LABELV $359
line 869
;868:
;869:	G_InitGentity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_InitGentity
CALLV
pop
line 870
;870:	ent->touch = 0;
ADDRLP4 4
INDIRP4
CNSTI4 704
ADDP4
CNSTP4 0
ASGNP4
line 871
;871:	ent->pain = 0;
ADDRLP4 4
INDIRP4
CNSTI4 712
ADDP4
CNSTP4 0
ASGNP4
line 872
;872:	ent->client = client;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 874
;873:
;874:	if ( client->pers.connected == CON_DISCONNECTED )
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $361
line 875
;875:		return;
ADDRGP4 $358
JUMPV
LABELV $361
line 877
;876:
;877:	client->pers.connected = CON_CONNECTED;
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
CNSTI4 2
ASGNI4
line 878
;878:	client->pers.enterTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 879
;879:	client->pers.teamState.state = TEAM_BEGIN;
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
CNSTI4 0
ASGNI4
line 880
;880:	spawns = client->ps.persistant[PERS_SPAWN_COUNT];
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRI4
ASGNI4
line 887
;881:
;882:	// save eflags around this, because changing teams will
;883:	// cause this to happen with a valid entity, and we
;884:	// want to make sure the teleport bit is set right
;885:	// so the viewpoint doesn't interpolate through the
;886:	// world to the new position
;887:	flags = client->ps.eFlags;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ASGNI4
line 888
;888:	memset( &client->ps, 0, sizeof( client->ps ) );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 468
ARGI4
ADDRGP4 memset
CALLP4
pop
line 889
;889:	client->ps.eFlags = flags;
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 890
;890:	client->ps.persistant[PERS_SPAWN_COUNT] = spawns;
ADDRLP4 0
INDIRP4
CNSTI4 264
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 893
;891:
;892:	// locate ent at a spawn point
;893:	ClientSpawn( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 ClientSpawn
CALLV
pop
line 895
;894:
;895:	if ( !client->pers.inGame ) {
ADDRLP4 0
INDIRP4
CNSTI4 612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $364
line 896
;896:		BroadcastTeamChange( client, -1 );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 BroadcastTeamChange
CALLV
pop
line 897
;897:		if ( client->sess.sessionTeam == TEAM_RED || client->sess.sessionTeam == TEAM_BLUE )
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 1
EQI4 $368
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 2
NEI4 $366
LABELV $368
line 898
;898:			CheckTeamLeader( client->sess.sessionTeam );
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
ARGI4
ADDRGP4 CheckTeamLeader
CALLV
pop
LABELV $366
line 899
;899:	}
LABELV $364
line 901
;900:
;901:	if ( client->sess.sessionTeam != TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
EQI4 $369
line 903
;902:		// send event
;903:		tent = G_TempEntity( client->ps.origin, EV_PLAYER_TELEPORT_IN );
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 42
ARGI4
ADDRLP4 20
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 20
INDIRP4
ASGNP4
line 904
;904:		tent->s.clientNum = ent->s.clientNum;
ADDRLP4 16
INDIRP4
CNSTI4 168
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 906
;905:
;906:		client->sess.spectatorTime = 0;
ADDRLP4 0
INDIRP4
CNSTI4 620
ADDP4
CNSTI4 0
ASGNI4
line 908
;907:
;908:		if ( g_gametype.integer != GT_TOURNAMENT && !client->pers.inGame ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
EQI4 $371
ADDRLP4 0
INDIRP4
CNSTI4 612
ADDP4
INDIRI4
CNSTI4 0
NEI4 $371
line 909
;909:			G_BroadcastServerCommand( -1, va("print \"%s" S_COLOR_WHITE " entered the game\n\"", client->pers.netname) );
ADDRGP4 $374
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 G_BroadcastServerCommand
CALLV
pop
line 910
;910:		}
LABELV $371
line 911
;911:	}
LABELV $369
line 913
;912:	
;913:	client->pers.inGame = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 612
ADDP4
CNSTI4 1
ASGNI4
line 915
;914:
;915:	G_LogPrintf( "ClientBegin: %i\n", clientNum );
ADDRGP4 $375
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 918
;916:
;917:	// count current clients and rank for scoreboard
;918:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 919
;919:}
LABELV $358
endproc ClientBegin 28 12
export ClientSpawn
proc ClientSpawn 1380 20
line 931
;920:
;921:
;922:/*
;923:===========
;924:ClientSpawn
;925:
;926:Called every time a client is placed fresh in the world:
;927:after the first ClientBegin, and after each respawn
;928:Initializes all non-persistant parts of playerState
;929:============
;930:*/
;931:void ClientSpawn(gentity_t *ent) {
line 948
;932:	int		index;
;933:	vec3_t	spawn_origin, spawn_angles;
;934:	gclient_t	*client;
;935:	int		i;
;936:	clientPersistant_t	saved;
;937:	clientSession_t		savedSess;
;938:	int		persistant[MAX_PERSISTANT];
;939:	gentity_t	*spawnPoint;
;940:	int		flags;
;941:	int		savedPing;
;942://	char	*savedAreaBits;
;943:	int		accuracy_hits, accuracy_shots;
;944:	int		eventSequence;
;945:	char	userinfo[MAX_INFO_STRING];
;946:	qboolean isSpectator;
;947:
;948:	index = ent - g_entities;
ADDRLP4 104
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 824
DIVI4
ASGNI4
line 949
;949:	client = ent->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 951
;950:
;951:	trap_UnlinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 953
;952:
;953:	isSpectator = client->sess.sessionTeam == TEAM_SPECTATOR;
ADDRLP4 4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
NEI4 $378
ADDRLP4 1328
CNSTI4 1
ASGNI4
ADDRGP4 $379
JUMPV
LABELV $378
ADDRLP4 1328
CNSTI4 0
ASGNI4
LABELV $379
ADDRLP4 88
ADDRLP4 1328
INDIRI4
ASGNI4
line 957
;954:	// find a spawn point
;955:	// do it before setting health back up, so farthest
;956:	// ranging doesn't count this client
;957:	if ( isSpectator ) {
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $380
line 958
;958:		spawnPoint = SelectSpectatorSpawnPoint( spawn_origin, spawn_angles );
ADDRLP4 76
ARGP4
ADDRLP4 92
ARGP4
ADDRLP4 1332
ADDRGP4 SelectSpectatorSpawnPoint
CALLP4
ASGNP4
ADDRLP4 72
ADDRLP4 1332
INDIRP4
ASGNP4
line 959
;959:	} else if (g_gametype.integer >= GT_CTF ) {
ADDRGP4 $381
JUMPV
LABELV $380
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
LTI4 $382
line 961
;960:		// all base oriented team games use the CTF spawn points
;961:		spawnPoint = SelectCTFSpawnPoint( ent, client->sess.sessionTeam, client->pers.teamState.state, spawn_origin, spawn_angles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
ARGI4
ADDRLP4 76
ARGP4
ADDRLP4 92
ARGP4
ADDRLP4 1336
ADDRGP4 SelectCTFSpawnPoint
CALLP4
ASGNP4
ADDRLP4 72
ADDRLP4 1336
INDIRP4
ASGNP4
line 962
;962:	} else {
ADDRGP4 $383
JUMPV
LABELV $382
LABELV $385
line 963
;963:		do {
line 965
;964:			// the first spawn should be at a good looking spot
;965:			if ( !client->pers.initialSpawn && client->pers.localClient ) {
ADDRLP4 4
INDIRP4
CNSTI4 500
ADDP4
INDIRI4
CNSTI4 0
NEI4 $388
ADDRLP4 4
INDIRP4
CNSTI4 496
ADDP4
INDIRI4
CNSTI4 0
EQI4 $388
line 966
;966:				client->pers.initialSpawn = qtrue;
ADDRLP4 4
INDIRP4
CNSTI4 500
ADDP4
CNSTI4 1
ASGNI4
line 967
;967:				spawnPoint = SelectInitialSpawnPoint( ent, spawn_origin, spawn_angles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 92
ARGP4
ADDRLP4 1336
ADDRGP4 SelectInitialSpawnPoint
CALLP4
ASGNP4
ADDRLP4 72
ADDRLP4 1336
INDIRP4
ASGNP4
line 968
;968:			} else {
ADDRGP4 $389
JUMPV
LABELV $388
line 970
;969:				// don't spawn near existing origin if possible
;970:				spawnPoint = SelectSpawnPoint( ent, client->ps.origin, spawn_origin, spawn_angles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 92
ARGP4
ADDRLP4 1336
ADDRGP4 SelectSpawnPoint
CALLP4
ASGNP4
ADDRLP4 72
ADDRLP4 1336
INDIRP4
ASGNP4
line 971
;971:			}
LABELV $389
line 975
;972:
;973:			// Tim needs to prevent bots from spawning at the initial point
;974:			// on q3dm0...
;975:			if ( ( spawnPoint->flags & FL_NO_BOTS ) && ( ent->r.svFlags & SVF_BOT ) ) {
ADDRLP4 72
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $390
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $390
line 976
;976:				continue;	// try again
ADDRGP4 $386
JUMPV
LABELV $390
line 979
;977:			}
;978:			// just to be symetric, we have a nohumans option...
;979:			if ( ( spawnPoint->flags & FL_NO_HUMANS ) && !( ent->r.svFlags & SVF_BOT ) ) {
ADDRLP4 72
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $387
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $387
line 980
;980:				continue;	// try again
line 983
;981:			}
;982:
;983:			break;
LABELV $386
line 985
;984:
;985:		} while ( 1 );
ADDRGP4 $385
JUMPV
LABELV $387
line 986
;986:	}
LABELV $383
LABELV $381
line 987
;987:	client->pers.teamState.state = TEAM_ACTIVE;
ADDRLP4 4
INDIRP4
CNSTI4 552
ADDP4
CNSTI4 1
ASGNI4
line 990
;988:
;989:	// always clear the kamikaze flag
;990:	ent->s.eFlags &= ~EF_KAMIKAZE;
ADDRLP4 1332
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 1332
INDIRP4
ADDRLP4 1332
INDIRP4
INDIRI4
CNSTI4 -513
BANDI4
ASGNI4
line 994
;991:
;992:	// toggle the teleport bit so the client knows to not lerp
;993:	// and never clear the voted flag
;994:	flags = client->ps.eFlags & (EF_TELEPORT_BIT | EF_VOTED);
ADDRLP4 108
ADDRLP4 4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 16388
BANDI4
ASGNI4
line 995
;995:	flags ^= EF_TELEPORT_BIT;
ADDRLP4 108
ADDRLP4 108
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 998
;996:
;997:	// unlagged
;998:	G_ResetHistory( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_ResetHistory
CALLV
pop
line 999
;999:	client->saved.leveltime = 0;
ADDRLP4 4
INDIRP4
CNSTI4 1604
ADDP4
CNSTI4 0
ASGNI4
line 1003
;1000:
;1001:	// clear everything but the persistant data
;1002:
;1003:	saved = client->pers;
ADDRLP4 1136
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRB
ASGNB 148
line 1004
;1004:	savedSess = client->sess;
ADDRLP4 1284
ADDRLP4 4
INDIRP4
CNSTI4 616
ADDP4
INDIRB
ASGNB 28
line 1005
;1005:	savedPing = client->ps.ping;
ADDRLP4 1312
ADDRLP4 4
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ASGNI4
line 1007
;1006://	savedAreaBits = client->areabits;
;1007:	accuracy_hits = client->accuracy_hits;
ADDRLP4 1316
ADDRLP4 4
INDIRP4
CNSTI4 716
ADDP4
INDIRI4
ASGNI4
line 1008
;1008:	accuracy_shots = client->accuracy_shots;
ADDRLP4 1320
ADDRLP4 4
INDIRP4
CNSTI4 712
ADDP4
INDIRI4
ASGNI4
line 1009
;1009:	for ( i = 0 ; i < MAX_PERSISTANT ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $394
line 1010
;1010:		persistant[i] = client->ps.persistant[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 248
ADDP4
ADDP4
INDIRI4
ASGNI4
line 1011
;1011:	}
LABELV $395
line 1009
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $394
line 1012
;1012:	eventSequence = client->ps.eventSequence;
ADDRLP4 1324
ADDRLP4 4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ASGNI4
line 1014
;1013:
;1014:	Com_Memset (client, 0, sizeof(*client));
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1632
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1016
;1015:
;1016:	client->pers = saved;
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
ADDRLP4 1136
INDIRB
ASGNB 148
line 1017
;1017:	client->sess = savedSess;
ADDRLP4 4
INDIRP4
CNSTI4 616
ADDP4
ADDRLP4 1284
INDIRB
ASGNB 28
line 1018
;1018:	client->ps.ping = savedPing;
ADDRLP4 4
INDIRP4
CNSTI4 452
ADDP4
ADDRLP4 1312
INDIRI4
ASGNI4
line 1020
;1019://	client->areabits = savedAreaBits;
;1020:	client->accuracy_hits = accuracy_hits;
ADDRLP4 4
INDIRP4
CNSTI4 716
ADDP4
ADDRLP4 1316
INDIRI4
ASGNI4
line 1021
;1021:	client->accuracy_shots = accuracy_shots;
ADDRLP4 4
INDIRP4
CNSTI4 712
ADDP4
ADDRLP4 1320
INDIRI4
ASGNI4
line 1022
;1022:	client->lastkilled_client = -1;
ADDRLP4 4
INDIRP4
CNSTI4 720
ADDP4
CNSTI4 -1
ASGNI4
line 1024
;1023:
;1024:	for ( i = 0 ; i < MAX_PERSISTANT ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $398
line 1025
;1025:		client->ps.persistant[i] = persistant[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 248
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRI4
ASGNI4
line 1026
;1026:	}
LABELV $399
line 1024
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $398
line 1027
;1027:	client->ps.eventSequence = eventSequence;
ADDRLP4 4
INDIRP4
CNSTI4 108
ADDP4
ADDRLP4 1324
INDIRI4
ASGNI4
line 1029
;1028:	// increment the spawncount so the client will detect the respawn
;1029:	client->ps.persistant[PERS_SPAWN_COUNT]++;
ADDRLP4 1336
ADDRLP4 4
INDIRP4
CNSTI4 264
ADDP4
ASGNP4
ADDRLP4 1336
INDIRP4
ADDRLP4 1336
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1030
;1030:	client->ps.persistant[PERS_TEAM] = client->sess.sessionTeam;
ADDRLP4 4
INDIRP4
CNSTI4 260
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
ASGNI4
line 1032
;1031:
;1032:	client->airOutTime = level.time + 12000;
ADDRLP4 4
INDIRP4
CNSTI4 748
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 12000
ADDI4
ASGNI4
line 1034
;1033:
;1034:	trap_GetUserinfo( index, userinfo, sizeof(userinfo) );
ADDRLP4 104
INDIRI4
ARGI4
ADDRLP4 112
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 1036
;1035:	// set max health
;1036:	client->pers.maxHealth = atoi( Info_ValueForKey( userinfo, "handicap" ) );
ADDRLP4 112
ARGP4
ADDRGP4 $291
ARGP4
ADDRLP4 1344
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1344
INDIRP4
ARGP4
ADDRLP4 1348
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 544
ADDP4
ADDRLP4 1348
INDIRI4
ASGNI4
line 1037
;1037:	if ( client->pers.maxHealth < 1 || client->pers.maxHealth > HEALTH_SOFT_LIMIT ) {
ADDRLP4 4
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 1
LTI4 $405
ADDRLP4 4
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 100
LEI4 $403
LABELV $405
line 1038
;1038:		client->pers.maxHealth = HEALTH_SOFT_LIMIT;
ADDRLP4 4
INDIRP4
CNSTI4 544
ADDP4
CNSTI4 100
ASGNI4
line 1039
;1039:	}
LABELV $403
line 1041
;1040:	// clear entity values
;1041:	client->ps.stats[STAT_MAX_HEALTH] = client->pers.maxHealth;
ADDRLP4 4
INDIRP4
CNSTI4 212
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ASGNI4
line 1042
;1042:	client->ps.eFlags = flags;
ADDRLP4 4
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 108
INDIRI4
ASGNI4
line 1044
;1043:
;1044:	ent->s.groundEntityNum = ENTITYNUM_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 1023
ASGNI4
line 1045
;1045:	ent->client = &level.clients[index];
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
ADDRLP4 104
INDIRI4
CNSTI4 1632
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1046
;1046:	ent->inuse = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
CNSTI4 1
ASGNI4
line 1047
;1047:	ent->classname = "player";
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $406
ASGNP4
line 1048
;1048:	if ( isSpectator ) {
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $407
line 1049
;1049:		ent->takedamage = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 0
ASGNI4
line 1050
;1050:		ent->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 1051
;1051:		ent->clipmask = MASK_PLAYERSOLID & ~CONTENTS_BODY;
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 65537
ASGNI4
line 1052
;1052:		client->ps.pm_type = PM_SPECTATOR;
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 2
ASGNI4
line 1053
;1053:	} else {
ADDRGP4 $408
JUMPV
LABELV $407
line 1054
;1054:		ent->takedamage = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
CNSTI4 1
ASGNI4
line 1055
;1055:		ent->r.contents = CONTENTS_BODY;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 33554432
ASGNI4
line 1056
;1056:		ent->clipmask = MASK_PLAYERSOLID;
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
CNSTI4 33619969
ASGNI4
line 1057
;1057:	}
LABELV $408
line 1058
;1058:	ent->die = player_die;
ADDRFP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 player_die
ASGNP4
line 1059
;1059:	ent->waterlevel = 0;
ADDRFP4 0
INDIRP4
CNSTI4 796
ADDP4
CNSTI4 0
ASGNI4
line 1060
;1060:	ent->watertype = 0;
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
CNSTI4 0
ASGNI4
line 1061
;1061:	ent->flags = 0;
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
CNSTI4 0
ASGNI4
line 1063
;1062:	
;1063:	VectorCopy (playerMins, ent->r.mins);
ADDRFP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRGP4 playerMins
INDIRB
ASGNB 12
line 1064
;1064:	VectorCopy (playerMaxs, ent->r.maxs);
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDRGP4 playerMaxs
INDIRB
ASGNB 12
line 1066
;1065:
;1066:	client->ps.clientNum = index;
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 104
INDIRI4
ASGNI4
line 1068
;1067:
;1068:	client->ps.stats[STAT_WEAPONS] = ( 1 << WP_MACHINEGUN );
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 4
ASGNI4
line 1069
;1069:	if ( g_gametype.integer == GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $409
line 1070
;1070:		client->ps.ammo[WP_MACHINEGUN] = 50;
ADDRLP4 4
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 50
ASGNI4
line 1071
;1071:	} else {
ADDRGP4 $410
JUMPV
LABELV $409
line 1072
;1072:		client->ps.ammo[WP_MACHINEGUN] = 100;
ADDRLP4 4
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 100
ASGNI4
line 1073
;1073:	}
LABELV $410
line 1075
;1074:
;1075:	client->ps.stats[STAT_WEAPONS] |= ( 1 << WP_GAUNTLET );
ADDRLP4 1360
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 1360
INDIRP4
ADDRLP4 1360
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 1076
;1076:	client->ps.ammo[WP_GAUNTLET] = -1;
ADDRLP4 4
INDIRP4
CNSTI4 380
ADDP4
CNSTI4 -1
ASGNI4
line 1077
;1077:	client->ps.ammo[WP_GRAPPLING_HOOK] = -1;
ADDRLP4 4
INDIRP4
CNSTI4 416
ADDP4
CNSTI4 -1
ASGNI4
line 1080
;1078:
;1079:	// health will count down towards max_health
;1080:	ent->health = client->ps.stats[STAT_HEALTH] = client->ps.stats[STAT_MAX_HEALTH] + 25;
ADDRLP4 1368
ADDRLP4 4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 25
ADDI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 1368
INDIRI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 1368
INDIRI4
ASGNI4
line 1082
;1081:
;1082:	G_SetOrigin( ent, spawn_origin );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 76
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 1083
;1083:	VectorCopy( spawn_origin, client->ps.origin );
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 76
INDIRB
ASGNB 12
line 1086
;1084:
;1085:	// the respawned flag will be cleared after the attack and jump keys come up
;1086:	client->ps.pm_flags |= PMF_RESPAWNED;
ADDRLP4 1372
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 1372
INDIRP4
ADDRLP4 1372
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 1088
;1087:
;1088:	trap_GetUsercmd( client - level.clients, &ent->client->pers.cmd );
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1632
DIVI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 472
ADDP4
ARGP4
ADDRGP4 trap_GetUsercmd
CALLV
pop
line 1089
;1089:	SetClientViewAngle( ent, spawn_angles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 92
ARGP4
ADDRGP4 SetClientViewAngle
CALLV
pop
line 1092
;1090:
;1091:	// entity should be unlinked before calling G_KillBox()	
;1092:	if ( !isSpectator )
ADDRLP4 88
INDIRI4
CNSTI4 0
NEI4 $412
line 1093
;1093:		G_KillBox( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_KillBox
CALLV
pop
LABELV $412
line 1096
;1094:
;1095:	// force the base weapon up
;1096:	client->ps.weapon = WP_MACHINEGUN;
ADDRLP4 4
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 2
ASGNI4
line 1097
;1097:	client->ps.weaponstate = WEAPON_READY;
ADDRLP4 4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 1100
;1098:
;1099:	// don't allow full run speed for a bit
;1100:	client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
ADDRLP4 1376
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 1376
INDIRP4
ADDRLP4 1376
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 1101
;1101:	client->ps.pm_time = 100;
ADDRLP4 4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 100
ASGNI4
line 1103
;1102:
;1103:	client->respawnTime = level.time;
ADDRLP4 4
INDIRP4
CNSTI4 732
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1104
;1104:	client->inactivityTime = level.time + g_inactivity.integer * 1000;
ADDRLP4 4
INDIRP4
CNSTI4 736
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRGP4 g_inactivity+12
INDIRI4
CNSTI4 1000
MULI4
ADDI4
ASGNI4
line 1105
;1105:	client->latched_buttons = 0;
ADDRLP4 4
INDIRP4
CNSTI4 664
ADDP4
CNSTI4 0
ASGNI4
line 1108
;1106:
;1107:	// set default animations
;1108:	client->ps.torsoAnim = TORSO_STAND;
ADDRLP4 4
INDIRP4
CNSTI4 84
ADDP4
CNSTI4 11
ASGNI4
line 1109
;1109:	client->ps.legsAnim = LEGS_IDLE;
ADDRLP4 4
INDIRP4
CNSTI4 76
ADDP4
CNSTI4 22
ASGNI4
line 1111
;1110:
;1111:	if ( level.intermissiontime ) {
ADDRGP4 level+5516
INDIRI4
CNSTI4 0
EQI4 $417
line 1112
;1112:		MoveClientToIntermission( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 MoveClientToIntermission
CALLV
pop
line 1113
;1113:	} else {
ADDRGP4 $418
JUMPV
LABELV $417
line 1114
;1114:		if ( !isSpectator )
ADDRLP4 88
INDIRI4
CNSTI4 0
NEI4 $420
line 1115
;1115:			trap_LinkEntity( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
LABELV $420
line 1117
;1116:		// fire the targets of the spawn point
;1117:		G_UseTargets( spawnPoint, ent );
ADDRLP4 72
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UseTargets
CALLV
pop
line 1121
;1118:
;1119:		// select the highest weapon number available, after any
;1120:		// spawn given items have fired
;1121:		client->ps.weapon = 1;
ADDRLP4 4
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 1
ASGNI4
line 1122
;1122:		for ( i = WP_NUM_WEAPONS - 1 ; i > 0 ; i-- ) {
ADDRLP4 0
CNSTI4 14
ASGNI4
LABELV $422
line 1123
;1123:			if ( client->ps.stats[STAT_WEAPONS] & ( 1 << i ) ) {
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $426
line 1124
;1124:				client->ps.weapon = i;
ADDRLP4 4
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1125
;1125:				break;
ADDRGP4 $424
JUMPV
LABELV $426
line 1127
;1126:			}
;1127:		}
LABELV $423
line 1122
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $422
LABELV $424
line 1128
;1128:	}
LABELV $418
line 1132
;1129:
;1130:	// run a client frame to drop exactly to the floor,
;1131:	// initialize animations and other things
;1132:	client->ps.commandTime = level.time - 100;
ADDRLP4 4
INDIRP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
SUBI4
ASGNI4
line 1133
;1133:	client->pers.cmd.serverTime = level.time;
ADDRLP4 4
INDIRP4
CNSTI4 472
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1134
;1134:	ClientThink( ent-g_entities );
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 824
DIVI4
ARGI4
ADDRGP4 ClientThink
CALLV
pop
line 1136
;1135:
;1136:	BG_PlayerStateToEntityState( &client->ps, &ent->s, qtrue );
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 1137
;1137:	VectorCopy( client->ps.origin, ent->r.currentOrigin );
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1140
;1138:
;1139:	// run the presend to set anything else
;1140:	ClientEndFrame( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ClientEndFrame
CALLV
pop
line 1143
;1141:
;1142:	// clear entity state values
;1143:	BG_PlayerStateToEntityState( &client->ps, &ent->s, qtrue );
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BG_PlayerStateToEntityState
CALLV
pop
line 1144
;1144:}
LABELV $376
endproc ClientSpawn 1380 20
export ClientDisconnect
proc ClientDisconnect 24 8
line 1159
;1145:
;1146:
;1147:/*
;1148:===========
;1149:ClientDisconnect
;1150:
;1151:Called when a player drops from the server.
;1152:Will not be called between levels.
;1153:
;1154:This should NOT be called directly by any game logic,
;1155:call trap_DropClient(), which will call this and do
;1156:server system housekeeping.
;1157:============
;1158:*/
;1159:void ClientDisconnect( int clientNum ) {
line 1166
;1160:	gentity_t	*ent;
;1161:	gentity_t	*tent;
;1162:	int			i;
;1163:
;1164:	// cleanup if we are kicking a bot that
;1165:	// hasn't spawned yet
;1166:	G_RemoveQueuedBotBegin( clientNum );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_RemoveQueuedBotBegin
CALLV
pop
line 1168
;1167:
;1168:	ent = g_entities + clientNum;
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1169
;1169:	if (!ent->client || ent->client->pers.connected == CON_DISCONNECTED) {
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $433
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $431
LABELV $433
line 1170
;1170:		return;
ADDRGP4 $430
JUMPV
LABELV $431
line 1174
;1171:	}
;1172:
;1173:	// stop any following clients
;1174:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $437
JUMPV
LABELV $434
line 1175
;1175:		if ( level.clients[i].sess.sessionTeam == TEAM_SPECTATOR
ADDRLP4 20
ADDRGP4 level
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 1632
MULI4
ADDRLP4 20
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
NEI4 $439
ADDRLP4 0
INDIRI4
CNSTI4 1632
MULI4
ADDRLP4 20
INDIRP4
ADDP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 2
NEI4 $439
ADDRLP4 0
INDIRI4
CNSTI4 1632
MULI4
ADDRLP4 20
INDIRP4
ADDP4
CNSTI4 628
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $439
line 1177
;1176:			&& level.clients[i].sess.spectatorState == SPECTATOR_FOLLOW
;1177:			&& level.clients[i].sess.spectatorClient == clientNum ) {
line 1178
;1178:			StopFollowing( &g_entities[i], qtrue );
ADDRLP4 0
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 StopFollowing
CALLV
pop
line 1179
;1179:		}
LABELV $439
line 1180
;1180:	}
LABELV $435
line 1174
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $437
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $434
line 1183
;1181:
;1182:	// send effect if they were completely connected
;1183:	if ( ent->client->pers.connected == CON_CONNECTED 
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $441
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
EQI4 $441
line 1184
;1184:		&& ent->client->sess.sessionTeam != TEAM_SPECTATOR ) {
line 1185
;1185:		tent = G_TempEntity( ent->client->ps.origin, EV_PLAYER_TELEPORT_OUT );
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 43
ARGI4
ADDRLP4 20
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
line 1186
;1186:		tent->s.clientNum = ent->s.clientNum;
ADDRLP4 8
INDIRP4
CNSTI4 168
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 1190
;1187:
;1188:		// They don't get to take powerups with them!
;1189:		// Especially important for stuff like CTF flags
;1190:		TossClientItems( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 TossClientItems
CALLV
pop
line 1191
;1191:		TossClientPersistantPowerups( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 TossClientPersistantPowerups
CALLV
pop
line 1192
;1192:		if( g_gametype.integer == GT_HARVESTER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $443
line 1193
;1193:			TossClientCubes( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 TossClientCubes
CALLV
pop
line 1194
;1194:		}
LABELV $443
line 1195
;1195:	}
LABELV $441
line 1197
;1196:
;1197:	G_RevertVote( ent->client );
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_RevertVote
CALLV
pop
line 1199
;1198:
;1199:	G_LogPrintf( "ClientDisconnect: %i\n", clientNum );
ADDRGP4 $446
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1202
;1200:
;1201:	// if we are playing in tourney mode and losing, give a win to the other player
;1202:	if ( (g_gametype.integer == GT_TOURNAMENT )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $447
ADDRGP4 level+5516
INDIRI4
CNSTI4 0
NEI4 $447
ADDRGP4 level+16
INDIRI4
CNSTI4 0
NEI4 $447
ADDRGP4 level+88+4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $447
line 1204
;1203:		&& !level.intermissiontime
;1204:		&& !level.warmupTime && level.sortedClients[1] == clientNum ) {
line 1205
;1205:		level.clients[ level.sortedClients[0] ].sess.wins++;
ADDRLP4 20
ADDRGP4 level+88
INDIRI4
CNSTI4 1632
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 632
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1206
;1206:		ClientUserinfoChanged( level.sortedClients[0] );
ADDRGP4 level+88
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLI4
pop
line 1207
;1207:	}
LABELV $447
line 1209
;1208:
;1209:	trap_UnlinkEntity( ent );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 1210
;1210:	ent->s.modelindex = 0;
ADDRLP4 4
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 0
ASGNI4
line 1211
;1211:	ent->inuse = qfalse;
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
CNSTI4 0
ASGNI4
line 1212
;1212:	ent->classname = "disconnected";
ADDRLP4 4
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $456
ASGNP4
line 1213
;1213:	ent->client->pers.connected = CON_DISCONNECTED;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
CNSTI4 0
ASGNI4
line 1214
;1214:	ent->client->ps.persistant[PERS_TEAM] = TEAM_FREE;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 260
ADDP4
CNSTI4 0
ASGNI4
line 1215
;1215:	ent->client->sess.sessionTeam = TEAM_FREE;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 616
ADDP4
CNSTI4 0
ASGNI4
line 1217
;1216:
;1217:	trap_SetConfigstring( CS_PLAYERS + clientNum, "" );
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRGP4 $457
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1219
;1218:
;1219:	G_ClearClientSessionData( ent->client );
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_ClearClientSessionData
CALLV
pop
line 1221
;1220:
;1221:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 1223
;1222:
;1223:	if ( ent->r.svFlags & SVF_BOT ) {
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $458
line 1224
;1224:		BotAIShutdownClient( clientNum, qfalse );
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 BotAIShutdownClient
CALLI4
pop
line 1225
;1225:	}
LABELV $458
line 1226
;1226:}
LABELV $430
endproc ClientDisconnect 24 8
bss
align 1
LABELV ban_reason
skip 256
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
import g_podiumDrop
import g_podiumDist
import g_blood
import g_motd
import g_debugAlloc
import g_debugDamage
import g_debugMove
import g_inactivity
import g_forcerespawn
import g_weaponTeamRespawn
import g_weaponRespawn
import g_quadfactor
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
import Svcmd_AbortPodium_f
import SpawnModelsOnVictoryPads
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
import CalculateRanks
import AddScore
import player_die
import BeginIntermission
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
import TossClientCubes
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
import ArmorIndex
import Think_Weapon
import FinishSpawningItem
import G_SpawnItem
import SetRespawn
import LaunchItem
import Drop_Item
import PrecacheItem
import UseHoldableItem
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
LABELV $457
byte 1 0
align 1
LABELV $456
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
LABELV $446
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 68
byte 1 105
byte 1 115
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $406
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $375
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 66
byte 1 101
byte 1 103
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $374
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $357
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $354
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 67
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $353
byte 1 66
byte 1 111
byte 1 116
byte 1 67
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $345
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $338
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $334
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $333
byte 1 110
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $326
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 98
byte 1 97
byte 1 110
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 46
byte 1 0
align 1
LABELV $317
byte 1 66
byte 1 97
byte 1 100
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
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 46
byte 1 0
align 1
LABELV $312
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 85
byte 1 115
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 67
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $311
byte 1 110
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 116
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 104
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 99
byte 1 49
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 99
byte 1 50
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 104
byte 1 99
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 119
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 108
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 116
byte 1 116
byte 1 92
byte 1 37
byte 1 100
byte 1 92
byte 1 116
byte 1 108
byte 1 92
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $310
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $309
byte 1 110
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 116
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 104
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 99
byte 1 49
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 99
byte 1 50
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 104
byte 1 99
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 119
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 108
byte 1 92
byte 1 37
byte 1 105
byte 1 92
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 116
byte 1 116
byte 1 92
byte 1 37
byte 1 100
byte 1 92
byte 1 116
byte 1 108
byte 1 92
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $306
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $305
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $304
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
LABELV $303
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
LABELV $302
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $298
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
LABELV $291
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
LABELV $288
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $283
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 98
byte 1 111
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $278
byte 1 85
byte 1 110
byte 1 110
byte 1 97
byte 1 109
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
LABELV $277
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $274
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
LABELV $273
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
LABELV $270
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $265
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 114
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 0
align 1
LABELV $180
byte 1 107
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $153
byte 1 98
byte 1 111
byte 1 100
byte 1 121
byte 1 113
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $126
byte 1 67
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 32
byte 1 112
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $63
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 100
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
LABELV $59
byte 1 110
byte 1 111
byte 1 104
byte 1 117
byte 1 109
byte 1 97
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $56
byte 1 48
byte 1 0
align 1
LABELV $55
byte 1 110
byte 1 111
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 0

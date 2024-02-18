export DeathmatchScoreboardMessage
code
proc DeathmatchScoreboardMessage 1344 64
file "..\..\..\..\code\game\g_cmds.c"
line 11
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:#include "g_local.h"
;4:
;5:/*
;6:==================
;7:DeathmatchScoreboardMessage
;8:
;9:==================
;10:*/
;11:void DeathmatchScoreboardMessage( gentity_t *ent ) {
line 20
;12:	char		entry[256]; // enough to hold 14 integers
;13:	char		string[MAX_STRING_CHARS-1];
;14:	int			stringlength;
;15:	int			i, j, ping, prefix;
;16:	gclient_t	*cl;
;17:	int			numSorted, scoreFlags, accuracy, perfect;
;18:
;19:	// send the latest information on all clients
;20:	string[0] = '\0';
ADDRLP4 16
CNSTI1 0
ASGNI1
line 21
;21:	stringlength = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 22
;22:	scoreFlags = 0;
ADDRLP4 1316
CNSTI4 0
ASGNI4
line 24
;23:
;24:	numSorted = level.numConnectedClients;
ADDRLP4 1308
ADDRGP4 level+76
INDIRI4
ASGNI4
line 27
;25:
;26:	// estimate prefix length to avoid oversize of final string
;27:	prefix = BG_sprintf( entry, "scores %i %i %i", level.teamScores[TEAM_RED], level.teamScores[TEAM_BLUE], numSorted );
ADDRLP4 1039
ARGP4
ADDRGP4 $56
ARGP4
ADDRGP4 level+48+4
INDIRI4
ARGI4
ADDRGP4 level+48+8
INDIRI4
ARGI4
ADDRLP4 1308
INDIRI4
ARGI4
ADDRLP4 1320
ADDRGP4 BG_sprintf
CALLI4
ASGNI4
ADDRLP4 1312
ADDRLP4 1320
INDIRI4
ASGNI4
line 29
;28:	
;29:	for ( i = 0 ; i < numSorted ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $64
JUMPV
LABELV $61
line 31
;30:
;31:		cl = &level.clients[level.sortedClients[i]];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+88
ADDP4
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 33
;32:
;33:		if ( cl->pers.connected == CON_CONNECTING ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 1
NEI4 $66
line 34
;34:			ping = -1;
ADDRLP4 1296
CNSTI4 -1
ASGNI4
line 35
;35:		} else {
ADDRGP4 $67
JUMPV
LABELV $66
line 36
;36:			ping = cl->ps.ping < 999 ? cl->ps.ping : 999;
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
CNSTI4 999
GEI4 $69
ADDRLP4 1324
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $70
JUMPV
LABELV $69
ADDRLP4 1324
CNSTI4 999
ASGNI4
LABELV $70
ADDRLP4 1296
ADDRLP4 1324
INDIRI4
ASGNI4
line 37
;37:		}
LABELV $67
line 39
;38:
;39:		if( cl->accuracy_shots ) {
ADDRLP4 0
INDIRP4
CNSTI4 712
ADDP4
INDIRI4
CNSTI4 0
EQI4 $71
line 40
;40:			accuracy = cl->accuracy_hits * 100 / cl->accuracy_shots;
ADDRLP4 1300
ADDRLP4 0
INDIRP4
CNSTI4 716
ADDP4
INDIRI4
CNSTI4 100
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 712
ADDP4
INDIRI4
DIVI4
ASGNI4
line 41
;41:		} else {
ADDRGP4 $72
JUMPV
LABELV $71
line 42
;42:			accuracy = 0;
ADDRLP4 1300
CNSTI4 0
ASGNI4
line 43
;43:		}
LABELV $72
line 45
;44:
;45:		perfect = ( cl->ps.persistant[PERS_RANK] == 0 && cl->ps.persistant[PERS_KILLED] == 0 ) ? 1 : 0;
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRI4
CNSTI4 0
NEI4 $74
ADDRLP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
CNSTI4 0
NEI4 $74
ADDRLP4 1324
CNSTI4 1
ASGNI4
ADDRGP4 $75
JUMPV
LABELV $74
ADDRLP4 1324
CNSTI4 0
ASGNI4
LABELV $75
ADDRLP4 1304
ADDRLP4 1324
INDIRI4
ASGNI4
line 47
;46:
;47:		j = BG_sprintf( entry, " %i %i %i %i %i %i %i %i %i %i %i %i %i %i",
ADDRLP4 1039
ARGP4
ADDRGP4 $76
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+88
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ARGI4
ADDRLP4 1296
INDIRI4
ARGI4
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 548
ADDP4
INDIRI4
SUBI4
CNSTI4 60000
DIVI4
ARGI4
ADDRLP4 1316
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+88
ADDP4
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities+188
ADDP4
INDIRI4
ARGI4
ADDRLP4 1300
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
ARGI4
ADDRLP4 1304
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ARGI4
ADDRLP4 1340
ADDRGP4 BG_sprintf
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 1340
INDIRI4
ASGNI4
line 63
;48:			level.sortedClients[i],
;49:			cl->ps.persistant[PERS_SCORE],
;50:			ping,
;51:			(level.time - cl->pers.enterTime)/60000,
;52:			scoreFlags,
;53:			g_entities[level.sortedClients[i]].s.powerups,
;54:			accuracy, 
;55:			cl->ps.persistant[PERS_IMPRESSIVE_COUNT],
;56:			cl->ps.persistant[PERS_EXCELLENT_COUNT],
;57:			cl->ps.persistant[PERS_GAUNTLET_FRAG_COUNT], 
;58:			cl->ps.persistant[PERS_DEFEND_COUNT], 
;59:			cl->ps.persistant[PERS_ASSIST_COUNT], 
;60:			perfect,
;61:			cl->ps.persistant[PERS_CAPTURES]);
;62:
;63:		if ( stringlength + j + prefix >= sizeof( string ) )
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
ADDI4
ADDRLP4 1312
INDIRI4
ADDI4
CVIU4 4
CNSTU4 1023
LTU4 $81
line 64
;64:			break;
ADDRGP4 $63
JUMPV
LABELV $81
line 66
;65:
;66:		strcpy( string + stringlength, entry );
ADDRLP4 8
INDIRI4
ADDRLP4 16
ADDP4
ARGP4
ADDRLP4 1039
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 67
;67:		stringlength += j;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
ADDI4
ASGNI4
line 68
;68:	}
LABELV $62
line 29
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $64
ADDRLP4 4
INDIRI4
ADDRLP4 1308
INDIRI4
LTI4 $61
LABELV $63
line 70
;69:
;70:	trap_SendServerCommand( ent-g_entities, va( "scores %i %i %i%s", i,
ADDRGP4 $83
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 level+48+4
INDIRI4
ARGI4
ADDRGP4 level+48+8
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 1324
ADDRGP4 va
CALLP4
ASGNP4
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
ADDRLP4 1324
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 73
;71:		level.teamScores[TEAM_RED], level.teamScores[TEAM_BLUE],
;72:		string ) );
;73:}
LABELV $54
endproc DeathmatchScoreboardMessage 1344 64
export Cmd_Score_f
proc Cmd_Score_f 0 4
line 83
;74:
;75:
;76:/*
;77:==================
;78:Cmd_Score_f
;79:
;80:Request current scoreboard information
;81:==================
;82:*/
;83:void Cmd_Score_f( gentity_t *ent ) {
line 84
;84:	DeathmatchScoreboardMessage( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 DeathmatchScoreboardMessage
CALLV
pop
line 85
;85:}
LABELV $88
endproc Cmd_Score_f 0 4
export CheatsOk
proc CheatsOk 0 8
line 93
;86:
;87:
;88:/*
;89:==================
;90:CheatsOk
;91:==================
;92:*/
;93:qboolean	CheatsOk( gentity_t *ent ) {
line 94
;94:	if ( !g_cheats.integer ) {
ADDRGP4 g_cheats+12
INDIRI4
CNSTI4 0
NEI4 $90
line 95
;95:		trap_SendServerCommand( ent-g_entities, "print \"Cheats are not enabled on this server.\n\"");
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
ADDRGP4 $93
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 96
;96:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $89
JUMPV
LABELV $90
line 98
;97:	}
;98:	if ( ent->health <= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
GTI4 $94
line 99
;99:		trap_SendServerCommand( ent-g_entities, "print \"You must be alive to use this command.\n\"");
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
ADDRGP4 $96
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 100
;100:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $89
JUMPV
LABELV $94
line 102
;101:	}
;102:	return qtrue;
CNSTI4 1
RETI4
LABELV $89
endproc CheatsOk 0 8
bss
align 1
LABELV $98
skip 1024
export ConcatArgs
code
proc ConcatArgs 1048 12
line 111
;103:}
;104:
;105:
;106:/*
;107:==================
;108:ConcatArgs
;109:==================
;110:*/
;111:char *ConcatArgs( int start ) {
line 117
;112:	static char line[MAX_STRING_CHARS];
;113:	char	arg[MAX_STRING_CHARS];
;114:	int		i, c, tlen;
;115:	int		len;
;116:
;117:	len = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 118
;118:	c = trap_Argc();
ADDRLP4 1040
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1036
ADDRLP4 1040
INDIRI4
ASGNI4
line 119
;119:	for ( i = start ; i < c ; i++ ) {
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRGP4 $102
JUMPV
LABELV $99
line 120
;120:		trap_Argv( i, arg, sizeof( arg ) );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 121
;121:		tlen = (int)strlen( arg );
ADDRLP4 8
ARGP4
ADDRLP4 1044
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1044
INDIRI4
ASGNI4
line 122
;122:		if ( len + tlen >= sizeof( line )-1 ) {
ADDRLP4 0
INDIRI4
ADDRLP4 1032
INDIRI4
ADDI4
CVIU4 4
CNSTU4 1023
LTU4 $103
line 123
;123:			break;
ADDRGP4 $101
JUMPV
LABELV $103
line 125
;124:		}
;125:		memcpy( line + len, arg, tlen );
ADDRLP4 0
INDIRI4
ADDRGP4 $98
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 1032
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 126
;126:		len += tlen;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 1032
INDIRI4
ADDI4
ASGNI4
line 127
;127:		if ( i != c - 1 ) {
ADDRLP4 4
INDIRI4
ADDRLP4 1036
INDIRI4
CNSTI4 1
SUBI4
EQI4 $105
line 128
;128:			line[len] = ' ';
ADDRLP4 0
INDIRI4
ADDRGP4 $98
ADDP4
CNSTI1 32
ASGNI1
line 129
;129:			len++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 130
;130:		}
LABELV $105
line 131
;131:	}
LABELV $100
line 119
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $102
ADDRLP4 4
INDIRI4
ADDRLP4 1036
INDIRI4
LTI4 $99
LABELV $101
line 133
;132:
;133:	line[len] = '\0';
ADDRLP4 0
INDIRI4
ADDRGP4 $98
ADDP4
CNSTI1 0
ASGNI1
line 135
;134:
;135:	return line;
ADDRGP4 $98
RETP4
LABELV $97
endproc ConcatArgs 1048 12
export SanitizeString
proc SanitizeString 4 4
line 146
;136:}
;137:
;138:
;139:/*
;140:==================
;141:SanitizeString
;142:
;143:Remove case and control characters
;144:==================
;145:*/
;146:void SanitizeString( const char *in, char *out ) {
ADDRGP4 $109
JUMPV
LABELV $108
line 147
;147:	while ( *in ) {
line 148
;148:		if ( *in == 27 ) {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 27
NEI4 $111
line 149
;149:			in += 2;		// skip color code
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 150
;150:			continue;
ADDRGP4 $109
JUMPV
LABELV $111
line 152
;151:		}
;152:		if ( *in < ' ' ) {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
GEI4 $113
line 153
;153:			in++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 154
;154:			continue;
ADDRGP4 $109
JUMPV
LABELV $113
line 156
;155:		}
;156:		*out = tolower( *in );
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 0
ADDRGP4 tolower
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
CVII1 4
ASGNI1
line 157
;157:		out++;
ADDRFP4 4
ADDRFP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 158
;158:		in++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 159
;159:	}
LABELV $109
line 147
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $108
line 161
;160:
;161:	*out = '\0';
ADDRFP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 162
;162:}
LABELV $107
endproc SanitizeString 4 4
export ClientNumberFromString
proc ClientNumberFromString 2068 8
line 173
;163:
;164:
;165:/*
;166:==================
;167:ClientNumberFromString
;168:
;169:Returns a player number for either a number or name string
;170:Returns -1 if invalid
;171:==================
;172:*/
;173:int ClientNumberFromString( gentity_t *to, char *s ) {
line 180
;174:	gclient_t	*cl;
;175:	int			idnum;
;176:	char		s2[MAX_STRING_CHARS];
;177:	char		n2[MAX_STRING_CHARS];
;178:
;179:	// numeric values are just slot numbers
;180:	if (s[0] >= '0' && s[0] <= '9') {
ADDRLP4 2056
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 2056
INDIRI4
CNSTI4 48
LTI4 $116
ADDRLP4 2056
INDIRI4
CNSTI4 57
GTI4 $116
line 181
;181:		idnum = atoi( s );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 2060
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 2060
INDIRI4
ASGNI4
line 182
;182:		if ( (unsigned) idnum >= (unsigned)level.maxclients ) {
ADDRLP4 4
INDIRI4
CVIU4 4
ADDRGP4 level+24
INDIRI4
CVIU4 4
LTU4 $118
line 183
;183:			trap_SendServerCommand( to-g_entities, va("print \"Bad client slot: %i\n\"", idnum));
ADDRGP4 $121
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 2064
ADDRGP4 va
CALLP4
ASGNP4
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
ADDRLP4 2064
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 184
;184:			return -1;
CNSTI4 -1
RETI4
ADDRGP4 $115
JUMPV
LABELV $118
line 187
;185:		}
;186:
;187:		cl = &level.clients[idnum];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 188
;188:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $122
line 189
;189:			trap_SendServerCommand( to-g_entities, va("print \"Client %i is not active\n\"", idnum));
ADDRGP4 $124
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 2064
ADDRGP4 va
CALLP4
ASGNP4
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
ADDRLP4 2064
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 190
;190:			return -1;
CNSTI4 -1
RETI4
ADDRGP4 $115
JUMPV
LABELV $122
line 192
;191:		}
;192:		return idnum;
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $115
JUMPV
LABELV $116
line 196
;193:	}
;194:
;195:	// check for a name match
;196:	SanitizeString( s, s2 );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1032
ARGP4
ADDRGP4 SanitizeString
CALLV
pop
line 197
;197:	for ( idnum=0,cl=level.clients ; idnum < level.maxclients ; idnum++,cl++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 level
INDIRP4
ASGNP4
ADDRGP4 $128
JUMPV
LABELV $125
line 198
;198:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $130
line 199
;199:			continue;
ADDRGP4 $126
JUMPV
LABELV $130
line 201
;200:		}
;201:		SanitizeString( cl->pers.netname, n2 );
ADDRLP4 0
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 SanitizeString
CALLV
pop
line 202
;202:		if ( !strcmp( n2, s2 ) ) {
ADDRLP4 8
ARGP4
ADDRLP4 1032
ARGP4
ADDRLP4 2060
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2060
INDIRI4
CNSTI4 0
NEI4 $132
line 203
;203:			return idnum;
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $115
JUMPV
LABELV $132
line 205
;204:		}
;205:	}
LABELV $126
line 197
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1636
ADDP4
ASGNP4
LABELV $128
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $125
line 207
;206:
;207:	trap_SendServerCommand( to-g_entities, va("print \"User %s is not on the server\n\"", s));
ADDRGP4 $134
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 2060
ADDRGP4 va
CALLP4
ASGNP4
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
ADDRLP4 2060
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 208
;208:	return -1;
CNSTI4 -1
RETI4
LABELV $115
endproc ClientNumberFromString 2068 8
export Cmd_Give_f
proc Cmd_Give_f 132 12
line 220
;209:}
;210:
;211:
;212:/*
;213:==================
;214:Cmd_Give_f
;215:
;216:Give items to a client
;217:==================
;218:*/
;219:void Cmd_Give_f( gentity_t *ent )
;220:{
line 228
;221:	char		*name;
;222:	gitem_t		*it;
;223:	int			i;
;224:	qboolean	give_all;
;225:	gentity_t	*it_ent;
;226:	trace_t		trace;
;227:
;228:	if ( !CheatsOk( ent ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 CheatsOk
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $136
line 229
;229:		return;
ADDRGP4 $135
JUMPV
LABELV $136
line 232
;230:	}
;231:
;232:	name = ConcatArgs( 1 );
CNSTI4 1
ARGI4
ADDRLP4 80
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 80
INDIRP4
ASGNP4
line 234
;233:
;234:	if (Q_stricmp(name, "all") == 0)
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $140
ARGP4
ADDRLP4 84
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
NEI4 $138
line 235
;235:		give_all = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $139
JUMPV
LABELV $138
line 237
;236:	else
;237:		give_all = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $139
line 239
;238:
;239:	if (give_all || Q_stricmp( name, "health") == 0)
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $144
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $143
ARGP4
ADDRLP4 88
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
NEI4 $141
LABELV $144
line 240
;240:	{
line 241
;241:		ent->health = ent->client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ASGNI4
line 242
;242:		if (!give_all)
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $145
line 243
;243:			return;
ADDRGP4 $135
JUMPV
LABELV $145
line 244
;244:	}
LABELV $141
line 246
;245:
;246:	if (give_all || Q_stricmp(name, "weapons") == 0)
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $150
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $149
ARGP4
ADDRLP4 92
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $147
LABELV $150
line 247
;247:	{
line 248
;248:		ent->client->ps.stats[STAT_WEAPONS] = (1 << WP_NUM_WEAPONS) - 1 - 
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 31742
ASGNI4
line 250
;249:			( 1 << WP_GRAPPLING_HOOK ) - ( 1 << WP_NONE );
;250:		if (!give_all)
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $151
line 251
;251:			return;
ADDRGP4 $135
JUMPV
LABELV $151
line 252
;252:	}
LABELV $147
line 254
;253:
;254:	if (give_all || Q_stricmp(name, "ammo") == 0)
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $156
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $155
ARGP4
ADDRLP4 96
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
NEI4 $153
LABELV $156
line 255
;255:	{
line 256
;256:		for ( i = 0 ; i < MAX_WEAPONS ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $157
line 257
;257:			ent->client->ps.ammo[i] = 999;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
CNSTI4 999
ASGNI4
line 258
;258:		}
LABELV $158
line 256
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $157
line 259
;259:		if (!give_all)
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $161
line 260
;260:			return;
ADDRGP4 $135
JUMPV
LABELV $161
line 261
;261:	}
LABELV $153
line 263
;262:
;263:	if (give_all || Q_stricmp(name, "armor") == 0)
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $166
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $165
ARGP4
ADDRLP4 100
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
NEI4 $163
LABELV $166
line 264
;264:	{
line 265
;265:		ent->client->ps.stats[STAT_ARMOR] = 200;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 200
ADDP4
CNSTI4 200
ASGNI4
line 267
;266:
;267:		if (!give_all)
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $167
line 268
;268:			return;
ADDRGP4 $135
JUMPV
LABELV $167
line 269
;269:	}
LABELV $163
line 271
;270:
;271:	if (Q_stricmp(name, "excellent") == 0) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $171
ARGP4
ADDRLP4 104
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
NEI4 $169
line 272
;272:		ent->client->ps.persistant[PERS_EXCELLENT_COUNT]++;
ADDRLP4 108
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 288
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 273
;273:		return;
ADDRGP4 $135
JUMPV
LABELV $169
line 275
;274:	}
;275:	if (Q_stricmp(name, "impressive") == 0) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $174
ARGP4
ADDRLP4 108
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
NEI4 $172
line 276
;276:		ent->client->ps.persistant[PERS_IMPRESSIVE_COUNT]++;
ADDRLP4 112
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 284
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 277
;277:		return;
ADDRGP4 $135
JUMPV
LABELV $172
line 279
;278:	}
;279:	if (Q_stricmp(name, "gauntletaward") == 0) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $177
ARGP4
ADDRLP4 112
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
NEI4 $175
line 280
;280:		ent->client->ps.persistant[PERS_GAUNTLET_FRAG_COUNT]++;
ADDRLP4 116
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 300
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 281
;281:		return;
ADDRGP4 $135
JUMPV
LABELV $175
line 283
;282:	}
;283:	if (Q_stricmp(name, "defend") == 0) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $180
ARGP4
ADDRLP4 116
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
NEI4 $178
line 284
;284:		ent->client->ps.persistant[PERS_DEFEND_COUNT]++;
ADDRLP4 120
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 292
ADDP4
ASGNP4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 285
;285:		return;
ADDRGP4 $135
JUMPV
LABELV $178
line 287
;286:	}
;287:	if (Q_stricmp(name, "assist") == 0) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $183
ARGP4
ADDRLP4 120
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
NEI4 $181
line 288
;288:		ent->client->ps.persistant[PERS_ASSIST_COUNT]++;
ADDRLP4 124
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 296
ADDP4
ASGNP4
ADDRLP4 124
INDIRP4
ADDRLP4 124
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 289
;289:		return;
ADDRGP4 $135
JUMPV
LABELV $181
line 293
;290:	}
;291:
;292:	// spawn a specific item right on the player
;293:	if ( !give_all ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $184
line 294
;294:		it = BG_FindItem (name);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 BG_FindItem
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 124
INDIRP4
ASGNP4
line 295
;295:		if (!it) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $186
line 296
;296:			return;
ADDRGP4 $135
JUMPV
LABELV $186
line 299
;297:		}
;298:
;299:		it_ent = G_Spawn();
ADDRLP4 128
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 128
INDIRP4
ASGNP4
line 300
;300:		VectorCopy( ent->r.currentOrigin, it_ent->s.origin );
ADDRLP4 12
INDIRP4
CNSTI4 92
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 301
;301:		it_ent->classname = it->classname;
ADDRLP4 12
INDIRP4
CNSTI4 524
ADDP4
ADDRLP4 16
INDIRP4
INDIRP4
ASGNP4
line 302
;302:		G_SpawnItem (it_ent, it);
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 G_SpawnItem
CALLV
pop
line 303
;303:		FinishSpawningItem(it_ent );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 FinishSpawningItem
CALLV
pop
line 304
;304:		memset( &trace, 0, sizeof( trace ) );
ADDRLP4 20
ARGP4
CNSTI4 0
ARGI4
CNSTI4 56
ARGI4
ADDRGP4 memset
CALLP4
pop
line 305
;305:		Touch_Item (it_ent, ent, &trace);
ADDRLP4 12
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 Touch_Item
CALLV
pop
line 306
;306:		if (it_ent->inuse) {
ADDRLP4 12
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $188
line 307
;307:			G_FreeEntity( it_ent );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 308
;308:		}
LABELV $188
line 309
;309:	}
LABELV $184
line 310
;310:}
LABELV $135
endproc Cmd_Give_f 132 12
export Cmd_God_f
proc Cmd_God_f 16 8
line 323
;311:
;312:
;313:/*
;314:==================
;315:Cmd_God_f
;316:
;317:Sets client to godmode
;318:
;319:argv(0) god
;320:==================
;321:*/
;322:void Cmd_God_f( gentity_t *ent )
;323:{
line 326
;324:	const char *msg;
;325:
;326:	if ( !CheatsOk( ent ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 CheatsOk
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $191
line 327
;327:		return;
ADDRGP4 $190
JUMPV
LABELV $191
line 330
;328:	}
;329:
;330:	ent->flags ^= FL_GODMODE;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 16
BXORI4
ASGNI4
line 331
;331:	if (!(ent->flags & FL_GODMODE) )
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $193
line 332
;332:		msg = "godmode OFF\n";
ADDRLP4 0
ADDRGP4 $195
ASGNP4
ADDRGP4 $194
JUMPV
LABELV $193
line 334
;333:	else
;334:		msg = "godmode ON\n";
ADDRLP4 0
ADDRGP4 $196
ASGNP4
LABELV $194
line 336
;335:
;336:	trap_SendServerCommand( ent-g_entities, va( "print \"%s\"", msg ) );
ADDRGP4 $197
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
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
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 337
;337:}
LABELV $190
endproc Cmd_God_f 16 8
export Cmd_Notarget_f
proc Cmd_Notarget_f 16 8
line 349
;338:
;339:
;340:/*
;341:==================
;342:Cmd_Notarget_f
;343:
;344:Sets client to notarget
;345:
;346:argv(0) notarget
;347:==================
;348:*/
;349:void Cmd_Notarget_f( gentity_t *ent ) {
line 352
;350:	const char *msg;
;351:
;352:	if ( !CheatsOk( ent ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 CheatsOk
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $199
line 353
;353:		return;
ADDRGP4 $198
JUMPV
LABELV $199
line 356
;354:	}
;355:
;356:	ent->flags ^= FL_NOTARGET;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 32
BXORI4
ASGNI4
line 357
;357:	if (!(ent->flags & FL_NOTARGET) )
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $201
line 358
;358:		msg = "notarget OFF\n";
ADDRLP4 0
ADDRGP4 $203
ASGNP4
ADDRGP4 $202
JUMPV
LABELV $201
line 360
;359:	else
;360:		msg = "notarget ON\n";
ADDRLP4 0
ADDRGP4 $204
ASGNP4
LABELV $202
line 362
;361:
;362:	trap_SendServerCommand( ent-g_entities, va( "print \"%s\"", msg ) );
ADDRGP4 $197
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
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
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 363
;363:}
LABELV $198
endproc Cmd_Notarget_f 16 8
export Cmd_Noclip_f
proc Cmd_Noclip_f 20 8
line 373
;364:
;365:
;366:/*
;367:==================
;368:Cmd_Noclip_f
;369:
;370:argv(0) noclip
;371:==================
;372:*/
;373:void Cmd_Noclip_f( gentity_t *ent ) {
line 376
;374:	const char *msg;
;375:
;376:	if ( !CheatsOk( ent ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 CheatsOk
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $206
line 377
;377:		return;
ADDRGP4 $205
JUMPV
LABELV $206
line 380
;378:	}
;379:
;380:	if ( ent->client->noclip ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 648
ADDP4
INDIRI4
CNSTI4 0
EQI4 $208
line 381
;381:		msg = "noclip OFF\n";
ADDRLP4 0
ADDRGP4 $210
ASGNP4
line 382
;382:	} else {
ADDRGP4 $209
JUMPV
LABELV $208
line 383
;383:		msg = "noclip ON\n";
ADDRLP4 0
ADDRGP4 $211
ASGNP4
line 384
;384:	}
LABELV $209
line 385
;385:	ent->client->noclip = !ent->client->noclip;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 648
ADDP4
INDIRI4
CNSTI4 0
NEI4 $213
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $214
JUMPV
LABELV $213
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $214
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 648
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 387
;386:
;387:	trap_SendServerCommand( ent-g_entities, va("print \"%s\"", msg));
ADDRGP4 $197
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
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
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 388
;388:}
LABELV $205
endproc Cmd_Noclip_f 20 8
export Cmd_LevelShot_f
proc Cmd_LevelShot_f 4 8
line 401
;389:
;390:
;391:/*
;392:==================
;393:Cmd_LevelShot_f
;394:
;395:This is just to help generate the level pictures
;396:for the menus.  It goes to the intermission immediately
;397:and sends over a command to the client to resize the view,
;398:hide the scoreboard, and take a special screenshot
;399:==================
;400:*/
;401:void Cmd_LevelShot_f( gentity_t *ent ) {
line 402
;402:	if ( !CheatsOk( ent ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 CheatsOk
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $216
line 403
;403:		return;
ADDRGP4 $215
JUMPV
LABELV $216
line 407
;404:	}
;405:
;406:	// doesn't work in single player
;407:	if ( g_gametype.integer == GT_SINGLE_PLAYER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $218
line 408
;408:		trap_SendServerCommand( ent-g_entities, 
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
ADDRGP4 $221
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 410
;409:			"print \"Must be in g_gametype 0 for levelshot\n\"" );
;410:		return;
ADDRGP4 $215
JUMPV
LABELV $218
line 413
;411:	}
;412:
;413:	if ( !ent->client->pers.localClient )
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 496
ADDP4
INDIRI4
CNSTI4 0
NEI4 $222
line 414
;414:	{
line 415
;415:		trap_SendServerCommand( ent - g_entities,
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
ADDRGP4 $224
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 417
;416:			"print \"The levelshot command must be executed by a local client\n\"" );
;417:		return;
ADDRGP4 $215
JUMPV
LABELV $222
line 420
;418:	}
;419:
;420:	BeginIntermission();
ADDRGP4 BeginIntermission
CALLV
pop
line 421
;421:	trap_SendServerCommand( ent-g_entities, "clientLevelShot" );
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
ADDRGP4 $225
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 422
;422:}
LABELV $215
endproc Cmd_LevelShot_f 4 8
export Cmd_TeamTask_f
proc Cmd_TeamTask_f 2068 12
line 430
;423:
;424:
;425:/*
;426:==================
;427:Cmd_TeamTask_f
;428:==================
;429:*/
;430:void Cmd_TeamTask_f( gentity_t *ent ) {
line 434
;431:	char userinfo[MAX_INFO_STRING];
;432:	char arg[MAX_TOKEN_CHARS];
;433:	int task;
;434:	int client = ent->client - level.clients;
ADDRLP4 1024
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1636
DIVI4
ASGNI4
line 436
;435:
;436:	if ( trap_Argc() != 2 ) {
ADDRLP4 2056
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 2056
INDIRI4
CNSTI4 2
EQI4 $227
line 437
;437:		return;
ADDRGP4 $226
JUMPV
LABELV $227
line 439
;438:	}
;439:	trap_Argv( 1, arg, sizeof( arg ) );
CNSTI4 1
ARGI4
ADDRLP4 1028
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 440
;440:	task = atoi( arg );
ADDRLP4 1028
ARGP4
ADDRLP4 2060
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 2052
ADDRLP4 2060
INDIRI4
ASGNI4
line 442
;441:
;442:	trap_GetUserinfo( client, userinfo, sizeof( userinfo ) );
ADDRLP4 1024
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 443
;443:	Info_SetValueForKey( userinfo, "teamtask", va( "%d", task ) );
ADDRGP4 $230
ARGP4
ADDRLP4 2052
INDIRI4
ARGI4
ADDRLP4 2064
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRGP4 $229
ARGP4
ADDRLP4 2064
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 444
;444:	trap_SetUserinfo( client, userinfo );
ADDRLP4 1024
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 445
;445:	ClientUserinfoChanged( client );
ADDRLP4 1024
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLI4
pop
line 446
;446:}
LABELV $226
endproc Cmd_TeamTask_f 2068 12
export Cmd_Kill_f
proc Cmd_Kill_f 16 20
line 454
;447:
;448:
;449:/*
;450:=================
;451:Cmd_Kill_f
;452:=================
;453:*/
;454:void Cmd_Kill_f( gentity_t *ent ) {
line 455
;455:	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
NEI4 $232
line 456
;456:		return;
ADDRGP4 $231
JUMPV
LABELV $232
line 458
;457:	}
;458:	if (ent->health <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
GTI4 $234
line 459
;459:		return;
ADDRGP4 $231
JUMPV
LABELV $234
line 461
;460:	}
;461:	if (g_allowKill.integer <= 0) {
ADDRGP4 g_allowKill+12
INDIRI4
CNSTI4 0
GTI4 $236
line 462
;462:		trap_SendServerCommand(ent - g_entities,
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
ADDRGP4 $239
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 464
;463:			"print \"Kill is not enabled on this server.\n\"");
;464:		return;
ADDRGP4 $231
JUMPV
LABELV $236
line 466
;465:	}
;466:	if (ent->client->killCmdTime + g_allowKill.integer > level.time) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
ADDRGP4 g_allowKill+12
INDIRI4
ADDI4
ADDRGP4 level+32
INDIRI4
LEI4 $240
line 467
;467:		return;
ADDRGP4 $231
JUMPV
LABELV $240
line 470
;468:	}
;469:
;470:	ent->client->killCmdTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 736
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 471
;471:	ent->flags &= ~FL_GODMODE;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 472
;472:	ent->client->ps.stats[STAT_HEALTH] = ent->health = -999;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
CNSTI4 -999
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 473
;473:	player_die (ent, ent, ent, 100000, MOD_SUICIDE);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTI4 100000
ARGI4
CNSTI4 20
ARGI4
ADDRGP4 player_die
CALLV
pop
line 474
;474:}
LABELV $231
endproc Cmd_Kill_f 16 20
export BroadcastTeamChange
proc BroadcastTeamChange 8 8
line 485
;475:
;476:
;477:/*
;478:=================
;479:BroadcastTeamChange
;480:
;481:Let everyone know about a team change
;482:=================
;483:*/
;484:void BroadcastTeamChange( gclient_t *client, team_t oldTeam )
;485:{
line 486
;486:	int clientNum = client - level.clients;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1636
DIVI4
ASGNI4
line 488
;487:
;488:	if ( client->sess.sessionTeam == TEAM_RED ) {
ADDRFP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 1
NEI4 $246
line 489
;489:		G_BroadcastServerCommand( clientNum, va("cp \"%s" S_COLOR_WHITE " joined the " S_COLOR_RED "red" S_COLOR_WHITE " team.\n\"",
ADDRGP4 $248
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_BroadcastServerCommand
CALLV
pop
line 491
;490:			client->pers.netname) );
;491:	} else if ( client->sess.sessionTeam == TEAM_BLUE ) {
ADDRGP4 $247
JUMPV
LABELV $246
ADDRFP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 2
NEI4 $249
line 492
;492:		G_BroadcastServerCommand( clientNum, va("cp \"%s" S_COLOR_WHITE " joined the " S_COLOR_BLUE "blue" S_COLOR_WHITE " team.\n\"",
ADDRGP4 $251
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_BroadcastServerCommand
CALLV
pop
line 494
;493:		client->pers.netname));
;494:	} else if ( client->sess.sessionTeam == TEAM_SPECTATOR && oldTeam != TEAM_SPECTATOR ) {
ADDRGP4 $250
JUMPV
LABELV $249
ADDRFP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
NEI4 $252
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $252
line 495
;495:		G_BroadcastServerCommand( clientNum, va("cp \"%s" S_COLOR_WHITE " joined the spectators.\n\"",
ADDRGP4 $254
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_BroadcastServerCommand
CALLV
pop
line 497
;496:		client->pers.netname));
;497:	} else if ( client->sess.sessionTeam == TEAM_FREE ) {
ADDRGP4 $253
JUMPV
LABELV $252
ADDRFP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 0
NEI4 $255
line 498
;498:		G_BroadcastServerCommand( clientNum, va("cp \"%s" S_COLOR_WHITE " joined the battle.\n\"",
ADDRGP4 $257
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_BroadcastServerCommand
CALLV
pop
line 500
;499:		client->pers.netname));
;500:	}
LABELV $255
LABELV $253
LABELV $250
LABELV $247
line 501
;501:}
LABELV $245
endproc BroadcastTeamChange 8 8
proc AllowTeamSwitch 24 8
line 504
;502:
;503:
;504:static qboolean AllowTeamSwitch( int clientNum, team_t newTeam ) {
line 506
;505:
;506:	if ( g_teamForceBalance.integer  ) {
ADDRGP4 g_teamForceBalance+12
INDIRI4
CNSTI4 0
EQI4 $259
line 509
;507:		int		counts[TEAM_NUM_TEAMS];
;508:
;509:		counts[TEAM_BLUE] = TeamCount( clientNum, TEAM_BLUE );
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
line 510
;510:		counts[TEAM_RED] = TeamCount( clientNum, TEAM_RED );
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
line 513
;511:
;512:		// We allow a spread of two
;513:		if ( newTeam == TEAM_RED && counts[TEAM_RED] - counts[TEAM_BLUE] > 1 ) {
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $264
ADDRLP4 0+4
INDIRI4
ADDRLP4 0+8
INDIRI4
SUBI4
CNSTI4 1
LEI4 $264
line 514
;514:			trap_SendServerCommand( clientNum, "cp \"Red team has too many players.\n\"" );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $268
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 515
;515:			return qfalse; // ignore the request
CNSTI4 0
RETI4
ADDRGP4 $258
JUMPV
LABELV $264
line 518
;516:		}
;517:
;518:		if ( newTeam == TEAM_BLUE && counts[TEAM_BLUE] - counts[TEAM_RED] > 1 ) {
ADDRFP4 4
INDIRI4
CNSTI4 2
NEI4 $269
ADDRLP4 0+8
INDIRI4
ADDRLP4 0+4
INDIRI4
SUBI4
CNSTI4 1
LEI4 $269
line 519
;519:			trap_SendServerCommand( clientNum, "cp \"Blue team has too many players.\n\"" );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $273
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 520
;520:			return qfalse; // ignore the request
CNSTI4 0
RETI4
ADDRGP4 $258
JUMPV
LABELV $269
line 524
;521:		}
;522:
;523:		// It's ok, the team we are switching to has less or same number of players
;524:	}
LABELV $259
line 526
;525:
;526:	return qtrue;
CNSTI4 1
RETI4
LABELV $258
endproc AllowTeamSwitch 24 8
export SetTeam
proc SetTeam 76 20
line 535
;527:}
;528:
;529:
;530:/*
;531:=================
;532:SetTeam
;533:=================
;534:*/
;535:qboolean SetTeam( gentity_t *ent, const char *s ) {
line 548
;536:	team_t				team, oldTeam;
;537:	gclient_t			*client;
;538:	int					clientNum;
;539:	spectatorState_t	specState;
;540:	int					specClient;
;541:	int					teamLeader;
;542:	qboolean			checkTeamLeader;
;543:
;544:	//
;545:	// see what change is requested
;546:	//
;547:
;548:	clientNum = ent - g_entities;
ADDRLP4 12
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
line 549
;549:	client = level.clients + clientNum;
ADDRLP4 0
ADDRLP4 12
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 552
;550:
;551:	// early team override
;552:	if ( client->pers.connected == CON_CONNECTING && g_gametype.integer >= GT_TEAM ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 1
NEI4 $275
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $275
line 553
;553:		if ( !Q_stricmp( s, "red" ) || !Q_stricmp( s, "r" ) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $280
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $282
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $281
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $278
LABELV $282
line 554
;554:			team = TEAM_RED;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 555
;555:		} else if ( !Q_stricmp( s, "blue" ) || !Q_stricmp( s, "b" ) ) {
ADDRGP4 $279
JUMPV
LABELV $278
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $285
ARGP4
ADDRLP4 40
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $287
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $286
ARGP4
ADDRLP4 44
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $283
LABELV $287
line 556
;556:			team = TEAM_BLUE; 
ADDRLP4 4
CNSTI4 2
ASGNI4
line 557
;557:		} else {
ADDRGP4 $284
JUMPV
LABELV $283
line 558
;558:			team = -1;
ADDRLP4 4
CNSTI4 -1
ASGNI4
line 559
;559:		}
LABELV $284
LABELV $279
line 560
;560:		if ( team != -1 && AllowTeamSwitch( clientNum, team ) ) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $288
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 AllowTeamSwitch
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $288
line 561
;561:			client->sess.sessionTeam = team;
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 562
;562:			client->pers.teamState.state = TEAM_BEGIN;
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
CNSTI4 0
ASGNI4
line 563
;563:			G_WriteClientSessionData( client );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_WriteClientSessionData
CALLV
pop
line 565
;564:			// count current clients and rank for scoreboard
;565:			CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 566
;566:		}
LABELV $288
line 567
;567:		return qfalse; // bypass flood protection
CNSTI4 0
RETI4
ADDRGP4 $274
JUMPV
LABELV $275
line 570
;568:	}
;569:
;570:	specClient = clientNum;
ADDRLP4 20
ADDRLP4 12
INDIRI4
ASGNI4
line 571
;571:	specState = SPECTATOR_NOT;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 572
;572:	if ( !Q_stricmp( s, "scoreboard" ) || !Q_stricmp( s, "score" )  ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $292
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $294
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $293
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $290
LABELV $294
line 573
;573:		team = TEAM_SPECTATOR;
ADDRLP4 4
CNSTI4 3
ASGNI4
line 574
;574:		specState = SPECTATOR_SCOREBOARD;
ADDRLP4 16
CNSTI4 3
ASGNI4
line 575
;575:	} else if ( !Q_stricmp( s, "follow1" ) ) {
ADDRGP4 $291
JUMPV
LABELV $290
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $297
ARGP4
ADDRLP4 40
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $295
line 576
;576:		team = TEAM_SPECTATOR;
ADDRLP4 4
CNSTI4 3
ASGNI4
line 577
;577:		specState = SPECTATOR_FOLLOW;
ADDRLP4 16
CNSTI4 2
ASGNI4
line 578
;578:		specClient = -1;
ADDRLP4 20
CNSTI4 -1
ASGNI4
line 579
;579:	} else if ( !Q_stricmp( s, "follow2" ) ) {
ADDRGP4 $296
JUMPV
LABELV $295
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $300
ARGP4
ADDRLP4 44
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $298
line 580
;580:		team = TEAM_SPECTATOR;
ADDRLP4 4
CNSTI4 3
ASGNI4
line 581
;581:		specState = SPECTATOR_FOLLOW;
ADDRLP4 16
CNSTI4 2
ASGNI4
line 582
;582:		specClient = -2;
ADDRLP4 20
CNSTI4 -2
ASGNI4
line 583
;583:	} else if ( !Q_stricmp( s, "spectator" ) || !Q_stricmp( s, "s" ) ) {
ADDRGP4 $299
JUMPV
LABELV $298
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $303
ARGP4
ADDRLP4 48
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $305
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $304
ARGP4
ADDRLP4 52
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $301
LABELV $305
line 584
;584:		team = TEAM_SPECTATOR;
ADDRLP4 4
CNSTI4 3
ASGNI4
line 585
;585:		specState = SPECTATOR_FREE;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 586
;586:	} else if ( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 $302
JUMPV
LABELV $301
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $306
line 588
;587:		// if running a team game, assign player to one of the teams
;588:		specState = SPECTATOR_NOT;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 589
;589:		if ( !Q_stricmp( s, "red" ) || !Q_stricmp( s, "r" ) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $280
ARGP4
ADDRLP4 56
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $311
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $281
ARGP4
ADDRLP4 60
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $309
LABELV $311
line 590
;590:			team = TEAM_RED;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 591
;591:		} else if ( !Q_stricmp( s, "blue" ) || !Q_stricmp( s, "b" ) ) {
ADDRGP4 $310
JUMPV
LABELV $309
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $285
ARGP4
ADDRLP4 64
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
EQI4 $314
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $286
ARGP4
ADDRLP4 68
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $312
LABELV $314
line 592
;592:			team = TEAM_BLUE;
ADDRLP4 4
CNSTI4 2
ASGNI4
line 593
;593:		} else {
ADDRGP4 $313
JUMPV
LABELV $312
line 595
;594:			// pick the team with the least number of players
;595:			team = PickTeam( clientNum );
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 72
ADDRGP4 PickTeam
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 72
INDIRI4
ASGNI4
line 596
;596:		}
LABELV $313
LABELV $310
line 598
;597:
;598:		if ( !AllowTeamSwitch( clientNum, team ) ) {
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 72
ADDRGP4 AllowTeamSwitch
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $307
line 599
;599:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $274
JUMPV
line 602
;600:		}
;601:
;602:	} else {
LABELV $306
line 604
;603:		// force them to spectators if there aren't any spots free
;604:		team = TEAM_FREE;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 605
;605:	}
LABELV $307
LABELV $302
LABELV $299
LABELV $296
LABELV $291
line 608
;606:
;607:	// override decision if limiting the players
;608:	if ( (g_gametype.integer == GT_TOURNAMENT)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $317
ADDRGP4 level+80
INDIRI4
CNSTI4 2
LTI4 $317
line 609
;609:		&& level.numNonSpectatorClients >= 2 ) {
line 610
;610:		team = TEAM_SPECTATOR;
ADDRLP4 4
CNSTI4 3
ASGNI4
line 611
;611:	} else if ( g_maxGameClients.integer > 0 && 
ADDRGP4 $318
JUMPV
LABELV $317
ADDRGP4 g_maxGameClients+12
INDIRI4
CNSTI4 0
LEI4 $321
ADDRGP4 level+80
INDIRI4
ADDRGP4 g_maxGameClients+12
INDIRI4
LTI4 $321
line 612
;612:		level.numNonSpectatorClients >= g_maxGameClients.integer ) {
line 613
;613:		team = TEAM_SPECTATOR;
ADDRLP4 4
CNSTI4 3
ASGNI4
line 614
;614:	}
LABELV $321
LABELV $318
line 619
;615:
;616:	//
;617:	// decide if we will allow the change
;618:	//
;619:	oldTeam = client->sess.sessionTeam;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
ASGNI4
line 620
;620:	if ( team == oldTeam ) {
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $326
line 621
;621:		if ( team != TEAM_SPECTATOR )
ADDRLP4 4
INDIRI4
CNSTI4 3
EQI4 $328
line 622
;622:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $274
JUMPV
LABELV $328
line 625
;623:
;624:		// do soft release if possible
;625:		if ( ( client->ps.pm_flags & PMF_FOLLOW ) && client->sess.spectatorState == SPECTATOR_FOLLOW ) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $330
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 2
NEI4 $330
line 626
;626:			StopFollowing( ent, qtrue );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 StopFollowing
CALLV
pop
line 627
;627:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $274
JUMPV
LABELV $330
line 631
;628:		}
;629:
;630:		// second spectator team request will move player to intermission point
;631:		if ( client->ps.persistant[ PERS_TEAM ] == TEAM_SPECTATOR && !( client->ps.pm_flags & PMF_FOLLOW )
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 3
NEI4 $332
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $332
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 1
NEI4 $332
line 632
;632:			&& client->sess.spectatorState == SPECTATOR_FREE ) {
line 633
;633:			VectorCopy( level.intermission_origin, ent->s.origin );
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRGP4 level+5528
INDIRB
ASGNB 12
line 634
;634:			VectorCopy( level.intermission_origin, client->ps.origin );
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 level+5528
INDIRB
ASGNB 12
line 635
;635:			SetClientViewAngle( ent, level.intermission_angle );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 level+5540
ARGP4
ADDRGP4 SetClientViewAngle
CALLV
pop
line 636
;636:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $274
JUMPV
LABELV $332
line 638
;637:		}
;638:	}
LABELV $326
line 645
;639:
;640:	//
;641:	// execute the team change
;642:	//
;643:
;644:	// if the player was dead leave the body
;645:	if ( ent->health <= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
GTI4 $337
line 646
;646:		CopyToBodyQue( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CopyToBodyQue
CALLV
pop
line 647
;647:	}
LABELV $337
line 650
;648:
;649:	// he starts at 'base'
;650:	client->pers.teamState.state = TEAM_BEGIN;
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
CNSTI4 0
ASGNI4
line 652
;651:
;652:	if ( oldTeam != TEAM_SPECTATOR ) {
ADDRLP4 8
INDIRI4
CNSTI4 3
EQI4 $339
line 655
;653:		
;654:		// revert any casted votes
;655:		if ( oldTeam != team )
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $341
line 656
;656:			G_RevertVote( ent->client );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_RevertVote
CALLV
pop
LABELV $341
line 659
;657:
;658:		// Kill him (makes sure he loses flags, etc)
;659:		ent->flags &= ~FL_GODMODE;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 660
;660:		ent->client->ps.stats[STAT_HEALTH] = ent->health = 0;
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRLP4 60
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 64
INDIRI4
ASGNI4
ADDRLP4 60
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 64
INDIRI4
ASGNI4
line 661
;661:		player_die (ent, ent, ent, 100000, MOD_SUICIDE);
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
CNSTI4 100000
ARGI4
CNSTI4 20
ARGI4
ADDRGP4 player_die
CALLV
pop
line 662
;662:	}
LABELV $339
line 665
;663:
;664:	// they go to the end of the line for tournements
;665:	if ( team == TEAM_SPECTATOR ) {
ADDRLP4 4
INDIRI4
CNSTI4 3
NEI4 $343
line 666
;666:		client->sess.spectatorTime = 0;
ADDRLP4 0
INDIRP4
CNSTI4 620
ADDP4
CNSTI4 0
ASGNI4
line 667
;667:	}
LABELV $343
line 669
;668:
;669:	client->sess.sessionTeam = team;
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 670
;670:	client->sess.spectatorState = specState;
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 671
;671:	client->sess.spectatorClient = specClient;
ADDRLP4 0
INDIRP4
CNSTI4 628
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 673
;672:
;673:	checkTeamLeader = client->sess.teamLeader;
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 640
ADDP4
INDIRI4
ASGNI4
line 674
;674:	client->sess.teamLeader = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 640
ADDP4
CNSTI4 0
ASGNI4
line 676
;675:
;676:	if ( team == TEAM_RED || team == TEAM_BLUE ) {
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $347
ADDRLP4 4
INDIRI4
CNSTI4 2
NEI4 $345
LABELV $347
line 677
;677:		teamLeader = TeamLeader( team );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 TeamLeader
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 60
INDIRI4
ASGNI4
line 679
;678:		// if there is no team leader or the team leader is a bot and this client is not a bot
;679:		if ( teamLeader == -1 || ( !(g_entities[clientNum].r.svFlags & SVF_BOT) && (g_entities[teamLeader].r.svFlags & SVF_BOT) ) ) {
ADDRLP4 64
ADDRLP4 24
INDIRI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 -1
EQI4 $354
ADDRLP4 12
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $348
ADDRLP4 64
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $348
LABELV $354
line 680
;680:			SetLeader( team, clientNum );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 SetLeader
CALLV
pop
line 681
;681:		}
LABELV $348
line 682
;682:	}
LABELV $345
line 685
;683:
;684:	// make sure there is a team leader on the team the player came from
;685:	if ( oldTeam == TEAM_RED || oldTeam == TEAM_BLUE ) {
ADDRLP4 8
INDIRI4
CNSTI4 1
EQI4 $357
ADDRLP4 8
INDIRI4
CNSTI4 2
NEI4 $355
LABELV $357
line 686
;686:		if ( checkTeamLeader ) {
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $358
line 687
;687:			CheckTeamLeader( oldTeam );
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 CheckTeamLeader
CALLV
pop
line 688
;688:		}
LABELV $358
line 689
;689:	}
LABELV $355
line 691
;690:
;691:	G_WriteClientSessionData( client );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_WriteClientSessionData
CALLV
pop
line 693
;692:
;693:	BroadcastTeamChange( client, oldTeam );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 BroadcastTeamChange
CALLV
pop
line 696
;694:
;695:	// get and distribute relevent paramters
;696:	ClientUserinfoChanged( clientNum );
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLI4
pop
line 698
;697:
;698:	ClientBegin( clientNum );
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 ClientBegin
CALLV
pop
line 700
;699:
;700:	return qtrue;
CNSTI4 1
RETI4
LABELV $274
endproc SetTeam 76 20
export StopFollowing
proc StopFollowing 12 12
line 712
;701:}
;702:
;703:
;704:/*
;705:=================
;706:StopFollowing
;707:
;708:If the client being followed leaves the game, or you just want to drop
;709:to free floating spectator mode
;710:=================
;711:*/
;712:void StopFollowing( gentity_t *ent, qboolean release ) {
line 715
;713:	gclient_t *client;
;714:
;715:	if ( ent->r.svFlags & SVF_BOT || !ent->inuse )
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $363
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $361
LABELV $363
line 716
;716:		return;
ADDRGP4 $360
JUMPV
LABELV $361
line 718
;717:
;718:	client = ent->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 720
;719:
;720:	client->ps.persistant[ PERS_TEAM ] = TEAM_SPECTATOR;	
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
CNSTI4 3
ASGNI4
line 721
;721:	client->sess.sessionTeam = TEAM_SPECTATOR;	
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
CNSTI4 3
ASGNI4
line 722
;722:	if ( release ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $364
line 723
;723:		client->ps.stats[STAT_HEALTH] = ent->health = 1;
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 724
;724:		memset( client->ps.powerups, 0, sizeof ( client->ps.powerups ) );
ADDRLP4 0
INDIRP4
CNSTI4 312
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 725
;725:	}
LABELV $364
line 726
;726:	SetClientViewAngle( ent, client->ps.viewangles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 SetClientViewAngle
CALLV
pop
line 728
;727:
;728:	client->sess.spectatorState = SPECTATOR_FREE;
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
CNSTI4 1
ASGNI4
line 729
;729:	client->ps.pm_flags &= ~PMF_FOLLOW;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -4097
BANDI4
ASGNI4
line 732
;730:	//ent->r.svFlags &= ~SVF_BOT;
;731:
;732:	client->ps.clientNum = ent - g_entities;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
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
line 733
;733:}
LABELV $360
endproc StopFollowing 12 12
proc Cmd_Team_f 1036 12
line 741
;734:
;735:
;736:/*
;737:=================
;738:Cmd_Team_f
;739:=================
;740:*/
;741:static void Cmd_Team_f( gentity_t *ent ) {
line 744
;742:	char		s[MAX_TOKEN_CHARS];
;743:
;744:	if ( trap_Argc() != 2 ) {
ADDRLP4 1024
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1024
INDIRI4
CNSTI4 2
EQI4 $367
line 745
;745:		switch ( ent->client->sess.sessionTeam ) {
ADDRLP4 1028
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
LTI4 $366
ADDRLP4 1028
INDIRI4
CNSTI4 3
GTI4 $366
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $380
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $380
address $376
address $374
address $372
address $378
code
LABELV $372
line 747
;746:		case TEAM_BLUE:
;747:			trap_SendServerCommand( ent-g_entities, "print \"Blue team\n\"" );
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
ADDRGP4 $373
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 748
;748:			break;
ADDRGP4 $366
JUMPV
LABELV $374
line 750
;749:		case TEAM_RED:
;750:			trap_SendServerCommand( ent-g_entities, "print \"Red team\n\"" );
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
ADDRGP4 $375
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 751
;751:			break;
ADDRGP4 $366
JUMPV
LABELV $376
line 753
;752:		case TEAM_FREE:
;753:			trap_SendServerCommand( ent-g_entities, "print \"Free team\n\"" );
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
ADDRGP4 $377
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 754
;754:			break;
ADDRGP4 $366
JUMPV
LABELV $378
line 756
;755:		case TEAM_SPECTATOR:
;756:			trap_SendServerCommand( ent-g_entities, "print \"Spectator team\n\"" );
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
ADDRGP4 $379
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 757
;757:			break;
line 759
;758:		default:
;759:			break;
line 761
;760:		}
;761:		return;
ADDRGP4 $366
JUMPV
LABELV $367
line 764
;762:	}
;763:
;764:	if ( ent->client->switchTeamTime > level.time ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 768
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $381
line 765
;765:		trap_SendServerCommand( ent-g_entities, "print \"May not switch teams more than once per 5 seconds.\n\"" );
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
ADDRGP4 $384
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 766
;766:		return;
ADDRGP4 $366
JUMPV
LABELV $381
line 770
;767:	}
;768:
;769:	// if they are playing a tournement game, count as a loss
;770:	if ( (g_gametype.integer == GT_TOURNAMENT )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $385
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 0
NEI4 $385
line 771
;771:		&& ent->client->sess.sessionTeam == TEAM_FREE ) {
line 772
;772:		ent->client->sess.losses++;
ADDRLP4 1028
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 636
ADDP4
ASGNP4
ADDRLP4 1028
INDIRP4
ADDRLP4 1028
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 773
;773:	}
LABELV $385
line 775
;774:
;775:	trap_Argv( 1, s, sizeof( s ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 777
;776:
;777:	if ( SetTeam( ent, s ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1028
ADDRGP4 SetTeam
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
EQI4 $388
line 778
;778:		ent->client->switchTeamTime = level.time + 5000;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 768
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 779
;779:	}
LABELV $388
line 780
;780:}
LABELV $366
endproc Cmd_Team_f 1036 12
proc Cmd_Follow_f 1040 12
line 788
;781:
;782:
;783:/*
;784:=================
;785:Cmd_Follow_f
;786:=================
;787:*/
;788:static void Cmd_Follow_f( gentity_t *ent ) {
line 792
;789:	int		i;
;790:	char	arg[MAX_TOKEN_CHARS];
;791:
;792:	if ( trap_Argc() != 2 ) {
ADDRLP4 1028
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 2
EQI4 $392
line 793
;793:		if ( ent->client->sess.spectatorState == SPECTATOR_FOLLOW ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 2
NEI4 $391
line 794
;794:			StopFollowing( ent, qtrue );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 StopFollowing
CALLV
pop
line 795
;795:		}
line 796
;796:		return;
ADDRGP4 $391
JUMPV
LABELV $392
line 799
;797:	}
;798:
;799:	trap_Argv( 1, arg, sizeof( arg ) );
CNSTI4 1
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 800
;800:	i = ClientNumberFromString( ent, arg );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1032
ADDRGP4 ClientNumberFromString
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1032
INDIRI4
ASGNI4
line 801
;801:	if ( i == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $396
line 802
;802:		return;
ADDRGP4 $391
JUMPV
LABELV $396
line 806
;803:	}
;804:
;805:	// can't follow self
;806:	if ( &level.clients[ i ] == ent->client ) {
ADDRLP4 0
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CVPU4 4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
NEU4 $398
line 807
;807:		return;
ADDRGP4 $391
JUMPV
LABELV $398
line 811
;808:	}
;809:
;810:	// can't follow another spectator
;811:	if ( level.clients[ i ].sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
NEI4 $400
line 812
;812:		return;
ADDRGP4 $391
JUMPV
LABELV $400
line 816
;813:	}
;814:
;815:	// if they are playing a tournement game, count as a loss
;816:	if ( (g_gametype.integer == GT_TOURNAMENT )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $402
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 0
NEI4 $402
line 817
;817:		&& ent->client->sess.sessionTeam == TEAM_FREE ) {
line 818
;818:		ent->client->sess.losses++;
ADDRLP4 1036
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 636
ADDP4
ASGNP4
ADDRLP4 1036
INDIRP4
ADDRLP4 1036
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 819
;819:	}
LABELV $402
line 822
;820:
;821:	// first set them to spectator
;822:	if ( ent->client->sess.sessionTeam != TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
EQI4 $405
line 823
;823:		SetTeam( ent, "spectator" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $303
ARGP4
ADDRGP4 SetTeam
CALLI4
pop
line 824
;824:	}
LABELV $405
line 826
;825:
;826:	ent->client->sess.spectatorState = SPECTATOR_FOLLOW;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
CNSTI4 2
ASGNI4
line 827
;827:	ent->client->sess.spectatorClient = i;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 628
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 828
;828:}
LABELV $391
endproc Cmd_Follow_f 1040 12
export Cmd_FollowCycle_f
proc Cmd_FollowCycle_f 16 8
line 836
;829:
;830:
;831:/*
;832:=================
;833:Cmd_FollowCycle_f
;834:=================
;835:*/
;836:void Cmd_FollowCycle_f( gentity_t *ent, int dir ) {
line 842
;837:	int		clientnum;
;838:	int		original;
;839:	gclient_t	*client;
;840:
;841:	// if they are playing a tournement game, count as a loss
;842:	if ( (g_gametype.integer == GT_TOURNAMENT )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $408
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 0
NEI4 $408
line 843
;843:		&& ent->client->sess.sessionTeam == TEAM_FREE ) {
line 844
;844:		ent->client->sess.losses++;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 636
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 845
;845:	}
LABELV $408
line 847
;846:
;847:	client = ent->client;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
ASGNP4
line 850
;848:
;849:	// first set them to spectator
;850:	if ( client->sess.spectatorState == SPECTATOR_NOT ) {
ADDRLP4 8
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 0
NEI4 $411
line 851
;851:		SetTeam( ent, "spectator" );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $303
ARGP4
ADDRGP4 SetTeam
CALLI4
pop
line 852
;852:	}
LABELV $411
line 854
;853:
;854:	if ( dir != 1 && dir != -1 ) {
ADDRLP4 12
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 1
EQI4 $413
ADDRLP4 12
INDIRI4
CNSTI4 -1
EQI4 $413
line 855
;855:		G_Error( "Cmd_FollowCycle_f: bad dir %i", dir );
ADDRGP4 $415
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 G_Error
CALLV
pop
line 856
;856:	}
LABELV $413
line 858
;857:
;858:	clientnum = client->sess.spectatorClient;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 628
ADDP4
INDIRI4
ASGNI4
line 859
;859:	original = clientnum;
ADDRLP4 4
ADDRLP4 0
INDIRI4
ASGNI4
LABELV $416
line 860
;860:	do {
line 861
;861:		clientnum += dir;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 862
;862:		if ( clientnum >= level.maxclients ) {
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $419
line 863
;863:			clientnum = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 864
;864:		}
LABELV $419
line 865
;865:		if ( clientnum < 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $422
line 866
;866:			clientnum = level.maxclients - 1;
ADDRLP4 0
ADDRGP4 level+24
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 867
;867:		}
LABELV $422
line 870
;868:
;869:		// can only follow connected clients
;870:		if ( level.clients[ clientnum ].pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $425
line 871
;871:			continue;
ADDRGP4 $417
JUMPV
LABELV $425
line 875
;872:		}
;873:
;874:		// can't follow another spectator
;875:		if ( level.clients[ clientnum ].sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
NEI4 $427
line 876
;876:			continue;
ADDRGP4 $417
JUMPV
LABELV $427
line 880
;877:		}
;878:
;879:		// this is good, we can use it
;880:		ent->client->sess.spectatorClient = clientnum;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 628
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 881
;881:		ent->client->sess.spectatorState = SPECTATOR_FOLLOW;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
CNSTI4 2
ASGNI4
line 882
;882:		return;
ADDRGP4 $407
JUMPV
LABELV $417
line 883
;883:	} while ( clientnum != original );
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $416
line 886
;884:
;885:	// leave it where it was
;886:}
LABELV $407
endproc Cmd_FollowCycle_f 16 8
proc G_SayTo 12 28
line 894
;887:
;888:
;889:/*
;890:==================
;891:G_Say
;892:==================
;893:*/
;894:static void G_SayTo( gentity_t *ent, gentity_t *other, int mode, int color, const char *name, const char *message ) {
line 895
;895:	if (!other) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $430
line 896
;896:		return;
ADDRGP4 $429
JUMPV
LABELV $430
line 898
;897:	}
;898:	if (!other->inuse) {
ADDRFP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $432
line 899
;899:		return;
ADDRGP4 $429
JUMPV
LABELV $432
line 901
;900:	}
;901:	if (!other->client) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $434
line 902
;902:		return;
ADDRGP4 $429
JUMPV
LABELV $434
line 904
;903:	}
;904:	if ( other->client->pers.connected != CON_CONNECTED ) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $436
line 905
;905:		return;
ADDRGP4 $429
JUMPV
LABELV $436
line 907
;906:	}
;907:	if ( mode == SAY_TEAM  && !OnSameTeam(ent, other) ) {
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $438
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $438
line 908
;908:		return;
ADDRGP4 $429
JUMPV
LABELV $438
line 911
;909:	}
;910:	// no chatting to players in tournements
;911:	if ( (g_gametype.integer == GT_TOURNAMENT )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $440
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 0
NEI4 $440
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 0
EQI4 $440
line 913
;912:		&& other->client->sess.sessionTeam == TEAM_FREE
;913:		&& ent->client->sess.sessionTeam != TEAM_FREE ) {
line 914
;914:		return;
ADDRGP4 $429
JUMPV
LABELV $440
line 917
;915:	}
;916:
;917:	trap_SendServerCommand( other-g_entities, va( "%s \"%s%c%c%s\" %i", mode == SAY_TEAM ? "tchat" : "chat", 
ADDRGP4 $443
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $447
ADDRLP4 4
ADDRGP4 $444
ASGNP4
ADDRGP4 $448
JUMPV
LABELV $447
ADDRLP4 4
ADDRGP4 $445
ASGNP4
LABELV $448
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
CNSTI4 94
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 20
INDIRP4
ARGP4
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
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 g_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 824
DIVI4
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 919
;918:		name, Q_COLOR_ESCAPE, color, message, ent - g_entities ) );
;919:}
LABELV $429
endproc G_SayTo 12 28
proc G_Say 388 28
line 923
;920:
;921:#define EC		"\x19"
;922:
;923:static void G_Say( gentity_t *ent, gentity_t *target, int mode, const char *chatText ) {
line 932
;924:	int			j;
;925:	gentity_t	*other;
;926:	int			color;
;927:	char		name[64 + 64 + 12]; // name + location + formatting
;928:	// don't let text be too long for malicious reasons
;929:	char		text[MAX_SAY_TEXT];
;930:	char		location[64];
;931:
;932:	if ( g_gametype.integer < GT_TEAM && mode == SAY_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
GEI4 $450
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $450
line 933
;933:		mode = SAY_ALL;
ADDRFP4 8
CNSTI4 0
ASGNI4
line 934
;934:	}
LABELV $450
line 936
;935:
;936:	switch ( mode ) {
ADDRLP4 368
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 0
EQI4 $455
ADDRLP4 368
INDIRI4
CNSTI4 1
EQI4 $458
ADDRLP4 368
INDIRI4
CNSTI4 2
EQI4 $464
ADDRGP4 $453
JUMPV
LABELV $453
LABELV $455
line 939
;937:	default:
;938:	case SAY_ALL:
;939:		G_LogPrintf( "say: %s: %s\n", ent->client->pers.netname, chatText );
ADDRGP4 $456
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 940
;940:		Com_sprintf (name, sizeof(name), "%s%c%c"EC": ", ent->client->pers.netname, Q_COLOR_ESCAPE, COLOR_WHITE );
ADDRLP4 158
ARGP4
CNSTI4 140
ARGI4
ADDRGP4 $457
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
CNSTI4 94
ARGI4
CNSTI4 55
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 941
;941:		color = COLOR_GREEN;
ADDRLP4 300
CNSTI4 50
ASGNI4
line 942
;942:		break;
ADDRGP4 $454
JUMPV
LABELV $458
line 944
;943:	case SAY_TEAM:
;944:		G_LogPrintf( "sayteam: %s: %s\n", ent->client->pers.netname, chatText );
ADDRGP4 $459
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 945
;945:		if (Team_GetLocationMsg(ent, location, sizeof(location)))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 304
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 372
ADDRGP4 Team_GetLocationMsg
CALLI4
ASGNI4
ADDRLP4 372
INDIRI4
CNSTI4 0
EQI4 $460
line 946
;946:			Com_sprintf (name, sizeof(name), EC"(%s%c%c"EC") (%s)"EC": ", 
ADDRLP4 158
ARGP4
CNSTI4 140
ARGI4
ADDRGP4 $462
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
CNSTI4 94
ARGI4
CNSTI4 55
ARGI4
ADDRLP4 304
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
ADDRGP4 $461
JUMPV
LABELV $460
line 949
;947:				ent->client->pers.netname, Q_COLOR_ESCAPE, COLOR_WHITE, location);
;948:		else
;949:			Com_sprintf (name, sizeof(name), EC"(%s%c%c"EC")"EC": ", 
ADDRLP4 158
ARGP4
CNSTI4 140
ARGI4
ADDRGP4 $463
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
CNSTI4 94
ARGI4
CNSTI4 55
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
LABELV $461
line 951
;950:				ent->client->pers.netname, Q_COLOR_ESCAPE, COLOR_WHITE );
;951:		color = COLOR_CYAN;
ADDRLP4 300
CNSTI4 53
ASGNI4
line 952
;952:		break;
ADDRGP4 $454
JUMPV
LABELV $464
line 954
;953:	case SAY_TELL:
;954:		if (target && target->inuse && target->client && g_gametype.integer >= GT_TEAM &&
ADDRLP4 376
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 376
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $465
ADDRLP4 376
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $465
ADDRLP4 376
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $465
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $465
ADDRLP4 380
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 376
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
ADDRLP4 380
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
NEI4 $465
ADDRLP4 380
INDIRP4
ARGP4
ADDRLP4 304
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 384
ADDRGP4 Team_GetLocationMsg
CALLI4
ASGNI4
ADDRLP4 384
INDIRI4
CNSTI4 0
EQI4 $465
line 957
;955:			target->client->sess.sessionTeam == ent->client->sess.sessionTeam &&
;956:			Team_GetLocationMsg(ent, location, sizeof(location)))
;957:			Com_sprintf (name, sizeof(name), EC"[%s%c%c"EC"] (%s)"EC": ", ent->client->pers.netname, Q_COLOR_ESCAPE, COLOR_WHITE, location );
ADDRLP4 158
ARGP4
CNSTI4 140
ARGI4
ADDRGP4 $468
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
CNSTI4 94
ARGI4
CNSTI4 55
ARGI4
ADDRLP4 304
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
ADDRGP4 $466
JUMPV
LABELV $465
line 959
;958:		else
;959:			Com_sprintf (name, sizeof(name), EC"[%s%c%c"EC"]"EC": ", ent->client->pers.netname, Q_COLOR_ESCAPE, COLOR_WHITE );
ADDRLP4 158
ARGP4
CNSTI4 140
ARGI4
ADDRGP4 $469
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
CNSTI4 94
ARGI4
CNSTI4 55
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
LABELV $466
line 960
;960:		color = COLOR_MAGENTA;
ADDRLP4 300
CNSTI4 54
ASGNI4
line 961
;961:		break;
LABELV $454
line 964
;962:	}
;963:
;964:	Q_strncpyz( text, chatText, sizeof(text) );
ADDRLP4 8
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 150
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 966
;965:
;966:	if ( target ) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $470
line 967
;967:		G_SayTo( ent, target, mode, color, name, text );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 300
INDIRI4
ARGI4
ADDRLP4 158
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 G_SayTo
CALLV
pop
line 968
;968:		return;
ADDRGP4 $449
JUMPV
LABELV $470
line 972
;969:	}
;970:
;971:	// echo the text to the console
;972:	if ( g_dedicated.integer ) {
ADDRGP4 g_dedicated+12
INDIRI4
CNSTI4 0
EQI4 $472
line 973
;973:		G_Printf( "%s%s\n", name, text);
ADDRGP4 $475
ARGP4
ADDRLP4 158
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 974
;974:	}
LABELV $472
line 977
;975:
;976:	// send it to all the apropriate clients
;977:	for (j = 0; j < level.maxclients; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $479
JUMPV
LABELV $476
line 978
;978:		other = &g_entities[j];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 979
;979:		G_SayTo( ent, other, mode, color, name, text );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 300
INDIRI4
ARGI4
ADDRLP4 158
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 G_SayTo
CALLV
pop
line 980
;980:	}
LABELV $477
line 977
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $479
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $476
line 981
;981:}
LABELV $449
endproc G_Say 388 28
proc Cmd_Say_f 12 16
line 989
;982:
;983:
;984:/*
;985:==================
;986:Cmd_Say_f
;987:==================
;988:*/
;989:static void Cmd_Say_f( gentity_t *ent, int mode, qboolean arg0 ) {
line 992
;990:	char		*p;
;991:
;992:	if ( trap_Argc () < 2 && !arg0 ) {
ADDRLP4 4
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 2
GEI4 $482
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $482
line 993
;993:		return;
ADDRGP4 $481
JUMPV
LABELV $482
line 996
;994:	}
;995:
;996:	if (arg0)
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $484
line 997
;997:	{
line 998
;998:		p = ConcatArgs( 0 );
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 999
;999:	}
ADDRGP4 $485
JUMPV
LABELV $484
line 1001
;1000:	else
;1001:	{
line 1002
;1002:		p = ConcatArgs( 1 );
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 1003
;1003:	}
LABELV $485
line 1005
;1004:
;1005:	G_Say( ent, NULL, mode, p );
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_Say
CALLV
pop
line 1006
;1006:}
LABELV $481
endproc Cmd_Say_f 12 16
proc Cmd_Tell_f 1060 16
line 1014
;1007:
;1008:
;1009:/*
;1010:==================
;1011:Cmd_Tell_f
;1012:==================
;1013:*/
;1014:static void Cmd_Tell_f( gentity_t *ent ) {
line 1020
;1015:	int			targetNum;
;1016:	gentity_t	*target;
;1017:	char		*p;
;1018:	char		arg[MAX_TOKEN_CHARS];
;1019:
;1020:	if ( trap_Argc () < 2 ) {
ADDRLP4 1036
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 2
GEI4 $487
line 1021
;1021:		return;
ADDRGP4 $486
JUMPV
LABELV $487
line 1024
;1022:	}
;1023:
;1024:	trap_Argv( 1, arg, sizeof( arg ) );
CNSTI4 1
ARGI4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1025
;1025:	targetNum = atoi( arg );
ADDRLP4 12
ARGP4
ADDRLP4 1040
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 1040
INDIRI4
ASGNI4
line 1026
;1026:	if ( (unsigned)targetNum >= (unsigned)level.maxclients ) {
ADDRLP4 8
INDIRI4
CVIU4 4
ADDRGP4 level+24
INDIRI4
CVIU4 4
LTU4 $489
line 1027
;1027:		return;
ADDRGP4 $486
JUMPV
LABELV $489
line 1030
;1028:	}
;1029:
;1030:	target = &g_entities[targetNum];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1031
;1031:	if ( !target->inuse || !target->client ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $494
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $492
LABELV $494
line 1032
;1032:		return;
ADDRGP4 $486
JUMPV
LABELV $492
line 1035
;1033:	}
;1034:
;1035:	p = ConcatArgs( 2 );
CNSTI4 2
ARGI4
ADDRLP4 1048
ADDRGP4 ConcatArgs
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 1048
INDIRP4
ASGNP4
line 1037
;1036:
;1037:	G_LogPrintf( "tell: %s to %s: %s\n", ent->client->pers.netname, target->client->pers.netname, p );
ADDRGP4 $495
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1038
;1038:	G_Say( ent, target, SAY_TELL, p );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_Say
CALLV
pop
line 1041
;1039:	// don't tell to the player self if it was already directed to this player
;1040:	// also don't send the chat back to a bot
;1041:	if ( ent != target && !(ent->r.svFlags & SVF_BOT)) {
ADDRLP4 1052
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1052
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
EQU4 $496
ADDRLP4 1052
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $496
line 1042
;1042:		G_Say( ent, ent, SAY_TELL, p );
ADDRLP4 1056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
INDIRP4
ARGP4
ADDRLP4 1056
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_Say
CALLV
pop
line 1043
;1043:	}
LABELV $496
line 1044
;1044:}
LABELV $486
endproc Cmd_Tell_f 1060 16
data
align 4
LABELV gc_orders
address $498
address $499
address $500
address $501
address $502
address $503
address $504
export Cmd_GameCommand_f
code
proc Cmd_GameCommand_f 1044 16
line 1056
;1045:
;1046:static char	*gc_orders[] = {
;1047:	"hold your position",
;1048:	"hold this position",
;1049:	"come here",
;1050:	"cover me",
;1051:	"guard location",
;1052:	"search and destroy",
;1053:	"report"
;1054:};
;1055:
;1056:void Cmd_GameCommand_f( gentity_t *ent ) {
line 1061
;1057:	int		player;
;1058:	int		order;
;1059:	char	str[MAX_TOKEN_CHARS];
;1060:
;1061:	trap_Argv( 1, str, sizeof( str ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1062
;1062:	player = atoi( str );
ADDRLP4 0
ARGP4
ADDRLP4 1032
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 1032
INDIRI4
ASGNI4
line 1063
;1063:	trap_Argv( 2, str, sizeof( str ) );
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1064
;1064:	order = atoi( str );
ADDRLP4 0
ARGP4
ADDRLP4 1036
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1024
ADDRLP4 1036
INDIRI4
ASGNI4
line 1066
;1065:
;1066:	if ( (unsigned)player >= MAX_CLIENTS ) {
ADDRLP4 1028
INDIRI4
CVIU4 4
CNSTU4 64
LTU4 $506
line 1067
;1067:		return;
ADDRGP4 $505
JUMPV
LABELV $506
line 1069
;1068:	}
;1069:	if ( (unsigned) order > ARRAY_LEN( gc_orders ) ) {
ADDRLP4 1024
INDIRI4
CVIU4 4
CNSTU4 7
LEU4 $508
line 1070
;1070:		return;
ADDRGP4 $505
JUMPV
LABELV $508
line 1072
;1071:	}
;1072:	G_Say( ent, &g_entities[player], SAY_TELL, gc_orders[order] );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1028
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 1024
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gc_orders
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_Say
CALLV
pop
line 1073
;1073:	G_Say( ent, ent, SAY_TELL, gc_orders[order] );
ADDRLP4 1040
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1040
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRLP4 1024
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gc_orders
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_Say
CALLV
pop
line 1074
;1074:}
LABELV $505
endproc Cmd_GameCommand_f 1044 16
export Cmd_Where_f
proc Cmd_Where_f 8 8
line 1082
;1075:
;1076:
;1077:/*
;1078:==================
;1079:Cmd_Where_f
;1080:==================
;1081:*/
;1082:void Cmd_Where_f( gentity_t *ent ) {
line 1083
;1083:	trap_SendServerCommand( ent-g_entities, va("print \"%s\n\"", vtos( ent->s.origin ) ) );
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 vtos
CALLP4
ASGNP4
ADDRGP4 $511
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
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
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1084
;1084:}
LABELV $510
endproc Cmd_Where_f 8 8
data
align 4
LABELV voteCommands
address $512
address $513
address $514
address $515
address $516
address $517
address $518
address $519
address $520
address $521
address $522
address $523
code
proc ValidVoteCommand 320 12
line 1110
;1085:
;1086:static const char *voteCommands[] = {
;1087:	"map_restart",
;1088:	"map",
;1089:	"rotate",
;1090:	"nextmap",
;1091:	"kick",
;1092:	"clientkick",
;1093:	"g_gametype",
;1094:	"g_unlagged",
;1095:	"g_warmup",
;1096:	"timelimit",
;1097:	"fraglimit",
;1098:	"capturelimit"
;1099:};
;1100:
;1101:
;1102:/*
;1103:==================
;1104:ValidVoteCommand
;1105:
;1106:Input string can be modified by overwriting gametype number instead of text value, for example
;1107:==================
;1108:*/
;1109:static qboolean ValidVoteCommand( int clientNum, char *command ) 
;1110:{
line 1116
;1111:	char buf[ MAX_CVAR_VALUE_STRING ];
;1112:	char *base;
;1113:	char *s;
;1114:	int	i;
;1115:
;1116:	if ( strchr( command, ';' ) || strchr( command, '\n' ) || strchr( command, '\r' ) )
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 59
ARGI4
ADDRLP4 268
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 268
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $528
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 272
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 272
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $528
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 13
ARGI4
ADDRLP4 276
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 276
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $525
LABELV $528
line 1117
;1117:	{
line 1118
;1118:		trap_SendServerCommand( clientNum, "print \"Invalid vote command.\n\"" );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $529
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1119
;1119:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $524
JUMPV
LABELV $525
line 1122
;1120:	}
;1121:
;1122:	base = command;
ADDRLP4 264
ADDRFP4 4
INDIRP4
ASGNP4
line 1124
;1123:	
;1124:	s = buf; // extract command name
ADDRLP4 4
ADDRLP4 8
ASGNP4
ADDRGP4 $531
JUMPV
LABELV $530
line 1125
;1125:	while ( *command != '\0' && *command != ' ' ) {
line 1126
;1126:		*s = *command; s++; command++;
ADDRLP4 4
INDIRP4
ADDRFP4 4
INDIRP4
INDIRI1
ASGNI1
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRFP4 4
ADDRFP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1127
;1127:	}
LABELV $531
line 1125
ADDRLP4 280
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 0
EQI4 $533
ADDRLP4 280
INDIRI4
CNSTI4 32
NEI4 $530
LABELV $533
line 1128
;1128:	*s = '\0';
ADDRLP4 4
INDIRP4
CNSTI1 0
ASGNI1
ADDRGP4 $535
JUMPV
LABELV $534
line 1131
;1129:	// point cmd on first argument
;1130:	while ( *command == ' ' || *command == '\t' )
;1131:		command++;
ADDRFP4 4
ADDRFP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $535
line 1130
ADDRLP4 284
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 32
EQI4 $534
ADDRLP4 284
INDIRI4
CNSTI4 9
EQI4 $534
line 1133
;1132:
;1133:	for ( i = 0; i < ARRAY_LEN( voteCommands ); i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $540
JUMPV
LABELV $537
line 1134
;1134:		if ( !Q_stricmp( buf, voteCommands[i] ) ) {
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 voteCommands
ADDP4
INDIRP4
ARGP4
ADDRLP4 288
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
NEI4 $541
line 1135
;1135:			break;
ADDRGP4 $539
JUMPV
LABELV $541
line 1137
;1136:		}
;1137:	}
LABELV $538
line 1133
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $540
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 12
LTU4 $537
LABELV $539
line 1139
;1138:
;1139:	if ( i == ARRAY_LEN( voteCommands ) ) {
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 12
NEU4 $543
line 1140
;1140:		trap_SendServerCommand( clientNum, "print \"Invalid vote command.\nVote commands are: \n"
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $545
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1146
;1141:			" g_gametype <n|ffa|duel|tdm|ctf>\n"
;1142:			" map_restart, map <mapname>, rotate [round], nextmap\n"
;1143:			" kick <player>, clientkick <clientnum>\n"
;1144:			" g_unlagged <0|1>, g_warmup <-1|0|seconds>\n"
;1145:			" timelimit <time>, fraglimit <frags>, capturelimit <captures>.\n\"" );
;1146:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $524
JUMPV
LABELV $543
line 1149
;1147:	}
;1148:
;1149:	if ( Q_stricmp( buf, "g_gametype" ) == 0 )
ADDRLP4 8
ARGP4
ADDRGP4 $518
ARGP4
ADDRLP4 288
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 288
INDIRI4
CNSTI4 0
NEI4 $546
line 1150
;1150:	{
line 1151
;1151:		if ( !Q_stricmp( command, "ffa" ) ) i = GT_FFA;
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $550
ARGP4
ADDRLP4 292
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 0
NEI4 $548
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $549
JUMPV
LABELV $548
line 1152
;1152:		else if ( !Q_stricmp( command, "duel" ) ) i = GT_TOURNAMENT;
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $553
ARGP4
ADDRLP4 296
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 296
INDIRI4
CNSTI4 0
NEI4 $551
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $552
JUMPV
LABELV $551
line 1153
;1153:		else if ( !Q_stricmp( command, "tdm" ) ) i = GT_TEAM;
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $556
ARGP4
ADDRLP4 300
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 300
INDIRI4
CNSTI4 0
NEI4 $554
ADDRLP4 0
CNSTI4 3
ASGNI4
ADDRGP4 $555
JUMPV
LABELV $554
line 1154
;1154:		else if ( !Q_stricmp( command, "ctf" ) ) i = GT_CTF;
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $559
ARGP4
ADDRLP4 304
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 304
INDIRI4
CNSTI4 0
NEI4 $557
ADDRLP4 0
CNSTI4 5
ASGNI4
ADDRGP4 $558
JUMPV
LABELV $557
line 1156
;1155:		else 
;1156:		{
line 1157
;1157:			i = atoi( command );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 308
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 308
INDIRI4
ASGNI4
line 1158
;1158:			if( i == GT_SINGLE_PLAYER || i < GT_FFA || i >= GT_MAX_GAME_TYPE ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $563
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $563
ADDRLP4 0
INDIRI4
CNSTI4 9
LTI4 $560
LABELV $563
line 1159
;1159:				trap_SendServerCommand( clientNum, va( "print \"Invalid gametype %i.\n\"", i ) );
ADDRGP4 $564
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 316
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 316
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1160
;1160:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $524
JUMPV
LABELV $560
line 1162
;1161:			}
;1162:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $524
JUMPV
LABELV $558
LABELV $555
LABELV $552
LABELV $549
line 1166
;1163:		}
;1164:
;1165:		// handle string values
;1166:		BG_sprintf( base, "g_gametype %i", i );
ADDRLP4 264
INDIRP4
ARGP4
ADDRGP4 $565
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BG_sprintf
CALLI4
pop
line 1168
;1167:
;1168:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $524
JUMPV
LABELV $546
line 1171
;1169:	}
;1170:
;1171:	if ( Q_stricmp( buf, "map" ) == 0 ) {
ADDRLP4 8
ARGP4
ADDRGP4 $513
ARGP4
ADDRLP4 292
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 0
NEI4 $566
line 1172
;1172:		if ( !G_MapExist( command ) ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 296
ADDRGP4 G_MapExist
CALLI4
ASGNI4
ADDRLP4 296
INDIRI4
CNSTI4 0
NEI4 $568
line 1173
;1173:			trap_SendServerCommand( clientNum, va( "print \"No such map on server: %s.\n\"", command ) );
ADDRGP4 $570
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 300
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 300
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1174
;1174:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $524
JUMPV
LABELV $568
line 1176
;1175:		} 
;1176:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $524
JUMPV
LABELV $566
line 1179
;1177:	}
;1178:
;1179:	if ( Q_stricmp( buf, "nextmap" ) == 0 ) {
ADDRLP4 8
ARGP4
ADDRGP4 $515
ARGP4
ADDRLP4 296
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 296
INDIRI4
CNSTI4 0
NEI4 $571
line 1180
;1180:		strcpy( base, "rotate" );
ADDRLP4 264
INDIRP4
ARGP4
ADDRGP4 $514
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1181
;1181:	}
LABELV $571
line 1183
;1182:
;1183:	return qtrue;
CNSTI4 1
RETI4
LABELV $524
endproc ValidVoteCommand 320 12
export Cmd_CallVote_f
proc Cmd_CallVote_f 2108 16
line 1192
;1184:}
;1185:
;1186:
;1187:/*
;1188:==================
;1189:Cmd_CallVote_f
;1190:==================
;1191:*/
;1192:void Cmd_CallVote_f( gentity_t *ent ) {
line 1197
;1193:	int		i, n;
;1194:	char	arg[MAX_STRING_TOKENS], *argn[4];
;1195:	char	cmd[MAX_STRING_TOKENS], *s;
;1196:
;1197:	if ( !g_allowVote.integer ) {
ADDRGP4 g_allowVote+12
INDIRI4
CNSTI4 0
NEI4 $574
line 1198
;1198:		trap_SendServerCommand( ent-g_entities, "print \"Voting not allowed here.\n\"" );
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
ADDRGP4 $577
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1199
;1199:		return;
ADDRGP4 $573
JUMPV
LABELV $574
line 1202
;1200:	}
;1201:
;1202:	if ( level.voteTime ) {
ADDRGP4 level+872
INDIRI4
CNSTI4 0
EQI4 $578
line 1203
;1203:		trap_SendServerCommand( ent-g_entities, "print \"A vote is already in progress.\n\"" );
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
ADDRGP4 $581
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1204
;1204:		return;
ADDRGP4 $573
JUMPV
LABELV $578
line 1208
;1205:	}
;1206:
;1207:	// if there is still a vote to be executed
;1208:	if ( level.voteExecuteTime || level.restarted ) {
ADDRGP4 level+876
INDIRI4
CNSTI4 0
NEI4 $586
ADDRGP4 level+72
INDIRI4
CNSTI4 0
EQI4 $582
LABELV $586
line 1209
;1209:		trap_SendServerCommand( ent-g_entities, "print \"Previous vote command is waiting execution^1.^7\n\"" );
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
ADDRGP4 $587
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1210
;1210:		return;
ADDRGP4 $573
JUMPV
LABELV $582
line 1213
;1211:	}
;1212:
;1213:	if ( ent->client->pers.voteCount >= MAX_VOTE_COUNT ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 600
ADDP4
INDIRI4
CNSTI4 3
LTI4 $588
line 1214
;1214:		trap_SendServerCommand( ent-g_entities, "print \"You have called the maximum number of votes.\n\"" );
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
ADDRGP4 $590
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1215
;1215:		return;
ADDRGP4 $573
JUMPV
LABELV $588
line 1217
;1216:	}
;1217:	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
NEI4 $591
line 1218
;1218:		trap_SendServerCommand( ent-g_entities, "print \"Not allowed to call a vote as spectator.\n\"" );
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
ADDRGP4 $593
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1219
;1219:		return;
ADDRGP4 $573
JUMPV
LABELV $591
line 1223
;1220:	}
;1221:
;1222:	// build command buffer
;1223:	arg[ 0 ] = '\0'; s = arg;
ADDRLP4 1052
CNSTI1 0
ASGNI1
ADDRLP4 4
ADDRLP4 1052
ASGNP4
line 1224
;1224:	for ( i = 1; i < trap_Argc(); i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $597
JUMPV
LABELV $594
line 1225
;1225:		if ( arg[ 0 ] )
ADDRLP4 1052
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $598
line 1226
;1226:			s = Q_stradd( s, " " );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $600
ARGP4
ADDRLP4 2076
ADDRGP4 Q_stradd
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 2076
INDIRP4
ASGNP4
LABELV $598
line 1227
;1227:		trap_Argv( i, cmd, sizeof( cmd ) );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1228
;1228:		s = Q_stradd( s, cmd );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 2080
ADDRGP4 Q_stradd
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 2080
INDIRP4
ASGNP4
line 1229
;1229:	}
LABELV $595
line 1224
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $597
ADDRLP4 2076
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 2076
INDIRI4
LTI4 $594
line 1232
;1230:
;1231:	// split by ';' seperators
;1232:	n = Com_Split( arg, argn, ARRAY_LEN( argn ), ';' );
ADDRLP4 1052
ARGP4
ADDRLP4 1032
ARGP4
CNSTI4 4
ARGI4
CNSTI4 59
ARGI4
ADDRLP4 2080
ADDRGP4 Com_Split
CALLI4
ASGNI4
ADDRLP4 1048
ADDRLP4 2080
INDIRI4
ASGNI4
line 1233
;1233:	if ( n == 0 || *argn[0] == '\0' ) 
ADDRLP4 1048
INDIRI4
CNSTI4 0
EQI4 $603
ADDRLP4 1032
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $601
LABELV $603
line 1234
;1234:		return; // empty callvote command?
ADDRGP4 $573
JUMPV
LABELV $601
line 1237
;1235:
;1236:	// validate all split commands
;1237:	for ( i = 0; i < n; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $607
JUMPV
LABELV $604
line 1239
;1238:		// make sure it is a valid command to vote on
;1239:		if ( !ValidVoteCommand( ent - g_entities, argn[i] ) )
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
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1032
ADDP4
INDIRP4
ARGP4
ADDRLP4 2084
ADDRGP4 ValidVoteCommand
CALLI4
ASGNI4
ADDRLP4 2084
INDIRI4
CNSTI4 0
NEI4 $608
line 1240
;1240:			return;
ADDRGP4 $573
JUMPV
LABELV $608
line 1241
;1241:	}
LABELV $605
line 1237
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $607
ADDRLP4 0
INDIRI4
ADDRLP4 1048
INDIRI4
LTI4 $604
line 1244
;1242:
;1243:	// rebuild command buffer
;1244:	cmd[0] = '\0';
ADDRLP4 8
CNSTI1 0
ASGNI1
line 1245
;1245:	for ( s = cmd, i = 0; i < n; i++ ) {
ADDRLP4 4
ADDRLP4 8
ASGNP4
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $613
JUMPV
LABELV $610
line 1246
;1246:		if ( cmd[0] )
ADDRLP4 8
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $614
line 1247
;1247:			s = Q_stradd( s, ";" );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $616
ARGP4
ADDRLP4 2084
ADDRGP4 Q_stradd
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 2084
INDIRP4
ASGNP4
LABELV $614
line 1248
;1248:		s = Q_stradd( s, argn[ i ] );
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1032
ADDP4
INDIRP4
ARGP4
ADDRLP4 2088
ADDRGP4 Q_stradd
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 2088
INDIRP4
ASGNP4
line 1249
;1249:	}
LABELV $611
line 1245
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $613
ADDRLP4 0
INDIRI4
ADDRLP4 1048
INDIRI4
LTI4 $610
line 1251
;1250:
;1251:	Com_sprintf( level.voteString, sizeof( level.voteString ), cmd );
ADDRGP4 level+360
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1252
;1252:	Com_sprintf( level.voteDisplayString, sizeof( level.voteDisplayString ), "%s", level.voteString );
ADDRGP4 level+616
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $621
ARGP4
ADDRGP4 level+360
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 1254
;1253:
;1254:	trap_SendServerCommand( -1, va( "print \"%s called a vote(%s).\n\"", ent->client->pers.netname, cmd ) );
ADDRGP4 $623
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 2084
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 2084
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1257
;1255:
;1256:	// start the voting, the caller automatically votes yes
;1257:	level.voteTime = level.time;
ADDRGP4 level+872
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1258
;1258:	level.voteYes = 1;
ADDRGP4 level+880
CNSTI4 1
ASGNI4
line 1259
;1259:	level.voteNo = 0;
ADDRGP4 level+884
CNSTI4 0
ASGNI4
line 1261
;1260:
;1261:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $631
JUMPV
LABELV $628
line 1262
;1262:		level.clients[i].ps.eFlags &= ~EF_VOTED;
ADDRLP4 2088
ADDRLP4 0
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 2088
INDIRP4
ADDRLP4 2088
INDIRP4
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 1263
;1263:		level.clients[i].pers.voted = 0;
ADDRLP4 0
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 608
ADDP4
CNSTI4 0
ASGNI4
line 1264
;1264:	}
LABELV $629
line 1261
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $631
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $628
line 1266
;1265:
;1266:	ent->client->ps.eFlags |= EF_VOTED;
ADDRLP4 2088
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 2088
INDIRP4
ADDRLP4 2088
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 1267
;1267:	ent->client->pers.voted = 1;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 608
ADDP4
CNSTI4 1
ASGNI4
line 1269
;1268:
;1269:	ent->client->pers.voteCount++;
ADDRLP4 2092
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 600
ADDP4
ASGNP4
ADDRLP4 2092
INDIRP4
ADDRLP4 2092
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1271
;1270:
;1271:	trap_SetConfigstring( CS_VOTE_TIME, va("%i", level.voteTime ) );
ADDRGP4 $633
ARGP4
ADDRGP4 level+872
INDIRI4
ARGI4
ADDRLP4 2096
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 8
ARGI4
ADDRLP4 2096
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1272
;1272:	trap_SetConfigstring( CS_VOTE_STRING, level.voteDisplayString );	
CNSTI4 9
ARGI4
ADDRGP4 level+616
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1273
;1273:	trap_SetConfigstring( CS_VOTE_YES, va("%i", level.voteYes ) );
ADDRGP4 $633
ARGP4
ADDRGP4 level+880
INDIRI4
ARGI4
ADDRLP4 2100
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 10
ARGI4
ADDRLP4 2100
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1274
;1274:	trap_SetConfigstring( CS_VOTE_NO, va("%i", level.voteNo ) );	
ADDRGP4 $633
ARGP4
ADDRGP4 level+884
INDIRI4
ARGI4
ADDRLP4 2104
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 11
ARGI4
ADDRLP4 2104
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1275
;1275:}
LABELV $573
endproc Cmd_CallVote_f 2108 16
proc Cmd_Vote_f 80 12
line 1283
;1276:
;1277:
;1278:/*
;1279:==================
;1280:Cmd_Vote_f
;1281:==================
;1282:*/
;1283:static void Cmd_Vote_f( gentity_t *ent ) {
line 1286
;1284:	char		msg[64];
;1285:
;1286:	if ( !level.voteTime ) {
ADDRGP4 level+872
INDIRI4
CNSTI4 0
NEI4 $639
line 1287
;1287:		trap_SendServerCommand( ent-g_entities, "print \"No vote in progress.\n\"" );
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
ADDRGP4 $642
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1288
;1288:		return;
ADDRGP4 $638
JUMPV
LABELV $639
line 1291
;1289:	}
;1290:
;1291:	if ( ent->client->pers.voted != 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 608
ADDP4
INDIRI4
CNSTI4 0
EQI4 $643
line 1292
;1292:		trap_SendServerCommand( ent-g_entities, "print \"Vote already cast.\n\"" );
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
ADDRGP4 $645
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1293
;1293:		return;
ADDRGP4 $638
JUMPV
LABELV $643
line 1296
;1294:	}
;1295:
;1296:	if ( ent->client->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
NEI4 $646
line 1297
;1297:		trap_SendServerCommand( ent-g_entities, "print \"Not allowed to vote as spectator.\n\"" );
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
ADDRGP4 $648
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1298
;1298:		return;
ADDRGP4 $638
JUMPV
LABELV $646
line 1301
;1299:	}
;1300:
;1301:	trap_SendServerCommand( ent-g_entities, "print \"Vote cast.\n\"" );
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
ADDRGP4 $649
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1303
;1302:
;1303:	ent->client->ps.eFlags |= EF_VOTED;
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 1305
;1304:
;1305:	trap_Argv( 1, msg, sizeof( msg ) );
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1307
;1306:
;1307:	if ( msg[0] == 'y' || msg[0] == 'Y' || msg[0] == '1' ) {
ADDRLP4 68
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 121
EQI4 $653
ADDRLP4 68
INDIRI4
CNSTI4 89
EQI4 $653
ADDRLP4 68
INDIRI4
CNSTI4 49
NEI4 $650
LABELV $653
line 1308
;1308:		level.voteYes++;
ADDRLP4 72
ADDRGP4 level+880
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1309
;1309:		ent->client->pers.voted = 1;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 608
ADDP4
CNSTI4 1
ASGNI4
line 1310
;1310:		trap_SetConfigstring( CS_VOTE_YES, va( "%i", level.voteYes ) );
ADDRGP4 $633
ARGP4
ADDRGP4 level+880
INDIRI4
ARGI4
ADDRLP4 76
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 10
ARGI4
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1311
;1311:	} else {
ADDRGP4 $651
JUMPV
LABELV $650
line 1312
;1312:		level.voteNo++;
ADDRLP4 72
ADDRGP4 level+884
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1313
;1313:		ent->client->pers.voted = -1;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 608
ADDP4
CNSTI4 -1
ASGNI4
line 1314
;1314:		trap_SetConfigstring( CS_VOTE_NO, va( "%i", level.voteNo ) );	
ADDRGP4 $633
ARGP4
ADDRGP4 level+884
INDIRI4
ARGI4
ADDRLP4 76
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 11
ARGI4
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1315
;1315:	}
LABELV $651
line 1319
;1316:
;1317:	// a majority will be determined in CheckVote, which will also account
;1318:	// for players entering or leaving
;1319:}
LABELV $638
endproc Cmd_Vote_f 80 12
export G_RevertVote
proc G_RevertVote 12 8
line 1322
;1320:
;1321:
;1322:void G_RevertVote( gclient_t *client ) {
line 1323
;1323:	if ( level.voteTime ) {
ADDRGP4 level+872
INDIRI4
CNSTI4 0
EQI4 $659
line 1324
;1324:		if ( client->pers.voted == 1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 608
ADDP4
INDIRI4
CNSTI4 1
NEI4 $662
line 1325
;1325:			level.voteYes--;
ADDRLP4 0
ADDRGP4 level+880
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1326
;1326:			client->pers.voted = 0;
ADDRFP4 0
INDIRP4
CNSTI4 608
ADDP4
CNSTI4 0
ASGNI4
line 1327
;1327:			client->ps.eFlags &= ~EF_VOTED;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 1328
;1328:			trap_SetConfigstring( CS_VOTE_YES, va( "%i", level.voteYes ) );
ADDRGP4 $633
ARGP4
ADDRGP4 level+880
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 10
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1329
;1329:		} else if ( client->pers.voted == -1 ) {
ADDRGP4 $663
JUMPV
LABELV $662
ADDRFP4 0
INDIRP4
CNSTI4 608
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $666
line 1330
;1330:			level.voteNo--;
ADDRLP4 0
ADDRGP4 level+884
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1331
;1331:			client->pers.voted = 0;
ADDRFP4 0
INDIRP4
CNSTI4 608
ADDP4
CNSTI4 0
ASGNI4
line 1332
;1332:			client->ps.eFlags &= ~EF_VOTED;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 1333
;1333:			trap_SetConfigstring( CS_VOTE_NO, va( "%i", level.voteNo ) );
ADDRGP4 $633
ARGP4
ADDRGP4 level+884
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 11
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1334
;1334:		}
LABELV $666
LABELV $663
line 1335
;1335:	}
LABELV $659
line 1336
;1336:}
LABELV $658
endproc G_RevertVote 12 8
proc Cmd_SetViewpos_f 1060 12
line 1344
;1337:
;1338:
;1339:/*
;1340:=================
;1341:Cmd_SetViewpos_f
;1342:=================
;1343:*/
;1344:static void Cmd_SetViewpos_f( gentity_t *ent ) {
line 1349
;1345:	vec3_t		origin, angles;
;1346:	char		buffer[MAX_TOKEN_CHARS];
;1347:	int			i;
;1348:
;1349:	if ( !g_cheats.integer ) {
ADDRGP4 g_cheats+12
INDIRI4
CNSTI4 0
NEI4 $671
line 1350
;1350:		trap_SendServerCommand( ent-g_entities, "print \"Cheats are not enabled on this server.\n\"");
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
ADDRGP4 $93
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1351
;1351:		return;
ADDRGP4 $670
JUMPV
LABELV $671
line 1353
;1352:	}
;1353:	if ( trap_Argc() != 5 ) {
ADDRLP4 1052
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 5
EQI4 $674
line 1354
;1354:		trap_SendServerCommand( ent-g_entities, "print \"usage: setviewpos x y z yaw\n\"");
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
ADDRGP4 $676
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1355
;1355:		return;
ADDRGP4 $670
JUMPV
LABELV $674
line 1358
;1356:	}
;1357:
;1358:	VectorClear( angles );
ADDRLP4 1040
CNSTF4 0
ASGNF4
ADDRLP4 1040+4
CNSTF4 0
ASGNF4
ADDRLP4 1040+8
CNSTF4 0
ASGNF4
line 1359
;1359:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $679
line 1360
;1360:		trap_Argv( i + 1, buffer, sizeof( buffer ) );
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1361
;1361:		origin[i] = atof( buffer );
ADDRLP4 4
ARGP4
ADDRLP4 1056
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1028
ADDP4
ADDRLP4 1056
INDIRF4
ASGNF4
line 1362
;1362:	}
LABELV $680
line 1359
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $679
line 1364
;1363:
;1364:	trap_Argv( 4, buffer, sizeof( buffer ) );
CNSTI4 4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1365
;1365:	angles[YAW] = atof( buffer );
ADDRLP4 4
ARGP4
ADDRLP4 1056
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 1040+4
ADDRLP4 1056
INDIRF4
ASGNF4
line 1367
;1366:
;1367:	TeleportPlayer( ent, origin, angles );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1028
ARGP4
ADDRLP4 1040
ARGP4
ADDRGP4 TeleportPlayer
CALLV
pop
line 1368
;1368:}
LABELV $670
endproc Cmd_SetViewpos_f 1060 12
proc Cmd_Stats_f 0 0
line 1377
;1369:
;1370:
;1371:
;1372:/*
;1373:=================
;1374:Cmd_Stats_f
;1375:=================
;1376:*/
;1377:static void Cmd_Stats_f( gentity_t *ent ) {
line 1392
;1378:/*
;1379:	int max, n, i;
;1380:
;1381:	max = trap_AAS_PointReachabilityAreaIndex( NULL );
;1382:
;1383:	n = 0;
;1384:	for ( i = 0; i < max; i++ ) {
;1385:		if ( ent->client->areabits[i >> 3] & (1 << (i & 7)) )
;1386:			n++;
;1387:	}
;1388:
;1389:	//trap_SendServerCommand( ent-g_entities, va("print \"visited %d of %d areas\n\"", n, max));
;1390:	trap_SendServerCommand( ent-g_entities, va("print \"%d%% level coverage\n\"", n * 100 / max));
;1391:*/
;1392:}
LABELV $684
endproc Cmd_Stats_f 0 0
export ClientCommand
proc ClientCommand 1116 12
line 1400
;1393:
;1394:
;1395:/*
;1396:=================
;1397:ClientCommand
;1398:=================
;1399:*/
;1400:void ClientCommand( int clientNum ) {
line 1404
;1401:	gentity_t *ent;
;1402:	char	cmd[MAX_TOKEN_CHARS];
;1403:
;1404:	ent = g_entities + clientNum;
ADDRLP4 1024
ADDRFP4 0
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1405
;1405:	if ( !ent->client )
ADDRLP4 1024
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $686
line 1406
;1406:		return;
ADDRGP4 $685
JUMPV
LABELV $686
line 1408
;1407:
;1408:	trap_Argv( 0, cmd, sizeof( cmd ) );
CNSTI4 0
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 1410
;1409:
;1410:	if ( ent->client->pers.connected != CON_CONNECTED ) {
ADDRLP4 1024
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $688
line 1411
;1411:		if ( ent->client->pers.connected == CON_CONNECTING && g_gametype.integer >= GT_TEAM ) {
ADDRLP4 1024
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 1
NEI4 $685
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $685
line 1412
;1412:			if ( Q_stricmp( cmd, "team" ) == 0 && !level.restarted ) {
ADDRLP4 0
ARGP4
ADDRGP4 $695
ARGP4
ADDRLP4 1028
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
NEI4 $685
ADDRGP4 level+72
INDIRI4
CNSTI4 0
NEI4 $685
line 1413
;1413:				Cmd_Team_f( ent ); // early team override
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Team_f
CALLV
pop
line 1414
;1414:			}
line 1415
;1415:		}
line 1416
;1416:		return;	// not fully in game yet
ADDRGP4 $685
JUMPV
LABELV $688
line 1419
;1417:	}
;1418:
;1419:	if (Q_stricmp (cmd, "say") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $699
ARGP4
ADDRLP4 1028
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 0
NEI4 $697
line 1420
;1420:		Cmd_Say_f (ent, SAY_ALL, qfalse);
ADDRLP4 1024
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Cmd_Say_f
CALLV
pop
line 1421
;1421:		return;
ADDRGP4 $685
JUMPV
LABELV $697
line 1423
;1422:	}
;1423:	if (Q_stricmp (cmd, "say_team") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $702
ARGP4
ADDRLP4 1032
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $700
line 1424
;1424:		Cmd_Say_f (ent, SAY_TEAM, qfalse);
ADDRLP4 1024
INDIRP4
ARGP4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Cmd_Say_f
CALLV
pop
line 1425
;1425:		return;
ADDRGP4 $685
JUMPV
LABELV $700
line 1427
;1426:	}
;1427:	if (Q_stricmp (cmd, "tell") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $705
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $703
line 1428
;1428:		Cmd_Tell_f ( ent );
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Tell_f
CALLV
pop
line 1429
;1429:		return;
ADDRGP4 $685
JUMPV
LABELV $703
line 1431
;1430:	}
;1431:	if (Q_stricmp (cmd, "score") == 0) {
ADDRLP4 0
ARGP4
ADDRGP4 $293
ARGP4
ADDRLP4 1040
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $706
line 1432
;1432:		Cmd_Score_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Score_f
CALLV
pop
line 1433
;1433:		return;
ADDRGP4 $685
JUMPV
LABELV $706
line 1437
;1434:	}
;1435:
;1436:	// ignore all other commands when at intermission
;1437:	if (level.intermissiontime) {
ADDRGP4 level+5516
INDIRI4
CNSTI4 0
EQI4 $708
line 1438
;1438:		Cmd_Say_f (ent, qfalse, qtrue);
ADDRLP4 1024
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 Cmd_Say_f
CALLV
pop
line 1439
;1439:		return;
ADDRGP4 $685
JUMPV
LABELV $708
line 1442
;1440:	}
;1441:
;1442:	if (Q_stricmp (cmd, "give") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $713
ARGP4
ADDRLP4 1044
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $711
line 1443
;1443:		Cmd_Give_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Give_f
CALLV
pop
ADDRGP4 $712
JUMPV
LABELV $711
line 1444
;1444:	else if (Q_stricmp (cmd, "god") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $716
ARGP4
ADDRLP4 1048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $714
line 1445
;1445:		Cmd_God_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_God_f
CALLV
pop
ADDRGP4 $715
JUMPV
LABELV $714
line 1446
;1446:	else if (Q_stricmp (cmd, "notarget") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $719
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $717
line 1447
;1447:		Cmd_Notarget_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Notarget_f
CALLV
pop
ADDRGP4 $718
JUMPV
LABELV $717
line 1448
;1448:	else if (Q_stricmp (cmd, "noclip") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $722
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $720
line 1449
;1449:		Cmd_Noclip_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Noclip_f
CALLV
pop
ADDRGP4 $721
JUMPV
LABELV $720
line 1450
;1450:	else if (Q_stricmp (cmd, "kill") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $725
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $723
line 1451
;1451:		Cmd_Kill_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Kill_f
CALLV
pop
ADDRGP4 $724
JUMPV
LABELV $723
line 1452
;1452:	else if (Q_stricmp (cmd, "teamtask") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $229
ARGP4
ADDRLP4 1064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $726
line 1453
;1453:		Cmd_TeamTask_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_TeamTask_f
CALLV
pop
ADDRGP4 $727
JUMPV
LABELV $726
line 1454
;1454:	else if (Q_stricmp (cmd, "levelshot") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $730
ARGP4
ADDRLP4 1068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
NEI4 $728
line 1455
;1455:		Cmd_LevelShot_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_LevelShot_f
CALLV
pop
ADDRGP4 $729
JUMPV
LABELV $728
line 1456
;1456:	else if (Q_stricmp (cmd, "follow") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $733
ARGP4
ADDRLP4 1072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $731
line 1457
;1457:		Cmd_Follow_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Follow_f
CALLV
pop
ADDRGP4 $732
JUMPV
LABELV $731
line 1458
;1458:	else if (Q_stricmp (cmd, "follownext") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $736
ARGP4
ADDRLP4 1076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
NEI4 $734
line 1459
;1459:		Cmd_FollowCycle_f (ent, 1);
ADDRLP4 1024
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Cmd_FollowCycle_f
CALLV
pop
ADDRGP4 $735
JUMPV
LABELV $734
line 1460
;1460:	else if (Q_stricmp (cmd, "followprev") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $739
ARGP4
ADDRLP4 1080
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 0
NEI4 $737
line 1461
;1461:		Cmd_FollowCycle_f (ent, -1);
ADDRLP4 1024
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 Cmd_FollowCycle_f
CALLV
pop
ADDRGP4 $738
JUMPV
LABELV $737
line 1462
;1462:	else if (Q_stricmp (cmd, "team") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $695
ARGP4
ADDRLP4 1084
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1084
INDIRI4
CNSTI4 0
NEI4 $740
line 1463
;1463:		Cmd_Team_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Team_f
CALLV
pop
ADDRGP4 $741
JUMPV
LABELV $740
line 1464
;1464:	else if (Q_stricmp (cmd, "where") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $744
ARGP4
ADDRLP4 1088
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1088
INDIRI4
CNSTI4 0
NEI4 $742
line 1465
;1465:		Cmd_Where_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Where_f
CALLV
pop
ADDRGP4 $743
JUMPV
LABELV $742
line 1466
;1466:	else if (Q_stricmp (cmd, "callvote") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $747
ARGP4
ADDRLP4 1092
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1092
INDIRI4
CNSTI4 0
NEI4 $745
line 1467
;1467:		Cmd_CallVote_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_CallVote_f
CALLV
pop
ADDRGP4 $746
JUMPV
LABELV $745
line 1468
;1468:	else if (Q_stricmp (cmd, "vote") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $750
ARGP4
ADDRLP4 1096
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1096
INDIRI4
CNSTI4 0
NEI4 $748
line 1469
;1469:		Cmd_Vote_f (ent);
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Vote_f
CALLV
pop
ADDRGP4 $749
JUMPV
LABELV $748
line 1470
;1470:	else if (Q_stricmp (cmd, "gc") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $753
ARGP4
ADDRLP4 1100
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1100
INDIRI4
CNSTI4 0
NEI4 $751
line 1471
;1471:		Cmd_GameCommand_f( ent );
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_GameCommand_f
CALLV
pop
ADDRGP4 $752
JUMPV
LABELV $751
line 1472
;1472:	else if (Q_stricmp (cmd, "setviewpos") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $756
ARGP4
ADDRLP4 1104
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1104
INDIRI4
CNSTI4 0
NEI4 $754
line 1473
;1473:		Cmd_SetViewpos_f( ent );
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_SetViewpos_f
CALLV
pop
ADDRGP4 $755
JUMPV
LABELV $754
line 1474
;1474:	else if (Q_stricmp (cmd, "stats") == 0)
ADDRLP4 0
ARGP4
ADDRGP4 $759
ARGP4
ADDRLP4 1108
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 0
NEI4 $757
line 1475
;1475:		Cmd_Stats_f( ent );
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Cmd_Stats_f
CALLV
pop
ADDRGP4 $758
JUMPV
LABELV $757
line 1477
;1476:	else
;1477:		trap_SendServerCommand( clientNum, va( "print \"unknown cmd %s\n\"", cmd ) );
ADDRGP4 $760
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1112
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1112
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
LABELV $758
LABELV $755
LABELV $752
LABELV $749
LABELV $746
LABELV $743
LABELV $741
LABELV $738
LABELV $735
LABELV $732
LABELV $729
LABELV $727
LABELV $724
LABELV $721
LABELV $718
LABELV $715
LABELV $712
line 1478
;1478:}
LABELV $685
endproc ClientCommand 1116 12
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
import g_allowKill
import g_podiumDrop
import g_podiumDist
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
LABELV $760
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 99
byte 1 109
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $759
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $756
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
LABELV $753
byte 1 103
byte 1 99
byte 1 0
align 1
LABELV $750
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $747
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
LABELV $744
byte 1 119
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $739
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 0
align 1
LABELV $736
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $733
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $730
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
LABELV $725
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $722
byte 1 110
byte 1 111
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $719
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
LABELV $716
byte 1 103
byte 1 111
byte 1 100
byte 1 0
align 1
LABELV $713
byte 1 103
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $705
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $702
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
LABELV $699
byte 1 115
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $695
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $676
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 117
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
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
byte 1 32
byte 1 120
byte 1 32
byte 1 121
byte 1 32
byte 1 122
byte 1 32
byte 1 121
byte 1 97
byte 1 119
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $649
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 99
byte 1 97
byte 1 115
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $648
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 78
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $645
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 86
byte 1 111
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
byte 1 99
byte 1 97
byte 1 115
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $642
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 78
byte 1 111
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $633
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $623
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 97
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $621
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $616
byte 1 59
byte 1 0
align 1
LABELV $600
byte 1 32
byte 1 0
align 1
LABELV $593
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 78
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 97
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 115
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $590
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 99
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 109
byte 1 97
byte 1 120
byte 1 105
byte 1 109
byte 1 117
byte 1 109
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $587
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 80
byte 1 114
byte 1 101
byte 1 118
byte 1 105
byte 1 111
byte 1 117
byte 1 115
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 117
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 94
byte 1 49
byte 1 46
byte 1 94
byte 1 55
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $581
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 65
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 105
byte 1 115
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
byte 1 112
byte 1 114
byte 1 111
byte 1 103
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $577
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 86
byte 1 111
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $570
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 78
byte 1 111
byte 1 32
byte 1 115
byte 1 117
byte 1 99
byte 1 104
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $565
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
byte 1 0
align 1
LABELV $564
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
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
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $559
byte 1 99
byte 1 116
byte 1 102
byte 1 0
align 1
LABELV $556
byte 1 116
byte 1 100
byte 1 109
byte 1 0
align 1
LABELV $553
byte 1 100
byte 1 117
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $550
byte 1 102
byte 1 102
byte 1 97
byte 1 0
align 1
LABELV $545
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 46
byte 1 10
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 10
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
byte 1 60
byte 1 110
byte 1 124
byte 1 102
byte 1 102
byte 1 97
byte 1 124
byte 1 100
byte 1 117
byte 1 101
byte 1 108
byte 1 124
byte 1 116
byte 1 100
byte 1 109
byte 1 124
byte 1 99
byte 1 116
byte 1 102
byte 1 62
byte 1 10
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 44
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 32
byte 1 60
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 62
byte 1 44
byte 1 32
byte 1 114
byte 1 111
byte 1 116
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 91
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 93
byte 1 44
byte 1 32
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 109
byte 1 97
byte 1 112
byte 1 10
byte 1 32
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 60
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 62
byte 1 44
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 32
byte 1 60
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 110
byte 1 117
byte 1 109
byte 1 62
byte 1 10
byte 1 32
byte 1 103
byte 1 95
byte 1 117
byte 1 110
byte 1 108
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 60
byte 1 48
byte 1 124
byte 1 49
byte 1 62
byte 1 44
byte 1 32
byte 1 103
byte 1 95
byte 1 119
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 32
byte 1 60
byte 1 45
byte 1 49
byte 1 124
byte 1 48
byte 1 124
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 62
byte 1 10
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 60
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 62
byte 1 44
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 60
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 62
byte 1 44
byte 1 32
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
byte 1 32
byte 1 60
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 115
byte 1 62
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $529
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $523
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
LABELV $522
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
LABELV $521
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
LABELV $520
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
LABELV $519
byte 1 103
byte 1 95
byte 1 117
byte 1 110
byte 1 108
byte 1 97
byte 1 103
byte 1 103
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $518
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
LABELV $517
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $516
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $515
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $514
byte 1 114
byte 1 111
byte 1 116
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $513
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $512
byte 1 109
byte 1 97
byte 1 112
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $511
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $504
byte 1 114
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $503
byte 1 115
byte 1 101
byte 1 97
byte 1 114
byte 1 99
byte 1 104
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 114
byte 1 111
byte 1 121
byte 1 0
align 1
LABELV $502
byte 1 103
byte 1 117
byte 1 97
byte 1 114
byte 1 100
byte 1 32
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $501
byte 1 99
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $500
byte 1 99
byte 1 111
byte 1 109
byte 1 101
byte 1 32
byte 1 104
byte 1 101
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $499
byte 1 104
byte 1 111
byte 1 108
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
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
LABELV $498
byte 1 104
byte 1 111
byte 1 108
byte 1 100
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 32
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
LABELV $495
byte 1 116
byte 1 101
byte 1 108
byte 1 108
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $475
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $469
byte 1 25
byte 1 91
byte 1 37
byte 1 115
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 25
byte 1 93
byte 1 25
byte 1 58
byte 1 32
byte 1 0
align 1
LABELV $468
byte 1 25
byte 1 91
byte 1 37
byte 1 115
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 25
byte 1 93
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 25
byte 1 58
byte 1 32
byte 1 0
align 1
LABELV $463
byte 1 25
byte 1 40
byte 1 37
byte 1 115
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 25
byte 1 41
byte 1 25
byte 1 58
byte 1 32
byte 1 0
align 1
LABELV $462
byte 1 25
byte 1 40
byte 1 37
byte 1 115
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 25
byte 1 41
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 25
byte 1 58
byte 1 32
byte 1 0
align 1
LABELV $459
byte 1 115
byte 1 97
byte 1 121
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $457
byte 1 37
byte 1 115
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 25
byte 1 58
byte 1 32
byte 1 0
align 1
LABELV $456
byte 1 115
byte 1 97
byte 1 121
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $445
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $444
byte 1 116
byte 1 99
byte 1 104
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $443
byte 1 37
byte 1 115
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 37
byte 1 99
byte 1 37
byte 1 99
byte 1 37
byte 1 115
byte 1 34
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $415
byte 1 67
byte 1 109
byte 1 100
byte 1 95
byte 1 70
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 67
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 95
byte 1 102
byte 1 58
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 100
byte 1 105
byte 1 114
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $384
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 77
byte 1 97
byte 1 121
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
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
byte 1 111
byte 1 110
byte 1 99
byte 1 101
byte 1 32
byte 1 112
byte 1 101
byte 1 114
byte 1 32
byte 1 53
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $379
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 83
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $377
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $375
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $373
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $304
byte 1 115
byte 1 0
align 1
LABELV $303
byte 1 115
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
LABELV $300
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 50
byte 1 0
align 1
LABELV $297
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 49
byte 1 0
align 1
LABELV $293
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $292
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
LABELV $286
byte 1 98
byte 1 0
align 1
LABELV $285
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $281
byte 1 114
byte 1 0
align 1
LABELV $280
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $273
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
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
byte 1 34
byte 1 0
align 1
LABELV $268
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 109
byte 1 97
byte 1 110
byte 1 121
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
byte 1 34
byte 1 0
align 1
LABELV $257
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $254
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 116
byte 1 111
byte 1 114
byte 1 115
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $251
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 94
byte 1 52
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 94
byte 1 55
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $248
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 106
byte 1 111
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 94
byte 1 49
byte 1 114
byte 1 101
byte 1 100
byte 1 94
byte 1 55
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $239
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 75
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
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
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $230
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $229
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
LABELV $225
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
LABELV $224
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 117
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 97
byte 1 32
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 108
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $221
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 77
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 105
byte 1 110
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
byte 1 48
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $211
byte 1 110
byte 1 111
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 32
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $210
byte 1 110
byte 1 111
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 10
byte 1 0
align 1
LABELV $204
byte 1 110
byte 1 111
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $203
byte 1 110
byte 1 111
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 10
byte 1 0
align 1
LABELV $197
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $196
byte 1 103
byte 1 111
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 79
byte 1 78
byte 1 10
byte 1 0
align 1
LABELV $195
byte 1 103
byte 1 111
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 79
byte 1 70
byte 1 70
byte 1 10
byte 1 0
align 1
LABELV $183
byte 1 97
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $180
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $177
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 97
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $174
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
LABELV $171
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
LABELV $165
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $155
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $149
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $143
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $140
byte 1 97
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $134
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 85
byte 1 115
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $124
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $121
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 66
byte 1 97
byte 1 100
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $96
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 109
byte 1 117
byte 1 115
byte 1 116
byte 1 32
byte 1 98
byte 1 101
byte 1 32
byte 1 97
byte 1 108
byte 1 105
byte 1 118
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $93
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 67
byte 1 104
byte 1 101
byte 1 97
byte 1 116
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 111
byte 1 110
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
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $83
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $76
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
byte 1 0
align 1
LABELV $56
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 0

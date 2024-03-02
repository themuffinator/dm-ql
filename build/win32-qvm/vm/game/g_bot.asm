export trap_Cvar_VariableValue
code
proc trap_Cvar_VariableValue 132 12
file "..\..\..\..\code\game\g_bot.c"
line 32
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// g_bot.c
;4:
;5:#include "g_local.h"
;6:
;7:
;8:static int		g_numBots;
;9:static char		*g_botInfos[MAX_BOTS];
;10:
;11:
;12:int				g_numArenas;
;13:static char		*g_arenaInfos[MAX_ARENAS];
;14:
;15:
;16:#define BOT_BEGIN_DELAY_BASE		2000
;17:#define BOT_BEGIN_DELAY_INCREMENT	1500
;18:
;19:#define BOT_SPAWN_QUEUE_DEPTH	16
;20:
;21:typedef struct {
;22:	int		clientNum;
;23:	int		spawnTime;
;24:} botSpawnQueue_t;
;25:
;26:static botSpawnQueue_t	botSpawnQueue[BOT_SPAWN_QUEUE_DEPTH];
;27:
;28:vmCvar_t bot_minplayers;
;29:
;30:extern char mapname[ MAX_QPATH ];
;31:
;32:float trap_Cvar_VariableValue( const char *var_name ) {
line 35
;33:	char buf[128];
;34:
;35:	trap_Cvar_VariableStringBuffer(var_name, buf, sizeof(buf));
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
line 36
;36:	return atof(buf);
ADDRLP4 0
ARGP4
ADDRLP4 128
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 128
INDIRF4
RETF4
LABELV $56
endproc trap_Cvar_VariableValue 132 12
export G_ParseInfos
proc G_ParseInfos 2084 12
line 46
;37:}
;38:
;39:
;40:
;41:/*
;42:===============
;43:G_ParseInfos
;44:===============
;45:*/
;46:int G_ParseInfos( char *buf, int max, char *infos[] ) {
line 52
;47:	char	*token;
;48:	int		count;
;49:	char	key[MAX_TOKEN_CHARS];
;50:	char	info[MAX_INFO_STRING];
;51:
;52:	count = 0;
ADDRLP4 2052
CNSTI4 0
ASGNI4
ADDRGP4 $59
JUMPV
LABELV $58
line 54
;53:
;54:	while ( 1 ) {
line 55
;55:		token = COM_Parse( &buf );
ADDRFP4 0
ARGP4
ADDRLP4 2056
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2056
INDIRP4
ASGNP4
line 56
;56:		if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $61
line 57
;57:			break;
ADDRGP4 $60
JUMPV
LABELV $61
line 59
;58:		}
;59:		if ( strcmp( token, "{" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $65
ARGP4
ADDRLP4 2060
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2060
INDIRI4
CNSTI4 0
EQI4 $63
line 60
;60:			Com_Printf( "Missing { in info file\n" );
ADDRGP4 $66
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 61
;61:			break;
ADDRGP4 $60
JUMPV
LABELV $63
line 64
;62:		}
;63:
;64:		if ( count == max ) {
ADDRLP4 2052
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $67
line 65
;65:			Com_Printf( "Max infos exceeded\n" );
ADDRGP4 $69
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 66
;66:			break;
ADDRGP4 $60
JUMPV
LABELV $67
line 69
;67:		}
;68:
;69:		info[0] = '\0';
ADDRLP4 1028
CNSTI1 0
ASGNI1
ADDRGP4 $71
JUMPV
LABELV $70
line 70
;70:		while ( 1 ) {
line 71
;71:			token = COM_ParseExt( &buf, qtrue );
ADDRFP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 2064
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2064
INDIRP4
ASGNP4
line 72
;72:			if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $73
line 73
;73:				Com_Printf( "Unexpected end of info file\n" );
ADDRGP4 $75
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 74
;74:				break;
ADDRGP4 $72
JUMPV
LABELV $73
line 76
;75:			}
;76:			if ( !strcmp( token, "}" ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $78
ARGP4
ADDRLP4 2068
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
NEI4 $76
line 77
;77:				break;
ADDRGP4 $72
JUMPV
LABELV $76
line 79
;78:			}
;79:			Q_strncpyz( key, token, sizeof( key ) );
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 81
;80:
;81:			token = COM_ParseExt( &buf, qfalse );
ADDRFP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 2072
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2072
INDIRP4
ASGNP4
line 82
;82:			if ( !token[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $79
line 83
;83:				strcpy( token, "<NULL>" );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $81
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 84
;84:			}
LABELV $79
line 85
;85:			Info_SetValueForKey( info, key, token );
ADDRLP4 1028
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 86
;86:		}
LABELV $71
line 70
ADDRGP4 $70
JUMPV
LABELV $72
line 88
;87:		//NOTE: extra space for arena number
;88:		infos[count] = G_Alloc(strlen(info) + strlen("\\num\\") + strlen(va("%d", MAX_ARENAS)) + 1);
ADDRLP4 1028
ARGP4
ADDRLP4 2064
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRGP4 $82
ARGP4
ADDRLP4 2068
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRGP4 $83
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2072
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 2072
INDIRP4
ARGP4
ADDRLP4 2076
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 2064
INDIRI4
ADDRLP4 2068
INDIRI4
ADDI4
ADDRLP4 2076
INDIRI4
ADDI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 2080
ADDRGP4 G_Alloc
CALLP4
ASGNP4
ADDRLP4 2052
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
ADDRLP4 2080
INDIRP4
ASGNP4
line 89
;89:		if (infos[count]) {
ADDRLP4 2052
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $84
line 90
;90:			strcpy(infos[count], info);
ADDRLP4 2052
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1028
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 91
;91:			count++;
ADDRLP4 2052
ADDRLP4 2052
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 92
;92:		}
LABELV $84
line 93
;93:	}
LABELV $59
line 54
ADDRGP4 $58
JUMPV
LABELV $60
line 94
;94:	return count;
ADDRLP4 2052
INDIRI4
RETI4
LABELV $57
endproc G_ParseInfos 2084 12
proc G_LoadArenasFromFile 8216 16
line 103
;95:}
;96:
;97:
;98:/*
;99:===============
;100:G_LoadArenasFromFile
;101:===============
;102:*/
;103:static void G_LoadArenasFromFile( const char *filename ) {
line 108
;104:	int				len;
;105:	fileHandle_t	f;
;106:	char			buf[MAX_ARENAS_TEXT];
;107:
;108:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8200
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8200
INDIRI4
ASGNI4
line 109
;109:	if ( f == FS_INVALID_HANDLE ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $87
line 110
;110:		trap_Print( va( S_COLOR_RED "file not found: %s\n", filename ) );
ADDRGP4 $89
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8204
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8204
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 111
;111:		return;
ADDRGP4 $86
JUMPV
LABELV $87
line 113
;112:	}
;113:	if ( len >= MAX_ARENAS_TEXT ) {
ADDRLP4 0
INDIRI4
CNSTI4 8192
LTI4 $90
line 114
;114:		trap_Print( va( S_COLOR_RED "file too large: %s is %i, max allowed is %i", filename, len, MAX_ARENAS_TEXT ) );
ADDRGP4 $92
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 8192
ARGI4
ADDRLP4 8204
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8204
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 115
;115:		trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 116
;116:		return;
ADDRGP4 $86
JUMPV
LABELV $90
line 119
;117:	}
;118:
;119:	trap_FS_Read( buf, len, f );
ADDRLP4 8
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
line 120
;120:	buf[len] = 0;
ADDRLP4 0
INDIRI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 121
;121:	trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 123
;122:
;123:	g_numArenas += G_ParseInfos( buf, MAX_ARENAS - g_numArenas, &g_arenaInfos[g_numArenas] );
ADDRLP4 8
ARGP4
ADDRLP4 8204
ADDRGP4 g_numArenas
ASGNP4
ADDRLP4 8208
ADDRLP4 8204
INDIRP4
INDIRI4
ASGNI4
CNSTI4 1024
ADDRLP4 8208
INDIRI4
SUBI4
ARGI4
ADDRLP4 8208
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_arenaInfos
ADDP4
ARGP4
ADDRLP4 8212
ADDRGP4 G_ParseInfos
CALLI4
ASGNI4
ADDRLP4 8204
INDIRP4
ADDRLP4 8208
INDIRI4
ADDRLP4 8212
INDIRI4
ADDI4
ASGNI4
line 124
;124:}
LABELV $86
endproc G_LoadArenasFromFile 8216 16
proc G_LoadArenas 1456 16
line 132
;125:
;126:
;127:/*
;128:===============
;129:G_LoadArenas
;130:===============
;131:*/
;132:static void G_LoadArenas( void ) {
line 141
;133:	int			numdirs;
;134:	vmCvar_t	arenasFile;
;135:	char		filename[128];
;136:	char		dirlist[1024];
;137:	char*		dirptr;
;138:	int			i, n;
;139:	int			dirlen;
;140:
;141:	g_numArenas = 0;
ADDRGP4 g_numArenas
CNSTI4 0
ASGNI4
line 143
;142:
;143:	trap_Cvar_Register( &arenasFile, "g_arenasFile", "", CVAR_INIT|CVAR_ROM );
ADDRLP4 1172
ARGP4
ADDRGP4 $94
ARGP4
ADDRGP4 $95
ARGP4
CNSTI4 80
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 144
;144:	if( *arenasFile.string ) {
ADDRLP4 1172+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $96
line 145
;145:		G_LoadArenasFromFile(arenasFile.string);
ADDRLP4 1172+16
ARGP4
ADDRGP4 G_LoadArenasFromFile
CALLV
pop
line 146
;146:	}
ADDRGP4 $97
JUMPV
LABELV $96
line 147
;147:	else {
line 148
;148:		G_LoadArenasFromFile("scripts/arenas.txt");
ADDRGP4 $100
ARGP4
ADDRGP4 G_LoadArenasFromFile
CALLV
pop
line 149
;149:	}
LABELV $97
line 152
;150:
;151:	// get all arenas from .arena files
;152:	numdirs = trap_FS_GetFileList( "scripts", ".arena", dirlist, sizeof( dirlist ) );
ADDRGP4 $101
ARGP4
ADDRGP4 $102
ARGP4
ADDRLP4 148
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1444
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 144
ADDRLP4 1444
INDIRI4
ASGNI4
line 153
;153:	dirptr  = dirlist;
ADDRLP4 4
ADDRLP4 148
ASGNP4
line 154
;154:	for (i = 0; i < numdirs; i++, dirptr += dirlen+1) {
ADDRLP4 136
CNSTI4 0
ASGNI4
ADDRGP4 $106
JUMPV
LABELV $103
line 155
;155:		dirlen = (int)strlen(dirptr);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 1448
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 140
ADDRLP4 1448
INDIRI4
ASGNI4
line 156
;156:		strcpy(filename, "scripts/");
ADDRLP4 8
ARGP4
ADDRGP4 $107
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 157
;157:		strcat(filename, dirptr);
ADDRLP4 8
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 158
;158:		G_LoadArenasFromFile(filename);
ADDRLP4 8
ARGP4
ADDRGP4 G_LoadArenasFromFile
CALLV
pop
line 159
;159:	}
LABELV $104
line 154
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 4
INDIRP4
ADDP4
ASGNP4
LABELV $106
ADDRLP4 136
INDIRI4
ADDRLP4 144
INDIRI4
LTI4 $103
line 160
;160:	trap_Print( va( "%i arenas parsed\n", g_numArenas ) );
ADDRGP4 $108
ARGP4
ADDRGP4 g_numArenas
INDIRI4
ARGI4
ADDRLP4 1448
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1448
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 162
;161:	
;162:	for( n = 0; n < g_numArenas; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $112
JUMPV
LABELV $109
line 163
;163:		Info_SetValueForKey( g_arenaInfos[n], "num", va( "%i", n ) );
ADDRGP4 $114
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1452
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_arenaInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $113
ARGP4
ADDRLP4 1452
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 164
;164:	}
LABELV $110
line 162
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $112
ADDRLP4 0
INDIRI4
ADDRGP4 g_numArenas
INDIRI4
LTI4 $109
line 165
;165:}
LABELV $93
endproc G_LoadArenas 1456 16
export G_GetArenaInfoByMap
proc G_GetArenaInfoByMap 12 8
line 173
;166:
;167:
;168:/*
;169:===============
;170:G_GetArenaInfoByNumber
;171:===============
;172:*/
;173:const char *G_GetArenaInfoByMap( const char *map ) {
line 176
;174:	int			n;
;175:
;176:	for( n = 0; n < g_numArenas; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $119
JUMPV
LABELV $116
line 177
;177:		if( Q_stricmp( Info_ValueForKey( g_arenaInfos[n], "map" ), map ) == 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_arenaInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $122
ARGP4
ADDRLP4 4
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $120
line 178
;178:			return g_arenaInfos[n];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_arenaInfos
ADDP4
INDIRP4
RETP4
ADDRGP4 $115
JUMPV
LABELV $120
line 180
;179:		}
;180:	}
LABELV $117
line 176
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $119
ADDRLP4 0
INDIRI4
ADDRGP4 g_numArenas
INDIRI4
LTI4 $116
line 182
;181:
;182:	return NULL;
CNSTP4 0
RETP4
LABELV $115
endproc G_GetArenaInfoByMap 12 8
proc PlayerIntroSound 80 12
line 191
;183:}
;184:
;185:
;186:/*
;187:=================
;188:PlayerIntroSound
;189:=================
;190:*/
;191:static void PlayerIntroSound( const char *modelAndSkin ) {
line 195
;192:	char	model[MAX_QPATH];
;193:	char	*skin;
;194:
;195:	Q_strncpyz( model, modelAndSkin, sizeof(model) );
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 196
;196:	skin = Q_strrchr( model, '/' );
ADDRLP4 4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 68
ADDRGP4 Q_strrchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 68
INDIRP4
ASGNP4
line 197
;197:	if ( skin ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $124
line 198
;198:		*skin++ = '\0';
ADDRLP4 72
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 72
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI1 0
ASGNI1
line 199
;199:	}
ADDRGP4 $125
JUMPV
LABELV $124
line 200
;200:	else {
line 201
;201:		skin = model;
ADDRLP4 0
ADDRLP4 4
ASGNP4
line 202
;202:	}
LABELV $125
line 204
;203:
;204:	if( Q_stricmp( skin, "default" ) == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $128
ARGP4
ADDRLP4 72
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $126
line 205
;205:		skin = model;
ADDRLP4 0
ADDRLP4 4
ASGNP4
line 206
;206:	}
LABELV $126
line 208
;207:
;208:	trap_SendConsoleCommand( EXEC_APPEND, va( "play sound/player/announce/%s.wav\n", skin ) );
ADDRGP4 $129
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 209
;209:}
LABELV $123
endproc PlayerIntroSound 80 12
export G_AddRandomBot
proc G_AddRandomBot 96 16
line 217
;210:
;211:
;212:/*
;213:===============
;214:G_AddRandomBot
;215:===============
;216:*/
;217:void G_AddRandomBot( team_t team ) {
line 223
;218:	int		i, n, num;
;219:	float	skill;
;220:	char	*value, netname[36], *teamstr, *skillstr;
;221:	gclient_t	*cl;
;222:
;223:	num = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 224
;224:	for ( n = 0; n < g_numBots ; n++ ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $134
JUMPV
LABELV $131
line 225
;225:		value = Info_ValueForKey( g_botInfos[n], "name" );
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $135
ARGP4
ADDRLP4 68
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 68
INDIRP4
ASGNP4
line 227
;226:		//
;227:		for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $139
JUMPV
LABELV $136
line 228
;228:			cl = level.clients + i;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 229
;229:			if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $141
line 230
;230:				continue;
ADDRGP4 $137
JUMPV
LABELV $141
line 232
;231:			}
;232:			if ( !(g_entities[i].r.svFlags & SVF_BOT) ) {
ADDRLP4 0
INDIRI4
CNSTI4 832
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $143
line 233
;233:				continue;
ADDRGP4 $137
JUMPV
LABELV $143
line 235
;234:			}
;235:			if ( team >= 0 && cl->sess.sessionTeam != team ) {
ADDRLP4 72
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
LTI4 $147
ADDRLP4 4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
ADDRLP4 72
INDIRI4
EQI4 $147
line 236
;236:				continue;
ADDRGP4 $137
JUMPV
LABELV $147
line 238
;237:			}
;238:			if ( !Q_stricmp( value, cl->pers.netname ) ) {
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 76
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $149
line 239
;239:				break;
ADDRGP4 $138
JUMPV
LABELV $149
line 241
;240:			}
;241:		}
LABELV $137
line 227
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $139
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $136
LABELV $138
line 242
;242:		if (i >= level.maxclients) {
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $151
line 243
;243:			num++;
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 244
;244:		}
LABELV $151
line 245
;245:	}
LABELV $132
line 224
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $134
ADDRLP4 12
INDIRI4
ADDRGP4 g_numBots
INDIRI4
LTI4 $131
line 246
;246:	num = random() * num;
ADDRLP4 68
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 68
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ADDRLP4 20
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 247
;247:	for ( n = 0; n < g_numBots ; n++ ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $157
JUMPV
LABELV $154
line 249
;248:
;249:		value = Info_ValueForKey( g_botInfos[ n ], "name" );
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $135
ARGP4
ADDRLP4 72
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 72
INDIRP4
ASGNP4
line 251
;250:
;251:		skillstr = Info_ValueForKey( g_botInfos[ n ], "skill" );
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $158
ARGP4
ADDRLP4 76
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 76
INDIRP4
ASGNP4
line 252
;252:		if ( *skillstr )
ADDRLP4 16
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $159
line 253
;253:			skill = atof( skillstr );
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 80
INDIRF4
ASGNF4
ADDRGP4 $160
JUMPV
LABELV $159
line 255
;254:		else
;255:			skill = trap_Cvar_VariableValue( "g_spSkill" );
ADDRGP4 $161
ARGP4
ADDRLP4 84
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 84
INDIRF4
ASGNF4
LABELV $160
line 257
;256:
;257:		for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $165
JUMPV
LABELV $162
line 258
;258:			cl = level.clients + i;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 259
;259:			if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $167
line 260
;260:				continue;
ADDRGP4 $163
JUMPV
LABELV $167
line 262
;261:			}
;262:			if ( !(g_entities[i].r.svFlags & SVF_BOT) ) {
ADDRLP4 0
INDIRI4
CNSTI4 832
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $169
line 263
;263:				continue;
ADDRGP4 $163
JUMPV
LABELV $169
line 265
;264:			}
;265:			if ( team >= 0 && cl->sess.sessionTeam != team ) {
ADDRLP4 88
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
LTI4 $173
ADDRLP4 4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
ADDRLP4 88
INDIRI4
EQI4 $173
line 266
;266:				continue;
ADDRGP4 $163
JUMPV
LABELV $173
line 268
;267:			}
;268:			if ( !Q_stricmp( value, cl->pers.netname ) ) {
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRLP4 92
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $175
line 269
;269:				break;
ADDRGP4 $164
JUMPV
LABELV $175
line 271
;270:			}
;271:		}
LABELV $163
line 257
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $165
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $162
LABELV $164
line 272
;272:		if (i >= level.maxclients) {
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $177
line 273
;273:			num--;
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 274
;274:			if ( num <= 0 ) {
ADDRLP4 20
INDIRI4
CNSTI4 0
GTI4 $180
line 275
;275:				if (team == TEAM_RED) teamstr = "red";
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $182
ADDRLP4 64
ADDRGP4 $184
ASGNP4
ADDRGP4 $183
JUMPV
LABELV $182
line 276
;276:				else if (team == TEAM_BLUE) teamstr = "blue";
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $185
ADDRLP4 64
ADDRGP4 $187
ASGNP4
ADDRGP4 $186
JUMPV
LABELV $185
line 277
;277:				else teamstr = "";
ADDRLP4 64
ADDRGP4 $95
ASGNP4
LABELV $186
LABELV $183
line 278
;278:				Q_strncpyz(netname, value, sizeof(netname));
ADDRLP4 28
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 279
;279:				Q_CleanStr(netname);
ADDRLP4 28
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 280
;280:				trap_SendConsoleCommand( EXEC_INSERT, va( "addbot %s %1.2f %s 0\n", netname, skill, teamstr ) );
ADDRGP4 $188
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 88
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 88
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 281
;281:				return;
ADDRGP4 $130
JUMPV
LABELV $180
line 283
;282:			}
;283:		}
LABELV $177
line 284
;284:	}
LABELV $155
line 247
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $157
ADDRLP4 12
INDIRI4
ADDRGP4 g_numBots
INDIRI4
LTI4 $154
line 285
;285:}
LABELV $130
endproc G_AddRandomBot 96 16
export G_RemoveRandomBot
proc G_RemoveRandomBot 52 8
line 293
;286:
;287:
;288:/*
;289:===============
;290:G_RemoveRandomBot
;291:===============
;292:*/
;293:int G_RemoveRandomBot( int team ) {
line 298
;294:	int i;
;295:	char netname[36];
;296:	gclient_t	*cl;
;297:
;298:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $193
JUMPV
LABELV $190
line 299
;299:		cl = level.clients + i;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 300
;300:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $195
line 301
;301:			continue;
ADDRGP4 $191
JUMPV
LABELV $195
line 303
;302:		}
;303:		if ( !(g_entities[i].r.svFlags & SVF_BOT) ) {
ADDRLP4 0
INDIRI4
CNSTI4 832
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $197
line 304
;304:			continue;
ADDRGP4 $191
JUMPV
LABELV $197
line 306
;305:		}
;306:		if ( team >= 0 && cl->sess.sessionTeam != team ) {
ADDRLP4 44
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
LTI4 $201
ADDRLP4 4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
ADDRLP4 44
INDIRI4
EQI4 $201
line 307
;307:			continue;
ADDRGP4 $191
JUMPV
LABELV $201
line 309
;308:		}
;309:		strcpy(netname, cl->pers.netname);
ADDRLP4 8
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 508
ADDP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 310
;310:		Q_CleanStr(netname);
ADDRLP4 8
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 311
;311:		trap_SendConsoleCommand( EXEC_INSERT, va("kick %s\n", netname) );
ADDRGP4 $203
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 312
;312:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $189
JUMPV
LABELV $191
line 298
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $193
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $190
line 314
;313:	}
;314:	return qfalse;
CNSTI4 0
RETI4
LABELV $189
endproc G_RemoveRandomBot 52 8
proc G_CountHumanPlayers 16 0
line 323
;315:}
;316:
;317:
;318:/*
;319:===============
;320:G_CountHumanPlayers
;321:===============
;322:*/
;323:static int G_CountHumanPlayers( team_t team ) {
line 327
;324:	int i, num;
;325:	gclient_t	*cl;
;326:
;327:	num = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 328
;328:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $208
JUMPV
LABELV $205
line 329
;329:		cl = level.clients + i;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 330
;330:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $210
line 331
;331:			continue;
ADDRGP4 $206
JUMPV
LABELV $210
line 333
;332:		}
;333:		if ( g_entities[i].r.svFlags & SVF_BOT ) {
ADDRLP4 0
INDIRI4
CNSTI4 832
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $212
line 334
;334:			continue;
ADDRGP4 $206
JUMPV
LABELV $212
line 336
;335:		}
;336:		if ( team >= 0 && cl->sess.sessionTeam != team ) {
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $216
ADDRLP4 4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $216
line 337
;337:			continue;
ADDRGP4 $206
JUMPV
LABELV $216
line 339
;338:		}
;339:		num++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 340
;340:	}
LABELV $206
line 328
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $208
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $205
line 341
;341:	return num;
ADDRLP4 8
INDIRI4
RETI4
LABELV $204
endproc G_CountHumanPlayers 16 0
proc G_CountBotPlayers 20 0
line 350
;342:}
;343:
;344:
;345:/*
;346:===============
;347:G_CountBotPlayers
;348:===============
;349:*/
;350:static int G_CountBotPlayers( team_t team ) {
line 354
;351:	int i, n, num;
;352:	gclient_t	*cl;
;353:
;354:	num = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 355
;355:	for ( i=0 ; i< level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $222
JUMPV
LABELV $219
line 356
;356:		cl = level.clients + i;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 357
;357:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 8
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $224
line 358
;358:			continue;
ADDRGP4 $220
JUMPV
LABELV $224
line 360
;359:		}
;360:		if ( !(g_entities[i].r.svFlags & SVF_BOT) ) {
ADDRLP4 0
INDIRI4
CNSTI4 832
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $226
line 361
;361:			continue;
ADDRGP4 $220
JUMPV
LABELV $226
line 363
;362:		}
;363:		if ( team >= 0 && cl->sess.sessionTeam != team ) {
ADDRLP4 16
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
LTI4 $230
ADDRLP4 8
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $230
line 364
;364:			continue;
ADDRGP4 $220
JUMPV
LABELV $230
line 366
;365:		}
;366:		num++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 367
;367:	}
LABELV $220
line 355
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $222
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $219
line 368
;368:	for( n = 0; n < BOT_SPAWN_QUEUE_DEPTH; n++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $232
line 369
;369:		if( !botSpawnQueue[n].spawnTime ) {
ADDRLP4 4
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $236
line 370
;370:			continue;
ADDRGP4 $233
JUMPV
LABELV $236
line 372
;371:		}
;372:		if ( botSpawnQueue[n].spawnTime > level.time ) {
ADDRLP4 4
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $239
line 373
;373:			continue;
ADDRGP4 $233
JUMPV
LABELV $239
line 375
;374:		}
;375:		num++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 376
;376:	}
LABELV $233
line 368
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 16
LTI4 $232
line 377
;377:	return num;
ADDRLP4 12
INDIRI4
RETI4
LABELV $218
endproc G_CountBotPlayers 20 0
bss
align 4
LABELV $244
skip 4
export G_CheckMinimumPlayers
code
proc G_CheckMinimumPlayers 36 4
line 386
;378:}
;379:
;380:
;381:/*
;382:===============
;383:G_CheckMinimumPlayers
;384:===============
;385:*/
;386:void G_CheckMinimumPlayers( void ) {
line 391
;387:	int minplayers;
;388:	int humanplayers, botplayers;
;389:	static int checkminimumplayers_time;
;390:
;391:	if ( level.intermissiontime )
ADDRGP4 level+5520
INDIRI4
CNSTI4 0
EQI4 $245
line 392
;392:		return;
ADDRGP4 $243
JUMPV
LABELV $245
line 395
;393:
;394:	//only check once each 10 seconds
;395:	if ( checkminimumplayers_time > level.time - 10000 )
ADDRGP4 $244
INDIRI4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
SUBI4
LEI4 $248
line 396
;396:		return;
ADDRGP4 $243
JUMPV
LABELV $248
line 398
;397:
;398:	if ( level.time - level.startTime < 2000 )
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+40
INDIRI4
SUBI4
CNSTI4 2000
GEI4 $251
line 399
;399:		return;
ADDRGP4 $243
JUMPV
LABELV $251
line 401
;400:
;401:	checkminimumplayers_time = level.time;
ADDRGP4 $244
ADDRGP4 level+32
INDIRI4
ASGNI4
line 402
;402:	trap_Cvar_Update(&bot_minplayers);
ADDRGP4 bot_minplayers
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 403
;403:	minplayers = bot_minplayers.integer;
ADDRLP4 0
ADDRGP4 bot_minplayers+12
INDIRI4
ASGNI4
line 404
;404:	if (minplayers <= 0) return;
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $257
ADDRGP4 $243
JUMPV
LABELV $257
line 406
;405:
;406:	if (g_gametype.integer >= GT_TEAM) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $259
line 407
;407:		if (minplayers >= level.maxclients / 2) {
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
CNSTI4 2
DIVI4
LTI4 $262
line 408
;408:			minplayers = (level.maxclients / 2) -1;
ADDRLP4 0
ADDRGP4 level+24
INDIRI4
CNSTI4 2
DIVI4
CNSTI4 1
SUBI4
ASGNI4
line 409
;409:		}
LABELV $262
line 411
;410:
;411:		humanplayers = G_CountHumanPlayers( TEAM_RED );
CNSTI4 1
ARGI4
ADDRLP4 12
ADDRGP4 G_CountHumanPlayers
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 412
;412:		botplayers = G_CountBotPlayers(	TEAM_RED );
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 G_CountBotPlayers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 414
;413:		//
;414:		if (humanplayers + botplayers < minplayers) {
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
GEI4 $266
line 415
;415:			G_AddRandomBot( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 G_AddRandomBot
CALLV
pop
line 416
;416:		} else if (humanplayers + botplayers > minplayers && botplayers) {
ADDRGP4 $267
JUMPV
LABELV $266
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
LEI4 $268
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $268
line 417
;417:			G_RemoveRandomBot( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 G_RemoveRandomBot
CALLI4
pop
line 418
;418:		}
LABELV $268
LABELV $267
line 420
;419:		//
;420:		humanplayers = G_CountHumanPlayers( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRLP4 24
ADDRGP4 G_CountHumanPlayers
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 24
INDIRI4
ASGNI4
line 421
;421:		botplayers = G_CountBotPlayers( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRLP4 28
ADDRGP4 G_CountBotPlayers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 28
INDIRI4
ASGNI4
line 423
;422:		//
;423:		if (humanplayers + botplayers < minplayers) {
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
GEI4 $270
line 424
;424:			G_AddRandomBot( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 G_AddRandomBot
CALLV
pop
line 425
;425:		} else if (humanplayers + botplayers > minplayers && botplayers) {
ADDRGP4 $260
JUMPV
LABELV $270
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
LEI4 $260
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $260
line 426
;426:			G_RemoveRandomBot( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 G_RemoveRandomBot
CALLI4
pop
line 427
;427:		}
line 428
;428:	}
ADDRGP4 $260
JUMPV
LABELV $259
line 429
;429:	else if (g_gametype.integer == GT_DUEL ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $274
line 430
;430:		if (minplayers >= level.maxclients) {
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $277
line 431
;431:			minplayers = level.maxclients-1;
ADDRLP4 0
ADDRGP4 level+24
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 432
;432:		}
LABELV $277
line 433
;433:		humanplayers = G_CountHumanPlayers( -1 );
CNSTI4 -1
ARGI4
ADDRLP4 12
ADDRGP4 G_CountHumanPlayers
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 434
;434:		botplayers = G_CountBotPlayers( -1 );
CNSTI4 -1
ARGI4
ADDRLP4 16
ADDRGP4 G_CountBotPlayers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 436
;435:		//
;436:		if (humanplayers + botplayers < minplayers) {
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
GEI4 $281
line 437
;437:			G_AddRandomBot( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 G_AddRandomBot
CALLV
pop
line 438
;438:		} else if (humanplayers + botplayers > minplayers && botplayers) {
ADDRGP4 $275
JUMPV
LABELV $281
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
LEI4 $275
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $275
line 440
;439:			// try to remove spectators first
;440:			if (!G_RemoveRandomBot( TEAM_SPECTATOR )) {
CNSTI4 3
ARGI4
ADDRLP4 24
ADDRGP4 G_RemoveRandomBot
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $275
line 442
;441:				// just remove the bot that is playing
;442:				G_RemoveRandomBot( -1 );
CNSTI4 -1
ARGI4
ADDRGP4 G_RemoveRandomBot
CALLI4
pop
line 443
;443:			}
line 444
;444:		}
line 445
;445:	}
ADDRGP4 $275
JUMPV
LABELV $274
line 446
;446:	else if (g_gametype.integer == GT_FFA) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 0
NEI4 $287
line 447
;447:		if (minplayers >= level.maxclients) {
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $290
line 448
;448:			minplayers = level.maxclients-1;
ADDRLP4 0
ADDRGP4 level+24
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 449
;449:		}
LABELV $290
line 450
;450:		humanplayers = G_CountHumanPlayers( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRLP4 12
ADDRGP4 G_CountHumanPlayers
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 451
;451:		botplayers = G_CountBotPlayers( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRLP4 16
ADDRGP4 G_CountBotPlayers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 453
;452:		//
;453:		if (humanplayers + botplayers < minplayers) {
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
GEI4 $294
line 454
;454:			G_AddRandomBot( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 G_AddRandomBot
CALLV
pop
line 455
;455:		} else if (humanplayers + botplayers > minplayers && botplayers) {
ADDRGP4 $295
JUMPV
LABELV $294
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ADDRLP4 0
INDIRI4
LEI4 $296
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $296
line 456
;456:			G_RemoveRandomBot( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 G_RemoveRandomBot
CALLI4
pop
line 457
;457:		}
LABELV $296
LABELV $295
line 458
;458:	}
LABELV $287
LABELV $275
LABELV $260
line 459
;459:}
LABELV $243
endproc G_CheckMinimumPlayers 36 4
export G_CheckBotSpawn
proc G_CheckBotSpawn 1028 4
line 467
;460:
;461:
;462:/*
;463:===============
;464:G_CheckBotSpawn
;465:===============
;466:*/
;467:void G_CheckBotSpawn( void ) {
line 471
;468:	int		n;
;469:	char	userinfo[MAX_INFO_VALUE];
;470:
;471:	G_CheckMinimumPlayers();
ADDRGP4 G_CheckMinimumPlayers
CALLV
pop
line 473
;472:
;473:	for( n = 0; n < BOT_SPAWN_QUEUE_DEPTH; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $299
line 474
;474:		if( !botSpawnQueue[n].spawnTime ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $303
line 475
;475:			continue;
ADDRGP4 $300
JUMPV
LABELV $303
line 477
;476:		}
;477:		if ( botSpawnQueue[n].spawnTime > level.time ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $306
line 478
;478:			continue;
ADDRGP4 $300
JUMPV
LABELV $306
line 480
;479:		}
;480:		ClientBegin( botSpawnQueue[n].clientNum );
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue
ADDP4
INDIRI4
ARGI4
ADDRGP4 ClientBegin
CALLV
pop
line 481
;481:		botSpawnQueue[n].spawnTime = 0;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
CNSTI4 0
ASGNI4
line 482
;482:	}
LABELV $300
line 473
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $299
line 483
;483:}
LABELV $298
endproc G_CheckBotSpawn 1028 4
proc AddBotToSpawnQueue 4 4
line 491
;484:
;485:
;486:/*
;487:===============
;488:AddBotToSpawnQueue
;489:===============
;490:*/
;491:static void AddBotToSpawnQueue( int clientNum, int delay ) {
line 494
;492:	int		n;
;493:
;494:	for( n = 0; n < BOT_SPAWN_QUEUE_DEPTH; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $312
line 495
;495:		if( !botSpawnQueue[n].spawnTime ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $316
line 496
;496:			botSpawnQueue[n].spawnTime = level.time + delay;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 497
;497:			botSpawnQueue[n].clientNum = clientNum;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 498
;498:			return;
ADDRGP4 $311
JUMPV
LABELV $316
line 500
;499:		}
;500:	}
LABELV $313
line 494
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $312
line 502
;501:
;502:	G_Printf( S_COLOR_YELLOW "Unable to delay bot spawn\n" );
ADDRGP4 $321
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 504
;503:
;504:	ClientBegin( clientNum );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 ClientBegin
CALLV
pop
line 505
;505:}
LABELV $311
endproc AddBotToSpawnQueue 4 4
export G_RemoveQueuedBotBegin
proc G_RemoveQueuedBotBegin 4 0
line 516
;506:
;507:
;508:/*
;509:===============
;510:G_RemoveQueuedBotBegin
;511:
;512:Called on client disconnect to make sure the delayed spawn
;513:doesn't happen on a freed index
;514:===============
;515:*/
;516:void G_RemoveQueuedBotBegin( int clientNum ) {
line 519
;517:	int		n;
;518:
;519:	for( n = 0; n < BOT_SPAWN_QUEUE_DEPTH; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $323
line 520
;520:		if( botSpawnQueue[n].clientNum == clientNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $327
line 521
;521:			botSpawnQueue[n].spawnTime = 0;
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 botSpawnQueue+4
ADDP4
CNSTI4 0
ASGNI4
line 522
;522:			return;
ADDRGP4 $322
JUMPV
LABELV $327
line 524
;523:		}
;524:	}
LABELV $324
line 519
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $323
line 525
;525:}
LABELV $322
endproc G_RemoveQueuedBotBegin 4 0
export G_BotConnect
proc G_BotConnect 1336 12
line 533
;526:
;527:
;528:/*
;529:===============
;530:G_BotConnect
;531:===============
;532:*/
;533:qboolean G_BotConnect( int clientNum, qboolean restart ) {
line 537
;534:	bot_settings_t	settings;
;535:	char			userinfo[MAX_INFO_STRING];
;536:
;537:	trap_GetUserinfo( clientNum, userinfo, sizeof(userinfo) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 292
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetUserinfo
CALLV
pop
line 539
;538:
;539:	Q_strncpyz( settings.characterfile, Info_ValueForKey( userinfo, "characterfile" ), sizeof(settings.characterfile) );
ADDRLP4 292
ARGP4
ADDRGP4 $331
ARGP4
ADDRLP4 1316
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 1316
INDIRP4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 540
;540:	settings.skill = atof( Info_ValueForKey( userinfo, "skill" ) );
ADDRLP4 292
ARGP4
ADDRGP4 $158
ARGP4
ADDRLP4 1320
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1320
INDIRP4
ARGP4
ADDRLP4 1324
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0+144
ADDRLP4 1324
INDIRF4
ASGNF4
line 541
;541:	Q_strncpyz( settings.team, Info_ValueForKey( userinfo, "team" ), sizeof(settings.team) );
ADDRLP4 292
ARGP4
ADDRGP4 $334
ARGP4
ADDRLP4 1328
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0+148
ARGP4
ADDRLP4 1328
INDIRP4
ARGP4
CNSTI4 144
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 543
;542:
;543:	if (!BotAISetupClient( clientNum, &settings, restart )) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 1332
ADDRGP4 BotAISetupClient
CALLI4
ASGNI4
ADDRLP4 1332
INDIRI4
CNSTI4 0
NEI4 $336
line 544
;544:		trap_DropClient( clientNum, "BotAISetupClient failed" );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $338
ARGP4
ADDRGP4 trap_DropClient
CALLV
pop
line 545
;545:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $330
JUMPV
LABELV $336
line 548
;546:	}
;547:
;548:	return qtrue;
CNSTI4 1
RETI4
LABELV $330
endproc G_BotConnect 1336 12
proc G_AddBot 1388 16
line 557
;549:}
;550:
;551:
;552:/*
;553:===============
;554:G_AddBot
;555:===============
;556:*/
;557:static void G_AddBot( const char *name, float skill, const char *team, int delay, const char *altname ) {
line 570
;558:	int				clientNum;
;559:	char			*botinfo;
;560:	gentity_t		*bot;
;561:	char			*key;
;562:	char			*s;
;563:	const char		*botname;
;564:	const char		*model;
;565:	const char		*headmodel;
;566:	char			userinfo[MAX_INFO_STRING];
;567:	char			nm[MAX_CVAR_VALUE_STRING];
;568:
;569:	// get the botinfo from bots.txt
;570:	botinfo = G_GetBotInfoByName( name );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1312
ADDRGP4 G_GetBotInfoByName
CALLP4
ASGNP4
ADDRLP4 1032
ADDRLP4 1312
INDIRP4
ASGNP4
line 571
;571:	if ( !botinfo ) {
ADDRLP4 1032
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $340
line 572
;572:		G_Printf( S_COLOR_RED "Error: Bot '%s' not defined\n", name );
ADDRGP4 $342
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 573
;573:		return;
ADDRGP4 $339
JUMPV
LABELV $340
line 577
;574:	}
;575:
;576:	// create the bot's userinfo
;577:	userinfo[0] = '\0';
ADDRLP4 0
CNSTI1 0
ASGNI1
line 579
;578:
;579:	botname = Info_ValueForKey( botinfo, "funname" );
ADDRLP4 1032
INDIRP4
ARGP4
ADDRGP4 $343
ARGP4
ADDRLP4 1316
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1040
ADDRLP4 1316
INDIRP4
ASGNP4
line 580
;580:	if( !botname[0] ) {
ADDRLP4 1040
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $344
line 581
;581:		botname = Info_ValueForKey( botinfo, "name" );
ADDRLP4 1032
INDIRP4
ARGP4
ADDRGP4 $135
ARGP4
ADDRLP4 1320
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1040
ADDRLP4 1320
INDIRP4
ASGNP4
line 582
;582:	}
LABELV $344
line 584
;583:	// check for an alternative name
;584:	if (altname && altname[0]) {
ADDRLP4 1320
ADDRFP4 16
INDIRP4
ASGNP4
ADDRLP4 1320
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $346
ADDRLP4 1320
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $346
line 585
;585:		botname = altname;
ADDRLP4 1040
ADDRFP4 16
INDIRP4
ASGNP4
line 586
;586:	}
LABELV $346
line 588
;587:
;588:	BG_CleanName( botname, nm, sizeof( nm ), "unnamed bot" );
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1056
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $348
ARGP4
ADDRGP4 BG_CleanName
CALLV
pop
line 589
;589:	Info_SetValueForKey( userinfo, "name", nm );
ADDRLP4 0
ARGP4
ADDRGP4 $135
ARGP4
ADDRLP4 1056
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 591
;590:
;591:	Info_SetValueForKey( userinfo, "rate", "25000" );
ADDRLP4 0
ARGP4
ADDRGP4 $349
ARGP4
ADDRGP4 $350
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 592
;592:	Info_SetValueForKey( userinfo, "snaps", va( "%i", sv_fps.integer ) );
ADDRGP4 $114
ARGP4
ADDRGP4 sv_fps+12
INDIRI4
ARGI4
ADDRLP4 1324
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRGP4 $351
ARGP4
ADDRLP4 1324
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 593
;593:	Info_SetValueForKey( userinfo, "skill", va("%1.2f", skill) );
ADDRGP4 $353
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 1328
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRGP4 $158
ARGP4
ADDRLP4 1328
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 595
;594:
;595:	if ( skill >= 1 && skill < 2 ) {
ADDRLP4 1332
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 1332
INDIRF4
CNSTF4 1065353216
LTF4 $354
ADDRLP4 1332
INDIRF4
CNSTF4 1073741824
GEF4 $354
line 596
;596:		Info_SetValueForKey( userinfo, "handicap", "50" );
ADDRLP4 0
ARGP4
ADDRGP4 $356
ARGP4
ADDRGP4 $357
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 597
;597:	}
ADDRGP4 $355
JUMPV
LABELV $354
line 598
;598:	else if ( skill >= 2 && skill < 3 ) {
ADDRLP4 1336
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 1336
INDIRF4
CNSTF4 1073741824
LTF4 $358
ADDRLP4 1336
INDIRF4
CNSTF4 1077936128
GEF4 $358
line 599
;599:		Info_SetValueForKey( userinfo, "handicap", "70" );
ADDRLP4 0
ARGP4
ADDRGP4 $356
ARGP4
ADDRGP4 $360
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 600
;600:	}
ADDRGP4 $359
JUMPV
LABELV $358
line 601
;601:	else if ( skill >= 3 && skill < 4 ) {
ADDRLP4 1340
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 1340
INDIRF4
CNSTF4 1077936128
LTF4 $361
ADDRLP4 1340
INDIRF4
CNSTF4 1082130432
GEF4 $361
line 602
;602:		Info_SetValueForKey( userinfo, "handicap", "90" );
ADDRLP4 0
ARGP4
ADDRGP4 $356
ARGP4
ADDRGP4 $363
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 603
;603:	}
LABELV $361
LABELV $359
LABELV $355
line 605
;604:
;605:	key = "model";
ADDRLP4 1024
ADDRGP4 $364
ASGNP4
line 606
;606:	model = Info_ValueForKey( botinfo, key );
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 1344
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1044
ADDRLP4 1344
INDIRP4
ASGNP4
line 607
;607:	if ( !*model ) {
ADDRLP4 1044
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $365
line 608
;608:		model = "visor/default";
ADDRLP4 1044
ADDRGP4 $367
ASGNP4
line 609
;609:	}
LABELV $365
line 610
;610:	Info_SetValueForKey( userinfo, key, model );
ADDRLP4 0
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 614
;611:	//key = "team_model";
;612:	//Info_SetValueForKey( userinfo, key, model );
;613:
;614:	key = "headmodel";
ADDRLP4 1024
ADDRGP4 $368
ASGNP4
line 615
;615:	headmodel = Info_ValueForKey( botinfo, key );
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 1348
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1048
ADDRLP4 1348
INDIRP4
ASGNP4
line 616
;616:	if ( !*headmodel ) {
ADDRLP4 1048
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $369
line 617
;617:		headmodel = model;
ADDRLP4 1048
ADDRLP4 1044
INDIRP4
ASGNP4
line 618
;618:	}
LABELV $369
line 619
;619:	Info_SetValueForKey( userinfo, key, headmodel );
ADDRLP4 0
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 623
;620:	//key = "team_headmodel";
;621:	//Info_SetValueForKey( userinfo, key, headmodel );
;622:
;623:	key = "gender";
ADDRLP4 1024
ADDRGP4 $371
ASGNP4
line 624
;624:	s = Info_ValueForKey( botinfo, key );
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 1352
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1352
INDIRP4
ASGNP4
line 625
;625:	if ( !*s ) {
ADDRLP4 1028
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $372
line 626
;626:		s = "male";
ADDRLP4 1028
ADDRGP4 $374
ASGNP4
line 627
;627:	}
LABELV $372
line 628
;628:	Info_SetValueForKey( userinfo, "sex", s );
ADDRLP4 0
ARGP4
ADDRGP4 $375
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 630
;629:
;630:	key = "color1";
ADDRLP4 1024
ADDRGP4 $376
ASGNP4
line 631
;631:	s = Info_ValueForKey( botinfo, key );
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 1356
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1356
INDIRP4
ASGNP4
line 632
;632:	if ( !*s ) {
ADDRLP4 1028
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $377
line 633
;633:		s = "4";
ADDRLP4 1028
ADDRGP4 $379
ASGNP4
line 634
;634:	}
LABELV $377
line 635
;635:	Info_SetValueForKey( userinfo, key, s );
ADDRLP4 0
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 637
;636:
;637:	key = "color2";
ADDRLP4 1024
ADDRGP4 $380
ASGNP4
line 638
;638:	s = Info_ValueForKey( botinfo, key );
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 1360
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1360
INDIRP4
ASGNP4
line 639
;639:	if ( !*s ) {
ADDRLP4 1028
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $381
line 640
;640:		s = "5";
ADDRLP4 1028
ADDRGP4 $383
ASGNP4
line 641
;641:	}
LABELV $381
line 642
;642:	Info_SetValueForKey( userinfo, key, s );
ADDRLP4 0
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 644
;643:
;644:	s = Info_ValueForKey(botinfo, "aifile");
ADDRLP4 1032
INDIRP4
ARGP4
ADDRGP4 $384
ARGP4
ADDRLP4 1364
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1364
INDIRP4
ASGNP4
line 645
;645:	if (!*s ) {
ADDRLP4 1028
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $385
line 646
;646:		trap_Print( S_COLOR_RED "Error: bot has no aifile specified\n" );
ADDRGP4 $387
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 647
;647:		return;
ADDRGP4 $339
JUMPV
LABELV $385
line 651
;648:	}
;649:
;650:	// have the server allocate a client slot
;651:	clientNum = trap_BotAllocateClient();
ADDRLP4 1368
ADDRGP4 trap_BotAllocateClient
CALLI4
ASGNI4
ADDRLP4 1036
ADDRLP4 1368
INDIRI4
ASGNI4
line 652
;652:	if ( clientNum == -1 ) {
ADDRLP4 1036
INDIRI4
CNSTI4 -1
NEI4 $388
line 653
;653:		G_Printf( S_COLOR_RED "Unable to add bot.  All player slots are in use.\n" );
ADDRGP4 $390
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 654
;654:		G_Printf( S_COLOR_RED "Start server with more 'open' slots (or check setting of sv_maxclients cvar).\n" );
ADDRGP4 $391
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 655
;655:		return;
ADDRGP4 $339
JUMPV
LABELV $388
line 660
;656:	}
;657:
;658:	// cleanup previous data manually
;659:	// because client may silently (re)connect without ClientDisconnect in case of crash for example
;660:	if ( level.clients[ clientNum ].pers.connected != CON_DISCONNECTED ) {
ADDRLP4 1036
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
EQI4 $392
line 661
;661:		ClientDisconnect( clientNum );
ADDRLP4 1036
INDIRI4
ARGI4
ADDRGP4 ClientDisconnect
CALLV
pop
line 662
;662:	}
LABELV $392
line 664
;663:
;664:	Info_SetValueForKey( userinfo, "characterfile", Info_ValueForKey( botinfo, "aifile" ) );
ADDRLP4 1032
INDIRP4
ARGP4
ADDRGP4 $384
ARGP4
ADDRLP4 1372
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRGP4 $331
ARGP4
ADDRLP4 1372
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 665
;665:	Info_SetValueForKey( userinfo, "skill", va( "%1.2f", skill ) );
ADDRGP4 $353
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 1376
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRGP4 $158
ARGP4
ADDRLP4 1376
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 666
;666:	Info_SetValueForKey( userinfo, "team", team );
ADDRLP4 0
ARGP4
ADDRGP4 $334
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Info_SetValueForKey
CALLI4
pop
line 668
;667:
;668:	bot = &g_entities[ clientNum ];
ADDRLP4 1052
ADDRLP4 1036
INDIRI4
CNSTI4 832
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 669
;669:	bot->r.svFlags |= SVF_BOT;
ADDRLP4 1380
ADDRLP4 1052
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 1380
INDIRP4
ADDRLP4 1380
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 670
;670:	bot->inuse = qtrue;
ADDRLP4 1052
INDIRP4
CNSTI4 520
ADDP4
CNSTI4 1
ASGNI4
line 673
;671:
;672:	// register the userinfo
;673:	trap_SetUserinfo( clientNum, userinfo );
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_SetUserinfo
CALLV
pop
line 676
;674:
;675:	// have it connect to the game as a normal client
;676:	if ( ClientConnect( clientNum, qtrue, qtrue ) ) {
ADDRLP4 1036
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 1384
ADDRGP4 ClientConnect
CALLP4
ASGNP4
ADDRLP4 1384
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $394
line 677
;677:		return;
ADDRGP4 $339
JUMPV
LABELV $394
line 680
;678:	}
;679:
;680:	if ( delay == 0 ) {
ADDRFP4 12
INDIRI4
CNSTI4 0
NEI4 $396
line 681
;681:		ClientBegin( clientNum );
ADDRLP4 1036
INDIRI4
ARGI4
ADDRGP4 ClientBegin
CALLV
pop
line 682
;682:		return;
ADDRGP4 $339
JUMPV
LABELV $396
line 685
;683:	}
;684:
;685:	AddBotToSpawnQueue( clientNum, delay );
ADDRLP4 1036
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 AddBotToSpawnQueue
CALLV
pop
line 686
;686:}
LABELV $339
endproc G_AddBot 1388 16
export Svcmd_AddBot_f
proc Svcmd_AddBot_f 4112 20
line 694
;687:
;688:
;689:/*
;690:===============
;691:Svcmd_AddBot_f
;692:===============
;693:*/
;694:void Svcmd_AddBot_f( void ) {
line 703
;695:	float			skill;
;696:	int				delay;
;697:	char			name[MAX_TOKEN_CHARS];
;698:	char			altname[MAX_TOKEN_CHARS];
;699:	char			string[MAX_TOKEN_CHARS];
;700:	char			team[MAX_TOKEN_CHARS];
;701:
;702:	// are bots enabled?
;703:	if ( !trap_Cvar_VariableIntegerValue( "bot_enable" ) ) {
ADDRGP4 $401
ARGP4
ADDRLP4 4104
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 4104
INDIRI4
CNSTI4 0
NEI4 $399
line 704
;704:		return;
ADDRGP4 $398
JUMPV
LABELV $399
line 708
;705:	}
;706:
;707:	// name
;708:	trap_Argv( 1, name, sizeof( name ) );
CNSTI4 1
ARGI4
ADDRLP4 1024
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 709
;709:	if ( !name[0] ) {
ADDRLP4 1024
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $402
line 710
;710:		trap_Print( "Usage: Addbot <botname> [skill 1-5] [team] [msec delay] [altname]\n" );
ADDRGP4 $404
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 711
;711:		return;
ADDRGP4 $398
JUMPV
LABELV $402
line 715
;712:	}
;713:
;714:	// skill
;715:	trap_Argv( 2, string, sizeof( string ) );
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 716
;716:	if ( !string[0] ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $405
line 717
;717:		skill = 4;
ADDRLP4 2048
CNSTF4 1082130432
ASGNF4
line 718
;718:	}
ADDRGP4 $406
JUMPV
LABELV $405
line 719
;719:	else {
line 720
;720:		skill = atof( string );
ADDRLP4 0
ARGP4
ADDRLP4 4108
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 2048
ADDRLP4 4108
INDIRF4
ASGNF4
line 721
;721:		if ( skill < 1 )
ADDRLP4 2048
INDIRF4
CNSTF4 1065353216
GEF4 $407
line 722
;722:			skill = 1;
ADDRLP4 2048
CNSTF4 1065353216
ASGNF4
ADDRGP4 $408
JUMPV
LABELV $407
line 723
;723:		else if ( skill > 5 )
ADDRLP4 2048
INDIRF4
CNSTF4 1084227584
LEF4 $409
line 724
;724:			skill = 5;
ADDRLP4 2048
CNSTF4 1084227584
ASGNF4
LABELV $409
LABELV $408
line 725
;725:	}
LABELV $406
line 728
;726:
;727:	// team
;728:	trap_Argv( 3, team, sizeof( team ) );
CNSTI4 3
ARGI4
ADDRLP4 3076
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 731
;729:
;730:	// delay
;731:	trap_Argv( 4, string, sizeof( string ) );
CNSTI4 4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 732
;732:	if ( !string[0] ) {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $411
line 733
;733:		delay = 0;
ADDRLP4 4100
CNSTI4 0
ASGNI4
line 734
;734:	}
ADDRGP4 $412
JUMPV
LABELV $411
line 735
;735:	else {
line 736
;736:		delay = atoi( string );
ADDRLP4 0
ARGP4
ADDRLP4 4108
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4100
ADDRLP4 4108
INDIRI4
ASGNI4
line 737
;737:	}
LABELV $412
line 740
;738:
;739:	// alternative name
;740:	trap_Argv( 5, altname, sizeof( altname ) );
CNSTI4 5
ARGI4
ADDRLP4 2052
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 742
;741:
;742:	G_AddBot( name, skill, team, delay, altname );
ADDRLP4 1024
ARGP4
ADDRLP4 2048
INDIRF4
ARGF4
ADDRLP4 3076
ARGP4
ADDRLP4 4100
INDIRI4
ARGI4
ADDRLP4 2052
ARGP4
ADDRGP4 G_AddBot
CALLV
pop
line 746
;743:
;744:	// if this was issued during gameplay and we are playing locally,
;745:	// go ahead and load the bot's media immediately
;746:	if ( level.time - level.startTime > 1000 &&
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+40
INDIRI4
SUBI4
CNSTI4 1000
LEI4 $413
ADDRGP4 $417
ARGP4
ADDRLP4 4108
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 4108
INDIRI4
CNSTI4 0
EQI4 $413
line 747
;747:		trap_Cvar_VariableIntegerValue( "cl_running" ) ) {
line 748
;748:		trap_SendServerCommand( -1, "loaddeferred\n" );	// FIXME: spelled wrong, but not changing for demo
CNSTI4 -1
ARGI4
ADDRGP4 $418
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 749
;749:	}
LABELV $413
line 750
;750:}
LABELV $398
endproc Svcmd_AddBot_f 4112 20
export Svcmd_BotList_f
proc Svcmd_BotList_f 224 20
line 757
;751:
;752:/*
;753:===============
;754:Svcmd_BotList_f
;755:===============
;756:*/
;757:void Svcmd_BotList_f( void ) {
line 764
;758:	int i;
;759:	char name[MAX_NETNAME];
;760:	char funname[MAX_NETNAME];
;761:	char model[MAX_QPATH];
;762:	char aifile[MAX_QPATH];
;763:
;764:	trap_Print( S_COLOR_RED "name             model            aifile              funname\n" );
ADDRGP4 $420
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 765
;765:	for ( i = 0; i < g_numBots; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $424
JUMPV
LABELV $421
line 766
;766:		Q_strncpyz( name, Info_ValueForKey( g_botInfos[i], "name" ), sizeof( name ) );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $135
ARGP4
ADDRLP4 204
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 204
INDIRP4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 767
;767:		if ( !*name ) {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $425
line 768
;768:			strcpy(name, "UnnamedPlayer");
ADDRLP4 4
ARGP4
ADDRGP4 $427
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 769
;769:		}
LABELV $425
line 770
;770:		Q_strncpyz( funname, Info_ValueForKey( g_botInfos[i], "funname" ), sizeof( funname ) );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $343
ARGP4
ADDRLP4 208
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 40
ARGP4
ADDRLP4 208
INDIRP4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 771
;771:		if ( !*funname ) {
ADDRLP4 40
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $428
line 772
;772:			strcpy( funname, "" );
ADDRLP4 40
ARGP4
ADDRGP4 $95
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 773
;773:		}
LABELV $428
line 774
;774:		Q_strncpyz( model, Info_ValueForKey( g_botInfos[i], "model" ), sizeof( model ) );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $364
ARGP4
ADDRLP4 212
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 76
ARGP4
ADDRLP4 212
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 775
;775:		if ( !*model ) {
ADDRLP4 76
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $430
line 776
;776:			strcpy( model, "visor/default" );
ADDRLP4 76
ARGP4
ADDRGP4 $367
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 777
;777:		}
LABELV $430
line 778
;778:		Q_strncpyz( aifile, Info_ValueForKey( g_botInfos[i], "aifile" ), sizeof( aifile ) );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $384
ARGP4
ADDRLP4 216
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 140
ARGP4
ADDRLP4 216
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 779
;779:		if ( !*aifile ) {
ADDRLP4 140
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $432
line 780
;780:			strcpy( aifile, "bots/default_c.c" );
ADDRLP4 140
ARGP4
ADDRGP4 $434
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 781
;781:		}
LABELV $432
line 782
;782:		trap_Print( va( "%-16s %-16s %-20s %-20s\n", name, model, aifile, funname ) );
ADDRGP4 $435
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 140
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 220
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 220
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 783
;783:	}
LABELV $422
line 765
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $424
ADDRLP4 0
INDIRI4
ADDRGP4 g_numBots
INDIRI4
LTI4 $421
line 784
;784:}
LABELV $419
endproc Svcmd_BotList_f 224 20
proc G_SpawnBots 1052 16
line 792
;785:
;786:
;787:/*
;788:===============
;789:G_SpawnBots
;790:===============
;791:*/
;792:static void G_SpawnBots( const char *botList, int baseDelay ) {
line 799
;793:	char		*bot;
;794:	char		*p;
;795:	float		skill;
;796:	int			delay;
;797:	char		bots[MAX_INFO_VALUE];
;798:
;799:	skill = trap_Cvar_VariableValue( "g_spSkill" );
ADDRGP4 $161
ARGP4
ADDRLP4 1040
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 1040
INDIRF4
ASGNF4
line 800
;800:	if( skill < 1 ) {
ADDRLP4 12
INDIRF4
CNSTF4 1065353216
GEF4 $437
line 801
;801:		trap_Cvar_Set( "g_spSkill", "1" );
ADDRGP4 $161
ARGP4
ADDRGP4 $439
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 802
;802:		skill = 1;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 803
;803:	}
ADDRGP4 $438
JUMPV
LABELV $437
line 804
;804:	else if ( skill > 5 ) {
ADDRLP4 12
INDIRF4
CNSTF4 1084227584
LEF4 $440
line 805
;805:		trap_Cvar_Set( "g_spSkill", "5" );
ADDRGP4 $161
ARGP4
ADDRGP4 $383
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 806
;806:		skill = 5;
ADDRLP4 12
CNSTF4 1084227584
ASGNF4
line 807
;807:	}
LABELV $440
LABELV $438
line 809
;808:
;809:	Q_strncpyz( bots, botList, sizeof( bots ) );
ADDRLP4 16
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 810
;810:	p = &bots[0];
ADDRLP4 0
ADDRLP4 16
ASGNP4
line 811
;811:	delay = baseDelay;
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRGP4 $443
JUMPV
line 812
;812:	while( *p ) {
LABELV $445
line 814
;813:		//skip spaces
;814:		while( *p == ' ' ) {
line 815
;815:			p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 816
;816:		}
LABELV $446
line 814
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 32
EQI4 $445
line 817
;817:		if( !*p ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $448
line 818
;818:			break;
ADDRGP4 $444
JUMPV
LABELV $448
line 822
;819:		}
;820:
;821:		// mark start of bot name
;822:		bot = p;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $451
JUMPV
LABELV $450
line 825
;823:
;824:		// skip until space of null
;825:		while( *p && *p != ' ' ) {
line 826
;826:			p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 827
;827:		}
LABELV $451
line 825
ADDRLP4 1044
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
EQI4 $453
ADDRLP4 1044
INDIRI4
CNSTI4 32
NEI4 $450
LABELV $453
line 828
;828:		if( *p ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $454
line 829
;829:			*p++ = '\0';
ADDRLP4 1048
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 1048
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 1048
INDIRP4
CNSTI1 0
ASGNI1
line 830
;830:		}
LABELV $454
line 834
;831:
;832:		// we must add the bot this way, calling G_AddBot directly at this stage
;833:		// does "Bad Things"
;834:		trap_SendConsoleCommand( EXEC_INSERT, va("addbot %s %f free %i\n", bot, skill, delay) );
ADDRGP4 $456
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 1048
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 1
ARGI4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 836
;835:
;836:		delay += BOT_BEGIN_DELAY_INCREMENT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1500
ADDI4
ASGNI4
line 837
;837:	}
LABELV $443
line 812
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $446
LABELV $444
line 838
;838:}
LABELV $436
endproc G_SpawnBots 1052 16
proc G_LoadBotsFromFile 8216 16
line 846
;839:
;840:
;841:/*
;842:===============
;843:G_LoadBotsFromFile
;844:===============
;845:*/
;846:static void G_LoadBotsFromFile( const char *filename ) {
line 851
;847:	int				len;
;848:	fileHandle_t	f;
;849:	char			buf[MAX_BOTS_TEXT];
;850:
;851:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8200
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8200
INDIRI4
ASGNI4
line 852
;852:	if ( f == FS_INVALID_HANDLE ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $458
line 853
;853:		trap_Print( va( S_COLOR_RED "file not found: %s\n", filename ) );
ADDRGP4 $89
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8204
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8204
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 854
;854:		return;
ADDRGP4 $457
JUMPV
LABELV $458
line 856
;855:	}
;856:	if ( len >= MAX_BOTS_TEXT ) {
ADDRLP4 0
INDIRI4
CNSTI4 8192
LTI4 $460
line 857
;857:		trap_Print( va( S_COLOR_RED "file too large: %s is %i, max allowed is %i\n", filename, len, MAX_BOTS_TEXT ) );
ADDRGP4 $462
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 8192
ARGI4
ADDRLP4 8204
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8204
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 858
;858:		trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 859
;859:		return;
ADDRGP4 $457
JUMPV
LABELV $460
line 862
;860:	}
;861:
;862:	trap_FS_Read( buf, len, f );
ADDRLP4 8
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
line 863
;863:	trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 864
;864:	buf[ len ] = '\0';
ADDRLP4 0
INDIRI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 866
;865:
;866:	g_numBots += G_ParseInfos( buf, MAX_BOTS - g_numBots, &g_botInfos[g_numBots] );
ADDRLP4 8
ARGP4
ADDRLP4 8204
ADDRGP4 g_numBots
ASGNP4
ADDRLP4 8208
ADDRLP4 8204
INDIRP4
INDIRI4
ASGNI4
CNSTI4 1024
ADDRLP4 8208
INDIRI4
SUBI4
ARGI4
ADDRLP4 8208
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
ARGP4
ADDRLP4 8212
ADDRGP4 G_ParseInfos
CALLI4
ASGNI4
ADDRLP4 8204
INDIRP4
ADDRLP4 8208
INDIRI4
ADDRLP4 8212
INDIRI4
ADDI4
ASGNI4
line 867
;867:}
LABELV $457
endproc G_LoadBotsFromFile 8216 16
proc G_LoadBots 1452 16
line 875
;868:
;869:
;870:/*
;871:===============
;872:G_LoadBots
;873:===============
;874:*/
;875:static void G_LoadBots( void ) {
line 884
;876:	vmCvar_t	botsFile;
;877:	int			numdirs;
;878:	char		filename[128];
;879:	char		dirlist[1024];
;880:	char*		dirptr;
;881:	int			i;
;882:	int			dirlen;
;883:
;884:	if ( !trap_Cvar_VariableIntegerValue( "bot_enable" ) ) {
ADDRGP4 $401
ARGP4
ADDRLP4 1440
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 1440
INDIRI4
CNSTI4 0
NEI4 $464
line 885
;885:		return;
ADDRGP4 $463
JUMPV
LABELV $464
line 888
;886:	}
;887:
;888:	g_numBots = 0;
ADDRGP4 g_numBots
CNSTI4 0
ASGNI4
line 890
;889:
;890:	trap_Cvar_Register( &botsFile, "g_botsFile", "", CVAR_ARCHIVE | CVAR_LATCH );
ADDRLP4 1168
ARGP4
ADDRGP4 $466
ARGP4
ADDRGP4 $95
ARGP4
CNSTI4 33
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 892
;891:
;892:	if ( *botsFile.string ) {
ADDRLP4 1168+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $467
line 893
;893:		G_LoadBotsFromFile( botsFile.string );
ADDRLP4 1168+16
ARGP4
ADDRGP4 G_LoadBotsFromFile
CALLV
pop
line 894
;894:	} else {
ADDRGP4 $468
JUMPV
LABELV $467
line 895
;895:		G_LoadBotsFromFile( "scripts/bots.txt" );
ADDRGP4 $471
ARGP4
ADDRGP4 G_LoadBotsFromFile
CALLV
pop
line 896
;896:	}
LABELV $468
line 899
;897:
;898:	// get all bots from .bot files
;899:	numdirs = trap_FS_GetFileList( "scripts", ".bot", dirlist, sizeof( dirlist ) );
ADDRGP4 $101
ARGP4
ADDRGP4 $472
ARGP4
ADDRLP4 144
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1444
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 140
ADDRLP4 1444
INDIRI4
ASGNI4
line 900
;900:	dirptr  = dirlist;
ADDRLP4 0
ADDRLP4 144
ASGNP4
line 901
;901:	for (i = 0; i < numdirs; i++, dirptr += dirlen+1) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $476
JUMPV
LABELV $473
line 902
;902:		dirlen = (int)strlen(dirptr);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1448
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 136
ADDRLP4 1448
INDIRI4
ASGNI4
line 903
;903:		strcpy(filename, "scripts/");
ADDRLP4 4
ARGP4
ADDRGP4 $107
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 904
;904:		strcat(filename, dirptr);
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 905
;905:		G_LoadBotsFromFile(filename);
ADDRLP4 4
ARGP4
ADDRGP4 G_LoadBotsFromFile
CALLV
pop
line 906
;906:	}
LABELV $474
line 901
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
LABELV $476
ADDRLP4 132
INDIRI4
ADDRLP4 140
INDIRI4
LTI4 $473
line 907
;907:	trap_Print( va( "%i bots parsed\n", g_numBots ) );
ADDRGP4 $477
ARGP4
ADDRGP4 g_numBots
INDIRI4
ARGI4
ADDRLP4 1448
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1448
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 908
;908:}
LABELV $463
endproc G_LoadBots 1452 16
export G_GetBotInfoByNumber
proc G_GetBotInfoByNumber 8 8
line 917
;909:
;910:
;911:
;912:/*
;913:===============
;914:G_GetBotInfoByNumber
;915:===============
;916:*/
;917:char *G_GetBotInfoByNumber( int num ) {
line 918
;918:	if( num < 0 || num >= g_numBots ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $481
ADDRLP4 0
INDIRI4
ADDRGP4 g_numBots
INDIRI4
LTI4 $479
LABELV $481
line 919
;919:		trap_Print( va( S_COLOR_RED "Invalid bot number: %i\n", num ) );
ADDRGP4 $482
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 920
;920:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $478
JUMPV
LABELV $479
line 922
;921:	}
;922:	return g_botInfos[num];
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
RETP4
LABELV $478
endproc G_GetBotInfoByNumber 8 8
export G_GetBotInfoByName
proc G_GetBotInfoByName 16 8
line 931
;923:}
;924:
;925:
;926:/*
;927:===============
;928:G_GetBotInfoByName
;929:===============
;930:*/
;931:char *G_GetBotInfoByName( const char *name ) {
line 935
;932:	int		n;
;933:	char	*value;
;934:
;935:	for ( n = 0; n < g_numBots ; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $487
JUMPV
LABELV $484
line 936
;936:		value = Info_ValueForKey( g_botInfos[n], "name" );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $135
ARGP4
ADDRLP4 8
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 937
;937:		if ( !Q_stricmp( value, name ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $488
line 938
;938:			return g_botInfos[n];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 g_botInfos
ADDP4
INDIRP4
RETP4
ADDRGP4 $483
JUMPV
LABELV $488
line 940
;939:		}
;940:	}
LABELV $485
line 935
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $487
ADDRLP4 0
INDIRI4
ADDRGP4 g_numBots
INDIRI4
LTI4 $484
line 942
;941:
;942:	return NULL;
CNSTP4 0
RETP4
LABELV $483
endproc G_GetBotInfoByName 16 8
export G_InitBots
proc G_InitBots 0 16
line 951
;943:}
;944:
;945:
;946:/*
;947:===============
;948:G_InitBots
;949:===============
;950:*/
;951:void G_InitBots( qboolean restart ) {
line 952
;952:	G_LoadBots();
ADDRGP4 G_LoadBots
CALLV
pop
line 953
;953:	G_LoadArenas();
ADDRGP4 G_LoadArenas
CALLV
pop
line 955
;954:
;955:	trap_Cvar_Register( &bot_minplayers, "bot_minplayers", "0", CVAR_SERVERINFO );
ADDRGP4 bot_minplayers
ARGP4
ADDRGP4 $491
ARGP4
ADDRGP4 $492
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 956
;956:}
LABELV $490
endproc G_InitBots 0 16
import mapname
bss
export bot_minplayers
align 4
LABELV bot_minplayers
skip 272
align 4
LABELV botSpawnQueue
skip 128
align 4
LABELV g_arenaInfos
skip 4096
export g_numArenas
align 4
LABELV g_numArenas
skip 4
align 4
LABELV g_botInfos
skip 4096
align 4
LABELV g_numBots
skip 4
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
import BotTestAAS
import BotAIStartFrame
import BotAIShutdownClient
import BotAISetupClient
import BotAILoadMap
import BotAIShutdown
import BotAISetup
import BotInterbreedEndMatch
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
LABELV $492
byte 1 48
byte 1 0
align 1
LABELV $491
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $482
byte 1 94
byte 1 49
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $477
byte 1 37
byte 1 105
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $472
byte 1 46
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $471
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $466
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
LABELV $462
byte 1 94
byte 1 49
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
LABELV $456
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
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $439
byte 1 49
byte 1 0
align 1
LABELV $435
byte 1 37
byte 1 45
byte 1 49
byte 1 54
byte 1 115
byte 1 32
byte 1 37
byte 1 45
byte 1 49
byte 1 54
byte 1 115
byte 1 32
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 32
byte 1 37
byte 1 45
byte 1 50
byte 1 48
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $434
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 47
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 95
byte 1 99
byte 1 46
byte 1 99
byte 1 0
align 1
LABELV $427
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
LABELV $420
byte 1 94
byte 1 49
byte 1 110
byte 1 97
byte 1 109
byte 1 101
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
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
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
byte 1 97
byte 1 105
byte 1 102
byte 1 105
byte 1 108
byte 1 101
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
byte 1 102
byte 1 117
byte 1 110
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $418
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
byte 1 10
byte 1 0
align 1
LABELV $417
byte 1 99
byte 1 108
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
LABELV $404
byte 1 85
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 32
byte 1 65
byte 1 100
byte 1 100
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 60
byte 1 98
byte 1 111
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 62
byte 1 32
byte 1 91
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 32
byte 1 49
byte 1 45
byte 1 53
byte 1 93
byte 1 32
byte 1 91
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 93
byte 1 32
byte 1 91
byte 1 109
byte 1 115
byte 1 101
byte 1 99
byte 1 32
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 93
byte 1 32
byte 1 91
byte 1 97
byte 1 108
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 93
byte 1 10
byte 1 0
align 1
LABELV $401
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $391
byte 1 94
byte 1 49
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 39
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 39
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 115
byte 1 32
byte 1 40
byte 1 111
byte 1 114
byte 1 32
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 111
byte 1 102
byte 1 32
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
byte 1 32
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 41
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $390
byte 1 94
byte 1 49
byte 1 85
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 97
byte 1 100
byte 1 100
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 46
byte 1 32
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 115
byte 1 108
byte 1 111
byte 1 116
byte 1 115
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $387
byte 1 94
byte 1 49
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 97
byte 1 105
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 102
byte 1 105
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $384
byte 1 97
byte 1 105
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $383
byte 1 53
byte 1 0
align 1
LABELV $380
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $379
byte 1 52
byte 1 0
align 1
LABELV $376
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 49
byte 1 0
align 1
LABELV $375
byte 1 115
byte 1 101
byte 1 120
byte 1 0
align 1
LABELV $374
byte 1 109
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $371
byte 1 103
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $368
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
LABELV $367
byte 1 118
byte 1 105
byte 1 115
byte 1 111
byte 1 114
byte 1 47
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $364
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $363
byte 1 57
byte 1 48
byte 1 0
align 1
LABELV $360
byte 1 55
byte 1 48
byte 1 0
align 1
LABELV $357
byte 1 53
byte 1 48
byte 1 0
align 1
LABELV $356
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
LABELV $353
byte 1 37
byte 1 49
byte 1 46
byte 1 50
byte 1 102
byte 1 0
align 1
LABELV $351
byte 1 115
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $350
byte 1 50
byte 1 53
byte 1 48
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $349
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $348
byte 1 117
byte 1 110
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $343
byte 1 102
byte 1 117
byte 1 110
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $342
byte 1 94
byte 1 49
byte 1 69
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 58
byte 1 32
byte 1 66
byte 1 111
byte 1 116
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $338
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
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $334
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $331
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $321
byte 1 94
byte 1 51
byte 1 85
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 32
byte 1 98
byte 1 111
byte 1 116
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $203
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
LABELV $188
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
byte 1 49
byte 1 46
byte 1 50
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $187
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $184
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $161
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
LABELV $158
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $135
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $129
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 32
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
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 117
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 10
byte 1 0
align 1
LABELV $128
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $122
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $114
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $113
byte 1 110
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $108
byte 1 37
byte 1 105
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $107
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 0
align 1
LABELV $102
byte 1 46
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 0
align 1
LABELV $101
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $100
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 46
byte 1 116
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $95
byte 1 0
align 1
LABELV $94
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
LABELV $92
byte 1 94
byte 1 49
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
LABELV $89
byte 1 94
byte 1 49
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
byte 1 10
byte 1 0
align 1
LABELV $83
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $82
byte 1 92
byte 1 110
byte 1 117
byte 1 109
byte 1 92
byte 1 0
align 1
LABELV $81
byte 1 60
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 62
byte 1 0
align 1
LABELV $78
byte 1 125
byte 1 0
align 1
LABELV $75
byte 1 85
byte 1 110
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $69
byte 1 77
byte 1 97
byte 1 120
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 115
byte 1 32
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $66
byte 1 77
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 123
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $65
byte 1 123
byte 1 0

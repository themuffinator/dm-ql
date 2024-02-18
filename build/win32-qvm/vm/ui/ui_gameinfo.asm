export UI_ParseInfos
code
proc UI_ParseInfos 2084 12
file "..\..\..\..\code\ui\ui_gameinfo.c"
line 26
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3://
;4:// gameinfo.c
;5://
;6:
;7:#include "ui_local.h"
;8:
;9:
;10://
;11:// arena and bot info
;12://
;13:
;14:
;15:int				ui_numBots;
;16:static char *ui_botInfos[MAX_BOTS];
;17:
;18:static int		ui_numArenas;
;19:static char *ui_arenaInfos[MAX_ARENAS];
;20:
;21:/*
;22:===============
;23:UI_ParseInfos
;24:===============
;25:*/
;26:int UI_ParseInfos(char *buf, int max, char *infos[]) {
line 32
;27:	char *token;
;28:	int		count;
;29:	char	key[MAX_TOKEN_CHARS];
;30:	char	info[MAX_INFO_STRING];
;31:
;32:	count = 0;
ADDRLP4 2052
CNSTI4 0
ASGNI4
ADDRGP4 $91
JUMPV
LABELV $90
line 34
;33:
;34:	while (1) {
line 35
;35:		token = COM_Parse(&buf);
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
line 36
;36:		if (!token[0]) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $93
line 37
;37:			break;
ADDRGP4 $92
JUMPV
LABELV $93
line 39
;38:		}
;39:		if (strcmp(token, "{")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $97
ARGP4
ADDRLP4 2060
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2060
INDIRI4
CNSTI4 0
EQI4 $95
line 40
;40:			Com_Printf("Missing { in info file\n");
ADDRGP4 $98
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 41
;41:			break;
ADDRGP4 $92
JUMPV
LABELV $95
line 44
;42:		}
;43:
;44:		if (count == max) {
ADDRLP4 2052
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $99
line 45
;45:			Com_Printf("Max infos exceeded\n");
ADDRGP4 $101
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 46
;46:			break;
ADDRGP4 $92
JUMPV
LABELV $99
line 49
;47:		}
;48:
;49:		info[0] = '\0';
ADDRLP4 1028
CNSTI1 0
ASGNI1
ADDRGP4 $103
JUMPV
LABELV $102
line 50
;50:		while (1) {
line 51
;51:			token = COM_ParseExt(&buf, qtrue);
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
line 52
;52:			if (!token[0]) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $105
line 53
;53:				Com_Printf("Unexpected end of info file\n");
ADDRGP4 $107
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 54
;54:				break;
ADDRGP4 $104
JUMPV
LABELV $105
line 56
;55:			}
;56:			if (!strcmp(token, "}")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $110
ARGP4
ADDRLP4 2068
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
NEI4 $108
line 57
;57:				break;
ADDRGP4 $104
JUMPV
LABELV $108
line 59
;58:			}
;59:			Q_strncpyz(key, token, sizeof(key));
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
line 61
;60:
;61:			token = COM_ParseExt(&buf, qfalse);
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
line 62
;62:			if (!token[0]) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $111
line 63
;63:				strcpy(token, "<NULL>");
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $113
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 64
;64:			}
LABELV $111
line 65
;65:			Info_SetValueForKey(info, key, token);
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
line 66
;66:		}
LABELV $103
line 50
ADDRGP4 $102
JUMPV
LABELV $104
line 68
;67:		//NOTE: extra space for arena number
;68:		infos[count] = UI_Alloc(strlen(info) + strlen("\\num\\") + strlen(va("%d", MAX_ARENAS)) + 1);
ADDRLP4 1028
ARGP4
ADDRLP4 2064
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRGP4 $114
ARGP4
ADDRLP4 2068
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRGP4 $115
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
ADDRGP4 UI_Alloc
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
line 69
;69:		if (infos[count]) {
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
EQU4 $116
line 70
;70:			strcpy(infos[count], info);
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
line 71
;71:			count++;
ADDRLP4 2052
ADDRLP4 2052
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 72
;72:		}
LABELV $116
line 73
;73:	}
LABELV $91
line 34
ADDRGP4 $90
JUMPV
LABELV $92
line 74
;74:	return count;
ADDRLP4 2052
INDIRI4
RETI4
LABELV $89
endproc UI_ParseInfos 2084 12
proc UI_LoadArenasFromFile 8216 16
line 82
;75:}
;76:
;77:/*
;78:===============
;79:UI_LoadArenasFromFile
;80:===============
;81:*/
;82:static void UI_LoadArenasFromFile(char *filename) {
line 87
;83:	int				len;
;84:	fileHandle_t	f;
;85:	char			buf[MAX_ARENAS_TEXT];
;86:
;87:	len = trap_FS_FOpenFile(filename, &f, FS_READ);
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
line 88
;88:	if (!f) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $119
line 89
;89:		trap_Print(va(S_COLOR_RED "file not found: %s\n", filename));
ADDRGP4 $121
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
line 90
;90:		return;
ADDRGP4 $118
JUMPV
LABELV $119
line 92
;91:	}
;92:	if (len >= MAX_ARENAS_TEXT) {
ADDRLP4 0
INDIRI4
CNSTI4 8192
LTI4 $122
line 93
;93:		trap_Print(va(S_COLOR_RED "file too large: %s is %i, max allowed is %i", filename, len, MAX_ARENAS_TEXT));
ADDRGP4 $124
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
line 94
;94:		trap_FS_FCloseFile(f);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 95
;95:		return;
ADDRGP4 $118
JUMPV
LABELV $122
line 98
;96:	}
;97:
;98:	trap_FS_Read(buf, len, f);
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
line 99
;99:	buf[len] = 0;
ADDRLP4 0
INDIRI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 100
;100:	trap_FS_FCloseFile(f);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 102
;101:
;102:	ui_numArenas += UI_ParseInfos(buf, MAX_ARENAS - ui_numArenas, &ui_arenaInfos[ui_numArenas]);
ADDRLP4 8
ARGP4
ADDRLP4 8204
ADDRGP4 ui_numArenas
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
ADDRGP4 ui_arenaInfos
ADDP4
ARGP4
ADDRLP4 8212
ADDRGP4 UI_ParseInfos
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
line 103
;103:}
LABELV $118
endproc UI_LoadArenasFromFile 8216 16
export UI_LoadArenas
proc UI_LoadArenas 1540 16
line 110
;104:
;105:/*
;106:===============
;107:UI_LoadArenas
;108:===============
;109:*/
;110:void UI_LoadArenas(void) {
line 120
;111:	int			numdirs;
;112:	vmCvar_t	arenasFile;
;113:	char		filename[128];
;114:	char		dirlist[1024];
;115:	char *dirptr;
;116:	int			i, n;
;117:	int			dirlen;
;118:	char *type;
;119:
;120:	ui_numArenas = 0;
ADDRGP4 ui_numArenas
CNSTI4 0
ASGNI4
line 121
;121:	uiInfo.mapCount = 0;
ADDRGP4 uiInfo+83224
CNSTI4 0
ASGNI4
line 123
;122:
;123:	trap_Cvar_Register(&arenasFile, "g_arenasFile", "", CVAR_INIT | CVAR_ROM);
ADDRLP4 152
ARGP4
ADDRGP4 $127
ARGP4
ADDRGP4 $128
ARGP4
CNSTI4 80
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 124
;124:	if (*arenasFile.string) {
ADDRLP4 152+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $129
line 125
;125:		UI_LoadArenasFromFile(arenasFile.string);
ADDRLP4 152+16
ARGP4
ADDRGP4 UI_LoadArenasFromFile
CALLV
pop
line 126
;126:	} else {
ADDRGP4 $130
JUMPV
LABELV $129
line 127
;127:		UI_LoadArenasFromFile("scripts/arenas.txt");
ADDRGP4 $133
ARGP4
ADDRGP4 UI_LoadArenasFromFile
CALLV
pop
line 128
;128:	}
LABELV $130
line 131
;129:
;130:	// get all arenas from .arena files
;131:	numdirs = trap_FS_GetFileList("scripts", ".arena", dirlist, 1024);
ADDRGP4 $134
ARGP4
ADDRGP4 $135
ARGP4
ADDRLP4 424
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1448
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 1448
INDIRI4
ASGNI4
line 132
;132:	dirptr = dirlist;
ADDRLP4 8
ADDRLP4 424
ASGNP4
line 133
;133:	for (i = 0; i < numdirs; i++, dirptr += dirlen + 1) {
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRGP4 $139
JUMPV
LABELV $136
line 134
;134:		dirlen = strlen(dirptr);
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1452
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 144
ADDRLP4 1452
INDIRI4
ASGNI4
line 135
;135:		strcpy(filename, "scripts/");
ADDRLP4 12
ARGP4
ADDRGP4 $140
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 136
;136:		strcat(filename, dirptr);
ADDRLP4 12
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 137
;137:		UI_LoadArenasFromFile(filename);
ADDRLP4 12
ARGP4
ADDRGP4 UI_LoadArenasFromFile
CALLV
pop
line 138
;138:	}
LABELV $137
line 133
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 8
INDIRP4
ADDP4
ASGNP4
LABELV $139
ADDRLP4 140
INDIRI4
ADDRLP4 148
INDIRI4
LTI4 $136
line 139
;139:	trap_Print(va("%i arenas parsed\n", ui_numArenas));
ADDRGP4 $141
ARGP4
ADDRGP4 ui_numArenas
INDIRI4
ARGI4
ADDRLP4 1452
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1452
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 140
;140:	if (UI_OutOfMemory()) {
ADDRLP4 1456
ADDRGP4 UI_OutOfMemory
CALLI4
ASGNI4
ADDRLP4 1456
INDIRI4
CNSTI4 0
EQI4 $142
line 141
;141:		trap_Print(S_COLOR_YELLOW"WARNING: not anough memory in pool to load all arenas\n");
ADDRGP4 $144
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 142
;142:	}
LABELV $142
line 144
;143:
;144:	for (n = 0; n < ui_numArenas; n++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $148
JUMPV
LABELV $145
line 147
;145:		// determine type
;146:
;147:		uiInfo.mapList[uiInfo.mapCount].cinematic = -1;
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+24
ADDP4
CNSTI4 -1
ASGNI4
line 148
;148:		uiInfo.mapList[uiInfo.mapCount].mapLoadName = String_Alloc(Info_ValueForKey(ui_arenaInfos[n], "map"));
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_arenaInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $155
ARGP4
ADDRLP4 1460
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1460
INDIRP4
ARGP4
ADDRLP4 1464
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+4
ADDP4
ADDRLP4 1464
INDIRP4
ASGNP4
line 149
;149:		uiInfo.mapList[uiInfo.mapCount].mapName = String_Alloc(Info_ValueForKey(ui_arenaInfos[n], "longname"));
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_arenaInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $158
ARGP4
ADDRLP4 1468
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1468
INDIRP4
ARGP4
ADDRLP4 1472
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228
ADDP4
ADDRLP4 1472
INDIRP4
ASGNP4
line 150
;150:		uiInfo.mapList[uiInfo.mapCount].levelShot = -1;
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+92
ADDP4
CNSTI4 -1
ASGNI4
line 151
;151:		uiInfo.mapList[uiInfo.mapCount].imageName = String_Alloc(va("levelshots/%s", uiInfo.mapList[uiInfo.mapCount].mapLoadName));
ADDRGP4 $165
ARGP4
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1476
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1476
INDIRP4
ARGP4
ADDRLP4 1480
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+8
ADDP4
ADDRLP4 1480
INDIRP4
ASGNP4
line 152
;152:		uiInfo.mapList[uiInfo.mapCount].typeBits = 0;
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+20
ADDP4
CNSTI4 0
ASGNI4
line 154
;153:
;154:		type = Info_ValueForKey(ui_arenaInfos[n], "type");
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_arenaInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $172
ARGP4
ADDRLP4 1484
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1484
INDIRP4
ASGNP4
line 156
;155:		// if no type specified, it will be treated as "ffa"
;156:		if (*type) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $173
line 157
;157:			if (strstr(type, "ffa")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $177
ARGP4
ADDRLP4 1488
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 1488
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $175
line 158
;158:				uiInfo.mapList[uiInfo.mapCount].typeBits |= (1 << GT_FFA);
ADDRLP4 1492
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+20
ADDP4
ASGNP4
ADDRLP4 1492
INDIRP4
ADDRLP4 1492
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 159
;159:			}
LABELV $175
line 160
;160:			if (strstr(type, "duel")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $183
ARGP4
ADDRLP4 1492
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 1492
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $181
line 161
;161:				uiInfo.mapList[uiInfo.mapCount].typeBits |= (1 << GT_DUEL);
ADDRLP4 1496
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+20
ADDP4
ASGNP4
ADDRLP4 1496
INDIRP4
ADDRLP4 1496
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 162
;162:			}
LABELV $181
line 163
;163:			if (strstr(type, "race")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $189
ARGP4
ADDRLP4 1496
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 1496
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $187
line 164
;164:				uiInfo.mapList[uiInfo.mapCount].typeBits |= (1 << GT_RACE);
ADDRLP4 1500
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+20
ADDP4
ASGNP4
ADDRLP4 1500
INDIRP4
ADDRLP4 1500
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 165
;165:			}
LABELV $187
line 166
;166:			if (strstr(type, "ca")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $195
ARGP4
ADDRLP4 1500
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 1500
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $193
line 167
;167:				uiInfo.mapList[uiInfo.mapCount].typeBits |= (1 << GT_CA);
ADDRLP4 1504
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+20
ADDP4
ASGNP4
ADDRLP4 1504
INDIRP4
ADDRLP4 1504
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 168
;168:			}
LABELV $193
line 169
;169:			if (strstr(type, "ctf")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $201
ARGP4
ADDRLP4 1504
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 1504
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $199
line 170
;170:				uiInfo.mapList[uiInfo.mapCount].typeBits |= (1 << GT_CTF);
ADDRLP4 1508
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+20
ADDP4
ASGNP4
ADDRLP4 1508
INDIRP4
ADDRLP4 1508
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 171
;171:			}
LABELV $199
line 172
;172:			if (strstr(type, "oneflag")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $207
ARGP4
ADDRLP4 1508
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 1508
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $205
line 173
;173:				uiInfo.mapList[uiInfo.mapCount].typeBits |= (1 << GT_1FCTF);
ADDRLP4 1512
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+20
ADDP4
ASGNP4
ADDRLP4 1512
INDIRP4
ADDRLP4 1512
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 174
;174:			}
LABELV $205
line 175
;175:			if (strstr(type, "ob")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $213
ARGP4
ADDRLP4 1512
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 1512
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $211
line 176
;176:				uiInfo.mapList[uiInfo.mapCount].typeBits |= (1 << GT_OBELISK);
ADDRLP4 1516
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+20
ADDP4
ASGNP4
ADDRLP4 1516
INDIRP4
ADDRLP4 1516
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 177
;177:			}
LABELV $211
line 178
;178:			if (strstr(type, "har")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $219
ARGP4
ADDRLP4 1516
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 1516
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $217
line 179
;179:				uiInfo.mapList[uiInfo.mapCount].typeBits |= (1 << GT_HARVESTER);
ADDRLP4 1520
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+20
ADDP4
ASGNP4
ADDRLP4 1520
INDIRP4
ADDRLP4 1520
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 180
;180:			}
LABELV $217
line 181
;181:			if (strstr(type, "ft")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $225
ARGP4
ADDRLP4 1520
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 1520
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $223
line 182
;182:				uiInfo.mapList[uiInfo.mapCount].typeBits |= (1 << GT_FREEZE);
ADDRLP4 1524
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+20
ADDP4
ASGNP4
ADDRLP4 1524
INDIRP4
ADDRLP4 1524
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 183
;183:			}
LABELV $223
line 184
;184:			if (strstr(type, "dom")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $231
ARGP4
ADDRLP4 1524
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 1524
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $229
line 185
;185:				uiInfo.mapList[uiInfo.mapCount].typeBits |= (1 << GT_DOM);
ADDRLP4 1528
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+20
ADDP4
ASGNP4
ADDRLP4 1528
INDIRP4
ADDRLP4 1528
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 186
;186:			}
LABELV $229
line 187
;187:			if (strstr(type, "ad")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $237
ARGP4
ADDRLP4 1528
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 1528
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $235
line 188
;188:				uiInfo.mapList[uiInfo.mapCount].typeBits |= (1 << GT_AD);
ADDRLP4 1532
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+20
ADDP4
ASGNP4
ADDRLP4 1532
INDIRP4
ADDRLP4 1532
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
line 189
;189:			}
LABELV $235
line 190
;190:			if (strstr(type, "rr")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $243
ARGP4
ADDRLP4 1532
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 1532
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $174
line 191
;191:				uiInfo.mapList[uiInfo.mapCount].typeBits |= (1 << GT_RR);
ADDRLP4 1536
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+20
ADDP4
ASGNP4
ADDRLP4 1536
INDIRP4
ADDRLP4 1536
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 192
;192:			}
line 193
;193:		} else {
ADDRGP4 $174
JUMPV
LABELV $173
line 194
;194:			uiInfo.mapList[uiInfo.mapCount].typeBits |= (1 << GT_FFA);
ADDRLP4 1488
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+83228+20
ADDP4
ASGNP4
ADDRLP4 1488
INDIRP4
ADDRLP4 1488
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 195
;195:		}
LABELV $174
line 197
;196:
;197:		uiInfo.mapCount++;
ADDRLP4 1488
ADDRGP4 uiInfo+83224
ASGNP4
ADDRLP4 1488
INDIRP4
ADDRLP4 1488
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 198
;198:		if (uiInfo.mapCount >= MAX_MAPS) {
ADDRGP4 uiInfo+83224
INDIRI4
CNSTI4 128
LTI4 $251
line 199
;199:			break;
ADDRGP4 $147
JUMPV
LABELV $251
line 201
;200:		}
;201:	}
LABELV $146
line 144
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $148
ADDRLP4 4
INDIRI4
ADDRGP4 ui_numArenas
INDIRI4
LTI4 $145
LABELV $147
line 202
;202:}
LABELV $125
endproc UI_LoadArenas 1540 16
proc UI_LoadBotsFromFile 8216 16
line 210
;203:
;204:
;205:/*
;206:===============
;207:UI_LoadBotsFromFile
;208:===============
;209:*/
;210:static void UI_LoadBotsFromFile(char *filename) {
line 215
;211:	int				len;
;212:	fileHandle_t	f;
;213:	char			buf[MAX_BOTS_TEXT];
;214:
;215:	len = trap_FS_FOpenFile(filename, &f, FS_READ);
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
line 216
;216:	if (!f) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $255
line 217
;217:		trap_Print(va(S_COLOR_RED "file not found: %s\n", filename));
ADDRGP4 $121
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
line 218
;218:		return;
ADDRGP4 $254
JUMPV
LABELV $255
line 220
;219:	}
;220:	if (len >= MAX_BOTS_TEXT) {
ADDRLP4 0
INDIRI4
CNSTI4 8192
LTI4 $257
line 221
;221:		trap_Print(va(S_COLOR_RED "file too large: %s is %i, max allowed is %i", filename, len, MAX_BOTS_TEXT));
ADDRGP4 $124
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
line 222
;222:		trap_FS_FCloseFile(f);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 223
;223:		return;
ADDRGP4 $254
JUMPV
LABELV $257
line 226
;224:	}
;225:
;226:	trap_FS_Read(buf, len, f);
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
line 227
;227:	buf[len] = 0;
ADDRLP4 0
INDIRI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 228
;228:	trap_FS_FCloseFile(f);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 230
;229:
;230:	COM_Compress(buf);
ADDRLP4 8
ARGP4
ADDRGP4 COM_Compress
CALLI4
pop
line 232
;231:
;232:	ui_numBots += UI_ParseInfos(buf, MAX_BOTS - ui_numBots, &ui_botInfos[ui_numBots]);
ADDRLP4 8
ARGP4
ADDRLP4 8204
ADDRGP4 ui_numBots
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
ADDRGP4 ui_botInfos
ADDP4
ARGP4
ADDRLP4 8212
ADDRGP4 UI_ParseInfos
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
line 233
;233:}
LABELV $254
endproc UI_LoadBotsFromFile 8216 16
export UI_LoadBots
proc UI_LoadBots 1448 16
line 240
;234:
;235:/*
;236:===============
;237:UI_LoadBots
;238:===============
;239:*/
;240:void UI_LoadBots(void) {
line 249
;241:	vmCvar_t	botsFile;
;242:	int			numdirs;
;243:	char		filename[128];
;244:	char		dirlist[1024];
;245:	char *dirptr;
;246:	int			i;
;247:	int			dirlen;
;248:
;249:	ui_numBots = 0;
ADDRGP4 ui_numBots
CNSTI4 0
ASGNI4
line 251
;250:
;251:	trap_Cvar_Register(&botsFile, "g_botsFile", "", CVAR_INIT | CVAR_ROM);
ADDRLP4 144
ARGP4
ADDRGP4 $260
ARGP4
ADDRGP4 $128
ARGP4
CNSTI4 80
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 252
;252:	if (*botsFile.string) {
ADDRLP4 144+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $261
line 253
;253:		UI_LoadBotsFromFile(botsFile.string);
ADDRLP4 144+16
ARGP4
ADDRGP4 UI_LoadBotsFromFile
CALLV
pop
line 254
;254:	} else {
ADDRGP4 $262
JUMPV
LABELV $261
line 255
;255:		UI_LoadBotsFromFile("scripts/bots.txt");
ADDRGP4 $265
ARGP4
ADDRGP4 UI_LoadBotsFromFile
CALLV
pop
line 256
;256:	}
LABELV $262
line 259
;257:
;258:	// get all bots from .bot files
;259:	numdirs = trap_FS_GetFileList("scripts", ".bot", dirlist, 1024);
ADDRGP4 $134
ARGP4
ADDRGP4 $266
ARGP4
ADDRLP4 416
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1440
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 140
ADDRLP4 1440
INDIRI4
ASGNI4
line 260
;260:	dirptr = dirlist;
ADDRLP4 0
ADDRLP4 416
ASGNP4
line 261
;261:	for (i = 0; i < numdirs; i++, dirptr += dirlen + 1) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $270
JUMPV
LABELV $267
line 262
;262:		dirlen = strlen(dirptr);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1444
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 136
ADDRLP4 1444
INDIRI4
ASGNI4
line 263
;263:		strcpy(filename, "scripts/");
ADDRLP4 4
ARGP4
ADDRGP4 $140
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 264
;264:		strcat(filename, dirptr);
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 265
;265:		UI_LoadBotsFromFile(filename);
ADDRLP4 4
ARGP4
ADDRGP4 UI_LoadBotsFromFile
CALLV
pop
line 266
;266:	}
LABELV $268
line 261
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
LABELV $270
ADDRLP4 132
INDIRI4
ADDRLP4 140
INDIRI4
LTI4 $267
line 267
;267:	trap_Print(va("%i bots parsed\n", ui_numBots));
ADDRGP4 $271
ARGP4
ADDRGP4 ui_numBots
INDIRI4
ARGI4
ADDRLP4 1444
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1444
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 268
;268:}
LABELV $259
endproc UI_LoadBots 1448 16
export UI_GetBotInfoByNumber
proc UI_GetBotInfoByNumber 8 8
line 276
;269:
;270:
;271:/*
;272:===============
;273:UI_GetBotInfoByNumber
;274:===============
;275:*/
;276:char *UI_GetBotInfoByNumber(int num) {
line 277
;277:	if (num < 0 || num >= ui_numBots) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $275
ADDRLP4 0
INDIRI4
ADDRGP4 ui_numBots
INDIRI4
LTI4 $273
LABELV $275
line 278
;278:		trap_Print(va(S_COLOR_RED "Invalid bot number: %i\n", num));
ADDRGP4 $276
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
line 279
;279:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $272
JUMPV
LABELV $273
line 281
;280:	}
;281:	return ui_botInfos[num];
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_botInfos
ADDP4
INDIRP4
RETP4
LABELV $272
endproc UI_GetBotInfoByNumber 8 8
export UI_GetBotInfoByName
proc UI_GetBotInfoByName 16 8
line 290
;282:}
;283:
;284:
;285:/*
;286:===============
;287:UI_GetBotInfoByName
;288:===============
;289:*/
;290:char *UI_GetBotInfoByName(const char *name) {
line 294
;291:	int		n;
;292:	char *value;
;293:
;294:	for (n = 0; n < ui_numBots; n++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $281
JUMPV
LABELV $278
line 295
;295:		value = Info_ValueForKey(ui_botInfos[n], "name");
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_botInfos
ADDP4
INDIRP4
ARGP4
ADDRGP4 $282
ARGP4
ADDRLP4 8
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 296
;296:		if (!Q_stricmp(value, name)) {
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
NEI4 $283
line 297
;297:			return ui_botInfos[n];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_botInfos
ADDP4
INDIRP4
RETP4
ADDRGP4 $277
JUMPV
LABELV $283
line 299
;298:		}
;299:	}
LABELV $279
line 294
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $281
ADDRLP4 0
INDIRI4
ADDRGP4 ui_numBots
INDIRI4
LTI4 $278
line 301
;300:
;301:	return NULL;
CNSTP4 0
RETP4
LABELV $277
endproc UI_GetBotInfoByName 16 8
export UI_GetNumBots
proc UI_GetNumBots 0 0
line 304
;302:}
;303:
;304:int UI_GetNumBots() {
line 305
;305:	return ui_numBots;
ADDRGP4 ui_numBots
INDIRI4
RETI4
LABELV $285
endproc UI_GetNumBots 0 0
export UI_GetBotNameByNumber
proc UI_GetBotNameByNumber 12 8
line 309
;306:}
;307:
;308:
;309:char *UI_GetBotNameByNumber(int num) {
line 310
;310:	char *info = UI_GetBotInfoByNumber(num);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 UI_GetBotInfoByNumber
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 311
;311:	if (info) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $287
line 312
;312:		return Info_ValueForKey(info, "name");
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $282
ARGP4
ADDRLP4 8
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
RETP4
ADDRGP4 $286
JUMPV
LABELV $287
line 314
;313:	}
;314:	return "Sarge";
ADDRGP4 $289
RETP4
LABELV $286
endproc UI_GetBotNameByNumber 12 8
bss
align 4
LABELV ui_arenaInfos
skip 4096
align 4
LABELV ui_numArenas
skip 4
align 4
LABELV ui_botInfos
skip 4096
export ui_numBots
align 4
LABELV ui_numBots
skip 4
import UI_RankStatusMenu
import RankStatus_Cache
import UI_SignupMenu
import Signup_Cache
import UI_LoginMenu
import Login_Cache
import UI_InitGameinfo
import UI_SPUnlockMedals_f
import UI_SPUnlock_f
import UI_GetAwardLevel
import UI_LogAwardData
import UI_NewGame
import UI_GetCurrentGame
import UI_CanShowTierVideo
import UI_ShowTierVideo
import UI_TierCompleted
import UI_SetBestScore
import UI_GetBestScore
import UI_GetNumSPTiers
import UI_GetNumSPArenas
import UI_GetNumArenas
import UI_GetSpecialArenaInfo
import UI_GetArenaInfoByMap
import UI_GetArenaInfoByNumber
import UI_NetworkOptionsMenu
import UI_NetworkOptionsMenu_Cache
import UI_SoundOptionsMenu
import UI_SoundOptionsMenu_Cache
import UI_DisplayOptionsMenu
import UI_DisplayOptionsMenu_Cache
import UI_SaveConfigMenu
import UI_SaveConfigMenu_Cache
import UI_LoadConfigMenu
import UI_LoadConfig_Cache
import UI_TeamOrdersMenu_Cache
import UI_TeamOrdersMenu_f
import UI_TeamOrdersMenu
import UI_RemoveBotsMenu
import UI_RemoveBots_Cache
import UI_AddBotsMenu
import UI_AddBots_Cache
import trap_SetPbClStatus
import trap_VerifyCDKey
import trap_R_RemapShader
import trap_RealTime
import trap_CIN_SetExtents
import trap_CIN_DrawCinematic
import trap_CIN_RunCinematic
import trap_CIN_StopCinematic
import trap_CIN_PlayCinematic
import trap_S_StartBackgroundTrack
import trap_S_StopBackgroundTrack
import trap_R_RegisterFont
import trap_SetCDKey
import trap_GetCDKey
import trap_MemoryRemaining
import trap_LAN_CompareServers
import trap_LAN_ServerStatus
import trap_LAN_ResetPings
import trap_LAN_RemoveServer
import trap_LAN_AddServer
import trap_LAN_UpdateVisiblePings
import trap_LAN_ServerIsVisible
import trap_LAN_MarkServerVisible
import trap_LAN_SaveCachedServers
import trap_LAN_LoadCachedServers
import trap_LAN_GetPingInfo
import trap_LAN_GetPing
import trap_LAN_ClearPing
import trap_LAN_GetPingQueueCount
import trap_LAN_GetServerPing
import trap_LAN_GetServerInfo
import trap_LAN_GetServerAddressString
import trap_LAN_GetServerCount
import trap_GetConfigString
import trap_GetGlconfig
import trap_GetClientState
import trap_GetClipboardData
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_ClearStates
import trap_Key_SetOverstrikeMode
import trap_Key_GetOverstrikeMode
import trap_Key_IsDown
import trap_Key_SetBinding
import trap_Key_GetBindingBuf
import trap_Key_KeynumToStringBuf
import trap_S_RegisterSound
import trap_S_StartLocalSound
import trap_CM_LerpTag
import trap_UpdateScreen
import trap_R_ModelBounds
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_AddLightToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Cmd_ExecuteText
import trap_Argv
import trap_Argc
import trap_Cvar_InfoStringBuffer
import trap_Cvar_Create
import trap_Cvar_Reset
import trap_Cvar_SetValue
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import UI_SPSkillMenu_Cache
import UI_SPSkillMenu
import UI_SPPostgameMenu_f
import UI_SPPostgameMenu_Cache
import UI_SPArena_Start
import UI_SPLevelMenu_ReInit
import UI_SPLevelMenu_f
import UI_SPLevelMenu
import UI_SPLevelMenu_Cache
import uis
import UI_LoadBestScores
import m_entersound
import UI_StartDemoLoop
import UI_Cvar_VariableString
import UI_Argv
import UI_ForceMenuOff
import UI_PopMenu
import UI_PushMenu
import UI_SetActiveMenu
import UI_IsFullscreen
import UI_DrawTextBox
import UI_AdjustFrom640
import UI_CursorInRect
import UI_DrawChar
import UI_DrawString
import UI_ProportionalStringWidth
import UI_DrawProportionalString
import UI_ProportionalSizeScale
import UI_DrawBannerString
import UI_LerpColor
import UI_SetColor
import UI_UpdateScreen
import UI_DrawSides
import UI_DrawTopBottom
import UI_DrawRect
import UI_FillRect
import UI_DrawHandlePic
import UI_DrawNamedPic
import UI_ClampCvar
import UI_ConsoleCommand
import UI_Refresh
import UI_MouseEvent
import UI_KeyEvent
import UI_Shutdown
import UI_Init
import uiInfo
import UI_RegisterClientModelname
import UI_PlayerInfo_SetInfo
import UI_PlayerInfo_SetModel
import UI_DrawPlayer
import DriverInfo_Cache
import GraphicsOptions_Cache
import UI_GraphicsOptionsMenu
import ServerInfo_Cache
import UI_ServerInfoMenu
import UI_BotSelectMenu_Cache
import UI_BotSelectMenu
import ServerOptions_Cache
import StartServer_Cache
import UI_StartServerMenu
import ArenaServers_Cache
import UI_ArenaServersMenu
import SpecifyServer_Cache
import UI_SpecifyServerMenu
import SpecifyLeague_Cache
import UI_SpecifyLeagueMenu
import Preferences_Cache
import UI_PreferencesMenu
import PlayerSettings_Cache
import UI_PlayerSettingsMenu
import PlayerModel_Cache
import UI_PlayerModelMenu
import UI_CDKeyMenu_f
import UI_CDKeyMenu_Cache
import UI_CDKeyMenu
import UI_ModsMenu_Cache
import UI_ModsMenu
import UI_CinematicsMenu_Cache
import UI_CinematicsMenu_f
import UI_CinematicsMenu
import Demos_Cache
import UI_DemosMenu
import Controls_Cache
import UI_ControlsMenu
import UI_DrawConnectScreen
import TeamMain_Cache
import UI_TeamMainMenu
import UI_SetupMenu
import UI_SetupMenu_Cache
import UI_ConfirmMenu
import ConfirmMenu_Cache
import UI_InGameMenu
import InGame_Cache
import UI_CreditMenu
import UI_UpdateCvars
import UI_RegisterCvars
import UI_MainMenu
import MainMenu_Cache
import UI_ClearScores
import UI_ShowPostGame
import UI_AdjustTimeByGame
import _UI_SetActiveMenu
import UI_LoadMenus
import UI_Load
import UI_Report
import MenuField_Key
import MenuField_Draw
import MenuField_Init
import MField_Draw
import MField_CharEvent
import MField_KeyDownEvent
import MField_Clear
import ui_medalSounds
import ui_medalPicNames
import ui_medalNames
import text_color_highlight
import text_color_normal
import text_color_disabled
import listbar_color
import list_color
import name_color
import color_dim
import color_red
import color_orange
import color_blue
import color_yellow
import color_white
import color_black
import menu_dim_color
import menu_black_color
import menu_red_color
import menu_highlight_color
import menu_dark_color
import menu_grayed_color
import menu_text_color
import weaponChangeSound
import menu_null_sound
import menu_buzz_sound
import menu_out_sound
import menu_move_sound
import menu_in_sound
import ScrollList_Key
import ScrollList_Draw
import Bitmap_Draw
import Bitmap_Init
import Menu_DefaultKey
import Menu_SetCursorToItem
import Menu_SetCursor
import Menu_ActivateItem
import Menu_ItemAtCursor
import Menu_Draw
import Menu_AdjustCursor
import Menu_AddItem
import Menu_Focus
import Menu_Cache
import ui_serverStatusTimeOut
import ui_realCaptureLimit
import ui_realWarmUp
import ui_teamArenaFirstRun
import ui_recordSPDemo
import ui_hudFiles
import ui_Q3Model
import ui_findPlayer
import ui_bigFont
import ui_smallFont
import ui_captureLimit
import ui_fragLimit
import ui_scoreShutoutBonus
import ui_scoreSkillBonus
import ui_scoreTimeBonus
import ui_scoreTime
import ui_scoreBase
import ui_scoreTeam
import ui_scorePerfect
import ui_scoreScore
import ui_scoreGauntlets
import ui_scoreAssists
import ui_scoreDefends
import ui_scoreCaptures
import ui_scoreExcellents
import ui_scoreImpressives
import ui_scoreAccuracy
import ui_singlePlayerActive
import ui_lastServerRefresh_3
import ui_lastServerRefresh_2
import ui_lastServerRefresh_1
import ui_lastServerRefresh_0
import ui_selectedPlayerName
import ui_selectedPlayer
import ui_currentOpponent
import ui_mapIndex
import ui_currentNetMap
import ui_currentMap
import ui_currentTier
import ui_menuFiles
import ui_serverFilterType
import ui_netSource
import ui_blueteam5
import ui_blueteam4
import ui_blueteam3
import ui_blueteam2
import ui_blueteam1
import ui_redteam5
import ui_redteam4
import ui_redteam3
import ui_redteam2
import ui_redteam1
import ui_actualNetGameType
import ui_netGameType
import ui_joinGameType
import ui_gameType
import ui_dedicated
import ui_blueteam
import ui_redteam
import ui_opponentName
import ui_teamName
import ui_initialized
import ui_debug
import ui_new
import ui_cdkeychecked
import ui_server16
import ui_server15
import ui_server14
import ui_server13
import ui_server12
import ui_server11
import ui_server10
import ui_server9
import ui_server8
import ui_server7
import ui_server6
import ui_server5
import ui_server4
import ui_server3
import ui_server2
import ui_server1
import ui_marks
import ui_drawCrosshairNames
import ui_drawCrosshair
import ui_brassTime
import ui_browserShowEmpty
import ui_browserShowFull
import ui_browserSortKey
import ui_browserGameType
import ui_browserMaster
import ui_spSelection
import ui_spSkill
import ui_spVideos
import ui_spAwards
import ui_spScores5
import ui_spScores4
import ui_spScores3
import ui_spScores2
import ui_spScores1
import ui_botsFile
import ui_arenasFile
import ui_ctf_friendly
import ui_ctf_timelimit
import ui_ctf_capturelimit
import ui_team_friendly
import ui_team_timelimit
import ui_team_fraglimit
import ui_tourney_timelimit
import ui_tourney_fraglimit
import ui_ffa_timelimit
import ui_ffa_fraglimit
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
LABELV $289
byte 1 83
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $282
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $276
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
LABELV $271
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
LABELV $266
byte 1 46
byte 1 98
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $265
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
LABELV $260
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
LABELV $243
byte 1 114
byte 1 114
byte 1 0
align 1
LABELV $237
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $231
byte 1 100
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $225
byte 1 102
byte 1 116
byte 1 0
align 1
LABELV $219
byte 1 104
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $213
byte 1 111
byte 1 98
byte 1 0
align 1
LABELV $207
byte 1 111
byte 1 110
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $201
byte 1 99
byte 1 116
byte 1 102
byte 1 0
align 1
LABELV $195
byte 1 99
byte 1 97
byte 1 0
align 1
LABELV $189
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $183
byte 1 100
byte 1 117
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $177
byte 1 102
byte 1 102
byte 1 97
byte 1 0
align 1
LABELV $172
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $165
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $158
byte 1 108
byte 1 111
byte 1 110
byte 1 103
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $155
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $144
byte 1 94
byte 1 51
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 97
byte 1 110
byte 1 111
byte 1 117
byte 1 103
byte 1 104
byte 1 32
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 112
byte 1 111
byte 1 111
byte 1 108
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $141
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
LABELV $140
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
LABELV $135
byte 1 46
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 0
align 1
LABELV $134
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $133
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
LABELV $128
byte 1 0
align 1
LABELV $127
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
LABELV $124
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
LABELV $121
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
LABELV $115
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $114
byte 1 92
byte 1 110
byte 1 117
byte 1 109
byte 1 92
byte 1 0
align 1
LABELV $113
byte 1 60
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 62
byte 1 0
align 1
LABELV $110
byte 1 125
byte 1 0
align 1
LABELV $107
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
LABELV $101
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
LABELV $98
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
LABELV $97
byte 1 123
byte 1 0

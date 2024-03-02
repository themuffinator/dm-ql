export Com_Error
code
proc Com_Error 1032 12
file "..\..\..\..\code\ui\ui_atoms.c"
line 15
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/**********************************************************************
;4:	UI_ATOMS.C
;5:
;6:	User interface building blocks and support functions.
;7:**********************************************************************/
;8:#include "ui_local.h"
;9:
;10:qboolean		m_entersound;		// after a frame, so caching won't disrupt the sound
;11:
;12:// these are here so the functions in q_shared.c can link
;13:#ifndef UI_HARD_LINKED
;14:
;15:void QDECL Com_Error( int level, const char *error, ... ) {
line 19
;16:	va_list		argptr;
;17:	char		text[1024];
;18:
;19:	va_start (argptr, error);
ADDRLP4 0
ADDRFP4 4+4
ASGNP4
line 20
;20:	ED_vsprintf (text, error, argptr);
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
line 21
;21:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 23
;22:
;23:	trap_Error( va("%s", text) );
ADDRGP4 $90
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1028
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 24
;24:}
LABELV $88
endproc Com_Error 1032 12
export Com_Printf
proc Com_Printf 1032 12
line 26
;25:
;26:void QDECL Com_Printf( const char *msg, ... ) {
line 30
;27:	va_list		argptr;
;28:	char		text[1024];
;29:
;30:	va_start (argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 31
;31:	ED_vsprintf (text, msg, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ED_vsprintf
CALLI4
pop
line 32
;32:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 34
;33:
;34:	trap_Print( va("%s", text) );
ADDRGP4 $90
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 1028
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 35
;35:}
LABELV $91
endproc Com_Printf 1032 12
data
export newUI
align 4
LABELV newUI
byte 4 0
export UI_ClampCvar
code
proc UI_ClampCvar 0 0
line 48
;36:
;37:#endif
;38:
;39:qboolean newUI = qfalse;
;40:
;41:
;42:/*
;43:=================
;44:UI_ClampCvar
;45:=================
;46:*/
;47:float UI_ClampCvar( float min, float max, float value )
;48:{
line 49
;49:	if ( value < min ) return min;
ADDRFP4 8
INDIRF4
ADDRFP4 0
INDIRF4
GEF4 $94
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $93
JUMPV
LABELV $94
line 50
;50:	if ( value > max ) return max;
ADDRFP4 8
INDIRF4
ADDRFP4 4
INDIRF4
LEF4 $96
ADDRFP4 4
INDIRF4
RETF4
ADDRGP4 $93
JUMPV
LABELV $96
line 51
;51:	return value;
ADDRFP4 8
INDIRF4
RETF4
LABELV $93
endproc UI_ClampCvar 0 0
export UI_StartDemoLoop
proc UI_StartDemoLoop 0 8
line 59
;52:}
;53:
;54:/*
;55:=================
;56:UI_StartDemoLoop
;57:=================
;58:*/
;59:void UI_StartDemoLoop( void ) {
line 60
;60:	trap_Cmd_ExecuteText( EXEC_APPEND, "d1\n" );
CNSTI4 2
ARGI4
ADDRGP4 $99
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 61
;61:}
LABELV $98
endproc UI_StartDemoLoop 0 8
bss
align 1
LABELV $101
skip 1024
export UI_Argv
code
proc UI_Argv 0 12
line 63
;62:
;63:char *UI_Argv( int arg ) {
line 66
;64:	static char	buffer[MAX_STRING_CHARS];
;65:
;66:	trap_Argv( arg, buffer, sizeof( buffer ) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $101
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 68
;67:
;68:	return buffer;
ADDRGP4 $101
RETP4
LABELV $100
endproc UI_Argv 0 12
bss
align 1
LABELV $103
skip 1024
export UI_Cvar_VariableString
code
proc UI_Cvar_VariableString 0 12
line 72
;69:}
;70:
;71:
;72:char *UI_Cvar_VariableString( const char *var_name ) {
line 75
;73:	static char	buffer[MAX_STRING_CHARS];
;74:
;75:	trap_Cvar_VariableStringBuffer( var_name, buffer, sizeof( buffer ) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $103
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 77
;76:
;77:	return buffer;
ADDRGP4 $103
RETP4
LABELV $102
endproc UI_Cvar_VariableString 0 12
export UI_SetBestScores
proc UI_SetBestScores 136 12
line 80
;78:}
;79:
;80:void UI_SetBestScores(postGameInfo_t *newInfo, qboolean postGame) {
line 81
;81:	trap_Cvar_Set("ui_scoreAccuracy",     va("%i%%", newInfo->accuracy));
ADDRGP4 $106
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $105
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 82
;82:	trap_Cvar_Set("ui_scoreImpressives",	va("%i", newInfo->impressives));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $107
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 83
;83:	trap_Cvar_Set("ui_scoreExcellents", 	va("%i", newInfo->excellents));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $109
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 84
;84:	trap_Cvar_Set("ui_scoreDefends", 			va("%i", newInfo->defends));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $110
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 85
;85:	trap_Cvar_Set("ui_scoreAssists", 			va("%i", newInfo->assists));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $111
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 86
;86:	trap_Cvar_Set("ui_scoreGauntlets", 		va("%i", newInfo->gauntlets));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $112
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 87
;87:	trap_Cvar_Set("ui_scoreScore", 				va("%i", newInfo->score));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $113
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 88
;88:	trap_Cvar_Set("ui_scorePerfect",	 		va("%i", newInfo->perfects));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $114
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 89
;89:	trap_Cvar_Set("ui_scoreTeam",					va("%i to %i", newInfo->redScore, newInfo->blueScore));
ADDRGP4 $116
ARGP4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $115
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 90
;90:	trap_Cvar_Set("ui_scoreBase",					va("%i", newInfo->baseScore));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $117
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 91
;91:	trap_Cvar_Set("ui_scoreTimeBonus",		va("%i", newInfo->timeBonus));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $118
ARGP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 92
;92:	trap_Cvar_Set("ui_scoreSkillBonus",		va("%i", newInfo->skillBonus));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $119
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 93
;93:	trap_Cvar_Set("ui_scoreShutoutBonus",	va("%i", newInfo->shutoutBonus));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $120
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 94
;94:	trap_Cvar_Set("ui_scoreTime",					va("%02i:%02i", newInfo->time / 60, newInfo->time % 60));
ADDRGP4 $122
ARGP4
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 60
DIVI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 60
MODI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $121
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 95
;95:	trap_Cvar_Set("ui_scoreCaptures",		va("%i", newInfo->captures));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $123
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 96
;96:  if (postGame) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $124
line 97
;97:		trap_Cvar_Set("ui_scoreAccuracy2",     va("%i%%", newInfo->accuracy));
ADDRGP4 $106
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $126
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 98
;98:		trap_Cvar_Set("ui_scoreImpressives2",	va("%i", newInfo->impressives));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $127
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 99
;99:		trap_Cvar_Set("ui_scoreExcellents2", 	va("%i", newInfo->excellents));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ARGI4
ADDRLP4 76
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $128
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 100
;100:		trap_Cvar_Set("ui_scoreDefends2", 			va("%i", newInfo->defends));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 80
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $129
ARGP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 101
;101:		trap_Cvar_Set("ui_scoreAssists2", 			va("%i", newInfo->assists));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $130
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 102
;102:		trap_Cvar_Set("ui_scoreGauntlets2", 		va("%i", newInfo->gauntlets));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $131
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 103
;103:		trap_Cvar_Set("ui_scoreScore2", 				va("%i", newInfo->score));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRLP4 92
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $132
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 104
;104:		trap_Cvar_Set("ui_scorePerfect2",	 		va("%i", newInfo->perfects));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRLP4 96
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $133
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 105
;105:		trap_Cvar_Set("ui_scoreTeam2",					va("%i to %i", newInfo->redScore, newInfo->blueScore));
ADDRGP4 $116
ARGP4
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
ADDRLP4 100
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 104
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $134
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 106
;106:		trap_Cvar_Set("ui_scoreBase2",					va("%i", newInfo->baseScore));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 108
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $135
ARGP4
ADDRLP4 108
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 107
;107:		trap_Cvar_Set("ui_scoreTimeBonus2",		va("%i", newInfo->timeBonus));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ARGI4
ADDRLP4 112
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $136
ARGP4
ADDRLP4 112
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 108
;108:		trap_Cvar_Set("ui_scoreSkillBonus2",		va("%i", newInfo->skillBonus));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 116
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $137
ARGP4
ADDRLP4 116
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 109
;109:		trap_Cvar_Set("ui_scoreShutoutBonus2",	va("%i", newInfo->shutoutBonus));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ARGI4
ADDRLP4 120
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $138
ARGP4
ADDRLP4 120
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 110
;110:		trap_Cvar_Set("ui_scoreTime2",					va("%02i:%02i", newInfo->time / 60, newInfo->time % 60));
ADDRGP4 $122
ARGP4
ADDRLP4 124
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 124
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 60
DIVI4
ARGI4
ADDRLP4 124
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 60
MODI4
ARGI4
ADDRLP4 128
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $139
ARGP4
ADDRLP4 128
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 111
;111:		trap_Cvar_Set("ui_scoreCaptures2",		va("%i", newInfo->captures));
ADDRGP4 $108
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRLP4 132
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $140
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 112
;112:	}
LABELV $124
line 113
;113:}
LABELV $104
endproc UI_SetBestScores 136 12
export UI_LoadBestScores
proc UI_LoadBestScores 144 24
line 115
;114:
;115:void UI_LoadBestScores(const char *map, int game) {
line 119
;116:	char		fileName[MAX_QPATH];
;117:	fileHandle_t f;
;118:	postGameInfo_t newInfo;
;119:	memset(&newInfo, 0, sizeof(postGameInfo_t));
ADDRLP4 68
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 120
;120:	Com_sprintf(fileName, MAX_QPATH, "games/%s_%i.game", map, game);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $142
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 121
;121:	if (trap_FS_FOpenFile(fileName, &f, FS_READ) >= 0) {
ADDRLP4 0
ARGP4
ADDRLP4 64
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 132
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 0
LTI4 $143
line 122
;122:		int size = 0;
ADDRLP4 136
CNSTI4 0
ASGNI4
line 123
;123:		trap_FS_Read(&size, sizeof(int), f);
ADDRLP4 136
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 124
;124:		if (size == sizeof(postGameInfo_t)) {
ADDRLP4 136
INDIRI4
CVIU4 4
CNSTU4 64
NEU4 $145
line 125
;125:			trap_FS_Read(&newInfo, sizeof(postGameInfo_t), f);
ADDRLP4 68
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 126
;126:		}
LABELV $145
line 127
;127:		trap_FS_FCloseFile(f);
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 128
;128:	}
LABELV $143
line 129
;129:	UI_SetBestScores(&newInfo, qfalse);
ADDRLP4 68
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 UI_SetBestScores
CALLV
pop
line 131
;130:
;131:	Com_sprintf(fileName, MAX_QPATH, "demos/%s_%d.dm_%d", map, game, (int)trap_Cvar_VariableValue("protocol"));
ADDRGP4 $148
ARGP4
ADDRLP4 136
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $147
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 136
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 132
;132:	uiInfo.demoAvailable = qfalse;
ADDRGP4 uiInfo+5354364
CNSTI4 0
ASGNI4
line 133
;133:	if (trap_FS_FOpenFile(fileName, &f, FS_READ) >= 0) {
ADDRLP4 0
ARGP4
ADDRLP4 64
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 140
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
LTI4 $150
line 134
;134:		uiInfo.demoAvailable = qtrue;
ADDRGP4 uiInfo+5354364
CNSTI4 1
ASGNI4
line 135
;135:		trap_FS_FCloseFile(f);
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 136
;136:	} 
LABELV $150
line 137
;137:}
LABELV $141
endproc UI_LoadBestScores 144 24
export UI_ClearScores
proc UI_ClearScores 4200 16
line 144
;138:
;139:/*
;140:===============
;141:UI_ClearScores
;142:===============
;143:*/
;144:void UI_ClearScores() {
line 151
;145:	char	gameList[4096];
;146:	char *gameFile;
;147:	int		i, len, count, size;
;148:	fileHandle_t f;
;149:	postGameInfo_t newInfo;
;150:
;151:	count = trap_FS_GetFileList( "games", "game", gameList, sizeof(gameList) );
ADDRGP4 $154
ARGP4
ADDRGP4 $155
ARGP4
ADDRLP4 88
ARGP4
CNSTI4 4096
ARGI4
ADDRLP4 4184
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 4184
INDIRI4
ASGNI4
line 153
;152:
;153:	size = sizeof(postGameInfo_t);
ADDRLP4 20
CNSTI4 64
ASGNI4
line 154
;154:	memset(&newInfo, 0, size);
ADDRLP4 24
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 memset
CALLP4
pop
line 156
;155:
;156:	if (count > 0) {
ADDRLP4 16
INDIRI4
CNSTI4 0
LEI4 $156
line 157
;157:		gameFile = gameList;
ADDRLP4 0
ADDRLP4 88
ASGNP4
line 158
;158:		for ( i = 0; i < count; i++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $161
JUMPV
LABELV $158
line 159
;159:			len = strlen(gameFile);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4188
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 4188
INDIRI4
ASGNI4
line 160
;160:			if (trap_FS_FOpenFile(va("games/%s",gameFile), &f, FS_WRITE) >= 0) {
ADDRGP4 $164
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4192
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4192
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 4196
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 4196
INDIRI4
CNSTI4 0
LTI4 $162
line 161
;161:				trap_FS_Write(&size, sizeof(int), f);
ADDRLP4 20
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 162
;162:				trap_FS_Write(&newInfo, size, f);
ADDRLP4 24
ARGP4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 163
;163:				trap_FS_FCloseFile(f);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 164
;164:			}
LABELV $162
line 165
;165:			gameFile += len + 1;
ADDRLP4 0
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 166
;166:		}
LABELV $159
line 158
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $161
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $158
line 167
;167:	}
LABELV $156
line 169
;168:	
;169:	UI_SetBestScores(&newInfo, qfalse);
ADDRLP4 24
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 UI_SetBestScores
CALLV
pop
line 171
;170:
;171:}
LABELV $153
endproc UI_ClearScores 4200 16
proc UI_Cache_f 0 0
line 175
;172:
;173:
;174:
;175:static void	UI_Cache_f() {
line 176
;176:	Display_CacheAll();
ADDRGP4 Display_CacheAll
CALLV
pop
line 177
;177:}
LABELV $165
endproc UI_Cache_f 0 0
proc UI_CalcPostGameStats 1456 20
line 184
;178:
;179:/*
;180:=======================
;181:UI_CalcPostGameStats
;182:=======================
;183:*/
;184:static void UI_CalcPostGameStats() {
line 192
;185:	char		map[MAX_QPATH];
;186:	char		fileName[MAX_QPATH];
;187:	char		info[MAX_INFO_STRING];
;188:	fileHandle_t f;
;189:	int size, game, time, adjustedTime;
;190:	postGameInfo_t oldInfo;
;191:	postGameInfo_t newInfo;
;192:	qboolean newHigh = qfalse;
ADDRLP4 1088
CNSTI4 0
ASGNI4
line 194
;193:
;194:	trap_GetConfigString( CS_SERVERINFO, info, sizeof(info) );
CNSTI4 0
ARGI4
ADDRLP4 64
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 195
;195:	Q_strncpyz( map, Info_ValueForKey( info, "mapname" ), sizeof(map) );
ADDRLP4 64
ARGP4
ADDRGP4 $167
ARGP4
ADDRLP4 1304
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1160
ARGP4
ADDRLP4 1304
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 196
;196:	game = atoi(Info_ValueForKey(info, "g_gametype"));
ADDRLP4 64
ARGP4
ADDRGP4 $168
ARGP4
ADDRLP4 1308
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1308
INDIRP4
ARGP4
ADDRLP4 1312
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1224
ADDRLP4 1312
INDIRI4
ASGNI4
line 199
;197:
;198:	// compose file name
;199:	Com_sprintf(fileName, MAX_QPATH, "games/%s_%i.game", map, game);
ADDRLP4 1228
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $142
ARGP4
ADDRLP4 1160
ARGP4
ADDRLP4 1224
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 201
;200:	// see if we have one already
;201:	memset(&oldInfo, 0, sizeof(postGameInfo_t));
ADDRLP4 1096
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 202
;202:	if (trap_FS_FOpenFile(fileName, &f, FS_READ) >= 0) {
ADDRLP4 1228
ARGP4
ADDRLP4 1092
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1316
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 1316
INDIRI4
CNSTI4 0
LTI4 $169
line 204
;203:	// if so load it
;204:		size = 0;
ADDRLP4 1296
CNSTI4 0
ASGNI4
line 205
;205:		trap_FS_Read(&size, sizeof(int), f);
ADDRLP4 1296
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 1092
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 206
;206:		if (size == sizeof(postGameInfo_t)) {
ADDRLP4 1296
INDIRI4
CVIU4 4
CNSTU4 64
NEU4 $171
line 207
;207:			trap_FS_Read(&oldInfo, sizeof(postGameInfo_t), f);
ADDRLP4 1096
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 1092
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 208
;208:		}
LABELV $171
line 209
;209:		trap_FS_FCloseFile(f);
ADDRLP4 1092
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 210
;210:	}					 
LABELV $169
line 212
;211:
;212:	newInfo.accuracy = atoi(UI_Argv(3));
CNSTI4 3
ARGI4
ADDRLP4 1320
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1320
INDIRP4
ARGP4
ADDRLP4 1324
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+16
ADDRLP4 1324
INDIRI4
ASGNI4
line 213
;213:	newInfo.impressives = atoi(UI_Argv(4));
CNSTI4 4
ARGI4
ADDRLP4 1328
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1328
INDIRP4
ARGP4
ADDRLP4 1332
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+20
ADDRLP4 1332
INDIRI4
ASGNI4
line 214
;214:	newInfo.excellents = atoi(UI_Argv(5));
CNSTI4 5
ARGI4
ADDRLP4 1336
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1336
INDIRP4
ARGP4
ADDRLP4 1340
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+24
ADDRLP4 1340
INDIRI4
ASGNI4
line 215
;215:	newInfo.defends = atoi(UI_Argv(6));
CNSTI4 6
ARGI4
ADDRLP4 1344
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1344
INDIRP4
ARGP4
ADDRLP4 1348
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+28
ADDRLP4 1348
INDIRI4
ASGNI4
line 216
;216:	newInfo.assists = atoi(UI_Argv(7));
CNSTI4 7
ARGI4
ADDRLP4 1352
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1352
INDIRP4
ARGP4
ADDRLP4 1356
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+32
ADDRLP4 1356
INDIRI4
ASGNI4
line 217
;217:	newInfo.gauntlets = atoi(UI_Argv(8));
CNSTI4 8
ARGI4
ADDRLP4 1360
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1360
INDIRP4
ARGP4
ADDRLP4 1364
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+36
ADDRLP4 1364
INDIRI4
ASGNI4
line 218
;218:	newInfo.baseScore = atoi(UI_Argv(9));
CNSTI4 9
ARGI4
ADDRLP4 1368
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1368
INDIRP4
ARGP4
ADDRLP4 1372
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+60
ADDRLP4 1372
INDIRI4
ASGNI4
line 219
;219:	newInfo.perfects = atoi(UI_Argv(10));
CNSTI4 10
ARGI4
ADDRLP4 1376
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1376
INDIRP4
ARGP4
ADDRLP4 1380
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+12
ADDRLP4 1380
INDIRI4
ASGNI4
line 220
;220:	newInfo.redScore = atoi(UI_Argv(11));
CNSTI4 11
ARGI4
ADDRLP4 1384
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1384
INDIRP4
ARGP4
ADDRLP4 1388
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+4
ADDRLP4 1388
INDIRI4
ASGNI4
line 221
;221:	newInfo.blueScore = atoi(UI_Argv(12));
CNSTI4 12
ARGI4
ADDRLP4 1392
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1392
INDIRP4
ARGP4
ADDRLP4 1396
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+8
ADDRLP4 1396
INDIRI4
ASGNI4
line 222
;222:	time = atoi(UI_Argv(13));
CNSTI4 13
ARGI4
ADDRLP4 1400
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1400
INDIRP4
ARGP4
ADDRLP4 1404
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1300
ADDRLP4 1404
INDIRI4
ASGNI4
line 223
;223:	newInfo.captures = atoi(UI_Argv(14));
CNSTI4 14
ARGI4
ADDRLP4 1408
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 1408
INDIRP4
ARGP4
ADDRLP4 1412
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0+40
ADDRLP4 1412
INDIRI4
ASGNI4
line 225
;224:
;225:	newInfo.time = (time - trap_Cvar_VariableValue("ui_matchStartTime")) / 1000;
ADDRGP4 $185
ARGP4
ADDRLP4 1416
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0+44
ADDRLP4 1300
INDIRI4
CVIF4 4
ADDRLP4 1416
INDIRF4
SUBF4
CNSTF4 981668463
MULF4
CVFI4 4
ASGNI4
line 226
;226:	adjustedTime = uiInfo.mapList[ui_currentMap.integer].timeToBeat[game];
ADDRLP4 1292
ADDRLP4 1224
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 100
MULI4
ADDRGP4 uiInfo+5364160+28
ADDP4
ADDP4
INDIRI4
ASGNI4
line 227
;227:	if (newInfo.time < adjustedTime) { 
ADDRLP4 0+44
INDIRI4
ADDRLP4 1292
INDIRI4
GEI4 $189
line 228
;228:		newInfo.timeBonus = (adjustedTime - newInfo.time) * 10;
ADDRLP4 0+48
ADDRLP4 1292
INDIRI4
ADDRLP4 0+44
INDIRI4
SUBI4
CNSTI4 10
MULI4
ASGNI4
line 229
;229:	} else {
ADDRGP4 $190
JUMPV
LABELV $189
line 230
;230:		newInfo.timeBonus = 0;
ADDRLP4 0+48
CNSTI4 0
ASGNI4
line 231
;231:	}
LABELV $190
line 233
;232:
;233:	if (newInfo.redScore > newInfo.blueScore && newInfo.blueScore <= 0) {
ADDRLP4 0+4
INDIRI4
ADDRLP4 0+8
INDIRI4
LEI4 $195
ADDRLP4 0+8
INDIRI4
CNSTI4 0
GTI4 $195
line 234
;234:		newInfo.shutoutBonus = 100;
ADDRLP4 0+52
CNSTI4 100
ASGNI4
line 235
;235:	} else {
ADDRGP4 $196
JUMPV
LABELV $195
line 236
;236:		newInfo.shutoutBonus = 0;
ADDRLP4 0+52
CNSTI4 0
ASGNI4
line 237
;237:	}
LABELV $196
line 239
;238:
;239:	newInfo.skillBonus = trap_Cvar_VariableValue("g_spSkill");
ADDRGP4 $203
ARGP4
ADDRLP4 1420
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0+56
ADDRLP4 1420
INDIRF4
CVFI4 4
ASGNI4
line 240
;240:	if (newInfo.skillBonus <= 0) {
ADDRLP4 0+56
INDIRI4
CNSTI4 0
GTI4 $204
line 241
;241:		newInfo.skillBonus = 1;
ADDRLP4 0+56
CNSTI4 1
ASGNI4
line 242
;242:	}
LABELV $204
line 243
;243:	newInfo.score = newInfo.baseScore + newInfo.shutoutBonus + newInfo.timeBonus;
ADDRLP4 0
ADDRLP4 0+60
INDIRI4
ADDRLP4 0+52
INDIRI4
ADDI4
ADDRLP4 0+48
INDIRI4
ADDI4
ASGNI4
line 244
;244:	newInfo.score *= newInfo.skillBonus;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 0+56
INDIRI4
MULI4
ASGNI4
line 247
;245:
;246:	// see if the score is higher for this one
;247:	newHigh = (newInfo.redScore > newInfo.blueScore && newInfo.score > oldInfo.score);
ADDRLP4 0+4
INDIRI4
ADDRLP4 0+8
INDIRI4
LEI4 $215
ADDRLP4 0
INDIRI4
ADDRLP4 1096
INDIRI4
LEI4 $215
ADDRLP4 1424
CNSTI4 1
ASGNI4
ADDRGP4 $216
JUMPV
LABELV $215
ADDRLP4 1424
CNSTI4 0
ASGNI4
LABELV $216
ADDRLP4 1088
ADDRLP4 1424
INDIRI4
ASGNI4
line 249
;248:
;249:	if  (newHigh) {
ADDRLP4 1088
INDIRI4
CNSTI4 0
EQI4 $217
line 251
;250:		// if so write out the new one
;251:		uiInfo.newHighScoreTime = uiInfo.uiDC.realTime + 20000;
ADDRGP4 uiInfo+5354348
ADDRGP4 uiInfo+212
INDIRI4
CNSTI4 20000
ADDI4
ASGNI4
line 252
;252:		if (trap_FS_FOpenFile(fileName, &f, FS_WRITE) >= 0) {
ADDRLP4 1228
ARGP4
ADDRLP4 1092
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 1428
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 1428
INDIRI4
CNSTI4 0
LTI4 $221
line 253
;253:			size = sizeof(postGameInfo_t);
ADDRLP4 1296
CNSTI4 64
ASGNI4
line 254
;254:			trap_FS_Write(&size, sizeof(int), f);
ADDRLP4 1296
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 1092
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 255
;255:			trap_FS_Write(&newInfo, sizeof(postGameInfo_t), f);
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 1092
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 256
;256:			trap_FS_FCloseFile(f);
ADDRLP4 1092
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 257
;257:		}
LABELV $221
line 258
;258:	}
LABELV $217
line 260
;259:
;260:	if (newInfo.time < oldInfo.time) {
ADDRLP4 0+44
INDIRI4
ADDRLP4 1096+44
INDIRI4
GEI4 $223
line 261
;261:		uiInfo.newBestTime = uiInfo.uiDC.realTime + 20000;
ADDRGP4 uiInfo+5354352
ADDRGP4 uiInfo+212
INDIRI4
CNSTI4 20000
ADDI4
ASGNI4
line 262
;262:	}
LABELV $223
line 265
;263: 
;264:	// put back all the ui overrides
;265:	trap_Cvar_Set("capturelimit", UI_Cvar_VariableString("ui_saveCaptureLimit"));
ADDRGP4 $230
ARGP4
ADDRLP4 1428
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $229
ARGP4
ADDRLP4 1428
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 266
;266:	trap_Cvar_Set("fraglimit", UI_Cvar_VariableString("ui_saveFragLimit"));
ADDRGP4 $232
ARGP4
ADDRLP4 1432
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $231
ARGP4
ADDRLP4 1432
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 267
;267:	trap_Cvar_Set("cg_drawTimer", UI_Cvar_VariableString("ui_drawTimer"));
ADDRGP4 $234
ARGP4
ADDRLP4 1436
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $233
ARGP4
ADDRLP4 1436
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 268
;268:	trap_Cvar_Set("g_doWarmup", UI_Cvar_VariableString("ui_doWarmup"));
ADDRGP4 $236
ARGP4
ADDRLP4 1440
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $235
ARGP4
ADDRLP4 1440
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 269
;269:	trap_Cvar_Set("g_Warmup", UI_Cvar_VariableString("ui_Warmup"));
ADDRGP4 $238
ARGP4
ADDRLP4 1444
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $237
ARGP4
ADDRLP4 1444
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 270
;270:	trap_Cvar_Set("sv_pure", UI_Cvar_VariableString("ui_pure"));
ADDRGP4 $240
ARGP4
ADDRLP4 1448
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $239
ARGP4
ADDRLP4 1448
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 271
;271:	trap_Cvar_Set("g_friendlyFire", UI_Cvar_VariableString("ui_friendlyFire"));
ADDRGP4 $242
ARGP4
ADDRLP4 1452
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $241
ARGP4
ADDRLP4 1452
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 273
;272:
;273:	UI_SetBestScores(&newInfo, qtrue);
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 UI_SetBestScores
CALLV
pop
line 274
;274:	UI_ShowPostGame(newHigh);
ADDRLP4 1088
INDIRI4
ARGI4
ADDRGP4 UI_ShowPostGame
CALLV
pop
line 277
;275:
;276:
;277:}
LABELV $166
endproc UI_CalcPostGameStats 1456 20
export UI_ConsoleCommand
proc UI_ConsoleCommand 168 12
line 285
;278:
;279:
;280:/*
;281:=================
;282:UI_ConsoleCommand
;283:=================
;284:*/
;285:qboolean UI_ConsoleCommand( int realTime ) {
line 288
;286:	char	*cmd;
;287:
;288:	uiInfo.uiDC.frameTime = realTime - uiInfo.uiDC.realTime;
ADDRGP4 uiInfo+220
ADDRFP4 0
INDIRI4
ADDRGP4 uiInfo+212
INDIRI4
SUBI4
ASGNI4
line 289
;289:	uiInfo.uiDC.realTime = realTime;
ADDRGP4 uiInfo+212
ADDRFP4 0
INDIRI4
ASGNI4
line 291
;290:
;291:	cmd = UI_Argv( 0 );
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 296
;292:
;293:	// ensure minimum menu data is available
;294:	//Menu_Cache();
;295:
;296:	if ( Q_stricmp (cmd, "ui_test") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $249
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $247
line 297
;297:		UI_ShowPostGame(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_ShowPostGame
CALLV
pop
line 298
;298:	}
LABELV $247
line 300
;299:
;300:	if ( Q_stricmp (cmd, "ui_report") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $252
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $250
line 301
;301:		UI_Report();
ADDRGP4 UI_Report
CALLV
pop
line 302
;302:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $243
JUMPV
LABELV $250
line 305
;303:	}
;304:	
;305:	if ( Q_stricmp (cmd, "ui_load") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $255
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $253
line 306
;306:		UI_Load();
ADDRGP4 UI_Load
CALLV
pop
line 307
;307:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $243
JUMPV
LABELV $253
line 310
;308:	}
;309:
;310:	if ( Q_stricmp (cmd, "remapShader") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $258
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $256
line 311
;311:		if (trap_Argc() == 4) {
ADDRLP4 24
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 4
NEI4 $259
line 314
;312:			char shader1[MAX_QPATH];
;313:			char shader2[MAX_QPATH];
;314:			Q_strncpyz(shader1, UI_Argv(1), sizeof(shader1));
CNSTI4 1
ARGI4
ADDRLP4 156
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 28
ARGP4
ADDRLP4 156
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 315
;315:			Q_strncpyz(shader2, UI_Argv(2), sizeof(shader2));
CNSTI4 2
ARGI4
ADDRLP4 160
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 92
ARGP4
ADDRLP4 160
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 316
;316:			trap_R_RemapShader(shader1, shader2, UI_Argv(3));
CNSTI4 3
ARGI4
ADDRLP4 164
ADDRGP4 UI_Argv
CALLP4
ASGNP4
ADDRLP4 28
ARGP4
ADDRLP4 92
ARGP4
ADDRLP4 164
INDIRP4
ARGP4
ADDRGP4 trap_R_RemapShader
CALLV
pop
line 317
;317:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $243
JUMPV
LABELV $259
line 319
;318:		}
;319:	}
LABELV $256
line 321
;320:
;321:	if ( Q_stricmp (cmd, "postgame") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $263
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $261
line 322
;322:		UI_CalcPostGameStats();
ADDRGP4 UI_CalcPostGameStats
CALLV
pop
line 323
;323:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $243
JUMPV
LABELV $261
line 326
;324:	}
;325:
;326:	if ( Q_stricmp (cmd, "ui_cache") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $266
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $264
line 327
;327:		UI_Cache_f();
ADDRGP4 UI_Cache_f
CALLV
pop
line 328
;328:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $243
JUMPV
LABELV $264
line 331
;329:	}
;330:
;331:	if ( Q_stricmp (cmd, "ui_teamOrders") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $269
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $267
line 333
;332:		//UI_TeamOrdersMenu_f();
;333:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $243
JUMPV
LABELV $267
line 337
;334:	}
;335:
;336:
;337:	if ( Q_stricmp (cmd, "ui_cdkey") == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $272
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $270
line 339
;338:		//UI_CDKeyMenu_f();
;339:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $243
JUMPV
LABELV $270
line 342
;340:	}
;341:
;342:	return qfalse;
CNSTI4 0
RETI4
LABELV $243
endproc UI_ConsoleCommand 168 12
export UI_Shutdown
proc UI_Shutdown 0 0
line 350
;343:}
;344:
;345:/*
;346:=================
;347:UI_Shutdown
;348:=================
;349:*/
;350:void UI_Shutdown( void ) {
line 351
;351:}
LABELV $273
endproc UI_Shutdown 0 0
export UI_AdjustFrom640
proc UI_AdjustFrom640 16 0
line 360
;352:
;353:/*
;354:================
;355:UI_AdjustFrom640
;356:
;357:Adjusted for resolution and screen aspect ratio
;358:================
;359:*/
;360:void UI_AdjustFrom640( float *x, float *y, float *w, float *h ) {
line 369
;361:	// expect valid pointers
;362:#if 0
;363:	*x = *x * uiInfo.uiDC.scale + uiInfo.uiDC.bias;
;364:	*y *= uiInfo.uiDC.scale;
;365:	*w *= uiInfo.uiDC.scale;
;366:	*h *= uiInfo.uiDC.scale;
;367:#endif
;368:
;369:	*x *= uiInfo.uiDC.xscale;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRGP4 uiInfo+204
INDIRF4
MULF4
ASGNF4
line 370
;370:	*y *= uiInfo.uiDC.yscale;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 uiInfo+200
INDIRF4
MULF4
ASGNF4
line 371
;371:	*w *= uiInfo.uiDC.xscale;
ADDRLP4 8
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRGP4 uiInfo+204
INDIRF4
MULF4
ASGNF4
line 372
;372:	*h *= uiInfo.uiDC.yscale;
ADDRLP4 12
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRGP4 uiInfo+200
INDIRF4
MULF4
ASGNF4
line 374
;373:
;374:}
LABELV $274
endproc UI_AdjustFrom640 16 0
export UI_DrawNamedPic
proc UI_DrawNamedPic 8 36
line 376
;375:
;376:void UI_DrawNamedPic( float x, float y, float width, float height, const char *picname ) {
line 379
;377:	qhandle_t	hShader;
;378:
;379:	hShader = trap_R_RegisterShaderNoMip( picname );
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 380
;380:	UI_AdjustFrom640( &x, &y, &width, &height );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 UI_AdjustFrom640
CALLV
pop
line 381
;381:	trap_R_DrawStretchPic( x, y, width, height, 0, 0, 1, 1, hShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 382
;382:}
LABELV $279
endproc UI_DrawNamedPic 8 36
export UI_DrawHandlePic
proc UI_DrawHandlePic 16 36
line 384
;383:
;384:void UI_DrawHandlePic( float x, float y, float w, float h, qhandle_t hShader, int widescreen ) {
line 390
;385:	float	s0;
;386:	float	s1;
;387:	float	t0;
;388:	float	t1;
;389:
;390:	if( w < 0 ) {	// flip about vertical
ADDRFP4 8
INDIRF4
CNSTF4 0
GEF4 $281
line 391
;391:		w  = -w;
ADDRFP4 8
ADDRFP4 8
INDIRF4
NEGF4
ASGNF4
line 392
;392:		s0 = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 393
;393:		s1 = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 394
;394:	}
ADDRGP4 $282
JUMPV
LABELV $281
line 395
;395:	else {
line 396
;396:		s0 = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 397
;397:		s1 = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
line 398
;398:	}
LABELV $282
line 400
;399:
;400:	if( h < 0 ) {	// flip about horizontal
ADDRFP4 12
INDIRF4
CNSTF4 0
GEF4 $283
line 401
;401:		h  = -h;
ADDRFP4 12
ADDRFP4 12
INDIRF4
NEGF4
ASGNF4
line 402
;402:		t0 = 1;
ADDRLP4 8
CNSTF4 1065353216
ASGNF4
line 403
;403:		t1 = 0;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 404
;404:	}
ADDRGP4 $284
JUMPV
LABELV $283
line 405
;405:	else {
line 406
;406:		t0 = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 407
;407:		t1 = 1;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 408
;408:	}
LABELV $284
line 410
;409:	
;410:	UI_AdjustFrom640( &x, &y, &w, &h );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 UI_AdjustFrom640
CALLV
pop
line 411
;411:	trap_R_DrawStretchPic( x, y, w, h, s0, t0, s1, t1, hShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 412
;412:}
LABELV $280
endproc UI_DrawHandlePic 16 36
export UI_DrawStretchPic
proc UI_DrawStretchPic 0 36
line 414
;413:
;414:void UI_DrawStretchPic(float x, float y, float w, float h, float s1, float t1, float s2, float t2, qhandle_t hShader, int widescreen) { //, rectDef_t menuRect) {
line 415
;415:	trap_R_DrawStretchPic( x, y, w, h, s1, t1, s2, t2, hShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 20
INDIRF4
ARGF4
ADDRFP4 24
INDIRF4
ARGF4
ADDRFP4 28
INDIRF4
ARGF4
ADDRFP4 32
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 416
;416:}
LABELV $285
endproc UI_DrawStretchPic 0 36
export UI_FillRect
proc UI_FillRect 0 36
line 425
;417:
;418:/*
;419:================
;420:UI_FillRect
;421:
;422:Coordinates are SCREEN_WIDTH*SCREEN_HEIGHT virtual values
;423:=================
;424:*/
;425:void UI_FillRect(float x, float y, float w, float h, const vec4_t color, int widescreen) { //, rectDef_t menuRect) {
line 426
;426:	trap_R_SetColor( color );
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 428
;427:
;428:	UI_AdjustFrom640( &x, &y, &w, &h );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 UI_AdjustFrom640
CALLV
pop
line 429
;429:	trap_R_DrawStretchPic( x, y, w, h, 0, 0, 0, 0, uiInfo.uiDC.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 uiInfo+5354328
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 431
;430:
;431:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 432
;432:}
LABELV $286
endproc UI_FillRect 0 36
export UI_DrawSides
proc UI_DrawSides 0 36
line 434
;433:
;434:void UI_DrawSides(float x, float y, float w, float h) {
line 435
;435:	UI_AdjustFrom640( &x, &y, &w, &h );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 UI_AdjustFrom640
CALLV
pop
line 436
;436:	trap_R_DrawStretchPic( x, y, 1, h, 0, 0, 0, 0, uiInfo.uiDC.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 uiInfo+5354328
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 437
;437:	trap_R_DrawStretchPic( x + w - 1, y, 1, h, 0, 0, 0, 0, uiInfo.uiDC.whiteShader );
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
CNSTF4 1065353216
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 uiInfo+5354328
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 438
;438:}
LABELV $288
endproc UI_DrawSides 0 36
export UI_DrawTopBottom
proc UI_DrawTopBottom 0 36
line 440
;439:
;440:void UI_DrawTopBottom(float x, float y, float w, float h) {
line 441
;441:	UI_AdjustFrom640( &x, &y, &w, &h );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 UI_AdjustFrom640
CALLV
pop
line 442
;442:	trap_R_DrawStretchPic( x, y, w, 1, 0, 0, 0, 0, uiInfo.uiDC.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 uiInfo+5354328
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 443
;443:	trap_R_DrawStretchPic( x, y + h - 1, w, 1, 0, 0, 0, 0, uiInfo.uiDC.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ADDRFP4 12
INDIRF4
ADDF4
CNSTF4 1065353216
SUBF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 uiInfo+5354328
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 444
;444:}
LABELV $291
endproc UI_DrawTopBottom 0 36
export UI_DrawRect
proc UI_DrawRect 0 16
line 452
;445:/*
;446:================
;447:UI_DrawRect
;448:
;449:Coordinates are SCREEN_WIDTH*SCREEN_HEIGHT virtual values
;450:=================
;451:*/
;452:void UI_DrawRect( float x, float y, float width, float height, const float *color ) {
line 453
;453:	trap_R_SetColor( color );
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 455
;454:
;455:	UI_DrawTopBottom(x, y, width, height);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 UI_DrawTopBottom
CALLV
pop
line 456
;456:	UI_DrawSides(x, y, width, height);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 UI_DrawSides
CALLV
pop
line 458
;457:
;458:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 459
;459:}
LABELV $294
endproc UI_DrawRect 0 16
export UI_SetColor
proc UI_SetColor 0 4
line 461
;460:
;461:void UI_SetColor( const float *rgba ) {
line 462
;462:	trap_R_SetColor( rgba );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 463
;463:}
LABELV $295
endproc UI_SetColor 0 4
export UI_UpdateScreen
proc UI_UpdateScreen 0 0
line 465
;464:
;465:void UI_UpdateScreen( void ) {
line 466
;466:	trap_UpdateScreen();
ADDRGP4 trap_UpdateScreen
CALLV
pop
line 467
;467:}
LABELV $296
endproc UI_UpdateScreen 0 0
export UI_CursorInRect
proc UI_CursorInRect 8 0
line 470
;468:
;469:qboolean UI_CursorInRect (int x, int y, int width, int height)
;470:{
line 471
;471:	if (uiInfo.uiDC.cursorx < x ||
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRGP4 uiInfo+224
INDIRI4
ADDRLP4 0
INDIRI4
LTI4 $306
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRGP4 uiInfo+228
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $306
ADDRGP4 uiInfo+224
INDIRI4
ADDRLP4 0
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
GTI4 $306
ADDRGP4 uiInfo+228
INDIRI4
ADDRLP4 4
INDIRI4
ADDRFP4 12
INDIRI4
ADDI4
LEI4 $298
LABELV $306
line 475
;472:		uiInfo.uiDC.cursory < y ||
;473:		uiInfo.uiDC.cursorx > x+width ||
;474:		uiInfo.uiDC.cursory > y+height)
;475:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $297
JUMPV
LABELV $298
line 477
;476:
;477:	return qtrue;
CNSTI4 1
RETI4
LABELV $297
endproc UI_CursorInRect 8 0
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
import UI_GetBotNameByNumber
import UI_LoadBots
import UI_GetNumBots
import UI_GetBotInfoByName
import UI_GetBotInfoByNumber
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
bss
export m_entersound
align 4
LABELV m_entersound
skip 4
import UI_ForceMenuOff
import UI_PopMenu
import UI_PushMenu
import UI_SetActiveMenu
import UI_IsFullscreen
import UI_DrawChar
import UI_DrawString
import UI_ProportionalStringWidth
import UI_DrawProportionalString
import UI_ProportionalSizeScale
import UI_DrawBannerString
import UI_LerpColor
import UI_Refresh
import UI_MouseEvent
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
import UI_LoadArenas
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
LABELV $272
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 100
byte 1 107
byte 1 101
byte 1 121
byte 1 0
align 1
LABELV $269
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $266
byte 1 117
byte 1 105
byte 1 95
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 0
align 1
LABELV $263
byte 1 112
byte 1 111
byte 1 115
byte 1 116
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $258
byte 1 114
byte 1 101
byte 1 109
byte 1 97
byte 1 112
byte 1 83
byte 1 104
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $255
byte 1 117
byte 1 105
byte 1 95
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $252
byte 1 117
byte 1 105
byte 1 95
byte 1 114
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $249
byte 1 117
byte 1 105
byte 1 95
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $242
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $241
byte 1 103
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $240
byte 1 117
byte 1 105
byte 1 95
byte 1 112
byte 1 117
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $239
byte 1 115
byte 1 118
byte 1 95
byte 1 112
byte 1 117
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $238
byte 1 117
byte 1 105
byte 1 95
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $237
byte 1 103
byte 1 95
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $236
byte 1 117
byte 1 105
byte 1 95
byte 1 100
byte 1 111
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $235
byte 1 103
byte 1 95
byte 1 100
byte 1 111
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $234
byte 1 117
byte 1 105
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $233
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $232
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 70
byte 1 114
byte 1 97
byte 1 103
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $231
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
LABELV $230
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 97
byte 1 118
byte 1 101
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 76
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $229
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
LABELV $203
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
LABELV $185
byte 1 117
byte 1 105
byte 1 95
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $168
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
LABELV $167
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $164
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $155
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $154
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $148
byte 1 112
byte 1 114
byte 1 111
byte 1 116
byte 1 111
byte 1 99
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $147
byte 1 100
byte 1 101
byte 1 109
byte 1 111
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 100
byte 1 46
byte 1 100
byte 1 109
byte 1 95
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $142
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 105
byte 1 46
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $140
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 115
byte 1 50
byte 1 0
align 1
LABELV $139
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 50
byte 1 0
align 1
LABELV $138
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 83
byte 1 104
byte 1 117
byte 1 116
byte 1 111
byte 1 117
byte 1 116
byte 1 66
byte 1 111
byte 1 110
byte 1 117
byte 1 115
byte 1 50
byte 1 0
align 1
LABELV $137
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 83
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 66
byte 1 111
byte 1 110
byte 1 117
byte 1 115
byte 1 50
byte 1 0
align 1
LABELV $136
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 66
byte 1 111
byte 1 110
byte 1 117
byte 1 115
byte 1 50
byte 1 0
align 1
LABELV $135
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 66
byte 1 97
byte 1 115
byte 1 101
byte 1 50
byte 1 0
align 1
LABELV $134
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 50
byte 1 0
align 1
LABELV $133
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 80
byte 1 101
byte 1 114
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 50
byte 1 0
align 1
LABELV $132
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 50
byte 1 0
align 1
LABELV $131
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 71
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 115
byte 1 50
byte 1 0
align 1
LABELV $130
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 65
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 115
byte 1 50
byte 1 0
align 1
LABELV $129
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 68
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 115
byte 1 50
byte 1 0
align 1
LABELV $128
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 69
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 50
byte 1 0
align 1
LABELV $127
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 73
byte 1 109
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 115
byte 1 50
byte 1 0
align 1
LABELV $126
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 65
byte 1 99
byte 1 99
byte 1 117
byte 1 114
byte 1 97
byte 1 99
byte 1 121
byte 1 50
byte 1 0
align 1
LABELV $123
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $122
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 58
byte 1 37
byte 1 48
byte 1 50
byte 1 105
byte 1 0
align 1
LABELV $121
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $120
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 83
byte 1 104
byte 1 117
byte 1 116
byte 1 111
byte 1 117
byte 1 116
byte 1 66
byte 1 111
byte 1 110
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $119
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 83
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 66
byte 1 111
byte 1 110
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $118
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 66
byte 1 111
byte 1 110
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $117
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 66
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $116
byte 1 37
byte 1 105
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $115
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $114
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 80
byte 1 101
byte 1 114
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $113
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 83
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $112
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 71
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $111
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 65
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $110
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 68
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $109
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 69
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $108
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $107
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 73
byte 1 109
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $106
byte 1 37
byte 1 105
byte 1 37
byte 1 37
byte 1 0
align 1
LABELV $105
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 65
byte 1 99
byte 1 99
byte 1 117
byte 1 114
byte 1 97
byte 1 99
byte 1 121
byte 1 0
align 1
LABELV $99
byte 1 100
byte 1 49
byte 1 10
byte 1 0
align 1
LABELV $90
byte 1 37
byte 1 115
byte 1 0

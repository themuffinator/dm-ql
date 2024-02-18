data
align 4
LABELV syscall
byte 4 4294967295
export dllEntry
code
proc dllEntry 0 0
file "..\..\..\..\code\ui\ui_syscalls.c"
line 13
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:#include "ui_local.h"
;4:
;5:// this file is only included when building a dll
;6:// syscalls.asm is included instead when building a qvm
;7:#ifdef Q3_VM
;8:#error "Do not use in VM build"
;9:#endif
;10:
;11:static int (QDECL *syscall)( int arg, ... ) = (int (QDECL *)( int, ...))-1;
;12:
;13:void dllEntry( int (QDECL *syscallptr)( int arg,... ) ) {
line 14
;14:	syscall = syscallptr;
ADDRGP4 syscall
ADDRFP4 0
INDIRP4
ASGNP4
line 15
;15:}
LABELV $88
endproc dllEntry 0 0
export PASSFLOAT
proc PASSFLOAT 4 0
line 17
;16:
;17:int PASSFLOAT( float x ) {
line 19
;18:	float	floatTemp;
;19:	floatTemp = x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
line 20
;20:	return *(int *)&floatTemp;
ADDRLP4 0
INDIRI4
RETI4
LABELV $89
endproc PASSFLOAT 4 0
export trap_Print
proc trap_Print 0 8
line 23
;21:}
;22:
;23:void trap_Print( const char *string ) {
line 24
;24:	syscall( UI_PRINT, string );
CNSTI4 1
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 25
;25:}
LABELV $90
endproc trap_Print 0 8
export trap_Error
proc trap_Error 0 8
line 27
;26:
;27:void trap_Error( const char *string ) {
line 28
;28:	syscall( UI_ERROR, string );
CNSTI4 0
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 29
;29:}
LABELV $91
endproc trap_Error 0 8
export trap_Milliseconds
proc trap_Milliseconds 4 4
line 31
;30:
;31:int trap_Milliseconds( void ) {
line 32
;32:	return syscall( UI_MILLISECONDS ); 
CNSTI4 2
ARGI4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $92
endproc trap_Milliseconds 4 4
export trap_Cvar_Register
proc trap_Cvar_Register 0 20
line 35
;33:}
;34:
;35:void trap_Cvar_Register( vmCvar_t *cvar, const char *var_name, const char *value, int flags ) {
line 36
;36:	syscall( UI_CVAR_REGISTER, cvar, var_name, value, flags );
CNSTI4 50
ARGI4
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
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 37
;37:}
LABELV $93
endproc trap_Cvar_Register 0 20
export trap_Cvar_Update
proc trap_Cvar_Update 0 8
line 39
;38:
;39:void trap_Cvar_Update( vmCvar_t *cvar ) {
line 40
;40:	syscall( UI_CVAR_UPDATE, cvar );
CNSTI4 51
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 41
;41:}
LABELV $94
endproc trap_Cvar_Update 0 8
export trap_Cvar_Set
proc trap_Cvar_Set 0 12
line 43
;42:
;43:void trap_Cvar_Set( const char *var_name, const char *value ) {
line 44
;44:	syscall( UI_CVAR_SET, var_name, value );
CNSTI4 3
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 45
;45:}
LABELV $95
endproc trap_Cvar_Set 0 12
export trap_Cvar_VariableValue
proc trap_Cvar_VariableValue 8 8
line 47
;46:
;47:float trap_Cvar_VariableValue( const char *var_name ) {
line 49
;48:	int temp;
;49:	temp = syscall( UI_CVAR_VARIABLEVALUE, var_name );
CNSTI4 4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 50
;50:	return (*(float*)&temp);
ADDRLP4 0
INDIRF4
RETF4
LABELV $96
endproc trap_Cvar_VariableValue 8 8
export trap_Cvar_VariableStringBuffer
proc trap_Cvar_VariableStringBuffer 0 16
line 53
;51:}
;52:
;53:void trap_Cvar_VariableStringBuffer( const char *var_name, char *buffer, int bufsize ) {
line 54
;54:	syscall( UI_CVAR_VARIABLESTRINGBUFFER, var_name, buffer, bufsize );
CNSTI4 5
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 55
;55:}
LABELV $97
endproc trap_Cvar_VariableStringBuffer 0 16
export trap_Cvar_SetValue
proc trap_Cvar_SetValue 4 12
line 57
;56:
;57:void trap_Cvar_SetValue( const char *var_name, float value ) {
line 58
;58:	syscall( UI_CVAR_SETVALUE, var_name, PASSFLOAT( value ) );
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 0
ADDRGP4 PASSFLOAT
CALLI4
ASGNI4
CNSTI4 6
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 59
;59:}
LABELV $98
endproc trap_Cvar_SetValue 4 12
export trap_Cvar_Reset
proc trap_Cvar_Reset 0 8
line 61
;60:
;61:void trap_Cvar_Reset( const char *name ) {
line 62
;62:	syscall( UI_CVAR_RESET, name ); 
CNSTI4 7
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 63
;63:}
LABELV $99
endproc trap_Cvar_Reset 0 8
export trap_Cvar_Create
proc trap_Cvar_Create 0 16
line 65
;64:
;65:void trap_Cvar_Create( const char *var_name, const char *var_value, int flags ) {
line 66
;66:	syscall( UI_CVAR_CREATE, var_name, var_value, flags );
CNSTI4 8
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 67
;67:}
LABELV $100
endproc trap_Cvar_Create 0 16
export trap_Cvar_InfoStringBuffer
proc trap_Cvar_InfoStringBuffer 0 16
line 69
;68:
;69:void trap_Cvar_InfoStringBuffer( int bit, char *buffer, int bufsize ) {
line 70
;70:	syscall( UI_CVAR_INFOSTRINGBUFFER, bit, buffer, bufsize );
CNSTI4 9
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 71
;71:}
LABELV $101
endproc trap_Cvar_InfoStringBuffer 0 16
export trap_Argc
proc trap_Argc 4 4
line 73
;72:
;73:int trap_Argc( void ) {
line 74
;74:	return syscall( UI_ARGC );
CNSTI4 10
ARGI4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $102
endproc trap_Argc 4 4
export trap_Argv
proc trap_Argv 0 16
line 77
;75:}
;76:
;77:void trap_Argv( int n, char *buffer, int bufferLength ) {
line 78
;78:	syscall( UI_ARGV, n, buffer, bufferLength );
CNSTI4 11
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 79
;79:}
LABELV $103
endproc trap_Argv 0 16
export trap_Cmd_ExecuteText
proc trap_Cmd_ExecuteText 0 12
line 81
;80:
;81:void trap_Cmd_ExecuteText( int exec_when, const char *text ) {
line 82
;82:	syscall( UI_CMD_EXECUTETEXT, exec_when, text );
CNSTI4 12
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 83
;83:}
LABELV $104
endproc trap_Cmd_ExecuteText 0 12
export trap_FS_FOpenFile
proc trap_FS_FOpenFile 4 16
line 85
;84:
;85:int trap_FS_FOpenFile( const char *qpath, fileHandle_t *f, fsMode_t mode ) {
line 86
;86:	return syscall( UI_FS_FOPENFILE, qpath, f, mode );
CNSTI4 13
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $105
endproc trap_FS_FOpenFile 4 16
export trap_FS_Read
proc trap_FS_Read 0 16
line 89
;87:}
;88:
;89:void trap_FS_Read( void *buffer, int len, fileHandle_t f ) {
line 90
;90:	syscall( UI_FS_READ, buffer, len, f );
CNSTI4 14
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 91
;91:}
LABELV $106
endproc trap_FS_Read 0 16
export trap_FS_Write
proc trap_FS_Write 0 16
line 93
;92:
;93:void trap_FS_Write( const void *buffer, int len, fileHandle_t f ) {
line 94
;94:	syscall( UI_FS_WRITE, buffer, len, f );
CNSTI4 15
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 95
;95:}
LABELV $107
endproc trap_FS_Write 0 16
export trap_FS_FCloseFile
proc trap_FS_FCloseFile 0 8
line 97
;96:
;97:void trap_FS_FCloseFile( fileHandle_t f ) {
line 98
;98:	syscall( UI_FS_FCLOSEFILE, f );
CNSTI4 16
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 99
;99:}
LABELV $108
endproc trap_FS_FCloseFile 0 8
export trap_FS_GetFileList
proc trap_FS_GetFileList 4 20
line 101
;100:
;101:int trap_FS_GetFileList(  const char *path, const char *extension, char *listbuf, int bufsize ) {
line 102
;102:	return syscall( UI_FS_GETFILELIST, path, extension, listbuf, bufsize );
CNSTI4 17
ARGI4
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
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $109
endproc trap_FS_GetFileList 4 20
export trap_FS_Seek
proc trap_FS_Seek 4 16
line 105
;103:}
;104:
;105:int trap_FS_Seek( fileHandle_t f, long offset, int origin ) {
line 106
;106:	return syscall( UI_FS_SEEK, f, offset, origin );
CNSTI4 86
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $110
endproc trap_FS_Seek 4 16
export trap_R_RegisterModel
proc trap_R_RegisterModel 4 8
line 109
;107:}
;108:
;109:qhandle_t trap_R_RegisterModel( const char *name ) {
line 110
;110:	return syscall( UI_R_REGISTERMODEL, name );
CNSTI4 18
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $111
endproc trap_R_RegisterModel 4 8
export trap_R_RegisterSkin
proc trap_R_RegisterSkin 4 8
line 113
;111:}
;112:
;113:qhandle_t trap_R_RegisterSkin( const char *name ) {
line 114
;114:	return syscall( UI_R_REGISTERSKIN, name );
CNSTI4 19
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $112
endproc trap_R_RegisterSkin 4 8
export trap_R_RegisterFont
proc trap_R_RegisterFont 0 16
line 117
;115:}
;116:
;117:void trap_R_RegisterFont(const char *fontName, int pointSize, fontInfo_t *font) {
line 118
;118:	syscall( UI_R_REGISTERFONT, fontName, pointSize, font );
CNSTI4 55
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 119
;119:}
LABELV $113
endproc trap_R_RegisterFont 0 16
export trap_R_RegisterShaderNoMip
proc trap_R_RegisterShaderNoMip 4 8
line 121
;120:
;121:qhandle_t trap_R_RegisterShaderNoMip( const char *name ) {
line 122
;122:	return syscall( UI_R_REGISTERSHADERNOMIP, name );
CNSTI4 20
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $114
endproc trap_R_RegisterShaderNoMip 4 8
export trap_R_ClearScene
proc trap_R_ClearScene 0 4
line 125
;123:}
;124:
;125:void trap_R_ClearScene( void ) {
line 126
;126:	syscall( UI_R_CLEARSCENE );
CNSTI4 21
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 127
;127:}
LABELV $115
endproc trap_R_ClearScene 0 4
export trap_R_AddRefEntityToScene
proc trap_R_AddRefEntityToScene 0 8
line 129
;128:
;129:void trap_R_AddRefEntityToScene( const refEntity_t *re ) {
line 130
;130:	syscall( UI_R_ADDREFENTITYTOSCENE, re );
CNSTI4 22
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 131
;131:}
LABELV $116
endproc trap_R_AddRefEntityToScene 0 8
export trap_R_AddPolyToScene
proc trap_R_AddPolyToScene 0 16
line 133
;132:
;133:void trap_R_AddPolyToScene( qhandle_t hShader , int numVerts, const polyVert_t *verts ) {
line 134
;134:	syscall( UI_R_ADDPOLYTOSCENE, hShader, numVerts, verts );
CNSTI4 23
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 135
;135:}
LABELV $117
endproc trap_R_AddPolyToScene 0 16
export trap_R_AddLightToScene
proc trap_R_AddLightToScene 16 24
line 137
;136:
;137:void trap_R_AddLightToScene( const vec3_t org, float intensity, float r, float g, float b ) {
line 138
;138:	syscall( UI_R_ADDLIGHTTOSCENE, org, PASSFLOAT(intensity), PASSFLOAT(r), PASSFLOAT(g), PASSFLOAT(b) );
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 0
ADDRGP4 PASSFLOAT
CALLI4
ASGNI4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 PASSFLOAT
CALLI4
ASGNI4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 PASSFLOAT
CALLI4
ASGNI4
ADDRFP4 16
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 PASSFLOAT
CALLI4
ASGNI4
CNSTI4 24
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 139
;139:}
LABELV $118
endproc trap_R_AddLightToScene 16 24
export trap_R_RenderScene
proc trap_R_RenderScene 0 8
line 141
;140:
;141:void trap_R_RenderScene( const refdef_t *fd ) {
line 142
;142:	syscall( UI_R_RENDERSCENE, fd );
CNSTI4 25
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 143
;143:}
LABELV $119
endproc trap_R_RenderScene 0 8
export trap_R_SetColor
proc trap_R_SetColor 0 8
line 145
;144:
;145:void trap_R_SetColor( const float *rgba ) {
line 146
;146:	syscall( UI_R_SETCOLOR, rgba );
CNSTI4 26
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 147
;147:}
LABELV $120
endproc trap_R_SetColor 0 8
export trap_R_DrawStretchPic
proc trap_R_DrawStretchPic 32 40
line 149
;148:
;149:void trap_R_DrawStretchPic( float x, float y, float w, float h, float s1, float t1, float s2, float t2, qhandle_t hShader ) {
line 150
;150:	syscall( UI_R_DRAWSTRETCHPIC, PASSFLOAT(x), PASSFLOAT(y), PASSFLOAT(w), PASSFLOAT(h), PASSFLOAT(s1), PASSFLOAT(t1), PASSFLOAT(s2), PASSFLOAT(t2), hShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 0
ADDRGP4 PASSFLOAT
CALLI4
ASGNI4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 PASSFLOAT
CALLI4
ASGNI4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 PASSFLOAT
CALLI4
ASGNI4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 PASSFLOAT
CALLI4
ASGNI4
ADDRFP4 16
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 PASSFLOAT
CALLI4
ASGNI4
ADDRFP4 20
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 PASSFLOAT
CALLI4
ASGNI4
ADDRFP4 24
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 PASSFLOAT
CALLI4
ASGNI4
ADDRFP4 28
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 PASSFLOAT
CALLI4
ASGNI4
CNSTI4 27
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRFP4 32
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 151
;151:}
LABELV $121
endproc trap_R_DrawStretchPic 32 40
export trap_R_ModelBounds
proc trap_R_ModelBounds 0 16
line 153
;152:
;153:void	trap_R_ModelBounds( clipHandle_t model, vec3_t mins, vec3_t maxs ) {
line 154
;154:	syscall( UI_R_MODELBOUNDS, model, mins, maxs );
CNSTI4 56
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 155
;155:}
LABELV $122
endproc trap_R_ModelBounds 0 16
export trap_UpdateScreen
proc trap_UpdateScreen 0 4
line 157
;156:
;157:void trap_UpdateScreen( void ) {
line 158
;158:	syscall( UI_UPDATESCREEN );
CNSTI4 28
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 159
;159:}
LABELV $123
endproc trap_UpdateScreen 0 4
export trap_CM_LerpTag
proc trap_CM_LerpTag 8 28
line 161
;160:
;161:int trap_CM_LerpTag( orientation_t *tag, clipHandle_t mod, int startFrame, int endFrame, float frac, const char *tagName ) {
line 162
;162:	return syscall( UI_CM_LERPTAG, tag, mod, startFrame, endFrame, PASSFLOAT(frac), tagName );
ADDRFP4 16
INDIRF4
ARGF4
ADDRLP4 0
ADDRGP4 PASSFLOAT
CALLI4
ASGNI4
CNSTI4 29
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
LABELV $124
endproc trap_CM_LerpTag 8 28
export trap_S_StartLocalSound
proc trap_S_StartLocalSound 0 12
line 165
;163:}
;164:
;165:void trap_S_StartLocalSound( sfxHandle_t sfx, int channelNum ) {
line 166
;166:	syscall( UI_S_STARTLOCALSOUND, sfx, channelNum );
CNSTI4 32
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 167
;167:}
LABELV $125
endproc trap_S_StartLocalSound 0 12
export trap_S_RegisterSound
proc trap_S_RegisterSound 4 12
line 169
;168:
;169:sfxHandle_t	trap_S_RegisterSound( const char *sample, qboolean compressed ) {
line 170
;170:	return syscall( UI_S_REGISTERSOUND, sample, compressed );
CNSTI4 31
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $126
endproc trap_S_RegisterSound 4 12
export trap_Key_KeynumToStringBuf
proc trap_Key_KeynumToStringBuf 0 16
line 173
;171:}
;172:
;173:void trap_Key_KeynumToStringBuf( int keynum, char *buf, int buflen ) {
line 174
;174:	syscall( UI_KEY_KEYNUMTOSTRINGBUF, keynum, buf, buflen );
CNSTI4 33
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 175
;175:}
LABELV $127
endproc trap_Key_KeynumToStringBuf 0 16
export trap_Key_GetBindingBuf
proc trap_Key_GetBindingBuf 0 16
line 177
;176:
;177:void trap_Key_GetBindingBuf( int keynum, char *buf, int buflen ) {
line 178
;178:	syscall( UI_KEY_GETBINDINGBUF, keynum, buf, buflen );
CNSTI4 34
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 179
;179:}
LABELV $128
endproc trap_Key_GetBindingBuf 0 16
export trap_Key_SetBinding
proc trap_Key_SetBinding 0 12
line 181
;180:
;181:void trap_Key_SetBinding( int keynum, const char *binding ) {
line 182
;182:	syscall( UI_KEY_SETBINDING, keynum, binding );
CNSTI4 35
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 183
;183:}
LABELV $129
endproc trap_Key_SetBinding 0 12
export trap_Key_IsDown
proc trap_Key_IsDown 4 8
line 185
;184:
;185:qboolean trap_Key_IsDown( int keynum ) {
line 186
;186:	return syscall( UI_KEY_ISDOWN, keynum );
CNSTI4 36
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $130
endproc trap_Key_IsDown 4 8
export trap_Key_GetOverstrikeMode
proc trap_Key_GetOverstrikeMode 4 4
line 189
;187:}
;188:
;189:qboolean trap_Key_GetOverstrikeMode( void ) {
line 190
;190:	return syscall( UI_KEY_GETOVERSTRIKEMODE );
CNSTI4 37
ARGI4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $131
endproc trap_Key_GetOverstrikeMode 4 4
export trap_Key_SetOverstrikeMode
proc trap_Key_SetOverstrikeMode 0 8
line 193
;191:}
;192:
;193:void trap_Key_SetOverstrikeMode( qboolean state ) {
line 194
;194:	syscall( UI_KEY_SETOVERSTRIKEMODE, state );
CNSTI4 38
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 195
;195:}
LABELV $132
endproc trap_Key_SetOverstrikeMode 0 8
export trap_Key_ClearStates
proc trap_Key_ClearStates 0 4
line 197
;196:
;197:void trap_Key_ClearStates( void ) {
line 198
;198:	syscall( UI_KEY_CLEARSTATES );
CNSTI4 39
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 199
;199:}
LABELV $133
endproc trap_Key_ClearStates 0 4
export trap_Key_GetCatcher
proc trap_Key_GetCatcher 4 4
line 201
;200:
;201:int trap_Key_GetCatcher( void ) {
line 202
;202:	return syscall( UI_KEY_GETCATCHER );
CNSTI4 40
ARGI4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $134
endproc trap_Key_GetCatcher 4 4
export trap_Key_SetCatcher
proc trap_Key_SetCatcher 0 8
line 205
;203:}
;204:
;205:void trap_Key_SetCatcher( int catcher ) {
line 206
;206:	syscall( UI_KEY_SETCATCHER, catcher );
CNSTI4 41
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 207
;207:}
LABELV $135
endproc trap_Key_SetCatcher 0 8
export trap_GetClipboardData
proc trap_GetClipboardData 0 12
line 209
;208:
;209:void trap_GetClipboardData( char *buf, int bufsize ) {
line 210
;210:	syscall( UI_GETCLIPBOARDDATA, buf, bufsize );
CNSTI4 42
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 211
;211:}
LABELV $136
endproc trap_GetClipboardData 0 12
export trap_GetClientState
proc trap_GetClientState 0 8
line 213
;212:
;213:void trap_GetClientState( uiClientState_t *state ) {
line 214
;214:	syscall( UI_GETCLIENTSTATE, state );
CNSTI4 44
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 215
;215:}
LABELV $137
endproc trap_GetClientState 0 8
export trap_GetGlconfig
proc trap_GetGlconfig 0 8
line 217
;216:
;217:void trap_GetGlconfig( glconfig_t *glconfig ) {
line 218
;218:	syscall( UI_GETGLCONFIG, glconfig );
CNSTI4 43
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 219
;219:}
LABELV $138
endproc trap_GetGlconfig 0 8
export trap_GetConfigString
proc trap_GetConfigString 4 16
line 221
;220:
;221:int trap_GetConfigString( int index, char* buff, int buffsize ) {
line 222
;222:	return syscall( UI_GETCONFIGSTRING, index, buff, buffsize );
CNSTI4 45
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $139
endproc trap_GetConfigString 4 16
export trap_LAN_GetServerCount
proc trap_LAN_GetServerCount 4 8
line 225
;223:}
;224:
;225:int	trap_LAN_GetServerCount( int source ) {
line 226
;226:	return syscall( UI_LAN_GETSERVERCOUNT, source );
CNSTI4 65
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $140
endproc trap_LAN_GetServerCount 4 8
export trap_LAN_GetServerAddressString
proc trap_LAN_GetServerAddressString 0 20
line 229
;227:}
;228:
;229:void trap_LAN_GetServerAddressString( int source, int n, char *buf, int buflen ) {
line 230
;230:	syscall( UI_LAN_GETSERVERADDRESSSTRING, source, n, buf, buflen );
CNSTI4 66
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 231
;231:}
LABELV $141
endproc trap_LAN_GetServerAddressString 0 20
export trap_LAN_GetServerInfo
proc trap_LAN_GetServerInfo 0 20
line 233
;232:
;233:void trap_LAN_GetServerInfo( int source, int n, char *buf, int buflen ) {
line 234
;234:	syscall( UI_LAN_GETSERVERINFO, source, n, buf, buflen );
CNSTI4 67
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 235
;235:}
LABELV $142
endproc trap_LAN_GetServerInfo 0 20
export trap_LAN_GetServerPing
proc trap_LAN_GetServerPing 4 12
line 237
;236:
;237:int trap_LAN_GetServerPing( int source, int n ) {
line 238
;238:	return syscall( UI_LAN_GETSERVERPING, source, n );
CNSTI4 83
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $143
endproc trap_LAN_GetServerPing 4 12
export trap_LAN_GetPingQueueCount
proc trap_LAN_GetPingQueueCount 4 4
line 241
;239:}
;240:
;241:int trap_LAN_GetPingQueueCount( void ) {
line 242
;242:	return syscall( UI_LAN_GETPINGQUEUECOUNT );
CNSTI4 46
ARGI4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $144
endproc trap_LAN_GetPingQueueCount 4 4
export trap_LAN_ServerStatus
proc trap_LAN_ServerStatus 4 16
line 245
;243:}
;244:
;245:int trap_LAN_ServerStatus( const char *serverAddress, char *serverStatus, int maxLen ) {
line 246
;246:	return syscall( UI_LAN_SERVERSTATUS, serverAddress, serverStatus, maxLen );
CNSTI4 82
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $145
endproc trap_LAN_ServerStatus 4 16
export trap_LAN_SaveCachedServers
proc trap_LAN_SaveCachedServers 0 4
line 249
;247:}
;248:
;249:void trap_LAN_SaveCachedServers() {
line 250
;250:	syscall( UI_LAN_SAVECACHEDSERVERS );
CNSTI4 72
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 251
;251:}
LABELV $146
endproc trap_LAN_SaveCachedServers 0 4
export trap_LAN_LoadCachedServers
proc trap_LAN_LoadCachedServers 0 4
line 253
;252:
;253:void trap_LAN_LoadCachedServers() {
line 254
;254:	syscall( UI_LAN_LOADCACHEDSERVERS );
CNSTI4 71
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 255
;255:}
LABELV $147
endproc trap_LAN_LoadCachedServers 0 4
export trap_LAN_ResetPings
proc trap_LAN_ResetPings 0 8
line 257
;256:
;257:void trap_LAN_ResetPings(int n) {
line 258
;258:	syscall( UI_LAN_RESETPINGS, n );
CNSTI4 70
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 259
;259:}
LABELV $148
endproc trap_LAN_ResetPings 0 8
export trap_LAN_ClearPing
proc trap_LAN_ClearPing 0 8
line 261
;260:
;261:void trap_LAN_ClearPing( int n ) {
line 262
;262:	syscall( UI_LAN_CLEARPING, n );
CNSTI4 47
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 263
;263:}
LABELV $149
endproc trap_LAN_ClearPing 0 8
export trap_LAN_GetPing
proc trap_LAN_GetPing 0 20
line 265
;264:
;265:void trap_LAN_GetPing( int n, char *buf, int buflen, int *pingtime ) {
line 266
;266:	syscall( UI_LAN_GETPING, n, buf, buflen, pingtime );
CNSTI4 48
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 267
;267:}
LABELV $150
endproc trap_LAN_GetPing 0 20
export trap_LAN_GetPingInfo
proc trap_LAN_GetPingInfo 0 16
line 269
;268:
;269:void trap_LAN_GetPingInfo( int n, char *buf, int buflen ) {
line 270
;270:	syscall( UI_LAN_GETPINGINFO, n, buf, buflen );
CNSTI4 49
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 271
;271:}
LABELV $151
endproc trap_LAN_GetPingInfo 0 16
export trap_LAN_MarkServerVisible
proc trap_LAN_MarkServerVisible 0 16
line 273
;272:
;273:void trap_LAN_MarkServerVisible( int source, int n, qboolean visible ) {
line 274
;274:	syscall( UI_LAN_MARKSERVERVISIBLE, source, n, visible );
CNSTI4 68
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 275
;275:}
LABELV $152
endproc trap_LAN_MarkServerVisible 0 16
export trap_LAN_ServerIsVisible
proc trap_LAN_ServerIsVisible 4 12
line 277
;276:
;277:int trap_LAN_ServerIsVisible( int source, int n) {
line 278
;278:	return syscall( UI_LAN_SERVERISVISIBLE, source, n );
CNSTI4 84
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $153
endproc trap_LAN_ServerIsVisible 4 12
export trap_LAN_UpdateVisiblePings
proc trap_LAN_UpdateVisiblePings 4 8
line 281
;279:}
;280:
;281:qboolean trap_LAN_UpdateVisiblePings( int source ) {
line 282
;282:	return syscall( UI_LAN_UPDATEVISIBLEPINGS, source );
CNSTI4 69
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $154
endproc trap_LAN_UpdateVisiblePings 4 8
export trap_LAN_AddServer
proc trap_LAN_AddServer 4 16
line 285
;283:}
;284:
;285:int trap_LAN_AddServer(int source, const char *name, const char *addr) {
line 286
;286:	return syscall( UI_LAN_ADDSERVER, source, name, addr );
CNSTI4 73
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $155
endproc trap_LAN_AddServer 4 16
export trap_LAN_RemoveServer
proc trap_LAN_RemoveServer 0 12
line 289
;287:}
;288:
;289:void trap_LAN_RemoveServer(int source, const char *addr) {
line 290
;290:	syscall( UI_LAN_REMOVESERVER, source, addr );
CNSTI4 74
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 291
;291:}
LABELV $156
endproc trap_LAN_RemoveServer 0 12
export trap_LAN_CompareServers
proc trap_LAN_CompareServers 4 24
line 293
;292:
;293:int trap_LAN_CompareServers( int source, int sortKey, int sortDir, int s1, int s2 ) {
line 294
;294:	return syscall( UI_LAN_COMPARESERVERS, source, sortKey, sortDir, s1, s2 );
CNSTI4 85
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $157
endproc trap_LAN_CompareServers 4 24
export trap_MemoryRemaining
proc trap_MemoryRemaining 4 4
line 297
;295:}
;296:
;297:int trap_MemoryRemaining( void ) {
line 298
;298:	return syscall( UI_MEMORY_REMAINING );
CNSTI4 52
ARGI4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $158
endproc trap_MemoryRemaining 4 4
export trap_GetCDKey
proc trap_GetCDKey 0 12
line 301
;299:}
;300:
;301:void trap_GetCDKey( char *buf, int buflen ) {
line 302
;302:	syscall( UI_GET_CDKEY, buf, buflen );
CNSTI4 53
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 303
;303:}
LABELV $159
endproc trap_GetCDKey 0 12
export trap_SetCDKey
proc trap_SetCDKey 0 8
line 305
;304:
;305:void trap_SetCDKey( char *buf ) {
line 306
;306:	syscall( UI_SET_CDKEY, buf );
CNSTI4 54
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 307
;307:}
LABELV $160
endproc trap_SetCDKey 0 8
export trap_PC_AddGlobalDefine
proc trap_PC_AddGlobalDefine 4 8
line 309
;308:
;309:int trap_PC_AddGlobalDefine( char *define ) {
line 310
;310:	return syscall( UI_PC_ADD_GLOBAL_DEFINE, define );
CNSTI4 57
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $161
endproc trap_PC_AddGlobalDefine 4 8
export trap_PC_LoadSource
proc trap_PC_LoadSource 4 8
line 313
;311:}
;312:
;313:int trap_PC_LoadSource( const char *filename ) {
line 314
;314:	return syscall( UI_PC_LOAD_SOURCE, filename );
CNSTI4 58
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $162
endproc trap_PC_LoadSource 4 8
export trap_PC_FreeSource
proc trap_PC_FreeSource 4 8
line 317
;315:}
;316:
;317:int trap_PC_FreeSource( int handle ) {
line 318
;318:	return syscall( UI_PC_FREE_SOURCE, handle );
CNSTI4 59
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $163
endproc trap_PC_FreeSource 4 8
export trap_PC_ReadToken
proc trap_PC_ReadToken 4 12
line 321
;319:}
;320:
;321:int trap_PC_ReadToken( int handle, pc_token_t *pc_token ) {
line 322
;322:	return syscall( UI_PC_READ_TOKEN, handle, pc_token );
CNSTI4 60
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $164
endproc trap_PC_ReadToken 4 12
export trap_PC_SourceFileAndLine
proc trap_PC_SourceFileAndLine 4 16
line 325
;323:}
;324:
;325:int trap_PC_SourceFileAndLine( int handle, char *filename, int *line ) {
line 326
;326:	return syscall( UI_PC_SOURCE_FILE_AND_LINE, handle, filename, line );
CNSTI4 61
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $165
endproc trap_PC_SourceFileAndLine 4 16
export trap_S_StopBackgroundTrack
proc trap_S_StopBackgroundTrack 0 4
line 329
;327:}
;328:
;329:void trap_S_StopBackgroundTrack( void ) {
line 330
;330:	syscall( UI_S_STOPBACKGROUNDTRACK );
CNSTI4 62
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 331
;331:}
LABELV $166
endproc trap_S_StopBackgroundTrack 0 4
export trap_S_StartBackgroundTrack
proc trap_S_StartBackgroundTrack 0 12
line 333
;332:
;333:void trap_S_StartBackgroundTrack( const char *intro, const char *loop) {
line 334
;334:	syscall( UI_S_STARTBACKGROUNDTRACK, intro, loop );
CNSTI4 63
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 335
;335:}
LABELV $167
endproc trap_S_StartBackgroundTrack 0 12
export trap_RealTime
proc trap_RealTime 4 8
line 337
;336:
;337:int trap_RealTime(qtime_t *qtime) {
line 338
;338:	return syscall( UI_REAL_TIME, qtime );
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $168
endproc trap_RealTime 4 8
export trap_CIN_PlayCinematic
proc trap_CIN_PlayCinematic 4 28
line 342
;339:}
;340:
;341:// this returns a handle.  arg0 is the name in the format "idlogo.roq", set arg1 to NULL, alteredstates to qfalse (do not alter gamestate)
;342:int trap_CIN_PlayCinematic( const char *arg0, int xpos, int ypos, int width, int height, int bits) {
line 343
;343:  return syscall(UI_CIN_PLAYCINEMATIC, arg0, xpos, ypos, width, height, bits);
CNSTI4 75
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRFP4 20
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $169
endproc trap_CIN_PlayCinematic 4 28
export trap_CIN_StopCinematic
proc trap_CIN_StopCinematic 4 8
line 348
;344:}
;345: 
;346:// stops playing the cinematic and ends it.  should always return FMV_EOF
;347:// cinematics must be stopped in reverse order of when they are started
;348:e_status trap_CIN_StopCinematic(int handle) {
line 349
;349:  return syscall(UI_CIN_STOPCINEMATIC, handle);
CNSTI4 76
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $170
endproc trap_CIN_StopCinematic 4 8
export trap_CIN_RunCinematic
proc trap_CIN_RunCinematic 4 8
line 354
;350:}
;351:
;352:
;353:// will run a frame of the cinematic but will not draw it.  Will return FMV_EOF if the end of the cinematic has been reached.
;354:e_status trap_CIN_RunCinematic (int handle) {
line 355
;355:  return syscall(UI_CIN_RUNCINEMATIC, handle);
CNSTI4 77
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $171
endproc trap_CIN_RunCinematic 4 8
export trap_CIN_DrawCinematic
proc trap_CIN_DrawCinematic 0 8
line 360
;356:}
;357: 
;358:
;359:// draws the current frame
;360:void trap_CIN_DrawCinematic (int handle) {
line 361
;361:  syscall(UI_CIN_DRAWCINEMATIC, handle);
CNSTI4 78
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 362
;362:}
LABELV $172
endproc trap_CIN_DrawCinematic 0 8
export trap_CIN_SetExtents
proc trap_CIN_SetExtents 0 24
line 366
;363: 
;364:
;365:// allows you to resize the animation dynamically
;366:void trap_CIN_SetExtents (int handle, int x, int y, int w, int h) {
line 367
;367:  syscall(UI_CIN_SETEXTENTS, handle, x, y, w, h);
CNSTI4 79
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 368
;368:}
LABELV $173
endproc trap_CIN_SetExtents 0 24
export trap_R_RemapShader
proc trap_R_RemapShader 0 16
line 371
;369:
;370:
;371:void	trap_R_RemapShader( const char *oldShader, const char *newShader, const char *timeOffset ) {
line 372
;372:	syscall( UI_R_REMAP_SHADER, oldShader, newShader, timeOffset );
CNSTI4 80
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 373
;373:}
LABELV $174
endproc trap_R_RemapShader 0 16
export trap_VerifyCDKey
proc trap_VerifyCDKey 4 12
line 375
;374:
;375:qboolean trap_VerifyCDKey( const char *key, const char *chksum) {
line 376
;376:	return syscall( UI_VERIFY_CDKEY, key, chksum);
CNSTI4 81
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 syscall
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $175
endproc trap_VerifyCDKey 4 12
export trap_SetPbClStatus
proc trap_SetPbClStatus 0 8
line 379
;377:}
;378:
;379:void trap_SetPbClStatus( int status ) {
line 380
;380:	syscall( UI_SET_PBCLSTATUS, status );
CNSTI4 87
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 syscall
INDIRP4
CALLI4
pop
line 381
;381:}
LABELV $176
endproc trap_SetPbClStatus 0 8
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
import UI_LoadArenas
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

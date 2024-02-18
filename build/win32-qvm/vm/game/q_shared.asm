export Com_Clamp
code
proc Com_Clamp 0 0
file "..\..\..\..\code\game\q_shared.c"
line 6
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// q_shared.c -- stateless support routines that are included in each code dll
;4:#include "q_shared.h"
;5:
;6:float Com_Clamp(float min, float max, float value) {
line 7
;7:	if (value < min) {
ADDRFP4 8
INDIRF4
ADDRFP4 0
INDIRF4
GEF4 $22
line 8
;8:		return min;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $21
JUMPV
LABELV $22
line 10
;9:	}
;10:	if (value > max) {
ADDRFP4 8
INDIRF4
ADDRFP4 4
INDIRF4
LEF4 $24
line 11
;11:		return max;
ADDRFP4 4
INDIRF4
RETF4
ADDRGP4 $21
JUMPV
LABELV $24
line 13
;12:	}
;13:	return value;
ADDRFP4 8
INDIRF4
RETF4
LABELV $21
endproc Com_Clamp 0 0
export COM_SkipPath
proc COM_SkipPath 4 0
line 22
;14:}
;15:
;16:
;17:/*
;18:============
;19:COM_SkipPath
;20:============
;21:*/
;22:char *COM_SkipPath(char *pathname) {
line 25
;23:	char *last;
;24:
;25:	last = pathname;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $28
JUMPV
LABELV $27
line 26
;26:	while (*pathname) {
line 27
;27:		if (*pathname == '/')
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $30
line 28
;28:			last = pathname + 1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $30
line 29
;29:		pathname++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 30
;30:	}
LABELV $28
line 26
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $27
line 31
;31:	return last;
ADDRLP4 0
INDIRP4
RETP4
LABELV $26
endproc COM_SkipPath 4 0
export COM_StripExtension
proc COM_StripExtension 12 12
line 39
;32:}
;33:
;34:/*
;35:============
;36:COM_StripExtension
;37:============
;38:*/
;39:void COM_StripExtension(const char *in, char *out, int destsize) {
line 42
;40:	int             length;
;41:
;42:	Q_strncpyz(out, in, destsize);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 44
;43:
;44:	length = strlen(out) - 1;
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $34
JUMPV
LABELV $33
line 45
;45:	while (length > 0 && out[length] != '.') {
line 46
;46:		length--;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 47
;47:		if (out[length] == '/')
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $36
line 48
;48:			return;		// no extension
ADDRGP4 $32
JUMPV
LABELV $36
line 49
;49:	}
LABELV $34
line 45
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $38
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 46
NEI4 $33
LABELV $38
line 50
;50:	if (length)
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $39
line 51
;51:		out[length] = '\0';
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
LABELV $39
line 52
;52:}
LABELV $32
endproc COM_StripExtension 12 12
export COM_DefaultExtension
proc COM_DefaultExtension 76 20
line 60
;53:
;54:
;55:/*
;56:==================
;57:COM_DefaultExtension
;58:==================
;59:*/
;60:void COM_DefaultExtension(char *path, int maxSize, const char *extension) {
line 68
;61:	char	oldPath[MAX_QPATH];
;62:	char *src;
;63:
;64:	//
;65:	// if path doesn't have a .EXT, append extension
;66:	// (extension should include the .)
;67:	//
;68:	src = path + strlen(path) - 1;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 68
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
CNSTI4 -1
ADDP4
ASGNP4
ADDRGP4 $43
JUMPV
LABELV $42
line 70
;69:
;70:	while (*src != '/' && src != path) {
line 71
;71:		if (*src == '.') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 46
NEI4 $45
line 72
;72:			return;                 // it has an extension
ADDRGP4 $41
JUMPV
LABELV $45
line 74
;73:		}
;74:		src--;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 -1
ADDP4
ASGNP4
line 75
;75:	}
LABELV $43
line 70
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 47
EQI4 $47
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $42
LABELV $47
line 77
;76:
;77:	Q_strncpyz(oldPath, path, sizeof(oldPath));
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
line 78
;78:	Com_sprintf(path, maxSize, "%s%s", oldPath, extension);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $48
ARGP4
ADDRLP4 4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 79
;79:}
LABELV $41
endproc COM_DefaultExtension 76 20
export COM_BeginParseSession
proc COM_BeginParseSession 0 16
line 96
;80:
;81:
;82:/*
;83:============================================================================
;84:
;85:PARSING
;86:
;87:============================================================================
;88:*/
;89:
;90:static	char	com_token[MAX_TOKEN_CHARS];
;91:static	char	com_parsename[MAX_TOKEN_CHARS];
;92:static	int		com_lines;
;93:static	int		com_tokenline;
;94:static	int		is_separator[256];
;95:
;96:void COM_BeginParseSession(const char *name) {
line 97
;97:	com_lines = 1;
ADDRGP4 com_lines
CNSTI4 1
ASGNI4
line 98
;98:	com_tokenline = 0;
ADDRGP4 com_tokenline
CNSTI4 0
ASGNI4
line 99
;99:	Com_sprintf(com_parsename, sizeof(com_parsename), "%s", name);
ADDRGP4 com_parsename
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $50
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 100
;100:}
LABELV $49
endproc COM_BeginParseSession 0 16
export COM_GetCurrentParseLine
proc COM_GetCurrentParseLine 0 0
line 103
;101:
;102:
;103:int COM_GetCurrentParseLine(void) {
line 104
;104:	if (com_tokenline) {
ADDRGP4 com_tokenline
INDIRI4
CNSTI4 0
EQI4 $52
line 105
;105:		return com_tokenline;
ADDRGP4 com_tokenline
INDIRI4
RETI4
ADDRGP4 $51
JUMPV
LABELV $52
line 108
;106:	}
;107:
;108:	return com_lines;
ADDRGP4 com_lines
INDIRI4
RETI4
LABELV $51
endproc COM_GetCurrentParseLine 0 0
export COM_Parse
proc COM_Parse 4 8
line 111
;109:}
;110:
;111:char *COM_Parse(char **data_p) {
line 112
;112:	return COM_ParseExt(data_p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
RETP4
LABELV $54
endproc COM_Parse 4 8
bss
align 1
LABELV $56
skip 4096
export COM_ParseError
code
proc COM_ParseError 4 16
line 119
;113:}
;114:
;115:
;116:extern int ED_vsprintf(char *buffer, const char *fmt, va_list argptr);
;117:
;118:
;119:void COM_ParseError(char *format, ...) {
line 123
;120:	va_list argptr;
;121:	static char string[4096];
;122:
;123:	va_start(argptr, format);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 124
;124:	ED_vsprintf(string, format, argptr);
ADDRGP4 $56
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
line 125
;125:	va_end(argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 127
;126:
;127:	Com_Printf("ERROR: %s, line %d: %s\n", com_parsename, com_lines, string);
ADDRGP4 $58
ARGP4
ADDRGP4 com_parsename
ARGP4
ADDRGP4 com_lines
INDIRI4
ARGI4
ADDRGP4 $56
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 128
;128:}
LABELV $55
endproc COM_ParseError 4 16
bss
align 1
LABELV $60
skip 4096
export COM_ParseWarning
code
proc COM_ParseWarning 4 16
line 131
;129:
;130:
;131:void COM_ParseWarning(char *format, ...) {
line 135
;132:	va_list argptr;
;133:	static char string[4096];
;134:
;135:	va_start(argptr, format);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 136
;136:	ED_vsprintf(string, format, argptr);
ADDRGP4 $60
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
line 137
;137:	va_end(argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 139
;138:
;139:	Com_Printf("WARNING: %s, line %d: %s\n", com_parsename, com_lines, string);
ADDRGP4 $62
ARGP4
ADDRGP4 com_parsename
ARGP4
ADDRGP4 com_lines
INDIRI4
ARGI4
ADDRGP4 $60
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 140
;140:}
LABELV $59
endproc COM_ParseWarning 4 16
proc SkipWhitespace 8 0
line 155
;141:
;142:
;143:/*
;144:==============
;145:COM_Parse
;146:
;147:Parse a token out of a string
;148:Will never return NULL, just empty strings
;149:
;150:If "allowLineBreaks" is qtrue then an empty
;151:string will be returned if the next token is
;152:a newline.
;153:==============
;154:*/
;155:static char *SkipWhitespace(char *data, qboolean *hasNewLines) {
ADDRGP4 $65
JUMPV
LABELV $64
line 158
;156:	int c;
;157:
;158:	while ((c = *data) <= ' ') {
line 159
;159:		if (!c) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $67
line 160
;160:			return NULL;
CNSTP4 0
RETP4
ADDRGP4 $63
JUMPV
LABELV $67
line 162
;161:		}
;162:		if (c == '\n') {
ADDRLP4 0
INDIRI4
CNSTI4 10
NEI4 $69
line 163
;163:			com_lines++;
ADDRLP4 4
ADDRGP4 com_lines
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 164
;164:			*hasNewLines = qtrue;
ADDRFP4 4
INDIRP4
CNSTI4 1
ASGNI4
line 165
;165:		}
LABELV $69
line 166
;166:		data++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 167
;167:	}
LABELV $65
line 158
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 32
LEI4 $64
line 169
;168:
;169:	return data;
ADDRFP4 0
INDIRP4
RETP4
LABELV $63
endproc SkipWhitespace 8 0
export COM_Compress
proc COM_Compress 44 0
line 173
;170:}
;171:
;172:
;173:int COM_Compress(char *data_p) {
line 176
;174:	char *in, *out;
;175:	int c;
;176:	qboolean newline = qfalse, whitespace = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 16
CNSTI4 0
ASGNI4
line 178
;177:
;178:	in = out = data_p;
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 179
;179:	if (in) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $72
ADDRGP4 $75
JUMPV
LABELV $74
line 180
;180:		while ((c = *in) != 0) {
line 182
;181:			// skip double slash comments
;182:			if (c == '/' && in[1] == '/') {
ADDRLP4 4
INDIRI4
CNSTI4 47
NEI4 $77
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $77
ADDRGP4 $80
JUMPV
LABELV $79
line 183
;183:				while (*in && *in != '\n') {
line 184
;184:					in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 185
;185:				}
LABELV $80
line 183
ADDRLP4 24
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $82
ADDRLP4 24
INDIRI4
CNSTI4 10
NEI4 $79
LABELV $82
line 187
;186:				// skip /* */ comments
;187:			} else if (c == '/' && in[1] == '*') {
ADDRGP4 $78
JUMPV
LABELV $77
ADDRLP4 4
INDIRI4
CNSTI4 47
NEI4 $83
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $83
ADDRGP4 $86
JUMPV
LABELV $85
line 189
;188:				while (*in && (*in != '*' || in[1] != '/'))
;189:					in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $86
line 188
ADDRLP4 28
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $88
ADDRLP4 28
INDIRI4
CNSTI4 42
NEI4 $85
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $85
LABELV $88
line 190
;190:				if (*in)
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $84
line 191
;191:					in += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 193
;192:				// record when we hit a newline
;193:			} else if (c == '\n' || c == '\r') {
ADDRGP4 $84
JUMPV
LABELV $83
ADDRLP4 4
INDIRI4
CNSTI4 10
EQI4 $93
ADDRLP4 4
INDIRI4
CNSTI4 13
NEI4 $91
LABELV $93
line 194
;194:				newline = qtrue;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 195
;195:				in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 197
;196:				// record when we hit whitespace
;197:			} else if (c == ' ' || c == '\t') {
ADDRGP4 $92
JUMPV
LABELV $91
ADDRLP4 4
INDIRI4
CNSTI4 32
EQI4 $96
ADDRLP4 4
INDIRI4
CNSTI4 9
NEI4 $94
LABELV $96
line 198
;198:				whitespace = qtrue;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 199
;199:				in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 201
;200:				// an actual token
;201:			} else {
ADDRGP4 $95
JUMPV
LABELV $94
line 203
;202:				// if we have a pending newline, emit it (and it counts as whitespace)
;203:				if (newline) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $97
line 204
;204:					*out++ = '\n';
ADDRLP4 32
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI1 10
ASGNI1
line 205
;205:					newline = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 206
;206:					whitespace = qfalse;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 207
;207:				} else if (whitespace) {
ADDRGP4 $98
JUMPV
LABELV $97
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $99
line 208
;208:					*out++ = ' ';
ADDRLP4 32
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI1 32
ASGNI1
line 209
;209:					whitespace = qfalse;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 210
;210:				}
LABELV $99
LABELV $98
line 213
;211:
;212:				// copy quoted strings unmolested
;213:				if (c == '"') {
ADDRLP4 4
INDIRI4
CNSTI4 34
NEI4 $101
line 214
;214:					*out++ = c;
ADDRLP4 32
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 215
;215:					in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRGP4 $104
JUMPV
LABELV $103
line 216
;216:					while (1) {
line 217
;217:						c = *in;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 218
;218:						if (c && c != '"') {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $105
ADDRLP4 4
INDIRI4
CNSTI4 34
EQI4 $105
line 219
;219:							*out++ = c;
ADDRLP4 40
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 40
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 220
;220:							in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 221
;221:						} else {
line 222
;222:							break;
LABELV $107
line 224
;223:						}
;224:					}
LABELV $104
line 216
ADDRGP4 $103
JUMPV
LABELV $105
line 225
;225:					if (c == '"') {
ADDRLP4 4
INDIRI4
CNSTI4 34
NEI4 $102
line 226
;226:						*out++ = c;
ADDRLP4 36
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 36
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 227
;227:						in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 228
;228:					}
line 229
;229:				} else {
ADDRGP4 $102
JUMPV
LABELV $101
line 230
;230:					*out = c;
ADDRLP4 8
INDIRP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 231
;231:					out++;
ADDRLP4 8
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 232
;232:					in++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 233
;233:				}
LABELV $102
line 234
;234:			}
LABELV $95
LABELV $92
LABELV $84
LABELV $78
line 235
;235:		}
LABELV $75
line 180
ADDRLP4 24
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4
ADDRLP4 24
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $74
line 236
;236:	}
LABELV $72
line 237
;237:	*out = 0;
ADDRLP4 8
INDIRP4
CNSTI1 0
ASGNI1
line 238
;238:	return out - data_p;
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
RETI4
LABELV $71
endproc COM_Compress 44 0
export COM_ParseExt
proc COM_ParseExt 28 8
line 242
;239:}
;240:
;241:
;242:char *COM_ParseExt(char **data_p, qboolean allowLineBreaks) {
line 243
;243:	int c = 0, len;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 244
;244:	qboolean hasNewLines = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 247
;245:	char *data;
;246:
;247:	data = *data_p;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
line 248
;248:	len = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 249
;249:	com_token[0] = '\0';
ADDRGP4 com_token
CNSTI1 0
ASGNI1
line 250
;250:	com_tokenline = 0;
ADDRGP4 com_tokenline
CNSTI4 0
ASGNI4
line 253
;251:
;252:	// make sure incoming data is valid
;253:	if (!data) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $114
line 254
;254:		*data_p = NULL;
ADDRFP4 0
INDIRP4
CNSTP4 0
ASGNP4
line 255
;255:		return com_token;
ADDRGP4 com_token
RETP4
ADDRGP4 $110
JUMPV
LABELV $113
line 258
;256:	}
;257:
;258:	while (1) {
line 260
;259:		// skip whitespace
;260:		data = SkipWhitespace(data, &hasNewLines);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 16
ADDRGP4 SkipWhitespace
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 261
;261:		if (!data) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $116
line 262
;262:			*data_p = NULL;
ADDRFP4 0
INDIRP4
CNSTP4 0
ASGNP4
line 263
;263:			return com_token;
ADDRGP4 com_token
RETP4
ADDRGP4 $110
JUMPV
LABELV $116
line 265
;264:		}
;265:		if (hasNewLines && !allowLineBreaks) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $118
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $118
line 266
;266:			*data_p = data;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 267
;267:			return com_token;
ADDRGP4 com_token
RETP4
ADDRGP4 $110
JUMPV
LABELV $118
line 270
;268:		}
;269:
;270:		c = *data;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 273
;271:
;272:		// skip double slash comments
;273:		if (c == '/' && data[1] == '/') {
ADDRLP4 4
INDIRI4
CNSTI4 47
NEI4 $120
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $120
line 274
;274:			data += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
ADDRGP4 $123
JUMPV
LABELV $122
line 275
;275:			while (*data && *data != '\n') {
line 276
;276:				data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 277
;277:			}
LABELV $123
line 275
ADDRLP4 20
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $125
ADDRLP4 20
INDIRI4
CNSTI4 10
NEI4 $122
LABELV $125
line 278
;278:		}
ADDRGP4 $121
JUMPV
LABELV $120
line 280
;279:		// skip /* */ comments
;280:		else if (c == '/' && data[1] == '*') {
ADDRLP4 4
INDIRI4
CNSTI4 47
NEI4 $115
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $115
line 281
;281:			data += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
ADDRGP4 $129
JUMPV
LABELV $128
line 282
;282:			while (*data && (*data != '*' || data[1] != '/')) {
line 283
;283:				if (*data == '\n') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 10
NEI4 $131
line 284
;284:					com_lines++;
ADDRLP4 20
ADDRGP4 com_lines
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 285
;285:				}
LABELV $131
line 286
;286:				data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 287
;287:			}
LABELV $129
line 282
ADDRLP4 24
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $133
ADDRLP4 24
INDIRI4
CNSTI4 42
NEI4 $128
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $128
LABELV $133
line 288
;288:			if (*data) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $127
line 289
;289:				data += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 290
;290:			}
line 291
;291:		} else {
line 292
;292:			break;
LABELV $127
LABELV $121
line 294
;293:		}
;294:	}
LABELV $114
line 258
ADDRGP4 $113
JUMPV
LABELV $115
line 296
;295:
;296:	com_tokenline = com_lines;
ADDRGP4 com_tokenline
ADDRGP4 com_lines
INDIRI4
ASGNI4
line 299
;297:
;298:	// handle quoted strings
;299:	if (c == '"') {
ADDRLP4 4
INDIRI4
CNSTI4 34
NEI4 $136
line 300
;300:		data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRGP4 $139
JUMPV
LABELV $138
line 301
;301:		while (1) {
line 302
;302:			c = *data;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 303
;303:			if (c == '"' || c == '\0') {
ADDRLP4 4
INDIRI4
CNSTI4 34
EQI4 $143
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $141
LABELV $143
line 304
;304:				if (c == '"')
ADDRLP4 4
INDIRI4
CNSTI4 34
NEI4 $144
line 305
;305:					data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $144
line 307
;306:
;307:				com_token[len] = '\0';
ADDRLP4 8
INDIRI4
ADDRGP4 com_token
ADDP4
CNSTI1 0
ASGNI1
line 308
;308:				*data_p = (char *)data;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 309
;309:				return com_token;
ADDRGP4 com_token
RETP4
ADDRGP4 $110
JUMPV
LABELV $141
line 311
;310:			}
;311:			data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 312
;312:			if (c == '\n') {
ADDRLP4 4
INDIRI4
CNSTI4 10
NEI4 $146
line 313
;313:				com_lines++;
ADDRLP4 20
ADDRGP4 com_lines
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 314
;314:			}
LABELV $146
line 315
;315:			if (len < MAX_TOKEN_CHARS - 1) {
ADDRLP4 8
INDIRI4
CNSTI4 1023
GEI4 $148
line 316
;316:				com_token[len] = c;
ADDRLP4 8
INDIRI4
ADDRGP4 com_token
ADDP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 317
;317:				len++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 318
;318:			}
LABELV $148
line 319
;319:		}
LABELV $139
line 301
ADDRGP4 $138
JUMPV
line 320
;320:	}
LABELV $136
LABELV $150
line 323
;321:
;322:	// parse a regular word
;323:	do {
line 324
;324:		if (len < MAX_TOKEN_CHARS - 1) {
ADDRLP4 8
INDIRI4
CNSTI4 1023
GEI4 $153
line 325
;325:			com_token[len] = c;
ADDRLP4 8
INDIRI4
ADDRGP4 com_token
ADDP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 326
;326:			len++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 327
;327:		}
LABELV $153
line 328
;328:		data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 329
;329:		c = *data;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 330
;330:	} while (c > ' ');
LABELV $151
ADDRLP4 4
INDIRI4
CNSTI4 32
GTI4 $150
line 332
;331:
;332:	com_token[len] = '\0';
ADDRLP4 8
INDIRI4
ADDRGP4 com_token
ADDP4
CNSTI1 0
ASGNI1
line 334
;333:
;334:	*data_p = (char *)data;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 335
;335:	return com_token;
ADDRGP4 com_token
RETP4
LABELV $110
endproc COM_ParseExt 28 8
export COM_MatchToken
proc COM_MatchToken 12 16
line 344
;336:}
;337:
;338:
;339:/*
;340:==================
;341:COM_MatchToken
;342:==================
;343:*/
;344:void COM_MatchToken(char **buf_p, char *match) {
line 347
;345:	char *token;
;346:
;347:	token = COM_Parse(buf_p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 348
;348:	if (strcmp(token, match)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $156
line 349
;349:		Com_Error(ERR_DROP, "MatchToken: %s != %s", token, match);
CNSTI4 1
ARGI4
ADDRGP4 $158
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 350
;350:	}
LABELV $156
line 351
;351:}
LABELV $155
endproc COM_MatchToken 12 16
export SkipBracedSection
proc SkipBracedSection 12 8
line 363
;352:
;353:
;354:/*
;355:=================
;356:SkipBracedSection
;357:
;358:The next token should be an open brace.
;359:Skips until a matching close brace is found.
;360:Internal brace depths are properly skipped.
;361:=================
;362:*/
;363:void SkipBracedSection(char **program) {
line 367
;364:	char *token;
;365:	int				depth;
;366:
;367:	depth = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $160
line 368
;368:	do {
line 369
;369:		token = COM_ParseExt(program, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 370
;370:		if (token[1] == 0) {
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $163
line 371
;371:			if (token[0] == '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $165
line 372
;372:				depth++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 373
;373:			} else if (token[0] == '}') {
ADDRGP4 $166
JUMPV
LABELV $165
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $167
line 374
;374:				depth--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 375
;375:			}
LABELV $167
LABELV $166
line 376
;376:		}
LABELV $163
line 377
;377:	} while (depth && *program);
LABELV $161
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $169
ADDRFP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $160
LABELV $169
line 378
;378:}
LABELV $159
endproc SkipBracedSection 12 8
export SkipRestOfLine
proc SkipRestOfLine 12 0
line 386
;379:
;380:
;381:/*
;382:=================
;383:SkipRestOfLine
;384:=================
;385:*/
;386:void SkipRestOfLine(char **data) {
line 390
;387:	char *p;
;388:	int		c;
;389:
;390:	p = *data;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
line 392
;391:
;392:	if (!*p)
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $174
line 393
;393:		return;
ADDRGP4 $170
JUMPV
LABELV $173
line 395
;394:
;395:	while ((c = *p) != '\0') {
line 396
;396:		p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 397
;397:		if (c == '\n') {
ADDRLP4 4
INDIRI4
CNSTI4 10
NEI4 $176
line 398
;398:			com_lines++;
ADDRLP4 8
ADDRGP4 com_lines
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 399
;399:			break;
ADDRGP4 $175
JUMPV
LABELV $176
line 401
;400:		}
;401:	}
LABELV $174
line 395
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $173
LABELV $175
line 403
;402:
;403:	*data = p;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 404
;404:}
LABELV $170
endproc SkipRestOfLine 12 0
export Com_InitSeparators
proc Com_InitSeparators 0 0
line 407
;405:
;406:
;407:void Com_InitSeparators(void) {
line 408
;408:	is_separator['\n'] = 1;
ADDRGP4 is_separator+40
CNSTI4 1
ASGNI4
line 409
;409:	is_separator[';'] = 1;
ADDRGP4 is_separator+236
CNSTI4 1
ASGNI4
line 410
;410:	is_separator['='] = 1;
ADDRGP4 is_separator+244
CNSTI4 1
ASGNI4
line 411
;411:	is_separator['{'] = 1;
ADDRGP4 is_separator+492
CNSTI4 1
ASGNI4
line 412
;412:	is_separator['}'] = 1;
ADDRGP4 is_separator+500
CNSTI4 1
ASGNI4
line 413
;413:}
LABELV $178
endproc Com_InitSeparators 0 0
export SkipTillSeparators
proc SkipTillSeparators 12 0
line 416
;414:
;415:
;416:void SkipTillSeparators(char **data) {
line 420
;417:	char *p;
;418:	int	c;
;419:
;420:	p = *data;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
line 422
;421:
;422:	if (!*p)
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $188
line 423
;423:		return;
ADDRGP4 $184
JUMPV
LABELV $187
line 425
;424:
;425:	while ((c = *p) != '\0') {
line 426
;426:		p++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 427
;427:		if (is_separator[c]) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 is_separator
ADDP4
INDIRI4
CNSTI4 0
EQI4 $190
line 428
;428:			if (c == '\n') {
ADDRLP4 0
INDIRI4
CNSTI4 10
NEI4 $189
line 429
;429:				com_lines++;
ADDRLP4 8
ADDRGP4 com_lines
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 430
;430:			}
line 431
;431:			break;
ADDRGP4 $189
JUMPV
LABELV $190
line 433
;432:		}
;433:	}
LABELV $188
line 425
ADDRLP4 8
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $187
LABELV $189
line 435
;434:
;435:	*data = p;
ADDRFP4 0
INDIRP4
ADDRLP4 4
INDIRP4
ASGNP4
line 436
;436:}
LABELV $184
endproc SkipTillSeparators 12 0
export COM_ParseSep
proc COM_ParseSep 28 8
line 439
;437:
;438:
;439:char *COM_ParseSep(char **data_p, qboolean allowLineBreaks) {
line 440
;440:	int c = 0, len;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 441
;441:	qboolean hasNewLines = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 444
;442:	char *data;
;443:
;444:	data = *data_p;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
line 445
;445:	len = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 446
;446:	com_token[0] = '\0';
ADDRGP4 com_token
CNSTI1 0
ASGNI1
line 447
;447:	com_tokenline = 0;
ADDRGP4 com_tokenline
CNSTI4 0
ASGNI4
line 450
;448:
;449:	// make sure incoming data is valid
;450:	if (!data) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $198
line 451
;451:		*data_p = NULL;
ADDRFP4 0
INDIRP4
CNSTP4 0
ASGNP4
line 452
;452:		return com_token;
ADDRGP4 com_token
RETP4
ADDRGP4 $194
JUMPV
LABELV $197
line 455
;453:	}
;454:
;455:	while (1) {
line 457
;456:		// skip whitespace
;457:		data = SkipWhitespace(data, &hasNewLines);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 16
ADDRGP4 SkipWhitespace
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 458
;458:		if (!data) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $200
line 459
;459:			*data_p = NULL;
ADDRFP4 0
INDIRP4
CNSTP4 0
ASGNP4
line 460
;460:			return com_token;
ADDRGP4 com_token
RETP4
ADDRGP4 $194
JUMPV
LABELV $200
line 462
;461:		}
;462:		if (hasNewLines && !allowLineBreaks) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $202
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $202
line 463
;463:			*data_p = data;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 464
;464:			return com_token;
ADDRGP4 com_token
RETP4
ADDRGP4 $194
JUMPV
LABELV $202
line 467
;465:		}
;466:
;467:		c = *data;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 470
;468:
;469:		// skip double slash comments
;470:		if (c == '/' && data[1] == '/') {
ADDRLP4 4
INDIRI4
CNSTI4 47
NEI4 $204
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $204
line 471
;471:			data += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
ADDRGP4 $207
JUMPV
LABELV $206
line 472
;472:			while (*data && *data != '\n') {
line 473
;473:				data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 474
;474:			}
LABELV $207
line 472
ADDRLP4 20
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $209
ADDRLP4 20
INDIRI4
CNSTI4 10
NEI4 $206
LABELV $209
line 475
;475:		}
ADDRGP4 $205
JUMPV
LABELV $204
line 477
;476:		// skip /* */ comments
;477:		else if (c == '/' && data[1] == '*') {
ADDRLP4 4
INDIRI4
CNSTI4 47
NEI4 $199
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $199
line 478
;478:			data += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
ADDRGP4 $213
JUMPV
LABELV $212
line 479
;479:			while (*data && (*data != '*' || data[1] != '/')) {
line 480
;480:				if (*data == '\n') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 10
NEI4 $215
line 481
;481:					com_lines++;
ADDRLP4 20
ADDRGP4 com_lines
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 482
;482:				}
LABELV $215
line 483
;483:				data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 484
;484:			}
LABELV $213
line 479
ADDRLP4 24
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $217
ADDRLP4 24
INDIRI4
CNSTI4 42
NEI4 $212
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $212
LABELV $217
line 485
;485:			if (*data) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $211
line 486
;486:				data += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 487
;487:			}
line 488
;488:		} else {
line 489
;489:			break;
LABELV $211
LABELV $205
line 491
;490:		}
;491:	}
LABELV $198
line 455
ADDRGP4 $197
JUMPV
LABELV $199
line 493
;492:
;493:	com_tokenline = com_lines;
ADDRGP4 com_tokenline
ADDRGP4 com_lines
INDIRI4
ASGNI4
line 496
;494:
;495:	// handle quoted strings
;496:	if (c == '"') {
ADDRLP4 4
INDIRI4
CNSTI4 34
NEI4 $220
line 497
;497:		data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRGP4 $223
JUMPV
LABELV $222
line 498
;498:		while (1) {
line 499
;499:			c = *data;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 500
;500:			if (c == '"' || c == '\0') {
ADDRLP4 4
INDIRI4
CNSTI4 34
EQI4 $227
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $225
LABELV $227
line 501
;501:				if (c == '"')
ADDRLP4 4
INDIRI4
CNSTI4 34
NEI4 $228
line 502
;502:					data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $228
line 504
;503:
;504:				com_token[len] = '\0';
ADDRLP4 8
INDIRI4
ADDRGP4 com_token
ADDP4
CNSTI1 0
ASGNI1
line 505
;505:				*data_p = (char *)data;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 506
;506:				return com_token;
ADDRGP4 com_token
RETP4
ADDRGP4 $194
JUMPV
LABELV $225
line 508
;507:			}
;508:			data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 509
;509:			if (c == '\n') {
ADDRLP4 4
INDIRI4
CNSTI4 10
NEI4 $230
line 510
;510:				com_lines++;
ADDRLP4 20
ADDRGP4 com_lines
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 511
;511:			}
LABELV $230
line 512
;512:			if (len < MAX_TOKEN_CHARS - 1) {
ADDRLP4 8
INDIRI4
CNSTI4 1023
GEI4 $232
line 513
;513:				com_token[len] = c;
ADDRLP4 8
INDIRI4
ADDRGP4 com_token
ADDP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 514
;514:				len++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 515
;515:			}
LABELV $232
line 516
;516:		}
LABELV $223
line 498
ADDRGP4 $222
JUMPV
line 517
;517:	}
LABELV $220
line 520
;518:
;519:	// special case for separators
;520:	if (is_separator[c]) {
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 is_separator
ADDP4
INDIRI4
CNSTI4 0
EQI4 $234
line 521
;521:		com_token[len] = c;
ADDRLP4 8
INDIRI4
ADDRGP4 com_token
ADDP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 522
;522:		len++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 523
;523:		data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 524
;524:	} else // parse a regular word
ADDRGP4 $235
JUMPV
LABELV $234
LABELV $236
line 525
;525:		do {
line 526
;526:			if (len < MAX_TOKEN_CHARS - 1) {
ADDRLP4 8
INDIRI4
CNSTI4 1023
GEI4 $239
line 527
;527:				com_token[len] = c;
ADDRLP4 8
INDIRI4
ADDRGP4 com_token
ADDP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
line 528
;528:				len++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 529
;529:			}
LABELV $239
line 530
;530:			data++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 531
;531:			c = *data;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 532
;532:		} while (c > ' ' && !is_separator[c]);
LABELV $237
ADDRLP4 4
INDIRI4
CNSTI4 32
LEI4 $241
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 is_separator
ADDP4
INDIRI4
CNSTI4 0
EQI4 $236
LABELV $241
LABELV $235
line 534
;533:
;534:		com_token[len] = '\0';
ADDRLP4 8
INDIRI4
ADDRGP4 com_token
ADDP4
CNSTI1 0
ASGNI1
line 536
;535:
;536:		*data_p = (char *)data;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 537
;537:		return com_token;
ADDRGP4 com_token
RETP4
LABELV $194
endproc COM_ParseSep 28 8
export Com_Split
proc Com_Split 20 0
line 546
;538:}
;539:
;540:
;541:/*
;542:============
;543:Com_Split
;544:============
;545:*/
;546:int Com_Split(char *in, char **out, int outsz, int delim) {
line 548
;547:	int c;
;548:	char **o = out, **end = out + outsz;
ADDRLP4 8
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRFP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ASGNP4
line 550
;549:	// skip leading spaces
;550:	if (delim >= ' ') {
ADDRFP4 12
INDIRI4
CNSTI4 32
LTI4 $243
ADDRGP4 $246
JUMPV
LABELV $245
line 552
;551:		while ((c = *in) != '\0' && c <= ' ')
;552:			in++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $246
line 551
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $248
ADDRLP4 0
INDIRI4
CNSTI4 32
LEI4 $245
LABELV $248
line 553
;553:	}
LABELV $243
line 554
;554:	*out = in; out++;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRGP4 $250
JUMPV
line 555
;555:	while (out < end) {
LABELV $252
line 557
;556:		while ((c = *in) != '\0' && c != delim)
;557:			in++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $253
line 556
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $255
ADDRLP4 0
INDIRI4
ADDRFP4 12
INDIRI4
NEI4 $252
LABELV $255
line 558
;558:		*in = '\0';
ADDRFP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 559
;559:		if (!c) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $256
line 561
;560:			// don't count last null value
;561:			if (out[-1][0] == '\0')
ADDRFP4 4
INDIRP4
CNSTI4 -4
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $267
line 562
;562:				out--;
ADDRFP4 4
ADDRFP4 4
INDIRP4
CNSTI4 -4
ADDP4
ASGNP4
line 563
;563:			break;
ADDRGP4 $267
JUMPV
LABELV $256
line 565
;564:		}
;565:		in++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 567
;566:		// skip leading spaces
;567:		if (delim >= ' ') {
ADDRFP4 12
INDIRI4
CNSTI4 32
LTI4 $260
ADDRGP4 $263
JUMPV
LABELV $262
line 569
;568:			while ((c = *in) != '\0' && c <= ' ')
;569:				in++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $263
line 568
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 0
ADDRLP4 16
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $265
ADDRLP4 0
INDIRI4
CNSTI4 32
LEI4 $262
LABELV $265
line 570
;570:		}
LABELV $260
line 571
;571:		*out = in; out++;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
line 572
;572:	}
LABELV $250
line 555
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
LTU4 $253
ADDRGP4 $267
JUMPV
LABELV $266
line 575
;573:	// sanitize last value
;574:	while ((c = *in) != '\0' && c != delim)
;575:		in++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $267
line 574
ADDRLP4 12
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $269
ADDRLP4 0
INDIRI4
ADDRFP4 12
INDIRI4
NEI4 $266
LABELV $269
line 576
;576:	*in = '\0';
ADDRFP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 577
;577:	c = out - o;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 4
DIVI4
ASGNI4
ADDRGP4 $271
JUMPV
LABELV $270
line 579
;578:	// set remaining out pointers
;579:	while (out < end) {
line 580
;580:		*out = in; out++;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
line 581
;581:	}
LABELV $271
line 579
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
LTU4 $270
line 582
;582:	return c;
ADDRLP4 0
INDIRI4
RETI4
LABELV $242
endproc Com_Split 20 0
export Parse1DMatrix
proc Parse1DMatrix 16 8
line 586
;583:}
;584:
;585:
;586:void Parse1DMatrix(char **buf_p, int x, float *m) {
line 590
;587:	char *token;
;588:	int		i;
;589:
;590:	COM_MatchToken(buf_p, "(");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $274
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 592
;591:
;592:	for (i = 0; i < x; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $278
JUMPV
LABELV $275
line 593
;593:		token = COM_Parse(buf_p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 594
;594:		m[i] = atof(token);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
line 595
;595:	}
LABELV $276
line 592
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $278
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $275
line 597
;596:
;597:	COM_MatchToken(buf_p, ")");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $279
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 598
;598:}
LABELV $273
endproc Parse1DMatrix 16 8
export Parse2DMatrix
proc Parse2DMatrix 8 12
line 600
;599:
;600:void Parse2DMatrix(char **buf_p, int y, int x, float *m) {
line 603
;601:	int		i;
;602:
;603:	COM_MatchToken(buf_p, "(");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $274
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 605
;604:
;605:	for (i = 0; i < y; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $284
JUMPV
LABELV $281
line 606
;606:		Parse1DMatrix(buf_p, x, m + i * x);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
MULI4
CNSTI4 2
LSHI4
ADDRFP4 12
INDIRP4
ADDP4
ARGP4
ADDRGP4 Parse1DMatrix
CALLV
pop
line 607
;607:	}
LABELV $282
line 605
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $284
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $281
line 609
;608:
;609:	COM_MatchToken(buf_p, ")");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $279
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 610
;610:}
LABELV $280
endproc Parse2DMatrix 8 12
export Parse3DMatrix
proc Parse3DMatrix 12 16
line 612
;611:
;612:void Parse3DMatrix(char **buf_p, int z, int y, int x, float *m) {
line 615
;613:	int		i;
;614:
;615:	COM_MatchToken(buf_p, "(");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $274
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 617
;616:
;617:	for (i = 0; i < z; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $289
JUMPV
LABELV $286
line 618
;618:		Parse2DMatrix(buf_p, y, x, m + i * x * y);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRFP4 12
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
MULI4
ADDRLP4 4
INDIRI4
MULI4
CNSTI4 2
LSHI4
ADDRFP4 16
INDIRP4
ADDP4
ARGP4
ADDRGP4 Parse2DMatrix
CALLV
pop
line 619
;619:	}
LABELV $287
line 617
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $289
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $286
line 621
;620:
;621:	COM_MatchToken(buf_p, ")");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $279
ARGP4
ADDRGP4 COM_MatchToken
CALLV
pop
line 622
;622:}
LABELV $285
endproc Parse3DMatrix 12 16
lit
export locase
align 1
LABELV locase
byte 1 0
byte 1 1
byte 1 2
byte 1 3
byte 1 4
byte 1 5
byte 1 6
byte 1 7
byte 1 8
byte 1 9
byte 1 10
byte 1 11
byte 1 12
byte 1 13
byte 1 14
byte 1 15
byte 1 16
byte 1 17
byte 1 18
byte 1 19
byte 1 20
byte 1 21
byte 1 22
byte 1 23
byte 1 24
byte 1 25
byte 1 26
byte 1 27
byte 1 28
byte 1 29
byte 1 30
byte 1 31
byte 1 32
byte 1 33
byte 1 34
byte 1 35
byte 1 36
byte 1 37
byte 1 38
byte 1 39
byte 1 40
byte 1 41
byte 1 42
byte 1 43
byte 1 44
byte 1 45
byte 1 46
byte 1 47
byte 1 48
byte 1 49
byte 1 50
byte 1 51
byte 1 52
byte 1 53
byte 1 54
byte 1 55
byte 1 56
byte 1 57
byte 1 58
byte 1 59
byte 1 60
byte 1 61
byte 1 62
byte 1 63
byte 1 64
byte 1 97
byte 1 98
byte 1 99
byte 1 100
byte 1 101
byte 1 102
byte 1 103
byte 1 104
byte 1 105
byte 1 106
byte 1 107
byte 1 108
byte 1 109
byte 1 110
byte 1 111
byte 1 112
byte 1 113
byte 1 114
byte 1 115
byte 1 116
byte 1 117
byte 1 118
byte 1 119
byte 1 120
byte 1 121
byte 1 122
byte 1 91
byte 1 92
byte 1 93
byte 1 94
byte 1 95
byte 1 96
byte 1 97
byte 1 98
byte 1 99
byte 1 100
byte 1 101
byte 1 102
byte 1 103
byte 1 104
byte 1 105
byte 1 106
byte 1 107
byte 1 108
byte 1 109
byte 1 110
byte 1 111
byte 1 112
byte 1 113
byte 1 114
byte 1 115
byte 1 116
byte 1 117
byte 1 118
byte 1 119
byte 1 120
byte 1 121
byte 1 122
byte 1 123
byte 1 124
byte 1 125
byte 1 126
byte 1 127
byte 1 128
byte 1 129
byte 1 130
byte 1 131
byte 1 132
byte 1 133
byte 1 134
byte 1 135
byte 1 136
byte 1 137
byte 1 138
byte 1 139
byte 1 140
byte 1 141
byte 1 142
byte 1 143
byte 1 144
byte 1 145
byte 1 146
byte 1 147
byte 1 148
byte 1 149
byte 1 150
byte 1 151
byte 1 152
byte 1 153
byte 1 154
byte 1 155
byte 1 156
byte 1 157
byte 1 158
byte 1 159
byte 1 160
byte 1 161
byte 1 162
byte 1 163
byte 1 164
byte 1 165
byte 1 166
byte 1 167
byte 1 168
byte 1 169
byte 1 170
byte 1 171
byte 1 172
byte 1 173
byte 1 174
byte 1 175
byte 1 176
byte 1 177
byte 1 178
byte 1 179
byte 1 180
byte 1 181
byte 1 182
byte 1 183
byte 1 184
byte 1 185
byte 1 186
byte 1 187
byte 1 188
byte 1 189
byte 1 190
byte 1 191
byte 1 192
byte 1 193
byte 1 194
byte 1 195
byte 1 196
byte 1 197
byte 1 198
byte 1 199
byte 1 200
byte 1 201
byte 1 202
byte 1 203
byte 1 204
byte 1 205
byte 1 206
byte 1 207
byte 1 208
byte 1 209
byte 1 210
byte 1 211
byte 1 212
byte 1 213
byte 1 214
byte 1 215
byte 1 216
byte 1 217
byte 1 218
byte 1 219
byte 1 220
byte 1 221
byte 1 222
byte 1 223
byte 1 224
byte 1 225
byte 1 226
byte 1 227
byte 1 228
byte 1 229
byte 1 230
byte 1 231
byte 1 232
byte 1 233
byte 1 234
byte 1 235
byte 1 236
byte 1 237
byte 1 238
byte 1 239
byte 1 240
byte 1 241
byte 1 242
byte 1 243
byte 1 244
byte 1 245
byte 1 246
byte 1 247
byte 1 248
byte 1 249
byte 1 250
byte 1 251
byte 1 252
byte 1 253
byte 1 254
byte 1 255
export Q_isprint
code
proc Q_isprint 4 0
line 670
;623:
;624:
;625:/*
;626:============================================================================
;627:
;628:					LIBRARY REPLACEMENT FUNCTIONS
;629:
;630:============================================================================
;631:*/
;632:
;633:const byte locase[256] =
;634:{
;635:	0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,
;636:	0x08,0x09,0x0a,0x0b,0x0c,0x0d,0x0e,0x0f,
;637:	0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,
;638:	0x18,0x19,0x1a,0x1b,0x1c,0x1d,0x1e,0x1f,
;639:	0x20,0x21,0x22,0x23,0x24,0x25,0x26,0x27,
;640:	0x28,0x29,0x2a,0x2b,0x2c,0x2d,0x2e,0x2f,
;641:	0x30,0x31,0x32,0x33,0x34,0x35,0x36,0x37,
;642:	0x38,0x39,0x3a,0x3b,0x3c,0x3d,0x3e,0x3f,
;643:	0x40,0x61,0x62,0x63,0x64,0x65,0x66,0x67,
;644:	0x68,0x69,0x6a,0x6b,0x6c,0x6d,0x6e,0x6f,
;645:	0x70,0x71,0x72,0x73,0x74,0x75,0x76,0x77,
;646:	0x78,0x79,0x7a,0x5b,0x5c,0x5d,0x5e,0x5f,
;647:	0x60,0x61,0x62,0x63,0x64,0x65,0x66,0x67,
;648:	0x68,0x69,0x6a,0x6b,0x6c,0x6d,0x6e,0x6f,
;649:	0x70,0x71,0x72,0x73,0x74,0x75,0x76,0x77,
;650:	0x78,0x79,0x7a,0x7b,0x7c,0x7d,0x7e,0x7f,
;651:	0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,
;652:	0x88,0x89,0x8a,0x8b,0x8c,0x8d,0x8e,0x8f,
;653:	0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,
;654:	0x98,0x99,0x9a,0x9b,0x9c,0x9d,0x9e,0x9f,
;655:	0xa0,0xa1,0xa2,0xa3,0xa4,0xa5,0xa6,0xa7,
;656:	0xa8,0xa9,0xaa,0xab,0xac,0xad,0xae,0xaf,
;657:	0xb0,0xb1,0xb2,0xb3,0xb4,0xb5,0xb6,0xb7,
;658:	0xb8,0xb9,0xba,0xbb,0xbc,0xbd,0xbe,0xbf,
;659:	0xc0,0xc1,0xc2,0xc3,0xc4,0xc5,0xc6,0xc7,
;660:	0xc8,0xc9,0xca,0xcb,0xcc,0xcd,0xce,0xcf,
;661:	0xd0,0xd1,0xd2,0xd3,0xd4,0xd5,0xd6,0xd7,
;662:	0xd8,0xd9,0xda,0xdb,0xdc,0xdd,0xde,0xdf,
;663:	0xe0,0xe1,0xe2,0xe3,0xe4,0xe5,0xe6,0xe7,
;664:	0xe8,0xe9,0xea,0xeb,0xec,0xed,0xee,0xef,
;665:	0xf0,0xf1,0xf2,0xf3,0xf4,0xf5,0xf6,0xf7,
;666:	0xf8,0xf9,0xfa,0xfb,0xfc,0xfd,0xfe,0xff
;667:};
;668:
;669:
;670:int Q_isprint(int c) {
line 671
;671:	if (c >= 0x20 && c <= 0x7E)
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $291
ADDRLP4 0
INDIRI4
CNSTI4 126
GTI4 $291
line 672
;672:		return (1);
CNSTI4 1
RETI4
ADDRGP4 $290
JUMPV
LABELV $291
line 673
;673:	return (0);
CNSTI4 0
RETI4
LABELV $290
endproc Q_isprint 4 0
export Q_islower
proc Q_islower 4 0
line 677
;674:}
;675:
;676:
;677:int Q_islower(int c) {
line 678
;678:	if (c >= 'a' && c <= 'z')
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 97
LTI4 $294
ADDRLP4 0
INDIRI4
CNSTI4 122
GTI4 $294
line 679
;679:		return (1);
CNSTI4 1
RETI4
ADDRGP4 $293
JUMPV
LABELV $294
line 680
;680:	return (0);
CNSTI4 0
RETI4
LABELV $293
endproc Q_islower 4 0
export Q_isupper
proc Q_isupper 4 0
line 684
;681:}
;682:
;683:
;684:int Q_isupper(int c) {
line 685
;685:	if (c >= 'A' && c <= 'Z')
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 65
LTI4 $297
ADDRLP4 0
INDIRI4
CNSTI4 90
GTI4 $297
line 686
;686:		return (1);
CNSTI4 1
RETI4
ADDRGP4 $296
JUMPV
LABELV $297
line 687
;687:	return (0);
CNSTI4 0
RETI4
LABELV $296
endproc Q_isupper 4 0
export Q_isalpha
proc Q_isalpha 8 0
line 691
;688:}
;689:
;690:
;691:int Q_isalpha(int c) {
line 692
;692:	if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z'))
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 97
LTI4 $303
ADDRLP4 0
INDIRI4
CNSTI4 122
LEI4 $302
LABELV $303
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 65
LTI4 $300
ADDRLP4 4
INDIRI4
CNSTI4 90
GTI4 $300
LABELV $302
line 693
;693:		return (1);
CNSTI4 1
RETI4
ADDRGP4 $299
JUMPV
LABELV $300
line 694
;694:	return (0);
CNSTI4 0
RETI4
LABELV $299
endproc Q_isalpha 8 0
export Q_strrchr
proc Q_strrchr 12 0
line 698
;695:}
;696:
;697:
;698:char *Q_strrchr(const char *string, int c) {
line 699
;699:	char cc = c;
ADDRLP4 4
ADDRFP4 4
INDIRI4
CVII1 4
ASGNI1
line 701
;700:	char *s;
;701:	char *sp = (char *)0;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 703
;702:
;703:	s = (char *)string;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $306
JUMPV
LABELV $305
line 705
;704:
;705:	while (*s) {
line 706
;706:		if (*s == cc)
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI1
CVII4 1
NEI4 $308
line 707
;707:			sp = s;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $308
line 708
;708:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 709
;709:	}
LABELV $306
line 705
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $305
line 710
;710:	if (cc == 0)
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $310
line 711
;711:		sp = s;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
LABELV $310
line 713
;712:
;713:	return sp;
ADDRLP4 8
INDIRP4
RETP4
LABELV $304
endproc Q_strrchr 12 0
export Q_strncpyz
proc Q_strncpyz 0 12
line 724
;714:}
;715:
;716:
;717:/*
;718:=============
;719:Q_strncpyz
;720:
;721:Safe strncpy that ensures a trailing zero
;722:=============
;723:*/
;724:void Q_strncpyz(char *dest, const char *src, int destsize) {
line 725
;725:	if (!dest) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $313
line 726
;726:		Com_Error(ERR_FATAL, "Q_strncpyz: NULL dest");
CNSTI4 0
ARGI4
ADDRGP4 $315
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 727
;727:	}
LABELV $313
line 729
;728:
;729:	if (!src) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $316
line 730
;730:		Com_Error(ERR_FATAL, "Q_strncpyz: NULL src");
CNSTI4 0
ARGI4
ADDRGP4 $318
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 731
;731:	}
LABELV $316
line 733
;732:
;733:	if (destsize < 1) {
ADDRFP4 8
INDIRI4
CNSTI4 1
GEI4 $319
line 734
;734:		Com_Error(ERR_FATAL, "Q_strncpyz: destsize < 1");
CNSTI4 0
ARGI4
ADDRGP4 $321
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 735
;735:	}
LABELV $319
line 737
;736:
;737:	strncpy(dest, src, destsize - 1);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 738
;738:	dest[destsize - 1] = '\0';
ADDRFP4 8
INDIRI4
CNSTI4 1
SUBI4
ADDRFP4 0
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 739
;739:}
LABELV $312
endproc Q_strncpyz 0 12
export Q_stricmpn
proc Q_stricmpn 24 0
line 742
;740:
;741:
;742:int Q_stricmpn(const char *s1, const char *s2, int n) {
line 745
;743:	int	c1, c2;
;744:
;745:	if (s1 == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $323
line 746
;746:		if (s2 == NULL)
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $325
line 747
;747:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $322
JUMPV
LABELV $325
line 749
;748:		else
;749:			return -1;
CNSTI4 -1
RETI4
ADDRGP4 $322
JUMPV
LABELV $323
line 750
;750:	} else if (s2 == NULL)
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $327
line 751
;751:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $322
JUMPV
LABELV $327
LABELV $329
line 753
;752:
;753:	do {
line 754
;754:		c1 = *s1; s1++;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 755
;755:		c2 = *s2; s2++;
ADDRLP4 4
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRFP4 4
ADDRFP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 757
;756:
;757:		if (!n--) {
ADDRLP4 8
ADDRFP4 8
INDIRI4
ASGNI4
ADDRFP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $332
line 758
;758:			return 0; // strings are equal until end point
CNSTI4 0
RETI4
ADDRGP4 $322
JUMPV
LABELV $332
line 761
;759:		}
;760:
;761:		if (c1 != c2) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $334
line 762
;762:			if (c1 >= 'a' && c1 <= 'z') {
ADDRLP4 0
INDIRI4
CNSTI4 97
LTI4 $336
ADDRLP4 0
INDIRI4
CNSTI4 122
GTI4 $336
line 763
;763:				c1 -= ('a' - 'A');
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 32
SUBI4
ASGNI4
line 764
;764:			}
LABELV $336
line 765
;765:			if (c2 >= 'a' && c2 <= 'z') {
ADDRLP4 4
INDIRI4
CNSTI4 97
LTI4 $338
ADDRLP4 4
INDIRI4
CNSTI4 122
GTI4 $338
line 766
;766:				c2 -= ('a' - 'A');
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 32
SUBI4
ASGNI4
line 767
;767:			}
LABELV $338
line 768
;768:			if (c1 != c2) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $340
line 769
;769:				return c1 < c2 ? -1 : 1;
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
GEI4 $343
ADDRLP4 20
CNSTI4 -1
ASGNI4
ADDRGP4 $344
JUMPV
LABELV $343
ADDRLP4 20
CNSTI4 1
ASGNI4
LABELV $344
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $322
JUMPV
LABELV $340
line 771
;770:			}
;771:		}
LABELV $334
line 772
;772:	} while (c1);
LABELV $330
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $329
line 774
;773:
;774:	return 0;		// strings are equal
CNSTI4 0
RETI4
LABELV $322
endproc Q_stricmpn 24 0
export Q_strncmp
proc Q_strncmp 16 0
line 778
;775:}
;776:
;777:
;778:int Q_strncmp(const char *s1, const char *s2, int n) {
LABELV $346
line 781
;779:	int		c1, c2;
;780:
;781:	do {
line 782
;782:		c1 = *s1; s1++;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 783
;783:		c2 = *s2; s2++;
ADDRLP4 4
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRFP4 4
ADDRFP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 785
;784:
;785:		if (!n--) {
ADDRLP4 8
ADDRFP4 8
INDIRI4
ASGNI4
ADDRFP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $349
line 786
;786:			return 0;		// strings are equal until end point
CNSTI4 0
RETI4
ADDRGP4 $345
JUMPV
LABELV $349
line 789
;787:		}
;788:
;789:		if (c1 != c2) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $351
line 790
;790:			return c1 < c2 ? -1 : 1;
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
GEI4 $354
ADDRLP4 12
CNSTI4 -1
ASGNI4
ADDRGP4 $355
JUMPV
LABELV $354
ADDRLP4 12
CNSTI4 1
ASGNI4
LABELV $355
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $345
JUMPV
LABELV $351
line 792
;791:		}
;792:	} while (c1);
LABELV $347
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $346
line 794
;793:
;794:	return 0;		// strings are equal
CNSTI4 0
RETI4
LABELV $345
endproc Q_strncmp 16 0
export Q_stricmp
proc Q_stricmp 16 0
line 798
;795:}
;796:
;797:
;798:int Q_stricmp(const char *s1, const char *s2) {
line 801
;799:	unsigned char c1, c2;
;800:
;801:	if (s1 == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $357
line 802
;802:		if (s2 == NULL)
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $359
line 803
;803:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $356
JUMPV
LABELV $359
line 805
;804:		else
;805:			return -1;
CNSTI4 -1
RETI4
ADDRGP4 $356
JUMPV
LABELV $357
line 806
;806:	} else if (s2 == NULL)
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $361
line 807
;807:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $356
JUMPV
LABELV $361
LABELV $363
line 809
;808:
;809:	do {
line 810
;810:		c1 = *s1; s1++;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CVIU4 4
CVUU1 4
ASGNU1
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 811
;811:		c2 = *s2; s2++;
ADDRLP4 1
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
CVIU4 4
CVUU1 4
ASGNU1
ADDRFP4 4
ADDRFP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 813
;812:
;813:		if (c1 != c2) {
ADDRLP4 0
INDIRU1
CVUI4 1
ADDRLP4 1
INDIRU1
CVUI4 1
EQI4 $366
line 814
;814:			if (c1 <= 'Z' && c1 >= 'A')
ADDRLP4 4
ADDRLP4 0
INDIRU1
CVUI4 1
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 90
GTI4 $368
ADDRLP4 4
INDIRI4
CNSTI4 65
LTI4 $368
line 815
;815:				c1 += ('a' - 'A');
ADDRLP4 0
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 32
ADDI4
CVIU4 4
CVUU1 4
ASGNU1
LABELV $368
line 817
;816:
;817:			if (c2 <= 'Z' && c2 >= 'A')
ADDRLP4 8
ADDRLP4 1
INDIRU1
CVUI4 1
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 90
GTI4 $370
ADDRLP4 8
INDIRI4
CNSTI4 65
LTI4 $370
line 818
;818:				c2 += ('a' - 'A');
ADDRLP4 1
ADDRLP4 1
INDIRU1
CVUI4 1
CNSTI4 32
ADDI4
CVIU4 4
CVUU1 4
ASGNU1
LABELV $370
line 820
;819:
;820:			if (c1 != c2)
ADDRLP4 0
INDIRU1
CVUI4 1
ADDRLP4 1
INDIRU1
CVUI4 1
EQI4 $372
line 821
;821:				return c1 < c2 ? -1 : 1;
ADDRLP4 0
INDIRU1
CVUI4 1
ADDRLP4 1
INDIRU1
CVUI4 1
GEI4 $375
ADDRLP4 12
CNSTI4 -1
ASGNI4
ADDRGP4 $376
JUMPV
LABELV $375
ADDRLP4 12
CNSTI4 1
ASGNI4
LABELV $376
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $356
JUMPV
LABELV $372
line 822
;822:		}
LABELV $366
line 823
;823:	} while (c1 != '\0');
LABELV $364
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 0
NEI4 $363
line 825
;824:
;825:	return 0;
CNSTI4 0
RETI4
LABELV $356
endproc Q_stricmp 16 0
export Q_strlwr
proc Q_strlwr 12 4
line 829
;826:}
;827:
;828:
;829:char *Q_strlwr(char *s1) {
line 832
;830:	char *s;
;831:
;832:	s = s1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $379
JUMPV
LABELV $378
line 833
;833:	while (*s) {
line 834
;834:		*s = tolower(*s);
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 tolower
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
CVII1 4
ASGNI1
line 835
;835:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 836
;836:	}
LABELV $379
line 833
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $378
line 837
;837:	return s1;
ADDRFP4 0
INDIRP4
RETP4
LABELV $377
endproc Q_strlwr 12 4
export Q_strupr
proc Q_strupr 12 4
line 841
;838:}
;839:
;840:
;841:char *Q_strupr(char *s1) {
line 844
;842:	char *s;
;843:
;844:	s = s1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $383
JUMPV
LABELV $382
line 845
;845:	while (*s) {
line 846
;846:		*s = toupper(*s);
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
CVII1 4
ASGNI1
line 847
;847:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 848
;848:	}
LABELV $383
line 845
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $382
line 849
;849:	return s1;
ADDRFP4 0
INDIRP4
RETP4
LABELV $381
endproc Q_strupr 12 4
export Q_strcat
proc Q_strcat 12 12
line 854
;850:}
;851:
;852:
;853:// never goes past bounds or leaves without a terminating 0
;854:void Q_strcat(char *dest, int size, const char *src) {
line 857
;855:	int		l1;
;856:
;857:	l1 = strlen(dest);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 858
;858:	if (l1 >= size) {
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $386
line 859
;859:		Com_Error(ERR_FATAL, "Q_strcat: already overflowed");
CNSTI4 0
ARGI4
ADDRGP4 $388
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 860
;860:	}
LABELV $386
line 861
;861:	Q_strncpyz(dest + l1, src, size - l1);
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 862
;862:}
LABELV $385
endproc Q_strcat 12 12
export Q_PrintStrlen
proc Q_PrintStrlen 12 0
line 865
;863:
;864:
;865:int Q_PrintStrlen(const char *string) {
line 869
;866:	int			len;
;867:	const char *p;
;868:
;869:	if (!string) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $390
line 870
;870:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $389
JUMPV
LABELV $390
line 873
;871:	}
;872:
;873:	len = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 874
;874:	p = string;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $393
JUMPV
LABELV $392
line 875
;875:	while (*p) {
line 876
;876:		if (Q_IsColorString(p)) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $395
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $395
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $395
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $395
line 877
;877:			p += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 878
;878:			continue;
ADDRGP4 $393
JUMPV
LABELV $395
line 880
;879:		}
;880:		p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 881
;881:		len++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 882
;882:	}
LABELV $393
line 875
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $392
line 884
;883:
;884:	return len;
ADDRLP4 4
INDIRI4
RETI4
LABELV $389
endproc Q_PrintStrlen 12 0
export Q_CleanStr
proc Q_CleanStr 20 0
line 888
;885:}
;886:
;887:
;888:char *Q_CleanStr(char *string) {
line 893
;889:	char *d;
;890:	char *s;
;891:	int		c;
;892:
;893:	s = string;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 894
;894:	d = string;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $399
JUMPV
LABELV $398
line 895
;895:	while ((c = *s) != '\0') {
line 896
;896:		if (Q_IsColorString(s)) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $401
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $401
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $401
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $401
line 897
;897:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 898
;898:		} else if (c >= ' ' && c <= '~') {
ADDRGP4 $402
JUMPV
LABELV $401
ADDRLP4 4
INDIRI4
CNSTI4 32
LTI4 $403
ADDRLP4 4
INDIRI4
CNSTI4 126
GTI4 $403
line 899
;899:			*d = c; d++;
ADDRLP4 8
INDIRP4
ADDRLP4 4
INDIRI4
CVII1 4
ASGNI1
ADDRLP4 8
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 900
;900:		}
LABELV $403
LABELV $402
line 901
;901:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 902
;902:	}
LABELV $399
line 895
ADDRLP4 12
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $398
line 903
;903:	*d = '\0';
ADDRLP4 8
INDIRP4
CNSTI1 0
ASGNI1
line 905
;904:
;905:	return string;
ADDRFP4 0
INDIRP4
RETP4
LABELV $397
endproc Q_CleanStr 20 0
export Com_sprintf
proc Com_sprintf 12 16
line 909
;906:}
;907:
;908:
;909:int QDECL Com_sprintf(char *dest, int size, const char *fmt, ...) {
line 913
;910:	va_list argptr;
;911:	int len;
;912:
;913:	va_start(argptr, fmt);
ADDRLP4 4
ADDRFP4 8+4
ASGNP4
line 914
;914:	len = ED_vsprintf(dest, fmt, argptr);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 ED_vsprintf
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 915
;915:	va_end(argptr);
ADDRLP4 4
CNSTP4 0
ASGNP4
line 917
;916:
;917:	if (len >= size) {
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $407
line 918
;918:		Com_Error(ERR_FATAL, "Com_sprintf: overflow of %i in %i\n", len, size);
CNSTI4 0
ARGI4
ADDRGP4 $409
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 Com_Error
CALLV
pop
line 919
;919:	}
LABELV $407
line 921
;920:
;921:	return len;
ADDRLP4 0
INDIRI4
RETI4
LABELV $405
endproc Com_sprintf 12 16
bss
align 1
LABELV $411
skip 64000
data
align 4
LABELV $412
byte 4 0
export va
code
proc va 12 12
line 934
;922:}
;923:
;924:
;925:/*
;926:============
;927:va
;928:
;929:does a varargs printf into a temp buffer, so I don't need to have
;930:varargs versions of all text functions.
;931:FIXME: make this buffer size safe someday
;932:============
;933:*/
;934:char *QDECL va(const char *format, ...) {
line 940
;935:	va_list		argptr;
;936:	static char		string[2][32000];	// in case va is called by nested functions
;937:	static int		index = 0;
;938:	char *buf;
;939:
;940:	buf = string[index];
ADDRLP4 4
ADDRGP4 $412
INDIRI4
CNSTI4 32000
MULI4
ADDRGP4 $411
ADDP4
ASGNP4
line 941
;941:	index ^= 1;
ADDRLP4 8
ADDRGP4 $412
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 943
;942:
;943:	va_start(argptr, format);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 944
;944:	ED_vsprintf(buf, format, argptr);
ADDRLP4 4
INDIRP4
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
line 945
;945:	va_end(argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 947
;946:
;947:	return buf;
ADDRLP4 4
INDIRP4
RETP4
LABELV $410
endproc va 12 12
proc Q_strkey 12 0
line 960
;948:}
;949:
;950:
;951:/*
;952:=====================================================================
;953:
;954:  INFO STRINGS
;955:
;956:=====================================================================
;957:*/
;958:
;959:
;960:static qboolean Q_strkey(const char *str, const char *key, int key_len) {
line 963
;961:	int i;
;962:
;963:	for (i = 0; i < key_len; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $418
JUMPV
LABELV $415
line 964
;964:		if (locase[(byte)str[i]] != locase[(byte)key[i]]) {
ADDRLP4 8
ADDRGP4 locase
ASGNP4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CVIU4 4
CVUU1 4
CVUI4 1
ADDRLP4 8
INDIRP4
ADDP4
INDIRU1
CVUI4 1
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CVIU4 4
CVUU1 4
CVUI4 1
ADDRLP4 8
INDIRP4
ADDP4
INDIRU1
CVUI4 1
EQI4 $419
line 965
;965:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $414
JUMPV
LABELV $419
line 967
;966:		}
;967:	}
LABELV $416
line 963
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $418
ADDRLP4 0
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $415
line 969
;968:
;969:	return qtrue;
CNSTI4 1
RETI4
LABELV $414
endproc Q_strkey 12 0
bss
align 1
LABELV $422
skip 16384
data
align 4
LABELV $423
byte 4 0
export Info_ValueForKey
code
proc Info_ValueForKey 52 12
line 981
;970:}
;971:
;972:
;973:/*
;974:===============
;975:Info_ValueForKey
;976:
;977:Searches the string for the given
;978:key and returns the associated value, or an empty string.
;979:===============
;980:*/
;981:char *Info_ValueForKey(const char *s, const char *key) {
line 989
;982:	static	char value[2][BIG_INFO_VALUE];	// use two buffers so compares
;983:	// work without stomping on each other
;984:	static	int	valueindex = 0;
;985:	const char *v, *pkey;
;986:	char *o, *o2;
;987:	int		klen, len;
;988:
;989:	if (!s || !key || !*key)
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $427
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $427
ADDRLP4 24
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $424
LABELV $427
line 990
;990:		return "";
ADDRGP4 $428
RETP4
ADDRGP4 $421
JUMPV
LABELV $424
line 992
;991:
;992:	klen = (int)strlen(key);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 28
INDIRI4
ASGNI4
line 994
;993:
;994:	if (*s == '\\')
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $432
line 995
;995:		s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRGP4 $432
JUMPV
LABELV $431
line 997
;996:
;997:	while (1) {
line 998
;998:		pkey = s;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $435
JUMPV
LABELV $434
line 999
;999:		while (*s != '\\') {
line 1000
;1000:			if (*s == '\0')
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $437
line 1001
;1001:				return "";
ADDRGP4 $428
RETP4
ADDRGP4 $421
JUMPV
LABELV $437
line 1002
;1002:			++s;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1003
;1003:		}
LABELV $435
line 999
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $434
line 1004
;1004:		len = (int)(s - pkey);
ADDRLP4 16
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 1005
;1005:		s++; // skip '\\'
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1007
;1006:
;1007:		v = s;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $440
JUMPV
LABELV $439
line 1009
;1008:		while (*s != '\\' && *s != '\0')
;1009:			s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $440
line 1008
ADDRLP4 32
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 92
EQI4 $442
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $439
LABELV $442
line 1011
;1010:
;1011:		if (len == klen && Q_strkey(pkey, key, klen)) {
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $443
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 Q_strkey
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $443
line 1012
;1012:			o = o2 = value[valueindex];
ADDRLP4 44
ADDRGP4 $423
INDIRI4
CNSTI4 13
LSHI4
ADDRGP4 $422
ADDP4
ASGNP4
ADDRLP4 20
ADDRLP4 44
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 44
INDIRP4
ASGNP4
line 1013
;1013:			valueindex ^= 1;
ADDRLP4 48
ADDRGP4 $423
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 1014
;1014:			if ((int)(s - v) >= BIG_INFO_STRING) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 8192
LTI4 $449
line 1015
;1015:				Com_Error(ERR_DROP, "Info_ValueForKey: oversize infostring value");
CNSTI4 1
ARGI4
ADDRGP4 $447
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 1016
;1016:			} else {
ADDRGP4 $446
JUMPV
LABELV $448
line 1017
;1017:				while (v < s) {
line 1018
;1018:					*o = *v;
ADDRLP4 4
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI1
ASGNI1
line 1019
;1019:					++o; ++v;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1020
;1020:				}
LABELV $449
line 1017
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
LTU4 $448
line 1021
;1021:			}
LABELV $446
line 1022
;1022:			*o = '\0';
ADDRLP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 1023
;1023:			return o2;
ADDRLP4 20
INDIRP4
RETP4
ADDRGP4 $421
JUMPV
LABELV $443
line 1026
;1024:		}
;1025:
;1026:		if (*s == '\0')
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $451
line 1027
;1027:			break;
ADDRGP4 $433
JUMPV
LABELV $451
line 1029
;1028:
;1029:		s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1030
;1030:	}
LABELV $432
line 997
ADDRGP4 $431
JUMPV
LABELV $433
line 1032
;1031:
;1032:	return "";
ADDRGP4 $428
RETP4
LABELV $421
endproc Info_ValueForKey 52 12
export Info_NextPair
proc Info_NextPair 12 0
line 1043
;1033:}
;1034:
;1035:
;1036:/*
;1037:===================
;1038:Info_NextPair
;1039:
;1040:Used to itterate through all the key/value pairs in an info string
;1041:===================
;1042:*/
;1043:const char *Info_NextPair(const char *s, char *key, char *value) {
line 1046
;1044:	char *o;
;1045:
;1046:	if (*s == '\\') {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $454
line 1047
;1047:		s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1048
;1048:	}
LABELV $454
line 1050
;1049:
;1050:	key[0] = '\0';
ADDRFP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 1051
;1051:	value[0] = '\0';
ADDRFP4 8
INDIRP4
CNSTI1 0
ASGNI1
line 1053
;1052:
;1053:	o = key;
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRGP4 $457
JUMPV
LABELV $456
line 1054
;1054:	while (*s != '\\') {
line 1055
;1055:		if (*s == '\0') {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $459
line 1056
;1056:			*o = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1057
;1057:			return s;
ADDRFP4 0
INDIRP4
RETP4
ADDRGP4 $453
JUMPV
LABELV $459
line 1059
;1058:		}
;1059:		*o++ = *s++;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI1
ASGNI1
line 1060
;1060:	}
LABELV $457
line 1054
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $456
line 1061
;1061:	*o = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1062
;1062:	s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1064
;1063:
;1064:	o = value;
ADDRLP4 0
ADDRFP4 8
INDIRP4
ASGNP4
ADDRGP4 $462
JUMPV
LABELV $461
line 1065
;1065:	while (*s != '\\' && *s != '\0') {
line 1066
;1066:		*o++ = *s++;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 0
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI1
ASGNI1
line 1067
;1067:	}
LABELV $462
line 1065
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 92
EQI4 $464
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $461
LABELV $464
line 1068
;1068:	*o = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 1070
;1069:
;1070:	return s;
ADDRFP4 0
INDIRP4
RETP4
LABELV $453
endproc Info_NextPair 12 0
proc Info_RemoveKey 36 12
line 1079
;1071:}
;1072:
;1073:
;1074:/*
;1075:===================
;1076:Info_RemoveKey
;1077:===================
;1078:*/
;1079:static int Info_RemoveKey(char *s, const char *key) {
line 1084
;1080:	char *start;
;1081:	char *pkey;
;1082:	int		key_len, len;
;1083:
;1084:	key_len = (int)strlen(key);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
ADDRGP4 $467
JUMPV
LABELV $466
line 1086
;1085:
;1086:	while (1) {
line 1087
;1087:		start = s;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 1088
;1088:		if (*s == '\\')
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $469
line 1089
;1089:			s++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $469
line 1090
;1090:		pkey = s;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $472
JUMPV
LABELV $471
line 1091
;1091:		while (*s != '\\') {
line 1092
;1092:			if (*s == '\0')
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $474
line 1093
;1093:				return 0;
CNSTI4 0
RETI4
ADDRGP4 $465
JUMPV
LABELV $474
line 1094
;1094:			++s;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1095
;1095:		}
LABELV $472
line 1091
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $471
line 1097
;1096:
;1097:		len = (int)(s - pkey);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 1098
;1098:		++s; // skip '\\'
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRGP4 $477
JUMPV
LABELV $476
line 1101
;1099:
;1100:		while (*s != '\\' && *s != '\0')
;1101:			++s;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $477
line 1100
ADDRLP4 20
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 92
EQI4 $479
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $476
LABELV $479
line 1103
;1102:
;1103:		if (len == key_len && Q_strkey(pkey, key, key_len)) {
ADDRLP4 12
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $480
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 Q_strkey
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $480
line 1104
;1104:			memmove(start, s, strlen(s) + 1); // remove this part
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 1105
;1105:			return (int)(s - start);
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
RETI4
ADDRGP4 $465
JUMPV
LABELV $480
line 1108
;1106:		}
;1107:
;1108:		if (*s == '\0')
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $482
line 1109
;1109:			break;
ADDRGP4 $468
JUMPV
LABELV $482
line 1110
;1110:	}
LABELV $467
line 1086
ADDRGP4 $466
JUMPV
LABELV $468
line 1112
;1111:
;1112:	return 0;
CNSTI4 0
RETI4
LABELV $465
endproc Info_RemoveKey 36 12
export Info_Validate
proc Info_Validate 8 0
line 1124
;1113:}
;1114:
;1115:
;1116:/*
;1117:==================
;1118:Info_ValidateKeyValue
;1119:
;1120:Some characters are illegal in info strings because they
;1121:can mess up the server's parsing
;1122:==================
;1123:*/
;1124:qboolean Info_Validate(const char *s) {
line 1125
;1125:	for (;; ) {
LABELV $485
line 1126
;1126:		switch (*s) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 34
EQI4 $493
ADDRLP4 0
INDIRI4
CNSTI4 34
GTI4 $495
LABELV $494
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $492
ADDRGP4 $489
JUMPV
LABELV $495
ADDRLP4 0
INDIRI4
CNSTI4 59
EQI4 $493
ADDRGP4 $489
JUMPV
LABELV $492
line 1128
;1127:		case '\0':
;1128:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $484
JUMPV
LABELV $493
line 1131
;1129:		case '\"':
;1130:		case ';':
;1131:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $484
JUMPV
LABELV $489
line 1133
;1132:		default:
;1133:			++s;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1134
;1134:			continue;
line 1125
ADDRGP4 $485
JUMPV
LABELV $484
endproc Info_Validate 8 0
export Info_ValidateKeyValue
proc Info_ValidateKeyValue 12 0
line 1145
;1135:		}
;1136:	}
;1137:}
;1138:
;1139:
;1140:/*
;1141:==================
;1142:Info_ValidateKeyValue
;1143:==================
;1144:*/
;1145:qboolean Info_ValidateKeyValue(const char *s) {
line 1146
;1146:	for (;; ) {
LABELV $497
line 1147
;1147:		switch (*s) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 34
EQI4 $505
ADDRLP4 0
INDIRI4
CNSTI4 34
GTI4 $507
LABELV $506
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $504
ADDRGP4 $501
JUMPV
LABELV $507
ADDRLP4 0
INDIRI4
CNSTI4 59
EQI4 $505
ADDRLP4 0
INDIRI4
CNSTI4 59
LTI4 $501
LABELV $508
ADDRLP4 0
INDIRI4
CNSTI4 92
EQI4 $505
ADDRGP4 $501
JUMPV
LABELV $504
line 1149
;1148:		case '\0':
;1149:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $496
JUMPV
LABELV $505
line 1153
;1150:		case '\\':
;1151:		case '\"':
;1152:		case ';':
;1153:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $496
JUMPV
LABELV $501
line 1155
;1154:		default:
;1155:			++s;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1156
;1156:			continue;
line 1146
ADDRGP4 $497
JUMPV
LABELV $496
endproc Info_ValidateKeyValue 12 0
export Info_SetValueForKey
proc Info_SetValueForKey 1060 20
line 1169
;1157:		}
;1158:	}
;1159:}
;1160:
;1161:
;1162:/*
;1163:==================
;1164:Info_SetValueForKey
;1165:
;1166:Changes or adds a key/value pair
;1167:==================
;1168:*/
;1169:qboolean Info_SetValueForKey(char *s, const char *key, const char *value) {
line 1173
;1170:	char	newi[MAX_INFO_STRING + 2];
;1171:	int		len1, len2;
;1172:
;1173:	len1 = (int)strlen(s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 1036
INDIRI4
ASGNI4
line 1174
;1174:	if (len1 >= MAX_INFO_STRING) {
ADDRLP4 0
INDIRI4
CNSTI4 1024
LTI4 $510
line 1175
;1175:		Com_Error(ERR_DROP, "Info_SetValueForKey: oversize infostring");
CNSTI4 1
ARGI4
ADDRGP4 $512
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 1176
;1176:	}
LABELV $510
line 1178
;1177:
;1178:	if (!Info_ValidateKeyValue(key) || *key == '\0') {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 Info_ValidateKeyValue
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
EQI4 $515
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $513
LABELV $515
line 1179
;1179:		Com_Printf(S_COLOR_YELLOW "Invalid key name: '%s'\n", key);
ADDRGP4 $516
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1180
;1180:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $509
JUMPV
LABELV $513
line 1183
;1181:	}
;1182:
;1183:	if (!Info_ValidateKeyValue(value)) {
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 1044
ADDRGP4 Info_ValidateKeyValue
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $517
line 1184
;1184:		Com_Printf(S_COLOR_YELLOW "Invalid value name: '%s'\n", value);
ADDRGP4 $519
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1185
;1185:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $509
JUMPV
LABELV $517
line 1188
;1186:	}
;1187:
;1188:	len1 -= Info_RemoveKey(s, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1048
ADDRGP4 Info_RemoveKey
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 1048
INDIRI4
SUBI4
ASGNI4
line 1189
;1189:	if (!value || !*value)
ADDRLP4 1052
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 1052
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $522
ADDRLP4 1052
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $520
LABELV $522
line 1190
;1190:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $509
JUMPV
LABELV $520
line 1192
;1191:
;1192:	len2 = Com_sprintf(newi, sizeof(newi), "\\%s\\%s", key, value);
ADDRLP4 4
ARGP4
CNSTI4 1026
ARGI4
ADDRGP4 $523
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 1056
ADDRGP4 Com_sprintf
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1056
INDIRI4
ASGNI4
line 1194
;1193:
;1194:	if (len1 + len2 >= MAX_INFO_STRING) {
ADDRLP4 0
INDIRI4
ADDRLP4 1032
INDIRI4
ADDI4
CNSTI4 1024
LTI4 $524
line 1195
;1195:		Com_Printf(S_COLOR_YELLOW "Info string length exceeded\n");
ADDRGP4 $526
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1196
;1196:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $509
JUMPV
LABELV $524
line 1199
;1197:	}
;1198:
;1199:	strcpy(s + len1, newi);
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1200
;1200:	return qtrue;
CNSTI4 1
RETI4
LABELV $509
endproc Info_SetValueForKey 1060 20
export Info_SetValueForKey_Big
proc Info_SetValueForKey_Big 8228 20
line 1211
;1201:}
;1202:
;1203:
;1204:/*
;1205:==================
;1206:Info_SetValueForKey_Big
;1207:
;1208:Changes or adds a key/value pair
;1209:==================
;1210:*/
;1211:qboolean Info_SetValueForKey_Big(char *s, const char *key, const char *value) {
line 1215
;1212:	char	newi[BIG_INFO_STRING + 2];
;1213:	int		len1, len2;
;1214:
;1215:	len1 = (int)strlen(s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8204
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8204
INDIRI4
ASGNI4
line 1216
;1216:	if (len1 >= BIG_INFO_STRING) {
ADDRLP4 0
INDIRI4
CNSTI4 8192
LTI4 $528
line 1217
;1217:		Com_Error(ERR_DROP, "Info_SetValueForKey: oversize infostring");
CNSTI4 1
ARGI4
ADDRGP4 $512
ARGP4
ADDRGP4 Com_Error
CALLV
pop
line 1218
;1218:	}
LABELV $528
line 1220
;1219:
;1220:	if (!Info_ValidateKeyValue(key) || *key == '\0') {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8208
ADDRGP4 Info_ValidateKeyValue
CALLI4
ASGNI4
ADDRLP4 8208
INDIRI4
CNSTI4 0
EQI4 $532
ADDRFP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $530
LABELV $532
line 1221
;1221:		Com_Printf(S_COLOR_YELLOW "Invalid key name: '%s'\n", key);
ADDRGP4 $516
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1222
;1222:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $527
JUMPV
LABELV $530
line 1225
;1223:	}
;1224:
;1225:	if (!Info_ValidateKeyValue(value)) {
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8212
ADDRGP4 Info_ValidateKeyValue
CALLI4
ASGNI4
ADDRLP4 8212
INDIRI4
CNSTI4 0
NEI4 $533
line 1226
;1226:		Com_Printf(S_COLOR_YELLOW "Invalid value name: '%s'\n", value);
ADDRGP4 $519
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1227
;1227:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $527
JUMPV
LABELV $533
line 1230
;1228:	}
;1229:
;1230:	len1 -= Info_RemoveKey(s, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8216
ADDRGP4 Info_RemoveKey
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 8216
INDIRI4
SUBI4
ASGNI4
line 1231
;1231:	if (!value || !*value)
ADDRLP4 8220
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 8220
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $537
ADDRLP4 8220
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $535
LABELV $537
line 1232
;1232:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $527
JUMPV
LABELV $535
line 1234
;1233:
;1234:	len2 = Com_sprintf(newi, sizeof(newi), "\\%s\\%s", key, value);
ADDRLP4 4
ARGP4
CNSTI4 8194
ARGI4
ADDRGP4 $523
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8224
ADDRGP4 Com_sprintf
CALLI4
ASGNI4
ADDRLP4 8200
ADDRLP4 8224
INDIRI4
ASGNI4
line 1236
;1235:
;1236:	if (len1 + len2 >= BIG_INFO_STRING) {
ADDRLP4 0
INDIRI4
ADDRLP4 8200
INDIRI4
ADDI4
CNSTI4 8192
LTI4 $538
line 1237
;1237:		Com_Printf(S_COLOR_YELLOW "BIG Info string length exceeded\n");
ADDRGP4 $540
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1238
;1238:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $527
JUMPV
LABELV $538
line 1241
;1239:	}
;1240:
;1241:	strcpy(s + len1, newi);
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1242
;1242:	return qtrue;
CNSTI4 1
RETI4
LABELV $527
endproc Info_SetValueForKey_Big 8228 20
bss
align 4
LABELV is_separator
skip 1024
align 4
LABELV com_tokenline
skip 4
align 4
LABELV com_lines
skip 4
align 1
LABELV com_parsename
skip 1024
align 1
LABELV com_token
skip 1024
import Com_Printf
import Com_Error
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
LABELV $540
byte 1 94
byte 1 51
byte 1 66
byte 1 73
byte 1 71
byte 1 32
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
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
LABELV $526
byte 1 94
byte 1 51
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
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
LABELV $523
byte 1 92
byte 1 37
byte 1 115
byte 1 92
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $519
byte 1 94
byte 1 51
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $516
byte 1 94
byte 1 51
byte 1 73
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $512
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 83
byte 1 101
byte 1 116
byte 1 86
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 70
byte 1 111
byte 1 114
byte 1 75
byte 1 101
byte 1 121
byte 1 58
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $447
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 86
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 70
byte 1 111
byte 1 114
byte 1 75
byte 1 101
byte 1 121
byte 1 58
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $428
byte 1 0
align 1
LABELV $409
byte 1 67
byte 1 111
byte 1 109
byte 1 95
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 102
byte 1 58
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $388
byte 1 81
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 99
byte 1 97
byte 1 116
byte 1 58
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $321
byte 1 81
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 110
byte 1 99
byte 1 112
byte 1 121
byte 1 122
byte 1 58
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 32
byte 1 60
byte 1 32
byte 1 49
byte 1 0
align 1
LABELV $318
byte 1 81
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 110
byte 1 99
byte 1 112
byte 1 121
byte 1 122
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 115
byte 1 114
byte 1 99
byte 1 0
align 1
LABELV $315
byte 1 81
byte 1 95
byte 1 115
byte 1 116
byte 1 114
byte 1 110
byte 1 99
byte 1 112
byte 1 121
byte 1 122
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $279
byte 1 41
byte 1 0
align 1
LABELV $274
byte 1 40
byte 1 0
align 1
LABELV $158
byte 1 77
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 84
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 33
byte 1 61
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $62
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 108
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $58
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 44
byte 1 32
byte 1 108
byte 1 105
byte 1 110
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $50
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $48
byte 1 37
byte 1 115
byte 1 37
byte 1 115
byte 1 0

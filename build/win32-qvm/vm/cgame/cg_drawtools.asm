export CG_AdjustFrom640
code
proc CG_AdjustFrom640 16 0
file "..\..\..\..\code\cgame\cg_drawtools.c"
line 13
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_drawtools.c -- helper functions called by cg_draw, cg_scoreboard, cg_info, etc
;4:#include "cg_local.h"
;5:
;6:/*
;7:================
;8:CG_AdjustFrom640
;9:
;10:Adjusted for resolution and screen aspect ratio
;11:================
;12:*/
;13:void CG_AdjustFrom640(float *x, float *y, float *w, float *h) {
line 15
;14:	// scale for screen sizes
;15:	*x = *x * cgs.screenXScale + cgs.screenXBias;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDRGP4 cgs+31444
INDIRF4
ADDF4
ASGNF4
line 16
;16:	*y = *y * cgs.screenYScale + cgs.screenYBias;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 cgs+31436
INDIRF4
MULF4
ADDRGP4 cgs+31448
INDIRF4
ADDF4
ASGNF4
line 17
;17:	*w *= cgs.screenXScale;
ADDRLP4 8
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 18
;18:	*h *= cgs.screenYScale;
ADDRLP4 12
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRGP4 cgs+31436
INDIRF4
MULF4
ASGNF4
line 19
;19:}
LABELV $81
endproc CG_AdjustFrom640 16 0
export CG_FillRect
proc CG_FillRect 0 36
line 29
;20:
;21:
;22:/*
;23:================
;24:CG_FillRect
;25:
;26:Coordinates are SCREEN_WIDTH*SCREEN_HEIGHT virtual values
;27:=================
;28:*/
;29:void CG_FillRect(float x, float y, float w, float h, const vec4_t color, int widescreen) { //, rectDef_t menuRect) {
line 30
;30:	trap_R_SetColor(color);
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 32
;31:
;32:	CG_AdjustFrom640(&x, &y, &w, &h);
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 33
;33:	trap_R_DrawStretchPic(x, y, w, h, 0, 0, 0, 0, cgs.media.whiteShader);
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
ADDRGP4 cgs+146664+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 35
;34:
;35:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 36
;36:}
LABELV $88
endproc CG_FillRect 0 36
export CG_FillScreen
proc CG_FillScreen 0 36
line 44
;37:
;38:
;39:/*
;40:================
;41:CG_FillScreen
;42:================
;43:*/
;44:void CG_FillScreen(const float *color) {
line 45
;45:	trap_R_SetColor(color);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 46
;46:	trap_R_DrawStretchPic(0, 0, cgs.glconfig.vidWidth, cgs.glconfig.vidHeight, 0, 0, 0, 0, cgs.media.whiteShader);
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 cgs+20100+11304
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+20100+11308
INDIRI4
CVIF4 4
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
ADDRGP4 cgs+146664+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 47
;47:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 48
;48:}
LABELV $91
endproc CG_FillScreen 0 36
export CG_DrawSides
proc CG_DrawSides 4 36
line 58
;49:
;50:
;51:/*
;52:================
;53:CG_DrawSides
;54:
;55:Coords are virtual 640x480
;56:================
;57:*/
;58:void CG_DrawSides(float x, float y, float w, float h, float size, int widescreen) { //, rectDef_t menuRect) {
line 59
;59:	CG_AdjustFrom640(&x, &y, &w, &h);
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 60
;60:	size *= cgs.screenXScale;
ADDRFP4 16
ADDRFP4 16
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 61
;61:	trap_R_DrawStretchPic(x, y, size, h, 0, 0, 0, 0, cgs.media.whiteShader);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 16
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
ADDRGP4 cgs+146664+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 62
;62:	trap_R_DrawStretchPic(x + w - size, y, size, h, 0, 0, 0, 0, cgs.media.whiteShader);
ADDRLP4 0
ADDRFP4 16
INDIRF4
ASGNF4
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 0
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
ADDRGP4 cgs+146664+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 63
;63:}
LABELV $98
endproc CG_DrawSides 4 36
export CG_DrawTopBottom
proc CG_DrawTopBottom 4 36
line 66
;64:
;65:
;66:void CG_DrawTopBottom(float x, float y, float w, float h, float size, int widescreen) { //, rectDef_t menuRect) {
line 67
;67:	CG_AdjustFrom640(&x, &y, &w, &h);
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 68
;68:	size *= cgs.screenYScale;
ADDRFP4 16
ADDRFP4 16
INDIRF4
ADDRGP4 cgs+31436
INDIRF4
MULF4
ASGNF4
line 69
;69:	trap_R_DrawStretchPic(x, y, w, size, 0, 0, 0, 0, cgs.media.whiteShader);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 16
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
ADDRGP4 cgs+146664+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 70
;70:	trap_R_DrawStretchPic(x, y + h - size, w, size, 0, 0, 0, 0, cgs.media.whiteShader);
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 0
ADDRFP4 16
INDIRF4
ASGNF4
ADDRFP4 4
INDIRF4
ADDRFP4 12
INDIRF4
ADDF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 0
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
ADDRGP4 cgs+146664+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 71
;71:}
LABELV $104
endproc CG_DrawTopBottom 4 36
export CG_DrawRect
proc CG_DrawRect 0 24
line 81
;72:
;73:
;74:/*
;75:================
;76:UI_DrawRect
;77:
;78:Coordinates are SCREEN_WIDTH*SCREEN_HEIGHT virtual values
;79:=================
;80:*/
;81:void CG_DrawRect(float x, float y, float w, float h, float size, const vec4_t color, int widescreen) { //, rectDef_t menuRect) {
line 82
;82:	trap_R_SetColor(color);
ADDRFP4 20
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 84
;83:
;84:	CG_DrawTopBottom(x, y, w, h, size, widescreen); //, menuRect);
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
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 CG_DrawTopBottom
CALLV
pop
line 85
;85:	CG_DrawSides(x, y, w, h, size, widescreen); //, menuRect);
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
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 CG_DrawSides
CALLV
pop
line 87
;86:
;87:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 88
;88:}
LABELV $110
endproc CG_DrawRect 0 24
export CG_DrawPic
proc CG_DrawPic 0 36
line 98
;89:
;90:
;91:/*
;92:================
;93:CG_DrawPic
;94:
;95:Coordinates are SCREEN_WIDTH*SCREEN_HEIGHT virtual values
;96:=================
;97:*/
;98:void CG_DrawPic(float x, float y, float w, float h, qhandle_t asset, int widescreen) { //, rectDef_t menuRect) {
line 99
;99:	CG_AdjustFrom640(&x, &y, &w, &h);
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 100
;100:	trap_R_DrawStretchPic(x, y, w, h, 0, 0, 1, 1, asset);
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
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 101
;101:}
LABELV $111
endproc CG_DrawPic 0 36
export CG_DrawStretchPic
proc CG_DrawStretchPic 0 36
line 110
;102:
;103:
;104:/*
;105:================
;106:CG_DrawStretchPic
;107:
;108:=================
;109:*/
;110:void CG_DrawStretchPic(float x, float y, float w, float h, float s1, float t1, float s2, float t2, qhandle_t hShader, int widescreen) { //, rectDef_t menuRect) {
line 111
;111:	CG_AdjustFrom640(&x, &y, &w, &h);
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 112
;112:	trap_R_DrawStretchPic(x, y, w, h, 0, 0, 1, 1, hShader);
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
ADDRFP4 32
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 113
;113:}
LABELV $112
endproc CG_DrawStretchPic 0 36
proc CG_DrawChar 48 36
line 123
;114:
;115:
;116:/*
;117:===============
;118:CG_DrawChar
;119:
;120:Coordinates and size in SCREEN_WIDTH*SCREEN_HEIGHT virtual screen size
;121:===============
;122:*/
;123:static void CG_DrawChar(int x, int y, int width, int height, int ch) {
line 129
;124:	int row, col;
;125:	float frow, fcol;
;126:	float size;
;127:	float	ax, ay, aw, ah;
;128:
;129:	ch &= 255;
ADDRFP4 16
ADDRFP4 16
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 131
;130:
;131:	if (ch == ' ') {
ADDRFP4 16
INDIRI4
CNSTI4 32
NEI4 $114
line 132
;132:		return;
ADDRGP4 $113
JUMPV
LABELV $114
line 135
;133:	}
;134:
;135:	ax = x;
ADDRLP4 12
ADDRFP4 0
INDIRI4
CVIF4 4
ASGNF4
line 136
;136:	ay = y;
ADDRLP4 16
ADDRFP4 4
INDIRI4
CVIF4 4
ASGNF4
line 137
;137:	aw = width;
ADDRLP4 20
ADDRFP4 8
INDIRI4
CVIF4 4
ASGNF4
line 138
;138:	ah = height;
ADDRLP4 24
ADDRFP4 12
INDIRI4
CVIF4 4
ASGNF4
line 139
;139:	CG_AdjustFrom640(&ax, &ay, &aw, &ah);
ADDRLP4 12
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 141
;140:
;141:	row = ch >> 4;
ADDRLP4 28
ADDRFP4 16
INDIRI4
CNSTI4 4
RSHI4
ASGNI4
line 142
;142:	col = ch & 15;
ADDRLP4 32
ADDRFP4 16
INDIRI4
CNSTI4 15
BANDI4
ASGNI4
line 144
;143:
;144:	frow = row * 0.0625;
ADDRLP4 0
ADDRLP4 28
INDIRI4
CVIF4 4
CNSTF4 1031798784
MULF4
ASGNF4
line 145
;145:	fcol = col * 0.0625;
ADDRLP4 4
ADDRLP4 32
INDIRI4
CVIF4 4
CNSTF4 1031798784
MULF4
ASGNF4
line 146
;146:	size = 0.0625;
ADDRLP4 8
CNSTF4 1031798784
ASGNF4
line 148
;147:
;148:	trap_R_DrawStretchPic(ax, ay, aw, ah,
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ARGF4
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ARGF4
ADDRGP4 cgs+146664
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 152
;149:		fcol, frow,
;150:		fcol + size, frow + size,
;151:		cgs.media.charsetShader);
;152:}
LABELV $113
endproc CG_DrawChar 48 36
export CG_DrawStringExt
proc CG_DrawStringExt 36 20
line 166
;153:
;154:
;155:/*
;156:==================
;157:CG_DrawStringExt
;158:
;159:Draws a multi-colored string with a drop shadow, optionally forcing
;160:to a fixed color.
;161:
;162:Coordinates are at SCREEN_WIDTH by SCREEN_HEIGHT virtual resolution
;163:==================
;164:*/
;165:void CG_DrawStringExt(int x, int y, const char *string, const float *setColor,
;166:	qboolean forceColor, qboolean shadow, int charWidth, int charHeight, int maxChars) {
line 172
;167:	vec4_t		color;
;168:	const char *s;
;169:	int			xx;
;170:	int			cnt;
;171:
;172:	if (maxChars <= 0)
ADDRFP4 32
INDIRI4
CNSTI4 0
GTI4 $118
line 173
;173:		maxChars = 32767; // do them all!
ADDRFP4 32
CNSTI4 32767
ASGNI4
LABELV $118
line 176
;174:
;175:	// draw the drop shadow
;176:	if (shadow) {
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $120
line 177
;177:		color[0] = color[1] = color[2] = 0;
ADDRLP4 28
CNSTF4 0
ASGNF4
ADDRLP4 12+8
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 28
INDIRF4
ASGNF4
line 178
;178:		color[3] = setColor[3];
ADDRLP4 12+12
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 179
;179:		trap_R_SetColor(color);
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 180
;180:		s = string;
ADDRLP4 0
ADDRFP4 8
INDIRP4
ASGNP4
line 181
;181:		xx = x;
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
line 182
;182:		cnt = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $126
JUMPV
LABELV $125
line 183
;183:		while (*s && cnt < maxChars) {
line 184
;184:			if (Q_IsColorString(s)) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $128
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $128
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $128
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $128
line 185
;185:				s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 186
;186:				continue;
ADDRGP4 $126
JUMPV
LABELV $128
line 188
;187:			}
;188:			CG_DrawChar(xx + 2, y + 2, charWidth, charHeight, *s);
ADDRLP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRFP4 28
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRGP4 CG_DrawChar
CALLV
pop
line 189
;189:			cnt++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 190
;190:			xx += charWidth;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRFP4 24
INDIRI4
ADDI4
ASGNI4
line 191
;191:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 192
;192:		}
LABELV $126
line 183
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $130
ADDRLP4 8
INDIRI4
ADDRFP4 32
INDIRI4
LTI4 $125
LABELV $130
line 193
;193:	}
LABELV $120
line 196
;194:
;195:	// draw the colored text
;196:	s = string;
ADDRLP4 0
ADDRFP4 8
INDIRP4
ASGNP4
line 197
;197:	xx = x;
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
line 198
;198:	cnt = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 199
;199:	trap_R_SetColor(setColor);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
ADDRGP4 $132
JUMPV
LABELV $131
line 200
;200:	while (*s && cnt < maxChars) {
line 201
;201:		if (Q_IsColorString(s)) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $134
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $134
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $134
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $134
line 202
;202:			if (!forceColor) {
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $136
line 203
;203:				memcpy(color, g_color_table[ColorIndex(*(s + 1))], sizeof(color));
ADDRLP4 12
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
CNSTI4 7
BANDI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 204
;204:				color[3] = setColor[3];
ADDRLP4 12+12
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 205
;205:				trap_R_SetColor(color);
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 206
;206:			}
LABELV $136
line 207
;207:			s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 208
;208:			continue;
ADDRGP4 $132
JUMPV
LABELV $134
line 210
;209:		}
;210:		CG_DrawChar(xx, y, charWidth, charHeight, *s);
ADDRLP4 4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRFP4 28
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRGP4 CG_DrawChar
CALLV
pop
line 211
;211:		xx += charWidth;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRFP4 24
INDIRI4
ADDI4
ASGNI4
line 212
;212:		cnt++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 213
;213:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 214
;214:	}
LABELV $132
line 200
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $139
ADDRLP4 8
INDIRI4
ADDRFP4 32
INDIRI4
LTI4 $131
LABELV $139
line 215
;215:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 216
;216:}
LABELV $117
endproc CG_DrawStringExt 36 20
data
align 4
LABELV font
address bigchars
align 4
LABELV metrics
address bigchars
export CG_SelectFont
code
proc CG_SelectFont 0 0
line 246
;217:
;218:
;219:// new font renderer
;220:
;221:#ifdef USE_NEW_FONT_RENDERER
;222:
;223:#define MAX_FONT_SHADERS 4
;224:
;225:typedef struct {
;226:	float tc_prop[4];
;227:	float tc_mono[4];
;228:	float space1;
;229:	float space2;
;230:	float width;
;231:} font_metric_t;
;232:
;233:typedef struct {
;234:	font_metric_t	metrics[256];
;235:	qhandle_t		shader[MAX_FONT_SHADERS];
;236:	int				shaderThreshold[MAX_FONT_SHADERS];
;237:	int				shaderCount;
;238:} font_t;
;239:
;240:static font_t bigchars;
;241:static font_t numbers;
;242:static const font_t *font = &bigchars;
;243:static const font_metric_t *metrics = &bigchars.metrics[0];
;244:
;245:
;246:void CG_SelectFont(int index) {
line 247
;247:	if (index == 0)
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $143
line 248
;248:		font = &bigchars;
ADDRGP4 font
ADDRGP4 bigchars
ASGNP4
ADDRGP4 $144
JUMPV
LABELV $143
line 250
;249:	else
;250:		font = &numbers;
ADDRGP4 font
ADDRGP4 numbers
ASGNP4
LABELV $144
line 252
;251:
;252:	metrics = &font->metrics[0];
ADDRGP4 metrics
ADDRGP4 font
INDIRP4
ASGNP4
line 253
;253:}
LABELV $142
endproc CG_SelectFont 0 0
proc CG_FileExist 8 12
line 256
;254:
;255:
;256:static qboolean CG_FileExist(const char *file) {
line 259
;257:	fileHandle_t	f;
;258:
;259:	if (!file || !file[0])
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $148
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $146
LABELV $148
line 260
;260:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $145
JUMPV
LABELV $146
line 262
;261:
;262:	trap_FS_FOpenFile(file, &f, FS_READ);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_FS_FOpenFile
CALLI4
pop
line 263
;263:	if (f == FS_INVALID_HANDLE)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $149
line 264
;264:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $145
JUMPV
LABELV $149
line 265
;265:	else {
line 266
;266:		trap_FS_FCloseFile(f);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 267
;267:		return qtrue;
CNSTI4 1
RETI4
LABELV $145
endproc CG_FileExist 8 12
proc CG_LoadFont 8508 16
line 272
;268:	}
;269:}
;270:
;271:
;272:static void CG_LoadFont(font_t *fnt, const char *fontName) {
line 289
;273:	char buf[8000];
;274:	fileHandle_t f;
;275:	char *token, *text;
;276:	float width, height, r_width, r_height;
;277:	float char_width;
;278:	float char_height;
;279:	char shaderName[MAX_FONT_SHADERS][MAX_QPATH], tmpName[MAX_QPATH];
;280:	int shaderCount;
;281:	int shaderThreshold[MAX_FONT_SHADERS];
;282:	font_metric_t *fm;
;283:	int i, tmp, len, chars;
;284:	float w1, w2;
;285:	float s1, s2;
;286:	float x0, y0;
;287:	qboolean swapped;
;288:
;289:	memset(fnt, 0, sizeof(*fnt));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 11300
ARGI4
ADDRGP4 memset
CALLP4
pop
line 291
;290:
;291:	len = trap_FS_FOpenFile(fontName, &f, FS_READ);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8420
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8424
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 416
ADDRLP4 8424
INDIRI4
ASGNI4
line 292
;292:	if (f == FS_INVALID_HANDLE) {
ADDRLP4 8420
INDIRI4
CNSTI4 0
NEI4 $152
line 293
;293:		CG_Printf(S_COLOR_YELLOW "CG_LoadFont: error opening %s\n", fontName);
ADDRGP4 $154
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 294
;294:		return;
ADDRGP4 $151
JUMPV
LABELV $152
line 297
;295:	}
;296:
;297:	if (len >= sizeof(buf)) {
ADDRLP4 416
INDIRI4
CVIU4 4
CNSTU4 8000
LTU4 $155
line 298
;298:		CG_Printf(S_COLOR_YELLOW "CG_LoadFont: font file is too long: %i\n", len);
ADDRGP4 $157
ARGP4
ADDRLP4 416
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 299
;299:		len = sizeof(buf) - 1;
ADDRLP4 416
CNSTI4 7999
ASGNI4
line 300
;300:	}
LABELV $155
line 302
;301:
;302:	trap_FS_Read(buf, len, f);
ADDRLP4 420
ARGP4
ADDRLP4 416
INDIRI4
ARGI4
ADDRLP4 8420
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 303
;303:	trap_FS_FCloseFile(f);
ADDRLP4 8420
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 304
;304:	buf[len] = '\0';
ADDRLP4 416
INDIRI4
ADDRLP4 420
ADDP4
CNSTI1 0
ASGNI1
line 306
;305:
;306:	shaderCount = 0;
ADDRLP4 284
CNSTI4 0
ASGNI4
line 308
;307:
;308:	text = buf; // initialize parser
ADDRLP4 288
ADDRLP4 420
ASGNP4
line 309
;309:	COM_BeginParseSession(fontName);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 COM_BeginParseSession
CALLV
pop
ADDRGP4 $159
JUMPV
LABELV $158
line 311
;310:
;311:	while (1) {
line 312
;312:		token = COM_ParseExt(&text, qtrue);
ADDRLP4 288
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8428
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 8428
INDIRP4
ASGNP4
line 313
;313:		if (token[0] == '\0') {
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $161
line 314
;314:			Com_Printf(S_COLOR_RED "CG_LoadFont: parse error.\n");
ADDRGP4 $163
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 315
;315:			return;
ADDRGP4 $151
JUMPV
LABELV $161
line 319
;316:		}
;317:
;318:		// font image
;319:		if (strcmp(token, "img") == 0) {
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 $166
ARGP4
ADDRLP4 8432
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8432
INDIRI4
CNSTI4 0
NEI4 $164
line 320
;320:			if (shaderCount >= MAX_FONT_SHADERS) {
ADDRLP4 284
INDIRI4
CNSTI4 4
LTI4 $167
line 321
;321:				Com_Printf("CG_LoadFont: too many font images, ignoring.\n");
ADDRGP4 $169
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 322
;322:				SkipRestOfLine(&text);
ADDRLP4 288
ARGP4
ADDRGP4 SkipRestOfLine
CALLV
pop
line 323
;323:				continue;
ADDRGP4 $159
JUMPV
LABELV $167
line 325
;324:			}
;325:			token = COM_ParseExt(&text, qfalse);
ADDRLP4 288
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8436
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 8436
INDIRP4
ASGNP4
line 326
;326:			if (!CG_FileExist(token)) {
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 8440
ADDRGP4 CG_FileExist
CALLI4
ASGNI4
ADDRLP4 8440
INDIRI4
CNSTI4 0
NEI4 $170
line 327
;327:				Com_Printf("CG_LoadFont: font image '%s' doesn't exist.\n", token);
ADDRGP4 $172
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 328
;328:				return;
ADDRGP4 $151
JUMPV
LABELV $170
line 331
;329:			}
;330:			// save shader name
;331:			Q_strncpyz(shaderName[shaderCount], token, sizeof(shaderName[shaderCount]));
ADDRLP4 284
INDIRI4
CNSTI4 6
LSHI4
ADDRLP4 24
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 333
;332:			// get threshold
;333:			token = COM_ParseExt(&text, qfalse);
ADDRLP4 288
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8444
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 8444
INDIRP4
ASGNP4
line 334
;334:			shaderThreshold[shaderCount] = atoi(token);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 8448
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 8448
INDIRI4
ASGNI4
line 337
;335:
;336:			//Com_Printf( S_COLOR_CYAN "img: %s, threshold: %i\n", shaderName[ shaderCount ], shaderThreshold[ shaderCount ] );
;337:			shaderCount++;
ADDRLP4 284
ADDRLP4 284
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 339
;338:
;339:			SkipRestOfLine(&text);
ADDRLP4 288
ARGP4
ADDRGP4 SkipRestOfLine
CALLV
pop
line 340
;340:			continue;
ADDRGP4 $159
JUMPV
LABELV $164
line 344
;341:		}
;342:
;343:		// font parameters
;344:		if (strcmp(token, "fnt") == 0) {
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 $175
ARGP4
ADDRLP4 8436
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8436
INDIRI4
CNSTI4 0
NEI4 $173
line 345
;345:			token = COM_ParseExt(&text, qfalse);
ADDRLP4 288
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8440
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 8440
INDIRP4
ASGNP4
line 346
;346:			if (token[0] == '\0' || (width = atof(token)) <= 0.0) {
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $178
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 8448
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 408
ADDRLP4 8448
INDIRF4
ASGNF4
ADDRLP4 8448
INDIRF4
CNSTF4 0
GTF4 $176
LABELV $178
line 347
;347:				Com_Printf("CG_LoadFont: error reading image width.\n");
ADDRGP4 $179
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 348
;348:				return;
ADDRGP4 $151
JUMPV
LABELV $176
line 350
;349:			}
;350:			r_width = 1.0 / width;
ADDRLP4 364
CNSTF4 1065353216
ADDRLP4 408
INDIRF4
DIVF4
ASGNF4
line 352
;351:
;352:			token = COM_ParseExt(&text, qfalse);
ADDRLP4 288
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8452
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 8452
INDIRP4
ASGNP4
line 353
;353:			if (token[0] == '\0' || (height = atof(token)) <= 0.0) {
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $182
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 8460
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 412
ADDRLP4 8460
INDIRF4
ASGNF4
ADDRLP4 8460
INDIRF4
CNSTF4 0
GTF4 $180
LABELV $182
line 354
;354:				Com_Printf("CG_LoadFont: error reading image height.\n");
ADDRGP4 $183
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 355
;355:				return;
ADDRGP4 $151
JUMPV
LABELV $180
line 357
;356:			}
;357:			r_height = 1.0 / height;
ADDRLP4 384
CNSTF4 1065353216
ADDRLP4 412
INDIRF4
DIVF4
ASGNF4
line 359
;358:
;359:			token = COM_ParseExt(&text, qfalse);
ADDRLP4 288
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8464
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 8464
INDIRP4
ASGNP4
line 360
;360:			if (token[0] == '\0') {
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $184
line 361
;361:				Com_Printf("CG_LoadFont: error reading char widht.\n");
ADDRGP4 $186
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 362
;362:				return;
ADDRGP4 $151
JUMPV
LABELV $184
line 364
;363:			}
;364:			char_width = atof(token);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 8468
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 368
ADDRLP4 8468
INDIRF4
ASGNF4
line 366
;365:
;366:			token = COM_ParseExt(&text, qfalse);
ADDRLP4 288
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8472
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 8472
INDIRP4
ASGNP4
line 367
;367:			if (token[0] == '\0') {
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $187
line 368
;368:				Com_Printf("CG_LoadFont: error reading char height.\n");
ADDRGP4 $189
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 369
;369:				return;
ADDRGP4 $151
JUMPV
LABELV $187
line 371
;370:			}
;371:			char_height = atof(token);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 8476
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 400
ADDRLP4 8476
INDIRF4
ASGNF4
line 373
;372:
;373:			break; // parse char metrics
ADDRGP4 $160
JUMPV
LABELV $173
line 375
;374:		}
;375:	}
LABELV $159
line 311
ADDRGP4 $158
JUMPV
LABELV $160
line 377
;376:
;377:	if (shaderCount == 0) {
ADDRLP4 284
INDIRI4
CNSTI4 0
NEI4 $190
line 378
;378:		Com_Printf("CG_LoadFont: no font images specified in %s.\n", fontName);
ADDRGP4 $192
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 379
;379:		return;
ADDRGP4 $151
JUMPV
LABELV $190
line 382
;380:	}
;381:
;382:	fm = fnt->metrics;
ADDRLP4 280
ADDRFP4 0
INDIRP4
ASGNP4
line 384
;383:
;384:	chars = 0;
ADDRLP4 404
CNSTI4 0
ASGNI4
line 385
;385:	for (;; ) {
LABELV $193
line 387
;386:		// char index
;387:		token = COM_ParseExt(&text, qtrue);
ADDRLP4 288
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8428
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 8428
INDIRP4
ASGNP4
line 388
;388:		if (!token[0])
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $197
line 389
;389:			break;
ADDRGP4 $195
JUMPV
LABELV $197
line 391
;390:
;391:		if (token[0] == '\'' && token[1] && token[2] == '\'') // char code in form 'X'
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 39
NEI4 $199
ADDRLP4 20
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $199
ADDRLP4 20
INDIRP4
CNSTI4 2
ADDP4
INDIRI1
CVII4 1
CNSTI4 39
NEI4 $199
line 392
;392:			i = token[1] & 255;
ADDRLP4 0
ADDRLP4 20
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 255
BANDI4
ASGNI4
ADDRGP4 $200
JUMPV
LABELV $199
line 394
;393:		else // integer code
;394:			i = atoi(token);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 8436
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8436
INDIRI4
ASGNI4
LABELV $200
line 396
;395:
;396:		if (i < 0 || i > 255) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $203
ADDRLP4 0
INDIRI4
CNSTI4 255
LEI4 $201
LABELV $203
line 397
;397:			CG_Printf(S_COLOR_RED "CG_LoadFont: bad char index %i.\n", i);
ADDRGP4 $204
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 398
;398:			return;
ADDRGP4 $151
JUMPV
LABELV $201
line 400
;399:		}
;400:		fm = fnt->metrics + i;
ADDRLP4 280
ADDRLP4 0
INDIRI4
CNSTI4 44
MULI4
ADDRFP4 0
INDIRP4
ADDP4
ASGNP4
line 403
;401:
;402:		// x0
;403:		token = COM_ParseExt(&text, qfalse);
ADDRLP4 288
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8444
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 8444
INDIRP4
ASGNP4
line 404
;404:		if (!token[0]) {
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $205
line 405
;405:			CG_Printf(S_COLOR_RED "CG_LoadFont: error reading x0.\n");
ADDRGP4 $207
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 406
;406:			return;
ADDRGP4 $151
JUMPV
LABELV $205
line 408
;407:		}
;408:		x0 = atof(token);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 8448
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 376
ADDRLP4 8448
INDIRF4
ASGNF4
line 411
;409:
;410:		// y0
;411:		token = COM_ParseExt(&text, qfalse);
ADDRLP4 288
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8452
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 8452
INDIRP4
ASGNP4
line 412
;412:		if (!token[0]) {
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $208
line 413
;413:			CG_Printf(S_COLOR_RED "CG_LoadFont: error reading y0.\n");
ADDRGP4 $210
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 414
;414:			return;
ADDRGP4 $151
JUMPV
LABELV $208
line 416
;415:		}
;416:		y0 = atof(token);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 8456
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 380
ADDRLP4 8456
INDIRF4
ASGNF4
line 419
;417:
;418:		// w1-offset
;419:		token = COM_ParseExt(&text, qfalse);
ADDRLP4 288
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8460
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 8460
INDIRP4
ASGNP4
line 420
;420:		if (!token[0]) {
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $211
line 421
;421:			CG_Printf(S_COLOR_RED "CG_LoadFont: error reading x-offset.\n");
ADDRGP4 $213
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 422
;422:			return;
ADDRGP4 $151
JUMPV
LABELV $211
line 424
;423:		}
;424:		w1 = atof(token);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 8464
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 388
ADDRLP4 8464
INDIRF4
ASGNF4
line 427
;425:
;426:		// w2-offset
;427:		token = COM_ParseExt(&text, qfalse);
ADDRLP4 288
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8468
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 8468
INDIRP4
ASGNP4
line 428
;428:		if (!token[0]) {
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $214
line 429
;429:			CG_Printf(S_COLOR_RED "CG_LoadFont: error reading x-length.\n");
ADDRGP4 $216
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 430
;430:			return;
ADDRGP4 $151
JUMPV
LABELV $214
line 432
;431:		}
;432:		w2 = atof(token);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 8472
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 372
ADDRLP4 8472
INDIRF4
ASGNF4
line 435
;433:
;434:		// space1
;435:		token = COM_ParseExt(&text, qfalse);
ADDRLP4 288
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8476
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 8476
INDIRP4
ASGNP4
line 436
;436:		if (!token[0]) {
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $217
line 437
;437:			CG_Printf(S_COLOR_RED "CG_LoadFont: error reading space1.\n");
ADDRGP4 $219
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 438
;438:			return;
ADDRGP4 $151
JUMPV
LABELV $217
line 440
;439:		}
;440:		s1 = atof(token);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 8480
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 392
ADDRLP4 8480
INDIRF4
ASGNF4
line 443
;441:
;442:		// space2
;443:		token = COM_ParseExt(&text, qfalse);
ADDRLP4 288
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8484
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 8484
INDIRP4
ASGNP4
line 444
;444:		if (!token[0]) {
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $220
line 445
;445:			CG_Printf(S_COLOR_RED "CG_LoadFont: error reading space2.\n");
ADDRGP4 $222
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 446
;446:			return;
ADDRGP4 $151
JUMPV
LABELV $220
line 448
;447:		}
;448:		s2 = atof(token);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 8488
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 396
ADDRLP4 8488
INDIRF4
ASGNF4
line 450
;449:
;450:		fm->tc_mono[0] = x0 * r_width;
ADDRLP4 280
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 376
INDIRF4
ADDRLP4 364
INDIRF4
MULF4
ASGNF4
line 451
;451:		fm->tc_mono[1] = y0 * r_height;
ADDRLP4 280
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 380
INDIRF4
ADDRLP4 384
INDIRF4
MULF4
ASGNF4
line 452
;452:		fm->tc_mono[2] = (x0 + char_width) * r_width;
ADDRLP4 280
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 376
INDIRF4
ADDRLP4 368
INDIRF4
ADDF4
ADDRLP4 364
INDIRF4
MULF4
ASGNF4
line 453
;453:		fm->tc_mono[3] = (y0 + char_height) * r_height;
ADDRLP4 280
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 380
INDIRF4
ADDRLP4 400
INDIRF4
ADDF4
ADDRLP4 384
INDIRF4
MULF4
ASGNF4
line 456
;454:
;455:		// proportional y-coords is matching with mono
;456:		fm->tc_prop[1] = fm->tc_mono[1];
ADDRLP4 280
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 280
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 457
;457:		fm->tc_prop[3] = fm->tc_mono[3];
ADDRLP4 280
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 280
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ASGNF4
line 459
;458:
;459:		fm->width = w2 / char_width;
ADDRLP4 280
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 372
INDIRF4
ADDRLP4 368
INDIRF4
DIVF4
ASGNF4
line 460
;460:		fm->space1 = s1 / char_width;
ADDRLP4 280
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 392
INDIRF4
ADDRLP4 368
INDIRF4
DIVF4
ASGNF4
line 461
;461:		fm->space2 = (s2 + w2) / char_width;
ADDRLP4 280
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 396
INDIRF4
ADDRLP4 372
INDIRF4
ADDF4
ADDRLP4 368
INDIRF4
DIVF4
ASGNF4
line 462
;462:		fm->tc_prop[0] = fm->tc_mono[0] + (w1 * r_width);
ADDRLP4 280
INDIRP4
ADDRLP4 280
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 388
INDIRF4
ADDRLP4 364
INDIRF4
MULF4
ADDF4
ASGNF4
line 463
;463:		fm->tc_prop[2] = fm->tc_prop[0] + (w2 * r_width);
ADDRLP4 280
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 280
INDIRP4
INDIRF4
ADDRLP4 372
INDIRF4
ADDRLP4 364
INDIRF4
MULF4
ADDF4
ASGNF4
line 465
;464:
;465:		chars++;
ADDRLP4 404
ADDRLP4 404
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 467
;466:
;467:		SkipRestOfLine(&text);
ADDRLP4 288
ARGP4
ADDRGP4 SkipRestOfLine
CALLV
pop
line 468
;468:	}
line 385
ADDRGP4 $193
JUMPV
LABELV $195
LABELV $223
line 471
;469:
;470:	// sort images by threshold
;471:	do {
line 472
;472:		for (swapped = qfalse, i = 1; i < shaderCount; i++) {
ADDRLP4 360
CNSTI4 0
ASGNI4
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $229
JUMPV
LABELV $226
line 473
;473:			if (shaderThreshold[i - 1] > shaderThreshold[i]) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
LEI4 $230
line 474
;474:				tmp = shaderThreshold[i - 1];
ADDRLP4 356
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ASGNI4
line 475
;475:				shaderThreshold[i - 1] = shaderThreshold[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ASGNI4
line 476
;476:				shaderThreshold[i] = tmp;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 356
INDIRI4
ASGNI4
line 477
;477:				strcpy(tmpName, shaderName[i - 1]);
ADDRLP4 292
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRLP4 24-64
ADDP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 478
;478:				strcpy(shaderName[i - 1], shaderName[i]);
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRLP4 24-64
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRLP4 24
ADDP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 479
;479:				strcpy(shaderName[i], tmpName);
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRLP4 24
ADDP4
ARGP4
ADDRLP4 292
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 480
;480:				swapped = qtrue;
ADDRLP4 360
CNSTI4 1
ASGNI4
line 481
;481:			}
LABELV $230
line 482
;482:		}
LABELV $227
line 472
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $229
ADDRLP4 0
INDIRI4
ADDRLP4 284
INDIRI4
LTI4 $226
line 483
;483:	} while (swapped);
LABELV $224
ADDRLP4 360
INDIRI4
CNSTI4 0
NEI4 $223
line 486
;484:
;485:	// always assume zero threshold for lowest-quality shader
;486:	shaderThreshold[0] = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 488
;487:
;488:	fnt->shaderCount = shaderCount;
ADDRFP4 0
INDIRP4
CNSTI4 11296
ADDP4
ADDRLP4 284
INDIRI4
ASGNI4
line 489
;489:	for (i = 0; i < shaderCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $240
JUMPV
LABELV $237
line 490
;490:		fnt->shader[i] = trap_R_RegisterShaderNoMip(shaderName[i]);
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRLP4 24
ADDP4
ARGP4
ADDRLP4 8432
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 11264
ADDP4
ADDP4
ADDRLP4 8432
INDIRI4
ASGNI4
line 491
;491:		fnt->shaderThreshold[i] = shaderThreshold[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 11280
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ASGNI4
line 492
;492:	}
LABELV $238
line 489
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $240
ADDRLP4 0
INDIRI4
ADDRLP4 284
INDIRI4
LTI4 $237
line 494
;493:
;494:	CG_Printf("Font '%s' loaded with %i chars and %i images\n", fontName, chars, shaderCount);
ADDRGP4 $241
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 404
INDIRI4
ARGI4
ADDRLP4 284
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 495
;495:}
LABELV $151
endproc CG_LoadFont 8508 16
export CG_LoadFonts
proc CG_LoadFonts 0 8
line 498
;496:
;497:
;498:void CG_LoadFonts(void) {
line 499
;499:	CG_LoadFont(&bigchars, "gfx/2d/bigchars.cfg");
ADDRGP4 bigchars
ARGP4
ADDRGP4 $243
ARGP4
ADDRGP4 CG_LoadFont
CALLV
pop
line 500
;500:	CG_LoadFont(&numbers, "gfx/2d/numbers.cfg");
ADDRGP4 numbers
ARGP4
ADDRGP4 $244
ARGP4
ADDRGP4 CG_LoadFont
CALLV
pop
line 501
;501:}
LABELV $242
endproc CG_LoadFonts 0 8
proc DrawStringLength 20 0
line 504
;502:
;503:
;504:static float DrawStringLength(const char *string, float ax, float aw, float max_ax, int proportional) {
line 511
;505:	const font_metric_t *fm;
;506:	//float			aw1;
;507:	float			x_end;
;508:	const byte *s;
;509:	float			xx;
;510:
;511:	if (!string)
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $246
line 512
;512:		return 0.0f;
CNSTF4 0
RETF4
ADDRGP4 $245
JUMPV
LABELV $246
line 514
;513:
;514:	s = (const byte *)string;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 516
;515:
;516:	xx = ax;
ADDRLP4 12
ADDRFP4 4
INDIRF4
ASGNF4
ADDRGP4 $249
JUMPV
LABELV $248
line 518
;517:
;518:	while (*s != '\0') {
line 520
;519:
;520:		if (*s == Q_COLOR_ESCAPE && s[1] != '\0' && s[1] != '^') {
ADDRLP4 0
INDIRP4
INDIRU1
CVUI4 1
CNSTI4 94
NEI4 $251
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRU1
CVUI4 1
CNSTI4 0
EQI4 $251
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRU1
CVUI4 1
CNSTI4 94
EQI4 $251
line 522
;521:			//if ( !(flags & DS_SHOW_CODE) ) {
;522:			s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 523
;523:			continue;
ADDRGP4 $249
JUMPV
LABELV $251
line 528
;524:			//}
;525:		}
;526:
;527:		//fm = &font->metrics[ *s ];
;528:		fm = &metrics[*s];
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRU1
CVUI4 1
CNSTI4 44
MULI4
ADDRGP4 metrics
INDIRP4
ADDP4
ASGNP4
line 529
;529:		if (proportional) {
ADDRFP4 16
INDIRI4
CNSTI4 0
EQI4 $253
line 531
;530:			//aw1 = fm->width * aw;
;531:			ax += fm->space1 * aw;			// add extra space if required by metrics
ADDRFP4 4
ADDRFP4 4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRFP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
line 532
;532:			x_end = ax + fm->space2 * aw;	// final position
ADDRLP4 4
ADDRFP4 4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRFP4 8
INDIRF4
MULF4
ADDF4
ASGNF4
line 533
;533:		} else {
ADDRGP4 $254
JUMPV
LABELV $253
line 535
;534:			//aw1 = aw;
;535:			x_end = ax + aw;
ADDRLP4 4
ADDRFP4 4
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
ASGNF4
line 536
;536:		}
LABELV $254
line 538
;537:
;538:		if (x_end > max_ax)
ADDRLP4 4
INDIRF4
ADDRFP4 12
INDIRF4
LEF4 $255
line 539
;539:			break;
ADDRGP4 $250
JUMPV
LABELV $255
line 541
;540:
;541:		ax = x_end;
ADDRFP4 4
ADDRLP4 4
INDIRF4
ASGNF4
line 542
;542:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 543
;543:	}
LABELV $249
line 518
ADDRLP4 0
INDIRP4
INDIRU1
CVUI4 1
CNSTI4 0
NEI4 $248
LABELV $250
line 545
;544:
;545:	return (ax - xx);
ADDRFP4 4
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
RETF4
LABELV $245
endproc DrawStringLength 20 0
export CG_DrawString
proc CG_DrawString 96 36
line 549
;546:}
;547:
;548:
;549:void CG_DrawString(float x, float y, const char *string, const vec4_t setColor, float charWidth, float charHeight, int maxChars, int flags) {
line 563
;550:	const font_metric_t *fm;
;551:	const float *tc; // texture coordinates for char
;552:	float			ax, ay, aw, aw1, ah; // absolute positions/dimensions
;553:	float			scale;
;554:	float			x_end, xx;
;555:	vec4_t			color;
;556:	const byte *s;
;557:	float			xx_add, yy_add;
;558:	float			max_ax;
;559:	int				i;
;560:	qhandle_t		sh;
;561:	int				proportional;
;562:
;563:	if (!string)
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $258
line 564
;564:		return;
ADDRGP4 $257
JUMPV
LABELV $258
line 566
;565:
;566:	s = (const byte *)string;
ADDRLP4 0
ADDRFP4 8
INDIRP4
ASGNP4
line 568
;567:
;568:	ax = x * cgs.screenXScale + cgs.screenXBias;
ADDRLP4 8
ADDRFP4 0
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDRGP4 cgs+31444
INDIRF4
ADDF4
ASGNF4
line 569
;569:	ay = y * cgs.screenYScale + cgs.screenYBias;
ADDRLP4 48
ADDRFP4 4
INDIRF4
ADDRGP4 cgs+31436
INDIRF4
MULF4
ADDRGP4 cgs+31448
INDIRF4
ADDF4
ASGNF4
line 571
;570:
;571:	aw = charWidth * cgs.screenXScale;
ADDRLP4 20
ADDRFP4 16
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 572
;572:	ah = charHeight * cgs.screenYScale;
ADDRLP4 32
ADDRFP4 20
INDIRF4
ADDRGP4 cgs+31436
INDIRF4
MULF4
ASGNF4
line 574
;573:
;574:	if (maxChars <= 0) {
ADDRFP4 24
INDIRI4
CNSTI4 0
GTI4 $266
line 575
;575:		max_ax = 9999999.0f;
ADDRLP4 40
CNSTF4 1259902591
ASGNF4
line 576
;576:	} else {
ADDRGP4 $267
JUMPV
LABELV $266
line 577
;577:		max_ax = ax + aw * maxChars;
ADDRLP4 40
ADDRLP4 8
INDIRF4
ADDRLP4 20
INDIRF4
ADDRFP4 24
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 578
;578:	}
LABELV $267
line 580
;579:
;580:	proportional = (flags & DS_PROPORTIONAL);
ADDRLP4 44
ADDRFP4 28
INDIRI4
CNSTI4 4
BANDI4
ASGNI4
line 582
;581:
;582:	if (flags & (DS_CENTER | DS_RIGHT)) {
ADDRFP4 28
INDIRI4
CNSTI4 24
BANDI4
CNSTI4 0
EQI4 $268
line 583
;583:		if (flags & DS_CENTER) {
ADDRFP4 28
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $270
line 584
;584:			ax -= 0.5f * DrawStringLength(string, ax, aw, max_ax, proportional);
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 88
ADDRGP4 DrawStringLength
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 88
INDIRF4
CNSTF4 1056964608
MULF4
SUBF4
ASGNF4
line 585
;585:		} else {
ADDRGP4 $271
JUMPV
LABELV $270
line 586
;586:			ax -= DrawStringLength(string, ax, aw, max_ax, proportional);
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 88
ADDRGP4 DrawStringLength
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 88
INDIRF4
SUBF4
ASGNF4
line 587
;587:		}
LABELV $271
line 588
;588:	}
LABELV $268
line 590
;589:
;590:	sh = font->shader[0]; // low-res shader by default
ADDRLP4 36
ADDRGP4 font
INDIRP4
CNSTI4 11264
ADDP4
INDIRI4
ASGNI4
line 592
;591:
;592:	if (flags & DS_SHADOW) {
ADDRFP4 28
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $272
line 593
;593:		xx = ax;
ADDRLP4 80
ADDRLP4 8
INDIRF4
ASGNF4
line 596
;594:
;595:		// calculate shadow offsets
;596:		scale = charWidth * 0.075f; // charWidth/15
ADDRLP4 76
ADDRFP4 16
INDIRF4
CNSTF4 1033476506
MULF4
ASGNF4
line 597
;597:		xx_add = scale * cgs.screenXScale;
ADDRLP4 68
ADDRLP4 76
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 598
;598:		yy_add = scale * cgs.screenYScale;
ADDRLP4 72
ADDRLP4 76
INDIRF4
ADDRGP4 cgs+31436
INDIRF4
MULF4
ASGNF4
line 600
;599:
;600:		color[0] = color[1] = color[2] = 0.0f;
ADDRLP4 84
CNSTF4 0
ASGNF4
ADDRLP4 52+8
ADDRLP4 84
INDIRF4
ASGNF4
ADDRLP4 52+4
ADDRLP4 84
INDIRF4
ASGNF4
ADDRLP4 52
ADDRLP4 84
INDIRF4
ASGNF4
line 601
;601:		color[3] = setColor[3] * 0.5f;
ADDRLP4 52+12
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 602
;602:		trap_R_SetColor(color);
ADDRLP4 52
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
ADDRGP4 $280
JUMPV
LABELV $279
line 604
;603:
;604:		while (*s != '\0') {
line 605
;605:			if (*s == Q_COLOR_ESCAPE && s[1] != '\0' && s[1] != '^') {
ADDRLP4 0
INDIRP4
INDIRU1
CVUI4 1
CNSTI4 94
NEI4 $282
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRU1
CVUI4 1
CNSTI4 0
EQI4 $282
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRU1
CVUI4 1
CNSTI4 94
EQI4 $282
line 607
;606:				//if ( !(options & DS_SHOW_CODE) ) {
;607:				s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 608
;608:				continue;
ADDRGP4 $280
JUMPV
LABELV $282
line 612
;609:				//}
;610:			}
;611:			//fm = &font->metrics[ *s ];
;612:			fm = &metrics[*s];
ADDRLP4 12
ADDRLP4 0
INDIRP4
INDIRU1
CVUI4 1
CNSTI4 44
MULI4
ADDRGP4 metrics
INDIRP4
ADDP4
ASGNP4
line 613
;613:			if (proportional) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $284
line 614
;614:				tc = fm->tc_prop;
ADDRLP4 4
ADDRLP4 12
INDIRP4
ASGNP4
line 615
;615:				aw1 = fm->width * aw;
ADDRLP4 28
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ASGNF4
line 616
;616:				ax += fm->space1 * aw;			// add extra space if required by metrics
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 617
;617:				x_end = ax + fm->space2 * aw;	// final position
ADDRLP4 16
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 618
;618:			} else {
ADDRGP4 $285
JUMPV
LABELV $284
line 619
;619:				tc = fm->tc_mono;
ADDRLP4 4
ADDRLP4 12
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
line 620
;620:				aw1 = aw;
ADDRLP4 28
ADDRLP4 20
INDIRF4
ASGNF4
line 621
;621:				x_end = ax + aw;
ADDRLP4 16
ADDRLP4 8
INDIRF4
ADDRLP4 20
INDIRF4
ADDF4
ASGNF4
line 622
;622:			}
LABELV $285
line 624
;623:
;624:			if (x_end > max_ax || ax >= cgs.glconfig.vidWidth)
ADDRLP4 16
INDIRF4
ADDRLP4 40
INDIRF4
GTF4 $290
ADDRLP4 8
INDIRF4
ADDRGP4 cgs+20100+11304
INDIRI4
CVIF4 4
LTF4 $286
LABELV $290
line 625
;625:				break;
ADDRGP4 $281
JUMPV
LABELV $286
line 627
;626:
;627:			trap_R_DrawStretchPic(ax + xx_add, ay + yy_add, aw1, ah, tc[0], tc[1], tc[2], tc[3], sh);
ADDRLP4 8
INDIRF4
ADDRLP4 68
INDIRF4
ADDF4
ARGF4
ADDRLP4 48
INDIRF4
ADDRLP4 72
INDIRF4
ADDF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 629
;628:
;629:			ax = x_end;
ADDRLP4 8
ADDRLP4 16
INDIRF4
ASGNF4
line 630
;630:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 631
;631:		}
LABELV $280
line 604
ADDRLP4 0
INDIRP4
INDIRU1
CVUI4 1
CNSTI4 0
NEI4 $279
LABELV $281
line 634
;632:
;633:		// recover altered parameters
;634:		s = (const byte *)string;
ADDRLP4 0
ADDRFP4 8
INDIRP4
ASGNP4
line 635
;635:		ax = xx;
ADDRLP4 8
ADDRLP4 80
INDIRF4
ASGNF4
line 636
;636:	}
LABELV $272
line 639
;637:
;638:	// select hi-res shader if accepted
;639:	for (i = 1; i < font->shaderCount; i++) {
ADDRLP4 24
CNSTI4 1
ASGNI4
ADDRGP4 $294
JUMPV
LABELV $291
line 640
;640:		if (ah >= font->shaderThreshold[i]) {
ADDRLP4 32
INDIRF4
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 font
INDIRP4
CNSTI4 11280
ADDP4
ADDP4
INDIRI4
CVIF4 4
LTF4 $295
line 641
;641:			sh = font->shader[i];
ADDRLP4 36
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 font
INDIRP4
CNSTI4 11264
ADDP4
ADDP4
INDIRI4
ASGNI4
line 642
;642:		}
LABELV $295
line 643
;643:	}
LABELV $292
line 639
ADDRLP4 24
ADDRLP4 24
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $294
ADDRLP4 24
INDIRI4
ADDRGP4 font
INDIRP4
CNSTI4 11296
ADDP4
INDIRI4
LTI4 $291
line 645
;644:
;645:	Vector4Copy(setColor, color);
ADDRLP4 84
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 52
ADDRLP4 84
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 52+4
ADDRLP4 84
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
ADDRLP4 52+8
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
ADDRLP4 52+12
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 646
;646:	trap_R_SetColor(color);
ADDRLP4 52
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
ADDRGP4 $301
JUMPV
LABELV $300
line 648
;647:
;648:	while (*s != '\0') {
line 650
;649:
;650:		if (*s == Q_COLOR_ESCAPE && s[1] != '\0' && s[1] != '^') {
ADDRLP4 0
INDIRP4
INDIRU1
CVUI4 1
CNSTI4 94
NEI4 $303
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRU1
CVUI4 1
CNSTI4 0
EQI4 $303
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRU1
CVUI4 1
CNSTI4 94
EQI4 $303
line 651
;651:			if (!(flags & DS_FORCE_COLOR)) {
ADDRFP4 28
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $305
line 652
;652:				VectorCopy(g_color_table[ColorIndex(s[1])], color);
ADDRLP4 52
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRU1
CVUI4 1
CNSTI4 48
SUBI4
CNSTI4 7
BANDI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
INDIRB
ASGNB 12
line 653
;653:				trap_R_SetColor(color);
ADDRLP4 52
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 654
;654:			}
LABELV $305
line 656
;655:			//if ( !(options & DS_SHOW_CODE) ) {
;656:			s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 657
;657:			continue;
ADDRGP4 $301
JUMPV
LABELV $303
line 662
;658:			//}
;659:		}
;660:
;661:		//fm = &font->metrics[ *s ];
;662:		fm = &metrics[*s];
ADDRLP4 12
ADDRLP4 0
INDIRP4
INDIRU1
CVUI4 1
CNSTI4 44
MULI4
ADDRGP4 metrics
INDIRP4
ADDP4
ASGNP4
line 663
;663:		if (proportional) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $307
line 664
;664:			tc = fm->tc_prop;
ADDRLP4 4
ADDRLP4 12
INDIRP4
ASGNP4
line 665
;665:			aw1 = fm->width * aw;
ADDRLP4 28
ADDRLP4 12
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ASGNF4
line 666
;666:			ax += fm->space1 * aw;			// add extra space if required by metrics
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 667
;667:			x_end = ax + fm->space2 * aw;	// final position
ADDRLP4 16
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 668
;668:		} else {
ADDRGP4 $308
JUMPV
LABELV $307
line 669
;669:			tc = fm->tc_mono;
ADDRLP4 4
ADDRLP4 12
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
line 670
;670:			aw1 = aw;
ADDRLP4 28
ADDRLP4 20
INDIRF4
ASGNF4
line 671
;671:			x_end = ax + aw;
ADDRLP4 16
ADDRLP4 8
INDIRF4
ADDRLP4 20
INDIRF4
ADDF4
ASGNF4
line 672
;672:		}
LABELV $308
line 674
;673:
;674:		if (x_end > max_ax || ax >= cgs.glconfig.vidWidth)
ADDRLP4 16
INDIRF4
ADDRLP4 40
INDIRF4
GTF4 $313
ADDRLP4 8
INDIRF4
ADDRGP4 cgs+20100+11304
INDIRI4
CVIF4 4
LTF4 $309
LABELV $313
line 675
;675:			break;
ADDRGP4 $302
JUMPV
LABELV $309
line 677
;676:
;677:		trap_R_DrawStretchPic(ax, ay, aw1, ah, tc[0], tc[1], tc[2], tc[3], sh);
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 679
;678:
;679:		ax = x_end;
ADDRLP4 8
ADDRLP4 16
INDIRF4
ASGNF4
line 680
;680:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 681
;681:	}
LABELV $301
line 648
ADDRLP4 0
INDIRP4
INDIRU1
CVUI4 1
CNSTI4 0
NEI4 $300
LABELV $302
line 684
;682:
;683:	//trap_R_SetColor( NULL );
;684:}
LABELV $257
endproc CG_DrawString 96 36
export CG_DrawStrlen
proc CG_DrawStrlen 12 0
line 729
;685:#else
;686:
;687:
;688:static float DrawStringLen(const char *s, float charWidth) {
;689:	int count;
;690:	count = 0;
;691:	while (*s) {
;692:		if (Q_IsColorString(s)) {
;693:			s += 2;
;694:		} else {
;695:			count++;
;696:			s++;
;697:		}
;698:	}
;699:	return count * charWidth;
;700:}
;701:
;702:
;703:void CG_DrawString(float x, float y, const char *s, const vec4_t color, float charWidth, float charHeight, int maxChars, int flags) {
;704:	if (!color) {
;705:		color = g_color_table[ColorIndex(COLOR_WHITE)];
;706:	}
;707:
;708:	if (flags & (DS_CENTER | DS_RIGHT)) {
;709:		float w;
;710:		w = DrawStringLen(s, charWidth);
;711:		if (flags & DS_CENTER)
;712:			x -= w * 0.5f;
;713:		else
;714:			x -= w;
;715:	}
;716:
;717:	CG_DrawStringExt(x, y, s, color, flags & DS_FORCE_COLOR, flags & DS_SHADOW, charWidth, charHeight, maxChars);
;718:}
;719:#endif
;720:
;721:
;722:/*
;723:=================
;724:CG_DrawStrlen
;725:
;726:Returns character count, skiping color escape codes
;727:=================
;728:*/
;729:int CG_DrawStrlen(const char *str) {
line 730
;730:	const char *s = str;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 731
;731:	int count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $316
JUMPV
LABELV $315
line 733
;732:
;733:	while (*s) {
line 734
;734:		if (Q_IsColorString(s)) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $318
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 94
NEI4 $318
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $318
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 94
EQI4 $318
line 735
;735:			s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 736
;736:		} else {
ADDRGP4 $319
JUMPV
LABELV $318
line 737
;737:			count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 738
;738:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 739
;739:		}
LABELV $319
line 740
;740:	}
LABELV $316
line 733
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $315
line 742
;741:
;742:	return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $314
endproc CG_DrawStrlen 12 0
proc CG_TileClearBox 16 36
line 754
;743:}
;744:
;745:
;746:/*
;747:=============
;748:CG_TileClearBox
;749:
;750:This repeats a 64*64 tile graphic to fill the screen around a sized down
;751:refresh window.
;752:=============
;753:*/
;754:static void CG_TileClearBox(int x, int y, int w, int h, qhandle_t hShader) {
line 757
;755:	float	s1, t1, s2, t2;
;756:
;757:	s1 = x / 64.0;
ADDRLP4 0
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 1015021568
MULF4
ASGNF4
line 758
;758:	t1 = y / 64.0;
ADDRLP4 4
ADDRFP4 4
INDIRI4
CVIF4 4
CNSTF4 1015021568
MULF4
ASGNF4
line 759
;759:	s2 = (x + w) / 64.0;
ADDRLP4 8
ADDRFP4 0
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
CVIF4 4
CNSTF4 1015021568
MULF4
ASGNF4
line 760
;760:	t2 = (y + h) / 64.0;
ADDRLP4 12
ADDRFP4 4
INDIRI4
ADDRFP4 12
INDIRI4
ADDI4
CVIF4 4
CNSTF4 1015021568
MULF4
ASGNF4
line 761
;761:	trap_R_DrawStretchPic(x, y, w, h, s1, t1, s2, t2, hShader);
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
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
line 762
;762:}
LABELV $320
endproc CG_TileClearBox 16 36
export CG_TileClear
proc CG_TileClear 40 20
line 772
;763:
;764:
;765:/*
;766:==============
;767:CG_TileClear
;768:
;769:Clear around a sized down screen
;770:==============
;771:*/
;772:void CG_TileClear(void) {
line 776
;773:	int		top, bottom, left, right;
;774:	int		w, h;
;775:
;776:	w = cgs.glconfig.vidWidth;
ADDRLP4 8
ADDRGP4 cgs+20100+11304
INDIRI4
ASGNI4
line 777
;777:	h = cgs.glconfig.vidHeight;
ADDRLP4 20
ADDRGP4 cgs+20100+11308
INDIRI4
ASGNI4
line 779
;778:
;779:	if (cg.refdef.x == 0 && cg.refdef.y == 0 &&
ADDRGP4 cg+109056
INDIRI4
CNSTI4 0
NEI4 $326
ADDRGP4 cg+109056+4
INDIRI4
CNSTI4 0
NEI4 $326
ADDRGP4 cg+109056+8
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $326
ADDRGP4 cg+109056+12
INDIRI4
ADDRLP4 20
INDIRI4
NEI4 $326
line 780
;780:		cg.refdef.width == w && cg.refdef.height == h) {
line 781
;781:		return;		// full screen rendering
ADDRGP4 $321
JUMPV
LABELV $326
line 784
;782:	}
;783:
;784:	top = cg.refdef.y;
ADDRLP4 0
ADDRGP4 cg+109056+4
INDIRI4
ASGNI4
line 785
;785:	bottom = top + cg.refdef.height - 1;
ADDRLP4 4
ADDRLP4 0
INDIRI4
ADDRGP4 cg+109056+12
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 786
;786:	left = cg.refdef.x;
ADDRLP4 12
ADDRGP4 cg+109056
INDIRI4
ASGNI4
line 787
;787:	right = left + cg.refdef.width - 1;
ADDRLP4 16
ADDRLP4 12
INDIRI4
ADDRGP4 cg+109056+8
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 790
;788:
;789:	// clear above view screen
;790:	CG_TileClearBox(0, 0, w, top, cgs.media.backTileShader);
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cgs+146664+380
INDIRI4
ARGI4
ADDRGP4 CG_TileClearBox
CALLV
pop
line 793
;791:
;792:	// clear below view screen
;793:	CG_TileClearBox(0, bottom, w, h - bottom, cgs.media.backTileShader);
CNSTI4 0
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ARGI4
ADDRGP4 cgs+146664+380
INDIRI4
ARGI4
ADDRGP4 CG_TileClearBox
CALLV
pop
line 796
;794:
;795:	// clear left of view screen
;796:	CG_TileClearBox(0, top, left, bottom - top + 1, cgs.media.backTileShader);
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 cgs+146664+380
INDIRI4
ARGI4
ADDRGP4 CG_TileClearBox
CALLV
pop
line 799
;797:
;798:	// clear right of view screen
;799:	CG_TileClearBox(right, top, w - right, bottom - top + 1, cgs.media.backTileShader);
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
SUBI4
ARGI4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 cgs+146664+380
INDIRI4
ARGI4
ADDRGP4 CG_TileClearBox
CALLV
pop
line 800
;800:}
LABELV $321
endproc CG_TileClear 40 20
bss
align 4
LABELV $351
skip 16
export CG_FadeColor
code
proc CG_FadeColor 8 0
line 808
;801:
;802:
;803:/*
;804:================
;805:CG_FadeColor
;806:================
;807:*/
;808:float *CG_FadeColor(int startMsec, int totalMsec) {
line 812
;809:	static vec4_t		color;
;810:	int			t;
;811:
;812:	if (startMsec == 0) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $352
line 813
;813:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $350
JUMPV
LABELV $352
line 816
;814:	}
;815:
;816:	t = cg.time - startMsec;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRI4
SUBI4
ASGNI4
line 818
;817:
;818:	if (t >= totalMsec) {
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $355
line 819
;819:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $350
JUMPV
LABELV $355
line 823
;820:	}
;821:
;822:	// fade out
;823:	if (totalMsec - t < FADE_TIME) {
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 200
GEI4 $357
line 824
;824:		color[3] = (totalMsec - t) * 1.0 / FADE_TIME;
ADDRGP4 $351+12
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1000593162
MULF4
ASGNF4
line 825
;825:	} else {
ADDRGP4 $358
JUMPV
LABELV $357
line 826
;826:		color[3] = 1.0;
ADDRGP4 $351+12
CNSTF4 1065353216
ASGNF4
line 827
;827:	}
LABELV $358
line 828
;828:	color[0] = color[1] = color[2] = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRGP4 $351+8
ADDRLP4 4
INDIRF4
ASGNF4
ADDRGP4 $351+4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRGP4 $351
ADDRLP4 4
INDIRF4
ASGNF4
line 830
;829:
;830:	return color;
ADDRGP4 $351
RETP4
LABELV $350
endproc CG_FadeColor 8 0
bss
align 4
LABELV $364
skip 16
export CG_FadeColorTime
code
proc CG_FadeColorTime 8 0
line 839
;831:}
;832:
;833:
;834:/*
;835:================
;836:CG_FadeColorTime
;837:================
;838:*/
;839:float *CG_FadeColorTime(int startMsec, int totalMsec, int fadeMsec) {
line 843
;840:	static vec4_t		color;
;841:	int			t;
;842:
;843:	if (startMsec == 0) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $365
line 844
;844:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $363
JUMPV
LABELV $365
line 847
;845:	}
;846:
;847:	t = cg.time - startMsec;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRI4
SUBI4
ASGNI4
line 849
;848:
;849:	if (t >= totalMsec) {
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $368
line 850
;850:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $363
JUMPV
LABELV $368
line 854
;851:	}
;852:
;853:	// fade out
;854:	if (totalMsec - t < fadeMsec) {
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ADDRFP4 8
INDIRI4
GEI4 $370
line 855
;855:		color[3] = (totalMsec - t) * 1.0f / (float)fadeMsec;
ADDRGP4 $364+12
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CVIF4 4
ADDRFP4 8
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 856
;856:	} else {
ADDRGP4 $371
JUMPV
LABELV $370
line 857
;857:		color[3] = 1.0f;
ADDRGP4 $364+12
CNSTF4 1065353216
ASGNF4
line 858
;858:	}
LABELV $371
line 859
;859:	color[0] = color[1] = color[2] = 1.0f;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRGP4 $364+8
ADDRLP4 4
INDIRF4
ASGNF4
ADDRGP4 $364+4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRGP4 $364
ADDRLP4 4
INDIRF4
ASGNF4
line 861
;860:
;861:	return color;
ADDRGP4 $364
RETP4
LABELV $363
endproc CG_FadeColorTime 8 0
data
align 4
LABELV $377
byte 4 1065353216
byte 4 1045220557
byte 4 1045220557
byte 4 1065353216
align 4
LABELV $378
byte 4 1045220557
byte 4 1045220557
byte 4 1065353216
byte 4 1065353216
align 4
LABELV $379
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
align 4
LABELV $380
byte 4 1060320051
byte 4 1060320051
byte 4 1060320051
byte 4 1065353216
export CG_TeamColor
code
proc CG_TeamColor 8 0
line 870
;862:}
;863:
;864:
;865:/*
;866:================
;867:CG_TeamColor
;868:================
;869:*/
;870:const float *CG_TeamColor(team_t team) {
line 876
;871:	static vec4_t	red = { 1, 0.2f, 0.2f, 1 };
;872:	static vec4_t	blue = { 0.2f, 0.2f, 1, 1 };
;873:	static vec4_t	other = { 1, 1, 1, 1 };
;874:	static vec4_t	spectator = { 0.7f, 0.7f, 0.7f, 1 };
;875:
;876:	switch (team) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $384
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $385
ADDRLP4 0
INDIRI4
CNSTI4 3
EQI4 $386
ADDRGP4 $381
JUMPV
LABELV $384
line 878
;877:	case TEAM_RED:
;878:		return red;
ADDRGP4 $377
RETP4
ADDRGP4 $376
JUMPV
LABELV $385
line 880
;879:	case TEAM_BLUE:
;880:		return blue;
ADDRGP4 $378
RETP4
ADDRGP4 $376
JUMPV
LABELV $386
line 882
;881:	case TEAM_SPECTATOR:
;882:		return spectator;
ADDRGP4 $380
RETP4
ADDRGP4 $376
JUMPV
LABELV $381
line 884
;883:	default:
;884:		return other;
ADDRGP4 $379
RETP4
LABELV $376
endproc CG_TeamColor 8 0
export CG_GetColorForHealth
proc CG_GetColorForHealth 8 0
line 895
;885:	}
;886:}
;887:
;888:
;889:
;890:/*
;891:=================
;892:CG_GetColorForHealth
;893:=================
;894:*/
;895:void CG_GetColorForHealth(int health, int armor, vec4_t hcolor) {
line 901
;896:	int		count;
;897:	int		max;
;898:
;899:	// calculate the total points of damage that can
;900:	// be sustained at the current health / armor level
;901:	if (health <= 0) {
ADDRFP4 0
INDIRI4
CNSTI4 0
GTI4 $388
line 902
;902:		VectorClear(hcolor);	// black
ADDRFP4 8
INDIRP4
CNSTF4 0
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
line 903
;903:		hcolor[3] = 1;
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1065353216
ASGNF4
line 904
;904:		return;
ADDRGP4 $387
JUMPV
LABELV $388
line 906
;905:	}
;906:	count = armor;
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
line 907
;907:	max = health * ARMOR_PROTECTION / (1.0 - ARMOR_PROTECTION);
ADDRLP4 4
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 1073248376
MULF4
CVFI4 4
ASGNI4
line 908
;908:	if (max < count) {
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
GEI4 $390
line 909
;909:		count = max;
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 910
;910:	}
LABELV $390
line 911
;911:	health += count;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 914
;912:
;913:	// set the color based on health
;914:	hcolor[0] = 1.0;
ADDRFP4 8
INDIRP4
CNSTF4 1065353216
ASGNF4
line 915
;915:	hcolor[3] = 1.0;
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1065353216
ASGNF4
line 916
;916:	if (health >= 100) {
ADDRFP4 0
INDIRI4
CNSTI4 100
LTI4 $392
line 917
;917:		hcolor[2] = 1.0;
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1065353216
ASGNF4
line 918
;918:	} else if (health < 66) {
ADDRGP4 $393
JUMPV
LABELV $392
ADDRFP4 0
INDIRI4
CNSTI4 66
GEI4 $394
line 919
;919:		hcolor[2] = 0;
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
line 920
;920:	} else {
ADDRGP4 $395
JUMPV
LABELV $394
line 921
;921:		hcolor[2] = (health - 66) / 33.0;
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 0
INDIRI4
CNSTI4 66
SUBI4
CVIF4 4
CNSTF4 1022901776
MULF4
ASGNF4
line 922
;922:	}
LABELV $395
LABELV $393
line 924
;923:
;924:	if (health > 60) {
ADDRFP4 0
INDIRI4
CNSTI4 60
LEI4 $396
line 925
;925:		hcolor[1] = 1.0;
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1065353216
ASGNF4
line 926
;926:	} else if (health < 30) {
ADDRGP4 $397
JUMPV
LABELV $396
ADDRFP4 0
INDIRI4
CNSTI4 30
GEI4 $398
line 927
;927:		hcolor[1] = 0;
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
line 928
;928:	} else {
ADDRGP4 $399
JUMPV
LABELV $398
line 929
;929:		hcolor[1] = (health - 30) / 30.0;
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRI4
CNSTI4 30
SUBI4
CVIF4 4
CNSTF4 1023969417
MULF4
ASGNF4
line 930
;930:	}
LABELV $399
LABELV $397
line 931
;931:}
LABELV $387
endproc CG_GetColorForHealth 8 0
export CG_ColorForHealth
proc CG_ColorForHealth 0 12
line 939
;932:
;933:
;934:/*
;935:=================
;936:CG_ColorForHealth
;937:=================
;938:*/
;939:void CG_ColorForHealth(vec4_t hcolor) {
line 941
;940:
;941:	CG_GetColorForHealth(cg.snap->ps.stats[STAT_HEALTH],
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_GetColorForHealth
CALLV
pop
line 943
;942:		cg.snap->ps.stats[STAT_ARMOR], hcolor);
;943:}
LABELV $400
endproc CG_ColorForHealth 0 12
data
align 4
LABELV propMap
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 8
byte 4 11
byte 4 122
byte 4 7
byte 4 154
byte 4 181
byte 4 14
byte 4 55
byte 4 122
byte 4 17
byte 4 79
byte 4 122
byte 4 18
byte 4 101
byte 4 122
byte 4 23
byte 4 153
byte 4 122
byte 4 18
byte 4 9
byte 4 93
byte 4 7
byte 4 207
byte 4 122
byte 4 8
byte 4 230
byte 4 122
byte 4 9
byte 4 177
byte 4 122
byte 4 18
byte 4 30
byte 4 152
byte 4 18
byte 4 85
byte 4 181
byte 4 7
byte 4 34
byte 4 93
byte 4 11
byte 4 110
byte 4 181
byte 4 6
byte 4 130
byte 4 152
byte 4 14
byte 4 22
byte 4 64
byte 4 17
byte 4 41
byte 4 64
byte 4 12
byte 4 58
byte 4 64
byte 4 17
byte 4 78
byte 4 64
byte 4 18
byte 4 98
byte 4 64
byte 4 19
byte 4 120
byte 4 64
byte 4 18
byte 4 141
byte 4 64
byte 4 18
byte 4 204
byte 4 64
byte 4 16
byte 4 162
byte 4 64
byte 4 17
byte 4 182
byte 4 64
byte 4 18
byte 4 59
byte 4 181
byte 4 7
byte 4 35
byte 4 181
byte 4 7
byte 4 203
byte 4 152
byte 4 14
byte 4 56
byte 4 93
byte 4 14
byte 4 228
byte 4 152
byte 4 14
byte 4 177
byte 4 181
byte 4 18
byte 4 28
byte 4 122
byte 4 22
byte 4 5
byte 4 4
byte 4 18
byte 4 27
byte 4 4
byte 4 18
byte 4 48
byte 4 4
byte 4 18
byte 4 69
byte 4 4
byte 4 17
byte 4 90
byte 4 4
byte 4 13
byte 4 106
byte 4 4
byte 4 13
byte 4 121
byte 4 4
byte 4 18
byte 4 143
byte 4 4
byte 4 17
byte 4 164
byte 4 4
byte 4 8
byte 4 175
byte 4 4
byte 4 16
byte 4 195
byte 4 4
byte 4 18
byte 4 216
byte 4 4
byte 4 12
byte 4 230
byte 4 4
byte 4 23
byte 4 6
byte 4 34
byte 4 18
byte 4 27
byte 4 34
byte 4 18
byte 4 48
byte 4 34
byte 4 18
byte 4 68
byte 4 34
byte 4 18
byte 4 90
byte 4 34
byte 4 17
byte 4 110
byte 4 34
byte 4 18
byte 4 130
byte 4 34
byte 4 14
byte 4 146
byte 4 34
byte 4 18
byte 4 166
byte 4 34
byte 4 19
byte 4 185
byte 4 34
byte 4 29
byte 4 215
byte 4 34
byte 4 18
byte 4 234
byte 4 34
byte 4 18
byte 4 5
byte 4 64
byte 4 14
byte 4 60
byte 4 152
byte 4 7
byte 4 106
byte 4 151
byte 4 13
byte 4 83
byte 4 152
byte 4 7
byte 4 128
byte 4 122
byte 4 17
byte 4 4
byte 4 152
byte 4 21
byte 4 134
byte 4 181
byte 4 5
byte 4 5
byte 4 4
byte 4 18
byte 4 27
byte 4 4
byte 4 18
byte 4 48
byte 4 4
byte 4 18
byte 4 69
byte 4 4
byte 4 17
byte 4 90
byte 4 4
byte 4 13
byte 4 106
byte 4 4
byte 4 13
byte 4 121
byte 4 4
byte 4 18
byte 4 143
byte 4 4
byte 4 17
byte 4 164
byte 4 4
byte 4 8
byte 4 175
byte 4 4
byte 4 16
byte 4 195
byte 4 4
byte 4 18
byte 4 216
byte 4 4
byte 4 12
byte 4 230
byte 4 4
byte 4 23
byte 4 6
byte 4 34
byte 4 18
byte 4 27
byte 4 34
byte 4 18
byte 4 48
byte 4 34
byte 4 18
byte 4 68
byte 4 34
byte 4 18
byte 4 90
byte 4 34
byte 4 17
byte 4 110
byte 4 34
byte 4 18
byte 4 130
byte 4 34
byte 4 14
byte 4 146
byte 4 34
byte 4 18
byte 4 166
byte 4 34
byte 4 19
byte 4 185
byte 4 34
byte 4 29
byte 4 215
byte 4 34
byte 4 18
byte 4 234
byte 4 34
byte 4 18
byte 4 5
byte 4 64
byte 4 14
byte 4 153
byte 4 152
byte 4 13
byte 4 11
byte 4 181
byte 4 5
byte 4 180
byte 4 152
byte 4 13
byte 4 79
byte 4 93
byte 4 17
byte 4 0
byte 4 0
byte 4 -1
align 4
LABELV propMapB
byte 4 11
byte 4 12
byte 4 33
byte 4 49
byte 4 12
byte 4 31
byte 4 85
byte 4 12
byte 4 31
byte 4 120
byte 4 12
byte 4 30
byte 4 156
byte 4 12
byte 4 21
byte 4 183
byte 4 12
byte 4 21
byte 4 207
byte 4 12
byte 4 32
byte 4 13
byte 4 55
byte 4 30
byte 4 49
byte 4 55
byte 4 13
byte 4 66
byte 4 55
byte 4 29
byte 4 101
byte 4 55
byte 4 31
byte 4 135
byte 4 55
byte 4 21
byte 4 158
byte 4 55
byte 4 40
byte 4 204
byte 4 55
byte 4 32
byte 4 12
byte 4 97
byte 4 31
byte 4 48
byte 4 97
byte 4 31
byte 4 82
byte 4 97
byte 4 30
byte 4 118
byte 4 97
byte 4 30
byte 4 153
byte 4 97
byte 4 30
byte 4 185
byte 4 97
byte 4 25
byte 4 213
byte 4 97
byte 4 30
byte 4 11
byte 4 139
byte 4 32
byte 4 42
byte 4 139
byte 4 51
byte 4 93
byte 4 139
byte 4 32
byte 4 126
byte 4 139
byte 4 31
byte 4 158
byte 4 139
byte 4 25
code
proc UI_DrawBannerString2 52 36
line 1107
;944:
;945:
;946:
;947:// bk001205 - code below duplicated in ui/ui-atoms.c
;948:// bk001205 - FIXME: does this belong in ui_shared.c?
;949:// bk001205 - FIXME: HARD_LINKED flags not visible here
;950:#ifndef Q3_STATIC // bk001205 - q_shared defines not visible here 
;951:/*
;952:=================
;953:UI_DrawProportionalString2
;954:=================
;955:*/
;956:static int	propMap[128][3] = {
;957:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;958:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;959:
;960:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;961:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;962:
;963:{0, 0, PROP_SPACE_WIDTH},		// SPACE
;964:{11, 122, 7},	// !
;965:{154, 181, 14},	// "
;966:{55, 122, 17},	// #
;967:{79, 122, 18},	// $
;968:{101, 122, 23},	// %
;969:{153, 122, 18},	// &
;970:{9, 93, 7},		// '
;971:{207, 122, 8},	// (
;972:{230, 122, 9},	// )
;973:{177, 122, 18},	// *
;974:{30, 152, 18},	// +
;975:{85, 181, 7},	// ,
;976:{34, 93, 11},	// -
;977:{110, 181, 6},	// .
;978:{130, 152, 14},	// /
;979:
;980:{22, 64, 17},	// 0
;981:{41, 64, 12},	// 1
;982:{58, 64, 17},	// 2
;983:{78, 64, 18},	// 3
;984:{98, 64, 19},	// 4
;985:{120, 64, 18},	// 5
;986:{141, 64, 18},	// 6
;987:{204, 64, 16},	// 7
;988:{162, 64, 17},	// 8
;989:{182, 64, 18},	// 9
;990:{59, 181, 7},	// :
;991:{35,181, 7},	// ;
;992:{203, 152, 14},	// <
;993:{56, 93, 14},	// =
;994:{228, 152, 14},	// >
;995:{177, 181, 18},	// ?
;996:
;997:{28, 122, 22},	// @
;998:{5, 4, 18},		// A
;999:{27, 4, 18},	// B
;1000:{48, 4, 18},	// C
;1001:{69, 4, 17},	// D
;1002:{90, 4, 13},	// E
;1003:{106, 4, 13},	// F
;1004:{121, 4, 18},	// G
;1005:{143, 4, 17},	// H
;1006:{164, 4, 8},	// I
;1007:{175, 4, 16},	// J
;1008:{195, 4, 18},	// K
;1009:{216, 4, 12},	// L
;1010:{230, 4, 23},	// M
;1011:{6, 34, 18},	// N
;1012:{27, 34, 18},	// O
;1013:
;1014:{48, 34, 18},	// P
;1015:{68, 34, 18},	// Q
;1016:{90, 34, 17},	// R
;1017:{110, 34, 18},	// S
;1018:{130, 34, 14},	// T
;1019:{146, 34, 18},	// U
;1020:{166, 34, 19},	// V
;1021:{185, 34, 29},	// W
;1022:{215, 34, 18},	// X
;1023:{234, 34, 18},	// Y
;1024:{5, 64, 14},	// Z
;1025:{60, 152, 7},	// [
;1026:{106, 151, 13},	// '\'
;1027:{83, 152, 7},	// ]
;1028:{128, 122, 17},	// ^
;1029:{4, 152, 21},	// _
;1030:
;1031:{134, 181, 5},	// '
;1032:{5, 4, 18},		// A
;1033:{27, 4, 18},	// B
;1034:{48, 4, 18},	// C
;1035:{69, 4, 17},	// D
;1036:{90, 4, 13},	// E
;1037:{106, 4, 13},	// F
;1038:{121, 4, 18},	// G
;1039:{143, 4, 17},	// H
;1040:{164, 4, 8},	// I
;1041:{175, 4, 16},	// J
;1042:{195, 4, 18},	// K
;1043:{216, 4, 12},	// L
;1044:{230, 4, 23},	// M
;1045:{6, 34, 18},	// N
;1046:{27, 34, 18},	// O
;1047:
;1048:{48, 34, 18},	// P
;1049:{68, 34, 18},	// Q
;1050:{90, 34, 17},	// R
;1051:{110, 34, 18},	// S
;1052:{130, 34, 14},	// T
;1053:{146, 34, 18},	// U
;1054:{166, 34, 19},	// V
;1055:{185, 34, 29},	// W
;1056:{215, 34, 18},	// X
;1057:{234, 34, 18},	// Y
;1058:{5, 64, 14},	// Z
;1059:{153, 152, 13},	// {
;1060:{11, 181, 5},	// |
;1061:{180, 152, 13},	// }
;1062:{79, 93, 17},	// ~
;1063:{0, 0, -1}		// DEL
;1064:};
;1065:
;1066:static int propMapB[26][3] = {
;1067:{11, 12, 33},
;1068:{49, 12, 31},
;1069:{85, 12, 31},
;1070:{120, 12, 30},
;1071:{156, 12, 21},
;1072:{183, 12, 21},
;1073:{207, 12, 32},
;1074:
;1075:{13, 55, 30},
;1076:{49, 55, 13},
;1077:{66, 55, 29},
;1078:{101, 55, 31},
;1079:{135, 55, 21},
;1080:{158, 55, 40},
;1081:{204, 55, 32},
;1082:
;1083:{12, 97, 31},
;1084:{48, 97, 31},
;1085:{82, 97, 30},
;1086:{118, 97, 30},
;1087:{153, 97, 30},
;1088:{185, 97, 25},
;1089:{213, 97, 30},
;1090:
;1091:{11, 139, 32},
;1092:{42, 139, 51},
;1093:{93, 139, 32},
;1094:{126, 139, 31},
;1095:{158, 139, 25},
;1096:};
;1097:
;1098:#define PROPB_GAP_WIDTH		4
;1099:#define PROPB_SPACE_WIDTH	12
;1100:#define PROPB_HEIGHT		36
;1101:
;1102:/*
;1103:=================
;1104:UI_DrawBannerString
;1105:=================
;1106:*/
;1107:static void UI_DrawBannerString2(int x, int y, const char *str, vec4_t color) {
line 1120
;1108:	const char *s;
;1109:	unsigned char	ch; // bk001204 : array subscript
;1110:	float	ax;
;1111:	float	ay;
;1112:	float	aw;
;1113:	float	ah;
;1114:	float	frow;
;1115:	float	fcol;
;1116:	float	fwidth;
;1117:	float	fheight;
;1118:
;1119:	// draw the colored text
;1120:	trap_R_SetColor(color);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1122
;1121:
;1122:	ax = x * cgs.screenXScale + cgs.screenXBias;
ADDRLP4 8
ADDRFP4 0
INDIRI4
CVIF4 4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDRGP4 cgs+31444
INDIRF4
ADDF4
ASGNF4
line 1123
;1123:	ay = y * cgs.screenYScale + cgs.screenYBias;
ADDRLP4 36
ADDRFP4 4
INDIRI4
CVIF4 4
ADDRGP4 cgs+31436
INDIRF4
MULF4
ADDRGP4 cgs+31448
INDIRF4
ADDF4
ASGNF4
line 1125
;1124:
;1125:	s = str;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
ADDRGP4 $409
JUMPV
LABELV $408
line 1126
;1126:	while (*s) {
line 1127
;1127:		ch = *s & 127;
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 1128
;1128:		if (ch == ' ') {
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 32
NEI4 $411
line 1129
;1129:			ax += ((float)PROPB_SPACE_WIDTH + (float)PROPB_GAP_WIDTH) * cgs.screenXScale;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
CNSTF4 1098907648
MULF4
ADDF4
ASGNF4
line 1130
;1130:		} else if (ch >= 'A' && ch <= 'Z') {
ADDRGP4 $412
JUMPV
LABELV $411
ADDRLP4 40
ADDRLP4 0
INDIRU1
CVUI4 1
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 65
LTI4 $414
ADDRLP4 40
INDIRI4
CNSTI4 90
GTI4 $414
line 1131
;1131:			ch -= 'A';
ADDRLP4 0
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 65
SUBI4
CVIU4 4
CVUU1 4
ASGNU1
line 1132
;1132:			fcol = (float)propMapB[ch][0] / 256.0f;
ADDRLP4 20
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMapB
ADDP4
INDIRI4
CVIF4 4
CNSTF4 998244352
MULF4
ASGNF4
line 1133
;1133:			frow = (float)propMapB[ch][1] / 256.0f;
ADDRLP4 16
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMapB+4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 998244352
MULF4
ASGNF4
line 1134
;1134:			fwidth = (float)propMapB[ch][2] / 256.0f;
ADDRLP4 28
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMapB+8
ADDP4
INDIRI4
CVIF4 4
CNSTF4 998244352
MULF4
ASGNF4
line 1135
;1135:			fheight = (float)PROPB_HEIGHT / 256.0f;
ADDRLP4 32
CNSTF4 1041235968
ASGNF4
line 1136
;1136:			aw = (float)propMapB[ch][2] * cgs.screenXScale;
ADDRLP4 12
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMapB+8
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 1137
;1137:			ah = (float)PROPB_HEIGHT * cgs.screenXScale;
ADDRLP4 24
ADDRGP4 cgs+31432
INDIRF4
CNSTF4 1108344832
MULF4
ASGNF4
line 1138
;1138:			trap_R_DrawStretchPic(ax, ay, aw, ah, fcol, frow, fcol + fwidth, frow + fheight, cgs.media.charsetPropB);
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ADDRLP4 28
INDIRF4
ADDF4
ARGF4
ADDRLP4 16
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ARGF4
ADDRGP4 cgs+146664+12
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1139
;1139:			ax += (aw + (float)PROPB_GAP_WIDTH * cgs.screenXScale);
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
CNSTF4 1082130432
MULF4
ADDF4
ADDF4
ASGNF4
line 1140
;1140:		}
LABELV $414
LABELV $412
line 1141
;1141:		s++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1142
;1142:	}
LABELV $409
line 1126
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $408
line 1144
;1143:
;1144:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1145
;1145:}
LABELV $403
endproc UI_DrawBannerString2 52 36
export UI_DrawBannerString
proc UI_DrawBannerString 40 16
line 1147
;1146:
;1147:void UI_DrawBannerString(int x, int y, const char *str, int style, vec4_t color) {
line 1154
;1148:	const char *s;
;1149:	int				ch;
;1150:	int				width;
;1151:	vec4_t			drawcolor;
;1152:
;1153:	// find the width of the drawn text
;1154:	s = str;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
line 1155
;1155:	width = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $426
JUMPV
LABELV $425
line 1156
;1156:	while (*s) {
line 1157
;1157:		ch = *s;
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 1158
;1158:		if (ch == ' ') {
ADDRLP4 0
INDIRI4
CNSTI4 32
NEI4 $428
line 1159
;1159:			width += PROPB_SPACE_WIDTH;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 12
ADDI4
ASGNI4
line 1160
;1160:		} else if (ch >= 'A' && ch <= 'Z') {
ADDRGP4 $429
JUMPV
LABELV $428
ADDRLP4 0
INDIRI4
CNSTI4 65
LTI4 $430
ADDRLP4 0
INDIRI4
CNSTI4 90
GTI4 $430
line 1161
;1161:			width += propMapB[ch - 'A'][2] + PROPB_GAP_WIDTH;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 propMapB-780+8
ADDP4
INDIRI4
CNSTI4 4
ADDI4
ADDI4
ASGNI4
line 1162
;1162:		}
LABELV $430
LABELV $429
line 1163
;1163:		s++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1164
;1164:	}
LABELV $426
line 1156
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $425
line 1165
;1165:	width -= PROPB_GAP_WIDTH;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 4
SUBI4
ASGNI4
line 1167
;1166:
;1167:	switch (style & UI_FORMATMASK) {
ADDRLP4 28
ADDRFP4 12
INDIRI4
CNSTI4 7
BANDI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $435
ADDRLP4 28
INDIRI4
CNSTI4 1
EQI4 $437
ADDRLP4 28
INDIRI4
CNSTI4 2
EQI4 $438
ADDRGP4 $435
JUMPV
LABELV $437
line 1169
;1168:	case UI_CENTER:
;1169:		x -= width / 2;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
line 1170
;1170:		break;
ADDRGP4 $435
JUMPV
LABELV $438
line 1173
;1171:
;1172:	case UI_RIGHT:
;1173:		x -= width;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1174
;1174:		break;
line 1178
;1175:
;1176:	case UI_LEFT:
;1177:	default:
;1178:		break;
LABELV $435
line 1181
;1179:	}
;1180:
;1181:	if (style & UI_DROPSHADOW) {
ADDRFP4 12
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $440
line 1182
;1182:		drawcolor[0] = drawcolor[1] = drawcolor[2] = 0;
ADDRLP4 36
CNSTF4 0
ASGNF4
ADDRLP4 12+8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 36
INDIRF4
ASGNF4
line 1183
;1183:		drawcolor[3] = color[3];
ADDRLP4 12+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 1184
;1184:		UI_DrawBannerString2(x + 2, y + 2, str, drawcolor);
ADDRFP4 0
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 UI_DrawBannerString2
CALLV
pop
line 1185
;1185:	}
LABELV $440
line 1187
;1186:
;1187:	UI_DrawBannerString2(x, y, str, color);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 UI_DrawBannerString2
CALLV
pop
line 1188
;1188:}
LABELV $424
endproc UI_DrawBannerString 40 16
export UI_ProportionalStringWidth
proc UI_ProportionalStringWidth 16 0
line 1191
;1189:
;1190:
;1191:int UI_ProportionalStringWidth(const char *str) {
line 1197
;1192:	const char *s;
;1193:	int				ch;
;1194:	int				charWidth;
;1195:	int				width;
;1196:
;1197:	s = str;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 1198
;1198:	width = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $447
JUMPV
LABELV $446
line 1199
;1199:	while (*s) {
line 1200
;1200:		ch = *s & 127;
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
ASGNI4
line 1201
;1201:		charWidth = propMap[ch][2];
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 propMap+8
ADDP4
INDIRI4
ASGNI4
line 1202
;1202:		if (charWidth != -1) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $450
line 1203
;1203:			width += charWidth;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1204
;1204:			width += PROP_GAP_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 3
ADDI4
ASGNI4
line 1205
;1205:		}
LABELV $450
line 1206
;1206:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1207
;1207:	}
LABELV $447
line 1199
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $446
line 1209
;1208:
;1209:	width -= PROP_GAP_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 3
SUBI4
ASGNI4
line 1210
;1210:	return width;
ADDRLP4 12
INDIRI4
RETI4
LABELV $445
endproc UI_ProportionalStringWidth 16 0
proc UI_DrawProportionalString2 48 36
line 1213
;1211:}
;1212:
;1213:static void UI_DrawProportionalString2(int x, int y, const char *str, vec4_t color, float sizeScale, qhandle_t charset) {
line 1226
;1214:	const char *s;
;1215:	unsigned char	ch; // bk001204 - unsigned
;1216:	float	ax;
;1217:	float	ay;
;1218:	float	aw;
;1219:	float	ah;
;1220:	float	frow;
;1221:	float	fcol;
;1222:	float	fwidth;
;1223:	float	fheight;
;1224:
;1225:	// draw the colored text
;1226:	trap_R_SetColor(color);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1228
;1227:
;1228:	ax = x * cgs.screenXScale + cgs.screenXBias;
ADDRLP4 12
ADDRFP4 0
INDIRI4
CVIF4 4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDRGP4 cgs+31444
INDIRF4
ADDF4
ASGNF4
line 1229
;1229:	ay = y * cgs.screenYScale + cgs.screenYBias;
ADDRLP4 36
ADDRFP4 4
INDIRI4
CVIF4 4
ADDRGP4 cgs+31436
INDIRF4
MULF4
ADDRGP4 cgs+31448
INDIRF4
ADDF4
ASGNF4
line 1231
;1230:
;1231:	s = str;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
ADDRGP4 $458
JUMPV
LABELV $457
line 1232
;1232:	while (*s) {
line 1233
;1233:		ch = *s & 127;
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 1234
;1234:		if (ch == ' ') {
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 32
NEI4 $460
line 1235
;1235:			aw = (float)PROP_SPACE_WIDTH * cgs.screenXScale * sizeScale;
ADDRLP4 8
ADDRGP4 cgs+31432
INDIRF4
CNSTF4 1090519040
MULF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 1236
;1236:		} else if (propMap[ch][2] != -1) {
ADDRGP4 $461
JUMPV
LABELV $460
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMap+8
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $463
line 1237
;1237:			fcol = (float)propMap[ch][0] / 256.0f;
ADDRLP4 20
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMap
ADDP4
INDIRI4
CVIF4 4
CNSTF4 998244352
MULF4
ASGNF4
line 1238
;1238:			frow = (float)propMap[ch][1] / 256.0f;
ADDRLP4 16
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMap+4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 998244352
MULF4
ASGNF4
line 1239
;1239:			fwidth = (float)propMap[ch][2] / 256.0f;
ADDRLP4 28
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMap+8
ADDP4
INDIRI4
CVIF4 4
CNSTF4 998244352
MULF4
ASGNF4
line 1240
;1240:			fheight = (float)PROP_HEIGHT / 256.0f;
ADDRLP4 32
CNSTF4 1037565952
ASGNF4
line 1241
;1241:			aw = (float)propMap[ch][2] * cgs.screenXScale * sizeScale;
ADDRLP4 8
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 12
MULI4
ADDRGP4 propMap+8
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 1242
;1242:			ah = (float)PROP_HEIGHT * cgs.screenXScale * sizeScale;
ADDRLP4 24
ADDRGP4 cgs+31432
INDIRF4
CNSTF4 1104674816
MULF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 1243
;1243:			trap_R_DrawStretchPic(ax, ay, aw, ah, fcol, frow, fcol + fwidth, frow + fheight, charset);
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ADDRLP4 28
INDIRF4
ADDF4
ARGF4
ADDRLP4 16
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ARGF4
ADDRFP4 20
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1244
;1244:		} else {
ADDRGP4 $464
JUMPV
LABELV $463
line 1245
;1245:			aw = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 1246
;1246:		}
LABELV $464
LABELV $461
line 1248
;1247:
;1248:		ax += (aw + (float)PROP_GAP_WIDTH * cgs.screenXScale * sizeScale);
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
CNSTF4 1077936128
MULF4
ADDRFP4 16
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 1249
;1249:		s++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1250
;1250:	}
LABELV $458
line 1232
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $457
line 1252
;1251:
;1252:	trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1253
;1253:}
LABELV $452
endproc UI_DrawProportionalString2 48 36
export UI_ProportionalSizeScale
proc UI_ProportionalSizeScale 0 0
line 1260
;1254:
;1255:/*
;1256:=================
;1257:UI_ProportionalSizeScale
;1258:=================
;1259:*/
;1260:float UI_ProportionalSizeScale(int style) {
line 1261
;1261:	if (style & UI_SMALLFONT) {
ADDRFP4 0
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $473
line 1262
;1262:		return 0.75;
CNSTF4 1061158912
RETF4
ADDRGP4 $472
JUMPV
LABELV $473
line 1265
;1263:	}
;1264:
;1265:	return 1.00;
CNSTF4 1065353216
RETF4
LABELV $472
endproc UI_ProportionalSizeScale 0 0
export UI_DrawProportionalString
proc UI_DrawProportionalString 44 24
line 1274
;1266:}
;1267:
;1268:
;1269:/*
;1270:=================
;1271:UI_DrawProportionalString
;1272:=================
;1273:*/
;1274:void UI_DrawProportionalString(int x, int y, const char *str, int style, vec4_t color) {
line 1279
;1275:	vec4_t	drawcolor;
;1276:	int		width;
;1277:	float	sizeScale;
;1278:
;1279:	sizeScale = UI_ProportionalSizeScale(style);
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 UI_ProportionalSizeScale
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 24
INDIRF4
ASGNF4
line 1281
;1280:
;1281:	switch (style & UI_FORMATMASK) {
ADDRLP4 28
ADDRFP4 12
INDIRI4
CNSTI4 7
BANDI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $477
ADDRLP4 28
INDIRI4
CNSTI4 1
EQI4 $479
ADDRLP4 28
INDIRI4
CNSTI4 2
EQI4 $480
ADDRGP4 $477
JUMPV
LABELV $479
line 1283
;1282:	case UI_CENTER:
;1283:		width = UI_ProportionalStringWidth(str) * sizeScale;
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 UI_ProportionalStringWidth
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 36
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1284
;1284:		x -= width / 2;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 20
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
line 1285
;1285:		break;
ADDRGP4 $477
JUMPV
LABELV $480
line 1288
;1286:
;1287:	case UI_RIGHT:
;1288:		width = UI_ProportionalStringWidth(str) * sizeScale;
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 UI_ProportionalStringWidth
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 40
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 1289
;1289:		x -= width;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1290
;1290:		break;
line 1294
;1291:
;1292:	case UI_LEFT:
;1293:	default:
;1294:		break;
LABELV $477
line 1297
;1295:	}
;1296:
;1297:	if (style & UI_DROPSHADOW) {
ADDRFP4 12
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $482
line 1298
;1298:		drawcolor[0] = drawcolor[1] = drawcolor[2] = 0;
ADDRLP4 36
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 36
INDIRF4
ASGNF4
line 1299
;1299:		drawcolor[3] = color[3];
ADDRLP4 0+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 1300
;1300:		UI_DrawProportionalString2(x + 2, y + 2, str, drawcolor, sizeScale, cgs.media.charsetProp);
ADDRFP4 0
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
ADDI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cgs+146664+4
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 1301
;1301:	}
LABELV $482
line 1303
;1302:
;1303:	if (style & UI_INVERSE) {
ADDRFP4 12
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $489
line 1304
;1304:		drawcolor[0] = color[0] * 0.8;
ADDRLP4 0
ADDRFP4 16
INDIRP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 1305
;1305:		drawcolor[1] = color[1] * 0.8;
ADDRLP4 0+4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 1306
;1306:		drawcolor[2] = color[2] * 0.8;
ADDRLP4 0+8
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 1307
;1307:		drawcolor[3] = color[3];
ADDRLP4 0+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 1308
;1308:		UI_DrawProportionalString2(x, y, str, drawcolor, sizeScale, cgs.media.charsetProp);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cgs+146664+4
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 1309
;1309:		return;
ADDRGP4 $475
JUMPV
LABELV $489
line 1312
;1310:	}
;1311:
;1312:	if (style & UI_PULSE) {
ADDRFP4 12
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $496
line 1313
;1313:		drawcolor[0] = color[0] * 0.8;
ADDRLP4 0
ADDRFP4 16
INDIRP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 1314
;1314:		drawcolor[1] = color[1] * 0.8;
ADDRLP4 0+4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 1315
;1315:		drawcolor[2] = color[2] * 0.8;
ADDRLP4 0+8
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 1316
;1316:		drawcolor[3] = color[3];
ADDRLP4 0+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 1317
;1317:		UI_DrawProportionalString2(x, y, str, color, sizeScale, cgs.media.charsetProp);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cgs+146664+4
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 1319
;1318:
;1319:		drawcolor[0] = color[0];
ADDRLP4 0
ADDRFP4 16
INDIRP4
INDIRF4
ASGNF4
line 1320
;1320:		drawcolor[1] = color[1];
ADDRLP4 0+4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1321
;1321:		drawcolor[2] = color[2];
ADDRLP4 0+8
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 1322
;1322:		drawcolor[3] = 0.5 + 0.5 * sin((cg.time % TMOD_075) / PULSE_DIVISOR);
ADDRGP4 cg+107604
INDIRI4
CNSTI4 2292106
MODI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 36
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0+12
ADDRLP4 36
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 1323
;1323:		UI_DrawProportionalString2(x, y, str, drawcolor, sizeScale, cgs.media.charsetPropGlow);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cgs+146664+8
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 1324
;1324:		return;
ADDRGP4 $475
JUMPV
LABELV $496
line 1327
;1325:	}
;1326:
;1327:	UI_DrawProportionalString2(x, y, str, color, sizeScale, cgs.media.charsetProp);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cgs+146664+4
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 1328
;1328:}
LABELV $475
endproc UI_DrawProportionalString 44 24
bss
align 4
LABELV numbers
skip 11300
align 4
LABELV bigchars
skip 11300
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
import CG_PainEvent
import CG_EntityEvent
import CG_PlaceString
import CG_CheckEvents
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
LABELV $244
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $243
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 98
byte 1 105
byte 1 103
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 115
byte 1 46
byte 1 99
byte 1 102
byte 1 103
byte 1 0
align 1
LABELV $241
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 115
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 105
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $222
byte 1 94
byte 1 49
byte 1 67
byte 1 71
byte 1 95
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 99
byte 1 101
byte 1 50
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $219
byte 1 94
byte 1 49
byte 1 67
byte 1 71
byte 1 95
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 115
byte 1 112
byte 1 97
byte 1 99
byte 1 101
byte 1 49
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $216
byte 1 94
byte 1 49
byte 1 67
byte 1 71
byte 1 95
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 120
byte 1 45
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $213
byte 1 94
byte 1 49
byte 1 67
byte 1 71
byte 1 95
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 120
byte 1 45
byte 1 111
byte 1 102
byte 1 102
byte 1 115
byte 1 101
byte 1 116
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $210
byte 1 94
byte 1 49
byte 1 67
byte 1 71
byte 1 95
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 121
byte 1 48
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $207
byte 1 94
byte 1 49
byte 1 67
byte 1 71
byte 1 95
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 120
byte 1 48
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $204
byte 1 94
byte 1 49
byte 1 67
byte 1 71
byte 1 95
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 32
byte 1 105
byte 1 110
byte 1 100
byte 1 101
byte 1 120
byte 1 32
byte 1 37
byte 1 105
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $192
byte 1 67
byte 1 71
byte 1 95
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 32
byte 1 105
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 115
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
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 115
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $189
byte 1 67
byte 1 71
byte 1 95
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 32
byte 1 104
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $186
byte 1 67
byte 1 71
byte 1 95
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 32
byte 1 119
byte 1 105
byte 1 100
byte 1 104
byte 1 116
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $183
byte 1 67
byte 1 71
byte 1 95
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 105
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 32
byte 1 104
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $179
byte 1 67
byte 1 71
byte 1 95
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 105
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 32
byte 1 119
byte 1 105
byte 1 100
byte 1 116
byte 1 104
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $175
byte 1 102
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $172
byte 1 67
byte 1 71
byte 1 95
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 32
byte 1 105
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 100
byte 1 111
byte 1 101
byte 1 115
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 101
byte 1 120
byte 1 105
byte 1 115
byte 1 116
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $169
byte 1 67
byte 1 71
byte 1 95
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 58
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
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 32
byte 1 105
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 115
byte 1 44
byte 1 32
byte 1 105
byte 1 103
byte 1 110
byte 1 111
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $166
byte 1 105
byte 1 109
byte 1 103
byte 1 0
align 1
LABELV $163
byte 1 94
byte 1 49
byte 1 67
byte 1 71
byte 1 95
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 32
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $157
byte 1 94
byte 1 51
byte 1 67
byte 1 71
byte 1 95
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $154
byte 1 94
byte 1 51
byte 1 67
byte 1 71
byte 1 95
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 32
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0

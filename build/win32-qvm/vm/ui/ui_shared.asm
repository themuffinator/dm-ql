data
align 4
LABELV ScriptBuffer
byte 4 0
align 4
LABELV UseScriptBuffer
byte 4 0
align 4
LABELV LastListSelected
byte 4 0
align 4
LABELV captureFunc
byte 4 0
align 4
LABELV captureData
byte 4 0
align 4
LABELV itemCapture
byte 4 0
export DC
align 4
LABELV DC
byte 4 0
align 4
LABELV g_waitingForKey
byte 4 0
align 4
LABELV g_editingField
byte 4 0
align 4
LABELV g_bindItem
byte 4 0
align 4
LABELV g_editItem
byte 4 0
align 4
LABELV LastFocusItem
byte 4 0
export menuCount
align 4
LABELV menuCount
byte 4 0
export openMenuCount
align 4
LABELV openMenuCount
byte 4 0
align 4
LABELV debugMode
byte 4 0
align 4
LABELV lastListBoxClickTime
byte 4 0
export DefaultWideScreenValue
align 4
LABELV DefaultWideScreenValue
byte 4 2
code
proc Q_isdigit 4 0
ADDRFP4 0
ADDRFP4 0
INDIRI4
CVII1 4
ASGNI1
file "..\..\..\..\code\ui\ui_shared.c"
line 97
;1://
;2:// string allocation/management
;3:
;4:#include "../ui/ui_shared.h"
;5:
;6://FIXME argh...  hack
;7:static char *ScriptBuffer = NULL;
;8:static qboolean UseScriptBuffer = qfalse;
;9:
;10:#define DEFAULT_FONT		"fonts/handelgothic.ttf"
;11:#define DEFAULT_SANS_FONT	"fonts/notosans-regular.ttf"
;12:#define DEFAULT_MONO_FONT	"fonts/droidsansmono.ttf"
;13:
;14:typedef struct menuVar_s {
;15:	char name[MAX_MENU_VAR_NAME];
;16:	float value;
;17:} menuVar_t;
;18:
;19:static menuVar_t menuVars[MAX_MENU_VARS];
;20:
;21://FIXME hack for team game lists
;22:static listBoxDef_t *LastListSelected = NULL;
;23:
;24:#define SCROLL_TIME_START					500
;25:#define SCROLL_TIME_ADJUST				150
;26:#define SCROLL_TIME_ADJUSTOFFSET	40
;27:#define SCROLL_TIME_FLOOR					20
;28:
;29:typedef struct scrollInfo_s {
;30:	int nextScrollTime;
;31:	int nextAdjustTime;
;32:	int adjustValue;
;33:	int scrollKey;
;34:	float xStart;
;35:	float yStart;
;36:	itemDef_t *item;
;37:	qboolean scrollDir;
;38:} scrollInfo_t;
;39:
;40:static scrollInfo_t scrollInfo;
;41:
;42:static void (*captureFunc) (void *p) = 0;
;43:static void *captureData = NULL;
;44:static itemDef_t *itemCapture = NULL;   // item that has the mouse captured ( if any )
;45:
;46:displayContextDef_t *DC = NULL;
;47:
;48:static qboolean g_waitingForKey = qfalse;
;49:static qboolean g_editingField = qfalse;
;50:
;51:static itemDef_t *g_bindItem = NULL;
;52:static itemDef_t *g_editItem = NULL;
;53:
;54://FIXME hack
;55:static itemDef_t *LastFocusItem = NULL;
;56:
;57:menuDef_t Menus[MAX_MENUS];      // defined menus
;58:int menuCount = 0;               // how many
;59:
;60:menuDef_t *menuStack[MAX_OPEN_MENUS];
;61:int openMenuCount = 0;
;62:
;63:static qboolean debugMode = qfalse;
;64:
;65:#define DOUBLE_CLICK_DELAY 300
;66:static int lastListBoxClickTime = 0;
;67:
;68:int DefaultWideScreenValue = WIDESCREEN_CENTER;
;69:
;70:static void Item_RunScript(itemDef_t *item, const char *s);
;71:static void Item_RunFrameScript(itemDef_t *item, const char *script);
;72:static void Item_SetupKeywordHash(void);
;73:static void Menu_SetupKeywordHash(void);
;74:static int BindingIDFromName(const char *name);
;75:static qboolean Item_Bind_HandleKey(itemDef_t *item, int key, qboolean down);
;76:static itemDef_t *Menu_SetPrevCursorItem(menuDef_t *menu);
;77:static itemDef_t *Menu_SetNextCursorItem(menuDef_t *menu);
;78:static qboolean Menu_OverActiveItem(menuDef_t *menu, float x, float y);
;79:static qboolean Item_Slider_HandleKey(itemDef_t *item, int key, qboolean down);
;80:
;81://char *Q_MathScript (char *script, float *val, int *error);
;82:
;83:static qboolean ItemParse_if(itemDef_t *item, int handle, char *token, qboolean forceSkip);
;84:
;85:#ifdef CGAME
;86:#define MEM_POOL_SIZE  (1024 * 1024 * 2)  //128 * 1024
;87:#else
;88:#define MEM_POOL_SIZE  (1024 * 1024 * 2)  //1024 * 1024
;89:#endif
;90:
;91:static char		memoryPool[MEM_POOL_SIZE];
;92:static int		allocPoint, outOfMemory;
;93:
;94://---------------------
;95:#define MIN(a,b)	((a) < (b) ? (a) : (b))
;96:
;97:static qboolean Q_isdigit(char c) {
line 98
;98:	if (c < '0' || c > '9') {
ADDRLP4 0
ADDRFP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 48
LTI4 $42
ADDRLP4 0
INDIRI4
CNSTI4 57
LEI4 $40
LABELV $42
line 99
;99:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $39
JUMPV
LABELV $40
line 102
;100:	}
;101:
;102:	return qtrue;
CNSTI4 1
RETI4
LABELV $39
endproc Q_isdigit 4 0
export Q_fpow
proc Q_fpow 8 0
line 105
;103:}
;104:
;105:float Q_fpow(float base, float exponent) {
line 107
;106:	int i;
;107:	for (i = 0; i < exponent; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $47
JUMPV
LABELV $44
line 108
;108:		base *= base;
ADDRLP4 4
ADDRFP4 0
INDIRF4
ASGNF4
ADDRFP4 0
ADDRLP4 4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 109
;109:	}
LABELV $45
line 107
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $47
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRFP4 4
INDIRF4
LTF4 $44
line 110
;110:	return base;
ADDRFP4 0
INDIRF4
RETF4
LABELV $43
endproc Q_fpow 8 0
proc Com_HexStrToInt 36 4
line 118
;111:}
;112:
;113:/*
;114:===================
;115:Com_HexStrToInt
;116:===================
;117:*/
;118:static int Com_HexStrToInt(const char *str) {
line 119
;119:	if (!str)
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $49
line 120
;120:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $48
JUMPV
LABELV $49
line 123
;121:
;122:	// check for hex code
;123:	if (str[0] == '0' && str[1] == 'x' && str[2] != '\0') {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
NEI4 $51
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 120
NEI4 $51
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $51
line 124
;124:		int i, n = 0, len = strlen(str);
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 16
INDIRI4
ASGNI4
line 126
;125:
;126:		for (i = 2; i < len; i++) {
ADDRLP4 4
CNSTI4 2
ASGNI4
ADDRGP4 $56
JUMPV
LABELV $53
line 129
;127:			char digit;
;128:
;129:			n *= 16;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 131
;130:
;131:			digit = tolower(str[i]);
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 24
ADDRGP4 tolower
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 24
INDIRI4
CVII1 4
ASGNI1
line 133
;132:
;133:			if (digit >= '0' && digit <= '9')
ADDRLP4 28
ADDRLP4 20
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 48
LTI4 $57
ADDRLP4 28
INDIRI4
CNSTI4 57
GTI4 $57
line 134
;134:				digit -= '0';
ADDRLP4 20
ADDRLP4 20
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
CVII1 4
ASGNI1
ADDRGP4 $58
JUMPV
LABELV $57
line 135
;135:			else if (digit >= 'a' && digit <= 'f')
ADDRLP4 32
ADDRLP4 20
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 97
LTI4 $59
ADDRLP4 32
INDIRI4
CNSTI4 102
GTI4 $59
line 136
;136:				digit = digit - 'a' + 10;
ADDRLP4 20
ADDRLP4 20
INDIRI1
CVII4 1
CNSTI4 97
SUBI4
CNSTI4 10
ADDI4
CVII1 4
ASGNI1
ADDRGP4 $60
JUMPV
LABELV $59
line 138
;137:			else
;138:				return -1;
CNSTI4 -1
RETI4
ADDRGP4 $48
JUMPV
LABELV $60
LABELV $58
line 140
;139:
;140:			n += digit;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 20
INDIRI1
CVII4 1
ADDI4
ASGNI4
line 141
;141:		}
LABELV $54
line 126
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $56
ADDRLP4 4
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $53
line 143
;142:
;143:		return n;
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $48
JUMPV
LABELV $51
line 146
;144:	}
;145:
;146:	return -1;
CNSTI4 -1
RETI4
LABELV $48
endproc Com_HexStrToInt 36 4
export Q_GetCpFromUtf8
proc Q_GetCpFromUtf8 20 8
line 149
;147:}
;148:
;149:int Q_GetCpFromUtf8(const char *s, int *bytes, qboolean *error) {
line 153
;150:	unsigned char c;
;151:	int b0, b1, b2, b3;
;152:
;153:	*error = qfalse;
ADDRFP4 8
INDIRP4
CNSTI4 0
ASGNI4
line 155
;154:
;155:	c = s[0];
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CVIU4 4
CVUU1 4
ASGNU1
line 156
;156:	if (c <= 0x7f) {  // 1 byte 0xxxxxxx
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 127
GTI4 $62
line 157
;157:		*bytes = 1;
ADDRFP4 4
INDIRP4
CNSTI4 1
ASGNI4
line 158
;158:		return c;
ADDRLP4 0
INDIRU1
CVUI4 1
RETI4
ADDRGP4 $61
JUMPV
LABELV $62
line 159
;159:	} else if ((c & 0xe0) == 0xc0) {  // 2 bytes 110xxxxx 10xxxxxx
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 224
BANDI4
CNSTI4 192
NEI4 $64
line 160
;160:		if (qfalse) {  //(s[1] == '\0') {  // not enough bytes to read
ADDRGP4 $66
JUMPV
line 161
;161:			Com_Printf("^3Q_GetCpFromUtf8 two byte UTF-8 sequence terminated, %d\n", c);
ADDRGP4 $68
ARGP4
ADDRLP4 0
INDIRU1
CVUI4 1
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 162
;162:			*bytes = 1;
ADDRFP4 4
INDIRP4
CNSTI4 1
ASGNI4
line 164
;163:			//FIXME return a standard invalid char
;164:			*error = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 1
ASGNI4
line 165
;165:			return c;
ADDRLP4 0
INDIRU1
CVUI4 1
RETI4
ADDRGP4 $61
JUMPV
LABELV $66
line 167
;166:		}
;167:		*bytes = 2;
ADDRFP4 4
INDIRP4
CNSTI4 2
ASGNI4
line 168
;168:		b0 = c;
ADDRLP4 4
ADDRLP4 0
INDIRU1
CVUI4 1
ASGNI4
line 169
;169:		b1 = s[1];
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
line 170
;170:		return (((b0 & 0x1f) << 6) | (b1 & 0x3f));
ADDRLP4 4
INDIRI4
CNSTI4 31
BANDI4
CNSTI4 6
LSHI4
ADDRLP4 8
INDIRI4
CNSTI4 63
BANDI4
BORI4
RETI4
ADDRGP4 $61
JUMPV
LABELV $64
line 171
;171:	} else if ((c & 0xf0) == 0xe0) {  // 3 bytes 1110xxxx 10xxxxxx 10xxxxxx
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 240
BANDI4
CNSTI4 224
NEI4 $69
line 172
;172:		if (qfalse) {  //(s[1] == '\0'  ||  s[2] == '\0') {
ADDRGP4 $71
JUMPV
line 173
;173:			Com_Printf("^3Q_GetCpFromUtf8  three byte UTF-8 sequence terminated, %d\n", c);
ADDRGP4 $73
ARGP4
ADDRLP4 0
INDIRU1
CVUI4 1
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 175
;174:			//Com_Printf("%s\n", s);
;175:			*bytes = 1;
ADDRFP4 4
INDIRP4
CNSTI4 1
ASGNI4
line 177
;176:			//FIXME return a standard invalid char
;177:			*error = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 1
ASGNI4
line 178
;178:			return c;
ADDRLP4 0
INDIRU1
CVUI4 1
RETI4
ADDRGP4 $61
JUMPV
LABELV $71
line 180
;179:		}
;180:		*bytes = 3;
ADDRFP4 4
INDIRP4
CNSTI4 3
ASGNI4
line 181
;181:		b0 = c;
ADDRLP4 4
ADDRLP4 0
INDIRU1
CVUI4 1
ASGNI4
line 182
;182:		b1 = s[1];
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
line 183
;183:		b2 = s[2];
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 2
ADDP4
INDIRI1
CVII4 1
ASGNI4
line 184
;184:		return (((b0 & 0xf) << 12) | ((b1 & 0x3f) << 6) | (b2 & 0x3f));
ADDRLP4 4
INDIRI4
CNSTI4 15
BANDI4
CNSTI4 12
LSHI4
ADDRLP4 8
INDIRI4
CNSTI4 63
BANDI4
CNSTI4 6
LSHI4
BORI4
ADDRLP4 12
INDIRI4
CNSTI4 63
BANDI4
BORI4
RETI4
ADDRGP4 $61
JUMPV
LABELV $69
line 185
;185:	} else if ((c & 0xf8) == 0xf0) {  // 4 bytes 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 248
BANDI4
CNSTI4 240
NEI4 $74
line 186
;186:		if (qfalse) {  //(s[1] == '\0'  ||  s[2] == '\0'  ||  s[3] == '\0') {
ADDRGP4 $76
JUMPV
line 187
;187:			Com_Printf("^3Q_GetCpFromUtf8  four byte UTF-8 sequence terminated, %d\n", c);
ADDRGP4 $78
ARGP4
ADDRLP4 0
INDIRU1
CVUI4 1
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 188
;188:			*bytes = 1;
ADDRFP4 4
INDIRP4
CNSTI4 1
ASGNI4
line 190
;189:			//FIXME return a standard invalid char
;190:			*error = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 1
ASGNI4
line 191
;191:			return c;
ADDRLP4 0
INDIRU1
CVUI4 1
RETI4
ADDRGP4 $61
JUMPV
LABELV $76
line 193
;192:		}
;193:		*bytes = 4;
ADDRFP4 4
INDIRP4
CNSTI4 4
ASGNI4
line 194
;194:		b0 = c;
ADDRLP4 4
ADDRLP4 0
INDIRU1
CVUI4 1
ASGNI4
line 195
;195:		b1 = s[1];
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
line 196
;196:		b2 = s[2];
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 2
ADDP4
INDIRI1
CVII4 1
ASGNI4
line 197
;197:		b3 = s[3];
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 3
ADDP4
INDIRI1
CVII4 1
ASGNI4
line 198
;198:		return (((b0 & 0x7) << 18) | ((b1 & 0x3f) << 12) | ((b2 & 0x3f) << 6) | (b3 & 0x3f));
ADDRLP4 4
INDIRI4
CNSTI4 7
BANDI4
CNSTI4 18
LSHI4
ADDRLP4 8
INDIRI4
CNSTI4 63
BANDI4
CNSTI4 12
LSHI4
BORI4
ADDRLP4 12
INDIRI4
CNSTI4 63
BANDI4
CNSTI4 6
LSHI4
BORI4
ADDRLP4 16
INDIRI4
CNSTI4 63
BANDI4
BORI4
RETI4
ADDRGP4 $61
JUMPV
LABELV $74
line 202
;199:	}
;200:
;201:	// invalid number of bytes
;202:	Com_Printf("^3Q_GetCpFromUtf8  invalid number of bytes specified in UTF-8 character %d\n", c);
ADDRGP4 $79
ARGP4
ADDRLP4 0
INDIRU1
CVUI4 1
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 203
;203:	*error = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 1
ASGNI4
line 204
;204:	*bytes = 1;
ADDRFP4 4
INDIRP4
CNSTI4 1
ASGNI4
line 205
;205:	return c;
ADDRLP4 0
INDIRU1
CVUI4 1
RETI4
LABELV $61
endproc Q_GetCpFromUtf8 20 8
export UI_Alloc
proc UI_Alloc 8 16
line 213
;206:}
;207:
;208:/*
;209:===============
;210:UI_Alloc
;211:===============
;212:*/
;213:void *UI_Alloc(int size) {
line 216
;214:	char *p;
;215:
;216:	if (allocPoint + size > MEM_POOL_SIZE) {
ADDRGP4 allocPoint
INDIRI4
ADDRFP4 0
INDIRI4
ADDI4
CNSTI4 2097152
LEI4 $81
line 217
;217:		outOfMemory = qtrue;
ADDRGP4 outOfMemory
CNSTI4 1
ASGNI4
line 218
;218:		if (DC->Print) {
ADDRGP4 DC
INDIRP4
CNSTI4 160
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $83
line 219
;219:			DC->Print("UI_Alloc: Failure. Out of memory!  %d + %d > %d\n", allocPoint, size, MEM_POOL_SIZE);
ADDRGP4 $85
ARGP4
ADDRGP4 allocPoint
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 2097152
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 160
ADDP4
INDIRP4
CALLV
pop
line 220
;220:		}
LABELV $83
line 221
;221:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $80
JUMPV
LABELV $81
line 224
;222:	}
;223:
;224:	p = &memoryPool[allocPoint];
ADDRLP4 0
ADDRGP4 allocPoint
INDIRI4
ADDRGP4 memoryPool
ADDP4
ASGNP4
line 226
;225:
;226:	allocPoint += (size + 15) & ~15;
ADDRLP4 4
ADDRGP4 allocPoint
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRI4
CNSTI4 15
ADDI4
CNSTI4 -16
BANDI4
ADDI4
ASGNI4
line 228
;227:
;228:	return p;
ADDRLP4 0
INDIRP4
RETP4
LABELV $80
endproc UI_Alloc 8 16
export UI_InitMemory
proc UI_InitMemory 0 0
line 236
;229:}
;230:
;231:/*
;232:===============
;233:UI_InitMemory
;234:===============
;235:*/
;236:void UI_InitMemory(void) {
line 237
;237:	allocPoint = 0;
ADDRGP4 allocPoint
CNSTI4 0
ASGNI4
line 238
;238:	outOfMemory = qfalse;
ADDRGP4 outOfMemory
CNSTI4 0
ASGNI4
line 239
;239:}
LABELV $86
endproc UI_InitMemory 0 0
export UI_OutOfMemory
proc UI_OutOfMemory 0 0
line 241
;240:
;241:qboolean UI_OutOfMemory(void) {
line 242
;242:	return outOfMemory;
ADDRGP4 outOfMemory
INDIRI4
RETI4
LABELV $87
endproc UI_OutOfMemory 0 0
proc hashForString 16 4
line 255
;243:}
;244:
;245:
;246:
;247:
;248:
;249:#define HASH_TABLE_SIZE 2048
;250:/*
;251:================
;252:return a hash value for the string
;253:================
;254:*/
;255:static unsigned hashForString(const char *str) {
line 260
;256:	int		i;
;257:	unsigned	hash;
;258:	char	letter;
;259:
;260:	hash = 0;
ADDRLP4 8
CNSTU4 0
ASGNU4
line 261
;261:	i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $90
JUMPV
LABELV $89
line 262
;262:	while (str[i] != '\0') {
line 263
;263:		letter = tolower(str[i]);
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 12
ADDRGP4 tolower
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CVII1 4
ASGNI1
line 264
;264:		hash += (unsigned)(letter) * (i + 119);
ADDRLP4 8
ADDRLP4 8
INDIRU4
ADDRLP4 4
INDIRI1
CVII4 1
CVIU4 4
ADDRLP4 0
INDIRI4
CNSTI4 119
ADDI4
CVIU4 4
MULU4
ADDU4
ASGNU4
line 265
;265:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 266
;266:	}
LABELV $90
line 262
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $89
line 267
;267:	hash &= (HASH_TABLE_SIZE - 1);
ADDRLP4 8
ADDRLP4 8
INDIRU4
CNSTU4 2047
BANDU4
ASGNU4
line 268
;268:	return hash;
ADDRLP4 8
INDIRU4
RETU4
LABELV $88
endproc hashForString 16 4
data
align 4
LABELV strPoolIndex
byte 4 0
align 4
LABELV strHandleCount
byte 4 0
align 4
LABELV $93
address $94
export String_Alloc
code
proc String_Alloc 36 8
line 283
;269:}
;270:
;271:typedef struct stringDef_s {
;272:	struct stringDef_s *next;
;273:	const char *str;
;274:} stringDef_t;
;275:
;276:static int strPoolIndex = 0;
;277:static char strPool[STRING_POOL_SIZE];
;278:
;279:static int strHandleCount = 0;
;280:static stringDef_t *strHandle[HASH_TABLE_SIZE];
;281:
;282:
;283:const char *String_Alloc(const char *p) {
line 289
;284:	int len;
;285:	unsigned hash;
;286:	stringDef_t *str, *last;
;287:	static const char *staticNULL = "";
;288:
;289:	if (p == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $95
line 290
;290:		Com_Printf("^1String_Alloc() p == NULL\n");
ADDRGP4 $97
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 291
;291:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $92
JUMPV
LABELV $95
line 294
;292:	}
;293:
;294:	if (*p == 0) {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $98
line 295
;295:		return staticNULL;
ADDRGP4 $93
INDIRP4
RETP4
ADDRGP4 $92
JUMPV
LABELV $98
line 298
;296:	}
;297:
;298:	hash = hashForString(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 hashForString
CALLU4
ASGNU4
ADDRLP4 8
ADDRLP4 16
INDIRU4
ASGNU4
line 300
;299:
;300:	str = strHandle[hash];
ADDRLP4 0
ADDRLP4 8
INDIRU4
CNSTI4 2
LSHU4
ADDRGP4 strHandle
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $101
JUMPV
LABELV $100
line 301
;301:	while (str) {
line 302
;302:		if (strcmp(p, str->str) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $103
line 303
;303:			return str->str;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
RETP4
ADDRGP4 $92
JUMPV
LABELV $103
line 305
;304:		}
;305:		str = str->next;
ADDRLP4 0
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 306
;306:	}
LABELV $101
line 301
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $100
line 321
;307:
;308:#if 0
;309:	Com_Printf("%0x  new string '%s'  len %d\n", hash, p, strlen(p));
;310:	str = strHandle[hash];
;311:	while (str) {
;312:		Com_Printf("^5%0x '%s'\n", hash, str->str);
;313:		if (strcmp(p, str->str) == 0) {
;314:			//Com_Printf("String_Alloc() got it: '%s'\n", str->str);
;315:			return str->str;
;316:		}
;317:		str = str->next;
;318:	}
;319:#endif
;320:
;321:	len = strlen(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 20
INDIRI4
ASGNI4
line 322
;322:	if (len + strPoolIndex + 1 < STRING_POOL_SIZE) {
ADDRLP4 12
INDIRI4
ADDRGP4 strPoolIndex
INDIRI4
ADDI4
CNSTI4 1
ADDI4
CNSTI4 2097152
GEI4 $105
line 323
;323:		int ph = strPoolIndex;
ADDRLP4 24
ADDRGP4 strPoolIndex
INDIRI4
ASGNI4
line 324
;324:		strcpy(&strPool[strPoolIndex], p);
ADDRGP4 strPoolIndex
INDIRI4
ADDRGP4 strPool
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 325
;325:		strPoolIndex += len + 1;
ADDRLP4 28
ADDRGP4 strPoolIndex
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ADDI4
ASGNI4
line 327
;326:
;327:		last = strHandle[hash];
ADDRLP4 4
ADDRLP4 8
INDIRU4
CNSTI4 2
LSHU4
ADDRGP4 strHandle
ADDP4
INDIRP4
ASGNP4
line 328
;328:		if (last) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $107
ADDRGP4 $110
JUMPV
LABELV $109
line 329
;329:			while (last->next) {
line 330
;330:				last = last->next;
ADDRLP4 4
ADDRLP4 4
INDIRP4
INDIRP4
ASGNP4
line 331
;331:			}
LABELV $110
line 329
ADDRLP4 4
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $109
line 332
;332:		}
LABELV $107
line 334
;333:
;334:		str = UI_Alloc(sizeof(stringDef_t));
CNSTI4 8
ARGI4
ADDRLP4 32
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ASGNP4
line 335
;335:		if (!str) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $112
line 336
;336:			return NULL;
CNSTP4 0
RETP4
ADDRGP4 $92
JUMPV
LABELV $112
line 338
;337:		}
;338:		str->next = NULL;
ADDRLP4 0
INDIRP4
CNSTP4 0
ASGNP4
line 339
;339:		str->str = &strPool[ph];
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 24
INDIRI4
ADDRGP4 strPool
ADDP4
ASGNP4
line 340
;340:		if (last) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $114
line 341
;341:			last->next = str;
ADDRLP4 4
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 342
;342:		} else {
ADDRGP4 $115
JUMPV
LABELV $114
line 343
;343:			strHandle[hash] = str;
ADDRLP4 8
INDIRU4
CNSTI4 2
LSHU4
ADDRGP4 strHandle
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 344
;344:		}
LABELV $115
line 348
;345:
;346:		//Com_Printf("^5String_Alloc() space left: %fmb of %fmb\n", (STRING_POOL_SIZE - strPoolIndex) / (1024.0 * 1024.0), STRING_POOL_SIZE / (1024.0 * 1024.0));
;347:
;348:		return &strPool[ph];
ADDRLP4 24
INDIRI4
ADDRGP4 strPool
ADDP4
RETP4
ADDRGP4 $92
JUMPV
LABELV $105
line 351
;349:	}
;350:
;351:	Com_Printf("^1String_Alloc() out of memory\n");
ADDRGP4 $116
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 352
;352:	String_Report();
ADDRGP4 String_Report
CALLV
pop
line 354
;353:
;354:	return NULL;
CNSTP4 0
RETP4
LABELV $92
endproc String_Alloc 36 8
export String_Report
proc String_Report 4 16
line 357
;355:}
;356:
;357:void String_Report(void) {
line 359
;358:	float f;
;359:	Com_Printf("Memory/String Pool Info\n");
ADDRGP4 $118
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 360
;360:	Com_Printf("----------------\n");
ADDRGP4 $119
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 361
;361:	f = strPoolIndex;
ADDRLP4 0
ADDRGP4 strPoolIndex
INDIRI4
CVIF4 4
ASGNF4
line 362
;362:	f /= STRING_POOL_SIZE;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 889192448
MULF4
ASGNF4
line 363
;363:	f *= 100;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1120403456
MULF4
ASGNF4
line 364
;364:	Com_Printf("String Pool is %.1f%% full, %i bytes out of %i used.\n", f, strPoolIndex, STRING_POOL_SIZE);
ADDRGP4 $120
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 strPoolIndex
INDIRI4
ARGI4
CNSTI4 2097152
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 365
;365:	f = allocPoint;
ADDRLP4 0
ADDRGP4 allocPoint
INDIRI4
CVIF4 4
ASGNF4
line 366
;366:	f /= MEM_POOL_SIZE;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 889192448
MULF4
ASGNF4
line 367
;367:	f *= 100;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1120403456
MULF4
ASGNF4
line 368
;368:	Com_Printf("Memory Pool is %.1f%% full, %i bytes out of %i used.\n", f, allocPoint, MEM_POOL_SIZE);
ADDRGP4 $121
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 allocPoint
INDIRI4
ARGI4
CNSTI4 2097152
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 369
;369:}
LABELV $117
endproc String_Report 4 16
export String_Init
proc String_Init 8 0
line 376
;370:
;371:/*
;372:=================
;373:String_Init
;374:=================
;375:*/
;376:void String_Init(void) {
line 378
;377:	int i;
;378:	for (i = 0; i < HASH_TABLE_SIZE; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $123
line 379
;379:		strHandle[i] = NULL;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 strHandle
ADDP4
CNSTP4 0
ASGNP4
line 380
;380:	}
LABELV $124
line 378
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2048
LTI4 $123
line 381
;381:	strHandleCount = 0;
ADDRGP4 strHandleCount
CNSTI4 0
ASGNI4
line 382
;382:	strPoolIndex = 0;
ADDRGP4 strPoolIndex
CNSTI4 0
ASGNI4
line 383
;383:	menuCount = 0;
ADDRGP4 menuCount
CNSTI4 0
ASGNI4
line 384
;384:	openMenuCount = 0;
ADDRGP4 openMenuCount
CNSTI4 0
ASGNI4
line 385
;385:	UI_InitMemory();
ADDRGP4 UI_InitMemory
CALLV
pop
line 386
;386:	Item_SetupKeywordHash();
ADDRGP4 Item_SetupKeywordHash
CALLV
pop
line 387
;387:	Menu_SetupKeywordHash();
ADDRGP4 Menu_SetupKeywordHash
CALLV
pop
line 388
;388:	if (DC && DC->getBindingBuf) {
ADDRLP4 4
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $127
ADDRLP4 4
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $127
line 389
;389:		Controls_GetConfig();
ADDRGP4 Controls_GetConfig
CALLV
pop
line 390
;390:	}
LABELV $127
line 391
;391:}
LABELV $122
endproc String_Init 8 0
bss
align 1
LABELV $130
skip 4096
export PC_SourceWarning
code
proc PC_SourceWarning 136 16
line 399
;392:
;393:#if 1  // unused
;394:/*
;395:=================
;396:PC_SourceWarning
;397:=================
;398:*/
;399:void PC_SourceWarning(int handle, char *format, ...) {
line 405
;400:	int line;
;401:	char filename[128];
;402:	va_list argptr;
;403:	static char string[4096];
;404:
;405:	va_start(argptr, format);
ADDRLP4 132
ADDRFP4 4+4
ASGNP4
line 406
;406:	ED_vsprintf(string, format, argptr);
ADDRGP4 $130
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRGP4 ED_vsprintf
CALLI4
pop
line 407
;407:	va_end(argptr);
ADDRLP4 132
CNSTP4 0
ASGNP4
line 409
;408:
;409:	filename[0] = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 410
;410:	line = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 411
;411:	trap_PC_SourceFileAndLine(handle, filename, &line);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_PC_SourceFileAndLine
CALLI4
pop
line 413
;412:
;413:	Com_Printf(S_COLOR_YELLOW "WARNING: %s, line %d: %s\n", filename, line, string);
ADDRGP4 $132
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $130
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 414
;414:}
LABELV $129
endproc PC_SourceWarning 136 16
bss
align 1
LABELV $134
skip 4096
export PC_SourceError
code
proc PC_SourceError 136 16
line 422
;415:#endif
;416:
;417:/*
;418:=================
;419:PC_SourceError
;420:=================
;421:*/
;422:void PC_SourceError(int handle, char *format, ...) {
line 428
;423:	int line;
;424:	char filename[128];
;425:	va_list argptr;
;426:	static char string[4096];
;427:
;428:	va_start(argptr, format);
ADDRLP4 132
ADDRFP4 4+4
ASGNP4
line 429
;429:	ED_vsprintf(string, format, argptr);
ADDRGP4 $134
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 132
INDIRP4
ARGP4
ADDRGP4 ED_vsprintf
CALLI4
pop
line 430
;430:	va_end(argptr);
ADDRLP4 132
CNSTP4 0
ASGNP4
line 432
;431:
;432:	filename[0] = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 433
;433:	line = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 434
;434:	trap_PC_SourceFileAndLine(handle, filename, &line);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 trap_PC_SourceFileAndLine
CALLI4
pop
line 436
;435:
;436:	Com_Printf(S_COLOR_RED "ERROR: %s, line %d: %s\n", filename, line, string);
ADDRGP4 $136
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $134
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 437
;437:}
LABELV $133
endproc PC_SourceError 136 16
export MenuVar_Set
proc MenuVar_Set 20 12
line 439
;438:
;439:qboolean MenuVar_Set(const char *varName, float f) {
line 442
;440:	int i;
;441:
;442:	for (i = 0; i < MAX_MENU_VARS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $138
line 445
;443:		menuVar_t *mv;
;444:
;445:		mv = &menuVars[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 68
MULI4
ADDRGP4 menuVars
ADDP4
ASGNP4
line 446
;446:		if (mv->name[0] == '\0' || !Q_stricmp(varName, mv->name)) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $144
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $142
LABELV $144
line 447
;447:			if (mv->name[0] == '\0') {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $145
line 448
;448:				Q_strncpyz(mv->name, varName, sizeof(mv->name));
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 449
;449:				if (strlen(varName) >= MAX_MENU_VAR_NAME) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 64
LTI4 $147
line 450
;450:					Com_Printf("^1ERROR: truncated menu name, max menu var name length is %d: '%s'\n", MAX_MENU_VAR_NAME, varName);
ADDRGP4 $149
ARGP4
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 451
;451:				}
LABELV $147
line 452
;452:			}
LABELV $145
line 453
;453:			mv->value = f;
ADDRLP4 4
INDIRP4
CNSTI4 64
ADDP4
ADDRFP4 4
INDIRF4
ASGNF4
line 455
;454:
;455:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $137
JUMPV
LABELV $142
line 457
;456:		}
;457:	}
LABELV $139
line 442
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 128
LTI4 $138
line 459
;458:
;459:	Com_Printf("^3MenuSetVar() couldn't set '%s', MAX_MENU_VARS (%d) reached\n", varName, MAX_MENU_VARS);
ADDRGP4 $150
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 461
;460:
;461:	return qfalse;
CNSTI4 0
RETI4
LABELV $137
endproc MenuVar_Set 20 12
export MenuVar_Get
proc MenuVar_Get 16 8
line 464
;462:}
;463:
;464:float MenuVar_Get(const char *varName) {
line 468
;465:	int i;
;466:	float f;
;467:
;468:	f = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 469
;469:	for (i = 0; i < MAX_MENU_VARS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $152
line 472
;470:		menuVar_t *mv;
;471:
;472:		mv = &menuVars[i];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 68
MULI4
ADDRGP4 menuVars
ADDP4
ASGNP4
line 473
;473:		if (mv->name[0] == '\0') {
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $156
line 474
;474:			Com_Printf("^3MenuVar_Get() no such menu variable '%s'\n", varName);
ADDRGP4 $158
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 475
;475:			break;
ADDRGP4 $154
JUMPV
LABELV $156
line 478
;476:		}
;477:
;478:		if (!Q_stricmp(varName, mv->name)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $159
line 479
;479:			f = mv->value;
ADDRLP4 4
ADDRLP4 8
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ASGNF4
line 480
;480:			break;
ADDRGP4 $154
JUMPV
LABELV $159
line 482
;481:		}
;482:	}
LABELV $153
line 469
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 128
LTI4 $152
LABELV $154
line 484
;483:
;484:	return f;
ADDRLP4 4
INDIRF4
RETF4
LABELV $151
endproc MenuVar_Get 16 8
export LerpColor
proc LerpColor 12 0
line 492
;485:}
;486:
;487:/*
;488:=================
;489:LerpColor
;490:=================
;491:*/
;492:void LerpColor(vec4_t a, vec4_t b, vec4_t c, float t) {
line 496
;493:	int i;
;494:
;495:	// lerp and clamp each component
;496:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $162
line 497
;497:		c[i] = a[i] + t * (b[i] - a[i]);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 498
;498:		if (c[i] < 0)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $166
line 499
;499:			c[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $167
JUMPV
LABELV $166
line 500
;500:		else if (c[i] > 1.0)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
CNSTF4 1065353216
LEF4 $168
line 501
;501:			c[i] = 1.0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $168
LABELV $167
line 502
;502:	}
LABELV $163
line 496
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $162
line 503
;503:}
LABELV $161
endproc LerpColor 12 0
export Float_Parse
proc Float_Parse 28 8
line 510
;504:
;505:/*
;506:=================
;507:Float_Parse
;508:=================
;509:*/
;510:qboolean Float_Parse(char **p, float *f) {
line 512
;511:	char *token;
;512:	token = COM_ParseExt(p, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 513
;513:	if (token && token[0] != 0) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $171
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $171
line 514
;514:		if (token[0] != '@') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 64
EQI4 $173
line 515
;515:			if (token[0] == '0' && (token[1] == 'x' || token[1] == 'X')) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
NEI4 $175
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 120
EQI4 $177
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 88
NEI4 $175
LABELV $177
line 516
;516:				*f = Com_HexStrToInt(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Com_HexStrToInt
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
line 517
;517:			} else {
ADDRGP4 $174
JUMPV
LABELV $175
line 518
;518:				if (!Q_isdigit(token[0]) && (token[0] != '+' && token[0] != '-' && token[0] != '.')) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 16
ADDRGP4 Q_isdigit
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $178
ADDRLP4 20
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 43
EQI4 $178
ADDRLP4 20
INDIRI4
CNSTI4 45
EQI4 $178
ADDRLP4 20
INDIRI4
CNSTI4 46
EQI4 $178
line 519
;519:					Com_Printf("^1Float_Parse() invalid float token: '%s'\n", token);
ADDRGP4 $180
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 520
;520:				}
LABELV $178
line 521
;521:				*f = atof(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRF4
ASGNF4
line 522
;522:			}
line 523
;523:		} else {
ADDRGP4 $174
JUMPV
LABELV $173
line 524
;524:			*f = MenuVar_Get(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 MenuVar_Get
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRF4
ASGNF4
line 525
;525:		}
LABELV $174
line 526
;526:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $170
JUMPV
LABELV $171
line 527
;527:	} else {
line 528
;528:		Com_Printf("^1Float_Parse() couldn't get token\n");
ADDRGP4 $181
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 529
;529:		return qfalse;
CNSTI4 0
RETI4
LABELV $170
endproc Float_Parse 28 8
export PC_Float_Parse
proc PC_Float_Parse 2076 12
line 538
;530:	}
;531:}
;532:
;533:/*
;534:=================
;535:PC_Float_Parse
;536:=================
;537:*/
;538:qboolean PC_Float_Parse(int handle, float *f) {
line 543
;539:	pc_token_t token;
;540:	char *p;
;541:	char buf[MAX_TOKENLENGTH];
;542:
;543:	if (UseScriptBuffer) {
ADDRGP4 UseScriptBuffer
INDIRI4
CNSTI4 0
EQI4 $183
line 544
;544:		return Float_Parse(&ScriptBuffer, f);
ADDRGP4 ScriptBuffer
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 2068
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
RETI4
ADDRGP4 $182
JUMPV
LABELV $183
line 547
;545:	}
;546:
;547:	p = buf;
ADDRLP4 0
ADDRLP4 1044
ASGNP4
line 548
;548:	p[0] = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 550
;549:
;550:	if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 2068
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
NEI4 $185
line 551
;551:		Com_Printf("^1PC_Float_Parse() couldn't get token1\n");
ADDRGP4 $187
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 552
;552:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $182
JUMPV
LABELV $185
line 555
;553:	}
;554:
;555:	if (token.string[0] == '-') {
ADDRLP4 4+16
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $188
line 556
;556:		p[0] = '-';
ADDRLP4 0
INDIRP4
CNSTI1 45
ASGNI1
line 557
;557:		p[1] = '\0';
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
CNSTI1 0
ASGNI1
line 558
;558:		p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 559
;559:		if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 2072
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 2072
INDIRI4
CNSTI4 0
NEI4 $191
line 560
;560:			Com_Printf("^1PC_Float_Parse() couldn't get token2\n");
ADDRGP4 $193
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 561
;561:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $182
JUMPV
LABELV $191
line 563
;562:		}
;563:	}
LABELV $188
line 565
;564:
;565:	Q_strncpyz(p, token.string, sizeof(buf) - 1);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4+16
ARGP4
CNSTI4 1023
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 567
;566:
;567:	p = buf;
ADDRLP4 0
ADDRLP4 1044
ASGNP4
line 568
;568:	Float_Parse(&p, f);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Float_Parse
CALLI4
pop
line 570
;569:
;570:	return qtrue;
CNSTI4 1
RETI4
LABELV $182
endproc PC_Float_Parse 2076 12
export Color_Parse
proc Color_Parse 12 8
line 578
;571:}
;572:
;573:/*
;574:=================
;575:Color_Parse
;576:=================
;577:*/
;578:qboolean Color_Parse(char **p, vec4_t *c) {
line 582
;579:	int i;
;580:	float f;
;581:
;582:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $196
line 583
;583:		if (!Float_Parse(p, &f)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $200
line 584
;584:			Com_Printf("^1Color_Parse() couldn't get token %d\n", i);
ADDRGP4 $202
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 586
;585:			//Com_Printf("^3'%s'\n", *p);
;586:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $195
JUMPV
LABELV $200
line 588
;587:		}
;588:		(*c)[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 589
;589:	}
LABELV $197
line 582
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $196
line 590
;590:	return qtrue;
CNSTI4 1
RETI4
LABELV $195
endproc Color_Parse 12 8
export PC_Color_Parse
proc PC_Color_Parse 12 8
line 598
;591:}
;592:
;593:/*
;594:=================
;595:PC_Color_Parse
;596:=================
;597:*/
;598:qboolean PC_Color_Parse(int handle, vec4_t *c) {
line 602
;599:	int i;
;600:	float f;
;601:
;602:	if (UseScriptBuffer) {
ADDRGP4 UseScriptBuffer
INDIRI4
CNSTI4 0
EQI4 $204
line 603
;603:		return Color_Parse(&ScriptBuffer, c);
ADDRGP4 ScriptBuffer
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Color_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $203
JUMPV
LABELV $204
line 606
;604:	}
;605:
;606:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $206
line 607
;607:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $210
line 608
;608:			Com_Printf("^1PC_Color_Parse() couldn't get token %d\n", i);
ADDRGP4 $212
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 609
;609:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $203
JUMPV
LABELV $210
line 611
;610:		}
;611:		(*c)[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 612
;612:	}
LABELV $207
line 606
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $206
line 613
;613:	return qtrue;
CNSTI4 1
RETI4
LABELV $203
endproc PC_Color_Parse 12 8
export Int_Parse
proc Int_Parse 28 8
line 621
;614:}
;615:
;616:/*
;617:=================
;618:Int_Parse
;619:=================
;620:*/
;621:qboolean Int_Parse(char **p, int *i) {
line 623
;622:	char *token;
;623:	token = COM_ParseExt(p, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 625
;624:
;625:	if (token && token[0] != 0) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $214
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $214
line 626
;626:		if (token[0] != '@') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 64
EQI4 $216
line 627
;627:			if (token[0] == '0' && (token[1] == 'x' || token[1] == 'X')) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
NEI4 $218
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 120
EQI4 $220
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 88
NEI4 $218
LABELV $220
line 628
;628:				*i = Com_HexStrToInt(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Com_HexStrToInt
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 16
INDIRI4
ASGNI4
line 629
;629:			} else {
ADDRGP4 $217
JUMPV
LABELV $218
line 630
;630:				if (!Q_isdigit(token[0]) && (token[0] != '+' && token[0] != '-')) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 16
ADDRGP4 Q_isdigit
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $221
ADDRLP4 20
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 43
EQI4 $221
ADDRLP4 20
INDIRI4
CNSTI4 45
EQI4 $221
line 631
;631:					Com_Printf("^1Int_Parse() invalid integer token: '%s'\n", token);
ADDRGP4 $223
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 632
;632:				}
LABELV $221
line 633
;633:				*i = atoi(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ASGNI4
line 634
;634:			}
line 635
;635:		} else {
ADDRGP4 $217
JUMPV
LABELV $216
line 636
;636:			*i = floor(MenuVar_Get(token));
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 MenuVar_Get
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 floor
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
line 637
;637:		}
LABELV $217
line 638
;638:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $213
JUMPV
LABELV $214
line 639
;639:	} else {
line 640
;640:		Com_Printf("^1Int_Parse() couldn't get token\n");
ADDRGP4 $224
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 641
;641:		return qfalse;
CNSTI4 0
RETI4
LABELV $213
endproc Int_Parse 28 8
export PC_Int_Parse
proc PC_Int_Parse 2076 12
line 650
;642:	}
;643:}
;644:
;645:/*
;646:=================
;647:PC_Int_Parse
;648:=================
;649:*/
;650:qboolean PC_Int_Parse(int handle, int *i) {
line 655
;651:	pc_token_t token;
;652:	char *p;
;653:	char buf[MAX_TOKENLENGTH];
;654:
;655:	if (!i) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $226
line 656
;656:		Com_Printf("^1ERROR PC_Int_Parse i == null\n");
ADDRGP4 $228
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 657
;657:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $225
JUMPV
LABELV $226
line 660
;658:	}
;659:
;660:	if (UseScriptBuffer) {
ADDRGP4 UseScriptBuffer
INDIRI4
CNSTI4 0
EQI4 $229
line 661
;661:		return Int_Parse(&ScriptBuffer, i);
ADDRGP4 ScriptBuffer
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 2068
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
RETI4
ADDRGP4 $225
JUMPV
LABELV $229
line 664
;662:	}
;663:
;664:	p = buf;
ADDRLP4 0
ADDRLP4 1044
ASGNP4
line 665
;665:	p[0] = '\0';
ADDRLP4 0
INDIRP4
CNSTI1 0
ASGNI1
line 667
;666:
;667:	if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 2068
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
NEI4 $231
line 668
;668:		Com_Printf("^1PC_Int_Parse() couldn't get token1\n");
ADDRGP4 $233
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 669
;669:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $225
JUMPV
LABELV $231
line 672
;670:	}
;671:
;672:	if (token.string[0] == '-') {
ADDRLP4 4+16
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $234
line 673
;673:		p[0] = '-';
ADDRLP4 0
INDIRP4
CNSTI1 45
ASGNI1
line 674
;674:		p[1] = '\0';
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
CNSTI1 0
ASGNI1
line 675
;675:		p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 676
;676:		if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 2072
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 2072
INDIRI4
CNSTI4 0
NEI4 $237
line 677
;677:			Com_Printf("^1PC_Int_Parse() couldn't get token2\n");
ADDRGP4 $239
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 678
;678:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $225
JUMPV
LABELV $237
line 680
;679:		}
;680:	}
LABELV $234
line 682
;681:
;682:	Q_strncpyz(p, token.string, sizeof(buf) - 1);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4+16
ARGP4
CNSTI4 1023
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 684
;683:
;684:	p = buf;
ADDRLP4 0
ADDRLP4 1044
ASGNP4
line 685
;685:	Int_Parse(&p, i);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Int_Parse
CALLI4
pop
line 687
;686:
;687:	return qtrue;
CNSTI4 1
RETI4
LABELV $225
endproc PC_Int_Parse 2076 12
export Rect_Parse
proc Rect_Parse 16 8
line 695
;688:}
;689:
;690:/*
;691:=================
;692:Rect_Parse
;693:=================
;694:*/
;695:qboolean Rect_Parse(char **p, rectDef_t *r) {
line 696
;696:	if (Float_Parse(p, &r->x)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $242
line 697
;697:		if (Float_Parse(p, &r->y)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $244
line 698
;698:			if (Float_Parse(p, &r->w)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $246
line 699
;699:				if (Float_Parse(p, &r->h)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $248
line 700
;700:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $241
JUMPV
LABELV $248
line 702
;701:				}
;702:			}
LABELV $246
line 703
;703:		}
LABELV $244
line 704
;704:	}
LABELV $242
line 706
;705:
;706:	Com_Printf("^1Rect_Parse() couldn't parse rectangle\n");
ADDRGP4 $250
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 707
;707:	return qfalse;
CNSTI4 0
RETI4
LABELV $241
endproc Rect_Parse 16 8
export PC_Rect_Parse
proc PC_Rect_Parse 16 8
line 715
;708:}
;709:
;710:/*
;711:=================
;712:PC_Rect_Parse
;713:=================
;714:*/
;715:qboolean PC_Rect_Parse(int handle, rectDef_t *r) {
line 716
;716:	if (UseScriptBuffer) {
ADDRGP4 UseScriptBuffer
INDIRI4
CNSTI4 0
EQI4 $252
line 717
;717:		return Rect_Parse(&ScriptBuffer, r);
ADDRGP4 ScriptBuffer
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 Rect_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $251
JUMPV
LABELV $252
line 720
;718:	}
;719:
;720:	if (PC_Float_Parse(handle, &r->x)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $254
line 721
;721:		if (PC_Float_Parse(handle, &r->y)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $256
line 722
;722:			if (PC_Float_Parse(handle, &r->w)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $258
line 723
;723:				if (PC_Float_Parse(handle, &r->h)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $260
line 724
;724:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $251
JUMPV
LABELV $260
line 726
;725:				}
;726:			}
LABELV $258
line 727
;727:		}
LABELV $256
line 728
;728:	}
LABELV $254
line 730
;729:
;730:	Com_Printf("^1PC_Rect_Parse() couldn't parse rectangle\n");
ADDRGP4 $262
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 731
;731:	return qfalse;
CNSTI4 0
RETI4
LABELV $251
endproc PC_Rect_Parse 16 8
export String_Parse
proc String_Parse 16 8
line 739
;732:}
;733:
;734:/*
;735:=================
;736:String_Parse
;737:=================
;738:*/
;739:qboolean String_Parse(char **p, const char **out) {
line 742
;740:	char *token;
;741:
;742:	token = COM_ParseExt(p, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 743
;743:	if (token && token[0] != 0) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $264
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $264
line 744
;744:		*(out) = String_Alloc(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRP4
ASGNP4
line 745
;745:		if (!*(out)) {
ADDRFP4 4
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $266
line 746
;746:			Com_Printf("^1String_Parse() couldn't allocate string\n");
ADDRGP4 $268
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 747
;747:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $263
JUMPV
LABELV $266
line 750
;748:		}
;749:
;750:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $263
JUMPV
LABELV $264
line 754
;751:	}
;752:
;753:	//Com_Printf("^1String_Parse() couldn't parse string\n");
;754:	return qfalse;
CNSTI4 0
RETI4
LABELV $263
endproc String_Parse 16 8
export PC_String_Parse
proc PC_String_Parse 1048 8
line 762
;755:}
;756:
;757:/*
;758:=================
;759:PC_String_Parse
;760:=================
;761:*/
;762:qboolean PC_String_Parse(int handle, const char **out) {
line 765
;763:	pc_token_t token;
;764:
;765:	if (UseScriptBuffer) {
ADDRGP4 UseScriptBuffer
INDIRI4
CNSTI4 0
EQI4 $270
line 766
;766:		return String_Parse(&ScriptBuffer, out);
ADDRGP4 ScriptBuffer
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
RETI4
ADDRGP4 $269
JUMPV
LABELV $270
line 769
;767:	}
;768:
;769:	if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1040
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $272
line 771
;770:		//Com_Printf("^1PC_String_Parse() couldn't read token\n");
;771:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $269
JUMPV
LABELV $272
line 774
;772:	}
;773:
;774:	*(out) = String_Alloc(token.string);
ADDRLP4 0+16
ARGP4
ADDRLP4 1044
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ADDRLP4 1044
INDIRP4
ASGNP4
line 776
;775:
;776:	if (!*(out)) {
ADDRFP4 4
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $275
line 777
;777:		Com_Printf("^1PC_String_Parse() couldn't allocate string\n");
ADDRGP4 $277
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 778
;778:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $269
JUMPV
LABELV $275
line 781
;779:	}
;780:
;781:	return qtrue;
CNSTI4 1
RETI4
LABELV $269
endproc PC_String_Parse 1048 8
proc Script_ParseExt 1056 12
line 784
;782:}
;783:
;784:static qboolean Script_ParseExt(char **p, const char **out, const char **lastToken) {
line 789
;785:	char script[1024];
;786:	const char *token;
;787:	int braceCount;
;788:
;789:	memset(script, 0, sizeof(script));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 790
;790:	if (lastToken) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $279
line 791
;791:		*lastToken = NULL;
ADDRFP4 8
INDIRP4
CNSTP4 0
ASGNP4
line 792
;792:	}
LABELV $279
line 797
;793:
;794:	// scripts start with { and have ; separated command lists.. commands are command, arg..
;795:	// basically we want everything between the { } as it will be interpreted at run time
;796:
;797:	if (!String_Parse(p, &token)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1032
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $281
line 798
;798:		Com_Printf("^1Script_Parse() couldn't get first token\n");
ADDRGP4 $283
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 799
;799:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $278
JUMPV
LABELV $281
line 801
;800:	}
;801:	if (Q_stricmp(token, "{") != 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $286
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $284
line 802
;802:		if (lastToken == NULL) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $287
line 803
;803:			Com_Printf("^1Script_Parse() first token != '{'  '%s'\n", token);
ADDRGP4 $289
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 804
;804:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $278
JUMPV
LABELV $287
line 805
;805:		} else {
line 806
;806:			*lastToken = String_Alloc(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 8
INDIRP4
ADDRLP4 1040
INDIRP4
ASGNP4
line 807
;807:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $278
JUMPV
LABELV $284
line 811
;808:		}
;809:	}
;810:
;811:	braceCount = 1;
ADDRLP4 1028
CNSTI4 1
ASGNI4
ADDRGP4 $291
JUMPV
LABELV $290
line 812
;812:	while (1) {
line 813
;813:		if (!String_Parse(p, &token)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1040
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $293
line 814
;814:			Com_Printf("^1Script_Parse() couldn't get token in loop\n");
ADDRGP4 $295
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 815
;815:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $278
JUMPV
LABELV $293
line 817
;816:		}
;817:		if (!token) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $296
line 818
;818:			Com_Printf("^1Script_Parse() token == NULL\n");
ADDRGP4 $298
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 819
;819:			Com_Printf("p == '%s'\n", *p);
ADDRGP4 $299
ARGP4
ADDRFP4 0
INDIRP4
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 820
;820:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $278
JUMPV
LABELV $296
line 823
;821:		}
;822:
;823:		if (Q_stricmp(token, "}") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $302
ARGP4
ADDRLP4 1044
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $300
line 824
;824:			braceCount--;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 825
;825:			if (braceCount < 0) {
ADDRLP4 1028
INDIRI4
CNSTI4 0
GEI4 $303
line 826
;826:				Com_Printf("^1Script_Parse() braceCount < 0 (%d)\n", braceCount);
ADDRGP4 $305
ARGP4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 827
;827:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $278
JUMPV
LABELV $303
line 828
;828:			} else if (braceCount == 0) {
ADDRLP4 1028
INDIRI4
CNSTI4 0
NEI4 $301
line 829
;829:				*out = String_Alloc(script);
ADDRLP4 4
ARGP4
ADDRLP4 1048
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ADDRLP4 1048
INDIRP4
ASGNP4
line 830
;830:				if (!*(out)) {
ADDRFP4 4
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $308
line 831
;831:					Com_Printf("^1Script_Parse() couldn't allocate string\n");
ADDRGP4 $310
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 832
;832:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $278
JUMPV
LABELV $308
line 834
;833:				}
;834:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $278
JUMPV
line 836
;835:			}
;836:		} else if (Q_stricmp(token, "{") == 0) {
LABELV $300
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $286
ARGP4
ADDRLP4 1048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $311
line 837
;837:			braceCount++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 838
;838:		}
LABELV $311
LABELV $301
line 840
;839:
;840:		if (token[1] != '\0') {
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $313
line 841
;841:			Q_strcat(script, 1024, va("\"%s\"", token));
ADDRGP4 $315
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1052
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1052
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 842
;842:		} else {
ADDRGP4 $314
JUMPV
LABELV $313
line 843
;843:			Q_strcat(script, 1024, token);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 844
;844:		}
LABELV $314
line 845
;845:		Q_strcat(script, 1024, " ");
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $316
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 846
;846:	}
LABELV $291
line 812
ADDRGP4 $290
JUMPV
line 849
;847:
;848:	// shouldn't get here
;849:	return qfalse;
CNSTI4 0
RETI4
LABELV $278
endproc Script_ParseExt 1056 12
export Script_Parse
proc Script_Parse 4 12
line 857
;850:}
;851:
;852:/*
;853:=================
;854:Script_Parse
;855:=================
;856:*/
;857:qboolean Script_Parse(char **p, const char **out) {
line 858
;858:	return Script_ParseExt(p, out, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ADDRGP4 Script_ParseExt
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $317
endproc Script_Parse 4 12
export PC_Script_ParseExt
proc PC_Script_ParseExt 2092 12
line 861
;859:}
;860:
;861:qboolean PC_Script_ParseExt(int handle, const char **out, const char **lastToken) {
line 866
;862:	char script[1024];
;863:	pc_token_t token;
;864:	int braceCount;
;865:
;866:	if (UseScriptBuffer) {
ADDRGP4 UseScriptBuffer
INDIRI4
CNSTI4 0
EQI4 $319
line 867
;867:		return Script_ParseExt(&ScriptBuffer, out, lastToken);
ADDRGP4 ScriptBuffer
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 2068
ADDRGP4 Script_ParseExt
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
RETI4
ADDRGP4 $318
JUMPV
LABELV $319
line 870
;868:	}
;869:
;870:	memset(script, 0, sizeof(script));
ADDRLP4 1040
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 871
;871:	if (lastToken) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $321
line 872
;872:		*lastToken = NULL;
ADDRFP4 8
INDIRP4
CNSTP4 0
ASGNP4
line 873
;873:	}
LABELV $321
line 878
;874:
;875:	// scripts start with { and have ; separated command lists.. commands are command, arg..
;876:	// basically we want everything between the { } as it will be interpreted at run time
;877:
;878:	if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 2068
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
NEI4 $323
line 879
;879:		Com_Printf("^1PC_Script_Parse() couldn't get first token\n");
ADDRGP4 $325
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 880
;880:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $318
JUMPV
LABELV $323
line 882
;881:	}
;882:	if (Q_stricmp(token.string, "{") != 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $286
ARGP4
ADDRLP4 2072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2072
INDIRI4
CNSTI4 0
EQI4 $326
line 883
;883:		if (lastToken == NULL) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $329
line 884
;884:			Com_Printf("^1PC_Script_Parse() first token != '{'  '%s'\n", token.string);
ADDRGP4 $331
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 885
;885:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $318
JUMPV
LABELV $329
line 886
;886:		} else {
line 887
;887:			*lastToken = String_Alloc(token.string);
ADDRLP4 0+16
ARGP4
ADDRLP4 2076
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 8
INDIRP4
ADDRLP4 2076
INDIRP4
ASGNP4
line 888
;888:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $318
JUMPV
LABELV $326
line 892
;889:		}
;890:	}
;891:
;892:	braceCount = 1;
ADDRLP4 2064
CNSTI4 1
ASGNI4
ADDRGP4 $335
JUMPV
LABELV $334
line 893
;893:	while (1) {
line 894
;894:		if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 2076
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 2076
INDIRI4
CNSTI4 0
NEI4 $337
line 895
;895:			Com_Printf("^1PC_Script_Parse() couldn't get token in loop\n");
ADDRGP4 $339
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 896
;896:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $318
JUMPV
LABELV $337
line 898
;897:		}
;898:		if (Q_stricmp(token.string, "}") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $302
ARGP4
ADDRLP4 2080
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2080
INDIRI4
CNSTI4 0
NEI4 $340
line 899
;899:			braceCount--;
ADDRLP4 2064
ADDRLP4 2064
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 900
;900:			if (braceCount < 0) {
ADDRLP4 2064
INDIRI4
CNSTI4 0
GEI4 $343
line 901
;901:				Com_Printf("^1PC_Script_Parse() braceCount < 0 (%d)\n", braceCount);
ADDRGP4 $345
ARGP4
ADDRLP4 2064
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 902
;902:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $318
JUMPV
LABELV $343
line 903
;903:			} else if (braceCount == 0) {
ADDRLP4 2064
INDIRI4
CNSTI4 0
NEI4 $341
line 904
;904:				*out = String_Alloc(script);
ADDRLP4 1040
ARGP4
ADDRLP4 2084
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ADDRLP4 2084
INDIRP4
ASGNP4
line 905
;905:				if (!*out) {
ADDRFP4 4
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $348
line 906
;906:					Com_Printf("^1PC_Script_Parse() couldn't allocate string\n");
ADDRGP4 $350
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 907
;907:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $318
JUMPV
LABELV $348
line 909
;908:				}
;909:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $318
JUMPV
line 911
;910:			}
;911:		} else if (Q_stricmp(token.string, "{") == 0) {
LABELV $340
ADDRLP4 0+16
ARGP4
ADDRGP4 $286
ARGP4
ADDRLP4 2084
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2084
INDIRI4
CNSTI4 0
NEI4 $351
line 912
;912:			braceCount++;
ADDRLP4 2064
ADDRLP4 2064
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 913
;913:		}
LABELV $351
LABELV $341
line 915
;914:
;915:		if (token.string[1] != '\0') {
ADDRLP4 0+16+1
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $354
line 916
;916:			Q_strcat(script, 1024, va("\"%s\"", token.string));
ADDRGP4 $315
ARGP4
ADDRLP4 0+16
ARGP4
ADDRLP4 2088
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1040
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2088
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 917
;917:		} else {
ADDRGP4 $355
JUMPV
LABELV $354
line 918
;918:			Q_strcat(script, 1024, token.string);
ADDRLP4 1040
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 0+16
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 919
;919:		}
LABELV $355
line 920
;920:		Q_strcat(script, 1024, " ");
ADDRLP4 1040
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $316
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 921
;921:	}
LABELV $335
line 893
ADDRGP4 $334
JUMPV
line 924
;922:
;923:	// shouldn't get here
;924:	return qfalse;
CNSTI4 0
RETI4
LABELV $318
endproc PC_Script_ParseExt 2092 12
export PC_Script_Parse
proc PC_Script_Parse 4 12
line 932
;925:}
;926:
;927:/*
;928:=================
;929:PC_Script_Parse
;930:=================
;931:*/
;932:qboolean PC_Script_Parse(int handle, const char **out) {
line 933
;933:	return PC_Script_ParseExt(handle, out, NULL);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_ParseExt
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $360
endproc PC_Script_Parse 4 12
export Parenthesis_Parse
proc Parenthesis_Parse 1056 12
line 941
;934:}
;935:
;936:/*
;937:=================
;938:Parenthesis_Parse
;939:=================
;940:*/
;941:qboolean Parenthesis_Parse(char **p, const char **out) {
line 946
;942:	char script[1024];
;943:	const char *token;
;944:	int braceCount;
;945:
;946:	memset(script, 0, sizeof(script));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 950
;947:	// scripts start with { and have ; separated command lists.. commands are command, arg..
;948:	// basically we want everything between the { } as it will be interpreted at run time
;949:
;950:	if (!String_Parse(p, &token)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1032
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $362
line 951
;951:		Com_Printf("^1Parenthesis_Parse() couldn't get first token\n");
ADDRGP4 $364
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 952
;952:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $361
JUMPV
LABELV $362
line 954
;953:	}
;954:	if (Q_stricmp(token, "(") != 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $367
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $365
line 955
;955:		Com_Printf("^1Parenthesis_Parse() first token != '('  '%s'\n", token);
ADDRGP4 $368
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 956
;956:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $361
JUMPV
LABELV $365
line 959
;957:	}
;958:
;959:	braceCount = 1;
ADDRLP4 1028
CNSTI4 1
ASGNI4
ADDRGP4 $370
JUMPV
LABELV $369
line 960
;960:	while (1) {
line 961
;961:		if (!String_Parse(p, &token)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1040
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $372
line 962
;962:			Com_Printf("^1Parenthesis_Parse() couldn't get token in loop\n");
ADDRGP4 $374
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 963
;963:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $361
JUMPV
LABELV $372
line 965
;964:		}
;965:		if (Q_stricmp(token, ")") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $377
ARGP4
ADDRLP4 1044
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $375
line 966
;966:			braceCount--;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 967
;967:			if (braceCount < 0) {
ADDRLP4 1028
INDIRI4
CNSTI4 0
GEI4 $378
line 968
;968:				Com_Printf("^1Parenthesis_Parse() braceCount < 0 (%d)\n", braceCount);
ADDRGP4 $380
ARGP4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 969
;969:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $361
JUMPV
LABELV $378
line 970
;970:			} else if (braceCount == 0) {
ADDRLP4 1028
INDIRI4
CNSTI4 0
NEI4 $376
line 971
;971:				*out = String_Alloc(script);
ADDRLP4 4
ARGP4
ADDRLP4 1048
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ADDRLP4 1048
INDIRP4
ASGNP4
line 972
;972:				if (!*out) {
ADDRFP4 4
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $383
line 973
;973:					Com_Printf("^1Parenthesis_Parse() couldn't allocate string\n");
ADDRGP4 $385
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 974
;974:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $361
JUMPV
LABELV $383
line 976
;975:				}
;976:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $361
JUMPV
line 978
;977:			}
;978:		} else if (Q_stricmp(token, "(") == 0) {
LABELV $375
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $367
ARGP4
ADDRLP4 1048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $386
line 979
;979:			braceCount++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 980
;980:		}
LABELV $386
LABELV $376
line 982
;981:
;982:		if (token[1] != '\0') {
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $388
line 983
;983:			Q_strcat(script, 1024, va("\"%s\"", token));
ADDRGP4 $315
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1052
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1052
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 984
;984:		} else {
ADDRGP4 $389
JUMPV
LABELV $388
line 985
;985:			Q_strcat(script, 1024, token);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 986
;986:		}
LABELV $389
line 987
;987:		Q_strcat(script, 1024, " ");
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $316
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 988
;988:	}
LABELV $370
line 960
ADDRGP4 $369
JUMPV
line 991
;989:
;990:	// shouldn't get here
;991:	return qfalse;
CNSTI4 0
RETI4
LABELV $361
endproc Parenthesis_Parse 1056 12
export PC_Parenthesis_Parse
proc PC_Parenthesis_Parse 2092 12
line 999
;992:}
;993:
;994:/*
;995:=================
;996:PC_Parenthesis_Parse
;997:=================
;998:*/
;999:qboolean PC_Parenthesis_Parse(int handle, const char **out) {
line 1004
;1000:	char script[1024];
;1001:	pc_token_t token;
;1002:	int braceCount;
;1003:
;1004:	if (UseScriptBuffer) {
ADDRGP4 UseScriptBuffer
INDIRI4
CNSTI4 0
EQI4 $391
line 1005
;1005:		return Parenthesis_Parse(&ScriptBuffer, out);
ADDRGP4 ScriptBuffer
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 2068
ADDRGP4 Parenthesis_Parse
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
RETI4
ADDRGP4 $390
JUMPV
LABELV $391
line 1008
;1006:	}
;1007:
;1008:	memset(script, 0, sizeof(script));
ADDRLP4 1040
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1012
;1009:	// scripts start with { and have ; separated command lists.. commands are command, arg..
;1010:	// basically we want everything between the { } as it will be interpreted at run time
;1011:
;1012:	if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 2068
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
NEI4 $393
line 1013
;1013:		Com_Printf("^1PC_Parenthesis_Parse() couldn't get first token\n");
ADDRGP4 $395
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1014
;1014:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $390
JUMPV
LABELV $393
line 1016
;1015:	}
;1016:	if (Q_stricmp(token.string, "(") != 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $367
ARGP4
ADDRLP4 2072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2072
INDIRI4
CNSTI4 0
EQI4 $396
line 1017
;1017:		Com_Printf("^1PC_Parenthesis_Parse() first token != '('  '%s'\n", token.string);
ADDRGP4 $399
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1018
;1018:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $390
JUMPV
LABELV $396
line 1021
;1019:	}
;1020:
;1021:	braceCount = 1;
ADDRLP4 2064
CNSTI4 1
ASGNI4
ADDRGP4 $402
JUMPV
LABELV $401
line 1022
;1022:	while (1) {
line 1023
;1023:		if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 2076
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 2076
INDIRI4
CNSTI4 0
NEI4 $404
line 1024
;1024:			Com_Printf("^1PC_Parenthesis_Parse() couldn't get token in loop\n");
ADDRGP4 $406
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1025
;1025:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $390
JUMPV
LABELV $404
line 1027
;1026:		}
;1027:		if (Q_stricmp(token.string, ")") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $377
ARGP4
ADDRLP4 2080
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2080
INDIRI4
CNSTI4 0
NEI4 $407
line 1028
;1028:			braceCount--;
ADDRLP4 2064
ADDRLP4 2064
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1029
;1029:			if (braceCount < 0) {
ADDRLP4 2064
INDIRI4
CNSTI4 0
GEI4 $410
line 1030
;1030:				Com_Printf("^1PC_Parenthesis_Parse() braceCount < 0 (%d)\n", braceCount);
ADDRGP4 $412
ARGP4
ADDRLP4 2064
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1031
;1031:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $390
JUMPV
LABELV $410
line 1032
;1032:			} else if (braceCount == 0) {
ADDRLP4 2064
INDIRI4
CNSTI4 0
NEI4 $408
line 1033
;1033:				*out = String_Alloc(script);
ADDRLP4 1040
ARGP4
ADDRLP4 2084
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ADDRLP4 2084
INDIRP4
ASGNP4
line 1034
;1034:				if (!*out) {
ADDRFP4 4
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $415
line 1035
;1035:					Com_Printf("^1PC_Parenthesis_Parse() couldn't allocate string\n");
ADDRGP4 $417
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1036
;1036:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $390
JUMPV
LABELV $415
line 1038
;1037:				}
;1038:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $390
JUMPV
line 1040
;1039:			}
;1040:		} else if (Q_stricmp(token.string, "(") == 0) {
LABELV $407
ADDRLP4 0+16
ARGP4
ADDRGP4 $367
ARGP4
ADDRLP4 2084
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2084
INDIRI4
CNSTI4 0
NEI4 $418
line 1041
;1041:			braceCount++;
ADDRLP4 2064
ADDRLP4 2064
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1042
;1042:		}
LABELV $418
LABELV $408
line 1044
;1043:
;1044:		if (token.string[1] != '\0') {
ADDRLP4 0+16+1
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $421
line 1045
;1045:			Q_strcat(script, 1024, va("\"%s\"", token.string));
ADDRGP4 $315
ARGP4
ADDRLP4 0+16
ARGP4
ADDRLP4 2088
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1040
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2088
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 1046
;1046:		} else {
ADDRGP4 $422
JUMPV
LABELV $421
line 1047
;1047:			Q_strcat(script, 1024, token.string);
ADDRLP4 1040
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 0+16
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 1048
;1048:		}
LABELV $422
line 1049
;1049:		Q_strcat(script, 1024, " ");
ADDRLP4 1040
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $316
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 1050
;1050:	}
LABELV $402
line 1022
ADDRGP4 $401
JUMPV
line 1053
;1051:
;1052:	// shouldn't get here
;1053:	return qfalse;
CNSTI4 0
RETI4
LABELV $390
endproc PC_Parenthesis_Parse 2092 12
export Init_Display
proc Init_Display 0 0
line 1066
;1054:}
;1055:
;1056:// display, window, menu, item code
;1057://
;1058:
;1059:/*
;1060:==================
;1061:Init_Display
;1062:
;1063:Initializes the display with a structure to all the drawing routines
;1064: ==================
;1065:*/
;1066:void Init_Display(displayContextDef_t *dc) {
line 1067
;1067:	DC = dc;
ADDRGP4 DC
ADDRFP4 0
INDIRP4
ASGNP4
line 1068
;1068:}
LABELV $427
endproc Init_Display 0 0
proc GradientBar_Paint 8 24
line 1074
;1069:
;1070:
;1071:
;1072:// type and style painting 
;1073:
;1074:static void GradientBar_Paint(rectDef_t *rect, vec4_t color, int widescreen) { //, rectDef_t menuRect) {
line 1076
;1075:	// gradient bar takes two paints
;1076:	DC->setColor(color);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 1077
;1077:	DC->drawHandlePic(rect->x, rect->y, rect->w, rect->h, DC->Assets.gradientBar, widescreen); //, menuRect);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 5342736
ADDP4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 1078
;1078:	DC->setColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 1079
;1079:}
LABELV $428
endproc GradientBar_Paint 8 24
proc Window_Init 8 12
line 1090
;1080:
;1081:
;1082:/*
;1083:==================
;1084:Window_Init
;1085:
;1086:Initializes a window structure ( windowDef_t ) with defaults
;1087:
;1088:==================
;1089:*/
;1090:static void Window_Init(Window *w) {
line 1091
;1091:	memset(w, 0, sizeof(windowDef_t));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 188
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1092
;1092:	w->borderSize = 1;
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
CNSTF4 1065353216
ASGNF4
line 1093
;1093:	w->foreColor[0] = w->foreColor[1] = w->foreColor[2] = w->foreColor[3] = 1.0;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 124
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 1094
;1094:	w->cinematic = -1;
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 -1
ASGNI4
line 1095
;1095:}
LABELV $429
endproc Window_Init 8 12
proc Fade 8 0
line 1097
;1096:
;1097:static void Fade(int *flags, float *f, float clamp, int *nextTime, int offsetTime, qboolean bFlags, float fadeAmount) {
line 1098
;1098:	if (*flags & (WINDOW_FADINGOUT | WINDOW_FADINGIN)) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 96
BANDI4
CNSTI4 0
EQI4 $431
line 1099
;1099:		if (DC->realTime > *nextTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ADDRFP4 12
INDIRP4
INDIRI4
LEI4 $433
line 1100
;1100:			*nextTime = DC->realTime + offsetTime;
ADDRFP4 12
INDIRP4
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ADDRFP4 16
INDIRI4
ADDI4
ASGNI4
line 1101
;1101:			if (*flags & WINDOW_FADINGOUT) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $435
line 1102
;1102:				*f -= fadeAmount;
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 24
INDIRF4
SUBF4
ASGNF4
line 1103
;1103:				if (bFlags && *f <= 0.0) {
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $436
ADDRFP4 4
INDIRP4
INDIRF4
CNSTF4 0
GTF4 $436
line 1104
;1104:					*flags &= ~(WINDOW_FADINGOUT | WINDOW_VISIBLE);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -37
BANDI4
ASGNI4
line 1105
;1105:				}
line 1106
;1106:			} else {
ADDRGP4 $436
JUMPV
LABELV $435
line 1107
;1107:				*f += fadeAmount;
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 24
INDIRF4
ADDF4
ASGNF4
line 1108
;1108:				if (*f >= clamp) {
ADDRFP4 4
INDIRP4
INDIRF4
ADDRFP4 8
INDIRF4
LTF4 $439
line 1109
;1109:					*f = clamp;
ADDRFP4 4
INDIRP4
ADDRFP4 8
INDIRF4
ASGNF4
line 1110
;1110:					if (bFlags) {
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $441
line 1111
;1111:						*flags &= ~WINDOW_FADINGIN;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -65
BANDI4
ASGNI4
line 1112
;1112:					}
LABELV $441
line 1113
;1113:				}
LABELV $439
line 1114
;1114:			}
LABELV $436
line 1115
;1115:		}
LABELV $433
line 1116
;1116:	}
LABELV $431
line 1117
;1117:}
LABELV $430
endproc Fade 8 0
data
align 4
LABELV $444
byte 4 0
skip 12
code
proc Window_Paint 56 28
line 1121
;1118:
;1119:
;1120:
;1121:static void Window_Paint(Window *w, float fadeAmount, float fadeClamp, float fadeCycle, int widescreen) { //, rectDef_t menuRect) {
line 1123
;1122:	//float bordersize = 0;
;1123:	vec4_t color = { 0 };
ADDRLP4 16
ADDRGP4 $444
INDIRB
ASGNB 16
line 1126
;1124:	rectDef_t fillRect;
;1125:
;1126:	if (w == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $445
line 1127
;1127:		return;
ADDRGP4 $443
JUMPV
LABELV $445
line 1132
;1128:	}
;1129:
;1130:	//Com_Printf("window paint\n");
;1131:
;1132:	if (debugMode) {
ADDRGP4 debugMode
INDIRI4
CNSTI4 0
EQI4 $447
line 1133
;1133:		color[0] = color[1] = color[2] = color[3] = 1;
ADDRLP4 32
CNSTF4 1065353216
ASGNF4
ADDRLP4 16+12
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 16+8
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 32
INDIRF4
ASGNF4
line 1134
;1134:		DC->drawRect(w->rect.x, w->rect.y, w->rect.w, w->rect.h, 1, color, widescreen); //, menuRect);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 16
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 1135
;1135:	}
LABELV $447
line 1137
;1136:
;1137:	if (w->style == 0 && w->border == 0) {
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 0
NEI4 $452
ADDRLP4 32
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
NEI4 $452
line 1138
;1138:		return;
ADDRGP4 $443
JUMPV
LABELV $452
line 1141
;1139:	}
;1140:
;1141:	fillRect = w->rect;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 16
line 1143
;1142:
;1143:	if (w->border != 0) {
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $454
line 1144
;1144:		fillRect.x += w->borderSize;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1145
;1145:		fillRect.y += w->borderSize;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1146
;1146:		fillRect.w -= w->borderSize + 1;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
SUBF4
ASGNF4
line 1147
;1147:		fillRect.h -= w->borderSize + 1;
ADDRLP4 0+12
ADDRLP4 0+12
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
SUBF4
ASGNF4
line 1148
;1148:	}
LABELV $454
line 1150
;1149:
;1150:	if (w->style == WINDOW_STYLE_FILLED) {
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 1
NEI4 $459
line 1152
;1151:		// box, but possible a shader that needs filled
;1152:		if (w->background) {
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 0
EQI4 $461
line 1153
;1153:			Fade(&w->flags, &w->backColor[3], fadeClamp, &w->nextTime, fadeCycle, qtrue, fadeAmount);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 72
ADDP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRFP4 12
INDIRF4
CVFI4 4
ARGI4
CNSTI4 1
ARGI4
ADDRFP4 4
INDIRF4
ARGF4
ADDRGP4 Fade
CALLV
pop
line 1154
;1154:			DC->setColor(w->backColor);
ADDRFP4 0
INDIRP4
CNSTI4 132
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 1155
;1155:			DC->drawHandlePic(fillRect.x, fillRect.y, fillRect.w, fillRect.h, w->background, widescreen); //, menuRect);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 1156
;1156:			DC->setColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 1157
;1157:		} else {
ADDRGP4 $460
JUMPV
LABELV $461
line 1158
;1158:			DC->fillRect(fillRect.x, fillRect.y, fillRect.w, fillRect.h, w->backColor, widescreen); //, menuRect);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 132
ADDP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
CALLV
pop
line 1159
;1159:		}
line 1160
;1160:	} else if (w->style == WINDOW_STYLE_GRADIENT) {
ADDRGP4 $460
JUMPV
LABELV $459
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 2
NEI4 $469
line 1161
;1161:		GradientBar_Paint(&fillRect, w->backColor, widescreen); //, menuRect);
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 132
ADDP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 GradientBar_Paint
CALLV
pop
line 1163
;1162:		// gradient bar
;1163:	} else if (w->style == WINDOW_STYLE_SHADER) {
ADDRGP4 $470
JUMPV
LABELV $469
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 3
NEI4 $471
line 1164
;1164:		if (w->flags & WINDOW_FORECOLORSET) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $473
line 1165
;1165:			DC->setColor(w->foreColor);
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 1166
;1166:		}
LABELV $473
line 1167
;1167:		DC->drawHandlePic(fillRect.x, fillRect.y, fillRect.w, fillRect.h, w->background, widescreen); //, menuRect);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 1168
;1168:		DC->setColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 1169
;1169:	} else if (w->style == WINDOW_STYLE_TEAMCOLOR) {
ADDRGP4 $472
JUMPV
LABELV $471
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 4
NEI4 $478
line 1170
;1170:		if (DC->getTeamColor) {
ADDRGP4 DC
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $479
line 1171
;1171:			DC->getTeamColor(&color);
ADDRLP4 16
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
CALLV
pop
line 1172
;1172:			DC->fillRect(fillRect.x, fillRect.y, fillRect.w, fillRect.h, color, widescreen); //, menuRect);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRLP4 16
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
CALLV
pop
line 1173
;1173:		}
line 1174
;1174:	} else if (w->style == WINDOW_STYLE_CINEMATIC) {
ADDRGP4 $479
JUMPV
LABELV $478
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $485
line 1175
;1175:		if (w->cinematic == -1) {
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $487
line 1176
;1176:			w->cinematic = DC->playCinematic(w->cinematicName, fillRect.x, fillRect.y, fillRect.w, fillRect.h, widescreen); //, menuRect);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 DC
INDIRP4
CNSTI4 184
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 36
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1177
;1177:			if (w->cinematic == -1) {
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $492
line 1178
;1178:				w->cinematic = -2;
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 -2
ASGNI4
line 1179
;1179:			}
LABELV $492
line 1180
;1180:		}
LABELV $487
line 1181
;1181:		if (w->cinematic >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LTI4 $494
line 1183
;1182:			//FIXME why two calls?
;1183:			DC->runCinematicFrame(w->cinematic);
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 196
ADDP4
INDIRP4
CALLV
pop
line 1184
;1184:			DC->drawCinematic(w->cinematic, fillRect.x, fillRect.y, fillRect.w, fillRect.h, widescreen); //, menuRect);
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0+4
INDIRF4
ARGF4
ADDRLP4 0+8
INDIRF4
ARGF4
ADDRLP4 0+12
INDIRF4
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 192
ADDP4
INDIRP4
CALLV
pop
line 1185
;1185:		}
LABELV $494
line 1186
;1186:	}
LABELV $485
LABELV $479
LABELV $472
LABELV $470
LABELV $460
line 1188
;1187:
;1188:	if (w->border == WINDOW_BORDER_FULL) {
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 1
NEI4 $499
line 1191
;1189:		// full
;1190:		// HACK HACK HACK
;1191:		if (w->style == WINDOW_STYLE_TEAMCOLOR) {
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 4
NEI4 $501
line 1192
;1192:			if (color[0] > 0) {
ADDRLP4 16
INDIRF4
CNSTF4 0
LEF4 $503
line 1194
;1193:				// red
;1194:				color[0] = 1;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
line 1195
;1195:				color[1] = color[2] = .5;
ADDRLP4 36
CNSTF4 1056964608
ASGNF4
ADDRLP4 16+8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 16+4
ADDRLP4 36
INDIRF4
ASGNF4
line 1197
;1196:
;1197:			} else {
ADDRGP4 $504
JUMPV
LABELV $503
line 1198
;1198:				color[2] = 1;
ADDRLP4 16+8
CNSTF4 1065353216
ASGNF4
line 1199
;1199:				color[0] = color[1] = .5;
ADDRLP4 36
CNSTF4 1056964608
ASGNF4
ADDRLP4 16+4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 16
ADDRLP4 36
INDIRF4
ASGNF4
line 1200
;1200:			}
LABELV $504
line 1201
;1201:			color[3] = 1;
ADDRLP4 16+12
CNSTF4 1065353216
ASGNF4
line 1202
;1202:			DC->drawRect(w->rect.x, w->rect.y, w->rect.w, w->rect.h, w->borderSize, color, widescreen); //, menuRect);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 1203
;1203:		} else {
ADDRGP4 $500
JUMPV
LABELV $501
line 1204
;1204:			DC->drawRect(w->rect.x, w->rect.y, w->rect.w, w->rect.h, w->borderSize, w->borderColor, widescreen); //, menuRect);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 148
ADDP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 1205
;1205:		}
line 1206
;1206:	} else if (w->border == WINDOW_BORDER_HORZ) {
ADDRGP4 $500
JUMPV
LABELV $499
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 2
NEI4 $510
line 1208
;1207:		// top/bottom
;1208:		DC->setColor(w->borderColor);
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 1209
;1209:		DC->drawTopBottom(w->rect.x, w->rect.y, w->rect.w, w->rect.h, w->borderSize, widescreen); //, menuRect);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CALLV
pop
line 1210
;1210:		DC->setColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 1211
;1211:	} else if (w->border == WINDOW_BORDER_VERT) {
ADDRGP4 $511
JUMPV
LABELV $510
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 3
NEI4 $512
line 1213
;1212:		// left right
;1213:		DC->setColor(w->borderColor);
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 1214
;1214:		DC->drawSides(w->rect.x, w->rect.y, w->rect.w, w->rect.h, w->borderSize, widescreen); //, menuRect);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
CALLV
pop
line 1215
;1215:		DC->setColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 1216
;1216:	} else if (w->border == WINDOW_BORDER_KCGRADIENT) {
ADDRGP4 $513
JUMPV
LABELV $512
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 4
NEI4 $514
line 1218
;1217:		// this is just two gradient bars along each horz edge
;1218:		rectDef_t r = w->rect;
ADDRLP4 36
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 16
line 1219
;1219:		r.h = w->borderSize;
ADDRLP4 36+12
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ASGNF4
line 1220
;1220:		GradientBar_Paint(&r, w->borderColor, widescreen); //, menuRect);
ADDRLP4 36
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 GradientBar_Paint
CALLV
pop
line 1221
;1221:		r.y = w->rect.y + w->rect.h - 1;
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36+4
ADDRLP4 52
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 1222
;1222:		GradientBar_Paint(&r, w->borderColor, widescreen); //, menuRect);
ADDRLP4 36
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 GradientBar_Paint
CALLV
pop
line 1223
;1223:	}
LABELV $514
LABELV $513
LABELV $511
LABELV $500
line 1225
;1224:
;1225:}
LABELV $443
endproc Window_Paint 56 28
proc Item_SetScreenCoords 16 0
line 1228
;1226:
;1227:
;1228:static void Item_SetScreenCoords(itemDef_t *item, float x, float y) {
line 1230
;1229:
;1230:	if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $519
line 1231
;1231:		return;
ADDRGP4 $518
JUMPV
LABELV $519
line 1234
;1232:	}
;1233:
;1234:	if (item->window.border != 0) {
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $521
line 1235
;1235:		x += item->window.borderSize;
ADDRFP4 4
ADDRFP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1236
;1236:		y += item->window.borderSize;
ADDRFP4 8
ADDRFP4 8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1237
;1237:	}
LABELV $521
line 1239
;1238:
;1239:	item->window.rect.x = x + item->window.rectClient.x;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRFP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1240
;1240:	item->window.rect.y = y + item->window.rectClient.y;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 8
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1241
;1241:	item->window.rect.w = item->window.rectClient.w;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1242
;1242:	item->window.rect.h = item->window.rectClient.h;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ASGNF4
line 1245
;1243:
;1244:	// force the text rects to recompute
;1245:	item->textRect.w = 0;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 0
ASGNF4
line 1246
;1246:	item->textRect.h = 0;
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
CNSTF4 0
ASGNF4
line 1247
;1247:}
LABELV $518
endproc Item_SetScreenCoords 16 0
proc Item_UpdatePosition 16 12
line 1250
;1248:
;1249:// FIXME: consolidate this with nearby stuff
;1250:static void Item_UpdatePosition(itemDef_t *item) {
line 1254
;1251:	float x, y;
;1252:	menuDef_t *menu;
;1253:
;1254:	if (item == NULL || item->parent == NULL) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $526
ADDRLP4 12
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $524
LABELV $526
line 1255
;1255:		return;
ADDRGP4 $523
JUMPV
LABELV $524
line 1258
;1256:	}
;1257:
;1258:	menu = item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 1260
;1259:
;1260:	x = menu->window.rect.x;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRF4
ASGNF4
line 1261
;1261:	y = menu->window.rect.y;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1263
;1262:
;1263:	if (menu->window.border != 0) {
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $527
line 1264
;1264:		x += menu->window.borderSize;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1265
;1265:		y += menu->window.borderSize;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1266
;1266:	}
LABELV $527
line 1268
;1267:
;1268:	Item_SetScreenCoords(item, x, y);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 Item_SetScreenCoords
CALLV
pop
line 1270
;1269:
;1270:}
LABELV $523
endproc Item_UpdatePosition 16 12
proc Menu_UpdatePosition 12 12
line 1273
;1271:
;1272:// menus
;1273:static void Menu_UpdatePosition(menuDef_t *menu) {
line 1277
;1274:	int i;
;1275:	float x, y;
;1276:
;1277:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $530
line 1278
;1278:		return;
ADDRGP4 $529
JUMPV
LABELV $530
line 1281
;1279:	}
;1280:
;1281:	x = menu->window.rect.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 1282
;1282:	y = menu->window.rect.y;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1283
;1283:	if (menu->window.border != 0) {
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $532
line 1284
;1284:		x += menu->window.borderSize;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1285
;1285:		y += menu->window.borderSize;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1286
;1286:	}
LABELV $532
line 1288
;1287:
;1288:	for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $537
JUMPV
LABELV $534
line 1289
;1289:		Item_SetScreenCoords(menu->items[i], x, y);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 Item_SetScreenCoords
CALLV
pop
line 1290
;1290:	}
LABELV $535
line 1288
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $537
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
LTI4 $534
line 1291
;1291:}
LABELV $529
endproc Menu_UpdatePosition 12 12
proc Menu_PostParse 0 4
line 1293
;1292:
;1293:static void Menu_PostParse(menuDef_t *menu) {
line 1294
;1294:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $539
line 1295
;1295:		return;
ADDRGP4 $538
JUMPV
LABELV $539
line 1297
;1296:	}
;1297:	if (menu->fullScreen) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 0
EQI4 $541
line 1298
;1298:		menu->window.rect.x = 0;
ADDRFP4 0
INDIRP4
CNSTF4 0
ASGNF4
line 1299
;1299:		menu->window.rect.y = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
line 1300
;1300:		menu->window.rect.w = SCREEN_WIDTH;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1142947840
ASGNF4
line 1301
;1301:		menu->window.rect.h = SCREEN_HEIGHT;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1139802112
ASGNF4
line 1302
;1302:	}
LABELV $541
line 1303
;1303:	Menu_UpdatePosition(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_UpdatePosition
CALLV
pop
line 1304
;1304:}
LABELV $538
endproc Menu_PostParse 0 4
proc Menu_ClearFocus 20 8
line 1306
;1305:
;1306:static itemDef_t *Menu_ClearFocus(menuDef_t *menu) {
line 1308
;1307:	int i;
;1308:	itemDef_t *ret = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 1310
;1309:
;1310:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $544
line 1311
;1311:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $543
JUMPV
LABELV $544
line 1314
;1312:	}
;1313:
;1314:	for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $549
JUMPV
LABELV $546
line 1315
;1315:		if (menu->items[i]->window.flags & WINDOW_HASFOCUS) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $550
line 1316
;1316:			ret = menu->items[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
ASGNP4
line 1317
;1317:		}
LABELV $550
line 1318
;1318:		menu->items[i]->window.flags &= ~WINDOW_HASFOCUS;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 1319
;1319:		if (menu->items[i]->leaveFocus) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 280
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $552
line 1320
;1320:			Item_RunScript(menu->items[i], menu->items[i]->leaveFocus);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 280
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1321
;1321:		}
LABELV $552
line 1322
;1322:	}
LABELV $547
line 1314
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $549
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
LTI4 $546
line 1324
;1323:
;1324:	return ret;
ADDRLP4 4
INDIRP4
RETP4
LABELV $543
endproc Menu_ClearFocus 20 8
proc IsVisible 8 0
line 1327
;1325:}
;1326:
;1327:static qboolean IsVisible(int flags) {
line 1328
;1328:	return (flags & WINDOW_VISIBLE && !(flags & WINDOW_FADINGOUT));
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $556
ADDRLP4 4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $556
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $557
JUMPV
LABELV $556
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $557
ADDRLP4 0
INDIRI4
RETI4
LABELV $554
endproc IsVisible 8 0
proc Rect_ContainsPoint 16 0
line 1331
;1329:}
;1330:
;1331:static qboolean Rect_ContainsPoint(const rectDef_t *rect, float x, float y) {
line 1332
;1332:	if (rect) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $559
line 1333
;1333:		if (x > rect->x && x < rect->x + rect->w && y > rect->y && y < rect->y + rect->h) {
ADDRLP4 0
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $561
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
GEF4 $561
ADDRLP4 12
ADDRFP4 8
INDIRF4
ASGNF4
ADDRLP4 12
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
LEF4 $561
ADDRLP4 12
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
GEF4 $561
line 1334
;1334:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $558
JUMPV
LABELV $561
line 1336
;1335:		}
;1336:	}
LABELV $559
line 1337
;1337:	return qfalse;
CNSTI4 0
RETI4
LABELV $558
endproc Rect_ContainsPoint 16 0
proc Rect_ContainsWidescreenPoint 44 12
line 1385
;1338:}
;1339:
;1340:#if 0
;1341:static qboolean Item_ContainsPoint(const itemDef_t *item, float x, float y) {
;1342:	rectDef_t rect;
;1343:	float aspect;
;1344:	float width43;
;1345:	float diff;
;1346:	float diff640;
;1347:	float newXScale;
;1348:
;1349:	if (!item) {
;1350:		Com_Printf("^1Item_ContainsPoint item == NULL\n");
;1351:		return qfalse;
;1352:	}
;1353:
;1354:	memcpy(&rect, &item->window.rect, sizeof(rectDef_t));
;1355:	//FIXME get cg_wideScreen value
;1356:
;1357:	//FIXME store calculations
;1358:	aspect = (float)DC->glconfig.vidWidth / (float)DC->glconfig.vidHeight;
;1359:
;1360:	width43 = 4.0f * (DC->glconfig.vidHeight / 3.0);
;1361:	diff = (float)DC->glconfig.vidWidth - width43;
;1362:
;1363:	diff640 = (float)SCREEN_WIDTH * diff / (float)DC->glconfig.vidWidth;
;1364:	newXScale = width43 / (float)DC->glconfig.vidWidth;
;1365:
;1366:	// already scaled to 640x480, reverse and apply new
;1367:
;1368:	if (item->widescreen == WIDESCREEN_STRETCH || aspect <= 1.25f) {
;1369:		//use regular scaling, don't alter rect values
;1370:	} else if (item->widescreen == WIDESCREEN_LEFT) {
;1371:		rect.w *= newXScale;
;1372:	} else if (item->widescreen == WIDESCREEN_CENTER) {
;1373:		rect.w *= newXScale;
;1374:		rect.x *= newXScale;
;1375:		rect.x += diff640 / 2;
;1376:	} else if (item->widescreen == WIDESCREEN_RIGHT) {
;1377:		rect.w *= newXScale;
;1378:		rect.x += diff640;
;1379:	}
;1380:
;1381:	return Rect_ContainsPoint(&rect, x, y);
;1382:}
;1383:#endif
;1384:
;1385:static qboolean Rect_ContainsWidescreenPoint(const rectDef_t *rectIn, float x, float y, int widescreen) {
line 1393
;1386:	rectDef_t rect;
;1387:	float aspect;
;1388:	float width43;
;1389:	float diff;
;1390:	float diff640;
;1391:	float newXScale;
;1392:
;1393:	if (!rectIn) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $564
line 1394
;1394:		Com_Printf("^1Rect_ContainsWidescreenPoint rectIn == NULL\n");
ADDRGP4 $566
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1395
;1395:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $563
JUMPV
LABELV $564
line 1398
;1396:	}
;1397:
;1398:	memcpy(&rect, rectIn, sizeof(rectDef_t));
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1401
;1399:
;1400:	//FIXME store calculations
;1401:	aspect = (float)DC->glconfig.vidWidth / (float)DC->glconfig.vidHeight;
ADDRLP4 36
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 36
INDIRP4
CNSTI4 5354300
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 36
INDIRP4
CNSTI4 5354304
ADDP4
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 1403
;1402:
;1403:	width43 = 4.0f * (DC->glconfig.vidHeight / 3.0);
ADDRLP4 0
ADDRGP4 DC
INDIRP4
CNSTI4 5354304
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1051372203
MULF4
CNSTF4 1082130432
MULF4
ASGNF4
line 1404
;1404:	diff = (float)DC->glconfig.vidWidth - width43;
ADDRLP4 24
ADDRGP4 DC
INDIRP4
CNSTI4 5354300
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
line 1406
;1405:
;1406:	diff640 = (float)SCREEN_WIDTH * diff / (float)DC->glconfig.vidWidth;
ADDRLP4 32
ADDRLP4 24
INDIRF4
CNSTF4 1142947840
MULF4
ADDRGP4 DC
INDIRP4
CNSTI4 5354300
ADDP4
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 1407
;1407:	newXScale = width43 / (float)DC->glconfig.vidWidth;
ADDRLP4 28
ADDRLP4 0
INDIRF4
ADDRGP4 DC
INDIRP4
CNSTI4 5354300
ADDP4
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 1411
;1408:
;1409:	// already scaled to 640x480, reverse and apply new
;1410:
;1411:	if (widescreen == WIDESCREEN_STRETCH || aspect <= 1.25f || DC->widescreen != 5) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $570
ADDRLP4 20
INDIRF4
CNSTF4 1067450368
LEF4 $570
ADDRGP4 DC
INDIRP4
CNSTI4 5354344
ADDP4
INDIRI4
CNSTI4 5
EQI4 $567
LABELV $570
line 1413
;1412:		//use regular scaling, don't alter rect values
;1413:	} else if (widescreen == WIDESCREEN_LEFT) {
ADDRGP4 $568
JUMPV
LABELV $567
ADDRFP4 12
INDIRI4
CNSTI4 1
NEI4 $571
line 1414
;1414:		rect.w *= newXScale;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 1415
;1415:	} else if (widescreen == WIDESCREEN_CENTER) {
ADDRGP4 $572
JUMPV
LABELV $571
ADDRFP4 12
INDIRI4
CNSTI4 2
NEI4 $574
line 1416
;1416:		rect.w *= newXScale;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 1417
;1417:		rect.x *= newXScale;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 1418
;1418:		rect.x += diff640 / 2;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 32
INDIRF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
line 1419
;1419:	} else if (widescreen == WIDESCREEN_RIGHT) {
ADDRGP4 $575
JUMPV
LABELV $574
ADDRFP4 12
INDIRI4
CNSTI4 3
NEI4 $577
line 1420
;1420:		rect.w *= newXScale;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 1421
;1421:		rect.x += diff640;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ASGNF4
line 1422
;1422:	}
LABELV $577
LABELV $575
LABELV $572
LABELV $568
line 1424
;1423:
;1424:	return Rect_ContainsPoint(&rect, x, y);
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
RETI4
LABELV $563
endproc Rect_ContainsWidescreenPoint 44 12
proc CursorX_Widescreen 28 0
line 1429
;1425:}
;1426:
;1427:// assumes cursor is being drawn fullscreen (widescreen == WIDESCREEN_STRETCH),
;1428:// converts to the relative 640x480 coordinates of the widescreen hud
;1429:static float CursorX_Widescreen(int widescreen) {
line 1437
;1430:	float aspect;
;1431:	float width43;
;1432:	float diff;
;1433:	float realXScale;
;1434:	float newXScale;
;1435:	float x;
;1436:
;1437:	x = DC->cursorx;
ADDRLP4 0
ADDRGP4 DC
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1440
;1438:
;1439:	//FIXME store calculations
;1440:	aspect = (float)DC->glconfig.vidWidth / (float)DC->glconfig.vidHeight;
ADDRLP4 24
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 24
INDIRP4
CNSTI4 5354300
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 24
INDIRP4
CNSTI4 5354304
ADDP4
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 1441
;1441:	width43 = 4.0 * (DC->glconfig.vidHeight / 3.0f);
ADDRLP4 4
ADDRGP4 DC
INDIRP4
CNSTI4 5354304
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1051372203
MULF4
CNSTF4 1082130432
MULF4
ASGNF4
line 1442
;1442:	diff = (float)DC->glconfig.vidWidth - width43;
ADDRLP4 20
ADDRGP4 DC
INDIRP4
CNSTI4 5354300
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 1444
;1443:
;1444:	realXScale = (float)DC->glconfig.vidWidth / (float)SCREEN_WIDTH;
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 5354300
ADDP4
INDIRI4
CVIF4 4
CNSTF4 986500301
MULF4
ASGNF4
line 1445
;1445:	newXScale = (float)SCREEN_WIDTH / width43;
ADDRLP4 16
CNSTF4 1142947840
ADDRLP4 4
INDIRF4
DIVF4
ASGNF4
line 1447
;1446:
;1447:	if (widescreen == WIDESCREEN_STRETCH || aspect <= 1.25f || DC->widescreen != 5) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $584
ADDRLP4 8
INDIRF4
CNSTF4 1067450368
LEF4 $584
ADDRGP4 DC
INDIRP4
CNSTI4 5354344
ADDP4
INDIRI4
CNSTI4 5
EQI4 $581
LABELV $584
line 1449
;1448:		//use regular scaling, don't chage x
;1449:	} else if (widescreen == WIDESCREEN_LEFT) {
ADDRGP4 $582
JUMPV
LABELV $581
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $585
line 1450
;1450:		x *= realXScale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
line 1451
;1451:		x *= newXScale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 1452
;1452:	} else if (widescreen == WIDESCREEN_CENTER) {
ADDRGP4 $586
JUMPV
LABELV $585
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $587
line 1453
;1453:		x *= realXScale;  // where we really are
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
line 1454
;1454:		x -= diff / 2;  // relative to widescreen box
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRF4
CNSTF4 1056964608
MULF4
SUBF4
ASGNF4
line 1455
;1455:		x *= newXScale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 1456
;1456:	} else if (widescreen == WIDESCREEN_RIGHT) {
ADDRGP4 $588
JUMPV
LABELV $587
ADDRFP4 0
INDIRI4
CNSTI4 3
NEI4 $589
line 1457
;1457:		x *= realXScale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
line 1458
;1458:		x -= diff;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
ASGNF4
line 1459
;1459:		x *= newXScale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ASGNF4
line 1460
;1460:	}
LABELV $589
LABELV $588
LABELV $586
LABELV $582
line 1462
;1461:
;1462:	if (x < 0.0f) {
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $591
line 1463
;1463:		x = 0.0f;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1464
;1464:	} else if (x > (float)SCREEN_WIDTH) {
ADDRGP4 $592
JUMPV
LABELV $591
ADDRLP4 0
INDIRF4
CNSTF4 1142947840
LEF4 $593
line 1465
;1465:		x = (float)SCREEN_WIDTH;
ADDRLP4 0
CNSTF4 1142947840
ASGNF4
line 1466
;1466:	}
LABELV $593
LABELV $592
line 1468
;1467:
;1468:	return x;
ADDRLP4 0
INDIRF4
RETF4
LABELV $580
endproc CursorX_Widescreen 28 0
proc Menu_ItemsMatchingGroup 24 8
line 1471
;1469:}
;1470:
;1471:static int Menu_ItemsMatchingGroup(menuDef_t *menu, const char *name) {
line 1473
;1472:	int i;
;1473:	int count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1474
;1474:	for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $599
JUMPV
LABELV $596
line 1475
;1475:		if (Q_stricmp(menu->items[i]->window.name, name) == 0 || (menu->items[i]->window.group && Q_stricmp(menu->items[i]->window.group, name) == 0)) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $602
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $600
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 36
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
NEI4 $600
LABELV $602
line 1476
;1476:			count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1477
;1477:		}
LABELV $600
line 1478
;1478:	}
LABELV $597
line 1474
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $599
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
LTI4 $596
line 1479
;1479:	return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $595
endproc Menu_ItemsMatchingGroup 24 8
proc Menu_GetMatchingItemByNumber 24 8
line 1482
;1480:}
;1481:
;1482:static itemDef_t *Menu_GetMatchingItemByNumber(menuDef_t *menu, int index, const char *name) {
line 1484
;1483:	int i;
;1484:	int count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1485
;1485:	for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $607
JUMPV
LABELV $604
line 1486
;1486:		if (Q_stricmp(menu->items[i]->window.name, name) == 0 || (menu->items[i]->window.group && Q_stricmp(menu->items[i]->window.group, name) == 0)) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $610
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $608
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $608
LABELV $610
line 1487
;1487:			if (count == index) {
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $611
line 1488
;1488:				return menu->items[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $603
JUMPV
LABELV $611
line 1490
;1489:			}
;1490:			count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1491
;1491:		}
LABELV $608
line 1492
;1492:	}
LABELV $605
line 1485
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $607
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
LTI4 $604
line 1493
;1493:	return NULL;
CNSTP4 0
RETP4
LABELV $603
endproc Menu_GetMatchingItemByNumber 24 8
proc Script_SetColor 36 8
line 1498
;1494:}
;1495:
;1496:
;1497:
;1498:static void Script_SetColor(itemDef_t *item, char **args) {
line 1504
;1499:	const char *name;
;1500:	int i;
;1501:	float f;
;1502:	vec4_t *out;
;1503:	// expecting type of color to set and 4 args for the color
;1504:	if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 16
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $614
line 1505
;1505:		out = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 1506
;1506:		if (Q_stricmp(name, "backcolor") == 0) {
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $618
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $616
line 1507
;1507:			out = &item->window.backColor;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 132
ADDP4
ASGNP4
line 1508
;1508:			item->window.flags |= WINDOW_BACKCOLORSET;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 4194304
BORI4
ASGNI4
line 1509
;1509:		} else if (Q_stricmp(name, "forecolor") == 0) {
ADDRGP4 $617
JUMPV
LABELV $616
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $621
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $619
line 1510
;1510:			out = &item->window.foreColor;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ASGNP4
line 1511
;1511:			item->window.flags |= WINDOW_FORECOLORSET;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 1512
;1512:		} else if (Q_stricmp(name, "bordercolor") == 0) {
ADDRGP4 $620
JUMPV
LABELV $619
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $624
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $622
line 1513
;1513:			out = &item->window.borderColor;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
ASGNP4
line 1514
;1514:		}
LABELV $622
LABELV $620
LABELV $617
line 1516
;1515:
;1516:		if (out) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $625
line 1517
;1517:			for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $627
line 1518
;1518:				if (!Float_Parse(args, &f)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 32
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $631
line 1519
;1519:					return;
ADDRGP4 $613
JUMPV
LABELV $631
line 1521
;1520:				}
;1521:				(*out)[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 1522
;1522:			}
LABELV $628
line 1517
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $627
line 1523
;1523:		}
LABELV $625
line 1524
;1524:	}
LABELV $614
line 1525
;1525:}
LABELV $613
endproc Script_SetColor 36 8
proc Script_SetAsset 8 8
line 1527
;1526:
;1527:static void Script_SetAsset(itemDef_t *item, char **args) {
line 1530
;1528:	const char *name;
;1529:	// expecting name to set asset to
;1530:	if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $634
line 1532
;1531:		// check for a model 
;1532:		if (item->type == ITEM_TYPE_MODEL) {
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 7
NEI4 $636
line 1533
;1533:		}
LABELV $636
line 1534
;1534:	}
LABELV $634
line 1535
;1535:}
LABELV $633
endproc Script_SetAsset 8 8
proc Script_SetBackground 20 8
line 1537
;1536:
;1537:static void Script_SetBackground(itemDef_t *item, char **args) {
line 1541
;1538:	const char *name;
;1539:
;1540:	// expecting name to set asset to
;1541:	if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $639
line 1542
;1542:		if (Q_stricmp(name, item->window.backgroundName)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $641
line 1543
;1543:			item->window.background = DC->registerShaderNoMip(name);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1544
;1544:			item->window.backgroundName = String_Alloc(name);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 16
INDIRP4
ASGNP4
line 1545
;1545:		}
LABELV $641
line 1546
;1546:	}
LABELV $639
line 1547
;1547:}
LABELV $638
endproc Script_SetBackground 20 8
proc Menu_FindItemByName 8 8
line 1550
;1548:
;1549:
;1550:static itemDef_t *Menu_FindItemByName(menuDef_t *menu, const char *p) {
line 1552
;1551:	int i;
;1552:	if (menu == NULL || p == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $646
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $644
LABELV $646
line 1553
;1553:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $643
JUMPV
LABELV $644
line 1556
;1554:	}
;1555:
;1556:	for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $650
JUMPV
LABELV $647
line 1557
;1557:		if (Q_stricmp(p, menu->items[i]->window.name) == 0) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $651
line 1558
;1558:			return menu->items[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $643
JUMPV
LABELV $651
line 1560
;1559:		}
;1560:	}
LABELV $648
line 1556
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $650
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
LTI4 $647
line 1562
;1561:
;1562:	return NULL;
CNSTP4 0
RETP4
LABELV $643
endproc Menu_FindItemByName 8 8
proc Script_SetTeamColor 24 4
line 1565
;1563:}
;1564:
;1565:static void Script_SetTeamColor(itemDef_t *item, char **args) {
line 1566
;1566:	if (DC->getTeamColor) {
ADDRGP4 DC
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $654
line 1569
;1567:		int i;
;1568:		vec4_t color;
;1569:		DC->getTeamColor(&color);
ADDRLP4 4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
CALLV
pop
line 1570
;1570:		for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $656
line 1571
;1571:			item->window.backColor[i] = color[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 132
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ASGNF4
line 1572
;1572:		}
LABELV $657
line 1570
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $656
line 1573
;1573:	}
LABELV $654
line 1574
;1574:}
LABELV $653
endproc Script_SetTeamColor 24 4
proc Script_SetItemColor 80 12
line 1576
;1575:
;1576:static void Script_SetItemColor(itemDef_t *item, char **args) {
line 1583
;1577:	const char *itemname;
;1578:	const char *name;
;1579:	vec4_t color;
;1580:	int i;
;1581:	vec4_t *out;
;1582:	// expecting type of color to set and 4 args for the color
;1583:	if (String_Parse(args, &itemname) && String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 32
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $661
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 36
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $661
line 1586
;1584:		itemDef_t *item2;
;1585:		int j;
;1586:		int count = Menu_ItemsMatchingGroup(item->parent, itemname);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 Menu_ItemsMatchingGroup
CALLI4
ASGNI4
ADDRLP4 48
ADDRLP4 52
INDIRI4
ASGNI4
line 1588
;1587:
;1588:		if (!Color_Parse(args, &color)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 56
ADDRGP4 Color_Parse
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
NEI4 $663
line 1589
;1589:			return;
ADDRGP4 $660
JUMPV
LABELV $663
line 1592
;1590:		}
;1591:
;1592:		for (j = 0; j < count; j++) {
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRGP4 $668
JUMPV
LABELV $665
line 1593
;1593:			item2 = Menu_GetMatchingItemByNumber(item->parent, j, itemname);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 Menu_GetMatchingItemByNumber
CALLP4
ASGNP4
ADDRLP4 44
ADDRLP4 60
INDIRP4
ASGNP4
line 1594
;1594:			if (item2 != NULL) {
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $669
line 1595
;1595:				out = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 1596
;1596:				if (Q_stricmp(name, "backcolor") == 0) {
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 $618
ARGP4
ADDRLP4 64
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $671
line 1597
;1597:					out = &item2->window.backColor;
ADDRLP4 4
ADDRLP4 44
INDIRP4
CNSTI4 132
ADDP4
ASGNP4
line 1598
;1598:				} else if (Q_stricmp(name, "forecolor") == 0) {
ADDRGP4 $672
JUMPV
LABELV $671
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 $621
ARGP4
ADDRLP4 68
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $673
line 1599
;1599:					out = &item2->window.foreColor;
ADDRLP4 4
ADDRLP4 44
INDIRP4
CNSTI4 116
ADDP4
ASGNP4
line 1600
;1600:					item2->window.flags |= WINDOW_FORECOLORSET;
ADDRLP4 72
ADDRLP4 44
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 1601
;1601:				} else if (Q_stricmp(name, "bordercolor") == 0) {
ADDRGP4 $674
JUMPV
LABELV $673
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 $624
ARGP4
ADDRLP4 72
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $675
line 1602
;1602:					out = &item2->window.borderColor;
ADDRLP4 4
ADDRLP4 44
INDIRP4
CNSTI4 148
ADDP4
ASGNP4
line 1603
;1603:				}
LABELV $675
LABELV $674
LABELV $672
line 1605
;1604:
;1605:				if (out) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $677
line 1606
;1606:					for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $679
line 1607
;1607:						(*out)[i] = color[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
INDIRF4
ASGNF4
line 1608
;1608:					}
LABELV $680
line 1606
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $679
line 1609
;1609:				}
LABELV $677
line 1610
;1610:			}
LABELV $669
line 1611
;1611:		}
LABELV $666
line 1592
ADDRLP4 40
ADDRLP4 40
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $668
ADDRLP4 40
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $665
line 1612
;1612:	}
LABELV $661
line 1613
;1613:}
LABELV $660
endproc Script_SetItemColor 80 12
proc Menu_ShowItemByName 24 12
line 1616
;1614:
;1615:
;1616:static void Menu_ShowItemByName(menuDef_t *menu, const char *p, qboolean bShow) {
line 1619
;1617:	itemDef_t *item;
;1618:	int i;
;1619:	int count = Menu_ItemsMatchingGroup(menu, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Menu_ItemsMatchingGroup
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 1620
;1620:	for (i = 0; i < count; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $687
JUMPV
LABELV $684
line 1621
;1621:		item = Menu_GetMatchingItemByNumber(menu, i, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Menu_GetMatchingItemByNumber
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 1622
;1622:		if (item != NULL) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $688
line 1623
;1623:			if (bShow) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $690
line 1624
;1624:				item->window.flags |= WINDOW_VISIBLE;
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 1625
;1625:			} else {
ADDRGP4 $691
JUMPV
LABELV $690
line 1626
;1626:				item->window.flags &= ~WINDOW_VISIBLE;
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 -5
BANDI4
ASGNI4
line 1628
;1627:				// stop cinematics playing in the window
;1628:				if (item->window.cinematic >= 0) {
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LTI4 $692
line 1629
;1629:					DC->stopCinematic(item->window.cinematic);
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 188
ADDP4
INDIRP4
CALLV
pop
line 1630
;1630:					item->window.cinematic = -1;
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 -1
ASGNI4
line 1631
;1631:				}
LABELV $692
line 1632
;1632:			}
LABELV $691
line 1633
;1633:		}
LABELV $688
line 1634
;1634:	}
LABELV $685
line 1620
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $687
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $684
line 1635
;1635:}
LABELV $683
endproc Menu_ShowItemByName 24 12
proc Menu_FadeItemByName 28 12
line 1637
;1636:
;1637:static void Menu_FadeItemByName(menuDef_t *menu, const char *p, qboolean fadeOut) {
line 1640
;1638:	itemDef_t *item;
;1639:	int i;
;1640:	int count = Menu_ItemsMatchingGroup(menu, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Menu_ItemsMatchingGroup
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 1641
;1641:	for (i = 0; i < count; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $698
JUMPV
LABELV $695
line 1642
;1642:		item = Menu_GetMatchingItemByNumber(menu, i, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Menu_GetMatchingItemByNumber
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
ASGNP4
line 1643
;1643:		if (item != NULL) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $699
line 1644
;1644:			if (fadeOut) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $701
line 1645
;1645:				item->window.flags |= (WINDOW_FADINGOUT | WINDOW_VISIBLE);
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 36
BORI4
ASGNI4
line 1646
;1646:				item->window.flags &= ~WINDOW_FADINGIN;
ADDRLP4 24
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 -65
BANDI4
ASGNI4
line 1647
;1647:			} else {
ADDRGP4 $702
JUMPV
LABELV $701
line 1648
;1648:				item->window.flags |= (WINDOW_VISIBLE | WINDOW_FADINGIN);
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 68
BORI4
ASGNI4
line 1649
;1649:				item->window.flags &= ~WINDOW_FADINGOUT;
ADDRLP4 24
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 -33
BANDI4
ASGNI4
line 1650
;1650:			}
LABELV $702
line 1651
;1651:		}
LABELV $699
line 1652
;1652:	}
LABELV $696
line 1641
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $698
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $695
line 1653
;1653:}
LABELV $694
endproc Menu_FadeItemByName 28 12
export Menus_FindByName
proc Menus_FindByName 8 8
line 1655
;1654:
;1655:menuDef_t *Menus_FindByName(const char *p) {
line 1657
;1656:	int i;
;1657:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $707
JUMPV
LABELV $704
line 1658
;1658:		if (Q_stricmp(Menus[i].window.name, p) == 0) {
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus+32
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $708
line 1659
;1659:			return &Menus[i];
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus
ADDP4
RETP4
ADDRGP4 $703
JUMPV
LABELV $708
line 1661
;1660:		}
;1661:	}
LABELV $705
line 1657
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $707
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $704
line 1662
;1662:	return NULL;
CNSTP4 0
RETP4
LABELV $703
endproc Menus_FindByName 8 8
export Menus_ShowByName
proc Menus_ShowByName 8 4
line 1665
;1663:}
;1664:
;1665:void Menus_ShowByName(const char *p) {
line 1666
;1666:	menuDef_t *menu = Menus_FindByName(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1667
;1667:	if (menu) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $712
line 1668
;1668:		Menus_Activate(menu);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menus_Activate
CALLV
pop
line 1669
;1669:	}
LABELV $712
line 1670
;1670:}
LABELV $711
endproc Menus_ShowByName 8 4
export Menus_OpenByName
proc Menus_OpenByName 0 4
line 1672
;1671:
;1672:void Menus_OpenByName(const char *p) {
line 1673
;1673:	Menus_ActivateByName(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 1674
;1674:}
LABELV $714
endproc Menus_OpenByName 0 4
proc Menu_RunCloseScript 584 8
line 1676
;1675:
;1676:static void Menu_RunCloseScript(menuDef_t *menu) {
line 1677
;1677:	if (menu && menu->window.flags & WINDOW_VISIBLE && menu->onClose) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $716
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $716
ADDRLP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $716
line 1679
;1678:		itemDef_t item;
;1679:		item.parent = menu;
ADDRLP4 4+240
ADDRFP4 0
INDIRP4
ASGNP4
line 1680
;1680:		Item_RunScript(&item, menu->onClose);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1681
;1681:	}
LABELV $716
line 1682
;1682:}
LABELV $715
endproc Menu_RunCloseScript 584 8
export Menus_CloseByName
proc Menus_CloseByName 12 4
line 1684
;1683:
;1684:void Menus_CloseByName(const char *p) {
line 1685
;1685:	menuDef_t *menu = Menus_FindByName(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1686
;1686:	if (menu != NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $720
line 1687
;1687:		Menu_RunCloseScript(menu);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_RunCloseScript
CALLV
pop
line 1688
;1688:		menu->window.flags &= ~(WINDOW_VISIBLE | WINDOW_HASFOCUS);
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -7
BANDI4
ASGNI4
line 1689
;1689:	}
LABELV $720
line 1690
;1690:}
LABELV $719
endproc Menus_CloseByName 12 4
export Menus_CloseAll
proc Menus_CloseAll 8 4
line 1692
;1691:
;1692:void Menus_CloseAll(void) {
line 1694
;1693:	int i;
;1694:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $726
JUMPV
LABELV $723
line 1695
;1695:		Menu_RunCloseScript(&Menus[i]);
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRGP4 Menu_RunCloseScript
CALLV
pop
line 1696
;1696:		Menus[i].window.flags &= ~(WINDOW_HASFOCUS | WINDOW_VISIBLE);
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus+72
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -7
BANDI4
ASGNI4
line 1697
;1697:	}
LABELV $724
line 1694
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $726
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $723
line 1698
;1698:}
LABELV $722
endproc Menus_CloseAll 8 4
proc Script_Show 8 12
line 1701
;1699:
;1700:
;1701:static void Script_Show(itemDef_t *item, char **args) {
line 1703
;1702:	const char *name;
;1703:	if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $729
line 1704
;1704:		Menu_ShowItemByName(item->parent, name, qtrue);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1705
;1705:	}
LABELV $729
line 1706
;1706:}
LABELV $728
endproc Script_Show 8 12
proc Script_Hide 8 12
line 1708
;1707:
;1708:static void Script_Hide(itemDef_t *item, char **args) {
line 1710
;1709:	const char *name;
;1710:	if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $732
line 1711
;1711:		Menu_ShowItemByName(item->parent, name, qfalse);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1712
;1712:	}
LABELV $732
line 1713
;1713:}
LABELV $731
endproc Script_Hide 8 12
proc Script_FadeIn 8 12
line 1715
;1714:
;1715:static void Script_FadeIn(itemDef_t *item, char **args) {
line 1717
;1716:	const char *name;
;1717:	if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $735
line 1718
;1718:		Menu_FadeItemByName(item->parent, name, qfalse);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_FadeItemByName
CALLV
pop
line 1719
;1719:	}
LABELV $735
line 1720
;1720:}
LABELV $734
endproc Script_FadeIn 8 12
proc Script_FadeOut 8 12
line 1722
;1721:
;1722:static void Script_FadeOut(itemDef_t *item, char **args) {
line 1724
;1723:	const char *name;
;1724:	if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $738
line 1725
;1725:		Menu_FadeItemByName(item->parent, name, qtrue);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_FadeItemByName
CALLV
pop
line 1726
;1726:	}
LABELV $738
line 1727
;1727:}
LABELV $737
endproc Script_FadeOut 8 12
proc Script_Open 8 8
line 1731
;1728:
;1729:
;1730:
;1731:static void Script_Open(itemDef_t *item, char **args) {
line 1733
;1732:	const char *name;
;1733:	if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $741
line 1734
;1734:		Menus_OpenByName(name);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menus_OpenByName
CALLV
pop
line 1735
;1735:	}
LABELV $741
line 1736
;1736:}
LABELV $740
endproc Script_Open 8 8
proc Script_ConditionalOpen 32 8
line 1738
;1737:
;1738:static void Script_ConditionalOpen(itemDef_t *item, char **args) {
line 1744
;1739:	const char *cvar;
;1740:	const char *name1;
;1741:	const char *name2;
;1742:	float           val;
;1743:
;1744:	if (String_Parse(args, &cvar) && String_Parse(args, &name1) && String_Parse(args, &name2)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $744
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 20
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $744
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 24
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $744
line 1745
;1745:		val = DC->getCVarValue(cvar);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 28
INDIRF4
ASGNF4
line 1746
;1746:		if (val == 0.f) {
ADDRLP4 12
INDIRF4
CNSTF4 0
NEF4 $746
line 1747
;1747:			Menus_OpenByName(name2);
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 Menus_OpenByName
CALLV
pop
line 1748
;1748:		} else {
ADDRGP4 $747
JUMPV
LABELV $746
line 1749
;1749:			Menus_OpenByName(name1);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Menus_OpenByName
CALLV
pop
line 1750
;1750:		}
LABELV $747
line 1751
;1751:	}
LABELV $744
line 1752
;1752:}
LABELV $743
endproc Script_ConditionalOpen 32 8
proc Script_Close 8 8
line 1754
;1753:
;1754:static void Script_Close(itemDef_t *item, char **args) {
line 1756
;1755:	const char *name;
;1756:	if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $749
line 1757
;1757:		Menus_CloseByName(name);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menus_CloseByName
CALLV
pop
line 1758
;1758:	}
LABELV $749
line 1759
;1759:}
LABELV $748
endproc Script_Close 8 8
proc Menu_TransitionItemByName 40 12
line 1761
;1760:
;1761:static void Menu_TransitionItemByName(menuDef_t *menu, const char *p, rectDef_t rectFrom, rectDef_t rectTo, int time, float amt) {
line 1764
;1762:	itemDef_t *item;
;1763:	int i;
;1764:	int count = Menu_ItemsMatchingGroup(menu, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Menu_ItemsMatchingGroup
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 1765
;1765:	for (i = 0; i < count; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $755
JUMPV
LABELV $752
line 1766
;1766:		item = Menu_GetMatchingItemByNumber(menu, i, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Menu_GetMatchingItemByNumber
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 1767
;1767:		if (item != NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $756
line 1768
;1768:			item->window.flags |= (WINDOW_INTRANSITION | WINDOW_VISIBLE);
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 260
BORI4
ASGNI4
line 1769
;1769:			item->window.offsetTime = time;
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
ADDRFP4 16
INDIRI4
ASGNI4
line 1770
;1770:			memcpy(&item->window.rectClient, &rectFrom, sizeof(rectDef_t));
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1771
;1771:			memcpy(&item->window.rectEffects, &rectTo, sizeof(rectDef_t));
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 1772
;1772:			item->window.rectEffects2.x = Q_fabs(rectTo.x - rectFrom.x) / amt;
ADDRFP4 12
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
INDIRF4
SUBF4
ARGF4
ADDRLP4 24
ADDRGP4 Q_fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 24
INDIRF4
ADDRFP4 20
INDIRF4
DIVF4
ASGNF4
line 1773
;1773:			item->window.rectEffects2.y = Q_fabs(rectTo.y - rectFrom.y) / amt;
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRLP4 28
ADDRGP4 Q_fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
ADDRLP4 28
INDIRF4
ADDRFP4 20
INDIRF4
DIVF4
ASGNF4
line 1774
;1774:			item->window.rectEffects2.w = Q_fabs(rectTo.w - rectFrom.w) / amt;
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRLP4 32
ADDRGP4 Q_fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
ADDRLP4 32
INDIRF4
ADDRFP4 20
INDIRF4
DIVF4
ASGNF4
line 1775
;1775:			item->window.rectEffects2.h = Q_fabs(rectTo.h - rectFrom.h) / amt;
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
SUBF4
ARGF4
ADDRLP4 36
ADDRGP4 Q_fabs
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 36
INDIRF4
ADDRFP4 20
INDIRF4
DIVF4
ASGNF4
line 1776
;1776:			Item_UpdatePosition(item);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Item_UpdatePosition
CALLV
pop
line 1777
;1777:		}
LABELV $756
line 1778
;1778:	}
LABELV $753
line 1765
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $755
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $752
line 1779
;1779:}
LABELV $751
endproc Menu_TransitionItemByName 40 12
proc Script_Transition 96 24
line 1782
;1780:
;1781:
;1782:static void Script_Transition(itemDef_t *item, char **args) {
line 1788
;1783:	const char *name;
;1784:	rectDef_t rectFrom, rectTo;
;1785:	int time;
;1786:	float amt;
;1787:
;1788:	if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 44
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $759
line 1789
;1789:		if (Rect_Parse(args, &rectFrom) && Rect_Parse(args, &rectTo) && Int_Parse(args, &time) && Float_Parse(args, &amt)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 48
ADDRGP4 Rect_Parse
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $761
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 52
ADDRGP4 Rect_Parse
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $761
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 56
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $761
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 40
ARGP4
ADDRLP4 60
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $761
line 1790
;1790:			Menu_TransitionItemByName(item->parent, name, rectFrom, rectTo, time, amt);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRLP4 4
INDIRB
ASGNB 16
ADDRLP4 64
ARGP4
ADDRLP4 80
ADDRLP4 20
INDIRB
ASGNB 16
ADDRLP4 80
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 40
INDIRF4
ARGF4
ADDRGP4 Menu_TransitionItemByName
CALLV
pop
line 1791
;1791:		}
LABELV $761
line 1792
;1792:	}
LABELV $759
line 1793
;1793:}
LABELV $758
endproc Script_Transition 96 24
proc Menu_OrbitItemByName 24 12
line 1796
;1794:
;1795:
;1796:static void Menu_OrbitItemByName(menuDef_t *menu, const char *p, float x, float y, float cx, float cy, int time) {
line 1799
;1797:	itemDef_t *item;
;1798:	int i;
;1799:	int count = Menu_ItemsMatchingGroup(menu, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Menu_ItemsMatchingGroup
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 1800
;1800:	for (i = 0; i < count; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $767
JUMPV
LABELV $764
line 1801
;1801:		item = Menu_GetMatchingItemByNumber(menu, i, p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Menu_GetMatchingItemByNumber
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 1802
;1802:		if (item != NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $768
line 1803
;1803:			item->window.flags |= (WINDOW_ORBITING | WINDOW_VISIBLE);
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 65540
BORI4
ASGNI4
line 1804
;1804:			item->window.offsetTime = time;
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
ADDRFP4 24
INDIRI4
ASGNI4
line 1805
;1805:			item->window.rectEffects.x = cx;
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRFP4 16
INDIRF4
ASGNF4
line 1806
;1806:			item->window.rectEffects.y = cy;
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
ADDRFP4 20
INDIRF4
ASGNF4
line 1807
;1807:			item->window.rectClient.x = x;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 8
INDIRF4
ASGNF4
line 1808
;1808:			item->window.rectClient.y = y;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 12
INDIRF4
ASGNF4
line 1809
;1809:			Item_UpdatePosition(item);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Item_UpdatePosition
CALLV
pop
line 1810
;1810:		}
LABELV $768
line 1811
;1811:	}
LABELV $765
line 1800
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $767
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $764
line 1812
;1812:}
LABELV $763
endproc Menu_OrbitItemByName 24 12
proc Script_Orbit 48 28
line 1815
;1813:
;1814:
;1815:static void Script_Orbit(itemDef_t *item, char **args) {
line 1820
;1816:	const char *name;
;1817:	float cx, cy, x, y;
;1818:	int time;
;1819:
;1820:	if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $771
line 1821
;1821:		if (Float_Parse(args, &x) && Float_Parse(args, &y) && Float_Parse(args, &cx) && Float_Parse(args, &cy) && Int_Parse(args, &time)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 28
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $773
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 32
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $773
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 36
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $773
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 40
ADDRGP4 Float_Parse
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $773
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 44
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $773
line 1822
;1822:			Menu_OrbitItemByName(item->parent, name, x, y, cx, cy, time);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 Menu_OrbitItemByName
CALLV
pop
line 1823
;1823:		}
LABELV $773
line 1824
;1824:	}
LABELV $771
line 1825
;1825:}
LABELV $770
endproc Script_Orbit 48 28
proc Script_SetFocus 28 8
line 1829
;1826:
;1827:
;1828:
;1829:static void Script_SetFocus(itemDef_t *item, char **args) {
line 1833
;1830:	const char *name;
;1831:	itemDef_t *focusItem;
;1832:
;1833:	if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $776
line 1834
;1834:		focusItem = Menu_FindItemByName(item->parent, name);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Menu_FindItemByName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1835
;1835:		if (focusItem && !(focusItem->window.flags & WINDOW_DECORATION) && !(focusItem->window.flags & WINDOW_HASFOCUS)) {
ADDRLP4 16
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $778
ADDRLP4 16
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $778
ADDRLP4 16
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $778
line 1836
;1836:			Menu_ClearFocus(item->parent);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRGP4 Menu_ClearFocus
CALLP4
pop
line 1837
;1837:			focusItem->window.flags |= WINDOW_HASFOCUS;
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 72
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
line 1838
;1838:			if (focusItem->onFocus) {
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $780
line 1839
;1839:				Item_RunScript(focusItem, focusItem->onFocus);
ADDRLP4 24
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1840
;1840:			}
LABELV $780
line 1841
;1841:			if (DC->Assets.itemFocusSound) {
ADDRGP4 DC
INDIRP4
CNSTI4 5342796
ADDP4
INDIRI4
CNSTI4 0
EQI4 $782
line 1843
;1842:				//Com_Printf("focus sound\n");
;1843:				DC->startLocalSound(DC->Assets.itemFocusSound, CHAN_LOCAL_SOUND);
ADDRLP4 24
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 5342796
ADDP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 116
ADDP4
INDIRP4
CALLV
pop
line 1844
;1844:			}
LABELV $782
line 1845
;1845:		}
LABELV $778
line 1846
;1846:	}
LABELV $776
line 1847
;1847:}
LABELV $775
endproc Script_SetFocus 28 8
proc Script_SetPlayerModel 8 8
line 1849
;1848:
;1849:static void Script_SetPlayerModel(itemDef_t *item, char **args) {
line 1851
;1850:	const char *name;
;1851:	if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $785
line 1852
;1852:		DC->setCVar("team_model", name);
ADDRGP4 $787
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 1853
;1853:	}
LABELV $785
line 1854
;1854:}
LABELV $784
endproc Script_SetPlayerModel 8 8
proc Script_SetPlayerHead 8 8
line 1856
;1855:
;1856:static void Script_SetPlayerHead(itemDef_t *item, char **args) {
line 1858
;1857:	const char *name;
;1858:	if (String_Parse(args, &name)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $789
line 1859
;1859:		DC->setCVar("team_headmodel", name);
ADDRGP4 $791
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 1860
;1860:	}
LABELV $789
line 1861
;1861:}
LABELV $788
endproc Script_SetPlayerHead 8 8
proc Script_SetCvar 16 8
line 1863
;1862:
;1863:static void Script_SetCvar(itemDef_t *item, char **args) {
line 1865
;1864:	const char *cvar, *val;
;1865:	if (String_Parse(args, &cvar) && String_Parse(args, &val)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $793
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $793
line 1866
;1866:		DC->setCVar(cvar, val);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 1867
;1867:	}
LABELV $793
line 1868
;1868:}
LABELV $792
endproc Script_SetCvar 16 8
proc Script_SetVar 24 12
line 1870
;1869:
;1870:static void Script_SetVar(itemDef_t *item, char **args) {
line 1876
;1871:	const char *var;
;1872:	const char *mathScript;
;1873:	float f;
;1874:	int err;
;1875:
;1876:	if (!String_Parse(args, &var)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $796
line 1877
;1877:		Com_Printf("^1Script_SetVar() couldn't get variable name\n");
ADDRGP4 $798
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1878
;1878:		return;
ADDRGP4 $795
JUMPV
LABELV $796
line 1881
;1879:	}
;1880:
;1881:	if (!Parenthesis_Parse(args, &mathScript)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 20
ADDRGP4 Parenthesis_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $799
line 1882
;1882:		Com_Printf("^1Script_SetVar() couldn't get math block\n");
ADDRGP4 $801
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 1883
;1883:		return;
ADDRGP4 $795
JUMPV
LABELV $799
line 1886
;1884:	}
;1885:
;1886:	Q_MathScript((char *)mathScript, &f, &err);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 Q_MathScript
CALLP4
pop
line 1887
;1887:	MenuVar_Set(var, f);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 MenuVar_Set
CALLI4
pop
line 1888
;1888:}
LABELV $795
endproc Script_SetVar 24 12
proc Script_Exec 12 8
line 1890
;1889:
;1890:static void Script_Exec(itemDef_t *item, char **args) {
line 1892
;1891:	const char *val;
;1892:	if (String_Parse(args, &val)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $803
line 1894
;1893:		//Com_Printf("^3exec '%s'\n", val);
;1894:		if (DC->executeText) {
ADDRGP4 DC
INDIRP4
CNSTI4 152
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $805
line 1895
;1895:			DC->executeText(EXEC_APPEND, va("%s ; ", val));
ADDRGP4 $807
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 152
ADDP4
INDIRP4
CALLV
pop
line 1896
;1896:		}
LABELV $805
line 1897
;1897:	}
LABELV $803
line 1898
;1898:}
LABELV $802
endproc Script_Exec 12 8
proc Script_Play 20 8
line 1900
;1899:
;1900:static void Script_Play(itemDef_t *item, char **args) {
line 1902
;1901:	const char *val;
;1902:	if (String_Parse(args, &val)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $809
line 1903
;1903:		if (Q_stricmp(val, item->playSoundName)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 312
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $811
line 1904
;1904:			item->playSound = DC->registerSound(val, qfalse);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 172
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 308
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1905
;1905:			item->playSoundName = String_Alloc(val);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 312
ADDP4
ADDRLP4 16
INDIRP4
ASGNP4
line 1906
;1906:		}
LABELV $811
line 1907
;1907:		DC->startLocalSound(item->playSound, CHAN_LOCAL_SOUND);
ADDRFP4 0
INDIRP4
CNSTI4 308
ADDP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 116
ADDP4
INDIRP4
CALLV
pop
line 1908
;1908:	}
LABELV $809
line 1909
;1909:}
LABELV $808
endproc Script_Play 20 8
proc Script_playLooped 12 8
line 1911
;1910:
;1911:static void Script_playLooped(itemDef_t *item, char **args) {
line 1913
;1912:	const char *val;
;1913:	if (String_Parse(args, &val)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $814
line 1914
;1914:		DC->stopBackgroundTrack();
ADDRGP4 DC
INDIRP4
CNSTI4 180
ADDP4
INDIRP4
CALLV
pop
line 1915
;1915:		DC->startBackgroundTrack(val, val);
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 176
ADDP4
INDIRP4
CALLV
pop
line 1916
;1916:	}
LABELV $814
line 1917
;1917:}
LABELV $813
endproc Script_playLooped 12 8
data
export commandList
align 4
LABELV commandList
address $816
address Script_FadeIn
address $817
address Script_FadeOut
address $818
address Script_Show
address $819
address Script_Hide
address $820
address Script_SetColor
address $821
address Script_Open
address $822
address Script_ConditionalOpen
address $823
address Script_Close
address $824
address Script_SetAsset
address $825
address Script_SetBackground
address $826
address Script_SetItemColor
address $827
address Script_SetTeamColor
address $828
address Script_SetFocus
address $829
address Script_SetPlayerModel
address $830
address Script_SetPlayerHead
address $831
address Script_Transition
address $832
address Script_SetCvar
address $833
address Script_SetVar
address $834
address Script_Exec
address $835
address Script_Play
address $836
address Script_playLooped
address $837
address Script_Orbit
align 4
LABELV scriptCommandCount
byte 4 22
code
proc Item_RunScript 1056 12
line 1949
;1918:
;1919:
;1920:commandDef_t commandList[] =
;1921:{
;1922:  {"fadein", &Script_FadeIn},                   // group/name
;1923:  {"fadeout", &Script_FadeOut},                 // group/name
;1924:  {"show", &Script_Show},                       // group/name
;1925:  {"hide", &Script_Hide},                       // group/name
;1926:  {"setcolor", &Script_SetColor},               // works on this
;1927:  {"open", &Script_Open},                       // menu
;1928:	{"conditionalopen", &Script_ConditionalOpen},	// menu
;1929:  {"close", &Script_Close},                     // menu
;1930:  {"setasset", &Script_SetAsset},               // works on this
;1931:  {"setbackground", &Script_SetBackground},     // works on this
;1932:  {"setitemcolor", &Script_SetItemColor},       // group/name
;1933:  {"setteamcolor", &Script_SetTeamColor},       // sets this background color to team color
;1934:  {"setfocus", &Script_SetFocus},               // sets this background color to team color
;1935:  {"setplayermodel", &Script_SetPlayerModel},   // sets this background color to team color
;1936:  {"setplayerhead", &Script_SetPlayerHead},     // sets this background color to team color
;1937:  {"transition", &Script_Transition},           // group/name
;1938:  {"setcvar", &Script_SetCvar},           // group/name
;1939:  {"setvar", &Script_SetVar},
;1940:  {"exec", &Script_Exec},           // group/name
;1941:  {"play", &Script_Play},           // group/name
;1942:  {"playlooped", &Script_playLooped},           // group/name
;1943:  {"orbit", &Script_Orbit}                      // group/name
;1944:};
;1945:
;1946:static int scriptCommandCount = ARRAY_LEN(commandList);
;1947:
;1948:
;1949:static void Item_RunScript(itemDef_t *item, const char *s) {
line 1953
;1950:	char script[1024], *p;
;1951:	int i;
;1952:	qboolean bRan;
;1953:	memset(script, 0, sizeof(script));
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1954
;1954:	if (item && s && s[0]) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $839
ADDRLP4 1036
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 1036
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $839
ADDRLP4 1036
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $839
line 1955
;1955:		Q_strcat(script, 1024, s);
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 1956
;1956:		p = script;
ADDRLP4 8
ADDRLP4 12
ASGNP4
ADDRGP4 $842
JUMPV
LABELV $841
line 1957
;1957:		while (1) {
line 1960
;1958:			const char *command;
;1959:			// expect command then arguments, ; ends command, NULL ends script
;1960:			if (!String_Parse(&p, &command)) {
ADDRLP4 8
ARGP4
ADDRLP4 1040
ARGP4
ADDRLP4 1044
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $844
line 1961
;1961:				return;
ADDRGP4 $838
JUMPV
LABELV $844
line 1964
;1962:			}
;1963:
;1964:			if (command[0] == ';' && command[1] == '\0') {
ADDRLP4 1048
ADDRLP4 1040
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
INDIRI1
CVII4 1
CNSTI4 59
NEI4 $846
ADDRLP4 1048
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $846
line 1965
;1965:				continue;
ADDRGP4 $842
JUMPV
LABELV $846
line 1968
;1966:			}
;1967:
;1968:			bRan = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1969
;1969:			for (i = 0; i < scriptCommandCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $851
JUMPV
LABELV $848
line 1970
;1970:				if (Q_stricmp(command, commandList[i].name) == 0) {
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commandList
ADDP4
INDIRP4
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $852
line 1971
;1971:					(commandList[i].handler(item, &p));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 commandList+4
ADDP4
INDIRP4
CALLV
pop
line 1972
;1972:					bRan = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1973
;1973:					break;
ADDRGP4 $850
JUMPV
LABELV $852
line 1975
;1974:				}
;1975:			}
LABELV $849
line 1969
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $851
ADDRLP4 0
INDIRI4
ADDRGP4 scriptCommandCount
INDIRI4
LTI4 $848
LABELV $850
line 1977
;1976:			// not in our auto list, pass to handler
;1977:			if (!bRan) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $855
line 1978
;1978:				DC->runScript(&p);
ADDRLP4 8
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 80
ADDP4
INDIRP4
CALLV
pop
line 1979
;1979:			}
LABELV $855
line 1980
;1980:		}
LABELV $842
line 1957
ADDRGP4 $841
JUMPV
line 1981
;1981:	}
LABELV $839
line 1982
;1982:}
LABELV $838
endproc Item_RunScript 1056 12
proc Item_EnableShowViaCvar 2072 12
line 1985
;1983:
;1984:
;1985:static qboolean Item_EnableShowViaCvar(itemDef_t *item, int flag) {
line 1987
;1986:	char script[1024], *p;
;1987:	memset(script, 0, sizeof(script));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1988
;1988:	if (item && item->enableCvar && *item->enableCvar && item->cvarTest && *item->cvarTest) {
ADDRLP4 1028
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $858
ADDRLP4 1028
INDIRP4
CNSTI4 292
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $858
ADDRLP4 1028
INDIRP4
CNSTI4 292
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $858
ADDRLP4 1028
INDIRP4
CNSTI4 288
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $858
ADDRLP4 1028
INDIRP4
CNSTI4 288
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $858
line 1990
;1989:		char buff[1024];
;1990:		DC->getCVarString(item->cvarTest, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
INDIRP4
ARGP4
ADDRLP4 1032
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 1992
;1991:
;1992:		Q_strcat(script, 1024, item->enableCvar);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 292
ADDP4
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 1993
;1993:		p = script;
ADDRLP4 0
ADDRLP4 4
ASGNP4
ADDRGP4 $861
JUMPV
LABELV $860
line 1994
;1994:		while (1) {
line 1997
;1995:			const char *val;
;1996:			// expect value then ; or NULL, NULL ends list
;1997:			if (!String_Parse(&p, &val)) {
ADDRLP4 0
ARGP4
ADDRLP4 2056
ARGP4
ADDRLP4 2060
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 2060
INDIRI4
CNSTI4 0
NEI4 $863
line 1998
;1998:				return (item->cvarFlags & flag) ? qfalse : qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
BANDI4
CNSTI4 0
EQI4 $866
ADDRLP4 2064
CNSTI4 0
ASGNI4
ADDRGP4 $867
JUMPV
LABELV $866
ADDRLP4 2064
CNSTI4 1
ASGNI4
LABELV $867
ADDRLP4 2064
INDIRI4
RETI4
ADDRGP4 $857
JUMPV
LABELV $863
line 2001
;1999:			}
;2000:
;2001:			if (val[0] == ';' && val[1] == '\0') {
ADDRLP4 2064
ADDRLP4 2056
INDIRP4
ASGNP4
ADDRLP4 2064
INDIRP4
INDIRI1
CVII4 1
CNSTI4 59
NEI4 $868
ADDRLP4 2064
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $868
line 2002
;2002:				continue;
ADDRGP4 $861
JUMPV
LABELV $868
line 2006
;2003:			}
;2004:
;2005:			// enable it if any of the values are true
;2006:			if (item->cvarFlags & flag) {
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
BANDI4
CNSTI4 0
EQI4 $870
line 2007
;2007:				if (Q_stricmp(buff, val) == 0) {
ADDRLP4 1032
ARGP4
ADDRLP4 2056
INDIRP4
ARGP4
ADDRLP4 2068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
NEI4 $871
line 2008
;2008:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $857
JUMPV
line 2010
;2009:				}
;2010:			} else {
LABELV $870
line 2012
;2011:				// disable it if any of the values are true
;2012:				if (Q_stricmp(buff, val) == 0) {
ADDRLP4 1032
ARGP4
ADDRLP4 2056
INDIRP4
ARGP4
ADDRLP4 2068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
NEI4 $874
line 2013
;2013:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $857
JUMPV
LABELV $874
line 2015
;2014:				}
;2015:			}
LABELV $871
line 2017
;2016:
;2017:		}
LABELV $861
line 1994
ADDRGP4 $860
JUMPV
line 2018
;2018:		return (item->cvarFlags & flag) ? qfalse : qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
BANDI4
CNSTI4 0
EQI4 $877
ADDRLP4 2056
CNSTI4 0
ASGNI4
ADDRGP4 $878
JUMPV
LABELV $877
ADDRLP4 2056
CNSTI4 1
ASGNI4
LABELV $878
ADDRLP4 2056
INDIRI4
RETI4
ADDRGP4 $857
JUMPV
LABELV $858
line 2020
;2019:	}
;2020:	return qtrue;
CNSTI4 1
RETI4
LABELV $857
endproc Item_EnableShowViaCvar 2072 12
proc Item_SetFocus 72 16
line 2025
;2021:}
;2022:
;2023:
;2024:// will optionaly set focus to this item
;2025:static qboolean Item_SetFocus(itemDef_t *item, float x, float y) {
line 2028
;2026:	int i;
;2027:	itemDef_t *oldFocus;
;2028:	sfxHandle_t *sfx = &DC->Assets.itemFocusSound;
ADDRLP4 8
ADDRGP4 DC
INDIRP4
CNSTI4 5342796
ADDP4
ASGNP4
line 2029
;2029:	qboolean playSound = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 2035
;2030:	menuDef_t *parent;
;2031:
;2032:	//Com_Printf("Item_SetFocus %p\n", item);
;2033:
;2034:	// sanity check, non-null, not a decoration and does not already have the focus
;2035:	if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $880
line 2036
;2036:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $879
JUMPV
LABELV $880
line 2039
;2037:	}
;2038:
;2039:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $882
line 2041
;2040:		//Com_Printf("already has focus\n");
;2041:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $879
JUMPV
LABELV $882
line 2044
;2042:	}
;2043:
;2044:	if (item == NULL || item->window.flags & WINDOW_DECORATION || item->window.flags & WINDOW_HASFOCUS || !(item->window.flags & WINDOW_VISIBLE)) {
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $888
ADDRLP4 20
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $888
ADDRLP4 20
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $888
ADDRLP4 20
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $884
LABELV $888
line 2045
;2045:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $879
JUMPV
LABELV $884
line 2049
;2046:	}
;2047:
;2048:	// this can be NULL
;2049:	parent = (menuDef_t *)item->parent;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 2052
;2050:
;2051:	// items can be enabled and disabled based on cvars
;2052:	if (item->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(item, CVAR_ENABLE)) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $889
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 28
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $889
line 2053
;2053:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $879
JUMPV
LABELV $889
line 2056
;2054:	}
;2055:
;2056:	if (item->cvarFlags & (CVAR_SHOW | CVAR_HIDE) && !Item_EnableShowViaCvar(item, CVAR_SHOW)) {
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $891
ADDRLP4 32
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 36
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $891
line 2057
;2057:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $879
JUMPV
LABELV $891
line 2060
;2058:	}
;2059:
;2060:	oldFocus = Menu_ClearFocus(item->parent);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 Menu_ClearFocus
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 40
INDIRP4
ASGNP4
line 2062
;2061:
;2062:	if (item->type == ITEM_TYPE_TEXT) {
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
NEI4 $893
line 2064
;2063:		rectDef_t r;
;2064:		r = item->textRect;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRB
ASGNB 16
line 2065
;2065:		r.y -= r.h;
ADDRLP4 44+4
ADDRLP4 44+4
INDIRF4
ADDRLP4 44+12
INDIRF4
SUBF4
ASGNF4
line 2066
;2066:		if (Rect_ContainsWidescreenPoint(&r, x, y, item->widescreen)) {
ADDRLP4 44
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $897
line 2067
;2067:			item->window.flags |= WINDOW_HASFOCUS;
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 72
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
line 2068
;2068:			if (item->focusSound) {
ADDRFP4 0
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
CNSTI4 0
EQI4 $899
line 2069
;2069:				sfx = &item->focusSound;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 300
ADDP4
ASGNP4
line 2070
;2070:			}
LABELV $899
line 2071
;2071:			playSound = qtrue;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 2072
;2072:		} else {
ADDRGP4 $894
JUMPV
LABELV $897
line 2073
;2073:			if (oldFocus) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $894
line 2074
;2074:				oldFocus->window.flags |= WINDOW_HASFOCUS;
ADDRLP4 64
ADDRLP4 16
INDIRP4
CNSTI4 72
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
line 2075
;2075:				if (oldFocus->onFocus) {
ADDRLP4 16
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $894
line 2076
;2076:					Item_RunScript(oldFocus, oldFocus->onFocus);
ADDRLP4 68
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2077
;2077:				}
line 2078
;2078:			}
line 2079
;2079:		}
line 2080
;2080:	} else {
ADDRGP4 $894
JUMPV
LABELV $893
line 2081
;2081:		item->window.flags |= WINDOW_HASFOCUS;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 2082
;2082:		if (item->onFocus) {
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $905
line 2083
;2083:			Item_RunScript(item, item->onFocus);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
CNSTI4 276
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2084
;2084:		}
LABELV $905
line 2085
;2085:		if (item->focusSound) {
ADDRFP4 0
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
CNSTI4 0
EQI4 $907
line 2086
;2086:			sfx = &item->focusSound;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 300
ADDP4
ASGNP4
line 2087
;2087:		}
LABELV $907
line 2088
;2088:		playSound = qtrue;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 2089
;2089:	}
LABELV $894
line 2091
;2090:
;2091:	if (playSound && sfx) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $909
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $909
line 2092
;2092:		DC->startLocalSound(*sfx, CHAN_LOCAL_SOUND);
ADDRLP4 8
INDIRP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 116
ADDP4
INDIRP4
CALLV
pop
line 2093
;2093:	}
LABELV $909
line 2095
;2094:
;2095:	for (i = 0; i < parent->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $914
JUMPV
LABELV $911
line 2096
;2096:		if (parent->items[i] == item) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $915
line 2097
;2097:			parent->cursorItem = i;
ADDRLP4 4
INDIRP4
CNSTI4 204
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 2098
;2098:			break;
ADDRGP4 $913
JUMPV
LABELV $915
line 2100
;2099:		}
;2100:	}
LABELV $912
line 2095
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $914
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
LTI4 $911
LABELV $913
line 2103
;2101:
;2102:	//FIXME hack
;2103:	if (item && item->window.flags & WINDOW_HASFOCUS) {
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $917
ADDRLP4 44
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $917
line 2104
;2104:		LastFocusItem = item;
ADDRGP4 LastFocusItem
ADDRFP4 0
INDIRP4
ASGNP4
line 2105
;2105:	}
LABELV $917
line 2107
;2106:
;2107:	return qtrue;
CNSTI4 1
RETI4
LABELV $879
endproc Item_SetFocus 72 16
proc Item_ListBox_MaxScroll 16 4
line 2110
;2108:}
;2109:
;2110:static int Item_ListBox_MaxScroll(itemDef_t *item) {
line 2111
;2111:	listBoxDef_t *listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 2112
;2112:	int count = DC->feederCount(item->special);
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 124
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 2115
;2113:	int max;
;2114:
;2115:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $920
line 2116
;2116:		max = count - (item->window.rect.w / listPtr->elementWidth) + 1;
ADDRLP4 0
ADDRLP4 8
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
DIVF4
SUBF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 2117
;2117:	} else {
ADDRGP4 $921
JUMPV
LABELV $920
line 2118
;2118:		max = count - (item->window.rect.h / listPtr->elementHeight) + 1;
ADDRLP4 0
ADDRLP4 8
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
DIVF4
SUBF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 2119
;2119:	}
LABELV $921
line 2120
;2120:	if (max < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $922
line 2121
;2121:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $919
JUMPV
LABELV $922
line 2123
;2122:	}
;2123:	return max;
ADDRLP4 0
INDIRI4
RETI4
LABELV $919
endproc Item_ListBox_MaxScroll 16 4
proc Item_ListBox_ThumbPosition 20 4
line 2126
;2124:}
;2125:
;2126:static int Item_ListBox_ThumbPosition(itemDef_t *item) {
line 2128
;2127:	float max, pos, size;
;2128:	listBoxDef_t *listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 2130
;2129:
;2130:	max = Item_ListBox_MaxScroll(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Item_ListBox_MaxScroll
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
line 2131
;2131:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $925
line 2132
;2132:		size = item->window.rect.w - (SCROLLBAR_SIZE * 2) - 2;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 2133
;2133:		if (max > 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $927
line 2134
;2134:			pos = (size - SCROLLBAR_SIZE) / (float)max;
ADDRLP4 0
ADDRLP4 12
INDIRF4
CNSTF4 1098907648
SUBF4
ADDRLP4 4
INDIRF4
DIVF4
ASGNF4
line 2135
;2135:		} else {
ADDRGP4 $928
JUMPV
LABELV $927
line 2136
;2136:			pos = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 2137
;2137:		}
LABELV $928
line 2138
;2138:		pos *= listPtr->startPos;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRP4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 2139
;2139:		return item->window.rect.x + 1 + SCROLLBAR_SIZE + pos;
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
CNSTF4 1098907648
ADDF4
ADDRLP4 0
INDIRF4
ADDF4
CVFI4 4
RETI4
ADDRGP4 $924
JUMPV
LABELV $925
line 2140
;2140:	} else {
line 2141
;2141:		size = item->window.rect.h - (SCROLLBAR_SIZE * 2) - 2;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 2142
;2142:		if (max > 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $929
line 2143
;2143:			pos = (size - SCROLLBAR_SIZE) / (float)max;
ADDRLP4 0
ADDRLP4 12
INDIRF4
CNSTF4 1098907648
SUBF4
ADDRLP4 4
INDIRF4
DIVF4
ASGNF4
line 2144
;2144:		} else {
ADDRGP4 $930
JUMPV
LABELV $929
line 2145
;2145:			pos = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 2146
;2146:		}
LABELV $930
line 2147
;2147:		pos *= listPtr->startPos;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRP4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 2148
;2148:		return item->window.rect.y + 1 + SCROLLBAR_SIZE + pos;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
CNSTF4 1098907648
ADDF4
ADDRLP4 0
INDIRF4
ADDF4
CVFI4 4
RETI4
LABELV $924
endproc Item_ListBox_ThumbPosition 20 4
proc Item_ListBox_ThumbDrawPosition 24 4
line 2152
;2149:	}
;2150:}
;2151:
;2152:static int Item_ListBox_ThumbDrawPosition(itemDef_t *item) {
line 2155
;2153:	int min, max;
;2154:
;2155:	if (itemCapture == item) {
ADDRGP4 itemCapture
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $932
line 2156
;2156:		if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $934
line 2157
;2157:			min = item->window.rect.x + SCROLLBAR_SIZE + 1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 2158
;2158:			max = item->window.rect.x + item->window.rect.w - 2 * SCROLLBAR_SIZE - 1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1107296256
SUBF4
CNSTF4 1065353216
SUBF4
CVFI4 4
ASGNI4
line 2161
;2159:			//Com_Printf("checking cursor x\n");
;2160:			//if (DC->cursorx >= min + SCROLLBAR_SIZE/2 && DC->cursorx <= max + SCROLLBAR_SIZE/2) {
;2161:			if (CursorX_Widescreen(item->widescreen) >= min + SCROLLBAR_SIZE / 2 && CursorX_Widescreen(item->widescreen) <= max + SCROLLBAR_SIZE / 2) {
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 CursorX_Widescreen
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1090519040
ADDF4
LTF4 $936
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 CursorX_Widescreen
CALLF4
ASGNF4
ADDRLP4 16
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
CNSTF4 1090519040
ADDF4
GTF4 $936
line 2162
;2162:				return CursorX_Widescreen(item->widescreen) - SCROLLBAR_SIZE / 2;
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 CursorX_Widescreen
CALLF4
ASGNF4
ADDRLP4 20
INDIRF4
CNSTF4 1090519040
SUBF4
CVFI4 4
RETI4
ADDRGP4 $931
JUMPV
LABELV $936
line 2163
;2163:			} else {
line 2164
;2164:				return Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Item_ListBox_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $931
JUMPV
LABELV $934
line 2166
;2165:			}
;2166:		} else {
line 2167
;2167:			min = item->window.rect.y + SCROLLBAR_SIZE + 1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 2168
;2168:			max = item->window.rect.y + item->window.rect.h - 2 * SCROLLBAR_SIZE - 1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1107296256
SUBF4
CNSTF4 1065353216
SUBF4
CVFI4 4
ASGNI4
line 2169
;2169:			if (DC->cursory >= min + SCROLLBAR_SIZE / 2 && DC->cursory <= max + SCROLLBAR_SIZE / 2) {
ADDRLP4 12
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1090519040
ADDF4
LTF4 $938
ADDRLP4 12
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRI4
CVIF4 4
CNSTF4 1090519040
ADDF4
GTF4 $938
line 2170
;2170:				return DC->cursory - SCROLLBAR_SIZE / 2;
ADDRGP4 DC
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1090519040
SUBF4
CVFI4 4
RETI4
ADDRGP4 $931
JUMPV
LABELV $938
line 2171
;2171:			} else {
line 2172
;2172:				return Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Item_ListBox_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
RETI4
ADDRGP4 $931
JUMPV
LABELV $932
line 2175
;2173:			}
;2174:		}
;2175:	} else {
line 2176
;2176:		return Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Item_ListBox_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
LABELV $931
endproc Item_ListBox_ThumbDrawPosition 24 4
proc Item_Slider_ThumbPosition 24 4
line 2180
;2177:	}
;2178:}
;2179:
;2180:static float Item_Slider_ThumbPosition(itemDef_t *item) {
line 2182
;2181:	float value, range, x;
;2182:	editFieldDef_t *editDef = item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 2184
;2183:
;2184:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $941
line 2185
;2185:		x = item->textRect.x + item->textRect.w + 8;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 2186
;2186:	} else {
ADDRGP4 $942
JUMPV
LABELV $941
line 2187
;2187:		x = item->window.rect.x;
ADDRLP4 8
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 2188
;2188:	}
LABELV $942
line 2190
;2189:
;2190:	if (!editDef || !item->cvar) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $945
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $943
LABELV $945
line 2191
;2191:		return x;
ADDRLP4 8
INDIRF4
RETF4
ADDRGP4 $940
JUMPV
LABELV $943
line 2194
;2192:	}
;2193:
;2194:	value = DC->getCVarValue(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 2196
;2195:
;2196:	if (value < editDef->minVal) {
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRP4
INDIRF4
GEF4 $946
line 2197
;2197:		value = editDef->minVal;
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRF4
ASGNF4
line 2198
;2198:	} else if (value > editDef->maxVal) {
ADDRGP4 $947
JUMPV
LABELV $946
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
LEF4 $948
line 2199
;2199:		value = editDef->maxVal;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 2200
;2200:	}
LABELV $948
LABELV $947
line 2202
;2201:
;2202:	range = editDef->maxVal - editDef->minVal;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
INDIRF4
SUBF4
ASGNF4
line 2203
;2203:	value -= editDef->minVal;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRP4
INDIRF4
SUBF4
ASGNF4
line 2204
;2204:	value /= range;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
DIVF4
ASGNF4
line 2206
;2205:	//value /= (editDef->maxVal - editDef->minVal);
;2206:	value *= SLIDER_WIDTH;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1119879168
MULF4
ASGNF4
line 2207
;2207:	x += value;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 2210
;2208:	// vm fuckage
;2209:	//x = x + (((float)value / editDef->maxVal) * SLIDER_WIDTH);
;2210:	return x;
ADDRLP4 8
INDIRF4
RETF4
LABELV $940
endproc Item_Slider_ThumbPosition 24 4
proc Item_Slider_OverSlider 24 16
line 2213
;2211:}
;2212:
;2213:static int Item_Slider_OverSlider(itemDef_t *item, float x, float y) {
line 2218
;2214:	rectDef_t r;
;2215:
;2216:	//Com_Printf("slider over slider\n");
;2217:
;2218:	if (!item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $951
line 2219
;2219:		Com_Printf("^1Item_SlideOverSlide item == NULL\n");
ADDRGP4 $953
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 2220
;2220:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $950
JUMPV
LABELV $951
line 2223
;2221:	}
;2222:
;2223:	r.x = Item_Slider_ThumbPosition(item) - (SLIDER_THUMB_WIDTH / 2);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Item_Slider_ThumbPosition
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
CNSTF4 1086324736
SUBF4
ASGNF4
line 2224
;2224:	r.y = item->window.rect.y - 2;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 2225
;2225:	r.w = SLIDER_THUMB_WIDTH;
ADDRLP4 0+8
CNSTF4 1094713344
ASGNF4
line 2226
;2226:	r.h = SLIDER_THUMB_HEIGHT;
ADDRLP4 0+12
CNSTF4 1101004800
ASGNF4
line 2228
;2227:
;2228:	if (Rect_ContainsWidescreenPoint(&r, x, y, item->widescreen)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $957
line 2229
;2229:		return WINDOW_LB_THUMB;
CNSTI4 8192
RETI4
ADDRGP4 $950
JUMPV
LABELV $957
line 2231
;2230:	}
;2231:	return 0;
CNSTI4 0
RETI4
LABELV $950
endproc Item_Slider_OverSlider 24 16
proc Item_ListBox_OverLB 60 16
line 2234
;2232:}
;2233:
;2234:static int Item_ListBox_OverLB(itemDef_t *item, float x, float y) {
line 2238
;2235:	rectDef_t r;
;2236:	int thumbstart;
;2237:
;2238:	if (!item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $960
line 2239
;2239:		Com_Printf("^1Item_ListBox_OverLB item == NULL\n");
ADDRGP4 $962
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 2240
;2240:	}
LABELV $960
line 2242
;2241:
;2242:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $963
line 2244
;2243:		// check if on left arrow
;2244:		r.x = item->window.rect.x;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 2245
;2245:		r.y = item->window.rect.y + item->window.rect.h - SCROLLBAR_SIZE;
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 2246
;2246:		r.h = r.w = SCROLLBAR_SIZE;
ADDRLP4 24
CNSTF4 1098907648
ASGNF4
ADDRLP4 0+8
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 0+12
ADDRLP4 24
INDIRF4
ASGNF4
line 2247
;2247:		if (Rect_ContainsWidescreenPoint(&r, x, y, item->widescreen)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $968
line 2248
;2248:			return WINDOW_LB_LEFTARROW;
CNSTI4 2048
RETI4
ADDRGP4 $959
JUMPV
LABELV $968
line 2251
;2249:		}
;2250:		// check if on right arrow
;2251:		r.x = item->window.rect.x + item->window.rect.w - SCROLLBAR_SIZE;
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 2252
;2252:		if (Rect_ContainsWidescreenPoint(&r, x, y, item->widescreen)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $970
line 2253
;2253:			return WINDOW_LB_RIGHTARROW;
CNSTI4 4096
RETI4
ADDRGP4 $959
JUMPV
LABELV $970
line 2256
;2254:		}
;2255:		// check if on thumb
;2256:		thumbstart = Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 Item_ListBox_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 40
INDIRI4
ASGNI4
line 2257
;2257:		r.x = thumbstart;
ADDRLP4 0
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
line 2258
;2258:		if (Rect_ContainsWidescreenPoint(&r, x, y, item->widescreen)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $972
line 2259
;2259:			return WINDOW_LB_THUMB;
CNSTI4 8192
RETI4
ADDRGP4 $959
JUMPV
LABELV $972
line 2261
;2260:		}
;2261:		r.x = item->window.rect.x + SCROLLBAR_SIZE;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 2262
;2262:		r.w = thumbstart - r.x;
ADDRLP4 0+8
ADDRLP4 16
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
line 2263
;2263:		if (Rect_ContainsWidescreenPoint(&r, x, y, item->widescreen)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $975
line 2264
;2264:			return WINDOW_LB_PGUP;
CNSTI4 16384
RETI4
ADDRGP4 $959
JUMPV
LABELV $975
line 2266
;2265:		}
;2266:		r.x = thumbstart + SCROLLBAR_SIZE;
ADDRLP4 0
ADDRLP4 16
INDIRI4
CVIF4 4
CNSTF4 1098907648
ADDF4
ASGNF4
line 2267
;2267:		r.w = item->window.rect.x + item->window.rect.w - SCROLLBAR_SIZE;
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 52
INDIRP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 2268
;2268:		if (Rect_ContainsWidescreenPoint(&r, x, y, item->widescreen)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $964
line 2269
;2269:			return WINDOW_LB_PGDN;
CNSTI4 32768
RETI4
ADDRGP4 $959
JUMPV
line 2271
;2270:		}
;2271:	} else {
LABELV $963
line 2272
;2272:		r.x = item->window.rect.x + item->window.rect.w - SCROLLBAR_SIZE;
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 2273
;2273:		r.y = item->window.rect.y;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 2274
;2274:		r.h = r.w = SCROLLBAR_SIZE;
ADDRLP4 24
CNSTF4 1098907648
ASGNF4
ADDRLP4 0+8
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 0+12
ADDRLP4 24
INDIRF4
ASGNF4
line 2275
;2275:		if (Rect_ContainsWidescreenPoint(&r, x, y, item->widescreen)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $983
line 2276
;2276:			return WINDOW_LB_LEFTARROW;
CNSTI4 2048
RETI4
ADDRGP4 $959
JUMPV
LABELV $983
line 2278
;2277:		}
;2278:		r.y = item->window.rect.y + item->window.rect.h - SCROLLBAR_SIZE;
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 2279
;2279:		if (Rect_ContainsWidescreenPoint(&r, x, y, item->widescreen)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $986
line 2280
;2280:			return WINDOW_LB_RIGHTARROW;
CNSTI4 4096
RETI4
ADDRGP4 $959
JUMPV
LABELV $986
line 2282
;2281:		}
;2282:		thumbstart = Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 Item_ListBox_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 40
INDIRI4
ASGNI4
line 2283
;2283:		r.y = thumbstart;
ADDRLP4 0+4
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
line 2284
;2284:		if (Rect_ContainsWidescreenPoint(&r, x, y, item->widescreen)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $989
line 2285
;2285:			return WINDOW_LB_THUMB;
CNSTI4 8192
RETI4
ADDRGP4 $959
JUMPV
LABELV $989
line 2287
;2286:		}
;2287:		r.y = item->window.rect.y + SCROLLBAR_SIZE;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 2288
;2288:		r.h = thumbstart - r.y;
ADDRLP4 0+12
ADDRLP4 16
INDIRI4
CVIF4 4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
line 2289
;2289:		if (Rect_ContainsWidescreenPoint(&r, x, y, item->widescreen)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $994
line 2290
;2290:			return WINDOW_LB_PGUP;
CNSTI4 16384
RETI4
ADDRGP4 $959
JUMPV
LABELV $994
line 2292
;2291:		}
;2292:		r.y = thumbstart + SCROLLBAR_SIZE;
ADDRLP4 0+4
ADDRLP4 16
INDIRI4
CVIF4 4
CNSTF4 1098907648
ADDF4
ASGNF4
line 2293
;2293:		r.h = item->window.rect.y + item->window.rect.h - SCROLLBAR_SIZE;
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+12
ADDRLP4 52
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 2294
;2294:		if (Rect_ContainsWidescreenPoint(&r, x, y, item->widescreen)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $998
line 2295
;2295:			return WINDOW_LB_PGDN;
CNSTI4 32768
RETI4
ADDRGP4 $959
JUMPV
LABELV $998
line 2297
;2296:		}
;2297:	}
LABELV $964
line 2298
;2298:	return 0;
CNSTI4 0
RETI4
LABELV $959
endproc Item_ListBox_OverLB 60 16
proc Item_ListBox_MouseEnter 52 16
line 2302
;2299:}
;2300:
;2301:
;2302:static void Item_ListBox_MouseEnter(itemDef_t *item, float x, float y) {
line 2304
;2303:	rectDef_t r;
;2304:	listBoxDef_t *listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 2308
;2305:
;2306:	//Com_Printf("enter list box\n");
;2307:
;2308:	item->window.flags &= ~(WINDOW_LB_LEFTARROW | WINDOW_LB_RIGHTARROW | WINDOW_LB_THUMB | WINDOW_LB_PGUP | WINDOW_LB_PGDN);
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 -63489
BANDI4
ASGNI4
line 2309
;2309:	item->window.flags |= Item_ListBox_OverLB(item, x, y);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 Item_ListBox_OverLB
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 24
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
ADDRLP4 28
INDIRI4
BORI4
ASGNI4
line 2311
;2310:
;2311:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1001
line 2312
;2312:		if (!(item->window.flags & (WINDOW_LB_LEFTARROW | WINDOW_LB_RIGHTARROW | WINDOW_LB_THUMB | WINDOW_LB_PGUP | WINDOW_LB_PGDN))) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 63488
BANDI4
CNSTI4 0
NEI4 $1002
line 2314
;2313:			// check for selection hit as we have exausted buttons and thumb
;2314:			if (listPtr->elementStyle == LISTBOX_IMAGE) {
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1002
line 2315
;2315:				r.x = item->window.rect.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 2316
;2316:				r.y = item->window.rect.y;
ADDRLP4 4+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 2317
;2317:				r.h = item->window.rect.h - SCROLLBAR_SIZE;
ADDRLP4 4+12
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 2318
;2318:				r.w = item->window.rect.w - listPtr->drawPadding;
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 2319
;2319:				if (Rect_ContainsWidescreenPoint(&r, x, y, item->widescreen)) {
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $1002
line 2320
;2320:					listPtr->cursorPos = (int)((x - r.x) / listPtr->elementWidth) + listPtr->startPos;
ADDRLP4 40
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ADDRLP4 40
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
DIVF4
CVFI4 4
ADDRLP4 40
INDIRP4
INDIRI4
ADDI4
ASGNI4
line 2321
;2321:					if (listPtr->cursorPos >= listPtr->endPos) {
ADDRLP4 44
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LTI4 $1002
line 2322
;2322:						listPtr->cursorPos = listPtr->endPos;
ADDRLP4 48
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 2323
;2323:					}
line 2324
;2324:				}
line 2325
;2325:			} else {
line 2327
;2326:				// text hit.. 
;2327:			}
line 2328
;2328:		}
line 2329
;2329:	} else if (!(item->window.flags & (WINDOW_LB_LEFTARROW | WINDOW_LB_RIGHTARROW | WINDOW_LB_THUMB | WINDOW_LB_PGUP | WINDOW_LB_PGDN))) {
ADDRGP4 $1002
JUMPV
LABELV $1001
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 63488
BANDI4
CNSTI4 0
NEI4 $1014
line 2330
;2330:		r.x = item->window.rect.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 2331
;2331:		r.y = item->window.rect.y;
ADDRLP4 4+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 2332
;2332:		r.w = item->window.rect.w - SCROLLBAR_SIZE;
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 2333
;2333:		r.h = item->window.rect.h - listPtr->drawPadding;
ADDRLP4 4+12
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 2334
;2334:		if (Rect_ContainsWidescreenPoint(&r, x, y, item->widescreen)) {
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $1019
line 2335
;2335:			listPtr->cursorPos = (int)((y - 2 - r.y) / listPtr->elementHeight) + listPtr->startPos;
ADDRLP4 40
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 8
INDIRF4
CNSTF4 1073741824
SUBF4
ADDRLP4 4+4
INDIRF4
SUBF4
ADDRLP4 40
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
DIVF4
CVFI4 4
ADDRLP4 40
INDIRP4
INDIRI4
ADDI4
ASGNI4
line 2336
;2336:			if (listPtr->cursorPos > listPtr->endPos) {
ADDRLP4 44
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LEI4 $1022
line 2337
;2337:				listPtr->cursorPos = listPtr->endPos;
ADDRLP4 48
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 2338
;2338:			}
LABELV $1022
line 2339
;2339:		}
LABELV $1019
line 2340
;2340:	}
LABELV $1014
LABELV $1002
line 2341
;2341:}
LABELV $1000
endproc Item_ListBox_MouseEnter 52 16
proc Item_MouseEnter 44 16
line 2343
;2342:
;2343:static void Item_MouseEnter(itemDef_t *item, float x, float y) {
line 2345
;2344:	rectDef_t r;
;2345:	if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1025
line 2346
;2346:		r = item->textRect;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRB
ASGNB 16
line 2347
;2347:		r.y -= r.h;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 0+12
INDIRF4
SUBF4
ASGNF4
line 2351
;2348:		// in the text rect?
;2349:
;2350:		// items can be enabled and disabled based on cvars
;2351:		if (item->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(item, CVAR_ENABLE)) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $1029
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 20
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $1029
line 2352
;2352:			return;
ADDRGP4 $1024
JUMPV
LABELV $1029
line 2355
;2353:		}
;2354:
;2355:		if (item->cvarFlags & (CVAR_SHOW | CVAR_HIDE) && !Item_EnableShowViaCvar(item, CVAR_SHOW)) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $1031
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 28
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $1031
line 2356
;2356:			return;
ADDRGP4 $1024
JUMPV
LABELV $1031
line 2359
;2357:		}
;2358:
;2359:		if (Rect_ContainsWidescreenPoint(&r, x, y, item->widescreen)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $1033
line 2360
;2360:			if (!(item->window.flags & WINDOW_MOUSEOVERTEXT)) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
NEI4 $1035
line 2361
;2361:				Item_RunScript(item, item->mouseEnterText);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2362
;2362:				item->window.flags |= WINDOW_MOUSEOVERTEXT;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 2363
;2363:			}
LABELV $1035
line 2364
;2364:			if (!(item->window.flags & WINDOW_MOUSEOVER)) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $1034
line 2365
;2365:				Item_RunScript(item, item->mouseEnter);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2366
;2366:				item->window.flags |= WINDOW_MOUSEOVER;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 2367
;2367:			}
line 2369
;2368:
;2369:		} else {
ADDRGP4 $1034
JUMPV
LABELV $1033
line 2371
;2370:			// not in the text rect
;2371:			if (item->window.flags & WINDOW_MOUSEOVERTEXT) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $1039
line 2373
;2372:				// if we were
;2373:				Item_RunScript(item, item->mouseExitText);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 260
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2374
;2374:				item->window.flags &= ~WINDOW_MOUSEOVERTEXT;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 2375
;2375:			}
LABELV $1039
line 2376
;2376:			if (!(item->window.flags & WINDOW_MOUSEOVER)) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $1041
line 2377
;2377:				Item_RunScript(item, item->mouseEnter);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2378
;2378:				item->window.flags |= WINDOW_MOUSEOVER;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 2379
;2379:			}
LABELV $1041
line 2381
;2380:
;2381:			if (item->type == ITEM_TYPE_LISTBOX) {
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 6
NEI4 $1043
line 2382
;2382:				Item_ListBox_MouseEnter(item, x, y);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRGP4 Item_ListBox_MouseEnter
CALLV
pop
line 2383
;2383:			}
LABELV $1043
line 2384
;2384:		}
LABELV $1034
line 2385
;2385:	}
LABELV $1025
line 2386
;2386:}
LABELV $1024
endproc Item_MouseEnter 44 16
proc Item_MouseLeave 8 8
line 2388
;2387:
;2388:static void Item_MouseLeave(itemDef_t *item) {
line 2389
;2389:	if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1046
line 2390
;2390:		if (item->window.flags & WINDOW_MOUSEOVERTEXT) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $1048
line 2391
;2391:			Item_RunScript(item, item->mouseExitText);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2392
;2392:			item->window.flags &= ~WINDOW_MOUSEOVERTEXT;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 2393
;2393:		}
LABELV $1048
line 2394
;2394:		Item_RunScript(item, item->mouseExit);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 268
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2395
;2395:		item->window.flags &= ~(WINDOW_LB_RIGHTARROW | WINDOW_LB_LEFTARROW);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -6145
BANDI4
ASGNI4
line 2396
;2396:	}
LABELV $1046
line 2397
;2397:}
LABELV $1045
endproc Item_MouseLeave 8 8
proc Item_SetMouseOver 4 0
line 2412
;2398:
;2399:// unused
;2400:#if 0
;2401:static itemDef_t *Menu_HitTest(menuDef_t *menu, float x, float y) {
;2402:	int i;
;2403:	for (i = 0; i < menu->itemCount; i++) {
;2404:		if (Rect_ContainsWidescreenPoint(&menu->items[i]->window.rect, x, y, menu->items[i]->widescreen)) {
;2405:			return menu->items[i];
;2406:		}
;2407:	}
;2408:	return NULL;
;2409:}
;2410:#endif
;2411:
;2412:static void Item_SetMouseOver(itemDef_t *item, qboolean focus) {
line 2413
;2413:	if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1051
line 2414
;2414:		if (focus) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $1053
line 2415
;2415:			item->window.flags |= WINDOW_MOUSEOVER;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 2416
;2416:		} else {
ADDRGP4 $1054
JUMPV
LABELV $1053
line 2417
;2417:			item->window.flags &= ~WINDOW_MOUSEOVER;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 2418
;2418:		}
LABELV $1054
line 2419
;2419:	}
LABELV $1051
line 2420
;2420:}
LABELV $1050
endproc Item_SetMouseOver 4 0
proc Item_OwnerDraw_HandleKey 8 20
line 2423
;2421:
;2422:
;2423:static qboolean Item_OwnerDraw_HandleKey(itemDef_t *item, int key) {
line 2424
;2424:	if (item && DC->ownerDrawHandleKey) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1056
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1056
line 2425
;2425:		return DC->ownerDrawHandleKey(item->window.ownerDraw, item->window.ownerDrawFlags, item->window.ownerDrawFlags2, &item->special, key);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 560
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $1055
JUMPV
LABELV $1056
line 2427
;2426:	}
;2427:	return qfalse;
CNSTI4 0
RETI4
LABELV $1055
endproc Item_OwnerDraw_HandleKey 8 20
proc Item_ListBox_HandleKey 72 16
line 2430
;2428:}
;2429:
;2430:static qboolean Item_ListBox_HandleKey(itemDef_t *item, int key, qboolean down, qboolean force) {
line 2431
;2431:	listBoxDef_t *listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 2432
;2432:	int count = DC->feederCount(item->special);
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 DC
INDIRP4
CNSTI4 124
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
ASGNI4
line 2435
;2433:	int max, viewmax;
;2434:
;2435:	if (force || (Rect_ContainsWidescreenPoint(&item->window.rect, DC->cursorx, DC->cursory, item->widescreen) && item->window.flags & WINDOW_HASFOCUS)) {
ADDRFP4 12
INDIRI4
CNSTI4 0
NEI4 $1061
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $1059
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1059
LABELV $1061
line 2436
;2436:		max = Item_ListBox_MaxScroll(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 Item_ListBox_MaxScroll
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 32
INDIRI4
ASGNI4
line 2437
;2437:		if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1062
line 2438
;2438:			viewmax = (item->window.rect.w / listPtr->elementWidth);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 2439
;2439:			if (key == K_LEFTARROW || key == K_KP_LEFTARROW) {
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 134
EQI4 $1066
ADDRLP4 36
INDIRI4
CNSTI4 163
NEI4 $1064
LABELV $1066
line 2440
;2440:				if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 472
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1067
line 2441
;2441:					listPtr->cursorPos--;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2442
;2442:					if (listPtr->cursorPos < 0) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1069
line 2443
;2443:						listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 2444
;2444:					}
LABELV $1069
line 2445
;2445:					if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $1071
line 2446
;2446:						listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2447
;2447:					}
LABELV $1071
line 2448
;2448:					if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $1073
line 2449
;2449:						listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 2450
;2450:					}
LABELV $1073
line 2451
;2451:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2452
;2452:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 136
ADDP4
INDIRP4
CALLV
pop
line 2453
;2453:				} else {
ADDRGP4 $1068
JUMPV
LABELV $1067
line 2454
;2454:					listPtr->startPos--;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2455
;2455:					if (listPtr->startPos < 0)
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $1075
line 2456
;2456:						listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
LABELV $1075
line 2457
;2457:				}
LABELV $1068
line 2458
;2458:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1058
JUMPV
LABELV $1064
line 2460
;2459:			}
;2460:			if (key == K_RIGHTARROW || key == K_KP_RIGHTARROW) {
ADDRLP4 40
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 135
EQI4 $1079
ADDRLP4 40
INDIRI4
CNSTI4 165
NEI4 $1063
LABELV $1079
line 2461
;2461:				if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 472
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1080
line 2462
;2462:					listPtr->cursorPos++;
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2463
;2463:					if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $1082
line 2464
;2464:						listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2465
;2465:					}
LABELV $1082
line 2466
;2466:					if (listPtr->cursorPos >= count) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $1084
line 2467
;2467:						listPtr->cursorPos = count - 1;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2468
;2468:					}
LABELV $1084
line 2469
;2469:					if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $1086
line 2470
;2470:						listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 2471
;2471:					}
LABELV $1086
line 2472
;2472:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2473
;2473:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 136
ADDP4
INDIRP4
CALLV
pop
line 2474
;2474:				} else {
ADDRGP4 $1081
JUMPV
LABELV $1080
line 2475
;2475:					listPtr->startPos++;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2476
;2476:					if (listPtr->startPos >= count)
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $1088
line 2477
;2477:						listPtr->startPos = count - 1;
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $1088
line 2478
;2478:				}
LABELV $1081
line 2479
;2479:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1058
JUMPV
line 2481
;2480:			}
;2481:		} else {
LABELV $1062
line 2482
;2482:			viewmax = (item->window.rect.h / listPtr->elementHeight);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 2483
;2483:			if (key == K_UPARROW || key == K_KP_UPARROW || key == K_MWHEELUP) {
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 132
EQI4 $1093
ADDRLP4 36
INDIRI4
CNSTI4 161
EQI4 $1093
ADDRLP4 36
INDIRI4
CNSTI4 184
NEI4 $1090
LABELV $1093
line 2484
;2484:				if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 472
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1094
line 2485
;2485:					listPtr->cursorPos--;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2486
;2486:					if (listPtr->cursorPos < 0) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1096
line 2487
;2487:						listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 2488
;2488:					}
LABELV $1096
line 2489
;2489:					if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $1098
line 2490
;2490:						listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2491
;2491:					}
LABELV $1098
line 2492
;2492:					if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $1100
line 2493
;2493:						listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 2494
;2494:					}
LABELV $1100
line 2495
;2495:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2496
;2496:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 136
ADDP4
INDIRP4
CALLV
pop
line 2497
;2497:				} else {
ADDRGP4 $1095
JUMPV
LABELV $1094
line 2498
;2498:					listPtr->startPos--;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2499
;2499:					if (listPtr->startPos < 0)
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $1102
line 2500
;2500:						listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
LABELV $1102
line 2501
;2501:				}
LABELV $1095
line 2502
;2502:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1058
JUMPV
LABELV $1090
line 2504
;2503:			}
;2504:			if (key == K_DOWNARROW || key == K_KP_DOWNARROW || key == K_MWHEELDOWN) {
ADDRLP4 40
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 133
EQI4 $1107
ADDRLP4 40
INDIRI4
CNSTI4 167
EQI4 $1107
ADDRLP4 40
INDIRI4
CNSTI4 183
NEI4 $1104
LABELV $1107
line 2505
;2505:				if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 472
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1108
line 2506
;2506:					listPtr->cursorPos++;
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2507
;2507:					if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $1110
line 2508
;2508:						listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2509
;2509:					}
LABELV $1110
line 2510
;2510:					if (listPtr->cursorPos >= count) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $1112
line 2511
;2511:						listPtr->cursorPos = count - 1;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2512
;2512:					}
LABELV $1112
line 2513
;2513:					if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $1114
line 2514
;2514:						listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 2515
;2515:					}
LABELV $1114
line 2516
;2516:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2517
;2517:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 136
ADDP4
INDIRP4
CALLV
pop
line 2518
;2518:				} else {
ADDRGP4 $1109
JUMPV
LABELV $1108
line 2519
;2519:					listPtr->startPos++;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2520
;2520:					if (listPtr->startPos > max)
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $1116
line 2521
;2521:						listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
LABELV $1116
line 2522
;2522:				}
LABELV $1109
line 2523
;2523:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1058
JUMPV
LABELV $1104
line 2525
;2524:			}
;2525:		}
LABELV $1063
line 2527
;2526:		// mouse hit
;2527:		if (key == K_MOUSE1 || key == K_MOUSE2) {
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 178
EQI4 $1120
ADDRLP4 36
INDIRI4
CNSTI4 179
NEI4 $1118
LABELV $1120
line 2528
;2528:			if (item->window.flags & WINDOW_LB_LEFTARROW) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1121
line 2529
;2529:				listPtr->startPos--;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2530
;2530:				if (listPtr->startPos < 0) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $1122
line 2531
;2531:					listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 2532
;2532:				}
line 2533
;2533:			} else if (item->window.flags & WINDOW_LB_RIGHTARROW) {
ADDRGP4 $1122
JUMPV
LABELV $1121
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1125
line 2535
;2534:				// one down
;2535:				listPtr->startPos++;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2536
;2536:				if (listPtr->startPos > max) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $1126
line 2537
;2537:					listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 2538
;2538:				}
line 2539
;2539:			} else if (item->window.flags & WINDOW_LB_PGUP) {
ADDRGP4 $1126
JUMPV
LABELV $1125
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $1129
line 2541
;2540:				// page up
;2541:				listPtr->startPos -= viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 2542
;2542:				if (listPtr->startPos < 0) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $1130
line 2543
;2543:					listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 2544
;2544:				}
line 2545
;2545:			} else if (item->window.flags & WINDOW_LB_PGDN) {
ADDRGP4 $1130
JUMPV
LABELV $1129
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $1133
line 2547
;2546:				// page down
;2547:				listPtr->startPos += viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 2548
;2548:				if (listPtr->startPos > max) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $1134
line 2549
;2549:					listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 2550
;2550:				}
line 2551
;2551:			} else if (item->window.flags & WINDOW_LB_THUMB) {
ADDRGP4 $1134
JUMPV
LABELV $1133
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1137
line 2553
;2552:				// Display_SetCaptureItem(item);
;2553:			} else {
ADDRGP4 $1138
JUMPV
LABELV $1137
line 2555
;2554:				// select an item
;2555:				if (DC->realTime < lastListBoxClickTime && listPtr->doubleClick) {
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ADDRGP4 lastListBoxClickTime
INDIRI4
GEI4 $1139
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1139
line 2556
;2556:					Item_RunScript(item, listPtr->doubleClick);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2557
;2557:				}
LABELV $1139
line 2558
;2558:				lastListBoxClickTime = DC->realTime + DOUBLE_CLICK_DELAY;
ADDRGP4 lastListBoxClickTime
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 300
ADDI4
ASGNI4
line 2559
;2559:				if (item->cursorPos != listPtr->cursorPos) {
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
EQI4 $1141
line 2560
;2560:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2561
;2561:					listPtr->selectedCursorPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2562
;2562:					LastListSelected = listPtr;
ADDRGP4 LastListSelected
ADDRLP4 0
INDIRP4
ASGNP4
line 2563
;2563:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 136
ADDP4
INDIRP4
CALLV
pop
line 2564
;2564:				}
LABELV $1141
line 2566
;2565:				//Com_Printf("selected %p\n", item);
;2566:			}
LABELV $1138
LABELV $1134
LABELV $1130
LABELV $1126
LABELV $1122
line 2567
;2567:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1058
JUMPV
LABELV $1118
line 2569
;2568:		}
;2569:		if (key == K_HOME || key == K_KP_HOME) {
ADDRLP4 40
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 143
EQI4 $1145
ADDRLP4 40
INDIRI4
CNSTI4 160
NEI4 $1143
LABELV $1145
line 2571
;2570:			// home
;2571:			listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 2572
;2572:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1058
JUMPV
LABELV $1143
line 2574
;2573:		}
;2574:		if (key == K_END || key == K_KP_END) {
ADDRLP4 44
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 144
EQI4 $1148
ADDRLP4 44
INDIRI4
CNSTI4 166
NEI4 $1146
LABELV $1148
line 2576
;2575:			// end
;2576:			listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 2577
;2577:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1058
JUMPV
LABELV $1146
line 2579
;2578:		}
;2579:		if (key == K_PGUP || key == K_KP_PGUP) {
ADDRLP4 48
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 142
EQI4 $1151
ADDRLP4 48
INDIRI4
CNSTI4 162
NEI4 $1149
LABELV $1151
line 2581
;2580:			// page up
;2581:			if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 472
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1152
line 2582
;2582:				listPtr->cursorPos -= viewmax;
ADDRLP4 52
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 2583
;2583:				if (listPtr->cursorPos < 0) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1154
line 2584
;2584:					listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 2585
;2585:				}
LABELV $1154
line 2586
;2586:				if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $1156
line 2587
;2587:					listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2588
;2588:				}
LABELV $1156
line 2589
;2589:				if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $1158
line 2590
;2590:					listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 2591
;2591:				}
LABELV $1158
line 2592
;2592:				item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2593
;2593:				DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
ARGF4
ADDRLP4 64
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 136
ADDP4
INDIRP4
CALLV
pop
line 2594
;2594:			} else {
ADDRGP4 $1153
JUMPV
LABELV $1152
line 2595
;2595:				listPtr->startPos -= viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 2596
;2596:				if (listPtr->startPos < 0) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $1160
line 2597
;2597:					listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 2598
;2598:				}
LABELV $1160
line 2599
;2599:			}
LABELV $1153
line 2600
;2600:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1058
JUMPV
LABELV $1149
line 2602
;2601:		}
;2602:		if (key == K_PGDN || key == K_KP_PGDN) {
ADDRLP4 52
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 141
EQI4 $1164
ADDRLP4 52
INDIRI4
CNSTI4 168
NEI4 $1162
LABELV $1164
line 2604
;2603:			// page down
;2604:			if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 472
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1165
line 2605
;2605:				listPtr->cursorPos += viewmax;
ADDRLP4 56
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 2606
;2606:				if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $1167
line 2607
;2607:					listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2608
;2608:				}
LABELV $1167
line 2609
;2609:				if (listPtr->cursorPos >= count) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $1169
line 2610
;2610:					listPtr->cursorPos = count - 1;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2611
;2611:				}
LABELV $1169
line 2612
;2612:				if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
LTI4 $1171
line 2613
;2613:					listPtr->startPos = listPtr->cursorPos - viewmax + 1;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 2614
;2614:				}
LABELV $1171
line 2615
;2615:				item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 2616
;2616:				DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
ARGF4
ADDRLP4 68
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 136
ADDP4
INDIRP4
CALLV
pop
line 2617
;2617:			} else {
ADDRGP4 $1166
JUMPV
LABELV $1165
line 2618
;2618:				listPtr->startPos += viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 2619
;2619:				if (listPtr->startPos > max) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $1173
line 2620
;2620:					listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 2621
;2621:				}
LABELV $1173
line 2622
;2622:			}
LABELV $1166
line 2623
;2623:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1058
JUMPV
LABELV $1162
line 2625
;2624:		}
;2625:	}
LABELV $1059
line 2626
;2626:	return qfalse;
CNSTI4 0
RETI4
LABELV $1058
endproc Item_ListBox_HandleKey 72 16
proc Item_YesNo_HandleKey 24 16
line 2629
;2627:}
;2628:
;2629:static qboolean Item_YesNo_HandleKey(itemDef_t *item, int key) {
line 2630
;2630:	if (item->cvar) {
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1176
line 2631
;2631:		qboolean action = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2633
;2632:
;2633:		if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_MOUSE3) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 178
EQI4 $1181
ADDRLP4 4
INDIRI4
CNSTI4 179
EQI4 $1181
ADDRLP4 4
INDIRI4
CNSTI4 180
NEI4 $1178
LABELV $1181
line 2634
;2634:			if (Rect_ContainsWidescreenPoint(&item->window.rect, DC->cursorx, DC->cursory, item->widescreen) && item->window.flags & WINDOW_HASFOCUS) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $1179
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1179
line 2635
;2635:				action = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 2636
;2636:			}
line 2637
;2637:		} else if (UI_SelectForKey(key) != 0) {
ADDRGP4 $1179
JUMPV
LABELV $1178
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 UI_SelectForKey
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1184
line 2638
;2638:			action = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 2639
;2639:		}
LABELV $1184
LABELV $1179
line 2641
;2640:
;2641:		if (action) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1186
line 2642
;2642:			DC->setCVar(item->cvar, va("%i", !DC->getCVarValue(item->cvar)));
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 16
INDIRF4
CNSTF4 0
NEF4 $1190
ADDRLP4 12
CNSTI4 1
ASGNI4
ADDRGP4 $1191
JUMPV
LABELV $1190
ADDRLP4 12
CNSTI4 0
ASGNI4
LABELV $1191
ADDRGP4 $1188
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2643
;2643:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1175
JUMPV
LABELV $1186
line 2645
;2644:		}
;2645:	}
LABELV $1176
line 2647
;2646:
;2647:	return qfalse;
CNSTI4 0
RETI4
LABELV $1175
endproc Item_YesNo_HandleKey 24 16
proc Item_Multi_CountSettings 4 0
line 2650
;2648:}
;2649:
;2650:static int Item_Multi_CountSettings(itemDef_t *item) {
line 2651
;2651:	multiDef_t *multiPtr = (multiDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 2652
;2652:	if (multiPtr == NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1193
line 2653
;2653:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1192
JUMPV
LABELV $1193
line 2655
;2654:	}
;2655:	return multiPtr->count;
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
RETI4
LABELV $1192
endproc Item_Multi_CountSettings 4 0
proc Item_Multi_FindCvarByValue 1040 12
line 2658
;2656:}
;2657:
;2658:static int Item_Multi_FindCvarByValue(itemDef_t *item) {
line 2660
;2659:	char buff[1024];
;2660:	float value = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 2662
;2661:	int i;
;2662:	multiDef_t *multiPtr = (multiDef_t *)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 2663
;2663:	if (multiPtr) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1196
line 2664
;2664:		if (multiPtr->strDef) {
ADDRLP4 4
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1198
line 2665
;2665:			DC->getCVarString(item->cvar, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 2666
;2666:		} else {
ADDRGP4 $1199
JUMPV
LABELV $1198
line 2667
;2667:			value = DC->getCVarValue(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 1036
INDIRF4
ASGNF4
line 2668
;2668:		}
LABELV $1199
line 2669
;2669:		for (i = 0; i < multiPtr->count; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1203
JUMPV
LABELV $1200
line 2670
;2670:			if (multiPtr->strDef) {
ADDRLP4 4
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1204
line 2671
;2671:				if (Q_stricmp(buff, multiPtr->cvarStr[i]) == 0) {
ADDRLP4 12
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 128
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $1205
line 2672
;2672:					return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1195
JUMPV
line 2674
;2673:				}
;2674:			} else {
LABELV $1204
line 2675
;2675:				if (multiPtr->cvarValue[i] == value) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 256
ADDP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
NEF4 $1208
line 2676
;2676:					return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1195
JUMPV
LABELV $1208
line 2678
;2677:				}
;2678:			}
LABELV $1205
line 2679
;2679:		}
LABELV $1201
line 2669
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1203
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
LTI4 $1200
line 2680
;2680:	}
LABELV $1196
line 2681
;2681:	return 0;
CNSTI4 0
RETI4
LABELV $1195
endproc Item_Multi_FindCvarByValue 1040 12
proc Item_Multi_Setting 1040 12
line 2684
;2682:}
;2683:
;2684:static const char *Item_Multi_Setting(itemDef_t *item) {
line 2686
;2685:	char buff[1024];
;2686:	float value = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 2688
;2687:	int i;
;2688:	multiDef_t *multiPtr = (multiDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 2689
;2689:	if (multiPtr) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1211
line 2690
;2690:		if (multiPtr->strDef) {
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1213
line 2691
;2691:			DC->getCVarString(item->cvar, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 2692
;2692:		} else {
ADDRGP4 $1214
JUMPV
LABELV $1213
line 2693
;2693:			value = DC->getCVarValue(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 1036
INDIRF4
ASGNF4
line 2694
;2694:		}
LABELV $1214
line 2695
;2695:		for (i = 0; i < multiPtr->count; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1218
JUMPV
LABELV $1215
line 2696
;2696:			if (multiPtr->strDef) {
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1219
line 2697
;2697:				if (Q_stricmp(buff, multiPtr->cvarStr[i]) == 0) {
ADDRLP4 12
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $1220
line 2698
;2698:					return multiPtr->cvarList[i];
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $1210
JUMPV
line 2700
;2699:				}
;2700:			} else {
LABELV $1219
line 2701
;2701:				if (multiPtr->cvarValue[i] == value) {
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
NEF4 $1223
line 2702
;2702:					return multiPtr->cvarList[i];
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $1210
JUMPV
LABELV $1223
line 2704
;2703:				}
;2704:			}
LABELV $1220
line 2705
;2705:		}
LABELV $1216
line 2695
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1218
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
LTI4 $1215
line 2706
;2706:	}
LABELV $1211
line 2707
;2707:	return "";
ADDRGP4 $94
RETP4
LABELV $1210
endproc Item_Multi_Setting 1040 12
proc Item_Multi_HandleKey 80 16
line 2710
;2708:}
;2709:
;2710:static qboolean Item_Multi_HandleKey(itemDef_t *item, int key) {
line 2711
;2711:	multiDef_t *multiPtr = (multiDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 2712
;2712:	if (multiPtr) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1226
line 2713
;2713:		if (item->cvar) {
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1228
line 2714
;2714:			int select = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2716
;2715:
;2716:			if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_MOUSE3) {
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 178
EQI4 $1233
ADDRLP4 8
INDIRI4
CNSTI4 179
EQI4 $1233
ADDRLP4 8
INDIRI4
CNSTI4 180
NEI4 $1230
LABELV $1233
line 2717
;2717:				if (Rect_ContainsWidescreenPoint(&item->window.rect, DC->cursorx, DC->cursory, item->widescreen) && item->window.flags & WINDOW_HASFOCUS) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $1231
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1231
line 2718
;2718:					select = (key == K_MOUSE2) ? -1 : 1;
ADDRFP4 4
INDIRI4
CNSTI4 179
NEI4 $1237
ADDRLP4 24
CNSTI4 -1
ASGNI4
ADDRGP4 $1238
JUMPV
LABELV $1237
ADDRLP4 24
CNSTI4 1
ASGNI4
LABELV $1238
ADDRLP4 4
ADDRLP4 24
INDIRI4
ASGNI4
line 2719
;2719:				}
line 2720
;2720:			} else {
ADDRGP4 $1231
JUMPV
LABELV $1230
line 2721
;2721:				select = UI_SelectForKey(key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 UI_SelectForKey
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 2722
;2722:			}
LABELV $1231
line 2724
;2723:
;2724:			if (select != 0) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1239
line 2725
;2725:				int current = Item_Multi_FindCvarByValue(item) + 1;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Item_Multi_FindCvarByValue
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2726
;2726:				int max = Item_Multi_CountSettings(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 Item_Multi_CountSettings
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 24
INDIRI4
ASGNI4
line 2727
;2727:				if (current < 0) {
ADDRLP4 12
INDIRI4
CNSTI4 0
GEI4 $1241
line 2728
;2728:					current = max - 1;
ADDRLP4 12
ADDRLP4 16
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2729
;2729:				} else if (current >= max) {
ADDRGP4 $1242
JUMPV
LABELV $1241
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $1243
line 2730
;2730:					current = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 2731
;2731:				}
LABELV $1243
LABELV $1242
line 2733
;2732:
;2733:				if (multiPtr->videoMode) {
ADDRLP4 0
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1245
line 2734
;2734:					if (multiPtr->cvarValue[current] != -1) {
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
ADDP4
INDIRF4
CNSTF4 3212836864
EQF4 $1247
line 2735
;2735:						DC->setCVar("r_mode", va("%i", (int)multiPtr->cvarValue[current]));
ADDRGP4 $1188
ARGP4
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1249
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2736
;2736:					} else {
ADDRGP4 $1248
JUMPV
LABELV $1247
line 2741
;2737:						int w, h;
;2738:						char *x;
;2739:						char str[8];
;2740:
;2741:						x = strchr(multiPtr->cvarStr[current], 'x') + 1;
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDP4
INDIRP4
ARGP4
CNSTI4 120
ARGI4
ADDRLP4 48
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 48
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 2742
;2742:						Q_strncpyz(str, multiPtr->cvarStr[current], MIN(x - multiPtr->cvarStr[current], sizeof(str)));
ADDRLP4 32
ARGP4
ADDRLP4 56
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 60
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 60
INDIRP4
CNSTI4 128
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
CVPU4 4
ADDRLP4 56
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 60
INDIRP4
CNSTI4 128
ADDP4
ADDP4
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CVIU4 4
CNSTU4 8
GEU4 $1251
ADDRLP4 52
ADDRLP4 28
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDP4
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CVIU4 4
ASGNU4
ADDRGP4 $1252
JUMPV
LABELV $1251
ADDRLP4 52
CNSTU4 8
ASGNU4
LABELV $1252
ADDRLP4 52
INDIRU4
CVUI4 4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2743
;2743:						w = atoi(str);
ADDRLP4 32
ARGP4
ADDRLP4 64
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 64
INDIRI4
ASGNI4
line 2744
;2744:						h = atoi(x);
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 68
INDIRI4
ASGNI4
line 2746
;2745:
;2746:						DC->setCVar("r_mode", "-1");
ADDRGP4 $1249
ARGP4
ADDRGP4 $1253
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2747
;2747:						DC->setCVar("r_customwidth", va("%i", w));
ADDRGP4 $1188
ARGP4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 72
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1254
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2748
;2748:						DC->setCVar("r_customheight", va("%i", h));
ADDRGP4 $1188
ARGP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 76
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1255
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2749
;2749:					}
LABELV $1248
line 2750
;2750:				}
LABELV $1245
line 2752
;2751:
;2752:				if (multiPtr->strDef) {
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1256
line 2753
;2753:					DC->setCVar(item->cvar, multiPtr->cvarStr[current]);
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2754
;2754:				} else {
ADDRGP4 $1257
JUMPV
LABELV $1256
line 2755
;2755:					float value = multiPtr->cvarValue[current];
ADDRLP4 28
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
ADDP4
INDIRF4
ASGNF4
line 2756
;2756:					if (((float)((int)value)) == value) {
ADDRLP4 32
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 32
INDIRF4
CVFI4 4
CVIF4 4
ADDRLP4 32
INDIRF4
NEF4 $1258
line 2757
;2757:						DC->setCVar(item->cvar, va("%i", (int)value));
ADDRGP4 $1188
ARGP4
ADDRLP4 28
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2758
;2758:					} else {
ADDRGP4 $1259
JUMPV
LABELV $1258
line 2759
;2759:						DC->setCVar(item->cvar, va("%f", value));
ADDRGP4 $1260
ARGP4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2760
;2760:					}
LABELV $1259
line 2761
;2761:				}
LABELV $1257
line 2762
;2762:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1225
JUMPV
LABELV $1239
line 2764
;2763:			}
;2764:		}
LABELV $1228
line 2765
;2765:	}
LABELV $1226
line 2766
;2766:	return qfalse;
CNSTI4 0
RETI4
LABELV $1225
endproc Item_Multi_HandleKey 80 16
proc Item_TextField_HandleKey 1076 12
line 2770
;2767:}
;2768:
;2769://FIXME UTF-8
;2770:static qboolean Item_TextField_HandleKey(itemDef_t *item, int key) {
line 2773
;2771:	char buff[1024];
;2772:	int len;
;2773:	itemDef_t *newItem = NULL;
ADDRLP4 1028
CNSTP4 0
ASGNP4
line 2774
;2774:	editFieldDef_t *editPtr = (editFieldDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 2777
;2775:
;2776:	//Com_Printf("item key:  %d '%c'\n", key, key);
;2777:	if (item->cvar) {
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1262
line 2779
;2778:
;2779:		memset(buff, 0, sizeof(buff));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2780
;2780:		DC->getCVarString(item->cvar, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 2781
;2781:		len = strlen(buff);
ADDRLP4 4
ARGP4
ADDRLP4 1036
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1036
INDIRI4
ASGNI4
line 2782
;2782:		if (editPtr->maxChars && len > editPtr->maxChars) {
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1264
ADDRLP4 1032
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
LEI4 $1264
line 2783
;2783:			len = editPtr->maxChars;
ADDRLP4 1032
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 2784
;2784:		}
LABELV $1264
line 2785
;2785:		if (key & K_CHAR_FLAG) {
ADDRFP4 4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1266
line 2786
;2786:			key &= ~K_CHAR_FLAG;
ADDRFP4 4
ADDRFP4 4
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 2789
;2787:
;2788:
;2789:			if (key == 'h' - 'a' + 1) {	// ctrl-h is backspace
ADDRFP4 4
INDIRI4
CNSTI4 8
NEI4 $1268
line 2790
;2790:				if (item->cursorPos > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1270
line 2791
;2791:					memmove(&buff[item->cursorPos - 1], &buff[item->cursorPos], len + 1 - item->cursorPos);
ADDRLP4 1044
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1044
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ADDRLP4 4-1
ADDP4
ARGP4
ADDRLP4 1044
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 1032
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 1044
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
SUBI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 2792
;2792:					item->cursorPos--;
ADDRLP4 1048
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
ASGNP4
ADDRLP4 1048
INDIRP4
ADDRLP4 1048
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2793
;2793:					if (item->cursorPos < editPtr->paintOffset) {
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
GEI4 $1273
line 2794
;2794:						editPtr->paintOffset--;
ADDRLP4 1052
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 1052
INDIRP4
ADDRLP4 1052
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2795
;2795:					}
LABELV $1273
line 2796
;2796:				}
LABELV $1270
line 2797
;2797:				DC->setCVar(item->cvar, buff);
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2798
;2798:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1261
JUMPV
LABELV $1268
line 2805
;2799:			}
;2800:
;2801:
;2802:			//
;2803:			// ignore any non printable chars
;2804:			//
;2805:			if (key < 32 || !item->cvar) {
ADDRFP4 4
INDIRI4
CNSTI4 32
LTI4 $1277
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1275
LABELV $1277
line 2806
;2806:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1261
JUMPV
LABELV $1275
line 2809
;2807:			}
;2808:
;2809:			if (item->type == ITEM_TYPE_NUMERICFIELD) {
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 9
NEI4 $1278
line 2810
;2810:				if (key < '0' || key > '9') {
ADDRLP4 1044
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 48
LTI4 $1282
ADDRLP4 1044
INDIRI4
CNSTI4 57
LEI4 $1280
LABELV $1282
line 2811
;2811:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1261
JUMPV
LABELV $1280
line 2813
;2812:				}
;2813:			}
LABELV $1278
line 2815
;2814:
;2815:			if (!DC->getOverstrikeMode()) {
ADDRLP4 1044
ADDRGP4 DC
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $1283
line 2816
;2816:				if ((len == MAX_EDITFIELD - 1) || (editPtr->maxChars && len >= editPtr->maxChars)) {
ADDRLP4 1048
ADDRLP4 1032
INDIRI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 255
EQI4 $1287
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1285
ADDRLP4 1048
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
LTI4 $1285
LABELV $1287
line 2817
;2817:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1261
JUMPV
LABELV $1285
line 2819
;2818:				}
;2819:				memmove(&buff[item->cursorPos + 1], &buff[item->cursorPos], len + 1 - item->cursorPos);
ADDRLP4 1056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ADDRLP4 4+1
ADDP4
ARGP4
ADDRLP4 1056
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 1032
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 1056
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
SUBI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 2820
;2820:			} else {
ADDRGP4 $1284
JUMPV
LABELV $1283
line 2821
;2821:				if (editPtr->maxChars && item->cursorPos >= editPtr->maxChars) {
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1289
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
LTI4 $1289
line 2822
;2822:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1261
JUMPV
LABELV $1289
line 2824
;2823:				}
;2824:			}
LABELV $1284
line 2826
;2825:
;2826:			buff[item->cursorPos] = key;
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ADDRLP4 4
ADDP4
ADDRFP4 4
INDIRI4
CVII1 4
ASGNI1
line 2828
;2827:
;2828:			DC->setCVar(item->cvar, buff);
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2830
;2829:
;2830:			if (item->cursorPos < len + 1) {
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ADDRLP4 1032
INDIRI4
CNSTI4 1
ADDI4
GEI4 $1267
line 2831
;2831:				item->cursorPos++;
ADDRLP4 1048
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
ASGNP4
ADDRLP4 1048
INDIRP4
ADDRLP4 1048
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2832
;2832:				if (editPtr->maxPaintChars && item->cursorPos > editPtr->maxPaintChars) {
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1267
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
LEI4 $1267
line 2833
;2833:					editPtr->paintOffset++;
ADDRLP4 1056
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 1056
INDIRP4
ADDRLP4 1056
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2834
;2834:				}
line 2835
;2835:			}
line 2837
;2836:
;2837:		} else {
ADDRGP4 $1267
JUMPV
LABELV $1266
line 2839
;2838:
;2839:			if (key == K_DEL || key == K_KP_DEL) {
ADDRLP4 1044
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 140
EQI4 $1297
ADDRLP4 1044
INDIRI4
CNSTI4 171
NEI4 $1295
LABELV $1297
line 2840
;2840:				if (item->cursorPos < len) {
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ADDRLP4 1032
INDIRI4
GEI4 $1298
line 2841
;2841:					memmove(buff + item->cursorPos, buff + item->cursorPos + 1, len - item->cursorPos);
ADDRLP4 1048
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 1048
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ADDRLP4 4+1
ADDP4
ARGP4
ADDRLP4 1032
INDIRI4
ADDRLP4 1048
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
SUBI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 2842
;2842:					DC->setCVar(item->cvar, buff);
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2843
;2843:				}
LABELV $1298
line 2844
;2844:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1261
JUMPV
LABELV $1295
line 2847
;2845:			}
;2846:
;2847:			if (key == K_RIGHTARROW || key == K_KP_RIGHTARROW) {
ADDRLP4 1048
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 135
EQI4 $1303
ADDRLP4 1048
INDIRI4
CNSTI4 165
NEI4 $1301
LABELV $1303
line 2848
;2848:				if (editPtr->maxPaintChars && item->cursorPos >= editPtr->maxPaintChars && item->cursorPos < len) {
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1304
ADDRLP4 1056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
LTI4 $1304
ADDRLP4 1056
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ADDRLP4 1032
INDIRI4
GEI4 $1304
line 2849
;2849:					item->cursorPos++;
ADDRLP4 1060
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
ASGNP4
ADDRLP4 1060
INDIRP4
ADDRLP4 1060
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2850
;2850:					editPtr->paintOffset++;
ADDRLP4 1064
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 1064
INDIRP4
ADDRLP4 1064
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2851
;2851:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1261
JUMPV
LABELV $1304
line 2853
;2852:				}
;2853:				if (item->cursorPos < len) {
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ADDRLP4 1032
INDIRI4
GEI4 $1306
line 2854
;2854:					item->cursorPos++;
ADDRLP4 1060
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
ASGNP4
ADDRLP4 1060
INDIRP4
ADDRLP4 1060
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2855
;2855:				}
LABELV $1306
line 2856
;2856:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1261
JUMPV
LABELV $1301
line 2859
;2857:			}
;2858:
;2859:			if (key == K_LEFTARROW || key == K_KP_LEFTARROW) {
ADDRLP4 1052
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 134
EQI4 $1310
ADDRLP4 1052
INDIRI4
CNSTI4 163
NEI4 $1308
LABELV $1310
line 2860
;2860:				if (item->cursorPos > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1311
line 2861
;2861:					item->cursorPos--;
ADDRLP4 1056
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
ASGNP4
ADDRLP4 1056
INDIRP4
ADDRLP4 1056
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2862
;2862:				}
LABELV $1311
line 2863
;2863:				if (item->cursorPos < editPtr->paintOffset) {
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
GEI4 $1313
line 2864
;2864:					editPtr->paintOffset--;
ADDRLP4 1056
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 1056
INDIRP4
ADDRLP4 1056
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2865
;2865:				}
LABELV $1313
line 2866
;2866:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1261
JUMPV
LABELV $1308
line 2869
;2867:			}
;2868:
;2869:			if (key == K_HOME || key == K_KP_HOME) {// || ( tolower(key) == 'a' && trap_Key_IsDown( K_CTRL ) ) ) {
ADDRLP4 1056
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 143
EQI4 $1317
ADDRLP4 1056
INDIRI4
CNSTI4 160
NEI4 $1315
LABELV $1317
line 2870
;2870:				item->cursorPos = 0;
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
CNSTI4 0
ASGNI4
line 2871
;2871:				editPtr->paintOffset = 0;
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 2872
;2872:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1261
JUMPV
LABELV $1315
line 2875
;2873:			}
;2874:
;2875:			if (key == K_END || key == K_KP_END) {// ( tolower(key) == 'e' && trap_Key_IsDown( K_CTRL ) ) ) {
ADDRLP4 1060
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 144
EQI4 $1320
ADDRLP4 1060
INDIRI4
CNSTI4 166
NEI4 $1318
LABELV $1320
line 2876
;2876:				item->cursorPos = len;
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
ADDRLP4 1032
INDIRI4
ASGNI4
line 2877
;2877:				if (item->cursorPos > editPtr->maxPaintChars) {
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
LEI4 $1321
line 2878
;2878:					editPtr->paintOffset = len - editPtr->maxPaintChars;
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 1032
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
SUBI4
ASGNI4
line 2879
;2879:				}
LABELV $1321
line 2880
;2880:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1261
JUMPV
LABELV $1318
line 2883
;2881:			}
;2882:
;2883:			if (key == K_INS || key == K_KP_INS) {
ADDRLP4 1064
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 139
EQI4 $1325
ADDRLP4 1064
INDIRI4
CNSTI4 170
NEI4 $1323
LABELV $1325
line 2884
;2884:				DC->setOverstrikeMode(!DC->getOverstrikeMode());
ADDRLP4 1072
ADDRGP4 DC
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $1327
ADDRLP4 1068
CNSTI4 1
ASGNI4
ADDRGP4 $1328
JUMPV
LABELV $1327
ADDRLP4 1068
CNSTI4 0
ASGNI4
LABELV $1328
ADDRLP4 1068
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 108
ADDP4
INDIRP4
CALLV
pop
line 2885
;2885:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1261
JUMPV
LABELV $1323
line 2887
;2886:			}
;2887:		}
LABELV $1267
line 2889
;2888:
;2889:		if (key == K_TAB || key == K_DOWNARROW || key == K_KP_DOWNARROW) {
ADDRLP4 1044
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 9
EQI4 $1332
ADDRLP4 1044
INDIRI4
CNSTI4 133
EQI4 $1332
ADDRLP4 1044
INDIRI4
CNSTI4 167
NEI4 $1329
LABELV $1332
line 2890
;2890:			newItem = Menu_SetNextCursorItem(item->parent);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 1048
ADDRGP4 Menu_SetNextCursorItem
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1048
INDIRP4
ASGNP4
line 2891
;2891:			if (newItem && (newItem->type == ITEM_TYPE_EDITFIELD || newItem->type == ITEM_TYPE_NUMERICFIELD)) {
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1333
ADDRLP4 1028
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 4
EQI4 $1335
ADDRLP4 1028
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 9
NEI4 $1333
LABELV $1335
line 2892
;2892:				g_editItem = newItem;
ADDRGP4 g_editItem
ADDRLP4 1028
INDIRP4
ASGNP4
line 2893
;2893:			}
LABELV $1333
line 2894
;2894:		}
LABELV $1329
line 2896
;2895:
;2896:		if (key == K_UPARROW || key == K_KP_UPARROW) {
ADDRLP4 1048
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 132
EQI4 $1338
ADDRLP4 1048
INDIRI4
CNSTI4 161
NEI4 $1336
LABELV $1338
line 2897
;2897:			newItem = Menu_SetPrevCursorItem(item->parent);
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRLP4 1052
ADDRGP4 Menu_SetPrevCursorItem
CALLP4
ASGNP4
ADDRLP4 1028
ADDRLP4 1052
INDIRP4
ASGNP4
line 2898
;2898:			if (newItem && (newItem->type == ITEM_TYPE_EDITFIELD || newItem->type == ITEM_TYPE_NUMERICFIELD)) {
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1339
ADDRLP4 1028
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 4
EQI4 $1341
ADDRLP4 1028
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 9
NEI4 $1339
LABELV $1341
line 2899
;2899:				g_editItem = newItem;
ADDRGP4 g_editItem
ADDRLP4 1028
INDIRP4
ASGNP4
line 2900
;2900:			}
LABELV $1339
line 2901
;2901:		}
LABELV $1336
line 2903
;2902:
;2903:		if (key == K_ENTER || key == K_KP_ENTER || key == K_ESCAPE) {
ADDRLP4 1052
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 13
EQI4 $1345
ADDRLP4 1052
INDIRI4
CNSTI4 169
EQI4 $1345
ADDRLP4 1052
INDIRI4
CNSTI4 27
NEI4 $1342
LABELV $1345
line 2904
;2904:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1261
JUMPV
LABELV $1342
line 2907
;2905:		}
;2906:
;2907:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1261
JUMPV
LABELV $1262
line 2909
;2908:	}
;2909:	return qfalse;
CNSTI4 0
RETI4
LABELV $1261
endproc Item_TextField_HandleKey 1076 12
proc Scroll_ListBox_AutoFunc 12 16
line 2913
;2910:
;2911:}
;2912:
;2913:static void Scroll_ListBox_AutoFunc(void *p) {
line 2914
;2914:	scrollInfo_t *si = (scrollInfo_t *)p;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 2915
;2915:	if (DC->realTime > si->nextScrollTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
LEI4 $1347
line 2919
;2916:		// need to scroll which is done by simulating a click to the item
;2917:		// this is done a bit sideways as the autoscroll "knows" that the item is a listbox
;2918:		// so it calls it directly
;2919:		Item_ListBox_HandleKey(si->item, si->scrollKey, qtrue, qfalse);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Item_ListBox_HandleKey
CALLI4
pop
line 2920
;2920:		si->nextScrollTime = DC->realTime + si->adjustValue;
ADDRLP4 0
INDIRP4
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDI4
ASGNI4
line 2921
;2921:	}
LABELV $1347
line 2923
;2922:
;2923:	if (DC->realTime > si->nextAdjustTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LEI4 $1349
line 2924
;2924:		si->nextAdjustTime = DC->realTime + SCROLL_TIME_ADJUST;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 150
ADDI4
ASGNI4
line 2925
;2925:		if (si->adjustValue > SCROLL_TIME_FLOOR) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 20
LEI4 $1351
line 2926
;2926:			si->adjustValue -= SCROLL_TIME_ADJUSTOFFSET;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 40
SUBI4
ASGNI4
line 2927
;2927:		}
LABELV $1351
line 2928
;2928:	}
LABELV $1349
line 2929
;2929:}
LABELV $1346
endproc Scroll_ListBox_AutoFunc 12 16
proc Scroll_ListBox_ThumbFunc 56 16
line 2931
;2930:
;2931:static void Scroll_ListBox_ThumbFunc(void *p) {
line 2932
;2932:	scrollInfo_t *si = (scrollInfo_t *)p;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 2938
;2933:	rectDef_t r;
;2934:	int pos, max;
;2935:
;2936:	//Com_Printf("listbox thumbfunc...\n");
;2937:
;2938:	listBoxDef_t *listPtr = (listBoxDef_t *)si->item->typeData;
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 2939
;2939:	if (si->item->window.flags & WINDOW_HORIZONTAL) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1354
line 2940
;2940:		if (CursorX_Widescreen(si->item->widescreen) == si->xStart) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 CursorX_Widescreen
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
NEF4 $1356
line 2941
;2941:			return;
ADDRGP4 $1353
JUMPV
LABELV $1356
line 2943
;2942:		}
;2943:		r.x = si->item->window.rect.x + SCROLLBAR_SIZE + 1;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2944
;2944:		r.y = si->item->window.rect.y + si->item->window.rect.h - SCROLLBAR_SIZE - 1;
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 2945
;2945:		r.h = SCROLLBAR_SIZE;
ADDRLP4 4+12
CNSTF4 1098907648
ASGNF4
line 2946
;2946:		r.w = si->item->window.rect.w - (SCROLLBAR_SIZE * 2) - 2;
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 2947
;2947:		max = Item_ListBox_MaxScroll(si->item);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 Item_ListBox_MaxScroll
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 40
INDIRI4
ASGNI4
line 2949
;2948:		//
;2949:		pos = (CursorX_Widescreen(si->item->widescreen) - r.x - SCROLLBAR_SIZE / 2) * max / (r.w - SCROLLBAR_SIZE);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 CursorX_Widescreen
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 44
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
CNSTF4 1090519040
SUBF4
ADDRLP4 24
INDIRI4
CVIF4 4
MULF4
ADDRLP4 4+8
INDIRF4
CNSTF4 1098907648
SUBF4
DIVF4
CVFI4 4
ASGNI4
line 2950
;2950:		if (pos < 0) {
ADDRLP4 20
INDIRI4
CNSTI4 0
GEI4 $1362
line 2951
;2951:			pos = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 2952
;2952:		} else if (pos > max) {
ADDRGP4 $1363
JUMPV
LABELV $1362
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $1364
line 2953
;2953:			pos = max;
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 2954
;2954:		}
LABELV $1364
LABELV $1363
line 2955
;2955:		listPtr->startPos = pos;
ADDRLP4 28
INDIRP4
ADDRLP4 20
INDIRI4
ASGNI4
line 2956
;2956:		si->xStart = CursorX_Widescreen(si->item->widescreen);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 CursorX_Widescreen
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 52
INDIRF4
ASGNF4
line 2957
;2957:	} else if (DC->cursory != si->yStart) {
ADDRGP4 $1355
JUMPV
LABELV $1354
ADDRGP4 DC
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
EQF4 $1366
line 2959
;2958:
;2959:		r.x = si->item->window.rect.x + si->item->window.rect.w - SCROLLBAR_SIZE - 1;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 2960
;2960:		r.y = si->item->window.rect.y + SCROLLBAR_SIZE + 1;
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 2961
;2961:		r.h = si->item->window.rect.h - (SCROLLBAR_SIZE * 2) - 2;
ADDRLP4 4+12
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 2962
;2962:		r.w = SCROLLBAR_SIZE;
ADDRLP4 4+8
CNSTF4 1098907648
ASGNF4
line 2963
;2963:		max = Item_ListBox_MaxScroll(si->item);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 Item_ListBox_MaxScroll
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 36
INDIRI4
ASGNI4
line 2965
;2964:		//
;2965:		pos = (DC->cursory - r.y - SCROLLBAR_SIZE / 2) * max / (r.h - SCROLLBAR_SIZE);
ADDRLP4 20
ADDRGP4 DC
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 4+4
INDIRF4
SUBF4
CNSTF4 1090519040
SUBF4
ADDRLP4 24
INDIRI4
CVIF4 4
MULF4
ADDRLP4 4+12
INDIRF4
CNSTF4 1098907648
SUBF4
DIVF4
CVFI4 4
ASGNI4
line 2966
;2966:		if (pos < 0) {
ADDRLP4 20
INDIRI4
CNSTI4 0
GEI4 $1373
line 2967
;2967:			pos = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 2968
;2968:		} else if (pos > max) {
ADDRGP4 $1374
JUMPV
LABELV $1373
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $1375
line 2969
;2969:			pos = max;
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 2970
;2970:		}
LABELV $1375
LABELV $1374
line 2971
;2971:		listPtr->startPos = pos;
ADDRLP4 28
INDIRP4
ADDRLP4 20
INDIRI4
ASGNI4
line 2972
;2972:		si->yStart = DC->cursory;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2973
;2973:	}
LABELV $1366
LABELV $1355
line 2975
;2974:
;2975:	if (DC->realTime > si->nextScrollTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
LEI4 $1377
line 2979
;2976:		// need to scroll which is done by simulating a click to the item
;2977:		// this is done a bit sideways as the autoscroll "knows" that the item is a listbox
;2978:		// so it calls it directly
;2979:		Item_ListBox_HandleKey(si->item, si->scrollKey, qtrue, qfalse);
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 Item_ListBox_HandleKey
CALLI4
pop
line 2980
;2980:		si->nextScrollTime = DC->realTime + si->adjustValue;
ADDRLP4 0
INDIRP4
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDI4
ASGNI4
line 2981
;2981:	}
LABELV $1377
line 2983
;2982:
;2983:	if (DC->realTime > si->nextAdjustTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LEI4 $1379
line 2984
;2984:		si->nextAdjustTime = DC->realTime + SCROLL_TIME_ADJUST;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 150
ADDI4
ASGNI4
line 2985
;2985:		if (si->adjustValue > SCROLL_TIME_FLOOR) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 20
LEI4 $1381
line 2986
;2986:			si->adjustValue -= SCROLL_TIME_ADJUSTOFFSET;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 40
SUBI4
ASGNI4
line 2987
;2987:		}
LABELV $1381
line 2988
;2988:	}
LABELV $1379
line 2989
;2989:}
LABELV $1353
endproc Scroll_ListBox_ThumbFunc 56 16
proc Scroll_Slider_ThumbFunc 32 8
line 2991
;2990:
;2991:static void Scroll_Slider_ThumbFunc(void *p) {
line 2993
;2992:	float x, value, cursorx;
;2993:	scrollInfo_t *si = (scrollInfo_t *)p;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 2994
;2994:	editFieldDef_t *editDef = si->item->typeData;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 2998
;2995:
;2996:	//Com_Printf("slider thumb func\n");
;2997:
;2998:	if (si->item->text) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1384
line 2999
;2999:		x = si->item->textRect.x + si->item->textRect.w + 8;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 3000
;3000:	} else {
ADDRGP4 $1385
JUMPV
LABELV $1384
line 3001
;3001:		x = si->item->window.rect.x;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
INDIRF4
ASGNF4
line 3002
;3002:	}
LABELV $1385
line 3004
;3003:
;3004:	cursorx = CursorX_Widescreen(si->item->widescreen);  //DC->cursorx;
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 CursorX_Widescreen
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 20
INDIRF4
ASGNF4
line 3007
;3005:	//cursorx = DC->cursorx;
;3006:
;3007:	if (cursorx < x) {
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
GEF4 $1386
line 3008
;3008:		cursorx = x;
ADDRLP4 12
ADDRLP4 8
INDIRF4
ASGNF4
line 3009
;3009:	} else if (cursorx > x + SLIDER_WIDTH) {
ADDRGP4 $1387
JUMPV
LABELV $1386
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
CNSTF4 1119879168
ADDF4
LEF4 $1388
line 3010
;3010:		cursorx = x + SLIDER_WIDTH;
ADDRLP4 12
ADDRLP4 8
INDIRF4
CNSTF4 1119879168
ADDF4
ASGNF4
line 3011
;3011:	}
LABELV $1388
LABELV $1387
line 3012
;3012:	value = cursorx - x;
ADDRLP4 4
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
ASGNF4
line 3013
;3013:	value /= SLIDER_WIDTH;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1009429163
MULF4
ASGNF4
line 3014
;3014:	value *= (editDef->maxVal - editDef->minVal);
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
INDIRF4
SUBF4
MULF4
ASGNF4
line 3015
;3015:	value += editDef->minVal;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 16
INDIRP4
INDIRF4
ADDF4
ASGNF4
line 3019
;3016:
;3017:	//Com_Printf("^5slider thumbfunc %f\n", value);
;3018:
;3019:	DC->setCVar(si->item->cvar, va("%f", value));
ADDRGP4 $1260
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 3020
;3020:}
LABELV $1383
endproc Scroll_Slider_ThumbFunc 32 8
proc Item_StartCapture 24 12
line 3022
;3021:
;3022:static void Item_StartCapture(itemDef_t *item, int key) {
line 3024
;3023:	int flags;
;3024:	switch (item->type) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
LTI4 $1391
ADDRLP4 4
INDIRI4
CNSTI4 10
GTI4 $1422
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1423-16
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1423
address $1394
address $1391
address $1394
address $1391
address $1391
address $1394
address $1414
code
LABELV $1422
ADDRLP4 4
INDIRI4
CNSTI4 14
EQI4 $1412
ADDRGP4 $1391
JUMPV
LABELV $1394
line 3029
;3025:	case ITEM_TYPE_EDITFIELD:
;3026:	case ITEM_TYPE_NUMERICFIELD:
;3027:
;3028:	case ITEM_TYPE_LISTBOX:
;3029:	{
line 3030
;3030:		flags = Item_ListBox_OverLB(item, DC->cursorx, DC->cursory);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
ADDRGP4 Item_ListBox_OverLB
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 16
INDIRI4
ASGNI4
line 3031
;3031:		if (flags & (WINDOW_LB_LEFTARROW | WINDOW_LB_RIGHTARROW)) {
ADDRLP4 0
INDIRI4
CNSTI4 6144
BANDI4
CNSTI4 0
EQI4 $1395
line 3032
;3032:			scrollInfo.nextScrollTime = DC->realTime + SCROLL_TIME_START;
ADDRGP4 scrollInfo
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 3033
;3033:			scrollInfo.nextAdjustTime = DC->realTime + SCROLL_TIME_ADJUST;
ADDRGP4 scrollInfo+4
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 150
ADDI4
ASGNI4
line 3034
;3034:			scrollInfo.adjustValue = SCROLL_TIME_START;
ADDRGP4 scrollInfo+8
CNSTI4 500
ASGNI4
line 3035
;3035:			scrollInfo.scrollKey = key;
ADDRGP4 scrollInfo+12
ADDRFP4 4
INDIRI4
ASGNI4
line 3036
;3036:			scrollInfo.scrollDir = (flags & WINDOW_LB_LEFTARROW) ? qtrue : qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1402
ADDRLP4 20
CNSTI4 1
ASGNI4
ADDRGP4 $1403
JUMPV
LABELV $1402
ADDRLP4 20
CNSTI4 0
ASGNI4
LABELV $1403
ADDRGP4 scrollInfo+28
ADDRLP4 20
INDIRI4
ASGNI4
line 3037
;3037:			scrollInfo.item = item;
ADDRGP4 scrollInfo+24
ADDRFP4 0
INDIRP4
ASGNP4
line 3038
;3038:			captureData = &scrollInfo;
ADDRGP4 captureData
ADDRGP4 scrollInfo
ASGNP4
line 3039
;3039:			captureFunc = &Scroll_ListBox_AutoFunc;
ADDRGP4 captureFunc
ADDRGP4 Scroll_ListBox_AutoFunc
ASGNP4
line 3040
;3040:			itemCapture = item;
ADDRGP4 itemCapture
ADDRFP4 0
INDIRP4
ASGNP4
line 3042
;3041:			//Com_Printf("got listbox autofunc %p\n", captureFunc);
;3042:		} else if (flags & WINDOW_LB_THUMB) {
ADDRGP4 $1392
JUMPV
LABELV $1395
ADDRLP4 0
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1392
line 3043
;3043:			scrollInfo.scrollKey = key;
ADDRGP4 scrollInfo+12
ADDRFP4 4
INDIRI4
ASGNI4
line 3044
;3044:			scrollInfo.item = item;
ADDRGP4 scrollInfo+24
ADDRFP4 0
INDIRP4
ASGNP4
line 3045
;3045:			scrollInfo.xStart = CursorX_Widescreen(scrollInfo.item->widescreen);  //DC->cursorx;
ADDRGP4 scrollInfo+24
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 CursorX_Widescreen
CALLF4
ASGNF4
ADDRGP4 scrollInfo+16
ADDRLP4 20
INDIRF4
ASGNF4
line 3046
;3046:			scrollInfo.yStart = DC->cursory;
ADDRGP4 scrollInfo+20
ADDRGP4 DC
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 3047
;3047:			captureData = &scrollInfo;
ADDRGP4 captureData
ADDRGP4 scrollInfo
ASGNP4
line 3048
;3048:			captureFunc = &Scroll_ListBox_ThumbFunc;
ADDRGP4 captureFunc
ADDRGP4 Scroll_ListBox_ThumbFunc
ASGNP4
line 3049
;3049:			itemCapture = item;
ADDRGP4 itemCapture
ADDRFP4 0
INDIRP4
ASGNP4
line 3051
;3050:			//Com_Printf("got listbox thumbfunc %p\n", captureFunc);
;3051:		}
line 3052
;3052:		break;
ADDRGP4 $1392
JUMPV
LABELV $1412
line 3055
;3053:	}
;3054:	case ITEM_TYPE_SLIDER_COLOR:
;3055:		Com_Printf("FIXME Item_StartCapture() ITEM_TYPE_SLIDER_COLOR\n");
ADDRGP4 $1413
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
LABELV $1414
line 3057
;3056:	case ITEM_TYPE_SLIDER:
;3057:	{
line 3059
;3058:		//Com_Printf("slider start capture\n");
;3059:		flags = Item_Slider_OverSlider(item, DC->cursorx, DC->cursory);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
ADDRGP4 Item_Slider_OverSlider
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 16
INDIRI4
ASGNI4
line 3061
;3060:		//Com_Printf("flags: %d\n", flags);
;3061:		if (flags & WINDOW_LB_THUMB) {
ADDRLP4 0
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1392
line 3062
;3062:			scrollInfo.scrollKey = key;
ADDRGP4 scrollInfo+12
ADDRFP4 4
INDIRI4
ASGNI4
line 3063
;3063:			scrollInfo.item = item;
ADDRGP4 scrollInfo+24
ADDRFP4 0
INDIRP4
ASGNP4
line 3064
;3064:			scrollInfo.xStart = CursorX_Widescreen(scrollInfo.item->widescreen);  //DC->cursorx;
ADDRGP4 scrollInfo+24
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 CursorX_Widescreen
CALLF4
ASGNF4
ADDRGP4 scrollInfo+16
ADDRLP4 20
INDIRF4
ASGNF4
line 3065
;3065:			scrollInfo.yStart = DC->cursory;
ADDRGP4 scrollInfo+20
ADDRGP4 DC
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 3066
;3066:			captureData = &scrollInfo;
ADDRGP4 captureData
ADDRGP4 scrollInfo
ASGNP4
line 3067
;3067:			captureFunc = &Scroll_Slider_ThumbFunc;
ADDRGP4 captureFunc
ADDRGP4 Scroll_Slider_ThumbFunc
ASGNP4
line 3068
;3068:			itemCapture = item;
ADDRGP4 itemCapture
ADDRFP4 0
INDIRP4
ASGNP4
line 3070
;3069:			//Com_Printf("got slider thumb %p\n", captureFunc);
;3070:		}
line 3071
;3071:		break;
LABELV $1391
LABELV $1392
line 3074
;3072:	}
;3073:	}
;3074:}
LABELV $1390
endproc Item_StartCapture 24 12
proc Item_StopCapture 0 0
line 3076
;3075:
;3076:static void Item_StopCapture(itemDef_t *item) {
line 3078
;3077:
;3078:}
LABELV $1425
endproc Item_StopCapture 0 0
proc Item_Slider_HandleKey 72 16
line 3080
;3079:
;3080:static qboolean Item_Slider_HandleKey(itemDef_t *item, int key, qboolean down) {
line 3084
;3081:	float x, value, width, work;
;3082:
;3083:	//DC->Print("slider handle key\n");
;3084:	if (item->cvar) {
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1427
line 3085
;3085:		if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_MOUSE3) {
ADDRLP4 16
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 178
EQI4 $1432
ADDRLP4 16
INDIRI4
CNSTI4 179
EQI4 $1432
ADDRLP4 16
INDIRI4
CNSTI4 180
NEI4 $1429
LABELV $1432
line 3086
;3086:			editFieldDef_t *editDef = item->typeData;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 3087
;3087:			if (editDef && Rect_ContainsWidescreenPoint(&item->window.rect, DC->cursorx, DC->cursory, item->widescreen) && item->window.flags & WINDOW_HASFOCUS) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1430
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $1430
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1430
line 3089
;3088:				rectDef_t testRect;
;3089:				width = SLIDER_WIDTH;
ADDRLP4 8
CNSTF4 1119879168
ASGNF4
line 3090
;3090:				if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1435
line 3091
;3091:					x = item->textRect.x + item->textRect.w + 8;
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 52
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 3092
;3092:				} else {
ADDRGP4 $1436
JUMPV
LABELV $1435
line 3093
;3093:					x = item->window.rect.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 3094
;3094:				}
LABELV $1436
line 3096
;3095:
;3096:				testRect = item->window.rect;
ADDRLP4 36
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 16
line 3097
;3097:				testRect.x = x;
ADDRLP4 36
ADDRLP4 4
INDIRF4
ASGNF4
line 3098
;3098:				value = (float)SLIDER_THUMB_WIDTH / 2;
ADDRLP4 0
CNSTF4 1086324736
ASGNF4
line 3099
;3099:				testRect.x -= value;
ADDRLP4 36
ADDRLP4 36
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
line 3101
;3100:				//DC->Print("slider x: %f\n", testRect.x);
;3101:				testRect.w = (SLIDER_WIDTH + (float)SLIDER_THUMB_WIDTH / 2);
ADDRLP4 36+8
CNSTF4 1120665600
ASGNF4
line 3103
;3102:				//DC->Print("slider w: %f\n", testRect.w);
;3103:				if (Rect_ContainsWidescreenPoint(&testRect, DC->cursorx, DC->cursory, item->widescreen)) {
ADDRLP4 36
ARGP4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $1430
line 3104
;3104:					work = CursorX_Widescreen(item->widescreen) - x;
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 CursorX_Widescreen
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 60
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 3107
;3105:					//Com_Printf("x: %d  wsx: %f\n", DC->cursorx, CursorX_Widescreen(item->widescreen));
;3106:					//Com_Printf("rescaled:  %f\n", CursorX_Widescreen(item->widescreen) / (DC->glconfig.vidWidth / (float)SCREEN_WIDTH));
;3107:					value = work / width;
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
ASGNF4
line 3108
;3108:					value *= (editDef->maxVal - editDef->minVal);
ADDRLP4 64
ADDRLP4 20
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
INDIRF4
SUBF4
MULF4
ASGNF4
line 3111
;3109:					// vm fuckage
;3110:					// value = (((float)(DC->cursorx - x)/ SLIDER_WIDTH) * (editDef->maxVal - editDef->minVal));
;3111:					value += editDef->minVal;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRP4
INDIRF4
ADDF4
ASGNF4
line 3113
;3112:					//Com_Printf("slider setting value %f\n", value);
;3113:					DC->setCVar(item->cvar, va("%f", value));
ADDRGP4 $1260
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 3114
;3114:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1426
JUMPV
line 3116
;3115:				}
;3116:			}
line 3117
;3117:		} else {
LABELV $1429
line 3118
;3118:			int select = UI_SelectForKey(key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 UI_SelectForKey
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 3119
;3119:			if (select != 0) {
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $1440
line 3120
;3120:				editFieldDef_t *editDef = item->typeData;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 3121
;3121:				if (editDef) {
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1442
line 3123
;3122:					// 20 is number of steps
;3123:					value = DC->getCVarValue(item->cvar) + (((editDef->maxVal - editDef->minVal) / 20) * select);
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 36
ADDRLP4 28
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
INDIRF4
SUBF4
CNSTF4 1028443341
MULF4
ADDRLP4 20
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 3124
;3124:					if (value < editDef->minVal)
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRP4
INDIRF4
GEF4 $1444
line 3125
;3125:						value = editDef->minVal;
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRF4
ASGNF4
ADDRGP4 $1445
JUMPV
LABELV $1444
line 3126
;3126:					else if (value > editDef->maxVal)
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
LEF4 $1446
line 3127
;3127:						value = editDef->maxVal;
ADDRLP4 0
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
LABELV $1446
LABELV $1445
line 3129
;3128:
;3129:					DC->setCVar(item->cvar, va("%f", value));
ADDRGP4 $1260
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 3130
;3130:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1426
JUMPV
LABELV $1442
line 3132
;3131:				}
;3132:			}
LABELV $1440
line 3133
;3133:		}
LABELV $1430
line 3134
;3134:	}
LABELV $1427
line 3137
;3135:
;3136:	//DC->Print("slider handle key exit\n");
;3137:	return qfalse;
CNSTI4 0
RETI4
LABELV $1426
endproc Item_Slider_HandleKey 72 16
proc Item_HandleKey 32 16
line 3141
;3138:}
;3139:
;3140:
;3141:static qboolean Item_HandleKey(itemDef_t *item, int key, qboolean down) {
line 3143
;3142:
;3143:	if (itemCapture) {
ADDRGP4 itemCapture
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1449
line 3144
;3144:		Item_StopCapture(itemCapture);
ADDRGP4 itemCapture
INDIRP4
ARGP4
ADDRGP4 Item_StopCapture
CALLV
pop
line 3145
;3145:		itemCapture = NULL;
ADDRGP4 itemCapture
CNSTP4 0
ASGNP4
line 3146
;3146:		captureFunc = 0;
ADDRGP4 captureFunc
CNSTP4 0
ASGNP4
line 3147
;3147:		captureData = NULL;
ADDRGP4 captureData
CNSTP4 0
ASGNP4
line 3149
;3148:		//Com_Printf("^2stop capture\n");
;3149:	} else {
ADDRGP4 $1450
JUMPV
LABELV $1449
line 3150
;3150:		if (down && (key == K_MOUSE1 || key == K_MOUSE2 || key == K_MOUSE3)) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1451
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1454
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1454
ADDRLP4 0
INDIRI4
CNSTI4 180
NEI4 $1451
LABELV $1454
line 3151
;3151:			Item_StartCapture(item, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 Item_StartCapture
CALLV
pop
line 3152
;3152:		}
LABELV $1451
line 3153
;3153:	}
LABELV $1450
line 3155
;3154:
;3155:	if (!down) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $1455
line 3156
;3156:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1448
JUMPV
LABELV $1455
line 3159
;3157:	}
;3158:
;3159:	switch (item->type) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $1457
ADDRLP4 0
INDIRI4
CNSTI4 14
GTI4 $1457
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1473-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1473
address $1460
address $1461
address $1462
address $1463
address $1464
address $1465
address $1457
address $1468
address $1463
address $1472
address $1466
address $1467
address $1469
address $1470
code
LABELV $1460
line 3161
;3160:	case ITEM_TYPE_BUTTON:
;3161:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1448
JUMPV
line 3162
;3162:		break;
LABELV $1461
line 3164
;3163:	case ITEM_TYPE_RADIOBUTTON:
;3164:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1448
JUMPV
line 3165
;3165:		break;
LABELV $1462
line 3167
;3166:	case ITEM_TYPE_CHECKBOX:
;3167:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1448
JUMPV
line 3168
;3168:		break;
LABELV $1463
line 3172
;3169:	case ITEM_TYPE_EDITFIELD:
;3170:	case ITEM_TYPE_NUMERICFIELD:
;3171:		//return Item_TextField_HandleKey(item, key);
;3172:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1448
JUMPV
line 3173
;3173:		break;
LABELV $1464
line 3175
;3174:	case ITEM_TYPE_COMBO:
;3175:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1448
JUMPV
line 3176
;3176:		break;
LABELV $1465
line 3178
;3177:	case ITEM_TYPE_LISTBOX:
;3178:		return Item_ListBox_HandleKey(item, key, down, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 Item_ListBox_HandleKey
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $1448
JUMPV
line 3179
;3179:		break;
LABELV $1466
line 3181
;3180:	case ITEM_TYPE_YESNO:
;3181:		return Item_YesNo_HandleKey(item, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 Item_YesNo_HandleKey
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $1448
JUMPV
line 3182
;3182:		break;
LABELV $1467
line 3184
;3183:	case ITEM_TYPE_MULTI:
;3184:		return Item_Multi_HandleKey(item, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 Item_Multi_HandleKey
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
RETI4
ADDRGP4 $1448
JUMPV
line 3185
;3185:		break;
LABELV $1468
line 3187
;3186:	case ITEM_TYPE_OWNERDRAW:
;3187:		return Item_OwnerDraw_HandleKey(item, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 Item_OwnerDraw_HandleKey
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $1448
JUMPV
line 3188
;3188:		break;
LABELV $1469
line 3190
;3189:	case ITEM_TYPE_BIND:
;3190:		return Item_Bind_HandleKey(item, key, down);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 Item_Bind_HandleKey
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
RETI4
ADDRGP4 $1448
JUMPV
line 3191
;3191:		break;
LABELV $1470
line 3193
;3192:	case ITEM_TYPE_SLIDER_COLOR:
;3193:		Com_Printf("FIXME Item_HandleKey()  ITEM_TYPE_SLIDER_COLOR\n");
ADDRGP4 $1471
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
LABELV $1472
line 3195
;3194:	case ITEM_TYPE_SLIDER:
;3195:		return Item_Slider_HandleKey(item, key, down);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 Item_Slider_HandleKey
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
RETI4
ADDRGP4 $1448
JUMPV
line 3196
;3196:		break;
LABELV $1457
line 3201
;3197:		//case ITEM_TYPE_IMAGE:
;3198:		//  Item_Image_Paint(item);
;3199:		//  break;
;3200:	default:
;3201:		return qfalse;
CNSTI4 0
RETI4
line 3202
;3202:		break;
LABELV $1448
endproc Item_HandleKey 32 16
proc Item_Action 4 8
line 3208
;3203:	}
;3204:
;3205:	//return qfalse;
;3206:}
;3207:
;3208:static void Item_Action(itemDef_t *item) {
line 3209
;3209:	if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1476
line 3210
;3210:		Item_RunScript(item, item->action);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 3211
;3211:	}
LABELV $1476
line 3212
;3212:}
LABELV $1475
endproc Item_Action 4 8
proc Menu_SetPrevCursorItem 32 12
line 3214
;3213:
;3214:static itemDef_t *Menu_SetPrevCursorItem(menuDef_t *menu) {
line 3215
;3215:	qboolean wrapped = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 3216
;3216:	int oldCursor = menu->cursorItem;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
line 3218
;3217:
;3218:	if (menu->cursorItem < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1482
line 3219
;3219:		menu->cursorItem = menu->itemCount - 1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 204
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3220
;3220:		wrapped = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 3221
;3221:	}
ADDRGP4 $1482
JUMPV
LABELV $1481
line 3223
;3222:
;3223:	while (menu->cursorItem > -1) {
line 3225
;3224:
;3225:		menu->cursorItem--;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3226
;3226:		if (menu->cursorItem < 0 && !wrapped) {
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1484
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1484
line 3227
;3227:			wrapped = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 3228
;3228:			menu->cursorItem = menu->itemCount - 1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 204
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3229
;3229:		}
LABELV $1484
line 3231
;3230:
;3231:		if (Item_SetFocus(menu->items[menu->cursorItem], DC->cursorx, DC->cursory)) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
ADDRGP4 Item_SetFocus
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $1486
line 3232
;3232:			Menu_HandleMouseMove(menu, menu->items[menu->cursorItem]->window.rect.x + 1, menu->items[menu->cursorItem]->window.rect.y + 1);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRGP4 Menu_HandleMouseMove
CALLV
pop
line 3233
;3233:			return menu->items[menu->cursorItem];
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $1478
JUMPV
LABELV $1486
line 3235
;3234:		}
;3235:	}
LABELV $1482
line 3223
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 -1
GTI4 $1481
line 3236
;3236:	menu->cursorItem = oldCursor;
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 3237
;3237:	return NULL;
CNSTP4 0
RETP4
LABELV $1478
endproc Menu_SetPrevCursorItem 32 12
proc Menu_SetNextCursorItem 36 12
line 3241
;3238:
;3239:}
;3240:
;3241:static itemDef_t *Menu_SetNextCursorItem(menuDef_t *menu) {
line 3243
;3242:
;3243:	qboolean wrapped = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 3244
;3244:	int oldCursor = menu->cursorItem;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
line 3247
;3245:
;3246:
;3247:	if (menu->cursorItem == -1) {
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1492
line 3248
;3248:		menu->cursorItem = 0;
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 0
ASGNI4
line 3249
;3249:		wrapped = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 3250
;3250:	}
ADDRGP4 $1492
JUMPV
LABELV $1491
line 3252
;3251:
;3252:	while (menu->cursorItem < menu->itemCount) {
line 3254
;3253:
;3254:		menu->cursorItem++;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3255
;3255:		if (menu->cursorItem >= menu->itemCount && !wrapped) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
LTI4 $1494
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1494
line 3256
;3256:			wrapped = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 3257
;3257:			menu->cursorItem = 0;
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 0
ASGNI4
line 3258
;3258:		}
LABELV $1494
line 3259
;3259:		if (Item_SetFocus(menu->items[menu->cursorItem], DC->cursorx, DC->cursory)) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
ADDRGP4 Item_SetFocus
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1496
line 3260
;3260:			Menu_HandleMouseMove(menu, menu->items[menu->cursorItem]->window.rect.x + 1, menu->items[menu->cursorItem]->window.rect.y + 1);
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRGP4 Menu_HandleMouseMove
CALLV
pop
line 3261
;3261:			return menu->items[menu->cursorItem];
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $1488
JUMPV
LABELV $1496
line 3264
;3262:		}
;3263:
;3264:	}
LABELV $1492
line 3252
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
LTI4 $1491
line 3266
;3265:
;3266:	menu->cursorItem = oldCursor;
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 3267
;3267:	return NULL;
CNSTP4 0
RETP4
LABELV $1488
endproc Menu_SetNextCursorItem 36 12
proc Window_CloseCinematic 4 4
line 3270
;3268:}
;3269:
;3270:static void Window_CloseCinematic(windowDef_t *window) {
line 3271
;3271:	if (window->style == WINDOW_STYLE_CINEMATIC && window->cinematic >= 0) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1499
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LTI4 $1499
line 3272
;3272:		DC->stopCinematic(window->cinematic);
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 188
ADDP4
INDIRP4
CALLV
pop
line 3273
;3273:		window->cinematic = -1;
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 -1
ASGNI4
line 3274
;3274:	}
LABELV $1499
line 3275
;3275:}
LABELV $1498
endproc Window_CloseCinematic 4 4
proc Menu_CloseCinematics 4 4
line 3277
;3276:
;3277:static void Menu_CloseCinematics(menuDef_t *menu) {
line 3278
;3278:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1502
line 3280
;3279:		int i;
;3280:		Window_CloseCinematic(&menu->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_CloseCinematic
CALLV
pop
line 3281
;3281:		for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1507
JUMPV
LABELV $1504
line 3282
;3282:			Window_CloseCinematic(&menu->items[i]->window);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Window_CloseCinematic
CALLV
pop
line 3283
;3283:			if (menu->items[i]->type == ITEM_TYPE_OWNERDRAW) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1508
line 3284
;3284:				DC->stopCinematic(0 - menu->items[i]->window.ownerDraw);
CNSTI4 0
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
SUBI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 188
ADDP4
INDIRP4
CALLV
pop
line 3285
;3285:			}
LABELV $1508
line 3286
;3286:		}
LABELV $1505
line 3281
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1507
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
LTI4 $1504
line 3287
;3287:	}
LABELV $1502
line 3288
;3288:}
LABELV $1501
endproc Menu_CloseCinematics 4 4
proc Display_CloseCinematics 4 4
line 3290
;3289:
;3290:static void Display_CloseCinematics(void) {
line 3292
;3291:	int i;
;3292:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1514
JUMPV
LABELV $1511
line 3293
;3293:		Menu_CloseCinematics(&Menus[i]);
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRGP4 Menu_CloseCinematics
CALLV
pop
line 3294
;3294:	}
LABELV $1512
line 3292
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1514
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1511
line 3295
;3295:}
LABELV $1510
endproc Display_CloseCinematics 4 4
export Menus_Activate
proc Menus_Activate 584 8
line 3297
;3296:
;3297:void  Menus_Activate(menuDef_t *menu) {
line 3298
;3298:	menu->window.flags |= (WINDOW_HASFOCUS | WINDOW_VISIBLE);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 6
BORI4
ASGNI4
line 3299
;3299:	if (menu->onOpen) {
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1516
line 3301
;3300:		itemDef_t item;
;3301:		item.parent = menu;
ADDRLP4 4+240
ADDRFP4 0
INDIRP4
ASGNP4
line 3303
;3302:		//Com_Printf("^5onOpen\n");
;3303:		Item_RunScript(&item, menu->onOpen);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 3304
;3304:	}
LABELV $1516
line 3306
;3305:
;3306:	if (menu->soundName && *menu->soundName) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 232
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1519
ADDRLP4 4
INDIRP4
CNSTI4 232
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1519
line 3308
;3307:		//		DC->stopBackgroundTrack();					// you don't want to do this since it will reset s_rawend
;3308:		DC->startBackgroundTrack(menu->soundName, menu->soundName);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 232
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 232
ADDP4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 176
ADDP4
INDIRP4
CALLV
pop
line 3309
;3309:	}
LABELV $1519
line 3311
;3310:
;3311:	Display_CloseCinematics();
ADDRGP4 Display_CloseCinematics
CALLV
pop
line 3313
;3312:
;3313:}
LABELV $1515
endproc Menus_Activate 584 8
proc Display_VisibleMenuCount 8 0
line 3315
;3314:
;3315:static int Display_VisibleMenuCount(void) {
line 3317
;3316:	int i, count;
;3317:	count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3318
;3318:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1525
JUMPV
LABELV $1522
line 3319
;3319:		if (Menus[i].window.flags & (WINDOW_FORCED | WINDOW_VISIBLE)) {
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus+72
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
EQI4 $1526
line 3320
;3320:			count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3321
;3321:		}
LABELV $1526
line 3322
;3322:	}
LABELV $1523
line 3318
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1525
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1522
line 3323
;3323:	return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $1521
endproc Display_VisibleMenuCount 8 0
proc Menus_HandleOOBClick 20 12
line 3326
;3324:}
;3325:
;3326:static void Menus_HandleOOBClick(menuDef_t *menu, int key, qboolean down) {
line 3327
;3327:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1530
line 3332
;3328:		int i;
;3329:		// basically the behaviour we are looking for is if there are windows in the stack.. see if 
;3330:		// the cursor is within any of them.. if not close them otherwise activate them and pass the 
;3331:		// key on.. force a mouse move to activate focus and script stuff 
;3332:		if (down && menu->window.flags & WINDOW_OOB_CLICK) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1532
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $1532
line 3333
;3333:			Menu_RunCloseScript(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_RunCloseScript
CALLV
pop
line 3334
;3334:			menu->window.flags &= ~(WINDOW_HASFOCUS | WINDOW_VISIBLE);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -7
BANDI4
ASGNI4
line 3335
;3335:		}
LABELV $1532
line 3337
;3336:
;3337:		for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1537
JUMPV
LABELV $1534
line 3338
;3338:			if (Menu_OverActiveItem(&Menus[i], DC->cursorx, DC->cursory)) {
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
ADDRGP4 Menu_OverActiveItem
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1538
line 3339
;3339:				Menu_RunCloseScript(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_RunCloseScript
CALLV
pop
line 3340
;3340:				menu->window.flags &= ~(WINDOW_HASFOCUS | WINDOW_VISIBLE);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 -7
BANDI4
ASGNI4
line 3341
;3341:				Menus_Activate(&Menus[i]);
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRGP4 Menus_Activate
CALLV
pop
line 3342
;3342:				Menu_HandleMouseMove(&Menus[i], DC->cursorx, DC->cursory);
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 Menu_HandleMouseMove
CALLV
pop
line 3343
;3343:				Menu_HandleKey(&Menus[i], key, down);
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Menu_HandleKey
CALLV
pop
line 3344
;3344:			}
LABELV $1538
line 3345
;3345:		}
LABELV $1535
line 3337
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1537
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1534
line 3347
;3346:
;3347:		if (Display_VisibleMenuCount() == 0) {
ADDRLP4 4
ADDRGP4 Display_VisibleMenuCount
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1540
line 3348
;3348:			if (DC->Pause) {
ADDRGP4 DC
INDIRP4
CNSTI4 164
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1542
line 3349
;3349:				DC->Pause(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 164
ADDP4
INDIRP4
CALLV
pop
line 3350
;3350:			}
LABELV $1542
line 3351
;3351:		}
LABELV $1540
line 3352
;3352:		Display_CloseCinematics();
ADDRGP4 Display_CloseCinematics
CALLV
pop
line 3353
;3353:	}
LABELV $1530
line 3354
;3354:}
LABELV $1529
endproc Menus_HandleOOBClick 20 12
bss
align 4
LABELV $1545
skip 16
code
proc Item_CorrectedTextRect 4 12
line 3356
;3355:
;3356:static rectDef_t *Item_CorrectedTextRect(itemDef_t *item) {
line 3358
;3357:	static rectDef_t rect;
;3358:	memset(&rect, 0, sizeof(rectDef_t));
ADDRGP4 $1545
ARGP4
CNSTI4 0
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3359
;3359:	if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1546
line 3360
;3360:		rect = item->textRect;
ADDRGP4 $1545
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRB
ASGNB 16
line 3361
;3361:		if (rect.w) {
ADDRGP4 $1545+8
INDIRF4
CNSTF4 0
EQF4 $1548
line 3362
;3362:			rect.y -= rect.h;
ADDRLP4 0
ADDRGP4 $1545+4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRGP4 $1545+12
INDIRF4
SUBF4
ASGNF4
line 3363
;3363:		}
LABELV $1548
line 3364
;3364:	}
LABELV $1546
line 3365
;3365:	return &rect;
ADDRGP4 $1545
RETP4
LABELV $1544
endproc Item_CorrectedTextRect 4 12
export UI_SelectForKey
proc UI_SelectForKey 20 0
line 3369
;3366:}
;3367:
;3368:// menu item key horizontal action: -1 = previous value, 1 = next value, 0 = no change
;3369:int UI_SelectForKey(int key) {
line 3370
;3370:	switch (key) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 163
EQI4 $1557
ADDRLP4 0
INDIRI4
CNSTI4 165
EQI4 $1556
ADDRLP4 0
INDIRI4
CNSTI4 165
GTI4 $1559
LABELV $1558
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 13
EQI4 $1556
ADDRLP4 4
INDIRI4
CNSTI4 13
LTI4 $1554
LABELV $1560
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 134
EQI4 $1557
ADDRLP4 8
INDIRI4
CNSTI4 135
EQI4 $1556
ADDRGP4 $1554
JUMPV
LABELV $1559
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 169
EQI4 $1556
ADDRLP4 12
INDIRI4
CNSTI4 169
LTI4 $1554
LABELV $1561
ADDRLP4 16
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 178
LTI4 $1554
ADDRLP4 16
INDIRI4
CNSTI4 188
GTI4 $1554
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1562-712
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1562
address $1556
address $1557
address $1556
address $1554
address $1554
address $1554
address $1554
address $1556
address $1556
address $1556
address $1556
code
LABELV $1556
line 3381
;3371:	case K_MOUSE1:
;3372:	case K_MOUSE3:
;3373:	case K_ENTER:
;3374:	case K_KP_ENTER:
;3375:	case K_RIGHTARROW:
;3376:	case K_KP_RIGHTARROW:
;3377:	case K_JOY1:
;3378:	case K_JOY2:
;3379:	case K_JOY3:
;3380:	case K_JOY4:
;3381:		return 1; // next
CNSTI4 1
RETI4
ADDRGP4 $1553
JUMPV
LABELV $1557
line 3385
;3382:	case K_MOUSE2:
;3383:	case K_LEFTARROW:
;3384:	case K_KP_LEFTARROW:
;3385:		return -1; // previous
CNSTI4 -1
RETI4
ADDRGP4 $1553
JUMPV
LABELV $1554
line 3389
;3386:	}
;3387:
;3388:	// no change
;3389:	return 0;
CNSTI4 0
RETI4
LABELV $1553
endproc UI_SelectForKey 20 0
data
align 4
LABELV $1565
byte 4 0
align 4
LABELV $1586
byte 4 0
export Menu_HandleKey
code
proc Menu_HandleKey 40 16
line 3394
;3390:}
;3391:
;3392:
;3393://FIXME UTF-8
;3394:void Menu_HandleKey(menuDef_t *menu, int key, qboolean down) {
line 3396
;3395:	//int i;
;3396:	itemDef_t *item = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 3405
;3397:	static qboolean inHandler = qfalse;
;3398:
;3399:#if 0
;3400:	if (down) {
;3401:		Com_Printf("Menu_HandleKey() %p 0x%x %d\n", menu, key, down);
;3402:	}
;3403:#endif
;3404:
;3405:	if (inHandler) {
ADDRGP4 $1565
INDIRI4
CNSTI4 0
EQI4 $1566
line 3406
;3406:		return;
ADDRGP4 $1564
JUMPV
LABELV $1566
line 3409
;3407:	}
;3408:
;3409:	inHandler = qtrue;
ADDRGP4 $1565
CNSTI4 1
ASGNI4
line 3410
;3410:	if (g_waitingForKey && down) {
ADDRGP4 g_waitingForKey
INDIRI4
CNSTI4 0
EQI4 $1568
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1568
line 3411
;3411:		Item_Bind_HandleKey(g_bindItem, key, down);
ADDRGP4 g_bindItem
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Item_Bind_HandleKey
CALLI4
pop
line 3412
;3412:		inHandler = qfalse;
ADDRGP4 $1565
CNSTI4 0
ASGNI4
line 3413
;3413:		return;
ADDRGP4 $1564
JUMPV
LABELV $1568
line 3416
;3414:	}
;3415:
;3416:	if (g_editingField && down) {
ADDRGP4 g_editingField
INDIRI4
CNSTI4 0
EQI4 $1570
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1570
line 3417
;3417:		if (!Item_TextField_HandleKey(g_editItem, key)) {
ADDRGP4 g_editItem
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 Item_TextField_HandleKey
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1572
line 3418
;3418:			g_editingField = qfalse;
ADDRGP4 g_editingField
CNSTI4 0
ASGNI4
line 3419
;3419:			g_editItem = NULL;
ADDRGP4 g_editItem
CNSTP4 0
ASGNP4
line 3420
;3420:			inHandler = qfalse;
ADDRGP4 $1565
CNSTI4 0
ASGNI4
line 3421
;3421:			return;
ADDRGP4 $1564
JUMPV
LABELV $1572
line 3422
;3422:		} else if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_MOUSE3) {
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 178
EQI4 $1577
ADDRLP4 8
INDIRI4
CNSTI4 179
EQI4 $1577
ADDRLP4 8
INDIRI4
CNSTI4 180
NEI4 $1574
LABELV $1577
line 3423
;3423:			g_editingField = qfalse;
ADDRGP4 g_editingField
CNSTI4 0
ASGNI4
line 3424
;3424:			g_editItem = NULL;
ADDRGP4 g_editItem
CNSTP4 0
ASGNP4
line 3425
;3425:			Display_MouseMove(NULL, DC->cursorx, DC->cursory);
CNSTP4 0
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRGP4 Display_MouseMove
CALLI4
pop
line 3426
;3426:		} else if (key == K_TAB || key == K_UPARROW || key == K_DOWNARROW) {
ADDRGP4 $1575
JUMPV
LABELV $1574
ADDRLP4 12
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 9
EQI4 $1581
ADDRLP4 12
INDIRI4
CNSTI4 132
EQI4 $1581
ADDRLP4 12
INDIRI4
CNSTI4 133
NEI4 $1578
LABELV $1581
line 3427
;3427:			return;
ADDRGP4 $1564
JUMPV
LABELV $1578
LABELV $1575
line 3429
;3428:		}
;3429:	}
LABELV $1570
line 3431
;3430:
;3431:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1582
line 3432
;3432:		inHandler = qfalse;
ADDRGP4 $1565
CNSTI4 0
ASGNI4
line 3433
;3433:		return;
ADDRGP4 $1564
JUMPV
LABELV $1582
line 3437
;3434:	}
;3435:
;3436:	// see if the mouse is within the window bounds and if so is this a mouse click
;3437:	if (down && !(menu->window.flags & WINDOW_POPUP) && !Rect_ContainsWidescreenPoint(&menu->window.rect, DC->cursorx, DC->cursory, menu->widescreen)) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1584
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2097152
BANDI4
CNSTI4 0
NEI4 $1584
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4364
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $1584
line 3439
;3438:		static qboolean inHandleKey = qfalse;
;3439:		if (!inHandleKey && (key == K_MOUSE1 || key == K_MOUSE2 || key == K_MOUSE3)) {
ADDRGP4 $1586
INDIRI4
CNSTI4 0
NEI4 $1587
ADDRLP4 16
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 178
EQI4 $1590
ADDRLP4 16
INDIRI4
CNSTI4 179
EQI4 $1590
ADDRLP4 16
INDIRI4
CNSTI4 180
NEI4 $1587
LABELV $1590
line 3440
;3440:			inHandleKey = qtrue;
ADDRGP4 $1586
CNSTI4 1
ASGNI4
line 3441
;3441:			Menus_HandleOOBClick(menu, key, down);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Menus_HandleOOBClick
CALLV
pop
line 3442
;3442:			inHandleKey = qfalse;
ADDRGP4 $1586
CNSTI4 0
ASGNI4
line 3443
;3443:			inHandler = qfalse;
ADDRGP4 $1565
CNSTI4 0
ASGNI4
line 3444
;3444:			return;
ADDRGP4 $1564
JUMPV
LABELV $1587
line 3446
;3445:		}
;3446:	}
LABELV $1584
line 3458
;3447:
;3448:#if 0
;3449:	// get the item with focus
;3450:	for (i = 0; i < menu->itemCount; i++) {
;3451:		if (menu->items[i]->window.flags & WINDOW_HASFOCUS) {
;3452:			item = menu->items[i];
;3453:		}
;3454:	}
;3455:#endif
;3456:
;3457:	//FIXME hack
;3458:	if (LastFocusItem && LastFocusItem->window.flags & WINDOW_HASFOCUS) {
ADDRLP4 16
ADDRGP4 LastFocusItem
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1591
ADDRLP4 16
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1591
line 3459
;3459:		item = LastFocusItem;
ADDRLP4 0
ADDRGP4 LastFocusItem
INDIRP4
ASGNP4
line 3460
;3460:	}
LABELV $1591
line 3464
;3461:
;3462:	//Com_Printf("item: %p  count == %d\n", item, menu->itemCount);
;3463:
;3464:	if (item != NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1593
line 3465
;3465:		if (Item_HandleKey(item, key, down)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 Item_HandleKey
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $1595
line 3466
;3466:			Item_Action(item);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Action
CALLV
pop
line 3467
;3467:			inHandler = qfalse;
ADDRGP4 $1565
CNSTI4 0
ASGNI4
line 3468
;3468:			return;
ADDRGP4 $1564
JUMPV
LABELV $1595
line 3470
;3469:		}
;3470:	}
LABELV $1593
line 3472
;3471:
;3472:	if (!down) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $1597
line 3473
;3473:		inHandler = qfalse;
ADDRGP4 $1565
CNSTI4 0
ASGNI4
line 3474
;3474:		return;
ADDRGP4 $1564
JUMPV
LABELV $1597
line 3485
;3475:	}
;3476:
;3477:	//Com_Printf("default handler item: %p\n", item);
;3478:
;3479:	// default handling
;3480:
;3481:	//FIXME
;3482:	//inHandler = qfalse;
;3483:	//return;
;3484:
;3485:	switch (key) {
ADDRLP4 20
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 178
EQI4 $1601
ADDRLP4 20
INDIRI4
CNSTI4 179
EQI4 $1601
ADDRGP4 $1599
JUMPV
LABELV $1601
line 3518
;3486:#if 0  //FIXME
;3487:	case K_F11:
;3488:		if (DC->getCVarValue("developer")) {
;3489:			debugMode ^= 1;
;3490:		}
;3491:		break;
;3492:
;3493:	case K_F12:
;3494:		if (DC->getCVarValue("developer")) {
;3495:			DC->executeText(EXEC_APPEND, "screenshot\n");
;3496:		}
;3497:		break;
;3498:	case K_KP_UPARROW:
;3499:	case K_UPARROW:
;3500:		Menu_SetPrevCursorItem(menu);
;3501:		break;
;3502:
;3503:	case K_ESCAPE:
;3504:		if (!g_waitingForKey && menu->onESC) {
;3505:			itemDef_t it;
;3506:			it.parent = menu;
;3507:			Item_RunScript(&it, menu->onESC);
;3508:		}
;3509:		break;
;3510:	case K_TAB:
;3511:	case K_KP_DOWNARROW:
;3512:	case K_DOWNARROW:
;3513:		Menu_SetNextCursorItem(menu);
;3514:		break;
;3515:#endif
;3516:	case K_MOUSE1:
;3517:	case K_MOUSE2:
;3518:		if (item) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1600
line 3519
;3519:			if (item->type == ITEM_TYPE_TEXT) {
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1604
line 3520
;3520:				if (Rect_ContainsWidescreenPoint(Item_CorrectedTextRect(item), DC->cursorx, DC->cursory, item->widescreen)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 Item_CorrectedTextRect
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $1600
line 3521
;3521:					Item_Action(item);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Action
CALLV
pop
line 3522
;3522:				}
line 3523
;3523:			} else if (item->type == ITEM_TYPE_EDITFIELD || item->type == ITEM_TYPE_NUMERICFIELD) {
ADDRGP4 $1600
JUMPV
LABELV $1604
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 4
EQI4 $1610
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 9
NEI4 $1608
LABELV $1610
line 3524
;3524:				if (Rect_ContainsWidescreenPoint(&item->window.rect, DC->cursorx, DC->cursory, item->widescreen)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $1600
line 3525
;3525:					item->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 564
ADDP4
CNSTI4 0
ASGNI4
line 3526
;3526:					g_editingField = qtrue;
ADDRGP4 g_editingField
CNSTI4 1
ASGNI4
line 3527
;3527:					g_editItem = item;
ADDRGP4 g_editItem
ADDRLP4 0
INDIRP4
ASGNP4
line 3528
;3528:				}
line 3529
;3529:			} else {
ADDRGP4 $1600
JUMPV
LABELV $1608
line 3530
;3530:				if (Rect_ContainsWidescreenPoint(&item->window.rect, DC->cursorx, DC->cursory, item->widescreen)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $1600
line 3531
;3531:					Item_Action(item);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Action
CALLV
pop
line 3532
;3532:				}
line 3533
;3533:			}
line 3534
;3534:		}
line 3535
;3535:		break;
LABELV $1599
LABELV $1600
line 3571
;3536:#if 0  //FIXME
;3537:	case K_JOY1:
;3538:	case K_JOY2:
;3539:	case K_JOY3:
;3540:	case K_JOY4:
;3541:	case K_AUX1:
;3542:	case K_AUX2:
;3543:	case K_AUX3:
;3544:	case K_AUX4:
;3545:	case K_AUX5:
;3546:	case K_AUX6:
;3547:	case K_AUX7:
;3548:	case K_AUX8:
;3549:	case K_AUX9:
;3550:	case K_AUX10:
;3551:	case K_AUX11:
;3552:	case K_AUX12:
;3553:	case K_AUX13:
;3554:	case K_AUX14:
;3555:	case K_AUX15:
;3556:	case K_AUX16:
;3557:	case K_KP_ENTER:
;3558:	case K_ENTER:
;3559:		if (item) {
;3560:			if (item->type == ITEM_TYPE_EDITFIELD || item->type == ITEM_TYPE_NUMERICFIELD) {
;3561:				item->cursorPos = 0;
;3562:				g_editingField = qtrue;
;3563:				g_editItem = item;
;3564:			} else {
;3565:				Item_Action(item);
;3566:			}
;3567:		}
;3568:		break;
;3569:#endif
;3570:	}
;3571:	inHandler = qfalse;
ADDRGP4 $1565
CNSTI4 0
ASGNI4
line 3572
;3572:}
LABELV $1564
endproc Menu_HandleKey 40 16
proc ToWindowCoords 8 0
line 3574
;3573:
;3574:static void ToWindowCoords(float *x, float *y, windowDef_t *window) {
line 3575
;3575:	if (window->border != 0) {
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1616
line 3576
;3576:		*x += window->borderSize;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3577
;3577:		*y += window->borderSize;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3578
;3578:	}
LABELV $1616
line 3579
;3579:	*x += window->rect.x;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
INDIRF4
ADDF4
ASGNF4
line 3580
;3580:	*y += window->rect.y;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3581
;3581:}
LABELV $1615
endproc ToWindowCoords 8 0
proc Item_SetTextExtents 312 20
line 3590
;3582:
;3583:// unused
;3584:#if 0
;3585:static void Rect_ToWindowCoords(rectDef_t *rect, windowDef_t *window) {
;3586:	ToWindowCoords(&rect->x, &rect->y, window);
;3587:}
;3588:#endif
;3589:
;3590:static void Item_SetTextExtents(itemDef_t *item, float *width, float *height, const char *text) {
line 3591
;3591:	const char *textPtr = (text) ? text : item->text;
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1620
ADDRLP4 20
ADDRFP4 12
INDIRP4
ASGNP4
ADDRGP4 $1621
JUMPV
LABELV $1620
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
ASGNP4
LABELV $1621
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 3594
;3592:	rectDef_t menuRect;
;3593:
;3594:	if (item->parent) {
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1622
line 3595
;3595:		menuRect = ((menuDef_t *)item->parent)->window.rect;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
INDIRB
ASGNB 16
line 3596
;3596:	}
LABELV $1622
line 3598
;3597:
;3598:	if (textPtr == NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1624
line 3599
;3599:		return;
ADDRGP4 $1618
JUMPV
LABELV $1624
line 3602
;3600:	}
;3601:
;3602:	*width = item->textRect.w;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ASGNF4
line 3603
;3603:	*height = item->textRect.h;
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRF4
ASGNF4
line 3606
;3604:
;3605:	// keeps us from computing the widths and heights more than once
;3606:	if (*width == 0 || (item->type == ITEM_TYPE_OWNERDRAW && item->textalignment == ITEM_ALIGN_CENTER)) {
ADDRFP4 4
INDIRP4
INDIRF4
CNSTF4 0
EQF4 $1628
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1626
ADDRLP4 24
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1626
LABELV $1628
line 3608
;3607:		//FIXME widescreen?  -- 2018-07-12 cgame textWidth() takes widescreen into account
;3608:		float originalWidth = DC->textWidth(item->text, item->textscale, 0, item->fontIndex, item->widescreen); //, menuRect);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 32
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 32
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 36
INDIRF4
ASGNF4
line 3610
;3609:
;3610:		if (item->type == ITEM_TYPE_OWNERDRAW && (item->textalignment == ITEM_ALIGN_CENTER || item->textalignment == ITEM_ALIGN_RIGHT)) {
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1629
ADDRLP4 40
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 1
EQI4 $1631
ADDRLP4 40
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1629
LABELV $1631
line 3611
;3611:			originalWidth += DC->ownerDrawWidth(item->window.ownerDraw, item->textscale, item->fontIndex, item->widescreen); //, menuRect);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 DC
INDIRP4
CNSTI4 168
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 48
INDIRF4
ADDF4
ASGNF4
line 3612
;3612:		} else if (item->type == ITEM_TYPE_EDITFIELD && item->textalignment == ITEM_ALIGN_CENTER && item->cvar) {
ADDRGP4 $1630
JUMPV
LABELV $1629
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1632
ADDRLP4 44
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1632
ADDRLP4 44
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1632
line 3614
;3613:			char buff[256];
;3614:			DC->getCVarString(item->cvar, buff, 256);
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 48
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 3615
;3615:			originalWidth += DC->textWidth(buff, item->textscale, 0, item->fontIndex, item->widescreen); //, menuRect);
ADDRLP4 48
ARGP4
ADDRLP4 304
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 304
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 304
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 304
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 308
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 308
INDIRF4
ADDF4
ASGNF4
line 3616
;3616:		}
LABELV $1632
LABELV $1630
line 3618
;3617:
;3618:		*width = DC->textWidth(textPtr, item->textscale, 0, item->fontIndex, item->widescreen); //, menuRect);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 48
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
ADDRLP4 52
INDIRF4
ASGNF4
line 3619
;3619:		*height = DC->textHeight(textPtr, item->textscale, 0, item->fontIndex, item->widescreen); //, menuRect);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 DC
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRFP4 8
INDIRP4
ADDRLP4 60
INDIRF4
ASGNF4
line 3620
;3620:		item->textRect.w = *width;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRFP4 4
INDIRP4
INDIRF4
ASGNF4
line 3621
;3621:		item->textRect.h = *height;
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
ASGNF4
line 3622
;3622:		item->textRect.x = item->textalignx;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 188
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ASGNF4
line 3623
;3623:		item->textRect.y = item->textaligny;
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 192
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ASGNF4
line 3624
;3624:		if (item->textalignment == ITEM_ALIGN_RIGHT) {
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1634
line 3625
;3625:			item->textRect.x = item->textalignx - originalWidth;
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 188
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
SUBF4
ASGNF4
line 3626
;3626:		} else if (item->textalignment == ITEM_ALIGN_CENTER) {
ADDRGP4 $1635
JUMPV
LABELV $1634
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1636
line 3627
;3627:			item->textRect.x = item->textalignx - originalWidth / 2;
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 188
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
CNSTF4 1056964608
MULF4
SUBF4
ASGNF4
line 3628
;3628:		}
LABELV $1636
LABELV $1635
line 3630
;3629:
;3630:		ToWindowCoords(&item->textRect.x, &item->textRect.y, &item->window);
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 188
ADDP4
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRGP4 ToWindowCoords
CALLV
pop
line 3631
;3631:	}
LABELV $1626
line 3632
;3632:}
LABELV $1618
endproc Item_SetTextExtents 312 20
proc Item_TextColor 40 28
line 3634
;3633:
;3634:static void Item_TextColor(itemDef_t *item, vec4_t *newColor) {
line 3636
;3635:	vec4_t lowLight;
;3636:	menuDef_t *parent = (menuDef_t *)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 3638
;3637:
;3638:	Fade(&item->window.flags, &item->window.foreColor[3], parent->fadeClamp, &item->window.nextTime, parent->fadeCycle, qtrue, parent->fadeAmount);
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 72
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRGP4 Fade
CALLV
pop
line 3640
;3639:
;3640:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1639
line 3641
;3641:		lowLight[0] = 0.8 * parent->focusColor[0];
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3642
;3642:		lowLight[1] = 0.8 * parent->focusColor[1];
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3643
;3643:		lowLight[2] = 0.8 * parent->focusColor[2];
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3644
;3644:		lowLight[3] = 0.8 * parent->focusColor[3];
ADDRLP4 4+12
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3645
;3645:		LerpColor(parent->focusColor, lowLight, *newColor, 0.5 + 0.5 * sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 28
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3646
;3646:	} else if (item->textStyle == ITEM_TEXTSTYLE_BLINK && !((DC->realTime / BLINK_DIVISOR) & 1)) {
ADDRGP4 $1640
JUMPV
LABELV $1639
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1644
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 200
DIVI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $1644
line 3647
;3647:		lowLight[0] = 0.8 * item->window.foreColor[0];
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3648
;3648:		lowLight[1] = 0.8 * item->window.foreColor[1];
ADDRLP4 4+4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3649
;3649:		lowLight[2] = 0.8 * item->window.foreColor[2];
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3650
;3650:		lowLight[3] = 0.8 * item->window.foreColor[3];
ADDRLP4 4+12
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3651
;3651:		LerpColor(item->window.foreColor, lowLight, *newColor, 0.5 + 0.5 * sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 28
ADDRGP4 sin
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3652
;3652:	} else {
ADDRGP4 $1645
JUMPV
LABELV $1644
line 3653
;3653:		memcpy(newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3655
;3654:		// items can be enabled and disabled based on cvars
;3655:	}
LABELV $1645
LABELV $1640
line 3657
;3656:
;3657:	if (item->enableCvar && *item->enableCvar && item->cvarTest && *item->cvarTest) {
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 292
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1649
ADDRLP4 28
INDIRP4
CNSTI4 292
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1649
ADDRLP4 28
INDIRP4
CNSTI4 288
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1649
ADDRLP4 28
INDIRP4
CNSTI4 288
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1649
line 3658
;3658:		if (item->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(item, CVAR_ENABLE)) {
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $1651
ADDRLP4 32
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 36
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $1651
line 3659
;3659:			memcpy(newColor, &parent->disableColor, sizeof(vec4_t));
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 252
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3660
;3660:		}
LABELV $1651
line 3661
;3661:	}
LABELV $1649
line 3662
;3662:}
LABELV $1638
endproc Item_TextColor 40 28
proc Item_Text_AutoWrapped_Paint 2156 40
line 3664
;3663:
;3664:static void Item_Text_AutoWrapped_Paint(itemDef_t *item) {
line 3675
;3665:	char text[1024];
;3666:	const char *p, *textPtr, *newLinePtr;
;3667:	char buff[1024];
;3668:	int len, newLine;
;3669:	float width, height, newLineWidth;
;3670:	float textWidth;
;3671:	float y;
;3672:	vec4_t color;
;3673:	rectDef_t menuRect;
;3674:
;3675:	if (item->parent) {
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1654
line 3676
;3676:		menuRect = ((menuDef_t *)item->parent)->window.rect;
ADDRLP4 2104
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
INDIRB
ASGNB 16
line 3677
;3677:	}
LABELV $1654
line 3679
;3678:
;3679:	textWidth = 0;
ADDRLP4 1032
CNSTF4 0
ASGNF4
line 3680
;3680:	newLinePtr = NULL;
ADDRLP4 1044
CNSTP4 0
ASGNP4
line 3682
;3681:
;3682:	if (item->text == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1656
line 3683
;3683:		if (item->cvar == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1658
line 3684
;3684:			return;
ADDRGP4 $1653
JUMPV
LABELV $1658
line 3685
;3685:		} else {
line 3686
;3686:			DC->getCVarString(item->cvar, text, sizeof(text));
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 1080
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 3687
;3687:			textPtr = text;
ADDRLP4 1056
ADDRLP4 1080
ASGNP4
line 3688
;3688:		}
line 3689
;3689:	} else {
ADDRGP4 $1657
JUMPV
LABELV $1656
line 3690
;3690:		textPtr = item->text;
ADDRLP4 1056
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
ASGNP4
line 3691
;3691:	}
LABELV $1657
line 3692
;3692:	if (*textPtr == '\0') {
ADDRLP4 1056
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1660
line 3693
;3693:		return;
ADDRGP4 $1653
JUMPV
LABELV $1660
line 3695
;3694:	}
;3695:	Item_TextColor(item, &color);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1060
ARGP4
ADDRGP4 Item_TextColor
CALLV
pop
line 3696
;3696:	Item_SetTextExtents(item, &width, &height, textPtr);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1076
ARGP4
ADDRLP4 1052
ARGP4
ADDRLP4 1056
INDIRP4
ARGP4
ADDRGP4 Item_SetTextExtents
CALLV
pop
line 3698
;3697:
;3698:	y = item->textaligny;
ADDRLP4 1048
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ASGNF4
line 3699
;3699:	len = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3700
;3700:	buff[0] = '\0';
ADDRLP4 8
CNSTI1 0
ASGNI1
line 3701
;3701:	newLine = 0;
ADDRLP4 1036
CNSTI4 0
ASGNI4
line 3702
;3702:	newLineWidth = 0;
ADDRLP4 1040
CNSTF4 0
ASGNF4
line 3703
;3703:	p = textPtr;
ADDRLP4 0
ADDRLP4 1056
INDIRP4
ASGNP4
ADDRGP4 $1663
JUMPV
LABELV $1662
line 3704
;3704:	while (p) {
line 3709
;3705:		int numUtf8Bytes;
;3706:		qboolean error;
;3707:		int n;
;3708:
;3709:		if (*p == ' ' || *p == '\t' || *p == '\n' || *p == '\0') {
ADDRLP4 2132
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 2132
INDIRI4
CNSTI4 32
EQI4 $1669
ADDRLP4 2132
INDIRI4
CNSTI4 9
EQI4 $1669
ADDRLP4 2132
INDIRI4
CNSTI4 10
EQI4 $1669
ADDRLP4 2132
INDIRI4
CNSTI4 0
NEI4 $1665
LABELV $1669
line 3710
;3710:			newLine = len;
ADDRLP4 1036
ADDRLP4 4
INDIRI4
ASGNI4
line 3711
;3711:			newLinePtr = p + 1;
ADDRLP4 1044
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 3712
;3712:			newLineWidth = textWidth;
ADDRLP4 1040
ADDRLP4 1032
INDIRF4
ASGNF4
line 3713
;3713:		}
LABELV $1665
line 3714
;3714:		textWidth = DC->textWidth(buff, item->textscale, 0, item->fontIndex, item->widescreen); //, menuRect);
ADDRLP4 8
ARGP4
ADDRLP4 2136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2136
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 2136
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 2136
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 2140
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 1032
ADDRLP4 2140
INDIRF4
ASGNF4
line 3715
;3715:		if ((newLine && textWidth > item->window.rect.w) || *p == '\n' || *p == '\0') {
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $1673
ADDRLP4 1032
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
GTF4 $1674
LABELV $1673
ADDRLP4 2144
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 2144
INDIRI4
CNSTI4 10
EQI4 $1674
ADDRLP4 2144
INDIRI4
CNSTI4 0
NEI4 $1670
LABELV $1674
line 3716
;3716:			if (len) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1675
line 3717
;3717:				if (item->textalignment == ITEM_ALIGN_LEFT) {
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1677
line 3718
;3718:					item->textRect.x = item->textalignx;
ADDRLP4 2148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2148
INDIRP4
CNSTI4 188
ADDP4
ADDRLP4 2148
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ASGNF4
line 3719
;3719:				} else if (item->textalignment == ITEM_ALIGN_RIGHT) {
ADDRGP4 $1678
JUMPV
LABELV $1677
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1679
line 3720
;3720:					item->textRect.x = item->textalignx - newLineWidth;
ADDRLP4 2148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2148
INDIRP4
CNSTI4 188
ADDP4
ADDRLP4 2148
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ADDRLP4 1040
INDIRF4
SUBF4
ASGNF4
line 3721
;3721:				} else if (item->textalignment == ITEM_ALIGN_CENTER) {
ADDRGP4 $1680
JUMPV
LABELV $1679
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1681
line 3722
;3722:					item->textRect.x = item->textalignx - newLineWidth / 2;
ADDRLP4 2148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2148
INDIRP4
CNSTI4 188
ADDP4
ADDRLP4 2148
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ADDRLP4 1040
INDIRF4
CNSTF4 1056964608
MULF4
SUBF4
ASGNF4
line 3723
;3723:				}
LABELV $1681
LABELV $1680
LABELV $1678
line 3724
;3724:				item->textRect.y = y;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
ADDRLP4 1048
INDIRF4
ASGNF4
line 3725
;3725:				ToWindowCoords(&item->textRect.x, &item->textRect.y, &item->window);
ADDRLP4 2148
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2148
INDIRP4
CNSTI4 188
ADDP4
ARGP4
ADDRLP4 2148
INDIRP4
CNSTI4 192
ADDP4
ARGP4
ADDRLP4 2148
INDIRP4
ARGP4
ADDRGP4 ToWindowCoords
CALLV
pop
line 3727
;3726:				//
;3727:				buff[newLine] = '\0';
ADDRLP4 1036
INDIRI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 3728
;3728:				DC->drawText(item->textRect.x, item->textRect.y, item->textscale, color, buff, 0, 0, item->textStyle, item->fontIndex, item->widescreen); //, menuRect);
ADDRLP4 2152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2152
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ARGF4
ADDRLP4 2152
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
ARGF4
ADDRLP4 2152
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
ADDRLP4 1060
ARGP4
ADDRLP4 8
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 2152
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRLP4 2152
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 2152
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3729
;3729:			}
LABELV $1675
line 3730
;3730:			if (*p == '\0') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1683
line 3731
;3731:				break;
ADDRGP4 $1664
JUMPV
LABELV $1683
line 3734
;3732:			}
;3733:			//
;3734:			y += height + 5;
ADDRLP4 1048
ADDRLP4 1048
INDIRF4
ADDRLP4 1052
INDIRF4
CNSTF4 1084227584
ADDF4
ADDF4
ASGNF4
line 3735
;3735:			p = newLinePtr;
ADDRLP4 0
ADDRLP4 1044
INDIRP4
ASGNP4
line 3736
;3736:			len = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3737
;3737:			newLine = 0;
ADDRLP4 1036
CNSTI4 0
ASGNI4
line 3738
;3738:			newLineWidth = 0;
ADDRLP4 1040
CNSTF4 0
ASGNF4
line 3739
;3739:			continue;
ADDRGP4 $1663
JUMPV
LABELV $1670
line 3742
;3740:		}
;3741:
;3742:		Q_GetCpFromUtf8(p, &numUtf8Bytes, &error);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 2124
ARGP4
ADDRLP4 2128
ARGP4
ADDRGP4 Q_GetCpFromUtf8
CALLI4
pop
line 3743
;3743:		for (n = 0; n < numUtf8Bytes; n++) {
ADDRLP4 2120
CNSTI4 0
ASGNI4
ADDRGP4 $1688
JUMPV
LABELV $1685
line 3744
;3744:			buff[len + n] = p[n];
ADDRLP4 4
INDIRI4
ADDRLP4 2120
INDIRI4
ADDI4
ADDRLP4 8
ADDP4
ADDRLP4 2120
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 3745
;3745:		}
LABELV $1686
line 3743
ADDRLP4 2120
ADDRLP4 2120
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1688
ADDRLP4 2120
INDIRI4
ADDRLP4 2124
INDIRI4
LTI4 $1685
line 3746
;3746:		len += numUtf8Bytes;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 2124
INDIRI4
ADDI4
ASGNI4
line 3747
;3747:		p += numUtf8Bytes;
ADDRLP4 0
ADDRLP4 2124
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 3748
;3748:		buff[len] = '\0';
ADDRLP4 4
INDIRI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 3749
;3749:	}
LABELV $1663
line 3704
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1662
LABELV $1664
line 3750
;3750:}
LABELV $1653
endproc Item_Text_AutoWrapped_Paint 2156 40
proc Item_Text_Wrapped_Paint 2128 40
line 3752
;3751:
;3752:static void Item_Text_Wrapped_Paint(itemDef_t *item) {
line 3761
;3753:	char text[1024];
;3754:	const char *p, *start, *textPtr;
;3755:	char buff[1024];
;3756:	float width, height;
;3757:	float x, y;
;3758:	vec4_t color;
;3759:	rectDef_t menuRect;
;3760:
;3761:	if (item->parent) {
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1690
line 3762
;3762:		menuRect = ((menuDef_t *)item->parent)->window.rect;
ADDRLP4 2092
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
INDIRB
ASGNB 16
line 3763
;3763:	}
LABELV $1690
line 3767
;3764:	// now paint the text and/or any optional images
;3765:	// default to left
;3766:
;3767:	if (item->text == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1692
line 3768
;3768:		if (item->cvar == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1694
line 3769
;3769:			return;
ADDRGP4 $1689
JUMPV
LABELV $1694
line 3770
;3770:		} else {
line 3771
;3771:			DC->getCVarString(item->cvar, text, sizeof(text));
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 1068
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 3772
;3772:			textPtr = text;
ADDRLP4 1060
ADDRLP4 1068
ASGNP4
line 3773
;3773:		}
line 3774
;3774:	} else {
ADDRGP4 $1693
JUMPV
LABELV $1692
line 3775
;3775:		textPtr = item->text;
ADDRLP4 1060
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
ASGNP4
line 3776
;3776:	}
LABELV $1693
line 3777
;3777:	if (*textPtr == '\0') {
ADDRLP4 1060
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1696
line 3778
;3778:		return;
ADDRGP4 $1689
JUMPV
LABELV $1696
line 3781
;3779:	}
;3780:
;3781:	Item_TextColor(item, &color);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1040
ARGP4
ADDRGP4 Item_TextColor
CALLV
pop
line 3782
;3782:	Item_SetTextExtents(item, &width, &height, textPtr);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1064
ARGP4
ADDRLP4 1056
ARGP4
ADDRLP4 1060
INDIRP4
ARGP4
ADDRGP4 Item_SetTextExtents
CALLV
pop
line 3784
;3783:
;3784:	x = item->textRect.x;
ADDRLP4 1036
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ASGNF4
line 3785
;3785:	y = item->textRect.y;
ADDRLP4 1032
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
ASGNF4
line 3786
;3786:	start = textPtr;
ADDRLP4 4
ADDRLP4 1060
INDIRP4
ASGNP4
line 3787
;3787:	p = strchr(textPtr, '\r');
ADDRLP4 1060
INDIRP4
ARGP4
CNSTI4 13
ARGI4
ADDRLP4 2108
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2108
INDIRP4
ASGNP4
ADDRGP4 $1699
JUMPV
LABELV $1698
line 3788
;3788:	while (p && *p) {
line 3789
;3789:		strncpy(buff, start, p - start + 1);
ADDRLP4 8
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 3790
;3790:		buff[p - start] = '\0';
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 3791
;3791:		DC->drawText(x, y, item->textscale, color, buff, 0, 0, item->textStyle, item->fontIndex, item->widescreen); //, menuRect);
ADDRLP4 1036
INDIRF4
ARGF4
ADDRLP4 1032
INDIRF4
ARGF4
ADDRLP4 2116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2116
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
ADDRLP4 1040
ARGP4
ADDRLP4 8
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 2116
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRLP4 2116
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 2116
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3792
;3792:		y += height + 5;
ADDRLP4 1032
ADDRLP4 1032
INDIRF4
ADDRLP4 1056
INDIRF4
CNSTF4 1084227584
ADDF4
ADDF4
ASGNF4
line 3793
;3793:		start += p - start + 1;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 4
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 1
ADDI4
ADDRLP4 4
INDIRP4
ADDP4
ASGNP4
line 3794
;3794:		p = strchr(p + 1, '\r');
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ARGP4
CNSTI4 13
ARGI4
ADDRLP4 2124
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2124
INDIRP4
ASGNP4
line 3795
;3795:	}
LABELV $1699
line 3788
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1701
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1698
LABELV $1701
line 3796
;3796:	DC->drawText(x, y, item->textscale, color, start, 0, 0, item->textStyle, item->fontIndex, item->widescreen); //, menuRect);
ADDRLP4 1036
INDIRF4
ARGF4
ADDRLP4 1032
INDIRF4
ARGF4
ADDRLP4 2116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2116
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
ADDRLP4 1040
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 2116
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRLP4 2116
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 2116
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3797
;3797:}
LABELV $1689
endproc Item_Text_Wrapped_Paint 2128 40
proc Item_Text_Paint 1072 40
line 3799
;3798:
;3799:static void Item_Text_Paint(itemDef_t *item) {
line 3806
;3800:	char text[1024];
;3801:	const char *textPtr;
;3802:	float height, width;
;3803:	vec4_t color;
;3804:	rectDef_t menuRect;
;3805:
;3806:	if (item->parent) {
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1703
line 3807
;3807:		menuRect = ((menuDef_t *)item->parent)->window.rect;
ADDRLP4 1052
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
INDIRB
ASGNB 16
line 3808
;3808:	}
LABELV $1703
line 3809
;3809:	if (item->window.flags & WINDOW_WRAPPED) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 262144
BANDI4
CNSTI4 0
EQI4 $1705
line 3810
;3810:		Item_Text_Wrapped_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Wrapped_Paint
CALLV
pop
line 3811
;3811:		return;
ADDRGP4 $1702
JUMPV
LABELV $1705
line 3813
;3812:	}
;3813:	if (item->window.flags & WINDOW_AUTOWRAPPED) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 524288
BANDI4
CNSTI4 0
EQI4 $1707
line 3814
;3814:		Item_Text_AutoWrapped_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_AutoWrapped_Paint
CALLV
pop
line 3815
;3815:		return;
ADDRGP4 $1702
JUMPV
LABELV $1707
line 3818
;3816:	}
;3817:
;3818:	if (item->text == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1709
line 3819
;3819:		if (item->cvar == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1711
line 3820
;3820:			return;
ADDRGP4 $1702
JUMPV
LABELV $1711
line 3821
;3821:		} else {
line 3822
;3822:			DC->getCVarString(item->cvar, text, sizeof(text));
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 3823
;3823:			textPtr = text;
ADDRLP4 0
ADDRLP4 28
ASGNP4
line 3824
;3824:		}
line 3825
;3825:	} else {
ADDRGP4 $1710
JUMPV
LABELV $1709
line 3826
;3826:		textPtr = item->text;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
ASGNP4
line 3827
;3827:	}
LABELV $1710
line 3830
;3828:
;3829:	// this needs to go here as it sets extents for cvar types as well
;3830:	Item_SetTextExtents(item, &width, &height, textPtr);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Item_SetTextExtents
CALLV
pop
line 3832
;3831:
;3832:	if (*textPtr == '\0') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1713
line 3833
;3833:		return;
ADDRGP4 $1702
JUMPV
LABELV $1713
line 3837
;3834:	}
;3835:
;3836:
;3837:	Item_TextColor(item, &color);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Item_TextColor
CALLV
pop
line 3868
;3838:
;3839:	//FIXME: this is a fucking mess
;3840:/*
;3841:	adjust = 0;
;3842:	if (item->textStyle == ITEM_TEXTSTYLE_OUTLINED || item->textStyle == ITEM_TEXTSTYLE_OUTLINESHADOWED) {
;3843:		adjust = 0.5;
;3844:	}
;3845:
;3846:	if (item->textStyle == ITEM_TEXTSTYLE_SHADOWED || item->textStyle == ITEM_TEXTSTYLE_OUTLINESHADOWED) {
;3847:		Fade(&item->window.flags, &DC->Assets.shadowColor[3], DC->Assets.fadeClamp, &item->window.nextTime, DC->Assets.fadeCycle, qfalse);
;3848:		DC->drawText(item->textRect.x + DC->Assets.shadowX, item->textRect.y + DC->Assets.shadowY, item->textscale, DC->Assets.shadowColor, textPtr, adjust, item->fontIndex, item->widescreen);
;3849:	}
;3850:*/
;3851:
;3852:
;3853://	if (item->textStyle == ITEM_TEXTSTYLE_OUTLINED || item->textStyle == ITEM_TEXTSTYLE_OUTLINESHADOWED) {
;3854://		Fade(&item->window.flags, &item->window.outlineColor[3], DC->Assets.fadeClamp, &item->window.nextTime, DC->Assets.fadeCycle, qfalse);
;3855://		/*
;3856://		Text_Paint(item->textRect.x-1, item->textRect.y-1, item->textscale, item->window.foreColor, textPtr, adjust);
;3857://		Text_Paint(item->textRect.x, item->textRect.y-1, item->textscale, item->window.foreColor, textPtr, adjust);
;3858://		Text_Paint(item->textRect.x+1, item->textRect.y-1, item->textscale, item->window.foreColor, textPtr, adjust);
;3859://		Text_Paint(item->textRect.x-1, item->textRect.y, item->textscale, item->window.foreColor, textPtr, adjust);
;3860://		Text_Paint(item->textRect.x+1, item->textRect.y, item->textscale, item->window.foreColor, textPtr, adjust);
;3861://		Text_Paint(item->textRect.x-1, item->textRect.y+1, item->textscale, item->window.foreColor, textPtr, adjust);
;3862://		Text_Paint(item->textRect.x, item->textRect.y+1, item->textscale, item->window.foreColor, textPtr, adjust);
;3863://		Text_Paint(item->textRect.x+1, item->textRect.y+1, item->textscale, item->window.foreColor, textPtr, adjust);
;3864://		*/
;3865://		DC->drawText(item->textRect.x - 1, item->textRect.y + 1, item->textscale * 1.02, item->window.outlineColor, textPtr, adjust, item->fontIndex);
;3866://	}
;3867:
;3868:	DC->drawText(item->textRect.x, item->textRect.y, item->textscale, color, textPtr, 0, 0, item->textStyle, item->fontIndex, item->widescreen); //, menuRect);
ADDRLP4 1068
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1068
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ARGF4
ADDRLP4 1068
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
ARGF4
ADDRLP4 1068
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 1068
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRLP4 1068
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 1068
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3869
;3869:}
LABELV $1702
endproc Item_Text_Paint 1072 40
proc Item_TextField_Paint 1112 44
line 3876
;3870:
;3871:
;3872:
;3873://float			trap_Cvar_VariableValue( const char *var_name );
;3874://void			trap_Cvar_VariableStringBuffer( const char *var_name, char *buffer, int bufsize );
;3875:
;3876:static void Item_TextField_Paint(itemDef_t *item) {
line 3880
;3877:	char buff[1024];
;3878:	vec4_t newColor, lowLight;
;3879:	int offset;
;3880:	menuDef_t *parent = (menuDef_t *)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 3881
;3881:	editFieldDef_t *editPtr = (editFieldDef_t *)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 3884
;3882:	rectDef_t menuRect;
;3883:
;3884:	if (item->parent) {
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1716
line 3885
;3885:		menuRect = ((menuDef_t *)item->parent)->window.rect;
ADDRLP4 1068
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
INDIRB
ASGNB 16
line 3886
;3886:	}
LABELV $1716
line 3887
;3887:	Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3889
;3888:
;3889:	buff[0] = '\0';
ADDRLP4 8
CNSTI1 0
ASGNI1
line 3891
;3890:
;3891:	if (item->cvar) {
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1718
line 3892
;3892:		DC->getCVarString(item->cvar, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 3893
;3893:	}
LABELV $1718
line 3895
;3894:
;3895:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1720
line 3896
;3896:		lowLight[0] = 0.8 * parent->focusColor[0];
ADDRLP4 1032
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3897
;3897:		lowLight[1] = 0.8 * parent->focusColor[1];
ADDRLP4 1032+4
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3898
;3898:		lowLight[2] = 0.8 * parent->focusColor[2];
ADDRLP4 1032+8
ADDRLP4 0
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3899
;3899:		lowLight[3] = 0.8 * parent->focusColor[3];
ADDRLP4 1032+12
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3900
;3900:		LerpColor(parent->focusColor, lowLight, newColor, 0.5 + 0.5 * sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 1084
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
ARGP4
ADDRLP4 1032
ARGP4
ADDRLP4 1048
ARGP4
ADDRLP4 1084
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3901
;3901:	} else {
ADDRGP4 $1721
JUMPV
LABELV $1720
line 3902
;3902:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 1048
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3903
;3903:	}
LABELV $1721
line 3905
;3904:
;3905:	offset = (item->text && *item->text) ? 8 : 0;
ADDRLP4 1088
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1088
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1726
ADDRLP4 1088
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1726
ADDRLP4 1084
CNSTI4 8
ASGNI4
ADDRGP4 $1727
JUMPV
LABELV $1726
ADDRLP4 1084
CNSTI4 0
ASGNI4
LABELV $1727
ADDRLP4 1064
ADDRLP4 1084
INDIRI4
ASGNI4
line 3906
;3906:	if (item->window.flags & WINDOW_HASFOCUS && g_editingField) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1728
ADDRGP4 g_editingField
INDIRI4
CNSTI4 0
EQI4 $1728
line 3907
;3907:		char cursor = DC->getOverstrikeMode() ? '_' : '|';
ADDRLP4 1100
ADDRGP4 DC
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1100
INDIRI4
CNSTI4 0
EQI4 $1731
ADDRLP4 1096
CNSTI4 95
ASGNI4
ADDRGP4 $1732
JUMPV
LABELV $1731
ADDRLP4 1096
CNSTI4 124
ASGNI4
LABELV $1732
ADDRLP4 1092
ADDRLP4 1096
INDIRI4
CVII1 4
ASGNI1
line 3908
;3908:		DC->drawTextWithCursor(item->textRect.x + item->textRect.w + offset, item->textRect.y, item->textscale, newColor, buff + editPtr->paintOffset, item->cursorPos - editPtr->paintOffset, cursor, editPtr->maxPaintChars, item->textStyle, item->fontIndex, item->widescreen); //, menuRect);
ADDRLP4 1104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1104
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDRLP4 1104
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ADDF4
ADDRLP4 1064
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 1104
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
ARGF4
ADDRLP4 1104
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
ADDRLP4 1048
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ADDRLP4 8
ADDP4
ARGP4
ADDRLP4 1104
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
SUBI4
ARGI4
ADDRLP4 1092
INDIRI1
CVII4 1
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 1104
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRLP4 1104
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 1104
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 104
ADDP4
INDIRP4
CALLV
pop
line 3909
;3909:	} else {
ADDRGP4 $1729
JUMPV
LABELV $1728
line 3910
;3910:		DC->drawText(item->textRect.x + item->textRect.w + offset, item->textRect.y, item->textscale, newColor, buff + editPtr->paintOffset, 0, editPtr->maxPaintChars, item->textStyle, item->fontIndex, item->widescreen); //, menuRect);
ADDRLP4 1092
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1092
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDRLP4 1092
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ADDF4
ADDRLP4 1064
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 1092
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
ARGF4
ADDRLP4 1092
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
ADDRLP4 1048
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ADDRLP4 8
ADDP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 1092
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRLP4 1092
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 1092
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3911
;3911:	}
LABELV $1729
line 3913
;3912:
;3913:}
LABELV $1715
endproc Item_TextField_Paint 1112 44
proc Item_YesNo_Paint 76 40
line 3915
;3914:
;3915:static void Item_YesNo_Paint(itemDef_t *item) {
line 3918
;3916:	vec4_t newColor, lowLight;
;3917:	float value;
;3918:	menuDef_t *parent = (menuDef_t *)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 3921
;3919:	rectDef_t menuRect;
;3920:
;3921:	if (item->parent) {
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1734
line 3922
;3922:		menuRect = ((menuDef_t *)item->parent)->window.rect;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
INDIRB
ASGNB 16
line 3923
;3923:	}
LABELV $1734
line 3924
;3924:	value = (item->cvar) ? DC->getCVarValue(item->cvar) : 0;
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1737
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 56
ADDRLP4 60
INDIRF4
ASGNF4
ADDRGP4 $1738
JUMPV
LABELV $1737
ADDRLP4 56
CNSTF4 0
ASGNF4
LABELV $1738
ADDRLP4 36
ADDRLP4 56
INDIRF4
ASGNF4
line 3926
;3925:
;3926:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1739
line 3927
;3927:		lowLight[0] = 0.8 * parent->focusColor[0];
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3928
;3928:		lowLight[1] = 0.8 * parent->focusColor[1];
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3929
;3929:		lowLight[2] = 0.8 * parent->focusColor[2];
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3930
;3930:		lowLight[3] = 0.8 * parent->focusColor[3];
ADDRLP4 4+12
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3931
;3931:		LerpColor(parent->focusColor, lowLight, newColor, 0.5 + 0.5 * sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 64
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 64
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3932
;3932:	} else {
ADDRGP4 $1740
JUMPV
LABELV $1739
line 3933
;3933:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 20
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3934
;3934:	}
LABELV $1740
line 3936
;3935:
;3936:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1744
line 3937
;3937:		Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3938
;3938:		DC->drawText(item->textRect.x + item->textRect.w + 8, item->textRect.y, item->textscale, newColor, (value != 0) ? "Yes" : "No", 0, 0, item->textStyle, item->fontIndex, item->widescreen); //, menuRect);
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDRLP4 68
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRLP4 68
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
ARGF4
ADDRLP4 68
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
ARGP4
ADDRLP4 36
INDIRF4
CNSTF4 0
EQF4 $1749
ADDRLP4 64
ADDRGP4 $1746
ASGNP4
ADDRGP4 $1750
JUMPV
LABELV $1749
ADDRLP4 64
ADDRGP4 $1747
ASGNP4
LABELV $1750
ADDRLP4 64
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3939
;3939:	} else {
ADDRGP4 $1745
JUMPV
LABELV $1744
line 3940
;3940:		DC->drawText(item->textRect.x, item->textRect.y, item->textscale, newColor, (value != 0) ? "Yes" : "No", 0, 0, item->textStyle, item->fontIndex, item->widescreen); //, menuRect);
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ARGF4
ADDRLP4 68
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
ARGF4
ADDRLP4 68
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
ARGP4
ADDRLP4 36
INDIRF4
CNSTF4 0
EQF4 $1752
ADDRLP4 64
ADDRGP4 $1746
ASGNP4
ADDRGP4 $1753
JUMPV
LABELV $1752
ADDRLP4 64
ADDRGP4 $1747
ASGNP4
LABELV $1753
ADDRLP4 64
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3941
;3941:	}
LABELV $1745
line 3942
;3942:}
LABELV $1733
endproc Item_YesNo_Paint 76 40
proc Item_Multi_Paint 64 40
line 3944
;3943:
;3944:static void Item_Multi_Paint(itemDef_t *item) {
line 3946
;3945:	vec4_t newColor, lowLight;
;3946:	const char *text = "";
ADDRLP4 4
ADDRGP4 $94
ASGNP4
line 3947
;3947:	menuDef_t *parent = (menuDef_t *)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 3950
;3948:	rectDef_t menuRect;
;3949:
;3950:	if (item->parent) {
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1755
line 3951
;3951:		menuRect = ((menuDef_t *)item->parent)->window.rect;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
INDIRB
ASGNB 16
line 3952
;3952:	}
LABELV $1755
line 3953
;3953:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1757
line 3954
;3954:		lowLight[0] = 0.8 * parent->focusColor[0];
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3955
;3955:		lowLight[1] = 0.8 * parent->focusColor[1];
ADDRLP4 8+4
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3956
;3956:		lowLight[2] = 0.8 * parent->focusColor[2];
ADDRLP4 8+8
ADDRLP4 0
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3957
;3957:		lowLight[3] = 0.8 * parent->focusColor[3];
ADDRLP4 8+12
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3958
;3958:		LerpColor(parent->focusColor, lowLight, newColor, 0.5 + 0.5 * sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 56
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 56
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3959
;3959:	} else {
ADDRGP4 $1758
JUMPV
LABELV $1757
line 3960
;3960:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 24
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3961
;3961:	}
LABELV $1758
line 3963
;3962:
;3963:	text = Item_Multi_Setting(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 Item_Multi_Setting
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 56
INDIRP4
ASGNP4
line 3965
;3964:
;3965:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1762
line 3966
;3966:		Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3967
;3967:		DC->drawText(item->textRect.x + item->textRect.w + 8, item->textRect.y, item->textscale, newColor, text, 0, 0, item->textStyle, item->fontIndex, item->widescreen); //, menuRect);
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3968
;3968:	} else {
ADDRGP4 $1763
JUMPV
LABELV $1762
line 3969
;3969:		DC->drawText(item->textRect.x, item->textRect.y, item->textscale, newColor, text, 0, 0, item->textStyle, item->fontIndex, item->widescreen); //, menuRect);
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 3970
;3970:	}
LABELV $1763
line 3971
;3971:}
LABELV $1754
endproc Item_Multi_Paint 64 40
data
align 4
LABELV g_bindings
address $1766
byte 4 9
byte 4 -1
byte 4 -1
byte 4 -1
address $1767
byte 4 13
byte 4 -1
byte 4 -1
byte 4 -1
address $1768
byte 4 138
byte 4 -1
byte 4 -1
byte 4 -1
address $1769
byte 4 132
byte 4 -1
byte 4 -1
byte 4 -1
address $1770
byte 4 133
byte 4 -1
byte 4 -1
byte 4 -1
address $1771
byte 4 44
byte 4 -1
byte 4 -1
byte 4 -1
address $1772
byte 4 46
byte 4 -1
byte 4 -1
byte 4 -1
address $1773
byte 4 32
byte 4 -1
byte 4 -1
byte 4 -1
address $1774
byte 4 99
byte 4 -1
byte 4 -1
byte 4 -1
address $1775
byte 4 134
byte 4 -1
byte 4 -1
byte 4 -1
address $1776
byte 4 135
byte 4 -1
byte 4 -1
byte 4 -1
address $1777
byte 4 136
byte 4 -1
byte 4 -1
byte 4 -1
address $1778
byte 4 141
byte 4 -1
byte 4 -1
byte 4 -1
address $1779
byte 4 140
byte 4 -1
byte 4 -1
byte 4 -1
address $1780
byte 4 47
byte 4 -1
byte 4 -1
byte 4 -1
address $1781
byte 4 144
byte 4 -1
byte 4 -1
byte 4 -1
address $1782
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
address $1783
byte 4 49
byte 4 -1
byte 4 -1
byte 4 -1
address $1784
byte 4 50
byte 4 -1
byte 4 -1
byte 4 -1
address $1785
byte 4 51
byte 4 -1
byte 4 -1
byte 4 -1
address $1786
byte 4 52
byte 4 -1
byte 4 -1
byte 4 -1
address $1787
byte 4 53
byte 4 -1
byte 4 -1
byte 4 -1
address $1788
byte 4 54
byte 4 -1
byte 4 -1
byte 4 -1
address $1789
byte 4 55
byte 4 -1
byte 4 -1
byte 4 -1
address $1790
byte 4 56
byte 4 -1
byte 4 -1
byte 4 -1
address $1791
byte 4 57
byte 4 -1
byte 4 -1
byte 4 -1
address $1792
byte 4 48
byte 4 -1
byte 4 -1
byte 4 -1
address $1793
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
address $1794
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
address $1795
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
address $1796
byte 4 137
byte 4 -1
byte 4 -1
byte 4 -1
address $1797
byte 4 91
byte 4 -1
byte 4 -1
byte 4 -1
address $1798
byte 4 93
byte 4 -1
byte 4 -1
byte 4 -1
address $1799
byte 4 180
byte 4 -1
byte 4 -1
byte 4 -1
address $1800
byte 4 181
byte 4 -1
byte 4 -1
byte 4 -1
address $1801
byte 4 119
byte 4 -1
byte 4 -1
byte 4 -1
address $1802
byte 4 114
byte 4 -1
byte 4 -1
byte 4 -1
address $1803
byte 4 116
byte 4 -1
byte 4 -1
byte 4 -1
address $1804
byte 4 121
byte 4 -1
byte 4 -1
byte 4 -1
address $1805
byte 4 110
byte 4 -1
byte 4 -1
byte 4 -1
address $1806
byte 4 111
byte 4 -1
byte 4 -1
byte 4 -1
address $1807
byte 4 100
byte 4 -1
byte 4 -1
byte 4 -1
address $1808
byte 4 112
byte 4 -1
byte 4 -1
byte 4 -1
address $1809
byte 4 99
byte 4 -1
byte 4 -1
byte 4 -1
address $1810
byte 4 102
byte 4 -1
byte 4 -1
byte 4 -1
address $1811
byte 4 118
byte 4 -1
byte 4 -1
byte 4 -1
address $1812
byte 4 101
byte 4 -1
byte 4 -1
byte 4 -1
address $1813
byte 4 105
byte 4 -1
byte 4 -1
byte 4 -1
address $1814
byte 4 107
byte 4 -1
byte 4 -1
byte 4 -1
address $1815
byte 4 145
byte 4 -1
byte 4 -1
byte 4 -1
address $1816
byte 4 146
byte 4 -1
byte 4 -1
byte 4 -1
address $1817
byte 4 147
byte 4 -1
byte 4 -1
byte 4 -1
address $1818
byte 4 148
byte 4 -1
byte 4 -1
byte 4 -1
address $1819
byte 4 149
byte 4 -1
byte 4 -1
byte 4 -1
address $1820
byte 4 162
byte 4 -1
byte 4 -1
byte 4 -1
address $1821
byte 4 168
byte 4 -1
byte 4 -1
byte 4 -1
address $1822
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
address $1823
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
address $1824
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
address $1825
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
align 4
LABELV g_bindCount
byte 4 60
align 4
LABELV g_configcvars
address $1826
byte 4 0
byte 4 0
address $1827
byte 4 0
byte 4 0
address $1828
byte 4 0
byte 4 0
address $1829
byte 4 0
byte 4 0
address $1830
byte 4 0
byte 4 0
address $1831
byte 4 0
byte 4 0
address $1832
byte 4 0
byte 4 0
address $1833
byte 4 0
byte 4 0
byte 4 0
byte 4 0
byte 4 0
code
proc Controls_GetKeyAssignment 276 12
line 4084
;3972:
;3973:
;3974:typedef struct {
;3975:	char *command;
;3976:	int		defaultbind1;
;3977:	int		defaultbind2;
;3978:	int		bind1;
;3979:	int		bind2;
;3980:} bind_t;
;3981:
;3982:typedef struct {
;3983:	char *name;
;3984:	float	defaultvalue;
;3985:	float	value;
;3986:} configcvar_t;
;3987:
;3988:
;3989:static bind_t g_bindings[] =
;3990:{
;3991:	{"+scores",			 K_TAB,				-1,		-1, -1},
;3992:	{"+button2",		 K_ENTER,			-1,		-1, -1},
;3993:	{"+speed", 			 K_SHIFT,			-1,		-1,	-1},
;3994:	{"+forward", 		 K_UPARROW,		-1,		-1, -1},
;3995:	{"+back", 			 K_DOWNARROW,	-1,		-1, -1},
;3996:	{"+moveleft", 	 ',',					-1,		-1, -1},
;3997:	{"+moveright", 	 '.',					-1,		-1, -1},
;3998:	{"+moveup",			 K_SPACE,			-1,		-1, -1},
;3999:	{"+movedown",		 'c',					-1,		-1, -1},
;4000:	{"+left", 			 K_LEFTARROW,	-1,		-1, -1},
;4001:	{"+right", 			 K_RIGHTARROW,	-1,		-1, -1},
;4002:	{"+strafe", 		 K_ALT,				-1,		-1, -1},
;4003:	{"+lookup", 		 K_PGDN,				-1,		-1, -1},
;4004:	{"+lookdown", 	 K_DEL,				-1,		-1, -1},
;4005:	{"+mlook", 			 '/',					-1,		-1, -1},
;4006:	{"centerview", 	 K_END,				-1,		-1, -1},
;4007:	{"+zoom", 			 -1,						-1,		-1, -1},
;4008:	{"weapon 1",		 '1',					-1,		-1, -1},
;4009:	{"weapon 2",		 '2',					-1,		-1, -1},
;4010:	{"weapon 3",		 '3',					-1,		-1, -1},
;4011:	{"weapon 4",		 '4',					-1,		-1, -1},
;4012:	{"weapon 5",		 '5',					-1,		-1, -1},
;4013:	{"weapon 6",		 '6',					-1,		-1, -1},
;4014:	{"weapon 7",		 '7',					-1,		-1, -1},
;4015:	{"weapon 8",		 '8',					-1,		-1, -1},
;4016:	{"weapon 9",		 '9',					-1,		-1, -1},
;4017:	{"weapon 10",		 '0',					-1,		-1, -1},
;4018:	{"weapon 11",		 -1,					-1,		-1, -1},
;4019:	{"weapon 12",		 -1,					-1,		-1, -1},
;4020:	{"weapon 13",		 -1,					-1,		-1, -1},
;4021:	{"+attack", 		 K_CTRL,				-1,		-1, -1},
;4022:	{"weapprev",		 '[',					-1,		-1, -1},
;4023:	{"weapnext", 		 ']',					-1,		-1, -1},
;4024:	{"+button3", 		 K_MOUSE3,			-1,		-1, -1},
;4025:	{"+button4", 		 K_MOUSE4,			-1,		-1, -1},
;4026:	{"prevTeamMember", 'w',					-1,		-1, -1},
;4027:	{"nextTeamMember", 'r',					-1,		-1, -1},
;4028:	{"nextOrder", 't',					-1,		-1, -1},
;4029:	{"confirmOrder", 'y',					-1,		-1, -1},
;4030:	{"denyOrder", 'n',					-1,		-1, -1},
;4031:	{"taskOffense", 'o',					-1,		-1, -1},
;4032:	{"taskDefense", 'd',					-1,		-1, -1},
;4033:	{"taskPatrol", 'p',					-1,		-1, -1},
;4034:	{"taskCamp", 'c',					-1,		-1, -1},
;4035:	{"taskFollow", 'f',					-1,		-1, -1},
;4036:	{"taskRetrieve", 'v',					-1,		-1, -1},
;4037:	{"taskEscort", 'e',					-1,		-1, -1},
;4038:	{"taskOwnFlag", 'i',					-1,		-1, -1},
;4039:	{"taskSuicide", 'k',					-1,		-1, -1},
;4040:	{"tauntKillInsult", K_F1,			-1,		-1, -1},
;4041:	{"tauntPraise", K_F2,			-1,		-1, -1},
;4042:	{"tauntTaunt", K_F3,			-1,		-1, -1},
;4043:	{"tauntDeathInsult", K_F4,			-1,		-1, -1},
;4044:	{"tauntGauntlet", K_F5,			-1,		-1, -1},
;4045:	{"scoresUp", K_KP_PGUP,			-1,		-1, -1},
;4046:	{"scoresDown", K_KP_PGDN,			-1,		-1, -1},
;4047:	{"messagemode",  -1,					-1,		-1, -1},
;4048:	{"messagemode2", -1,						-1,		-1, -1},
;4049:	{"messagemode3", -1,						-1,		-1, -1},
;4050:	{"messagemode4", -1,						-1,		-1, -1},
;4051:#if 0  // doesn't work, uses q3default.cfg
;4052:	{ "pause", K_PAUSE, -1, -1, -1 },
;4053:	{ "freecam", K_KP_ENTER, -1, -1, -1 },
;4054:	{ "rewind 10", K_KP_LEFTARROW, -1, -1, -1 },
;4055:	{ "fastforward 10", K_KP_RIGHTARROW, -1, -1, -1 },
;4056:	{ "fastforward 60", K_KP_UPARROW, -1, -1, -1 },
;4057:	{ "rewind 60", K_KP_DOWNARROW, -1, -1, -1 },
;4058:#endif
;4059:};
;4060:
;4061:
;4062:static const int g_bindCount = ARRAY_LEN(g_bindings);
;4063:
;4064:#ifndef MISSIONPACK
;4065:static configcvar_t g_configcvars[] =
;4066:{
;4067:	{"cl_run",			0,					0},
;4068:	{"m_pitch",			0,					0},
;4069:	{"cg_autoswitch",	0,					0},
;4070:	{"sensitivity",		0,					0},
;4071:	{"in_joystick",		0,					0},
;4072:	{"joy_threshold",	0,					0},
;4073:	{"m_filter",		0,					0},
;4074:	{"cl_freelook",		0,					0},
;4075:	{NULL,				0,					0}
;4076:};
;4077:#endif
;4078:
;4079:/*
;4080:=================
;4081:Controls_GetKeyAssignment
;4082:=================
;4083:*/
;4084:static void Controls_GetKeyAssignment(char *command, int *twokeys) {
line 4089
;4085:	int		count;
;4086:	int		j;
;4087:	char	b[256];
;4088:
;4089:	twokeys[0] = twokeys[1] = -1;
ADDRLP4 264
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 268
CNSTI4 -1
ASGNI4
ADDRLP4 264
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 268
INDIRI4
ASGNI4
ADDRLP4 264
INDIRP4
ADDRLP4 268
INDIRI4
ASGNI4
line 4090
;4090:	count = 0;
ADDRLP4 260
CNSTI4 0
ASGNI4
line 4092
;4091:
;4092:	for (j = 0; j < 256; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1835
line 4093
;4093:		DC->getBindingBuf(j, b, 256);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLV
pop
line 4094
;4094:		if (*b == 0) {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1839
line 4095
;4095:			continue;
ADDRGP4 $1836
JUMPV
LABELV $1839
line 4097
;4096:		}
;4097:		if (!Q_stricmp(b, command)) {
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 0
NEI4 $1841
line 4098
;4098:			twokeys[count] = j;
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 4099
;4099:			count++;
ADDRLP4 260
ADDRLP4 260
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4100
;4100:			if (count == 2) {
ADDRLP4 260
INDIRI4
CNSTI4 2
NEI4 $1843
line 4101
;4101:				break;
ADDRGP4 $1837
JUMPV
LABELV $1843
line 4103
;4102:			}
;4103:		}
LABELV $1841
line 4104
;4104:	}
LABELV $1836
line 4092
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 256
LTI4 $1835
LABELV $1837
line 4105
;4105:}
LABELV $1834
endproc Controls_GetKeyAssignment 276 12
export Controls_GetConfig
proc Controls_GetConfig 12 8
line 4112
;4106:
;4107:/*
;4108:=================
;4109:Controls_GetConfig
;4110:=================
;4111:*/
;4112:void Controls_GetConfig(void) {
line 4117
;4113:	int		i;
;4114:	int		twokeys[2];
;4115:
;4116:	// iterate each command, get its numeric binding
;4117:	for (i = 0; i < g_bindCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1849
JUMPV
LABELV $1846
line 4119
;4118:
;4119:		Controls_GetKeyAssignment(g_bindings[i].command, twokeys);
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Controls_GetKeyAssignment
CALLV
pop
line 4121
;4120:
;4121:		g_bindings[i].bind1 = twokeys[0];
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+12
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 4122
;4122:		g_bindings[i].bind2 = twokeys[1];
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+16
ADDP4
ADDRLP4 4+4
INDIRI4
ASGNI4
line 4123
;4123:	}
LABELV $1847
line 4117
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1849
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1846
line 4133
;4124:
;4125:	//s_controls.invertmouse.curvalue  = DC->getCVarValue( "m_pitch" ) < 0;
;4126:	//s_controls.smoothmouse.curvalue  = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "m_filter" ) );
;4127:	//s_controls.alwaysrun.curvalue    = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "cl_run" ) );
;4128:	//s_controls.autoswitch.curvalue   = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "cg_autoswitch" ) );
;4129:	//s_controls.sensitivity.curvalue  = UI_ClampCvar( 2, 30, Controls_GetCvarValue( "sensitivity" ) );
;4130:	//s_controls.joyenable.curvalue    = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "in_joystick" ) );
;4131:	//s_controls.joythreshold.curvalue = UI_ClampCvar( 0.05, 0.75, Controls_GetCvarValue( "joy_threshold" ) );
;4132:	//s_controls.freelook.curvalue     = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "cl_freelook" ) );
;4133:}
LABELV $1845
endproc Controls_GetConfig 12 8
export Controls_SetConfig
proc Controls_SetConfig 12 8
line 4140
;4134:
;4135:/*
;4136:=================
;4137:Controls_SetConfig
;4138:=================
;4139:*/
;4140:void Controls_SetConfig(qboolean restart) {
line 4144
;4141:	int		i;
;4142:
;4143:	// iterate each command, get its numeric binding
;4144:	for (i = 0; i < g_bindCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1857
JUMPV
LABELV $1854
line 4146
;4145:
;4146:		if (g_bindings[i].bind1 != -1) {
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+12
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1858
line 4147
;4147:			DC->setBinding(g_bindings[i].bind1, g_bindings[i].command);
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+12
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings
ADDP4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 148
ADDP4
INDIRP4
CALLV
pop
line 4149
;4148:
;4149:			if (g_bindings[i].bind2 != -1)
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1862
line 4150
;4150:				DC->setBinding(g_bindings[i].bind2, g_bindings[i].command);
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings
ADDP4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 148
ADDP4
INDIRP4
CALLV
pop
LABELV $1862
line 4151
;4151:		}
LABELV $1858
line 4152
;4152:	}
LABELV $1855
line 4144
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1857
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1854
line 4166
;4153:
;4154:	//if ( s_controls.invertmouse.curvalue )
;4155:	//	DC->setCVar("m_pitch", va("%f),-fabs( DC->getCVarValue( "m_pitch" ) ) );
;4156:	//else
;4157:	//	trap_Cvar_SetValue( "m_pitch", fabs( trap_Cvar_VariableValue( "m_pitch" ) ) );
;4158:
;4159:	//trap_Cvar_SetValue( "m_filter", s_controls.smoothmouse.curvalue );
;4160:	//trap_Cvar_SetValue( "cl_run", s_controls.alwaysrun.curvalue );
;4161:	//trap_Cvar_SetValue( "cg_autoswitch", s_controls.autoswitch.curvalue );
;4162:	//trap_Cvar_SetValue( "sensitivity", s_controls.sensitivity.curvalue );
;4163:	//trap_Cvar_SetValue( "in_joystick", s_controls.joyenable.curvalue );
;4164:	//trap_Cvar_SetValue( "joy_threshold", s_controls.joythreshold.curvalue );
;4165:	//trap_Cvar_SetValue( "cl_freelook", s_controls.freelook.curvalue );
;4166:	DC->executeText(EXEC_APPEND, "in_restart\n");
CNSTI4 2
ARGI4
ADDRGP4 $1866
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 152
ADDP4
INDIRP4
CALLV
pop
line 4168
;4167:	//trap_Cmd_ExecuteText( EXEC_APPEND, "in_restart\n" );
;4168:}
LABELV $1853
endproc Controls_SetConfig 12 8
export Controls_SetDefaults
proc Controls_SetDefaults 12 0
line 4175
;4169:
;4170:/*
;4171:=================
;4172:Controls_SetDefaults
;4173:=================
;4174:*/
;4175:void Controls_SetDefaults(void) {
line 4179
;4176:	int	i;
;4177:
;4178:	// iterate each command, set its default binding
;4179:	for (i = 0; i < g_bindCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1871
JUMPV
LABELV $1868
line 4180
;4180:		g_bindings[i].bind1 = g_bindings[i].defaultbind1;
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+12
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+4
ADDP4
INDIRI4
ASGNI4
line 4181
;4181:		g_bindings[i].bind2 = g_bindings[i].defaultbind2;
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+8
ADDP4
INDIRI4
ASGNI4
line 4182
;4182:	}
LABELV $1869
line 4179
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1871
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1868
line 4192
;4183:
;4184:	//s_controls.invertmouse.curvalue  = Controls_GetCvarDefault( "m_pitch" ) < 0;
;4185:	//s_controls.smoothmouse.curvalue  = Controls_GetCvarDefault( "m_filter" );
;4186:	//s_controls.alwaysrun.curvalue    = Controls_GetCvarDefault( "cl_run" );
;4187:	//s_controls.autoswitch.curvalue   = Controls_GetCvarDefault( "cg_autoswitch" );
;4188:	//s_controls.sensitivity.curvalue  = Controls_GetCvarDefault( "sensitivity" );
;4189:	//s_controls.joyenable.curvalue    = Controls_GetCvarDefault( "in_joystick" );
;4190:	//s_controls.joythreshold.curvalue = Controls_GetCvarDefault( "joy_threshold" );
;4191:	//s_controls.freelook.curvalue     = Controls_GetCvarDefault( "cl_freelook" );
;4192:}
LABELV $1867
endproc Controls_SetDefaults 12 0
proc BindingIDFromName 8 8
line 4194
;4193:
;4194:static int BindingIDFromName(const char *name) {
line 4196
;4195:	int i;
;4196:	for (i = 0; i < g_bindCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1880
JUMPV
LABELV $1877
line 4197
;4197:		if (Q_stricmp(name, g_bindings[i].command) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1881
line 4198
;4198:			return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1876
JUMPV
LABELV $1881
line 4200
;4199:		}
;4200:	}
LABELV $1878
line 4196
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1880
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1877
line 4201
;4201:	return -1;
CNSTI4 -1
RETI4
LABELV $1876
endproc BindingIDFromName 8 8
proc BindingFromName 16 12
line 4207
;4202:}
;4203:
;4204:char g_nameBind1[32];
;4205:char g_nameBind2[32];
;4206:
;4207:static void BindingFromName(const char *cvar) {
line 4211
;4208:	int	i, b1, b2;
;4209:
;4210:	// iterate each command, set its default binding
;4211:	for (i = 0; i < g_bindCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1887
JUMPV
LABELV $1884
line 4212
;4212:		if (Q_stricmp(cvar, g_bindings[i].command) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $1888
line 4213
;4213:			b1 = g_bindings[i].bind1;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+12
ADDP4
INDIRI4
ASGNI4
line 4214
;4214:			if (b1 == -1) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
NEI4 $1891
line 4215
;4215:				break;
ADDRGP4 $1886
JUMPV
LABELV $1891
line 4217
;4216:			}
;4217:			DC->keynumToStringBuf(b1, g_nameBind1, 32);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 g_nameBind1
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 140
ADDP4
INDIRP4
CALLV
pop
line 4218
;4218:			Q_strupr(g_nameBind1);
ADDRGP4 g_nameBind1
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 4220
;4219:
;4220:			b2 = g_bindings[i].bind2;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ASGNI4
line 4221
;4221:			if (b2 != -1) {
ADDRLP4 8
INDIRI4
CNSTI4 -1
EQI4 $1883
line 4222
;4222:				DC->keynumToStringBuf(b2, g_nameBind2, 32);
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 g_nameBind2
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 140
ADDP4
INDIRP4
CALLV
pop
line 4223
;4223:				Q_strupr(g_nameBind2);
ADDRGP4 g_nameBind2
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 4224
;4224:				strcat(g_nameBind1, " or ");
ADDRGP4 g_nameBind1
ARGP4
ADDRGP4 $1896
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 4225
;4225:				strcat(g_nameBind1, g_nameBind2);
ADDRGP4 g_nameBind1
ARGP4
ADDRGP4 g_nameBind2
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 4226
;4226:			}
line 4227
;4227:			return;
ADDRGP4 $1883
JUMPV
LABELV $1888
line 4229
;4228:		}
;4229:	}
LABELV $1885
line 4211
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1887
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1884
LABELV $1886
line 4230
;4230:	strcpy(g_nameBind1, "???");
ADDRGP4 g_nameBind1
ARGP4
ADDRGP4 $1897
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 4231
;4231:}
LABELV $1883
endproc BindingFromName 16 12
proc Item_Slider_Paint 72 24
line 4233
;4232:
;4233:static void Item_Slider_Paint(itemDef_t *item) {
line 4236
;4234:	vec4_t newColor, lowLight;
;4235:	float x, y;
;4236:	menuDef_t *parent = (menuDef_t *)item->parent;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 4239
;4237:	rectDef_t menuRect;
;4238:
;4239:	if (!item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1899
line 4240
;4240:		Com_Printf("^1Item_Slider_Paint item == NULL\n");
ADDRGP4 $1901
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4241
;4241:		return;
ADDRGP4 $1898
JUMPV
LABELV $1899
line 4244
;4242:	}
;4243:
;4244:	if (item->parent == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1902
line 4245
;4245:		Com_Printf("^1Item_Slider_Paint item->parent == NULL\n");
ADDRGP4 $1904
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4246
;4246:		return;
ADDRGP4 $1898
JUMPV
LABELV $1902
line 4249
;4247:	}
;4248:
;4249:	menuRect = ((menuDef_t *)item->parent)->window.rect;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
INDIRB
ASGNB 16
line 4251
;4250:
;4251:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1905
line 4252
;4252:		lowLight[0] = 0.8 * parent->focusColor[0];
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 4253
;4253:		lowLight[1] = 0.8 * parent->focusColor[1];
ADDRLP4 12+4
ADDRLP4 4
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 4254
;4254:		lowLight[2] = 0.8 * parent->focusColor[2];
ADDRLP4 12+8
ADDRLP4 4
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 4255
;4255:		lowLight[3] = 0.8 * parent->focusColor[3];
ADDRLP4 12+12
ADDRLP4 4
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 4256
;4256:		LerpColor(parent->focusColor, lowLight, newColor, 0.5 + 0.5 * sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 60
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 236
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 60
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 4257
;4257:	} else {
ADDRGP4 $1906
JUMPV
LABELV $1905
line 4258
;4258:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 4259
;4259:	}
LABELV $1906
line 4261
;4260:
;4261:	y = item->window.rect.y;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 4262
;4262:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1910
line 4263
;4263:		Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 4264
;4264:		x = item->textRect.x + item->textRect.w + 8;
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 60
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 4265
;4265:	} else {
ADDRGP4 $1911
JUMPV
LABELV $1910
line 4266
;4266:		x = item->window.rect.x;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 4267
;4267:	}
LABELV $1911
line 4268
;4268:	DC->setColor(newColor);
ADDRLP4 28
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 4269
;4269:	DC->drawHandlePic(x, y, SLIDER_WIDTH, SLIDER_HEIGHT, DC->Assets.sliderBar, item->widescreen); //, menuRect);
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
CNSTF4 1119879168
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 60
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 5342776
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4271
;4270:
;4271:	x = Item_Slider_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 Item_Slider_ThumbPosition
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 64
INDIRF4
ASGNF4
line 4272
;4272:	DC->drawHandlePic(x - (SLIDER_THUMB_WIDTH / 2), y - 2, SLIDER_THUMB_WIDTH, SLIDER_THUMB_HEIGHT, DC->Assets.sliderThumb, item->widescreen); //, menuRect);
ADDRLP4 0
INDIRF4
CNSTF4 1086324736
SUBF4
ARGF4
ADDRLP4 8
INDIRF4
CNSTF4 1073741824
SUBF4
ARGF4
CNSTF4 1094713344
ARGF4
CNSTF4 1101004800
ARGF4
ADDRLP4 68
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 5342780
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4273
;4273:}
LABELV $1898
endproc Item_Slider_Paint 72 24
proc Item_Bind_Paint 64 40
line 4275
;4274:
;4275:static void Item_Bind_Paint(itemDef_t *item) {
line 4277
;4276:	vec4_t newColor, lowLight;
;4277:	int maxChars = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 4278
;4278:	menuDef_t *parent = (menuDef_t *)item->parent;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 4279
;4279:	editFieldDef_t *editPtr = (editFieldDef_t *)item->typeData;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 4282
;4280:	rectDef_t menuRect;
;4281:
;4282:	if (item->parent) {
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1913
line 4283
;4283:		menuRect = ((menuDef_t *)item->parent)->window.rect;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
INDIRB
ASGNB 16
line 4284
;4284:	}
LABELV $1913
line 4285
;4285:	if (editPtr) {
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1915
line 4286
;4286:		maxChars = editPtr->maxPaintChars;
ADDRLP4 16
ADDRLP4 24
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
line 4287
;4287:	}
LABELV $1915
line 4289
;4288:
;4289:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1917
line 4290
;4290:		if (g_bindItem == item) {
ADDRGP4 g_bindItem
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $1919
line 4291
;4291:			lowLight[0] = 0.8f * 1.0f;
ADDRLP4 0
CNSTF4 1061997773
ASGNF4
line 4292
;4292:			lowLight[1] = 0.8f * 0.0f;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 4293
;4293:			lowLight[2] = 0.8f * 0.0f;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 4294
;4294:			lowLight[3] = 0.8f * 1.0f;
ADDRLP4 0+12
CNSTF4 1061997773
ASGNF4
line 4295
;4295:		} else {
ADDRGP4 $1920
JUMPV
LABELV $1919
line 4296
;4296:			lowLight[0] = 0.8f * parent->focusColor[0];
ADDRLP4 0
ADDRLP4 20
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 4297
;4297:			lowLight[1] = 0.8f * parent->focusColor[1];
ADDRLP4 0+4
ADDRLP4 20
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 4298
;4298:			lowLight[2] = 0.8f * parent->focusColor[2];
ADDRLP4 0+8
ADDRLP4 20
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 4299
;4299:			lowLight[3] = 0.8f * parent->focusColor[3];
ADDRLP4 0+12
ADDRLP4 20
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 4300
;4300:		}
LABELV $1920
line 4301
;4301:		LerpColor(parent->focusColor, lowLight, newColor, 0.5 + 0.5 * sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 60
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
CNSTI4 236
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 28
ARGP4
ADDRLP4 60
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 4302
;4302:	} else {
ADDRGP4 $1918
JUMPV
LABELV $1917
line 4303
;4303:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 4304
;4304:	}
LABELV $1918
line 4306
;4305:
;4306:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1927
line 4307
;4307:		Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 4308
;4308:		BindingFromName(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRGP4 BindingFromName
CALLV
pop
line 4309
;4309:		DC->drawText(item->textRect.x + item->textRect.w + 8, item->textRect.y, item->textscale, newColor, g_nameBind1, 0, maxChars, item->textStyle, item->fontIndex, item->widescreen); //, menuRect);
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
ARGP4
ADDRGP4 g_nameBind1
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 4310
;4310:	} else {
ADDRGP4 $1928
JUMPV
LABELV $1927
line 4311
;4311:		DC->drawText(item->textRect.x, item->textRect.y, item->textscale, newColor, "FIXME", 0, maxChars, item->textStyle, item->fontIndex, item->widescreen); //, menuRect);
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
ARGP4
ADDRGP4 $1929
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 4312
;4312:	}
LABELV $1928
line 4313
;4313:}
LABELV $1912
endproc Item_Bind_Paint 64 40
export Display_KeyBindPending
proc Display_KeyBindPending 0 0
line 4315
;4314:
;4315:qboolean Display_KeyBindPending(void) {
line 4316
;4316:	return g_waitingForKey;
ADDRGP4 g_waitingForKey
INDIRI4
RETI4
LABELV $1930
endproc Display_KeyBindPending 0 0
proc Item_Bind_HandleKey 24 16
line 4319
;4317:}
;4318:
;4319:static qboolean Item_Bind_HandleKey(itemDef_t *item, int key, qboolean down) {
line 4323
;4320:	int			id;
;4321:	int			i;
;4322:
;4323:	if (!g_waitingForKey) {
ADDRGP4 g_waitingForKey
INDIRI4
CNSTI4 0
NEI4 $1932
line 4324
;4324:		if (down && ((key == K_MOUSE1 && Rect_ContainsWidescreenPoint(&item->window.rect, DC->cursorx, DC->cursory, item->widescreen))
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1934
ADDRFP4 4
INDIRI4
CNSTI4 178
NEI4 $1937
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 224
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $1942
LABELV $1937
ADDRLP4 20
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 13
EQI4 $1942
ADDRLP4 20
INDIRI4
CNSTI4 169
EQI4 $1942
ADDRLP4 20
INDIRI4
CNSTI4 185
EQI4 $1942
ADDRLP4 20
INDIRI4
CNSTI4 186
EQI4 $1942
ADDRLP4 20
INDIRI4
CNSTI4 187
EQI4 $1942
ADDRLP4 20
INDIRI4
CNSTI4 188
NEI4 $1934
LABELV $1942
line 4325
;4325:			|| key == K_ENTER || key == K_KP_ENTER || key == K_JOY1 || key == K_JOY2 || key == K_JOY3 || key == K_JOY4)) {
line 4326
;4326:			g_waitingForKey = qtrue;
ADDRGP4 g_waitingForKey
CNSTI4 1
ASGNI4
line 4327
;4327:			g_bindItem = item;
ADDRGP4 g_bindItem
ADDRFP4 0
INDIRP4
ASGNP4
line 4328
;4328:		}
LABELV $1934
line 4329
;4329:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1931
JUMPV
LABELV $1932
line 4330
;4330:	} else {
line 4331
;4331:		if (g_bindItem == NULL) {
ADDRGP4 g_bindItem
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1943
line 4332
;4332:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1931
JUMPV
LABELV $1943
line 4335
;4333:		}
;4334:
;4335:		if (key & K_CHAR_FLAG) {
ADDRFP4 4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1945
line 4336
;4336:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1931
JUMPV
LABELV $1945
line 4339
;4337:		}
;4338:
;4339:		switch (key) {
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 96
EQI4 $1963
ADDRLP4 8
INDIRI4
CNSTI4 96
GTI4 $1965
LABELV $1964
ADDRFP4 4
INDIRI4
CNSTI4 27
EQI4 $1949
ADDRGP4 $1947
JUMPV
LABELV $1965
ADDRFP4 4
INDIRI4
CNSTI4 127
EQI4 $1950
ADDRGP4 $1947
JUMPV
LABELV $1949
line 4341
;4340:		case K_ESCAPE:
;4341:			g_waitingForKey = qfalse;
ADDRGP4 g_waitingForKey
CNSTI4 0
ASGNI4
line 4342
;4342:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1931
JUMPV
LABELV $1950
line 4345
;4343:
;4344:		case K_BACKSPACE:
;4345:			id = BindingIDFromName(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 BindingIDFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 4346
;4346:			if (id != -1) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $1951
line 4347
;4347:				if (g_bindings[id].bind1 != -1) {
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+12
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1953
line 4348
;4348:					DC->setBinding(g_bindings[id].bind1, "");
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+12
ADDP4
INDIRI4
ARGI4
ADDRGP4 $94
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 148
ADDP4
INDIRP4
CALLV
pop
line 4349
;4349:					g_bindings[id].bind1 = -1;
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+12
ADDP4
CNSTI4 -1
ASGNI4
line 4350
;4350:				}
LABELV $1953
line 4351
;4351:				if (g_bindings[id].bind2 != -1) {
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1958
line 4352
;4352:					DC->setBinding(g_bindings[id].bind2, "");
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ARGI4
ADDRGP4 $94
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 148
ADDP4
INDIRP4
CALLV
pop
line 4353
;4353:					g_bindings[id].bind2 = -1;
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+16
ADDP4
CNSTI4 -1
ASGNI4
line 4354
;4354:				}
LABELV $1958
line 4355
;4355:			}
LABELV $1951
line 4356
;4356:			Controls_SetConfig(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 Controls_SetConfig
CALLV
pop
line 4357
;4357:			g_waitingForKey = qfalse;
ADDRGP4 g_waitingForKey
CNSTI4 0
ASGNI4
line 4358
;4358:			g_bindItem = NULL;
ADDRGP4 g_bindItem
CNSTP4 0
ASGNP4
line 4359
;4359:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1931
JUMPV
LABELV $1963
line 4362
;4360:
;4361:		case '`':
;4362:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1931
JUMPV
LABELV $1947
line 4364
;4363:		}
;4364:	}
line 4366
;4365:
;4366:	if (key != -1) {
ADDRFP4 4
INDIRI4
CNSTI4 -1
EQI4 $1966
line 4368
;4367:
;4368:		for (i = 0; i < g_bindCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1971
JUMPV
LABELV $1968
line 4370
;4369:
;4370:			if (g_bindings[i].bind2 == key) {
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1972
line 4371
;4371:				g_bindings[i].bind2 = -1;
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+16
ADDP4
CNSTI4 -1
ASGNI4
line 4372
;4372:			}
LABELV $1972
line 4374
;4373:
;4374:			if (g_bindings[i].bind1 == key) {
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+12
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1976
line 4375
;4375:				g_bindings[i].bind1 = g_bindings[i].bind2;
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+12
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ASGNI4
line 4376
;4376:				g_bindings[i].bind2 = -1;
ADDRLP4 0
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+16
ADDP4
CNSTI4 -1
ASGNI4
line 4377
;4377:			}
LABELV $1976
line 4378
;4378:		}
LABELV $1969
line 4368
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1971
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1968
line 4379
;4379:	}
LABELV $1966
line 4382
;4380:
;4381:
;4382:	id = BindingIDFromName(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BindingIDFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 4384
;4383:
;4384:	if (id != -1) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $1982
line 4385
;4385:		if (key == -1) {
ADDRFP4 4
INDIRI4
CNSTI4 -1
NEI4 $1984
line 4386
;4386:			if (g_bindings[id].bind1 != -1) {
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+12
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1986
line 4387
;4387:				DC->setBinding(g_bindings[id].bind1, "");
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+12
ADDP4
INDIRI4
ARGI4
ADDRGP4 $94
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 148
ADDP4
INDIRP4
CALLV
pop
line 4388
;4388:				g_bindings[id].bind1 = -1;
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+12
ADDP4
CNSTI4 -1
ASGNI4
line 4389
;4389:			}
LABELV $1986
line 4390
;4390:			if (g_bindings[id].bind2 != -1) {
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1985
line 4391
;4391:				DC->setBinding(g_bindings[id].bind2, "");
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ARGI4
ADDRGP4 $94
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 148
ADDP4
INDIRP4
CALLV
pop
line 4392
;4392:				g_bindings[id].bind2 = -1;
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+16
ADDP4
CNSTI4 -1
ASGNI4
line 4393
;4393:			}
line 4394
;4394:		} else if (g_bindings[id].bind1 == -1) {
ADDRGP4 $1985
JUMPV
LABELV $1984
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+12
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1996
line 4395
;4395:			g_bindings[id].bind1 = key;
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+12
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 4396
;4396:		} else if (g_bindings[id].bind1 != key && g_bindings[id].bind2 == -1) {
ADDRGP4 $1997
JUMPV
LABELV $1996
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+12
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
EQI4 $2000
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $2000
line 4397
;4397:			g_bindings[id].bind2 = key;
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+16
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 4398
;4398:		} else {
ADDRGP4 $2001
JUMPV
LABELV $2000
line 4399
;4399:			DC->setBinding(g_bindings[id].bind1, "");
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+12
ADDP4
INDIRI4
ARGI4
ADDRGP4 $94
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 148
ADDP4
INDIRP4
CALLV
pop
line 4400
;4400:			DC->setBinding(g_bindings[id].bind2, "");
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ARGI4
ADDRGP4 $94
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 148
ADDP4
INDIRP4
CALLV
pop
line 4401
;4401:			g_bindings[id].bind1 = key;
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+12
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 4402
;4402:			g_bindings[id].bind2 = -1;
ADDRLP4 4
INDIRI4
CNSTI4 20
MULI4
ADDRGP4 g_bindings+16
ADDP4
CNSTI4 -1
ASGNI4
line 4403
;4403:		}
LABELV $2001
LABELV $1997
LABELV $1985
line 4404
;4404:	}
LABELV $1982
line 4406
;4405:
;4406:	Controls_SetConfig(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 Controls_SetConfig
CALLV
pop
line 4407
;4407:	g_waitingForKey = qfalse;
ADDRGP4 g_waitingForKey
CNSTI4 0
ASGNI4
line 4409
;4408:
;4409:	return qtrue;
CNSTI4 1
RETI4
LABELV $1931
endproc Item_Bind_HandleKey 24 16
proc AdjustFrom640 16 0
line 4414
;4410:}
;4411:
;4412:
;4413:
;4414:static void AdjustFrom640(float *x, float *y, float *w, float *h) {
line 4418
;4415:	//FIXME widescreen
;4416:
;4417:	//*x = *x * DC->scale + DC->bias;
;4418:	*x *= DC->xscale;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRGP4 DC
INDIRP4
CNSTI4 204
ADDP4
INDIRF4
MULF4
ASGNF4
line 4419
;4419:	*y *= DC->yscale;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 DC
INDIRP4
CNSTI4 200
ADDP4
INDIRF4
MULF4
ASGNF4
line 4420
;4420:	*w *= DC->xscale;
ADDRLP4 8
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRGP4 DC
INDIRP4
CNSTI4 204
ADDP4
INDIRF4
MULF4
ASGNF4
line 4421
;4421:	*h *= DC->yscale;
ADDRLP4 12
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRGP4 DC
INDIRP4
CNSTI4 200
ADDP4
INDIRF4
MULF4
ASGNF4
line 4422
;4422:}
LABELV $2009
endproc AdjustFrom640 16 0
proc Item_Model_Paint 588 16
line 4425
;4423:
;4424://FIXME widescreen
;4425:static void Item_Model_Paint(itemDef_t *item) {
line 4431
;4426:	float x, y, w, h;
;4427:	refdef_t refdef;
;4428:	refEntity_t		ent;
;4429:	vec3_t			mins, maxs, origin;
;4430:	vec3_t			angles;
;4431:	modelDef_t *modelPtr = (modelDef_t *)item->typeData;
ADDRLP4 508
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 4433
;4432:
;4433:	if (modelPtr == NULL) {
ADDRLP4 508
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2011
line 4434
;4434:		return;
ADDRGP4 $2010
JUMPV
LABELV $2011
line 4438
;4435:	}
;4436:
;4437:	// setup the refdef
;4438:	memset(&refdef, 0, sizeof(refdef));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4439
;4439:	refdef.rdflags = RDF_NOWORLDMODEL;
ADDRLP4 0+76
CNSTI4 1
ASGNI4
line 4440
;4440:	AxisClear(refdef.viewaxis);
ADDRLP4 0+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 4441
;4441:	x = item->window.rect.x + 1;
ADDRLP4 568
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4442
;4442:	y = item->window.rect.y + 1;
ADDRLP4 572
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4443
;4443:	w = item->window.rect.w - 2;
ADDRLP4 524
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 4444
;4444:	h = item->window.rect.h - 2;
ADDRLP4 528
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 4446
;4445:
;4446:	AdjustFrom640(&x, &y, &w, &h);
ADDRLP4 568
ARGP4
ADDRLP4 572
ARGP4
ADDRLP4 524
ARGP4
ADDRLP4 528
ARGP4
ADDRGP4 AdjustFrom640
CALLV
pop
line 4448
;4447:
;4448:	refdef.x = x;
ADDRLP4 0
ADDRLP4 568
INDIRF4
CVFI4 4
ASGNI4
line 4449
;4449:	refdef.y = y;
ADDRLP4 0+4
ADDRLP4 572
INDIRF4
CVFI4 4
ASGNI4
line 4450
;4450:	refdef.width = w;
ADDRLP4 0+8
ADDRLP4 524
INDIRF4
CVFI4 4
ASGNI4
line 4451
;4451:	refdef.height = h;
ADDRLP4 0+12
ADDRLP4 528
INDIRF4
CVFI4 4
ASGNI4
line 4453
;4452:
;4453:	DC->modelBounds(item->asset, mins, maxs);
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
ARGI4
ADDRLP4 544
ARGP4
ADDRLP4 556
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
CALLV
pop
line 4455
;4454:
;4455:	origin[2] = -0.5 * (mins[2] + maxs[2]);
ADDRLP4 512+8
ADDRLP4 544+8
INDIRF4
ADDRLP4 556+8
INDIRF4
ADDF4
CNSTF4 3204448256
MULF4
ASGNF4
line 4456
;4456:	origin[1] = 0.5 * (mins[1] + maxs[1]);
ADDRLP4 512+4
ADDRLP4 544+4
INDIRF4
ADDRLP4 556+4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ASGNF4
line 4459
;4457:
;4458:	// calculate distance so the model nearly fills the box
;4459:	if (qtrue) {
line 4460
;4460:		float len = 0.5 * (maxs[2] - mins[2]);
ADDRLP4 576
ADDRLP4 556+8
INDIRF4
ADDRLP4 544+8
INDIRF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 4461
;4461:		origin[0] = len / 0.268;	// len / tan( fov/2 )
ADDRLP4 512
ADDRLP4 576
INDIRF4
CNSTF4 1081003604
MULF4
ASGNF4
line 4463
;4462:		//origin[0] = len / tan(w/2);
;4463:	} else {
ADDRGP4 $2025
JUMPV
LABELV $2024
line 4464
;4464:		origin[0] = item->textscale;
ADDRLP4 512
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ASGNF4
line 4465
;4465:	}
LABELV $2025
line 4466
;4466:	refdef.fov_x = (modelPtr->fov_x) ? modelPtr->fov_x : w;
ADDRLP4 508
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 0
EQF4 $2030
ADDRLP4 576
ADDRLP4 508
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ASGNF4
ADDRGP4 $2031
JUMPV
LABELV $2030
ADDRLP4 576
ADDRLP4 524
INDIRF4
ASGNF4
LABELV $2031
ADDRLP4 0+16
ADDRLP4 576
INDIRF4
ASGNF4
line 4467
;4467:	refdef.fov_y = (modelPtr->fov_y) ? modelPtr->fov_y : h;
ADDRLP4 508
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 0
EQF4 $2034
ADDRLP4 580
ADDRLP4 508
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
ADDRGP4 $2035
JUMPV
LABELV $2034
ADDRLP4 580
ADDRLP4 528
INDIRF4
ASGNF4
LABELV $2035
ADDRLP4 0+20
ADDRLP4 580
INDIRF4
ASGNF4
line 4474
;4468:
;4469:	//refdef.fov_x = (int)((float)refdef.width / (float)SCREEN_WIDTH * 90.0f);
;4470:	//xx = refdef.width / tan( refdef.fov_x / 360 * M_PI );
;4471:	//refdef.fov_y = atan2( refdef.height, xx );
;4472:	//refdef.fov_y *= ( 360 / M_PI );
;4473:
;4474:	DC->clearScene();
ADDRGP4 DC
INDIRP4
CNSTI4 52
ADDP4
INDIRP4
CALLV
pop
line 4476
;4475:
;4476:	refdef.time = DC->realTime;
ADDRLP4 0+72
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ASGNI4
line 4480
;4477:
;4478:	// add the model
;4479:
;4480:	memset(&ent, 0, sizeof(ent));
ADDRLP4 368
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4487
;4481:
;4482:	//adjust = 5.0 * sin( (float)uis.realtime / 500 );
;4483:	//adjust = 360 % (int)((float)uis.realtime / 1000);
;4484:	//VectorSet( angles, 0, 0, 1 );
;4485:
;4486:	// use item storage to track
;4487:	if (modelPtr->rotationSpeed) {
ADDRLP4 508
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2037
line 4488
;4488:		if (DC->realTime > item->window.nextTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
LEI4 $2039
line 4489
;4489:			item->window.nextTime = DC->realTime + modelPtr->rotationSpeed;
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ADDRLP4 508
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ADDI4
ASGNI4
line 4490
;4490:			modelPtr->angle = (int)(modelPtr->angle + 1) % 360;
ADDRLP4 508
INDIRP4
ADDRLP4 508
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 360
MODI4
ASGNI4
line 4491
;4491:		}
LABELV $2039
line 4492
;4492:	}
LABELV $2037
line 4493
;4493:	VectorSet(angles, 0, modelPtr->angle, 0);
ADDRLP4 532
CNSTF4 0
ASGNF4
ADDRLP4 532+4
ADDRLP4 508
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 532+8
CNSTF4 0
ASGNF4
line 4494
;4494:	AnglesToAxis(angles, ent.axis);
ADDRLP4 532
ARGP4
ADDRLP4 368+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 4496
;4495:
;4496:	ent.hModel = item->asset;
ADDRLP4 368+8
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
INDIRI4
ASGNI4
line 4497
;4497:	VectorCopy(origin, ent.origin);
ADDRLP4 368+68
ADDRLP4 512
INDIRB
ASGNB 12
line 4498
;4498:	VectorCopy(origin, ent.lightingOrigin);
ADDRLP4 368+12
ADDRLP4 512
INDIRB
ASGNB 12
line 4499
;4499:	ent.renderfx = RF_LIGHTING_ORIGIN | RF_NOSHADOW;
ADDRLP4 368+4
CNSTI4 192
ASGNI4
line 4500
;4500:	VectorCopy(ent.origin, ent.oldorigin);
ADDRLP4 368+84
ADDRLP4 368+68
INDIRB
ASGNB 12
line 4502
;4501:
;4502:	DC->addRefEntityToScene(&ent);
ADDRLP4 368
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 56
ADDP4
INDIRP4
CALLV
pop
line 4503
;4503:	DC->renderScene(&refdef);
ADDRLP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 60
ADDP4
INDIRP4
CALLV
pop
line 4505
;4504:
;4505:}
LABELV $2010
endproc Item_Model_Paint 588 16
export Item_ListBox_Paint
proc Item_ListBox_Paint 120 40
line 4524
;4506:
;4507:// unused
;4508:#if 0
;4509:static void Item_Image_Paint(itemDef_t *item) {
;4510:	rectDef_t menuRect;
;4511:
;4512:	if (item == NULL) {
;4513:		return;
;4514:	}
;4515:
;4516:	if (item->parent) {
;4517:		menuRect = ((menuDef_t *)item->parent)->window.rect;
;4518:	}
;4519:	DC->drawHandlePic(item->window.rect.x + 1, item->window.rect.y + 1, item->window.rect.w - 2, item->window.rect.h - 2, item->asset, item->widescreen); //, menuRect);
;4520:	//Com_Printf("item image paint\n");
;4521:}
;4522:#endif
;4523:
;4524:void Item_ListBox_Paint(itemDef_t *item) {
line 4529
;4525:	float x, y, size, thumb;
;4526:	int	count, i;
;4527:	qhandle_t image;
;4528:	qhandle_t optionalImage;
;4529:	listBoxDef_t *listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 4533
;4530:	rectDef_t menuRect;
;4531:	float elementHeight;
;4532:
;4533:	if (item->parent) {
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2051
line 4534
;4534:		menuRect = ((menuDef_t *)item->parent)->window.rect;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
INDIRB
ASGNB 16
line 4535
;4535:	}
LABELV $2051
line 4541
;4536:
;4537:	// the listbox is horizontal or vertical and has a fixed size scroll bar going either direction
;4538:	// elements are enumerated from the DC and either text or image handles are acquired from the DC as well
;4539:	// textscale is used to size the text, textalignx and textaligny are used to size image elements
;4540:	// there is no clipping available so only the last completely visible item is painted
;4541:	count = DC->feederCount(item->special);
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
ADDRGP4 DC
INDIRP4
CNSTI4 124
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 56
INDIRI4
ASGNI4
line 4544
;4542:
;4543:	// hack to dynamically change scoreboard line height
;4544:	elementHeight = listPtr->elementHeight;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 4546
;4545:
;4546:	if (item->special == FEEDER_REDTEAM_LIST || item->special == FEEDER_BLUETEAM_LIST) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
CNSTF4 1084227584
EQF4 $2055
ADDRLP4 60
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
CNSTF4 1086324736
NEF4 $2053
LABELV $2055
line 4550
;4547:		float forceLineHeight;
;4548:		int defaultCount;
;4549:
;4550:		forceLineHeight = DC->getCVarValue("cg_scoreBoardForceLineHeightTeam");
ADDRGP4 $2056
ARGP4
ADDRLP4 72
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 64
ADDRLP4 72
INDIRF4
ASGNF4
line 4551
;4551:		defaultCount = DC->getCVarValue("cg_scoreBoardForceLineHeightTeamDefault");
ADDRGP4 $2057
ARGP4
ADDRLP4 76
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 68
ADDRLP4 76
INDIRF4
CVFI4 4
ASGNI4
line 4552
;4552:		if (defaultCount < 1) {
ADDRLP4 68
INDIRI4
CNSTI4 1
GEI4 $2058
line 4553
;4553:			defaultCount = 1;
ADDRLP4 68
CNSTI4 1
ASGNI4
line 4554
;4554:		}
LABELV $2058
line 4557
;4555:
;4556:		// default height of 16 fits 8 players
;4557:		if (forceLineHeight > 0.001f) {
ADDRLP4 64
INDIRF4
CNSTF4 981668463
LEF4 $2060
line 4558
;4558:			elementHeight = forceLineHeight;
ADDRLP4 12
ADDRLP4 64
INDIRF4
ASGNF4
line 4559
;4559:		} else if (forceLineHeight < 0.0f) {
ADDRGP4 $2054
JUMPV
LABELV $2060
ADDRLP4 64
INDIRF4
CNSTF4 0
GEF4 $2054
line 4560
;4560:			if (count > defaultCount) {
ADDRLP4 32
INDIRI4
ADDRLP4 68
INDIRI4
LEI4 $2054
line 4561
;4561:				elementHeight *= (float)defaultCount / (count + 1);  // +1 since the last one can be cut off
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 68
INDIRI4
CVIF4 4
ADDRLP4 32
INDIRI4
CNSTI4 1
ADDI4
CVIF4 4
DIVF4
MULF4
ASGNF4
line 4562
;4562:			}
line 4563
;4563:		} else {  // 0 disables and uses height set in menu
line 4565
;4564:			// pass
;4565:		}
line 4566
;4566:	} else if (item->special == FEEDER_SCOREBOARD) {
ADDRGP4 $2054
JUMPV
LABELV $2053
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
CNSTF4 1093664768
NEF4 $2066
line 4570
;4567:		float forceLineHeight;
;4568:		int defaultCount;
;4569:
;4570:		forceLineHeight = DC->getCVarValue("cg_scoreBoardForceLineHeight");
ADDRGP4 $2068
ARGP4
ADDRLP4 72
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 64
ADDRLP4 72
INDIRF4
ASGNF4
line 4571
;4571:		defaultCount = DC->getCVarValue("cg_scoreBoardForceLineHeightDefault");
ADDRGP4 $2069
ARGP4
ADDRLP4 76
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 68
ADDRLP4 76
INDIRF4
CVFI4 4
ASGNI4
line 4572
;4572:		if (defaultCount < 1) {
ADDRLP4 68
INDIRI4
CNSTI4 1
GEI4 $2070
line 4573
;4573:			defaultCount = 1;
ADDRLP4 68
CNSTI4 1
ASGNI4
line 4574
;4574:		}
LABELV $2070
line 4577
;4575:
;4576:		// default height of 18 fits 9 players
;4577:		if (forceLineHeight > 0.001f) {
ADDRLP4 64
INDIRF4
CNSTF4 981668463
LEF4 $2072
line 4578
;4578:			elementHeight = forceLineHeight;
ADDRLP4 12
ADDRLP4 64
INDIRF4
ASGNF4
line 4579
;4579:		} else if (forceLineHeight < 0.0f) {
ADDRGP4 $2073
JUMPV
LABELV $2072
ADDRLP4 64
INDIRF4
CNSTF4 0
GEF4 $2074
line 4580
;4580:			if (count > defaultCount) {
ADDRLP4 32
INDIRI4
ADDRLP4 68
INDIRI4
LEI4 $2075
line 4581
;4581:				elementHeight *= (float)defaultCount / (count + 1);
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 68
INDIRI4
CVIF4 4
ADDRLP4 32
INDIRI4
CNSTI4 1
ADDI4
CVIF4 4
DIVF4
MULF4
ASGNF4
line 4582
;4582:			}
line 4583
;4583:		} else {  // 0 disables and uses height set in menu
LABELV $2074
line 4585
;4584:			// pass
;4585:		}
LABELV $2075
LABELV $2073
line 4586
;4586:	}
LABELV $2066
LABELV $2054
line 4589
;4587:
;4588:	// default is vertical if horizontal flag is not here
;4589:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $2078
line 4592
;4590:		// draw scrollbar in bottom of the window
;4591:		// bar
;4592:		x = item->window.rect.x + 1;
ADDRLP4 20
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4593
;4593:		y = item->window.rect.y + item->window.rect.h - SCROLLBAR_SIZE - 1;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 64
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 4594
;4594:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarArrowLeft, item->widescreen); //, menuRect);
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 68
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 5342748
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4595
;4595:		x += SCROLLBAR_SIZE - 1;
ADDRLP4 20
ADDRLP4 20
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 4596
;4596:		size = item->window.rect.w - (SCROLLBAR_SIZE * 2);
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 4597
;4597:		DC->drawHandlePic(x, y, size + 1, SCROLLBAR_SIZE, DC->Assets.scrollBar, item->widescreen); //, menuRect);
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 72
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 5342756
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4598
;4598:		x += size - 1;
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 1065353216
SUBF4
ADDF4
ASGNF4
line 4599
;4599:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarArrowRight, item->widescreen); //, menuRect);
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 76
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 5342752
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 76
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4601
;4600:		// thumb
;4601:		thumb = Item_ListBox_ThumbDrawPosition(item);//Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 Item_ListBox_ThumbDrawPosition
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 80
INDIRI4
CVIF4 4
ASGNF4
line 4602
;4602:		if (thumb > x - SCROLLBAR_SIZE - 1) {
ADDRLP4 36
INDIRF4
ADDRLP4 20
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
LEF4 $2080
line 4603
;4603:			thumb = x - SCROLLBAR_SIZE - 1;
ADDRLP4 36
ADDRLP4 20
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 4604
;4604:		}
LABELV $2080
line 4605
;4605:		DC->drawHandlePic(thumb, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarThumb, item->widescreen); //, menuRect);
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 84
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 5342760
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4607
;4606:		//
;4607:		listPtr->endPos = listPtr->startPos;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 4608
;4608:		size = item->window.rect.w - 2;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 4611
;4609:		// items
;4610:		// size contains max available space
;4611:		if (listPtr->elementStyle == LISTBOX_IMAGE) {
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 1
NEI4 $2079
line 4613
;4612:			// fit = 0;
;4613:			x = item->window.rect.x + 1;
ADDRLP4 20
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4614
;4614:			y = item->window.rect.y + 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4615
;4615:			for (i = listPtr->startPos; i < count; i++) {
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
ADDRGP4 $2087
JUMPV
LABELV $2084
line 4618
;4616:				// always draw at least one
;4617:				// which may overdraw the box if it is too small for the element
;4618:				image = DC->feederItemImage(item->special, i);
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 92
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 92
INDIRI4
ASGNI4
line 4619
;4619:				if (image) {
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2088
line 4620
;4620:					DC->drawHandlePic(x + 1, y + 1, listPtr->elementWidth - 2, elementHeight - 2, image, item->widescreen); //, menuRect);
ADDRLP4 20
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 16
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ARGF4
ADDRLP4 12
INDIRF4
CNSTF4 1073741824
SUBF4
ARGF4
ADDRLP4 28
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4621
;4621:				}
LABELV $2088
line 4623
;4622:
;4623:				if (i == item->cursorPos) {
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
NEI4 $2090
line 4624
;4624:					DC->drawRect(x, y, listPtr->elementWidth - 1, elementHeight - 1, item->window.borderSize, item->window.borderColor, item->widescreen); //, menuRect);
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1065353216
SUBF4
ARGF4
ADDRLP4 12
INDIRF4
CNSTF4 1065353216
SUBF4
ARGF4
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ARGF4
ADDRLP4 96
INDIRP4
CNSTI4 148
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 4625
;4625:				}
LABELV $2090
line 4627
;4626:
;4627:				size -= listPtr->elementWidth;
ADDRLP4 24
ADDRLP4 24
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4628
;4628:				if (size < listPtr->elementWidth) {
ADDRLP4 24
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
GEF4 $2092
line 4629
;4629:					listPtr->drawPadding = size; //listPtr->elementWidth - size;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 24
INDIRF4
CVFI4 4
ASGNI4
line 4630
;4630:					break;
ADDRGP4 $2079
JUMPV
LABELV $2092
line 4632
;4631:				}
;4632:				x += listPtr->elementWidth;
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
ASGNF4
line 4633
;4633:				listPtr->endPos++;
ADDRLP4 96
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4635
;4634:				// fit++;
;4635:			}
LABELV $2085
line 4615
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2087
ADDRLP4 4
INDIRI4
ADDRLP4 32
INDIRI4
LTI4 $2084
line 4636
;4636:		} else {
line 4638
;4637:			//
;4638:		}
line 4639
;4639:	} else {
ADDRGP4 $2079
JUMPV
LABELV $2078
line 4641
;4640:		// draw scrollbar to right side of the window
;4641:		x = item->window.rect.x + item->window.rect.w - SCROLLBAR_SIZE - 1;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 64
INDIRP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 4642
;4642:		y = item->window.rect.y + 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4643
;4643:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarArrowUp, item->widescreen); //, menuRect);
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 68
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 5342740
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4644
;4644:		y += SCROLLBAR_SIZE - 1;
ADDRLP4 16
ADDRLP4 16
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 4646
;4645:
;4646:		listPtr->endPos = listPtr->startPos;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 4647
;4647:		size = item->window.rect.h - (SCROLLBAR_SIZE * 2);
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 4648
;4648:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, size + 1, DC->Assets.scrollBar, item->widescreen); //, menuRect);
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 24
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 76
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 5342756
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 76
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4649
;4649:		y += size - 1;
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 1065353216
SUBF4
ADDF4
ASGNF4
line 4650
;4650:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarArrowDown, item->widescreen); //, menuRect);
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 80
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 5342744
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 80
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4652
;4651:		// thumb
;4652:		thumb = Item_ListBox_ThumbDrawPosition(item);//Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 Item_ListBox_ThumbDrawPosition
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 84
INDIRI4
CVIF4 4
ASGNF4
line 4653
;4653:		if (thumb > y - SCROLLBAR_SIZE - 1) {
ADDRLP4 36
INDIRF4
ADDRLP4 16
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
LEF4 $2094
line 4654
;4654:			thumb = y - SCROLLBAR_SIZE - 1;
ADDRLP4 36
ADDRLP4 16
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 4655
;4655:		}
LABELV $2094
line 4656
;4656:		DC->drawHandlePic(x, thumb, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarThumb, item->widescreen); //, menuRect);
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 88
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 5342760
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4659
;4657:
;4658:		// adjust size for item painting
;4659:		size = item->window.rect.h - 2;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 4660
;4660:		if (listPtr->elementStyle == LISTBOX_IMAGE) {
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 1
NEI4 $2096
line 4662
;4661:			// fit = 0;
;4662:			x = item->window.rect.x + 1;
ADDRLP4 20
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4663
;4663:			y = item->window.rect.y + 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4664
;4664:			for (i = listPtr->startPos; i < count; i++) {
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
ADDRGP4 $2101
JUMPV
LABELV $2098
line 4667
;4665:				// always draw at least one
;4666:				// which may overdraw the box if it is too small for the element
;4667:				image = DC->feederItemImage(item->special, i);
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 92
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 92
INDIRI4
ASGNI4
line 4668
;4668:				if (image) {
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2102
line 4669
;4669:					DC->drawHandlePic(x + 1, y + 1, listPtr->elementWidth - 2, elementHeight - 2, image, item->widescreen); //, menuRect);
ADDRLP4 20
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 16
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ARGF4
ADDRLP4 12
INDIRF4
CNSTF4 1073741824
SUBF4
ARGF4
ADDRLP4 28
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4670
;4670:				}
LABELV $2102
line 4672
;4671:
;4672:				if (i == item->cursorPos) {
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
NEI4 $2104
line 4673
;4673:					DC->drawRect(x, y, listPtr->elementWidth - 1, elementHeight - 1, item->window.borderSize, item->window.borderColor, item->widescreen); //, menuRect);
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1065353216
SUBF4
ARGF4
ADDRLP4 12
INDIRF4
CNSTF4 1065353216
SUBF4
ARGF4
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 68
ADDP4
INDIRF4
ARGF4
ADDRLP4 96
INDIRP4
CNSTI4 148
ADDP4
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 4674
;4674:				}
LABELV $2104
line 4676
;4675:
;4676:				listPtr->endPos++;
ADDRLP4 96
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4677
;4677:				size -= listPtr->elementWidth;
ADDRLP4 24
ADDRLP4 24
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4678
;4678:				if (size < elementHeight) {
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
GEF4 $2106
line 4679
;4679:					listPtr->drawPadding = elementHeight - size;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 12
INDIRF4
ADDRLP4 24
INDIRF4
SUBF4
CVFI4 4
ASGNI4
line 4680
;4680:					break;
ADDRGP4 $2097
JUMPV
LABELV $2106
line 4682
;4681:				}
;4682:				y += elementHeight;
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ASGNF4
line 4684
;4683:				// fit++;
;4684:			}
LABELV $2099
line 4664
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2101
ADDRLP4 4
INDIRI4
ADDRLP4 32
INDIRI4
LTI4 $2098
line 4685
;4685:		} else {
ADDRGP4 $2097
JUMPV
LABELV $2096
line 4686
;4686:			x = item->window.rect.x + 1;
ADDRLP4 20
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4687
;4687:			y = item->window.rect.y + 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 4688
;4688:			for (i = listPtr->startPos; i < count; i++) {
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
ADDRGP4 $2111
JUMPV
LABELV $2108
line 4693
;4689:				const char *text;
;4690:				// always draw at least one
;4691:				// which may overdraw the box if it is too small for the element
;4692:
;4693:				if (LastListSelected == listPtr && i == listPtr->selectedCursorPos) {
ADDRGP4 LastListSelected
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRP4
CVPU4 4
NEU4 $2112
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
NEI4 $2112
line 4701
;4694:#if 0
;4695:					vec4_t color;
;4696:
;4697:					Vector4Copy(listPtr->selectedColor, color);
;4698:					color[3] = 0.5;
;4699:#endif
;4700:
;4701:					DC->fillRect(x + 2, y + 2 + 4, item->window.rect.w - SCROLLBAR_SIZE - 4, elementHeight, item->window.outlineColor, item->widescreen); //, menuRect);
ADDRLP4 20
INDIRF4
CNSTF4 1073741824
ADDF4
ARGF4
ADDRLP4 16
INDIRF4
CNSTF4 1073741824
ADDF4
CNSTF4 1082130432
ADDF4
ARGF4
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 100
INDIRP4
CNSTI4 164
ADDP4
ARGP4
ADDRLP4 100
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
CALLV
pop
line 4702
;4702:				} else if ((int)i % 2 == 1) {
ADDRGP4 $2113
JUMPV
LABELV $2112
ADDRLP4 4
INDIRI4
CNSTI4 2
MODI4
CNSTI4 1
NEI4 $2114
line 4704
;4703:					//DC->fillRect(x + 2, y + 2, item->window.rect.w - SCROLLBAR_SIZE - 4, elementHeight, item->window.outlineColor, item->widescreen); //, menuRect);
;4704:					DC->fillRect(x + 2, y + 2 + 4, item->window.rect.w - SCROLLBAR_SIZE - 4, elementHeight, listPtr->altRowColor, item->widescreen); //, menuRect);
ADDRLP4 20
INDIRF4
CNSTF4 1073741824
ADDF4
ARGF4
ADDRLP4 16
INDIRF4
CNSTF4 1073741824
ADDF4
CNSTF4 1082130432
ADDF4
ARGF4
ADDRLP4 100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRLP4 100
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
CALLV
pop
line 4705
;4705:				}
LABELV $2114
LABELV $2113
line 4707
;4706:
;4707:				if (listPtr->numColumns > 0) {
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2116
line 4709
;4708:					int j;
;4709:					for (j = 0; j < listPtr->numColumns; j++) {
ADDRLP4 100
CNSTI4 0
ASGNI4
ADDRGP4 $2121
JUMPV
LABELV $2118
line 4710
;4710:						text = DC->feederItemText(item->special, i, j, &optionalImage);
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 100
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 104
ADDRGP4 DC
INDIRP4
CNSTI4 128
ADDP4
INDIRP4
CALLP4
ASGNP4
ADDRLP4 92
ADDRLP4 104
INDIRP4
ASGNP4
line 4711
;4711:						if (optionalImage >= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $2122
line 4712
;4712:							DC->drawHandlePic(x + 4 + listPtr->columnInfo[j].pos, y - 1 + elementHeight / 2, listPtr->columnInfo[j].width, listPtr->columnInfo[j].width, optionalImage, item->widescreen); //, menuRect);
ADDRLP4 20
INDIRF4
CNSTF4 1082130432
ADDF4
ADDRLP4 100
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDP4
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 16
INDIRF4
CNSTF4 1065353216
SUBF4
ADDRLP4 12
INDIRF4
CNSTF4 1056964608
MULF4
ADDF4
ARGF4
ADDRLP4 100
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 100
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 4713
;4713:						} else if (text) {
ADDRGP4 $2123
JUMPV
LABELV $2122
ADDRLP4 92
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2124
line 4716
;4714:							//DC->drawText(x + 4 + listPtr->columnInfo[j].pos, y + elementHeight, item->textscale, item->window.foreColor, text, 0, listPtr->columnInfo[j].maxChars, item->textStyle, item->fontIndex, item->widescreen); //, menuRect);
;4715:							// scoreboard text
;4716:							DC->drawText(x + 4 + listPtr->columnInfo[j].pos, y + elementHeight, item->textscale, listPtr->elementColor, text, 0, listPtr->columnInfo[j].maxChars, item->textStyle, item->fontIndex, item->widescreen); //, menuRect);
ADDRLP4 20
INDIRF4
CNSTF4 1082130432
ADDF4
ADDRLP4 100
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDP4
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 16
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ARGF4
ADDRLP4 116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 116
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 100
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 116
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRLP4 116
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 116
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 4720
;4717:							//Com_Printf("feeder: text scale %f\n", item->textscale);
;4718:							// 0.16
;4719:							//Com_Printf("max: %d\n", listPtr->columnInfo[j].maxChars);
;4720:						}
LABELV $2124
LABELV $2123
line 4721
;4721:					}
LABELV $2119
line 4709
ADDRLP4 100
ADDRLP4 100
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2121
ADDRLP4 100
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
LTI4 $2118
line 4722
;4722:				} else {
ADDRGP4 $2117
JUMPV
LABELV $2116
line 4723
;4723:					text = DC->feederItemText(item->special, i, 0, &optionalImage);
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 100
ADDRGP4 DC
INDIRP4
CNSTI4 128
ADDP4
INDIRP4
CALLP4
ASGNP4
ADDRLP4 92
ADDRLP4 100
INDIRP4
ASGNP4
line 4724
;4724:					if (optionalImage >= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $2126
line 4726
;4725:						//DC->drawHandlePic(x + 4 + elementHeight, y, listPtr->columnInfo[j].width, listPtr->columnInfo[j].width, optionalImage);
;4726:					} else if (text) {
ADDRGP4 $2127
JUMPV
LABELV $2126
ADDRLP4 92
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2128
line 4728
;4727:						//DC->drawText(x + 4, y + elementHeight, item->textscale, item->window.foreColor, text, 0, 0, item->textStyle, item->fontIndex);
;4728:						DC->drawText(x + 4, y + elementHeight, item->textscale, listPtr->elementColor, text, 0, 0, item->textStyle, item->fontIndex, item->widescreen); //, menuRect);
ADDRLP4 20
INDIRF4
CNSTF4 1082130432
ADDF4
ARGF4
ADDRLP4 16
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ARGF4
ADDRLP4 104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 104
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 104
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRLP4 104
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 104
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 4729
;4729:					}
LABELV $2128
LABELV $2127
line 4730
;4730:				}
LABELV $2117
line 4744
;4731:
;4732:				//FIXME covers names in scoreboard
;4733:#if 0
;4734:				if (i == item->cursorPos) {
;4735:					DC->fillRect(x + 2, y + 2, item->window.rect.w - SCROLLBAR_SIZE - 4, elementHeight, item->window.outlineColor, item->widescreen); //, menuRect);
;4736:				}
;4737:#endif
;4738:#if 0
;4739:				if ((int)i % 2 == 1) {
;4740:					//DC->fillRect(x + 2, y + 2, item->window.rect.w - SCROLLBAR_SIZE - 4, elementHeight, item->window.outlineColor, item->widescreen); //, menuRect);
;4741:					DC->fillRect(x + 2, y + 2 + 4, item->window.rect.w - SCROLLBAR_SIZE - 4, elementHeight, listPtr->altRowColor, item->widescreen); //, menuRect);
;4742:				}
;4743:#endif
;4744:				size -= elementHeight;
ADDRLP4 24
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
line 4745
;4745:				if (size < elementHeight) {
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
GEF4 $2130
line 4746
;4746:					listPtr->drawPadding = elementHeight - size;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 12
INDIRF4
ADDRLP4 24
INDIRF4
SUBF4
CVFI4 4
ASGNI4
line 4747
;4747:					break;
ADDRGP4 $2110
JUMPV
LABELV $2130
line 4749
;4748:				}
;4749:				listPtr->endPos++;
ADDRLP4 100
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4750
;4750:				y += elementHeight;
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ASGNF4
line 4752
;4751:				// fit++;
;4752:			}
LABELV $2109
line 4688
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2111
ADDRLP4 4
INDIRI4
ADDRLP4 32
INDIRI4
LTI4 $2108
LABELV $2110
line 4753
;4753:		}
LABELV $2097
line 4754
;4754:	}
LABELV $2079
line 4755
;4755:}
LABELV $2050
endproc Item_ListBox_Paint 120 40
proc Item_OwnerDraw_Paint 88 72
line 4758
;4756:
;4757:
;4758:static void Item_OwnerDraw_Paint(itemDef_t *item) {
line 4759
;4759:	int menuWidescreen = WIDESCREEN_STRETCH;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 4761
;4760:
;4761:	if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2133
line 4762
;4762:		return;
ADDRGP4 $2132
JUMPV
LABELV $2133
line 4765
;4763:	}
;4764:
;4765:	if (DC->ownerDrawItem) {
ADDRGP4 DC
INDIRP4
CNSTI4 68
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2135
line 4767
;4766:		vec4_t color, lowLight;
;4767:		menuDef_t *parent = (menuDef_t *)item->parent;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 4770
;4768:		rectDef_t menuRect;
;4769:
;4770:		if (parent == NULL) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2137
line 4771
;4771:			Com_Printf("^3FIXME check ItemOwnerDraw_Paint parent is null\n");
ADDRGP4 $2139
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4772
;4772:		} else {
ADDRGP4 $2138
JUMPV
LABELV $2137
line 4773
;4773:			menuWidescreen = parent->widescreen;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 4364
ADDP4
INDIRI4
ASGNI4
line 4774
;4774:			menuRect = parent->window.rect;
ADDRLP4 40
ADDRLP4 4
INDIRP4
INDIRB
ASGNB 16
line 4775
;4775:		}
LABELV $2138
line 4777
;4776:
;4777:		Fade(&item->window.flags, &item->window.foreColor[3], parent->fadeClamp, &item->window.nextTime, parent->fadeCycle, qtrue, parent->fadeAmount);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 72
ADDP4
ARGP4
ADDRLP4 56
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRGP4 Fade
CALLV
pop
line 4778
;4778:		memcpy(&color, &item->window.foreColor, sizeof(color));
ADDRLP4 8
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 4779
;4779:		if (item->numColors > 0 && DC->getValue) {
ADDRFP4 0
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
CNSTI4 0
LEI4 $2140
ADDRGP4 DC
INDIRP4
CNSTI4 72
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2140
line 4782
;4780:			// if the value is within one of the ranges then set color to that, otherwise leave at default
;4781:			int i;
;4782:			float f = DC->getValue(item->window.ownerDraw);
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
ADDRGP4 DC
INDIRP4
CNSTI4 72
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 68
ADDRLP4 72
INDIRF4
ASGNF4
line 4783
;4783:			for (i = 0; i < item->numColors; i++) {
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRGP4 $2145
JUMPV
LABELV $2142
line 4784
;4784:				if (f >= item->colorRanges[i].low && f <= item->colorRanges[i].high) {
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRF4
ADDRLP4 64
INDIRI4
CNSTI4 24
MULI4
ADDRLP4 84
INDIRP4
CNSTI4 320
ADDP4
ADDP4
CNSTI4 16
ADDP4
INDIRF4
LTF4 $2146
ADDRLP4 68
INDIRF4
ADDRLP4 64
INDIRI4
CNSTI4 24
MULI4
ADDRLP4 84
INDIRP4
CNSTI4 320
ADDP4
ADDP4
CNSTI4 20
ADDP4
INDIRF4
GTF4 $2146
line 4785
;4785:					memcpy(&color, &item->colorRanges[i].color, sizeof(color));
ADDRLP4 8
ARGP4
ADDRLP4 64
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 320
ADDP4
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 4786
;4786:					break;
ADDRGP4 $2144
JUMPV
LABELV $2146
line 4788
;4787:				}
;4788:			}
LABELV $2143
line 4783
ADDRLP4 64
ADDRLP4 64
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2145
ADDRLP4 64
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
LTI4 $2142
LABELV $2144
line 4789
;4789:		}
LABELV $2140
line 4791
;4790:
;4791:		if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $2148
line 4792
;4792:			lowLight[0] = 0.8 * parent->focusColor[0];
ADDRLP4 24
ADDRLP4 4
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 4793
;4793:			lowLight[1] = 0.8 * parent->focusColor[1];
ADDRLP4 24+4
ADDRLP4 4
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 4794
;4794:			lowLight[2] = 0.8 * parent->focusColor[2];
ADDRLP4 24+8
ADDRLP4 4
INDIRP4
CNSTI4 244
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 4795
;4795:			lowLight[3] = 0.8 * parent->focusColor[3];
ADDRLP4 24+12
ADDRLP4 4
INDIRP4
CNSTI4 248
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 4796
;4796:			LerpColor(parent->focusColor, lowLight, color, 0.5 + 0.5 * sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 64
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 236
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 64
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 4797
;4797:		} else if (item->textStyle == ITEM_TEXTSTYLE_BLINK && !((DC->realTime / BLINK_DIVISOR) & 1)) {
ADDRGP4 $2149
JUMPV
LABELV $2148
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 1
NEI4 $2153
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 200
DIVI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $2153
line 4798
;4798:			lowLight[0] = 0.8 * item->window.foreColor[0];
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 4799
;4799:			lowLight[1] = 0.8 * item->window.foreColor[1];
ADDRLP4 24+4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 4800
;4800:			lowLight[2] = 0.8 * item->window.foreColor[2];
ADDRLP4 24+8
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 4801
;4801:			lowLight[3] = 0.8 * item->window.foreColor[3];
ADDRLP4 24+12
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 4802
;4802:			LerpColor(item->window.foreColor, lowLight, color, 0.5 + 0.5 * sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 64
ADDRGP4 sin
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 64
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 4803
;4803:		}
LABELV $2153
LABELV $2149
line 4805
;4804:
;4805:		if (item->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(item, CVAR_ENABLE)) {
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $2158
ADDRLP4 64
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 68
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $2158
line 4806
;4806:			Com_Memcpy(color, parent->disableColor, sizeof(vec4_t));
ADDRLP4 8
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 252
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 4807
;4807:		}
LABELV $2158
line 4811
;4808:
;4809:		//FIXME ((menuDef_t*)(item->parent))->widescreen check if parent is null
;4810:
;4811:		if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2160
line 4813
;4812:			//FIXME check widescreen here
;4813:			Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 4814
;4814:			if (item->text[0]) {
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $2162
line 4816
;4815:				// +8 is an offset kludge to properly align owner draw items that have text combined with them
;4816:				DC->ownerDrawItem(item->textRect.x + item->textRect.w + 8, item->window.rect.y, item->window.rect.w, item->window.rect.h, 0, item->textaligny, item->window.ownerDraw, item->window.ownerDrawFlags, item->window.ownerDrawFlags2, item->alignment, item->special, item->textscale, color, item->window.background, item->textStyle, item->fontIndex, menuWidescreen, item->widescreen); //, menuRect);
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 68
ADDP4
INDIRP4
CALLV
pop
line 4817
;4817:			} else {
ADDRGP4 $2161
JUMPV
LABELV $2162
line 4818
;4818:				DC->ownerDrawItem(item->textRect.x + item->textRect.w, item->window.rect.y, item->window.rect.w, item->window.rect.h, 0, item->textaligny, item->window.ownerDraw, item->window.ownerDrawFlags, item->window.ownerDrawFlags2, item->alignment, item->special, item->textscale, color, item->window.background, item->textStyle, item->fontIndex, menuWidescreen, item->widescreen); //, menuRect);
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 196
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTF4 0
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 68
ADDP4
INDIRP4
CALLV
pop
line 4819
;4819:			}
line 4820
;4820:		} else {
ADDRGP4 $2161
JUMPV
LABELV $2160
line 4821
;4821:			DC->ownerDrawItem(item->window.rect.x, item->window.rect.y, item->window.rect.w, item->window.rect.h, item->textalignx, item->textaligny, item->window.ownerDraw, item->window.ownerDrawFlags, item->window.ownerDrawFlags2, item->alignment, item->special, item->textscale, color, item->window.background, item->textStyle, item->fontIndex, menuWidescreen, item->widescreen); //, menuRect);
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
INDIRF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 220
ADDP4
INDIRF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 224
ADDP4
INDIRF4
ARGF4
ADDRLP4 8
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 68
ADDP4
INDIRP4
CALLV
pop
line 4822
;4822:		}
LABELV $2161
line 4823
;4823:	}
LABELV $2135
line 4824
;4824:}
LABELV $2132
endproc Item_OwnerDraw_Paint 88 72
proc Item_Paint 100 28
line 4826
;4825:
;4826:static void Item_Paint(itemDef_t *item) {
line 4831
;4827:	vec4_t red;
;4828:	menuDef_t *parent;
;4829:	rectDef_t menuRect;
;4830:
;4831:	red[0] = red[3] = 1;
ADDRLP4 36
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+12
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 36
INDIRF4
ASGNF4
line 4832
;4832:	red[1] = red[2] = 0;
ADDRLP4 40
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 40
INDIRF4
ASGNF4
line 4834
;4833:
;4834:	if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2168
line 4835
;4835:		return;
ADDRGP4 $2164
JUMPV
LABELV $2168
line 4838
;4836:	}
;4837:
;4838:	if (item->parent) {
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2170
line 4839
;4839:		menuRect = ((menuDef_t *)item->parent)->window.rect;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
INDIRB
ASGNB 16
line 4840
;4840:	}
LABELV $2170
line 4841
;4841:	if (item->run) {
ADDRFP4 0
INDIRP4
CNSTI4 252
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2172
line 4844
;4842:		//UseScriptBuffer = qtrue;
;4843:		//ScriptBuffer = (char *)item->run;
;4844:		Item_RunFrameScript(item, item->run);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 252
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunFrameScript
CALLV
pop
line 4845
;4845:		Item_UpdatePosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_UpdatePosition
CALLV
pop
line 4847
;4846:		//Com_Printf("name %s\n", item->window.name);
;4847:	}
LABELV $2172
line 4849
;4848:
;4849:	parent = (menuDef_t *)item->parent;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ASGNP4
line 4851
;4850:
;4851:	if (item->window.flags & WINDOW_ORBITING) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 65536
BANDI4
CNSTI4 0
EQI4 $2174
line 4852
;4852:		if (DC->realTime > item->window.nextTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
LEI4 $2176
line 4855
;4853:			float rx, ry, a, c, s, w, h;
;4854:
;4855:			item->window.nextTime = DC->realTime + item->window.offsetTime;
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ADDRLP4 72
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ADDI4
ASGNI4
line 4857
;4856:			// translate
;4857:			w = item->window.rectClient.w / 2;
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 4858
;4858:			h = item->window.rectClient.h / 2;
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 4859
;4859:			rx = item->window.rectClient.x + w - item->window.rectEffects.x;
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
ADDRLP4 76
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 64
INDIRF4
ADDF4
ADDRLP4 76
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4860
;4860:			ry = item->window.rectClient.y + h - item->window.rectEffects.y;
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
ADDRLP4 80
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 68
INDIRF4
ADDF4
ADDRLP4 80
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4861
;4861:			a = 3 * M_PI / 180;
ADDRLP4 52
CNSTF4 1029076816
ASGNF4
line 4862
;4862:			c = cos(a);
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 84
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 56
ADDRLP4 84
INDIRF4
ASGNF4
line 4863
;4863:			s = sin(a);
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 88
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 60
ADDRLP4 88
INDIRF4
ASGNF4
line 4864
;4864:			item->window.rectClient.x = (rx * c - ry * s) + item->window.rectEffects.x - w;
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 44
INDIRF4
ADDRLP4 56
INDIRF4
MULF4
ADDRLP4 48
INDIRF4
ADDRLP4 60
INDIRF4
MULF4
SUBF4
ADDRLP4 92
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ADDF4
ADDRLP4 64
INDIRF4
SUBF4
ASGNF4
line 4865
;4865:			item->window.rectClient.y = (rx * s + ry * c) + item->window.rectEffects.y - h;
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 44
INDIRF4
ADDRLP4 60
INDIRF4
MULF4
ADDRLP4 48
INDIRF4
ADDRLP4 56
INDIRF4
MULF4
ADDF4
ADDRLP4 96
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ADDF4
ADDRLP4 68
INDIRF4
SUBF4
ASGNF4
line 4866
;4866:			Item_UpdatePosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_UpdatePosition
CALLV
pop
line 4868
;4867:
;4868:		}
LABELV $2176
line 4869
;4869:	}
LABELV $2174
line 4872
;4870:
;4871:
;4872:	if (item->window.flags & WINDOW_INTRANSITION) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $2178
line 4873
;4873:		if (DC->realTime > item->window.nextTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
LEI4 $2180
line 4874
;4874:			int done = 0;
ADDRLP4 44
CNSTI4 0
ASGNI4
line 4875
;4875:			item->window.nextTime = DC->realTime + item->window.offsetTime;
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ADDRLP4 48
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ADDI4
ASGNI4
line 4878
;4876:			// transition the x,y
;4877:
;4878:			if (item->window.rectClient.x == item->window.rectEffects.x) {
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
NEF4 $2182
line 4879
;4879:				done++;
ADDRLP4 44
ADDRLP4 44
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4880
;4880:			} else {
ADDRGP4 $2183
JUMPV
LABELV $2182
line 4881
;4881:				if (item->window.rectClient.x < item->window.rectEffects.x) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
GEF4 $2184
line 4882
;4882:					item->window.rectClient.x += item->window.rectEffects2.x;
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 60
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDF4
ASGNF4
line 4883
;4883:					if (item->window.rectClient.x > item->window.rectEffects.x) {
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 68
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
LEF4 $2185
line 4884
;4884:						item->window.rectClient.x = item->window.rectEffects.x;
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ASGNF4
line 4885
;4885:						done++;
ADDRLP4 44
ADDRLP4 44
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4886
;4886:					}
line 4887
;4887:				} else {
ADDRGP4 $2185
JUMPV
LABELV $2184
line 4888
;4888:					item->window.rectClient.x -= item->window.rectEffects2.x;
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 60
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4889
;4889:					if (item->window.rectClient.x < item->window.rectEffects.x) {
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 68
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
GEF4 $2188
line 4890
;4890:						item->window.rectClient.x = item->window.rectEffects.x;
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ASGNF4
line 4891
;4891:						done++;
ADDRLP4 44
ADDRLP4 44
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4892
;4892:					}
LABELV $2188
line 4893
;4893:				}
LABELV $2185
line 4894
;4894:			}
LABELV $2183
line 4895
;4895:			if (item->window.rectClient.y == item->window.rectEffects.y) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
NEF4 $2190
line 4896
;4896:				done++;
ADDRLP4 44
ADDRLP4 44
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4897
;4897:			} else {
ADDRGP4 $2191
JUMPV
LABELV $2190
line 4898
;4898:				if (item->window.rectClient.y < item->window.rectEffects.y) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
GEF4 $2192
line 4899
;4899:					item->window.rectClient.y += item->window.rectEffects2.y;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDF4
ASGNF4
line 4900
;4900:					if (item->window.rectClient.y > item->window.rectEffects.y) {
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
LEF4 $2193
line 4901
;4901:						item->window.rectClient.y = item->window.rectEffects.y;
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 76
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ASGNF4
line 4902
;4902:						done++;
ADDRLP4 44
ADDRLP4 44
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4903
;4903:					}
line 4904
;4904:				} else {
ADDRGP4 $2193
JUMPV
LABELV $2192
line 4905
;4905:					item->window.rectClient.y -= item->window.rectEffects2.y;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4906
;4906:					if (item->window.rectClient.y < item->window.rectEffects.y) {
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
GEF4 $2196
line 4907
;4907:						item->window.rectClient.y = item->window.rectEffects.y;
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 76
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ASGNF4
line 4908
;4908:						done++;
ADDRLP4 44
ADDRLP4 44
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4909
;4909:					}
LABELV $2196
line 4910
;4910:				}
LABELV $2193
line 4911
;4911:			}
LABELV $2191
line 4912
;4912:			if (item->window.rectClient.w == item->window.rectEffects.w) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
NEF4 $2198
line 4913
;4913:				done++;
ADDRLP4 44
ADDRLP4 44
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4914
;4914:			} else {
ADDRGP4 $2199
JUMPV
LABELV $2198
line 4915
;4915:				if (item->window.rectClient.w < item->window.rectEffects.w) {
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
GEF4 $2200
line 4916
;4916:					item->window.rectClient.w += item->window.rectEffects2.w;
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 68
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDF4
ASGNF4
line 4917
;4917:					if (item->window.rectClient.w > item->window.rectEffects.w) {
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
LEF4 $2201
line 4918
;4918:						item->window.rectClient.w = item->window.rectEffects.w;
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 80
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ASGNF4
line 4919
;4919:						done++;
ADDRLP4 44
ADDRLP4 44
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4920
;4920:					}
line 4921
;4921:				} else {
ADDRGP4 $2201
JUMPV
LABELV $2200
line 4922
;4922:					item->window.rectClient.w -= item->window.rectEffects2.w;
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 68
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4923
;4923:					if (item->window.rectClient.w < item->window.rectEffects.w) {
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 76
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
GEF4 $2204
line 4924
;4924:						item->window.rectClient.w = item->window.rectEffects.w;
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 80
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ASGNF4
line 4925
;4925:						done++;
ADDRLP4 44
ADDRLP4 44
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4926
;4926:					}
LABELV $2204
line 4927
;4927:				}
LABELV $2201
line 4928
;4928:			}
LABELV $2199
line 4929
;4929:			if (item->window.rectClient.h == item->window.rectEffects.h) {
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
NEF4 $2206
line 4930
;4930:				done++;
ADDRLP4 44
ADDRLP4 44
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4931
;4931:			} else {
ADDRGP4 $2207
JUMPV
LABELV $2206
line 4932
;4932:				if (item->window.rectClient.h < item->window.rectEffects.h) {
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 68
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
GEF4 $2208
line 4933
;4933:					item->window.rectClient.h += item->window.rectEffects2.h;
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
ADDRLP4 72
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
ADDF4
ASGNF4
line 4934
;4934:					if (item->window.rectClient.h > item->window.rectEffects.h) {
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
LEF4 $2209
line 4935
;4935:						item->window.rectClient.h = item->window.rectEffects.h;
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
ASGNF4
line 4936
;4936:						done++;
ADDRLP4 44
ADDRLP4 44
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4937
;4937:					}
line 4938
;4938:				} else {
ADDRGP4 $2209
JUMPV
LABELV $2208
line 4939
;4939:					item->window.rectClient.h -= item->window.rectEffects2.h;
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
ADDRLP4 72
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRLP4 72
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4940
;4940:					if (item->window.rectClient.h < item->window.rectEffects.h) {
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
GEF4 $2212
line 4941
;4941:						item->window.rectClient.h = item->window.rectEffects.h;
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
ASGNF4
line 4942
;4942:						done++;
ADDRLP4 44
ADDRLP4 44
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4943
;4943:					}
LABELV $2212
line 4944
;4944:				}
LABELV $2209
line 4945
;4945:			}
LABELV $2207
line 4947
;4946:
;4947:			Item_UpdatePosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_UpdatePosition
CALLV
pop
line 4949
;4948:
;4949:			if (done == 4) {
ADDRLP4 44
INDIRI4
CNSTI4 4
NEI4 $2214
line 4950
;4950:				item->window.flags &= ~WINDOW_INTRANSITION;
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 4951
;4951:			}
LABELV $2214
line 4953
;4952:
;4953:		}
LABELV $2180
line 4954
;4954:	}
LABELV $2178
line 4956
;4955:
;4956:	if ((item->window.ownerDrawFlags || item->window.ownerDrawFlags2) && DC->ownerDrawVisible) {
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2218
ADDRLP4 44
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2216
LABELV $2218
ADDRGP4 DC
INDIRP4
CNSTI4 76
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2216
line 4957
;4957:		if (!DC->ownerDrawVisible(item->window.ownerDrawFlags, item->window.ownerDrawFlags2)) {
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
CNSTI4 76
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $2219
line 4958
;4958:			item->window.flags &= ~WINDOW_VISIBLE;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 -5
BANDI4
ASGNI4
line 4959
;4959:		} else {
ADDRGP4 $2220
JUMPV
LABELV $2219
line 4960
;4960:			item->window.flags |= WINDOW_VISIBLE;
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 4961
;4961:		}
LABELV $2220
line 4962
;4962:	}
LABELV $2216
line 4964
;4963:
;4964:	if (item->cvarFlags & (CVAR_SHOW | CVAR_HIDE)) {
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $2221
line 4965
;4965:		if (!Item_EnableShowViaCvar(item, CVAR_SHOW)) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 48
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $2223
line 4966
;4966:			return;
ADDRGP4 $2164
JUMPV
LABELV $2223
line 4968
;4967:		}
;4968:	}
LABELV $2221
line 4970
;4969:
;4970:	if (item->window.flags & WINDOW_TIMEDVISIBLE) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 8388608
BANDI4
CNSTI4 0
EQI4 $2225
line 4972
;4971:
;4972:	}
LABELV $2225
line 4974
;4973:
;4974:	if (!(item->window.flags & WINDOW_VISIBLE)) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $2227
line 4975
;4975:		return;
ADDRGP4 $2164
JUMPV
LABELV $2227
line 4979
;4976:	}
;4977:
;4978:	// paint the rect first.. 
;4979:	Window_Paint(&item->window, parent->fadeAmount, parent->fadeClamp, parent->fadeCycle, item->widescreen); //, menuRect);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 48
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 Window_Paint
CALLV
pop
line 4981
;4980:
;4981:	if (debugMode) {
ADDRGP4 debugMode
INDIRI4
CNSTI4 0
EQI4 $2229
line 4983
;4982:		vec4_t color;
;4983:		rectDef_t *r = Item_CorrectedTextRect(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 Item_CorrectedTextRect
CALLP4
ASGNP4
ADDRLP4 56
ADDRLP4 76
INDIRP4
ASGNP4
line 4984
;4984:		color[1] = color[3] = 1;
ADDRLP4 80
CNSTF4 1065353216
ASGNF4
ADDRLP4 60+12
ADDRLP4 80
INDIRF4
ASGNF4
ADDRLP4 60+4
ADDRLP4 80
INDIRF4
ASGNF4
line 4985
;4985:		color[0] = color[2] = 0;
ADDRLP4 84
CNSTF4 0
ASGNF4
ADDRLP4 60+8
ADDRLP4 84
INDIRF4
ASGNF4
ADDRLP4 60
ADDRLP4 84
INDIRF4
ASGNF4
line 4986
;4986:		DC->drawRect(r->x, r->y, r->w, r->h, 1, color, item->widescreen); //, menuRect);
ADDRLP4 56
INDIRP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 60
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 4987
;4987:	}
LABELV $2229
line 4991
;4988:
;4989:	//DC->drawRect(item->window.rect.x, item->window.rect.y, item->window.rect.w, item->window.rect.h, 1, red, item->widescreen);
;4990:
;4991:	switch (item->type) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
LTI4 $2235
ADDRLP4 56
INDIRI4
CNSTI4 14
GTI4 $2235
ADDRLP4 56
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2251
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $2251
address $2238
address $2238
address $2235
address $2235
address $2241
address $2235
address $2243
address $2244
address $2237
address $2241
address $2250
address $2245
address $2246
address $2247
address $2248
code
LABELV $2237
line 4993
;4992:	case ITEM_TYPE_OWNERDRAW:
;4993:		Item_OwnerDraw_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_OwnerDraw_Paint
CALLV
pop
line 4994
;4994:		break;
ADDRGP4 $2235
JUMPV
LABELV $2238
line 4997
;4995:	case ITEM_TYPE_TEXT:
;4996:	case ITEM_TYPE_BUTTON:
;4997:		Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 4998
;4998:		break;
ADDRGP4 $2235
JUMPV
line 5000
;4999:	case ITEM_TYPE_RADIOBUTTON:
;5000:		break;
line 5002
;5001:	case ITEM_TYPE_CHECKBOX:
;5002:		break;
LABELV $2241
line 5005
;5003:	case ITEM_TYPE_EDITFIELD:
;5004:	case ITEM_TYPE_NUMERICFIELD:
;5005:		Item_TextField_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_TextField_Paint
CALLV
pop
line 5006
;5006:		break;
ADDRGP4 $2235
JUMPV
line 5008
;5007:	case ITEM_TYPE_COMBO:
;5008:		break;
LABELV $2243
line 5010
;5009:	case ITEM_TYPE_LISTBOX:
;5010:		Item_ListBox_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ListBox_Paint
CALLV
pop
line 5011
;5011:		break;
ADDRGP4 $2235
JUMPV
LABELV $2244
line 5016
;5012:		//case ITEM_TYPE_IMAGE:
;5013:		//  Item_Image_Paint(item);
;5014:		//  break;
;5015:	case ITEM_TYPE_MODEL:
;5016:		Item_Model_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Model_Paint
CALLV
pop
line 5017
;5017:		break;
ADDRGP4 $2235
JUMPV
LABELV $2245
line 5019
;5018:	case ITEM_TYPE_YESNO:
;5019:		Item_YesNo_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_YesNo_Paint
CALLV
pop
line 5020
;5020:		break;
ADDRGP4 $2235
JUMPV
LABELV $2246
line 5022
;5021:	case ITEM_TYPE_MULTI:
;5022:		Item_Multi_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Multi_Paint
CALLV
pop
line 5023
;5023:		break;
ADDRGP4 $2235
JUMPV
LABELV $2247
line 5025
;5024:	case ITEM_TYPE_BIND:
;5025:		Item_Bind_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Bind_Paint
CALLV
pop
line 5026
;5026:		break;
ADDRGP4 $2235
JUMPV
LABELV $2248
line 5028
;5027:	case ITEM_TYPE_SLIDER_COLOR:
;5028:		Com_Printf("FIXME item paint()  ITEM_TYPE_SLIDER_COLOR\n");
ADDRGP4 $2249
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
LABELV $2250
line 5030
;5029:	case ITEM_TYPE_SLIDER:
;5030:		Item_Slider_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Slider_Paint
CALLV
pop
line 5031
;5031:		break;
line 5033
;5032:	default:
;5033:		break;
LABELV $2235
line 5036
;5034:	}
;5035:
;5036:}
LABELV $2164
endproc Item_Paint 100 28
export Menu_Init
proc Menu_Init 0 12
line 5038
;5037:
;5038:void Menu_Init(menuDef_t *menu) {
line 5039
;5039:	memset(menu, 0, sizeof(menuDef_t));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 5040
;5040:	menu->cursorItem = -1;
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 -1
ASGNI4
line 5041
;5041:	menu->fadeAmount = DC->Assets.fadeAmount;
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 5342808
ADDP4
INDIRF4
ASGNF4
line 5042
;5042:	menu->fadeClamp = DC->Assets.fadeClamp;
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 5342800
ADDP4
INDIRF4
ASGNF4
line 5043
;5043:	menu->fadeCycle = DC->Assets.fadeCycle;
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 5342804
ADDP4
INDIRI4
ASGNI4
line 5046
;5044:
;5045:	// 2018-07-12 this uses a global variable to allow changing the default for certain menus.  Quake Live uses WIDESCREEN_STRETCH as the default for user huds (cg_hudFiles) but appears to force WIDESCREEN_CENTER for the default (and possiply other) menus.
;5046:	menu->widescreen = DefaultWideScreenValue;
ADDRFP4 0
INDIRP4
CNSTI4 4364
ADDP4
ADDRGP4 DefaultWideScreenValue
INDIRI4
ASGNI4
line 5047
;5047:	Window_Init(&menu->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_Init
CALLV
pop
line 5048
;5048:}
LABELV $2252
endproc Menu_Init 0 12
export Menu_GetFocused
proc Menu_GetFocused 8 0
line 5065
;5049:
;5050:// unused
;5051:#if 0
;5052:static itemDef_t *Menu_GetFocusedItem(menuDef_t *menu) {
;5053:	int i;
;5054:	if (menu) {
;5055:		for (i = 0; i < menu->itemCount; i++) {
;5056:			if (menu->items[i]->window.flags & WINDOW_HASFOCUS) {
;5057:				return menu->items[i];
;5058:			}
;5059:		}
;5060:	}
;5061:	return NULL;
;5062:}
;5063:#endif
;5064:
;5065:menuDef_t *Menu_GetFocused(void) {
line 5068
;5066:	int i;
;5067:
;5068:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2257
JUMPV
LABELV $2254
line 5071
;5069:		//Com_Printf("%d focus %d  visible %d   '%s'\n", i, Menus[i].window.flags & WINDOW_HASFOCUS, Menus[i].window.flags & WINDOW_VISIBLE, Menus[i].window.name);
;5070:
;5071:		if (Menus[i].window.flags & WINDOW_HASFOCUS && Menus[i].window.flags & WINDOW_VISIBLE) {
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus+72
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $2258
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus+72
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $2258
line 5072
;5072:			return &Menus[i];
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus
ADDP4
RETP4
ADDRGP4 $2253
JUMPV
LABELV $2258
line 5074
;5073:		}
;5074:	}
LABELV $2255
line 5068
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2257
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $2254
line 5075
;5075:	return NULL;
CNSTP4 0
RETP4
LABELV $2253
endproc Menu_GetFocused 8 0
export Menu_ScrollFeeder
proc Menu_ScrollFeeder 8 16
line 5078
;5076:}
;5077:
;5078:void Menu_ScrollFeeder(menuDef_t *menu, int feeder, qboolean down) {
line 5079
;5079:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2263
line 5081
;5080:		int i;
;5081:		for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2268
JUMPV
LABELV $2265
line 5082
;5082:			if (menu->items[i]->special == feeder) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
ADDRFP4 4
INDIRI4
CVIF4 4
NEF4 $2269
line 5083
;5083:				Item_ListBox_HandleKey(menu->items[i], (down) ? K_DOWNARROW : K_UPARROW, qtrue, qtrue);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $2272
ADDRLP4 4
CNSTI4 133
ASGNI4
ADDRGP4 $2273
JUMPV
LABELV $2272
ADDRLP4 4
CNSTI4 132
ASGNI4
LABELV $2273
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 Item_ListBox_HandleKey
CALLI4
pop
line 5084
;5084:				return;
ADDRGP4 $2262
JUMPV
LABELV $2269
line 5086
;5085:			}
;5086:		}
LABELV $2266
line 5081
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2268
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
LTI4 $2265
line 5087
;5087:	}
LABELV $2263
line 5088
;5088:}
LABELV $2262
endproc Menu_ScrollFeeder 8 16
export Menu_SetFeederSelection
proc Menu_SetFeederSelection 12 8
line 5092
;5089:
;5090:
;5091:
;5092:void Menu_SetFeederSelection(menuDef_t *menu, int feeder, int index, const char *name) {
line 5093
;5093:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2275
line 5094
;5094:		if (name == NULL) {
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2277
line 5095
;5095:			menu = Menu_GetFocused();
ADDRLP4 0
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRFP4 0
ADDRLP4 0
INDIRP4
ASGNP4
line 5096
;5096:		} else {
ADDRGP4 $2278
JUMPV
LABELV $2277
line 5097
;5097:			menu = Menus_FindByName(name);
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRFP4 0
ADDRLP4 0
INDIRP4
ASGNP4
line 5098
;5098:		}
LABELV $2278
line 5099
;5099:	}
LABELV $2275
line 5101
;5100:
;5101:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2279
line 5103
;5102:		int i;
;5103:		for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2284
JUMPV
LABELV $2281
line 5104
;5104:			if (menu->items[i]->special == feeder) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
ADDRFP4 4
INDIRI4
CVIF4 4
NEF4 $2285
line 5105
;5105:				if (index == 0) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $2287
line 5106
;5106:					listBoxDef_t *listPtr = (listBoxDef_t *)menu->items[i]->typeData;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 5107
;5107:					listPtr->cursorPos = 0;
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 5108
;5108:					listPtr->startPos = 0;
ADDRLP4 4
INDIRP4
CNSTI4 0
ASGNI4
line 5109
;5109:				}
LABELV $2287
line 5110
;5110:				menu->items[i]->cursorPos = index;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 564
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 5111
;5111:				DC->feederSelection(menu->items[i]->special, menu->items[i]->cursorPos);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 560
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 136
ADDP4
INDIRP4
CALLV
pop
line 5112
;5112:				return;
ADDRGP4 $2274
JUMPV
LABELV $2285
line 5114
;5113:			}
;5114:		}
LABELV $2282
line 5103
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2284
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
LTI4 $2281
line 5115
;5115:	}
LABELV $2279
line 5116
;5116:}
LABELV $2274
endproc Menu_SetFeederSelection 12 8
export Menus_AnyFullScreenVisible
proc Menus_AnyFullScreenVisible 8 0
line 5118
;5117:
;5118:qboolean Menus_AnyFullScreenVisible(void) {
line 5120
;5119:	int i;
;5120:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2293
JUMPV
LABELV $2290
line 5121
;5121:		if (Menus[i].window.flags & WINDOW_VISIBLE && Menus[i].fullScreen) {
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus+72
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $2294
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus+192
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2294
line 5122
;5122:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2289
JUMPV
LABELV $2294
line 5124
;5123:		}
;5124:	}
LABELV $2291
line 5120
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2293
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $2290
line 5125
;5125:	return qfalse;
CNSTI4 0
RETI4
LABELV $2289
endproc Menus_AnyFullScreenVisible 8 0
export Menus_ActivateByName
proc Menus_ActivateByName 28 8
line 5128
;5126:}
;5127:
;5128:menuDef_t *Menus_ActivateByName(const char *p) {
line 5130
;5129:	int i;
;5130:	menuDef_t *m = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 5132
;5131:	//menuDef_t *focus = Menu_GetFocused();
;5132:	menuDef_t *focus = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 5134
;5133:
;5134:	focus = Menu_GetFocused();
ADDRLP4 12
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 5136
;5135:
;5136:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2302
JUMPV
LABELV $2299
line 5137
;5137:		if (Q_stricmp(Menus[i].window.name, p) == 0) {
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus+32
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $2303
line 5138
;5138:			m = &Menus[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus
ADDP4
ASGNP4
line 5139
;5139:			Menus_Activate(m);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Menus_Activate
CALLV
pop
line 5141
;5140:			//focus = Menu_GetFocused();
;5141:			if (openMenuCount < MAX_OPEN_MENUS && focus != NULL) {
ADDRGP4 openMenuCount
INDIRI4
CNSTI4 256
GEI4 $2306
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2306
line 5142
;5142:				menuStack[openMenuCount++] = focus;
ADDRLP4 24
ADDRGP4 openMenuCount
ASGNP4
ADDRLP4 20
ADDRLP4 24
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRP4
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 menuStack
ADDP4
ADDRLP4 8
INDIRP4
ASGNP4
line 5144
;5143:				//Com_Printf("^6activated '%s'\n", p);
;5144:			} else {
ADDRGP4 $2304
JUMPV
LABELV $2306
line 5145
;5145:				if (focus == NULL) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2308
line 5146
;5146:					Com_Printf(S_COLOR_RED "ERROR: Menus_ActivateByName: focus == NULL\n");
ADDRGP4 $2310
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 5147
;5147:				} else {
ADDRGP4 $2304
JUMPV
LABELV $2308
line 5148
;5148:					Com_Printf(S_COLOR_RED "ERROR: Menus_ActivateByName: MAX_OPEN_MENUS (%d)\n", MAX_OPEN_MENUS);
ADDRGP4 $2311
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 5149
;5149:				}
line 5150
;5150:			}
line 5151
;5151:		} else {
ADDRGP4 $2304
JUMPV
LABELV $2303
line 5152
;5152:			Menus[i].window.flags &= ~WINDOW_HASFOCUS;
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus+72
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 5153
;5153:		}
LABELV $2304
line 5154
;5154:	}
LABELV $2300
line 5136
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2302
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $2299
line 5156
;5155:
;5156:	Display_CloseCinematics();
ADDRGP4 Display_CloseCinematics
CALLV
pop
line 5157
;5157:	return m;
ADDRLP4 4
INDIRP4
RETP4
LABELV $2298
endproc Menus_ActivateByName 28 8
export Item_Init
proc Item_Init 0 12
line 5161
;5158:}
;5159:
;5160:
;5161:void Item_Init(itemDef_t *item) {
line 5162
;5162:	if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2314
line 5163
;5163:		Com_Printf("^1ERROR Item_Init item == null\n");
ADDRGP4 $2316
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 5164
;5164:		return;
ADDRGP4 $2313
JUMPV
LABELV $2314
line 5167
;5165:	}
;5166:
;5167:	memset(item, 0, sizeof(itemDef_t));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 580
ARGI4
ADDRGP4 memset
CALLP4
pop
line 5168
;5168:	item->textscale = 0.55f;  // 2018-07-22 this matches quake live
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
CNSTF4 1057803469
ASGNF4
line 5169
;5169:	Window_Init(&item->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_Init
CALLV
pop
line 5170
;5170:}
LABELV $2313
endproc Item_Init 0 12
export Menu_HandleMouseMove
proc Menu_HandleMouseMove 64 16
line 5172
;5171:
;5172:void Menu_HandleMouseMove(menuDef_t *menu, float x, float y) {
line 5174
;5173:	int i, pass;
;5174:	qboolean focusSet = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 5177
;5175:
;5176:	itemDef_t *overItem;
;5177:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2318
line 5178
;5178:		return;
ADDRGP4 $2317
JUMPV
LABELV $2318
line 5181
;5179:	}
;5180:
;5181:	if (!(menu->window.flags & (WINDOW_VISIBLE | WINDOW_FORCED))) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
NEI4 $2320
line 5182
;5182:		return;
ADDRGP4 $2317
JUMPV
LABELV $2320
line 5185
;5183:	}
;5184:
;5185:	if (itemCapture) {
ADDRGP4 itemCapture
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2322
line 5187
;5186:		//Item_MouseMove(itemCapture, x, y);
;5187:		return;
ADDRGP4 $2317
JUMPV
LABELV $2322
line 5190
;5188:	}
;5189:
;5190:	if (g_waitingForKey || g_editingField) {
ADDRGP4 g_waitingForKey
INDIRI4
CNSTI4 0
NEI4 $2326
ADDRGP4 g_editingField
INDIRI4
CNSTI4 0
EQI4 $2324
LABELV $2326
line 5191
;5191:		return;
ADDRGP4 $2317
JUMPV
LABELV $2324
line 5196
;5192:	}
;5193:
;5194:	// FIXME: this is the whole issue of focus vs. mouse over.. 
;5195:	// need a better overall solution as i don't like going through everything twice
;5196:	for (pass = 0; pass < 2; pass++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $2327
line 5197
;5197:		for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2334
JUMPV
LABELV $2331
line 5201
;5198:			// turn off focus each item
;5199:			// menu->items[i].window.flags &= ~WINDOW_HASFOCUS;
;5200:
;5201:			if (!(menu->items[i]->window.flags & (WINDOW_VISIBLE | WINDOW_FORCED))) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
NEI4 $2335
line 5202
;5202:				continue;
ADDRGP4 $2332
JUMPV
LABELV $2335
line 5206
;5203:			}
;5204:
;5205:			// items can be enabled and disabled based on cvars
;5206:			if (menu->items[i]->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(menu->items[i], CVAR_ENABLE)) {
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $2337
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 24
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $2337
line 5207
;5207:				continue;
ADDRGP4 $2332
JUMPV
LABELV $2337
line 5210
;5208:			}
;5209:
;5210:			if (menu->items[i]->cvarFlags & (CVAR_SHOW | CVAR_HIDE) && !Item_EnableShowViaCvar(menu->items[i], CVAR_SHOW)) {
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
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $2339
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 36
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $2339
line 5211
;5211:				continue;
ADDRGP4 $2332
JUMPV
LABELV $2339
line 5218
;5212:			}
;5213:
;5214:
;5215:
;5216:			//if (Rect_ContainsPoint(&menu->items[i]->window.rect, x, y)) {
;5217:			//if (Item_ContainsPoint(menu->items[i], x, y)) {
;5218:			if (Rect_ContainsWidescreenPoint(&menu->items[i]->window.rect, x, y, menu->items[i]->widescreen)) {
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
CNSTI4 268
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 44
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $2341
line 5219
;5219:				if (pass == 1) {
ADDRLP4 8
INDIRI4
CNSTI4 1
NEI4 $2342
line 5220
;5220:					overItem = menu->items[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
ASGNP4
line 5221
;5221:					if (overItem->type == ITEM_TYPE_TEXT && overItem->text) {
ADDRLP4 4
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2345
ADDRLP4 4
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2345
line 5222
;5222:						if (!Rect_ContainsWidescreenPoint(Item_CorrectedTextRect(overItem), x, y, overItem->widescreen)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 Item_CorrectedTextRect
CALLP4
ASGNP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $2347
line 5223
;5223:							continue;
ADDRGP4 $2332
JUMPV
LABELV $2347
line 5225
;5224:						}
;5225:					}
LABELV $2345
line 5227
;5226:					// if we are over an item
;5227:					if (IsVisible(overItem->window.flags)) {
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 IsVisible
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $2342
line 5230
;5228:						//Com_Printf("overitem %p\n", overItem);
;5229:						// different one
;5230:						Item_MouseEnter(overItem, x, y);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRGP4 Item_MouseEnter
CALLV
pop
line 5234
;5231:						// Item_SetMouseOver(overItem, qtrue);
;5232:
;5233:						// if item is not a decoration see if it can take focus
;5234:						if (!focusSet) {
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2342
line 5235
;5235:							focusSet = Item_SetFocus(overItem, x, y);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 Item_SetFocus
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 60
INDIRI4
ASGNI4
line 5236
;5236:						}
line 5237
;5237:					}
line 5238
;5238:				}
line 5239
;5239:			} else if (menu->items[i] && menu->items[i]->window.flags & WINDOW_MOUSEOVER) {
ADDRGP4 $2342
JUMPV
LABELV $2341
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
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2353
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 56
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2353
line 5240
;5240:				Item_MouseLeave(menu->items[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_MouseLeave
CALLV
pop
line 5241
;5241:				Item_SetMouseOver(menu->items[i], qfalse);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Item_SetMouseOver
CALLV
pop
line 5242
;5242:			}
LABELV $2353
LABELV $2342
line 5243
;5243:		}
LABELV $2332
line 5197
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2334
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
LTI4 $2331
line 5244
;5244:	}
LABELV $2328
line 5196
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 2
LTI4 $2327
line 5246
;5245:
;5246:}
LABELV $2317
endproc Menu_HandleMouseMove 64 16
export Menu_Paint
proc Menu_Paint 48 28
line 5248
;5247:
;5248:void Menu_Paint(menuDef_t *menu, qboolean forcePaint) {
line 5251
;5249:	int i;
;5250:
;5251:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2356
line 5252
;5252:		return;
ADDRGP4 $2355
JUMPV
LABELV $2356
line 5257
;5253:	}
;5254:
;5255:	//FIXME menu->run script
;5256:
;5257:	if (!(menu->window.flags & WINDOW_VISIBLE) && !forcePaint) {
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $2358
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $2358
line 5258
;5258:		return;
ADDRGP4 $2355
JUMPV
LABELV $2358
line 5261
;5259:	}
;5260:
;5261:	if ((menu->window.ownerDrawFlags || menu->window.ownerDrawFlags2) && DC->ownerDrawVisible && !DC->ownerDrawVisible(menu->window.ownerDrawFlags, menu->window.ownerDrawFlags2)) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2362
ADDRLP4 4
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2360
LABELV $2362
ADDRLP4 8
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 76
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2360
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRLP4 8
INDIRP4
CNSTI4 76
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $2360
line 5262
;5262:		return;
ADDRGP4 $2355
JUMPV
LABELV $2360
line 5265
;5263:	}
;5264:
;5265:	if (forcePaint) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $2363
line 5266
;5266:		menu->window.flags |= WINDOW_FORCED;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1048576
BORI4
ASGNI4
line 5267
;5267:	}
LABELV $2363
line 5270
;5268:
;5269:	// draw the background if necessary
;5270:	if (menu->fullScreen) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2365
line 5273
;5271:		// implies a background shader
;5272:		// FIXME: make sure we have a default shader if fullscreen is set with no background
;5273:		DC->drawHandlePic(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, menu->window.background, menu->widescreen); //, menu->window.rect);
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
INDIRP4
CNSTI4 4364
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 5274
;5274:	} else if (menu->window.background) {
ADDRGP4 $2366
JUMPV
LABELV $2365
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2367
line 5277
;5275:		// this allows a background shader without being full screen
;5276:		//UI_DrawHandlePic(menu->window.rect.x, menu->window.rect.y, menu->window.rect.w, menu->window.rect.h, menu->backgroundShader);
;5277:	}
LABELV $2367
LABELV $2366
line 5280
;5278:
;5279:	// paint the background and or border
;5280:	Window_Paint(&menu->window, menu->fadeAmount, menu->fadeClamp, menu->fadeCycle, menu->widescreen); //, menu->window.rect);
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 4364
ADDP4
INDIRI4
ARGI4
ADDRGP4 Window_Paint
CALLV
pop
line 5282
;5281:
;5282:	for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2372
JUMPV
LABELV $2369
line 5283
;5283:		Item_Paint(menu->items[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_Paint
CALLV
pop
line 5284
;5284:	}
LABELV $2370
line 5282
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2372
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
LTI4 $2369
line 5286
;5285:
;5286:	if (debugMode) {
ADDRGP4 debugMode
INDIRI4
CNSTI4 0
EQI4 $2373
line 5288
;5287:		vec4_t color;
;5288:		color[0] = color[2] = color[3] = 1;
ADDRLP4 40
CNSTF4 1065353216
ASGNF4
ADDRLP4 24+12
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 24
ADDRLP4 40
INDIRF4
ASGNF4
line 5289
;5289:		color[1] = 0;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 5290
;5290:		DC->drawRect(menu->window.rect.x, menu->window.rect.y, menu->window.rect.w, menu->window.rect.h, 1, color, menu->widescreen); //, menu->window.rect);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 24
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 4364
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 5291
;5291:	}
LABELV $2373
line 5292
;5292:}
LABELV $2355
endproc Menu_Paint 48 28
proc Item_ValidateTypeData 8 12
line 5299
;5293:
;5294:/*
;5295:===============
;5296:Item_ValidateTypeData
;5297:===============
;5298:*/
;5299:static void Item_ValidateTypeData(itemDef_t *item) {
line 5300
;5300:	if (item->typeData) {
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2379
line 5301
;5301:		return;
ADDRGP4 $2378
JUMPV
LABELV $2379
line 5304
;5302:	}
;5303:
;5304:	if (item->type == ITEM_TYPE_LISTBOX) {
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 6
NEI4 $2381
line 5305
;5305:		item->typeData = UI_Alloc(sizeof(listBoxDef_t));
CNSTI4 476
ARGI4
ADDRLP4 0
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 5306
;5306:		memset(item->typeData, 0, sizeof(listBoxDef_t));
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 476
ARGI4
ADDRGP4 memset
CALLP4
pop
line 5307
;5307:	} else if (item->type == ITEM_TYPE_EDITFIELD || item->type == ITEM_TYPE_NUMERICFIELD || item->type == ITEM_TYPE_YESNO || item->type == ITEM_TYPE_BIND || item->type == ITEM_TYPE_SLIDER || item->type == ITEM_TYPE_SLIDER_COLOR || item->type == ITEM_TYPE_TEXT) {
ADDRGP4 $2382
JUMPV
LABELV $2381
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 4
EQI4 $2390
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 9
EQI4 $2390
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 11
EQI4 $2390
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 13
EQI4 $2390
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 10
EQI4 $2390
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 14
EQI4 $2390
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2383
LABELV $2390
line 5308
;5308:		item->typeData = UI_Alloc(sizeof(editFieldDef_t));
CNSTI4 28
ARGI4
ADDRLP4 4
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 5309
;5309:		memset(item->typeData, 0, sizeof(editFieldDef_t));
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 28
ARGI4
ADDRGP4 memset
CALLP4
pop
line 5310
;5310:		if (item->type == ITEM_TYPE_EDITFIELD) {
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 4
NEI4 $2384
line 5311
;5311:			if (!((editFieldDef_t *)item->typeData)->maxPaintChars) {
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2384
line 5312
;5312:				((editFieldDef_t *)item->typeData)->maxPaintChars = MAX_EDITFIELD;
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 256
ASGNI4
line 5313
;5313:			}
line 5314
;5314:		}
line 5315
;5315:	} else if (item->type == ITEM_TYPE_MULTI) {
ADDRGP4 $2384
JUMPV
LABELV $2383
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 12
NEI4 $2395
line 5316
;5316:		item->typeData = UI_Alloc(sizeof(multiDef_t));
CNSTI4 396
ARGI4
ADDRLP4 4
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 5317
;5317:	} else if (item->type == ITEM_TYPE_MODEL) {
ADDRGP4 $2396
JUMPV
LABELV $2395
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 7
NEI4 $2397
line 5318
;5318:		item->typeData = UI_Alloc(sizeof(modelDef_t));
CNSTI4 28
ARGI4
ADDRLP4 4
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 5319
;5319:	}
LABELV $2397
LABELV $2396
LABELV $2384
LABELV $2382
line 5320
;5320:}
LABELV $2378
endproc Item_ValidateTypeData 8 12
export KeywordHash_Key
proc KeywordHash_Key 20 0
line 5336
;5321:
;5322:/*
;5323:===============
;5324:Keyword Hash
;5325:===============
;5326:*/
;5327:
;5328:#define KEYWORDHASH_SIZE	512
;5329:
;5330:typedef struct keywordHash_s {
;5331:	char *keyword;
;5332:	qboolean(*func)(itemDef_t *item, int handle);
;5333:	struct keywordHash_s *next;
;5334:} keywordHash_t;
;5335:
;5336:int KeywordHash_Key(char *keyword) {
line 5339
;5337:	int hash, i;
;5338:
;5339:	hash = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 5340
;5340:	for (i = 0; keyword[i] != '\0'; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2403
JUMPV
LABELV $2400
line 5341
;5341:		if (keyword[i] >= 'A' && keyword[i] <= 'Z')
ADDRLP4 8
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 65
LTI4 $2404
ADDRLP4 8
INDIRI4
CNSTI4 90
GTI4 $2404
line 5342
;5342:			hash += (keyword[i] + ('a' - 'A')) * (119 + i);
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 32
ADDI4
ADDRLP4 0
INDIRI4
CNSTI4 119
ADDI4
MULI4
ADDI4
ASGNI4
ADDRGP4 $2405
JUMPV
LABELV $2404
line 5344
;5343:		else
;5344:			hash += keyword[i] * (119 + i);
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ADDRLP4 0
INDIRI4
CNSTI4 119
ADDI4
MULI4
ADDI4
ASGNI4
LABELV $2405
line 5345
;5345:	}
LABELV $2401
line 5340
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2403
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2400
line 5346
;5346:	hash = (hash ^ (hash >> 10) ^ (hash >> 20)) & (KEYWORDHASH_SIZE - 1);
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 10
RSHI4
BXORI4
ADDRLP4 4
INDIRI4
CNSTI4 20
RSHI4
BXORI4
CNSTI4 511
BANDI4
ASGNI4
line 5347
;5347:	return hash;
ADDRLP4 4
INDIRI4
RETI4
LABELV $2399
endproc KeywordHash_Key 20 0
proc KeywordHash_Add 8 4
line 5350
;5348:}
;5349:
;5350:static void KeywordHash_Add(keywordHash_t *table[], keywordHash_t *key) {
line 5353
;5351:	int hash;
;5352:
;5353:	hash = KeywordHash_Key(key->keyword);
ADDRFP4 4
INDIRP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 KeywordHash_Key
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 5359
;5354:	/*
;5355:		if (table[hash]) {
;5356:			int collision = qtrue;
;5357:		}
;5358:	*/
;5359:	key->next = table[hash];
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRP4
ASGNP4
line 5360
;5360:	table[hash] = key;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
ADDRFP4 4
INDIRP4
ASGNP4
line 5361
;5361:}
LABELV $2406
endproc KeywordHash_Add 8 4
proc KeywordHash_Find 16 8
line 5363
;5362:
;5363:static keywordHash_t *KeywordHash_Find(keywordHash_t *table[], char *keyword) {
line 5367
;5364:	keywordHash_t *key;
;5365:	int hash;
;5366:
;5367:	hash = KeywordHash_Key(keyword);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 KeywordHash_Key
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 5368
;5368:	for (key = table[hash]; key; key = key->next) {
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $2411
JUMPV
LABELV $2408
line 5369
;5369:		if (!Q_stricmp(key->keyword, keyword))
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2412
line 5370
;5370:			return key;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $2407
JUMPV
LABELV $2412
line 5371
;5371:	}
LABELV $2409
line 5368
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ASGNP4
LABELV $2411
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2408
line 5372
;5372:	return NULL;
CNSTP4 0
RETP4
LABELV $2407
endproc KeywordHash_Find 16 8
proc ItemParse_name 4 8
line 5382
;5373:}
;5374:
;5375:/*
;5376:===============
;5377:Item Keyword Parse functions
;5378:===============
;5379:*/
;5380:
;5381:// name <string>
;5382:static qboolean ItemParse_name(itemDef_t *item, int handle) {
line 5383
;5383:	if (!PC_String_Parse(handle, &item->window.name)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2415
line 5384
;5384:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2414
JUMPV
LABELV $2415
line 5386
;5385:	}
;5386:	return qtrue;
CNSTI4 1
RETI4
LABELV $2414
endproc ItemParse_name 4 8
proc ItemParse_focusSound 20 8
line 5390
;5387:}
;5388:
;5389:// name <string>
;5390:static qboolean ItemParse_focusSound(itemDef_t *item, int handle) {
line 5392
;5391:	const char *name;
;5392:	if (!PC_String_Parse(handle, &name)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2418
line 5393
;5393:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2417
JUMPV
LABELV $2418
line 5395
;5394:	}
;5395:	if (Q_stricmp(name, item->focusSoundName)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $2420
line 5396
;5396:		item->focusSound = DC->registerSound(name, qfalse);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 172
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 300
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 5397
;5397:		item->focusSoundName = String_Alloc(name);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 304
ADDP4
ADDRLP4 16
INDIRP4
ASGNP4
line 5398
;5398:	}
LABELV $2420
line 5399
;5399:	return qtrue;
CNSTI4 1
RETI4
LABELV $2417
endproc ItemParse_focusSound 20 8
proc ItemParse_text 4 8
line 5404
;5400:}
;5401:
;5402:
;5403:// text <string>
;5404:static qboolean ItemParse_text(itemDef_t *item, int handle) {
line 5405
;5405:	if (!PC_String_Parse(handle, &item->text)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2423
line 5406
;5406:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2422
JUMPV
LABELV $2423
line 5408
;5407:	}
;5408:	return qtrue;
CNSTI4 1
RETI4
LABELV $2422
endproc ItemParse_text 4 8
proc ItemParse_textExt 4160 12
line 5411
;5409:}
;5410:
;5411:static qboolean ItemParse_textExt(itemDef_t *item, int handle) {
line 5424
;5412:	const char *inb;
;5413:	char outb[MAX_STRING_CHARS];
;5414:	const char *ip;
;5415:	char *op;
;5416:	char token[MAX_STRING_CHARS];
;5417:	char formatString[MAX_STRING_CHARS];
;5418:	char cvarStringBuffer[MAX_STRING_CHARS];
;5419:	char *tp;
;5420:	int length;
;5421:	float f;
;5422:	char *s;
;5423:
;5424:	if (!PC_String_Parse(handle, &inb)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 1044
ARGP4
ADDRLP4 4124
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4124
INDIRI4
CNSTI4 0
NEI4 $2426
line 5425
;5425:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2425
JUMPV
LABELV $2426
line 5428
;5426:	}
;5427:
;5428:	outb[0] = '\0';
ADDRLP4 2072
CNSTI1 0
ASGNI1
line 5429
;5429:	ip = inb;
ADDRLP4 0
ADDRLP4 1044
INDIRP4
ASGNP4
line 5430
;5430:	op = outb;
ADDRLP4 8
ADDRLP4 2072
ASGNP4
line 5432
;5431:
;5432:	length = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $2429
JUMPV
LABELV $2428
line 5433
;5433:	while (ip[0] != '\0') {
line 5434
;5434:		if (length >= (MAX_STRING_CHARS - 1)) {
ADDRLP4 12
INDIRI4
CNSTI4 1023
LTI4 $2431
line 5435
;5435:			Com_Printf("^1ItemParse_textExt() output string overflow\n");
ADDRGP4 $2433
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 5436
;5436:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2425
JUMPV
LABELV $2431
line 5439
;5437:		}
;5438:
;5439:		if (ip[0] == '%') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 37
NEI4 $2434
line 5440
;5440:			if (ip[1] == '\0') {
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2436
line 5441
;5441:				Com_Printf("^1ItemParse_textExt() invalid string '%s'\n", inb);
ADDRGP4 $2438
ARGP4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 5442
;5442:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2425
JUMPV
LABELV $2436
line 5443
;5443:			} else if (ip[1] == '%') {
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 37
NEI4 $2439
line 5444
;5444:				ip++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 5445
;5445:			} else {  // check for script variable
ADDRGP4 $2440
JUMPV
LABELV $2439
line 5454
;5446:				int slength;
;5447:				int tlength;
;5448:				qboolean convertToInt;
;5449:				qboolean convertToString;
;5450:
;5451:				//ip++;  // skip '%'
;5452:
;5453:				// get formatString
;5454:				formatString[0] = '\0';
ADDRLP4 20
CNSTI1 0
ASGNI1
line 5455
;5455:				s = formatString;
ADDRLP4 4
ADDRLP4 20
ASGNP4
line 5456
;5456:				slength = 0;
ADDRLP4 4128
CNSTI4 0
ASGNI4
line 5458
;5457:
;5458:				convertToInt = qfalse;
ADDRLP4 4140
CNSTI4 0
ASGNI4
line 5459
;5459:				convertToString = qfalse;
ADDRLP4 4136
CNSTI4 0
ASGNI4
ADDRGP4 $2442
JUMPV
LABELV $2441
line 5460
;5460:				while (1) {
line 5461
;5461:					if (slength >= (MAX_STRING_CHARS - 1)) {
ADDRLP4 4128
INDIRI4
CNSTI4 1023
LTI4 $2444
line 5462
;5462:						Com_Printf("^1ItemParse_textExt() format string too long\n");
ADDRGP4 $2446
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 5463
;5463:						return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2425
JUMPV
LABELV $2444
line 5465
;5464:					}
;5465:					if (ip[0] == '\0') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2447
line 5466
;5466:						Com_Printf("^1ItemParse_textExt() missing format string\n");
ADDRGP4 $2449
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 5467
;5467:						return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2425
JUMPV
LABELV $2447
line 5470
;5468:					}
;5469:
;5470:					if (ip[0] == '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $2450
line 5471
;5471:						s[0] = '\0';
ADDRLP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 5472
;5472:						ip++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 5473
;5473:						break;
ADDRGP4 $2443
JUMPV
LABELV $2450
line 5476
;5474:					}
;5475:
;5476:					if (!(ip[0] == ' ' || Q_isdigit(ip[0]) || ip[0] == '.' || ip[0] == 'f' || ip[0] == 'd' || ip[0] == 'x' || ip[0] == '%' || ip[0] == 's')) {
ADDRLP4 4144
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4144
INDIRI4
CNSTI4 32
EQI4 $2452
ADDRLP4 4144
INDIRI4
ARGI4
ADDRLP4 4148
ADDRGP4 Q_isdigit
CALLI4
ASGNI4
ADDRLP4 4148
INDIRI4
CNSTI4 0
NEI4 $2452
ADDRLP4 4152
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4152
INDIRI4
CNSTI4 46
EQI4 $2452
ADDRLP4 4152
INDIRI4
CNSTI4 102
EQI4 $2452
ADDRLP4 4152
INDIRI4
CNSTI4 100
EQI4 $2452
ADDRLP4 4152
INDIRI4
CNSTI4 120
EQI4 $2452
ADDRLP4 4152
INDIRI4
CNSTI4 37
EQI4 $2452
ADDRLP4 4152
INDIRI4
CNSTI4 115
EQI4 $2452
line 5477
;5477:						Com_Printf("^1ItemParse_textExt() invalid conversion char '%c'\n", ip[0]);
ADDRGP4 $2454
ARGP4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 5478
;5478:						return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2425
JUMPV
LABELV $2452
line 5481
;5479:					}
;5480:
;5481:					if (ip[0] == 'd' || ip[0] == 'x') {
ADDRLP4 4156
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4156
INDIRI4
CNSTI4 100
EQI4 $2457
ADDRLP4 4156
INDIRI4
CNSTI4 120
NEI4 $2455
LABELV $2457
line 5482
;5482:						convertToInt = qtrue;
ADDRLP4 4140
CNSTI4 1
ASGNI4
line 5483
;5483:					}
LABELV $2455
line 5485
;5484:
;5485:					if (ip[0] == 's') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 115
NEI4 $2458
line 5486
;5486:						convertToString = qtrue;
ADDRLP4 4136
CNSTI4 1
ASGNI4
line 5487
;5487:					}
LABELV $2458
line 5489
;5488:
;5489:					s[0] = ip[0];
ADDRLP4 4
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI1
ASGNI1
line 5490
;5490:					s++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 5491
;5491:					ip++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 5492
;5492:					slength++;
ADDRLP4 4128
ADDRLP4 4128
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5493
;5493:				}
LABELV $2442
line 5460
ADDRGP4 $2441
JUMPV
LABELV $2443
line 5495
;5494:
;5495:				if (strlen(formatString) < 2) {
ADDRLP4 20
ARGP4
ADDRLP4 4144
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4144
INDIRI4
CNSTI4 2
GEI4 $2460
line 5496
;5496:					Com_Printf("^1ItemParse_textExt() invalid format string '%s'\n", formatString);
ADDRGP4 $2462
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 5497
;5497:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2425
JUMPV
LABELV $2460
line 5500
;5498:				}
;5499:
;5500:				token[0] = '\0';
ADDRLP4 1048
CNSTI1 0
ASGNI1
line 5501
;5501:				tp = token;
ADDRLP4 16
ADDRLP4 1048
ASGNP4
line 5502
;5502:				tlength = 0;
ADDRLP4 4132
CNSTI4 0
ASGNI4
ADDRGP4 $2464
JUMPV
LABELV $2463
line 5504
;5503:
;5504:				while (1) {
line 5505
;5505:					if (tlength >= (MAX_STRING_CHARS - 1)) {
ADDRLP4 4132
INDIRI4
CNSTI4 1023
LTI4 $2466
line 5506
;5506:						Com_Printf("^1ItemParse_textExt() token string too long\n");
ADDRGP4 $2468
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 5507
;5507:						return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2425
JUMPV
LABELV $2466
line 5509
;5508:					}
;5509:					if (ip[0] == '\0') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2469
line 5510
;5510:						Com_Printf("^1ItemParse_textExt() missing closing '}'\n");
ADDRGP4 $2471
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 5511
;5511:						return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2425
JUMPV
LABELV $2469
line 5513
;5512:					}
;5513:					if (ip[0] == '}') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $2472
line 5514
;5514:						tp[0] = '\0';
ADDRLP4 16
INDIRP4
CNSTI1 0
ASGNI1
line 5515
;5515:						ip++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 5516
;5516:						break;
ADDRGP4 $2465
JUMPV
LABELV $2472
line 5519
;5517:					}
;5518:
;5519:					tp[0] = ip[0];
ADDRLP4 16
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI1
ASGNI1
line 5520
;5520:					tp++;
ADDRLP4 16
ADDRLP4 16
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 5521
;5521:					ip++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 5522
;5522:					tlength++;
ADDRLP4 4132
ADDRLP4 4132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5523
;5523:				}
LABELV $2464
line 5504
ADDRGP4 $2463
JUMPV
LABELV $2465
line 5525
;5524:
;5525:				if (convertToString) {
ADDRLP4 4136
INDIRI4
CNSTI4 0
EQI4 $2474
line 5526
;5526:					cvarStringBuffer[0] = '\0';
ADDRLP4 3096
CNSTI1 0
ASGNI1
line 5527
;5527:					DC->getCVarString(token, cvarStringBuffer, sizeof(cvarStringBuffer));
ADDRLP4 1048
ARGP4
ADDRLP4 3096
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 5528
;5528:					s = cvarStringBuffer;
ADDRLP4 4
ADDRLP4 3096
ASGNP4
line 5530
;5529:					//Com_Printf("cvar '%s'\n", s);
;5530:				} else {
ADDRGP4 $2479
JUMPV
LABELV $2474
line 5531
;5531:					f = MenuVar_Get(token);
ADDRLP4 1048
ARGP4
ADDRLP4 4148
ADDRGP4 MenuVar_Get
CALLF4
ASGNF4
ADDRLP4 4120
ADDRLP4 4148
INDIRF4
ASGNF4
line 5532
;5532:					if (convertToInt) {
ADDRLP4 4140
INDIRI4
CNSTI4 0
EQI4 $2476
line 5533
;5533:						s = va(formatString, (int)floor(f));
ADDRLP4 4120
INDIRF4
ARGF4
ADDRLP4 4152
ADDRGP4 floor
CALLF4
ASGNF4
ADDRLP4 20
ARGP4
ADDRLP4 4152
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4156
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 4156
INDIRP4
ASGNP4
line 5534
;5534:					} else {
ADDRGP4 $2479
JUMPV
LABELV $2476
line 5535
;5535:						s = va(formatString, f);
ADDRLP4 20
ARGP4
ADDRLP4 4120
INDIRF4
ARGF4
ADDRLP4 4152
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 4152
INDIRP4
ASGNP4
line 5536
;5536:					}
line 5537
;5537:				}
ADDRGP4 $2479
JUMPV
LABELV $2478
line 5539
;5538:
;5539:				while (*s) {
line 5540
;5540:					if (length >= (MAX_STRING_CHARS - 1)) {
ADDRLP4 12
INDIRI4
CNSTI4 1023
LTI4 $2481
line 5541
;5541:						Com_Printf("^1ItemParse_textExt() output string too long\n");
ADDRGP4 $2483
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 5542
;5542:						return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2425
JUMPV
LABELV $2481
line 5544
;5543:					}
;5544:					op[0] = s[0];
ADDRLP4 8
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI1
ASGNI1
line 5545
;5545:					op++;
ADDRLP4 8
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 5546
;5546:					s++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 5547
;5547:					length++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5548
;5548:				}
LABELV $2479
line 5539
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2478
line 5549
;5549:			}
LABELV $2440
line 5550
;5550:		}
LABELV $2434
line 5552
;5551:
;5552:		op[0] = ip[0];
ADDRLP4 8
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI1
ASGNI1
line 5554
;5553:
;5554:		ip++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 5555
;5555:		op++;
ADDRLP4 8
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 5556
;5556:		length++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5557
;5557:	}
LABELV $2429
line 5433
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2428
line 5559
;5558:
;5559:	op[0] = '\0';
ADDRLP4 8
INDIRP4
CNSTI1 0
ASGNI1
line 5561
;5560:
;5561:	item->text = String_Alloc(outb);
ADDRLP4 2072
ARGP4
ADDRLP4 4128
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
ADDRLP4 4128
INDIRP4
ASGNP4
line 5563
;5562:
;5563:	return qtrue;
CNSTI4 1
RETI4
LABELV $2425
endproc ItemParse_textExt 4160 12
proc ItemParse_textReset 0 0
line 5566
;5564:}
;5565:
;5566:static qboolean ItemParse_textReset(itemDef_t *item, int handle) {
line 5568
;5567:	//FIXME free previous string?
;5568:	item->text = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
CNSTP4 0
ASGNP4
line 5569
;5569:	return qtrue;
CNSTI4 1
RETI4
LABELV $2484
endproc ItemParse_textReset 0 0
proc ItemParse_group 4 8
line 5573
;5570:}
;5571:
;5572:// group <string>
;5573:static qboolean ItemParse_group(itemDef_t *item, int handle) {
line 5574
;5574:	if (!PC_String_Parse(handle, &item->window.group)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2486
line 5575
;5575:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2485
JUMPV
LABELV $2486
line 5577
;5576:	}
;5577:	return qtrue;
CNSTI4 1
RETI4
LABELV $2485
endproc ItemParse_group 4 8
proc ItemParse_asset_model 28 8
line 5581
;5578:}
;5579:
;5580:// asset_model <string>
;5581:static qboolean ItemParse_asset_model(itemDef_t *item, int handle) {
line 5584
;5582:	const char *temp;
;5583:	modelDef_t *modelPtr;
;5584:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5585
;5585:	modelPtr = (modelDef_t *)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 5587
;5586:
;5587:	if (!PC_String_Parse(handle, &temp)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2489
line 5588
;5588:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2488
JUMPV
LABELV $2489
line 5590
;5589:	}
;5590:	if (Q_stricmp(temp, item->assetName)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2491
line 5591
;5591:		item->asset = DC->registerModel(temp);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 DC
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 5592
;5592:		item->assetName = String_Alloc(temp);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 248
ADDP4
ADDRLP4 20
INDIRP4
ASGNP4
line 5593
;5593:		modelPtr->angle = rand() % 360;
ADDRLP4 24
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 24
INDIRI4
CNSTI4 360
MODI4
ASGNI4
line 5594
;5594:	}
LABELV $2491
line 5595
;5595:	return qtrue;
CNSTI4 1
RETI4
LABELV $2488
endproc ItemParse_asset_model 28 8
proc ItemParse_asset_shader 20 8
line 5599
;5596:}
;5597:
;5598:// asset_shader <string>
;5599:static qboolean ItemParse_asset_shader(itemDef_t *item, int handle) {
line 5602
;5600:	const char *temp;
;5601:
;5602:	if (!PC_String_Parse(handle, &temp)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2494
line 5603
;5603:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2493
JUMPV
LABELV $2494
line 5605
;5604:	}
;5605:	if (Q_stricmp(temp, item->assetName)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $2496
line 5606
;5606:		item->asset = DC->registerShaderNoMip(temp);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 5607
;5607:		item->assetName = String_Alloc(temp);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 248
ADDP4
ADDRLP4 16
INDIRP4
ASGNP4
line 5608
;5608:	}
LABELV $2496
line 5609
;5609:	return qtrue;
CNSTI4 1
RETI4
LABELV $2493
endproc ItemParse_asset_shader 20 8
proc ItemParse_model_origin 16 8
line 5613
;5610:}
;5611:
;5612:// model_origin <number> <number> <number>
;5613:static qboolean ItemParse_model_origin(itemDef_t *item, int handle) {
line 5615
;5614:	modelDef_t *modelPtr;
;5615:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5616
;5616:	modelPtr = (modelDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 5618
;5617:
;5618:	if (PC_Float_Parse(handle, &modelPtr->origin[0])) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2499
line 5619
;5619:		if (PC_Float_Parse(handle, &modelPtr->origin[1])) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $2501
line 5620
;5620:			if (PC_Float_Parse(handle, &modelPtr->origin[2])) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2503
line 5621
;5621:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2498
JUMPV
LABELV $2503
line 5623
;5622:			}
;5623:		}
LABELV $2501
line 5624
;5624:	}
LABELV $2499
line 5625
;5625:	return qfalse;
CNSTI4 0
RETI4
LABELV $2498
endproc ItemParse_model_origin 16 8
proc ItemParse_model_fovx 8 8
line 5629
;5626:}
;5627:
;5628:// model_fovx <number>
;5629:static qboolean ItemParse_model_fovx(itemDef_t *item, int handle) {
line 5631
;5630:	modelDef_t *modelPtr;
;5631:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5632
;5632:	modelPtr = (modelDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 5634
;5633:
;5634:	if (!PC_Float_Parse(handle, &modelPtr->fov_x)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2506
line 5635
;5635:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2505
JUMPV
LABELV $2506
line 5637
;5636:	}
;5637:	return qtrue;
CNSTI4 1
RETI4
LABELV $2505
endproc ItemParse_model_fovx 8 8
proc ItemParse_model_fovy 8 8
line 5641
;5638:}
;5639:
;5640:// model_fovy <number>
;5641:static qboolean ItemParse_model_fovy(itemDef_t *item, int handle) {
line 5643
;5642:	modelDef_t *modelPtr;
;5643:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5644
;5644:	modelPtr = (modelDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 5646
;5645:
;5646:	if (!PC_Float_Parse(handle, &modelPtr->fov_y)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2509
line 5647
;5647:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2508
JUMPV
LABELV $2509
line 5649
;5648:	}
;5649:	return qtrue;
CNSTI4 1
RETI4
LABELV $2508
endproc ItemParse_model_fovy 8 8
proc ItemParse_model_rotation 8 8
line 5653
;5650:}
;5651:
;5652:// model_rotation <integer>
;5653:static qboolean ItemParse_model_rotation(itemDef_t *item, int handle) {
line 5655
;5654:	modelDef_t *modelPtr;
;5655:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5656
;5656:	modelPtr = (modelDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 5658
;5657:
;5658:	if (!PC_Int_Parse(handle, &modelPtr->rotationSpeed)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2512
line 5659
;5659:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2511
JUMPV
LABELV $2512
line 5661
;5660:	}
;5661:	return qtrue;
CNSTI4 1
RETI4
LABELV $2511
endproc ItemParse_model_rotation 8 8
proc ItemParse_model_angle 8 8
line 5665
;5662:}
;5663:
;5664:// model_angle <integer>
;5665:static qboolean ItemParse_model_angle(itemDef_t *item, int handle) {
line 5667
;5666:	modelDef_t *modelPtr;
;5667:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5668
;5668:	modelPtr = (modelDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 5670
;5669:
;5670:	if (!PC_Int_Parse(handle, &modelPtr->angle)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2515
line 5671
;5671:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2514
JUMPV
LABELV $2515
line 5673
;5672:	}
;5673:	return qtrue;
CNSTI4 1
RETI4
LABELV $2514
endproc ItemParse_model_angle 8 8
proc ItemParse_rect 4 8
line 5677
;5674:}
;5675:
;5676:// rect <rectangle>
;5677:static qboolean ItemParse_rect(itemDef_t *item, int handle) {
line 5678
;5678:	if (!PC_Rect_Parse(handle, &item->window.rectClient)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Rect_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2518
line 5679
;5679:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2517
JUMPV
LABELV $2518
line 5682
;5680:	}
;5681:	//Com_Printf("%f %f %f %f\n", item->window.rectClient.x, item->window.rectClient.y, item->window.rectClient.w, item->window.rectClient.h);
;5682:	return qtrue;
CNSTI4 1
RETI4
LABELV $2517
endproc ItemParse_rect 4 8
proc ItemParse_style 4 8
line 5686
;5683:}
;5684:
;5685:// style <integer>
;5686:static qboolean ItemParse_style(itemDef_t *item, int handle) {
line 5687
;5687:	if (!PC_Int_Parse(handle, &item->window.style)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2521
line 5688
;5688:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2520
JUMPV
LABELV $2521
line 5690
;5689:	}
;5690:	return qtrue;
CNSTI4 1
RETI4
LABELV $2520
endproc ItemParse_style 4 8
proc ItemParse_decoration 4 0
line 5694
;5691:}
;5692:
;5693:// decoration
;5694:static qboolean ItemParse_decoration(itemDef_t *item, int handle) {
line 5695
;5695:	item->window.flags |= WINDOW_DECORATION;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 5696
;5696:	return qtrue;
CNSTI4 1
RETI4
LABELV $2523
endproc ItemParse_decoration 4 0
proc ItemParse_notselectable 4 4
line 5700
;5697:}
;5698:
;5699:// notselectable
;5700:static qboolean ItemParse_notselectable(itemDef_t *item, int handle) {
line 5702
;5701:	listBoxDef_t *listPtr;
;5702:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5703
;5703:	listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 5704
;5704:	if (item->type == ITEM_TYPE_LISTBOX && listPtr) {
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 6
NEI4 $2525
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2525
line 5705
;5705:		listPtr->notselectable = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 472
ADDP4
CNSTI4 1
ASGNI4
line 5706
;5706:	}
LABELV $2525
line 5707
;5707:	return qtrue;
CNSTI4 1
RETI4
LABELV $2524
endproc ItemParse_notselectable 4 4
proc ItemParse_wrapped 4 0
line 5711
;5708:}
;5709:
;5710:// manually wrapped
;5711:static qboolean ItemParse_wrapped(itemDef_t *item, int handle) {
line 5712
;5712:	item->window.flags |= WINDOW_WRAPPED;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 262144
BORI4
ASGNI4
line 5713
;5713:	return qtrue;
CNSTI4 1
RETI4
LABELV $2527
endproc ItemParse_wrapped 4 0
proc ItemParse_autowrapped 4 0
line 5717
;5714:}
;5715:
;5716:// auto wrapped
;5717:static qboolean ItemParse_autowrapped(itemDef_t *item, int handle) {
line 5718
;5718:	item->window.flags |= WINDOW_AUTOWRAPPED;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 524288
BORI4
ASGNI4
line 5719
;5719:	return qtrue;
CNSTI4 1
RETI4
LABELV $2528
endproc ItemParse_autowrapped 4 0
proc ItemParse_horizontalscroll 4 0
line 5724
;5720:}
;5721:
;5722:
;5723:// horizontalscroll
;5724:static qboolean ItemParse_horizontalscroll(itemDef_t *item, int handle) {
line 5725
;5725:	item->window.flags |= WINDOW_HORIZONTAL;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 5726
;5726:	return qtrue;
CNSTI4 1
RETI4
LABELV $2529
endproc ItemParse_horizontalscroll 4 0
proc ItemParse_type 4 8
line 5730
;5727:}
;5728:
;5729:// type <integer>
;5730:static qboolean ItemParse_type(itemDef_t *item, int handle) {
line 5731
;5731:	if (!PC_Int_Parse(handle, &item->type)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2531
line 5732
;5732:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2530
JUMPV
LABELV $2531
line 5734
;5733:	}
;5734:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5735
;5735:	return qtrue;
CNSTI4 1
RETI4
LABELV $2530
endproc ItemParse_type 4 8
proc ItemParse_elementwidth 8 8
line 5740
;5736:}
;5737:
;5738:// elementwidth, used for listbox image elements
;5739:// uses textalignx for storage
;5740:static qboolean ItemParse_elementwidth(itemDef_t *item, int handle) {
line 5743
;5741:	listBoxDef_t *listPtr;
;5742:
;5743:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5744
;5744:	listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 5745
;5745:	if (!PC_Float_Parse(handle, &listPtr->elementWidth)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2534
line 5746
;5746:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2533
JUMPV
LABELV $2534
line 5748
;5747:	}
;5748:	return qtrue;
CNSTI4 1
RETI4
LABELV $2533
endproc ItemParse_elementwidth 8 8
proc ItemParse_elementheight 8 8
line 5753
;5749:}
;5750:
;5751:// elementheight, used for listbox image elements
;5752:// uses textaligny for storage
;5753:static qboolean ItemParse_elementheight(itemDef_t *item, int handle) {
line 5756
;5754:	listBoxDef_t *listPtr;
;5755:
;5756:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5757
;5757:	listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 5758
;5758:	if (!PC_Float_Parse(handle, &listPtr->elementHeight)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2537
line 5759
;5759:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2536
JUMPV
LABELV $2537
line 5762
;5760:	}
;5761:
;5762:	return qtrue;
CNSTI4 1
RETI4
LABELV $2536
endproc ItemParse_elementheight 8 8
proc ItemParse_elementColor 8 8
line 5765
;5763:}
;5764:
;5765:static qboolean ItemParse_elementColor(itemDef_t *item, int handle) {
line 5768
;5766:	listBoxDef_t *listPtr;
;5767:
;5768:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5769
;5769:	listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 5770
;5770:	if (!PC_Color_Parse(handle, &listPtr->elementColor)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Color_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2540
line 5771
;5771:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2539
JUMPV
LABELV $2540
line 5774
;5772:	}
;5773:
;5774:	return qtrue;
CNSTI4 1
RETI4
LABELV $2539
endproc ItemParse_elementColor 8 8
proc ItemParse_selectedColor 8 8
line 5777
;5775:}
;5776:
;5777:static qboolean ItemParse_selectedColor(itemDef_t *item, int handle) {
line 5781
;5778:	listBoxDef_t *listPtr;
;5779:
;5780:	//Com_Printf("FIXME ui_shared.c selectedColor\n");
;5781:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5782
;5782:	listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 5783
;5783:	if (!PC_Color_Parse(handle, &listPtr->selectedColor)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Color_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2543
line 5784
;5784:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2542
JUMPV
LABELV $2543
line 5787
;5785:	}
;5786:	//listPtr->selectedColor[3] = 0.0;
;5787:	return qtrue;
CNSTI4 1
RETI4
LABELV $2542
endproc ItemParse_selectedColor 8 8
proc ItemParse_altRowColor 8 8
line 5790
;5788:}
;5789:
;5790:static qboolean ItemParse_altRowColor(itemDef_t *item, int handle) {
line 5793
;5791:	listBoxDef_t *listPtr;
;5792:
;5793:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5794
;5794:	listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 5795
;5795:	if (!PC_Color_Parse(handle, &listPtr->altRowColor)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Color_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2546
line 5796
;5796:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2545
JUMPV
LABELV $2546
line 5798
;5797:	}
;5798:	return qtrue;
CNSTI4 1
RETI4
LABELV $2545
endproc ItemParse_altRowColor 8 8
proc ItemParse_feeder 4 8
line 5802
;5799:}
;5800:
;5801:// feeder <float>
;5802:static qboolean ItemParse_feeder(itemDef_t *item, int handle) {
line 5803
;5803:	if (!PC_Float_Parse(handle, &item->special)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2549
line 5804
;5804:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2548
JUMPV
LABELV $2549
line 5806
;5805:	}
;5806:	return qtrue;
CNSTI4 1
RETI4
LABELV $2548
endproc ItemParse_feeder 4 8
proc ItemParse_elementtype 8 8
line 5811
;5807:}
;5808:
;5809:// elementtype, used to specify what type of elements a listbox contains
;5810:// uses textstyle for storage
;5811:static qboolean ItemParse_elementtype(itemDef_t *item, int handle) {
line 5814
;5812:	listBoxDef_t *listPtr;
;5813:
;5814:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5815
;5815:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2552
line 5816
;5816:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2551
JUMPV
LABELV $2552
line 5817
;5817:	listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 5818
;5818:	if (!PC_Int_Parse(handle, &listPtr->elementStyle)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2554
line 5819
;5819:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2551
JUMPV
LABELV $2554
line 5821
;5820:	}
;5821:	return qtrue;
CNSTI4 1
RETI4
LABELV $2551
endproc ItemParse_elementtype 8 8
proc ItemParse_columns 40 12
line 5825
;5822:}
;5823:
;5824:// columns sets a number of columns and an x pos and width per.. 
;5825:static qboolean ItemParse_columns(itemDef_t *item, int handle) {
line 5829
;5826:	int num, i;
;5827:	listBoxDef_t *listPtr;
;5828:
;5829:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 5830
;5830:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2557
line 5831
;5831:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2556
JUMPV
LABELV $2557
line 5832
;5832:	listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 5833
;5833:	if (PC_Int_Parse(handle, &num)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 12
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2559
line 5834
;5834:		if (num > MAX_LB_COLUMNS) {
ADDRLP4 8
INDIRI4
CNSTI4 32
LEI4 $2561
line 5835
;5835:			Com_Printf("^1ERROR:  ItemParse_columns() %d > MAX_LB_COLUMNS(%d)\n", num, MAX_LB_COLUMNS);
ADDRGP4 $2563
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 5836
;5836:			num = MAX_LB_COLUMNS;
ADDRLP4 8
CNSTI4 32
ASGNI4
line 5837
;5837:		}
LABELV $2561
line 5838
;5838:		listPtr->numColumns = num;
ADDRLP4 4
INDIRP4
CNSTI4 80
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 5839
;5839:		for (i = 0; i < num; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2567
JUMPV
LABELV $2564
line 5842
;5840:			int pos, width, maxChars;
;5841:
;5842:			if (PC_Int_Parse(handle, &pos) && PC_Int_Parse(handle, &width) && PC_Int_Parse(handle, &maxChars)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 28
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2568
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 20
ARGP4
ADDRLP4 32
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $2568
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 36
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $2568
line 5843
;5843:				listPtr->columnInfo[i].pos = pos;
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 84
ADDP4
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 5844
;5844:				listPtr->columnInfo[i].width = width;
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 84
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 5845
;5845:				listPtr->columnInfo[i].maxChars = maxChars;
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 84
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 5847
;5846:				//Com_Printf("%d %d %d\n", pos, width, maxChars);
;5847:			} else {
ADDRGP4 $2569
JUMPV
LABELV $2568
line 5848
;5848:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2556
JUMPV
LABELV $2569
line 5850
;5849:			}
;5850:		}
LABELV $2565
line 5839
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2567
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $2564
line 5851
;5851:	} else {
ADDRGP4 $2560
JUMPV
LABELV $2559
line 5852
;5852:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2556
JUMPV
LABELV $2560
line 5854
;5853:	}
;5854:	return qtrue;
CNSTI4 1
RETI4
LABELV $2556
endproc ItemParse_columns 40 12
proc ItemParse_border 4 8
line 5857
;5855:}
;5856:
;5857:static qboolean ItemParse_border(itemDef_t *item, int handle) {
line 5858
;5858:	if (!PC_Int_Parse(handle, &item->window.border)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2571
line 5859
;5859:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2570
JUMPV
LABELV $2571
line 5861
;5860:	}
;5861:	return qtrue;
CNSTI4 1
RETI4
LABELV $2570
endproc ItemParse_border 4 8
proc ItemParse_bordersize 4 8
line 5864
;5862:}
;5863:
;5864:static qboolean ItemParse_bordersize(itemDef_t *item, int handle) {
line 5865
;5865:	if (!PC_Float_Parse(handle, &item->window.borderSize)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2574
line 5866
;5866:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2573
JUMPV
LABELV $2574
line 5868
;5867:	}
;5868:	return qtrue;
CNSTI4 1
RETI4
LABELV $2573
endproc ItemParse_bordersize 4 8
proc ItemParse_visible 12 8
line 5871
;5869:}
;5870:
;5871:static qboolean ItemParse_visible(itemDef_t *item, int handle) {
line 5874
;5872:	int i;
;5873:
;5874:	if (!PC_Int_Parse(handle, &i)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2577
line 5875
;5875:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2576
JUMPV
LABELV $2577
line 5877
;5876:	}
;5877:	if (i) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2579
line 5878
;5878:		item->window.flags |= WINDOW_VISIBLE;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 5879
;5879:	} else {
ADDRGP4 $2580
JUMPV
LABELV $2579
line 5880
;5880:		item->window.flags &= ~WINDOW_VISIBLE;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -5
BANDI4
ASGNI4
line 5881
;5881:	}
LABELV $2580
line 5883
;5882:
;5883:	return qtrue;
CNSTI4 1
RETI4
LABELV $2576
endproc ItemParse_visible 12 8
proc ItemParse_ownerdraw 4 8
line 5886
;5884:}
;5885:
;5886:static qboolean ItemParse_ownerdraw(itemDef_t *item, int handle) {
line 5887
;5887:	if (!PC_Int_Parse(handle, &item->window.ownerDraw)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2582
line 5888
;5888:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2581
JUMPV
LABELV $2582
line 5890
;5889:	}
;5890:	item->type = ITEM_TYPE_OWNERDRAW;
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 8
ASGNI4
line 5891
;5891:	return qtrue;
CNSTI4 1
RETI4
LABELV $2581
endproc ItemParse_ownerdraw 4 8
proc ItemParse_align 4 8
line 5894
;5892:}
;5893:
;5894:static qboolean ItemParse_align(itemDef_t *item, int handle) {
line 5895
;5895:	if (!PC_Int_Parse(handle, &item->alignment)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2585
line 5896
;5896:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2584
JUMPV
LABELV $2585
line 5898
;5897:	}
;5898:	return qtrue;
CNSTI4 1
RETI4
LABELV $2584
endproc ItemParse_align 4 8
proc ItemParse_textalign 4 8
line 5901
;5899:}
;5900:
;5901:static qboolean ItemParse_textalign(itemDef_t *item, int handle) {
line 5902
;5902:	if (!PC_Int_Parse(handle, &item->textalignment)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2588
line 5903
;5903:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2587
JUMPV
LABELV $2588
line 5905
;5904:	}
;5905:	return qtrue;
CNSTI4 1
RETI4
LABELV $2587
endproc ItemParse_textalign 4 8
proc ItemParse_textalignx 4 8
line 5908
;5906:}
;5907:
;5908:static qboolean ItemParse_textalignx(itemDef_t *item, int handle) {
line 5909
;5909:	if (!PC_Float_Parse(handle, &item->textalignx)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2591
line 5910
;5910:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2590
JUMPV
LABELV $2591
line 5912
;5911:	}
;5912:	return qtrue;
CNSTI4 1
RETI4
LABELV $2590
endproc ItemParse_textalignx 4 8
proc ItemParse_textaligny 4 8
line 5915
;5913:}
;5914:
;5915:static qboolean ItemParse_textaligny(itemDef_t *item, int handle) {
line 5916
;5916:	if (!PC_Float_Parse(handle, &item->textaligny)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2594
line 5917
;5917:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2593
JUMPV
LABELV $2594
line 5919
;5918:	}
;5919:	return qtrue;
CNSTI4 1
RETI4
LABELV $2593
endproc ItemParse_textaligny 4 8
proc ItemParse_textscale 4 8
line 5922
;5920:}
;5921:
;5922:static qboolean ItemParse_textscale(itemDef_t *item, int handle) {
line 5923
;5923:	if (!PC_Float_Parse(handle, &item->textscale)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2597
line 5924
;5924:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2596
JUMPV
LABELV $2597
line 5927
;5925:	}
;5926:	//Com_Printf("item %p '%s'  scale %f\n", item, item->window.name, item->textscale);
;5927:	return qtrue;
CNSTI4 1
RETI4
LABELV $2596
endproc ItemParse_textscale 4 8
proc ItemParse_textstyle 4 8
line 5930
;5928:}
;5929:
;5930:static qboolean ItemParse_textstyle(itemDef_t *item, int handle) {
line 5931
;5931:	if (!PC_Int_Parse(handle, &item->textStyle)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2600
line 5932
;5932:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2599
JUMPV
LABELV $2600
line 5934
;5933:	}
;5934:	return qtrue;
CNSTI4 1
RETI4
LABELV $2599
endproc ItemParse_textstyle 4 8
proc ItemParse_backcolor 12 8
line 5937
;5935:}
;5936:
;5937:static qboolean ItemParse_backcolor(itemDef_t *item, int handle) {
line 5941
;5938:	int i;
;5939:	float f;
;5940:
;5941:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2603
line 5942
;5942:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2607
line 5943
;5943:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2602
JUMPV
LABELV $2607
line 5945
;5944:		}
;5945:		item->window.backColor[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 132
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 5946
;5946:	}
LABELV $2604
line 5941
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2603
line 5947
;5947:	return qtrue;
CNSTI4 1
RETI4
LABELV $2602
endproc ItemParse_backcolor 12 8
proc ItemParse_forecolor 16 8
line 5950
;5948:}
;5949:
;5950:static qboolean ItemParse_forecolor(itemDef_t *item, int handle) {
line 5954
;5951:	int i;
;5952:	float f;
;5953:
;5954:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2610
line 5955
;5955:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2614
line 5956
;5956:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2609
JUMPV
LABELV $2614
line 5958
;5957:		}
;5958:		item->window.foreColor[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 5959
;5959:		item->window.flags |= WINDOW_FORECOLORSET;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 5960
;5960:	}
LABELV $2611
line 5954
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2610
line 5961
;5961:	return qtrue;
CNSTI4 1
RETI4
LABELV $2609
endproc ItemParse_forecolor 16 8
proc ItemParse_bordercolor 12 8
line 5964
;5962:}
;5963:
;5964:static qboolean ItemParse_bordercolor(itemDef_t *item, int handle) {
line 5968
;5965:	int i;
;5966:	float f;
;5967:
;5968:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2617
line 5969
;5969:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2621
line 5970
;5970:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2616
JUMPV
LABELV $2621
line 5972
;5971:		}
;5972:		item->window.borderColor[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 148
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 5973
;5973:	}
LABELV $2618
line 5968
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2617
line 5974
;5974:	return qtrue;
CNSTI4 1
RETI4
LABELV $2616
endproc ItemParse_bordercolor 12 8
proc ItemParse_outlinecolor 4 8
line 5977
;5975:}
;5976:
;5977:static qboolean ItemParse_outlinecolor(itemDef_t *item, int handle) {
line 5978
;5978:	if (!PC_Color_Parse(handle, &item->window.outlineColor)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Color_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2624
line 5979
;5979:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2623
JUMPV
LABELV $2624
line 5983
;5980:	}
;5981:	//FIXME ac hack
;5982:	//item->window.outlineColor[3] = 0.2;
;5983:	return qtrue;
CNSTI4 1
RETI4
LABELV $2623
endproc ItemParse_outlinecolor 4 8
proc ItemParse_background 20 8
line 5986
;5984:}
;5985:
;5986:static qboolean ItemParse_background(itemDef_t *item, int handle) {
line 5989
;5987:	const char *name;
;5988:
;5989:	if (!PC_String_Parse(handle, &name)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2627
line 5990
;5990:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2626
JUMPV
LABELV $2627
line 5992
;5991:	}
;5992:	if (Q_stricmp(name, item->window.backgroundName)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $2629
line 5993
;5993:		item->window.background = DC->registerShaderNoMip(name);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 5994
;5994:		item->window.backgroundName = String_Alloc(name);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 16
INDIRP4
ASGNP4
line 5995
;5995:	}
LABELV $2629
line 5997
;5996:
;5997:	return qtrue;
CNSTI4 1
RETI4
LABELV $2626
endproc ItemParse_background 20 8
proc ItemParse_backgroundReset 0 0
line 6000
;5998:}
;5999:
;6000:static qboolean ItemParse_backgroundReset(itemDef_t *item, int handle) {
line 6001
;6001:	item->window.background = 0;
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTI4 0
ASGNI4
line 6002
;6002:	item->window.backgroundName = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTP4 0
ASGNP4
line 6004
;6003:
;6004:	return qtrue;
CNSTI4 1
RETI4
LABELV $2631
endproc ItemParse_backgroundReset 0 0
proc ItemParse_cinematic 4 8
line 6007
;6005:}
;6006:
;6007:static qboolean ItemParse_cinematic(itemDef_t *item, int handle) {
line 6008
;6008:	if (!PC_String_Parse(handle, &item->window.cinematicName)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2633
line 6009
;6009:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2632
JUMPV
LABELV $2633
line 6011
;6010:	}
;6011:	return qtrue;
CNSTI4 1
RETI4
LABELV $2632
endproc ItemParse_cinematic 4 8
proc ItemParse_doubleClick 8 8
line 6014
;6012:}
;6013:
;6014:static qboolean ItemParse_doubleClick(itemDef_t *item, int handle) {
line 6017
;6015:	listBoxDef_t *listPtr;
;6016:
;6017:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 6018
;6018:	if (!item->typeData) {
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2636
line 6019
;6019:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2635
JUMPV
LABELV $2636
line 6022
;6020:	}
;6021:
;6022:	listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 6024
;6023:
;6024:	if (!PC_Script_Parse(handle, &listPtr->doubleClick)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2638
line 6025
;6025:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2635
JUMPV
LABELV $2638
line 6027
;6026:	}
;6027:	return qtrue;
CNSTI4 1
RETI4
LABELV $2635
endproc ItemParse_doubleClick 8 8
proc ItemParse_onFocus 4 8
line 6030
;6028:}
;6029:
;6030:static qboolean ItemParse_onFocus(itemDef_t *item, int handle) {
line 6031
;6031:	if (!PC_Script_Parse(handle, &item->onFocus)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2641
line 6032
;6032:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2640
JUMPV
LABELV $2641
line 6034
;6033:	}
;6034:	return qtrue;
CNSTI4 1
RETI4
LABELV $2640
endproc ItemParse_onFocus 4 8
proc ItemParse_leaveFocus 4 8
line 6037
;6035:}
;6036:
;6037:static qboolean ItemParse_leaveFocus(itemDef_t *item, int handle) {
line 6038
;6038:	if (!PC_Script_Parse(handle, &item->leaveFocus)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2644
line 6039
;6039:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2643
JUMPV
LABELV $2644
line 6041
;6040:	}
;6041:	return qtrue;
CNSTI4 1
RETI4
LABELV $2643
endproc ItemParse_leaveFocus 4 8
proc ItemParse_mouseEnter 4 8
line 6044
;6042:}
;6043:
;6044:static qboolean ItemParse_mouseEnter(itemDef_t *item, int handle) {
line 6045
;6045:	if (!PC_Script_Parse(handle, &item->mouseEnter)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2647
line 6046
;6046:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2646
JUMPV
LABELV $2647
line 6048
;6047:	}
;6048:	return qtrue;
CNSTI4 1
RETI4
LABELV $2646
endproc ItemParse_mouseEnter 4 8
proc ItemParse_mouseExit 4 8
line 6051
;6049:}
;6050:
;6051:static qboolean ItemParse_mouseExit(itemDef_t *item, int handle) {
line 6052
;6052:	if (!PC_Script_Parse(handle, &item->mouseExit)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2650
line 6053
;6053:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2649
JUMPV
LABELV $2650
line 6055
;6054:	}
;6055:	return qtrue;
CNSTI4 1
RETI4
LABELV $2649
endproc ItemParse_mouseExit 4 8
proc ItemParse_mouseEnterText 4 8
line 6058
;6056:}
;6057:
;6058:static qboolean ItemParse_mouseEnterText(itemDef_t *item, int handle) {
line 6059
;6059:	if (!PC_Script_Parse(handle, &item->mouseEnterText)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2653
line 6060
;6060:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2652
JUMPV
LABELV $2653
line 6062
;6061:	}
;6062:	return qtrue;
CNSTI4 1
RETI4
LABELV $2652
endproc ItemParse_mouseEnterText 4 8
proc ItemParse_mouseExitText 4 8
line 6065
;6063:}
;6064:
;6065:static qboolean ItemParse_mouseExitText(itemDef_t *item, int handle) {
line 6066
;6066:	if (!PC_Script_Parse(handle, &item->mouseExitText)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2656
line 6067
;6067:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2655
JUMPV
LABELV $2656
line 6069
;6068:	}
;6069:	return qtrue;
CNSTI4 1
RETI4
LABELV $2655
endproc ItemParse_mouseExitText 4 8
proc ItemParse_action 4 8
line 6072
;6070:}
;6071:
;6072:static qboolean ItemParse_action(itemDef_t *item, int handle) {
line 6073
;6073:	if (!PC_Script_Parse(handle, &item->action)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2659
line 6074
;6074:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2658
JUMPV
LABELV $2659
line 6076
;6075:	}
;6076:	return qtrue;
CNSTI4 1
RETI4
LABELV $2658
endproc ItemParse_action 4 8
proc ItemParse_special 4 8
line 6079
;6077:}
;6078:
;6079:static qboolean ItemParse_special(itemDef_t *item, int handle) {
line 6080
;6080:	if (!PC_Float_Parse(handle, &item->special)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 560
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2662
line 6081
;6081:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2661
JUMPV
LABELV $2662
line 6083
;6082:	}
;6083:	return qtrue;
CNSTI4 1
RETI4
LABELV $2661
endproc ItemParse_special 4 8
proc ItemParse_cvarTest 4 8
line 6086
;6084:}
;6085:
;6086:static qboolean ItemParse_cvarTest(itemDef_t *item, int handle) {
line 6087
;6087:	if (!PC_String_Parse(handle, &item->cvarTest)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2665
line 6088
;6088:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2664
JUMPV
LABELV $2665
line 6090
;6089:	}
;6090:	return qtrue;
CNSTI4 1
RETI4
LABELV $2664
endproc ItemParse_cvarTest 4 8
proc ItemParse_cvar 8 8
line 6093
;6091:}
;6092:
;6093:static qboolean ItemParse_cvar(itemDef_t *item, int handle) {
line 6096
;6094:	editFieldDef_t *editPtr;
;6095:
;6096:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 6097
;6097:	if (!PC_String_Parse(handle, &item->cvar)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2668
line 6098
;6098:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2667
JUMPV
LABELV $2668
line 6100
;6099:	}
;6100:	if (item->typeData) {
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2670
line 6101
;6101:		editPtr = (editFieldDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 6102
;6102:		editPtr->minVal = -1;
ADDRLP4 0
INDIRP4
CNSTF4 3212836864
ASGNF4
line 6103
;6103:		editPtr->maxVal = -1;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 3212836864
ASGNF4
line 6104
;6104:		editPtr->defVal = -1;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 3212836864
ASGNF4
line 6105
;6105:	}
LABELV $2670
line 6106
;6106:	return qtrue;
CNSTI4 1
RETI4
LABELV $2667
endproc ItemParse_cvar 8 8
proc ItemParse_cvarSet 16 8
line 6109
;6107:}
;6108:
;6109:static qboolean ItemParse_cvarSet(itemDef_t *item, int handle) {
line 6113
;6110:	const char *cvarName;
;6111:	const char *cvarString;
;6112:
;6113:	if (!PC_String_Parse(handle, &cvarName)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2673
line 6114
;6114:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2672
JUMPV
LABELV $2673
line 6116
;6115:	}
;6116:	if (!PC_String_Parse(handle, &cvarString)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2675
line 6117
;6117:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2672
JUMPV
LABELV $2675
line 6120
;6118:	}
;6119:
;6120:	DC->setCVar(cvarName, cvarString);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 6122
;6121:
;6122:	return qtrue;
CNSTI4 1
RETI4
LABELV $2672
endproc ItemParse_cvarSet 16 8
proc ItemParse_maxChars 12 8
line 6125
;6123:}
;6124:
;6125:static qboolean ItemParse_maxChars(itemDef_t *item, int handle) {
line 6129
;6126:	editFieldDef_t *editPtr;
;6127:	int maxChars;
;6128:
;6129:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 6130
;6130:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2678
line 6131
;6131:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2677
JUMPV
LABELV $2678
line 6133
;6132:
;6133:	if (!PC_Int_Parse(handle, &maxChars)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2680
line 6134
;6134:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2677
JUMPV
LABELV $2680
line 6136
;6135:	}
;6136:	editPtr = (editFieldDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 6137
;6137:	editPtr->maxChars = maxChars;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 6138
;6138:	return qtrue;
CNSTI4 1
RETI4
LABELV $2677
endproc ItemParse_maxChars 12 8
proc ItemParse_maxPaintChars 12 8
line 6141
;6139:}
;6140:
;6141:static qboolean ItemParse_maxPaintChars(itemDef_t *item, int handle) {
line 6145
;6142:	editFieldDef_t *editPtr;
;6143:	int maxChars;
;6144:
;6145:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 6146
;6146:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2683
line 6147
;6147:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2682
JUMPV
LABELV $2683
line 6149
;6148:
;6149:	if (!PC_Int_Parse(handle, &maxChars)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2685
line 6150
;6150:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2682
JUMPV
LABELV $2685
line 6152
;6151:	}
;6152:	editPtr = (editFieldDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 6153
;6153:	editPtr->maxPaintChars = maxChars;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 6154
;6154:	return qtrue;
CNSTI4 1
RETI4
LABELV $2682
endproc ItemParse_maxPaintChars 12 8
proc ItemParse_cvarFloat 20 8
line 6159
;6155:}
;6156:
;6157:
;6158:
;6159:static qboolean ItemParse_cvarFloat(itemDef_t *item, int handle) {
line 6162
;6160:	editFieldDef_t *editPtr;
;6161:
;6162:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 6163
;6163:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2688
line 6164
;6164:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2687
JUMPV
LABELV $2688
line 6165
;6165:	editPtr = (editFieldDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 6166
;6166:	if (PC_String_Parse(handle, &item->cvar) &&
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2690
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $2690
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2690
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $2690
line 6169
;6167:		PC_Float_Parse(handle, &editPtr->defVal) &&
;6168:		PC_Float_Parse(handle, &editPtr->minVal) &&
;6169:		PC_Float_Parse(handle, &editPtr->maxVal)) {
line 6170
;6170:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2687
JUMPV
LABELV $2690
line 6172
;6171:	}
;6172:	return qfalse;
CNSTI4 0
RETI4
LABELV $2687
endproc ItemParse_cvarFloat 20 8
proc ItemParse_cvarInt 20 8
line 6175
;6173:}
;6174:
;6175:static qboolean ItemParse_cvarInt(itemDef_t *item, int handle) {
line 6178
;6176:	editFieldDef_t *editPtr;
;6177:
;6178:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 6179
;6179:	if (!item->typeData) {
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2693
line 6180
;6180:		Com_Printf("^5parse int invalid type data\n");
ADDRGP4 $2695
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 6181
;6181:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2692
JUMPV
LABELV $2693
line 6183
;6182:	}
;6183:	editPtr = (editFieldDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 6185
;6184:	//FIXME PC_Int_Parse() ?
;6185:	if (PC_String_Parse(handle, &item->cvar) &&
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2696
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $2696
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2696
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $2696
line 6188
;6186:		PC_Float_Parse(handle, &editPtr->defVal) &&
;6187:		PC_Float_Parse(handle, &editPtr->minVal) &&
;6188:		PC_Float_Parse(handle, &editPtr->maxVal)) {
line 6189
;6189:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2692
JUMPV
LABELV $2696
line 6191
;6190:	}
;6191:	return qfalse;
CNSTI4 0
RETI4
LABELV $2692
endproc ItemParse_cvarInt 20 8
proc ItemParse_cvarStrList 1068 8
line 6194
;6192:}
;6193:
;6194:static qboolean ItemParse_cvarStrList(itemDef_t *item, int handle) {
line 6199
;6195:	pc_token_t token;
;6196:	multiDef_t *multiPtr;
;6197:	int pass;
;6198:
;6199:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 6200
;6200:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2699
line 6201
;6201:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2698
JUMPV
LABELV $2699
line 6202
;6202:	multiPtr = (multiDef_t *)item->typeData;
ADDRLP4 1040
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 6203
;6203:	multiPtr->count = 0;
ADDRLP4 1040
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 0
ASGNI4
line 6204
;6204:	multiPtr->strDef = qtrue;
ADDRLP4 1040
INDIRP4
CNSTI4 388
ADDP4
CNSTI4 1
ASGNI4
line 6205
;6205:	multiPtr->videoMode = qfalse;
ADDRLP4 1040
INDIRP4
CNSTI4 392
ADDP4
CNSTI4 0
ASGNI4
line 6207
;6206:
;6207:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1048
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $2701
line 6208
;6208:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2698
JUMPV
LABELV $2701
line 6209
;6209:	if (*token.string != '{') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $2703
line 6210
;6210:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2698
JUMPV
LABELV $2703
line 6213
;6211:	}
;6212:
;6213:	pass = 0;
ADDRLP4 1044
CNSTI4 0
ASGNI4
ADDRGP4 $2707
JUMPV
LABELV $2706
line 6214
;6214:	while (1) {
line 6216
;6215:		///////////////// here
;6216:		if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1052
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $2709
line 6217
;6217:			PC_SourceError(handle, "end of file inside menu item");
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $2711
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 6218
;6218:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2698
JUMPV
LABELV $2709
line 6221
;6219:		}
;6220:
;6221:		if (*token.string == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $2712
line 6222
;6222:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2698
JUMPV
LABELV $2712
line 6225
;6223:		}
;6224:
;6225:		if (*token.string == ',' || *token.string == ';') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 44
EQI4 $2719
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 59
NEI4 $2715
LABELV $2719
line 6226
;6226:			continue;
ADDRGP4 $2707
JUMPV
LABELV $2715
line 6229
;6227:		}
;6228:
;6229:		if (pass == 0) {
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $2720
line 6230
;6230:			multiPtr->cvarList[multiPtr->count] = String_Alloc(token.string);
ADDRLP4 0+16
ARGP4
ADDRLP4 1056
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 1040
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1040
INDIRP4
ADDP4
ADDRLP4 1056
INDIRP4
ASGNP4
line 6231
;6231:			pass = 1;
ADDRLP4 1044
CNSTI4 1
ASGNI4
line 6232
;6232:		} else {
ADDRGP4 $2721
JUMPV
LABELV $2720
line 6233
;6233:			multiPtr->cvarStr[multiPtr->count] = String_Alloc(token.string);
ADDRLP4 0+16
ARGP4
ADDRLP4 1056
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 1040
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1040
INDIRP4
CNSTI4 128
ADDP4
ADDP4
ADDRLP4 1056
INDIRP4
ASGNP4
line 6234
;6234:			pass = 0;
ADDRLP4 1044
CNSTI4 0
ASGNI4
line 6235
;6235:			multiPtr->count++;
ADDRLP4 1064
ADDRLP4 1040
INDIRP4
CNSTI4 384
ADDP4
ASGNP4
ADDRLP4 1064
INDIRP4
ADDRLP4 1064
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 6236
;6236:			if (multiPtr->count >= MAX_MULTI_CVARS) {
ADDRLP4 1040
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 32
LTI4 $2724
line 6237
;6237:				Com_Printf("^1ERROR:  ItemParse_cvarStrList() MAX_MULTI_CVARS(%d)\n", MAX_MULTI_CVARS);
ADDRGP4 $2726
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 6238
;6238:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2698
JUMPV
LABELV $2724
line 6240
;6239:			}
;6240:		}
LABELV $2721
line 6242
;6241:
;6242:	}
LABELV $2707
line 6214
ADDRGP4 $2706
JUMPV
line 6243
;6243:	return qfalse;
CNSTI4 0
RETI4
LABELV $2698
endproc ItemParse_cvarStrList 1068 8
proc ItemParse_cvarFloatList 1072 8
line 6246
;6244:}
;6245:
;6246:static qboolean ItemParse_cvarFloatList(itemDef_t *item, int handle) {
line 6250
;6247:	pc_token_t token;
;6248:	multiDef_t *multiPtr;
;6249:
;6250:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 6251
;6251:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2728
line 6252
;6252:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2727
JUMPV
LABELV $2728
line 6253
;6253:	multiPtr = (multiDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 6254
;6254:	multiPtr->count = 0;
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 0
ASGNI4
line 6255
;6255:	multiPtr->strDef = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
CNSTI4 0
ASGNI4
line 6256
;6256:	multiPtr->videoMode = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 392
ADDP4
CNSTI4 0
ASGNI4
line 6258
;6257:
;6258:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $2730
line 6259
;6259:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2727
JUMPV
LABELV $2730
line 6260
;6260:	if (*token.string != '{') {
ADDRLP4 4+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $2736
line 6261
;6261:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2727
JUMPV
LABELV $2735
line 6264
;6262:	}
;6263:
;6264:	while (1) {
line 6266
;6265:		/////////////// here
;6266:		if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 1048
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $2738
line 6267
;6267:			PC_SourceError(handle, "end of file inside menu item");
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $2711
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 6268
;6268:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2727
JUMPV
LABELV $2738
line 6271
;6269:		}
;6270:
;6271:		if (*token.string == '}') {
ADDRLP4 4+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $2740
line 6272
;6272:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2727
JUMPV
LABELV $2740
line 6275
;6273:		}
;6274:
;6275:		if (*token.string == ',' || *token.string == ';') {
ADDRLP4 4+16
INDIRI1
CVII4 1
CNSTI4 44
EQI4 $2747
ADDRLP4 4+16
INDIRI1
CVII4 1
CNSTI4 59
NEI4 $2743
LABELV $2747
line 6276
;6276:			continue;
ADDRGP4 $2736
JUMPV
LABELV $2743
line 6279
;6277:		}
;6278:
;6279:		multiPtr->cvarList[multiPtr->count] = String_Alloc(token.string);
ADDRLP4 4+16
ARGP4
ADDRLP4 1052
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
ADDP4
ADDRLP4 1052
INDIRP4
ASGNP4
line 6280
;6280:		if (!PC_Float_Parse(handle, &multiPtr->cvarValue[multiPtr->count])) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
ADDP4
ARGP4
ADDRLP4 1064
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $2749
line 6281
;6281:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2727
JUMPV
LABELV $2749
line 6284
;6282:		}
;6283:
;6284:		multiPtr->count++;
ADDRLP4 1068
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
ASGNP4
ADDRLP4 1068
INDIRP4
ADDRLP4 1068
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 6285
;6285:		if (multiPtr->count >= MAX_MULTI_CVARS) {
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 32
LTI4 $2751
line 6286
;6286:			Com_Printf(S_COLOR_YELLOW "ItemParse_cvarFloatList: MAX_MULTI_CVARS\n");
ADDRGP4 $2753
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 6287
;6287:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2727
JUMPV
LABELV $2751
line 6290
;6288:		}
;6289:
;6290:	}
LABELV $2736
line 6264
ADDRGP4 $2735
JUMPV
line 6291
;6291:	return qfalse;
CNSTI4 0
RETI4
LABELV $2727
endproc ItemParse_cvarFloatList 1072 8
proc ItemParse_addColorRange 44 12
line 6296
;6292:}
;6293:
;6294:
;6295:
;6296:static qboolean ItemParse_addColorRange(itemDef_t *item, int handle) {
line 6299
;6297:	colorRangeDef_t color;
;6298:
;6299:	if (PC_Float_Parse(handle, &color.low) &&
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0+16
ARGP4
ADDRLP4 24
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $2755
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0+20
ARGP4
ADDRLP4 28
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2755
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 32
ADDRGP4 PC_Color_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $2755
line 6301
;6300:		PC_Float_Parse(handle, &color.high) &&
;6301:		PC_Color_Parse(handle, &color.color)) {
line 6302
;6302:		if (item->numColors < MAX_COLOR_RANGES) {
ADDRFP4 0
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
CNSTI4 10
GEI4 $2759
line 6303
;6303:			memcpy(&item->colorRanges[item->numColors], &color, sizeof(color));
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
CNSTI4 24
MULI4
ADDRLP4 36
INDIRP4
CNSTI4 320
ADDP4
ADDP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 24
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 6304
;6304:			item->numColors++;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 316
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 6305
;6305:		} else {
ADDRGP4 $2760
JUMPV
LABELV $2759
line 6306
;6306:			Com_Printf("^1ERROR: MAX_COLOR_RANGES exceeded: %d >= %d\n", item->numColors, MAX_COLOR_RANGES);
ADDRGP4 $2761
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
ARGI4
CNSTI4 10
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 6307
;6307:		}
LABELV $2760
line 6308
;6308:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2754
JUMPV
LABELV $2755
line 6310
;6309:	}
;6310:	return qfalse;
CNSTI4 0
RETI4
LABELV $2754
endproc ItemParse_addColorRange 44 12
proc ItemParse_ownerdrawFlag 12 8
line 6313
;6311:}
;6312:
;6313:static qboolean ItemParse_ownerdrawFlag(itemDef_t *item, int handle) {
line 6315
;6314:	int i;
;6315:	if (!PC_Int_Parse(handle, &i)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2763
line 6316
;6316:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2762
JUMPV
LABELV $2763
line 6318
;6317:	}
;6318:	item->window.ownerDrawFlags |= i;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
BORI4
ASGNI4
line 6319
;6319:	return qtrue;
CNSTI4 1
RETI4
LABELV $2762
endproc ItemParse_ownerdrawFlag 12 8
proc ItemParse_ownerdrawFlag2 12 8
line 6322
;6320:}
;6321:
;6322:static qboolean ItemParse_ownerdrawFlag2(itemDef_t *item, int handle) {
line 6324
;6323:	int i;
;6324:	if (!PC_Int_Parse(handle, &i)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2766
line 6325
;6325:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2765
JUMPV
LABELV $2766
line 6327
;6326:	}
;6327:	item->window.ownerDrawFlags2 |= i;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
BORI4
ASGNI4
line 6328
;6328:	return qtrue;
CNSTI4 1
RETI4
LABELV $2765
endproc ItemParse_ownerdrawFlag2 12 8
proc ItemParse_enableCvar 4 8
line 6331
;6329:}
;6330:
;6331:static qboolean ItemParse_enableCvar(itemDef_t *item, int handle) {
line 6332
;6332:	if (PC_Script_Parse(handle, &item->enableCvar)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 292
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2769
line 6333
;6333:		item->cvarFlags = CVAR_ENABLE;
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
CNSTI4 1
ASGNI4
line 6334
;6334:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2768
JUMPV
LABELV $2769
line 6336
;6335:	}
;6336:	return qfalse;
CNSTI4 0
RETI4
LABELV $2768
endproc ItemParse_enableCvar 4 8
proc ItemParse_disableCvar 4 8
line 6339
;6337:}
;6338:
;6339:static qboolean ItemParse_disableCvar(itemDef_t *item, int handle) {
line 6340
;6340:	if (PC_Script_Parse(handle, &item->enableCvar)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 292
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2772
line 6341
;6341:		item->cvarFlags = CVAR_DISABLE;
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
CNSTI4 2
ASGNI4
line 6342
;6342:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2771
JUMPV
LABELV $2772
line 6344
;6343:	}
;6344:	return qfalse;
CNSTI4 0
RETI4
LABELV $2771
endproc ItemParse_disableCvar 4 8
proc ItemParse_showCvar 4 8
line 6347
;6345:}
;6346:
;6347:static qboolean ItemParse_showCvar(itemDef_t *item, int handle) {
line 6348
;6348:	if (PC_Script_Parse(handle, &item->enableCvar)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 292
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2775
line 6349
;6349:		item->cvarFlags = CVAR_SHOW;
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
CNSTI4 4
ASGNI4
line 6350
;6350:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2774
JUMPV
LABELV $2775
line 6352
;6351:	}
;6352:	return qfalse;
CNSTI4 0
RETI4
LABELV $2774
endproc ItemParse_showCvar 4 8
proc ItemParse_hideCvar 4 8
line 6355
;6353:}
;6354:
;6355:static qboolean ItemParse_hideCvar(itemDef_t *item, int handle) {
line 6356
;6356:	if (PC_Script_Parse(handle, &item->enableCvar)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 292
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2778
line 6357
;6357:		item->cvarFlags = CVAR_HIDE;
ADDRFP4 0
INDIRP4
CNSTI4 296
ADDP4
CNSTI4 8
ASGNI4
line 6358
;6358:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2777
JUMPV
LABELV $2778
line 6360
;6359:	}
;6360:	return qfalse;
CNSTI4 0
RETI4
LABELV $2777
endproc ItemParse_hideCvar 4 8
proc ItemParse_defaultContent 20 8
line 6363
;6361:}
;6362:
;6363:static qboolean ItemParse_defaultContent(itemDef_t *item, int handle) {
line 6366
;6364:	const char *temp;
;6365:
;6366:	if (!PC_String_Parse(handle, &temp)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2781
line 6367
;6367:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2780
JUMPV
LABELV $2781
line 6369
;6368:	}
;6369:	if (Q_stricmp(temp, item->window.backgroundName)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $2783
line 6370
;6370:		item->window.background = DC->registerShaderNoMip(temp);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 6371
;6371:		item->window.backgroundName = String_Alloc(temp);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 16
INDIRP4
ASGNP4
line 6372
;6372:	}
LABELV $2783
line 6373
;6373:	return qtrue;
CNSTI4 1
RETI4
LABELV $2780
endproc ItemParse_defaultContent 20 8
proc ItemParse_cellId 8 8
line 6376
;6374:}
;6375:
;6376:static qboolean ItemParse_cellId(itemDef_t *item, int handle) {
line 6378
;6377:	int i;
;6378:	if (!PC_Int_Parse(handle, &i)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2786
line 6379
;6379:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2785
JUMPV
LABELV $2786
line 6383
;6380:	}
;6381:	//item->window.ownerDrawFlags |= i;
;6382:	//FIXME
;6383:	return qtrue;
CNSTI4 1
RETI4
LABELV $2785
endproc ItemParse_cellId 8 8
proc ItemParse_font 180 12
line 6386
;6384:}
;6385:
;6386:static qboolean ItemParse_font(itemDef_t *item, int handle) {
line 6393
;6387:	const char *fontName;
;6388:	int pointSize;
;6389:	char checkName[MAX_QPATH];
;6390:	char baseName[MAX_QPATH];
;6391:	int i;
;6392:
;6393:	if (!PC_String_Parse(handle, &fontName)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 68
ARGP4
ADDRLP4 140
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
NEI4 $2789
line 6394
;6394:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2788
JUMPV
LABELV $2789
line 6400
;6395:	}
;6396:
;6397:	//Com_Printf("^4 fontName: '%s'\n", fontName);
;6398:
;6399:	// 2015-10-26 ql now added itemdef 'font' keyword which is an integer
;6400:	if (strlen(fontName) == 1 && (fontName[0] == '0' || fontName[0] == '1' || fontName[0] == '2')) {
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 1
NEI4 $2791
ADDRLP4 148
ADDRLP4 68
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 148
INDIRI4
CNSTI4 48
EQI4 $2794
ADDRLP4 148
INDIRI4
CNSTI4 49
EQI4 $2794
ADDRLP4 148
INDIRI4
CNSTI4 50
NEI4 $2791
LABELV $2794
line 6405
;6401:		int fontId;
;6402:
;6403:		//PC_SourceWarning(handle, "font %s\n", fontName);
;6404:		//FIXME pointSize  -- 2018-07-31 48 is too blurry for "notosans-regular" and "droidsansmono"
;6405:		pointSize = 48;
ADDRLP4 72
CNSTI4 48
ASGNI4
line 6407
;6406:		//pointSize = 24;
;6407:		fontId = atoi(fontName);
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 156
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 152
ADDRLP4 156
INDIRI4
ASGNI4
line 6408
;6408:		switch (fontId) {
ADDRLP4 160
ADDRLP4 152
INDIRI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
EQI4 $2801
ADDRLP4 160
INDIRI4
CNSTI4 1
EQI4 $2797
ADDRLP4 160
INDIRI4
CNSTI4 2
EQI4 $2799
ADDRGP4 $2795
JUMPV
LABELV $2797
line 6410
;6409:		case FONT_SANS:
;6410:			fontName = DEFAULT_SANS_FONT;
ADDRLP4 68
ADDRGP4 $2798
ASGNP4
line 6411
;6411:			pointSize = 24;
ADDRLP4 72
CNSTI4 24
ASGNI4
line 6412
;6412:			break;
ADDRGP4 $2792
JUMPV
LABELV $2799
line 6414
;6413:		case FONT_MONO:
;6414:			fontName = DEFAULT_MONO_FONT;
ADDRLP4 68
ADDRGP4 $2800
ASGNP4
line 6416
;6415:			// 2018-09-25 24 is blurry with textScale 0.6, auto font scale, threshold 9 or 24
;6416:			pointSize = 24;
ADDRLP4 72
CNSTI4 24
ASGNI4
line 6417
;6417:			break;
ADDRGP4 $2792
JUMPV
LABELV $2795
LABELV $2801
line 6420
;6418:		default:
;6419:		case FONT_DEFAULT:
;6420:			fontName = DEFAULT_FONT;
ADDRLP4 68
ADDRGP4 $2802
ASGNP4
line 6421
;6421:			break;
line 6423
;6422:		}
;6423:	} else {  // wolfcamql font keyword (fontname : pointsize)
ADDRGP4 $2792
JUMPV
LABELV $2791
line 6424
;6424:		if (!PC_Int_Parse(handle, &pointSize)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 72
ARGP4
ADDRLP4 152
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $2803
line 6425
;6425:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2788
JUMPV
LABELV $2803
line 6427
;6426:		}
;6427:	}
LABELV $2792
line 6429
;6428:
;6429:	if (!Q_stricmp(fontName, "qlfont")) {
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 $2807
ARGP4
ADDRLP4 152
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
NEI4 $2805
line 6430
;6430:		item->fontIndex = 0;
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
CNSTI4 0
ASGNI4
line 6431
;6431:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2788
JUMPV
LABELV $2805
line 6432
;6432:	} else if (!Q_stricmp(fontName, "q3tiny") || !Q_stricmp(fontName, "q3small") || !Q_stricmp(fontName, "q3big") || !Q_stricmp(fontName, "q3giant")) {
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 $2810
ARGP4
ADDRLP4 156
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 156
INDIRI4
CNSTI4 0
EQI4 $2816
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 $2811
ARGP4
ADDRLP4 160
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
EQI4 $2816
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 $2812
ARGP4
ADDRLP4 164
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 164
INDIRI4
CNSTI4 0
EQI4 $2816
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 $2813
ARGP4
ADDRLP4 168
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 168
INDIRI4
CNSTI4 0
NEI4 $2808
LABELV $2816
line 6433
;6433:		Q_strncpyz(checkName, fontName, sizeof(checkName));
ADDRLP4 4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 6434
;6434:	} else {
ADDRGP4 $2809
JUMPV
LABELV $2808
line 6435
;6435:		Q_strncpyz(checkName, fontName, sizeof(checkName));
ADDRLP4 4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 6436
;6436:		COM_StripExtension(COM_SkipPath(checkName), baseName, sizeof(baseName));
ADDRLP4 4
ARGP4
ADDRLP4 172
ADDRGP4 COM_SkipPath
CALLP4
ASGNP4
ADDRLP4 172
INDIRP4
ARGP4
ADDRLP4 76
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 COM_StripExtension
CALLV
pop
line 6437
;6437:		Q_strncpyz(checkName, va("fonts2/%s_%i.dat", baseName, pointSize), sizeof(checkName));
ADDRGP4 $2817
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 176
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 176
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 6438
;6438:	}
LABELV $2809
line 6440
;6439:
;6440:	for (i = 0; i <= DC->Assets.numFonts; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2821
JUMPV
LABELV $2818
line 6442
;6441:		//Com_Printf("^5%d '%s'\n", i, DC->Assets.extraFonts[i].name);
;6442:		if (!Q_stricmp(checkName, DC->Assets.extraFonts[i].name)) {
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 20548
MULI4
ADDRGP4 DC
INDIRP4
CNSTI4 61892
ADDP4
ADDP4
CNSTI4 20484
ADDP4
ARGP4
ADDRLP4 172
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
NEI4 $2822
line 6444
;6443:			//Com_Printf("font '%s' already loaded\n", fontName);
;6444:			item->fontIndex = i;
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 6445
;6445:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2788
JUMPV
LABELV $2822
line 6447
;6446:		}
;6447:	}
LABELV $2819
line 6440
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2821
ADDRLP4 0
INDIRI4
ADDRGP4 DC
INDIRP4
CNSTI4 5342728
ADDP4
INDIRI4
LEI4 $2818
line 6449
;6448:
;6449:	if (DC->Assets.numFonts + 1 >= MAX_FONTS + 1) {
ADDRGP4 DC
INDIRP4
CNSTI4 5342728
ADDP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 257
LTI4 $2824
line 6450
;6450:		Com_Printf("^3ItemParse_font() MAX_FONTS (%d) reached, couldn't load '%s'\n", MAX_FONTS, fontName);
ADDRGP4 $2826
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 6451
;6451:		item->fontIndex = 0;
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
CNSTI4 0
ASGNI4
line 6452
;6452:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2788
JUMPV
LABELV $2824
line 6455
;6453:	}
;6454:
;6455:	DC->registerFont(fontName, pointSize, &DC->Assets.extraFonts[DC->Assets.numFonts + 1]);
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 172
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 172
INDIRP4
CNSTI4 5342728
ADDP4
INDIRI4
CNSTI4 20548
MULI4
ADDRLP4 172
INDIRP4
CNSTI4 82440
ADDP4
ADDP4
ARGP4
ADDRLP4 172
INDIRP4
CNSTI4 64
ADDP4
INDIRP4
CALLV
pop
line 6456
;6456:	item->fontIndex = DC->Assets.numFonts + 1;
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 5342728
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 6457
;6457:	DC->Assets.numFonts++;
ADDRLP4 176
ADDRGP4 DC
INDIRP4
CNSTI4 5342728
ADDP4
ASGNP4
ADDRLP4 176
INDIRP4
ADDRLP4 176
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 6459
;6458:
;6459:	return qtrue;
CNSTI4 1
RETI4
LABELV $2788
endproc ItemParse_font 180 12
proc ItemParse_precision 4 8
line 6462
;6460:}
;6461:
;6462:static qboolean ItemParse_precision(itemDef_t *item, int handle) {
line 6463
;6463:	if (!PC_Int_Parse(handle, &item->precision)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 568
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2828
line 6464
;6464:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2827
JUMPV
LABELV $2828
line 6466
;6465:	}
;6466:	return qtrue;
CNSTI4 1
RETI4
LABELV $2827
endproc ItemParse_precision 4 8
proc Q_GetToken 32 4
line 6470
;6467:}
;6468:
;6469://FIXME UTF-8  --  2016-02-22 ok used with predefined math tokens
;6470:static char *Q_GetToken(char *inputString, char *token, qboolean isFilename, qboolean *newLine) {
line 6475
;6471:	char *p;
;6472:	char c;
;6473:	qboolean gotFirstToken;
;6474:
;6475:	if (!inputString) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2831
line 6476
;6476:		Com_Printf("Q_GetToken inputString == NULL\n");
ADDRGP4 $2833
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 6477
;6477:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $2830
JUMPV
LABELV $2831
line 6480
;6478:	}
;6479:
;6480:	*newLine = qfalse;
ADDRFP4 12
INDIRP4
CNSTI4 0
ASGNI4
line 6481
;6481:	p = inputString;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 6482
;6482:	token[0] = '\0';
ADDRFP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 6484
;6483:
;6484:	if (p[0] == '\0') {  //  ||  (p[0] != '\t'  &&  (p[0] < ' '  ||  p[0] > '~'))) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2834
line 6486
;6485:		//Com_Printf("xx\n");
;6486:		*newLine = qtrue;
ADDRFP4 12
INDIRP4
CNSTI4 1
ASGNI4
line 6488
;6487:		//Com_Printf("CG_GetToken() '%s'\n", tokenOrig);
;6488:		return p;
ADDRLP4 4
INDIRP4
RETP4
ADDRGP4 $2830
JUMPV
LABELV $2834
line 6499
;6489:	}
;6490:
;6491:#if 0
;6492:	if (p[0] == '\0' || (p[0] != '\t' && (p[0] < ' ' || p[0] > '~'))) {
;6493:		Com_Printf("xx\n");
;6494:		*newLine = qtrue;
;6495:		return p;
;6496:	}
;6497:#endif
;6498:
;6499:	gotFirstToken = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $2837
JUMPV
LABELV $2836
line 6501
;6500:
;6501:	while (1) {
line 6502
;6502:		c = p[0];
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRI1
ASGNI1
line 6503
;6503:		if (c == '\0') {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2839
line 6505
;6504:			//Com_Printf("end\n");
;6505:			*newLine = qtrue;
ADDRFP4 12
INDIRP4
CNSTI4 1
ASGNI4
line 6506
;6506:			break;
ADDRGP4 $2838
JUMPV
LABELV $2839
line 6509
;6507:		}
;6508:		//FIXME UTF-8  --  2016-02-22 ok used with predefined math tokens
;6509:		if (c != '\t' && (c < ' ' || c > '~')) {
ADDRLP4 12
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 9
EQI4 $2841
ADDRLP4 12
INDIRI4
CNSTI4 32
LTI4 $2843
ADDRLP4 12
INDIRI4
CNSTI4 126
LEI4 $2841
LABELV $2843
line 6510
;6510:			*newLine = qtrue;
ADDRFP4 12
INDIRP4
CNSTI4 1
ASGNI4
line 6511
;6511:			if (gotFirstToken) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $2838
line 6512
;6512:				p--;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 -1
ADDP4
ASGNP4
line 6513
;6513:			}
line 6514
;6514:			break;
ADDRGP4 $2838
JUMPV
LABELV $2841
line 6517
;6515:		}
;6516:
;6517:		if (c == ' ' || c == '\t' || c == '\'' || c == '"') {
ADDRLP4 16
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 32
EQI4 $2850
ADDRLP4 16
INDIRI4
CNSTI4 9
EQI4 $2850
ADDRLP4 16
INDIRI4
CNSTI4 39
EQI4 $2850
ADDRLP4 16
INDIRI4
CNSTI4 34
NEI4 $2846
LABELV $2850
line 6518
;6518:			if (!gotFirstToken) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2838
line 6519
;6519:				p++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 6520
;6520:				continue;
ADDRGP4 $2837
JUMPV
line 6521
;6521:			} else {
line 6522
;6522:				break;
LABELV $2846
line 6526
;6523:			}
;6524:		}
;6525:
;6526:		if (!isFilename && (c == '/' || c == '-' || c == '+' || c == '*' || c == '(' || c == ')' || c == ',')) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $2853
ADDRLP4 20
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 47
EQI4 $2860
ADDRLP4 20
INDIRI4
CNSTI4 45
EQI4 $2860
ADDRLP4 20
INDIRI4
CNSTI4 43
EQI4 $2860
ADDRLP4 20
INDIRI4
CNSTI4 42
EQI4 $2860
ADDRLP4 20
INDIRI4
CNSTI4 40
EQI4 $2860
ADDRLP4 20
INDIRI4
CNSTI4 41
EQI4 $2860
ADDRLP4 20
INDIRI4
CNSTI4 44
NEI4 $2853
LABELV $2860
line 6527
;6527:			if (gotFirstToken) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $2861
line 6528
;6528:				p--;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 -1
ADDP4
ASGNP4
line 6529
;6529:				break;
ADDRGP4 $2838
JUMPV
LABELV $2861
line 6530
;6530:			} else {
line 6531
;6531:				token[0] = c;
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI1
ASGNI1
line 6532
;6532:				token++;
ADDRFP4 4
ADDRFP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 6533
;6533:				break;
ADDRGP4 $2838
JUMPV
LABELV $2853
line 6538
;6534:			}
;6535:		}
;6536:
;6537:		//FIXME UTF-8  --  2016-02-22 ok used with predefined math tokens
;6538:		if (c < '!' || c > '~') {
ADDRLP4 24
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 33
LTI4 $2865
ADDRLP4 24
INDIRI4
CNSTI4 126
LEI4 $2863
LABELV $2865
line 6539
;6539:			break;
ADDRGP4 $2838
JUMPV
LABELV $2863
line 6542
;6540:		}
;6541:
;6542:		if (c == '{' || c == '}') {
ADDRLP4 28
ADDRLP4 0
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 123
EQI4 $2868
ADDRLP4 28
INDIRI4
CNSTI4 125
NEI4 $2866
LABELV $2868
line 6543
;6543:			if (gotFirstToken) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $2869
line 6544
;6544:				p--;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 -1
ADDP4
ASGNP4
line 6545
;6545:				break;
ADDRGP4 $2838
JUMPV
LABELV $2869
line 6547
;6546:			}
;6547:		}
LABELV $2866
line 6549
;6548:
;6549:		token[0] = c;
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI1
ASGNI1
line 6550
;6550:		token++;
ADDRFP4 4
ADDRFP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 6551
;6551:		p++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 6552
;6552:		gotFirstToken = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 6553
;6553:	}
LABELV $2837
line 6501
ADDRGP4 $2836
JUMPV
LABELV $2838
line 6555
;6554:
;6555:	p++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 6556
;6556:	token[0] = '\0';
ADDRFP4 4
INDIRP4
CNSTI1 0
ASGNI1
line 6568
;6557:
;6558:#if 0
;6559:	if (isFilename) {
;6560:		Com_Printf("^6filename token: '%s'\n", start);
;6561:	} else {
;6562:		Com_Printf("^5token: '%s'\n", start);
;6563:	}
;6564:#endif
;6565:
;6566:	//Com_Printf("CG_GetToken() '%s'\n", tokenOrig);
;6567:
;6568:	return p;
ADDRLP4 4
INDIRP4
RETP4
LABELV $2830
endproc Q_GetToken 32 4
data
align 4
LABELV $2872
byte 4 0
export Q_MathScript
code
proc Q_MathScript 1480 20
line 6610
;6569:}
;6570:
;6571://FIXME
;6572:#define OP_NOP 0
;6573:#define OP_PLUS 1
;6574:#define OP_MINUS 2
;6575:#define OP_MULT 3
;6576:#define OP_DIV 4
;6577:#define OP_LESS 5
;6578:#define OP_GREATER 6
;6579:#define OP_NOT 7
;6580:#define OP_EQUAL 8
;6581:#define OP_AND 9
;6582:#define OP_OR 10
;6583:#define OP_VAL 11
;6584:#define OP_MOD 12
;6585:
;6586://#define OP_CVAR 12  //FIXME probably not
;6587://#define OP_RAND 13
;6588:
;6589:#define OP_FSQRT 14
;6590:#define OP_FCEIL 15
;6591:#define OP_FFLOOR 16
;6592:#define OP_FSIN 17
;6593:#define OP_FCOS 18
;6594:#define OP_FWAVE 19
;6595:#define OP_FCLIP 20
;6596:#define OP_FACOS 21
;6597:#define OP_FASIN 22
;6598:#define OP_FATAN 23
;6599:#define OP_FATAN2 24
;6600:#define OP_FTAN 25
;6601:#define OP_FPOW 26
;6602:#define OP_FOWNERDRAWVALUE 27
;6603:#define OP_FINWATER 28
;6604:
;6605:#define OP_FUNCFIRST OP_FSQRT
;6606:#define OP_FUNCLAST OP_FINWATER
;6607:
;6608:#define USE_SWITCH 0
;6609:
;6610:char *Q_MathScript(char *script, float *val, int *error) {
line 6624
;6611:	char token[MAX_QPATH];
;6612:	char buffer[256];  //FIXME
;6613:	char *p;
;6614:	float ops[256];
;6615:	int numOps;
;6616:	int i;
;6617:	int j;
;6618:	int err;
;6619:	static int recursiveCount = 0;
;6620:	int uniqueId;
;6621:	qboolean newLine;
;6622:	int verbose;
;6623:
;6624:	recursiveCount++;
ADDRLP4 1376
ADDRGP4 $2872
ASGNP4
ADDRLP4 1376
INDIRP4
ADDRLP4 1376
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 6625
;6625:	uniqueId = rand();
ADDRLP4 1380
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1372
ADDRLP4 1380
INDIRI4
ASGNI4
line 6626
;6626:	verbose = qfalse;  //SC_Cvar_Get_Int("debug_math");
ADDRLP4 1368
CNSTI4 0
ASGNI4
line 6631
;6627:	//verbose = SC_Cvar_Get_Int("debug_math");
;6628:
;6629:	//Com_Printf("math(%d %d): '%s'\n", recursiveCount, uniqueId, script);
;6630:
;6631:	newLine = qfalse;
ADDRLP4 1364
CNSTI4 0
ASGNI4
line 6632
;6632:	numOps = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
ADDRGP4 $2874
JUMPV
LABELV $2873
line 6633
;6633:	while (1) {
line 6634
;6634:		script = Q_GetToken(script, token, qfalse, &newLine);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1300
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1364
ARGP4
ADDRLP4 1384
ADDRGP4 Q_GetToken
CALLP4
ASGNP4
ADDRFP4 0
ADDRLP4 1384
INDIRP4
ASGNP4
line 6635
;6635:		if (verbose) {
ADDRLP4 1368
INDIRI4
CNSTI4 0
EQI4 $2876
line 6637
;6636:			//Com_Printf("token: '%s'  script[0] '%c' %d  newLine:%d\n", token, script[0], script[0], newLine);
;6637:			Com_Printf("qmath token: '%s'  script[0] %d  newLine:%d\n", token, script[0], newLine);
ADDRGP4 $2878
ARGP4
ADDRLP4 1300
ARGP4
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 1364
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 6638
;6638:		}
LABELV $2876
line 6639
;6639:		if (token[0] == '\0' || token[0] == '{') {  //  ||  newLine)  {  // ||  end) {
ADDRLP4 1388
ADDRLP4 1300
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1388
INDIRI4
CNSTI4 0
EQI4 $2881
ADDRLP4 1388
INDIRI4
CNSTI4 123
NEI4 $2879
LABELV $2881
line 6641
;6640:			//if (token[0] == '\0'  ||  token[0] == '}') {  //  ||  newLine)  {  // ||  end) {
;6641:			break;
ADDRGP4 $2875
JUMPV
LABELV $2879
line 6644
;6642:		}
;6643:
;6644:		if (token[0] == '(') {
ADDRLP4 1300
INDIRI1
CVII4 1
CNSTI4 40
NEI4 $2882
line 6647
;6645:			int parenCount;
;6646:
;6647:			parenCount = 1;
ADDRLP4 1392
CNSTI4 1
ASGNI4
line 6648
;6648:			p = script;
ADDRLP4 1036
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 $2885
JUMPV
LABELV $2884
line 6649
;6649:			while (1) {
line 6652
;6650:				float tmpVal;
;6651:
;6652:				if (p[0] == '(') {
ADDRLP4 1036
INDIRP4
INDIRI1
CVII4 1
CNSTI4 40
NEI4 $2887
line 6653
;6653:					parenCount++;
ADDRLP4 1392
ADDRLP4 1392
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 6654
;6654:				} else if (p[0] == ')') {
ADDRGP4 $2888
JUMPV
LABELV $2887
ADDRLP4 1036
INDIRP4
INDIRI1
CVII4 1
CNSTI4 41
NEI4 $2889
line 6655
;6655:					parenCount--;
ADDRLP4 1392
ADDRLP4 1392
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 6656
;6656:				}
LABELV $2889
LABELV $2888
line 6658
;6657:
;6658:				if (p[0] == '\t') {  // the only non printable char allowed
ADDRLP4 1036
INDIRP4
INDIRI1
CVII4 1
CNSTI4 9
NEI4 $2891
line 6659
;6659:					p++;
ADDRLP4 1036
ADDRLP4 1036
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 6660
;6660:					continue;
ADDRGP4 $2885
JUMPV
LABELV $2891
line 6663
;6661:				}
;6662:
;6663:				if (parenCount == 0 || p[0] == '\0' || p[0] == '\n' || (p[0] < ' ' || p[0] > '~')) {
ADDRLP4 1392
INDIRI4
CNSTI4 0
EQI4 $2898
ADDRLP4 1400
ADDRLP4 1036
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1400
INDIRI4
CNSTI4 0
EQI4 $2898
ADDRLP4 1400
INDIRI4
CNSTI4 10
EQI4 $2898
ADDRLP4 1400
INDIRI4
CNSTI4 32
LTI4 $2898
ADDRLP4 1400
INDIRI4
CNSTI4 126
LEI4 $2893
LABELV $2898
line 6664
;6664:					memcpy(buffer, script, p - script);
ADDRLP4 1044
ARGP4
ADDRLP4 1404
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1404
INDIRP4
ARGP4
ADDRLP4 1036
INDIRP4
CVPU4 4
ADDRLP4 1404
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 6665
;6665:					buffer[p - script] = '\0';
ADDRLP4 1036
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ADDRLP4 1044
ADDP4
CNSTI1 0
ASGNI1
line 6667
;6666:					//Com_Printf("paren(%d): %d '%s'\n", recursiveCount + 1, p - script, buffer);
;6667:					err = 0;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 6668
;6668:					Q_MathScript(buffer, &tmpVal, &err);
ADDRLP4 1044
ARGP4
ADDRLP4 1396
ARGP4
ADDRLP4 1040
ARGP4
ADDRGP4 Q_MathScript
CALLP4
pop
line 6669
;6669:					if (err) {
ADDRLP4 1040
INDIRI4
CNSTI4 0
EQI4 $2899
line 6670
;6670:						*error = err;
ADDRFP4 8
INDIRP4
ADDRLP4 1040
INDIRI4
ASGNI4
line 6671
;6671:						recursiveCount--;
ADDRLP4 1408
ADDRGP4 $2872
ASGNP4
ADDRLP4 1408
INDIRP4
ADDRLP4 1408
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 6672
;6672:						return script;
ADDRFP4 0
INDIRP4
RETP4
ADDRGP4 $2871
JUMPV
LABELV $2899
line 6674
;6673:					}
;6674:					ops[numOps] = OP_VAL;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1093664768
ASGNF4
line 6675
;6675:					numOps++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 6676
;6676:					ops[numOps] = tmpVal;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 1396
INDIRF4
ASGNF4
line 6677
;6677:					numOps++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 6678
;6678:					script = p + 1;
ADDRFP4 0
ADDRLP4 1036
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 6679
;6679:					break;
ADDRGP4 $2886
JUMPV
LABELV $2893
line 6681
;6680:				}
;6681:				p++;
ADDRLP4 1036
ADDRLP4 1036
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 6682
;6682:			}
LABELV $2885
line 6649
ADDRGP4 $2884
JUMPV
LABELV $2886
line 6683
;6683:		}
LABELV $2882
line 6685
;6684:
;6685:		if (0) {
ADDRGP4 $2901
JUMPV
line 6687
;6686:
;6687:		} else if (!USE_SWITCH && token[0] == '+') {
ADDRGP4 $2902
JUMPV
LABELV $2901
ADDRLP4 1300
INDIRI1
CVII4 1
CNSTI4 43
NEI4 $2903
line 6688
;6688:			ops[numOps] = OP_PLUS;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1065353216
ASGNF4
line 6689
;6689:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6690
;6690:			goto tokenHandled;
ADDRGP4 $2905
JUMPV
LABELV $2903
line 6691
;6691:		} else if (!USE_SWITCH && token[0] == '-') {
ADDRLP4 1300
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $2906
line 6692
;6692:			ops[numOps] = OP_MINUS;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1073741824
ASGNF4
line 6693
;6693:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6694
;6694:			goto tokenHandled;
ADDRGP4 $2905
JUMPV
LABELV $2906
line 6695
;6695:		} else if (!USE_SWITCH && token[0] == '*') {
ADDRLP4 1300
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $2908
line 6696
;6696:			ops[numOps] = OP_MULT;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1077936128
ASGNF4
line 6697
;6697:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6698
;6698:			goto tokenHandled;
ADDRGP4 $2905
JUMPV
LABELV $2908
line 6699
;6699:		} else if (!USE_SWITCH && token[0] == '/') {
ADDRLP4 1300
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $2910
line 6700
;6700:			ops[numOps] = OP_DIV;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1082130432
ASGNF4
line 6701
;6701:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6702
;6702:			goto tokenHandled;
ADDRGP4 $2905
JUMPV
LABELV $2910
line 6703
;6703:		} else if (!USE_SWITCH && token[0] == '%') {
ADDRLP4 1300
INDIRI1
CVII4 1
CNSTI4 37
NEI4 $2912
line 6704
;6704:			ops[numOps] = OP_MOD;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1094713344
ASGNF4
line 6705
;6705:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6706
;6706:			goto tokenHandled;
ADDRGP4 $2905
JUMPV
LABELV $2912
line 6707
;6707:		} else if (!USE_SWITCH && token[0] == '<') {
ADDRLP4 1300
INDIRI1
CVII4 1
CNSTI4 60
NEI4 $2914
line 6708
;6708:			ops[numOps] = OP_LESS;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1084227584
ASGNF4
line 6709
;6709:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6710
;6710:			goto tokenHandled;
ADDRGP4 $2905
JUMPV
LABELV $2914
line 6711
;6711:		} else if (token[0] == '>') {
ADDRLP4 1300
INDIRI1
CVII4 1
CNSTI4 62
NEI4 $2916
line 6712
;6712:			ops[numOps] = OP_GREATER;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1086324736
ASGNF4
line 6713
;6713:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6714
;6714:		} else if (token[0] == '!') {
ADDRGP4 $2917
JUMPV
LABELV $2916
ADDRLP4 1300
INDIRI1
CVII4 1
CNSTI4 33
NEI4 $2918
line 6715
;6715:			ops[numOps] = OP_NOT;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1088421888
ASGNF4
line 6716
;6716:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6717
;6717:		} else if (token[0] == '=') {
ADDRGP4 $2919
JUMPV
LABELV $2918
ADDRLP4 1300
INDIRI1
CVII4 1
CNSTI4 61
NEI4 $2920
line 6718
;6718:			ops[numOps] = OP_EQUAL;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1090519040
ASGNF4
line 6719
;6719:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6720
;6720:		} else if (token[0] == '&') {
ADDRGP4 $2921
JUMPV
LABELV $2920
ADDRLP4 1300
INDIRI1
CVII4 1
CNSTI4 38
NEI4 $2922
line 6721
;6721:			ops[numOps] = OP_AND;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1091567616
ASGNF4
line 6722
;6722:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6723
;6723:		} else if (token[0] == '|') {
ADDRGP4 $2923
JUMPV
LABELV $2922
ADDRLP4 1300
INDIRI1
CVII4 1
CNSTI4 124
NEI4 $2924
line 6724
;6724:			ops[numOps] = OP_OR;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1092616192
ASGNF4
line 6725
;6725:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6726
;6726:		} else if (!USE_SWITCH && (token[0] == '.' || (token[0] >= '0' && token[0] <= '9'))) {  //((token[0] >= '0'  &&  token[0] <= '9')  ||  (token[0] == '-'  &&  (token[1] >= '0'  &&  token[1] <= '9'))) {
ADDRGP4 $2925
JUMPV
LABELV $2924
ADDRLP4 1392
ADDRLP4 1300
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1392
INDIRI4
CNSTI4 46
EQI4 $2928
ADDRLP4 1392
INDIRI4
CNSTI4 48
LTI4 $2926
ADDRLP4 1392
INDIRI4
CNSTI4 57
GTI4 $2926
LABELV $2928
line 6728
;6727:			//opnumbertoken:
;6728:			ops[numOps] = OP_VAL;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1093664768
ASGNF4
line 6729
;6729:			numOps++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 6730
;6730:			ops[numOps] = atof(token);
ADDRLP4 1300
ARGP4
ADDRLP4 1396
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 1396
INDIRF4
ASGNF4
line 6731
;6731:			numOps++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 6732
;6732:			goto tokenHandled;
ADDRGP4 $2905
JUMPV
LABELV $2926
line 6742
;6733:#if 0
;6734:		} else if (!Q_stricmpt(token, "time")) {
;6735:			ops[numOps] = OP_VAL;
;6736:			ops[numOps + 1] = (cg.ftime - (float)cgs.levelStartTime) / 1000.0;
;6737:			//ops[numOps + 1] = (cg.time - (float)cgs.levelStartTime) / 1000.0;
;6738:			numOps += 2;
;6739:#endif
;6740:			// functions //
;6741:
;6742:		} else if (!Q_stricmp(token, "sqrt")) {
ADDRLP4 1300
ARGP4
ADDRGP4 $2931
ARGP4
ADDRLP4 1396
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1396
INDIRI4
CNSTI4 0
NEI4 $2929
line 6743
;6743:			ops[numOps] = OP_FSQRT;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1096810496
ASGNF4
line 6744
;6744:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6745
;6745:		} else if (!Q_stricmp(token, "ceil")) {
ADDRGP4 $2930
JUMPV
LABELV $2929
ADDRLP4 1300
ARGP4
ADDRGP4 $2934
ARGP4
ADDRLP4 1400
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1400
INDIRI4
CNSTI4 0
NEI4 $2932
line 6746
;6746:			ops[numOps] = OP_FCEIL;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1097859072
ASGNF4
line 6747
;6747:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6748
;6748:		} else if (!Q_stricmp(token, "floor")) {
ADDRGP4 $2933
JUMPV
LABELV $2932
ADDRLP4 1300
ARGP4
ADDRGP4 $2937
ARGP4
ADDRLP4 1404
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1404
INDIRI4
CNSTI4 0
NEI4 $2935
line 6749
;6749:			ops[numOps] = OP_FFLOOR;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1098907648
ASGNF4
line 6750
;6750:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6751
;6751:		} else if (!Q_stricmp(token, "sin")) {
ADDRGP4 $2936
JUMPV
LABELV $2935
ADDRLP4 1300
ARGP4
ADDRGP4 $2940
ARGP4
ADDRLP4 1408
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1408
INDIRI4
CNSTI4 0
NEI4 $2938
line 6752
;6752:			ops[numOps] = OP_FSIN;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1099431936
ASGNF4
line 6753
;6753:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6754
;6754:		} else if (!Q_stricmp(token, "cos")) {
ADDRGP4 $2939
JUMPV
LABELV $2938
ADDRLP4 1300
ARGP4
ADDRGP4 $2943
ARGP4
ADDRLP4 1412
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1412
INDIRI4
CNSTI4 0
NEI4 $2941
line 6755
;6755:			ops[numOps] = OP_FCOS;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1099956224
ASGNF4
line 6756
;6756:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6757
;6757:		} else if (!Q_stricmp(token, "wave")) {
ADDRGP4 $2942
JUMPV
LABELV $2941
ADDRLP4 1300
ARGP4
ADDRGP4 $2946
ARGP4
ADDRLP4 1416
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1416
INDIRI4
CNSTI4 0
NEI4 $2944
line 6758
;6758:			ops[numOps] = OP_FWAVE;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1100480512
ASGNF4
line 6759
;6759:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6760
;6760:		} else if (!Q_stricmp(token, "clip")) {
ADDRGP4 $2945
JUMPV
LABELV $2944
ADDRLP4 1300
ARGP4
ADDRGP4 $2949
ARGP4
ADDRLP4 1420
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1420
INDIRI4
CNSTI4 0
NEI4 $2947
line 6761
;6761:			ops[numOps] = OP_FCLIP;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1101004800
ASGNF4
line 6762
;6762:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6763
;6763:		} else if (!Q_stricmp(token, "acos")) {
ADDRGP4 $2948
JUMPV
LABELV $2947
ADDRLP4 1300
ARGP4
ADDRGP4 $2952
ARGP4
ADDRLP4 1424
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1424
INDIRI4
CNSTI4 0
NEI4 $2950
line 6764
;6764:			ops[numOps] = OP_FACOS;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1101529088
ASGNF4
line 6765
;6765:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6766
;6766:		} else if (!Q_stricmp(token, "asin")) {
ADDRGP4 $2951
JUMPV
LABELV $2950
ADDRLP4 1300
ARGP4
ADDRGP4 $2955
ARGP4
ADDRLP4 1428
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1428
INDIRI4
CNSTI4 0
NEI4 $2953
line 6767
;6767:			ops[numOps] = OP_FASIN;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1102053376
ASGNF4
line 6768
;6768:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6769
;6769:		} else if (!Q_stricmp(token, "atan")) {
ADDRGP4 $2954
JUMPV
LABELV $2953
ADDRLP4 1300
ARGP4
ADDRGP4 $2958
ARGP4
ADDRLP4 1432
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1432
INDIRI4
CNSTI4 0
NEI4 $2956
line 6770
;6770:			ops[numOps] = OP_FATAN;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1102577664
ASGNF4
line 6771
;6771:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6772
;6772:		} else if (!Q_stricmp(token, "atan2")) {
ADDRGP4 $2957
JUMPV
LABELV $2956
ADDRLP4 1300
ARGP4
ADDRGP4 $2961
ARGP4
ADDRLP4 1436
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1436
INDIRI4
CNSTI4 0
NEI4 $2959
line 6773
;6773:			ops[numOps] = OP_FATAN2;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1103101952
ASGNF4
line 6774
;6774:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6775
;6775:		} else if (!Q_stricmp(token, "tan")) {
ADDRGP4 $2960
JUMPV
LABELV $2959
ADDRLP4 1300
ARGP4
ADDRGP4 $2964
ARGP4
ADDRLP4 1440
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1440
INDIRI4
CNSTI4 0
NEI4 $2962
line 6776
;6776:			ops[numOps] = OP_FTAN;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1103626240
ASGNF4
line 6777
;6777:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6778
;6778:		} else if (!Q_stricmp(token, "pow")) {
ADDRGP4 $2963
JUMPV
LABELV $2962
ADDRLP4 1300
ARGP4
ADDRGP4 $2967
ARGP4
ADDRLP4 1444
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1444
INDIRI4
CNSTI4 0
NEI4 $2965
line 6779
;6779:			ops[numOps] = OP_FPOW;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1104150528
ASGNF4
line 6780
;6780:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6781
;6781:		} else if (!Q_stricmp(token, "pi")) {
ADDRGP4 $2966
JUMPV
LABELV $2965
ADDRLP4 1300
ARGP4
ADDRGP4 $2970
ARGP4
ADDRLP4 1448
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1448
INDIRI4
CNSTI4 0
NEI4 $2968
line 6782
;6782:			ops[numOps] = OP_VAL;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1093664768
ASGNF4
line 6783
;6783:			numOps++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 6784
;6784:			ops[numOps] = M_PI;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1078530011
ASGNF4
line 6785
;6785:			numOps++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 6786
;6786:		} else if (!Q_stricmp(token, "rand")) {
ADDRGP4 $2969
JUMPV
LABELV $2968
ADDRLP4 1300
ARGP4
ADDRGP4 $2973
ARGP4
ADDRLP4 1452
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1452
INDIRI4
CNSTI4 0
NEI4 $2971
line 6787
;6787:			ops[numOps] = OP_VAL;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1093664768
ASGNF4
line 6788
;6788:			ops[numOps + 1] = random();
ADDRLP4 1456
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+4
ADDP4
ADDRLP4 1456
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
ASGNF4
line 6789
;6789:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6790
;6790:		} else if (!Q_stricmp(token, "crand")) {
ADDRGP4 $2972
JUMPV
LABELV $2971
ADDRLP4 1300
ARGP4
ADDRGP4 $2977
ARGP4
ADDRLP4 1456
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1456
INDIRI4
CNSTI4 0
NEI4 $2975
line 6791
;6791:			ops[numOps] = OP_VAL;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1093664768
ASGNF4
line 6792
;6792:			ops[numOps + 1] = crandom();
ADDRLP4 1460
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+4
ADDP4
ADDRLP4 1460
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
ASGNF4
line 6793
;6793:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6794
;6794:		} else if (!Q_stricmp(token, "realtime")) {
ADDRGP4 $2976
JUMPV
LABELV $2975
ADDRLP4 1300
ARGP4
ADDRGP4 $2981
ARGP4
ADDRLP4 1460
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1460
INDIRI4
CNSTI4 0
NEI4 $2979
line 6797
;6795:			float val;
;6796:
;6797:			val = DC->realTime;
ADDRLP4 1464
ADDRGP4 DC
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 6798
;6798:			ops[numOps] = OP_VAL;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1093664768
ASGNF4
line 6799
;6799:			ops[numOps + 1] = val;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+4
ADDP4
ADDRLP4 1464
INDIRF4
ASGNF4
line 6800
;6800:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6801
;6801:		} else if (!Q_stricmp(token, "gametime")) {
ADDRGP4 $2980
JUMPV
LABELV $2979
ADDRLP4 1300
ARGP4
ADDRGP4 $2985
ARGP4
ADDRLP4 1464
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1464
INDIRI4
CNSTI4 0
NEI4 $2983
line 6804
;6802:			float val;
;6803:
;6804:			val = DC->cgTime;
ADDRLP4 1468
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ASGNF4
line 6805
;6805:			ops[numOps] = OP_VAL;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1093664768
ASGNF4
line 6806
;6806:			ops[numOps + 1] = val;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+4
ADDP4
ADDRLP4 1468
INDIRF4
ASGNF4
line 6807
;6807:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6808
;6808:		} else if (!Q_stricmp(token, "ownerdrawvalue")) {
ADDRGP4 $2984
JUMPV
LABELV $2983
ADDRLP4 1300
ARGP4
ADDRGP4 $2989
ARGP4
ADDRLP4 1468
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1468
INDIRI4
CNSTI4 0
NEI4 $2987
line 6809
;6809:			ops[numOps] = OP_FOWNERDRAWVALUE;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1104674816
ASGNF4
line 6810
;6810:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6811
;6811:		} else if (token[0] == '@') {
ADDRGP4 $2988
JUMPV
LABELV $2987
ADDRLP4 1300
INDIRI1
CVII4 1
CNSTI4 64
NEI4 $2990
line 6814
;6812:			float f;
;6813:
;6814:			f = MenuVar_Get(token);
ADDRLP4 1300
ARGP4
ADDRLP4 1476
ADDRGP4 MenuVar_Get
CALLF4
ASGNF4
ADDRLP4 1472
ADDRLP4 1476
INDIRF4
ASGNF4
line 6816
;6815:
;6816:			ops[numOps] = OP_VAL;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1093664768
ASGNF4
line 6817
;6817:			ops[numOps + 1] = f;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+4
ADDP4
ADDRLP4 1472
INDIRF4
ASGNF4
line 6818
;6818:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6819
;6819:		} else if (token[0] == '(') {
ADDRGP4 $2991
JUMPV
LABELV $2990
ADDRLP4 1300
INDIRI1
CVII4 1
CNSTI4 40
NEI4 $2993
line 6821
;6820:			// pass
;6821:		} else if (DC->cvarExists(token)) {
ADDRGP4 $2994
JUMPV
LABELV $2993
ADDRLP4 1300
ARGP4
ADDRLP4 1472
ADDRGP4 DC
INDIRP4
CNSTI4 100
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1472
INDIRI4
CNSTI4 0
EQI4 $2995
line 6823
;6822:			//FIXME check @vars
;6823:			ops[numOps] = OP_VAL;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1093664768
ASGNF4
line 6824
;6824:			ops[numOps + 1] = DC->getCVarValue(token);  //trap_Cvar_VariableValue(token)  //SC_Cvar_Get_Float(token);
ADDRLP4 1300
ARGP4
ADDRLP4 1476
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+4
ADDP4
ADDRLP4 1476
INDIRF4
ASGNF4
line 6825
;6825:			numOps += 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6826
;6826:			if (verbose) {
ADDRLP4 1368
INDIRI4
CNSTI4 0
EQI4 $2996
line 6829
;6827:				//Com_Printf("^3q3math unknown token: 's'\n", token);
;6828:				//Com_Printf("cvar: '%s' %f\n", token, SC_Cvar_Get_Float(token));
;6829:			}
line 6830
;6830:		} else {
ADDRGP4 $2996
JUMPV
LABELV $2995
line 6831
;6831:			Com_Printf("^3qmath unknown token/cvar '%s'\n", token);
ADDRGP4 $3000
ARGP4
ADDRLP4 1300
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 6832
;6832:			recursiveCount--;
ADDRLP4 1476
ADDRGP4 $2872
ASGNP4
ADDRLP4 1476
INDIRP4
ADDRLP4 1476
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 6833
;6833:			return script;
ADDRFP4 0
INDIRP4
RETP4
ADDRGP4 $2871
JUMPV
LABELV $2996
LABELV $2994
LABELV $2991
LABELV $2988
LABELV $2984
LABELV $2980
LABELV $2976
LABELV $2972
LABELV $2969
LABELV $2966
LABELV $2963
LABELV $2960
LABELV $2957
LABELV $2954
LABELV $2951
LABELV $2948
LABELV $2945
LABELV $2942
LABELV $2939
LABELV $2936
LABELV $2933
LABELV $2930
LABELV $2925
LABELV $2923
LABELV $2921
LABELV $2919
LABELV $2917
LABELV $2902
LABELV $2905
line 6837
;6834:		}
;6835:
;6836:	tokenHandled:
;6837:		if (newLine) {
ADDRLP4 1364
INDIRI4
CNSTI4 0
EQI4 $3001
line 6838
;6838:			break;
ADDRGP4 $2875
JUMPV
LABELV $3001
line 6840
;6839:		}
;6840:	}
LABELV $2874
line 6633
ADDRGP4 $2873
JUMPV
LABELV $2875
line 6843
;6841:
;6842:	// sanity check
;6843:	if (ops[0] >= OP_PLUS && ops[0] <= OP_OR && ops[0] != OP_MINUS) {
ADDRLP4 1384
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 1384
INDIRF4
CNSTF4 1065353216
LTF4 $3003
ADDRLP4 1384
INDIRF4
CNSTF4 1092616192
GTF4 $3003
ADDRLP4 1384
INDIRF4
CNSTF4 1073741824
EQF4 $3003
line 6844
;6844:		*error = 1;
ADDRFP4 8
INDIRP4
CNSTI4 1
ASGNI4
line 6845
;6845:		Com_Printf("^3qmath invalid first token(%d %d): %f\n", recursiveCount, uniqueId, ops[0]);
ADDRGP4 $3005
ARGP4
ADDRGP4 $2872
INDIRI4
ARGI4
ADDRLP4 1372
INDIRI4
ARGI4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 Com_Printf
CALLV
pop
line 6846
;6846:		recursiveCount--;
ADDRLP4 1388
ADDRGP4 $2872
ASGNP4
ADDRLP4 1388
INDIRP4
ADDRLP4 1388
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 6847
;6847:		return script;
ADDRFP4 0
INDIRP4
RETP4
ADDRGP4 $2871
JUMPV
LABELV $3003
line 6850
;6848:	}
;6849:
;6850:	if (numOps > 0 && (ops[numOps - 2] >= OP_PLUS && ops[numOps - 2] <= OP_OR)) {
ADDRLP4 1028
INDIRI4
CNSTI4 0
LEI4 $3006
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-8
ADDP4
INDIRF4
CNSTF4 1065353216
LTF4 $3006
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-8
ADDP4
INDIRF4
CNSTF4 1092616192
GTF4 $3006
line 6851
;6851:		*error = 2;
ADDRFP4 8
INDIRP4
CNSTI4 2
ASGNI4
line 6852
;6852:		Com_Printf("^3qmath invalid last token(%d %d): %f\n", recursiveCount, uniqueId, ops[numOps - 2]);
ADDRGP4 $3010
ARGP4
ADDRGP4 $2872
INDIRI4
ARGI4
ADDRLP4 1372
INDIRI4
ARGI4
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-8
ADDP4
INDIRF4
ARGF4
ADDRGP4 Com_Printf
CALLV
pop
line 6853
;6853:		recursiveCount--;
ADDRLP4 1392
ADDRGP4 $2872
ASGNP4
ADDRLP4 1392
INDIRP4
ADDRLP4 1392
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 6854
;6854:		return script;
ADDRFP4 0
INDIRP4
RETP4
ADDRGP4 $2871
JUMPV
LABELV $3006
line 6858
;6855:	}
;6856:
;6857:	// functions
;6858:	for (i = numOps - 2; i >= 0; i -= 2) {
ADDRLP4 1032
ADDRLP4 1028
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
ADDRGP4 $3015
JUMPV
LABELV $3012
line 6861
;6859:		float val, val2;
;6860:
;6861:		if (ops[i] < OP_FUNCFIRST || ops[i] > OP_FUNCLAST) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1096810496
LTF4 $3018
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1105199104
LEF4 $3016
LABELV $3018
line 6862
;6862:			continue;
ADDRGP4 $3013
JUMPV
LABELV $3016
line 6865
;6863:		}
;6864:
;6865:		val = 0;
ADDRLP4 1392
CNSTF4 0
ASGNF4
line 6866
;6866:		if ((i + 2) < (numOps - 1)) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
ADDI4
ADDRLP4 1028
INDIRI4
CNSTI4 1
SUBI4
GEI4 $3019
line 6867
;6867:			if (ops[i + 2] != OP_VAL) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+8
ADDP4
INDIRF4
CNSTF4 1093664768
EQF4 $3021
line 6868
;6868:				*error = 6;
ADDRFP4 8
INDIRP4
CNSTI4 6
ASGNI4
line 6869
;6869:				Com_Printf("^3qmath invalid function value type (%d %d): %f\n", recursiveCount, uniqueId, ops[i + 2]);
ADDRGP4 $3024
ARGP4
ADDRGP4 $2872
INDIRI4
ARGI4
ADDRLP4 1372
INDIRI4
ARGI4
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+8
ADDP4
INDIRF4
ARGF4
ADDRGP4 Com_Printf
CALLV
pop
line 6870
;6870:				recursiveCount--;
ADDRLP4 1404
ADDRGP4 $2872
ASGNP4
ADDRLP4 1404
INDIRP4
ADDRLP4 1404
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 6871
;6871:				return script;
ADDRFP4 0
INDIRP4
RETP4
ADDRGP4 $2871
JUMPV
LABELV $3021
line 6873
;6872:			}
;6873:			val = ops[i + 3];
ADDRLP4 1392
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+12
ADDP4
INDIRF4
ASGNF4
line 6874
;6874:		}
LABELV $3019
line 6876
;6875:
;6876:		if (ops[i] == OP_FSQRT) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1096810496
NEF4 $3027
line 6877
;6877:			val = sqrt(val);
ADDRLP4 1392
INDIRF4
ARGF4
ADDRLP4 1404
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 1392
ADDRLP4 1404
INDIRF4
ASGNF4
line 6878
;6878:		} else if (ops[i] == OP_FCEIL) {
ADDRGP4 $3028
JUMPV
LABELV $3027
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1097859072
NEF4 $3029
line 6879
;6879:			val = ceil(val);
ADDRLP4 1392
INDIRF4
ARGF4
ADDRLP4 1404
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 1392
ADDRLP4 1404
INDIRF4
ASGNF4
line 6880
;6880:		} else if (ops[i] == OP_FFLOOR) {
ADDRGP4 $3030
JUMPV
LABELV $3029
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1098907648
NEF4 $3031
line 6881
;6881:			val = floor(val);
ADDRLP4 1392
INDIRF4
ARGF4
ADDRLP4 1404
ADDRGP4 floor
CALLF4
ASGNF4
ADDRLP4 1392
ADDRLP4 1404
INDIRF4
ASGNF4
line 6882
;6882:		} else if (ops[i] == OP_FSIN) {
ADDRGP4 $3032
JUMPV
LABELV $3031
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1099431936
NEF4 $3033
line 6883
;6883:			val = sin(DEG2RAD(val));
ADDRLP4 1392
INDIRF4
CNSTF4 1016003125
MULF4
ARGF4
ADDRLP4 1404
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 1392
ADDRLP4 1404
INDIRF4
ASGNF4
line 6884
;6884:		} else if (ops[i] == OP_FCOS) {
ADDRGP4 $3034
JUMPV
LABELV $3033
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1099956224
NEF4 $3035
line 6885
;6885:			val = cos(DEG2RAD(val));
ADDRLP4 1392
INDIRF4
CNSTF4 1016003125
MULF4
ARGF4
ADDRLP4 1404
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 1392
ADDRLP4 1404
INDIRF4
ASGNF4
line 6886
;6886:		} else if (ops[i] == OP_FWAVE) {
ADDRGP4 $3036
JUMPV
LABELV $3035
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1100480512
NEF4 $3037
line 6889
;6887:			//val = sin(val / M_PI);
;6888:			// fucking q3mme -- this is what they have
;6889:			val = sin(val * 2 * M_PI);
ADDRLP4 1392
INDIRF4
CNSTF4 1086918619
MULF4
ARGF4
ADDRLP4 1404
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 1392
ADDRLP4 1404
INDIRF4
ASGNF4
line 6890
;6890:		} else if (ops[i] == OP_FCLIP) {
ADDRGP4 $3038
JUMPV
LABELV $3037
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1101004800
NEF4 $3039
line 6891
;6891:			if (val < 0.0) {
ADDRLP4 1392
INDIRF4
CNSTF4 0
GEF4 $3041
line 6892
;6892:				val = 0;
ADDRLP4 1392
CNSTF4 0
ASGNF4
line 6893
;6893:			} else if (val > 1.0) {
ADDRGP4 $3040
JUMPV
LABELV $3041
ADDRLP4 1392
INDIRF4
CNSTF4 1065353216
LEF4 $3040
line 6894
;6894:				val = 1;
ADDRLP4 1392
CNSTF4 1065353216
ASGNF4
line 6895
;6895:			}
line 6896
;6896:		} else if (ops[i] == OP_FACOS) {
ADDRGP4 $3040
JUMPV
LABELV $3039
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1101529088
NEF4 $3045
line 6897
;6897:			val = RAD2DEG(acos(val));
ADDRLP4 1392
INDIRF4
ARGF4
ADDRLP4 1404
ADDRGP4 acos
CALLF4
ASGNF4
ADDRLP4 1392
ADDRLP4 1404
INDIRF4
CNSTF4 1113927393
MULF4
ASGNF4
line 6898
;6898:		} else if (ops[i] == OP_FASIN) {
ADDRGP4 $3046
JUMPV
LABELV $3045
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1102053376
NEF4 $3047
line 6899
;6899:			val = RAD2DEG(M_PI / 2.0 - acos(val));
ADDRLP4 1392
INDIRF4
ARGF4
ADDRLP4 1404
ADDRGP4 acos
CALLF4
ASGNF4
ADDRLP4 1392
CNSTF4 1070141403
ADDRLP4 1404
INDIRF4
SUBF4
CNSTF4 1113927393
MULF4
ASGNF4
line 6900
;6900:		} else if (ops[i] == OP_FATAN) {
ADDRGP4 $3048
JUMPV
LABELV $3047
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1102577664
NEF4 $3049
line 6901
;6901:			val = RAD2DEG(M_PI / 2.0 - acos(val / (sqrt(val * val + 1))));
ADDRLP4 1392
INDIRF4
ADDRLP4 1392
INDIRF4
MULF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 1408
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 1392
INDIRF4
ADDRLP4 1408
INDIRF4
DIVF4
ARGF4
ADDRLP4 1412
ADDRGP4 acos
CALLF4
ASGNF4
ADDRLP4 1392
CNSTF4 1070141403
ADDRLP4 1412
INDIRF4
SUBF4
CNSTF4 1113927393
MULF4
ASGNF4
line 6902
;6902:		} else if (ops[i] == OP_FATAN2) {
ADDRGP4 $3050
JUMPV
LABELV $3049
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1103101952
NEF4 $3051
line 6903
;6903:			val2 = ops[i + 5];
ADDRLP4 1396
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+20
ADDP4
INDIRF4
ASGNF4
line 6904
;6904:			val = RAD2DEG(atan2(val, val2));
ADDRLP4 1392
INDIRF4
ARGF4
ADDRLP4 1396
INDIRF4
ARGF4
ADDRLP4 1404
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRLP4 1392
ADDRLP4 1404
INDIRF4
CNSTF4 1113927393
MULF4
ASGNF4
line 6905
;6905:			numOps -= 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 6906
;6906:		} else if (ops[i] == OP_FTAN) {
ADDRGP4 $3052
JUMPV
LABELV $3051
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1103626240
NEF4 $3054
line 6907
;6907:			val = tan(DEG2RAD(val));
ADDRLP4 1392
INDIRF4
CNSTF4 1016003125
MULF4
ARGF4
ADDRLP4 1404
ADDRGP4 tan
CALLF4
ASGNF4
ADDRLP4 1392
ADDRLP4 1404
INDIRF4
ASGNF4
line 6908
;6908:		} else if (ops[i] == OP_FPOW) {
ADDRGP4 $3055
JUMPV
LABELV $3054
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1104150528
NEF4 $3056
line 6909
;6909:			val2 = ops[i + 5];
ADDRLP4 1396
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+20
ADDP4
INDIRF4
ASGNF4
line 6910
;6910:			val = Q_fpow(val, val2);
ADDRLP4 1392
INDIRF4
ARGF4
ADDRLP4 1396
INDIRF4
ARGF4
ADDRLP4 1404
ADDRGP4 Q_fpow
CALLF4
ASGNF4
ADDRLP4 1392
ADDRLP4 1404
INDIRF4
ASGNF4
line 6911
;6911:			numOps -= 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 6912
;6912:		} else if (ops[i] == OP_FOWNERDRAWVALUE) {
ADDRGP4 $3057
JUMPV
LABELV $3056
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1104674816
NEF4 $3059
line 6913
;6913:			val = DC->getValue(val);
ADDRLP4 1392
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 1404
ADDRGP4 DC
INDIRP4
CNSTI4 72
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 1392
ADDRLP4 1404
INDIRF4
ASGNF4
line 6914
;6914:		} else {
ADDRGP4 $3060
JUMPV
LABELV $3059
line 6915
;6915:			Com_Printf("^3qmath unknown function %f\n", ops[i]);
ADDRGP4 $3061
ARGP4
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ARGF4
ADDRGP4 Com_Printf
CALLV
pop
line 6916
;6916:		}
LABELV $3060
LABELV $3057
LABELV $3055
LABELV $3052
LABELV $3050
LABELV $3048
LABELV $3046
LABELV $3040
LABELV $3038
LABELV $3036
LABELV $3034
LABELV $3032
LABELV $3030
LABELV $3028
line 6918
;6917:
;6918:		ops[i] = OP_VAL;
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1093664768
ASGNF4
line 6919
;6919:		ops[i + 1] = val;
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+4
ADDP4
ADDRLP4 1392
INDIRF4
ASGNF4
line 6921
;6920:
;6921:		for (j = i + 4; j < numOps; j++) {
ADDRLP4 0
ADDRLP4 1032
INDIRI4
CNSTI4 4
ADDI4
ASGNI4
ADDRGP4 $3066
JUMPV
LABELV $3063
line 6922
;6922:			ops[j - 2] = ops[j];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ASGNF4
line 6923
;6923:		}
LABELV $3064
line 6921
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3066
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $3063
line 6924
;6924:		numOps -= 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 6925
;6925:	}
LABELV $3013
line 6858
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
LABELV $3015
ADDRLP4 1032
INDIRI4
CNSTI4 0
GEI4 $3012
line 6928
;6926:
;6927:	// checking
;6928:	for (i = 2; i < numOps; i += 2) {
ADDRLP4 1032
CNSTI4 2
ASGNI4
ADDRGP4 $3071
JUMPV
LABELV $3068
line 6929
;6929:		if (ops[i] >= OP_PLUS && ops[i] <= OP_OR) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1065353216
LTF4 $3072
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1092616192
GTF4 $3072
line 6930
;6930:			if (ops[i + 2] >= OP_PLUS && ops[i + 2] <= OP_OR) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+8
ADDP4
INDIRF4
CNSTF4 1065353216
LTF4 $3074
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+8
ADDP4
INDIRF4
CNSTF4 1092616192
GTF4 $3074
line 6931
;6931:				if (ops[i + 2] != OP_MINUS) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+8
ADDP4
INDIRF4
CNSTF4 1073741824
EQF4 $3078
line 6932
;6932:					*error = 3;
ADDRFP4 8
INDIRP4
CNSTI4 3
ASGNI4
line 6933
;6933:					Com_Printf("^3qmath two operands following each other(%d %d)\n", recursiveCount, uniqueId);
ADDRGP4 $3081
ARGP4
ADDRGP4 $2872
INDIRI4
ARGI4
ADDRLP4 1372
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 6934
;6934:					recursiveCount--;
ADDRLP4 1400
ADDRGP4 $2872
ASGNP4
ADDRLP4 1400
INDIRP4
ADDRLP4 1400
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 6935
;6935:					return script;
ADDRFP4 0
INDIRP4
RETP4
ADDRGP4 $2871
JUMPV
LABELV $3078
line 6936
;6936:				} else {
line 6937
;6937:					i += 2;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
line 6938
;6938:				}
line 6939
;6939:			}
LABELV $3074
line 6940
;6940:		}
LABELV $3072
line 6941
;6941:	}
LABELV $3069
line 6928
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
LABELV $3071
ADDRLP4 1032
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $3068
line 6944
;6942:
;6943:	// - as multiplier
;6944:	for (i = 0; i < numOps; i += 2) {
ADDRLP4 1032
CNSTI4 0
ASGNI4
ADDRGP4 $3085
JUMPV
LABELV $3082
line 6945
;6945:		if (ops[i] == OP_NOP) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
NEF4 $3086
line 6946
;6946:			continue;
ADDRGP4 $3083
JUMPV
LABELV $3086
line 6948
;6947:		}
;6948:		if (ops[i] == OP_MINUS) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $3088
line 6949
;6949:			if (i == 0 || (i >= 2 && (ops[i - 2] >= OP_PLUS && ops[i - 2] <= OP_OR))) {
ADDRLP4 1032
INDIRI4
CNSTI4 0
EQI4 $3094
ADDRLP4 1032
INDIRI4
CNSTI4 2
LTI4 $3090
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-8
ADDP4
INDIRF4
CNSTF4 1065353216
LTF4 $3090
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-8
ADDP4
INDIRF4
CNSTF4 1092616192
GTF4 $3090
LABELV $3094
line 6950
;6950:				ops[i] = OP_VAL;
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
CNSTF4 1093664768
ASGNF4
line 6951
;6951:				ops[i + 1] = -(ops[i + 3]);
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+4
ADDP4
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+12
ADDP4
INDIRF4
NEGF4
ASGNF4
line 6952
;6952:				for (j = i + 4; j < numOps; j++) {
ADDRLP4 0
ADDRLP4 1032
INDIRI4
CNSTI4 4
ADDI4
ASGNI4
ADDRGP4 $3100
JUMPV
LABELV $3097
line 6953
;6953:					ops[j - 2] = ops[j];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ASGNF4
line 6954
;6954:				}
LABELV $3098
line 6952
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3100
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $3097
line 6955
;6955:				numOps -= 2;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 6956
;6956:			}
LABELV $3090
line 6957
;6957:		}
LABELV $3088
line 6958
;6958:	}
LABELV $3083
line 6944
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
LABELV $3085
ADDRLP4 1032
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $3082
line 6962
;6959:
;6960:	// * /
;6961:
;6962:	for (i = 0; i < numOps; i += 2) {
ADDRLP4 1032
CNSTI4 0
ASGNI4
ADDRGP4 $3105
JUMPV
LABELV $3102
line 6963
;6963:		if (ops[i] == OP_NOP) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
NEF4 $3106
line 6964
;6964:			continue;
ADDRGP4 $3103
JUMPV
LABELV $3106
line 6967
;6965:		}
;6966:
;6967:		if (ops[i] == OP_MULT) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1077936128
NEF4 $3108
line 6969
;6968:			//Com_Printf("(%d %d)  %f * %f\n", recursiveCount, uniqueId, ops[i - 1], ops[i + 3]);
;6969:			ops[i - 1] *= ops[i + 3];
ADDRLP4 1396
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
ASGNP4
ADDRLP4 1396
INDIRP4
ADDRLP4 1396
INDIRP4
INDIRF4
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+12
ADDP4
INDIRF4
MULF4
ASGNF4
line 6970
;6970:			for (j = i + 4; j < numOps; j++) {
ADDRLP4 0
ADDRLP4 1032
INDIRI4
CNSTI4 4
ADDI4
ASGNI4
ADDRGP4 $3115
JUMPV
LABELV $3112
line 6971
;6971:				ops[j - 4] = ops[j];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ASGNF4
line 6972
;6972:			}
LABELV $3113
line 6970
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3115
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $3112
line 6973
;6973:			numOps -= 4;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 4
SUBI4
ASGNI4
line 6974
;6974:			i -= 2;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 6975
;6975:			continue;
ADDRGP4 $3103
JUMPV
LABELV $3108
line 6976
;6976:		} else if (ops[i] == OP_DIV) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1082130432
NEF4 $3117
line 6983
;6977:			//Com_Printf("(%d %d)  %f / %f\n", recursiveCount, uniqueId, ops[i - 1], ops[i + 3]);
;6978:#if 0
;6979:			if (ops[i + 3] == 0.0) {
;6980:				Com_Printf("^3qmath divide by zero\n");
;6981:			}
;6982:#endif
;6983:			ops[i - 1] /= ops[i + 3];
ADDRLP4 1396
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
ASGNP4
ADDRLP4 1396
INDIRP4
ADDRLP4 1396
INDIRP4
INDIRF4
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+12
ADDP4
INDIRF4
DIVF4
ASGNF4
line 6984
;6984:			for (j = i + 4; j < numOps; j++) {
ADDRLP4 0
ADDRLP4 1032
INDIRI4
CNSTI4 4
ADDI4
ASGNI4
ADDRGP4 $3124
JUMPV
LABELV $3121
line 6985
;6985:				ops[j - 4] = ops[j];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ASGNF4
line 6986
;6986:			}
LABELV $3122
line 6984
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3124
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $3121
line 6987
;6987:			numOps -= 4;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 4
SUBI4
ASGNI4
line 6988
;6988:			i -= 2;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 6989
;6989:			continue;
ADDRGP4 $3103
JUMPV
LABELV $3117
line 6990
;6990:		} else if (ops[i] == OP_MOD) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1094713344
NEF4 $3126
line 6992
;6991:			//Com_Printf("(%d %d)  %f % %f\n", recursiveCount, uniqueId, ops[i - 1], ops[i + 3]);
;6992:			ops[i - 1] = (int)floor(ops[i - 1]) % (int)floor(ops[i + 3]);
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRF4
ARGF4
ADDRLP4 1396
ADDRGP4 floor
CALLF4
ASGNF4
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+12
ADDP4
INDIRF4
ARGF4
ADDRLP4 1400
ADDRGP4 floor
CALLF4
ASGNF4
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
ADDRLP4 1396
INDIRF4
CVFI4 4
ADDRLP4 1400
INDIRF4
CVFI4 4
MODI4
CVIF4 4
ASGNF4
line 6993
;6993:			for (j = i + 4; j < numOps; j++) {
ADDRLP4 0
ADDRLP4 1032
INDIRI4
CNSTI4 4
ADDI4
ASGNI4
ADDRGP4 $3134
JUMPV
LABELV $3131
line 6994
;6994:				ops[j - 4] = ops[j];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ASGNF4
line 6995
;6995:			}
LABELV $3132
line 6993
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3134
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $3131
line 6996
;6996:			numOps -= 4;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 4
SUBI4
ASGNI4
line 6997
;6997:			i -= 2;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 6998
;6998:			continue;
LABELV $3126
line 7000
;6999:		}
;7000:	}
LABELV $3103
line 6962
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
LABELV $3105
ADDRLP4 1032
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $3102
line 7004
;7001:
;7002:	// + -
;7003:
;7004:	for (i = 0; i < numOps; i += 2) {
ADDRLP4 1032
CNSTI4 0
ASGNI4
ADDRGP4 $3139
JUMPV
LABELV $3136
line 7005
;7005:		if (ops[i] == OP_NOP) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
NEF4 $3140
line 7006
;7006:			continue;
ADDRGP4 $3137
JUMPV
LABELV $3140
line 7009
;7007:		}
;7008:
;7009:		if (ops[i] == OP_PLUS) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1065353216
NEF4 $3142
line 7011
;7010:			//Com_Printf("(%d %d)  %f + %f\n", recursiveCount, uniqueId, ops[i - 1], ops[i + 3]);
;7011:			ops[i - 1] += ops[i + 3];
ADDRLP4 1396
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
ASGNP4
ADDRLP4 1396
INDIRP4
ADDRLP4 1396
INDIRP4
INDIRF4
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+12
ADDP4
INDIRF4
ADDF4
ASGNF4
line 7012
;7012:			for (j = i + 4; j < numOps; j++) {
ADDRLP4 0
ADDRLP4 1032
INDIRI4
CNSTI4 4
ADDI4
ASGNI4
ADDRGP4 $3149
JUMPV
LABELV $3146
line 7013
;7013:				ops[j - 4] = ops[j];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ASGNF4
line 7014
;7014:			}
LABELV $3147
line 7012
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3149
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $3146
line 7015
;7015:			numOps -= 4;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 4
SUBI4
ASGNI4
line 7016
;7016:			i -= 2;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 7017
;7017:			continue;
ADDRGP4 $3137
JUMPV
LABELV $3142
line 7018
;7018:		} else if (ops[i] == OP_MINUS) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1073741824
NEF4 $3151
line 7020
;7019:			//Com_Printf("(%d %d)  %f - %f\n", recursiveCount, uniqueId, ops[i - 1], ops[i + 3]);
;7020:			ops[i - 1] -= ops[i + 3];
ADDRLP4 1396
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
ASGNP4
ADDRLP4 1396
INDIRP4
ADDRLP4 1396
INDIRP4
INDIRF4
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+12
ADDP4
INDIRF4
SUBF4
ASGNF4
line 7021
;7021:			for (j = i + 4; j < numOps; j++) {
ADDRLP4 0
ADDRLP4 1032
INDIRI4
CNSTI4 4
ADDI4
ASGNI4
ADDRGP4 $3158
JUMPV
LABELV $3155
line 7022
;7022:				ops[j - 4] = ops[j];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ASGNF4
line 7023
;7023:			}
LABELV $3156
line 7021
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3158
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $3155
line 7024
;7024:			numOps -= 4;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 4
SUBI4
ASGNI4
line 7025
;7025:			i -= 2;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 7026
;7026:			continue;
LABELV $3151
line 7028
;7027:		}
;7028:	}
LABELV $3137
line 7004
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
LABELV $3139
ADDRLP4 1032
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $3136
line 7032
;7029:
;7030:	// < > ! =    (= is ==  and  ! is !=, equal and not equal)
;7031:
;7032:	for (i = 0; i < numOps; i += 2) {
ADDRLP4 1032
CNSTI4 0
ASGNI4
ADDRGP4 $3163
JUMPV
LABELV $3160
line 7033
;7033:		if (ops[i] == OP_NOP) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
NEF4 $3164
line 7034
;7034:			continue;
ADDRGP4 $3161
JUMPV
LABELV $3164
line 7037
;7035:		}
;7036:
;7037:		if (ops[i] == OP_LESS) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1084227584
NEF4 $3166
line 7039
;7038:			//Com_Printf("(%d %d)  %f < %f\n", recursiveCount, uniqueId, ops[i - 1], ops[i + 3]);
;7039:			ops[i - 1] = ops[i - 1] < ops[i + 3];
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRF4
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+12
ADDP4
INDIRF4
GEF4 $3172
ADDRLP4 1392
CNSTI4 1
ASGNI4
ADDRGP4 $3173
JUMPV
LABELV $3172
ADDRLP4 1392
CNSTI4 0
ASGNI4
LABELV $3173
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
ADDRLP4 1392
INDIRI4
CVIF4 4
ASGNF4
line 7040
;7040:			for (j = i + 4; j < numOps; j++) {
ADDRLP4 0
ADDRLP4 1032
INDIRI4
CNSTI4 4
ADDI4
ASGNI4
ADDRGP4 $3177
JUMPV
LABELV $3174
line 7041
;7041:				ops[j - 4] = ops[j];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ASGNF4
line 7042
;7042:			}
LABELV $3175
line 7040
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3177
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $3174
line 7043
;7043:			numOps -= 4;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 4
SUBI4
ASGNI4
line 7044
;7044:			i -= 2;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 7045
;7045:			continue;
ADDRGP4 $3161
JUMPV
LABELV $3166
line 7046
;7046:		} else if (ops[i] == OP_GREATER) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1086324736
NEF4 $3179
line 7048
;7047:			//Com_Printf("(%d %d)  %f > %f\n", recursiveCount, uniqueId, ops[i - 1], ops[i + 3]);
;7048:			ops[i - 1] = ops[i - 1] > ops[i + 3];
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRF4
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+12
ADDP4
INDIRF4
LEF4 $3185
ADDRLP4 1392
CNSTI4 1
ASGNI4
ADDRGP4 $3186
JUMPV
LABELV $3185
ADDRLP4 1392
CNSTI4 0
ASGNI4
LABELV $3186
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
ADDRLP4 1392
INDIRI4
CVIF4 4
ASGNF4
line 7049
;7049:			for (j = i + 4; j < numOps; j++) {
ADDRLP4 0
ADDRLP4 1032
INDIRI4
CNSTI4 4
ADDI4
ASGNI4
ADDRGP4 $3190
JUMPV
LABELV $3187
line 7050
;7050:				ops[j - 4] = ops[j];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ASGNF4
line 7051
;7051:			}
LABELV $3188
line 7049
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3190
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $3187
line 7052
;7052:			numOps -= 4;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 4
SUBI4
ASGNI4
line 7053
;7053:			i -= 2;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 7054
;7054:			continue;
ADDRGP4 $3161
JUMPV
LABELV $3179
line 7055
;7055:		} else if (ops[i] == OP_NOT) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1088421888
NEF4 $3192
line 7057
;7056:			//Com_Printf("(%d %d)  %f != %f\n", recursiveCount, uniqueId, ops[i - 1], ops[i + 3]);
;7057:			ops[i - 1] = ops[i - 1] != ops[i + 3];
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRF4
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+12
ADDP4
INDIRF4
EQF4 $3198
ADDRLP4 1392
CNSTI4 1
ASGNI4
ADDRGP4 $3199
JUMPV
LABELV $3198
ADDRLP4 1392
CNSTI4 0
ASGNI4
LABELV $3199
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
ADDRLP4 1392
INDIRI4
CVIF4 4
ASGNF4
line 7058
;7058:			for (j = i + 4; j < numOps; j++) {
ADDRLP4 0
ADDRLP4 1032
INDIRI4
CNSTI4 4
ADDI4
ASGNI4
ADDRGP4 $3203
JUMPV
LABELV $3200
line 7059
;7059:				ops[j - 4] = ops[j];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ASGNF4
line 7060
;7060:			}
LABELV $3201
line 7058
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3203
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $3200
line 7061
;7061:			numOps -= 4;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 4
SUBI4
ASGNI4
line 7062
;7062:			i -= 2;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 7063
;7063:			continue;
ADDRGP4 $3161
JUMPV
LABELV $3192
line 7064
;7064:		} else if (ops[i] == OP_EQUAL) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1090519040
NEF4 $3205
line 7066
;7065:			//Com_Printf("(%d %d)  %f == %f\n", recursiveCount, uniqueId, ops[i - 1], ops[i + 3]);
;7066:			ops[i - 1] = ops[i - 1] == ops[i + 3];
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRF4
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+12
ADDP4
INDIRF4
NEF4 $3211
ADDRLP4 1392
CNSTI4 1
ASGNI4
ADDRGP4 $3212
JUMPV
LABELV $3211
ADDRLP4 1392
CNSTI4 0
ASGNI4
LABELV $3212
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
ADDRLP4 1392
INDIRI4
CVIF4 4
ASGNF4
line 7067
;7067:			for (j = i + 4; j < numOps; j++) {
ADDRLP4 0
ADDRLP4 1032
INDIRI4
CNSTI4 4
ADDI4
ASGNI4
ADDRGP4 $3216
JUMPV
LABELV $3213
line 7068
;7068:				ops[j - 4] = ops[j];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ASGNF4
line 7069
;7069:			}
LABELV $3214
line 7067
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3216
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $3213
line 7070
;7070:			numOps -= 4;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 4
SUBI4
ASGNI4
line 7071
;7071:			i -= 2;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 7072
;7072:			continue;
LABELV $3205
line 7074
;7073:		}
;7074:	}
LABELV $3161
line 7032
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
LABELV $3163
ADDRLP4 1032
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $3160
line 7077
;7075:
;7076:	// & |
;7077:	for (i = 0; i < numOps; i += 2) {
ADDRLP4 1032
CNSTI4 0
ASGNI4
ADDRGP4 $3221
JUMPV
LABELV $3218
line 7078
;7078:		if (ops[i] == OP_NOP) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 0
NEF4 $3222
line 7079
;7079:			continue;
ADDRGP4 $3219
JUMPV
LABELV $3222
line 7082
;7080:		}
;7081:
;7082:		if (ops[i] == OP_AND) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1091567616
NEF4 $3224
line 7084
;7083:			//Com_Printf("(%d %d)  %f && %f\n", recursiveCount, uniqueId, ops[i - 1], ops[i + 3]);
;7084:			ops[i - 1] = ops[i - 1] && ops[i + 3];
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRF4
CNSTF4 0
EQF4 $3230
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+12
ADDP4
INDIRF4
CNSTF4 0
EQF4 $3230
ADDRLP4 1392
CNSTI4 1
ASGNI4
ADDRGP4 $3231
JUMPV
LABELV $3230
ADDRLP4 1392
CNSTI4 0
ASGNI4
LABELV $3231
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
ADDRLP4 1392
INDIRI4
CVIF4 4
ASGNF4
line 7085
;7085:			for (j = i + 4; j < numOps; j++) {
ADDRLP4 0
ADDRLP4 1032
INDIRI4
CNSTI4 4
ADDI4
ASGNI4
ADDRGP4 $3235
JUMPV
LABELV $3232
line 7086
;7086:				ops[j - 4] = ops[j];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ASGNF4
line 7087
;7087:			}
LABELV $3233
line 7085
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3235
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $3232
line 7088
;7088:			numOps -= 4;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 4
SUBI4
ASGNI4
line 7089
;7089:			i -= 2;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 7090
;7090:			continue;
ADDRGP4 $3219
JUMPV
LABELV $3224
line 7091
;7091:		} else if (ops[i] == OP_OR) {
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
CNSTF4 1092616192
NEF4 $3237
line 7093
;7092:			//Com_Printf("(%d %d)  %f || %f\n", recursiveCount, uniqueId, ops[i - 1], ops[i + 3]);
;7093:			ops[i - 1] = ops[i - 1] || ops[i + 3];
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRF4
CNSTF4 0
NEF4 $3245
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4+12
ADDP4
INDIRF4
CNSTF4 0
EQF4 $3243
LABELV $3245
ADDRLP4 1392
CNSTI4 1
ASGNI4
ADDRGP4 $3244
JUMPV
LABELV $3243
ADDRLP4 1392
CNSTI4 0
ASGNI4
LABELV $3244
ADDRLP4 1032
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
ADDRLP4 1392
INDIRI4
CVIF4 4
ASGNF4
line 7094
;7094:			for (j = i + 4; j < numOps; j++) {
ADDRLP4 0
ADDRLP4 1032
INDIRI4
CNSTI4 4
ADDI4
ASGNI4
ADDRGP4 $3249
JUMPV
LABELV $3246
line 7095
;7095:				ops[j - 4] = ops[j];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4-16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRF4
ASGNF4
line 7096
;7096:			}
LABELV $3247
line 7094
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3249
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $3246
line 7097
;7097:			numOps -= 4;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 4
SUBI4
ASGNI4
line 7098
;7098:			i -= 2;
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 7099
;7099:			continue;
LABELV $3237
line 7101
;7100:		}
;7101:	}
LABELV $3219
line 7077
ADDRLP4 1032
ADDRLP4 1032
INDIRI4
CNSTI4 2
ADDI4
ASGNI4
LABELV $3221
ADDRLP4 1032
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $3218
line 7104
;7102:
;7103:	// sanity check
;7104:	if (ops[0] != OP_VAL) {
ADDRLP4 4
INDIRF4
CNSTF4 1093664768
EQF4 $3251
line 7105
;7105:		*error = 5;
ADDRFP4 8
INDIRP4
CNSTI4 5
ASGNI4
line 7106
;7106:		Com_Printf("^3qmath invalid final value op(%d %d): %f\n", recursiveCount, uniqueId, ops[0]);
ADDRGP4 $3253
ARGP4
ADDRGP4 $2872
INDIRI4
ARGI4
ADDRLP4 1372
INDIRI4
ARGI4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 Com_Printf
CALLV
pop
line 7107
;7107:		recursiveCount--;
ADDRLP4 1392
ADDRGP4 $2872
ASGNP4
ADDRLP4 1392
INDIRP4
ADDRLP4 1392
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 7108
;7108:		return script;
ADDRFP4 0
INDIRP4
RETP4
ADDRGP4 $2871
JUMPV
LABELV $3251
line 7111
;7109:	}
;7110:
;7111:	*val = ops[1];
ADDRFP4 4
INDIRP4
ADDRLP4 4+4
INDIRF4
ASGNF4
line 7112
;7112:	if (verbose) {
ADDRLP4 1368
INDIRI4
CNSTI4 0
EQI4 $3255
line 7113
;7113:		Com_Printf("val(%d %d)(numOps:%d): %f\n", recursiveCount, uniqueId, numOps, *val);
ADDRGP4 $3257
ARGP4
ADDRGP4 $2872
INDIRI4
ARGI4
ADDRLP4 1372
INDIRI4
ARGI4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
INDIRF4
ARGF4
ADDRGP4 Com_Printf
CALLV
pop
line 7114
;7114:	}
LABELV $3255
line 7116
;7115:
;7116:	recursiveCount--;
ADDRLP4 1392
ADDRGP4 $2872
ASGNP4
ADDRLP4 1392
INDIRP4
ADDRLP4 1392
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 7117
;7117:	return script;
ADDRFP4 0
INDIRP4
RETP4
LABELV $2871
endproc Q_MathScript 1480 20
proc ItemParse_setVar 28 12
line 7120
;7118:}
;7119:
;7120:static qboolean ItemParse_setVar(itemDef_t *item, int handle) {
line 7126
;7121:	const char *var;
;7122:	char *mathScript;
;7123:	int err;
;7124:	float f;
;7125:
;7126:	if (!PC_String_Parse(handle, &var)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 16
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $3259
line 7127
;7127:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3258
JUMPV
LABELV $3259
line 7130
;7128:	}
;7129:
;7130:	if (!PC_Parenthesis_Parse(handle, (const char **)&mathScript)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 20
ADDRGP4 PC_Parenthesis_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $3261
line 7131
;7131:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3258
JUMPV
LABELV $3261
line 7133
;7132:	}
;7133:	Q_MathScript(mathScript, &f, &err);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 Q_MathScript
CALLP4
pop
line 7134
;7134:	if (!MenuVar_Set(var, f)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 MenuVar_Set
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $3263
line 7135
;7135:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3258
JUMPV
LABELV $3263
line 7138
;7136:	}
;7137:
;7138:	return qtrue;
CNSTI4 1
RETI4
LABELV $3258
endproc ItemParse_setVar 28 12
proc ItemParse_run 4 8
line 7141
;7139:}
;7140:
;7141:static qboolean ItemParse_run(itemDef_t *item, int handle) {
line 7142
;7142:	if (PC_Script_Parse(handle, &item->run)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 252
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $3266
line 7143
;7143:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3265
JUMPV
LABELV $3266
line 7145
;7144:	}
;7145:	return qfalse;
CNSTI4 0
RETI4
LABELV $3265
endproc ItemParse_run 4 8
proc ItemParse_printVal 16 12
line 7148
;7146:}
;7147:
;7148:static qboolean ItemParse_printVal(itemDef_t *item, int handle) {
line 7153
;7149:	char *mathScript;
;7150:	int err;
;7151:	float f;
;7152:
;7153:	if (!PC_Parenthesis_Parse(handle, (const char **)&mathScript)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 12
ADDRGP4 PC_Parenthesis_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $3269
line 7154
;7154:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3268
JUMPV
LABELV $3269
line 7156
;7155:	}
;7156:	Q_MathScript(mathScript, &f, &err);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 Q_MathScript
CALLP4
pop
line 7157
;7157:	Com_Printf("%f\n", f);
ADDRGP4 $3271
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRGP4 Com_Printf
CALLV
pop
line 7159
;7158:
;7159:	return qtrue;
CNSTI4 1
RETI4
LABELV $3268
endproc ItemParse_printVal 16 12
proc ItemParse_widescreen 8 12
line 7162
;7160:}
;7161:
;7162:static qboolean ItemParse_widescreen(itemDef_t *item, int handle) {
line 7163
;7163:	if (!PC_Int_Parse(handle, &item->widescreen)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $3273
line 7164
;7164:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3272
JUMPV
LABELV $3273
line 7170
;7165:	}
;7166:
;7167:	//Com_Printf("^3FIXME item parse widescreen %d\n", item->widescreen);
;7168:	//PC_SourceWarning(handle, "FIXME item parse widescreen %d", item->widescreen);
;7169:
;7170:	if (item->widescreen < WIDESCREEN_STRETCH || item->widescreen > WIDESCREEN_RIGHT) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 0
LTI4 $3277
ADDRLP4 4
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
CNSTI4 3
LEI4 $3275
LABELV $3277
line 7171
;7171:		PC_SourceError(handle, "invalid widescreen value %d", item->widescreen);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $3278
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRGP4 PC_SourceError
CALLV
pop
line 7172
;7172:		item->widescreen = WIDESCREEN_STRETCH;
ADDRFP4 0
INDIRP4
CNSTI4 576
ADDP4
CNSTI4 0
ASGNI4
line 7173
;7173:	}
LABELV $3275
line 7175
;7174:
;7175:	return qtrue;
CNSTI4 1
RETI4
LABELV $3272
endproc ItemParse_widescreen 8 12
data
export itemParseKeywords
align 4
LABELV itemParseKeywords
address $3279
address ItemParse_name
byte 4 0
address $3280
address ItemParse_text
byte 4 0
address $3281
address ItemParse_textExt
byte 4 0
address $3282
address ItemParse_textReset
byte 4 0
address $3283
address ItemParse_group
byte 4 0
address $3284
address ItemParse_asset_model
byte 4 0
address $3285
address ItemParse_asset_shader
byte 4 0
address $3286
address ItemParse_model_origin
byte 4 0
address $3287
address ItemParse_model_fovx
byte 4 0
address $3288
address ItemParse_model_fovy
byte 4 0
address $3289
address ItemParse_model_rotation
byte 4 0
address $3290
address ItemParse_model_angle
byte 4 0
address $3291
address ItemParse_rect
byte 4 0
address $3292
address ItemParse_style
byte 4 0
address $3293
address ItemParse_decoration
byte 4 0
address $3294
address ItemParse_notselectable
byte 4 0
address $3295
address ItemParse_wrapped
byte 4 0
address $3296
address ItemParse_autowrapped
byte 4 0
address $3297
address ItemParse_horizontalscroll
byte 4 0
address $3298
address ItemParse_type
byte 4 0
address $3299
address ItemParse_elementwidth
byte 4 0
address $3300
address ItemParse_elementheight
byte 4 0
address $3301
address ItemParse_elementColor
byte 4 0
address $3302
address ItemParse_selectedColor
byte 4 0
address $3303
address ItemParse_altRowColor
byte 4 0
address $3304
address ItemParse_feeder
byte 4 0
address $3305
address ItemParse_elementtype
byte 4 0
address $3306
address ItemParse_columns
byte 4 0
address $3307
address ItemParse_border
byte 4 0
address $3308
address ItemParse_bordersize
byte 4 0
address $3309
address ItemParse_visible
byte 4 0
address $3310
address ItemParse_ownerdraw
byte 4 0
address $3311
address ItemParse_align
byte 4 0
address $3312
address ItemParse_textalign
byte 4 0
address $3313
address ItemParse_textalignx
byte 4 0
address $3314
address ItemParse_textaligny
byte 4 0
address $3315
address ItemParse_textscale
byte 4 0
address $3316
address ItemParse_textstyle
byte 4 0
address $618
address ItemParse_backcolor
byte 4 0
address $621
address ItemParse_forecolor
byte 4 0
address $624
address ItemParse_bordercolor
byte 4 0
address $3317
address ItemParse_outlinecolor
byte 4 0
address $3318
address ItemParse_background
byte 4 0
address $3319
address ItemParse_backgroundReset
byte 4 0
address $3320
address ItemParse_onFocus
byte 4 0
address $3321
address ItemParse_leaveFocus
byte 4 0
address $3322
address ItemParse_mouseEnter
byte 4 0
address $3323
address ItemParse_mouseExit
byte 4 0
address $3324
address ItemParse_mouseEnterText
byte 4 0
address $3325
address ItemParse_mouseExitText
byte 4 0
address $3326
address ItemParse_action
byte 4 0
address $3327
address ItemParse_special
byte 4 0
address $3328
address ItemParse_cvar
byte 4 0
address $3329
address ItemParse_cvarSet
byte 4 0
address $3330
address ItemParse_maxChars
byte 4 0
address $3331
address ItemParse_maxPaintChars
byte 4 0
address $3332
address ItemParse_focusSound
byte 4 0
address $3333
address ItemParse_cvarFloat
byte 4 0
address $3334
address ItemParse_cvarInt
byte 4 0
address $3335
address ItemParse_cvarStrList
byte 4 0
address $3336
address ItemParse_cvarFloatList
byte 4 0
address $3337
address ItemParse_addColorRange
byte 4 0
address $3338
address ItemParse_ownerdrawFlag
byte 4 0
address $3339
address ItemParse_ownerdrawFlag2
byte 4 0
address $3340
address ItemParse_enableCvar
byte 4 0
address $3341
address ItemParse_cvarTest
byte 4 0
address $3342
address ItemParse_disableCvar
byte 4 0
address $3343
address ItemParse_showCvar
byte 4 0
address $3344
address ItemParse_hideCvar
byte 4 0
address $3345
address ItemParse_cinematic
byte 4 0
address $3346
address ItemParse_doubleClick
byte 4 0
address $3347
address ItemParse_defaultContent
byte 4 0
address $3348
address ItemParse_cellId
byte 4 0
address $3349
address ItemParse_font
byte 4 0
address $3350
address ItemParse_precision
byte 4 0
address $833
address ItemParse_setVar
byte 4 0
address $3351
address ItemParse_run
byte 4 0
address $3352
address ItemParse_printVal
byte 4 0
address $3353
address ItemParse_widescreen
byte 4 0
byte 4 0
byte 4 0
byte 4 0
code
proc Item_SetupKeywordHash 4 12
line 7268
;7176:}
;7177:
;7178:keywordHash_t itemParseKeywords[] = {
;7179:	{"name", ItemParse_name, NULL},
;7180:	{"text", ItemParse_text, NULL},
;7181:	{"textext", ItemParse_textExt, NULL},
;7182:	{"textreset", ItemParse_textReset, NULL},
;7183:	{"group", ItemParse_group, NULL},
;7184:	{"asset_model", ItemParse_asset_model, NULL},
;7185:	{"asset_shader", ItemParse_asset_shader, NULL},
;7186:	{"model_origin", ItemParse_model_origin, NULL},
;7187:	{"model_fovx", ItemParse_model_fovx, NULL},
;7188:	{"model_fovy", ItemParse_model_fovy, NULL},
;7189:	{"model_rotation", ItemParse_model_rotation, NULL},
;7190:	{"model_angle", ItemParse_model_angle, NULL},
;7191:	{"rect", ItemParse_rect, NULL},
;7192:	{"style", ItemParse_style, NULL},
;7193:	{"decoration", ItemParse_decoration, NULL},
;7194:	{"notselectable", ItemParse_notselectable, NULL},
;7195:	{"wrapped", ItemParse_wrapped, NULL},
;7196:	{"autowrapped", ItemParse_autowrapped, NULL},
;7197:	{"horizontalscroll", ItemParse_horizontalscroll, NULL},
;7198:	{"type", ItemParse_type, NULL},
;7199:	{"elementwidth", ItemParse_elementwidth, NULL},
;7200:	{"elementheight", ItemParse_elementheight, NULL},
;7201:	{"elementcolor", ItemParse_elementColor, NULL},
;7202:	{"selectedcolor", ItemParse_selectedColor, NULL},
;7203:	{"altrowcolor", ItemParse_altRowColor, NULL},
;7204:	{"feeder", ItemParse_feeder, NULL},
;7205:	{"elementtype", ItemParse_elementtype, NULL},
;7206:	{"columns", ItemParse_columns, NULL},
;7207:	{"border", ItemParse_border, NULL},
;7208:	{"bordersize", ItemParse_bordersize, NULL},
;7209:	{"visible", ItemParse_visible, NULL},
;7210:	{"ownerdraw", ItemParse_ownerdraw, NULL},
;7211:	{"align", ItemParse_align, NULL},
;7212:	{"textalign", ItemParse_textalign, NULL},
;7213:	{"textalignx", ItemParse_textalignx, NULL},
;7214:	{"textaligny", ItemParse_textaligny, NULL},
;7215:	{"textscale", ItemParse_textscale, NULL},
;7216:	{"textstyle", ItemParse_textstyle, NULL},
;7217:	{"backcolor", ItemParse_backcolor, NULL},
;7218:	{"forecolor", ItemParse_forecolor, NULL},
;7219:	{"bordercolor", ItemParse_bordercolor, NULL},
;7220:	{"outlinecolor", ItemParse_outlinecolor, NULL},
;7221:	{"background", ItemParse_background, NULL},
;7222:	{"backgroundreset", ItemParse_backgroundReset, NULL},
;7223:	{"onFocus", ItemParse_onFocus, NULL},
;7224:	{"leaveFocus", ItemParse_leaveFocus, NULL},
;7225:	{"mouseEnter", ItemParse_mouseEnter, NULL},
;7226:	{"mouseExit", ItemParse_mouseExit, NULL},
;7227:	{"mouseEnterText", ItemParse_mouseEnterText, NULL},
;7228:	{"mouseExitText", ItemParse_mouseExitText, NULL},
;7229:	{"action", ItemParse_action, NULL},
;7230:	{"special", ItemParse_special, NULL},
;7231:	{"cvar", ItemParse_cvar, NULL},
;7232:	{"cvarset", ItemParse_cvarSet, NULL},
;7233:	{"maxChars", ItemParse_maxChars, NULL},
;7234:	{"maxPaintChars", ItemParse_maxPaintChars, NULL},
;7235:	{"focusSound", ItemParse_focusSound, NULL},
;7236:	{"cvarFloat", ItemParse_cvarFloat, NULL},
;7237:	{"cvarInt", ItemParse_cvarInt, NULL},
;7238:	{"cvarStrList", ItemParse_cvarStrList, NULL},
;7239:	{"cvarFloatList", ItemParse_cvarFloatList, NULL},
;7240:	{"addColorRange", ItemParse_addColorRange, NULL},
;7241:	{"ownerdrawFlag", ItemParse_ownerdrawFlag, NULL},
;7242:	{"ownerdrawFlag2", ItemParse_ownerdrawFlag2, NULL},
;7243:	{"enableCvar", ItemParse_enableCvar, NULL},
;7244:	{"cvarTest", ItemParse_cvarTest, NULL},
;7245:	{"disableCvar", ItemParse_disableCvar, NULL},
;7246:	{"showCvar", ItemParse_showCvar, NULL},
;7247:	{"hideCvar", ItemParse_hideCvar, NULL},
;7248:	{"cinematic", ItemParse_cinematic, NULL},
;7249:	{"doubleclick", ItemParse_doubleClick, NULL},
;7250:	{"defaultContent", ItemParse_defaultContent, NULL},
;7251:	{"cellId", ItemParse_cellId, NULL},
;7252:	{"font", ItemParse_font, NULL},
;7253:	{"precision", ItemParse_precision, NULL},
;7254:	{"setvar", ItemParse_setVar, NULL},
;7255:	{"run", ItemParse_run, NULL},
;7256:	{"printval", ItemParse_printVal, NULL},
;7257:	{ "widescreen", ItemParse_widescreen, NULL },
;7258:	{NULL, 0, NULL}
;7259:};
;7260:
;7261:keywordHash_t *itemParseKeywordHash[KEYWORDHASH_SIZE];
;7262:
;7263:/*
;7264:===============
;7265:Item_SetupKeywordHash
;7266:===============
;7267:*/
;7268:static void Item_SetupKeywordHash(void) {
line 7271
;7269:	int i;
;7270:
;7271:	memset(itemParseKeywordHash, 0, sizeof(itemParseKeywordHash));
ADDRGP4 itemParseKeywordHash
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2048
ARGI4
ADDRGP4 memset
CALLP4
pop
line 7272
;7272:	for (i = 0; itemParseKeywords[i].keyword; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3358
JUMPV
LABELV $3355
line 7273
;7273:		KeywordHash_Add(itemParseKeywordHash, &itemParseKeywords[i]);
ADDRGP4 itemParseKeywordHash
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 itemParseKeywords
ADDP4
ARGP4
ADDRGP4 KeywordHash_Add
CALLV
pop
line 7274
;7274:	}
LABELV $3356
line 7272
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3358
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 itemParseKeywords
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3355
line 7275
;7275:}
LABELV $3354
endproc Item_SetupKeywordHash 4 12
data
align 4
LABELV builtinResolutions
address $3359
address $3360
address $3361
address $3362
address $3363
address $3364
address $3365
address $3366
address $3367
address $3368
address $3369
address $3370
byte 4 0
align 4
LABELV knownRatios
address $3371
address $3372
address $3373
address $3374
address $3375
address $3376
address $3377
address $3378
address $3379
address $3380
address $3381
address $3382
address $3383
address $3384
byte 4 0
byte 4 0
code
proc UI_ResolutionToAspect 48 16
line 7311
;7276:
;7277:static const char *builtinResolutions[] =
;7278:{
;7279:	"320x240",
;7280:	"400x300",
;7281:	"512x384",
;7282:	"640x480",
;7283:	"800x600",
;7284:	"960x720",
;7285:	"1024x768",
;7286:	"1152x864",
;7287:	"1280x1024",
;7288:	"1600x1200",
;7289:	"2048x1536",
;7290:	"856x480",
;7291:	NULL
;7292:};
;7293:
;7294:static const char *knownRatios[][2] =
;7295:{
;7296:	{ "1.25:1", "5:4"   },
;7297:	{ "1.33:1", "4:3"   },
;7298:	{ "1.50:1", "3:2"   },
;7299:	{ "1.56:1", "14:9"  },
;7300:	{ "1.60:1", "16:10" },
;7301:	{ "1.67:1", "5:3"   },
;7302:	{ "1.78:1", "16:9"  },
;7303:	{ NULL    , NULL    }
;7304:};
;7305:
;7306:/*
;7307:===============
;7308:UI_ResolutionToAspect
;7309:===============
;7310:*/
;7311:static void UI_ResolutionToAspect(const char *resolution, char *aspect, size_t aspectLength) {
line 7317
;7312:	int i, w, h;
;7313:	char *x;
;7314:	char str[8];
;7315:
;7316:	// calculate resolution's aspect ratio
;7317:	x = strchr(resolution, 'x') + 1;
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 120
ARGI4
ADDRLP4 24
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 7318
;7318:	Q_strncpyz(str, resolution, MIN(x - resolution, sizeof(str)));
ADDRLP4 8
ARGP4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CVIU4 4
CNSTU4 8
GEU4 $3387
ADDRLP4 28
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CVIU4 4
ASGNU4
ADDRGP4 $3388
JUMPV
LABELV $3387
ADDRLP4 28
CNSTU4 8
ASGNU4
LABELV $3388
ADDRLP4 28
INDIRU4
CVUI4 4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 7319
;7319:	w = atoi(str);
ADDRLP4 8
ARGP4
ADDRLP4 36
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 36
INDIRI4
ASGNI4
line 7320
;7320:	h = atoi(x);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 40
INDIRI4
ASGNI4
line 7321
;7321:	Com_sprintf(aspect, aspectLength, "%.2f:1", (float)w / (float)h);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $3389
ARGP4
ADDRLP4 16
INDIRI4
CVIF4 4
ADDRLP4 20
INDIRI4
CVIF4 4
DIVF4
ARGF4
ADDRGP4 Com_sprintf
CALLI4
pop
line 7324
;7322:
;7323:	// rename common ratios ("1.33:1" -> "4:3")
;7324:	for (i = 0; knownRatios[i][0]; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3393
JUMPV
LABELV $3390
line 7325
;7325:		if (!Q_stricmp(aspect, knownRatios[i][0])) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 knownRatios
ADDP4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $3394
line 7326
;7326:			Q_strncpyz(aspect, knownRatios[i][1], aspectLength);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 knownRatios+4
ADDP4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 7327
;7327:			break;
ADDRGP4 $3392
JUMPV
LABELV $3394
line 7329
;7328:		}
;7329:	}
LABELV $3391
line 7324
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3393
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 knownRatios
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3390
LABELV $3392
line 7330
;7330:}
LABELV $3385
endproc UI_ResolutionToAspect 48 16
proc Item_RunFrameScript 1052 16
line 7332
;7331:
;7332:static void Item_RunFrameScript(itemDef_t *item, const char *script) {
line 7338
;7333:	keywordHash_t *key;
;7334:	const char *token;
;7335:	char *oldScriptBuffer;
;7336:	qboolean oldUseScriptBuffer;
;7337:
;7338:	if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3398
line 7339
;7339:		Com_Printf("^1Item_RunFrameScript() item == NULL\n");
ADDRGP4 $3400
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 7340
;7340:		return;
ADDRGP4 $3397
JUMPV
LABELV $3398
line 7343
;7341:	}
;7342:
;7343:	if (script == NULL) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3401
line 7344
;7344:		Com_Printf("^1Item_RunFrameScript() script == NULL\n");
ADDRGP4 $3403
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 7345
;7345:		return;
ADDRGP4 $3397
JUMPV
LABELV $3401
line 7348
;7346:	}
;7347:
;7348:	oldScriptBuffer = ScriptBuffer;
ADDRLP4 4
ADDRGP4 ScriptBuffer
INDIRP4
ASGNP4
line 7349
;7349:	oldUseScriptBuffer = UseScriptBuffer;
ADDRLP4 8
ADDRGP4 UseScriptBuffer
INDIRI4
ASGNI4
line 7351
;7350:
;7351:	UseScriptBuffer = qtrue;
ADDRGP4 UseScriptBuffer
CNSTI4 1
ASGNI4
line 7352
;7352:	ScriptBuffer = (char *)script;
ADDRGP4 ScriptBuffer
ADDRFP4 4
INDIRP4
ASGNP4
ADDRGP4 $3405
JUMPV
LABELV $3404
line 7353
;7353:	while (1) {
LABELV $3407
line 7355
;7354:	loopStart:
;7355:		if (!String_Parse(&ScriptBuffer, &token)) {
ADDRGP4 ScriptBuffer
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $3411
line 7357
;7356:			// all done
;7357:			break;
ADDRGP4 $3406
JUMPV
LABELV $3410
line 7360
;7358:		}
;7359:
;7360:		while (!Q_stricmp(token, "if")) {
line 7363
;7361:			char s[MAX_TOKEN_CHARS];
;7362:
;7363:			if (!ItemParse_if(item, -1, s, qfalse)) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 20
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 1044
ADDRGP4 ItemParse_if
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $3414
line 7364
;7364:				ScriptBuffer = oldScriptBuffer;
ADDRGP4 ScriptBuffer
ADDRLP4 4
INDIRP4
ASGNP4
line 7365
;7365:				UseScriptBuffer = oldUseScriptBuffer;
ADDRGP4 UseScriptBuffer
ADDRLP4 8
INDIRI4
ASGNI4
line 7366
;7366:				return;
ADDRGP4 $3397
JUMPV
LABELV $3414
line 7368
;7367:			}
;7368:			if (s[0] == '\0') {
ADDRLP4 20
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3416
line 7369
;7369:				goto loopStart;
ADDRGP4 $3407
JUMPV
LABELV $3416
line 7371
;7370:			}
;7371:			token = String_Alloc(s);
ADDRLP4 20
ARGP4
ADDRLP4 1048
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1048
INDIRP4
ASGNP4
line 7372
;7372:		}
LABELV $3411
line 7360
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $3413
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $3410
line 7374
;7373:
;7374:		key = KeywordHash_Find(itemParseKeywordHash, (char *)token);
ADDRGP4 itemParseKeywordHash
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 KeywordHash_Find
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 24
INDIRP4
ASGNP4
line 7375
;7375:		if (!key) {
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3418
line 7376
;7376:			Com_Printf("^1Item_RunFrameScript()  unknown menu item keyword '%s'\n", token);
ADDRGP4 $3420
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 7377
;7377:			continue;
ADDRGP4 $3405
JUMPV
LABELV $3418
line 7379
;7378:		}
;7379:		if (!key->func(item, -1)) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 28
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $3421
line 7380
;7380:			Com_Printf("^1Item_RunFrameScript()  couldn't parse menu item keyword '%s'\n", token);
ADDRGP4 $3423
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 7381
;7381:			break;
ADDRGP4 $3406
JUMPV
LABELV $3421
line 7383
;7382:		}
;7383:	}
LABELV $3405
line 7353
ADDRGP4 $3404
JUMPV
LABELV $3406
line 7385
;7384:
;7385:	ScriptBuffer = oldScriptBuffer;
ADDRGP4 ScriptBuffer
ADDRLP4 4
INDIRP4
ASGNP4
line 7386
;7386:	UseScriptBuffer = oldUseScriptBuffer;
ADDRGP4 UseScriptBuffer
ADDRLP4 8
INDIRI4
ASGNI4
line 7387
;7387:}
LABELV $3397
endproc Item_RunFrameScript 1052 16
proc ItemParse_if 60 16
line 7389
;7388:
;7389:static qboolean ItemParse_if(itemDef_t *item, int handle, char *lastToken, qboolean forceSkip) {
line 7399
;7390:	char *mathScript;
;7391:	const char *script;
;7392:	float f;
;7393:	int err;
;7394:	int oldUseScriptBuffer;
;7395:	char *oldScriptBuffer;
;7396:	const char *token;
;7397:	qboolean runElse;
;7398:
;7399:	if (!PC_Parenthesis_Parse(handle, (const char **)&mathScript)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 32
ADDRGP4 PC_Parenthesis_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $3425
line 7400
;7400:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3424
JUMPV
LABELV $3425
line 7403
;7401:	}
;7402:
;7403:	if (!forceSkip) {
ADDRFP4 12
INDIRI4
CNSTI4 0
NEI4 $3427
line 7404
;7404:		Q_MathScript(mathScript, &f, &err);
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 Q_MathScript
CALLP4
pop
line 7405
;7405:	} else {
ADDRGP4 $3428
JUMPV
LABELV $3427
line 7406
;7406:		f = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 7407
;7407:	}
LABELV $3428
line 7409
;7408:
;7409:	if (!PC_Script_Parse(handle, &script)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRLP4 36
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $3429
line 7410
;7410:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3424
JUMPV
LABELV $3429
line 7413
;7411:	}
;7412:
;7413:	runElse = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 7414
;7414:	if (f == 0.0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
NEF4 $3431
line 7415
;7415:		runElse = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 7416
;7416:	}
LABELV $3431
line 7419
;7417:
;7418:	// handle 'if' block
;7419:	if (!forceSkip && !runElse) {
ADDRFP4 12
INDIRI4
CNSTI4 0
NEI4 $3433
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $3433
line 7421
;7420:		//FIXME :(
;7421:		oldUseScriptBuffer = UseScriptBuffer;
ADDRLP4 20
ADDRGP4 UseScriptBuffer
INDIRI4
ASGNI4
line 7422
;7422:		oldScriptBuffer = ScriptBuffer;
ADDRLP4 24
ADDRGP4 ScriptBuffer
INDIRP4
ASGNP4
line 7424
;7423:
;7424:		Item_RunFrameScript(item, script);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 Item_RunFrameScript
CALLV
pop
line 7426
;7425:
;7426:		ScriptBuffer = oldScriptBuffer;
ADDRGP4 ScriptBuffer
ADDRLP4 24
INDIRP4
ASGNP4
line 7427
;7427:		UseScriptBuffer = oldUseScriptBuffer;
ADDRGP4 UseScriptBuffer
ADDRLP4 20
INDIRI4
ASGNI4
line 7428
;7428:	}
LABELV $3433
line 7433
;7429:
;7430:	// handle 'else' and 'elif' blocks
;7431:
;7432:	//while (1) {
;7433:	if (!PC_String_Parse(handle, &token)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 40
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $3435
line 7435
;7434:		// end of script
;7435:		lastToken[0] = '\0';
ADDRFP4 8
INDIRP4
CNSTI1 0
ASGNI1
line 7436
;7436:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3424
JUMPV
LABELV $3435
line 7439
;7437:	}
;7438:
;7439:	Q_strncpyz(lastToken, token, MAX_TOKEN_CHARS);
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 7441
;7440:
;7441:	if (token[0] == '}') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $3437
line 7442
;7442:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3424
JUMPV
LABELV $3437
line 7443
;7443:	} else if (!Q_stricmp(token, "else")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $3441
ARGP4
ADDRLP4 44
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $3439
line 7444
;7444:		if (!PC_Script_ParseExt(handle, &script, &token)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 48
ADDRGP4 PC_Script_ParseExt
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $3442
line 7445
;7445:			if (!Q_stricmp(token, "if")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $3413
ARGP4
ADDRLP4 52
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $3444
line 7446
;7446:				if (!forceSkip && runElse) {
ADDRFP4 12
INDIRI4
CNSTI4 0
NEI4 $3446
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $3446
line 7447
;7447:					return ItemParse_if(item, handle, lastToken, qfalse);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 56
ADDRGP4 ItemParse_if
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
RETI4
ADDRGP4 $3424
JUMPV
LABELV $3446
line 7448
;7448:				} else {
line 7449
;7449:					return ItemParse_if(item, handle, lastToken, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 56
ADDRGP4 ItemParse_if
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
RETI4
ADDRGP4 $3424
JUMPV
LABELV $3444
line 7451
;7450:				}
;7451:			} else {
line 7452
;7452:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3424
JUMPV
LABELV $3442
line 7456
;7453:			}
;7454:		}
;7455:
;7456:		if (!forceSkip && runElse) {
ADDRFP4 12
INDIRI4
CNSTI4 0
NEI4 $3448
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $3448
line 7457
;7457:			oldUseScriptBuffer = UseScriptBuffer;
ADDRLP4 20
ADDRGP4 UseScriptBuffer
INDIRI4
ASGNI4
line 7458
;7458:			oldScriptBuffer = ScriptBuffer;
ADDRLP4 24
ADDRGP4 ScriptBuffer
INDIRP4
ASGNP4
line 7460
;7459:
;7460:			Item_RunFrameScript(item, script);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 Item_RunFrameScript
CALLV
pop
line 7462
;7461:
;7462:			ScriptBuffer = oldScriptBuffer;
ADDRGP4 ScriptBuffer
ADDRLP4 24
INDIRP4
ASGNP4
line 7463
;7463:			UseScriptBuffer = oldUseScriptBuffer;
ADDRGP4 UseScriptBuffer
ADDRLP4 20
INDIRI4
ASGNI4
line 7464
;7464:		}
LABELV $3448
line 7465
;7465:		lastToken[0] = '\0';
ADDRFP4 8
INDIRP4
CNSTI1 0
ASGNI1
line 7466
;7466:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3424
JUMPV
LABELV $3439
line 7467
;7467:	} else {
line 7468
;7468:		return qtrue;
CNSTI4 1
RETI4
LABELV $3424
endproc ItemParse_if 60 16
proc Item_ApplyHacks 1152 20
line 7481
;7469:	}
;7470:
;7471:	//}
;7472:}
;7473:
;7474:/*
;7475:===============
;7476:Item_ApplyHacks
;7477:
;7478:Hacks to fix issues with Team Arena menu scripts
;7479:===============
;7480:*/
;7481:static void Item_ApplyHacks(itemDef_t *item) {
line 7484
;7482:
;7483:	// Fix length of favorite address in createfavorite.menu
;7484:	if (item->type == ITEM_TYPE_EDITFIELD && item->cvar && !Q_stricmp(item->cvar, "ui_favoriteAddress")) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 4
NEI4 $3451
ADDRLP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3451
ADDRLP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRGP4 $3453
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $3451
line 7485
;7485:		editFieldDef_t *editField = (editFieldDef_t *)item->typeData;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 7488
;7486:
;7487:		// enough to hold an IPv6 address plus null
;7488:		if (editField->maxChars < 48) {
ADDRLP4 8
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 48
GEI4 $3454
line 7489
;7489:			Com_Printf("Extended create favorite address edit field length to hold an IPv6 address\n");
ADDRGP4 $3456
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 7490
;7490:			editField->maxChars = 48;
ADDRLP4 8
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 48
ASGNI4
line 7491
;7491:		}
LABELV $3454
line 7492
;7492:	}
LABELV $3451
line 7494
;7493:
;7494:	if (item->type == ITEM_TYPE_EDITFIELD && item->cvar && (!Q_stricmp(item->cvar, "ui_Name") || !Q_stricmp(item->cvar, "ui_findplayer"))) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 4
NEI4 $3457
ADDRLP4 8
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3457
ADDRLP4 8
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRGP4 $3459
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $3461
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRGP4 $3460
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $3457
LABELV $3461
line 7495
;7495:		editFieldDef_t *editField = (editFieldDef_t *)item->typeData;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 7498
;7496:
;7497:		// enough to hold a full player name
;7498:		if (editField->maxChars < MAX_NAME_LENGTH) {
ADDRLP4 20
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 32
GEI4 $3462
line 7499
;7499:			if (editField->maxPaintChars > editField->maxChars) {
ADDRLP4 24
ADDRLP4 20
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ADDRLP4 24
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
LEI4 $3464
line 7500
;7500:				editField->maxPaintChars = editField->maxChars;
ADDRLP4 28
ADDRLP4 20
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 28
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 7501
;7501:			}
LABELV $3464
line 7503
;7502:
;7503:			Com_Printf("Extended player name field using cvar %s to %d characters\n", item->cvar, MAX_NAME_LENGTH);
ADDRGP4 $3466
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 7504
;7504:			editField->maxChars = MAX_NAME_LENGTH;
ADDRLP4 20
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 32
ASGNI4
line 7505
;7505:		}
LABELV $3462
line 7506
;7506:	}
LABELV $3457
line 7509
;7507:
;7508:	// Replace mode list and use a temporary ui_videomode cvar for handling custom modes
;7509:	if (item->type == ITEM_TYPE_MULTI && item->cvar && !Q_stricmp(item->cvar, "r_mode")) {
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 12
NEI4 $3467
ADDRLP4 20
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3467
ADDRLP4 20
INDIRP4
CNSTI4 284
ADDP4
INDIRP4
ARGP4
ADDRGP4 $1249
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $3467
line 7510
;7510:		multiDef_t *multiPtr = (multiDef_t *)item->typeData;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 7515
;7511:		int i, oldCount;
;7512:		char resbuf[MAX_STRING_CHARS];
;7513:		char modeName[32], aspect[8];
;7514:
;7515:		item->cvar = "ui_videomode";
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
ADDRGP4 $3469
ASGNP4
line 7516
;7516:		multiPtr->strDef = qtrue;
ADDRLP4 32
INDIRP4
CNSTI4 388
ADDP4
CNSTI4 1
ASGNI4
line 7517
;7517:		multiPtr->videoMode = qtrue;
ADDRLP4 32
INDIRP4
CNSTI4 392
ADDP4
CNSTI4 1
ASGNI4
line 7519
;7518:
;7519:		oldCount = multiPtr->count;
ADDRLP4 1100
ADDRLP4 32
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
ASGNI4
line 7520
;7520:		multiPtr->count = 0;
ADDRLP4 32
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 0
ASGNI4
line 7522
;7521:
;7522:		DC->getCVarString("r_availableModes", resbuf, sizeof(resbuf));
ADDRGP4 $3470
ARGP4
ADDRLP4 76
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 88
ADDP4
INDIRP4
CALLV
pop
line 7524
;7523:
;7524:		if (*resbuf) {
ADDRLP4 76
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3471
line 7525
;7525:			char *s = resbuf, *mode;
ADDRLP4 1108
ADDRLP4 76
ASGNP4
ADDRGP4 $3474
JUMPV
LABELV $3473
line 7527
;7526:
;7527:			while (s && multiPtr->count < MAX_MULTI_CVARS) {
line 7528
;7528:				mode = s;
ADDRLP4 1104
ADDRLP4 1108
INDIRP4
ASGNP4
line 7530
;7529:
;7530:				s = strchr(s, ' ');
ADDRLP4 1108
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 1112
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1108
ADDRLP4 1112
INDIRP4
ASGNP4
line 7531
;7531:				if (s)
ADDRLP4 1108
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3476
line 7532
;7532:					*s++ = '\0';
ADDRLP4 1116
ADDRLP4 1108
INDIRP4
ASGNP4
ADDRLP4 1108
ADDRLP4 1116
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 1116
INDIRP4
CNSTI1 0
ASGNI1
LABELV $3476
line 7534
;7533:
;7534:				UI_ResolutionToAspect(mode, aspect, sizeof(aspect));
ADDRLP4 1104
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
CNSTI4 8
ARGI4
ADDRGP4 UI_ResolutionToAspect
CALLV
pop
line 7535
;7535:				Com_sprintf(modeName, sizeof(modeName), "%s (%s)", mode, aspect);
ADDRLP4 36
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $3478
ARGP4
ADDRLP4 1104
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 7537
;7536:
;7537:				multiPtr->cvarList[multiPtr->count] = String_Alloc(modeName);
ADDRLP4 36
ARGP4
ADDRLP4 1120
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
ADDP4
ADDRLP4 1120
INDIRP4
ASGNP4
line 7539
;7538:
;7539:				for (i = 0; builtinResolutions[i]; i++) {
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRGP4 $3482
JUMPV
LABELV $3479
line 7540
;7540:					if (!Q_stricmp(builtinResolutions[i], mode)) {
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 builtinResolutions
ADDP4
INDIRP4
ARGP4
ADDRLP4 1104
INDIRP4
ARGP4
ADDRLP4 1128
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1128
INDIRI4
CNSTI4 0
NEI4 $3483
line 7541
;7541:						multiPtr->cvarStr[multiPtr->count] = builtinResolutions[i];
ADDRLP4 32
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 128
ADDP4
ADDP4
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 builtinResolutions
ADDP4
INDIRP4
ASGNP4
line 7542
;7542:						multiPtr->cvarValue[multiPtr->count] = i;
ADDRLP4 32
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 256
ADDP4
ADDP4
ADDRLP4 28
INDIRI4
CVIF4 4
ASGNF4
line 7543
;7543:						break;
ADDRGP4 $3481
JUMPV
LABELV $3483
line 7545
;7544:					}
;7545:				}
LABELV $3480
line 7539
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3482
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 builtinResolutions
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3479
LABELV $3481
line 7547
;7546:
;7547:				if (builtinResolutions[i] == NULL) {
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 builtinResolutions
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3485
line 7548
;7548:					multiPtr->cvarStr[multiPtr->count] = String_Alloc(mode);
ADDRLP4 1104
INDIRP4
ARGP4
ADDRLP4 1128
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 128
ADDP4
ADDP4
ADDRLP4 1128
INDIRP4
ASGNP4
line 7549
;7549:					multiPtr->cvarValue[multiPtr->count] = -1;
ADDRLP4 32
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 256
ADDP4
ADDP4
CNSTF4 3212836864
ASGNF4
line 7550
;7550:				}
LABELV $3485
line 7552
;7551:
;7552:				multiPtr->count++;
ADDRLP4 1128
ADDRLP4 32
INDIRP4
CNSTI4 384
ADDP4
ASGNP4
ADDRLP4 1128
INDIRP4
ADDRLP4 1128
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 7553
;7553:			}
LABELV $3474
line 7527
ADDRLP4 1108
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3487
ADDRLP4 32
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 32
LTI4 $3473
LABELV $3487
line 7554
;7554:		} else {
ADDRGP4 $3472
JUMPV
LABELV $3471
line 7555
;7555:			for (i = 0; builtinResolutions[i] && multiPtr->count < MAX_MULTI_CVARS; i++) {
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRGP4 $3491
JUMPV
LABELV $3488
line 7556
;7556:				UI_ResolutionToAspect(builtinResolutions[i], aspect, sizeof(aspect));
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 builtinResolutions
ADDP4
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
CNSTI4 8
ARGI4
ADDRGP4 UI_ResolutionToAspect
CALLV
pop
line 7557
;7557:				Com_sprintf(modeName, sizeof(modeName), "%s (%s)", builtinResolutions[i], aspect);
ADDRLP4 36
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $3478
ARGP4
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 builtinResolutions
ADDP4
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 7559
;7558:
;7559:				multiPtr->cvarList[multiPtr->count] = String_Alloc(modeName);
ADDRLP4 36
ARGP4
ADDRLP4 1104
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
ADDP4
ADDRLP4 1104
INDIRP4
ASGNP4
line 7560
;7560:				multiPtr->cvarStr[multiPtr->count] = builtinResolutions[i];
ADDRLP4 32
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 128
ADDP4
ADDP4
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 builtinResolutions
ADDP4
INDIRP4
ASGNP4
line 7561
;7561:				multiPtr->cvarValue[multiPtr->count] = i;
ADDRLP4 32
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 256
ADDP4
ADDP4
ADDRLP4 28
INDIRI4
CVIF4 4
ASGNF4
line 7562
;7562:				multiPtr->count++;
ADDRLP4 1120
ADDRLP4 32
INDIRP4
CNSTI4 384
ADDP4
ASGNP4
ADDRLP4 1120
INDIRP4
ADDRLP4 1120
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 7563
;7563:			}
LABELV $3489
line 7555
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3491
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 builtinResolutions
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3492
ADDRLP4 32
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 32
LTI4 $3488
LABELV $3492
line 7564
;7564:		}
LABELV $3472
line 7567
;7565:
;7566:		// Add custom resolution if not in mode list
;7567:		if (multiPtr->count < MAX_MULTI_CVARS) {
ADDRLP4 32
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 32
GEI4 $3493
line 7570
;7568:			char currentResolution[20];
;7569:
;7570:			Com_sprintf(currentResolution, sizeof(currentResolution), "%dx%d", DC->glconfig.vidWidth, DC->glconfig.vidHeight);
ADDRLP4 1104
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 $3495
ARGP4
ADDRLP4 1124
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 1124
INDIRP4
CNSTI4 5354300
ADDP4
INDIRI4
ARGI4
ADDRLP4 1124
INDIRP4
CNSTI4 5354304
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 7571
;7571:			for (i = 0; i < multiPtr->count; i++) {
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRGP4 $3499
JUMPV
LABELV $3496
line 7572
;7572:				if (!Q_stricmp(multiPtr->cvarStr[i], currentResolution)) {
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 128
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1104
ARGP4
ADDRLP4 1128
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1128
INDIRI4
CNSTI4 0
NEI4 $3500
line 7573
;7573:					break;
ADDRGP4 $3498
JUMPV
LABELV $3500
line 7575
;7574:				}
;7575:			}
LABELV $3497
line 7571
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3499
ADDRLP4 28
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
LTI4 $3496
LABELV $3498
line 7577
;7576:
;7577:			if (i == multiPtr->count) {
ADDRLP4 28
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
NEI4 $3502
line 7578
;7578:				UI_ResolutionToAspect(currentResolution, aspect, sizeof(aspect));
ADDRLP4 1104
ARGP4
ADDRLP4 68
ARGP4
CNSTI4 8
ARGI4
ADDRGP4 UI_ResolutionToAspect
CALLV
pop
line 7579
;7579:				Com_sprintf(modeName, sizeof(modeName), "%s (%s)", currentResolution, aspect);
ADDRLP4 36
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $3478
ARGP4
ADDRLP4 1104
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 Com_sprintf
CALLI4
pop
line 7581
;7580:
;7581:				multiPtr->cvarList[multiPtr->count] = String_Alloc(modeName);
ADDRLP4 36
ARGP4
ADDRLP4 1128
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
ADDP4
ADDRLP4 1128
INDIRP4
ASGNP4
line 7582
;7582:				multiPtr->cvarStr[multiPtr->count] = String_Alloc(currentResolution);
ADDRLP4 1104
ARGP4
ADDRLP4 1136
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 128
ADDP4
ADDP4
ADDRLP4 1136
INDIRP4
ASGNP4
line 7583
;7583:				multiPtr->cvarValue[multiPtr->count] = -1;
ADDRLP4 32
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 256
ADDP4
ADDP4
CNSTF4 3212836864
ASGNF4
line 7584
;7584:				multiPtr->count++;
ADDRLP4 1148
ADDRLP4 32
INDIRP4
CNSTI4 384
ADDP4
ASGNP4
ADDRLP4 1148
INDIRP4
ADDRLP4 1148
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 7585
;7585:			}
LABELV $3502
line 7586
;7586:		}
LABELV $3493
line 7588
;7587:
;7588:		Com_Printf("Found video mode list with %d modes, replaced list with %d modes\n", oldCount, multiPtr->count);
ADDRGP4 $3504
ARGP4
ADDRLP4 1100
INDIRI4
ARGI4
ADDRLP4 32
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 7589
;7589:	}
LABELV $3467
line 7591
;7590:
;7591:}
LABELV $3450
endproc Item_ApplyHacks 1152 20
proc Item_Parse 2080 16
line 7598
;7592:
;7593:/*
;7594:===============
;7595:Item_Parse
;7596:===============
;7597:*/
;7598:static qboolean Item_Parse(int handle, itemDef_t *item) {
line 7602
;7599:	pc_token_t token;
;7600:	keywordHash_t *key;
;7601:
;7602:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $3506
line 7603
;7603:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3505
JUMPV
LABELV $3506
line 7604
;7604:	if (*token.string != '{') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $3508
line 7605
;7605:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3505
JUMPV
LABELV $3508
line 7608
;7606:	}
;7607:
;7608:	UseScriptBuffer = qfalse;
ADDRGP4 UseScriptBuffer
CNSTI4 0
ASGNI4
ADDRGP4 $3512
JUMPV
LABELV $3511
line 7609
;7609:	while (1) {
LABELV $3514
line 7611
;7610:	loopStart:
;7611:		if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1048
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $3519
line 7612
;7612:			PC_SourceError(handle, "Item_Parse() end of file inside menu item");
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $3517
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 7613
;7613:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3505
JUMPV
LABELV $3518
line 7618
;7614:		}
;7615:
;7616:		// hack for reading extra token in parse_if()
;7617:		// returns qfalse if last token was '}'
;7618:		while (!Q_stricmp(token.string, "if")) {
line 7621
;7619:			char s[MAX_TOKEN_CHARS];
;7620:
;7621:			if (!ItemParse_if(item, handle, s, qfalse)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1052
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 2076
ADDRGP4 ItemParse_if
CALLI4
ASGNI4
ADDRLP4 2076
INDIRI4
CNSTI4 0
NEI4 $3522
line 7622
;7622:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3505
JUMPV
LABELV $3522
line 7624
;7623:			}
;7624:			if (s[0] == '\0') {
ADDRLP4 1052
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3524
line 7625
;7625:				goto loopStart;
ADDRGP4 $3514
JUMPV
LABELV $3524
line 7627
;7626:			}
;7627:			Q_strncpyz(token.string, s, sizeof(token.string));
ADDRLP4 0+16
ARGP4
ADDRLP4 1052
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 7628
;7628:		}
LABELV $3519
line 7618
ADDRLP4 0+16
ARGP4
ADDRGP4 $3413
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
EQI4 $3518
line 7630
;7629:
;7630:		if (*token.string == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $3528
line 7631
;7631:			Item_ApplyHacks(item);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Item_ApplyHacks
CALLV
pop
line 7632
;7632:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3505
JUMPV
LABELV $3528
line 7635
;7633:		}
;7634:
;7635:		key = KeywordHash_Find(itemParseKeywordHash, token.string);
ADDRGP4 itemParseKeywordHash
ARGP4
ADDRLP4 0+16
ARGP4
ADDRLP4 1056
ADDRGP4 KeywordHash_Find
CALLP4
ASGNP4
ADDRLP4 1040
ADDRLP4 1056
INDIRP4
ASGNP4
line 7636
;7636:		if (!key) {
ADDRLP4 1040
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3532
line 7637
;7637:			PC_SourceError(handle, "Item_Parse() unknown menu item keyword %s", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $3534
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 7638
;7638:			continue;
ADDRGP4 $3512
JUMPV
LABELV $3532
line 7641
;7639:		}
;7640:
;7641:		if (!key->func(item, handle)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1060
ADDRLP4 1040
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $3536
line 7642
;7642:			PC_SourceError(handle, "Item_Parse() couldn't parse menu item keyword %s", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $3538
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 7643
;7643:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3505
JUMPV
LABELV $3536
line 7645
;7644:		}
;7645:	}
LABELV $3512
line 7609
ADDRGP4 $3511
JUMPV
line 7646
;7646:	return qfalse;
CNSTI4 0
RETI4
LABELV $3505
endproc Item_Parse 2080 16
proc Item_InitControls 4 0
line 7652
;7647:}
;7648:
;7649:
;7650:// Item_InitControls
;7651:// init's special control types
;7652:static void Item_InitControls(itemDef_t *item) {
line 7653
;7653:	if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3541
line 7654
;7654:		return;
ADDRGP4 $3540
JUMPV
LABELV $3541
line 7656
;7655:	}
;7656:	if (item->type == ITEM_TYPE_LISTBOX) {
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 6
NEI4 $3543
line 7657
;7657:		listBoxDef_t *listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 572
ADDP4
INDIRP4
ASGNP4
line 7658
;7658:		item->cursorPos = 0;
ADDRFP4 0
INDIRP4
CNSTI4 564
ADDP4
CNSTI4 0
ASGNI4
line 7659
;7659:		if (listPtr) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3545
line 7660
;7660:			listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 7661
;7661:			listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 7662
;7662:			listPtr->endPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 7663
;7663:			listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 7664
;7664:		}
LABELV $3545
line 7665
;7665:	}
LABELV $3543
line 7666
;7666:}
LABELV $3540
endproc Item_InitControls 4 0
proc MenuParse_font 12 12
line 7674
;7667:
;7668:/*
;7669:===============
;7670:Menu Keyword Parse functions
;7671:===============
;7672:*/
;7673:
;7674:static qboolean MenuParse_font(itemDef_t *item, int handle) {
line 7675
;7675:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 7676
;7676:	if (!PC_String_Parse(handle, &menu->font)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $3548
line 7677
;7677:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3547
JUMPV
LABELV $3548
line 7679
;7678:	}
;7679:	if (!DC->Assets.fontRegistered) {
ADDRGP4 DC
INDIRP4
CNSTI4 5342840
ADDP4
INDIRI4
CNSTI4 0
NEI4 $3550
line 7680
;7680:		DC->registerFont(menu->font, 48, &DC->Assets.textFont);
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRP4
ARGP4
CNSTI4 48
ARGI4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 248
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 64
ADDP4
INDIRP4
CALLV
pop
line 7681
;7681:		DC->Assets.fontRegistered = qtrue;
ADDRGP4 DC
INDIRP4
CNSTI4 5342840
ADDP4
CNSTI4 1
ASGNI4
line 7682
;7682:	}
LABELV $3550
line 7683
;7683:	return qtrue;
CNSTI4 1
RETI4
LABELV $3547
endproc MenuParse_font 12 12
proc MenuParse_name 12 8
line 7686
;7684:}
;7685:
;7686:static qboolean MenuParse_name(itemDef_t *item, int handle) {
line 7687
;7687:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 7688
;7688:	if (!PC_String_Parse(handle, &menu->window.name)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $3553
line 7689
;7689:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3552
JUMPV
LABELV $3553
line 7691
;7690:	}
;7691:	if (Q_stricmp(menu->window.name, "main") == 0) {
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
ARGP4
ADDRGP4 $3557
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $3555
line 7694
;7692:		// default main as having focus
;7693:		//menu->window.flags |= WINDOW_HASFOCUS;
;7694:	}
LABELV $3555
line 7695
;7695:	return qtrue;
CNSTI4 1
RETI4
LABELV $3552
endproc MenuParse_name 12 8
proc MenuParse_fullscreen 12 8
line 7698
;7696:}
;7697:
;7698:static qboolean MenuParse_fullscreen(itemDef_t *item, int handle) {
line 7699
;7699:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 7705
;7700:	union {
;7701:		qboolean b;
;7702:		int i;
;7703:	} fullScreen;
;7704:
;7705:	if (!PC_Int_Parse(handle, &fullScreen.i)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $3560
line 7706
;7706:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3558
JUMPV
LABELV $3560
line 7708
;7707:	}
;7708:	menu->fullScreen = fullScreen.b;
ADDRLP4 0
INDIRP4
CNSTI4 192
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 7709
;7709:	return qtrue;
CNSTI4 1
RETI4
LABELV $3558
endproc MenuParse_fullscreen 12 8
proc MenuParse_rect 8 8
line 7712
;7710:}
;7711:
;7712:static qboolean MenuParse_rect(itemDef_t *item, int handle) {
line 7713
;7713:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 7714
;7714:	if (!PC_Rect_Parse(handle, &menu->window.rect)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Rect_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $3563
line 7715
;7715:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3562
JUMPV
LABELV $3563
line 7717
;7716:	}
;7717:	return qtrue;
CNSTI4 1
RETI4
LABELV $3562
endproc MenuParse_rect 8 8
proc MenuParse_style 8 8
line 7720
;7718:}
;7719:
;7720:static qboolean MenuParse_style(itemDef_t *item, int handle) {
line 7721
;7721:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 7722
;7722:	if (!PC_Int_Parse(handle, &menu->window.style)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $3566
line 7723
;7723:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3565
JUMPV
LABELV $3566
line 7725
;7724:	}
;7725:	return qtrue;
CNSTI4 1
RETI4
LABELV $3565
endproc MenuParse_style 8 8
proc MenuParse_visible 16 8
line 7728
;7726:}
;7727:
;7728:static qboolean MenuParse_visible(itemDef_t *item, int handle) {
line 7730
;7729:	int i;
;7730:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 7732
;7731:
;7732:	if (!PC_Int_Parse(handle, &i)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $3569
line 7733
;7733:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3568
JUMPV
LABELV $3569
line 7735
;7734:	}
;7735:	if (i) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $3571
line 7736
;7736:		menu->window.flags |= WINDOW_VISIBLE;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 7737
;7737:	} else {
ADDRGP4 $3572
JUMPV
LABELV $3571
line 7738
;7738:		menu->window.flags &= ~WINDOW_VISIBLE;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 -5
BANDI4
ASGNI4
line 7739
;7739:	}
LABELV $3572
line 7741
;7740:
;7741:	return qtrue;
CNSTI4 1
RETI4
LABELV $3568
endproc MenuParse_visible 16 8
proc MenuParse_onOpen 8 8
line 7744
;7742:}
;7743:
;7744:static qboolean MenuParse_onOpen(itemDef_t *item, int handle) {
line 7745
;7745:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 7746
;7746:	if (!PC_Script_Parse(handle, &menu->onOpen)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 220
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $3574
line 7747
;7747:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3573
JUMPV
LABELV $3574
line 7749
;7748:	}
;7749:	return qtrue;
CNSTI4 1
RETI4
LABELV $3573
endproc MenuParse_onOpen 8 8
proc MenuParse_onClose 8 8
line 7752
;7750:}
;7751:
;7752:static qboolean MenuParse_onClose(itemDef_t *item, int handle) {
line 7753
;7753:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 7754
;7754:	if (!PC_Script_Parse(handle, &menu->onClose)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $3577
line 7755
;7755:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3576
JUMPV
LABELV $3577
line 7757
;7756:	}
;7757:	return qtrue;
CNSTI4 1
RETI4
LABELV $3576
endproc MenuParse_onClose 8 8
proc MenuParse_onESC 8 8
line 7760
;7758:}
;7759:
;7760:static qboolean MenuParse_onESC(itemDef_t *item, int handle) {
line 7761
;7761:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 7762
;7762:	if (!PC_Script_Parse(handle, &menu->onESC)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $3580
line 7763
;7763:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3579
JUMPV
LABELV $3580
line 7765
;7764:	}
;7765:	return qtrue;
CNSTI4 1
RETI4
LABELV $3579
endproc MenuParse_onESC 8 8
proc MenuParse_border 8 8
line 7770
;7766:}
;7767:
;7768:
;7769:
;7770:static qboolean MenuParse_border(itemDef_t *item, int handle) {
line 7771
;7771:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 7772
;7772:	if (!PC_Int_Parse(handle, &menu->window.border)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $3583
line 7773
;7773:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3582
JUMPV
LABELV $3583
line 7775
;7774:	}
;7775:	return qtrue;
CNSTI4 1
RETI4
LABELV $3582
endproc MenuParse_border 8 8
proc MenuParse_borderSize 8 8
line 7778
;7776:}
;7777:
;7778:static qboolean MenuParse_borderSize(itemDef_t *item, int handle) {
line 7779
;7779:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 7780
;7780:	if (!PC_Float_Parse(handle, &menu->window.borderSize)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $3586
line 7781
;7781:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3585
JUMPV
LABELV $3586
line 7783
;7782:	}
;7783:	return qtrue;
CNSTI4 1
RETI4
LABELV $3585
endproc MenuParse_borderSize 8 8
proc MenuParse_backcolor 16 8
line 7786
;7784:}
;7785:
;7786:static qboolean MenuParse_backcolor(itemDef_t *item, int handle) {
line 7789
;7787:	int i;
;7788:	float f;
;7789:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 7791
;7790:
;7791:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $3589
line 7792
;7792:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $3593
line 7793
;7793:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3588
JUMPV
LABELV $3593
line 7795
;7794:		}
;7795:		menu->window.backColor[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 132
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 7796
;7796:	}
LABELV $3590
line 7791
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $3589
line 7797
;7797:	return qtrue;
CNSTI4 1
RETI4
LABELV $3588
endproc MenuParse_backcolor 16 8
proc MenuParse_forecolor 20 8
line 7800
;7798:}
;7799:
;7800:static qboolean MenuParse_forecolor(itemDef_t *item, int handle) {
line 7803
;7801:	int i;
;7802:	float f;
;7803:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 7805
;7804:
;7805:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $3596
line 7806
;7806:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $3600
line 7807
;7807:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3595
JUMPV
LABELV $3600
line 7809
;7808:		}
;7809:		menu->window.foreColor[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
line 7810
;7810:		menu->window.flags |= WINDOW_FORECOLORSET;
ADDRLP4 16
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
line 7812
;7811:		//Com_Printf("color[%d] %f\n", i, f);
;7812:	}
LABELV $3597
line 7805
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $3596
line 7813
;7813:	return qtrue;
CNSTI4 1
RETI4
LABELV $3595
endproc MenuParse_forecolor 20 8
proc MenuParse_bordercolor 16 8
line 7816
;7814:}
;7815:
;7816:static qboolean MenuParse_bordercolor(itemDef_t *item, int handle) {
line 7819
;7817:	int i;
;7818:	float f;
;7819:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 7821
;7820:
;7821:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $3603
line 7822
;7822:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $3607
line 7823
;7823:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3602
JUMPV
LABELV $3607
line 7825
;7824:		}
;7825:		menu->window.borderColor[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 148
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 7826
;7826:	}
LABELV $3604
line 7821
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $3603
line 7827
;7827:	return qtrue;
CNSTI4 1
RETI4
LABELV $3602
endproc MenuParse_bordercolor 16 8
proc MenuParse_focuscolor 16 8
line 7830
;7828:}
;7829:
;7830:static qboolean MenuParse_focuscolor(itemDef_t *item, int handle) {
line 7833
;7831:	int i;
;7832:	float f;
;7833:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 7835
;7834:
;7835:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $3610
line 7836
;7836:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $3614
line 7837
;7837:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3609
JUMPV
LABELV $3614
line 7839
;7838:		}
;7839:		menu->focusColor[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 236
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 7840
;7840:	}
LABELV $3611
line 7835
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $3610
line 7841
;7841:	return qtrue;
CNSTI4 1
RETI4
LABELV $3609
endproc MenuParse_focuscolor 16 8
proc MenuParse_disablecolor 16 8
line 7844
;7842:}
;7843:
;7844:static qboolean MenuParse_disablecolor(itemDef_t *item, int handle) {
line 7847
;7845:	int i;
;7846:	float f;
;7847:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 7848
;7848:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $3617
line 7849
;7849:		if (!PC_Float_Parse(handle, &f)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 12
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $3621
line 7850
;7850:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3616
JUMPV
LABELV $3621
line 7852
;7851:		}
;7852:		menu->disableColor[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 252
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 7853
;7853:	}
LABELV $3618
line 7848
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $3617
line 7854
;7854:	return qtrue;
CNSTI4 1
RETI4
LABELV $3616
endproc MenuParse_disablecolor 16 8
proc MenuParse_outlinecolor 8 8
line 7858
;7855:}
;7856:
;7857:
;7858:static qboolean MenuParse_outlinecolor(itemDef_t *item, int handle) {
line 7859
;7859:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 7860
;7860:	if (!PC_Color_Parse(handle, &menu->window.outlineColor)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Color_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $3624
line 7861
;7861:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3623
JUMPV
LABELV $3624
line 7863
;7862:	}
;7863:	return qtrue;
CNSTI4 1
RETI4
LABELV $3623
endproc MenuParse_outlinecolor 8 8
proc MenuParse_background 24 8
line 7866
;7864:}
;7865:
;7866:static qboolean MenuParse_background(itemDef_t *item, int handle) {
line 7868
;7867:	const char *buff;
;7868:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 7870
;7869:
;7870:	if (!PC_String_Parse(handle, &buff)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $3627
line 7871
;7871:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3626
JUMPV
LABELV $3627
line 7873
;7872:	}
;7873:	if (Q_stricmp(buff, menu->window.backgroundName)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $3629
line 7874
;7874:		menu->window.background = DC->registerShaderNoMip(buff);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 DC
INDIRP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 7875
;7875:		menu->window.backgroundName = String_Alloc(buff);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 20
INDIRP4
ASGNP4
line 7876
;7876:	}
LABELV $3629
line 7877
;7877:	return qtrue;
CNSTI4 1
RETI4
LABELV $3626
endproc MenuParse_background 24 8
proc MenuParse_backgroundReset 4 0
line 7880
;7878:}
;7879:
;7880:static qboolean MenuParse_backgroundReset(itemDef_t *item, int handle) {
line 7881
;7881:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 7883
;7882:
;7883:	menu->window.background = 0;
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTI4 0
ASGNI4
line 7884
;7884:	menu->window.backgroundName = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
CNSTP4 0
ASGNP4
line 7886
;7885:
;7886:	return qtrue;
CNSTI4 1
RETI4
LABELV $3631
endproc MenuParse_backgroundReset 4 0
proc MenuParse_cinematic 8 8
line 7889
;7887:}
;7888:
;7889:static qboolean MenuParse_cinematic(itemDef_t *item, int handle) {
line 7890
;7890:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 7892
;7891:
;7892:	if (!PC_String_Parse(handle, &menu->window.cinematicName)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $3633
line 7893
;7893:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3632
JUMPV
LABELV $3633
line 7895
;7894:	}
;7895:	return qtrue;
CNSTI4 1
RETI4
LABELV $3632
endproc MenuParse_cinematic 8 8
proc MenuParse_ownerdrawFlag 16 8
line 7898
;7896:}
;7897:
;7898:static qboolean MenuParse_ownerdrawFlag(itemDef_t *item, int handle) {
line 7900
;7899:	int i;
;7900:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 7902
;7901:
;7902:	if (!PC_Int_Parse(handle, &i)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $3636
line 7903
;7903:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3635
JUMPV
LABELV $3636
line 7905
;7904:	}
;7905:	menu->window.ownerDrawFlags |= i;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 60
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
BORI4
ASGNI4
line 7906
;7906:	return qtrue;
CNSTI4 1
RETI4
LABELV $3635
endproc MenuParse_ownerdrawFlag 16 8
proc MenuParse_ownerdrawFlag2 16 8
line 7909
;7907:}
;7908:
;7909:static qboolean MenuParse_ownerdrawFlag2(itemDef_t *item, int handle) {
line 7911
;7910:	int i;
;7911:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 7913
;7912:
;7913:	if (!PC_Int_Parse(handle, &i)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $3639
line 7914
;7914:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3638
JUMPV
LABELV $3639
line 7916
;7915:	}
;7916:	menu->window.ownerDrawFlags2 |= i;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 64
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
BORI4
ASGNI4
line 7917
;7917:	return qtrue;
CNSTI4 1
RETI4
LABELV $3638
endproc MenuParse_ownerdrawFlag2 16 8
proc MenuParse_ownerdraw 8 8
line 7920
;7918:}
;7919:
;7920:static qboolean MenuParse_ownerdraw(itemDef_t *item, int handle) {
line 7921
;7921:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 7923
;7922:
;7923:	if (!PC_Int_Parse(handle, &menu->window.ownerDraw)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 56
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $3642
line 7924
;7924:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3641
JUMPV
LABELV $3642
line 7926
;7925:	}
;7926:	return qtrue;
CNSTI4 1
RETI4
LABELV $3641
endproc MenuParse_ownerdraw 8 8
proc MenuParse_widescreen 12 12
line 7929
;7927:}
;7928:
;7929:static qboolean MenuParse_widescreen(itemDef_t *item, int handle) {
line 7930
;7930:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 7932
;7931:
;7932:	if (!PC_Int_Parse(handle, &menu->widescreen)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4364
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $3645
line 7933
;7933:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3644
JUMPV
LABELV $3645
line 7940
;7934:	}
;7935:
;7936:	//PC_SourceWarning(handle, "FIXME menu widescreen %d", menu->widescreen);
;7937:
;7938:	//Com_Printf("^1............\n");
;7939:
;7940:	if (menu->widescreen < WIDESCREEN_STRETCH || menu->widescreen > WIDESCREEN_RIGHT) {
ADDRLP4 0
INDIRP4
CNSTI4 4364
ADDP4
INDIRI4
CNSTI4 0
LTI4 $3649
ADDRLP4 0
INDIRP4
CNSTI4 4364
ADDP4
INDIRI4
CNSTI4 3
LEI4 $3647
LABELV $3649
line 7942
;7941:		//Com_Printf("^1MenuParse invalid widescreen value: %d", menu->widescreen);
;7942:		PC_SourceError(handle, "menu parse invalid widescreen value: %d\n", menu->widescreen);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $3650
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4364
ADDP4
INDIRI4
ARGI4
ADDRGP4 PC_SourceError
CALLV
pop
line 7943
;7943:		menu->widescreen = WIDESCREEN_STRETCH;
ADDRLP4 0
INDIRP4
CNSTI4 4364
ADDP4
CNSTI4 0
ASGNI4
line 7944
;7944:	}
LABELV $3647
line 7946
;7945:
;7946:	return qtrue;
CNSTI4 1
RETI4
LABELV $3644
endproc MenuParse_widescreen 12 12
proc MenuParse_popup 8 0
line 7951
;7947:}
;7948:
;7949:
;7950:// decoration
;7951:static qboolean MenuParse_popup(itemDef_t *item, int handle) {
line 7952
;7952:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 7953
;7953:	menu->window.flags |= WINDOW_POPUP;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 2097152
BORI4
ASGNI4
line 7954
;7954:	return qtrue;
CNSTI4 1
RETI4
LABELV $3651
endproc MenuParse_popup 8 0
proc MenuParse_outOfBounds 8 0
line 7958
;7955:}
;7956:
;7957:
;7958:static qboolean MenuParse_outOfBounds(itemDef_t *item, int handle) {
line 7959
;7959:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 7961
;7960:
;7961:	menu->window.flags |= WINDOW_OOB_CLICK;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 131072
BORI4
ASGNI4
line 7962
;7962:	return qtrue;
CNSTI4 1
RETI4
LABELV $3652
endproc MenuParse_outOfBounds 8 0
proc MenuParse_soundLoop 8 8
line 7965
;7963:}
;7964:
;7965:static qboolean MenuParse_soundLoop(itemDef_t *item, int handle) {
line 7966
;7966:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 7968
;7967:
;7968:	if (!PC_String_Parse(handle, &menu->soundName)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $3654
line 7969
;7969:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3653
JUMPV
LABELV $3654
line 7971
;7970:	}
;7971:	return qtrue;
CNSTI4 1
RETI4
LABELV $3653
endproc MenuParse_soundLoop 8 8
proc MenuParse_fadeClamp 8 8
line 7974
;7972:}
;7973:
;7974:static qboolean MenuParse_fadeClamp(itemDef_t *item, int handle) {
line 7975
;7975:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 7977
;7976:
;7977:	if (!PC_Float_Parse(handle, &menu->fadeClamp)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $3657
line 7978
;7978:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3656
JUMPV
LABELV $3657
line 7980
;7979:	}
;7980:	return qtrue;
CNSTI4 1
RETI4
LABELV $3656
endproc MenuParse_fadeClamp 8 8
proc MenuParse_fadeAmount 8 8
line 7983
;7981:}
;7982:
;7983:static qboolean MenuParse_fadeAmount(itemDef_t *item, int handle) {
line 7984
;7984:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 7986
;7985:
;7986:	if (!PC_Float_Parse(handle, &menu->fadeAmount)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $3660
line 7987
;7987:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3659
JUMPV
LABELV $3660
line 7989
;7988:	}
;7989:	return qtrue;
CNSTI4 1
RETI4
LABELV $3659
endproc MenuParse_fadeAmount 8 8
proc MenuParse_fadeCycle 8 8
line 7993
;7990:}
;7991:
;7992:
;7993:static qboolean MenuParse_fadeCycle(itemDef_t *item, int handle) {
line 7994
;7994:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 7996
;7995:
;7996:	if (!PC_Int_Parse(handle, &menu->fadeCycle)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $3663
line 7997
;7997:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3662
JUMPV
LABELV $3663
line 7999
;7998:	}
;7999:	return qtrue;
CNSTI4 1
RETI4
LABELV $3662
endproc MenuParse_fadeCycle 8 8
proc MenuParse_itemDef 48 8
line 8003
;8000:}
;8001:
;8002:
;8003:static qboolean MenuParse_itemDef(itemDef_t *item, int handle) {
line 8004
;8004:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 8005
;8005:	if (menu->itemCount < MAX_MENUITEMS) {
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 1024
GEI4 $3666
line 8006
;8006:		menu->items[menu->itemCount] = UI_Alloc(sizeof(itemDef_t));
CNSTI4 580
ARGI4
ADDRLP4 4
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 8007
;8007:		if (!menu->items[menu->itemCount]) {
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3668
line 8008
;8008:			Com_Printf("^1ERROR:  UI_Alloc() failed for MenuParse_itemDef\n");
ADDRGP4 $3670
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 8009
;8009:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3665
JUMPV
LABELV $3668
line 8011
;8010:		}
;8011:		Item_Init(menu->items[menu->itemCount]);
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_Init
CALLV
pop
line 8013
;8012:		//FIXME widescreen hack
;8013:		menu->items[menu->itemCount]->widescreen = menu->widescreen;
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 576
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 4364
ADDP4
INDIRI4
ASGNI4
line 8014
;8014:		if (!Item_Parse(handle, menu->items[menu->itemCount])) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 Item_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $3671
line 8015
;8015:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3665
JUMPV
LABELV $3671
line 8022
;8016:		}
;8017:		/*
;8018:		if (menu->widescreen != menu->items[menu->itemCount]->widescreen) {
;8019:			Com_Printf("^4new widescreen value: %d from %d\n", menu->items[menu->itemCount]->widescreen, menu->widescreen);
;8020:		}
;8021:		*/
;8022:		Item_InitControls(menu->items[menu->itemCount]);
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_InitControls
CALLV
pop
line 8023
;8023:		menu->items[menu->itemCount++]->parent = menu;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 36
ADDRLP4 40
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRP4
ADDRLP4 36
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 240
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 8024
;8024:	} else {
ADDRGP4 $3667
JUMPV
LABELV $3666
line 8025
;8025:		Com_Printf("^1MenuParse_itemDef() menu->itemCount >= MAX_MENUITEMS (%d)\n", MAX_MENUITEMS);
ADDRGP4 $3673
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 8026
;8026:	}
LABELV $3667
line 8027
;8027:	return qtrue;
CNSTI4 1
RETI4
LABELV $3665
endproc MenuParse_itemDef 48 8
data
export menuParseKeywords
align 4
LABELV menuParseKeywords
address $3349
address MenuParse_font
byte 4 0
address $3279
address MenuParse_name
byte 4 0
address $3674
address MenuParse_fullscreen
byte 4 0
address $3291
address MenuParse_rect
byte 4 0
address $3292
address MenuParse_style
byte 4 0
address $3309
address MenuParse_visible
byte 4 0
address $3675
address MenuParse_onOpen
byte 4 0
address $3676
address MenuParse_onClose
byte 4 0
address $3677
address MenuParse_onESC
byte 4 0
address $3307
address MenuParse_border
byte 4 0
address $3678
address MenuParse_borderSize
byte 4 0
address $618
address MenuParse_backcolor
byte 4 0
address $621
address MenuParse_forecolor
byte 4 0
address $624
address MenuParse_bordercolor
byte 4 0
address $3679
address MenuParse_focuscolor
byte 4 0
address $3680
address MenuParse_disablecolor
byte 4 0
address $3317
address MenuParse_outlinecolor
byte 4 0
address $3318
address MenuParse_background
byte 4 0
address $3319
address MenuParse_backgroundReset
byte 4 0
address $3310
address MenuParse_ownerdraw
byte 4 0
address $3338
address MenuParse_ownerdrawFlag
byte 4 0
address $3339
address MenuParse_ownerdrawFlag2
byte 4 0
address $3681
address MenuParse_outOfBounds
byte 4 0
address $3682
address MenuParse_soundLoop
byte 4 0
address $3683
address MenuParse_itemDef
byte 4 0
address $3345
address MenuParse_cinematic
byte 4 0
address $3684
address MenuParse_popup
byte 4 0
address $3685
address MenuParse_fadeClamp
byte 4 0
address $3686
address MenuParse_fadeCycle
byte 4 0
address $3687
address MenuParse_fadeAmount
byte 4 0
address $833
address ItemParse_setVar
byte 4 0
address $3353
address MenuParse_widescreen
byte 4 0
byte 4 0
byte 4 0
byte 4 0
code
proc Menu_SetupKeywordHash 4 12
line 8073
;8028:}
;8029:
;8030:keywordHash_t menuParseKeywords[] = {
;8031:	{"font", MenuParse_font, NULL},
;8032:	{"name", MenuParse_name, NULL},
;8033:	{"fullscreen", MenuParse_fullscreen, NULL},
;8034:	{"rect", MenuParse_rect, NULL},
;8035:	{"style", MenuParse_style, NULL},
;8036:	{"visible", MenuParse_visible, NULL},
;8037:	{"onOpen", MenuParse_onOpen, NULL},
;8038:	{"onClose", MenuParse_onClose, NULL},
;8039:	{"onESC", MenuParse_onESC, NULL},
;8040:	{"border", MenuParse_border, NULL},
;8041:	{"borderSize", MenuParse_borderSize, NULL},
;8042:	{"backcolor", MenuParse_backcolor, NULL},
;8043:	{"forecolor", MenuParse_forecolor, NULL},
;8044:	{"bordercolor", MenuParse_bordercolor, NULL},
;8045:	{"focuscolor", MenuParse_focuscolor, NULL},
;8046:	{"disablecolor", MenuParse_disablecolor, NULL},
;8047:	{"outlinecolor", MenuParse_outlinecolor, NULL},
;8048:	{"background", MenuParse_background, NULL},
;8049:	{"backgroundreset", MenuParse_backgroundReset, NULL},
;8050:	{"ownerdraw", MenuParse_ownerdraw, NULL},
;8051:	{"ownerdrawFlag", MenuParse_ownerdrawFlag, NULL},
;8052:	{"ownerdrawFlag2", MenuParse_ownerdrawFlag2, NULL},
;8053:	{"outOfBoundsClick", MenuParse_outOfBounds, NULL},
;8054:	{"soundLoop", MenuParse_soundLoop, NULL},
;8055:	{"itemDef", MenuParse_itemDef, NULL},
;8056:	{"cinematic", MenuParse_cinematic, NULL},
;8057:	{"popup", MenuParse_popup, NULL},
;8058:	{"fadeClamp", MenuParse_fadeClamp, NULL},
;8059:	{"fadeCycle", MenuParse_fadeCycle, NULL},
;8060:	{"fadeAmount", MenuParse_fadeAmount, NULL},
;8061:	{"setvar", ItemParse_setVar, NULL},
;8062:	{"widescreen", MenuParse_widescreen, NULL},
;8063:	{NULL, 0, NULL}
;8064:};
;8065:
;8066:keywordHash_t *menuParseKeywordHash[KEYWORDHASH_SIZE];
;8067:
;8068:/*
;8069:===============
;8070:Menu_SetupKeywordHash
;8071:===============
;8072:*/
;8073:static void Menu_SetupKeywordHash(void) {
line 8076
;8074:	int i;
;8075:
;8076:	memset(menuParseKeywordHash, 0, sizeof(menuParseKeywordHash));
ADDRGP4 menuParseKeywordHash
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2048
ARGI4
ADDRGP4 memset
CALLP4
pop
line 8077
;8077:	for (i = 0; menuParseKeywords[i].keyword; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3692
JUMPV
LABELV $3689
line 8078
;8078:		KeywordHash_Add(menuParseKeywordHash, &menuParseKeywords[i]);
ADDRGP4 menuParseKeywordHash
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 menuParseKeywords
ADDP4
ARGP4
ADDRGP4 KeywordHash_Add
CALLV
pop
line 8079
;8079:	}
LABELV $3690
line 8077
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3692
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 menuParseKeywords
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3689
line 8080
;8080:}
LABELV $3688
endproc Menu_SetupKeywordHash 4 12
proc Menu_Parse 1060 12
line 8216
;8081:
;8082:#if 0
;8083:static qboolean MenuParse_if(itemDef_t *item, int handle, char *lastToken);
;8084:
;8085:static void Menu_RunFrameScript(itemDef_t *item, const char *script) {
;8086:	keywordHash_t *key;
;8087:	const char *token;
;8088:	char *oldScriptBuffer;
;8089:	qboolean oldUseScriptBuffer;
;8090:
;8091:	if (item == NULL) {
;8092:		Com_Printf("^1Menu_RunFrameScript() item == NULL\n");
;8093:		return;
;8094:	}
;8095:
;8096:	if (script == NULL) {
;8097:		Com_Printf("^1Menu_RunFrameScript() script == NULL\n");
;8098:		return;
;8099:	}
;8100:
;8101:	oldScriptBuffer = ScriptBuffer;
;8102:	oldUseScriptBuffer = UseScriptBuffer;
;8103:
;8104:	UseScriptBuffer = qtrue;
;8105:	ScriptBuffer = (char *)script;
;8106:	while (1) {
;8107:	loopStart:
;8108:		if (!String_Parse(&ScriptBuffer, &token)) {
;8109:			// all done
;8110:			break;
;8111:		}
;8112:
;8113:		while (!Q_stricmp(token, "if")) {
;8114:			char s[MAX_TOKEN_CHARS];
;8115:
;8116:			if (!MenuParse_if(item, -1, s)) {
;8117:				ScriptBuffer = oldScriptBuffer;
;8118:				UseScriptBuffer = oldUseScriptBuffer;
;8119:				return;
;8120:			}
;8121:			if (s[0] == '\0') {
;8122:				goto loopStart;
;8123:			}
;8124:			token = String_Alloc(s);
;8125:		}
;8126:
;8127:		key = KeywordHash_Find(menuParseKeywordHash, (char *)token);
;8128:		if (!key) {
;8129:			Com_Printf("^1Menu_RunFrameScript()  unknown menu item keyword '%s'\n", token);
;8130:			continue;
;8131:		}
;8132:		if (!key->func(item, -1)) {
;8133:			Com_Printf("^1Menu_RunFrameScript()  couldn't parse menu item keyword '%s'\n", token);
;8134:			break;
;8135:		}
;8136:	}
;8137:
;8138:	ScriptBuffer = oldScriptBuffer;
;8139:	UseScriptBuffer = oldUseScriptBuffer;
;8140:}
;8141:
;8142:static qboolean MenuParse_if(itemDef_t *item, int handle, char *lastToken) {
;8143:	char *mathScript;
;8144:	const char *script;
;8145:	float f;
;8146:	int err;
;8147:	int oldUseScriptBuffer;
;8148:	char *oldScriptBuffer;
;8149:	const char *token;
;8150:	qboolean runElse;
;8151:
;8152:	if (!PC_Parenthesis_Parse(handle, (const char **)&mathScript)) {
;8153:		return qfalse;
;8154:	}
;8155:
;8156:	Q_MathScript(mathScript, &f, &err);
;8157:	if (!PC_Script_Parse(handle, &script)) {
;8158:		return qfalse;
;8159:	}
;8160:
;8161:	runElse = qfalse;
;8162:	if (f == 0.0) {
;8163:		runElse = qtrue;
;8164:	}
;8165:
;8166:	// handle 'if' block
;8167:	if (!runElse) {
;8168:		//FIXME :(
;8169:		oldUseScriptBuffer = UseScriptBuffer;
;8170:		oldScriptBuffer = ScriptBuffer;
;8171:
;8172:		Menu_RunFrameScript(item, script);
;8173:
;8174:		ScriptBuffer = oldScriptBuffer;
;8175:		UseScriptBuffer = oldUseScriptBuffer;
;8176:	}
;8177:
;8178:	// handle 'else' block
;8179:
;8180:	if (!PC_String_Parse(handle, &token)) {
;8181:		// end of script
;8182:		lastToken[0] = '\0';
;8183:		return qtrue;
;8184:	}
;8185:
;8186:	Q_strncpyz(lastToken, token, MAX_TOKEN_CHARS);
;8187:
;8188:	if (token[0] == '}') {
;8189:		return qtrue;
;8190:	} else	if (!Q_stricmp(token, "else")) {
;8191:		if (!PC_Script_Parse(handle, &script)) {
;8192:			return qfalse;
;8193:		}
;8194:		if (runElse) {
;8195:			oldUseScriptBuffer = UseScriptBuffer;
;8196:			oldScriptBuffer = ScriptBuffer;
;8197:
;8198:			Menu_RunFrameScript(item, script);
;8199:
;8200:			ScriptBuffer = oldScriptBuffer;
;8201:			UseScriptBuffer = oldUseScriptBuffer;
;8202:		}
;8203:		lastToken[0] = '\0';
;8204:		return qtrue;
;8205:	} else {
;8206:		return qtrue;
;8207:	}
;8208:}
;8209:#endif
;8210:
;8211:/*
;8212:===============
;8213:Menu_Parse
;8214:===============
;8215:*/
;8216:static qboolean Menu_Parse(int handle, menuDef_t *menu) {
line 8220
;8217:	pc_token_t token;
;8218:	keywordHash_t *key;
;8219:
;8220:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $3694
line 8221
;8221:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3693
JUMPV
LABELV $3694
line 8222
;8222:	if (*token.string != '{') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $3700
line 8223
;8223:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3693
JUMPV
LABELV $3699
line 8226
;8224:	}
;8225:
;8226:	while (1) {
line 8228
;8227:
;8228:		memset(&token, 0, sizeof(pc_token_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1040
ARGI4
ADDRGP4 memset
CALLP4
pop
line 8229
;8229:		if (!trap_PC_ReadToken(handle, &token)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1048
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $3702
line 8230
;8230:			PC_SourceError(handle, "end of file inside menu");
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $3704
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 8231
;8231:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3693
JUMPV
LABELV $3702
line 8251
;8232:		}
;8233:
;8234:#if 0
;8235:		// hack for reading extra token in parse_if()
;8236:		// returns qfalse if last token was '}'
;8237:		if (!Q_stricmp(token.string, "if")) {
;8238:			char s[MAX_TOKEN_CHARS];
;8239:
;8240:			Com_Printf("menuparse if\n");
;8241:			if (!MenuParse_if((itemDef_t *)menu, handle, s)) {
;8242:				return qfalse;
;8243:			}
;8244:			if (s[0] == '\0') {
;8245:				continue;
;8246:			}
;8247:			Q_strncpyz(token.string, s, sizeof(token.string));
;8248:		}
;8249:#endif
;8250:
;8251:		if (*token.string == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $3705
line 8253
;8252:			//PC_SourceError(handle, "close %s", token.string);
;8253:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3693
JUMPV
LABELV $3705
line 8256
;8254:		}
;8255:
;8256:		key = KeywordHash_Find(menuParseKeywordHash, token.string);
ADDRGP4 menuParseKeywordHash
ARGP4
ADDRLP4 0+16
ARGP4
ADDRLP4 1052
ADDRGP4 KeywordHash_Find
CALLP4
ASGNP4
ADDRLP4 1040
ADDRLP4 1052
INDIRP4
ASGNP4
line 8257
;8257:		if (!key) {
ADDRLP4 1040
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3709
line 8258
;8258:			PC_SourceError(handle, "unknown menu keyword %s", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $3711
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 8259
;8259:			continue;
ADDRGP4 $3700
JUMPV
LABELV $3709
line 8261
;8260:		}
;8261:		if (!key->func((itemDef_t *)menu, handle)) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1056
ADDRLP4 1040
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $3713
line 8262
;8262:			PC_SourceError(handle, "couldn't parse menu keyword %s", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $3715
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 8263
;8263:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3693
JUMPV
LABELV $3713
line 8265
;8264:		}
;8265:	}
LABELV $3700
line 8226
ADDRGP4 $3699
JUMPV
line 8266
;8266:	return qfalse;
CNSTI4 0
RETI4
LABELV $3693
endproc Menu_Parse 1060 12
export Menu_New
proc Menu_New 12 8
line 8274
;8267:}
;8268:
;8269:/*
;8270:===============
;8271:Menu_New
;8272:===============
;8273:*/
;8274:void Menu_New(int handle) {
line 8275
;8275:	menuDef_t *menu = &Menus[menuCount];
ADDRLP4 0
ADDRGP4 menuCount
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus
ADDP4
ASGNP4
line 8277
;8276:
;8277:	if (menuCount < MAX_MENUS) {
ADDRGP4 menuCount
INDIRI4
CNSTI4 512
GEI4 $3718
line 8278
;8278:		Menu_Init(menu);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_Init
CALLV
pop
line 8279
;8279:		if (Menu_Parse(handle, menu)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Menu_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $3719
line 8280
;8280:			Menu_PostParse(menu);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_PostParse
CALLV
pop
line 8281
;8281:			menuCount++;
ADDRLP4 8
ADDRGP4 menuCount
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 8282
;8282:		}
line 8283
;8283:	} else {
ADDRGP4 $3719
JUMPV
LABELV $3718
line 8284
;8284:		Com_Printf("^1ERROR: Menu_New() already at MAX_MENUS  %d\n", MAX_MENUS);
ADDRGP4 $3722
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 8285
;8285:	}
LABELV $3719
line 8286
;8286:}
LABELV $3717
endproc Menu_New 12 8
export Menu_Count
proc Menu_Count 0 0
line 8288
;8287:
;8288:int Menu_Count(void) {
line 8289
;8289:	return menuCount;
ADDRGP4 menuCount
INDIRI4
RETI4
LABELV $3723
endproc Menu_Count 0 0
export Menu_HandleCapture
proc Menu_HandleCapture 0 4
line 8292
;8290:}
;8291:
;8292:void Menu_HandleCapture(void) {
line 8293
;8293:	if (captureFunc) {
ADDRGP4 captureFunc
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3725
line 8295
;8294:		//Com_Printf("^6calling capture func %p\n", captureFunc);
;8295:		captureFunc(captureData);
ADDRGP4 captureData
INDIRP4
ARGP4
ADDRGP4 captureFunc
INDIRP4
CALLV
pop
line 8296
;8296:	}
LABELV $3725
line 8297
;8297:}
LABELV $3724
endproc Menu_HandleCapture 0 4
data
align 4
LABELV $3734
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
export Menu_PaintAll
code
proc Menu_PaintAll 44 40
line 8299
;8298:
;8299:void Menu_PaintAll(void) {
line 8302
;8300:	int i;
;8301:
;8302:	Menu_HandleCapture();
ADDRGP4 Menu_HandleCapture
CALLV
pop
line 8304
;8303:
;8304:	for (i = 0; i < Menu_Count(); i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3731
JUMPV
LABELV $3728
line 8305
;8305:		Menu_Paint(&Menus[i], qfalse);
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_Paint
CALLV
pop
line 8307
;8306:		//Com_Printf("Menu_PaintAll %d  '%s'\n", i, Menus[i].window.name);
;8307:	}
LABELV $3729
line 8304
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3731
ADDRLP4 4
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $3728
line 8309
;8308:
;8309:	if (debugMode) {
ADDRGP4 debugMode
INDIRI4
CNSTI4 0
EQI4 $3732
line 8310
;8310:		vec4_t v = { 1, 1, 1, 1 };
ADDRLP4 8
ADDRGP4 $3734
INDIRB
ASGNB 16
line 8312
;8311:		rectDef_t r;
;8312:		memset(&r, 0, sizeof(rectDef_t));
ADDRLP4 24
ARGP4
CNSTI4 0
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 memset
CALLP4
pop
line 8313
;8313:		DC->drawText(5, 25, .5, v, va("fps: %f", DC->FPS), 0, 0, 0, 0, 0); // , r);
ADDRGP4 $3735
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 5354340
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
CNSTF4 1084227584
ARGF4
CNSTF4 1103626240
ARGF4
CNSTF4 1056964608
ARGF4
ADDRLP4 8
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 16
ADDP4
INDIRP4
CALLV
pop
line 8314
;8314:	}
LABELV $3732
line 8315
;8315:}
LABELV $3727
endproc Menu_PaintAll 44 40
export Menu_Reset
proc Menu_Reset 0 4
line 8317
;8316:
;8317:void Menu_Reset(void) {
line 8318
;8318:	Com_Printf("Menu_Reset()\n");
ADDRGP4 $3737
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 8319
;8319:	menuCount = 0;
ADDRGP4 menuCount
CNSTI4 0
ASGNI4
line 8320
;8320:}
LABELV $3736
endproc Menu_Reset 0 4
export Display_GetContext
proc Display_GetContext 0 0
line 8322
;8321:
;8322:displayContextDef_t *Display_GetContext(void) {
line 8323
;8323:	return DC;
ADDRGP4 DC
INDIRP4
RETP4
LABELV $3738
endproc Display_GetContext 0 0
export Display_CaptureItem
proc Display_CaptureItem 12 16
line 8331
;8324:}
;8325:
;8326:#ifndef MISSIONPACK
;8327:static float captureX;
;8328:static float captureY;
;8329:#endif
;8330:
;8331:void *Display_CaptureItem(int x, int y) {
line 8334
;8332:	int i;
;8333:
;8334:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3743
JUMPV
LABELV $3740
line 8337
;8335:		// turn off focus each item
;8336:		// menu->items[i].window.flags &= ~WINDOW_HASFOCUS;
;8337:		if (Rect_ContainsWidescreenPoint(&Menus[i].window.rect, x, y, Menus[i].widescreen)) {
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus+4364
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $3744
line 8338
;8338:			return &Menus[i];
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus
ADDP4
RETP4
ADDRGP4 $3739
JUMPV
LABELV $3744
line 8340
;8339:		}
;8340:	}
LABELV $3741
line 8334
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3743
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $3740
line 8341
;8341:	return NULL;
CNSTP4 0
RETP4
LABELV $3739
endproc Display_CaptureItem 12 16
export Display_MouseMove
proc Display_MouseMove 16 12
line 8346
;8342:}
;8343:
;8344:
;8345:// FIXME: 
;8346:qboolean Display_MouseMove(void *p, int x, int y) {
line 8348
;8347:	int i;
;8348:	menuDef_t *menu = p;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 8350
;8349:
;8350:	if (menu == NULL) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3748
line 8351
;8351:		menu = Menu_GetFocused();
ADDRLP4 8
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 8352
;8352:		if (menu) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3750
line 8353
;8353:			if (menu->window.flags & WINDOW_POPUP) {
ADDRLP4 4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 2097152
BANDI4
CNSTI4 0
EQI4 $3752
line 8354
;8354:				Menu_HandleMouseMove(menu, x, y);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 Menu_HandleMouseMove
CALLV
pop
line 8355
;8355:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3747
JUMPV
LABELV $3752
line 8357
;8356:			}
;8357:		}
LABELV $3750
line 8358
;8358:		for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3757
JUMPV
LABELV $3754
line 8359
;8359:			Menu_HandleMouseMove(&Menus[i], x, y);
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 Menu_HandleMouseMove
CALLV
pop
line 8360
;8360:		}
LABELV $3755
line 8358
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3757
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $3754
line 8361
;8361:	} else {
ADDRGP4 $3749
JUMPV
LABELV $3748
line 8362
;8362:		menu->window.rect.x += x;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRFP4 4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 8363
;8363:		menu->window.rect.y += y;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRFP4 8
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 8364
;8364:		Menu_UpdatePosition(menu);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Menu_UpdatePosition
CALLV
pop
line 8365
;8365:	}
LABELV $3749
line 8366
;8366:	return qtrue;
CNSTI4 1
RETI4
LABELV $3747
endproc Display_MouseMove 16 12
export Display_CursorType
proc Display_CursorType 28 16
line 8370
;8367:
;8368:}
;8369:
;8370:int Display_CursorType(int x, int y) {
line 8372
;8371:	int i;
;8372:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3762
JUMPV
LABELV $3759
line 8374
;8373:		rectDef_t r2;
;8374:		r2.x = Menus[i].window.rect.x - 3;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus
ADDP4
INDIRF4
CNSTF4 1077936128
SUBF4
ASGNF4
line 8375
;8375:		r2.y = Menus[i].window.rect.y - 3;
ADDRLP4 4+4
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus+4
ADDP4
INDIRF4
CNSTF4 1077936128
SUBF4
ASGNF4
line 8376
;8376:		r2.w = r2.h = 7;
ADDRLP4 20
CNSTF4 1088421888
ASGNF4
ADDRLP4 4+12
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 20
INDIRF4
ASGNF4
line 8377
;8377:		if (Rect_ContainsWidescreenPoint(&r2, x, y, Menus[i].widescreen)) {
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus+4364
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $3767
line 8378
;8378:			return CURSOR_SIZER;
CNSTI4 4
RETI4
ADDRGP4 $3758
JUMPV
LABELV $3767
line 8380
;8379:		}
;8380:	}
LABELV $3760
line 8372
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3762
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $3759
line 8381
;8381:	return CURSOR_ARROW;
CNSTI4 2
RETI4
LABELV $3758
endproc Display_CursorType 28 16
export Display_HandleKey
proc Display_HandleKey 12 12
line 8385
;8382:}
;8383:
;8384:
;8385:void Display_HandleKey(int key, qboolean down, int x, int y) {
line 8386
;8386:	menuDef_t *menu = Display_CaptureItem(x, y);
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 Display_CaptureItem
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 8387
;8387:	if (menu == NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3771
line 8388
;8388:		menu = Menu_GetFocused();
ADDRLP4 8
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 8389
;8389:	}
LABELV $3771
line 8390
;8390:	if (menu) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3773
line 8391
;8391:		Menu_HandleKey(menu, key, down);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 Menu_HandleKey
CALLV
pop
line 8392
;8392:	}
LABELV $3773
line 8393
;8393:}
LABELV $3770
endproc Display_HandleKey 12 12
proc Window_CacheContents 8 24
line 8395
;8394:
;8395:static void Window_CacheContents(windowDef_t *window) {
line 8396
;8396:	if (window) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3776
line 8397
;8397:		if (window->cinematicName) {
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3778
line 8399
;8398:			//FIXME widescreen
;8399:			int cin = DC->playCinematic(window->cinematicName, 0, 0, 0, 0, /*widescreen*/ 0); // , window->rect);
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 DC
INDIRP4
CNSTI4 184
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 8400
;8400:			DC->stopCinematic(cin);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 188
ADDP4
INDIRP4
CALLV
pop
line 8401
;8401:		}
LABELV $3778
line 8402
;8402:	}
LABELV $3776
line 8403
;8403:}
LABELV $3775
endproc Window_CacheContents 8 24
proc Item_CacheContents 0 4
line 8406
;8404:
;8405:
;8406:static void Item_CacheContents(itemDef_t *item) {
line 8407
;8407:	if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3781
line 8408
;8408:		Window_CacheContents(&item->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_CacheContents
CALLV
pop
line 8409
;8409:	}
LABELV $3781
line 8411
;8410:
;8411:}
LABELV $3780
endproc Item_CacheContents 0 4
proc Menu_CacheContents 8 8
line 8413
;8412:
;8413:static void Menu_CacheContents(menuDef_t *menu) {
line 8414
;8414:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3784
line 8416
;8415:		int i;
;8416:		Window_CacheContents(&menu->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_CacheContents
CALLV
pop
line 8417
;8417:		for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3789
JUMPV
LABELV $3786
line 8418
;8418:			Item_CacheContents(menu->items[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_CacheContents
CALLV
pop
line 8419
;8419:		}
LABELV $3787
line 8417
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3789
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
LTI4 $3786
line 8421
;8420:
;8421:		if (menu->soundName && *menu->soundName) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 232
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3790
ADDRLP4 4
INDIRP4
CNSTI4 232
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3790
line 8422
;8422:			DC->registerSound(menu->soundName, qfalse);
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 172
ADDP4
INDIRP4
CALLI4
pop
line 8423
;8423:		}
LABELV $3790
line 8424
;8424:	}
LABELV $3784
line 8426
;8425:
;8426:}
LABELV $3783
endproc Menu_CacheContents 8 8
export Display_CacheAll
proc Display_CacheAll 4 4
line 8428
;8427:
;8428:void Display_CacheAll(void) {
line 8430
;8429:	int i;
;8430:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3796
JUMPV
LABELV $3793
line 8431
;8431:		Menu_CacheContents(&Menus[i]);
ADDRLP4 0
INDIRI4
CNSTI4 4368
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRGP4 Menu_CacheContents
CALLV
pop
line 8432
;8432:	}
LABELV $3794
line 8430
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3796
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $3793
line 8433
;8433:}
LABELV $3792
endproc Display_CacheAll 4 4
proc Menu_OverActiveItem 44 16
line 8436
;8434:
;8435:
;8436:static qboolean Menu_OverActiveItem(menuDef_t *menu, float x, float y) {
line 8437
;8437:	if (menu && menu->window.flags & (WINDOW_VISIBLE | WINDOW_FORCED)) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3798
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
EQI4 $3798
line 8438
;8438:		if (Rect_ContainsWidescreenPoint(&menu->window.rect, x, y, menu->widescreen)) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4364
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $3800
line 8440
;8439:			int i;
;8440:			for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $3805
JUMPV
LABELV $3802
line 8444
;8441:				// turn off focus each item
;8442:				// menu->items[i].window.flags &= ~WINDOW_HASFOCUS;
;8443:
;8444:				if (!(menu->items[i]->window.flags & (WINDOW_VISIBLE | WINDOW_FORCED))) {
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
NEI4 $3806
line 8445
;8445:					continue;
ADDRGP4 $3803
JUMPV
LABELV $3806
line 8448
;8446:				}
;8447:
;8448:				if (menu->items[i]->window.flags & WINDOW_DECORATION) {
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $3808
line 8449
;8449:					continue;
ADDRGP4 $3803
JUMPV
LABELV $3808
line 8452
;8450:				}
;8451:
;8452:				if (Rect_ContainsWidescreenPoint(&menu->items[i]->window.rect, x, y, menu->items[i]->widescreen)) {
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $3810
line 8453
;8453:					itemDef_t *overItem = menu->items[i];
ADDRLP4 28
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ADDP4
INDIRP4
ASGNP4
line 8454
;8454:					if (overItem->type == ITEM_TYPE_TEXT && overItem->text) {
ADDRLP4 28
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
NEI4 $3812
ADDRLP4 28
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3812
line 8455
;8455:						if (Rect_ContainsWidescreenPoint(Item_CorrectedTextRect(overItem), x, y, overItem->widescreen)) {
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 Item_CorrectedTextRect
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 576
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 Rect_ContainsWidescreenPoint
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $3803
line 8456
;8456:							return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3797
JUMPV
line 8457
;8457:						} else {
line 8458
;8458:							continue;
LABELV $3812
line 8460
;8459:						}
;8460:					} else {
line 8461
;8461:						return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3797
JUMPV
LABELV $3810
line 8464
;8462:					}
;8463:				}
;8464:			}
LABELV $3803
line 8440
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3805
ADDRLP4 12
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
LTI4 $3802
line 8466
;8465:
;8466:		}
LABELV $3800
line 8467
;8467:	}
LABELV $3798
line 8468
;8468:	return qfalse;
CNSTI4 0
RETI4
LABELV $3797
endproc Menu_OverActiveItem 44 16
bss
align 4
LABELV captureY
skip 4
align 4
LABELV captureX
skip 4
export menuParseKeywordHash
align 4
LABELV menuParseKeywordHash
skip 2048
export itemParseKeywordHash
align 4
LABELV itemParseKeywordHash
skip 2048
export g_nameBind2
align 1
LABELV g_nameBind2
skip 32
export g_nameBind1
align 1
LABELV g_nameBind1
skip 32
align 4
LABELV strHandle
skip 8192
align 1
LABELV strPool
skip 2097152
align 4
LABELV outOfMemory
skip 4
align 4
LABELV allocPoint
skip 4
align 1
LABELV memoryPool
skip 2097152
export menuStack
align 4
LABELV menuStack
skip 1024
export Menus
align 4
LABELV Menus
skip 2236416
align 4
LABELV scrollInfo
skip 32
align 4
LABELV menuVars
skip 8704
import trap_PC_SourceFileAndLine
import trap_PC_ReadToken
import trap_PC_FreeSource
import trap_PC_LoadSource
import trap_PC_AddGlobalDefine
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
LABELV $3737
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 95
byte 1 82
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 40
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $3735
byte 1 102
byte 1 112
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 102
byte 1 0
align 1
LABELV $3722
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 95
byte 1 78
byte 1 101
byte 1 119
byte 1 40
byte 1 41
byte 1 32
byte 1 97
byte 1 108
byte 1 114
byte 1 101
byte 1 97
byte 1 100
byte 1 121
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 77
byte 1 69
byte 1 78
byte 1 85
byte 1 83
byte 1 32
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $3715
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $3711
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $3704
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 115
byte 1 105
byte 1 100
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 0
align 1
LABELV $3687
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 65
byte 1 109
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $3686
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 67
byte 1 121
byte 1 99
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $3685
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 67
byte 1 108
byte 1 97
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $3684
byte 1 112
byte 1 111
byte 1 112
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $3683
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 68
byte 1 101
byte 1 102
byte 1 0
align 1
LABELV $3682
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 76
byte 1 111
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $3681
byte 1 111
byte 1 117
byte 1 116
byte 1 79
byte 1 102
byte 1 66
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 115
byte 1 67
byte 1 108
byte 1 105
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $3680
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $3679
byte 1 102
byte 1 111
byte 1 99
byte 1 117
byte 1 115
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $3678
byte 1 98
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 83
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $3677
byte 1 111
byte 1 110
byte 1 69
byte 1 83
byte 1 67
byte 1 0
align 1
LABELV $3676
byte 1 111
byte 1 110
byte 1 67
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $3675
byte 1 111
byte 1 110
byte 1 79
byte 1 112
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $3674
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 115
byte 1 99
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $3673
byte 1 94
byte 1 49
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 95
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 68
byte 1 101
byte 1 102
byte 1 40
byte 1 41
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 45
byte 1 62
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 67
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 32
byte 1 62
byte 1 61
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 77
byte 1 69
byte 1 78
byte 1 85
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 83
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $3670
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 32
byte 1 85
byte 1 73
byte 1 95
byte 1 65
byte 1 108
byte 1 108
byte 1 111
byte 1 99
byte 1 40
byte 1 41
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 95
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 68
byte 1 101
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $3650
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 100
byte 1 101
byte 1 115
byte 1 99
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $3557
byte 1 109
byte 1 97
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $3538
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $3534
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $3517
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 115
byte 1 105
byte 1 100
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 0
align 1
LABELV $3504
byte 1 70
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 118
byte 1 105
byte 1 100
byte 1 101
byte 1 111
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 115
byte 1 44
byte 1 32
byte 1 114
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 100
byte 1 32
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $3495
byte 1 37
byte 1 100
byte 1 120
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $3478
byte 1 37
byte 1 115
byte 1 32
byte 1 40
byte 1 37
byte 1 115
byte 1 41
byte 1 0
align 1
LABELV $3470
byte 1 114
byte 1 95
byte 1 97
byte 1 118
byte 1 97
byte 1 105
byte 1 108
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $3469
byte 1 117
byte 1 105
byte 1 95
byte 1 118
byte 1 105
byte 1 100
byte 1 101
byte 1 111
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $3466
byte 1 69
byte 1 120
byte 1 116
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 101
byte 1 108
byte 1 100
byte 1 32
byte 1 117
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 100
byte 1 32
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
byte 1 10
byte 1 0
align 1
LABELV $3460
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 105
byte 1 110
byte 1 100
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $3459
byte 1 117
byte 1 105
byte 1 95
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $3456
byte 1 69
byte 1 120
byte 1 116
byte 1 101
byte 1 110
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 99
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 102
byte 1 97
byte 1 118
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 32
byte 1 97
byte 1 100
byte 1 100
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 101
byte 1 100
byte 1 105
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 101
byte 1 108
byte 1 100
byte 1 32
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 104
byte 1 111
byte 1 108
byte 1 100
byte 1 32
byte 1 97
byte 1 110
byte 1 32
byte 1 73
byte 1 80
byte 1 118
byte 1 54
byte 1 32
byte 1 97
byte 1 100
byte 1 100
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $3453
byte 1 117
byte 1 105
byte 1 95
byte 1 102
byte 1 97
byte 1 118
byte 1 111
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 65
byte 1 100
byte 1 100
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $3441
byte 1 101
byte 1 108
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $3423
byte 1 94
byte 1 49
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 82
byte 1 117
byte 1 110
byte 1 70
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 40
byte 1 41
byte 1 32
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $3420
byte 1 94
byte 1 49
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 82
byte 1 117
byte 1 110
byte 1 70
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 40
byte 1 41
byte 1 32
byte 1 32
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $3413
byte 1 105
byte 1 102
byte 1 0
align 1
LABELV $3403
byte 1 94
byte 1 49
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 82
byte 1 117
byte 1 110
byte 1 70
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 40
byte 1 41
byte 1 32
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $3400
byte 1 94
byte 1 49
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 82
byte 1 117
byte 1 110
byte 1 70
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 40
byte 1 41
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $3389
byte 1 37
byte 1 46
byte 1 50
byte 1 102
byte 1 58
byte 1 49
byte 1 0
align 1
LABELV $3384
byte 1 49
byte 1 54
byte 1 58
byte 1 57
byte 1 0
align 1
LABELV $3383
byte 1 49
byte 1 46
byte 1 55
byte 1 56
byte 1 58
byte 1 49
byte 1 0
align 1
LABELV $3382
byte 1 53
byte 1 58
byte 1 51
byte 1 0
align 1
LABELV $3381
byte 1 49
byte 1 46
byte 1 54
byte 1 55
byte 1 58
byte 1 49
byte 1 0
align 1
LABELV $3380
byte 1 49
byte 1 54
byte 1 58
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $3379
byte 1 49
byte 1 46
byte 1 54
byte 1 48
byte 1 58
byte 1 49
byte 1 0
align 1
LABELV $3378
byte 1 49
byte 1 52
byte 1 58
byte 1 57
byte 1 0
align 1
LABELV $3377
byte 1 49
byte 1 46
byte 1 53
byte 1 54
byte 1 58
byte 1 49
byte 1 0
align 1
LABELV $3376
byte 1 51
byte 1 58
byte 1 50
byte 1 0
align 1
LABELV $3375
byte 1 49
byte 1 46
byte 1 53
byte 1 48
byte 1 58
byte 1 49
byte 1 0
align 1
LABELV $3374
byte 1 52
byte 1 58
byte 1 51
byte 1 0
align 1
LABELV $3373
byte 1 49
byte 1 46
byte 1 51
byte 1 51
byte 1 58
byte 1 49
byte 1 0
align 1
LABELV $3372
byte 1 53
byte 1 58
byte 1 52
byte 1 0
align 1
LABELV $3371
byte 1 49
byte 1 46
byte 1 50
byte 1 53
byte 1 58
byte 1 49
byte 1 0
align 1
LABELV $3370
byte 1 56
byte 1 53
byte 1 54
byte 1 120
byte 1 52
byte 1 56
byte 1 48
byte 1 0
align 1
LABELV $3369
byte 1 50
byte 1 48
byte 1 52
byte 1 56
byte 1 120
byte 1 49
byte 1 53
byte 1 51
byte 1 54
byte 1 0
align 1
LABELV $3368
byte 1 49
byte 1 54
byte 1 48
byte 1 48
byte 1 120
byte 1 49
byte 1 50
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $3367
byte 1 49
byte 1 50
byte 1 56
byte 1 48
byte 1 120
byte 1 49
byte 1 48
byte 1 50
byte 1 52
byte 1 0
align 1
LABELV $3366
byte 1 49
byte 1 49
byte 1 53
byte 1 50
byte 1 120
byte 1 56
byte 1 54
byte 1 52
byte 1 0
align 1
LABELV $3365
byte 1 49
byte 1 48
byte 1 50
byte 1 52
byte 1 120
byte 1 55
byte 1 54
byte 1 56
byte 1 0
align 1
LABELV $3364
byte 1 57
byte 1 54
byte 1 48
byte 1 120
byte 1 55
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $3363
byte 1 56
byte 1 48
byte 1 48
byte 1 120
byte 1 54
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $3362
byte 1 54
byte 1 52
byte 1 48
byte 1 120
byte 1 52
byte 1 56
byte 1 48
byte 1 0
align 1
LABELV $3361
byte 1 53
byte 1 49
byte 1 50
byte 1 120
byte 1 51
byte 1 56
byte 1 52
byte 1 0
align 1
LABELV $3360
byte 1 52
byte 1 48
byte 1 48
byte 1 120
byte 1 51
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $3359
byte 1 51
byte 1 50
byte 1 48
byte 1 120
byte 1 50
byte 1 52
byte 1 48
byte 1 0
align 1
LABELV $3353
byte 1 119
byte 1 105
byte 1 100
byte 1 101
byte 1 115
byte 1 99
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $3352
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 118
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $3351
byte 1 114
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $3350
byte 1 112
byte 1 114
byte 1 101
byte 1 99
byte 1 105
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $3349
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $3348
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 73
byte 1 100
byte 1 0
align 1
LABELV $3347
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 67
byte 1 111
byte 1 110
byte 1 116
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $3346
byte 1 100
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 99
byte 1 108
byte 1 105
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $3345
byte 1 99
byte 1 105
byte 1 110
byte 1 101
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 99
byte 1 0
align 1
LABELV $3344
byte 1 104
byte 1 105
byte 1 100
byte 1 101
byte 1 67
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $3343
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 67
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $3342
byte 1 100
byte 1 105
byte 1 115
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 67
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $3341
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 84
byte 1 101
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $3340
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 67
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $3339
byte 1 111
byte 1 119
byte 1 110
byte 1 101
byte 1 114
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 50
byte 1 0
align 1
LABELV $3338
byte 1 111
byte 1 119
byte 1 110
byte 1 101
byte 1 114
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $3337
byte 1 97
byte 1 100
byte 1 100
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 82
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $3336
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 70
byte 1 108
byte 1 111
byte 1 97
byte 1 116
byte 1 76
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $3335
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 83
byte 1 116
byte 1 114
byte 1 76
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $3334
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 73
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $3333
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 70
byte 1 108
byte 1 111
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $3332
byte 1 102
byte 1 111
byte 1 99
byte 1 117
byte 1 115
byte 1 83
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $3331
byte 1 109
byte 1 97
byte 1 120
byte 1 80
byte 1 97
byte 1 105
byte 1 110
byte 1 116
byte 1 67
byte 1 104
byte 1 97
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $3330
byte 1 109
byte 1 97
byte 1 120
byte 1 67
byte 1 104
byte 1 97
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $3329
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $3328
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $3327
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $3326
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $3325
byte 1 109
byte 1 111
byte 1 117
byte 1 115
byte 1 101
byte 1 69
byte 1 120
byte 1 105
byte 1 116
byte 1 84
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $3324
byte 1 109
byte 1 111
byte 1 117
byte 1 115
byte 1 101
byte 1 69
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 84
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $3323
byte 1 109
byte 1 111
byte 1 117
byte 1 115
byte 1 101
byte 1 69
byte 1 120
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $3322
byte 1 109
byte 1 111
byte 1 117
byte 1 115
byte 1 101
byte 1 69
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $3321
byte 1 108
byte 1 101
byte 1 97
byte 1 118
byte 1 101
byte 1 70
byte 1 111
byte 1 99
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $3320
byte 1 111
byte 1 110
byte 1 70
byte 1 111
byte 1 99
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $3319
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 114
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $3318
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $3317
byte 1 111
byte 1 117
byte 1 116
byte 1 108
byte 1 105
byte 1 110
byte 1 101
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $3316
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $3315
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $3314
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 97
byte 1 108
byte 1 105
byte 1 103
byte 1 110
byte 1 121
byte 1 0
align 1
LABELV $3313
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 97
byte 1 108
byte 1 105
byte 1 103
byte 1 110
byte 1 120
byte 1 0
align 1
LABELV $3312
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 97
byte 1 108
byte 1 105
byte 1 103
byte 1 110
byte 1 0
align 1
LABELV $3311
byte 1 97
byte 1 108
byte 1 105
byte 1 103
byte 1 110
byte 1 0
align 1
LABELV $3310
byte 1 111
byte 1 119
byte 1 110
byte 1 101
byte 1 114
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 0
align 1
LABELV $3309
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $3308
byte 1 98
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $3307
byte 1 98
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $3306
byte 1 99
byte 1 111
byte 1 108
byte 1 117
byte 1 109
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $3305
byte 1 101
byte 1 108
byte 1 101
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $3304
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $3303
byte 1 97
byte 1 108
byte 1 116
byte 1 114
byte 1 111
byte 1 119
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $3302
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $3301
byte 1 101
byte 1 108
byte 1 101
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $3300
byte 1 101
byte 1 108
byte 1 101
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 104
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $3299
byte 1 101
byte 1 108
byte 1 101
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 119
byte 1 105
byte 1 100
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $3298
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $3297
byte 1 104
byte 1 111
byte 1 114
byte 1 105
byte 1 122
byte 1 111
byte 1 110
byte 1 116
byte 1 97
byte 1 108
byte 1 115
byte 1 99
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $3296
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 119
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $3295
byte 1 119
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $3294
byte 1 110
byte 1 111
byte 1 116
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $3293
byte 1 100
byte 1 101
byte 1 99
byte 1 111
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $3292
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $3291
byte 1 114
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $3290
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 95
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $3289
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 95
byte 1 114
byte 1 111
byte 1 116
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $3288
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 95
byte 1 102
byte 1 111
byte 1 118
byte 1 121
byte 1 0
align 1
LABELV $3287
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 95
byte 1 102
byte 1 111
byte 1 118
byte 1 120
byte 1 0
align 1
LABELV $3286
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 95
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $3285
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 95
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $3284
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $3283
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $3282
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 114
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $3281
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $3280
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $3279
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $3278
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 119
byte 1 105
byte 1 100
byte 1 101
byte 1 115
byte 1 99
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $3271
byte 1 37
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $3257
byte 1 118
byte 1 97
byte 1 108
byte 1 40
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 41
byte 1 40
byte 1 110
byte 1 117
byte 1 109
byte 1 79
byte 1 112
byte 1 115
byte 1 58
byte 1 37
byte 1 100
byte 1 41
byte 1 58
byte 1 32
byte 1 37
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $3253
byte 1 94
byte 1 51
byte 1 113
byte 1 109
byte 1 97
byte 1 116
byte 1 104
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 102
byte 1 105
byte 1 110
byte 1 97
byte 1 108
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 111
byte 1 112
byte 1 40
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 41
byte 1 58
byte 1 32
byte 1 37
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $3081
byte 1 94
byte 1 51
byte 1 113
byte 1 109
byte 1 97
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 119
byte 1 111
byte 1 32
byte 1 111
byte 1 112
byte 1 101
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 101
byte 1 97
byte 1 99
byte 1 104
byte 1 32
byte 1 111
byte 1 116
byte 1 104
byte 1 101
byte 1 114
byte 1 40
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $3061
byte 1 94
byte 1 51
byte 1 113
byte 1 109
byte 1 97
byte 1 116
byte 1 104
byte 1 32
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 37
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $3024
byte 1 94
byte 1 51
byte 1 113
byte 1 109
byte 1 97
byte 1 116
byte 1 104
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 41
byte 1 58
byte 1 32
byte 1 37
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $3010
byte 1 94
byte 1 51
byte 1 113
byte 1 109
byte 1 97
byte 1 116
byte 1 104
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 108
byte 1 97
byte 1 115
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 40
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 41
byte 1 58
byte 1 32
byte 1 37
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $3005
byte 1 94
byte 1 51
byte 1 113
byte 1 109
byte 1 97
byte 1 116
byte 1 104
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 40
byte 1 37
byte 1 100
byte 1 32
byte 1 37
byte 1 100
byte 1 41
byte 1 58
byte 1 32
byte 1 37
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $3000
byte 1 94
byte 1 51
byte 1 113
byte 1 109
byte 1 97
byte 1 116
byte 1 104
byte 1 32
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 47
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $2989
byte 1 111
byte 1 119
byte 1 110
byte 1 101
byte 1 114
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 118
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $2985
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2981
byte 1 114
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2977
byte 1 99
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $2973
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $2970
byte 1 112
byte 1 105
byte 1 0
align 1
LABELV $2967
byte 1 112
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $2964
byte 1 116
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $2961
byte 1 97
byte 1 116
byte 1 97
byte 1 110
byte 1 50
byte 1 0
align 1
LABELV $2958
byte 1 97
byte 1 116
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $2955
byte 1 97
byte 1 115
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $2952
byte 1 97
byte 1 99
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $2949
byte 1 99
byte 1 108
byte 1 105
byte 1 112
byte 1 0
align 1
LABELV $2946
byte 1 119
byte 1 97
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $2943
byte 1 99
byte 1 111
byte 1 115
byte 1 0
align 1
LABELV $2940
byte 1 115
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $2937
byte 1 102
byte 1 108
byte 1 111
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $2934
byte 1 99
byte 1 101
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $2931
byte 1 115
byte 1 113
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $2878
byte 1 113
byte 1 109
byte 1 97
byte 1 116
byte 1 104
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 58
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 32
byte 1 32
byte 1 115
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 91
byte 1 48
byte 1 93
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 32
byte 1 110
byte 1 101
byte 1 119
byte 1 76
byte 1 105
byte 1 110
byte 1 101
byte 1 58
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $2833
byte 1 81
byte 1 95
byte 1 71
byte 1 101
byte 1 116
byte 1 84
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 112
byte 1 117
byte 1 116
byte 1 83
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $2826
byte 1 94
byte 1 51
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 95
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 40
byte 1 41
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 70
byte 1 79
byte 1 78
byte 1 84
byte 1 83
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 100
byte 1 44
byte 1 32
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
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $2817
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 115
byte 1 50
byte 1 47
byte 1 37
byte 1 115
byte 1 95
byte 1 37
byte 1 105
byte 1 46
byte 1 100
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $2813
byte 1 113
byte 1 51
byte 1 103
byte 1 105
byte 1 97
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $2812
byte 1 113
byte 1 51
byte 1 98
byte 1 105
byte 1 103
byte 1 0
align 1
LABELV $2811
byte 1 113
byte 1 51
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $2810
byte 1 113
byte 1 51
byte 1 116
byte 1 105
byte 1 110
byte 1 121
byte 1 0
align 1
LABELV $2807
byte 1 113
byte 1 108
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $2802
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 115
byte 1 47
byte 1 104
byte 1 97
byte 1 110
byte 1 100
byte 1 101
byte 1 108
byte 1 103
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 99
byte 1 46
byte 1 116
byte 1 116
byte 1 102
byte 1 0
align 1
LABELV $2800
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 115
byte 1 47
byte 1 100
byte 1 114
byte 1 111
byte 1 105
byte 1 100
byte 1 115
byte 1 97
byte 1 110
byte 1 115
byte 1 109
byte 1 111
byte 1 110
byte 1 111
byte 1 46
byte 1 116
byte 1 116
byte 1 102
byte 1 0
align 1
LABELV $2798
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 115
byte 1 47
byte 1 110
byte 1 111
byte 1 116
byte 1 111
byte 1 115
byte 1 97
byte 1 110
byte 1 115
byte 1 45
byte 1 114
byte 1 101
byte 1 103
byte 1 117
byte 1 108
byte 1 97
byte 1 114
byte 1 46
byte 1 116
byte 1 116
byte 1 102
byte 1 0
align 1
LABELV $2761
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 67
byte 1 79
byte 1 76
byte 1 79
byte 1 82
byte 1 95
byte 1 82
byte 1 65
byte 1 78
byte 1 71
byte 1 69
byte 1 83
byte 1 32
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 100
byte 1 58
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 62
byte 1 61
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $2753
byte 1 94
byte 1 51
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 95
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 70
byte 1 108
byte 1 111
byte 1 97
byte 1 116
byte 1 76
byte 1 105
byte 1 115
byte 1 116
byte 1 58
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 77
byte 1 85
byte 1 76
byte 1 84
byte 1 73
byte 1 95
byte 1 67
byte 1 86
byte 1 65
byte 1 82
byte 1 83
byte 1 10
byte 1 0
align 1
LABELV $2726
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 32
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 95
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 83
byte 1 116
byte 1 114
byte 1 76
byte 1 105
byte 1 115
byte 1 116
byte 1 40
byte 1 41
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 77
byte 1 85
byte 1 76
byte 1 84
byte 1 73
byte 1 95
byte 1 67
byte 1 86
byte 1 65
byte 1 82
byte 1 83
byte 1 40
byte 1 37
byte 1 100
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $2711
byte 1 101
byte 1 110
byte 1 100
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 115
byte 1 105
byte 1 100
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 0
align 1
LABELV $2695
byte 1 94
byte 1 53
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 32
byte 1 100
byte 1 97
byte 1 116
byte 1 97
byte 1 10
byte 1 0
align 1
LABELV $2563
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 32
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 95
byte 1 99
byte 1 111
byte 1 108
byte 1 117
byte 1 109
byte 1 110
byte 1 115
byte 1 40
byte 1 41
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 62
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 76
byte 1 66
byte 1 95
byte 1 67
byte 1 79
byte 1 76
byte 1 85
byte 1 77
byte 1 78
byte 1 83
byte 1 40
byte 1 37
byte 1 100
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $2483
byte 1 94
byte 1 49
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 95
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 69
byte 1 120
byte 1 116
byte 1 40
byte 1 41
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 112
byte 1 117
byte 1 116
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $2471
byte 1 94
byte 1 49
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 95
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 69
byte 1 120
byte 1 116
byte 1 40
byte 1 41
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 39
byte 1 125
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $2468
byte 1 94
byte 1 49
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 95
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 69
byte 1 120
byte 1 116
byte 1 40
byte 1 41
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $2462
byte 1 94
byte 1 49
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 95
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 69
byte 1 120
byte 1 116
byte 1 40
byte 1 41
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 116
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $2454
byte 1 94
byte 1 49
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 95
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 69
byte 1 120
byte 1 116
byte 1 40
byte 1 41
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 118
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 32
byte 1 39
byte 1 37
byte 1 99
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $2449
byte 1 94
byte 1 49
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 95
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 69
byte 1 120
byte 1 116
byte 1 40
byte 1 41
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 116
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $2446
byte 1 94
byte 1 49
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 95
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 69
byte 1 120
byte 1 116
byte 1 40
byte 1 41
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 109
byte 1 97
byte 1 116
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 111
byte 1 32
byte 1 108
byte 1 111
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $2438
byte 1 94
byte 1 49
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 95
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 69
byte 1 120
byte 1 116
byte 1 40
byte 1 41
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $2433
byte 1 94
byte 1 49
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 95
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 69
byte 1 120
byte 1 116
byte 1 40
byte 1 41
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 112
byte 1 117
byte 1 116
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 102
byte 1 108
byte 1 111
byte 1 119
byte 1 10
byte 1 0
align 1
LABELV $2316
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 32
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 73
byte 1 110
byte 1 105
byte 1 116
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 110
byte 1 117
byte 1 108
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $2311
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 115
byte 1 95
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 66
byte 1 121
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 79
byte 1 80
byte 1 69
byte 1 78
byte 1 95
byte 1 77
byte 1 69
byte 1 78
byte 1 85
byte 1 83
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $2310
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 115
byte 1 95
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 97
byte 1 116
byte 1 101
byte 1 66
byte 1 121
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 102
byte 1 111
byte 1 99
byte 1 117
byte 1 115
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $2249
byte 1 70
byte 1 73
byte 1 88
byte 1 77
byte 1 69
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 112
byte 1 97
byte 1 105
byte 1 110
byte 1 116
byte 1 40
byte 1 41
byte 1 32
byte 1 32
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 84
byte 1 89
byte 1 80
byte 1 69
byte 1 95
byte 1 83
byte 1 76
byte 1 73
byte 1 68
byte 1 69
byte 1 82
byte 1 95
byte 1 67
byte 1 79
byte 1 76
byte 1 79
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $2139
byte 1 94
byte 1 51
byte 1 70
byte 1 73
byte 1 88
byte 1 77
byte 1 69
byte 1 32
byte 1 99
byte 1 104
byte 1 101
byte 1 99
byte 1 107
byte 1 32
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 79
byte 1 119
byte 1 110
byte 1 101
byte 1 114
byte 1 68
byte 1 114
byte 1 97
byte 1 119
byte 1 95
byte 1 80
byte 1 97
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 117
byte 1 108
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $2069
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 66
byte 1 111
byte 1 97
byte 1 114
byte 1 100
byte 1 70
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 76
byte 1 105
byte 1 110
byte 1 101
byte 1 72
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 68
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $2068
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 66
byte 1 111
byte 1 97
byte 1 114
byte 1 100
byte 1 70
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 76
byte 1 105
byte 1 110
byte 1 101
byte 1 72
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $2057
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 66
byte 1 111
byte 1 97
byte 1 114
byte 1 100
byte 1 70
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 76
byte 1 105
byte 1 110
byte 1 101
byte 1 72
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 68
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $2056
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 66
byte 1 111
byte 1 97
byte 1 114
byte 1 100
byte 1 70
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 76
byte 1 105
byte 1 110
byte 1 101
byte 1 72
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $1929
byte 1 70
byte 1 73
byte 1 88
byte 1 77
byte 1 69
byte 1 0
align 1
LABELV $1904
byte 1 94
byte 1 49
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 83
byte 1 108
byte 1 105
byte 1 100
byte 1 101
byte 1 114
byte 1 95
byte 1 80
byte 1 97
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 45
byte 1 62
byte 1 112
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $1901
byte 1 94
byte 1 49
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 83
byte 1 108
byte 1 105
byte 1 100
byte 1 101
byte 1 114
byte 1 95
byte 1 80
byte 1 97
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $1897
byte 1 63
byte 1 63
byte 1 63
byte 1 0
align 1
LABELV $1896
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 0
align 1
LABELV $1866
byte 1 105
byte 1 110
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $1833
byte 1 99
byte 1 108
byte 1 95
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 108
byte 1 111
byte 1 111
byte 1 107
byte 1 0
align 1
LABELV $1832
byte 1 109
byte 1 95
byte 1 102
byte 1 105
byte 1 108
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1831
byte 1 106
byte 1 111
byte 1 121
byte 1 95
byte 1 116
byte 1 104
byte 1 114
byte 1 101
byte 1 115
byte 1 104
byte 1 111
byte 1 108
byte 1 100
byte 1 0
align 1
LABELV $1830
byte 1 105
byte 1 110
byte 1 95
byte 1 106
byte 1 111
byte 1 121
byte 1 115
byte 1 116
byte 1 105
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $1829
byte 1 115
byte 1 101
byte 1 110
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $1828
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $1827
byte 1 109
byte 1 95
byte 1 112
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $1826
byte 1 99
byte 1 108
byte 1 95
byte 1 114
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $1825
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 52
byte 1 0
align 1
LABELV $1824
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 51
byte 1 0
align 1
LABELV $1823
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 50
byte 1 0
align 1
LABELV $1822
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $1821
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 68
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $1820
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 85
byte 1 112
byte 1 0
align 1
LABELV $1819
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 71
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $1818
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 73
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $1817
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 84
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $1816
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 80
byte 1 114
byte 1 97
byte 1 105
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $1815
byte 1 116
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 75
byte 1 105
byte 1 108
byte 1 108
byte 1 73
byte 1 110
byte 1 115
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $1814
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 83
byte 1 117
byte 1 105
byte 1 99
byte 1 105
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $1813
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 79
byte 1 119
byte 1 110
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $1812
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 69
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $1811
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 82
byte 1 101
byte 1 116
byte 1 114
byte 1 105
byte 1 101
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $1810
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 70
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $1809
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 67
byte 1 97
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $1808
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 80
byte 1 97
byte 1 116
byte 1 114
byte 1 111
byte 1 108
byte 1 0
align 1
LABELV $1807
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 68
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $1806
byte 1 116
byte 1 97
byte 1 115
byte 1 107
byte 1 79
byte 1 102
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $1805
byte 1 100
byte 1 101
byte 1 110
byte 1 121
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1804
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 114
byte 1 109
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1803
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 79
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1802
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 77
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1801
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 77
byte 1 101
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1800
byte 1 43
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 52
byte 1 0
align 1
LABELV $1799
byte 1 43
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 51
byte 1 0
align 1
LABELV $1798
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $1797
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 112
byte 1 114
byte 1 101
byte 1 118
byte 1 0
align 1
LABELV $1796
byte 1 43
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $1795
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 49
byte 1 51
byte 1 0
align 1
LABELV $1794
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 49
byte 1 50
byte 1 0
align 1
LABELV $1793
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 49
byte 1 49
byte 1 0
align 1
LABELV $1792
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 49
byte 1 48
byte 1 0
align 1
LABELV $1791
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 57
byte 1 0
align 1
LABELV $1790
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 56
byte 1 0
align 1
LABELV $1789
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 55
byte 1 0
align 1
LABELV $1788
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 54
byte 1 0
align 1
LABELV $1787
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 53
byte 1 0
align 1
LABELV $1786
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 52
byte 1 0
align 1
LABELV $1785
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 51
byte 1 0
align 1
LABELV $1784
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 50
byte 1 0
align 1
LABELV $1783
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 32
byte 1 49
byte 1 0
align 1
LABELV $1782
byte 1 43
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $1781
byte 1 99
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 0
align 1
LABELV $1780
byte 1 43
byte 1 109
byte 1 108
byte 1 111
byte 1 111
byte 1 107
byte 1 0
align 1
LABELV $1779
byte 1 43
byte 1 108
byte 1 111
byte 1 111
byte 1 107
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $1778
byte 1 43
byte 1 108
byte 1 111
byte 1 111
byte 1 107
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $1777
byte 1 43
byte 1 115
byte 1 116
byte 1 114
byte 1 97
byte 1 102
byte 1 101
byte 1 0
align 1
LABELV $1776
byte 1 43
byte 1 114
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $1775
byte 1 43
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 0
align 1
LABELV $1774
byte 1 43
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $1773
byte 1 43
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $1772
byte 1 43
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $1771
byte 1 43
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 0
align 1
LABELV $1770
byte 1 43
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $1769
byte 1 43
byte 1 102
byte 1 111
byte 1 114
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $1768
byte 1 43
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1767
byte 1 43
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 50
byte 1 0
align 1
LABELV $1766
byte 1 43
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $1747
byte 1 78
byte 1 111
byte 1 0
align 1
LABELV $1746
byte 1 89
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $1471
byte 1 70
byte 1 73
byte 1 88
byte 1 77
byte 1 69
byte 1 32
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 72
byte 1 97
byte 1 110
byte 1 100
byte 1 108
byte 1 101
byte 1 75
byte 1 101
byte 1 121
byte 1 40
byte 1 41
byte 1 32
byte 1 32
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 84
byte 1 89
byte 1 80
byte 1 69
byte 1 95
byte 1 83
byte 1 76
byte 1 73
byte 1 68
byte 1 69
byte 1 82
byte 1 95
byte 1 67
byte 1 79
byte 1 76
byte 1 79
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $1413
byte 1 70
byte 1 73
byte 1 88
byte 1 77
byte 1 69
byte 1 32
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 73
byte 1 84
byte 1 69
byte 1 77
byte 1 95
byte 1 84
byte 1 89
byte 1 80
byte 1 69
byte 1 95
byte 1 83
byte 1 76
byte 1 73
byte 1 68
byte 1 69
byte 1 82
byte 1 95
byte 1 67
byte 1 79
byte 1 76
byte 1 79
byte 1 82
byte 1 10
byte 1 0
align 1
LABELV $1260
byte 1 37
byte 1 102
byte 1 0
align 1
LABELV $1255
byte 1 114
byte 1 95
byte 1 99
byte 1 117
byte 1 115
byte 1 116
byte 1 111
byte 1 109
byte 1 104
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $1254
byte 1 114
byte 1 95
byte 1 99
byte 1 117
byte 1 115
byte 1 116
byte 1 111
byte 1 109
byte 1 119
byte 1 105
byte 1 100
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $1253
byte 1 45
byte 1 49
byte 1 0
align 1
LABELV $1249
byte 1 114
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $1188
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $962
byte 1 94
byte 1 49
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 76
byte 1 105
byte 1 115
byte 1 116
byte 1 66
byte 1 111
byte 1 120
byte 1 95
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 76
byte 1 66
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $953
byte 1 94
byte 1 49
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 83
byte 1 108
byte 1 105
byte 1 100
byte 1 101
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 83
byte 1 108
byte 1 105
byte 1 100
byte 1 101
byte 1 32
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $837
byte 1 111
byte 1 114
byte 1 98
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $836
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 108
byte 1 111
byte 1 111
byte 1 112
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $835
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $834
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $833
byte 1 115
byte 1 101
byte 1 116
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $832
byte 1 115
byte 1 101
byte 1 116
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $831
byte 1 116
byte 1 114
byte 1 97
byte 1 110
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $830
byte 1 115
byte 1 101
byte 1 116
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $829
byte 1 115
byte 1 101
byte 1 116
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $828
byte 1 115
byte 1 101
byte 1 116
byte 1 102
byte 1 111
byte 1 99
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $827
byte 1 115
byte 1 101
byte 1 116
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $826
byte 1 115
byte 1 101
byte 1 116
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $825
byte 1 115
byte 1 101
byte 1 116
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $824
byte 1 115
byte 1 101
byte 1 116
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $823
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $822
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 97
byte 1 108
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $821
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $820
byte 1 115
byte 1 101
byte 1 116
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $819
byte 1 104
byte 1 105
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $818
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $817
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $816
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $807
byte 1 37
byte 1 115
byte 1 32
byte 1 59
byte 1 32
byte 1 0
align 1
LABELV $801
byte 1 94
byte 1 49
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 95
byte 1 83
byte 1 101
byte 1 116
byte 1 86
byte 1 97
byte 1 114
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 109
byte 1 97
byte 1 116
byte 1 104
byte 1 32
byte 1 98
byte 1 108
byte 1 111
byte 1 99
byte 1 107
byte 1 10
byte 1 0
align 1
LABELV $798
byte 1 94
byte 1 49
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 95
byte 1 83
byte 1 101
byte 1 116
byte 1 86
byte 1 97
byte 1 114
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 118
byte 1 97
byte 1 114
byte 1 105
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $791
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
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
LABELV $787
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $624
byte 1 98
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $621
byte 1 102
byte 1 111
byte 1 114
byte 1 101
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $618
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $566
byte 1 94
byte 1 49
byte 1 82
byte 1 101
byte 1 99
byte 1 116
byte 1 95
byte 1 67
byte 1 111
byte 1 110
byte 1 116
byte 1 97
byte 1 105
byte 1 110
byte 1 115
byte 1 87
byte 1 105
byte 1 100
byte 1 101
byte 1 115
byte 1 99
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 80
byte 1 111
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 99
byte 1 116
byte 1 73
byte 1 110
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $417
byte 1 94
byte 1 49
byte 1 80
byte 1 67
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 104
byte 1 101
byte 1 115
byte 1 105
byte 1 115
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $412
byte 1 94
byte 1 49
byte 1 80
byte 1 67
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 104
byte 1 101
byte 1 115
byte 1 105
byte 1 115
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 98
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 67
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 32
byte 1 60
byte 1 32
byte 1 48
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $406
byte 1 94
byte 1 49
byte 1 80
byte 1 67
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 104
byte 1 101
byte 1 115
byte 1 105
byte 1 115
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 111
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $399
byte 1 94
byte 1 49
byte 1 80
byte 1 67
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 104
byte 1 101
byte 1 115
byte 1 105
byte 1 115
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 33
byte 1 61
byte 1 32
byte 1 39
byte 1 40
byte 1 39
byte 1 32
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $395
byte 1 94
byte 1 49
byte 1 80
byte 1 67
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 104
byte 1 101
byte 1 115
byte 1 105
byte 1 115
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $385
byte 1 94
byte 1 49
byte 1 80
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 104
byte 1 101
byte 1 115
byte 1 105
byte 1 115
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $380
byte 1 94
byte 1 49
byte 1 80
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 104
byte 1 101
byte 1 115
byte 1 105
byte 1 115
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 98
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 67
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 32
byte 1 60
byte 1 32
byte 1 48
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $377
byte 1 41
byte 1 0
align 1
LABELV $374
byte 1 94
byte 1 49
byte 1 80
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 104
byte 1 101
byte 1 115
byte 1 105
byte 1 115
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 111
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $368
byte 1 94
byte 1 49
byte 1 80
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 104
byte 1 101
byte 1 115
byte 1 105
byte 1 115
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 33
byte 1 61
byte 1 32
byte 1 39
byte 1 40
byte 1 39
byte 1 32
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $367
byte 1 40
byte 1 0
align 1
LABELV $364
byte 1 94
byte 1 49
byte 1 80
byte 1 97
byte 1 114
byte 1 101
byte 1 110
byte 1 116
byte 1 104
byte 1 101
byte 1 115
byte 1 105
byte 1 115
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $350
byte 1 94
byte 1 49
byte 1 80
byte 1 67
byte 1 95
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $345
byte 1 94
byte 1 49
byte 1 80
byte 1 67
byte 1 95
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 98
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 67
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 32
byte 1 60
byte 1 32
byte 1 48
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $339
byte 1 94
byte 1 49
byte 1 80
byte 1 67
byte 1 95
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 111
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $331
byte 1 94
byte 1 49
byte 1 80
byte 1 67
byte 1 95
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 33
byte 1 61
byte 1 32
byte 1 39
byte 1 123
byte 1 39
byte 1 32
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $325
byte 1 94
byte 1 49
byte 1 80
byte 1 67
byte 1 95
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $316
byte 1 32
byte 1 0
align 1
LABELV $315
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $310
byte 1 94
byte 1 49
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $305
byte 1 94
byte 1 49
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 98
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 67
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 32
byte 1 60
byte 1 32
byte 1 48
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
byte 1 10
byte 1 0
align 1
LABELV $302
byte 1 125
byte 1 0
align 1
LABELV $299
byte 1 112
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $298
byte 1 94
byte 1 49
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $295
byte 1 94
byte 1 49
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 105
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 111
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $289
byte 1 94
byte 1 49
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 33
byte 1 61
byte 1 32
byte 1 39
byte 1 123
byte 1 39
byte 1 32
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $286
byte 1 123
byte 1 0
align 1
LABELV $283
byte 1 94
byte 1 49
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $277
byte 1 94
byte 1 49
byte 1 80
byte 1 67
byte 1 95
byte 1 83
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $268
byte 1 94
byte 1 49
byte 1 83
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 10
byte 1 0
align 1
LABELV $262
byte 1 94
byte 1 49
byte 1 80
byte 1 67
byte 1 95
byte 1 82
byte 1 101
byte 1 99
byte 1 116
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $250
byte 1 94
byte 1 49
byte 1 82
byte 1 101
byte 1 99
byte 1 116
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 112
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 32
byte 1 114
byte 1 101
byte 1 99
byte 1 116
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $239
byte 1 94
byte 1 49
byte 1 80
byte 1 67
byte 1 95
byte 1 73
byte 1 110
byte 1 116
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 50
byte 1 10
byte 1 0
align 1
LABELV $233
byte 1 94
byte 1 49
byte 1 80
byte 1 67
byte 1 95
byte 1 73
byte 1 110
byte 1 116
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 49
byte 1 10
byte 1 0
align 1
LABELV $228
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 32
byte 1 80
byte 1 67
byte 1 95
byte 1 73
byte 1 110
byte 1 116
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 32
byte 1 105
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 110
byte 1 117
byte 1 108
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $224
byte 1 94
byte 1 49
byte 1 73
byte 1 110
byte 1 116
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $223
byte 1 94
byte 1 49
byte 1 73
byte 1 110
byte 1 116
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 103
byte 1 101
byte 1 114
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 58
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $212
byte 1 94
byte 1 49
byte 1 80
byte 1 67
byte 1 95
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $202
byte 1 94
byte 1 49
byte 1 67
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $193
byte 1 94
byte 1 49
byte 1 80
byte 1 67
byte 1 95
byte 1 70
byte 1 108
byte 1 111
byte 1 97
byte 1 116
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 50
byte 1 10
byte 1 0
align 1
LABELV $187
byte 1 94
byte 1 49
byte 1 80
byte 1 67
byte 1 95
byte 1 70
byte 1 108
byte 1 111
byte 1 97
byte 1 116
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 49
byte 1 10
byte 1 0
align 1
LABELV $181
byte 1 94
byte 1 49
byte 1 70
byte 1 108
byte 1 111
byte 1 97
byte 1 116
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 103
byte 1 101
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 10
byte 1 0
align 1
LABELV $180
byte 1 94
byte 1 49
byte 1 70
byte 1 108
byte 1 111
byte 1 97
byte 1 116
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 40
byte 1 41
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
byte 1 32
byte 1 102
byte 1 108
byte 1 111
byte 1 97
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 58
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $158
byte 1 94
byte 1 51
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 86
byte 1 97
byte 1 114
byte 1 95
byte 1 71
byte 1 101
byte 1 116
byte 1 40
byte 1 41
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 115
byte 1 117
byte 1 99
byte 1 104
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 118
byte 1 97
byte 1 114
byte 1 105
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $150
byte 1 94
byte 1 51
byte 1 77
byte 1 101
byte 1 110
byte 1 117
byte 1 83
byte 1 101
byte 1 116
byte 1 86
byte 1 97
byte 1 114
byte 1 40
byte 1 41
byte 1 32
byte 1 99
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 115
byte 1 101
byte 1 116
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 44
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 77
byte 1 69
byte 1 78
byte 1 85
byte 1 95
byte 1 86
byte 1 65
byte 1 82
byte 1 83
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 41
byte 1 32
byte 1 114
byte 1 101
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $149
byte 1 94
byte 1 49
byte 1 69
byte 1 82
byte 1 82
byte 1 79
byte 1 82
byte 1 58
byte 1 32
byte 1 116
byte 1 114
byte 1 117
byte 1 110
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 44
byte 1 32
byte 1 109
byte 1 97
byte 1 120
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 118
byte 1 97
byte 1 114
byte 1 32
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 100
byte 1 58
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 10
byte 1 0
align 1
LABELV $136
byte 1 94
byte 1 49
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
LABELV $132
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
LABELV $121
byte 1 77
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 32
byte 1 80
byte 1 111
byte 1 111
byte 1 108
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 46
byte 1 49
byte 1 102
byte 1 37
byte 1 37
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 44
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 98
byte 1 121
byte 1 116
byte 1 101
byte 1 115
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $120
byte 1 83
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 80
byte 1 111
byte 1 111
byte 1 108
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 37
byte 1 46
byte 1 49
byte 1 102
byte 1 37
byte 1 37
byte 1 32
byte 1 102
byte 1 117
byte 1 108
byte 1 108
byte 1 44
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 98
byte 1 121
byte 1 116
byte 1 101
byte 1 115
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $119
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
LABELV $118
byte 1 77
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 47
byte 1 83
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 80
byte 1 111
byte 1 111
byte 1 108
byte 1 32
byte 1 73
byte 1 110
byte 1 102
byte 1 111
byte 1 10
byte 1 0
align 1
LABELV $116
byte 1 94
byte 1 49
byte 1 83
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 95
byte 1 65
byte 1 108
byte 1 108
byte 1 111
byte 1 99
byte 1 40
byte 1 41
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 10
byte 1 0
align 1
LABELV $97
byte 1 94
byte 1 49
byte 1 83
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 95
byte 1 65
byte 1 108
byte 1 108
byte 1 111
byte 1 99
byte 1 40
byte 1 41
byte 1 32
byte 1 112
byte 1 32
byte 1 61
byte 1 61
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 10
byte 1 0
align 1
LABELV $94
byte 1 0
align 1
LABELV $85
byte 1 85
byte 1 73
byte 1 95
byte 1 65
byte 1 108
byte 1 108
byte 1 111
byte 1 99
byte 1 58
byte 1 32
byte 1 70
byte 1 97
byte 1 105
byte 1 108
byte 1 117
byte 1 114
byte 1 101
byte 1 46
byte 1 32
byte 1 79
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 109
byte 1 101
byte 1 109
byte 1 111
byte 1 114
byte 1 121
byte 1 33
byte 1 32
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 43
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 62
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $79
byte 1 94
byte 1 51
byte 1 81
byte 1 95
byte 1 71
byte 1 101
byte 1 116
byte 1 67
byte 1 112
byte 1 70
byte 1 114
byte 1 111
byte 1 109
byte 1 85
byte 1 116
byte 1 102
byte 1 56
byte 1 32
byte 1 32
byte 1 105
byte 1 110
byte 1 118
byte 1 97
byte 1 108
byte 1 105
byte 1 100
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
byte 1 98
byte 1 121
byte 1 116
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
byte 1 85
byte 1 84
byte 1 70
byte 1 45
byte 1 56
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $78
byte 1 94
byte 1 51
byte 1 81
byte 1 95
byte 1 71
byte 1 101
byte 1 116
byte 1 67
byte 1 112
byte 1 70
byte 1 114
byte 1 111
byte 1 109
byte 1 85
byte 1 116
byte 1 102
byte 1 56
byte 1 32
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 114
byte 1 32
byte 1 98
byte 1 121
byte 1 116
byte 1 101
byte 1 32
byte 1 85
byte 1 84
byte 1 70
byte 1 45
byte 1 56
byte 1 32
byte 1 115
byte 1 101
byte 1 113
byte 1 117
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 44
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $73
byte 1 94
byte 1 51
byte 1 81
byte 1 95
byte 1 71
byte 1 101
byte 1 116
byte 1 67
byte 1 112
byte 1 70
byte 1 114
byte 1 111
byte 1 109
byte 1 85
byte 1 116
byte 1 102
byte 1 56
byte 1 32
byte 1 32
byte 1 116
byte 1 104
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 98
byte 1 121
byte 1 116
byte 1 101
byte 1 32
byte 1 85
byte 1 84
byte 1 70
byte 1 45
byte 1 56
byte 1 32
byte 1 115
byte 1 101
byte 1 113
byte 1 117
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 44
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $68
byte 1 94
byte 1 51
byte 1 81
byte 1 95
byte 1 71
byte 1 101
byte 1 116
byte 1 67
byte 1 112
byte 1 70
byte 1 114
byte 1 111
byte 1 109
byte 1 85
byte 1 116
byte 1 102
byte 1 56
byte 1 32
byte 1 116
byte 1 119
byte 1 111
byte 1 32
byte 1 98
byte 1 121
byte 1 116
byte 1 101
byte 1 32
byte 1 85
byte 1 84
byte 1 70
byte 1 45
byte 1 56
byte 1 32
byte 1 115
byte 1 101
byte 1 113
byte 1 117
byte 1 101
byte 1 110
byte 1 99
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 44
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0

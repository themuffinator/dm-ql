data
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
export UI_Alloc
code
proc UI_Alloc 8 4
file "..\..\..\..\code\ui\ui_shared.c"
line 71
;1:// 
;2:// string allocation/managment
;3:
;4:#include "../ui/ui_shared.h"
;5:
;6:#define SCROLL_TIME_START					500
;7:#define SCROLL_TIME_ADJUST					150
;8:#define SCROLL_TIME_ADJUSTOFFSET			40
;9:#define SCROLL_TIME_FLOOR					20
;10:
;11:typedef struct scrollInfo_s {
;12:	int nextScrollTime;
;13:	int nextAdjustTime;
;14:	int adjustValue;
;15:	int scrollKey;
;16:	float xStart;
;17:	float yStart;
;18:	itemDef_t *item;
;19:	qboolean scrollDir;
;20:} scrollInfo_t;
;21:
;22:static scrollInfo_t scrollInfo;
;23:
;24:static void (*captureFunc) (void *p) = NULL;
;25:static void *captureData = NULL;
;26:static itemDef_t *itemCapture = NULL;   // item that has the mouse captured ( if any )
;27:
;28:displayContextDef_t *DC = NULL;
;29:
;30:static qboolean g_waitingForKey = qfalse;
;31:static qboolean g_editingField = qfalse;
;32:
;33:static itemDef_t *g_bindItem = NULL;
;34:static itemDef_t *g_editItem = NULL;
;35:
;36:menuDef_t Menus[MAX_MENUS];      // defined menus
;37:int menuCount = 0;               // how many
;38:
;39:menuDef_t *menuStack[MAX_OPEN_MENUS];
;40:int openMenuCount = 0;
;41:
;42:static qboolean debugMode = qfalse;
;43:
;44:#define DOUBLE_CLICK_DELAY 300
;45:static int lastListBoxClickTime = 0;
;46:
;47:void Item_RunScript(itemDef_t *item, const char *s);
;48:void Item_SetupKeywordHash(void);
;49:void Menu_SetupKeywordHash(void);
;50:int BindingIDFromName(const char *name);
;51:qboolean Item_Bind_HandleKey(itemDef_t *item, int key, qboolean down);
;52:itemDef_t *Menu_SetPrevCursorItem(menuDef_t *menu);
;53:itemDef_t *Menu_SetNextCursorItem(menuDef_t *menu);
;54:static qboolean Menu_OverActiveItem(menuDef_t *menu, float x, float y);
;55:
;56:#ifdef CGAME
;57:#define MEM_POOL_SIZE  128 * 1024
;58:#else
;59:#define MEM_POOL_SIZE  1024 * 1024
;60:#endif
;61:
;62:static char		memoryPool[MEM_POOL_SIZE];
;63:static int		allocPoint, outOfMemory;
;64:
;65:
;66:/*
;67:===============
;68:UI_Alloc
;69:===============
;70:*/
;71:void *UI_Alloc(int size) {
line 74
;72:	char *p;
;73:
;74:	if (allocPoint + size > MEM_POOL_SIZE) {
ADDRGP4 allocPoint
INDIRI4
ADDRFP4 0
INDIRI4
ADDI4
CNSTI4 1048576
LEI4 $41
line 75
;75:		outOfMemory = qtrue;
ADDRGP4 outOfMemory
CNSTI4 1
ASGNI4
line 76
;76:		if (DC->Print) {
ADDRGP4 DC
INDIRP4
CNSTI4 156
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $43
line 77
;77:			DC->Print("UI_Alloc: Failure. Out of memory!\n");
ADDRGP4 $45
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 156
ADDP4
INDIRP4
CALLV
pop
line 78
;78:		}
LABELV $43
line 80
;79:		//DC->trap_Print(S_COLOR_YELLOW"WARNING: UI Out of Memory!\n");
;80:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $40
JUMPV
LABELV $41
line 83
;81:	}
;82:
;83:	p = &memoryPool[allocPoint];
ADDRLP4 0
ADDRGP4 allocPoint
INDIRI4
ADDRGP4 memoryPool
ADDP4
ASGNP4
line 85
;84:
;85:	allocPoint += (size + 15) & ~15;
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
line 87
;86:
;87:	return p;
ADDRLP4 0
INDIRP4
RETP4
LABELV $40
endproc UI_Alloc 8 4
export UI_InitMemory
proc UI_InitMemory 0 0
line 95
;88:}
;89:
;90:/*
;91:===============
;92:UI_InitMemory
;93:===============
;94:*/
;95:void UI_InitMemory(void) {
line 96
;96:	allocPoint = 0;
ADDRGP4 allocPoint
CNSTI4 0
ASGNI4
line 97
;97:	outOfMemory = qfalse;
ADDRGP4 outOfMemory
CNSTI4 0
ASGNI4
line 98
;98:}
LABELV $46
endproc UI_InitMemory 0 0
export UI_OutOfMemory
proc UI_OutOfMemory 0 0
line 100
;99:
;100:qboolean UI_OutOfMemory() {
line 101
;101:	return outOfMemory;
ADDRGP4 outOfMemory
INDIRI4
RETI4
LABELV $47
endproc UI_OutOfMemory 0 0
proc hashForString 16 4
line 114
;102:}
;103:
;104:
;105:
;106:
;107:
;108:#define HASH_TABLE_SIZE 2048
;109:/*
;110:================
;111:return a hash value for the string
;112:================
;113:*/
;114:static long hashForString(const char *str) {
line 119
;115:	int		i;
;116:	long	hash;
;117:	char	letter;
;118:
;119:	hash = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 120
;120:	i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $50
JUMPV
LABELV $49
line 121
;121:	while (str[i] != '\0') {
line 122
;122:		letter = tolower(str[i]);
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
line 123
;123:		hash += (long)(letter) * (i + 119);
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI1
CVII4 1
ADDRLP4 0
INDIRI4
CNSTI4 119
ADDI4
MULI4
ADDI4
ASGNI4
line 124
;124:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 125
;125:	}
LABELV $50
line 121
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $49
line 126
;126:	hash &= (HASH_TABLE_SIZE - 1);
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 2047
BANDI4
ASGNI4
line 127
;127:	return hash;
ADDRLP4 8
INDIRI4
RETI4
LABELV $48
endproc hashForString 16 4
data
align 4
LABELV strPoolIndex
byte 4 0
align 4
LABELV strHandleCount
byte 4 0
align 4
LABELV $53
address $54
export String_Alloc
code
proc String_Alloc 40 8
line 142
;128:}
;129:
;130:typedef struct stringDef_s {
;131:	struct stringDef_s *next;
;132:	const char *str;
;133:} stringDef_t;
;134:
;135:static int strPoolIndex = 0;
;136:static char strPool[STRING_POOL_SIZE];
;137:
;138:static int strHandleCount = 0;
;139:static stringDef_t *strHandle[HASH_TABLE_SIZE];
;140:
;141:
;142:const char *String_Alloc(const char *p) {
line 148
;143:	int len;
;144:	long hash;
;145:	stringDef_t *str, *last;
;146:	static const char *staticNULL = "";
;147:
;148:	if (p == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $55
line 149
;149:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $52
JUMPV
LABELV $55
line 152
;150:	}
;151:
;152:	if (*p == 0) {
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $57
line 153
;153:		return staticNULL;
ADDRGP4 $53
INDIRP4
RETP4
ADDRGP4 $52
JUMPV
LABELV $57
line 156
;154:	}
;155:
;156:	hash = hashForString(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 hashForString
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
ASGNI4
line 158
;157:
;158:	str = strHandle[hash];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 strHandle
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $60
JUMPV
LABELV $59
line 159
;159:	while (str) {
line 160
;160:		if (strcmp(p, str->str) == 0) {
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
NEI4 $62
line 161
;161:			return str->str;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
RETP4
ADDRGP4 $52
JUMPV
LABELV $62
line 163
;162:		}
;163:		str = str->next;
ADDRLP4 0
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 164
;164:	}
LABELV $60
line 159
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $59
line 166
;165:
;166:	len = strlen(p);
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
line 167
;167:	if (len + strPoolIndex + 1 < STRING_POOL_SIZE) {
ADDRLP4 12
INDIRI4
ADDRGP4 strPoolIndex
INDIRI4
ADDI4
CNSTI4 1
ADDI4
CNSTI4 393216
GEI4 $64
line 168
;168:		int ph = strPoolIndex;
ADDRLP4 24
ADDRGP4 strPoolIndex
INDIRI4
ASGNI4
line 169
;169:		strcpy(&strPool[strPoolIndex], p);
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
line 170
;170:		strPoolIndex += len + 1;
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
line 172
;171:
;172:		str = strHandle[hash];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 strHandle
ADDP4
INDIRP4
ASGNP4
line 173
;173:		last = str;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $67
JUMPV
LABELV $66
line 174
;174:		while (str && str->next) {
line 175
;175:			last = str;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 176
;176:			str = str->next;
ADDRLP4 0
ADDRLP4 0
INDIRP4
INDIRP4
ASGNP4
line 177
;177:		}
LABELV $67
line 174
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $69
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $66
LABELV $69
line 179
;178:
;179:		str = UI_Alloc(sizeof(stringDef_t));
CNSTI4 8
ARGI4
ADDRLP4 36
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
line 180
;180:		str->next = NULL;
ADDRLP4 0
INDIRP4
CNSTP4 0
ASGNP4
line 181
;181:		str->str = &strPool[ph];
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 24
INDIRI4
ADDRGP4 strPool
ADDP4
ASGNP4
line 182
;182:		if (last) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $70
line 183
;183:			last->next = str;
ADDRLP4 4
INDIRP4
ADDRLP4 0
INDIRP4
ASGNP4
line 184
;184:		} else {
ADDRGP4 $71
JUMPV
LABELV $70
line 185
;185:			strHandle[hash] = str;
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 strHandle
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 186
;186:		}
LABELV $71
line 187
;187:		return &strPool[ph];
ADDRLP4 24
INDIRI4
ADDRGP4 strPool
ADDP4
RETP4
ADDRGP4 $52
JUMPV
LABELV $64
line 189
;188:	}
;189:	return NULL;
CNSTP4 0
RETP4
LABELV $52
endproc String_Alloc 40 8
export String_Report
proc String_Report 4 16
line 192
;190:}
;191:
;192:void String_Report() {
line 194
;193:	float f;
;194:	Com_Printf("Memory/String Pool Info\n");
ADDRGP4 $73
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 195
;195:	Com_Printf("----------------\n");
ADDRGP4 $74
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 196
;196:	f = strPoolIndex;
ADDRLP4 0
ADDRGP4 strPoolIndex
INDIRI4
CVIF4 4
ASGNF4
line 197
;197:	f /= STRING_POOL_SIZE;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 908765867
MULF4
ASGNF4
line 198
;198:	f *= 100;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1120403456
MULF4
ASGNF4
line 199
;199:	Com_Printf("String Pool is %.1f%% full, %i bytes out of %i used.\n", f, strPoolIndex, STRING_POOL_SIZE);
ADDRGP4 $75
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 strPoolIndex
INDIRI4
ARGI4
CNSTI4 393216
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 200
;200:	f = allocPoint;
ADDRLP4 0
ADDRGP4 allocPoint
INDIRI4
CVIF4 4
ASGNF4
line 201
;201:	f /= MEM_POOL_SIZE;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 897581056
MULF4
ASGNF4
line 202
;202:	f *= 100;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1120403456
MULF4
ASGNF4
line 203
;203:	Com_Printf("Memory Pool is %.1f%% full, %i bytes out of %i used.\n", f, allocPoint, MEM_POOL_SIZE);
ADDRGP4 $76
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 allocPoint
INDIRI4
ARGI4
CNSTI4 1048576
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 204
;204:}
LABELV $72
endproc String_Report 4 16
export String_Init
proc String_Init 8 0
line 211
;205:
;206:/*
;207:=================
;208:String_Init
;209:=================
;210:*/
;211:void String_Init() {
line 213
;212:	int i;
;213:	for (i = 0; i < HASH_TABLE_SIZE; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $78
line 214
;214:		strHandle[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 strHandle
ADDP4
CNSTP4 0
ASGNP4
line 215
;215:	}
LABELV $79
line 213
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2048
LTI4 $78
line 216
;216:	strHandleCount = 0;
ADDRGP4 strHandleCount
CNSTI4 0
ASGNI4
line 217
;217:	strPoolIndex = 0;
ADDRGP4 strPoolIndex
CNSTI4 0
ASGNI4
line 218
;218:	menuCount = 0;
ADDRGP4 menuCount
CNSTI4 0
ASGNI4
line 219
;219:	openMenuCount = 0;
ADDRGP4 openMenuCount
CNSTI4 0
ASGNI4
line 220
;220:	UI_InitMemory();
ADDRGP4 UI_InitMemory
CALLV
pop
line 221
;221:	Item_SetupKeywordHash();
ADDRGP4 Item_SetupKeywordHash
CALLV
pop
line 222
;222:	Menu_SetupKeywordHash();
ADDRGP4 Menu_SetupKeywordHash
CALLV
pop
line 223
;223:	if (DC && DC->getBindingBuf) {
ADDRLP4 4
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $82
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $82
line 224
;224:		Controls_GetConfig();
ADDRGP4 Controls_GetConfig
CALLV
pop
line 225
;225:	}
LABELV $82
line 226
;226:}
LABELV $77
endproc String_Init 8 0
bss
align 1
LABELV $85
skip 4096
export PC_SourceWarning
code
proc PC_SourceWarning 136 16
line 233
;227:
;228:/*
;229:=================
;230:PC_SourceWarning
;231:=================
;232:*/
;233:void PC_SourceWarning(int handle, char *format, ...) {
line 239
;234:	int line;
;235:	char filename[128];
;236:	va_list argptr;
;237:	static char string[4096];
;238:
;239:	va_start(argptr, format);
ADDRLP4 132
ADDRFP4 4+4
ASGNP4
line 240
;240:	ED_vsprintf(string, format, argptr);
ADDRGP4 $85
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
line 241
;241:	va_end(argptr);
ADDRLP4 132
CNSTP4 0
ASGNP4
line 243
;242:
;243:	filename[0] = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 244
;244:	line = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 245
;245:	trap_PC_SourceFileAndLine(handle, filename, &line);
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
line 247
;246:
;247:	Com_Printf(S_COLOR_YELLOW "WARNING: %s, line %d: %s\n", filename, line, string);
ADDRGP4 $87
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $85
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 248
;248:}
LABELV $84
endproc PC_SourceWarning 136 16
bss
align 1
LABELV $89
skip 4096
export PC_SourceError
code
proc PC_SourceError 136 16
line 255
;249:
;250:/*
;251:=================
;252:PC_SourceError
;253:=================
;254:*/
;255:void PC_SourceError(int handle, char *format, ...) {
line 261
;256:	int line;
;257:	char filename[128];
;258:	va_list argptr;
;259:	static char string[4096];
;260:
;261:	va_start(argptr, format);
ADDRLP4 132
ADDRFP4 4+4
ASGNP4
line 262
;262:	ED_vsprintf(string, format, argptr);
ADDRGP4 $89
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
line 263
;263:	va_end(argptr);
ADDRLP4 132
CNSTP4 0
ASGNP4
line 265
;264:
;265:	filename[0] = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 266
;266:	line = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 267
;267:	trap_PC_SourceFileAndLine(handle, filename, &line);
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
line 269
;268:
;269:	Com_Printf(S_COLOR_RED "ERROR: %s, line %d: %s\n", filename, line, string);
ADDRGP4 $91
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $89
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 270
;270:}
LABELV $88
endproc PC_SourceError 136 16
export LerpColor
proc LerpColor 12 0
line 277
;271:
;272:/*
;273:=================
;274:LerpColor
;275:=================
;276:*/
;277:void LerpColor(vec4_t a, vec4_t b, vec4_t c, float t) {
line 281
;278:	int i;
;279:
;280:	// lerp and clamp each component
;281:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $93
line 282
;282:		c[i] = a[i] + t * (b[i] - a[i]);
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
line 283
;283:		if (c[i] < 0)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $97
line 284
;284:			c[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 $98
JUMPV
LABELV $97
line 285
;285:		else if (c[i] > 1.0)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
CNSTF4 1065353216
LEF4 $99
line 286
;286:			c[i] = 1.0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
CNSTF4 1065353216
ASGNF4
LABELV $99
LABELV $98
line 287
;287:	}
LABELV $94
line 281
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $93
line 288
;288:}
LABELV $92
endproc LerpColor 12 0
export Float_Parse
proc Float_Parse 16 8
line 295
;289:
;290:/*
;291:=================
;292:Float_Parse
;293:=================
;294:*/
;295:qboolean Float_Parse(char **p, float *f) {
line 297
;296:	char *token;
;297:	token = COM_ParseExt(p, qfalse);
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
line 298
;298:	if (token && token[0] != 0) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $102
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $102
line 299
;299:		*f = atof(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRF4
ASGNF4
line 300
;300:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $101
JUMPV
LABELV $102
line 301
;301:	} else {
line 302
;302:		return qfalse;
CNSTI4 0
RETI4
LABELV $101
endproc Float_Parse 16 8
export PC_Float_Parse
proc PC_Float_Parse 1052 12
line 311
;303:	}
;304:}
;305:
;306:/*
;307:=================
;308:PC_Float_Parse
;309:=================
;310:*/
;311:qboolean PC_Float_Parse(int handle, float *f) {
line 313
;312:	pc_token_t token;
;313:	int negative = qfalse;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 315
;314:
;315:	if (!trap_PC_ReadToken(handle, &token))
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
NEI4 $105
line 316
;316:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $104
JUMPV
LABELV $105
line 317
;317:	if (token.string[0] == '-') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $107
line 318
;318:		if (!trap_PC_ReadToken(handle, &token))
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
NEI4 $110
line 319
;319:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $104
JUMPV
LABELV $110
line 320
;320:		negative = qtrue;
ADDRLP4 1040
CNSTI4 1
ASGNI4
line 321
;321:	}
LABELV $107
line 322
;322:	if (token.type != TT_NUMBER) {
ADDRLP4 0
INDIRI4
CNSTI4 3
EQI4 $112
line 323
;323:		PC_SourceError(handle, "expected float but found %s\n", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $114
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 324
;324:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $104
JUMPV
LABELV $112
line 326
;325:	}
;326:	if (negative)
ADDRLP4 1040
INDIRI4
CNSTI4 0
EQI4 $116
line 327
;327:		*f = -token.floatvalue;
ADDRFP4 4
INDIRP4
ADDRLP4 0+12
INDIRF4
NEGF4
ASGNF4
ADDRGP4 $117
JUMPV
LABELV $116
line 329
;328:	else
;329:		*f = token.floatvalue;
ADDRFP4 4
INDIRP4
ADDRLP4 0+12
INDIRF4
ASGNF4
LABELV $117
line 330
;330:	return qtrue;
CNSTI4 1
RETI4
LABELV $104
endproc PC_Float_Parse 1052 12
export Color_Parse
proc Color_Parse 12 8
line 338
;331:}
;332:
;333:/*
;334:=================
;335:Color_Parse
;336:=================
;337:*/
;338:qboolean Color_Parse(char **p, vec4_t *c) {
line 342
;339:	int i;
;340:	float f;
;341:
;342:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $121
line 343
;343:		if (!Float_Parse(p, &f)) {
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
NEI4 $125
line 344
;344:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $120
JUMPV
LABELV $125
line 346
;345:		}
;346:		(*c)[i] = f;
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
line 347
;347:	}
LABELV $122
line 342
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $121
line 348
;348:	return qtrue;
CNSTI4 1
RETI4
LABELV $120
endproc Color_Parse 12 8
export PC_Color_Parse
proc PC_Color_Parse 12 8
line 356
;349:}
;350:
;351:/*
;352:=================
;353:PC_Color_Parse
;354:=================
;355:*/
;356:qboolean PC_Color_Parse(int handle, vec4_t *c) {
line 360
;357:	int i;
;358:	float f;
;359:
;360:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $128
line 361
;361:		if (!PC_Float_Parse(handle, &f)) {
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
NEI4 $132
line 362
;362:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $127
JUMPV
LABELV $132
line 364
;363:		}
;364:		(*c)[i] = f;
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
line 365
;365:	}
LABELV $129
line 360
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $128
line 366
;366:	return qtrue;
CNSTI4 1
RETI4
LABELV $127
endproc PC_Color_Parse 12 8
export Int_Parse
proc Int_Parse 16 8
line 374
;367:}
;368:
;369:/*
;370:=================
;371:Int_Parse
;372:=================
;373:*/
;374:qboolean Int_Parse(char **p, int *i) {
line 376
;375:	char *token;
;376:	token = COM_ParseExt(p, qfalse);
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
line 378
;377:
;378:	if (token && token[0] != 0) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $135
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $135
line 379
;379:		*i = atoi(token);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 380
;380:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $134
JUMPV
LABELV $135
line 381
;381:	} else {
line 382
;382:		return qfalse;
CNSTI4 0
RETI4
LABELV $134
endproc Int_Parse 16 8
export PC_Int_Parse
proc PC_Int_Parse 1052 12
line 391
;383:	}
;384:}
;385:
;386:/*
;387:=================
;388:PC_Int_Parse
;389:=================
;390:*/
;391:qboolean PC_Int_Parse(int handle, int *i) {
line 393
;392:	pc_token_t token;
;393:	int negative = qfalse;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 395
;394:
;395:	if (!trap_PC_ReadToken(handle, &token))
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
NEI4 $138
line 396
;396:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $137
JUMPV
LABELV $138
line 397
;397:	if (token.string[0] == '-') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $140
line 398
;398:		if (!trap_PC_ReadToken(handle, &token))
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
NEI4 $143
line 399
;399:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $137
JUMPV
LABELV $143
line 400
;400:		negative = qtrue;
ADDRLP4 1040
CNSTI4 1
ASGNI4
line 401
;401:	}
LABELV $140
line 402
;402:	if (token.type != TT_NUMBER) {
ADDRLP4 0
INDIRI4
CNSTI4 3
EQI4 $145
line 403
;403:		PC_SourceError(handle, "expected integer but found %s\n", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $147
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 404
;404:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $137
JUMPV
LABELV $145
line 406
;405:	}
;406:	*i = token.intvalue;
ADDRFP4 4
INDIRP4
ADDRLP4 0+8
INDIRI4
ASGNI4
line 407
;407:	if (negative)
ADDRLP4 1040
INDIRI4
CNSTI4 0
EQI4 $150
line 408
;408:		*i = -*i;
ADDRLP4 1048
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
ADDRLP4 1048
INDIRP4
INDIRI4
NEGI4
ASGNI4
LABELV $150
line 409
;409:	return qtrue;
CNSTI4 1
RETI4
LABELV $137
endproc PC_Int_Parse 1052 12
export Rect_Parse
proc Rect_Parse 16 8
line 417
;410:}
;411:
;412:/*
;413:=================
;414:Rect_Parse
;415:=================
;416:*/
;417:qboolean Rect_Parse(char **p, rectDef_t *r) {
line 418
;418:	if (Float_Parse(p, &r->x)) {
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
EQI4 $153
line 419
;419:		if (Float_Parse(p, &r->y)) {
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
EQI4 $155
line 420
;420:			if (Float_Parse(p, &r->w)) {
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
EQI4 $157
line 421
;421:				if (Float_Parse(p, &r->h)) {
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
EQI4 $159
line 422
;422:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $152
JUMPV
LABELV $159
line 424
;423:				}
;424:			}
LABELV $157
line 425
;425:		}
LABELV $155
line 426
;426:	}
LABELV $153
line 427
;427:	return qfalse;
CNSTI4 0
RETI4
LABELV $152
endproc Rect_Parse 16 8
export PC_Rect_Parse
proc PC_Rect_Parse 16 8
line 435
;428:}
;429:
;430:/*
;431:=================
;432:PC_Rect_Parse
;433:=================
;434:*/
;435:qboolean PC_Rect_Parse(int handle, rectDef_t *r) {
line 436
;436:	if (PC_Float_Parse(handle, &r->x)) {
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
EQI4 $162
line 437
;437:		if (PC_Float_Parse(handle, &r->y)) {
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
EQI4 $164
line 438
;438:			if (PC_Float_Parse(handle, &r->w)) {
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
EQI4 $166
line 439
;439:				if (PC_Float_Parse(handle, &r->h)) {
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
EQI4 $168
line 440
;440:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $161
JUMPV
LABELV $168
line 442
;441:				}
;442:			}
LABELV $166
line 443
;443:		}
LABELV $164
line 444
;444:	}
LABELV $162
line 445
;445:	return qfalse;
CNSTI4 0
RETI4
LABELV $161
endproc PC_Rect_Parse 16 8
export String_Parse
proc String_Parse 16 8
line 453
;446:}
;447:
;448:/*
;449:=================
;450:String_Parse
;451:=================
;452:*/
;453:qboolean String_Parse(char **p, const char **out) {
line 456
;454:	char *token;
;455:
;456:	token = COM_ParseExt(p, qfalse);
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
line 457
;457:	if (token && token[0] != 0) {
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
line 458
;458:		*(out) = String_Alloc(token);
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
line 459
;459:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $170
JUMPV
LABELV $171
line 461
;460:	}
;461:	return qfalse;
CNSTI4 0
RETI4
LABELV $170
endproc String_Parse 16 8
export PC_String_Parse
proc PC_String_Parse 1048 8
line 469
;462:}
;463:
;464:/*
;465:=================
;466:PC_String_Parse
;467:=================
;468:*/
;469:qboolean PC_String_Parse(int handle, const char **out) {
line 472
;470:	pc_token_t token;
;471:
;472:	if (!trap_PC_ReadToken(handle, &token))
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
NEI4 $174
line 473
;473:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $173
JUMPV
LABELV $174
line 475
;474:
;475:	*(out) = String_Alloc(token.string);
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
line 476
;476:	return qtrue;
CNSTI4 1
RETI4
LABELV $173
endproc PC_String_Parse 1048 8
export PC_Script_Parse
proc PC_Script_Parse 2084 12
line 484
;477:}
;478:
;479:/*
;480:=================
;481:PC_Script_Parse
;482:=================
;483:*/
;484:qboolean PC_Script_Parse(int handle, const char **out) {
line 488
;485:	char script[1024];
;486:	pc_token_t token;
;487:
;488:	memset(script, 0, sizeof(script));
ADDRLP4 1040
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 492
;489:	// scripts start with { and have ; separated command lists.. commands are command, arg.. 
;490:	// basically we want everything between the { } as it will be interpreted at run time
;491:
;492:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 2064
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 2064
INDIRI4
CNSTI4 0
NEI4 $178
line 493
;493:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $177
JUMPV
LABELV $178
line 494
;494:	if (Q_stricmp(token.string, "{") != 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $183
ARGP4
ADDRLP4 2068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
EQI4 $185
line 495
;495:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $177
JUMPV
LABELV $184
line 498
;496:	}
;497:
;498:	while (1) {
line 499
;499:		if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 2072
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 2072
INDIRI4
CNSTI4 0
NEI4 $187
line 500
;500:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $177
JUMPV
LABELV $187
line 502
;501:
;502:		if (Q_stricmp(token.string, "}") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $192
ARGP4
ADDRLP4 2076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2076
INDIRI4
CNSTI4 0
NEI4 $189
line 503
;503:			*out = String_Alloc(script);
ADDRLP4 1040
ARGP4
ADDRLP4 2080
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRFP4 4
INDIRP4
ADDRLP4 2080
INDIRP4
ASGNP4
line 504
;504:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $177
JUMPV
LABELV $189
line 507
;505:		}
;506:
;507:		if (token.string[1] != '\0') {
ADDRLP4 0+16+1
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $193
line 508
;508:			Q_strcat(script, 1024, va("\"%s\"", token.string));
ADDRGP4 $197
ARGP4
ADDRLP4 0+16
ARGP4
ADDRLP4 2080
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1040
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2080
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 509
;509:		} else {
ADDRGP4 $194
JUMPV
LABELV $193
line 510
;510:			Q_strcat(script, 1024, token.string);
ADDRLP4 1040
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 0+16
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 511
;511:		}
LABELV $194
line 512
;512:		Q_strcat(script, 1024, " ");
ADDRLP4 1040
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $200
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 513
;513:	}
LABELV $185
line 498
ADDRGP4 $184
JUMPV
line 514
;514:	return qfalse; 	// bk001105 - LCC   missing return value
CNSTI4 0
RETI4
LABELV $177
endproc PC_Script_Parse 2084 12
export Init_Display
proc Init_Display 0 0
line 527
;515:}
;516:
;517:// display, window, menu, item code
;518:// 
;519:
;520:/*
;521:==================
;522:Init_Display
;523:
;524:Initializes the display with a structure to all the drawing routines
;525: ==================
;526:*/
;527:void Init_Display(displayContextDef_t *dc) {
line 528
;528:	DC = dc;
ADDRGP4 DC
ADDRFP4 0
INDIRP4
ASGNP4
line 529
;529:}
LABELV $201
endproc Init_Display 0 0
export GradientBar_Paint
proc GradientBar_Paint 8 20
line 535
;530:
;531:
;532:
;533:// type and style painting 
;534:
;535:void GradientBar_Paint(rectDef_t *rect, vec4_t color) {
line 537
;536:	// gradient bar takes two paints
;537:	DC->setColor(color);
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
line 538
;538:	DC->drawHandlePic(rect->x, rect->y, rect->w, rect->h, DC->Assets.gradientBar);
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
CNSTI4 61888
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 539
;539:	DC->setColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 540
;540:}
LABELV $202
endproc GradientBar_Paint 8 20
export Window_Init
proc Window_Init 8 12
line 551
;541:
;542:
;543:/*
;544:==================
;545:Window_Init
;546:
;547:Initializes a window structure ( windowDef_t ) with defaults
;548:
;549:==================
;550:*/
;551:void Window_Init(Window *w) {
line 552
;552:	memset(w, 0, sizeof(windowDef_t));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 180
ARGI4
ADDRGP4 memset
CALLP4
pop
line 553
;553:	w->borderSize = 1;
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
CNSTF4 1065353216
ASGNF4
line 554
;554:	w->foreColor[0] = w->foreColor[1] = w->foreColor[2] = w->foreColor[3] = 1.0;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTF4 1065353216
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
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 555
;555:	w->cinematic = -1;
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 -1
ASGNI4
line 556
;556:}
LABELV $203
endproc Window_Init 8 12
export Fade
proc Fade 8 0
line 558
;557:
;558:void Fade(int *flags, float *f, float clamp, int *nextTime, int offsetTime, qboolean bFlags, float fadeAmount) {
line 559
;559:	if (*flags & (WINDOW_FADINGOUT | WINDOW_FADINGIN)) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 96
BANDI4
CNSTI4 0
EQI4 $205
line 560
;560:		if (DC->realTime > *nextTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRFP4 12
INDIRP4
INDIRI4
LEI4 $207
line 561
;561:			*nextTime = DC->realTime + offsetTime;
ADDRFP4 12
INDIRP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRFP4 16
INDIRI4
ADDI4
ASGNI4
line 562
;562:			if (*flags & WINDOW_FADINGOUT) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $209
line 563
;563:				*f -= fadeAmount;
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
line 564
;564:				if (bFlags && *f <= 0.0) {
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $210
ADDRFP4 4
INDIRP4
INDIRF4
CNSTF4 0
GTF4 $210
line 565
;565:					*flags &= ~(WINDOW_FADINGOUT | WINDOW_VISIBLE);
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
line 566
;566:				}
line 567
;567:			} else {
ADDRGP4 $210
JUMPV
LABELV $209
line 568
;568:				*f += fadeAmount;
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
line 569
;569:				if (*f >= clamp) {
ADDRFP4 4
INDIRP4
INDIRF4
ADDRFP4 8
INDIRF4
LTF4 $213
line 570
;570:					*f = clamp;
ADDRFP4 4
INDIRP4
ADDRFP4 8
INDIRF4
ASGNF4
line 571
;571:					if (bFlags) {
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $215
line 572
;572:						*flags &= ~WINDOW_FADINGIN;
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
line 573
;573:					}
LABELV $215
line 574
;574:				}
LABELV $213
line 575
;575:			}
LABELV $210
line 576
;576:		}
LABELV $207
line 577
;577:	}
LABELV $205
line 578
;578:}
LABELV $204
endproc Fade 8 0
export Window_Paint
proc Window_Paint 56 28
line 582
;579:
;580:
;581:
;582:void Window_Paint(Window *w, float fadeAmount, float fadeClamp, float fadeCycle) {
line 585
;583:	//float bordersize = 0;
;584:	vec4_t color;
;585:	rectDef_t fillRect = w->rect;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 16
line 588
;586:
;587:
;588:	if (debugMode) {
ADDRGP4 debugMode
INDIRI4
CNSTI4 0
EQI4 $218
line 589
;589:		color[0] = color[1] = color[2] = color[3] = 1;
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
line 590
;590:		DC->drawRect(w->rect.x, w->rect.y, w->rect.w, w->rect.h, 1, color);
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
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 591
;591:	}
LABELV $218
line 593
;592:
;593:	if (w == NULL || (w->style == 0 && w->border == 0)) {
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $225
ADDRLP4 32
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 0
NEI4 $223
ADDRLP4 32
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
NEI4 $223
LABELV $225
line 594
;594:		return;
ADDRGP4 $217
JUMPV
LABELV $223
line 597
;595:	}
;596:
;597:	if (w->border != 0) {
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $226
line 598
;598:		fillRect.x += w->borderSize;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 599
;599:		fillRect.y += w->borderSize;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 600
;600:		fillRect.w -= w->borderSize + 1;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
SUBF4
ASGNF4
line 601
;601:		fillRect.h -= w->borderSize + 1;
ADDRLP4 0+12
ADDRLP4 0+12
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
SUBF4
ASGNF4
line 602
;602:	}
LABELV $226
line 604
;603:
;604:	if (w->style == WINDOW_STYLE_FILLED) {
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 1
NEI4 $231
line 606
;605:		// box, but possible a shader that needs filled
;606:		if (w->background) {
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 0
EQI4 $233
line 607
;607:			Fade(&w->flags, &w->backColor[3], fadeClamp, &w->nextTime, fadeCycle, qtrue, fadeAmount);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 68
ADDP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 140
ADDP4
ARGP4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 108
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
line 608
;608:			DC->setColor(w->backColor);
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 609
;609:			DC->drawHandlePic(fillRect.x, fillRect.y, fillRect.w, fillRect.h, w->background);
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
CNSTI4 176
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
line 610
;610:			DC->setColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 611
;611:		} else {
ADDRGP4 $232
JUMPV
LABELV $233
line 612
;612:			DC->fillRect(fillRect.x, fillRect.y, fillRect.w, fillRect.h, w->backColor);
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
CNSTI4 128
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
CALLV
pop
line 613
;613:		}
line 614
;614:	} else if (w->style == WINDOW_STYLE_GRADIENT) {
ADDRGP4 $232
JUMPV
LABELV $231
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 2
NEI4 $241
line 615
;615:		GradientBar_Paint(&fillRect, w->backColor);
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ARGP4
ADDRGP4 GradientBar_Paint
CALLV
pop
line 617
;616:		// gradient bar
;617:	} else if (w->style == WINDOW_STYLE_SHADER) {
ADDRGP4 $242
JUMPV
LABELV $241
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 3
NEI4 $243
line 618
;618:		if (w->flags & WINDOW_FORECOLORSET) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $245
line 619
;619:			DC->setColor(w->foreColor);
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 620
;620:		}
LABELV $245
line 621
;621:		DC->drawHandlePic(fillRect.x, fillRect.y, fillRect.w, fillRect.h, w->background);
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
CNSTI4 176
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
line 622
;622:		DC->setColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 623
;623:	} else if (w->style == WINDOW_STYLE_TEAMCOLOR) {
ADDRGP4 $244
JUMPV
LABELV $243
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 4
NEI4 $250
line 624
;624:		if (DC->getTeamColor) {
ADDRGP4 DC
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $251
line 625
;625:			DC->getTeamColor(&color);
ADDRLP4 16
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
CALLV
pop
line 626
;626:			DC->fillRect(fillRect.x, fillRect.y, fillRect.w, fillRect.h, color);
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
ADDRGP4 DC
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
CALLV
pop
line 627
;627:		}
line 628
;628:	} else if (w->style == WINDOW_STYLE_CINEMATIC) {
ADDRGP4 $251
JUMPV
LABELV $250
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $257
line 629
;629:		if (w->cinematic == -1) {
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $259
line 630
;630:			w->cinematic = DC->playCinematic(w->cinematicName, fillRect.x, fillRect.y, fillRect.w, fillRect.h);
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
ADDRLP4 40
ADDRGP4 DC
INDIRP4
CNSTI4 180
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
line 631
;631:			if (w->cinematic == -1) {
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $264
line 632
;632:				w->cinematic = -2;
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 -2
ASGNI4
line 633
;633:			}
LABELV $264
line 634
;634:		}
LABELV $259
line 635
;635:		if (w->cinematic >= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LTI4 $266
line 636
;636:			DC->runCinematicFrame(w->cinematic);
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 192
ADDP4
INDIRP4
CALLV
pop
line 637
;637:			DC->drawCinematic(w->cinematic, fillRect.x, fillRect.y, fillRect.w, fillRect.h);
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
ADDRGP4 DC
INDIRP4
CNSTI4 188
ADDP4
INDIRP4
CALLV
pop
line 638
;638:		}
LABELV $266
line 639
;639:	}
LABELV $257
LABELV $251
LABELV $244
LABELV $242
LABELV $232
line 641
;640:
;641:	if (w->border == WINDOW_BORDER_FULL) {
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 1
NEI4 $271
line 644
;642:		// full
;643:		// HACK HACK HACK
;644:		if (w->style == WINDOW_STYLE_TEAMCOLOR) {
ADDRFP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 4
NEI4 $273
line 645
;645:			if (color[0] > 0) {
ADDRLP4 16
INDIRF4
CNSTF4 0
LEF4 $275
line 647
;646:				// red
;647:				color[0] = 1;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
line 648
;648:				color[1] = color[2] = .5;
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
line 650
;649:
;650:			} else {
ADDRGP4 $276
JUMPV
LABELV $275
line 651
;651:				color[2] = 1;
ADDRLP4 16+8
CNSTF4 1065353216
ASGNF4
line 652
;652:				color[0] = color[1] = .5;
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
line 653
;653:			}
LABELV $276
line 654
;654:			color[3] = 1;
ADDRLP4 16+12
CNSTF4 1065353216
ASGNF4
line 655
;655:			DC->drawRect(w->rect.x, w->rect.y, w->rect.w, w->rect.h, w->borderSize, color);
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
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 656
;656:		} else {
ADDRGP4 $272
JUMPV
LABELV $273
line 657
;657:			DC->drawRect(w->rect.x, w->rect.y, w->rect.w, w->rect.h, w->borderSize, w->borderColor);
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
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 658
;658:		}
line 659
;659:	} else if (w->border == WINDOW_BORDER_HORZ) {
ADDRGP4 $272
JUMPV
LABELV $271
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 2
NEI4 $282
line 661
;660:		// top/bottom
;661:		DC->setColor(w->borderColor);
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 662
;662:		DC->drawTopBottom(w->rect.x, w->rect.y, w->rect.w, w->rect.h, w->borderSize);
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
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRGP4 DC
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
CALLV
pop
line 663
;663:		DC->setColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 664
;664:	} else if (w->border == WINDOW_BORDER_VERT) {
ADDRGP4 $283
JUMPV
LABELV $282
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 3
NEI4 $284
line 666
;665:		// left right
;666:		DC->setColor(w->borderColor);
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 667
;667:		DC->drawSides(w->rect.x, w->rect.y, w->rect.w, w->rect.h, w->borderSize);
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
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRGP4 DC
INDIRP4
CNSTI4 44
ADDP4
INDIRP4
CALLV
pop
line 668
;668:		DC->setColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 669
;669:	} else if (w->border == WINDOW_BORDER_KCGRADIENT) {
ADDRGP4 $285
JUMPV
LABELV $284
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 4
NEI4 $286
line 671
;670:		// this is just two gradient bars along each horz edge
;671:		rectDef_t r = w->rect;
ADDRLP4 36
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 16
line 672
;672:		r.h = w->borderSize;
ADDRLP4 36+12
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ASGNF4
line 673
;673:		GradientBar_Paint(&r, w->borderColor);
ADDRLP4 36
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 GradientBar_Paint
CALLV
pop
line 674
;674:		r.y = w->rect.y + w->rect.h - 1;
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
line 675
;675:		GradientBar_Paint(&r, w->borderColor);
ADDRLP4 36
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 GradientBar_Paint
CALLV
pop
line 676
;676:	}
LABELV $286
LABELV $285
LABELV $283
LABELV $272
line 678
;677:
;678:}
LABELV $217
endproc Window_Paint 56 28
export Item_SetScreenCoords
proc Item_SetScreenCoords 16 0
line 681
;679:
;680:
;681:void Item_SetScreenCoords(itemDef_t *item, float x, float y) {
line 683
;682:
;683:	if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $291
line 684
;684:		return;
ADDRGP4 $290
JUMPV
LABELV $291
line 687
;685:	}
;686:
;687:	if (item->window.border != 0) {
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $293
line 688
;688:		x += item->window.borderSize;
ADDRFP4 4
ADDRFP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 689
;689:		y += item->window.borderSize;
ADDRFP4 8
ADDRFP4 8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 690
;690:	}
LABELV $293
line 692
;691:
;692:	item->window.rect.x = x + item->window.rectClient.x;
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
line 693
;693:	item->window.rect.y = y + item->window.rectClient.y;
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
line 694
;694:	item->window.rect.w = item->window.rectClient.w;
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
line 695
;695:	item->window.rect.h = item->window.rectClient.h;
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
line 698
;696:
;697:	// force the text rects to recompute
;698:	item->textRect.w = 0;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 0
ASGNF4
line 699
;699:	item->textRect.h = 0;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 0
ASGNF4
line 700
;700:}
LABELV $290
endproc Item_SetScreenCoords 16 0
export Item_UpdatePosition
proc Item_UpdatePosition 16 12
line 703
;701:
;702:// FIXME: consolidate this with nearby stuff
;703:void Item_UpdatePosition(itemDef_t *item) {
line 707
;704:	float x, y;
;705:	menuDef_t *menu;
;706:
;707:	if (item == NULL || item->parent == NULL) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $298
ADDRLP4 12
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $296
LABELV $298
line 708
;708:		return;
ADDRGP4 $295
JUMPV
LABELV $296
line 711
;709:	}
;710:
;711:	menu = item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 713
;712:
;713:	x = menu->window.rect.x;
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRF4
ASGNF4
line 714
;714:	y = menu->window.rect.y;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 716
;715:
;716:	if (menu->window.border != 0) {
ADDRLP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $299
line 717
;717:		x += menu->window.borderSize;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 718
;718:		y += menu->window.borderSize;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 719
;719:	}
LABELV $299
line 721
;720:
;721:	Item_SetScreenCoords(item, x, y);
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
line 723
;722:
;723:}
LABELV $295
endproc Item_UpdatePosition 16 12
export Menu_UpdatePosition
proc Menu_UpdatePosition 12 12
line 726
;724:
;725:// menus
;726:void Menu_UpdatePosition(menuDef_t *menu) {
line 730
;727:	int i;
;728:	float x, y;
;729:
;730:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $302
line 731
;731:		return;
ADDRGP4 $301
JUMPV
LABELV $302
line 734
;732:	}
;733:
;734:	x = menu->window.rect.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 735
;735:	y = menu->window.rect.y;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 736
;736:	if (menu->window.border != 0) {
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $304
line 737
;737:		x += menu->window.borderSize;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 738
;738:		y += menu->window.borderSize;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 739
;739:	}
LABELV $304
line 741
;740:
;741:	for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $309
JUMPV
LABELV $306
line 742
;742:		Item_SetScreenCoords(menu->items[i], x, y);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
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
line 743
;743:	}
LABELV $307
line 741
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $309
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $306
line 744
;744:}
LABELV $301
endproc Menu_UpdatePosition 12 12
export Menu_PostParse
proc Menu_PostParse 0 4
line 746
;745:
;746:void Menu_PostParse(menuDef_t *menu) {
line 747
;747:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $311
line 748
;748:		return;
ADDRGP4 $310
JUMPV
LABELV $311
line 750
;749:	}
;750:	if (menu->fullScreen) {
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
EQI4 $313
line 751
;751:		menu->window.rect.x = 0;
ADDRFP4 0
INDIRP4
CNSTF4 0
ASGNF4
line 752
;752:		menu->window.rect.y = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
line 753
;753:		menu->window.rect.w = 640;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1142947840
ASGNF4
line 754
;754:		menu->window.rect.h = 480;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1139802112
ASGNF4
line 755
;755:	}
LABELV $313
line 756
;756:	Menu_UpdatePosition(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_UpdatePosition
CALLV
pop
line 757
;757:}
LABELV $310
endproc Menu_PostParse 0 4
export Menu_ClearFocus
proc Menu_ClearFocus 20 8
line 759
;758:
;759:itemDef_t *Menu_ClearFocus(menuDef_t *menu) {
line 761
;760:	int i;
;761:	itemDef_t *ret = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 763
;762:
;763:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $316
line 764
;764:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $315
JUMPV
LABELV $316
line 767
;765:	}
;766:
;767:	for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $321
JUMPV
LABELV $318
line 768
;768:		if (menu->items[i]->window.flags & WINDOW_HASFOCUS) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $322
line 769
;769:			ret = menu->items[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
line 770
;770:		}
LABELV $322
line 771
;771:		menu->items[i]->window.flags &= ~WINDOW_HASFOCUS;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
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
line 772
;772:		if (menu->items[i]->leaveFocus) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 260
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $324
line 773
;773:			Item_RunScript(menu->items[i], menu->items[i]->leaveFocus);
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
CNSTI4 260
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
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 260
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 774
;774:		}
LABELV $324
line 775
;775:	}
LABELV $319
line 767
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $321
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $318
line 777
;776:
;777:	return ret;
ADDRLP4 4
INDIRP4
RETP4
LABELV $315
endproc Menu_ClearFocus 20 8
export IsVisible
proc IsVisible 8 0
line 780
;778:}
;779:
;780:qboolean IsVisible(int flags) {
line 781
;781:	return (flags & WINDOW_VISIBLE && !(flags & WINDOW_FADINGOUT));
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $328
ADDRLP4 4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
NEI4 $328
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $329
JUMPV
LABELV $328
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $329
ADDRLP4 0
INDIRI4
RETI4
LABELV $326
endproc IsVisible 8 0
export Rect_ContainsPoint
proc Rect_ContainsPoint 16 0
line 784
;782:}
;783:
;784:qboolean Rect_ContainsPoint(rectDef_t *rect, float x, float y) {
line 785
;785:	if (rect) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $331
line 786
;786:		if (x > rect->x && x < rect->x + rect->w && y > rect->y && y < rect->y + rect->h) {
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
LEF4 $333
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
GEF4 $333
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
LEF4 $333
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
GEF4 $333
line 787
;787:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $330
JUMPV
LABELV $333
line 789
;788:		}
;789:	}
LABELV $331
line 790
;790:	return qfalse;
CNSTI4 0
RETI4
LABELV $330
endproc Rect_ContainsPoint 16 0
export Menu_ItemsMatchingGroup
proc Menu_ItemsMatchingGroup 24 8
line 793
;791:}
;792:
;793:int Menu_ItemsMatchingGroup(menuDef_t *menu, const char *name) {
line 795
;794:	int i;
;795:	int count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 796
;796:	for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $339
JUMPV
LABELV $336
line 797
;797:		if (Q_stricmp(menu->items[i]->window.name, name) == 0 || (menu->items[i]->window.group && Q_stricmp(menu->items[i]->window.group, name) == 0)) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
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
EQI4 $342
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
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $340
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 260
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
NEI4 $340
LABELV $342
line 798
;798:			count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 799
;799:		}
LABELV $340
line 800
;800:	}
LABELV $337
line 796
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $339
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $336
line 801
;801:	return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $335
endproc Menu_ItemsMatchingGroup 24 8
export Menu_GetMatchingItemByNumber
proc Menu_GetMatchingItemByNumber 24 8
line 804
;802:}
;803:
;804:itemDef_t *Menu_GetMatchingItemByNumber(menuDef_t *menu, int index, const char *name) {
line 806
;805:	int i;
;806:	int count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 807
;807:	for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $347
JUMPV
LABELV $344
line 808
;808:		if (Q_stricmp(menu->items[i]->window.name, name) == 0 || (menu->items[i]->window.group && Q_stricmp(menu->items[i]->window.group, name) == 0)) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
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
EQI4 $350
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
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $348
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 260
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
NEI4 $348
LABELV $350
line 809
;809:			if (count == index) {
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $351
line 810
;810:				return menu->items[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $343
JUMPV
LABELV $351
line 812
;811:			}
;812:			count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 813
;813:		}
LABELV $348
line 814
;814:	}
LABELV $345
line 807
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $347
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $344
line 815
;815:	return NULL;
CNSTP4 0
RETP4
LABELV $343
endproc Menu_GetMatchingItemByNumber 24 8
export Script_SetColor
proc Script_SetColor 36 8
line 820
;816:}
;817:
;818:
;819:
;820:void Script_SetColor(itemDef_t *item, char **args) {
line 826
;821:	const char *name;
;822:	int i;
;823:	float f;
;824:	vec4_t *out;
;825:	// expecting type of color to set and 4 args for the color
;826:	if (String_Parse(args, &name)) {
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
EQI4 $354
line 827
;827:		out = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 828
;828:		if (Q_stricmp(name, "backcolor") == 0) {
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $358
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $356
line 829
;829:			out = &item->window.backColor;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ASGNP4
line 830
;830:			item->window.flags |= WINDOW_BACKCOLORSET;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 831
;831:		} else if (Q_stricmp(name, "forecolor") == 0) {
ADDRGP4 $357
JUMPV
LABELV $356
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $361
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $359
line 832
;832:			out = &item->window.foreColor;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ASGNP4
line 833
;833:			item->window.flags |= WINDOW_FORECOLORSET;
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 834
;834:		} else if (Q_stricmp(name, "bordercolor") == 0) {
ADDRGP4 $360
JUMPV
LABELV $359
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $364
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $362
line 835
;835:			out = &item->window.borderColor;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ASGNP4
line 836
;836:		}
LABELV $362
LABELV $360
LABELV $357
line 838
;837:
;838:		if (out) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $365
line 839
;839:			for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $367
line 840
;840:				if (!Float_Parse(args, &f)) {
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
NEI4 $371
line 841
;841:					return;
ADDRGP4 $353
JUMPV
LABELV $371
line 843
;842:				}
;843:				(*out)[i] = f;
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
line 844
;844:			}
LABELV $368
line 839
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $367
line 845
;845:		}
LABELV $365
line 846
;846:	}
LABELV $354
line 847
;847:}
LABELV $353
endproc Script_SetColor 36 8
export Script_SetAsset
proc Script_SetAsset 8 8
line 849
;848:
;849:void Script_SetAsset(itemDef_t *item, char **args) {
line 852
;850:	const char *name;
;851:	// expecting name to set asset to
;852:	if (String_Parse(args, &name)) {
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
EQI4 $374
line 854
;853:		// check for a model 
;854:		if (item->type == ITEM_TYPE_MODEL) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 7
NEI4 $376
line 855
;855:		}
LABELV $376
line 856
;856:	}
LABELV $374
line 857
;857:}
LABELV $373
endproc Script_SetAsset 8 8
export Script_SetBackground
proc Script_SetBackground 12 8
line 859
;858:
;859:void Script_SetBackground(itemDef_t *item, char **args) {
line 862
;860:	const char *name;
;861:	// expecting name to set asset to
;862:	if (String_Parse(args, &name)) {
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
EQI4 $379
line 863
;863:		item->window.background = DC->registerShaderNoMip(name);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 864
;864:	}
LABELV $379
line 865
;865:}
LABELV $378
endproc Script_SetBackground 12 8
export Menu_FindItemByName
proc Menu_FindItemByName 8 8
line 870
;866:
;867:
;868:
;869:
;870:itemDef_t *Menu_FindItemByName(menuDef_t *menu, const char *p) {
line 872
;871:	int i;
;872:	if (menu == NULL || p == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $384
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $382
LABELV $384
line 873
;873:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $381
JUMPV
LABELV $382
line 876
;874:	}
;875:
;876:	for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $388
JUMPV
LABELV $385
line 877
;877:		if (Q_stricmp(p, menu->items[i]->window.name) == 0) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
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
NEI4 $389
line 878
;878:			return menu->items[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $381
JUMPV
LABELV $389
line 880
;879:		}
;880:	}
LABELV $386
line 876
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $388
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $385
line 882
;881:
;882:	return NULL;
CNSTP4 0
RETP4
LABELV $381
endproc Menu_FindItemByName 8 8
export Script_SetTeamColor
proc Script_SetTeamColor 24 4
line 885
;883:}
;884:
;885:void Script_SetTeamColor(itemDef_t *item, char **args) {
line 886
;886:	if (DC->getTeamColor) {
ADDRGP4 DC
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $392
line 889
;887:		int i;
;888:		vec4_t color;
;889:		DC->getTeamColor(&color);
ADDRLP4 4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 84
ADDP4
INDIRP4
CALLV
pop
line 890
;890:		for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $394
line 891
;891:			item->window.backColor[i] = color[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 128
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
line 892
;892:		}
LABELV $395
line 890
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $394
line 893
;893:	}
LABELV $392
line 894
;894:}
LABELV $391
endproc Script_SetTeamColor 24 4
export Script_SetItemColor
proc Script_SetItemColor 80 12
line 896
;895:
;896:void Script_SetItemColor(itemDef_t *item, char **args) {
line 903
;897:	const char *itemname;
;898:	const char *name;
;899:	vec4_t color;
;900:	int i;
;901:	vec4_t *out;
;902:	// expecting type of color to set and 4 args for the color
;903:	if (String_Parse(args, &itemname) && String_Parse(args, &name)) {
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
EQI4 $399
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
EQI4 $399
line 906
;904:		itemDef_t *item2;
;905:		int j;
;906:		int count = Menu_ItemsMatchingGroup(item->parent, itemname);
ADDRFP4 0
INDIRP4
CNSTI4 228
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
line 908
;907:
;908:		if (!Color_Parse(args, &color)) {
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
NEI4 $401
line 909
;909:			return;
ADDRGP4 $398
JUMPV
LABELV $401
line 912
;910:		}
;911:
;912:		for (j = 0; j < count; j++) {
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRGP4 $406
JUMPV
LABELV $403
line 913
;913:			item2 = Menu_GetMatchingItemByNumber(item->parent, j, itemname);
ADDRFP4 0
INDIRP4
CNSTI4 228
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
line 914
;914:			if (item2 != NULL) {
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $407
line 915
;915:				out = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 916
;916:				if (Q_stricmp(name, "backcolor") == 0) {
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 $358
ARGP4
ADDRLP4 64
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 0
NEI4 $409
line 917
;917:					out = &item2->window.backColor;
ADDRLP4 4
ADDRLP4 44
INDIRP4
CNSTI4 128
ADDP4
ASGNP4
line 918
;918:				} else if (Q_stricmp(name, "forecolor") == 0) {
ADDRGP4 $410
JUMPV
LABELV $409
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 $361
ARGP4
ADDRLP4 68
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $411
line 919
;919:					out = &item2->window.foreColor;
ADDRLP4 4
ADDRLP4 44
INDIRP4
CNSTI4 112
ADDP4
ASGNP4
line 920
;920:					item2->window.flags |= WINDOW_FORECOLORSET;
ADDRLP4 72
ADDRLP4 44
INDIRP4
CNSTI4 68
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
line 921
;921:				} else if (Q_stricmp(name, "bordercolor") == 0) {
ADDRGP4 $412
JUMPV
LABELV $411
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 $364
ARGP4
ADDRLP4 72
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $413
line 922
;922:					out = &item2->window.borderColor;
ADDRLP4 4
ADDRLP4 44
INDIRP4
CNSTI4 144
ADDP4
ASGNP4
line 923
;923:				}
LABELV $413
LABELV $412
LABELV $410
line 925
;924:
;925:				if (out) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $415
line 926
;926:					for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $417
line 927
;927:						(*out)[i] = color[i];
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
line 928
;928:					}
LABELV $418
line 926
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $417
line 929
;929:				}
LABELV $415
line 930
;930:			}
LABELV $407
line 931
;931:		}
LABELV $404
line 912
ADDRLP4 40
ADDRLP4 40
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $406
ADDRLP4 40
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $403
line 932
;932:	}
LABELV $399
line 933
;933:}
LABELV $398
endproc Script_SetItemColor 80 12
export Menu_ShowItemByName
proc Menu_ShowItemByName 24 12
line 936
;934:
;935:
;936:void Menu_ShowItemByName(menuDef_t *menu, const char *p, qboolean bShow) {
line 939
;937:	itemDef_t *item;
;938:	int i;
;939:	int count = Menu_ItemsMatchingGroup(menu, p);
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
line 940
;940:	for (i = 0; i < count; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $425
JUMPV
LABELV $422
line 941
;941:		item = Menu_GetMatchingItemByNumber(menu, i, p);
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
line 942
;942:		if (item != NULL) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $426
line 943
;943:			if (bShow) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $428
line 944
;944:				item->window.flags |= WINDOW_VISIBLE;
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 68
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
line 945
;945:			} else {
ADDRGP4 $429
JUMPV
LABELV $428
line 946
;946:				item->window.flags &= ~WINDOW_VISIBLE;
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 68
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
line 948
;947:				// stop cinematics playing in the window
;948:				if (item->window.cinematic >= 0) {
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LTI4 $430
line 949
;949:					DC->stopCinematic(item->window.cinematic);
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 184
ADDP4
INDIRP4
CALLV
pop
line 950
;950:					item->window.cinematic = -1;
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 -1
ASGNI4
line 951
;951:				}
LABELV $430
line 952
;952:			}
LABELV $429
line 953
;953:		}
LABELV $426
line 954
;954:	}
LABELV $423
line 940
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $425
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $422
line 955
;955:}
LABELV $421
endproc Menu_ShowItemByName 24 12
export Menu_FadeItemByName
proc Menu_FadeItemByName 28 12
line 957
;956:
;957:void Menu_FadeItemByName(menuDef_t *menu, const char *p, qboolean fadeOut) {
line 960
;958:	itemDef_t *item;
;959:	int i;
;960:	int count = Menu_ItemsMatchingGroup(menu, p);
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
line 961
;961:	for (i = 0; i < count; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $436
JUMPV
LABELV $433
line 962
;962:		item = Menu_GetMatchingItemByNumber(menu, i, p);
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
line 963
;963:		if (item != NULL) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $437
line 964
;964:			if (fadeOut) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $439
line 965
;965:				item->window.flags |= (WINDOW_FADINGOUT | WINDOW_VISIBLE);
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 68
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
line 966
;966:				item->window.flags &= ~WINDOW_FADINGIN;
ADDRLP4 24
ADDRLP4 4
INDIRP4
CNSTI4 68
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
line 967
;967:			} else {
ADDRGP4 $440
JUMPV
LABELV $439
line 968
;968:				item->window.flags |= (WINDOW_VISIBLE | WINDOW_FADINGIN);
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 68
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
line 969
;969:				item->window.flags &= ~WINDOW_FADINGOUT;
ADDRLP4 24
ADDRLP4 4
INDIRP4
CNSTI4 68
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
line 970
;970:			}
LABELV $440
line 971
;971:		}
LABELV $437
line 972
;972:	}
LABELV $434
line 961
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $436
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $433
line 973
;973:}
LABELV $432
endproc Menu_FadeItemByName 28 12
export Menus_FindByName
proc Menus_FindByName 8 8
line 975
;974:
;975:menuDef_t *Menus_FindByName(const char *p) {
line 977
;976:	int i;
;977:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $445
JUMPV
LABELV $442
line 978
;978:		if (Q_stricmp(Menus[i].window.name, p) == 0) {
ADDRLP4 0
INDIRI4
CNSTI4 644
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
NEI4 $446
line 979
;979:			return &Menus[i];
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
RETP4
ADDRGP4 $441
JUMPV
LABELV $446
line 981
;980:		}
;981:	}
LABELV $443
line 977
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $445
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $442
line 982
;982:	return NULL;
CNSTP4 0
RETP4
LABELV $441
endproc Menus_FindByName 8 8
export Menus_ShowByName
proc Menus_ShowByName 8 4
line 985
;983:}
;984:
;985:void Menus_ShowByName(const char *p) {
line 986
;986:	menuDef_t *menu = Menus_FindByName(p);
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
line 987
;987:	if (menu) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $450
line 988
;988:		Menus_Activate(menu);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menus_Activate
CALLV
pop
line 989
;989:	}
LABELV $450
line 990
;990:}
LABELV $449
endproc Menus_ShowByName 8 4
export Menus_OpenByName
proc Menus_OpenByName 0 4
line 992
;991:
;992:void Menus_OpenByName(const char *p) {
line 993
;993:	Menus_ActivateByName(p);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 994
;994:}
LABELV $452
endproc Menus_OpenByName 0 4
proc Menu_RunCloseScript 544 8
line 996
;995:
;996:static void Menu_RunCloseScript(menuDef_t *menu) {
line 997
;997:	if (menu && menu->window.flags & WINDOW_VISIBLE && menu->onClose) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $454
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $454
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $454
line 999
;998:		itemDef_t item;
;999:		item.parent = menu;
ADDRLP4 4+228
ADDRFP4 0
INDIRP4
ASGNP4
line 1000
;1000:		Item_RunScript(&item, menu->onClose);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1001
;1001:	}
LABELV $454
line 1002
;1002:}
LABELV $453
endproc Menu_RunCloseScript 544 8
export Menus_CloseByName
proc Menus_CloseByName 12 4
line 1004
;1003:
;1004:void Menus_CloseByName(const char *p) {
line 1005
;1005:	menuDef_t *menu = Menus_FindByName(p);
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
line 1006
;1006:	if (menu != NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $458
line 1007
;1007:		Menu_RunCloseScript(menu);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_RunCloseScript
CALLV
pop
line 1008
;1008:		menu->window.flags &= ~(WINDOW_VISIBLE | WINDOW_HASFOCUS);
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 68
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
line 1009
;1009:	}
LABELV $458
line 1010
;1010:}
LABELV $457
endproc Menus_CloseByName 12 4
export Menus_CloseAll
proc Menus_CloseAll 8 4
line 1012
;1011:
;1012:void Menus_CloseAll() {
line 1014
;1013:	int i;
;1014:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $464
JUMPV
LABELV $461
line 1015
;1015:		Menu_RunCloseScript(&Menus[i]);
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRGP4 Menu_RunCloseScript
CALLV
pop
line 1016
;1016:		Menus[i].window.flags &= ~(WINDOW_HASFOCUS | WINDOW_VISIBLE);
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus+68
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
line 1017
;1017:	}
LABELV $462
line 1014
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $464
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $461
line 1018
;1018:}
LABELV $460
endproc Menus_CloseAll 8 4
export Script_Show
proc Script_Show 8 12
line 1021
;1019:
;1020:
;1021:void Script_Show(itemDef_t *item, char **args) {
line 1023
;1022:	const char *name;
;1023:	if (String_Parse(args, &name)) {
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
EQI4 $467
line 1024
;1024:		Menu_ShowItemByName(item->parent, name, qtrue);
ADDRFP4 0
INDIRP4
CNSTI4 228
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
line 1025
;1025:	}
LABELV $467
line 1026
;1026:}
LABELV $466
endproc Script_Show 8 12
export Script_Hide
proc Script_Hide 8 12
line 1028
;1027:
;1028:void Script_Hide(itemDef_t *item, char **args) {
line 1030
;1029:	const char *name;
;1030:	if (String_Parse(args, &name)) {
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
EQI4 $470
line 1031
;1031:		Menu_ShowItemByName(item->parent, name, qfalse);
ADDRFP4 0
INDIRP4
CNSTI4 228
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
line 1032
;1032:	}
LABELV $470
line 1033
;1033:}
LABELV $469
endproc Script_Hide 8 12
export Script_FadeIn
proc Script_FadeIn 8 12
line 1035
;1034:
;1035:void Script_FadeIn(itemDef_t *item, char **args) {
line 1037
;1036:	const char *name;
;1037:	if (String_Parse(args, &name)) {
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
EQI4 $473
line 1038
;1038:		Menu_FadeItemByName(item->parent, name, qfalse);
ADDRFP4 0
INDIRP4
CNSTI4 228
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
line 1039
;1039:	}
LABELV $473
line 1040
;1040:}
LABELV $472
endproc Script_FadeIn 8 12
export Script_FadeOut
proc Script_FadeOut 8 12
line 1042
;1041:
;1042:void Script_FadeOut(itemDef_t *item, char **args) {
line 1044
;1043:	const char *name;
;1044:	if (String_Parse(args, &name)) {
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
EQI4 $476
line 1045
;1045:		Menu_FadeItemByName(item->parent, name, qtrue);
ADDRFP4 0
INDIRP4
CNSTI4 228
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
line 1046
;1046:	}
LABELV $476
line 1047
;1047:}
LABELV $475
endproc Script_FadeOut 8 12
export Script_Open
proc Script_Open 8 8
line 1051
;1048:
;1049:
;1050:
;1051:void Script_Open(itemDef_t *item, char **args) {
line 1053
;1052:	const char *name;
;1053:	if (String_Parse(args, &name)) {
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
EQI4 $479
line 1054
;1054:		Menus_OpenByName(name);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menus_OpenByName
CALLV
pop
line 1055
;1055:	}
LABELV $479
line 1056
;1056:}
LABELV $478
endproc Script_Open 8 8
export Script_ConditionalOpen
proc Script_ConditionalOpen 32 8
line 1058
;1057:
;1058:void Script_ConditionalOpen(itemDef_t *item, char **args) {
line 1064
;1059:	const char *cvar;
;1060:	const char *name1;
;1061:	const char *name2;
;1062:	float           val;
;1063:
;1064:	if (String_Parse(args, &cvar) && String_Parse(args, &name1) && String_Parse(args, &name2)) {
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
EQI4 $482
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
EQI4 $482
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
EQI4 $482
line 1065
;1065:		val = DC->getCVarValue(cvar);
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
line 1066
;1066:		if (val == 0.f) {
ADDRLP4 12
INDIRF4
CNSTF4 0
NEF4 $484
line 1067
;1067:			Menus_OpenByName(name2);
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 Menus_OpenByName
CALLV
pop
line 1068
;1068:		} else {
ADDRGP4 $485
JUMPV
LABELV $484
line 1069
;1069:			Menus_OpenByName(name1);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Menus_OpenByName
CALLV
pop
line 1070
;1070:		}
LABELV $485
line 1071
;1071:	}
LABELV $482
line 1072
;1072:}
LABELV $481
endproc Script_ConditionalOpen 32 8
export Script_Close
proc Script_Close 8 8
line 1074
;1073:
;1074:void Script_Close(itemDef_t *item, char **args) {
line 1076
;1075:	const char *name;
;1076:	if (String_Parse(args, &name)) {
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
EQI4 $487
line 1077
;1077:		Menus_CloseByName(name);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menus_CloseByName
CALLV
pop
line 1078
;1078:	}
LABELV $487
line 1079
;1079:}
LABELV $486
endproc Script_Close 8 8
export Menu_TransitionItemByName
proc Menu_TransitionItemByName 40 12
line 1081
;1080:
;1081:void Menu_TransitionItemByName(menuDef_t *menu, const char *p, rectDef_t rectFrom, rectDef_t rectTo, int time, float amt) {
line 1084
;1082:	itemDef_t *item;
;1083:	int i;
;1084:	int count = Menu_ItemsMatchingGroup(menu, p);
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
line 1085
;1085:	for (i = 0; i < count; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $493
JUMPV
LABELV $490
line 1086
;1086:		item = Menu_GetMatchingItemByNumber(menu, i, p);
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
line 1087
;1087:		if (item != NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $494
line 1088
;1088:			item->window.flags |= (WINDOW_INTRANSITION | WINDOW_VISIBLE);
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 68
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
line 1089
;1089:			item->window.offsetTime = time;
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRFP4 16
INDIRI4
ASGNI4
line 1090
;1090:			memcpy(&item->window.rectClient, &rectFrom, sizeof(rectDef_t));
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
line 1091
;1091:			memcpy(&item->window.rectEffects, &rectTo, sizeof(rectDef_t));
ADDRLP4 0
INDIRP4
CNSTI4 72
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
line 1092
;1092:			item->window.rectEffects2.x = abs(rectTo.x - rectFrom.x) / amt;
ADDRFP4 12
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
INDIRF4
SUBF4
CVFI4 4
ARGI4
ADDRLP4 24
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 88
ADDP4
ADDRLP4 24
INDIRI4
CVIF4 4
ADDRFP4 20
INDIRF4
DIVF4
ASGNF4
line 1093
;1093:			item->window.rectEffects2.y = abs(rectTo.y - rectFrom.y) / amt;
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
CVFI4 4
ARGI4
ADDRLP4 28
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 28
INDIRI4
CVIF4 4
ADDRFP4 20
INDIRF4
DIVF4
ASGNF4
line 1094
;1094:			item->window.rectEffects2.w = abs(rectTo.w - rectFrom.w) / amt;
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
CVFI4 4
ARGI4
ADDRLP4 32
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
ADDRLP4 32
INDIRI4
CVIF4 4
ADDRFP4 20
INDIRF4
DIVF4
ASGNF4
line 1095
;1095:			item->window.rectEffects2.h = abs(rectTo.h - rectFrom.h) / amt;
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
CVFI4 4
ARGI4
ADDRLP4 36
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
ADDRLP4 36
INDIRI4
CVIF4 4
ADDRFP4 20
INDIRF4
DIVF4
ASGNF4
line 1096
;1096:			Item_UpdatePosition(item);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Item_UpdatePosition
CALLV
pop
line 1097
;1097:		}
LABELV $494
line 1098
;1098:	}
LABELV $491
line 1085
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $493
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $490
line 1099
;1099:}
LABELV $489
endproc Menu_TransitionItemByName 40 12
export Script_Transition
proc Script_Transition 96 24
line 1102
;1100:
;1101:
;1102:void Script_Transition(itemDef_t *item, char **args) {
line 1108
;1103:	const char *name;
;1104:	rectDef_t rectFrom, rectTo;
;1105:	int time;
;1106:	float amt;
;1107:
;1108:	if (String_Parse(args, &name)) {
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
EQI4 $497
line 1109
;1109:		if (Rect_Parse(args, &rectFrom) && Rect_Parse(args, &rectTo) && Int_Parse(args, &time) && Float_Parse(args, &amt)) {
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
EQI4 $499
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
EQI4 $499
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
EQI4 $499
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
EQI4 $499
line 1110
;1110:			Menu_TransitionItemByName(item->parent, name, rectFrom, rectTo, time, amt);
ADDRFP4 0
INDIRP4
CNSTI4 228
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
line 1111
;1111:		}
LABELV $499
line 1112
;1112:	}
LABELV $497
line 1113
;1113:}
LABELV $496
endproc Script_Transition 96 24
export Menu_OrbitItemByName
proc Menu_OrbitItemByName 24 12
line 1116
;1114:
;1115:
;1116:void Menu_OrbitItemByName(menuDef_t *menu, const char *p, float x, float y, float cx, float cy, int time) {
line 1119
;1117:	itemDef_t *item;
;1118:	int i;
;1119:	int count = Menu_ItemsMatchingGroup(menu, p);
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
line 1120
;1120:	for (i = 0; i < count; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $505
JUMPV
LABELV $502
line 1121
;1121:		item = Menu_GetMatchingItemByNumber(menu, i, p);
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
line 1122
;1122:		if (item != NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $506
line 1123
;1123:			item->window.flags |= (WINDOW_ORBITING | WINDOW_VISIBLE);
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 68
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
line 1124
;1124:			item->window.offsetTime = time;
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRFP4 24
INDIRI4
ASGNI4
line 1125
;1125:			item->window.rectEffects.x = cx;
ADDRLP4 0
INDIRP4
CNSTI4 72
ADDP4
ADDRFP4 16
INDIRF4
ASGNF4
line 1126
;1126:			item->window.rectEffects.y = cy;
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRFP4 20
INDIRF4
ASGNF4
line 1127
;1127:			item->window.rectClient.x = x;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 8
INDIRF4
ASGNF4
line 1128
;1128:			item->window.rectClient.y = y;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 12
INDIRF4
ASGNF4
line 1129
;1129:			Item_UpdatePosition(item);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Item_UpdatePosition
CALLV
pop
line 1130
;1130:		}
LABELV $506
line 1131
;1131:	}
LABELV $503
line 1120
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $505
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $502
line 1132
;1132:}
LABELV $501
endproc Menu_OrbitItemByName 24 12
export Script_Orbit
proc Script_Orbit 48 28
line 1135
;1133:
;1134:
;1135:void Script_Orbit(itemDef_t *item, char **args) {
line 1140
;1136:	const char *name;
;1137:	float cx, cy, x, y;
;1138:	int time;
;1139:
;1140:	if (String_Parse(args, &name)) {
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
EQI4 $509
line 1141
;1141:		if (Float_Parse(args, &x) && Float_Parse(args, &y) && Float_Parse(args, &cx) && Float_Parse(args, &cy) && Int_Parse(args, &time)) {
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
EQI4 $511
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
EQI4 $511
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
EQI4 $511
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
EQI4 $511
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
EQI4 $511
line 1142
;1142:			Menu_OrbitItemByName(item->parent, name, x, y, cx, cy, time);
ADDRFP4 0
INDIRP4
CNSTI4 228
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
line 1143
;1143:		}
LABELV $511
line 1144
;1144:	}
LABELV $509
line 1145
;1145:}
LABELV $508
endproc Script_Orbit 48 28
export Script_SetFocus
proc Script_SetFocus 28 8
line 1149
;1146:
;1147:
;1148:
;1149:void Script_SetFocus(itemDef_t *item, char **args) {
line 1153
;1150:	const char *name;
;1151:	itemDef_t *focusItem;
;1152:
;1153:	if (String_Parse(args, &name)) {
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
EQI4 $514
line 1154
;1154:		focusItem = Menu_FindItemByName(item->parent, name);
ADDRFP4 0
INDIRP4
CNSTI4 228
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
line 1155
;1155:		if (focusItem && !(focusItem->window.flags & WINDOW_DECORATION) && !(focusItem->window.flags & WINDOW_HASFOCUS)) {
ADDRLP4 16
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $516
ADDRLP4 16
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $516
ADDRLP4 16
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $516
line 1156
;1156:			Menu_ClearFocus(item->parent);
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ARGP4
ADDRGP4 Menu_ClearFocus
CALLP4
pop
line 1157
;1157:			focusItem->window.flags |= WINDOW_HASFOCUS;
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 68
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
line 1158
;1158:			if (focusItem->onFocus) {
ADDRLP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $518
line 1159
;1159:				Item_RunScript(focusItem, focusItem->onFocus);
ADDRLP4 24
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1160
;1160:			}
LABELV $518
line 1161
;1161:			if (DC->Assets.itemFocusSound) {
ADDRGP4 DC
INDIRP4
CNSTI4 61948
ADDP4
INDIRI4
CNSTI4 0
EQI4 $520
line 1162
;1162:				DC->startLocalSound(DC->Assets.itemFocusSound, CHAN_LOCAL_SOUND);
ADDRLP4 24
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 61948
ADDP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLV
pop
line 1163
;1163:			}
LABELV $520
line 1164
;1164:		}
LABELV $516
line 1165
;1165:	}
LABELV $514
line 1166
;1166:}
LABELV $513
endproc Script_SetFocus 28 8
export Script_SetPlayerModel
proc Script_SetPlayerModel 8 8
line 1168
;1167:
;1168:void Script_SetPlayerModel(itemDef_t *item, char **args) {
line 1170
;1169:	const char *name;
;1170:	if (String_Parse(args, &name)) {
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
EQI4 $523
line 1171
;1171:		DC->setCVar("team_model", name);
ADDRGP4 $525
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
line 1172
;1172:	}
LABELV $523
line 1173
;1173:}
LABELV $522
endproc Script_SetPlayerModel 8 8
export Script_SetPlayerHead
proc Script_SetPlayerHead 8 8
line 1175
;1174:
;1175:void Script_SetPlayerHead(itemDef_t *item, char **args) {
line 1177
;1176:	const char *name;
;1177:	if (String_Parse(args, &name)) {
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
EQI4 $527
line 1178
;1178:		DC->setCVar("team_headmodel", name);
ADDRGP4 $529
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
line 1179
;1179:	}
LABELV $527
line 1180
;1180:}
LABELV $526
endproc Script_SetPlayerHead 8 8
export Script_SetCvar
proc Script_SetCvar 16 8
line 1182
;1181:
;1182:void Script_SetCvar(itemDef_t *item, char **args) {
line 1184
;1183:	const char *cvar, *val;
;1184:	if (String_Parse(args, &cvar) && String_Parse(args, &val)) {
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
EQI4 $531
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
EQI4 $531
line 1185
;1185:		DC->setCVar(cvar, val);
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
line 1186
;1186:	}
LABELV $531
line 1188
;1187:
;1188:}
LABELV $530
endproc Script_SetCvar 16 8
export Script_Exec
proc Script_Exec 12 8
line 1190
;1189:
;1190:void Script_Exec(itemDef_t *item, char **args) {
line 1192
;1191:	const char *val;
;1192:	if (String_Parse(args, &val)) {
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
EQI4 $534
line 1193
;1193:		DC->executeText(EXEC_APPEND, va("%s ; ", val));
ADDRGP4 $536
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
CNSTI4 148
ADDP4
INDIRP4
CALLV
pop
line 1194
;1194:	}
LABELV $534
line 1195
;1195:}
LABELV $533
endproc Script_Exec 12 8
export Script_Play
proc Script_Play 12 8
line 1197
;1196:
;1197:void Script_Play(itemDef_t *item, char **args) {
line 1199
;1198:	const char *val;
;1199:	if (String_Parse(args, &val)) {
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
EQI4 $538
line 1200
;1200:		DC->startLocalSound(DC->registerSound(val, qfalse), CHAN_LOCAL_SOUND);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
CNSTI4 168
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLV
pop
line 1201
;1201:	}
LABELV $538
line 1202
;1202:}
LABELV $537
endproc Script_Play 12 8
export Script_playLooped
proc Script_playLooped 12 8
line 1204
;1203:
;1204:void Script_playLooped(itemDef_t *item, char **args) {
line 1206
;1205:	const char *val;
;1206:	if (String_Parse(args, &val)) {
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
EQI4 $541
line 1207
;1207:		DC->stopBackgroundTrack();
ADDRGP4 DC
INDIRP4
CNSTI4 176
ADDP4
INDIRP4
CALLV
pop
line 1208
;1208:		DC->startBackgroundTrack(val, val);
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
CNSTI4 172
ADDP4
INDIRP4
CALLV
pop
line 1209
;1209:	}
LABELV $541
line 1210
;1210:}
LABELV $540
endproc Script_playLooped 12 8
data
export commandList
align 4
LABELV commandList
address $543
address Script_FadeIn
address $544
address Script_FadeOut
address $545
address Script_Show
address $546
address Script_Hide
address $547
address Script_SetColor
address $548
address Script_Open
address $549
address Script_ConditionalOpen
address $550
address Script_Close
address $551
address Script_SetAsset
address $552
address Script_SetBackground
address $553
address Script_SetItemColor
address $554
address Script_SetTeamColor
address $555
address Script_SetFocus
address $556
address Script_SetPlayerModel
address $557
address Script_SetPlayerHead
address $558
address Script_Transition
address $559
address Script_SetCvar
address $560
address Script_Exec
address $561
address Script_Play
address $562
address Script_playLooped
address $563
address Script_Orbit
export scriptCommandCount
align 4
LABELV scriptCommandCount
byte 4 21
export Item_RunScript
code
proc Item_RunScript 1056 12
line 1241
;1211:
;1212:
;1213:commandDef_t commandList[] =
;1214:{
;1215:  {"fadein", &Script_FadeIn},                   // group/name
;1216:  {"fadeout", &Script_FadeOut},                 // group/name
;1217:  {"show", &Script_Show},                       // group/name
;1218:  {"hide", &Script_Hide},                       // group/name
;1219:  {"setcolor", &Script_SetColor},               // works on this
;1220:  {"open", &Script_Open},                       // menu
;1221:	{"conditionalopen", &Script_ConditionalOpen},	// menu
;1222:  {"close", &Script_Close},                     // menu
;1223:  {"setasset", &Script_SetAsset},               // works on this
;1224:  {"setbackground", &Script_SetBackground},     // works on this
;1225:  {"setitemcolor", &Script_SetItemColor},       // group/name
;1226:  {"setteamcolor", &Script_SetTeamColor},       // sets this background color to team color
;1227:  {"setfocus", &Script_SetFocus},               // sets this background color to team color
;1228:  {"setplayermodel", &Script_SetPlayerModel},   // sets this background color to team color
;1229:  {"setplayerhead", &Script_SetPlayerHead},     // sets this background color to team color
;1230:  {"transition", &Script_Transition},           // group/name
;1231:  {"setcvar", &Script_SetCvar},           // group/name
;1232:  {"exec", &Script_Exec},           // group/name
;1233:  {"play", &Script_Play},           // group/name
;1234:  {"playlooped", &Script_playLooped},           // group/name
;1235:  {"orbit", &Script_Orbit}                      // group/name
;1236:};
;1237:
;1238:int scriptCommandCount = sizeof(commandList) / sizeof(commandDef_t);
;1239:
;1240:
;1241:void Item_RunScript(itemDef_t *item, const char *s) {
line 1245
;1242:	char script[1024], *p;
;1243:	int i;
;1244:	qboolean bRan;
;1245:	memset(script, 0, sizeof(script));
ADDRLP4 12
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1246
;1246:	if (item && s && s[0]) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $565
ADDRLP4 1036
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 1036
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $565
ADDRLP4 1036
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $565
line 1247
;1247:		Q_strcat(script, 1024, s);
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
line 1248
;1248:		p = script;
ADDRLP4 8
ADDRLP4 12
ASGNP4
ADDRGP4 $568
JUMPV
LABELV $567
line 1249
;1249:		while (1) {
line 1252
;1250:			const char *command;
;1251:			// expect command then arguments, ; ends command, NULL ends script
;1252:			if (!String_Parse(&p, &command)) {
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
NEI4 $570
line 1253
;1253:				return;
ADDRGP4 $564
JUMPV
LABELV $570
line 1256
;1254:			}
;1255:
;1256:			if (command[0] == ';' && command[1] == '\0') {
ADDRLP4 1048
ADDRLP4 1040
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
INDIRI1
CVII4 1
CNSTI4 59
NEI4 $572
ADDRLP4 1048
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $572
line 1257
;1257:				continue;
ADDRGP4 $568
JUMPV
LABELV $572
line 1260
;1258:			}
;1259:
;1260:			bRan = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1261
;1261:			for (i = 0; i < scriptCommandCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $577
JUMPV
LABELV $574
line 1262
;1262:				if (Q_stricmp(command, commandList[i].name) == 0) {
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
NEI4 $578
line 1263
;1263:					(commandList[i].handler(item, &p));
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
line 1264
;1264:					bRan = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1265
;1265:					break;
ADDRGP4 $576
JUMPV
LABELV $578
line 1267
;1266:				}
;1267:			}
LABELV $575
line 1261
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $577
ADDRLP4 0
INDIRI4
ADDRGP4 scriptCommandCount
INDIRI4
LTI4 $574
LABELV $576
line 1269
;1268:			// not in our auto list, pass to handler
;1269:			if (!bRan) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $581
line 1270
;1270:				DC->runScript(&p);
ADDRLP4 8
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 80
ADDP4
INDIRP4
CALLV
pop
line 1271
;1271:			}
LABELV $581
line 1272
;1272:		}
LABELV $568
line 1249
ADDRGP4 $567
JUMPV
line 1273
;1273:	}
LABELV $565
line 1274
;1274:}
LABELV $564
endproc Item_RunScript 1056 12
export Item_EnableShowViaCvar
proc Item_EnableShowViaCvar 2072 12
line 1277
;1275:
;1276:
;1277:qboolean Item_EnableShowViaCvar(itemDef_t *item, int flag) {
line 1279
;1278:	char script[1024], *p;
;1279:	memset(script, 0, sizeof(script));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1280
;1280:	if (item && item->enableCvar && *item->enableCvar && item->cvarTest && *item->cvarTest) {
ADDRLP4 1028
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $584
ADDRLP4 1028
INDIRP4
CNSTI4 272
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $584
ADDRLP4 1028
INDIRP4
CNSTI4 272
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $584
ADDRLP4 1028
INDIRP4
CNSTI4 268
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $584
ADDRLP4 1028
INDIRP4
CNSTI4 268
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $584
line 1282
;1281:		char buff[1024];
;1282:		DC->getCVarString(item->cvarTest, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 268
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
line 1284
;1283:
;1284:		Q_strcat(script, 1024, item->enableCvar);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 272
ADDP4
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 1285
;1285:		p = script;
ADDRLP4 0
ADDRLP4 4
ASGNP4
ADDRGP4 $587
JUMPV
LABELV $586
line 1286
;1286:		while (1) {
line 1289
;1287:			const char *val;
;1288:			// expect value then ; or NULL, NULL ends list
;1289:			if (!String_Parse(&p, &val)) {
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
NEI4 $589
line 1290
;1290:				return (item->cvarFlags & flag) ? qfalse : qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
BANDI4
CNSTI4 0
EQI4 $592
ADDRLP4 2064
CNSTI4 0
ASGNI4
ADDRGP4 $593
JUMPV
LABELV $592
ADDRLP4 2064
CNSTI4 1
ASGNI4
LABELV $593
ADDRLP4 2064
INDIRI4
RETI4
ADDRGP4 $583
JUMPV
LABELV $589
line 1293
;1291:			}
;1292:
;1293:			if (val[0] == ';' && val[1] == '\0') {
ADDRLP4 2064
ADDRLP4 2056
INDIRP4
ASGNP4
ADDRLP4 2064
INDIRP4
INDIRI1
CVII4 1
CNSTI4 59
NEI4 $594
ADDRLP4 2064
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $594
line 1294
;1294:				continue;
ADDRGP4 $587
JUMPV
LABELV $594
line 1298
;1295:			}
;1296:
;1297:			// enable it if any of the values are true
;1298:			if (item->cvarFlags & flag) {
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
BANDI4
CNSTI4 0
EQI4 $596
line 1299
;1299:				if (Q_stricmp(buff, val) == 0) {
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
NEI4 $597
line 1300
;1300:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $583
JUMPV
line 1302
;1301:				}
;1302:			} else {
LABELV $596
line 1304
;1303:				// disable it if any of the values are true
;1304:				if (Q_stricmp(buff, val) == 0) {
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
NEI4 $600
line 1305
;1305:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $583
JUMPV
LABELV $600
line 1307
;1306:				}
;1307:			}
LABELV $597
line 1309
;1308:
;1309:		}
LABELV $587
line 1286
ADDRGP4 $586
JUMPV
line 1310
;1310:		return (item->cvarFlags & flag) ? qfalse : qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
BANDI4
CNSTI4 0
EQI4 $603
ADDRLP4 2056
CNSTI4 0
ASGNI4
ADDRGP4 $604
JUMPV
LABELV $603
ADDRLP4 2056
CNSTI4 1
ASGNI4
LABELV $604
ADDRLP4 2056
INDIRI4
RETI4
ADDRGP4 $583
JUMPV
LABELV $584
line 1312
;1311:	}
;1312:	return qtrue;
CNSTI4 1
RETI4
LABELV $583
endproc Item_EnableShowViaCvar 2072 12
export Item_SetFocus
proc Item_SetFocus 72 12
line 1317
;1313:}
;1314:
;1315:
;1316:// will optionaly set focus to this item 
;1317:qboolean Item_SetFocus(itemDef_t *item, float x, float y) {
line 1320
;1318:	int i;
;1319:	itemDef_t *oldFocus;
;1320:	sfxHandle_t *sfx = &DC->Assets.itemFocusSound;
ADDRLP4 8
ADDRGP4 DC
INDIRP4
CNSTI4 61948
ADDP4
ASGNP4
line 1321
;1321:	qboolean playSound = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 1324
;1322:	menuDef_t *parent; // bk001206: = (menuDef_t*)item->parent;
;1323:	// sanity check, non-null, not a decoration and does not already have the focus
;1324:	if (item == NULL || item->window.flags & WINDOW_DECORATION || item->window.flags & WINDOW_HASFOCUS || !(item->window.flags & WINDOW_VISIBLE)) {
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $610
ADDRLP4 20
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $610
ADDRLP4 20
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $610
ADDRLP4 20
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $606
LABELV $610
line 1325
;1325:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $605
JUMPV
LABELV $606
line 1329
;1326:	}
;1327:
;1328:	// bk001206 - this can be NULL.
;1329:	parent = (menuDef_t *)item->parent;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 1332
;1330:
;1331:	// items can be enabled and disabled based on cvars
;1332:	if (item->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(item, CVAR_ENABLE)) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $611
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
NEI4 $611
line 1333
;1333:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $605
JUMPV
LABELV $611
line 1336
;1334:	}
;1335:
;1336:	if (item->cvarFlags & (CVAR_SHOW | CVAR_HIDE) && !Item_EnableShowViaCvar(item, CVAR_SHOW)) {
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $613
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
NEI4 $613
line 1337
;1337:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $605
JUMPV
LABELV $613
line 1340
;1338:	}
;1339:
;1340:	oldFocus = Menu_ClearFocus(item->parent);
ADDRFP4 0
INDIRP4
CNSTI4 228
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
line 1342
;1341:
;1342:	if (item->type == ITEM_TYPE_TEXT) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
NEI4 $615
line 1344
;1343:		rectDef_t r;
;1344:		r = item->textRect;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRB
ASGNB 16
line 1345
;1345:		r.y -= r.h;
ADDRLP4 44+4
ADDRLP4 44+4
INDIRF4
ADDRLP4 44+12
INDIRF4
SUBF4
ASGNF4
line 1346
;1346:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 44
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $619
line 1347
;1347:			item->window.flags |= WINDOW_HASFOCUS;
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 1348
;1348:			if (item->focusSound) {
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
CNSTI4 0
EQI4 $621
line 1349
;1349:				sfx = &item->focusSound;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
ASGNP4
line 1350
;1350:			}
LABELV $621
line 1351
;1351:			playSound = qtrue;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 1352
;1352:		} else {
ADDRGP4 $616
JUMPV
LABELV $619
line 1353
;1353:			if (oldFocus) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $616
line 1354
;1354:				oldFocus->window.flags |= WINDOW_HASFOCUS;
ADDRLP4 64
ADDRLP4 16
INDIRP4
CNSTI4 68
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
line 1355
;1355:				if (oldFocus->onFocus) {
ADDRLP4 16
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $616
line 1356
;1356:					Item_RunScript(oldFocus, oldFocus->onFocus);
ADDRLP4 68
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1357
;1357:				}
line 1358
;1358:			}
line 1359
;1359:		}
line 1360
;1360:	} else {
ADDRGP4 $616
JUMPV
LABELV $615
line 1361
;1361:		item->window.flags |= WINDOW_HASFOCUS;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 1362
;1362:		if (item->onFocus) {
ADDRFP4 0
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $627
line 1363
;1363:			Item_RunScript(item, item->onFocus);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
CNSTI4 256
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1364
;1364:		}
LABELV $627
line 1365
;1365:		if (item->focusSound) {
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
CNSTI4 0
EQI4 $629
line 1366
;1366:			sfx = &item->focusSound;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
ASGNP4
line 1367
;1367:		}
LABELV $629
line 1368
;1368:		playSound = qtrue;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 1369
;1369:	}
LABELV $616
line 1371
;1370:
;1371:	if (playSound && sfx) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $631
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $631
line 1372
;1372:		DC->startLocalSound(*sfx, CHAN_LOCAL_SOUND);
ADDRLP4 8
INDIRP4
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 112
ADDP4
INDIRP4
CALLV
pop
line 1373
;1373:	}
LABELV $631
line 1375
;1374:
;1375:	for (i = 0; i < parent->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $636
JUMPV
LABELV $633
line 1376
;1376:		if (parent->items[i] == item) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $637
line 1377
;1377:			parent->cursorItem = i;
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1378
;1378:			break;
ADDRGP4 $635
JUMPV
LABELV $637
line 1380
;1379:		}
;1380:	}
LABELV $634
line 1375
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $636
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $633
LABELV $635
line 1382
;1381:
;1382:	return qtrue;
CNSTI4 1
RETI4
LABELV $605
endproc Item_SetFocus 72 12
export Item_ListBox_MaxScroll
proc Item_ListBox_MaxScroll 16 4
line 1385
;1383:}
;1384:
;1385:int Item_ListBox_MaxScroll(itemDef_t *item) {
line 1386
;1386:	listBoxDef_t *listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1387
;1387:	int count = DC->feederCount(item->special);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 12
INDIRI4
ASGNI4
line 1390
;1388:	int max;
;1389:
;1390:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $640
line 1391
;1391:		max = count - (item->window.rect.w / listPtr->elementWidth) + 1;
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
CNSTI4 16
ADDP4
INDIRF4
DIVF4
SUBF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1392
;1392:	} else {
ADDRGP4 $641
JUMPV
LABELV $640
line 1393
;1393:		max = count - (item->window.rect.h / listPtr->elementHeight) + 1;
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
CNSTI4 20
ADDP4
INDIRF4
DIVF4
SUBF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 1394
;1394:	}
LABELV $641
line 1395
;1395:	if (max < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $642
line 1396
;1396:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $639
JUMPV
LABELV $642
line 1398
;1397:	}
;1398:	return max;
ADDRLP4 0
INDIRI4
RETI4
LABELV $639
endproc Item_ListBox_MaxScroll 16 4
export Item_ListBox_ThumbPosition
proc Item_ListBox_ThumbPosition 20 4
line 1401
;1399:}
;1400:
;1401:int Item_ListBox_ThumbPosition(itemDef_t *item) {
line 1403
;1402:	float max, pos, size;
;1403:	listBoxDef_t *listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1405
;1404:
;1405:	max = Item_ListBox_MaxScroll(item);
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
line 1406
;1406:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $645
line 1407
;1407:		size = item->window.rect.w - (SCROLLBAR_SIZE * 2) - 2;
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
line 1408
;1408:		if (max > 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $647
line 1409
;1409:			pos = (size - SCROLLBAR_SIZE) / (float)max;
ADDRLP4 0
ADDRLP4 12
INDIRF4
CNSTF4 1098907648
SUBF4
ADDRLP4 4
INDIRF4
DIVF4
ASGNF4
line 1410
;1410:		} else {
ADDRGP4 $648
JUMPV
LABELV $647
line 1411
;1411:			pos = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1412
;1412:		}
LABELV $648
line 1413
;1413:		pos *= listPtr->startPos;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRP4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 1414
;1414:		return item->window.rect.x + 1 + SCROLLBAR_SIZE + pos;
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
ADDRGP4 $644
JUMPV
LABELV $645
line 1415
;1415:	} else {
line 1416
;1416:		size = item->window.rect.h - (SCROLLBAR_SIZE * 2) - 2;
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
line 1417
;1417:		if (max > 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $649
line 1418
;1418:			pos = (size - SCROLLBAR_SIZE) / (float)max;
ADDRLP4 0
ADDRLP4 12
INDIRF4
CNSTF4 1098907648
SUBF4
ADDRLP4 4
INDIRF4
DIVF4
ASGNF4
line 1419
;1419:		} else {
ADDRGP4 $650
JUMPV
LABELV $649
line 1420
;1420:			pos = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1421
;1421:		}
LABELV $650
line 1422
;1422:		pos *= listPtr->startPos;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRP4
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 1423
;1423:		return item->window.rect.y + 1 + SCROLLBAR_SIZE + pos;
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
LABELV $644
endproc Item_ListBox_ThumbPosition 20 4
export Item_ListBox_ThumbDrawPosition
proc Item_ListBox_ThumbDrawPosition 20 4
line 1427
;1424:	}
;1425:}
;1426:
;1427:int Item_ListBox_ThumbDrawPosition(itemDef_t *item) {
line 1430
;1428:	int min, max;
;1429:
;1430:	if (itemCapture == item) {
ADDRGP4 itemCapture
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $652
line 1431
;1431:		if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $654
line 1432
;1432:			min = item->window.rect.x + SCROLLBAR_SIZE + 1;
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
line 1433
;1433:			max = item->window.rect.x + item->window.rect.w - 2 * SCROLLBAR_SIZE - 1;
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
line 1434
;1434:			if (DC->cursorx >= min + SCROLLBAR_SIZE / 2 && DC->cursorx <= max + SCROLLBAR_SIZE / 2) {
ADDRLP4 12
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1090519040
ADDF4
LTF4 $656
ADDRLP4 12
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRI4
CVIF4 4
CNSTF4 1090519040
ADDF4
GTF4 $656
line 1435
;1435:				return DC->cursorx - SCROLLBAR_SIZE / 2;
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1090519040
SUBF4
CVFI4 4
RETI4
ADDRGP4 $651
JUMPV
LABELV $656
line 1436
;1436:			} else {
line 1437
;1437:				return Item_ListBox_ThumbPosition(item);
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
ADDRGP4 $651
JUMPV
LABELV $654
line 1439
;1438:			}
;1439:		} else {
line 1440
;1440:			min = item->window.rect.y + SCROLLBAR_SIZE + 1;
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
line 1441
;1441:			max = item->window.rect.y + item->window.rect.h - 2 * SCROLLBAR_SIZE - 1;
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
line 1442
;1442:			if (DC->cursory >= min + SCROLLBAR_SIZE / 2 && DC->cursory <= max + SCROLLBAR_SIZE / 2) {
ADDRLP4 12
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1090519040
ADDF4
LTF4 $658
ADDRLP4 12
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRI4
CVIF4 4
CNSTF4 1090519040
ADDF4
GTF4 $658
line 1443
;1443:				return DC->cursory - SCROLLBAR_SIZE / 2;
ADDRGP4 DC
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1090519040
SUBF4
CVFI4 4
RETI4
ADDRGP4 $651
JUMPV
LABELV $658
line 1444
;1444:			} else {
line 1445
;1445:				return Item_ListBox_ThumbPosition(item);
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
ADDRGP4 $651
JUMPV
LABELV $652
line 1448
;1446:			}
;1447:		}
;1448:	} else {
line 1449
;1449:		return Item_ListBox_ThumbPosition(item);
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
LABELV $651
endproc Item_ListBox_ThumbDrawPosition 20 4
export Item_Slider_ThumbPosition
proc Item_Slider_ThumbPosition 24 4
line 1453
;1450:	}
;1451:}
;1452:
;1453:float Item_Slider_ThumbPosition(itemDef_t *item) {
line 1455
;1454:	float value, range, x;
;1455:	editFieldDef_t *editDef = item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1457
;1456:
;1457:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $661
line 1458
;1458:		x = item->textRect.x + item->textRect.w + 8;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 1459
;1459:	} else {
ADDRGP4 $662
JUMPV
LABELV $661
line 1460
;1460:		x = item->window.rect.x;
ADDRLP4 8
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 1461
;1461:	}
LABELV $662
line 1463
;1462:
;1463:	if (editDef == NULL && item->cvar) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $663
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $663
line 1464
;1464:		return x;
ADDRLP4 8
INDIRF4
RETF4
ADDRGP4 $660
JUMPV
LABELV $663
line 1467
;1465:	}
;1466:
;1467:	value = DC->getCVarValue(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 264
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
line 1469
;1468:
;1469:	if (value < editDef->minVal) {
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRP4
INDIRF4
GEF4 $665
line 1470
;1470:		value = editDef->minVal;
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRF4
ASGNF4
line 1471
;1471:	} else if (value > editDef->maxVal) {
ADDRGP4 $666
JUMPV
LABELV $665
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
LEF4 $667
line 1472
;1472:		value = editDef->maxVal;
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1473
;1473:	}
LABELV $667
LABELV $666
line 1475
;1474:
;1475:	range = editDef->maxVal - editDef->minVal;
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
line 1476
;1476:	value -= editDef->minVal;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 4
INDIRP4
INDIRF4
SUBF4
ASGNF4
line 1477
;1477:	value /= range;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
DIVF4
ASGNF4
line 1479
;1478:	//value /= (editDef->maxVal - editDef->minVal);
;1479:	value *= SLIDER_WIDTH;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1119879168
MULF4
ASGNF4
line 1480
;1480:	x += value;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 1483
;1481:	// vm fuckage
;1482:	//x = x + (((float)value / editDef->maxVal) * SLIDER_WIDTH);
;1483:	return x;
ADDRLP4 8
INDIRF4
RETF4
LABELV $660
endproc Item_Slider_ThumbPosition 24 4
export Item_Slider_OverSlider
proc Item_Slider_OverSlider 24 12
line 1486
;1484:}
;1485:
;1486:int Item_Slider_OverSlider(itemDef_t *item, float x, float y) {
line 1489
;1487:	rectDef_t r;
;1488:
;1489:	r.x = Item_Slider_ThumbPosition(item) - (SLIDER_THUMB_WIDTH / 2);
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
line 1490
;1490:	r.y = item->window.rect.y - 2;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 1491
;1491:	r.w = SLIDER_THUMB_WIDTH;
ADDRLP4 0+8
CNSTF4 1094713344
ASGNF4
line 1492
;1492:	r.h = SLIDER_THUMB_HEIGHT;
ADDRLP4 0+12
CNSTF4 1101004800
ASGNF4
line 1494
;1493:
;1494:	if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $673
line 1495
;1495:		return WINDOW_LB_THUMB;
CNSTI4 8192
RETI4
ADDRGP4 $669
JUMPV
LABELV $673
line 1497
;1496:	}
;1497:	return 0;
CNSTI4 0
RETI4
LABELV $669
endproc Item_Slider_OverSlider 24 12
export Item_ListBox_OverLB
proc Item_ListBox_OverLB 72 12
line 1500
;1498:}
;1499:
;1500:int Item_ListBox_OverLB(itemDef_t *item, float x, float y) {
line 1506
;1501:	rectDef_t r;
;1502:	listBoxDef_t *listPtr;
;1503:	int thumbstart;
;1504:	int count;
;1505:
;1506:	count = DC->feederCount(item->special);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 28
INDIRI4
ASGNI4
line 1507
;1507:	listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1508
;1508:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $676
line 1510
;1509:		// check if on left arrow
;1510:		r.x = item->window.rect.x;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 1511
;1511:		r.y = item->window.rect.y + item->window.rect.h - SCROLLBAR_SIZE;
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
line 1512
;1512:		r.h = r.w = SCROLLBAR_SIZE;
ADDRLP4 36
CNSTF4 1098907648
ASGNF4
ADDRLP4 0+8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0+12
ADDRLP4 36
INDIRF4
ASGNF4
line 1513
;1513:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
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
CNSTI4 0
EQI4 $681
line 1514
;1514:			return WINDOW_LB_LEFTARROW;
CNSTI4 2048
RETI4
ADDRGP4 $675
JUMPV
LABELV $681
line 1517
;1515:		}
;1516:		// check if on right arrow
;1517:		r.x = item->window.rect.x + item->window.rect.w - SCROLLBAR_SIZE;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 44
INDIRP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1518
;1518:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $683
line 1519
;1519:			return WINDOW_LB_RIGHTARROW;
CNSTI4 4096
RETI4
ADDRGP4 $675
JUMPV
LABELV $683
line 1522
;1520:		}
;1521:		// check if on thumb
;1522:		thumbstart = Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 Item_ListBox_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 52
INDIRI4
ASGNI4
line 1523
;1523:		r.x = thumbstart;
ADDRLP4 0
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
line 1524
;1524:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 56
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $685
line 1525
;1525:			return WINDOW_LB_THUMB;
CNSTI4 8192
RETI4
ADDRGP4 $675
JUMPV
LABELV $685
line 1527
;1526:		}
;1527:		r.x = item->window.rect.x + SCROLLBAR_SIZE;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1528
;1528:		r.w = thumbstart - r.x;
ADDRLP4 0+8
ADDRLP4 16
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
line 1529
;1529:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $688
line 1530
;1530:			return WINDOW_LB_PGUP;
CNSTI4 16384
RETI4
ADDRGP4 $675
JUMPV
LABELV $688
line 1532
;1531:		}
;1532:		r.x = thumbstart + SCROLLBAR_SIZE;
ADDRLP4 0
ADDRLP4 16
INDIRI4
CVIF4 4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1533
;1533:		r.w = item->window.rect.x + item->window.rect.w - SCROLLBAR_SIZE;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
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
ASGNF4
line 1534
;1534:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $677
line 1535
;1535:			return WINDOW_LB_PGDN;
CNSTI4 32768
RETI4
ADDRGP4 $675
JUMPV
line 1537
;1536:		}
;1537:	} else {
LABELV $676
line 1538
;1538:		r.x = item->window.rect.x + item->window.rect.w - SCROLLBAR_SIZE;
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
line 1539
;1539:		r.y = item->window.rect.y;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1540
;1540:		r.h = r.w = SCROLLBAR_SIZE;
ADDRLP4 36
CNSTF4 1098907648
ASGNF4
ADDRLP4 0+8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0+12
ADDRLP4 36
INDIRF4
ASGNF4
line 1541
;1541:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
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
CNSTI4 0
EQI4 $696
line 1542
;1542:			return WINDOW_LB_LEFTARROW;
CNSTI4 2048
RETI4
ADDRGP4 $675
JUMPV
LABELV $696
line 1544
;1543:		}
;1544:		r.y = item->window.rect.y + item->window.rect.h - SCROLLBAR_SIZE;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1545
;1545:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $699
line 1546
;1546:			return WINDOW_LB_RIGHTARROW;
CNSTI4 4096
RETI4
ADDRGP4 $675
JUMPV
LABELV $699
line 1548
;1547:		}
;1548:		thumbstart = Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 Item_ListBox_ThumbPosition
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 52
INDIRI4
ASGNI4
line 1549
;1549:		r.y = thumbstart;
ADDRLP4 0+4
ADDRLP4 16
INDIRI4
CVIF4 4
ASGNF4
line 1550
;1550:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 56
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $702
line 1551
;1551:			return WINDOW_LB_THUMB;
CNSTI4 8192
RETI4
ADDRGP4 $675
JUMPV
LABELV $702
line 1553
;1552:		}
;1553:		r.y = item->window.rect.y + SCROLLBAR_SIZE;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1554
;1554:		r.h = thumbstart - r.y;
ADDRLP4 0+12
ADDRLP4 16
INDIRI4
CVIF4 4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
line 1555
;1555:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 60
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $707
line 1556
;1556:			return WINDOW_LB_PGUP;
CNSTI4 16384
RETI4
ADDRGP4 $675
JUMPV
LABELV $707
line 1558
;1557:		}
;1558:		r.y = thumbstart + SCROLLBAR_SIZE;
ADDRLP4 0+4
ADDRLP4 16
INDIRI4
CVIF4 4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1559
;1559:		r.h = item->window.rect.y + item->window.rect.h - SCROLLBAR_SIZE;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+12
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
ASGNF4
line 1560
;1560:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $711
line 1561
;1561:			return WINDOW_LB_PGDN;
CNSTI4 32768
RETI4
ADDRGP4 $675
JUMPV
LABELV $711
line 1563
;1562:		}
;1563:	}
LABELV $677
line 1564
;1564:	return 0;
CNSTI4 0
RETI4
LABELV $675
endproc Item_ListBox_OverLB 72 12
export Item_ListBox_MouseEnter
proc Item_ListBox_MouseEnter 52 12
line 1568
;1565:}
;1566:
;1567:
;1568:void Item_ListBox_MouseEnter(itemDef_t *item, float x, float y) {
line 1570
;1569:	rectDef_t r;
;1570:	listBoxDef_t *listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1572
;1571:
;1572:	item->window.flags &= ~(WINDOW_LB_LEFTARROW | WINDOW_LB_RIGHTARROW | WINDOW_LB_THUMB | WINDOW_LB_PGUP | WINDOW_LB_PGDN);
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 1573
;1573:	item->window.flags |= Item_ListBox_OverLB(item, x, y);
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
CNSTI4 68
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
line 1575
;1574:
;1575:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $714
line 1576
;1576:		if (!(item->window.flags & (WINDOW_LB_LEFTARROW | WINDOW_LB_RIGHTARROW | WINDOW_LB_THUMB | WINDOW_LB_PGUP | WINDOW_LB_PGDN))) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 63488
BANDI4
CNSTI4 0
NEI4 $715
line 1578
;1577:			// check for selection hit as we have exausted buttons and thumb
;1578:			if (listPtr->elementStyle == LISTBOX_IMAGE) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 1
NEI4 $715
line 1579
;1579:				r.x = item->window.rect.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 1580
;1580:				r.y = item->window.rect.y;
ADDRLP4 4+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1581
;1581:				r.h = item->window.rect.h - SCROLLBAR_SIZE;
ADDRLP4 4+12
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1582
;1582:				r.w = item->window.rect.w - listPtr->drawPadding;
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
line 1583
;1583:				if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $715
line 1584
;1584:					listPtr->cursorPos = (int)((x - r.x) / listPtr->elementWidth) + listPtr->startPos;
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
CNSTI4 16
ADDP4
INDIRF4
DIVF4
CVFI4 4
ADDRLP4 40
INDIRP4
INDIRI4
ADDI4
ASGNI4
line 1585
;1585:					if (listPtr->cursorPos >= listPtr->endPos) {
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
LTI4 $715
line 1586
;1586:						listPtr->cursorPos = listPtr->endPos;
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
line 1587
;1587:					}
line 1588
;1588:				}
line 1589
;1589:			} else {
line 1591
;1590:				// text hit.. 
;1591:			}
line 1592
;1592:		}
line 1593
;1593:	} else if (!(item->window.flags & (WINDOW_LB_LEFTARROW | WINDOW_LB_RIGHTARROW | WINDOW_LB_THUMB | WINDOW_LB_PGUP | WINDOW_LB_PGDN))) {
ADDRGP4 $715
JUMPV
LABELV $714
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 63488
BANDI4
CNSTI4 0
NEI4 $727
line 1594
;1594:		r.x = item->window.rect.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 1595
;1595:		r.y = item->window.rect.y;
ADDRLP4 4+4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1596
;1596:		r.w = item->window.rect.w - SCROLLBAR_SIZE;
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
ASGNF4
line 1597
;1597:		r.h = item->window.rect.h - listPtr->drawPadding;
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
line 1598
;1598:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $732
line 1599
;1599:			listPtr->cursorPos = (int)((y - 2 - r.y) / listPtr->elementHeight) + listPtr->startPos;
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
line 1600
;1600:			if (listPtr->cursorPos > listPtr->endPos) {
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
LEI4 $735
line 1601
;1601:				listPtr->cursorPos = listPtr->endPos;
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
line 1602
;1602:			}
LABELV $735
line 1603
;1603:		}
LABELV $732
line 1604
;1604:	}
LABELV $727
LABELV $715
line 1605
;1605:}
LABELV $713
endproc Item_ListBox_MouseEnter 52 12
export Item_MouseEnter
proc Item_MouseEnter 44 12
line 1607
;1606:
;1607:void Item_MouseEnter(itemDef_t *item, float x, float y) {
line 1609
;1608:	rectDef_t r;
;1609:	if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $738
line 1610
;1610:		r = item->textRect;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRB
ASGNB 16
line 1611
;1611:		r.y -= r.h;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 0+12
INDIRF4
SUBF4
ASGNF4
line 1615
;1612:		// in the text rect?
;1613:
;1614:		// items can be enabled and disabled based on cvars
;1615:		if (item->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(item, CVAR_ENABLE)) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $742
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
NEI4 $742
line 1616
;1616:			return;
ADDRGP4 $737
JUMPV
LABELV $742
line 1619
;1617:		}
;1618:
;1619:		if (item->cvarFlags & (CVAR_SHOW | CVAR_HIDE) && !Item_EnableShowViaCvar(item, CVAR_SHOW)) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $744
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
NEI4 $744
line 1620
;1620:			return;
ADDRGP4 $737
JUMPV
LABELV $744
line 1623
;1621:		}
;1622:
;1623:		if (Rect_ContainsPoint(&r, x, y)) {
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $746
line 1624
;1624:			if (!(item->window.flags & WINDOW_MOUSEOVERTEXT)) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
NEI4 $748
line 1625
;1625:				Item_RunScript(item, item->mouseEnterText);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 236
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1626
;1626:				item->window.flags |= WINDOW_MOUSEOVERTEXT;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 1627
;1627:			}
LABELV $748
line 1628
;1628:			if (!(item->window.flags & WINDOW_MOUSEOVER)) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $747
line 1629
;1629:				Item_RunScript(item, item->mouseEnter);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 244
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1630
;1630:				item->window.flags |= WINDOW_MOUSEOVER;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 1631
;1631:			}
line 1633
;1632:
;1633:		} else {
ADDRGP4 $747
JUMPV
LABELV $746
line 1635
;1634:			// not in the text rect
;1635:			if (item->window.flags & WINDOW_MOUSEOVERTEXT) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $752
line 1637
;1636:				// if we were
;1637:				Item_RunScript(item, item->mouseExitText);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1638
;1638:				item->window.flags &= ~WINDOW_MOUSEOVERTEXT;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 1639
;1639:			}
LABELV $752
line 1640
;1640:			if (!(item->window.flags & WINDOW_MOUSEOVER)) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $754
line 1641
;1641:				Item_RunScript(item, item->mouseEnter);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
CNSTI4 244
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1642
;1642:				item->window.flags |= WINDOW_MOUSEOVER;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 1643
;1643:			}
LABELV $754
line 1645
;1644:
;1645:			if (item->type == ITEM_TYPE_LISTBOX) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 6
NEI4 $756
line 1646
;1646:				Item_ListBox_MouseEnter(item, x, y);
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
line 1647
;1647:			}
LABELV $756
line 1648
;1648:		}
LABELV $747
line 1649
;1649:	}
LABELV $738
line 1650
;1650:}
LABELV $737
endproc Item_MouseEnter 44 12
export Item_MouseLeave
proc Item_MouseLeave 8 8
line 1652
;1651:
;1652:void Item_MouseLeave(itemDef_t *item) {
line 1653
;1653:	if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $759
line 1654
;1654:		if (item->window.flags & WINDOW_MOUSEOVERTEXT) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $761
line 1655
;1655:			Item_RunScript(item, item->mouseExitText);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1656
;1656:			item->window.flags &= ~WINDOW_MOUSEOVERTEXT;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 1657
;1657:		}
LABELV $761
line 1658
;1658:		Item_RunScript(item, item->mouseExit);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1659
;1659:		item->window.flags &= ~(WINDOW_LB_RIGHTARROW | WINDOW_LB_LEFTARROW);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 1660
;1660:	}
LABELV $759
line 1661
;1661:}
LABELV $758
endproc Item_MouseLeave 8 8
export Menu_HitTest
proc Menu_HitTest 8 12
line 1663
;1662:
;1663:itemDef_t *Menu_HitTest(menuDef_t *menu, float x, float y) {
line 1665
;1664:	int i;
;1665:	for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $767
JUMPV
LABELV $764
line 1666
;1666:		if (Rect_ContainsPoint(&menu->items[i]->window.rect, x, y)) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
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
ADDRLP4 4
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $768
line 1667
;1667:			return menu->items[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $763
JUMPV
LABELV $768
line 1669
;1668:		}
;1669:	}
LABELV $765
line 1665
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $767
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $764
line 1670
;1670:	return NULL;
CNSTP4 0
RETP4
LABELV $763
endproc Menu_HitTest 8 12
export Item_SetMouseOver
proc Item_SetMouseOver 4 0
line 1673
;1671:}
;1672:
;1673:void Item_SetMouseOver(itemDef_t *item, qboolean focus) {
line 1674
;1674:	if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $771
line 1675
;1675:		if (focus) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $773
line 1676
;1676:			item->window.flags |= WINDOW_MOUSEOVER;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 1677
;1677:		} else {
ADDRGP4 $774
JUMPV
LABELV $773
line 1678
;1678:			item->window.flags &= ~WINDOW_MOUSEOVER;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 1679
;1679:		}
LABELV $774
line 1680
;1680:	}
LABELV $771
line 1681
;1681:}
LABELV $770
endproc Item_SetMouseOver 4 0
export Item_OwnerDraw_HandleKey
proc Item_OwnerDraw_HandleKey 8 16
line 1684
;1682:
;1683:
;1684:qboolean Item_OwnerDraw_HandleKey(itemDef_t *item, int key) {
line 1685
;1685:	if (item && DC->ownerDrawHandleKey) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $776
ADDRGP4 DC
INDIRP4
CNSTI4 116
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $776
line 1686
;1686:		return DC->ownerDrawHandleKey(item->window.ownerDraw, item->window.ownerDrawFlags, &item->special, key);
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
CNSTI4 528
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 DC
INDIRP4
CNSTI4 116
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $775
JUMPV
LABELV $776
line 1688
;1687:	}
;1688:	return qfalse;
CNSTI4 0
RETI4
LABELV $775
endproc Item_OwnerDraw_HandleKey 8 16
export Item_ListBox_HandleKey
proc Item_ListBox_HandleKey 68 12
line 1691
;1689:}
;1690:
;1691:qboolean Item_ListBox_HandleKey(itemDef_t *item, int key, qboolean down, qboolean force) {
line 1692
;1692:	listBoxDef_t *listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1693
;1693:	int count = DC->feederCount(item->special);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
ASGNI4
line 1696
;1694:	int max, viewmax;
;1695:
;1696:	if (force || (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory) && item->window.flags & WINDOW_HASFOCUS)) {
ADDRFP4 12
INDIRI4
CNSTI4 0
NEI4 $781
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $779
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $779
LABELV $781
line 1697
;1697:		max = Item_ListBox_MaxScroll(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 Item_ListBox_MaxScroll
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 28
INDIRI4
ASGNI4
line 1698
;1698:		if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $782
line 1699
;1699:			viewmax = (item->window.rect.w / listPtr->elementWidth);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
DIVF4
CVFI4 4
ASGNI4
line 1700
;1700:			if (key == K_LEFTARROW || key == K_KP_LEFTARROW) {
ADDRLP4 32
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 134
EQI4 $786
ADDRLP4 32
INDIRI4
CNSTI4 163
NEI4 $784
LABELV $786
line 1701
;1701:				if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $787
line 1702
;1702:					listPtr->cursorPos--;
ADDRLP4 36
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1703
;1703:					if (listPtr->cursorPos < 0) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
GEI4 $789
line 1704
;1704:						listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 1705
;1705:					}
LABELV $789
line 1706
;1706:					if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $791
line 1707
;1707:						listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1708
;1708:					}
LABELV $791
line 1709
;1709:					if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
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
LTI4 $793
line 1710
;1710:						listPtr->startPos = listPtr->cursorPos - viewmax + 1;
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
line 1711
;1711:					}
LABELV $793
line 1712
;1712:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1713
;1713:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 48
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 1714
;1714:				} else {
ADDRGP4 $788
JUMPV
LABELV $787
line 1715
;1715:					listPtr->startPos--;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1716
;1716:					if (listPtr->startPos < 0)
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $795
line 1717
;1717:						listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
LABELV $795
line 1718
;1718:				}
LABELV $788
line 1719
;1719:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $778
JUMPV
LABELV $784
line 1721
;1720:			}
;1721:			if (key == K_RIGHTARROW || key == K_KP_RIGHTARROW) {
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 135
EQI4 $799
ADDRLP4 36
INDIRI4
CNSTI4 165
NEI4 $783
LABELV $799
line 1722
;1722:				if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $800
line 1723
;1723:					listPtr->cursorPos++;
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
ADDI4
ASGNI4
line 1724
;1724:					if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $802
line 1725
;1725:						listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1726
;1726:					}
LABELV $802
line 1727
;1727:					if (listPtr->cursorPos >= count) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $804
line 1728
;1728:						listPtr->cursorPos = count - 1;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1729
;1729:					}
LABELV $804
line 1730
;1730:					if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
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
LTI4 $806
line 1731
;1731:						listPtr->startPos = listPtr->cursorPos - viewmax + 1;
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
line 1732
;1732:					}
LABELV $806
line 1733
;1733:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1734
;1734:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 1735
;1735:				} else {
ADDRGP4 $801
JUMPV
LABELV $800
line 1736
;1736:					listPtr->startPos++;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1737
;1737:					if (listPtr->startPos >= count)
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $808
line 1738
;1738:						listPtr->startPos = count - 1;
ADDRLP4 0
INDIRP4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $808
line 1739
;1739:				}
LABELV $801
line 1740
;1740:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $778
JUMPV
line 1742
;1741:			}
;1742:		} else {
LABELV $782
line 1743
;1743:			viewmax = (item->window.rect.h / listPtr->elementHeight);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 12
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
line 1744
;1744:			if (key == K_UPARROW || key == K_KP_UPARROW) {
ADDRLP4 32
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 132
EQI4 $812
ADDRLP4 32
INDIRI4
CNSTI4 161
NEI4 $810
LABELV $812
line 1745
;1745:				if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $813
line 1746
;1746:					listPtr->cursorPos--;
ADDRLP4 36
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1747
;1747:					if (listPtr->cursorPos < 0) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
GEI4 $815
line 1748
;1748:						listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 1749
;1749:					}
LABELV $815
line 1750
;1750:					if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $817
line 1751
;1751:						listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1752
;1752:					}
LABELV $817
line 1753
;1753:					if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
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
LTI4 $819
line 1754
;1754:						listPtr->startPos = listPtr->cursorPos - viewmax + 1;
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
line 1755
;1755:					}
LABELV $819
line 1756
;1756:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1757
;1757:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 48
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 1758
;1758:				} else {
ADDRGP4 $814
JUMPV
LABELV $813
line 1759
;1759:					listPtr->startPos--;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1760
;1760:					if (listPtr->startPos < 0)
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $821
line 1761
;1761:						listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
LABELV $821
line 1762
;1762:				}
LABELV $814
line 1763
;1763:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $778
JUMPV
LABELV $810
line 1765
;1764:			}
;1765:			if (key == K_DOWNARROW || key == K_KP_DOWNARROW) {
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 133
EQI4 $825
ADDRLP4 36
INDIRI4
CNSTI4 167
NEI4 $823
LABELV $825
line 1766
;1766:				if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $826
line 1767
;1767:					listPtr->cursorPos++;
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
ADDI4
ASGNI4
line 1768
;1768:					if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $828
line 1769
;1769:						listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1770
;1770:					}
LABELV $828
line 1771
;1771:					if (listPtr->cursorPos >= count) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $830
line 1772
;1772:						listPtr->cursorPos = count - 1;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1773
;1773:					}
LABELV $830
line 1774
;1774:					if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
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
LTI4 $832
line 1775
;1775:						listPtr->startPos = listPtr->cursorPos - viewmax + 1;
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
line 1776
;1776:					}
LABELV $832
line 1777
;1777:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1778
;1778:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 1779
;1779:				} else {
ADDRGP4 $827
JUMPV
LABELV $826
line 1780
;1780:					listPtr->startPos++;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1781
;1781:					if (listPtr->startPos > max)
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $834
line 1782
;1782:						listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
LABELV $834
line 1783
;1783:				}
LABELV $827
line 1784
;1784:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $778
JUMPV
LABELV $823
line 1786
;1785:			}
;1786:		}
LABELV $783
line 1788
;1787:		// mouse hit
;1788:		if (key == K_MOUSE1 || key == K_MOUSE2) {
ADDRLP4 32
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 178
EQI4 $838
ADDRLP4 32
INDIRI4
CNSTI4 179
NEI4 $836
LABELV $838
line 1789
;1789:			if (item->window.flags & WINDOW_LB_LEFTARROW) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $839
line 1790
;1790:				listPtr->startPos--;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1791
;1791:				if (listPtr->startPos < 0) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $840
line 1792
;1792:					listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1793
;1793:				}
line 1794
;1794:			} else if (item->window.flags & WINDOW_LB_RIGHTARROW) {
ADDRGP4 $840
JUMPV
LABELV $839
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $843
line 1796
;1795:				// one down
;1796:				listPtr->startPos++;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1797
;1797:				if (listPtr->startPos > max) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $844
line 1798
;1798:					listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1799
;1799:				}
line 1800
;1800:			} else if (item->window.flags & WINDOW_LB_PGUP) {
ADDRGP4 $844
JUMPV
LABELV $843
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $847
line 1802
;1801:				// page up
;1802:				listPtr->startPos -= viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 1803
;1803:				if (listPtr->startPos < 0) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $848
line 1804
;1804:					listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1805
;1805:				}
line 1806
;1806:			} else if (item->window.flags & WINDOW_LB_PGDN) {
ADDRGP4 $848
JUMPV
LABELV $847
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $851
line 1808
;1807:				// page down
;1808:				listPtr->startPos += viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1809
;1809:				if (listPtr->startPos > max) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $852
line 1810
;1810:					listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1811
;1811:				}
line 1812
;1812:			} else if (item->window.flags & WINDOW_LB_THUMB) {
ADDRGP4 $852
JUMPV
LABELV $851
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $855
line 1814
;1813:				// Display_SetCaptureItem(item);
;1814:			} else {
ADDRGP4 $856
JUMPV
LABELV $855
line 1816
;1815:				// select an item
;1816:				if (DC->realTime < lastListBoxClickTime && listPtr->doubleClick) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRGP4 lastListBoxClickTime
INDIRI4
GEI4 $857
ADDRLP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $857
line 1817
;1817:					Item_RunScript(item, listPtr->doubleClick);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 1818
;1818:				}
LABELV $857
line 1819
;1819:				lastListBoxClickTime = DC->realTime + DOUBLE_CLICK_DELAY;
ADDRGP4 lastListBoxClickTime
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 300
ADDI4
ASGNI4
line 1820
;1820:				if (item->cursorPos != listPtr->cursorPos) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
EQI4 $859
line 1821
;1821:					item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1822
;1822:					DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 1823
;1823:				}
LABELV $859
line 1824
;1824:			}
LABELV $856
LABELV $852
LABELV $848
LABELV $844
LABELV $840
line 1825
;1825:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $778
JUMPV
LABELV $836
line 1827
;1826:		}
;1827:		if (key == K_HOME || key == K_KP_HOME) {
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 143
EQI4 $863
ADDRLP4 36
INDIRI4
CNSTI4 160
NEI4 $861
LABELV $863
line 1829
;1828:			// home
;1829:			listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1830
;1830:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $778
JUMPV
LABELV $861
line 1832
;1831:		}
;1832:		if (key == K_END || key == K_KP_END) {
ADDRLP4 40
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 144
EQI4 $866
ADDRLP4 40
INDIRI4
CNSTI4 166
NEI4 $864
LABELV $866
line 1834
;1833:			// end
;1834:			listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1835
;1835:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $778
JUMPV
LABELV $864
line 1837
;1836:		}
;1837:		if (key == K_PGUP || key == K_KP_PGUP) {
ADDRLP4 44
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 142
EQI4 $869
ADDRLP4 44
INDIRI4
CNSTI4 162
NEI4 $867
LABELV $869
line 1839
;1838:			// page up
;1839:			if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $870
line 1840
;1840:				listPtr->cursorPos -= viewmax;
ADDRLP4 48
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 1841
;1841:				if (listPtr->cursorPos < 0) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
GEI4 $872
line 1842
;1842:					listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 1843
;1843:				}
LABELV $872
line 1844
;1844:				if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $874
line 1845
;1845:					listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1846
;1846:				}
LABELV $874
line 1847
;1847:				if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
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
LTI4 $876
line 1848
;1848:					listPtr->startPos = listPtr->cursorPos - viewmax + 1;
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
line 1849
;1849:				}
LABELV $876
line 1850
;1850:				item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1851
;1851:				DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 1852
;1852:			} else {
ADDRGP4 $871
JUMPV
LABELV $870
line 1853
;1853:				listPtr->startPos -= viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 1854
;1854:				if (listPtr->startPos < 0) {
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
GEI4 $878
line 1855
;1855:					listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 1856
;1856:				}
LABELV $878
line 1857
;1857:			}
LABELV $871
line 1858
;1858:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $778
JUMPV
LABELV $867
line 1860
;1859:		}
;1860:		if (key == K_PGDN || key == K_KP_PGDN) {
ADDRLP4 48
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 141
EQI4 $882
ADDRLP4 48
INDIRI4
CNSTI4 168
NEI4 $880
LABELV $882
line 1862
;1861:			// page down
;1862:			if (!listPtr->notselectable) {
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
NEI4 $883
line 1863
;1863:				listPtr->cursorPos += viewmax;
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
ADDI4
ASGNI4
line 1864
;1864:				if (listPtr->cursorPos < listPtr->startPos) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
GEI4 $885
line 1865
;1865:					listPtr->startPos = listPtr->cursorPos;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1866
;1866:				}
LABELV $885
line 1867
;1867:				if (listPtr->cursorPos >= count) {
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $887
line 1868
;1868:					listPtr->cursorPos = count - 1;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1869
;1869:				}
LABELV $887
line 1870
;1870:				if (listPtr->cursorPos >= listPtr->startPos + viewmax) {
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
LTI4 $889
line 1871
;1871:					listPtr->startPos = listPtr->cursorPos - viewmax + 1;
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
line 1872
;1872:				}
LABELV $889
line 1873
;1873:				item->cursorPos = listPtr->cursorPos;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 1874
;1874:				DC->feederSelection(item->special, item->cursorPos);
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 64
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 1875
;1875:			} else {
ADDRGP4 $884
JUMPV
LABELV $883
line 1876
;1876:				listPtr->startPos += viewmax;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1877
;1877:				if (listPtr->startPos > max) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
LEI4 $891
line 1878
;1878:					listPtr->startPos = max;
ADDRLP4 0
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1879
;1879:				}
LABELV $891
line 1880
;1880:			}
LABELV $884
line 1881
;1881:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $778
JUMPV
LABELV $880
line 1883
;1882:		}
;1883:	}
LABELV $779
line 1884
;1884:	return qfalse;
CNSTI4 0
RETI4
LABELV $778
endproc Item_ListBox_HandleKey 68 12
export Item_YesNo_HandleKey
proc Item_YesNo_HandleKey 28 12
line 1887
;1885:}
;1886:
;1887:qboolean Item_YesNo_HandleKey(itemDef_t *item, int key) {
line 1889
;1888:
;1889:	if (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory) && item->window.flags & WINDOW_HASFOCUS && item->cvar) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $894
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $894
ADDRLP4 8
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $894
line 1890
;1890:		if (key == K_MOUSE1 || key == K_ENTER || key == K_MOUSE2 || key == K_MOUSE3) {
ADDRLP4 12
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 178
EQI4 $900
ADDRLP4 12
INDIRI4
CNSTI4 13
EQI4 $900
ADDRLP4 12
INDIRI4
CNSTI4 179
EQI4 $900
ADDRLP4 12
INDIRI4
CNSTI4 180
NEI4 $896
LABELV $900
line 1891
;1891:			DC->setCVar(item->cvar, va("%i", !DC->getCVarValue(item->cvar)));
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 20
INDIRF4
CNSTF4 0
NEF4 $903
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRGP4 $904
JUMPV
LABELV $903
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $904
ADDRGP4 $901
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 1892
;1892:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $893
JUMPV
LABELV $896
line 1894
;1893:		}
;1894:	}
LABELV $894
line 1896
;1895:
;1896:	return qfalse;
CNSTI4 0
RETI4
LABELV $893
endproc Item_YesNo_HandleKey 28 12
export Item_Multi_CountSettings
proc Item_Multi_CountSettings 4 0
line 1900
;1897:
;1898:}
;1899:
;1900:int Item_Multi_CountSettings(itemDef_t *item) {
line 1901
;1901:	multiDef_t *multiPtr = (multiDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1902
;1902:	if (multiPtr == NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $906
line 1903
;1903:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $905
JUMPV
LABELV $906
line 1905
;1904:	}
;1905:	return multiPtr->count;
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
RETI4
LABELV $905
endproc Item_Multi_CountSettings 4 0
export Item_Multi_FindCvarByValue
proc Item_Multi_FindCvarByValue 1040 12
line 1908
;1906:}
;1907:
;1908:int Item_Multi_FindCvarByValue(itemDef_t *item) {
line 1910
;1909:	char buff[1024];
;1910:	float value = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 1912
;1911:	int i;
;1912:	multiDef_t *multiPtr = (multiDef_t *)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1913
;1913:	if (multiPtr) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $909
line 1914
;1914:		if (multiPtr->strDef) {
ADDRLP4 4
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $911
line 1915
;1915:			DC->getCVarString(item->cvar, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 264
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
line 1916
;1916:		} else {
ADDRGP4 $912
JUMPV
LABELV $911
line 1917
;1917:			value = DC->getCVarValue(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 264
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
line 1918
;1918:		}
LABELV $912
line 1919
;1919:		for (i = 0; i < multiPtr->count; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $916
JUMPV
LABELV $913
line 1920
;1920:			if (multiPtr->strDef) {
ADDRLP4 4
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $917
line 1921
;1921:				if (Q_stricmp(buff, multiPtr->cvarStr[i]) == 0) {
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
NEI4 $918
line 1922
;1922:					return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $908
JUMPV
line 1924
;1923:				}
;1924:			} else {
LABELV $917
line 1925
;1925:				if (multiPtr->cvarValue[i] == value) {
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
NEF4 $921
line 1926
;1926:					return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $908
JUMPV
LABELV $921
line 1928
;1927:				}
;1928:			}
LABELV $918
line 1929
;1929:		}
LABELV $914
line 1919
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $916
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
LTI4 $913
line 1930
;1930:	}
LABELV $909
line 1931
;1931:	return 0;
CNSTI4 0
RETI4
LABELV $908
endproc Item_Multi_FindCvarByValue 1040 12
export Item_Multi_Setting
proc Item_Multi_Setting 1040 12
line 1934
;1932:}
;1933:
;1934:const char *Item_Multi_Setting(itemDef_t *item) {
line 1936
;1935:	char buff[1024];
;1936:	float value = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 1938
;1937:	int i;
;1938:	multiDef_t *multiPtr = (multiDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1939
;1939:	if (multiPtr) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $924
line 1940
;1940:		if (multiPtr->strDef) {
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $926
line 1941
;1941:			DC->getCVarString(item->cvar, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 264
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
line 1942
;1942:		} else {
ADDRGP4 $927
JUMPV
LABELV $926
line 1943
;1943:			value = DC->getCVarValue(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 264
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
line 1944
;1944:		}
LABELV $927
line 1945
;1945:		for (i = 0; i < multiPtr->count; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $931
JUMPV
LABELV $928
line 1946
;1946:			if (multiPtr->strDef) {
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $932
line 1947
;1947:				if (Q_stricmp(buff, multiPtr->cvarStr[i]) == 0) {
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
NEI4 $933
line 1948
;1948:					return multiPtr->cvarList[i];
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $923
JUMPV
line 1950
;1949:				}
;1950:			} else {
LABELV $932
line 1951
;1951:				if (multiPtr->cvarValue[i] == value) {
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
NEF4 $936
line 1952
;1952:					return multiPtr->cvarList[i];
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $923
JUMPV
LABELV $936
line 1954
;1953:				}
;1954:			}
LABELV $933
line 1955
;1955:		}
LABELV $929
line 1945
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $931
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
LTI4 $928
line 1956
;1956:	}
LABELV $924
line 1957
;1957:	return "";
ADDRGP4 $54
RETP4
LABELV $923
endproc Item_Multi_Setting 1040 12
export Item_Multi_HandleKey
proc Item_Multi_HandleKey 52 12
line 1960
;1958:}
;1959:
;1960:qboolean Item_Multi_HandleKey(itemDef_t *item, int key) {
line 1961
;1961:	multiDef_t *multiPtr = (multiDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1962
;1962:	if (multiPtr) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $939
line 1963
;1963:		if (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory) && item->window.flags & WINDOW_HASFOCUS && item->cvar) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $941
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $941
ADDRLP4 12
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $941
line 1964
;1964:			if (key == K_MOUSE1 || key == K_ENTER || key == K_MOUSE2 || key == K_MOUSE3) {
ADDRLP4 16
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 178
EQI4 $947
ADDRLP4 16
INDIRI4
CNSTI4 13
EQI4 $947
ADDRLP4 16
INDIRI4
CNSTI4 179
EQI4 $947
ADDRLP4 16
INDIRI4
CNSTI4 180
NEI4 $943
LABELV $947
line 1965
;1965:				int current = Item_Multi_FindCvarByValue(item) + 1;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 Item_Multi_FindCvarByValue
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1966
;1966:				int max = Item_Multi_CountSettings(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 Item_Multi_CountSettings
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 32
INDIRI4
ASGNI4
line 1967
;1967:				if (current < 0 || current >= max) {
ADDRLP4 36
ADDRLP4 20
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
LTI4 $950
ADDRLP4 36
INDIRI4
ADDRLP4 24
INDIRI4
LTI4 $948
LABELV $950
line 1968
;1968:					current = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 1969
;1969:				}
LABELV $948
line 1970
;1970:				if (multiPtr->strDef) {
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 0
EQI4 $951
line 1971
;1971:					DC->setCVar(item->cvar, multiPtr->cvarStr[current]);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
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
line 1972
;1972:				} else {
ADDRGP4 $952
JUMPV
LABELV $951
line 1973
;1973:					float value = multiPtr->cvarValue[current];
ADDRLP4 40
ADDRLP4 20
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
line 1974
;1974:					if (((float)((int)value)) == value) {
ADDRLP4 44
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 44
INDIRF4
CVFI4 4
CVIF4 4
ADDRLP4 44
INDIRF4
NEF4 $953
line 1975
;1975:						DC->setCVar(item->cvar, va("%i", (int)value));
ADDRGP4 $901
ARGP4
ADDRLP4 40
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 1976
;1976:					} else {
ADDRGP4 $954
JUMPV
LABELV $953
line 1977
;1977:						DC->setCVar(item->cvar, va("%f", value));
ADDRGP4 $955
ARGP4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 1978
;1978:					}
LABELV $954
line 1979
;1979:				}
LABELV $952
line 1980
;1980:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $938
JUMPV
LABELV $943
line 1982
;1981:			}
;1982:		}
LABELV $941
line 1983
;1983:	}
LABELV $939
line 1984
;1984:	return qfalse;
CNSTI4 0
RETI4
LABELV $938
endproc Item_Multi_HandleKey 52 12
export Item_TextField_HandleKey
proc Item_TextField_HandleKey 1076 12
line 1987
;1985:}
;1986:
;1987:qboolean Item_TextField_HandleKey(itemDef_t *item, int key) {
line 1990
;1988:	char buff[1024];
;1989:	int len;
;1990:	itemDef_t *newItem = NULL;
ADDRLP4 1028
CNSTP4 0
ASGNP4
line 1991
;1991:	editFieldDef_t *editPtr = (editFieldDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 1993
;1992:
;1993:	if (item->cvar) {
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $957
line 1995
;1994:
;1995:		memset(buff, 0, sizeof(buff));
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1024
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1996
;1996:		DC->getCVarString(item->cvar, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 264
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
line 1997
;1997:		len = strlen(buff);
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
line 1998
;1998:		if (editPtr->maxChars && len > editPtr->maxChars) {
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $959
ADDRLP4 1032
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
LEI4 $959
line 1999
;1999:			len = editPtr->maxChars;
ADDRLP4 1032
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 2000
;2000:		}
LABELV $959
line 2001
;2001:		if (key & K_CHAR_FLAG) {
ADDRFP4 4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $961
line 2002
;2002:			key &= ~K_CHAR_FLAG;
ADDRFP4 4
ADDRFP4 4
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 2005
;2003:
;2004:
;2005:			if (key == 'h' - 'a' + 1) {	// ctrl-h is backspace
ADDRFP4 4
INDIRI4
CNSTI4 8
NEI4 $963
line 2006
;2006:				if (item->cursorPos > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 0
LEI4 $965
line 2007
;2007:					memmove(&buff[item->cursorPos - 1], &buff[item->cursorPos], len + 1 - item->cursorPos);
ADDRLP4 1044
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1044
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 4-1
ADDP4
ARGP4
ADDRLP4 1044
INDIRP4
CNSTI4 532
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
CNSTI4 532
ADDP4
INDIRI4
SUBI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 2008
;2008:					item->cursorPos--;
ADDRLP4 1048
ADDRFP4 0
INDIRP4
CNSTI4 532
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
line 2009
;2009:					if (item->cursorPos < editPtr->paintOffset) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
GEI4 $968
line 2010
;2010:						editPtr->paintOffset--;
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
line 2011
;2011:					}
LABELV $968
line 2012
;2012:				}
LABELV $965
line 2013
;2013:				DC->setCVar(item->cvar, buff);
ADDRFP4 0
INDIRP4
CNSTI4 264
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
line 2014
;2014:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $956
JUMPV
LABELV $963
line 2021
;2015:			}
;2016:
;2017:
;2018:			//
;2019:			// ignore any non printable chars
;2020:			//
;2021:			if (key < 32 || !item->cvar) {
ADDRFP4 4
INDIRI4
CNSTI4 32
LTI4 $972
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $970
LABELV $972
line 2022
;2022:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $956
JUMPV
LABELV $970
line 2025
;2023:			}
;2024:
;2025:			if (item->type == ITEM_TYPE_NUMERICFIELD) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 9
NEI4 $973
line 2026
;2026:				if (key < '0' || key > '9') {
ADDRLP4 1044
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 48
LTI4 $977
ADDRLP4 1044
INDIRI4
CNSTI4 57
LEI4 $975
LABELV $977
line 2027
;2027:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $956
JUMPV
LABELV $975
line 2029
;2028:				}
;2029:			}
LABELV $973
line 2031
;2030:
;2031:			if (!DC->getOverstrikeMode()) {
ADDRLP4 1044
ADDRGP4 DC
INDIRP4
CNSTI4 108
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $978
line 2032
;2032:				if ((len == MAX_EDITFIELD - 1) || (editPtr->maxChars && len >= editPtr->maxChars)) {
ADDRLP4 1048
ADDRLP4 1032
INDIRI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 255
EQI4 $982
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $980
ADDRLP4 1048
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
LTI4 $980
LABELV $982
line 2033
;2033:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $956
JUMPV
LABELV $980
line 2035
;2034:				}
;2035:				memmove(&buff[item->cursorPos + 1], &buff[item->cursorPos], len + 1 - item->cursorPos);
ADDRLP4 1056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 4+1
ADDP4
ARGP4
ADDRLP4 1056
INDIRP4
CNSTI4 532
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
CNSTI4 532
ADDP4
INDIRI4
SUBI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 2036
;2036:			} else {
ADDRGP4 $979
JUMPV
LABELV $978
line 2037
;2037:				if (editPtr->maxChars && item->cursorPos >= editPtr->maxChars) {
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $984
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
LTI4 $984
line 2038
;2038:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $956
JUMPV
LABELV $984
line 2040
;2039:				}
;2040:			}
LABELV $979
line 2042
;2041:
;2042:			buff[item->cursorPos] = key;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 4
ADDP4
ADDRFP4 4
INDIRI4
CVII1 4
ASGNI1
line 2044
;2043:
;2044:			DC->setCVar(item->cvar, buff);
ADDRFP4 0
INDIRP4
CNSTI4 264
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
line 2046
;2045:
;2046:			if (item->cursorPos < len + 1) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 1032
INDIRI4
CNSTI4 1
ADDI4
GEI4 $962
line 2047
;2047:				item->cursorPos++;
ADDRLP4 1048
ADDRFP4 0
INDIRP4
CNSTI4 532
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
line 2048
;2048:				if (editPtr->maxPaintChars && item->cursorPos > editPtr->maxPaintChars) {
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
EQI4 $962
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
LEI4 $962
line 2049
;2049:					editPtr->paintOffset++;
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
line 2050
;2050:				}
line 2051
;2051:			}
line 2053
;2052:
;2053:		} else {
ADDRGP4 $962
JUMPV
LABELV $961
line 2055
;2054:
;2055:			if (key == K_DEL || key == K_KP_DEL) {
ADDRLP4 1044
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 140
EQI4 $992
ADDRLP4 1044
INDIRI4
CNSTI4 171
NEI4 $990
LABELV $992
line 2056
;2056:				if (item->cursorPos < len) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 1032
INDIRI4
GEI4 $993
line 2057
;2057:					memmove(buff + item->cursorPos, buff + item->cursorPos + 1, len - item->cursorPos);
ADDRLP4 1048
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1048
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 4
ADDP4
ARGP4
ADDRLP4 1048
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 4+1
ADDP4
ARGP4
ADDRLP4 1032
INDIRI4
ADDRLP4 1048
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
SUBI4
ARGI4
ADDRGP4 memmove
CALLP4
pop
line 2058
;2058:					DC->setCVar(item->cvar, buff);
ADDRFP4 0
INDIRP4
CNSTI4 264
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
line 2059
;2059:				}
LABELV $993
line 2060
;2060:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $956
JUMPV
LABELV $990
line 2063
;2061:			}
;2062:
;2063:			if (key == K_RIGHTARROW || key == K_KP_RIGHTARROW) {
ADDRLP4 1048
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 135
EQI4 $998
ADDRLP4 1048
INDIRI4
CNSTI4 165
NEI4 $996
LABELV $998
line 2064
;2064:				if (editPtr->maxPaintChars && item->cursorPos >= editPtr->maxPaintChars && item->cursorPos < len) {
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
EQI4 $999
ADDRLP4 1056
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1056
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
LTI4 $999
ADDRLP4 1056
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 1032
INDIRI4
GEI4 $999
line 2065
;2065:					item->cursorPos++;
ADDRLP4 1060
ADDRFP4 0
INDIRP4
CNSTI4 532
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
line 2066
;2066:					editPtr->paintOffset++;
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
line 2067
;2067:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $956
JUMPV
LABELV $999
line 2069
;2068:				}
;2069:				if (item->cursorPos < len) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 1032
INDIRI4
GEI4 $1001
line 2070
;2070:					item->cursorPos++;
ADDRLP4 1060
ADDRFP4 0
INDIRP4
CNSTI4 532
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
line 2071
;2071:				}
LABELV $1001
line 2072
;2072:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $956
JUMPV
LABELV $996
line 2075
;2073:			}
;2074:
;2075:			if (key == K_LEFTARROW || key == K_KP_LEFTARROW) {
ADDRLP4 1052
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 134
EQI4 $1005
ADDRLP4 1052
INDIRI4
CNSTI4 163
NEI4 $1003
LABELV $1005
line 2076
;2076:				if (item->cursorPos > 0) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1006
line 2077
;2077:					item->cursorPos--;
ADDRLP4 1056
ADDRFP4 0
INDIRP4
CNSTI4 532
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
line 2078
;2078:				}
LABELV $1006
line 2079
;2079:				if (item->cursorPos < editPtr->paintOffset) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
GEI4 $1008
line 2080
;2080:					editPtr->paintOffset--;
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
line 2081
;2081:				}
LABELV $1008
line 2082
;2082:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $956
JUMPV
LABELV $1003
line 2085
;2083:			}
;2084:
;2085:			if (key == K_HOME || key == K_KP_HOME) {// || ( tolower(key) == 'a' && trap_Key_IsDown( K_CTRL ) ) ) {
ADDRLP4 1056
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 143
EQI4 $1012
ADDRLP4 1056
INDIRI4
CNSTI4 160
NEI4 $1010
LABELV $1012
line 2086
;2086:				item->cursorPos = 0;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 0
ASGNI4
line 2087
;2087:				editPtr->paintOffset = 0;
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
CNSTI4 0
ASGNI4
line 2088
;2088:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $956
JUMPV
LABELV $1010
line 2091
;2089:			}
;2090:
;2091:			if (key == K_END || key == K_KP_END) {// ( tolower(key) == 'e' && trap_Key_IsDown( K_CTRL ) ) ) {
ADDRLP4 1060
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 144
EQI4 $1015
ADDRLP4 1060
INDIRI4
CNSTI4 166
NEI4 $1013
LABELV $1015
line 2092
;2092:				item->cursorPos = len;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRLP4 1032
INDIRI4
ASGNI4
line 2093
;2093:				if (item->cursorPos > editPtr->maxPaintChars) {
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
LEI4 $1016
line 2094
;2094:					editPtr->paintOffset = len - editPtr->maxPaintChars;
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
line 2095
;2095:				}
LABELV $1016
line 2096
;2096:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $956
JUMPV
LABELV $1013
line 2099
;2097:			}
;2098:
;2099:			if (key == K_INS || key == K_KP_INS) {
ADDRLP4 1064
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 139
EQI4 $1020
ADDRLP4 1064
INDIRI4
CNSTI4 170
NEI4 $1018
LABELV $1020
line 2100
;2100:				DC->setOverstrikeMode(!DC->getOverstrikeMode());
ADDRLP4 1072
ADDRGP4 DC
INDIRP4
CNSTI4 108
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $1022
ADDRLP4 1068
CNSTI4 1
ASGNI4
ADDRGP4 $1023
JUMPV
LABELV $1022
ADDRLP4 1068
CNSTI4 0
ASGNI4
LABELV $1023
ADDRLP4 1068
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 104
ADDP4
INDIRP4
CALLV
pop
line 2101
;2101:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $956
JUMPV
LABELV $1018
line 2103
;2102:			}
;2103:		}
LABELV $962
line 2105
;2104:
;2105:		if (key == K_TAB || key == K_DOWNARROW || key == K_KP_DOWNARROW) {
ADDRLP4 1044
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 9
EQI4 $1027
ADDRLP4 1044
INDIRI4
CNSTI4 133
EQI4 $1027
ADDRLP4 1044
INDIRI4
CNSTI4 167
NEI4 $1024
LABELV $1027
line 2106
;2106:			newItem = Menu_SetNextCursorItem(item->parent);
ADDRFP4 0
INDIRP4
CNSTI4 228
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
line 2107
;2107:			if (newItem && (newItem->type == ITEM_TYPE_EDITFIELD || newItem->type == ITEM_TYPE_NUMERICFIELD)) {
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1028
ADDRLP4 1028
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 4
EQI4 $1030
ADDRLP4 1028
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 9
NEI4 $1028
LABELV $1030
line 2108
;2108:				g_editItem = newItem;
ADDRGP4 g_editItem
ADDRLP4 1028
INDIRP4
ASGNP4
line 2109
;2109:			}
LABELV $1028
line 2110
;2110:		}
LABELV $1024
line 2112
;2111:
;2112:		if (key == K_UPARROW || key == K_KP_UPARROW) {
ADDRLP4 1048
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 132
EQI4 $1033
ADDRLP4 1048
INDIRI4
CNSTI4 161
NEI4 $1031
LABELV $1033
line 2113
;2113:			newItem = Menu_SetPrevCursorItem(item->parent);
ADDRFP4 0
INDIRP4
CNSTI4 228
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
line 2114
;2114:			if (newItem && (newItem->type == ITEM_TYPE_EDITFIELD || newItem->type == ITEM_TYPE_NUMERICFIELD)) {
ADDRLP4 1028
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1034
ADDRLP4 1028
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 4
EQI4 $1036
ADDRLP4 1028
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 9
NEI4 $1034
LABELV $1036
line 2115
;2115:				g_editItem = newItem;
ADDRGP4 g_editItem
ADDRLP4 1028
INDIRP4
ASGNP4
line 2116
;2116:			}
LABELV $1034
line 2117
;2117:		}
LABELV $1031
line 2119
;2118:
;2119:		if (key == K_ENTER || key == K_KP_ENTER || key == K_ESCAPE) {
ADDRLP4 1052
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 13
EQI4 $1040
ADDRLP4 1052
INDIRI4
CNSTI4 169
EQI4 $1040
ADDRLP4 1052
INDIRI4
CNSTI4 27
NEI4 $1037
LABELV $1040
line 2120
;2120:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $956
JUMPV
LABELV $1037
line 2123
;2121:		}
;2122:
;2123:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $956
JUMPV
LABELV $957
line 2125
;2124:	}
;2125:	return qfalse;
CNSTI4 0
RETI4
LABELV $956
endproc Item_TextField_HandleKey 1076 12
proc Scroll_ListBox_AutoFunc 12 16
line 2129
;2126:
;2127:}
;2128:
;2129:static void Scroll_ListBox_AutoFunc(void *p) {
line 2130
;2130:	scrollInfo_t *si = (scrollInfo_t *)p;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 2131
;2131:	if (DC->realTime > si->nextScrollTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
LEI4 $1042
line 2135
;2132:		// need to scroll which is done by simulating a click to the item
;2133:		// this is done a bit sideways as the autoscroll "knows" that the item is a listbox
;2134:		// so it calls it directly
;2135:		Item_ListBox_HandleKey(si->item, si->scrollKey, qtrue, qfalse);
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
line 2136
;2136:		si->nextScrollTime = DC->realTime + si->adjustValue;
ADDRLP4 0
INDIRP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDI4
ASGNI4
line 2137
;2137:	}
LABELV $1042
line 2139
;2138:
;2139:	if (DC->realTime > si->nextAdjustTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LEI4 $1044
line 2140
;2140:		si->nextAdjustTime = DC->realTime + SCROLL_TIME_ADJUST;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 150
ADDI4
ASGNI4
line 2141
;2141:		if (si->adjustValue > SCROLL_TIME_FLOOR) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 20
LEI4 $1046
line 2142
;2142:			si->adjustValue -= SCROLL_TIME_ADJUSTOFFSET;
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
line 2143
;2143:		}
LABELV $1046
line 2144
;2144:	}
LABELV $1044
line 2145
;2145:}
LABELV $1041
endproc Scroll_ListBox_AutoFunc 12 16
proc Scroll_ListBox_ThumbFunc 40 16
line 2147
;2146:
;2147:static void Scroll_ListBox_ThumbFunc(void *p) {
line 2148
;2148:	scrollInfo_t *si = (scrollInfo_t *)p;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 2152
;2149:	rectDef_t r;
;2150:	int pos, max;
;2151:
;2152:	listBoxDef_t *listPtr = (listBoxDef_t *)si->item->typeData;
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 2153
;2153:	if (si->item->window.flags & WINDOW_HORIZONTAL) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1049
line 2154
;2154:		if (DC->cursorx == si->xStart) {
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
NEF4 $1051
line 2155
;2155:			return;
ADDRGP4 $1048
JUMPV
LABELV $1051
line 2157
;2156:		}
;2157:		r.x = si->item->window.rect.x + SCROLLBAR_SIZE + 1;
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
line 2158
;2158:		r.y = si->item->window.rect.y + si->item->window.rect.h - SCROLLBAR_SIZE - 1;
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
line 2159
;2159:		r.h = SCROLLBAR_SIZE;
ADDRLP4 4+12
CNSTF4 1098907648
ASGNF4
line 2160
;2160:		r.w = si->item->window.rect.w - (SCROLLBAR_SIZE * 2) - 2;
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
line 2161
;2161:		max = Item_ListBox_MaxScroll(si->item);
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
line 2163
;2162:		//
;2163:		pos = (DC->cursorx - r.x - SCROLLBAR_SIZE / 2) * max / (r.w - SCROLLBAR_SIZE);
ADDRLP4 20
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
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
line 2164
;2164:		if (pos < 0) {
ADDRLP4 20
INDIRI4
CNSTI4 0
GEI4 $1057
line 2165
;2165:			pos = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 2166
;2166:		} else if (pos > max) {
ADDRGP4 $1058
JUMPV
LABELV $1057
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $1059
line 2167
;2167:			pos = max;
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 2168
;2168:		}
LABELV $1059
LABELV $1058
line 2169
;2169:		listPtr->startPos = pos;
ADDRLP4 28
INDIRP4
ADDRLP4 20
INDIRI4
ASGNI4
line 2170
;2170:		si->xStart = DC->cursorx;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2171
;2171:	} else if (DC->cursory != si->yStart) {
ADDRGP4 $1050
JUMPV
LABELV $1049
ADDRGP4 DC
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
EQF4 $1061
line 2173
;2172:
;2173:		r.x = si->item->window.rect.x + si->item->window.rect.w - SCROLLBAR_SIZE - 1;
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
line 2174
;2174:		r.y = si->item->window.rect.y + SCROLLBAR_SIZE + 1;
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
line 2175
;2175:		r.h = si->item->window.rect.h - (SCROLLBAR_SIZE * 2) - 2;
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
line 2176
;2176:		r.w = SCROLLBAR_SIZE;
ADDRLP4 4+8
CNSTF4 1098907648
ASGNF4
line 2177
;2177:		max = Item_ListBox_MaxScroll(si->item);
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
line 2179
;2178:		//
;2179:		pos = (DC->cursory - r.y - SCROLLBAR_SIZE / 2) * max / (r.h - SCROLLBAR_SIZE);
ADDRLP4 20
ADDRGP4 DC
INDIRP4
CNSTI4 220
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
line 2180
;2180:		if (pos < 0) {
ADDRLP4 20
INDIRI4
CNSTI4 0
GEI4 $1068
line 2181
;2181:			pos = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 2182
;2182:		} else if (pos > max) {
ADDRGP4 $1069
JUMPV
LABELV $1068
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRI4
LEI4 $1070
line 2183
;2183:			pos = max;
ADDRLP4 20
ADDRLP4 24
INDIRI4
ASGNI4
line 2184
;2184:		}
LABELV $1070
LABELV $1069
line 2185
;2185:		listPtr->startPos = pos;
ADDRLP4 28
INDIRP4
ADDRLP4 20
INDIRI4
ASGNI4
line 2186
;2186:		si->yStart = DC->cursory;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2187
;2187:	}
LABELV $1061
LABELV $1050
line 2189
;2188:
;2189:	if (DC->realTime > si->nextScrollTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
LEI4 $1072
line 2193
;2190:		// need to scroll which is done by simulating a click to the item
;2191:		// this is done a bit sideways as the autoscroll "knows" that the item is a listbox
;2192:		// so it calls it directly
;2193:		Item_ListBox_HandleKey(si->item, si->scrollKey, qtrue, qfalse);
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
line 2194
;2194:		si->nextScrollTime = DC->realTime + si->adjustValue;
ADDRLP4 0
INDIRP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDI4
ASGNI4
line 2195
;2195:	}
LABELV $1072
line 2197
;2196:
;2197:	if (DC->realTime > si->nextAdjustTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LEI4 $1074
line 2198
;2198:		si->nextAdjustTime = DC->realTime + SCROLL_TIME_ADJUST;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 150
ADDI4
ASGNI4
line 2199
;2199:		if (si->adjustValue > SCROLL_TIME_FLOOR) {
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 20
LEI4 $1076
line 2200
;2200:			si->adjustValue -= SCROLL_TIME_ADJUSTOFFSET;
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
line 2201
;2201:		}
LABELV $1076
line 2202
;2202:	}
LABELV $1074
line 2203
;2203:}
LABELV $1048
endproc Scroll_ListBox_ThumbFunc 40 16
proc Scroll_Slider_ThumbFunc 28 8
line 2205
;2204:
;2205:static void Scroll_Slider_ThumbFunc(void *p) {
line 2207
;2206:	float x, value, cursorx;
;2207:	scrollInfo_t *si = (scrollInfo_t *)p;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 2208
;2208:	editFieldDef_t *editDef = si->item->typeData;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 2210
;2209:
;2210:	if (si->item->text) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1079
line 2211
;2211:		x = si->item->textRect.x + si->item->textRect.w + 8;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 2212
;2212:	} else {
ADDRGP4 $1080
JUMPV
LABELV $1079
line 2213
;2213:		x = si->item->window.rect.x;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
INDIRF4
ASGNF4
line 2214
;2214:	}
LABELV $1080
line 2216
;2215:
;2216:	cursorx = DC->cursorx;
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2218
;2217:
;2218:	if (cursorx < x) {
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
GEF4 $1081
line 2219
;2219:		cursorx = x;
ADDRLP4 12
ADDRLP4 8
INDIRF4
ASGNF4
line 2220
;2220:	} else if (cursorx > x + SLIDER_WIDTH) {
ADDRGP4 $1082
JUMPV
LABELV $1081
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
CNSTF4 1119879168
ADDF4
LEF4 $1083
line 2221
;2221:		cursorx = x + SLIDER_WIDTH;
ADDRLP4 12
ADDRLP4 8
INDIRF4
CNSTF4 1119879168
ADDF4
ASGNF4
line 2222
;2222:	}
LABELV $1083
LABELV $1082
line 2223
;2223:	value = cursorx - x;
ADDRLP4 4
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
ASGNF4
line 2224
;2224:	value /= SLIDER_WIDTH;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1009429163
MULF4
ASGNF4
line 2225
;2225:	value *= (editDef->maxVal - editDef->minVal);
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
line 2226
;2226:	value += editDef->minVal;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 16
INDIRP4
INDIRF4
ADDF4
ASGNF4
line 2227
;2227:	DC->setCVar(si->item->cvar, va("%f", value));
ADDRGP4 $955
ARGP4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2228
;2228:}
LABELV $1078
endproc Scroll_Slider_ThumbFunc 28 8
export Item_StartCapture
proc Item_StartCapture 24 12
line 2230
;2229:
;2230:void Item_StartCapture(itemDef_t *item, int key) {
line 2232
;2231:	int flags;
;2232:	switch (item->type) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
LTI4 $1086
ADDRLP4 4
INDIRI4
CNSTI4 10
GTI4 $1086
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1113-16
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1113
address $1089
address $1086
address $1089
address $1086
address $1086
address $1089
address $1106
code
LABELV $1089
line 2237
;2233:	case ITEM_TYPE_EDITFIELD:
;2234:	case ITEM_TYPE_NUMERICFIELD:
;2235:
;2236:	case ITEM_TYPE_LISTBOX:
;2237:	{
line 2238
;2238:		flags = Item_ListBox_OverLB(item, DC->cursorx, DC->cursory);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 220
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
line 2239
;2239:		if (flags & (WINDOW_LB_LEFTARROW | WINDOW_LB_RIGHTARROW)) {
ADDRLP4 0
INDIRI4
CNSTI4 6144
BANDI4
CNSTI4 0
EQI4 $1090
line 2240
;2240:			scrollInfo.nextScrollTime = DC->realTime + SCROLL_TIME_START;
ADDRGP4 scrollInfo
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 2241
;2241:			scrollInfo.nextAdjustTime = DC->realTime + SCROLL_TIME_ADJUST;
ADDRGP4 scrollInfo+4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 150
ADDI4
ASGNI4
line 2242
;2242:			scrollInfo.adjustValue = SCROLL_TIME_START;
ADDRGP4 scrollInfo+8
CNSTI4 500
ASGNI4
line 2243
;2243:			scrollInfo.scrollKey = key;
ADDRGP4 scrollInfo+12
ADDRFP4 4
INDIRI4
ASGNI4
line 2244
;2244:			scrollInfo.scrollDir = (flags & WINDOW_LB_LEFTARROW) ? qtrue : qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1097
ADDRLP4 20
CNSTI4 1
ASGNI4
ADDRGP4 $1098
JUMPV
LABELV $1097
ADDRLP4 20
CNSTI4 0
ASGNI4
LABELV $1098
ADDRGP4 scrollInfo+28
ADDRLP4 20
INDIRI4
ASGNI4
line 2245
;2245:			scrollInfo.item = item;
ADDRGP4 scrollInfo+24
ADDRFP4 0
INDIRP4
ASGNP4
line 2246
;2246:			captureData = &scrollInfo;
ADDRGP4 captureData
ADDRGP4 scrollInfo
ASGNP4
line 2247
;2247:			captureFunc = &Scroll_ListBox_AutoFunc;
ADDRGP4 captureFunc
ADDRGP4 Scroll_ListBox_AutoFunc
ASGNP4
line 2248
;2248:			itemCapture = item;
ADDRGP4 itemCapture
ADDRFP4 0
INDIRP4
ASGNP4
line 2249
;2249:		} else if (flags & WINDOW_LB_THUMB) {
ADDRGP4 $1087
JUMPV
LABELV $1090
ADDRLP4 0
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1087
line 2250
;2250:			scrollInfo.scrollKey = key;
ADDRGP4 scrollInfo+12
ADDRFP4 4
INDIRI4
ASGNI4
line 2251
;2251:			scrollInfo.item = item;
ADDRGP4 scrollInfo+24
ADDRFP4 0
INDIRP4
ASGNP4
line 2252
;2252:			scrollInfo.xStart = DC->cursorx;
ADDRGP4 scrollInfo+16
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2253
;2253:			scrollInfo.yStart = DC->cursory;
ADDRGP4 scrollInfo+20
ADDRGP4 DC
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2254
;2254:			captureData = &scrollInfo;
ADDRGP4 captureData
ADDRGP4 scrollInfo
ASGNP4
line 2255
;2255:			captureFunc = &Scroll_ListBox_ThumbFunc;
ADDRGP4 captureFunc
ADDRGP4 Scroll_ListBox_ThumbFunc
ASGNP4
line 2256
;2256:			itemCapture = item;
ADDRGP4 itemCapture
ADDRFP4 0
INDIRP4
ASGNP4
line 2257
;2257:		}
line 2258
;2258:		break;
ADDRGP4 $1087
JUMPV
LABELV $1106
line 2261
;2259:	}
;2260:	case ITEM_TYPE_SLIDER:
;2261:	{
line 2262
;2262:		flags = Item_Slider_OverSlider(item, DC->cursorx, DC->cursory);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 220
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
line 2263
;2263:		if (flags & WINDOW_LB_THUMB) {
ADDRLP4 0
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1087
line 2264
;2264:			scrollInfo.scrollKey = key;
ADDRGP4 scrollInfo+12
ADDRFP4 4
INDIRI4
ASGNI4
line 2265
;2265:			scrollInfo.item = item;
ADDRGP4 scrollInfo+24
ADDRFP4 0
INDIRP4
ASGNP4
line 2266
;2266:			scrollInfo.xStart = DC->cursorx;
ADDRGP4 scrollInfo+16
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2267
;2267:			scrollInfo.yStart = DC->cursory;
ADDRGP4 scrollInfo+20
ADDRGP4 DC
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 2268
;2268:			captureData = &scrollInfo;
ADDRGP4 captureData
ADDRGP4 scrollInfo
ASGNP4
line 2269
;2269:			captureFunc = &Scroll_Slider_ThumbFunc;
ADDRGP4 captureFunc
ADDRGP4 Scroll_Slider_ThumbFunc
ASGNP4
line 2270
;2270:			itemCapture = item;
ADDRGP4 itemCapture
ADDRFP4 0
INDIRP4
ASGNP4
line 2271
;2271:		}
line 2272
;2272:		break;
LABELV $1086
LABELV $1087
line 2275
;2273:	}
;2274:	}
;2275:}
LABELV $1085
endproc Item_StartCapture 24 12
export Item_StopCapture
proc Item_StopCapture 0 0
line 2277
;2276:
;2277:void Item_StopCapture(itemDef_t *item) {
line 2279
;2278:
;2279:}
LABELV $1115
endproc Item_StopCapture 0 0
export Item_Slider_HandleKey
proc Item_Slider_HandleKey 68 12
line 2281
;2280:
;2281:qboolean Item_Slider_HandleKey(itemDef_t *item, int key, qboolean down) {
line 2285
;2282:	float x, value, width, work;
;2283:
;2284:	//DC->Print("slider handle key\n");
;2285:	if (item->window.flags & WINDOW_HASFOCUS && item->cvar && Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory)) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1117
ADDRLP4 16
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1117
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 24
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1117
line 2286
;2286:		if (key == K_MOUSE1 || key == K_ENTER || key == K_MOUSE2 || key == K_MOUSE3) {
ADDRLP4 28
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 178
EQI4 $1123
ADDRLP4 28
INDIRI4
CNSTI4 13
EQI4 $1123
ADDRLP4 28
INDIRI4
CNSTI4 179
EQI4 $1123
ADDRLP4 28
INDIRI4
CNSTI4 180
NEI4 $1119
LABELV $1123
line 2287
;2287:			editFieldDef_t *editDef = item->typeData;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 2288
;2288:			if (editDef) {
ADDRLP4 32
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1124
line 2290
;2289:				rectDef_t testRect;
;2290:				width = SLIDER_WIDTH;
ADDRLP4 8
CNSTF4 1119879168
ASGNF4
line 2291
;2291:				if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1126
line 2292
;2292:					x = item->textRect.x + item->textRect.w + 8;
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 52
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 2293
;2293:				} else {
ADDRGP4 $1127
JUMPV
LABELV $1126
line 2294
;2294:					x = item->window.rect.x;
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 2295
;2295:				}
LABELV $1127
line 2297
;2296:
;2297:				testRect = item->window.rect;
ADDRLP4 36
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 16
line 2298
;2298:				testRect.x = x;
ADDRLP4 36
ADDRLP4 4
INDIRF4
ASGNF4
line 2299
;2299:				value = (float)SLIDER_THUMB_WIDTH / 2;
ADDRLP4 0
CNSTF4 1086324736
ASGNF4
line 2300
;2300:				testRect.x -= value;
ADDRLP4 36
ADDRLP4 36
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
line 2302
;2301:				//DC->Print("slider x: %f\n", testRect.x);
;2302:				testRect.w = (SLIDER_WIDTH + (float)SLIDER_THUMB_WIDTH / 2);
ADDRLP4 36+8
CNSTF4 1120665600
ASGNF4
line 2304
;2303:				//DC->Print("slider w: %f\n", testRect.w);
;2304:				if (Rect_ContainsPoint(&testRect, DC->cursorx, DC->cursory)) {
ADDRLP4 36
ARGP4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 56
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $1129
line 2305
;2305:					work = DC->cursorx - x;
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 2306
;2306:					value = work / width;
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
ASGNF4
line 2307
;2307:					value *= (editDef->maxVal - editDef->minVal);
ADDRLP4 60
ADDRLP4 32
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
INDIRF4
SUBF4
MULF4
ASGNF4
line 2310
;2308:					// vm fuckage
;2309:					// value = (((float)(DC->cursorx - x)/ SLIDER_WIDTH) * (editDef->maxVal - editDef->minVal));
;2310:					value += editDef->minVal;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 32
INDIRP4
INDIRF4
ADDF4
ASGNF4
line 2311
;2311:					DC->setCVar(item->cvar, va("%f", value));
ADDRGP4 $955
ARGP4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 64
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 96
ADDP4
INDIRP4
CALLV
pop
line 2312
;2312:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1116
JUMPV
LABELV $1129
line 2314
;2313:				}
;2314:			}
LABELV $1124
line 2315
;2315:		}
LABELV $1119
line 2316
;2316:	}
LABELV $1117
line 2317
;2317:	DC->Print("slider handle key exit\n");
ADDRGP4 $1131
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 156
ADDP4
INDIRP4
CALLV
pop
line 2318
;2318:	return qfalse;
CNSTI4 0
RETI4
LABELV $1116
endproc Item_Slider_HandleKey 68 12
export Item_HandleKey
proc Item_HandleKey 32 16
line 2322
;2319:}
;2320:
;2321:
;2322:qboolean Item_HandleKey(itemDef_t *item, int key, qboolean down) {
line 2324
;2323:
;2324:	if (itemCapture) {
ADDRGP4 itemCapture
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1133
line 2325
;2325:		Item_StopCapture(itemCapture);
ADDRGP4 itemCapture
INDIRP4
ARGP4
ADDRGP4 Item_StopCapture
CALLV
pop
line 2326
;2326:		itemCapture = NULL;
ADDRGP4 itemCapture
CNSTP4 0
ASGNP4
line 2327
;2327:		captureFunc = NULL;
ADDRGP4 captureFunc
CNSTP4 0
ASGNP4
line 2328
;2328:		captureData = NULL;
ADDRGP4 captureData
CNSTP4 0
ASGNP4
line 2329
;2329:	} else {
ADDRGP4 $1134
JUMPV
LABELV $1133
line 2331
;2330:		// bk001206 - parentheses
;2331:		if (down && (key == K_MOUSE1 || key == K_MOUSE2 || key == K_MOUSE3)) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1135
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1138
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1138
ADDRLP4 0
INDIRI4
CNSTI4 180
NEI4 $1135
LABELV $1138
line 2332
;2332:			Item_StartCapture(item, key);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 Item_StartCapture
CALLV
pop
line 2333
;2333:		}
LABELV $1135
line 2334
;2334:	}
LABELV $1134
line 2336
;2335:
;2336:	if (!down) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $1139
line 2337
;2337:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1132
JUMPV
LABELV $1139
line 2340
;2338:	}
;2339:
;2340:	switch (item->type) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $1141
ADDRLP4 0
INDIRI4
CNSTI4 13
GTI4 $1141
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1155-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1155
address $1144
address $1145
address $1146
address $1147
address $1148
address $1149
address $1141
address $1152
address $1147
address $1154
address $1150
address $1151
address $1153
code
LABELV $1144
line 2342
;2341:	case ITEM_TYPE_BUTTON:
;2342:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1132
JUMPV
line 2343
;2343:		break;
LABELV $1145
line 2345
;2344:	case ITEM_TYPE_RADIOBUTTON:
;2345:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1132
JUMPV
line 2346
;2346:		break;
LABELV $1146
line 2348
;2347:	case ITEM_TYPE_CHECKBOX:
;2348:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1132
JUMPV
line 2349
;2349:		break;
LABELV $1147
line 2353
;2350:	case ITEM_TYPE_EDITFIELD:
;2351:	case ITEM_TYPE_NUMERICFIELD:
;2352:		//return Item_TextField_HandleKey(item, key);
;2353:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1132
JUMPV
line 2354
;2354:		break;
LABELV $1148
line 2356
;2355:	case ITEM_TYPE_COMBO:
;2356:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1132
JUMPV
line 2357
;2357:		break;
LABELV $1149
line 2359
;2358:	case ITEM_TYPE_LISTBOX:
;2359:		return Item_ListBox_HandleKey(item, key, down, qfalse);
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
ADDRGP4 $1132
JUMPV
line 2360
;2360:		break;
LABELV $1150
line 2362
;2361:	case ITEM_TYPE_YESNO:
;2362:		return Item_YesNo_HandleKey(item, key);
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
ADDRGP4 $1132
JUMPV
line 2363
;2363:		break;
LABELV $1151
line 2365
;2364:	case ITEM_TYPE_MULTI:
;2365:		return Item_Multi_HandleKey(item, key);
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
ADDRGP4 $1132
JUMPV
line 2366
;2366:		break;
LABELV $1152
line 2368
;2367:	case ITEM_TYPE_OWNERDRAW:
;2368:		return Item_OwnerDraw_HandleKey(item, key);
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
ADDRGP4 $1132
JUMPV
line 2369
;2369:		break;
LABELV $1153
line 2371
;2370:	case ITEM_TYPE_BIND:
;2371:		return Item_Bind_HandleKey(item, key, down);
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
ADDRGP4 $1132
JUMPV
line 2372
;2372:		break;
LABELV $1154
line 2374
;2373:	case ITEM_TYPE_SLIDER:
;2374:		return Item_Slider_HandleKey(item, key, down);
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
ADDRGP4 $1132
JUMPV
line 2375
;2375:		break;
LABELV $1141
line 2380
;2376:		//case ITEM_TYPE_IMAGE:
;2377:		//  Item_Image_Paint(item);
;2378:		//  break;
;2379:	default:
;2380:		return qfalse;
CNSTI4 0
RETI4
line 2381
;2381:		break;
LABELV $1132
endproc Item_HandleKey 32 16
export Item_Action
proc Item_Action 4 8
line 2387
;2382:	}
;2383:
;2384:	//return qfalse;
;2385:}
;2386:
;2387:void Item_Action(itemDef_t *item) {
line 2388
;2388:	if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1158
line 2389
;2389:		Item_RunScript(item, item->action);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 252
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2390
;2390:	}
LABELV $1158
line 2391
;2391:}
LABELV $1157
endproc Item_Action 4 8
export Menu_SetPrevCursorItem
proc Menu_SetPrevCursorItem 32 12
line 2393
;2392:
;2393:itemDef_t *Menu_SetPrevCursorItem(menuDef_t *menu) {
line 2394
;2394:	qboolean wrapped = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2395
;2395:	int oldCursor = menu->cursorItem;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 2397
;2396:
;2397:	if (menu->cursorItem < 0) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1164
line 2398
;2398:		menu->cursorItem = menu->itemCount - 1;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2399
;2399:		wrapped = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 2400
;2400:	}
ADDRGP4 $1164
JUMPV
LABELV $1163
line 2402
;2401:
;2402:	while (menu->cursorItem > -1) {
line 2404
;2403:
;2404:		menu->cursorItem--;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 196
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
line 2405
;2405:		if (menu->cursorItem < 0 && !wrapped) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
GEI4 $1166
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1166
line 2406
;2406:			wrapped = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 2407
;2407:			menu->cursorItem = menu->itemCount - 1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2408
;2408:		}
LABELV $1166
line 2410
;2409:
;2410:		if (Item_SetFocus(menu->items[menu->cursorItem], DC->cursorx, DC->cursory)) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 260
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
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 220
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
EQI4 $1168
line 2411
;2411:			Menu_HandleMouseMove(menu, menu->items[menu->cursorItem]->window.rect.x + 1, menu->items[menu->cursorItem]->window.rect.y + 1);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 260
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
line 2412
;2412:			return menu->items[menu->cursorItem];
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $1160
JUMPV
LABELV $1168
line 2414
;2413:		}
;2414:	}
LABELV $1164
line 2402
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -1
GTI4 $1163
line 2415
;2415:	menu->cursorItem = oldCursor;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 2416
;2416:	return NULL;
CNSTP4 0
RETP4
LABELV $1160
endproc Menu_SetPrevCursorItem 32 12
export Menu_SetNextCursorItem
proc Menu_SetNextCursorItem 36 12
line 2420
;2417:
;2418:}
;2419:
;2420:itemDef_t *Menu_SetNextCursorItem(menuDef_t *menu) {
line 2422
;2421:
;2422:	qboolean wrapped = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2423
;2423:	int oldCursor = menu->cursorItem;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 2426
;2424:
;2425:
;2426:	if (menu->cursorItem == -1) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1174
line 2427
;2427:		menu->cursorItem = 0;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 0
ASGNI4
line 2428
;2428:		wrapped = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 2429
;2429:	}
ADDRGP4 $1174
JUMPV
LABELV $1173
line 2431
;2430:
;2431:	while (menu->cursorItem < menu->itemCount) {
line 2433
;2432:
;2433:		menu->cursorItem++;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 196
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
line 2434
;2434:		if (menu->cursorItem >= menu->itemCount && !wrapped) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1176
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1176
line 2435
;2435:			wrapped = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 2436
;2436:			menu->cursorItem = 0;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 0
ASGNI4
line 2437
;2437:		}
LABELV $1176
line 2438
;2438:		if (Item_SetFocus(menu->items[menu->cursorItem], DC->cursorx, DC->cursory)) {
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 260
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
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 220
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
EQI4 $1178
line 2439
;2439:			Menu_HandleMouseMove(menu, menu->items[menu->cursorItem]->window.rect.x + 1, menu->items[menu->cursorItem]->window.rect.y + 1);
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 28
INDIRP4
CNSTI4 260
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
line 2440
;2440:			return menu->items[menu->cursorItem];
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $1170
JUMPV
LABELV $1178
line 2443
;2441:		}
;2442:
;2443:	}
LABELV $1174
line 2431
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1173
line 2445
;2444:
;2445:	menu->cursorItem = oldCursor;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 2446
;2446:	return NULL;
CNSTP4 0
RETP4
LABELV $1170
endproc Menu_SetNextCursorItem 36 12
proc Window_CloseCinematic 4 4
line 2449
;2447:}
;2448:
;2449:static void Window_CloseCinematic(windowDef_t *window) {
line 2450
;2450:	if (window->style == WINDOW_STYLE_CINEMATIC && window->cinematic >= 0) {
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
NEI4 $1181
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LTI4 $1181
line 2451
;2451:		DC->stopCinematic(window->cinematic);
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 184
ADDP4
INDIRP4
CALLV
pop
line 2452
;2452:		window->cinematic = -1;
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 -1
ASGNI4
line 2453
;2453:	}
LABELV $1181
line 2454
;2454:}
LABELV $1180
endproc Window_CloseCinematic 4 4
proc Menu_CloseCinematics 4 4
line 2456
;2455:
;2456:static void Menu_CloseCinematics(menuDef_t *menu) {
line 2457
;2457:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1184
line 2459
;2458:		int i;
;2459:		Window_CloseCinematic(&menu->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_CloseCinematic
CALLV
pop
line 2460
;2460:		for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1189
JUMPV
LABELV $1186
line 2461
;2461:			Window_CloseCinematic(&menu->items[i]->window);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Window_CloseCinematic
CALLV
pop
line 2462
;2462:			if (menu->items[i]->type == ITEM_TYPE_OWNERDRAW) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1190
line 2463
;2463:				DC->stopCinematic(0 - menu->items[i]->window.ownerDraw);
CNSTI4 0
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
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
CNSTI4 184
ADDP4
INDIRP4
CALLV
pop
line 2464
;2464:			}
LABELV $1190
line 2465
;2465:		}
LABELV $1187
line 2460
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1189
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1186
line 2466
;2466:	}
LABELV $1184
line 2467
;2467:}
LABELV $1183
endproc Menu_CloseCinematics 4 4
proc Display_CloseCinematics 4 4
line 2469
;2468:
;2469:static void Display_CloseCinematics() {
line 2471
;2470:	int i;
;2471:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1196
JUMPV
LABELV $1193
line 2472
;2472:		Menu_CloseCinematics(&Menus[i]);
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRGP4 Menu_CloseCinematics
CALLV
pop
line 2473
;2473:	}
LABELV $1194
line 2471
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1196
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1193
line 2474
;2474:}
LABELV $1192
endproc Display_CloseCinematics 4 4
export Menus_Activate
proc Menus_Activate 544 8
line 2476
;2475:
;2476:void  Menus_Activate(menuDef_t *menu) {
line 2477
;2477:	menu->window.flags |= (WINDOW_HASFOCUS | WINDOW_VISIBLE);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 2478
;2478:	if (menu->onOpen) {
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1198
line 2480
;2479:		itemDef_t item;
;2480:		item.parent = menu;
ADDRLP4 4+228
ADDRFP4 0
INDIRP4
ASGNP4
line 2481
;2481:		Item_RunScript(&item, menu->onOpen);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_RunScript
CALLV
pop
line 2482
;2482:	}
LABELV $1198
line 2484
;2483:
;2484:	if (menu->soundName && *menu->soundName) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1201
ADDRLP4 4
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1201
line 2486
;2485:		//		DC->stopBackgroundTrack();					// you don't want to do this since it will reset s_rawend
;2486:		DC->startBackgroundTrack(menu->soundName, menu->soundName);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 172
ADDP4
INDIRP4
CALLV
pop
line 2487
;2487:	}
LABELV $1201
line 2489
;2488:
;2489:	Display_CloseCinematics();
ADDRGP4 Display_CloseCinematics
CALLV
pop
line 2491
;2490:
;2491:}
LABELV $1197
endproc Menus_Activate 544 8
export Display_VisibleMenuCount
proc Display_VisibleMenuCount 8 0
line 2493
;2492:
;2493:int Display_VisibleMenuCount() {
line 2495
;2494:	int i, count;
;2495:	count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2496
;2496:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1207
JUMPV
LABELV $1204
line 2497
;2497:		if (Menus[i].window.flags & (WINDOW_FORCED | WINDOW_VISIBLE)) {
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus+68
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
EQI4 $1208
line 2498
;2498:			count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2499
;2499:		}
LABELV $1208
line 2500
;2500:	}
LABELV $1205
line 2496
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1207
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1204
line 2501
;2501:	return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $1203
endproc Display_VisibleMenuCount 8 0
export Menus_HandleOOBClick
proc Menus_HandleOOBClick 20 12
line 2504
;2502:}
;2503:
;2504:void Menus_HandleOOBClick(menuDef_t *menu, int key, qboolean down) {
line 2505
;2505:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1212
line 2510
;2506:		int i;
;2507:		// basically the behaviour we are looking for is if there are windows in the stack.. see if 
;2508:		// the cursor is within any of them.. if not close them otherwise activate them and pass the 
;2509:		// key on.. force a mouse move to activate focus and script stuff 
;2510:		if (down && menu->window.flags & WINDOW_OOB_CLICK) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1214
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $1214
line 2511
;2511:			Menu_RunCloseScript(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_RunCloseScript
CALLV
pop
line 2512
;2512:			menu->window.flags &= ~(WINDOW_HASFOCUS | WINDOW_VISIBLE);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 2513
;2513:		}
LABELV $1214
line 2515
;2514:
;2515:		for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1219
JUMPV
LABELV $1216
line 2516
;2516:			if (Menu_OverActiveItem(&Menus[i], DC->cursorx, DC->cursory)) {
ADDRLP4 0
INDIRI4
CNSTI4 644
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
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 220
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
EQI4 $1220
line 2517
;2517:				Menu_RunCloseScript(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_RunCloseScript
CALLV
pop
line 2518
;2518:				menu->window.flags &= ~(WINDOW_HASFOCUS | WINDOW_VISIBLE);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 2519
;2519:				Menus_Activate(&Menus[i]);
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRGP4 Menus_Activate
CALLV
pop
line 2520
;2520:				Menu_HandleMouseMove(&Menus[i], DC->cursorx, DC->cursory);
ADDRLP4 0
INDIRI4
CNSTI4 644
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
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 Menu_HandleMouseMove
CALLV
pop
line 2521
;2521:				Menu_HandleKey(&Menus[i], key, down);
ADDRLP4 0
INDIRI4
CNSTI4 644
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
line 2522
;2522:			}
LABELV $1220
line 2523
;2523:		}
LABELV $1217
line 2515
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1219
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1216
line 2525
;2524:
;2525:		if (Display_VisibleMenuCount() == 0) {
ADDRLP4 4
ADDRGP4 Display_VisibleMenuCount
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1222
line 2526
;2526:			if (DC->Pause) {
ADDRGP4 DC
INDIRP4
CNSTI4 160
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1224
line 2527
;2527:				DC->Pause(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 160
ADDP4
INDIRP4
CALLV
pop
line 2528
;2528:			}
LABELV $1224
line 2529
;2529:		}
LABELV $1222
line 2530
;2530:		Display_CloseCinematics();
ADDRGP4 Display_CloseCinematics
CALLV
pop
line 2531
;2531:	}
LABELV $1212
line 2532
;2532:}
LABELV $1211
endproc Menus_HandleOOBClick 20 12
bss
align 4
LABELV $1227
skip 16
code
proc Item_CorrectedTextRect 4 12
line 2534
;2533:
;2534:static rectDef_t *Item_CorrectedTextRect(itemDef_t *item) {
line 2536
;2535:	static rectDef_t rect;
;2536:	memset(&rect, 0, sizeof(rectDef_t));
ADDRGP4 $1227
ARGP4
CNSTI4 0
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 memset
CALLP4
pop
line 2537
;2537:	if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1228
line 2538
;2538:		rect = item->textRect;
ADDRGP4 $1227
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRB
ASGNB 16
line 2539
;2539:		if (rect.w) {
ADDRGP4 $1227+8
INDIRF4
CNSTF4 0
EQF4 $1230
line 2540
;2540:			rect.y -= rect.h;
ADDRLP4 0
ADDRGP4 $1227+4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRGP4 $1227+12
INDIRF4
SUBF4
ASGNF4
line 2541
;2541:		}
LABELV $1230
line 2542
;2542:	}
LABELV $1228
line 2543
;2543:	return &rect;
ADDRGP4 $1227
RETP4
LABELV $1226
endproc Item_CorrectedTextRect 4 12
data
align 4
LABELV $1256
byte 4 0
export Menu_HandleKey
code
proc Menu_HandleKey 600 12
line 2546
;2544:}
;2545:
;2546:void Menu_HandleKey(menuDef_t *menu, int key, qboolean down) {
line 2548
;2547:	int i;
;2548:	itemDef_t *item = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 2549
;2549:	qboolean inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2551
;2550:
;2551:	if (inHandler) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $1236
line 2552
;2552:		return;
ADDRGP4 $1235
JUMPV
LABELV $1236
line 2555
;2553:	}
;2554:
;2555:	inHandler = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 2556
;2556:	if (g_waitingForKey && down) {
ADDRGP4 g_waitingForKey
INDIRI4
CNSTI4 0
EQI4 $1238
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1238
line 2557
;2557:		Item_Bind_HandleKey(g_bindItem, key, down);
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
line 2558
;2558:		inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2559
;2559:		return;
ADDRGP4 $1235
JUMPV
LABELV $1238
line 2562
;2560:	}
;2561:
;2562:	if (g_editingField && down) {
ADDRGP4 g_editingField
INDIRI4
CNSTI4 0
EQI4 $1240
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1240
line 2563
;2563:		if (!Item_TextField_HandleKey(g_editItem, key)) {
ADDRGP4 g_editItem
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 Item_TextField_HandleKey
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $1242
line 2564
;2564:			g_editingField = qfalse;
ADDRGP4 g_editingField
CNSTI4 0
ASGNI4
line 2565
;2565:			g_editItem = NULL;
ADDRGP4 g_editItem
CNSTP4 0
ASGNP4
line 2566
;2566:			inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2567
;2567:			return;
ADDRGP4 $1235
JUMPV
LABELV $1242
line 2568
;2568:		} else if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_MOUSE3) {
ADDRLP4 16
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 178
EQI4 $1247
ADDRLP4 16
INDIRI4
CNSTI4 179
EQI4 $1247
ADDRLP4 16
INDIRI4
CNSTI4 180
NEI4 $1244
LABELV $1247
line 2569
;2569:			g_editingField = qfalse;
ADDRGP4 g_editingField
CNSTI4 0
ASGNI4
line 2570
;2570:			g_editItem = NULL;
ADDRGP4 g_editItem
CNSTP4 0
ASGNP4
line 2571
;2571:			Display_MouseMove(NULL, DC->cursorx, DC->cursory);
CNSTP4 0
ARGP4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 Display_MouseMove
CALLI4
pop
line 2572
;2572:		} else if (key == K_TAB || key == K_UPARROW || key == K_DOWNARROW) {
ADDRGP4 $1245
JUMPV
LABELV $1244
ADDRLP4 20
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 9
EQI4 $1251
ADDRLP4 20
INDIRI4
CNSTI4 132
EQI4 $1251
ADDRLP4 20
INDIRI4
CNSTI4 133
NEI4 $1248
LABELV $1251
line 2573
;2573:			return;
ADDRGP4 $1235
JUMPV
LABELV $1248
LABELV $1245
line 2575
;2574:		}
;2575:	}
LABELV $1240
line 2577
;2576:
;2577:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1252
line 2578
;2578:		inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2579
;2579:		return;
ADDRGP4 $1235
JUMPV
LABELV $1252
line 2583
;2580:	}
;2581:
;2582:	// see if the mouse is within the window bounds and if so is this a mouse click
;2583:	if (down && !(menu->window.flags & WINDOW_POPUP) && !Rect_ContainsPoint(&menu->window.rect, DC->cursorx, DC->cursory)) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1254
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2097152
BANDI4
CNSTI4 0
NEI4 $1254
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $1254
line 2586
;2584:		static qboolean inHandleKey = qfalse;
;2585:		// bk001206 - parentheses
;2586:		if (!inHandleKey && (key == K_MOUSE1 || key == K_MOUSE2 || key == K_MOUSE3)) {
ADDRGP4 $1256
INDIRI4
CNSTI4 0
NEI4 $1257
ADDRLP4 24
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 178
EQI4 $1260
ADDRLP4 24
INDIRI4
CNSTI4 179
EQI4 $1260
ADDRLP4 24
INDIRI4
CNSTI4 180
NEI4 $1257
LABELV $1260
line 2587
;2587:			inHandleKey = qtrue;
ADDRGP4 $1256
CNSTI4 1
ASGNI4
line 2588
;2588:			Menus_HandleOOBClick(menu, key, down);
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
line 2589
;2589:			inHandleKey = qfalse;
ADDRGP4 $1256
CNSTI4 0
ASGNI4
line 2590
;2590:			inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2591
;2591:			return;
ADDRGP4 $1235
JUMPV
LABELV $1257
line 2593
;2592:		}
;2593:	}
LABELV $1254
line 2596
;2594:
;2595:	// get the item with focus
;2596:	for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1264
JUMPV
LABELV $1261
line 2597
;2597:		if (menu->items[i]->window.flags & WINDOW_HASFOCUS) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1265
line 2598
;2598:			item = menu->items[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
line 2599
;2599:		}
LABELV $1265
line 2600
;2600:	}
LABELV $1262
line 2596
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1264
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1261
line 2602
;2601:
;2602:	if (item != NULL) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1267
line 2603
;2603:		if (Item_HandleKey(item, key, down)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 Item_HandleKey
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1269
line 2604
;2604:			Item_Action(item);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Item_Action
CALLV
pop
line 2605
;2605:			inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2606
;2606:			return;
ADDRGP4 $1235
JUMPV
LABELV $1269
line 2608
;2607:		}
;2608:	}
LABELV $1267
line 2610
;2609:
;2610:	if (!down) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $1271
line 2611
;2611:		inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2612
;2612:		return;
ADDRGP4 $1235
JUMPV
LABELV $1271
line 2616
;2613:	}
;2614:
;2615:	// default handling
;2616:	switch (key) {
ADDRLP4 24
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 155
EQI4 $1275
ADDRLP4 24
INDIRI4
CNSTI4 156
EQI4 $1279
ADDRLP4 24
INDIRI4
CNSTI4 156
GTI4 $1311
LABELV $1310
ADDRLP4 28
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 13
EQI4 $1304
ADDRLP4 28
INDIRI4
CNSTI4 13
GTI4 $1313
LABELV $1312
ADDRFP4 4
INDIRI4
CNSTI4 9
EQI4 $1288
ADDRGP4 $1273
JUMPV
LABELV $1313
ADDRLP4 32
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 27
EQI4 $1284
ADDRLP4 32
INDIRI4
CNSTI4 27
LTI4 $1273
LABELV $1314
ADDRLP4 36
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 132
EQI4 $1283
ADDRLP4 36
INDIRI4
CNSTI4 133
EQI4 $1288
ADDRGP4 $1273
JUMPV
LABELV $1311
ADDRLP4 40
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 167
EQI4 $1288
ADDRLP4 40
INDIRI4
CNSTI4 169
EQI4 $1304
ADDRLP4 40
INDIRI4
CNSTI4 169
GTI4 $1316
LABELV $1315
ADDRFP4 4
INDIRI4
CNSTI4 161
EQI4 $1283
ADDRGP4 $1273
JUMPV
LABELV $1316
ADDRLP4 44
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 178
LTI4 $1273
ADDRLP4 44
INDIRI4
CNSTI4 188
GTI4 $1317
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1318-712
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1318
address $1289
address $1289
address $1273
address $1273
address $1273
address $1273
address $1273
address $1274
address $1274
address $1274
address $1274
code
LABELV $1317
ADDRLP4 48
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 217
LTI4 $1273
ADDRLP4 48
INDIRI4
CNSTI4 232
GTI4 $1273
ADDRLP4 48
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1320-868
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1320
address $1274
address $1274
address $1274
address $1274
address $1274
address $1274
address $1274
address $1274
address $1274
address $1274
address $1274
address $1274
address $1274
address $1274
address $1274
address $1274
code
LABELV $1275
line 2619
;2617:
;2618:	case K_F11:
;2619:		if (DC->getCVarValue("developer")) {
ADDRGP4 $1278
ARGP4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 52
INDIRF4
CNSTF4 0
EQF4 $1274
line 2620
;2620:			debugMode ^= 1;
ADDRLP4 56
ADDRGP4 debugMode
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 2621
;2621:		}
line 2622
;2622:		break;
ADDRGP4 $1274
JUMPV
LABELV $1279
line 2625
;2623:
;2624:	case K_F12:
;2625:		if (DC->getCVarValue("developer")) {
ADDRGP4 $1278
ARGP4
ADDRLP4 56
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 56
INDIRF4
CNSTF4 0
EQF4 $1274
line 2626
;2626:			DC->executeText(EXEC_APPEND, "screenshot\n");
CNSTI4 2
ARGI4
ADDRGP4 $1282
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 148
ADDP4
INDIRP4
CALLV
pop
line 2627
;2627:		}
line 2628
;2628:		break;
ADDRGP4 $1274
JUMPV
LABELV $1283
line 2631
;2629:	case K_KP_UPARROW:
;2630:	case K_UPARROW:
;2631:		Menu_SetPrevCursorItem(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_SetPrevCursorItem
CALLP4
pop
line 2632
;2632:		break;
ADDRGP4 $1274
JUMPV
LABELV $1284
line 2635
;2633:
;2634:	case K_ESCAPE:
;2635:		if (!g_waitingForKey && menu->onESC) {
ADDRGP4 g_waitingForKey
INDIRI4
CNSTI4 0
NEI4 $1274
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1274
line 2637
;2636:			itemDef_t it;
;2637:			it.parent = menu;
ADDRLP4 60+228
ADDRFP4 0
INDIRP4
ASGNP4
line 2638
;2638:			Item_RunScript(&it, menu->onESC);
ADDRLP4 60
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
line 2639
;2639:		}
line 2640
;2640:		break;
ADDRGP4 $1274
JUMPV
LABELV $1288
line 2644
;2641:	case K_TAB:
;2642:	case K_KP_DOWNARROW:
;2643:	case K_DOWNARROW:
;2644:		Menu_SetNextCursorItem(menu);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_SetNextCursorItem
CALLP4
pop
line 2645
;2645:		break;
ADDRGP4 $1274
JUMPV
LABELV $1289
line 2649
;2646:
;2647:	case K_MOUSE1:
;2648:	case K_MOUSE2:
;2649:		if (item) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1274
line 2650
;2650:			if (item->type == ITEM_TYPE_TEXT) {
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1292
line 2651
;2651:				if (Rect_ContainsPoint(Item_CorrectedTextRect(item), DC->cursorx, DC->cursory)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 Item_CorrectedTextRect
CALLP4
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 64
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 68
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $1274
line 2652
;2652:					Item_Action(item);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Item_Action
CALLV
pop
line 2653
;2653:				}
line 2654
;2654:			} else if (item->type == ITEM_TYPE_EDITFIELD || item->type == ITEM_TYPE_NUMERICFIELD) {
ADDRGP4 $1274
JUMPV
LABELV $1292
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 4
EQI4 $1298
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 9
NEI4 $1296
LABELV $1298
line 2655
;2655:				if (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 64
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 68
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $1274
line 2656
;2656:					item->cursorPos = 0;
ADDRLP4 4
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 0
ASGNI4
line 2657
;2657:					g_editingField = qtrue;
ADDRGP4 g_editingField
CNSTI4 1
ASGNI4
line 2658
;2658:					g_editItem = item;
ADDRGP4 g_editItem
ADDRLP4 4
INDIRP4
ASGNP4
line 2659
;2659:					DC->setOverstrikeMode(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 104
ADDP4
INDIRP4
CALLV
pop
line 2660
;2660:				}
line 2661
;2661:			} else {
ADDRGP4 $1274
JUMPV
LABELV $1296
line 2662
;2662:				if (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 64
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 68
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $1274
line 2663
;2663:					Item_Action(item);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Item_Action
CALLV
pop
line 2664
;2664:				}
line 2665
;2665:			}
line 2666
;2666:		}
line 2667
;2667:		break;
ADDRGP4 $1274
JUMPV
line 2689
;2668:
;2669:	case K_JOY1:
;2670:	case K_JOY2:
;2671:	case K_JOY3:
;2672:	case K_JOY4:
;2673:	case K_AUX1:
;2674:	case K_AUX2:
;2675:	case K_AUX3:
;2676:	case K_AUX4:
;2677:	case K_AUX5:
;2678:	case K_AUX6:
;2679:	case K_AUX7:
;2680:	case K_AUX8:
;2681:	case K_AUX9:
;2682:	case K_AUX10:
;2683:	case K_AUX11:
;2684:	case K_AUX12:
;2685:	case K_AUX13:
;2686:	case K_AUX14:
;2687:	case K_AUX15:
;2688:	case K_AUX16:
;2689:		break;
LABELV $1304
line 2692
;2690:	case K_KP_ENTER:
;2691:	case K_ENTER:
;2692:		if (item) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1274
line 2693
;2693:			if (item->type == ITEM_TYPE_EDITFIELD || item->type == ITEM_TYPE_NUMERICFIELD) {
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 4
EQI4 $1309
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 9
NEI4 $1307
LABELV $1309
line 2694
;2694:				item->cursorPos = 0;
ADDRLP4 4
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 0
ASGNI4
line 2695
;2695:				g_editingField = qtrue;
ADDRGP4 g_editingField
CNSTI4 1
ASGNI4
line 2696
;2696:				g_editItem = item;
ADDRGP4 g_editItem
ADDRLP4 4
INDIRP4
ASGNP4
line 2697
;2697:				DC->setOverstrikeMode(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 104
ADDP4
INDIRP4
CALLV
pop
line 2698
;2698:			} else {
ADDRGP4 $1274
JUMPV
LABELV $1307
line 2699
;2699:				Item_Action(item);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Item_Action
CALLV
pop
line 2700
;2700:			}
line 2701
;2701:		}
line 2702
;2702:		break;
LABELV $1273
LABELV $1274
line 2704
;2703:	}
;2704:	inHandler = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2705
;2705:}
LABELV $1235
endproc Menu_HandleKey 600 12
export ToWindowCoords
proc ToWindowCoords 8 0
line 2707
;2706:
;2707:void ToWindowCoords(float *x, float *y, windowDef_t *window) {
line 2708
;2708:	if (window->border != 0) {
ADDRFP4 8
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1323
line 2709
;2709:		*x += window->borderSize;
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
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 2710
;2710:		*y += window->borderSize;
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
CNSTI4 64
ADDP4
INDIRF4
ADDF4
ASGNF4
line 2711
;2711:	}
LABELV $1323
line 2712
;2712:	*x += window->rect.x;
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
line 2713
;2713:	*y += window->rect.y;
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
line 2714
;2714:}
LABELV $1322
endproc ToWindowCoords 8 0
export Rect_ToWindowCoords
proc Rect_ToWindowCoords 4 12
line 2716
;2715:
;2716:void Rect_ToWindowCoords(rectDef_t *rect, windowDef_t *window) {
line 2717
;2717:	ToWindowCoords(&rect->x, &rect->y, window);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 ToWindowCoords
CALLV
pop
line 2718
;2718:}
LABELV $1325
endproc Rect_ToWindowCoords 4 12
export Item_SetTextExtents
proc Item_SetTextExtents 292 12
line 2720
;2719:
;2720:void Item_SetTextExtents(itemDef_t *item, int *width, int *height, const char *text) {
line 2721
;2721:	const char *textPtr = (text) ? text : item->text;
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1328
ADDRLP4 4
ADDRFP4 12
INDIRP4
ASGNP4
ADDRGP4 $1329
JUMPV
LABELV $1328
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
LABELV $1329
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 2723
;2722:
;2723:	if (textPtr == NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1330
line 2724
;2724:		return;
ADDRGP4 $1326
JUMPV
LABELV $1330
line 2727
;2725:	}
;2726:
;2727:	*width = item->textRect.w;
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 2728
;2728:	*height = item->textRect.h;
ADDRFP4 8
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 2731
;2729:
;2730:	// keeps us from computing the widths and heights more than once
;2731:	if (*width == 0 || (item->type == ITEM_TYPE_OWNERDRAW && item->textalignment == ITEM_ALIGN_CENTER)) {
ADDRFP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $1334
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1332
ADDRLP4 8
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1332
LABELV $1334
line 2732
;2732:		int originalWidth = DC->textWidth(item->text, item->textscale, 0);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 20
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 20
INDIRI4
ASGNI4
line 2734
;2733:
;2734:		if (item->type == ITEM_TYPE_OWNERDRAW && (item->textalignment == ITEM_ALIGN_CENTER || item->textalignment == ITEM_ALIGN_RIGHT)) {
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 8
NEI4 $1335
ADDRLP4 24
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
EQI4 $1337
ADDRLP4 24
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1335
LABELV $1337
line 2735
;2735:			originalWidth += DC->ownerDrawWidth(item->window.ownerDraw, item->textscale);
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
ADDRGP4 DC
INDIRP4
CNSTI4 164
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 32
INDIRI4
ADDI4
ASGNI4
line 2736
;2736:		} else if (item->type == ITEM_TYPE_EDITFIELD && item->textalignment == ITEM_ALIGN_CENTER && item->cvar) {
ADDRGP4 $1336
JUMPV
LABELV $1335
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1338
ADDRLP4 28
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1338
ADDRLP4 28
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1338
line 2738
;2737:			char buff[256];
;2738:			DC->getCVarString(item->cvar, buff, 256);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
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
line 2739
;2739:			originalWidth += DC->textWidth(buff, item->textscale, 0);
ADDRLP4 32
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 288
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 288
INDIRI4
ADDI4
ASGNI4
line 2740
;2740:		}
LABELV $1338
LABELV $1336
line 2742
;2741:
;2742:		*width = DC->textWidth(textPtr, item->textscale, 0);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 32
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 4
INDIRP4
ADDRLP4 32
INDIRI4
ASGNI4
line 2743
;2743:		*height = DC->textHeight(textPtr, item->textscale, 0);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 36
ADDRGP4 DC
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 36
INDIRI4
ASGNI4
line 2744
;2744:		item->textRect.w = *width;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
ADDRFP4 4
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
line 2745
;2745:		item->textRect.h = *height;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
ADDRFP4 8
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
line 2746
;2746:		item->textRect.x = item->textalignx;
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 40
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ASGNF4
line 2747
;2747:		item->textRect.y = item->textaligny;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 44
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ASGNF4
line 2748
;2748:		if (item->textalignment == ITEM_ALIGN_RIGHT) {
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1340
line 2749
;2749:			item->textRect.x = item->textalignx - originalWidth;
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ADDRLP4 12
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 2750
;2750:		} else if (item->textalignment == ITEM_ALIGN_CENTER) {
ADDRGP4 $1341
JUMPV
LABELV $1340
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1342
line 2751
;2751:			item->textRect.x = item->textalignx - originalWidth / 2;
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ADDRLP4 12
INDIRI4
CNSTI4 2
DIVI4
CVIF4 4
SUBF4
ASGNF4
line 2752
;2752:		}
LABELV $1342
LABELV $1341
line 2754
;2753:
;2754:		ToWindowCoords(&item->textRect.x, &item->textRect.y, &item->window);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 48
INDIRP4
CNSTI4 184
ADDP4
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 ToWindowCoords
CALLV
pop
line 2755
;2755:	}
LABELV $1332
line 2756
;2756:}
LABELV $1326
endproc Item_SetTextExtents 292 12
export Item_TextColor
proc Item_TextColor 40 28
line 2758
;2757:
;2758:void Item_TextColor(itemDef_t *item, vec4_t *newColor) {
line 2760
;2759:	vec4_t lowLight;
;2760:	menuDef_t *parent = (menuDef_t *)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 2762
;2761:
;2762:	Fade(&item->window.flags, &item->window.foreColor[3], parent->fadeClamp, &item->window.nextTime, parent->fadeCycle, qtrue, parent->fadeAmount);
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 68
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 124
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
INDIRP4
CNSTI4 108
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ARGF4
ADDRGP4 Fade
CALLV
pop
line 2764
;2763:
;2764:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1345
line 2765
;2765:		lowLight[0] = 0.8 * parent->focusColor[0];
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2766
;2766:		lowLight[1] = 0.8 * parent->focusColor[1];
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2767
;2767:		lowLight[2] = 0.8 * parent->focusColor[2];
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2768
;2768:		lowLight[3] = 0.8 * parent->focusColor[3];
ADDRLP4 4+12
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2769
;2769:		LerpColor(parent->focusColor, lowLight, *newColor, 0.5 + 0.5 * sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
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
CNSTI4 228
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
line 2770
;2770:	} else if (item->textStyle == ITEM_TEXTSTYLE_BLINK && !((DC->realTime / BLINK_DIVISOR) & 1)) {
ADDRGP4 $1346
JUMPV
LABELV $1345
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1350
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 200
DIVI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $1350
line 2771
;2771:		lowLight[0] = 0.8 * item->window.foreColor[0];
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2772
;2772:		lowLight[1] = 0.8 * item->window.foreColor[1];
ADDRLP4 4+4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2773
;2773:		lowLight[2] = 0.8 * item->window.foreColor[2];
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2774
;2774:		lowLight[3] = 0.8 * item->window.foreColor[3];
ADDRLP4 4+12
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2775
;2775:		LerpColor(item->window.foreColor, lowLight, *newColor, 0.5 + 0.5 * sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
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
CNSTI4 112
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
line 2776
;2776:	} else {
ADDRGP4 $1351
JUMPV
LABELV $1350
line 2777
;2777:		memcpy(newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2779
;2778:		// items can be enabled and disabled based on cvars
;2779:	}
LABELV $1351
LABELV $1346
line 2781
;2780:
;2781:	if (item->enableCvar && *item->enableCvar && item->cvarTest && *item->cvarTest) {
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 272
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1355
ADDRLP4 28
INDIRP4
CNSTI4 272
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1355
ADDRLP4 28
INDIRP4
CNSTI4 268
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1355
ADDRLP4 28
INDIRP4
CNSTI4 268
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1355
line 2782
;2782:		if (item->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(item, CVAR_ENABLE)) {
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $1357
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
NEI4 $1357
line 2783
;2783:			memcpy(newColor, &parent->disableColor, sizeof(vec4_t));
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 244
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 2784
;2784:		}
LABELV $1357
line 2785
;2785:	}
LABELV $1355
line 2786
;2786:}
LABELV $1344
endproc Item_TextColor 40 28
export Item_Text_AutoWrapped_Paint
proc Item_Text_AutoWrapped_Paint 2124 32
line 2788
;2787:
;2788:void Item_Text_AutoWrapped_Paint(itemDef_t *item) {
line 2796
;2789:	char text[1024];
;2790:	const char *p, *textPtr, *newLinePtr;
;2791:	char buff[1024];
;2792:	int width, height, len, textWidth, newLine, newLineWidth;
;2793:	float y;
;2794:	vec4_t color;
;2795:
;2796:	textWidth = 0;
ADDRLP4 1032
CNSTI4 0
ASGNI4
line 2797
;2797:	newLinePtr = NULL;
ADDRLP4 1044
CNSTP4 0
ASGNP4
line 2799
;2798:
;2799:	if (item->text == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1360
line 2800
;2800:		if (item->cvar == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1362
line 2801
;2801:			return;
ADDRGP4 $1359
JUMPV
LABELV $1362
line 2802
;2802:		} else {
line 2803
;2803:			DC->getCVarString(item->cvar, text, sizeof(text));
ADDRFP4 0
INDIRP4
CNSTI4 264
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
line 2804
;2804:			textPtr = text;
ADDRLP4 1056
ADDRLP4 1080
ASGNP4
line 2805
;2805:		}
line 2806
;2806:	} else {
ADDRGP4 $1361
JUMPV
LABELV $1360
line 2807
;2807:		textPtr = item->text;
ADDRLP4 1056
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
line 2808
;2808:	}
LABELV $1361
line 2809
;2809:	if (*textPtr == '\0') {
ADDRLP4 1056
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1364
line 2810
;2810:		return;
ADDRGP4 $1359
JUMPV
LABELV $1364
line 2812
;2811:	}
;2812:	Item_TextColor(item, &color);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1060
ARGP4
ADDRGP4 Item_TextColor
CALLV
pop
line 2813
;2813:	Item_SetTextExtents(item, &width, &height, textPtr);
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
line 2815
;2814:
;2815:	y = item->textaligny;
ADDRLP4 1048
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ASGNF4
line 2816
;2816:	len = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 2817
;2817:	buff[0] = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 2818
;2818:	newLine = 0;
ADDRLP4 1036
CNSTI4 0
ASGNI4
line 2819
;2819:	newLineWidth = 0;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 2820
;2820:	p = textPtr;
ADDRLP4 0
ADDRLP4 1056
INDIRP4
ASGNP4
ADDRGP4 $1367
JUMPV
LABELV $1366
line 2821
;2821:	while (p) {
line 2822
;2822:		if (*p == ' ' || *p == '\t' || *p == '\n' || *p == '\0') {
ADDRLP4 2104
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 2104
INDIRI4
CNSTI4 32
EQI4 $1373
ADDRLP4 2104
INDIRI4
CNSTI4 9
EQI4 $1373
ADDRLP4 2104
INDIRI4
CNSTI4 10
EQI4 $1373
ADDRLP4 2104
INDIRI4
CNSTI4 0
NEI4 $1369
LABELV $1373
line 2823
;2823:			newLine = len;
ADDRLP4 1036
ADDRLP4 1028
INDIRI4
ASGNI4
line 2824
;2824:			newLinePtr = p + 1;
ADDRLP4 1044
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 2825
;2825:			newLineWidth = textWidth;
ADDRLP4 1040
ADDRLP4 1032
INDIRI4
ASGNI4
line 2826
;2826:		}
LABELV $1369
line 2827
;2827:		textWidth = DC->textWidth(buff, item->textscale, 0);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 2108
ADDRGP4 DC
INDIRP4
CNSTI4 20
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 2108
INDIRI4
ASGNI4
line 2828
;2828:		if ((newLine && textWidth > item->window.rect.w) || *p == '\n' || *p == '\0') {
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $1377
ADDRLP4 1032
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
GTF4 $1378
LABELV $1377
ADDRLP4 2112
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 2112
INDIRI4
CNSTI4 10
EQI4 $1378
ADDRLP4 2112
INDIRI4
CNSTI4 0
NEI4 $1374
LABELV $1378
line 2829
;2829:			if (len) {
ADDRLP4 1028
INDIRI4
CNSTI4 0
EQI4 $1379
line 2830
;2830:				if (item->textalignment == ITEM_ALIGN_LEFT) {
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1381
line 2831
;2831:					item->textRect.x = item->textalignx;
ADDRLP4 2116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2116
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 2116
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ASGNF4
line 2832
;2832:				} else if (item->textalignment == ITEM_ALIGN_RIGHT) {
ADDRGP4 $1382
JUMPV
LABELV $1381
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1383
line 2833
;2833:					item->textRect.x = item->textalignx - newLineWidth;
ADDRLP4 2116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2116
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 2116
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ADDRLP4 1040
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 2834
;2834:				} else if (item->textalignment == ITEM_ALIGN_CENTER) {
ADDRGP4 $1384
JUMPV
LABELV $1383
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1385
line 2835
;2835:					item->textRect.x = item->textalignx - newLineWidth / 2;
ADDRLP4 2116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2116
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 2116
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ADDRLP4 1040
INDIRI4
CNSTI4 2
DIVI4
CVIF4 4
SUBF4
ASGNF4
line 2836
;2836:				}
LABELV $1385
LABELV $1384
LABELV $1382
line 2837
;2837:				item->textRect.y = y;
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 1048
INDIRF4
ASGNF4
line 2838
;2838:				ToWindowCoords(&item->textRect.x, &item->textRect.y, &item->window);
ADDRLP4 2116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2116
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 2116
INDIRP4
CNSTI4 184
ADDP4
ARGP4
ADDRLP4 2116
INDIRP4
ARGP4
ADDRGP4 ToWindowCoords
CALLV
pop
line 2840
;2839:				//
;2840:				buff[newLine] = '\0';
ADDRLP4 1036
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 0
ASGNI1
line 2841
;2841:				DC->drawText(item->textRect.x, item->textRect.y, item->textscale, color, buff, 0, 0, item->textStyle);
ADDRLP4 2120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2120
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ARGF4
ADDRLP4 2120
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 2120
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 1060
ARGP4
ADDRLP4 4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 2120
INDIRP4
CNSTI4 220
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
line 2842
;2842:			}
LABELV $1379
line 2843
;2843:			if (*p == '\0') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1387
line 2844
;2844:				break;
ADDRGP4 $1368
JUMPV
LABELV $1387
line 2847
;2845:			}
;2846:			//
;2847:			y += height + 5;
ADDRLP4 1048
ADDRLP4 1048
INDIRF4
ADDRLP4 1052
INDIRI4
CNSTI4 5
ADDI4
CVIF4 4
ADDF4
ASGNF4
line 2848
;2848:			p = newLinePtr;
ADDRLP4 0
ADDRLP4 1044
INDIRP4
ASGNP4
line 2849
;2849:			len = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 2850
;2850:			newLine = 0;
ADDRLP4 1036
CNSTI4 0
ASGNI4
line 2851
;2851:			newLineWidth = 0;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 2852
;2852:			continue;
ADDRGP4 $1367
JUMPV
LABELV $1374
line 2854
;2853:		}
;2854:		buff[len++] = *p++;
ADDRLP4 2116
ADDRLP4 1028
INDIRI4
ASGNI4
ADDRLP4 1028
ADDRLP4 2116
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 2120
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 2120
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 2116
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 2120
INDIRP4
INDIRI1
ASGNI1
line 2855
;2855:		buff[len] = '\0';
ADDRLP4 1028
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 0
ASGNI1
line 2856
;2856:	}
LABELV $1367
line 2821
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1366
LABELV $1368
line 2857
;2857:}
LABELV $1359
endproc Item_Text_AutoWrapped_Paint 2124 32
export Item_Text_Wrapped_Paint
proc Item_Text_Wrapped_Paint 2112 32
line 2859
;2858:
;2859:void Item_Text_Wrapped_Paint(itemDef_t *item) {
line 2870
;2860:	char text[1024];
;2861:	const char *p, *start, *textPtr;
;2862:	char buff[1024];
;2863:	int width, height;
;2864:	float x, y;
;2865:	vec4_t color;
;2866:
;2867:	// now paint the text and/or any optional images
;2868:	// default to left
;2869:
;2870:	if (item->text == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1390
line 2871
;2871:		if (item->cvar == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1392
line 2872
;2872:			return;
ADDRGP4 $1389
JUMPV
LABELV $1392
line 2873
;2873:		} else {
line 2874
;2874:			DC->getCVarString(item->cvar, text, sizeof(text));
ADDRFP4 0
INDIRP4
CNSTI4 264
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
line 2875
;2875:			textPtr = text;
ADDRLP4 1060
ADDRLP4 1068
ASGNP4
line 2876
;2876:		}
line 2877
;2877:	} else {
ADDRGP4 $1391
JUMPV
LABELV $1390
line 2878
;2878:		textPtr = item->text;
ADDRLP4 1060
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
line 2879
;2879:	}
LABELV $1391
line 2880
;2880:	if (*textPtr == '\0') {
ADDRLP4 1060
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1394
line 2881
;2881:		return;
ADDRGP4 $1389
JUMPV
LABELV $1394
line 2884
;2882:	}
;2883:
;2884:	Item_TextColor(item, &color);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1040
ARGP4
ADDRGP4 Item_TextColor
CALLV
pop
line 2885
;2885:	Item_SetTextExtents(item, &width, &height, textPtr);
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
line 2887
;2886:
;2887:	x = item->textRect.x;
ADDRLP4 1036
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ASGNF4
line 2888
;2888:	y = item->textRect.y;
ADDRLP4 1032
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ASGNF4
line 2889
;2889:	start = textPtr;
ADDRLP4 4
ADDRLP4 1060
INDIRP4
ASGNP4
line 2890
;2890:	p = strchr(textPtr, '\r');
ADDRLP4 1060
INDIRP4
ARGP4
CNSTI4 13
ARGI4
ADDRLP4 2092
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 2092
INDIRP4
ASGNP4
ADDRGP4 $1397
JUMPV
LABELV $1396
line 2891
;2891:	while (p && *p) {
line 2892
;2892:		strncpy(buff, start, p - start + 1);
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
line 2893
;2893:		buff[p - start] = '\0';
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
line 2894
;2894:		DC->drawText(x, y, item->textscale, color, buff, 0, 0, item->textStyle);
ADDRLP4 1036
INDIRF4
ARGF4
ADDRLP4 1032
INDIRF4
ARGF4
ADDRLP4 2100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2100
INDIRP4
CNSTI4 216
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
ADDRLP4 2100
INDIRP4
CNSTI4 220
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
line 2895
;2895:		y += height + 5;
ADDRLP4 1032
ADDRLP4 1032
INDIRF4
ADDRLP4 1056
INDIRI4
CNSTI4 5
ADDI4
CVIF4 4
ADDF4
ASGNF4
line 2896
;2896:		start += p - start + 1;
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
line 2897
;2897:		p = strchr(p + 1, '\r');
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
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
line 2898
;2898:	}
LABELV $1397
line 2891
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1399
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1396
LABELV $1399
line 2899
;2899:	DC->drawText(x, y, item->textscale, color, start, 0, 0, item->textStyle);
ADDRLP4 1036
INDIRF4
ARGF4
ADDRLP4 1032
INDIRF4
ARGF4
ADDRLP4 2100
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 2100
INDIRP4
CNSTI4 216
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
ADDRLP4 2100
INDIRP4
CNSTI4 220
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
line 2900
;2900:}
LABELV $1389
endproc Item_Text_Wrapped_Paint 2112 32
export Item_Text_Paint
proc Item_Text_Paint 1056 32
line 2902
;2901:
;2902:void Item_Text_Paint(itemDef_t *item) {
line 2908
;2903:	char text[1024];
;2904:	const char *textPtr;
;2905:	int height, width;
;2906:	vec4_t color;
;2907:
;2908:	if (item->window.flags & WINDOW_WRAPPED) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 262144
BANDI4
CNSTI4 0
EQI4 $1401
line 2909
;2909:		Item_Text_Wrapped_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Wrapped_Paint
CALLV
pop
line 2910
;2910:		return;
ADDRGP4 $1400
JUMPV
LABELV $1401
line 2912
;2911:	}
;2912:	if (item->window.flags & WINDOW_AUTOWRAPPED) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 524288
BANDI4
CNSTI4 0
EQI4 $1403
line 2913
;2913:		Item_Text_AutoWrapped_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_AutoWrapped_Paint
CALLV
pop
line 2914
;2914:		return;
ADDRGP4 $1400
JUMPV
LABELV $1403
line 2917
;2915:	}
;2916:
;2917:	if (item->text == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1405
line 2918
;2918:		if (item->cvar == NULL) {
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1407
line 2919
;2919:			return;
ADDRGP4 $1400
JUMPV
LABELV $1407
line 2920
;2920:		} else {
line 2921
;2921:			DC->getCVarString(item->cvar, text, sizeof(text));
ADDRFP4 0
INDIRP4
CNSTI4 264
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
line 2922
;2922:			textPtr = text;
ADDRLP4 0
ADDRLP4 28
ASGNP4
line 2923
;2923:		}
line 2924
;2924:	} else {
ADDRGP4 $1406
JUMPV
LABELV $1405
line 2925
;2925:		textPtr = item->text;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ASGNP4
line 2926
;2926:	}
LABELV $1406
line 2929
;2927:
;2928:	// this needs to go here as it sets extents for cvar types as well
;2929:	Item_SetTextExtents(item, &width, &height, textPtr);
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
line 2931
;2930:
;2931:	if (*textPtr == '\0') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1409
line 2932
;2932:		return;
ADDRGP4 $1400
JUMPV
LABELV $1409
line 2936
;2933:	}
;2934:
;2935:
;2936:	Item_TextColor(item, &color);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Item_TextColor
CALLV
pop
line 2967
;2937:
;2938:	//FIXME: this is a fucking mess
;2939:/*
;2940:	adjust = 0;
;2941:	if (item->textStyle == ITEM_TEXTSTYLE_OUTLINED || item->textStyle == ITEM_TEXTSTYLE_OUTLINESHADOWED) {
;2942:		adjust = 0.5;
;2943:	}
;2944:
;2945:	if (item->textStyle == ITEM_TEXTSTYLE_SHADOWED || item->textStyle == ITEM_TEXTSTYLE_OUTLINESHADOWED) {
;2946:		Fade(&item->window.flags, &DC->Assets.shadowColor[3], DC->Assets.fadeClamp, &item->window.nextTime, DC->Assets.fadeCycle, qfalse);
;2947:		DC->drawText(item->textRect.x + DC->Assets.shadowX, item->textRect.y + DC->Assets.shadowY, item->textscale, DC->Assets.shadowColor, textPtr, adjust);
;2948:	}
;2949:*/
;2950:
;2951:
;2952://	if (item->textStyle == ITEM_TEXTSTYLE_OUTLINED || item->textStyle == ITEM_TEXTSTYLE_OUTLINESHADOWED) {
;2953://		Fade(&item->window.flags, &item->window.outlineColor[3], DC->Assets.fadeClamp, &item->window.nextTime, DC->Assets.fadeCycle, qfalse);
;2954://		/*
;2955://		Text_Paint(item->textRect.x-1, item->textRect.y-1, item->textscale, item->window.foreColor, textPtr, adjust);
;2956://		Text_Paint(item->textRect.x, item->textRect.y-1, item->textscale, item->window.foreColor, textPtr, adjust);
;2957://		Text_Paint(item->textRect.x+1, item->textRect.y-1, item->textscale, item->window.foreColor, textPtr, adjust);
;2958://		Text_Paint(item->textRect.x-1, item->textRect.y, item->textscale, item->window.foreColor, textPtr, adjust);
;2959://		Text_Paint(item->textRect.x+1, item->textRect.y, item->textscale, item->window.foreColor, textPtr, adjust);
;2960://		Text_Paint(item->textRect.x-1, item->textRect.y+1, item->textscale, item->window.foreColor, textPtr, adjust);
;2961://		Text_Paint(item->textRect.x, item->textRect.y+1, item->textscale, item->window.foreColor, textPtr, adjust);
;2962://		Text_Paint(item->textRect.x+1, item->textRect.y+1, item->textscale, item->window.foreColor, textPtr, adjust);
;2963://		*/
;2964://		DC->drawText(item->textRect.x - 1, item->textRect.y + 1, item->textscale * 1.02, item->window.outlineColor, textPtr, adjust);
;2965://	}
;2966:
;2967:	DC->drawText(item->textRect.x, item->textRect.y, item->textscale, color, textPtr, 0, 0, item->textStyle);
ADDRLP4 1052
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1052
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ARGF4
ADDRLP4 1052
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 1052
INDIRP4
CNSTI4 216
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
ADDRLP4 1052
INDIRP4
CNSTI4 220
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
line 2968
;2968:}
LABELV $1400
endproc Item_Text_Paint 1056 32
export Item_TextField_Paint
proc Item_TextField_Paint 1096 36
line 2975
;2969:
;2970:
;2971:
;2972://float			trap_Cvar_VariableValue( const char *var_name );
;2973://void			trap_Cvar_VariableStringBuffer( const char *var_name, char *buffer, int bufsize );
;2974:
;2975:void Item_TextField_Paint(itemDef_t *item) {
line 2979
;2976:	char buff[1024];
;2977:	vec4_t newColor, lowLight;
;2978:	int offset;
;2979:	menuDef_t *parent = (menuDef_t *)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 2980
;2980:	editFieldDef_t *editPtr = (editFieldDef_t *)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 2982
;2981:
;2982:	Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 2984
;2983:
;2984:	buff[0] = '\0';
ADDRLP4 8
CNSTI1 0
ASGNI1
line 2986
;2985:
;2986:	if (item->cvar) {
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1412
line 2987
;2987:		DC->getCVarString(item->cvar, buff, sizeof(buff));
ADDRFP4 0
INDIRP4
CNSTI4 264
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
line 2988
;2988:	}
LABELV $1412
line 2990
;2989:
;2990:	parent = (menuDef_t *)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 2992
;2991:
;2992:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1414
line 2993
;2993:		lowLight[0] = 0.8 * parent->focusColor[0];
ADDRLP4 1032
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2994
;2994:		lowLight[1] = 0.8 * parent->focusColor[1];
ADDRLP4 1032+4
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2995
;2995:		lowLight[2] = 0.8 * parent->focusColor[2];
ADDRLP4 1032+8
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2996
;2996:		lowLight[3] = 0.8 * parent->focusColor[3];
ADDRLP4 1032+12
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 2997
;2997:		LerpColor(parent->focusColor, lowLight, newColor, 0.5 + 0.5 * sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 1068
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 1032
ARGP4
ADDRLP4 1048
ARGP4
ADDRLP4 1068
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 2998
;2998:	} else {
ADDRGP4 $1415
JUMPV
LABELV $1414
line 2999
;2999:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 1048
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3000
;3000:	}
LABELV $1415
line 3002
;3001:
;3002:	offset = (item->text && *item->text) ? 8 : 0;
ADDRLP4 1072
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1072
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1420
ADDRLP4 1072
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1420
ADDRLP4 1068
CNSTI4 8
ASGNI4
ADDRGP4 $1421
JUMPV
LABELV $1420
ADDRLP4 1068
CNSTI4 0
ASGNI4
LABELV $1421
ADDRLP4 1064
ADDRLP4 1068
INDIRI4
ASGNI4
line 3003
;3003:	if (item->window.flags & WINDOW_HASFOCUS && g_editingField) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1422
ADDRGP4 g_editingField
INDIRI4
CNSTI4 0
EQI4 $1422
line 3004
;3004:		char cursor = DC->getOverstrikeMode() ? '_' : '|';
ADDRLP4 1084
ADDRGP4 DC
INDIRP4
CNSTI4 108
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 1084
INDIRI4
CNSTI4 0
EQI4 $1425
ADDRLP4 1080
CNSTI4 95
ASGNI4
ADDRGP4 $1426
JUMPV
LABELV $1425
ADDRLP4 1080
CNSTI4 124
ASGNI4
LABELV $1426
ADDRLP4 1076
ADDRLP4 1080
INDIRI4
CVII1 4
ASGNI1
line 3005
;3005:		DC->drawTextWithCursor(item->textRect.x + item->textRect.w + offset, item->textRect.y, item->textscale, newColor, buff + editPtr->paintOffset, item->cursorPos - editPtr->paintOffset, cursor, editPtr->maxPaintChars, item->textStyle);
ADDRLP4 1088
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1088
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 1088
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
ADDRLP4 1064
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 1088
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 1088
INDIRP4
CNSTI4 216
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
ADDRLP4 1088
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
SUBI4
ARGI4
ADDRLP4 1076
INDIRI1
CVII4 1
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ARGI4
ADDRLP4 1088
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 100
ADDP4
INDIRP4
CALLV
pop
line 3006
;3006:	} else {
ADDRGP4 $1423
JUMPV
LABELV $1422
line 3007
;3007:		DC->drawText(item->textRect.x + item->textRect.w + offset, item->textRect.y, item->textscale, newColor, buff + editPtr->paintOffset, 0, editPtr->maxPaintChars, item->textStyle);
ADDRLP4 1076
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1076
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 1076
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
ADDRLP4 1064
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 1076
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 1076
INDIRP4
CNSTI4 216
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
ADDRLP4 1076
INDIRP4
CNSTI4 220
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
line 3008
;3008:	}
LABELV $1423
line 3010
;3009:
;3010:}
LABELV $1411
endproc Item_TextField_Paint 1096 36
export Item_YesNo_Paint
proc Item_YesNo_Paint 56 32
line 3012
;3011:
;3012:void Item_YesNo_Paint(itemDef_t *item) {
line 3015
;3013:	vec4_t newColor, lowLight;
;3014:	float value;
;3015:	menuDef_t *parent = (menuDef_t *)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3017
;3016:
;3017:	value = (item->cvar) ? DC->getCVarValue(item->cvar) : 0;
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1429
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 44
INDIRF4
ASGNF4
ADDRGP4 $1430
JUMPV
LABELV $1429
ADDRLP4 40
CNSTF4 0
ASGNF4
LABELV $1430
ADDRLP4 36
ADDRLP4 40
INDIRF4
ASGNF4
line 3019
;3018:
;3019:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1431
line 3020
;3020:		lowLight[0] = 0.8 * parent->focusColor[0];
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3021
;3021:		lowLight[1] = 0.8 * parent->focusColor[1];
ADDRLP4 4+4
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3022
;3022:		lowLight[2] = 0.8 * parent->focusColor[2];
ADDRLP4 4+8
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3023
;3023:		lowLight[3] = 0.8 * parent->focusColor[3];
ADDRLP4 4+12
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3024
;3024:		LerpColor(parent->focusColor, lowLight, newColor, 0.5 + 0.5 * sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 48
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 48
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3025
;3025:	} else {
ADDRGP4 $1432
JUMPV
LABELV $1431
line 3026
;3026:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 20
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3027
;3027:	}
LABELV $1432
line 3029
;3028:
;3029:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1436
line 3030
;3030:		Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3031
;3031:		DC->drawText(item->textRect.x + item->textRect.w + 8, item->textRect.y, item->textscale, newColor, (value != 0) ? "Yes" : "No", 0, 0, item->textStyle);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
ARGP4
ADDRLP4 36
INDIRF4
CNSTF4 0
EQF4 $1441
ADDRLP4 48
ADDRGP4 $1438
ASGNP4
ADDRGP4 $1442
JUMPV
LABELV $1441
ADDRLP4 48
ADDRGP4 $1439
ASGNP4
LABELV $1442
ADDRLP4 48
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 220
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
line 3032
;3032:	} else {
ADDRGP4 $1437
JUMPV
LABELV $1436
line 3033
;3033:		DC->drawText(item->textRect.x, item->textRect.y, item->textscale, newColor, (value != 0) ? "Yes" : "No", 0, 0, item->textStyle);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 52
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 20
ARGP4
ADDRLP4 36
INDIRF4
CNSTF4 0
EQF4 $1444
ADDRLP4 48
ADDRGP4 $1438
ASGNP4
ADDRGP4 $1445
JUMPV
LABELV $1444
ADDRLP4 48
ADDRGP4 $1439
ASGNP4
LABELV $1445
ADDRLP4 48
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 220
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
line 3034
;3034:	}
LABELV $1437
line 3035
;3035:}
LABELV $1427
endproc Item_YesNo_Paint 56 32
export Item_Multi_Paint
proc Item_Multi_Paint 48 32
line 3037
;3036:
;3037:void Item_Multi_Paint(itemDef_t *item) {
line 3039
;3038:	vec4_t newColor, lowLight;
;3039:	const char *text = "";
ADDRLP4 4
ADDRGP4 $54
ASGNP4
line 3040
;3040:	menuDef_t *parent = (menuDef_t *)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3042
;3041:
;3042:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1447
line 3043
;3043:		lowLight[0] = 0.8 * parent->focusColor[0];
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3044
;3044:		lowLight[1] = 0.8 * parent->focusColor[1];
ADDRLP4 8+4
ADDRLP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3045
;3045:		lowLight[2] = 0.8 * parent->focusColor[2];
ADDRLP4 8+8
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3046
;3046:		lowLight[3] = 0.8 * parent->focusColor[3];
ADDRLP4 8+12
ADDRLP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3047
;3047:		LerpColor(parent->focusColor, lowLight, newColor, 0.5 + 0.5 * sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 40
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 40
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3048
;3048:	} else {
ADDRGP4 $1448
JUMPV
LABELV $1447
line 3049
;3049:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 24
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3050
;3050:	}
LABELV $1448
line 3052
;3051:
;3052:	text = Item_Multi_Setting(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 Item_Multi_Setting
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 40
INDIRP4
ASGNP4
line 3054
;3053:
;3054:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1452
line 3055
;3055:		Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3056
;3056:		DC->drawText(item->textRect.x + item->textRect.w + 8, item->textRect.y, item->textscale, newColor, text, 0, 0, item->textStyle);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 216
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
ADDRLP4 44
INDIRP4
CNSTI4 220
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
line 3057
;3057:	} else {
ADDRGP4 $1453
JUMPV
LABELV $1452
line 3058
;3058:		DC->drawText(item->textRect.x, item->textRect.y, item->textscale, newColor, text, 0, 0, item->textStyle);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 216
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
ADDRLP4 44
INDIRP4
CNSTI4 220
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
line 3059
;3059:	}
LABELV $1453
line 3060
;3060:}
LABELV $1446
endproc Item_Multi_Paint 48 32
data
align 4
LABELV g_bindings
address $1456
byte 4 9
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1457
byte 4 13
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1458
byte 4 138
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1459
byte 4 132
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1460
byte 4 133
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1461
byte 4 44
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1462
byte 4 46
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1463
byte 4 32
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1464
byte 4 99
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1465
byte 4 134
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1466
byte 4 135
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1467
byte 4 136
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1468
byte 4 141
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1469
byte 4 140
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1470
byte 4 47
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1471
byte 4 144
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1472
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1473
byte 4 49
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1474
byte 4 50
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1475
byte 4 51
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1476
byte 4 52
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1477
byte 4 53
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1478
byte 4 54
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1479
byte 4 55
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1480
byte 4 56
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1481
byte 4 57
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1482
byte 4 48
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1483
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1484
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1485
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1486
byte 4 137
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1487
byte 4 91
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1488
byte 4 93
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1489
byte 4 180
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1490
byte 4 181
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1491
byte 4 119
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1492
byte 4 114
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1493
byte 4 116
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1494
byte 4 121
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1495
byte 4 110
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1496
byte 4 111
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1497
byte 4 100
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1498
byte 4 112
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1499
byte 4 99
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1500
byte 4 102
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1501
byte 4 118
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1502
byte 4 101
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1503
byte 4 105
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1504
byte 4 107
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1505
byte 4 145
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1506
byte 4 146
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1507
byte 4 147
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1508
byte 4 148
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1509
byte 4 149
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1510
byte 4 162
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1511
byte 4 168
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1512
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1513
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1514
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
address $1515
byte 4 -1
byte 4 -1
byte 4 -1
byte 4 -1
skip 4
align 4
LABELV g_bindCount
byte 4 60
code
proc Controls_GetKeyAssignment 276 12
line 3152
;3061:
;3062:
;3063:typedef struct {
;3064:	char *command;
;3065:	int		id;
;3066:	int		defaultbind1;
;3067:	int		defaultbind2;
;3068:	int		bind1;
;3069:	int		bind2;
;3070:} bind_t;
;3071:
;3072:typedef struct {
;3073:	char *name;
;3074:	float	defaultvalue;
;3075:	float	value;
;3076:} configcvar_t;
;3077:
;3078:
;3079:static bind_t g_bindings[] =
;3080:{
;3081:	{"+scores",			 K_TAB,				-1,		-1, -1},
;3082:	{"+button2",		 K_ENTER,			-1,		-1, -1},
;3083:	{"+speed", 			 K_SHIFT,			-1,		-1,	-1},
;3084:	{"+forward", 		 K_UPARROW,		-1,		-1, -1},
;3085:	{"+back", 			 K_DOWNARROW,	-1,		-1, -1},
;3086:	{"+moveleft", 	 ',',					-1,		-1, -1},
;3087:	{"+moveright", 	 '.',					-1,		-1, -1},
;3088:	{"+moveup",			 K_SPACE,			-1,		-1, -1},
;3089:	{"+movedown",		 'c',					-1,		-1, -1},
;3090:	{"+left", 			 K_LEFTARROW,	-1,		-1, -1},
;3091:	{"+right", 			 K_RIGHTARROW,	-1,		-1, -1},
;3092:	{"+strafe", 		 K_ALT,				-1,		-1, -1},
;3093:	{"+lookup", 		 K_PGDN,				-1,		-1, -1},
;3094:	{"+lookdown", 	 K_DEL,				-1,		-1, -1},
;3095:	{"+mlook", 			 '/',					-1,		-1, -1},
;3096:	{"centerview", 	 K_END,				-1,		-1, -1},
;3097:	{"+zoom", 			 -1,						-1,		-1, -1},
;3098:	{"weapon 1",		 '1',					-1,		-1, -1},
;3099:	{"weapon 2",		 '2',					-1,		-1, -1},
;3100:	{"weapon 3",		 '3',					-1,		-1, -1},
;3101:	{"weapon 4",		 '4',					-1,		-1, -1},
;3102:	{"weapon 5",		 '5',					-1,		-1, -1},
;3103:	{"weapon 6",		 '6',					-1,		-1, -1},
;3104:	{"weapon 7",		 '7',					-1,		-1, -1},
;3105:	{"weapon 8",		 '8',					-1,		-1, -1},
;3106:	{"weapon 9",		 '9',					-1,		-1, -1},
;3107:	{"weapon 10",		 '0',					-1,		-1, -1},
;3108:	{"weapon 11",		 -1,					-1,		-1, -1},
;3109:	{"weapon 12",		 -1,					-1,		-1, -1},
;3110:	{"weapon 13",		 -1,					-1,		-1, -1},
;3111:	{"+attack", 		 K_CTRL,				-1,		-1, -1},
;3112:	{"weapprev",		 '[',					-1,		-1, -1},
;3113:	{"weapnext", 		 ']',					-1,		-1, -1},
;3114:	{"+button3", 		 K_MOUSE3,			-1,		-1, -1},
;3115:	{"+button4", 		 K_MOUSE4,			-1,		-1, -1},
;3116:	{"prevTeamMember", 'w',					-1,		-1, -1},
;3117:	{"nextTeamMember", 'r',					-1,		-1, -1},
;3118:	{"nextOrder", 't',					-1,		-1, -1},
;3119:	{"confirmOrder", 'y',					-1,		-1, -1},
;3120:	{"denyOrder", 'n',					-1,		-1, -1},
;3121:	{"taskOffense", 'o',					-1,		-1, -1},
;3122:	{"taskDefense", 'd',					-1,		-1, -1},
;3123:	{"taskPatrol", 'p',					-1,		-1, -1},
;3124:	{"taskCamp", 'c',					-1,		-1, -1},
;3125:	{"taskFollow", 'f',					-1,		-1, -1},
;3126:	{"taskRetrieve", 'v',					-1,		-1, -1},
;3127:	{"taskEscort", 'e',					-1,		-1, -1},
;3128:	{"taskOwnFlag", 'i',					-1,		-1, -1},
;3129:	{"taskSuicide", 'k',					-1,		-1, -1},
;3130:	{"tauntKillInsult", K_F1,			-1,		-1, -1},
;3131:	{"tauntPraise", K_F2,			-1,		-1, -1},
;3132:	{"tauntTaunt", K_F3,			-1,		-1, -1},
;3133:	{"tauntDeathInsult", K_F4,			-1,		-1, -1},
;3134:	{"tauntGauntlet", K_F5,			-1,		-1, -1},
;3135:	{"scoresUp", K_KP_PGUP,			-1,		-1, -1},
;3136:	{"scoresDown", K_KP_PGDN,			-1,		-1, -1},
;3137:	// bk001205 - this one below was:  '-1' 
;3138:	{"messagemode",  -1,					-1,		-1, -1},
;3139:	{"messagemode2", -1,						-1,		-1, -1},
;3140:	{"messagemode3", -1,						-1,		-1, -1},
;3141:	{"messagemode4", -1,						-1,		-1, -1}
;3142:};
;3143:
;3144:
;3145:static const int g_bindCount = sizeof(g_bindings) / sizeof(bind_t);
;3146:
;3147:/*
;3148:=================
;3149:Controls_GetKeyAssignment
;3150:=================
;3151:*/
;3152:static void Controls_GetKeyAssignment(char *command, int *twokeys) {
line 3157
;3153:	int		count;
;3154:	int		j;
;3155:	char	b[256];
;3156:
;3157:	twokeys[0] = twokeys[1] = -1;
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
line 3158
;3158:	count = 0;
ADDRLP4 260
CNSTI4 0
ASGNI4
line 3160
;3159:
;3160:	for (j = 0; j < 256; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $1517
line 3161
;3161:		DC->getBindingBuf(j, b, 256);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 140
ADDP4
INDIRP4
CALLV
pop
line 3162
;3162:		if (*b == 0) {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1521
line 3163
;3163:			continue;
ADDRGP4 $1518
JUMPV
LABELV $1521
line 3165
;3164:		}
;3165:		if (!Q_stricmp(b, command)) {
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
NEI4 $1523
line 3166
;3166:			twokeys[count] = j;
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
line 3167
;3167:			count++;
ADDRLP4 260
ADDRLP4 260
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3168
;3168:			if (count == 2) {
ADDRLP4 260
INDIRI4
CNSTI4 2
NEI4 $1525
line 3169
;3169:				break;
ADDRGP4 $1519
JUMPV
LABELV $1525
line 3171
;3170:			}
;3171:		}
LABELV $1523
line 3172
;3172:	}
LABELV $1518
line 3160
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 256
LTI4 $1517
LABELV $1519
line 3173
;3173:}
LABELV $1516
endproc Controls_GetKeyAssignment 276 12
export Controls_GetConfig
proc Controls_GetConfig 12 8
line 3180
;3174:
;3175:/*
;3176:=================
;3177:Controls_GetConfig
;3178:=================
;3179:*/
;3180:void Controls_GetConfig(void) {
line 3185
;3181:	int		i;
;3182:	int		twokeys[2];
;3183:
;3184:	// iterate each command, get its numeric binding
;3185:	for (i = 0; i < g_bindCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1531
JUMPV
LABELV $1528
line 3187
;3186:
;3187:		Controls_GetKeyAssignment(g_bindings[i].command, twokeys);
ADDRLP4 0
INDIRI4
CNSTI4 24
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
line 3189
;3188:
;3189:		g_bindings[i].bind1 = twokeys[0];
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 3190
;3190:		g_bindings[i].bind2 = twokeys[1];
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
ADDRLP4 4+4
INDIRI4
ASGNI4
line 3191
;3191:	}
LABELV $1529
line 3185
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1531
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1528
line 3201
;3192:
;3193:	//s_controls.invertmouse.curvalue  = DC->getCVarValue( "m_pitch" ) < 0;
;3194:	//s_controls.smoothmouse.curvalue  = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "m_filter" ) );
;3195:	//s_controls.alwaysrun.curvalue    = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "cl_run" ) );
;3196:	//s_controls.autoswitch.curvalue   = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "cg_autoswitch" ) );
;3197:	//s_controls.sensitivity.curvalue  = UI_ClampCvar( 2, 30, Controls_GetCvarValue( "sensitivity" ) );
;3198:	//s_controls.joyenable.curvalue    = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "in_joystick" ) );
;3199:	//s_controls.joythreshold.curvalue = UI_ClampCvar( 0.05, 0.75, Controls_GetCvarValue( "joy_threshold" ) );
;3200:	//s_controls.freelook.curvalue     = UI_ClampCvar( 0, 1, Controls_GetCvarValue( "cl_freelook" ) );
;3201:}
LABELV $1527
endproc Controls_GetConfig 12 8
export Controls_SetConfig
proc Controls_SetConfig 12 8
line 3208
;3202:
;3203:/*
;3204:=================
;3205:Controls_SetConfig
;3206:=================
;3207:*/
;3208:void Controls_SetConfig(qboolean restart) {
line 3212
;3209:	int		i;
;3210:
;3211:	// iterate each command, get its numeric binding
;3212:	for (i = 0; i < g_bindCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1539
JUMPV
LABELV $1536
line 3214
;3213:
;3214:		if (g_bindings[i].bind1 != -1) {
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1540
line 3215
;3215:			DC->setBinding(g_bindings[i].bind1, g_bindings[i].command);
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings
ADDP4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLV
pop
line 3217
;3216:
;3217:			if (g_bindings[i].bind2 != -1)
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1544
line 3218
;3218:				DC->setBinding(g_bindings[i].bind2, g_bindings[i].command);
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings
ADDP4
INDIRP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLV
pop
LABELV $1544
line 3219
;3219:		}
LABELV $1540
line 3220
;3220:	}
LABELV $1537
line 3212
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1539
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1536
line 3234
;3221:
;3222:	//if ( s_controls.invertmouse.curvalue )
;3223:	//	DC->setCVar("m_pitch", va("%f),-fabs( DC->getCVarValue( "m_pitch" ) ) );
;3224:	//else
;3225:	//	trap_Cvar_SetValue( "m_pitch", fabs( trap_Cvar_VariableValue( "m_pitch" ) ) );
;3226:
;3227:	//trap_Cvar_SetValue( "m_filter", s_controls.smoothmouse.curvalue );
;3228:	//trap_Cvar_SetValue( "cl_run", s_controls.alwaysrun.curvalue );
;3229:	//trap_Cvar_SetValue( "cg_autoswitch", s_controls.autoswitch.curvalue );
;3230:	//trap_Cvar_SetValue( "sensitivity", s_controls.sensitivity.curvalue );
;3231:	//trap_Cvar_SetValue( "in_joystick", s_controls.joyenable.curvalue );
;3232:	//trap_Cvar_SetValue( "joy_threshold", s_controls.joythreshold.curvalue );
;3233:	//trap_Cvar_SetValue( "cl_freelook", s_controls.freelook.curvalue );
;3234:	DC->executeText(EXEC_APPEND, "in_restart\n");
CNSTI4 2
ARGI4
ADDRGP4 $1548
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 148
ADDP4
INDIRP4
CALLV
pop
line 3236
;3235:	//trap_Cmd_ExecuteText( EXEC_APPEND, "in_restart\n" );
;3236:}
LABELV $1535
endproc Controls_SetConfig 12 8
export Controls_SetDefaults
proc Controls_SetDefaults 12 0
line 3243
;3237:
;3238:/*
;3239:=================
;3240:Controls_SetDefaults
;3241:=================
;3242:*/
;3243:void Controls_SetDefaults(void) {
line 3247
;3244:	int	i;
;3245:
;3246:	// iterate each command, set its default binding
;3247:	for (i = 0; i < g_bindCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1553
JUMPV
LABELV $1550
line 3248
;3248:		g_bindings[i].bind1 = g_bindings[i].defaultbind1;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+8
ADDP4
INDIRI4
ASGNI4
line 3249
;3249:		g_bindings[i].bind2 = g_bindings[i].defaultbind2;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+12
ADDP4
INDIRI4
ASGNI4
line 3250
;3250:	}
LABELV $1551
line 3247
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1553
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1550
line 3260
;3251:
;3252:	//s_controls.invertmouse.curvalue  = Controls_GetCvarDefault( "m_pitch" ) < 0;
;3253:	//s_controls.smoothmouse.curvalue  = Controls_GetCvarDefault( "m_filter" );
;3254:	//s_controls.alwaysrun.curvalue    = Controls_GetCvarDefault( "cl_run" );
;3255:	//s_controls.autoswitch.curvalue   = Controls_GetCvarDefault( "cg_autoswitch" );
;3256:	//s_controls.sensitivity.curvalue  = Controls_GetCvarDefault( "sensitivity" );
;3257:	//s_controls.joyenable.curvalue    = Controls_GetCvarDefault( "in_joystick" );
;3258:	//s_controls.joythreshold.curvalue = Controls_GetCvarDefault( "joy_threshold" );
;3259:	//s_controls.freelook.curvalue     = Controls_GetCvarDefault( "cl_freelook" );
;3260:}
LABELV $1549
endproc Controls_SetDefaults 12 0
export BindingIDFromName
proc BindingIDFromName 8 8
line 3262
;3261:
;3262:int BindingIDFromName(const char *name) {
line 3264
;3263:	int i;
;3264:	for (i = 0; i < g_bindCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1562
JUMPV
LABELV $1559
line 3265
;3265:		if (Q_stricmp(name, g_bindings[i].command) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 24
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
NEI4 $1563
line 3266
;3266:			return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $1558
JUMPV
LABELV $1563
line 3268
;3267:		}
;3268:	}
LABELV $1560
line 3264
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1562
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1559
line 3269
;3269:	return -1;
CNSTI4 -1
RETI4
LABELV $1558
endproc BindingIDFromName 8 8
export BindingFromName
proc BindingFromName 16 12
line 3275
;3270:}
;3271:
;3272:char g_nameBind1[32];
;3273:char g_nameBind2[32];
;3274:
;3275:void BindingFromName(const char *cvar) {
line 3279
;3276:	int	i, b1, b2;
;3277:
;3278:	// iterate each command, set its default binding
;3279:	for (i = 0; i < g_bindCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1569
JUMPV
LABELV $1566
line 3280
;3280:		if (Q_stricmp(cvar, g_bindings[i].command) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 24
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
NEI4 $1570
line 3281
;3281:			b1 = g_bindings[i].bind1;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ASGNI4
line 3282
;3282:			if (b1 == -1) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
NEI4 $1573
line 3283
;3283:				break;
ADDRGP4 $1568
JUMPV
LABELV $1573
line 3285
;3284:			}
;3285:			DC->keynumToStringBuf(b1, g_nameBind1, 32);
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 g_nameBind1
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 136
ADDP4
INDIRP4
CALLV
pop
line 3286
;3286:			Q_strupr(g_nameBind1);
ADDRGP4 g_nameBind1
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 3288
;3287:
;3288:			b2 = g_bindings[i].bind2;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ASGNI4
line 3289
;3289:			if (b2 != -1) {
ADDRLP4 8
INDIRI4
CNSTI4 -1
EQI4 $1565
line 3290
;3290:				DC->keynumToStringBuf(b2, g_nameBind2, 32);
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 g_nameBind2
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 136
ADDP4
INDIRP4
CALLV
pop
line 3291
;3291:				Q_strupr(g_nameBind2);
ADDRGP4 g_nameBind2
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 3292
;3292:				strcat(g_nameBind1, " or ");
ADDRGP4 g_nameBind1
ARGP4
ADDRGP4 $1578
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 3293
;3293:				strcat(g_nameBind1, g_nameBind2);
ADDRGP4 g_nameBind1
ARGP4
ADDRGP4 g_nameBind2
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 3294
;3294:			}
line 3295
;3295:			return;
ADDRGP4 $1565
JUMPV
LABELV $1570
line 3297
;3296:		}
;3297:	}
LABELV $1567
line 3279
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1569
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1566
LABELV $1568
line 3298
;3298:	strcpy(g_nameBind1, "???");
ADDRGP4 g_nameBind1
ARGP4
ADDRGP4 $1579
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 3299
;3299:}
LABELV $1565
endproc BindingFromName 16 12
export Item_Slider_Paint
proc Item_Slider_Paint 68 20
line 3301
;3300:
;3301:void Item_Slider_Paint(itemDef_t *item) {
line 3304
;3302:	vec4_t newColor, lowLight;
;3303:	float x, y, value;
;3304:	menuDef_t *parent = (menuDef_t *)item->parent;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3306
;3305:
;3306:	value = (item->cvar) ? DC->getCVarValue(item->cvar) : 0;
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1582
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 48
ADDRLP4 52
INDIRF4
ASGNF4
ADDRGP4 $1583
JUMPV
LABELV $1582
ADDRLP4 48
CNSTF4 0
ASGNF4
LABELV $1583
ADDRLP4 44
ADDRLP4 48
INDIRF4
ASGNF4
line 3308
;3307:
;3308:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1584
line 3309
;3309:		lowLight[0] = 0.8 * parent->focusColor[0];
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3310
;3310:		lowLight[1] = 0.8 * parent->focusColor[1];
ADDRLP4 12+4
ADDRLP4 4
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3311
;3311:		lowLight[2] = 0.8 * parent->focusColor[2];
ADDRLP4 12+8
ADDRLP4 4
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3312
;3312:		lowLight[3] = 0.8 * parent->focusColor[3];
ADDRLP4 12+12
ADDRLP4 4
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3313
;3313:		LerpColor(parent->focusColor, lowLight, newColor, 0.5 + 0.5 * sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
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
ADDRLP4 4
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 28
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
line 3314
;3314:	} else {
ADDRGP4 $1585
JUMPV
LABELV $1584
line 3315
;3315:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3316
;3316:	}
LABELV $1585
line 3318
;3317:
;3318:	y = item->window.rect.y;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 3319
;3319:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1589
line 3320
;3320:		Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3321
;3321:		x = item->textRect.x + item->textRect.w + 8;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 3322
;3322:	} else {
ADDRGP4 $1590
JUMPV
LABELV $1589
line 3323
;3323:		x = item->window.rect.x;
ADDRLP4 0
ADDRFP4 0
INDIRP4
INDIRF4
ASGNF4
line 3324
;3324:	}
LABELV $1590
line 3325
;3325:	DC->setColor(newColor);
ADDRLP4 28
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 3326
;3326:	DC->drawHandlePic(x, y, SLIDER_WIDTH, SLIDER_HEIGHT, DC->Assets.sliderBar);
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
ADDRLP4 56
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 61928
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3328
;3327:
;3328:	x = Item_Slider_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 Item_Slider_ThumbPosition
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 60
INDIRF4
ASGNF4
line 3329
;3329:	DC->drawHandlePic(x - (SLIDER_THUMB_WIDTH / 2), y - 2, SLIDER_THUMB_WIDTH, SLIDER_THUMB_HEIGHT, DC->Assets.sliderThumb);
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
ADDRLP4 64
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 61932
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3331
;3330:
;3331:}
LABELV $1580
endproc Item_Slider_Paint 68 20
export Item_Bind_Paint
proc Item_Bind_Paint 64 32
line 3333
;3332:
;3333:void Item_Bind_Paint(itemDef_t *item) {
line 3336
;3334:	vec4_t newColor, lowLight;
;3335:	float value;
;3336:	int maxChars = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 3337
;3337:	menuDef_t *parent = (menuDef_t *)item->parent;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3338
;3338:	editFieldDef_t *editPtr = (editFieldDef_t *)item->typeData;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 3339
;3339:	if (editPtr) {
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1592
line 3340
;3340:		maxChars = editPtr->maxPaintChars;
ADDRLP4 16
ADDRLP4 24
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
line 3341
;3341:	}
LABELV $1592
line 3343
;3342:
;3343:	value = (item->cvar) ? DC->getCVarValue(item->cvar) : 0;
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1595
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
CNSTI4 92
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 48
ADDRLP4 52
INDIRF4
ASGNF4
ADDRGP4 $1596
JUMPV
LABELV $1595
ADDRLP4 48
CNSTF4 0
ASGNF4
LABELV $1596
ADDRLP4 44
ADDRLP4 48
INDIRF4
ASGNF4
line 3345
;3344:
;3345:	if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1597
line 3346
;3346:		if (g_bindItem == item) {
ADDRGP4 g_bindItem
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $1599
line 3347
;3347:			lowLight[0] = 0.8f * 1.0f;
ADDRLP4 0
CNSTF4 1061997773
ASGNF4
line 3348
;3348:			lowLight[1] = 0.8f * 0.0f;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 3349
;3349:			lowLight[2] = 0.8f * 0.0f;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 3350
;3350:			lowLight[3] = 0.8f * 1.0f;
ADDRLP4 0+12
CNSTF4 1061997773
ASGNF4
line 3351
;3351:		} else {
ADDRGP4 $1600
JUMPV
LABELV $1599
line 3352
;3352:			lowLight[0] = 0.8f * parent->focusColor[0];
ADDRLP4 0
ADDRLP4 20
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3353
;3353:			lowLight[1] = 0.8f * parent->focusColor[1];
ADDRLP4 0+4
ADDRLP4 20
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3354
;3354:			lowLight[2] = 0.8f * parent->focusColor[2];
ADDRLP4 0+8
ADDRLP4 20
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3355
;3355:			lowLight[3] = 0.8f * parent->focusColor[3];
ADDRLP4 0+12
ADDRLP4 20
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3356
;3356:		}
LABELV $1600
line 3357
;3357:		LerpColor(parent->focusColor, lowLight, newColor, 0.5 + 0.5 * sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
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
ADDRLP4 20
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 28
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
line 3358
;3358:	} else {
ADDRGP4 $1598
JUMPV
LABELV $1597
line 3359
;3359:		memcpy(&newColor, &item->window.foreColor, sizeof(vec4_t));
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3360
;3360:	}
LABELV $1598
line 3362
;3361:
;3362:	if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1607
line 3363
;3363:		Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3364
;3364:		BindingFromName(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRGP4 BindingFromName
CALLV
pop
line 3365
;3365:		DC->drawText(item->textRect.x + item->textRect.w + 8, item->textRect.y, item->textscale, newColor, g_nameBind1, 0, maxChars, item->textStyle);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 216
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
ADDRLP4 56
INDIRP4
CNSTI4 220
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
line 3366
;3366:	} else {
ADDRGP4 $1608
JUMPV
LABELV $1607
line 3367
;3367:		DC->drawText(item->textRect.x, item->textRect.y, item->textscale, newColor, (value != 0) ? "FIXME" : "FIXME", 0, maxChars, item->textStyle);
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 184
ADDP4
INDIRF4
ARGF4
ADDRLP4 60
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 28
ARGP4
ADDRLP4 44
INDIRF4
CNSTF4 0
EQF4 $1611
ADDRLP4 56
ADDRGP4 $1609
ASGNP4
ADDRGP4 $1612
JUMPV
LABELV $1611
ADDRLP4 56
ADDRGP4 $1609
ASGNP4
LABELV $1612
ADDRLP4 56
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 16
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 220
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
line 3368
;3368:	}
LABELV $1608
line 3369
;3369:}
LABELV $1591
endproc Item_Bind_Paint 64 32
export Display_KeyBindPending
proc Display_KeyBindPending 0 0
line 3371
;3370:
;3371:qboolean Display_KeyBindPending() {
line 3372
;3372:	return g_waitingForKey;
ADDRGP4 g_waitingForKey
INDIRI4
RETI4
LABELV $1613
endproc Display_KeyBindPending 0 0
export Item_Bind_HandleKey
proc Item_Bind_HandleKey 24 12
line 3375
;3373:}
;3374:
;3375:qboolean Item_Bind_HandleKey(itemDef_t *item, int key, qboolean down) {
line 3379
;3376:	int			id;
;3377:	int			i;
;3378:
;3379:	if (Rect_ContainsPoint(&item->window.rect, DC->cursorx, DC->cursory) && !g_waitingForKey) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $1615
ADDRGP4 g_waitingForKey
INDIRI4
CNSTI4 0
NEI4 $1615
line 3380
;3380:		if (down && (key == K_MOUSE1 || key == K_ENTER)) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1617
ADDRLP4 16
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 178
EQI4 $1619
ADDRLP4 16
INDIRI4
CNSTI4 13
NEI4 $1617
LABELV $1619
line 3381
;3381:			g_waitingForKey = qtrue;
ADDRGP4 g_waitingForKey
CNSTI4 1
ASGNI4
line 3382
;3382:			g_bindItem = item;
ADDRGP4 g_bindItem
ADDRFP4 0
INDIRP4
ASGNP4
line 3383
;3383:		}
LABELV $1617
line 3384
;3384:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1614
JUMPV
LABELV $1615
line 3385
;3385:	} else {
line 3386
;3386:		if (!g_waitingForKey || g_bindItem == NULL) {
ADDRGP4 g_waitingForKey
INDIRI4
CNSTI4 0
EQI4 $1622
ADDRGP4 g_bindItem
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1620
LABELV $1622
line 3387
;3387:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1614
JUMPV
LABELV $1620
line 3390
;3388:		}
;3389:
;3390:		if (key & K_CHAR_FLAG) {
ADDRFP4 4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1623
line 3391
;3391:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1614
JUMPV
LABELV $1623
line 3394
;3392:		}
;3393:
;3394:		switch (key) {
ADDRLP4 16
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 96
EQI4 $1633
ADDRLP4 16
INDIRI4
CNSTI4 96
GTI4 $1635
LABELV $1634
ADDRFP4 4
INDIRI4
CNSTI4 27
EQI4 $1627
ADDRGP4 $1625
JUMPV
LABELV $1635
ADDRFP4 4
INDIRI4
CNSTI4 127
EQI4 $1628
ADDRGP4 $1625
JUMPV
LABELV $1627
line 3396
;3395:		case K_ESCAPE:
;3396:			g_waitingForKey = qfalse;
ADDRGP4 g_waitingForKey
CNSTI4 0
ASGNI4
line 3397
;3397:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1614
JUMPV
LABELV $1628
line 3400
;3398:
;3399:		case K_BACKSPACE:
;3400:			id = BindingIDFromName(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 BindingIDFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
ASGNI4
line 3401
;3401:			if (id != -1) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $1629
line 3402
;3402:				g_bindings[id].bind1 = -1;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
CNSTI4 -1
ASGNI4
line 3403
;3403:				g_bindings[id].bind2 = -1;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
CNSTI4 -1
ASGNI4
line 3404
;3404:			}
LABELV $1629
line 3405
;3405:			Controls_SetConfig(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 Controls_SetConfig
CALLV
pop
line 3406
;3406:			g_waitingForKey = qfalse;
ADDRGP4 g_waitingForKey
CNSTI4 0
ASGNI4
line 3407
;3407:			g_bindItem = NULL;
ADDRGP4 g_bindItem
CNSTP4 0
ASGNP4
line 3408
;3408:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1614
JUMPV
LABELV $1633
line 3411
;3409:
;3410:		case '`':
;3411:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1614
JUMPV
LABELV $1625
line 3413
;3412:		}
;3413:	}
line 3415
;3414:
;3415:	if (key != -1) {
ADDRFP4 4
INDIRI4
CNSTI4 -1
EQI4 $1636
line 3417
;3416:
;3417:		for (i = 0; i < g_bindCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1641
JUMPV
LABELV $1638
line 3419
;3418:
;3419:			if (g_bindings[i].bind2 == key) {
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1642
line 3420
;3420:				g_bindings[i].bind2 = -1;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
CNSTI4 -1
ASGNI4
line 3421
;3421:			}
LABELV $1642
line 3423
;3422:
;3423:			if (g_bindings[i].bind1 == key) {
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $1646
line 3424
;3424:				g_bindings[i].bind1 = g_bindings[i].bind2;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ASGNI4
line 3425
;3425:				g_bindings[i].bind2 = -1;
ADDRLP4 0
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
CNSTI4 -1
ASGNI4
line 3426
;3426:			}
LABELV $1646
line 3427
;3427:		}
LABELV $1639
line 3417
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1641
ADDRLP4 0
INDIRI4
ADDRGP4 g_bindCount
INDIRI4
LTI4 $1638
line 3428
;3428:	}
LABELV $1636
line 3431
;3429:
;3430:
;3431:	id = BindingIDFromName(item->cvar);
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 BindingIDFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 3433
;3432:
;3433:	if (id != -1) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $1652
line 3434
;3434:		if (key == -1) {
ADDRFP4 4
INDIRI4
CNSTI4 -1
NEI4 $1654
line 3435
;3435:			if (g_bindings[id].bind1 != -1) {
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1656
line 3436
;3436:				DC->setBinding(g_bindings[id].bind1, "");
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ARGI4
ADDRGP4 $54
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLV
pop
line 3437
;3437:				g_bindings[id].bind1 = -1;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
CNSTI4 -1
ASGNI4
line 3438
;3438:			}
LABELV $1656
line 3439
;3439:			if (g_bindings[id].bind2 != -1) {
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1655
line 3440
;3440:				DC->setBinding(g_bindings[id].bind2, "");
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 $54
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLV
pop
line 3441
;3441:				g_bindings[id].bind2 = -1;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
CNSTI4 -1
ASGNI4
line 3442
;3442:			}
line 3443
;3443:		} else if (g_bindings[id].bind1 == -1) {
ADDRGP4 $1655
JUMPV
LABELV $1654
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1666
line 3444
;3444:			g_bindings[id].bind1 = key;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 3445
;3445:		} else if (g_bindings[id].bind1 != key && g_bindings[id].bind2 == -1) {
ADDRGP4 $1667
JUMPV
LABELV $1666
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
EQI4 $1670
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1670
line 3446
;3446:			g_bindings[id].bind2 = key;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 3447
;3447:		} else {
ADDRGP4 $1671
JUMPV
LABELV $1670
line 3448
;3448:			DC->setBinding(g_bindings[id].bind1, "");
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
INDIRI4
ARGI4
ADDRGP4 $54
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLV
pop
line 3449
;3449:			DC->setBinding(g_bindings[id].bind2, "");
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 $54
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 144
ADDP4
INDIRP4
CALLV
pop
line 3450
;3450:			g_bindings[id].bind1 = key;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+16
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 3451
;3451:			g_bindings[id].bind2 = -1;
ADDRLP4 4
INDIRI4
CNSTI4 24
MULI4
ADDRGP4 g_bindings+20
ADDP4
CNSTI4 -1
ASGNI4
line 3452
;3452:		}
LABELV $1671
LABELV $1667
LABELV $1655
line 3453
;3453:	}
LABELV $1652
line 3455
;3454:
;3455:	Controls_SetConfig(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 Controls_SetConfig
CALLV
pop
line 3456
;3456:	g_waitingForKey = qfalse;
ADDRGP4 g_waitingForKey
CNSTI4 0
ASGNI4
line 3458
;3457:
;3458:	return qtrue;
CNSTI4 1
RETI4
LABELV $1614
endproc Item_Bind_HandleKey 24 12
export AdjustFrom640
proc AdjustFrom640 16 0
line 3463
;3459:}
;3460:
;3461:
;3462:
;3463:void AdjustFrom640(float *x, float *y, float *w, float *h) {
line 3465
;3464:	//*x = *x * DC->scale + DC->bias;
;3465:	*x *= DC->xscale;
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
CNSTI4 200
ADDP4
INDIRF4
MULF4
ASGNF4
line 3466
;3466:	*y *= DC->yscale;
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
CNSTI4 196
ADDP4
INDIRF4
MULF4
ASGNF4
line 3467
;3467:	*w *= DC->xscale;
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
CNSTI4 200
ADDP4
INDIRF4
MULF4
ASGNF4
line 3468
;3468:	*h *= DC->yscale;
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
CNSTI4 196
ADDP4
INDIRF4
MULF4
ASGNF4
line 3469
;3469:}
LABELV $1679
endproc AdjustFrom640 16 0
export Item_Model_Paint
proc Item_Model_Paint 588 16
line 3471
;3470:
;3471:void Item_Model_Paint(itemDef_t *item) {
line 3477
;3472:	float x, y, w, h;
;3473:	refdef_t refdef;
;3474:	refEntity_t		ent;
;3475:	vec3_t			mins, maxs, origin;
;3476:	vec3_t			angles;
;3477:	modelDef_t *modelPtr = (modelDef_t *)item->typeData;
ADDRLP4 508
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 3479
;3478:
;3479:	if (modelPtr == NULL) {
ADDRLP4 508
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1681
line 3480
;3480:		return;
ADDRGP4 $1680
JUMPV
LABELV $1681
line 3484
;3481:	}
;3482:
;3483:	// setup the refdef
;3484:	memset(&refdef, 0, sizeof(refdef));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3485
;3485:	refdef.rdflags = RDF_NOWORLDMODEL;
ADDRLP4 0+76
CNSTI4 1
ASGNI4
line 3486
;3486:	AxisClear(refdef.viewaxis);
ADDRLP4 0+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 3487
;3487:	x = item->window.rect.x + 1;
ADDRLP4 568
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3488
;3488:	y = item->window.rect.y + 1;
ADDRLP4 572
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3489
;3489:	w = item->window.rect.w - 2;
ADDRLP4 524
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 3490
;3490:	h = item->window.rect.h - 2;
ADDRLP4 528
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 3492
;3491:
;3492:	AdjustFrom640(&x, &y, &w, &h);
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
line 3494
;3493:
;3494:	refdef.x = x;
ADDRLP4 0
ADDRLP4 568
INDIRF4
CVFI4 4
ASGNI4
line 3495
;3495:	refdef.y = y;
ADDRLP4 0+4
ADDRLP4 572
INDIRF4
CVFI4 4
ASGNI4
line 3496
;3496:	refdef.width = w;
ADDRLP4 0+8
ADDRLP4 524
INDIRF4
CVFI4 4
ASGNI4
line 3497
;3497:	refdef.height = h;
ADDRLP4 0+12
ADDRLP4 528
INDIRF4
CVFI4 4
ASGNI4
line 3499
;3498:
;3499:	DC->modelBounds(item->asset, mins, maxs);
ADDRFP4 0
INDIRP4
CNSTI4 232
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
line 3501
;3500:
;3501:	origin[2] = -0.5 * (mins[2] + maxs[2]);
ADDRLP4 512+8
ADDRLP4 544+8
INDIRF4
ADDRLP4 556+8
INDIRF4
ADDF4
CNSTF4 3204448256
MULF4
ASGNF4
line 3502
;3502:	origin[1] = 0.5 * (mins[1] + maxs[1]);
ADDRLP4 512+4
ADDRLP4 544+4
INDIRF4
ADDRLP4 556+4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3505
;3503:
;3504:	// calculate distance so the model nearly fills the box
;3505:	if (qtrue) {
line 3506
;3506:		float len = 0.5 * (maxs[2] - mins[2]);
ADDRLP4 576
ADDRLP4 556+8
INDIRF4
ADDRLP4 544+8
INDIRF4
SUBF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3507
;3507:		origin[0] = len / 0.268;	// len / tan( fov/2 )
ADDRLP4 512
ADDRLP4 576
INDIRF4
CNSTF4 1081003604
MULF4
ASGNF4
line 3509
;3508:		//origin[0] = len / tan(w/2);
;3509:	} else {
ADDRGP4 $1695
JUMPV
LABELV $1694
line 3510
;3510:		origin[0] = item->textscale;
ADDRLP4 512
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ASGNF4
line 3511
;3511:	}
LABELV $1695
line 3512
;3512:	refdef.fov_x = (modelPtr->fov_x) ? modelPtr->fov_x : w;
ADDRLP4 508
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1700
ADDRLP4 576
ADDRLP4 508
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ASGNF4
ADDRGP4 $1701
JUMPV
LABELV $1700
ADDRLP4 576
ADDRLP4 524
INDIRF4
ASGNF4
LABELV $1701
ADDRLP4 0+16
ADDRLP4 576
INDIRF4
ASGNF4
line 3513
;3513:	refdef.fov_y = (modelPtr->fov_y) ? modelPtr->fov_y : h;
ADDRLP4 508
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1704
ADDRLP4 580
ADDRLP4 508
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
ADDRGP4 $1705
JUMPV
LABELV $1704
ADDRLP4 580
ADDRLP4 528
INDIRF4
ASGNF4
LABELV $1705
ADDRLP4 0+20
ADDRLP4 580
INDIRF4
ASGNF4
line 3520
;3514:
;3515:	//refdef.fov_x = (int)((float)refdef.width / 640.0f * 90.0f);
;3516:	//xx = refdef.width / tan( refdef.fov_x / 360 * M_PI );
;3517:	//refdef.fov_y = atan2( refdef.height, xx );
;3518:	//refdef.fov_y *= ( 360 / M_PI );
;3519:
;3520:	DC->clearScene();
ADDRGP4 DC
INDIRP4
CNSTI4 52
ADDP4
INDIRP4
CALLV
pop
line 3522
;3521:
;3522:	refdef.time = DC->realTime;
ADDRLP4 0+72
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ASGNI4
line 3526
;3523:
;3524:	// add the model
;3525:
;3526:	memset(&ent, 0, sizeof(ent));
ADDRLP4 368
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3533
;3527:
;3528:	//adjust = 5.0 * sin( (float)uis.realtime / 500 );
;3529:	//adjust = 360 % (int)((float)uis.realtime / 1000);
;3530:	//VectorSet( angles, 0, 0, 1 );
;3531:
;3532:	// use item storage to track
;3533:	if (modelPtr->rotationSpeed) {
ADDRLP4 508
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1707
line 3534
;3534:		if (DC->realTime > item->window.nextTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LEI4 $1709
line 3535
;3535:			item->window.nextTime = DC->realTime + modelPtr->rotationSpeed;
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 508
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3536
;3536:			modelPtr->angle = (int)(modelPtr->angle + 1) % 360;
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
line 3537
;3537:		}
LABELV $1709
line 3538
;3538:	}
LABELV $1707
line 3539
;3539:	VectorSet(angles, 0, modelPtr->angle, 0);
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
line 3540
;3540:	AnglesToAxis(angles, ent.axis);
ADDRLP4 532
ARGP4
ADDRLP4 368+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 3542
;3541:
;3542:	ent.hModel = item->asset;
ADDRLP4 368+8
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ASGNI4
line 3543
;3543:	VectorCopy(origin, ent.origin);
ADDRLP4 368+68
ADDRLP4 512
INDIRB
ASGNB 12
line 3544
;3544:	VectorCopy(origin, ent.lightingOrigin);
ADDRLP4 368+12
ADDRLP4 512
INDIRB
ASGNB 12
line 3545
;3545:	ent.renderfx = RF_LIGHTING_ORIGIN | RF_NOSHADOW;
ADDRLP4 368+4
CNSTI4 192
ASGNI4
line 3546
;3546:	VectorCopy(ent.origin, ent.oldorigin);
ADDRLP4 368+84
ADDRLP4 368+68
INDIRB
ASGNB 12
line 3548
;3547:
;3548:	DC->addRefEntityToScene(&ent);
ADDRLP4 368
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 56
ADDP4
INDIRP4
CALLV
pop
line 3549
;3549:	DC->renderScene(&refdef);
ADDRLP4 0
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 60
ADDP4
INDIRP4
CALLV
pop
line 3551
;3550:
;3551:}
LABELV $1680
endproc Item_Model_Paint 588 16
export Item_Image_Paint
proc Item_Image_Paint 4 20
line 3554
;3552:
;3553:
;3554:void Item_Image_Paint(itemDef_t *item) {
line 3555
;3555:	if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1721
line 3556
;3556:		return;
ADDRGP4 $1720
JUMPV
LABELV $1721
line 3558
;3557:	}
;3558:	DC->drawHandlePic(item->window.rect.x + 1, item->window.rect.y + 1, item->window.rect.w - 2, item->window.rect.h - 2, item->asset);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 232
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
line 3559
;3559:}
LABELV $1720
endproc Item_Image_Paint 4 20
export Item_ListBox_Paint
proc Item_ListBox_Paint 92 32
line 3561
;3560:
;3561:void Item_ListBox_Paint(itemDef_t *item) {
line 3565
;3562:	float x, y, size, count, i, thumb;
;3563:	qhandle_t image;
;3564:	qhandle_t optionalImage;
;3565:	listBoxDef_t *listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 3571
;3566:
;3567:	// the listbox is horizontal or vertical and has a fixed size scroll bar going either direction
;3568:	// elements are enumerated from the DC and either text or image handles are acquired from the DC as well
;3569:	// textscale is used to size the text, textalignx and textaligny are used to size image elements
;3570:	// there is no clipping available so only the last completely visible item is painted
;3571:	count = DC->feederCount(item->special);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 DC
INDIRP4
CNSTI4 120
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 36
INDIRI4
CVIF4 4
ASGNF4
line 3573
;3572:	// default is vertical if horizontal flag is not here
;3573:	if (item->window.flags & WINDOW_HORIZONTAL) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1724
line 3576
;3574:		// draw scrollbar in bottom of the window
;3575:		// bar
;3576:		x = item->window.rect.x + 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3577
;3577:		y = item->window.rect.y + item->window.rect.h - SCROLLBAR_SIZE - 1;
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 40
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
line 3578
;3578:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarArrowLeft);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 44
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 61900
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3579
;3579:		x += SCROLLBAR_SIZE - 1;
ADDRLP4 16
ADDRLP4 16
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 3580
;3580:		size = item->window.rect.w - (SCROLLBAR_SIZE * 2);
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 3581
;3581:		DC->drawHandlePic(x, y, size + 1, SCROLLBAR_SIZE, DC->Assets.scrollBar);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 48
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 61908
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3582
;3582:		x += size - 1;
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
CNSTF4 1065353216
SUBF4
ADDF4
ASGNF4
line 3583
;3583:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarArrowRight);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 61904
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3585
;3584:		// thumb
;3585:		thumb = Item_ListBox_ThumbDrawPosition(item);//Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 Item_ListBox_ThumbDrawPosition
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 56
INDIRI4
CVIF4 4
ASGNF4
line 3586
;3586:		if (thumb > x - SCROLLBAR_SIZE - 1) {
ADDRLP4 32
INDIRF4
ADDRLP4 16
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
LEF4 $1726
line 3587
;3587:			thumb = x - SCROLLBAR_SIZE - 1;
ADDRLP4 32
ADDRLP4 16
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 3588
;3588:		}
LABELV $1726
line 3589
;3589:		DC->drawHandlePic(thumb, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarThumb);
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 60
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 61912
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
line 3591
;3590:		//
;3591:		listPtr->endPos = listPtr->startPos;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 3592
;3592:		size = item->window.rect.w - 2;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 3595
;3593:		// items
;3594:		// size contains max available space
;3595:		if (listPtr->elementStyle == LISTBOX_IMAGE) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1725
line 3597
;3596:			// fit = 0;
;3597:			x = item->window.rect.x + 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3598
;3598:			y = item->window.rect.y + 1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3599
;3599:			for (i = listPtr->startPos; i < count; i++) {
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
ADDRGP4 $1733
JUMPV
LABELV $1730
line 3602
;3600:				// always draw at least one
;3601:				// which may overdraw the box if it is too small for the element
;3602:				image = DC->feederItemImage(item->special, i);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 68
ADDRGP4 DC
INDIRP4
CNSTI4 128
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 68
INDIRI4
ASGNI4
line 3603
;3603:				if (image) {
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1734
line 3604
;3604:					DC->drawHandlePic(x + 1, y + 1, listPtr->elementWidth - 2, listPtr->elementHeight - 2, image);
ADDRLP4 16
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3605
;3605:				}
LABELV $1734
line 3607
;3606:
;3607:				if (i == item->cursorPos) {
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CVIF4 4
NEF4 $1736
line 3608
;3608:					DC->drawRect(x, y, listPtr->elementWidth - 1, listPtr->elementHeight - 1, item->window.borderSize, item->window.borderColor);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 1065353216
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1065353216
SUBF4
ARGF4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRLP4 76
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 3609
;3609:				}
LABELV $1736
line 3611
;3610:
;3611:				size -= listPtr->elementWidth;
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3612
;3612:				if (size < listPtr->elementWidth) {
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
GEF4 $1738
line 3613
;3613:					listPtr->drawPadding = size; //listPtr->elementWidth - size;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 20
INDIRF4
CVFI4 4
ASGNI4
line 3614
;3614:					break;
ADDRGP4 $1725
JUMPV
LABELV $1738
line 3616
;3615:				}
;3616:				x += listPtr->elementWidth;
ADDRLP4 16
ADDRLP4 16
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3617
;3617:				listPtr->endPos++;
ADDRLP4 72
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3619
;3618:				// fit++;
;3619:			}
LABELV $1731
line 3599
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $1733
ADDRLP4 4
INDIRF4
ADDRLP4 28
INDIRF4
LTF4 $1730
line 3620
;3620:		} else {
line 3622
;3621:			//
;3622:		}
line 3623
;3623:	} else {
ADDRGP4 $1725
JUMPV
LABELV $1724
line 3625
;3624:		// draw scrollbar to right side of the window
;3625:		x = item->window.rect.x + item->window.rect.w - SCROLLBAR_SIZE - 1;
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 40
INDIRP4
INDIRF4
ADDRLP4 40
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
line 3626
;3626:		y = item->window.rect.y + 1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3627
;3627:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarArrowUp);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 44
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 61892
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3628
;3628:		y += SCROLLBAR_SIZE - 1;
ADDRLP4 12
ADDRLP4 12
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 3630
;3629:
;3630:		listPtr->endPos = listPtr->startPos;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 3631
;3631:		size = item->window.rect.h - (SCROLLBAR_SIZE * 2);
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 3632
;3632:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, size + 1, DC->Assets.scrollBar);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 20
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 52
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 61908
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3633
;3633:		y += size - 1;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 20
INDIRF4
CNSTF4 1065353216
SUBF4
ADDF4
ASGNF4
line 3634
;3634:		DC->drawHandlePic(x, y, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarArrowDown);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 56
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 61896
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3636
;3635:		// thumb
;3636:		thumb = Item_ListBox_ThumbDrawPosition(item);//Item_ListBox_ThumbPosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 Item_ListBox_ThumbDrawPosition
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 60
INDIRI4
CVIF4 4
ASGNF4
line 3637
;3637:		if (thumb > y - SCROLLBAR_SIZE - 1) {
ADDRLP4 32
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
LEF4 $1740
line 3638
;3638:			thumb = y - SCROLLBAR_SIZE - 1;
ADDRLP4 32
ADDRLP4 12
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1065353216
SUBF4
ASGNF4
line 3639
;3639:		}
LABELV $1740
line 3640
;3640:		DC->drawHandlePic(x, thumb, SCROLLBAR_SIZE, SCROLLBAR_SIZE, DC->Assets.scrollBarThumb);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
CNSTF4 1098907648
ARGF4
CNSTF4 1098907648
ARGF4
ADDRLP4 64
ADDRGP4 DC
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 61912
ADDP4
INDIRI4
ARGI4
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3643
;3641:
;3642:		// adjust size for item painting
;3643:		size = item->window.rect.h - 2;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 3644
;3644:		if (listPtr->elementStyle == LISTBOX_IMAGE) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1742
line 3646
;3645:			// fit = 0;
;3646:			x = item->window.rect.x + 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3647
;3647:			y = item->window.rect.y + 1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3648
;3648:			for (i = listPtr->startPos; i < count; i++) {
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
ADDRGP4 $1747
JUMPV
LABELV $1744
line 3651
;3649:				// always draw at least one
;3650:				// which may overdraw the box if it is too small for the element
;3651:				image = DC->feederItemImage(item->special, i);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 68
ADDRGP4 DC
INDIRP4
CNSTI4 128
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 68
INDIRI4
ASGNI4
line 3652
;3652:				if (image) {
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $1748
line 3653
;3653:					DC->drawHandlePic(x + 1, y + 1, listPtr->elementWidth - 2, listPtr->elementHeight - 2, image);
ADDRLP4 16
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
CNSTF4 1065353216
ADDF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1073741824
SUBF4
ARGF4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3654
;3654:				}
LABELV $1748
line 3656
;3655:
;3656:				if (i == item->cursorPos) {
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CVIF4 4
NEF4 $1750
line 3657
;3657:					DC->drawRect(x, y, listPtr->elementWidth - 1, listPtr->elementHeight - 1, item->window.borderSize, item->window.borderColor);
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
CNSTF4 1065353216
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1065353216
SUBF4
ARGF4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 64
ADDP4
INDIRF4
ARGF4
ADDRLP4 76
INDIRP4
CNSTI4 144
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 3658
;3658:				}
LABELV $1750
line 3660
;3659:
;3660:				listPtr->endPos++;
ADDRLP4 72
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3661
;3661:				size -= listPtr->elementWidth;
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3662
;3662:				if (size < listPtr->elementHeight) {
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
GEF4 $1752
line 3663
;3663:					listPtr->drawPadding = listPtr->elementHeight - size;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
CVFI4 4
ASGNI4
line 3664
;3664:					break;
ADDRGP4 $1743
JUMPV
LABELV $1752
line 3666
;3665:				}
;3666:				y += listPtr->elementHeight;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3668
;3667:				// fit++;
;3668:			}
LABELV $1745
line 3648
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $1747
ADDRLP4 4
INDIRF4
ADDRLP4 28
INDIRF4
LTF4 $1744
line 3669
;3669:		} else {
ADDRGP4 $1743
JUMPV
LABELV $1742
line 3670
;3670:			x = item->window.rect.x + 1;
ADDRLP4 16
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3671
;3671:			y = item->window.rect.y + 1;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 3672
;3672:			for (i = listPtr->startPos; i < count; i++) {
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI4
CVIF4 4
ASGNF4
ADDRGP4 $1757
JUMPV
LABELV $1754
line 3677
;3673:				const char *text;
;3674:				// always draw at least one
;3675:				// which may overdraw the box if it is too small for the element
;3676:
;3677:				if (listPtr->numColumns > 0) {
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1758
line 3679
;3678:					int j;
;3679:					for (j = 0; j < listPtr->numColumns; j++) {
ADDRLP4 72
CNSTI4 0
ASGNI4
ADDRGP4 $1763
JUMPV
LABELV $1760
line 3680
;3680:						text = DC->feederItemText(item->special, i, j, &optionalImage);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 76
ADDRGP4 DC
INDIRP4
CNSTI4 124
ADDP4
INDIRP4
CALLP4
ASGNP4
ADDRLP4 68
ADDRLP4 76
INDIRP4
ASGNP4
line 3681
;3681:						if (optionalImage >= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $1764
line 3682
;3682:							DC->drawHandlePic(x + 4 + listPtr->columnInfo[j].pos, y - 1 + listPtr->elementHeight / 2, listPtr->columnInfo[j].width, listPtr->columnInfo[j].width, optionalImage);
ADDRLP4 16
INDIRF4
CNSTF4 1082130432
ADDF4
ADDRLP4 72
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDP4
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
CNSTF4 1065353216
SUBF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1056964608
MULF4
ADDF4
ARGF4
ADDRLP4 72
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 72
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 32
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
ADDRGP4 DC
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
CALLV
pop
line 3683
;3683:						} else if (text) {
ADDRGP4 $1765
JUMPV
LABELV $1764
ADDRLP4 68
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1766
line 3684
;3684:							DC->drawText(x + 4 + listPtr->columnInfo[j].pos, y + listPtr->elementHeight, item->textscale, item->window.foreColor, text, 0, listPtr->columnInfo[j].maxChars, item->textStyle);
ADDRLP4 16
INDIRF4
CNSTF4 1082130432
ADDF4
ADDRLP4 72
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDP4
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 88
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 72
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
INDIRP4
CNSTI4 220
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
line 3685
;3685:						}
LABELV $1766
LABELV $1765
line 3686
;3686:					}
LABELV $1761
line 3679
ADDRLP4 72
ADDRLP4 72
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1763
ADDRLP4 72
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
LTI4 $1760
line 3687
;3687:				} else {
ADDRGP4 $1759
JUMPV
LABELV $1758
line 3688
;3688:					text = DC->feederItemText(item->special, i, 0, &optionalImage);
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 72
ADDRGP4 DC
INDIRP4
CNSTI4 124
ADDP4
INDIRP4
CALLP4
ASGNP4
ADDRLP4 68
ADDRLP4 72
INDIRP4
ASGNP4
line 3689
;3689:					if (optionalImage >= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $1768
line 3691
;3690:						//DC->drawHandlePic(x + 4 + listPtr->elementHeight, y, listPtr->columnInfo[j].width, listPtr->columnInfo[j].width, optionalImage);
;3691:					} else if (text) {
ADDRGP4 $1769
JUMPV
LABELV $1768
ADDRLP4 68
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1770
line 3692
;3692:						DC->drawText(x + 4, y + listPtr->elementHeight, item->textscale, item->window.foreColor, text, 0, 0, item->textStyle);
ADDRLP4 16
INDIRF4
CNSTF4 1082130432
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
ARGF4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 76
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 76
INDIRP4
CNSTI4 220
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
line 3693
;3693:					}
LABELV $1770
LABELV $1769
line 3694
;3694:				}
LABELV $1759
line 3696
;3695:
;3696:				if (i == item->cursorPos) {
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CVIF4 4
NEF4 $1772
line 3697
;3697:					DC->fillRect(x + 2, y + 2, item->window.rect.w - SCROLLBAR_SIZE - 4, listPtr->elementHeight, item->window.outlineColor);
ADDRLP4 16
INDIRF4
CNSTF4 1073741824
ADDF4
ARGF4
ADDRLP4 12
INDIRF4
CNSTF4 1073741824
ADDF4
ARGF4
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ARGF4
ADDRLP4 72
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 36
ADDP4
INDIRP4
CALLV
pop
line 3698
;3698:				}
LABELV $1772
line 3700
;3699:
;3700:				size -= listPtr->elementHeight;
ADDRLP4 20
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3701
;3701:				if (size < listPtr->elementHeight) {
ADDRLP4 20
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
GEF4 $1774
line 3702
;3702:					listPtr->drawPadding = listPtr->elementHeight - size;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
CVFI4 4
ASGNI4
line 3703
;3703:					break;
ADDRGP4 $1756
JUMPV
LABELV $1774
line 3705
;3704:				}
;3705:				listPtr->endPos++;
ADDRLP4 72
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3706
;3706:				y += listPtr->elementHeight;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3708
;3707:				// fit++;
;3708:			}
LABELV $1755
line 3672
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
ADDF4
ASGNF4
LABELV $1757
ADDRLP4 4
INDIRF4
ADDRLP4 28
INDIRF4
LTF4 $1754
LABELV $1756
line 3709
;3709:		}
LABELV $1743
line 3710
;3710:	}
LABELV $1725
line 3711
;3711:}
LABELV $1723
endproc Item_ListBox_Paint 92 32
export Item_OwnerDraw_Paint
proc Item_OwnerDraw_Paint 72 56
line 3714
;3712:
;3713:
;3714:void Item_OwnerDraw_Paint(itemDef_t *item) {
line 3717
;3715:	menuDef_t *parent;
;3716:
;3717:	if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1777
line 3718
;3718:		return;
ADDRGP4 $1776
JUMPV
LABELV $1777
line 3720
;3719:	}
;3720:	parent = (menuDef_t *)item->parent;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3722
;3721:
;3722:	if (DC->ownerDrawItem) {
ADDRGP4 DC
INDIRP4
CNSTI4 68
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1779
line 3724
;3723:		vec4_t color, lowLight;
;3724:		menuDef_t *parent = (menuDef_t *)item->parent;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3725
;3725:		Fade(&item->window.flags, &item->window.foreColor[3], parent->fadeClamp, &item->window.nextTime, parent->fadeCycle, qtrue, parent->fadeAmount);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 68
ADDP4
ARGP4
ADDRLP4 40
INDIRP4
CNSTI4 124
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 204
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 108
ADDP4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 20
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ARGF4
ADDRGP4 Fade
CALLV
pop
line 3726
;3726:		memcpy(&color, &item->window.foreColor, sizeof(color));
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3727
;3727:		if (item->numColors > 0 && DC->getValue) {
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1781
ADDRGP4 DC
INDIRP4
CNSTI4 72
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1781
line 3730
;3728:			// if the value is within one of the ranges then set color to that, otherwise leave at default
;3729:			int i;
;3730:			float f = DC->getValue(item->window.ownerDraw);
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 DC
INDIRP4
CNSTI4 72
ADDP4
INDIRP4
CALLF4
ASGNF4
ADDRLP4 52
ADDRLP4 56
INDIRF4
ASGNF4
line 3731
;3731:			for (i = 0; i < item->numColors; i++) {
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRGP4 $1786
JUMPV
LABELV $1783
line 3732
;3732:				if (f >= item->colorRanges[i].low && f <= item->colorRanges[i].high) {
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRF4
ADDRLP4 48
INDIRI4
CNSTI4 24
MULI4
ADDRLP4 68
INDIRP4
CNSTI4 288
ADDP4
ADDP4
CNSTI4 16
ADDP4
INDIRF4
LTF4 $1787
ADDRLP4 52
INDIRF4
ADDRLP4 48
INDIRI4
CNSTI4 24
MULI4
ADDRLP4 68
INDIRP4
CNSTI4 288
ADDP4
ADDP4
CNSTI4 20
ADDP4
INDIRF4
GTF4 $1787
line 3733
;3733:					memcpy(&color, &item->colorRanges[i].color, sizeof(color));
ADDRLP4 4
ARGP4
ADDRLP4 48
INDIRI4
CNSTI4 24
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 288
ADDP4
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3734
;3734:					break;
ADDRGP4 $1785
JUMPV
LABELV $1787
line 3736
;3735:				}
;3736:			}
LABELV $1784
line 3731
ADDRLP4 48
ADDRLP4 48
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1786
ADDRLP4 48
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
LTI4 $1783
LABELV $1785
line 3737
;3737:		}
LABELV $1781
line 3739
;3738:
;3739:		if (item->window.flags & WINDOW_HASFOCUS) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1789
line 3740
;3740:			lowLight[0] = 0.8 * parent->focusColor[0];
ADDRLP4 24
ADDRLP4 20
INDIRP4
CNSTI4 228
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3741
;3741:			lowLight[1] = 0.8 * parent->focusColor[1];
ADDRLP4 24+4
ADDRLP4 20
INDIRP4
CNSTI4 232
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3742
;3742:			lowLight[2] = 0.8 * parent->focusColor[2];
ADDRLP4 24+8
ADDRLP4 20
INDIRP4
CNSTI4 236
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3743
;3743:			lowLight[3] = 0.8 * parent->focusColor[3];
ADDRLP4 24+12
ADDRLP4 20
INDIRP4
CNSTI4 240
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3744
;3744:			LerpColor(parent->focusColor, lowLight, color, 0.5 + 0.5 * sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 48
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 20
INDIRP4
CNSTI4 228
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 48
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3745
;3745:		} else if (item->textStyle == ITEM_TEXTSTYLE_BLINK && !((DC->realTime / BLINK_DIVISOR) & 1)) {
ADDRGP4 $1790
JUMPV
LABELV $1789
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1794
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 200
DIVI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $1794
line 3746
;3746:			lowLight[0] = 0.8 * item->window.foreColor[0];
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3747
;3747:			lowLight[1] = 0.8 * item->window.foreColor[1];
ADDRLP4 24+4
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3748
;3748:			lowLight[2] = 0.8 * item->window.foreColor[2];
ADDRLP4 24+8
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3749
;3749:			lowLight[3] = 0.8 * item->window.foreColor[3];
ADDRLP4 24+12
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
INDIRF4
CNSTF4 1061997773
MULF4
ASGNF4
line 3750
;3750:			LerpColor(item->window.foreColor, lowLight, color, 0.5 + 0.5 * sin(DC->realTime / PULSE_DIVISOR));
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 48
ADDRGP4 sin
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 48
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 3751
;3751:		}
LABELV $1794
LABELV $1790
line 3753
;3752:
;3753:		if (item->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(item, CVAR_ENABLE)) {
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $1799
ADDRLP4 48
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 52
ADDRGP4 Item_EnableShowViaCvar
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $1799
line 3754
;3754:			memcpy(color, parent->disableColor, sizeof(vec4_t)); // bk001207 - FIXME: Com_Memcpy
ADDRLP4 4
ARGP4
ADDRLP4 20
INDIRP4
CNSTI4 244
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 3755
;3755:		}
LABELV $1799
line 3757
;3756:
;3757:		if (item->text) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1801
line 3758
;3758:			Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3759
;3759:			if (item->text[0]) {
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1803
line 3761
;3760:				// +8 is an offset kludge to properly align owner draw items that have text combined with them
;3761:				DC->ownerDrawItem(item->textRect.x + item->textRect.w + 8, item->window.rect.y, item->window.rect.w, item->window.rect.h, 0, item->textaligny, item->window.ownerDraw, item->window.ownerDrawFlags, item->alignment, item->special, item->textscale, color, item->window.background, item->textStyle);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
CNSTF4 1090519040
ADDF4
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
CNSTF4 0
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
ARGP4
ADDRLP4 56
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 220
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
line 3762
;3762:			} else {
ADDRGP4 $1802
JUMPV
LABELV $1803
line 3763
;3763:				DC->ownerDrawItem(item->textRect.x + item->textRect.w, item->window.rect.y, item->window.rect.w, item->window.rect.h, 0, item->textaligny, item->window.ownerDraw, item->window.ownerDrawFlags, item->alignment, item->special, item->textscale, color, item->window.background, item->textStyle);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 180
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 188
ADDP4
INDIRF4
ADDF4
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
CNSTF4 0
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
ARGP4
ADDRLP4 56
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 220
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
line 3764
;3764:			}
line 3765
;3765:		} else {
ADDRGP4 $1802
JUMPV
LABELV $1801
line 3766
;3766:			DC->ownerDrawItem(item->window.rect.x, item->window.rect.y, item->window.rect.w, item->window.rect.h, item->textalignx, item->textaligny, item->window.ownerDraw, item->window.ownerDrawFlags, item->alignment, item->special, item->textscale, color, item->window.background, item->textStyle);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
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
ADDRLP4 56
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 212
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
INDIRP4
CNSTI4 216
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
ARGP4
ADDRLP4 56
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 56
INDIRP4
CNSTI4 220
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
line 3767
;3767:		}
LABELV $1802
line 3768
;3768:	}
LABELV $1779
line 3769
;3769:}
LABELV $1776
endproc Item_OwnerDraw_Paint 72 56
export Item_Paint
proc Item_Paint 84 24
line 3772
;3770:
;3771:
;3772:void Item_Paint(itemDef_t *item) {
line 3774
;3773:	vec4_t red;
;3774:	menuDef_t *parent = (menuDef_t *)item->parent;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 228
ADDP4
INDIRP4
ASGNP4
line 3775
;3775:	red[0] = red[3] = 1;
ADDRLP4 20
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+12
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 3776
;3776:	red[1] = red[2] = 0;
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 24
INDIRF4
ASGNF4
line 3778
;3777:
;3778:	if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1809
line 3779
;3779:		return;
ADDRGP4 $1805
JUMPV
LABELV $1809
line 3782
;3780:	}
;3781:
;3782:	if (item->window.flags & WINDOW_ORBITING) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 65536
BANDI4
CNSTI4 0
EQI4 $1811
line 3783
;3783:		if (DC->realTime > item->window.nextTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LEI4 $1813
line 3786
;3784:			float rx, ry, a, c, s, w, h;
;3785:
;3786:			item->window.nextTime = DC->realTime + item->window.offsetTime;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 108
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 56
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3788
;3787:			// translate
;3788:			w = item->window.rectClient.w / 2;
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3789
;3789:			h = item->window.rectClient.h / 2;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 3790
;3790:			rx = item->window.rectClient.x + w - item->window.rectEffects.x;
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 60
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 48
INDIRF4
ADDF4
ADDRLP4 60
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3791
;3791:			ry = item->window.rectClient.y + h - item->window.rectEffects.y;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 52
INDIRF4
ADDF4
ADDRLP4 64
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3792
;3792:			a = 3 * M_PI / 180;
ADDRLP4 36
CNSTF4 1029076816
ASGNF4
line 3793
;3793:			c = cos(a);
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 68
INDIRF4
ASGNF4
line 3794
;3794:			s = sin(a);
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 72
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 72
INDIRF4
ASGNF4
line 3795
;3795:			item->window.rectClient.x = (rx * c - ry * s) + item->window.rectEffects.x - w;
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 28
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ADDRLP4 32
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
SUBF4
ADDRLP4 76
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ADDF4
ADDRLP4 48
INDIRF4
SUBF4
ASGNF4
line 3796
;3796:			item->window.rectClient.y = (rx * s + ry * c) + item->window.rectEffects.y - h;
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 28
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ADDRLP4 32
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ADDF4
ADDRLP4 80
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ADDF4
ADDRLP4 52
INDIRF4
SUBF4
ASGNF4
line 3797
;3797:			Item_UpdatePosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_UpdatePosition
CALLV
pop
line 3799
;3798:
;3799:		}
LABELV $1813
line 3800
;3800:	}
LABELV $1811
line 3803
;3801:
;3802:
;3803:	if (item->window.flags & WINDOW_INTRANSITION) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $1815
line 3804
;3804:		if (DC->realTime > item->window.nextTime) {
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
LEI4 $1817
line 3805
;3805:			int done = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 3806
;3806:			item->window.nextTime = DC->realTime + item->window.offsetTime;
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 108
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ADDI4
ASGNI4
line 3808
;3807:			// transition the x,y
;3808:			if (item->window.rectClient.x == item->window.rectEffects.x) {
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
NEF4 $1819
line 3809
;3809:				done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3810
;3810:			} else {
ADDRGP4 $1820
JUMPV
LABELV $1819
line 3811
;3811:				if (item->window.rectClient.x < item->window.rectEffects.x) {
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
GEF4 $1821
line 3812
;3812:					item->window.rectClient.x += item->window.rectEffects2.x;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
ADDRLP4 44
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3813
;3813:					if (item->window.rectClient.x > item->window.rectEffects.x) {
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
CNSTI4 72
ADDP4
INDIRF4
LEF4 $1822
line 3814
;3814:						item->window.rectClient.x = item->window.rectEffects.x;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ASGNF4
line 3815
;3815:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3816
;3816:					}
line 3817
;3817:				} else {
ADDRGP4 $1822
JUMPV
LABELV $1821
line 3818
;3818:					item->window.rectClient.x -= item->window.rectEffects2.x;
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
ADDRLP4 44
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 88
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3819
;3819:					if (item->window.rectClient.x < item->window.rectEffects.x) {
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
CNSTI4 72
ADDP4
INDIRF4
GEF4 $1825
line 3820
;3820:						item->window.rectClient.x = item->window.rectEffects.x;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 56
INDIRP4
CNSTI4 72
ADDP4
INDIRF4
ASGNF4
line 3821
;3821:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3822
;3822:					}
LABELV $1825
line 3823
;3823:				}
LABELV $1822
line 3824
;3824:			}
LABELV $1820
line 3825
;3825:			if (item->window.rectClient.y == item->window.rectEffects.y) {
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
NEF4 $1827
line 3826
;3826:				done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3827
;3827:			} else {
ADDRGP4 $1828
JUMPV
LABELV $1827
line 3828
;3828:				if (item->window.rectClient.y < item->window.rectEffects.y) {
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
GEF4 $1829
line 3829
;3829:					item->window.rectClient.y += item->window.rectEffects2.y;
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
ADDRLP4 48
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3830
;3830:					if (item->window.rectClient.y > item->window.rectEffects.y) {
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
CNSTI4 76
ADDP4
INDIRF4
LEF4 $1830
line 3831
;3831:						item->window.rectClient.y = item->window.rectEffects.y;
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ASGNF4
line 3832
;3832:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3833
;3833:					}
line 3834
;3834:				} else {
ADDRGP4 $1830
JUMPV
LABELV $1829
line 3835
;3835:					item->window.rectClient.y -= item->window.rectEffects2.y;
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
ADDRLP4 48
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3836
;3836:					if (item->window.rectClient.y < item->window.rectEffects.y) {
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
CNSTI4 76
ADDP4
INDIRF4
GEF4 $1833
line 3837
;3837:						item->window.rectClient.y = item->window.rectEffects.y;
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 76
ADDP4
INDIRF4
ASGNF4
line 3838
;3838:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3839
;3839:					}
LABELV $1833
line 3840
;3840:				}
LABELV $1830
line 3841
;3841:			}
LABELV $1828
line 3842
;3842:			if (item->window.rectClient.w == item->window.rectEffects.w) {
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 44
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
NEF4 $1835
line 3843
;3843:				done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3844
;3844:			} else {
ADDRGP4 $1836
JUMPV
LABELV $1835
line 3845
;3845:				if (item->window.rectClient.w < item->window.rectEffects.w) {
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
GEF4 $1837
line 3846
;3846:					item->window.rectClient.w += item->window.rectEffects2.w;
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 52
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3847
;3847:					if (item->window.rectClient.w > item->window.rectEffects.w) {
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
CNSTI4 80
ADDP4
INDIRF4
LEF4 $1838
line 3848
;3848:						item->window.rectClient.w = item->window.rectEffects.w;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ASGNF4
line 3849
;3849:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3850
;3850:					}
line 3851
;3851:				} else {
ADDRGP4 $1838
JUMPV
LABELV $1837
line 3852
;3852:					item->window.rectClient.w -= item->window.rectEffects2.w;
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 52
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3853
;3853:					if (item->window.rectClient.w < item->window.rectEffects.w) {
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
CNSTI4 80
ADDP4
INDIRF4
GEF4 $1841
line 3854
;3854:						item->window.rectClient.w = item->window.rectEffects.w;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 80
ADDP4
INDIRF4
ASGNF4
line 3855
;3855:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3856
;3856:					}
LABELV $1841
line 3857
;3857:				}
LABELV $1838
line 3858
;3858:			}
LABELV $1836
line 3859
;3859:			if (item->window.rectClient.h == item->window.rectEffects.h) {
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
NEF4 $1843
line 3860
;3860:				done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3861
;3861:			} else {
ADDRGP4 $1844
JUMPV
LABELV $1843
line 3862
;3862:				if (item->window.rectClient.h < item->window.rectEffects.h) {
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
GEF4 $1845
line 3863
;3863:					item->window.rectClient.h += item->window.rectEffects2.h;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
ADDRLP4 56
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDF4
ASGNF4
line 3864
;3864:					if (item->window.rectClient.h > item->window.rectEffects.h) {
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
CNSTI4 84
ADDP4
INDIRF4
LEF4 $1846
line 3865
;3865:						item->window.rectClient.h = item->window.rectEffects.h;
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ASGNF4
line 3866
;3866:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3867
;3867:					}
line 3868
;3868:				} else {
ADDRGP4 $1846
JUMPV
LABELV $1845
line 3869
;3869:					item->window.rectClient.h -= item->window.rectEffects2.h;
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
ADDRLP4 56
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 56
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3870
;3870:					if (item->window.rectClient.h < item->window.rectEffects.h) {
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
CNSTI4 84
ADDP4
INDIRF4
GEF4 $1849
line 3871
;3871:						item->window.rectClient.h = item->window.rectEffects.h;
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 84
ADDP4
INDIRF4
ASGNF4
line 3872
;3872:						done++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3873
;3873:					}
LABELV $1849
line 3874
;3874:				}
LABELV $1846
line 3875
;3875:			}
LABELV $1844
line 3877
;3876:
;3877:			Item_UpdatePosition(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_UpdatePosition
CALLV
pop
line 3879
;3878:
;3879:			if (done == 4) {
ADDRLP4 28
INDIRI4
CNSTI4 4
NEI4 $1851
line 3880
;3880:				item->window.flags &= ~WINDOW_INTRANSITION;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 3881
;3881:			}
LABELV $1851
line 3883
;3882:
;3883:		}
LABELV $1817
line 3884
;3884:	}
LABELV $1815
line 3886
;3885:
;3886:	if (item->window.ownerDrawFlags && DC->ownerDrawVisible) {
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1853
ADDRGP4 DC
INDIRP4
CNSTI4 76
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1853
line 3887
;3887:		if (!DC->ownerDrawVisible(item->window.ownerDrawFlags)) {
ADDRFP4 0
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 DC
INDIRP4
CNSTI4 76
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $1855
line 3888
;3888:			item->window.flags &= ~WINDOW_VISIBLE;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 -5
BANDI4
ASGNI4
line 3889
;3889:		} else {
ADDRGP4 $1856
JUMPV
LABELV $1855
line 3890
;3890:			item->window.flags |= WINDOW_VISIBLE;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 3891
;3891:		}
LABELV $1856
line 3892
;3892:	}
LABELV $1853
line 3894
;3893:
;3894:	if (item->cvarFlags & (CVAR_SHOW | CVAR_HIDE)) {
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $1857
line 3895
;3895:		if (!Item_EnableShowViaCvar(item, CVAR_SHOW)) {
ADDRFP4 0
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
NEI4 $1859
line 3896
;3896:			return;
ADDRGP4 $1805
JUMPV
LABELV $1859
line 3898
;3897:		}
;3898:	}
LABELV $1857
line 3900
;3899:
;3900:	if (item->window.flags & WINDOW_TIMEDVISIBLE) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 8388608
BANDI4
CNSTI4 0
EQI4 $1861
line 3902
;3901:
;3902:	}
LABELV $1861
line 3904
;3903:
;3904:	if (!(item->window.flags & WINDOW_VISIBLE)) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $1863
line 3905
;3905:		return;
ADDRGP4 $1805
JUMPV
LABELV $1863
line 3909
;3906:	}
;3907:
;3908:	// paint the rect first.. 
;3909:	Window_Paint(&item->window, parent->fadeAmount, parent->fadeClamp, parent->fadeCycle);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 204
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 Window_Paint
CALLV
pop
line 3911
;3910:
;3911:	if (debugMode) {
ADDRGP4 debugMode
INDIRI4
CNSTI4 0
EQI4 $1865
line 3913
;3912:		vec4_t color;
;3913:		rectDef_t *r = Item_CorrectedTextRect(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 Item_CorrectedTextRect
CALLP4
ASGNP4
ADDRLP4 32
ADDRLP4 52
INDIRP4
ASGNP4
line 3914
;3914:		color[1] = color[3] = 1;
ADDRLP4 56
CNSTF4 1065353216
ASGNF4
ADDRLP4 36+12
ADDRLP4 56
INDIRF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 56
INDIRF4
ASGNF4
line 3915
;3915:		color[0] = color[2] = 0;
ADDRLP4 60
CNSTF4 0
ASGNF4
ADDRLP4 36+8
ADDRLP4 60
INDIRF4
ASGNF4
ADDRLP4 36
ADDRLP4 60
INDIRF4
ASGNF4
line 3916
;3916:		DC->drawRect(r->x, r->y, r->w, r->h, 1, color);
ADDRLP4 32
INDIRP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 36
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 3917
;3917:	}
LABELV $1865
line 3921
;3918:
;3919:	//DC->drawRect(item->window.rect.x, item->window.rect.y, item->window.rect.w, item->window.rect.h, 1, red);
;3920:
;3921:	switch (item->type) {
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
LTI4 $1871
ADDRLP4 32
INDIRI4
CNSTI4 13
GTI4 $1871
ADDRLP4 32
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1885
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $1885
address $1874
address $1874
address $1871
address $1871
address $1877
address $1871
address $1879
address $1880
address $1873
address $1877
address $1884
address $1881
address $1882
address $1883
code
LABELV $1873
line 3923
;3922:	case ITEM_TYPE_OWNERDRAW:
;3923:		Item_OwnerDraw_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_OwnerDraw_Paint
CALLV
pop
line 3924
;3924:		break;
ADDRGP4 $1871
JUMPV
LABELV $1874
line 3927
;3925:	case ITEM_TYPE_TEXT:
;3926:	case ITEM_TYPE_BUTTON:
;3927:		Item_Text_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Text_Paint
CALLV
pop
line 3928
;3928:		break;
ADDRGP4 $1871
JUMPV
line 3930
;3929:	case ITEM_TYPE_RADIOBUTTON:
;3930:		break;
line 3932
;3931:	case ITEM_TYPE_CHECKBOX:
;3932:		break;
LABELV $1877
line 3935
;3933:	case ITEM_TYPE_EDITFIELD:
;3934:	case ITEM_TYPE_NUMERICFIELD:
;3935:		Item_TextField_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_TextField_Paint
CALLV
pop
line 3936
;3936:		break;
ADDRGP4 $1871
JUMPV
line 3938
;3937:	case ITEM_TYPE_COMBO:
;3938:		break;
LABELV $1879
line 3940
;3939:	case ITEM_TYPE_LISTBOX:
;3940:		Item_ListBox_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ListBox_Paint
CALLV
pop
line 3941
;3941:		break;
ADDRGP4 $1871
JUMPV
LABELV $1880
line 3946
;3942:		//case ITEM_TYPE_IMAGE:
;3943:		//  Item_Image_Paint(item);
;3944:		//  break;
;3945:	case ITEM_TYPE_MODEL:
;3946:		Item_Model_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Model_Paint
CALLV
pop
line 3947
;3947:		break;
ADDRGP4 $1871
JUMPV
LABELV $1881
line 3949
;3948:	case ITEM_TYPE_YESNO:
;3949:		Item_YesNo_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_YesNo_Paint
CALLV
pop
line 3950
;3950:		break;
ADDRGP4 $1871
JUMPV
LABELV $1882
line 3952
;3951:	case ITEM_TYPE_MULTI:
;3952:		Item_Multi_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Multi_Paint
CALLV
pop
line 3953
;3953:		break;
ADDRGP4 $1871
JUMPV
LABELV $1883
line 3955
;3954:	case ITEM_TYPE_BIND:
;3955:		Item_Bind_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Bind_Paint
CALLV
pop
line 3956
;3956:		break;
ADDRGP4 $1871
JUMPV
LABELV $1884
line 3958
;3957:	case ITEM_TYPE_SLIDER:
;3958:		Item_Slider_Paint(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_Slider_Paint
CALLV
pop
line 3959
;3959:		break;
line 3961
;3960:	default:
;3961:		break;
LABELV $1871
line 3964
;3962:	}
;3963:
;3964:}
LABELV $1805
endproc Item_Paint 84 24
export Menu_Init
proc Menu_Init 0 12
line 3966
;3965:
;3966:void Menu_Init(menuDef_t *menu) {
line 3967
;3967:	memset(menu, 0, sizeof(menuDef_t));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 644
ARGI4
ADDRGP4 memset
CALLP4
pop
line 3968
;3968:	menu->cursorItem = -1;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 -1
ASGNI4
line 3969
;3969:	menu->fadeAmount = DC->Assets.fadeAmount;
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 61960
ADDP4
INDIRF4
ASGNF4
line 3970
;3970:	menu->fadeClamp = DC->Assets.fadeClamp;
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 61952
ADDP4
INDIRF4
ASGNF4
line 3971
;3971:	menu->fadeCycle = DC->Assets.fadeCycle;
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
ADDRGP4 DC
INDIRP4
CNSTI4 61956
ADDP4
INDIRI4
ASGNI4
line 3972
;3972:	Window_Init(&menu->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_Init
CALLV
pop
line 3973
;3973:}
LABELV $1886
endproc Menu_Init 0 12
export Menu_GetFocusedItem
proc Menu_GetFocusedItem 4 0
line 3975
;3974:
;3975:itemDef_t *Menu_GetFocusedItem(menuDef_t *menu) {
line 3977
;3976:	int i;
;3977:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1888
line 3978
;3978:		for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1893
JUMPV
LABELV $1890
line 3979
;3979:			if (menu->items[i]->window.flags & WINDOW_HASFOCUS) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1894
line 3980
;3980:				return menu->items[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $1887
JUMPV
LABELV $1894
line 3982
;3981:			}
;3982:		}
LABELV $1891
line 3978
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1893
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1890
line 3983
;3983:	}
LABELV $1888
line 3984
;3984:	return NULL;
CNSTP4 0
RETP4
LABELV $1887
endproc Menu_GetFocusedItem 4 0
export Menu_GetFocused
proc Menu_GetFocused 8 0
line 3987
;3985:}
;3986:
;3987:menuDef_t *Menu_GetFocused() {
line 3989
;3988:	int i;
;3989:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1900
JUMPV
LABELV $1897
line 3990
;3990:		if (Menus[i].window.flags & WINDOW_HASFOCUS && Menus[i].window.flags & WINDOW_VISIBLE) {
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus+68
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1901
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus+68
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1901
line 3991
;3991:			return &Menus[i];
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
RETP4
ADDRGP4 $1896
JUMPV
LABELV $1901
line 3993
;3992:		}
;3993:	}
LABELV $1898
line 3989
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1900
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1897
line 3994
;3994:	return NULL;
CNSTP4 0
RETP4
LABELV $1896
endproc Menu_GetFocused 8 0
export Menu_ScrollFeeder
proc Menu_ScrollFeeder 8 16
line 3997
;3995:}
;3996:
;3997:void Menu_ScrollFeeder(menuDef_t *menu, int feeder, qboolean down) {
line 3998
;3998:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1906
line 4000
;3999:		int i;
;4000:		for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1911
JUMPV
LABELV $1908
line 4001
;4001:			if (menu->items[i]->special == feeder) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ADDRFP4 4
INDIRI4
CVIF4 4
NEF4 $1912
line 4002
;4002:				Item_ListBox_HandleKey(menu->items[i], (down) ? K_DOWNARROW : K_UPARROW, qtrue, qtrue);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $1915
ADDRLP4 4
CNSTI4 133
ASGNI4
ADDRGP4 $1916
JUMPV
LABELV $1915
ADDRLP4 4
CNSTI4 132
ASGNI4
LABELV $1916
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
line 4003
;4003:				return;
ADDRGP4 $1905
JUMPV
LABELV $1912
line 4005
;4004:			}
;4005:		}
LABELV $1909
line 4000
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1911
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1908
line 4006
;4006:	}
LABELV $1906
line 4007
;4007:}
LABELV $1905
endproc Menu_ScrollFeeder 8 16
export Menu_SetFeederSelection
proc Menu_SetFeederSelection 12 8
line 4011
;4008:
;4009:
;4010:
;4011:void Menu_SetFeederSelection(menuDef_t *menu, int feeder, int index, const char *name) {
line 4012
;4012:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1918
line 4013
;4013:		if (name == NULL) {
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1920
line 4014
;4014:			menu = Menu_GetFocused();
ADDRLP4 0
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRFP4 0
ADDRLP4 0
INDIRP4
ASGNP4
line 4015
;4015:		} else {
ADDRGP4 $1921
JUMPV
LABELV $1920
line 4016
;4016:			menu = Menus_FindByName(name);
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
line 4017
;4017:		}
LABELV $1921
line 4018
;4018:	}
LABELV $1918
line 4020
;4019:
;4020:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1922
line 4022
;4021:		int i;
;4022:		for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1927
JUMPV
LABELV $1924
line 4023
;4023:			if (menu->items[i]->special == feeder) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ADDRFP4 4
INDIRI4
CVIF4 4
NEF4 $1928
line 4024
;4024:				if (index == 0) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $1930
line 4025
;4025:					listBoxDef_t *listPtr = (listBoxDef_t *)menu->items[i]->typeData;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4026
;4026:					listPtr->cursorPos = 0;
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 4027
;4027:					listPtr->startPos = 0;
ADDRLP4 4
INDIRP4
CNSTI4 0
ASGNI4
line 4028
;4028:				}
LABELV $1930
line 4029
;4029:				menu->items[i]->cursorPos = index;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 532
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 4030
;4030:				DC->feederSelection(menu->items[i]->special, menu->items[i]->cursorPos);
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
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 528
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 132
ADDP4
INDIRP4
CALLV
pop
line 4031
;4031:				return;
ADDRGP4 $1917
JUMPV
LABELV $1928
line 4033
;4032:			}
;4033:		}
LABELV $1925
line 4022
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1927
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1924
line 4034
;4034:	}
LABELV $1922
line 4035
;4035:}
LABELV $1917
endproc Menu_SetFeederSelection 12 8
export Menus_AnyFullScreenVisible
proc Menus_AnyFullScreenVisible 8 0
line 4037
;4036:
;4037:qboolean Menus_AnyFullScreenVisible() {
line 4039
;4038:	int i;
;4039:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1936
JUMPV
LABELV $1933
line 4040
;4040:		if (Menus[i].window.flags & WINDOW_VISIBLE && Menus[i].fullScreen) {
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus+68
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1937
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus+184
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1937
line 4041
;4041:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1932
JUMPV
LABELV $1937
line 4043
;4042:		}
;4043:	}
LABELV $1934
line 4039
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1936
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1933
line 4044
;4044:	return qfalse;
CNSTI4 0
RETI4
LABELV $1932
endproc Menus_AnyFullScreenVisible 8 0
export Menus_ActivateByName
proc Menus_ActivateByName 28 8
line 4047
;4045:}
;4046:
;4047:menuDef_t *Menus_ActivateByName(const char *p) {
line 4049
;4048:	int i;
;4049:	menuDef_t *m = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 4050
;4050:	menuDef_t *focus = Menu_GetFocused();
ADDRLP4 12
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 4051
;4051:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1945
JUMPV
LABELV $1942
line 4052
;4052:		if (Q_stricmp(Menus[i].window.name, p) == 0) {
ADDRLP4 0
INDIRI4
CNSTI4 644
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
NEI4 $1946
line 4053
;4053:			m = &Menus[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
ASGNP4
line 4054
;4054:			Menus_Activate(m);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Menus_Activate
CALLV
pop
line 4055
;4055:			if (openMenuCount < MAX_OPEN_MENUS && focus != NULL) {
ADDRGP4 openMenuCount
INDIRI4
CNSTI4 16
GEI4 $1947
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1947
line 4056
;4056:				menuStack[openMenuCount++] = focus;
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
line 4057
;4057:			}
line 4058
;4058:		} else {
ADDRGP4 $1947
JUMPV
LABELV $1946
line 4059
;4059:			Menus[i].window.flags &= ~WINDOW_HASFOCUS;
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus+68
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
line 4060
;4060:		}
LABELV $1947
line 4061
;4061:	}
LABELV $1943
line 4051
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1945
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $1942
line 4062
;4062:	Display_CloseCinematics();
ADDRGP4 Display_CloseCinematics
CALLV
pop
line 4063
;4063:	return m;
ADDRLP4 4
INDIRP4
RETP4
LABELV $1941
endproc Menus_ActivateByName 28 8
export Item_Init
proc Item_Init 0 12
line 4067
;4064:}
;4065:
;4066:
;4067:void Item_Init(itemDef_t *item) {
line 4068
;4068:	memset(item, 0, sizeof(itemDef_t));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 540
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4069
;4069:	item->textscale = 0.55f;
ADDRFP4 0
INDIRP4
CNSTI4 216
ADDP4
CNSTF4 1057803469
ASGNF4
line 4070
;4070:	Window_Init(&item->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_Init
CALLV
pop
line 4071
;4071:}
LABELV $1952
endproc Item_Init 0 12
export Menu_HandleMouseMove
proc Menu_HandleMouseMove 56 12
line 4073
;4072:
;4073:void Menu_HandleMouseMove(menuDef_t *menu, float x, float y) {
line 4075
;4074:	int i, pass;
;4075:	qboolean focusSet = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 4078
;4076:
;4077:	itemDef_t *overItem;
;4078:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1954
line 4079
;4079:		return;
ADDRGP4 $1953
JUMPV
LABELV $1954
line 4082
;4080:	}
;4081:
;4082:	if (!(menu->window.flags & (WINDOW_VISIBLE | WINDOW_FORCED))) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
NEI4 $1956
line 4083
;4083:		return;
ADDRGP4 $1953
JUMPV
LABELV $1956
line 4086
;4084:	}
;4085:
;4086:	if (itemCapture) {
ADDRGP4 itemCapture
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1958
line 4088
;4087:		//Item_MouseMove(itemCapture, x, y);
;4088:		return;
ADDRGP4 $1953
JUMPV
LABELV $1958
line 4091
;4089:	}
;4090:
;4091:	if (g_waitingForKey || g_editingField) {
ADDRGP4 g_waitingForKey
INDIRI4
CNSTI4 0
NEI4 $1962
ADDRGP4 g_editingField
INDIRI4
CNSTI4 0
EQI4 $1960
LABELV $1962
line 4092
;4092:		return;
ADDRGP4 $1953
JUMPV
LABELV $1960
line 4097
;4093:	}
;4094:
;4095:	// FIXME: this is the whole issue of focus vs. mouse over.. 
;4096:	// need a better overall solution as i don't like going through everything twice
;4097:	for (pass = 0; pass < 2; pass++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $1963
line 4098
;4098:		for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1970
JUMPV
LABELV $1967
line 4102
;4099:			// turn off focus each item
;4100:			// menu->items[i].window.flags &= ~WINDOW_HASFOCUS;
;4101:
;4102:			if (!(menu->items[i]->window.flags & (WINDOW_VISIBLE | WINDOW_FORCED))) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
NEI4 $1971
line 4103
;4103:				continue;
ADDRGP4 $1968
JUMPV
LABELV $1971
line 4107
;4104:			}
;4105:
;4106:			// items can be enabled and disabled based on cvars
;4107:			if (menu->items[i]->cvarFlags & (CVAR_ENABLE | CVAR_DISABLE) && !Item_EnableShowViaCvar(menu->items[i], CVAR_ENABLE)) {
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
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 3
BANDI4
CNSTI4 0
EQI4 $1973
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
CNSTI4 260
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
NEI4 $1973
line 4108
;4108:				continue;
ADDRGP4 $1968
JUMPV
LABELV $1973
line 4111
;4109:			}
;4110:
;4111:			if (menu->items[i]->cvarFlags & (CVAR_SHOW | CVAR_HIDE) && !Item_EnableShowViaCvar(menu->items[i], CVAR_SHOW)) {
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
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 12
BANDI4
CNSTI4 0
EQI4 $1975
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 260
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
NEI4 $1975
line 4112
;4112:				continue;
ADDRGP4 $1968
JUMPV
LABELV $1975
line 4117
;4113:			}
;4114:
;4115:
;4116:
;4117:			if (Rect_ContainsPoint(&menu->items[i]->window.rect, x, y)) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
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
ADDRLP4 40
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $1977
line 4118
;4118:				if (pass == 1) {
ADDRLP4 8
INDIRI4
CNSTI4 1
NEI4 $1978
line 4119
;4119:					overItem = menu->items[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
line 4120
;4120:					if (overItem->type == ITEM_TYPE_TEXT && overItem->text) {
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1981
ADDRLP4 4
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1981
line 4121
;4121:						if (!Rect_ContainsPoint(Item_CorrectedTextRect(overItem), x, y)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 Item_CorrectedTextRect
CALLP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 52
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $1983
line 4122
;4122:							continue;
ADDRGP4 $1968
JUMPV
LABELV $1983
line 4124
;4123:						}
;4124:					}
LABELV $1981
line 4126
;4125:					// if we are over an item
;4126:					if (IsVisible(overItem->window.flags)) {
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 IsVisible
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $1978
line 4128
;4127:						// different one
;4128:						Item_MouseEnter(overItem, x, y);
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
line 4132
;4129:						// Item_SetMouseOver(overItem, qtrue);
;4130:
;4131:						// if item is not a decoration see if it can take focus
;4132:						if (!focusSet) {
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $1978
line 4133
;4133:							focusSet = Item_SetFocus(overItem, x, y);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 52
ADDRGP4 Item_SetFocus
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 52
INDIRI4
ASGNI4
line 4134
;4134:						}
line 4135
;4135:					}
line 4136
;4136:				}
line 4137
;4137:			} else if (menu->items[i]->window.flags & WINDOW_MOUSEOVER) {
ADDRGP4 $1978
JUMPV
LABELV $1977
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1989
line 4138
;4138:				Item_MouseLeave(menu->items[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_MouseLeave
CALLV
pop
line 4139
;4139:				Item_SetMouseOver(menu->items[i], qfalse);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Item_SetMouseOver
CALLV
pop
line 4140
;4140:			}
LABELV $1989
LABELV $1978
line 4141
;4141:		}
LABELV $1968
line 4098
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1970
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $1967
line 4142
;4142:	}
LABELV $1964
line 4097
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 2
LTI4 $1963
line 4144
;4143:
;4144:}
LABELV $1953
endproc Menu_HandleMouseMove 56 12
export Menu_Paint
proc Menu_Paint 44 24
line 4146
;4145:
;4146:void Menu_Paint(menuDef_t *menu, qboolean forcePaint) {
line 4149
;4147:	int i;
;4148:
;4149:	if (menu == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1992
line 4150
;4150:		return;
ADDRGP4 $1991
JUMPV
LABELV $1992
line 4153
;4151:	}
;4152:
;4153:	if (!(menu->window.flags & WINDOW_VISIBLE) && !forcePaint) {
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
NEI4 $1994
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $1994
line 4154
;4154:		return;
ADDRGP4 $1991
JUMPV
LABELV $1994
line 4157
;4155:	}
;4156:
;4157:	if (menu->window.ownerDrawFlags && DC->ownerDrawVisible && !DC->ownerDrawVisible(menu->window.ownerDrawFlags)) {
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
EQI4 $1996
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
EQU4 $1996
ADDRLP4 4
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 76
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $1996
line 4158
;4158:		return;
ADDRGP4 $1991
JUMPV
LABELV $1996
line 4161
;4159:	}
;4160:
;4161:	if (forcePaint) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $1998
line 4162
;4162:		menu->window.flags |= WINDOW_FORCED;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 68
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1048576
BORI4
ASGNI4
line 4163
;4163:	}
LABELV $1998
line 4166
;4164:
;4165:	// draw the background if necessary
;4166:	if (menu->fullScreen) {
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2000
line 4169
;4167:		// implies a background shader
;4168:		// FIXME: make sure we have a default shader if fullscreen is set with no background
;4169:		DC->drawHandlePic(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, menu->window.background);
CNSTF4 0
ARGF4
CNSTF4 0
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
ADDRFP4 0
INDIRP4
CNSTI4 176
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
line 4170
;4170:	} else if (menu->window.background) {
ADDRGP4 $2001
JUMPV
LABELV $2000
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2002
line 4173
;4171:		// this allows a background shader without being full screen
;4172:		//UI_DrawHandlePic(menu->window.rect.x, menu->window.rect.y, menu->window.rect.w, menu->window.rect.h, menu->backgroundShader);
;4173:	}
LABELV $2002
LABELV $2001
line 4176
;4174:
;4175:	// paint the background and or border
;4176:	Window_Paint(&menu->window, menu->fadeAmount, menu->fadeClamp, menu->fadeCycle);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
CNSTI4 208
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 204
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 Window_Paint
CALLV
pop
line 4178
;4177:
;4178:	for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2007
JUMPV
LABELV $2004
line 4179
;4179:		Item_Paint(menu->items[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_Paint
CALLV
pop
line 4180
;4180:	}
LABELV $2005
line 4178
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2007
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $2004
line 4182
;4181:
;4182:	if (debugMode) {
ADDRGP4 debugMode
INDIRI4
CNSTI4 0
EQI4 $2008
line 4184
;4183:		vec4_t color;
;4184:		color[0] = color[2] = color[3] = 1;
ADDRLP4 36
CNSTF4 1065353216
ASGNF4
ADDRLP4 20+12
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 20+8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 20
ADDRLP4 36
INDIRF4
ASGNF4
line 4185
;4185:		color[1] = 0;
ADDRLP4 20+4
CNSTF4 0
ASGNF4
line 4186
;4186:		DC->drawRect(menu->window.rect.x, menu->window.rect.y, menu->window.rect.w, menu->window.rect.h, 1, color);
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 20
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CALLV
pop
line 4187
;4187:	}
LABELV $2008
line 4188
;4188:}
LABELV $1991
endproc Menu_Paint 44 24
export Item_ValidateTypeData
proc Item_ValidateTypeData 8 12
line 4195
;4189:
;4190:/*
;4191:===============
;4192:Item_ValidateTypeData
;4193:===============
;4194:*/
;4195:void Item_ValidateTypeData(itemDef_t *item) {
line 4196
;4196:	if (item->typeData) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2014
line 4197
;4197:		return;
ADDRGP4 $2013
JUMPV
LABELV $2014
line 4200
;4198:	}
;4199:
;4200:	if (item->type == ITEM_TYPE_LISTBOX) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 6
NEI4 $2016
line 4201
;4201:		item->typeData = UI_Alloc(sizeof(listBoxDef_t));
CNSTI4 232
ARGI4
ADDRLP4 0
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 4202
;4202:		memset(item->typeData, 0, sizeof(listBoxDef_t));
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 232
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4203
;4203:	} else if (item->type == ITEM_TYPE_EDITFIELD || item->type == ITEM_TYPE_NUMERICFIELD || item->type == ITEM_TYPE_YESNO || item->type == ITEM_TYPE_BIND || item->type == ITEM_TYPE_SLIDER || item->type == ITEM_TYPE_TEXT) {
ADDRGP4 $2017
JUMPV
LABELV $2016
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 4
EQI4 $2024
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 9
EQI4 $2024
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 11
EQI4 $2024
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 13
EQI4 $2024
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 10
EQI4 $2024
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2018
LABELV $2024
line 4204
;4204:		item->typeData = UI_Alloc(sizeof(editFieldDef_t));
CNSTI4 28
ARGI4
ADDRLP4 4
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 4205
;4205:		memset(item->typeData, 0, sizeof(editFieldDef_t));
ADDRFP4 0
INDIRP4
CNSTI4 536
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
line 4206
;4206:		if (item->type == ITEM_TYPE_EDITFIELD) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 4
NEI4 $2019
line 4207
;4207:			if (!((editFieldDef_t *)item->typeData)->maxPaintChars) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2019
line 4208
;4208:				((editFieldDef_t *)item->typeData)->maxPaintChars = MAX_EDITFIELD;
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 256
ASGNI4
line 4209
;4209:			}
line 4210
;4210:		}
line 4211
;4211:	} else if (item->type == ITEM_TYPE_MULTI) {
ADDRGP4 $2019
JUMPV
LABELV $2018
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 12
NEI4 $2029
line 4212
;4212:		item->typeData = UI_Alloc(sizeof(multiDef_t));
CNSTI4 392
ARGI4
ADDRLP4 4
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 4213
;4213:	} else if (item->type == ITEM_TYPE_MODEL) {
ADDRGP4 $2030
JUMPV
LABELV $2029
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 7
NEI4 $2031
line 4214
;4214:		item->typeData = UI_Alloc(sizeof(modelDef_t));
CNSTI4 28
ARGI4
ADDRLP4 4
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 4215
;4215:	}
LABELV $2031
LABELV $2030
LABELV $2019
LABELV $2017
line 4216
;4216:}
LABELV $2013
endproc Item_ValidateTypeData 8 12
export KeywordHash_Key
proc KeywordHash_Key 20 0
line 4232
;4217:
;4218:/*
;4219:===============
;4220:Keyword Hash
;4221:===============
;4222:*/
;4223:
;4224:#define KEYWORDHASH_SIZE	512
;4225:
;4226:typedef struct keywordHash_s {
;4227:	char *keyword;
;4228:	qboolean(*func)(itemDef_t *item, int handle);
;4229:	struct keywordHash_s *next;
;4230:} keywordHash_t;
;4231:
;4232:int KeywordHash_Key(char *keyword) {
line 4235
;4233:	int register hash, i;
;4234:
;4235:	hash = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 4236
;4236:	for (i = 0; keyword[i] != '\0'; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2037
JUMPV
LABELV $2034
line 4237
;4237:		if (keyword[i] >= 'A' && keyword[i] <= 'Z')
ADDRLP4 8
ADDRLP4 4
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
LTI4 $2038
ADDRLP4 8
INDIRI4
CNSTI4 90
GTI4 $2038
line 4238
;4238:			hash += (keyword[i] + ('a' - 'A')) * (119 + i);
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 32
ADDI4
ADDRLP4 4
INDIRI4
CNSTI4 119
ADDI4
MULI4
ADDI4
ASGNI4
ADDRGP4 $2039
JUMPV
LABELV $2038
line 4240
;4239:		else
;4240:			hash += keyword[i] * (119 + i);
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ADDRLP4 4
INDIRI4
CNSTI4 119
ADDI4
MULI4
ADDI4
ASGNI4
LABELV $2039
line 4241
;4241:	}
LABELV $2035
line 4236
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2037
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $2034
line 4242
;4242:	hash = (hash ^ (hash >> 10) ^ (hash >> 20)) & (KEYWORDHASH_SIZE - 1);
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 10
RSHI4
BXORI4
ADDRLP4 0
INDIRI4
CNSTI4 20
RSHI4
BXORI4
CNSTI4 511
BANDI4
ASGNI4
line 4243
;4243:	return hash;
ADDRLP4 0
INDIRI4
RETI4
LABELV $2033
endproc KeywordHash_Key 20 0
export KeywordHash_Add
proc KeywordHash_Add 8 4
line 4246
;4244:}
;4245:
;4246:void KeywordHash_Add(keywordHash_t *table[], keywordHash_t *key) {
line 4249
;4247:	int hash;
;4248:
;4249:	hash = KeywordHash_Key(key->keyword);
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
line 4255
;4250:	/*
;4251:		if (table[hash]) {
;4252:			int collision = qtrue;
;4253:		}
;4254:	*/
;4255:	key->next = table[hash];
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
line 4256
;4256:	table[hash] = key;
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
line 4257
;4257:}
LABELV $2040
endproc KeywordHash_Add 8 4
export KeywordHash_Find
proc KeywordHash_Find 16 8
line 4259
;4258:
;4259:keywordHash_t *KeywordHash_Find(keywordHash_t *table[], char *keyword) {
line 4263
;4260:	keywordHash_t *key;
;4261:	int hash;
;4262:
;4263:	hash = KeywordHash_Key(keyword);
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
line 4264
;4264:	for (key = table[hash]; key; key = key->next) {
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
ADDRGP4 $2045
JUMPV
LABELV $2042
line 4265
;4265:		if (!Q_stricmp(key->keyword, keyword))
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
NEI4 $2046
line 4266
;4266:			return key;
ADDRLP4 0
INDIRP4
RETP4
ADDRGP4 $2041
JUMPV
LABELV $2046
line 4267
;4267:	}
LABELV $2043
line 4264
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ASGNP4
LABELV $2045
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2042
line 4268
;4268:	return NULL;
CNSTP4 0
RETP4
LABELV $2041
endproc KeywordHash_Find 16 8
export ItemParse_name
proc ItemParse_name 4 8
line 4278
;4269:}
;4270:
;4271:/*
;4272:===============
;4273:Item Keyword Parse functions
;4274:===============
;4275:*/
;4276:
;4277:// name <string>
;4278:qboolean ItemParse_name(itemDef_t *item, int handle) {
line 4279
;4279:	if (!PC_String_Parse(handle, &item->window.name)) {
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
NEI4 $2049
line 4280
;4280:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2048
JUMPV
LABELV $2049
line 4282
;4281:	}
;4282:	return qtrue;
CNSTI4 1
RETI4
LABELV $2048
endproc ItemParse_name 4 8
export ItemParse_focusSound
proc ItemParse_focusSound 12 8
line 4286
;4283:}
;4284:
;4285:// name <string>
;4286:qboolean ItemParse_focusSound(itemDef_t *item, int handle) {
line 4288
;4287:	const char *temp;
;4288:	if (!PC_String_Parse(handle, &temp)) {
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
NEI4 $2052
line 4289
;4289:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2051
JUMPV
LABELV $2052
line 4291
;4290:	}
;4291:	item->focusSound = DC->registerSound(temp, qfalse);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
CNSTI4 168
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 280
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 4292
;4292:	return qtrue;
CNSTI4 1
RETI4
LABELV $2051
endproc ItemParse_focusSound 12 8
export ItemParse_text
proc ItemParse_text 4 8
line 4297
;4293:}
;4294:
;4295:
;4296:// text <string>
;4297:qboolean ItemParse_text(itemDef_t *item, int handle) {
line 4298
;4298:	if (!PC_String_Parse(handle, &item->text)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2055
line 4299
;4299:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2054
JUMPV
LABELV $2055
line 4301
;4300:	}
;4301:	return qtrue;
CNSTI4 1
RETI4
LABELV $2054
endproc ItemParse_text 4 8
export ItemParse_group
proc ItemParse_group 4 8
line 4305
;4302:}
;4303:
;4304:// group <string>
;4305:qboolean ItemParse_group(itemDef_t *item, int handle) {
line 4306
;4306:	if (!PC_String_Parse(handle, &item->window.group)) {
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
NEI4 $2058
line 4307
;4307:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2057
JUMPV
LABELV $2058
line 4309
;4308:	}
;4309:	return qtrue;
CNSTI4 1
RETI4
LABELV $2057
endproc ItemParse_group 4 8
export ItemParse_asset_model
proc ItemParse_asset_model 20 8
line 4313
;4310:}
;4311:
;4312:// asset_model <string>
;4313:qboolean ItemParse_asset_model(itemDef_t *item, int handle) {
line 4316
;4314:	const char *temp;
;4315:	modelDef_t *modelPtr;
;4316:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4317
;4317:	modelPtr = (modelDef_t *)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4319
;4318:
;4319:	if (!PC_String_Parse(handle, &temp)) {
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
NEI4 $2061
line 4320
;4320:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2060
JUMPV
LABELV $2061
line 4322
;4321:	}
;4322:	item->asset = DC->registerModel(temp);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 4323
;4323:	modelPtr->angle = rand() % 360;
ADDRLP4 16
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 16
INDIRI4
CNSTI4 360
MODI4
ASGNI4
line 4324
;4324:	return qtrue;
CNSTI4 1
RETI4
LABELV $2060
endproc ItemParse_asset_model 20 8
export ItemParse_asset_shader
proc ItemParse_asset_shader 12 8
line 4328
;4325:}
;4326:
;4327:// asset_shader <string>
;4328:qboolean ItemParse_asset_shader(itemDef_t *item, int handle) {
line 4331
;4329:	const char *temp;
;4330:
;4331:	if (!PC_String_Parse(handle, &temp)) {
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
NEI4 $2064
line 4332
;4332:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2063
JUMPV
LABELV $2064
line 4334
;4333:	}
;4334:	item->asset = DC->registerShaderNoMip(temp);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 232
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 4335
;4335:	return qtrue;
CNSTI4 1
RETI4
LABELV $2063
endproc ItemParse_asset_shader 12 8
export ItemParse_model_origin
proc ItemParse_model_origin 16 8
line 4339
;4336:}
;4337:
;4338:// model_origin <number> <number> <number>
;4339:qboolean ItemParse_model_origin(itemDef_t *item, int handle) {
line 4341
;4340:	modelDef_t *modelPtr;
;4341:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4342
;4342:	modelPtr = (modelDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4344
;4343:
;4344:	if (PC_Float_Parse(handle, &modelPtr->origin[0])) {
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
EQI4 $2067
line 4345
;4345:		if (PC_Float_Parse(handle, &modelPtr->origin[1])) {
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
EQI4 $2069
line 4346
;4346:			if (PC_Float_Parse(handle, &modelPtr->origin[2])) {
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
EQI4 $2071
line 4347
;4347:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2066
JUMPV
LABELV $2071
line 4349
;4348:			}
;4349:		}
LABELV $2069
line 4350
;4350:	}
LABELV $2067
line 4351
;4351:	return qfalse;
CNSTI4 0
RETI4
LABELV $2066
endproc ItemParse_model_origin 16 8
export ItemParse_model_fovx
proc ItemParse_model_fovx 8 8
line 4355
;4352:}
;4353:
;4354:// model_fovx <number>
;4355:qboolean ItemParse_model_fovx(itemDef_t *item, int handle) {
line 4357
;4356:	modelDef_t *modelPtr;
;4357:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4358
;4358:	modelPtr = (modelDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4360
;4359:
;4360:	if (!PC_Float_Parse(handle, &modelPtr->fov_x)) {
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
NEI4 $2074
line 4361
;4361:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2073
JUMPV
LABELV $2074
line 4363
;4362:	}
;4363:	return qtrue;
CNSTI4 1
RETI4
LABELV $2073
endproc ItemParse_model_fovx 8 8
export ItemParse_model_fovy
proc ItemParse_model_fovy 8 8
line 4367
;4364:}
;4365:
;4366:// model_fovy <number>
;4367:qboolean ItemParse_model_fovy(itemDef_t *item, int handle) {
line 4369
;4368:	modelDef_t *modelPtr;
;4369:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4370
;4370:	modelPtr = (modelDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4372
;4371:
;4372:	if (!PC_Float_Parse(handle, &modelPtr->fov_y)) {
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
NEI4 $2077
line 4373
;4373:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2076
JUMPV
LABELV $2077
line 4375
;4374:	}
;4375:	return qtrue;
CNSTI4 1
RETI4
LABELV $2076
endproc ItemParse_model_fovy 8 8
export ItemParse_model_rotation
proc ItemParse_model_rotation 8 8
line 4379
;4376:}
;4377:
;4378:// model_rotation <integer>
;4379:qboolean ItemParse_model_rotation(itemDef_t *item, int handle) {
line 4381
;4380:	modelDef_t *modelPtr;
;4381:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4382
;4382:	modelPtr = (modelDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4384
;4383:
;4384:	if (!PC_Int_Parse(handle, &modelPtr->rotationSpeed)) {
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
NEI4 $2080
line 4385
;4385:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2079
JUMPV
LABELV $2080
line 4387
;4386:	}
;4387:	return qtrue;
CNSTI4 1
RETI4
LABELV $2079
endproc ItemParse_model_rotation 8 8
export ItemParse_model_angle
proc ItemParse_model_angle 8 8
line 4391
;4388:}
;4389:
;4390:// model_angle <integer>
;4391:qboolean ItemParse_model_angle(itemDef_t *item, int handle) {
line 4393
;4392:	modelDef_t *modelPtr;
;4393:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4394
;4394:	modelPtr = (modelDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4396
;4395:
;4396:	if (!PC_Int_Parse(handle, &modelPtr->angle)) {
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
NEI4 $2083
line 4397
;4397:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2082
JUMPV
LABELV $2083
line 4399
;4398:	}
;4399:	return qtrue;
CNSTI4 1
RETI4
LABELV $2082
endproc ItemParse_model_angle 8 8
export ItemParse_rect
proc ItemParse_rect 4 8
line 4403
;4400:}
;4401:
;4402:// rect <rectangle>
;4403:qboolean ItemParse_rect(itemDef_t *item, int handle) {
line 4404
;4404:	if (!PC_Rect_Parse(handle, &item->window.rectClient)) {
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
NEI4 $2086
line 4405
;4405:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2085
JUMPV
LABELV $2086
line 4407
;4406:	}
;4407:	return qtrue;
CNSTI4 1
RETI4
LABELV $2085
endproc ItemParse_rect 4 8
export ItemParse_style
proc ItemParse_style 4 8
line 4411
;4408:}
;4409:
;4410:// style <integer>
;4411:qboolean ItemParse_style(itemDef_t *item, int handle) {
line 4412
;4412:	if (!PC_Int_Parse(handle, &item->window.style)) {
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
NEI4 $2089
line 4413
;4413:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2088
JUMPV
LABELV $2089
line 4415
;4414:	}
;4415:	return qtrue;
CNSTI4 1
RETI4
LABELV $2088
endproc ItemParse_style 4 8
export ItemParse_decoration
proc ItemParse_decoration 4 0
line 4419
;4416:}
;4417:
;4418:// decoration
;4419:qboolean ItemParse_decoration(itemDef_t *item, int handle) {
line 4420
;4420:	item->window.flags |= WINDOW_DECORATION;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 4421
;4421:	return qtrue;
CNSTI4 1
RETI4
LABELV $2091
endproc ItemParse_decoration 4 0
export ItemParse_notselectable
proc ItemParse_notselectable 4 4
line 4425
;4422:}
;4423:
;4424:// notselectable
;4425:qboolean ItemParse_notselectable(itemDef_t *item, int handle) {
line 4427
;4426:	listBoxDef_t *listPtr;
;4427:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4428
;4428:	listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4429
;4429:	if (item->type == ITEM_TYPE_LISTBOX && listPtr) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 6
NEI4 $2093
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2093
line 4430
;4430:		listPtr->notselectable = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 228
ADDP4
CNSTI4 1
ASGNI4
line 4431
;4431:	}
LABELV $2093
line 4432
;4432:	return qtrue;
CNSTI4 1
RETI4
LABELV $2092
endproc ItemParse_notselectable 4 4
export ItemParse_wrapped
proc ItemParse_wrapped 4 0
line 4436
;4433:}
;4434:
;4435:// manually wrapped
;4436:qboolean ItemParse_wrapped(itemDef_t *item, int handle) {
line 4437
;4437:	item->window.flags |= WINDOW_WRAPPED;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 4438
;4438:	return qtrue;
CNSTI4 1
RETI4
LABELV $2095
endproc ItemParse_wrapped 4 0
export ItemParse_autowrapped
proc ItemParse_autowrapped 4 0
line 4442
;4439:}
;4440:
;4441:// auto wrapped
;4442:qboolean ItemParse_autowrapped(itemDef_t *item, int handle) {
line 4443
;4443:	item->window.flags |= WINDOW_AUTOWRAPPED;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 4444
;4444:	return qtrue;
CNSTI4 1
RETI4
LABELV $2096
endproc ItemParse_autowrapped 4 0
export ItemParse_horizontalscroll
proc ItemParse_horizontalscroll 4 0
line 4449
;4445:}
;4446:
;4447:
;4448:// horizontalscroll
;4449:qboolean ItemParse_horizontalscroll(itemDef_t *item, int handle) {
line 4450
;4450:	item->window.flags |= WINDOW_HORIZONTAL;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 4451
;4451:	return qtrue;
CNSTI4 1
RETI4
LABELV $2097
endproc ItemParse_horizontalscroll 4 0
export ItemParse_type
proc ItemParse_type 4 8
line 4455
;4452:}
;4453:
;4454:// type <integer>
;4455:qboolean ItemParse_type(itemDef_t *item, int handle) {
line 4456
;4456:	if (!PC_Int_Parse(handle, &item->type)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2099
line 4457
;4457:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2098
JUMPV
LABELV $2099
line 4459
;4458:	}
;4459:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4460
;4460:	return qtrue;
CNSTI4 1
RETI4
LABELV $2098
endproc ItemParse_type 4 8
export ItemParse_elementwidth
proc ItemParse_elementwidth 8 8
line 4465
;4461:}
;4462:
;4463:// elementwidth, used for listbox image elements
;4464:// uses textalignx for storage
;4465:qboolean ItemParse_elementwidth(itemDef_t *item, int handle) {
line 4468
;4466:	listBoxDef_t *listPtr;
;4467:
;4468:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4469
;4469:	listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4470
;4470:	if (!PC_Float_Parse(handle, &listPtr->elementWidth)) {
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
NEI4 $2102
line 4471
;4471:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2101
JUMPV
LABELV $2102
line 4473
;4472:	}
;4473:	return qtrue;
CNSTI4 1
RETI4
LABELV $2101
endproc ItemParse_elementwidth 8 8
export ItemParse_elementheight
proc ItemParse_elementheight 8 8
line 4478
;4474:}
;4475:
;4476:// elementheight, used for listbox image elements
;4477:// uses textaligny for storage
;4478:qboolean ItemParse_elementheight(itemDef_t *item, int handle) {
line 4481
;4479:	listBoxDef_t *listPtr;
;4480:
;4481:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4482
;4482:	listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4483
;4483:	if (!PC_Float_Parse(handle, &listPtr->elementHeight)) {
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
NEI4 $2105
line 4484
;4484:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2104
JUMPV
LABELV $2105
line 4486
;4485:	}
;4486:	return qtrue;
CNSTI4 1
RETI4
LABELV $2104
endproc ItemParse_elementheight 8 8
export ItemParse_feeder
proc ItemParse_feeder 4 8
line 4490
;4487:}
;4488:
;4489:// feeder <float>
;4490:qboolean ItemParse_feeder(itemDef_t *item, int handle) {
line 4491
;4491:	if (!PC_Float_Parse(handle, &item->special)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2108
line 4492
;4492:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2107
JUMPV
LABELV $2108
line 4494
;4493:	}
;4494:	return qtrue;
CNSTI4 1
RETI4
LABELV $2107
endproc ItemParse_feeder 4 8
export ItemParse_elementtype
proc ItemParse_elementtype 8 8
line 4499
;4495:}
;4496:
;4497:// elementtype, used to specify what type of elements a listbox contains
;4498:// uses textstyle for storage
;4499:qboolean ItemParse_elementtype(itemDef_t *item, int handle) {
line 4502
;4500:	listBoxDef_t *listPtr;
;4501:
;4502:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4503
;4503:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2111
line 4504
;4504:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2110
JUMPV
LABELV $2111
line 4505
;4505:	listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4506
;4506:	if (!PC_Int_Parse(handle, &listPtr->elementStyle)) {
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
NEI4 $2113
line 4507
;4507:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2110
JUMPV
LABELV $2113
line 4509
;4508:	}
;4509:	return qtrue;
CNSTI4 1
RETI4
LABELV $2110
endproc ItemParse_elementtype 8 8
export ItemParse_columns
proc ItemParse_columns 40 8
line 4513
;4510:}
;4511:
;4512:// columns sets a number of columns and an x pos and width per.. 
;4513:qboolean ItemParse_columns(itemDef_t *item, int handle) {
line 4517
;4514:	int num, i;
;4515:	listBoxDef_t *listPtr;
;4516:
;4517:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4518
;4518:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2116
line 4519
;4519:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2115
JUMPV
LABELV $2116
line 4520
;4520:	listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4521
;4521:	if (PC_Int_Parse(handle, &num)) {
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
EQI4 $2118
line 4522
;4522:		if (num > MAX_LB_COLUMNS) {
ADDRLP4 8
INDIRI4
CNSTI4 16
LEI4 $2120
line 4523
;4523:			num = MAX_LB_COLUMNS;
ADDRLP4 8
CNSTI4 16
ASGNI4
line 4524
;4524:		}
LABELV $2120
line 4525
;4525:		listPtr->numColumns = num;
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 4526
;4526:		for (i = 0; i < num; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2125
JUMPV
LABELV $2122
line 4529
;4527:			int pos, width, maxChars;
;4528:
;4529:			if (PC_Int_Parse(handle, &pos) && PC_Int_Parse(handle, &width) && PC_Int_Parse(handle, &maxChars)) {
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
EQI4 $2126
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
EQI4 $2126
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
EQI4 $2126
line 4530
;4530:				listPtr->columnInfo[i].pos = pos;
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 4531
;4531:				listPtr->columnInfo[i].width = width;
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 4532
;4532:				listPtr->columnInfo[i].maxChars = maxChars;
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 4533
;4533:			} else {
ADDRGP4 $2127
JUMPV
LABELV $2126
line 4534
;4534:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2115
JUMPV
LABELV $2127
line 4536
;4535:			}
;4536:		}
LABELV $2123
line 4526
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2125
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $2122
line 4537
;4537:	} else {
ADDRGP4 $2119
JUMPV
LABELV $2118
line 4538
;4538:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2115
JUMPV
LABELV $2119
line 4540
;4539:	}
;4540:	return qtrue;
CNSTI4 1
RETI4
LABELV $2115
endproc ItemParse_columns 40 8
export ItemParse_border
proc ItemParse_border 4 8
line 4543
;4541:}
;4542:
;4543:qboolean ItemParse_border(itemDef_t *item, int handle) {
line 4544
;4544:	if (!PC_Int_Parse(handle, &item->window.border)) {
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
NEI4 $2129
line 4545
;4545:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2128
JUMPV
LABELV $2129
line 4547
;4546:	}
;4547:	return qtrue;
CNSTI4 1
RETI4
LABELV $2128
endproc ItemParse_border 4 8
export ItemParse_bordersize
proc ItemParse_bordersize 4 8
line 4550
;4548:}
;4549:
;4550:qboolean ItemParse_bordersize(itemDef_t *item, int handle) {
line 4551
;4551:	if (!PC_Float_Parse(handle, &item->window.borderSize)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2132
line 4552
;4552:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2131
JUMPV
LABELV $2132
line 4554
;4553:	}
;4554:	return qtrue;
CNSTI4 1
RETI4
LABELV $2131
endproc ItemParse_bordersize 4 8
export ItemParse_visible
proc ItemParse_visible 12 8
line 4557
;4555:}
;4556:
;4557:qboolean ItemParse_visible(itemDef_t *item, int handle) {
line 4560
;4558:	int i;
;4559:
;4560:	if (!PC_Int_Parse(handle, &i)) {
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
NEI4 $2135
line 4561
;4561:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2134
JUMPV
LABELV $2135
line 4563
;4562:	}
;4563:	if (i) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2137
line 4564
;4564:		item->window.flags |= WINDOW_VISIBLE;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 4565
;4565:	}
LABELV $2137
line 4566
;4566:	return qtrue;
CNSTI4 1
RETI4
LABELV $2134
endproc ItemParse_visible 12 8
export ItemParse_ownerdraw
proc ItemParse_ownerdraw 4 8
line 4569
;4567:}
;4568:
;4569:qboolean ItemParse_ownerdraw(itemDef_t *item, int handle) {
line 4570
;4570:	if (!PC_Int_Parse(handle, &item->window.ownerDraw)) {
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
NEI4 $2140
line 4571
;4571:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2139
JUMPV
LABELV $2140
line 4573
;4572:	}
;4573:	item->type = ITEM_TYPE_OWNERDRAW;
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
CNSTI4 8
ASGNI4
line 4574
;4574:	return qtrue;
CNSTI4 1
RETI4
LABELV $2139
endproc ItemParse_ownerdraw 4 8
export ItemParse_align
proc ItemParse_align 4 8
line 4577
;4575:}
;4576:
;4577:qboolean ItemParse_align(itemDef_t *item, int handle) {
line 4578
;4578:	if (!PC_Int_Parse(handle, &item->alignment)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2143
line 4579
;4579:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2142
JUMPV
LABELV $2143
line 4581
;4580:	}
;4581:	return qtrue;
CNSTI4 1
RETI4
LABELV $2142
endproc ItemParse_align 4 8
export ItemParse_textalign
proc ItemParse_textalign 4 8
line 4584
;4582:}
;4583:
;4584:qboolean ItemParse_textalign(itemDef_t *item, int handle) {
line 4585
;4585:	if (!PC_Int_Parse(handle, &item->textalignment)) {
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
NEI4 $2146
line 4586
;4586:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2145
JUMPV
LABELV $2146
line 4588
;4587:	}
;4588:	return qtrue;
CNSTI4 1
RETI4
LABELV $2145
endproc ItemParse_textalign 4 8
export ItemParse_textalignx
proc ItemParse_textalignx 4 8
line 4591
;4589:}
;4590:
;4591:qboolean ItemParse_textalignx(itemDef_t *item, int handle) {
line 4592
;4592:	if (!PC_Float_Parse(handle, &item->textalignx)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2149
line 4593
;4593:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2148
JUMPV
LABELV $2149
line 4595
;4594:	}
;4595:	return qtrue;
CNSTI4 1
RETI4
LABELV $2148
endproc ItemParse_textalignx 4 8
export ItemParse_textaligny
proc ItemParse_textaligny 4 8
line 4598
;4596:}
;4597:
;4598:qboolean ItemParse_textaligny(itemDef_t *item, int handle) {
line 4599
;4599:	if (!PC_Float_Parse(handle, &item->textaligny)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2152
line 4600
;4600:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2151
JUMPV
LABELV $2152
line 4602
;4601:	}
;4602:	return qtrue;
CNSTI4 1
RETI4
LABELV $2151
endproc ItemParse_textaligny 4 8
export ItemParse_textscale
proc ItemParse_textscale 4 8
line 4605
;4603:}
;4604:
;4605:qboolean ItemParse_textscale(itemDef_t *item, int handle) {
line 4606
;4606:	if (!PC_Float_Parse(handle, &item->textscale)) {
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
NEI4 $2155
line 4607
;4607:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2154
JUMPV
LABELV $2155
line 4609
;4608:	}
;4609:	return qtrue;
CNSTI4 1
RETI4
LABELV $2154
endproc ItemParse_textscale 4 8
export ItemParse_textstyle
proc ItemParse_textstyle 4 8
line 4612
;4610:}
;4611:
;4612:qboolean ItemParse_textstyle(itemDef_t *item, int handle) {
line 4613
;4613:	if (!PC_Int_Parse(handle, &item->textStyle)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 220
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2158
line 4614
;4614:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2157
JUMPV
LABELV $2158
line 4616
;4615:	}
;4616:	return qtrue;
CNSTI4 1
RETI4
LABELV $2157
endproc ItemParse_textstyle 4 8
export ItemParse_backcolor
proc ItemParse_backcolor 12 8
line 4619
;4617:}
;4618:
;4619:qboolean ItemParse_backcolor(itemDef_t *item, int handle) {
line 4623
;4620:	int i;
;4621:	float f;
;4622:
;4623:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2161
line 4624
;4624:		if (!PC_Float_Parse(handle, &f)) {
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
NEI4 $2165
line 4625
;4625:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2160
JUMPV
LABELV $2165
line 4627
;4626:		}
;4627:		item->window.backColor[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 128
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 4628
;4628:	}
LABELV $2162
line 4623
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2161
line 4629
;4629:	return qtrue;
CNSTI4 1
RETI4
LABELV $2160
endproc ItemParse_backcolor 12 8
export ItemParse_forecolor
proc ItemParse_forecolor 16 8
line 4632
;4630:}
;4631:
;4632:qboolean ItemParse_forecolor(itemDef_t *item, int handle) {
line 4636
;4633:	int i;
;4634:	float f;
;4635:
;4636:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2168
line 4637
;4637:		if (!PC_Float_Parse(handle, &f)) {
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
NEI4 $2172
line 4638
;4638:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2167
JUMPV
LABELV $2172
line 4640
;4639:		}
;4640:		item->window.foreColor[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 4641
;4641:		item->window.flags |= WINDOW_FORECOLORSET;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 68
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
line 4642
;4642:	}
LABELV $2169
line 4636
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2168
line 4643
;4643:	return qtrue;
CNSTI4 1
RETI4
LABELV $2167
endproc ItemParse_forecolor 16 8
export ItemParse_bordercolor
proc ItemParse_bordercolor 12 8
line 4646
;4644:}
;4645:
;4646:qboolean ItemParse_bordercolor(itemDef_t *item, int handle) {
line 4650
;4647:	int i;
;4648:	float f;
;4649:
;4650:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2175
line 4651
;4651:		if (!PC_Float_Parse(handle, &f)) {
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
NEI4 $2179
line 4652
;4652:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2174
JUMPV
LABELV $2179
line 4654
;4653:		}
;4654:		item->window.borderColor[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 4655
;4655:	}
LABELV $2176
line 4650
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2175
line 4656
;4656:	return qtrue;
CNSTI4 1
RETI4
LABELV $2174
endproc ItemParse_bordercolor 12 8
export ItemParse_outlinecolor
proc ItemParse_outlinecolor 4 8
line 4659
;4657:}
;4658:
;4659:qboolean ItemParse_outlinecolor(itemDef_t *item, int handle) {
line 4660
;4660:	if (!PC_Color_Parse(handle, &item->window.outlineColor)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Color_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2182
line 4661
;4661:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2181
JUMPV
LABELV $2182
line 4663
;4662:	}
;4663:	return qtrue;
CNSTI4 1
RETI4
LABELV $2181
endproc ItemParse_outlinecolor 4 8
export ItemParse_background
proc ItemParse_background 12 8
line 4666
;4664:}
;4665:
;4666:qboolean ItemParse_background(itemDef_t *item, int handle) {
line 4669
;4667:	const char *temp;
;4668:
;4669:	if (!PC_String_Parse(handle, &temp)) {
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
NEI4 $2185
line 4670
;4670:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2184
JUMPV
LABELV $2185
line 4672
;4671:	}
;4672:	item->window.background = DC->registerShaderNoMip(temp);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 DC
INDIRP4
INDIRP4
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 176
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 4673
;4673:	return qtrue;
CNSTI4 1
RETI4
LABELV $2184
endproc ItemParse_background 12 8
export ItemParse_cinematic
proc ItemParse_cinematic 4 8
line 4676
;4674:}
;4675:
;4676:qboolean ItemParse_cinematic(itemDef_t *item, int handle) {
line 4677
;4677:	if (!PC_String_Parse(handle, &item->window.cinematicName)) {
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
NEI4 $2188
line 4678
;4678:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2187
JUMPV
LABELV $2188
line 4680
;4679:	}
;4680:	return qtrue;
CNSTI4 1
RETI4
LABELV $2187
endproc ItemParse_cinematic 4 8
export ItemParse_doubleClick
proc ItemParse_doubleClick 8 8
line 4683
;4681:}
;4682:
;4683:qboolean ItemParse_doubleClick(itemDef_t *item, int handle) {
line 4686
;4684:	listBoxDef_t *listPtr;
;4685:
;4686:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4687
;4687:	if (!item->typeData) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2191
line 4688
;4688:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2190
JUMPV
LABELV $2191
line 4691
;4689:	}
;4690:
;4691:	listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4693
;4692:
;4693:	if (!PC_Script_Parse(handle, &listPtr->doubleClick)) {
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
NEI4 $2193
line 4694
;4694:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2190
JUMPV
LABELV $2193
line 4696
;4695:	}
;4696:	return qtrue;
CNSTI4 1
RETI4
LABELV $2190
endproc ItemParse_doubleClick 8 8
export ItemParse_onFocus
proc ItemParse_onFocus 4 8
line 4699
;4697:}
;4698:
;4699:qboolean ItemParse_onFocus(itemDef_t *item, int handle) {
line 4700
;4700:	if (!PC_Script_Parse(handle, &item->onFocus)) {
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
NEI4 $2196
line 4701
;4701:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2195
JUMPV
LABELV $2196
line 4703
;4702:	}
;4703:	return qtrue;
CNSTI4 1
RETI4
LABELV $2195
endproc ItemParse_onFocus 4 8
export ItemParse_leaveFocus
proc ItemParse_leaveFocus 4 8
line 4706
;4704:}
;4705:
;4706:qboolean ItemParse_leaveFocus(itemDef_t *item, int handle) {
line 4707
;4707:	if (!PC_Script_Parse(handle, &item->leaveFocus)) {
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
NEI4 $2199
line 4708
;4708:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2198
JUMPV
LABELV $2199
line 4710
;4709:	}
;4710:	return qtrue;
CNSTI4 1
RETI4
LABELV $2198
endproc ItemParse_leaveFocus 4 8
export ItemParse_mouseEnter
proc ItemParse_mouseEnter 4 8
line 4713
;4711:}
;4712:
;4713:qboolean ItemParse_mouseEnter(itemDef_t *item, int handle) {
line 4714
;4714:	if (!PC_Script_Parse(handle, &item->mouseEnter)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 244
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2202
line 4715
;4715:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2201
JUMPV
LABELV $2202
line 4717
;4716:	}
;4717:	return qtrue;
CNSTI4 1
RETI4
LABELV $2201
endproc ItemParse_mouseEnter 4 8
export ItemParse_mouseExit
proc ItemParse_mouseExit 4 8
line 4720
;4718:}
;4719:
;4720:qboolean ItemParse_mouseExit(itemDef_t *item, int handle) {
line 4721
;4721:	if (!PC_Script_Parse(handle, &item->mouseExit)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 248
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2205
line 4722
;4722:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2204
JUMPV
LABELV $2205
line 4724
;4723:	}
;4724:	return qtrue;
CNSTI4 1
RETI4
LABELV $2204
endproc ItemParse_mouseExit 4 8
export ItemParse_mouseEnterText
proc ItemParse_mouseEnterText 4 8
line 4727
;4725:}
;4726:
;4727:qboolean ItemParse_mouseEnterText(itemDef_t *item, int handle) {
line 4728
;4728:	if (!PC_Script_Parse(handle, &item->mouseEnterText)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2208
line 4729
;4729:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2207
JUMPV
LABELV $2208
line 4731
;4730:	}
;4731:	return qtrue;
CNSTI4 1
RETI4
LABELV $2207
endproc ItemParse_mouseEnterText 4 8
export ItemParse_mouseExitText
proc ItemParse_mouseExitText 4 8
line 4734
;4732:}
;4733:
;4734:qboolean ItemParse_mouseExitText(itemDef_t *item, int handle) {
line 4735
;4735:	if (!PC_Script_Parse(handle, &item->mouseExitText)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2211
line 4736
;4736:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2210
JUMPV
LABELV $2211
line 4738
;4737:	}
;4738:	return qtrue;
CNSTI4 1
RETI4
LABELV $2210
endproc ItemParse_mouseExitText 4 8
export ItemParse_action
proc ItemParse_action 4 8
line 4741
;4739:}
;4740:
;4741:qboolean ItemParse_action(itemDef_t *item, int handle) {
line 4742
;4742:	if (!PC_Script_Parse(handle, &item->action)) {
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
NEI4 $2214
line 4743
;4743:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2213
JUMPV
LABELV $2214
line 4745
;4744:	}
;4745:	return qtrue;
CNSTI4 1
RETI4
LABELV $2213
endproc ItemParse_action 4 8
export ItemParse_special
proc ItemParse_special 4 8
line 4748
;4746:}
;4747:
;4748:qboolean ItemParse_special(itemDef_t *item, int handle) {
line 4749
;4749:	if (!PC_Float_Parse(handle, &item->special)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 528
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2217
line 4750
;4750:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2216
JUMPV
LABELV $2217
line 4752
;4751:	}
;4752:	return qtrue;
CNSTI4 1
RETI4
LABELV $2216
endproc ItemParse_special 4 8
export ItemParse_cvarTest
proc ItemParse_cvarTest 4 8
line 4755
;4753:}
;4754:
;4755:qboolean ItemParse_cvarTest(itemDef_t *item, int handle) {
line 4756
;4756:	if (!PC_String_Parse(handle, &item->cvarTest)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 268
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2220
line 4757
;4757:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2219
JUMPV
LABELV $2220
line 4759
;4758:	}
;4759:	return qtrue;
CNSTI4 1
RETI4
LABELV $2219
endproc ItemParse_cvarTest 4 8
export ItemParse_cvar
proc ItemParse_cvar 8 8
line 4762
;4760:}
;4761:
;4762:qboolean ItemParse_cvar(itemDef_t *item, int handle) {
line 4765
;4763:	editFieldDef_t *editPtr;
;4764:
;4765:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4766
;4766:	if (!PC_String_Parse(handle, &item->cvar)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2223
line 4767
;4767:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2222
JUMPV
LABELV $2223
line 4769
;4768:	}
;4769:	if (item->typeData) {
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2225
line 4770
;4770:		editPtr = (editFieldDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4771
;4771:		editPtr->minVal = -1;
ADDRLP4 0
INDIRP4
CNSTF4 3212836864
ASGNF4
line 4772
;4772:		editPtr->maxVal = -1;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 3212836864
ASGNF4
line 4773
;4773:		editPtr->defVal = -1;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 3212836864
ASGNF4
line 4774
;4774:	}
LABELV $2225
line 4775
;4775:	return qtrue;
CNSTI4 1
RETI4
LABELV $2222
endproc ItemParse_cvar 8 8
export ItemParse_maxChars
proc ItemParse_maxChars 12 8
line 4778
;4776:}
;4777:
;4778:qboolean ItemParse_maxChars(itemDef_t *item, int handle) {
line 4782
;4779:	editFieldDef_t *editPtr;
;4780:	int maxChars;
;4781:
;4782:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4783
;4783:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2228
line 4784
;4784:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2227
JUMPV
LABELV $2228
line 4786
;4785:
;4786:	if (!PC_Int_Parse(handle, &maxChars)) {
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
NEI4 $2230
line 4787
;4787:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2227
JUMPV
LABELV $2230
line 4789
;4788:	}
;4789:	editPtr = (editFieldDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4790
;4790:	editPtr->maxChars = maxChars;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 4791
;4791:	return qtrue;
CNSTI4 1
RETI4
LABELV $2227
endproc ItemParse_maxChars 12 8
export ItemParse_maxPaintChars
proc ItemParse_maxPaintChars 12 8
line 4794
;4792:}
;4793:
;4794:qboolean ItemParse_maxPaintChars(itemDef_t *item, int handle) {
line 4798
;4795:	editFieldDef_t *editPtr;
;4796:	int maxChars;
;4797:
;4798:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4799
;4799:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2233
line 4800
;4800:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2232
JUMPV
LABELV $2233
line 4802
;4801:
;4802:	if (!PC_Int_Parse(handle, &maxChars)) {
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
NEI4 $2235
line 4803
;4803:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2232
JUMPV
LABELV $2235
line 4805
;4804:	}
;4805:	editPtr = (editFieldDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4806
;4806:	editPtr->maxPaintChars = maxChars;
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 4807
;4807:	return qtrue;
CNSTI4 1
RETI4
LABELV $2232
endproc ItemParse_maxPaintChars 12 8
export ItemParse_cvarFloat
proc ItemParse_cvarFloat 20 8
line 4812
;4808:}
;4809:
;4810:
;4811:
;4812:qboolean ItemParse_cvarFloat(itemDef_t *item, int handle) {
line 4815
;4813:	editFieldDef_t *editPtr;
;4814:
;4815:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4816
;4816:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2238
line 4817
;4817:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2237
JUMPV
LABELV $2238
line 4818
;4818:	editPtr = (editFieldDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4819
;4819:	if (PC_String_Parse(handle, &item->cvar) &&
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 264
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2240
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
EQI4 $2240
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
EQI4 $2240
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
EQI4 $2240
line 4822
;4820:		PC_Float_Parse(handle, &editPtr->defVal) &&
;4821:		PC_Float_Parse(handle, &editPtr->minVal) &&
;4822:		PC_Float_Parse(handle, &editPtr->maxVal)) {
line 4823
;4823:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2237
JUMPV
LABELV $2240
line 4825
;4824:	}
;4825:	return qfalse;
CNSTI4 0
RETI4
LABELV $2237
endproc ItemParse_cvarFloat 20 8
export ItemParse_cvarStrList
proc ItemParse_cvarStrList 1068 8
line 4828
;4826:}
;4827:
;4828:qboolean ItemParse_cvarStrList(itemDef_t *item, int handle) {
line 4833
;4829:	pc_token_t token;
;4830:	multiDef_t *multiPtr;
;4831:	int pass;
;4832:
;4833:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4834
;4834:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2243
line 4835
;4835:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2242
JUMPV
LABELV $2243
line 4836
;4836:	multiPtr = (multiDef_t *)item->typeData;
ADDRLP4 1040
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4837
;4837:	multiPtr->count = 0;
ADDRLP4 1040
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 0
ASGNI4
line 4838
;4838:	multiPtr->strDef = qtrue;
ADDRLP4 1040
INDIRP4
CNSTI4 388
ADDP4
CNSTI4 1
ASGNI4
line 4840
;4839:
;4840:	if (!trap_PC_ReadToken(handle, &token))
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
NEI4 $2245
line 4841
;4841:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2242
JUMPV
LABELV $2245
line 4842
;4842:	if (*token.string != '{') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $2247
line 4843
;4843:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2242
JUMPV
LABELV $2247
line 4846
;4844:	}
;4845:
;4846:	pass = 0;
ADDRLP4 1044
CNSTI4 0
ASGNI4
ADDRGP4 $2251
JUMPV
LABELV $2250
line 4847
;4847:	while (1) {
line 4848
;4848:		if (!trap_PC_ReadToken(handle, &token)) {
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
NEI4 $2253
line 4849
;4849:			PC_SourceError(handle, "end of file inside menu item\n");
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $2255
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 4850
;4850:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2242
JUMPV
LABELV $2253
line 4853
;4851:		}
;4852:
;4853:		if (*token.string == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $2256
line 4854
;4854:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2242
JUMPV
LABELV $2256
line 4857
;4855:		}
;4856:
;4857:		if (*token.string == ',' || *token.string == ';') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 44
EQI4 $2263
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 59
NEI4 $2259
LABELV $2263
line 4858
;4858:			continue;
ADDRGP4 $2251
JUMPV
LABELV $2259
line 4861
;4859:		}
;4860:
;4861:		if (pass == 0) {
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $2264
line 4862
;4862:			multiPtr->cvarList[multiPtr->count] = String_Alloc(token.string);
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
line 4863
;4863:			pass = 1;
ADDRLP4 1044
CNSTI4 1
ASGNI4
line 4864
;4864:		} else {
ADDRGP4 $2265
JUMPV
LABELV $2264
line 4865
;4865:			multiPtr->cvarStr[multiPtr->count] = String_Alloc(token.string);
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
line 4866
;4866:			pass = 0;
ADDRLP4 1044
CNSTI4 0
ASGNI4
line 4867
;4867:			multiPtr->count++;
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
line 4868
;4868:			if (multiPtr->count >= MAX_MULTI_CVARS) {
ADDRLP4 1040
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 32
LTI4 $2268
line 4869
;4869:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2242
JUMPV
LABELV $2268
line 4871
;4870:			}
;4871:		}
LABELV $2265
line 4873
;4872:
;4873:	}
LABELV $2251
line 4847
ADDRGP4 $2250
JUMPV
line 4874
;4874:	return qfalse; 	// bk001205 - LCC missing return value
CNSTI4 0
RETI4
LABELV $2242
endproc ItemParse_cvarStrList 1068 8
export ItemParse_cvarFloatList
proc ItemParse_cvarFloatList 1072 8
line 4877
;4875:}
;4876:
;4877:qboolean ItemParse_cvarFloatList(itemDef_t *item, int handle) {
line 4881
;4878:	pc_token_t token;
;4879:	multiDef_t *multiPtr;
;4880:
;4881:	Item_ValidateTypeData(item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Item_ValidateTypeData
CALLV
pop
line 4882
;4882:	if (!item->typeData)
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2271
line 4883
;4883:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2270
JUMPV
LABELV $2271
line 4884
;4884:	multiPtr = (multiDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 4885
;4885:	multiPtr->count = 0;
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
CNSTI4 0
ASGNI4
line 4886
;4886:	multiPtr->strDef = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
CNSTI4 0
ASGNI4
line 4888
;4887:
;4888:	if (!trap_PC_ReadToken(handle, &token))
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
NEI4 $2273
line 4889
;4889:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2270
JUMPV
LABELV $2273
line 4890
;4890:	if (*token.string != '{') {
ADDRLP4 4+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $2279
line 4891
;4891:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2270
JUMPV
LABELV $2278
line 4894
;4892:	}
;4893:
;4894:	while (1) {
line 4895
;4895:		if (!trap_PC_ReadToken(handle, &token)) {
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
NEI4 $2281
line 4896
;4896:			PC_SourceError(handle, "end of file inside menu item\n");
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $2255
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 4897
;4897:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2270
JUMPV
LABELV $2281
line 4900
;4898:		}
;4899:
;4900:		if (*token.string == '}') {
ADDRLP4 4+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $2283
line 4901
;4901:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2270
JUMPV
LABELV $2283
line 4904
;4902:		}
;4903:
;4904:		if (*token.string == ',' || *token.string == ';') {
ADDRLP4 4+16
INDIRI1
CVII4 1
CNSTI4 44
EQI4 $2290
ADDRLP4 4+16
INDIRI1
CVII4 1
CNSTI4 59
NEI4 $2286
LABELV $2290
line 4905
;4905:			continue;
ADDRGP4 $2279
JUMPV
LABELV $2286
line 4908
;4906:		}
;4907:
;4908:		multiPtr->cvarList[multiPtr->count] = String_Alloc(token.string);
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
line 4909
;4909:		if (!PC_Float_Parse(handle, &multiPtr->cvarValue[multiPtr->count])) {
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
NEI4 $2292
line 4910
;4910:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2270
JUMPV
LABELV $2292
line 4913
;4911:		}
;4912:
;4913:		multiPtr->count++;
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
line 4914
;4914:		if (multiPtr->count >= MAX_MULTI_CVARS) {
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 32
LTI4 $2294
line 4915
;4915:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2270
JUMPV
LABELV $2294
line 4918
;4916:		}
;4917:
;4918:	}
LABELV $2279
line 4894
ADDRGP4 $2278
JUMPV
line 4919
;4919:	return qfalse; 	// bk001205 - LCC missing return value
CNSTI4 0
RETI4
LABELV $2270
endproc ItemParse_cvarFloatList 1072 8
export ItemParse_addColorRange
proc ItemParse_addColorRange 44 12
line 4924
;4920:}
;4921:
;4922:
;4923:
;4924:qboolean ItemParse_addColorRange(itemDef_t *item, int handle) {
line 4927
;4925:	colorRangeDef_t color;
;4926:
;4927:	if (PC_Float_Parse(handle, &color.low) &&
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
EQI4 $2297
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
EQI4 $2297
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
EQI4 $2297
line 4929
;4928:		PC_Float_Parse(handle, &color.high) &&
;4929:		PC_Color_Parse(handle, &color.color)) {
line 4930
;4930:		if (item->numColors < MAX_COLOR_RANGES) {
ADDRFP4 0
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
CNSTI4 10
GEI4 $2301
line 4931
;4931:			memcpy(&item->colorRanges[item->numColors], &color, sizeof(color));
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
CNSTI4 24
MULI4
ADDRLP4 36
INDIRP4
CNSTI4 288
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
line 4932
;4932:			item->numColors++;
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 284
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
line 4933
;4933:		}
LABELV $2301
line 4934
;4934:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2296
JUMPV
LABELV $2297
line 4936
;4935:	}
;4936:	return qfalse;
CNSTI4 0
RETI4
LABELV $2296
endproc ItemParse_addColorRange 44 12
export ItemParse_ownerdrawFlag
proc ItemParse_ownerdrawFlag 12 8
line 4939
;4937:}
;4938:
;4939:qboolean ItemParse_ownerdrawFlag(itemDef_t *item, int handle) {
line 4941
;4940:	int i;
;4941:	if (!PC_Int_Parse(handle, &i)) {
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
NEI4 $2304
line 4942
;4942:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2303
JUMPV
LABELV $2304
line 4944
;4943:	}
;4944:	item->window.ownerDrawFlags |= i;
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
line 4945
;4945:	return qtrue;
CNSTI4 1
RETI4
LABELV $2303
endproc ItemParse_ownerdrawFlag 12 8
export ItemParse_enableCvar
proc ItemParse_enableCvar 4 8
line 4948
;4946:}
;4947:
;4948:qboolean ItemParse_enableCvar(itemDef_t *item, int handle) {
line 4949
;4949:	if (PC_Script_Parse(handle, &item->enableCvar)) {
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
EQI4 $2307
line 4950
;4950:		item->cvarFlags = CVAR_ENABLE;
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
CNSTI4 1
ASGNI4
line 4951
;4951:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2306
JUMPV
LABELV $2307
line 4953
;4952:	}
;4953:	return qfalse;
CNSTI4 0
RETI4
LABELV $2306
endproc ItemParse_enableCvar 4 8
export ItemParse_disableCvar
proc ItemParse_disableCvar 4 8
line 4956
;4954:}
;4955:
;4956:qboolean ItemParse_disableCvar(itemDef_t *item, int handle) {
line 4957
;4957:	if (PC_Script_Parse(handle, &item->enableCvar)) {
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
EQI4 $2310
line 4958
;4958:		item->cvarFlags = CVAR_DISABLE;
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
CNSTI4 2
ASGNI4
line 4959
;4959:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2309
JUMPV
LABELV $2310
line 4961
;4960:	}
;4961:	return qfalse;
CNSTI4 0
RETI4
LABELV $2309
endproc ItemParse_disableCvar 4 8
export ItemParse_showCvar
proc ItemParse_showCvar 4 8
line 4964
;4962:}
;4963:
;4964:qboolean ItemParse_showCvar(itemDef_t *item, int handle) {
line 4965
;4965:	if (PC_Script_Parse(handle, &item->enableCvar)) {
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
EQI4 $2313
line 4966
;4966:		item->cvarFlags = CVAR_SHOW;
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
CNSTI4 4
ASGNI4
line 4967
;4967:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2312
JUMPV
LABELV $2313
line 4969
;4968:	}
;4969:	return qfalse;
CNSTI4 0
RETI4
LABELV $2312
endproc ItemParse_showCvar 4 8
export ItemParse_hideCvar
proc ItemParse_hideCvar 4 8
line 4972
;4970:}
;4971:
;4972:qboolean ItemParse_hideCvar(itemDef_t *item, int handle) {
line 4973
;4973:	if (PC_Script_Parse(handle, &item->enableCvar)) {
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
EQI4 $2316
line 4974
;4974:		item->cvarFlags = CVAR_HIDE;
ADDRFP4 0
INDIRP4
CNSTI4 276
ADDP4
CNSTI4 8
ASGNI4
line 4975
;4975:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2315
JUMPV
LABELV $2316
line 4977
;4976:	}
;4977:	return qfalse;
CNSTI4 0
RETI4
LABELV $2315
endproc ItemParse_hideCvar 4 8
data
export itemParseKeywords
align 4
LABELV itemParseKeywords
address $2318
address ItemParse_name
byte 4 0
address $2319
address ItemParse_text
byte 4 0
address $2320
address ItemParse_group
byte 4 0
address $2321
address ItemParse_asset_model
byte 4 0
address $2322
address ItemParse_asset_shader
byte 4 0
address $2323
address ItemParse_model_origin
byte 4 0
address $2324
address ItemParse_model_fovx
byte 4 0
address $2325
address ItemParse_model_fovy
byte 4 0
address $2326
address ItemParse_model_rotation
byte 4 0
address $2327
address ItemParse_model_angle
byte 4 0
address $2328
address ItemParse_rect
byte 4 0
address $2329
address ItemParse_style
byte 4 0
address $2330
address ItemParse_decoration
byte 4 0
address $2331
address ItemParse_notselectable
byte 4 0
address $2332
address ItemParse_wrapped
byte 4 0
address $2333
address ItemParse_autowrapped
byte 4 0
address $2334
address ItemParse_horizontalscroll
byte 4 0
address $2335
address ItemParse_type
byte 4 0
address $2336
address ItemParse_elementwidth
byte 4 0
address $2337
address ItemParse_elementheight
byte 4 0
address $2338
address ItemParse_feeder
byte 4 0
address $2339
address ItemParse_elementtype
byte 4 0
address $2340
address ItemParse_columns
byte 4 0
address $2341
address ItemParse_border
byte 4 0
address $2342
address ItemParse_bordersize
byte 4 0
address $2343
address ItemParse_visible
byte 4 0
address $2344
address ItemParse_ownerdraw
byte 4 0
address $2345
address ItemParse_align
byte 4 0
address $2346
address ItemParse_textalign
byte 4 0
address $2347
address ItemParse_textalignx
byte 4 0
address $2348
address ItemParse_textaligny
byte 4 0
address $2349
address ItemParse_textscale
byte 4 0
address $2350
address ItemParse_textstyle
byte 4 0
address $358
address ItemParse_backcolor
byte 4 0
address $361
address ItemParse_forecolor
byte 4 0
address $364
address ItemParse_bordercolor
byte 4 0
address $2351
address ItemParse_outlinecolor
byte 4 0
address $2352
address ItemParse_background
byte 4 0
address $2353
address ItemParse_onFocus
byte 4 0
address $2354
address ItemParse_leaveFocus
byte 4 0
address $2355
address ItemParse_mouseEnter
byte 4 0
address $2356
address ItemParse_mouseExit
byte 4 0
address $2357
address ItemParse_mouseEnterText
byte 4 0
address $2358
address ItemParse_mouseExitText
byte 4 0
address $2359
address ItemParse_action
byte 4 0
address $2360
address ItemParse_special
byte 4 0
address $2361
address ItemParse_cvar
byte 4 0
address $2362
address ItemParse_maxChars
byte 4 0
address $2363
address ItemParse_maxPaintChars
byte 4 0
address $2364
address ItemParse_focusSound
byte 4 0
address $2365
address ItemParse_cvarFloat
byte 4 0
address $2366
address ItemParse_cvarStrList
byte 4 0
address $2367
address ItemParse_cvarFloatList
byte 4 0
address $2368
address ItemParse_addColorRange
byte 4 0
address $2369
address ItemParse_ownerdrawFlag
byte 4 0
address $2370
address ItemParse_enableCvar
byte 4 0
address $2371
address ItemParse_cvarTest
byte 4 0
address $2372
address ItemParse_disableCvar
byte 4 0
address $2373
address ItemParse_showCvar
byte 4 0
address $2374
address ItemParse_hideCvar
byte 4 0
address $2375
address ItemParse_cinematic
byte 4 0
address $2376
address ItemParse_doubleClick
byte 4 0
byte 4 0
byte 4 0
byte 4 0
export Item_SetupKeywordHash
code
proc Item_SetupKeywordHash 4 12
line 5054
;4978:}
;4979:
;4980:
;4981:keywordHash_t itemParseKeywords[] = {
;4982:	{"name", ItemParse_name, NULL},
;4983:	{"text", ItemParse_text, NULL},
;4984:	{"group", ItemParse_group, NULL},
;4985:	{"asset_model", ItemParse_asset_model, NULL},
;4986:	{"asset_shader", ItemParse_asset_shader, NULL},
;4987:	{"model_origin", ItemParse_model_origin, NULL},
;4988:	{"model_fovx", ItemParse_model_fovx, NULL},
;4989:	{"model_fovy", ItemParse_model_fovy, NULL},
;4990:	{"model_rotation", ItemParse_model_rotation, NULL},
;4991:	{"model_angle", ItemParse_model_angle, NULL},
;4992:	{"rect", ItemParse_rect, NULL},
;4993:	{"style", ItemParse_style, NULL},
;4994:	{"decoration", ItemParse_decoration, NULL},
;4995:	{"notselectable", ItemParse_notselectable, NULL},
;4996:	{"wrapped", ItemParse_wrapped, NULL},
;4997:	{"autowrapped", ItemParse_autowrapped, NULL},
;4998:	{"horizontalscroll", ItemParse_horizontalscroll, NULL},
;4999:	{"type", ItemParse_type, NULL},
;5000:	{"elementwidth", ItemParse_elementwidth, NULL},
;5001:	{"elementheight", ItemParse_elementheight, NULL},
;5002:	{"feeder", ItemParse_feeder, NULL},
;5003:	{"elementtype", ItemParse_elementtype, NULL},
;5004:	{"columns", ItemParse_columns, NULL},
;5005:	{"border", ItemParse_border, NULL},
;5006:	{"bordersize", ItemParse_bordersize, NULL},
;5007:	{"visible", ItemParse_visible, NULL},
;5008:	{"ownerdraw", ItemParse_ownerdraw, NULL},
;5009:	{"align", ItemParse_align, NULL},
;5010:	{"textalign", ItemParse_textalign, NULL},
;5011:	{"textalignx", ItemParse_textalignx, NULL},
;5012:	{"textaligny", ItemParse_textaligny, NULL},
;5013:	{"textscale", ItemParse_textscale, NULL},
;5014:	{"textstyle", ItemParse_textstyle, NULL},
;5015:	{"backcolor", ItemParse_backcolor, NULL},
;5016:	{"forecolor", ItemParse_forecolor, NULL},
;5017:	{"bordercolor", ItemParse_bordercolor, NULL},
;5018:	{"outlinecolor", ItemParse_outlinecolor, NULL},
;5019:	{"background", ItemParse_background, NULL},
;5020:	{"onFocus", ItemParse_onFocus, NULL},
;5021:	{"leaveFocus", ItemParse_leaveFocus, NULL},
;5022:	{"mouseEnter", ItemParse_mouseEnter, NULL},
;5023:	{"mouseExit", ItemParse_mouseExit, NULL},
;5024:	{"mouseEnterText", ItemParse_mouseEnterText, NULL},
;5025:	{"mouseExitText", ItemParse_mouseExitText, NULL},
;5026:	{"action", ItemParse_action, NULL},
;5027:	{"special", ItemParse_special, NULL},
;5028:	{"cvar", ItemParse_cvar, NULL},
;5029:	{"maxChars", ItemParse_maxChars, NULL},
;5030:	{"maxPaintChars", ItemParse_maxPaintChars, NULL},
;5031:	{"focusSound", ItemParse_focusSound, NULL},
;5032:	{"cvarFloat", ItemParse_cvarFloat, NULL},
;5033:	{"cvarStrList", ItemParse_cvarStrList, NULL},
;5034:	{"cvarFloatList", ItemParse_cvarFloatList, NULL},
;5035:	{"addColorRange", ItemParse_addColorRange, NULL},
;5036:	{"ownerdrawFlag", ItemParse_ownerdrawFlag, NULL},
;5037:	{"enableCvar", ItemParse_enableCvar, NULL},
;5038:	{"cvarTest", ItemParse_cvarTest, NULL},
;5039:	{"disableCvar", ItemParse_disableCvar, NULL},
;5040:	{"showCvar", ItemParse_showCvar, NULL},
;5041:	{"hideCvar", ItemParse_hideCvar, NULL},
;5042:	{"cinematic", ItemParse_cinematic, NULL},
;5043:	{"doubleclick", ItemParse_doubleClick, NULL},
;5044:	{NULL, NULL, NULL}
;5045:};
;5046:
;5047:keywordHash_t *itemParseKeywordHash[KEYWORDHASH_SIZE];
;5048:
;5049:/*
;5050:===============
;5051:Item_SetupKeywordHash
;5052:===============
;5053:*/
;5054:void Item_SetupKeywordHash(void) {
line 5057
;5055:	int i;
;5056:
;5057:	memset(itemParseKeywordHash, 0, sizeof(itemParseKeywordHash));
ADDRGP4 itemParseKeywordHash
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2048
ARGI4
ADDRGP4 memset
CALLP4
pop
line 5058
;5058:	for (i = 0; itemParseKeywords[i].keyword; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2381
JUMPV
LABELV $2378
line 5059
;5059:		KeywordHash_Add(itemParseKeywordHash, &itemParseKeywords[i]);
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
line 5060
;5060:	}
LABELV $2379
line 5058
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2381
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 itemParseKeywords
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2378
line 5061
;5061:}
LABELV $2377
endproc Item_SetupKeywordHash 4 12
export Item_Parse
proc Item_Parse 1060 12
line 5068
;5062:
;5063:/*
;5064:===============
;5065:Item_Parse
;5066:===============
;5067:*/
;5068:qboolean Item_Parse(int handle, itemDef_t *item) {
line 5073
;5069:	pc_token_t token;
;5070:	keywordHash_t *key;
;5071:
;5072:
;5073:	if (!trap_PC_ReadToken(handle, &token))
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
NEI4 $2383
line 5074
;5074:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2382
JUMPV
LABELV $2383
line 5075
;5075:	if (*token.string != '{') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $2389
line 5076
;5076:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2382
JUMPV
LABELV $2388
line 5078
;5077:	}
;5078:	while (1) {
line 5079
;5079:		if (!trap_PC_ReadToken(handle, &token)) {
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
NEI4 $2391
line 5080
;5080:			PC_SourceError(handle, "end of file inside menu item\n");
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2255
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 5081
;5081:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2382
JUMPV
LABELV $2391
line 5084
;5082:		}
;5083:
;5084:		if (*token.string == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $2393
line 5085
;5085:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2382
JUMPV
LABELV $2393
line 5088
;5086:		}
;5087:
;5088:		key = KeywordHash_Find(itemParseKeywordHash, token.string);
ADDRGP4 itemParseKeywordHash
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
line 5089
;5089:		if (!key) {
ADDRLP4 1040
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2397
line 5090
;5090:			PC_SourceError(handle, "unknown menu item keyword %s", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2399
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 5091
;5091:			continue;
ADDRGP4 $2389
JUMPV
LABELV $2397
line 5093
;5092:		}
;5093:		if (!key->func(item, handle)) {
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
NEI4 $2401
line 5094
;5094:			PC_SourceError(handle, "couldn't parse menu item keyword %s", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2403
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 5095
;5095:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2382
JUMPV
LABELV $2401
line 5097
;5096:		}
;5097:	}
LABELV $2389
line 5078
ADDRGP4 $2388
JUMPV
line 5098
;5098:	return qfalse; 	// bk001205 - LCC missing return value
CNSTI4 0
RETI4
LABELV $2382
endproc Item_Parse 1060 12
export Item_InitControls
proc Item_InitControls 4 0
line 5104
;5099:}
;5100:
;5101:
;5102:// Item_InitControls
;5103:// init's special control types
;5104:void Item_InitControls(itemDef_t *item) {
line 5105
;5105:	if (item == NULL) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2406
line 5106
;5106:		return;
ADDRGP4 $2405
JUMPV
LABELV $2406
line 5108
;5107:	}
;5108:	if (item->type == ITEM_TYPE_LISTBOX) {
ADDRFP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 6
NEI4 $2408
line 5109
;5109:		listBoxDef_t *listPtr = (listBoxDef_t *)item->typeData;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
line 5110
;5110:		item->cursorPos = 0;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 0
ASGNI4
line 5111
;5111:		if (listPtr) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2410
line 5112
;5112:			listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 5113
;5113:			listPtr->startPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 5114
;5114:			listPtr->endPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 5115
;5115:			listPtr->cursorPos = 0;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 5116
;5116:		}
LABELV $2410
line 5117
;5117:	}
LABELV $2408
line 5118
;5118:}
LABELV $2405
endproc Item_InitControls 4 0
export MenuParse_font
proc MenuParse_font 12 12
line 5126
;5119:
;5120:/*
;5121:===============
;5122:Menu Keyword Parse functions
;5123:===============
;5124:*/
;5125:
;5126:qboolean MenuParse_font(itemDef_t *item, int handle) {
line 5127
;5127:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5128
;5128:	if (!PC_String_Parse(handle, &menu->font)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2413
line 5129
;5129:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2412
JUMPV
LABELV $2413
line 5131
;5130:	}
;5131:	if (!DC->Assets.fontRegistered) {
ADDRGP4 DC
INDIRP4
CNSTI4 61992
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2415
line 5132
;5132:		DC->registerFont(menu->font, 48, &DC->Assets.textFont);
ADDRLP4 0
INDIRP4
CNSTI4 180
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
CNSTI4 240
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
CNSTI4 64
ADDP4
INDIRP4
CALLV
pop
line 5133
;5133:		DC->Assets.fontRegistered = qtrue;
ADDRGP4 DC
INDIRP4
CNSTI4 61992
ADDP4
CNSTI4 1
ASGNI4
line 5134
;5134:	}
LABELV $2415
line 5135
;5135:	return qtrue;
CNSTI4 1
RETI4
LABELV $2412
endproc MenuParse_font 12 12
export MenuParse_name
proc MenuParse_name 12 8
line 5138
;5136:}
;5137:
;5138:qboolean MenuParse_name(itemDef_t *item, int handle) {
line 5139
;5139:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5140
;5140:	if (!PC_String_Parse(handle, &menu->window.name)) {
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
NEI4 $2418
line 5141
;5141:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2417
JUMPV
LABELV $2418
line 5143
;5142:	}
;5143:	if (Q_stricmp(menu->window.name, "main") == 0) {
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
ARGP4
ADDRGP4 $2422
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2420
line 5146
;5144:		// default main as having focus
;5145:		//menu->window.flags |= WINDOW_HASFOCUS;
;5146:	}
LABELV $2420
line 5147
;5147:	return qtrue;
CNSTI4 1
RETI4
LABELV $2417
endproc MenuParse_name 12 8
export MenuParse_fullscreen
proc MenuParse_fullscreen 8 8
line 5150
;5148:}
;5149:
;5150:qboolean MenuParse_fullscreen(itemDef_t *item, int handle) {
line 5151
;5151:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5152
;5152:	if (!PC_Int_Parse(handle, (int *)&menu->fullScreen)) { // bk001206 - cast qboolean
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2424
line 5153
;5153:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2423
JUMPV
LABELV $2424
line 5155
;5154:	}
;5155:	return qtrue;
CNSTI4 1
RETI4
LABELV $2423
endproc MenuParse_fullscreen 8 8
export MenuParse_rect
proc MenuParse_rect 8 8
line 5158
;5156:}
;5157:
;5158:qboolean MenuParse_rect(itemDef_t *item, int handle) {
line 5159
;5159:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5160
;5160:	if (!PC_Rect_Parse(handle, &menu->window.rect)) {
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
NEI4 $2427
line 5161
;5161:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2426
JUMPV
LABELV $2427
line 5163
;5162:	}
;5163:	return qtrue;
CNSTI4 1
RETI4
LABELV $2426
endproc MenuParse_rect 8 8
export MenuParse_style
proc MenuParse_style 8 8
line 5166
;5164:}
;5165:
;5166:qboolean MenuParse_style(itemDef_t *item, int handle) {
line 5167
;5167:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5168
;5168:	if (!PC_Int_Parse(handle, &menu->window.style)) {
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
NEI4 $2430
line 5169
;5169:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2429
JUMPV
LABELV $2430
line 5171
;5170:	}
;5171:	return qtrue;
CNSTI4 1
RETI4
LABELV $2429
endproc MenuParse_style 8 8
export MenuParse_visible
proc MenuParse_visible 16 8
line 5174
;5172:}
;5173:
;5174:qboolean MenuParse_visible(itemDef_t *item, int handle) {
line 5176
;5175:	int i;
;5176:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 5178
;5177:
;5178:	if (!PC_Int_Parse(handle, &i)) {
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
NEI4 $2433
line 5179
;5179:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2432
JUMPV
LABELV $2433
line 5181
;5180:	}
;5181:	if (i) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2435
line 5182
;5182:		menu->window.flags |= WINDOW_VISIBLE;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 68
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
line 5183
;5183:	}
LABELV $2435
line 5184
;5184:	return qtrue;
CNSTI4 1
RETI4
LABELV $2432
endproc MenuParse_visible 16 8
export MenuParse_onOpen
proc MenuParse_onOpen 8 8
line 5187
;5185:}
;5186:
;5187:qboolean MenuParse_onOpen(itemDef_t *item, int handle) {
line 5188
;5188:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5189
;5189:	if (!PC_Script_Parse(handle, &menu->onOpen)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 212
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2438
line 5190
;5190:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2437
JUMPV
LABELV $2438
line 5192
;5191:	}
;5192:	return qtrue;
CNSTI4 1
RETI4
LABELV $2437
endproc MenuParse_onOpen 8 8
export MenuParse_onClose
proc MenuParse_onClose 8 8
line 5195
;5193:}
;5194:
;5195:qboolean MenuParse_onClose(itemDef_t *item, int handle) {
line 5196
;5196:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5197
;5197:	if (!PC_Script_Parse(handle, &menu->onClose)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 216
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Script_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2441
line 5198
;5198:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2440
JUMPV
LABELV $2441
line 5200
;5199:	}
;5200:	return qtrue;
CNSTI4 1
RETI4
LABELV $2440
endproc MenuParse_onClose 8 8
export MenuParse_onESC
proc MenuParse_onESC 8 8
line 5203
;5201:}
;5202:
;5203:qboolean MenuParse_onESC(itemDef_t *item, int handle) {
line 5204
;5204:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5205
;5205:	if (!PC_Script_Parse(handle, &menu->onESC)) {
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
NEI4 $2444
line 5206
;5206:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2443
JUMPV
LABELV $2444
line 5208
;5207:	}
;5208:	return qtrue;
CNSTI4 1
RETI4
LABELV $2443
endproc MenuParse_onESC 8 8
export MenuParse_border
proc MenuParse_border 8 8
line 5213
;5209:}
;5210:
;5211:
;5212:
;5213:qboolean MenuParse_border(itemDef_t *item, int handle) {
line 5214
;5214:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5215
;5215:	if (!PC_Int_Parse(handle, &menu->window.border)) {
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
NEI4 $2447
line 5216
;5216:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2446
JUMPV
LABELV $2447
line 5218
;5217:	}
;5218:	return qtrue;
CNSTI4 1
RETI4
LABELV $2446
endproc MenuParse_border 8 8
export MenuParse_borderSize
proc MenuParse_borderSize 8 8
line 5221
;5219:}
;5220:
;5221:qboolean MenuParse_borderSize(itemDef_t *item, int handle) {
line 5222
;5222:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5223
;5223:	if (!PC_Float_Parse(handle, &menu->window.borderSize)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 64
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2450
line 5224
;5224:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2449
JUMPV
LABELV $2450
line 5226
;5225:	}
;5226:	return qtrue;
CNSTI4 1
RETI4
LABELV $2449
endproc MenuParse_borderSize 8 8
export MenuParse_backcolor
proc MenuParse_backcolor 16 8
line 5229
;5227:}
;5228:
;5229:qboolean MenuParse_backcolor(itemDef_t *item, int handle) {
line 5232
;5230:	int i;
;5231:	float f;
;5232:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 5234
;5233:
;5234:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2453
line 5235
;5235:		if (!PC_Float_Parse(handle, &f)) {
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
NEI4 $2457
line 5236
;5236:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2452
JUMPV
LABELV $2457
line 5238
;5237:		}
;5238:		menu->window.backColor[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 128
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 5239
;5239:	}
LABELV $2454
line 5234
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2453
line 5240
;5240:	return qtrue;
CNSTI4 1
RETI4
LABELV $2452
endproc MenuParse_backcolor 16 8
export MenuParse_forecolor
proc MenuParse_forecolor 20 8
line 5243
;5241:}
;5242:
;5243:qboolean MenuParse_forecolor(itemDef_t *item, int handle) {
line 5246
;5244:	int i;
;5245:	float f;
;5246:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 5248
;5247:
;5248:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2460
line 5249
;5249:		if (!PC_Float_Parse(handle, &f)) {
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
NEI4 $2464
line 5250
;5250:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2459
JUMPV
LABELV $2464
line 5252
;5251:		}
;5252:		menu->window.foreColor[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 112
ADDP4
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
line 5253
;5253:		menu->window.flags |= WINDOW_FORECOLORSET;
ADDRLP4 16
ADDRLP4 4
INDIRP4
CNSTI4 68
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
line 5254
;5254:	}
LABELV $2461
line 5248
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2460
line 5255
;5255:	return qtrue;
CNSTI4 1
RETI4
LABELV $2459
endproc MenuParse_forecolor 20 8
export MenuParse_bordercolor
proc MenuParse_bordercolor 16 8
line 5258
;5256:}
;5257:
;5258:qboolean MenuParse_bordercolor(itemDef_t *item, int handle) {
line 5261
;5259:	int i;
;5260:	float f;
;5261:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 5263
;5262:
;5263:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2467
line 5264
;5264:		if (!PC_Float_Parse(handle, &f)) {
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
NEI4 $2471
line 5265
;5265:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2466
JUMPV
LABELV $2471
line 5267
;5266:		}
;5267:		menu->window.borderColor[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 144
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 5268
;5268:	}
LABELV $2468
line 5263
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2467
line 5269
;5269:	return qtrue;
CNSTI4 1
RETI4
LABELV $2466
endproc MenuParse_bordercolor 16 8
export MenuParse_focuscolor
proc MenuParse_focuscolor 16 8
line 5272
;5270:}
;5271:
;5272:qboolean MenuParse_focuscolor(itemDef_t *item, int handle) {
line 5275
;5273:	int i;
;5274:	float f;
;5275:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 5277
;5276:
;5277:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2474
line 5278
;5278:		if (!PC_Float_Parse(handle, &f)) {
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
NEI4 $2478
line 5279
;5279:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2473
JUMPV
LABELV $2478
line 5281
;5280:		}
;5281:		menu->focusColor[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 228
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 5282
;5282:	}
LABELV $2475
line 5277
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2474
line 5283
;5283:	return qtrue;
CNSTI4 1
RETI4
LABELV $2473
endproc MenuParse_focuscolor 16 8
export MenuParse_disablecolor
proc MenuParse_disablecolor 16 8
line 5286
;5284:}
;5285:
;5286:qboolean MenuParse_disablecolor(itemDef_t *item, int handle) {
line 5289
;5287:	int i;
;5288:	float f;
;5289:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
line 5290
;5290:	for (i = 0; i < 4; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2481
line 5291
;5291:		if (!PC_Float_Parse(handle, &f)) {
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
NEI4 $2485
line 5292
;5292:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2480
JUMPV
LABELV $2485
line 5294
;5293:		}
;5294:		menu->disableColor[i] = f;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 244
ADDP4
ADDP4
ADDRLP4 4
INDIRF4
ASGNF4
line 5295
;5295:	}
LABELV $2482
line 5290
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $2481
line 5296
;5296:	return qtrue;
CNSTI4 1
RETI4
LABELV $2480
endproc MenuParse_disablecolor 16 8
export MenuParse_outlinecolor
proc MenuParse_outlinecolor 8 8
line 5300
;5297:}
;5298:
;5299:
;5300:qboolean MenuParse_outlinecolor(itemDef_t *item, int handle) {
line 5301
;5301:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5302
;5302:	if (!PC_Color_Parse(handle, &menu->window.outlineColor)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Color_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2488
line 5303
;5303:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2487
JUMPV
LABELV $2488
line 5305
;5304:	}
;5305:	return qtrue;
CNSTI4 1
RETI4
LABELV $2487
endproc MenuParse_outlinecolor 8 8
export MenuParse_background
proc MenuParse_background 16 8
line 5308
;5306:}
;5307:
;5308:qboolean MenuParse_background(itemDef_t *item, int handle) {
line 5310
;5309:	const char *buff;
;5310:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 5312
;5311:
;5312:	if (!PC_String_Parse(handle, &buff)) {
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
NEI4 $2491
line 5313
;5313:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2490
JUMPV
LABELV $2491
line 5315
;5314:	}
;5315:	menu->window.background = DC->registerShaderNoMip(buff);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 DC
INDIRP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 176
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 5316
;5316:	return qtrue;
CNSTI4 1
RETI4
LABELV $2490
endproc MenuParse_background 16 8
export MenuParse_cinematic
proc MenuParse_cinematic 8 8
line 5319
;5317:}
;5318:
;5319:qboolean MenuParse_cinematic(itemDef_t *item, int handle) {
line 5320
;5320:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5322
;5321:
;5322:	if (!PC_String_Parse(handle, &menu->window.cinematicName)) {
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
NEI4 $2494
line 5323
;5323:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2493
JUMPV
LABELV $2494
line 5325
;5324:	}
;5325:	return qtrue;
CNSTI4 1
RETI4
LABELV $2493
endproc MenuParse_cinematic 8 8
export MenuParse_ownerdrawFlag
proc MenuParse_ownerdrawFlag 16 8
line 5328
;5326:}
;5327:
;5328:qboolean MenuParse_ownerdrawFlag(itemDef_t *item, int handle) {
line 5330
;5329:	int i;
;5330:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 5332
;5331:
;5332:	if (!PC_Int_Parse(handle, &i)) {
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
NEI4 $2497
line 5333
;5333:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2496
JUMPV
LABELV $2497
line 5335
;5334:	}
;5335:	menu->window.ownerDrawFlags |= i;
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
line 5336
;5336:	return qtrue;
CNSTI4 1
RETI4
LABELV $2496
endproc MenuParse_ownerdrawFlag 16 8
export MenuParse_ownerdraw
proc MenuParse_ownerdraw 8 8
line 5339
;5337:}
;5338:
;5339:qboolean MenuParse_ownerdraw(itemDef_t *item, int handle) {
line 5340
;5340:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5342
;5341:
;5342:	if (!PC_Int_Parse(handle, &menu->window.ownerDraw)) {
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
NEI4 $2500
line 5343
;5343:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2499
JUMPV
LABELV $2500
line 5345
;5344:	}
;5345:	return qtrue;
CNSTI4 1
RETI4
LABELV $2499
endproc MenuParse_ownerdraw 8 8
export MenuParse_popup
proc MenuParse_popup 8 0
line 5350
;5346:}
;5347:
;5348:
;5349:// decoration
;5350:qboolean MenuParse_popup(itemDef_t *item, int handle) {
line 5351
;5351:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5352
;5352:	menu->window.flags |= WINDOW_POPUP;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 68
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
line 5353
;5353:	return qtrue;
CNSTI4 1
RETI4
LABELV $2502
endproc MenuParse_popup 8 0
export MenuParse_outOfBounds
proc MenuParse_outOfBounds 8 0
line 5357
;5354:}
;5355:
;5356:
;5357:qboolean MenuParse_outOfBounds(itemDef_t *item, int handle) {
line 5358
;5358:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5360
;5359:
;5360:	menu->window.flags |= WINDOW_OOB_CLICK;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 68
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
line 5361
;5361:	return qtrue;
CNSTI4 1
RETI4
LABELV $2503
endproc MenuParse_outOfBounds 8 0
export MenuParse_soundLoop
proc MenuParse_soundLoop 8 8
line 5364
;5362:}
;5363:
;5364:qboolean MenuParse_soundLoop(itemDef_t *item, int handle) {
line 5365
;5365:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5367
;5366:
;5367:	if (!PC_String_Parse(handle, &menu->soundName)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 224
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2505
line 5368
;5368:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2504
JUMPV
LABELV $2505
line 5370
;5369:	}
;5370:	return qtrue;
CNSTI4 1
RETI4
LABELV $2504
endproc MenuParse_soundLoop 8 8
export MenuParse_fadeClamp
proc MenuParse_fadeClamp 8 8
line 5373
;5371:}
;5372:
;5373:qboolean MenuParse_fadeClamp(itemDef_t *item, int handle) {
line 5374
;5374:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5376
;5375:
;5376:	if (!PC_Float_Parse(handle, &menu->fadeClamp)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2508
line 5377
;5377:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2507
JUMPV
LABELV $2508
line 5379
;5378:	}
;5379:	return qtrue;
CNSTI4 1
RETI4
LABELV $2507
endproc MenuParse_fadeClamp 8 8
export MenuParse_fadeAmount
proc MenuParse_fadeAmount 8 8
line 5382
;5380:}
;5381:
;5382:qboolean MenuParse_fadeAmount(itemDef_t *item, int handle) {
line 5383
;5383:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5385
;5384:
;5385:	if (!PC_Float_Parse(handle, &menu->fadeAmount)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 208
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2511
line 5386
;5386:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2510
JUMPV
LABELV $2511
line 5388
;5387:	}
;5388:	return qtrue;
CNSTI4 1
RETI4
LABELV $2510
endproc MenuParse_fadeAmount 8 8
export MenuParse_fadeCycle
proc MenuParse_fadeCycle 8 8
line 5392
;5389:}
;5390:
;5391:
;5392:qboolean MenuParse_fadeCycle(itemDef_t *item, int handle) {
line 5393
;5393:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5395
;5394:
;5395:	if (!PC_Int_Parse(handle, &menu->fadeCycle)) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 200
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2514
line 5396
;5396:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2513
JUMPV
LABELV $2514
line 5398
;5397:	}
;5398:	return qtrue;
CNSTI4 1
RETI4
LABELV $2513
endproc MenuParse_fadeCycle 8 8
export MenuParse_itemDef
proc MenuParse_itemDef 40 8
line 5402
;5399:}
;5400:
;5401:
;5402:qboolean MenuParse_itemDef(itemDef_t *item, int handle) {
line 5403
;5403:	menuDef_t *menu = (menuDef_t *)item;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 5404
;5404:	if (menu->itemCount < MAX_MENUITEMS) {
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 96
GEI4 $2517
line 5405
;5405:		menu->items[menu->itemCount] = UI_Alloc(sizeof(itemDef_t));
CNSTI4 540
ARGI4
ADDRLP4 4
ADDRGP4 UI_Alloc
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 5406
;5406:		Item_Init(menu->items[menu->itemCount]);
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_Init
CALLV
pop
line 5407
;5407:		if (!Item_Parse(handle, menu->items[menu->itemCount])) {
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 Item_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $2519
line 5408
;5408:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2516
JUMPV
LABELV $2519
line 5410
;5409:		}
;5410:		Item_InitControls(menu->items[menu->itemCount]);
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_InitControls
CALLV
pop
line 5411
;5411:		menu->items[menu->itemCount++]->parent = menu;
ADDRLP4 32
ADDRLP4 0
INDIRP4
CNSTI4 188
ADDP4
ASGNP4
ADDRLP4 28
ADDRLP4 32
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRP4
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 228
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 5412
;5412:	}
LABELV $2517
line 5413
;5413:	return qtrue;
CNSTI4 1
RETI4
LABELV $2516
endproc MenuParse_itemDef 40 8
data
export menuParseKeywords
align 4
LABELV menuParseKeywords
address $2521
address MenuParse_font
byte 4 0
address $2318
address MenuParse_name
byte 4 0
address $2522
address MenuParse_fullscreen
byte 4 0
address $2328
address MenuParse_rect
byte 4 0
address $2329
address MenuParse_style
byte 4 0
address $2343
address MenuParse_visible
byte 4 0
address $2523
address MenuParse_onOpen
byte 4 0
address $2524
address MenuParse_onClose
byte 4 0
address $2525
address MenuParse_onESC
byte 4 0
address $2341
address MenuParse_border
byte 4 0
address $2526
address MenuParse_borderSize
byte 4 0
address $358
address MenuParse_backcolor
byte 4 0
address $361
address MenuParse_forecolor
byte 4 0
address $364
address MenuParse_bordercolor
byte 4 0
address $2527
address MenuParse_focuscolor
byte 4 0
address $2528
address MenuParse_disablecolor
byte 4 0
address $2351
address MenuParse_outlinecolor
byte 4 0
address $2352
address MenuParse_background
byte 4 0
address $2344
address MenuParse_ownerdraw
byte 4 0
address $2369
address MenuParse_ownerdrawFlag
byte 4 0
address $2529
address MenuParse_outOfBounds
byte 4 0
address $2530
address MenuParse_soundLoop
byte 4 0
address $2531
address MenuParse_itemDef
byte 4 0
address $2375
address MenuParse_cinematic
byte 4 0
address $2532
address MenuParse_popup
byte 4 0
address $2533
address MenuParse_fadeClamp
byte 4 0
address $2534
address MenuParse_fadeCycle
byte 4 0
address $2535
address MenuParse_fadeAmount
byte 4 0
byte 4 0
byte 4 0
byte 4 0
export Menu_SetupKeywordHash
code
proc Menu_SetupKeywordHash 4 12
line 5455
;5414:}
;5415:
;5416:keywordHash_t menuParseKeywords[] = {
;5417:	{"font", MenuParse_font, NULL},
;5418:	{"name", MenuParse_name, NULL},
;5419:	{"fullscreen", MenuParse_fullscreen, NULL},
;5420:	{"rect", MenuParse_rect, NULL},
;5421:	{"style", MenuParse_style, NULL},
;5422:	{"visible", MenuParse_visible, NULL},
;5423:	{"onOpen", MenuParse_onOpen, NULL},
;5424:	{"onClose", MenuParse_onClose, NULL},
;5425:	{"onESC", MenuParse_onESC, NULL},
;5426:	{"border", MenuParse_border, NULL},
;5427:	{"borderSize", MenuParse_borderSize, NULL},
;5428:	{"backcolor", MenuParse_backcolor, NULL},
;5429:	{"forecolor", MenuParse_forecolor, NULL},
;5430:	{"bordercolor", MenuParse_bordercolor, NULL},
;5431:	{"focuscolor", MenuParse_focuscolor, NULL},
;5432:	{"disablecolor", MenuParse_disablecolor, NULL},
;5433:	{"outlinecolor", MenuParse_outlinecolor, NULL},
;5434:	{"background", MenuParse_background, NULL},
;5435:	{"ownerdraw", MenuParse_ownerdraw, NULL},
;5436:	{"ownerdrawFlag", MenuParse_ownerdrawFlag, NULL},
;5437:	{"outOfBoundsClick", MenuParse_outOfBounds, NULL},
;5438:	{"soundLoop", MenuParse_soundLoop, NULL},
;5439:	{"itemDef", MenuParse_itemDef, NULL},
;5440:	{"cinematic", MenuParse_cinematic, NULL},
;5441:	{"popup", MenuParse_popup, NULL},
;5442:	{"fadeClamp", MenuParse_fadeClamp, NULL},
;5443:	{"fadeCycle", MenuParse_fadeCycle, NULL},
;5444:	{"fadeAmount", MenuParse_fadeAmount, NULL},
;5445:	{NULL, NULL, NULL}
;5446:};
;5447:
;5448:keywordHash_t *menuParseKeywordHash[KEYWORDHASH_SIZE];
;5449:
;5450:/*
;5451:===============
;5452:Menu_SetupKeywordHash
;5453:===============
;5454:*/
;5455:void Menu_SetupKeywordHash(void) {
line 5458
;5456:	int i;
;5457:
;5458:	memset(menuParseKeywordHash, 0, sizeof(menuParseKeywordHash));
ADDRGP4 menuParseKeywordHash
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2048
ARGI4
ADDRGP4 memset
CALLP4
pop
line 5459
;5459:	for (i = 0; menuParseKeywords[i].keyword; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2540
JUMPV
LABELV $2537
line 5460
;5460:		KeywordHash_Add(menuParseKeywordHash, &menuParseKeywords[i]);
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
line 5461
;5461:	}
LABELV $2538
line 5459
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2540
ADDRLP4 0
INDIRI4
CNSTI4 12
MULI4
ADDRGP4 menuParseKeywords
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2537
line 5462
;5462:}
LABELV $2536
endproc Menu_SetupKeywordHash 4 12
export Menu_Parse
proc Menu_Parse 1060 12
line 5469
;5463:
;5464:/*
;5465:===============
;5466:Menu_Parse
;5467:===============
;5468:*/
;5469:qboolean Menu_Parse(int handle, menuDef_t *menu) {
line 5473
;5470:	pc_token_t token;
;5471:	keywordHash_t *key;
;5472:
;5473:	if (!trap_PC_ReadToken(handle, &token))
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
NEI4 $2542
line 5474
;5474:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2541
JUMPV
LABELV $2542
line 5475
;5475:	if (*token.string != '{') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $2548
line 5476
;5476:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2541
JUMPV
LABELV $2547
line 5479
;5477:	}
;5478:
;5479:	while (1) {
line 5481
;5480:
;5481:		memset(&token, 0, sizeof(pc_token_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1040
ARGI4
ADDRGP4 memset
CALLP4
pop
line 5482
;5482:		if (!trap_PC_ReadToken(handle, &token)) {
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
NEI4 $2550
line 5483
;5483:			PC_SourceError(handle, "end of file inside menu\n");
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2552
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 5484
;5484:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2541
JUMPV
LABELV $2550
line 5487
;5485:		}
;5486:
;5487:		if (*token.string == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $2553
line 5488
;5488:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2541
JUMPV
LABELV $2553
line 5491
;5489:		}
;5490:
;5491:		key = KeywordHash_Find(menuParseKeywordHash, token.string);
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
line 5492
;5492:		if (!key) {
ADDRLP4 1040
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2557
line 5493
;5493:			PC_SourceError(handle, "unknown menu keyword %s", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2559
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 5494
;5494:			continue;
ADDRGP4 $2548
JUMPV
LABELV $2557
line 5496
;5495:		}
;5496:		if (!key->func((itemDef_t *)menu, handle)) {
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
NEI4 $2561
line 5497
;5497:			PC_SourceError(handle, "couldn't parse menu keyword %s", token.string);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $2563
ARGP4
ADDRLP4 0+16
ARGP4
ADDRGP4 PC_SourceError
CALLV
pop
line 5498
;5498:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2541
JUMPV
LABELV $2561
line 5500
;5499:		}
;5500:	}
LABELV $2548
line 5479
ADDRGP4 $2547
JUMPV
line 5501
;5501:	return qfalse; 	// bk001205 - LCC missing return value
CNSTI4 0
RETI4
LABELV $2541
endproc Menu_Parse 1060 12
export Menu_New
proc Menu_New 12 8
line 5509
;5502:}
;5503:
;5504:/*
;5505:===============
;5506:Menu_New
;5507:===============
;5508:*/
;5509:void Menu_New(int handle) {
line 5510
;5510:	menuDef_t *menu = &Menus[menuCount];
ADDRLP4 0
ADDRGP4 menuCount
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
ASGNP4
line 5512
;5511:
;5512:	if (menuCount < MAX_MENUS) {
ADDRGP4 menuCount
INDIRI4
CNSTI4 64
GEI4 $2566
line 5513
;5513:		Menu_Init(menu);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_Init
CALLV
pop
line 5514
;5514:		if (Menu_Parse(handle, menu)) {
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
EQI4 $2568
line 5515
;5515:			Menu_PostParse(menu);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Menu_PostParse
CALLV
pop
line 5516
;5516:			menuCount++;
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
line 5517
;5517:		}
LABELV $2568
line 5518
;5518:	}
LABELV $2566
line 5519
;5519:}
LABELV $2565
endproc Menu_New 12 8
export Menu_Count
proc Menu_Count 0 0
line 5521
;5520:
;5521:int Menu_Count() {
line 5522
;5522:	return menuCount;
ADDRGP4 menuCount
INDIRI4
RETI4
LABELV $2570
endproc Menu_Count 0 0
data
align 4
LABELV $2580
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
export Menu_PaintAll
code
proc Menu_PaintAll 28 32
line 5525
;5523:}
;5524:
;5525:void Menu_PaintAll() {
line 5527
;5526:	int i;
;5527:	if (captureFunc) {
ADDRGP4 captureFunc
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2572
line 5528
;5528:		captureFunc(captureData);
ADDRGP4 captureData
INDIRP4
ARGP4
ADDRGP4 captureFunc
INDIRP4
CALLV
pop
line 5529
;5529:	}
LABELV $2572
line 5531
;5530:
;5531:	for (i = 0; i < Menu_Count(); i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2577
JUMPV
LABELV $2574
line 5532
;5532:		Menu_Paint(&Menus[i], qfalse);
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_Paint
CALLV
pop
line 5533
;5533:	}
LABELV $2575
line 5531
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2577
ADDRLP4 4
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $2574
line 5535
;5534:
;5535:	if (debugMode) {
ADDRGP4 debugMode
INDIRI4
CNSTI4 0
EQI4 $2578
line 5536
;5536:		vec4_t v = { 1, 1, 1, 1 };
ADDRLP4 8
ADDRGP4 $2580
INDIRB
ASGNB 16
line 5537
;5537:		DC->drawText(5, 25, .5, v, va("fps: %f", DC->FPS), 0, 0, 0);
ADDRGP4 $2581
ARGP4
ADDRGP4 DC
INDIRP4
CNSTI4 73412
ADDP4
INDIRF4
ARGF4
ADDRLP4 24
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
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 0
ARGF4
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
line 5538
;5538:	}
LABELV $2578
line 5539
;5539:}
LABELV $2571
endproc Menu_PaintAll 28 32
export Menu_Reset
proc Menu_Reset 0 0
line 5541
;5540:
;5541:void Menu_Reset() {
line 5542
;5542:	menuCount = 0;
ADDRGP4 menuCount
CNSTI4 0
ASGNI4
line 5543
;5543:}
LABELV $2582
endproc Menu_Reset 0 0
export Display_GetContext
proc Display_GetContext 0 0
line 5545
;5544:
;5545:displayContextDef_t *Display_GetContext() {
line 5546
;5546:	return DC;
ADDRGP4 DC
INDIRP4
RETP4
LABELV $2583
endproc Display_GetContext 0 0
export Display_CaptureItem
proc Display_CaptureItem 8 12
line 5549
;5547:}
;5548:
;5549:void *Display_CaptureItem(int x, int y) {
line 5552
;5550:	int i;
;5551:
;5552:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2588
JUMPV
LABELV $2585
line 5555
;5553:		// turn off focus each item
;5554:		// menu->items[i].window.flags &= ~WINDOW_HASFOCUS;
;5555:		if (Rect_ContainsPoint(&Menus[i].window.rect, x, y)) {
ADDRLP4 0
INDIRI4
CNSTI4 644
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
ADDRLP4 4
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2589
line 5556
;5556:			return &Menus[i];
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
RETP4
ADDRGP4 $2584
JUMPV
LABELV $2589
line 5558
;5557:		}
;5558:	}
LABELV $2586
line 5552
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2588
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $2585
line 5559
;5559:	return NULL;
CNSTP4 0
RETP4
LABELV $2584
endproc Display_CaptureItem 8 12
export Display_MouseMove
proc Display_MouseMove 16 12
line 5564
;5560:}
;5561:
;5562:
;5563:// FIXME: 
;5564:qboolean Display_MouseMove(void *p, int x, int y) {
line 5566
;5565:	int i;
;5566:	menuDef_t *menu = p;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
line 5568
;5567:
;5568:	if (menu == NULL) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2592
line 5569
;5569:		menu = Menu_GetFocused();
ADDRLP4 8
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 5570
;5570:		if (menu) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2594
line 5571
;5571:			if (menu->window.flags & WINDOW_POPUP) {
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 2097152
BANDI4
CNSTI4 0
EQI4 $2596
line 5572
;5572:				Menu_HandleMouseMove(menu, x, y);
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
line 5573
;5573:				return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2591
JUMPV
LABELV $2596
line 5575
;5574:			}
;5575:		}
LABELV $2594
line 5576
;5576:		for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2601
JUMPV
LABELV $2598
line 5577
;5577:			Menu_HandleMouseMove(&Menus[i], x, y);
ADDRLP4 0
INDIRI4
CNSTI4 644
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
line 5578
;5578:		}
LABELV $2599
line 5576
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2601
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $2598
line 5579
;5579:	} else {
ADDRGP4 $2593
JUMPV
LABELV $2592
line 5580
;5580:		menu->window.rect.x += x;
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
line 5581
;5581:		menu->window.rect.y += y;
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
line 5582
;5582:		Menu_UpdatePosition(menu);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 Menu_UpdatePosition
CALLV
pop
line 5583
;5583:	}
LABELV $2593
line 5584
;5584:	return qtrue;
CNSTI4 1
RETI4
LABELV $2591
endproc Display_MouseMove 16 12
export Display_CursorType
proc Display_CursorType 28 12
line 5588
;5585:
;5586:}
;5587:
;5588:int Display_CursorType(int x, int y) {
line 5590
;5589:	int i;
;5590:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2606
JUMPV
LABELV $2603
line 5592
;5591:		rectDef_t r2;
;5592:		r2.x = Menus[i].window.rect.x - 3;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
INDIRF4
CNSTF4 1077936128
SUBF4
ASGNF4
line 5593
;5593:		r2.y = Menus[i].window.rect.y - 3;
ADDRLP4 4+4
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus+4
ADDP4
INDIRF4
CNSTF4 1077936128
SUBF4
ASGNF4
line 5594
;5594:		r2.w = r2.h = 7;
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
line 5595
;5595:		if (Rect_ContainsPoint(&r2, x, y)) {
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
ADDRLP4 24
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $2611
line 5596
;5596:			return CURSOR_SIZER;
CNSTI4 4
RETI4
ADDRGP4 $2602
JUMPV
LABELV $2611
line 5598
;5597:		}
;5598:	}
LABELV $2604
line 5590
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2606
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $2603
line 5599
;5599:	return CURSOR_ARROW;
CNSTI4 2
RETI4
LABELV $2602
endproc Display_CursorType 28 12
export Display_HandleKey
proc Display_HandleKey 12 12
line 5603
;5600:}
;5601:
;5602:
;5603:void Display_HandleKey(int key, qboolean down, int x, int y) {
line 5604
;5604:	menuDef_t *menu = Display_CaptureItem(x, y);
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
line 5605
;5605:	if (menu == NULL) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2614
line 5606
;5606:		menu = Menu_GetFocused();
ADDRLP4 8
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 5607
;5607:	}
LABELV $2614
line 5608
;5608:	if (menu) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2616
line 5609
;5609:		Menu_HandleKey(menu, key, down);
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
line 5610
;5610:	}
LABELV $2616
line 5611
;5611:}
LABELV $2613
endproc Display_HandleKey 12 12
proc Window_CacheContents 8 20
line 5613
;5612:
;5613:static void Window_CacheContents(windowDef_t *window) {
line 5614
;5614:	if (window) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2619
line 5615
;5615:		if (window->cinematicName) {
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2621
line 5616
;5616:			int cin = DC->playCinematic(window->cinematicName, 0, 0, 0, 0);
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
ADDRLP4 4
ADDRGP4 DC
INDIRP4
CNSTI4 180
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 5617
;5617:			DC->stopCinematic(cin);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 184
ADDP4
INDIRP4
CALLV
pop
line 5618
;5618:		}
LABELV $2621
line 5619
;5619:	}
LABELV $2619
line 5620
;5620:}
LABELV $2618
endproc Window_CacheContents 8 20
proc Item_CacheContents 0 4
line 5623
;5621:
;5622:
;5623:static void Item_CacheContents(itemDef_t *item) {
line 5624
;5624:	if (item) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2624
line 5625
;5625:		Window_CacheContents(&item->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_CacheContents
CALLV
pop
line 5626
;5626:	}
LABELV $2624
line 5628
;5627:
;5628:}
LABELV $2623
endproc Item_CacheContents 0 4
proc Menu_CacheContents 8 8
line 5630
;5629:
;5630:static void Menu_CacheContents(menuDef_t *menu) {
line 5631
;5631:	if (menu) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2627
line 5633
;5632:		int i;
;5633:		Window_CacheContents(&menu->window);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Window_CacheContents
CALLV
pop
line 5634
;5634:		for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2632
JUMPV
LABELV $2629
line 5635
;5635:			Item_CacheContents(menu->items[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Item_CacheContents
CALLV
pop
line 5636
;5636:		}
LABELV $2630
line 5634
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2632
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $2629
line 5638
;5637:
;5638:		if (menu->soundName && *menu->soundName) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2633
ADDRLP4 4
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $2633
line 5639
;5639:			DC->registerSound(menu->soundName, qfalse);
ADDRFP4 0
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 DC
INDIRP4
CNSTI4 168
ADDP4
INDIRP4
CALLI4
pop
line 5640
;5640:		}
LABELV $2633
line 5641
;5641:	}
LABELV $2627
line 5643
;5642:
;5643:}
LABELV $2626
endproc Menu_CacheContents 8 8
export Display_CacheAll
proc Display_CacheAll 4 4
line 5645
;5644:
;5645:void Display_CacheAll() {
line 5647
;5646:	int i;
;5647:	for (i = 0; i < menuCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2639
JUMPV
LABELV $2636
line 5648
;5648:		Menu_CacheContents(&Menus[i]);
ADDRLP4 0
INDIRI4
CNSTI4 644
MULI4
ADDRGP4 Menus
ADDP4
ARGP4
ADDRGP4 Menu_CacheContents
CALLV
pop
line 5649
;5649:	}
LABELV $2637
line 5647
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2639
ADDRLP4 0
INDIRI4
ADDRGP4 menuCount
INDIRI4
LTI4 $2636
line 5650
;5650:}
LABELV $2635
endproc Display_CacheAll 4 4
proc Menu_OverActiveItem 32 12
line 5653
;5651:
;5652:
;5653:static qboolean Menu_OverActiveItem(menuDef_t *menu, float x, float y) {
line 5654
;5654:	if (menu && menu->window.flags & (WINDOW_VISIBLE | WINDOW_FORCED)) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2641
ADDRLP4 0
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
EQI4 $2641
line 5655
;5655:		if (Rect_ContainsPoint(&menu->window.rect, x, y)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2643
line 5657
;5656:			int i;
;5657:			for (i = 0; i < menu->itemCount; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $2648
JUMPV
LABELV $2645
line 5661
;5658:				// turn off focus each item
;5659:				// menu->items[i].window.flags &= ~WINDOW_HASFOCUS;
;5660:
;5661:				if (!(menu->items[i]->window.flags & (WINDOW_VISIBLE | WINDOW_FORCED))) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1048580
BANDI4
CNSTI4 0
NEI4 $2649
line 5662
;5662:					continue;
ADDRGP4 $2646
JUMPV
LABELV $2649
line 5665
;5663:				}
;5664:
;5665:				if (menu->items[i]->window.flags & WINDOW_DECORATION) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $2651
line 5666
;5666:					continue;
ADDRGP4 $2646
JUMPV
LABELV $2651
line 5669
;5667:				}
;5668:
;5669:				if (Rect_ContainsPoint(&menu->items[i]->window.rect, x, y)) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
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
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2653
line 5670
;5670:					itemDef_t *overItem = menu->items[i];
ADDRLP4 16
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 260
ADDP4
ADDP4
INDIRP4
ASGNP4
line 5671
;5671:					if (overItem->type == ITEM_TYPE_TEXT && overItem->text) {
ADDRLP4 16
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2655
ADDRLP4 16
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2655
line 5672
;5672:						if (Rect_ContainsPoint(Item_CorrectedTextRect(overItem), x, y)) {
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 Item_CorrectedTextRect
CALLP4
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
ADDRGP4 Rect_ContainsPoint
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2646
line 5673
;5673:							return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2640
JUMPV
line 5674
;5674:						} else {
line 5675
;5675:							continue;
LABELV $2655
line 5677
;5676:						}
;5677:					} else {
line 5678
;5678:						return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2640
JUMPV
LABELV $2653
line 5681
;5679:					}
;5680:				}
;5681:			}
LABELV $2646
line 5657
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2648
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
LTI4 $2645
line 5683
;5682:
;5683:		}
LABELV $2643
line 5684
;5684:	}
LABELV $2641
line 5685
;5685:	return qfalse;
CNSTI4 0
RETI4
LABELV $2640
endproc Menu_OverActiveItem 32 12
bss
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
skip 393216
align 4
LABELV outOfMemory
skip 4
align 4
LABELV allocPoint
skip 4
align 1
LABELV memoryPool
skip 1048576
export menuStack
align 4
LABELV menuStack
skip 64
export Menus
align 4
LABELV Menus
skip 41216
align 4
LABELV scrollInfo
skip 32
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
LABELV $2581
byte 1 102
byte 1 112
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 102
byte 1 0
align 1
LABELV $2563
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
LABELV $2559
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
LABELV $2552
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
byte 1 10
byte 1 0
align 1
LABELV $2535
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
LABELV $2534
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
LABELV $2533
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
LABELV $2532
byte 1 112
byte 1 111
byte 1 112
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $2531
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 68
byte 1 101
byte 1 102
byte 1 0
align 1
LABELV $2530
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
LABELV $2529
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
LABELV $2528
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
LABELV $2527
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
LABELV $2526
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
LABELV $2525
byte 1 111
byte 1 110
byte 1 69
byte 1 83
byte 1 67
byte 1 0
align 1
LABELV $2524
byte 1 111
byte 1 110
byte 1 67
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $2523
byte 1 111
byte 1 110
byte 1 79
byte 1 112
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $2522
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
LABELV $2521
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $2422
byte 1 109
byte 1 97
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $2403
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
LABELV $2399
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
LABELV $2376
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
LABELV $2375
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
LABELV $2374
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
LABELV $2373
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
LABELV $2372
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
LABELV $2371
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
LABELV $2370
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
LABELV $2369
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
LABELV $2368
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
LABELV $2367
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
LABELV $2366
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
LABELV $2365
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
LABELV $2364
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
LABELV $2363
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
LABELV $2362
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
LABELV $2361
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $2360
byte 1 115
byte 1 112
byte 1 101
byte 1 99
byte 1 105
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $2359
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $2358
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
LABELV $2357
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
LABELV $2356
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
LABELV $2355
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
LABELV $2354
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
LABELV $2353
byte 1 111
byte 1 110
byte 1 70
byte 1 111
byte 1 99
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $2352
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
LABELV $2351
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
LABELV $2350
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
LABELV $2349
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
LABELV $2348
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
LABELV $2347
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
LABELV $2346
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
LABELV $2345
byte 1 97
byte 1 108
byte 1 105
byte 1 103
byte 1 110
byte 1 0
align 1
LABELV $2344
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
LABELV $2343
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2342
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
LABELV $2341
byte 1 98
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2340
byte 1 99
byte 1 111
byte 1 108
byte 1 117
byte 1 109
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $2339
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
LABELV $2338
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $2337
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
LABELV $2336
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
LABELV $2335
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $2334
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
LABELV $2333
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
LABELV $2332
byte 1 119
byte 1 114
byte 1 97
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $2331
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
LABELV $2330
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
LABELV $2329
byte 1 115
byte 1 116
byte 1 121
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $2328
byte 1 114
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $2327
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
LABELV $2326
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
LABELV $2325
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
LABELV $2324
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
LABELV $2323
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
LABELV $2322
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
LABELV $2321
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
LABELV $2320
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $2319
byte 1 116
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $2318
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $2255
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
byte 1 10
byte 1 0
align 1
LABELV $1609
byte 1 70
byte 1 73
byte 1 88
byte 1 77
byte 1 69
byte 1 0
align 1
LABELV $1579
byte 1 63
byte 1 63
byte 1 63
byte 1 0
align 1
LABELV $1578
byte 1 32
byte 1 111
byte 1 114
byte 1 32
byte 1 0
align 1
LABELV $1548
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
LABELV $1515
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
LABELV $1514
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
LABELV $1513
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
LABELV $1512
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
LABELV $1511
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
LABELV $1510
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
LABELV $1509
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
LABELV $1508
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
LABELV $1507
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
LABELV $1506
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
LABELV $1505
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
LABELV $1504
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
LABELV $1503
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
LABELV $1502
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
LABELV $1501
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
LABELV $1500
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
LABELV $1499
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
LABELV $1498
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
LABELV $1497
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
LABELV $1496
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
LABELV $1495
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
LABELV $1494
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
LABELV $1493
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
LABELV $1492
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
LABELV $1491
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
LABELV $1490
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
LABELV $1489
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
LABELV $1488
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
LABELV $1487
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
LABELV $1486
byte 1 43
byte 1 97
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $1485
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
LABELV $1484
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
LABELV $1483
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
LABELV $1482
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
LABELV $1481
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
LABELV $1480
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
LABELV $1479
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
LABELV $1478
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
LABELV $1477
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
LABELV $1476
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
LABELV $1475
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
LABELV $1474
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
LABELV $1473
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
LABELV $1472
byte 1 43
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $1471
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
LABELV $1470
byte 1 43
byte 1 109
byte 1 108
byte 1 111
byte 1 111
byte 1 107
byte 1 0
align 1
LABELV $1469
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
LABELV $1468
byte 1 43
byte 1 108
byte 1 111
byte 1 111
byte 1 107
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $1467
byte 1 43
byte 1 115
byte 1 116
byte 1 114
byte 1 97
byte 1 102
byte 1 101
byte 1 0
align 1
LABELV $1466
byte 1 43
byte 1 114
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $1465
byte 1 43
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 0
align 1
LABELV $1464
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
LABELV $1463
byte 1 43
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $1462
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
LABELV $1461
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
LABELV $1460
byte 1 43
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $1459
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
LABELV $1458
byte 1 43
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $1457
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
LABELV $1456
byte 1 43
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $1439
byte 1 78
byte 1 111
byte 1 0
align 1
LABELV $1438
byte 1 89
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $1282
byte 1 115
byte 1 99
byte 1 114
byte 1 101
byte 1 101
byte 1 110
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $1278
byte 1 100
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 111
byte 1 112
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $1131
byte 1 115
byte 1 108
byte 1 105
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 104
byte 1 97
byte 1 110
byte 1 100
byte 1 108
byte 1 101
byte 1 32
byte 1 107
byte 1 101
byte 1 121
byte 1 32
byte 1 101
byte 1 120
byte 1 105
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $955
byte 1 37
byte 1 102
byte 1 0
align 1
LABELV $901
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $563
byte 1 111
byte 1 114
byte 1 98
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $562
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
LABELV $561
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $560
byte 1 101
byte 1 120
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $559
byte 1 115
byte 1 101
byte 1 116
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $558
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
LABELV $557
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
LABELV $556
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
LABELV $555
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
LABELV $554
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
LABELV $553
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
LABELV $552
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
LABELV $551
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
LABELV $550
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $549
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
LABELV $548
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $547
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
LABELV $546
byte 1 104
byte 1 105
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $545
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $544
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 111
byte 1 117
byte 1 116
byte 1 0
align 1
LABELV $543
byte 1 102
byte 1 97
byte 1 100
byte 1 101
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $536
byte 1 37
byte 1 115
byte 1 32
byte 1 59
byte 1 32
byte 1 0
align 1
LABELV $529
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
LABELV $525
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
LABELV $364
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
LABELV $361
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
LABELV $358
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
LABELV $200
byte 1 32
byte 1 0
align 1
LABELV $197
byte 1 34
byte 1 37
byte 1 115
byte 1 34
byte 1 0
align 1
LABELV $192
byte 1 125
byte 1 0
align 1
LABELV $183
byte 1 123
byte 1 0
align 1
LABELV $147
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
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
byte 1 98
byte 1 117
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $114
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 102
byte 1 108
byte 1 111
byte 1 97
byte 1 116
byte 1 32
byte 1 98
byte 1 117
byte 1 116
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $91
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
LABELV $87
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
LABELV $76
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
LABELV $75
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
LABELV $74
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
LABELV $73
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
LABELV $54
byte 1 0
align 1
LABELV $45
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
byte 1 10
byte 1 0

export G_SpawnString
code
proc G_SpawnString 8 8
file "..\..\..\..\code\game\g_spawn.c"
line 6
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:#include "g_local.h"
;5:
;6:qboolean	G_SpawnString(const char *key, const char *defaultString, char **out) {
line 9
;7:	int		i;
;8:
;9:	if (!level.spawning) {
ADDRGP4 level+896
INDIRI4
CNSTI4 0
NEI4 $56
line 10
;10:		*out = (char *)defaultString;
ADDRFP4 8
INDIRP4
ADDRFP4 4
INDIRP4
ASGNP4
line 12
;11:		//		G_Error( "G_SpawnString() called while not spawning" );
;12:	}
LABELV $56
line 14
;13:
;14:	for (i = 0; i < level.numSpawnVars; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $62
JUMPV
LABELV $59
line 15
;15:		if (!Q_stricmp(key, level.spawnVars[i][0])) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 level+904
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
NEI4 $64
line 16
;16:			*out = level.spawnVars[i][1];
ADDRFP4 8
INDIRP4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 level+904+4
ADDP4
INDIRP4
ASGNP4
line 17
;17:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $55
JUMPV
LABELV $64
line 19
;18:		}
;19:	}
LABELV $60
line 14
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $62
ADDRLP4 0
INDIRI4
ADDRGP4 level+900
INDIRI4
LTI4 $59
line 21
;20:
;21:	*out = (char *)defaultString;
ADDRFP4 8
INDIRP4
ADDRFP4 4
INDIRP4
ASGNP4
line 22
;22:	return qfalse;
CNSTI4 0
RETI4
LABELV $55
endproc G_SpawnString 8 8
export G_SpawnFloat
proc G_SpawnFloat 16 12
line 25
;23:}
;24:
;25:qboolean	G_SpawnFloat(const char *key, const char *defaultString, float *out) {
line 29
;26:	char *s;
;27:	qboolean	present;
;28:
;29:	present = G_SpawnString(key, defaultString, &s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 G_SpawnString
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 30
;30:	*out = atof(s);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atof
CALLF4
ASGNF4
ADDRFP4 8
INDIRP4
ADDRLP4 12
INDIRF4
ASGNF4
line 31
;31:	return present;
ADDRLP4 4
INDIRI4
RETI4
LABELV $69
endproc G_SpawnFloat 16 12
export G_SpawnInt
proc G_SpawnInt 16 12
line 34
;32:}
;33:
;34:qboolean	G_SpawnInt(const char *key, const char *defaultString, int *out) {
line 38
;35:	char *s;
;36:	qboolean	present;
;37:
;38:	present = G_SpawnString(key, defaultString, &s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 G_SpawnString
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 39
;39:	*out = atoi(s);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 12
INDIRI4
ASGNI4
line 40
;40:	return present;
ADDRLP4 4
INDIRI4
RETI4
LABELV $70
endproc G_SpawnInt 16 12
export G_SpawnVector
proc G_SpawnVector 16 20
line 43
;41:}
;42:
;43:qboolean	G_SpawnVector(const char *key, const char *defaultString, float *out) {
line 47
;44:	char *s;
;45:	qboolean	present;
;46:
;47:	present = G_SpawnString(key, defaultString, &s);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 8
ADDRGP4 G_SpawnString
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 48
;48:	Q_sscanf(s, "%f %f %f", &out[0], &out[1], &out[2]);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $72
ARGP4
ADDRLP4 12
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
ARGP4
ADDRGP4 Q_sscanf
CALLI4
pop
line 49
;49:	return present;
ADDRLP4 4
INDIRI4
RETI4
LABELV $71
endproc G_SpawnVector 16 20
data
export fields
align 4
LABELV fields
address $75
byte 4 524
byte 4 2
address $76
byte 4 92
byte 4 4
address $77
byte 4 540
byte 4 2
address $78
byte 4 544
byte 4 2
address $79
byte 4 528
byte 4 0
address $80
byte 4 672
byte 4 1
address $81
byte 4 648
byte 4 2
address $82
byte 4 652
byte 4 2
address $83
byte 4 636
byte 4 2
address $84
byte 4 656
byte 4 2
address $85
byte 4 804
byte 4 1
address $86
byte 4 808
byte 4 1
address $87
byte 4 760
byte 4 0
address $88
byte 4 732
byte 4 0
address $89
byte 4 0
byte 4 9
address $90
byte 4 740
byte 4 0
address $91
byte 4 116
byte 4 4
address $92
byte 4 116
byte 4 5
address $93
byte 4 660
byte 4 2
address $94
byte 4 664
byte 4 2
address $95
byte 4 812
byte 4 2
address $96
byte 4 816
byte 4 2
byte 4 0
skip 8
code
proc SP_info_firstplace 0 0
line 114
;50:}
;51:
;52:
;53:
;54://
;55:// fields are needed for spawning from the entity string
;56://
;57:typedef enum {
;58:	F_INT,
;59:	F_FLOAT,
;60:	F_LSTRING,			// string on disk, pointer in memory, TAG_LEVEL
;61:	F_GSTRING,			// string on disk, pointer in memory, TAG_GAME
;62:	F_VECTOR,
;63:	F_ANGLEHACK,
;64:	F_ENTITY,			// index on disk, pointer in memory
;65:	F_ITEM,				// index on disk, pointer in memory
;66:	F_CLIENT,			// index on disk, pointer in memory
;67:	F_IGNORE
;68:} fieldtype_t;
;69:
;70:typedef struct {
;71:	const char *name;
;72:	int		ofs;
;73:	fieldtype_t	type;
;74:	//int		flags;
;75:} field_t;
;76:
;77:const field_t fields[] = {
;78:	{"classname", FOFS(classname), F_LSTRING},
;79:	{"origin", FOFS(s.origin), F_VECTOR},
;80:	{"model", FOFS(model), F_LSTRING},
;81:	{"model2", FOFS(model2), F_LSTRING},
;82:	{"spawnflags", FOFS(spawnflags), F_INT},
;83:	{"speed", FOFS(speed), F_FLOAT},
;84:	{"target", FOFS(target), F_LSTRING},
;85:	{"targetname", FOFS(targetname), F_LSTRING},
;86:	{"message", FOFS(message), F_LSTRING},
;87:	{"team", FOFS(team), F_LSTRING},
;88:	{"wait", FOFS(wait), F_FLOAT},
;89:	{"random", FOFS(random), F_FLOAT},
;90:	{"count", FOFS(count), F_INT},
;91:	{"health", FOFS(health), F_INT},
;92:	{"light", 0, F_IGNORE},
;93:	{"dmg", FOFS(damage), F_INT},
;94:	{"angles", FOFS(s.angles), F_VECTOR},
;95:	{"angle", FOFS(s.angles), F_ANGLEHACK},
;96:	{"targetShaderName", FOFS(targetShaderName), F_LSTRING},
;97:	{"targetShaderNewName", FOFS(targetShaderNewName), F_LSTRING},
;98:
;99:	{ "cvar", FOFS(cvar), F_LSTRING },
;100:	{ "cvarValue", FOFS(cvarValue), F_LSTRING },
;101:
;102:	{NULL}
;103:};
;104:
;105:
;106:typedef struct {
;107:	char *name;
;108:	void	(*spawn)(gentity_t *ent);
;109:} spawn_t;
;110:
;111:void SP_info_player_start(gentity_t *ent);
;112:void SP_info_player_deathmatch(gentity_t *ent);
;113:void SP_info_player_intermission(gentity_t *ent);
;114:static void SP_info_firstplace(gentity_t *ent) {};
LABELV $98
endproc SP_info_firstplace 0 0
proc SP_info_secondplace 0 0
line 115
;115:static void SP_info_secondplace(gentity_t *ent) {};
LABELV $99
endproc SP_info_secondplace 0 0
proc SP_info_thirdplace 0 0
line 116
;116:static void SP_info_thirdplace(gentity_t *ent) {};
LABELV $100
endproc SP_info_thirdplace 0 0
proc SP_info_podium 0 0
line 117
;117:static void SP_info_podium(gentity_t *ent) {};
LABELV $101
endproc SP_info_podium 0 0
proc SP_item_botroam 0 0
line 175
;118:
;119:void SP_func_plat(gentity_t *ent);
;120:void SP_func_static(gentity_t *ent);
;121:void SP_func_rotating(gentity_t *ent);
;122:void SP_func_bobbing(gentity_t *ent);
;123:void SP_func_pendulum(gentity_t *ent);
;124:void SP_func_button(gentity_t *ent);
;125:void SP_func_door(gentity_t *ent);
;126:void SP_func_train(gentity_t *ent);
;127:void SP_func_timer(gentity_t *self);
;128:
;129:void SP_trigger_always(gentity_t *ent);
;130:void SP_trigger_multiple(gentity_t *ent);
;131:void SP_trigger_push(gentity_t *ent);
;132:void SP_trigger_teleport(gentity_t *ent);
;133:void SP_trigger_hurt(gentity_t *ent);
;134:
;135:void SP_target_remove_powerups(gentity_t *ent);
;136:void SP_target_give(gentity_t *ent);
;137:void SP_target_delay(gentity_t *ent);
;138:void SP_target_speaker(gentity_t *ent);
;139:void SP_target_print(gentity_t *ent);
;140:void SP_target_laser(gentity_t *self);
;141:void SP_target_score(gentity_t *ent);
;142:void SP_target_teleporter(gentity_t *ent);
;143:void SP_target_relay(gentity_t *ent);
;144:void SP_target_kill(gentity_t *ent);
;145:void SP_target_position(gentity_t *ent);
;146:void SP_target_location(gentity_t *ent);
;147:void SP_target_push(gentity_t *ent);
;148:void SP_target_cvar(gentity_t *ent);
;149:
;150:void SP_light(gentity_t *self);
;151:void SP_info_null(gentity_t *self);
;152:void SP_info_notnull(gentity_t *self);
;153:void SP_info_camp(gentity_t *self);
;154:void SP_path_corner(gentity_t *self);
;155:
;156:void SP_misc_teleporter_dest(gentity_t *self);
;157:void SP_misc_model(gentity_t *ent);
;158:void SP_misc_portal_camera(gentity_t *ent);
;159:void SP_misc_portal_surface(gentity_t *ent);
;160:
;161:void SP_shooter_rocket(gentity_t *ent);
;162:void SP_shooter_plasma(gentity_t *ent);
;163:void SP_shooter_grenade(gentity_t *ent);
;164:
;165:void SP_team_CTF_redplayer(gentity_t *ent);
;166:void SP_team_CTF_blueplayer(gentity_t *ent);
;167:
;168:void SP_team_CTF_redspawn(gentity_t *ent);
;169:void SP_team_CTF_bluespawn(gentity_t *ent);
;170:
;171:void SP_team_blueobelisk(gentity_t *ent);
;172:void SP_team_redobelisk(gentity_t *ent);
;173:void SP_team_neutralobelisk(gentity_t *ent);
;174:
;175:static void SP_item_botroam(gentity_t *ent) {};
LABELV $102
endproc SP_item_botroam 0 0
data
export spawns
align 4
LABELV spawns
address $103
address SP_info_player_start
address $104
address SP_info_player_deathmatch
address $105
address SP_info_player_intermission
address $106
address SP_info_null
address $107
address SP_info_notnull
address $108
address SP_info_camp
address $109
address SP_info_firstplace
address $110
address SP_info_secondplace
address $111
address SP_info_thirdplace
address $112
address SP_info_podium
address $113
address SP_func_plat
address $114
address SP_func_button
address $115
address SP_func_door
address $116
address SP_func_static
address $117
address SP_func_rotating
address $118
address SP_func_bobbing
address $119
address SP_func_pendulum
address $120
address SP_func_train
address $121
address SP_info_null
address $122
address SP_func_timer
address $123
address SP_trigger_always
address $124
address SP_trigger_multiple
address $125
address SP_trigger_push
address $126
address SP_trigger_teleport
address $127
address SP_trigger_hurt
address $128
address SP_target_give
address $129
address SP_target_remove_powerups
address $130
address SP_target_delay
address $131
address SP_target_speaker
address $132
address SP_target_print
address $133
address SP_target_laser
address $134
address SP_target_score
address $135
address SP_target_teleporter
address $136
address SP_target_relay
address $137
address SP_target_kill
address $138
address SP_target_position
address $139
address SP_target_location
address $140
address SP_target_push
address $141
address SP_target_cvar
address $89
address SP_light
address $142
address SP_path_corner
address $143
address SP_misc_teleporter_dest
address $144
address SP_misc_model
address $145
address SP_misc_portal_surface
address $146
address SP_misc_portal_camera
address $147
address SP_shooter_rocket
address $148
address SP_shooter_grenade
address $149
address SP_shooter_plasma
address $150
address SP_team_CTF_redplayer
address $151
address SP_team_CTF_blueplayer
address $152
address SP_team_CTF_redspawn
address $153
address SP_team_CTF_bluespawn
address $154
address SP_team_redobelisk
address $155
address SP_team_blueobelisk
address $156
address SP_team_neutralobelisk
address $157
address SP_item_botroam
byte 4 0
byte 4 0
export G_CallSpawn
code
proc G_CallSpawn 12 8
line 265
;176:
;177:spawn_t	spawns[] = {
;178:	// info entities don't do anything at all, but provide positional
;179:	// information for things controlled by other processes
;180:	{"info_player_start", SP_info_player_start},
;181:	{"info_player_deathmatch", SP_info_player_deathmatch},
;182:	{"info_player_intermission", SP_info_player_intermission},
;183:	{"info_null", SP_info_null},
;184:	{"info_notnull", SP_info_notnull},		// use target_position instead
;185:	{"info_camp", SP_info_camp},
;186:	{"info_firstplace", SP_info_firstplace},
;187:	{"info_secondplace", SP_info_secondplace},
;188:	{"info_thirdplace", SP_info_thirdplace},
;189:	{"info_podium", SP_info_podium},
;190:
;191:	{"func_plat", SP_func_plat},
;192:	{"func_button", SP_func_button},
;193:	{"func_door", SP_func_door},
;194:	{"func_static", SP_func_static},
;195:	{"func_rotating", SP_func_rotating},
;196:	{"func_bobbing", SP_func_bobbing},
;197:	{"func_pendulum", SP_func_pendulum},
;198:	{"func_train", SP_func_train},
;199:	{"func_group", SP_info_null},
;200:	{"func_timer", SP_func_timer},			// rename trigger_timer?
;201:
;202:	// Triggers are brush objects that cause an effect when contacted
;203:	// by a living player, usually involving firing targets.
;204:	// While almost everything could be done with
;205:	// a single trigger class and different targets, triggered effects
;206:	// could not be client side predicted (push and teleport).
;207:	{"trigger_always", SP_trigger_always},
;208:	{"trigger_multiple", SP_trigger_multiple},
;209:	{"trigger_push", SP_trigger_push},
;210:	{"trigger_teleport", SP_trigger_teleport},
;211:	{"trigger_hurt", SP_trigger_hurt},
;212:
;213:	// targets perform no action by themselves, but must be triggered
;214:	// by another entity
;215:	{"target_give", SP_target_give},
;216:	{"target_remove_powerups", SP_target_remove_powerups},
;217:	{"target_delay", SP_target_delay},
;218:	{"target_speaker", SP_target_speaker},
;219:	{"target_print", SP_target_print},
;220:	{"target_laser", SP_target_laser},
;221:	{"target_score", SP_target_score},
;222:	{"target_teleporter", SP_target_teleporter},
;223:	{"target_relay", SP_target_relay},
;224:	{"target_kill", SP_target_kill},
;225:	{"target_position", SP_target_position},
;226:	{"target_location", SP_target_location},
;227:	{"target_push", SP_target_push},
;228:	{"target_cvar", SP_target_cvar},
;229:
;230:	{"light", SP_light},
;231:	{"path_corner", SP_path_corner},
;232:
;233:	{"misc_teleporter_dest", SP_misc_teleporter_dest},
;234:	{"misc_model", SP_misc_model},
;235:	{"misc_portal_surface", SP_misc_portal_surface},
;236:	{"misc_portal_camera", SP_misc_portal_camera},
;237:
;238:	{"shooter_rocket", SP_shooter_rocket},
;239:	{"shooter_grenade", SP_shooter_grenade},
;240:	{"shooter_plasma", SP_shooter_plasma},
;241:
;242:	{"team_CTF_redplayer", SP_team_CTF_redplayer},
;243:	{"team_CTF_blueplayer", SP_team_CTF_blueplayer},
;244:
;245:	{"team_CTF_redspawn", SP_team_CTF_redspawn},
;246:	{"team_CTF_bluespawn", SP_team_CTF_bluespawn},
;247:
;248:	{"team_redobelisk", SP_team_redobelisk},
;249:	{"team_blueobelisk", SP_team_blueobelisk},
;250:	{"team_neutralobelisk", SP_team_neutralobelisk},
;251:
;252:	{"item_botroam", SP_item_botroam},
;253:
;254:	{0, 0}
;255:};
;256:
;257:/*
;258:===============
;259:G_CallSpawn
;260:
;261:Finds the spawn function for the entity and calls it,
;262:returning qfalse if not found
;263:===============
;264:*/
;265:qboolean G_CallSpawn(gentity_t *ent) {
line 269
;266:	spawn_t *s;
;267:	gitem_t *item;
;268:
;269:	if (!ent->classname) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $159
line 270
;270:		G_Printf("G_CallSpawn: NULL classname\n");
ADDRGP4 $161
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 271
;271:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $158
JUMPV
LABELV $159
line 275
;272:	}
;273:
;274:	// check item spawn functions
;275:	for (item = bg_itemlist + 1; item->classname; item++) {
ADDRLP4 4
ADDRGP4 bg_itemlist+52
ASGNP4
ADDRGP4 $165
JUMPV
LABELV $162
line 276
;276:		if (!strcmp(item->classname, ent->classname)) {
ADDRLP4 4
INDIRP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $167
line 277
;277:			G_SpawnItem(ent, item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_SpawnItem
CALLV
pop
line 278
;278:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $158
JUMPV
LABELV $167
line 280
;279:		}
;280:	}
LABELV $163
line 275
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
ASGNP4
LABELV $165
ADDRLP4 4
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $162
line 283
;281:
;282:	// check normal spawn functions
;283:	for (s = spawns; s->name; s++) {
ADDRLP4 0
ADDRGP4 spawns
ASGNP4
ADDRGP4 $172
JUMPV
LABELV $169
line 284
;284:		if (!strcmp(s->name, ent->classname)) {
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $173
line 286
;285:			// found it
;286:			s->spawn(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CALLV
pop
line 287
;287:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $158
JUMPV
LABELV $173
line 289
;288:		}
;289:	}
LABELV $170
line 283
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
LABELV $172
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $169
line 290
;290:	G_Printf("%s doesn't have a spawn function\n", ent->classname);
ADDRGP4 $175
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 291
;291:	return qfalse;
CNSTI4 0
RETI4
LABELV $158
endproc G_CallSpawn 12 8
export G_NewString
proc G_NewString 32 4
line 302
;292:}
;293:
;294:/*
;295:=============
;296:G_NewString
;297:
;298:Builds a copy of the string, translating \n to real linefeeds
;299:so message texts can be multi-line
;300:=============
;301:*/
;302:char *G_NewString(const char *string) {
line 306
;303:	char *newb, *new_p;
;304:	int		i, l;
;305:
;306:	l = (int)strlen(string) + 1;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 308
;307:
;308:	newb = G_Alloc(l);
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 G_Alloc
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 20
INDIRP4
ASGNP4
line 310
;309:
;310:	new_p = newb;
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 313
;311:
;312:	// turn \n into a real linefeed
;313:	for (i = 0; i < l; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $180
JUMPV
LABELV $177
line 314
;314:		if (string[i] == '\\' && i < l - 1) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $181
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
GEI4 $181
line 315
;315:			i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 316
;316:			if (string[i] == 'n') {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 110
NEI4 $183
line 317
;317:				*new_p++ = '\n';
ADDRLP4 28
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI1 10
ASGNI1
line 318
;318:			} else {
ADDRGP4 $182
JUMPV
LABELV $183
line 319
;319:				*new_p++ = '\\';
ADDRLP4 28
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI1 92
ASGNI1
line 320
;320:			}
line 321
;321:		} else {
ADDRGP4 $182
JUMPV
LABELV $181
line 322
;322:			*new_p++ = string[i];
ADDRLP4 28
ADDRLP4 8
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 323
;323:		}
LABELV $182
line 324
;324:	}
LABELV $178
line 313
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $180
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $177
line 326
;325:
;326:	return newb;
ADDRLP4 12
INDIRP4
RETP4
LABELV $176
endproc G_NewString 32 4
export G_ParseField
proc G_ParseField 52 20
line 340
;327:}
;328:
;329:
;330:
;331:
;332:/*
;333:===============
;334:G_ParseField
;335:
;336:Takes a key/value pair and sets the binary values
;337:in a gentity
;338:===============
;339:*/
;340:void G_ParseField(const char *key, const char *value, gentity_t *ent) {
line 346
;341:	const field_t *f;
;342:	byte *b;
;343:	float	v;
;344:	vec3_t	vec;
;345:
;346:	for (f = fields; f->name; f++) {
ADDRLP4 0
ADDRGP4 fields
ASGNP4
ADDRGP4 $189
JUMPV
LABELV $186
line 347
;347:		if (!Q_stricmp(f->name, key)) {
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $190
line 349
;348:			// found it
;349:			b = (byte *)ent;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
line 351
;350:
;351:			switch (f->type) {
ADDRLP4 28
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
LTI4 $185
ADDRLP4 28
INDIRI4
CNSTI4 9
GTI4 $185
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $205
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $205
address $201
address $202
address $195
address $185
address $196
address $203
address $185
address $185
address $185
address $185
code
LABELV $195
line 353
;352:			case F_LSTRING:
;353:				*(char **)(b + f->ofs) = G_NewString(value);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 G_NewString
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 36
INDIRP4
ASGNP4
line 354
;354:				break;
ADDRGP4 $185
JUMPV
LABELV $196
line 356
;355:			case F_VECTOR:
;356:				Q_sscanf(value, "%f %f %f", &vec[0], &vec[1], &vec[2]);
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 $72
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 8+4
ARGP4
ADDRLP4 8+8
ARGP4
ADDRGP4 Q_sscanf
CALLI4
pop
line 357
;357:				((float *)(b + f->ofs))[0] = vec[0];
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
line 358
;358:				((float *)(b + f->ofs))[1] = vec[1];
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 8+4
INDIRF4
ASGNF4
line 359
;359:				((float *)(b + f->ofs))[2] = vec[2];
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 8+8
INDIRF4
ASGNF4
line 360
;360:				break;
ADDRGP4 $185
JUMPV
LABELV $201
line 362
;361:			case F_INT:
;362:				*(int *)(b + f->ofs) = atoi(value);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 363
;363:				break;
ADDRGP4 $185
JUMPV
LABELV $202
line 365
;364:			case F_FLOAT:
;365:				*(float *)(b + f->ofs) = atof(value);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ADDRLP4 44
INDIRF4
ASGNF4
line 366
;366:				break;
ADDRGP4 $185
JUMPV
LABELV $203
line 368
;367:			case F_ANGLEHACK:
;368:				v = atof(value);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 atof
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 48
INDIRF4
ASGNF4
line 369
;369:				((float *)(b + f->ofs))[0] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTF4 0
ASGNF4
line 370
;370:				((float *)(b + f->ofs))[1] = v;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 4
ADDP4
ADDRLP4 20
INDIRF4
ASGNF4
line 371
;371:				((float *)(b + f->ofs))[2] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
line 372
;372:				break;
line 375
;373:			default:
;374:			case F_IGNORE:
;375:				break;
line 377
;376:			}
;377:			return;
ADDRGP4 $185
JUMPV
LABELV $190
line 379
;378:		}
;379:	}
LABELV $187
line 346
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
LABELV $189
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $186
line 380
;380:}
LABELV $185
endproc G_ParseField 52 20
data
align 4
LABELV $207
address $208
address $209
address $210
address $211
address $212
address $213
address $214
address $215
address $216
address $217
address $218
address $219
address $220
export G_SpawnGEntityFromSpawnVars
code
proc G_SpawnGEntityFromSpawnVars 44 12
line 393
;381:
;382:
;383:
;384:
;385:/*
;386:===================
;387:G_SpawnGEntityFromSpawnVars
;388:
;389:Spawn an entity and fill in all of the level fields from
;390:level.spawnVars[], then call the class specfic spawn function
;391:===================
;392:*/
;393:void G_SpawnGEntityFromSpawnVars(void) {
line 400
;394:	int			i;
;395:	gentity_t *ent;
;396:	char *s, *value, *gametypeName;
;397:	static char *gametypeNames[] = { "ffa", "duel", "race", "tdm", "ca", "ctf", "1f", "ob", "har", "ft", "dom", "ad", "rr" };
;398:
;399:	// get the next free entity
;400:	ent = G_Spawn();
ADDRLP4 20
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 402
;401:
;402:	for (i = 0; i < level.numSpawnVars; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $224
JUMPV
LABELV $221
line 403
;403:		G_ParseField(level.spawnVars[i][0], level.spawnVars[i][1], ent);
ADDRLP4 24
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 level+904
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 level+904+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_ParseField
CALLV
pop
line 404
;404:	}
LABELV $222
line 402
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $224
ADDRLP4 0
INDIRI4
ADDRGP4 level+900
INDIRI4
LTI4 $221
line 407
;405:
;406:	// check for "notteam" flag (GT_FFA, GT_DUEL, GT_RACE)
;407:	if (g_gametype.integer >= GT_TEAM) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $229
line 408
;408:		G_SpawnInt("notteam", "0", &i);
ADDRGP4 $232
ARGP4
ADDRGP4 $233
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 409
;409:		if (i) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $230
line 410
;410:			G_FreeEntity(ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 411
;411:			return;
ADDRGP4 $206
JUMPV
line 413
;412:		}
;413:	} else {
LABELV $229
line 414
;414:		G_SpawnInt("notfree", "0", &i);
ADDRGP4 $236
ARGP4
ADDRGP4 $233
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 415
;415:		if (i) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $237
line 416
;416:			G_FreeEntity(ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 417
;417:			return;
ADDRGP4 $206
JUMPV
LABELV $237
line 419
;418:		}
;419:	}
LABELV $230
line 421
;420:
;421:	G_SpawnInt("notta", "0", &i);
ADDRGP4 $239
ARGP4
ADDRGP4 $233
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnInt
CALLI4
pop
line 422
;422:	if (i) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $240
line 423
;423:		G_FreeEntity(ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 424
;424:		return;
ADDRGP4 $206
JUMPV
LABELV $240
line 427
;425:	}
;426:
;427:	if (G_SpawnString("gametype", NULL, &value)) {
ADDRGP4 $244
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 24
ADDRGP4 G_SpawnString
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $242
line 428
;428:		if (g_gametype.integer >= GT_FFA && g_gametype.integer < GT_MAX_GAME_TYPE) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 0
LTI4 $245
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 13
GEI4 $245
line 429
;429:			gametypeName = gametypeNames[g_gametype.integer];
ADDRLP4 16
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $207
ADDP4
INDIRP4
ASGNP4
line 431
;430:
;431:			s = strstr(value, gametypeName);
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 28
INDIRP4
ASGNP4
line 432
;432:			if (!s) {
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $250
line 433
;433:				G_FreeEntity(ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 434
;434:				return;
ADDRGP4 $206
JUMPV
LABELV $250
line 436
;435:			}
;436:		}
LABELV $245
line 437
;437:	}
LABELV $242
line 439
;438:
;439:	if (G_SpawnString("not_gametype", NULL, &value)) {
ADDRGP4 $254
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 28
ADDRGP4 G_SpawnString
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $252
line 440
;440:		if (g_gametype.integer >= GT_FFA && g_gametype.integer < GT_MAX_GAME_TYPE) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 0
LTI4 $255
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 13
GEI4 $255
line 441
;441:			gametypeName = gametypeNames[g_gametype.integer];
ADDRLP4 16
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $207
ADDP4
INDIRP4
ASGNP4
line 443
;442:
;443:			s = strstr(value, gametypeName);
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 32
INDIRP4
ASGNP4
line 444
;444:			if (s) {
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $260
line 445
;445:				G_FreeEntity(ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 446
;446:				return;
ADDRGP4 $206
JUMPV
LABELV $260
line 448
;447:			}
;448:		}
LABELV $255
line 449
;449:	}
LABELV $252
line 452
;450:
;451:	// move editor origin to pos
;452:	VectorCopy(ent->s.origin, ent->s.pos.trBase);
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 453
;453:	VectorCopy(ent->s.origin, ent->r.currentOrigin);
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 456
;454:
;455:	// if we didn't get a classname, don't bother spawning anything
;456:	if (!G_CallSpawn(ent)) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 G_CallSpawn
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $262
line 457
;457:		G_FreeEntity(ent);
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 458
;458:	}
LABELV $262
line 459
;459:}
LABELV $206
endproc G_SpawnGEntityFromSpawnVars 44 12
export G_AddSpawnVarToken
proc G_AddSpawnVarToken 16 12
line 468
;460:
;461:
;462:
;463:/*
;464:====================
;465:G_AddSpawnVarToken
;466:====================
;467:*/
;468:char *G_AddSpawnVarToken(const char *string) {
line 472
;469:	int		l;
;470:	char *dest;
;471:
;472:	l = (int)strlen(string);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 473
;473:	if (level.numSpawnVarChars + l + 1 > MAX_SPAWN_VARS_CHARS) {
ADDRGP4 level+1416
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
CNSTI4 1
ADDI4
CNSTI4 4096
LEI4 $265
line 474
;474:		G_Error("G_AddSpawnVarToken: MAX_SPAWN_VARS_CHARS");
ADDRGP4 $268
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 475
;475:	}
LABELV $265
line 477
;476:
;477:	dest = level.spawnVarChars + level.numSpawnVarChars;
ADDRLP4 4
ADDRGP4 level+1416
INDIRI4
ADDRGP4 level+1420
ADDP4
ASGNP4
line 478
;478:	memcpy(dest, string, l + 1);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 480
;479:
;480:	level.numSpawnVarChars += l + 1;
ADDRLP4 12
ADDRGP4 level+1416
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ADDI4
ASGNI4
line 482
;481:
;482:	return dest;
ADDRLP4 4
INDIRP4
RETP4
LABELV $264
endproc G_AddSpawnVarToken 16 12
export G_ParseSpawnVars
proc G_ParseSpawnVars 2072 8
line 495
;483:}
;484:
;485:/*
;486:====================
;487:G_ParseSpawnVars
;488:
;489:Parses a brace bounded set of key / value pairs out of the
;490:level's entity strings into level.spawnVars[]
;491:
;492:This does not actually spawn an entity.
;493:====================
;494:*/
;495:qboolean G_ParseSpawnVars(void) {
line 499
;496:	char		keyname[MAX_TOKEN_CHARS];
;497:	char		com_token[MAX_TOKEN_CHARS];
;498:
;499:	level.numSpawnVars = 0;
ADDRGP4 level+900
CNSTI4 0
ASGNI4
line 500
;500:	level.numSpawnVarChars = 0;
ADDRGP4 level+1416
CNSTI4 0
ASGNI4
line 503
;501:
;502:	// parse the opening brace
;503:	if (!trap_GetEntityToken(com_token, sizeof(com_token))) {
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2048
ADDRGP4 trap_GetEntityToken
CALLI4
ASGNI4
ADDRLP4 2048
INDIRI4
CNSTI4 0
NEI4 $275
line 505
;504:		// end of spawn string
;505:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $272
JUMPV
LABELV $275
line 507
;506:	}
;507:	if (com_token[0] != '{') {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $281
line 508
;508:		G_Error("G_ParseSpawnVars: found %s when expecting {", com_token);
ADDRGP4 $279
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 509
;509:	}
ADDRGP4 $281
JUMPV
LABELV $280
line 512
;510:
;511:	// go through all the key / value pairs
;512:	while (1) {
line 514
;513:		// parse key
;514:		if (!trap_GetEntityToken(keyname, sizeof(keyname))) {
ADDRLP4 1024
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2052
ADDRGP4 trap_GetEntityToken
CALLI4
ASGNI4
ADDRLP4 2052
INDIRI4
CNSTI4 0
NEI4 $283
line 515
;515:			G_Error("G_ParseSpawnVars: EOF without closing brace");
ADDRGP4 $285
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 516
;516:		}
LABELV $283
line 518
;517:
;518:		if (keyname[0] == '}') {
ADDRLP4 1024
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $286
line 519
;519:			break;
ADDRGP4 $282
JUMPV
LABELV $286
line 523
;520:		}
;521:
;522:		// parse value	
;523:		if (!trap_GetEntityToken(com_token, sizeof(com_token))) {
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 2056
ADDRGP4 trap_GetEntityToken
CALLI4
ASGNI4
ADDRLP4 2056
INDIRI4
CNSTI4 0
NEI4 $288
line 524
;524:			G_Error("G_ParseSpawnVars: EOF without closing brace");
ADDRGP4 $285
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 525
;525:		}
LABELV $288
line 527
;526:
;527:		if (com_token[0] == '}') {
ADDRLP4 0
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $290
line 528
;528:			G_Error("G_ParseSpawnVars: closing brace without data");
ADDRGP4 $292
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 529
;529:		}
LABELV $290
line 530
;530:		if (level.numSpawnVars == MAX_SPAWN_VARS) {
ADDRGP4 level+900
INDIRI4
CNSTI4 64
NEI4 $293
line 531
;531:			G_Error("G_ParseSpawnVars: MAX_SPAWN_VARS");
ADDRGP4 $296
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 532
;532:		}
LABELV $293
line 533
;533:		level.spawnVars[level.numSpawnVars][0] = G_AddSpawnVarToken(keyname);
ADDRLP4 1024
ARGP4
ADDRLP4 2060
ADDRGP4 G_AddSpawnVarToken
CALLP4
ASGNP4
ADDRGP4 level+900
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 level+904
ADDP4
ADDRLP4 2060
INDIRP4
ASGNP4
line 534
;534:		level.spawnVars[level.numSpawnVars][1] = G_AddSpawnVarToken(com_token);
ADDRLP4 0
ARGP4
ADDRLP4 2064
ADDRGP4 G_AddSpawnVarToken
CALLP4
ASGNP4
ADDRGP4 level+900
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 level+904+4
ADDP4
ADDRLP4 2064
INDIRP4
ASGNP4
line 535
;535:		level.numSpawnVars++;
ADDRLP4 2068
ADDRGP4 level+900
ASGNP4
ADDRLP4 2068
INDIRP4
ADDRLP4 2068
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 536
;536:	}
LABELV $281
line 512
ADDRGP4 $280
JUMPV
LABELV $282
line 538
;537:
;538:	return qtrue;
CNSTI4 1
RETI4
LABELV $272
endproc G_ParseSpawnVars 2072 8
export SP_worldspawn
proc SP_worldspawn 16 12
line 550
;539:}
;540:
;541:
;542:
;543:/*QUAKED worldspawn (0 0 0) ?
;544:
;545:Every map should have exactly one worldspawn.
;546:"music"		music wav file
;547:"gravity"	800 is default gravity
;548:"message"	Text to print during connection process
;549:*/
;550:void SP_worldspawn(void) {
line 553
;551:	char *s;
;552:
;553:	G_SpawnString("classname", "", &s);
ADDRGP4 $75
ARGP4
ADDRGP4 $304
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 554
;554:	if (Q_stricmp(s, "worldspawn")) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $307
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $305
line 555
;555:		G_Error("SP_worldspawn: The first entity isn't 'worldspawn'");
ADDRGP4 $308
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 556
;556:	}
LABELV $305
line 559
;557:
;558:	// make some data visible to connecting client
;559:	trap_SetConfigstring(CS_GAME_VERSION, GAME_VERSION);
CNSTI4 12
ARGI4
ADDRGP4 $309
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 561
;560:
;561:	trap_SetConfigstring(CS_LEVEL_START_TIME, va("%i", level.startTime));
ADDRGP4 $310
ARGP4
ADDRGP4 level+40
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 13
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 563
;562:
;563:	G_SpawnString("music", "", &s);
ADDRGP4 $312
ARGP4
ADDRGP4 $304
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 564
;564:	trap_SetConfigstring(CS_MUSIC, s);
CNSTI4 2
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 566
;565:
;566:	G_SpawnString("message", "", &s);
ADDRGP4 $83
ARGP4
ADDRGP4 $304
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 567
;567:	trap_SetConfigstring(CS_MESSAGE, s);				// map specific message
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 569
;568:
;569:	G_SpawnString("author", "", &s);
ADDRGP4 $313
ARGP4
ADDRGP4 $304
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 570
;570:	trap_SetConfigstring(CS_MAP_AUTHOR1, s);
CNSTI4 678
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 572
;571:
;572:	G_SpawnString("author2", "", &s);
ADDRGP4 $314
ARGP4
ADDRGP4 $304
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 573
;573:	trap_SetConfigstring(CS_MAP_AUTHOR2, s);
CNSTI4 679
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 575
;574:
;575:	trap_SetConfigstring(CS_MOTD, g_motd.string);		// message of the day
CNSTI4 4
ARGI4
ADDRGP4 g_motd+16
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 577
;576:
;577:	G_SpawnString("gravity", "800", &s);
ADDRGP4 $316
ARGP4
ADDRGP4 $317
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 578
;578:	trap_Cvar_Set("g_gravity", s);
ADDRGP4 $318
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 580
;579:
;580:	G_SpawnString("enableDust", "0", &s);
ADDRGP4 $319
ARGP4
ADDRGP4 $233
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 581
;581:	trap_Cvar_Set("g_enableDust", s);
ADDRGP4 $320
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 583
;582:
;583:	G_SpawnString("enableBreath", "0", &s);
ADDRGP4 $321
ARGP4
ADDRGP4 $233
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SpawnString
CALLI4
pop
line 584
;584:	trap_Cvar_Set("g_enableBreath", s);
ADDRGP4 $322
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 586
;585:
;586:	g_entities[ENTITYNUM_WORLD].s.number = ENTITYNUM_WORLD;
ADDRGP4 g_entities+850304
CNSTI4 1022
ASGNI4
line 587
;587:	g_entities[ENTITYNUM_WORLD].r.ownerNum = ENTITYNUM_NONE;
ADDRGP4 g_entities+850304+208+304
CNSTI4 1023
ASGNI4
line 588
;588:	g_entities[ENTITYNUM_WORLD].classname = "worldspawn";
ADDRGP4 g_entities+850304+524
ADDRGP4 $307
ASGNP4
line 590
;589:
;590:	g_entities[ENTITYNUM_NONE].s.number = ENTITYNUM_NONE;
ADDRGP4 g_entities+851136
CNSTI4 1023
ASGNI4
line 591
;591:	g_entities[ENTITYNUM_NONE].r.ownerNum = ENTITYNUM_NONE;
ADDRGP4 g_entities+851136+208+304
CNSTI4 1023
ASGNI4
line 592
;592:	g_entities[ENTITYNUM_NONE].classname = "nothing";
ADDRGP4 g_entities+851136+524
ADDRGP4 $335
ASGNP4
line 596
;593:
;594:	// see if we want a warmup time
;595:	// assume that g_doWarmup is always 1
;596:	level.warmupTime = -1;
ADDRGP4 level+16
CNSTI4 -1
ASGNI4
line 597
;597:	if (g_warmup.integer > 0) {
ADDRGP4 g_warmup+12
INDIRI4
CNSTI4 0
LEI4 $337
line 598
;598:		trap_SetConfigstring(CS_WARMUP, va("%i", level.warmupTime));
ADDRGP4 $310
ARGP4
ADDRGP4 level+16
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 5
ARGI4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 599
;599:	} else {
ADDRGP4 $338
JUMPV
LABELV $337
line 600
;600:		trap_SetConfigstring(CS_WARMUP, "");
CNSTI4 5
ARGI4
ADDRGP4 $304
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 601
;601:	}
LABELV $338
line 602
;602:	G_LogPrintf("Warmup:\n");
ADDRGP4 $341
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 603
;603:}
LABELV $303
endproc SP_worldspawn 16 12
export G_SpawnEntitiesFromString
proc G_SpawnEntitiesFromString 8 4
line 613
;604:
;605:
;606:/*
;607:==============
;608:G_SpawnEntitiesFromString
;609:
;610:Parses textual entity definitions out of an entstring and spawns gentities.
;611:==============
;612:*/
;613:void G_SpawnEntitiesFromString(void) {
line 615
;614:	// allow calls to G_Spawn*()
;615:	level.spawning = qtrue;
ADDRGP4 level+896
CNSTI4 1
ASGNI4
line 616
;616:	level.numSpawnVars = 0;
ADDRGP4 level+900
CNSTI4 0
ASGNI4
line 621
;617:
;618:	// the worldspawn is not an actual entity, but it still
;619:	// has a "spawn" function to perform any global setup
;620:	// needed by a level (setting configstrings or cvars, etc)
;621:	if (!G_ParseSpawnVars()) {
ADDRLP4 0
ADDRGP4 G_ParseSpawnVars
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $345
line 622
;622:		G_Error("SpawnEntities: no entities");
ADDRGP4 $347
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 623
;623:	}
LABELV $345
line 624
;624:	SP_worldspawn();
ADDRGP4 SP_worldspawn
CALLV
pop
ADDRGP4 $349
JUMPV
LABELV $348
line 627
;625:
;626:	// parse ents
;627:	while (G_ParseSpawnVars()) {
line 628
;628:		G_SpawnGEntityFromSpawnVars();
ADDRGP4 G_SpawnGEntityFromSpawnVars
CALLV
pop
line 629
;629:	}
LABELV $349
line 627
ADDRLP4 4
ADDRGP4 G_ParseSpawnVars
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $348
line 631
;630:
;631:	level.spawning = qfalse;			// any future calls to G_Spawn*() will be errors
ADDRGP4 level+896
CNSTI4 0
ASGNI4
line 632
;632:}
LABELV $342
endproc G_SpawnEntitiesFromString 8 4
import SP_team_neutralobelisk
import SP_team_redobelisk
import SP_team_blueobelisk
import SP_team_CTF_bluespawn
import SP_team_CTF_redspawn
import SP_team_CTF_blueplayer
import SP_team_CTF_redplayer
import SP_shooter_grenade
import SP_shooter_plasma
import SP_shooter_rocket
import SP_misc_portal_surface
import SP_misc_portal_camera
import SP_misc_model
import SP_misc_teleporter_dest
import SP_path_corner
import SP_info_camp
import SP_info_notnull
import SP_info_null
import SP_light
import SP_target_cvar
import SP_target_push
import SP_target_location
import SP_target_position
import SP_target_kill
import SP_target_relay
import SP_target_teleporter
import SP_target_score
import SP_target_laser
import SP_target_print
import SP_target_speaker
import SP_target_delay
import SP_target_give
import SP_target_remove_powerups
import SP_trigger_hurt
import SP_trigger_teleport
import SP_trigger_push
import SP_trigger_multiple
import SP_trigger_always
import SP_func_timer
import SP_func_train
import SP_func_door
import SP_func_button
import SP_func_pendulum
import SP_func_bobbing
import SP_func_rotating
import SP_func_static
import SP_func_plat
import SP_info_player_intermission
import SP_info_player_deathmatch
import SP_info_player_start
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
LABELV $347
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 105
byte 1 101
byte 1 115
byte 1 58
byte 1 32
byte 1 110
byte 1 111
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 105
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $341
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $335
byte 1 110
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $322
byte 1 103
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 66
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $321
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 66
byte 1 114
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $320
byte 1 103
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 68
byte 1 117
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $319
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 68
byte 1 117
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $318
byte 1 103
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $317
byte 1 56
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $316
byte 1 103
byte 1 114
byte 1 97
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $314
byte 1 97
byte 1 117
byte 1 116
byte 1 104
byte 1 111
byte 1 114
byte 1 50
byte 1 0
align 1
LABELV $313
byte 1 97
byte 1 117
byte 1 116
byte 1 104
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $312
byte 1 109
byte 1 117
byte 1 115
byte 1 105
byte 1 99
byte 1 0
align 1
LABELV $310
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $309
byte 1 100
byte 1 109
byte 1 45
byte 1 113
byte 1 108
byte 1 0
align 1
LABELV $308
byte 1 83
byte 1 80
byte 1 95
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 58
byte 1 32
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 105
byte 1 115
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 39
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 39
byte 1 0
align 1
LABELV $307
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $304
byte 1 0
align 1
LABELV $296
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 86
byte 1 97
byte 1 114
byte 1 115
byte 1 58
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 83
byte 1 80
byte 1 65
byte 1 87
byte 1 78
byte 1 95
byte 1 86
byte 1 65
byte 1 82
byte 1 83
byte 1 0
align 1
LABELV $292
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 86
byte 1 97
byte 1 114
byte 1 115
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 100
byte 1 97
byte 1 116
byte 1 97
byte 1 0
align 1
LABELV $285
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 86
byte 1 97
byte 1 114
byte 1 115
byte 1 58
byte 1 32
byte 1 69
byte 1 79
byte 1 70
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 99
byte 1 108
byte 1 111
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 98
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $279
byte 1 71
byte 1 95
byte 1 80
byte 1 97
byte 1 114
byte 1 115
byte 1 101
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 86
byte 1 97
byte 1 114
byte 1 115
byte 1 58
byte 1 32
byte 1 102
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 119
byte 1 104
byte 1 101
byte 1 110
byte 1 32
byte 1 101
byte 1 120
byte 1 112
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 123
byte 1 0
align 1
LABELV $268
byte 1 71
byte 1 95
byte 1 65
byte 1 100
byte 1 100
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 86
byte 1 97
byte 1 114
byte 1 84
byte 1 111
byte 1 107
byte 1 101
byte 1 110
byte 1 58
byte 1 32
byte 1 77
byte 1 65
byte 1 88
byte 1 95
byte 1 83
byte 1 80
byte 1 65
byte 1 87
byte 1 78
byte 1 95
byte 1 86
byte 1 65
byte 1 82
byte 1 83
byte 1 95
byte 1 67
byte 1 72
byte 1 65
byte 1 82
byte 1 83
byte 1 0
align 1
LABELV $254
byte 1 110
byte 1 111
byte 1 116
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
LABELV $244
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
LABELV $239
byte 1 110
byte 1 111
byte 1 116
byte 1 116
byte 1 97
byte 1 0
align 1
LABELV $236
byte 1 110
byte 1 111
byte 1 116
byte 1 102
byte 1 114
byte 1 101
byte 1 101
byte 1 0
align 1
LABELV $233
byte 1 48
byte 1 0
align 1
LABELV $232
byte 1 110
byte 1 111
byte 1 116
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $220
byte 1 114
byte 1 114
byte 1 0
align 1
LABELV $219
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $218
byte 1 100
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $217
byte 1 102
byte 1 116
byte 1 0
align 1
LABELV $216
byte 1 104
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $215
byte 1 111
byte 1 98
byte 1 0
align 1
LABELV $214
byte 1 49
byte 1 102
byte 1 0
align 1
LABELV $213
byte 1 99
byte 1 116
byte 1 102
byte 1 0
align 1
LABELV $212
byte 1 99
byte 1 97
byte 1 0
align 1
LABELV $211
byte 1 116
byte 1 100
byte 1 109
byte 1 0
align 1
LABELV $210
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $209
byte 1 100
byte 1 117
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $208
byte 1 102
byte 1 102
byte 1 97
byte 1 0
align 1
LABELV $175
byte 1 37
byte 1 115
byte 1 32
byte 1 100
byte 1 111
byte 1 101
byte 1 115
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 104
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 97
byte 1 32
byte 1 115
byte 1 112
byte 1 97
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
byte 1 10
byte 1 0
align 1
LABELV $161
byte 1 71
byte 1 95
byte 1 67
byte 1 97
byte 1 108
byte 1 108
byte 1 83
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 58
byte 1 32
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $157
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 98
byte 1 111
byte 1 116
byte 1 114
byte 1 111
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $156
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 110
byte 1 101
byte 1 117
byte 1 116
byte 1 114
byte 1 97
byte 1 108
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $155
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $154
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $153
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $152
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $151
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $150
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $149
byte 1 115
byte 1 104
byte 1 111
byte 1 111
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 0
align 1
LABELV $148
byte 1 115
byte 1 104
byte 1 111
byte 1 111
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $147
byte 1 115
byte 1 104
byte 1 111
byte 1 111
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $146
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 95
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 97
byte 1 108
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 97
byte 1 0
align 1
LABELV $145
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 95
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 97
byte 1 108
byte 1 95
byte 1 115
byte 1 117
byte 1 114
byte 1 102
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $144
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $143
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 101
byte 1 114
byte 1 95
byte 1 100
byte 1 101
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $142
byte 1 112
byte 1 97
byte 1 116
byte 1 104
byte 1 95
byte 1 99
byte 1 111
byte 1 114
byte 1 110
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $141
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $140
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 112
byte 1 117
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $139
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
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
LABELV $138
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
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
LABELV $137
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $136
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $135
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $134
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $133
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 108
byte 1 97
byte 1 115
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $132
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $131
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 115
byte 1 112
byte 1 101
byte 1 97
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $130
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 100
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $129
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 114
byte 1 101
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $128
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 95
byte 1 103
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $127
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 104
byte 1 117
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $126
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $125
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 112
byte 1 117
byte 1 115
byte 1 104
byte 1 0
align 1
LABELV $124
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 109
byte 1 117
byte 1 108
byte 1 116
byte 1 105
byte 1 112
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $123
byte 1 116
byte 1 114
byte 1 105
byte 1 103
byte 1 103
byte 1 101
byte 1 114
byte 1 95
byte 1 97
byte 1 108
byte 1 119
byte 1 97
byte 1 121
byte 1 115
byte 1 0
align 1
LABELV $122
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $121
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 103
byte 1 114
byte 1 111
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $120
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $119
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 112
byte 1 101
byte 1 110
byte 1 100
byte 1 117
byte 1 108
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $118
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 98
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $117
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 114
byte 1 111
byte 1 116
byte 1 97
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $116
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 105
byte 1 99
byte 1 0
align 1
LABELV $115
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 100
byte 1 111
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $114
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 98
byte 1 117
byte 1 116
byte 1 116
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $113
byte 1 102
byte 1 117
byte 1 110
byte 1 99
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 116
byte 1 0
align 1
LABELV $112
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 111
byte 1 100
byte 1 105
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $111
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $110
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 115
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $109
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 102
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 112
byte 1 108
byte 1 97
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $108
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 112
byte 1 0
align 1
LABELV $107
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 110
byte 1 111
byte 1 116
byte 1 110
byte 1 117
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $106
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 110
byte 1 117
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $105
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
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $104
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
LABELV $103
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
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 0
align 1
LABELV $96
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 86
byte 1 97
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $95
byte 1 99
byte 1 118
byte 1 97
byte 1 114
byte 1 0
align 1
LABELV $94
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 83
byte 1 104
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 78
byte 1 101
byte 1 119
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $93
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 83
byte 1 104
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $92
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $91
byte 1 97
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $90
byte 1 100
byte 1 109
byte 1 103
byte 1 0
align 1
LABELV $89
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $88
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $87
byte 1 99
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $86
byte 1 114
byte 1 97
byte 1 110
byte 1 100
byte 1 111
byte 1 109
byte 1 0
align 1
LABELV $85
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $84
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 0
align 1
LABELV $83
byte 1 109
byte 1 101
byte 1 115
byte 1 115
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $82
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $81
byte 1 116
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $80
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $79
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $78
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 50
byte 1 0
align 1
LABELV $77
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $76
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $75
byte 1 99
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $72
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 32
byte 1 37
byte 1 102
byte 1 0

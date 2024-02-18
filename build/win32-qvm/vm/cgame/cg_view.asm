export CG_TestModel_f
code
proc CG_TestModel_f 36 12
file "..\..\..\..\code\cgame\cg_view.c"
line 51
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_view.c -- setup all the parameters (position, angle, etc)
;4:// for a 3D rendering
;5:#include "cg_local.h"
;6:
;7:
;8:/*
;9:=============================================================================
;10:
;11:  MODEL TESTING
;12:
;13:The viewthing and gun positioning tools from Q2 have been integrated and
;14:enhanced into a single model testing facility.
;15:
;16:Model viewing can begin with either "testmodel <modelname>" or "testgun <modelname>".
;17:
;18:The names must be the full pathname after the basedir, like
;19:"models/weapons/v_launch/tris.md3" or "players/male/tris.md3"
;20:
;21:Testmodel will create a fake entity 100 units in front of the current view
;22:position, directly facing the viewer.  It will remain immobile, so you can
;23:move around it to view it from different angles.
;24:
;25:Testgun will cause the model to follow the player around and supress the real
;26:view weapon model.  The default frame 0 of most guns is completely off screen,
;27:so you will probably have to cycle a couple frames to see it.
;28:
;29:"nextframe", "prevframe", "nextskin", and "prevskin" commands will change the
;30:frame or skin of the testmodel.  These are bound to F5, F6, F7, and F8 in
;31:q3default.cfg.
;32:
;33:If a gun is being tested, the "gun_x", "gun_y", and "gun_z" variables will let
;34:you adjust the positioning.
;35:
;36:Note that none of the model testing features update while the game is paused, so
;37:it may be convenient to test with deathmatch set to 1 so that bringing down the
;38:console doesn't pause the game.
;39:
;40:=============================================================================
;41:*/
;42:
;43:/*
;44:=================
;45:CG_TestModel_f
;46:
;47:Creates an entity in front of the current position, which
;48:can then be moved around
;49:=================
;50:*/
;51:void CG_TestModel_f(void) {
line 54
;52:	vec3_t		angles;
;53:
;54:	memset(&cg.testModelEntity, 0, sizeof(cg.testModelEntity));
ADDRGP4 cg+125884
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 55
;55:	if (trap_Argc() < 2) {
ADDRLP4 12
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 2
GEI4 $75
line 56
;56:		return;
ADDRGP4 $72
JUMPV
LABELV $75
line 59
;57:	}
;58:
;59:	Q_strncpyz(cg.testModelName, CG_Argv(1), MAX_QPATH);
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRGP4 cg+126024
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 60
;60:	cg.testModelEntity.hModel = trap_R_RegisterModel(cg.testModelName);
ADDRGP4 cg+126024
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cg+125884+8
ADDRLP4 20
INDIRI4
ASGNI4
line 62
;61:
;62:	if (trap_Argc() == 3) {
ADDRLP4 24
ADDRGP4 trap_Argc
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 3
NEI4 $81
line 63
;63:		cg.testModelEntity.backlerp = atof(CG_Argv(2));
CNSTI4 2
ARGI4
ADDRLP4 28
ADDRGP4 CG_Argv
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 atof
CALLF4
ASGNF4
ADDRGP4 cg+125884+100
ADDRLP4 32
INDIRF4
ASGNF4
line 64
;64:		cg.testModelEntity.frame = 1;
ADDRGP4 cg+125884+80
CNSTI4 1
ASGNI4
line 65
;65:		cg.testModelEntity.oldframe = 0;
ADDRGP4 cg+125884+96
CNSTI4 0
ASGNI4
line 66
;66:	}
LABELV $81
line 68
;67:
;68:	if (!cg.testModelEntity.hModel) {
ADDRGP4 cg+125884+8
INDIRI4
CNSTI4 0
NEI4 $89
line 69
;69:		CG_Printf("Can't register model '%s'.\n", cg.testModelName);
ADDRGP4 $93
ARGP4
ADDRGP4 cg+126024
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 70
;70:		return;
ADDRGP4 $72
JUMPV
LABELV $89
line 73
;71:	}
;72:
;73:	VectorMA(cg.refdef.vieworg, 100, cg.refdef.viewaxis[0], cg.testModelEntity.origin);
ADDRGP4 cg+125884+68
ADDRGP4 cg+109056+24
INDIRF4
ADDRGP4 cg+109056+36
INDIRF4
CNSTF4 1120403456
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+125884+68+4
ADDRGP4 cg+109056+24+4
INDIRF4
ADDRGP4 cg+109056+36+4
INDIRF4
CNSTF4 1120403456
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+125884+68+8
ADDRGP4 cg+109056+24+8
INDIRF4
ADDRGP4 cg+109056+36+8
INDIRF4
CNSTF4 1120403456
MULF4
ADDF4
ASGNF4
line 75
;74:
;75:	angles[PITCH] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 76
;76:	angles[YAW] = 180 + cg.refdefViewAngles[1];
ADDRLP4 0+4
ADDRGP4 cg+109424+4
INDIRF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 77
;77:	angles[ROLL] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 79
;78:
;79:	AnglesToAxis(angles, cg.testModelEntity.axis);
ADDRLP4 0
ARGP4
ADDRGP4 cg+125884+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 80
;80:	cg.testGun = qfalse;
ADDRGP4 cg+126088
CNSTI4 0
ASGNI4
line 81
;81:}
LABELV $72
endproc CG_TestModel_f 36 12
export CG_TestGun_f
proc CG_TestGun_f 0 0
line 90
;82:
;83:/*
;84:=================
;85:CG_TestGun_f
;86:
;87:Replaces the current view weapon with the given model
;88:=================
;89:*/
;90:void CG_TestGun_f(void) {
line 91
;91:	CG_TestModel_f();
ADDRGP4 CG_TestModel_f
CALLV
pop
line 92
;92:	cg.testGun = qtrue;
ADDRGP4 cg+126088
CNSTI4 1
ASGNI4
line 93
;93:	cg.testModelEntity.renderfx = RF_MINLIGHT | RF_DEPTHHACK | RF_FIRST_PERSON;
ADDRGP4 cg+125884+4
CNSTI4 13
ASGNI4
line 94
;94:}
LABELV $126
endproc CG_TestGun_f 0 0
export CG_TestModelNextFrame_f
proc CG_TestModelNextFrame_f 4 8
line 97
;95:
;96:
;97:void CG_TestModelNextFrame_f(void) {
line 98
;98:	cg.testModelEntity.frame++;
ADDRLP4 0
ADDRGP4 cg+125884+80
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 99
;99:	CG_Printf("frame %i\n", cg.testModelEntity.frame);
ADDRGP4 $133
ARGP4
ADDRGP4 cg+125884+80
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 100
;100:}
LABELV $130
endproc CG_TestModelNextFrame_f 4 8
export CG_TestModelPrevFrame_f
proc CG_TestModelPrevFrame_f 4 8
line 102
;101:
;102:void CG_TestModelPrevFrame_f(void) {
line 103
;103:	cg.testModelEntity.frame--;
ADDRLP4 0
ADDRGP4 cg+125884+80
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 104
;104:	if (cg.testModelEntity.frame < 0) {
ADDRGP4 cg+125884+80
INDIRI4
CNSTI4 0
GEI4 $139
line 105
;105:		cg.testModelEntity.frame = 0;
ADDRGP4 cg+125884+80
CNSTI4 0
ASGNI4
line 106
;106:	}
LABELV $139
line 107
;107:	CG_Printf("frame %i\n", cg.testModelEntity.frame);
ADDRGP4 $133
ARGP4
ADDRGP4 cg+125884+80
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 108
;108:}
LABELV $136
endproc CG_TestModelPrevFrame_f 4 8
export CG_TestModelNextSkin_f
proc CG_TestModelNextSkin_f 4 8
line 110
;109:
;110:void CG_TestModelNextSkin_f(void) {
line 111
;111:	cg.testModelEntity.skinNum++;
ADDRLP4 0
ADDRGP4 cg+125884+104
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 112
;112:	CG_Printf("skin %i\n", cg.testModelEntity.skinNum);
ADDRGP4 $150
ARGP4
ADDRGP4 cg+125884+104
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 113
;113:}
LABELV $147
endproc CG_TestModelNextSkin_f 4 8
export CG_TestModelPrevSkin_f
proc CG_TestModelPrevSkin_f 4 8
line 115
;114:
;115:void CG_TestModelPrevSkin_f(void) {
line 116
;116:	cg.testModelEntity.skinNum--;
ADDRLP4 0
ADDRGP4 cg+125884+104
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 117
;117:	if (cg.testModelEntity.skinNum < 0) {
ADDRGP4 cg+125884+104
INDIRI4
CNSTI4 0
GEI4 $156
line 118
;118:		cg.testModelEntity.skinNum = 0;
ADDRGP4 cg+125884+104
CNSTI4 0
ASGNI4
line 119
;119:	}
LABELV $156
line 120
;120:	CG_Printf("skin %i\n", cg.testModelEntity.skinNum);
ADDRGP4 $150
ARGP4
ADDRGP4 cg+125884+104
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 121
;121:}
LABELV $153
endproc CG_TestModelPrevSkin_f 4 8
proc CG_AddTestModel 32 4
line 123
;122:
;123:static void CG_AddTestModel(void) {
line 127
;124:	int		i;
;125:
;126:	// re-register the model, because the level may have changed
;127:	cg.testModelEntity.hModel = trap_R_RegisterModel(cg.testModelName);
ADDRGP4 cg+126024
ARGP4
ADDRLP4 4
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cg+125884+8
ADDRLP4 4
INDIRI4
ASGNI4
line 128
;128:	if (!cg.testModelEntity.hModel) {
ADDRGP4 cg+125884+8
INDIRI4
CNSTI4 0
NEI4 $168
line 129
;129:		CG_Printf("Can't register model\n");
ADDRGP4 $172
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 130
;130:		return;
ADDRGP4 $164
JUMPV
LABELV $168
line 134
;131:	}
;132:
;133:	// if testing a gun, set the origin relative to the view origin
;134:	if (cg.testGun) {
ADDRGP4 cg+126088
INDIRI4
CNSTI4 0
EQI4 $173
line 135
;135:		VectorCopy(cg.refdef.vieworg, cg.testModelEntity.origin);
ADDRGP4 cg+125884+68
ADDRGP4 cg+109056+24
INDIRB
ASGNB 12
line 136
;136:		VectorCopy(cg.refdef.viewaxis[0], cg.testModelEntity.axis[0]);
ADDRGP4 cg+125884+28
ADDRGP4 cg+109056+36
INDIRB
ASGNB 12
line 137
;137:		VectorCopy(cg.refdef.viewaxis[1], cg.testModelEntity.axis[1]);
ADDRGP4 cg+125884+28+12
ADDRGP4 cg+109056+36+12
INDIRB
ASGNB 12
line 138
;138:		VectorCopy(cg.refdef.viewaxis[2], cg.testModelEntity.axis[2]);
ADDRGP4 cg+125884+28+24
ADDRGP4 cg+109056+36+24
INDIRB
ASGNB 12
line 141
;139:
;140:		// allow the position to be adjusted
;141:		for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $196
line 142
;142:			cg.testModelEntity.origin[i] += cg.refdef.viewaxis[0][i] * cg_gun_x.value;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125884+68
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+109056+36
ADDP4
INDIRF4
ADDRGP4 cg_gun_x+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 143
;143:			cg.testModelEntity.origin[i] += cg.refdef.viewaxis[1][i] * cg_gun_y.value;
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125884+68
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+109056+36+12
ADDP4
INDIRF4
ADDRGP4 cg_gun_y+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 144
;144:			cg.testModelEntity.origin[i] += cg.refdef.viewaxis[2][i] * cg_gun_z.value;
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125884+68
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+109056+36+24
ADDP4
INDIRF4
ADDRGP4 cg_gun_z+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 145
;145:		}
LABELV $197
line 141
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $196
line 146
;146:	}
LABELV $173
line 148
;147:
;148:	trap_R_AddRefEntityToScene(&cg.testModelEntity);
ADDRGP4 cg+125884
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 149
;149:}
LABELV $164
endproc CG_AddTestModel 32 4
proc CG_CalcVrect 12 8
line 163
;150:
;151:
;152:
;153://============================================================================
;154:
;155:
;156:/*
;157:=================
;158:CG_CalcVrect
;159:
;160:Sets the coordinates of the rendered window
;161:=================
;162:*/
;163:static void CG_CalcVrect(void) {
line 167
;164:	int		size;
;165:
;166:	// the intermission should allways be full screen
;167:	if (cg.snap->ps.pm_type == PM_INTERMISSION) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $219
line 168
;168:		size = 100;
ADDRLP4 0
CNSTI4 100
ASGNI4
line 169
;169:	} else {
ADDRGP4 $220
JUMPV
LABELV $219
line 171
;170:		// bound normal viewsize
;171:		if (cg_viewsize.integer < 30) {
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 30
GEI4 $222
line 172
;172:			trap_Cvar_Set("cg_viewsize", "30");
ADDRGP4 $225
ARGP4
ADDRGP4 $226
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 173
;173:			size = 30;
ADDRLP4 0
CNSTI4 30
ASGNI4
line 174
;174:		} else if (cg_viewsize.integer > 100) {
ADDRGP4 $223
JUMPV
LABELV $222
ADDRGP4 cg_viewsize+12
INDIRI4
CNSTI4 100
LEI4 $227
line 175
;175:			trap_Cvar_Set("cg_viewsize", "100");
ADDRGP4 $225
ARGP4
ADDRGP4 $230
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 176
;176:			size = 100;
ADDRLP4 0
CNSTI4 100
ASGNI4
line 177
;177:		} else {
ADDRGP4 $228
JUMPV
LABELV $227
line 178
;178:			size = cg_viewsize.integer;
ADDRLP4 0
ADDRGP4 cg_viewsize+12
INDIRI4
ASGNI4
line 179
;179:		}
LABELV $228
LABELV $223
line 181
;180:
;181:	}
LABELV $220
line 182
;182:	cg.refdef.width = cgs.glconfig.vidWidth * size / 100;
ADDRGP4 cg+109056+8
ADDRGP4 cgs+20100+11304
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 100
DIVI4
ASGNI4
line 183
;183:	cg.refdef.width &= ~1;
ADDRLP4 4
ADDRGP4 cg+109056+8
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 185
;184:
;185:	cg.refdef.height = cgs.glconfig.vidHeight * size / 100;
ADDRGP4 cg+109056+12
ADDRGP4 cgs+20100+11308
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 100
DIVI4
ASGNI4
line 186
;186:	cg.refdef.height &= ~1;
ADDRLP4 8
ADDRGP4 cg+109056+12
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 188
;187:
;188:	cg.refdef.x = (cgs.glconfig.vidWidth - cg.refdef.width) / 2;
ADDRGP4 cg+109056
ADDRGP4 cgs+20100+11304
INDIRI4
ADDRGP4 cg+109056+8
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 189
;189:	cg.refdef.y = (cgs.glconfig.vidHeight - cg.refdef.height) / 2;
ADDRGP4 cg+109056+4
ADDRGP4 cgs+20100+11308
INDIRI4
ADDRGP4 cg+109056+12
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 190
;190:}
LABELV $218
endproc CG_CalcVrect 12 8
data
align 4
LABELV $256
byte 4 3229614080
byte 4 3229614080
byte 4 3229614080
align 4
LABELV $257
byte 4 1082130432
byte 4 1082130432
byte 4 1082130432
code
proc CG_OffsetThirdPersonView 180 28
line 202
;191:
;192://==============================================================================
;193:
;194:
;195:/*
;196:===============
;197:CG_OffsetThirdPersonView
;198:
;199:===============
;200:*/
;201:#define	FOCUS_DISTANCE	512
;202:static void CG_OffsetThirdPersonView(void) {
line 213
;203:	vec3_t		forward, right, up;
;204:	vec3_t		view;
;205:	vec3_t		focusAngles;
;206:	trace_t		trace;
;207:	static vec3_t	mins = { -4, -4, -4 };
;208:	static vec3_t	maxs = { 4, 4, 4 };
;209:	vec3_t		focusPoint;
;210:	float		focusDist;
;211:	float		forwardScale, sideScale;
;212:
;213:	cg.refdef.vieworg[2] += cg.predictedPlayerState.viewheight;
ADDRLP4 140
ADDRGP4 cg+109056+24+8
ASGNP4
ADDRLP4 140
INDIRP4
ADDRLP4 140
INDIRP4
INDIRF4
ADDRGP4 cg+107636+164
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 215
;214:
;215:	VectorCopy(cg.refdefViewAngles, focusAngles);
ADDRLP4 48
ADDRGP4 cg+109424
INDIRB
ASGNB 12
line 218
;216:
;217:	// if dead, look at killer
;218:	if (cg.predictedPlayerState.stats[STAT_HEALTH] <= 0) {
ADDRGP4 cg+107636+184
INDIRI4
CNSTI4 0
GTI4 $264
line 219
;219:		focusAngles[YAW] = cg.predictedPlayerState.stats[STAT_DEAD_YAW];
ADDRLP4 48+4
ADDRGP4 cg+107636+184+20
INDIRI4
CVIF4 4
ASGNF4
line 220
;220:		cg.refdefViewAngles[YAW] = cg.predictedPlayerState.stats[STAT_DEAD_YAW];
ADDRGP4 cg+109424+4
ADDRGP4 cg+107636+184+20
INDIRI4
CVIF4 4
ASGNF4
line 221
;221:	}
LABELV $264
line 223
;222:
;223:	if (focusAngles[PITCH] > 45) {
ADDRLP4 48
INDIRF4
CNSTF4 1110704128
LEF4 $277
line 224
;224:		focusAngles[PITCH] = 45;		// don't go too far overhead
ADDRLP4 48
CNSTF4 1110704128
ASGNF4
line 225
;225:	}
LABELV $277
line 226
;226:	AngleVectors(focusAngles, forward, NULL, NULL);
ADDRLP4 48
ARGP4
ADDRLP4 24
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 228
;227:
;228:	VectorMA(cg.refdef.vieworg, FOCUS_DISTANCE, forward, focusPoint);
ADDRLP4 12
ADDRGP4 cg+109056+24
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 1140850688
MULF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRGP4 cg+109056+24+4
INDIRF4
ADDRLP4 24+4
INDIRF4
CNSTF4 1140850688
MULF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRGP4 cg+109056+24+8
INDIRF4
ADDRLP4 24+8
INDIRF4
CNSTF4 1140850688
MULF4
ADDF4
ASGNF4
line 230
;229:
;230:	VectorCopy(cg.refdef.vieworg, view);
ADDRLP4 0
ADDRGP4 cg+109056+24
INDIRB
ASGNB 12
line 232
;231:
;232:	view[2] += 8;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 234
;233:
;234:	cg.refdefViewAngles[PITCH] *= 0.5;
ADDRLP4 144
ADDRGP4 cg+109424
ASGNP4
ADDRLP4 144
INDIRP4
ADDRLP4 144
INDIRP4
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 236
;235:
;236:	AngleVectors(cg.refdefViewAngles, forward, right, up);
ADDRGP4 cg+109424
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 128
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 238
;237:
;238:	forwardScale = cos(cg_thirdPersonAngle.value / 180 * M_PI);
ADDRGP4 cg_thirdPersonAngle+8
INDIRF4
CNSTF4 1016003125
MULF4
ARGF4
ADDRLP4 148
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 60
ADDRLP4 148
INDIRF4
ASGNF4
line 239
;239:	sideScale = sin(cg_thirdPersonAngle.value / 180 * M_PI);
ADDRGP4 cg_thirdPersonAngle+8
INDIRF4
CNSTF4 1016003125
MULF4
ARGF4
ADDRLP4 152
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 64
ADDRLP4 152
INDIRF4
ASGNF4
line 240
;240:	VectorMA(view, -cg_thirdPersonRange.value * forwardScale, forward, view);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
ADDRGP4 cg_thirdPersonRange+8
INDIRF4
NEGF4
ADDRLP4 60
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24+4
INDIRF4
ADDRGP4 cg_thirdPersonRange+8
INDIRF4
NEGF4
ADDRLP4 60
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 24+8
INDIRF4
ADDRGP4 cg_thirdPersonRange+8
INDIRF4
NEGF4
ADDRLP4 60
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 241
;241:	VectorMA(view, -cg_thirdPersonRange.value * sideScale, right, view);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDRGP4 cg_thirdPersonRange+8
INDIRF4
NEGF4
ADDRLP4 64
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDRGP4 cg_thirdPersonRange+8
INDIRF4
NEGF4
ADDRLP4 64
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDRGP4 cg_thirdPersonRange+8
INDIRF4
NEGF4
ADDRLP4 64
INDIRF4
MULF4
MULF4
ADDF4
ASGNF4
line 246
;242:
;243:	// trace a ray from the origin to the viewpoint to make sure the view isn't
;244:	// in a solid block.  Use an 8 by 8 block to prevent the view from near clipping anything
;245:
;246:	if (!cg_cameraMode.integer) {
ADDRGP4 cg_cameraMode+12
INDIRI4
CNSTI4 0
NEI4 $316
line 247
;247:		CG_Trace(&trace, cg.refdef.vieworg, mins, maxs, view, cg.predictedPlayerState.clientNum, MASK_SOLID);
ADDRLP4 72
ARGP4
ADDRGP4 cg+109056+24
ARGP4
ADDRGP4 $256
ARGP4
ADDRGP4 $257
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cg+107636+140
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 249
;248:
;249:		if (trace.fraction != 1.0) {
ADDRLP4 72+8
INDIRF4
CNSTF4 1065353216
EQF4 $323
line 250
;250:			VectorCopy(trace.endpos, view);
ADDRLP4 0
ADDRLP4 72+12
INDIRB
ASGNB 12
line 251
;251:			view[2] += (1.0 - trace.fraction) * 32;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
ADDRLP4 72+8
INDIRF4
SUBF4
CNSTF4 1107296256
MULF4
ADDF4
ASGNF4
line 255
;252:			// try another trace to this position, because a tunnel may have the ceiling
;253:			// close enough that this is poking out
;254:
;255:			CG_Trace(&trace, cg.refdef.vieworg, mins, maxs, view, cg.predictedPlayerState.clientNum, MASK_SOLID);
ADDRLP4 72
ARGP4
ADDRGP4 cg+109056+24
ARGP4
ADDRGP4 $256
ARGP4
ADDRGP4 $257
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 cg+107636+140
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 256
;256:			VectorCopy(trace.endpos, view);
ADDRLP4 0
ADDRLP4 72+12
INDIRB
ASGNB 12
line 257
;257:		}
LABELV $323
line 258
;258:	}
LABELV $316
line 261
;259:
;260:
;261:	VectorCopy(view, cg.refdef.vieworg);
ADDRGP4 cg+109056+24
ADDRLP4 0
INDIRB
ASGNB 12
line 264
;262:
;263:	// select pitch to look at focus point from vieword
;264:	VectorSubtract(focusPoint, cg.refdef.vieworg, focusPoint);
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRGP4 cg+109056+24
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
ADDRGP4 cg+109056+24+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
ADDRGP4 cg+109056+24+8
INDIRF4
SUBF4
ASGNF4
line 265
;265:	focusDist = sqrt(focusPoint[0] * focusPoint[0] + focusPoint[1] * focusPoint[1]);
ADDRLP4 164
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 164
INDIRF4
ADDRLP4 164
INDIRF4
MULF4
ADDRLP4 12+4
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 168
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 68
ADDRLP4 168
INDIRF4
ASGNF4
line 266
;266:	if (focusDist < 1) {
ADDRLP4 68
INDIRF4
CNSTF4 1065353216
GEF4 $350
line 267
;267:		focusDist = 1;	// should never happen
ADDRLP4 68
CNSTF4 1065353216
ASGNF4
line 268
;268:	}
LABELV $350
line 269
;269:	cg.refdefViewAngles[PITCH] = -180 / M_PI * atan2(focusPoint[2], focusDist);
ADDRLP4 12+8
INDIRF4
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 172
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRGP4 cg+109424
ADDRLP4 172
INDIRF4
CNSTF4 3261411041
MULF4
ASGNF4
line 270
;270:	cg.refdefViewAngles[YAW] -= cg_thirdPersonAngle.value;
ADDRLP4 176
ADDRGP4 cg+109424+4
ASGNP4
ADDRLP4 176
INDIRP4
ADDRLP4 176
INDIRP4
INDIRF4
ADDRGP4 cg_thirdPersonAngle+8
INDIRF4
SUBF4
ASGNF4
line 271
;271:}
LABELV $255
endproc CG_OffsetThirdPersonView 180 28
proc CG_StepOffset 8 0
line 275
;272:
;273:
;274:// this causes a compiler bug on mac MrC compiler
;275:static void CG_StepOffset(void) {
line 279
;276:	int		timeDelta;
;277:
;278:	// smooth out stair climbing
;279:	timeDelta = cg.time - cg.stepTime;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+108936
INDIRI4
SUBI4
ASGNI4
line 280
;280:	if (timeDelta < STEP_TIME) {
ADDRLP4 0
INDIRI4
CNSTI4 200
GEI4 $360
line 281
;281:		cg.refdef.vieworg[2] -= cg.stepChange
ADDRLP4 4
ADDRGP4 cg+109056+24+8
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 cg+108932
INDIRF4
CNSTI4 200
ADDRLP4 0
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1000593162
MULF4
SUBF4
ASGNF4
line 283
;282:			* (STEP_TIME - timeDelta) / STEP_TIME;
;283:	}
LABELV $360
line 284
;284:}
LABELV $357
endproc CG_StepOffset 8 0
proc CG_OffsetFirstPersonView 96 0
line 292
;285:
;286:/*
;287:===============
;288:CG_OffsetFirstPersonView
;289:
;290:===============
;291:*/
;292:static void CG_OffsetFirstPersonView(void) {
line 303
;293:	float *origin;
;294:	float *angles;
;295:	float			bob;
;296:	float			ratio;
;297:	float			delta;
;298:	float			speed;
;299:	float			f;
;300:	vec3_t			predictedVelocity;
;301:	int				timeDelta;
;302:
;303:	if (cg.snap->ps.pm_type == PM_INTERMISSION) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $367
line 304
;304:		return;
ADDRGP4 $366
JUMPV
LABELV $367
line 307
;305:	}
;306:
;307:	origin = cg.refdef.vieworg;
ADDRLP4 8
ADDRGP4 cg+109056+24
ASGNP4
line 308
;308:	angles = cg.refdefViewAngles;
ADDRLP4 4
ADDRGP4 cg+109424
ASGNP4
line 311
;309:
;310:	// if dead, fix the angle and don't add any kick
;311:	if (cg.snap->ps.stats[STAT_HEALTH] <= 0) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
GTI4 $373
line 312
;312:		angles[ROLL] = 40;
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1109393408
ASGNF4
line 313
;313:		angles[PITCH] = -15;
ADDRLP4 4
INDIRP4
CNSTF4 3245342720
ASGNF4
line 314
;314:		angles[YAW] = cg.snap->ps.stats[STAT_DEAD_YAW];
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 315
;315:		origin[2] += cg.predictedPlayerState.viewheight;
ADDRLP4 44
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
ADDRGP4 cg+107636+164
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 316
;316:		return;
ADDRGP4 $366
JUMPV
LABELV $373
line 320
;317:	}
;318:
;319:	// add angles based on weapon kick
;320:	VectorAdd(angles, cg.kick_angles, angles);
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 cg+125848
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 cg+125848+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 cg+125848+8
INDIRF4
ADDF4
ASGNF4
line 323
;321:
;322:	// add angles based on damage kick
;323:	if (cg.damageTime) {
ADDRGP4 cg+125792
INDIRI4
CNSTI4 0
EQI4 $384
line 324
;324:		ratio = cg.time - cg.damageTime;
ADDRLP4 32
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+125792
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 325
;325:		if (ratio < DAMAGE_DEFLECT_TIME) {
ADDRLP4 32
INDIRF4
CNSTF4 1120403456
GEF4 $389
line 326
;326:			ratio /= DAMAGE_DEFLECT_TIME;
ADDRLP4 32
ADDRLP4 32
INDIRF4
CNSTF4 1008981770
MULF4
ASGNF4
line 327
;327:			angles[PITCH] += ratio * cg.v_dmg_pitch;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRGP4 cg+125840
INDIRF4
MULF4
ADDF4
ASGNF4
line 328
;328:			angles[ROLL] += ratio * cg.v_dmg_roll;
ADDRLP4 60
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRGP4 cg+125844
INDIRF4
MULF4
ADDF4
ASGNF4
line 329
;329:		} else {
ADDRGP4 $390
JUMPV
LABELV $389
line 330
;330:			ratio = 1.0 - (ratio - DAMAGE_DEFLECT_TIME) / DAMAGE_RETURN_TIME;
ADDRLP4 32
CNSTF4 1065353216
ADDRLP4 32
INDIRF4
CNSTF4 1120403456
SUBF4
CNSTF4 992204554
MULF4
SUBF4
ASGNF4
line 331
;331:			if (ratio > 0) {
ADDRLP4 32
INDIRF4
CNSTF4 0
LEF4 $393
line 332
;332:				angles[PITCH] += ratio * cg.v_dmg_pitch;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRGP4 cg+125840
INDIRF4
MULF4
ADDF4
ASGNF4
line 333
;333:				angles[ROLL] += ratio * cg.v_dmg_roll;
ADDRLP4 60
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 32
INDIRF4
ADDRGP4 cg+125844
INDIRF4
MULF4
ADDF4
ASGNF4
line 334
;334:			}
LABELV $393
line 335
;335:		}
LABELV $390
line 336
;336:	}
LABELV $384
line 347
;337:
;338:	// add pitch based on fall kick
;339:#if 0
;340:	ratio = (cg.time - cg.landTime) / FALL_TIME;
;341:	if (ratio < 0)
;342:		ratio = 0;
;343:	angles[PITCH] += ratio * cg.fall_value;
;344:#endif
;345:
;346:	// add angles based on velocity
;347:	VectorCopy(cg.predictedPlayerState.velocity, predictedVelocity);
ADDRLP4 12
ADDRGP4 cg+107636+32
INDIRB
ASGNB 12
line 349
;348:
;349:	delta = DotProduct(predictedVelocity, cg.refdef.viewaxis[0]);
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRGP4 cg+109056+36
INDIRF4
MULF4
ADDRLP4 12+4
INDIRF4
ADDRGP4 cg+109056+36+4
INDIRF4
MULF4
ADDF4
ADDRLP4 12+8
INDIRF4
ADDRGP4 cg+109056+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 350
;350:	angles[PITCH] += delta * cg_runpitch.value;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDRGP4 cg_runpitch+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 352
;351:
;352:	delta = DotProduct(predictedVelocity, cg.refdef.viewaxis[1]);
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRGP4 cg+109056+36+12
INDIRF4
MULF4
ADDRLP4 12+4
INDIRF4
ADDRGP4 cg+109056+36+12+4
INDIRF4
MULF4
ADDF4
ADDRLP4 12+8
INDIRF4
ADDRGP4 cg+109056+36+12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 353
;353:	angles[ROLL] -= delta * cg_runroll.value;
ADDRLP4 60
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDRGP4 cg_runroll+8
INDIRF4
MULF4
SUBF4
ASGNF4
line 358
;354:
;355:	// add angles based on bob
;356:
;357:	// make sure the bob is visible even at low speeds
;358:	speed = cg.xyspeed > 200 ? cg.xyspeed : 200;
ADDRGP4 cg+125880
INDIRF4
CNSTF4 1128792064
LEF4 $427
ADDRLP4 64
ADDRGP4 cg+125880
INDIRF4
ASGNF4
ADDRGP4 $428
JUMPV
LABELV $427
ADDRLP4 64
CNSTF4 1128792064
ASGNF4
LABELV $428
ADDRLP4 28
ADDRLP4 64
INDIRF4
ASGNF4
line 360
;359:
;360:	delta = cg.bobfracsin * cg_bobpitch.value * speed;
ADDRLP4 0
ADDRGP4 cg+125872
INDIRF4
ADDRGP4 cg_bobpitch+8
INDIRF4
MULF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 361
;361:	if (cg.predictedPlayerState.pm_flags & PMF_DUCKED)
ADDRGP4 cg+107636+12
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $431
line 362
;362:		delta *= 3;		// crouching
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1077936128
MULF4
ASGNF4
LABELV $431
line 363
;363:	angles[PITCH] += delta;
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 364
;364:	delta = cg.bobfracsin * cg_bobroll.value * speed;
ADDRLP4 0
ADDRGP4 cg+125872
INDIRF4
ADDRGP4 cg_bobroll+8
INDIRF4
MULF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 365
;365:	if (cg.predictedPlayerState.pm_flags & PMF_DUCKED)
ADDRGP4 cg+107636+12
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $437
line 366
;366:		delta *= 3;		// crouching accentuates roll
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1077936128
MULF4
ASGNF4
LABELV $437
line 367
;367:	if (cg.bobcycle & 1)
ADDRGP4 cg+125876
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $441
line 368
;368:		delta = -delta;
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
LABELV $441
line 369
;369:	angles[ROLL] += delta;
ADDRLP4 72
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ASGNF4
line 374
;370:
;371:	//===================================
;372:
;373:		// add view height
;374:	origin[2] += cg.predictedPlayerState.viewheight;
ADDRLP4 76
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRGP4 cg+107636+164
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 377
;375:
;376:	// smooth out duck height changes
;377:	timeDelta = cg.time - cg.duckTime;
ADDRLP4 36
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+108944
INDIRI4
SUBI4
ASGNI4
line 378
;378:	if (timeDelta < DUCK_TIME) {
ADDRLP4 36
INDIRI4
CNSTI4 100
GEI4 $448
line 379
;379:		cg.refdef.vieworg[2] -= cg.duckChange
ADDRLP4 80
ADDRGP4 cg+109056+24+8
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
ADDRGP4 cg+108940
INDIRF4
CNSTI4 100
ADDRLP4 36
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1008981770
MULF4
SUBF4
ASGNF4
line 381
;380:			* (DUCK_TIME - timeDelta) / DUCK_TIME;
;381:	}
LABELV $448
line 384
;382:
;383:	// add bob height
;384:	bob = cg.bobfracsin * cg.xyspeed * cg_bobup.value;
ADDRLP4 24
ADDRGP4 cg+125872
INDIRF4
ADDRGP4 cg+125880
INDIRF4
MULF4
ADDRGP4 cg_bobup+8
INDIRF4
MULF4
ASGNF4
line 385
;385:	if (bob > 6) {
ADDRLP4 24
INDIRF4
CNSTF4 1086324736
LEF4 $457
line 386
;386:		bob = 6;
ADDRLP4 24
CNSTF4 1086324736
ASGNF4
line 387
;387:	}
LABELV $457
line 389
;388:
;389:	origin[2] += bob;
ADDRLP4 80
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
ADDRLP4 24
INDIRF4
ADDF4
ASGNF4
line 393
;390:
;391:
;392:	// add fall height
;393:	delta = cg.time - cg.landTime;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+108952
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 394
;394:	if (delta < LAND_DEFLECT_TIME) {
ADDRLP4 0
INDIRF4
CNSTF4 1125515264
GEF4 $461
line 395
;395:		f = delta / LAND_DEFLECT_TIME;
ADDRLP4 40
ADDRLP4 0
INDIRF4
CNSTF4 1004172302
MULF4
ASGNF4
line 396
;396:		cg.refdef.vieworg[2] += cg.landChange * f;
ADDRLP4 84
ADDRGP4 cg+109056+24+8
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRGP4 cg+108948
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ADDF4
ASGNF4
line 397
;397:	} else if (delta < LAND_DEFLECT_TIME + LAND_RETURN_TIME) {
ADDRGP4 $462
JUMPV
LABELV $461
ADDRLP4 0
INDIRF4
CNSTF4 1138819072
GEF4 $467
line 398
;398:		delta -= LAND_DEFLECT_TIME;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1125515264
SUBF4
ASGNF4
line 399
;399:		f = 1.0 - (delta / LAND_RETURN_TIME);
ADDRLP4 40
CNSTF4 1065353216
ADDRLP4 0
INDIRF4
CNSTF4 995783694
MULF4
SUBF4
ASGNF4
line 400
;400:		cg.refdef.vieworg[2] += cg.landChange * f;
ADDRLP4 84
ADDRGP4 cg+109056+24+8
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRGP4 cg+108948
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ADDF4
ASGNF4
line 401
;401:	}
LABELV $467
LABELV $462
line 404
;402:
;403:	// add step offset
;404:	CG_StepOffset();
ADDRGP4 CG_StepOffset
CALLV
pop
line 408
;405:
;406:	// add kick offset
;407:
;408:	VectorAdd(origin, cg.kick_origin, origin);
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRGP4 cg+125860
INDIRF4
ADDF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 cg+125860+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 cg+125860+8
INDIRF4
ADDF4
ASGNF4
line 422
;409:
;410:	// pivot the eye based on a neck length
;411:#if 0
;412:	{
;413:#define	NECK_LENGTH		8
;414:		vec3_t			forward, up;
;415:
;416:		cg.refdef.vieworg[2] -= NECK_LENGTH;
;417:		AngleVectors(cg.refdefViewAngles, forward, NULL, up);
;418:		VectorMA(cg.refdef.vieworg, 3, forward, cg.refdef.vieworg);
;419:		VectorMA(cg.refdef.vieworg, NECK_LENGTH, up, cg.refdef.vieworg);
;420:	}
;421:#endif
;422:}
LABELV $366
endproc CG_OffsetFirstPersonView 96 0
export CG_ZoomDown_f
proc CG_ZoomDown_f 0 0
line 426
;423:
;424://======================================================================
;425:
;426:void CG_ZoomDown_f(void) {
line 427
;427:	if (cg.zoomed) {
ADDRGP4 cg+109436
INDIRI4
CNSTI4 0
EQI4 $479
line 428
;428:		return;
ADDRGP4 $478
JUMPV
LABELV $479
line 430
;429:	}
;430:	cg.zoomed = qtrue;
ADDRGP4 cg+109436
CNSTI4 1
ASGNI4
line 431
;431:	cg.zoomTime = cg.time;
ADDRGP4 cg+109440
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 432
;432:}
LABELV $478
endproc CG_ZoomDown_f 0 0
export CG_ZoomUp_f
proc CG_ZoomUp_f 0 0
line 434
;433:
;434:void CG_ZoomUp_f(void) {
line 435
;435:	if (!cg.zoomed) {
ADDRGP4 cg+109436
INDIRI4
CNSTI4 0
NEI4 $486
line 436
;436:		return;
ADDRGP4 $485
JUMPV
LABELV $486
line 438
;437:	}
;438:	cg.zoomed = qfalse;
ADDRGP4 cg+109436
CNSTI4 0
ASGNI4
line 439
;439:	cg.zoomTime = cg.time;
ADDRGP4 cg+109440
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 440
;440:}
LABELV $485
endproc CG_ZoomUp_f 0 0
proc CG_CalcFov 68 8
line 453
;441:
;442:
;443:/*
;444:====================
;445:CG_CalcFov
;446:
;447:Fixed fov at intermissions, otherwise account for fov variable and zooms.
;448:====================
;449:*/
;450:#define	WAVE_AMPLITUDE	1
;451:#define	WAVE_FREQUENCY	0.4
;452:
;453:static int CG_CalcFov(void) {
line 464
;454:	float	x;
;455:	//float	phase;
;456:	float	v;
;457:	int		contents;
;458:	float	fov_x, fov_y;
;459:	float	zoomFov;
;460:	float	f;
;461:	int		inwater;
;462:
;463:	// Based on LordHavoc's code for Darkplaces
;464:	const float baseAspect = 0.75f; // 3/4
ADDRLP4 20
CNSTF4 1061158912
ASGNF4
line 465
;465:	const float aspect = (float)cg.refdef.width / (float)cg.refdef.height;
ADDRLP4 24
ADDRGP4 cg+109056+8
INDIRI4
CVIF4 4
ADDRGP4 cg+109056+12
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 466
;466:	const float desiredFov = fov_x;
ADDRLP4 28
ADDRLP4 0
INDIRF4
ASGNF4
line 468
;467:
;468:	cgs.fov = cg_fov.value;
ADDRGP4 cgs+149984
ADDRGP4 cg_fov+8
INDIRF4
ASGNF4
line 469
;469:	if (cgs.fov < 1.0)
ADDRGP4 cgs+149984
INDIRF4
CNSTF4 1065353216
GEF4 $499
line 470
;470:		cgs.fov = 1.0;
ADDRGP4 cgs+149984
CNSTF4 1065353216
ASGNF4
ADDRGP4 $500
JUMPV
LABELV $499
line 471
;471:	else if (cgs.fov > 160.0)
ADDRGP4 cgs+149984
INDIRF4
CNSTF4 1126170624
LEF4 $503
line 472
;472:		cgs.fov = 160.0;
ADDRGP4 cgs+149984
CNSTF4 1126170624
ASGNF4
LABELV $503
LABELV $500
line 474
;473:
;474:	cgs.zoomFov = cg_zoomFov.value;
ADDRGP4 cgs+149988
ADDRGP4 cg_zoomFov+8
INDIRF4
ASGNF4
line 475
;475:	if (cgs.zoomFov < 1.0)
ADDRGP4 cgs+149988
INDIRF4
CNSTF4 1065353216
GEF4 $509
line 476
;476:		cgs.zoomFov = 1.0;
ADDRGP4 cgs+149988
CNSTF4 1065353216
ASGNF4
ADDRGP4 $510
JUMPV
LABELV $509
line 477
;477:	else if (cgs.zoomFov > 160.0)
ADDRGP4 cgs+149988
INDIRF4
CNSTF4 1126170624
LEF4 $513
line 478
;478:		cgs.zoomFov = 160.0;
ADDRGP4 cgs+149988
CNSTF4 1126170624
ASGNF4
LABELV $513
LABELV $510
line 480
;479:
;480:	if (cg.predictedPlayerState.pm_type == PM_INTERMISSION) {
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 5
NEI4 $517
line 482
;481:		// if in intermission, use a fixed value
;482:		fov_x = 90;
ADDRLP4 0
CNSTF4 1119092736
ASGNF4
line 483
;483:	} else {
ADDRGP4 $518
JUMPV
LABELV $517
line 485
;484:		// user selectable
;485:		fov_x = cgs.fov;
ADDRLP4 0
ADDRGP4 cgs+149984
INDIRF4
ASGNF4
line 488
;486:
;487:		// account for zooms
;488:		zoomFov = cgs.zoomFov;
ADDRLP4 40
ADDRGP4 cgs+149988
INDIRF4
ASGNF4
line 490
;489:
;490:		if (cg.zoomed) {
ADDRGP4 cg+109436
INDIRI4
CNSTI4 0
EQI4 $523
line 491
;491:			f = (cg.time - cg.zoomTime) / (float)ZOOM_TIME;
ADDRLP4 36
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+109440
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1004172302
MULF4
ASGNF4
line 492
;492:			if (f > 1.0) {
ADDRLP4 36
INDIRF4
CNSTF4 1065353216
LEF4 $528
line 493
;493:				fov_x = zoomFov;
ADDRLP4 0
ADDRLP4 40
INDIRF4
ASGNF4
line 494
;494:			} else {
ADDRGP4 $524
JUMPV
LABELV $528
line 495
;495:				fov_x = fov_x + f * (zoomFov - fov_x);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRF4
ADDRLP4 40
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 496
;496:			}
line 497
;497:		} else {
ADDRGP4 $524
JUMPV
LABELV $523
line 498
;498:			f = (cg.time - cg.zoomTime) / (float)ZOOM_TIME;
ADDRLP4 36
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+109440
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1004172302
MULF4
ASGNF4
line 499
;499:			if (f > 1.0) {
ADDRLP4 36
INDIRF4
CNSTF4 1065353216
LEF4 $532
line 501
;500:				//fov_x = fov_x;
;501:			} else {
ADDRGP4 $533
JUMPV
LABELV $532
line 502
;502:				fov_x = zoomFov + f * (fov_x - zoomFov);
ADDRLP4 44
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 44
INDIRF4
ADDRLP4 36
INDIRF4
ADDRLP4 0
INDIRF4
ADDRLP4 44
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 503
;503:			}
LABELV $533
line 504
;504:		}
LABELV $524
line 505
;505:	}
LABELV $518
line 507
;506:
;507:	fov_x = atan2(tan(desiredFov * M_PI / 360.0f) * baseAspect * aspect, 1) * 360.0f / M_PI;
ADDRLP4 28
INDIRF4
CNSTF4 1007614517
MULF4
ARGF4
ADDRLP4 44
ADDRGP4 tan
CALLF4
ASGNF4
ADDRLP4 44
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDRLP4 24
INDIRF4
MULF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 48
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 48
INDIRF4
CNSTF4 1122316001
MULF4
ASGNF4
line 509
;508:
;509:	x = cg.refdef.width / tan(fov_x / 360 * M_PI);
ADDRLP4 0
INDIRF4
CNSTF4 1007614517
MULF4
ARGF4
ADDRLP4 52
ADDRGP4 tan
CALLF4
ASGNF4
ADDRLP4 8
ADDRGP4 cg+109056+8
INDIRI4
CVIF4 4
ADDRLP4 52
INDIRF4
DIVF4
ASGNF4
line 510
;510:	fov_y = atan2(cg.refdef.height, x);
ADDRGP4 cg+109056+12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 56
ADDRGP4 atan2
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 56
INDIRF4
ASGNF4
line 511
;511:	fov_y = fov_y * 360 / M_PI;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1122316001
MULF4
ASGNF4
line 514
;512:
;513:	// warp if underwater
;514:	contents = CG_PointContents(cg.refdef.vieworg, -1);
ADDRGP4 cg+109056+24
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 60
ADDRGP4 CG_PointContents
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 60
INDIRI4
ASGNI4
line 515
;515:	if (contents & (CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA)) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $540
line 518
;516:		//phase = cg.time / 1000.0 * WAVE_FREQUENCY * M_PI * 2;
;517:		//v = WAVE_AMPLITUDE * sin( phase );
;518:		v = WAVE_AMPLITUDE * sin((cg.time % 16419587) / 397.87735f); // result is very close to original
ADDRGP4 cg+107604
INDIRI4
CNSTI4 16419587
MODI4
CVIF4 4
CNSTF4 992261838
MULF4
ARGF4
ADDRLP4 64
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 64
INDIRF4
CNSTF4 1065353216
MULF4
ASGNF4
line 519
;519:		fov_x += v;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ASGNF4
line 520
;520:		fov_y -= v;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 32
INDIRF4
SUBF4
ASGNF4
line 521
;521:		inwater = qtrue;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 522
;522:	} else {
ADDRGP4 $541
JUMPV
LABELV $540
line 523
;523:		inwater = qfalse;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 524
;524:	}
LABELV $541
line 528
;525:
;526:
;527:	// set it
;528:	cg.refdef.fov_x = fov_x;
ADDRGP4 cg+109056+16
ADDRLP4 0
INDIRF4
ASGNF4
line 529
;529:	cg.refdef.fov_y = fov_y;
ADDRGP4 cg+109056+20
ADDRLP4 4
INDIRF4
ASGNF4
line 531
;530:
;531:	if (!cg.zoomed) {
ADDRGP4 cg+109436
INDIRI4
CNSTI4 0
NEI4 $547
line 532
;532:		cg.zoomSensitivity = 1;
ADDRGP4 cg+109444
CNSTF4 1065353216
ASGNF4
line 533
;533:	} else {
ADDRGP4 $548
JUMPV
LABELV $547
line 534
;534:		cg.zoomSensitivity = cg.refdef.fov_y / 75.0;
ADDRGP4 cg+109444
ADDRGP4 cg+109056+20
INDIRF4
CNSTF4 1012560910
MULF4
ASGNF4
line 535
;535:	}
LABELV $548
line 537
;536:
;537:	return inwater;
ADDRLP4 16
INDIRI4
RETI4
LABELV $492
endproc CG_CalcFov 68 8
proc CG_DamageBlendBlob 164 12
line 548
;538:}
;539:
;540:
;541:
;542:/*
;543:===============
;544:CG_DamageBlendBlob
;545:
;546:===============
;547:*/
;548:static void CG_DamageBlendBlob(void) {
line 553
;549:	int			t;
;550:	int			maxTime;
;551:	refEntity_t		ent;
;552:
;553:	if (!cg_blood.integer) {
ADDRGP4 cg_blood+12
INDIRI4
CNSTI4 0
NEI4 $555
line 554
;554:		return;
ADDRGP4 $554
JUMPV
LABELV $555
line 557
;555:	}
;556:
;557:	if (!cg.damageValue) {
ADDRGP4 cg+125804
INDIRF4
CNSTF4 0
NEF4 $558
line 558
;558:		return;
ADDRGP4 $554
JUMPV
LABELV $558
line 566
;559:	}
;560:
;561:	//if (cg.cameraMode) {
;562:	//	return;
;563:	//}
;564:
;565:	// ragePro systems can't fade blends, so don't obscure the screen
;566:	if (cgs.glconfig.hardwareType == GLHW_RAGEPRO) {
ADDRGP4 cgs+20100+11288
INDIRI4
CNSTI4 3
NEI4 $561
line 567
;567:		return;
ADDRGP4 $554
JUMPV
LABELV $561
line 570
;568:	}
;569:
;570:	maxTime = DAMAGE_TIME;
ADDRLP4 144
CNSTI4 500
ASGNI4
line 571
;571:	t = cg.time - cg.damageTime;
ADDRLP4 140
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+125792
INDIRI4
SUBI4
ASGNI4
line 572
;572:	if (t <= 0 || t >= maxTime) {
ADDRLP4 140
INDIRI4
CNSTI4 0
LEI4 $569
ADDRLP4 140
INDIRI4
ADDRLP4 144
INDIRI4
LTI4 $567
LABELV $569
line 573
;573:		return;
ADDRGP4 $554
JUMPV
LABELV $567
line 577
;574:	}
;575:
;576:
;577:	memset(&ent, 0, sizeof(ent));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 578
;578:	ent.reType = RT_SPRITE;
ADDRLP4 0
CNSTI4 2
ASGNI4
line 579
;579:	ent.renderfx = RF_FIRST_PERSON;
ADDRLP4 0+4
CNSTI4 4
ASGNI4
line 581
;580:
;581:	VectorMA(cg.refdef.vieworg, 8, cg.refdef.viewaxis[0], ent.origin);
ADDRLP4 0+68
ADDRGP4 cg+109056+24
INDIRF4
ADDRGP4 cg+109056+36
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRGP4 cg+109056+24+4
INDIRF4
ADDRGP4 cg+109056+36+4
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRGP4 cg+109056+24+8
INDIRF4
ADDRGP4 cg+109056+36+8
INDIRF4
CNSTF4 1090519040
MULF4
ADDF4
ASGNF4
line 582
;582:	VectorMA(ent.origin, cg.damageX * -8, cg.refdef.viewaxis[1], ent.origin);
ADDRLP4 0+68
ADDRLP4 0+68
INDIRF4
ADDRGP4 cg+109056+36+12
INDIRF4
ADDRGP4 cg+125796
INDIRF4
CNSTF4 3238002688
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRLP4 0+68+4
INDIRF4
ADDRGP4 cg+109056+36+12+4
INDIRF4
ADDRGP4 cg+125796
INDIRF4
CNSTF4 3238002688
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
ADDRGP4 cg+109056+36+12+8
INDIRF4
ADDRGP4 cg+125796
INDIRF4
CNSTF4 3238002688
MULF4
MULF4
ADDF4
ASGNF4
line 583
;583:	VectorMA(ent.origin, cg.damageY * 8, cg.refdef.viewaxis[2], ent.origin);
ADDRLP4 0+68
ADDRLP4 0+68
INDIRF4
ADDRGP4 cg+109056+36+24
INDIRF4
ADDRGP4 cg+125800
INDIRF4
CNSTF4 1090519040
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+4
ADDRLP4 0+68+4
INDIRF4
ADDRGP4 cg+109056+36+24+4
INDIRF4
ADDRGP4 cg+125800
INDIRF4
CNSTF4 1090519040
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+68+8
ADDRLP4 0+68+8
INDIRF4
ADDRGP4 cg+109056+36+24+8
INDIRF4
ADDRGP4 cg+125800
INDIRF4
CNSTF4 1090519040
MULF4
MULF4
ADDF4
ASGNF4
line 585
;584:
;585:	ent.radius = cg.damageValue * 3;
ADDRLP4 0+132
ADDRGP4 cg+125804
INDIRF4
CNSTF4 1077936128
MULF4
ASGNF4
line 586
;586:	ent.customShader = cgs.media.viewBloodShader;
ADDRLP4 0+112
ADDRGP4 cgs+148744+248
INDIRI4
ASGNI4
line 587
;587:	ent.shaderRGBA[0] = 255;
ADDRLP4 0+116
CNSTU1 255
ASGNU1
line 588
;588:	ent.shaderRGBA[1] = 255;
ADDRLP4 0+116+1
CNSTU1 255
ASGNU1
line 589
;589:	ent.shaderRGBA[2] = 255;
ADDRLP4 0+116+2
CNSTU1 255
ASGNU1
line 590
;590:	ent.shaderRGBA[3] = 200 * (1.0 - ((float)t / maxTime));
ADDRLP4 156
CNSTF4 1065353216
ADDRLP4 140
INDIRI4
CVIF4 4
ADDRLP4 144
INDIRI4
CVIF4 4
DIVF4
SUBF4
CNSTF4 1128792064
MULF4
ASGNF4
ADDRLP4 160
CNSTF4 1325400064
ASGNF4
ADDRLP4 156
INDIRF4
ADDRLP4 160
INDIRF4
LTF4 $653
ADDRLP4 152
ADDRLP4 156
INDIRF4
ADDRLP4 160
INDIRF4
SUBF4
CVFI4 4
CVIU4 4
CNSTU4 2147483648
ADDU4
ASGNU4
ADDRGP4 $654
JUMPV
LABELV $653
ADDRLP4 152
ADDRLP4 156
INDIRF4
CVFI4 4
CVIU4 4
ASGNU4
LABELV $654
ADDRLP4 0+116+3
ADDRLP4 152
INDIRU4
CVUU1 4
ASGNU1
line 591
;591:	trap_R_AddRefEntityToScene(&ent);
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 592
;592:}
LABELV $554
endproc CG_DamageBlendBlob 164 12
proc CG_CalcViewValues 32 12
line 602
;593:
;594:
;595:/*
;596:===============
;597:CG_CalcViewValues
;598:
;599:Sets cg.refdef view values
;600:===============
;601:*/
;602:static int CG_CalcViewValues(void) {
line 605
;603:	playerState_t *ps;
;604:
;605:	memset(&cg.refdef, 0, sizeof(cg.refdef));
ADDRGP4 cg+109056
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 612
;606:
;607:	// strings for in game rendering
;608:	// Q_strncpyz( cg.refdef.text[0], "Park Ranger", sizeof(cg.refdef.text[0]) );
;609:	// Q_strncpyz( cg.refdef.text[1], "19", sizeof(cg.refdef.text[1]) );
;610:
;611:	// calculate size of 3D view
;612:	CG_CalcVrect();
ADDRGP4 CG_CalcVrect
CALLV
pop
line 614
;613:
;614:	ps = &cg.predictedPlayerState;
ADDRLP4 0
ADDRGP4 cg+107636
ASGNP4
line 630
;615:	/*
;616:		if (cg.cameraMode) {
;617:			vec3_t origin, angles;
;618:			if (trap_getCameraInfo(cg.time, &origin, &angles)) {
;619:				VectorCopy(origin, cg.refdef.vieworg);
;620:				angles[ROLL] = 0;
;621:				VectorCopy(angles, cg.refdefViewAngles);
;622:				AnglesToAxis( cg.refdefViewAngles, cg.refdef.viewaxis );
;623:				return CG_CalcFov();
;624:			} else {
;625:				cg.cameraMode = qfalse;
;626:			}
;627:		}
;628:	*/
;629:	// intermission view
;630:	if (ps->pm_type == PM_INTERMISSION) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 5
NEI4 $659
line 631
;631:		VectorCopy(ps->origin, cg.refdef.vieworg);
ADDRGP4 cg+109056+24
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 632
;632:		VectorCopy(ps->viewangles, cg.refdefViewAngles);
ADDRGP4 cg+109424
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRB
ASGNB 12
line 633
;633:		AnglesToAxis(cg.refdefViewAngles, cg.refdef.viewaxis);
ADDRGP4 cg+109424
ARGP4
ADDRGP4 cg+109056+36
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 634
;634:		return CG_CalcFov();
ADDRLP4 4
ADDRGP4 CG_CalcFov
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $655
JUMPV
LABELV $659
line 637
;635:	}
;636:
;637:	cg.bobcycle = (ps->bobCycle & 128) >> 7;
ADDRGP4 cg+125876
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 7
RSHI4
ASGNI4
line 638
;638:	cg.bobfracsin = fabs(sin((ps->bobCycle & 127) / 127.0 * M_PI));
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 127
BANDI4
CVIF4 4
CNSTF4 1019913509
MULF4
ARGF4
ADDRLP4 4
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRGP4 cg+125872
ADDRLP4 8
INDIRF4
ASGNF4
line 639
;639:	cg.xyspeed = sqrt(ps->velocity[0] * ps->velocity[0] +
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
MULF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
MULF4
ADDF4
ARGF4
ADDRLP4 16
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRGP4 cg+125880
ADDRLP4 16
INDIRF4
ASGNF4
line 643
;640:		ps->velocity[1] * ps->velocity[1]);
;641:
;642:
;643:	VectorCopy(ps->origin, cg.refdef.vieworg);
ADDRGP4 cg+109056+24
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 644
;644:	VectorCopy(ps->viewangles, cg.refdefViewAngles);
ADDRGP4 cg+109424
ADDRLP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRB
ASGNB 12
line 647
;645:
;646:	// add error decay
;647:	if (cg_errorDecay.value > 0) {
ADDRGP4 cg_errorDecay+8
INDIRF4
CNSTF4 0
LEF4 $673
line 651
;648:		int		t;
;649:		float	f;
;650:
;651:		t = cg.time - cg.predictedErrorTime;
ADDRLP4 24
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+108848
INDIRI4
SUBI4
ASGNI4
line 652
;652:		f = (cg_errorDecay.value - t) / cg_errorDecay.value;
ADDRLP4 20
ADDRGP4 cg_errorDecay+8
INDIRF4
ADDRLP4 24
INDIRI4
CVIF4 4
SUBF4
ADDRGP4 cg_errorDecay+8
INDIRF4
DIVF4
ASGNF4
line 653
;653:		if (f > 0 && f < 1) {
ADDRLP4 28
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 28
INDIRF4
CNSTF4 0
LEF4 $680
ADDRLP4 28
INDIRF4
CNSTF4 1065353216
GEF4 $680
line 654
;654:			VectorMA(cg.refdef.vieworg, f, cg.predictedError, cg.refdef.vieworg);
ADDRGP4 cg+109056+24
ADDRGP4 cg+109056+24
INDIRF4
ADDRGP4 cg+108852
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109056+24+4
ADDRGP4 cg+109056+24+4
INDIRF4
ADDRGP4 cg+108852+4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109056+24+8
ADDRGP4 cg+109056+24+8
INDIRF4
ADDRGP4 cg+108852+8
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 655
;655:		} else {
ADDRGP4 $681
JUMPV
LABELV $680
line 656
;656:			cg.predictedErrorTime = 0;
ADDRGP4 cg+108848
CNSTI4 0
ASGNI4
line 657
;657:		}
LABELV $681
line 658
;658:	}
LABELV $673
line 660
;659:
;660:	if (cg.renderingThirdPerson) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
EQI4 $704
line 662
;661:		// back away from character
;662:		CG_OffsetThirdPersonView();
ADDRGP4 CG_OffsetThirdPersonView
CALLV
pop
line 663
;663:	} else {
ADDRGP4 $705
JUMPV
LABELV $704
line 665
;664:		// offset for local bobbing and kicks
;665:		CG_OffsetFirstPersonView();
ADDRGP4 CG_OffsetFirstPersonView
CALLV
pop
line 666
;666:	}
LABELV $705
line 669
;667:
;668:	// position eye relative to origin
;669:	AnglesToAxis(cg.refdefViewAngles, cg.refdef.viewaxis);
ADDRGP4 cg+109424
ARGP4
ADDRGP4 cg+109056+36
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 671
;670:
;671:	if (cg.hyperspace) {
ADDRGP4 cg+107632
INDIRI4
CNSTI4 0
EQI4 $710
line 672
;672:		cg.refdef.rdflags |= RDF_NOWORLDMODEL | RDF_HYPERSPACE;
ADDRLP4 20
ADDRGP4 cg+109056+76
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 5
BORI4
ASGNI4
line 673
;673:	}
LABELV $710
line 676
;674:
;675:	// field of view
;676:	return CG_CalcFov();
ADDRLP4 20
ADDRGP4 CG_CalcFov
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
LABELV $655
endproc CG_CalcViewValues 32 12
proc CG_PowerupTimerSounds 12 16
line 685
;677:}
;678:
;679:
;680:/*
;681:=====================
;682:CG_PowerupTimerSounds
;683:=====================
;684:*/
;685:static void CG_PowerupTimerSounds(void) {
line 690
;686:	int		i;
;687:	int		t;
;688:
;689:	// powerup timers going away
;690:	for (i = 0; i < MAX_POWERUPS; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $716
line 691
;691:		t = cg.snap->ps.powerups[i];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 356
ADDP4
ADDP4
INDIRI4
ASGNI4
line 692
;692:		if (t <= cg.time) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GTI4 $721
line 693
;693:			continue;
ADDRGP4 $717
JUMPV
LABELV $721
line 695
;694:		}
;695:		if (t - cg.time >= POWERUP_BLINKS * POWERUP_BLINK_TIME) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CNSTI4 5000
LTI4 $724
line 696
;696:			continue;
ADDRGP4 $717
JUMPV
LABELV $724
line 698
;697:		}
;698:		if ((t - cg.time) / POWERUP_BLINK_TIME != (t - cg.oldTime) / POWERUP_BLINK_TIME) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
ADDRLP4 0
INDIRI4
ADDRGP4 cg+107608
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
EQI4 $727
line 699
;699:			trap_S_StartSound(NULL, cg.snap->ps.clientNum, CHAN_ITEM, cgs.media.wearOffSound);
CNSTP4 0
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 cgs+148744+636
INDIRI4
ARGI4
ADDRGP4 trap_S_StartSound
CALLV
pop
line 700
;700:		}
LABELV $727
line 701
;701:	}
LABELV $717
line 690
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 16
LTI4 $716
line 702
;702:}
LABELV $715
endproc CG_PowerupTimerSounds 12 16
export CG_AddBufferedSound
proc CG_AddBufferedSound 0 12
line 709
;703:
;704:/*
;705:=====================
;706:CG_AddBufferedSound
;707:=====================
;708:*/
;709:void CG_AddBufferedSound(sfxHandle_t sfx) {
line 710
;710:	if (!sfx)
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $735
line 711
;711:		return;
ADDRGP4 $734
JUMPV
LABELV $735
line 714
;712:
;713:	// clear all buffered sounds
;714:	if (sfx == -1) {
ADDRFP4 0
INDIRI4
CNSTI4 -1
NEI4 $737
line 715
;715:		cg.soundBufferIn = 0;
ADDRGP4 cg+125656
CNSTI4 0
ASGNI4
line 716
;716:		cg.soundBufferOut = 0;
ADDRGP4 cg+125660
CNSTI4 0
ASGNI4
line 717
;717:		memset(cg.soundBuffer, 0, sizeof(cg.soundBuffer));
ADDRGP4 cg+125668
ARGP4
CNSTI4 0
ARGI4
CNSTI4 80
ARGI4
ADDRGP4 memset
CALLP4
pop
line 718
;718:		return;
ADDRGP4 $734
JUMPV
LABELV $737
line 721
;719:	}
;720:
;721:	cg.soundBuffer[cg.soundBufferIn] = sfx;
ADDRGP4 cg+125656
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125668
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 722
;722:	cg.soundBufferIn = (cg.soundBufferIn + 1) % MAX_SOUNDBUFFER;
ADDRGP4 cg+125656
ADDRGP4 cg+125656
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 20
MODI4
ASGNI4
line 723
;723:	if (cg.soundBufferIn == cg.soundBufferOut) {
ADDRGP4 cg+125656
INDIRI4
ADDRGP4 cg+125660
INDIRI4
NEI4 $747
line 725
;724:		//cg.soundBufferOut++;
;725:		cg.soundBufferOut = (cg.soundBufferOut + 1) % MAX_SOUNDBUFFER;
ADDRGP4 cg+125660
ADDRGP4 cg+125660
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 20
MODI4
ASGNI4
line 726
;726:	}
LABELV $747
line 727
;727:}
LABELV $734
endproc CG_AddBufferedSound 0 12
proc CG_PlayBufferedSounds 0 8
line 734
;728:
;729:/*
;730:=====================
;731:CG_PlayBufferedSounds
;732:=====================
;733:*/
;734:static void CG_PlayBufferedSounds(void) {
line 735
;735:	if (cg.soundTime < cg.time) {
ADDRGP4 cg+125664
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $754
line 736
;736:		if (cg.soundBufferOut != cg.soundBufferIn && cg.soundBuffer[cg.soundBufferOut]) {
ADDRGP4 cg+125660
INDIRI4
ADDRGP4 cg+125656
INDIRI4
EQI4 $758
ADDRGP4 cg+125660
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125668
ADDP4
INDIRI4
CNSTI4 0
EQI4 $758
line 737
;737:			cg.soundPlaying = cg.soundBuffer[cg.soundBufferOut];
ADDRGP4 cg+125748
ADDRGP4 cg+125660
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125668
ADDP4
INDIRI4
ASGNI4
line 738
;738:			trap_S_StartLocalSound(cg.soundPlaying, CHAN_ANNOUNCER);
ADDRGP4 cg+125748
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 739
;739:			cg.soundBuffer[cg.soundBufferOut] = 0;
ADDRGP4 cg+125660
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+125668
ADDP4
CNSTI4 0
ASGNI4
line 740
;740:			cg.soundBufferOut = (cg.soundBufferOut + 1) % MAX_SOUNDBUFFER;
ADDRGP4 cg+125660
ADDRGP4 cg+125660
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 20
MODI4
ASGNI4
line 741
;741:			cg.soundTime = cg.time + 750;
ADDRGP4 cg+125664
ADDRGP4 cg+107604
INDIRI4
CNSTI4 750
ADDI4
ASGNI4
line 742
;742:		} else {
ADDRGP4 $759
JUMPV
LABELV $758
line 743
;743:			cg.soundPlaying = 0;
ADDRGP4 cg+125748
CNSTI4 0
ASGNI4
line 744
;744:		}
LABELV $759
line 745
;745:	}
LABELV $754
line 746
;746:}
LABELV $753
endproc CG_PlayBufferedSounds 0 8
proc CG_FirstFrame 28 12
line 758
;747:
;748://=========================================================================
;749:
;750:
;751:/*
;752:=================
;753:CG_FirstFrame
;754:
;755:Called once on first rendered frame
;756:=================
;757:*/
;758:static void CG_FirstFrame(void) {
line 759
;759:	CG_SetConfigValues();
ADDRGP4 CG_SetConfigValues
CALLV
pop
line 761
;760:
;761:	cgs.voteTime = atoi(CG_ConfigString(CS_VOTE_TIME));
CNSTI4 8
ARGI4
ADDRLP4 0
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31700
ADDRLP4 4
INDIRI4
ASGNI4
line 762
;762:	cgs.voteYes = atoi(CG_ConfigString(CS_VOTE_YES));
CNSTI4 10
ARGI4
ADDRLP4 8
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31704
ADDRLP4 12
INDIRI4
ASGNI4
line 763
;763:	cgs.voteNo = atoi(CG_ConfigString(CS_VOTE_NO));
CNSTI4 11
ARGI4
ADDRLP4 16
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31708
ADDRLP4 20
INDIRI4
ASGNI4
line 764
;764:	Q_strncpyz(cgs.voteString, CG_ConfigString(CS_VOTE_STRING), sizeof(cgs.voteString));
CNSTI4 9
ARGI4
ADDRLP4 24
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRGP4 cgs+31716
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 766
;765:
;766:	if (cgs.voteTime)
ADDRGP4 cgs+31700
INDIRI4
CNSTI4 0
EQI4 $781
line 767
;767:		cgs.voteModified = qtrue;
ADDRGP4 cgs+31712
CNSTI4 1
ASGNI4
ADDRGP4 $782
JUMPV
LABELV $781
line 769
;768:	else
;769:		cgs.voteModified = qfalse;
ADDRGP4 cgs+31712
CNSTI4 0
ASGNI4
LABELV $782
line 770
;770:}
LABELV $775
endproc CG_FirstFrame 28 12
export CG_DrawActiveFrame
proc CG_DrawActiveFrame 16 16
line 780
;771:
;772:
;773:/*
;774:=================
;775:CG_DrawActiveFrame
;776:
;777:Generates and draws a game scene and status information at the given time.
;778:=================
;779:*/
;780:void CG_DrawActiveFrame(int serverTime, stereoFrame_t stereoView, qboolean demoPlayback) {
line 783
;781:	int		inwater;
;782:
;783:	cg.time = serverTime;
ADDRGP4 cg+107604
ADDRFP4 0
INDIRI4
ASGNI4
line 784
;784:	cg.demoPlayback = demoPlayback;
ADDRGP4 cg+8
ADDRFP4 8
INDIRI4
ASGNI4
line 787
;785:
;786:	// update cvars
;787:	CG_UpdateCvars();
ADDRGP4 CG_UpdateCvars
CALLV
pop
line 791
;788:
;789:	// if we are only updating the screen as a loading
;790:	// pacifier, don't even try to read snapshots
;791:	if (cg.infoScreenText[0] != 0) {
ADDRGP4 cg+109448
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $789
line 792
;792:		CG_DrawInformation();
ADDRGP4 CG_DrawInformation
CALLV
pop
line 793
;793:		return;
ADDRGP4 $786
JUMPV
LABELV $789
line 798
;794:	}
;795:
;796:	// any looped sounds will be respecified as entities
;797:	// are added to the render list
;798:	trap_S_ClearLoopingSounds(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 trap_S_ClearLoopingSounds
CALLV
pop
line 801
;799:
;800:	// clear all the render lists
;801:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 804
;802:
;803:	// set up cg.snap and possibly cg.nextSnap
;804:	CG_ProcessSnapshots();
ADDRGP4 CG_ProcessSnapshots
CALLV
pop
line 808
;805:
;806:	// if we haven't received any snapshots yet, all
;807:	// we can draw is the information screen
;808:	if (!cg.snap || (cg.snap->snapFlags & SNAPFLAG_NOT_ACTIVE)) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $796
ADDRGP4 cg+36
INDIRP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $792
LABELV $796
line 809
;809:		CG_DrawInformation();
ADDRGP4 CG_DrawInformation
CALLV
pop
line 810
;810:		return;
ADDRGP4 $786
JUMPV
LABELV $792
line 814
;811:	}
;812:
;813:	// let the client system know what our weapon and zoom settings are
;814:	trap_SetUserCmdValue(cg.weaponSelect, cg.zoomSensitivity);
ADDRGP4 cg+108956
INDIRI4
ARGI4
ADDRGP4 cg+109444
INDIRF4
ARGF4
ADDRGP4 trap_SetUserCmdValue
CALLV
pop
line 816
;815:
;816:	if (cg.clientFrame == 0)
ADDRGP4 cg
INDIRI4
CNSTI4 0
NEI4 $799
line 817
;817:		CG_FirstFrame();
ADDRGP4 CG_FirstFrame
CALLV
pop
LABELV $799
line 820
;818:
;819:	// update cg.predictedPlayerState
;820:	CG_PredictPlayerState();
ADDRGP4 CG_PredictPlayerState
CALLV
pop
line 823
;821:
;822:	// decide on third person view
;823:	cg.renderingThirdPerson = cg_thirdPerson.integer || (cg.snap->ps.stats[STAT_HEALTH] <= 0);
ADDRGP4 cg_thirdPerson+12
INDIRI4
CNSTI4 0
NEI4 $807
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
GTI4 $805
LABELV $807
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRGP4 $806
JUMPV
LABELV $805
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $806
ADDRGP4 cg+107628
ADDRLP4 4
INDIRI4
ASGNI4
line 825
;824:
;825:	CG_TrackClientTeamChange();
ADDRGP4 CG_TrackClientTeamChange
CALLV
pop
line 828
;826:
;827:	// follow killer
;828:	if (cg.followTime && cg.followTime < cg.time) {
ADDRGP4 cg+157008
INDIRI4
CNSTI4 0
EQI4 $808
ADDRGP4 cg+157008
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $808
line 829
;829:		cg.followTime = 0;
ADDRGP4 cg+157008
CNSTI4 0
ASGNI4
line 830
;830:		if (!cg.demoPlayback) {
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
NEI4 $814
line 831
;831:			trap_SendConsoleCommand(va("follow %i\n", cg.followClient));
ADDRGP4 $817
ARGP4
ADDRGP4 cg+157012
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 832
;832:		}
LABELV $814
line 833
;833:	}
LABELV $808
line 836
;834:
;835:	// build cg.refdef
;836:	inwater = CG_CalcViewValues();
ADDRLP4 8
ADDRGP4 CG_CalcViewValues
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 839
;837:
;838:	// first person blend blobs, done after AnglesToAxis
;839:	if (!cg.renderingThirdPerson) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
NEI4 $819
line 840
;840:		CG_DamageBlendBlob();
ADDRGP4 CG_DamageBlendBlob
CALLV
pop
line 841
;841:	}
LABELV $819
line 844
;842:
;843:	// build the render lists
;844:	if (!cg.hyperspace) {
ADDRGP4 cg+107632
INDIRI4
CNSTI4 0
NEI4 $822
line 845
;845:		CG_AddPacketEntities();	// alter calcViewValues, so predicted player state is correct
ADDRGP4 CG_AddPacketEntities
CALLV
pop
line 846
;846:		CG_AddMarks();
ADDRGP4 CG_AddMarks
CALLV
pop
line 847
;847:		CG_AddParticles();
ADDRGP4 CG_AddParticles
CALLV
pop
line 848
;848:		CG_AddLocalEntities();
ADDRGP4 CG_AddLocalEntities
CALLV
pop
line 849
;849:	}
LABELV $822
line 850
;850:	CG_AddViewWeapon(&cg.predictedPlayerState);
ADDRGP4 cg+107636
ARGP4
ADDRGP4 CG_AddViewWeapon
CALLV
pop
line 853
;851:
;852:	// add buffered sounds
;853:	CG_PlayBufferedSounds();
ADDRGP4 CG_PlayBufferedSounds
CALLV
pop
line 856
;854:
;855:	// finish up the rest of the refdef
;856:	if (cg.testModelEntity.hModel) {
ADDRGP4 cg+125884+8
INDIRI4
CNSTI4 0
EQI4 $826
line 857
;857:		CG_AddTestModel();
ADDRGP4 CG_AddTestModel
CALLV
pop
line 858
;858:	}
LABELV $826
line 859
;859:	cg.refdef.time = cg.time;
ADDRGP4 cg+109056+72
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 860
;860:	memcpy(cg.refdef.areamask, cg.snap->areamask, sizeof(cg.refdef.areamask));
ADDRGP4 cg+109056+80
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 12
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 863
;861:
;862:	// warning sounds when powerup is wearing off
;863:	CG_PowerupTimerSounds();
ADDRGP4 CG_PowerupTimerSounds
CALLV
pop
line 866
;864:
;865:	// update audio positions
;866:	trap_S_Respatialize(cg.snap->ps.clientNum, cg.refdef.vieworg, cg.refdef.viewaxis, inwater);
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+109056+24
ARGP4
ADDRGP4 cg+109056+36
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 trap_S_Respatialize
CALLV
pop
line 869
;867:
;868:	// make sure the lagometerSample and frame timing isn't done twice when in stereo
;869:	if (stereoView != STEREO_RIGHT) {
ADDRFP4 4
INDIRI4
CNSTI4 2
EQI4 $843
line 870
;870:		cg.frametime = cg.time - cg.oldTime;
ADDRGP4 cg+107600
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+107608
INDIRI4
SUBI4
ASGNI4
line 871
;871:		if (cg.frametime < 0) {
ADDRGP4 cg+107600
INDIRI4
CNSTI4 0
GEI4 $848
line 872
;872:			cg.frametime = 0;
ADDRGP4 cg+107600
CNSTI4 0
ASGNI4
line 873
;873:		}
LABELV $848
line 874
;874:		cg.oldTime = cg.time;
ADDRGP4 cg+107608
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 875
;875:		CG_AddLagometerFrameInfo();
ADDRGP4 CG_AddLagometerFrameInfo
CALLV
pop
line 876
;876:	}
LABELV $843
line 877
;877:	if (cg_timescale.value != cg_timescaleFadeEnd.value) {
ADDRGP4 cg_timescale+8
INDIRF4
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
EQF4 $854
line 878
;878:		if (cg_timescale.value < cg_timescaleFadeEnd.value) {
ADDRGP4 cg_timescale+8
INDIRF4
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
GEF4 $858
line 879
;879:			cg_timescale.value += cg_timescaleFadeSpeed.value * ((float)cg.frametime) / 1000;
ADDRLP4 12
ADDRGP4 cg_timescale+8
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRGP4 cg_timescaleFadeSpeed+8
INDIRF4
ADDRGP4 cg+107600
INDIRI4
CVIF4 4
MULF4
CNSTF4 981668463
MULF4
ADDF4
ASGNF4
line 880
;880:			if (cg_timescale.value > cg_timescaleFadeEnd.value)
ADDRGP4 cg_timescale+8
INDIRF4
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
LEF4 $859
line 881
;881:				cg_timescale.value = cg_timescaleFadeEnd.value;
ADDRGP4 cg_timescale+8
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
ASGNF4
line 882
;882:		} else {
ADDRGP4 $859
JUMPV
LABELV $858
line 883
;883:			cg_timescale.value -= cg_timescaleFadeSpeed.value * ((float)cg.frametime) / 1000;
ADDRLP4 12
ADDRGP4 cg_timescale+8
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRGP4 cg_timescaleFadeSpeed+8
INDIRF4
ADDRGP4 cg+107600
INDIRI4
CVIF4 4
MULF4
CNSTF4 981668463
MULF4
SUBF4
ASGNF4
line 884
;884:			if (cg_timescale.value < cg_timescaleFadeEnd.value)
ADDRGP4 cg_timescale+8
INDIRF4
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
GEF4 $874
line 885
;885:				cg_timescale.value = cg_timescaleFadeEnd.value;
ADDRGP4 cg_timescale+8
ADDRGP4 cg_timescaleFadeEnd+8
INDIRF4
ASGNF4
LABELV $874
line 886
;886:		}
LABELV $859
line 887
;887:		if (cg_timescaleFadeSpeed.value) {
ADDRGP4 cg_timescaleFadeSpeed+8
INDIRF4
CNSTF4 0
EQF4 $880
line 888
;888:			trap_Cvar_Set("timescale", va("%f", cg_timescale.value));
ADDRGP4 $884
ARGP4
ADDRGP4 cg_timescale+8
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $883
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 889
;889:		}
LABELV $880
line 890
;890:	}
LABELV $854
line 893
;891:
;892:	// actually issue the rendering calls
;893:	CG_DrawActive(stereoView);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 CG_DrawActive
CALLV
pop
line 896
;894:
;895:	// this counter will be bumped for every valid scene we generate
;896:	cg.clientFrame++;
ADDRLP4 12
ADDRGP4 cg
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 898
;897:
;898:	if (cg_stats.integer) {
ADDRGP4 cg_stats+12
INDIRI4
CNSTI4 0
EQI4 $886
line 899
;899:		CG_Printf("cg.clientFrame:%i\n", cg.clientFrame);
ADDRGP4 $889
ARGP4
ADDRGP4 cg
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 900
;900:	}
LABELV $886
line 901
;901:}
LABELV $786
endproc CG_DrawActiveFrame 16 16
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
import CG_GameTypeString
import CG_Text_PaintChar
import CG_Draw3DModel
import CG_GetKillerText
import CG_GetGameStatusText
import CG_GetTeamColor
import CG_ShowResponseHead
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
import CG_SelectFont
import CG_LoadFonts
import CG_DrawString
import CG_DrawTopBottom
import CG_DrawSides
import CG_DrawRect
import UI_DrawProportionalString
import CG_GetColorForHealth
import CG_ColorForHealth
import CG_TileClear
import CG_TeamColor
import CG_FadeColorTime
import CG_FadeColor
import CG_DrawStrlen
import CG_DrawStringExt
import CG_DrawPic
import CG_FillScreen
import CG_FillRect
import CG_AdjustFrom640
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
LABELV $889
byte 1 99
byte 1 103
byte 1 46
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 70
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $884
byte 1 37
byte 1 102
byte 1 0
align 1
LABELV $883
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $817
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $230
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $226
byte 1 51
byte 1 48
byte 1 0
align 1
LABELV $225
byte 1 99
byte 1 103
byte 1 95
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $172
byte 1 67
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 10
byte 1 0
align 1
LABELV $150
byte 1 115
byte 1 107
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $133
byte 1 102
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $93
byte 1 67
byte 1 97
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 114
byte 1 101
byte 1 103
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 32
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 32
byte 1 39
byte 1 37
byte 1 115
byte 1 39
byte 1 46
byte 1 10
byte 1 0

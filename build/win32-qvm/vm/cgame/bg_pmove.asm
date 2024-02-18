data
export pm_stopspeed
align 4
LABELV pm_stopspeed
byte 4 1120403456
export pm_duckScale
align 4
LABELV pm_duckScale
byte 4 1048576000
export pm_swimScale
align 4
LABELV pm_swimScale
byte 4 1056964608
export pm_wadeScale
align 4
LABELV pm_wadeScale
byte 4 1060320051
export pm_accelerate
align 4
LABELV pm_accelerate
byte 4 1092616192
export pm_airaccelerate
align 4
LABELV pm_airaccelerate
byte 4 1065353216
export pm_wateraccelerate
align 4
LABELV pm_wateraccelerate
byte 4 1082130432
export pm_flyaccelerate
align 4
LABELV pm_flyaccelerate
byte 4 1090519040
export pm_friction
align 4
LABELV pm_friction
byte 4 1086324736
export pm_waterfriction
align 4
LABELV pm_waterfriction
byte 4 1065353216
export pm_flightfriction
align 4
LABELV pm_flightfriction
byte 4 1077936128
export pm_spectatorfriction
align 4
LABELV pm_spectatorfriction
byte 4 1084227584
export c_pmove
align 4
LABELV c_pmove
byte 4 0
align 4
LABELV pm_respawntimer
byte 4 0
export PM_AddEvent
code
proc PM_AddEvent 0 16
file "..\..\..\..\code\game\bg_pmove.c"
line 41
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// bg_pmove.c -- both games player movement code
;4:// takes a playerstate and a usercmd as input and returns a modifed playerstate
;5:
;6:#include "q_shared.h"
;7:#include "bg_public.h"
;8:#include "bg_local.h"
;9:
;10:pmove_t *pm;
;11:pml_t		pml;
;12:
;13:// movement parameters
;14:float	pm_stopspeed = 100.0f;
;15:float	pm_duckScale = 0.25f;
;16:float	pm_swimScale = 0.50f;
;17:float	pm_wadeScale = 0.70f;
;18:
;19:float	pm_accelerate = 10.0f;
;20:float	pm_airaccelerate = 1.0f;
;21:float	pm_wateraccelerate = 4.0f;
;22:float	pm_flyaccelerate = 8.0f;
;23:
;24:float	pm_friction = 6.0f;
;25:float	pm_waterfriction = 1.0f;
;26:float	pm_flightfriction = 3.0f;
;27:float	pm_spectatorfriction = 5.0f;
;28:
;29:int		c_pmove = 0;
;30:
;31:#define NO_RESPAWN_OVERBOUNCE 250
;32:
;33:static int pm_respawntimer = 0;
;34:
;35:/*
;36:===============
;37:PM_AddEvent
;38:
;39:===============
;40:*/
;41:void PM_AddEvent(int newEvent) {
line 42
;42:	BG_AddPredictableEventToPlayerstate(newEvent, 0, pm->ps, -1);
ADDRFP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 pm
INDIRP4
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 BG_AddPredictableEventToPlayerstate
CALLV
pop
line 43
;43:}
LABELV $41
endproc PM_AddEvent 0 16
export PM_AddTouchEnt
proc PM_AddTouchEnt 12 0
line 50
;44:
;45:/*
;46:===============
;47:PM_AddTouchEnt
;48:===============
;49:*/
;50:void PM_AddTouchEnt(int entityNum) {
line 53
;51:	int		i;
;52:
;53:	if (entityNum == ENTITYNUM_WORLD) {
ADDRFP4 0
INDIRI4
CNSTI4 1022
NEI4 $43
line 54
;54:		return;
ADDRGP4 $42
JUMPV
LABELV $43
line 57
;55:	}
;56:
;57:	if (pm->numtouch >= MAXTOUCH) {
ADDRGP4 pm
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 32
LTI4 $45
line 58
;58:		return;
ADDRGP4 $42
JUMPV
LABELV $45
line 62
;59:	}
;60:
;61:	// see if it is already added
;62:	for (i = 0; i < pm->numtouch; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $50
JUMPV
LABELV $47
line 63
;63:		if (pm->touchents[i] == entityNum) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pm
INDIRP4
CNSTI4 48
ADDP4
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $51
line 64
;64:			return;
ADDRGP4 $42
JUMPV
LABELV $51
line 66
;65:		}
;66:	}
LABELV $48
line 62
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $50
ADDRLP4 0
INDIRI4
ADDRGP4 pm
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
LTI4 $47
line 69
;67:
;68:	// add it
;69:	pm->touchents[pm->numtouch] = entityNum;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 48
ADDP4
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 70
;70:	pm->numtouch++;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
CNSTI4 44
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
line 71
;71:}
LABELV $42
endproc PM_AddTouchEnt 12 0
proc PM_StartTorsoAnim 4 0
line 78
;72:
;73:/*
;74:===================
;75:PM_StartTorsoAnim
;76:===================
;77:*/
;78:static void PM_StartTorsoAnim(int anim) {
line 79
;79:	if (pm->ps->pm_type >= PM_DEAD) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
LTI4 $54
line 80
;80:		return;
ADDRGP4 $53
JUMPV
LABELV $54
line 82
;81:	}
;82:	pm->ps->torsoAnim = ((pm->ps->torsoAnim & ANIM_TOGGLEBIT) ^ ANIM_TOGGLEBIT)
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 128
BXORI4
ADDRFP4 0
INDIRI4
BORI4
ASGNI4
line 84
;83:		| anim;
;84:}
LABELV $53
endproc PM_StartTorsoAnim 4 0
proc PM_StartLegsAnim 4 0
line 85
;85:static void PM_StartLegsAnim(int anim) {
line 86
;86:	if (pm->ps->pm_type >= PM_DEAD) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
LTI4 $57
line 87
;87:		return;
ADDRGP4 $56
JUMPV
LABELV $57
line 89
;88:	}
;89:	if (pm->ps->legsTimer > 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
LEI4 $59
line 90
;90:		return;		// a high priority animation is running
ADDRGP4 $56
JUMPV
LABELV $59
line 92
;91:	}
;92:	pm->ps->legsAnim = ((pm->ps->legsAnim & ANIM_TOGGLEBIT) ^ ANIM_TOGGLEBIT)
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 128
BXORI4
ADDRFP4 0
INDIRI4
BORI4
ASGNI4
line 94
;93:		| anim;
;94:}
LABELV $56
endproc PM_StartLegsAnim 4 0
proc PM_ContinueLegsAnim 0 4
line 96
;95:
;96:static void PM_ContinueLegsAnim(int anim) {
line 97
;97:	if ((pm->ps->legsAnim & ~ANIM_TOGGLEBIT) == anim) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ADDRFP4 0
INDIRI4
NEI4 $62
line 98
;98:		return;
ADDRGP4 $61
JUMPV
LABELV $62
line 100
;99:	}
;100:	if (pm->ps->legsTimer > 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
LEI4 $64
line 101
;101:		return;		// a high priority animation is running
ADDRGP4 $61
JUMPV
LABELV $64
line 103
;102:	}
;103:	PM_StartLegsAnim(anim);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 PM_StartLegsAnim
CALLV
pop
line 104
;104:}
LABELV $61
endproc PM_ContinueLegsAnim 0 4
proc PM_ContinueTorsoAnim 0 4
line 106
;105:
;106:static void PM_ContinueTorsoAnim(int anim) {
line 107
;107:	if ((pm->ps->torsoAnim & ~ANIM_TOGGLEBIT) == anim) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
ADDRFP4 0
INDIRI4
NEI4 $67
line 108
;108:		return;
ADDRGP4 $66
JUMPV
LABELV $67
line 110
;109:	}
;110:	if (pm->ps->torsoTimer > 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
LEI4 $69
line 111
;111:		return;		// a high priority animation is running
ADDRGP4 $66
JUMPV
LABELV $69
line 113
;112:	}
;113:	PM_StartTorsoAnim(anim);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 114
;114:}
LABELV $66
endproc PM_ContinueTorsoAnim 0 4
proc PM_ForceLegsAnim 0 4
line 116
;115:
;116:static void PM_ForceLegsAnim(int anim) {
line 117
;117:	pm->ps->legsTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 118
;118:	PM_StartLegsAnim(anim);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 PM_StartLegsAnim
CALLV
pop
line 119
;119:}
LABELV $71
endproc PM_ForceLegsAnim 0 4
export PM_ClipVelocity
proc PM_ClipVelocity 24 0
line 129
;120:
;121:
;122:/*
;123:==================
;124:PM_ClipVelocity
;125:
;126:Slide off of the impacting surface
;127:==================
;128:*/
;129:void PM_ClipVelocity(vec3_t in, vec3_t normal, vec3_t out, float overbounce) {
line 134
;130:	float	backoff;
;131:	float	change;
;132:	int		i;
;133:
;134:	backoff = DotProduct(in, normal);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 16
INDIRP4
INDIRF4
MULF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 136
;135:
;136:	if (backoff < 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
GEF4 $73
line 137
;137:		backoff *= overbounce;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 138
;138:	} else {
ADDRGP4 $74
JUMPV
LABELV $73
line 139
;139:		backoff /= overbounce;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 12
INDIRF4
DIVF4
ASGNF4
line 140
;140:	}
LABELV $74
line 142
;141:
;142:	for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $75
line 143
;143:		change = normal[i] * backoff;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
MULF4
ASGNF4
line 144
;144:		out[i] = in[i] - change;
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
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
SUBF4
ASGNF4
line 145
;145:	}
LABELV $76
line 142
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $75
line 146
;146:}
LABELV $72
endproc PM_ClipVelocity 24 0
proc PM_Friction 48 4
line 156
;147:
;148:
;149:/*
;150:==================
;151:PM_Friction
;152:
;153:Handles both ground friction and water friction
;154:==================
;155:*/
;156:static void PM_Friction(void) {
line 162
;157:	vec3_t	vec;
;158:	float *vel;
;159:	float	speed, newspeed, control;
;160:	float	drop;
;161:
;162:	vel = pm->ps->velocity;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
line 164
;163:
;164:	VectorCopy(vel, vec);
ADDRLP4 16
ADDRLP4 0
INDIRP4
INDIRB
ASGNB 12
line 165
;165:	if (pml.walking) {
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
EQI4 $80
line 166
;166:		vec[2] = 0;	// ignore slope movement
ADDRLP4 16+8
CNSTF4 0
ASGNF4
line 167
;167:	}
LABELV $80
line 169
;168:
;169:	speed = VectorLength(vec);
ADDRLP4 16
ARGP4
ADDRLP4 32
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 32
INDIRF4
ASGNF4
line 170
;170:	if (speed < 1) {
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
GEF4 $84
line 171
;171:		vel[0] = 0;
ADDRLP4 0
INDIRP4
CNSTF4 0
ASGNF4
line 172
;172:		vel[1] = 0;		// allow sinking underwater
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
line 174
;173:		// FIXME: still have z friction underwater?
;174:		if (pm->ps->pm_type == PM_SPECTATOR || pm->ps->powerups[PW_FLIGHT])
ADDRLP4 36
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $88
ADDRLP4 36
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $79
LABELV $88
line 175
;175:			vel[2] = 0.0f; // no slow-sinking/raising movements
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
line 176
;176:		return;
ADDRGP4 $79
JUMPV
LABELV $84
line 179
;177:	}
;178:
;179:	drop = 0;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 182
;180:
;181:	// apply ground friction
;182:	if (pm->waterlevel <= 1) {
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
GTI4 $89
line 183
;183:		if (pml.walking && !(pml.groundTrace.surfaceFlags & SURF_SLICK)) {
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
EQI4 $91
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $91
line 185
;184:			// if getting knocked back, no friction
;185:			if (!(pm->ps->pm_flags & PMF_TIME_KNOCKBACK)) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
NEI4 $96
line 186
;186:				control = speed < pm_stopspeed ? pm_stopspeed : speed;
ADDRLP4 8
INDIRF4
ADDRGP4 pm_stopspeed
INDIRF4
GEF4 $99
ADDRLP4 36
ADDRGP4 pm_stopspeed
INDIRF4
ASGNF4
ADDRGP4 $100
JUMPV
LABELV $99
ADDRLP4 36
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $100
ADDRLP4 28
ADDRLP4 36
INDIRF4
ASGNF4
line 187
;187:				drop += control * pm_friction * pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 28
INDIRF4
ADDRGP4 pm_friction
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 188
;188:			}
LABELV $96
line 189
;189:		}
LABELV $91
line 190
;190:	}
LABELV $89
line 193
;191:
;192:	// apply water friction even if just wading
;193:	if (pm->waterlevel) {
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
EQI4 $102
line 194
;194:		drop += speed * pm_waterfriction * pm->waterlevel * pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 pm_waterfriction
INDIRF4
MULF4
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 195
;195:	}
LABELV $102
line 198
;196:
;197:	// apply flying friction
;198:	if (pm->ps->powerups[PW_FLIGHT]) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $105
line 199
;199:		drop += speed * pm_flightfriction * pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 pm_flightfriction
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 200
;200:	}
LABELV $105
line 202
;201:
;202:	if (pm->ps->pm_type == PM_SPECTATOR) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $108
line 203
;203:		drop += speed * pm_spectatorfriction * pml.frametime;
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
ADDRGP4 pm_spectatorfriction
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 204
;204:	}
LABELV $108
line 207
;205:
;206:	// scale the velocity
;207:	newspeed = speed - drop;
ADDRLP4 4
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
line 208
;208:	if (newspeed < 0) {
ADDRLP4 4
INDIRF4
CNSTF4 0
GEF4 $111
line 209
;209:		newspeed = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 210
;210:	}
LABELV $111
line 211
;211:	newspeed /= speed;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
DIVF4
ASGNF4
line 213
;212:
;213:	vel[0] = vel[0] * newspeed;
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 214
;214:	vel[1] = vel[1] * newspeed;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 215
;215:	vel[2] = vel[2] * newspeed;
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 216
;216:}
LABELV $79
endproc PM_Friction 48 4
proc PM_Accelerate 32 0
line 226
;217:
;218:
;219:/*
;220:==============
;221:PM_Accelerate
;222:
;223:Handles user intended acceleration
;224:==============
;225:*/
;226:static void PM_Accelerate(vec3_t wishdir, float wishspeed, float accel) {
line 232
;227:#if 1
;228:	// q2 style
;229:	int			i;
;230:	float		addspeed, accelspeed, currentspeed;
;231:
;232:	currentspeed = DotProduct(pm->ps->velocity, wishdir);
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
INDIRF4
MULF4
ADDRLP4 16
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 16
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 233
;233:	addspeed = wishspeed - currentspeed;
ADDRLP4 8
ADDRFP4 4
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
line 234
;234:	if (addspeed <= 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
GTF4 $114
line 235
;235:		return;
ADDRGP4 $113
JUMPV
LABELV $114
line 237
;236:	}
;237:	accelspeed = accel * pml.frametime * wishspeed;
ADDRLP4 4
ADDRFP4 8
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 238
;238:	if (accelspeed > addspeed) {
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $117
line 239
;239:		accelspeed = addspeed;
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 240
;240:	}
LABELV $117
line 242
;241:
;242:	for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $119
line 243
;243:		pm->ps->velocity[i] += accelspeed * wishdir[i];
ADDRLP4 28
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 244
;244:	}
LABELV $120
line 242
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $119
line 263
;245:#else
;246:	// proper way (avoids strafe jump maxspeed bug), but feels bad
;247:	vec3_t		wishVelocity;
;248:	vec3_t		pushDir;
;249:	float		pushLen;
;250:	float		canPush;
;251:
;252:	VectorScale(wishdir, wishspeed, wishVelocity);
;253:	VectorSubtract(wishVelocity, pm->ps->velocity, pushDir);
;254:	pushLen = VectorNormalize(pushDir);
;255:
;256:	canPush = accel * pml.frametime * wishspeed;
;257:	if (canPush > pushLen) {
;258:		canPush = pushLen;
;259:	}
;260:
;261:	VectorMA(pm->ps->velocity, canPush, pushDir, pm->ps->velocity);
;262:#endif
;263:}
LABELV $113
endproc PM_Accelerate 32 0
proc PM_CmdScale 32 4
line 276
;264:
;265:
;266:
;267:/*
;268:============
;269:PM_CmdScale
;270:
;271:Returns the scale factor to apply to cmd movements
;272:This allows the clients to use axial -127 to 127 values for all directions
;273:without getting a sqrt(2) distortion in speed.
;274:============
;275:*/
;276:static float PM_CmdScale(usercmd_t *cmd) {
line 281
;277:	int		max;
;278:	float	total;
;279:	float	scale;
;280:
;281:	max = abs(cmd->forwardmove);
ADDRFP4 0
INDIRP4
CNSTI4 21
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 12
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 282
;282:	if (abs(cmd->rightmove) > max) {
ADDRFP4 0
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 16
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $124
line 283
;283:		max = abs(cmd->rightmove);
ADDRFP4 0
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 20
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
ASGNI4
line 284
;284:	}
LABELV $124
line 285
;285:	if (abs(cmd->upmove) > max) {
ADDRFP4 0
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 20
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $126
line 286
;286:		max = abs(cmd->upmove);
ADDRFP4 0
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 24
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
ASGNI4
line 287
;287:	}
LABELV $126
line 288
;288:	if (!max) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $128
line 289
;289:		return 0;
CNSTF4 0
RETF4
ADDRGP4 $123
JUMPV
LABELV $128
line 292
;290:	}
;291:
;292:	total = sqrt(cmd->forwardmove * cmd->forwardmove
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 21
ADDP4
INDIRI1
CVII4 1
ADDRLP4 24
INDIRP4
CNSTI4 21
ADDP4
INDIRI1
CVII4 1
MULI4
ADDRLP4 24
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
ADDRLP4 24
INDIRP4
CNSTI4 22
ADDP4
INDIRI1
CVII4 1
MULI4
ADDI4
ADDRLP4 24
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
ADDRLP4 24
INDIRP4
CNSTI4 23
ADDP4
INDIRI1
CVII4 1
MULI4
ADDI4
CVIF4 4
ARGF4
ADDRLP4 28
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 28
INDIRF4
ASGNF4
line 294
;293:		+ cmd->rightmove * cmd->rightmove + cmd->upmove * cmd->upmove);
;294:	scale = (float)pm->ps->speed * max / (127.0 * total);
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 0
INDIRI4
CVIF4 4
MULF4
ADDRLP4 4
INDIRF4
CNSTF4 1123942400
MULF4
DIVF4
ASGNF4
line 296
;295:
;296:	return scale;
ADDRLP4 8
INDIRF4
RETF4
LABELV $123
endproc PM_CmdScale 32 4
proc PM_SetMovementDir 36 0
line 308
;297:}
;298:
;299:
;300:/*
;301:================
;302:PM_SetMovementDir
;303:
;304:Determine the rotation of the legs relative
;305:to the facing dir
;306:================
;307:*/
;308:static void PM_SetMovementDir(void) {
line 309
;309:	if (pm->cmd.forwardmove || pm->cmd.rightmove) {
ADDRLP4 0
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $133
ADDRLP4 0
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $131
LABELV $133
line 310
;310:		if (pm->cmd.rightmove == 0 && pm->cmd.forwardmove > 0) {
ADDRLP4 4
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $134
ADDRLP4 4
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $134
line 311
;311:			pm->ps->movementDir = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 0
ASGNI4
line 312
;312:		} else if (pm->cmd.rightmove < 0 && pm->cmd.forwardmove > 0) {
ADDRGP4 $132
JUMPV
LABELV $134
ADDRLP4 8
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $136
ADDRLP4 8
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $136
line 313
;313:			pm->ps->movementDir = 1;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 1
ASGNI4
line 314
;314:		} else if (pm->cmd.rightmove < 0 && pm->cmd.forwardmove == 0) {
ADDRGP4 $132
JUMPV
LABELV $136
ADDRLP4 12
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $138
ADDRLP4 12
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $138
line 315
;315:			pm->ps->movementDir = 2;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 2
ASGNI4
line 316
;316:		} else if (pm->cmd.rightmove < 0 && pm->cmd.forwardmove < 0) {
ADDRGP4 $132
JUMPV
LABELV $138
ADDRLP4 16
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $140
ADDRLP4 16
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $140
line 317
;317:			pm->ps->movementDir = 3;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 3
ASGNI4
line 318
;318:		} else if (pm->cmd.rightmove == 0 && pm->cmd.forwardmove < 0) {
ADDRGP4 $132
JUMPV
LABELV $140
ADDRLP4 20
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $142
ADDRLP4 20
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $142
line 319
;319:			pm->ps->movementDir = 4;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 4
ASGNI4
line 320
;320:		} else if (pm->cmd.rightmove > 0 && pm->cmd.forwardmove < 0) {
ADDRGP4 $132
JUMPV
LABELV $142
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $144
ADDRLP4 24
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $144
line 321
;321:			pm->ps->movementDir = 5;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 5
ASGNI4
line 322
;322:		} else if (pm->cmd.rightmove > 0 && pm->cmd.forwardmove == 0) {
ADDRGP4 $132
JUMPV
LABELV $144
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $146
ADDRLP4 28
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $146
line 323
;323:			pm->ps->movementDir = 6;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 6
ASGNI4
line 324
;324:		} else if (pm->cmd.rightmove > 0 && pm->cmd.forwardmove > 0) {
ADDRGP4 $132
JUMPV
LABELV $146
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $132
ADDRLP4 32
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $132
line 325
;325:			pm->ps->movementDir = 7;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 7
ASGNI4
line 326
;326:		}
line 327
;327:	} else {
ADDRGP4 $132
JUMPV
LABELV $131
line 331
;328:		// if they aren't actively going directly sideways,
;329:		// change the animation to the diagonal so they
;330:		// don't stop too crooked
;331:		if (pm->ps->movementDir == 2) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 2
NEI4 $150
line 332
;332:			pm->ps->movementDir = 1;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 1
ASGNI4
line 333
;333:		} else if (pm->ps->movementDir == 6) {
ADDRGP4 $151
JUMPV
LABELV $150
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 6
NEI4 $152
line 334
;334:			pm->ps->movementDir = 7;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 88
ADDP4
CNSTI4 7
ASGNI4
line 335
;335:		}
LABELV $152
LABELV $151
line 336
;336:	}
LABELV $132
line 337
;337:}
LABELV $130
endproc PM_SetMovementDir 36 0
proc PM_CheckJump 8 4
line 345
;338:
;339:
;340:/*
;341:=============
;342:PM_CheckJump
;343:=============
;344:*/
;345:static qboolean PM_CheckJump(void) {
line 346
;346:	if (pm->ps->pm_flags & PMF_RESPAWNED) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $155
line 347
;347:		return qfalse;		// don't allow jump until all buttons are up
CNSTI4 0
RETI4
ADDRGP4 $154
JUMPV
LABELV $155
line 350
;348:	}
;349:
;350:	if (pm->cmd.upmove < 10) {
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 10
GEI4 $157
line 352
;351:		// not holding jump
;352:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $154
JUMPV
LABELV $157
line 356
;353:	}
;354:
;355:	// must wait for jump to be released
;356:	if (pm->ps->pm_flags & PMF_JUMP_HELD) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $159
line 358
;357:		// clear upmove so cmdscale doesn't lower running speed
;358:		pm->cmd.upmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 359
;359:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $154
JUMPV
LABELV $159
line 362
;360:	}
;361:
;362:	pml.groundPlane = qfalse;		// jumping away
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 363
;363:	pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 364
;364:	pm->ps->pm_flags |= PMF_JUMP_HELD;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 366
;365:
;366:	pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 367
;367:	pm->ps->velocity[2] = JUMP_VELOCITY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1132920832
ASGNF4
line 368
;368:	PM_AddEvent(EV_JUMP);
CNSTI4 14
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 370
;369:
;370:	if (pm->cmd.forwardmove >= 0) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LTI4 $163
line 371
;371:		PM_ForceLegsAnim(LEGS_JUMP);
CNSTI4 18
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 372
;372:		pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 373
;373:	} else {
ADDRGP4 $164
JUMPV
LABELV $163
line 374
;374:		PM_ForceLegsAnim(LEGS_JUMPB);
CNSTI4 20
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 375
;375:		pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 376
;376:	}
LABELV $164
line 378
;377:
;378:	return qtrue;
CNSTI4 1
RETI4
LABELV $154
endproc PM_CheckJump 8 4
proc PM_CheckWaterJump 52 8
line 386
;379:}
;380:
;381:/*
;382:=============
;383:PM_CheckWaterJump
;384:=============
;385:*/
;386:static qboolean	PM_CheckWaterJump(void) {
line 391
;387:	vec3_t	spot;
;388:	int		cont;
;389:	vec3_t	flatforward;
;390:
;391:	if (pm->ps->pm_time) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $166
line 392
;392:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $165
JUMPV
LABELV $166
line 396
;393:	}
;394:
;395:	// check for water jump
;396:	if (pm->waterlevel != 2) {
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
EQI4 $168
line 397
;397:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $165
JUMPV
LABELV $168
line 400
;398:	}
;399:
;400:	flatforward[0] = pml.forward[0];
ADDRLP4 12
ADDRGP4 pml
INDIRF4
ASGNF4
line 401
;401:	flatforward[1] = pml.forward[1];
ADDRLP4 12+4
ADDRGP4 pml+4
INDIRF4
ASGNF4
line 402
;402:	flatforward[2] = 0;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 403
;403:	VectorNormalize(flatforward);
ADDRLP4 12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 405
;404:
;405:	VectorMA(pm->ps->origin, 30, flatforward, spot);
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 1106247680
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 12+4
INDIRF4
CNSTF4 1106247680
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 12+8
INDIRF4
CNSTF4 1106247680
MULF4
ADDF4
ASGNF4
line 406
;406:	spot[2] += 4;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1082130432
ADDF4
ASGNF4
line 407
;407:	cont = pm->pointcontents(spot, pm->ps->clientNum);
ADDRLP4 0
ARGP4
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 36
INDIRI4
ASGNI4
line 408
;408:	if (!(cont & CONTENTS_SOLID)) {
ADDRLP4 24
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $178
line 409
;409:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $165
JUMPV
LABELV $178
line 412
;410:	}
;411:
;412:	spot[2] += 16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 413
;413:	cont = pm->pointcontents(spot, pm->ps->clientNum);
ADDRLP4 0
ARGP4
ADDRLP4 40
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ADDRLP4 40
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 24
ADDRLP4 44
INDIRI4
ASGNI4
line 414
;414:	if (cont & (CONTENTS_SOLID | CONTENTS_PLAYERCLIP | CONTENTS_BODY)) {
ADDRLP4 24
INDIRI4
CNSTI4 33619969
BANDI4
CNSTI4 0
EQI4 $181
line 415
;415:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $165
JUMPV
LABELV $181
line 419
;416:	}
;417:
;418:	// jump out of water
;419:	VectorScale(pml.forward, 200, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRGP4 pml
INDIRF4
CNSTF4 1128792064
MULF4
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ADDRGP4 pml+4
INDIRF4
CNSTF4 1128792064
MULF4
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ADDRGP4 pml+8
INDIRF4
CNSTF4 1128792064
MULF4
ASGNF4
line 420
;420:	pm->ps->velocity[2] = 350;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1135542272
ASGNF4
line 422
;421:
;422:	pm->ps->pm_flags |= PMF_TIME_WATERJUMP;
ADDRLP4 48
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 423
;423:	pm->ps->pm_time = 2000;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 2000
ASGNI4
line 425
;424:
;425:	return qtrue;
CNSTI4 1
RETI4
LABELV $165
endproc PM_CheckWaterJump 52 8
proc PM_WaterJumpMove 12 4
line 438
;426:}
;427:
;428://============================================================================
;429:
;430:
;431:/*
;432:===================
;433:PM_WaterJumpMove
;434:
;435:Flying out of the water
;436:===================
;437:*/
;438:static void PM_WaterJumpMove(void) {
line 441
;439:	// waterjump has no control, but falls
;440:
;441:	PM_StepSlideMove(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 443
;442:
;443:	pm->ps->velocity[2] -= pm->ps->gravity * pml.frametime;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pml+36
INDIRF4
MULF4
SUBF4
ASGNF4
line 444
;444:	if (pm->ps->velocity[2] < 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 0
GEF4 $187
line 446
;445:		// cancel as soon as we are falling down again
;446:		pm->ps->pm_flags &= ~PMF_ALL_TIMES;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -353
BANDI4
ASGNI4
line 447
;447:		pm->ps->pm_time = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 448
;448:	}
LABELV $187
line 449
;449:}
LABELV $185
endproc PM_WaterJumpMove 12 4
proc PM_WaterMove 76 16
line 457
;450:
;451:/*
;452:===================
;453:PM_WaterMove
;454:
;455:===================
;456:*/
;457:static void PM_WaterMove(void) {
line 465
;458:	int		i;
;459:	vec3_t	wishvel;
;460:	float	wishspeed;
;461:	vec3_t	wishdir;
;462:	float	scale;
;463:	float	vel;
;464:
;465:	if (PM_CheckWaterJump()) {
ADDRLP4 40
ADDRGP4 PM_CheckWaterJump
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $190
line 466
;466:		PM_WaterJumpMove();
ADDRGP4 PM_WaterJumpMove
CALLV
pop
line 467
;467:		return;
ADDRGP4 $189
JUMPV
LABELV $190
line 483
;468:	}
;469:#if 0
;470:	// jump = head for surface
;471:	if (pm->cmd.upmove >= 10) {
;472:		if (pm->ps->velocity[2] > -300) {
;473:			if (pm->watertype & CONTENTS_WATER) {
;474:				pm->ps->velocity[2] = 100;
;475:			} else if (pm->watertype & CONTENTS_SLIME) {
;476:				pm->ps->velocity[2] = 80;
;477:			} else {
;478:				pm->ps->velocity[2] = 50;
;479:			}
;480:		}
;481:	}
;482:#endif
;483:	PM_Friction();
ADDRGP4 PM_Friction
CALLV
pop
line 485
;484:
;485:	scale = PM_CmdScale(&pm->cmd);
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 44
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 44
INDIRF4
ASGNF4
line 489
;486:	//
;487:	// user intentions
;488:	//
;489:	if (!scale) {
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $192
line 490
;490:		wishvel[0] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 491
;491:		wishvel[1] = 0;
ADDRLP4 8+4
CNSTF4 0
ASGNF4
line 492
;492:		wishvel[2] = -60;		// sink towards bottom
ADDRLP4 8+8
CNSTF4 3262119936
ASGNF4
line 493
;493:	} else {
ADDRGP4 $193
JUMPV
LABELV $192
line 494
;494:		for (i = 0; i < 3; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $196
line 495
;495:			wishvel[i] = scale * pml.forward[i] * pm->cmd.forwardmove + scale * pml.right[i] * pm->cmd.rightmove;
ADDRLP4 56
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml
ADDP4
INDIRF4
MULF4
ADDRLP4 56
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml+12
ADDP4
INDIRF4
MULF4
ADDRLP4 56
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
LABELV $197
line 494
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
line 497
;496:
;497:		wishvel[2] += scale * pm->cmd.upmove;
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 4
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
line 498
;498:	}
LABELV $193
line 500
;499:
;500:	VectorCopy(wishvel, wishdir);
ADDRLP4 24
ADDRLP4 8
INDIRB
ASGNB 12
line 501
;501:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 24
ARGP4
ADDRLP4 48
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 48
INDIRF4
ASGNF4
line 503
;502:
;503:	if (wishspeed > pm->ps->speed * pm_swimScale) {
ADDRLP4 20
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_swimScale
INDIRF4
MULF4
LEF4 $202
line 504
;504:		wishspeed = pm->ps->speed * pm_swimScale;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_swimScale
INDIRF4
MULF4
ASGNF4
line 505
;505:	}
LABELV $202
line 507
;506:
;507:	PM_Accelerate(wishdir, wishspeed, pm_wateraccelerate);
ADDRLP4 24
ARGP4
ADDRLP4 20
INDIRF4
ARGF4
ADDRGP4 pm_wateraccelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 510
;508:
;509:	// make sure we can go up slopes easily under water
;510:	if (pml.groundPlane && DotProduct(pm->ps->velocity, pml.groundTrace.plane.normal) < 0) {
ADDRGP4 pml+48
INDIRI4
CNSTI4 0
EQI4 $204
ADDRLP4 52
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRGP4 pml+52+24
INDIRF4
MULF4
ADDRLP4 52
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRGP4 pml+52+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 52
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRGP4 pml+52+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
GEF4 $204
line 511
;511:		vel = VectorLength(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 56
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 36
ADDRLP4 56
INDIRF4
ASGNF4
line 513
;512:		// slide along the ground plane
;513:		PM_ClipVelocity(pm->ps->velocity, pml.groundTrace.plane.normal,
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 32
ADDP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 516
;514:			pm->ps->velocity, OVERCLIP);
;515:
;516:		VectorNormalize(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 517
;517:		VectorScale(pm->ps->velocity, vel, pm->ps->velocity);
ADDRLP4 64
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
ADDRLP4 68
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 36
INDIRF4
MULF4
ASGNF4
line 518
;518:	}
LABELV $204
line 520
;519:
;520:	PM_SlideMove(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 PM_SlideMove
CALLI4
pop
line 521
;521:}
LABELV $189
endproc PM_WaterMove 76 16
proc PM_InvulnerabilityMove 0 0
line 531
;522:
;523:
;524:/*
;525:===================
;526:PM_InvulnerabilityMove
;527:
;528:Only with the invulnerability powerup
;529:===================
;530:*/
;531:static void PM_InvulnerabilityMove(void) {
line 532
;532:	pm->cmd.forwardmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
CNSTI1 0
ASGNI1
line 533
;533:	pm->cmd.rightmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
CNSTI1 0
ASGNI1
line 534
;534:	pm->cmd.upmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 535
;535:	VectorClear(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 0
ASGNF4
line 536
;536:}
LABELV $217
endproc PM_InvulnerabilityMove 0 0
proc PM_FlyMove 52 12
line 545
;537:
;538:/*
;539:===================
;540:PM_FlyMove
;541:
;542:Only with the flight powerup
;543:===================
;544:*/
;545:static void PM_FlyMove(void) {
line 553
;546:	int		i;
;547:	vec3_t	wishvel;
;548:	float	wishspeed;
;549:	vec3_t	wishdir;
;550:	float	scale;
;551:
;552:	// normal slowdown
;553:	PM_Friction();
ADDRGP4 PM_Friction
CALLV
pop
line 555
;554:
;555:	scale = PM_CmdScale(&pm->cmd);
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 36
INDIRF4
ASGNF4
line 559
;556:	//
;557:	// user intentions
;558:	//
;559:	if (!scale) {
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $219
line 560
;560:		wishvel[0] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 561
;561:		wishvel[1] = 0;
ADDRLP4 8+4
CNSTF4 0
ASGNF4
line 562
;562:		wishvel[2] = 0;
ADDRLP4 8+8
CNSTF4 0
ASGNF4
line 563
;563:	} else {
ADDRGP4 $220
JUMPV
LABELV $219
line 564
;564:		for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $223
line 565
;565:			wishvel[i] = scale * pml.forward[i] * pm->cmd.forwardmove + scale * pml.right[i] * pm->cmd.rightmove;
ADDRLP4 48
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml
ADDP4
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml+12
ADDP4
INDIRF4
MULF4
ADDRLP4 48
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
line 566
;566:		}
LABELV $224
line 564
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $223
line 568
;567:
;568:		wishvel[2] += scale * pm->cmd.upmove;
ADDRLP4 8+8
ADDRLP4 8+8
INDIRF4
ADDRLP4 4
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CVIF4 4
MULF4
ADDF4
ASGNF4
line 569
;569:	}
LABELV $220
line 571
;570:
;571:	VectorCopy(wishvel, wishdir);
ADDRLP4 20
ADDRLP4 8
INDIRB
ASGNB 12
line 572
;572:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 20
ARGP4
ADDRLP4 40
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 32
ADDRLP4 40
INDIRF4
ASGNF4
line 574
;573:
;574:	PM_Accelerate(wishdir, wishspeed, pm_flyaccelerate);
ADDRLP4 20
ARGP4
ADDRLP4 32
INDIRF4
ARGF4
ADDRGP4 pm_flyaccelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 576
;575:
;576:	PM_StepSlideMove(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 577
;577:}
LABELV $218
endproc PM_FlyMove 52 12
proc PM_AirMove 80 16
line 586
;578:
;579:
;580:/*
;581:===================
;582:PM_AirMove
;583:
;584:===================
;585:*/
;586:static void PM_AirMove(void) {
line 595
;587:	int			i;
;588:	vec3_t		wishvel;
;589:	float		fmove, smove;
;590:	vec3_t		wishdir;
;591:	float		wishspeed;
;592:	float		scale;
;593:	usercmd_t	cmd;
;594:
;595:	PM_Friction();
ADDRGP4 PM_Friction
CALLV
pop
line 597
;596:
;597:	fmove = pm->cmd.forwardmove;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 598
;598:	smove = pm->cmd.rightmove;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 600
;599:
;600:	cmd = pm->cmd;
ADDRLP4 44
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
INDIRB
ASGNB 24
line 601
;601:	scale = PM_CmdScale(&cmd);
ADDRLP4 44
ARGP4
ADDRLP4 68
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 68
INDIRF4
ASGNF4
line 604
;602:
;603:	// set the movementDir so clients can rotate the legs for strafing
;604:	PM_SetMovementDir();
ADDRGP4 PM_SetMovementDir
CALLV
pop
line 607
;605:
;606:	// project moves down to flat plane
;607:	pml.forward[2] = 0;
ADDRGP4 pml+8
CNSTF4 0
ASGNF4
line 608
;608:	pml.right[2] = 0;
ADDRGP4 pml+12+8
CNSTF4 0
ASGNF4
line 609
;609:	VectorNormalize(pml.forward);
ADDRGP4 pml
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 610
;610:	VectorNormalize(pml.right);
ADDRGP4 pml+12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 612
;611:
;612:	for (i = 0; i < 2; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $234
line 613
;613:		wishvel[i] = pml.forward[i] * fmove + pml.right[i] * smove;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml+12
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 614
;614:	}
LABELV $235
line 612
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $234
line 615
;615:	wishvel[2] = 0;
ADDRLP4 4+8
CNSTF4 0
ASGNF4
line 617
;616:
;617:	VectorCopy(wishvel, wishdir);
ADDRLP4 24
ADDRLP4 4
INDIRB
ASGNB 12
line 618
;618:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 24
ARGP4
ADDRLP4 72
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 36
ADDRLP4 72
INDIRF4
ASGNF4
line 619
;619:	wishspeed *= scale;
ADDRLP4 36
ADDRLP4 36
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ASGNF4
line 622
;620:
;621:	// not on ground, so little effect on velocity
;622:	PM_Accelerate(wishdir, wishspeed, pm_airaccelerate);
ADDRLP4 24
ARGP4
ADDRLP4 36
INDIRF4
ARGF4
ADDRGP4 pm_airaccelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 627
;623:
;624:	// we may have a ground plane that is very steep, even
;625:	// though we don't have a groundentity
;626:	// slide along the steep plane
;627:	if (pml.groundPlane) {
ADDRGP4 pml+48
INDIRI4
CNSTI4 0
EQI4 $240
line 628
;628:		PM_ClipVelocity(pm->ps->velocity, pml.groundTrace.plane.normal,
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 76
INDIRP4
CNSTI4 32
ADDP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 630
;629:			pm->ps->velocity, OVERCLIP);
;630:	}
LABELV $240
line 642
;631:
;632:#if 0
;633:	//ZOID:  If we are on the grapple, try stair-stepping
;634:	//this allows a player to use the grapple to pull himself
;635:	//over a ledge
;636:	if (pm->ps->pm_flags & PMF_GRAPPLE_PULL)
;637:		PM_StepSlideMove(qtrue);
;638:	else
;639:		PM_SlideMove(qtrue);
;640:#endif
;641:
;642:	PM_StepSlideMove(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 643
;643:}
LABELV $229
endproc PM_AirMove 80 16
proc PM_GrappleMove 44 4
line 651
;644:
;645:/*
;646:===================
;647:PM_GrappleMove
;648:
;649:===================
;650:*/
;651:static void PM_GrappleMove(void) {
line 655
;652:	vec3_t vel, v;
;653:	float vlen;
;654:
;655:	VectorScale(pml.forward, -16, v);
ADDRLP4 12
ADDRGP4 pml
INDIRF4
CNSTF4 3246391296
MULF4
ASGNF4
ADDRLP4 12+4
ADDRGP4 pml+4
INDIRF4
CNSTF4 3246391296
MULF4
ASGNF4
ADDRLP4 12+8
ADDRGP4 pml+8
INDIRF4
CNSTF4 3246391296
MULF4
ASGNF4
line 656
;656:	VectorAdd(pm->ps->grapplePoint, v, v);
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 28
INDIRP4
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 12+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRLP4 12+8
INDIRF4
ADDF4
ASGNF4
line 657
;657:	VectorSubtract(v, pm->ps->origin, vel);
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 12+8
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
line 658
;658:	vlen = VectorLength(vel);
ADDRLP4 0
ARGP4
ADDRLP4 36
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 36
INDIRF4
ASGNF4
line 659
;659:	VectorNormalize(vel);
ADDRLP4 0
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 661
;660:
;661:	if (vlen <= 100)
ADDRLP4 24
INDIRF4
CNSTF4 1120403456
GTF4 $258
line 662
;662:		VectorScale(vel, 10 * vlen, vel);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 1092616192
MULF4
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 1092616192
MULF4
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 1092616192
MULF4
MULF4
ASGNF4
ADDRGP4 $259
JUMPV
LABELV $258
line 664
;663:	else
;664:		VectorScale(vel, 800, vel);
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1145569280
MULF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1145569280
MULF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1145569280
MULF4
ASGNF4
LABELV $259
line 666
;665:
;666:	VectorCopy(vel, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 668
;667:
;668:	pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 669
;669:}
LABELV $245
endproc PM_GrappleMove 44 4
proc PM_WalkMove 112 16
line 677
;670:
;671:/*
;672:===================
;673:PM_WalkMove
;674:
;675:===================
;676:*/
;677:static void PM_WalkMove(void) {
line 688
;678:	int			i;
;679:	vec3_t		wishvel;
;680:	float		fmove, smove;
;681:	vec3_t		wishdir;
;682:	float		wishspeed;
;683:	float		scale;
;684:	usercmd_t	cmd;
;685:	float		accelerate;
;686:	float		vel;
;687:
;688:	if (pm->waterlevel > 2 && DotProduct(pml.forward, pml.groundTrace.plane.normal) > 0) {
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
LEI4 $270
ADDRGP4 pml
INDIRF4
ADDRGP4 pml+52+24
INDIRF4
MULF4
ADDRGP4 pml+4
INDIRF4
ADDRGP4 pml+52+24+4
INDIRF4
MULF4
ADDF4
ADDRGP4 pml+8
INDIRF4
ADDRGP4 pml+52+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 0
LEF4 $270
line 690
;689:		// begin swimming
;690:		PM_WaterMove();
ADDRGP4 PM_WaterMove
CALLV
pop
line 691
;691:		return;
ADDRGP4 $269
JUMPV
LABELV $270
line 695
;692:	}
;693:
;694:
;695:	if (PM_CheckJump()) {
ADDRLP4 76
ADDRGP4 PM_CheckJump
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $282
line 697
;696:		// jumped away
;697:		if (pm->waterlevel > 1) {
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
LEI4 $284
line 698
;698:			PM_WaterMove();
ADDRGP4 PM_WaterMove
CALLV
pop
line 699
;699:		} else {
ADDRGP4 $269
JUMPV
LABELV $284
line 700
;700:			PM_AirMove();
ADDRGP4 PM_AirMove
CALLV
pop
line 701
;701:		}
line 702
;702:		return;
ADDRGP4 $269
JUMPV
LABELV $282
line 705
;703:	}
;704:
;705:	PM_Friction();
ADDRGP4 PM_Friction
CALLV
pop
line 707
;706:
;707:	fmove = pm->cmd.forwardmove;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 708
;708:	smove = pm->cmd.rightmove;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 710
;709:
;710:	cmd = pm->cmd;
ADDRLP4 44
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
INDIRB
ASGNB 24
line 711
;711:	scale = PM_CmdScale(&cmd);
ADDRLP4 44
ARGP4
ADDRLP4 80
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 80
INDIRF4
ASGNF4
line 714
;712:
;713:	// set the movementDir so clients can rotate the legs for strafing
;714:	PM_SetMovementDir();
ADDRGP4 PM_SetMovementDir
CALLV
pop
line 717
;715:
;716:	// project moves down to flat plane
;717:	pml.forward[2] = 0;
ADDRGP4 pml+8
CNSTF4 0
ASGNF4
line 718
;718:	pml.right[2] = 0;
ADDRGP4 pml+12+8
CNSTF4 0
ASGNF4
line 721
;719:
;720:	// project the forward and right directions onto the ground plane
;721:	PM_ClipVelocity(pml.forward, pml.groundTrace.plane.normal, pml.forward, OVERCLIP);
ADDRLP4 84
ADDRGP4 pml
ASGNP4
ADDRLP4 84
INDIRP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 84
INDIRP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 722
;722:	PM_ClipVelocity(pml.right, pml.groundTrace.plane.normal, pml.right, OVERCLIP);
ADDRGP4 pml+12
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRGP4 pml+12
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 724
;723:	//
;724:	VectorNormalize(pml.forward);
ADDRGP4 pml
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 725
;725:	VectorNormalize(pml.right);
ADDRGP4 pml+12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 727
;726:
;727:	for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $296
line 728
;728:		wishvel[i] = pml.forward[i] * fmove + pml.right[i] * smove;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml+12
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
line 729
;729:	}
LABELV $297
line 727
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $296
line 733
;730:	// when going up or down slopes the wish velocity should Not be zero
;731://	wishvel[2] = 0;
;732:
;733:	VectorCopy(wishvel, wishdir);
ADDRLP4 28
ADDRLP4 4
INDIRB
ASGNB 12
line 734
;734:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 28
ARGP4
ADDRLP4 88
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 88
INDIRF4
ASGNF4
line 735
;735:	wishspeed *= scale;
ADDRLP4 24
ADDRLP4 24
INDIRF4
ADDRLP4 40
INDIRF4
MULF4
ASGNF4
line 738
;736:
;737:	// clamp the speed lower if ducking
;738:	if (pm->ps->pm_flags & PMF_DUCKED) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $301
line 739
;739:		if (wishspeed > pm->ps->speed * pm_duckScale) {
ADDRLP4 24
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_duckScale
INDIRF4
MULF4
LEF4 $303
line 740
;740:			wishspeed = pm->ps->speed * pm_duckScale;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pm_duckScale
INDIRF4
MULF4
ASGNF4
line 741
;741:		}
LABELV $303
line 742
;742:	}
LABELV $301
line 745
;743:
;744:	// clamp the speed lower if wading or walking on the bottom
;745:	if (pm->waterlevel) {
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
EQI4 $305
line 748
;746:		float	waterScale;
;747:
;748:		waterScale = pm->waterlevel / 3.0;
ADDRLP4 92
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1051372203
MULF4
ASGNF4
line 749
;749:		waterScale = 1.0 - (1.0 - pm_swimScale) * waterScale;
ADDRLP4 92
CNSTF4 1065353216
CNSTF4 1065353216
ADDRGP4 pm_swimScale
INDIRF4
SUBF4
ADDRLP4 92
INDIRF4
MULF4
SUBF4
ASGNF4
line 750
;750:		if (wishspeed > pm->ps->speed * waterScale) {
ADDRLP4 24
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 92
INDIRF4
MULF4
LEF4 $307
line 751
;751:			wishspeed = pm->ps->speed * waterScale;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 92
INDIRF4
MULF4
ASGNF4
line 752
;752:		}
LABELV $307
line 753
;753:	}
LABELV $305
line 757
;754:
;755:	// when a player gets hit, they temporarily lose
;756:	// full control, which allows them to be moved a bit
;757:	if ((pml.groundTrace.surfaceFlags & SURF_SLICK) || pm->ps->pm_flags & PMF_TIME_KNOCKBACK) {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $313
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $309
LABELV $313
line 758
;758:		accelerate = pm_airaccelerate;
ADDRLP4 68
ADDRGP4 pm_airaccelerate
INDIRF4
ASGNF4
line 759
;759:	} else {
ADDRGP4 $310
JUMPV
LABELV $309
line 760
;760:		accelerate = pm_accelerate;
ADDRLP4 68
ADDRGP4 pm_accelerate
INDIRF4
ASGNF4
line 761
;761:	}
LABELV $310
line 763
;762:
;763:	PM_Accelerate(wishdir, wishspeed, accelerate);
ADDRLP4 28
ARGP4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 768
;764:
;765:	//Com_Printf("velocity = %1.1f %1.1f %1.1f\n", pm->ps->velocity[0], pm->ps->velocity[1], pm->ps->velocity[2]);
;766:	//Com_Printf("velocity1 = %1.1f\n", VectorLength(pm->ps->velocity));
;767:
;768:	if ((pml.groundTrace.surfaceFlags & SURF_SLICK) || pm->ps->pm_flags & PMF_TIME_KNOCKBACK) {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $318
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $314
LABELV $318
line 769
;769:		pm->ps->velocity[2] -= pm->ps->gravity * pml.frametime;
ADDRLP4 92
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 96
ADDRLP4 92
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 pml+36
INDIRF4
MULF4
SUBF4
ASGNF4
line 770
;770:	} else {
LABELV $314
line 773
;771:		// don't reset the z velocity for slopes
;772://		pm->ps->velocity[2] = 0;
;773:	}
LABELV $315
line 775
;774:
;775:	if (pm_respawntimer) { // no more overbounce at respawn
ADDRGP4 pm_respawntimer
INDIRI4
CNSTI4 0
EQI4 $320
line 777
;776:		// slide along the ground plane
;777:		PM_ClipVelocity(pm->ps->velocity, pml.groundTrace.plane.normal,
ADDRLP4 92
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 32
ADDP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 779
;778:			pm->ps->velocity, OVERCLIP);
;779:	} else {
ADDRGP4 $321
JUMPV
LABELV $320
line 780
;780:		vel = VectorLength(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 92
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 72
ADDRLP4 92
INDIRF4
ASGNF4
line 783
;781:
;782:		// slide along the ground plane
;783:		PM_ClipVelocity(pm->ps->velocity, pml.groundTrace.plane.normal,
ADDRLP4 96
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 pml+52+24
ARGP4
ADDRLP4 96
INDIRP4
CNSTI4 32
ADDP4
ARGP4
CNSTF4 1065361605
ARGF4
ADDRGP4 PM_ClipVelocity
CALLV
pop
line 787
;784:			pm->ps->velocity, OVERCLIP);
;785:
;786:		// don't decrease velocity when going up or down a slope
;787:		VectorNormalize(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 788
;788:		VectorScale(pm->ps->velocity, vel, pm->ps->velocity);
ADDRLP4 100
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 100
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 72
INDIRF4
MULF4
ASGNF4
ADDRLP4 104
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 104
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 104
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 72
INDIRF4
MULF4
ASGNF4
ADDRLP4 108
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 108
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 72
INDIRF4
MULF4
ASGNF4
line 789
;789:	}
LABELV $321
line 792
;790:
;791:	// don't do anything if standing still
;792:	if (!pm->ps->velocity[0] && !pm->ps->velocity[1]) {
ADDRLP4 92
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 0
NEF4 $326
ADDRLP4 92
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CNSTF4 0
NEF4 $326
line 793
;793:		return;
ADDRGP4 $269
JUMPV
LABELV $326
line 796
;794:	}
;795:
;796:	PM_StepSlideMove(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 PM_StepSlideMove
CALLV
pop
line 800
;797:
;798:	//Com_Printf("velocity2 = %1.1f\n", VectorLength(pm->ps->velocity));
;799:
;800:}
LABELV $269
endproc PM_WalkMove 112 16
proc PM_DeadMove 20 4
line 808
;801:
;802:
;803:/*
;804:==============
;805:PM_DeadMove
;806:==============
;807:*/
;808:static void PM_DeadMove(void) {
line 811
;809:	float	forward;
;810:
;811:	if (!pml.walking) {
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
NEI4 $329
line 812
;812:		return;
ADDRGP4 $328
JUMPV
LABELV $329
line 817
;813:	}
;814:
;815:	// extra friction
;816:
;817:	forward = VectorLength(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 818
;818:	forward -= 20;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1101004800
SUBF4
ASGNF4
line 819
;819:	if (forward <= 0) {
ADDRLP4 0
INDIRF4
CNSTF4 0
GTF4 $332
line 820
;820:		VectorClear(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 0
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 0
ASGNF4
line 821
;821:	} else {
ADDRGP4 $333
JUMPV
LABELV $332
line 822
;822:		VectorNormalize(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 823
;823:		VectorScale(pm->ps->velocity, forward, pm->ps->velocity);
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 8
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 12
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 16
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 824
;824:	}
LABELV $333
line 825
;825:}
LABELV $328
endproc PM_DeadMove 20 4
proc PM_NoclipMove 92 12
line 833
;826:
;827:
;828:/*
;829:===============
;830:PM_NoclipMove
;831:===============
;832:*/
;833:static void PM_NoclipMove(void) {
line 842
;834:	float	speed, drop, friction, control, newspeed;
;835:	int			i;
;836:	vec3_t		wishvel;
;837:	float		fmove, smove;
;838:	vec3_t		wishdir;
;839:	float		wishspeed;
;840:	float		scale;
;841:
;842:	pm->ps->viewheight = DEFAULT_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 26
ASGNI4
line 846
;843:
;844:	// friction
;845:
;846:	speed = VectorLength(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRLP4 64
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 64
INDIRF4
ASGNF4
line 847
;847:	if (speed < 1) {
ADDRLP4 24
INDIRF4
CNSTF4 1065353216
GEF4 $335
line 848
;848:		VectorCopy(vec3_origin, pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRGP4 vec3_origin
INDIRB
ASGNB 12
line 849
;849:	} else {
ADDRGP4 $336
JUMPV
LABELV $335
line 850
;850:		drop = 0;
ADDRLP4 52
CNSTF4 0
ASGNF4
line 852
;851:
;852:		friction = pm_friction * 1.5;	// extra friction
ADDRLP4 56
ADDRGP4 pm_friction
INDIRF4
CNSTF4 1069547520
MULF4
ASGNF4
line 853
;853:		control = speed < pm_stopspeed ? pm_stopspeed : speed;
ADDRLP4 24
INDIRF4
ADDRGP4 pm_stopspeed
INDIRF4
GEF4 $338
ADDRLP4 68
ADDRGP4 pm_stopspeed
INDIRF4
ASGNF4
ADDRGP4 $339
JUMPV
LABELV $338
ADDRLP4 68
ADDRLP4 24
INDIRF4
ASGNF4
LABELV $339
ADDRLP4 60
ADDRLP4 68
INDIRF4
ASGNF4
line 854
;854:		drop += control * friction * pml.frametime;
ADDRLP4 52
ADDRLP4 52
INDIRF4
ADDRLP4 60
INDIRF4
ADDRLP4 56
INDIRF4
MULF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 857
;855:
;856:		// scale the velocity
;857:		newspeed = speed - drop;
ADDRLP4 28
ADDRLP4 24
INDIRF4
ADDRLP4 52
INDIRF4
SUBF4
ASGNF4
line 858
;858:		if (newspeed < 0)
ADDRLP4 28
INDIRF4
CNSTF4 0
GEF4 $341
line 859
;859:			newspeed = 0;
ADDRLP4 28
CNSTF4 0
ASGNF4
LABELV $341
line 860
;860:		newspeed /= speed;
ADDRLP4 28
ADDRLP4 28
INDIRF4
ADDRLP4 24
INDIRF4
DIVF4
ASGNF4
line 862
;861:
;862:		VectorScale(pm->ps->velocity, newspeed, pm->ps->velocity);
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 76
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 80
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 863
;863:	}
LABELV $336
line 866
;864:
;865:	// accelerate
;866:	scale = PM_CmdScale(&pm->cmd);
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 68
ADDRGP4 PM_CmdScale
CALLF4
ASGNF4
ADDRLP4 48
ADDRLP4 68
INDIRF4
ASGNF4
line 868
;867:
;868:	fmove = pm->cmd.forwardmove;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 869
;869:	smove = pm->cmd.rightmove;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ASGNF4
line 871
;870:
;871:	for (i = 0; i < 3; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $343
line 872
;872:		wishvel[i] = pml.forward[i] * fmove + pml.right[i] * smove;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pml+12
ADDP4
INDIRF4
ADDRLP4 20
INDIRF4
MULF4
ADDF4
ASGNF4
LABELV $344
line 871
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $343
line 873
;873:	wishvel[2] += pm->cmd.upmove;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CVIF4 4
ADDF4
ASGNF4
line 875
;874:
;875:	VectorCopy(wishvel, wishdir);
ADDRLP4 32
ADDRLP4 4
INDIRB
ASGNB 12
line 876
;876:	wishspeed = VectorNormalize(wishdir);
ADDRLP4 32
ARGP4
ADDRLP4 76
ADDRGP4 VectorNormalize
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 76
INDIRF4
ASGNF4
line 877
;877:	wishspeed *= scale;
ADDRLP4 44
ADDRLP4 44
INDIRF4
ADDRLP4 48
INDIRF4
MULF4
ASGNF4
line 879
;878:
;879:	PM_Accelerate(wishdir, wishspeed, pm_accelerate);
ADDRLP4 32
ARGP4
ADDRLP4 44
INDIRF4
ARGF4
ADDRGP4 pm_accelerate
INDIRF4
ARGF4
ADDRGP4 PM_Accelerate
CALLV
pop
line 882
;880:
;881:	// move
;882:	VectorMA(pm->ps->origin, pml.frametime, pm->ps->velocity, pm->ps->origin);
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 20
ADDP4
ADDRLP4 80
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 88
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 28
ADDP4
ADDRLP4 88
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 88
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRGP4 pml+36
INDIRF4
MULF4
ADDF4
ASGNF4
line 883
;883:}
LABELV $334
endproc PM_NoclipMove 92 12
proc PM_FootstepForSurface 0 0
line 894
;884:
;885://============================================================================
;886:
;887:/*
;888:================
;889:PM_FootstepForSurface
;890:
;891:Returns an event number apropriate for the groundsurface
;892:================
;893:*/
;894:static int PM_FootstepForSurface(void) {
line 895
;895:	if (pml.groundTrace.surfaceFlags & SURF_NOSTEPS) {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $353
line 896
;896:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $352
JUMPV
LABELV $353
line 898
;897:	}
;898:	if (pml.groundTrace.surfaceFlags & SURF_METALSTEPS) {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $357
line 899
;899:		return EV_FOOTSTEP_METAL;
CNSTI4 2
RETI4
ADDRGP4 $352
JUMPV
LABELV $357
line 901
;900:	}
;901:	return EV_FOOTSTEP;
CNSTI4 1
RETI4
LABELV $352
endproc PM_FootstepForSurface 0 0
proc PM_CrashLand 52 4
line 912
;902:}
;903:
;904:
;905:/*
;906:=================
;907:PM_CrashLand
;908:
;909:Check for hard landings that generate sound events
;910:=================
;911:*/
;912:static void PM_CrashLand(void) {
line 920
;913:	float		delta;
;914:	float		dist;
;915:	float		vel, acc;
;916:	float		t;
;917:	float		a, b, c, den;
;918:
;919:	// decide which landing animation to use
;920:	if (pm->ps->pm_flags & PMF_BACKWARDS_JUMP) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $362
line 921
;921:		PM_ForceLegsAnim(LEGS_LANDB);
CNSTI4 21
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 922
;922:	} else {
ADDRGP4 $363
JUMPV
LABELV $362
line 923
;923:		PM_ForceLegsAnim(LEGS_LAND);
CNSTI4 19
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 924
;924:	}
LABELV $363
line 926
;925:
;926:	pm->ps->legsTimer = TIMER_LAND;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 130
ASGNI4
line 929
;927:
;928:	// calculate the exact velocity on landing
;929:	dist = pm->ps->origin[2] - pml.previous_origin[2];
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRGP4 pml+112+8
INDIRF4
SUBF4
ASGNF4
line 930
;930:	vel = pml.previous_velocity[2];
ADDRLP4 8
ADDRGP4 pml+124+8
INDIRF4
ASGNF4
line 931
;931:	acc = -pm->ps->gravity;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
NEGI4
CVIF4 4
ASGNF4
line 933
;932:
;933:	a = acc / 2;
ADDRLP4 16
ADDRLP4 12
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 934
;934:	b = vel;
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 935
;935:	c = -dist;
ADDRLP4 32
ADDRLP4 24
INDIRF4
NEGF4
ASGNF4
line 937
;936:
;937:	den = b * b - 4 * a * c;
ADDRLP4 20
ADDRLP4 4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
ADDRLP4 16
INDIRF4
CNSTF4 1082130432
MULF4
ADDRLP4 32
INDIRF4
MULF4
SUBF4
ASGNF4
line 938
;938:	if (den < 0) {
ADDRLP4 20
INDIRF4
CNSTF4 0
GEF4 $368
line 939
;939:		return;
ADDRGP4 $361
JUMPV
LABELV $368
line 941
;940:	}
;941:	t = (-b - sqrt(den)) / (2 * a);
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 40
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 4
INDIRF4
NEGF4
ADDRLP4 40
INDIRF4
SUBF4
ADDRLP4 16
INDIRF4
CNSTF4 1073741824
MULF4
DIVF4
ASGNF4
line 943
;942:
;943:	delta = vel + t * acc;
ADDRLP4 0
ADDRLP4 8
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 944
;944:	delta = delta * delta * 0.0001;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 953267991
MULF4
ASGNF4
line 947
;945:
;946:	// ducking while falling doubles damage
;947:	if (pm->ps->pm_flags & PMF_DUCKED) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $370
line 948
;948:		delta *= 2;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1073741824
MULF4
ASGNF4
line 949
;949:	}
LABELV $370
line 952
;950:
;951:	// never take falling damage if completely underwater
;952:	if (pm->waterlevel == 3) {
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 3
NEI4 $372
line 953
;953:		return;
ADDRGP4 $361
JUMPV
LABELV $372
line 957
;954:	}
;955:
;956:	// reduce falling damage if there is standing water
;957:	if (pm->waterlevel == 2) {
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
NEI4 $374
line 958
;958:		delta *= 0.25;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1048576000
MULF4
ASGNF4
line 959
;959:	}
LABELV $374
line 960
;960:	if (pm->waterlevel == 1) {
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
NEI4 $376
line 961
;961:		delta *= 0.5;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1056964608
MULF4
ASGNF4
line 962
;962:	}
LABELV $376
line 964
;963:
;964:	if (delta < 1) {
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
GEF4 $378
line 965
;965:		return;
ADDRGP4 $361
JUMPV
LABELV $378
line 972
;966:	}
;967:
;968:	// create a local entity event to play the sound
;969:
;970:	// SURF_NODAMAGE is used for bounce pads where you don't ever
;971:	// want to take damage or play a crunch sound
;972:	if (!(pml.groundTrace.surfaceFlags & SURF_NODAMAGE)) {
ADDRGP4 pml+52+44
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $380
line 973
;973:		if (delta > 60) {
ADDRLP4 0
INDIRF4
CNSTF4 1114636288
LEF4 $384
line 974
;974:			PM_AddEvent(EV_FALL_FAR);
CNSTI4 12
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 975
;975:		} else if (delta > 40) {
ADDRGP4 $385
JUMPV
LABELV $384
ADDRLP4 0
INDIRF4
CNSTF4 1109393408
LEF4 $386
line 977
;976:			// this is a pain grunt, so don't play it if dead
;977:			if (pm->ps->stats[STAT_HEALTH] > 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $387
line 978
;978:				PM_AddEvent(EV_FALL_MEDIUM);
CNSTI4 11
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 979
;979:			}
line 980
;980:		} else if (delta > 7) {
ADDRGP4 $387
JUMPV
LABELV $386
ADDRLP4 0
INDIRF4
CNSTF4 1088421888
LEF4 $390
line 981
;981:			PM_AddEvent(EV_FALL_SHORT);
CNSTI4 10
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 982
;982:		} else {
ADDRGP4 $391
JUMPV
LABELV $390
line 983
;983:			PM_AddEvent(PM_FootstepForSurface());
ADDRLP4 48
ADDRGP4 PM_FootstepForSurface
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 984
;984:		}
LABELV $391
LABELV $387
LABELV $385
line 985
;985:	}
LABELV $380
line 988
;986:
;987:	// start footstep cycle over
;988:	pm->ps->bobCycle = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 0
ASGNI4
line 989
;989:}
LABELV $361
endproc PM_CrashLand 52 4
proc PM_CorrectAllSolid 36 28
line 1012
;990:
;991:/*
;992:=============
;993:PM_CheckStuck
;994:=============
;995:*/
;996:/*
;997:void PM_CheckStuck(void) {
;998:	trace_t trace;
;999:
;1000:	pm->trace (&trace, pm->ps->origin, pm->mins, pm->maxs, pm->ps->origin, pm->ps->clientNum, pm->tracemask);
;1001:	if (trace.allsolid) {
;1002:		//int shit = qtrue;
;1003:	}
;1004:}
;1005:*/
;1006:
;1007:/*
;1008:=============
;1009:PM_CorrectAllSolid
;1010:=============
;1011:*/
;1012:static int PM_CorrectAllSolid(trace_t *trace) {
line 1016
;1013:	int			i, j, k;
;1014:	vec3_t		point;
;1015:
;1016:	if (pm->debugLevel) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $393
line 1017
;1017:		Com_Printf("%i:allsolid\n", c_pmove);
ADDRGP4 $395
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1018
;1018:	}
LABELV $393
line 1021
;1019:
;1020:	// jitter around
;1021:	for (i = -1; i <= 1; i++) {
ADDRLP4 20
CNSTI4 -1
ASGNI4
LABELV $396
line 1022
;1022:		for (j = -1; j <= 1; j++) {
ADDRLP4 16
CNSTI4 -1
ASGNI4
LABELV $400
line 1023
;1023:			for (k = -1; k <= 1; k++) {
ADDRLP4 12
CNSTI4 -1
ASGNI4
LABELV $404
line 1024
;1024:				VectorCopy(pm->ps->origin, point);
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1025
;1025:				point[0] += (float)i;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 20
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1026
;1026:				point[1] += (float)j;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 16
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1027
;1027:				point[2] += (float)k;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1028
;1028:				pm->trace(trace, point, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CNSTI4 176
ADDP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 188
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CALLV
pop
line 1029
;1029:				if (!trace->allsolid) {
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $410
line 1030
;1030:					point[0] = pm->ps->origin[0];
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1031
;1031:					point[1] = pm->ps->origin[1];
ADDRLP4 0+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1032
;1032:					point[2] = pm->ps->origin[2] - 0.25;
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1048576000
SUBF4
ASGNF4
line 1034
;1033:
;1034:					pm->trace(trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 28
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 176
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 188
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 32
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CALLV
pop
line 1035
;1035:					pml.groundTrace = *trace;
ADDRGP4 pml+52
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 56
line 1036
;1036:					return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $392
JUMPV
LABELV $410
line 1038
;1037:				}
;1038:			}
LABELV $405
line 1023
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 1
LEI4 $404
line 1039
;1039:		}
LABELV $401
line 1022
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
LEI4 $400
line 1040
;1040:	}
LABELV $397
line 1021
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 1
LEI4 $396
line 1042
;1041:
;1042:	pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1043
;1043:	pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1044
;1044:	pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1046
;1045:
;1046:	return qfalse;
CNSTI4 0
RETI4
LABELV $392
endproc PM_CorrectAllSolid 36 28
proc PM_GroundTraceMissed 80 28
line 1057
;1047:}
;1048:
;1049:
;1050:/*
;1051:=============
;1052:PM_GroundTraceMissed
;1053:
;1054:The ground trace didn't hit a surface, so we are in freefall
;1055:=============
;1056:*/
;1057:static void PM_GroundTraceMissed(void) {
line 1061
;1058:	trace_t		trace;
;1059:	vec3_t		point;
;1060:
;1061:	if (pm->ps->groundEntityNum != ENTITYNUM_NONE) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $418
line 1063
;1062:		// we just transitioned into freefall
;1063:		if (pm->debugLevel) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $420
line 1064
;1064:			Com_Printf("%i:lift\n", c_pmove);
ADDRGP4 $422
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1065
;1065:		}
LABELV $420
line 1069
;1066:
;1067:		// if they aren't in a jumping animation and the ground is a ways away, force into it
;1068:		// if we didn't do the trace, the player would be backflipping down staircases
;1069:		VectorCopy(pm->ps->origin, point);
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1070
;1070:		point[2] -= 64;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1115684864
SUBF4
ASGNF4
line 1072
;1071:
;1072:		pm->trace(&trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRLP4 12
ARGP4
ADDRLP4 68
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 176
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 188
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CALLV
pop
line 1073
;1073:		if (trace.fraction == 1.0) {
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
NEF4 $424
line 1074
;1074:			if (pm->cmd.forwardmove >= 0) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LTI4 $427
line 1075
;1075:				PM_ForceLegsAnim(LEGS_JUMP);
CNSTI4 18
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1076
;1076:				pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 1077
;1077:			} else {
ADDRGP4 $428
JUMPV
LABELV $427
line 1078
;1078:				PM_ForceLegsAnim(LEGS_JUMPB);
CNSTI4 20
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1079
;1079:				pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1080
;1080:			}
LABELV $428
line 1081
;1081:		}
LABELV $424
line 1082
;1082:	}
LABELV $418
line 1084
;1083:
;1084:	pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1085
;1085:	pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1086
;1086:	pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1087
;1087:}
LABELV $417
endproc PM_GroundTraceMissed 80 28
proc PM_GroundTrace 84 28
line 1095
;1088:
;1089:
;1090:/*
;1091:=============
;1092:PM_GroundTrace
;1093:=============
;1094:*/
;1095:static void PM_GroundTrace(void) {
line 1099
;1096:	vec3_t		point;
;1097:	trace_t		trace;
;1098:
;1099:	point[0] = pm->ps->origin[0];
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1100
;1100:	point[1] = pm->ps->origin[1];
ADDRLP4 56+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1101
;1101:	point[2] = pm->ps->origin[2] - 0.25;
ADDRLP4 56+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1048576000
SUBF4
ASGNF4
line 1103
;1102:
;1103:	pm->trace(&trace, pm->ps->origin, pm->mins, pm->maxs, point, pm->ps->clientNum, pm->tracemask);
ADDRLP4 0
ARGP4
ADDRLP4 68
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 72
ADDRLP4 68
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 176
ADDP4
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 188
ADDP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CALLV
pop
line 1104
;1104:	pml.groundTrace = trace;
ADDRGP4 pml+52
ADDRLP4 0
INDIRB
ASGNB 56
line 1107
;1105:
;1106:	// do something corrective if the trace starts in a solid...
;1107:	if (trace.allsolid) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $435
line 1108
;1108:		if (!PM_CorrectAllSolid(&trace))
ADDRLP4 0
ARGP4
ADDRLP4 76
ADDRGP4 PM_CorrectAllSolid
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $437
line 1109
;1109:			return;
ADDRGP4 $431
JUMPV
LABELV $437
line 1110
;1110:	}
LABELV $435
line 1113
;1111:
;1112:	// if the trace didn't hit anything, we are in free fall
;1113:	if (trace.fraction == 1.0) {
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
NEF4 $439
line 1114
;1114:		PM_GroundTraceMissed();
ADDRGP4 PM_GroundTraceMissed
CALLV
pop
line 1115
;1115:		pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1116
;1116:		pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1117
;1117:		return;
ADDRGP4 $431
JUMPV
LABELV $439
line 1121
;1118:	}
;1119:
;1120:	// check if getting thrown off the ground
;1121:	if (pm->ps->velocity[2] > 0 && DotProduct(pm->ps->velocity, trace.plane.normal) > 10) {
ADDRLP4 76
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 0
LEF4 $444
ADDRLP4 76
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 0+24
INDIRF4
MULF4
ADDRLP4 76
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 0+24+4
INDIRF4
MULF4
ADDF4
ADDRLP4 76
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 0+24+8
INDIRF4
MULF4
ADDF4
CNSTF4 1092616192
LEF4 $444
line 1122
;1122:		if (pm->debugLevel) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $451
line 1123
;1123:			Com_Printf("%i:kickoff\n", c_pmove);
ADDRGP4 $453
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1124
;1124:		}
LABELV $451
line 1126
;1125:		// go into jump animation
;1126:		if (pm->cmd.forwardmove >= 0) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LTI4 $454
line 1127
;1127:			PM_ForceLegsAnim(LEGS_JUMP);
CNSTI4 18
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1128
;1128:			pm->ps->pm_flags &= ~PMF_BACKWARDS_JUMP;
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 1129
;1129:		} else {
ADDRGP4 $455
JUMPV
LABELV $454
line 1130
;1130:			PM_ForceLegsAnim(LEGS_JUMPB);
CNSTI4 20
ARGI4
ADDRGP4 PM_ForceLegsAnim
CALLV
pop
line 1131
;1131:			pm->ps->pm_flags |= PMF_BACKWARDS_JUMP;
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 1132
;1132:		}
LABELV $455
line 1134
;1133:
;1134:		pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1135
;1135:		pml.groundPlane = qfalse;
ADDRGP4 pml+48
CNSTI4 0
ASGNI4
line 1136
;1136:		pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1137
;1137:		return;
ADDRGP4 $431
JUMPV
LABELV $444
line 1141
;1138:	}
;1139:
;1140:	// slopes that are too steep will not be considered onground
;1141:	if (trace.plane.normal[2] < MIN_WALK_NORMAL) {
ADDRLP4 0+24+8
INDIRF4
CNSTF4 1060320051
GEF4 $458
line 1142
;1142:		if (pm->debugLevel) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $462
line 1143
;1143:			Com_Printf("%i:steep\n", c_pmove);
ADDRGP4 $464
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1144
;1144:		}
LABELV $462
line 1147
;1145:		// FIXME: if they can't slide down the slope, let them
;1146:		// walk (sharp crevices)
;1147:		pm->ps->groundEntityNum = ENTITYNUM_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
CNSTI4 1023
ASGNI4
line 1148
;1148:		pml.groundPlane = qtrue;
ADDRGP4 pml+48
CNSTI4 1
ASGNI4
line 1149
;1149:		pml.walking = qfalse;
ADDRGP4 pml+44
CNSTI4 0
ASGNI4
line 1150
;1150:		return;
ADDRGP4 $431
JUMPV
LABELV $458
line 1153
;1151:	}
;1152:
;1153:	pml.groundPlane = qtrue;
ADDRGP4 pml+48
CNSTI4 1
ASGNI4
line 1154
;1154:	pml.walking = qtrue;
ADDRGP4 pml+44
CNSTI4 1
ASGNI4
line 1157
;1155:
;1156:	// hitting solid ground will end a waterjump
;1157:	if (pm->ps->pm_flags & PMF_TIME_WATERJUMP) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $469
line 1158
;1158:		pm->ps->pm_flags &= ~(PMF_TIME_WATERJUMP | PMF_TIME_LAND);
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 -289
BANDI4
ASGNI4
line 1159
;1159:		pm->ps->pm_time = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 1160
;1160:	}
LABELV $469
line 1162
;1161:
;1162:	if (pm->ps->groundEntityNum == ENTITYNUM_NONE) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $471
line 1164
;1163:		// just hit the ground
;1164:		if (pm->debugLevel) {
ADDRGP4 pm
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 0
EQI4 $473
line 1165
;1165:			Com_Printf("%i:Land\n", c_pmove);
ADDRGP4 $475
ARGP4
ADDRGP4 c_pmove
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 1166
;1166:		}
LABELV $473
line 1168
;1167:
;1168:		PM_CrashLand();
ADDRGP4 PM_CrashLand
CALLV
pop
line 1171
;1169:
;1170:		// don't do landing time if we were just going down a slope
;1171:		if (pml.previous_velocity[2] < -200) {
ADDRGP4 pml+124+8
INDIRF4
CNSTF4 3276275712
GEF4 $476
line 1173
;1172:			// don't allow another jump for a little while
;1173:			pm->ps->pm_flags |= PMF_TIME_LAND;
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 1174
;1174:			pm->ps->pm_time = 250;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 250
ASGNI4
line 1175
;1175:		}
LABELV $476
line 1176
;1176:	}
LABELV $471
line 1178
;1177:
;1178:	pm->ps->groundEntityNum = trace.entityNum;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
ADDRLP4 0+52
INDIRI4
ASGNI4
line 1183
;1179:
;1180:	// don't reset the z velocity for slopes
;1181://	pm->ps->velocity[2] = 0;
;1182:
;1183:	PM_AddTouchEnt(trace.entityNum);
ADDRLP4 0+52
INDIRI4
ARGI4
ADDRGP4 PM_AddTouchEnt
CALLV
pop
line 1184
;1184:}
LABELV $431
endproc PM_GroundTrace 84 28
proc PM_SetWaterLevel 48 8
line 1192
;1185:
;1186:
;1187:/*
;1188:=============
;1189:PM_SetWaterLevel	FIXME: avoid this twice?  certainly if not moving
;1190:=============
;1191:*/
;1192:static void PM_SetWaterLevel(void) {
line 1201
;1193:	vec3_t		point;
;1194:	int			cont;
;1195:	int			sample1;
;1196:	int			sample2;
;1197:
;1198:	//
;1199:	// get waterlevel, accounting for ducking
;1200:	//
;1201:	pm->waterlevel = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 0
ASGNI4
line 1202
;1202:	pm->watertype = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTI4 0
ASGNI4
line 1204
;1203:
;1204:	point[0] = pm->ps->origin[0];
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
line 1205
;1205:	point[1] = pm->ps->origin[1];
ADDRLP4 0+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 1206
;1206:	point[2] = pm->ps->origin[2] + MINS_Z + 1;
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
CNSTF4 1065353216
ADDF4
ASGNF4
line 1207
;1207:	cont = pm->pointcontents(point, pm->ps->clientNum);
ADDRLP4 0
ARGP4
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 28
INDIRI4
ASGNI4
line 1209
;1208:
;1209:	if (cont & MASK_WATER) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $485
line 1210
;1210:		sample2 = pm->ps->viewheight - MINS_Z;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 -24
SUBI4
ASGNI4
line 1211
;1211:		sample1 = sample2 / 2;
ADDRLP4 20
ADDRLP4 16
INDIRI4
CNSTI4 2
DIVI4
ASGNI4
line 1213
;1212:
;1213:		pm->watertype = cont;
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 1214
;1214:		pm->waterlevel = 1;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 1
ASGNI4
line 1215
;1215:		point[2] = pm->ps->origin[2] + MINS_Z + sample1;
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
ADDRLP4 20
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1216
;1216:		cont = pm->pointcontents(point, pm->ps->clientNum);
ADDRLP4 0
ARGP4
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 36
INDIRI4
ASGNI4
line 1217
;1217:		if (cont & MASK_WATER) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $488
line 1218
;1218:			pm->waterlevel = 2;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 2
ASGNI4
line 1219
;1219:			point[2] = pm->ps->origin[2] + MINS_Z + sample2;
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 3250585600
ADDF4
ADDRLP4 16
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1220
;1220:			cont = pm->pointcontents(point, pm->ps->clientNum);
ADDRLP4 0
ARGP4
ADDRLP4 40
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ADDRLP4 40
INDIRP4
CNSTI4 220
ADDP4
INDIRP4
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 44
INDIRI4
ASGNI4
line 1221
;1221:			if (cont & MASK_WATER) {
ADDRLP4 12
INDIRI4
CNSTI4 56
BANDI4
CNSTI4 0
EQI4 $491
line 1222
;1222:				pm->waterlevel = 3;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 3
ASGNI4
line 1223
;1223:			}
LABELV $491
line 1224
;1224:		}
LABELV $488
line 1225
;1225:	}
LABELV $485
line 1227
;1226:
;1227:}
LABELV $482
endproc PM_SetWaterLevel 48 8
proc PM_CheckDuck 72 28
line 1236
;1228:
;1229:/*
;1230:==============
;1231:PM_CheckDuck
;1232:
;1233:Sets mins, maxs, and pm->ps->viewheight
;1234:==============
;1235:*/
;1236:static void PM_CheckDuck(void) {
line 1239
;1237:	trace_t	trace;
;1238:
;1239:	if (pm->ps->powerups[PW_INVULNERABILITY]) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 368
ADDP4
INDIRI4
CNSTI4 0
EQI4 $494
line 1240
;1240:		if (pm->ps->pm_flags & PMF_INVULEXPAND) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $496
line 1242
;1241:			// invulnerability sphere has a 42 units radius
;1242:			VectorSet(pm->mins, -42, -42, -42);
ADDRGP4 pm
INDIRP4
CNSTI4 176
ADDP4
CNSTF4 3257401344
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 3257401344
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 3257401344
ASGNF4
line 1243
;1243:			VectorSet(pm->maxs, 42, 42, 42);
ADDRGP4 pm
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1109917696
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 1109917696
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1109917696
ASGNF4
line 1244
;1244:		} else {
ADDRGP4 $497
JUMPV
LABELV $496
line 1245
;1245:			VectorSet(pm->mins, -15, -15, MINS_Z);
ADDRGP4 pm
INDIRP4
CNSTI4 176
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 3245342720
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 3250585600
ASGNF4
line 1246
;1246:			VectorSet(pm->maxs, 15, 15, 16);
ADDRGP4 pm
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 1097859072
ASGNF4
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1098907648
ASGNF4
line 1247
;1247:		}
LABELV $497
line 1248
;1248:		pm->ps->pm_flags |= PMF_DUCKED;
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1249
;1249:		pm->ps->viewheight = CROUCH_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 12
ASGNI4
line 1250
;1250:		return;
ADDRGP4 $493
JUMPV
LABELV $494
line 1252
;1251:	}
;1252:	pm->ps->pm_flags &= ~PMF_INVULEXPAND;
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 -16385
BANDI4
ASGNI4
line 1254
;1253:
;1254:	pm->mins[0] = -15;
ADDRGP4 pm
INDIRP4
CNSTI4 176
ADDP4
CNSTF4 3245342720
ASGNF4
line 1255
;1255:	pm->mins[1] = -15;
ADDRGP4 pm
INDIRP4
CNSTI4 180
ADDP4
CNSTF4 3245342720
ASGNF4
line 1257
;1256:
;1257:	pm->maxs[0] = 15;
ADDRGP4 pm
INDIRP4
CNSTI4 188
ADDP4
CNSTF4 1097859072
ASGNF4
line 1258
;1258:	pm->maxs[1] = 15;
ADDRGP4 pm
INDIRP4
CNSTI4 192
ADDP4
CNSTF4 1097859072
ASGNF4
line 1260
;1259:
;1260:	pm->mins[2] = MINS_Z;
ADDRGP4 pm
INDIRP4
CNSTI4 184
ADDP4
CNSTF4 3250585600
ASGNF4
line 1262
;1261:
;1262:	if (pm->ps->pm_type == PM_DEAD) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $498
line 1263
;1263:		pm->maxs[2] = -8;
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 3238002688
ASGNF4
line 1264
;1264:		pm->ps->viewheight = DEAD_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 -16
ASGNI4
line 1265
;1265:		return;
ADDRGP4 $493
JUMPV
LABELV $498
line 1268
;1266:	}
;1267:
;1268:	if (pm->cmd.upmove < 0) {	// duck
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $500
line 1269
;1269:		pm->ps->pm_flags |= PMF_DUCKED;
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 60
INDIRP4
ADDRLP4 60
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
line 1270
;1270:	} else {	// stand up if possible
ADDRGP4 $501
JUMPV
LABELV $500
line 1271
;1271:		if (pm->ps->pm_flags & PMF_DUCKED) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $502
line 1273
;1272:			// try to stand up
;1273:			pm->maxs[2] = 32;
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1107296256
ASGNF4
line 1274
;1274:			pm->trace(&trace, pm->ps->origin, pm->mins, pm->maxs, pm->ps->origin, pm->ps->clientNum, pm->tracemask);
ADDRLP4 0
ARGP4
ADDRLP4 60
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 60
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 176
ADDP4
ARGP4
ADDRLP4 60
INDIRP4
CNSTI4 188
ADDP4
ARGP4
ADDRLP4 64
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 64
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
INDIRP4
CNSTI4 216
ADDP4
INDIRP4
CALLV
pop
line 1275
;1275:			if (!trace.allsolid)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $504
line 1276
;1276:				pm->ps->pm_flags &= ~PMF_DUCKED;
ADDRLP4 68
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
LABELV $504
line 1277
;1277:		}
LABELV $502
line 1278
;1278:	}
LABELV $501
line 1280
;1279:
;1280:	if (pm->ps->pm_flags & PMF_DUCKED) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $506
line 1281
;1281:		pm->maxs[2] = 16;
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1098907648
ASGNF4
line 1282
;1282:		pm->ps->viewheight = CROUCH_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 12
ASGNI4
line 1283
;1283:	} else {
ADDRGP4 $507
JUMPV
LABELV $506
line 1284
;1284:		pm->maxs[2] = 32;
ADDRGP4 pm
INDIRP4
CNSTI4 196
ADDP4
CNSTF4 1107296256
ASGNF4
line 1285
;1285:		pm->ps->viewheight = DEFAULT_VIEWHEIGHT;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 164
ADDP4
CNSTI4 26
ASGNI4
line 1286
;1286:	}
LABELV $507
line 1287
;1287:}
LABELV $493
endproc PM_CheckDuck 72 28
proc PM_Footsteps 24 4
line 1299
;1288:
;1289:
;1290:
;1291://===================================================================
;1292:
;1293:
;1294:/*
;1295:===============
;1296:PM_Footsteps
;1297:===============
;1298:*/
;1299:static void PM_Footsteps(void) {
line 1312
;1300:	float		bobmove;
;1301:	float		xyspeedQ;
;1302:	int			old;
;1303:	qboolean	footstep;
;1304:
;1305:	//
;1306:	// calculate speed and cycle to be used for
;1307:	// all cyclic walking effects
;1308:	//
;1309:	//xyspeedQ = pm->ps->velocity[0] * pm->ps->velocity[0] 
;1310:	//	+ pm->ps->velocity[1] * pm->ps->velocity[1];
;1311:
;1312:	if (pm->ps->groundEntityNum == ENTITYNUM_NONE) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $509
line 1314
;1313:
;1314:		if (pm->ps->powerups[PW_INVULNERABILITY]) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 368
ADDP4
INDIRI4
CNSTI4 0
EQI4 $511
line 1315
;1315:			PM_ContinueLegsAnim(LEGS_IDLECR);
CNSTI4 23
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1316
;1316:		}
LABELV $511
line 1318
;1317:		// airborne leaves position in cycle intact, but doesn't advance
;1318:		if (pm->waterlevel > 1) {
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
LEI4 $508
line 1319
;1319:			PM_ContinueLegsAnim(LEGS_SWIM);
CNSTI4 17
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1320
;1320:		}
line 1321
;1321:		return;
ADDRGP4 $508
JUMPV
LABELV $509
line 1325
;1322:	}
;1323:
;1324:	// if not trying to move
;1325:	if (!pm->cmd.forwardmove && !pm->cmd.rightmove) {
ADDRLP4 16
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $515
ADDRLP4 16
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $515
line 1326
;1326:		xyspeedQ = pm->ps->velocity[0] * pm->ps->velocity[0]
ADDRLP4 20
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 20
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
MULF4
ADDRLP4 20
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1328
;1327:			+ pm->ps->velocity[1] * pm->ps->velocity[1];
;1328:		if (xyspeedQ < 5.0 * 5.0) { // not using sqrt() there
ADDRLP4 12
INDIRF4
CNSTF4 1103626240
GEF4 $508
line 1329
;1329:			pm->ps->bobCycle = 0;	// start at beginning of cycle again
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 0
ASGNI4
line 1330
;1330:			if (pm->ps->pm_flags & PMF_DUCKED) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $519
line 1331
;1331:				PM_ContinueLegsAnim(LEGS_IDLECR);
CNSTI4 23
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1332
;1332:			} else {
ADDRGP4 $508
JUMPV
LABELV $519
line 1333
;1333:				PM_ContinueLegsAnim(LEGS_IDLE);
CNSTI4 22
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1334
;1334:			}
line 1335
;1335:		}
line 1336
;1336:		return;
ADDRGP4 $508
JUMPV
LABELV $515
line 1340
;1337:	}
;1338:
;1339:
;1340:	footstep = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1342
;1341:
;1342:	if (pm->ps->pm_flags & PMF_DUCKED) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $521
line 1343
;1343:		bobmove = 0.5;	// ducked characters bob much faster
ADDRLP4 4
CNSTF4 1056964608
ASGNF4
line 1344
;1344:		if (pm->ps->pm_flags & PMF_BACKWARDS_RUN) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $523
line 1345
;1345:			PM_ContinueLegsAnim(LEGS_BACKCR);
CNSTI4 32
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1346
;1346:		} else {
ADDRGP4 $522
JUMPV
LABELV $523
line 1347
;1347:			PM_ContinueLegsAnim(LEGS_WALKCR);
CNSTI4 13
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1348
;1348:		}
line 1360
;1349:		// ducked characters never play footsteps
;1350:	/*
;1351:	} else 	if ( pm->ps->pm_flags & PMF_BACKWARDS_RUN ) {
;1352:		if ( !( pm->cmd.buttons & BUTTON_WALKING ) ) {
;1353:			bobmove = 0.4;	// faster speeds bob faster
;1354:			footstep = qtrue;
;1355:		} else {
;1356:			bobmove = 0.3;
;1357:		}
;1358:		PM_ContinueLegsAnim( LEGS_BACK );
;1359:	*/
;1360:	} else {
ADDRGP4 $522
JUMPV
LABELV $521
line 1361
;1361:		if (!(pm->cmd.buttons & BUTTON_WALKING)) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $525
line 1362
;1362:			bobmove = 0.4f;	// faster speeds bob faster
ADDRLP4 4
CNSTF4 1053609165
ASGNF4
line 1363
;1363:			if (pm->ps->pm_flags & PMF_BACKWARDS_RUN) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $527
line 1364
;1364:				PM_ContinueLegsAnim(LEGS_BACK);
CNSTI4 16
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1365
;1365:			} else {
ADDRGP4 $528
JUMPV
LABELV $527
line 1366
;1366:				PM_ContinueLegsAnim(LEGS_RUN);
CNSTI4 15
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1367
;1367:			}
LABELV $528
line 1368
;1368:			footstep = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 1369
;1369:		} else {
ADDRGP4 $526
JUMPV
LABELV $525
line 1370
;1370:			bobmove = 0.3f;	// walking bobs slow
ADDRLP4 4
CNSTF4 1050253722
ASGNF4
line 1371
;1371:			if (pm->ps->pm_flags & PMF_BACKWARDS_RUN) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $529
line 1372
;1372:				PM_ContinueLegsAnim(LEGS_BACKWALK);
CNSTI4 33
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1373
;1373:			} else {
ADDRGP4 $530
JUMPV
LABELV $529
line 1374
;1374:				PM_ContinueLegsAnim(LEGS_WALK);
CNSTI4 14
ARGI4
ADDRGP4 PM_ContinueLegsAnim
CALLV
pop
line 1375
;1375:			}
LABELV $530
line 1376
;1376:		}
LABELV $526
line 1377
;1377:	}
LABELV $522
line 1380
;1378:
;1379:	// check for footstep / splash sounds
;1380:	old = pm->ps->bobCycle;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 1381
;1381:	pm->ps->bobCycle = (int)(old + bobmove * pml.msec) & 255;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
ADDRGP4 pml+40
INDIRI4
CVIF4 4
MULF4
ADDF4
CVFI4 4
CNSTI4 255
BANDI4
ASGNI4
line 1384
;1382:
;1383:	// if we just crossed a cycle boundary, play an apropriate footstep event
;1384:	if (((old + 64) ^ (pm->ps->bobCycle + 64)) & 128) {
ADDRLP4 0
INDIRI4
CNSTI4 64
ADDI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 64
ADDI4
BXORI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $532
line 1385
;1385:		if (pm->waterlevel == 0) {
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
NEI4 $534
line 1387
;1386:			// on ground will only play sounds if running
;1387:			if (footstep) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $535
line 1388
;1388:				PM_AddEvent(PM_FootstepForSurface());
ADDRLP4 20
ADDRGP4 PM_FootstepForSurface
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1389
;1389:			}
line 1390
;1390:		} else if (pm->waterlevel == 1) {
ADDRGP4 $535
JUMPV
LABELV $534
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
NEI4 $538
line 1392
;1391:			// splashing
;1392:			PM_AddEvent(EV_FOOTSPLASH);
CNSTI4 3
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1393
;1393:		} else if (pm->waterlevel == 2) {
ADDRGP4 $539
JUMPV
LABELV $538
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 2
NEI4 $540
line 1395
;1394:			// wading / swimming at surface
;1395:			PM_AddEvent(EV_SWIM);
CNSTI4 5
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1396
;1396:		} else if (pm->waterlevel == 3) {
ADDRGP4 $541
JUMPV
LABELV $540
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 3
NEI4 $542
line 1399
;1397:			// no sound when completely underwater
;1398:
;1399:		}
LABELV $542
LABELV $541
LABELV $539
LABELV $535
line 1400
;1400:	}
LABELV $532
line 1401
;1401:}
LABELV $508
endproc PM_Footsteps 24 4
proc PM_WaterEvents 0 4
line 1410
;1402:
;1403:/*
;1404:==============
;1405:PM_WaterEvents
;1406:
;1407:Generate sound events for entering and leaving water
;1408:==============
;1409:*/
;1410:static void PM_WaterEvents(void) {		// FIXME?
line 1414
;1411:	//
;1412:	// if just entered a water volume, play a sound
;1413:	//
;1414:	if (!pml.previous_waterlevel && pm->waterlevel) {
ADDRGP4 pml+136
INDIRI4
CNSTI4 0
NEI4 $545
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
EQI4 $545
line 1415
;1415:		PM_AddEvent(EV_WATER_TOUCH);
CNSTI4 15
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1416
;1416:	}
LABELV $545
line 1421
;1417:
;1418:	//
;1419:	// if just completely exited a water volume, play a sound
;1420:	//
;1421:	if (pml.previous_waterlevel && !pm->waterlevel) {
ADDRGP4 pml+136
INDIRI4
CNSTI4 0
EQI4 $548
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 0
NEI4 $548
line 1422
;1422:		PM_AddEvent(EV_WATER_LEAVE);
CNSTI4 16
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1423
;1423:	}
LABELV $548
line 1428
;1424:
;1425:	//
;1426:	// check for head just going under water
;1427:	//
;1428:	if (pml.previous_waterlevel != 3 && pm->waterlevel == 3) {
ADDRGP4 pml+136
INDIRI4
CNSTI4 3
EQI4 $551
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 3
NEI4 $551
line 1429
;1429:		PM_AddEvent(EV_WATER_UNDER);
CNSTI4 17
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1430
;1430:	}
LABELV $551
line 1435
;1431:
;1432:	//
;1433:	// check for head just coming out of water
;1434:	//
;1435:	if (pml.previous_waterlevel == 3 && pm->waterlevel != 3) {
ADDRGP4 pml+136
INDIRI4
CNSTI4 3
NEI4 $554
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 3
EQI4 $554
line 1436
;1436:		PM_AddEvent(EV_WATER_CLEAR);
CNSTI4 18
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1437
;1437:	}
LABELV $554
line 1438
;1438:}
LABELV $544
endproc PM_WaterEvents 0 4
proc PM_BeginWeaponChange 8 4
line 1446
;1439:
;1440:
;1441:/*
;1442:===============
;1443:PM_BeginWeaponChange
;1444:===============
;1445:*/
;1446:static void PM_BeginWeaponChange(int weapon) {
line 1447
;1447:	if (weapon <= WP_NONE || weapon >= WP_NUM_WEAPONS) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $560
ADDRLP4 0
INDIRI4
CNSTI4 15
LTI4 $558
LABELV $560
line 1448
;1448:		return;
ADDRGP4 $557
JUMPV
LABELV $558
line 1451
;1449:	}
;1450:
;1451:	if (!(pm->ps->stats[STAT_WEAPONS] & (1 << weapon))) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 1
ADDRFP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $561
line 1452
;1452:		return;
ADDRGP4 $557
JUMPV
LABELV $561
line 1455
;1453:	}
;1454:
;1455:	if (pm->ps->weaponstate == WEAPON_DROPPING) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $563
line 1456
;1456:		pm->ps->eFlags &= ~EF_FIRING;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 1457
;1457:		return;
ADDRGP4 $557
JUMPV
LABELV $563
line 1460
;1458:	}
;1459:
;1460:	PM_AddEvent(EV_CHANGE_WEAPON);
CNSTI4 22
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1461
;1461:	pm->ps->weaponstate = WEAPON_DROPPING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 2
ASGNI4
line 1462
;1462:	pm->ps->weaponTime += 200;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 1463
;1463:	PM_StartTorsoAnim(TORSO_DROP);
CNSTI4 9
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1464
;1464:}
LABELV $557
endproc PM_BeginWeaponChange 8 4
proc PM_FinishWeaponChange 16 4
line 1472
;1465:
;1466:
;1467:/*
;1468:===============
;1469:PM_FinishWeaponChange
;1470:===============
;1471:*/
;1472:static void PM_FinishWeaponChange(void) {
line 1475
;1473:	int		weapon;
;1474:
;1475:	weapon = pm->cmd.weapon;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
ASGNI4
line 1476
;1476:	if (weapon < WP_NONE || weapon >= WP_NUM_WEAPONS) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $568
ADDRLP4 0
INDIRI4
CNSTI4 15
LTI4 $566
LABELV $568
line 1477
;1477:		weapon = WP_NONE;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1478
;1478:	}
LABELV $566
line 1480
;1479:
;1480:	if (!(pm->ps->stats[STAT_WEAPONS] & (1 << weapon))) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $569
line 1481
;1481:		weapon = WP_NONE;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1482
;1482:	}
LABELV $569
line 1484
;1483:
;1484:	pm->ps->weapon = weapon;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1485
;1485:	pm->ps->weaponstate = WEAPON_RAISING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 1
ASGNI4
line 1486
;1486:	pm->ps->eFlags &= ~EF_FIRING;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 1487
;1487:	pm->ps->weaponTime += 250;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 250
ADDI4
ASGNI4
line 1488
;1488:	PM_StartTorsoAnim(TORSO_RAISE);
CNSTI4 10
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1489
;1489:}
LABELV $565
endproc PM_FinishWeaponChange 16 4
proc PM_TorsoAnimation 0 4
line 1498
;1490:
;1491:
;1492:/*
;1493:==============
;1494:PM_TorsoAnimation
;1495:
;1496:==============
;1497:*/
;1498:static void PM_TorsoAnimation(void) {
line 1499
;1499:	if (pm->ps->weaponstate == WEAPON_READY) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 0
NEI4 $572
line 1500
;1500:		if (pm->ps->weapon == WP_GAUNTLET) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $574
line 1501
;1501:			PM_ContinueTorsoAnim(TORSO_STAND2);
CNSTI4 12
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1502
;1502:		} else {
ADDRGP4 $571
JUMPV
LABELV $574
line 1503
;1503:			PM_ContinueTorsoAnim(TORSO_STAND);
CNSTI4 11
ARGI4
ADDRGP4 PM_ContinueTorsoAnim
CALLV
pop
line 1504
;1504:		}
line 1505
;1505:		return;
LABELV $572
line 1507
;1506:	}
;1507:}
LABELV $571
endproc PM_TorsoAnimation 0 4
proc PM_Weapon 28 4
line 1517
;1508:
;1509:
;1510:/*
;1511:==============
;1512:PM_Weapon
;1513:
;1514:Generates weapon events and modifes the weapon counter
;1515:==============
;1516:*/
;1517:static void PM_Weapon(void) {
line 1521
;1518:	int		addTime;
;1519:
;1520:	// don't allow attack until all buttons are up
;1521:	if (pm->ps->pm_flags & PMF_RESPAWNED) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $577
line 1522
;1522:		return;
ADDRGP4 $576
JUMPV
LABELV $577
line 1526
;1523:	}
;1524:
;1525:	// ignore if spectator
;1526:	if (pm->ps->persistant[PERS_TEAM] == TEAM_SPECTATOR) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 3
NEI4 $579
line 1527
;1527:		return;
ADDRGP4 $576
JUMPV
LABELV $579
line 1531
;1528:	}
;1529:
;1530:	// check for dead player
;1531:	if (pm->ps->stats[STAT_HEALTH] <= 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $581
line 1532
;1532:		pm->ps->weapon = WP_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
CNSTI4 0
ASGNI4
line 1533
;1533:		return;
ADDRGP4 $576
JUMPV
LABELV $581
line 1537
;1534:	}
;1535:
;1536:	// check for item using
;1537:	if (pm->cmd.buttons & BUTTON_USE_HOLDABLE) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $583
line 1538
;1538:		if (!(pm->ps->pm_flags & PMF_USE_ITEM_HELD)) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
NEI4 $584
line 1539
;1539:			if (bg_itemlist[pm->ps->stats[STAT_HOLDABLE_ITEM]].giTag == HI_MEDKIT
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 2
NEI4 $587
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
CNSTI4 25
ADDI4
LTI4 $587
line 1540
;1540:				&& pm->ps->stats[STAT_HEALTH] >= (pm->ps->stats[STAT_MAX_HEALTH] + 25)) {
line 1542
;1541:				// don't use medkit if at max health
;1542:			} else {
ADDRGP4 $576
JUMPV
LABELV $587
line 1543
;1543:				pm->ps->pm_flags |= PMF_USE_ITEM_HELD;
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 1544
;1544:				PM_AddEvent(EV_USE_ITEM0 + bg_itemlist[pm->ps->stats[STAT_HOLDABLE_ITEM]].giTag);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 188
ADDP4
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 24
ADDI4
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1545
;1545:				pm->ps->stats[STAT_HOLDABLE_ITEM] = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 1546
;1546:			}
line 1547
;1547:			return;
ADDRGP4 $576
JUMPV
line 1549
;1548:		}
;1549:	} else {
LABELV $583
line 1550
;1550:		pm->ps->pm_flags &= ~PMF_USE_ITEM_HELD;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 1551
;1551:	}
LABELV $584
line 1555
;1552:
;1553:
;1554:	// make weapon function
;1555:	if (pm->ps->weaponTime > 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $591
line 1556
;1556:		pm->ps->weaponTime -= pml.msec;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1557
;1557:	}
LABELV $591
line 1562
;1558:
;1559:	// check for weapon change
;1560:	// can't change if weapon is firing, but can change
;1561:	// again if lowering or raising
;1562:	if (pm->ps->weaponTime <= 0 || pm->ps->weaponstate != WEAPON_FIRING) {
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $596
ADDRLP4 4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 3
EQI4 $594
LABELV $596
line 1563
;1563:		if (pm->ps->weapon != pm->cmd.weapon) {
ADDRLP4 8
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
EQI4 $597
line 1564
;1564:			PM_BeginWeaponChange(pm->cmd.weapon);
ADDRGP4 pm
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
ARGI4
ADDRGP4 PM_BeginWeaponChange
CALLV
pop
line 1565
;1565:		}
LABELV $597
line 1566
;1566:	}
LABELV $594
line 1568
;1567:
;1568:	if (pm->ps->weaponTime > 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $599
line 1569
;1569:		return;
ADDRGP4 $576
JUMPV
LABELV $599
line 1573
;1570:	}
;1571:
;1572:	// change weapon if time
;1573:	if (pm->ps->weaponstate == WEAPON_DROPPING) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $601
line 1574
;1574:		PM_FinishWeaponChange();
ADDRGP4 PM_FinishWeaponChange
CALLV
pop
line 1575
;1575:		return;
ADDRGP4 $576
JUMPV
LABELV $601
line 1578
;1576:	}
;1577:
;1578:	if (pm->ps->weaponstate == WEAPON_RAISING) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 1
NEI4 $603
line 1579
;1579:		pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 1580
;1580:		if (pm->ps->weapon == WP_GAUNTLET) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $605
line 1581
;1581:			PM_StartTorsoAnim(TORSO_STAND2);
CNSTI4 12
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1582
;1582:		} else {
ADDRGP4 $576
JUMPV
LABELV $605
line 1583
;1583:			PM_StartTorsoAnim(TORSO_STAND);
CNSTI4 11
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1584
;1584:		}
line 1585
;1585:		return;
ADDRGP4 $576
JUMPV
LABELV $603
line 1589
;1586:	}
;1587:
;1588:	// check for fire
;1589:	if (!(pm->cmd.buttons & BUTTON_ATTACK)) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $607
line 1590
;1590:		pm->ps->weaponTime = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 1591
;1591:		pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 1592
;1592:		return;
ADDRGP4 $576
JUMPV
LABELV $607
line 1596
;1593:	}
;1594:
;1595:	// start the animation even if out of ammo
;1596:	if (pm->ps->weapon == WP_GAUNTLET) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 1
NEI4 $609
line 1598
;1597:		// the guantlet only "fires" when it actually hits something
;1598:		if (!pm->gauntletHit) {
ADDRGP4 pm
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 0
NEI4 $611
line 1599
;1599:			pm->ps->weaponTime = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 1600
;1600:			pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 0
ASGNI4
line 1601
;1601:			return;
ADDRGP4 $576
JUMPV
LABELV $611
line 1603
;1602:		}
;1603:		PM_StartTorsoAnim(TORSO_ATTACK2);
CNSTI4 8
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1604
;1604:	} else {
ADDRGP4 $610
JUMPV
LABELV $609
line 1605
;1605:		PM_StartTorsoAnim(TORSO_ATTACK);
CNSTI4 7
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1606
;1606:	}
LABELV $610
line 1608
;1607:
;1608:	pm->ps->weaponstate = WEAPON_FIRING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
CNSTI4 3
ASGNI4
line 1611
;1609:
;1610:	// check for out of ammo
;1611:	if (!pm->ps->ammo[pm->ps->weapon]) {
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $613
line 1612
;1612:		PM_AddEvent(EV_NOAMMO);
CNSTI4 21
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1613
;1613:		pm->ps->weaponTime += 500;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 1614
;1614:		return;
ADDRGP4 $576
JUMPV
LABELV $613
line 1618
;1615:	}
;1616:
;1617:	// take an ammo away if not infinite
;1618:	if (pm->ps->ammo[pm->ps->weapon] != -1) {
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $615
line 1619
;1619:		pm->ps->ammo[pm->ps->weapon]--;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 16
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 376
ADDP4
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1620
;1620:	}
LABELV $615
line 1623
;1621:
;1622:	// fire weapon
;1623:	PM_AddEvent(EV_FIRE_WEAPON);
CNSTI4 23
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1625
;1624:
;1625:	switch (pm->ps->weapon) {
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 1
LTI4 $617
ADDRLP4 16
INDIRI4
CNSTI4 13
GTI4 $617
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $633-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $633
address $620
address $623
address $622
address $624
address $625
address $621
address $627
address $626
address $628
address $629
address $630
address $631
address $632
code
LABELV $617
LABELV $620
line 1628
;1626:	default:
;1627:	case WP_GAUNTLET:
;1628:		addTime = 400;
ADDRLP4 0
CNSTI4 400
ASGNI4
line 1629
;1629:		break;
ADDRGP4 $618
JUMPV
LABELV $621
line 1631
;1630:	case WP_LIGHTNING:
;1631:		addTime = 50;
ADDRLP4 0
CNSTI4 50
ASGNI4
line 1632
;1632:		break;
ADDRGP4 $618
JUMPV
LABELV $622
line 1634
;1633:	case WP_SHOTGUN:
;1634:		addTime = 1000;
ADDRLP4 0
CNSTI4 1000
ASGNI4
line 1635
;1635:		break;
ADDRGP4 $618
JUMPV
LABELV $623
line 1637
;1636:	case WP_MACHINEGUN:
;1637:		addTime = 100;
ADDRLP4 0
CNSTI4 100
ASGNI4
line 1638
;1638:		break;
ADDRGP4 $618
JUMPV
LABELV $624
line 1640
;1639:	case WP_GRENADE_LAUNCHER:
;1640:		addTime = 800;
ADDRLP4 0
CNSTI4 800
ASGNI4
line 1641
;1641:		break;
ADDRGP4 $618
JUMPV
LABELV $625
line 1643
;1642:	case WP_ROCKET_LAUNCHER:
;1643:		addTime = 800;
ADDRLP4 0
CNSTI4 800
ASGNI4
line 1644
;1644:		break;
ADDRGP4 $618
JUMPV
LABELV $626
line 1646
;1645:	case WP_PLASMAGUN:
;1646:		addTime = 100;
ADDRLP4 0
CNSTI4 100
ASGNI4
line 1647
;1647:		break;
ADDRGP4 $618
JUMPV
LABELV $627
line 1649
;1648:	case WP_RAILGUN:
;1649:		addTime = 1500;
ADDRLP4 0
CNSTI4 1500
ASGNI4
line 1650
;1650:		break;
ADDRGP4 $618
JUMPV
LABELV $628
line 1652
;1651:	case WP_BFG:
;1652:		addTime = 200;
ADDRLP4 0
CNSTI4 200
ASGNI4
line 1653
;1653:		break;
ADDRGP4 $618
JUMPV
LABELV $629
line 1655
;1654:	case WP_GRAPPLING_HOOK:
;1655:		addTime = 400;
ADDRLP4 0
CNSTI4 400
ASGNI4
line 1656
;1656:		break;
ADDRGP4 $618
JUMPV
LABELV $630
line 1658
;1657:	case WP_NAILGUN:
;1658:		addTime = 1000;
ADDRLP4 0
CNSTI4 1000
ASGNI4
line 1659
;1659:		break;
ADDRGP4 $618
JUMPV
LABELV $631
line 1661
;1660:	case WP_PROX_LAUNCHER:
;1661:		addTime = 800;
ADDRLP4 0
CNSTI4 800
ASGNI4
line 1662
;1662:		break;
ADDRGP4 $618
JUMPV
LABELV $632
line 1664
;1663:	case WP_CHAINGUN:
;1664:		addTime = 30;
ADDRLP4 0
CNSTI4 30
ASGNI4
line 1665
;1665:		break;
LABELV $618
line 1668
;1666:	}
;1667:
;1668:	if (bg_itemlist[pm->ps->stats[STAT_PERSISTANT_POWERUP]].giTag == PW_SCOUT) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 10
NEI4 $635
line 1669
;1669:		addTime /= 1.5;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1059760811
MULF4
CVFI4 4
ASGNI4
line 1670
;1670:	} else
ADDRGP4 $636
JUMPV
LABELV $635
line 1671
;1671:		if (bg_itemlist[pm->ps->stats[STAT_PERSISTANT_POWERUP]].giTag == PW_AMMOREGEN) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist+40
ADDP4
INDIRI4
CNSTI4 13
NEI4 $638
line 1672
;1672:			addTime /= 1.3;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1061481551
MULF4
CVFI4 4
ASGNI4
line 1673
;1673:		} else if (pm->ps->powerups[PW_HASTE]) {
ADDRGP4 $639
JUMPV
LABELV $638
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 324
ADDP4
INDIRI4
CNSTI4 0
EQI4 $641
line 1674
;1674:			addTime /= 1.3;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CVIF4 4
CNSTF4 1061481551
MULF4
CVFI4 4
ASGNI4
line 1675
;1675:		}
LABELV $641
LABELV $639
LABELV $636
line 1677
;1676:
;1677:		pm->ps->weaponTime += addTime;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 1678
;1678:}
LABELV $576
endproc PM_Weapon 28 4
proc PM_Animate 0 4
line 1686
;1679:
;1680:/*
;1681:================
;1682:PM_Animate
;1683:================
;1684:*/
;1685:
;1686:static void PM_Animate(void) {
line 1687
;1687:	if (pm->cmd.buttons & BUTTON_GESTURE) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $644
line 1688
;1688:		if (pm->ps->torsoTimer == 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $645
line 1689
;1689:			PM_StartTorsoAnim(TORSO_GESTURE);
CNSTI4 6
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1690
;1690:			pm->ps->torsoTimer = TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 2294
ASGNI4
line 1691
;1691:			PM_AddEvent(EV_TAUNT);
CNSTI4 76
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1692
;1692:		}
line 1693
;1693:	} else if (pm->cmd.buttons & BUTTON_GETFLAG) {
ADDRGP4 $645
JUMPV
LABELV $644
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $648
line 1694
;1694:		if (pm->ps->torsoTimer == 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $649
line 1695
;1695:			PM_StartTorsoAnim(TORSO_GETFLAG);
CNSTI4 25
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1696
;1696:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 600
ASGNI4
line 1697
;1697:		}
line 1698
;1698:	} else if (pm->cmd.buttons & BUTTON_GUARDBASE) {
ADDRGP4 $649
JUMPV
LABELV $648
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $652
line 1699
;1699:		if (pm->ps->torsoTimer == 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $653
line 1700
;1700:			PM_StartTorsoAnim(TORSO_GUARDBASE);
CNSTI4 26
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1701
;1701:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 600
ASGNI4
line 1702
;1702:		}
line 1703
;1703:	} else if (pm->cmd.buttons & BUTTON_PATROL) {
ADDRGP4 $653
JUMPV
LABELV $652
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $656
line 1704
;1704:		if (pm->ps->torsoTimer == 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $657
line 1705
;1705:			PM_StartTorsoAnim(TORSO_PATROL);
CNSTI4 27
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1706
;1706:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 600
ASGNI4
line 1707
;1707:		}
line 1708
;1708:	} else if (pm->cmd.buttons & BUTTON_FOLLOWME) {
ADDRGP4 $657
JUMPV
LABELV $656
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $660
line 1709
;1709:		if (pm->ps->torsoTimer == 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $661
line 1710
;1710:			PM_StartTorsoAnim(TORSO_FOLLOWME);
CNSTI4 28
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1711
;1711:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 600
ASGNI4
line 1712
;1712:		}
line 1713
;1713:	} else if (pm->cmd.buttons & BUTTON_AFFIRMATIVE) {
ADDRGP4 $661
JUMPV
LABELV $660
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $664
line 1714
;1714:		if (pm->ps->torsoTimer == 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $665
line 1715
;1715:			PM_StartTorsoAnim(TORSO_AFFIRMATIVE);
CNSTI4 29
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1716
;1716:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 600
ASGNI4
line 1717
;1717:		}
line 1718
;1718:	} else if (pm->cmd.buttons & BUTTON_NEGATIVE) {
ADDRGP4 $665
JUMPV
LABELV $664
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $668
line 1719
;1719:		if (pm->ps->torsoTimer == 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
NEI4 $670
line 1720
;1720:			PM_StartTorsoAnim(TORSO_NEGATIVE);
CNSTI4 30
ARGI4
ADDRGP4 PM_StartTorsoAnim
CALLV
pop
line 1721
;1721:			pm->ps->torsoTimer = 600;	//TIMER_GESTURE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 600
ASGNI4
line 1722
;1722:		}
LABELV $670
line 1723
;1723:	}
LABELV $668
LABELV $665
LABELV $661
LABELV $657
LABELV $653
LABELV $649
LABELV $645
line 1724
;1724:}
LABELV $643
endproc PM_Animate 0 4
proc PM_DropTimers 4 0
line 1732
;1725:
;1726:
;1727:/*
;1728:================
;1729:PM_DropTimers
;1730:================
;1731:*/
;1732:static void PM_DropTimers(void) {
line 1734
;1733:	// drop misc timing counter
;1734:	if (pm->ps->pm_time) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $673
line 1735
;1735:		if (pml.msec >= pm->ps->pm_time) {
ADDRGP4 pml+40
INDIRI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
LTI4 $675
line 1736
;1736:			pm->ps->pm_flags &= ~PMF_ALL_TIMES;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -353
BANDI4
ASGNI4
line 1737
;1737:			pm->ps->pm_time = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 0
ASGNI4
line 1738
;1738:		} else {
ADDRGP4 $676
JUMPV
LABELV $675
line 1739
;1739:			pm->ps->pm_time -= pml.msec;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1740
;1740:		}
LABELV $676
line 1741
;1741:	}
LABELV $673
line 1744
;1742:
;1743:	// drop animation counter
;1744:	if (pm->ps->legsTimer > 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
LEI4 $679
line 1745
;1745:		pm->ps->legsTimer -= pml.msec;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1746
;1746:		if (pm->ps->legsTimer < 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
CNSTI4 0
GEI4 $682
line 1747
;1747:			pm->ps->legsTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 72
ADDP4
CNSTI4 0
ASGNI4
line 1748
;1748:		}
LABELV $682
line 1749
;1749:	}
LABELV $679
line 1751
;1750:
;1751:	if (pm->ps->torsoTimer > 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
LEI4 $684
line 1752
;1752:		pm->ps->torsoTimer -= pml.msec;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1753
;1753:		if (pm->ps->torsoTimer < 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
CNSTI4 0
GEI4 $687
line 1754
;1754:			pm->ps->torsoTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 80
ADDP4
CNSTI4 0
ASGNI4
line 1755
;1755:		}
LABELV $687
line 1756
;1756:	}
LABELV $684
line 1757
;1757:}
LABELV $672
endproc PM_DropTimers 4 0
export PM_UpdateViewAngles
proc PM_UpdateViewAngles 24 0
line 1767
;1758:
;1759:/*
;1760:================
;1761:PM_UpdateViewAngles
;1762:
;1763:This can be used as another entry point when only the viewangles
;1764:are being updated instead of a full move
;1765:================
;1766:*/
;1767:void PM_UpdateViewAngles(playerState_t *ps, const usercmd_t *cmd) {
line 1771
;1768:	short		temp;
;1769:	int		i;
;1770:
;1771:	if (ps->pm_type == PM_INTERMISSION || ps->pm_type == PM_SPINTERMISSION) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 5
EQI4 $692
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 6
NEI4 $690
LABELV $692
line 1772
;1772:		return;		// no view changes at all
ADDRGP4 $689
JUMPV
LABELV $690
line 1775
;1773:	}
;1774:
;1775:	if (ps->pm_type != PM_SPECTATOR && ps->stats[STAT_HEALTH] <= 0) {
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $693
ADDRLP4 12
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $693
line 1776
;1776:		return;		// no view changes at all
ADDRGP4 $689
JUMPV
LABELV $693
line 1780
;1777:	}
;1778:
;1779:	// circularly clamp the angles with deltas
;1780:	for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $695
line 1781
;1781:		temp = cmd->angles[i] + ps->delta_angles[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDP4
INDIRI4
ADDI4
CVII2 4
ASGNI2
line 1782
;1782:		if (i == PITCH) {
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $699
line 1784
;1783:			// don't let the player look up or down more than 90 degrees
;1784:			if (temp > 16000) {
ADDRLP4 4
INDIRI2
CVII4 2
CNSTI4 16000
LEI4 $701
line 1785
;1785:				ps->delta_angles[i] = (16000 - cmd->angles[i]) & 0xFFFF;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDP4
CNSTI4 16000
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
SUBI4
CNSTI4 65535
BANDI4
ASGNI4
line 1786
;1786:				temp = 16000;
ADDRLP4 4
CNSTI2 16000
ASGNI2
line 1787
;1787:			} else if (temp < -16000) {
ADDRGP4 $702
JUMPV
LABELV $701
ADDRLP4 4
INDIRI2
CVII4 2
CNSTI4 -16000
GEI4 $703
line 1788
;1788:				ps->delta_angles[i] = (-16000 - cmd->angles[i]) & 0xFFFF;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 56
ADDP4
ADDP4
CNSTI4 -16000
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
SUBI4
CNSTI4 65535
BANDI4
ASGNI4
line 1789
;1789:				temp = -16000;
ADDRLP4 4
CNSTI2 -16000
ASGNI2
line 1790
;1790:			}
LABELV $703
LABELV $702
line 1791
;1791:		}
LABELV $699
line 1792
;1792:		ps->viewangles[i] = SHORT2ANGLE(temp);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
ADDP4
ADDRLP4 4
INDIRI2
CVII4 2
CVIF4 4
CNSTF4 1001652224
MULF4
ASGNF4
line 1793
;1793:	}
LABELV $696
line 1780
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $695
line 1795
;1794:
;1795:}
LABELV $689
endproc PM_UpdateViewAngles 24 0
export PmoveSingle
proc PmoveSingle 36 16
line 1806
;1796:
;1797:
;1798:/*
;1799:================
;1800:PmoveSingle
;1801:
;1802:================
;1803:*/
;1804:void trap_SnapVector(float *v);
;1805:
;1806:void PmoveSingle(pmove_t *pmove) {
line 1807
;1807:	pm = pmove;
ADDRGP4 pm
ADDRFP4 0
INDIRP4
ASGNP4
line 1811
;1808:
;1809:	// this counter lets us debug movement problems with a journal
;1810:	// by setting a conditional breakpoint fot the previous frame
;1811:	c_pmove++;
ADDRLP4 0
ADDRGP4 c_pmove
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1814
;1812:
;1813:	// clear results
;1814:	pm->numtouch = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 1815
;1815:	pm->watertype = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 200
ADDP4
CNSTI4 0
ASGNI4
line 1816
;1816:	pm->waterlevel = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
CNSTI4 0
ASGNI4
line 1818
;1817:
;1818:	if (pm->ps->stats[STAT_HEALTH] <= 0) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $706
line 1819
;1819:		pm->tracemask &= ~CONTENTS_BODY;	// corpses can fly through bodies
ADDRLP4 4
ADDRGP4 pm
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 -33554433
BANDI4
ASGNI4
line 1820
;1820:	}
LABELV $706
line 1824
;1821:
;1822:	// make sure walking button is clear if they are running, to avoid
;1823:	// proxy no-footsteps cheats
;1824:	if (abs(pm->cmd.forwardmove) > 64 || abs(pm->cmd.rightmove) > 64) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 4
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 64
GTI4 $710
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 64
LEI4 $708
LABELV $710
line 1825
;1825:		pm->cmd.buttons &= ~BUTTON_WALKING;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 1826
;1826:	}
LABELV $708
line 1829
;1827:
;1828:	// set the talk balloon flag
;1829:	if (pm->cmd.buttons & BUTTON_TALK) {
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $711
line 1830
;1830:		pm->ps->eFlags |= EF_TALK;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 4096
BORI4
ASGNI4
line 1831
;1831:	} else {
ADDRGP4 $712
JUMPV
LABELV $711
line 1832
;1832:		pm->ps->eFlags &= ~EF_TALK;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 -4097
BANDI4
ASGNI4
line 1833
;1833:	}
LABELV $712
line 1836
;1834:
;1835:	// set the firing flag for continuous beam weapons
;1836:	if (!(pm->ps->pm_flags & PMF_RESPAWNED) && pm->ps->pm_type != PM_INTERMISSION && pm->ps->pm_type != PM_NOCLIP
ADDRLP4 12
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
NEI4 $713
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 5
EQI4 $713
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
EQI4 $713
ADDRLP4 12
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $713
ADDRLP4 16
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $713
line 1837
;1837:		&& (pm->cmd.buttons & BUTTON_ATTACK) && pm->ps->ammo[pm->ps->weapon]) {
line 1838
;1838:		pm->ps->eFlags |= EF_FIRING;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 1839
;1839:	} else {
ADDRGP4 $714
JUMPV
LABELV $713
line 1840
;1840:		pm->ps->eFlags &= ~EF_FIRING;
ADDRLP4 20
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 1841
;1841:	}
LABELV $714
line 1844
;1842:
;1843:	// clear the respawned flag if attack and use are cleared
;1844:	if (pm->ps->stats[STAT_HEALTH] > 0 &&
ADDRLP4 20
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
LEI4 $715
ADDRLP4 20
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 5
BANDI4
CNSTI4 0
NEI4 $715
line 1845
;1845:		!(pm->cmd.buttons & (BUTTON_ATTACK | BUTTON_USE_HOLDABLE))) {
line 1846
;1846:		pm->ps->pm_flags &= ~PMF_RESPAWNED;
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 -513
BANDI4
ASGNI4
line 1847
;1847:	}
LABELV $715
line 1852
;1848:
;1849:	// if talk button is down, dissallow all other input
;1850:	// this is to prevent any possible intercept proxy from
;1851:	// adding fake talk balloons
;1852:	if (pmove->cmd.buttons & BUTTON_TALK) {
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $717
line 1855
;1853:		// keep the talk button set tho for when the cmd.serverTime > 66 msec
;1854:		// and the same cmd is used multiple times in Pmove
;1855:		pmove->cmd.buttons = BUTTON_TALK;
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
CNSTI4 2
ASGNI4
line 1856
;1856:		pmove->cmd.forwardmove = 0;
ADDRFP4 0
INDIRP4
CNSTI4 25
ADDP4
CNSTI1 0
ASGNI1
line 1857
;1857:		pmove->cmd.rightmove = 0;
ADDRFP4 0
INDIRP4
CNSTI4 26
ADDP4
CNSTI1 0
ASGNI1
line 1858
;1858:		pmove->cmd.upmove = 0;
ADDRFP4 0
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 1859
;1859:	}
LABELV $717
line 1862
;1860:
;1861:	// clear all pmove local vars
;1862:	memset(&pml, 0, sizeof(pml));
ADDRGP4 pml
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1865
;1863:
;1864:	// determine the time
;1865:	pml.msec = pmove->cmd.serverTime - pm->ps->commandTime;
ADDRGP4 pml+40
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRGP4 pm
INDIRP4
INDIRP4
INDIRI4
SUBI4
ASGNI4
line 1866
;1866:	if (pml.msec < 1) {
ADDRGP4 pml+40
INDIRI4
CNSTI4 1
GEI4 $720
line 1867
;1867:		pml.msec = 1;
ADDRGP4 pml+40
CNSTI4 1
ASGNI4
line 1868
;1868:	} else if (pml.msec > 200) {
ADDRGP4 $721
JUMPV
LABELV $720
ADDRGP4 pml+40
INDIRI4
CNSTI4 200
LEI4 $724
line 1869
;1869:		pml.msec = 200;
ADDRGP4 pml+40
CNSTI4 200
ASGNI4
line 1870
;1870:	}
LABELV $724
LABELV $721
line 1871
;1871:	pm->ps->commandTime = pmove->cmd.serverTime;
ADDRGP4 pm
INDIRP4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1874
;1872:
;1873:	// save old org in case we get stuck
;1874:	VectorCopy(pm->ps->origin, pml.previous_origin);
ADDRGP4 pml+112
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1877
;1875:
;1876:	// save old velocity for crashlanding
;1877:	VectorCopy(pm->ps->velocity, pml.previous_velocity);
ADDRGP4 pml+124
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
INDIRB
ASGNB 12
line 1879
;1878:
;1879:	pml.frametime = pml.msec * 0.001;
ADDRGP4 pml+36
ADDRGP4 pml+40
INDIRI4
CVIF4 4
CNSTF4 981668463
MULF4
ASGNF4
line 1882
;1880:
;1881:	// update the viewangles
;1882:	PM_UpdateViewAngles(pm->ps, &pm->cmd);
ADDRLP4 24
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRGP4 PM_UpdateViewAngles
CALLV
pop
line 1884
;1883:
;1884:	AngleVectors(pm->ps->viewangles, pml.forward, pml.right, pml.up);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 pml
ARGP4
ADDRGP4 pml+12
ARGP4
ADDRGP4 pml+24
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1886
;1885:
;1886:	if (pm->cmd.upmove < 10) {
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
INDIRI1
CVII4 1
CNSTI4 10
GEI4 $734
line 1888
;1887:		// not holding jump
;1888:		pm->ps->pm_flags &= ~PMF_JUMP_HELD;
ADDRLP4 28
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 1889
;1889:	}
LABELV $734
line 1892
;1890:
;1891:	// decide if backpedaling animations should be used
;1892:	if (pm->cmd.forwardmove < 0) {
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $736
line 1893
;1893:		pm->ps->pm_flags |= PMF_BACKWARDS_RUN;
ADDRLP4 28
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 1894
;1894:	} else if (pm->cmd.forwardmove > 0 || (pm->cmd.forwardmove == 0 && pm->cmd.rightmove)) {
ADDRGP4 $737
JUMPV
LABELV $736
ADDRLP4 28
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GTI4 $740
ADDRLP4 28
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $738
ADDRLP4 28
INDIRP4
CNSTI4 26
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $738
LABELV $740
line 1895
;1895:		pm->ps->pm_flags &= ~PMF_BACKWARDS_RUN;
ADDRLP4 32
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 1896
;1896:	}
LABELV $738
LABELV $737
line 1898
;1897:
;1898:	if (pm->ps->pm_type >= PM_DEAD) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
LTI4 $741
line 1899
;1899:		pm->cmd.forwardmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 25
ADDP4
CNSTI1 0
ASGNI1
line 1900
;1900:		pm->cmd.rightmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 26
ADDP4
CNSTI1 0
ASGNI1
line 1901
;1901:		pm->cmd.upmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 0
ASGNI1
line 1902
;1902:	}
LABELV $741
line 1904
;1903:
;1904:	if (pm_respawntimer) {
ADDRGP4 pm_respawntimer
INDIRI4
CNSTI4 0
EQI4 $743
line 1905
;1905:		pm_respawntimer -= pml.msec;
ADDRLP4 32
ADDRGP4 pm_respawntimer
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1906
;1906:		if (pm_respawntimer < 0) {
ADDRGP4 pm_respawntimer
INDIRI4
CNSTI4 0
GEI4 $746
line 1907
;1907:			pm_respawntimer = 0;
ADDRGP4 pm_respawntimer
CNSTI4 0
ASGNI4
line 1908
;1908:		}
LABELV $746
line 1909
;1909:	}
LABELV $743
line 1911
;1910:
;1911:	if (pm->ps->pm_type == PM_SPECTATOR) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $748
line 1912
;1912:		PM_CheckDuck();
ADDRGP4 PM_CheckDuck
CALLV
pop
line 1913
;1913:		PM_FlyMove();
ADDRGP4 PM_FlyMove
CALLV
pop
line 1914
;1914:		PM_DropTimers();
ADDRGP4 PM_DropTimers
CALLV
pop
line 1915
;1915:		return;
ADDRGP4 $705
JUMPV
LABELV $748
line 1918
;1916:	}
;1917:
;1918:	if (pm->ps->pm_type == PM_NOCLIP) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1
NEI4 $750
line 1919
;1919:		PM_NoclipMove();
ADDRGP4 PM_NoclipMove
CALLV
pop
line 1920
;1920:		PM_DropTimers();
ADDRGP4 PM_DropTimers
CALLV
pop
line 1921
;1921:		return;
ADDRGP4 $705
JUMPV
LABELV $750
line 1924
;1922:	}
;1923:
;1924:	if (pm->ps->pm_type == PM_FREEZE) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 4
NEI4 $752
line 1925
;1925:		return;		// no movement at all
ADDRGP4 $705
JUMPV
LABELV $752
line 1928
;1926:	}
;1927:
;1928:	if (pm->ps->pm_type == PM_INTERMISSION || pm->ps->pm_type == PM_SPINTERMISSION) {
ADDRLP4 32
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 5
EQI4 $756
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 6
NEI4 $754
LABELV $756
line 1929
;1929:		return;		// no movement at all
ADDRGP4 $705
JUMPV
LABELV $754
line 1933
;1930:	}
;1931:
;1932:	// set watertype, and waterlevel
;1933:	PM_SetWaterLevel();
ADDRGP4 PM_SetWaterLevel
CALLV
pop
line 1934
;1934:	pml.previous_waterlevel = pmove->waterlevel;
ADDRGP4 pml+136
ADDRFP4 0
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
ASGNI4
line 1937
;1935:
;1936:	// set mins, maxs, and viewheight
;1937:	PM_CheckDuck();
ADDRGP4 PM_CheckDuck
CALLV
pop
line 1940
;1938:
;1939:	// set groundentity
;1940:	PM_GroundTrace();
ADDRGP4 PM_GroundTrace
CALLV
pop
line 1942
;1941:
;1942:	if (pm->ps->pm_type == PM_DEAD) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $758
line 1943
;1943:		PM_DeadMove();
ADDRGP4 PM_DeadMove
CALLV
pop
line 1944
;1944:	}
LABELV $758
line 1946
;1945:
;1946:	PM_DropTimers();
ADDRGP4 PM_DropTimers
CALLV
pop
line 1948
;1947:
;1948:	if (pm->ps->powerups[PW_INVULNERABILITY]) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 368
ADDP4
INDIRI4
CNSTI4 0
EQI4 $760
line 1949
;1949:		PM_InvulnerabilityMove();
ADDRGP4 PM_InvulnerabilityMove
CALLV
pop
line 1950
;1950:	} else if (pm->ps->powerups[PW_FLIGHT]) {
ADDRGP4 $761
JUMPV
LABELV $760
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $762
line 1952
;1951:		// flight powerup doesn't allow jump and has different friction
;1952:		PM_FlyMove();
ADDRGP4 PM_FlyMove
CALLV
pop
line 1953
;1953:	} else if (pm->ps->pm_flags & PMF_GRAPPLE_PULL) {
ADDRGP4 $763
JUMPV
LABELV $762
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $764
line 1954
;1954:		PM_GrappleMove();
ADDRGP4 PM_GrappleMove
CALLV
pop
line 1956
;1955:		// We can wiggle a bit
;1956:		PM_AirMove();
ADDRGP4 PM_AirMove
CALLV
pop
line 1957
;1957:	} else if (pm->ps->pm_flags & PMF_TIME_WATERJUMP) {
ADDRGP4 $765
JUMPV
LABELV $764
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $766
line 1958
;1958:		PM_WaterJumpMove();
ADDRGP4 PM_WaterJumpMove
CALLV
pop
line 1959
;1959:	} else if (pm->waterlevel > 1) {
ADDRGP4 $767
JUMPV
LABELV $766
ADDRGP4 pm
INDIRP4
CNSTI4 204
ADDP4
INDIRI4
CNSTI4 1
LEI4 $768
line 1961
;1960:		// swimming
;1961:		PM_WaterMove();
ADDRGP4 PM_WaterMove
CALLV
pop
line 1962
;1962:	} else if (pml.walking) {
ADDRGP4 $769
JUMPV
LABELV $768
ADDRGP4 pml+44
INDIRI4
CNSTI4 0
EQI4 $770
line 1964
;1963:		// walking on ground
;1964:		PM_WalkMove();
ADDRGP4 PM_WalkMove
CALLV
pop
line 1965
;1965:	} else {
ADDRGP4 $771
JUMPV
LABELV $770
line 1967
;1966:		// airborne
;1967:		PM_AirMove();
ADDRGP4 PM_AirMove
CALLV
pop
line 1968
;1968:	}
LABELV $771
LABELV $769
LABELV $767
LABELV $765
LABELV $763
LABELV $761
line 1970
;1969:
;1970:	PM_Animate();
ADDRGP4 PM_Animate
CALLV
pop
line 1973
;1971:
;1972:	// set groundentity, watertype, and waterlevel
;1973:	PM_GroundTrace();
ADDRGP4 PM_GroundTrace
CALLV
pop
line 1974
;1974:	PM_SetWaterLevel();
ADDRGP4 PM_SetWaterLevel
CALLV
pop
line 1977
;1975:
;1976:	// weapons
;1977:	PM_Weapon();
ADDRGP4 PM_Weapon
CALLV
pop
line 1980
;1978:
;1979:	// torso animation
;1980:	PM_TorsoAnimation();
ADDRGP4 PM_TorsoAnimation
CALLV
pop
line 1983
;1981:
;1982:	// footstep events / legs animations
;1983:	PM_Footsteps();
ADDRGP4 PM_Footsteps
CALLV
pop
line 1986
;1984:
;1985:	// entering / leaving water splashes
;1986:	PM_WaterEvents();
ADDRGP4 PM_WaterEvents
CALLV
pop
line 1988
;1987:
;1988:	if (pm->ps->powerups[PW_FLIGHT] && !pml.groundPlane) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 336
ADDP4
INDIRI4
CNSTI4 0
EQI4 $773
ADDRGP4 pml+48
INDIRI4
CNSTI4 0
NEI4 $773
line 1990
;1989:		// don't snap velocity in free-fly or we will be not able to stop via flight friction
;1990:		return;
ADDRGP4 $705
JUMPV
LABELV $773
line 1994
;1991:	}
;1992:
;1993:	// snap some parts of playerstate to save network bandwidth
;1994:	trap_SnapVector(pm->ps->velocity);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ARGP4
ADDRGP4 trap_SnapVector
CALLV
pop
line 1995
;1995:}
LABELV $705
endproc PmoveSingle 36 16
export Pmove
proc Pmove 16 4
line 2005
;1996:
;1997:
;1998:/*
;1999:================
;2000:Pmove
;2001:
;2002:Can be called by either the server or the client
;2003:================
;2004:*/
;2005:void Pmove(pmove_t *pmove) {
line 2008
;2006:	int			finalTime;
;2007:
;2008:	finalTime = pmove->cmd.serverTime;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 2010
;2009:
;2010:	if (finalTime < pmove->ps->commandTime) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
GEI4 $777
line 2011
;2011:		return;	// should not happen
ADDRGP4 $776
JUMPV
LABELV $777
line 2014
;2012:	}
;2013:
;2014:	if (finalTime > pmove->ps->commandTime + 1000) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
CNSTI4 1000
ADDI4
LEI4 $779
line 2015
;2015:		pmove->ps->commandTime = finalTime - 1000;
ADDRFP4 0
INDIRP4
INDIRP4
ADDRLP4 0
INDIRI4
CNSTI4 1000
SUBI4
ASGNI4
line 2016
;2016:	}
LABELV $779
line 2018
;2017:
;2018:	pmove->ps->pmove_framecount = (pmove->ps->pmove_framecount + 1) & ((1 << PS_PMOVEFRAMECOUNTBITS) - 1);
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 456
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 456
ADDP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 63
BANDI4
ASGNI4
line 2020
;2019:
;2020:	if (pmove->ps->pm_flags & PMF_RESPAWNED && pm_respawntimer == 0) {
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $784
ADDRGP4 pm_respawntimer
INDIRI4
CNSTI4 0
NEI4 $784
line 2021
;2021:		pm_respawntimer = NO_RESPAWN_OVERBOUNCE;
ADDRGP4 pm_respawntimer
CNSTI4 250
ASGNI4
line 2022
;2022:	}
ADDRGP4 $784
JUMPV
LABELV $783
line 2026
;2023:
;2024:	// chop the move up if it is too long, to prevent framerate
;2025:	// dependent behavior
;2026:	while (pmove->ps->commandTime != finalTime) {
line 2029
;2027:		int		msec;
;2028:
;2029:		msec = finalTime - pmove->ps->commandTime;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
SUBI4
ASGNI4
line 2031
;2030:
;2031:		if (pmove->pmove_fixed) {
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
CNSTI4 0
EQI4 $786
line 2032
;2032:			if (msec > pmove->pmove_msec) {
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
LEI4 $787
line 2033
;2033:				msec = pmove->pmove_msec;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
ASGNI4
line 2034
;2034:			}
line 2035
;2035:		} else {
ADDRGP4 $787
JUMPV
LABELV $786
line 2036
;2036:			if (msec > 66) {
ADDRLP4 8
INDIRI4
CNSTI4 66
LEI4 $790
line 2037
;2037:				msec = 66;
ADDRLP4 8
CNSTI4 66
ASGNI4
line 2038
;2038:			}
LABELV $790
line 2039
;2039:		}
LABELV $787
line 2040
;2040:		pmove->cmd.serverTime = pmove->ps->commandTime + msec;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRP4
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 2041
;2041:		PmoveSingle(pmove);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 PmoveSingle
CALLV
pop
line 2043
;2042:
;2043:		if (pmove->ps->pm_flags & PMF_JUMP_HELD) {
ADDRFP4 0
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $792
line 2044
;2044:			pmove->cmd.upmove = 20;
ADDRFP4 0
INDIRP4
CNSTI4 27
ADDP4
CNSTI1 20
ASGNI1
line 2045
;2045:		}
LABELV $792
line 2046
;2046:	}
LABELV $784
line 2026
ADDRFP4 0
INDIRP4
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $783
line 2048
;2047:	//PM_CheckStuck();
;2048:}
LABELV $776
endproc Pmove 16 4
import trap_SnapVector
import PM_StepSlideMove
import PM_SlideMove
bss
export pml
align 4
LABELV pml
skip 140
export pm
align 4
LABELV pm
skip 4
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
LABELV $475
byte 1 37
byte 1 105
byte 1 58
byte 1 76
byte 1 97
byte 1 110
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $464
byte 1 37
byte 1 105
byte 1 58
byte 1 115
byte 1 116
byte 1 101
byte 1 101
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $453
byte 1 37
byte 1 105
byte 1 58
byte 1 107
byte 1 105
byte 1 99
byte 1 107
byte 1 111
byte 1 102
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $422
byte 1 37
byte 1 105
byte 1 58
byte 1 108
byte 1 105
byte 1 102
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $395
byte 1 37
byte 1 105
byte 1 58
byte 1 97
byte 1 108
byte 1 108
byte 1 115
byte 1 111
byte 1 108
byte 1 105
byte 1 100
byte 1 10
byte 1 0

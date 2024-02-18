export CG_BuildSolidList
code
proc CG_BuildSolidList 24 0
file "..\..\..\..\code\cgame\cg_predict.c"
line 26
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_predict.c -- this file generates cg.predictedPlayerState by either
;4:// interpolating between snapshots from the server or locally predicting
;5:// ahead the client's movement.
;6:// It also handles local physics interaction, like fragments bouncing off walls
;7:
;8:#include "cg_local.h"
;9:
;10:static	pmove_t		cg_pmove;
;11:
;12:static	int			cg_numSolidEntities;
;13:static	centity_t *cg_solidEntities[MAX_ENTITIES_IN_SNAPSHOT];
;14:static	int			cg_numTriggerEntities;
;15:static	centity_t *cg_triggerEntities[MAX_ENTITIES_IN_SNAPSHOT];
;16:
;17:/*
;18:====================
;19:CG_BuildSolidList
;20:
;21:When a new cg.snap has been set, this function builds a sublist
;22:of the entities that are actually solid, to make for more
;23:efficient collision detection
;24:====================
;25:*/
;26:void CG_BuildSolidList(void) {
line 32
;27:	int			i;
;28:	centity_t *cent;
;29:	snapshot_t *snap;
;30:	entityState_t *ent;
;31:
;32:	cg_numSolidEntities = 0;
ADDRGP4 cg_numSolidEntities
CNSTI4 0
ASGNI4
line 33
;33:	cg_numTriggerEntities = 0;
ADDRGP4 cg_numTriggerEntities
CNSTI4 0
ASGNI4
line 35
;34:
;35:	if (cg.nextSnap && !cg.nextFrameTeleport && !cg.thisFrameTeleport) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $73
ADDRGP4 cg+107596
INDIRI4
CNSTI4 0
NEI4 $73
ADDRGP4 cg+107592
INDIRI4
CNSTI4 0
NEI4 $73
line 36
;36:		snap = cg.nextSnap;
ADDRLP4 12
ADDRGP4 cg+40
INDIRP4
ASGNP4
line 37
;37:	} else {
ADDRGP4 $74
JUMPV
LABELV $73
line 38
;38:		snap = cg.snap;
ADDRLP4 12
ADDRGP4 cg+36
INDIRP4
ASGNP4
line 39
;39:	}
LABELV $74
line 41
;40:
;41:	for (i = 0; i < snap->numEntities; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $83
JUMPV
LABELV $80
line 42
;42:		cent = &cg_entities[snap->entities[i].number];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 208
MULI4
ADDRLP4 12
INDIRP4
CNSTI4 516
ADDP4
ADDP4
INDIRI4
CNSTI4 740
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 43
;43:		ent = &cent->currentState;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 45
;44:
;45:		if (ent->eType == ET_ITEM || ent->eType == ET_PUSH_TRIGGER || ent->eType == ET_TELEPORT_TRIGGER) {
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $87
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 8
EQI4 $87
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 9
NEI4 $84
LABELV $87
line 46
;46:			cg_triggerEntities[cg_numTriggerEntities] = cent;
ADDRGP4 cg_numTriggerEntities
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_triggerEntities
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 47
;47:			cg_numTriggerEntities++;
ADDRLP4 20
ADDRGP4 cg_numTriggerEntities
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 48
;48:			continue;
ADDRGP4 $81
JUMPV
LABELV $84
line 51
;49:		}
;50:
;51:		if (cent->nextState.solid) {
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 0
EQI4 $88
line 52
;52:			cg_solidEntities[cg_numSolidEntities] = cent;
ADDRGP4 cg_numSolidEntities
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_solidEntities
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 53
;53:			cg_numSolidEntities++;
ADDRLP4 20
ADDRGP4 cg_numSolidEntities
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 54
;54:			continue;
LABELV $88
line 56
;55:		}
;56:	}
LABELV $81
line 41
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $83
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
LTI4 $80
line 57
;57:}
LABELV $72
endproc CG_BuildSolidList 24 0
proc CG_ClipMoveToEntities 144 36
line 67
;58:
;59:
;60:/*
;61:====================
;62:CG_ClipMoveToEntities
;63:
;64:====================
;65:*/
;66:static void CG_ClipMoveToEntities(const vec3_t start, const vec3_t mins, const vec3_t maxs, const vec3_t end,
;67:	int skipNumber, int mask, trace_t *tr) {
line 76
;68:	int			i, x, zd, zu;
;69:	trace_t		trace;
;70:	entityState_t *ent;
;71:	clipHandle_t 	cmodel;
;72:	vec3_t		bmins, bmaxs;
;73:	vec3_t		origin, angles;
;74:	centity_t *cent;
;75:
;76:	for (i = 0; i < cg_numSolidEntities; i++) {
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRGP4 $94
JUMPV
LABELV $91
line 77
;77:		cent = cg_solidEntities[i];
ADDRLP4 60
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_solidEntities
ADDP4
INDIRP4
ASGNP4
line 78
;78:		ent = &cent->currentState;
ADDRLP4 0
ADDRLP4 60
INDIRP4
ASGNP4
line 80
;79:
;80:		if (ent->number == skipNumber) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 16
INDIRI4
NEI4 $95
line 81
;81:			continue;
ADDRGP4 $92
JUMPV
LABELV $95
line 84
;82:		}
;83:
;84:		if (ent->solid == SOLID_BMODEL) {
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
NEI4 $97
line 86
;85:			// special value for bmodel
;86:			cmodel = trap_CM_InlineModel(ent->modelindex);
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRLP4 132
ADDRGP4 trap_CM_InlineModel
CALLI4
ASGNI4
ADDRLP4 68
ADDRLP4 132
INDIRI4
ASGNI4
line 87
;87:			VectorCopy(cent->lerpAngles, angles);
ADDRLP4 108
ADDRLP4 60
INDIRP4
CNSTI4 728
ADDP4
INDIRB
ASGNB 12
line 88
;88:			BG_EvaluateTrajectory(&cent->currentState.pos, cg.physicsTime, origin);
ADDRLP4 60
INDIRP4
CNSTI4 12
ADDP4
ARGP4
ADDRGP4 cg+107612
INDIRI4
ARGI4
ADDRLP4 96
ARGP4
ADDRGP4 BG_EvaluateTrajectory
CALLV
pop
line 89
;89:		} else {
ADDRGP4 $98
JUMPV
LABELV $97
line 91
;90:			// encoded bbox
;91:			x = (ent->solid & 255);
ADDRLP4 120
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 92
;92:			zd = ((ent->solid >> 8) & 255);
ADDRLP4 124
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 255
BANDI4
ASGNI4
line 93
;93:			zu = ((ent->solid >> 16) & 255) - 32;
ADDRLP4 128
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16
RSHI4
CNSTI4 255
BANDI4
CNSTI4 32
SUBI4
ASGNI4
line 95
;94:
;95:			bmins[0] = bmins[1] = -x;
ADDRLP4 132
ADDRLP4 120
INDIRI4
NEGI4
CVIF4 4
ASGNF4
ADDRLP4 72+4
ADDRLP4 132
INDIRF4
ASGNF4
ADDRLP4 72
ADDRLP4 132
INDIRF4
ASGNF4
line 96
;96:			bmaxs[0] = bmaxs[1] = x;
ADDRLP4 136
ADDRLP4 120
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 84+4
ADDRLP4 136
INDIRF4
ASGNF4
ADDRLP4 84
ADDRLP4 136
INDIRF4
ASGNF4
line 97
;97:			bmins[2] = -zd;
ADDRLP4 72+8
ADDRLP4 124
INDIRI4
NEGI4
CVIF4 4
ASGNF4
line 98
;98:			bmaxs[2] = zu;
ADDRLP4 84+8
ADDRLP4 128
INDIRI4
CVIF4 4
ASGNF4
line 100
;99:
;100:			cmodel = trap_CM_TempBoxModel(bmins, bmaxs);
ADDRLP4 72
ARGP4
ADDRLP4 84
ARGP4
ADDRLP4 140
ADDRGP4 trap_CM_TempBoxModel
CALLI4
ASGNI4
ADDRLP4 68
ADDRLP4 140
INDIRI4
ASGNI4
line 101
;101:			VectorCopy(vec3_origin, angles);
ADDRLP4 108
ADDRGP4 vec3_origin
INDIRB
ASGNB 12
line 102
;102:			VectorCopy(cent->lerpOrigin, origin);
ADDRLP4 96
ADDRLP4 60
INDIRP4
CNSTI4 716
ADDP4
INDIRB
ASGNB 12
line 103
;103:		}
LABELV $98
line 106
;104:
;105:
;106:		trap_CM_TransformedBoxTrace(&trace, start, end,
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 68
INDIRI4
ARGI4
ADDRFP4 20
INDIRI4
ARGI4
ADDRLP4 96
ARGP4
ADDRLP4 108
ARGP4
ADDRGP4 trap_CM_TransformedBoxTrace
CALLV
pop
line 109
;107:			mins, maxs, cmodel, mask, origin, angles);
;108:
;109:		if (trace.allsolid || trace.fraction < tr->fraction) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $107
ADDRLP4 4+8
INDIRF4
ADDRFP4 24
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
GEF4 $104
LABELV $107
line 110
;110:			trace.entityNum = ent->number;
ADDRLP4 4+52
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 111
;111:			*tr = trace;
ADDRFP4 24
INDIRP4
ADDRLP4 4
INDIRB
ASGNB 56
line 112
;112:		} else if (trace.startsolid) {
ADDRGP4 $105
JUMPV
LABELV $104
ADDRLP4 4+4
INDIRI4
CNSTI4 0
EQI4 $109
line 113
;113:			tr->startsolid = qtrue;
ADDRFP4 24
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 1
ASGNI4
line 114
;114:		}
LABELV $109
LABELV $105
line 115
;115:		if (tr->allsolid) {
ADDRFP4 24
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $112
line 116
;116:			return;
ADDRGP4 $90
JUMPV
LABELV $112
line 118
;117:		}
;118:	}
LABELV $92
line 76
ADDRLP4 64
ADDRLP4 64
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $94
ADDRLP4 64
INDIRI4
ADDRGP4 cg_numSolidEntities
INDIRI4
LTI4 $91
line 119
;119:}
LABELV $90
endproc CG_ClipMoveToEntities 144 36
export CG_Trace
proc CG_Trace 56 28
line 128
;120:
;121:
;122:/*
;123:================
;124:CG_Trace
;125:================
;126:*/
;127:void	CG_Trace(trace_t *result, const vec3_t start, const vec3_t mins, const vec3_t maxs, const vec3_t end,
;128:	int skipNumber, int mask) {
line 131
;129:	trace_t	t;
;130:
;131:	trap_CM_BoxTrace(&t, start, end, mins, maxs, 0, mask);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 132
;132:	if (t.fraction == 1.0)
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
NEF4 $115
line 133
;133:		t.entityNum = ENTITYNUM_NONE;
ADDRLP4 0+52
CNSTI4 1023
ASGNI4
ADDRGP4 $116
JUMPV
LABELV $115
line 135
;134:	else
;135:		t.entityNum = ENTITYNUM_WORLD;
ADDRLP4 0+52
CNSTI4 1022
ASGNI4
LABELV $116
line 138
;136:
;137:	// check all other solid models
;138:	CG_ClipMoveToEntities(start, mins, maxs, end, skipNumber, mask, &t);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 CG_ClipMoveToEntities
CALLV
pop
line 140
;139:
;140:	*result = t;
ADDRFP4 0
INDIRP4
ADDRLP4 0
INDIRB
ASGNB 56
line 141
;141:}
LABELV $114
endproc CG_Trace 56 28
export CG_PointContents
proc CG_PointContents 36 16
line 149
;142:
;143:
;144:/*
;145:================
;146:CG_PointContents
;147:================
;148:*/
;149:int		CG_PointContents(const vec3_t point, int passEntityNum) {
line 156
;150:	int			i;
;151:	entityState_t *ent;
;152:	centity_t *cent;
;153:	clipHandle_t cmodel;
;154:	int			contents;
;155:
;156:	contents = trap_CM_PointContents(point, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 20
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 20
INDIRI4
ASGNI4
line 158
;157:
;158:	for (i = 0; i < cg_numSolidEntities; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $124
JUMPV
LABELV $121
line 159
;159:		cent = cg_solidEntities[i];
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_solidEntities
ADDP4
INDIRP4
ASGNP4
line 161
;160:
;161:		ent = &cent->currentState;
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 163
;162:
;163:		if (ent->number == passEntityNum) {
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $125
line 164
;164:			continue;
ADDRGP4 $122
JUMPV
LABELV $125
line 167
;165:		}
;166:
;167:		if (ent->solid != SOLID_BMODEL) { // special value for bmodel
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
EQI4 $127
line 168
;168:			continue;
ADDRGP4 $122
JUMPV
LABELV $127
line 171
;169:		}
;170:
;171:		cmodel = trap_CM_InlineModel(ent->modelindex);
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 trap_CM_InlineModel
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 24
INDIRI4
ASGNI4
line 172
;172:		if (!cmodel) {
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $129
line 173
;173:			continue;
ADDRGP4 $122
JUMPV
LABELV $129
line 176
;174:		}
;175:
;176:		contents |= trap_CM_TransformedPointContents(point, cmodel, cent->lerpOrigin, cent->lerpAngles);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 728
ADDP4
ARGP4
ADDRLP4 32
ADDRGP4 trap_CM_TransformedPointContents
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 32
INDIRI4
BORI4
ASGNI4
line 177
;177:	}
LABELV $122
line 158
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $124
ADDRLP4 8
INDIRI4
ADDRGP4 cg_numSolidEntities
INDIRI4
LTI4 $121
line 179
;178:
;179:	return contents;
ADDRLP4 16
INDIRI4
RETI4
LABELV $120
endproc CG_PointContents 36 16
proc CG_InterpolatePlayerState 52 12
line 191
;180:}
;181:
;182:
;183:/*
;184:========================
;185:CG_InterpolatePlayerState
;186:
;187:Generates cg.predictedPlayerState by interpolating between
;188:cg.snap->player_state and cg.nextFrame->player_state
;189:========================
;190:*/
;191:static void CG_InterpolatePlayerState(qboolean grabAngles) {
line 197
;192:	float			f;
;193:	int				i;
;194:	playerState_t *out;
;195:	snapshot_t *prev, *next;
;196:
;197:	out = &cg.predictedPlayerState;
ADDRLP4 12
ADDRGP4 cg+107636
ASGNP4
line 198
;198:	prev = cg.snap;
ADDRLP4 4
ADDRGP4 cg+36
INDIRP4
ASGNP4
line 199
;199:	next = cg.nextSnap;
ADDRLP4 8
ADDRGP4 cg+40
INDIRP4
ASGNP4
line 201
;200:
;201:	*out = cg.snap->ps;
ADDRLP4 12
INDIRP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 468
line 204
;202:
;203:	// if we are still allowing local input, short circuit the view angles
;204:	if (grabAngles) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $136
line 208
;205:		usercmd_t	cmd;
;206:		int			cmdNum;
;207:
;208:		cmdNum = trap_GetCurrentCmdNumber();
ADDRLP4 48
ADDRGP4 trap_GetCurrentCmdNumber
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 48
INDIRI4
ASGNI4
line 209
;209:		trap_GetUserCmd(cmdNum, &cmd);
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 20
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 211
;210:
;211:		PM_UpdateViewAngles(out, &cmd);
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 PM_UpdateViewAngles
CALLV
pop
line 212
;212:	}
LABELV $136
line 215
;213:
;214:	// if the next frame is a teleport, we can't lerp to it
;215:	if (cg.nextFrameTeleport) {
ADDRGP4 cg+107596
INDIRI4
CNSTI4 0
EQI4 $138
line 216
;216:		return;
ADDRGP4 $131
JUMPV
LABELV $138
line 219
;217:	}
;218:
;219:	if (!next || next->serverTime <= prev->serverTime) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $143
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
GTI4 $141
LABELV $143
line 220
;220:		return;
ADDRGP4 $131
JUMPV
LABELV $141
line 223
;221:	}
;222:
;223:	f = (float)(cg.time - prev->serverTime) / (next->serverTime - prev->serverTime);
ADDRLP4 16
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
CVIF4 4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 225
;224:
;225:	i = next->ps.bobCycle;
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ASGNI4
line 226
;226:	if (i < prev->ps.bobCycle) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
GEI4 $145
line 227
;227:		i += 256;		// handle wraparound
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 256
ADDI4
ASGNI4
line 228
;228:	}
LABELV $145
line 229
;229:	out->bobCycle = prev->ps.bobCycle + f * (i - prev->ps.bobCycle);
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
SUBI4
CVIF4 4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 231
;230:
;231:	for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $147
line 232
;232:		out->origin[i] = prev->ps.origin[i] + f * (next->ps.origin[i] - prev->ps.origin[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 20
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 64
ADDP4
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 64
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 64
ADDP4
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 233
;233:		if (!grabAngles) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $151
line 234
;234:			out->viewangles[i] = LerpAngle(
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 196
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 44
ADDRGP4 LerpAngle
CALLF4
ASGNF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 152
ADDP4
ADDP4
ADDRLP4 44
INDIRF4
ASGNF4
line 236
;235:				prev->ps.viewangles[i], next->ps.viewangles[i], f);
;236:		}
LABELV $151
line 237
;237:		out->velocity[i] = prev->ps.velocity[i] +
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 32
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 76
ADDP4
ADDP4
INDIRF4
ADDRLP4 16
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 76
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 76
ADDP4
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 239
;238:			f * (next->ps.velocity[i] - prev->ps.velocity[i]);
;239:	}
LABELV $148
line 231
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $147
line 241
;240:
;241:}
LABELV $131
endproc CG_InterpolatePlayerState 52 12
export CG_StoreEvent
proc CG_StoreEvent 4 4
line 257
;242:
;243:int				eventStack;
;244:entity_event_t	events[MAX_PREDICTED_EVENTS];
;245:int				eventParms[MAX_PREDICTED_EVENTS];
;246:int				eventParm2[MAX_PREDICTED_EVENTS]; // client entity index
;247:
;248:void CG_AddFallDamage(int damage);
;249:
;250:/*
;251:===================
;252:CG_StoreEvents
;253:
;254:Save events that may be dropped during prediction
;255:===================
;256:*/
;257:void CG_StoreEvent(entity_event_t evt, int eventParm, int entityNum) {
line 258
;258:	if (eventStack >= MAX_PREDICTED_EVENTS)
ADDRGP4 eventStack
INDIRI4
CNSTI4 16
LTI4 $154
line 259
;259:		return;
ADDRGP4 $153
JUMPV
LABELV $154
line 261
;260:
;261:	if (evt == EV_FALL_FAR) {
ADDRFP4 0
INDIRI4
CNSTI4 12
NEI4 $156
line 262
;262:		CG_AddFallDamage(10);
CNSTI4 10
ARGI4
ADDRGP4 CG_AddFallDamage
CALLV
pop
line 263
;263:	} else if (evt == EV_FALL_MEDIUM) {
ADDRGP4 $157
JUMPV
LABELV $156
ADDRFP4 0
INDIRI4
CNSTI4 11
NEI4 $158
line 264
;264:		CG_AddFallDamage(5);
CNSTI4 5
ARGI4
ADDRGP4 CG_AddFallDamage
CALLV
pop
line 265
;265:	}
LABELV $158
LABELV $157
line 267
;266:
;267:	events[eventStack] = evt;
ADDRGP4 eventStack
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 events
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 268
;268:	eventParms[eventStack] = eventParm;
ADDRGP4 eventStack
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 eventParms
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 269
;269:	eventParm2[eventStack] = entityNum;
ADDRGP4 eventStack
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 eventParm2
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 270
;270:	eventStack++;
ADDRLP4 0
ADDRGP4 eventStack
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 271
;271:}
LABELV $153
endproc CG_StoreEvent 4 4
export CG_PlayDroppedEvents
proc CG_PlayDroppedEvents 24 12
line 279
;272:
;273:
;274:/*
;275:===================
;276:CG_PlayDroppedEvents
;277:===================
;278:*/
;279:void CG_PlayDroppedEvents(playerState_t *ps, playerState_t *ops) {
line 284
;280:	centity_t *cent;
;281:	entity_event_t oldEvent;
;282:	int i, oldParam;
;283:
;284:	if (ps == ops) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $161
line 285
;285:		return;
ADDRGP4 $160
JUMPV
LABELV $161
line 288
;286:	}
;287:
;288:	if (eventStack <= MAX_PS_EVENTS) {
ADDRGP4 eventStack
INDIRI4
CNSTI4 2
GTI4 $163
line 289
;289:		return;
ADDRGP4 $160
JUMPV
LABELV $163
line 292
;290:	}
;291:
;292:	cent = &cg.predictedPlayerEntity;
ADDRLP4 4
ADDRGP4 cg+108104
ASGNP4
line 294
;293:
;294:	oldEvent = cent->currentState.event;
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ASGNI4
line 295
;295:	oldParam = cent->currentState.eventParm;
ADDRLP4 12
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 297
;296:
;297:	for (i = 0; i < eventStack - MAX_PS_EVENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $169
JUMPV
LABELV $166
line 298
;298:		cent->currentState.event = events[i];
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 events
ADDP4
INDIRI4
ASGNI4
line 299
;299:		cent->currentState.eventParm = eventParms[i];
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 eventParms
ADDP4
INDIRI4
ASGNI4
line 300
;300:		if (cg_showmiss.integer) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $170
line 301
;301:			CG_Printf("Playing dropped event: %s %i", eventnames[events[i]], eventParms[i]);
ADDRGP4 $173
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 events
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 eventnames
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 eventParms
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 302
;302:		}
LABELV $170
line 303
;303:		CG_EntityEvent(cent, cent->lerpOrigin, eventParm2[i]);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 716
ADDP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 eventParm2
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_EntityEvent
CALLV
pop
line 304
;304:		cg.eventSequence++;
ADDRLP4 20
ADDRGP4 cg+108864
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 305
;305:	}
LABELV $167
line 297
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $169
ADDRLP4 0
INDIRI4
ADDRGP4 eventStack
INDIRI4
CNSTI4 2
SUBI4
LTI4 $166
line 307
;306:
;307:	cent->currentState.event = oldEvent;
ADDRLP4 4
INDIRP4
CNSTI4 180
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 308
;308:	cent->currentState.eventParm = oldParam;
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 309
;309:}
LABELV $160
endproc CG_PlayDroppedEvents 24 12
proc CG_AddArmor 4 0
line 312
;310:
;311:
;312:static void CG_AddArmor(const gitem_t *item, int quantity) {
line 314
;313:
;314:	cg.predictedPlayerState.stats[STAT_ARMOR] += quantity;
ADDRLP4 0
ADDRGP4 cg+107636+184+16
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 316
;315:
;316:	if (cg.predictedPlayerState.stats[STAT_ARMOR] > cg.predictedPlayerState.stats[STAT_MAX_HEALTH] * 2)
ADDRGP4 cg+107636+184+16
INDIRI4
ADDRGP4 cg+107636+184+28
INDIRI4
CNSTI4 1
LSHI4
LEI4 $179
line 317
;317:		cg.predictedPlayerState.stats[STAT_ARMOR] = cg.predictedPlayerState.stats[STAT_MAX_HEALTH] * 2;
ADDRGP4 cg+107636+184+16
ADDRGP4 cg+107636+184+28
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
LABELV $179
line 318
;318:}
LABELV $175
endproc CG_AddArmor 4 0
proc CG_AddAmmo 12 0
line 321
;319:
;320:
;321:static void CG_AddAmmo(int weapon, int count) {
line 322
;322:	if (weapon == WP_GAUNTLET || weapon == WP_GRAPPLING_HOOK) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $196
ADDRLP4 0
INDIRI4
CNSTI4 10
NEI4 $194
LABELV $196
line 323
;323:		cg.predictedPlayerState.ammo[weapon] = -1;
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+376
ADDP4
CNSTI4 -1
ASGNI4
line 324
;324:	} else {
ADDRGP4 $195
JUMPV
LABELV $194
line 325
;325:		cg.predictedPlayerState.ammo[weapon] += count;
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+376
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 326
;326:		if (weapon >= WP_MACHINEGUN && weapon <= WP_BFG) {
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 2
LTI4 $201
ADDRLP4 8
INDIRI4
CNSTI4 9
GTI4 $201
line 327
;327:			if (cg.predictedPlayerState.ammo[weapon] > AMMO_HARD_LIMIT) {
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+376
ADDP4
INDIRI4
CNSTI4 200
LEI4 $203
line 328
;328:				cg.predictedPlayerState.ammo[weapon] = AMMO_HARD_LIMIT;
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+376
ADDP4
CNSTI4 200
ASGNI4
line 329
;329:			}
LABELV $203
line 330
;330:		}
LABELV $201
line 331
;331:	}
LABELV $195
line 332
;332:}
LABELV $193
endproc CG_AddAmmo 12 0
proc CG_AddWeapon 4 8
line 335
;333:
;334:
;335:static void CG_AddWeapon(int weapon, int quantity, qboolean dropped) {
line 341
;336:	//int	ammo;
;337:
;338:	//ammo = quantity;
;339:
;340:	// dropped items and teamplay weapons always have full ammo
;341:	if (!dropped && cgs.gametype != GT_TEAM) {
ADDRFP4 8
INDIRI4
CNSTI4 0
NEI4 $210
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 3
EQI4 $210
line 342
;342:		if (cg.predictedPlayerState.ammo[weapon] < quantity) {
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+376
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
GEI4 $213
line 343
;343:			quantity = quantity - cg.predictedPlayerState.ammo[weapon];
ADDRFP4 4
ADDRFP4 4
INDIRI4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+376
ADDP4
INDIRI4
SUBI4
ASGNI4
line 344
;344:		} else {
ADDRGP4 $214
JUMPV
LABELV $213
line 345
;345:			quantity = 1;
ADDRFP4 4
CNSTI4 1
ASGNI4
line 346
;346:		}
LABELV $214
line 347
;347:	}
LABELV $210
line 350
;348:
;349:	// add the weapon
;350:	cg.predictedPlayerState.stats[STAT_WEAPONS] |= (1 << weapon);
ADDRLP4 0
ADDRGP4 cg+107636+184+12
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDRFP4 0
INDIRI4
LSHI4
BORI4
ASGNI4
line 352
;351:
;352:	CG_AddAmmo(weapon, quantity);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 CG_AddAmmo
CALLV
pop
line 353
;353:}
LABELV $209
endproc CG_AddWeapon 4 8
proc CG_CheckArmor 16 4
line 356
;354:
;355:
;356:static int CG_CheckArmor(int damage) {
line 360
;357:	int				save;
;358:	int				count;
;359:
;360:	count = cg.predictedPlayerState.stats[STAT_ARMOR];
ADDRLP4 4
ADDRGP4 cg+107636+184+16
INDIRI4
ASGNI4
line 362
;361:
;362:	save = ceil(damage * ARMOR_PROTECTION);
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 1059648963
MULF4
ARGF4
ADDRLP4 8
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
CVFI4 4
ASGNI4
line 364
;363:
;364:	if (save >= count)
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $226
line 365
;365:		save = count;
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
LABELV $226
line 367
;366:
;367:	if (!save)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $228
line 368
;368:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $222
JUMPV
LABELV $228
line 370
;369:
;370:	cg.predictedPlayerState.stats[STAT_ARMOR] -= save;
ADDRLP4 12
ADDRGP4 cg+107636+184+16
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ASGNI4
line 372
;371:
;372:	return save;
ADDRLP4 0
INDIRI4
RETI4
LABELV $222
endproc CG_CheckArmor 16 4
export CG_AddFallDamage
proc CG_AddFallDamage 16 4
line 376
;373:}
;374:
;375:
;376:void CG_AddFallDamage(int damage) {
line 379
;377:	int take, asave;
;378:
;379:	if (cg.predictedPlayerState.powerups[PW_BATTLESUIT])
ADDRGP4 cg+107636+312+8
INDIRI4
CNSTI4 0
EQI4 $234
line 380
;380:		return;
ADDRGP4 $233
JUMPV
LABELV $234
line 382
;381:
;382:	if (cg.predictedPlayerState.clientNum != cg.snap->ps.clientNum || cg.snap->ps.pm_flags & PMF_FOLLOW) {
ADDRGP4 cg+107636+140
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $245
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $239
LABELV $245
line 383
;383:		return;
ADDRGP4 $233
JUMPV
LABELV $239
line 386
;384:	}
;385:
;386:	take = damage;
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
line 388
;387:
;388:	asave = CG_CheckArmor(take);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_CheckArmor
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 390
;389:
;390:	take -= asave;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 392
;391:
;392:	cg.predictedPlayerState.stats[STAT_HEALTH] -= take;
ADDRLP4 12
ADDRGP4 cg+107636+184
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ASGNI4
line 399
;393:
;394:#if 0
;395:	CG_Printf("take: %i asave:%i health:%i armor:%i\n", take, asave,
;396:		cg.predictedPlayerState.stats[STAT_HEALTH], cg.predictedPlayerState.stats[STAT_ARMOR]);
;397:#endif
;398:
;399:	cg.predictedPlayerState.damagePitch = 255;
ADDRGP4 cg+107636+176
CNSTI4 255
ASGNI4
line 400
;400:	cg.predictedPlayerState.damageYaw = 255;
ADDRGP4 cg+107636+172
CNSTI4 255
ASGNI4
line 402
;401:	//cg.predictedPlayerState.damageEvent++;
;402:	cg.predictedPlayerState.damageCount = take + asave;
ADDRGP4 cg+107636+180
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 403
;403:}
LABELV $233
endproc CG_AddFallDamage 16 4
proc CG_PickupPrediction 16 12
line 406
;404:
;405:
;406:static void CG_PickupPrediction(centity_t *cent, const gitem_t *item) {
line 409
;407:
;408:	// health prediction
;409:	if (item->giType == IT_HEALTH && cent->currentState.time2 > 0) {
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 4
NEI4 $255
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 0
LEI4 $255
line 412
;410:		int limit;
;411:
;412:		limit = cg.predictedPlayerState.stats[STAT_MAX_HEALTH]; // soft limit
ADDRLP4 0
ADDRGP4 cg+107636+184+28
INDIRI4
ASGNI4
line 413
;413:		if (!Q_stricmp(item->classname, "item_health_small") || !Q_stricmp(item->classname, "item_health_mega")) {
ADDRFP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 $262
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $264
ADDRFP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 $263
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $260
LABELV $264
line 414
;414:			limit *= 2; // hard limit
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 415
;415:		}
LABELV $260
line 417
;416:
;417:		cg.predictedPlayerState.stats[STAT_HEALTH] += cent->currentState.time2;
ADDRLP4 12
ADDRGP4 cg+107636+184
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ADDI4
ASGNI4
line 418
;418:		if (cg.predictedPlayerState.stats[STAT_HEALTH] > limit) {
ADDRGP4 cg+107636+184
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $267
line 419
;419:			cg.predictedPlayerState.stats[STAT_HEALTH] = limit;
ADDRGP4 cg+107636+184
ADDRLP4 0
INDIRI4
ASGNI4
line 420
;420:		}
LABELV $267
line 421
;421:	}
LABELV $255
line 424
;422:
;423:	// armor prediction
;424:	if (item->giType == IT_ARMOR && cent->currentState.time2 > 0) {
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 3
NEI4 $273
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 0
LEI4 $273
line 425
;425:		CG_AddArmor(item, cent->currentState.time2);
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddArmor
CALLV
pop
line 426
;426:		return;
ADDRGP4 $254
JUMPV
LABELV $273
line 430
;427:	}
;428:
;429:	// ammo prediction
;430:	if (item->giType == IT_AMMO && cent->currentState.time2 > 0) {
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 2
NEI4 $275
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 0
LEI4 $275
line 431
;431:		CG_AddAmmo(item->giTag, cent->currentState.time2);
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_AddAmmo
CALLV
pop
line 432
;432:		return;
ADDRGP4 $254
JUMPV
LABELV $275
line 436
;433:	}
;434:
;435:	// weapon prediction
;436:	if (item->giType == IT_WEAPON && cent->currentState.time2 > 0) {
ADDRFP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $277
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 0
LEI4 $277
line 437
;437:		CG_AddWeapon(item->giTag, cent->currentState.time2, (cent->currentState.modelindex2 == 1));
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 1
NEI4 $280
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $281
JUMPV
LABELV $280
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $281
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_AddWeapon
CALLV
pop
line 438
;438:		return;
ADDRGP4 $254
JUMPV
LABELV $277
line 442
;439:	}
;440:
;441:	// powerups prediction
;442:	if (item->giType == IT_POWERUP && item->giTag >= PW_QUAD && item->giTag <= PW_FLIGHT) {
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $282
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 1
LTI4 $282
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 6
GTI4 $282
line 444
;443:		// round timing to seconds to make multiple powerup timers count in sync
;444:		if (!cg.predictedPlayerState.powerups[item->giTag]) {
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+312
ADDP4
INDIRI4
CNSTI4 0
NEI4 $284
line 445
;445:			cg.predictedPlayerState.powerups[item->giTag] = cg.predictedPlayerState.commandTime - (cg.predictedPlayerState.commandTime % 1000);
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+312
ADDP4
ADDRGP4 cg+107636
INDIRI4
ADDRGP4 cg+107636
INDIRI4
CNSTI4 1000
MODI4
SUBI4
ASGNI4
line 447
;446:			// this assumption is correct only on transition and implies hardcoded 1.3 coefficient:
;447:			if (item->giTag == PW_HASTE) {
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 3
NEI4 $292
line 448
;448:				cg.predictedPlayerState.speed *= 1.3f;
ADDRLP4 4
ADDRGP4 cg+107636+52
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CVIF4 4
CNSTF4 1067869798
MULF4
CVFI4 4
ASGNI4
line 449
;449:			}
LABELV $292
line 450
;450:		}
LABELV $284
line 451
;451:		cg.predictedPlayerState.powerups[item->giTag] += cent->currentState.time2 * 1000;
ADDRLP4 4
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+312
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
CNSTI4 1000
MULI4
ADDI4
ASGNI4
line 452
;452:	}
LABELV $282
line 455
;453:
;454:	// holdable prediction
;455:	if (item->giType == IT_HOLDABLE && (item->giTag == HI_TELEPORTER || item->giTag == HI_MEDKIT)) {
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 6
NEI4 $298
ADDRLP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 1
EQI4 $300
ADDRLP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
NEI4 $298
LABELV $300
line 456
;456:		cg.predictedPlayerState.stats[STAT_HOLDABLE_ITEM] = item - bg_itemlist;
ADDRGP4 cg+107636+184+4
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
ASGNI4
line 457
;457:	}
LABELV $298
line 458
;458:}
LABELV $254
endproc CG_PickupPrediction 16 12
proc CG_TouchItem 28 16
line 466
;459:
;460:
;461:/*
;462:===================
;463:CG_TouchItem
;464:===================
;465:*/
;466:static void CG_TouchItem(centity_t *cent) {
line 469
;467:	const gitem_t *item;
;468:
;469:	if (cg.allowPickupPrediction && cg.allowPickupPrediction > cg.time) {
ADDRGP4 cg+157004
INDIRI4
CNSTI4 0
EQI4 $305
ADDRGP4 cg+157004
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $305
line 470
;470:		return;
ADDRGP4 $304
JUMPV
LABELV $305
line 473
;471:	}
;472:
;473:	if (!cg_predictItems.integer) {
ADDRGP4 cg_predictItems+12
INDIRI4
CNSTI4 0
NEI4 $310
line 474
;474:		return;
ADDRGP4 $304
JUMPV
LABELV $310
line 477
;475:	}
;476:
;477:	if (!BG_PlayerTouchesItem(&cg.predictedPlayerState, &cent->currentState, cg.time)) {
ADDRGP4 cg+107636
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 BG_PlayerTouchesItem
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $313
line 478
;478:		return;
ADDRGP4 $304
JUMPV
LABELV $313
line 482
;479:	}
;480:
;481:	// never pick an item up twice in a prediction
;482:	if (cent->delaySpawn > cg.time) {
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $317
line 483
;483:		return;
ADDRGP4 $304
JUMPV
LABELV $317
line 486
;484:	}
;485:
;486:	if (!BG_CanItemBeGrabbed(cgs.gametype, &cent->currentState, &cg.predictedPlayerState)) {
ADDRGP4 cgs+31480
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 cg+107636
ARGP4
ADDRLP4 8
ADDRGP4 BG_CanItemBeGrabbed
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $320
line 487
;487:		return;	// can't hold it
ADDRGP4 $304
JUMPV
LABELV $320
line 490
;488:	}
;489:
;490:	item = &bg_itemlist[cent->currentState.modelindex];
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
CNSTI4 52
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 494
;491:
;492:	// Special case for flags.  
;493:	// We don't predict touching our own flag
;494:	if (cgs.gametype == GT_1FCTF) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 6
NEI4 $324
line 495
;495:		if (item->giTag != PW_NEUTRALFLAG) {
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 9
EQI4 $327
line 496
;496:			return;
ADDRGP4 $304
JUMPV
LABELV $327
line 498
;497:		}
;498:	}
LABELV $324
line 499
;499:	if (cgs.gametype == GT_CTF || cgs.gametype == GT_HARVESTER) {
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 5
EQI4 $333
ADDRGP4 cgs+31480
INDIRI4
CNSTI4 8
NEI4 $329
LABELV $333
line 500
;500:		if (cg.predictedPlayerState.persistant[PERS_TEAM] == TEAM_RED &&
ADDRGP4 cg+107636+248+12
INDIRI4
CNSTI4 1
NEI4 $334
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $334
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 7
NEI4 $334
line 502
;501:			item->giType == IT_TEAM && item->giTag == PW_REDFLAG)
;502:			return;
ADDRGP4 $304
JUMPV
LABELV $334
line 503
;503:		if (cg.predictedPlayerState.persistant[PERS_TEAM] == TEAM_BLUE &&
ADDRGP4 cg+107636+248+12
INDIRI4
CNSTI4 2
NEI4 $339
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 8
NEI4 $339
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 8
NEI4 $339
line 505
;504:			item->giType == IT_TEAM && item->giTag == PW_BLUEFLAG)
;505:			return;
ADDRGP4 $304
JUMPV
LABELV $339
line 506
;506:	}
LABELV $329
line 509
;507:
;508:	// grab it
;509:	BG_AddPredictableEventToPlayerstate(EV_ITEM_PICKUP, cent->currentState.modelindex, &cg.predictedPlayerState, cent - cg_entities);
CNSTI4 19
ARGI4
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+107636
ARGP4
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRGP4 cg_entities
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 740
DIVI4
ARGI4
ADDRGP4 BG_AddPredictableEventToPlayerstate
CALLV
pop
line 512
;510:
;511:	// perform prediction
;512:	CG_PickupPrediction(cent, item);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_PickupPrediction
CALLV
pop
line 515
;513:
;514:	// remove it from the frame so it won't be drawn
;515:	cent->currentState.eFlags |= EF_NODRAW;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
line 518
;516:
;517:	// don't touch it again this prediction
;518:	cent->miscTime = cg.time;
ADDRFP4 0
INDIRP4
CNSTI4 444
ADDP4
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 521
;519:
;520:	// delay next potential pickup for some time
;521:	cent->delaySpawn = cg.time + (cg.meanPing > 0 ? cg.meanPing * 2 + 100 : 333);
ADDRGP4 cg+156996
INDIRI4
CNSTI4 0
LEI4 $350
ADDRLP4 20
ADDRGP4 cg+156996
INDIRI4
CNSTI4 1
LSHI4
CNSTI4 100
ADDI4
ASGNI4
ADDRGP4 $351
JUMPV
LABELV $350
ADDRLP4 20
CNSTI4 333
ASGNI4
LABELV $351
ADDRFP4 0
INDIRP4
CNSTI4 448
ADDP4
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 20
INDIRI4
ADDI4
ASGNI4
line 522
;522:	cent->delaySpawnPlayed = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
CNSTI4 0
ASGNI4
line 525
;523:
;524:	// if it's a weapon, give them some predicted ammo so the autoswitch will work
;525:	if (item->giType == IT_WEAPON) {
ADDRLP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $352
line 526
;526:		cg.predictedPlayerState.stats[STAT_WEAPONS] |= 1 << item->giTag;
ADDRLP4 24
ADDRGP4 cg+107636+184+12
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
LSHI4
BORI4
ASGNI4
line 527
;527:		if (!cg.predictedPlayerState.ammo[item->giTag]) {
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+376
ADDP4
INDIRI4
CNSTI4 0
NEI4 $357
line 528
;528:			cg.predictedPlayerState.ammo[item->giTag] = 1;
ADDRLP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+376
ADDP4
CNSTI4 1
ASGNI4
line 529
;529:		}
LABELV $357
line 530
;530:	}
LABELV $352
line 531
;531:}
LABELV $304
endproc CG_TouchItem 28 16
proc CG_TouchTriggerPrediction 84 28
line 541
;532:
;533:
;534:/*
;535:=========================
;536:CG_TouchTriggerPrediction
;537:
;538:Predict push triggers and items
;539:=========================
;540:*/
;541:static void CG_TouchTriggerPrediction(void) {
line 550
;542:	int			i;
;543:	trace_t		trace;
;544:	entityState_t *ent;
;545:	clipHandle_t cmodel;
;546:	centity_t *cent;
;547:	qboolean	spectator;
;548:
;549:	// dead clients don't activate triggers
;550:	if (cg.predictedPlayerState.stats[STAT_HEALTH] <= 0) {
ADDRGP4 cg+107636+184
INDIRI4
CNSTI4 0
GTI4 $364
line 551
;551:		return;
ADDRGP4 $363
JUMPV
LABELV $364
line 554
;552:	}
;553:
;554:	spectator = (cg.predictedPlayerState.pm_type == PM_SPECTATOR);
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 2
NEI4 $371
ADDRLP4 76
CNSTI4 1
ASGNI4
ADDRGP4 $372
JUMPV
LABELV $371
ADDRLP4 76
CNSTI4 0
ASGNI4
LABELV $372
ADDRLP4 72
ADDRLP4 76
INDIRI4
ASGNI4
line 556
;555:
;556:	if (cg.predictedPlayerState.pm_type != PM_NORMAL && !spectator) {
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 0
EQI4 $373
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $373
line 557
;557:		return;
ADDRGP4 $363
JUMPV
LABELV $373
line 560
;558:	}
;559:
;560:	for (i = 0; i < cg_numTriggerEntities; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $380
JUMPV
LABELV $377
line 561
;561:		cent = cg_triggerEntities[i];
ADDRLP4 12
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg_triggerEntities
ADDP4
INDIRP4
ASGNP4
line 562
;562:		ent = &cent->currentState;
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 564
;563:
;564:		if (ent->eType == ET_ITEM && !spectator) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
NEI4 $381
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $381
line 565
;565:			CG_TouchItem(cent);
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 CG_TouchItem
CALLV
pop
line 566
;566:			continue;
ADDRGP4 $378
JUMPV
LABELV $381
line 569
;567:		}
;568:
;569:		if (ent->solid != SOLID_BMODEL) {
ADDRLP4 0
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
CNSTI4 16777215
EQI4 $383
line 570
;570:			continue;
ADDRGP4 $378
JUMPV
LABELV $383
line 573
;571:		}
;572:
;573:		cmodel = trap_CM_InlineModel(ent->modelindex);
ADDRLP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRI4
ARGI4
ADDRLP4 80
ADDRGP4 trap_CM_InlineModel
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 80
INDIRI4
ASGNI4
line 574
;574:		if (!cmodel) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $385
line 575
;575:			continue;
ADDRGP4 $378
JUMPV
LABELV $385
line 578
;576:		}
;577:
;578:		trap_CM_BoxTrace(&trace, cg.predictedPlayerState.origin, cg.predictedPlayerState.origin,
ADDRLP4 16
ARGP4
ADDRGP4 cg+107636+20
ARGP4
ADDRGP4 cg+107636+20
ARGP4
ADDRGP4 cg_pmove+176
ARGP4
ADDRGP4 cg_pmove+188
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
ADDRGP4 trap_CM_BoxTrace
CALLV
pop
line 581
;579:			cg_pmove.mins, cg_pmove.maxs, cmodel, -1);
;580:
;581:		if (!trace.startsolid) {
ADDRLP4 16+4
INDIRI4
CNSTI4 0
NEI4 $393
line 582
;582:			continue;
ADDRGP4 $378
JUMPV
LABELV $393
line 585
;583:		}
;584:
;585:		if (ent->eType == ET_TELEPORT_TRIGGER) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 9
NEI4 $396
line 586
;586:			cg.hyperspace = qtrue;
ADDRGP4 cg+107632
CNSTI4 1
ASGNI4
line 587
;587:		} else if (ent->eType == ET_PUSH_TRIGGER) {
ADDRGP4 $397
JUMPV
LABELV $396
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 8
NEI4 $399
line 588
;588:			BG_TouchJumpPad(&cg.predictedPlayerState, ent);
ADDRGP4 cg+107636
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BG_TouchJumpPad
CALLV
pop
line 589
;589:		}
LABELV $399
LABELV $397
line 590
;590:	}
LABELV $378
line 560
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $380
ADDRLP4 4
INDIRI4
ADDRGP4 cg_numTriggerEntities
INDIRI4
LTI4 $377
line 593
;591:
;592:	// if we didn't touch a jump pad this pmove frame
;593:	if (cg.predictedPlayerState.jumppad_frame != cg.predictedPlayerState.pmove_framecount) {
ADDRGP4 cg+107636+460
INDIRI4
ADDRGP4 cg+107636+456
INDIRI4
EQI4 $402
line 594
;594:		cg.predictedPlayerState.jumppad_frame = 0;
ADDRGP4 cg+107636+460
CNSTI4 0
ASGNI4
line 595
;595:		cg.predictedPlayerState.jumppad_ent = 0;
ADDRGP4 cg+107636+448
CNSTI4 0
ASGNI4
line 596
;596:	}
LABELV $402
line 597
;597:}
LABELV $363
endproc CG_TouchTriggerPrediction 84 28
proc CG_CheckTimers 16 0
line 600
;598:
;599:
;600:static void CG_CheckTimers(void) {
line 604
;601:	int i;
;602:
;603:	// no prediction for spectators
;604:	if (cg.predictedPlayerState.pm_type == PM_SPECTATOR) {
ADDRGP4 cg+107636+4
INDIRI4
CNSTI4 2
NEI4 $413
line 605
;605:		return;
ADDRGP4 $412
JUMPV
LABELV $413
line 609
;606:	}
;607:
;608:	// no armor/health/powerups prediction for dead bodies
;609:	if (cg.predictedPlayerState.stats[STAT_HEALTH] <= 0)
ADDRGP4 cg+107636+184
INDIRI4
CNSTI4 0
GTI4 $417
line 610
;610:		return;
ADDRGP4 $412
JUMPV
LABELV $417
line 613
;611:
;612:	// periodic tasks
;613:	if (cg.timeResidual && cg.predictedPlayerState.commandTime >= cg.timeResidual && !cg.thisFrameTeleport) {
ADDRGP4 cg+157000
INDIRI4
CNSTI4 0
EQI4 $421
ADDRGP4 cg+107636
INDIRI4
ADDRGP4 cg+157000
INDIRI4
LTI4 $421
ADDRGP4 cg+107592
INDIRI4
CNSTI4 0
NEI4 $421
line 614
;614:		cg.timeResidual += 1000;
ADDRLP4 4
ADDRGP4 cg+157000
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 615
;615:		if (cg.predictedPlayerState.powerups[PW_REGEN]) {
ADDRGP4 cg+107636+312+20
INDIRI4
CNSTI4 0
EQI4 $428
line 616
;616:			int maxhealth = cg.predictedPlayerState.stats[STAT_MAX_HEALTH];
ADDRLP4 8
ADDRGP4 cg+107636+184+28
INDIRI4
ASGNI4
line 617
;617:			if (cg.predictedPlayerState.stats[STAT_HEALTH] < maxhealth) {
ADDRGP4 cg+107636+184
INDIRI4
ADDRLP4 8
INDIRI4
GEI4 $436
line 618
;618:				cg.predictedPlayerState.stats[STAT_HEALTH] += 15;
ADDRLP4 12
ADDRGP4 cg+107636+184
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 15
ADDI4
ASGNI4
line 619
;619:				if (cg.predictedPlayerState.stats[STAT_HEALTH] > maxhealth * 1.1) {
ADDRGP4 cg+107636+184
INDIRI4
CVIF4 4
ADDRLP4 8
INDIRI4
CVIF4 4
CNSTF4 1066192077
MULF4
LEF4 $429
line 620
;620:					cg.predictedPlayerState.stats[STAT_HEALTH] = maxhealth * 1.1;
ADDRGP4 cg+107636+184
ADDRLP4 8
INDIRI4
CVIF4 4
CNSTF4 1066192077
MULF4
CVFI4 4
ASGNI4
line 621
;621:				}
line 623
;622:				// TODO: add external EV_POWERUP_REGEN
;623:			} else if (cg.predictedPlayerState.stats[STAT_HEALTH] < maxhealth * 2) {
ADDRGP4 $429
JUMPV
LABELV $436
ADDRGP4 cg+107636+184
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 1
LSHI4
GEI4 $429
line 624
;624:				cg.predictedPlayerState.stats[STAT_HEALTH] += 5;
ADDRLP4 12
ADDRGP4 cg+107636+184
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 5
ADDI4
ASGNI4
line 625
;625:				if (cg.predictedPlayerState.stats[STAT_HEALTH] > maxhealth * 2) {
ADDRGP4 cg+107636+184
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 1
LSHI4
LEI4 $429
line 626
;626:					cg.predictedPlayerState.stats[STAT_HEALTH] = maxhealth * 2;
ADDRGP4 cg+107636+184
ADDRLP4 8
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 627
;627:				}
line 629
;628:				// TODO: add external EV_POWERUP_REGEN
;629:			}
line 630
;630:		} else {
ADDRGP4 $429
JUMPV
LABELV $428
line 631
;631:			if (cg.predictedPlayerState.stats[STAT_HEALTH] > cg.predictedPlayerState.stats[STAT_MAX_HEALTH]) {
ADDRGP4 cg+107636+184
INDIRI4
ADDRGP4 cg+107636+184+28
INDIRI4
LEI4 $460
line 632
;632:				cg.predictedPlayerState.stats[STAT_HEALTH]--;
ADDRLP4 8
ADDRGP4 cg+107636+184
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 633
;633:			}
LABELV $460
line 634
;634:		}
LABELV $429
line 635
;635:		if (cg.predictedPlayerState.stats[STAT_ARMOR] > cg.predictedPlayerState.stats[STAT_MAX_HEALTH]) {
ADDRGP4 cg+107636+184+16
INDIRI4
ADDRGP4 cg+107636+184+28
INDIRI4
LEI4 $469
line 636
;636:			cg.predictedPlayerState.stats[STAT_ARMOR]--;
ADDRLP4 8
ADDRGP4 cg+107636+184+16
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 637
;637:		}
LABELV $469
line 638
;638:	}
LABELV $421
line 641
;639:
;640:	// turn off any expired powerups
;641:	for (i = 0; i < MAX_POWERUPS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $480
line 642
;642:		if (!cg.predictedPlayerState.powerups[i])
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+312
ADDP4
INDIRI4
CNSTI4 0
NEI4 $484
line 643
;643:			continue;
ADDRGP4 $481
JUMPV
LABELV $484
line 644
;644:		if (cg.predictedPlayerState.powerups[i] < cg.predictedPlayerState.commandTime) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+312
ADDP4
INDIRI4
ADDRGP4 cg+107636
INDIRI4
GEI4 $488
line 645
;645:			cg.predictedPlayerState.powerups[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cg+107636+312
ADDP4
CNSTI4 0
ASGNI4
line 646
;646:		}
LABELV $488
line 647
;647:	}
LABELV $481
line 641
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $480
line 648
;648:}
LABELV $412
endproc CG_CheckTimers 16 0
proc CG_IsUnacceptableError 164 36
line 651
;649:
;650:
;651:static int CG_IsUnacceptableError(playerState_t *ps, playerState_t *pps, qboolean *forceMove) {
line 655
;652:	vec3_t delta;
;653:	int i, n, v0, v1;
;654:
;655:	if (pps->pm_time != ps->pm_time ||
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
NEI4 $499
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
NEI4 $499
ADDRLP4 28
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
EQI4 $496
LABELV $499
line 657
;656:		pps->pm_type != ps->pm_type ||
;657:		pps->pm_flags != ps->pm_flags) {
line 658
;658:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $495
JUMPV
LABELV $496
line 661
;659:	}
;660:
;661:	VectorSubtract(pps->origin, ps->origin, delta);
ADDRLP4 36
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 36
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 36
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
line 662
;662:	if (VectorLengthSquared(delta) > 0.01f * 0.01f) {
ADDRLP4 12
ARGP4
ADDRLP4 44
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 44
INDIRF4
CNSTF4 953267991
LEF4 $502
line 663
;663:		if (cg_showmiss.integer > 2) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 2
LEI4 $504
line 664
;664:			CG_Printf("origin delta: %.2f  ", VectorLength(delta));
ADDRLP4 12
ARGP4
ADDRLP4 48
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRGP4 $507
ARGP4
ADDRLP4 48
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 665
;665:		}
LABELV $504
line 666
;666:		return 2;
CNSTI4 2
RETI4
ADDRGP4 $495
JUMPV
LABELV $502
line 669
;667:	}
;668:
;669:	VectorSubtract(pps->velocity, ps->velocity, delta);
ADDRLP4 48
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 48
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 48
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 52
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
SUBF4
ASGNF4
line 670
;670:	if (VectorLengthSquared(delta) > 0.01f * 0.01f) {
ADDRLP4 12
ARGP4
ADDRLP4 56
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 56
INDIRF4
CNSTF4 953267991
LEF4 $510
line 671
;671:		if (cg_showmiss.integer > 2) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 2
LEI4 $512
line 672
;672:			CG_Printf("velocity delta: %.2f  ", VectorLength(delta));
ADDRLP4 12
ARGP4
ADDRLP4 60
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRGP4 $515
ARGP4
ADDRLP4 60
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 673
;673:		}
LABELV $512
line 674
;674:		return 3;
CNSTI4 3
RETI4
ADDRGP4 $495
JUMPV
LABELV $510
line 677
;675:	}
;676:
;677:	if (pps->weaponTime != ps->weaponTime ||
ADDRLP4 60
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
NEI4 $523
ADDRLP4 60
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
NEI4 $523
ADDRLP4 60
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
NEI4 $523
ADDRLP4 60
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
NEI4 $523
ADDRLP4 60
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 60
ADDP4
INDIRI4
NEI4 $523
ADDRLP4 60
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
NEI4 $523
ADDRLP4 60
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
EQI4 $516
LABELV $523
line 683
;678:		pps->gravity != ps->gravity ||
;679:		pps->speed != ps->speed ||
;680:		pps->delta_angles[0] != ps->delta_angles[0] ||
;681:		pps->delta_angles[1] != ps->delta_angles[1] ||
;682:		pps->delta_angles[2] != ps->delta_angles[2] ||
;683:		pps->groundEntityNum != ps->groundEntityNum) {
line 684
;684:		if (cg_showmiss.integer > 1)
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $524
line 685
;685:			CG_Printf("%i %i %i %i => %i %i %i %i",
ADDRGP4 $527
ARGP4
ADDRLP4 68
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $524
line 689
;686:				pps->weaponTime, pps->gravity, pps->speed, pps->groundEntityNum,
;687:				ps->weaponTime, ps->gravity, ps->speed, ps->groundEntityNum);
;688:
;689:		return 4;
CNSTI4 4
RETI4
ADDRGP4 $495
JUMPV
LABELV $516
line 693
;690:	}
;691:
;692:	// forward gesture animation
;693:	if (pps->torsoAnim != ps->torsoAnim && (ps->torsoAnim & ~ANIM_TOGGLEBIT) == TORSO_GESTURE) {
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDRLP4 68
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
EQI4 $528
ADDRLP4 68
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 -129
BANDI4
CNSTI4 6
NEI4 $528
line 694
;694:		for (n = 0; n < NUM_SAVED_STATES; n++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $530
line 695
;695:			cg.savedPmoveStates[n].torsoAnim = ps->torsoAnim;
ADDRLP4 4
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126100+84
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ASGNI4
line 696
;696:			cg.savedPmoveStates[n].torsoTimer = ps->torsoTimer;
ADDRLP4 4
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126100+80
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ASGNI4
line 697
;697:		}
LABELV $531
line 694
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 66
LTI4 $530
line 698
;698:	}
LABELV $528
line 700
;699:
;700:	if (pps->legsTimer != ps->legsTimer || pps->legsAnim != ps->legsAnim ||
ADDRLP4 72
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
ADDRLP4 76
INDIRP4
CNSTI4 72
ADDP4
INDIRI4
NEI4 $543
ADDRLP4 72
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
ADDRLP4 76
INDIRP4
CNSTI4 76
ADDP4
INDIRI4
NEI4 $543
ADDRLP4 72
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
ADDRLP4 76
INDIRP4
CNSTI4 80
ADDP4
INDIRI4
NEI4 $543
ADDRLP4 72
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
ADDRLP4 76
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
NEI4 $543
ADDRLP4 72
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
ADDRLP4 76
INDIRP4
CNSTI4 88
ADDP4
INDIRI4
EQI4 $538
LABELV $543
line 702
;701:		pps->torsoTimer != ps->torsoTimer || pps->torsoAnim != ps->torsoAnim ||
;702:		pps->movementDir != ps->movementDir) {
line 703
;703:		return 5;
CNSTI4 5
RETI4
ADDRGP4 $495
JUMPV
LABELV $538
line 706
;704:	}
;705:
;706:	VectorSubtract(pps->grapplePoint, ps->grapplePoint, delta);
ADDRLP4 80
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 80
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 80
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRFP4 4
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 707
;707:	if (VectorLengthSquared(delta) > 0.01f * 0.01f)
ADDRLP4 12
ARGP4
ADDRLP4 88
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 88
INDIRF4
CNSTF4 953267991
LEF4 $546
line 708
;708:		return 6;
CNSTI4 6
RETI4
ADDRGP4 $495
JUMPV
LABELV $546
line 711
;709:
;710:	// check/update eFlags if needed
;711:	v0 = pps->eFlags & EF_NOPREDICT;
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 784456
BANDI4
ASGNI4
line 712
;712:	v1 = ps->eFlags & EF_NOPREDICT;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 784456
BANDI4
ASGNI4
line 713
;713:	if (v0 != v1) {
ADDRLP4 8
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $548
line 714
;714:		for (i = 0; i < NUM_SAVED_STATES; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $550
line 715
;715:			cg.savedPmoveStates[i].eFlags = (cg.savedPmoveStates[i].eFlags & ~EF_NOPREDICT) | v1;
ADDRLP4 0
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126100+104
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126100+104
ADDP4
INDIRI4
CNSTI4 -784457
BANDI4
ADDRLP4 24
INDIRI4
BORI4
ASGNI4
line 716
;716:		}
LABELV $551
line 714
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 66
LTI4 $550
line 717
;717:		pps->eFlags = (pps->eFlags & ~EF_NOPREDICT) | v1;
ADDRLP4 92
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 -784457
BANDI4
ADDRLP4 24
INDIRI4
BORI4
ASGNI4
line 718
;718:	}
LABELV $548
line 720
;719:
;720:	if (pps->eFlags != ps->eFlags) {
ADDRFP4 4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
EQI4 $558
line 721
;721:		if (cg_showmiss.integer > 1)
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $560
line 722
;722:			CG_Printf("eFlags %i => %i", pps->eFlags, ps->eFlags);
ADDRGP4 $563
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $560
line 723
;723:		return 7;
CNSTI4 7
RETI4
ADDRGP4 $495
JUMPV
LABELV $558
line 726
;724:	}
;725:
;726:	if (pps->eventSequence != ps->eventSequence)
ADDRFP4 4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
EQI4 $564
line 727
;727:		return 8;
CNSTI4 8
RETI4
ADDRGP4 $495
JUMPV
LABELV $564
line 729
;728:
;729:	for (i = 0; i < MAX_PS_EVENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $566
line 730
;730:		if (pps->events[i] != ps->events[i]) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
EQI4 $570
line 731
;731:			if (cg_showmiss.integer > 1) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $572
line 732
;732:				CG_Printf("event[%i] %i => %i\n", i, pps->events[i], ps->events[i]);
ADDRGP4 $575
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 733
;733:			}
LABELV $572
line 734
;734:			return 9;
CNSTI4 9
RETI4
ADDRGP4 $495
JUMPV
LABELV $570
line 736
;735:		}
;736:		if (pps->eventParms[i] != ps->eventParms[i]) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 120
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDP4
INDIRI4
EQI4 $576
line 737
;737:			if (cg_showmiss.integer > 1) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $578
line 738
;738:				CG_Printf("eventParms[%i] %i => %i\n", i, pps->eventParms[i], ps->eventParms[i]);
ADDRGP4 $581
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 120
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 120
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 739
;739:			}
LABELV $578
line 740
;740:			return 9;
CNSTI4 9
RETI4
ADDRGP4 $495
JUMPV
LABELV $576
line 742
;741:		}
;742:	}
LABELV $567
line 729
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $566
line 744
;743:
;744:	if (pps->externalEvent != ps->externalEvent ||
ADDRLP4 92
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
ADDRLP4 96
INDIRP4
CNSTI4 128
ADDP4
INDIRI4
NEI4 $585
ADDRLP4 92
INDIRP4
CNSTI4 132
ADDP4
INDIRI4
ADDRLP4 96
INDIRP4
CNSTI4 132
ADDP4
INDIRI4
NEI4 $585
ADDRLP4 92
INDIRP4
CNSTI4 136
ADDP4
INDIRI4
ADDRLP4 96
INDIRP4
CNSTI4 136
ADDP4
INDIRI4
EQI4 $582
LABELV $585
line 746
;745:		pps->externalEventParm != ps->externalEventParm ||
;746:		pps->externalEventTime != ps->externalEventTime) {
line 747
;747:		return 10;
CNSTI4 10
RETI4
ADDRGP4 $495
JUMPV
LABELV $582
line 750
;748:	}
;749:
;750:	if (pps->clientNum != ps->clientNum ||
ADDRLP4 100
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 100
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
ADDRLP4 104
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
NEI4 $589
ADDRLP4 100
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ADDRLP4 104
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
NEI4 $589
ADDRLP4 100
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ADDRLP4 104
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
EQI4 $586
LABELV $589
line 752
;751:		pps->weapon != ps->weapon ||
;752:		pps->weaponstate != ps->weaponstate) {
line 753
;753:		return 11;
CNSTI4 11
RETI4
ADDRGP4 $495
JUMPV
LABELV $586
line 756
;754:	}
;755:
;756:	if (fabs(AngleDelta(ps->viewangles[0], pps->viewangles[0])) > 1.0f ||
ADDRFP4 0
INDIRP4
CNSTI4 152
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRP4
CNSTI4 152
ADDP4
INDIRF4
ARGF4
ADDRLP4 108
ADDRGP4 AngleDelta
CALLF4
ASGNF4
ADDRLP4 108
INDIRF4
ARGF4
ADDRLP4 112
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 112
INDIRF4
CNSTF4 1065353216
GTF4 $593
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRP4
CNSTI4 156
ADDP4
INDIRF4
ARGF4
ADDRLP4 116
ADDRGP4 AngleDelta
CALLF4
ASGNF4
ADDRLP4 116
INDIRF4
ARGF4
ADDRLP4 120
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 120
INDIRF4
CNSTF4 1065353216
GTF4 $593
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRP4
CNSTI4 160
ADDP4
INDIRF4
ARGF4
ADDRLP4 124
ADDRGP4 AngleDelta
CALLF4
ASGNF4
ADDRLP4 124
INDIRF4
ARGF4
ADDRLP4 128
ADDRGP4 fabs
CALLF4
ASGNF4
ADDRLP4 128
INDIRF4
CNSTF4 1065353216
LEF4 $590
LABELV $593
line 758
;757:		fabs(AngleDelta(ps->viewangles[1], pps->viewangles[1])) > 1.0f ||
;758:		fabs(AngleDelta(ps->viewangles[2], pps->viewangles[2])) > 1.0f) {
line 759
;759:		return 12;
CNSTI4 12
RETI4
ADDRGP4 $495
JUMPV
LABELV $590
line 762
;760:	}
;761:
;762:	if (pps->viewheight != ps->viewheight)
ADDRFP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
EQI4 $594
line 763
;763:		return 13;
CNSTI4 13
RETI4
ADDRGP4 $495
JUMPV
LABELV $594
line 765
;764:
;765:	if (pps->damageEvent != ps->damageEvent ||
ADDRLP4 132
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 132
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ADDRLP4 136
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
NEI4 $600
ADDRLP4 132
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ADDRLP4 136
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
NEI4 $600
ADDRLP4 132
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ADDRLP4 136
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
NEI4 $600
ADDRLP4 132
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ADDRLP4 136
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
EQI4 $596
LABELV $600
line 768
;766:		pps->damageYaw != ps->damageYaw ||
;767:		pps->damagePitch != ps->damagePitch ||
;768:		pps->damageCount != ps->damageCount) {
line 769
;769:		if (cg_showmiss.integer > 1)
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $601
line 770
;770:			CG_Printf("dmg %i %i %i %i >= %i %i %i %i\n",
ADDRGP4 $604
ARGP4
ADDRLP4 140
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 140
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ARGI4
ADDRLP4 140
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ARGI4
ADDRLP4 140
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 140
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ARGI4
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 144
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ARGI4
ADDRLP4 144
INDIRP4
CNSTI4 172
ADDP4
INDIRI4
ARGI4
ADDRLP4 144
INDIRP4
CNSTI4 176
ADDP4
INDIRI4
ARGI4
ADDRLP4 144
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $601
line 773
;771:				pps->damageEvent, pps->damageYaw, pps->damagePitch, pps->damageCount,
;772:				ps->damageEvent, ps->damageYaw, ps->damagePitch, ps->damageCount);
;773:		return 14;
CNSTI4 14
RETI4
ADDRGP4 $495
JUMPV
LABELV $596
line 777
;774:	}
;775:
;776:	// health countdown?
;777:	if (pps->stats[STAT_HEALTH] == ps->stats[STAT_HEALTH] + 1 && ps->stats[STAT_HEALTH] >= ps->stats[STAT_MAX_HEALTH]) {
ADDRLP4 140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 140
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 1
ADDI4
NEI4 $605
ADDRLP4 140
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ADDRLP4 140
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
LTI4 $605
line 778
;778:		cg.timeResidual = ps->commandTime + 1000;
ADDRGP4 cg+157000
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 779
;779:		for (n = 0; n < NUM_SAVED_STATES; n++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $608
line 780
;780:			cg.savedPmoveStates[n].stats[STAT_HEALTH] = ps->stats[STAT_HEALTH];
ADDRLP4 4
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126100+184
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 781
;781:		}
LABELV $609
line 779
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 66
LTI4 $608
line 783
;782:
;783:	}
LABELV $605
line 785
;784:	// armor countdown?
;785:	if (pps->stats[STAT_ARMOR] == ps->stats[STAT_ARMOR] - 1 && ps->stats[STAT_ARMOR] >= ps->stats[STAT_MAX_HEALTH]) {
ADDRLP4 144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 4
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ADDRLP4 144
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
CNSTI4 1
SUBI4
NEI4 $614
ADDRLP4 144
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ADDRLP4 144
INDIRP4
CNSTI4 212
ADDP4
INDIRI4
LTI4 $614
line 787
;786:		// we may need few frames to sync with client->timeResidual on server side
;787:		cg.timeResidual = ps->commandTime + 1000;
ADDRGP4 cg+157000
ADDRFP4 0
INDIRP4
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 788
;788:		for (n = 0; n < NUM_SAVED_STATES; n++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $617
line 789
;789:			cg.savedPmoveStates[n].stats[STAT_ARMOR] = ps->stats[STAT_ARMOR];
ADDRLP4 4
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126100+184+16
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 200
ADDP4
INDIRI4
ASGNI4
line 790
;790:		}
LABELV $618
line 788
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 66
LTI4 $617
line 791
;791:	}
LABELV $614
line 793
;792:
;793:	for (i = 0; i < MAX_STATS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $624
line 795
;794:		// we can't predict some flags
;795:		if (i == STAT_CLIENTS_READY /*|| i == STAT_MAX_HEALTH */) {
ADDRLP4 0
INDIRI4
CNSTI4 6
NEI4 $628
line 796
;796:			for (n = 0; n < NUM_SAVED_STATES; n++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $630
line 797
;797:				cg.savedPmoveStates[n].stats[i] = ps->stats[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126100+184
ADDP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDP4
INDIRI4
ASGNI4
line 798
;798:			}
LABELV $631
line 796
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 66
LTI4 $630
line 799
;799:			continue;
ADDRGP4 $625
JUMPV
LABELV $628
line 801
;800:		}
;801:		if (pps->stats[i] != ps->stats[i]) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDP4
INDIRI4
EQI4 $636
line 802
;802:			if (cg_showmiss.integer > 1) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $638
line 803
;803:				CG_Printf("stats[%i] %i => %i ", i, pps->stats[i], ps->stats[i]);
ADDRGP4 $641
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 184
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 804
;804:			}
LABELV $638
line 805
;805:			return 15;
CNSTI4 15
RETI4
ADDRGP4 $495
JUMPV
LABELV $636
line 807
;806:		}
;807:	}
LABELV $625
line 793
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $624
line 810
;808:
;809:
;810:	for (i = 0; i < MAX_PERSISTANT; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $642
line 811
;811:		if (pps->persistant[i] != ps->persistant[i]) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 248
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 248
ADDP4
ADDP4
INDIRI4
EQI4 $646
line 812
;812:			if (i >= PERS_TEAM && i <= PERS_PLAYEREVENTS) {
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $648
ADDRLP4 0
INDIRI4
CNSTI4 5
GTI4 $648
line 813
;813:				if (cg_showmiss.integer > 1) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $650
line 814
;814:					CG_Printf("persistant[%i] %i => %i ", i, pps->persistant[i], ps->persistant[i]);
ADDRGP4 $653
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 248
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 248
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 815
;815:				}
LABELV $650
line 816
;816:				return 16;
CNSTI4 16
RETI4
ADDRGP4 $495
JUMPV
LABELV $648
line 818
;817:			}
;818:			v0 = ps->persistant[i];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 248
ADDP4
ADDP4
INDIRI4
ASGNI4
line 819
;819:			for (n = 0; n < NUM_SAVED_STATES; n++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $654
line 820
;820:				cg.savedPmoveStates[n].persistant[i] = v0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126100+248
ADDP4
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 821
;821:			}
LABELV $655
line 819
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 66
LTI4 $654
line 822
;822:			*forceMove = qtrue;
ADDRFP4 8
INDIRP4
CNSTI4 1
ASGNI4
line 823
;823:		}
LABELV $646
line 824
;824:	}
LABELV $643
line 810
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $642
line 826
;825:
;826:	for (i = 0; i < MAX_WEAPONS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $660
line 827
;827:		if (pps->ammo[i] != ps->ammo[i]) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
EQI4 $664
line 828
;828:			if (cg_showmiss.integer > 1) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $666
line 829
;829:				CG_Printf("ammo[%i] %i => %i ", i, pps->ammo[i], ps->ammo[i]);
ADDRGP4 $669
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 830
;830:			}
LABELV $666
line 831
;831:			return 18;
CNSTI4 18
RETI4
ADDRGP4 $495
JUMPV
LABELV $664
line 833
;832:		}
;833:	}
LABELV $661
line 826
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $660
line 835
;834:
;835:	if (pps->generic1 != ps->generic1 || pps->loopSound != ps->loopSound) {
ADDRLP4 148
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
ADDRLP4 152
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
NEI4 $672
ADDRLP4 148
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
ADDRLP4 152
INDIRP4
CNSTI4 444
ADDP4
INDIRI4
EQI4 $670
LABELV $672
line 836
;836:		return 19;
CNSTI4 19
RETI4
ADDRGP4 $495
JUMPV
LABELV $670
line 839
;837:	}
;838:
;839:	for (i = 0; i < MAX_POWERUPS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $673
line 840
;840:		if (pps->powerups[i] != ps->powerups[i]) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
EQI4 $677
line 841
;841:			if (cg_showmiss.integer > 1)
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $679
line 842
;842:				CG_Printf("powerups[%i] %i => %i ", i, pps->powerups[i], ps->powerups[i]);
ADDRGP4 $682
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
LABELV $679
line 843
;843:			return 20;
CNSTI4 20
RETI4
ADDRGP4 $495
JUMPV
LABELV $677
line 845
;844:		}
;845:	}
LABELV $674
line 839
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $673
line 847
;846:
;847:	return 0;
CNSTI4 0
RETI4
LABELV $495
endproc CG_IsUnacceptableError 164 36
export CG_PredictPlayerState
proc CG_PredictPlayerState 596 28
line 877
;848:}
;849:
;850:
;851:/*
;852:=================
;853:CG_PredictPlayerState
;854:
;855:Generates cg.predictedPlayerState for the current cg.time
;856:cg.predictedPlayerState is guaranteed to be valid after exiting.
;857:
;858:For demo playback, this will be an interpolation between two valid
;859:playerState_t.
;860:
;861:For normal gameplay, it will be the result of predicted usercmd_t on
;862:top of the most recent playerState_t received from the server.
;863:
;864:Each new snapshot will usually have one or more new usercmd over the last,
;865:but we simulate all unacknowledged commands each time, not just the new ones.
;866:This means that on an internet connection, quite a few pmoves may be issued
;867:each frame.
;868:
;869:OPTIMIZE: don't re-simulate unless the newly arrived snapshot playerState_t
;870:differs from the predicted one.  Would require saving all intermediate
;871:playerState_t during prediction.
;872:
;873:We detect prediction errors and allow them to be decayed off over several frames
;874:to ease the jerk.
;875:=================
;876:*/
;877:void CG_PredictPlayerState(void) {
line 883
;878:	int			cmdNum, current;
;879:	playerState_t	oldPlayerState;
;880:	qboolean	moved;
;881:	usercmd_t	oldestCmd;
;882:	usercmd_t	latestCmd;
;883:	int stateIndex = 0, predictCmd = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 484
CNSTI4 0
ASGNI4
line 885
;884:
;885:	cg.hyperspace = qfalse;	// will be set if touching a trigger_teleport
ADDRGP4 cg+107632
CNSTI4 0
ASGNI4
line 890
;886:
;887:	// if this is the first frame we must guarantee
;888:	// predictedPlayerState is valid even if there is some
;889:	// other error condition
;890:	if (!cg.validPPS) {
ADDRGP4 cg+108844
INDIRI4
CNSTI4 0
NEI4 $685
line 891
;891:		cg.validPPS = qtrue;
ADDRGP4 cg+108844
CNSTI4 1
ASGNI4
line 892
;892:		cg.predictedPlayerState = cg.snap->ps;
ADDRGP4 cg+107636
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 468
line 893
;893:	}
LABELV $685
line 897
;894:
;895:
;896:	// demo playback just copies the moves
;897:	if (cg.demoPlayback || (cg.snap->ps.pm_flags & PMF_FOLLOW)) {
ADDRGP4 cg+8
INDIRI4
CNSTI4 0
NEI4 $695
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $691
LABELV $695
line 898
;898:		CG_InterpolatePlayerState(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 CG_InterpolatePlayerState
CALLV
pop
line 899
;899:		return;
ADDRGP4 $683
JUMPV
LABELV $691
line 903
;900:	}
;901:
;902:	// non-predicting local movement will grab the latest angles
;903:	if (cg_nopredict.integer || cgs.synchronousClients) {
ADDRGP4 cg_nopredict+12
INDIRI4
CNSTI4 0
NEI4 $700
ADDRGP4 cgs+150000
INDIRI4
CNSTI4 0
EQI4 $696
LABELV $700
line 904
;904:		CG_InterpolatePlayerState(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 CG_InterpolatePlayerState
CALLV
pop
line 905
;905:		return;
ADDRGP4 $683
JUMPV
LABELV $696
line 909
;906:	}
;907:
;908:	// prepare for pmove
;909:	cg_pmove.ps = &cg.predictedPlayerState;
ADDRGP4 cg_pmove
ADDRGP4 cg+107636
ASGNP4
line 910
;910:	cg_pmove.trace = CG_Trace;
ADDRGP4 cg_pmove+216
ADDRGP4 CG_Trace
ASGNP4
line 911
;911:	cg_pmove.pointcontents = CG_PointContents;
ADDRGP4 cg_pmove+220
ADDRGP4 CG_PointContents
ASGNP4
line 912
;912:	if (cg_pmove.ps->pm_type == PM_DEAD) {
ADDRGP4 cg_pmove
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $704
line 913
;913:		cg_pmove.tracemask = MASK_PLAYERSOLID & ~CONTENTS_BODY;
ADDRGP4 cg_pmove+28
CNSTI4 65537
ASGNI4
line 914
;914:	} else {
ADDRGP4 $705
JUMPV
LABELV $704
line 915
;915:		cg_pmove.tracemask = MASK_PLAYERSOLID;
ADDRGP4 cg_pmove+28
CNSTI4 33619969
ASGNI4
line 916
;916:	}
LABELV $705
line 917
;917:	if (cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $708
line 918
;918:		cg_pmove.tracemask &= ~CONTENTS_BODY;	// spectators can fly through bodies
ADDRLP4 536
ADDRGP4 cg_pmove+28
ASGNP4
ADDRLP4 536
INDIRP4
ADDRLP4 536
INDIRP4
INDIRI4
CNSTI4 -33554433
BANDI4
ASGNI4
line 919
;919:	}
LABELV $708
line 922
;920:
;921:	// save the state before the pmove so we can detect transitions
;922:	oldPlayerState = cg.predictedPlayerState;
ADDRLP4 8
ADDRGP4 cg+107636
INDIRB
ASGNB 468
line 924
;923:
;924:	current = trap_GetCurrentCmdNumber();
ADDRLP4 536
ADDRGP4 trap_GetCurrentCmdNumber
CALLI4
ASGNI4
ADDRLP4 476
ADDRLP4 536
INDIRI4
ASGNI4
line 929
;925:
;926:	// if we don't have the commands right after the snapshot, we
;927:	// can't accurately predict a current position, so just freeze at
;928:	// the last good position we had
;929:	cmdNum = current - CMD_BACKUP + 1;
ADDRLP4 0
ADDRLP4 476
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 930
;930:	trap_GetUserCmd(cmdNum, &oldestCmd);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 512
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 931
;931:	if (oldestCmd.serverTime > cg.snap->ps.commandTime
ADDRLP4 540
ADDRLP4 512
INDIRI4
ASGNI4
ADDRLP4 540
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
LEI4 $713
ADDRLP4 540
INDIRI4
ADDRGP4 cg+107604
INDIRI4
GEI4 $713
line 932
;932:		&& oldestCmd.serverTime < cg.time) {	// special check for map_restart
line 933
;933:		if (cg_showmiss.integer) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $683
line 934
;934:			CG_Printf("exceeded PACKET_BACKUP on commands\n");
ADDRGP4 $720
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 935
;935:		}
line 936
;936:		return;
ADDRGP4 $683
JUMPV
LABELV $713
line 940
;937:	}
;938:
;939:	// get the latest command so we can know which commands are from previous map_restarts
;940:	trap_GetUserCmd(current, &latestCmd);
ADDRLP4 476
INDIRI4
ARGI4
ADDRLP4 488
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 946
;941:
;942:	// get the most recent information we have, even if
;943:	// the server time is beyond our current cg.time,
;944:	// because predicted player positions are going to 
;945:	// be ahead of everything else anyway
;946:	if (cg.nextSnap && !cg.nextFrameTeleport && !cg.thisFrameTeleport) {
ADDRGP4 cg+40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $721
ADDRGP4 cg+107596
INDIRI4
CNSTI4 0
NEI4 $721
ADDRGP4 cg+107592
INDIRI4
CNSTI4 0
NEI4 $721
line 947
;947:		cg.predictedPlayerState = cg.nextSnap->ps;
ADDRGP4 cg+107636
ADDRGP4 cg+40
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 468
line 948
;948:		cg.physicsTime = cg.nextSnap->serverTime;
ADDRGP4 cg+107612
ADDRGP4 cg+40
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 949
;949:	} else {
ADDRGP4 $722
JUMPV
LABELV $721
line 950
;950:		cg.predictedPlayerState = cg.snap->ps;
ADDRGP4 cg+107636
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRB
ASGNB 468
line 951
;951:		cg.physicsTime = cg.snap->serverTime;
ADDRGP4 cg+107612
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 952
;952:	}
LABELV $722
line 954
;953:
;954:	cg_pmove.pmove_fixed = cgs.pmove_fixed;
ADDRGP4 cg_pmove+208
ADDRGP4 cgs+149992
INDIRI4
ASGNI4
line 955
;955:	cg_pmove.pmove_msec = cgs.pmove_msec;
ADDRGP4 cg_pmove+212
ADDRGP4 cgs+149996
INDIRI4
ASGNI4
line 958
;956:
;957:	// clean event stack
;958:	eventStack = 0;
ADDRGP4 eventStack
CNSTI4 0
ASGNI4
line 961
;959:
;960:	// run cmds
;961:	moved = qfalse;
ADDRLP4 480
CNSTI4 0
ASGNI4
line 963
;962:
;963:	cg_pmove.pmove_fixed = cgs.pmove_fixed;
ADDRGP4 cg_pmove+208
ADDRGP4 cgs+149992
INDIRI4
ASGNI4
line 964
;964:	cg_pmove.pmove_msec = cgs.pmove_msec;
ADDRGP4 cg_pmove+212
ADDRGP4 cgs+149996
INDIRI4
ASGNI4
line 984
;965:
;966:	// Like the comments described above, a player's state is entirely
;967:	// re-predicted from the last valid snapshot every client frame, which
;968:	// can be really, really, really slow.  Every old command has to be
;969:	// run again.  For every client frame that is *not* directly after a
;970:	// snapshot, this is unnecessary, since we have no new information.
;971:	// For those, we'll play back the predictions from the last frame and
;972:	// predict only the newest commands.  Essentially, we'll be doing
;973:	// an incremental predict instead of a full predict.
;974:	//
;975:	// If we have a new snapshot, we can compare its player state's command
;976:	// time to the command times in the queue to find a match.  If we find
;977:	// a matching state, and the predicted version has not deviated, we can
;978:	// use the predicted state as a base - and also do an incremental predict.
;979:	//
;980:	// With this method, we get incremental predicts on every client frame
;981:	// except a frame following a new snapshot in which there was a prediction
;982:	// error.  This yeilds anywhere from a 15% to 40% performance increase,
;983:	// depending on how much of a bottleneck the CPU is.
;984:	if (1 /* cg_optimizePrediction.integer */) {
line 985
;985:		if (cg.nextFrameTeleport || cg.thisFrameTeleport) {
ADDRGP4 cg+107596
INDIRI4
CNSTI4 0
NEI4 $748
ADDRGP4 cg+107592
INDIRI4
CNSTI4 0
EQI4 $744
LABELV $748
line 987
;986:			// do a full predict
;987:			cg.lastPredictedCommand = 0;
ADDRGP4 cg+126092
CNSTI4 0
ASGNI4
line 988
;988:			cg.stateTail = cg.stateHead;
ADDRGP4 cg+156992
ADDRGP4 cg+156988
INDIRI4
ASGNI4
line 989
;989:			predictCmd = current - CMD_BACKUP + 1;
ADDRLP4 484
ADDRLP4 476
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 990
;990:		}
ADDRGP4 $745
JUMPV
LABELV $744
line 993
;991:		// cg.physicsTime is the current snapshot's serverTime if it's the same
;992:		// as the last one
;993:		else if (cg.physicsTime == cg.lastServerTime) {
ADDRGP4 cg+107612
INDIRI4
ADDRGP4 cg+126096
INDIRI4
NEI4 $752
line 995
;994:			// we have no new information, so do an incremental predict
;995:			predictCmd = cg.lastPredictedCommand + 1;
ADDRLP4 484
ADDRGP4 cg+126092
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 996
;996:		} else {
ADDRGP4 $753
JUMPV
LABELV $752
line 1000
;997:			// we have a new snapshot
;998:			int i;
;999:			int errorcode;
;1000:			qboolean error = qtrue;
ADDRLP4 552
CNSTI4 1
ASGNI4
line 1003
;1001:
;1002:			// loop through the saved states queue
;1003:			for (i = cg.stateHead; i != cg.stateTail; i = (i + 1) % NUM_SAVED_STATES) {
ADDRLP4 544
ADDRGP4 cg+156988
INDIRI4
ASGNI4
ADDRGP4 $760
JUMPV
LABELV $757
line 1006
;1004:				// if we find a predicted state whose commandTime matches the snapshot
;1005:				// player state's commandTime
;1006:				if (cg.savedPmoveStates[i].commandTime != cg.predictedPlayerState.commandTime) {
ADDRLP4 544
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126100
ADDP4
INDIRI4
ADDRGP4 cg+107636
INDIRI4
EQI4 $763
line 1007
;1007:					continue;
ADDRGP4 $758
JUMPV
LABELV $763
line 1010
;1008:				}
;1009:				// make sure the state differences are acceptable
;1010:				errorcode = CG_IsUnacceptableError(&cg.predictedPlayerState, &cg.savedPmoveStates[i], &moved);
ADDRGP4 cg+107636
ARGP4
ADDRLP4 544
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126100
ADDP4
ARGP4
ADDRLP4 480
ARGP4
ADDRLP4 556
ADDRGP4 CG_IsUnacceptableError
CALLI4
ASGNI4
ADDRLP4 548
ADDRLP4 556
INDIRI4
ASGNI4
line 1011
;1011:				if (errorcode) {
ADDRLP4 548
INDIRI4
CNSTI4 0
EQI4 $769
line 1012
;1012:					if (cg_showmiss.integer > 1)
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 1
LEI4 $759
line 1013
;1013:						CG_Printf("errorcode %d at %d\n", errorcode, cg.time);
ADDRGP4 $774
ARGP4
ADDRLP4 548
INDIRI4
ARGI4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 1014
;1014:					break;
ADDRGP4 $759
JUMPV
LABELV $769
line 1018
;1015:				}
;1016:
;1017:				// this one is almost exact, so we'll copy it in as the starting point
;1018:				*cg_pmove.ps = cg.savedPmoveStates[i];
ADDRGP4 cg_pmove
INDIRP4
ADDRLP4 544
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126100
ADDP4
INDIRB
ASGNB 468
line 1020
;1019:				// advance the head
;1020:				cg.stateHead = (i + 1) % NUM_SAVED_STATES;
ADDRGP4 cg+156988
ADDRLP4 544
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ASGNI4
line 1023
;1021:
;1022:				// set the next command to predict
;1023:				predictCmd = cg.lastPredictedCommand + 1;
ADDRLP4 484
ADDRGP4 cg+126092
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1026
;1024:
;1025:				// a saved state matched, so flag it
;1026:				error = qfalse;
ADDRLP4 552
CNSTI4 0
ASGNI4
line 1027
;1027:				break;
ADDRGP4 $759
JUMPV
LABELV $758
line 1003
ADDRLP4 544
ADDRLP4 544
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ASGNI4
LABELV $760
ADDRLP4 544
INDIRI4
ADDRGP4 cg+156992
INDIRI4
NEI4 $757
LABELV $759
line 1031
;1028:			}
;1029:
;1030:			// if no saved states matched
;1031:			if (error) {
ADDRLP4 552
INDIRI4
CNSTI4 0
EQI4 $779
line 1033
;1032:				// do a full predict
;1033:				cg.lastPredictedCommand = 0;
ADDRGP4 cg+126092
CNSTI4 0
ASGNI4
line 1034
;1034:				cg.stateTail = cg.stateHead;
ADDRGP4 cg+156992
ADDRGP4 cg+156988
INDIRI4
ASGNI4
line 1035
;1035:				predictCmd = current - CMD_BACKUP + 1;
ADDRLP4 484
ADDRLP4 476
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1036
;1036:			}
LABELV $779
line 1037
;1037:		}
LABELV $753
LABELV $745
line 1040
;1038:		// keep track of the server time of the last snapshot so we
;1039:		// know when we're starting from a new one in future calls
;1040:		cg.lastServerTime = cg.physicsTime;
ADDRGP4 cg+126096
ADDRGP4 cg+107612
INDIRI4
ASGNI4
line 1041
;1041:		stateIndex = cg.stateHead;
ADDRLP4 4
ADDRGP4 cg+156988
INDIRI4
ASGNI4
line 1042
;1042:	}
LABELV $742
line 1044
;1043:
;1044:	cmdNum = current - CMD_BACKUP + 1;
ADDRLP4 0
ADDRLP4 476
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1045
;1045:	if (cmdNum < 0) // can happen on first spawn
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $792
line 1046
;1046:		cmdNum = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1051
;1047:
;1048:	// run cmds
;1049:	// moved = qfalse;
;1050:
;1051:	for ( /* cmdNum = current - CMD_BACKUP + 1 */; cmdNum <= current; cmdNum++) {
ADDRGP4 $792
JUMPV
LABELV $789
line 1053
;1052:		// get the command
;1053:		trap_GetUserCmd(cmdNum, &cg_pmove.cmd);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cg_pmove+4
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 1055
;1054:
;1055:		if (cgs.pmove_fixed) {
ADDRGP4 cgs+149992
INDIRI4
CNSTI4 0
EQI4 $794
line 1056
;1056:			PM_UpdateViewAngles(cg_pmove.ps, &cg_pmove.cmd);
ADDRGP4 cg_pmove
INDIRP4
ARGP4
ADDRGP4 cg_pmove+4
ARGP4
ADDRGP4 PM_UpdateViewAngles
CALLV
pop
line 1057
;1057:		}
LABELV $794
line 1060
;1058:
;1059:		// don't do anything if the time is before the snapshot player time
;1060:		if (cg_pmove.cmd.serverTime <= cg.predictedPlayerState.commandTime) {
ADDRGP4 cg_pmove+4
INDIRI4
ADDRGP4 cg+107636
INDIRI4
GTI4 $798
line 1061
;1061:			continue;
ADDRGP4 $790
JUMPV
LABELV $798
line 1065
;1062:		}
;1063:
;1064:		// don't do anything if the command was from a previous map_restart
;1065:		if (cg_pmove.cmd.serverTime > latestCmd.serverTime) {
ADDRGP4 cg_pmove+4
INDIRI4
ADDRLP4 488
INDIRI4
LEI4 $802
line 1066
;1066:			continue;
ADDRGP4 $790
JUMPV
LABELV $802
line 1074
;1067:		}
;1068:
;1069:		// check for a prediction error from last frame
;1070:		// on a lan, this will often be the exact value
;1071:		// from the snapshot, but on a wan we will have
;1072:		// to predict several commands to get to the point
;1073:		// we want to compare
;1074:		if (cg.predictedPlayerState.commandTime == oldPlayerState.commandTime) {
ADDRGP4 cg+107636
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $805
line 1078
;1075:			vec3_t	delta;
;1076:			float	len;
;1077:
;1078:			if (cg.thisFrameTeleport) {
ADDRGP4 cg+107592
INDIRI4
CNSTI4 0
EQI4 $808
line 1080
;1079:				// a teleport will not cause an error decay
;1080:				VectorClear(cg.predictedError);
ADDRGP4 cg+108852
CNSTF4 0
ASGNF4
ADDRGP4 cg+108852+4
CNSTF4 0
ASGNF4
ADDRGP4 cg+108852+8
CNSTF4 0
ASGNF4
line 1081
;1081:				if (cg_showmiss.integer) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $816
line 1082
;1082:					CG_Printf("PredictionTeleport\n");
ADDRGP4 $819
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1083
;1083:				}
LABELV $816
line 1084
;1084:				cg.thisFrameTeleport = qfalse;
ADDRGP4 cg+107592
CNSTI4 0
ASGNI4
line 1087
;1085:
;1086:				// delay prediction for some time or until first server event
;1087:				cg.allowPickupPrediction = cg.time + PICKUP_PREDICTION_DELAY;
ADDRGP4 cg+157004
ADDRGP4 cg+107604
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 1088
;1088:			} else {
ADDRGP4 $809
JUMPV
LABELV $808
line 1090
;1089:				vec3_t adjusted, new_angles;
;1090:				CG_AdjustPositionForMover(cg.predictedPlayerState.origin,
ADDRGP4 cg+107636+20
ARGP4
ADDRGP4 cg+107636+68
INDIRI4
ARGI4
ADDRGP4 cg+107612
INDIRI4
ARGI4
ADDRGP4 cg+107608
INDIRI4
ARGI4
ADDRLP4 560
ARGP4
ADDRGP4 cg+107636+152
ARGP4
ADDRLP4 572
ARGP4
ADDRGP4 CG_AdjustPositionForMover
CALLV
pop
line 1093
;1091:					cg.predictedPlayerState.groundEntityNum, cg.physicsTime, cg.oldTime, adjusted, cg.predictedPlayerState.viewangles, new_angles);
;1092:
;1093:				if (cg_showmiss.integer) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $831
line 1094
;1094:					if (!VectorCompare(oldPlayerState.origin, adjusted)) {
ADDRLP4 8+20
ARGP4
ADDRLP4 560
ARGP4
ADDRLP4 584
ADDRGP4 VectorCompare
CALLI4
ASGNI4
ADDRLP4 584
INDIRI4
CNSTI4 0
NEI4 $834
line 1095
;1095:						CG_Printf("prediction error\n");
ADDRGP4 $837
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1096
;1096:					}
LABELV $834
line 1097
;1097:				}
LABELV $831
line 1098
;1098:				VectorSubtract(oldPlayerState.origin, adjusted, delta);
ADDRLP4 544
ADDRLP4 8+20
INDIRF4
ADDRLP4 560
INDIRF4
SUBF4
ASGNF4
ADDRLP4 544+4
ADDRLP4 8+20+4
INDIRF4
ADDRLP4 560+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 544+8
ADDRLP4 8+20+8
INDIRF4
ADDRLP4 560+8
INDIRF4
SUBF4
ASGNF4
line 1099
;1099:				len = VectorLengthSquared(delta);
ADDRLP4 544
ARGP4
ADDRLP4 584
ADDRGP4 VectorLengthSquared
CALLF4
ASGNF4
ADDRLP4 556
ADDRLP4 584
INDIRF4
ASGNF4
line 1100
;1100:				if (len > (0.01f * 0.01f)) {
ADDRLP4 556
INDIRF4
CNSTF4 953267991
LEF4 $847
line 1101
;1101:					if (cg_showmiss.integer) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $849
line 1102
;1102:						CG_Printf("Prediction miss: %f\n", sqrt(len));
ADDRLP4 556
INDIRF4
ARGF4
ADDRLP4 588
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRGP4 $852
ARGP4
ADDRLP4 588
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 1103
;1103:					}
LABELV $849
line 1104
;1104:					if (cg_errorDecay.integer) {
ADDRGP4 cg_errorDecay+12
INDIRI4
CNSTI4 0
EQI4 $853
line 1108
;1105:						int		t;
;1106:						float	f;
;1107:
;1108:						t = cg.time - cg.predictedErrorTime;
ADDRLP4 592
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+108848
INDIRI4
SUBI4
ASGNI4
line 1109
;1109:						f = (cg_errorDecay.value - t) / cg_errorDecay.value;
ADDRLP4 588
ADDRGP4 cg_errorDecay+8
INDIRF4
ADDRLP4 592
INDIRI4
CVIF4 4
SUBF4
ADDRGP4 cg_errorDecay+8
INDIRF4
DIVF4
ASGNF4
line 1110
;1110:						if (f < 0) {
ADDRLP4 588
INDIRF4
CNSTF4 0
GEF4 $860
line 1111
;1111:							f = 0;
ADDRLP4 588
CNSTF4 0
ASGNF4
line 1112
;1112:						} else
ADDRGP4 $861
JUMPV
LABELV $860
line 1113
;1113:							if (f > 0 && cg_showmiss.integer) {
ADDRLP4 588
INDIRF4
CNSTF4 0
LEF4 $862
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $862
line 1114
;1114:								CG_Printf("Double prediction decay: %f\n", f);
ADDRGP4 $865
ARGP4
ADDRLP4 588
INDIRF4
ARGF4
ADDRGP4 CG_Printf
CALLV
pop
line 1115
;1115:							}
LABELV $862
LABELV $861
line 1116
;1116:						VectorScale(cg.predictedError, f, cg.predictedError);
ADDRGP4 cg+108852
ADDRGP4 cg+108852
INDIRF4
ADDRLP4 588
INDIRF4
MULF4
ASGNF4
ADDRGP4 cg+108852+4
ADDRGP4 cg+108852+4
INDIRF4
ADDRLP4 588
INDIRF4
MULF4
ASGNF4
ADDRGP4 cg+108852+8
ADDRGP4 cg+108852+8
INDIRF4
ADDRLP4 588
INDIRF4
MULF4
ASGNF4
line 1117
;1117:					} else {
ADDRGP4 $854
JUMPV
LABELV $853
line 1118
;1118:						VectorClear(cg.predictedError);
ADDRGP4 cg+108852
CNSTF4 0
ASGNF4
ADDRGP4 cg+108852+4
CNSTF4 0
ASGNF4
ADDRGP4 cg+108852+8
CNSTF4 0
ASGNF4
line 1119
;1119:					}
LABELV $854
line 1120
;1120:					VectorAdd(delta, cg.predictedError, cg.predictedError);
ADDRGP4 cg+108852
ADDRLP4 544
INDIRF4
ADDRGP4 cg+108852
INDIRF4
ADDF4
ASGNF4
ADDRGP4 cg+108852+4
ADDRLP4 544+4
INDIRF4
ADDRGP4 cg+108852+4
INDIRF4
ADDF4
ASGNF4
ADDRGP4 cg+108852+8
ADDRLP4 544+8
INDIRF4
ADDRGP4 cg+108852+8
INDIRF4
ADDF4
ASGNF4
line 1121
;1121:					cg.predictedErrorTime = cg.oldTime;
ADDRGP4 cg+108848
ADDRGP4 cg+107608
INDIRI4
ASGNI4
line 1122
;1122:				}
LABELV $847
line 1123
;1123:			}
LABELV $809
line 1124
;1124:		}
LABELV $805
line 1128
;1125:
;1126:		// don't predict gauntlet firing, which is only supposed to happen
;1127:		// when it actually inflicts damage
;1128:		cg_pmove.gauntletHit = qfalse;
ADDRGP4 cg_pmove+36
CNSTI4 0
ASGNI4
line 1130
;1129:
;1130:		if (cg_pmove.pmove_fixed) {
ADDRGP4 cg_pmove+208
INDIRI4
CNSTI4 0
EQI4 $896
line 1131
;1131:			cg_pmove.cmd.serverTime = ((cg_pmove.cmd.serverTime + cg_pmove.pmove_msec - 1) / cg_pmove.pmove_msec) * cg_pmove.pmove_msec;
ADDRGP4 cg_pmove+4
ADDRGP4 cg_pmove+4
INDIRI4
ADDRGP4 cg_pmove+212
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ADDRGP4 cg_pmove+212
INDIRI4
DIVI4
ADDRGP4 cg_pmove+212
INDIRI4
MULI4
ASGNI4
line 1132
;1132:		}
LABELV $896
line 1138
;1133:#if 0
;1134:		if (!cg_optimizePrediction.integer) {
;1135:			Pmove(&cg_pmove);
;1136:		} else
;1137:#endif
;1138:			if ( /*cg_optimizePrediction.integer && */ (cmdNum >= predictCmd || (stateIndex + 1) % NUM_SAVED_STATES == cg.stateHead)) {
ADDRLP4 0
INDIRI4
ADDRLP4 484
INDIRI4
GEI4 $907
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ADDRGP4 cg+156988
INDIRI4
NEI4 $904
LABELV $907
line 1140
;1139:
;1140:				Pmove(&cg_pmove);
ADDRGP4 cg_pmove
ARGP4
ADDRGP4 Pmove
CALLV
pop
line 1143
;1141:
;1142:				// add push trigger movement effects
;1143:				CG_TouchTriggerPrediction();
ADDRGP4 CG_TouchTriggerPrediction
CALLV
pop
line 1146
;1144:
;1145:				// check for expired powerups etc.
;1146:				CG_CheckTimers();
ADDRGP4 CG_CheckTimers
CALLV
pop
line 1149
;1147:
;1148:				// record the last predicted command
;1149:				cg.lastPredictedCommand = cmdNum;
ADDRGP4 cg+126092
ADDRLP4 0
INDIRI4
ASGNI4
line 1152
;1150:
;1151:				// if we haven't run out of space in the saved states queue
;1152:				if ((stateIndex + 1) % NUM_SAVED_STATES != cg.stateHead) {
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ADDRGP4 cg+156988
INDIRI4
EQI4 $905
line 1155
;1153:					// save the state for the false case ( of cmdNum >= predictCmd )
;1154:					// in later calls to this function
;1155:					cg.savedPmoveStates[stateIndex] = *cg_pmove.ps;
ADDRLP4 4
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126100
ADDP4
ADDRGP4 cg_pmove
INDIRP4
INDIRB
ASGNB 468
line 1156
;1156:					stateIndex = (stateIndex + 1) % NUM_SAVED_STATES;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ASGNI4
line 1157
;1157:					cg.stateTail = stateIndex;
ADDRGP4 cg+156992
ADDRLP4 4
INDIRI4
ASGNI4
line 1158
;1158:				}
line 1159
;1159:			} else {
ADDRGP4 $905
JUMPV
LABELV $904
line 1160
;1160:				*cg_pmove.ps = cg.savedPmoveStates[stateIndex];
ADDRGP4 cg_pmove
INDIRP4
ADDRLP4 4
INDIRI4
CNSTI4 468
MULI4
ADDRGP4 cg+126100
ADDP4
INDIRB
ASGNB 468
line 1161
;1161:				stateIndex = (stateIndex + 1) % NUM_SAVED_STATES;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 66
MODI4
ASGNI4
line 1162
;1162:			}
LABELV $905
line 1164
;1163:
;1164:		moved = qtrue;
ADDRLP4 480
CNSTI4 1
ASGNI4
line 1165
;1165:	}
LABELV $790
line 1051
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $792
ADDRLP4 0
INDIRI4
ADDRLP4 476
INDIRI4
LEI4 $789
line 1167
;1166:
;1167:	if (cg_showmiss.integer > 3) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 3
LEI4 $915
line 1168
;1168:		CG_Printf("[%i : %i] ", cg_pmove.cmd.serverTime, cg.time);
ADDRGP4 $918
ARGP4
ADDRGP4 cg_pmove+4
INDIRI4
ARGI4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRGP4 CG_Printf
CALLV
pop
line 1169
;1169:	}
LABELV $915
line 1171
;1170:
;1171:	if (!moved) {
ADDRLP4 480
INDIRI4
CNSTI4 0
NEI4 $921
line 1172
;1172:		if (cg_showmiss.integer) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $923
line 1173
;1173:			CG_Printf("not moved\n");
ADDRGP4 $926
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1174
;1174:		}
LABELV $923
line 1176
;1175:		// clean event stack
;1176:		eventStack = 0;
ADDRGP4 eventStack
CNSTI4 0
ASGNI4
line 1177
;1177:		return;
ADDRGP4 $683
JUMPV
LABELV $921
line 1181
;1178:	}
;1179:
;1180:	// adjust for the movement of the groundentity
;1181:	CG_AdjustPositionForMover(cg.predictedPlayerState.origin, cg.predictedPlayerState.groundEntityNum,
ADDRGP4 cg+107636+20
ARGP4
ADDRGP4 cg+107636+68
INDIRI4
ARGI4
ADDRGP4 cg+107612
INDIRI4
ARGI4
ADDRGP4 cg+107604
INDIRI4
ARGI4
ADDRGP4 cg+107636+20
ARGP4
ADDRGP4 cg+107636+152
ARGP4
ADDRGP4 cg+107636+152
ARGP4
ADDRGP4 CG_AdjustPositionForMover
CALLV
pop
line 1185
;1182:		cg.physicsTime, cg.time, cg.predictedPlayerState.origin,
;1183:		cg.predictedPlayerState.viewangles, cg.predictedPlayerState.viewangles);
;1184:
;1185:	if (cg_showmiss.integer) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $939
line 1186
;1186:		if (cg.predictedPlayerState.eventSequence > oldPlayerState.eventSequence + MAX_PS_EVENTS) {
ADDRGP4 cg+107636+108
INDIRI4
ADDRLP4 8+108
INDIRI4
CNSTI4 2
ADDI4
LEI4 $942
line 1187
;1187:			CG_Printf("WARNING: dropped event\n");
ADDRGP4 $947
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1188
;1188:		}
LABELV $942
line 1189
;1189:	}
LABELV $939
line 1192
;1190:
;1191:	// fire events and other transition triggered things
;1192:	CG_TransitionPlayerState(&cg.predictedPlayerState, &oldPlayerState);
ADDRGP4 cg+107636
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_TransitionPlayerState
CALLV
pop
line 1194
;1193:
;1194:	if (cg_showmiss.integer) {
ADDRGP4 cg_showmiss+12
INDIRI4
CNSTI4 0
EQI4 $949
line 1195
;1195:		if (cg.eventSequence > cg.predictedPlayerState.eventSequence) {
ADDRGP4 cg+108864
INDIRI4
ADDRGP4 cg+107636+108
INDIRI4
LEI4 $952
line 1196
;1196:			CG_Printf("WARNING: double event\n");
ADDRGP4 $957
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 1197
;1197:			cg.eventSequence = cg.predictedPlayerState.eventSequence;
ADDRGP4 cg+108864
ADDRGP4 cg+107636+108
INDIRI4
ASGNI4
line 1198
;1198:		}
LABELV $952
line 1199
;1199:	}
LABELV $949
line 1200
;1200:}
LABELV $683
endproc CG_PredictPlayerState 596 28
bss
export eventParm2
align 4
LABELV eventParm2
skip 64
export eventParms
align 4
LABELV eventParms
skip 64
export events
align 4
LABELV events
skip 64
export eventStack
align 4
LABELV eventStack
skip 4
align 4
LABELV cg_triggerEntities
skip 1024
align 4
LABELV cg_numTriggerEntities
skip 4
align 4
LABELV cg_solidEntities
skip 1024
align 4
LABELV cg_numSolidEntities
skip 4
align 4
LABELV cg_pmove
skip 224
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
import CG_LoadDeferredPlayers
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
LABELV $957
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 100
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $947
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $926
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $918
byte 1 91
byte 1 37
byte 1 105
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 93
byte 1 32
byte 1 0
align 1
LABELV $865
byte 1 68
byte 1 111
byte 1 117
byte 1 98
byte 1 108
byte 1 101
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 100
byte 1 101
byte 1 99
byte 1 97
byte 1 121
byte 1 58
byte 1 32
byte 1 37
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $852
byte 1 80
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 102
byte 1 10
byte 1 0
align 1
LABELV $837
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 10
byte 1 0
align 1
LABELV $819
byte 1 80
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 84
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $774
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 99
byte 1 111
byte 1 100
byte 1 101
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 97
byte 1 116
byte 1 32
byte 1 37
byte 1 100
byte 1 10
byte 1 0
align 1
LABELV $720
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 101
byte 1 100
byte 1 101
byte 1 100
byte 1 32
byte 1 80
byte 1 65
byte 1 67
byte 1 75
byte 1 69
byte 1 84
byte 1 95
byte 1 66
byte 1 65
byte 1 67
byte 1 75
byte 1 85
byte 1 80
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $682
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 91
byte 1 37
byte 1 105
byte 1 93
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 61
byte 1 62
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 0
align 1
LABELV $669
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 91
byte 1 37
byte 1 105
byte 1 93
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 61
byte 1 62
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 0
align 1
LABELV $653
byte 1 112
byte 1 101
byte 1 114
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 97
byte 1 110
byte 1 116
byte 1 91
byte 1 37
byte 1 105
byte 1 93
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 61
byte 1 62
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 0
align 1
LABELV $641
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 115
byte 1 91
byte 1 37
byte 1 105
byte 1 93
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 61
byte 1 62
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 0
align 1
LABELV $604
byte 1 100
byte 1 109
byte 1 103
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 62
byte 1 61
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $581
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 80
byte 1 97
byte 1 114
byte 1 109
byte 1 115
byte 1 91
byte 1 37
byte 1 105
byte 1 93
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 61
byte 1 62
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $575
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 91
byte 1 37
byte 1 105
byte 1 93
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 61
byte 1 62
byte 1 32
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $563
byte 1 101
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 61
byte 1 62
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $527
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 61
byte 1 62
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $515
byte 1 118
byte 1 101
byte 1 108
byte 1 111
byte 1 99
byte 1 105
byte 1 116
byte 1 121
byte 1 32
byte 1 100
byte 1 101
byte 1 108
byte 1 116
byte 1 97
byte 1 58
byte 1 32
byte 1 37
byte 1 46
byte 1 50
byte 1 102
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $507
byte 1 111
byte 1 114
byte 1 105
byte 1 103
byte 1 105
byte 1 110
byte 1 32
byte 1 100
byte 1 101
byte 1 108
byte 1 116
byte 1 97
byte 1 58
byte 1 32
byte 1 37
byte 1 46
byte 1 50
byte 1 102
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $263
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 95
byte 1 109
byte 1 101
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $262
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 95
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $173
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 100
byte 1 114
byte 1 111
byte 1 112
byte 1 112
byte 1 101
byte 1 100
byte 1 32
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 37
byte 1 105
byte 1 0

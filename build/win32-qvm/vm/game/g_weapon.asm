export CalcMuzzlePointOrigin
code
proc CalcMuzzlePointOrigin 4 0
file "..\..\..\..\code\game\g_weapon.c"
line 21
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// g_weapon.c 
;4:// perform the server side effects of a weapon firing
;5:
;6:#include "g_local.h"
;7:
;8:static	float	s_quadFactor;
;9:static	vec3_t	forward, right, up;
;10:static	vec3_t	muzzle;
;11:static	vec3_t	muzzle_origin; // for hitscan weapon trace
;12:
;13:#define NUM_NAILSHOTS 15
;14:
;15:
;16:/*
;17:===============
;18:CalcMuzzlePointOrigin
;19:===============
;20:*/
;21:void CalcMuzzlePointOrigin(const gentity_t *ent, vec3_t origin, const vec3_t forward, const vec3_t right, const vec3_t up, vec3_t muzzlePoint) {
line 22
;22:	VectorCopy(ent->client->ps.origin, origin);
ADDRFP4 4
INDIRP4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 23
;23:	origin[2] += ent->client->ps.viewheight;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 24
;24:	VectorMA(origin, 14.0, forward, muzzlePoint);
ADDRFP4 20
INDIRP4
ADDRFP4 4
INDIRP4
INDIRF4
ADDRFP4 8
INDIRP4
INDIRF4
CNSTF4 1096810496
MULF4
ADDF4
ASGNF4
ADDRFP4 20
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1096810496
MULF4
ADDF4
ASGNF4
ADDRFP4 20
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1096810496
MULF4
ADDF4
ASGNF4
line 27
;25:	// snap to integer coordinates for more efficient network bandwidth usage
;26:	//SnapVector( muzzlePoint );
;27:}
LABELV $54
endproc CalcMuzzlePointOrigin 4 0
export G_BounceProjectile
proc G_BounceProjectile 48 4
line 35
;28:
;29:
;30:/*
;31:================
;32:G_BounceProjectile
;33:================
;34:*/
;35:void G_BounceProjectile(vec3_t start, vec3_t impact, vec3_t dir, vec3_t endout) {
line 39
;36:	vec3_t v, newv;
;37:	float dot;
;38:
;39:	VectorSubtract(impact, start, v);
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
INDIRF4
ADDRLP4 32
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 40
;40:	dot = DotProduct(v, dir);
ADDRLP4 36
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 0
INDIRF4
ADDRLP4 36
INDIRP4
INDIRF4
MULF4
ADDRLP4 0+4
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 0+8
INDIRF4
ADDRLP4 36
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ASGNF4
line 41
;41:	VectorMA(v, -2 * dot, dir, newv);
ADDRLP4 40
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 0
INDIRF4
ADDRLP4 40
INDIRP4
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 3221225472
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 40
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 3221225472
MULF4
MULF4
ADDF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 0+8
INDIRF4
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 3221225472
MULF4
MULF4
ADDF4
ASGNF4
line 43
;42:
;43:	VectorNormalize(newv);
ADDRLP4 12
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 44
;44:	VectorMA(impact, 8192, newv, endout);
ADDRFP4 12
INDIRP4
ADDRFP4 4
INDIRP4
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 1174405120
MULF4
ADDF4
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 12+4
INDIRF4
CNSTF4 1174405120
MULF4
ADDF4
ASGNF4
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 12+8
INDIRF4
CNSTF4 1174405120
MULF4
ADDF4
ASGNF4
line 45
;45:}
LABELV $55
endproc G_BounceProjectile 48 4
export Weapon_Gauntlet
proc Weapon_Gauntlet 0 0
line 56
;46:
;47:
;48:/*
;49:======================================================================
;50:
;51:GAUNTLET
;52:
;53:======================================================================
;54:*/
;55:
;56:void Weapon_Gauntlet(gentity_t *ent) {
line 58
;57:
;58:}
LABELV $66
endproc Weapon_Gauntlet 0 0
export CheckGauntletAttack
proc CheckGauntletAttack 92 32
line 65
;59:
;60:/*
;61:===============
;62:CheckGauntletAttack
;63:===============
;64:*/
;65:qboolean CheckGauntletAttack(gentity_t *ent) {
line 73
;66:	trace_t		tr;
;67:	vec3_t		end;
;68:	gentity_t *tent;
;69:	gentity_t *traceEnt;
;70:	int			damage;
;71:
;72:	// set aiming directions
;73:	AngleVectors(ent->client->ps.viewangles, forward, right, up);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 75
;74:
;75:	CalcMuzzlePointOrigin(ent, muzzle_origin, forward, right, up, muzzle);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle_origin
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 CalcMuzzlePointOrigin
CALLV
pop
line 77
;76:
;77:	VectorMA(muzzle_origin, (32.0 + 14.0), forward, end);
ADDRLP4 60
ADDRGP4 muzzle_origin
INDIRF4
ADDRGP4 forward
INDIRF4
CNSTF4 1110966272
MULF4
ADDF4
ASGNF4
ADDRLP4 60+4
ADDRGP4 muzzle_origin+4
INDIRF4
ADDRGP4 forward+4
INDIRF4
CNSTF4 1110966272
MULF4
ADDF4
ASGNF4
ADDRLP4 60+8
ADDRGP4 muzzle_origin+8
INDIRF4
ADDRGP4 forward+8
INDIRF4
CNSTF4 1110966272
MULF4
ADDF4
ASGNF4
line 79
;78:
;79:	trap_Trace(&tr, muzzle_origin, NULL, NULL, end, ent->s.number, MASK_SHOT);
ADDRLP4 4
ARGP4
ADDRGP4 muzzle_origin
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 60
ARGP4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 80
;80:	if (tr.surfaceFlags & SURF_NOIMPACT) {
ADDRLP4 4+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $74
line 81
;81:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $67
JUMPV
LABELV $74
line 84
;82:	}
;83:
;84:	if (ent->client->noclip) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 648
ADDP4
INDIRI4
CNSTI4 0
EQI4 $77
line 85
;85:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $67
JUMPV
LABELV $77
line 88
;86:	}
;87:
;88:	traceEnt = &g_entities[tr.entityNum];
ADDRLP4 0
ADDRLP4 4+52
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 91
;89:
;90:	// send blood impact
;91:	if (traceEnt->takedamage && traceEnt->client) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $80
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $80
line 92
;92:		tent = G_TempEntity(tr.endpos, EV_MISSILE_HIT);
ADDRLP4 4+12
ARGP4
CNSTI4 50
ARGI4
ADDRLP4 84
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 72
ADDRLP4 84
INDIRP4
ASGNP4
line 93
;93:		tent->s.otherEntityNum = traceEnt->s.number;
ADDRLP4 72
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 94
;94:		tent->s.eventParm = DirToByte(tr.plane.normal);
ADDRLP4 4+24
ARGP4
ADDRLP4 88
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 72
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 88
INDIRI4
ASGNI4
line 95
;95:		tent->s.weapon = ent->s.weapon;
ADDRLP4 72
INDIRP4
CNSTI4 192
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
line 96
;96:	}
LABELV $80
line 98
;97:
;98:	if (!traceEnt->takedamage) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
NEI4 $84
line 99
;99:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $67
JUMPV
LABELV $84
line 102
;100:	}
;101:
;102:	if (ent->client->ps.powerups[PW_QUAD]) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
CNSTI4 0
EQI4 $86
line 103
;103:		G_AddEvent(ent, EV_POWERUP_QUAD, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 61
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 104
;104:		s_quadFactor = g_quadDamageFactor.value;
ADDRGP4 s_quadFactor
ADDRGP4 g_quadDamageFactor+8
INDIRF4
ASGNF4
line 105
;105:	} else {
ADDRGP4 $87
JUMPV
LABELV $86
line 106
;106:		s_quadFactor = 1.0;
ADDRGP4 s_quadFactor
CNSTF4 1065353216
ASGNF4
line 107
;107:	}
LABELV $87
line 109
;108:
;109:	if (ent->client->persistantPowerup && ent->client->persistantPowerup->item && ent->client->persistantPowerup->item->giTag == PW_DOUBLER) {
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $89
ADDRLP4 84
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $89
ADDRLP4 84
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 12
NEI4 $89
line 110
;110:		s_quadFactor *= 2;
ADDRLP4 88
ADDRGP4 s_quadFactor
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRF4
CNSTF4 1073741824
MULF4
ASGNF4
line 111
;111:	}
LABELV $89
line 113
;112:
;113:	damage = 50 * s_quadFactor;
ADDRLP4 76
ADDRGP4 s_quadFactor
INDIRF4
CNSTF4 1112014848
MULF4
CVFI4 4
ASGNI4
line 114
;114:	G_Damage(traceEnt, ent, ent, forward, tr.endpos, damage, 0, MOD_GAUNTLET);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4+12
ARGP4
ADDRLP4 76
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 116
;115:
;116:	return qtrue;
CNSTI4 1
RETI4
LABELV $67
endproc CheckGauntletAttack 92 32
export SnapVectorTowards
proc SnapVectorTowards 24 0
line 138
;117:}
;118:
;119:
;120:/*
;121:======================================================================
;122:
;123:MACHINEGUN
;124:
;125:======================================================================
;126:*/
;127:
;128:/*
;129:======================
;130:SnapVectorTowards
;131:
;132:Round a vector to integers for more efficient network
;133:transmission, but make sure that it rounds towards a given point
;134:rather than blindly truncating.  This prevents it from truncating
;135:into a wall.
;136:======================
;137:*/
;138:void SnapVectorTowards(vec3_t v, vec3_t to) {
line 141
;139:	int		i;
;140:
;141:	for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $93
line 142
;142:		if (v[i] < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $97
line 143
;143:			if (to[i] >= v[i])
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
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
LTF4 $99
line 144
;144:				v[i] = (int)v[i];
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRGP4 $98
JUMPV
LABELV $99
line 146
;145:			else
;146:				v[i] = (int)v[i] - 1;
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
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
SUBI4
CVIF4 4
ASGNF4
line 147
;147:		} else {
ADDRGP4 $98
JUMPV
LABELV $97
line 148
;148:			if (to[i] <= v[i])
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
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
GTF4 $101
line 149
;149:				v[i] = (int)v[i];
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRGP4 $102
JUMPV
LABELV $101
line 151
;150:			else
;151:				v[i] = (int)v[i] + 1;
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
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
ADDP4
INDIRF4
CVFI4 4
CNSTI4 1
ADDI4
CVIF4 4
ASGNF4
LABELV $102
line 152
;152:		}
LABELV $98
line 153
;153:	}
LABELV $94
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
LTI4 $93
line 154
;154:}
LABELV $92
endproc SnapVectorTowards 24 0
proc Bullet_Fire 160 32
line 161
;155:
;156:#define CHAINGUN_SPREAD		600
;157:#define MACHINEGUN_SPREAD	200
;158:#define	MACHINEGUN_DAMAGE	7
;159:#define	MACHINEGUN_TEAM_DAMAGE	5		// wimpier MG in teamplay
;160:
;161:static void Bullet_Fire(gentity_t *ent, float spread, int damage) {
line 171
;162:	trace_t		tr;
;163:	vec3_t		end;
;164:	vec3_t		impactpoint, bouncedir;
;165:	float		r;
;166:	float		u;
;167:	gentity_t *tent;
;168:	gentity_t *traceEnt;
;169:	int			i, passent;
;170:
;171:	damage *= s_quadFactor;
ADDRFP4 8
ADDRFP4 8
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 173
;172:
;173:	r = random() * M_PI * 2.0f;
ADDRLP4 116
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 84
ADDRLP4 116
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 961089901
MULF4
ASGNF4
line 174
;174:	u = sin(r) * crandom() * spread * 16;
ADDRLP4 84
INDIRF4
ARGF4
ADDRLP4 120
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 124
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 100
ADDRLP4 120
INDIRF4
ADDRLP4 124
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
MULF4
ADDRFP4 4
INDIRF4
MULF4
CNSTF4 1098907648
MULF4
ASGNF4
line 175
;175:	r = cos(r) * crandom() * spread * 16;
ADDRLP4 84
INDIRF4
ARGF4
ADDRLP4 128
ADDRGP4 cos
CALLF4
ASGNF4
ADDRLP4 132
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 84
ADDRLP4 128
INDIRF4
ADDRLP4 132
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
MULF4
ADDRFP4 4
INDIRF4
MULF4
CNSTF4 1098907648
MULF4
ASGNF4
line 177
;176:
;177:	VectorMA(muzzle_origin, (8192.0 * 16.0), forward, end);
ADDRLP4 64
ADDRGP4 muzzle_origin
INDIRF4
ADDRGP4 forward
INDIRF4
CNSTF4 1207959552
MULF4
ADDF4
ASGNF4
ADDRLP4 64+4
ADDRGP4 muzzle_origin+4
INDIRF4
ADDRGP4 forward+4
INDIRF4
CNSTF4 1207959552
MULF4
ADDF4
ASGNF4
ADDRLP4 64+8
ADDRGP4 muzzle_origin+8
INDIRF4
ADDRGP4 forward+8
INDIRF4
CNSTF4 1207959552
MULF4
ADDF4
ASGNF4
line 178
;178:	VectorMA(end, r, right, end);
ADDRLP4 64
ADDRLP4 64
INDIRF4
ADDRGP4 right
INDIRF4
ADDRLP4 84
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 64+4
INDIRF4
ADDRGP4 right+4
INDIRF4
ADDRLP4 84
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+8
ADDRLP4 64+8
INDIRF4
ADDRGP4 right+8
INDIRF4
ADDRLP4 84
INDIRF4
MULF4
ADDF4
ASGNF4
line 179
;179:	VectorMA(end, u, up, end);
ADDRLP4 64
ADDRLP4 64
INDIRF4
ADDRGP4 up
INDIRF4
ADDRLP4 100
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+4
ADDRLP4 64+4
INDIRF4
ADDRGP4 up+4
INDIRF4
ADDRLP4 100
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 64+8
ADDRLP4 64+8
INDIRF4
ADDRGP4 up+8
INDIRF4
ADDRLP4 100
INDIRF4
MULF4
ADDF4
ASGNF4
line 181
;180:
;181:	passent = ent->s.number;
ADDRLP4 80
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 182
;182:	for (i = 0; i < 10; i++) {
ADDRLP4 76
CNSTI4 0
ASGNI4
LABELV $122
line 185
;183:
;184:		// unlagged
;185:		G_DoTimeShiftFor(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_DoTimeShiftFor
CALLV
pop
line 187
;186:
;187:		trap_Trace(&tr, muzzle_origin, NULL, NULL, end, passent, MASK_SHOT);
ADDRLP4 4
ARGP4
ADDRGP4 muzzle_origin
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 64
ARGP4
ADDRLP4 80
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 190
;188:
;189:		// unlagged
;190:		G_UndoTimeShiftFor(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UndoTimeShiftFor
CALLV
pop
line 192
;191:
;192:		if (tr.surfaceFlags & SURF_NOIMPACT)
ADDRLP4 4+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $126
line 193
;193:			return;
ADDRGP4 $103
JUMPV
LABELV $126
line 195
;194:
;195:		traceEnt = &g_entities[tr.entityNum];
ADDRLP4 0
ADDRLP4 4+52
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 198
;196:
;197:		// snap the endpos to integers, but nudged towards the line
;198:		SnapVectorTowards(tr.endpos, muzzle_origin);
ADDRLP4 4+12
ARGP4
ADDRGP4 muzzle_origin
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 201
;199:
;200:		// send bullet impact
;201:		if (traceEnt->takedamage && traceEnt->client) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $131
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $131
line 202
;202:			tent = G_TempEntity(tr.endpos, EV_BULLET_HIT_FLESH);
ADDRLP4 4+12
ARGP4
CNSTI4 48
ARGI4
ADDRLP4 148
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 148
INDIRP4
ASGNP4
line 203
;203:			tent->s.eventParm = traceEnt->s.number;
ADDRLP4 60
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 206
;204:
;205:			// unlagged
;206:			tent->s.clientNum = ent->s.clientNum;
ADDRLP4 60
INDIRP4
CNSTI4 168
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 208
;207:
;208:			if (LogAccuracyHit(traceEnt, ent)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 152
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $132
line 209
;209:				ent->client->accuracy_hits++;
ADDRLP4 156
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 716
ADDP4
ASGNP4
ADDRLP4 156
INDIRP4
ADDRLP4 156
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 210
;210:			}
line 211
;211:		} else {
ADDRGP4 $132
JUMPV
LABELV $131
line 212
;212:			tent = G_TempEntity(tr.endpos, EV_BULLET_HIT_WALL);
ADDRLP4 4+12
ARGP4
CNSTI4 49
ARGI4
ADDRLP4 148
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 148
INDIRP4
ASGNP4
line 213
;213:			tent->s.eventParm = DirToByte(tr.plane.normal);
ADDRLP4 4+24
ARGP4
ADDRLP4 152
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 60
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 152
INDIRI4
ASGNI4
line 214
;214:		}
LABELV $132
line 215
;215:		tent->s.otherEntityNum = ent->s.number;
ADDRLP4 60
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 217
;216:
;217:		if (traceEnt->takedamage) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $124
line 218
;218:			if (traceEnt->client && traceEnt->client->invulnerabilityTime > level.time) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $140
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 844
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $140
line 219
;219:				if (G_InvulnerabilityEffect(traceEnt, forward, tr.endpos, impactpoint, bouncedir)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4+12
ARGP4
ADDRLP4 88
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 152
ADDRGP4 G_InvulnerabilityEffect
CALLI4
ASGNI4
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $143
line 220
;220:					G_BounceProjectile(muzzle, impactpoint, bouncedir, end);
ADDRGP4 muzzle
ARGP4
ADDRLP4 88
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 64
ARGP4
ADDRGP4 G_BounceProjectile
CALLV
pop
line 221
;221:					VectorCopy(impactpoint, muzzle);
ADDRGP4 muzzle
ADDRLP4 88
INDIRB
ASGNB 12
line 223
;222:					// the player can hit him/herself with the bounced rail
;223:					passent = ENTITYNUM_NONE;
ADDRLP4 80
CNSTI4 1023
ASGNI4
line 224
;224:				} else {
ADDRGP4 $123
JUMPV
LABELV $143
line 225
;225:					VectorCopy(tr.endpos, muzzle);
ADDRGP4 muzzle
ADDRLP4 4+12
INDIRB
ASGNB 12
line 226
;226:					passent = traceEnt->s.number;
ADDRLP4 80
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 227
;227:				}
line 228
;228:				continue;
ADDRGP4 $123
JUMPV
LABELV $140
line 229
;229:			} else {
line 230
;230:				G_Damage(traceEnt, ent, ent, forward, tr.endpos, damage, 0, MOD_MACHINEGUN);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRLP4 152
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4+12
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 231
;231:			}
line 232
;232:		}
line 233
;233:		break;
ADDRGP4 $124
JUMPV
LABELV $123
line 182
ADDRLP4 76
ADDRLP4 76
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 10
LTI4 $122
LABELV $124
line 235
;234:	}
;235:}
LABELV $103
endproc Bullet_Fire 160 32
export BFG_Fire
proc BFG_Fire 16 12
line 246
;236:
;237:
;238:/*
;239:======================================================================
;240:
;241:BFG
;242:
;243:======================================================================
;244:*/
;245:
;246:void BFG_Fire(gentity_t *ent) {
line 249
;247:	gentity_t *m;
;248:
;249:	m = fire_bfg(ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4
ADDRGP4 fire_bfg
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 250
;250:	m->damage *= s_quadFactor;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 251
;251:	m->splashDamage *= s_quadFactor;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 254
;252:
;253:	//	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;254:}
LABELV $148
endproc BFG_Fire 16 12
proc ShotgunPellet 132 28
line 269
;255:
;256:
;257:/*
;258:======================================================================
;259:
;260:SHOTGUN
;261:
;262:======================================================================
;263:*/
;264:
;265:// DEFAULT_SHOTGUN_SPREAD and DEFAULT_SHOTGUN_COUNT	are in bg_public.h, because
;266:// client predicts same spreads
;267:#define	DEFAULT_SHOTGUN_DAMAGE	10
;268:
;269:static qboolean ShotgunPellet(const vec3_t start, const vec3_t end, gentity_t *ent) {
line 275
;270:	trace_t		tr;
;271:	int			damage, i, passent;
;272:	gentity_t *traceEnt;
;273:	vec3_t		impactpoint, bouncedir;
;274:	vec3_t		tr_start, tr_end;
;275:	qboolean	hitClient = qfalse;
ADDRLP4 120
CNSTI4 0
ASGNI4
line 277
;276:
;277:	passent = ent->s.number;
ADDRLP4 76
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 278
;278:	VectorCopy(start, tr_start);
ADDRLP4 64
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 279
;279:	VectorCopy(end, tr_end);
ADDRLP4 80
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 281
;280:
;281:	for (i = 0; i < 10; i++) {
ADDRLP4 60
CNSTI4 0
ASGNI4
LABELV $150
line 282
;282:		trap_Trace(&tr, tr_start, NULL, NULL, tr_end, passent, MASK_SHOT);
ADDRLP4 0
ARGP4
ADDRLP4 64
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 80
ARGP4
ADDRLP4 76
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 283
;283:		traceEnt = &g_entities[tr.entityNum];
ADDRLP4 56
ADDRLP4 0+52
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 286
;284:
;285:		// send bullet impact
;286:		if (tr.surfaceFlags & SURF_NOIMPACT) {
ADDRLP4 0+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $155
line 287
;287:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $149
JUMPV
LABELV $155
line 290
;288:		}
;289:
;290:		if (traceEnt->takedamage) {
ADDRLP4 56
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $158
line 291
;291:			damage = DEFAULT_SHOTGUN_DAMAGE * s_quadFactor;
ADDRLP4 92
ADDRGP4 s_quadFactor
INDIRF4
CNSTF4 1092616192
MULF4
CVFI4 4
ASGNI4
line 292
;292:			if (traceEnt->client && traceEnt->client->invulnerabilityTime > level.time) {
ADDRLP4 56
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $160
ADDRLP4 56
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 844
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $160
line 293
;293:				if (G_InvulnerabilityEffect(traceEnt, forward, tr.endpos, impactpoint, bouncedir)) {
ADDRLP4 56
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 0+12
ARGP4
ADDRLP4 96
ARGP4
ADDRLP4 108
ARGP4
ADDRLP4 128
ADDRGP4 G_InvulnerabilityEffect
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
CNSTI4 0
EQI4 $163
line 294
;294:					G_BounceProjectile(tr_start, impactpoint, bouncedir, tr_end);
ADDRLP4 64
ARGP4
ADDRLP4 96
ARGP4
ADDRLP4 108
ARGP4
ADDRLP4 80
ARGP4
ADDRGP4 G_BounceProjectile
CALLV
pop
line 295
;295:					VectorCopy(impactpoint, tr_start);
ADDRLP4 64
ADDRLP4 96
INDIRB
ASGNB 12
line 297
;296:					// the player can hit him/herself with the bounced rail
;297:					passent = ENTITYNUM_NONE;
ADDRLP4 76
CNSTI4 1023
ASGNI4
line 298
;298:				} else {
ADDRGP4 $151
JUMPV
LABELV $163
line 299
;299:					VectorCopy(tr.endpos, tr_start);
ADDRLP4 64
ADDRLP4 0+12
INDIRB
ASGNB 12
line 300
;300:					passent = traceEnt->s.number;
ADDRLP4 76
ADDRLP4 56
INDIRP4
INDIRI4
ASGNI4
line 301
;301:				}
line 302
;302:				continue;
ADDRGP4 $151
JUMPV
LABELV $160
line 304
;303:			}
;304:		}
LABELV $158
line 305
;305:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $149
JUMPV
LABELV $151
line 281
ADDRLP4 60
ADDRLP4 60
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 10
LTI4 $150
line 307
;306:	}
;307:	return qfalse;
CNSTI4 0
RETI4
LABELV $149
endproc ShotgunPellet 132 28
proc ShotgunPattern 92 12
line 312
;308:}
;309:
;310:
;311:// this should match CG_ShotgunPattern
;312:static void ShotgunPattern(const vec3_t origin, const vec3_t origin2, int seed, gentity_t *ent) {
line 317
;313:	int			i;
;314:	float		r, u;
;315:	vec3_t		end;
;316:	vec3_t		forward, right, up;
;317:	qboolean	hitClient = qfalse;
ADDRLP4 60
CNSTI4 0
ASGNI4
line 321
;318:
;319:	// derive the right and up vectors from the forward vector, because
;320:	// the client won't have any other information
;321:	VectorNormalize2(origin2, forward);
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 VectorNormalize2
CALLF4
pop
line 322
;322:	PerpendicularVector(right, forward);
ADDRLP4 32
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 PerpendicularVector
CALLV
pop
line 323
;323:	CrossProduct(forward, right, up);
ADDRLP4 20
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRGP4 CrossProduct
CALLV
pop
line 326
;324:
;325:	// unlagged
;326:	G_DoTimeShiftFor(ent);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 G_DoTimeShiftFor
CALLV
pop
line 329
;327:
;328:	// generate the "random" spread pattern
;329:	for (i = 0; i < DEFAULT_SHOTGUN_COUNT; i++) {
ADDRLP4 56
CNSTI4 0
ASGNI4
LABELV $168
line 330
;330:		r = Q_crandom(&seed) * DEFAULT_SHOTGUN_SPREAD * 16;
ADDRFP4 8
ARGP4
ADDRLP4 64
ADDRGP4 Q_crandom
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 64
INDIRF4
CNSTF4 1177485312
MULF4
ASGNF4
line 331
;331:		u = Q_crandom(&seed) * DEFAULT_SHOTGUN_SPREAD * 16;
ADDRFP4 8
ARGP4
ADDRLP4 68
ADDRGP4 Q_crandom
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 68
INDIRF4
CNSTF4 1177485312
MULF4
ASGNF4
line 332
;332:		VectorMA(origin, (8192.0 * 16.0), forward, end);
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 72
INDIRP4
INDIRF4
ADDRLP4 20
INDIRF4
CNSTF4 1207959552
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 72
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 20+4
INDIRF4
CNSTF4 1207959552
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 20+8
INDIRF4
CNSTF4 1207959552
MULF4
ADDF4
ASGNF4
line 333
;333:		VectorMA(end, r, right, end);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 32
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 32+4
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 32+8
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 334
;334:		VectorMA(end, u, up, end);
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 44
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 44+4
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 44+8
INDIRF4
ADDRLP4 16
INDIRF4
MULF4
ADDF4
ASGNF4
line 335
;335:		if (ShotgunPellet(origin, end, ent) && !hitClient) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 ShotgunPellet
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $188
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $188
line 336
;336:			hitClient = qtrue;
ADDRLP4 60
CNSTI4 1
ASGNI4
line 337
;337:			ent->client->accuracy_hits++;
ADDRLP4 88
ADDRFP4 12
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 716
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 338
;338:		}
LABELV $188
line 339
;339:	}
LABELV $169
line 329
ADDRLP4 56
ADDRLP4 56
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 11
LTI4 $168
line 342
;340:
;341:	// unlagged
;342:	G_UndoTimeShiftFor(ent);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 G_UndoTimeShiftFor
CALLV
pop
line 343
;343:}
LABELV $167
endproc ShotgunPattern 92 12
proc weapon_supershotgun_fire 20 16
line 346
;344:
;345:
;346:static void weapon_supershotgun_fire(gentity_t *ent) {
line 350
;347:	gentity_t *tent;
;348:
;349:	// send shotgun blast
;350:	tent = G_TempEntity(muzzle, EV_SHOTGUN);
ADDRGP4 muzzle
ARGP4
CNSTI4 54
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 351
;351:	VectorScale(forward, 4096.0, tent->s.origin2);
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRGP4 forward
INDIRF4
CNSTF4 1166016512
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
ADDRGP4 forward+4
INDIRF4
CNSTF4 1166016512
MULF4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRGP4 forward+8
INDIRF4
CNSTF4 1166016512
MULF4
ASGNF4
line 353
;352:
;353:	SnapVector(tent->s.origin2);
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 108
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 354
;354:	tent->s.eventParm = rand() & 255;		// seed for spread pattern
ADDRLP4 8
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 355
;355:	tent->s.otherEntityNum = ent->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 357
;356:
;357:	ShotgunPattern(muzzle_origin, tent->s.origin2, tent->s.eventParm, ent);
ADDRGP4 muzzle_origin
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 104
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 ShotgunPattern
CALLV
pop
line 358
;358:}
LABELV $190
endproc weapon_supershotgun_fire 20 16
export weapon_grenadelauncher_fire
proc weapon_grenadelauncher_fire 20 12
line 369
;359:
;360:
;361:/*
;362:======================================================================
;363:
;364:GRENADE LAUNCHER
;365:
;366:======================================================================
;367:*/
;368:
;369:void weapon_grenadelauncher_fire(gentity_t *ent) {
line 373
;370:	gentity_t *m;
;371:
;372:	// extra vertical velocity
;373:	forward[2] += 0.2f;
ADDRLP4 4
ADDRGP4 forward+8
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 374
;374:	VectorNormalize(forward);
ADDRGP4 forward
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 376
;375:
;376:	m = fire_grenade(ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 8
ADDRGP4 fire_grenade
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 377
;377:	m->damage *= s_quadFactor;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 378
;378:	m->splashDamage *= s_quadFactor;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 381
;379:
;380:	//	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;381:}
LABELV $193
endproc weapon_grenadelauncher_fire 20 12
export Weapon_RocketLauncher_Fire
proc Weapon_RocketLauncher_Fire 16 12
line 391
;382:
;383:/*
;384:======================================================================
;385:
;386:ROCKET
;387:
;388:======================================================================
;389:*/
;390:
;391:void Weapon_RocketLauncher_Fire(gentity_t *ent) {
line 394
;392:	gentity_t *m;
;393:
;394:	m = fire_rocket(ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4
ADDRGP4 fire_rocket
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 395
;395:	m->damage *= s_quadFactor;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 396
;396:	m->splashDamage *= s_quadFactor;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 399
;397:
;398:	//	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;399:}
LABELV $195
endproc Weapon_RocketLauncher_Fire 16 12
export Weapon_Plasmagun_Fire
proc Weapon_Plasmagun_Fire 16 12
line 410
;400:
;401:
;402:/*
;403:======================================================================
;404:
;405:PLASMA GUN
;406:
;407:======================================================================
;408:*/
;409:
;410:void Weapon_Plasmagun_Fire(gentity_t *ent) {
line 413
;411:	gentity_t *m;
;412:
;413:	m = fire_plasma(ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4
ADDRGP4 fire_plasma
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 414
;414:	m->damage *= s_quadFactor;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 415
;415:	m->splashDamage *= s_quadFactor;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 418
;416:
;417:	//	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;418:}
LABELV $196
endproc Weapon_Plasmagun_Fire 16 12
export weapon_railgun_fire
proc weapon_railgun_fire 184 28
line 435
;419:
;420:/*
;421:======================================================================
;422:
;423:RAILGUN
;424:
;425:======================================================================
;426:*/
;427:
;428:
;429:/*
;430:=================
;431:weapon_railgun_fire
;432:=================
;433:*/
;434:#define	MAX_RAIL_HITS	4
;435:void weapon_railgun_fire(gentity_t *ent) {
line 448
;436:	vec3_t		end;
;437:	vec3_t		impactpoint, bouncedir;
;438:	trace_t		trace;
;439:	gentity_t *tent;
;440:	gentity_t *traceEnt;
;441:	int			damage;
;442:	int			i;
;443:	int			hits;
;444:	int			unlinked;
;445:	int			passent;
;446:	gentity_t *unlinkedEntities[MAX_RAIL_HITS];
;447:
;448:	damage = 100 * s_quadFactor;
ADDRLP4 132
ADDRGP4 s_quadFactor
INDIRF4
CNSTF4 1120403456
MULF4
CVFI4 4
ASGNI4
line 450
;449:
;450:	VectorMA(muzzle_origin, 8192.0, forward, end);
ADDRLP4 88
ADDRGP4 muzzle_origin
INDIRF4
ADDRGP4 forward
INDIRF4
CNSTF4 1174405120
MULF4
ADDF4
ASGNF4
ADDRLP4 88+4
ADDRGP4 muzzle_origin+4
INDIRF4
ADDRGP4 forward+4
INDIRF4
CNSTF4 1174405120
MULF4
ADDF4
ASGNF4
ADDRLP4 88+8
ADDRGP4 muzzle_origin+8
INDIRF4
ADDRGP4 forward+8
INDIRF4
CNSTF4 1174405120
MULF4
ADDF4
ASGNF4
line 453
;451:
;452:	// unlagged
;453:	G_DoTimeShiftFor(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_DoTimeShiftFor
CALLV
pop
line 456
;454:
;455:	// trace only against the solids, so the railgun will go through people
;456:	unlinked = 0;
ADDRLP4 64
CNSTI4 0
ASGNI4
line 457
;457:	hits = 0;
ADDRLP4 128
CNSTI4 0
ASGNI4
line 458
;458:	passent = ent->s.number;
ADDRLP4 100
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
LABELV $204
line 459
;459:	do {
line 460
;460:		trap_Trace(&trace, muzzle_origin, NULL, NULL, end, passent, MASK_SHOT);
ADDRLP4 4
ARGP4
ADDRGP4 muzzle_origin
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 88
ARGP4
ADDRLP4 100
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 461
;461:		if (trace.entityNum >= ENTITYNUM_MAX_NORMAL) {
ADDRLP4 4+52
INDIRI4
CNSTI4 1022
LTI4 $207
line 462
;462:			break;
ADDRGP4 $206
JUMPV
LABELV $207
line 464
;463:		}
;464:		traceEnt = &g_entities[trace.entityNum];
ADDRLP4 0
ADDRLP4 4+52
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 465
;465:		if (traceEnt->takedamage) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $211
line 466
;466:			if (traceEnt->client && traceEnt->client->invulnerabilityTime > level.time) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $213
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 844
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $213
line 467
;467:				if (G_InvulnerabilityEffect(traceEnt, forward, trace.endpos, impactpoint, bouncedir)) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 4+12
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 116
ARGP4
ADDRLP4 140
ADDRGP4 G_InvulnerabilityEffect
CALLI4
ASGNI4
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $216
line 468
;468:					G_BounceProjectile(muzzle, impactpoint, bouncedir, end);
ADDRGP4 muzzle
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 116
ARGP4
ADDRLP4 88
ARGP4
ADDRGP4 G_BounceProjectile
CALLV
pop
line 470
;469:					// snap the endpos to integers to save net bandwidth, but nudged towards the line
;470:					SnapVectorTowards(trace.endpos, muzzle);
ADDRLP4 4+12
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 472
;471:					// send railgun beam effect
;472:					tent = G_TempEntity(trace.endpos, EV_RAILTRAIL);
ADDRLP4 4+12
ARGP4
CNSTI4 53
ARGI4
ADDRLP4 144
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 144
INDIRP4
ASGNP4
line 474
;473:					// set player number for custom colors on the railtrail
;474:					tent->s.clientNum = ent->s.clientNum;
ADDRLP4 60
INDIRP4
CNSTI4 168
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 475
;475:					VectorCopy(muzzle, tent->s.origin2);
ADDRLP4 60
INDIRP4
CNSTI4 104
ADDP4
ADDRGP4 muzzle
INDIRB
ASGNB 12
line 477
;476:					// move origin a bit to come closer to the drawn gun muzzle
;477:					VectorMA(tent->s.origin2, 4, right, tent->s.origin2);
ADDRLP4 60
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
ADDRGP4 right
INDIRF4
CNSTF4 1082130432
MULF4
ADDF4
ASGNF4
ADDRLP4 60
INDIRP4
CNSTI4 108
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 108
ADDP4
INDIRF4
ADDRGP4 right+4
INDIRF4
CNSTF4 1082130432
MULF4
ADDF4
ASGNF4
ADDRLP4 60
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
ADDRGP4 right+8
INDIRF4
CNSTF4 1082130432
MULF4
ADDF4
ASGNF4
line 478
;478:					VectorMA(tent->s.origin2, -1, up, tent->s.origin2);
ADDRLP4 60
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
ADDRGP4 up
INDIRF4
CNSTF4 3212836864
MULF4
ADDF4
ASGNF4
ADDRLP4 60
INDIRP4
CNSTI4 108
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 108
ADDP4
INDIRF4
ADDRGP4 up+4
INDIRF4
CNSTF4 3212836864
MULF4
ADDF4
ASGNF4
ADDRLP4 60
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
ADDRGP4 up+8
INDIRF4
CNSTF4 3212836864
MULF4
ADDF4
ASGNF4
line 479
;479:					tent->s.eventParm = 255;	// don't make the explosion at the end
ADDRLP4 60
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 255
ASGNI4
line 481
;480:					//
;481:					VectorCopy(impactpoint, muzzle);
ADDRGP4 muzzle
ADDRLP4 104
INDIRB
ASGNB 12
line 483
;482:					// the player can hit him/herself with the bounced rail
;483:					passent = ENTITYNUM_NONE;
ADDRLP4 100
CNSTI4 1023
ASGNI4
line 484
;484:				}
LABELV $216
line 485
;485:			}
LABELV $213
line 486
;486:		}
LABELV $211
line 487
;487:		if (trace.contents & CONTENTS_SOLID) {
ADDRLP4 4+48
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $225
line 488
;488:			break;		// we hit something solid enough to stop the beam
ADDRGP4 $206
JUMPV
LABELV $225
line 491
;489:		}
;490:		// unlink this entity, so the next trace will go past it
;491:		trap_UnlinkEntity(traceEnt);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 492
;492:		unlinkedEntities[unlinked] = traceEnt;
ADDRLP4 64
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 72
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 493
;493:		unlinked++;
ADDRLP4 64
ADDRLP4 64
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 494
;494:	} while (unlinked < MAX_RAIL_HITS);
LABELV $205
ADDRLP4 64
INDIRI4
CNSTI4 4
LTI4 $204
LABELV $206
line 497
;495:
;496:	// unlagged
;497:	G_UndoTimeShiftFor(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UndoTimeShiftFor
CALLV
pop
line 501
;498:
;499:
;500:	// link back in any entities we unlinked
;501:	for (i = 0; i < unlinked; i++) {
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRGP4 $231
JUMPV
LABELV $228
line 502
;502:		trap_LinkEntity(unlinkedEntities[i]);
ADDRLP4 68
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 72
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 503
;503:	}
LABELV $229
line 501
ADDRLP4 68
ADDRLP4 68
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $231
ADDRLP4 68
INDIRI4
ADDRLP4 64
INDIRI4
LTI4 $228
line 508
;504:
;505:	// the final trace endpos will be the terminal point of the rail trail
;506:
;507:	// snap the endpos to integers to save net bandwidth, but nudged towards the line
;508:	SnapVectorTowards(trace.endpos, muzzle_origin);
ADDRLP4 4+12
ARGP4
ADDRGP4 muzzle_origin
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 511
;509:
;510:	// send railgun beam effect
;511:	tent = G_TempEntity(trace.endpos, EV_RAILTRAIL);
ADDRLP4 4+12
ARGP4
CNSTI4 53
ARGI4
ADDRLP4 136
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 60
ADDRLP4 136
INDIRP4
ASGNP4
line 514
;512:
;513:	// set player number for custom colors on the railtrail
;514:	tent->s.clientNum = ent->s.clientNum;
ADDRLP4 60
INDIRP4
CNSTI4 168
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 516
;515:
;516:	VectorCopy(muzzle, tent->s.origin2);
ADDRLP4 60
INDIRP4
CNSTI4 104
ADDP4
ADDRGP4 muzzle
INDIRB
ASGNB 12
line 518
;517:	// move origin a bit to come closer to the drawn gun muzzle
;518:	VectorMA(tent->s.origin2, 4, right, tent->s.origin2);
ADDRLP4 60
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
ADDRGP4 right
INDIRF4
CNSTF4 1082130432
MULF4
ADDF4
ASGNF4
ADDRLP4 60
INDIRP4
CNSTI4 108
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 108
ADDP4
INDIRF4
ADDRGP4 right+4
INDIRF4
CNSTF4 1082130432
MULF4
ADDF4
ASGNF4
ADDRLP4 60
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
ADDRGP4 right+8
INDIRF4
CNSTF4 1082130432
MULF4
ADDF4
ASGNF4
line 519
;519:	VectorMA(tent->s.origin2, -1, up, tent->s.origin2);
ADDRLP4 60
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
ADDRGP4 up
INDIRF4
CNSTF4 3212836864
MULF4
ADDF4
ASGNF4
ADDRLP4 60
INDIRP4
CNSTI4 108
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 108
ADDP4
INDIRF4
ADDRGP4 up+4
INDIRF4
CNSTF4 3212836864
MULF4
ADDF4
ASGNF4
ADDRLP4 60
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
ADDRGP4 up+8
INDIRF4
CNSTF4 3212836864
MULF4
ADDF4
ASGNF4
line 521
;520:
;521:	SnapVector(tent->s.origin2);
ADDRLP4 60
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 104
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 60
INDIRP4
CNSTI4 108
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 108
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 60
INDIRP4
CNSTI4 112
ADDP4
ADDRLP4 60
INDIRP4
CNSTI4 112
ADDP4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 524
;522:
;523:	// no explosion at end if SURF_NOIMPACT, but still make the trail
;524:	if (trace.surfaceFlags & SURF_NOIMPACT) {
ADDRLP4 4+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $238
line 525
;525:		tent->s.eventParm = 255;	// don't make the explosion at the end
ADDRLP4 60
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 255
ASGNI4
line 526
;526:	} else {
ADDRGP4 $239
JUMPV
LABELV $238
line 527
;527:		tent->s.eventParm = DirToByte(trace.plane.normal);
ADDRLP4 4+24
ARGP4
ADDRLP4 164
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 60
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 164
INDIRI4
ASGNI4
line 528
;528:	}
LABELV $239
line 529
;529:	tent->s.clientNum = ent->s.clientNum;
ADDRLP4 60
INDIRP4
CNSTI4 168
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
line 532
;530:
;531:	// give the shooter a reward sound if they have made two railgun hits in a row
;532:	if (hits == 0) {
ADDRLP4 128
INDIRI4
CNSTI4 0
NEI4 $242
line 534
;533:		// complete miss
;534:		ent->client->accurateCount = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 708
ADDP4
CNSTI4 0
ASGNI4
line 535
;535:	} else {
ADDRGP4 $243
JUMPV
LABELV $242
line 537
;536:		// check for "impressive" reward sound
;537:		ent->client->accurateCount += hits;
ADDRLP4 164
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 708
ADDP4
ASGNP4
ADDRLP4 164
INDIRP4
ADDRLP4 164
INDIRP4
INDIRI4
ADDRLP4 128
INDIRI4
ADDI4
ASGNI4
line 538
;538:		if (ent->client->accurateCount >= 2) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 708
ADDP4
INDIRI4
CNSTI4 2
LTI4 $244
line 539
;539:			ent->client->accurateCount -= 2;
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 708
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 540
;540:			ent->client->ps.persistant[PERS_IMPRESSIVE_COUNT]++;
ADDRLP4 172
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 284
ADDP4
ASGNP4
ADDRLP4 172
INDIRP4
ADDRLP4 172
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 542
;541:			// add the sprite over the player's head
;542:			ent->client->ps.eFlags &= ~EF_AWARDS;
ADDRLP4 176
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 176
INDIRP4
ADDRLP4 176
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 543
;543:			ent->client->ps.eFlags |= EF_AWARD_IMPRESSIVE;
ADDRLP4 180
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 180
INDIRP4
ADDRLP4 180
INDIRP4
INDIRI4
CNSTI4 32768
BORI4
ASGNI4
line 544
;544:			ent->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 748
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 545
;545:		}
LABELV $244
line 546
;546:		ent->client->accuracy_hits++;
ADDRLP4 168
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 716
ADDP4
ASGNP4
ADDRLP4 168
INDIRP4
ADDRLP4 168
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 547
;547:	}
LABELV $243
line 549
;548:
;549:}
LABELV $197
endproc weapon_railgun_fire 184 28
export Weapon_GrapplingHook_Fire
proc Weapon_GrapplingHook_Fire 4 12
line 560
;550:
;551:
;552:/*
;553:======================================================================
;554:
;555:GRAPPLING HOOK
;556:
;557:======================================================================
;558:*/
;559:
;560:void Weapon_GrapplingHook_Fire(gentity_t *ent) {
line 561
;561:	if (!ent->client->fireHeld && !ent->client->hook)
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
NEI4 $248
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 764
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $248
line 562
;562:		fire_grapple(ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 fire_grapple
CALLP4
pop
LABELV $248
line 564
;563:
;564:	ent->client->fireHeld = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 1
ASGNI4
line 565
;565:}
LABELV $247
endproc Weapon_GrapplingHook_Fire 4 12
export Weapon_HookFree
proc Weapon_HookFree 4 4
line 568
;566:
;567:
;568:void Weapon_HookFree(gentity_t *ent) {
line 569
;569:	ent->parent->client->hook = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 764
ADDP4
CNSTP4 0
ASGNP4
line 570
;570:	ent->parent->client->ps.pm_flags &= ~PMF_GRAPPLE_PULL;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 571
;571:	G_FreeEntity(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 572
;572:}
LABELV $250
endproc Weapon_HookFree 4 4
export Weapon_HookThink
proc Weapon_HookThink 36 8
line 575
;573:
;574:
;575:void Weapon_HookThink(gentity_t *ent) {
line 576
;576:	if (ent->enemy) {
ADDRFP4 0
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $252
line 579
;577:		vec3_t v, oldorigin;
;578:
;579:		VectorCopy(ent->r.currentOrigin, oldorigin);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 580
;580:		v[0] = ent->enemy->r.currentOrigin[0] + (ent->enemy->r.mins[0] + ent->enemy->r.maxs[0]) * 0.5;
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 24
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CNSTI4 436
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CNSTI4 448
ADDP4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
line 581
;581:		v[1] = ent->enemy->r.currentOrigin[1] + (ent->enemy->r.mins[1] + ent->enemy->r.maxs[1]) * 0.5;
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+4
ADDRLP4 28
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CNSTI4 440
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
line 582
;582:		v[2] = ent->enemy->r.currentOrigin[2] + (ent->enemy->r.mins[2] + ent->enemy->r.maxs[2]) * 0.5;
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 32
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CNSTI4 444
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 768
ADDP4
INDIRP4
CNSTI4 456
ADDP4
INDIRF4
ADDF4
CNSTF4 1056964608
MULF4
ADDF4
ASGNF4
line 583
;583:		SnapVectorTowards(v, oldorigin);	// save net bandwidth
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 SnapVectorTowards
CALLV
pop
line 585
;584:
;585:		G_SetOrigin(ent, v);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 586
;586:	}
LABELV $252
line 588
;587:
;588:	VectorCopy(ent->r.currentOrigin, ent->parent->client->ps.grapplePoint);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 92
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 488
ADDP4
INDIRB
ASGNB 12
line 589
;589:}
LABELV $251
endproc Weapon_HookThink 36 8
export Weapon_LightningFire
proc Weapon_LightningFire 124 28
line 600
;590:
;591:
;592:/*
;593:======================================================================
;594:
;595:LIGHTNING GUN
;596:
;597:======================================================================
;598:*/
;599:
;600:void Weapon_LightningFire(gentity_t *ent) {
line 607
;601:	trace_t		tr;
;602:	vec3_t		end;
;603:	vec3_t		impactpoint, bouncedir;
;604:	gentity_t *traceEnt, *tent;
;605:	int			damage, i, passent;
;606:
;607:	damage = 8 * s_quadFactor;
ADDRLP4 108
ADDRGP4 s_quadFactor
INDIRF4
CNSTF4 1090519040
MULF4
CVFI4 4
ASGNI4
line 609
;608:
;609:	passent = ent->s.number;
ADDRLP4 80
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 611
;610:
;611:	for (i = 0; i < 10; i++) {
ADDRLP4 76
CNSTI4 0
ASGNI4
LABELV $257
line 612
;612:		VectorMA(muzzle_origin, LIGHTNING_RANGE, forward, end);
ADDRLP4 0
ADDRGP4 muzzle_origin
INDIRF4
ADDRGP4 forward
INDIRF4
CNSTF4 1145044992
MULF4
ADDF4
ASGNF4
ADDRLP4 0+4
ADDRGP4 muzzle_origin+4
INDIRF4
ADDRGP4 forward+4
INDIRF4
CNSTF4 1145044992
MULF4
ADDF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 muzzle_origin+8
INDIRF4
ADDRGP4 forward+8
INDIRF4
CNSTF4 1145044992
MULF4
ADDF4
ASGNF4
line 615
;613:
;614:		// unlagged
;615:		G_DoTimeShiftFor(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_DoTimeShiftFor
CALLV
pop
line 617
;616:
;617:		trap_Trace(&tr, muzzle_origin, NULL, NULL, end, passent, MASK_SHOT);
ADDRLP4 12
ARGP4
ADDRGP4 muzzle_origin
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 80
INDIRI4
ARGI4
CNSTI4 100663297
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 620
;618:
;619:		// unlagged
;620:		G_UndoTimeShiftFor(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UndoTimeShiftFor
CALLV
pop
line 623
;621:
;622:		// if not the first trace (the lightning bounced of an invulnerability sphere)
;623:		if (i) {
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $267
line 627
;624:			// add bounced off lightning bolt temp entity
;625:			// the first lightning bolt is a cgame only visual
;626:			//
;627:			tent = G_TempEntity(muzzle, EV_LIGHTNINGBOLT);
ADDRGP4 muzzle
ARGP4
CNSTI4 73
ARGI4
ADDRLP4 112
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 72
ADDRLP4 112
INDIRP4
ASGNP4
line 628
;628:			VectorCopy(tr.endpos, end);
ADDRLP4 0
ADDRLP4 12+12
INDIRB
ASGNB 12
line 629
;629:			SnapVector(end);
ADDRLP4 0
ADDRLP4 0
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 630
;630:			VectorCopy(end, tent->s.origin2);
ADDRLP4 72
INDIRP4
CNSTI4 104
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 631
;631:		}
LABELV $267
line 632
;632:		if (tr.entityNum == ENTITYNUM_NONE) {
ADDRLP4 12+52
INDIRI4
CNSTI4 1023
NEI4 $274
line 633
;633:			return;
ADDRGP4 $256
JUMPV
LABELV $274
line 636
;634:		}
;635:
;636:		traceEnt = &g_entities[tr.entityNum];
ADDRLP4 68
ADDRLP4 12+52
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 638
;637:
;638:		if (traceEnt->takedamage) {
ADDRLP4 68
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $278
line 639
;639:			if (traceEnt->client && traceEnt->client->invulnerabilityTime > level.time) {
ADDRLP4 68
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $280
ADDRLP4 68
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 844
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $280
line 640
;640:				if (G_InvulnerabilityEffect(traceEnt, forward, tr.endpos, impactpoint, bouncedir)) {
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 12+12
ARGP4
ADDRLP4 84
ARGP4
ADDRLP4 96
ARGP4
ADDRLP4 116
ADDRGP4 G_InvulnerabilityEffect
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
EQI4 $283
line 641
;641:					G_BounceProjectile(muzzle, impactpoint, bouncedir, end);
ADDRGP4 muzzle
ARGP4
ADDRLP4 84
ARGP4
ADDRLP4 96
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 G_BounceProjectile
CALLV
pop
line 642
;642:					VectorCopy(impactpoint, muzzle);
ADDRGP4 muzzle
ADDRLP4 84
INDIRB
ASGNB 12
line 643
;643:					VectorSubtract(end, impactpoint, forward);
ADDRGP4 forward
ADDRLP4 0
INDIRF4
ADDRLP4 84
INDIRF4
SUBF4
ASGNF4
ADDRGP4 forward+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 84+4
INDIRF4
SUBF4
ASGNF4
ADDRGP4 forward+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 84+8
INDIRF4
SUBF4
ASGNF4
line 644
;644:					VectorNormalize(forward);
ADDRGP4 forward
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 646
;645:					// the player can hit him/herself with the bounced lightning
;646:					passent = ENTITYNUM_NONE;
ADDRLP4 80
CNSTI4 1023
ASGNI4
line 647
;647:				} else {
ADDRGP4 $258
JUMPV
LABELV $283
line 648
;648:					VectorCopy(tr.endpos, muzzle);
ADDRGP4 muzzle
ADDRLP4 12+12
INDIRB
ASGNB 12
line 649
;649:					passent = traceEnt->s.number;
ADDRLP4 80
ADDRLP4 68
INDIRP4
INDIRI4
ASGNI4
line 650
;650:				}
line 651
;651:				continue;
ADDRGP4 $258
JUMPV
LABELV $280
line 653
;652:			}
;653:		}
LABELV $278
line 655
;654:
;655:		if (traceEnt->takedamage && traceEnt->client) {
ADDRLP4 68
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $293
ADDRLP4 68
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $293
line 656
;656:			tent = G_TempEntity(tr.endpos, EV_MISSILE_HIT);
ADDRLP4 12+12
ARGP4
CNSTI4 50
ARGI4
ADDRLP4 116
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 72
ADDRLP4 116
INDIRP4
ASGNP4
line 657
;657:			tent->s.otherEntityNum = traceEnt->s.number;
ADDRLP4 72
INDIRP4
CNSTI4 140
ADDP4
ADDRLP4 68
INDIRP4
INDIRI4
ASGNI4
line 658
;658:			tent->s.eventParm = DirToByte(tr.plane.normal);
ADDRLP4 12+24
ARGP4
ADDRLP4 120
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 72
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 120
INDIRI4
ASGNI4
line 659
;659:			tent->s.weapon = ent->s.weapon;
ADDRLP4 72
INDIRP4
CNSTI4 192
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
line 660
;660:		} else if (!(tr.surfaceFlags & SURF_NOIMPACT)) {
ADDRGP4 $259
JUMPV
LABELV $293
ADDRLP4 12+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $259
line 661
;661:			tent = G_TempEntity(tr.endpos, EV_MISSILE_MISS);
ADDRLP4 12+12
ARGP4
CNSTI4 51
ARGI4
ADDRLP4 116
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 72
ADDRLP4 116
INDIRP4
ASGNP4
line 662
;662:			tent->s.eventParm = DirToByte(tr.plane.normal);
ADDRLP4 12+24
ARGP4
ADDRLP4 120
ADDRGP4 DirToByte
CALLI4
ASGNI4
ADDRLP4 72
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 120
INDIRI4
ASGNI4
line 663
;663:		}
line 665
;664:
;665:		break;
ADDRGP4 $259
JUMPV
LABELV $258
line 611
ADDRLP4 76
ADDRLP4 76
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 10
LTI4 $257
LABELV $259
line 667
;666:	}
;667:}
LABELV $256
endproc Weapon_LightningFire 124 28
export Weapon_Nailgun_Fire
proc Weapon_Nailgun_Fire 20 20
line 678
;668:
;669:
;670:/*
;671:======================================================================
;672:
;673:NAILGUN
;674:
;675:======================================================================
;676:*/
;677:
;678:void Weapon_Nailgun_Fire(gentity_t *ent) {
line 682
;679:	gentity_t *m;
;680:	int			count;
;681:
;682:	for (count = 0; count < NUM_NAILSHOTS; count++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $303
line 683
;683:		m = fire_nail(ent, muzzle, forward, right, up);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRLP4 8
ADDRGP4 fire_nail
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 684
;684:		m->damage *= s_quadFactor;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 685
;685:		m->splashDamage *= s_quadFactor;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 686
;686:	}
LABELV $304
line 682
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 15
LTI4 $303
line 689
;687:
;688:	//	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;689:}
LABELV $302
endproc Weapon_Nailgun_Fire 20 20
export weapon_proxlauncher_fire
proc weapon_proxlauncher_fire 20 12
line 700
;690:
;691:
;692:/*
;693:======================================================================
;694:
;695:PROXIMITY MINE LAUNCHER
;696:
;697:======================================================================
;698:*/
;699:
;700:void weapon_proxlauncher_fire(gentity_t *ent) {
line 704
;701:	gentity_t *m;
;702:
;703:	// extra vertical velocity
;704:	forward[2] += 0.2f;
ADDRLP4 4
ADDRGP4 forward+8
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1045220557
ADDF4
ASGNF4
line 705
;705:	VectorNormalize(forward);
ADDRGP4 forward
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 707
;706:
;707:	m = fire_prox(ent, muzzle, forward);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 forward
ARGP4
ADDRLP4 8
ADDRGP4 fire_prox
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 708
;708:	m->damage *= s_quadFactor;
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 740
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 709
;709:	m->splashDamage *= s_quadFactor;
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 744
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 712
;710:
;711:	//	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;712:}
LABELV $307
endproc weapon_proxlauncher_fire 20 12
export LogAccuracyHit
proc LogAccuracyHit 4 8
line 722
;713:
;714://======================================================================
;715:
;716:
;717:/*
;718:===============
;719:LogAccuracyHit
;720:===============
;721:*/
;722:qboolean LogAccuracyHit(gentity_t *target, gentity_t *attacker) {
line 723
;723:	if (!target->takedamage) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
NEI4 $310
line 724
;724:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $309
JUMPV
LABELV $310
line 727
;725:	}
;726:
;727:	if (target == attacker) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CVPU4 4
NEU4 $312
line 728
;728:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $309
JUMPV
LABELV $312
line 731
;729:	}
;730:
;731:	if (!target->client) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $314
line 732
;732:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $309
JUMPV
LABELV $314
line 735
;733:	}
;734:
;735:	if (!attacker->client) {
ADDRFP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $316
line 736
;736:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $309
JUMPV
LABELV $316
line 739
;737:	}
;738:
;739:	if (target->client->ps.stats[STAT_HEALTH] <= 0) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $318
line 740
;740:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $309
JUMPV
LABELV $318
line 743
;741:	}
;742:
;743:	if (OnSameTeam(target, attacker)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $320
line 744
;744:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $309
JUMPV
LABELV $320
line 747
;745:	}
;746:
;747:	return qtrue;
CNSTI4 1
RETI4
LABELV $309
endproc LogAccuracyHit 4 8
export FireWeapon
proc FireWeapon 16 24
line 756
;748:}
;749:
;750:
;751:/*
;752:===============
;753:FireWeapon
;754:===============
;755:*/
;756:void FireWeapon(gentity_t *ent) {
line 757
;757:	if (ent->client->ps.powerups[PW_QUAD]) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
CNSTI4 0
EQI4 $323
line 758
;758:		s_quadFactor = g_quadDamageFactor.value;
ADDRGP4 s_quadFactor
ADDRGP4 g_quadDamageFactor+8
INDIRF4
ASGNF4
line 759
;759:	} else {
ADDRGP4 $324
JUMPV
LABELV $323
line 760
;760:		s_quadFactor = 1.0;
ADDRGP4 s_quadFactor
CNSTF4 1065353216
ASGNF4
line 761
;761:	}
LABELV $324
line 762
;762:	if (ent->client->persistantPowerup && ent->client->persistantPowerup->item && ent->client->persistantPowerup->item->giTag == PW_DOUBLER) {
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $326
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $326
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
CNSTI4 812
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 12
NEI4 $326
line 763
;763:		s_quadFactor *= 2;
ADDRLP4 4
ADDRGP4 s_quadFactor
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
CNSTF4 1073741824
MULF4
ASGNF4
line 764
;764:	}
LABELV $326
line 767
;765:
;766:	// track shots taken for accuracy tracking.  Grapple is not a weapon and gauntet is just not tracked
;767:	if (ent->s.weapon != WP_GRAPPLING_HOOK && ent->s.weapon != WP_GAUNTLET) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 10
EQI4 $328
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1
EQI4 $328
line 768
;768:		if (ent->s.weapon == WP_NAILGUN) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 11
NEI4 $330
line 769
;769:			ent->client->accuracy_shots += NUM_NAILSHOTS;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 712
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 15
ADDI4
ASGNI4
line 770
;770:		} else {
ADDRGP4 $331
JUMPV
LABELV $330
line 771
;771:			ent->client->accuracy_shots++;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 712
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
line 772
;772:		}
LABELV $331
line 773
;773:	}
LABELV $328
line 776
;774:
;775:	// set aiming directions
;776:	AngleVectors(ent->client->ps.viewangles, forward, right, up);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 778
;777:
;778:	CalcMuzzlePointOrigin(ent, muzzle_origin, forward, right, up, muzzle);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 muzzle_origin
ARGP4
ADDRGP4 forward
ARGP4
ADDRGP4 right
ARGP4
ADDRGP4 up
ARGP4
ADDRGP4 muzzle
ARGP4
ADDRGP4 CalcMuzzlePointOrigin
CALLV
pop
line 781
;779:
;780:	// fire the specific weapon
;781:	switch (ent->s.weapon) {
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
LTI4 $333
ADDRLP4 8
INDIRI4
CNSTI4 14
GTI4 $333
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $352-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $352
address $335
address $336
address $340
address $341
address $342
address $343
address $344
address $345
address $346
address $347
address $348
address $349
address $350
address $351
code
LABELV $335
line 783
;782:	case WP_GAUNTLET:
;783:		Weapon_Gauntlet(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_Gauntlet
CALLV
pop
line 784
;784:		break;
ADDRGP4 $333
JUMPV
LABELV $336
line 786
;785:	case WP_MACHINEGUN:
;786:		if (g_gametype.integer != GT_TEAM) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
EQI4 $337
line 787
;787:			Bullet_Fire(ent, MACHINEGUN_SPREAD, MACHINEGUN_DAMAGE);
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 1128792064
ARGF4
CNSTI4 7
ARGI4
ADDRGP4 Bullet_Fire
CALLV
pop
line 788
;788:		} else {
ADDRGP4 $333
JUMPV
LABELV $337
line 789
;789:			Bullet_Fire(ent, MACHINEGUN_SPREAD, MACHINEGUN_TEAM_DAMAGE);
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 1128792064
ARGF4
CNSTI4 5
ARGI4
ADDRGP4 Bullet_Fire
CALLV
pop
line 790
;790:		}
line 791
;791:		break;
ADDRGP4 $333
JUMPV
LABELV $340
line 793
;792:	case WP_SHOTGUN:
;793:		weapon_supershotgun_fire(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 weapon_supershotgun_fire
CALLV
pop
line 794
;794:		break;
ADDRGP4 $333
JUMPV
LABELV $341
line 796
;795:	case WP_GRENADE_LAUNCHER:
;796:		weapon_grenadelauncher_fire(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 weapon_grenadelauncher_fire
CALLV
pop
line 797
;797:		break;
ADDRGP4 $333
JUMPV
LABELV $342
line 799
;798:	case WP_ROCKET_LAUNCHER:
;799:		Weapon_RocketLauncher_Fire(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_RocketLauncher_Fire
CALLV
pop
line 800
;800:		break;
ADDRGP4 $333
JUMPV
LABELV $343
line 802
;801:	case WP_LIGHTNING:
;802:		Weapon_LightningFire(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_LightningFire
CALLV
pop
line 803
;803:		break;
ADDRGP4 $333
JUMPV
LABELV $344
line 805
;804:	case WP_RAILGUN:
;805:		weapon_railgun_fire(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 weapon_railgun_fire
CALLV
pop
line 806
;806:		break;
ADDRGP4 $333
JUMPV
LABELV $345
line 808
;807:	case WP_PLASMAGUN:
;808:		Weapon_Plasmagun_Fire(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_Plasmagun_Fire
CALLV
pop
line 809
;809:		break;
ADDRGP4 $333
JUMPV
LABELV $346
line 811
;810:	case WP_BFG:
;811:		BFG_Fire(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BFG_Fire
CALLV
pop
line 812
;812:		break;
ADDRGP4 $333
JUMPV
LABELV $347
line 814
;813:	case WP_GRAPPLING_HOOK:
;814:		Weapon_GrapplingHook_Fire(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_GrapplingHook_Fire
CALLV
pop
line 815
;815:		break;
ADDRGP4 $333
JUMPV
LABELV $348
line 817
;816:	case WP_NAILGUN:
;817:		Weapon_Nailgun_Fire(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_Nailgun_Fire
CALLV
pop
line 818
;818:		break;
ADDRGP4 $333
JUMPV
LABELV $349
line 820
;819:	case WP_PROX_LAUNCHER:
;820:		weapon_proxlauncher_fire(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 weapon_proxlauncher_fire
CALLV
pop
line 821
;821:		break;
ADDRGP4 $333
JUMPV
LABELV $350
line 823
;822:	case WP_CHAINGUN:
;823:		Bullet_Fire(ent, CHAINGUN_SPREAD, MACHINEGUN_DAMAGE);
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 1142292480
ARGF4
CNSTI4 7
ARGI4
ADDRGP4 Bullet_Fire
CALLV
pop
line 824
;824:		break;
ADDRGP4 $333
JUMPV
LABELV $351
line 826
;825:	case WP_HMG:
;826:		Bullet_Fire(ent, MACHINEGUN_SPREAD, MACHINEGUN_DAMAGE);
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 1128792064
ARGF4
CNSTI4 7
ARGI4
ADDRGP4 Bullet_Fire
CALLV
pop
line 827
;827:		break;
line 830
;828:	default:
;829:		// FIXME		G_Error( "Bad ent->s.weapon" );
;830:		break;
LABELV $333
line 832
;831:	}
;832:}
LABELV $322
endproc FireWeapon 16 24
proc KamikazeRadiusDamage 4180 32
line 840
;833:
;834:
;835:/*
;836:===============
;837:KamikazeRadiusDamage
;838:===============
;839:*/
;840:static void KamikazeRadiusDamage(vec3_t origin, gentity_t *attacker, float damage, float radius) {
line 850
;841:	float		dist;
;842:	gentity_t *ent;
;843:	int			entityList[MAX_GENTITIES];
;844:	int			numListedEntities;
;845:	vec3_t		mins, maxs;
;846:	vec3_t		v;
;847:	vec3_t		dir;
;848:	int			i, e;
;849:
;850:	if (radius < 1) {
ADDRFP4 12
INDIRF4
CNSTF4 1065353216
GEF4 $355
line 851
;851:		radius = 1;
ADDRFP4 12
CNSTF4 1065353216
ASGNF4
line 852
;852:	}
LABELV $355
line 854
;853:
;854:	for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $357
line 855
;855:		mins[i] = origin[i] - radius;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4140
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
SUBF4
ASGNF4
line 856
;856:		maxs[i] = origin[i] + radius;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4152
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
ADDF4
ASGNF4
line 857
;857:	}
LABELV $358
line 854
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $357
line 859
;858:
;859:	numListedEntities = trap_EntitiesInBox(mins, maxs, entityList, MAX_GENTITIES);
ADDRLP4 4140
ARGP4
ADDRLP4 4152
ARGP4
ADDRLP4 40
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4164
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 4136
ADDRLP4 4164
INDIRI4
ASGNI4
line 861
;860:
;861:	for (e = 0; e < numListedEntities; e++) {
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRGP4 $364
JUMPV
LABELV $361
line 862
;862:		ent = &g_entities[entityList[e]];
ADDRLP4 4
ADDRLP4 32
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 40
ADDP4
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 864
;863:
;864:		if (!ent->takedamage) {
ADDRLP4 4
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
NEI4 $365
line 865
;865:			continue;
ADDRGP4 $362
JUMPV
LABELV $365
line 869
;866:		}
;867:
;868:		// dont hit things we have already hit
;869:		if (ent->kamikazeTime > level.time) {
ADDRLP4 4
INDIRP4
CNSTI4 784
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $367
line 870
;870:			continue;
ADDRGP4 $362
JUMPV
LABELV $367
line 874
;871:		}
;872:
;873:		// find the distance from the edge of the bounding box
;874:		for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $370
line 875
;875:			if (origin[i] < ent->r.absmin[i]) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
GEF4 $374
line 876
;876:				v[i] = ent->r.absmin[i] - origin[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 877
;877:			} else if (origin[i] > ent->r.absmax[i]) {
ADDRGP4 $375
JUMPV
LABELV $374
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
LEF4 $376
line 878
;878:				v[i] = origin[i] - ent->r.absmax[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 879
;879:			} else {
ADDRGP4 $377
JUMPV
LABELV $376
line 880
;880:				v[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
CNSTF4 0
ASGNF4
line 881
;881:			}
LABELV $377
LABELV $375
line 882
;882:		}
LABELV $371
line 874
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $370
line 884
;883:
;884:		dist = VectorLength(v);
ADDRLP4 8
ARGP4
ADDRLP4 4168
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 36
ADDRLP4 4168
INDIRF4
ASGNF4
line 885
;885:		if (dist >= radius) {
ADDRLP4 36
INDIRF4
ADDRFP4 12
INDIRF4
LTF4 $378
line 886
;886:			continue;
ADDRGP4 $362
JUMPV
LABELV $378
line 890
;887:		}
;888:
;889:		//		if( CanDamage (ent, origin) ) {
;890:		VectorSubtract(ent->r.currentOrigin, origin, dir);
ADDRLP4 4176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 4176
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20+4
ADDRLP4 4
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 4176
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20+8
ADDRLP4 4
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 893
;891:		// push the center of mass higher than the origin so players
;892:		// get knocked into the air more
;893:		dir[2] += 24;
ADDRLP4 20+8
ADDRLP4 20+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 894
;894:		G_Damage(ent, NULL, attacker, dir, origin, damage, DAMAGE_RADIUS | DAMAGE_NO_TEAM_PROTECTION, MOD_KAMIKAZE);
ADDRLP4 4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRF4
CVFI4 4
ARGI4
CNSTI4 17
ARGI4
CNSTI4 26
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 895
;895:		ent->kamikazeTime = level.time + 3000;
ADDRLP4 4
INDIRP4
CNSTI4 784
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 897
;896:		//		}
;897:	}
LABELV $362
line 861
ADDRLP4 32
ADDRLP4 32
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $364
ADDRLP4 32
INDIRI4
ADDRLP4 4136
INDIRI4
LTI4 $361
line 898
;898:}
LABELV $354
endproc KamikazeRadiusDamage 4180 32
proc KamikazeShockWave 4180 32
line 905
;899:
;900:/*
;901:===============
;902:KamikazeShockWave
;903:===============
;904:*/
;905:static void KamikazeShockWave(vec3_t origin, gentity_t *attacker, float damage, float push, float radius) {
line 915
;906:	float		dist;
;907:	gentity_t *ent;
;908:	int			entityList[MAX_GENTITIES];
;909:	int			numListedEntities;
;910:	vec3_t		mins, maxs;
;911:	vec3_t		v;
;912:	vec3_t		dir;
;913:	int			i, e;
;914:
;915:	if (radius < 1)
ADDRFP4 16
INDIRF4
CNSTF4 1065353216
GEF4 $385
line 916
;916:		radius = 1;
ADDRFP4 16
CNSTF4 1065353216
ASGNF4
LABELV $385
line 918
;917:
;918:	for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $387
line 919
;919:		mins[i] = origin[i] - radius;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4140
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRFP4 16
INDIRF4
SUBF4
ASGNF4
line 920
;920:		maxs[i] = origin[i] + radius;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4152
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRFP4 16
INDIRF4
ADDF4
ASGNF4
line 921
;921:	}
LABELV $388
line 918
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $387
line 923
;922:
;923:	numListedEntities = trap_EntitiesInBox(mins, maxs, entityList, MAX_GENTITIES);
ADDRLP4 4140
ARGP4
ADDRLP4 4152
ARGP4
ADDRLP4 40
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4164
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 4136
ADDRLP4 4164
INDIRI4
ASGNI4
line 925
;924:
;925:	for (e = 0; e < numListedEntities; e++) {
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRGP4 $394
JUMPV
LABELV $391
line 926
;926:		ent = &g_entities[entityList[e]];
ADDRLP4 4
ADDRLP4 32
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 40
ADDP4
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 929
;927:
;928:		// dont hit things we have already hit
;929:		if (ent->kamikazeShockTime > level.time) {
ADDRLP4 4
INDIRP4
CNSTI4 788
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $395
line 930
;930:			continue;
ADDRGP4 $392
JUMPV
LABELV $395
line 934
;931:		}
;932:
;933:		// find the distance from the edge of the bounding box
;934:		for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $398
line 935
;935:			if (origin[i] < ent->r.absmin[i]) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
GEF4 $402
line 936
;936:				v[i] = ent->r.absmin[i] - origin[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 464
ADDP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 937
;937:			} else if (origin[i] > ent->r.absmax[i]) {
ADDRGP4 $403
JUMPV
LABELV $402
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
LEF4 $404
line 938
;938:				v[i] = origin[i] - ent->r.absmax[i];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 476
ADDP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 939
;939:			} else {
ADDRGP4 $405
JUMPV
LABELV $404
line 940
;940:				v[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
CNSTF4 0
ASGNF4
line 941
;941:			}
LABELV $405
LABELV $403
line 942
;942:		}
LABELV $399
line 934
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $398
line 944
;943:
;944:		dist = VectorLength(v);
ADDRLP4 8
ARGP4
ADDRLP4 4168
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 36
ADDRLP4 4168
INDIRF4
ASGNF4
line 945
;945:		if (dist >= radius) {
ADDRLP4 36
INDIRF4
ADDRFP4 16
INDIRF4
LTF4 $406
line 946
;946:			continue;
ADDRGP4 $392
JUMPV
LABELV $406
line 950
;947:		}
;948:
;949:		//		if( CanDamage (ent, origin) ) {
;950:		VectorSubtract(ent->r.currentOrigin, origin, dir);
ADDRLP4 4176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
ADDRLP4 4
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDRLP4 4176
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20+4
ADDRLP4 4
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDRLP4 4176
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20+8
ADDRLP4 4
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 951
;951:		dir[2] += 24;
ADDRLP4 20+8
ADDRLP4 20+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 952
;952:		G_Damage(ent, NULL, attacker, dir, origin, damage, DAMAGE_RADIUS | DAMAGE_NO_TEAM_PROTECTION, MOD_KAMIKAZE);
ADDRLP4 4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRF4
CVFI4 4
ARGI4
CNSTI4 17
ARGI4
CNSTI4 26
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 954
;953:		//
;954:		dir[2] = 0;
ADDRLP4 20+8
CNSTF4 0
ASGNF4
line 955
;955:		VectorNormalize(dir);
ADDRLP4 20
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 956
;956:		if (ent->client) {
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $412
line 957
;957:			ent->client->ps.velocity[0] = dir[0] * push;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 20
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 958
;958:			ent->client->ps.velocity[1] = dir[1] * push;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 20+4
INDIRF4
ADDRFP4 12
INDIRF4
MULF4
ASGNF4
line 959
;959:			ent->client->ps.velocity[2] = 100;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1120403456
ASGNF4
line 960
;960:		}
LABELV $412
line 961
;961:		ent->kamikazeShockTime = level.time + 3000;
ADDRLP4 4
INDIRP4
CNSTI4 788
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 963
;962:		//		}
;963:	}
LABELV $392
line 925
ADDRLP4 32
ADDRLP4 32
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $394
ADDRLP4 32
INDIRI4
ADDRLP4 4136
INDIRI4
LTI4 $391
line 964
;964:}
LABELV $384
endproc KamikazeShockWave 4180 32
proc KamikazeDamage 56 20
line 971
;965:
;966:/*
;967:===============
;968:KamikazeDamage
;969:===============
;970:*/
;971:static void KamikazeDamage(gentity_t *self) {
line 977
;972:	int i;
;973:	float t;
;974:	gentity_t *ent;
;975:	vec3_t newangles;
;976:
;977:	self->count += 100;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 979
;978:
;979:	if (self->count >= KAMI_SHOCKWAVE_STARTTIME) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
LTI4 $417
line 981
;980:		// shockwave push back
;981:		t = self->count - KAMI_SHOCKWAVE_STARTTIME;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 982
;982:		KamikazeShockWave(self->s.pos.trBase, self->activator, 25, 400, (int)(float)t * KAMI_SHOCKWAVE_MAXRADIUS / (KAMI_SHOCKWAVE_ENDTIME - KAMI_SHOCKWAVE_STARTTIME));
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
ARGP4
CNSTF4 1103626240
ARGF4
CNSTF4 1137180672
ARGF4
ADDRLP4 20
INDIRF4
CVFI4 4
CNSTI4 1320
MULI4
CNSTI4 2000
DIVI4
CVIF4 4
ARGF4
ADDRGP4 KamikazeShockWave
CALLV
pop
line 983
;983:	}
LABELV $417
line 985
;984:	//
;985:	if (self->count >= KAMI_EXPLODE_STARTTIME) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 250
LTI4 $419
line 987
;986:		// do our damage
;987:		t = self->count - KAMI_EXPLODE_STARTTIME;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 250
SUBI4
CVIF4 4
ASGNF4
line 988
;988:		KamikazeRadiusDamage(self->s.pos.trBase, self->activator, 400, (int)(float)t * KAMI_BOOMSPHERE_MAXRADIUS / (KAMI_IMPLODE_STARTTIME - KAMI_EXPLODE_STARTTIME));
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
ARGP4
CNSTF4 1137180672
ARGF4
ADDRLP4 20
INDIRF4
CVFI4 4
CNSTI4 720
MULI4
CNSTI4 1750
DIVI4
CVIF4 4
ARGF4
ADDRGP4 KamikazeRadiusDamage
CALLV
pop
line 989
;989:	}
LABELV $419
line 992
;990:
;991:	// either cycle or kill self
;992:	if (self->count >= KAMI_SHOCKWAVE_ENDTIME) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 2000
LTI4 $421
line 993
;993:		G_FreeEntity(self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 994
;994:		return;
ADDRGP4 $416
JUMPV
LABELV $421
line 996
;995:	}
;996:	self->nextthink = level.time + 100;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 999
;997:
;998:	// add earth quake effect
;999:	newangles[0] = crandom() * 2;
ADDRLP4 28
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 28
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1082130432
MULF4
ASGNF4
line 1000
;1000:	newangles[1] = crandom() * 2;
ADDRLP4 32
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 4+4
ADDRLP4 32
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1082130432
MULF4
ASGNF4
line 1001
;1001:	newangles[2] = 0;
ADDRLP4 4+8
CNSTF4 0
ASGNF4
line 1002
;1002:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $426
line 1003
;1003:		ent = &g_entities[i];
ADDRLP4 0
ADDRLP4 16
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1004
;1004:		if (!ent->inuse)
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $430
line 1005
;1005:			continue;
ADDRGP4 $427
JUMPV
LABELV $430
line 1006
;1006:		if (!ent->client)
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $432
line 1007
;1007:			continue;
ADDRGP4 $427
JUMPV
LABELV $432
line 1009
;1008:
;1009:		if (ent->client->ps.groundEntityNum != ENTITYNUM_NONE) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $434
line 1010
;1010:			ent->client->ps.velocity[0] += crandom() * 120;
ADDRLP4 36
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRF4
ADDRLP4 36
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1131413504
MULF4
ADDF4
ASGNF4
line 1011
;1011:			ent->client->ps.velocity[1] += crandom() * 120;
ADDRLP4 44
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 48
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRF4
ADDRLP4 44
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 939524352
MULF4
CNSTF4 1056964608
SUBF4
CNSTF4 1131413504
MULF4
ADDF4
ASGNF4
line 1012
;1012:			ent->client->ps.velocity[2] = 30 + random() * 25;
ADDRLP4 52
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 40
ADDP4
ADDRLP4 52
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 977797520
MULF4
CNSTF4 1106247680
ADDF4
ASGNF4
line 1013
;1013:		}
LABELV $434
line 1015
;1014:
;1015:		ent->client->ps.delta_angles[0] += ANGLE2SHORT(newangles[0] - self->movedir[0]);
ADDRLP4 36
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 56
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 676
ADDP4
INDIRF4
SUBF4
CNSTF4 1127615329
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
ADDI4
ASGNI4
line 1016
;1016:		ent->client->ps.delta_angles[1] += ANGLE2SHORT(newangles[1] - self->movedir[1]);
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 60
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
ADDRLP4 4+4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 680
ADDP4
INDIRF4
SUBF4
CNSTF4 1127615329
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
ADDI4
ASGNI4
line 1017
;1017:		ent->client->ps.delta_angles[2] += ANGLE2SHORT(newangles[2] - self->movedir[2]);
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 64
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
ADDRLP4 4+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 684
ADDP4
INDIRF4
SUBF4
CNSTF4 1127615329
MULF4
CVFI4 4
CNSTI4 65535
BANDI4
ADDI4
ASGNI4
line 1018
;1018:	}
LABELV $427
line 1002
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 64
LTI4 $426
line 1019
;1019:	VectorCopy(newangles, self->movedir);
ADDRFP4 0
INDIRP4
CNSTI4 676
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 1020
;1020:}
LABELV $416
endproc KamikazeDamage 56 20
export G_StartKamikaze
proc G_StartKamikaze 32 32
line 1027
;1021:
;1022:/*
;1023:===============
;1024:G_StartKamikaze
;1025:===============
;1026:*/
;1027:void G_StartKamikaze(gentity_t *ent) {
line 1033
;1028:	gentity_t *explosion;
;1029:	gentity_t *te;
;1030:	vec3_t		snapped;
;1031:
;1032:	// start up the explosion logic
;1033:	explosion = G_Spawn();
ADDRLP4 20
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 1035
;1034:
;1035:	explosion->s.eType = ET_EVENTS + EV_KAMIKAZE;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 81
ASGNI4
line 1036
;1036:	explosion->eventTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1038
;1037:
;1038:	if (ent->client) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $440
line 1039
;1039:		VectorCopy(ent->s.pos.trBase, snapped);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1040
;1040:	} else {
ADDRGP4 $441
JUMPV
LABELV $440
line 1041
;1041:		VectorCopy(ent->activator->s.pos.trBase, snapped);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1042
;1042:	}
LABELV $441
line 1043
;1043:	SnapVector(snapped);		// save network bandwidth
ADDRLP4 4
ADDRLP4 4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
CVFI4 4
CVIF4 4
ASGNF4
line 1044
;1044:	G_SetOrigin(explosion, snapped);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 1046
;1045:
;1046:	explosion->classname = "kamikaze";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $446
ASGNP4
line 1047
;1047:	explosion->s.pos.trType = TR_STATIONARY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 1049
;1048:
;1049:	explosion->kamikazeTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 784
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1051
;1050:
;1051:	explosion->think = KamikazeDamage;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 KamikazeDamage
ASGNP4
line 1052
;1052:	explosion->nextthink = level.time + 100;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 1053
;1053:	explosion->count = 0;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 0
ASGNI4
line 1054
;1054:	VectorClear(explosion->movedir);
ADDRLP4 0
INDIRP4
CNSTI4 676
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 680
ADDP4
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRP4
CNSTI4 684
ADDP4
CNSTF4 0
ASGNF4
line 1056
;1055:
;1056:	trap_LinkEntity(explosion);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1058
;1057:
;1058:	if (ent->client) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $449
line 1060
;1059:		//
;1060:		explosion->activator = ent;
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 1062
;1061:		//
;1062:		ent->s.eFlags &= ~EF_KAMIKAZE;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 8
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
line 1064
;1063:		// nuke the guy that used it
;1064:		G_Damage(ent, ent, ent, NULL, NULL, 100000, DAMAGE_NO_PROTECTION, MOD_KAMIKAZE);
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTI4 100000
ARGI4
CNSTI4 8
ARGI4
CNSTI4 26
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 1065
;1065:	} else {
ADDRGP4 $450
JUMPV
LABELV $449
line 1066
;1066:		if (!strcmp(ent->activator->classname, "bodyque")) {
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $453
ARGP4
ADDRLP4 24
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $451
line 1067
;1067:			explosion->activator = &g_entities[ent->activator->r.ownerNum];
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
CNSTI4 824
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1068
;1068:		} else {
ADDRGP4 $452
JUMPV
LABELV $451
line 1069
;1069:			explosion->activator = ent->activator;
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
ASGNP4
line 1070
;1070:		}
LABELV $452
line 1071
;1071:	}
LABELV $450
line 1074
;1072:
;1073:	// play global sound at all clients
;1074:	te = G_TempEntity(snapped, EV_GLOBAL_TEAM_SOUND);
ADDRLP4 4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 24
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 24
INDIRP4
ASGNP4
line 1075
;1075:	te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 28
ADDRLP4 16
INDIRP4
CNSTI4 424
ADDP4
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 1076
;1076:	te->s.eventParm = GTS_KAMIKAZE;
ADDRLP4 16
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 13
ASGNI4
line 1077
;1077:}
LABELV $438
endproc G_StartKamikaze 32 32
bss
align 4
LABELV muzzle_origin
skip 12
align 4
LABELV muzzle
skip 12
align 4
LABELV up
skip 12
align 4
LABELV right
skip 12
align 4
LABELV forward
skip 12
align 4
LABELV s_quadFactor
skip 4
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
import g_allowVote
import g_allowKill
import g_podiumDrop
import g_podiumDist
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
import Svcmd_AbortPodium_f
import SpawnModelsOnVictoryPads
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
import CalcMuzzlePoint
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
import Touch_Item
import ArmorIndex
import Think_Weapon
import FinishSpawningItem
import G_SpawnItem
import SetRespawn
import LaunchItem
import Drop_Item
import PrecacheItem
import UseHoldableItem
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
import G_NewString
import G_SpawnEntitiesFromString
import G_SpawnVector
import G_SpawnInt
import G_SpawnFloat
import G_SpawnString
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
LABELV $453
byte 1 98
byte 1 111
byte 1 100
byte 1 121
byte 1 113
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $446
byte 1 107
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
byte 1 0

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
LABELV $55
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
LABELV $56
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
LABELV $67
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
EQI4 $75
line 81
;81:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $68
JUMPV
LABELV $75
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
EQI4 $78
line 85
;85:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $68
JUMPV
LABELV $78
line 88
;86:	}
;87:
;88:	traceEnt = &g_entities[tr.entityNum];
ADDRLP4 0
ADDRLP4 4+52
INDIRI4
CNSTI4 832
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
EQI4 $81
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $81
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
LABELV $81
line 98
;97:
;98:	if (!traceEnt->takedamage) {
ADDRLP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
NEI4 $85
line 99
;99:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $68
JUMPV
LABELV $85
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
EQI4 $87
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
ADDRGP4 $88
JUMPV
LABELV $87
line 106
;106:		s_quadFactor = 1.0;
ADDRGP4 s_quadFactor
CNSTF4 1065353216
ASGNF4
line 107
;107:	}
LABELV $88
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
EQU4 $90
ADDRLP4 84
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
CNSTI4 820
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $90
ADDRLP4 84
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
CNSTI4 820
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 12
NEI4 $90
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
LABELV $90
line 113
;112:
;113:	damage = g_damage_g.integer * s_quadFactor;
ADDRLP4 76
ADDRGP4 g_damage_g+12
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
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
LABELV $68
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
LABELV $95
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
GEF4 $99
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
LTF4 $101
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
ADDRGP4 $100
JUMPV
LABELV $101
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
ADDRGP4 $100
JUMPV
LABELV $99
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
GTF4 $103
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
ADDRGP4 $104
JUMPV
LABELV $103
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
LABELV $104
line 152
;152:		}
LABELV $100
line 153
;153:	}
LABELV $96
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
LTI4 $95
line 154
;154:}
LABELV $94
endproc SnapVectorTowards 24 0
proc Bullet_Fire 160 32
line 161
;155:
;156:#define CHAINGUN_SPREAD		600
;157:#define MACHINEGUN_SPREAD	200
;158:#define	MACHINEGUN_DAMAGE	7
;159:#define	MACHINEGUN_TEAM_DAMAGE	5		// wimpier MG in teamplay
;160:
;161:static void Bullet_Fire(gentity_t *ent, float spread, int damage, int mod) {
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
LABELV $124
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
EQI4 $128
line 193
;193:			return;
ADDRGP4 $105
JUMPV
LABELV $128
line 195
;194:
;195:		traceEnt = &g_entities[tr.entityNum];
ADDRLP4 0
ADDRLP4 4+52
INDIRI4
CNSTI4 832
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
EQI4 $133
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $133
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
EQI4 $134
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
ADDRGP4 $134
JUMPV
LABELV $133
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
LABELV $134
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
EQI4 $126
line 218
;218:			if (traceEnt->client && traceEnt->client->invulnerabilityTime > level.time) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $142
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
LEI4 $142
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
EQI4 $145
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
ADDRGP4 $125
JUMPV
LABELV $145
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
ADDRGP4 $125
JUMPV
LABELV $142
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
ADDRGP4 $126
JUMPV
LABELV $125
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
LTI4 $124
LABELV $126
line 235
;234:	}
;235:}
LABELV $105
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
LABELV $150
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
LABELV $152
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
CNSTI4 832
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
EQI4 $157
line 287
;287:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $151
JUMPV
LABELV $157
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
EQI4 $160
line 291
;291:			damage = g_damage_sg.integer * s_quadFactor;
ADDRLP4 92
ADDRGP4 g_damage_sg+12
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
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
EQU4 $163
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
LEI4 $163
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
EQI4 $166
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
ADDRGP4 $153
JUMPV
LABELV $166
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
ADDRGP4 $153
JUMPV
LABELV $163
line 304
;303:			}
;304:		}
LABELV $160
line 305
;305:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $151
JUMPV
LABELV $153
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
LTI4 $152
line 307
;306:	}
;307:	return qfalse;
CNSTI4 0
RETI4
LABELV $151
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
LABELV $171
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
EQI4 $191
ADDRLP4 60
INDIRI4
CNSTI4 0
NEI4 $191
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
LABELV $191
line 339
;339:	}
LABELV $172
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
LTI4 $171
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
LABELV $170
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
LABELV $193
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
LABELV $196
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
LABELV $198
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
LABELV $199
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
;448:	damage = g_damage_rg.integer * s_quadFactor;
ADDRLP4 132
ADDRGP4 g_damage_rg+12
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
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
LABELV $208
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
LTI4 $211
line 462
;462:			break;
ADDRGP4 $210
JUMPV
LABELV $211
line 464
;463:		}
;464:		traceEnt = &g_entities[trace.entityNum];
ADDRLP4 0
ADDRLP4 4+52
INDIRI4
CNSTI4 832
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
EQI4 $215
line 466
;466:			if (traceEnt->client && traceEnt->client->invulnerabilityTime > level.time) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $217
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
LEI4 $217
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
EQI4 $220
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
LABELV $220
line 485
;485:			}
LABELV $217
line 486
;486:		}
LABELV $215
line 487
;487:		if (trace.contents & CONTENTS_SOLID) {
ADDRLP4 4+48
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $229
line 488
;488:			break;		// we hit something solid enough to stop the beam
ADDRGP4 $210
JUMPV
LABELV $229
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
LABELV $209
ADDRLP4 64
INDIRI4
CNSTI4 4
LTI4 $208
LABELV $210
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
ADDRGP4 $235
JUMPV
LABELV $232
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
LABELV $233
line 501
ADDRLP4 68
ADDRLP4 68
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $235
ADDRLP4 68
INDIRI4
ADDRLP4 64
INDIRI4
LTI4 $232
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
EQI4 $242
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
ADDRGP4 $243
JUMPV
LABELV $242
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
LABELV $243
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
NEI4 $246
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
ADDRGP4 $247
JUMPV
LABELV $246
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
LTI4 $248
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
LABELV $248
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
LABELV $247
line 549
;548:
;549:}
LABELV $200
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
NEI4 $252
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
NEU4 $252
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
LABELV $252
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
LABELV $251
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
LABELV $254
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
EQU4 $256
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
LABELV $256
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
LABELV $255
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
;607:	damage = g_damage_lg.integer * s_quadFactor;
ADDRLP4 108
ADDRGP4 g_damage_lg+12
INDIRI4
CVIF4 4
ADDRGP4 s_quadFactor
INDIRF4
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
LABELV $262
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
EQI4 $272
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
LABELV $272
line 632
;632:		if (tr.entityNum == ENTITYNUM_NONE) {
ADDRLP4 12+52
INDIRI4
CNSTI4 1023
NEI4 $279
line 633
;633:			return;
ADDRGP4 $260
JUMPV
LABELV $279
line 636
;634:		}
;635:
;636:		traceEnt = &g_entities[tr.entityNum];
ADDRLP4 68
ADDRLP4 12+52
INDIRI4
CNSTI4 832
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
EQI4 $283
line 639
;639:			if (traceEnt->client && traceEnt->client->invulnerabilityTime > level.time) {
ADDRLP4 68
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $285
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
LEI4 $285
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
EQI4 $288
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
ADDRGP4 $263
JUMPV
LABELV $288
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
ADDRGP4 $263
JUMPV
LABELV $285
line 653
;652:			}
;653:		}
LABELV $283
line 655
;654:
;655:		if (traceEnt->takedamage && traceEnt->client) {
ADDRLP4 68
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
EQI4 $298
ADDRLP4 68
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $298
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
ADDRGP4 $264
JUMPV
LABELV $298
ADDRLP4 12+44
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $264
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
ADDRGP4 $264
JUMPV
LABELV $263
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
LTI4 $262
LABELV $264
line 667
;666:	}
;667:}
LABELV $260
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
LABELV $308
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
LABELV $309
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
LTI4 $308
line 689
;687:
;688:	//	VectorAdd( m->s.pos.trDelta, ent->client->ps.velocity, m->s.pos.trDelta );	// "real" physics
;689:}
LABELV $307
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
LABELV $312
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
NEI4 $315
line 724
;724:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $314
JUMPV
LABELV $315
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
NEU4 $317
line 728
;728:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $314
JUMPV
LABELV $317
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
NEU4 $319
line 732
;732:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $314
JUMPV
LABELV $319
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
NEU4 $321
line 736
;736:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $314
JUMPV
LABELV $321
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
GTI4 $323
line 740
;740:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $314
JUMPV
LABELV $323
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
EQI4 $325
line 744
;744:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $314
JUMPV
LABELV $325
line 747
;745:	}
;746:
;747:	return qtrue;
CNSTI4 1
RETI4
LABELV $314
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
EQI4 $328
line 758
;758:		s_quadFactor = g_quadDamageFactor.value;
ADDRGP4 s_quadFactor
ADDRGP4 g_quadDamageFactor+8
INDIRF4
ASGNF4
line 759
;759:	} else {
ADDRGP4 $329
JUMPV
LABELV $328
line 760
;760:		s_quadFactor = 1.0;
ADDRGP4 s_quadFactor
CNSTF4 1065353216
ASGNF4
line 761
;761:	}
LABELV $329
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
EQU4 $331
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
CNSTI4 820
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $331
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 776
ADDP4
INDIRP4
CNSTI4 820
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 12
NEI4 $331
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
LABELV $331
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
EQI4 $333
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1
EQI4 $333
line 768
;768:		if (ent->s.weapon == WP_NAILGUN) {
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 11
NEI4 $335
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
ADDRGP4 $336
JUMPV
LABELV $335
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
LABELV $336
line 773
;773:	}
LABELV $333
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
LTI4 $338
ADDRLP4 8
INDIRI4
CNSTI4 14
GTI4 $338
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $357-4
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $357
address $340
address $341
address $343
address $344
address $345
address $346
address $347
address $348
address $349
address $350
address $351
address $352
address $353
address $355
code
LABELV $340
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
ADDRGP4 $338
JUMPV
LABELV $341
line 786
;785:	case WP_MACHINEGUN:
;786:		Bullet_Fire(ent, MACHINEGUN_SPREAD, g_damage_mg.integer, MOD_MACHINEGUN);
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 1128792064
ARGF4
ADDRGP4 g_damage_mg+12
INDIRI4
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 Bullet_Fire
CALLV
pop
line 787
;787:		break;
ADDRGP4 $338
JUMPV
LABELV $343
line 789
;788:	case WP_SHOTGUN:
;789:		weapon_supershotgun_fire(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 weapon_supershotgun_fire
CALLV
pop
line 790
;790:		break;
ADDRGP4 $338
JUMPV
LABELV $344
line 792
;791:	case WP_GRENADE_LAUNCHER:
;792:		weapon_grenadelauncher_fire(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 weapon_grenadelauncher_fire
CALLV
pop
line 793
;793:		break;
ADDRGP4 $338
JUMPV
LABELV $345
line 795
;794:	case WP_ROCKET_LAUNCHER:
;795:		Weapon_RocketLauncher_Fire(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_RocketLauncher_Fire
CALLV
pop
line 796
;796:		break;
ADDRGP4 $338
JUMPV
LABELV $346
line 798
;797:	case WP_LIGHTNING:
;798:		Weapon_LightningFire(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_LightningFire
CALLV
pop
line 799
;799:		break;
ADDRGP4 $338
JUMPV
LABELV $347
line 801
;800:	case WP_RAILGUN:
;801:		weapon_railgun_fire(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 weapon_railgun_fire
CALLV
pop
line 802
;802:		break;
ADDRGP4 $338
JUMPV
LABELV $348
line 804
;803:	case WP_PLASMAGUN:
;804:		Weapon_Plasmagun_Fire(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_Plasmagun_Fire
CALLV
pop
line 805
;805:		break;
ADDRGP4 $338
JUMPV
LABELV $349
line 807
;806:	case WP_BFG:
;807:		BFG_Fire(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BFG_Fire
CALLV
pop
line 808
;808:		break;
ADDRGP4 $338
JUMPV
LABELV $350
line 810
;809:	case WP_GRAPPLING_HOOK:
;810:		Weapon_GrapplingHook_Fire(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_GrapplingHook_Fire
CALLV
pop
line 811
;811:		break;
ADDRGP4 $338
JUMPV
LABELV $351
line 813
;812:	case WP_NAILGUN:
;813:		Weapon_Nailgun_Fire(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Weapon_Nailgun_Fire
CALLV
pop
line 814
;814:		break;
ADDRGP4 $338
JUMPV
LABELV $352
line 816
;815:	case WP_PROX_LAUNCHER:
;816:		weapon_proxlauncher_fire(ent);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 weapon_proxlauncher_fire
CALLV
pop
line 817
;817:		break;
ADDRGP4 $338
JUMPV
LABELV $353
line 819
;818:	case WP_CHAINGUN:
;819:		Bullet_Fire(ent, CHAINGUN_SPREAD, g_damage_cg.integer, MOD_CHAINGUN);
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 1142292480
ARGF4
ADDRGP4 g_damage_cg+12
INDIRI4
ARGI4
CNSTI4 24
ARGI4
ADDRGP4 Bullet_Fire
CALLV
pop
line 820
;820:		break;
ADDRGP4 $338
JUMPV
LABELV $355
line 822
;821:	case WP_HMG:
;822:		Bullet_Fire(ent, MACHINEGUN_SPREAD, g_damage_hmg.integer, MOD_HMG);
ADDRFP4 0
INDIRP4
ARGP4
CNSTF4 1128792064
ARGF4
ADDRGP4 g_damage_hmg+12
INDIRI4
ARGI4
CNSTI4 32
ARGI4
ADDRGP4 Bullet_Fire
CALLV
pop
line 823
;823:		break;
line 826
;824:	default:
;825:		// FIXME		G_Error( "Bad ent->s.weapon" );
;826:		break;
LABELV $338
line 828
;827:	}
;828:}
LABELV $327
endproc FireWeapon 16 24
proc KamikazeRadiusDamage 4180 32
line 836
;829:
;830:
;831:/*
;832:===============
;833:KamikazeRadiusDamage
;834:===============
;835:*/
;836:static void KamikazeRadiusDamage(vec3_t origin, gentity_t *attacker, float damage, float radius) {
line 846
;837:	float		dist;
;838:	gentity_t *ent;
;839:	int			entityList[MAX_GENTITIES];
;840:	int			numListedEntities;
;841:	vec3_t		mins, maxs;
;842:	vec3_t		v;
;843:	vec3_t		dir;
;844:	int			i, e;
;845:
;846:	if (radius < 1) {
ADDRFP4 12
INDIRF4
CNSTF4 1065353216
GEF4 $360
line 847
;847:		radius = 1;
ADDRFP4 12
CNSTF4 1065353216
ASGNF4
line 848
;848:	}
LABELV $360
line 850
;849:
;850:	for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $362
line 851
;851:		mins[i] = origin[i] - radius;
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
line 852
;852:		maxs[i] = origin[i] + radius;
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
line 853
;853:	}
LABELV $363
line 850
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $362
line 855
;854:
;855:	numListedEntities = trap_EntitiesInBox(mins, maxs, entityList, MAX_GENTITIES);
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
line 857
;856:
;857:	for (e = 0; e < numListedEntities; e++) {
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRGP4 $369
JUMPV
LABELV $366
line 858
;858:		ent = &g_entities[entityList[e]];
ADDRLP4 4
ADDRLP4 32
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 40
ADDP4
INDIRI4
CNSTI4 832
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 860
;859:
;860:		if (!ent->takedamage) {
ADDRLP4 4
INDIRP4
CNSTI4 736
ADDP4
INDIRI4
CNSTI4 0
NEI4 $370
line 861
;861:			continue;
ADDRGP4 $367
JUMPV
LABELV $370
line 865
;862:		}
;863:
;864:		// dont hit things we have already hit
;865:		if (ent->kamikazeTime > level.time) {
ADDRLP4 4
INDIRP4
CNSTI4 784
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $372
line 866
;866:			continue;
ADDRGP4 $367
JUMPV
LABELV $372
line 870
;867:		}
;868:
;869:		// find the distance from the edge of the bounding box
;870:		for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $375
line 871
;871:			if (origin[i] < ent->r.absmin[i]) {
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
GEF4 $379
line 872
;872:				v[i] = ent->r.absmin[i] - origin[i];
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
line 873
;873:			} else if (origin[i] > ent->r.absmax[i]) {
ADDRGP4 $380
JUMPV
LABELV $379
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
LEF4 $381
line 874
;874:				v[i] = origin[i] - ent->r.absmax[i];
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
line 875
;875:			} else {
ADDRGP4 $382
JUMPV
LABELV $381
line 876
;876:				v[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
CNSTF4 0
ASGNF4
line 877
;877:			}
LABELV $382
LABELV $380
line 878
;878:		}
LABELV $376
line 870
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $375
line 880
;879:
;880:		dist = VectorLength(v);
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
line 881
;881:		if (dist >= radius) {
ADDRLP4 36
INDIRF4
ADDRFP4 12
INDIRF4
LTF4 $383
line 882
;882:			continue;
ADDRGP4 $367
JUMPV
LABELV $383
line 886
;883:		}
;884:
;885:		//		if( CanDamage (ent, origin) ) {
;886:		VectorSubtract(ent->r.currentOrigin, origin, dir);
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
line 889
;887:		// push the center of mass higher than the origin so players
;888:		// get knocked into the air more
;889:		dir[2] += 24;
ADDRLP4 20+8
ADDRLP4 20+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 890
;890:		G_Damage(ent, NULL, attacker, dir, origin, damage, DAMAGE_RADIUS | DAMAGE_NO_TEAM_PROTECTION, MOD_KAMIKAZE);
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
line 891
;891:		ent->kamikazeTime = level.time + 3000;
ADDRLP4 4
INDIRP4
CNSTI4 784
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 893
;892:		//		}
;893:	}
LABELV $367
line 857
ADDRLP4 32
ADDRLP4 32
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $369
ADDRLP4 32
INDIRI4
ADDRLP4 4136
INDIRI4
LTI4 $366
line 894
;894:}
LABELV $359
endproc KamikazeRadiusDamage 4180 32
proc KamikazeShockWave 4180 32
line 901
;895:
;896:/*
;897:===============
;898:KamikazeShockWave
;899:===============
;900:*/
;901:static void KamikazeShockWave(vec3_t origin, gentity_t *attacker, float damage, float push, float radius) {
line 911
;902:	float		dist;
;903:	gentity_t *ent;
;904:	int			entityList[MAX_GENTITIES];
;905:	int			numListedEntities;
;906:	vec3_t		mins, maxs;
;907:	vec3_t		v;
;908:	vec3_t		dir;
;909:	int			i, e;
;910:
;911:	if (radius < 1)
ADDRFP4 16
INDIRF4
CNSTF4 1065353216
GEF4 $390
line 912
;912:		radius = 1;
ADDRFP4 16
CNSTF4 1065353216
ASGNF4
LABELV $390
line 914
;913:
;914:	for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $392
line 915
;915:		mins[i] = origin[i] - radius;
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
line 916
;916:		maxs[i] = origin[i] + radius;
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
line 917
;917:	}
LABELV $393
line 914
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $392
line 919
;918:
;919:	numListedEntities = trap_EntitiesInBox(mins, maxs, entityList, MAX_GENTITIES);
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
line 921
;920:
;921:	for (e = 0; e < numListedEntities; e++) {
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRGP4 $399
JUMPV
LABELV $396
line 922
;922:		ent = &g_entities[entityList[e]];
ADDRLP4 4
ADDRLP4 32
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 40
ADDP4
INDIRI4
CNSTI4 832
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 925
;923:
;924:		// dont hit things we have already hit
;925:		if (ent->kamikazeShockTime > level.time) {
ADDRLP4 4
INDIRP4
CNSTI4 788
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $400
line 926
;926:			continue;
ADDRGP4 $397
JUMPV
LABELV $400
line 930
;927:		}
;928:
;929:		// find the distance from the edge of the bounding box
;930:		for (i = 0; i < 3; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $403
line 931
;931:			if (origin[i] < ent->r.absmin[i]) {
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
GEF4 $407
line 932
;932:				v[i] = ent->r.absmin[i] - origin[i];
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
line 933
;933:			} else if (origin[i] > ent->r.absmax[i]) {
ADDRGP4 $408
JUMPV
LABELV $407
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
LEF4 $409
line 934
;934:				v[i] = origin[i] - ent->r.absmax[i];
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
line 935
;935:			} else {
ADDRGP4 $410
JUMPV
LABELV $409
line 936
;936:				v[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
CNSTF4 0
ASGNF4
line 937
;937:			}
LABELV $410
LABELV $408
line 938
;938:		}
LABELV $404
line 930
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $403
line 940
;939:
;940:		dist = VectorLength(v);
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
line 941
;941:		if (dist >= radius) {
ADDRLP4 36
INDIRF4
ADDRFP4 16
INDIRF4
LTF4 $411
line 942
;942:			continue;
ADDRGP4 $397
JUMPV
LABELV $411
line 946
;943:		}
;944:
;945:		//		if( CanDamage (ent, origin) ) {
;946:		VectorSubtract(ent->r.currentOrigin, origin, dir);
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
line 947
;947:		dir[2] += 24;
ADDRLP4 20+8
ADDRLP4 20+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 948
;948:		G_Damage(ent, NULL, attacker, dir, origin, damage, DAMAGE_RADIUS | DAMAGE_NO_TEAM_PROTECTION, MOD_KAMIKAZE);
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
line 950
;949:		//
;950:		dir[2] = 0;
ADDRLP4 20+8
CNSTF4 0
ASGNF4
line 951
;951:		VectorNormalize(dir);
ADDRLP4 20
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 952
;952:		if (ent->client) {
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $417
line 953
;953:			ent->client->ps.velocity[0] = dir[0] * push;
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
line 954
;954:			ent->client->ps.velocity[1] = dir[1] * push;
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
line 955
;955:			ent->client->ps.velocity[2] = 100;
ADDRLP4 4
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1120403456
ASGNF4
line 956
;956:		}
LABELV $417
line 957
;957:		ent->kamikazeShockTime = level.time + 3000;
ADDRLP4 4
INDIRP4
CNSTI4 788
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 959
;958:		//		}
;959:	}
LABELV $397
line 921
ADDRLP4 32
ADDRLP4 32
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $399
ADDRLP4 32
INDIRI4
ADDRLP4 4136
INDIRI4
LTI4 $396
line 960
;960:}
LABELV $389
endproc KamikazeShockWave 4180 32
proc KamikazeDamage 56 20
line 967
;961:
;962:/*
;963:===============
;964:KamikazeDamage
;965:===============
;966:*/
;967:static void KamikazeDamage(gentity_t *self) {
line 973
;968:	int i;
;969:	float t;
;970:	gentity_t *ent;
;971:	vec3_t newangles;
;972:
;973:	self->count += 100;
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
line 975
;974:
;975:	if (self->count >= KAMI_SHOCKWAVE_STARTTIME) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
LTI4 $422
line 977
;976:		// shockwave push back
;977:		t = self->count - KAMI_SHOCKWAVE_STARTTIME;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 978
;978:		KamikazeShockWave(self->s.pos.trBase, self->activator, 25, 400, (int)(float)t * KAMI_SHOCKWAVE_MAXRADIUS / (KAMI_SHOCKWAVE_ENDTIME - KAMI_SHOCKWAVE_STARTTIME));
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
line 979
;979:	}
LABELV $422
line 981
;980:	//
;981:	if (self->count >= KAMI_EXPLODE_STARTTIME) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 250
LTI4 $424
line 983
;982:		// do our damage
;983:		t = self->count - KAMI_EXPLODE_STARTTIME;
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
line 984
;984:		KamikazeRadiusDamage(self->s.pos.trBase, self->activator, 400, (int)(float)t * KAMI_BOOMSPHERE_MAXRADIUS / (KAMI_IMPLODE_STARTTIME - KAMI_EXPLODE_STARTTIME));
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
line 985
;985:	}
LABELV $424
line 988
;986:
;987:	// either cycle or kill self
;988:	if (self->count >= KAMI_SHOCKWAVE_ENDTIME) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 2000
LTI4 $426
line 989
;989:		G_FreeEntity(self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 990
;990:		return;
ADDRGP4 $421
JUMPV
LABELV $426
line 992
;991:	}
;992:	self->nextthink = level.time + 100;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 995
;993:
;994:	// add earth quake effect
;995:	newangles[0] = crandom() * 2;
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
line 996
;996:	newangles[1] = crandom() * 2;
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
line 997
;997:	newangles[2] = 0;
ADDRLP4 4+8
CNSTF4 0
ASGNF4
line 998
;998:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 16
CNSTI4 0
ASGNI4
LABELV $431
line 999
;999:		ent = &g_entities[i];
ADDRLP4 0
ADDRLP4 16
INDIRI4
CNSTI4 832
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1000
;1000:		if (!ent->inuse)
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $435
line 1001
;1001:			continue;
ADDRGP4 $432
JUMPV
LABELV $435
line 1002
;1002:		if (!ent->client)
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $437
line 1003
;1003:			continue;
ADDRGP4 $432
JUMPV
LABELV $437
line 1005
;1004:
;1005:		if (ent->client->ps.groundEntityNum != ENTITYNUM_NONE) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $439
line 1006
;1006:			ent->client->ps.velocity[0] += crandom() * 120;
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
line 1007
;1007:			ent->client->ps.velocity[1] += crandom() * 120;
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
line 1008
;1008:			ent->client->ps.velocity[2] = 30 + random() * 25;
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
line 1009
;1009:		}
LABELV $439
line 1011
;1010:
;1011:		ent->client->ps.delta_angles[0] += ANGLE2SHORT(newangles[0] - self->movedir[0]);
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
line 1012
;1012:		ent->client->ps.delta_angles[1] += ANGLE2SHORT(newangles[1] - self->movedir[1]);
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
line 1013
;1013:		ent->client->ps.delta_angles[2] += ANGLE2SHORT(newangles[2] - self->movedir[2]);
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
line 1014
;1014:	}
LABELV $432
line 998
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 64
LTI4 $431
line 1015
;1015:	VectorCopy(newangles, self->movedir);
ADDRFP4 0
INDIRP4
CNSTI4 676
ADDP4
ADDRLP4 4
INDIRB
ASGNB 12
line 1016
;1016:}
LABELV $421
endproc KamikazeDamage 56 20
export G_StartKamikaze
proc G_StartKamikaze 32 32
line 1023
;1017:
;1018:/*
;1019:===============
;1020:G_StartKamikaze
;1021:===============
;1022:*/
;1023:void G_StartKamikaze(gentity_t *ent) {
line 1029
;1024:	gentity_t *explosion;
;1025:	gentity_t *te;
;1026:	vec3_t		snapped;
;1027:
;1028:	// start up the explosion logic
;1029:	explosion = G_Spawn();
ADDRLP4 20
ADDRGP4 G_Spawn
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 1031
;1030:
;1031:	explosion->s.eType = ET_EVENTS + EV_KAMIKAZE;
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 81
ASGNI4
line 1032
;1032:	explosion->eventTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1034
;1033:
;1034:	if (ent->client) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $445
line 1035
;1035:		VectorCopy(ent->s.pos.trBase, snapped);
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 1036
;1036:	} else {
ADDRGP4 $446
JUMPV
LABELV $445
line 1037
;1037:		VectorCopy(ent->activator->s.pos.trBase, snapped);
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
line 1038
;1038:	}
LABELV $446
line 1039
;1039:	SnapVector(snapped);		// save network bandwidth
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
line 1040
;1040:	G_SetOrigin(explosion, snapped);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_SetOrigin
CALLV
pop
line 1042
;1041:
;1042:	explosion->classname = "kamikaze";
ADDRLP4 0
INDIRP4
CNSTI4 524
ADDP4
ADDRGP4 $451
ASGNP4
line 1043
;1043:	explosion->s.pos.trType = TR_STATIONARY;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
CNSTI4 0
ASGNI4
line 1045
;1044:
;1045:	explosion->kamikazeTime = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 784
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1047
;1046:
;1047:	explosion->think = KamikazeDamage;
ADDRLP4 0
INDIRP4
CNSTI4 692
ADDP4
ADDRGP4 KamikazeDamage
ASGNP4
line 1048
;1048:	explosion->nextthink = level.time + 100;
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 1049
;1049:	explosion->count = 0;
ADDRLP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 0
ASGNI4
line 1050
;1050:	VectorClear(explosion->movedir);
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
line 1052
;1051:
;1052:	trap_LinkEntity(explosion);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 1054
;1053:
;1054:	if (ent->client) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $454
line 1056
;1055:		//
;1056:		explosion->activator = ent;
ADDRLP4 0
INDIRP4
CNSTI4 772
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 1058
;1057:		//
;1058:		ent->s.eFlags &= ~EF_KAMIKAZE;
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
line 1060
;1059:		// nuke the guy that used it
;1060:		G_Damage(ent, ent, ent, NULL, NULL, 100000, DAMAGE_NO_PROTECTION, MOD_KAMIKAZE);
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
line 1061
;1061:	} else {
ADDRGP4 $455
JUMPV
LABELV $454
line 1062
;1062:		if (!strcmp(ent->activator->classname, "bodyque")) {
ADDRFP4 0
INDIRP4
CNSTI4 772
ADDP4
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ARGP4
ADDRGP4 $458
ARGP4
ADDRLP4 24
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $456
line 1063
;1063:			explosion->activator = &g_entities[ent->activator->r.ownerNum];
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
CNSTI4 832
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1064
;1064:		} else {
ADDRGP4 $457
JUMPV
LABELV $456
line 1065
;1065:			explosion->activator = ent->activator;
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
line 1066
;1066:		}
LABELV $457
line 1067
;1067:	}
LABELV $455
line 1070
;1068:
;1069:	// play global sound at all clients
;1070:	te = G_TempEntity(snapped, EV_GLOBAL_TEAM_SOUND);
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
line 1071
;1071:	te->r.svFlags |= SVF_BROADCAST;
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
line 1072
;1072:	te->s.eventParm = GTS_KAMIKAZE;
ADDRLP4 16
INDIRP4
CNSTI4 184
ADDP4
CNSTI4 13
ASGNI4
line 1073
;1073:}
LABELV $443
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
LABELV $458
byte 1 98
byte 1 111
byte 1 100
byte 1 121
byte 1 113
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $451
byte 1 107
byte 1 97
byte 1 109
byte 1 105
byte 1 107
byte 1 97
byte 1 122
byte 1 101
byte 1 0

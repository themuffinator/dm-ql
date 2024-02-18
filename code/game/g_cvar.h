#ifdef EXTERN_G_CVAR
#define G_CVAR( vmCvar, cvarName, defaultString, cvarFlags, modificationCount, trackChange, teamShader ) extern vmCvar_t vmCvar;
#endif

#ifdef DECLARE_G_CVAR
#define G_CVAR( vmCvar, cvarName, defaultString, cvarFlags, modificationCount, trackChange, teamShader ) vmCvar_t vmCvar;
#endif

#ifdef G_CVAR_LIST
#define G_CVAR( vmCvar, cvarName, defaultString, cvarFlags, modificationCount, trackChange, teamShader ) { & vmCvar, cvarName, defaultString, cvarFlags, modificationCount, trackChange, teamShader },
#endif

// don't override the cheat state set by the system
G_CVAR(g_cheats, "sv_cheats", "", 0, 0, qfalse, qfalse)

//G_CVAR( g_restarted, "g_restarted", "0", CVAR_ROM, 0, qfalse, qfalse )
G_CVAR(g_mapname, "mapname", "", CVAR_SERVERINFO | CVAR_ROM, 0, qfalse, qfalse)
G_CVAR(sv_fps, "sv_fps", "30", CVAR_ARCHIVE, 0, qfalse, qfalse)

// latched vars
G_CVAR(g_gametype, "g_gametype", "0", CVAR_SERVERINFO | CVAR_USERINFO | CVAR_LATCH, 0, qfalse, qfalse)

G_CVAR(g_maxclients, "sv_maxclients", "8", CVAR_SERVERINFO | CVAR_LATCH | CVAR_ARCHIVE, 0, qfalse, qfalse) // allow this many total, including spectators
G_CVAR(g_maxGameClients, "g_maxGameClients", "0", CVAR_SERVERINFO | CVAR_LATCH | CVAR_ARCHIVE, 0, qfalse, qfalse) // allow this many active

// change anytime vars
G_CVAR(g_dmflags, "dmflags", "0", CVAR_SERVERINFO | CVAR_ARCHIVE, 0, qtrue, qfalse)
G_CVAR(g_fraglimit, "fraglimit", "20", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART, 0, qtrue, qfalse)
G_CVAR(g_timelimit, "timelimit", "0", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART, 0, qtrue, qfalse)
G_CVAR(g_capturelimit, "capturelimit", "8", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART, 0, qtrue, qfalse)

G_CVAR(g_synchronousClients, "g_synchronousClients", "0", CVAR_SYSTEMINFO, 0, qfalse, qfalse)

G_CVAR(g_friendlyFire, "g_friendlyFire", "0", CVAR_ARCHIVE, 0, qtrue, qfalse)

G_CVAR(g_autoJoin, "g_autoJoin", "1", CVAR_ARCHIVE, 0, qfalse, qfalse)
G_CVAR(g_teamForceBalance, "g_teamForceBalance", "0", CVAR_ARCHIVE, 0, qfalse, qfalse)

G_CVAR(g_warmup, "g_warmup", "20", CVAR_ARCHIVE, 0, qtrue, qfalse)
G_CVAR(g_log, "g_log", "games.log", CVAR_ARCHIVE, 0, qfalse, qfalse)
G_CVAR(g_logSync, "g_logSync", "0", CVAR_ARCHIVE, 0, qfalse, qfalse)

G_CVAR(g_password, "g_password", "", CVAR_USERINFO, 0, qfalse, qfalse)

G_CVAR(g_banIPs, "g_banIPs", "", CVAR_ARCHIVE, 0, qfalse, qfalse)
G_CVAR(g_filterBan, "g_filterBan", "1", CVAR_ARCHIVE, 0, qfalse, qfalse)

G_CVAR(g_needpass, "g_needpass", "0", CVAR_SERVERINFO | CVAR_ROM, 0, qfalse, qfalse)

G_CVAR(g_dedicated, "dedicated", "0", 0, 0, qfalse, qfalse)

G_CVAR(g_speed, "g_speed", "320", 0, 0, qtrue, qfalse)
G_CVAR(g_gravity, "g_gravity", "800", 0, 0, qtrue, qfalse)
G_CVAR(g_knockback, "g_knockback", "1000", 0, 0, qtrue, qfalse)
G_CVAR(g_quadDamageFactor, "g_quadDamageFactor", "3", 0, 0, qtrue, qfalse)
G_CVAR(g_weaponRespawn, "g_weaponRespawn", "5", 0, 0, qtrue, qfalse)
G_CVAR(g_weaponTeamRespawn, "g_weaponTeamRespawn", "30", 0, 0, qtrue, qfalse)
G_CVAR(g_respawn_delay_min, "g_respawn_delay_min", "2100", 0, 0, qtrue, qfalse)
G_CVAR(g_respawn_delay_max, "g_respawn_delay_max", "2400", 0, 0, qtrue, qfalse)
G_CVAR(g_inactivity, "g_inactivity", "0", 0, 0, qtrue, qfalse)
G_CVAR(g_debugMove, "g_debugMove", "0", 0, 0, qfalse, qfalse)
G_CVAR(g_debugDamage, "g_debugDamage", "0", 0, 0, qfalse, qfalse)
G_CVAR(g_debugAlloc, "g_debugAlloc", "0", 0, 0, qfalse, qfalse)
G_CVAR(g_motd, "g_motd", "", 0, 0, qfalse, qfalse)
G_CVAR(g_blood, "com_blood", "1", 0, 0, qfalse, qfalse)

G_CVAR(g_allowKill, "g_allowKill", "1000", CVAR_ARCHIVE, 0, qfalse, qfalse)
G_CVAR(g_allowVote, "g_allowVote", "1", CVAR_ARCHIVE, 0, qfalse, qfalse)
G_CVAR(g_allowSpecVote, "g_allowSpecVote", "0", CVAR_ARCHIVE, 0, qfalse, qfalse)
G_CVAR(g_allowVoteMidGame, "g_allowVoteMidGame", "0", CVAR_ARCHIVE, 0, qfalse, qfalse)
G_CVAR(g_voteLimit, "g_voteLimit", "0", CVAR_ARCHIVE, 0, qfalse, qfalse)
G_CVAR(g_voteDelay, "g_voteDelay", "0", CVAR_ARCHIVE, 0, qfalse, qfalse)
//G_CVAR(g_voteFlags, "g_voteFlags", "0", CVAR_ARCHIVE, 0, qfalse, qfalse)
G_CVAR(g_listEntity, "g_listEntity", "0", 0, 0, qfalse, qfalse)

G_CVAR(g_unlagged, "g_unlagged", "1", CVAR_SERVERINFO | CVAR_ARCHIVE, 0, qfalse, qfalse)
G_CVAR(g_predictPVS, "g_predictPVS", "0", CVAR_ARCHIVE, 0, qfalse, qfalse)

G_CVAR(g_obeliskHealth, "g_obeliskHealth", "2500", 0, 0, qfalse, qfalse)
G_CVAR(g_obeliskRegenPeriod, "g_obeliskRegenPeriod", "1", 0, 0, qfalse, qfalse)
G_CVAR(g_obeliskRegenAmount, "g_obeliskRegenAmount", "15", 0, 0, qfalse, qfalse)
G_CVAR(g_obeliskRespawnDelay, "g_obeliskRespawnDelay", "10", CVAR_SERVERINFO, 0, qfalse, qfalse)

G_CVAR(g_cubeTimeout, "g_cubeTimeout", "30", 0, 0, qfalse, qfalse)
G_CVAR(g_redteam, "g_redteam", "Stroggs", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO, 0, qtrue, qtrue)
G_CVAR(g_blueteam, "g_blueteam", "Pagans", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO, 0, qtrue, qtrue)

G_CVAR(g_enableDust, "g_enableDust", "0", CVAR_SERVERINFO, 0, qtrue, qfalse)
G_CVAR(g_enableBreath, "g_enableBreath", "0", CVAR_SERVERINFO, 0, qtrue, qfalse)
G_CVAR(g_proxMineTimeout, "g_proxMineTimeout", "20", 0, 0, qfalse, qfalse)
G_CVAR(g_smoothClients, "g_smoothClients", "1", 0, 0, qfalse, qfalse)
G_CVAR(pmove_fixed, "pmove_fixed", "0", CVAR_SYSTEMINFO, 0, qfalse, qfalse)
G_CVAR(pmove_msec, "pmove_msec", "8", CVAR_SYSTEMINFO, 0, qfalse, qfalse)

G_CVAR(g_rotation, "g_rotation", "0", CVAR_ARCHIVE, 0, qfalse, qfalse)

G_CVAR(armor_tiered, "armor_tiered", "0", 0, 0, qfalse, qfalse)

G_CVAR(g_startingWeapons, "g_startingWeapons", "3", 0, 0, qtrue, qfalse)
G_CVAR(g_startingAmmo_g, "g_startingAmmo_g", "-1", 0, 0, qfalse, qfalse)
G_CVAR(g_startingAmmo_mg, "g_startingAmmo_mg", "100", 0, 0, qfalse, qfalse)
G_CVAR(g_startingAmmo_sg, "g_startingAmmo_sg", "10", 0, 0, qfalse, qfalse)
G_CVAR(g_startingAmmo_gl, "g_startingAmmo_gl", "10", 0, 0, qfalse, qfalse)
G_CVAR(g_startingAmmo_rl, "g_startingAmmo_rl", "5", 0, 0, qfalse, qfalse)
G_CVAR(g_startingAmmo_lg, "g_startingAmmo_lg", "100", 0, 0, qfalse, qfalse)
G_CVAR(g_startingAmmo_rg, "g_startingAmmo_rg", "10", 0, 0, qfalse, qfalse)
G_CVAR(g_startingAmmo_pg, "g_startingAmmo_pg", "50", 0, 0, qfalse, qfalse)
G_CVAR(g_startingAmmo_bfg, "g_startingAmmo_bfg", "10", 0, 0, qfalse, qfalse)
G_CVAR(g_startingAmmo_gh, "g_startingAmmo_gh", "-1", 0, 0, qfalse, qfalse)
G_CVAR(g_startingAmmo_ng, "g_startingAmmo_ng", "10", 0, 0, qfalse, qfalse)
G_CVAR(g_startingAmmo_pl, "g_startingAmmo_pl", "5", 0, 0, qfalse, qfalse)
G_CVAR(g_startingAmmo_cg, "g_startingAmmo_cg", "100", 0, 0, qfalse, qfalse)
G_CVAR(g_startingAmmo_hmg, "g_startingAmmo_hmg", "50", 0, 0, qfalse, qfalse)

G_CVAR(g_ammoRespawn, "g_ammoRespawn", "40", 0, 0, qfalse, qfalse)
G_CVAR(g_ammoPack, "g_ammoPack", "0", 0, 0, qfalse, qfalse)

G_CVAR(g_damage_g, "g_damage_g", "50", 0, 0, qfalse, qfalse)
G_CVAR(g_damage_mg, "g_damage_mg", "5", 0, 0, qfalse, qfalse)
G_CVAR(g_damage_sg, "g_damage_sg", "5", 0, 0, qfalse, qfalse)
G_CVAR(g_damage_gl, "g_damage_gl", "100", 0, 0, qfalse, qfalse)
G_CVAR(g_damage_rl, "g_damage_rl", "100", 0, 0, qfalse, qfalse)
G_CVAR(g_damage_lg, "g_damage_lg", "6", 0, 0, qfalse, qfalse)
G_CVAR(g_damage_rg, "g_damage_rg", "80", 0, 0, qfalse, qfalse)
G_CVAR(g_damage_pg, "g_damage_pg", "20", 0, 0, qfalse, qfalse)
G_CVAR(g_damage_bfg, "g_damage_bfg", "100", 0, 0, qfalse, qfalse)
G_CVAR(g_damage_gh, "g_damage_gh", "10", 0, 0, qfalse, qfalse)
G_CVAR(g_damage_ng, "g_damage_ng", "12", 0, 0, qfalse, qfalse)
G_CVAR(g_damage_pl, "g_damage_pl", "0", 0, 0, qfalse, qfalse)
G_CVAR(g_damage_cg, "g_damage_cg", "8", 0, 0, qfalse, qfalse)
G_CVAR(g_damage_hmg, "g_damage_hmg", "8", 0, 0, qfalse, qfalse)
//G_CVAR(g_damage_sg_outer, "g_damage_sg_outer", "5", 0, 0, qfalse, qfalse)
//G_CVAR(g_damage_sg_falloff, "g_damage_sg_falloff", "0", 0, 0, qfalse, qfalse)
//G_CVAR(g_damage_lg_falloff, "g_damage_lg_falloff", "0", 0, 0, qfalse, qfalse)


G_CVAR(g_splashradius_bfg, "g_splashradius_bfg", "80", 0, 0, qfalse, qfalse)
G_CVAR(g_splashradius_gl, "g_splashradius_gl", "150", 0, 0, qfalse, qfalse)
G_CVAR(g_splashradius_pg, "g_splashradius_pg", "20", 0, 0, qfalse, qfalse)
G_CVAR(g_splashradius_pl, "g_splashradius_pl", "150", 0, 0, qfalse, qfalse)
G_CVAR(g_splashradius_rl, "g_splashradius_rl", "120", 0, 0, qfalse, qfalse)
//G_CVAR(g_splashdamageOffset, "g_splashdamageOffset", "0.05", 0, 0, qfalse, qfalse)
G_CVAR(g_splashdamage_bfg, "g_splashdamage_bfg", "100", 0, 0, qfalse, qfalse)
G_CVAR(g_splashdamage_gl, "g_splashdamage_gl", "100", 0, 0, qfalse, qfalse)
G_CVAR(g_splashdamage_pg, "g_splashdamage_pg", "15", 0, 0, qfalse, qfalse)
G_CVAR(g_splashdamage_pl, "g_splashdamage_pl", "100", 0, 0, qfalse, qfalse)
G_CVAR(g_splashdamage_rl, "g_splashdamage_rl", "84", 0, 0, qfalse, qfalse)

G_CVAR(g_velocity_bfg, "g_velocity_bfg", "1800", 0, 0, qfalse, qfalse)
G_CVAR(g_velocity_gl, "g_velocity_gl", "700", 0, 0, qfalse, qfalse)
G_CVAR(g_velocity_gh, "g_velocity_gh", "1800", 0, 0, qfalse, qfalse)
G_CVAR(g_velocity_pg, "g_velocity_pg", "2000", 0, 0, qfalse, qfalse)
G_CVAR(g_velocity_pl, "g_velocity_pl", "700", 0, 0, qfalse, qfalse)
G_CVAR(g_velocity_rl, "g_velocity_rl", "1000", 0, 0, qfalse, qfalse)

G_CVAR(g_knockback_g, "g_knockback_g", "1", 0, 0, qfalse, qfalse)
G_CVAR(g_knockback_mg, "g_knockback_mg", "1", 0, 0, qfalse, qfalse)
G_CVAR(g_knockback_sg, "g_knockback_sg", "1", 0, 0, qfalse, qfalse)
G_CVAR(g_knockback_gl, "g_knockback_gl", "1.10", 0, 0, qfalse, qfalse)
G_CVAR(g_knockback_rl, "g_knockback_rl", "0.90", 0, 0, qfalse, qfalse)
G_CVAR(g_knockback_rl_self, "g_knockback_rl_self", "1.10", 0, 0, qfalse, qfalse)
G_CVAR(g_knockback_lg, "g_knockback_lg", "6", 0, 0, qfalse, qfalse)
G_CVAR(g_knockback_rg, "g_knockback_rg", "0.85", 0, 0, qfalse, qfalse)
G_CVAR(g_knockback_pg, "g_knockback_pg", "1.10", 0, 0, qfalse, qfalse)
G_CVAR(g_knockback_pg_self, "g_knockback_pg_self", "1.30", 0, 0, qfalse, qfalse)
G_CVAR(g_knockback_bfg, "g_knockback_bfg", "1", 0, 0, qfalse, qfalse)
G_CVAR(g_knockback_gh, "g_knockback_gh", "-5", 0, 0, qfalse, qfalse)
G_CVAR(g_knockback_ng, "g_knockback_ng", "1", 0, 0, qfalse, qfalse)
G_CVAR(g_knockback_pl, "g_knockback_pl", "1", 0, 0, qfalse, qfalse)
G_CVAR(g_knockback_cg, "g_knockback_cg", "1", 0, 0, qfalse, qfalse)
G_CVAR(g_knockback_hmg, "g_knockback_hmg", "1", 0, 0, qfalse, qfalse)
G_CVAR(g_knockback_z, "g_knockback_z", "24", 0, 0, qfalse, qfalse)
G_CVAR(g_knockback_z_self, "g_knockback_z_self", "24", 0, 0, qfalse, qfalse)

G_CVAR(g_training, "g_training", "0", CVAR_ROM, 0, qfalse, qfalse)
#undef G_CVAR

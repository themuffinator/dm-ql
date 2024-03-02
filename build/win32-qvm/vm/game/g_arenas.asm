export UpdateTournamentInfo
code
proc UpdateTournamentInfo 1112 68
file "..\..\..\..\code\game\g_arenas.c"
line 14
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3://
;4:// g_arenas.c
;5://
;6:
;7:#include "g_local.h"
;8:
;9:/*
;10:==================
;11:UpdateTournamentInfo
;12:==================
;13:*/
;14:void UpdateTournamentInfo(void) {
line 25
;15:	int			i;
;16:	gentity_t *player;
;17:	int			playerClientNum;
;18:	int			n, accuracy, perfect, msglen;
;19:	int score1, score2;
;20:	qboolean won;
;21:	char		buf[32];
;22:	char		msg[MAX_STRING_CHARS];
;23:
;24:	// find the real player
;25:	player = NULL;
ADDRLP4 40
CNSTP4 0
ASGNP4
line 26
;26:	for (i = 0; i < level.maxclients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $59
JUMPV
LABELV $56
line 27
;27:		player = &g_entities[i];
ADDRLP4 40
ADDRLP4 0
INDIRI4
CNSTI4 832
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 28
;28:		if (!player->inuse) {
ADDRLP4 40
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $61
line 29
;29:			continue;
ADDRGP4 $57
JUMPV
LABELV $61
line 31
;30:		}
;31:		if (!(player->r.svFlags & SVF_BOT)) {
ADDRLP4 40
INDIRP4
CNSTI4 424
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $63
line 32
;32:			break;
ADDRGP4 $58
JUMPV
LABELV $63
line 34
;33:		}
;34:	}
LABELV $57
line 26
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $59
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $56
LABELV $58
line 36
;35:	// this should never happen!
;36:	if (!player || i == level.maxclients) {
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $68
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
NEI4 $65
LABELV $68
line 37
;37:		return;
ADDRGP4 $55
JUMPV
LABELV $65
line 39
;38:	}
;39:	playerClientNum = i;
ADDRLP4 1072
ADDRLP4 0
INDIRI4
ASGNI4
line 41
;40:
;41:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 43
;42:
;43:	if (level.clients[playerClientNum].sess.sessionTeam == TEAM_SPECTATOR) {
ADDRLP4 1072
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
NEI4 $69
line 44
;44:		Com_sprintf(msg, sizeof(msg), "postgame %i %i 0 0 0 0 0 0 0 0 0 0 0", level.numNonSpectatorClients, playerClientNum);
ADDRLP4 44
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $71
ARGP4
ADDRGP4 level+80
INDIRI4
ARGI4
ADDRLP4 1072
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 45
;45:	} else {
ADDRGP4 $70
JUMPV
LABELV $69
line 46
;46:		if (player->client->accuracy_shots) {
ADDRLP4 40
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 712
ADDP4
INDIRI4
CNSTI4 0
EQI4 $73
line 47
;47:			accuracy = player->client->accuracy_hits * 100 / player->client->accuracy_shots;
ADDRLP4 1080
ADDRLP4 40
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 716
ADDP4
INDIRI4
CNSTI4 100
MULI4
ADDRLP4 40
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 712
ADDP4
INDIRI4
DIVI4
ASGNI4
line 48
;48:		} else {
ADDRGP4 $74
JUMPV
LABELV $73
line 49
;49:			accuracy = 0;
ADDRLP4 1080
CNSTI4 0
ASGNI4
line 50
;50:		}
LABELV $74
line 51
;51:		won = qfalse;
ADDRLP4 1076
CNSTI4 0
ASGNI4
line 52
;52:		if (g_gametype.integer >= GT_CTF) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
LTI4 $75
line 53
;53:			score1 = level.teamScores[TEAM_RED];
ADDRLP4 1088
ADDRGP4 level+48+4
INDIRI4
ASGNI4
line 54
;54:			score2 = level.teamScores[TEAM_BLUE];
ADDRLP4 1092
ADDRGP4 level+48+8
INDIRI4
ASGNI4
line 55
;55:			if (level.clients[playerClientNum].sess.sessionTeam == TEAM_RED) {
ADDRLP4 1072
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 1
NEI4 $82
line 56
;56:				won = (level.teamScores[TEAM_RED] > level.teamScores[TEAM_BLUE]);
ADDRGP4 level+48+4
INDIRI4
ADDRGP4 level+48+8
INDIRI4
LEI4 $89
ADDRLP4 1096
CNSTI4 1
ASGNI4
ADDRGP4 $90
JUMPV
LABELV $89
ADDRLP4 1096
CNSTI4 0
ASGNI4
LABELV $90
ADDRLP4 1076
ADDRLP4 1096
INDIRI4
ASGNI4
line 57
;57:			} else {
ADDRGP4 $76
JUMPV
LABELV $82
line 58
;58:				won = (level.teamScores[TEAM_BLUE] > level.teamScores[TEAM_RED]);
ADDRGP4 level+48+8
INDIRI4
ADDRGP4 level+48+4
INDIRI4
LEI4 $96
ADDRLP4 1096
CNSTI4 1
ASGNI4
ADDRGP4 $97
JUMPV
LABELV $96
ADDRLP4 1096
CNSTI4 0
ASGNI4
LABELV $97
ADDRLP4 1076
ADDRLP4 1096
INDIRI4
ASGNI4
line 59
;59:			}
line 60
;60:		} else {
ADDRGP4 $76
JUMPV
LABELV $75
line 61
;61:			if (&level.clients[playerClientNum] == &level.clients[level.sortedClients[0]]) {
ADDRLP4 1096
ADDRGP4 level
INDIRP4
ASGNP4
ADDRLP4 1072
INDIRI4
CNSTI4 1636
MULI4
ADDRLP4 1096
INDIRP4
ADDP4
CVPU4 4
ADDRGP4 level+88
INDIRI4
CNSTI4 1636
MULI4
ADDRLP4 1096
INDIRP4
ADDP4
CVPU4 4
NEU4 $98
line 62
;62:				won = qtrue;
ADDRLP4 1076
CNSTI4 1
ASGNI4
line 63
;63:				score1 = level.clients[level.sortedClients[0]].ps.persistant[PERS_SCORE];
ADDRLP4 1088
ADDRGP4 level+88
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
line 64
;64:				score2 = level.clients[level.sortedClients[1]].ps.persistant[PERS_SCORE];
ADDRLP4 1092
ADDRGP4 level+88+4
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
line 65
;65:			} else {
ADDRGP4 $99
JUMPV
LABELV $98
line 66
;66:				score2 = level.clients[level.sortedClients[0]].ps.persistant[PERS_SCORE];
ADDRLP4 1092
ADDRGP4 level+88
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
line 67
;67:				score1 = level.clients[level.sortedClients[1]].ps.persistant[PERS_SCORE];
ADDRLP4 1088
ADDRGP4 level+88+4
INDIRI4
CNSTI4 1636
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
line 68
;68:			}
LABELV $99
line 69
;69:		}
LABELV $76
line 70
;70:		if (won && player->client->ps.persistant[PERS_KILLED] == 0) {
ADDRLP4 1076
INDIRI4
CNSTI4 0
EQI4 $107
ADDRLP4 40
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 280
ADDP4
INDIRI4
CNSTI4 0
NEI4 $107
line 71
;71:			perfect = 1;
ADDRLP4 1084
CNSTI4 1
ASGNI4
line 72
;72:		} else {
ADDRGP4 $108
JUMPV
LABELV $107
line 73
;73:			perfect = 0;
ADDRLP4 1084
CNSTI4 0
ASGNI4
line 74
;74:		}
LABELV $108
line 75
;75:		Com_sprintf(msg, sizeof(msg), "postgame %i %i %i %i %i %i %i %i %i %i %i %i %i %i", level.numNonSpectatorClients, playerClientNum, accuracy,
ADDRLP4 44
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $109
ARGP4
ADDRGP4 level+80
INDIRI4
ARGI4
ADDRLP4 1072
INDIRI4
ARGI4
ADDRLP4 1080
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 284
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 288
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 300
ADDP4
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ARGI4
ADDRLP4 1084
INDIRI4
ARGI4
ADDRLP4 1088
INDIRI4
ARGI4
ADDRLP4 1092
INDIRI4
ARGI4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 79
;76:			player->client->ps.persistant[PERS_IMPRESSIVE_COUNT], player->client->ps.persistant[PERS_EXCELLENT_COUNT], player->client->ps.persistant[PERS_DEFEND_COUNT],
;77:			player->client->ps.persistant[PERS_ASSIST_COUNT], player->client->ps.persistant[PERS_GAUNTLET_FRAG_COUNT], player->client->ps.persistant[PERS_SCORE],
;78:			perfect, score1, score2, level.time, player->client->ps.persistant[PERS_CAPTURES]);
;79:	}
LABELV $70
line 81
;80:
;81:	msglen = (int)strlen(msg);
ADDRLP4 44
ARGP4
ADDRLP4 1096
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1068
ADDRLP4 1096
INDIRI4
ASGNI4
line 82
;82:	for (i = 0; i < level.numNonSpectatorClients; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $115
JUMPV
LABELV $112
line 83
;83:		n = level.sortedClients[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+88
ADDP4
INDIRI4
ASGNI4
line 84
;84:		Com_sprintf(buf, sizeof(buf), " %i %i %i", n, level.clients[n].ps.persistant[PERS_RANK], level.clients[n].ps.persistant[PERS_SCORE]);
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $118
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 1104
ADDRGP4 level
INDIRP4
ASGNP4
ADDRLP4 4
INDIRI4
CNSTI4 1636
MULI4
ADDRLP4 1104
INDIRP4
ADDP4
CNSTI4 256
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
CNSTI4 1636
MULI4
ADDRLP4 1104
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLI4
pop
line 85
;85:		msglen += (int)strlen(buf);
ADDRLP4 8
ARGP4
ADDRLP4 1108
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1068
ADDRLP4 1068
INDIRI4
ADDRLP4 1108
INDIRI4
ADDI4
ASGNI4
line 86
;86:		if (msglen >= sizeof(msg) - 1) {
ADDRLP4 1068
INDIRI4
CVIU4 4
CNSTU4 1023
LTU4 $119
line 87
;87:			break;
ADDRGP4 $114
JUMPV
LABELV $119
line 89
;88:		}
;89:		strcat(msg, buf);
ADDRLP4 44
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 strcat
CALLP4
pop
line 90
;90:	}
LABELV $113
line 82
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $115
ADDRLP4 0
INDIRI4
ADDRGP4 level+80
INDIRI4
LTI4 $112
LABELV $114
line 91
;91:	trap_SendConsoleCommand(EXEC_APPEND, msg);
CNSTI4 2
ARGI4
ADDRLP4 44
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 92
;92:}
LABELV $55
endproc UpdateTournamentInfo 1112 68
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
LABELV $118
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
LABELV $109
byte 1 112
byte 1 111
byte 1 115
byte 1 116
byte 1 103
byte 1 97
byte 1 109
byte 1 101
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
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $71
byte 1 112
byte 1 111
byte 1 115
byte 1 116
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 48
byte 1 32
byte 1 48
byte 1 32
byte 1 48
byte 1 32
byte 1 48
byte 1 32
byte 1 48
byte 1 32
byte 1 48
byte 1 32
byte 1 48
byte 1 32
byte 1 48
byte 1 32
byte 1 48
byte 1 32
byte 1 48
byte 1 32
byte 1 48
byte 1 0

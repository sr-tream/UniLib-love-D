module defines;

enum FCR_NONE =			0x0;
enum FCR_BOLD =			0x1;
enum FCR_ITALICS =		0x2;
enum FCR_BORDER =		0x4;
enum FCR_UNDERLINE =	0x8;
enum FCR_STRIKEOUT =	0x10;

enum RAKNET_MAX_PACKET =	256;

enum RPCEnumeration
{
	RPC_ClickPlayer					= 23,
	RPC_ClientJoin					= 25,
	RPC_EnterVehicle				= 26,
	RPC_EnterEditObject				= 27,
	RPC_ScriptCash					= 31,
	RPC_ServerCommand				= 50,
	RPC_Spawn						= 52,
	RPC_Death						= 53,
	RPC_NPCJoin						= 54,
	RPC_DialogResponse				= 62,
	RPC_ClickTextDraw				= 83,
	RPC_SCMEvent					= 96,
	RPC_Chat						= 101,
	RPC_SrvNetStats					= 102,
	RPC_ClientCheck					= 103,
	RPC_DamageVehicle				= 106,
	RPC_GiveTakeDamage				= 115,
	RPC_EditAttachedObject			= 116,
	RPC_EditObject					= 117,
	RPC_SetInteriorId				= 118,
	RPC_MapMarker					= 119,
	RPC_RequestClass				= 128,
	RPC_RequestSpawn				= 129,
	RPC_PickedUpPickup				= 131,
	RPC_MenuSelect					= 132,
	RPC_VehicleDestroyed			= 136,
	RPC_MenuQuit					= 140,
	RPC_ExitVehicle					= 154,
	RPC_UpdateScoresPingsIPs		= 155,

	// server RPC's
	RPC_SetPlayerName				= 11,
	RPC_SetPlayerPos				= 12,
	RPC_SetPlayerPosFindZ			= 13,
	RPC_SetPlayerHealth				= 14,
	RPC_TogglePlayerControllable	= 15,
	RPC_PlaySound					= 16,
	RPC_SetPlayerWorldBounds		= 17,
	RPC_GivePlayerMoney				= 18,
	RPC_SetPlayerFacingAngle		= 19,
	RPC_ResetPlayerMoney			= 20,
	RPC_ResetPlayerWeapons			= 21,
	RPC_GivePlayerWeapon			= 22,
	RPC_SetVehicleParamsEx			= 24,
	RPC_CancelEdit					= 28,
	RPC_SetPlayerTime				= 29,
	RPC_ToggleClock					= 30,
	RPC_WorldPlayerAdd				= 32,
	RPC_SetPlayerShopName			= 33,
	RPC_SetPlayerSkillLevel			= 34,
	RPC_SetPlayerDrunkLevel			= 35,
	RPC_Create3DTextLabel			= 36,
	RPC_DisableCheckpoint			= 37,
	RPC_SetRaceCheckpoint			= 38,
	RPC_DisableRaceCheckpoint		= 39,
	RPC_GameModeRestart				= 40,
	RPC_PlayAudioStream				= 41,
	RPC_StopAudioStream				= 42,
	RPC_RemoveBuildingForPlayer		= 43,
	RPC_CreateObject				= 44,
	RPC_SetObjectPos				= 45,
	RPC_SetObjectRot				= 46,
	RPC_DestroyObject				= 47,
	RPC_DeathMessage				= 55,
	RPC_SetPlayerMapIcon			= 56,
	RPC_RemoveVehicleComponent		= 57,
	RPC_Update3DTextLabel			= 58,
	RPC_ChatBubble					= 59,
	RPC_UpdateSystemTime			= 60,
	RPC_ShowDialog					= 61,
	RPC_DestroyPickup				= 63,
	RPC_WeaponPickupDestroy			= 64,
	RPC_LinkVehicleToInterior		= 65,
	RPC_SetPlayerArmour				= 66,
	RPC_SetPlayerArmedWeapon		= 67,
	RPC_SetSpawnInfo				= 68,
	RPC_SetPlayerTeam				= 69,
	RPC_PutPlayerInVehicle			= 70,
	RPC_RemovePlayerFromVehicle		= 71,
	RPC_SetPlayerColor				= 72,
	RPC_DisplayGameText				= 73,
	RPC_ForceClassSelection			= 74,
	RPC_AttachObjectToPlayer		= 75,
	RPC_InitMenu					= 76,
	RPC_ShowMenu					= 77,
	RPC_HideMenu					= 78,
	RPC_CreateExplosion				= 79,
	RPC_ShowPlayerNameTagForPlayer	= 80,
	RPC_AttachCameraToObject		= 81,
	RPC_InterpolateCamera			= 82,
	RPC_SetObjectMaterial			= 84,
	RPC_GangZoneStopFlash			= 85,
	RPC_ApplyAnimation				= 86,
	RPC_ClearAnimations				= 87,
	RPC_SetPlayerSpecialAction		= 88,
	RPC_SetPlayerFightingStyle		= 89,
	RPC_SetPlayerVelocity			= 90,
	RPC_SetVehicleVelocity			= 91,
	RPC_SetPlayerDrunkVisuals		= 92,
	RPC_ClientMessage				= 93,
	RPC_SetWorldTime				= 94,
	RPC_CreatePickup				= 95,
	RPC_SetVehicleTireStatus		= 98,
	RPC_MoveObject					= 99,
	RPC_EnableStuntBonusForPlayer	= 104,
	RPC_TextDrawSetString			= 105,
	RPC_SetCheckpoint				= 107,
	RPC_GangZoneCreate				= 108,
	RPC_PlayCrimeReport				= 112,
	RPC_SetPlayerAttachedObject		= 113,
	RPC_GangZoneDestroy				= 120,
	RPC_GangZoneFlash				= 121,
	RPC_StopObject					= 122,
	RPC_SetNumberPlate				= 123,
	RPC_TogglePlayerSpectating		= 124,
	RPC_PlayerSpectatePlayer		= 126,
	RPC_PlayerSpectateVehicle		= 127,
	RPC_SetPlayerWantedLevel		= 133,
	RPC_ShowTextDraw				= 134,
	RPC_TextDrawHideForPlayer		= 135,
	RPC_ServerJoin					= 137,
	RPC_ServerQuit					= 138,
	RPC_InitGame					= 139,
	RPC_RemovePlayerMapIcon			= 144,
	RPC_SetPlayerAmmo				= 145,
	RPC_SetPlayerGravity			= 146,
	RPC_SetVehicleHealth			= 147,
	RPC_AttachTrailerToVehicle		= 148,
	RPC_DetachTrailerFromVehicle	= 149,
	RPC_SetPlayerDrunkHandling		= 150,
	RPC_DestroyPickups				= 151,
	RPC_SetWeather					= 152,
	RPC_SetPlayerSkin				= 153,
	RPC_SetPlayerInterior			= 156,
	RPC_SetPlayerCameraPos			= 157,
	RPC_SetPlayerCameraLookAt		= 158,
	RPC_SetVehiclePos				= 159,
	RPC_SetVehicleZAngle			= 160,
	RPC_SetVehicleParamsForPlayer	= 161,
	RPC_SetCameraBehindPlayer		= 162,
	RPC_WorldPlayerRemove			= 163,
	RPC_WorldVehicleAdd				= 164,
	RPC_WorldVehicleRemove			= 165,
	RPC_WorldPlayerDeath 			= 166,
};

enum PacketEnumeration
{
	ID_INTERNAL_PING = 6,
	ID_PING,
	ID_PING_OPEN_CONNECTIONS,
	ID_CONNECTED_PONG,
	ID_REQUEST_STATIC_DATA,
	ID_CONNECTION_REQUEST,
	ID_AUTH_KEY,
	ID_BROADCAST_PINGS = 15,
	ID_SECURED_CONNECTION_RESPONSE,
	ID_SECURED_CONNECTION_CONFIRMATION,
	ID_RPC_MAPPING,
	ID_SET_RANDOM_NUMBER_SEED = 21,
	ID_RPC,
	ID_RPC_REPLY,
	ID_DETECT_LOST_CONNECTIONS,
	ID_OPEN_CONNECTION_REQUEST,
	ID_OPEN_CONNECTION_REPLY,
	ID_RSA_PUBLIC_KEY_MISMATCH = 28,
	ID_CONNECTION_ATTEMPT_FAILED,
	ID_NEW_INCOMING_CONNECTION,
	ID_NO_FREE_INCOMING_CONNECTIONS,
	ID_DISCONNECTION_NOTIFICATION,
	ID_CONNECTION_LOST,
	ID_CONNECTION_REQUEST_ACCEPTED,
	ID_INITIALIZE_ENCRYPTION,
	ID_CONNECTION_BANNED,
	ID_INVALID_PASSWORD,
	ID_MODIFIED_PACKET,
	ID_PONG,
	ID_TIMESTAMP,
	ID_RECEIVED_STATIC_DATA,
	ID_REMOTE_DISCONNECTION_NOTIFICATION,
	ID_REMOTE_CONNECTION_LOST,
	ID_REMOTE_NEW_INCOMING_CONNECTION,
	ID_REMOTE_EXISTING_CONNECTION,
	ID_REMOTE_STATIC_DATA,
	ID_ADVERTISE_SYSTEM = 56,

	ID_VEHICLE_SYNC = 200,
	ID_AIM_SYNC = 203,
	ID_BULLET_SYNC = 206,
	ID_PLAYER_SYNC = 207,
	ID_MARKERS_SYNC,
	ID_UNOCCUPIED_SYNC,
	ID_TRAILER_SYNC,
	ID_PASSENGER_SYNC,
	ID_SPECTATOR_SYNC,
	ID_RCON_COMMAND,
	ID_RCON_RESPONCE,
	ID_WEAPONS_UPDATE,
	ID_STATS_UPDATE,
};

/// These enumerations are used to describe when packets are delivered.
enum PacketPriority
{
	SYSTEM_PRIORITY,   /// \internal Used by RakNet to send above-high priority messages.
	HIGH_PRIORITY,   /// High priority messages are send before medium priority messages.
	MEDIUM_PRIORITY,   /// Medium priority messages are send before low priority messages.
	LOW_PRIORITY,   /// Low priority messages are only sent when no other messages are waiting.
	NUMBER_OF_PRIORITIES
};

/// These enumerations are used to describe how packets are delivered.
/// \note  Note to self: I write this with 3 bits in the stream.  If I add more remember to change that
enum PacketReliability
{
	UNRELIABLE = 6,   /// Same as regular UDP, except that it will also discard duplicate datagrams.  RakNet adds (6 to 17) + 21 bits of overhead, 16 of which is used to detect duplicate packets and 6 to 17 of which is used for message length.
	UNRELIABLE_SEQUENCED,  /// Regular UDP with a sequence counter.  Out of order messages will be discarded.  This adds an additional 13 bits on top what is used for UNRELIABLE.
	RELIABLE,   /// The message is sent reliably, but not necessarily in any order.  Same overhead as UNRELIABLE.
	RELIABLE_ORDERED,   /// This message is reliable and will arrive in the order you sent it.  Messages will be delayed while waiting for out of order messages.  Same overhead as UNRELIABLE_SEQUENCED.
	RELIABLE_SEQUENCED /// This message is reliable and will arrive in the sequence you sent it.  Out or order messages will be dropped.  Same overhead as UNRELIABLE_SEQUENCED.
};

enum NetPatchType
{
	INCOMING_RPC,
	OUTCOMING_RPC,
	INCOMING_PACKET,
	OUTCOMING_PACKET,
};
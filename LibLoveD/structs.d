module structs;

import types;
import defines;

align (1) struct PlayerID
{
	align (1):
	///The peer address from inet_addr.
	uint binaryAddress;
	///The port number
	ushort port;

	ref PlayerID opAssign(ref const PlayerID  input) // Ca = Cb
	{
		binaryAddress = input.binaryAddress;
		port = input.port;
		return this;
	}
};

align (1) struct NetworkID
{
	align (1):
	bool peerToPeer;
	PlayerID playerId;
	ushort localSystemId;
};

/// This represents a user message from another system.
align (1) struct Packet
{
	align (1):
	/// Server only - this is the index into the player array that this playerId maps to
	PlayerIndex playerIndex;

	/// The system that send this packet.
	PlayerID playerId;

	/// The length of the data in bytes
	/// \deprecated You should use bitSize.
	uint length;

	/// The length of the data in bits
	uint bitSize;

	/// The data from the sender
	ubyte* data;

	/// @internal
	/// Indicates whether to delete the data, or to simply delete the packet.
	bool deleteData;
};

/// All RPC functions have the same parameter list - this structure.
align (1) struct RPCParameters
{
	align (1):
	/// The data from the remote system
	ubyte *input;

	/// How many bits long \a input is
	uint numberOfBitsOfData;

	/// Which system called this RPC
	PlayerID sender;

	/// Which instance of RakPeer (or a derived RakServer or RakClient) got this call
	void *recipient;

	/// You can return values from RPC calls by writing them to this BitStream.
	/// This is only sent back if the RPC call originally passed a BitStream to receive the reply.
	/// If you do so and your send is reliable, it will block until you get a reply or you get disconnected from the system you are sending to, whichever is first.
	/// If your send is not reliable, it will block for triple the ping time, or until you are disconnected, or you get a reply, whichever is first.
	BitStream replyToSender;
};

align (1) struct RPCNode
{
	align (1):
	uint8_t uniqueIdentifier;
	void* pFunc;
};

/// Store Statistics information related to network usage 
align (1) struct RakNetStatisticsStruct
{
	align (1):
	///  Number of Messages in the send Buffer (high, medium, low priority)
	uint[PacketPriority.NUMBER_OF_PRIORITIES] messageSendBuffer;
	///  Number of messages sent (high, medium, low priority)
	uint[PacketPriority.NUMBER_OF_PRIORITIES] messagesSent;
	///  Number of data bits used for user messages
	uint[PacketPriority.NUMBER_OF_PRIORITIES] messageDataBitsSent;
	///  Number of total bits used for user messages, including headers
	uint[PacketPriority.NUMBER_OF_PRIORITIES] messageTotalBitsSent;

	///  Number of packets sent containing only acknowledgements
	uint packetsContainingOnlyAcknowlegements;
	///  Number of acknowledgements sent
	uint acknowlegementsSent;
	///  Number of acknowledgements waiting to be sent
	uint acknowlegementsPending;
	///  Number of acknowledgements bits sent
	uint acknowlegementBitsSent;

	///  Number of packets containing only acknowledgements and resends
	uint packetsContainingOnlyAcknowlegementsAndResends;

	///  Number of messages resent
	uint messageResends;
	///  Number of bits resent of actual data
	uint messageDataBitsResent;
	///  Total number of bits resent, including headers
	uint messagesTotalBitsResent;
	///  Number of messages waiting for ack (// TODO - rename this)
	uint messagesOnResendQueue;

	///  Number of messages not split for sending
	uint numberOfUnsplitMessages;
	///  Number of messages split for sending
	uint numberOfSplitMessages;
	///  Total number of splits done for sending
	uint totalSplits;

	///  Total packets sent
	uint packetsSent;

	///  Number of bits added by encryption
	uint encryptionBitsSent;
	///  total bits sent
	uint totalBitsSent;

	///  Number of sequenced messages arrived out of order
	uint sequencedMessagesOutOfOrder;
	///  Number of sequenced messages arrived in order
	uint sequencedMessagesInOrder;

	///  Number of ordered messages arrived out of order
	uint orderedMessagesOutOfOrder;
	///  Number of ordered messages arrived in order
	uint orderedMessagesInOrder;

	///  Packets with a good CRC received
	uint packetsReceived;
	///  Packets with a bad CRC received
	uint packetsWithBadCRCReceived;
	///  Bits with a good CRC received
	uint bitsReceived;
	///  Bits with a bad CRC received
	uint bitsWithBadCRCReceived;
	///  Number of acknowledgement messages received for packets we are resending
	uint acknowlegementsReceived;
	///  Number of acknowledgement messages received for packets we are not resending
	uint duplicateAcknowlegementsReceived;
	///  Number of data messages (anything other than an ack) received that are valid and not duplicate
	uint messagesReceived;
	///  Number of data messages (anything other than an ack) received that are invalid
	uint invalidMessagesReceived;
	///  Number of data messages (anything other than an ack) received that are duplicate
	uint duplicateMessagesReceived;
	///  Number of messages waiting for reassembly
	uint messagesWaitingForReassembly;
	///  Number of messages in reliability output queue
	uint internalOutputQueueSize;
	///  Current bits per second
	double bitsPerSecond;
	///  connection start time
	RakNetTime connectionStartTime;
};

align (1) struct stNetPatch
{
	align (1):
	const(char) *name;
	int hotkey;
	bool enabled;
	byte id;
	NetPatchType type;
};

align (1) struct stSAMP
{
	align (1):
	void*[2]				pUnk0; // 8
	uint8_t[24]				byteSpace; // 24
	char[257]				szIP; // 257
	char[259]				szHostname; // 259
	uint8_t					byteUnk1; // 1
	uint32_t				ulPort; // 4
	uint32_t[100]			ulMapIcons; // 400
	int						iLanMode; // 4
	int						iGameState; // 4
	uint32_t				ulConnectTick; // 4
	stServerPresets			*pSettings; // 4
	void					*pRakClientInterface; // 4
	void					*pPools; // 4
};

align (1) struct stServerPresets
{
	align (1):
	uint8_t byteCJWalk; // 1
	uint8_t[4] byteUnk0; // 4
	float[4]	fWorldBoundaries; // 16
	uint8_t byteUnk1; // 1
	float	fGravity; // 4
	uint8_t byteDisableInteriorEnterExits; // 1
	uint32_t ulVehicleFriendlyFire; // 4
	uint8_t[4] byteUnk2; // 4
	int		iClassesAvailable; // 4
	float	fNameTagsDistance; // 4
	uint8_t byteUnk3; // 1
	uint8_t byteWorldTime_Hour; // 1
	uint8_t byteWorldTime_Minute; // 1
	uint8_t byteWeather; // 1
	uint8_t byteNoNametagsBehindWalls; // 1
	uint8_t bytePlayerMarkersMode; // 1
	uint8_t[3] byteUnk4; // 3
	float	fGlobalChatRadiusLimit; // 4
	uint8_t byteShowNameTags; // 1
};
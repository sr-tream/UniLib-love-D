module UniLib;

import std.stdio;
import core.runtime;
import core.memory;
import core.sys.windows.windows;

pragma(lib, "UniLib.lib");
import types;
import defines;
import structs;

export extern (C++)
{
	interface CFontInfo
	{
		void Initialize( IDirect3DDevice9 pDevice );
		void Invalidate();
		void Print( DWORD color, const(char)* szText, int X, int Y );
		void PrintShadow( DWORD color, const(char)* szText, int X, int Y );
		float GetHeight();
		float GetWidth( const(char)* szText );
	}
	interface CDrawInfo
	{
		void Box( int X, int Y, int W, int H, DWORD color );
		void BorderBox( int X, int Y, int W, int H, DWORD boreder_color, DWORD color );
		void Line( int X, int Y, int X2, int Y2, DWORD color );
		void Initialize( IDirect3DDevice9 pDevice );
		void Invalidate();
	}
	interface CCreateTexture
	{
		void Begin();
		void End();
		bool Clear( D3DCOLOR color = 0 );
		bool Render( int X, int Y, int W = -1, int H = -1, float R = 0.0f );
		void Release();
		void Init();
		void ReInit( int width, int height );
		ID3DXSprite GetSprite();
		IDirect3DTexture9 GetTexture();
		D3DSURFACE_DESC GetSurfaceDesc();
	}
	interface CBSInfo
	{
		void Write( void * data, size_t size );
		void WriteComp( byte data );
		void WriteComp( WORD data );
		void WriteComp( DWORD data );
		void WriteBits( ubyte * input, int numberOfBitsToWrite, bool rightAlignedBits = true );
		void SetWriteOffset( int offset );
		int GetWriteOffset();
		bool Read( void * data, size_t size );
		bool ReadComp( ref byte  data );
		bool ReadComp( ref WORD  data );
		bool ReadComp( ref DWORD  data );
		bool ReadBit();
		void SetReadOffset( int offset );
		int GetReadOffset();
		void SetNumberOfBitsAllocated( uint lengthInBits );
		int GetNumberOfUnreadBits();
		int GetNumberOfBitsUsed();
		int GetNumberOfBytesUsed();
	}
	interface RakClientInterface
	{
		void dRakClientInterface();
		bool Connect(const(char) * host, ushort serverPort, ushort clientPort, uint depreciated, int threadSleepTimer);
		void Disconnect(uint blockDuration, ubyte orderingChannel = 0);
		void InitializeSecurity(const(char) *privKeyP, const(char) *privKeyQ);
		void SetPassword(const(char) *_password);
		const(bool) HasPassword();
		bool Send(const(char) *data, const(int) length, PacketPriority priority, PacketReliability reliability, char orderingChannel);
		bool Send(BitStream bitStream, PacketPriority priority, PacketReliability reliability, char orderingChannel);
		Packet* Receive();
		void DeallocatePacket(Packet *packet);
		void PingServer();
		void PingServer(const(char) * host, ushort serverPort, ushort clientPort, bool onlyReplyOnAcceptingConnections);
		int GetAveragePing();
		int GetLastPing();
		int GetLowestPing();
		int GetPlayerPing(const PlayerID playerId);
		void StartOccasionalPing();
		void StopOccasionalPing();
		bool IsConnected();
		uint GetSynchronizedRandomInteger();
		bool GenerateCompressionLayer(uint* /*256*/ inputFrequencyTable, bool inputLayer);
		bool DeleteCompressionLayer(bool inputLayer);
		void RegisterAsRemoteProcedureCall(int * uniqueID, void* pFunc);
		void RegisterClassMemberRPC(int * uniqueID, void *functionPointer);
		void UnregisterAsRemoteProcedureCall(int * uniqueID);
		bool RPC(int * uniqueID, const(char) *data, uint bitLength, PacketPriority priority, PacketReliability reliability, char orderingChannel, bool shiftTimestamp);
		bool RPC(int * uniqueID, BitStream bitStream, PacketPriority priority, PacketReliability reliability, char orderingChannel, bool shiftTimestamp);
		bool RPC_(int * uniqueID, BitStream bitStream, PacketPriority priority, PacketReliability reliability, char orderingChannel, bool shiftTimestamp, NetworkID networkID);
		void SetTrackFrequencyTable(bool b);
		bool GetSendFrequencyTable(uint* /*256*/ outputFrequencyTable);
		const(float) GetCompressionRatio();
		const(float) GetDecompressionRatio();
		void AttachPlugin(void *messageHandler);
		void DetachPlugin(void *messageHandler);
		BitStream GetStaticServerData();
		void SetStaticServerData(const(char) *data, const(int) length);
		BitStream GetStaticClientData(const PlayerID playerId);
		void SetStaticClientData(const PlayerID playerId, const(char) *data, const(int) length);
		void SendStaticClientDataToServer();
		const(PlayerID) GetServerID();
		const(PlayerID) GetPlayerID();
		const(PlayerID) GetInternalID();
		const(char) * PlayerIDToDottedIP(const PlayerID playerId);
		void PushBackPacket(Packet *packet, bool pushAtHead);
		void SetRouterInterface(void *routerInterface);
		void RemoveRouterInterface(void *routerInterface);
		void SetTimeoutTime(RakNetTime timeMS);
		bool SetMTUSize(int size);
		const(int) GetMTUSize();
		void AllowConnectionResponseIPMigration(bool allow);
		void AdvertiseSystem(const(char) *host, ushort remotePort, const(char) *data, int dataLength);
		const(RakNetStatisticsStruct)* GetStatistics();
		void ApplyNetworkSimulator(double maxSendBPS, ushort minExtraPing, ushort extraPingVariance);
		bool IsNetworkSimulatorActive();
		PlayerIndex GetPlayerIndex();
	}
}
export extern (Windows)
{
	// CFontInfo
	CFontInfo CreateFontInfo( const(char)* szFontName, int fontHeight, DWORD dwCreateFlags );
	void DestoryFontInfo( ref CFontInfo pFont );

	// CDrawInfo
	CDrawInfo CreateDrawInfo( int numVertices );
	void DestoryDrawInfo( ref CDrawInfo pDraw );

	// CCreateTexture
	CCreateTexture CreateCTexture( IDirect3DDevice9 pDevice, int width, int height );
	void DestoryCTexture( ref CCreateTexture pTexture );

	// CBSInfo
	CBSInfo CreateBSInfo( BitStream BS );
	void DestoryBSInfo( CBSInfo pBS );


	void RegisterMainloop( void* pFunc ); // extern (Windows) void function();
	void DestoryMainloop( void* pFunc ); // extern (Windows) void function();

	void RegisterPresent( void* pFunc ); // extern (Windows) void function(IDirect3DDevice9);
	void DestoryPresent( void* pFunc ); // extern (Windows) void function(IDirect3DDevice9);

	void RegisterReset( void* pFunc ); // extern (Windows) void function(IDirect3DDevice9);
	void DestoryReset( void* pFunc ); // extern (Windows) void function(IDirect3DDevice9);

	void RegisterHandleRPCPacket( void* pFunc ); // extern (Windows) bool function(ubyte, ref RPCParameters);
	void DestoryHandleRPCPacket( void* pFunc ); // extern (Windows) bool function(ubyte, ref RPCParameters);

	void RegisterSendRPC( void* pFunc ); // extern (Windows) bool function(int, BitStream, PacketPriority, PacketReliability, byte, bool);
	void DestorySendRPC( void* pFunc ); // extern (Windows) bool function(int, BitStream, PacketPriority, PacketReliability, byte, bool);

	void RegisterRecivePacket( void* pFunc ); // extern (Windows) bool function(ref Packet p);
	void DestoryRecivePacket( void* pFunc ); // extern (Windows) bool function(ref Packet p);

	void RegisterSendPacket( void* pFunc ); // extern (Windows) bool function(BitStream, PacketPriority, PacketReliability, byte);
	void DestorySendPacket( void* pFunc ); // extern (Windows) bool function(BitStream, PacketPriority, PacketReliability, byte);

	void RegisterWndProc( void* pFunc ); // extern (Windows) bool function(HWND, UINT, WPARAM, LPARAM);
	void DestoryWndProc( void* pFunc ); // extern (Windows) bool function(HWND, UINT, WPARAM, LPARAM);


	IDirect3DDevice9 GetD3DDevice();
	bool IsLoaded();
	RakClientInterface GetRakClient();


	BitStream CreateBitStream();
	BitStream CreateBitStream2( int initialBytesToAllocate );
	BitStream CreateBitStream3( ubyte * _data, uint lengthInBytes, bool _copyData );
	void DestoryBitStream( ref BitStream pBS );
}

class FontInfo
{
	this(const(char)* szFontName, int fontHeight, DWORD dwCreateFlags)
	{
		_pFont = CreateFontInfo(szFontName, fontHeight, dwCreateFlags);
	}
	~this()
	{
		DestoryFontInfo(_pFont);
	}
	void Print( DWORD color, const(char)* szText, int X, int Y, bool shadow = false )
	{
		if (!shadow)
			_pFont.Print(color, szText, X, Y);
		else _pFont.PrintShadow(color, szText, X, Y);
	}
	float GetHeight()
	{
		return _pFont.GetHeight();
	}
	float GetWidth( const(char)* szText )
	{
		return _pFont.GetWidth(szText);
	}
	private:
	CFontInfo _pFont;
}
class DrawInfo
{
	this(int numVertices)
	{
		_pDraw = CreateDrawInfo(numVertices);
	}
	~this()
	{
		DestoryDrawInfo(_pDraw);
	}
	void Box( int X, int Y, int W, int H, DWORD color )
	{
		_pDraw.Box(X, Y, W, H, color);
	}
	void BorderBox( int X, int Y, int W, int H, DWORD boreder_color, DWORD color )
	{
		_pDraw.BorderBox(X, Y, W, H, boreder_color, color);
	}
	void Line( int X, int Y, int X2, int Y2, DWORD color )
	{
		_pDraw.Line(X, Y, X2, Y2, color);
	}
private:
	CDrawInfo _pDraw;
}
class CreateTexture
{
	this(IDirect3DDevice9 pDevice, int width, int height)
	{
		_pTex = CreateCTexture(pDevice, width, height);
	}
	~this()
	{
		DestoryCTexture(_pTex);
	}
	void Begin()
	{
		_pTex.Begin();
	}
	void End()
	{
		_pTex.End();
	}
	bool Clear( D3DCOLOR color = 0 )
	{
		return _pTex.Clear(color);
	}
	bool Render( int X, int Y, int W = -1, int H = -1, float R = 0.0f )
	{
		return _pTex.Render(X, Y, W, H, R);
	}
private:
	CCreateTexture _pTex;
}
class BSInfo
{
	this(BitStream BS)
	{
		Interface = CreateBSInfo(BS);
	}
	~this()
	{
		DestoryBSInfo(Interface);
	}
	template rw(T)
	{
		void Write(T v)
		{
			_BSInfo.Write(&v, v.sizeof);
		}
		bool Read(ref T v)
		{
			return _BSInfo.Read(&v, v.sizeof);
		}
	}
	CBSInfo Interface;
private:
}
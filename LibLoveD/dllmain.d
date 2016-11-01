module dllmain;

import core.sys.windows.windows;
import core.sys.windows.winbase;
import core.sys.windows.dll;
import std.string, std.stdio, std.conv;

import types;
import defines;
import structs;
import UniLib;
import CVector;

__gshared HINSTANCE g_hInst;
__gshared FontInfo pFont;
__gshared CreateTexture pTex;

extern (Windows) BOOL DllMain(HINSTANCE hInstance, ULONG ulReason, LPVOID pvReserved)
{
    switch (ulReason)
    {
        case DLL_PROCESS_ATTACH:
            g_hInst = hInstance;
			HANDLE h = GetModuleHandle("UniLib.DLL");
			if (h is null)
				LoadLibraryA("UniLib.DLL");
			RegisterMainloop(&mainloop);
            dll_process_attach(hInstance, true);
            break;

        case DLL_PROCESS_DETACH:
			delete pTex;
			delete pFont;
			DestoryWndProc(&WndProc);
			DestorySendPacket(&OnSendPacket);
			DestoryPresent(&OnReceivePacket);
			DestorySendRPC(&OnSendRPC);
			DestoryHandleRPCPacket(&HandleRPCPacketFunc);
			DestoryPresent(&Present);
			DestoryMainloop(&mainloop);
            dll_process_detach(hInstance, true);
            break;

        case DLL_THREAD_ATTACH:
            dll_thread_attach(true, true);
            break;

        case DLL_THREAD_DETACH:
            dll_thread_detach(true, true);
            break;

        default:
            break;
    }
    return true;
}

extern (Windows) void mainloop()
{
	static __gshared bool Init = false;
	if (!Init){
		if (!IsLoaded())
			return;

		pFont = new FontInfo("Arial", 12, FCR_BORDER);
		pTex = new CreateTexture(GetD3DDevice(), 300, 300);
		RegisterPresent(&Present);
		RegisterHandleRPCPacket(&HandleRPCPacketFunc);
		RegisterSendRPC(&OnSendRPC);
		RegisterRecivePacket(&OnReceivePacket);
		RegisterSendPacket(&OnSendPacket);
		RegisterWndProc(&WndProc);

		//string pIDsz = "PlayerId size: " ~ to!string(PlayerID.sizeof);
		//MessageBoxA(null, pIDsz.toStringz(), "LibLoveD", MB_OK);

		Init = true;
	}
}

__gshared ubyte lastInRPC, lastOutRPC, lastInPacket, lastOutPacket;
__gshared uint lastWndProc;
extern (Windows) void Present(IDirect3DDevice9 pDevice)
{
	static __gshared string draw = "I love D :)", draw2 = "";
	static __gshared DWORD time = 0, spawn = 0;
	pTex.Begin();
	pTex.Clear();
	if (time < GetTickCount() && GetRakClient().IsConnected()){
		GetRakClient().PingServer();
		draw = "I love D :) Server ping: " ~ to!string(GetRakClient().GetLastPing());
		if (spawn != 0)
			draw ~= " spawn: " ~ to!string(cast(int)((spawn - GetTickCount()) / 1000));
		time = GetTickCount() + 1000;
	}
	pFont.Print(-1, draw.toStringz(), 5, 5);
	string lastRpc = "Last RPC[IN]=" ~ to!string(lastInRPC);
	pFont.Print(-1, lastRpc.toStringz(), 5, 25);
	lastRpc = "Last RPC[OUT]=" ~ to!string(lastOutRPC);
	pFont.Print(-1, lastRpc.toStringz(), 5, 45);
	lastRpc = "Last Packet[IN]=" ~ to!string(lastInPacket);
	pFont.Print(-1, lastRpc.toStringz(), 5, 65);
	lastRpc = "Last Packet[OUT]=" ~ to!string(lastOutPacket);
	pFont.Print(-1, lastRpc.toStringz(), 5, 85);
	lastRpc = "Last WndProc=" ~ to!string(lastWndProc);
	pFont.Print(-1, lastRpc.toStringz(), 5, 105);
	pTex.End();
	pTex.Render(150, 70, 300, 300, 0.7);

	if (spawn == 0){
		spawn = GetTickCount() + 45000;
	}
	else if (spawn < GetTickCount()){
		spawn = 0;
		SendSpawn();
	}
}

void SendSpawn()
{
	BitStream bsSpawn = CreateBitStream();

	int rpcid = RPCEnumeration.RPC_RequestSpawn;
	GetRakClient().RPC( &rpcid, bsSpawn, PacketPriority.HIGH_PRIORITY, PacketReliability.RELIABLE, 0, false );
	rpcid = RPCEnumeration.RPC_Spawn;
	GetRakClient().RPC( &rpcid, bsSpawn, PacketPriority.HIGH_PRIORITY, PacketReliability.RELIABLE_ORDERED, 0, false );
	DestoryBitStream(bsSpawn);
}

void SendDeath()
{
	BitStream bsDeath = CreateBitStream();
	CBSInfo bs = CreateBSInfo(bsDeath);

	byte reason = 24;
	ushort killer = 0;
	bs.Write(&reason, 1);
	bs.Write(&killer, 2);

	int rpcid = RPCEnumeration.RPC_Death;
	GetRakClient().RPC( &rpcid, bsDeath, PacketPriority.HIGH_PRIORITY, PacketReliability.RELIABLE, 0, false );
	DestoryBSInfo(bs);
	DestoryBitStream(bsDeath);
}

extern (Windows) bool HandleRPCPacketFunc(ubyte id, ref RPCParameters RPC)
{
	//MessageBoxA(null, (cast(string)("In RPC=" ~ to!string(id))).toStringz(), "LibLoveD", MB_OK);
	//MessageBoxA(null, (cast(string)("size=" ~ to!string(RPC.numberOfBitsOfData))).toStringz(), "LibLoveD", MB_OK);
	lastInRPC = id;
	return true;
}

extern (Windows) bool OnSendRPC(int uniqueID, ref BitStream parameters, PacketPriority priority, PacketReliability reliability, byte orderingChannel, bool shiftTimestamp)
{
	lastOutRPC = cast(byte)uniqueID;
	return true;
}

extern (Windows) bool OnReceivePacket(ref Packet p)
{
	//MessageBoxA(null, (cast(string)("pi=" ~ to!string(p.length))).toStringz(), "LibLoveD", MB_OK);
	if (p.data is null || p.length == 0)
		return true;

	lastInPacket = p.data[0];

	return true;
}

extern (Windows) bool OnSendPacket(BitStream* bitStream, PacketPriority priority, PacketReliability reliability, char orderingChannel)
{
	if (bitStream is null)
		return false;

	CBSInfo bs = CreateBSInfo(bitStream);

	bs.Read(cast(char*)&lastOutPacket, 1);

	DestoryBSInfo(bs);
	return true;
}

extern (Windows) bool WndProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
	lastWndProc = uMsg;
	return true;
}
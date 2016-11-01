module CVector;

import std.stdio;
import core.runtime;
import core.sys.windows.windows;
import core.stdc.stdlib;
import core.stdc.string;
import std.math;

template vecMath(T)
{
	T len2D(T X, T Y)
	{
		return cast(T)sqrt(cast(double)(X ^^ 2) + cast(double)(Y ^^ 2));
	}
	T[2] norm2D(T X, T Y)
	{
		T len = vecMath!T.len2D(X, Y);
		X /= len;
		Y /= len;
		return [X, Y];
	}

	T len3D(T X, T Y, T Z)
	{
		return cast(T)sqrt(cast(double)(X ^^ 2) + cast(double)(Y ^^ 2) + cast(double)(Z ^^ 2));
	}
	T[3] norm3D(T X, T Y, T Z)
	{
		T len = vecMath!T.len3D(X, Y, Z);
		X /= len;
		Y /= len;
		Z /= len;
		return [X, Y, Z];
	}
	
	T len4D(T W, T X, T Y, T Z)
	{
		return cast(T)sqrt(cast(double)(W ^^ 2) + cast(double)(X ^^ 2) + cast(double)(Y ^^ 2) + cast(double)(Z ^^ 2));
	}
	T[4] norm4D(T W, T X, T Y, T Z)
	{
		T len = vecMath!T.len4D(W, X, Y, Z);
		W /= len;
		X /= len;
		Y /= len;
		Z /= len;
		return [W, X, Y, Z];
	}
}

class CVector2D(T)
{
	public T X;
	public T Y;
	
	this(void* _addr)
	{
		uint VP;
		VirtualProtect(_addr, size(), PAGE_EXECUTE_READWRITE, &VP);
		X = (cast(T*)_addr)[0];
		Y = (cast(T*)_addr)[1];
		VirtualProtect(_addr, size(), VP, &VP);
	}
	this(T X, T Y)
	{
		this.X = X;
		this.Y = Y;
	}
	this(T[2] vec)
	{
		this.X = vec[0];
		this.Y = vec[1];
	}
	this(T[] vec)
	{
		this.X = vec[0];
		this.Y = vec[1];
	}
	this(CVector2D vec)
	{
		X = vec.X;
		Y = vec.Y;
	}
	this()
	{
		X = cast(T)null;
		Y = cast(T)null;
	}
	
	size_t size()
	{
		return cast(size_t)(T.sizeof * 2);
	}

	@safe ref T opIndex(size_t id)
	{
		static T bad;
		switch(id)
		{
			case 0:
				return X;
			case 1:
				return Y;
			default:
				return bad;
		}
	}

	float length()
	{
		return vecMath!float.len2D(X, Y);
	}

	void Normalize()
	{
		float len = vecMath!float.len2D(X, Y);
		X /= len;
		Y /= len;
	}

	CVector2D norm()
	{
		return new CVector2D(vecMath!float.norm2D(X, Y));
	}
}

class CVector2D(T : string)
{
	public T X;
	public T Y;

	this(void* _addr)
	{
		uint VP;
		VirtualProtect(_addr, size(), PAGE_EXECUTE_READWRITE, &VP);
		X = (cast(T*)_addr)[0];
		Y = (cast(T*)_addr)[1];
		VirtualProtect(_addr, size(), VP, &VP);
	}
	this(T X, T Y)
	{
		this.X = X;
		this.Y = Y;
	}
	this(T[2] vec)
	{
		this.X = vec[0];
		this.Y = vec[1];
	}
	this(T[] vec)
	{
		this.X = vec[0];
		this.Y = vec[1];
	}
	this(CVector2D vec)
	{
		X = vec.X;
		Y = vec.Y;
	}
	this()
	{
		X = cast(T)null;
		Y = cast(T)null;
	}

	size_t size()
	{
		return cast(size_t)(T.sizeof * 2);
	}

	@safe ref T opIndex(size_t id)
	{
		static T bad;
		switch(id)
		{
			case 0:
				return X;
			case 1:
				return Y;
			default:
				return bad;
		}
	}
}

class CVector3D(T) : CVector2D!T
{
	public T Z;

	this(void* _addr)
	{
		super(_addr);
		uint VP;
		VirtualProtect(_addr, size(), PAGE_EXECUTE_READWRITE, &VP);
		Z = (cast(T*)_addr)[2];
		VirtualProtect(_addr, size(), VP, &VP);
	}
	this(T X, T Y, T Z)
	{
		super(X, Y);
		this.Z = Z;
	}
	this(T[3] vec)
	{
		this.X = vec[0];
		this.Y = vec[1];
		this.Z = vec[2];
	}
	this(T[] vec)
	{
		super(vec);
		this.Z = vec[2];
	}
	this(CVector3D vec)
	{
		X = vec.X;
		Y = vec.Y;
		Z = vec.Z;
	}
	this()
	{
		super();
		Z = cast(T)null;
	}

	override size_t size()
	{
		return cast(size_t)(T.sizeof * 3);
	}
	
	override @safe ref T opIndex(size_t id)
	{
		static T bad;
		switch(id)
		{
			case 0:
				return X;
			case 1:
				return Y;
			case 2:
				return Z;
			default:
				return bad;
		}
	}

	override float length()
	{
		return vecMath!float.len3D(X, Y, Z);
	}

	override void Normalize()
	{
		float len = vecMath!float.len3D(X, Y, Z);
		X /= len;
		Y /= len;
		Z /= len;
	}

	override CVector3D norm()
	{
		return new CVector3D(vecMath!float.norm3D(X, Y, Z));
	}
}

class CVector3D(T : string) : CVector2D!T
{
	public T Z;

	this(void* _addr)
	{
		super(_addr);
		uint VP;
		VirtualProtect(_addr, size(), PAGE_EXECUTE_READWRITE, &VP);
		Z = (cast(T*)_addr)[2];
		VirtualProtect(_addr, size(), VP, &VP);
	}
	this(T X, T Y, T Z)
	{
		super(X, Y);
		this.Z = Z;
	}
	this(T[3] vec)
	{
		this.X = vec[0];
		this.Y = vec[1];
		this.Z = vec[2];
	}
	this(T[] vec)
	{
		super(vec);
		this.Z = vec[2];
	}
	this(CVector3D vec)
	{
		X = vec.X;
		Y = vec.Y;
		Z = vec.Z;
	}
	this()
	{
		super();
		Z = cast(T)null;
	}

	override size_t size()
	{
		return cast(size_t)(T.sizeof * 3);
	}

	override @safe ref T opIndex(size_t id)
	{
		static T bad;
		switch(id)
		{
			case 0:
				return X;
			case 1:
				return Y;
			case 2:
				return Z;
			default:
				return bad;
		}
	}
}

class CVector4D(T) : CVector3D!T
{
	public T W;
	
	this(void* _addr)
	{
		uint VP;
		VirtualProtect(_addr, size(), PAGE_EXECUTE_READWRITE, &VP);
		W = (cast(T*)_addr)[0];
		VirtualProtect(_addr, size(), VP, &VP);
		void *addr = cast(void*)(cast(uint)_addr + T.sizeof);
		super(addr);
	}
	this(T W, T X, T Y, T Z)
	{
		super(X, Y, Z);
		this.W = W;
	}
	this(T[4] vec)
	{
		this.W = vec[0];
		this.X = vec[1];
		this.Y = vec[2];
		this.Z = vec[3];
	}
	this(T[] vec)
	{
		this.W = vec[0];
		this.X = vec[1];
		this.Y = vec[2];
		this.Z = vec[3];
	}
	this(CVector4D vec)
	{
		W = vec.W;
		X = vec.X;
		Y = vec.Y;
		Z = vec.Z;
	}
	this()
	{
		super();
		W = cast(T)null;
	}
	
	override size_t size()
	{
		return cast(size_t)(T.sizeof * 4);
	}

	override @safe ref T opIndex(size_t id)
	{
		static T bad;
		switch(id)
		{
			case 0:
				return W;
			case 1:
				return X;
			case 2:
				return Y;
			case 3:
				return Z;
			default:
				return bad;
		}
	}

	override float length()
	{
		return vecMath!float.len4D(W, X, Y, Z);
	}

	override void Normalize()
	{
		float len = vecMath!float.len4D(W, X, Y, Z);
		X /= len;
		Y /= len;
		Z /= len;
	}

	override CVector4D norm()
	{
		return new CVector4D(vecMath!float.norm4D(W, X, Y, Z));
	}
}

class CVector4D(T : string) : CVector3D!T
{
	public T W;

	this(void* _addr)
	{
		uint VP;
		VirtualProtect(_addr, size(), PAGE_EXECUTE_READWRITE, &VP);
		W = (cast(T*)_addr)[0];
		VirtualProtect(_addr, size(), VP, &VP);
		void *addr = cast(void*)(cast(uint)_addr + T.sizeof);
		super(addr);
	}
	this(T W, T X, T Y, T Z)
	{
		super(X, Y, Z);
		this.W = W;
	}
	this(T[4] vec)
	{
		this.W = vec[0];
		this.X = vec[1];
		this.Y = vec[2];
		this.Z = vec[3];
	}
	this(T[] vec)
	{
		this.W = vec[0];
		this.X = vec[1];
		this.Y = vec[2];
		this.Z = vec[3];
	}
	this(CVector4D vec)
	{
		W = vec.W;
		X = vec.X;
		Y = vec.Y;
		Z = vec.Z;
	}
	this()
	{
		super();
		W = cast(T)null;
	}

	override size_t size()
	{
		return cast(size_t)(T.sizeof * 4);
	}

	override @safe ref T opIndex(size_t id)
	{
		static T bad;
		switch(id)
		{
			case 0:
				return W;
			case 1:
				return X;
			case 2:
				return Y;
			case 3:
				return Z;
			default:
				return bad;
		}
	}
}

class vector(T)
{
	this() {}
	this(T[] v ...)
	{
		if (v.length){
			_values.length = v.length;
			foreach(i, it; v)
				_values[i] = it;
		}
		_end = v.length;
	}
	this(size_t size)
	{
		_values.length = size;
	}

	ref T opIndex(size_t id)
	{
		_sort = false;
		if (id > _values.length){
			_values.length = id * 2;
			_end = id + 1;
		}
		return _values[id];
	}
	int opApply(scope int delegate(ref T) dg)
	{
		int result = 0;
		
		for (int i = 0; i < _end; ++i)
		{
			result = dg(_values[i]);
			if (result)
				break;
		}
		return result;
	}
	int opApplyReverse(scope int delegate(ref T) dg)
	{
		int result = 0;

		for (int i = _end - 1; i >= 0; --i)
		{
			result = dg(_values[i]);
			if (result)
				break;
		}
		return result;
	}

	void push_back(T v)
	{
		insert(_end, v);
	}
	void push_front(T v)
	{
		insert(0, v);
	}
	T pop_back()
	{
		return erase(_end - 1);
	}
	T pop_front()
	{
		return erase(0);
	}

	size_t size()
	{
		return _end;
	}
	size_t max_size()
	{
		return _values.length;
	}

	void clear()
	{
		T empy_data;
		for(int i = 0; i < _end; ++i)
			_values[i] = empy_data;
		_end = 0;
	}
	void shrink_to_fit()
	{
		_values.length = _end;
	}

	void sort()
	{
		_values.sort;
		_sort = true;
	}
	void reverse()
	{
		_values.reverse;
	}

	T erase(size_t id)
	{
		T r = _values[id];
		for(int i = id; i < _end; ++i){
			if (i + 1 <= _values.length)
				_values[i] = _values[i + 1];
		}
		--_end;
		return r;
	}
	void insert(size_t id, T v)
	{
		if (id >= _values.length)
			_values.length = id * 2;
		for(int i = _end; i > id; --i)
			_values[i] = _values[i - 1];
		_values[id] = v;
		++_end;
		if (v < _values[id - 1])
			_sort = false;
	}

	ref T front()
	{
		_sort = false;
		return _values[0];
	}
	ref T back()
	{
		_sort = false;
		return _values[_end - 1];
	}
	ref T[] data()
	{
		_sort = false;
		return _values;
	}

	ref T at(size_t id)
	{
		_sort = false;
		static T bad;
		if (id >= _end)
			return bad;
		return _values[id];
	}

	bool empty()
	{
		return _end == 0;
	}
	size_t capacity()
	{
		return size();
	}

	bool swap(vector vec)
	{
		if (vec.size != size)
			return false;

		T[] temp;
		temp.length = _values.length;
		foreach(i, it; _values)
			temp[i] = it;
		for(int i = 0; i < size(); ++i)
			_values[i] = vec[i];
		vec.clear();
		for(int i = 0; i < size(); ++i)
			vec[i] = temp[i];

		_sort = false;
		return true;
	}

	void resize(size_t new_size)
	{
		_values.length = new_size;
		if (_end > new_size)
			_end = new_size;
	}

	ref T find(T v)
	{
		if (_sort)
			return fastFind(v);
		else return slowFind(v);
	}

private:
	T[] _values;
	size_t _end;
	bool _sort = false;

	ref T fastFind(T v)
	{
		if (v == _values[0])
			return _values[0];
		else if (v == _values[_end - 1])
			return _values[_end - 1];

		size_t part = (_end - 1) / 2;
		size_t id = part;
		while (_values[id] != v){
			part /= 2;
			if (part == 0)
				part = 1;
			if (_values[id] > v)
				id -= part;
			else id += part;
			if (id >= _end)
				return null;
		}
		return _values[id];
	}
	ref T slowFind(T v)
	{
		foreach(i, it; _values)
			if (_values == v)
				return _values[i];
		return null;
	}
}
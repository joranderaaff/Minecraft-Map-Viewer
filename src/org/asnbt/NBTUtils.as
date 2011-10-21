package org.asnbt
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedSuperclassName;
/*
 * ASNBT is a straight port of the JNBT library written by Graham Edgecombe.
 * More information can be found here: http://jnbt.sourceforge.net/
 * Port by Joran de Raaff
 * www.joranderaaff.nl
 * joranderaaff [at] gmail [dot] com
 * /

/*
 * JNBT License
 * 
 * Copyright (c) 2010 Graham Edgecombe
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 
 *     * Redistributions of source code must retain the above copyright notice,
 *       this list of conditions and the following disclaimer.
 *       
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *       
 *     * Neither the name of the JNBT team nor the names of its
 *       contributors may be used to endorse or promote products derived from
 *       this software without specific prior written permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE. 
 */

/**
 * A class which contains NBT-related utility methods.
 * @author Graham Edgecombe
 *
 */
public final class NBTUtils {
	
	/**
	 * Gets the type name of a tag.
	 * @param clazz The tag class.
	 * @return The type name.
	 */
	public static function getTypeName(clazz : Class):String{
		if(isSubclass(clazz, ByteArrayTag)) {
			return "TAG_Byte_Array";
		} else if(isSubclass(clazz, ByteTag)) {
			return "TAG_Byte";
		} else if(isSubclass(clazz, CompoundTag)) {
			return "TAG_Compound";
		} else if(isSubclass(clazz, DoubleTag)) {
			return "TAG_Double";
		} else if(isSubclass(clazz, EndTag)) {
			return "TAG_End";
		} else if(isSubclass(clazz, FloatTag)) {
			return "TAG_Float";
		} else if(isSubclass(clazz, IntTag)) {
			return "TAG_Int";
		} else if(isSubclass(clazz, ListTag)) {
			return "TAG_List";
		} else if(isSubclass(clazz, LongTag)) {
			return "TAG_Long";
		} else if(isSubclass(clazz, ShortTag)) {
			return "TAG_Short";
		} else if(isSubclass(clazz, StringTag)) {
			return "TAG_String";
		} else {
			throw new Error("Invalid tag classs (" + clazz + ").");
		}
	}
	
	/**
	 * Gets the type code of a tag class.
	 * @param clazz The tag class.
	 * @return The type code.
	 * @throws Error if the tag class is invalid.
	 */
	public static function getTypeCode(clazz : Class):int{
		if(isSubclass(clazz, ByteArrayTag)) {
			return NBTConstants.TYPE_BYTE_ARRAY;
		} else if(isSubclass(clazz, ByteTag)) {
			return NBTConstants.TYPE_BYTE;
		} else if(isSubclass(clazz, CompoundTag)) {
			return NBTConstants.TYPE_COMPOUND;
		} else if(isSubclass(clazz, DoubleTag)) {
			return NBTConstants.TYPE_DOUBLE;
		} else if(isSubclass(clazz, EndTag)) {
			return NBTConstants.TYPE_END;
		} else if(isSubclass(clazz, FloatTag)) {
			return NBTConstants.TYPE_FLOAT;
		} else if(isSubclass(clazz, IntTag)) {
			return NBTConstants.TYPE_INT;
		} else if(isSubclass(clazz, ListTag)) {
			return NBTConstants.TYPE_LIST;
		} else if(isSubclass(clazz, LongTag)) {
			return NBTConstants.TYPE_LONG;
		} else if(isSubclass(clazz, ShortTag)) {
			return NBTConstants.TYPE_SHORT;
		} else if(isSubclass(clazz, StringTag)) {
			return NBTConstants.TYPE_STRING;
		} else {
			throw new Error("Invalid tag classs (" + clazz + ").");
		}
	}
	
	/**
	 * Gets the class of a type of tag.
	 * @param type The type.
	 * @return The class.
	 * @throws Error if the tag type is invalid.
	 */
	public static function getTypeClass(type:int) : Class{
		switch(type) {
		case NBTConstants.TYPE_END:
			return EndTag;
		case NBTConstants.TYPE_BYTE:
			return ByteTag;
		case NBTConstants.TYPE_SHORT:
			return ShortTag;
		case NBTConstants.TYPE_INT:
			return IntTag;
		case NBTConstants.TYPE_LONG:
			return LongTag;
		case NBTConstants.TYPE_FLOAT:
			return FloatTag;
		case NBTConstants.TYPE_DOUBLE:
			return DoubleTag;
		case NBTConstants.TYPE_BYTE_ARRAY:
			return ByteArrayTag;
		case NBTConstants.TYPE_STRING:
			return StringTag;
		case NBTConstants.TYPE_LIST:
			return ListTag;
		case NBTConstants.TYPE_COMPOUND:
			return CompoundTag;
		default:
			throw new Error("Invalid tag type : " + type + ".");
		}
	}
	
	/**
	 * Default private constructor.
	 */
	public function NBTUtils() {
		
	}
	
	private static function isSubclass(type:Class, superClass:Class):Boolean {
		if(superClass == Object) {
			return true;
		}
		try {
			for(var c:Class = type; c != Object; c = Class(getDefinitionByName(getQualifiedSuperclassName(c)))) {
				if(c == superClass) {
					return true;
				}
			}
		} catch(e:Error) {}
		
		return false;
	}
}
}
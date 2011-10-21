package org.asnbt
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
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
 * <p>This class reads <strong>NBT</strong>, or
 * <strong>Named Binary Tag</strong> streams, and produces an object graph of
 * subclasses of the <code>Tag</code> object.</p>
 * 
 * <p>The NBT format was created by Markus Persson, and the specification may
 * be found at <a href="http://www.minecraft.net/docs/NBT.txt">
 * http://www.minecraft.net/docs/NBT.txt</a>.</p>
 * @author Graham Edgecombe
 *
 */
public final class NBTInputStream {
	
	/**
	 * The data input stream.
	 */
	private var input:ByteArray;
	
	/**
	 * Creates a new <code>NBTInputStream</code>, which will source its data
	 * from the specified input stream.
	 * @param is The input stream.
	 * @throws Error if an I/O error occurs.
	 */
	public function NBTInputStream(input:ByteArray) :void {
		this.input = input;
	}
	
	/**
	 * Reads an NBT from the stream.
	 * @param depth The depth of this tag.
	 * @return The tag that was read.
	 * @throws Error if an I/O error occurs.
	 */
	public function readTag(depth:int = 0): Tag {
		var type:int = input.readByte() & 0xFF;
		
		var name:String;
		
		if(type != NBTConstants.TYPE_END) {
			var nameLength:int = input.readShort() & 0xFFFF;
			name = String(input.readUTFBytes(nameLength));
		} else {
			name = "";
		}
		
		return readTagPayload(type, name, depth);
	}

	/**
	 * Reads the payload of a tag, given the name and type.
	 * @param type The type.
	 * @param name The name.
	 * @param depth The depth.
	 * @return The tag.
	 * @throws Error if an I/O error occurs.
	 */
	private function readTagPayload(type:int, name:String, depth:int):Tag {
		var tag:Tag;
		
		switch(type) {
		case NBTConstants.TYPE_END:
			if(depth == 0) {
				throw new Error("TAG_End found without a TAG_Compound/TAG_List tag preceding it.");
			} else {
				return new EndTag();
			}
		case NBTConstants.TYPE_BYTE:
			return new ByteTag(name, input.readByte());
		case NBTConstants.TYPE_SHORT:
			return new ShortTag(name, input.readShort());
		case NBTConstants.TYPE_INT:
			return new IntTag(name, input.readInt());
		case NBTConstants.TYPE_LONG:
			return new LongTag(name, input.readDouble());
		case NBTConstants.TYPE_FLOAT:
			return new FloatTag(name, input.readFloat());
		case NBTConstants.TYPE_DOUBLE:
			return new DoubleTag(name, input.readDouble());
		case NBTConstants.TYPE_BYTE_ARRAY:
			var length:int= input.readInt();
			var bytes:ByteArray = new ByteArray();
			input.readBytes(bytes, 0, length);
			return new ByteArrayTag(name, bytes);
		case NBTConstants.TYPE_STRING:
			length = input.readShort();
			return new StringTag(name, input.readUTFBytes(length));
		case NBTConstants.TYPE_LIST:
			var childType:int= input.readByte();
			length = input.readInt();
			
			var tagList:Vector.<Tag> = new Vector.<Tag>();
			for(var i:int = 0; i < length; i++) {
				tag = readTagPayload(childType, "", depth + 1);
				if(tag is EndTag) {
					throw new Error("TAG_End not permitted in a list.");
				}
				tagList.push(tag);
			}
			
			return new ListTag(name, NBTUtils.getTypeClass(childType), tagList);
		case NBTConstants.TYPE_COMPOUND:
			var tagMap:Dictionary = new Dictionary();
			while(true) {
				tag = readTag(depth + 1);
				if(tag is EndTag) {
					break;
				} else {
					tagMap[tag.getName()] = tag;
				}
			}
			
			return new CompoundTag(name, tagMap);
		default:
			throw new Error("Invalid tag type: " + type + ".");
		}
	}
}
}
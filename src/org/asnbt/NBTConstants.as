package org.asnbt
{

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
 * A class which holds constant values.
 * @author Graham Edgecombe
 *
 */
public final class NBTConstants {
	
	/**
	 * Tag type constants.
	 */
	public static const TYPE_END:int = 0;
	public static const TYPE_BYTE:int = 1;
	public static const TYPE_SHORT:int = 2
	public static const TYPE_INT:int = 3;
	public static const TYPE_LONG:int = 4;
	public static const TYPE_FLOAT:int = 5;
	public static const TYPE_DOUBLE:int = 6;
	public static const TYPE_BYTE_ARRAY:int = 7;
	public static const TYPE_STRING:int = 8;
	public static const TYPE_LIST:int = 9;
	public static const TYPE_COMPOUND:int = 10;

}
}
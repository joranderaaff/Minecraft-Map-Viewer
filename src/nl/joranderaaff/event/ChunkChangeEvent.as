/*

Copyright (c) 2011 Joran de Raaff, www.joranderaaff.nl

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/
package nl.joranderaaff.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Joran de Raaff
	 */
	public class ChunkChangeEvent extends Event 
	{
		public static const CHANGE:String = "CHANGE";
		
		public var x:int;
		public var z:int;
		
		public function ChunkChangeEvent(type:String, xIn:int, zIn:int, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			x = xIn;
			z = zIn;
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new ChunkChangeEvent(type, x, z, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ChunkChangeEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}
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
package nl.joranderaaff 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import nl.joranderaaff.event.ChunkChangeEvent;
	import org.asnbt.ByteArrayTag;
	import org.asnbt.CompoundTag;
	import org.asnbt.NBTInputStream;
	/**
	 * ...
	 * @author Joran de Raaff
	 */
	public class SimpleRegionFile extends EventDispatcher
	{
		private static const SECTOR_BYTES:int = 4096;
		private static const ZLIP:int = 2;
		public var x:int = 0;
		public var z:int = 0;
		
		private var _data:ByteArray;
		private var _path:String;
		private var _file:File;
		
		private var _chunkTimeStampsCache:Dictionary;
		private var _modificationDate:Date;
		
		public function SimpleRegionFile(file:File) 
		{
			if (!file.exists)
				throw new Error("File does not exist");
				
			_chunkTimeStampsCache = new Dictionary();
			_file = file;
			
			_modificationDate = _file.modificationDate
			
			var fileName:Array = _file.name.split(".");
			
			x = fileName[1];
			z = fileName[2];
		}
		
		public function reload() : void {
			if (_file.exists && _file.modificationDate.getTime() != _modificationDate.getTime())
			{
				load();
			}
		}
		
		public function load() :void {
			_file.addEventListener(Event.COMPLETE, handleRegionFileLoadComplete);
			_file.load();
		}
		
		private function handleRegionFileLoadComplete(e:Event):void 
		{
			_file.removeEventListener(Event.COMPLETE, handleRegionFileLoadComplete);
			_data = _file.data;
			
			for (var cx:int = 0; cx < 32; cx++) {
				for (var cz:int = 0; cz < 32; cz++) {
					var chunkInfoPosition:int = (cx + cz * 32);
					
					_data.position = chunkInfoPosition * 4;
					
					var offset:int = _data.readInt();
					var sectorNumber:int = offset >> 8;
					
					if (sectorNumber > 0)
					{
						_data.position = chunkInfoPosition * 4 + SECTOR_BYTES;
						
						var timeStamp:int = _data.readInt();
						
						if (_chunkTimeStampsCache[chunkInfoPosition] != timeStamp) {
							_chunkTimeStampsCache[chunkInfoPosition] = timeStamp;
							dispatchEvent(new ChunkChangeEvent(ChunkChangeEvent.CHANGE, (x * 32) + cx, (z * 32) + cz));
						}
					}
				}
			}
		}
		
		public function getBlockData(chunkX:int, chunkZ:int) : ByteArray {
			var cx:int = chunkX % 32;
			var cz:int = chunkZ % 32;
			
			if (cx < 0) cx += 32;
			if (cz < 0) cz += 32;
			
			var chunkInfoPosition:int = (cx + cz * 32);
			
			_data.position = chunkInfoPosition * 4;
			
			var offset:int = _data.readInt();
			var sectorNumber:int = offset >> 8;
			
			if (sectorNumber > 0)
			{
				_data.position = sectorNumber * SECTOR_BYTES;
					
				var length:int = _data.readInt();
				var compressionType:uint = _data.readByte();
				
				if (compressionType == ZLIP) {
					var chunkData:ByteArray = new ByteArray();
					_data.readBytes(chunkData, 0, length - 1);
					
					chunkData.uncompress();
					
					var nbtInputStream:NBTInputStream = new NBTInputStream(chunkData);
					var tag:CompoundTag = nbtInputStream.readTag() as CompoundTag;
					var levelData:CompoundTag = tag.getValue()['Level'];
					var blocks:ByteArrayTag = levelData.getValue()['Blocks'];
					return blocks.getValue();
				}
			}
			
			return null;
		}
	}
}
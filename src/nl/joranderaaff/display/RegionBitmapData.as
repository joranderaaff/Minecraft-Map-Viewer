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
package nl.joranderaaff.display 
{
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Joran de Raaff
	 */
	public class RegionBitmapData extends BitmapData 
	{
		public var regionX:int;
		public var regionZ:int;
		
		public function RegionBitmapData() 
		{
			super(512, 512, true, 0xFF000000);
		}
		
		public function renderBlocks(blockData:ByteArray, chunkX:int, chunkZ:int) : void {
			this.lock();
			
			chunkX = chunkX % 32;
			chunkZ = chunkZ % 32;
			if (chunkX < 0) chunkX += 32;
			if (chunkZ < 0) chunkZ += 32;
			
			var blockPosition:int;
			var blockType:int;
			var color:int;
			var blocksDrawn:int = 0;
			for (var bx:int = 0; bx < 16; bx++) {
				for (var bz:int = 0; bz < 16; bz++) {
					for (var by:int = 127; by >= 0; by--) {
						blockPosition = by + bz * 128 + bx * 128 * 16;
						blockData.position = blockPosition;
						blockType = blockData.readByte();
						if (blockType != 0) {
							blocksDrawn ++;
							color = getShadedColor(ColorHelper.getColor(blockType), by);
							super.setPixel((chunkZ*16) + bz, (chunkX*16) + bx, color);
							break;
						}
					}
				}
			}
			this.unlock();
		}
		
		private function getShadedColor(color:int, depth:int):int {
			var r:int = ((color >> 16) & 0xFF) * ((depth) / 127);
			var g:int = ((color >> 8) & 0xFF) * ((depth) / 127);
			var b:int = (color & 0xFF) * ((depth) / 127);
			
			r = (r > 255) ? 255 : r;
			g = (g > 255) ? 255 : g;
			b = (b > 255) ? 255 : b;
			
			r = (r < 0) ? 0 : r;
			g = (g < 0) ? 0 : g;
			b = (b < 0) ? 0 : b;
			
			return 0xFF000000 + (r<<16) + (g<<8) + b;
		}
	}

}
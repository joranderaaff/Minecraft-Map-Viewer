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
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Joran de Raaff
	 */
	public class ColorHelper 
	{
		private static var colorMap:Dictionary = new Dictionary();
		
		private static function setColor(blockType:int, r:int, g:int, b:int, ... args):void
		{
			colorMap[blockType] = 0xFF000000 + (r << 16) + (g << 8) + b;
		}
		
		public static function getColor(blockType:int) : int {
			return colorMap[blockType];
		}
		
		public static function init() : void {
			setColor(0, 255,255,255,0);
			setColor(1, 128,128,128,255, 16);
			setColor(2, 102,142,62,255, 14);
			setColor(3, 134,96,67,255, 22);
			setColor(4, 115,115,115,255, 24);
			setColor(5, 157,128,79,255, 11);
			setColor(6, 120,120,120,0);
			setColor(7, 84,84,84,255);
			setColor(8, 38,92,225,36);
			setColor(9, 38,92,225,36);
			setColor(10, 255,90,0,255);
			setColor(11, 255,90,0,255);
			setColor(12, 220,212,160,255, 14);
			setColor(13, 136,126,126,255, 24);
			setColor(14, 143,140,125,255);
			setColor(15, 136,130,127,255);
			setColor(16, 115,115,115,255);
			setColor(17, 102,81,51,255);
			setColor(18, 54,135,40,180, 12);
			setColor(20, 255,255,255,40);
			setColor(21, 102, 112, 134, 255, 10);
			setColor(22, 29, 71, 165, 255, 5);
			setColor(23, 107, 107, 107, 255);
			setColor(24, 218, 210, 158, 255, 7);
			setColor(25, 100, 67, 50, 255, 10);
			setColor(26, 175,116,116, 254);
			setColor(27, 160,134,72,250);
			setColor(28, 120,114,92,250);
			setColor(29, 106,102,95,255);
			setColor(29, 220,220,220,190);
			setColor(31, 110,166,68,254, 12);
			setColor(32, 123,79,25,254, 25);
			setColor(33, 106,102,95,255);
			setColor(34, 153,129,89,255);
			setColor(35, 222,222,222,255); //Color(143,143,143,255);
			//setColor(36, 222,222,222,255);
			setColor(37, 255,0,0,254); 
			setColor(38, 255,255,0,254); 
			setColor(39, 128,100,0,254); 
			setColor(40, 140,12,12,254); 
			setColor(41, 231,165,45,255);
			setColor(42, 191,191,191,255);
			setColor(43, 200,200,200,255);
			setColor(44, 200,200,200,254); 
			setColor(45, 170,86,62,255);
			//setColor(BRICKSTEP, 170,86,62,254);
			setColor(46, 160,83,65,255);
			setColor(48, 90,108,90,255, 27);
			setColor(49, 26,11,43,255);
			setColor(50, 245,220,50,200);
			setColor(51, 255,170,30,200);
			setColor(52, 20,170,200,255);
			setColor(53, 157,128,79,255);
			setColor(54, 125,91,38,255);
			setColor(55, 200,10,10,200);
			setColor(56, 129,140,143,255);
			setColor(57, 45,166,152,255);
			setColor(58, 114,88,56,255);
			setColor(59, 146,192,0,255);
			setColor(60, 95,58,30,255);
			setColor(61, 96,96,96,255);
			setColor(62, 96,96,96,255);
			setColor(63, 111,91,54,255);
			setColor(64, 136,109,67,255);
			setColor(65, 181,140,64,32);
			setColor(66, 140,134,72,250);
			setColor(67, 115,115,115,255);
			setColor(71, 191,191,191,255);
			setColor(73, 131,107,107,255);
			setColor(74, 131,107,107,255);
			setColor(75, 181,100,44,254);
			setColor(76, 255,0,0,254);
			setColor(78, 245,246,245,254, 13); 
			setColor(79, 125,173,255,159, 7);
			setColor(80, 250,250,250,255);
			setColor(81, 25,120,25,255);
			setColor(82, 151,157,169,255);
			setColor(83, 183,234,150,255);
			setColor(84, 100,67,50,255);
			setColor(85, 137,112,65,225); 
			setColor(86, 197,120,23,255);
			setColor(87, 110,53,51,255, 16);
			setColor(88, 84,64,51,255, 7);
			setColor(89, 137,112,64,255, 11);
			setColor(90, 0,42,255,127);
			setColor(91, 185,133,28,255);
			setColor(92, 228, 205, 206, 255, 7);
			setColor(93, 151,147,147, 255, 2);
			setColor(94, 161,147,147, 255, 2);
			setColor(95, 125,91,38,255);
			setColor(96, 126,93,45,240, 5);
			setColor(97, 128,128,128,255, 16);
			setColor(98, 122,122,122,255, 7);
			//setColor(STONEBRICKSTEP, 122,122,122,254, 7);
			setColor(99, 141,106,83,255, 0);
			setColor(100, 182,37,36,255, 6);
			setColor(101, 109,108,106,254, 6);
			setColor(102, 255,255,255,40);
			setColor(103, 151,153,36,255, 10);
			setColor(104, 115,170,73,254);
			setColor(105, 115,170,73,254);
			setColor(106, 51,130,36,180, 12);
			setColor(107, 137,112,65,225);
			setColor(108, 170,86,62,255);
			setColor(109, 122,122,122,255, 7);
			setColor(110, 140,115,119,255, 14);
			setColor(111, 85,124,60,254);
			setColor(112, 54,24,30,255, 7);
			setColor(113, 54,24,30,225);
			setColor(114, 54,24,30,255);
			setColor(115, 112,8,28,254);
			//setColor(SANDSTEP, 218, 210, 158, 254, 7); 
			//setColor(WOODSTEP, 157,128,79,254, 11); 
			//setColor(COBBLESTEP, 115,115,115,254, 26); 
			//setColor(PINELEAVES, 44,84,44,160, 20); // Pine leaves
			//setColor(BIRCHLEAVES, 85,124,60,170, 11); // Birch leaves
			//setColor(238, 70,50,32, 255); // Pine trunk
			//setColor(239, 206,206,201, 255, 5); // Birch trunk
			//setColor(240, 244,137,54, 255); // Dyed wool
			//setColor(241, 200,75,210,255);
			//setColor(242, 120,158,241, 255);
			//setColor(243, 204,200,28, 255);
			//setColor(244, 59,210,47, 255);
			//setColor(245, 237,141,164, 255);
			//setColor(246, 76,76,76, 255);
			//setColor(247, 168,172,172, 255);
			//setColor(248, 39,116,149, 255);
			//setColor(249, 133,53,195, 255);
			//setColor(250, 38,51,160, 255);
			//setColor(251, 85,51,27, 255);
			//setColor(252, 55,77,24, 255);
			//setColor(253, 173,44,40, 255);
			//setColor(254, 32,27,27, 255);
		}
	}

}
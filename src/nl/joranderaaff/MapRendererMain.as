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
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FileListEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import nl.joranderaaff.display.ColorHelper;
	import nl.joranderaaff.display.RegionBitmapData;
	import nl.joranderaaff.event.ChunkChangeEvent;
	
	/**
	 * ...
	 * @author Joran de Raaff
	 */
	public class MapRendererMain extends Sprite 
	{
		private static const RENDER_COUNT_PER_FRAME:int = 1;
		
		private var regionFiles:Array = [];
		private var renderEventQeue:Array = [];
		private var rendererByRegionFile:Dictionary = new Dictionary();
		
		private var previousX:int;
		private var previousY:int;
		private var mouseDown:Boolean;
		
		private var bitmapContainer:Sprite;
		private var mouseSprite:Sprite;
		protected var keysDown:Dictionary = new Dictionary();
		
		public function MapRendererMain() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(event:Event = null) : void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var file:File = new File();
			file.addEventListener(Event.SELECT, handleFolderSelected);
			file.browseForDirectory("Select a world folder");
		}
		
		private function handleFolderSelected(event:Event) : void {
			ColorHelper.init();
			
			var file:File = new File(File(event.target).nativePath + File.separator + "region");
			file.addEventListener(FileListEvent.DIRECTORY_LISTING, handleDirectoryRead);
			file.getDirectoryListingAsync();
			
			bitmapContainer = new Sprite();
			addChild(bitmapContainer);
			
			mouseSprite = new Sprite();
			with (mouseSprite) {
				graphics.beginFill(0x0000FF00);
				graphics.drawRect(0, 0, this.stage.stageWidth, this.stage.stageHeight);
			}
			mouseSprite.alpha = 0;
			addChild(mouseSprite);
			
			stage.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
			stage.addEventListener(Event.RESIZE, handleResize);
			
			mouseSprite.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			mouseSprite.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			mouseSprite.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
			
			stage.focus = stage;
			
			//addChild(new Stats());
		}
		
		protected function handleResize(e:Event):void 
		{
			mouseSprite.width = stage.stageWidth;
			mouseSprite.height = stage.stageHeight;
		}
		
		protected function handleKeyUp(e:KeyboardEvent):void 
		{
			keysDown[e.keyCode] = null;
			delete keysDown[e.keyCode];
		}
		
		protected function handleKeyDown(e:KeyboardEvent):void 
		{
			keysDown[e.keyCode] = true;
		}
		
		protected function handleMouseUp(e:MouseEvent):void 
		{
			mouseDown = false;
		}
		
		protected function handleMouseDown(e:MouseEvent):void 
		{
			mouseDown = true;
			previousX = e.stageX;
			previousY = e.stageY;
		}
		
		protected function handleMouseMove(e:MouseEvent):void 
		{
			if (mouseDown) {
				var dx:int = previousX - e.stageX;
				var dy:int = previousY - e.stageY;
				
				previousX = e.stageX;
				previousY = e.stageY;
				
				bitmapContainer.x -= dx;
				bitmapContainer.y -= dy;
			}
		}
		
		protected function handleDirectoryRead(event:FileListEvent):void 
		{
			var file:File;
			var simpleRegionFile:SimpleRegionFile;
			
			var maxX:int = int.MIN_VALUE;
			var maxY:int = int.MIN_VALUE;
			var minX:int = int.MAX_VALUE;
			var minY:int = int.MAX_VALUE;
			
			for each(file in event.files) {
				simpleRegionFile = new SimpleRegionFile(file);
				simpleRegionFile.addEventListener(ChunkChangeEvent.CHANGE, handleChunkChanged);
				
				regionFiles.push(simpleRegionFile);
				
				var renderer:RegionBitmapData = new RegionBitmapData();
				renderer.regionX = simpleRegionFile.x;
				renderer.regionZ = simpleRegionFile.z;
				
				rendererByRegionFile[simpleRegionFile] = renderer;
				
				var bitmap:Bitmap = new Bitmap(renderer);
				bitmap.y = simpleRegionFile.x * 512;
				bitmap.x = simpleRegionFile.z * 512;
				
				//get the min and max x and y
				maxX = Math.max(bitmap.x + bitmap.width, maxX);
				maxY = Math.max(bitmap.y + bitmap.height, maxY);
				minX = Math.min(bitmap.x, minX);
				minY = Math.min(bitmap.y, minY);
				
				bitmapContainer.addChild(bitmap);
				
				simpleRegionFile.load();
			}
			
			var centerX:int = (maxX + minX) / 2;
			var centerY:int = (maxY + minY) / 2;
			
			bitmapContainer.x = stage.stageWidth / 2 - centerX;
			bitmapContainer.y = stage.stageHeight / 2 - centerY;
		}
		
		protected function renderByChunkEvent(event:ChunkChangeEvent) : void
		{
			var simpleRegionFile:SimpleRegionFile = SimpleRegionFile(event.target);
			var renderer:RegionBitmapData = rendererByRegionFile[simpleRegionFile];
			var blockData:ByteArray = simpleRegionFile.getBlockData(event.x, event.z);
			renderer.renderBlocks(blockData, event.x, event.z);
		}
		
		//--------------------------------------------------------------------------------------- Event Handling
		
		protected function handleEnterFrame(event:Event) : void 
		{
			var renderCount:int = 0;
			
			var time:int = getTimer();
			
			while (renderEventQeue.length > 0 && (getTimer() - time) < (1/20) * 1000) {
				renderByChunkEvent(renderEventQeue.pop());
				renderCount ++;
			}
			
			if (keysDown[38]) bitmapContainer.y += 32;
			if (keysDown[40]) bitmapContainer.y -= 32;
			if (keysDown[37]) bitmapContainer.x += 32;
			if (keysDown[39]) bitmapContainer.x -= 32;
		}
		
		protected function handleChunkChanged(event:ChunkChangeEvent) : void 
		{
			renderEventQeue.push(event);
		}
	}

}
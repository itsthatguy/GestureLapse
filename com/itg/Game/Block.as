package com.itg.Game
{

  import flash.ui.Multitouch;
  import flash.ui.MultitouchInputMode;

  import flash.display.MovieClip;
  import flash.events.Event;
  import flash.events.TransformGestureEvent;
  import flash.text.TextField;
  import flash.events.MouseEvent;


  public class Block extends MovieClip
  {
    internal const BLOCK_AIR = 0,
           BLOCK_EARTH = 1,
           BLOCK_WATER = 2,
           BLOCK_FIRE = 3;

    internal var _blockType:int;

    private var _isHit:Boolean = false;
    public var col:int;
    public var row:int;
    public var console:TextField = new TextField();

    public function Block()
    {
      // constructor code
      trace("Block()::Init");

      //addChild(console);
      console.text = "test";
      console.x = -44;
      console.y = -44;
      console.width = 88;
      console.height = 88;
      //console.border = true;
      console.mouseEnabled = false;
      console.selectable = false;

      // Swipe Handler
      Multitouch.inputMode = MultitouchInputMode.GESTURE;
      this.addEventListener(TransformGestureEvent.GESTURE_SWIPE, HandleSwipe);

      // Click
      this.addEventListener(MouseEvent.CLICK, HandleClick);
    }

    public function Move(speed:Number, nRow:Number):void
    {
      if (!_isHit)
      {
        this.y += speed;
      }
      //console.text = String(this.y);
    }

    public function SetHit(b:Boolean):void
    {
      _isHit = b;
    }

    internal function SetBlockType(type:int):void
    {
      _blockType = type;
    }

    private function HandleSwipe(e:TransformGestureEvent):void
    {
      var shouldDestroy:Boolean = false;

      if (_blockType == BLOCK_AIR && e.offsetY == 1)
      {
        shouldDestroy = true;
      }
      if (_blockType == BLOCK_EARTH && e.offsetY == -1)
      {
        shouldDestroy = true;
      }
      if (_blockType == BLOCK_WATER && e.offsetX == 1)
      {
        shouldDestroy = true;
      }
      if (_blockType == BLOCK_FIRE && e.offsetY == -1)
      {
        shouldDestroy = true;
      }
      else
      {

      }

      if (shouldDestroy) dispatchEvent(new Event("Block.DESTROY"));
    }

    private function HandleClick(e:MouseEvent):void
    {
      var sF:SwipeFail = new SwipeFail();
      sF.addEventListener("Effect.DESTROY", DestroySwipeEffect);
      addChild(sF);
      //sF.x = this.x;
      //sF.y = this.y;

      if (_blockType == BLOCK_AIR)
      {
        trace("AIR");
      }
      else if (_blockType == BLOCK_EARTH)
      {
        trace("EARTH");
      }
      else if (_blockType == BLOCK_WATER)
      {
        trace("WATER");
      }
      else if (_blockType == BLOCK_FIRE)
      {
        trace("FIRE");

      }
      else
      {
        trace(e.target);
      }
    }

    private function DestroySwipeEffect(e:Event):void
    {
      removeEventListener("Effect.DESTROY", DestroySwipeEffect);
      removeChild(SwipeFail(e.target));
    }

  }

}

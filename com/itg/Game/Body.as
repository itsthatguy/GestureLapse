package com.itg.Game
{
  import flash.display.MovieClip;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.display.Shape;

public class Body extends MovieClip
{

  private const ROWS:int    = 4;
  private const COLS:int    = 3;
  private const BLOCK_AIR   = 0,
          BLOCK_FIRE  = 1,
          BLOCK_WATER   = 2,
          BLOCK_EARTH   = 3;

  private const POSX      = [70, 160, 250];
  private const MAXY      = 360,
          BLOCKY    = 98;

  private const MOVE_SPEED  = 16;

  internal var YouBeDead = false;
  private var _isMouseDown:Boolean = false;

  private var _stage:Shape = new Shape();

  private var blocks:Array = new Array();


  public function Body()
  {
    super();

    _stage.graphics.beginFill(0x00000, .2);
    _stage.graphics.drawRoundRect(0, 0, 320, 420, 0);
    _stage.graphics.endFill();
    addChild(_stage);

    addEventListener(MouseEvent.MOUSE_DOWN, SetDown);
    addEventListener(MouseEvent.MOUSE_UP, SetUp);

    for (var i:int = 0; i<COLS; i++)
    {
      blocks[i] = new Array();
    }
  }

  function SetDown(e:Event):void
  {
    _isMouseDown = true;
  }

  function SetUp(e:Event):void
  {
    _isMouseDown = false;
  }

  public function SpawnBlock():void
  {
    var blockSeed:int = Math.round((Math.random() * 3));
    var colSeed:int = Math.round(Math.random() * (COLS - 1));
    var block:*;

    if (blockSeed == BLOCK_AIR) block = new BlockAir();
    if (blockSeed == BLOCK_FIRE) block = new BlockFire();
    if (blockSeed == BLOCK_WATER) block = new BlockWater();
    if (blockSeed == BLOCK_EARTH) block = new BlockEarth();

    block.x = POSX[colSeed];
    block.y = - 44;
    addChild(block);
    block.addEventListener("Block.DESTROY", DestroyBlock);

    //add to dataobject
    blocks[colSeed].push(block);
    block.col = colSeed;
    block.row = (blocks[colSeed].length - 1);

  }

  public function Update():void
  {
    // handle mouse effects
    if (_isMouseDown)
    {

      var mE:MouseEffect = new MouseEffect();
      mE.addEventListener("Effect.DESTROY", DestroyMouseEffect);
      mE.mouseChildren = false;
      mE.mouseEnabled = false;
      addChild(mE);
      mE.rotation = Math.random() * 360;
      mE.x = mouseX;
      mE.y = mouseY;

    }

    // process blocks
    for (var col:int = 0; col<COLS; col++)
    {
      for (var row:int = 0; row<blocks[col].length; row++)
      {
        var block:* = blocks[col][row];
        block.Move(MOVE_SPEED, row);

        CheckCollision(row, col);
      }
    }

  }

  private function DestroyMouseEffect(e:Event):void
  {
    removeEventListener("Effect.DESTROY", DestroyMouseEffect);
    removeChild(MouseEffect(e.target));
  }

  private function CheckCollision(row:int, col:int):void
  {
    var block:* = blocks[col][row];
    if (block.y >= MAXY)
    {
      block.SetHit(true);
    }
    if (block.y >= MAXY - (BLOCKY * row))
    {
      block.SetHit(true);
      block.y = MAXY - (BLOCKY * row);
      if (row == ROWS)
      {
        YouBeDead = true;

        dispatchEvent(new Event("Game.PAUSE"));
      }
    }
  }

  private function DestroyBlock(e:Event):void
  {
    var block:Block = Block(e.target);
    var col:int = block.col;
    var row:int;
    var foundIt:Boolean = false;
    var nBlock:Block;
    trace("block : " + col + " : " + block.row);

    for (var i:int = 0; i<blocks[col].length; i++)
    {
      nBlock = Block(blocks[col][i]);

      if (blocks[col][i] == block)
      {
        row = i;
        foundIt = true;
      }
      else
      {
        if (foundIt == true)
        {
          nBlock.y += 16;
          nBlock.row -= 1;
          nBlock.SetHit(false);
        }
      }
    }

    trace("Outside Loop : " + col + " : " + row);
    removeChild(block);
    blocks[col].splice(row,1);
  }

}

}

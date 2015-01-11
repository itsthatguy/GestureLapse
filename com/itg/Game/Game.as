package com.itg.Game
{

import com.itg.Engine.Time;
import com.itg.Game.Body;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

public class Game extends MovieClip
{


  private var dT:Number;
  private var n:Number = 0;
  private var body:Body = new Body();

  private var ScreenLayer:Sprite;
  private var _pauseButton:PauseButton;
  private var _pauseScreen:PauseScreen;
  private var _loserScreen:LoserScreen;

  private var _scoreText:TextField;

  private var isItPlaying:Boolean = true;

  public function Game()
  {
    super();

    addChild(body);

    Time.addEventListener("Time.UPDATE", Update);
    body.addEventListener("Game.PAUSE", HandlePause);

    // Setup Interface
    ScreenLayer = new Sprite();
    addChild(ScreenLayer);

    SetupUI();
    PauseGame();

  }

  private function SetupUI():void
  {

    // Score Text
    var tf:TextFormat = new TextFormat();
    tf.align = TextFormatAlign.RIGHT;
    tf.size = 24;

    _scoreText = new TextField();
    _scoreText.width = 120;
    _scoreText.height = 30;

    _scoreText.x = 190;
    _scoreText.y = 8;
    _scoreText.textColor = 0x990000;
    _scoreText.background = false;
    _scoreText.backgroundColor = 0xFFFFFF;
    _scoreText.text = "0";
    _scoreText.setTextFormat(tf);
    addChild(_scoreText);


    // Screen Overlays
    _pauseScreen = new PauseScreen();
    _loserScreen = new LoserScreen();

    _pauseButton =  new PauseButton();
    _pauseButton.addEventListener(MouseEvent.CLICK, HandlePause);
    _pauseButton.x = 160 - (_pauseButton.width / 2);
    _pauseButton.y = 480 - _pauseButton.height;

    addChild(_pauseButton);

  }

  public function Update(e:Event):void
  {
    if (isItPlaying)
    {
      n += Time.deltaTime;
      if (n >= 2)
      {
        n = 0;
        body.SpawnBlock();
      }

      body.Update();
    }
  }

  private function HandlePause(e:Event):void
  {
    PauseGame();
  }

  public function StartGame():void
  {

  }

  private function PauseGame():void
  {

    isItPlaying = !isItPlaying;

    if (!isItPlaying)
    {
      if (!body.YouBeDead) ScreenLayer.addChild(_pauseScreen);
      if (body.YouBeDead) ScreenLayer.addChild(_loserScreen);

    }
    else ScreenLayer.removeChild(_pauseScreen);
  }

  public function EndGame():void
  {
  }


}

}

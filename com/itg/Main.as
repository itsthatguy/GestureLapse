package com.itg
{

  import flash.display.MovieClip;
  import flash.events.Event;
  import com.itg.Engine.Time;

  import com.itg.Game.Game;


  public class Main extends MovieClip
  {
    private var firstRun:Boolean = true;

    private var game:Game;

    public function Main()
    {
      // constructor code
      if (firstRun)
      {
        GotoGame();
      }


    }

    static public function GotoFrontEnd():void
    {

    }

    private function GotoGame():void
    {
      game = new Game();
      addChild(game);
    }

    internal function LoadLevel():void
    {

    }

    static public function NextLevel():void
    {

    }

    static public function MainMenu():void
    {

    }

  }


}

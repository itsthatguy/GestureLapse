package com.itg.Engine
{

  import flash.display.MovieClip;
  import flash.events.Event;
  import flash.utils.getTimer;


  public class Time extends MovieClip
  {

    static private var _instance:Time = new Time();
    static private var _currentTime:int;
    static private var _previousTime:int;
    static public var Events:Object;

    static public var Controller:Object = new Object;

    public function Time()
    {
      // constructor code
      if (_instance)
      {
        throw new Error("The Time class cannot be instantiated.");
      }
      addEventListener(Event.ENTER_FRAME, updateTime, false, 0, true);
      _currentTime = getTimer();
    }

    private function updateTime(e:Event):void
    {
      _previousTime = _currentTime;
      _currentTime = getTimer();
      Time.dispatchEvent(new Event("Time.UPDATE"));
    }

    static public function get deltaTime():Number
    {
      return (_currentTime-_previousTime)/1000;
    }

    static public function Update():void
    {
      Events.dispatchEvent(new Event("Time.UPDATE"));
    }

    /**
           * Returns a instance of the class Test.
         * @return  A instance of Test.
         */
        public static function getInstance():Time
        {
            if (_instance == null)
                _instance = new Time();

            return _instance;
        }

        /// Registers an event listener object with an EventDispatcher object so that the listener receives notification of an event.
        public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
        {
            getInstance().addEventListener(type, listener, useCapture, priority, useWeakReference);
        }

        /// Dispatches an event into the event flow.
        public static function dispatchEvent(event:Event):Boolean
        {
            return getInstance().dispatchEvent(event);
        }

        /// Removes a listener from the EventDispatcher object.
        public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
        {
            getInstance().removeEventListener(type, listener, useCapture);
        }

        /// Checks whether the EventDispatcher object has any listeners registered for a specific type of event.
        public static function hasEventListener(type:String):Boolean
        {
            return getInstance().hasEventListener(type);
        }

        /// Checks whether an event listener is registered with this EventDispatcher object or any of its ancestors for the specified event type.
        public static function willTrigger(type:String):Boolean
        {
            return getInstance().willTrigger(type);
        }

  }


}

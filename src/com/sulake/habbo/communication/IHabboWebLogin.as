
package com.sulake.habbo.communication
{
    import flash.events.IEventDispatcher;

    public interface IHabboWebLogin extends IEventDispatcher 
    {

        function requestReAuthenticate():void;
        function init():void;

    }
}//package com.sulake.habbo.communication

// requestReAuthenticate = "_-0QM" (String#4100, DoABC#2)
// IHabboWebLogin = "_-0eC" (String#4394, DoABC#2)



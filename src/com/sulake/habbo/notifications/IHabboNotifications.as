
package com.sulake.habbo.notifications
{
    import com.sulake.core.runtime.IUnknown;

    public interface IHabboNotifications extends IUnknown 
    {

        function showGenericNotification(_arg_1:String):void;
        function addSongPlayingNotification(_arg_1:String, _arg_2:String):void;

    }
}//package com.sulake.habbo.notifications

// showGenericNotification = "_-1Mw" (String#5290, DoABC#2)
// addSongPlayingNotification = "_-fE" (String#8499, DoABC#2)
// IHabboNotifications = "_-0uT" (String#4734, DoABC#2)



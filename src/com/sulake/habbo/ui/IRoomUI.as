
package com.sulake.habbo.ui
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.habbo.session.IRoomSession;

    public interface IRoomUI extends IUnknown 
    {

        function createDesktop(_arg_1:IRoomSession):IRoomDesktop;
        function disposeDesktop(_arg_1:String):void;
        function getDesktop(_arg_1:String):IRoomDesktop;

    }
}//package com.sulake.habbo.ui

// IRoomSession = "_-2e4" (String#6835, DoABC#2)
// createDesktop = "_-2Oo" (String#6537, DoABC#2)
// disposeDesktop = "_-34F" (String#7394, DoABC#2)
// IRoomDesktop = "_-2iD" (String#6912, DoABC#2)
// IRoomUI = "_-2g2" (String#6867, DoABC#2)



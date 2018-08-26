
package com.sulake.habbo.roomevents.userdefinedroomevents
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public interface Element 
    {

        function get code():int;
        function get requiresFurni():int;
        function Element(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):void;
        function Element(_arg_1:IWindowContainer, _arg_2:Triggerable):void;
        function Element(_arg_1:IWindowContainer):Array;
        function Element(_arg_1:IWindowContainer):String;
        function get hasSpecialInputs():Boolean;
        function get hasStateSnapshot():Boolean;

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents

// Triggerable = "_-2oD" (String#7043, DoABC#2)
// Element = "_-zj" (String#8875, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// requiresFurni = "_-1i4" (String#5711, DoABC#2)
// hasStateSnapshot = "_-2bG" (String#6777, DoABC#2)
// Element = "_-10U" (String#4881, DoABC#2)
// Element = "_-2Cw" (String#6305, DoABC#2)
// Element = "_-0uD" (String#4727, DoABC#2)
// Element = "_-gW" (String#8522, DoABC#2)
// hasSpecialInputs = "_-pV" (String#8699, DoABC#2)



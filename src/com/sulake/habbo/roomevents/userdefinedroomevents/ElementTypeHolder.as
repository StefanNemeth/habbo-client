
package com.sulake.habbo.roomevents.userdefinedroomevents
{
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public interface ElementTypeHolder 
    {

        function getElementByCode(_arg_1:int):Element;
        function getKey():String;
        function acceptTriggerable(_arg_1:Triggerable):Boolean;

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents

// Triggerable = "_-2oD" (String#7043, DoABC#2)
// Element = "_-zj" (String#8875, DoABC#2)
// ElementTypeHolder = "_-0P4" (String#4071, DoABC#2)
// getElementByCode = "_-2v7" (String#7181, DoABC#2)
// acceptTriggerable = "_-29f" (String#6243, DoABC#2)



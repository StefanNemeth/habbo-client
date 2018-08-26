
package com.sulake.core.communication.messages
{
    public interface IMessageClassManager 
    {

        function registerMessages(_arg_1:IMessageConfiguration):Boolean;
        function getMessageComposerID(_arg_1:IMessageComposer):int;
        function getMessageEventClasses(_arg_1:int):Array;

    }
}//package com.sulake.core.communication.messages

// IMessageConfiguration = "_-EK" (String#7959, DoABC#2)
// IMessageClassManager = "_-2if" (String#6924, DoABC#2)
// getMessageComposerID = "_-2Ur" (String#6664, DoABC#2)
// registerMessages = "_-2Qq" (String#6573, DoABC#2)
// getMessageEventClasses = "_-1Uo" (String#5450, DoABC#2)



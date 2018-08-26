
package com.sulake.habbo.tracking
{
    import com.sulake.core.runtime.IUnknown;

    public interface IHabboTracking extends IUnknown 
    {

        function trackGoogle(_arg_1:String, _arg_2:String, _arg_3:int=-1):void;
        function legacyTrackGoogle(_arg_1:String, _arg_2:String, _arg_3:Array=null):void;
        function logError(_arg_1:String):void;
        function chatLagDetected(_arg_1:int):void;

    }
}//package com.sulake.habbo.tracking

// chatLagDetected = "_-1JX" (String#5231, DoABC#2)
// legacyTrackGoogle = "_-0A8" (String#3760, DoABC#2)
// logError = "_-2vF" (String#7182, DoABC#2)
// IHabboTracking = "_-0fl" (String#4419, DoABC#2)
// trackGoogle = "_-3Fx" (String#7630, DoABC#2)



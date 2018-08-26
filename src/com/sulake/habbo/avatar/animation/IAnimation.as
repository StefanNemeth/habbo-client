
package com.sulake.habbo.avatar.animation
{
    public interface IAnimation 
    {

        function hasSpriteData():Boolean;
        function hasAvatarData():Boolean;
        function hasCanvasData():Boolean;
        function hasDirectionData():Boolean;
        function hasShadowData():Boolean;
        function hasRemoveData():Boolean;
        function hasAddData():Boolean;
        function get id():String;
        function get description():String;
        function get spriteData():Array;
        function get canvasData():Array;
        function get removeData():Array;
        function get addData():Array;

    }
}//package com.sulake.habbo.avatar.animation

// IAnimation = "_-2l8" (String#6983, DoABC#2)
// removeData = "_-09h" (String#3752, DoABC#2)
// hasSpriteData = "_-0B" (String#3777, DoABC#2)
// hasAvatarData = "_-0wo" (String#4786, DoABC#2)
// hasCanvasData = "_-3AB" (String#7518, DoABC#2)
// hasDirectionData = "_-1O5" (String#5312, DoABC#2)
// hasShadowData = "_-2Ci" (String#6298, DoABC#2)
// hasRemoveData = "_-RP" (String#8234, DoABC#2)
// hasAddData = "_-2rO" (String#7110, DoABC#2)
// spriteData = "_-2BE" (String#6273, DoABC#2)
// canvasData = "_-1zx" (String#6030, DoABC#2)
// addData = "_-2Py" (String#6561, DoABC#2)



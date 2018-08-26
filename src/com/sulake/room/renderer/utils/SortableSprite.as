
package com.sulake.room.renderer.utils
{
    import com.sulake.room.object.visualization.IRoomObjectSprite;

    public class SortableSprite 
    {

        public static const _SafeStr_14449:Number = 100000000;

        public var x:int = 0;
        public var y:int = 0;
        public var z:Number = 0;
        public var name:String = "";
        public var sprite:IRoomObjectSprite = null;

        public function dispose():void
        {
            this.sprite = null;
            this.z = -(_SafeStr_14449);
        }

    }
}//package com.sulake.room.renderer.utils

// _SafeStr_14449 = "_-Xr" (String#23556, DoABC#2)
// IRoomObjectSprite = "_-0di" (String#4386, DoABC#2)
// SortableSprite = "_-0J3" (String#3936, DoABC#2)



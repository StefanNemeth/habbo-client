
package com.sulake.core.window.graphics.renderer
{
    import com.sulake.core.window.utils.IChildEntity;
    import flash.geom.Rectangle;

    public class SkinLayoutEntity implements IChildEntity 
    {

        public static const _SafeStr_4086:uint = (0 << 0);
        public static const _SafeStr_4079:uint = (1 << 0);
        public static const _SafeStr_4080:uint = (1 << 1);
        public static const _SafeStr_4081:uint = (1 << 2);
        public static const _SafeStr_4082:uint = (1 << 3);

        private var _id:uint;
        private var _name:String;
        public var color:uint;
        public var blend:uint;
        public var _SafeStr_4078:uint;
        public var _SafeStr_4083:uint;
        public var region:Rectangle;
        public var colorize:Boolean;

        public function SkinLayoutEntity(_arg_1:uint, _arg_2:String)
        {
            this._id = _arg_1;
            this._name = _arg_2;
        }
        public function get id():uint
        {
            return (this._id);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get tags():Array
        {
            return (null);
        }
        public function dispose():void
        {
            this.region = null;
        }

    }
}//package com.sulake.core.window.graphics.renderer

// IChildEntity = "_-1NX" (String#5302, DoABC#2)
// SkinLayoutEntity = "_-27j" (String#6196, DoABC#2)
// _SafeStr_4078 = "_-30D" (String#21509, DoABC#2)
// _SafeStr_4079 = "_-0Lq" (String#14907, DoABC#2)
// _SafeStr_4080 = "_-2Gj" (String#19670, DoABC#2)
// _SafeStr_4081 = "_-0AU" (String#14466, DoABC#2)
// _SafeStr_4082 = "_-0dp" (String#15577, DoABC#2)
// _SafeStr_4083 = "_-2vf" (String#21301, DoABC#2)
// _SafeStr_4086 = "_-0SW" (String#15154, DoABC#2)



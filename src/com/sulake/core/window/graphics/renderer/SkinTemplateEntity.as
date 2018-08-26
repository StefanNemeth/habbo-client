
package com.sulake.core.window.graphics.renderer
{
    import flash.geom.Rectangle;
    import com.sulake.core.utils.Map;

    public class SkinTemplateEntity implements ISkinTemplateEntity 
    {

        protected var _id:uint;
        protected var _name:String;
        protected var _type:String;
        protected var _rectangle:Rectangle;
        protected var _SafeStr_4095:Map;
        protected var _tags:Array;

        public function SkinTemplateEntity(_arg_1:String, _arg_2:String, _arg_3:uint, _arg_4:Rectangle, _arg_5:Map)
        {
            this._id = _arg_3;
            this._name = _arg_1;
            this._type = _arg_2;
            this._rectangle = _arg_4;
            this._SafeStr_4095 = (((_arg_5 == null)) ? new Map() : _arg_5);
            this._tags = new Array();
        }
        public function get id():uint
        {
            return (this._id);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get type():String
        {
            return (this._type);
        }
        public function get tags():Array
        {
            return (this._tags);
        }
        public function get region():Rectangle
        {
            return (this._rectangle);
        }
        public function getProperty(_arg_1:String):Object
        {
            return (this._SafeStr_4095[_arg_1]);
        }
        public function setProperty(_arg_1:String, _arg_2:Object):void
        {
            this._SafeStr_4095[_arg_1] = _arg_2;
        }

    }
}//package com.sulake.core.window.graphics.renderer

// ISkinTemplateEntity = "_-27h" (String#1819, DoABC#2)
// SkinTemplateEntity = "_-2qo" (String#7092, DoABC#2)
// _tags = "_-1NU" (String#163, DoABC#2)
// _rectangle = "_-1d7" (String#857, DoABC#2)
// _SafeStr_4095 = "_-2CY" (String#19507, DoABC#2)



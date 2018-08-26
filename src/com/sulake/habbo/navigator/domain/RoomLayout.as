
package com.sulake.habbo.navigator.domain
{
    import com.sulake.core.window.IWindowContainer;

    public class RoomLayout 
    {

        private var _level:int;
        private var _tileSize:int;
        private var _name:String;
        private var _view:IWindowContainer;

        public function RoomLayout(_arg_1:int, _arg_2:int, _arg_3:String)
        {
            this._level = _arg_1;
            this._tileSize = _arg_2;
            this._name = _arg_3;
        }
        public function get requiredClubLevel():int
        {
            return (this._level);
        }
        public function get tileSize():int
        {
            return (this._tileSize);
        }
        public function get name():String
        {
            return (this._name);
        }
        public function get view():IWindowContainer
        {
            return (this._view);
        }
        public function set view(_arg_1:IWindowContainer):void
        {
            this._view = _arg_1;
        }

    }
}//package com.sulake.habbo.navigator.domain

// RoomLayout = "_-Oa" (String#8174, DoABC#2)
// _level = "_-3FE" (String#250, DoABC#2)
// tileSize = "_-2va" (String#21298, DoABC#2)
// requiredClubLevel = "_-1AJ" (String#16873, DoABC#2)



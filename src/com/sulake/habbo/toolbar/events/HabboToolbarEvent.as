
package com.sulake.habbo.toolbar.events
{
    import flash.events.Event;

    public class HabboToolbarEvent extends Event 
    {

        public static const HTE_TOOLBAR_CLICK:String = "HTE_TOOLBAR_CLICK";

        private var _iconId:String;
        private var _iconName:String;

        public function HabboToolbarEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }
        public function set iconId(_arg_1:String):void
        {
            this._iconId = _arg_1;
        }
        public function get iconId():String
        {
            return (this._iconId);
        }
        public function set iconName(_arg_1:String):void
        {
            this._iconName = _arg_1;
        }
        public function get iconName():String
        {
            return (this._iconName);
        }

    }
}//package com.sulake.habbo.toolbar.events

// HTE_TOOLBAR_CLICK = "_-22-" (String#19089, DoABC#2)
// iconId = "_-2di" (String#20590, DoABC#2)
// _iconId = "_-32l" (String#7362, DoABC#2)
// _iconName = "_-1S" (String#17582, DoABC#2)
// iconName = "_-1Xn" (String#5513, DoABC#2)



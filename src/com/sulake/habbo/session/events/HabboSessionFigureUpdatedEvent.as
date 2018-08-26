
package com.sulake.habbo.session.events
{
    import flash.events.Event;

    public class HabboSessionFigureUpdatedEvent extends Event 
    {

        public static const HABBO_SESSION_FIGURE_UPDATE:String = "HABBO_SESSION_FIGURE_UPDATE";

        private var _userId:int;
        private var _figure:String;
        private var _gender:String;

        public function HabboSessionFigureUpdatedEvent(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:Boolean=false, _arg_5:Boolean=false)
        {
            super(HABBO_SESSION_FIGURE_UPDATE, _arg_4, _arg_5);
            this._userId = _arg_1;
            this._figure = _arg_2;
            this._gender = _arg_3;
        }
        public function get userId():int
        {
            return (this._userId);
        }
        public function get figure():String
        {
            return (this._figure);
        }
        public function get gender():String
        {
            return (this._gender);
        }

    }
}//package com.sulake.habbo.session.events

// HabboSessionFigureUpdatedEvent = "_-1Yz" (String#17851, DoABC#2)
// _gender = "_-a0" (String#95, DoABC#2)
// _figure = "_-20u" (String#75, DoABC#2)
// HABBO_SESSION_FIGURE_UPDATE = "_-0yO" (String#16368, DoABC#2)



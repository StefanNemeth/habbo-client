
package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs
{
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.roomevents.userdefinedroomevents.common.SliderWindowController;
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public class TriggerPeriodically implements TriggerConf 
    {

        private var _SafeStr_5221:HabboUserDefinedRoomEvents;
        private var _slider:SliderWindowController;

        public function get code():int
        {
            return (TriggerConfCodes._SafeStr_7120);
        }
        public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_NONE);
        }
        public function get hasStateSnapshot():Boolean
        {
            return (false);
        }
        public function Element(_arg_1:IWindowContainer):Array
        {
            var _local_2:Array = new Array();
            _local_2.push(this._slider.getValue());
            return (_local_2);
        }
        public function Element(_arg_1:IWindowContainer):String
        {
            return ("");
        }
        public function Element(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):void
        {
            this._SafeStr_5221 = _arg_2;
            this._slider = new SliderWindowController(_arg_2, this.getInput(_arg_1), _arg_2.assets, 1, 120, 1);
            this._slider.setValue(1);
            this._slider.addEventListener(Event.CHANGE, this.StuffsInFormation);
        }
        public function Element(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            var _local_3:int = _arg_2.intParams[0];
            this._slider.setValue(_local_3);
        }
        public function get hasSpecialInputs():Boolean
        {
            return (true);
        }
        private function getInput(_arg_1:IWindowContainer):IWindowContainer
        {
            return ((_arg_1.findChildByName("slider_container") as IWindowContainer));
        }
        private function StuffsInFormation(_arg_1:Event):void
        {
            var _local_2:SliderWindowController;
            var _local_3:Number;
            var _local_4:int;
            var _local_5:String;
            if (_arg_1.type == Event.CHANGE){
                _local_2 = (_arg_1.target as SliderWindowController);
                if (_local_2){
                    _local_3 = _local_2.getValue();
                    _local_4 = int(_local_3);
                    _local_5 = TriggerOnce.TriggerOnce(_local_4);
                    this._SafeStr_5221.localization.registerParameter("wiredfurni.params.settime", "seconds", _local_5);
                };
            };
        }

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs

// Triggerable = "_-2oD" (String#7043, DoABC#2)
// SliderWindowController = "_-GO" (String#8002, DoABC#2)
// TriggerConf = "_-0ol" (String#4609, DoABC#2)
// TriggerOnce = "_-31n" (String#7342, DoABC#2)
// TriggerPeriodically = "_-nd" (String#8671, DoABC#2)
// TriggerConfCodes = "_-2-z" (String#6047, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// requiresFurni = "_-1i4" (String#5711, DoABC#2)
// hasStateSnapshot = "_-2bG" (String#6777, DoABC#2)
// Element = "_-10U" (String#4881, DoABC#2)
// Element = "_-2Cw" (String#6305, DoABC#2)
// intParams = "_-kt" (String#24066, DoABC#2)
// Element = "_-0uD" (String#4727, DoABC#2)
// Element = "_-gW" (String#8522, DoABC#2)
// hasSpecialInputs = "_-pV" (String#8699, DoABC#2)
// _SafeStr_5221 = "_-0D2" (String#124, DoABC#2)
// StuffsInFormation = "_-2q0" (String#307, DoABC#2)
// TriggerOnce = "_-2SO" (String#20133, DoABC#2)
// _SafeStr_7120 = "_-1nr" (String#18454, DoABC#2)



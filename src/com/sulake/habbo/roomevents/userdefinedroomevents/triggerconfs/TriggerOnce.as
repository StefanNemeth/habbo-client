
package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs
{
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.roomevents.userdefinedroomevents.common.SliderWindowController;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public class TriggerOnce implements TriggerConf 
    {

        private var _SafeStr_5221:HabboUserDefinedRoomEvents;
        private var _slider:SliderWindowController;

        public static function preparePulseSelection(_arg_1:IWindowContainer, _arg_2:IDropMenuWindow):void
        {
            var _local_3:Array = new Array();
            var _local_4:int = 10;
            var _local_5:int;
            while (_local_5 <= _local_4) {
                if (_local_5 != 0){
                    _local_3.push((("at " + _local_5) + " secs"));
                };
                _local_3.push((("at " + _local_5) + ".5 secs"));
                _local_5++;
            };
            if (_arg_2){
                _arg_2.populate(_local_3);
                _arg_2.selection = 0;
            };
        }
        public static function getSecsFromPulses(_arg_1:int):String
        {
            var _local_2:int = Math.floor((_arg_1 / 2));
            if ((_arg_1 % 2) == 0){
                return (("" + _local_2));
            };
            return ((_local_2 + ".5"));
        }

        public function get code():int
        {
            return (TriggerConfCodes._SafeStr_7113);
        }
        public function get requiresFurni():int
        {
            return (UserDefinedRoomEventsCtrl.STUFF_SELECTION_OPTION_NONE);
        }
        public function get hasStateSnapshot():Boolean
        {
            return (false);
        }
        public function readIntParamsFromForm(_arg_1:IWindowContainer):Array
        {
            var _local_2:Array = new Array();
            _local_2.push(this._slider.getValue());
            return (_local_2);
        }
        public function readStringParamFromForm(_arg_1:IWindowContainer):String
        {
            return ("");
        }
        public function onInit(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):void
        {
            this._SafeStr_5221 = _arg_2;
            this._slider = new SliderWindowController(_arg_2, this.getInput(_arg_1), _arg_2.assets, 1, 1200, 1);
            this._slider.setValue(1);
            this._slider.addEventListener(Event.CHANGE, this.onSliderChange);
        }
        public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
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
        private function onSliderChange(_arg_1:Event):void
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
                    _local_5 = TriggerOnce.getSecsFromPulses(_local_4);
                    this._SafeStr_5221.localization.registerParameter("wiredfurni.params.settime", "seconds", _local_5);
                };
            };
        }

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs

// IDropMenuWindow = "_-4Z" (String#2049, DoABC#2)
// Triggerable = "_-2oD" (String#7043, DoABC#2)
// SliderWindowController = "_-GO" (String#8002, DoABC#2)
// TriggerConf = "_-0ol" (String#4609, DoABC#2)
// TriggerOnce = "_-31n" (String#7342, DoABC#2)
// TriggerConfCodes = "_-2-z" (String#6047, DoABC#2)
// code = "_-12Y" (String#4926, DoABC#2)
// requiresFurni = "_-1i4" (String#5711, DoABC#2)
// hasStateSnapshot = "_-2bG" (String#6777, DoABC#2)
// onInit = "_-10U" (String#4881, DoABC#2)
// onEditStart = "_-2Cw" (String#6305, DoABC#2)
// intParams = "_-kt" (String#24066, DoABC#2)
// readIntParamsFromForm = "_-0uD" (String#4727, DoABC#2)
// readStringParamFromForm = "_-gW" (String#8522, DoABC#2)
// hasSpecialInputs = "_-pV" (String#8699, DoABC#2)
// _SafeStr_5221 = "_-0D2" (String#124, DoABC#2)
// onSliderChange = "_-2q0" (String#307, DoABC#2)
// preparePulseSelection = "_-36B" (String#21737, DoABC#2)
// getSecsFromPulses = "_-2SO" (String#20133, DoABC#2)
// _SafeStr_7113 = "_-2A3" (String#19407, DoABC#2)



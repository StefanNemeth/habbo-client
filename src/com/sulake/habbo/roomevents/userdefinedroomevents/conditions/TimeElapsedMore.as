
package com.sulake.habbo.roomevents.userdefinedroomevents.conditions
{
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.roomevents.userdefinedroomevents.common.SliderWindowController;
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
    import com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs.TriggerOnce;
    import com.sulake.habbo.roomevents.userdefinedroomevents.triggerconfs.*;

    public class TimeElapsedMore implements ConditionType 
    {

        private var _SafeStr_5221:HabboUserDefinedRoomEvents;
        private var _slider:SliderWindowController;

        public function get code():int
        {
            return (ConditionCodes._SafeStr_7662);
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
            var _local_3:int = this._slider.getValue();
            _local_2.push((_local_3 + 1));
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
            var _local_3:int = (_arg_2.intParams[0] - 1);
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
                    this._SafeStr_5221.localization.registerParameter("wiredfurni.params.allowafter", "seconds", _local_5);
                };
            };
        }

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents.conditions

// Triggerable = "_-2oD" (String#7043, DoABC#2)
// SliderWindowController = "_-GO" (String#8002, DoABC#2)
// TriggerOnce = "_-31n" (String#7342, DoABC#2)
// ConditionType = "_-262" (String#6162, DoABC#2)
// TimeElapsedMore = "_-0zj" (String#4842, DoABC#2)
// ConditionCodes = "_-3Jq" (String#7699, DoABC#2)
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
// getSecsFromPulses = "_-2SO" (String#20133, DoABC#2)
// _SafeStr_7662 = "_-2ue" (String#21265, DoABC#2)



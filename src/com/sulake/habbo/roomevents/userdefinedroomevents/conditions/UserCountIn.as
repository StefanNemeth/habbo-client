
package com.sulake.habbo.roomevents.userdefinedroomevents.conditions
{
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.habbo.roomevents.userdefinedroomevents.common.SliderWindowController;
    import com.sulake.habbo.roomevents.userdefinedroomevents.UserDefinedRoomEventsCtrl;
    import com.sulake.core.window.IWindowContainer;
    import flash.events.Event;
    import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;

    public class UserCountIn implements ConditionType 
    {

        private var _SafeStr_5221:HabboUserDefinedRoomEvents;
        private var _SafeStr_7673:SliderWindowController;
        private var _SafeStr_7674:SliderWindowController;

        public function get code():int
        {
            return (ConditionCodes._SafeStr_7669);
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
            _local_2.push(this._SafeStr_7673.getValue());
            _local_2.push(this._SafeStr_7674.getValue());
            return (_local_2);
        }
        public function readStringParamFromForm(_arg_1:IWindowContainer):String
        {
            return ("");
        }
        public function onInit(_arg_1:IWindowContainer, _arg_2:HabboUserDefinedRoomEvents):void
        {
            this._SafeStr_5221 = _arg_2;
            this._SafeStr_7673 = new SliderWindowController(_arg_2, this.getMinInput(_arg_1), _arg_2.assets, 1, 50, 1);
            this._SafeStr_7673.addEventListener(Event.CHANGE, this.onMinSliderChange);
            this._SafeStr_7673.setValue(1);
            this._SafeStr_7674 = new SliderWindowController(_arg_2, this.getMaxInput(_arg_1), _arg_2.assets, 1, 50, 1);
            this._SafeStr_7674.addEventListener(Event.CHANGE, this.onMaxSliderChange);
            this._SafeStr_7674.setValue(50);
        }
        public function onEditStart(_arg_1:IWindowContainer, _arg_2:Triggerable):void
        {
            var _local_3:int = _arg_2.intParams[0];
            var _local_4:int = _arg_2.intParams[1];
            this._SafeStr_7673.setValue(_local_3);
            this._SafeStr_7674.setValue(_local_4);
        }
        public function get hasSpecialInputs():Boolean
        {
            return (true);
        }
        private function getMinInput(_arg_1:IWindowContainer):IWindowContainer
        {
            return ((_arg_1.findChildByName("min_slider_container") as IWindowContainer));
        }
        private function getMaxInput(_arg_1:IWindowContainer):IWindowContainer
        {
            return ((_arg_1.findChildByName("max_slider_container") as IWindowContainer));
        }
        private function onMinSliderChange(_arg_1:Event):void
        {
            var _local_2:SliderWindowController;
            var _local_3:Number;
            var _local_4:int;
            if (_arg_1.type == Event.CHANGE){
                _local_2 = (_arg_1.target as SliderWindowController);
                if (_local_2){
                    _local_3 = _local_2.getValue();
                    _local_4 = int(_local_3);
                    this._SafeStr_5221.localization.registerParameter("wiredfurni.params.usercountmin", "value", ("" + _local_4));
                };
            };
        }
        private function onMaxSliderChange(_arg_1:Event):void
        {
            var _local_2:SliderWindowController;
            var _local_3:Number;
            var _local_4:int;
            if (_arg_1.type == Event.CHANGE){
                _local_2 = (_arg_1.target as SliderWindowController);
                if (_local_2){
                    _local_3 = _local_2.getValue();
                    _local_4 = int(_local_3);
                    this._SafeStr_5221.localization.registerParameter("wiredfurni.params.usercountmax", "value", ("" + _local_4));
                };
            };
        }

    }
}//package com.sulake.habbo.roomevents.userdefinedroomevents.conditions

// Triggerable = "_-2oD" (String#7043, DoABC#2)
// SliderWindowController = "_-GO" (String#8002, DoABC#2)
// ConditionType = "_-262" (String#6162, DoABC#2)
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
// _SafeStr_7669 = "_-1tv" (String#18713, DoABC#2)
// _SafeStr_7673 = "_-0fu" (String#15666, DoABC#2)
// _SafeStr_7674 = "_-0fj" (String#15661, DoABC#2)
// getMinInput = "_-3Ku" (String#22319, DoABC#2)
// onMinSliderChange = "_-0qM" (String#16064, DoABC#2)
// getMaxInput = "_-3Ci" (String#21983, DoABC#2)
// onMaxSliderChange = "_-EE" (String#22780, DoABC#2)



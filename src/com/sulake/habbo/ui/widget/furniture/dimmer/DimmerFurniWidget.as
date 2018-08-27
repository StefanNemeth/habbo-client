
package com.sulake.habbo.ui.widget.furniture.dimmer
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerStateUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerUpdateEventPresetItem;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerPreviewMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerSavePresetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerChangeStateMessage;

    public class DimmerFurniWidget extends RoomWidgetBase 
    {

        private static const _SafeStr_13936:Array = new Array(7665141, 21495, 15161822, 15353138, 15923281, 8581961, 0);
        private static const _SafeStr_13937:Array = new Array(int((0.3 * 0xFF)), int((0.3 * 0xFF)));

        private var _view:DimmerView;
        private var _presets:Array;
        private var _selectedPresetIndex:int;
        private var _dimmerState:int;
        private var _presetId:int;
        private var _effectId:int;
        private var _color:uint = 0xFFFFFF;
        private var _brightness:uint = 0xFF;

        public function DimmerFurniWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null, _arg_4:IHabboLocalizationManager=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }
        public function get dimmerState():int
        {
            return (this._dimmerState);
        }
        public function get presets():Array
        {
            return (this._presets);
        }
        public function get colors():Array
        {
            return (_SafeStr_13936);
        }
        public function get _SafeStr_13940():Array
        {
            return (_SafeStr_13937);
        }
        public function get selectedPresetIndex():int
        {
            return (this._selectedPresetIndex);
        }
        public function set selectedPresetIndex(_arg_1:int):void
        {
            this._selectedPresetIndex = _arg_1;
        }
        override public function dispose():void
        {
            this.disposeInterface();
            this._presets = null;
            super.dispose();
        }
        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.addEventListener(RoomWidgetDimmerUpdateEvent.RWDUE_PRESETS, this.onPresets);
            _arg_1.addEventListener(RoomWidgetDimmerUpdateEvent.RWDUE_HIDE, this.onHide);
            _arg_1.addEventListener(RoomWidgetDimmerStateUpdateEvent.RWDSUE_DIMMER_STATE, this.onDimmerState);
            super.registerUpdateEvents(_arg_1);
        }
        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetDimmerUpdateEvent.RWDUE_PRESETS, this.onPresets);
            _arg_1.removeEventListener(RoomWidgetDimmerUpdateEvent.RWDUE_HIDE, this.onHide);
            _arg_1.removeEventListener(RoomWidgetDimmerStateUpdateEvent.RWDSUE_DIMMER_STATE, this.onDimmerState);
        }
        private function onPresets(_arg_1:RoomWidgetDimmerUpdateEvent):void
        {
            var _local_3:RoomWidgetDimmerUpdateEventPresetItem;
            var _local_4:DimmerFurniWidgetPresetItem;
            this._selectedPresetIndex = (_arg_1.selectedPresetId - 1);
            this._presets = new Array();
            var _local_2:int;
            while (_local_2 < _arg_1.presets.length) {
                _local_3 = _arg_1.presets[_local_2];
                _local_4 = new DimmerFurniWidgetPresetItem(_local_3.id, _local_3.type, _local_3.color, _local_3.light);
                this._presets.push(_local_4);
                _local_2++;
            };
            this.showInterface();
        }
        private function onHide(_arg_1:RoomWidgetDimmerUpdateEvent):void
        {
            this.disposeInterface();
        }
        private function disposeInterface():void
        {
            if (this._view != null){
                this._view.dispose();
                this._view = null;
            };
        }
        private function onDimmerState(_arg_1:RoomWidgetDimmerStateUpdateEvent):void
        {
            var _local_2:RoomWidgetDimmerPreviewMessage;
            if (_arg_1 == null){
                return;
            };
            this._dimmerState = _arg_1.state;
            this._presetId = _arg_1.presetId;
            this._effectId = _arg_1.effectId;
            this._color = _arg_1.color;
            this._brightness = _arg_1.brightness;
            if (this._view != null){
                this._view.update();
            };
            if (!this.validateBrightness(this._brightness, this._effectId)){
                return;
            };
            _local_2 = new RoomWidgetDimmerPreviewMessage(this._color, this._brightness, (this._effectId == 2));
            messageListener.processWidgetMessage(_local_2);
        }
        private function showInterface():void
        {
            if (this._view == null){
                this._view = new DimmerView(this);
            };
            if (this._view != null){
                this._view.showInterface();
            };
        }
        public function storeCurrentSetting(_arg_1:Boolean):void
        {
            var _local_7:RoomWidgetDimmerSavePresetMessage;
            if (this._dimmerState == 0){
                return;
            };
            if (messageListener == null){
                return;
            };
            var _local_2:int = (this._selectedPresetIndex + 1);
            if ((((((this._presets == null)) || ((_local_2 < 0)))) || ((_local_2 > this._presets.length)))){
                return;
            };
            var _local_3:int = this._view.selectedType;
            var _local_4:uint = this.colors[this._view.selectedColorIndex];
            var _local_5:int = this._view.selectedBrightness;
            var _local_6:DimmerFurniWidgetPresetItem = (this._presets[this._selectedPresetIndex] as DimmerFurniWidgetPresetItem);
            if (((((((((!((_local_6 == null))) && ((_local_6.type == _local_3)))) && ((_local_6.color == _local_4)))) && ((_local_6.light == _local_5)))) && (!(_arg_1)))){
                return;
            };
            _local_6.type = _local_3;
            _local_6.color = _local_4;
            _local_6.light = _local_5;
            if (!this.validateBrightness(_local_5, _local_3)){
                return;
            };
            _local_7 = new RoomWidgetDimmerSavePresetMessage(_local_2, _local_3, _local_4, _local_5, _arg_1);
            messageListener.processWidgetMessage(_local_7);
        }
        public function previewCurrentSetting():void
        {
            var _local_1:RoomWidgetDimmerPreviewMessage;
            if (this._dimmerState == 0){
                return;
            };
            if (messageListener == null){
                return;
            };
            if (!this.validateBrightness(this._view.selectedBrightness, this._view.selectedType)){
                return;
            };
            _local_1 = new RoomWidgetDimmerPreviewMessage(this.colors[this._view.selectedColorIndex], this._view.selectedBrightness, (this._view.selectedType == 2));
            messageListener.processWidgetMessage(_local_1);
        }
        public function changeRoomDimmerState():void
        {
            var _local_1:RoomWidgetDimmerChangeStateMessage;
            if (messageListener != null){
                _local_1 = new RoomWidgetDimmerChangeStateMessage();
                messageListener.processWidgetMessage(_local_1);
            };
        }
        public function removePreview():void
        {
            var _local_1:RoomWidgetDimmerPreviewMessage;
            if (messageListener == null){
                return;
            };
            if (!this.validateBrightness(this._brightness, this._effectId)){
                return;
            };
            _local_1 = new RoomWidgetDimmerPreviewMessage(this._color, this._brightness, (this._effectId == 2));
            messageListener.processWidgetMessage(_local_1);
        }
        private function validateBrightness(_arg_1:uint, _arg_2:int):Boolean
        {
            return (true);
        }

    }
}//package com.sulake.habbo.ui.widget.furniture.dimmer

// presets = "_-0Da" (String#14592, DoABC#2)
// _SafeStr_13936 = "_-2-O" (String#18987, DoABC#2)
// _SafeStr_13937 = "_-20y" (String#19051, DoABC#2)
// _selectedPresetIndex = "_-0pn" (String#16045, DoABC#2)
// dimmerState = "_-0rb" (String#16106, DoABC#2)
// _SafeStr_13940 = "with" (String#47252, DoABC#2)
// selectedPresetIndex = "_-No" (String#23157, DoABC#2)
// onPresets = "_-ol" (String#24226, DoABC#2)
// onHide = "_-c-" (String#23713, DoABC#2)
// onDimmerState = "_-0b7" (String#15480, DoABC#2)
// validateBrightness = "_-2eL" (String#20616, DoABC#2)
// storeCurrentSetting = "_-rg" (String#24347, DoABC#2)
// selectedType = "_-20N" (String#19027, DoABC#2)
// selectedColorIndex = "_-3HF" (String#22173, DoABC#2)
// selectedBrightness = "_-02h" (String#14148, DoABC#2)
// previewCurrentSetting = "_-bB" (String#23676, DoABC#2)
// changeRoomDimmerState = "_-0XJ" (String#15327, DoABC#2)
// removePreview = "_-2uc" (String#21264, DoABC#2)
// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// DimmerFurniWidget = "_-1-P" (String#4856, DoABC#2)
// RoomWidgetDimmerChangeStateMessage = "_-0Nh" (String#4035, DoABC#2)
// DimmerFurniWidgetPresetItem = "_-n2" (String#8658, DoABC#2)
// RoomWidgetDimmerSavePresetMessage = "_-1D3" (String#5126, DoABC#2)
// RoomWidgetDimmerPreviewMessage = "_-yc" (String#8849, DoABC#2)
// RoomWidgetDimmerUpdateEvent = "_-2Fv" (String#6362, DoABC#2)
// RoomWidgetDimmerStateUpdateEvent = "_-12o" (String#4930, DoABC#2)
// RoomWidgetDimmerUpdateEventPresetItem = "_-0U1" (String#4184, DoABC#2)
// DimmerView = "_-1QW" (String#5361, DoABC#2)
// _brightness = "_-2Jm" (String#450, DoABC#2)
// brightness = "_-kZ" (String#24053, DoABC#2)
// registerUpdateEvents = "_-1yD" (String#1787, DoABC#2)
// unregisterUpdateEvents = "_-0-c" (String#3556, DoABC#2)
// showInterface = "_-121" (String#162, DoABC#2)
// selectedPresetId = "_-0Pr" (String#15055, DoABC#2)
// disposeInterface = "_-0FF" (String#3856, DoABC#2)
// RWDSUE_DIMMER_STATE = "_-0A5" (String#14451, DoABC#2)
// _presetId = "_-1ik" (String#861, DoABC#2)
// _effectId = "_-06d" (String#580, DoABC#2)
// presetId = "_-37i" (String#21795, DoABC#2)
// effectId = "_-0jW" (String#15809, DoABC#2)
// RWDUE_PRESETS = "_-1i5" (String#18213, DoABC#2)
// RWDUE_HIDE = "_-0KF" (String#14852, DoABC#2)



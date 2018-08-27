
package com.sulake.habbo.ui.widget.furniture.dimmer
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITabContextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITabButtonWindow;
    import flash.display.BitmapData;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.geom.Point;
    import com.sulake.core.window.components.ICheckBoxWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.assets.XmlAsset;

    public class DimmerView 
    {

        private static const _SafeStr_3710:Number = 100;
        private static const _selectedBrightness:Number = 100;

        private var _window:IWindowContainer;
        private var _SafeStr_4238:ITabContextWindow;
        private var _windowXML:XML;
        private var _widget:DimmerFurniWidget;
        private var _SafeStr_13954:DimmerViewColorGrid;
        private var _SafeStr_13955:DimmerViewAlphaSlider;
        private var _selectedBrightness:int;
        private var _selectedColorIndex:int;
        private var _selectedType:int;

        public function DimmerView(_arg_1:DimmerFurniWidget)
        {
            this._widget = _arg_1;
        }
        public function get selectedBrightness():int
        {
            return (this._selectedBrightness);
        }
        public function get selectedColorIndex():int
        {
            return (this._selectedColorIndex);
        }
        public function get selectedType():int
        {
            return (this._selectedType);
        }
        public function dispose():void
        {
            this.hideInterface();
            this._widget = null;
        }
        public function showInterface():void
        {
            if (this._window == null){
                this.createWindow();
            };
            this.selectPreset(this._widget.selectedPresetIndex);
            this.update();
        }
        public function update():void
        {
            var _local_3:String;
            if ((((this._window == null)) || ((this._widget == null)))){
                return;
            };
            var _local_1 = (this._widget.dimmerState == 1);
            var _local_2:IWindow = this._window.findChildByName("on_off_button");
            if (_local_2 != null){
                _local_3 = ((_local_1) ? "${widget.dimmer.button.off}" : "${widget.dimmer.button.on}");
                _local_2.caption = _local_3;
            };
            _local_2 = this._window.findChildByName("tabbedview");
            if (_local_2 != null){
                _local_2.visible = _local_1;
            };
            _local_2 = this._window.findChildByName("apply_button");
            if (_local_2 != null){
                if (_local_1){
                    _local_2.enable();
                }
                else {
                    _local_2.disable();
                };
            };
            _local_2 = this._window.findChildByName("off_border");
            if (_local_2){
                _local_2.visible = !(_local_1);
            };
        }
        public function hideInterface():void
        {
            if (this._widget != null){
                this._widget.removePreview();
            };
            if (this._SafeStr_13954 != null){
                this._SafeStr_13954.dispose();
                this._SafeStr_13954 = null;
            };
            if (this._SafeStr_13955 != null){
                this._SafeStr_13955.dispose();
                this._SafeStr_13955 = null;
            };
            this._SafeStr_4238 = null;
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
        }
        private function createWindow():void
        {
            var _local_1:IWindow;
            var _local_5:IWindow;
            var _local_6:ITabButtonWindow;
            var _local_7:BitmapData;
            if ((((((this._widget == null)) || ((this._widget.windowManager == null)))) || ((this.windowXML == null)))){
                return;
            };
            this._window = (this._widget.windowManager.createWindow("dimmerui_container", "", HabboWindowType._SafeStr_3728, HabboWindowStyle._SafeStr_3729, (HabboWindowParam._SafeStr_3730 | HabboWindowParam._SafeStr_3731), new Rectangle(_SafeStr_3710, _selectedBrightness, 2, 2), null, 0) as IWindowContainer);
            this._window.buildFromXML(this.windowXML);
            _local_1 = this._window.findChildByTag("close");
            if (_local_1 != null){
                _local_1.procedure = this.onWindowClose;
            };
            _local_1 = this._window.findChildByName("color_grid_container");
            if (_local_1 != null){
                _local_5 = (_local_1 as IWindowContainer).findChildByName("color_grid");
                if (_local_5 != null){
                    this._SafeStr_13954 = new DimmerViewColorGrid(this, (_local_5 as IItemGridWindow), this._widget.windowManager, this._widget.assets);
                };
            };
            _local_1 = this._window.findChildByName("brightness_container");
            if (_local_1 != null){
                this._SafeStr_13955 = new DimmerViewAlphaSlider(this, (_local_1 as IWindowContainer), this._widget.assets);
            };
            this._SafeStr_4238 = ITabContextWindow(this._window.findChildByName("tab_context"));
            this.selectTab(this._widget.selectedPresetIndex);
            var _local_2:int;
            while (_local_2 < this._SafeStr_4238.numTabItems) {
                _local_6 = this._SafeStr_4238.getTabItemAt(_local_2);
                _local_6.setParamFlag(HabboWindowParam._SafeStr_3731, true);
                _local_6.procedure = this.onTabClick;
                _local_2++;
            };
            _local_1 = this._window.findChildByName("type_checkbox");
            if (_local_1 != null){
                _local_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
            };
            _local_1 = this._window.findChildByName("apply_button");
            if (_local_1 != null){
                _local_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
            };
            _local_1 = this._window.findChildByName("on_off_button");
            if (_local_1 != null){
                _local_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
            };
            var _local_3:IBitmapWrapperWindow = (this._window.findChildByName("off_image") as IBitmapWrapperWindow);
            var _local_4:BitmapDataAsset = (this._widget.assets.getAssetByName("dimmer_info") as BitmapDataAsset);
            if (((!((_local_3 == null))) && (!((_local_4 == null))))){
                _local_3.bitmap = new BitmapData(_local_3.width, _local_3.height);
                _local_7 = (_local_4.content as BitmapData);
                if (_local_7 != null){
                    _local_3.bitmap.copyPixels(_local_7, _local_7.rect, new Point(0, 0));
                };
            };
        }
        private function onMouseEvent(_arg_1:WindowMouseEvent):void
        {
            var _local_4:ICheckBoxWindow;
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            switch (_local_3){
                case "type_checkbox":
                    _local_4 = (_arg_1.target as ICheckBoxWindow);
                    if (_local_4 == null){
                        return;
                    };
                    if (_local_4.isSelected){
                        this.selectedType = 2;
                    }
                    else {
                        this.selectedType = 1;
                    };
                    this._widget.previewCurrentSetting();
                    return;
                case "apply_button":
                    this._widget.storeCurrentSetting(true);
                    return;
                case "cancel":
                case "close":
                    this.hideInterface();
                    return;
                case "on_off_button":
                    this._widget.changeRoomDimmerState();
                    return;
            };
        }
        private function onTabClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowEvent.WE_SELECTED){
                return;
            };
            this._widget.storeCurrentSetting(false);
            var _local_3:int = _arg_2.id;
            this.selectPreset(_local_3);
        }
        private function onWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this.hideInterface();
        }
        private function selectPreset(_arg_1:int):void
        {
            if ((((((((this._widget == null)) || ((this._widget.presets == null)))) || ((_arg_1 < 0)))) || ((_arg_1 >= this._widget.presets.length)))){
                return;
            };
            this._widget.selectedPresetIndex = _arg_1;
            var _local_2:DimmerFurniWidgetPresetItem = this._widget.presets[_arg_1];
            if (_local_2 == null){
                return;
            };
            this.selectTab(_arg_1);
            this._selectedBrightness = _local_2.light;
            if (this._SafeStr_13955 != null){
                this._SafeStr_13955.setValue(this._selectedBrightness);
            };
            this._selectedColorIndex = this.colors.indexOf(_local_2.color);
            if (this._SafeStr_13954 != null){
                this._SafeStr_13954.setSelectedColorIndex(this._selectedColorIndex);
            };
            this.selectedType = _local_2.type;
            this._widget.previewCurrentSetting();
        }
        private function selectTab(_arg_1:int):void
        {
            if (this._SafeStr_4238 == null){
                return;
            };
            var _local_2:IWindow = this._SafeStr_4238.getTabItemAt(_arg_1);
            if (_local_2 != null){
                this._SafeStr_4238.selector.setSelected((_local_2 as ISelectableWindow));
            };
        }
        private function getSelectedTabIndex():int
        {
            if (this._SafeStr_4238 == null){
                return (-1);
            };
            var _local_1:ISelectableWindow = this._SafeStr_4238.selector.getSelected();
            return (this._SafeStr_4238.selector.getSelectableIndex(_local_1));
        }
        private function get windowXML():XML
        {
            if (this._windowXML != null){
                return (this._windowXML);
            };
            if ((((((this._widget == null)) || ((this._widget.assets == null)))) || ((this._widget.assets.getAssetByName("dimmer_ui") == null)))){
                return (null);
            };
            var _local_1:XmlAsset = XmlAsset(this._widget.assets.getAssetByName("dimmer_ui"));
            this._windowXML = XML(_local_1.content);
            return (this._windowXML);
        }
        public function get colors():Array
        {
            if (this._widget == null){
                return (null);
            };
            return (this._widget.colors);
        }
        public function set selectedType(_arg_1:int):void
        {
            if (((!((_arg_1 == 1))) && (!((_arg_1 == 2))))){
                return;
            };
            this._selectedType = _arg_1;
            var _local_2:ICheckBoxWindow = (this._window.findChildByName("type_checkbox") as ICheckBoxWindow);
            if (_local_2 != null){
                if (_arg_1 == 2){
                    _local_2.select();
                }
                else {
                    _local_2.unselect();
                };
            };
            if (this._SafeStr_13955 != null){
                this._SafeStr_13955.min = this._widget._SafeStr_13940[(_arg_1 - 1)];
            };
        }
        public function set selectedColorIndex(_arg_1:int):void
        {
            this._selectedColorIndex = _arg_1;
            if (this._SafeStr_13954 != null){
                this._SafeStr_13954.setSelectedColorIndex(_arg_1);
            };
            this._widget.previewCurrentSetting();
        }
        public function set selectedBrightness(_arg_1:int):void
        {
            this._selectedBrightness = _arg_1;
            if (this._SafeStr_13955 != null){
                this._SafeStr_13955.setValue(_arg_1);
            };
            this._widget.previewCurrentSetting();
        }

    }
}//package com.sulake.habbo.ui.widget.furniture.dimmer

// _selectedColorIndex = "_-0n9" (String#4572, DoABC#2)
// selectTab = "_-F0" (String#2077, DoABC#2)
// onTabClick = "_-1kH" (String#1752, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// presets = "_-0Da" (String#14592, DoABC#2)
// dimmerState = "_-0rb" (String#16106, DoABC#2)
// _SafeStr_13940 = "with" (String#47252, DoABC#2)
// selectedPresetIndex = "_-No" (String#23157, DoABC#2)
// storeCurrentSetting = "_-rg" (String#24347, DoABC#2)
// selectedType = "_-20N" (String#19027, DoABC#2)
// selectedColorIndex = "_-3HF" (String#22173, DoABC#2)
// selectedBrightness = "_-02h" (String#14148, DoABC#2)
// previewCurrentSetting = "_-bB" (String#23676, DoABC#2)
// changeRoomDimmerState = "_-0XJ" (String#15327, DoABC#2)
// removePreview = "_-2uc" (String#21264, DoABC#2)
// _windowXML = "_-1Br" (String#16935, DoABC#2)
// _SafeStr_13954 = "_-2qm" (String#21113, DoABC#2)
// _SafeStr_13955 = "_-2tK" (String#21213, DoABC#2)
// _selectedBrightness = "_-e1" (String#23803, DoABC#2)
// _selectedType = "_-mT" (String#24126, DoABC#2)
// selectPreset = "_-tX" (String#24428, DoABC#2)
// windowXML = "_-13" (String#16579, DoABC#2)
// setSelectedColorIndex = "_-2Ki" (String#19832, DoABC#2)
// getSelectedTabIndex = "_-Tv" (String#23403, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// HabboWindowStyle = "_-0E1" (String#14608, DoABC#2)
// HabboWindowType = "_-29U" (String#19384, DoABC#2)
// ISelectableWindow = "_-nA" (String#2188, DoABC#2)
// ITabButtonWindow = "_-1Gf" (String#1649, DoABC#2)
// ICheckBoxWindow = "_-1zu" (String#1793, DoABC#2)
// IItemGridWindow = "_-265" (String#1809, DoABC#2)
// ITabContextWindow = "_-0L6" (String#1455, DoABC#2)
// DimmerFurniWidget = "_-1-P" (String#4856, DoABC#2)
// DimmerFurniWidgetPresetItem = "_-n2" (String#8658, DoABC#2)
// DimmerView = "_-1QW" (String#5361, DoABC#2)
// DimmerViewAlphaSlider = "_-1Oj" (String#5328, DoABC#2)
// DimmerViewColorGrid = "_-2WW" (String#6690, DoABC#2)
// _SafeStr_3710 = "_-3-S" (String#908, DoABC#2)
// _selectedBrightness = "_-2M9" (String#885, DoABC#2)
// hideInterface = "_-29" (String#304, DoABC#2)
// showInterface = "_-121" (String#162, DoABC#2)
// _SafeStr_3728 = "_-1IW" (String#5215, DoABC#2)
// _SafeStr_3729 = "_-06z" (String#14322, DoABC#2)
// _SafeStr_3730 = "_-1rZ" (String#18611, DoABC#2)
// _SafeStr_3731 = "_-B" (String#22654, DoABC#2)
// onMouseEvent = "_-0ZW" (String#357, DoABC#2)
// _SafeStr_4238 = "_-1WR" (String#1704, DoABC#2)
// getSelected = "_-88" (String#7825, DoABC#2)
// onWindowClose = "_-2tr" (String#136, DoABC#2)
// WE_SELECTED = "_-17F" (String#16745, DoABC#2)
// unselect = "_-2aK" (String#6764, DoABC#2)
// getSelectableIndex = "_-2bS" (String#6782, DoABC#2)
// numTabItems = "_-2Dt" (String#6317, DoABC#2)
// getTabItemAt = "_-0XL" (String#4256, DoABC#2)



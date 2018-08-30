
package com.sulake.habbo.ui.widget.infostand
{
    import flash.geom.Point;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.utils.Map;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPetCommandMessage;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
    import flash.geom.Rectangle;

    public class PetCommandTool 
    {

        private static const _SafeStr_10176:Point = new Point(100, 30);

        private const _SafeStr_14054:int = 1100;

        private var _widget:InfostandWidget;
        private var _SafeStr_14055:IFrameWindow;
        private var _SafeStr_14056:IFrameWindow;
        private var _enabledCommands:Map;
        private var _currentPetId:int;
        private var _SafeStr_14057:String;
        private var _SafeStr_14058:Timer;

        public function PetCommandTool(_arg_1:InfostandWidget)
        {
            this._widget = _arg_1;
            this._enabledCommands = new Map();
            this._SafeStr_14058 = new Timer(this._SafeStr_14054);
            this._SafeStr_14058.addEventListener(TimerEvent.TIMER, this.onButtonDisableTimeout);
        }
        public static function hideChildren(_arg_1:IWindowContainer):void
        {
            var _local_2:int;
            while (_local_2 < _arg_1.numChildren) {
                _arg_1.getChildAt(_local_2).visible = false;
                _local_2++;
            };
        }
        public static function getLowestPoint(_arg_1:IWindowContainer):int
        {
            var _local_4:IWindow;
            var _local_2:int;
            var _local_3:int;
            while (_local_3 < _arg_1.numChildren) {
                _local_4 = _arg_1.getChildAt(_local_3);
                if (_local_4.visible){
                    _local_2 = Math.max(_local_2, (_local_4.y + _local_4.height));
                };
                _local_3++;
            };
            return (_local_2);
        }

        public function dispose():void
        {
            if (this._SafeStr_14058){
                this._SafeStr_14058.stop();
                this._SafeStr_14058 = null;
            };
            if (this._widget){
                this._widget = null;
            };
            if (this._SafeStr_14055){
                this._SafeStr_14055.dispose();
            };
            this._SafeStr_14055 = null;
            if (this._SafeStr_14056){
                this._SafeStr_14056.dispose();
            };
            this._SafeStr_14056 = null;
        }
        public function getPetId():int
        {
            return (this._currentPetId);
        }
        public function isVisible():Boolean
        {
            if (this._SafeStr_14055 == null){
                return (false);
            };
            return (this._SafeStr_14055.visible);
        }
        public function showCommandToolForPet(_arg_1:int, _arg_2:String, _arg_3:BitmapData=null):void
        {
            var _local_7:BitmapData;
            var _local_8:Point;
            if (this._currentPetId == _arg_1){
                return;
            };
            this._currentPetId = _arg_1;
            this._SafeStr_14057 = _arg_2;
            if (this._SafeStr_14055 == null){
                return;
            };
            var _local_4:ITextWindow = (this._SafeStr_14055.findChildByName("pet_name") as ITextWindow);
            if (_local_4 != null){
                _local_4.text = _arg_2;
            };
            var _local_5:IBitmapWrapperWindow = (this._SafeStr_14055.findChildByName("avatar_image") as IBitmapWrapperWindow);
            if (_local_5 != null){
                if (_arg_3 != null){
                    _local_7 = new BitmapData(_local_5.width, _local_5.height, true, 0);
                    _local_8 = new Point(0, 0);
                    _local_8.x = Math.round(((_local_5.width - _arg_3.width) / 2));
                    _local_8.y = Math.round(((_local_5.height - _arg_3.height) / 2));
                    _local_7.copyPixels(_arg_3, _arg_3.rect, _local_8);
                    _local_5.bitmap = _local_7;
                }
                else {
                    _local_5.bitmap = null;
                };
                _local_5.invalidate();
            };
            var _local_6:CommandConfiguration = (this._enabledCommands.getValue(_arg_1) as CommandConfiguration);
            if (_local_6 == null){
                this.disableAllButtons();
                this.requestEnabledCommands(this._currentPetId);
            }
            else {
                this.updateCommandButtonsViewState(_local_6);
            };
        }
        private function onButtonDisableTimeout(_arg_1:TimerEvent):void
        {
            var _local_2:CommandConfiguration = (this._enabledCommands.getValue(this._currentPetId) as CommandConfiguration);
            this.updateCommandButtonsViewState(_local_2);
            this._SafeStr_14058.stop();
        }
        public function setEnabledCommands(_arg_1:int, _arg_2:CommandConfiguration):void
        {
            this._enabledCommands.remove(_arg_1);
            this._enabledCommands.add(_arg_1, _arg_2);
            if (_arg_1 != this._currentPetId){
                return;
            };
            this.updateCommandButtonsViewState(_arg_2);
            this._SafeStr_14058.stop();
        }
        public function showWindow(_arg_1:Boolean):void
        {
            if (_arg_1){
                if (this._SafeStr_14055 == null){
                    this.createCommandWindow();
                };
                this._SafeStr_14055.visible = true;
            }
            else {
                if (this._SafeStr_14055 != null){
                    this._SafeStr_14055.visible = false;
                };
            };
            this._SafeStr_14058.stop();
        }
        private function requestEnabledCommands(_arg_1:int):void
        {
            var _local_2:RoomWidgetPetCommandMessage = new RoomWidgetPetCommandMessage(RoomWidgetPetCommandMessage.RWPCM_REQUEST_PET_COMMANDS, _arg_1);
            this._widget.messageListener.processWidgetMessage(_local_2);
        }
        private function createCommandWindow():void
        {
            var _local_1:XmlAsset = (this._widget.assets.getAssetByName("pet_commands") as XmlAsset);
            this._SafeStr_14055 = (this._widget.windowManager.buildFromXML((_local_1.content as XML)) as IFrameWindow);
            if (this._SafeStr_14055 == null){
                throw (new Error("Failed to construct command window from XML!"));
            };
            this._SafeStr_14055.setParamFlag(WindowParam._SafeStr_7445, true);
            this._SafeStr_14055.context.getDesktopWindow().addEventListener(WindowEvent.WE_RESIZED, this.onWindowDesktopResized);
            this._SafeStr_14055.procedure = this.onCommandWindowProcedure;
            this._SafeStr_14055.position = _SafeStr_10176;
        }
        private function updateCommandButtonsViewState(_arg_1:CommandConfiguration):void
        {
            var _local_9:IButtonWindow;
            var _local_10:int;
            var _local_11:XmlAsset;
            if (this._SafeStr_14055 == null){
                return;
            };
            var _local_2:IWindowContainer = IWindowContainer(this._SafeStr_14055.findChildByName("commands_container"));
            hideChildren(_local_2);
            var _local_3:Array = _arg_1.allCommandIds;
            var _local_4:int = 25;
            var _local_5:int;
            var _local_6:int = 86;
            var _local_7:int;
            var _local_8:int;
            while (_local_8 < _local_3.length) {
                _local_9 = IButtonWindow(_local_2.getChildAt(_local_8));
                if (_local_9 == null){
                    _local_11 = (this._widget.assets.getAssetByName("pet_command") as XmlAsset);
                    _local_9 = (this._widget.windowManager.buildFromXML((_local_11.content as XML)) as IButtonWindow);
                    _local_9.procedure = this.onTrainButton;
                    _local_2.addChild(_local_9);
                };
                _local_9.visible = true;
                _local_10 = _local_3[_local_8];
                _local_9.id = _local_10;
                _local_9.caption = this._widget.localizations.getKey(("pet.command." + _local_10));
                if (_arg_1.isEnabled(_local_10)){
                    _local_9.enable();
                }
                else {
                    _local_9.disable();
                };
                _local_9.y = _local_7;
                if ((_local_8 % 2) == 1){
                    _local_7 = (_local_7 + _local_4);
                    _local_9.x = _local_6;
                }
                else {
                    _local_9.x = _local_5;
                };
                _local_8++;
            };
            _local_2.height = getLowestPoint(_local_2);
            this._SafeStr_14055.height = (_local_2.height + 160);
            this._SafeStr_14058.stop();
        }
        private function disableAllButtons():void
        {
            var _local_3:IButtonWindow;
            if (this._SafeStr_14055 == null){
                return;
            };
            var _local_1:IWindowContainer = IWindowContainer(this._SafeStr_14055.findChildByName("commands_container"));
            var _local_2:int;
            while (_local_2 < _local_1.numChildren) {
                _local_3 = IButtonWindow(_local_1.getChildAt(_local_2));
                _local_3.disable();
                _local_2++;
            };
        }
        private function openInfoWindow():void
        {
            var _local_1:XmlAsset;
            if (this._SafeStr_14056 == null){
                _local_1 = (this._widget.assets.getAssetByName("pet_commands_info") as XmlAsset);
                this._SafeStr_14056 = (this._widget.windowManager.buildFromXML((_local_1.content as XML)) as IFrameWindow);
                if (this._SafeStr_14056 == null){
                    throw (new Error("Failed to construct command info window from XML!"));
                };
                this._SafeStr_14056.x = 200;
                this._SafeStr_14056.procedure = this.onInfoWindowProcedure;
            }
            else {
                this._SafeStr_14056.visible = true;
            };
        }
        private function onInfoWindowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_3:WindowMouseEvent = (_arg_1 as WindowMouseEvent);
            if (((!((_local_3 == null))) && ((_local_3.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)))){
                if (_arg_2.name == "header_button_close"){
                    this._SafeStr_14056.visible = false;
                };
            };
        }
        private function onCommandWindowProcedure(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:int;
            var _local_5:String;
            var _local_6:String;
            var _local_7:RoomWidgetPetCommandMessage;
            var _local_3:WindowMouseEvent = (_arg_1 as WindowMouseEvent);
            if (((!((_local_3 == null))) && ((_local_3.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)))){
                if (_arg_2.name == "header_button_close"){
                    this._SafeStr_14055.visible = false;
                }
                else {
                    if (_arg_2.name == "description_link"){
                        this.openInfoWindow();
                    }
                    else {
                        if (_arg_2.name == "avatar_image"){
                            this._widget.messageListener.processWidgetMessage(new RoomWidgetUserActionMessage(RoomWidgetUserActionMessage.RWUAM_REQUEST_PET_UPDATE, this._currentPetId));
                        }
                        else {
                            if (_arg_2.name.indexOf("btn_cmd_") > -1){
                                _local_4 = int(_arg_2.name.substring(8));
                                _local_5 = ("pet.command." + _local_4);
                                _local_6 = this._widget.localizations.getKey(_local_5);
                                _local_7 = new RoomWidgetPetCommandMessage(RoomWidgetPetCommandMessage.RWPCM_PET_COMMAND, this._currentPetId, ((this._SafeStr_14057 + " ") + _local_6));
                                this._widget.messageListener.processWidgetMessage(_local_7);
                                this.disableAllButtons();
                                this._SafeStr_14058.start();
                            };
                        };
                    };
                };
            };
        }
        private function onTrainButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            var _local_3:int = _arg_2.id;
            var _local_4:String = ("pet.command." + _local_3);
            var _local_5:String = this._widget.localizations.getKey(_local_4);
            var _local_6:RoomWidgetPetCommandMessage = new RoomWidgetPetCommandMessage(RoomWidgetPetCommandMessage.RWPCM_PET_COMMAND, this._currentPetId, ((this._SafeStr_14057 + " ") + _local_5));
            this._widget.messageListener.processWidgetMessage(_local_6);
            this.disableAllButtons();
            this._SafeStr_14058.start();
        }
        private function onWindowDesktopResized(_arg_1:WindowEvent):void
        {
            var _local_2:IWindow;
            var _local_3:Rectangle;
            if (((this._SafeStr_14055) && (!(this._SafeStr_14055.disposed)))){
                _local_2 = _arg_1.window;
                _local_3 = new Rectangle();
                this._SafeStr_14055.getGlobalRectangle(_local_3);
                if (_local_3.x > _local_2.width){
                    this._SafeStr_14055.x = (_local_2.width - this._SafeStr_14055.width);
                    this._SafeStr_14055.getGlobalRectangle(_local_3);
                };
                if ((_local_3.x + _local_3.width) <= 0){
                    this._SafeStr_14055.x = 0;
                    this._SafeStr_14055.getGlobalRectangle(_local_3);
                };
                if (_local_3.y > _local_2.height){
                    this._SafeStr_14055.y = 0;
                    this._SafeStr_14055.getGlobalRectangle(_local_3);
                };
                if ((_local_3.y + _local_3.height) <= 0){
                    this._SafeStr_14055.y = 0;
                    this._SafeStr_14055.getGlobalRectangle(_local_3);
                };
            };
        }

    }
}//package com.sulake.habbo.ui.widget.infostand

// _SafeStr_10176 = "_-25d" (String#875, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// _currentPetId = "_-2l0" (String#6980, DoABC#2)
// showCommandToolForPet = "_-19V" (String#16837, DoABC#2)
// setEnabledCommands = "_-3A2" (String#21886, DoABC#2)
// getPetId = "_-2AE" (String#19413, DoABC#2)
// allCommandIds = "_-2Df" (String#19552, DoABC#2)
// _SafeStr_14054 = "_-2JV" (String#19789, DoABC#2)
// _SafeStr_14055 = "_-18Z" (String#16796, DoABC#2)
// _SafeStr_14056 = "_-0U5" (String#15208, DoABC#2)
// _SafeStr_14057 = "_-0CX" (String#14550, DoABC#2)
// _SafeStr_14058 = "_-1SY" (String#17603, DoABC#2)
// onButtonDisableTimeout = "_-1Pu" (String#17504, DoABC#2)
// disableAllButtons = "_-2Hb" (String#19710, DoABC#2)
// requestEnabledCommands = "_-0p3" (String#16017, DoABC#2)
// updateCommandButtonsViewState = "_-1MW" (String#17379, DoABC#2)
// createCommandWindow = "_-3v" (String#22372, DoABC#2)
// onWindowDesktopResized = "_-3Ew" (String#22073, DoABC#2)
// onCommandWindowProcedure = "_-1aW" (String#17915, DoABC#2)
// onTrainButton = "_-0CF" (String#14539, DoABC#2)
// openInfoWindow = "_-1OO" (String#17448, DoABC#2)
// onInfoWindowProcedure = "_-1rg" (String#18616, DoABC#2)
// CommandConfiguration = "_-2sa" (String#21184, DoABC#2)
// RoomWidgetUserActionMessage = "_-22U" (String#19109, DoABC#2)
// RoomWidgetPetCommandMessage = "_-1W9" (String#5475, DoABC#2)
// PetCommandTool = "_-1zX" (String#6025, DoABC#2)
// RWUAM_REQUEST_PET_UPDATE = "_-0Ro" (String#15130, DoABC#2)
// RWPCM_REQUEST_PET_COMMANDS = "_-1pG" (String#18512, DoABC#2)
// RWPCM_PET_COMMAND = "_-3K8" (String#22288, DoABC#2)
// hideChildren = "_-14q" (String#1615, DoABC#2)
// getLowestPoint = "_-0t0" (String#16161, DoABC#2)
// WE_RESIZED = "_-76" (String#22505, DoABC#2)
// getGlobalRectangle = "_-05T" (String#3675, DoABC#2)
// showWindow = "_-2ve" (String#21300, DoABC#2)
// isEnabled = "_-2ri" (String#21145, DoABC#2)
// _enabledCommands = "_-1GF" (String#843, DoABC#2)
// _SafeStr_7445 = "_-3Kg" (String#22311, DoABC#2)
// isVisible = "_-1rE" (String#18592, DoABC#2)



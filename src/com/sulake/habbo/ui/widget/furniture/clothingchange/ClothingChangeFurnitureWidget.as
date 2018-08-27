
package com.sulake.habbo.ui.widget.furniture.clothingchange
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.widget.events.RoomWidgetClothingChangeUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.avatar.figuredata.FigureData;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetClothingChangeMessage;

    public class ClothingChangeFurnitureWidget extends RoomWidgetBase 
    {

        private static const _SafeStr_8275:String = "Boy";
        private static const _SafeStr_8276:String = "Girl";

        private var _SafeStr_8277:IWindowContainer;
        private var _objectId:int = 0;
        private var _objectCategory:int = 0;
        private var _roomId:int = 0;
        private var _roomCategory:int = 0;

        public function ClothingChangeFurnitureWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary=null, _arg_4:IHabboLocalizationManager=null)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }
        override public function dispose():void
        {
            this.hideGenderSelectionInterface();
            super.dispose();
        }
        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.addEventListener(RoomWidgetClothingChangeUpdateEvent.RWCCUE_SHOW_GENDER_SELECTION, this.onUpdate);
            _arg_1.addEventListener(RoomWidgetClothingChangeUpdateEvent.RWCCUE_SHOW_CLOTHING_EDITOR, this.onUpdate);
            super.registerUpdateEvents(_arg_1);
        }
        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetClothingChangeUpdateEvent.RWCCUE_SHOW_GENDER_SELECTION, this.onUpdate);
            _arg_1.removeEventListener(RoomWidgetClothingChangeUpdateEvent.RWCCUE_SHOW_CLOTHING_EDITOR, this.onUpdate);
        }
        private function onUpdate(_arg_1:RoomWidgetClothingChangeUpdateEvent):void
        {
            switch (_arg_1.type){
                case RoomWidgetClothingChangeUpdateEvent.RWCCUE_SHOW_GENDER_SELECTION:
                    this.showGenderSelectionInterface(_arg_1);
                    return;
            };
        }
        private function showGenderSelectionInterface(_arg_1:RoomWidgetClothingChangeUpdateEvent):void
        {
            this.hideGenderSelectionInterface();
            this._objectId = _arg_1.objectId;
            this._objectCategory = _arg_1.objectCategory;
            this._roomId = _arg_1.roomId;
            this._roomCategory = _arg_1.roomCategory;
            var _local_2:IAsset = assets.getAssetByName("boygirl");
            var _local_3:XmlAsset = XmlAsset(_local_2);
            if (_local_3 == null){
                return;
            };
            this._SafeStr_8277 = (windowManager.createWindow("clothing change gender selection", "", HabboWindowType._SafeStr_3728, HabboWindowStyle._SafeStr_4662, (((HabboWindowParam._SafeStr_7485 | HabboWindowParam._SafeStr_7501) | HabboWindowParam._SafeStr_3730) | HabboWindowParam._SafeStr_3731), new Rectangle(100, 100, 200, 200), null, 0) as IWindowContainer);
            this._SafeStr_8277.buildFromXML(XML(_local_3.content));
            this._SafeStr_8277.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onGenderSelectionMouseEvent);
            this._SafeStr_8277.center();
            var _local_4:IWindow = this._SafeStr_8277.findChildByTag("close");
            if (_local_4 != null){
                _local_4.procedure = this.onGenderSelectionWindowClose;
            };
            _local_4 = this._SafeStr_8277.findChildByName(_SafeStr_8275);
            if (_local_4 != null){
                _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onGenderSelectionMouseEvent);
            };
            _local_4 = this._SafeStr_8277.findChildByName(_SafeStr_8276);
            if (_local_4 != null){
                _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onGenderSelectionMouseEvent);
            };
        }
        private function hideGenderSelectionInterface():void
        {
            if (this._SafeStr_8277 != null){
                this._SafeStr_8277.dispose();
                this._SafeStr_8277 = null;
            };
        }
        private function onGenderSelectionWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this.hideGenderSelectionInterface();
        }
        private function onGenderSelectionMouseEvent(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            switch (_local_3){
                case _SafeStr_8275:
                    this.requestBoyEditor();
                    this.hideGenderSelectionInterface();
                    return;
                case _SafeStr_8276:
                    this.requestGirlEditor();
                    this.hideGenderSelectionInterface();
                    return;
                case "close":
                case "close_btn":
                    this.hideGenderSelectionInterface();
                    return;
            };
        }
        private function requestBoyEditor():void
        {
            this.requestEditor(FigureData.M);
        }
        private function requestGirlEditor():void
        {
            this.requestEditor(FigureData.FEMALE);
        }
        private function requestEditor(_arg_1:String):void
        {
            var _local_2:RoomWidgetClothingChangeMessage = new RoomWidgetClothingChangeMessage(RoomWidgetClothingChangeMessage.RWCCM_REQUEST_EDITOR, _arg_1, this._objectId, this._objectCategory, this._roomId, this._roomCategory);
            messageListener.processWidgetMessage(_local_2);
        }

    }
}//package com.sulake.habbo.ui.widget.furniture.clothingchange

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// HabboWindowStyle = "_-0E1" (String#14608, DoABC#2)
// HabboWindowType = "_-29U" (String#19384, DoABC#2)
// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// ClothingChangeFurnitureWidget = "_-0hZ" (String#4458, DoABC#2)
// FigureData = "_-1BT" (String#836, DoABC#2)
// RoomWidgetClothingChangeUpdateEvent = "_-0RK" (String#4119, DoABC#2)
// RoomWidgetClothingChangeMessage = "_-2Tf" (String#6638, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// RWCCM_REQUEST_EDITOR = "_-14O" (String#16632, DoABC#2)
// _objectCategory = "_-2Bf" (String#367, DoABC#2)
// registerUpdateEvents = "_-1yD" (String#1787, DoABC#2)
// unregisterUpdateEvents = "_-0-c" (String#3556, DoABC#2)
// _SafeStr_3728 = "_-1IW" (String#5215, DoABC#2)
// _SafeStr_3730 = "_-1rZ" (String#18611, DoABC#2)
// _SafeStr_3731 = "_-B" (String#22654, DoABC#2)
// _SafeStr_4662 = "_-0g1" (String#15673, DoABC#2)
// M = "_-1c3" (String#17974, DoABC#2)
// RWCCUE_SHOW_GENDER_SELECTION = "_-0dg" (String#15572, DoABC#2)
// _SafeStr_7485 = "_-Q7" (String#23255, DoABC#2)
// _SafeStr_7501 = "_-20" (String#19009, DoABC#2)
// onUpdate = "_-Ck" (String#2075, DoABC#2)
// _SafeStr_8275 = "_-1HO" (String#17164, DoABC#2)
// _SafeStr_8276 = "_-2Dj" (String#19555, DoABC#2)
// _SafeStr_8277 = "_-1nG" (String#18435, DoABC#2)
// hideGenderSelectionInterface = "_-jS" (String#24017, DoABC#2)
// RWCCUE_SHOW_CLOTHING_EDITOR = "_-0Zz" (String#15440, DoABC#2)
// showGenderSelectionInterface = "_-0Tp" (String#15201, DoABC#2)
// onGenderSelectionMouseEvent = "_-1Ev" (String#17068, DoABC#2)
// onGenderSelectionWindowClose = "_-2Ew" (String#19600, DoABC#2)
// requestBoyEditor = "_-ur" (String#24485, DoABC#2)
// requestGirlEditor = "_-2yc" (String#21414, DoABC#2)
// requestEditor = "_-pa" (String#24256, DoABC#2)



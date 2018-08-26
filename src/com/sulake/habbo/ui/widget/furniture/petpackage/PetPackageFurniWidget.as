
package com.sulake.habbo.ui.widget.furniture.petpackage
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.components.IFrameWindow;
    import flash.display.BitmapData;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.ui.widget.events.RoomWidgetPetPackageUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.geom.Point;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetOpenPetPackageMessage;
    import com.sulake.core.window.components.ITextFieldWindow;

    public class PetPackageFurniWidget extends RoomWidgetBase 
    {

        private var _window:IFrameWindow;
        private var _objectId:int = -1;
        private var _SafeStr_13968:BitmapData;
        private var _SafeStr_13969:Boolean = false;

        public function PetPackageFurniWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }
        override public function dispose():void
        {
            this.hideInterface();
            super.dispose();
        }
        override public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.addEventListener(RoomWidgetPetPackageUpdateEvent.RWOPPUE_OPEN_PET_PACKAGE_REQUESTED, this.onObjectUpdate);
            _arg_1.addEventListener(RoomWidgetPetPackageUpdateEvent.RWOPPUE_OPEN_PET_PACKAGE_RESULT, this.onObjectUpdate);
            _arg_1.addEventListener(RoomWidgetPetPackageUpdateEvent.RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE, this.onObjectUpdate);
            super.RoomChatWidget(_arg_1);
        }
        override public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetPetPackageUpdateEvent.RWOPPUE_OPEN_PET_PACKAGE_REQUESTED, this.onObjectUpdate);
            _arg_1.removeEventListener(RoomWidgetPetPackageUpdateEvent.RWOPPUE_OPEN_PET_PACKAGE_RESULT, this.onObjectUpdate);
            _arg_1.removeEventListener(RoomWidgetPetPackageUpdateEvent.RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE, this.onObjectUpdate);
            super.RoomChatWidget(_arg_1);
        }
        private function onObjectUpdate(event:RoomWidgetPetPackageUpdateEvent):void
        {
            var nameValidationStatus:int;
            var nameValidationInfo:String;
            var error:String;
            var resultMessage:String;
            switch (event.type){
                case RoomWidgetPetPackageUpdateEvent.RWOPPUE_OPEN_PET_PACKAGE_REQUESTED:
                    this.hideInterface();
                    this._objectId = event.objectId;
                    this._SafeStr_13968 = event.image;
                    this.showInterface();
                    this.showPetImage();
                    return;
                case RoomWidgetPetPackageUpdateEvent.RWOPPUE_OPEN_PET_PACKAGE_RESULT:
                    if (!this._SafeStr_13969){
                        return;
                    };
                    this._SafeStr_13969 = false;
                    nameValidationStatus = event.nameValidationStatus;
                    nameValidationInfo = event.nameValidationInfo;
                    switch (nameValidationStatus){
                        case 0:
                            this.hideInterface();
                            return;
                        case 1:
                            error = "long";
                            break;
                        case 2:
                            error = "short";
                            break;
                        case 3:
                            error = "chars";
                            break;
                        default:
                            error = "bobba";
                    };
                    resultMessage = this.constructErrorMessage(error, nameValidationInfo);
                    windowManager.alert("${widgets.petpackage.alert.petname.title}", resultMessage, 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                    {
                        _arg_1.dispose();
                    });
                    return;
                case RoomWidgetPetPackageUpdateEvent.RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE:
                    if (event.objectId != this._objectId){
                        return;
                    };
                    this._SafeStr_13968 = event.image;
                    this.showPetImage();
                    return;
            };
        }
        private function constructErrorMessage(_arg_1:String, _arg_2:String):String
        {
            var _local_3:String = ("catalog.alert.petname." + _arg_1);
            var _local_4 = (_local_3 + ".additionalInfo");
            localizations.registerParameter(_local_4, "additional_info", _arg_2);
            var _local_5:String = localizations.getKey(_local_3);
            var _local_6:String = localizations.getKey(_local_4);
            if (((((((!((_arg_2 == null))) && ((_arg_2.length > 0)))) && (!((_local_6 == null))))) && ((_local_6.length > 0)))){
                _local_5 = _local_6;
            };
            return (_local_5);
        }
        private function hideInterface():void
        {
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
            this._objectId = -1;
            this._SafeStr_13969 = false;
            this._SafeStr_13968 = null;
        }
        private function showInterface():void
        {
            var _local_4:IWindow;
            if (this._objectId < 0){
                return;
            };
            var _local_1:IAsset = assets.getAssetByName("petpackage");
            var _local_2:XmlAsset = XmlAsset(_local_1);
            if (_local_2 == null){
                return;
            };
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
            this._window = (windowManager.buildFromXML(XML(_local_2.content)) as IFrameWindow);
            this._window.center();
            var _local_3:IWindow = this._window.header.findChildByTag("close");
            if (_local_3){
                _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onWindowClose);
            };
            _local_4 = this._window.findChildByName("pick_name");
            if (_local_4 != null){
                _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
            };
            _local_4 = this._window.findChildByName("cancel");
            if (_local_4 != null){
                _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
            };
            this._window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
            this.showPetImage();
        }
        private function showPetImage():void
        {
            var _local_2:Point;
            if ((((this._SafeStr_13968 == null)) || ((this._window == null)))){
                return;
            };
            var _local_1:IBitmapWrapperWindow = (this._window.findChildByName("pet_image") as IBitmapWrapperWindow);
            if (_local_1 != null){
                _local_1.bitmap = new BitmapData(_local_1.width, _local_1.height, true, 0);
                _local_2 = new Point(((_local_1.width - this._SafeStr_13968.width) / 2), ((_local_1.height - this._SafeStr_13968.height) / 2));
                _local_1.bitmap.copyPixels(this._SafeStr_13968, this._SafeStr_13968.rect, _local_2);
            };
        }
        private function onWindowClose(_arg_1:WindowEvent):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this.hideInterface();
        }
        private function onMouseEvent(_arg_1:WindowMouseEvent):void
        {
            var _local_2:IWindow = (_arg_1.target as IWindow);
            var _local_3:String = _local_2.name;
            switch (_local_3){
                case "pick_name":
                    this.sendOpenPetPackage();
                    return;
                case "cancel":
                    this.hideInterface();
                    return;
            };
        }
        private function sendOpenPetPackage():void
        {
            var message:RoomWidgetOpenPetPackageMessage;
            if (((this._SafeStr_13969) || ((this._objectId == -1)))){
                return;
            };
            var name:String = this.getName();
            if ((((name == null)) || ((name.length < 1)))){
                windowManager.alert("${widgets.petpackage.alert.petname.title}", "${catalog.alert.petname.short}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                {
                    _arg_1.dispose();
                });
                return;
            };
            if (messageListener != null){
                this._SafeStr_13969 = true;
                message = new RoomWidgetOpenPetPackageMessage(RoomWidgetOpenPetPackageMessage.RWOPPM_OPEN_PET_PACKAGE, this._objectId, name);
                messageListener.processWidgetMessage(message);
            };
        }
        private function getName():String
        {
            var _local_1:ITextFieldWindow;
            if (this._window){
                _local_1 = (this._window.findChildByName("input") as ITextFieldWindow);
                if (_local_1){
                    return (_local_1.text);
                };
            };
            return (null);
        }

    }
}//package com.sulake.habbo.ui.widget.furniture.petpackage

// constructErrorMessage = "_-2-W" (String#1796, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// _SafeStr_13968 = "_-2K-" (String#19806, DoABC#2)
// _SafeStr_13969 = "_-1fw" (String#18136, DoABC#2)
// showPetImage = "_-2CZ" (String#19508, DoABC#2)
// sendOpenPetPackage = "_-15b" (String#16679, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// PetPackageFurniWidget = "_-2bM" (String#6779, DoABC#2)
// RoomWidgetPetPackageUpdateEvent = "_-2N6" (String#6503, DoABC#2)
// RoomWidgetOpenPetPackageMessage = "_-0jy" (String#4501, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// RWOPPM_OPEN_PET_PACKAGE = "_-2Bv" (String#19479, DoABC#2)
// hideInterface = "_-29" (String#304, DoABC#2)
// RoomChatWidget = "_-1yD" (String#1787, DoABC#2)
// onObjectUpdate = "_-2l-" (String#248, DoABC#2)
// RoomChatWidget = "_-0-c" (String#3556, DoABC#2)
// showInterface = "_-121" (String#162, DoABC#2)
// onMouseEvent = "_-0ZW" (String#357, DoABC#2)
// getName = "_-D1" (String#931, DoABC#2)
// onWindowClose = "_-2tr" (String#136, DoABC#2)
// RWOPPUE_OPEN_PET_PACKAGE_REQUESTED = "_-0lb" (String#15884, DoABC#2)
// RWOPPUE_OPEN_PET_PACKAGE_RESULT = "_-0zY" (String#16409, DoABC#2)
// RWOPPUE_OPEN_PET_PACKAGE_UPDATE_PET_IMAGE = "_-tS" (String#24425, DoABC#2)




package com.sulake.habbo.ui.widget.furniture.welcomegift
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniActionMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChangeEmailMessage;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.habbo.ui.widget.events.RoomWidgetWelcomeGiftUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChangeEmailResultEvent;
    import flash.events.IEventDispatcher;

    public class WelcomeGiftWidget extends RoomWidgetBase 
    {

        private const _SafeStr_7992:String = "welcome_gift_email_unverified";
        private const _SafeStr_7993:String = "welcome_gift_email_verified";
        private const _SafeStr_7994:String = "welcome_gift_email_change";
        private const _SafeStr_7995:int = 4;

        private var _disposed:Boolean = false;
        private var _view:IWindowContainer;
        private var _email:String;
        private var _SafeStr_7997:String;
        private var _isVerified:Boolean;
        private var _allowEmailChange:Boolean;
        private var _furniId:int;
        private var _SafeStr_8000:String;

        public function WelcomeGiftWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
        }
        override public function get disposed():Boolean
        {
            return (this._disposed);
        }
        override public function dispose():void
        {
            if (this._disposed){
                return;
            };
            if (this._view){
                this._view.dispose();
            };
            super.dispose();
            this._disposed = true;
        }
        private function createMainView():void
        {
            if (this._view){
                this._view.dispose();
            };
            this._view = (this.createView("welcome_gift_widget") as IWindowContainer);
            this._view.center();
            this.setBitmap("image_bg", "yellow_highlight");
            this.setBitmap("gift_image", "giftbox_full");
            if (this._isVerified){
                this.setViewState(this._SafeStr_7993);
            }
            else {
                this.setViewState(this._SafeStr_7992);
            };
        }
        private function createView(_arg_1:String):IWindow
        {
            var _local_2:XmlAsset = (assets.getAssetByName(_arg_1) as XmlAsset);
            if (!_local_2){
                return (null);
            };
            return (windowManager.buildFromXML((_local_2.content as XML)));
        }
        private function disposeView():void
        {
            if (this._view){
                this._view.dispose();
                this._view = null;
            };
        }
        private function setViewState(_arg_1:String):void
        {
            var _local_6:ITextFieldWindow;
            if (this._view == null){
                return;
            };
            var _local_2:IWindowContainer = (this._view.findChildByName("state_content") as IWindowContainer);
            while (_local_2.numChildren > 0) {
                _local_2.removeChildAt(0);
            };
            var _local_3:IWindow = this.createView(_arg_1);
            if (!_local_3){
                Logger.log(("invalid welcome gift widget state: " + _arg_1));
                return;
            };
            _local_2.addChild(_local_3);
            _local_2.height = _local_3.height;
            switch (_arg_1){
                case this._SafeStr_7992:
                    this.addClickHandler(this._view.findChildByName("edit"), this.changeEmail);
                    this.setBitmap("email_icon", "email_icon");
                    this.setCaption("title", "${welcome.gift.title.email.unverified}");
                    this.setCaption("text", "${welcome.gift.text.email.unverified}");
                    this._view.findChildByName("edit_text").visible = this._allowEmailChange;
                    this._view.findChildByName("edit").setParamFlag(WindowParam._SafeStr_7434, this._allowEmailChange);
                    break;
                case this._SafeStr_7993:
                    this.setBitmap("email_icon", "ok_icon");
                    this.setCaption("title", "${welcome.gift.title.email.verified}");
                    this.setCaption("text", "${welcome.gift.text.email.verified}");
                    break;
                case this._SafeStr_7994:
                    this.addClickHandler(this._view.findChildByName("cancel_email_change"), this.cancelEmailChange);
                    this.addClickHandler(this._view.findChildByName("save_email"), this.saveEmail);
                    this.setBitmap("email_icon", "email_icon");
                    this.setButtonState("save_email", this._allowEmailChange);
                    _local_6 = (this._view.findChildByName("email_input") as ITextFieldWindow);
                    _local_6.caption = this._email;
                    _local_6.focus();
                    _local_6.setSelection(0, int.MAX_VALUE);
                    break;
            };
            var _local_4:IWindow = this._view.findChildByName("email");
            if (_local_4){
                _local_4.caption = this._email;
            };
            var _local_5:IWindow = this._view.findChildByName("open");
            if (_local_5){
                if (this._isVerified){
                    _local_5.enable();
                }
                else {
                    _local_5.disable();
                };
            };
            this.addClickHandler(this._view.findChildByName("close"), this.close);
            this.addClickHandler(this._view.findChildByTag("close"), this.close);
            this.addClickHandler(this._view.findChildByName("open"), this.openGift);
            this._SafeStr_8000 = _arg_1;
        }
        private function setCaption(_arg_1:String, _arg_2:String):void
        {
            if (!this._view){
                return;
            };
            var _local_3:IWindow = this._view.findChildByName(_arg_1);
            if (_local_3){
                _local_3.caption = _arg_2;
            };
        }
        private function setBitmap(_arg_1:String, _arg_2:String):void
        {
            var _local_3:IBitmapWrapperWindow = (this._view.findChildByName(_arg_1) as IBitmapWrapperWindow);
            var _local_4:BitmapDataAsset = (_assets.getAssetByName(_arg_2) as BitmapDataAsset);
            if (((!(_local_3)) || (!(_local_4)))){
                return;
            };
            var _local_5:BitmapData = (_local_4.content as BitmapData);
            if (_local_3.bitmap){
                _local_3.bitmap.dispose();
            };
            _local_3.bitmap = _local_5.clone();
        }
        private function addClickHandler(_arg_1:IWindow, _arg_2:Function):void
        {
            if (_arg_1){
                _arg_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, _arg_2);
            };
        }
        private function close(_arg_1:WindowMouseEvent):void
        {
            this.disposeView();
        }
        private function changeEmail(_arg_1:WindowMouseEvent):void
        {
            this.setViewState(this._SafeStr_7994);
        }
        private function openGift(_arg_1:WindowMouseEvent):void
        {
            messageListener.processWidgetMessage(new RoomWidgetFurniActionMessage(RoomWidgetFurniActionMessage.RWFAM_OPEN_WELCOME_GIFT, this._furniId, 0));
            this.disposeView();
        }
        private function cancelEmailChange(_arg_1:WindowMouseEvent):void
        {
            this.setViewState(((this._isVerified) ? this._SafeStr_7993 : this._SafeStr_7992));
        }
        private function saveEmail(_arg_1:WindowMouseEvent):void
        {
            if (!this._allowEmailChange){
                return;
            };
            var _local_2:ITextFieldWindow = (this._view.findChildByName("email_input") as ITextFieldWindow);
            this._view.findChildByName("cancel_email_change").setParamFlag(WindowParam._SafeStr_7434, false);
            this.setButtonState("save_email", false);
            _local_2.editable = false;
            _local_2.selectable = false;
            this._SafeStr_7997 = _local_2.text;
            messageListener.processWidgetMessage(new RoomWidgetChangeEmailMessage(this._SafeStr_7997));
        }
        private function setButtonState(_arg_1:String, _arg_2:Boolean):void
        {
            if (!this._view){
                return;
            };
            var _local_3:IButtonWindow = (this._view.findChildByName(_arg_1) as IButtonWindow);
            if (_local_3){
                if (_arg_2){
                    _local_3.enable();
                }
                else {
                    _local_3.disable();
                };
            };
        }
        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (!_arg_1){
                return;
            };
            _arg_1.addEventListener(RoomWidgetWelcomeGiftUpdateEvent._SafeStr_8012, this.updateEventHandler);
            _arg_1.addEventListener(RoomWidgetChangeEmailResultEvent._SafeStr_8013, this.emailChangeHandler);
            super.registerUpdateEvents(_arg_1);
        }
        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetWelcomeGiftUpdateEvent._SafeStr_8012, this.updateEventHandler);
            _arg_1.removeEventListener(RoomWidgetChangeEmailResultEvent._SafeStr_8013, this.emailChangeHandler);
        }
        private function updateEventHandler(_arg_1:RoomWidgetWelcomeGiftUpdateEvent):void
        {
            switch (_arg_1.type){
                case RoomWidgetWelcomeGiftUpdateEvent._SafeStr_8012:
                    this._email = _arg_1.email;
                    this._isVerified = _arg_1.isVerified;
                    this._allowEmailChange = _arg_1.allowEmailChange;
                    if (_arg_1.requestedByUser){
                        this._furniId = _arg_1.furniId;
                        this.createMainView();
                    }
                    else {
                        this.updateView();
                    };
                    return;
            };
        }
        private function updateView():void
        {
            if (!this._view){
                return;
            };
            if (this._isVerified){
                this.setViewState(this._SafeStr_7993);
            }
            else {
                this.setViewState(this._SafeStr_7992);
            };
        }
        private function emailChangeHandler(_arg_1:RoomWidgetChangeEmailResultEvent):void
        {
            if (_arg_1.result == 0){
                this._email = this._SafeStr_7997;
                this.setViewState(this._SafeStr_7992);
            }
            else {
                if (_arg_1.result == this._SafeStr_7995){
                    this._allowEmailChange = false;
                };
                this.showEmailChangeError(_arg_1.result);
            };
        }
        private function showEmailChangeError(_arg_1:int):void
        {
            if (!this._view){
                return;
            };
            this.setViewState(this._SafeStr_7994);
            var _local_2:IWindow = this._view.findChildByName("email_input_container");
            if (_local_2){
                _local_2.color = 0xFFFF8888;
            };
            this.setCaption("email_input", this._SafeStr_7997);
            this.setCaption("email_change_instructions", ((("$" + "{welcome.gift.email.error.") + _arg_1) + "}"));
        }

    }
}//package com.sulake.habbo.ui.widget.furniture.welcomegift

// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// WelcomeGiftWidget = "_-1Jh" (String#5235, DoABC#2)
// RoomWidgetWelcomeGiftUpdateEvent = "_-1ad" (String#5570, DoABC#2)
// RoomWidgetFurniActionMessage = "_-02g" (String#3622, DoABC#2)
// RoomWidgetChangeEmailMessage = "_-2iU" (String#6920, DoABC#2)
// RoomWidgetChangeEmailResultEvent = "_-1i2" (String#5710, DoABC#2)
// furniId = "_-2KO" (String#6454, DoABC#2)
// RWFAM_OPEN_WELCOME_GIFT = "_-2ef" (String#20633, DoABC#2)
// registerUpdateEvents = "_-1yD" (String#1787, DoABC#2)
// unregisterUpdateEvents = "_-0-c" (String#3556, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// updateEventHandler = "_-et" (String#8495, DoABC#2)
// updateView = "_-1Js" (String#847, DoABC#2)
// isVerified = "_-0hd" (String#15732, DoABC#2)
// allowEmailChange = "_-FE" (String#22823, DoABC#2)
// requestedByUser = "_-1cw" (String#18009, DoABC#2)
// _SafeStr_7434 = "_-2xA" (String#21356, DoABC#2)
// _SafeStr_7992 = "_-0Jz" (String#14840, DoABC#2)
// _SafeStr_7993 = "_-3EY" (String#22057, DoABC#2)
// _SafeStr_7994 = "_-30q" (String#21533, DoABC#2)
// _SafeStr_7995 = "_-0d3" (String#15551, DoABC#2)
// _email = "_-1k7" (String#1751, DoABC#2)
// _SafeStr_7997 = "_-2yj" (String#21419, DoABC#2)
// _isVerified = "_-0TI" (String#1479, DoABC#2)
// _allowEmailChange = "_-2hd" (String#6899, DoABC#2)
// _SafeStr_8000 = "_-3B1" (String#21923, DoABC#2)
// createMainView = "_-1Yq" (String#17844, DoABC#2)
// setBitmap = "_-1k8" (String#5753, DoABC#2)
// setViewState = "_-IL" (String#22943, DoABC#2)
// disposeView = "_-jU" (String#2169, DoABC#2)
// addClickHandler = "_-2wp" (String#21338, DoABC#2)
// changeEmail = "_-32H" (String#21592, DoABC#2)
// setCaption = "_-rz" (String#8735, DoABC#2)
// cancelEmailChange = "_-25n" (String#19250, DoABC#2)
// saveEmail = "_-0Sz" (String#15169, DoABC#2)
// setButtonState = "_-0CM" (String#14544, DoABC#2)
// openGift = "_-1yL" (String#18902, DoABC#2)
// _SafeStr_8012 = "_-2it" (String#20802, DoABC#2)
// _SafeStr_8013 = "_-nY" (String#24173, DoABC#2)
// emailChangeHandler = "_-0-b" (String#14036, DoABC#2)
// showEmailChangeError = "_-1tA" (String#18685, DoABC#2)



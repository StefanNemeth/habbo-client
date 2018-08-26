
package com.sulake.habbo.messenger
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.components.IFrameWindow;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import com.sulake.habbo.messenger.domain.Conversation;
    import com.sulake.habbo.messenger.domain.Message;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.ui.Keyboard;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.SendMsgMessageComposer;

    public class MessengerView implements IDisposable 
    {

        private var _messenger:HabboMessenger;
        private var _SafeStr_11707:ConversationsTabView;
        private var _SafeStr_11284:ITextFieldWindow;
        private var _InventoryMainView:IFrameWindow;
        private var _SafeStr_11708:ConversationView;
        private var _SafeStr_4247:Timer;
        private var _disposed:Boolean = false;

        public function MessengerView(_arg_1:HabboMessenger)
        {
            this._messenger = _arg_1;
            this._SafeStr_4247 = new Timer(300, 1);
            this._SafeStr_4247.addEventListener(TimerEvent.TIMER, this.onResizeTimer);
        }
        public function dispose():void
        {
            if (!this._disposed){
                if (this._SafeStr_4247){
                    this._SafeStr_4247.stop();
                    this._SafeStr_4247.removeEventListener(TimerEvent.TIMER, this.onResizeTimer);
                    this._SafeStr_4247 = null;
                };
                this._messenger = null;
                this._disposed = true;
            };
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function MessengerView():Boolean
        {
            return (((!((this._InventoryMainView == null))) && (this._InventoryMainView.visible)));
        }
        public function close():void
        {
            if (this._InventoryMainView != null){
                this._InventoryMainView.visible = false;
            };
        }
        public function MessengerView():void
        {
            if (this._messenger.conversations.openConversations.length < 1){
                return;
            };
            if (this._InventoryMainView == null){
                this.MessengerView();
                this.refresh();
            }
            else {
                this.refresh();
                this._InventoryMainView.visible = true;
                this._InventoryMainView.activate();
            };
        }
        public function refresh():void
        {
            if (this._InventoryMainView == null){
                return;
            };
            var _local_1:Conversation = this._messenger.conversations.findSelectedConversation();
            this._InventoryMainView.caption = (((_local_1 == null)) ? "" : _local_1.name);
            this._SafeStr_11707.refresh();
            this._SafeStr_11708.refresh();
            if (this._messenger.conversations.openConversations.length < 1){
                this._InventoryMainView.visible = false;
            };
        }
        public function MessengerView(_arg_1:Conversation, _arg_2:Message):void
        {
            if (this._InventoryMainView == null){
                return;
            };
            if (!_arg_1.selected){
                return;
            };
            this._SafeStr_11708.addMessage(_arg_2);
        }
        private function MessengerView():void
        {
            this._InventoryMainView = IFrameWindow(this._messenger.getXmlWindow("main_window"));
            var _local_1:IWindow = this._InventoryMainView.findChildByTag("close");
            _local_1.procedure = this.onWindowClose;
            this._InventoryMainView.procedure = this.RoomVisitsCtrl;
            this._InventoryMainView.title.color = 0xFFFAC200;
            this._InventoryMainView.title.textColor = 4287851525;
            this._SafeStr_11707 = new ConversationsTabView(this._messenger, this._InventoryMainView);
            this._SafeStr_11707.refresh();
            this._SafeStr_11284 = ITextFieldWindow(this._InventoryMainView.findChildByName("message_input"));
            this._SafeStr_11284.addEventListener(WindowKeyboardEvent.WKE_KEY_DOWN, this.MessengerView);
            this._SafeStr_11708 = new ConversationView(this._messenger, this._InventoryMainView);
            this._InventoryMainView.scaler.setParamFlag(HabboWindowParam._SafeStr_4267, false);
            this._InventoryMainView.scaler.setParamFlag(HabboWindowParam._SafeStr_7493, true);
            this._InventoryMainView.center();
        }
        private function MessengerView(_arg_1:WindowKeyboardEvent):void
        {
            var _local_2:int;
            var _local_3:String;
            if (_arg_1.charCode == Keyboard.ENTER){
                this.MessengerView();
            }
            else {
                _local_2 = 120;
                _local_3 = this._SafeStr_11284.text;
                if (_local_3.length > _local_2){
                    this._SafeStr_11284.text = _local_3.substring(0, _local_2);
                };
            };
        }
        private function RoomVisitsCtrl(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((!((_arg_1.type == WindowEvent.WE_RESIZED))) || (!((_arg_2 == this._InventoryMainView))))){
                return;
            };
            if (!this._SafeStr_4247.running){
                this._SafeStr_4247.reset();
                this._SafeStr_4247.start();
            };
        }
        private function onResizeTimer(_arg_1:TimerEvent):void
        {
            Logger.log("XXX RESIZE XXX");
            this._SafeStr_11708.afterResize();
            this._SafeStr_11707.refresh();
        }
        private function onWindowClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("Close window");
            this._InventoryMainView.visible = false;
        }
        private function MessengerView():void
        {
            var _local_1:String = this._SafeStr_11284.text;
            Logger.log(("Send msg: " + _local_1));
            if (_local_1 == ""){
                Logger.log("No text...");
                return;
            };
            var _local_2:Conversation = this._messenger.conversations.findSelectedConversation();
            if (_local_2 == null){
                Logger.log("No conversation...");
                return;
            };
            this._messenger.send(new SendMsgMessageComposer(_local_2.id, _local_1));
            if (_local_2.messages.length == 1){
                this._messenger.playSendSound();
            };
            this._SafeStr_11284.text = "";
            this._messenger.conversations.addMessageAndUpdateView(new Message(Message._SafeStr_4666, _local_2.id, _local_1, Util.getFormattedNow()));
        }
        public function MessengerView():int
        {
            return ((((this._SafeStr_11707 == null)) ? 7 : this._SafeStr_11707.MessengerView()));
        }

    }
}//package com.sulake.habbo.messenger

// RoomVisitsCtrl = "_-1zg" (String#873, DoABC#2)
// _SafeStr_11284 = "_-1X1" (String#5497, DoABC#2)
// MessengerView = "_-37F" (String#7451, DoABC#2)
// MessengerView = "_-38W" (String#7482, DoABC#2)
// _SafeStr_11707 = "_-1YU" (String#17831, DoABC#2)
// _SafeStr_11708 = "_-oL" (String#24206, DoABC#2)
// MessengerView = "_-1dh" (String#18044, DoABC#2)
// MessengerView = "_-04S" (String#14221, DoABC#2)
// conversations = "_-1Zf" (String#17877, DoABC#2)
// MessengerView = "_-0Rx" (String#15133, DoABC#2)
// afterResize = "_-1fv" (String#18135, DoABC#2)
// playSendSound = "_-B8" (String#22660, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// WindowKeyboardEvent = "_-0Di" (String#1433, DoABC#2)
// MessengerView = "_-2hj" (String#6900, DoABC#2)
// Util = "_-1ve" (String#445, DoABC#2)
// Message = "_-0r8" (String#4665, DoABC#2)
// Conversation = "_-Ej" (String#7965, DoABC#2)
// ConversationsTabView = "_-2dm" (String#6829, DoABC#2)
// ConversationView = "_-2jb" (String#6947, DoABC#2)
// SendMsgMessageComposer = "_-2Gh" (String#19668, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// _InventoryMainView = "_-1P" (String#361, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// _SafeStr_4247 = "_-0RI" (String#586, DoABC#2)
// onWindowClose = "_-2tr" (String#136, DoABC#2)
// WE_RESIZED = "_-76" (String#22505, DoABC#2)
// _SafeStr_4267 = "_-36k" (String#21755, DoABC#2)
// MessengerView = "_-FK" (String#7977, DoABC#2)
// MessengerView = "_-nV" (String#8668, DoABC#2)
// _SafeStr_4666 = "_-1Un" (String#17696, DoABC#2)
// findSelectedConversation = "_-0wy" (String#16309, DoABC#2)
// addMessage = "_-1Jl" (String#17266, DoABC#2)
// addMessageAndUpdateView = "_-2aB" (String#20449, DoABC#2)
// openConversations = "_-0FN" (String#14660, DoABC#2)
// getFormattedNow = "_-1y3" (String#18889, DoABC#2)
// WKE_KEY_DOWN = "_-fs" (String#23884, DoABC#2)
// _SafeStr_7493 = "_-0le" (String#15886, DoABC#2)




package com.sulake.habbo.messenger
{
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.core.window.components.IContainerButtonWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.messenger.domain.Conversation;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.messenger.domain.Message;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import flash.utils.Dictionary;
    import flash.external.ExternalInterface;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.core.window.components.*;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.*;
    import com.sulake.habbo.messenger.domain.*;

    public class ConversationView 
    {

        private static const _SafeStr_11722:int = 10;
        private static const _SafeStr_11723:int = 100;
        private static const _SafeStr_11724:int = 20;

        private var _messenger:HabboMessenger;
        private var _SafeStr_11725:IScrollbarWindow;
        private var _SafeStr_11726:IContainerButtonWindow;
        private var _content:IItemListWindow;
        private var _SafeStr_11727:Conversation;

        public function ConversationView(_arg_1:HabboMessenger, _arg_2:IWindowContainer)
        {
            this._messenger = _arg_1;
            this._SafeStr_11726 = this.initButton("follow_friend", this.onFollowButtonClick, _arg_2);
            this._content = IItemListWindow(_arg_2.findChildByName("msg_list"));
            this._SafeStr_11725 = IScrollbarWindow(_arg_2.findChildByName("scroller"));
            this._messenger.refreshButton(_arg_2, "close", true, this.onCloseButtonClick, 0);
            this.initButton("minimail", this.onMinimailButtonClick, _arg_2);
        }
        public function addMessage(_arg_1:Message):void
        {
            var _local_2:int = this.findAddIndex();
            if (_local_2 >= (_SafeStr_11723 + _SafeStr_11724)){
                this.refreshList();
                this.afterResize();
            }
            else {
                this._content.autoArrangeItems = false;
                this.refreshEntry(true, _local_2, _arg_1);
                this._content.autoArrangeItems = true;
            };
            this._SafeStr_11725.scrollV = 1;
            this.refreshScrollBarVisibility();
        }
        public function afterResize():void
        {
            this.refreshListDims();
            var _local_1:Boolean = this.refreshScrollBarVisibility();
            if (_local_1){
                this.refreshListDims();
            };
        }
        private function initButton(_arg_1:String, _arg_2:Function, _arg_3:IWindowContainer):IContainerButtonWindow
        {
            var _local_4:IContainerButtonWindow = IContainerButtonWindow(_arg_3.findChildByName(("button_" + _arg_1)));
            _local_4.procedure = _arg_2;
            var _local_5:IBitmapWrapperWindow = IBitmapWrapperWindow(_local_4.findChildByName("icon"));
            _local_5.bitmap = this._messenger.getButtonImage(_arg_1);
            _local_5.width = _local_5.bitmap.width;
            _local_5.height = _local_5.bitmap.height;
            return (_local_4);
        }
        private function refreshListDims():void
        {
            var _local_2:ITextWindow;
            this._content.autoArrangeItems = false;
            var _local_1:int;
            while (_local_1 < this._content.numListItems) {
                _local_2 = ITextWindow(this._content.getListItemAt(_local_1));
                this.refreshTextDims(_local_2);
                if (!_local_2.visible) break;
                _local_1++;
            };
            this._content.autoArrangeItems = true;
        }
        private function refreshTextDims(_arg_1:ITextWindow):void
        {
            _arg_1.width = this._content.width;
            _arg_1.height = (_arg_1.textHeight + _SafeStr_11722);
            _arg_1.invalidate();
        }
        private function refreshScrollBarVisibility():Boolean
        {
            var _local_1:IWindowContainer = IWindowContainer(this._content.parent);
            var _local_2:IWindow = (_local_1.getChildByName("scroller") as IWindow);
            var _local_3 = (this._content.scrollableRegion.height > this._content.height);
            var _local_4:int = 22;
            if (_local_2.visible){
                if (_local_3){
                    return (false);
                };
                _local_2.visible = false;
                this._content.width = (this._content.width + _local_4);
                return (true);
            };
            if (_local_3){
                _local_2.visible = true;
                this._content.width = (this._content.width - _local_4);
                return (true);
            };
            return (false);
        }
        private function findAddIndex():int
        {
            var _local_2:IWindow;
            var _local_1:int;
            while (_local_1 < this._content.numListItems) {
                _local_2 = this._content.getListItemAt(_local_1);
                if (!_local_2.visible){
                    return (_local_1);
                };
                _local_1++;
            };
            return ((_local_1 + 1));
        }
        public function refresh():void
        {
            var _local_1:Conversation = this._messenger.conversations.findSelectedConversation();
            if (_local_1 == null){
                return;
            };
            if ((((this._SafeStr_11727 == null)) || (!((_local_1.id == this._SafeStr_11727.id))))){
                this._SafeStr_11727 = _local_1;
                this.refreshList();
                this.afterResize();
            };
            this.refreshHeader();
        }
        public function refreshHeader():void
        {
            if (this._SafeStr_11727.followingAllowed){
                this._SafeStr_11726.enable();
            }
            else {
                this._SafeStr_11726.disable();
            };
        }
        private function refreshList():void
        {
            var _local_3:Boolean;
            if (this._content == null){
                return;
            };
            this._content.autoArrangeItems = false;
            var _local_1:int;
            var _local_2:int = Math.max(0, (this._SafeStr_11727.messages.length - _SafeStr_11723));
            _local_1 = 0;
            while ((_local_1 + _local_2) < this._SafeStr_11727.messages.length) {
                this.refreshEntry(true, _local_1, this._SafeStr_11727.messages[(_local_1 + _local_2)]);
                _local_1++;
            };
            while (true) {
                _local_3 = this.refreshEntry(false, _local_1, null);
                if (_local_3) break;
                _local_1++;
            };
            this._content.autoArrangeItems = true;
        }
        private function refreshEntry(_arg_1:Boolean, _arg_2:int, _arg_3:Message):Boolean
        {
            var _local_4:ITextWindow = (this._content.getListItemAt(_arg_2) as ITextWindow);
            if (_local_4 == null){
                if (!_arg_1){
                    return (true);
                };
                _local_4 = ITextWindow(this._messenger.getXmlWindow("msg_entry"));
                _local_4.width = this._content.width;
                this._content.addListItem(_local_4);
            };
            if (!_arg_1){
                _local_4.height = 0;
                _local_4.visible = false;
                return (false);
            };
            _local_4.visible = true;
            var _local_5:String = (((((_arg_3.type == Message._SafeStr_4666)) || ((_arg_3.type == Message._SafeStr_4667)))) ? (_arg_3.time + ": ") : "");
            _local_4.text = (_local_5 + _arg_3.messageText);
            _local_4.color = this.getChatBgColor(_arg_3.type);
            _local_4.textColor = this.getChatTextColor(_arg_3.type);
            this.refreshTextDims(_local_4);
            return (false);
        }
        private function onMinimailButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("Minimail clicked");
            var _local_3:Dictionary = new Dictionary();
            _local_3["recipientid"] = ("" + this._SafeStr_11727.id);
            _local_3["random"] = ("" + Math.round((Math.random() * 100000000)));
            if (this._messenger.isEmbeddedMinimailEnabled()){
                if (ExternalInterface.available){
                    ExternalInterface.call("FlashExternalInterface.openHabblet", "minimail", (((("#mail/compose/" + _local_3["recipientid"]) + "/") + _local_3["random"]) + "/"));
                };
            }
            else {
                this._messenger.openHabboWebPage("link.format.mail.compose", _local_3, _arg_1);
            };
        }
        private function onFollowButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("Follow clicked");
            this._messenger.send(new FollowFriendMessageComposer(this._SafeStr_11727.id));
            this._messenger.send(new EventLogMessageComposer("Navigation", "IM", "go.im"));
        }
        private function onCloseButtonClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("Close clicked");
            this._messenger.conversations.closeConversation();
            this._messenger.messengerView.refresh();
        }
        private function getChatBgColor(_arg_1:int):uint
        {
            if (_arg_1 == Message._SafeStr_4666){
                return (0xFFFFFFFF);
            };
            if (_arg_1 == Message._SafeStr_4667){
                return (4292801535);
            };
            if (_arg_1 == Message._SafeStr_4669){
                return (0xFFFF6666);
            };
            if (_arg_1 == Message._SafeStr_4668){
                return (4293454056);
            };
            if (_arg_1 == Message._SafeStr_4670){
                return (4293454056);
            };
            if (_arg_1 == Message._SafeStr_4671){
                return (4288269465);
            };
            return (4291611852);
        }
        private function getChatTextColor(_arg_1:int):uint
        {
            if (_arg_1 == Message._SafeStr_4668){
                return (4285887861);
            };
            if (_arg_1 == Message._SafeStr_4670){
                return (4285887861);
            };
            return (0xFF000000);
        }

    }
}//package com.sulake.habbo.messenger

// openHabboWebPage = "_-2w" (String#7202, DoABC#2)
// onMinimailButtonClick = "_-04L" (String#1396, DoABC#2)
// isEmbeddedMinimailEnabled = "_-2F1" (String#19604, DoABC#2)
// refreshScrollBarVisibility = "_-0E4" (String#1434, DoABC#2)
// initButton = "_-BZ" (String#7902, DoABC#2)
// onFollowButtonClick = "_-0BK" (String#3786, DoABC#2)
// conversations = "_-1Zf" (String#17877, DoABC#2)
// afterResize = "_-1fv" (String#18135, DoABC#2)
// _SafeStr_11722 = "_-2Bt" (String#19477, DoABC#2)
// _SafeStr_11723 = "_-00s" (String#14088, DoABC#2)
// _SafeStr_11724 = "_-2fo" (String#20685, DoABC#2)
// _SafeStr_11725 = "_-0Y6" (String#15361, DoABC#2)
// _SafeStr_11726 = "_-0J-" (String#14799, DoABC#2)
// _SafeStr_11727 = "_-54" (String#22422, DoABC#2)
// findAddIndex = "_-1DE" (String#16992, DoABC#2)
// refreshListDims = "_-2MQ" (String#6490, DoABC#2)
// refreshTextDims = "_-3AW" (String#21902, DoABC#2)
// getChatBgColor = "_-0ec" (String#15610, DoABC#2)
// getChatTextColor = "_-Pk" (String#23236, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IScrollbarWindow = "_-2fP" (String#1920, DoABC#2)
// IContainerButtonWindow = "_-0UF" (String#1484, DoABC#2)
// Message = "_-0r8" (String#4665, DoABC#2)
// Conversation = "_-Ej" (String#7965, DoABC#2)
// FollowFriendMessageComposer = "_-MN" (String#23099, DoABC#2)
// ConversationView = "_-2jb" (String#6947, DoABC#2)
// refreshEntry = "_-2v6" (String#308, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// _content = "_-1Q8" (String#74, DoABC#2)
// refreshList = "_-3Kn" (String#635, DoABC#2)
// scrollableRegion = "_-2ku" (String#6976, DoABC#2)
// messageText = "_-0EC" (String#14615, DoABC#2)
// _SafeStr_4666 = "_-1Un" (String#17696, DoABC#2)
// _SafeStr_4667 = "_-0T3" (String#15172, DoABC#2)
// _SafeStr_4668 = "_-F2" (String#22815, DoABC#2)
// _SafeStr_4669 = "_-372" (String#21770, DoABC#2)
// _SafeStr_4670 = "_-256" (String#19223, DoABC#2)
// _SafeStr_4671 = "_-28X" (String#19351, DoABC#2)
// closeConversation = "_-0gA" (String#15679, DoABC#2)
// findSelectedConversation = "_-0wy" (String#16309, DoABC#2)
// addMessage = "_-1Jl" (String#17266, DoABC#2)
// followingAllowed = "_-1-Z" (String#1598, DoABC#2)
// refreshHeader = "_-18C" (String#834, DoABC#2)
// EventLogMessageComposer = "_-2lH" (String#6984, DoABC#2)
// onCloseButtonClick = "_-39Y" (String#7505, DoABC#2)




package com.sulake.habbo.messenger
{
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.habbo.messenger.domain.Conversation;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.*;
    import com.sulake.core.window.events.*;
    import com.sulake.core.window.*;
    import com.sulake.habbo.messenger.domain.*;
    import com.sulake.habbo.window.enum.*;

    public class ConversationsTabView 
    {

        private var _messenger:HabboMessenger;
        private var _content:IWindowContainer;
        private var _SafeStr_11216:IWindowContainer;
        private var _SafeStr_11717:int = 30;

        public function ConversationsTabView(_arg_1:HabboMessenger, _arg_2:IFrameWindow)
        {
            this._messenger = _arg_1;
            this._content = IWindowContainer(_arg_2.findChildByName("content"));
            this._SafeStr_11216 = IWindowContainer(_arg_2.findChildByName("conversationstab"));
            var _local_3:IBitmapWrapperWindow = IBitmapWrapperWindow(this._content.findChildByName("convo_bg"));
            _local_3.bitmap = this._messenger.getButtonImage("convo_bg");
        }
        public function getTabCount():int
        {
            return (Math.floor((this._SafeStr_11216.width / this._SafeStr_11717)));
        }
        public function get content():IWindowContainer
        {
            return (this._content);
        }
        public function refresh():void
        {
            var _local_3:Boolean;
            var _local_1:Array = this._messenger.conversations.openConversations;
            var _local_2:int;
            while (_local_2 < this.getTabCount()) {
                this.refreshTabContent(_local_2, _local_1[(this._messenger.conversations.startIndex + _local_2)]);
                _local_2++;
            };
            while (true) {
                _local_3 = this.refreshTabContent(_local_2, null);
                if (_local_3) break;
                _local_2++;
            };
            if (this.hasPrevButton()){
                this.refreshAsArrow(0, false);
            };
            if (this.hasNextButton()){
                this.refreshAsArrow((this.getTabCount() - 1), true);
            };
        }
        private function refreshTabContent(_arg_1:int, _arg_2:Conversation):Boolean
        {
            var _local_3:IWindowContainer = (this._SafeStr_11216.getChildAt(_arg_1) as IWindowContainer);
            if (_local_3 == null){
                if (_arg_2 == null){
                    return (true);
                };
                _local_3 = IWindowContainer(this._messenger.getXmlWindow("tab_entry"));
                _local_3.y = 1;
                this._SafeStr_11216.addChild(_local_3);
            };
            this.hideChildren(_local_3);
            if (_arg_2 == null){
                return (false);
            };
            var _local_4:String = ((_arg_2.selected) ? "tab_bg_sel" : ((_arg_2.newMessageArrived) ? "tab_bg_hilite" : "tab_bg_unsel"));
            this.refreshTabBg(_local_3, _arg_1, _local_4);
            this.refreshFigure(_local_3, _arg_2.figure);
            _local_3.x = (_arg_1 * this._SafeStr_11717);
            _local_3.width = this._SafeStr_11717;
            return (false);
        }
        private function hideChildren(_arg_1:IWindowContainer):void
        {
            var _local_2:int;
            while (_local_2 < _arg_1.numChildren) {
                _arg_1.getChildAt(_local_2).visible = false;
                _local_2++;
            };
        }
        private function refreshAsArrow(_arg_1:int, _arg_2:Boolean):void
        {
            var _local_3:IWindowContainer = (this._SafeStr_11216.getChildAt(_arg_1) as IWindowContainer);
            this.hideChildren(_local_3);
            this.refreshArrow(_local_3, _arg_1, _arg_2);
            this.refreshTabBg(_local_3, _arg_1, ((_arg_2) ? "tab_bg_next" : "tab_bg_unsel"));
            var _local_4:int = (this._SafeStr_11216.width % this._SafeStr_11717);
            _local_3.width = (this._SafeStr_11717 + ((_arg_2) ? _local_4 : 0));
        }
        private function refreshTabBg(_arg_1:IWindowContainer, _arg_2:int, _arg_3:String):void
        {
            this._messenger.refreshButton(_arg_1, _arg_3, true, this.onTabClick, _arg_2);
        }
        private function refreshFigure(_arg_1:IWindowContainer, _arg_2:String):void
        {
            var _local_3:IBitmapWrapperWindow = (_arg_1.getChildByName(HabboMessenger._SafeStr_11259) as IBitmapWrapperWindow);
            if ((((_arg_2 == null)) || ((_arg_2 == "")))){
                _local_3.visible = false;
            }
            else {
                _local_3.bitmap = this._messenger.getAvatarFaceBitmap(_arg_2);
                _local_3.visible = true;
            };
        }
        private function refreshArrow(_arg_1:IWindowContainer, _arg_2:int, _arg_3:Boolean):void
        {
            this._messenger.refreshButton(_arg_1, ((_arg_3) ? "next" : "prev"), true, null, 0);
        }
        private function hasPrevButton():Boolean
        {
            return ((this._messenger.conversations.startIndex > 0));
        }
        private function hasNextButton():Boolean
        {
            return (((this._messenger.conversations.openConversations.length - this._messenger.conversations.startIndex) > this.getTabCount()));
        }
        private function onTabClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            var _local_4:Conversation;
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            var _local_3:int = _arg_2.id;
            if ((((_local_3 == 0)) && (this.hasPrevButton()))){
                this._messenger.conversations.changeStartIndex(-1);
            }
            else {
                if ((((_local_3 == (this.getTabCount() - 1))) && (this.hasNextButton()))){
                    this._messenger.conversations.changeStartIndex(1);
                }
                else {
                    _local_4 = (((_arg_2.name == HabboMessenger._SafeStr_11259)) ? this._messenger.conversations.findConversation(_arg_2.id) : this._messenger.conversations.openConversations[(_local_3 + this._messenger.conversations.startIndex)]);
                    if (_local_4 == null){
                        return;
                    };
                    this._messenger.conversations.setSelected(_local_4);
                };
            };
            this._messenger.messengerView.refresh();
        }

    }
}//package com.sulake.habbo.messenger

// _SafeStr_11216 = "_-f6" (String#8498, DoABC#2)
// refreshFigure = "_-1JQ" (String#846, DoABC#2)
// _SafeStr_11259 = "_-2en" (String#20637, DoABC#2)
// refreshTabContent = "_-0om" (String#4610, DoABC#2)
// onTabClick = "_-1kH" (String#1752, DoABC#2)
// refreshArrow = "_-2Jt" (String#6436, DoABC#2)
// conversations = "_-1Zf" (String#17877, DoABC#2)
// _SafeStr_11717 = "_-wH" (String#24543, DoABC#2)
// hasPrevButton = "_-1fn" (String#18128, DoABC#2)
// refreshAsArrow = "_-lt" (String#24105, DoABC#2)
// hasNextButton = "_-p-" (String#24235, DoABC#2)
// refreshTabBg = "_-2Dm" (String#19558, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// Conversation = "_-Ej" (String#7965, DoABC#2)
// ConversationsTabView = "_-2dm" (String#6829, DoABC#2)
// hideChildren = "_-14q" (String#1615, DoABC#2)
// refresh = "_-s9" (String#189, DoABC#2)
// _content = "_-o4" (String#96, DoABC#2)
// getTabCount = "_-FK" (String#7977, DoABC#2)
// changeStartIndex = "_-Mo" (String#23118, DoABC#2)
// findConversation = "_-2LL" (String#19861, DoABC#2)
// newMessageArrived = "_-0XG" (String#4255, DoABC#2)
// openConversations = "_-0FN" (String#14660, DoABC#2)
// startIndex = "_-1UD" (String#17675, DoABC#2)



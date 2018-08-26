
package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomModerationData;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.components.ICheckBoxWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetModeratorRoomInfoMessageComposer;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomData;
    import com.sulake.habbo.communication.messages.outgoing.moderator.GetRoomChatlogMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModeratorActionMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModerateRoomMessageComposer;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import flash.net.*;

    public class RoomToolCtrl implements IDisposable, TrackedWindow 
    {

        private var _help:ModerationManager;
        private var _flatId:int;
        private var _data:RoomModerationData;
        private var _frame:IFrameWindow;
        private var _content:IItemListWindow;
        private var _disposed:Boolean;
        private var _SafeStr_11822:IDropMenuWindow;
        private var _SafeStr_11823:ITextFieldWindow;
        private var _SafeStr_11824:Boolean = true;
        private var _SafeStr_11825:ICheckBoxWindow;
        private var _SafeStr_11826:ICheckBoxWindow;
        private var _SafeStr_11827:ICheckBoxWindow;

        public function RoomToolCtrl(_arg_1:ModerationManager, _arg_2:int)
        {
            this._help = _arg_1;
            this._flatId = _arg_2;
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
        public static function moveChildrenToColumn(_arg_1:IWindowContainer, _arg_2:int, _arg_3:int):void
        {
            var _local_5:IWindow;
            var _local_4:int;
            while (_local_4 < _arg_1.numChildren) {
                _local_5 = _arg_1.getChildAt(_local_4);
                if (((((!((_local_5 == null))) && (_local_5.visible))) && ((_local_5.height > 0)))){
                    _local_5.y = _arg_2;
                    _arg_2 = (_arg_2 + (_local_5.height + _arg_3));
                };
                _local_4++;
            };
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function show():void
        {
            this._frame = IFrameWindow(this._help.getXmlWindow("roomtool_frame"));
            this._help.messageHandler.addRoomInfoListener(this);
            this._help.connection.send(new GetModeratorRoomInfoMessageComposer(this._flatId));
            Logger.log(("BEGINNING TO SHOW: " + this._flatId));
        }
        public function getType():int
        {
            return (WindowTracker._SafeStr_11797);
        }
        public function getId():String
        {
            return (("" + this._flatId));
        }
        public function getFrame():IFrameWindow
        {
            return (this._frame);
        }
        private function PollOfferDialog(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this.dispose();
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            this._help.messageHandler.removeRoomEnterListener(this);
            if (this._frame != null){
                this._frame.destroy();
                this._frame = null;
            };
            if (this._data != null){
                this._data.dispose();
                this._data = null;
            };
            this._help = null;
            this._content = null;
            this._SafeStr_11822 = null;
            this._SafeStr_11823 = null;
            this._SafeStr_11825 = null;
            this._SafeStr_11826 = null;
            this._SafeStr_11827 = null;
        }
        public function RoomToolCtrl():void
        {
            this.RoomToolCtrl("send_caution_but");
            this.RoomToolCtrl("send_message_but");
        }
        private function RoomToolCtrl(_arg_1:String):void
        {
            var _local_2:Boolean = ((!((this._data == null))) && ((this._data.flatId == this._help.currentFlatId)));
            var _local_3:IButtonWindow = IButtonWindow(this._frame.findChildByName(_arg_1));
            if (((_local_2) && (this._help.initMsg.roomAlertPermission))){
                _local_3.enable();
            }
            else {
                _local_3.disable();
            };
        }
        public function IncomingMessages(_arg_1:RoomModerationData):void
        {
            Logger.log(((("GOT ROOM INFO: " + _arg_1.flatId) + ", ") + this._flatId));
            if (_arg_1.flatId != this._flatId){
                Logger.log(((("NOT THE SAME FLAT: " + _arg_1.flatId) + ", ") + this._flatId));
                return;
            };
            this._data = _arg_1;
            this.populate();
            this._help.messageHandler.removeRoomInfoListener(this);
            this._frame.visible = true;
            this._help.messageHandler.addRoomEnterListener(this);
            Logger.log(((("TURNED VISIBLE: " + this._frame.rectangle) + ", ") + this._frame.visible));
        }
        public function populate():void
        {
            this._content = IItemListWindow(this._frame.findChildByName("list_cont"));
            var _local_1:IWindow = this._frame.findChildByTag("close");
            _local_1.procedure = this.PollOfferDialog;
            this._SafeStr_11823 = ITextFieldWindow(this._frame.findChildByName("message_input"));
            this._SafeStr_11823.procedure = this.onInputClick;
            this._SafeStr_11822 = IDropMenuWindow(this._frame.findChildByName("msgTemplatesSelect"));
            this.prepareMsgSelect(this._SafeStr_11822);
            this._SafeStr_11822.procedure = this.onSelectTemplate;
            this._SafeStr_11825 = ICheckBoxWindow(this._frame.findChildByName("kick_check"));
            this._SafeStr_11826 = ICheckBoxWindow(this._frame.findChildByName("lock_check"));
            this._SafeStr_11827 = ICheckBoxWindow(this._frame.findChildByName("changename_check"));
            this.RoomToolCtrl(this._data.room, "room_cont");
            this.RoomToolCtrl(this._data.event, "event_cont");
            this.UserInfoCtrl("owner_name_txt", this._data.ownerName);
            this.UserInfoCtrl("owner_in_room_txt", ((this._data.ownerInRoom) ? "Yes" : "No"));
            this.UserInfoCtrl("user_count_txt", ("" + this._data.userCount));
            this.UserInfoCtrl("has_event_txt", ((this._data.event.exists) ? "Yes" : "No"));
            this._frame.findChildByName("enter_room_but").procedure = this.RoomToolCtrl;
            this._frame.findChildByName("chatlog_but").procedure = this.ChatlogCtrl;
            this._frame.findChildByName("edit_in_hk_but").procedure = this.RoomToolCtrl;
            this._frame.findChildByName("send_caution_but").procedure = this.RoomToolCtrl;
            this._frame.findChildByName("send_message_but").procedure = this.RoomToolCtrl;
            this._help.disableButton(this._help.initMsg.chatlogsPermission, this._frame, "chatlog_but");
            if (!this._help.initMsg.roomKickPermission){
                this._SafeStr_11825.disable();
            };
            this._frame.findChildByName("owner_name_txt").procedure = this.onOwnerName;
            this.RoomToolCtrl();
        }
        private function RoomToolCtrl(_arg_1:IItemListWindow, _arg_2:IWindow):void
        {
            var _local_3:IWindow = _arg_1.removeListItem(_arg_2);
            if (_local_3 != null){
                _local_3.dispose();
            };
        }
        private function RoomToolCtrl(_arg_1:RoomData, _arg_2:String):void
        {
            var _local_3:IWindowContainer = IWindowContainer(this._content.getListItemByName(_arg_2));
            var _local_4:IWindowContainer = IWindowContainer(_local_3.findChildByName("room_data"));
            if (_local_4 == null){
                _local_4 = IWindowContainer(this._help.getXmlWindow("roomtool_roomdata"));
                _local_3.addChild(_local_4);
            };
            if (!_arg_1.exists){
                this.RoomToolCtrl(this._content, _local_3);
                this.RoomToolCtrl(this._content, this._content.getListItemByName("event_spacing"));
                return;
            };
            var _local_5:ITextWindow = ITextWindow(_local_4.findChildByName("name"));
            _local_5.text = _arg_1.name;
            _local_5.height = (_local_5.textHeight + 5);
            var _local_6:ITextWindow = ITextWindow(_local_4.findChildByName("desc"));
            _local_6.text = _arg_1.desc;
            _local_6.height = (_local_6.textHeight + 5);
            var _local_7:IWindowContainer = IWindowContainer(_local_4.findChildByName("tags_cont"));
            var _local_8:ITextWindow = ITextWindow(_local_7.findChildByName("tags_txt"));
            _local_8.text = this.RoomToolCtrl(_arg_1.tags);
            _local_8.height = (_local_8.textHeight + 5);
            _local_7.height = _local_8.height;
            if (_arg_1.tags.length < 1){
                _local_4.removeChild(_local_7);
            };
            moveChildrenToColumn(_local_4, _local_5.y, 0);
            _local_4.height = getLowestPoint(_local_4);
            _local_3.height = (_local_4.height + (2 * _local_4.y));
            Logger.log(((((((((((("XXXX: " + _local_3.height) + ", ") + _local_4.height) + ", ") + _local_5.height) + ", ") + _local_6.height) + ", ") + _local_7.height) + ", ") + _local_8.height));
        }
        private function RoomToolCtrl(_arg_1:Array):String
        {
            var _local_3:String;
            var _local_2:String = "";
            for each (_local_3 in _arg_1) {
                if (_local_2 == ""){
                    _local_2 = _local_3;
                }
                else {
                    _local_2 = ((_local_2 + ", ") + _local_3);
                };
            };
            return (_local_2);
        }
        private function UserInfoCtrl(_arg_1:String, _arg_2:String):void
        {
            var _local_3:ITextWindow = ITextWindow(this._frame.findChildByName(_arg_1));
            _local_3.text = _arg_2;
        }
        private function onOwnerName(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._help.windowTracker.show(new UserInfoFrameCtrl(this._help, this._data.ownerId), this._frame, false, false, true);
        }
        private function RoomToolCtrl(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("Enter room clicked");
            this._help.goToRoom(this._data.flatId);
        }
        private function ChatlogCtrl(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this._help.windowTracker.show(new ChatlogCtrl(new GetRoomChatlogMessageComposer(0, this._data.flatId), this._help, WindowTracker._SafeStr_11755, this._data.flatId), this._frame, false, false, true);
        }
        private function RoomToolCtrl(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("Edit in hk clicked");
            this._help.openHkPage("roomadmin.url", ("" + this._data.flatId));
        }
        private function RoomToolCtrl(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("Sending caution...");
            this.RoomToolCtrl(true);
        }
        private function RoomToolCtrl(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("Sending message...");
            this.RoomToolCtrl(false);
        }
        private function RoomToolCtrl(_arg_1:Boolean):void
        {
            if (((this._SafeStr_11824) || ((this._SafeStr_11823.text == "")))){
                this._help.windowManager.alert("Alert", "You must input a message to the user", 0, this.SessionDataManager);
                return;
            };
            var _local_2:int = this.RoomToolCtrl(_arg_1, this._SafeStr_11825.isSelected);
            this._help.connection.send(new ModeratorActionMessageComposer(ModeratorActionMessageComposer._SafeStr_7595, _local_2, this._SafeStr_11823.text, "", ""));
            if (((((this._SafeStr_11826.isSelected) || (this._SafeStr_11827.isSelected))) || (this._SafeStr_11825.isSelected))){
                this._help.connection.send(new ModerateRoomMessageComposer(this._data.flatId, this._SafeStr_11826.isSelected, this._SafeStr_11827.isSelected, this._SafeStr_11825.isSelected));
            };
            this.dispose();
        }
        private function RoomToolCtrl(_arg_1:Boolean, _arg_2:Boolean):int
        {
            if (_arg_2){
                return (((_arg_1) ? ModeratorActionMessageComposer._SafeStr_7597 : ModeratorActionMessageComposer._SafeStr_7600));
            };
            return (((_arg_1) ? ModeratorActionMessageComposer._SafeStr_7596 : ModeratorActionMessageComposer._SafeStr_7599));
        }
        private function onInputClick(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowEvent.WE_FOCUSED){
                return;
            };
            if (!this._SafeStr_11824){
                return;
            };
            this._SafeStr_11823.text = "";
            this._SafeStr_11824 = false;
        }
        private function SessionDataManager(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }
        private function prepareMsgSelect(_arg_1:IDropMenuWindow):void
        {
            Logger.log(("MSG TEMPLATES: " + this._help.initMsg.roomMessageTemplates.length));
            _arg_1.populate(this._help.initMsg.roomMessageTemplates);
        }
        private function onSelectTemplate(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowEvent.WE_SELECTED){
                return;
            };
            var _local_3:String = this._help.initMsg.roomMessageTemplates[this._SafeStr_11822.selection];
            if (_local_3 != null){
                this._SafeStr_11824 = false;
                this._SafeStr_11823.text = _local_3;
            };
        }

    }
}//package com.sulake.habbo.moderation

// _help = "_-3HG" (String#114, DoABC#2)
// SessionDataManager = "_-34G" (String#309, DoABC#2)
// disableButton = "_-24c" (String#19207, DoABC#2)
// initMsg = "_-MD" (String#23092, DoABC#2)
// windowTracker = "_-1CG" (String#16953, DoABC#2)
// _SafeStr_11755 = "_-12Z" (String#16561, DoABC#2)
// IncomingMessages = "_-az" (String#2136, DoABC#2)
// ChatlogCtrl = "_-Ps" (String#2103, DoABC#2)
// currentFlatId = "_-2HL" (String#19698, DoABC#2)
// RoomToolCtrl = "_-2JA" (String#19774, DoABC#2)
// addRoomInfoListener = "_-33D" (String#21629, DoABC#2)
// removeRoomInfoListener = "_-hl" (String#23956, DoABC#2)
// addRoomEnterListener = "_-d0" (String#23757, DoABC#2)
// removeRoomEnterListener = "_-8C" (String#22549, DoABC#2)
// _SafeStr_11797 = "_-du" (String#23797, DoABC#2)
// messageHandler = "_-2T6" (String#20168, DoABC#2)
// _SafeStr_11822 = "_-0wD" (String#4774, DoABC#2)
// _SafeStr_11823 = "_-2AA" (String#1824, DoABC#2)
// _SafeStr_11824 = "_-0s6" (String#824, DoABC#2)
// _SafeStr_11825 = "_-1Vi" (String#17729, DoABC#2)
// _SafeStr_11826 = "_-G" (String#22852, DoABC#2)
// _SafeStr_11827 = "_-1p0" (String#18502, DoABC#2)
// RoomToolCtrl = "_-LE" (String#23055, DoABC#2)
// onInputClick = "_-2zA" (String#907, DoABC#2)
// prepareMsgSelect = "_-31U" (String#7335, DoABC#2)
// onSelectTemplate = "_-1ke" (String#5762, DoABC#2)
// RoomToolCtrl = "_-I2" (String#22931, DoABC#2)
// UserInfoCtrl = "_-0zx" (String#4847, DoABC#2)
// RoomToolCtrl = "_-2Y7" (String#20359, DoABC#2)
// RoomToolCtrl = "_-Sb" (String#23350, DoABC#2)
// RoomToolCtrl = "_-GJ" (String#22865, DoABC#2)
// RoomToolCtrl = "_-1A0" (String#16858, DoABC#2)
// onOwnerName = "_-tN" (String#8757, DoABC#2)
// RoomToolCtrl = "_-2dN" (String#20579, DoABC#2)
// RoomToolCtrl = "_-HG" (String#22901, DoABC#2)
// openHkPage = "_-mj" (String#24138, DoABC#2)
// RoomToolCtrl = "_-eb" (String#23827, DoABC#2)
// RoomToolCtrl = "_-3CZ" (String#21978, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// ICheckBoxWindow = "_-1zu" (String#1793, DoABC#2)
// IDropMenuWindow = "_-4Z" (String#2049, DoABC#2)
// WindowTracker = "_-2m9" (String#7008, DoABC#2)
// GetRoomChatlogMessageComposer = "_-2AI" (String#19416, DoABC#2)
// ModerateRoomMessageComposer = "_-2Mn" (String#19918, DoABC#2)
// ModeratorActionMessageComposer = "_-B-" (String#22655, DoABC#2)
// GetModeratorRoomInfoMessageComposer = "_-1cn" (String#18002, DoABC#2)
// TrackedWindow = "_-Xp" (String#8365, DoABC#2)
// UserInfoFrameCtrl = "_-1D1" (String#5125, DoABC#2)
// ChatlogCtrl = "_-2GT" (String#6377, DoABC#2)
// RoomToolCtrl = "_-0Tu" (String#4178, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// RoomModerationData = "_-1Zn" (String#5559, DoABC#2)
// userCount = "_-3Ez" (String#22075, DoABC#2)
// flatId = "_-3CK" (String#21973, DoABC#2)
// goToRoom = "_-2Jw" (String#6438, DoABC#2)
// _content = "_-1Q8" (String#74, DoABC#2)
// ownerName = "_-1e1" (String#1730, DoABC#2)
// getLowestPoint = "_-0t0" (String#16161, DoABC#2)
// WE_SELECTED = "_-17F" (String#16745, DoABC#2)
// moveChildrenToColumn = "_-fI" (String#23859, DoABC#2)
// getFrame = "_-3Jk" (String#923, DoABC#2)
// PollOfferDialog = "_-2Ts" (String#54, DoABC#2)
// _flatId = "_-2Al" (String#135, DoABC#2)
// WE_FOCUSED = "_-1ay" (String#17932, DoABC#2)
// ownerId = "_-0Kl" (String#3968, DoABC#2)
// ownerInRoom = "_-1QU" (String#17531, DoABC#2)
// exists = "_-23h" (String#19163, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// roomMessageTemplates = "_-yF" (String#24624, DoABC#2)
// chatlogsPermission = "_-Cg" (String#22712, DoABC#2)
// roomAlertPermission = "_-2DT" (String#19546, DoABC#2)
// roomKickPermission = "_-0tA" (String#16166, DoABC#2)
// _SafeStr_7595 = "_-0tI" (String#16171, DoABC#2)
// _SafeStr_7596 = "_-29x" (String#19403, DoABC#2)
// _SafeStr_7597 = "_-0JQ" (String#14819, DoABC#2)
// _SafeStr_7599 = "_-2Fo" (String#19635, DoABC#2)
// _SafeStr_7600 = "_-Y4" (String#23565, DoABC#2)



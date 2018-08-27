
package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.IWindowContainer;
    import flash.utils.Dictionary;
    import flash.utils.Timer;
    import com.sulake.core.utils.Map;
    import flash.events.TimerEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.communication.messages.incoming.moderation.RoomChatlogData;
    import com.sulake.habbo.communication.messages.incoming.moderation.ChatlineData;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class ChatlogCtrl implements IDisposable, TrackedWindow 
    {

        private static var _SafeStr_11801:Array = [];
        private static var _SafeStr_11802:int = 1000;
        private static var _SafeStr_11803:Array = [];
        private static var _SafeStr_11804:int = 200;

        private var _type:int;
        private var _id:int;
        private var _msg:IMessageComposer;
        private var _help:ModerationManager;
        private var _frame:IFrameWindow;
        private var _content:IItemListWindow;
        private var _rooms:Array;
        private var _disposed:Boolean;
        private var _SafeStr_11805:IWindowContainer;
        private var _SafeStr_11806:IWindowContainer;
        private var _SafeStr_11807:Dictionary;
        private var _SafeStr_4247:Timer;
        private var _SafeStr_11808:Map;
        private var _SafeStr_11809:Array;
        private var _SafeStr_11810:Array;

        public function ChatlogCtrl(_arg_1:IMessageComposer, _arg_2:ModerationManager, _arg_3:int, _arg_4:int)
        {
            this._SafeStr_11809 = [];
            this._SafeStr_11810 = [];
            super();
            this._help = _arg_2;
            this._type = _arg_3;
            this._id = _arg_4;
            this._msg = _arg_1;
            this._SafeStr_11808 = new Map();
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function show():void
        {
            this._SafeStr_11805 = IWindowContainer(this._help.getXmlWindow("chatlog_roomheader"));
            this._SafeStr_11806 = IWindowContainer(this._help.getXmlWindow("chatlog_chatline"));
            this._SafeStr_4247 = new Timer(1000, 1);
            this._SafeStr_4247.addEventListener(TimerEvent.TIMER, this.onResizeTimer);
            this._frame = IFrameWindow(this._help.getXmlWindow("chatlog_frame"));
            this._content = IItemListWindow(this._frame.findChildByName("chatline_list"));
            this._frame.procedure = this.onWindow;
            var _local_1:IWindow = this._frame.findChildByTag("close");
            _local_1.procedure = this.onClose;
            this._help.connection.send(this._msg);
            this._help.messageHandler.addChatlogListener(this);
        }
        public function onChatlog(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:Array, _arg_5:Dictionary):void
        {
            if (((((!((_arg_2 == this._type))) || (!((_arg_3 == this._id))))) || (this._disposed))){
                return;
            };
            this._help.messageHandler.removeChatlogListener(this);
            this._frame.caption = _arg_1;
            this._rooms = _arg_4;
            this._SafeStr_11807 = _arg_5;
            this.populate();
            this.onResizeTimer(null);
            this._frame.visible = true;
        }
        public function getType():int
        {
            return (this._type);
        }
        public function getId():String
        {
            return (("" + this._id));
        }
        public function getFrame():IFrameWindow
        {
            return (this._frame);
        }
        private function populate():void
        {
            var _local_1:RoomChatlogData;
            this._content.autoArrangeItems = false;
            for each (_local_1 in this._rooms) {
                this.populateRoomChat(_local_1);
            };
            this._content.autoArrangeItems = true;
        }
        private function populateRoomChat(_arg_1:RoomChatlogData):void
        {
            var _local_5:ChatlineData;
            var _local_2:IWindowContainer = this.getChatHeaderWindow();
            var _local_3:ITextWindow = ITextWindow(_local_2.findChildByName("room_name_txt"));
            if (_arg_1.roomId > 0){
                _local_3.caption = _arg_1.roomName;
                _local_3.underline = true;
                new OpenRoomTool(this._frame, this._help, _local_3, _arg_1.isPublic, _arg_1.roomId);
            }
            else {
                _local_3.caption = "Not in room";
                _local_3.underline = false;
            };
            this.addHeaderLineToList(_local_2, this._content);
            var _local_4:Boolean = true;
            for each (_local_5 in _arg_1.chatlog) {
                this.populateChatline(this._content, _local_5, _local_4);
                _local_4 = !(_local_4);
            };
        }
        private function addChatLineToList(_arg_1:IWindowContainer, _arg_2:IItemListWindow):void
        {
            _arg_2.addListItem(_arg_1);
            this._SafeStr_11809.push(_arg_1);
        }
        private function addHeaderLineToList(_arg_1:IWindowContainer, _arg_2:IItemListWindow):void
        {
            _arg_2.addListItem(_arg_1);
            this._SafeStr_11810.push(_arg_1);
        }
        private function getChatLineWindow():IWindowContainer
        {
            if (_SafeStr_11801.length > 0){
                return ((_SafeStr_11801.pop() as IWindowContainer));
            };
            return (IWindowContainer(this._SafeStr_11806.clone()));
        }
        private function storeChatLineWindow(_arg_1:IWindowContainer):void
        {
            var _local_2:ITextWindow;
            if (_SafeStr_11801.length < _SafeStr_11802){
                _local_2 = ITextWindow(_arg_1.findChildByName("chatter_txt"));
                _local_2.removeEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onChatLogUserClick);
                _arg_1.width = this._SafeStr_11806.width;
                _arg_1.height = this._SafeStr_11806.height;
                _SafeStr_11801.push(_arg_1);
            }
            else {
                _arg_1.dispose();
            };
        }
        private function getChatHeaderWindow():IWindowContainer
        {
            if (_SafeStr_11803.length > 0){
                return ((_SafeStr_11803.pop() as IWindowContainer));
            };
            return (IWindowContainer(this._SafeStr_11805.clone()));
        }
        private function storeChatHeaderWindow(_arg_1:IWindowContainer):void
        {
            var _local_2:ITextWindow;
            if (_SafeStr_11803.length < _SafeStr_11804){
                _local_2 = ITextWindow(_arg_1.findChildByName("room_name_txt"));
                _local_2.procedure = null;
                _arg_1.width = this._SafeStr_11805.width;
                _arg_1.height = this._SafeStr_11805.height;
                _SafeStr_11803.push(_arg_1);
            }
            else {
                _arg_1.dispose();
            };
        }
        private function populateChatline(_arg_1:IItemListWindow, _arg_2:ChatlineData, _arg_3:Boolean):void
        {
            var _local_4:IWindowContainer = this.getChatLineWindow();
            _local_4.color = (((this._SafeStr_11807[_arg_2.chatterId])!=null) ? ((_arg_3) ? 4294623571 : 0xFFFFE240) : ((_arg_3) ? 4288861930 : 0xFFFFFFFF));
            var _local_5:ITextWindow = ITextWindow(_local_4.findChildByName("time_txt"));
            _local_5.text = RoomVisitsCtrl.getFormattedTime(_arg_2.hour, _arg_2.minute);
            var _local_6:ITextWindow = ITextWindow(_local_4.findChildByName("chatter_txt"));
            _local_6.color = _local_4.color;
            if (_arg_2.chatterId > 0){
                _local_6.text = _arg_2.chatterName;
                _local_6.underline = true;
                _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onChatLogUserClick);
                if (!this._SafeStr_11808.getValue(_arg_2.chatterName)){
                    this._SafeStr_11808.add(_arg_2.chatterName, _arg_2.chatterId);
                };
            }
            else {
                if (_arg_2.chatterId == 0){
                    _local_6.text = "Bot / pet";
                    _local_6.underline = false;
                }
                else {
                    _local_6.text = "-";
                    _local_6.underline = false;
                };
            };
            var _local_7:ITextWindow = ITextWindow(_local_4.findChildByName("msg_txt"));
            _local_7.text = _arg_2.msg;
            _local_7.height = (_local_7.textHeight + 5);
            _local_4.height = _local_7.height;
            this.addChatLineToList(_local_4, _arg_1);
        }
        private function onChatLogUserClick(_arg_1:WindowMouseEvent):void
        {
            var _local_2:String = _arg_1.target.caption;
            var _local_3:int = this._SafeStr_11808.getValue(_local_2);
            this._help.windowTracker.show(new UserInfoFrameCtrl(this._help, _local_3), this._frame, false, false, true);
        }
        private function onClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this.dispose();
        }
        private function onWindow(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (((!((_arg_1.type == WindowEvent.WE_RESIZED))) || (!((_arg_2 == this._frame))))){
                return;
            };
            this._SafeStr_4247.reset();
            this._SafeStr_4247.start();
        }
        private function onResizeTimer(_arg_1:TimerEvent):void
        {
            this.refreshListDims();
            var _local_2:Boolean = this.refreshScrollBarVisibility();
        }
        private function refreshListDims():void
        {
            var _local_1:IWindowContainer;
            var _local_2:ITextWindow;
            this._content.autoArrangeItems = false;
            var _local_3:int = this._content.numListItems;
            var _local_4:int;
            while (_local_4 < _local_3) {
                _local_1 = IWindowContainer(this._content.getListItemAt(_local_4));
                if (_local_1.name == "chatline"){
                    _local_2 = ITextWindow(_local_1.findChildByName("msg_txt"));
                    _local_2.width = (_local_1.width - _local_2.x);
                    _local_2.height = (_local_2.textHeight + 5);
                    _local_1.height = _local_2.height;
                };
                _local_4++;
            };
            this._content.autoArrangeItems = true;
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
        public function dispose():void
        {
            var _local_1:IWindowContainer;
            if (this._disposed){
                return;
            };
            this._disposed = true;
            this._help = null;
            this._msg = null;
            if (this._content != null){
                this._content.removeListItems();
                this._content.dispose();
                this._content = null;
            };
            if (this._frame != null){
                this._frame.destroy();
                this._frame = null;
            };
            this._rooms = null;
            this._SafeStr_11807 = null;
            if (this._SafeStr_4247 != null){
                this._SafeStr_4247.stop();
                this._SafeStr_4247.removeEventListener(TimerEvent.TIMER, this.onResizeTimer);
                this._SafeStr_4247 = null;
            };
            for each (_local_1 in this._SafeStr_11809) {
                this.storeChatLineWindow(_local_1);
            };
            for each (_local_1 in this._SafeStr_11810) {
                this.storeChatHeaderWindow(_local_1);
            };
            this._SafeStr_11809 = [];
            this._SafeStr_11810 = [];
            if (this._SafeStr_11805 != null){
                this._SafeStr_11805.dispose();
                this._SafeStr_11805 = null;
            };
            if (this._SafeStr_11806 != null){
                this._SafeStr_11806.dispose();
                this._SafeStr_11806 = null;
            };
        }

    }
}//package com.sulake.habbo.moderation

// onWindow = "_-1zg" (String#873, DoABC#2)
// refreshScrollBarVisibility = "_-0E4" (String#1434, DoABC#2)
// _help = "_-3HG" (String#114, DoABC#2)
// refreshListDims = "_-2MQ" (String#6490, DoABC#2)
// windowTracker = "_-1CG" (String#16953, DoABC#2)
// onChatlog = "_-Ps" (String#2103, DoABC#2)
// addChatlogListener = "_-2oH" (String#21014, DoABC#2)
// removeChatlogListener = "_-1MZ" (String#17381, DoABC#2)
// _SafeStr_11801 = "_-0gK" (String#15687, DoABC#2)
// _SafeStr_11802 = "_-NL" (String#23137, DoABC#2)
// _SafeStr_11803 = "_-0K0" (String#14843, DoABC#2)
// _SafeStr_11804 = "_-0r0" (String#16085, DoABC#2)
// _SafeStr_11805 = "_-2As" (String#19437, DoABC#2)
// _SafeStr_11806 = "_-2Vj" (String#20269, DoABC#2)
// _SafeStr_11807 = "_-3Cb" (String#21979, DoABC#2)
// _SafeStr_11808 = "_-2OG" (String#19976, DoABC#2)
// _SafeStr_11809 = "_-0LL" (String#14889, DoABC#2)
// _SafeStr_11810 = "_-4Q" (String#22394, DoABC#2)
// messageHandler = "_-2T6" (String#20168, DoABC#2)
// populateRoomChat = "_-2hC" (String#20736, DoABC#2)
// getChatHeaderWindow = "_-0vg" (String#16263, DoABC#2)
// addHeaderLineToList = "_-3C3" (String#21962, DoABC#2)
// populateChatline = "_-0kI" (String#15842, DoABC#2)
// addChatLineToList = "_-rQ" (String#24335, DoABC#2)
// getChatLineWindow = "_-Nr" (String#23158, DoABC#2)
// storeChatLineWindow = "_-Ha" (String#22916, DoABC#2)
// onChatLogUserClick = "_-1x6" (String#18852, DoABC#2)
// storeChatHeaderWindow = "_-00z" (String#14093, DoABC#2)
// getFormattedTime = "_-1qM" (String#18557, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// TrackedWindow = "_-Xp" (String#8365, DoABC#2)
// UserInfoFrameCtrl = "_-1D1" (String#5125, DoABC#2)
// ChatlogCtrl = "_-2GT" (String#6377, DoABC#2)
// RoomVisitsCtrl = "_-2rD" (String#7106, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// RoomChatlogData = "_-2h1" (String#6893, DoABC#2)
// ChatlineData = "_-0ap" (String#4320, DoABC#2)
// OpenRoomTool = "_-2Kg" (String#6457, DoABC#2)
// _content = "_-1Q8" (String#74, DoABC#2)
// _SafeStr_4247 = "_-0RI" (String#586, DoABC#2)
// WE_RESIZED = "_-76" (String#22505, DoABC#2)
// scrollableRegion = "_-2ku" (String#6976, DoABC#2)
// getFrame = "_-3Jk" (String#923, DoABC#2)
// _msg = "_-Zx" (String#937, DoABC#2)
// onClose = "_-2Ts" (String#54, DoABC#2)
// removeListItems = "_-aG" (String#8425, DoABC#2)
// chatlog = "_-26z" (String#19292, DoABC#2)
// isPublic = "_-2lD" (String#20891, DoABC#2)
// hour = "_-20F" (String#19022, DoABC#2)
// minute = "_-4w" (String#22416, DoABC#2)
// chatterId = "_-VR" (String#23469, DoABC#2)
// chatterName = "_-2MC" (String#19893, DoABC#2)
// msg = "_-1Bo" (String#16933, DoABC#2)
// _rooms = "_-36o" (String#456, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)



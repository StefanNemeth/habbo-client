
package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IDropMenuWindow;
    import com.sulake.core.window.components.ITextFieldWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.communication.messages.outgoing.moderator.ModMessageMessageComposer;
    import com.sulake.habbo.window.utils.IAlertDialog;

    public class SendMsgsCtrl implements IDisposable, TrackedWindow 
    {

        private var _help:ModerationManager;
        private var _SafeStr_11909:int;
        private var _id:String;
        private var _SafeStr_11848:String;
        private var _frame:IFrameWindow;
        private var _SafeStr_11822:IDropMenuWindow;
        private var _SafeStr_11823:ITextFieldWindow;
        private var _disposed:Boolean;
        private var _SafeStr_11824:Boolean = true;

        public function SendMsgsCtrl(_arg_1:ModerationManager, _arg_2:int, _arg_3:String, _arg_4:String)
        {
            this._help = _arg_1;
            this._SafeStr_11909 = _arg_2;
            this._id = _arg_3;
            this._SafeStr_11848 = _arg_4;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function show():void
        {
            this._frame = IFrameWindow(this._help.getXmlWindow("send_msgs"));
            this._frame.caption = ("Msg To: " + this._id);
            this._frame.findChildByName("send_message_but").procedure = this.onSendMessageButton;
            this._SafeStr_11823 = ITextFieldWindow(this._frame.findChildByName("message_input"));
            this._SafeStr_11823.procedure = this.onInputClick;
            this._SafeStr_11822 = IDropMenuWindow(this._frame.findChildByName("msgTemplatesSelect"));
            this.prepareMsgSelect(this._SafeStr_11822);
            this._SafeStr_11822.procedure = this.onSelectTemplate;
            var _local_1:IWindow = this._frame.findChildByTag("close");
            _local_1.procedure = this.onClose;
            this._frame.visible = true;
        }
        public function getType():int
        {
            return (WindowTracker._SafeStr_11794);
        }
        public function getId():String
        {
            return (this._id);
        }
        public function getFrame():IFrameWindow
        {
            return (this._frame);
        }
        private function prepareMsgSelect(_arg_1:IDropMenuWindow):void
        {
            Logger.log(("MSG TEMPLATES: " + this._help.initMsg.messageTemplates.length));
            _arg_1.populate(this._help.initMsg.messageTemplates);
        }
        private function onSelectTemplate(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowEvent.WE_SELECTED){
                return;
            };
            var _local_3:String = this._help.initMsg.messageTemplates[this._SafeStr_11822.selection];
            if (_local_3 != null){
                this._SafeStr_11824 = false;
                this._SafeStr_11823.text = _local_3;
            };
        }
        private function onSendMessageButton(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            Logger.log("Sending message...");
            if (((this._SafeStr_11824) || ((this._SafeStr_11823.text == "")))){
                this._help.windowManager.alert("Alert", "You must input a message to the user", 0, this.onAlertClose);
                return;
            };
            this._help.connection.send(new ModMessageMessageComposer(this._SafeStr_11909, this._SafeStr_11823.text, this._SafeStr_11848));
            this.dispose();
        }
        private function onClose(_arg_1:WindowEvent, _arg_2:IWindow):void
        {
            if (_arg_1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK){
                return;
            };
            this.dispose();
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
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            if (this._frame != null){
                this._frame.destroy();
                this._frame = null;
            };
            this._SafeStr_11822 = null;
            this._SafeStr_11823 = null;
            this._help = null;
        }
        private function onAlertClose(_arg_1:IAlertDialog, _arg_2:WindowEvent):void
        {
            _arg_1.dispose();
        }

    }
}//package com.sulake.habbo.moderation

// _help = "_-3HG" (String#114, DoABC#2)
// onAlertClose = "_-34G" (String#309, DoABC#2)
// initMsg = "_-MD" (String#23092, DoABC#2)
// _SafeStr_11794 = "_-2pl" (String#21071, DoABC#2)
// _SafeStr_11822 = "_-0wD" (String#4774, DoABC#2)
// _SafeStr_11823 = "_-2AA" (String#1824, DoABC#2)
// _SafeStr_11824 = "_-0s6" (String#824, DoABC#2)
// onInputClick = "_-2zA" (String#907, DoABC#2)
// prepareMsgSelect = "_-31U" (String#7335, DoABC#2)
// onSelectTemplate = "_-1ke" (String#5762, DoABC#2)
// _SafeStr_11848 = "_-2-7" (String#1795, DoABC#2)
// _SafeStr_11909 = "_-1OJ" (String#5319, DoABC#2)
// _id = "_-US" (String#8292, DoABC#2)
// onSendMessageButton = "_-2FK" (String#19617, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// ITextFieldWindow = "_-3EL" (String#2027, DoABC#2)
// IDropMenuWindow = "_-4Z" (String#2049, DoABC#2)
// WindowTracker = "_-2m9" (String#7008, DoABC#2)
// ModMessageMessageComposer = "_-2Sk" (String#20148, DoABC#2)
// TrackedWindow = "_-Xp" (String#8365, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// SendMsgsCtrl = "_-Ls" (String#8122, DoABC#2)
// WE_SELECTED = "_-17F" (String#16745, DoABC#2)
// getFrame = "_-3Jk" (String#923, DoABC#2)
// onClose = "_-2Ts" (String#54, DoABC#2)
// WE_FOCUSED = "_-1ay" (String#17932, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)
// messageTemplates = "_-oF" (String#24201, DoABC#2)



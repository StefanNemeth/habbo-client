
package com.sulake.habbo.moderation
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class UserInfoFrameCtrl implements IDisposable, TrackedWindow 
    {

        private var _help:ModerationManager;
        private var _userId:int;
        private var _frame:IFrameWindow;
        private var _disposed:Boolean;
        private var _SafeStr_11800:UserInfoCtrl;

        public function UserInfoFrameCtrl(_arg_1:ModerationManager, _arg_2:int)
        {
            this._help = _arg_1;
            this._userId = _arg_2;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function show():void
        {
            this._frame = IFrameWindow(this._help.getXmlWindow("user_info_frame"));
            this._frame.caption = "User Info";
            var _local_1:IWindow = this._frame.findChildByTag("close");
            _local_1.procedure = this.PollOfferDialog;
            this._SafeStr_11800 = new UserInfoCtrl(this._frame, this._help, "", true);
            this._SafeStr_11800.load(this._frame.content, this._userId);
            this._frame.visible = true;
        }
        public function getType():int
        {
            return (WindowTracker._SafeStr_11793);
        }
        public function getId():String
        {
            return (("" + this._userId));
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
            if (this._frame != null){
                this._frame.destroy();
                this._frame = null;
            };
            if (this._SafeStr_11800 != null){
                this._SafeStr_11800.dispose();
                this._SafeStr_11800 = null;
            };
            this._help = null;
        }

    }
}//package com.sulake.habbo.moderation

// _help = "_-3HG" (String#114, DoABC#2)
// _SafeStr_11793 = "_-37N" (String#21783, DoABC#2)
// _SafeStr_11800 = "_-1Uc" (String#17688, DoABC#2)
// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowTracker = "_-2m9" (String#7008, DoABC#2)
// TrackedWindow = "_-Xp" (String#8365, DoABC#2)
// UserInfoFrameCtrl = "_-1D1" (String#5125, DoABC#2)
// UserInfoCtrl = "_-ip" (String#8573, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// getFrame = "_-3Jk" (String#923, DoABC#2)
// PollOfferDialog = "_-2Ts" (String#54, DoABC#2)
// destroy = "_-25R" (String#615, DoABC#2)



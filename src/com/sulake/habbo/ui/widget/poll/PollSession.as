
package com.sulake.habbo.ui.widget.poll
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.core.window.events.WindowEvent;

    public class PollSession implements IDisposable 
    {

        private var _id:int = -1;
        private var _SafeStr_14114:PollWidget;
        private var _SafeStr_14115:IPollDialog;
        private var _SafeStr_14116:IPollDialog;
        private var _endMessage:String = "";
        private var _disposed:Boolean = false;

        public function PollSession(_arg_1:int, _arg_2:PollWidget)
        {
            this._id = _arg_1;
            this._SafeStr_14114 = _arg_2;
        }
        public function get id():int
        {
            return (this._id);
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            if (this._SafeStr_14115 != null){
                this._SafeStr_14115.dispose();
                this._SafeStr_14115 = null;
            };
            if (this._SafeStr_14116 != null){
                this._SafeStr_14116.dispose();
                this._SafeStr_14116 = null;
            };
            this._SafeStr_14114 = null;
            this._disposed = true;
        }
        public function showOffer(_arg_1:String):void
        {
            this.hideOffer();
            this._SafeStr_14115 = new PollOfferDialog(this._id, _arg_1, this._SafeStr_14114);
            this._SafeStr_14115.start();
        }
        public function hideOffer():void
        {
            if ((this._SafeStr_14115 is PollOfferDialog)){
                if (!this._SafeStr_14115.disposed){
                    this._SafeStr_14115.dispose();
                };
                this._SafeStr_14115 = null;
            };
        }
        public function showContent(_arg_1:String, _arg_2:String, _arg_3:Array):void
        {
            this.hideOffer();
            this.hideContent();
            this._endMessage = _arg_2;
            this._SafeStr_14116 = new PollContentDialog(this._id, _arg_1, _arg_3, this._SafeStr_14114);
            this._SafeStr_14116.start();
        }
        public function hideContent():void
        {
            if ((this._SafeStr_14116 is PollContentDialog)){
                if (!this._SafeStr_14116.disposed){
                    this._SafeStr_14116.dispose();
                };
                this._SafeStr_14116 = null;
            };
        }
        public function showThanks():void
        {
            this._SafeStr_14114.windowManager.alert("${poll_thanks_title}", this._endMessage, 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
            {
                _arg_1.dispose();
            });
        }

    }
}//package com.sulake.habbo.ui.widget.poll

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// showContent = "_-ly" (String#24108, DoABC#2)
// showThanks = "_-1Tx" (String#17664, DoABC#2)
// _SafeStr_14114 = "_-16c" (String#16721, DoABC#2)
// _SafeStr_14115 = "_-Nx" (String#23163, DoABC#2)
// _SafeStr_14116 = "_-1E2" (String#17029, DoABC#2)
// hideOffer = "_-0Ng" (String#14979, DoABC#2)
// hideContent = "_-0Qn" (String#15093, DoABC#2)
// PollWidget = "_-0pz" (String#4635, DoABC#2)
// PollSession = "_-2C-" (String#6285, DoABC#2)
// IDisposable = "_-0dY" (String#4382, DoABC#2)
// IPollDialog = "_-1OE" (String#5315, DoABC#2)
// PollContentDialog = "_-1QT" (String#5360, DoABC#2)
// PollOfferDialog = "_-JC" (String#8066, DoABC#2)
// _endMessage = "_-0ua" (String#826, DoABC#2)
// showOffer = "_-2nW" (String#20980, DoABC#2)



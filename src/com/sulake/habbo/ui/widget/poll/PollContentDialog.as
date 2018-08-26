
package com.sulake.habbo.ui.widget.poll
{
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import flash.utils.Dictionary;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.core.window.components.ISelectorWindow;
    import com.sulake.core.window.components.ISelectableWindow;
    import com.sulake.core.window.components.ICheckBoxWindow;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.habbo.window.utils.IAlertDialog;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetPollMessage;

    public class PollContentDialog implements IPollDialog 
    {

        private static const _SafeStr_7558:int = 1;
        private static const _SafeStr_7560:int = 2;
        private static const _SafeStr_14119:int = 3;
        private static const _SafeStr_14120:int = 4;

        private var _id:int = -1;
        private var _disposed:Boolean = false;
        private var _SafeStr_14121:Array;
        private var _question:int = -1;
        private var _window:IFrameWindow;
        private var _widget:PollWidget;
        private var _SafeStr_14122:IFrameWindow;
        private var _SafeStr_14123:Boolean = false;

        public function PollContentDialog(_arg_1:int, _arg_2:String, _arg_3:Array, _arg_4:PollWidget)
        {
            var _local_6:ITextWindow;
            var _local_7:IWindow;
            var _local_8:IWindow;
            var _local_9:IWindow;
            super();
            this._id = _arg_1;
            this._SafeStr_14121 = _arg_3;
            this._widget = _arg_4;
            var _local_5:XmlAsset = (this._widget.assets.getAssetByName("poll_question") as XmlAsset);
            if (_local_5 != null){
                this._window = (this._widget.windowManager.buildFromXML((_local_5.content as XML)) as IFrameWindow);
                _local_6 = (this._window.findChildByName("poll_question_headline") as ITextWindow);
                if (_local_6){
                    _local_6.text = _arg_2;
                };
                this._window.center();
                _local_7 = this._window.findChildByName("header_button_close");
                if (_local_7 != null){
                    _local_7.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.PollOfferDialog);
                };
                _local_8 = this._window.findChildByName("poll_question_button_ok");
                if (_local_8 != null){
                    _local_8.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.PollOfferDialog);
                };
                _local_9 = this._window.findChildByName("poll_question_cancel");
                if (_local_9 != null){
                    _local_9.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.PollOfferDialog);
                };
            };
        }
        public function start():void
        {
            if (!this._SafeStr_14123){
                this._SafeStr_14123 = true;
                this.PollContentDialog();
            };
        }
        private function PollOfferDialog(_arg_1:WindowEvent):void
        {
            this.PollContentDialog();
        }
        private function PollOfferDialog(_arg_1:WindowEvent):void
        {
            this.PollContentDialog();
        }
        private function PollOfferDialog(_arg_1:WindowEvent):void
        {
            this.PollContentDialog();
        }
        public function dispose():void
        {
            if (this._disposed){
                return;
            };
            this._disposed = true;
            if (this._window){
                this._window.dispose();
                this._window = null;
            };
            if (this._SafeStr_14122){
                this._SafeStr_14122.dispose();
                this._SafeStr_14122 = null;
            };
            this._widget = null;
            this._SafeStr_14121 = null;
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        private function PollContentDialog():void
        {
            var _local_1:Dictionary;
            var _local_2:ITextWindow;
            var _local_3:int;
            var _local_4:IWindowContainer;
            var _local_5:IItemListWindow;
            var _local_6:String;
            var _local_7:int;
            this._question++;
            if (this._question < this._SafeStr_14121.length){
                _local_1 = (this._SafeStr_14121[this._question] as Dictionary);
                if (!_local_1){
                    Logger.log("ERROR; Poll question index out of range!");
                };
                if (this._window != null){
                    _local_3 = (_local_1["type"] as int);
                    _local_2 = (this._window.findChildByName("poll_question_text") as ITextWindow);
                    if (_local_2 != null){
                        _local_2.text = _local_1["content"];
                    };
                    _local_2 = (this._window.findChildByName("poll_question_number") as ITextWindow);
                    if (_local_2 != null){
                        _local_2.text = "${poll_question_number}";
                        _local_6 = _local_2.text;
                        _local_6 = _local_6.replace("%number%", _local_1["number"]);
                        _local_6 = _local_6.replace("%count%", this._SafeStr_14121.length);
                        _local_2.text = _local_6;
                    };
                    _local_4 = (this._window.findChildByName("poll_question_answer_container") as IWindowContainer);
                    if (_local_4 != null){
                        while (_local_4.numChildren > 0) {
                            _local_4.getChildAt(0).dispose();
                        };
                    };
                    switch (_local_3){
                        case _SafeStr_7558:
                            this.PollContentDialog(_local_4, _local_1["selections"]);
                            break;
                        case _SafeStr_7560:
                            this.PollContentDialog(_local_4, _local_1["selections"]);
                            break;
                        case _SafeStr_14119:
                            this.PollContentDialog(_local_4);
                            break;
                        case _SafeStr_14120:
                            this.PollContentDialog(_local_4);
                            break;
                        default:
                            throw (new Error((("Unknown poll question type: " + _local_3) + "!")));
                    };
                    _local_5 = (this._window.findChildByName("poll_content_wrapper") as IItemListWindow);
                    if (_local_5 != null){
                        _local_7 = (_local_5.scrollableRegion.height - _local_5.visibleRegion.height);
                        this._window.height = (this._window.height + _local_7);
                        this._window.center();
                    };
                };
            }
            else {
                this._widget.pollFinished(this._id);
            };
        }
        private function PollContentDialog(_arg_1:IWindowContainer, _arg_2:Array):void
        {
            var _local_3:XmlAsset = (this._widget.assets.getAssetByName("poll_answer_radiobutton_input") as XmlAsset);
            if (!_local_3){
                throw (new Error('Asset for poll widget hot found: "poll_answer_radiobutton_input"!'));
            };
            var _local_4:IWindowContainer = (this._widget.windowManager.buildFromXML((_local_3.content as XML)) as IWindowContainer);
            if (_local_4 != null){
                this.PollContentDialog(_arg_2, _local_4);
                _arg_1.addChild(_local_4);
            };
        }
        private function PollContentDialog():Array
        {
            var _local_2:ISelectorWindow;
            var _local_3:ISelectableWindow;
            var _local_1:Array = new Array();
            if (this._window != null){
                _local_2 = (this._window.findChildByName("poll_aswer_selector") as ISelectorWindow);
                if (_local_2){
                    _local_3 = _local_2.ISelectorWindow();
                    if (_local_3){
                        _local_1.push((_local_3.id + 1));
                    };
                };
            };
            return (_local_1);
        }
        private function PollContentDialog(_arg_1:IWindowContainer, _arg_2:Array):void
        {
            var _local_3:XmlAsset = (this._widget.assets.getAssetByName("poll_answer_checkbox_input") as XmlAsset);
            if (!_local_3){
                throw (new Error('Asset for poll widget hot found: "poll_answer_checkbox_input"!'));
            };
            var _local_4:IWindowContainer = (this._widget.windowManager.buildFromXML((_local_3.content as XML)) as IWindowContainer);
            if (_local_4 != null){
                this.PollContentDialog(_arg_2, _local_4);
                _arg_1.addChild(_local_4);
            };
        }
        private function PollContentDialog():Array
        {
            var _local_2:IItemListWindow;
            var _local_3:int;
            var _local_4:IWindowContainer;
            var _local_5:ICheckBoxWindow;
            var _local_1:Array = new Array();
            if (this._window != null){
                _local_2 = (this._window.findChildByName("poll_answer_itemlist") as IItemListWindow);
                if (_local_2 != null){
                    _local_3 = 0;
                    while (_local_3 < _local_2.numListItems) {
                        _local_4 = (_local_2.getListItemAt(_local_3) as IWindowContainer);
                        if (_local_4 != null){
                            _local_5 = (_local_4.findChildByName("poll_answer_checkbox") as ICheckBoxWindow);
                            if (_local_5 != null){
                                if (_local_5.IWindow(WindowState._SafeStr_9258)){
                                    _local_1.push((_local_3 + 1));
                                };
                            };
                        };
                        _local_3++;
                    };
                };
            };
            return (_local_1);
        }
        private function PollContentDialog(_arg_1:Array, _arg_2:IWindowContainer):void
        {
            var _local_4:IWindowContainer;
            var _local_5:int;
            var _local_6:ITextWindow;
            var _local_7:IWindow;
            var _local_3:IItemListWindow = (_arg_2.findChildByName("poll_answer_itemlist") as IItemListWindow);
            if (_local_3 != null){
                _local_4 = (_arg_2.findChildByName("poll_answer_entity") as IWindowContainer);
                if (_local_4 != null){
                    _local_5 = 0;
                    while (_local_5 < (_arg_1.length - 1)) {
                        _local_5++;
                        _local_3.addListItem(_local_4.clone());
                    };
                    _local_5 = 0;
                    while (_local_5 < _arg_1.length) {
                        _local_4 = (_local_3.getListItemAt(_local_5) as IWindowContainer);
                        _local_6 = (_local_4.findChildByName("poll_answer_entity_text") as ITextWindow);
                        if (_local_6){
                            _local_6.text = _arg_1[_local_5];
                        };
                        _local_7 = _local_4.findChildByTag("POLL_SELECTABLE_ITEM");
                        if (_local_7){
                            _local_7.id = _local_5;
                        };
                        _local_5++;
                    };
                };
            };
        }
        private function PollContentDialog(_arg_1:IWindowContainer):void
        {
            var _local_2:XmlAsset = (this._widget.assets.getAssetByName("poll_answer_text_input") as XmlAsset);
            if (!_local_2){
                throw (new Error('Asset for poll widget hot found: "poll_answer_text_input"!'));
            };
            _arg_1.addChild(this._widget.windowManager.buildFromXML((_local_2.content as XML)));
        }
        private function PollContentDialog():Array
        {
            var _local_2:ITextWindow;
            var _local_1:Array = new Array();
            if (this._window != null){
                _local_2 = (this._window.findChildByName("poll_answer_input") as ITextWindow);
                if (_local_2 != null){
                    _local_1.push(_local_2.text);
                };
            }
            else {
                throw (new Error("Invalid or disposed poll dialog!"));
            };
            return (_local_1);
        }
        private function PollContentDialog(_arg_1:IWindowContainer):void
        {
            this.PollContentDialog(_arg_1);
        }
        private function PollContentDialog():Array
        {
            return (this.PollContentDialog());
        }
        private function PollContentDialog():void
        {
            this._widget.pollCancelled(this._id);
        }
        private function PollContentDialog():void
        {
            var answerArray:Array;
            var question:Dictionary = (this._SafeStr_14121[this._question] as Dictionary);
            var type:int = (question["type"] as int);
            switch (type){
                case _SafeStr_7558:
                    answerArray = this.PollContentDialog();
                    if (answerArray.length < int(question["selection_min"])){
                        this._widget.windowManager.alert("${win_error}", "${poll_alert_answer_missing}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                        {
                            _arg_1.dispose();
                        });
                        return;
                    };
                    if (answerArray.length > int(question["selection_max"])){
                        this._widget.windowManager.alert("${win_error}", "${poll_alert_invalid_selection}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                        {
                            _arg_1.dispose();
                        });
                        return;
                    };
                    break;
                case _SafeStr_7560:
                    answerArray = this.PollContentDialog();
                    if (answerArray.length < int(question["selection_min"])){
                        this._widget.windowManager.alert("${win_error}", "${poll_alert_answer_missing}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                        {
                            _arg_1.dispose();
                        });
                        return;
                    };
                    if (answerArray.length > int(question["selection_max"])){
                        this._widget.windowManager.alert("${win_error}", "${poll_alert_invalid_selection}", 0, function (_arg_1:IAlertDialog, _arg_2:WindowEvent):void
                        {
                            _arg_1.dispose();
                        });
                        return;
                    };
                    break;
                case _SafeStr_14119:
                    answerArray = this.PollContentDialog();
                    break;
                case _SafeStr_14120:
                    answerArray = this.PollContentDialog();
                    break;
                default:
                    throw (new Error((("Unknown poll question type: " + type) + "!")));
            };
            var message:RoomWidgetPollMessage = new RoomWidgetPollMessage(RoomWidgetPollMessage.ANSWER, this._id);
            message.questionId = (question["id"] as int);
            message.answers = answerArray;
            this._widget.messageListener.processWidgetMessage(message);
            this.PollContentDialog();
        }
        private function PollContentDialog():void
        {
            var _local_1:XmlAsset;
            var _local_2:IWindow;
            var _local_3:IWindow;
            var _local_4:IWindow;
            if (!this._SafeStr_14122){
                _local_1 = (this._widget.assets.getAssetByName("poll_cancel_confirm") as XmlAsset);
                this._SafeStr_14122 = (this._widget.windowManager.buildFromXML((_local_1.content as XML), 2) as IFrameWindow);
                this._SafeStr_14122.center();
                _local_2 = this._SafeStr_14122.findChildByName("header_button_close");
                if (_local_2 != null){
                    _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.PollContentDialog);
                };
                _local_3 = this._SafeStr_14122.findChildByName("poll_cancel_confirm_button_ok");
                if (_local_3 != null){
                    _local_3.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.PollContentDialog);
                };
                _local_4 = this._SafeStr_14122.findChildByName("poll_cancel_confirm_button_cancel");
                if (_local_4 != null){
                    _local_4.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.PollContentDialog);
                };
            };
        }
        private function PollContentDialog():void
        {
            if (this._SafeStr_14122 != null){
                this._SafeStr_14122.dispose();
                this._SafeStr_14122 = null;
            };
        }
        private function PollContentDialog(_arg_1:WindowEvent):void
        {
            this.PollContentDialog();
        }
        private function PollContentDialog(_arg_1:WindowEvent):void
        {
            this.PollContentDialog();
            this.PollContentDialog();
        }
        private function PollContentDialog(_arg_1:WindowEvent):void
        {
            this.PollContentDialog();
        }

    }
}//package com.sulake.habbo.ui.widget.poll

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// IAlertDialog = "_-2LY" (String#6472, DoABC#2)
// pollFinished = "_-0qF" (String#16059, DoABC#2)
// pollCancelled = "_-1uv" (String#18752, DoABC#2)
// _SafeStr_14119 = "_-qY" (String#24295, DoABC#2)
// _SafeStr_14120 = "_-0xP" (String#16328, DoABC#2)
// _SafeStr_14121 = "_-0HO" (String#14735, DoABC#2)
// _SafeStr_14122 = "_-2-S" (String#18990, DoABC#2)
// _SafeStr_14123 = "_-0JY" (String#14824, DoABC#2)
// PollContentDialog = "_-1ls" (String#18369, DoABC#2)
// PollContentDialog = "_-1q" (String#18541, DoABC#2)
// PollContentDialog = "_-1M1" (String#17359, DoABC#2)
// PollContentDialog = "_-0uZ" (String#16224, DoABC#2)
// PollContentDialog = "_-13Q" (String#16595, DoABC#2)
// PollContentDialog = "_-1eY" (String#18080, DoABC#2)
// PollContentDialog = "_-2SX" (String#20138, DoABC#2)
// PollContentDialog = "_-0wm" (String#16302, DoABC#2)
// PollContentDialog = "_-2sC" (String#21167, DoABC#2)
// PollContentDialog = "_-1HZ" (String#17173, DoABC#2)
// PollContentDialog = "_-1E" (String#17025, DoABC#2)
// PollContentDialog = "_-1Hu" (String#17189, DoABC#2)
// PollContentDialog = "_-0Jy" (String#14839, DoABC#2)
// PollContentDialog = "_-28L" (String#19345, DoABC#2)
// PollContentDialog = "_-LI" (String#23057, DoABC#2)
// PollContentDialog = "_-3Eq" (String#22070, DoABC#2)
// PollContentDialog = "_-0i4" (String#15751, DoABC#2)
// ISelectableWindow = "_-nA" (String#2188, DoABC#2)
// WindowState = "_-1Kt" (String#5262, DoABC#2)
// ICheckBoxWindow = "_-1zu" (String#1793, DoABC#2)
// ISelectorWindow = "_-1aY" (String#1714, DoABC#2)
// PollWidget = "_-0pz" (String#4635, DoABC#2)
// RoomWidgetPollMessage = "_-0uI" (String#4731, DoABC#2)
// IPollDialog = "_-1OE" (String#5315, DoABC#2)
// PollContentDialog = "_-1QT" (String#5360, DoABC#2)
// questionId = "_-3-c" (String#21486, DoABC#2)
// answers = "_-2rZ" (String#21139, DoABC#2)
// ISelectorWindow = "_-88" (String#7825, DoABC#2)
// scrollableRegion = "_-2ku" (String#6976, DoABC#2)
// _question = "_-10p" (String#596, DoABC#2)
// PollOfferDialog = "_-2Ts" (String#54, DoABC#2)
// PollOfferDialog = "_-3JX" (String#633, DoABC#2)
// PollOfferDialog = "_-39j" (String#457, DoABC#2)
// _SafeStr_7558 = "_-sC" (String#8741, DoABC#2)
// _SafeStr_7560 = "_-Tu" (String#8283, DoABC#2)
// visibleRegion = "_-MK" (String#8129, DoABC#2)
// IWindow = "_-35A" (String#7410, DoABC#2)
// _SafeStr_9258 = "const" (String#44694, DoABC#2)



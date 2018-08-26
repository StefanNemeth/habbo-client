
package com.sulake.habbo.ui.widget.poll
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import flash.utils.Timer;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import flash.events.TimerEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetVoteUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.core.window.IWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IDesktopWindow;
    import flash.utils.getTimer;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.components.IBorderWindow;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetVoteMessage;
    import com.sulake.core.window.events.WindowEvent;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Rectangle;

    public class VoteWidget extends RoomWidgetBase 
    {

        private var _window:IFrameWindow;
        private var _content:IItemListWindow;
        private var _config:IHabboConfigurationManager;
        private var _vote:int = -1;
        private var _SafeStr_14099:int = 30000;
        private var _SafeStr_8077:int;
        private var _SafeStr_14086:Timer;

        public function VoteWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:IHabboConfigurationManager)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this._config = _arg_5;
            if (this._config != null){
                this._SafeStr_14099 = int(this._config.getKey("vote.time.limit", "30000"));
            };
        }
        override public function dispose():void
        {
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
            if (this._SafeStr_14086){
                this._SafeStr_14086.reset();
                this._SafeStr_14086.removeEventListener(TimerEvent.TIMER, this.updateEvent);
                this._SafeStr_14086 = null;
            };
            this._config = null;
            super.dispose();
        }
        override public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.addEventListener(RoomWidgetVoteUpdateEvent.RWPUE_VOTE_QUESTION, this.showVoteQuestion);
            _arg_1.addEventListener(RoomWidgetVoteUpdateEvent.RWPUE_VOTE_RESULT, this.showVoteResult);
            super.RoomChatWidget(_arg_1);
        }
        override public function RoomChatWidget(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetVoteUpdateEvent.RWPUE_VOTE_QUESTION, this.showVoteQuestion);
            _arg_1.removeEventListener(RoomWidgetVoteUpdateEvent.RWPUE_VOTE_RESULT, this.showVoteResult);
        }
        private function showVoteQuestion(_arg_1:RoomWidgetVoteUpdateEvent):void
        {
            var _local_6:IWindow;
            var _local_12:Point;
            if (_arg_1 == null){
                return;
            };
            if (!this.createWindow()){
                return;
            };
            var _local_2:ITextWindow = (this._window.findChildByName("question") as ITextWindow);
            if (_local_2 == null){
                return;
            };
            var _local_3:IWindowContainer = (this._window.findChildByName("list_container") as IWindowContainer);
            if (_local_3 == null){
                return;
            };
            _local_2.text = _arg_1.question;
            var _local_4:int = Math.max(((_local_2.textHeight + 10) - _local_2.height), 0);
            _local_2.scale(0, _local_4);
            _local_3.offset(0, _local_4);
            var _local_5:Array = _arg_1.choices;
            var _local_7:int;
            while (_local_7 < _local_5.length) {
                _local_6 = this.createChoice(_local_7, _local_5[_local_7]);
                if (_local_6 == null){
                    return;
                };
                this._content.addListItem(_local_6);
                _local_7++;
            };
            var _local_8:int = Math.max((this._content.scrollableRegion.height - this._content.height), 0);
            _local_3.scale(0, _local_8);
            this._window.scale(0, (_local_4 + _local_8));
            var _local_9:IWindow = this._window.findChildByName("waiting_text");
            if (_local_9 != null){
                _local_9.visible = false;
            };
            var _local_10:IDesktopWindow = this._window.desktop;
            if (_local_10 != null){
                _local_12 = new Point((_local_10.width - this._window.width), (_local_10.height - this._window.height));
                _local_12.offset(-10, -10);
                this._window.WindowController(_local_12);
            };
            this._window.visible = true;
            this._vote = -1;
            if (this._SafeStr_14086 == null){
                this._SafeStr_14086 = new Timer(1000);
                this._SafeStr_14086.addEventListener(TimerEvent.TIMER, this.updateEvent);
            };
            this._SafeStr_8077 = getTimer();
            this._SafeStr_14086.reset();
            this._SafeStr_14086.start();
            var _local_11:IWindow = this._window.findChildByName("timer");
            if (_local_11 != null){
                _local_11.visible = true;
            };
        }
        private function createWindow():Boolean
        {
            if (this._window != null){
                this._window.dispose();
            };
            var _local_1:XmlAsset = (assets.getAssetByName("vote_question") as XmlAsset);
            this._window = (windowManager.buildFromXML((_local_1.content as XML)) as IFrameWindow);
            if (this._window == null){
                return (false);
            };
            this._content = (this._window.findChildByName("choices") as IItemListWindow);
            if (this._content == null){
                return (false);
            };
            this._window.visible = false;
            var _local_2:IWindow = this._window.findChildByTag("close");
            if (_local_2 != null){
                _local_2.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.close);
            };
            var _local_3:IWindow = this._window.findChildByName("timer");
            if (_local_3 != null){
                _local_3.visible = false;
            };
            return (true);
        }
        private function createChoice(_arg_1:int, _arg_2:String):IWindow
        {
            var _local_3:XmlAsset = (assets.getAssetByName("vote_choice") as XmlAsset);
            if (_local_3 == null){
                return (null);
            };
            var _local_4:IWindowContainer = (windowManager.buildFromXML((_local_3.content as XML)) as IWindowContainer);
            if (_local_4 == null){
                return (null);
            };
            var _local_5:ITextWindow = (_local_4.findChildByName("text") as ITextWindow);
            if (_local_5 == null){
                return (null);
            };
            var _local_6:IButtonWindow = (_local_4.findChildByName("button") as IButtonWindow);
            if (_local_6 == null){
                return (null);
            };
            _local_6.id = _arg_1;
            _local_6.caption = String.fromCharCode((97 + _arg_1));
            _local_6.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onChoiceClicked);
            _local_5.text = _arg_2;
            var _local_7:IWindowContainer = (_local_4.findChildByName("bg") as IWindowContainer);
            if (_local_7 != null){
                _local_7.visible = false;
            };
            return (_local_4);
        }
        private function onChoiceClicked(_arg_1:WindowMouseEvent):void
        {
            if ((((_arg_1 == null)) || ((_arg_1.window == null)))){
                return;
            };
            this.vote(_arg_1.window.id);
        }
        private function vote(_arg_1:int=-1):void
        {
            var _local_2:IBorderWindow;
            var _local_3:IButtonWindow;
            this._vote = _arg_1;
            if (_arg_1 >= 0){
                if (messageListener == null){
                    return;
                };
                messageListener.processWidgetMessage(new RoomWidgetVoteMessage((_arg_1 + 1)));
            };
            if ((((this._window == null)) || ((this._content == null)))){
                return;
            };
            var _local_4:int;
            while (_local_4 < this._content.numListItems) {
                _local_2 = (this._content.getListItemAt(_local_4) as IBorderWindow);
                if (_local_2 == null){
                    return;
                };
                if (_local_4 != this._vote){
                    _local_2.blend = 0.5;
                };
                _local_3 = (_local_2.findChildByName("button") as IButtonWindow);
                if (_local_3 == null){
                    return;
                };
                _local_3.disable();
                _local_4++;
            };
            var _local_5:IWindow = this._window.findChildByName("timer");
            if (_local_5 != null){
                _local_5.visible = false;
            };
            var _local_6:IWindow = this._window.findChildByName("waiting_text");
            if (_local_6 != null){
                _local_6.visible = true;
            };
            this._SafeStr_14086.reset();
        }
        private function close(_arg_1:WindowEvent=null):void
        {
            if (this._window != null){
                this._window.dispose();
                this._window = null;
            };
        }
        private function updateTimerView():void
        {
            var _local_4:Number;
            var _local_5:BitmapData;
            var _local_6:int;
            if (this._window == null){
                return;
            };
            var _local_1:int = (getTimer() - this._SafeStr_8077);
            var _local_2:IBitmapWrapperWindow = (this._window.findChildByName("timer_bar") as IBitmapWrapperWindow);
            if (_local_2 != null){
                _local_4 = (Number(_local_1) / this._SafeStr_14099);
                _local_5 = new BitmapData(_local_2.width, _local_2.height, true, 0xFF339900);
                if (_local_4 > 0){
                    _local_5.fillRect(new Rectangle(0, 0, _local_5.width, int((_local_5.height * _local_4))), 4292006610);
                };
                _local_2.bitmap = _local_5;
            };
            var _local_3:ITextWindow = (this._window.findChildByName("timer_text") as ITextWindow);
            if (_local_3 != null){
                _local_6 = Math.max(((this._SafeStr_14099 - _local_1) / 1000), 0);
                _local_3.text = (_local_6 + " s");
            };
        }
        private function updateEvent(_arg_1:TimerEvent):void
        {
            var _local_2:int = (getTimer() - this._SafeStr_8077);
            if (_local_2 > this._SafeStr_14099){
                this.vote();
                return;
            };
            this.updateTimerView();
        }
        private function showVoteResult(_arg_1:RoomWidgetVoteUpdateEvent):void
        {
            var _local_2:IWindow;
            var _local_4:IWindowContainer;
            var _local_5:IBitmapWrapperWindow;
            var _local_6:IWindowContainer;
            var _local_7:ITextWindow;
            var _local_8:IButtonWindow;
            var _local_9:BitmapData;
            var _local_10:int;
            if ((((this._window == null)) || ((this._content == null)))){
                return;
            };
            _local_2 = this._window.findChildByName("timer");
            if (_local_2 != null){
                _local_2.visible = false;
            };
            _local_2 = this._window.findChildByName("waiting_text");
            if (_local_2 != null){
                _local_2.visible = false;
            };
            if (this._content.numListItems != _arg_1.votes.length){
                return;
            };
            var _local_3:int;
            while (_local_3 < this._content.numListItems) {
                _local_4 = (this._content.getListItemAt(_local_3) as IWindowContainer);
                if (_local_4 != null){
                    _local_5 = (_local_4.findChildByName("vote_bar") as IBitmapWrapperWindow);
                    if (_local_5 != null){
                        _local_9 = new BitmapData(_local_5.width, _local_5.height, true, 0);
                        _local_10 = int(((Number(_arg_1.votes[_local_3]) / _arg_1.totalVotes) * _local_9.width));
                        if (_local_10 > 0){
                            _local_9.fillRect(new Rectangle(0, 0, _local_10, _local_9.height), 0xFF339900);
                            _local_5.bitmap = _local_9;
                        };
                    };
                    _local_6 = (_local_4.findChildByName("bg") as IWindowContainer);
                    if (_local_6 != null){
                        _local_6.visible = true;
                    };
                    _local_7 = (_local_4.findChildByName("text") as ITextWindow);
                    if (_local_7 != null){
                        _local_7.text = (((((_local_7.text + " ( ") + _arg_1.votes[_local_3]) + "/") + _arg_1.totalVotes) + " )");
                    };
                    _local_8 = (_local_4.findChildByName("button") as IButtonWindow);
                    if (_local_8 != null){
                        _local_8.disable();
                    };
                };
                _local_3++;
            };
        }

    }
}//package com.sulake.habbo.ui.widget.poll

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// _SafeStr_14086 = "_-ck" (String#8468, DoABC#2)
// _SafeStr_14099 = "_-0P" (String#15024, DoABC#2)
// updateEvent = "_-d5" (String#23761, DoABC#2)
// showVoteQuestion = "_-0lN" (String#15878, DoABC#2)
// showVoteResult = "_-0fE" (String#15639, DoABC#2)
// createChoice = "_-39" (String#21843, DoABC#2)
// onChoiceClicked = "_-1tg" (String#18705, DoABC#2)
// updateTimerView = "_-22n" (String#19124, DoABC#2)
// IBorderWindow = "_-0Br" (String#1422, DoABC#2)
// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// VoteWidget = "_-qq" (String#8722, DoABC#2)
// RoomWidgetVoteMessage = "_-0ie" (String#4475, DoABC#2)
// RoomWidgetVoteUpdateEvent = "_-2qd" (String#7089, DoABC#2)
// _vote = "_-1EJ" (String#5148, DoABC#2)
// vote = "_-AW" (String#7878, DoABC#2)
// RoomChatWidget = "_-1yD" (String#1787, DoABC#2)
// RoomChatWidget = "_-0-c" (String#3556, DoABC#2)
// _content = "_-1Q8" (String#74, DoABC#2)
// scrollableRegion = "_-2ku" (String#6976, DoABC#2)
// RWPUE_VOTE_QUESTION = "_-1cE" (String#17980, DoABC#2)
// RWPUE_VOTE_RESULT = "_-1I3" (String#17195, DoABC#2)
// votes = "_-2a2" (String#20443, DoABC#2)
// totalVotes = "_-0EU" (String#14625, DoABC#2)
// _SafeStr_8077 = "_-3HJ" (String#2035, DoABC#2)
// WindowController = "_-0OJ" (String#4052, DoABC#2)



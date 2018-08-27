
package com.sulake.habbo.ui.widget.roomchat
{
    import com.sulake.habbo.ui.widget.RoomWidgetBase;
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemListWindow;
    import flash.geom.Point;
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.window.IWindow;
    import flash.utils.getTimer;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChatUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomViewUpdateEvent;
    import flash.events.IEventDispatcher;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChatSelectAvatarMessage;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class RoomChatWidget extends RoomWidgetBase implements IUpdateReceiver 
    {

        private static const _SafeStr_14144:int = 18;
        private static const _SafeStr_14145:int = 9;
        private static const _SafeStr_14146:int = 10;
        private static const _SafeStr_14147:int = 25;
        private static const _SafeStr_14148:int = 25;
        private static const _SafeStr_14149:int = 4000;
        private static const _SafeStr_14150:int = 6000;
        private static const _SafeStr_14151:int = 3;
        private static const _SafeStr_14152:int = 1;
        private static const _SafeStr_14153:int = 8;
        private static const _SafeStr_14154:int = 0;
        private static const _SafeStr_14155:int = (((_SafeStr_14153 + _SafeStr_14154) * _SafeStr_14144) + _SafeStr_14144);//162
        private static const _SafeStr_14156:int = 9;
        private static const _SafeStr_14157:int = 40;

        private var _SafeStr_14158:int = 0;
        private var _SafeStr_14159:int = 0;
        private var _mainWindow:IWindowContainer;
        private var _SafeStr_14161:IItemListWindow;
        private var _SafeStr_14162:IWindowContainer;
        private var _itemList:Array;
        private var _SafeStr_14163:Array;
        private var _SafeStr_14164:Array;
        private var _SafeStr_14165:int;
        private var _SafeStr_14166:int = 0;
        private var _SafeStr_14167:Number = 1;
        private var _baseUrl:String;
        private var _SafeStr_14168:Number = 1;
        private var _SafeStr_14169:Number = 0;
        private var _SafeStr_14170:Point;
        private var _SafeStr_14171:RoomChatHistoryViewer;
        private var _SafeStr_4426:Boolean = false;
        private var _SafeStr_14172:Boolean = false;
        private var _component:Component = null;
        private var _config:IHabboConfigurationManager;
        private var _SafeStr_14173:int = 150;
        private var _SafeStr_14174:int = 171;
        private var _SafeStr_14175:int = 18;
        private var _SafeStr_14176:int = 100;
        private var _SafeStr_14177:int = 195;

        public function RoomChatWidget(_arg_1:IRoomWidgetHandler, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:IHabboLocalizationManager, _arg_5:IHabboConfigurationManager, _arg_6:int, _arg_7:Component)
        {
            this._itemList = new Array();
            this._SafeStr_14163 = new Array();
            this._SafeStr_14164 = new Array();
            this._SafeStr_14170 = new Point();
            super(_arg_1, _arg_2, _arg_3, _arg_4);
            this._config = _arg_5;
            this._SafeStr_14165 = _arg_6;
            this._mainWindow = (_arg_2.createWindow("chat_container", "", HabboWindowType._SafeStr_3728, HabboWindowStyle._SafeStr_3729, HabboWindowParam._SafeStr_4662, new Rectangle(0, 0, 200, (this._SafeStr_14174 + RoomChatHistoryPulldown._SafeStr_14178)), null, 0) as IWindowContainer);
            this._mainWindow.background = true;
            this._mainWindow.color = 33554431;
            this._mainWindow.tags.push("room_widget_chat");
            this._SafeStr_14161 = (_arg_2.createWindow("chat_contentlist", "", HabboWindowType._SafeStr_7519, HabboWindowStyle._SafeStr_4662, (HabboWindowParam._SafeStr_6023 | HabboWindowParam._SafeStr_7469), new Rectangle(0, 0, 200, this._SafeStr_14174), null, 0) as IItemListWindow);
            this._mainWindow.addChild(this._SafeStr_14161);
            this._SafeStr_14162 = (_arg_2.createWindow("chat_active_content", "", HabboWindowType._SafeStr_3728, HabboWindowStyle._SafeStr_4662, HabboWindowParam._SafeStr_6023, new Rectangle(0, 0, 200, this._SafeStr_14174), null, 0) as IWindowContainer);
            this._SafeStr_14162.clipping = false;
            this._SafeStr_14161.addListItem(this._SafeStr_14162);
            this._SafeStr_14171 = new RoomChatHistoryViewer(this, _arg_2, this._mainWindow, _arg_3);
            this._baseUrl = _arg_5.getKey("site.url");
            this._SafeStr_14173 = int(_arg_5.getKey("chat.history.item.max.count", "150"));
            var _local_8:Boolean = _arg_5.getBoolean("chat.history.disabled", false);
            if (this._SafeStr_14171 != null){
                this._SafeStr_14171.disabled = _local_8;
            };
            if (_arg_7 != null){
                this._component = _arg_7;
                this._component.registerUpdateReceiver(this, 1);
            };
        }
        override public function get mainWindow():IWindow
        {
            return (this._mainWindow);
        }
        public function get config():IHabboConfigurationManager
        {
            return (this._config);
        }
        override public function dispose():void
        {
            var _local_1:RoomChatItem;
            var _local_2:int;
            if (disposed){
                return;
            };
            while (this._SafeStr_14164.length > 0) {
                _local_1 = this._SafeStr_14164.shift();
            };
            this._SafeStr_14171.dispose();
            this._SafeStr_14171 = null;
            while (this._itemList.length > 0) {
                _local_1 = this._itemList.shift();
                _local_1.dispose();
            };
            while (this._SafeStr_14163.length > 0) {
                _local_1 = this._SafeStr_14163.shift();
                _local_1.dispose();
            };
            this._mainWindow.dispose();
            if (this._component != null){
                this._component.removeUpdateReceiver(this);
                this._component = null;
            };
            super.dispose();
        }
        public function update(_arg_1:uint):void
        {
            var _local_2:int;
            if ((((getTimer() > this._SafeStr_14158)) && ((this._SafeStr_14158 > 0)))){
                this._SafeStr_14158 = -1;
                this.animationStart();
            };
            if (this._SafeStr_4426){
                _local_2 = ((_arg_1 / _SafeStr_14148) * _SafeStr_14151);
                if ((_local_2 + this._SafeStr_14159) > this._SafeStr_14175){
                    _local_2 = (this._SafeStr_14175 - this._SafeStr_14159);
                };
                if (_local_2 > 0){
                    this.moveItemsUp(_local_2);
                    this._SafeStr_14159 = (this._SafeStr_14159 + _local_2);
                };
                if (this._SafeStr_14159 >= this._SafeStr_14175){
                    this._SafeStr_14175 = _SafeStr_14144;
                    this._SafeStr_14159 = 0;
                    this.animationStop();
                    this.processBuffer();
                    this._SafeStr_14158 = (getTimer() + _SafeStr_14149);
                };
            };
            if (this._SafeStr_14171 != null){
                this._SafeStr_14171.update(_arg_1);
            };
        }
        override public function registerUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.addEventListener(RoomWidgetChatUpdateEvent.RWCUE_EVENT_CHAT, this.onChatMessage);
            _arg_1.addEventListener(RoomWidgetRoomViewUpdateEvent.RWRVUE_ROOM_VIEW_SIZE_CHANGED, this.onRoomViewUpdate);
            _arg_1.addEventListener(RoomWidgetRoomViewUpdateEvent.RWRVUE_ROOM_VIEW_POSITION_CHANGED, this.onRoomViewUpdate);
            _arg_1.addEventListener(RoomWidgetRoomViewUpdateEvent.RWRVUE_ROOM_VIEW_SCALE_CHANGED, this.onRoomViewUpdate);
            super.registerUpdateEvents(_arg_1);
        }
        override public function unregisterUpdateEvents(_arg_1:IEventDispatcher):void
        {
            if (_arg_1 == null){
                return;
            };
            _arg_1.removeEventListener(RoomWidgetChatUpdateEvent.RWCUE_EVENT_CHAT, this.onChatMessage);
            _arg_1.removeEventListener(RoomWidgetRoomViewUpdateEvent.RWRVUE_ROOM_VIEW_SIZE_CHANGED, this.onRoomViewUpdate);
            _arg_1.removeEventListener(RoomWidgetRoomViewUpdateEvent.RWRVUE_ROOM_VIEW_POSITION_CHANGED, this.onRoomViewUpdate);
            _arg_1.removeEventListener(RoomWidgetRoomViewUpdateEvent.RWRVUE_ROOM_VIEW_SCALE_CHANGED, this.onRoomViewUpdate);
        }
        private function onChatMessage(_arg_1:RoomWidgetChatUpdateEvent):void
        {
            var _local_2:RoomChatItem = new RoomChatItem(this, windowManager, assets, this.getFreeItemId(), localizations, this._baseUrl);
            _local_2.define(_arg_1);
            if (this._SafeStr_14168 != 1){
                _local_2.senderX = (_local_2.senderX / this._SafeStr_14168);
            };
            _local_2.senderX = (_local_2.senderX - this._SafeStr_14170.x);
            this.setChatItemLocHorizontal(_local_2);
            this._SafeStr_14163.push(_local_2);
            this.processBuffer();
        }
        private function onRoomViewUpdate(_arg_1:RoomWidgetRoomViewUpdateEvent):void
        {
            var _local_2:Rectangle = _arg_1.rect;
            if (_arg_1.scale > 0){
                if (this._SafeStr_14169 == 0){
                    this._SafeStr_14169 = _arg_1.scale;
                }
                else {
                    this._SafeStr_14168 = (_arg_1.scale / this._SafeStr_14169);
                };
            };
            if (_arg_1.positionDelta != null){
                this._SafeStr_14170.x = (this._SafeStr_14170.x + (_arg_1.positionDelta.x / this._SafeStr_14168));
                this._SafeStr_14170.y = (this._SafeStr_14170.y + (_arg_1.positionDelta.y / this._SafeStr_14168));
            };
            if (_arg_1.rect != null){
                if (this._SafeStr_14171 == null){
                    return;
                };
                this._mainWindow.width = _local_2.width;
                this._mainWindow.height = (this._SafeStr_14174 + this._SafeStr_14171.pulldownBarHeight);
                this._SafeStr_14161.width = (this._mainWindow.width - this._SafeStr_14171.scrollbarWidth);
                this._SafeStr_14161.height = this._SafeStr_14174;
                this._SafeStr_14161.x = this._mainWindow.x;
                this._SafeStr_14161.y = this._mainWindow.y;
                this._SafeStr_14162.width = (this._mainWindow.width - this._SafeStr_14171.scrollbarWidth);
                this._SafeStr_14162.height = this._SafeStr_14174;
                if (this.historyViewerActive()){
                    this.reAlignItemsToHistoryContent();
                };
                this._SafeStr_14171.containerResized(this._mainWindow.rectangle, true);
            };
            this.alignItems();
        }
        private function processBuffer():void
        {
            if (this._SafeStr_4426){
                return;
            };
            if (this._SafeStr_14163.length == 0){
                return;
            };
            while ((((this._SafeStr_14163.length > _SafeStr_14152)) || (((this.historyViewerActive()) && ((this._SafeStr_14163.length > 0)))))) {
                this.activateItemFromBuffer();
            };
            var _local_1:Boolean;
            if (this._itemList.length == 0){
                _local_1 = true;
            }
            else {
                _local_1 = this.checkLastItemAllowsAdding(this._SafeStr_14163[0]);
            };
            if (_local_1){
                this.activateItemFromBuffer();
                this._SafeStr_14158 = (getTimer() + _SafeStr_14149);
            }
            else {
                if ((((this._itemList.length > 0)) && ((this._SafeStr_14163.length > 0)))){
                    this._SafeStr_14175 = this.getItemSpacing(this._itemList[(this._itemList.length - 1)], this._SafeStr_14163[0]);
                }
                else {
                    this._SafeStr_14175 = _SafeStr_14144;
                };
                this.animationStart();
            };
        }
        private function activateItemFromBuffer():void
        {
            var _local_1:RoomChatItem;
            var _local_2:IWindowContainer;
            var _local_3:int;
            if (this._SafeStr_14163.length == 0){
                return;
            };
            if (this.historyViewerMinimized()){
                this.resetArea();
                this.hideHistoryViewer();
            };
            if (!this.checkLastItemAllowsAdding(this._SafeStr_14163[0])){
                this.selectItemsToMove();
                this.moveItemsUp(this.getItemSpacing(this._itemList[(this._itemList.length - 1)], this._SafeStr_14163[0]));
                if (!this.checkLastItemAllowsAdding(this._SafeStr_14163[0])){
                    this._SafeStr_14162.height = (this._SafeStr_14162.height + _SafeStr_14144);
                    if (this._SafeStr_14171 != null){
                        this._SafeStr_14171.containerResized(this._mainWindow.rectangle);
                    };
                };
            };
            _local_1 = this._SafeStr_14163.shift();
            if (_local_1 != null){
                _local_1.renderView();
                _local_2 = _local_1.view;
                if (_local_2 != null){
                    this._SafeStr_14162.addChild(_local_2);
                    _local_1.timeStamp = new Date().time;
                    this._itemList.push(_local_1);
                    _local_3 = 0;
                    if (this._itemList.length > 1){
                        _local_3 = this._itemList[(this._itemList.length - 2)].screenLevel;
                        if (this.historyViewerActive()){
                            _local_1.screenLevel = (_local_3 + 1);
                        }
                        else {
                            _local_1.screenLevel = (_local_3 + Math.max(this._SafeStr_14167, 1));
                        };
                    }
                    else {
                        _local_1.screenLevel = 100;
                    };
                    _local_1.aboveLevels = this._SafeStr_14167;
                    if (_local_1.aboveLevels > ((_SafeStr_14153 + _SafeStr_14154) + 2)){
                        _local_1.aboveLevels = ((_SafeStr_14153 + _SafeStr_14154) + 2);
                    };
                    this._SafeStr_14167 = 0;
                    this.setChatItemLocHorizontal(_local_1);
                    this.setChatItemLocVertical(_local_1);
                    this.setChatItemRenderable(_local_1);
                };
            };
        }
        private function checkLastItemAllowsAdding(_arg_1:RoomChatItem):Boolean
        {
            if (this._itemList.length == 0){
                return (true);
            };
            var _local_2:RoomChatItem = this._itemList[(this._itemList.length - 1)];
            if ((((_arg_1 == null)) || ((_local_2 == null)))){
                return (false);
            };
            if (_local_2.view == null){
                return (true);
            };
            if ((this._SafeStr_14162.rectangle.bottom - ((this._SafeStr_14162.y + _local_2.y) + _local_2.height)) <= this.getItemSpacing(_local_2, _arg_1)){
                return (false);
            };
            return (true);
        }
        private function alignItems():void
        {
            var _local_1:int;
            var _local_2:RoomChatItem;
            var _local_3:IWindowContainer;
            if (this._SafeStr_14171 == null){
                return;
            };
            _local_1 = (this._itemList.length - 1);
            while (_local_1 >= 0) {
                _local_2 = this._itemList[_local_1];
                if (_local_2 != null){
                    this.setChatItemLocHorizontal(_local_2);
                    this.setChatItemLocVertical(_local_2);
                };
                _local_1--;
            };
            _local_1 = 0;
            while (_local_1 < this._itemList.length) {
                _local_2 = this._itemList[_local_1];
                if (_local_2 != null){
                    this.setChatItemRenderable(_local_2);
                };
                _local_1++;
            };
            _local_1 = 0;
            while (_local_1 < this._SafeStr_14163.length) {
                _local_2 = this._SafeStr_14163[_local_1];
                if (_local_2 != null){
                    this.setChatItemLocHorizontal(_local_2);
                };
                _local_1++;
            };
        }
        private function animationStart():void
        {
            if (this._SafeStr_4426){
                return;
            };
            this.selectItemsToMove();
            this._SafeStr_4426 = true;
        }
        private function animationStop():void
        {
            this._SafeStr_4426 = false;
        }
        private function selectItemsToMove():void
        {
            var _local_4:RoomChatItem;
            if (this._SafeStr_4426){
                return;
            };
            this.purgeItems();
            this._SafeStr_14164 = new Array();
            var _local_1:int = new Date().time;
            var _local_2:int;
            if (this._itemList.length == 0){
                this._SafeStr_14167 = 1;
                return;
            };
            if (this.historyViewerActive()){
                return;
            };
            this._SafeStr_14167++;
            var _local_3:int = (this._itemList.length - 1);
            while (_local_3 >= 0) {
                _local_4 = this._itemList[_local_3];
                if (_local_4.view != null){
                    if ((((((_local_4.screenLevel > _SafeStr_14154)) || ((_local_4.screenLevel == (_local_2 - 1))))) || (((_local_1 - _local_4.timeStamp) >= _SafeStr_14150)))){
                        _local_4.timeStamp = _local_1;
                        _local_2 = _local_4.screenLevel;
                        _local_4.screenLevel--;
                        this._SafeStr_14164.push(_local_4);
                    };
                };
                _local_3--;
            };
        }
        private function moveItemsUp(_arg_1:int):void
        {
            var _local_3:Boolean;
            if (this._SafeStr_14164 == null){
                return;
            };
            if (this._SafeStr_14164.length == 0){
                return;
            };
            var _local_2:RoomChatItem;
            var _local_4:int = -1;
            var _local_5:int = (this._SafeStr_14164.length - 1);
            while (_local_5 >= 0) {
                _local_2 = this._SafeStr_14164[_local_5];
                if (_local_2 != null){
                    if (_local_4 == -1){
                        _local_4 = this._itemList.indexOf(_local_2);
                    }
                    else {
                        _local_4++;
                    };
                    _local_3 = true;
                    if (this.historyViewerActive()){
                        if (((_local_2.y - _arg_1) + _local_2.height) < 0){
                            _local_3 = false;
                        };
                    };
                    if (_local_4 > 0){
                        if (this._itemList[(_local_4 - 1)].view != null){
                            if (((_local_2.y - _arg_1) - this._itemList[(_local_4 - 1)].y) < this.getItemSpacing(this._itemList[(_local_4 - 1)], _local_2)){
                                _local_3 = false;
                            };
                        };
                    };
                    if (_local_3){
                        _local_2.y = (_local_2.y - _arg_1);
                    };
                };
                _local_5--;
            };
        }
        private function setChatItemLocHorizontal(_arg_1:RoomChatItem):void
        {
            var _local_9:Number;
            var _local_10:Number;
            if ((((_arg_1 == null)) || ((this._SafeStr_14171 == null)))){
                return;
            };
            var _local_2:Number = ((_arg_1.senderX + this._SafeStr_14170.x) * this._SafeStr_14168);
            var _local_3:Number = (_local_2 - (_arg_1.width / 2));
            var _local_4:Number = (_local_3 + _arg_1.width);
            var _local_5:Number = (((-(this._mainWindow.width) / 2) - _SafeStr_14146) + this._SafeStr_14176);
            var _local_6:Number = ((((this._mainWindow.width / 2) + _SafeStr_14146) - this._SafeStr_14171.scrollbarWidth) - this._SafeStr_14177);
            var _local_7:Boolean = (((_local_3 >= _local_5)) && ((_local_3 <= _local_6)));
            var _local_8:Boolean = (((_local_4 >= _local_5)) && ((_local_4 <= _local_6)));
            if (((_local_7) && (_local_8))){
                _local_9 = _local_3;
                _local_10 = _local_9;
            }
            else {
                if (_local_2 >= 0){
                    _local_9 = (_local_6 - _arg_1.width);
                }
                else {
                    _local_9 = _local_5;
                };
            };
            _arg_1.x = ((_local_9 + (this._mainWindow.width / 2)) + this._mainWindow.x);
            if ((((_local_2 < _local_5)) || ((_local_2 > _local_6)))){
                _arg_1.hidePointer();
            }
            else {
                _arg_1.setPointerOffset((_local_3 - _local_9));
            };
        }
        private function setChatItemLocVertical(_arg_1:RoomChatItem):void
        {
            var _local_2:int;
            var _local_3:Number;
            var _local_4:Number;
            if (_arg_1 != null){
                _local_2 = this._itemList.indexOf(_arg_1);
                _local_3 = ((this.historyViewerActive()) ? 0 : this._SafeStr_14167);
                if (_local_2 == (this._itemList.length - 1)){
                    _arg_1.y = ((this.getAreaBottom() - ((_local_3 + 1) * _SafeStr_14144)) - _SafeStr_14156);
                }
                else {
                    _local_4 = this._itemList[(_local_2 + 1)].aboveLevels;
                    if (_local_4 < 2){
                        _arg_1.y = (this._itemList[(_local_2 + 1)].y - this.getItemSpacing(_arg_1, this._itemList[(_local_2 + 1)]));
                    }
                    else {
                        _arg_1.y = (this._itemList[(_local_2 + 1)].y - (_local_4 * _SafeStr_14144));
                    };
                };
            };
        }
        private function setChatItemRenderable(_arg_1:RoomChatItem):void
        {
            if (_arg_1 != null){
                if (_arg_1.y < -(_SafeStr_14147)){
                    if (_arg_1.view != null){
                        this._SafeStr_14162.removeChild(_arg_1.view);
                        _arg_1.hideView();
                    };
                }
                else {
                    if (_arg_1.view == null){
                        _arg_1.renderView();
                        if (_arg_1.view != null){
                            this._SafeStr_14162.addChild(_arg_1.view);
                        };
                    };
                };
            };
        }
        public function getTotalContentHeight():int
        {
            var _local_1:RoomChatItem;
            var _local_2:int;
            var _local_3:int;
            while (_local_3 < this._itemList.length) {
                _local_1 = this._itemList[_local_3];
                if (_local_1 != null){
                    if (_local_3 == 0){
                        _local_2 = (_local_2 + _SafeStr_14144);
                    }
                    else {
                        _local_2 = (_local_2 + this.getItemSpacing(this._itemList[(_local_3 - 1)], _local_1));
                    };
                    _local_2 = (_local_2 + ((_local_1.aboveLevels - 1) * _SafeStr_14144));
                };
                _local_3++;
            };
            return (_local_2);
        }
        private function getAreaBottom():Number
        {
            if (this.historyViewerActive()){
                return (this._SafeStr_14162.height);
            };
            return ((this._SafeStr_14174 + this._mainWindow.y));
        }
        private function getItemSpacing(_arg_1:RoomChatItem, _arg_2:RoomChatItem):Number
        {
            if (_arg_1.checkOverlap(_arg_2.x, _arg_1.y, _arg_2.width, _arg_2.height)){
                return (_SafeStr_14144);
            };
            return (_SafeStr_14145);
        }
        private function purgeItems():void
        {
            var _local_2:RoomChatItem;
            if (this.historyViewerActive()){
                return;
            };
            var _local_1:int;
            var _local_3:int;
            while (this._itemList.length > this._SafeStr_14173) {
                _local_2 = this._itemList.shift();
                _local_3 = this._SafeStr_14164.indexOf(_local_2);
                if (_local_3 > -1){
                    this._SafeStr_14164.splice(_local_3, 1);
                };
                if (_local_2.view != null){
                    this._SafeStr_14162.removeChild(_local_2.view);
                    _local_2.hideView();
                };
                _local_2.dispose();
                _local_2 = null;
            };
            var _local_4:Boolean;
            _local_1 = 0;
            while (_local_1 < this._itemList.length) {
                _local_2 = this._itemList[_local_1];
                if (_local_2 != null){
                    if (_local_2.y <= -(_SafeStr_14147)){
                        _local_2.aboveLevels = 1;
                        if (_local_2.view != null){
                            _local_3 = this._SafeStr_14164.indexOf(_local_2);
                            if (_local_3 > -1){
                                this._SafeStr_14164.splice(_local_3, 1);
                            };
                            this._SafeStr_14162.removeChild(_local_2.view);
                            _local_2.hideView();
                        };
                    }
                    else {
                        _local_4 = true;
                        break;
                    };
                };
                _local_1++;
            };
            if (this._SafeStr_14163.length > 0){
                _local_4 = true;
            };
            if ((((((this.getTotalContentHeight() > _SafeStr_14144)) && (!(_local_4)))) && (!(this.historyViewerActive())))){
                if (this._SafeStr_14171 != null){
                    this.stretchAreaBottomTo(this._mainWindow.y);
                    this.alignItems();
                    if (!this.historyViewerActive()){
                        this._SafeStr_14171.showHistoryViewer();
                    };
                    if (!this.historyViewerVisible()){
                        this._SafeStr_14171.visible = true;
                    };
                };
            }
            else {
                if (this.historyViewerVisible()){
                    this._SafeStr_14171.visible = false;
                };
            };
        }
        private function getFreeItemId():String
        {
            return (((("chat_" + this._SafeStr_14165.toString()) + "_item_") + this._SafeStr_14166++.toString()));
        }
        public function onItemMouseClick(_arg_1:int, _arg_2:String, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:WindowMouseEvent):void
        {
            if (_arg_6.shiftKey){
                if (this._SafeStr_14171 != null){
                    this._SafeStr_14171.toggleHistoryViewer();
                };
                return;
            };
            var _local_7:RoomWidgetRoomObjectMessage = new RoomWidgetRoomObjectMessage(RoomWidgetRoomObjectMessage.RWROM_GET_OBJECT_INFO, _arg_1, _arg_3);
            messageListener.processWidgetMessage(_local_7);
            var _local_8:RoomWidgetChatSelectAvatarMessage = new RoomWidgetChatSelectAvatarMessage(RoomWidgetChatSelectAvatarMessage.RWCSAM_MESSAGE_SELECT_AVATAR, _arg_1, _arg_2, _arg_4, _arg_5);
            messageListener.processWidgetMessage(_local_8);
        }
        public function onItemMouseDown(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:WindowMouseEvent):void
        {
            if (this.historyViewerVisible()){
                return;
            };
            if (this._SafeStr_14171 != null){
                this._SafeStr_14171.beginDrag(_arg_5.stageY);
            };
        }
        public function onItemMouseOver(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:WindowMouseEvent):void
        {
        }
        public function onItemMouseOut(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:WindowMouseEvent):void
        {
        }
        public function onPulldownMouseDown(_arg_1:WindowMouseEvent):void
        {
            if (this._SafeStr_14171 != null){
                this._SafeStr_14171.beginDrag(_arg_1.stageY, true);
            };
        }
        public function onPulldownCloseButtonClicked(_arg_1:WindowMouseEvent):void
        {
            if (this._SafeStr_14171 != null){
                this._SafeStr_14171.hideHistoryViewer();
            };
        }
        public function stretchAreaBottomBy(_arg_1:Number):void
        {
            var _local_2:Number = ((this._mainWindow.rectangle.bottom + _arg_1) - RoomChatHistoryPulldown._SafeStr_14178);
            this.stretchAreaBottomTo(_local_2);
        }
        public function stretchAreaBottomTo(_arg_1:Number):void
        {
            var _local_2:int = ((this._mainWindow.context.getDesktopWindow().height - RoomChatHistoryPulldown._SafeStr_14178) - _SafeStr_14157);
            _arg_1 = Math.min(_arg_1, _local_2);
            this._SafeStr_14174 = (_arg_1 - this._mainWindow.y);
            this._mainWindow.height = (this._SafeStr_14174 + RoomChatHistoryPulldown._SafeStr_14178);
            if (this._SafeStr_14171 != null){
                this._SafeStr_14171.containerResized(this._mainWindow.rectangle);
            };
        }
        public function resetArea():void
        {
            if (this._SafeStr_14171 == null){
                return;
            };
            this.animationStop();
            this._SafeStr_14174 = (_SafeStr_14155 + _SafeStr_14156);
            this._mainWindow.height = (this._SafeStr_14174 + this._SafeStr_14171.pulldownBarHeight);
            this._SafeStr_14161.width = (this._mainWindow.width - this._SafeStr_14171.scrollbarWidth);
            this._SafeStr_14161.height = this._SafeStr_14174;
            this._SafeStr_14162.width = (this._mainWindow.width - this._SafeStr_14171.scrollbarWidth);
            if (this.historyViewerActive()){
                this._SafeStr_14162.height = (this.getTotalContentHeight() + _SafeStr_14156);
            }
            else {
                this._SafeStr_14162.height = this._SafeStr_14174;
            };
            this._SafeStr_14161.scrollV = 1;
            if (!this.historyViewerActive()){
                this._SafeStr_14171.containerResized(this._mainWindow.rectangle);
            };
            this.purgeItems();
            this.alignItems();
        }
        private function historyViewerActive():Boolean
        {
            return ((((this._SafeStr_14171)==null) ? false : this._SafeStr_14171.active));
        }
        private function historyViewerVisible():Boolean
        {
            return ((((this._SafeStr_14171)==null) ? false : this._SafeStr_14171.visible));
        }
        public function hideHistoryViewer():void
        {
            if (this._SafeStr_14171 != null){
                this._SafeStr_14171.hideHistoryViewer();
            };
        }
        private function historyViewerMinimized():Boolean
        {
            return ((this._SafeStr_14161.height <= 1));
        }
        public function resizeContainerToLowestItem():void
        {
            var _local_4:RoomChatItem;
            var _local_1:int;
            var _local_2:int;
            while (_local_2 < this._itemList.length) {
                _local_4 = this._itemList[_local_2];
                if (_local_4.y > _local_1){
                    _local_1 = _local_4.y;
                };
                _local_2++;
            };
            _local_2 = 0;
            while (_local_2 < this._SafeStr_14163.length) {
                _local_4 = this._SafeStr_14163[_local_2];
                if (_local_4.y > _local_1){
                    _local_1 = _local_4.y;
                };
                _local_2++;
            };
            _local_1 = (_local_1 + _SafeStr_14147);
            _local_1 = (((_local_1 < 0)) ? 0 : _local_1);
            var _local_3:int = this._mainWindow.rectangle.bottom;
            this.stretchAreaBottomTo((this._mainWindow.rectangle.top + _local_1));
            _local_3 = (_local_3 - this._mainWindow.rectangle.bottom);
            if (Math.abs(_local_3) < RoomChatHistoryViewer._SafeStr_14224){
                this.resetArea();
                return;
            };
            _local_2 = 0;
            while (_local_2 < this._itemList.length) {
                _local_4 = this._itemList[_local_2];
                _local_4.y = (_local_4.y + _local_3);
                _local_2++;
            };
            _local_2 = 0;
            while (_local_2 < this._SafeStr_14163.length) {
                _local_4 = this._SafeStr_14163[_local_2];
                _local_4.y = (_local_4.y + _local_3);
                _local_2++;
            };
            this._SafeStr_14172 = true;
        }
        public function mouseUp():void
        {
            var _local_1:Number = (this._mainWindow.rectangle.bottom - RoomChatHistoryPulldown._SafeStr_14178);
            if (_local_1 < _SafeStr_14155){
                if (_local_1 <= (this._SafeStr_14174 + this._mainWindow.y)){
                    if (this.historyViewerActive()){
                        this.hideHistoryViewer();
                    };
                    this.resetArea();
                    return;
                };
            };
            if (((this._SafeStr_14172) && (!(this.historyViewerActive())))){
                this.resetArea();
                this._SafeStr_14172 = false;
            };
        }
        public function reAlignItemsToHistoryContent():void
        {
            if (this.historyViewerActive()){
                this._SafeStr_14162.height = (this.getTotalContentHeight() + _SafeStr_14156);
                this.alignItems();
            };
        }
        public function enableDragTooltips():void
        {
            var _local_2:int;
            var _local_1:RoomChatItem;
            _local_2 = 0;
            while (_local_2 < this._itemList.length) {
                _local_1 = this._itemList[_local_2];
                _local_1.enableTooltip();
                _local_2++;
            };
            _local_2 = 0;
            while (_local_2 < this._SafeStr_14163.length) {
                _local_1 = this._SafeStr_14163[_local_2];
                _local_1.enableTooltip();
                _local_2++;
            };
        }
        public function disableDragTooltips():void
        {
            var _local_2:int;
            var _local_1:RoomChatItem;
            _local_2 = 0;
            while (_local_2 < this._itemList.length) {
                _local_1 = this._itemList[_local_2];
                _local_1.disableTooltip();
                _local_2++;
            };
            _local_2 = 0;
            while (_local_2 < this._SafeStr_14163.length) {
                _local_1 = this._SafeStr_14163[_local_2];
                _local_1.disableTooltip();
                _local_2++;
            };
        }

    }
}//package com.sulake.habbo.ui.widget.roomchat

// define = "_-19s" (String#5075, DoABC#2)
// RWRVUE_ROOM_VIEW_SIZE_CHANGED = "_-0x5" (String#16316, DoABC#2)
// positionDelta = "_-zM" (String#24667, DoABC#2)
// _SafeStr_14144 = "_-0Qc" (String#15087, DoABC#2)
// _SafeStr_14145 = "_-2tm" (String#21231, DoABC#2)
// _SafeStr_14146 = "_-2v0" (String#21278, DoABC#2)
// _SafeStr_14147 = "_-8d" (String#22565, DoABC#2)
// _SafeStr_14148 = "_-0sm" (String#16152, DoABC#2)
// _SafeStr_14149 = "_-2u" (String#21237, DoABC#2)
// _SafeStr_14150 = "_-0GH" (String#14696, DoABC#2)
// _SafeStr_14151 = "_-2Id" (String#19752, DoABC#2)
// _SafeStr_14152 = "_-2FN" (String#19618, DoABC#2)
// _SafeStr_14153 = "_-Vw" (String#23490, DoABC#2)
// _SafeStr_14154 = "_-2HS" (String#19703, DoABC#2)
// _SafeStr_14155 = "_-1wV" (String#18821, DoABC#2)
// _SafeStr_14156 = "_-2Yi" (String#20384, DoABC#2)
// _SafeStr_14157 = "_-0RX" (String#15121, DoABC#2)
// _SafeStr_14158 = "_-HQ" (String#22910, DoABC#2)
// _SafeStr_14159 = "_-2-i" (String#19001, DoABC#2)
// _mainWindow = "_-Xu" (String#8368, DoABC#2)
// _SafeStr_14161 = "_-0be" (String#15500, DoABC#2)
// _SafeStr_14162 = "_-0rc" (String#16107, DoABC#2)
// _SafeStr_14163 = "_-34b" (String#21682, DoABC#2)
// _SafeStr_14164 = "_-1dL" (String#18028, DoABC#2)
// _SafeStr_14165 = "_-2rp" (String#21147, DoABC#2)
// _SafeStr_14166 = "_-2EQ" (String#19582, DoABC#2)
// _SafeStr_14167 = "_-2k9" (String#20854, DoABC#2)
// _SafeStr_14168 = "_-S8" (String#23330, DoABC#2)
// _SafeStr_14169 = "_-2sm" (String#21190, DoABC#2)
// _SafeStr_14170 = "_-10c" (String#16486, DoABC#2)
// _SafeStr_14171 = "_-186" (String#16781, DoABC#2)
// _SafeStr_14172 = "_-0eH" (String#15597, DoABC#2)
// _SafeStr_14173 = "_-24R" (String#19197, DoABC#2)
// _SafeStr_14174 = "_-2rL" (String#21131, DoABC#2)
// _SafeStr_14175 = "_-0P5" (String#15029, DoABC#2)
// _SafeStr_14176 = "_-26L" (String#19267, DoABC#2)
// _SafeStr_14177 = "_-0fz" (String#15669, DoABC#2)
// _SafeStr_14178 = "_-fB" (String#23854, DoABC#2)
// animationStart = "_-2Kh" (String#19831, DoABC#2)
// moveItemsUp = "_-0aX" (String#15456, DoABC#2)
// animationStop = "_-I3" (String#22932, DoABC#2)
// processBuffer = "_-1SX" (String#17602, DoABC#2)
// onChatMessage = "_-2jg" (String#20833, DoABC#2)
// onRoomViewUpdate = "_-07Z" (String#14348, DoABC#2)
// getFreeItemId = "_-15F" (String#16663, DoABC#2)
// senderX = "_-DB" (String#22736, DoABC#2)
// setChatItemLocHorizontal = "_-wQ" (String#24551, DoABC#2)
// pulldownBarHeight = "_-0S" (String#15135, DoABC#2)
// scrollbarWidth = "_-Pt" (String#23244, DoABC#2)
// historyViewerActive = "_-0PV" (String#15042, DoABC#2)
// reAlignItemsToHistoryContent = "_-0vm" (String#16266, DoABC#2)
// containerResized = "_-7s" (String#22537, DoABC#2)
// alignItems = "_-2GR" (String#19659, DoABC#2)
// activateItemFromBuffer = "_-qF" (String#24282, DoABC#2)
// checkLastItemAllowsAdding = "_-31h" (String#21567, DoABC#2)
// getItemSpacing = "_-OS" (String#23186, DoABC#2)
// historyViewerMinimized = "_-1cz" (String#18012, DoABC#2)
// resetArea = "_-2XN" (String#20337, DoABC#2)
// hideHistoryViewer = "_-ZU" (String#23615, DoABC#2)
// selectItemsToMove = "_-kx" (String#24069, DoABC#2)
// renderView = "_-1xB" (String#18854, DoABC#2)
// setChatItemLocVertical = "_-t-" (String#24405, DoABC#2)
// setChatItemRenderable = "_-0vx" (String#16272, DoABC#2)
// purgeItems = "_-143" (String#16619, DoABC#2)
// hidePointer = "_-35N" (String#21709, DoABC#2)
// setPointerOffset = "_-1n-" (String#18421, DoABC#2)
// getAreaBottom = "_-00b" (String#14079, DoABC#2)
// hideView = "_-29-" (String#19367, DoABC#2)
// getTotalContentHeight = "_-2Kv" (String#19841, DoABC#2)
// checkOverlap = "_-2GV" (String#19661, DoABC#2)
// stretchAreaBottomTo = "_-1F-" (String#17070, DoABC#2)
// showHistoryViewer = "_-39s" (String#21880, DoABC#2)
// historyViewerVisible = "_-Zj" (String#23624, DoABC#2)
// onItemMouseClick = "_-3Dh" (String#22022, DoABC#2)
// toggleHistoryViewer = "_-1DA" (String#16988, DoABC#2)
// onItemMouseDown = "_-Mg" (String#23112, DoABC#2)
// beginDrag = "_-nM" (String#24165, DoABC#2)
// onItemMouseOver = "_-n0" (String#24154, DoABC#2)
// onItemMouseOut = "_-2h3" (String#20729, DoABC#2)
// onPulldownMouseDown = "_-2Am" (String#6263, DoABC#2)
// onPulldownCloseButtonClicked = "_-2zb" (String#21443, DoABC#2)
// stretchAreaBottomBy = "_-1Aa" (String#16882, DoABC#2)
// resizeContainerToLowestItem = "_-1-c" (String#16451, DoABC#2)
// _SafeStr_14224 = "_-1AK" (String#16874, DoABC#2)
// mouseUp = "_-0IF" (String#14768, DoABC#2)
// enableDragTooltips = "_-2-H" (String#18981, DoABC#2)
// enableTooltip = "_-20U" (String#19029, DoABC#2)
// disableDragTooltips = "_-02Z" (String#14145, DoABC#2)
// disableTooltip = "_-1Jb" (String#17262, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// HabboWindowStyle = "_-0E1" (String#14608, DoABC#2)
// HabboWindowType = "_-29U" (String#19384, DoABC#2)
// RoomWidgetBase = "_-0eQ" (String#4398, DoABC#2)
// RoomChatWidget = "_-Yb" (String#8385, DoABC#2)
// RoomWidgetRoomViewUpdateEvent = "_-xx" (String#24612, DoABC#2)
// RoomWidgetChatSelectAvatarMessage = "_-3-" (String#21461, DoABC#2)
// RoomChatHistoryViewer = "_-0ZO" (String#4288, DoABC#2)
// RoomChatHistoryPulldown = "_-0uL" (String#4732, DoABC#2)
// RoomChatItem = "_-2kD" (String#6959, DoABC#2)
// RWCSAM_MESSAGE_SELECT_AVATAR = "_-2R1" (String#20086, DoABC#2)
// RWROM_GET_OBJECT_INFO = "_-cp" (String#23747, DoABC#2)
// registerUpdateEvents = "_-1yD" (String#1787, DoABC#2)
// unregisterUpdateEvents = "_-0-c" (String#3556, DoABC#2)
// _SafeStr_3728 = "_-1IW" (String#5215, DoABC#2)
// _SafeStr_3729 = "_-06z" (String#14322, DoABC#2)
// mainWindow = "_-2Lh" (String#1862, DoABC#2)
// registerUpdateReceiver = "_-35P" (String#7415, DoABC#2)
// _SafeStr_4426 = "_-0wK" (String#594, DoABC#2)
// _SafeStr_4662 = "_-0g1" (String#15673, DoABC#2)
// _itemList = "_-Tp" (String#310, DoABC#2)
// _component = "_-2cU" (String#305, DoABC#2)
// _SafeStr_6023 = "_-Mr" (String#23121, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// RWCUE_EVENT_CHAT = "_-02A" (String#14133, DoABC#2)
// RWRVUE_ROOM_VIEW_POSITION_CHANGED = "_-3Jp" (String#22277, DoABC#2)
// RWRVUE_ROOM_VIEW_SCALE_CHANGED = "_-2ZI" (String#20410, DoABC#2)
// _SafeStr_7469 = "_-4v" (String#22415, DoABC#2)
// _SafeStr_7519 = "_-07K" (String#14339, DoABC#2)
// IUpdateReceiver = "_-Qe" (String#8218, DoABC#2)



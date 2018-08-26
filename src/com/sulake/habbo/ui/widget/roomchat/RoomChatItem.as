
package com.sulake.habbo.ui.widget.roomchat
{
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.display.BitmapData;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChatUpdateEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Rectangle;
    import flash.text.TextFormat;
    import com.sulake.core.window.components.ILabelWindow;
    import com.sulake.core.window.components.ITextWindow;
    import flash.geom.Point;
    import flash.geom.ColorTransform;
    import flash.display.BlendMode;
    import flash.geom.Matrix;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.utils.HabboWebTools;

    public class RoomChatItem 
    {

        private static const _SafeStr_14264:Number = 18;
        private static const _SafeStr_14265:int = 6;
        private static const _SafeStr_14266:int = 6;
        private static const _SafeStr_14267:int = 35;
        private static const _SafeStr_8785:String = "name";
        private static const _SafeStr_10986:String = "message";
        private static const _SafeStr_14268:String = "pointer";
        private static const _SafeStr_3421:String = "background";
        private static var _SafeStr_14269:IRegionWindow;
        private static var _SafeStr_14270:IRegionWindow;
        private static var _SafeStr_14271:IRegionWindow;
        private static var _SafeStr_14272:IRegionWindow;

        private var _widget:RoomChatWidget;
        private var _windowManager:IHabboWindowManager;
        private var _localizations:IHabboLocalizationManager;
        private var _window:IRegionWindow;
        private var _assetLibrary:IAssetLibrary;
        private var _id:String;
        private var _SafeStr_14273:String;
        private var _aboveLevels:int = 0;
        private var _screenLevel:int = -1;
        private var _chatType:int;
        private var _senderId:int;
        private var _senderName:String;
        private var _message:String;
        private var _SafeStr_14276:Array;
        private var _SafeStr_14277:Array;
        private var _timeStamp:int;
        private var _senderX:Number;
        private var _SafeStr_14279:BitmapData;
        private var _SafeStr_14280:uint;
        private var _roomId:int;
        private var _roomCategory:int;
        private var _SafeStr_14281:int;
        private var _width:Number = 0;
        private var _RoomChatItem:Boolean = false;
        private var _SafeStr_14283:Number = 0;
        private var _x:Number = 0;
        private var _y:Number = 0;

        public function RoomChatItem(_arg_1:RoomChatWidget, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary, _arg_4:String, _arg_5:IHabboLocalizationManager, _arg_6:String)
        {
            this._senderName = new String();
            this._message = new String();
            super();
            this._widget = _arg_1;
            this._windowManager = _arg_2;
            this._assetLibrary = _arg_3;
            this._id = _arg_4;
            this._localizations = _arg_5;
            this._SafeStr_14273 = _arg_6;
            if (((((((!(_SafeStr_14271)) || (!(_SafeStr_14270)))) || (!(_SafeStr_14272)))) || (!(_SafeStr_14269)))){
                _SafeStr_14271 = this.buildBubbleWindow("bubble_speak");
                _SafeStr_14270 = this.buildBubbleWindow("bubble_shout");
                _SafeStr_14272 = this.buildBubbleWindow("bubble_whisper");
                _SafeStr_14269 = this.buildBubbleWindow("bubble_whisper");
            };
        }
        private function buildBubbleWindow(_arg_1:String):IRegionWindow
        {
            var _local_2:IRegionWindow = (this._windowManager.buildFromXML((this._assetLibrary.getAssetByName(_arg_1).content as XML), 1) as IRegionWindow);
            _local_2.tags.push("roomchat_bubble");
            _local_2.x = 0;
            _local_2.y = 0;
            _local_2.width = 0;
            _local_2.background = true;
            _local_2.mouseThreshold = 0;
            _local_2.setParamFlag(WindowParam.WINDOW_PARAM_FORCE_CLIPPING, true);
            return (_local_2);
        }
        public function dispose():void
        {
            if (this._window != null){
                this._window.dispose();
                this._window = null;
                this._widget = null;
                this._windowManager = null;
                this._localizations = null;
                this._SafeStr_14279 = null;
            };
        }
        public function define(_arg_1:RoomWidgetChatUpdateEvent):void
        {
            this._chatType = _arg_1.chatType;
            this._senderId = _arg_1.userId;
            this._senderName = _arg_1.userName;
            this._SafeStr_14281 = _arg_1.userCategory;
            this._message = _arg_1.text;
            this._SafeStr_14276 = _arg_1.links;
            this._senderX = _arg_1.userX;
            this._SafeStr_14279 = _arg_1.userImage;
            this._SafeStr_14280 = _arg_1.userColor;
            this._roomId = _arg_1.roomId;
            this._roomCategory = _arg_1.roomCategory;
            this.renderView();
        }
        public function get view():IWindowContainer
        {
            return (this._window);
        }
        public function get screenLevel():int
        {
            return (this._screenLevel);
        }
        public function get timeStamp():int
        {
            return (this._timeStamp);
        }
        public function get senderX():Number
        {
            return (this._senderX);
        }
        public function set senderX(_arg_1:Number):void
        {
            this._senderX = _arg_1;
        }
        public function get width():Number
        {
            return (this._width);
        }
        public function get height():Number
        {
            return (_SafeStr_14264);
        }
        public function get message():String
        {
            return (this._message);
        }
        public function get x():Number
        {
            return (this._x);
        }
        public function get y():Number
        {
            return (this._y);
        }
        public function get aboveLevels():int
        {
            return (this._aboveLevels);
        }
        public function set aboveLevels(_arg_1:int):void
        {
            this._aboveLevels = _arg_1;
        }
        public function set screenLevel(_arg_1:int):void
        {
            this._screenLevel = _arg_1;
        }
        public function set timeStamp(_arg_1:int):void
        {
            this._timeStamp = _arg_1;
        }
        public function set x(_arg_1:Number):void
        {
            this._x = _arg_1;
            if (this._window != null){
                this._window.x = _arg_1;
            };
        }
        public function set y(_arg_1:Number):void
        {
            this._y = _arg_1;
            if (this._window != null){
                this._window.y = (_arg_1 - this._SafeStr_14283);
            };
        }
        public function RoomChatItem():void
        {
            if (this._window){
                this._window.findChildByName("pointer").visible = false;
            };
        }
        public function RoomChatItem(_arg_1:Number):void
        {
            if (((!(this._window)) || (this._window.disposed))){
                return;
            };
            var _local_2:IBitmapWrapperWindow = (this._window.findChildByName("pointer") as IBitmapWrapperWindow);
            var _local_3:IBitmapWrapperWindow = (this._window.findChildByName("middle") as IBitmapWrapperWindow);
            if ((((_local_3 == null)) || ((_local_2 == null)))){
                return;
            };
            _local_2.visible = true;
            _arg_1 = (_arg_1 + (this._window.width / 2));
            _arg_1 = Math.min(_arg_1, (_local_3.rectangle.right - _local_2.width));
            _arg_1 = Math.max(_arg_1, _local_3.rectangle.left);
            _local_2.x = _arg_1;
        }
        public function RoomChatItem(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):Boolean
        {
            var _local_5:Rectangle = new Rectangle(this._x, this._y, this.width, _SafeStr_14264);
            var _local_6:Rectangle = new Rectangle(_arg_1, _arg_2, _arg_3, _arg_4);
            return (_local_5.intersects(_local_6));
        }
        public function RoomChatItem():void
        {
            if (this._window){
                this._window.dispose();
            };
            this._window = null;
            this._RoomChatItem = false;
        }
        public function renderView():void
        {
            var messageWidth:int;
            var x1:int;
            var y1:int;
            var userIconWindow:IBitmapWrapperWindow;
            var i:int;
            var lastLinkEndPos:int;
            var linkFormat:TextFormat;
            var filteredLink:String;
            var placeHolder:String;
            var placeholderPos:int;
            var linkPos:Array;
            if (this._RoomChatItem){
                return;
            };
            this._RoomChatItem = true;
            if (this._window){
                return;
            };
            var isRespect:Boolean;
            switch (this._chatType){
                case RoomWidgetChatUpdateEvent._SafeStr_3620:
                    this._window = (_SafeStr_14271.clone() as IRegionWindow);
                    break;
                case RoomWidgetChatUpdateEvent._SafeStr_3621:
                    this._window = (_SafeStr_14272.clone() as IRegionWindow);
                    break;
                case RoomWidgetChatUpdateEvent._SafeStr_3622:
                    this._window = (_SafeStr_14270.clone() as IRegionWindow);
                    break;
                case RoomWidgetChatUpdateEvent._SafeStr_4788:
                    this._window = (_SafeStr_14269.clone() as IRegionWindow);
                    isRespect = true;
                    break;
                case RoomWidgetChatUpdateEvent._SafeStr_4789:
                    this._window = (_SafeStr_14269.clone() as IRegionWindow);
                    isRespect = true;
                    break;
            };
            var background:IBitmapWrapperWindow = (this._window.findChildByName(_SafeStr_3421) as IBitmapWrapperWindow);
            var nameWindow:ILabelWindow = (this._window.findChildByName(_SafeStr_8785) as ILabelWindow);
            var textWindow:ITextWindow = (this._window.findChildByName(_SafeStr_10986) as ITextWindow);
            var pointerWindow:IBitmapWrapperWindow = (this._window.findChildByName(_SafeStr_14268) as IBitmapWrapperWindow);
            var pointerBitmapData:BitmapData = (this._assetLibrary.getAssetByName("chat_bubble_pointer").content as BitmapData);
            var totalHeight:Number = this._window.height;
            var topOffset:int;
            if (this._SafeStr_14279 != null){
                topOffset = Math.max(0, ((this._SafeStr_14279.height - background.height) / 2));
                totalHeight = Math.max(totalHeight, this._SafeStr_14279.height);
            };
            this._width = 0;
            this._window.x = this._x;
            this._window.y = this._y;
            this._window.width = 0;
            this._window.height = totalHeight;
            this.enableTooltip();
            this.addEventListeners(this._window);
            if (((this._SafeStr_14279) && (!(isRespect)))){
                x1 = (14 - (this._SafeStr_14279.width / 2));
                y1 = Math.max(0, ((background.height - this._SafeStr_14279.height) / 2));
                userIconWindow = (this._window.findChildByName("user_image") as IBitmapWrapperWindow);
                if (userIconWindow){
                    userIconWindow.width = this._SafeStr_14279.width;
                    userIconWindow.height = this._SafeStr_14279.height;
                    userIconWindow.bitmap = this._SafeStr_14279;
                    userIconWindow.disposesBitmap = false;
                    userIconWindow.x = x1;
                    userIconWindow.y = y1;
                    this._SafeStr_14283 = Math.max(0, ((this._SafeStr_14279.height - background.height) / 2));
                    this._width = (this._width + (userIconWindow.x + this._SafeStr_14279.width));
                };
            };
            if (nameWindow != null){
                if (!isRespect){
                    nameWindow.text = (this._senderName + ": ");
                    nameWindow.y = (nameWindow.y + this._SafeStr_14283);
                    nameWindow.width = (nameWindow.textWidth + _SafeStr_14265);
                }
                else {
                    nameWindow.text = "";
                    nameWindow.width = 0;
                };
                this._width = (this._width + nameWindow.width);
            };
            if (this._chatType == RoomWidgetChatUpdateEvent._SafeStr_4788){
                textWindow.text = this._localizations.registerParameter("widgets.chatbubble.respect", "username", this._senderName);
                this._width = _SafeStr_14267;
            }
            else {
                if (this._chatType == RoomWidgetChatUpdateEvent._SafeStr_4789){
                    textWindow.text = this._localizations.registerParameter("widget.chatbubble.petrespect", "petname", this._senderName);
                    this._width = _SafeStr_14267;
                }
                else {
                    if (this._SafeStr_14276 == null){
                        textWindow.text = this.message;
                    }
                    else {
                        this._SafeStr_14277 = new Array();
                        lastLinkEndPos = -1;
                        i = 0;
                        while (i < this._SafeStr_14276.length) {
                            filteredLink = this._SafeStr_14276[i][1];
                            placeHolder = (("{" + i) + "}");
                            placeholderPos = this._message.indexOf(placeHolder);
                            lastLinkEndPos = (placeholderPos + filteredLink.length);
                            this._SafeStr_14277.push([placeholderPos, lastLinkEndPos]);
                            this._message = this._message.replace(placeHolder, filteredLink);
                            i = (i + 1);
                        };
                        textWindow.text = this.message;
                        textWindow.immediateClickMode = true;
                        textWindow.setParamFlag(WindowParam._SafeStr_7443, false);
                        textWindow.setParamFlag(WindowParam.WINDOW_PARAM_FORCE_CLIPPING, true);
                        linkFormat = textWindow.getTextFormat();
                        linkFormat.color = 2710438;
                        linkFormat.underline = true;
                        i = 0;
                        while (i < this._SafeStr_14277.length) {
                            linkPos = this._SafeStr_14277[i];
                            try {
                                textWindow.setTextFormat(linkFormat, linkPos[0], linkPos[1]);
                            }
                            catch(e:RangeError) {
                                Logger.log("Chat message links were malformed. Could not set TextFormat");
                            };
                            i = (i + 1);
                        };
                    };
                };
            };
            if (textWindow.visible){
                textWindow.x = this._width;
                if (nameWindow != null){
                    textWindow.x = (nameWindow.x + nameWindow.width);
                    if (nameWindow.width > _SafeStr_14265){
                        textWindow.x = (textWindow.x - (_SafeStr_14265 - 1));
                    };
                };
                textWindow.y = (textWindow.y + this._SafeStr_14283);
                messageWidth = textWindow.textWidth;
                textWindow.width = (messageWidth + _SafeStr_14266);
                this._width = (this._width + textWindow.width);
            };
            if (((!((pointerWindow == null))) && (pointerWindow.visible))){
                pointerWindow.bitmap = pointerBitmapData;
                pointerWindow.disposesBitmap = false;
                pointerWindow.x = (this._width / 2);
                pointerWindow.y = (pointerWindow.y + this._SafeStr_14283);
            };
            var bitmap:BitmapData = this.buildBubbleImage((nameWindow.width + textWindow.width), background.height, this._SafeStr_14280, isRespect);
            this._window.width = bitmap.width;
            this._window.y = (this._window.y - this._SafeStr_14283);
            this._width = this._window.width;
            background.bitmap = bitmap;
            background.y = this._SafeStr_14283;
        }
        private function buildBubbleImage(_arg_1:int, _arg_2:int, _arg_3:uint, _arg_4:Boolean):BitmapData
        {
            var _local_13:BitmapData;
            var _local_14:uint;
            var _local_15:uint;
            var _local_16:uint;
            var _local_5:BitmapData = (this._assetLibrary.getAssetByName("chat_bubble_left").content as BitmapData);
            var _local_6:BitmapData = (this._assetLibrary.getAssetByName("chat_bubble_middle").content as BitmapData);
            var _local_7:BitmapData = (this._assetLibrary.getAssetByName("chat_bubble_left_color").content as BitmapData);
            var _local_8:BitmapData = (this._assetLibrary.getAssetByName("chat_bubble_right").content as BitmapData);
            var _local_9:int;
            var _local_10:Point = new Point();
            var _local_11:BitmapData = new BitmapData(((_local_5.width + _arg_1) + _local_8.width), _arg_2, true, 0xFF00FF);
            _local_9 = (_local_9 + _local_5.width);
            _local_11.copyPixels(_local_5, _local_5.rect, _local_10);
            if (_arg_4){
                _local_13 = (this._assetLibrary.getAssetByName("chat_bubble_left_gen").content as BitmapData);
                _local_11.copyPixels(_local_13, _local_13.rect, _local_10, null, null, true);
            }
            else {
                _local_14 = 232;
                _local_15 = 177;
                _local_16 = 55;
                if (_arg_3 != 0){
                    _local_14 = ((_arg_3 >> 16) & 0xFF);
                    _local_15 = ((_arg_3 >> 8) & 0xFF);
                    _local_16 = ((_arg_3 >> 0) & 0xFF);
                };
                _local_11.draw(_local_7, null, new ColorTransform((_local_14 / 0xFF), (_local_15 / 0xFF), (_local_16 / 0xFF)), BlendMode.DARKEN);
            };
            var _local_12:Matrix = new Matrix();
            _local_12.scale((_arg_1 / _local_6.width), 1);
            _local_12.translate(_local_9, 0);
            _local_11.draw(_local_6, _local_12);
            _local_9 = (_local_9 + _arg_1);
            _local_10.x = _local_9;
            _local_11.copyPixels(_local_8, _local_8.rect, _local_10);
            _local_9 = (_local_9 + _local_8.width);
            return (_local_11);
        }
        public function enableTooltip():void
        {
            if (this._window != null){
                this._window.toolTipCaption = "${chat.history.drag.tooltip}";
                this._window.toolTipDelay = 500;
            };
        }
        public function disableTooltip():void
        {
            if (this._window != null){
                this._window.toolTipCaption = "";
            };
        }
        private function addEventListeners(_arg_1:IWindowContainer):void
        {
            _arg_1.setParamFlag(HabboWindowParam._SafeStr_3731, true);
            _arg_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onBubbleMouseClick);
            _arg_1.addEventListener(WindowMouseEvent.WME_DOWN, this.onBubbleMouseDown);
            _arg_1.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onBubbleMouseOver);
            _arg_1.addEventListener(WindowMouseEvent.WME_OUT, this.onBubbleMouseOut);
            _arg_1.addEventListener(WindowMouseEvent.WME_UP, this.onBubbleMouseUp);
        }
        private function testMessageLinkMouseClick(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_5:int;
            var _local_3:ITextWindow = (this._window.getChildByName(_SafeStr_10986) as ITextWindow);
            var _local_4:int = _local_3.getCharIndexAtPoint((_arg_1 - _local_3.x), (_arg_2 - _local_3.y));
            if (_local_4 > -1){
                _local_5 = 0;
                while (_local_5 < this._SafeStr_14277.length) {
                    if ((((_local_4 >= this._SafeStr_14277[_local_5][0])) && ((_local_4 <= this._SafeStr_14277[_local_5][1])))){
                        if (this._SafeStr_14276[_local_5][2] == 0){
                            HabboWebTools.openExternalLinkWarning(this._SafeStr_14276[_local_5][0]);
                        }
                        else {
                            if (this._SafeStr_14276[_local_5][2] == 1){
                                HabboWebTools.HTMLTextController((this._SafeStr_14273 + this._SafeStr_14276[_local_5][0]), "habboMain");
                            }
                            else {
                                HabboWebTools.HTMLTextController((this._SafeStr_14273 + this._SafeStr_14276[_local_5][0]));
                            };
                        };
                        return (true);
                    };
                    _local_5++;
                };
            };
            return (false);
        }
        private function onBubbleMouseClick(_arg_1:WindowMouseEvent):void
        {
            if (((this._SafeStr_14276) && ((this._SafeStr_14276.length > 0)))){
                if (this.testMessageLinkMouseClick(_arg_1.localX, _arg_1.localY)){
                    return;
                };
            };
            this._widget.RoomChatWidget(this._senderId, this._senderName, this._SafeStr_14281, this._roomId, this._roomCategory, _arg_1);
        }
        private function onBubbleMouseDown(_arg_1:WindowMouseEvent):void
        {
            this._widget.RoomChatWidget(this._senderId, this._SafeStr_14281, this._roomId, this._roomCategory, _arg_1);
        }
        private function onBubbleMouseOver(_arg_1:WindowMouseEvent):void
        {
            this._widget.RoomChatWidget(this._senderId, this._SafeStr_14281, this._roomId, this._roomCategory, _arg_1);
        }
        private function onBubbleMouseOut(_arg_1:WindowMouseEvent):void
        {
            this._widget.RoomChatWidget(this._senderId, this._SafeStr_14281, this._roomId, this._roomCategory, _arg_1);
        }
        private function onBubbleMouseUp(_arg_1:WindowMouseEvent):void
        {
            this._widget.RoomChatWidget();
        }

    }
}//package com.sulake.habbo.ui.widget.roomchat

// _senderName = "_-1oU" (String#5831, DoABC#2)
// _SafeStr_10986 = "_-34f" (String#629, DoABC#2)
// define = "_-19s" (String#5075, DoABC#2)
// HabboWebTools = "_-2pX" (String#21059, DoABC#2)
// userCategory = "_-1Fd" (String#17100, DoABC#2)
// userImage = "_-tl" (String#24438, DoABC#2)
// userColor = "_-lM" (String#24081, DoABC#2)
// senderX = "_-DB" (String#22736, DoABC#2)
// renderView = "_-1xB" (String#18854, DoABC#2)
// RoomChatItem = "_-35N" (String#21709, DoABC#2)
// RoomChatItem = "_-1n-" (String#18421, DoABC#2)
// RoomChatItem = "_-29-" (String#19367, DoABC#2)
// RoomChatItem = "_-2GV" (String#19661, DoABC#2)
// RoomChatWidget = "_-3Dh" (String#22022, DoABC#2)
// RoomChatWidget = "_-Mg" (String#23112, DoABC#2)
// RoomChatWidget = "_-n0" (String#24154, DoABC#2)
// RoomChatWidget = "_-2h3" (String#20729, DoABC#2)
// RoomChatWidget = "_-0IF" (String#14768, DoABC#2)
// enableTooltip = "_-20U" (String#19029, DoABC#2)
// disableTooltip = "_-1Jb" (String#17262, DoABC#2)
// _SafeStr_14264 = "_-X9" (String#23528, DoABC#2)
// _SafeStr_14265 = "_-Ph" (String#23234, DoABC#2)
// _SafeStr_14266 = "_-2t3" (String#21202, DoABC#2)
// _SafeStr_14267 = "_-1YG" (String#17826, DoABC#2)
// _SafeStr_14268 = "_-141" (String#16617, DoABC#2)
// _SafeStr_14269 = "_-1Hd" (String#17175, DoABC#2)
// _SafeStr_14270 = "_-0N2" (String#14959, DoABC#2)
// _SafeStr_14271 = "_-0OH" (String#15000, DoABC#2)
// _SafeStr_14272 = "_-0qD" (String#16058, DoABC#2)
// _SafeStr_14273 = "_-0JC" (String#14809, DoABC#2)
// _aboveLevels = "_-18t" (String#16809, DoABC#2)
// _screenLevel = "_-tz" (String#24448, DoABC#2)
// _SafeStr_14276 = "_-0R9" (String#15108, DoABC#2)
// _SafeStr_14277 = "_-2oN" (String#21019, DoABC#2)
// _senderX = "_-3LX" (String#22347, DoABC#2)
// _SafeStr_14279 = "_-UN" (String#23425, DoABC#2)
// _SafeStr_14280 = "_-tn" (String#24439, DoABC#2)
// _SafeStr_14281 = "_-2ff" (String#20678, DoABC#2)
// _RoomChatItem = "_-dy" (String#23800, DoABC#2)
// _SafeStr_14283 = "_-6o" (String#22491, DoABC#2)
// buildBubbleWindow = "_-2kL" (String#20859, DoABC#2)
// addEventListeners = "_-1pc" (String#18531, DoABC#2)
// buildBubbleImage = "_-1eV" (String#18077, DoABC#2)
// onBubbleMouseClick = "_-2Pk" (String#20033, DoABC#2)
// onBubbleMouseDown = "_-0b9" (String#15482, DoABC#2)
// onBubbleMouseOver = "_-0J" (String#14798, DoABC#2)
// onBubbleMouseOut = "_-0go" (String#15701, DoABC#2)
// onBubbleMouseUp = "_-2O3" (String#19967, DoABC#2)
// testMessageLinkMouseClick = "_-EH" (String#22782, DoABC#2)
// HabboWindowParam = "_-29D" (String#6233, DoABC#2)
// IRegionWindow = "_-dg" (String#2146, DoABC#2)
// RoomChatWidget = "_-Yb" (String#8385, DoABC#2)
// RoomChatItem = "_-2kD" (String#6959, DoABC#2)
// _SafeStr_3421 = "_-0BR" (String#1420, DoABC#2)
// _SafeStr_3620 = "_-xF" (String#24578, DoABC#2)
// _SafeStr_3621 = "_-0Bz" (String#14526, DoABC#2)
// _SafeStr_3622 = "_-0O5" (String#14992, DoABC#2)
// _chatType = "_-0Dp" (String#812, DoABC#2)
// chatType = "_-TQ" (String#23382, DoABC#2)
// _SafeStr_3731 = "_-B" (String#22654, DoABC#2)
// _width = "_-0Uq" (String#92, DoABC#2)
// WME_OUT = "_-0h2" (String#15712, DoABC#2)
// WME_DOWN = "_-hL" (String#23944, DoABC#2)
// WME_UP = "_-0Cs" (String#14566, DoABC#2)
// _y = "_-02f" (String#64, DoABC#2)
// HTMLTextController = "_-27c" (String#6194, DoABC#2)
// _senderId = "_-31K" (String#909, DoABC#2)
// openExternalLinkWarning = "_-9C" (String#22588, DoABC#2)
// _SafeStr_4788 = "_-1rK" (String#18597, DoABC#2)
// _SafeStr_4789 = "_-2ut" (String#21273, DoABC#2)
// _localizations = "_-0il" (String#358, DoABC#2)
// mouseThreshold = "_-0OA" (String#4051, DoABC#2)
// disposesBitmap = "_-03U" (String#3637, DoABC#2)
// _timeStamp = "_-1IA" (String#845, DoABC#2)
// toolTipCaption = "_-0cC" (String#4347, DoABC#2)
// _SafeStr_7443 = "_-0YX" (String#15382, DoABC#2)
// _SafeStr_8785 = "_-1OX" (String#605, DoABC#2)
// toolTipDelay = "_-2W1" (String#6685, DoABC#2)



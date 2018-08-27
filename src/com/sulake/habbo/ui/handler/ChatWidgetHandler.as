
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.avatar.IPetImageListener;
    import com.sulake.habbo.avatar.IAvatarImageListener;
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.core.utils.Map;
    import com.sulake.core.communication.connection.IConnection;
    import flash.geom.Point;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import flash.display.BitmapData;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChatMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetChatSelectAvatarMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
    import com.sulake.habbo.session.IUserData;
    import com.sulake.habbo.session.SecurityLevelEnum;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import flash.external.ExternalInterface;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.events.RoomSessionChatEvent;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.utils.IRoomGeometry;
    import com.sulake.room.utils.IVector3d;
    import com.sulake.habbo.avatar.IAvatarImage;
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import flash.events.Event;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.room.object.RoomObjectTypeEnum;
    import com.sulake.habbo.avatar.enum.AvatarScaleType;
    import com.sulake.habbo.avatar.enum.AvatarSetType;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChatUpdateEvent;
    import com.sulake.habbo.ui.widget.events.RoomWidgetRoomViewUpdateEvent;
    import com.sulake.room.utils.RoomGeometry;
    import com.sulake.room.utils.PointMath;
    import com.sulake.habbo.room.ImageResult;

    public class ChatWidgetHandler implements IRoomWidgetHandler, IPetImageListener, IAvatarImageListener, IGetImageListener 
    {

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _SafeStr_7230:Map = null;
        private var _SafeStr_7231:Map = null;
        private var _SafeStr_7232:Map = null;
        private var _SafeStr_7233:Map = null;
        private var _SafeStr_7234:Array;
        private var _connection:IConnection = null;
        private var _SafeStr_7235:Number = 0;
        private var _SafeStr_7236:Point = null;
        private var _SafeStr_7237:Vector3d;

        public function ChatWidgetHandler()
        {
            this._SafeStr_7234 = [];
            this._SafeStr_7237 = new Vector3d();
            super();
            this._SafeStr_7230 = new Map();
            this._SafeStr_7231 = new Map();
            this._SafeStr_7232 = new Map();
            this._SafeStr_7233 = new Map();
        }
        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWE_CHAT_WIDGET);
        }
        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            this._container = _arg_1;
        }
        public function set connection(_arg_1:IConnection):void
        {
            this._connection = _arg_1;
        }
        public function dispose():void
        {
            var _local_1:int;
            var _local_2:BitmapData;
            var _local_3:BitmapData;
            this._disposed = true;
            this._container = null;
            this._SafeStr_7236 = null;
            if (this._SafeStr_7230 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_7230.length) {
                    _local_2 = (this._SafeStr_7230.getWithIndex(_local_1) as BitmapData);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._SafeStr_7230.dispose();
                this._SafeStr_7230 = null;
            };
            if (this._SafeStr_7231 != null){
                _local_1 = 0;
                while (_local_1 < this._SafeStr_7231.length) {
                    _local_2 = (this._SafeStr_7231.getWithIndex(_local_1) as BitmapData);
                    if (_local_2 != null){
                        _local_2.dispose();
                    };
                    _local_1++;
                };
                this._SafeStr_7231.dispose();
                this._SafeStr_7231 = null;
            };
            for each (_local_3 in this._SafeStr_7234) {
                if (_local_3 != null){
                    _local_3.dispose();
                };
            };
            this._SafeStr_7234 = [];
            if (this._SafeStr_7232 != null){
                this._SafeStr_7232.dispose();
                this._SafeStr_7232 = null;
            };
        }
        public function getWidgetMessages():Array
        {
            return ([RoomWidgetChatMessage.RWCM_MESSAGE_CHAT, RoomWidgetChatSelectAvatarMessage.RWCSAM_MESSAGE_SELECT_AVATAR]);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetChatSelectAvatarMessage;
            var _local_3:RoomWidgetChatMessage;
            var _local_4:RoomWidgetRequestWidgetMessage;
            var _local_5:Array;
            var _local_6:String;
            var _local_7:String;
            var _local_8:int;
            var _local_9:IUserData;
            var _local_10:IUserData;
            switch (_arg_1.type){
                case RoomWidgetChatMessage.RWCM_MESSAGE_CHAT:
                    if (((!((this._container == null))) && (!((this._container.roomSession == null))))){
                        _local_3 = (_arg_1 as RoomWidgetChatMessage);
                        if (_local_3 != null){
                            if (_local_3.text == ""){
                                return (null);
                            };
                            _local_4 = null;
                            _local_5 = _local_3.text.split(" ");
                            if (_local_5.length > 0){
                                _local_6 = _local_5[0];
                                _local_7 = "";
                                if (_local_5.length > 1){
                                    _local_7 = _local_5[1];
                                };
                                if ((((_local_6.charAt(0) == ":")) && ((_local_7 == "x")))){
                                    _local_8 = this._container.roomEngine.getSelectedAvatarId();
                                    if (_local_8 > -1){
                                        _local_9 = this._container.roomSession.userDataManager.getUserDataByIndex(_local_8);
                                        if (_local_9 != null){
                                            this._container.roomSession.sendChatMessage(_local_3.text.replace(" x", (" " + _local_9.name)));
                                            return (null);
                                        };
                                    };
                                };
                                switch (_local_6.toLowerCase()){
                                    case "o/":
                                        this._container.roomSession.sendWaveMessage();
                                        return (null);
                                    case ":sign":
                                        this._container.roomSession.sendSignMessage(int(_local_7));
                                        return (null);
                                    case ":chooser":
                                        if (((this._container.sessionDataManager.hasUserRight("fuse_habbo_chooser", HabboClubLevelEnum._SafeStr_3943)) || (this._container.sessionDataManager.hasSecurity(SecurityLevelEnum._SafeStr_7243)))){
                                            _local_4 = new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.RWRWM_USER_CHOOSER);
                                            this._container.processWidgetMessage(_local_4);
                                        };
                                        return (null);
                                    case ":furni":
                                        if (((this._container.sessionDataManager.hasUserRight("fuse_furni_chooser", HabboClubLevelEnum._SafeStr_3943)) || (this._container.sessionDataManager.hasSecurity(SecurityLevelEnum._SafeStr_7243)))){
                                            _local_4 = new RoomWidgetRequestWidgetMessage(RoomWidgetRequestWidgetMessage.RWRWM_FURNI_CHOOSER);
                                            this._container.processWidgetMessage(_local_4);
                                        };
                                        return (null);
                                    case ":pickall":
                                        this._container.sessionDataManager.pickAllFurniture(this._container.roomSession.roomId, this._container.roomSession.roomCategory);
                                        return (null);
                                    case ":news":
                                        if (ExternalInterface.available){
                                            ExternalInterface.call("FlashExternalInterface.openHabblet", "news");
                                        };
                                        return (null);
                                };
                            };
                            switch (_local_3.chatType){
                                case RoomWidgetChatMessage._SafeStr_3620:
                                    this._container.roomSession.sendChatMessage(_local_3.text);
                                    break;
                                case RoomWidgetChatMessage._SafeStr_3622:
                                    this._container.roomSession.sendShoutMessage(_local_3.text);
                                    break;
                                case RoomWidgetChatMessage._SafeStr_3621:
                                    this._container.roomSession.sendWhisperMessage(_local_3.recipientName, _local_3.text);
                                    break;
                            };
                        };
                    };
                    break;
                case RoomWidgetChatSelectAvatarMessage.RWCSAM_MESSAGE_SELECT_AVATAR:
                    _local_2 = (_arg_1 as RoomWidgetChatSelectAvatarMessage);
                    if (_local_2 != null){
                        this._container.roomEngine.selectAvatar(_local_2.roomId, _local_2.roomCategory, _local_2.objectId);
                        _local_10 = this._container.roomSession.userDataManager.getUserDataByIndex(_local_2.objectId);
                        if (_local_10 != null){
                            this._container.moderation.userSelected(_local_10.webID, _local_2.userName);
                        };
                    };
                    break;
            };
            return (null);
        }
        public function getProcessedEvents():Array
        {
            return ([RoomSessionChatEvent.RSCE_CHAT_EVENT]);
        }
        public function processEvent(_arg_1:Event):void
        {
            var _local_3:RoomSessionChatEvent;
            var _local_4:IRoomObject;
            var _local_5:IRoomGeometry;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:IVector3d;
            var _local_9:Point;
            var _local_10:IUserData;
            var _local_11:String;
            var _local_12:uint;
            var _local_13:BitmapData;
            var _local_14:String;
            var _local_15:Point;
            var _local_16:String;
            var _local_17:IAvatarImage;
            var _local_18:IPartColor;
            var _local_2:Event;
            switch (_arg_1.type){
                case RoomSessionChatEvent.RSCE_CHAT_EVENT:
                    _local_3 = (_arg_1 as RoomSessionChatEvent);
                    if (_local_3 != null){
                        _local_4 = this._container.roomEngine.getRoomObject(_local_3.session.roomId, _local_3.session.roomCategory, _local_3.userId, RoomObjectCategoryEnum.OBJECT_CATEGORY_USER);
                        if (_local_4 != null){
                            _local_5 = this._container.roomEngine.getRoomCanvasGeometry(_local_3.session.roomId, _local_3.session.roomCategory, this._container.getFirstCanvasId());
                            if (_local_5 != null){
                                this.updateWidgetPosition();
                                _local_6 = 0;
                                _local_7 = 0;
                                _local_8 = _local_4.getLocation();
                                _local_9 = _local_5.getScreenPoint(_local_8);
                                if (_local_9 != null){
                                    _local_6 = _local_9.x;
                                    _local_7 = _local_9.y;
                                    _local_15 = this._container.roomEngine.getRoomCanvasScreenOffset(_local_3.session.roomId, _local_3.session.roomCategory, this._container.getFirstCanvasId());
                                    if (_local_15 != null){
                                        _local_6 = (_local_6 + _local_15.x);
                                        _local_7 = (_local_7 + _local_15.y);
                                    };
                                };
                                _local_10 = this._container.roomSession.userDataManager.getUserDataByIndex(_local_3.userId);
                                _local_11 = "";
                                _local_12 = 0;
                                _local_13 = null;
                                if (_local_10 != null){
                                    _local_16 = _local_10.figure;
                                    if (_local_10.type == RoomObjectTypeEnum._SafeStr_3747){
                                        _local_13 = (this._SafeStr_7231.getValue(this.getPetFigureString(_local_16)) as BitmapData);
                                    }
                                    else {
                                        _local_13 = (this._SafeStr_7230.getValue(_local_16) as BitmapData);
                                    };
                                    _local_12 = this._SafeStr_7232.getValue(_local_16);
                                    if (_local_13 == null){
                                        if (this._container.avatarRenderManager != null){
                                            switch (_local_10.type){
                                                case RoomObjectTypeEnum._SafeStr_3747:
                                                    _local_13 = this.getPetImage(_local_16);
                                                    _local_12 = this._SafeStr_7232.getValue(_local_16);
                                                    break;
                                                default:
                                                    _local_17 = this._container.avatarRenderManager.createAvatarImage(_local_16, AvatarScaleType._SafeStr_4337, null, this);
                                                    if (_local_17 != null){
                                                        _local_13 = _local_17.getCroppedImage(AvatarSetType._SafeStr_4458);
                                                        _local_18 = _local_17.getPartColor("ch");
                                                        _local_17.dispose();
                                                        if (_local_18 != null){
                                                            _local_12 = _local_18.rgb;
                                                            this._SafeStr_7232.add(_local_16, _local_12);
                                                        };
                                                    };
                                            };
                                            if (_local_13 != null){
                                                if (_local_10.type == RoomObjectTypeEnum._SafeStr_3747){
                                                    this._SafeStr_7231.add(this.getPetFigureString(_local_16), _local_13);
                                                }
                                                else {
                                                    this._SafeStr_7230.add(_local_16, _local_13);
                                                };
                                            };
                                        };
                                    };
                                    _local_11 = _local_10.name;
                                };
                                _local_14 = RoomWidgetChatUpdateEvent.RWCUE_EVENT_CHAT;
                                _local_2 = new RoomWidgetChatUpdateEvent(_local_14, _local_3.userId, _local_3.text, _local_11, RoomObjectCategoryEnum.OBJECT_CATEGORY_USER, _local_6, _local_7, _local_13, _local_12, _local_3.session.roomId, _local_3.session.roomCategory, _local_3.chatType, _local_3.links);
                            };
                        };
                    };
                    break;
            };
            if (((((!((this._container == null))) && (!((this._container.events == null))))) && (!((_local_2 == null))))){
                this._container.events.dispatchEvent(_local_2);
            };
        }
        public function update():void
        {
            this.updateWidgetPosition();
        }
        private function updateWidgetPosition():void
        {
            var _local_5:Number;
            var _local_6:String;
            var _local_7:RoomWidgetRoomViewUpdateEvent;
            var _local_8:Point;
            var _local_9:Point;
            var _local_10:Point;
            if ((((((((this._container == null)) || ((this._container.roomSession == null)))) || ((this._container.roomEngine == null)))) || ((this._container.events == null)))){
                return;
            };
            var _local_1:int = this._container.getFirstCanvasId();
            var _local_2:int = this._container.roomSession.roomId;
            var _local_3:int = this._container.roomSession.roomCategory;
            var _local_4:RoomGeometry = (this._container.roomEngine.getRoomCanvasGeometry(_local_2, _local_3, _local_1) as RoomGeometry);
            if (_local_4 != null){
                _local_5 = 1;
                if (this._SafeStr_7235 > 0){
                    _local_5 = (_local_4.scale / this._SafeStr_7235);
                };
                if (this._SafeStr_7236 == null){
                    this._SafeStr_7237.x = 0;
                    this._SafeStr_7237.y = 0;
                    this._SafeStr_7237.z = 0;
                    this._SafeStr_7236 = _local_4.getScreenPoint(this._SafeStr_7237);
                    this._SafeStr_7235 = (_local_4.scale - 10);
                };
                _local_6 = "";
                _local_7 = null;
                this._SafeStr_7237.x = 0;
                this._SafeStr_7237.y = 0;
                this._SafeStr_7237.z = 0;
                _local_8 = _local_4.getScreenPoint(this._SafeStr_7237);
                if (_local_8 != null){
                    _local_9 = this._container.roomEngine.getRoomCanvasScreenOffset(_local_2, _local_3, _local_1);
                    if (_local_9 != null){
                        _local_8.offset(_local_9.x, _local_9.y);
                    };
                    if (((!((_local_8.x == this._SafeStr_7236.x))) || (!((_local_8.y == this._SafeStr_7236.y))))){
                        _local_10 = PointMath.sub(_local_8, PointMath.mul(this._SafeStr_7236, _local_5));
                        if (((!((_local_10.x == 0))) || (!((_local_10.y == 0))))){
                            _local_6 = RoomWidgetRoomViewUpdateEvent.RWRVUE_ROOM_VIEW_POSITION_CHANGED;
                            _local_7 = new RoomWidgetRoomViewUpdateEvent(_local_6, null, _local_10);
                            this._container.events.dispatchEvent(_local_7);
                        };
                        this._SafeStr_7236 = _local_8;
                    };
                };
                if (_local_4.scale != this._SafeStr_7235){
                    _local_6 = RoomWidgetRoomViewUpdateEvent.RWRVUE_ROOM_VIEW_SCALE_CHANGED;
                    _local_7 = new RoomWidgetRoomViewUpdateEvent(_local_6, null, null, _local_4.scale);
                    this._container.events.dispatchEvent(_local_7);
                    this._SafeStr_7235 = _local_4.scale;
                };
            };
        }
        public function petImageReady(_arg_1:String):void
        {
            var _local_2:BitmapData;
            if (this._SafeStr_7231){
                _local_2 = (this._SafeStr_7231.remove(_arg_1) as BitmapData);
                if (_local_2 != null){
                    this._SafeStr_7234.push(_local_2);
                };
            };
        }
        public function avatarImageReady(_arg_1:String):void
        {
            var _local_2:BitmapData;
            if (this._SafeStr_7230){
                _local_2 = (this._SafeStr_7230.remove(_arg_1) as BitmapData);
                if (_local_2 != null){
                    this._SafeStr_7234.push(_local_2);
                };
            };
        }
        private function getPetFigureString(_arg_1:String):String
        {
            var _local_2:int = this.getPetType(_arg_1);
            if (_local_2 < 0){
                return (_arg_1);
            };
            if (_local_2 < 8){
                return (this._container.avatarRenderManager.getPetFigureString(_arg_1));
            };
            return (_arg_1);
        }
        private function getPetImage(_arg_1:String):BitmapData
        {
            var _local_5:IAvatarImage;
            var _local_6:IPartColor;
            var _local_7:uint;
            var _local_8:uint;
            var _local_9:ImageResult;
            var _local_2:BitmapData;
            var _local_3:int = this.getPetType(_arg_1);
            var _local_4:int = this.getPetRace(_arg_1);
            if ((((_local_3 < 0)) || ((_local_4 < 0)))){
                return (_local_2);
            };
            if (_local_3 < 8){
                _local_5 = this._container.avatarRenderManager.createPetImageFromFigure(_arg_1, AvatarScaleType._SafeStr_4337, this);
                if (_local_5 != null){
                    _local_2 = _local_5.getCroppedImage(AvatarSetType._SafeStr_4457);
                    _local_6 = _local_5.getPartColor("pbd");
                    _local_5.dispose();
                    if (_local_6 != null){
                        _local_7 = _local_6.rgb;
                        if (_local_7 != 0){
                            this._SafeStr_7232.add(_arg_1, _local_7);
                        };
                    };
                };
            }
            else {
                _local_8 = 0;
                _local_9 = this._container.roomEngine.getPetImage(_local_3, _local_4, new Vector3d(90), 32, this, _local_8);
                if (_local_9 != null){
                    _local_2 = _local_9.data;
                    if (_local_9.id > 0){
                        this._SafeStr_7233.add(_local_9.id, _arg_1);
                    };
                };
            };
            return (_local_2);
        }
        private function getPetType(_arg_1:String):int
        {
            var _local_3:Array;
            var _local_2:int = -1;
            if (_arg_1 != null){
                _local_3 = _arg_1.split(" ");
                if (_local_3.length >= 2){
                    _local_2 = int(_local_3[0]);
                };
            };
            return (_local_2);
        }
        private function getPetRace(_arg_1:String):int
        {
            var _local_3:Array;
            var _local_2:int = -1;
            if (_arg_1 != null){
                _local_3 = _arg_1.split(" ");
                if (_local_3.length >= 2){
                    _local_2 = int(_local_3[1]);
                };
            };
            return (_local_2);
        }
        public function imageReady(_arg_1:int, _arg_2:BitmapData):void
        {
            var _local_3:String = this._SafeStr_7233.remove(_arg_1);
            if (_local_3 != null){
                this.petImageReady(_local_3);
                if (this._SafeStr_7231){
                    this._SafeStr_7231.add(_local_3, _arg_2);
                };
            };
        }

    }
}//package com.sulake.habbo.ui.handler

// ImageResult = "_-31w" (String#21576, DoABC#2)
// IVector3d = "_-hf" (String#8547, DoABC#2)
// Vector3d = "_-1Rb" (String#17568, DoABC#2)
// AvatarScaleType = "_-2lF" (String#20893, DoABC#2)
// HabboClubLevelEnum = "_-1ZP" (String#17867, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomSessionChatEvent = "_-2e3" (String#6834, DoABC#2)
// SecurityLevelEnum = "_-2xM" (String#21364, DoABC#2)
// RoomGeometry = "_-2l9" (String#20887, DoABC#2)
// IUserData = "_-0n7" (String#4570, DoABC#2)
// IPartColor = "_-1dO" (String#5620, DoABC#2)
// IGetImageListener = "_-2i7" (String#6909, DoABC#2)
// RoomObjectTypeEnum = "_-2hK" (String#20744, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// ChatWidgetHandler = "_-0rx" (String#4685, DoABC#2)
// RoomWidgetRoomViewUpdateEvent = "_-xx" (String#24612, DoABC#2)
// RoomWidgetRequestWidgetMessage = "_-XQ" (String#8356, DoABC#2)
// RoomWidgetChatSelectAvatarMessage = "_-3-" (String#21461, DoABC#2)
// PointMath = "_-2Gf" (String#6380, DoABC#2)
// RWRWM_USER_CHOOSER = "_-3HZ" (String#22183, DoABC#2)
// RWRWM_FURNI_CHOOSER = "_-0pQ" (String#16032, DoABC#2)
// RWCSAM_MESSAGE_SELECT_AVATAR = "_-2R1" (String#20086, DoABC#2)
// RWCM_MESSAGE_CHAT = "_-2Zj" (String#20430, DoABC#2)
// _SafeStr_3620 = "_-xF" (String#24578, DoABC#2)
// _SafeStr_3621 = "_-0Bz" (String#14526, DoABC#2)
// _SafeStr_3622 = "_-0O5" (String#14992, DoABC#2)
// chatType = "_-TQ" (String#23382, DoABC#2)
// recipientName = "_-147" (String#16622, DoABC#2)
// webID = "_-2uI" (String#7166, DoABC#2)
// _SafeStr_3747 = "_-gF" (String#23903, DoABC#2)
// _SafeStr_3943 = "_-xn" (String#24604, DoABC#2)
// RWE_CHAT_WIDGET = "_-2dZ" (String#20586, DoABC#2)
// createPetImageFromFigure = "_-0Sk" (String#4153, DoABC#2)
// _SafeStr_4337 = "_-1dF" (String#18025, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// _SafeStr_4457 = "_-2mY" (String#20943, DoABC#2)
// _SafeStr_4458 = "_-327" (String#21586, DoABC#2)
// petImageReady = "_-WW" (String#8332, DoABC#2)
// RSCE_CHAT_EVENT = "_-0km" (String#15857, DoABC#2)
// getScreenPoint = "_-34h" (String#7403, DoABC#2)
// getRoomCanvasGeometry = "_-1Qw" (String#5373, DoABC#2)
// getRoomCanvasScreenOffset = "_-3FD" (String#7616, DoABC#2)
// getRoomObject = "_-1qD" (String#866, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// getCroppedImage = "_-2Ez" (String#6342, DoABC#2)
// avatarImageReady = "_-i" (String#8553, DoABC#2)
// userDataManager = "_-lZ" (String#8636, DoABC#2)
// getUserDataByIndex = "_-1XZ" (String#5510, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// rgb = "_-1zC" (String#1788, DoABC#2)
// getWidgetMessages = "_-1dr" (String#5626, DoABC#2)
// getProcessedEvents = "_-0gb" (String#4436, DoABC#2)
// processEvent = "_-xT" (String#2223, DoABC#2)
// getPetImage = "_-0Zc" (String#437, DoABC#2)
// IAvatarImageListener = "_-06N" (String#3688, DoABC#2)
// _SafeStr_7230 = "_-39r" (String#21879, DoABC#2)
// _SafeStr_7231 = "_-1uP" (String#18732, DoABC#2)
// _SafeStr_7232 = "_-14n" (String#16646, DoABC#2)
// _SafeStr_7233 = "_-s4" (String#24367, DoABC#2)
// _SafeStr_7234 = "_-2F2" (String#19605, DoABC#2)
// _SafeStr_7235 = "_-rh" (String#24348, DoABC#2)
// _SafeStr_7236 = "_-2-F" (String#18979, DoABC#2)
// _SafeStr_7237 = "_-1Fi" (String#17103, DoABC#2)
// getSelectedAvatarId = "_-2j0" (String#6933, DoABC#2)
// sendChatMessage = "_-3D4" (String#7576, DoABC#2)
// sendWaveMessage = "_-3BE" (String#7533, DoABC#2)
// sendSignMessage = "_-1UA" (String#5435, DoABC#2)
// hasSecurity = "_-0x9" (String#4794, DoABC#2)
// _SafeStr_7243 = "_-0Qi" (String#15090, DoABC#2)
// pickAllFurniture = "_-1Q1" (String#5353, DoABC#2)
// sendShoutMessage = "_-0Bn" (String#3791, DoABC#2)
// sendWhisperMessage = "_-2qY" (String#7086, DoABC#2)
// selectAvatar = "_-1aj" (String#5572, DoABC#2)
// moderation = "_-Id" (String#8055, DoABC#2)
// getFirstCanvasId = "_-iH" (String#8561, DoABC#2)
// updateWidgetPosition = "_-2an" (String#20480, DoABC#2)
// getPetFigureString = "_-0DP" (String#1431, DoABC#2)
// getPartColor = "_-2yW" (String#7250, DoABC#2)
// RWCUE_EVENT_CHAT = "_-02A" (String#14133, DoABC#2)
// sub = "_-2e2" (String#20605, DoABC#2)
// mul = "_-tH" (String#24418, DoABC#2)
// RWRVUE_ROOM_VIEW_POSITION_CHANGED = "_-3Jp" (String#22277, DoABC#2)
// RWRVUE_ROOM_VIEW_SCALE_CHANGED = "_-2ZI" (String#20410, DoABC#2)
// getPetType = "_-1qN" (String#867, DoABC#2)
// getPetRace = "_-33i" (String#7380, DoABC#2)
// RoomObjectCategoryEnum = "_-1eh" (String#5639, DoABC#2)



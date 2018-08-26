
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRequestWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomObjectMessage;
    import com.sulake.habbo.room.object.RoomObjectCategoryEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.ui.widget.events.ChooserItem;
    import com.sulake.habbo.ui.widget.events.RoomWidgetChooserContentEvent;
    import flash.events.Event;

    public class FurniChooserWidgetHandler implements IRoomWidgetHandler 
    {

        private var _container:IRoomWidgetHandlerContainer = null;
        private var _disposed:Boolean = false;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWE_FURNI_CHOOSER);
        }
        public function dispose():void
        {
            this._disposed = true;
            this._container = null;
        }
        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            this._container = _arg_1;
        }
        public function IRoomWidgetHandler():Array
        {
            var _local_1:Array = [];
            _local_1.push(RoomWidgetRequestWidgetMessage.RWRWM_FURNI_CHOOSER);
            _local_1.push(RoomWidgetRoomObjectMessage.RWROM_SELECT_OBJECT);
            return (_local_1);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_2:RoomWidgetRoomObjectMessage;
            if (_arg_1 == null){
                return (null);
            };
            switch (_arg_1.type){
                case RoomWidgetRequestWidgetMessage.RWRWM_FURNI_CHOOSER:
                    this.FurniChooserWidgetHandler();
                    break;
                case RoomWidgetRoomObjectMessage.RWROM_SELECT_OBJECT:
                    _local_2 = (_arg_1 as RoomWidgetRoomObjectMessage);
                    if (_local_2 == null){
                        return (null);
                    };
                    if ((((_local_2.category == RoomObjectCategoryEnum._SafeStr_4329)) || ((_local_2.category == RoomObjectCategoryEnum._SafeStr_4330)))){
                        this._container.roomEngine.selectRoomObject(this._container.roomSession.roomId, this._container.roomSession.roomCategory, _local_2.id, _local_2.category);
                    };
                    break;
            };
            return (null);
        }
        private function FurniChooserWidgetHandler():void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:IFurnitureData;
            var _local_7:String;
            var _local_8:IRoomObject;
            var _local_10:String;
            var _local_11:int;
            if ((((((this._container == null)) || ((this._container.roomSession == null)))) || ((this._container.roomEngine == null)))){
                return;
            };
            if (this._container.roomSession.userDataManager == null){
                return;
            };
            var _local_1:int = this._container.roomSession.roomId;
            var _local_2:int = this._container.roomSession.roomCategory;
            var _local_3:Array = [];
            var _local_9:int = this._container.roomEngine.IRoomSpriteCanvasContainer(_local_1, _local_2, RoomObjectCategoryEnum._SafeStr_4329);
            _local_4 = 0;
            while (_local_4 < _local_9) {
                _local_8 = this._container.roomEngine.IRoomSpriteCanvasContainer(_local_1, _local_2, _local_4, RoomObjectCategoryEnum._SafeStr_4329);
                if (_local_8 != null){
                    _local_5 = _local_8.getModel().getNumber(RoomObjectVariableEnum._SafeStr_7294);
                    _local_6 = this._container.sessionDataManager.SessionDataManager(_local_5);
                    if (_local_6 != null){
                        _local_7 = _local_6.title;
                    }
                    else {
                        _local_7 = _local_8.getType();
                    };
                    _local_3.push(new ChooserItem(_local_8.getId(), RoomObjectCategoryEnum._SafeStr_4329, _local_7));
                };
                _local_4++;
            };
            _local_9 = this._container.roomEngine.IRoomSpriteCanvasContainer(_local_1, _local_2, RoomObjectCategoryEnum._SafeStr_4330);
            _local_4 = 0;
            while (_local_4 < _local_9) {
                _local_8 = this._container.roomEngine.IRoomSpriteCanvasContainer(_local_1, _local_2, _local_4, RoomObjectCategoryEnum._SafeStr_4330);
                if (_local_8 != null){
                    _local_10 = _local_8.getType();
                    if (_local_10.indexOf("poster") == 0){
                        _local_11 = int(_local_10.replace("poster", ""));
                        _local_7 = this._container.localization.getKey((("poster_" + _local_11) + "_name"), (("poster_" + _local_11) + "_name"));
                    }
                    else {
                        _local_5 = _local_8.getModel().getNumber(RoomObjectVariableEnum._SafeStr_7294);
                        _local_6 = this._container.sessionDataManager.SessionDataManager(_local_5);
                        if (((!((_local_6 == null))) && ((_local_6.title.length > 0)))){
                            _local_7 = _local_6.title;
                        }
                        else {
                            _local_7 = _local_10;
                        };
                    };
                    _local_3.push(new ChooserItem(_local_8.getId(), RoomObjectCategoryEnum._SafeStr_4330, _local_7));
                };
                _local_4++;
            };
            _local_3.sort(this.UserChooserWidgetHandler);
            this._container.events.dispatchEvent(new RoomWidgetChooserContentEvent(RoomWidgetChooserContentEvent.RWCCE_FURNI_CHOOSER_CONTENT, _local_3, this._container.sessionDataManager.isAnyRoomController));
        }
        private function UserChooserWidgetHandler(_arg_1:ChooserItem, _arg_2:ChooserItem):int
        {
            if ((((((((((_arg_1 == null)) || ((_arg_2 == null)))) || ((_arg_1.name == _arg_2.name)))) || ((_arg_1.name.length == 0)))) || ((_arg_2.name.length == 0)))){
                return (1);
            };
            var _local_3:Array = new Array(_arg_1.name.toUpperCase(), _arg_2.name.toUpperCase()).sort();
            if (_local_3.indexOf(_arg_1.name.toUpperCase()) == 0){
                return (-1);
            };
            return (1);
        }
        public function IRoomWidgetHandler():Array
        {
            return (null);
        }
        public function IRoomWidgetHandler(_arg_1:Event):void
        {
        }
        public function update():void
        {
        }

    }
}//package com.sulake.habbo.ui.handler

// IFurnitureData = "_-pe" (String#8701, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// FurniChooserWidgetHandler = "_-25L" (String#19232, DoABC#2)
// RoomWidgetChooserContentEvent = "_-12l" (String#16570, DoABC#2)
// RoomWidgetRequestWidgetMessage = "_-XQ" (String#8356, DoABC#2)
// ChooserItem = "_-2XQ" (String#6710, DoABC#2)
// RWRWM_FURNI_CHOOSER = "_-0pQ" (String#16032, DoABC#2)
// RWROM_SELECT_OBJECT = "_-1RI" (String#17557, DoABC#2)
// RWE_FURNI_CHOOSER = "_-0aa" (String#15458, DoABC#2)
// _SafeStr_4329 = "_-bN" (String#23687, DoABC#2)
// _SafeStr_4330 = "_-0cQ" (String#15531, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// userDataManager = "_-lZ" (String#8636, DoABC#2)
// RWCCE_FURNI_CHOOSER_CONTENT = "_-2tc" (String#21225, DoABC#2)
// isAnyRoomController = "_-2IH" (String#6407, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// IRoomWidgetHandler = "_-1dr" (String#5626, DoABC#2)
// IRoomWidgetHandler = "_-0gb" (String#4436, DoABC#2)
// IRoomWidgetHandler = "_-xT" (String#2223, DoABC#2)
// SessionDataManager = "_-08L" (String#3728, DoABC#2)
// SessionDataManager = "_-Hc" (String#8029, DoABC#2)
// _SafeStr_7294 = "_-Uf" (String#23433, DoABC#2)
// UserChooserWidgetHandler = "_-2oV" (String#7048, DoABC#2)
// IRoomSpriteCanvasContainer = "_-1Hy" (String#1654, DoABC#2)
// IRoomSpriteCanvasContainer = "_-cJ" (String#2140, DoABC#2)
// FurniChooserWidgetHandler = "_-NT" (String#23144, DoABC#2)
// RoomObjectCategoryEnum = "_-1eh" (String#5639, DoABC#2)



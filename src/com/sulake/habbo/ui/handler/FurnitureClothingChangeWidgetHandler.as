
package com.sulake.habbo.ui.handler
{
    import com.sulake.habbo.ui.IRoomWidgetHandler;
    import com.sulake.habbo.avatar.IHabboAvatarEditorDataSaver;
    import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
    import com.sulake.habbo.ui.widget.enums.RoomWidgetEnum;
    import com.sulake.habbo.avatar.enum.AvatarEditorInstanceId;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetClothingChangeMessage;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetAvatarEditorMessage;
    import com.sulake.room.object.IRoomObject;
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.habbo.ui.widget.events.RoomWidgetClothingChangeUpdateEvent;
    import com.sulake.habbo.avatar.figuredata.FigureData;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.habbo.avatar.enum.AvatarEditorFigureCategory;
    import com.sulake.habbo.session.HabboClubLevelEnum;
    import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
    import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
    import flash.events.Event;

    public class FurnitureClothingChangeWidgetHandler implements IRoomWidgetHandler, IHabboAvatarEditorDataSaver 
    {

        private static const _SafeStr_7382:String = "hd-99999-99999.lg-270-62";
        private static const _FurnitureClothingChangeWidgetHandler:String = "hd-99999-99999.ch-630-62.lg-695-62";

        private var _disposed:Boolean = false;
        private var _container:IRoomWidgetHandlerContainer = null;
        private var _objectId:int = -1;

        public function get disposed():Boolean
        {
            return (this._disposed);
        }
        public function get type():String
        {
            return (RoomWidgetEnum.RWE_CLOTHING_CHANGE);
        }
        public function set container(_arg_1:IRoomWidgetHandlerContainer):void
        {
            this._container = _arg_1;
        }
        public function dispose():void
        {
            if (((this._container) && (this._container.avatarEditor))){
                this._container.avatarEditor.close(AvatarEditorInstanceId._SafeStr_7384);
            };
            this._disposed = true;
            this._container = null;
        }
        public function IRoomWidgetHandler():Array
        {
            return ([RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_CLOTHING_CHANGE, RoomWidgetClothingChangeMessage.RWCCM_REQUEST_EDITOR, RoomWidgetAvatarEditorMessage.RWCM_OPEN_AVATAR_EDITOR]);
        }
        public function processWidgetMessage(_arg_1:RoomWidgetMessage):RoomWidgetUpdateEvent
        {
            var _local_5:RoomWidgetFurniToWidgetMessage;
            var _local_6:RoomWidgetClothingChangeMessage;
            var _local_7:Boolean;
            var _local_8:String;
            var _local_9:String;
            var _local_2:IRoomObject;
            var _local_3:IRoomObjectModel;
            var _local_4:RoomWidgetClothingChangeUpdateEvent;
            switch (_arg_1.type){
                case RoomWidgetFurniToWidgetMessage.RWFWM_MESSAGE_REQUEST_CLOTHING_CHANGE:
                    _local_5 = (_arg_1 as RoomWidgetFurniToWidgetMessage);
                    _local_2 = this._container.roomEngine.IRoomSpriteCanvasContainer(_local_5.roomId, _local_5.roomCategory, _local_5.id, _local_5.category);
                    if (_local_2 != null){
                        _local_3 = _local_2.getModel();
                        if (_local_3 != null){
                            _local_7 = ((this._container.roomSession.isRoomOwner) || (this._container.sessionDataManager.isAnyRoomController));
                            if (_local_7){
                                _local_4 = new RoomWidgetClothingChangeUpdateEvent(RoomWidgetClothingChangeUpdateEvent.RWCCUE_SHOW_GENDER_SELECTION, _local_5.id, _local_5.category, _local_5.roomId, _local_5.roomCategory);
                                this._container.events.dispatchEvent(_local_4);
                            };
                        };
                    };
                    break;
                case RoomWidgetClothingChangeMessage.RWCCM_REQUEST_EDITOR:
                    _local_6 = (_arg_1 as RoomWidgetClothingChangeMessage);
                    _local_2 = this._container.roomEngine.IRoomSpriteCanvasContainer(_local_6.roomId, _local_6.roomCategory, _local_6.objectId, _local_6.objectCategory);
                    if (_local_2 != null){
                        _local_3 = _local_2.getModel();
                        if (_local_3 != null){
                            this._objectId = _local_6.objectId;
                            _local_8 = FigureData.M;
                            _local_9 = _local_3.getString(RoomObjectVariableEnum._SafeStr_7386);
                            if ((((_local_9 == null)) || ((_local_9 == "")))){
                                _local_9 = _SafeStr_7382;
                            };
                            if (_local_6.gender == FigureData.FEMALE){
                                _local_8 = FigureData.FEMALE;
                                _local_9 = _local_3.getString(RoomObjectVariableEnum._SafeStr_7387);
                                if ((((_local_9 == null)) || ((_local_9 == "")))){
                                    _local_9 = _FurnitureClothingChangeWidgetHandler;
                                };
                            };
                            if (this._container.avatarEditor.openEditor(AvatarEditorInstanceId._SafeStr_7384, this, [AvatarEditorFigureCategory._SafeStr_7388, AvatarEditorFigureCategory._SafeStr_7389], false, "${widget.furni.clothingchange.editor.title}")){
                                this._container.avatarEditor.loadAvatarInEditor(AvatarEditorInstanceId._SafeStr_7384, _local_9, _local_8, HabboClubLevelEnum._SafeStr_3942);
                                _local_4 = new RoomWidgetClothingChangeUpdateEvent(RoomWidgetClothingChangeUpdateEvent.RWCCUE_SHOW_GENDER_SELECTION, _local_6.objectId, _local_6.objectCategory, _local_6.roomId, _local_6.roomCategory);
                                this._container.events.dispatchEvent(_local_4);
                            };
                        };
                    };
                    break;
            };
            return (null);
        }
        public function update():void
        {
        }
        public function IRoomWidgetHandler():Array
        {
            return ([]);
        }
        public function IRoomWidgetHandler(_arg_1:Event):void
        {
        }
        public function saveFigure(_arg_1:String, _arg_2:String):void
        {
            if (this._container == null){
                return;
            };
            this._container.roomSession.RoomSession(this._objectId, _arg_2, _arg_1);
            this._container.avatarEditor.close(AvatarEditorInstanceId._SafeStr_7384);
        }

    }
}//package com.sulake.habbo.ui.handler

// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// HabboClubLevelEnum = "_-1ZP" (String#17867, DoABC#2)
// IRoomObjectModel = "_-253" (String#6141, DoABC#2)
// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// IHabboAvatarEditorDataSaver = "_-0EA" (String#3831, DoABC#2)
// AvatarEditorInstanceId = "_-3Bn" (String#21953, DoABC#2)
// FigureData = "_-1BT" (String#836, DoABC#2)
// RoomWidgetUpdateEvent = "_-0ZP" (String#4289, DoABC#2)
// FurnitureClothingChangeWidgetHandler = "_-2s5" (String#21161, DoABC#2)
// RoomWidgetFurniToWidgetMessage = "_-2Rk" (String#6600, DoABC#2)
// RoomWidgetClothingChangeUpdateEvent = "_-0RK" (String#4119, DoABC#2)
// RoomWidgetClothingChangeMessage = "_-2Tf" (String#6638, DoABC#2)
// AvatarEditorFigureCategory = "_-nF" (String#8661, DoABC#2)
// RoomWidgetAvatarEditorMessage = "_-2-5" (String#6031, DoABC#2)
// RWFWM_MESSAGE_REQUEST_CLOTHING_CHANGE = "_-3Af" (String#21907, DoABC#2)
// _objectId = "_-1YP" (String#18, DoABC#2)
// RWCCM_REQUEST_EDITOR = "_-14O" (String#16632, DoABC#2)
// RWCM_OPEN_AVATAR_EDITOR = "_-1Sk" (String#17613, DoABC#2)
// _SafeStr_3942 = "_-0G0" (String#14684, DoABC#2)
// RWE_CLOTHING_CHANGE = "_-1Q2" (String#17511, DoABC#2)
// _disposed = "_-6m" (String#31, DoABC#2)
// M = "_-1c3" (String#17974, DoABC#2)
// IRoomSpriteCanvasContainer = "_-1qD" (String#866, DoABC#2)
// sessionDataManager = "_-0pX" (String#4623, DoABC#2)
// isRoomOwner = "_-ZP" (String#8405, DoABC#2)
// isAnyRoomController = "_-2IH" (String#6407, DoABC#2)
// roomSession = "_-0cq" (String#4363, DoABC#2)
// openEditor = "_-86" (String#2059, DoABC#2)
// avatarEditor = "_-1mJ" (String#5786, DoABC#2)
// IRoomWidgetHandler = "_-1dr" (String#5626, DoABC#2)
// IRoomWidgetHandler = "_-0gb" (String#4436, DoABC#2)
// IRoomWidgetHandler = "_-xT" (String#2223, DoABC#2)
// _SafeStr_7382 = "_-1eA" (String#18064, DoABC#2)
// _FurnitureClothingChangeWidgetHandler = "_-9c" (String#22604, DoABC#2)
// _SafeStr_7384 = "_-J9" (String#22973, DoABC#2)
// RWCCUE_SHOW_GENDER_SELECTION = "_-0dg" (String#15572, DoABC#2)
// _SafeStr_7386 = "_-ew" (String#23841, DoABC#2)
// _SafeStr_7387 = "_-69" (String#22471, DoABC#2)
// _SafeStr_7388 = "_-0YE" (String#15366, DoABC#2)
// _SafeStr_7389 = "_-3HR" (String#22176, DoABC#2)
// saveFigure = "_-2M0" (String#6483, DoABC#2)
// RoomSession = "_-mI" (String#8649, DoABC#2)



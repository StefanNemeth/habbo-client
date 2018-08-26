
package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
    import com.sulake.habbo.room.events.RoomObjectFurnitureActionEvent;
    import com.sulake.room.events.RoomObjectEvent;
    import flash.events.MouseEvent;
    import com.sulake.room.object.IRoomObjectModelController;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;
    import com.sulake.room.events.RoomSpriteMouseEvent;
    import com.sulake.room.utils.IRoomGeometry;

    public class FurnitureTeaserLogic extends FurnitureLogic 
    {

        private const TYPE_INJECTED:String = "TYPE_INJECTED";

        override public function getEventTypes():Array
        {
            var _local_1:Array = [RoomObjectWidgetRequestEvent.REOE_WIDGET_REQUEST_TEASER, RoomObjectFurnitureActionEvent.ROFCAE_VIRAL_GIFT];
            return (ObjectLogicBase(super.getEventTypes(), _local_1));
        }
        override public function mouseEvent(_arg_1:RoomSpriteMouseEvent, _arg_2:IRoomGeometry):void
        {
            var _local_7:int;
            var _local_8:String;
            var _local_9:RoomObjectEvent;
            if ((((_arg_1 == null)) || ((_arg_2 == null)))){
                return;
            };
            if (object == null){
                return;
            };
            if (((((((!((_arg_1.type == MouseEvent.CLICK))) && (!((_arg_1.type == MouseEvent.DOUBLE_CLICK))))) && (!((_arg_1.type == MouseEvent.MOUSE_DOWN))))) && (!((_arg_1.type == MouseEvent.MOUSE_UP))))){
                return;
            };
            var _local_3:IRoomObjectModelController = object.getModelController();
            var _local_4:String = _local_3.getString(RoomObjectVariableEnum._SafeStr_7217);
            var _local_5:String = _local_4;
            var _local_6:String = "+";
            if (_local_4){
                if (_local_4.indexOf(_local_6) > -1){
                    _local_5 = _local_4.substring(0, _local_4.indexOf(_local_6));
                };
            };
            if (_local_5 == this.TYPE_INJECTED){
                if (_arg_1.type == MouseEvent.MOUSE_UP){
                    if (eventDispatcher != null){
                        _local_7 = object.getId();
                        _local_8 = object.getType();
                        _local_9 = new RoomObjectWidgetRequestEvent(RoomObjectWidgetRequestEvent.REOE_WIDGET_REQUEST_TEASER, _local_7, _local_8);
                        eventDispatcher.dispatchEvent(_local_9);
                        object.setVisualization(null);
                    };
                }
                else {
                    super.mouseEvent(_arg_1, _arg_2);
                };
            }
            else {
                if (_arg_1.type == MouseEvent.DOUBLE_CLICK){
                    this.useObject();
                }
                else {
                    if ((((_arg_1.type == MouseEvent.MOUSE_DOWN)) || ((_arg_1.type == MouseEvent.CLICK)))){
                        super.mouseEvent(_arg_1, _arg_2);
                    };
                };
            };
        }
        override public function useObject():void
        {
            var _local_1:int;
            var _local_2:String;
            var _local_3:RoomObjectEvent;
            if (((!((eventDispatcher == null))) && (!((object == null))))){
                _local_1 = object.getId();
                _local_2 = object.getType();
                _local_3 = new RoomObjectFurnitureActionEvent(RoomObjectFurnitureActionEvent.ROFCAE_VIRAL_GIFT, _local_1, _local_2);
                eventDispatcher.dispatchEvent(_local_3);
            };
        }

    }
}//package com.sulake.habbo.room.object.logic.furniture

// TYPE_INJECTED = "_-0s1" (String#16124, DoABC#2)
// RoomObjectVariableEnum = "_-1MH" (String#17370, DoABC#2)
// FurnitureLogic = "_-001" (String#14053, DoABC#2)
// FurnitureTeaserLogic = "_-1I1" (String#17193, DoABC#2)
// IRoomObjectModelController = "_-1yp" (String#6010, DoABC#2)
// IRoomGeometry = "_-0z9" (String#4829, DoABC#2)
// RoomObjectFurnitureActionEvent = "_-2H6" (String#19689, DoABC#2)
// RoomSpriteMouseEvent = "_-wc" (String#8815, DoABC#2)
// RoomObjectWidgetRequestEvent = "_-0Oy" (String#15023, DoABC#2)
// ObjectLogicBase = "_-uN" (String#24466, DoABC#2)
// mouseEvent = "_-0Um" (String#4199, DoABC#2)
// REOE_WIDGET_REQUEST_TEASER = "_-0u1" (String#16204, DoABC#2)
// ROFCAE_VIRAL_GIFT = "_-2T4" (String#20166, DoABC#2)
// _SafeStr_7217 = "_-1mr" (String#18416, DoABC#2)
// useObject = "_-0zi" (String#1594, DoABC#2)



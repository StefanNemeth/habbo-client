
package com.sulake.core.window.utils
{
    import com.sulake.core.window.enum.MouseCursorType;
    import flash.display.Stage;
    import flash.display.DisplayObject;
    import flash.utils.Dictionary;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.ui.Mouse;
    import flash.ui.MouseCursor;

    public class MouseCursorControl 
    {

        private static var _type:uint = MouseCursorType._SafeStr_3729;//0
        private static var _SafeStr_9650:Stage;
        private static var _visible:Boolean = true;
        private static var _disposed:Boolean = false;
        private static var _SafeStr_9673:Boolean = true;
        private static var _SafeStr_9674:DisplayObject;
        private static var _SafeStr_9675:Dictionary = new Dictionary();

        public function MouseCursorControl(_arg_1:DisplayObject)
        {
            _SafeStr_9650 = _arg_1.stage;
        }
        public static function dispose():void
        {
            if (!_disposed){
                if (_SafeStr_9674){
                    _SafeStr_9650.removeChild(_SafeStr_9674);
                    _SafeStr_9650.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
                    _SafeStr_9650.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
                    _SafeStr_9650.removeEventListener(MouseEvent.MOUSE_OVER, onStageMouseMove);
                    _SafeStr_9650.removeEventListener(MouseEvent.MOUSE_OUT, onStageMouseMove);
                };
                _disposed = true;
            };
        }
        public static function get disposed():Boolean
        {
            return (_disposed);
        }
        public static function get type():uint
        {
            return (_type);
        }
        public static function set type(_arg_1:uint):void
        {
            if (_type != _arg_1){
                _type = _arg_1;
                _SafeStr_9673 = true;
            };
        }
        public static function get visible():Boolean
        {
            return (_visible);
        }
        public static function set visible(_arg_1:Boolean):void
        {
            _visible = _arg_1;
            if (_visible){
                if (_SafeStr_9674){
                    _SafeStr_9674.visible = true;
                }
                else {
                    Mouse.show();
                };
            }
            else {
                if (_SafeStr_9674){
                    _SafeStr_9674.visible = false;
                }
                else {
                    Mouse.hide();
                };
            };
        }
        public static function change():void
        {
            var _local_1:DisplayObject;
            if (_SafeStr_9673){
                _local_1 = _SafeStr_9675[_type];
                if (_local_1){
                    if (_SafeStr_9674){
                        _SafeStr_9650.removeChild(_SafeStr_9674);
                    }
                    else {
                        _SafeStr_9650.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
                        _SafeStr_9650.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
                        _SafeStr_9650.addEventListener(MouseEvent.MOUSE_OVER, onStageMouseMove);
                        _SafeStr_9650.addEventListener(MouseEvent.MOUSE_OUT, onStageMouseMove);
                        Mouse.hide();
                    };
                    _SafeStr_9674 = _local_1;
                    _SafeStr_9650.addChild(_SafeStr_9674);
                }
                else {
                    if (_SafeStr_9674){
                        _SafeStr_9650.removeChild(_SafeStr_9674);
                        _SafeStr_9650.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
                        _SafeStr_9650.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
                        _SafeStr_9650.removeEventListener(MouseEvent.MOUSE_OVER, onStageMouseMove);
                        _SafeStr_9650.removeEventListener(MouseEvent.MOUSE_OUT, onStageMouseMove);
                        _SafeStr_9674 = null;
                        Mouse.show();
                    };
                    switch (_type){
                        case MouseCursorType._SafeStr_3729:
                        case MouseCursorType.ARROW:
                            Mouse.cursor = MouseCursor.ARROW;
                            break;
                        case MouseCursorType._SafeStr_9484:
                            Mouse.cursor = MouseCursor.BUTTON;
                            break;
                        case MouseCursorType._SafeStr_5005:
                        case MouseCursorType.RWFAM_MOVE:
                        case MouseCursorType._SafeStr_9487:
                        case MouseCursorType._SafeStr_9488:
                            Mouse.cursor = MouseCursor.HAND;
                            break;
                        case MouseCursorType.NONE:
                            Mouse.cursor = MouseCursor.ARROW;
                            Mouse.hide();
                            break;
                    };
                };
                _SafeStr_9673 = false;
            };
        }
        public static function defineCustomCursorType(_arg_1:uint, _arg_2:DisplayObject):void
        {
            _SafeStr_9675[_arg_1] = _arg_2;
        }
        private static function onStageMouseMove(_arg_1:MouseEvent):void
        {
            if (_SafeStr_9674){
                _SafeStr_9674.x = (_arg_1.stageX - 2);
                _SafeStr_9674.y = _arg_1.stageY;
                if (_type == MouseCursorType._SafeStr_3729){
                    _visible = false;
                    Mouse.show();
                }
                else {
                    _visible = true;
                    Mouse.hide();
                };
            };
        }
        private static function onStageMouseLeave(_arg_1:Event):void
        {
            if (((_SafeStr_9674) && (!((_type == MouseCursorType._SafeStr_3729))))){
                Mouse.hide();
                _visible = false;
            };
        }

    }
}//package com.sulake.core.window.utils

// MouseCursorControl = "_-eM" (String#23816, DoABC#2)
// MouseCursorType = "_-031" (String#14164, DoABC#2)
// RWFAM_MOVE = "_-07t" (String#14359, DoABC#2)
// _SafeStr_3729 = "_-06z" (String#14322, DoABC#2)
// _SafeStr_5005 = "_-0xz" (String#16354, DoABC#2)
// change = "_-Bl" (String#7908, DoABC#2)
// _visible = "_-1SE" (String#363, DoABC#2)
// _SafeStr_9484 = "_-3GB" (String#22126, DoABC#2)
// _SafeStr_9487 = "_-1au" (String#17930, DoABC#2)
// _SafeStr_9488 = "_-7A" (String#22508, DoABC#2)
// _SafeStr_9650 = "_-0MX" (String#4012, DoABC#2)
// _SafeStr_9673 = "_-1lb" (String#18358, DoABC#2)
// _SafeStr_9674 = "_-329" (String#21587, DoABC#2)
// _SafeStr_9675 = "_-NP" (String#23141, DoABC#2)
// onStageMouseLeave = "_-2Xt" (String#20353, DoABC#2)
// onStageMouseMove = "_-2UW" (String#6655, DoABC#2)
// defineCustomCursorType = "_-zV" (String#24673, DoABC#2)



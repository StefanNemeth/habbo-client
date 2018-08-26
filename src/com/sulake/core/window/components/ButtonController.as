
package com.sulake.core.window.components
{
    import com.sulake.core.window.utils.tablet.ITouchAwareWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowTouchEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.WindowController;

    public class ButtonController extends InteractiveController implements IButtonWindow, ITouchAwareWindow 
    {

        protected static const _BTN_TEXT:String = "_BTN_TEXT";
        protected static const _ButtonController:Number = 0.5;

        public function ButtonController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            _arg_4 = (_arg_4 | WindowParam.WINDOW_PARAM_EXPAND_TO_ACCOMMODATE_CHILDREN);
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }
        override public function set caption(_arg_1:String):void
        {
            super.caption = _arg_1;
            var _local_2:IWindow = getChildByName(_BTN_TEXT);
            if (_local_2 != null){
                _local_2.caption = caption;
            };
        }
        override public function update(subject:WindowController, event:WindowEvent):Boolean
        {
            var type:String;
            var windowEvent:WindowEvent;
            var result:Boolean;
            if ((event is WindowEvent)){
                switch (event.type){
                    case WindowEvent.WE_CHILD_RESIZED:
                        width = 0;
                        break;
                    case WindowEvent.WE_ENABLED:
                        try {
                            getChildByName(_BTN_TEXT).blend = (getChildByName(_BTN_TEXT).blend + _ButtonController);
                        }
                        catch(e:Error) {
                        };
                        break;
                    case WindowEvent.WE_DISABLED:
                        try {
                            getChildByName(_BTN_TEXT).blend = (getChildByName(_BTN_TEXT).blend - _ButtonController);
                        }
                        catch(e:Error) {
                        };
                        break;
                };
            }
            else {
                if ((event is WindowTouchEvent)){
                    type = WindowEvent.POLL_OFFER_STATE_UNKNOWN;
                    switch (event.type){
                        case WindowTouchEvent.WTE_BEGIN:
                            type = WindowMouseEvent.WME_DOWN;
                            break;
                        case WindowTouchEvent.WTE_END:
                            type = WindowMouseEvent.WME_UP;
                            break;
                        case WindowTouchEvent.WTE_TAP:
                            type = WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK;
                            break;
                    };
                    windowEvent = WindowMouseEvent.allocate(type, WindowTouchEvent(event).window, WindowTouchEvent(event).related, WindowTouchEvent(event).localX, WindowTouchEvent(event).localY, WindowTouchEvent(event).stageX, WindowTouchEvent(event).stageY, WindowTouchEvent(event).altKey, WindowTouchEvent(event).ctrlKey, WindowTouchEvent(event).shiftKey, true, 0);
                    result = super.update(subject, windowEvent);
                    windowEvent.recycle();
                    return (result);
                };
            };
            return (super.update(subject, event));
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// InteractiveController = "_-25D" (String#6146, DoABC#2)
// ITouchAwareWindow = "_-QS" (String#8212, DoABC#2)
// ButtonController = "_-Mw" (String#8140, DoABC#2)
// WindowTouchEvent = "_-0lW" (String#4536, DoABC#2)
// WME_DOWN = "_-hL" (String#23944, DoABC#2)
// WME_UP = "_-0Cs" (String#14566, DoABC#2)
// allocate = "_-08G" (String#14374, DoABC#2)
// _BTN_TEXT = "_-7L" (String#2054, DoABC#2)
// _ButtonController = "_-0YG" (String#15368, DoABC#2)
// WE_CHILD_RESIZED = "_-i1" (String#23965, DoABC#2)
// WE_ENABLED = "_-2J1" (String#19767, DoABC#2)
// WE_DISABLED = "_-xm" (String#24603, DoABC#2)
// POLL_OFFER_STATE_UNKNOWN = "_-2VV" (String#20262, DoABC#2)
// WTE_BEGIN = "_-17q" (String#16767, DoABC#2)
// WTE_END = "_-0i9" (String#15755, DoABC#2)
// WTE_TAP = "_-2Ox" (String#19999, DoABC#2)
// related = "_-2Pu" (String#20039, DoABC#2)



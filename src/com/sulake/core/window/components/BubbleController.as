
package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.Direction;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.utils.PropertyDefaults;

    public class BubbleController extends FrameController implements IBubbleWindow 
    {

        private static const _POINTER_UP:String = "_POINTER_UP";
        private static const _POINTER_DOWN:String = "_POINTER_DOWN";
        private static const _POINTER_LEFT:String = "_POINTER_LEFT";
        private static const _POINTER_RIGHT:String = "_POINTER_RIGHT";

        private var _direction:String = "down";
        private var _pointerOffset:int = 0;

        public function BubbleController(_arg_1:String, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:WindowContext, _arg_6:Rectangle, _arg_7:IWindow, _arg_8:Function=null, _arg_9:Array=null, _arg_10:Array=null, _arg_11:uint=0)
        {
            super(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11);
        }
        public function get direction():String
        {
            return (this._direction);
        }
        public function set direction(_arg_1:String):void
        {
            var _local_2:IWindow;
            if (_arg_1 != this._direction){
                _local_2 = getChildByName(_arg_1);
                if (!_local_2){
                    throw (new Error((('Invalid pointer direction: "' + _arg_1) + '"!')));
                };
                getChildByName(this._direction).visible = false;
                _local_2.visible = true;
                this._direction = _arg_1;
                this.pointerOffset = this._pointerOffset;
            };
        }
        public function get pointerOffset():int
        {
            return (this._pointerOffset);
        }
        public function set pointerOffset(_arg_1:int):void
        {
            var _local_2:IWindow = getChildByName(this._direction);
            if (!_local_2){
                throw (new Error((('Invalid pointer direction: "' + this._direction) + '"!')));
            };
            if ((((this._direction == Direction.UP)) || ((this._direction == Direction.DOWN)))){
                _local_2.x = ((width / 2) + _arg_1);
            }
            else {
                _local_2.y = ((height / 2) + _arg_1);
            };
            this._pointerOffset = _arg_1;
        }
        override public function update(_arg_1:WindowController, _arg_2:WindowEvent):Boolean
        {
            var _local_3:Boolean = super.update(_arg_1, _arg_2);
            if (this._pointerOffset != 0){
                if (_arg_1 == this){
                    if (_arg_2.type == WindowEvent.WE_RESIZED){
                        this.pointerOffset = this._pointerOffset;
                    };
                };
            };
            return (_local_3);
        }
        override public function get properties():Array
        {
            var _local_1:Array = super.properties;
            if (this._direction != Direction.DOWN){
                _local_1.push(new PropertyStruct(PropertyDefaults._SafeStr_9368, this._direction, PropertyStruct._SafeStr_8998, true));
            }
            else {
                _local_1.push(PropertyDefaults._SafeStr_9369);
            };
            if (this._pointerOffset != 0){
                _local_1.push(new PropertyStruct(PropertyDefaults._SafeStr_9370, this._pointerOffset, PropertyStruct._SafeStr_8992, true));
            }
            else {
                _local_1.push(PropertyDefaults._SafeStr_9371);
            };
            return (_local_1);
        }
        override public function set properties(_arg_1:Array):void
        {
            var _local_2:PropertyStruct;
            for each (_local_2 in _arg_1) {
                switch (_local_2.key){
                    case PropertyDefaults._SafeStr_9368:
                        this.direction = (_local_2.value as String);
                        break;
                    case PropertyDefaults._SafeStr_9370:
                        this.pointerOffset = (_local_2.value as int);
                        break;
                };
            };
            super.properties = _arg_1;
        }

    }
}//package com.sulake.core.window.components

// WindowEvent = "_-Jh" (String#2085, DoABC#2)
// WindowContext = "_-2K8" (String#6447, DoABC#2)
// PropertyStruct = "_-t6" (String#24410, DoABC#2)
// PropertyDefaults = "_-3Dd" (String#22019, DoABC#2)
// IBubbleWindow = "_-24" (String#6122, DoABC#2)
// FrameController = "_-Tj" (String#8280, DoABC#2)
// BubbleController = "_-1Qj" (String#5365, DoABC#2)
// Direction = "_-129" (String#4920, DoABC#2)
// WE_RESIZED = "_-76" (String#22505, DoABC#2)
// _SafeStr_8992 = "_-5d" (String#22447, DoABC#2)
// _SafeStr_8998 = "_-1lW" (String#18353, DoABC#2)
// pointerOffset = "_-0-G" (String#3550, DoABC#2)
// _POINTER_UP = "_-1YF" (String#17825, DoABC#2)
// _POINTER_DOWN = "_-3KX" (String#22305, DoABC#2)
// _POINTER_LEFT = "_-2j3" (String#20808, DoABC#2)
// _POINTER_RIGHT = "_-1j2" (String#18247, DoABC#2)
// _pointerOffset = "_-38-" (String#7471, DoABC#2)
// _SafeStr_9368 = "_-jr" (String#24029, DoABC#2)
// _SafeStr_9369 = "_-1hv" (String#18209, DoABC#2)
// _SafeStr_9370 = "_-Kd" (String#23029, DoABC#2)
// _SafeStr_9371 = "_-0CD" (String#14538, DoABC#2)



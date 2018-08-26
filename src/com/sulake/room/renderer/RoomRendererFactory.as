
package com.sulake.room.renderer
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IContext;

    public class RoomRendererFactory extends Component implements IRoomRendererFactory 
    {

        public function RoomRendererFactory(_arg_1:IContext, _arg_2:uint=0)
        {
            super(_arg_1, _arg_2);
        }
        public function createRenderer():IRoomRenderer
        {
            return (new RoomRenderer(this));
        }

    }
}//package com.sulake.room.renderer

// createRenderer = "_-0Gk" (String#3888, DoABC#2)
// IRoomRenderer = "_-2jS" (String#6944, DoABC#2)
// RoomRenderer = "_-012" (String#3582, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// IRoomRendererFactory = "_-2zw" (String#7283, DoABC#2)



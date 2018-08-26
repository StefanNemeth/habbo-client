
package com.sulake.habbo.ui.widget.messages
{
    import com.sulake.core.window.IWindowContainer;

    public class RoomWidgetAvatarEditorMessage extends RoomWidgetMessage 
    {

        public static const RWCM_OPEN_AVATAR_EDITOR:String = "RWCM_OPEN_AVATAR_EDITOR";
        public static const RWCM_GET_WARDROBE:String = "RWCM_GET_WARDROBE";
        public static const RWAEM_AVATAR_EDITOR_VIEW_DISPOSED:String = "RWAEM_AVATAR_EDITOR_VIEW_DISPOSED";

        private var _context:IWindowContainer;

        public function RoomWidgetAvatarEditorMessage(_arg_1:String, _arg_2:IWindowContainer=null)
        {
            super(_arg_1);
            this._context = _arg_2;
        }
        public function get context():IWindowContainer
        {
            return (this._context);
        }

    }
}//package com.sulake.habbo.ui.widget.messages

// RoomWidgetMessage = "_-04U" (String#3654, DoABC#2)
// RoomWidgetAvatarEditorMessage = "_-2-5" (String#6031, DoABC#2)
// RWCM_OPEN_AVATAR_EDITOR = "_-1Sk" (String#17613, DoABC#2)
// RWCM_GET_WARDROBE = "_-21R" (String#19070, DoABC#2)
// RWAEM_AVATAR_EDITOR_VIEW_DISPOSED = "_-sK" (String#24374, DoABC#2)



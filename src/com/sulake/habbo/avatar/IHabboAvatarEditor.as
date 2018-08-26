
package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.IUnknown;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import flash.events.IEventDispatcher;

    public interface IHabboAvatarEditor extends IUnknown 
    {

        function openEditor(_arg_1:uint, _arg_2:IHabboAvatarEditorDataSaver, _arg_3:Array=null, _arg_4:Boolean=false, _arg_5:String=null):IFrameWindow;
        function embedEditorToContext(_arg_1:uint, _arg_2:IWindowContainer, _arg_3:IHabboAvatarEditorDataSaver=null, _arg_4:Array=null, _arg_5:Boolean=false):Boolean;
        function loadAvatarInEditor(_arg_1:uint, _arg_2:String, _arg_3:String, _arg_4:int=0):void;
        function loadOwnAvatarInEditor(_arg_1:uint):void;
        function get events():IEventDispatcher;
        function close(_arg_1:uint):void;

    }
}//package com.sulake.habbo.avatar

// embedEditorToContext = "_-1qC" (String#5860, DoABC#2)
// IHabboAvatarEditor = "_-N2" (String#8144, DoABC#2)
// IHabboAvatarEditorDataSaver = "_-0EA" (String#3831, DoABC#2)
// openEditor = "_-86" (String#2059, DoABC#2)
// loadOwnAvatarInEditor = "_-ae" (String#2135, DoABC#2)



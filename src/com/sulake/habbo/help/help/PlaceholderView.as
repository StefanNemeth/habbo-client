
package com.sulake.habbo.help.help
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;

    public class PlaceholderView extends HelpViewController implements IHelpViewController 
    {

        public function PlaceholderView(_arg_1:HelpUI, _arg_2:IHabboWindowManager, _arg_3:IAssetLibrary)
        {
            super(_arg_1, _arg_2, _arg_3);
            _arg_2.registerLocalizationParameter("info.client.version", "version", new String(201108111102));
        }
        override public function render():void
        {
            if (container != null){
                container.dispose();
            };
            container = (buildXmlWindow("placeholder") as IWindowContainer);
            if (container == null){
                return;
            };
            container.background = true;
            container.color = 33554431;
            super.render();
        }

    }
}//package com.sulake.habbo.help.help

// IHelpViewController = "_-0cs" (String#4364, DoABC#2)
// HelpViewController = "_-IY" (String#8052, DoABC#2)
// PlaceholderView = "_-0wE" (String#828, DoABC#2)



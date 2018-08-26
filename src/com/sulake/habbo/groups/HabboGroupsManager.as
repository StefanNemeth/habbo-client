
package com.sulake.habbo.groups
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;

    public class HabboGroupsManager extends Component implements IHabboGroupsManager 
    {

        public function HabboGroupsManager(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            Logger.log(("HabboGroupsManager initialized: " + _arg_3));
        }
        override public function dispose():void
        {
            super.dispose();
        }

    }
}//package com.sulake.habbo.groups

// IHabboGroupsManager = "_-1vp" (String#5955, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)



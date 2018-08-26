
package com.sulake.habbo.friendbar
{
    import com.sulake.core.runtime.ComponentContext;
    import com.sulake.habbo.friendbar.utils.LinkResolver;
    import com.sulake.habbo.friendbar.data.HabboFriendBarData;
    import com.sulake.iid.IIDHabboFriendBarData;
    import com.sulake.habbo.friendbar.view.HabboFriendBarView;
    import com.sulake.iid.IIDHabboFriendBarView;
    import com.sulake.habbo.friendbar.stream.HabboEventStream;
    import com.sulake.iid.IIDHabboEventStream;
    import com.sulake.core.runtime.IContext;
    import com.sulake.core.assets.IAssetLibrary;

    public class HabboFriendBar extends ComponentContext 
    {

        public function HabboFriendBar(_arg_1:IContext, _arg_2:uint=0, _arg_3:IAssetLibrary=null)
        {
            super(_arg_1, _arg_2, _arg_3);
            LinkResolver.unknown = this;
            IContext(new HabboFriendBarData(this, 0, _arg_3), [new IIDHabboFriendBarData()]);
            IContext(new HabboFriendBarView(this, 0, _arg_3), [new IIDHabboFriendBarView()]);
            IContext(new HabboEventStream(this, 0, _arg_3), [new IIDHabboEventStream()]);
        }
    }
}//package com.sulake.habbo.friendbar

// HabboFriendBarView = "_-2Ai" (String#6260, DoABC#2)
// HabboEventStream = "_-1vJ" (String#5947, DoABC#2)
// HabboFriendBarData = "_-3DB" (String#7579, DoABC#2)
// LinkResolver = "_-0WN" (String#4235, DoABC#2)
// ComponentContext = "_-0jP" (String#4488, DoABC#2)
// IContext = "_-1G" (String#5169, DoABC#2)



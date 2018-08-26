
package com.sulake.habbo.friendbar.view
{
    import com.sulake.core.runtime.Component;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.avatar.IAvatarRenderManager;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.habbo.session.ISessionDataManager;
    import com.sulake.iid.IIDSessionDataManager;
    import com.sulake.iid.IIDAvatarRenderManager;
    import com.sulake.iid.IIDHabboWindowManager;
    import com.sulake.iid.IIDHabboLocalizationManager;
    import com.sulake.iid.IIDHabboConfigurationManager;
    import com.sulake.habbo.friendbar.HabboFriendBar;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.runtime.IID;
    import com.sulake.core.runtime.IUnknown;

    public class AbstractView extends Component 
    {

        protected var _windowManager:IHabboWindowManager;
        protected var _SafeStr_11072:IAvatarRenderManager;
        protected var _localization:IHabboLocalizationManager;
        protected var _SafeStr_10977:IHabboConfigurationManager;
        protected var _sessionDataManager:ISessionDataManager;

        public function AbstractView(_arg_1:HabboFriendBar, _arg_2:uint, _arg_3:IAssetLibrary)
        {
            super(_arg_1, _arg_2, _arg_3);
            queueInterface(new IIDSessionDataManager(), this.onSessionManagerAvailable);
            queueInterface(new IIDAvatarRenderManager(), this.onAvatarRendererAvailable);
            queueInterface(new IIDHabboWindowManager(), this.onWindowManagerAvailable);
            queueInterface(new IIDHabboLocalizationManager(), this.onLocalizationAvailable);
            queueInterface(new IIDHabboConfigurationManager(), this.onConfigurationAvailable);
        }
        override public function dispose():void
        {
            if (!disposed){
                if (this._windowManager){
                    if (!this._windowManager.disposed){
                        this._windowManager.release(new IIDHabboWindowManager());
                        this._windowManager = null;
                    };
                };
                if (this._SafeStr_11072){
                    if (!this._SafeStr_11072.disposed){
                        this._SafeStr_11072.release(new IIDAvatarRenderManager());
                        this._SafeStr_11072 = null;
                    };
                };
                if (this._localization){
                    if (!this._localization.disposed){
                        this._localization.release(new IIDHabboLocalizationManager());
                        this._localization = null;
                    };
                };
                if (this._SafeStr_10977){
                    if (!this._SafeStr_10977.disposed){
                        this._SafeStr_10977.release(new IIDHabboConfigurationManager());
                        this._SafeStr_10977 = null;
                    };
                };
                if (this._sessionDataManager){
                    if (!this._sessionDataManager.disposed){
                        this._sessionDataManager.release(new IIDSessionDataManager());
                        this._sessionDataManager = null;
                    };
                };
                super.dispose();
            };
        }
        protected function onAvatarRendererAvailable(_arg_1:IID, _arg_2:IUnknown):void
        {
            this._SafeStr_11072 = (_arg_2 as IAvatarRenderManager);
        }
        protected function onWindowManagerAvailable(_arg_1:IID, _arg_2:IUnknown):void
        {
            this._windowManager = (_arg_2 as IHabboWindowManager);
        }
        protected function onLocalizationAvailable(_arg_1:IID, _arg_2:IUnknown):void
        {
            this._localization = (_arg_2 as IHabboLocalizationManager);
        }
        protected function onConfigurationAvailable(_arg_1:IID, _arg_2:IUnknown):void
        {
            this._SafeStr_10977 = (_arg_2 as IHabboConfigurationManager);
        }
        protected function onSessionManagerAvailable(_arg_1:IID, _arg_2:IUnknown):void
        {
            this._sessionDataManager = (_arg_2 as ISessionDataManager);
        }

    }
}//package com.sulake.habbo.friendbar.view

// IID = "_-3KV" (String#7712, DoABC#2)
// onConfigurationAvailable = "_-pU" (String#2202, DoABC#2)
// _localization = "_-07" (String#3703, DoABC#2)
// _SafeStr_10977 = "_-01o" (String#3598, DoABC#2)
// _SafeStr_11072 = "_-2PE" (String#1873, DoABC#2)
// onSessionManagerAvailable = "_-2L1" (String#19847, DoABC#2)
// onAvatarRendererAvailable = "_-Vp" (String#23485, DoABC#2)
// onWindowManagerAvailable = "_-2CG" (String#19494, DoABC#2)
// onLocalizationAvailable = "_-31e" (String#21564, DoABC#2)
// ISessionDataManager = "_-Bk" (String#7907, DoABC#2)
// AbstractView = "_-0VM" (String#4212, DoABC#2)
// IAvatarRenderManager = "_-C9" (String#7915, DoABC#2)
// Component = "_-19A" (String#5060, DoABC#2)
// _sessionDataManager = "_-0kq" (String#149, DoABC#2)



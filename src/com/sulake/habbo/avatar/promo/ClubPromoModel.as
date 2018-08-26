
package com.sulake.habbo.avatar.promo
{
    import com.sulake.habbo.avatar.common.ISideContentModel;
    import com.sulake.habbo.avatar.HabboAvatarEditor;
    import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
    import com.sulake.core.window.IWindowContainer;

    public class ClubPromoModel implements ISideContentModel 
    {

        private var _controller:HabboAvatarEditor;
        private var _view:ClubPromoView;

        public function ClubPromoModel(_arg_1:HabboAvatarEditor)
        {
            this._controller = _arg_1;
        }
        public function dispose():void
        {
            if (this._view){
                this._view.dispose();
                this._view = null;
            };
        }
        public function reset():void
        {
        }
        private function init():void
        {
            if (!this._view){
                this._view = new ClubPromoView(this);
            };
        }
        public function tryClubClothes():void
        {
            this._view.showBuyView();
            if (this._controller){
                this._controller.useClubClothing();
            };
            if (this._controller.manager.communication){
                this._controller.manager.communication.HabboCommunicationManager(null).send(new EventLogMessageComposer("AvatarEditor", "click", "try_club_clothes"));
            };
        }
        public function get controller():HabboAvatarEditor
        {
            return (this._controller);
        }
        public function TradingModel():IWindowContainer
        {
            this.init();
            if (this._view){
                return (this._view.TradingModel());
            };
            return (null);
        }

    }
}//package com.sulake.habbo.avatar.promo

// ISideContentModel = "_-29F" (String#6234, DoABC#2)
// ClubPromoModel = "_-1zj" (String#6027, DoABC#2)
// ClubPromoView = "_-28r" (String#6221, DoABC#2)
// _controller = "_-18D" (String#59, DoABC#2)
// communication = "_-3HD" (String#22171, DoABC#2)
// HabboCommunicationManager = "_-0AQ" (String#809, DoABC#2)
// TradingModel = "_-v8" (String#313, DoABC#2)
// tryClubClothes = "_-0Mo" (String#14944, DoABC#2)
// showBuyView = "_-So" (String#23357, DoABC#2)
// useClubClothing = "_-38P" (String#21819, DoABC#2)
// EventLogMessageComposer = "_-2lH" (String#6984, DoABC#2)



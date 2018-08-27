
package com.sulake.habbo.avatar
{
    import com.sulake.habbo.avatar.structure.IFigureData;
    import com.sulake.core.utils.Map;
    import flash.utils.Dictionary;
    import com.sulake.habbo.avatar.figuredata.FigureData;
    import com.sulake.habbo.avatar.enum.AvatarType;
    import com.sulake.habbo.avatar.common.IAvatarEditorCategoryModel;
    import com.sulake.habbo.avatar.common.ISideContentModel;
    import com.sulake.habbo.avatar.enum.AvatarEditorFigureCategory;
    import com.sulake.habbo.avatar.generic.BodyModel;
    import com.sulake.habbo.avatar.head.HeadModel;
    import com.sulake.habbo.avatar.torso.TorsoModel;
    import com.sulake.habbo.avatar.legs.LegsModel;
    import com.sulake.habbo.avatar.hotlooks.HotLooksModel;
    import com.sulake.habbo.avatar.enum.AvatarEditorSideCategory;
    import com.sulake.habbo.avatar.wardrobe.WardrobeModel;
    import com.sulake.habbo.avatar.promo.ClubPromoModel;
    import com.sulake.habbo.avatar.structure.figure.ISetType;
    import com.sulake.habbo.avatar.structure.figure.IPalette;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.outgoing.register.UpdateFigureDataMessageComposer;
    import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
    import com.sulake.habbo.avatar.common.AvatarEditorGridPartItem;
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import com.sulake.habbo.avatar.common.AvatarEditorGridColorItem;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.common.CategoryData;

    public class HabboAvatarEditor 
    {

        private static const _SafeStr_10221:String = "hr-100.hd-180-7.ch-215-66.lg-270-79.sh-305-62.ha-1002-70.wa-2007";
        private static const _SafeStr_10222:String = "hr-515-33.hd-600-1.ch-635-70.lg-716-66-62.sh-735-68";
        private static const each:int = 2;

        private var _instanceId:uint;
        private var _manager:HabboAvatarEditorManager;
        private var _SafeStr_10224:IFigureData;
        private var _view:AvatarEditorView;
        private var _isInitialized:Boolean = false;
        private var _categories:Map;
        private var _SafeStr_10225:Map;
        private var _SafeStr_10226:Dictionary;
        private var _gender:String;
        private var _figureString:String;
        private var _clubMemberLevel:int = 0;
        private var _SafeStr_10228:Boolean;
        private var _SafeStr_10229:IHabboAvatarEditorDataSaver = null;
        private var _SafeStr_10230:Boolean = false;

        public function HabboAvatarEditor(_arg_1:uint, _arg_2:HabboAvatarEditorManager)
        {
            this._gender = FigureData.M;
            super();
            this._instanceId = _arg_1;
            this._manager = _arg_2;
            this._SafeStr_10224 = this._manager.avatarRenderManager.getFigureData(AvatarType._SafeStr_9974);
        }
        public function dispose():void
        {
            var _local_1:IAvatarEditorCategoryModel;
            var _local_2:ISideContentModel;
            if (this._categories != null){
                for each (_local_1 in this._categories) {
                    _local_1.dispose();
                    _local_1 = null;
                };
                this._categories = null;
            };
            if (this._SafeStr_10225 != null){
                for each (_local_2 in this._SafeStr_10225) {
                    _local_2.dispose();
                    _local_2 = null;
                };
                this._SafeStr_10225 = null;
            };
            if (this._view != null){
                this._view.dispose();
                this._view = null;
            };
            this._SafeStr_10224 = null;
            this._SafeStr_10226 = null;
            this._SafeStr_10229 = null;
        }
        private function init(_arg_1:Array=null):void
        {
            if (this._isInitialized){
                return;
            };
            this._SafeStr_10226 = new Dictionary();
            this._SafeStr_10226[FigureData.M] = new FigureData(this);
            this._SafeStr_10226[FigureData.FEMALE] = new FigureData(this);
            var _local_2:FigureData = this._SafeStr_10226[FigureData.M];
            var _local_3:FigureData = this._SafeStr_10226[FigureData.FEMALE];
            _local_2.loadAvatarData(_SafeStr_10221, FigureData.M);
            _local_3.loadAvatarData(_SafeStr_10222, FigureData.FEMALE);
            this._categories = new Map();
            this._SafeStr_10225 = new Map();
            this._categories.add(AvatarEditorFigureCategory._SafeStr_9987, new BodyModel(this));
            this._categories.add(AvatarEditorFigureCategory._SafeStr_4458, new HeadModel(this));
            this._categories.add(AvatarEditorFigureCategory._SafeStr_7388, new TorsoModel(this));
            this._categories.add(AvatarEditorFigureCategory._SafeStr_7389, new LegsModel(this));
            if ((((_arg_1 == null)) || ((_arg_1.indexOf(AvatarEditorFigureCategory.HOTLOOKS) > -1)))){
                this._categories.add(AvatarEditorFigureCategory.HOTLOOKS, new HotLooksModel(this));
            };
            this._SafeStr_10225.add(AvatarEditorSideCategory._SafeStr_9985, new WardrobeModel(this));
            this._SafeStr_10225.add(AvatarEditorSideCategory._SafeStr_9986, new ClubPromoModel(this));
            this._isInitialized = true;
        }
        public function loadAvatarInEditor(_arg_1:String, _arg_2:String, _arg_3:int=0):void
        {
            var _local_6:IAvatarEditorCategoryModel;
            switch (_arg_2){
                case FigureData.M:
                case "m":
                case "M":
                    _arg_2 = FigureData.M;
                    break;
                case FigureData.FEMALE:
                case "f":
                case "F":
                    _arg_2 = FigureData.FEMALE;
                    break;
            };
            var _local_4:Boolean;
            if (this._clubMemberLevel != _arg_3){
                this._clubMemberLevel = _arg_3;
                _local_4 = true;
            };
            var _local_5:FigureData = this._SafeStr_10226[_arg_2];
            if (_local_5 == null){
                return;
            };
            _local_5.loadAvatarData(_arg_1, _arg_2);
            if (_arg_2 != this.gender){
                this.gender = _arg_2;
                _local_4 = true;
            };
            if (this._figureString != _arg_1){
                this._figureString = _arg_1;
                _local_4 = true;
            };
            if (((this._categories) && (_local_4))){
                for each (_local_6 in this._categories) {
                    _local_6.reset();
                };
            };
            if (this._view != null){
                this._view.update();
            };
        }
        public function getFigureSetType(_arg_1:String):ISetType
        {
            if (this._SafeStr_10224 == null){
                return (null);
            };
            return (this._SafeStr_10224.getSetType(_arg_1));
        }
        public function getPalette(_arg_1:int):IPalette
        {
            if (this._SafeStr_10224 == null){
                return (null);
            };
            return (this._SafeStr_10224.getPalette(_arg_1));
        }
        public function openWindow(_arg_1:IHabboAvatarEditorDataSaver, _arg_2:Array=null, _arg_3:Boolean=false, _arg_4:String=null):IFrameWindow
        {
            this._SafeStr_10229 = _arg_1;
            this._SafeStr_10230 = _arg_3;
            this.init(_arg_2);
            if (this._view == null){
                this._view = new AvatarEditorView(this, _arg_2);
            };
            this.selectDefaultCategory(_arg_2);
            return (this._view.getFrame(_arg_2, _arg_4));
        }
        public function embedToContext(_arg_1:IWindowContainer=null, _arg_2:IHabboAvatarEditorDataSaver=null, _arg_3:Array=null, _arg_4:Boolean=false):Boolean
        {
            this._SafeStr_10229 = _arg_2;
            this._SafeStr_10230 = _arg_4;
            this.init(_arg_3);
            if (this._view == null){
                this._view = new AvatarEditorView(this, _arg_3);
            };
            this._view.embedToContext(_arg_1, _arg_3);
            this.selectDefaultCategory(_arg_3);
            return (true);
        }
        private function selectDefaultCategory(_arg_1:Array):void
        {
            if (((!((_arg_1 == null))) && ((_arg_1.length > 0)))){
                this.toggleAvatarEditorPage(_arg_1[0]);
            }
            else {
                this.toggleAvatarEditorPage(AvatarEditorFigureCategory._SafeStr_9987);
            };
        }
        public function get instanceId():uint
        {
            return (this._instanceId);
        }
        public function hide():void
        {
            this._view.hide();
        }
        public function getCategoryWindowContainer(_arg_1:String):IWindowContainer
        {
            var _local_2:IAvatarEditorCategoryModel = (this._categories.getValue(_arg_1) as IAvatarEditorCategoryModel);
            if (_local_2 != null){
                return (_local_2.getWindowContainer());
            };
            return (null);
        }
        public function getSideContentWindowContainer(_arg_1:String):IWindowContainer
        {
            var _local_2:ISideContentModel = (this._SafeStr_10225.getValue(_arg_1) as ISideContentModel);
            if (_local_2 != null){
                return (_local_2.getWindowContainer());
            };
            return (null);
        }
        public function toggleAvatarEditorPage(_arg_1:String):void
        {
            if (this._view){
                this._view.toggleCategoryView(_arg_1, false);
            };
        }
        public function useClubClothing():void
        {
            if (this._categories == null){
                return;
            };
            if (this._SafeStr_10228){
                return;
            };
            this._SafeStr_10228 = true;
            this.update();
        }
        public function get figureData():FigureData
        {
            return (this._SafeStr_10226[this._gender]);
        }
        public function saveCurrentSelection():void
        {
            var _local_3:UpdateFigureDataMessageComposer;
            var _local_1:String = this.figureData.getFigureString();
            var _local_2:String = this.figureData.gender;
            if (this._SafeStr_10229 != null){
                this._SafeStr_10229.saveFigure(_local_1, _local_2);
            }
            else {
                _local_3 = new UpdateFigureDataMessageComposer(_local_1, _local_2);
                this._manager.communication.getHabboMainConnection(null).send(_local_3);
                _local_3.dispose();
                _local_3 = null;
            };
        }
        public function generateDataContent(_arg_1:IAvatarEditorCategoryModel, _arg_2:String):CategoryData
        {
            var _local_5:int;
            var _local_6:IFigurePartSet;
            var _local_7:AvatarEditorGridPartItem;
            var _local_8:ISetType;
            var _local_9:IPalette;
            var _local_10:Array;
            var _local_11:Array;
            var _local_12:Boolean;
            var _local_13:IPartColor;
            var _local_14:Array;
            var _local_15:Boolean;
            var _local_16:Boolean;
            var _local_17:int;
            var _local_18:AvatarEditorGridColorItem;
            var _local_19:int;
            var _local_20:int;
            var _local_21:BitmapDataAsset;
            var _local_22:BitmapData;
            var _local_23:Boolean;
            var _local_24:Array;
            if (!_arg_1){
                return (null);
            };
            if (!_arg_2){
                return (null);
            };
            var _local_3:Array = [];
            var _local_4:Array = new Array();
            _local_5 = 0;
            while (_local_5 < each) {
                _local_4.push(new Array());
                _local_5++;
            };
            _local_8 = this.getFigureSetType(_arg_2);
            if (!_local_8){
                return (null);
            };
            if (_local_8 != null){
                _local_9 = this.getPalette(_local_8.paletteID);
                if (!_local_9){
                    return (null);
                };
                _local_10 = this.figureData.getColourIds(_arg_2);
                if (!_local_10){
                    _local_10 = new Array();
                };
                _local_11 = new Array(_local_10.length);
                _local_12 = ((this.isClubTryoutAllowed()) && (this._SafeStr_10228));
                for each (_local_13 in _local_9.colors) {
                    if (((_local_13.isSelectable) && (((_local_12) || ((this._clubMemberLevel >= _local_13.clubLevel)))))){
                        _local_17 = 0;
                        while (_local_17 < each) {
                            _local_18 = new AvatarEditorGridColorItem((AvatarEditorView._SafeStr_10174.clone() as IWindowContainer), _arg_1, _local_13);
                            _local_4[_local_17].push(_local_18);
                            _local_17++;
                        };
                        if (_arg_2 != FigureData._SafeStr_5401){
                            _local_19 = 0;
                            while (_local_19 < _local_10.length) {
                                if (_local_13.id == _local_10[_local_19]){
                                    _local_11[_local_19] = _local_13;
                                };
                                _local_19++;
                            };
                        };
                    };
                };
                if (_local_12){
                    _local_20 = 2;
                    _local_14 = this._manager.avatarRenderManager.getMandatoryAvatarPartSetIds(this.gender, _local_20);
                }
                else {
                    _local_14 = this._manager.avatarRenderManager.getMandatoryAvatarPartSetIds(this.gender, this.clubMemberLevel);
                };
                _local_15 = Boolean((_local_14.indexOf(_arg_2) == -1));
                if (_local_15){
                    _local_21 = (this._manager.assets.getAssetByName("removeSelection") as BitmapDataAsset);
                    if (_local_21){
                        _local_22 = (_local_21.content as BitmapData).clone();
                        _local_7 = new AvatarEditorGridPartItem((AvatarEditorView._SafeStr_10173.clone() as IWindowContainer), _arg_1, null, null, false);
                        _local_7.iconImage = _local_22;
                        _local_3.push(_local_7);
                    };
                };
                _local_16 = !((_arg_2 == FigureData._SafeStr_5401));
                for each (_local_6 in _local_8.partSets) {
                    _local_23 = false;
                    if (_local_6.gender == FigureData.U){
                        _local_23 = true;
                    }
                    else {
                        if (_local_6.gender == this.gender){
                            _local_23 = true;
                        };
                    };
                    if (((((_local_6.isSelectable) && (_local_23))) && (((_local_12) || ((this._clubMemberLevel >= _local_6.clubLevel)))))){
                        _local_7 = new AvatarEditorGridPartItem((AvatarEditorView._SafeStr_10173.clone() as IWindowContainer), _arg_1, _local_6, _local_11, _local_16);
                        _local_3.push(_local_7);
                    };
                };
            };
            _local_3.sort(this.orderByClub);
            _local_5 = 0;
            while (_local_5 < each) {
                _local_24 = (_local_4[_local_5] as Array);
                _local_24.sort(this.orderPaletteByClub);
                _local_5++;
            };
            return (new CategoryData(_local_3, _local_4));
        }
        public function isClubTryoutAllowed():Boolean
        {
            return (this._manager.configuration.getBoolean("avatareditor.allowclubtryout", false));
        }
        public function isSideContentEnabled():Boolean
        {
            return (this._SafeStr_10230);
        }
        public function hasInvalidClubItems():Boolean
        {
            var _local_2:IAvatarEditorCategoryModel;
            var _local_3:Boolean;
            var _local_1:Boolean;
            for each (_local_2 in this._categories) {
                _local_3 = _local_2.hasClubItemsOverLevel(this.clubMemberLevel);
                if (_local_3){
                    _local_1 = true;
                };
            };
            return (_local_1);
        }
        public function stripClubItems():void
        {
            var _local_1:IAvatarEditorCategoryModel;
            for each (_local_1 in this._categories) {
                _local_1.stripClubItemsOverLevel(this.clubMemberLevel);
            };
            this.figureData.updateView();
        }
        public function getDefaultColour(_arg_1:String):int
        {
            var _local_3:IPalette;
            var _local_4:IPartColor;
            var _local_2:ISetType = this.getFigureSetType(_arg_1);
            if (_local_2 != null){
                _local_3 = this.getPalette(_local_2.paletteID);
                for each (_local_4 in _local_3.colors) {
                    if (((_local_4.isSelectable) && ((this._clubMemberLevel >= _local_4.clubLevel)))){
                        return (_local_4.id);
                    };
                };
            };
            return (-1);
        }
        private function orderByClub(_arg_1:AvatarEditorGridPartItem, _arg_2:AvatarEditorGridPartItem):Number
        {
            var _local_3:Number = (((_arg_1.partSet)==null) ? -1 : Number(_arg_1.partSet.clubLevel));
            var _local_4:Number = (((_arg_2.partSet)==null) ? -1 : Number(_arg_2.partSet.clubLevel));
            if (_local_3 < _local_4){
                return (-1);
            };
            if (_local_3 > _local_4){
                return (1);
            };
            if (_arg_1.partSet.id < _arg_2.partSet.id){
                return (-1);
            };
            if (_arg_1.partSet.id > _arg_2.partSet.id){
                return (1);
            };
            return (0);
        }
        private function orderPaletteByClub(_arg_1:AvatarEditorGridColorItem, _arg_2:AvatarEditorGridColorItem):Number
        {
            var _local_3:Number = (((_arg_1.partColor)==null) ? -1 : (_arg_1.partColor.clubLevel as Number));
            var _local_4:Number = (((_arg_2.partColor)==null) ? -1 : (_arg_2.partColor.clubLevel as Number));
            if (_local_3 < _local_4){
                return (-1);
            };
            if (_local_3 > _local_4){
                return (1);
            };
            if (_arg_1.partColor.index < _arg_2.partColor.index){
                return (-1);
            };
            if (_arg_1.partColor.index > _arg_2.partColor.index){
                return (1);
            };
            return (0);
        }
        public function get gender():String
        {
            return (this._gender);
        }
        public function set gender(_arg_1:String):void
        {
            var _local_2:IAvatarEditorCategoryModel;
            if (this._gender == _arg_1){
                return;
            };
            this._gender = _arg_1;
            for each (_local_2 in this._categories) {
                _local_2.reset();
            };
            if (this._view != null){
                this._view.update();
            };
        }
        public function get handler():AvatarEditorMessageHandler
        {
            return (this._manager.handler);
        }
        public function get wardrobe():WardrobeModel
        {
            if (!this._isInitialized){
                return (null);
            };
            return (this._SafeStr_10225.getValue(AvatarEditorSideCategory._SafeStr_9985));
        }
        public function set clubMemberLevel(_arg_1:int):void
        {
            this._clubMemberLevel = _arg_1;
        }
        public function get clubMemberLevel():int
        {
            return (this._clubMemberLevel);
        }
        public function get manager():HabboAvatarEditorManager
        {
            return (this._manager);
        }
        public function update():void
        {
            var _local_1:IAvatarEditorCategoryModel;
            var _local_2:ISideContentModel;
            for each (_local_1 in this._categories) {
                _local_1.reset();
            };
            for each (_local_2 in this._SafeStr_10225) {
                _local_2.reset();
            };
            if (this._view){
                this._view.update();
            };
        }

    }
}//package com.sulake.habbo.avatar

// U = "_-2LT" (String#19866, DoABC#2)
// loadAvatarData = "_-DD" (String#22738, DoABC#2)
// getDefaultColour = "_-1PO" (String#17483, DoABC#2)
// getSetType = "_-0CE" (String#3795, DoABC#2)
// _SafeStr_10173 = "_-20g" (String#19038, DoABC#2)
// _SafeStr_10174 = "_-0YN" (String#15374, DoABC#2)
// isSideContentEnabled = "_-j" (String#23999, DoABC#2)
// isClubTryoutAllowed = "_-05h" (String#14269, DoABC#2)
// toggleCategoryView = "_-wV" (String#24553, DoABC#2)
// getSideContentWindowContainer = "_-24M" (String#19193, DoABC#2)
// getCategoryWindowContainer = "_-1yQ" (String#18906, DoABC#2)
// toggleAvatarEditorPage = "_-2Od" (String#19990, DoABC#2)
// hasInvalidClubItems = "_-1Si" (String#17611, DoABC#2)
// saveCurrentSelection = "_-1ER" (String#17045, DoABC#2)
// stripClubItems = "_-bD" (String#23678, DoABC#2)
// getFigureData = "_-2tG" (String#7143, DoABC#2)
// getMandatoryAvatarPartSetIds = "_-1un" (String#5934, DoABC#2)
// _SafeStr_10221 = "_-1c1" (String#17973, DoABC#2)
// _SafeStr_10222 = "_-0Bh" (String#14515, DoABC#2)
// _manager = "_-2RM" (String#20094, DoABC#2)
// _SafeStr_10224 = "_-0Ur" (String#15237, DoABC#2)
// _SafeStr_10225 = "_-0ea" (String#15608, DoABC#2)
// _SafeStr_10226 = "_-1t9" (String#18684, DoABC#2)
// _clubMemberLevel = "_-15N" (String#16669, DoABC#2)
// _SafeStr_10228 = "_-31W" (String#21559, DoABC#2)
// _SafeStr_10229 = "_-3Hk" (String#22191, DoABC#2)
// _SafeStr_10230 = "_-hu" (String#23960, DoABC#2)
// getFigureSetType = "_-2MK" (String#19897, DoABC#2)
// selectDefaultCategory = "_-O1" (String#23169, DoABC#2)
// orderByClub = "_-0OW" (String#15008, DoABC#2)
// orderPaletteByClub = "_-1n0" (String#18422, DoABC#2)
// BitmapDataAsset = "_-0PB" (String#4074, DoABC#2)
// IFigureData = "_-Ip" (String#8057, DoABC#2)
// IFigurePartSet = "_-5Y" (String#7773, DoABC#2)
// AvatarType = "_-0ST" (String#15153, DoABC#2)
// ISetType = "_-Gf" (String#8011, DoABC#2)
// IHabboAvatarEditorDataSaver = "_-0EA" (String#3831, DoABC#2)
// AvatarEditorMessageHandler = "_-2jV" (String#6945, DoABC#2)
// IPartColor = "_-1dO" (String#5620, DoABC#2)
// IPalette = "_-UT" (String#8293, DoABC#2)
// FigureData = "_-1BT" (String#836, DoABC#2)
// UpdateFigureDataMessageComposer = "_-0Qz" (String#15101, DoABC#2)
// IAvatarEditorCategoryModel = "_-1mx" (String#5798, DoABC#2)
// AvatarEditorGridColorItem = "_-14G" (String#4963, DoABC#2)
// AvatarEditorSideCategory = "_-0s9" (String#4689, DoABC#2)
// ISideContentModel = "_-29F" (String#6234, DoABC#2)
// ClubPromoModel = "_-1zj" (String#6027, DoABC#2)
// AvatarEditorView = "_-06P" (String#3690, DoABC#2)
// CategoryData = "_-2jI" (String#6943, DoABC#2)
// TorsoModel = "_-0cj" (String#4359, DoABC#2)
// AvatarEditorFigureCategory = "_-nF" (String#8661, DoABC#2)
// AvatarEditorGridPartItem = "_-xW" (String#8833, DoABC#2)
// _gender = "_-a0" (String#95, DoABC#2)
// handler = "_-06s" (String#1404, DoABC#2)
// getFrame = "_-3Jk" (String#923, DoABC#2)
// _SafeStr_4458 = "_-327" (String#21586, DoABC#2)
// communication = "_-3HD" (String#22171, DoABC#2)
// getHabboMainConnection = "_-0AQ" (String#809, DoABC#2)
// _categories = "_-EJ" (String#373, DoABC#2)
// getWindowContainer = "_-v8" (String#313, DoABC#2)
// M = "_-1c3" (String#17974, DoABC#2)
// iconImage = "_-0Pn" (String#4088, DoABC#2)
// _SafeStr_5401 = "_-06A" (String#14290, DoABC#2)
// _instanceId = "_-1cJ" (String#854, DoABC#2)
// instanceId = "_-044" (String#3649, DoABC#2)
// isSelectable = "_-30A" (String#1985, DoABC#2)
// useClubClothing = "_-38P" (String#21819, DoABC#2)
// updateView = "_-1Js" (String#847, DoABC#2)
// paletteID = "_-0BG" (String#3784, DoABC#2)
// partSets = "_-0L3" (String#3979, DoABC#2)
// _figureString = "_-30g" (String#1986, DoABC#2)
// _SafeStr_7388 = "_-0YE" (String#15366, DoABC#2)
// _SafeStr_7389 = "_-3HR" (String#22176, DoABC#2)
// saveFigure = "_-2M0" (String#6483, DoABC#2)
// openWindow = "_-1na" (String#18444, DoABC#2)
// getFigureString = "_-0-z" (String#3563, DoABC#2)
// hasClubItemsOverLevel = "_-0bi" (String#4340, DoABC#2)
// stripClubItemsOverLevel = "_-0C1" (String#3793, DoABC#2)
// generateDataContent = "_-15w" (String#16694, DoABC#2)
// partColor = "_-1Sa" (String#17605, DoABC#2)
// _SafeStr_9974 = "_-m7" (String#24114, DoABC#2)
// _SafeStr_9985 = "_-0g7" (String#15676, DoABC#2)
// _SafeStr_9986 = "_-0vi" (String#16264, DoABC#2)
// _SafeStr_9987 = "_-qw" (String#24312, DoABC#2)



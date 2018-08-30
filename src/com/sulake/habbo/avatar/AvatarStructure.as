
package com.sulake.habbo.avatar
{
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.habbo.avatar.geometry.AvatarModelGeometry;
    import com.sulake.habbo.avatar.actions.AvatarActionManager;
    import com.sulake.habbo.avatar.structure.FigureData;
    import com.sulake.habbo.avatar.structure.PartSetsData;
    import com.sulake.habbo.avatar.structure.AnimationData;
    import com.sulake.habbo.avatar.animation.AnimationManager;
    import com.sulake.habbo.avatar.actions.ActionDefinition;
    import com.sulake.habbo.avatar.structure.parts.PartOffsetData;
    import flash.utils.Dictionary;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.avatar.enum.AvatarType;
    import com.sulake.core.assets.AssetLibraryCollection;
    import com.sulake.habbo.avatar.structure.figure.ISetType;
    import com.sulake.habbo.avatar.structure.figure.IPalette;
    import com.sulake.habbo.avatar.structure.figure.IPartColor;
    import com.sulake.habbo.avatar.animation.AnimationLayerData;
    import com.sulake.habbo.avatar.animation.Animation;
    import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
    import com.sulake.habbo.avatar.structure.AvatarCanvas;
    import com.sulake.habbo.avatar.geometry.GeometryBodyPart;
    import com.sulake.habbo.avatar.structure.parts.PartDefinition;
    import com.sulake.habbo.avatar.animation.AddDataContainer;
    import com.sulake.habbo.avatar.actions.IActiveActionData;
    import com.sulake.habbo.avatar.enum.AvatarDirectionAngle;
    import com.sulake.habbo.avatar.structure.animation.ActionPart;
    import com.sulake.habbo.avatar.geometry.GeometryItem;
    import com.sulake.habbo.avatar.structure.figure.IFigurePart;
    import com.sulake.habbo.avatar.actions.IActionDefinition;
    import com.sulake.habbo.avatar.structure.animation.AnimationAction;
    import flash.geom.Point;
    import com.sulake.habbo.avatar.structure.IFigureData;
    import flash.display.Shape;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import flash.text.TextField;
    import flash.geom.Matrix;
    import flash.display.Stage;
    import com.sulake.habbo.avatar.structure.*;

    public class AvatarStructure extends EventDispatcher 
    {

        private var _renderManager:AvatarRenderManager;
        private var _geometry:AvatarModelGeometry;
        private var _SafeStr_10144:AvatarActionManager;
        private var _figureData:FigureData;
        private var _SafeStr_10146:PartSetsData;
        private var _animationData:AnimationData;
        private var _animationManager:AnimationManager;
        private var _defaultAction:ActionDefinition;
        private var _avatarType:String;
        private var _SafeStr_10148:PartOffsetData;
        private var _SafeStr_10149:Dictionary;

        public function AvatarStructure(_arg_1:AvatarRenderManager, _arg_2:String, _arg_3:PartOffsetData)
        {
            this._renderManager = _arg_1;
            this._figureData = new FigureData();
            this._SafeStr_10146 = new PartSetsData();
            this._animationData = new AnimationData();
            this._animationManager = new AnimationManager();
            this._avatarType = _arg_2;
            this._SafeStr_10149 = new Dictionary();
            this._SafeStr_10148 = _arg_3;
        }
        override public function dispose():void
        {
            if (!disposed){
                super.dispose();
                this._renderManager = null;
                this._figureData = null;
                this._SafeStr_10146 = null;
                this._animationData = null;
                this._SafeStr_10149 = null;
                this._SafeStr_10148 = null;
            };
        }
        public function resetPartOffsets(_arg_1:IAssetLibrary):void
        {
            this._SafeStr_10148.loadOffsets(_arg_1);
        }
        public function initGeometry(_arg_1:XML):void
        {
            if (!_arg_1){
                Logger.log(("[AvatarStructure] Could not init Geometry for structure: " + this._avatarType));
                return;
            };
            this._geometry = new AvatarModelGeometry(_arg_1);
        }
        public function initActions(_arg_1:IAssetLibrary, _arg_2:XML):void
        {
            if (!_arg_2){
                Logger.log(("[AvatarStructure] Could not init Actions for structure: " + this._avatarType));
                return;
            };
            this._SafeStr_10144 = new AvatarActionManager(_arg_1, this._avatarType, _arg_2);
            this._defaultAction = this._SafeStr_10144.getDefaultAction();
        }
        public function initPartSets(_arg_1:XML):Boolean
        {
            if (!_arg_1){
                Logger.log(("[AvatarStructure] Could not init Part Sets for structure: " + this._avatarType));
                return (false);
            };
            if (this._SafeStr_10146.parse(_arg_1)){
                if (this._avatarType == AvatarType._SafeStr_9974){
                    this._SafeStr_10146.getPartDefinition("ri").appendToFigure = true;
                    this._SafeStr_10146.getPartDefinition("li").appendToFigure = true;
                };
                return (true);
            };
            return (false);
        }
        public function initAnimation(_arg_1:XML):Boolean
        {
            if (!_arg_1){
                Logger.log(("[AvatarStructure] Could not init Animations for structure: " + this._avatarType));
                return (false);
            };
            return (this._animationData.parse(_arg_1));
        }
        public function initFigureData(_arg_1:XML):Boolean
        {
            if (!_arg_1){
                Logger.log(("[AvatarStructure] Could not init Figure Data for structure: " + this._avatarType));
                return (false);
            };
            return (this._figureData.parse(_arg_1));
        }
        public function injectFigureData(_arg_1:XML):void
        {
            this._figureData.injectXML(_arg_1);
        }
        public function registerAnimations(_arg_1:AssetLibraryCollection, _arg_2:String="fx", _arg_3:int=200):void
        {
            var _local_4:XML;
            var _local_5:int;
            while (_local_5 < _arg_3) {
                if (_arg_1.hasAsset((_arg_2 + _local_5))){
                    _local_4 = (_arg_1.getAssetByName((_arg_2 + _local_5)).content as XML);
                    this._animationManager.registerAnimation(this, _local_4);
                };
                _local_5++;
            };
        }
        public function getPartColor(_arg_1:IAvatarFigureContainer, _arg_2:String, _arg_3:int=0):IPartColor
        {
            var _local_4:Array = _arg_1.getPartColorIds(_arg_2);
            if (((!(_local_4)) || ((_local_4.length < _arg_3)))){
                return (null);
            };
            var _local_5:ISetType = this._figureData.getSetType(_arg_2);
            if (_local_5 == null){
                return (null);
            };
            var _local_6:IPalette = this._figureData.getPalette(_local_5.paletteID);
            if (!_local_6){
                return (null);
            };
            return (_local_6.getColor(_local_4[_arg_3]));
        }
        public function getBodyPartData(_arg_1:String, _arg_2:int, _arg_3:String):AnimationLayerData
        {
            return ((this._animationManager.getLayerData(_arg_1, _arg_2, _arg_3) as AnimationLayerData));
        }
        public function getAnimation(_arg_1:String):Animation
        {
            return ((this._animationManager.getAnimation(_arg_1) as Animation));
        }
        public function getActionDefinition(_arg_1:String):ActionDefinition
        {
            return (this._SafeStr_10144.getActionDefinition(_arg_1));
        }
        public function getActionDefinitionWithState(_arg_1:String):ActionDefinition
        {
            return (this._SafeStr_10144.getActionDefinitionWithState(_arg_1));
        }
        public function isMainAvatarSet(_arg_1:String):Boolean
        {
            return (this._geometry.isMainAvatarSet(_arg_1));
        }
        public function sortActions(_arg_1:Array):Array
        {
            return (this._SafeStr_10144.sortActions(_arg_1));
        }
        public function getMandatorySetTypeIds(_arg_1:String, _arg_2:int):Array
        {
            if (!this._SafeStr_10149[_arg_1]){
                this._SafeStr_10149[_arg_1] = new Dictionary();
            };
            if (this._SafeStr_10149[_arg_1][_arg_2]){
                return (this._SafeStr_10149[_arg_1][_arg_2]);
            };
            this._SafeStr_10149[_arg_1][_arg_2] = this._figureData.getMandatorySetTypeIds(_arg_1, _arg_2);
            return (this._SafeStr_10149[_arg_1][_arg_2]);
        }
        public function getDefaultPartSet(_arg_1:String, _arg_2:String):IFigurePartSet
        {
            return (this._figureData.getDefaultPartSet(_arg_1, _arg_2));
        }
        public function getCanvasOffsets(_arg_1:Array, _arg_2:String, _arg_3:int):Array
        {
            return (this._SafeStr_10144.getCanvasOffsets(_arg_1, _arg_2, _arg_3));
        }
        public function getCanvas(_arg_1:String, _arg_2:String):AvatarCanvas
        {
            return (this._geometry.getCanvas(_arg_1, _arg_2));
        }
        public function removeDynamicItems():void
        {
            this._geometry.removeDynamicItems();
        }
        public function getActiveBodyPartIds(_arg_1:IActiveActionData):Array
        {
            var _local_5:GeometryBodyPart;
            var _local_6:String;
            var _local_7:Animation;
            var _local_8:String;
            var _local_9:PartDefinition;
            var _local_10:XML;
            var _local_11:XML;
            var _local_12:AddDataContainer;
            var _local_13:String;
            var _local_2:Array = [];
            var _local_3:Array = new Array();
            var _local_4:String = _arg_1.definition.geometryType;
            if (_arg_1.definition.isAnimation){
                _local_6 = ((_arg_1.definition.state + ".") + _arg_1.actionParameter);
                _local_7 = (this._animationManager.getAnimation(_local_6) as Animation);
                if (_local_7 != null){
                    _local_2 = _local_7.getAnimatedBodyPartIds(0, _arg_1.overridingAction);
                    if (_local_7.hasAddData()){
                        _local_10 = <item id="" x="0" y="0" z="0" radius="0.01" nx="0" ny="0" nz="-1" double="1"/>
                        ;
                        _local_11 = <part/>
                        ;
                        for each (_local_12 in _local_7.addData) {
                            _local_5 = this._geometry.getBodyPart(_local_4, _local_12.align);
                            if (_local_5 != null){
                                _local_10.@id = _local_12.id;
                                _local_5.addPart(_local_10);
                                _local_11.@["set-type"] = _local_12.id;
                                _local_9 = this._SafeStr_10146.addPartDefinition(_local_11);
                                _local_9.appendToFigure = true;
                                if (_local_12.base == ""){
                                    _local_9.staticId = 1;
                                };
                                if (_local_3.indexOf(_local_5.id) == -1){
                                    _local_3.push(_local_5.id);
                                };
                            };
                        };
                    };
                };
                for each (_local_8 in _local_2) {
                    _local_5 = this._geometry.getBodyPart(_local_4, _local_8);
                    if (_local_5 != null){
                        if (_local_3.indexOf(_local_5.id) == -1){
                            _local_3.push(_local_5.id);
                        };
                    };
                };
            }
            else {
                _local_2 = this._SafeStr_10146.getActiveParts(_arg_1.definition);
                for each (_local_13 in _local_2) {
                    _local_5 = this._geometry.getBodyPartOfItem(_local_4, _local_13);
                    if (_local_5 != null){
                        if (_local_3.indexOf(_local_5.id) == -1){
                            _local_3.push(_local_5.id);
                        };
                    };
                };
            };
            return (_local_3);
        }
        public function getBodyPartsUnordered(_arg_1:String):Array
        {
            return (this._geometry.getBodyPartIdsInAvatarSet(_arg_1));
        }
        public function getBodyParts(_arg_1:String, _arg_2:String, _arg_3:int):Array
        {
            var _local_4:Number = AvatarDirectionAngle._SafeStr_9981[_arg_3];
            return (this._geometry.getBodyPartsAtAngle(_arg_1, _local_4, _arg_2));
        }
        public function getParts(_arg_1:String, _arg_2:IAvatarFigureContainer, _arg_3:IActiveActionData, _arg_4:String, _arg_5:int, _arg_6:Array, _arg_7:Dictionary=null):Array
        {
            var _local_9:Animation;
            var _local_11:String;
            var _local_12:PartDefinition;
            var _local_16:String;
            var _local_17:AvatarImagePartContainer;
            var _local_18:ActionPart;
            var _local_19:Array;
            var _local_21:Array;
            var _local_22:AvatarImagePartContainer;
            var _local_23:String;
            var _local_24:String;
            var _local_25:GeometryBodyPart;
            var _local_26:GeometryItem;
            var _local_27:int;
            var _local_28:Array;
            var _local_29:ISetType;
            var _local_30:IPalette;
            var _local_31:IFigurePartSet;
            var _local_32:IFigurePart;
            var _local_33:IActionDefinition;
            var _local_34:String;
            var _local_35:IPartColor;
            var _local_36:Boolean;
            var _local_37:Boolean;
            var _local_38:String;
            var _local_39:int;
            var _local_40:int;
            var _local_41:GeometryBodyPart;
            var _local_42:Boolean;
            var _local_43:Number;
            var _local_44:String;
            var _local_45:AddDataContainer;
            if (_arg_3 == null){
                Logger.log(("[AvatarStructure] getParts action == NULL!! bodyPartId: " + _arg_1));
                return ([]);
            };
            var _local_8:Array = this._SafeStr_10146.getActiveParts(_arg_3.definition);
            var _local_10:Array = new Array();
            var _local_13:Array = [0];
            var _local_14:AnimationAction = this._animationData.getAction(_arg_3.definition);
            if (_arg_3.definition.isAnimation){
                _local_23 = ((_arg_3.definition.state + ".") + _arg_3.actionParameter);
                _local_9 = (this._animationManager.getAnimation(_local_23) as Animation);
                if (_local_9 != null){
                    _local_13 = this.getPopulatedArray(_local_9.frameCount(_arg_3.overridingAction));
                    for each (_local_24 in _local_9.getAnimatedBodyPartIds(0, _arg_3.overridingAction)) {
                        if (_local_24 == _arg_1){
                            _local_25 = this._geometry.getBodyPart(_arg_4, _local_24);
                            if (_local_25 != null){
                                for each (_local_26 in _local_25.getDynamicParts()) {
                                    _local_8.push(_local_26.id);
                                };
                            };
                        };
                    };
                };
            };
            var _local_15:Array = this._geometry.getParts(_arg_4, _arg_1, _arg_5, _local_8);
            var _local_20:Array = _arg_2.getPartTypeIds();
            for each (_local_16 in _local_20) {
                if (_arg_7 != null){
                    if (_arg_7[_local_16] != null) continue;
                };
                _local_27 = _arg_2.getPartSetId(_local_16);
                _local_28 = _arg_2.getPartColorIds(_local_16);
                _local_29 = this._figureData.getSetType(_local_16);
                if (_local_29){
                    _local_30 = this._figureData.getPalette(_local_29.paletteID);
                    if (_local_30){
                        _local_31 = _local_29.getPartSet(_local_27);
                        if (_local_31){
                            _arg_6 = _arg_6.concat(_local_31.hiddenLayers);
                            for each (_local_32 in _local_31.parts) {
                                if (_local_15.indexOf(_local_32.type) > -1){
                                    if (_local_14 != null){
                                        _local_18 = _local_14.getPart(_local_32.type);
                                        if (_local_18 != null){
                                            _local_19 = _local_18.frames;
                                        }
                                        else {
                                            _local_19 = _local_13;
                                        };
                                    }
                                    else {
                                        _local_19 = _local_13;
                                    };
                                    _local_33 = _arg_3.definition;
                                    if (_local_8.indexOf(_local_32.type) == -1){
                                        _local_33 = this._defaultAction;
                                    };
                                    _local_12 = this._SafeStr_10146.getPartDefinition(_local_32.type);
                                    _local_34 = (((_local_12)==null) ? _local_32.type : _local_12.flippedSetType);
                                    if (_local_34 == ""){
                                        _local_34 = _local_32.type;
                                    };
                                    if (((_local_28) && ((_local_28.length > (_local_32.colorLayerIndex - 1))))){
                                        _local_35 = _local_30.getColor(_local_28[(_local_32.colorLayerIndex - 1)]);
                                    };
                                    _local_36 = (_local_32.colorLayerIndex > 0);
                                    _local_17 = new AvatarImagePartContainer(_arg_1, _local_32.type, _local_32.id.toString(), _local_35, _local_19, _local_33, _local_36, _local_32.paletteMap, _local_34);
                                    _local_10.push(_local_17);
                                };
                            };
                        };
                    };
                };
            };
            _local_21 = new Array();
            for each (_local_11 in _local_15) {
                _local_37 = false;
                for each (_local_22 in _local_10) {
                    if (_local_22._SafeStr_7968 == _local_11){
                        _local_37 = true;
                        if (_arg_6.indexOf(_local_11) == -1){
                            _local_21.push(_local_22);
                        };
                    };
                };
                if (!_local_37){
                    if (((_arg_7) && (_arg_7[_local_11]))){
                        _local_38 = _arg_7[_local_11];
                        _local_39 = 0;
                        _local_40 = 0;
                        while (_local_40 < _local_38.length) {
                            _local_39 = (_local_39 + _local_38.charCodeAt(_local_40));
                            _local_40++;
                        };
                        if (_local_14 != null){
                            _local_18 = _local_14.getPart(_local_11);
                            if (_local_18 != null){
                                _local_19 = _local_18.frames;
                            }
                            else {
                                _local_19 = _local_13;
                            };
                        }
                        else {
                            _local_19 = _local_13;
                        };
                        _local_17 = new AvatarImagePartContainer(_arg_1, _local_11, _local_38, null, _local_19, _arg_3.definition, false, -1, _local_11, false, 1);
                        _local_21.push(_local_17);
                    };
                    if (_local_8.indexOf(_local_11) > -1){
                        _local_41 = this._geometry.getBodyPartOfItem(_arg_4, _local_11);
                        if (_arg_1 != _local_41.id){
                            Logger.log(((("BodypartId mismatch:" + _arg_1) + " ") + _local_41.id));
                        }
                        else {
                            _local_12 = this._SafeStr_10146.getPartDefinition(_local_11);
                            _local_42 = false;
                            _local_43 = 1;
                            if (_local_12.appendToFigure){
                                Logger.log(("PART NOT FOUND, ALTHOUGH IT SHOULD HAVE BEEN! Add now?" + _local_11));
                                _local_44 = "1";
                                if (_arg_3.actionParameter != ""){
                                    _local_44 = _arg_3.actionParameter;
                                };
                                if (_local_12.hasStaticId()){
                                    _local_44 = _local_12.staticId.toString();
                                };
                                if (_local_9 != null){
                                    _local_45 = _local_9.getAddData(_local_11);
                                    if (_local_45 != null){
                                        _local_42 = _local_45.isBlended;
                                        _local_43 = _local_45.blend;
                                    };
                                };
                                if (_local_14 != null){
                                    _local_18 = _local_14.getPart(_local_11);
                                    if (_local_18 != null){
                                        _local_19 = _local_18.frames;
                                    }
                                    else {
                                        _local_19 = _local_13;
                                    };
                                }
                                else {
                                    _local_19 = _local_13;
                                };
                                _local_17 = new AvatarImagePartContainer(_arg_1, _local_11, _local_44, null, _local_19, _arg_3.definition, false, -1, _local_11, _local_42, _local_43);
                                _local_21.push(_local_17);
                            };
                        };
                    };
                };
            };
            return (_local_21);
        }
        public function getPartActionOffset(_arg_1:int, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:int, _arg_6:int):Point
        {
            return (this._SafeStr_10148.getOffset(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6));
        }
        public function get figureData():IFigureData
        {
            return (this._figureData);
        }
        public function get renderManager():AvatarRenderManager
        {
            return (this._renderManager);
        }
        public function get avatarType():String
        {
            return (this._avatarType);
        }
        public function get animationManager():AnimationManager
        {
            return (this._animationManager);
        }
        private function getPopulatedArray(_arg_1:int):Array
        {
            var _local_2:Array = new Array();
            var _local_3:int;
            while (_local_3 < _arg_1) {
                _local_2.push(_local_3);
                _local_3++;
            };
            return (_local_2);
        }
        public function displayGeometry(_arg_1:Stage):void
        {
            var _local_9:String;
            var _local_10:GeometryBodyPart;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:Shape;
            var _local_2:BitmapData = new BitmapData(960, 540, false, 0xFFFFFFFF);
            var _local_3:Bitmap = new Bitmap(_local_2);
            _arg_1.addChild(_local_3);
            var _local_4:Number = (_local_2.width / 2);
            var _local_5:Number = (_local_2.height / 2);
            var _local_6:Number = 200;
            var _local_7:TextField = new TextField();
            var _local_8:Matrix = new Matrix();
            for each (_local_9 in this._geometry.getBodyPartIdsInAvatarSet("full")) {
                _local_10 = this._geometry.getBodyPart("vertical", _local_9);
                Logger.log(("Drawing bodypart : " + _local_9));
                if (_local_10 != null){
                    _local_11 = (_local_10.location.x * _local_6);
                    _local_12 = (_local_10.location.z * _local_6);
                    _local_13 = (_local_10.radius * _local_6);
                    _local_14 = new Shape();
                    _local_14.graphics.lineStyle(1, 0xFFFF0000, 1);
                    _local_14.graphics.drawCircle((_local_4 + _local_11), (_local_5 + _local_12), _local_13);
                    _local_2.draw(_local_14);
                    _local_7.text = _local_9;
                    _local_7.textColor = 0xFFFF0000;
                    _local_8.identity();
                    _local_8.tx = ((((_local_4 + _local_11) + _local_13) - _local_7.textWidth) - 5);
                    _local_8.ty = ((_local_5 + _local_12) - 5);
                    _local_2.draw(_local_7, _local_8);
                }
                else {
                    Logger.log(("Could not draw bodypart : " + _local_9));
                };
            };
        }

    }
}//package com.sulake.habbo.avatar

// loadOffsets = "_-2R4" (String#20087, DoABC#2)
// getOffset = "_-2Cj" (String#19513, DoABC#2)
// hasStaticId = "_-89" (String#22547, DoABC#2)
// staticId = "_-b8" (String#23673, DoABC#2)
// flippedSetType = "_-0gz" (String#15709, DoABC#2)
// appendToFigure = "_-f8" (String#23851, DoABC#2)
// getSetType = "_-0CE" (String#3795, DoABC#2)
// getActiveParts = "_-21V" (String#19074, DoABC#2)
// getPartDefinition = "_-2sz" (String#21199, DoABC#2)
// addPartDefinition = "_-En" (String#22804, DoABC#2)
// injectXML = "_-2X3" (String#20325, DoABC#2)
// getMandatorySetTypeIds = "_-1Qh" (String#17541, DoABC#2)
// getPartTypeIds = "_-2ig" (String#6925, DoABC#2)
// getPartColorIds = "_-AZ" (String#7879, DoABC#2)
// getBodyPartData = "_-0FK" (String#14657, DoABC#2)
// getPartActionOffset = "_-0tW" (String#16180, DoABC#2)
// _SafeStr_10144 = "_-30F" (String#21510, DoABC#2)
// _figureData = "_-2IV" (String#19746, DoABC#2)
// _SafeStr_10146 = "_-27T" (String#19311, DoABC#2)
// _animationManager = "_-0Mi" (String#14940, DoABC#2)
// _SafeStr_10148 = "_-hV" (String#23949, DoABC#2)
// _SafeStr_10149 = "_-1bk" (String#17963, DoABC#2)
// resetPartOffsets = "_-19j" (String#16845, DoABC#2)
// initGeometry = "_-3JM" (String#22258, DoABC#2)
// initActions = "_-0PK" (String#15036, DoABC#2)
// initPartSets = "_-2QC" (String#20054, DoABC#2)
// initAnimation = "_-2Ou" (String#19998, DoABC#2)
// initFigureData = "_-1xy" (String#18885, DoABC#2)
// injectFigureData = "_-2vT" (String#7186, DoABC#2)
// registerAnimations = "_-2dG" (String#20574, DoABC#2)
// getPopulatedArray = "_-2Fu" (String#19639, DoABC#2)
// avatarType = "_-1wH" (String#18810, DoABC#2)
// animationManager = "_-Me" (String#23111, DoABC#2)
// displayGeometry = "_-0-a" (String#14035, DoABC#2)
// AssetLibraryCollection = "_-2Pg" (String#6555, DoABC#2)
// IAvatarFigureContainer = "_-2-D" (String#6034, DoABC#2)
// IFigureData = "_-Ip" (String#8057, DoABC#2)
// IFigurePartSet = "_-5Y" (String#7773, DoABC#2)
// AvatarType = "_-0ST" (String#15153, DoABC#2)
// ISetType = "_-Gf" (String#8011, DoABC#2)
// PartOffsetData = "_-8B" (String#22548, DoABC#2)
// AvatarStructure = "_-2PN" (String#6550, DoABC#2)
// Animation = "_-2Eu" (String#1841, DoABC#2)
// IPartColor = "_-1dO" (String#5620, DoABC#2)
// ActionDefinition = "_-1nw" (String#864, DoABC#2)
// IPalette = "_-UT" (String#8293, DoABC#2)
// IActiveActionData = "_-1An" (String#5087, DoABC#2)
// AvatarImagePartContainer = "_-39w" (String#7510, DoABC#2)
// AvatarDirectionAngle = "_-22R" (String#6097, DoABC#2)
// AvatarCanvas = "_-1UP" (String#5441, DoABC#2)
// IActionDefinition = "_-2ON" (String#6527, DoABC#2)
// AnimationData = "_-vF" (String#948, DoABC#2)
// AddDataContainer = "_-13k" (String#4948, DoABC#2)
// AnimationManager = "_-2gx" (String#6890, DoABC#2)
// GeometryBodyPart = "_-0qP" (String#4646, DoABC#2)
// GeometryItem = "_-H0" (String#8018, DoABC#2)
// AvatarModelGeometry = "_-2q7" (String#7081, DoABC#2)
// AvatarActionManager = "_-1H3" (String#17154, DoABC#2)
// AnimationLayerData = "_-3DH" (String#919, DoABC#2)
// PartSetsData = "_-18G" (String#5042, DoABC#2)
// PartDefinition = "_-2TQ" (String#6632, DoABC#2)
// ActionPart = "_-1WB" (String#5476, DoABC#2)
// FigureData = "_-1BT" (String#836, DoABC#2)
// AnimationAction = "_-11k" (String#4910, DoABC#2)
// getCanvasOffsets = "_-0gi" (String#4439, DoABC#2)
// getLayerData = "_-0Qg" (String#1470, DoABC#2)
// actionParameter = "_-2Oa" (String#6531, DoABC#2)
// getColor = "_-07L" (String#1406, DoABC#2)
// getPart = "_-1hb" (String#5700, DoABC#2)
// getDynamicParts = "_-39y" (String#21883, DoABC#2)
// addPart = "_-0lC" (String#15873, DoABC#2)
// getParts = "_-3DP" (String#7583, DoABC#2)
// removeDynamicItems = "_-1W" (String#17742, DoABC#2)
// getBodyPartIdsInAvatarSet = "_-MG" (String#23095, DoABC#2)
// isMainAvatarSet = "_-n8" (String#24160, DoABC#2)
// getBodyPart = "_-3Df" (String#22020, DoABC#2)
// getBodyPartOfItem = "_-0Ot" (String#15020, DoABC#2)
// getBodyPartsAtAngle = "_-1fX" (String#18119, DoABC#2)
// hiddenLayers = "_-3IA" (String#7671, DoABC#2)
// getPartSet = "_-72" (String#7807, DoABC#2)
// paletteID = "_-0BG" (String#3784, DoABC#2)
// colorLayerIndex = "_-05t" (String#3683, DoABC#2)
// getDefaultPartSet = "_-2J3" (String#19769, DoABC#2)
// getPartColor = "_-2yW" (String#7250, DoABC#2)
// getBodyPartsUnordered = "_-1Eq" (String#17063, DoABC#2)
// getActiveBodyPartIds = "_-1Mf" (String#17387, DoABC#2)
// getAction = "_-e3" (String#23805, DoABC#2)
// isAnimation = "_-1QB" (String#5356, DoABC#2)
// getAnimation = "_-35m" (String#7425, DoABC#2)
// overridingAction = "_-3Dz" (String#7595, DoABC#2)
// _SafeStr_7968 = "include" (String#45700, DoABC#2)
// renderManager = "_-2KA" (String#19812, DoABC#2)
// getActionDefinition = "_-1Yl" (String#17839, DoABC#2)
// frameCount = "_-0C7" (String#14533, DoABC#2)
// getAnimatedBodyPartIds = "_-0AX" (String#14469, DoABC#2)
// hasAddData = "_-2rO" (String#7110, DoABC#2)
// getAddData = "_-1Ie" (String#17220, DoABC#2)
// addData = "_-2Py" (String#6561, DoABC#2)
// isBlended = "_-1h4" (String#18179, DoABC#2)
// registerAnimation = "_-3Jo" (String#22276, DoABC#2)
// _avatarType = "_-Ms" (String#8138, DoABC#2)
// _defaultAction = "_-1ni" (String#862, DoABC#2)
// getActionDefinitionWithState = "_-K4" (String#23008, DoABC#2)
// getDefaultAction = "_-2dH" (String#20575, DoABC#2)
// sortActions = "_-OU" (String#2099, DoABC#2)
// _renderManager = "_-yU" (String#8845, DoABC#2)
// _SafeStr_9974 = "_-m7" (String#24114, DoABC#2)
// _SafeStr_9981 = "_-0NC" (String#14963, DoABC#2)



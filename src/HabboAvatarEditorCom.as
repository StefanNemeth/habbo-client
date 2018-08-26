
package 
{
    import mx.core.SimpleApplication;
    import com.sulake.bootstrap.HabboAvatarEditorManager;
    import com.sulake.iid.IIDHabboAvatarEditor;

    public class HabboAvatarEditorCom extends SimpleApplication 
    {

        public static var manifest:Class = HabboAvatarEditorCom_manifest;
        public static var AvatarEditor:Class = HabboAvatarEditorCom_AvatarEditor;
        public static var AvatarEditorFrame:Class = HabboAvatarEditorCom_AvatarEditorFrame;
        public static var AvatarEditorContent:Class = HabboAvatarEditorCom_AvatarEditorContent;
        public static var AvatarEditorGrid:Class = HabboAvatarEditorCom_AvatarEditorGrid;
        public static var AvatarEditorImage:Class = HabboAvatarEditorCom_AvatarEditorImage;
        public static var AvatarEditorThumb:Class = HabboAvatarEditorCom_AvatarEditorThumb;
        public static var ViewConfiguration:Class = HabboAvatarEditorCom_ViewConfiguration;
        public static var StripClubItemsInfo:Class = HabboAvatarEditorCom_StripClubItemsInfo;
        public static var color_chooser_cell:Class = HabboAvatarEditorCom_color_chooser_cell;
        public static var avatareditor_generic_base:Class = HabboAvatarEditorCom_avatareditor_generic_base;
        public static var avatareditor_head_base:Class = HabboAvatarEditorCom_avatareditor_head_base;
        public static var avatareditor_legs_base:Class = HabboAvatarEditorCom_avatareditor_legs_base;
        public static var avatareditor_club_promo_try:Class = HabboAvatarEditorCom_avatareditor_club_promo_try;
        public static var avatareditor_club_promo_buy:Class = HabboAvatarEditorCom_avatareditor_club_promo_buy;
        public static var avatareditor_torso_base:Class = HabboAvatarEditorCom_avatareditor_torso_base;
        public static var Outfit:Class = HabboAvatarEditorCom_Outfit;
        public static var Selector:Class = HabboAvatarEditorCom_Selector;
        public static var avatareditor_wardrobe_base:Class = HabboAvatarEditorCom_avatareditor_wardrobe_base;
        public static var wardrobe_slot:Class = HabboAvatarEditorCom_wardrobe_slot;
        public static var avatareditor_hotlooks_base:Class = HabboAvatarEditorCom_avatareditor_hotlooks_base;
        public static var avatar_editor_download_icon:Class = HabboAvatarEditorCom_avatar_editor_download_icon;
        public static var editor_clr_40x32_1:Class = HabboAvatarEditorCom_editor_clr_40x32_1;
        public static var editor_clr_40x32_2:Class = HabboAvatarEditorCom_editor_clr_40x32_2;
        public static var editor_clr_40x32_3:Class = HabboAvatarEditorCom_editor_clr_40x32_3;
        public static var platform:Class = HabboAvatarEditorCom_platform;
        public static var removeSelection:Class = HabboAvatarEditorCom_removeSelection;
        public static var ae_tabs_generic:Class = HabboAvatarEditorCom_ae_tabs_generic;
        public static var ae_tabs_head:Class = HabboAvatarEditorCom_ae_tabs_head;
        public static var ae_tabs_legs:Class = HabboAvatarEditorCom_ae_tabs_legs;
        public static var ae_tabs_torso:Class = HabboAvatarEditorCom_ae_tabs_torso;
        public static var ae_tabs_hotlooks:Class = HabboAvatarEditorCom_ae_tabs_hotlooks;
        public static var ae_tabs_wardrobe:Class = HabboAvatarEditorCom_ae_tabs_wardrobe;
        public static var bottom_accessories:Class = HabboAvatarEditorCom_bottom_accessories;
        public static var bottom_accessories_on:Class = HabboAvatarEditorCom_bottom_accessories_on;
        public static var bottom_shoes:Class = HabboAvatarEditorCom_bottom_shoes;
        public static var bottom_shoes_on:Class = HabboAvatarEditorCom_bottom_shoes_on;
        public static var bottom_trousers:Class = HabboAvatarEditorCom_bottom_trousers;
        public static var bottom_trousers_on:Class = HabboAvatarEditorCom_bottom_trousers_on;
        public static var gender_female:Class = HabboAvatarEditorCom_gender_female;
        public static var gender_female_on:Class = HabboAvatarEditorCom_gender_female_on;
        public static var gender_male:Class = HabboAvatarEditorCom_gender_male;
        public static var gender_male_on:Class = HabboAvatarEditorCom_gender_male_on;
        public static var head_accessories:Class = HabboAvatarEditorCom_head_accessories;
        public static var head_accessories_on:Class = HabboAvatarEditorCom_head_accessories_on;
        public static var head_eyewear:Class = HabboAvatarEditorCom_head_eyewear;
        public static var head_eyewear_on:Class = HabboAvatarEditorCom_head_eyewear_on;
        public static var head_face_accessories:Class = HabboAvatarEditorCom_head_face_accessories;
        public static var head_face_accessories_on:Class = HabboAvatarEditorCom_head_face_accessories_on;
        public static var head_hair:Class = HabboAvatarEditorCom_head_hair;
        public static var head_hair_on:Class = HabboAvatarEditorCom_head_hair_on;
        public static var head_hats:Class = HabboAvatarEditorCom_head_hats;
        public static var head_hats_on:Class = HabboAvatarEditorCom_head_hats_on;
        public static var top_accessories:Class = HabboAvatarEditorCom_top_accessories;
        public static var top_accessories_on:Class = HabboAvatarEditorCom_top_accessories_on;
        public static var top_shirt:Class = HabboAvatarEditorCom_top_shirt;
        public static var top_jacket_on:Class = HabboAvatarEditorCom_top_jacket_on;
        public static var top_jacket:Class = HabboAvatarEditorCom_top_jacket;
        public static var top_prints_on:Class = HabboAvatarEditorCom_top_prints_on;
        public static var top_prints:Class = HabboAvatarEditorCom_top_prints;
        public static var top_shirt_on:Class = HabboAvatarEditorCom_top_shirt_on;
        public static var selectOutfit:Class = HabboAvatarEditorCom_selectOutfit;
        public static var selectOutfit_over:Class = HabboAvatarEditorCom_selectOutfit_over;
        public static var wardrobe_empty_slot:Class = HabboAvatarEditorCom_wardrobe_empty_slot;
        public static var requiredClasses:Array = new Array(HabboAvatarEditorManager, IIDHabboAvatarEditor);

    }
}//package 

// HabboAvatarEditorCom_platform = "_-ho" (String#8550, DoABC#2)
// HabboAvatarEditorCom_head_hair = "_-KA" (String#8086, DoABC#2)
// HabboAvatarEditorCom_gender_female = "_-ld" (String#8637, DoABC#2)
// HabboAvatarEditorCom_top_prints = "_-20M" (String#6052, DoABC#2)
// HabboAvatarEditorCom_wardrobe_slot = "_-D8" (String#7934, DoABC#2)
// HabboAvatarEditorCom_head_hats_on = "_-2tI" (String#7144, DoABC#2)
// HabboAvatarEditorCom_wardrobe_empty_slot = "_-00K" (String#3569, DoABC#2)
// HabboAvatarEditorCom_bottom_accessories = "_-1Rq" (String#5395, DoABC#2)
// HabboAvatarEditorCom_avatareditor_club_promo_try = "_-0-N" (String#3552, DoABC#2)
// HabboAvatarEditorCom_AvatarEditorImage = "_-081" (String#3719, DoABC#2)
// HabboAvatarEditorCom_ViewConfiguration = "_-0F2" (String#3851, DoABC#2)
// HabboAvatarEditorCom_top_jacket = "_-1i0" (String#5709, DoABC#2)
// HabboAvatarEditorCom_avatareditor_club_promo_buy = "_-0j8" (String#4481, DoABC#2)
// HabboAvatarEditorCom_head_eyewear = "_-18T" (String#5048, DoABC#2)
// HabboAvatarEditorCom_gender_male_on = "_-1mb" (String#5791, DoABC#2)
// HabboAvatarEditorCom_head_accessories = "_-1nF" (String#5802, DoABC#2)
// HabboAvatarEditorCom_top_shirt = "_-Pg" (String#8196, DoABC#2)
// HabboAvatarEditorCom_bottom_trousers_on = "_-tf" (String#8761, DoABC#2)
// HabboAvatarEditorCom_avatareditor_legs_base = "_-0VC" (String#4208, DoABC#2)
// HabboAvatarEditorCom_AvatarEditorGrid = "_-2-9" (String#6033, DoABC#2)
// HabboAvatarEditorCom_head_eyewear_on = "_-09u" (String#3756, DoABC#2)
// HabboAvatarEditorCom_editor_clr_40x32_1 = "_-2hz" (String#6907, DoABC#2)
// HabboAvatarEditorCom_head_hats = "_-0JD" (String#3938, DoABC#2)
// HabboAvatarEditorCom_top_shirt_on = "_-2g8" (String#6870, DoABC#2)
// HabboAvatarEditorCom_avatar_editor_download_icon = "_-2sF" (String#7126, DoABC#2)
// HabboAvatarEditorCom_color_chooser_cell = "_-28i" (String#6217, DoABC#2)
// HabboAvatarEditorCom_manifest = "_-24w" (String#6138, DoABC#2)
// HabboAvatarEditorCom_avatareditor_head_base = "_-QY" (String#8215, DoABC#2)
// HabboAvatarEditorCom_head_accessories_on = "_-2ks" (String#6974, DoABC#2)
// HabboAvatarEditorCom_AvatarEditorContent = "_-3KD" (String#7709, DoABC#2)
// HabboAvatarEditorCom_AvatarEditor = "_-1e4" (String#5630, DoABC#2)
// HabboAvatarEditorCom_ae_tabs_torso = "_-1Rl" (String#5393, DoABC#2)
// HabboAvatarEditorCom_ae_tabs_head = "_-1Wy" (String#5494, DoABC#2)
// HabboAvatarEditorCom_gender_male = "_-0Tm" (String#4175, DoABC#2)
// HabboAvatarEditorCom_bottom_shoes = "_-41" (String#7746, DoABC#2)
// HabboAvatarEditorCom_editor_clr_40x32_2 = "_-05r" (String#3682, DoABC#2)
// HabboAvatarEditorCom_editor_clr_40x32_3 = "_-3Kx" (String#7722, DoABC#2)
// HabboAvatarEditorCom_StripClubItemsInfo = "_-0AT" (String#3767, DoABC#2)
// HabboAvatarEditorCom_head_face_accessories_on = "_-2NY" (String#6513, DoABC#2)
// HabboAvatarEditorCom_AvatarEditorThumb = "_-25r" (String#6158, DoABC#2)
// HabboAvatarEditorCom_selectOutfit = "_-1g0" (String#5663, DoABC#2)
// HabboAvatarEditorCom_head_face_accessories = "_-2qf" (String#7090, DoABC#2)
// HabboAvatarEditorCom_AvatarEditorFrame = "_-1zN" (String#6022, DoABC#2)
// HabboAvatarEditorCom_selectOutfit_over = "_-38S" (String#7480, DoABC#2)
// HabboAvatarEditorCom_avatareditor_generic_base = "_-7K" (String#7811, DoABC#2)
// HabboAvatarEditorCom_bottom_accessories_on = "_-0sw" (String#4704, DoABC#2)
// HabboAvatarEditorCom_gender_female_on = "_-QA" (String#8204, DoABC#2)
// HabboAvatarEditorCom_avatareditor_wardrobe_base = "_-0mc" (String#4561, DoABC#2)
// HabboAvatarEditorCom_Outfit = "_-vf" (String#8797, DoABC#2)
// HabboAvatarEditorCom_bottom_trousers = "_-2RR" (String#6595, DoABC#2)
// HabboAvatarEditorCom_Selector = "_-2N3" (String#6501, DoABC#2)
// HabboAvatarEditorCom_top_prints_on = "_-2Ji" (String#6433, DoABC#2)
// HabboAvatarEditorCom_top_accessories_on = "_-aV" (String#8429, DoABC#2)
// HabboAvatarEditorCom_ae_tabs_legs = "_-1VN" (String#5465, DoABC#2)
// HabboAvatarEditorCom_ae_tabs_generic = "_-2nu" (String#7038, DoABC#2)
// HabboAvatarEditorCom_top_jacket_on = "_-9h" (String#7856, DoABC#2)
// HabboAvatarEditorCom_ae_tabs_hotlooks = "_-TV" (String#8276, DoABC#2)
// HabboAvatarEditorCom_removeSelection = "_-1Fh" (String#5166, DoABC#2)
// HabboAvatarEditorCom_avatareditor_torso_base = "_-1r-" (String#5874, DoABC#2)
// HabboAvatarEditorCom_bottom_shoes_on = "_-JJ" (String#8070, DoABC#2)
// HabboAvatarEditorCom_head_hair_on = "_-1OZ" (String#5325, DoABC#2)
// HabboAvatarEditorCom_top_accessories = "_-2L-" (String#6461, DoABC#2)
// HabboAvatarEditorCom_ae_tabs_wardrobe = "_-1nS" (String#5808, DoABC#2)
// HabboAvatarEditorCom_avatareditor_hotlooks_base = "_-1FY" (String#5164, DoABC#2)



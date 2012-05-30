--# -path=.:alltenses

concrete LibraryBrowserAPI of LibraryBrowser = open Prelude in {

lincat 
  A, A2, AP, AdA, AdN, AdV, Adv, Ant, CAdv, CN, Card, Cl, ClSlash, Comp, Conj, Det, Dig, Digit, Digits, 
  IAdv, IComp, IDet, IP, IQuant, Imp, Interj, ListAP, ListAdv, 
  ListCN, ListIAdv, ListNP, ListRS, ListS, N, N2, N3, NP, Num, Numeral, 
  Ord, PConj, PN, Phr, Pol, Predet, Prep, Pron, QCl, QS, QVP, Quant, RCl, RP, RS, S, SC, SSlash, 
  Sub10, Sub100, Sub1000, Sub1000000, Subj, Temp, Tense, Text, Utt, V, V2, V2A, V2Q, V2S, V2V, V3, 
  VA, VP, VPSlash, VQ, VS, VV, Voc = Term ;

oper Term = {s : Str ; f,x : Str ; par : Str * Str ; flat : Bool} ;

oper mkTerm = overload {
  mkTerm : Str -> Term = \f -> 
    {s = f ; f = f ; x = [] ; par = noPar ; flat = False} ;
  mkTerm : Str -> Term -> Term = \f,x -> 
    appTerm f (fullTerm x) ;
  mkTerm : Str -> (_,_ : Term) -> Term = \f,x,y -> 
    appTerm f (fullTerm x ++ fullTerm y) ; 
  mkTerm : Str -> (_,_,_ : Term) -> Term = \f,x,y,z -> 
    appTerm f (fullTerm x ++ fullTerm y ++ fullTerm z) ; 
  mkTerm : Str -> (_,_,_,_ : Term) -> Term = \f,x,y,z,u -> 
    appTerm f (fullTerm x ++ fullTerm y ++ fullTerm z ++ fullTerm u) ;
  } ;

  noPar  = <[],[]> ;
  yesPar = <"(",")"> ;

  appTerm : Str -> Str -> Term = \f,x -> {s = f ++ x ; f = f ; x = x ; par = yesPar ; flat = False} ;
  useTerm : Term -> Str = \t -> t.f ++ t.x ;
  fullTerm : Term -> Str = \t -> t.par.p1 ++ t.f ++ t.x ++ t.par.p2 ;
  flatTerm : Term -> Term = \t -> {s = t.x ; f = [] ; x = t.x ; par = noPar ; flat = False} ;
  flatIfTerm : Term -> Term = \t -> case t.flat of {
    True  => flatTerm t ;
    False => t
    } ;
  mkFlat : Term -> Term = \t -> {s = t.s ; f = t.f ; x = t.x ; par = t.par ; flat = True} ;

  hide : Str -> Str = \f -> [] ;

lin AAnter = mkTerm "anteriorAnt" ;
lin ASimul = mkTerm (hide "simultaneousAnt") ;
lin AdAP ada_1 ap_2 = mkTerm "mkAP" ada_1 (flatIfTerm ap_2) ;
lin AdAdv ada_1 adv_2 = mkTerm "mkAdv" ada_1 adv_2 ;
lin AdNum adn_1 card_2 = mkTerm "mkCard" adn_1 card_2 ;
lin AdVVP adv_1 vp_2 = mkTerm "mkVP" adv_1 vp_2 ;
lin AdVVPSlash adv_1 vpslash_2 = mkTerm "mkVPSlash" adv_1 vpslash_2 ;
--lin AddAdvQVP qvp_1 iadv_2 = mkTerm "mkQVP" qvp_1 iadv_2 ;
lin AdjCN ap_1 cn_2 = mkTerm "mkCN" ap_1 cn_2 ;
lin AdjOrd ord_1 = mkTerm "mkAP" ord_1 ;
lin AdnCAdv cadv_1 = mkTerm "mkAdN" cadv_1 ;
lin AdvAP ap_1 adv_2 = mkTerm "mkAP" ap_1 adv_2 ;
lin AdvCN cn_1 adv_2 = mkTerm "mkCN" cn_1 adv_2 ;
lin AdvIAdv iadv_1 adv_2 = mkTerm "mkIAdv" iadv_1 adv_2 ;
lin AdvIP ip_1 adv_2 = mkTerm "mkIP" ip_1 adv_2 ;
lin AdvNP np_1 adv_2 = mkTerm "mkNP" np_1 adv_2 ;
--lin AdvQVP vp_1 iadv_2 = mkTerm "mkQVP" vp_1 iadv_2 ;
lin AdvS adv_1 s_2 = mkTerm "mkS" adv_1 s_2 ;
lin AdvSlash clslash_1 adv_2 = mkTerm "mkClSlash" clslash_1 adv_2 ;
lin AdvVP vp_1 adv_2 = mkTerm "mkVP" vp_1 adv_2 ;
lin AdvVPSlash vpslash_1 adv_2 = mkTerm "mkVPSlash" vpslash_1 adv_2 ;
lin ApposCN cn_1 np_2 = mkTerm "mkCN" cn_1 np_2 ;
lin BaseAP ap_1 ap_2 = mkFlat (mkTerm "mkListAP" ap_1 ap_2) ;
lin BaseAdv adv_1 adv_2 = mkFlat (mkTerm "mkListAdv" adv_1 adv_2) ;
lin BaseCN cn_1 cn_2 = mkTerm "mkListCN" cn_1 cn_2 ;
--lin BaseIAdv iadv_1 iadv_2 = mkTerm "mkListIAdv" iadv_1 iadv_2 ;
lin BaseNP np_1 np_2 =mkFlat (mkTerm "mkListNP" np_1 np_2) ;
lin BaseRS rs_1 rs_2 = mkTerm "mkListRS" rs_1 rs_2 ;
lin BaseS s_1 s_2 = mkFlat (mkTerm "mkListS" s_1 s_2) ;
lin CAdvAP cadv_1 ap_2 np_3 = mkTerm "mkAP" cadv_1 ap_2 np_3 ;
lin CleftAdv adv_1 s_2 = mkTerm "mkCl" adv_1 s_2 ;
lin CleftNP np_1 rs_2 = mkTerm "mkCl" np_1 rs_2 ;
lin CompAP ap_1 = mkFlat (mkTerm "mkComp" (flatIfTerm ap_1)) ;
lin CompAdv adv_1 = mkFlat (mkTerm "mkComp" adv_1) ;
lin CompCN cn_1 = mkFlat (mkTerm "mkComp" (flatIfTerm cn_1)) ;
lin CompIAdv iadv_1 = mkTerm "mkIComp" iadv_1 ;
lin CompIP ip_1 = mkTerm "mkIComp" ip_1 ;
lin CompNP np_1 = mkFlat (mkTerm "mkComp" np_1) ;
lin ComparA a_1 np_2 = mkTerm "comparAP" a_1 np_2 ;
lin ComparAdvAdj cadv_1 a_2 np_3 = mkTerm "mkAdv" cadv_1 a_2 np_3 ;
lin ComparAdvAdjS cadv_1 a_2 s_3 = mkTerm "mkAdv" cadv_1 a_2 s_3 ;
lin ComplA2 a2_1 np_2 = mkTerm "mkAP" a2_1 np_2 ;
lin ComplN2 n2_1 np_2 = mkTerm "mkCN" (flatIfTerm n2_1) np_2 ;
lin ComplN3 n3_1 np_2 = mkFlat (mkTerm "mkN2" n3_1 np_2) ;
lin ComplSlash vpslash_1 np_2 = mkFlat (mkTerm "mkVP" (flatIfTerm vpslash_1) np_2) ;
--lin ComplSlashIP vpslash_1 ip_2 = mkTerm "mkQVP" vpslash_1 ip_2 ;
lin ComplVA va_1 ap_2 = mkFlat (mkTerm "mkVP" va_1 (flatIfTerm ap_2)) ;
lin ComplVQ vq_1 qs_2 = mkTerm "mkVP" vq_1 qs_2 ;
lin ComplVS vs_1 s_2 = mkTerm "mkVP" vs_1 s_2 ;
lin ComplVV vv_1 vp_2 = mkFlat (mkTerm "mkVP" vv_1 vp_2) ;
lin ConjAP conj_1 listap_2 = mkTerm "mkAP" conj_1 (flatIfTerm listap_2) ;
lin ConjAdv conj_1 listadv_2 = mkTerm "mkAdv" conj_1 (flatIfTerm listadv_2) ;
lin ConjCN conj_1 listcn_2 = mkTerm "mkCN" conj_1 listcn_2 ;
lin ConjIAdv conj_1 listiadv_2 = mkTerm "mkIAdv" conj_1 listiadv_2 ;
lin ConjNP conj_1 listnp_2 = mkTerm "mkNP" conj_1 (flatIfTerm listnp_2) ;
lin ConjRS conj_1 listrs_2 = mkTerm "mkRS" conj_1 listrs_2 ;
lin ConjS conj_1 lists_2 = mkTerm "mkS" conj_1 (flatIfTerm lists_2) ;
lin ConsAP ap_1 listap_2 = mkTerm "mkListAP" ap_1 listap_2 ;
lin ConsAdv adv_1 listadv_2 = mkTerm "mkListAdv" adv_1 listadv_2 ;
lin ConsCN cn_1 listcn_2 = mkTerm "mkListCN" cn_1 listcn_2 ;
--lin ConsIAdv iadv_1 listiadv_2 = mkTerm "mkListIAdv" iadv_1 listiadv_2 ;
lin ConsNP np_1 listnp_2 = mkTerm "mkListNP" np_1 listnp_2 ;
lin ConsRS rs_1 listrs_2 = mkTerm "mkListRS" rs_1 listrs_2 ;
lin ConsS s_1 lists_2 = mkTerm "mkListS" s_1 lists_2 ;
lin D_0 = mkTerm "n0_Dig" ;
lin D_1 = mkTerm "n1_Dig" ;
lin D_2 = mkTerm "n2_Dig" ;
lin D_3 = mkTerm "n3_Dig" ;
lin D_4 = mkTerm "n4_Dig" ;
lin D_5 = mkTerm "n5_Dig" ;
lin D_6 = mkTerm "n6_Dig" ;
lin D_7 = mkTerm "n7_Dig" ;
lin D_8 = mkTerm "n8_Dig" ;
lin D_9 = mkTerm "n9_Dig" ;
--lin DefArt = mkTerm "the_Quant" ;
lin DetCN det_1 cn_2 = mkTerm "mkNP" (flatIfTerm det_1) (flatIfTerm cn_2) ;
lin DetNP det_1 = mkTerm "mkNP" det_1 ;
lin DetQuant quant_1 num_2 = mkFlat (mkTerm "mkDet" quant_1 num_2) ;
lin DetQuantOrd quant_1 num_2 ord_3 = mkTerm "mkDet" quant_1 num_2 ord_3 ;
lin EmbedQS qs_1 = mkTerm "mkSC" qs_1 ;
lin EmbedS s_1 = mkTerm "mkSC" s_1 ;
lin EmbedVP vp_1 = mkTerm "mkSC" vp_1 ;
lin ExistIP ip_1 = mkTerm "mkQCl" ip_1 ;
lin ExistNP np_1 = mkTerm "mkCl" np_1 ;
lin ExtAdvS adv_1 s_2 = mkTerm "mkS" adv_1 s_2 ;
lin FunRP prep_1 np_2 rp_3 = mkTerm "mkRP" prep_1 np_2 rp_3 ;
lin GenericCl vp_1 = mkTerm "genericCl" vp_1 ;
lin IDig dig_1 = mkTerm "mkDigits" (mkTerm "\"999999\"") ; -- mkTerm "mkDigits" dig_1 ;
lin IIDig dig_1 digits_2 = mkTerm "mkDigits" (mkTerm "\"999\"") ; -- mkTerm "mkDigits" dig_1 digits_2 ;
lin IdRP = mkTerm "IdRP" ;
lin IdetCN idet_1 cn_2 = mkTerm "mkIP" idet_1 cn_2 ;
lin IdetIP idet_1 = mkTerm "mkIP" idet_1 ;
lin IdetQuant iquant_1 num_2 = mkTerm "mkIDet" iquant_1 num_2 ;
--lin ImpP3 np_1 vp_2 = mkTerm "mkUtt" np_1 vp_2 ;
lin ImpPl1 vp_1 = mkTerm "lets_Utt" vp_1 ;
lin ImpVP vp_1 = mkTerm "mkImp" vp_1 ;
lin ImpersCl vp_1 = mkTerm "mkCl" vp_1 ;
--lin IndefArt = mkTerm "a_Quant" ;
lin MassNP cn_1 = mkTerm "mkNP" cn_1 ;
lin NoPConj = mkTerm (hide "NoPConj") ;
lin NoVoc = mkTerm (hide "NoVoc") ;
lin NumCard card_1 = mkTerm "mkNum" card_1 ;
lin NumDigits digits_1 = mkTerm "mkCard" digits_1 ;
lin NumNumeral numeral_1 = mkTerm "mkCard" numeral_1 ;
lin NumPl = mkTerm "pluralNum" ;
lin NumSg = mkTerm (hide "singularNum") ;
lin OrdDigits digits_1 = mkTerm "mkOrd" digits_1 ;
lin OrdNumeral numeral_1 = mkTerm "mkOrd" numeral_1 ;
lin OrdSuperl a_1 = mkTerm "mkOrd" a_1 ;
lin PConjConj conj_1 = mkTerm "mkPConj" conj_1 ;
lin PNeg = mkTerm "negativePol" ;
lin PPartNP np_1 v2_2 = mkTerm "mkNP" np_1 v2_2 ;
lin PPos = mkTerm (hide "positivePol") ;
lin PassV2 v2_1 = mkTerm "passiveVP" v2_1 ;
lin PhrUtt pconj_1 utt_2 voc_3 = mkFlat (mkTerm "mkPhr" pconj_1 utt_2 voc_3) ;
lin PositA a_1 = mkFlat (mkTerm "mkAP" a_1) ;
lin PositAdAAdj a_1 = mkTerm "mkAdA" a_1 ;
lin PositAdvAdj a_1 = mkTerm "mkAdv" a_1 ;
lin PossPron pron_1 = mkTerm "mkQuant" pron_1 ;
lin PredSCVP sc_1 vp_2 = mkTerm "mkCl" sc_1 vp_2 ;
--lin PredVP np_1 vp_2 = mkTerm "mkCl" np_1 vp_2 ;
lin PredVP np_1 vp_2 = mkTerm "mkCl" np_1 (flatIfTerm vp_2) ;
lin PredetNP predet_1 np_2 = mkTerm "mkNP" predet_1 np_2 ;
lin PrepIP prep_1 ip_2 = mkTerm "mkIAdv" prep_1 ip_2 ;
lin PrepNP prep_1 np_2 = mkTerm "mkAdv" prep_1 np_2 ;
lin ProgrVP vp_1 = mkTerm "progressiveVP" vp_1 ;
lin QuestCl cl_1 = mkTerm "mkQCl" cl_1 ;
lin QuestIAdv iadv_1 cl_2 = mkTerm "mkQCl" iadv_1 cl_2 ;
lin QuestIComp icomp_1 np_2 = mkTerm "mkQCl" icomp_1 np_2 ;
lin QuestQVP ip_1 qvp_2 = mkTerm "mkQCl" ip_1 qvp_2 ;
lin QuestSlash ip_1 clslash_2 = mkTerm "mkQCl" ip_1 clslash_2 ;
lin QuestVP ip_1 vp_2 = mkTerm "mkQCl" ip_1 (flatIfTerm vp_2) ;
lin ReflA2 a2_1 = mkTerm "reflAP" a2_1 ;
lin ReflVP vpslash_1 = mkTerm "reflexiveVP" vpslash_1 ;
lin RelCN cn_1 rs_2 = mkTerm "mkCN" cn_1 rs_2 ;
lin RelCl cl_1 = mkTerm "mkRCl" cl_1 ;
lin RelNP np_1 rs_2 = mkTerm "mkNP" np_1 rs_2 ;
lin RelS s_1 rs_2 = mkTerm "mkS" s_1 rs_2 ;
lin RelSlash rp_1 clslash_2 = mkTerm "mkRCl" rp_1 clslash_2 ;
lin RelVP rp_1 vp_2 = mkTerm "mkRCl" rp_1 (flatIfTerm vp_2) ;
lin SSubjS s_1 subj_2 s_3 = mkTerm "mkS" s_1 subj_2 s_3 ;
lin SentAP ap_1 sc_2 = mkTerm "mkAP" ap_1 sc_2 ;
lin SentCN cn_1 sc_2 = mkTerm "mkCN" cn_1 sc_2 ;
lin Slash2V3 v3_1 np_2 = mkTerm "mkVPSlash" v3_1 np_2 ;
lin Slash3V3 v3_1 np_2 = mkFlat (mkTerm "mkVPSlash" v3_1 np_2) ;
lin SlashPrep cl_1 prep_2 = mkTerm "mkClSlash" cl_1 prep_2 ;
lin SlashV2A v2a_1 ap_2 = mkFlat (mkTerm "mkVPSlash" v2a_1 ap_2) ;
lin SlashV2Q v2q_1 qs_2 = mkFlat (mkTerm "mkVPSlash" v2q_1 qs_2) ;
lin SlashV2S v2s_1 s_2 = mkFlat (mkTerm "mkVPSlash" v2s_1 s_2) ;
lin SlashV2V v2v_1 vp_2 = mkFlat (mkTerm "mkVPSlash" v2v_1 vp_2) ;
lin SlashV2VNP v2v_1 np_2 vpslash_3 = mkTerm "mkVPSlash" v2v_1 np_2 vpslash_3 ;
lin SlashV2a v2_1 = mkFlat (mkTerm "mkVPSlash" v2_1) ;
lin SlashVP np_1 vpslash_2 = mkTerm "mkClSlash" np_1 vpslash_2 ;
lin SlashVS np_1 vs_2 sslash_3 = mkTerm "mkClSlash" np_1 vs_2 sslash_3 ;
lin SlashVV vv_1 vpslash_2 = mkTerm "mkVPSlash" vv_1 vpslash_2 ;
lin SubjS subj_1 s_2 = mkTerm "mkAdv" subj_1 s_2 ;
lin TEmpty = mkTerm (hide "emptyText") ;
lin TExclMark phr_1 text_2 = mkTerm "mkText" (flatIfTerm phr_1) (mkTerm "exclMarkPunct") text_2 ;
lin TFullStop phr_1 text_2 = mkTerm "mkText" (flatIfTerm phr_1) text_2 ;
lin TCond = mkTerm "conditionalTense" ;
lin TFut = mkTerm "futureTense" ;
lin TPast = mkTerm "pastTense" ;
lin TPres = mkTerm (hide "presentTense") ;
lin TQuestMark phr_1 text_2 = mkTerm "mkText" (flatIfTerm phr_1) (mkTerm "questMarkPunct") text_2 ;
lin TTAnt tense_1 ant_2 = mkTerm "mkTense" tense_1 ant_2 ;
--lin Use2N3 n3_1 = mkTerm "mkN2" n3_1 ;
--lin Use3N3 n3_1 = mkTerm "mkN2" n3_1 ;
lin UseA2 a2_1 = mkTerm "mkAP" a2_1 ;
lin UseCl temp_1 pol_2 cl_3 = mkTerm "mkS" (flatTerm temp_1) pol_2 cl_3 ;
lin UseComp comp_1 = mkFlat (mkTerm "mkVP" (flatIfTerm comp_1)) ;
lin UseComparA a_1 = mkTerm "mkAP" a_1 ;
--lin UseCopula = mkTerm "UseCopula" ;
lin UseN n_1 = mkFlat (mkTerm "mkCN" n_1) ;
lin UseN2 n2_1 = mkTerm "mkCN" n2_1 ;
lin UsePN pn_1 = mkTerm "mkNP" pn_1 ;
--lin UsePron pron_1 = mkTerm "mkNP" pron_1 ;
lin UseQCl temp_1 pol_2 qcl_3 = mkTerm "mkQS" (flatTerm temp_1) pol_2 qcl_3 ;
lin UseRCl temp_1 pol_2 rcl_3 = mkTerm "mkRS" (flatTerm temp_1) pol_2 rcl_3 ;
lin UseSlash temp_1 pol_2 clslash_3 = mkTerm "mkSSlash" temp_1 pol_2 clslash_3 ;
lin UseV v_1 = mkFlat (mkTerm "mkVP" v_1) ;
lin UttAP ap_1 = mkTerm "mkUtt" ap_1 ;
lin UttAdv adv_1 = mkTerm "mkUtt" adv_1 ;
lin UttCN cn_1 = mkTerm "mkUtt" cn_1 ;
lin UttCard card_1 = mkTerm "mkUtt" card_1 ;
lin UttIAdv iadv_1 = mkTerm "mkUtt" iadv_1 ;
lin UttIP ip_1 = mkTerm "mkUtt" ip_1 ;
lin UttImpPl pol_1 imp_2 = mkTerm "mkUtt" (mkTerm "pluralImpForm") pol_1 imp_2 ;
lin UttImpPol pol_1 imp_2 = mkTerm "mkUtt" (mkTerm "politeImpForm") pol_1 imp_2 ;
lin UttImpSg pol_1 imp_2 = mkTerm "mkUtt" pol_1 imp_2 ;
--lin UttInterj interj_1 = mkTerm "mkUtt" interj_1 ;
lin UttNP np_1 = mkTerm "mkUtt" np_1 ;
lin UttQS qs_1 = mkFlat (mkTerm "mkUtt" qs_1) ;
lin UttS s_1 = mkFlat (mkTerm "mkUtt" s_1) ;
lin UttVP vp_1 = mkTerm "mkUtt" vp_1 ;
lin VocNP np_1 = mkTerm "mkVoc" np_1 ;

  lin
    i_NP = mkTerm "i_NP" ;
    you_NP = mkTerm "you_NP" ;
    he_NP = mkTerm "he_NP" ;
    she_NP = mkTerm "she_NP" ;
    we_NP = mkTerm "we_NP" ;
    youPl_NP = mkTerm "youPl_NP" ;
    youPol_NP = mkTerm "youPol_NP" ;
    they_NP = mkTerm "they_NP" ;

    a_Det = mkTerm "a_Det" ;
    the_Det = mkTerm "the_Det" ;
    aPl_Det = mkTerm "aPl_Det" ;
    thePl_Det = mkTerm "thePl_Det" ;

lin above_Prep = mkTerm "above_Prep" ;
--lin active2passive cl_1 = mkTerm "mkCl" cl_1 ;
lin add_V3 = mkTerm "add_V3" ;
lin after_Prep = mkTerm "after_Prep" ;
lin airplane_N = mkTerm "airplane_N" ;
lin alas_Interj = mkTerm "alas_Interj" ;
lin all_Predet = mkTerm "all_Predet" ;
lin almost_AdA = mkTerm "almost_AdA" ;
lin almost_AdN = mkTerm "almost_AdN" ;
lin already_Adv = mkTerm "already_Adv" ;
lin although_Subj = mkTerm "although_Subj" ;
lin always_AdV = mkTerm "always_AdV" ;
lin and_Conj = mkTerm "and_Conj" ;
lin animal_N = mkTerm "animal_N" ;
lin answer_V2S = mkTerm "answer_V2S" ;
lin apartment_N = mkTerm "apartment_N" ;
lin apple_N = mkTerm "apple_N" ;
lin art_N = mkTerm "art_N" ;
lin as_CAdv = mkTerm "as_CAdv" ;
lin ashes_N = mkTerm "ashes_N" ;
lin ask_V2Q = mkTerm "ask_V2Q" ;
lin at_least_AdN = mkTerm "at_least_AdN" ;
lin at_most_AdN = mkTerm "at_most_AdN" ;
lin baby_N = mkTerm "baby_N" ;
lin back_N = mkTerm "back_N" ;
lin bad_A = mkTerm "bad_A" ;
lin bank_N = mkTerm "bank_N" ;
lin bark_N = mkTerm "bark_N" ;
lin beautiful_A = mkTerm "beautiful_A" ;
lin because_Subj = mkTerm "because_Subj" ;
lin become_VA = mkTerm "become_VA" ;
lin beer_N = mkTerm "beer_N" ;
lin before_Prep = mkTerm "before_Prep" ;
lin beg_V2V = mkTerm "beg_V2V" ;
lin behind_Prep = mkTerm "behind_Prep" ;
lin belly_N = mkTerm "belly_N" ;
lin between_Prep = mkTerm "between_Prep" ;
lin big_A = mkTerm "big_A" ;
lin bike_N = mkTerm "bike_N" ;
lin bird_N = mkTerm "bird_N" ;
lin bite_V2 = mkTerm "bite_V2" ;
lin black_A = mkTerm "black_A" ;
lin blood_N = mkTerm "blood_N" ;
lin blow_V = mkTerm "blow_V" ;
lin blue_A = mkTerm "blue_A" ;
lin boat_N = mkTerm "boat_N" ;
lin bone_N = mkTerm "bone_N" ;
lin book_N = mkTerm "book_N" ;
lin boot_N = mkTerm "boot_N" ;
lin boss_N = mkTerm "boss_N" ;
lin both7and_DConj = mkTerm "both7and_DConj" ;
lin boy_N = mkTerm "boy_N" ;
lin bread_N = mkTerm "bread_N" ;
lin break_V2 = mkTerm "break_V2" ;
lin breast_N = mkTerm "breast_N" ;
lin breathe_V = mkTerm "breathe_V" ;
lin broad_A = mkTerm "broad_A" ;
lin brother_N2 = mkTerm "brother_N2" ;
lin brown_A = mkTerm "brown_A" ;
lin burn_V = mkTerm "burn_V" ;
lin but_PConj = mkTerm "but_PConj" ;
lin butter_N = mkTerm "butter_N" ;
lin buy_V2 = mkTerm "buy_V2" ;
lin by8agent_Prep = mkTerm "by8agent_Prep" ;
lin by8means_Prep = mkTerm "by8means_Prep" ;
lin camera_N = mkTerm "camera_N" ;
lin can8know_VV = mkTerm "can8know_VV" ;
lin can_VV = mkTerm "can_VV" ;
lin cap_N = mkTerm "cap_N" ;
lin car_N = mkTerm "car_N" ;
lin carpet_N = mkTerm "carpet_N" ;
lin cat_N = mkTerm "cat_N" ;
lin ceiling_N = mkTerm "ceiling_N" ;
lin chair_N = mkTerm "chair_N" ;
lin cheese_N = mkTerm "cheese_N" ;
lin child_N = mkTerm "child_N" ;
lin church_N = mkTerm "church_N" ;
lin city_N = mkTerm "city_N" ;
lin clean_A = mkTerm "clean_A" ;
lin clever_A = mkTerm "clever_A" ;
lin close_V2 = mkTerm "close_V2" ;
lin cloud_N = mkTerm "cloud_N" ;
lin coat_N = mkTerm "coat_N" ;
lin cold_A = mkTerm "cold_A" ;
lin come_V = mkTerm "come_V" ;
lin computer_N = mkTerm "computer_N" ;
lin correct_A = mkTerm "correct_A" ;
lin count_V2 = mkTerm "count_V2" ;
lin country_N = mkTerm "country_N" ;
lin cousin_N = mkTerm "cousin_N" ;
lin cow_N = mkTerm "cow_N" ;
lin cut_V2 = mkTerm "cut_V2" ;
lin day_N = mkTerm "day_N" ;
--lin dconcat digits_1 digits_2 = mkTerm "mkDigits" digits_1 digits_2 ;
lin die_V = mkTerm "die_V" ;
lin dig_V = mkTerm "dig_V" ;
--lin digits2num digits_1 = mkTerm "mkNumeral" digits_1 ;
--lin digits2numeral card_1 = mkTerm "mkCard" card_1 ;
lin dirty_A = mkTerm "dirty_A" ;
lin distance_N3 = mkTerm "distance_N3" ;
lin do_V2 = mkTerm "do_V2" ;
lin doctor_N = mkTerm "doctor_N" ;
lin dog_N = mkTerm "dog_N" ;
lin door_N = mkTerm "door_N" ;
lin drink_V2 = mkTerm "drink_V2" ;
lin dry_A = mkTerm "dry_A" ;
lin dull_A = mkTerm "dull_A" ;
lin during_Prep = mkTerm "during_Prep" ;
lin dust_N = mkTerm "dust_N" ;
lin ear_N = mkTerm "ear_N" ;
lin earth_N = mkTerm "earth_N" ;
lin easy_A2V = mkTerm "easy_A2V" ;
lin eat_V2 = mkTerm "eat_V2" ;
lin egg_N = mkTerm "egg_N" ;
lin either7or_DConj = mkTerm "either7or_DConj" ;
lin empty_A = mkTerm "empty_A" ;
lin enemy_N = mkTerm "enemy_N" ;
lin every_Det = mkTerm "every_Det" ;
lin everybody_NP = mkTerm "everybody_NP" ;
lin everything_NP = mkTerm "everything_NP" ;
lin everywhere_Adv = mkTerm "everywhere_Adv" ;
lin except_Prep = mkTerm "except_Prep" ;
lin eye_N = mkTerm "eye_N" ;
lin factory_N = mkTerm "factory_N" ;
lin fall_V = mkTerm "fall_V" ;
lin far_Adv = mkTerm "far_Adv" ;
lin fat_N = mkTerm "fat_N" ;
lin father_N2 = mkTerm "father_N2" ;
lin fear_V2 = mkTerm "fear_V2" ;
lin fear_VS = mkTerm "fear_VS" ;
lin feather_N = mkTerm "feather_N" ;
lin few_Det = mkTerm "few_Det" ;
lin fight_V2 = mkTerm "fight_V2" ;
lin find_V2 = mkTerm "find_V2" ;
lin fingernail_N = mkTerm "fingernail_N" ;
lin fire_N = mkTerm "fire_N" ;
lin fish_N = mkTerm "fish_N" ;
lin float_V = mkTerm "float_V" ;
lin floor_N = mkTerm "floor_N" ;
lin flow_V = mkTerm "flow_V" ;
lin flower_N = mkTerm "flower_N" ;
lin fly_V = mkTerm "fly_V" ;
lin fog_N = mkTerm "fog_N" ;
lin foot_N = mkTerm "foot_N" ;
lin for_Prep = mkTerm "for_Prep" ;
lin forest_N = mkTerm "forest_N" ;
lin forget_V2 = mkTerm "forget_V2" ;
lin freeze_V = mkTerm "freeze_V" ;
lin fridge_N = mkTerm "fridge_N" ;
lin friend_N = mkTerm "friend_N" ;
lin from_Prep = mkTerm "from_Prep" ;
lin fruit_N = mkTerm "fruit_N" ;
lin full_A = mkTerm "full_A" ;
lin fun_AV = mkTerm "fun_AV" ;
lin garden_N = mkTerm "garden_N" ;
lin girl_N = mkTerm "girl_N" ;
lin give_V3 = mkTerm "give_V3" ;
lin glove_N = mkTerm "glove_N" ;
lin go_V = mkTerm "go_V" ;
lin gold_N = mkTerm "gold_N" ;
lin good_A = mkTerm "good_A" ;
lin grammar_N = mkTerm "grammar_N" ;
lin grass_N = mkTerm "grass_N" ;
lin green_A = mkTerm "green_A" ;
lin guts_N = mkTerm "guts_N" ;
lin hair_N = mkTerm "hair_N" ;
lin hand_N = mkTerm "hand_N" ;
lin harbour_N = mkTerm "harbour_N" ;
lin hat_N = mkTerm "hat_N" ;
lin hate_V2 = mkTerm "hate_V2" ;
lin have_V2 = mkTerm "have_V2" ;
--lin have_V3 = mkTerm "have_V3" ;
--lin have_not_V3 = mkTerm "have_not_V3" ;
lin he_Pron = mkTerm "he_Pron" ;
lin head_N = mkTerm "head_N" ;
lin hear_V2 = mkTerm "hear_V2" ;
lin heart_N = mkTerm "heart_N" ;
lin heavy_A = mkTerm "heavy_A" ;
lin here7from_Adv = mkTerm "here7from_Adv" ;
lin here7to_Adv = mkTerm "here7to_Adv" ;
lin here_Adv = mkTerm "here_Adv" ;
lin hill_N = mkTerm "hill_N" ;
lin hit_V2 = mkTerm "hit_V2" ;
lin hold_V2 = mkTerm "hold_V2" ;
lin hope_VS = mkTerm "hope_VS" ;
lin horn_N = mkTerm "horn_N" ;
lin horse_N = mkTerm "horse_N" ;
lin hot_A = mkTerm "hot_A" ;
lin house_N = mkTerm "house_N" ;
lin how8many_IDet = mkTerm "how8many_IDet" ;
lin how8much_IAdv = mkTerm "how8much_IAdv" ;
lin how_IAdv = mkTerm "how_IAdv" ;
lin hunt_V2 = mkTerm "hunt_V2" ;
lin husband_N = mkTerm "husband_N" ;
lin i_Pron = mkTerm "i_Pron" ;
lin ice_N = mkTerm "ice_N" ;
lin if_Subj = mkTerm "if_Subj" ;
lin if_then_Conj = mkTerm "if_then_Conj" ;
lin important_A = mkTerm "important_A" ;
lin in8front_Prep = mkTerm "in8front_Prep" ;
lin in_Prep = mkTerm "in_Prep" ;
lin industry_N = mkTerm "industry_N" ;
lin iron_N = mkTerm "iron_N" ;
lin it_Pron = mkTerm "it_Pron" ;
lin john_PN = mkTerm "john_PN" ;
lin jump_V = mkTerm "jump_V" ;
lin kill_V2 = mkTerm "kill_V2" ;
lin king_N = mkTerm "king_N" ;
lin knee_N = mkTerm "knee_N" ;
lin know_V2 = mkTerm "know_V2" ;
lin know_VQ = mkTerm "know_VQ" ;
lin know_VS = mkTerm "know_VS" ;
lin lake_N = mkTerm "lake_N" ;
lin lamp_N = mkTerm "lamp_N" ;
lin language_N = mkTerm "language_N" ;
lin language_title_Utt = mkTerm "language_title_Utt" ;
lin laugh_V = mkTerm "laugh_V" ;
lin leaf_N = mkTerm "leaf_N" ;
lin learn_V2 = mkTerm "learn_V2" ;
lin leather_N = mkTerm "leather_N" ;
lin leave_V2 = mkTerm "leave_V2" ;
lin left_Ord = mkTerm "left_Ord" ;
lin leg_N = mkTerm "leg_N" ;
lin less_CAdv = mkTerm "less_CAdv" ;
lin lie_V = mkTerm "lie_V" ;
lin like_V2 = mkTerm "like_V2" ;
lin listen_V2 = mkTerm "listen_V2" ;
lin live_V = mkTerm "live_V" ;
lin liver_N = mkTerm "liver_N" ;
lin long_A = mkTerm "long_A" ;
lin lose_V2 = mkTerm "lose_V2" ;
lin louse_N = mkTerm "louse_N" ;
lin love_N = mkTerm "love_N" ;
lin love_V2 = mkTerm "love_V2" ;
lin man_N = mkTerm "man_N" ;
lin many_Det = mkTerm "many_Det" ;
lin married_A2 = mkTerm "married_A2" ;
lin meat_N = mkTerm "meat_N" ;
lin milk_N = mkTerm "milk_N" ;
lin moon_N = mkTerm "moon_N" ;
lin more_CAdv = mkTerm "more_CAdv" ;
lin most_Predet = mkTerm "most_Predet" ;
lin mother_N2 = mkTerm "mother_N2" ;
lin mountain_N = mkTerm "mountain_N" ;
lin mouth_N = mkTerm "mouth_N" ;
lin much_Det = mkTerm "much_Det" ;
lin music_N = mkTerm "music_N" ;
lin must_VV = mkTerm "must_VV" ;
lin n2 = mkTerm "n2_Unit" ;
lin n3 = mkTerm "n3_Unit" ;
lin n4 = mkTerm "n4_Unit" ;
lin n5 = mkTerm "n5_Unit" ;
lin n6 = mkTerm "n6_Unit" ;
lin n7 = mkTerm "n7_Unit" ;
lin n8 = mkTerm "n8_Unit" ;
lin n9 = mkTerm "n9_Unit" ;
lin name_N = mkTerm "name_N" ;
lin narrow_A = mkTerm "narrow_A" ;
lin nd digit_1 = mkTerm "mkDig" digit_1 ;
--lin nd10 sub10_1 = mkTerm "mkDigits" sub10_1 ;
--lin nd100 sub100_1 = mkTerm "mkDigits" sub100_1 ;
--lin nd1000 sub1000_1 = mkTerm "mkDigits" sub1000_1 ;
--lin nd1000000 sub1000000_1 = mkTerm "mkDigits" sub1000000_1 ;
lin near_A = mkTerm "near_A" ;
lin neck_N = mkTerm "neck_N" ;
lin new_A = mkTerm "new_A" ;
lin newspaper_N = mkTerm "newspaper_N" ;
lin night_N = mkTerm "night_N" ;
lin no_Quant = mkTerm "no_Quant" ;
lin no_Utt = mkTerm "no_Utt" ;
lin nobody_NP = mkTerm "nobody_NP" ;
lin nose_N = mkTerm "nose_N" ;
lin not_Predet = mkTerm "not_Predet" ;
lin nothing_NP = mkTerm "nothing_NP" ;
lin now_Adv = mkTerm "now_Adv" ;
lin num sub1000000_1 = mkTerm "mkNumeral" (mkTerm "\"999\"") ; -- sub1000000_1 ;
--lin num2digits numeral_1 = mkTerm "mkDigits" numeral_1 ;
lin number_N = mkTerm "number_N" ;
lin oil_N = mkTerm "oil_N" ;
lin old_A = mkTerm "old_A" ;
lin on_Prep = mkTerm "on_Prep" ;
lin only_Predet = mkTerm "only_Predet" ;
lin open_V2 = mkTerm "open_V2" ;
lin or_Conj = mkTerm "or_Conj" ;
lin otherwise_PConj = mkTerm "otherwise_PConj" ;
lin paint_V2A = mkTerm "paint_V2A" ;
lin paper_N = mkTerm "paper_N" ;
lin paris_PN = mkTerm "paris_PN" ;
lin part_Prep = mkTerm "part_Prep" ;
lin peace_N = mkTerm "peace_N" ;
lin pen_N = mkTerm "pen_N" ;
lin person_N = mkTerm "person_N" ;
lin planet_N = mkTerm "planet_N" ;
lin plastic_N = mkTerm "plastic_N" ;
lin play_V = mkTerm "play_V" ;
lin play_V2 = mkTerm "play_V2" ;
lin please_Voc = mkTerm "please_Voc" ;
lin policeman_N = mkTerm "policeman_N" ;
lin possess_Prep = mkTerm "possess_Prep" ;
lin pot0 digit_1 = mkTerm "mkSub10" digit_1 ;
lin pot01 = mkTerm "pot01" ;
lin pot0as1 sub10_1 = mkTerm "mkSub100" sub10_1 ;
lin pot1 digit_1 = mkTerm "mkSub100" digit_1 ;
lin pot110 = mkTerm "pot110" ;
lin pot111 = mkTerm "pot111" ;
lin pot1as2 sub100_1 = mkTerm "mkSub1000" sub100_1 ;
lin pot1plus digit_1 sub10_2 = mkTerm "mkSub100" digit_1 sub10_2 ;
lin pot1to19 digit_1 = mkTerm "mkSub100" digit_1 ;
lin pot2 sub10_1 = mkTerm "mkSub1000" sub10_1 ;
lin pot2as3 sub1000_1 = mkTerm "mkSub1000000" sub1000_1 ;
lin pot2plus sub10_1 sub100_2 = mkTerm "mkSub1000" sub10_1 sub100_2 ;
lin pot3 sub1000_1 = mkTerm "mkSub1000000" sub1000_1 ;
lin pot3plus sub1000_1 sub1000_2 = mkTerm "mkSub1000000" sub1000_1 sub1000_2 ;
lin priest_N = mkTerm "priest_N" ;
lin probable_AS = mkTerm "probable_AS" ;
lin pull_V2 = mkTerm "pull_V2" ;
lin push_V2 = mkTerm "push_V2" ;
lin put_V2 = mkTerm "put_V2" ;
lin queen_N = mkTerm "queen_N" ;
lin question_N = mkTerm "question_N" ;
lin quite_Adv = mkTerm "quite_Adv" ;
lin radio_N = mkTerm "radio_N" ;
lin rain_N = mkTerm "rain_N" ;
lin rain_V0 = mkTerm "rain_V0" ;
lin read_V2 = mkTerm "read_V2" ;
lin ready_A = mkTerm "ready_A" ;
lin reason_N = mkTerm "reason_N" ;
lin red_A = mkTerm "red_A" ;
lin religion_N = mkTerm "religion_N" ;
lin restaurant_N = mkTerm "restaurant_N" ;
lin right_Ord = mkTerm "right_Ord" ;
lin river_N = mkTerm "river_N" ;
lin road_N = mkTerm "road_N" ;
lin rock_N = mkTerm "rock_N" ;
lin roof_N = mkTerm "roof_N" ;
lin root_N = mkTerm "root_N" ;
lin rope_N = mkTerm "rope_N" ;
lin rotten_A = mkTerm "rotten_A" ;
lin round_A = mkTerm "round_A" ;
lin rub_V2 = mkTerm "rub_V2" ;
lin rubber_N = mkTerm "rubber_N" ;
lin rule_N = mkTerm "rule_N" ;
lin run_V = mkTerm "run_V" ;
lin salt_N = mkTerm "salt_N" ;
lin sand_N = mkTerm "sand_N" ;
lin say_VS = mkTerm "say_VS" ;
lin school_N = mkTerm "school_N" ;
lin science_N = mkTerm "science_N" ;
lin scratch_V2 = mkTerm "scratch_V2" ;
lin sea_N = mkTerm "sea_N" ;
lin see_V2 = mkTerm "see_V2" ;
lin seed_N = mkTerm "seed_N" ;
lin seek_V2 = mkTerm "seek_V2" ;
lin sell_V3 = mkTerm "sell_V3" ;
lin send_V3 = mkTerm "send_V3" ;
lin sew_V = mkTerm "sew_V" ;
lin sharp_A = mkTerm "sharp_A" ;
lin she_Pron = mkTerm "she_Pron" ;
lin sheep_N = mkTerm "sheep_N" ;
lin ship_N = mkTerm "ship_N" ;
lin shirt_N = mkTerm "shirt_N" ;
lin shoe_N = mkTerm "shoe_N" ;
lin shop_N = mkTerm "shop_N" ;
lin short_A = mkTerm "short_A" ;
lin silver_N = mkTerm "silver_N" ;
lin sing_V = mkTerm "sing_V" ;
lin sister_N = mkTerm "sister_N" ;
lin sit_V = mkTerm "sit_V" ;
lin skin_N = mkTerm "skin_N" ;
lin sky_N = mkTerm "sky_N" ;
lin sleep_V = mkTerm "sleep_V" ;
lin small_A = mkTerm "small_A" ;
lin smell_V = mkTerm "smell_V" ;
lin smoke_N = mkTerm "smoke_N" ;
lin smooth_A = mkTerm "smooth_A" ;
lin snake_N = mkTerm "snake_N" ;
lin snow_N = mkTerm "snow_N" ;
lin so_AdA = mkTerm "so_AdA" ;
lin sock_N = mkTerm "sock_N" ;
lin somePl_Det = mkTerm "somePl_Det" ;
lin someSg_Det = mkTerm "someSg_Det" ;
lin somebody_NP = mkTerm "somebody_NP" ;
lin something_NP = mkTerm "something_NP" ;
lin somewhere_Adv = mkTerm "somewhere_Adv" ;
lin song_N = mkTerm "song_N" ;
lin speak_V2 = mkTerm "speak_V2" ;
lin spit_V = mkTerm "spit_V" ;
lin split_V2 = mkTerm "split_V2" ;
lin squeeze_V2 = mkTerm "squeeze_V2" ;
lin stab_V2 = mkTerm "stab_V2" ;
lin stand_V = mkTerm "stand_V" ;
lin star_N = mkTerm "star_N" ;
lin steel_N = mkTerm "steel_N" ;
lin stick_N = mkTerm "stick_N" ;
lin stone_N = mkTerm "stone_N" ;
lin stop_V = mkTerm "stop_V" ;
lin stove_N = mkTerm "stove_N" ;
lin straight_A = mkTerm "straight_A" ;
lin student_N = mkTerm "student_N" ;
lin stupid_A = mkTerm "stupid_A" ;
lin suck_V2 = mkTerm "suck_V2" ;
lin sun_N = mkTerm "sun_N" ;
lin swell_V = mkTerm "swell_V" ;
lin swim_V = mkTerm "swim_V" ;
lin switch8off_V2 = mkTerm "switch8off_V2" ;
lin switch8on_V2 = mkTerm "switch8on_V2" ;
lin table_N = mkTerm "table_N" ;
lin tail_N = mkTerm "tail_N" ;
lin talk_V3 = mkTerm "talk_V3" ;
lin teach_V2 = mkTerm "teach_V2" ;
lin teacher_N = mkTerm "teacher_N" ;
lin television_N = mkTerm "television_N" ;
lin that_Quant = mkTerm "that_Quant" ;
lin that_Subj = mkTerm "that_Subj" ;
lin there7from_Adv = mkTerm "there7from_Adv" ;
lin there7to_Adv = mkTerm "there7to_Adv" ;
lin there_Adv = mkTerm "there_Adv" ;
lin therefore_PConj = mkTerm "therefore_PConj" ;
lin they_Pron = mkTerm "they_Pron" ;
lin thick_A = mkTerm "thick_A" ;
lin thin_A = mkTerm "thin_A" ;
lin think_V = mkTerm "think_V" ;
lin this_Quant = mkTerm "this_Quant" ;
lin through_Prep = mkTerm "through_Prep" ;
lin throw_V2 = mkTerm "throw_V2" ;
lin tie_V2 = mkTerm "tie_V2" ;
lin to_Prep = mkTerm "to_Prep" ;
lin today_Adv = mkTerm "today_Adv" ;
lin tongue_N = mkTerm "tongue_N" ;
lin too_AdA = mkTerm "too_AdA" ;
lin tooth_N = mkTerm "tooth_N" ;
lin train_N = mkTerm "train_N" ;
lin travel_V = mkTerm "travel_V" ;
lin tree_N = mkTerm "tree_N" ;
lin turn_V = mkTerm "turn_V" ;
lin ugly_A = mkTerm "ugly_A" ;
lin uncertain_A = mkTerm "uncertain_A" ;
lin under_Prep = mkTerm "under_Prep" ;
lin understand_V2 = mkTerm "understand_V2" ;
lin university_N = mkTerm "university_N" ;
lin very_AdA = mkTerm "very_AdA" ;
lin village_N = mkTerm "village_N" ;
lin vomit_V = mkTerm "vomit_V" ;
lin wait_V2 = mkTerm "wait_V2" ;
lin walk_V = mkTerm "walk_V" ;
lin want_VV = mkTerm "want_VV" ;
lin war_N = mkTerm "war_N" ;
lin warm_A = mkTerm "warm_A" ;
lin wash_V2 = mkTerm "wash_V2" ;
lin watch_V2 = mkTerm "watch_V2" ;
lin water_N = mkTerm "water_N" ;
lin we_Pron = mkTerm "we_Pron" ;
lin wet_A = mkTerm "wet_A" ;
lin whatPl_IP = mkTerm "whatPl_IP" ;
lin whatSg_IP = mkTerm "whatSg_IP" ;
lin when_IAdv = mkTerm "when_IAdv" ;
lin when_Subj = mkTerm "when_Subj" ;
lin where_IAdv = mkTerm "where_IAdv" ;
lin which_IQuant = mkTerm "which_IQuant" ;
lin white_A = mkTerm "white_A" ;
lin whoPl_IP = mkTerm "whoPl_IP" ;
lin whoSg_IP = mkTerm "whoSg_IP" ;
lin why_IAdv = mkTerm "why_IAdv" ;
lin wide_A = mkTerm "wide_A" ;
lin wife_N = mkTerm "wife_N" ;
lin win_V2 = mkTerm "win_V2" ;
lin wind_N = mkTerm "wind_N" ;
lin window_N = mkTerm "window_N" ;
lin wine_N = mkTerm "wine_N" ;
lin wing_N = mkTerm "wing_N" ;
lin wipe_V2 = mkTerm "wipe_V2" ;
lin with_Prep = mkTerm "with_Prep" ;
lin without_Prep = mkTerm "without_Prep" ;
lin woman_N = mkTerm "woman_N" ;
lin wonder_VQ = mkTerm "wonder_VQ" ;
lin wood_N = mkTerm "wood_N" ;
lin worm_N = mkTerm "worm_N" ;
lin write_V2 = mkTerm "write_V2" ;
lin year_N = mkTerm "year_N" ;
lin yellow_A = mkTerm "yellow_A" ;
lin yes_Utt = mkTerm "yes_Utt" ;
lin youPl_Pron = mkTerm "youPl_Pron" ;
lin youPol_Pron = mkTerm "youPol_Pron" ;
lin youSg_Pron = mkTerm "youSg_Pron" ;
lin young_A = mkTerm "young_A" ;
}
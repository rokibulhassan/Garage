class PrewrittenComment < ActiveRecord::Base
   attr_accessible :body_en, :body_fr, :vehicle_type,  :body_af, :body_al, :body_ar, :body_arm, :body_az, :body_eu, :body_be, :body_bn, :body_bs, :body_bg, :body_ca, :body_ceb, :body_zh, :body_hr, :body_cs, :body_da, :body_nl, :body_en, :body_eo, :body_et, :body_fil, :body_fi, :body_fr, :body_gl, :body_ka, :body_de, :body_grc, :body_gu, :body_ht, :body_ha, :body_he, :body_hi, :body_mww, :body_hu, :body_is, :body_ig, :body_id, :body_ga, :body_it, :body_ja, :body_jv, :body_kn, :body_km, :body_ko, :body_lo, :body_la, :body_lv, :body_lt, :body_mk, :body_msa, :body_mt, :body_mi, :body_mr, :body_mn, :body_ne, :body_no, :body_fa, :body_pl, :body_pt, :body_pa, :body_ro, :body_ru, :body_sr, :body_sk, :body_si, :body_so, :body_es, :body_sw, :body_sv, :body_ta, :body_te, :body_th, :body_tr, :body_uk, :body_ur, :body_vi, :body_cy, :body_yi, :body_yo, :body_zu

  validates :body_en, presence: true
  validates :body_fr, presence: true
end

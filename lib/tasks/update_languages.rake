desc 'updating langauage data for each global select option'
task :update_language_option_data => :environment do
  LANG = [["Afrikaans (af)","af"],["Albanian (al)","al"],["Arabic (ar)","ar"],["Armenian (arm)","arm"],["Azerbaijani (az)","az"],["Basque (eu)","eu"],["Belarusian (be)","be"],["Bengali (bn)","bn"],["Bosnian (bs)","bs"],["Bulgarian (bg)","bg"],["Catalan (ca)","ca"],["Cebuano (ceb)","ceb"],["Chinese (zh)","zh"],["Croatian (hr)","hr"],["Czech (cs)","cs"],["Danish (da)","da"],["Dutch (nl)","nl"],["English (en)","en"],["Esperanto (eo)","eo"],["Estonian (et)","et"],["Filipino (fil)","fil"],["Finnish (fi)","fi"],["French (fr)","fr"],["Galician (gl)","gl"],["Georgian (ka)","ka"],["German (de)","de"],["Greek (grc)","grc"],["Gujarati (gu)","gu"],["Haitian Creole (ht)","ht"],["Hausa (ha)","ha"],["Hebrew (he)","he"],["Hindi (hi)","hi"],["Hmong (mww)","mww"],["Hungarian (hu)","hu"],["Icelandic (is)","is"],["Igbo (ig)","ig"],["Indonesian (id)","id"],["Irish (ga)","ga"],["Italian (it)","it"],["Japanese (ja)","ja"],["Javanese (jv)","jv"],["Kannada (kn)","kn"],["Khmer (km)","km"],["Korean (ko)","ko"],["Lao (lo)","lo"],["Latin (la)","la"],["Latvian (lv)","lv"],["Lithuanian (lt)","lt"],["Macedonian (mk)","mk"],["Malay (msa)","msa"],["Maltese (mt)","mt"],["Maori (mi)","mi"],["Marathi (mr)","mr"],["Mongolian (mn)","mn"],["Nepali (ne)","ne"],["Norwegian (no)","no"],["Persian (fa)","fa"],["Polish (pl)","pl"],["Portuguese (pt)","pt"],["Punjabi (pa)","pa"],["Romanian (ro)","ro"],["Russian (ru)","ru"],["Serbian (sr)","sr"],["Slovak (sk)","sk"],["Slovenian (si)","si"],["Somali (so)","so"],["Spanish (es)","es"],["Swahili (sw)","sw"],["Swedish (sv)","sv"],["Tamil (ta)","ta"],["Telugu (te)","te"],["Thai (th)","th"],["Turkish (tr)","tr"],["Ukrainian (uk)","uk"],["Urdu (ur)","ur"],["Vietnamese (vi)","vi"],["Welsh (cy)","cy"],["Yiddish (yi)","yi"],["Yoruba (yo)","yo"],["Zulu (zu)","zu"]]

  LANG.each do |lang|
    GlobalSelectOption.all.each do |gso| 
      gso.options.merge!(lang[1] => gso.options["en"])
      gso.options[lang[1]].uniq
      gso.save
    end
  end
end

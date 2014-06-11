Models.LinkifiedMixin =
  linkified: (input)->
    text = linkify input,
      callback: (text, href)=>
        if href then '[url=' + href + ']' + text + '[/url]' else text
    _.escape(text).replace(/\[url=((http|https|mailto):[^\]]+)\](\S+)\[&#x2F;url\]/g,'<a href="$1" target="_blank">$3<\/a>')

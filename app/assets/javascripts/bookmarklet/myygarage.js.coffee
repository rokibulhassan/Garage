window.myyGarageDVRT.run = ->
  $ = window.myyGarageDVRT.jQuery

  getJSParams = (scriptName, paramName, ifEmpty) ->
    scriptElements = document.getElementsByTagName("script")
    ifEmpty = ""  unless ifEmpty?
    a = 0
    while a < scriptElements.length
      sourceString = scriptElements[a].src
      if sourceString.indexOf(scriptName) >= 0
        paramName = paramName.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]")
        regexString = new RegExp("[\\?&]" + paramName + "=([^&#]*)")
        parsedParams = regexString.exec(sourceString)
        unless parsedParams?
          return ifEmpty
        else
          return parsedParams[1]
      a++

  mouseEnterLeave = (o, enterCallback, leaveCallback) ->
    $(o).on "mouseover", (e) ->
      try
        clearTimeout o.outTimer
      enterCallback.call o  if typeof enterCallback is "function"  unless o.overing
      o.overing = true

    $(o).on "mouseout", (e) ->
      o.outTimer = setTimeout(->
        o.overing = false
        leaveCallback.call o  if typeof leaveCallback is "function"
      , 0)

  closePopup = ->
    bg = d.getElementById("myygarage-background")
    bg.parentNode.removeChild bg
    div = d.getElementById("myygarage-popup")
    div.parentNode.removeChild div
    $('body').css('marginTop', '0')
    $(css).remove()

  getVideoId = (arg)->
    candidates = arg.url.split('?')[0].split("#")[0].split("/")
    candidate = undefined
    while not candidate
      candidate = candidates.pop()
    encodeURIComponent candidate

  checkVideoTags = ->
    tagNames = ['video', 'embed', 'iframe', 'object']

    tagMatchers =
      video:
        youtube:
          attr : 'src'
          match: [/videoplayback/]
      embed:
        youtube:
          attr : 'src'
          match: [/^http:\/\/s\.ytimg\.com\/yt/, /^http:\/\/.*?\.?youtube-nocookie\.com\/v/]
      iframe:
        youtube:
          attr : 'src'
          match: [/^http:\/\/www\.youtube\.com\/embed\/([a-zA-Z0-9\-_]+)/]
      object:
        youtube:
          attr : 'data'
          match: [/^http:\/\/.*?\.?youtube-nocookie\.com\/v/]

    tagProcessors =
      youtube:
        video: (tag)->
          console.log tag
        embed: (tag)->
          params = $(tag).attr('flashvars')
          if (found = params?.split("video_id=")[1])
            return encodeURIComponent(found.split("&")[0])
          else
            return getVideoId { url: tag.src }
        iframe: (tag)->
          getVideoId { url: tag.src }
        object: (tag)->
          console.log tag

    thumbCreators =
      youtube: (videoId)->
        $('<img />').attr('src', 'http://img.youtube.com/vi/' + videoId + '/0.jpg')[0]

    foundTags = []
    for tagName in tagNames
      tags =  $(tagName)
      for tag in tags
        foundTags.push tag

    videos = []
    for foundTag in foundTags
      tagName = foundTag.tagName.toLowerCase()
      if tagMatchers[tagName]
        for origin of tagMatchers[tagName]
          attrName = tagMatchers[tagName][origin]['attr']
          if $(foundTag).attr(attrName)?
            for matcher in tagMatchers[tagName][origin]['match']
              $(foundTag).attr(attrName).match(matcher) && videos.push { origin: origin, id: tagProcessors[origin][tagName](foundTag) }

    imgs = []
    for video in videos
      imgs.push $(thumbCreators[video.origin](video.id)).attr('data-video-src', video.origin).attr('data-video-id', video.id)[0]
    imgs

  return if document.getElementById("myygarage-popup") or window.myyGarageDVRT.running
  window.myyGarageDVRT.running = true

  scriptName = 'myygarage'
  scriptHost = getJSParams(scriptName, 'host')
  userId = getJSParams(scriptName, 'prof')

  maxImagesToInspect = 100
  maxImagesToReturn = 24
  minWidth = 190
  minHeight = 140

  d = document
  h = d.getElementsByTagName("HEAD")

  css = d.createElement("style")
  css.setAttribute "type", "text/css"
  ((if h.length then h[0] else d.body)).appendChild css
  styleText = "body,html { margin:0; padding:0; } " +
    "#myygarage-popup { " +
    "background-color:#fff; " +
    "position:absolute; top:0; left:0; " +
    "width:100%; z-index: 2147483647; text-align: left; " +
    "font-weight:normal; font-family:Arial; font-family:Arial !important; " +
    "} " +
    "#myygarage-popup a { text-decoration: none; } " +
    "#myygarage-popup a img { border:0; } " +
    "#myygarage-popup .myygarage-title { height:56px; line-height:56px; background-color:#fff; } " +
    "#myygarage-popup .myygarage-title-inner { padding:0px 90px; height:56px; } " +
    "#myygarage-popup .myygarage-ok { background-color: #4d90fe; border: 1px solid #dcdcdc; border-radius: 2px; color: #fff; font-size: 14px; font-weight: bold; position: absolute; display: inline-block; right: 160px; top: 15px; line-height: 20px; moz-border-radius: 4px; padding: 3px 25px; text-decoration: none; webkit-border-radius: 2px; }" +
  "#myygarage-popup .myygarage-pictures { height: 163px; overflow-y: scroll; }" +

  "#myygarage-popup .myygarage-close { background-color: #f5f5f5; border: 1px solid #dcdcdc; border-radius: 2px; margin-left: 25px; padding: 3px 25px; display: inline-block; position: absolute; top: 15px; right: 40px; color: #444; background-image: -webkit-linear-gradient(top,#f5f5f5,#f1f1f1); background-image: -moz-linear-gradient(top,#f5f5f5,#f1f1f1); background-image: -ms-linear-gradient(top,#f5f5f5,#f1f1f1); background-image: -o-linear-gradient(top,#f5f5f5,#f1f1f1); background-image: linear-gradient(top,#f5f5f5,#f1f1f1); filter: progid:DXImageTransform.Microsoft.gradient(startColorStr='#f5f5f5',EndColorStr='#f1f1f1')} " +


    "#myygarage-popup .myygarage-close:hover { background-position: -396px -100px } " +
    "#myygarage-popup .myygarage-body { padding:0px 90px 20px; border-bottom: 1px solid #bbb; margin: 0; } "
  styleText += "#myygarage-popup .myygarage-caption { font-size:14px; line-height:20px; color:#000; font-weight:bold; } " +
    "#myygarage-background { background-color:#000; opacity:.5; position:absolute; top:0; left:0; z-index:2147483640; filter:alpha(opacity=50);} " +
    "#myygarage-popup .myygarage-image-wrapper { cursor: pointer; float:left; margin:0 25px 25px 0; position:relative; } " +
    "#myygarage-popup .myygarage-image-wrapper .myygarage-mask { position:absolute; z-index:5; height:140px; display:none; } " +
    "#myygarage-popup .myygarage-image-wrapper .myygarage-mask.myygarage-mask-picked { border:4px solid #1900FF; display:block; } " +
    "#myygarage-popup .myygarage-image-wrapper .myygarage-mask.myygarage-mask-pick { border:4px solid #208F14; } " +
    "#myygarage-popup .myygarage-image-wrapper .myygarage-mask.myygarage-mask-drop { border:4px solid #E01B1B; } " +
    "#myygarage-popup .myygarage-image-wrapper img { position:relative; top:4px; left:4px; } " +
    "#myygarage-popup .myygarage-image-wrapper .myygarage-mask-bg { width:100%;position:absolute; bottom:0; text-align:center; background-color:rgba(0,0,0,.3); filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#4B000000 ,endColorstr=#4B000000); } " +
    "#myygarage-popup .myygarage-image-wrapper .myygarage-mask-bg .myygarage-mask-inner { padding: 15px 0; } "
  styleText += "#myygarage-popup .myygarage-image-wrapper .myygarage-detail { width:100%; display:block; font-size:12px; color:#888; height:12px; margin-top:8px; text-align:center; }\n" +
    "#myygarage-popup .myygarage-mask-a { border: 1px solid transparent; border-radius: 6px; color: #fff; display: block; font-size: 14px; font-weight: bold; left: 0; line-height: 30px; margin: 0 auto; moz-border-radius: 6px; padding: 0 18px; position: relative; text-align: center; text-decoration: none; top: 0; webkit-border-radius: 6px; width: 60px; }" +
    "#myygarage-popup .myygarage-mask-pick .myygarage-mask-a { background-color: #208F14; }" +
    "#myygarage-popup .myygarage-mask-drop .myygarage-mask-a { background-color: #E01B1B; }" +
    ""
  if css.styleSheet
    css.styleSheet.cssText = styleText
  else
    css_textnode = d.createTextNode(styleText)
    css.appendChild css_textnode

  imgs = []
  if window.location.hostname == 'www.leboncoin.fr' and window.aImages?
    for imageSrc in window.aImages
      altText = $('#thumbs_carousel .thumbs[style="background-image: url(\'' + imageSrc.replace(/\/images\//, '/thumbs/') + '\');"]').parent().attr('title')
      img = $('<img />').attr('src', imageSrc).attr('alt', altText)[0]
      imgs.push img
  else if window.location.hostname == 'www.caradisiac.com'
    rawImages = $('img')
    for rawImg in rawImages
      fullImageSrc = rawImg.src.replace(/(^.*?images.caradisiac.com.*?\/S)[2-6]+([^/]*?$)/, '$17$2')
      if fullImageSrc == rawImg.src
        img = rawImg
      else
        img = $('<img />').attr('src', fullImageSrc).attr('alt', rawImg.alt)[0]
      imgs.push img

  else
    imgs = $('img')

  Array::push.apply imgs, checkVideoTags()
  console.log imgs

  callbackDone = ->
    imgSeen = {}
    imgFound = []
    i = 0
    img = undefined

    while (img = imgs[i]) and (imgFound.length <= maxImagesToInspect)
      if img.width >= minWidth and img.height >= minHeight and img.src != ''
        unless imgSeen[img.src]
          imgSeen[img.src] = true
          data = $(img).data()
          imgFound.push
            src: img.src
            alt: img.alt or img.title or img.parentNode?.title or ""
            height: img.height
            width: img.width
            mediaType: data?.videoSrc or 'picture'
            videoId: data?.videoId or ''
            drop: false

      i++
    found = imgFound.slice(0, maxImagesToReturn)

    captionText = (if found.length > 0 then '' else "Oops. We couldn't find any images for you to grab on this page.")
    $('body')
      .append($(d.createElement('div'))
        .attr('id', 'myygarage-background')
        .css('width', $(window).width() + "px")
        .css('height', $(window).height() + "px"))

    embeds = document.getElementsByTagName("embed")
    collision = false
    if embeds.length
      i = 0
      l = embeds.length

      while i < l
        offset = 0
        obj = embeds[i]
        if obj.offsetParent
          loop
            offset += obj.offsetTop
            break unless obj = obj.offsetParent
        if offset < 326
          collision = true
          break
        i++
    $('body').css('marginTop', '326px') if collision

    $('body').append($(d.createElement('div'))
      .attr('id', 'myygarage-popup')
      .html($('<div class="myygarage-title" />')
        .html($('<div class="myygarage-title-inner" />')
          .html('<span class="myygarage-caption">Select Image(s) you wish to import yo tour cloud&nbsp;</span>' +
            '<a class="myygarage-ok" href="javascript:;" id="myygarage-ok-button">&nbsp;Import pictures to Myy Cloud&nbsp;</a>' +
            '<a class="myygarage-caption myygarage-close" href="javascript:;" id="myygarage-close-button">Cancel</a>')))
      .append($('<div class="myygarage-body" ><div class="myygarage-caption">' + captionText + '</div><div class="myygarage-pictures" /></div>')))

    container = $('.myygarage-pictures')

    i = 0
    img = undefined
    imgSelected = {}

    while img = found[i]
      ((img) ->
        div = $(d.createElement('div')).addClass("myygarage-image-wrapper")

        div.on "click", ->
          if img.drop == false
            actionClassBefore = 'pick'
            actionClassAfter = 'drop'
            newAction = '<a href="#" class="myygarage-mask-a">Drop It</a>'
          else
            actionClassBefore = 'drop'
            actionClassAfter = 'pick'
            newAction = '<a href="#" class="myygarage-mask-a">Pick It</a>'

          div
            .find('.myygarage-mask-' + actionClassBefore)
              .removeClass('myygarage-mask-' + actionClassBefore)
              .addClass('myygarage-mask-' + actionClassAfter)
              .find('.myygarage-mask-inner')
                .html(newAction)
          div
            .find('.myygarage-mask')
              .toggleClass('myygarage-mask-picked')
          imgSelected[img.src] = img.drop = !img.drop

          false

        _w = Math.round(img.width * 140 / img.height)
        _w = 130  if _w < 130
        _w = 250  if _w > 250

        action = '<a href="#" class="myygarage-mask-a">Pick It</a>'
        maskClass = 'pick'
        mask = $(d.createElement('div'))
          .addClass("myygarage-mask")
          .addClass("myygarage-mask-" + maskClass)
          .css('width', _w + "px")
          .html($('<div class="myygarage-mask-bg" />')
            .html($('<div class="myygarage-mask-inner" />')
              .html(action)))

        div
          .append($(d.createElement('div'))
            .addClass("myygarage-mask")
            .css('width', _w + "px"))
          .append(mask)
          .append($(d.createElement('img'))
            .attr('src', img.src)
            .attr('width', _w)
            .css('width', _w + "px")
            .attr('height', 140)
            .css('height', "140px"))
          .append($(d.createElement('div'))
            .addClass("myygarage-detail")
            .css('width', _w + "px")
            .append(img.width + " x " + img.height))
        container.append div

        mouseEnterLeave div, (->
          mask.css('display', 'block')
        ), ->
          mask.css('display', 'none')

      ) img
      i++
    container.append($(d.createElement('div'))
      .css('clear', 'both')
      .css('height', '0px')
      .css('font-size', '0px'))

    $("#myygarage-close-button").on "click", closePopup

    $("#myygarage-ok-button").on "click", ->
      return if found.length == 0

      selected = found.filter (img)-> if imgSelected[img.src] then true else false
      return if selected.length == 0

      message = encodeURIComponent(JSON.stringify(selected))
      window.open('http://' + scriptHost + '/profiles/' + userId + '/pictures/new?r=1#' + message, 'Myy Garage Bookmarklet', 'width=960,height=577,status=yes')

      closePopup()
    try
      document.body.scrollTop = 0
    try
      document.contentElement.scrollTop = 0
    try
      window.scrollTo 0, 0

  callbackWait = ->
    imgComplete = (img for img in imgs when img.complete)
    if imgComplete.length < imgs.length
      setTimeout callbackWait, 50
    else
      callbackDone()
      window.myyGarageDVRT.running = false

  setTimeout callbackWait, 0

v = "1.7.2"
if window.myyGarageDVRT.jQuery is `undefined`
  done = false
  script = document.createElement("script")
  script.src = "http://ajax.googleapis.com/ajax/libs/jquery/" + v + "/jquery.min.js"
  script.onload = script.onreadystatechange = ->
    if not done and (not @readyState or @readyState is "loaded" or @readyState is "complete")
      done = true
      window.myyGarageDVRT.jQuery = window.jQuery.noConflict(true)
      window.myyGarageDVRT.run()

  document.body.appendChild script
else
  window.myyGarageDVRT.run()

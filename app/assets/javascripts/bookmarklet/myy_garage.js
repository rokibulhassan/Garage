var done, script, v;

window.myyGarageDVRT.run = function() {
  var $, altText, callbackDone, callbackWait, checkVideoTags, closePopup, css, css_textnode, d, fullImageSrc, getJSParams, getVideoId, h, imageSrc, img, imgs, maxImagesToInspect, maxImagesToReturn, minHeight, minWidth, mouseEnterLeave, rawImages, rawImg, scriptHost, scriptName, styleText, userId, _i, _j, _len, _len1, _ref;
  $ = window.myyGarageDVRT.jQuery;
  getJSParams = function(scriptName, paramName, ifEmpty) {
    var a, parsedParams, regexString, scriptElements, sourceString;
    scriptElements = document.getElementsByTagName("script");
    if (ifEmpty == null) {
      ifEmpty = "";
    }
    a = 0;
    while (a < scriptElements.length) {
      sourceString = scriptElements[a].src;
      if (sourceString.indexOf(scriptName) >= 0) {
        paramName = paramName.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
        regexString = new RegExp("[\\?&]" + paramName + "=([^&#]*)");
        parsedParams = regexString.exec(sourceString);
        if (parsedParams == null) {
          return ifEmpty;
        } else {
          return parsedParams[1];
        }
      }
      a++;
    }
  };
  mouseEnterLeave = function(o, enterCallback, leaveCallback) {
    $(o).on("mouseover", function(e) {
      try {
        clearTimeout(o.outTimer);
      } catch (_error) {}
      if (!o.overing ? typeof enterCallback === "function" : void 0) {
        enterCallback.call(o);
      }
      return o.overing = true;
    });
    return $(o).on("mouseout", function(e) {
      return o.outTimer = setTimeout(function() {
        o.overing = false;
        if (typeof leaveCallback === "function") {
          return leaveCallback.call(o);
        }
      }, 0);
    });
  };
  closePopup = function() {
    var bg, div;
    bg = d.getElementById("myygarage-background");
    bg.parentNode.removeChild(bg);
    div = d.getElementById("myygarage-popup");
    div.parentNode.removeChild(div);
    $('body').css('marginTop', '0');
    return $(css).remove();
  };
  getVideoId = function(arg) {
    var candidate, candidates;
    candidates = arg.url.split('?')[0].split("#")[0].split("/");
    candidate = void 0;
    while (!candidate) {
      candidate = candidates.pop();
    }
    return encodeURIComponent(candidate);
  };
  checkVideoTags = function() {
    var attrName, foundTag, foundTags, imgs, matcher, origin, tag, tagMatchers, tagName, tagNames, tagProcessors, tags, thumbCreators, video, videos, _i, _j, _k, _l, _len, _len1, _len2, _len3, _len4, _m, _ref;
    tagNames = ['video', 'embed', 'iframe', 'object'];
    tagMatchers = {
      video: {
        youtube: {
          attr: 'src',
          match: [/videoplayback/]
        }
      },
      embed: {
        youtube: {
          attr: 'src',
          match: [/^http:\/\/s\.ytimg\.com\/yt/, /^http:\/\/.*?\.?youtube-nocookie\.com\/v/]
        }
      },
      iframe: {
        youtube: {
          attr: 'src',
          match: [/^http:\/\/www\.youtube\.com\/embed\/([a-zA-Z0-9\-_]+)/]
        }
      },
      object: {
        youtube: {
          attr: 'data',
          match: [/^http:\/\/.*?\.?youtube-nocookie\.com\/v/]
        }
      }
    };
    tagProcessors = {
      youtube: {
        video: function(tag) {
          return console.log(tag);
        },
        embed: function(tag) {
          var found, params;
          params = $(tag).attr('flashvars');
          if ((found = params != null ? params.split("video_id=")[1] : void 0)) {
            return encodeURIComponent(found.split("&")[0]);
          } else {
            return getVideoId({
              url: tag.src
            });
          }
        },
        iframe: function(tag) {
          return getVideoId({
            url: tag.src
          });
        },
        object: function(tag) {
          return console.log(tag);
        }
      }
    };
    thumbCreators = {
      youtube: function(videoId) {
        return $('<img />').attr('src', 'http://img.youtube.com/vi/' + videoId + '/0.jpg')[0];
      }
    };
    foundTags = [];
    for (_i = 0, _len = tagNames.length; _i < _len; _i++) {
      tagName = tagNames[_i];
      tags = $(tagName);
      for (_j = 0, _len1 = tags.length; _j < _len1; _j++) {
        tag = tags[_j];
        foundTags.push(tag);
      }
    }
    videos = [];
    for (_k = 0, _len2 = foundTags.length; _k < _len2; _k++) {
      foundTag = foundTags[_k];
      tagName = foundTag.tagName.toLowerCase();
      if (tagMatchers[tagName]) {
        for (origin in tagMatchers[tagName]) {
          attrName = tagMatchers[tagName][origin]['attr'];
          if ($(foundTag).attr(attrName) != null) {
            _ref = tagMatchers[tagName][origin]['match'];
            for (_l = 0, _len3 = _ref.length; _l < _len3; _l++) {
              matcher = _ref[_l];
              $(foundTag).attr(attrName).match(matcher) && videos.push({
                origin: origin,
                id: tagProcessors[origin][tagName](foundTag)
              });
            }
          }
        }
      }
    }
    imgs = [];
    for (_m = 0, _len4 = videos.length; _m < _len4; _m++) {
      video = videos[_m];
      imgs.push($(thumbCreators[video.origin](video.id)).attr('data-video-src', video.origin).attr('data-video-id', video.id)[0]);
    }
    return imgs;
  };
  if (document.getElementById("myygarage-popup") || window.myyGarageDVRT.running) {
    return;
  }
  window.myyGarageDVRT.running = true;
  scriptName = 'myygarage';
  scriptHost = getJSParams(scriptName, 'host');
  userId = getJSParams(scriptName, 'prof');
  maxImagesToInspect = 100;
  maxImagesToReturn = 24;
  minWidth = 190;
  minHeight = 140;
  d = document;
  h = d.getElementsByTagName("HEAD");
  css = d.createElement("style");
  css.setAttribute("type", "text/css");
  (h.length ? h[0] : d.body).appendChild(css);
  styleText = "body,html { margin:0; padding:0; } " + "#myygarage-popup { " + "background-color:#fff; " + "position:absolute; top:0; left:0; " + "width:100%; z-index: 2147483647; text-align: left; " + "font-weight:normal; font-family:Arial; font-family:Arial !important; " + "} " + "#myygarage-popup a { text-decoration: none; } " + "#myygarage-popup a img { border:0; } " + "#myygarage-popup .myygarage-title { height:56px; line-height:56px; background-color:#fff; } " + "#myygarage-popup .myygarage-title-inner { padding:0px 90px; height:56px; } " + "#myygarage-popup .myygarage-ok { background-color: #4d90fe; border: 1px solid #dcdcdc; border-radius: 2px; color: #fff; font-size: 14px; font-weight: bold; position: absolute; display: inline-block; right: 160px; top: 15px; line-height: 20px; moz-border-radius: 4px; padding: 3px 25px; text-decoration: none; webkit-border-radius: 2px; }" + "#myygarage-popup .myygarage-pictures { height: 163px; overflow-y: scroll; }" + "#myygarage-popup .myygarage-close { background-color: #f5f5f5; border: 1px solid #dcdcdc; border-radius: 2px; margin-left: 25px; padding: 3px 25px; display: inline-block; position: absolute; top: 15px; right: 40px; color: #444; background-image: -webkit-linear-gradient(top,#f5f5f5,#f1f1f1); background-image: -moz-linear-gradient(top,#f5f5f5,#f1f1f1); background-image: -ms-linear-gradient(top,#f5f5f5,#f1f1f1); background-image: -o-linear-gradient(top,#f5f5f5,#f1f1f1); background-image: linear-gradient(top,#f5f5f5,#f1f1f1); filter: progid:DXImageTransform.Microsoft.gradient(startColorStr='#f5f5f5',EndColorStr='#f1f1f1')} " + "#myygarage-popup .myygarage-close:hover { background-position: -396px -100px } " + "#myygarage-popup .myygarage-body { padding:0px 90px 20px; border-bottom: 1px solid #bbb; margin: 0; } ";
  styleText += "#myygarage-popup .myygarage-caption { font-size:14px; line-height:20px; color:#000; font-weight:bold; } " + "#myygarage-background { background-color:#000; opacity:.5; position:absolute; top:0; left:0; z-index:2147483640; filter:alpha(opacity=50);} " + "#myygarage-popup .myygarage-image-wrapper { cursor: pointer; float:left; margin:0 25px 25px 0; position:relative; } " + "#myygarage-popup .myygarage-image-wrapper .myygarage-mask { position:absolute; z-index:5; height:140px; display:none; } " + "#myygarage-popup .myygarage-image-wrapper .myygarage-mask.myygarage-mask-picked { border:4px solid #1900FF; display:block; } " + "#myygarage-popup .myygarage-image-wrapper .myygarage-mask.myygarage-mask-pick { border:4px solid #208F14; } " + "#myygarage-popup .myygarage-image-wrapper .myygarage-mask.myygarage-mask-drop { border:4px solid #E01B1B; } " + "#myygarage-popup .myygarage-image-wrapper img { position:relative; top:4px; left:4px; } " + "#myygarage-popup .myygarage-image-wrapper .myygarage-mask-bg { width:100%;position:absolute; bottom:0; text-align:center; background-color:rgba(0,0,0,.3); filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#4B000000 ,endColorstr=#4B000000); } " + "#myygarage-popup .myygarage-image-wrapper .myygarage-mask-bg .myygarage-mask-inner { padding: 15px 0; } ";
  styleText += "#myygarage-popup .myygarage-image-wrapper .myygarage-detail { width:100%; display:block; font-size:12px; color:#888; height:12px; margin-top:8px; text-align:center; }\n" + "#myygarage-popup .myygarage-mask-a { border: 1px solid transparent; border-radius: 6px; color: #fff; display: block; font-size: 14px; font-weight: bold; left: 0; line-height: 30px; margin: 0 auto; moz-border-radius: 6px; padding: 0 18px; position: relative; text-align: center; text-decoration: none; top: 0; webkit-border-radius: 6px; width: 60px; }" + "#myygarage-popup .myygarage-mask-pick .myygarage-mask-a { background-color: #208F14; }" + "#myygarage-popup .myygarage-mask-drop .myygarage-mask-a { background-color: #E01B1B; }" + "";
  if (css.styleSheet) {
    css.styleSheet.cssText = styleText;
  } else {
    css_textnode = d.createTextNode(styleText);
    css.appendChild(css_textnode);
  }
  imgs = [];
  if (window.location.hostname === 'www.leboncoin.fr' && (window.aImages != null)) {
    _ref = window.aImages;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      imageSrc = _ref[_i];
      altText = $('#thumbs_carousel .thumbs[style="background-image: url(\'' + imageSrc.replace(/\/images\//, '/thumbs/') + '\');"]').parent().attr('title');
      img = $('<img />').attr('src', imageSrc).attr('alt', altText)[0];
      imgs.push(img);
    }
  } else if (window.location.hostname === 'www.caradisiac.com') {
    rawImages = $('img');
    for (_j = 0, _len1 = rawImages.length; _j < _len1; _j++) {
      rawImg = rawImages[_j];
      fullImageSrc = rawImg.src.replace(/(^.*?images.caradisiac.com.*?\/S)[2-6]+([^/]*?$)/, '$17$2');
      if (fullImageSrc === rawImg.src) {
        img = rawImg;
      } else {
        img = $('<img />').attr('src', fullImageSrc).attr('alt', rawImg.alt)[0];
      }
      imgs.push(img);
    }
  } else {
    imgs = $('img');
  }
  Array.prototype.push.apply(imgs, checkVideoTags());
  console.log(imgs);
  callbackDone = function() {
    var captionText, collision, container, data, embeds, found, i, imgFound, imgSeen, imgSelected, l, obj, offset, _ref1;
    imgSeen = {};
    imgFound = [];
    i = 0;
    img = void 0;
    while ((img = imgs[i]) && (imgFound.length <= maxImagesToInspect)) {
      if (img.width >= minWidth && img.height >= minHeight && img.src !== '') {
        if (!imgSeen[img.src]) {
          imgSeen[img.src] = true;
          data = $(img).data();
          imgFound.push({
            src: img.src,
            alt: img.alt || img.title || ((_ref1 = img.parentNode) != null ? _ref1.title : void 0) || "",
            height: img.height,
            width: img.width,
            mediaType: (data != null ? data.videoSrc : void 0) || 'picture',
            videoId: (data != null ? data.videoId : void 0) || '',
            drop: false
          });
        }
      }
      i++;
    }
    found = imgFound.slice(0, maxImagesToReturn);
    captionText = (found.length > 0 ? '' : "Oops. We couldn't find any images for you to grab on this page.");
    $('body').append($(d.createElement('div')).attr('id', 'myygarage-background').css('width', $(window).width() + "px").css('height', $(window).height() + "px"));
    embeds = document.getElementsByTagName("embed");
    collision = false;
    if (embeds.length) {
      i = 0;
      l = embeds.length;
      while (i < l) {
        offset = 0;
        obj = embeds[i];
        if (obj.offsetParent) {
          while (true) {
            offset += obj.offsetTop;
            if (!(obj = obj.offsetParent)) {
              break;
            }
          }
        }
        if (offset < 326) {
          collision = true;
          break;
        }
        i++;
      }
    }
    if (collision) {
      $('body').css('marginTop', '326px');
    }
    $('body').append($(d.createElement('div')).attr('id', 'myygarage-popup').html($('<div class="myygarage-title" />').html($('<div class="myygarage-title-inner" />').html('<span class="myygarage-caption">Select Image(s) you wish to import yo tour cloud&nbsp;</span>' + '<a class="myygarage-ok" href="javascript:" id="myygarage-ok-button">&nbsp;Import pictures to Myy Cloud&nbsp;</a>' + '<a class="myygarage-caption myygarage-close" href="javascript:;" id="myygarage-close-button">Cancel</a>'))).append($('<div class="myygarage-body" ><div class="myygarage-caption">' + captionText + '</div><div class="myygarage-pictures" /></div>')));
    container = $('.myygarage-pictures');
    i = 0;
    img = void 0;
    imgSelected = {};
    while (img = found[i]) {
      (function(img) {
        var action, div, mask, maskClass, _w;
        div = $(d.createElement('div')).addClass("myygarage-image-wrapper");
        div.on("click", function() {
          var actionClassAfter, actionClassBefore, newAction;
          if (img.drop === false) {
            actionClassBefore = 'pick';
            actionClassAfter = 'drop';
            newAction = '<a href="#" class="myygarage-mask-a">Drop It</a>';
          } else {
            actionClassBefore = 'drop';
            actionClassAfter = 'pick';
            newAction = '<a href="#" class="myygarage-mask-a">Pick It</a>';
          }
          div.find('.myygarage-mask-' + actionClassBefore).removeClass('myygarage-mask-' + actionClassBefore).addClass('myygarage-mask-' + actionClassAfter).find('.myygarage-mask-inner').html(newAction);
          div.find('.myygarage-mask').toggleClass('myygarage-mask-picked');
          imgSelected[img.src] = img.drop = !img.drop;
          return false;
        });
        _w = Math.round(img.width * 140 / img.height);
        if (_w < 130) {
          _w = 130;
        }
        if (_w > 250) {
          _w = 250;
        }
        action = '<a href="#" class="myygarage-mask-a">Pick It</a>';
        maskClass = 'pick';
        mask = $(d.createElement('div')).addClass("myygarage-mask").addClass("myygarage-mask-" + maskClass).css('width', _w + "px").html($('<div class="myygarage-mask-bg" />').html($('<div class="myygarage-mask-inner" />').html(action)));
        div.append($(d.createElement('div')).addClass("myygarage-mask").css('width', _w + "px")).append(mask).append($(d.createElement('img')).attr('src', img.src).attr('width', _w).css('width', _w + "px").attr('height', 140).css('height', "140px")).append($(d.createElement('div')).addClass("myygarage-detail").css('width', _w + "px").append(img.width + " x " + img.height));
        container.append(div);
        return mouseEnterLeave(div, (function() {
          return mask.css('display', 'block');
        }), function() {
          return mask.css('display', 'none');
        });
      })(img);
      i++;
    }
    container.append($(d.createElement('div')).css('clear', 'both').css('height', '0px').css('font-size', '0px'));
    $("#myygarage-close-button").on("click", closePopup);
    $("#myygarage-ok-button").on("click", function() {
      var message, selected;
      if (found.length === 0) {
        return;
      }
      selected = found.filter(function(img) {
        if (imgSelected[img.src]) {
          return true;
        } else {
          return false;
        }
      });
      if (selected.length === 0) {
        return;
      }
      message = encodeURIComponent(JSON.stringify(selected));
      window.open('http://' + scriptHost + '/profiles/' + userId + '/pictures/new?r=1#' + message, 'Myy Garage Bookmarklet', 'width=960,height=577,status=yes');
      return closePopup();
    });
    try {
      document.body.scrollTop = 0;
    } catch (_error) {}
    try {
      document.contentElement.scrollTop = 0;
    } catch (_error) {}
    try {
      return window.scrollTo(0, 0);
    } catch (_error) {}
  };
  callbackWait = function() {
    var imgComplete;
    imgComplete = (function() {
      var _k, _len2, _results;
      _results = [];
      for (_k = 0, _len2 = imgs.length; _k < _len2; _k++) {
        img = imgs[_k];
        if (img.complete) {
          _results.push(img);
        }
      }
      return _results;
    })();
    if (imgComplete.length < imgs.length) {
      return setTimeout(callbackWait, 50);
    } else {
      callbackDone();
      return window.myyGarageDVRT.running = false;
    }
  };
  return setTimeout(callbackWait, 0);
};

v = "1.7.2";

if (window.myyGarageDVRT.jQuery === undefined) {
  done = false;
  script = document.createElement("script");
  script.src = "http://ajax.googleapis.com/ajax/libs/jquery/" + v + "/jquery.min.js";
  script.onload = script.onreadystatechange = function() {
    if (!done && (!this.readyState || this.readyState === "loaded" || this.readyState === "complete")) {
      done = true;
      window.myyGarageDVRT.jQuery = window.jQuery.noConflict(true);
      return window.myyGarageDVRT.run();
    }
  };
  document.body.appendChild(script);
} else {
  window.myyGarageDVRT.run();
}

javascript: (function (oWindow, oDocument, jQueryVersion, callback) {
  oWindow.MyyGarage = {}
  var currentjQuery, scriptEl, loaded, readyState;

  // We load jQuery if there is no jQuery in the page, or if the present jQuery is older than the one we need.
  if (!(currentjQuery = oWindow.jQuery) || jQueryVersion > currentjQuery.fn.jquery || callback(currentjQuery)) {
    scriptEl        = oDocument.createElement('script');
    scriptEl.type   = 'text/javascript';
    scriptEl.src    = 'http://ajax.googleapis.com/ajax/libs/jquery/' + jQueryVersion + '/jquery.min.js';
    scriptEl.onload = scriptEl.onreadystatechange = function () {
      // When the script loading is finished, we run the callback with jQuery in no-conflict mode.
      if (!loaded && (!(readyState = this.readyState) || readyState == 'loaded' || readyState == 'complete')) {
        callback((currentjQuery = oWindow.jQuery).noConflict(1), loaded = 1);
        currentjQuery(scriptEl).remove()
        oWindow.MyyGarage.$ = currentjQuery;
      }
    };
    oDocument.documentElement.childNodes[0].appendChild(scriptEl)
  }
})(window, document, '1.7.2', function ($, L) {
  window.MyyGarage.$ = $
  var scriptUrl = 'http://lux2012.no-ip.org:3000/bookmarklet.js';
  $.getScript(scriptUrl);
});

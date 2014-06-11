Models.Cutout = Backbone.RelationalModel.extend({
  superUrl: Backbone.RelationalModel.prototype.url

  url: ->
    queryString = if @get('picture_id') then "?picture_id=#{@get('picture_id')}" else ''
    @superUrl() + queryString


  altText: ->
    if @get('picture')? and @get('picture').id? then @get('picture').altText() + ' cutout' else "#{@get('width')}x#{@get('height')} placeholder"
}, {
  youTubeSource: (options)->
    queryString = '?rel=0'
    options.youtube_start_at && queryString += '&start=' + options.youtube_start_at
    options.youtube_hd && options.youtube_hd == true && queryString += '&hd=1'
    'http://www.youtube.com/embed/' + options.youtube_video_id + queryString


  youTubeVideoId: (url)->
    m = /^(?:https?:\/\/)?(?:www\.)?youtube\.com\/watch\?(?=.*v=((\w|-){11}))(?:\S+)?$/.exec(url)
    return m[1] if m?
    m = /^(?:https?:\/\/)?youtu\.be\/((\w|-){11})(?:\?\S+)?$/.exec(url)
    return m[1] if m?
    false


  youTubeStartAt: (url)->
    m = /[^?]*(?:.*?)[?&]t=(?:(\d+)m)?(?:(\d+)s)/.exec(url)
    if m?
      parseInt(m[2], 10) + (if m[1]? then parseInt(m[1], 10) * 60 else 0)
    else
      false


  youTubeHd: (url)->
    m = /[^?]*(?:.*?)[?&]hd=([^&]+)/.exec(url)
    if m? and m[1] == '1' then true else false
})

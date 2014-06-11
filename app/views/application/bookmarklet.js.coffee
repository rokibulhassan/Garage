$ = window.MyyGarage.$

$box = $(
  '<div></div>'
  id: 'myy-garage-bookmarklet'
  css:
    zIndex: 9999999
    backgroundColor: 'rgba(0, 0, 0, 0.8)'
    position:        'absolute'
    top:             0
    bottom:          0
    left:            0
    right:           0
)

$close = $(
  '<a />'
  href: '#'
  css:
    color:          '#fff'
    textDecoration: 'none'
    float:          'right'
    padding:        '5px 10px 0 0'
  text: 'Close'
  class: 'close'
  click: (event)->
    $box.remove()
    false
)

$box.append($close)


if $('#myy-garage-bookmarklet').replaceWith($box).length == 0
  $(document.body).append($box)


thumbnailsMaxWidth  = 160
thumbnailsMaxHeight = 160
imageSources        = {}

# Ignore little images and build a grid of thumbnails.
# These thumbnails have the same ratio as the originals.
# Doubles are uniq'ed.
$('img').each (index, image)->
  return if image.width < 100 || image.height < 100
  return if imageSources[image.src]

  imageSources[image.src] = true

  if image.width > image.height
    width  = thumbnailsMaxWidth
    height = Math.round(image.height * width / image.width)

  else
    height = thumbnailsMaxHeight
    width  = Math.round(image.width * height / image.height)

  $thumbnailBlock = $(
    '<div></div>'
    css:
      width: thumbnailsMaxWidth
      height: thumbnailsMaxHeight
      float: 'left'
    click: (event)->
      $this     = $(this)
      actionUrl = 'http://lux2012.no-ip.org:3000/bookmarklet/favorites/new'
      imageUrl  = $this.find('img:first').prop('src')
      pageUrl   = window.location
      url       = "#{actionUrl}?url=#{imageUrl}&pageUrl=#{pageUrl}"
      settings  = 'height=460,width=580'

      window.open(url, 'foo', settings)
      false
  )

  $thumbnailImage = $('<img />', src: image.src, height: height, width: width)

  $item = $thumbnailBlock.append($thumbnailImage)
  $box.append($item)

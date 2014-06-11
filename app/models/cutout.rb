class Cutout < ActiveRecord::Base
  attr_accessible :layout, :row, :col, :crop, :youtube_video_id, :youtube_start_at, :youtube_hd
  serialize :crop, JSON

  belongs_to :collage
  belongs_to :picture
  mount_uploader :image, CutoutImageUploader

  def crop
    attributes['crop'] ||= {}
  end

  def dimensions
    {}.with_indifferent_access
      .merge Settings.collage_layouts[self.layout][self.row][self.col]
  end

  def media_type
    @media_type ||= Settings.collage_layouts[self.layout][self.row][self.col]['t'] == 'video' ? 'video' : 'picture'
  end

  def media_content_url
    if self.media_type == 'picture'
      self.image_collage_url
    elsif self.media_type == 'video'
      self.youtube_url
    end
  end

  def image_collage_url
    self.image.collage.url && self.image.collage.url + "?r=#{self.image_revision}"
  end

  def youtube_url
    #TODO: code duplicates Models.Cutout::youTubeSource
    query_string = '?rel=0'
    self.youtube_start_at && query_string += '&start=' + self.youtube_start_at.to_param
    self.youtube_hd && self.youtube_hd == true && query_string += '&hd=1'
    self.youtube_video_id && ('http://www.youtube.com/embed/' + self.youtube_video_id + query_string)
  end
end

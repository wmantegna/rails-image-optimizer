class BackgroundAsset < ActiveRecord::Base
  serialize :filesize_metadata, Hash

  # upload settings
  ########################
  has_attached_file :attachment, {
    styles: { 
      :thumb => {geometry: '125x100>'},
      :optimized_compress_0 => {geometry: '100%', paperclip_optimizer: {jpegrecompress: {allow_lossy: true, quality: 0}}},
      :optimized_compress_1 => {geometry: '100%', paperclip_optimizer: {jpegrecompress: {allow_lossy: true, quality: 1}}},
      :optimized_compress_2 => {geometry: '100%', paperclip_optimizer: {jpegrecompress: {allow_lossy: true, quality: 2}}},
      :optimized_compress_3 => {geometry: '100%', paperclip_optimizer: {jpegrecompress: {allow_lossy: true, quality: 3}}},
      :optimized_compress_4 => {geometry: '100%', paperclip_optimizer: {jpegrecompress: {allow_lossy: true, quality: 4}}}
    }
  }
  validates_attachment_content_type :attachment, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  ########################

  # background processing
  ########################
  process_in_background :attachment, processing_image_url: :processing_image_fallback
  def processing_image_fallback
    options = attachment.options
    options[:interpolator].interpolate(options[:url], attachment, :original)
  end
  ########################
  

  # Filesize
  ########################
  before_save :determine_dimensions
  # after_save :determine_style_file_sizes
  def determine_dimensions
    if attachment?
      tempfile = attachment.queued_for_write[:original]
      unless tempfile.nil?
        geometry = Paperclip::Geometry.from_file(tempfile)
        self.attachment_width = geometry.width.to_i
        self.attachment_height = geometry.height.to_i
      end
    end
  end
  
  def determine_style_file_sizes
    filesizes = {}
    self.attachment.styles.collect{|k,v| v.name}.each do |style|
      if Rails.application.class.config.paperclip_defaults[:storage] == :s3
        logger.info(self.attachment.url(style.to_sym))
        filesize = URI(self.attachment.url(style.to_sym)).read.size
      else
        filesize = File.read([Rails.root.to_s, "public", self.attachment.url(style)].join("/")).size
      end
      filesizes[style] = filesize
    end
    self.update_column(:filesize_metadata, filesizes)
  end
  ########################
end

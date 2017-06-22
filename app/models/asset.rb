class Asset < ActiveRecord::Base
  serialize :filesize_metadata, Hash

  has_attached_file :attachment, {
    styles: { 
      :thumb => {geometry: '125x100>'},
      :optimized_compress_0 => {geometry: '100%', paperclip_optimizer: {jpegrecompress: {allow_lossy: true, quality: 0}}},
      :optimized_compress_1 => {geometry: '100%', paperclip_optimizer: {jpegrecompress: {allow_lossy: true, quality: 1}}},
      :optimized_compress_2 => {geometry: '100%', paperclip_optimizer: {jpegrecompress: {allow_lossy: true, quality: 2}}},
      :optimized_compress_3 => {geometry: '100%', paperclip_optimizer: {jpegrecompress: {allow_lossy: true, quality: 3}}},
      :optimized_compress_4 => {geometry: '100%', paperclip_optimizer: {jpegrecompress: {allow_lossy: true, quality: 4}}},
    },
    processors:  [:thumbnail, :paperclip_optimizer],
    paperclip_optimizer: {
      nice: 19,
      jpegoptim: { allow_lossy: true, strip: :all, max_quality: 75 },
      jpegtran: { progressive: true},
      optipng: { level: 2 },
      pngout: { strategy: 1}
    },
    # path: "#{'public/' if Rails.env.test?}asset/:id/:style/:basename.:extension",
    convert_options: { :all => '-auto-orient +profile "exif"' },
    s3_headers: { 'Cache-Control' => 'max-age=600'}
  }
    
  validates_attachment_content_type :attachment, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  
  
  before_save :determine_dimensions
  after_save :determine_style_file_sizes
  
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
end

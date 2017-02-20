class Asset < ActiveRecord::Base

  has_attached_file :attachment, {
      styles: { 
        :thumb => {geometry: '125x100>'},
        :optimized => {geometry: '100%'}
      },
      processors:  [:thumbnail, :paperclip_optimizer],
      paperclip_optimizer: {
        nice: 19,
        jpegoptim: { allow_lossy: true, strip: :all, max_quality: 50 },
        jpegrecompress: {allow_lossy: true, quality: 2},
        jpegtran: {progressive: true},
        optipng: { level: 2 },
        pngout: { strategy: 1}
      },
      # path: "#{'public/' if Rails.env.test?}asset/:id/:style/:basename.:extension",
      convert_options: { :all => '-auto-orient +profile "exif"' },
      s3_headers: { 'Cache-Control' => 'max-age=31536000'}
    }
    
    validates_attachment_content_type :attachment, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
    
    
    before_save :determine_dimensions
    
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
end

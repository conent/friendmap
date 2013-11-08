module Paperclip
  class MarkerCreator < Processor
    
    def initialize file, options = {}, attachment = nil
      @file           = file
      @options        = options
      @instance       = attachment.instance
      @whiny          = options[:whiny].nil? ? true : options[:whiny]
    end

    def make  
      tmp1 = Tempfile.new(["first_image_r", ".png"].compact.join("."))
      tmp2 = Tempfile.new(["second_image_r", ".png"].compact.join("."))
      @file.rewind # move pointer back to start of file in case handled by other processors
      first_image = MiniMagick::Image.open "https://s3-us-west-2.amazonaws.com/friendmap/app/public/listimages/original/mapmarker.png"
      first_image.resize "36x36^"
      first_image.write tmp1.path
      second_image = MiniMagick::Image.open "https://s3-us-west-2.amazonaws.com/friendmap/app/public/listimages/navbar/user_1.png" #@file.path if resized
      result = tmp1.composite(second_image) do |c|
        c.compose "Over" # OverCompositeOp
        c.geometry "+2+2" # copy second_image onto first_image from (2, 2)
      end
      result.write @file.path
      
      # tmp = Tempfile.new([@basename, @current_format].compact.join("."))
      # tmp << file_content
      # tmp.flush 
      # @file = tmp
              
                 
        @file
      
    end
  end
end
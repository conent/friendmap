module Paperclip
  class MarkerCreator < Processor
    
    def initialize file, options = {}, attachment = nil
      @file           = file
      @options        = options
      @instance       = attachment.instance
      @whiny          = options[:whiny].nil? ? true : options[:whiny]
    end

    def make  
      @file.rewind # move pointer back to start of file in case handled by other processors
      first_image = MiniMagick::Image.open "https://s3-us-west-2.amazonaws.com/friendmap/app/public/listimages/original/mapmarker_s.png"
      second_image = MiniMagick::Image.open "https://s3-us-west-2.amazonaws.com/friendmap/app/public/listimages/navbar/user_1.png" #@file.path if resized
      result = first_image.composite(second_image) do |c|
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
module Paperclip
  class MarkerCreator < Processor
    
    def initialize file, options = {}, attachment = nil
      @file           = file
      @options        = options
      @instance       = attachment.instance
      @whiny          = options[:whiny].nil? ? true : options[:whiny]
    end

    def make


      first_image = MiniMagick::Image.open "https://s3-us-west-2.amazonaws.com/friendmap/app/public/listimages/original/mapmarker.png"
      second_image = MiniMagick::Image.open @file.path
      result = first_image.composite(second_image) do |c|
        c.compose "Over" # OverCompositeOp
        c.geometry "+20+20" # copy second_image onto first_image from (20, 20)
      end
      result.write "output.jpg"
      
        
          @file.rewind # move pointer back to start of file in case handled by other processors
          first_image = MiniMagick::Image.open "https://s3-us-west-2.amazonaws.com/friendmap/app/public/listimages/original/mapmarker.png"
          second_image = MiniMagick::Image.open @file.path
          result = first_image.composite(second_image) do |c|
            c.compose "Over" # OverCompositeOp
            c.geometry "+20+20" # copy second_image onto first_image from (20, 20)
          end
          result.write @file.path
        
          tmp = Tempfile.new([@basename, @current_format].compact.join("."))
          tmp << file_content
          tmp.flush 
         # @file = tmp
              
                 
        @file
      
    end
  end
end
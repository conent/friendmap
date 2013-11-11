module Paperclip
  class MarkerCreator < Processor
    
    def initialize file, options = {}, attachment = nil
      super
      @file           = file
      @options        = options
      @instance       = attachment.instance
      @whiny          = options[:whiny].nil? ? true : options[:whiny]
      @format         = File.extname(@file.path)
      @basename       = File.basename(@file.path, @format)
    end

    def make  
      # @file.rewind # move pointer back to start of file in case handled by other processors
      # first_image = MiniMagick::Image.open "https://s3-us-west-2.amazonaws.com/friendmap/app/public/listimages/original/mapmarkersmall.png"
      # second_image = MiniMagick::Image.open @file.path #@file.path if resized
      # second_image.resize "25x25"
      # result = first_image.composite(second_image, "png") do |c|
      #   #c.compose "Over" # OverCompositeOp
      #   c.geometry "+1+1" # copy second_image onto first_image from (2, 2)
      # end
      # result.write @file.path
      
      # # tmp = Tempfile.new([@basename, @current_format].compact.join("."))
      # # tmp << file_content
      # # tmp.flush 
      # # @file = tmp
              
                 
      #   @file

      src = @file
      dst = Tempfile.new([@basename, @format])
      dst.binmode
 
      begin
        parameters = []
         
        parameters << ':source'
        parameters << ':mask'
        parameters << '-alpha'
        parameters << 'on'
        parameters << '-compose'
        parameters << 'CopyOpacity'
        parameters << '-composite'
        parameters << ':dest'
 
        parameters = parameters.flatten.compact.join(" ").strip.squeeze(" ")
 
        mask_path = File.expand_path('https://s3-us-west-2.amazonaws.com/friendmap/app/public/listimages/original/mapmarkersmall.png')
        success = Paperclip.run("convert", parameters, :source => "#{File.expand_path(src.path)}[0]", :mask => "#{mask_path}[0]", :dest => File.expand_path(dst.path))
       
 
 
       rescue PaperclipCommandLineError => e
         raise PaperclipError, "There was an error during the mask for #{@basename}" if @whiny
       end
 
       dst
      
    end
  end
end
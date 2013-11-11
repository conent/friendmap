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

      src = @file
      dst = Tempfile.new([@basename, @format])
      dst.binmode
 
      begin
        parameters = []
         
         parameters << ':background'
         parameters << ':source'
         parameters << '-geometry 24x24+3+3'
         parameters << '-composite'
         parameters << ':dest'

        parameters = parameters.flatten.compact.join(" ").strip.squeeze(" ")
        success = Paperclip.run("convert", parameters, :source => "#{File.expand_path(src.path)}[0]", :background => "https://s3-us-west-2.amazonaws.com/friendmap/app/public/listimages/original/mapmarkersmall.png[0]", :dest => File.expand_path(dst.path))
      rescue PaperclipCommandLineError => e
        raise PaperclipError, "There was an error during the marker creation for #{@basename}" if @whiny
      end
 
       dst  
    end
  end
end
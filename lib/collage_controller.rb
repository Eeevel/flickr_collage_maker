require_relative 'helpers/image_sources/flickr'
require_relative 'helpers/image_handler'
require_relative 'helpers/collage_maker'
require_relative 'helpers/inputs/terminal'
require_relative 'helpers/inputs/web'

# ioc container: self implemented, dry-container.
class CollageController
  AVAILABLE_OPTIONS_INPUT = {
    terminal: Inputs::Terminal,
    web: Inputs::Web
  }.freeze

  AVAILABLE_IMAGE_SOURCES = {
    flickr: ImageSources::Flickr
  }.freeze

  def initialize(input:, images_source:)
    @input = input
    @images_source = images_source
  end

  def call
    # download photos
    # think about threads here. Check how it works in Ruby.
    photos = ImageHandler.download(urls, options[:quantity])

    collage = collage_builder.build

    # collage save
    ImageHandler.save(collage, options[:file_name])

    # delete temp images
    ImageHandler.clean(photos)
  end

  private

  def collage_builder
    CollageMaker.new(photos, options[:size])
  end

  def options
    @options ||= AVAILABLE_OPTIONS_INPUT.fetch(@input, :terminal).options
  end

  def urls
    @urls ||= begin
      url_soruce = AVAILABLE_IMAGE_SOURCES.fetch(@images_source, :flickr).new(options[:tag], options[:quantity])
      urls = url_soruce.urls
    end
  end
end

CollageController.new(input: :terminal, image_source: :flickr).call

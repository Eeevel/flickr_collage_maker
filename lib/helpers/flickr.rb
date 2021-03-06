require 'flickraw'
require 'logger'

class Flickr
  attr_reader :flickr, :logger

  def initialize
    FlickRaw.api_key = ENV['FLICKR_API_KEY']
    FlickRaw.shared_secret = ENV['FLICKR_SHARED_SECRET']
    @flickr = FlickRaw::Flickr.new
    @logger = Logger.new(STDOUT)
  end

  def urls(search_text, quanity)
    photos = find_photos(search_text, quanity)
    photos.map! { |photo| flickr.photos.getInfo(photo_id: photo.id, secret: photo.secret) }
          .map! { |img_info| FlickRaw.url_c(img_info) }
  end

  private

  def find_photos(search_text, quanity)
    list = flickr.photos.search(tags: search_text)
    photos = []
    quanity.times do
      photos << list[rand(list.size)]
    end
    logger.info('Photos was found')
    photos
  end
end

require 'flickraw'

module ImageSources
  class Flickr < Base
    def urls
      photos = find_photos(tag, quanity)
      photos.map! { |photo| flickr.photos.getInfo(photo_id: photo.id, secret: photo.secret) }
            .map! { |img_info| FlickRaw.url_c(img_info) }
    end

    private

    def flickr
      @flickr ||= begin
        FlickRaw.api_key = ENV['FLICKR_API_KEY']
        FlickRaw.shared_secret = ENV['FLICKR_SHARED_SECRET']
        FlickRaw::Flickr.new
      end
    end

    def find_photos
      list = flickr.photos.search(tags: tag)
      photos = []
      quanity.times do
        photos << list[rand(list.size)]
      end
      photos
    end
  end
end

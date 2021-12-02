require_relative 'helpers/flickr'
require_relative 'helpers/image_handler'
require_relative 'helpers/collage_maker'
require_relative 'helpers/options_handler'

options = OptionsHandler.options(ARGV)

# init
flickr = Flickr.new

# get urls
urls = flickr.urls(options[:tag], options[:quanity])

# download photos
photos = ImageHandler.download(urls, options[:quanity])

# make image_list
image_list = CollageMaker.image_list(photos)

# make collage
collage = CollageMaker.collage(image_list)

# collage save
ImageHandler.save(collage)

# delete temp images
ImageHandler.clean(photos)

puts 'Collage was made'

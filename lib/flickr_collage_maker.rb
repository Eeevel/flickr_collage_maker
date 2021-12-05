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
collage = CollageMaker.collage(image_list, options[:size])

# collage save
ImageHandler.save(collage, options[:file_name])

# delete temp images
ImageHandler.clean(photos)

puts 'Collage was made'
puts "You can find you collage at the path ./out/#{options[:file_name]}"
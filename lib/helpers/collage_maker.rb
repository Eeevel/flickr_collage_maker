require 'rmagick'

class CollageMaker
  def self.image_list(images)
    image_list = Magick::ImageList.new
    images.each do |image|
      image_list << Magick::Image.read(image).first
    end
    image_list
  end

  def self.collage(image_list, size_name)
    montage = image_list.montage do |image|
      image.background_color = '#ffffff'
      image.geometry = "#{size(size_name)}x#{size(size_name)}+5+5"
      image.shadow = true
    end
    montage.flatten_images
  end

  private_class_method def self.size(size_name)
    sizes = {
      thumbnail: 100,
      small: 250,
      medium: 500,
      large: 1000
    }
    sizes[size_name]
  end
end

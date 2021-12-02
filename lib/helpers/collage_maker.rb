require 'rmagick'

class CollageMaker
  def self.image_list(images)
    image_list = Magick::ImageList.new
    images.each do |image|
      image_list << Magick::Image.read(image).first
    end
    image_list
  end

  def self.collage(image_list)
    montage = image_list.montage do |image|
      image.background_color = '#ffffff'
      image.geometry = '500x500+5+5'
      image.shadow = true
    end

    montage.flatten_images
  end
end

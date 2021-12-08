require 'rmagick'

class CollageMaker
  SIZES = {
    thumbnail: 100,
    small: 250,
    medium: 500,
    large: 1000
  }.freeze

  def initialize(images, size_name)
    @images = images
    @size_name = size_name
  end

  def collage
    montage = image_list.montage do |image|
      image.background_color = '#ffffff'
      image.geometry = "#{size}x#{size}+5+5"
      image.shadow = true
    end
    montage.flatten_images
  end

  private

  attr_reader :images, :size_name

  def image_list
    image_list = Magick::ImageList.new
    images.each do |image|
      image_list << Magick::Image.read(image).first
    end
    image_list
  end

  def size
    @size ||= SIZES[size_name]
  end
end

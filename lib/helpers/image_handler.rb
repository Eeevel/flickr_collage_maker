require 'open-uri'

class ImageHandler
  def self.download(urls, quanity)
    images = []
    quanity.times do |i|
      images << "./tmp/temp#{i}.jpg"
      File.open(images[i], 'wb') do |f|
        f << open(urls[i]).read
      end
    end
    images
  end

  def self.clean(images)
    images.each do |image|
      File.delete(image) if File.exist?(image)
    end
  end

  def self.save(collage, file_name)
    collage.write("./out/#{file_name}")
  end
end

require 'rubygems'
require 'exifr'

class Exif

  def self.new(path)
    exif = EXIFR::JPEG.new(path)
    return {taken_at: exif.date_time, latitude: exif.gps_latitude, longitude: exif.gps_longitude}
  end

end
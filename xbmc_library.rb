require 'rubygems'
require 'active_record'
require 'active_support'

ActiveRecord::Base.establish_connection( 
  :adapter => "sqlite3", 
  :database => "/Volumes/xbmc/UserData/Database/MyVideos34.db" 
) 


class Genre < ActiveRecord::Base 
  set_table_name 'genre'
  set_primary_key 'idGenre'
  has_many :genre_link_movies, :foreign_key => "idGenre"
  has_many :movies, :through => :genre_link_movies
end

class GenreLinkMovie < ActiveRecord::Base
  set_table_name 'genrelinkmovie'
  belongs_to :movie, :foreign_key => "idMovie"
  belongs_to :genre, :foreign_key => "idGenre"
end


class Movie < ActiveRecord::Base 

  set_table_name 'movie'
  set_primary_key 'idMovie'
  belongs_to :file, :class_name => "MediaFile", :foreign_key => "idFile"

  def title
    self.c00
  end

  def description
    self.c01
  end
  
  def tagline
    self.c02
  end
  
  def imdb_score
    self.c05
  end

  def director
    self.c06
  end

  def year
    self.c07
  end
  
  def thumbs
    Hash.from_xml(self.c08)['thumbs']['thumb']
  end

  def imdb_id
    self.c09
  end

  def length
    self.c11
  end

  def rating
    self.c12
  end

  def genres
    self.c14
  end

  def path
    self.file.path.path
  end
  
  def filename
    self.file.filename
  end

  def full_path
    self.path + self.filename
  end


end

class MediaFile < ActiveRecord::Base
  set_table_name 'files'
  set_primary_key 'idFile'
  belongs_to :path, :class_name => "Path", :foreign_key => "idPath"
  
  def filename
    self.strFilename
  end
end

class Path < ActiveRecord::Base 
  set_table_name 'path'
  set_primary_key 'idPath'
  
  def path
    self.strPath
  end
end




class Series < ActiveRecord::Base 
  set_table_name 'tvshow'
  set_primary_key 'idShow'

  has_many :tvshow_link_episodes, :foreign_key => "idShow"
  has_many :episodes, :through => :tvshow_link_episodes


  def title
    self.c00
  end

  def description
    self.c01
  end

  def thumbs
    Hash.from_xml(self.c06)['thumbs']['thumb']
  end

end

class TvshowLinkEpisode < ActiveRecord::Base
  set_table_name 'tvshowlinkepisode'
  belongs_to :series, :foreign_key => "idShow"
  belongs_to :episode, :foreign_key => "idEpisode"
end


class Episode < ActiveRecord::Base 
  set_table_name 'episode'
  set_primary_key 'idEpisode'
  belongs_to :file, :class_name => "MediaFile", :foreign_key => "idFile"

  def title
    self.c00
  end

  def description
    self.c01
  end

  def date_aired
    self.c05
  end

  def thumb
    Hash.from_xml(self.c06)['thumb']
  end

  def season_number
    self.c12
  end

  def episode_number
    self.c13
  end

  def path
    self.file.path.path
  end
  
  def filename
    self.file.filename
  end

  def full_path
    self.path + self.filename
  end
  
end




Series.find(:all).first.episodes.each do |episode|
  puts episode.thumb
end

# puts Movie.find(:all).first.full_path




# Genre.find(:all).each do |genre|
#   puts genre.strGenre
#   genre.movies.each do |movie|
#     puts movie.thumbs
#   end
#   puts
#   puts
#   puts
# end


# movie = Movie.find(1);
# puts movie.thumbs.first

# 
# MovieFile.find(:all).each do |movie|
#   puts "#{movie.strFilename}: #{movie.path.strPath}"
# end

 
# ActiveRecord::Base.logger = Logger.new(STDOUT) 
# Order.find(:all).each do |o| 
# puts "Processing order number #{o.id}" 
# ‘./sendorder -c #{o.customer_id} \ 
# -p #{o.product_id} \ 
# -q #{o.quantity}‘ 
# end 

require('pg')
require_relative('./artists')
require_relative('./db/sql_runner')

class Albums

  attr_accessor :title, :genre, :artists_id
  attr_reader :id

    def initialize ( options )
      @id = options['id'] unless options['id'].nil?
      @title = options['title']
      @genre = options['genre']
      @artists_id = options['artists_id'].to_i
    end

    def save()
     db = PG.connect ({ dbname: 'music_collection', host: 'localhost'})
     sql = 
       "
       INSERT INTO albums
       (title, genre, artists_id)
       VALUES
       ('#{@title}', '#{@genre}', #{@artists_id})
       RETURNING *;
       "
     @id = db.exec(sql)[0]['id'].to_i
     db.close()
    end

    def self.all()
      sql = 'SELECT * FROM albums;'
      albums = SqlRunner.run ( sql )
      return albums.map { |album| Albums.new( album ) }
    end


    def self.delete_all
      db = PG.connect ({ dbname: 'music_collection', host: 'localhost'})
      sql = "DELETE FROM albums;"
      db.exec(sql)
      db.close()
    end

    def delete()
      db = PG.connect ({ dbname: 'music_collection', host: 'localhost'})
      sql = "DELETE FROM albums WHERE id = #{@id};"
      db.exec(sql)
      db.close()
    end

    def update()
      db = PG.connect ({ dbname: 'music_collection', host: 'localhost'})
      sql = 
      "UPDATE albums SET (title, genre, artists_id) 
      = ('#{@title}', '#{@genre}', #{@artists_id})
        WHERE id = '#{@id}';
      "
      db.exec(sql)
      db.close()
    end

    def artist()
      sql = "SELECT * FROM artists WHERE id = #{ @artists_id };"
      artists = SqlRunner.run( sql )
      return artists.map { |artist| Artists.new( artist ) }
    end 
  

end
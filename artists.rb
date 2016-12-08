require( 'pg' )
require_relative('./db/sql_runner')
require_relative('albums')

class Artists

  attr_reader :id
  attr_accessor :name

  
    def initialize ( options )
      @id = options['id'] unless options['id'].nil?
      @name = options['name']
    end

    def save()
     db = PG.connect ({ dbname: 'music_collection', host: 'localhost'})
     sql = 
       "
       INSERT INTO artists
       (name)
       VALUES
       ('#{@name}')
       RETURNING *;
       "
     @id = db.exec(sql)[0]['id'].to_i
     db.close()
    end

    def self.all()
      sql = 'SELECT * FROM artists;'
      artists = SqlRunner.run ( sql )
      return artists.map { |artist| Artists.new( artist ) }
    end

    def album()
      sql = "SELECT * FROM albums WHERE artists_id = #{ @id };"
      albums = SqlRunner.run( sql )
      return albums.map { |album| Albums.new( album ) }
    end 

    def delete()
      db = PG.connect ({ dbname: 'music_collection', host: 'localhost'})
      sql = "DELETE FROM artists WHERE id = #{@id};"
      db.exec(sql)
      db.close()
    end

    def update()
      db = PG.connect ({ dbname: 'music_collection', host: 'localhost'})
      sql = 
      "UPDATE artists SET (name 
      = ('#{@name}')
        WHERE id = '#{@id}';
      "
      db.exec(sql)
      db.close()
    end

    def self.delete_all
      db = PG.connect ({ dbname: 'music_collection', host: 'localhost'})
      sql = "DELETE FROM artists;"
      db.exec(sql)
      db.close()
    end


end
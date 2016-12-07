require('pry')
require_relative('artists')
require_relative('albums')

artists1 = Artists.new( { 'name' => 'Eminem' } )
artists2 = Artists.new( { 'name' => 'Jay-Z' } )

artists1.save()
artists2.save()

album1 = Albums.new( {
  'title' => 'The Marshall Mathers LP',
  'genre' => 'Rap',
  'artists_id' => artists1.id
} )

album2 = Albums.new( {
  'title' => 'The Black Album',
  'genre' => 'Rap',
  'artists_id' => artists2.id
  })

album1.save()
album2.save()



binding.pry
nil

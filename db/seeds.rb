# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'pg'
require 'csv'
require 'pry'

def db_connection
  begin
    connection = PG.connect(dbname: "collectibles")
    yield(connection)
  ensure
    connection.close
  end
end


db_connection do |conn|
  dad_id = conn.exec(
      "SELECT id FROM users WHERE name= 'Bruce Blaisdell"
  )
  CSV.foreach('dad_db.csv') do |row|
    conn.exec_params(
        'INSERT INTO collectibles (user_id, year, media, name_of_item,
              story_title, vol_num, issue_num, publisher, cover_artist, artist,
              artist2, artist3, condition, est_value, notes )
        VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15)',
        [dad_id, row[7], row[2], row[3], row[5], row[9], row[11],
         row[1], row[13], row[15], row[17], row[19], row[21], row[23], row[25]
        ]
    )
  end
end

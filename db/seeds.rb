require "json"
require "open-uri"

puts "Cleaning up database..."
Movie.destroy_all
puts "Database cleaned"

url = 'http://tmdb.lewagon.com/movie/top_rated'
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)

puts "#{movies['results'].first}"

movies['results'].each do |movie|
  puts "Creating #{movie['original_title']}"
  base_poster_url = 'https://image.tmdb.org/t/p/original'
  Movie.create(
    title: movie['original_title'],
    overview: movie['overview'],
    poster_url: "#{base_poster_url}#{movie['poster_path']}",
    rating: movie['vote_average']
  )
end

List.create(name: "Favoris", movie_id: "1", bookmark_id: "2")
List.create(name: "Recommendations", movie_id: "1", bookmark_id: "2")

Bookmark.create(comment: "Ok", movie_id: "1", list_id: "2")
Bookmark.create(comment: "OK", movie_id: "4", list_id: "1")

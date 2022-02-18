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

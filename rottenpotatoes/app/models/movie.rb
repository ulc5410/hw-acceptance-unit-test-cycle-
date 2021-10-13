class Movie < ActiveRecord::Base
    def self.all_ratings
        %w(G PG PG-13 NC-17 R)
    end
    
    def self.get_similar_movies(movie_id)
        director = Movie.where(id: movie_id).pluck(:director)[0]
        if director.nil? || director.blank?
            return nil
        end
       
        # Return the correct matches for movies by the same director
        Movie.where(director: director)
    end
    
    def self.with_ratings(ratings_list, to_sort)
        ratings_list.nil? ? self.all.order(to_sort) : self.where(rating: ratings_list).order(to_sort)
    end
    
    def self.movie_with_id(movie_id)
        Movie.where('id': movie_id).pluck(:title)[0]
    end
end
class Film
  include Api::Resource

  attr_accessor :_id

  attr_accessor :score

  attr_accessor :title

  attr_accessor :genre

  attr_accessor :rating

  attr_accessor :summary

  attr_accessor :poster_url

  attr_accessor :url

  attr_accessor :director

  attr_accessor :year

  attr_accessor :stars

  attr_accessor :keywords

  attr_accessor :id

  # attr_accessor :user_id

  def attributes
    {score: nil,
     title: nil,
     genre: nil,
     rating: nil,
     summary: nil,
     poster_url: nil,
     url: nil,
     director: nil,
     year: nil,
     stars: nil,
     keywords: nil }
     # user_id: nil
  end

  class << self
    def all
      execute(:get, '/api/films').map { |f| Film.new(f) }
    end

    def find(id)
      Film.new(execute(:get, "/api/films/#{id}"))
    end
  end
end

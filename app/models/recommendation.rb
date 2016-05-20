class Recommendation
  include Api::Resource

  attr_accessor :_id

  attr_accessor :winning_title

  attr_accessor :genres_pref

  attr_accessor :rating_pref

  attr_accessor :director_pref

  attr_accessor :decade_pref

  attr_accessor :keywords_pref

  attr_accessor :stars_pref

  attr_accessor :id

  # attr_accessor :user_id

  def attributes
    { winning_title: nil,
      genres_pref:   nil,
      director_pref: nil,
      decade_pref:   nil,
      rating_pref:   nil,
      keywords_pref: nil,
      stars_pref:    nil }
  end

  class << self
    def all
      execute(:get, '/api/recommendations').map { |f| Recommendation.new(f) }
    end

    def find(id)
      Recommendation.new(execute(:get, "/api/recommendations/#{id}"))
    end
  end

  def save
    response = self.class.execute(:post, '/api/recommendations', recommendation: self.serializable_hash)
    self.id = response[:id]
    true
  rescue RestClient::UnprocessableEntity => exception
    add_errors_to_resource(exception, self)
    false
  end

  def persisted?
    id.present?
  end

  def destroy
    self.class.execute(:delete, "/api/recommendations/#{id}")
  end
end

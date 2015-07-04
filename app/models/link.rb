class Link < ActiveRecord::Base

  acts_as_votable
  belongs_to :user
  has_many :comments
  @linkOrginize = Link.order("created_at DESC")
  has_reputation :votes, source: :user, aggregated_by: :sum

  # method for ordering link posts by number of upvotes (popular)
  def self.popular
    reorder('votes desc').find_with_reputation(:votes, :all)
  end

end

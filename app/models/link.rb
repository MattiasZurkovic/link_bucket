class Link < ActiveRecord::Base

  acts_as_votable
  belongs_to :user

  @linkOrginize = Link.order("created_at DESC")

end

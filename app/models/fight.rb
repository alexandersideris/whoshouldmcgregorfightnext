class Fight < ActiveRecord::Base
  acts_as_votable
  default_scope { order(upvotes: :desc) }
end

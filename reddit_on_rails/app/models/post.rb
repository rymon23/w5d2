# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string           not null
#  content    :text             not null
#  user_id    :integer          not null
#  sub_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  validates :title, presence: true
  validates :url, presence: true

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :post_subs
    primary_key: :id,
    foreign_key: :post_id,
    class_name: :PostSub
  
  has_many :subs,
    through: :post_subs,
    source: :sub
end

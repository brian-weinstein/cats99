# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  name        :text             not null
#  birth_date  :date             not null
#  color       :text             not null
#  sex         :text             not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#

require 'action_view'

class Cat < ApplicationRecord
    include ActionView::Helpers::DateHelper
    COLORS = %w(black white orange brown).freeze
    
    validates :name,:birth_date,:color,:sex,:description, presence: true
    validates :color, inclusion: COLORS
    validates :sex, inclusion: %w(M F)

    has_many :cat_rental_requests,
        dependent: :destroy
    belongs_to :owner,
        class_name: :User,
        foreign_key: :user_id
        
   

    def age
        time_ago_in_words(:birth_date)
    end

end

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
#

require "test_helper"

class CatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  end_date   :date             not null
#  start_date :date             not null
#  status     :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer          not null
#

require 'test_helper'

class CatRentalRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

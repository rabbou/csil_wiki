# == Schema Information
#
# Table name: pills
#
#  id          :integer          not null, primary key
#  description :string
#  name        :string
#  pill_time   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  show        :boolean

class Pill < ApplicationRecord
  belongs_to :user
end

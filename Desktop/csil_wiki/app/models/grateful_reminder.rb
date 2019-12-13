# == Schema Information
#
# Table name: grateful_reminders
#
#  id           :integer          not null, primary key
#  message_sent :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#

class GratefulReminder < ApplicationRecord
end

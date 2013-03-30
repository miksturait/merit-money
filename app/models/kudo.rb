class Kudo < ActiveRecord::Base
  belongs_to :receiver, class_name: "User"
  belongs_to :weekly_kudo

  delegate :giver, to: :weekly_kudo
  attr_accessible :comment, :value

  validates_presence_of :value, :receiver_id, :weekly_kudo_id
  validates_inclusion_of :value, in: 1..20

  class ReceiverIsDifferentThenGiverValidator < ActiveModel::Validator
    def validate(record)
      if record.weekly_kudo &&
          record.giver == record.receiver
        record.errors[:base] << "you are not allowed to give kudos yourself"
      end
    end
  end

  validates_with ReceiverIsDifferentThenGiverValidator

end

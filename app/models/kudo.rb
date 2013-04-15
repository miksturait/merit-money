class Kudo < ActiveRecord::Base
  belongs_to :receiver, class_name: "User"
  belongs_to :weekly_kudo, autosave: true

  delegate :giver, to: :weekly_kudo
  attr_accessible :comment, :value, :receiver_id

  validates_presence_of :value, :receiver_id, :weekly_kudo_id
  validates_inclusion_of :value, in: 1..20, message: "you are not allowed to go beyond kudos limit"
  validates_associated :weekly_kudo

  before_validation :substract_kudos_from_weekly_kudos, if: Proc.new { weekly_kudo }

  class ReceiverIsDifferentThenGiverValidator < ActiveModel::Validator
    def validate(record)
      if record.weekly_kudo &&
          record.giver == record.receiver
        record.errors[:base] << "you are not allowed to give kudos yourself"
      end
    end
  end

  validates_with ReceiverIsDifferentThenGiverValidator


  def ember_kudo_info
    {
        id: id,
        comment: comment,
        receiver_id: receiver_id
    }
  end

  private

  def substract_kudos_from_weekly_kudos
    weekly_kudo.kudos_left -= value
  end

end

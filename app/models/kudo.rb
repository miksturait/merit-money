class Kudo < ActiveRecord::Base
  belongs_to :receiver, class_name: "User"
  belongs_to :weekly_kudo, autosave: true

  delegate :giver, to: :weekly_kudo
  attr_accessible :comment, :value, :receiver_id

  validates_presence_of :value, :receiver_id, :weekly_kudo_id
  validates_inclusion_of :value, in: 1..20, message: "you are not allowed to go beyond kudos limit"
  validates_associated :weekly_kudo

  before_validation :substract_kudos_from_weekly_kudos, if: Proc.new { weekly_kudo }

  scope :with_comment, where("kudos.comment is not null and kudos.comment != ''")
  scope :latest_first, order("kudos.id DESC")
  scope :without_kudos_from_current_week, -> { joins(:weekly_kudo).
      where(["weekly_kudos.week_id != ?", Week.current.id]) }

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
        receiver_id: receiver_id,
        value: value
    }
  end

  def ember_comment_info
    {
        comment: comment,
        value: value
    }
  end

  private

  def substract_kudos_from_weekly_kudos
    weekly_kudo.kudos_left -= value
  end

end

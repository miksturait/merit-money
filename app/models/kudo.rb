class Kudo < ActiveRecord::Base
  belongs_to :giver, class_name: "User"
  belongs_to :receiver, class_name: "User"
  attr_accessible :comment, :value

  validates_presence_of :value, :giver_id, :receiver_id
  validates_inclusion_of :value, in: 1..20

  class ValuesNotEqualValidator < ActiveModel::Validator
    def validate(record)
      if options[:fields].any? && options[:fields].size >= 2
        field_values = options[:fields].collect { |f| record.send(f) }
        unless field_values.size == field_values.uniq.size
          record.errors[:base] <<
              (options[:msg].blank? ? "fields: #{options[:fields].join(", ")} - should not be equal" :
                  options[:msg])
        end
      else
        raise "#{self.class.name} require at least two fields as options [e.g. fields: [:giver_id, :receiver_id]"
      end
    end
  end

  validates_with ValuesNotEqualValidator, fields: [:giver_id, :receiver_id]
end

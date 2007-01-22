class Question < ActiveRecord::Base
  belongs_to :page
  acts_as_list :scope => :page_id
  has_many :answers
  
  def questionnaire
    page.questionnaire
  end
end

class Label < Question
  validates_presence_of :caption
end

class Divider < Question
end

class Heading < Question
  validates_presence_of :caption
end

class Field < Question
  has_one :special_field_association, :foreign_key => :question_id
  
  def purpose
    if special_field_association.nil?
      nil
    else
      special_field_association.purpose
    end
  end
end

class FreeformField < Field
end

class TextField < FreeformField
end

class BigTextField < FreeformField
end

class CheckBoxField < Field
end

class RangeField < Field
  validates_presence_of :min, :max, :step
  validates_numericality_of :min, :max, :step, :integer => true
  validates_exclusion_of :step, :in => [0]
  
  validate :range_boundaries
  def range_boundaries
    if step > 0
      if min > max
        errors.add('min', 'cannot be greater than max if step is positive')
      end
    else
      if min < max
        errors.add('min', 'cannot be less than max if step is negative')
      end
    end
  end
end

class SelectorField < Field
  has_many :question_options, :dependent => :destroy, :foreign_key => 'question_id'
  
  def options_for_select
    return question_options.collect { |o| [ o.option, o.option ] }
  end
end

class DropDownField < SelectorField
end

class RadioField < SelectorField
end

class MultiSelectField < SelectorField
end
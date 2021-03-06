class Questions::RangeField < Questions::Field
  validates_presence_of :min, :max, :step
  validates_numericality_of :min, :max, :step, :integer => true
  validates_exclusion_of :step, :in => [0]
  validate :ensure_range_boundaries
  
  def self.friendly_name
    "Numeric range"
  end
  
  def is_numeric?
    true
  end
  
  def xmlcontent(xml)
    super
    xml.min(self.min)
    xml.max(self.max)
    xml.step(self.step)
  end
  
  private
  def ensure_range_boundaries
    if step > 0
      if min > max
        if min_changed?
          errors.add('min', "must be at most #{max}")
        else
          errors.add('max', "must be at least #{min}")
        end
      end
    else
      if min < max
        if min_changed?
          errors.add('min', "must be at least #{max} (because step is negative)")
        else
          errors.add('max', "must be at most #{min} (because step is negative)")
        end
      end
    end
  end
end
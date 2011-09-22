class WeeklyActivityReport

  def initialize begin_date,end_date
    @begin_date = begin_date
    @end_date = end_date
  end

  def week
    @begin_date.to_s + " - " + @end_date.to_s
  end

  def generate_data_structure
    
  end

end

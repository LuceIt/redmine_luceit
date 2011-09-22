class Date
  def is_weekend?
    wday == 0 or wday == 6
  end
end

class WorkCalendar

  def self.monday_of_the_week(reference_date)
    reference_date.beginning_of_week
  end

  def self.friday_of_the_week(reference_date)
    monday = monday_of_the_week(reference_date)
    monday.advance(:days => 4)
  end

  def self.laboral_days_between(begin_date, end_date)
    self.weekdays_between(begin_date, end_date)
  end

  def self.monday_of_the_current_week
    monday_of_the_week(Date.today)
  end

  def self.friday_of_the_current_week
    friday_of_the_week(Date.today)
  end

  private
    def self.weekdays_between(begin_date, end_date)
      weekdays = 0
      begin_date.upto(end_date) do |day|
        weekdays += 1 unless day.is_weekend?
      end
      weekdays
    end
end

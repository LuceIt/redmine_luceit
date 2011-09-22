class PersonalActivityReport
  attr_accessor :first_day_of_the_week, :last_day_of_the_week
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def from!(begin_date)
    @first_day_of_the_week = Date.parse(begin_date.to_s)
    self
  end

  def to!(end_date)
    @last_day_of_the_week = Date.parse(end_date.to_s)
    self
  end

  def calculate_begin_and_end_of_the_week
    if @first_day_of_the_week and @last_day_of_the_week
      calculate_monday_and_friday_of_selected_period(@first_day_of_the_week, @last_day_of_the_week)
    elsif @first_day_of_the_week and not @last_day_of_the_week
      calculate_monday_and_friday_of_selected_period(@first_day_of_the_week, @first_day_of_the_week)
    end
  end

  def calculate_monday_and_friday_of_selected_period(begin_date,end_date)
    @begin = WorkCalendar.monday_of_the_week(begin_date)
    @end = WorkCalendar.friday_of_the_week(end_date)
  end

  def total_hours
    total = 0;
    user_time_records.each{|record| total += record.hours}   
    total
  end

  def expected_hours
    calculate_begin_and_end_of_the_week
    expected_weeks_between_begin_and_end = WorkCalendar.laboral_days_between(@begin, @end) / 5
    expected_hours = @user.hours_per_week * expected_weeks_between_begin_and_end
  end

  def dedication_percentage
    percentage = ( total_hours / expected_hours ) * 100
    percentage.floor
  end

  def hours_of_each_project
    hours = Hash.new(0)
    user_time_records.each do |record|
      project = record.project
      hours[project] = hours[project] + record.hours  
    end
    hours.delete_if{|key, value| value == 0}
  end

  def <=>(other)
    @user <=> other.user
  end

  private
  def user_time_records
    if not @begin and not @end
      calculate_begin_and_end_of_the_week
    end
    TimeEntry.find(:all, :conditions => time_conditions)
  end

  def time_conditions
    if(@begin and @end) 
      conditions = ['user_id = ? AND spent_on BETWEEN ? AND ?', @user.id, @begin, @end]
    elsif @begin
      conditions = ['user_id = ? AND spent_on >= ?', @user.id, @begin]
    elsif @end 
      conditions = ['user_id = ? AND spent_on <= ?', @user.id, @end]
    end
    conditions
  end
end

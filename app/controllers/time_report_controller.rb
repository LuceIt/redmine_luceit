
class TimeReportController < ApplicationController
  unloadable
  attr_accessor :begin_date, :end_date

  def index
    get_dates
    @user = User.current
    @personal_activity_report = PersonalActivityReport.new(@user).from!(@begin_date)
    @actual_week_monday = WorkCalendar.monday_of_the_current_week
    @actual_week_friday = WorkCalendar.friday_of_the_current_week
    @last_week_monday = @actual_week_monday.advance(:weeks => -1)
    @last_week_friday = WorkCalendar.friday_of_the_week(@last_week_monday)
    render :show 
  end

  def activity
    get_activity_report_dates
    @actual_week_monday = WorkCalendar.monday_of_the_current_week
    @actual_week_friday = WorkCalendar.friday_of_the_current_week
    @last_week_monday = @actual_week_monday.advance(:weeks => -1)
    @last_week_friday = WorkCalendar.friday_of_the_week(@last_week_monday)
    @activity_report = ActivityReport.new(@begin_date, @end_date)
  end

  def time_email_notification
    user_id_to_notify = params[:user_id]
    begin_date = params[:begin_date]
    end_date = params[:end_date]
    user_to_notify = User.find_by_id(user_id_to_notify)
    personal_activity_report = PersonalActivityReport.new(user_to_notify).from!(begin_date).to!(end_date)
    NotificationMailer.deliver_notification_hours_mail(personal_activity_report)
    render :partial=>'time_email_notification', :layout=> false 
  end

  def generate_weekly_activity_excel_report
    weekly_activity_report = WeeklyActivityReport.new(params[:begin_date],params[:end_date])
    ExcelReport.generate_activity_report(weekly_activity_report)
    render :partial=>'weekly_activity_excel_report', :layout => false
  end

  private 
  def get_dates
    @begin_date = WorkCalendar.monday_of_the_week(parsed_begin_date)
    @end_date = WorkCalendar.friday_of_the_week(parsed_begin_date)
  end

  def get_activity_report_dates
    @begin_date = WorkCalendar.monday_of_the_week(parsed_begin_date)
    @end_date = WorkCalendar.friday_of_the_week(parsed_end_date)
  end

  def parsed_begin_date
    begin_date = params[:begin_date] if params[:begin_date] != "" 
    if begin_date.nil?
      parsed_begin_date = WorkCalendar.monday_of_the_current_week
    else 
      parsed_begin_date = Date.parse(begin_date)
    end
    parsed_begin_date
  end

  def parsed_end_date
    end_date = params[:end_date] if params[:end_date] != "" 
    if end_date.nil?
      parsed_end_date = WorkCalendar.friday_of_the_current_week
    else 
      parsed_end_date = Date.parse(end_date)
    end
    parsed_end_date
  end
end

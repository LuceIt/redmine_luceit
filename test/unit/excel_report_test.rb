require File.expand_path('../../test_helper', __FILE__)

class ExcelReportTest < ActiveSupport::TestCase

  require 'excel_report'
  require 'work_calendar'

  def setup
    @monday_of_this_week = WorkCalendar.monday_of_the_week(Date.today)
    @friday_of_this_week = WorkCalendar.friday_of_the_week(Date.today)
    @activity_report = WeeklyActivityReport.new(@monday_of_this_week,
                                                @friday_of_this_week)
  end

  def test_generate_a_simple_excel_report_with_a_blank_sheet_from_an_activity_report
    excel_report = ExcelReport.generate_activity_report(@activity_report)
    report_name = 'Weekly activity report ' + 
      @monday_of_this_week.to_s + '-' + @friday_of_this_week.to_s
    assert_equal report_name, excel_report.worksheet(0).name
  end

  def test_generate_a_simple_excel_report_with_a_sheet_with_standart_columns
    excel_report = ExcelReport.generate_activity_report(@activity_report)
    activity_sheet = excel_report.worksheet(0)
    assert_equal 4, activity_sheet.column_count
  end
end

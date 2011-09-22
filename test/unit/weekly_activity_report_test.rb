require File.expand_path('../../test_helper', __FILE__)

class WeeklyActivityReportTest < ActiveSupport::TestCase

  require 'work_calendar'

  def setup
    @begin_date = WorkCalendar.monday_of_the_week(Date.today)
    @end_date = WorkCalendar.friday_of_the_week(Date.today)
    @weekly_activity_report = WeeklyActivityReport.new(@begin_date,@end_date)
  end

  def test_create_a_new_weekly_report_with_begin_and_end_date
    assert '2011-09-12 - 2011-09-16', @weekly_activity_report.week
  end

  def test_a_new_weekly_report
    @project = Project.generate
    @version = Version.generate
    @user_story = UserStory.generate
    @issue = Issue.generate(:user_story_id => @user_story.id)
    @user_story.issues << @issue
    @version.user_stories << @user_story
    @project.versions << @version
    assert false
    #    @weekly_activity_report.stubs(:get_report_data).returns(:projects_001)
    #    report_data_structure = @weekly_activity_report.generate_data_structure
    #    assert_equal 3, report_data_structure.size
    #    assert_equal 'eCookbook', report_data_structure[0]['project'].name
    #    assert_equal 'User Story One', report_data_structure[0]['hdu'].name
    #    assert_equal 155.25,  report_data_structure[0]['hdu'].total_assigned_hours
  end
end

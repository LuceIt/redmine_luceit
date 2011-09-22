require File.join(File.dirname(__FILE__), '..', 'test_helper')

class TimeReportControllerTest < ActionController::TestCase

  def setup
    @controller = TimeReportController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    Setting.default_language = 'en'
    User.current = nil
    @request.session[:user_id] = 1
  end

  def given_an_admin_when_click_on_generate_excel_report_then_should_generate_it 
    visit 'activity'
    click_button 'Generate Excel'
    assert_response :success
    assert_contain 'excel'
  end

end

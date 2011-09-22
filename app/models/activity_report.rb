class ActivityReport
  attr_reader :begin_date, :end_date, :personal_reports

  def initialize(begin_date, end_date)
    @begin_date, @end_date = begin_date, end_date
    @personal_reports = {}
    create_user_personal_activity_reports
  end

  private
    def create_user_personal_activity_reports
      users = User.find(:all, :conditions => "login <> ''", :order => "firstname ASC")
      users.each do |user|
        user_activity_report = PersonalActivityReport.new(user).from!(@begin_date).to!(@end_date)
        @personal_reports[user] = user_activity_report
      end
    end
end

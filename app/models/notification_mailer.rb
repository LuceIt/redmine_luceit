class NotificationMailer < ActionMailer::Base
  def notification_hours_mail(report)
    @report = report
    recipients @report.user.mail
    subject "Notificación de horas de proyecto"
    sent_on Time.now
    content_type "text/html"
    body(:personal_report => @report)
  end
end

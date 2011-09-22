class ExcelReport
  
  require 'spreadsheet'

  def self.generate_activity_report(activity_report)
    excel_report = Spreadsheet::Workbook.new
    sheet_report = excel_report.create_worksheet({:name => 'Weekly activity report ' + activity_report.week})
    return excel_report
  end
end

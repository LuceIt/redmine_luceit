require 'redmine'
require_dependency 'redmine_luceit/hooks/view_my_account_hook'

require 'dispatcher'
Dispatcher.to_prepare :redmine_luceit do

  require_dependency 'principal'
  require_dependency 'user'
  User.send(:include, RedmineLuceit::Patches::UserPatch)

end

unless Redmine::Plugin.registered_plugins.keys.include?(:redmine_luceit)
  Redmine::Plugin.register :redmine_luceit do
    name 'Redmine LuceIt Plugin'
    author 'Luce IT'
    description 'Redmine plugin for our internal agile methodology'
    version '0.0.1'
    url 'http://luceit.es'
    author_url 'http://luceit.es'

    Redmine::MenuManager.map :top_menu do |menu|
      menu.push :luceit_personal_activity,  { :controller => 'time_report', :action => 'index' },:caption => :my_time_report, :if => Proc.new { User.current.logged? }
      menu.push :luceit_activity, { :controller => 'time_report', :action => 'activity' },:caption => :time_report, :if => Proc.new { User.current.logged? && User.current.admin?}
    end

  end
end

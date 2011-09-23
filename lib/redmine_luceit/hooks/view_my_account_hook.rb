module RedmineLuceit
  module Hooks
    class Hooks < Redmine::Hook::ViewListener
      render_on :view_my_account, :partial => 'my_account/hours_per_week'
    end
  end
end

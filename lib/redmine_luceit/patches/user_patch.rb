module RedmineLuceit
  module Patches
    module UserPatch
      def self.included(base)
        base.extend(ClassMethods)

        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable
          safe_attributes 'hours_per_week'
        end
      end

      module ClassMethods
      end

      module InstanceMethods
      end
    end
  end
end

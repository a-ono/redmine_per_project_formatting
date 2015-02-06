module RedminePerProjectFormatting
  module ProjectPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        serialize :modules_for_formatting
        safe_attributes 'text_formatting', 'modules_for_formatting'
      end
    end

    module InstanceMethods
      def project_wide_formatting
        modules_for_formatting.to_a.reject(&:blank?).empty?
      end

      def module_options
        enabled_module_names.map {|name| [I18n.t("project_module_" + name), name]}
      end

      def text_formatting_for(module_name)
        text_formatting if project.project_wide_formatting ||
          project.modules_for_formatting.to_a.include?(module_name.to_s)
      end
    end
  end
end

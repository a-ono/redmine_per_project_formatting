require_dependency 'project'

module RedminePerProjectFormatting
  module ProjectPatch
    def self.included(base)
      base.class_eval do
        unloadable
        safe_attributes 'text_formatting'
      end
    end
  end

  Project.send(:include, ProjectPatch)
end

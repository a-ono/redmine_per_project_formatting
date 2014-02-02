require_dependency 'activities_controller'
require_dependency 'boards_controller'
require_dependency 'documents_controller'
require_dependency 'issues_controller'
require_dependency 'journals_controller'
require_dependency 'messages_controller'
require_dependency 'news_controller'
require_dependency 'previews_controller'
require_dependency 'projects_controller'
require_dependency 'wiki_controller'
require_dependency 'wikis_controller'
require_dependency 'welcome_controller'
require_dependency 'settings_controller'

module RedminePerProjectFormatting
  module ControllerPatch
    def self.included(base)
      base.class_eval do
        unloadable
        before_filter :set_current_text_formatting
      end
    end

    def set_current_text_formatting
      format = Setting.current_text_formatting = @project.try(:text_formatting)
      return if format.blank? || @project.project_wide_formatting

      mod = case controller = params[:controller]
        when "issues" then "issue_tracking"
        when "journals" then "issue_tracking"
        when "wikis" then "wiki"
        when "messages" then "boards"
        when "previews"
          case params[:action]
          when "issue" then "issue_tracking"
          when "news" then "news"
          end
        else controller
      end

      unless @project.modules_for_formatting.to_a.include?(mod)
        Setting.current_text_formatting = nil
      end
    end
  end

  [
    ActivitiesController,
    BoardsController,
    DocumentsController,
    IssuesController,
    JournalsController,
    MessagesController,
    NewsController,
    PreviewsController,
    ProjectsController,
    WikiController,
    WikisController,
    WelcomeController,
    SettingsController
  ].each do |c|
    c.send(:include, ControllerPatch)
  end
end

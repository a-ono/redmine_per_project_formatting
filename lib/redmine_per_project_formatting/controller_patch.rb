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

module RedminePerProjectFormatting
  module ControllerPatch
    def self.included(base)
      base.class_eval do
        unloadable
        before_filter :set_current_project_for_text_formatting
      end
    end

    def set_current_project_for_text_formatting
      Setting.current_project = @project if @project
    end
  end

  [
    BoardsController,
    DocumentsController,
    IssuesController,
    JournalsController,
    MessagesController,
    NewsController,
    PreviewsController,
    ProjectsController,
    WikiController,
    WikisController
  ].each do |c|
    c.send(:include, ControllerPatch)
  end
end

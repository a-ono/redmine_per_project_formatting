module RedminePerProjectFormatting
  module MailHandlerPatch
    def self.included(base)
      base.class_eval do
        unloadable
        alias_method_chain :target_project, :per_project
        alias_method_chain :receive_issue_reply, :per_project
        alias_method_chain :receive_message_reply, :per_project
      end
    end

    def target_project_with_per_project
      target_project_without_per_project.tap do |project|
        Setting.current_text_formatting =
          project.try(:text_formatting_for, :issue_tracking)
      end
    end

    def receive_issue_reply_with_per_project(issue_id, from_journal=nil)
      if p = Issue.where(:id => issue_id).first.try(:project)
        Setting.within_text_formatting(p.text_formatting_for(:issue_tracking)) do
          receive_issue_reply_without_per_project(issue_id, from_journal)
        end
      end
    end

    def receive_message_reply_with_per_project(message_id)
      if p = Message.where(:id => message_id).first.try(:project)
        Setting.within_text_formatting(p.text_formatting_for(:boards)) do
          receive_message_reply_without_per_project(message_id)
        end
      end
    end
  end

  MailHandler.send(:include, MailHandlerPatch)
end

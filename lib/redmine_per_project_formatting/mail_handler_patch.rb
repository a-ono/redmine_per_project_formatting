module RedminePerProjectFormatting
  module MailHandlerPatch
    def target_project
      super.tap do |project|
        Setting.current_text_formatting =
          project.try(:text_formatting_for, :issue_tracking)
      end
    end

    def receive_issue_reply(issue_id, from_journal=nil)
      if p = Issue.where(:id => issue_id).first.try(:project)
        Setting.within_text_formatting(p.text_formatting_for(:issue_tracking)) do
          super
        end
      end
    end

    def receive_message_reply(message_id)
      if p = Message.where(:id => message_id).first.try(:project)
        Setting.within_text_formatting(p.text_formatting_for(:boards)) do
          super
        end
      end
    end
  end
end

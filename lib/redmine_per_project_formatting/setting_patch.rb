module RedminePerProjectFormatting
  module SettingPatch
    def text_formatting
      current_text_formatting || super
    end

    def current_text_formatting
      Thread.current[:current_text_formatting]
    end

    def current_text_formatting=(format)
      Thread.current[:current_text_formatting] = format.presence
    end

    def within_text_formatting(format, &block)
      current = current_text_formatting
      begin
        self.current_text_formatting = format
        block.call
      ensure
        self.current_text_formatting = current
      end
    end
  end
end

module Lookbook
  class PreviewExample
    include Taggable

    attr_reader :name

    def initialize(name, preview)
      @name = name
      @preview = preview
    end

    def id
      path.underscore.tr("_", "-")
    end

    def path
      "#{@preview.lookbook_path}/#{name}"
    end

    def label
      lookbook_label.presence || name.titleize
    end

    def method_source
      code_object.source.split("\n")[1..-2].join("\n").strip_heredoc
    end

    def source_lang
      Lookbook::Lang.find(:ruby)
    end

    def template_source(template_path)
      File.read(full_template_path(template_path))
    end

    def template_lang(template_path)
      Lookbook::Lang.guess(full_template_path(template_path)) || Lookbook::Lang.find(:html)
    end

    def type
      :example
    end

    def matchers
      [@preview.label, label].map { |m| m.gsub(/\s/, "").downcase }
    end

    def hierarchy_depth
      @preview.lookbook_hierarchy_depth + 1
    end

    def params
      method_params = code_object.parameters
      code_object.tags(:param).map do |tag|
        name = tag.name.to_s        
        type = tag.types.first
        parsed_param = method_params.find { |p| p[0] == "#{name}:" }
        default_value = parsed_param ? parsed_param[1] : nil
        if type == String && default_value
          str_match = default_value.match(/^[\"\'](.+)[\"\']$/)
          if str_match
            default_value = str_match[1]
          end
        end
        
        {
          name: name,
          lang_type: type,
          field_type: tag.text.split[0] || "text",
          default_value: default_value
        }
      end
    end

    private

    def taggable_object_path
      "#{@preview.name}##{name}"
    end

    def full_template_path(template_path)
      base_path = Array(Lookbook.config.preview_paths).detect do |p|
        Dir["#{p}/#{template_path}.html.*"].first
      end
      Pathname.new(Dir["#{base_path}/#{template_path}.html.*"].first)
    end

    alias_method :group, :lookbook_group
    alias_method :notes, :lookbook_notes
    alias_method :hidden?, :lookbook_hidden?
  end
end

require "active_support/dependencies/autoload"
require "lookbook/engine"

module Lookbook
  extend ActiveSupport::Autoload

  autoload :Lang, "lookbook/lang"
  autoload :Collection, "lookbook/collection"
  autoload :Parser, "lookbook/parser"
  autoload :Preview, "lookbook/preview"
  autoload :PreviewController, "lookbook/preview_controller"
  autoload :PreviewExample, "lookbook/preview_example"
  autoload :PreviewGroup, "lookbook/preview_group"
  autoload :Taggable, "lookbook/taggable"
  autoload :Param, "lookbook/param"
end

# frozen_string_literal: true

require_relative "file/version"
require 'securerandom'
require 'prawn-html'
require 'tempfile'
module FakeFile
  class Document
    class << self
      def generate
        pdf = Prawn::Document.new
        PrawnHtml.append_html(pdf, '<h1 style="text-align: center">Just a test</h1>')
        file = Tempfile.new
        file.write pdf
        file
      end
    end
  end
end

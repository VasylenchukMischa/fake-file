# frozen_string_literal: true

require_relative "fake-file/version"
require 'securerandom'
require 'prawn-html'
require 'tempfile'
require 'faker'

module FakeFile
  class Document
    def self.pdf
      pdf = Prawn::Document.new
      html = "<h1>#{Faker::Book.title}</h1>
              <p>#{Faker::Lorem.paragraph}</p>"
      PrawnHtml.append_html(pdf, html)
      generate_tempfile(pdf.render)
    end

    private

    def self.generate_tempfile(filename)
      generated_file = Tempfile.new([SecureRandom.uuid, '.pdf'], encoding: 'ASCII-8BIT')
      generated_file.write filename
      generated_file
    end
  end
end

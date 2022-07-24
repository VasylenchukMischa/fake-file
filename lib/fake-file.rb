# frozen_string_literal: true

require_relative "fake-file/version"
require 'securerandom'
require 'prawn-html'
require 'tempfile'
require 'faker'
require 'htmltoword'

module FakeFile
  class Document
    def self.pdf
      pdf = Prawn::Document.new
      html = "<h1>#{Faker::Book.title}</h1>
              <p>#{Faker::Lorem.paragraph}</p>"
      PrawnHtml.append_html(pdf, html)
      generate_tempfile(pdf.render, '.pdf')
    end

    def self.docx
      my_html = '<html><head></head><body><p>Hello</p></body></html>'
      document = Htmltoword::Document.create(my_html)
      generate_tempfile(document, '.docx')
    end

    private

    def self.generate_tempfile(data, filetype, encoding='ASCII-8BIT')
      generated_file = Tempfile.new([SecureRandom.uuid, filetype], encoding: encoding)
      generated_file.write data
      generated_file
    end
  end
end

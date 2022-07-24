# frozen_string_literal: true

require_relative "fake-file/version"

require 'securerandom'
require 'tempfile'

require 'faker'

require 'prawn-html'
require 'htmltoword'
require 'axlsx'

require 'pry'

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

    def self.xlsx
      Axlsx::Package.new do |p|
        p.workbook.add_worksheet(:name => "Pie Chart") do |sheet|
          sheet.add_row ["Simple Pie Chart"]
          %w(first second third).each { |label| sheet.add_row [label, rand(24)+1] }
          sheet.add_chart(Axlsx::Pie3DChart, :start_at => [0,5], :end_at => [10, 20], :title => "example 3: Pie Chart") do |chart|
            chart.add_series :data => sheet["B2:B4"], :labels => sheet["A2:A4"],  :colors => ['FF0000', '00FF00', '0000FF']
          end
        end
        generate_tempfile(p.to_stream.read, '.xlsx')
      end
    end

    private

    def self.generate_tempfile(data, filetype, encoding='ASCII-8BIT')
      generated_file = Tempfile.new([SecureRandom.uuid, filetype], encoding: encoding)
      generated_file.write data
      generated_file
    end
  end
end

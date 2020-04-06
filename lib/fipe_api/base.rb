# frozen_string_literal: true

require 'http'
require 'nokogiri'
require 'fipe_api/utils'

module FipeApi
  class Base
    HEADERS = { 'Referer' => 'https://veiculos.fipe.org.br/', 'Host' => 'veiculos.fipe.org.br' }.freeze
  end
end

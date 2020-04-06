# frozen_string_literal: true

module FipeApi
  class Model < FipeApi::Base
    attr_accessor :id
    attr_accessor :name
    attr_accessor :brand

    def initialize(id, name, brand)
      self.id = id
      self.name = name
      self.brand = brand
    end

    def get_years(table = nil)
      table = Table.latest(brand.vehicle) if table.nil?

      response = HTTP.post('https://veiculos.fipe.org.br/api/veiculos/ConsultarAnoModelo',
                           headers: HEADERS,
                           params: {
                             codigoTabelaReferencia: table.id,
                             codigoTipoVeiculo: brand.vehicle.id,
                             codigoMarca: brand.id,
                             codigoModelo: id
                           },
                           body: {}.to_json).to_s
      years_hash = JSON.parse(response)
      years_result = []
      years_hash.each do |year|
        years_result << Year.new(year['Value'], year['Label'], self)
      end

      years_result
    end
  end
end

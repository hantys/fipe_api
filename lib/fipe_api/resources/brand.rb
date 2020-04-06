# frozen_string_literal: true

module FipeApi
  class Brand < FipeApi::Base
    attr_accessor :id
    attr_accessor :name
    attr_accessor :vehicle
    attr_accessor :table

    def initialize(id, name, table, vehicle)
      self.id = id
      self.name = name
      self.table = table
      self.vehicle = vehicle
    end

    def get_models(table = nil)
      table = Table.latest(vehicle) if table.nil?

      response = HTTP.post('https://veiculos.fipe.org.br/api/veiculos/ConsultarModelos',
                           headers: HEADERS,
                           params: {
                             codigoTabelaReferencia: table.id,
                             codigoTipoVeiculo: vehicle.id,
                             codigoMarca: id
                           },
                           body: {}.to_json).to_s
      models_hash = JSON.parse(response)
      models_result = []
      models_hash['Modelos'].each do |model|
        models_result << Model.new(model['Value'], model['Label'], self)
      end

      models_result
    end
  end
end

# frozen_string_literal: true

require 'date'

module FipeApi
  class Year < FipeApi::Base
    attr_accessor :id
    attr_accessor :year
    attr_accessor :name
    attr_accessor :model
    attr_accessor :fuel

    def initialize(id, name, model)
      self.id = id.split('-')[0]
      self.year = self.id == '32000' ? Date.today.year : self.id
      self.fuel = id.split('-')[1]
      self.name = name
      self.model = model
    end

    def get_result(table = nil)
      table = Table.latest(model.brand.vehicle) if table.nil?

      response = HTTP.post('https://veiculos.fipe.org.br/api/veiculos/ConsultarValorComTodosParametros',
                           headers: HEADERS,
                           params: {
                             codigoTabelaReferencia: table.id,
                             codigoTipoVeiculo: model.brand.vehicle.id,
                             codigoMarca: model.brand.id,
                             codigoModelo: model.id,
                             anoModelo: id,
                             codigoTipoCombustivel: fuel,
                             tipoVeiculo: model.brand.vehicle.name_id,
                             tipoConsulta: 'tradicional'
                           },
                           body: {}.to_json).to_s
      result_json = JSON.parse(response)
      fipe_result = nil
      unless result_json.nil?
        fipe_result = FipeResult.new(result_json['CodigoFipe'].strip,
                                     self,
                                     result_json['Combustivel'],
                                     result_json['Autenticacao'],
                                     result_json['Valor'],
                                     result_json['DataConsulta'])
      end

      fipe_result
    end
  end
end

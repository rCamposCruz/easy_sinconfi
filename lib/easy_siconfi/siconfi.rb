require "net/http"
require "json"

class SICONFI
	attr_accessor :available_no_anexo, :available_co_tipo_demonstrativo

	def initialize()
		@webservice_url = "http://apidatalake.tesouro.gov.br/ords/siconfi/tt/rreo?"
		@available_no_anexo = ['RREO-Anexo 01', 'RREO-Anexo 02', 'RREO-Anexo 03', 
		 			 								 'RREO-Anexo 04', 'RREO-Anexo 04 - RGPS', 'RREO-Anexo 04 - RPPS', 
													 'RREO-Anexo 04.0 - RGPS', 'RREO-Anexo 04.1', 'RREO-Anexo 04.2', 
													 'RREO-Anexo 04.3 - RGPS', 'RREO-Anexo 05', 'RREO-Anexo 06', 
													 'RREO-Anexo 07', 'RREO-Anexo 09', 'RREO-Anexo 10 - RGPS', 'RREO-Anexo 10 - RPPS', 
													 'RREO-Anexo 11', 'RREO-Anexo 13', 'RREO-Anexo 14']

		@available_co_tipo_demonstrativo = ['RREO', 'RREO Simplificado']
	end

	def get_to_server(str)
		Net::HTTP.get(URI(str))
	end

	def connected?()
		mock_query = "an_exercicio=2019&nr_periodo=1&co_tipo_demonstrativo=RREO&id_ente=3550308"
		response = get_to_server("#{@webservice_url}#{mock_query}")

		if response.to_s.eql? '' then
			false
		else
			true
		end
	end

	def query_data(hash)
		if check_no_anexo(hash[:no_anexo]) && check_co_tipo_demonstrativo(hash[:co_tipo_demonstrativo]) &&  
			 check_nr_periodo(hash[:nr_periodo]) &&  check_an_exercicio(hash[:an_exercicio]) &&  
			 check_id_ente(hash[:id_ente]) then

			# Builds query 		
			url = "#{@webservice_url}an_exercicio=#{hash[:an_exercicio]}"
			url = "#{url}&nr_periodo=#{hash[:nr_periodo]}"
			url = "#{url}&co_tipo_demonstrativo=#{hash[:co_tipo_demonstrativo]}"
			url = "#{url}&id_ente=#{hash[:id_ente]}"
			url = "#{url}&no_anexo=#{hash[:no_anexo]}"

			consume_json(get_to_server(url))
		else
			nil
		end
	end

	def consume_json(complex_json)
		data_array = []
		output = JSON.parse(complex_json)

		output['items'].each do |hash|
			data_array << SICONFIData.new(hash)
		end

		data_array
	end

	#this list comes from the documentation
	#@ http://apidatalake.tesouro.gov.br/docs/siconfi/#/RREO
	def check_no_anexo(no_anexo)
		if no_anexo == nil then
			false
		elsif no_anexo.match(/^\D\d+/) then
			no_anexo.to_i < @available_no_anexo.size && no_anexo.to_i >= 0
		else
			@available_no_anexo.index(no_anexo) != nil
		end
	end

	def check_co_tipo_demonstrativo(co_tipo_demonstrativo)
		@available_co_tipo_demonstrativo.index(co_tipo_demonstrativo) != nil && co_tipo_demonstrativo != nil
	end

	def check_nr_periodo(nr_periodo)
		nr_periodo >= 1 && nr_periodo <= 6 && nr_periodo != nil
	end

	def check_an_exercicio(an_exercicio)
		an_exercicio != nil && an_exercicio.to_i > 1940 && an_exercicio != nil
	end

	def check_id_ente(id_ente)
		id_ente != nil && id_ente.to_i > 0 && id_ente != nil
	end
end

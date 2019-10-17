RSpec.describe SICONFI do
	it "can connect to source" do
		expect(SICONFI.new().connected?).to eq(true)
	end

	context "whilst connected to source" do
		before :all do
			@source = SICONFI.new()
			
			@ano_exercicio = 2019
			@nr_periodo_valido = 3
			@nr_periodo_invalido = 7
			@co_tipo_demonstrativo_valido = "RREO"
			@co_tipo_demonstrativo_invalido = "RREO ASDF"
			@no_anexo_valido = "RREO-Anexo 02"
			@no_anexo_valido_simplificado = "1"
			@no_anexo_invalido = "RREO-Anexo 14123"
			@no_anexo_invalido_simplificado = "19"
			@codigo_ibge_sao_paulo = 3550308
			@codigo_ibge_amargosa = 2901007
		end

		it "identifies unavailable nr_periodo" do
			data_array = @source.query_data({an_exercicio: @ano_exercicio,
																	 		 nr_periodo: @nr_periodo_invalido,
																			 co_tipo_demonstrativo: @co_tipo_demonstrativo_valido,
																			 no_anexo: @no_anexo_valido,
																			 id_ente: @codigo_ibge_sao_paulo})

			expect(data_array).to eq(nil)
		end

		it "identifies unavailable co_tipo_demonstrativo" do
			data_array = @source.query_data({an_exercicio: @ano_exercicio,
																			 nr_periodo: @nr_periodo_valido,
																			 co_tipo_demonstrativo: @co_tipo_demonstrativo_invalido,
																			 no_anexo: @no_anexo_valido,
																			 id_ente: @codigo_ibge_sao_paulo})

			expect(data_array).to eq(nil)
		end

		it "identifies unavailable no_anexo" do
			data_array = @source.query_data({an_exercicio: @ano_exercicio,
																			 nr_periodo: @nr_periodo_valido,
																			 co_tipo_demonstrativo: @co_tipo_demonstrativo_valido,
																			 no_anexo: @no_anexo_invalido,
																			 id_ente: @codigo_ibge_sao_paulo})

			expect(data_array).to eq(nil)
		end

		it "can get a valid data object from source" do
			data_array = @source.query_data({an_exercicio: @ano_exercicio,
																			 nr_periodo: @nr_periodo_valido,
																			 co_tipo_demonstrativo: @co_tipo_demonstrativo_valido,
																			 no_anexo: @no_anexo_valido,
																			 id_ente: @codigo_ibge_sao_paulo})

			expect(data_array.size > 1).to eq(true)

			data_array.each do |data_object|
				expect(data_object.valid?).to eq(true)
			end
		end
	end
end

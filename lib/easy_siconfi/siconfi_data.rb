class SICONFIData
	attr_accessor :exercicio, :periodo, :periodicidade, :instituicao, 
								:uf, :populacao, :rotulo, :coluna, :conta, :valor

	def initialize(hash)
		@exercicio = hash['exercicio']
		@periodo = hash['periodo']
		@periodicidade = hash['periodicidade']
		@instituicao = hash['instituicao']
		@uf = hash['uf']
		@populacao = hash['populacao']
		@rotulo = hash['rotulo']
		@coluna = hash['coluna']
		@conta = hash['conta']
		@valor = hash['valor']
	end

	def valid?()
		@exercicio != nil && @periodo != nil && 
		@periodicidade != nil && @instituicao != nil && 
		@uf != nil && @populacao != nil && 
		@rotulo != nil && @coluna != nil && 
		@conta != nil && @valor != nil
	end
	
	def to_s()
		"exercicio: #{@exercicio}\nperiodo: #{@periodo}\nperiodicidade: #{@periodicidade}\ninstituicao: #{@instituicao}\nuf: #{@uf}\npopulacao: #{@populacao}\nrotulo: #{@rotulo}\ncoluna: #{@coluna}\nconta: #{@conta}\nvalor: #{@valor}"
	end
end

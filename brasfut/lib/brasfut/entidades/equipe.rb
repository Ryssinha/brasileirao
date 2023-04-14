class Equipe
  attr_accessor :nome, :sigla, :partidas

  def initialize(nome, sigla)
    self.nome = nome
    self.sigla = sigla
    self.partidas = []
  end

  def classificacao
    pontos = @partidas.map do |partida|
      partida.quantos_pontos_para(self)
    end.sum

    Classificacao.new(self, pontos)
  end

  def quantidade_vitorias
    @partidas.select{ |partida| partida.quantos_pontos_para(self) == 3 }.count
  end

  def quantidade_derrotas
    @partidas.select{ |partida| partida.quantos_pontos_para(self) == 0 }.count
  end

  def quantidade_empates
    @partidas.select{ |partida| partida.quantos_pontos_para(self) == 1 }.count
  end

  def gols_marcados
    @partidas.map do |partida|
      if partida.mandante == self
        partida.gols_mandante
      else
        partida.gols_visitante
      end
    end.sum
  end

  def gols_sofridos
    @partidas.map do |partida|
      if partida.mandante == self
        partida.gols_visitante
      else
        partida.gols_mandante
      end
    end.sum
  end

  def saldo_gols
    gols_marcados - gols_sofridos
  end
end

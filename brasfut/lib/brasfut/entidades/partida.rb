class Partida
  attr_accessor :mandante, :visitante,
                :gols_mandante, :gols_visitante

  def initialize(mandante, visitante)
    @mandante = mandante
    @visitante = visitante

    @mandante.partidas << self
    @visitante.partidas << self
  end

  def visualizar
    "#{@mandante.sigla} X #{@visitante.sigla}"
  end

  def quantos_pontos_para(equipe)
    return 0 if gols_mandante.nil? || gols_visitante.nil?

    if gols_mandante == gols_visitante
      return 1
    elsif (equipe == @mandante && gols_mandante > gols_visitante)
      return 3
    elsif (equipe == @visitante && gols_visitante > gols_mandante)
      return 3
    else
      return 0
    end
  end
end

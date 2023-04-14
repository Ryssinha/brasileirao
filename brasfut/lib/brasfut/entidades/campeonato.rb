class Campeonato

  attr_accessor :edicao, :equipes, :partidas, :rodadas

  def initialize(edicao)
    @edicao = edicao
    @equipes = []
    @partidas = []
    @rodadas = []
  end

  def classificacao
    @equipes.map do |equipe|
      equipe.classificacao
    end.sort { |x, y| y.pontos <=> x.pontos }
  end

  def criar_tabela!
    total_equipes = @equipes.count
    total_rodadas = total_equipes * 2 - 2
    partidas_por_rodada = total_equipes / 2
    partidas_possiveis = gerar_partidas_possiveis #vai para o metodo gerar_partidas_possiveis

    (1..total_rodadas).each do |id_rodada|
      turno = (id_rodada <= total_rodadas / 2) ? 1 : 2 #condição ternaria , se sim turno = 1,se nao vturno = 2
      rodada = Rodada.new(id_rodada, turno)

      partidas_por_rodada.times do |partida|
        if rodada.partidas.any? #existe alguma partida? 
          times_rodada = rodada.partidas.map{|r| [r.mandante, r.visitante]}.flatten.uniq #criar novo array com mandante e visitante.
          partida_selecionada = partidas_possiveis.find do |partida|
            !(times_rodada.include?(partida.mandante) || times_rodada.include?(partida.visitante))
          end
          partidas_possiveis.delete(partida_selecionada) #deleta a partida para que ela não se repita novamnete
          rodada.partidas << partida_selecionada

        else
          partida_selecionada = partidas_possiveis.first 
          partidas_possiveis.delete(partida_selecionada)
          rodada.partidas << partida_selecionada
        end
      end
      @rodadas << rodada #retorna as rodadas
    end
  end

  def gerar_partidas_possiveis
    partidas_possiveis = []
    @equipes.each do |mandante|
      adiversarios = @equipes - [mandante]

      adiversarios.each do |visitante|
        partidas_possiveis << Partida.new(mandante, visitante)
      end
    end
    partidas_possiveis #retorna todas as partidas possiveis
  end

  def imprimir_tabela
    @rodadas.map{ |r| r.visualizar }.join("\n")
  end

  def imprimir_classificao
    string = []
    string << "| # | Sigla | Time                    | Pontos | Vitorias | Empates | Derrotas | Saldo de Gols | Gols Pro | Gols Contra | \n"
    string << "|---|-------|-------------------------|--------|----------|---------|----------|---------------|----------|-------------| \n"
    classificacao.each_with_index do |classificacao, index|
      equipe = classificacao.equipe
      linha = []
      linha << "| #{index + 1 } "
      linha << "| #{equipe.sigla.ljust(5, " ")} "
      linha << "| #{equipe.nome.ljust(23, " ")} "
      linha << "| #{classificacao.pontos.to_s.ljust(6, " ")} "
      linha << "| #{equipe.quantidade_vitorias.to_s.ljust(8, " ")} "
      linha << "| #{equipe.quantidade_empates.to_s.ljust(7, " ")} "
      linha << "| #{equipe.quantidade_derrotas.to_s.ljust(8, " ")} "
      linha << "| #{equipe.saldo_gols.to_s.ljust(13, " ")} "
      linha << "| #{equipe.gols_marcados.to_s.ljust(8, " ")} "
      linha << "| #{equipe.gols_sofridos.to_s.ljust(12, " ")}| "
      linha << "\n"
      string << linha
    end
     puts string.join("") #adicionei esse puts para a visualização da classificação
    string.join("")
  end
end

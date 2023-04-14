# frozen_string_literal: true

require "brasfut"

RSpec.describe Brasfut do
  before(:all) do
    @campeonato = Campeonato.new(2023)
    @cam = Equipe.new("Atlético-MG", "CAM")
    @vas = Equipe.new("Vasco", "VAS")
    @cru = Equipe.new("Cruzeiro", "CRU")
    @for = Equipe.new("Fortaleza", "FOR")
    @campeonato.equipes = [@vas, @cam, @cru, @for]
  end

  it "Todos os times devem ter zero pontos" do
    @campeonato.equipes.each do |equipe|
      expect(equipe.classificacao.pontos).to eq(0)
    end
  end

  it "Deve calcular 3 pontos por uma vitoria" do
    @vas.partidas = []
    @cam.partidas = []
    partida = Partida.new(@cam, @vas)
    partida.gols_mandante = 2
    partida.gols_visitante = 1

    expect(@cam.classificacao.pontos).to eq(3)
    expect(@vas.classificacao.pontos).to eq(0)
  end

  it "Deve calcular 1 ponto por empate" do
    @vas.partidas = []
    @cam.partidas = []
    partida = Partida.new(@cam, @vas)
    partida.gols_mandante = 5
    partida.gols_visitante = 5

    expect(@cam.classificacao.pontos).to eq(1)
    expect(@vas.classificacao.pontos).to eq(1)
  end

  it "Deve calcular 0 ponto por derrota" do
    @cru.partidas = []
    @cam.partidas = []
    partida = Partida.new(@cru, @cam)
    partida.gols_mandante = 0
    partida.gols_visitante = 1

    expect(@cru.classificacao.pontos).to eq(0)
    expect(@cam.classificacao.pontos).to eq(3)
  end

  it "O galo deve estar em primeiro e o vasco em segundo" do
    @vas.partidas = []
    @cam.partidas = []
    partida = Partida.new(@cam, @vas)
    partida.gols_mandante = 2
    partida.gols_visitante = 1

    classificacoes = @campeonato.classificacao
    expect(classificacoes[0].equipe).to eq(@cam)
    expect(classificacoes[0].pontos).to eq(3)

    expect(classificacoes[1].equipe).to eq(@vas)
    expect(classificacoes[1].pontos).to eq(0)
  end

  it "o método gerar_partidas_possiveis deverá gerar 12 partidas" do
    limpar_partidas
    partidas = @campeonato.gerar_partidas_possiveis
    expect(partidas.count).to eq(12)
  end

  it "o método criar_tabela! deverá retornar um 10 rodadas" do
    limpar_partidas
    @campeonato.rodadas = []
    @campeonato.criar_tabela!
    expect(@campeonato.rodadas.count).to eq(6)
  end

  it "o método imprimir_tabela deverá retornar uma string representando a tabela" do
    limpar_partidas
    @campeonato.equipes = [@vas, @cam]
    @campeonato.rodadas = []
    @campeonato.criar_tabela!
    tabela = @campeonato.imprimir_tabela
    expect(tabela).to eq("Rodada 1\n---------------\nVAS X CAM\n\n\n\nRodada 2\n---------------\nCAM X VAS\n\n\n")
  end

  it "imprimir_classificao" do
    limpar_partidas
    @campeonato.equipes = [@vas, @cam]
    @campeonato.rodadas = []
    classificacao_esperada = "| # | Sigla | Time                    | Pontos | Vitorias | Empates | Derrotas | Saldo de Gols | Gols Pro | Gols Contra | \n|---|-------|-------------------------|--------|----------|---------|----------|---------------|----------|-------------| \n| 1 | VAS   | Vasco                   | 4      | 1        | 1       | 0        | 1             | 4        | 3           | \n| 2 | CAM   | Atlético-MG             | 1      | 0        | 1       | 1        | -1            | 3        | 4           | \n"

    partida = Partida.new(@cam, @vas)
    partida.gols_mandante = 2
    partida.gols_visitante = 3

    partida = Partida.new(@vas, @cam)
    partida.gols_mandante = 1
    partida.gols_visitante = 1
    
    expect(@campeonato.imprimir_classificao).to eq(classificacao_esperada)
  end

  def limpar_partidas
    @cam.partidas = []
    @vas.partidas = []
    @cru.partidas = []
    @for.partidas = []
  end
end

# brasileirao

## Campeonato
O **`Campeonato`** é uma classe que representa um campeonato de futebol. Possui os seguintes atributos:

- *`edicao`*: a edição do campeonato.
- *`equipes`*: um array que armazena as equipes participantes do campeonato.
- *`partidas`*: um array que armazena as partidas ocorridas no campeonato.
- *`rodadas`*: um array que armazena as rodadas do campeonato.
### Métodos
#### `initialize(edicao)`
O método construtor initialize é responsável por inicializar um novo objeto da classe Campeonato com a edição fornecida como parâmetro. Ele inicializa os arrays de equipes, partidas e rodadas vazios.

#### `classificacao`
O método classificacao retorna um array com as equipes participantes do campeonato ordenadas pela pontuação, em ordem decrescente. A pontuação é calculada com base nos pontos obtidos em cada partida.

#### `criar_tabela!`
O método criar_tabela! é responsável por criar a tabela do campeonato, gerando as rodadas e as partidas. Ele utiliza o algoritmo de rodadas e partidas possíveis para evitar que as equipes se enfrentem mais de uma vez na mesma rodada. A tabela gerada é armazenada no array de rodadas.

#### `gerar_partidas_possiveis`
O método gerar_partidas_possiveis é responsável por gerar todas as possíveis partidas entre as equipes participantes do campeonato. Ele retorna um array com todas as combinações possíveis de mandante e visitante.

#### `imprimir_tabela`
O método imprimir_tabela retorna uma string com a visualização da tabela do campeonato, mostrando as rodadas e as partidas ocorridas em cada rodada.

#### `imprimir_classificacao`
O método imprimir_classificacao retorna uma string com a classificação das equipes participantes do campeonato, mostrando a posição, sigla, nome, pontos, vitórias, empates, derrotas, saldo de gols, gols marcados e gols sofridos de cada equipe. Essa classificação é baseada na pontuação obtida em cada partida.

## Classificacao
A *`Classificacao`* é uma classe que representa a classificação de uma equipe em um campeonato. Possui os seguintes atributos:

- *`equipe`*: a equipe.
- *`pontos`*: a pontuação da equipe.
### **Métodos**
#### **`initialize(equipe, pontos)`**
O método construtor *`initialize`* é responsável por inicializar um novo objeto da classe *`Classificacao`* com a equipe e a pontuação fornecidas como parâmetros.

## Equipe
A *`Equipe`* é uma classe que representa uma equipe de futebol. Possui os seguintes atributos:

- *`nome`*: o nome da equipe.
- *`sigla`*: a sigla da equipe.
- *`partidas`*: um array que armazena as partidas que a equipe participou.
### Métodos
#### **`initialize(nome, sigla)`**
O método construtor initialize é responsável por inicializar um novo objeto da classe Equipe com o nome e a sigla fornecidos como parâmetros. Ele também inicializa o array de partidas vazio.

#### **`classificacao`**

O método *`classificacao`* retorna a posição atual da equipe na classificação do campeonato, com base na pontuação obtida em suas partidas. A posição é determinada pelo número de pontos, sendo que equipes com maior pontuação ocupam posições mais altas na classificação.

**`adicionar_partida(partida)`**
O método *`cadicionar_partida`* é responsável por adicionar uma partida à lista de partidas da equipe. Ele recebe um objeto *`Partida`* como parâmetro e adiciona essa partida ao array de *`partidas`* da equipe.

## Partida
A *`Partida`* é uma classe que representa uma partida de futebol entre duas equipes. Possui os seguintes atributos:

- *`mandante`*: a equipe mandante.
- *`visitante`*: a equipe visitante.
- *`gols_mandante`*: a quantidade de gols marcados pela equipe mandante.
- *`gols_visitante`*: a quantidade de gols marcados pela equipe visitante.
### Métodos
#### **`initialize(mandante, visitante, gols_mandante, gols_visitante)`**
O método construtor *`initialize`* é responsável por inicializar um novo objeto da classe *`Partida`* com as equipes mandante e visitante, bem como a quantidade de gols marcados por cada equipe.

#### **`resultado`**
O método resultado retorna o resultado da partida em formato de string, mostrando o placar com a quantidade de gols marcados por cada equipe.

## Exemplo de uso
Aqui está um exemplo de como usar as classes *`Campeonato`*, *`Equipe`* e *`Partida`* em um programa de simulação de campeonato de futebol:

```ruby
Copy code
# Criação das equipes
equipe1 = Equipe.new("Time A", "TA")
equipe2 = Equipe.new("Time B", "TB")
equipe3 = Equipe.new("Time C", "TC")
equipe4 = Equipe.new("Time D", "TD")

# Criação do campeonato
campeonato = Campeonato.new("Campeonato 2023")

# Adição das equipes ao campeonato
campeonato.adicionar_equipe(equipe1)
campeonato.adicionar_equipe(equipe2)
campeonato.adicionar_equipe(equipe3)
campeonato.adicionar_equipe(equipe4)

# Criação das partidas do campeonato
campeonato.criar_tabela!

# Simulação das partidas e atualização dos resultados
partidas = campeonato.partidas
partidas.each do |partida|
  gols_mandante = rand(0..5)
  gols_visitante = rand(0..5)
  partida.atualizar_resultado(gols_mandante, gols_visitante)
end

# Impressão da tabela e da classificação
puts campeonato.imprimir_tabela
puts campeonato.imprimir_classificacao
```
Nesse exemplo, as equipes são criadas, adicionadas ao campeonato, e as partidas são geradas automaticamente pelo método criar_tabela! do campeonato. Em seguida, as partidas são simuladas e os resultados são atualizados. Por fim, a tabela e a classificação do campeonato são impressas na tela.

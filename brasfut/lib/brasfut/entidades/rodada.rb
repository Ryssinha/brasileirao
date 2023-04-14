class Rodada
    attr_accessor :id, :partidas, :turno
  
    def initialize(id, turno)
      @id = id
      @turno = turno
      @partidas = []
    end
  
    def visualizar
      string = []
      string << "Rodada #{@id}"
      string << "---------------"
      @partidas.each do |partida|
        string << partida.visualizar + "\n"
      end
      string << "\n"
      puts string #adicionei esse puts para a visualização das rodadas
      string.join("\n")
    end
  end
  
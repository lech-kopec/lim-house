#Definiujemy klasę:
class Lost


  #potrzebujemy akcesora zwracającego wskaźnik do pliku:
  attr_accessor :fp

  #Konstruktor otwiera plik:
  def initialize(file)
    @fp = File.open(file, 'w')
  end

  #Metoda do dodawania rekordów:
  def add_record

    #Pobieramy informacje:
    id = "zip"
    name = "your pants"
    #Zapisujemy dane do pliku:
    @fp.puts "#{id},#{name}"
  end

  #Metoda zamykania pliku
  def close
    @fp.close
  end

end #Koniec klasy Lost

#Tworzymy obiekt:
lost = Lost.new('dane.txt')

#Dodajemy dwa kolene rekordy:
2.times { lost.add_record }
lost.close
#Zamykamy plik
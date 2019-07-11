class Disk < Product
  attr_reader :musician, :albom, :genre

  def self.from_file(file_path)
    lines = File.readlines(file_path, encoding: 'UTF-8').map { |l| l.chomp }

    self.new(
      albom: lines[0],
      musician: lines[1],
      genre: lines[2],
      price: lines[3],
      amount: lines[4]
    )
  end

  def initialize(params)
    super

    @musician = params[:musician]
    @albom = params[:albom]
    @genre = params[:genre]
  end

  def short_info
    "#{albom}, #{musician}, кол-во - #{stuff}"
  end

  def to_s
      "Альбом «#{@albom}», исполнитель - #{@musician}, жанр — #{@genre}, #{super}"
  end
end

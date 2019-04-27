class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    boats = Boat.joins(:boat_classifications, :classifications).where( "classifications.name = ?", "Catamaran").distinct
    captains = boats.map {|boat| boat.captain}
  end

  def self.sailors
    includes(boats: :classificaitons).where(classificaions: {name: "Sailboat"}).distinct
  end

  def self.motroboat_operators
    includes(boats: :classifications).where(classifications: {name: ["Motorboat", "Sailboat"]}).distinct
  end
  
end

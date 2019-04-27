class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    boats = Boat.joins(:boat_classifications, :classifications).where( "classifications.name = ?", "Catamaran").distinct
    captains = boats.map {|boat| boat.captain}
  end

  def self.sailors
    includes(boats: :classificatons).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.talented_seafarers
    includes(boats: :classifications).where(classifications: {name: ["Motorboat", "Sailboat"]}).distinct
  end

  def self.non_sailors
    includes(boats: :classifications).where("classifications.name <> ?","Sailboat").distinct  
  end
  
end

class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    boats = Boat.joins(:boat_classifications, :classifications).where( "classifications.name = ?", "Catamaran").distinct
    captains = boats.map {|boat| boat.captain}
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: {name: "Motorboat"}).distinct
  end
  

  def self.talented_seafarers
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end
  
  def self.non_sailors
    where.not("id IN (?)", self.sailors.pluck(:id))
  end
  
end

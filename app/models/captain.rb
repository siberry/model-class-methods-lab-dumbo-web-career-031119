class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.motorboat_operators
    includes(boats: :classifications).where(classifications: {name: "Motorboat"}).distinct
  end

  def self.talented_seafarers
    all.select { |captain| Captain.sailors.include?(captain) && Captain.motorboat_operators.include?(captain)}
  end

  def self.non_sailors
    where.not("name in (?)", self.sailors.pluck(:name))
  end
end

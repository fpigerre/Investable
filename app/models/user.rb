class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :relationships, class_name: 'Relationship',
           foreign_key: 'follower_id',
           dependent: :destroy
  has_many :following, through: :relationships, source: :followed
  has_one :name

  validates :name, :length => {:maximum => 30}

  def name
    if "#{self[:name]}" != ''
      "#{self[:name]}" + "\'s"
    else
      self.email[/[^@]+/] + "\'s"
    end
  end

  def watch_stock(stock)
    relationships.create(followed_id: stock.symbol)
  end

  def unwatch_stock(stock)
    relationships.find_by(followed_id: stock.symbol).destroy
  end

  def watching?(stock)
    following.include?(stock)
  end
end
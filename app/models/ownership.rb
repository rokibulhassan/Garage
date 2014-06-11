class Ownership < ActiveRecord::Base
  attr_accessible :year, :owner_name, :status
  belongs_to :vehicle

  MINE, SOLD_ON, OWNED = 'build_mine', 'sold_on', 'owned_since'
  STATUSES = [MINE, SOLD_ON, OWNED]

  ME, WIFE, DAD, MUM, KID1, KID2 = 'me', 'wife', 'dad', 'mum', 'kid_1', 'kid_2'
  OWNER_NAMES = [ME, WIFE, DAD, MUM, KID1, KID2]

  YEAR_DEPENDENCE =  [SOLD_ON, OWNED]
end

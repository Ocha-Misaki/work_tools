class AffiliatedGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :group_id, { scope: :user_id,
                         message: 'ユーザーはすでに招待されています' }
end

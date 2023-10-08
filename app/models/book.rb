class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

   has_one_attached :profile_image
   #titleがあるかのバリデーション
   validates :title, presence: true
   #ボディがあるかのバリデーション
   validates :body, length: { in: 1..200 }


def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
end

def favorited_by?(user)
  favorites.exists?(user_id: user.id)
end

end

class Image < ApplicationRecord
  belongs_to :plant

  # Mounts paperclip image
  has_attached_file :file,
    styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\z/

  # #Validates file, file type and file size
  # validates_attachment :image, presence: true,
  #   content_type: { content_type: ["image/jpeg", "image/png", "image/gif"] }
    # size: { in: 0..10.kilobytes }

end

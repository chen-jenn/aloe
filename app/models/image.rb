class Image < ApplicationRecord
  belongs_to :plant

  has_attached_file :file,
    :path => ":rails_root/public/images/:id/:filename",
    :url => "/images/:id/:filename"

  do_not_validate_attachment_file_type :file
end

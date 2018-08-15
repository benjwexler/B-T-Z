class Video < ActiveRecord::Base
    belongs_to :video
    validates :video_url, presence: true
end 
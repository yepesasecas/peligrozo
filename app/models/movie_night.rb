class MovieNight < ActiveRecord::Base
  has_paper_trail

  has_many :attendees
  has_many :users, through: :attendees, source: :user

  has_one :chat

  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  belongs_to :movie
  belongs_to :schedule

  scope :seen, ->{ where seen: true }

  def chat!
    chat.present? ? chat : build_chat(conversation: "[]")
  end
end

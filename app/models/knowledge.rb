# == Schema Information
#
# Table name: knowledges
#
#  id                :integer          not null, primary key
#  title             :string
#  subtitle          :string
#  description       :text
#  appropriate       :text
#  notice            :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  is_hidden         :boolean          default("t")
#  status            :string           default("hidden")
#  category_id       :integer
#  likes_count       :integer          default("0")
#  stars_count       :integer          default("0")
#  follows_count     :integer          default("0")
#  wants_count       :integer          default("0")
#  haves_count       :integer          default("0")
#  reviews_count     :integer          default("0"), not null
#  discussions_count :integer          default("0"), not null
#  questions_count   :integer          default("0"), not null
#
# Indexes
#
#  index_knowledges_on_title  (title)
#

#  wants_count  :integer          default("0")
#  haves_count    :integer          default("0")

#
# Indexes
#
#  index_knowledges_on_title  (title)
#

class Knowledge < ApplicationRecord
  validates_presence_of :title, message: "标题不能为空"
  validates_presence_of :description, message: "请添加详情介绍"
  validates_presence_of :category_id, message: "分类不能为空"
  scope :recent, -> { order("created_at DESC") }

  has_many :photos, :dependent => :destroy
  has_many :scores, :dependent => :destroy
  has_many :reviews, :dependent => :destroy
  has_many :discussions, :dependent => :destroy
  has_many :questions, :dependent => :destroy

  accepts_nested_attributes_for :photos, :allow_destroy => true, :reject_if => :all_blank

  belongs_to :category

  def find_score(user)
    user && self.scores.where( :user_id => user.id ).first
  end

  def average_score
    self.scores.average(:score)
  end

  def hide!
    self.status = "hidden"
    self.save
  end

  def reject!
    self.status = "failed"
    self.save
  end

  def publish!
    self.status = "published"
    self.save
  end
end

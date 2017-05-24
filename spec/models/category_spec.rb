# == Schema Information
#
# Table name: categories
#
#  id                 :integer          not null, primary key
#  title              :string
#  weight             :integer          default("0")
#  knowledges_counter :integer          default("0")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  ancestry           :string
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

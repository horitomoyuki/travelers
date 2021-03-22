require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'ルーム作成' do
    before do
      @room = FactoryBot.build(:room)
    end

    it 'nameの値が存在すれば作成できる' do
      expect(@room).to be_valid
    end
    it 'nameが空では作成できない' do
      @room.name = nil
      @room.valid?
      expect(@room.errors.full_messages).to include "Name can't be blank"
    end
  end
end

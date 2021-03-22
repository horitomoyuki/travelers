require 'rails_helper'

RSpec.describe Talk, type: :model do
  before do
    @talk = FactoryBot.build(:talk)
  end

  describe 'トークの保存' do
    context 'トークの保存ができるとき' do
      it 'contentとimageが存在していれば保存できる' do
        expect(@talk).to be_valid
      end
      it 'contentが空でも保存できる' do
        @talk.content = nil
        expect(@talk).to be_valid
      end
      it 'imageが空でも保存できる' do
        @talk.image = nil
        expect(@talk).to be_valid
      end
    end
    context 'トークの保存ができないとき' do
      it 'contentとimageが空では保存できないこと' do
        @talk.content = nil
        @talk.image = nil
        @talk.valid?
        expect(@talk.errors.full_messages).to include "Content can't be blank"
      end
      it 'roomが紐付いていないと保存できないこと' do
        @talk.room = nil
        @talk.valid?
        expect(@talk.errors.full_messages).to include "Room must exist"
      end
      it 'userが紐付いていないと保存できないこと' do
        @talk.user = nil
        @talk.valid?
        expect(@talk.errors.full_messages).to include "User must exist"
      end
    end
  end
end

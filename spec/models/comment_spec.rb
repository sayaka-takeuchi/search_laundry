require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  it 'コメントの値があれば保存されること' do
    expect(@comment).to be_valid
  end

  it 'コメントが空の場合保存がされないこと' do
    @comment.text = nil
    @comment.valid?
    expect(@comment.errors.full_messages).to include('コメントを入力してください')
  end
end

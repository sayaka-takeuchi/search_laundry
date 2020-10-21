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

  it '性別が空の場合保存がされないこと' do
    @comment.gender = nil
    @comment.valid?
    expect(@comment.errors.full_messages).to include('性別を入力してください')
  end

  it '年齢が選択されていない場合保存がされないこと' do
    @comment.age_id = 0
    @comment.valid?
    expect(@comment.errors.full_messages).to include('年齢を選択してください')
  end

  it '評価が選択されていない場合保存がされないこと' do
    @comment.rate_id = 0
    @comment.valid?
    expect(@comment.errors.full_messages).to include('評価を選択してください')
  end
end

# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def new_guest
    user = User.find_or_create_by!(nickname: 'ゲストユーザー', email: 'user@example.com', first_name: '鈴木', last_name: '太郎', first_name_kana: 'スズキ', last_name_kana: 'タロウ') do |admin|
      admin.password = SecureRandom.alphanumeric
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def new_admin
    user = User.find_or_create_by!(nickname: 'ゲスト管理者', email: 'admin@example.com', first_name: '鈴木', last_name: '太郎', first_name_kana: 'スズキ', last_name_kana: 'タロウ', admin: true) do |admin|
      admin.password = SecureRandom.alphanumeric
    end
    sign_in user
    redirect_to root_path, notice: 'ゲスト管理者としてログインしました。'
  end
end

# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # ゲストユーザーとしてログイン
  def new_guest
    user = User.find_or_create_by!(nickname: 'ゲストユーザー', email: 'user@example.com') do |user|
      user.password = make_password
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  # ゲスト管理者としてログイン
  def new_admin
    admin = User.find_or_create_by!(nickname: 'ゲスト管理者', email: 'admin@example.com', admin: true) do |admin|
      admin.password = make_password
    end
    sign_in admin
    redirect_to root_path, notice: 'ゲスト管理者としてログインしました。'
  end

  private

  # ランダムでパスワードを作成(英数字が必ず入る)
  def make_password
    SecureRandom.alphanumeric(10) + [*'a'..'z'].sample(1).join + [*'0'..'9'].sample(1).join
  end
end

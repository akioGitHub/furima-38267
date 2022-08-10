class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  VALID_KANANAME = /\A[ァ-ヶー－]+\z/
  VALID_NAME = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/

  has_one :card, dependent: :destroy
  has_one :address
  has_many :items
  has_many :orders
  has_many :sns_credentials
  has_many :comments

  validates :nickname, :last_name, :first_name, :last_kana_name, :first_kana_name, :birthday, presence: true
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は半角英数を両方含む必要があります' }
  validates :last_kana_name, :first_kana_name, format: { with: VALID_KANANAME, message: 'は全角カタカナで入力してください' }
  validates :last_name, :first_name, format: { with: VALID_NAME, message: 'は全角日本語で入力してください' }

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    # userが登録済みであるか判断
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end

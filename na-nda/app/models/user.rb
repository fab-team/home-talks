class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter]

	# omniauthから対応するuserを取得する
	def self.from_omniauth(auth)
		# どのSNSで認証したかをproviderで判定
		if auth.provider == 'facebook'
			where(facebook_uid: auth.uid).first
	  # twitterの判定も先取って記述しておきます
	  elsif auth.provider == 'twitter'
	  	where(twitter_uid: auth.uid).first
	  end
	end

	# ユーザー登録に渡すデータを設定
	def self.new_with_session(_, session)
		super.tap do |user|
			if (data = session['devise.omniauth_data'])
				user.email = data['email'] if user.email.blank?
				user.username = data['name'] if user.username.blank?
				user.facebook_uid = data['facebook_uid'] if data['facebook_uid'] && user.facebook_uid.blank?
        # twitterの判定も先取って記述しておきます
        user.twitter_uid = data['twitter_uid'] if data['twitter_uid'] && user.twitter_uid.blank?
        user.skip_confirmation!
      end
    end
  end

end

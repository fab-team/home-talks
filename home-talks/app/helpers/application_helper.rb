module ApplicationHelper
	def page_title
		title = "Morning Glory"
		title = @page_title + " - " + title if @page_title
		title
	end

  def default_meta_tags
    {
      site: 'ホメトーク-HOME TALKS-',
      title: 'タイトル',
      reverse: true,
      charset: 'utf-8',
      description: 'ホメトークは、人から褒められてテンションが上がることができるサービスです。',
      keywords: 'ホメトーク,テンション,嬉しい',
      canonical: request.original_url,
      separator: '|',
      # icon: [
      #   { href: image_url('favicon.ico') },
      #   { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      # ],
      og: {
        site_name: 'ホメトーク-HOME TALKS-',
        title: 'タイトル',
        description: 'ホメトークは、人から褒められてテンションが上がることができるサービスです。',
        type: 'website',
        url: request.original_url,
        # image: image_url('ogp.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary',
        site: '@home_talks',
      }
    }
  end

end


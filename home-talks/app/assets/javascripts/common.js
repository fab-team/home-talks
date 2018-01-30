// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `rails generate channel` command.
//

$(function () {
	$('.p-header__menu__btn').on('click', function (event) {
		if (!$(this).hasClass('is_active')) {
			$(this).addClass('is_active');
			$('.p-header__menu').fadeIn();
		}else {
			$(this).removeClass('is_active');
			$('.p-header__menu').fadeOut();
		}
	});

  /*-----------------------------------
   * twitter
   -----------------------------------*/
   $('.c-talk__text').on('click', function (e) {
    e.preventDefault();

    var dualScreenLeft = undefined;
    var dualScreenTop = undefined;
    var windowWidth = undefined;
    var windowHeight = undefined;
    var popupWidth = 650;
    var popupHeight = 450;
    var top = undefined;
    var left = undefined;
    var href = undefined;
    var description = '';

    var snsUrl = encodeURIComponent(location.href);

    // 変数に止まったテキストを代入
    // for (var i = 0; i < SLOT_NUM; i++) {
    //   description += $slot_txt[i].text() + '\n';
    // }

    description += '「';
    description += $(this).find('.c-talk__balloon').text();
    description += '」';
    description += '\n';

    if (typeof window.screenLeft !== 'undefined') {
      dualScreenLeft = window.screenLeft;
      dualScreenTop = window.screenTop;
    } else {
      dualScreenLeft = window.screen.left;
      dualScreenTop = window.screen.top;
    }

    if (typeof window.innerWidth !== 'undefined') {
      windowWidth = window.innerWidth;
      windowHeight = window.innerHeight;
    } else if (typeof document.documentElement !== 'undefined' && typeof document.documentElement.clientWidth !== 'undefined') {
      windowWidth = document.documentElement.clientWidth;
      windowWidth = document.documentElement.clientHeight;
    } else {
      windowWidth = window.screen.width;
      windowWidth = window.screen.height;
    }

    left = windowWidth / 2 - popupWidth / 2 + dualScreenLeft;
    top = windowHeight / 2 - popupHeight / 2 + dualScreenTop;


    href = 'http://twitter.com/share?url=' + snsUrl + '&text=' + encodeURIComponent(description) + '&hashtags=' + encodeURIComponent('ホメトーク') + ',' + encodeURIComponent($('.decText.active').text());

    window.open(href, 'twitter', 'width=' + popupWidth + ', height=' + popupHeight + ', top=' + top + ', left=' + left);
  });
});
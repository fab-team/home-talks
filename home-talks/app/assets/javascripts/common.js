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
});
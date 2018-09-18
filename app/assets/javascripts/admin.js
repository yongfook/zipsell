$(document).on('turbolinks:load',function(event){

	$('.filepicker input').on('change', function() {
		name = $(this)[0].files[0].name
		$(this).parents('.filepicker').find('span.file-name').text(name)
	});


	var maxLength = 140;
	$('input#product_intro').on('change keyup paste', function() {
	  var length = $(this).val().length;
	  var length = maxLength-length;
	  $('#chars_left').text(length);
	});

})
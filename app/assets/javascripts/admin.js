$(document).on('turbolinks:load',function(event){

	if ($('#product_file').length) {
		var file = document.getElementById("product_file");
		file.onchange = function(){
		  if(file.files.length > 0){
				document.getElementById('filename').innerHTML = file.files[0].name;
			}
		}
	}

	var maxLength = 140;
	$('input#product_intro').on('change keyup paste', function() {
	  var length = $(this).val().length;
	  var length = maxLength-length;
	  $('#chars_left').text(length);
	});

})
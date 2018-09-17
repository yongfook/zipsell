$(document).on('turbolinks:load',function(event){

	if ($('#product_file').length) {
		var file = document.getElementById("product_file");
		file.onchange = function(){
		  if(file.files.length > 0){
				document.getElementById('filename').innerHTML = file.files[0].name;
			}
		}
	}

})
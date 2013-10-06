$(document).ready(function(){
	$("form.button_to").on('submit', function(e){
		var confirmed = confirm('Are you sure you have sent this checkout?');
		if (confirmed){
		} else{
			e.preventDefault();
		}
	});
})
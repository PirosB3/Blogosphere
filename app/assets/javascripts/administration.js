$(document).ready(function(){
	$("form.administration_form").on('submit', function(e){
		var confirmed = confirm('Are you sure you have sent this checkout?');
		if (confirmed){
		} else{
			e.preventDefault();
		}
	});
})
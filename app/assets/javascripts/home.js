$(document).ready(function(){
	$('.add_to_basket').on('click', function(){
		var amount = $(this).closest('.magazine_data').data('price');
		console.log(amount);
	})
	

})
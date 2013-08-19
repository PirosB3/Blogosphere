$(document).ready(function(){

       //need to send an ajax request to the controller to make a new checkout
       //when a user signs in make sure that all their checkouts are deleted
	$('.add_to_basket').on('click', function(){
		//getting the cost of the magazine out of the data attribu
		var amount = $(this).closest('.magazine_data').data('price');
		console.log(amount);
		var name = $(this).closest('.magazine_data').data('name');
		console.log(name);
        var id = $(this).closest('.magazine_data').data('id');
        console.log(id);

        

        $.ajax({
            url: "/download/create_checkout",
            type: 'POST',
            data: {id: id},
            success: function(){
            var h6 = $("<h6 id='magazine_checkout'>");
            //add a delete link in here so that you can click on it and destroy the checkout item
            console.log(h6);
            h6.html(name);
                
            $('.basket').append(h6);
                increaseSubtotal(amount);
            
            }
        });

	})

	//a function that calculated the updateSubtotal everytime something is added to the basket or removed from the bakset
    function increaseSubtotal(amount){
    	$('.subtotal').html('');
    	var current_subtotal = $('.subtotal').data('subtotal');
    	console.log(current_subtotal);
    	var updated_subtotal = current_subtotal + amount;
    	console.log(updated_subtotal);
    	var updatedsub = $('.subtotal').data('subtotal', updated_subtotal);
    	var update = $('.subtotal').data('subtotal');
        console.log(update);
        var h6 = $("<h6>");
        h6.html('£' + update);
        $('.subtotal').append(h6);
    }
    //a function that removes an item from the basket and then calls the updateSubtotal function

	

})
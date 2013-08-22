$(document).ready(function(){

    //when a user signs in make sure that all their checkouts are deleted
	$('.add_to_basket').on('click', function(){
		//getting the cost of the magazine out of the data attributes
		var amount = $(this).closest('.magazine_data').data('price');
		console.log(amount);
		var name = $(this).closest('.magazine_data').data('name');
		console.log(name);
        var id = $(this).closest('.magazine_data').data('id');
        console.log(id);
        
        //send an ajax request to the controller to make a new checkout
        $.ajax({
            url: "/download/create_checkout",
            type: 'POST',
            data: {id: id},
            success: function(){
            var h6 = $("<h6 id='magazine_checkout'></h6>");
            var updated_h6 = h6.html(name);
            console.log(updated_h6);
            var img = $("<img id='trash_icon'></p>");
            img.attr('src', 'http://b.dryicons.com/images/icon_sets/symbolize_icons_set/png/128x128/trash.png');
            
            //trash icon here, you can click on it and destroy the checkout item
                
            // $('.basket').html(updated_h6);
            var updatemagazinecost = $('#basket').data('magazinecost', amount);
            var updatemagazinedata = $('#basket').data('magazinename', name);
            $('#basket').append(updated_h6);
            $('#basket').append(img);

                increaseSubtotal(amount);
            
            }
        });

	})//END add basket click

	//a function that calculated the updateSubtotal everytime something is added to the basket or removed from the bakset
    function increaseSubtotal(amount){
    	$('.subtotal').html('');
    	var current_subtotal = $('.subtotal').data('subtotal');
    	var updated_subtotal = current_subtotal + amount;
        //updating the subtotal data attribute in the DOM
    	var updatedsub = $('.subtotal').data('subtotal', updated_subtotal);
        var h6 = $("<h6>");
        //appending the updated subtotal to the DOM
        h6.html('£' + updated_subtotal);
        $('.subtotal').append(h6);
    }//END increaseSubtotal

    //a function that removes an item from the basket and then calls the updateSubtotal function

    $('#basket').on('click', function(){
        magazine_name = $(this).data('magazinename');
        magazine_cost = $(this).data('magazinecost');
        console.log(this);
        $(this).remove();
        //send an ajax request to the controller to destroy a checkout
        $.ajax({
            url: "/download/create_checkout",
            type: 'POST',
            data: {magazine_name: magazine_name},
            success: function(){
                decreaseSubtotal(magazine_cost);
            }
        });//END ajax

    })//END #basket onclick

    function decreaseSubtotal(magazine_cost){
        $('.subtotal').html('');
        var current_subtotal = $('.subtotal').data('subtotal');
        var updated_subtotal = current_subtotal - magazine_cost;
        //updating the subtotal data attribute in the DOM
        var updatedsub = $('.subtotal').data('subtotal', updated_subtotal);
        var h6 = $("<h6>");
        //appending the updated subtotal to the DOM
        h6.html('£' + updated_subtotal);
        $('.subtotal').append(h6);

    }

})//End DOM READY

    
	

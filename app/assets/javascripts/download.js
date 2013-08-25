$(document).ready(function(){

    //when a user signs in make sure that all their checkouts are deleted
	$('.add_to_basket').on('click', function(){

		//getting the cost of the magazine out of the data attributes
        var magazine_data = $(this).closest('.magazine_data');
        //getting the cost,name and id out of the magazine_data data attributes
		var amount = magazine_data.data('price');
		var name = magazine_data.data('name');
        var id = magazine_data.data('id');

        //send an ajax request to the controller to make a new checkout
        $.ajax({
            url: "/download/create_checkout",
            type: 'POST',
            data: {id: id},
            success: function(){
            //put the magazine name and trash icon in a container so they can be removed together
            var wrapper_div = $("<div class='wrapper' data-cost='"+amount+"'></div>");
            var h6 = $("<h6 class='magazine_checkout'></h6>");
            var updated_h6 = h6.html(name);
            var img = $("<img class='trash_icon'></p>");
            img.attr('src', 'http://b.dryicons.com/images/icon_sets/symbolize_icons_set/png/128x128/trash.png');
            updated_h6.append(img);
            wrapper_div.append(updated_h6);
            $('#basket').append(wrapper_div);
            increaseSubtotal(amount);

            //trash icon here, you can click on it and destroy the checkout item
            
            $(wrapper_div).find('.trash_icon').on('click', function(){
                magazine_name = $(this).prev().text();
                console.log(magazine_name);
                amount = $(this).closest('.wrapper').data('cost');
                console.log(amount);
                $.ajax({
                    url: "/download/create_checkout",
                    type: 'POST',
                    data: {magazine_name: magazine_name},
                    success: function(){
                    decreaseSubtotal(amount);
                    }
                 });//END ajax
                $(this).parent().fadeOut();
            });//END trash_icon on_click
            
            
            }
        });//END AJAX

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


    function decreaseSubtotal(amount){
        $('.subtotal').html('');
        var current_subtotal = $('.subtotal').data('subtotal');
        console.log(current_subtotal);
        var updated_subtotal = current_subtotal - amount;
        console.log(updated_subtotal);
        //updating the subtotal data attribute in the DOM
        var updatedsub = $('.subtotal').data('subtotal', updated_subtotal);
        var h6 = $("<h6>");
        //appending the updated subtotal to the DOM
        h6.html('£' + updated_subtotal);
        $('.subtotal').append(h6);

    }

})//End DOM READY

    
	

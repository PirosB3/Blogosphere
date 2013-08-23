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
            wrapper_div.append(updated_h6)
                       .append(img);
            $('#basket').append(wrapper_div);

            //trash icon here, you can click on it and destroy the checkout item
                
            // $('.basket').html(updated_h6);
            var updatemagazinecost = $('#basket').data('magazinecost', amount);
            var updatemagazinedata = $('#basket').data('magazinename', name);
                $('.trash_icon').on('click', function(){
                    magazine_name = $(this).prev().text();
                    // magazine_cost = $('#basket').data('magazinecost');
                });
            
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
    $('.wrapper').on('click', function(){
        magazine_name = $(this).prev().text();
        // alert(hello);
        // console.log(this);
        // console.log(this.parent());
        // magazine_name = $(this).data('magazinename');
        // magazine_cost = $(this).data('magazinecost');
        // console.log(this);
        // $(this).remove();
        // //send an ajax request to the controller to destroy a checkout
        // $.ajax({
        //     url: "/download/create_checkout",
        //     type: 'POST',
        //     data: {magazine_name: magazine_name},
        //     success: function(){
        //         decreaseSubtotal(magazine_cost);
        //     }
        // });//END ajax

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

    
	

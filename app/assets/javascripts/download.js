// Because underscore templates clash with Rails templates, let's change the template settings to use {{= }} and {{ }}
_.templateSettings = {
    interpolate: /\{\{\=(.+?)\}\}/g,
    evaluate: /\{\{(.+?)\}\}/g
};

$(document).ready(function(){
    
    // Define some constants, no need to call them multiple times.
    var CART_TEMPLATE = _.template($('#cart-template').html());
    var BASKET = $('#basket');
    var SUBTOTAL = $('.subtotal');
    var CHECKOUT = $('.payment_checkout');
    
    // This function calls the backend and populates the cart
    var getCartDataAndPopulatePage = function() {
      $.ajax({
        url: '/cart',
        type:'GET', 
        dataType: "json", 
        success: function(data) {

          // Unbind all click handlers, we will re-bind them later.
          // This avoids zombies
          $('.trash_icon').unbind('click');

          // Empty the basket element, as we are using append and this function
          // gets called multiple times, we can potentially have duplicates
          BASKET.empty()
          data.forEach(function(el){

            // Compile the template with the args coming from XHR request
            var full_cart = CART_TEMPLATE({
              name: el.name,
              price: el.price,
              id: el.id
            });

            // Append them to the DOM
            BASKET.append(full_cart);
          });

          // Pull out the price key from each object (hash) in  our array
          // and sum them together
          var prices = _.pluck(data, 'price');
          var result = _.reduce(prices, function(starting_value, number){
            return starting_value + number;
          }, 0);

          // Append the result to the subtotal elememet
          SUBTOTAL.text('SUBTOTAL: £' + result);
          
          var magazine_type = CHECKOUT.data('type');
          var checkout_link = $("<form name='input' action='/charges/new' method='post'><input type='submit' value='proceed to checkout' id='checkout_button'><input type='hidden' name='subtotal' value='"+result+"'><input type='hidden' name='type' value='"+magazine_type+"'></form>"); 
          $('.payment_checkout').html(checkout_link);


          // As jQuery.live() is deprecated, we need to re-bind the click
          // event on every new trash_icon
          $('.trash_icon').on('click', function() {
            var wrapper = $(this).parent('.wrapper')
            var id = wrapper.data('magazine-id')
            destroyCartItem(id);
          });
        }
      })
    };

    var destroyCartItem = function(id) {
      var url = '/cart/' + id;
      $.ajax({
        url: url,
        type:'DELETE',
        dataType:'json', 
        success: getCartDataAndPopulatePage
      });
    }
    
    var addCartItem = function(id) {
      $.ajax({
        url: '/cart',
        type:'POST',
        dataType:'json', 
        data: {id:id},
        success: getCartDataAndPopulatePage
      });
    }

    
    $('.add_to_basket').on('click', function(){
      var magazine_data = $(this).closest('.magazine_data');
      var id = magazine_data.data('id');
      addCartItem(id); 
    });

    // Once the document is ready, fetch the cart data from the database
    getCartDataAndPopulatePage();
});

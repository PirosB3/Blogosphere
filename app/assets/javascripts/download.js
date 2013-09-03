_.templateSettings = {
    interpolate: /\{\{\=(.+?)\}\}/g,
    evaluate: /\{\{(.+?)\}\}/g
};

$(document).ready(function(){
    
    var CART_TEMPLATE = _.template($('#cart-template').html());
    var BASKET = $('#basket');
    var SUBTOTAL = $('.subtotal');
    
    var getCartDataAndPopulatePage = function() {
      $.ajax({
        url: '/cart',
        type:'GET', 
        dataType: "json", 
        success: function(data) {
          BASKET.empty()
          data.forEach(function(el){
            var full_cart = CART_TEMPLATE({
              name: el.name,
              price: el.price,
              id: el.id
            });
            BASKET.append(full_cart);
          });
          var prices = _.pluck(data, 'price');
          var result = _.reduce(prices, function(starting_value, number){
            return starting_value + number;
          }, 0);
          SUBTOTAL.text('SUBTOTAL: £' + result);
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

    getCartDataAndPopulatePage();
});

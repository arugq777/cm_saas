$(document).ready(function(){
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
  //set up an event to watch for form submission
  $('.form-submit-btn').click(function(event){ 
    event.preventDefault();
    $('input[type=submit]').prop('disabled', true);
    var error = false;
      //get the stripe token
    var card = {
      number: $('#card_number').val(), 
      cvc: $('#card_code').val(), 
      exp_month: $('#card_month').val(), 
      exp_year: $('#card_year').val()
      };
    Stripe.createToken(card, stripeResponseHandler);
    return false;
  }); //form submission

  function stripeResponseHandler(status, response){ 
    //get a reference to the form
    var f = $('.pro_form');

    //get the token from the response
    var token = response.id;

    //Add token to the form:
    f.append($("<input type='hidden' name='user[stripe_card_token]'/>").val(token));

    //Submit form
    f.get(0).submit();
  }
});
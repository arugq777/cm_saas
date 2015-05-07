$(document).ready(function(){
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
  $('.pro_form').submit( function(event){
    stripeFormSubmit(event);
  });

  function stripeFormSubmit(event){
    event.preventDefault();
    $('.form-submit-btn').prop("disabled", true);
    Stripe.card.createToken({
      number: $('#card_number').val(),
      cvc: $('#card_code').val(),
      exp_month: $('#card_month').val(),
      exp_year: $('#card_year').val()
    }, stripeResponseHandler);
    return false;    
  }

  function stripeResponseHandler(status, response){ 
    //get a reference to the form
    var $f = $('.pro_form');
    
    //Add token to the form:
    $f.find('#hidden-token').val( response.id );
    alert("stripe token:" + $f.find('#hidden-token').val());
    //Submit form
    $f.get(0).submit();
  }
});
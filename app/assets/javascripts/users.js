$(document).ready(function(){
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
  resetListeners();
  //set up an event to watch for form submission
  // $('.pro_form').submit(function(event){ 
  //   var $form = $(this);
  //   event.preventDefault();
  //   $('.form-submit-btn').prop('disabled', true);
  //   Stripe.card.createToken({
  //     number: $('#card_number').val(),
  //     cvc: $('#card_code').val(),
  //     exp_month: $('#card_month').val(),
  //     exp_year: $('#card_year').val()
  //   }, stripeResponseHandler);

  //   return false;
  // }); //form submission

  function resetListeners(){
    $( "#pro_form" ).off();
    $( "#pro_upgrade_form" ).off();

    $('#pro_form').submit( function(event){
      stripeFormSubmit(event);
    });

    $('#pro_upgrade_form').submit(function(event){
      stripeFormSubmit(event);
    });
    //alert("reset");
  }

  function stripeFormSubmit(event){
    //alert(event);
    event.preventDefault();
    $('.form-submit-btn').prop("disabled", true);
    Stripe.card.createToken({
      number: $('#card_number').val(),
      cvc: $('#card_code').val(),
      exp_month: $('#card_month').val(),
      exp_year: $('#card_year').val()
    }, stripeResponseHandler);
    resetListeners();
    //return false;    
  }

  function stripeResponseHandler(status, response){ 
    //get a reference to the 
    var $f = $('.pro_form');
    //get the token from the response
    //Add token to the form:
    $f.find('#hidden-token').val( response.id );
    alert($f.find('#hidden-token').val());
    //Submit form
    $f.get(0).submit();
  }
});
$(document).ready(function() {
  $('form').submit(function(e){
      e.preventDefault();
      $('#load').show();
      $('#tweets').empty();
      $.ajax({
        url: '/tweet',
        type: 'post',
        data: $(this).serialize()
      })
      .done(function(server_response) {
      $('#load').hide();
        $('#tweets').html("Your tweet has been posted!!");
      })
      .fail(function() {
        console.log("error");
      })
      .always(function() {
        console.log("complete");
      });
    });
});

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
        console.log(server_response)
      $('#load').hide();
        $('#tweets').html(server_response);
      })
      .fail(function() {
        console.log("Something didn't go right");
      })
      .always(function() {
        console.log("complete");
      });
    });
});

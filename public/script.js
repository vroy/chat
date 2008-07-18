$(document).ready(function() {
  
  setInterval(function() {
    var initial = $('#messages').val();
    
    $.get("messages", { number: 2 }, function(data){
      if (initial != data) {
        $('#messages').val(data).css('color', 'red');
        
        setTimeout(function() {
          $('#messages').css('color', 'black');
        }, 500);
      }
    });
  }, 3000);
  
});


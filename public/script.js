$(document).ready(function() {
  
  function reload() {
    var initial = $('#messages').val();
    
    $.get("messages", { number: 2 }, function(data){
      if (initial != data) {
        $('#messages').val(data).css('color', 'red');
        
        setTimeout(function() {
          $('#messages').css('color', 'black');
        }, 500);
      }
    });
  }
  
  $("#refresh").click(function() {
    reload();
  });
  
  setInterval(function() {
    reload();
  }, 3000);
  
});


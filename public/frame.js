$(document).ready(function() {
  
  function reload() {
    $.getJSON("messages", { 'last': $("#last").val() }, function(data) {
      $("#last").val(data["last"]);
      $("#messages").before(data["str"]);
      
      $.scrollTo( $("#end") , 800 );

      
      
    });
  }
  
  setInterval(function() {
    reload();
  }, 3000);
  
  reload();
  
});



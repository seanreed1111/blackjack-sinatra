$(document).ready(function(){
  $("#player1").on("click", function(){
    $(this).toggle();
  });


  $("#player2").on("click", function(){
    $(this).transition({x:+550,y:-700});
  });
});
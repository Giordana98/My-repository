function vai_a_destra(){
$("#quadrato").removeClass("top-left");
$("#quadrato").addClass("top-right");
}
function vai_a_sinistra() {
$("#quadrato").removeClass("top-right");
$("#quadrato").addClass("top-left");
}

function quando clicki(){
  if($("#quadrato").hasClass("top-left")) {
    $("#quadrato").removeClass("top-left")
    $("#quadrato").removeClass("top-right");
  } else if ($("#quadrato").hasClass("top-right")) {
    $("#quadrato").removeClass("top-right").addClass("bottom-right")
  } else if ($("#quadrato").hasClass("bottom-right"))  {
    $("#quadrato").removeClass("bottom-right").addClass("bottom-left")
  } 




$/"#quadrato").on("click", quando_clicki)

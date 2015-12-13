function fatlight(fat,light) {
  document.getElementById(fat).style.fontWeight = "bold";
  document.getElementById(fat).style.textDecoration = "underline";
  document.getElementById(light).style.fontWeight = "normal";
  document.getElementById(light).style.textDecoration =  "none";
}

function replace(show,hide,fat,light) {
  stopsound();
  document.getElementById(show).style.display = "inline";
  document.getElementById(hide).style.display = "none";
  fatlight(fat,light);
}

function qachange(valon,valoff,qaon,fat,light) {
  playsound();
  document.getElementById(valon).style.display = "inline";
  document.getElementById(valoff).style.display = "none";
  document.getElementById(qaon).style.display = "inline";
  document.getElementById("ergrot").style.display = "none";
  document.getElementById("erggruen").style.display = "none";
  document.getElementById("erggelb").style.display = "none";
  document.getElementById("ergblau").style.display = "none";
  fatlight(fat,light);
}

function antwortaus(antwort) {
  stopsound();
  document.getElementById(antwort).style.display = "none";
  document.getElementById("ergrot").style.display = "inline";
  document.getElementById("erggruen").style.display = "inline";
  document.getElementById("erggelb").style.display = "inline";
  document.getElementById("ergblau").style.display = "inline";
}

function points(answer,group,value,off,offcolor) {
  stopsound();
  document.getElementById(answer).style.display = "none";
  document.getElementById("ergrot").style.display = "inline";
  document.getElementById("erggruen").style.display = "inline";
  document.getElementById("erggelb").style.display = "inline";
  document.getElementById("ergblau").style.display = "inline";
  document.getElementById(off).style.color = offcolor;
  valueold = eval(window.document.getElementById(group).value);
  valuenew = eval(value);
  result = eval(valuenew + valueold);
  document.getElementById(group).value = result;
}

function reset(zeige,verstecke,frage,antwort) {
  document.getElementById(zeige).style.display = "inline";
  document.getElementById(verstecke).style.display = "none";
  document.getElementById(antwort).style.display = "inline";
  document.getElementById(frage).style.display = "none";
}

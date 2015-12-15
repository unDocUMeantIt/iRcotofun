var allPoints = new Array("punkterot","punktegruen","punktegelb","punkteblau");

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

function getgroupnames(r,g,y,b) {
  var nr = document.getElementById("namerot").value;
  var ng = document.getElementById("namegruen").value;
  var ny = document.getElementById("namegelb").value;
  var nb = document.getElementById("nameblau").value;
  document.getElementById(r).value = nr;
  document.getElementById(g).value = ng;
  document.getElementById(y).value = ny;
  document.getElementById(b).value = nb;
}

function blink(on){
  for (var i in allPoints) {
    if(allPoints[i] === on){
      document.getElementById(allPoints[i]).className += " blink";
    } else {
      document.getElementById(allPoints[i]).className = document.getElementById(allPoints[i]).className.replace(/(?:^|\s)blink(?!\S)/g,'');
    }
  }
}

// our random group selector with a lot of bling-bling
function blinkrandom(){
  var randgroup = Math.floor(Math.random() * 4);
  blink(allPoints[randgroup]);
}

function qachange(valon,valoff,qaon,fat,light,r,g,y,b) {
  playsound();
  document.getElementById(valon).style.display = "inline";
  document.getElementById(valoff).style.display = "none";
  document.getElementById(qaon).style.display = "inline";
  document.getElementById("ergrot").style.display = "none";
  document.getElementById("erggruen").style.display = "none";
  document.getElementById("erggelb").style.display = "none";
  document.getElementById("ergblau").style.display = "none";
  document.getElementById("namespanrot").style.display = "none";
  document.getElementById("namespangruen").style.display = "none";
  document.getElementById("namespangelb").style.display = "none";
  document.getElementById("namespanblau").style.display = "none";
  document.getElementById("randomgroup").style.display = "none";
  fatlight(fat,light);
  getgroupnames(r,g,y,b);
}

function antwortaus(antwort) {
  stopsound();
  document.getElementById(antwort).style.display = "none";
  document.getElementById("ergrot").style.display = "inline";
  document.getElementById("erggruen").style.display = "inline";
  document.getElementById("erggelb").style.display = "inline";
  document.getElementById("ergblau").style.display = "inline";
  document.getElementById("namespanrot").style.display = "inline";
  document.getElementById("namespangruen").style.display = "inline";
  document.getElementById("namespangelb").style.display = "inline";
  document.getElementById("namespanblau").style.display = "inline";
  document.getElementById("randomgroup").style.display = "inline";
  blink("off");
}

function points(answer,group,value,off,offcolor,active) {
  stopsound();
  document.getElementById(answer).style.display = "none";
  document.getElementById("ergrot").style.display = "inline";
  document.getElementById("erggruen").style.display = "inline";
  document.getElementById("erggelb").style.display = "inline";
  document.getElementById("ergblau").style.display = "inline";
  document.getElementById("namespanrot").style.display = "inline";
  document.getElementById("namespangruen").style.display = "inline";
  document.getElementById("namespangelb").style.display = "inline";
  document.getElementById("namespanblau").style.display = "inline";
  document.getElementById("randomgroup").style.display = "inline";
  document.getElementById(off).style.color = offcolor;
  valueold = eval(window.document.getElementById(group).value);
  valuenew = eval(value);
  result = eval(valuenew + valueold);
  document.getElementById(group).value = result;
  blink(active);
}

function wrong(group,value,offp,offn) {
  valueold = eval(window.document.getElementById(group).value);
  valuenew = eval(value);
  result = eval(valueold - valuenew);
  document.getElementById(group).value = result;
  document.getElementById(offp).style.display = "none";
  document.getElementById(offn).style.display = "none";
}

function reset(zeige,verstecke,frage,antwort,rp,gp,yp,bp,rn,gn,yn,bn) {
  document.getElementById(zeige).style.display = "inline";
  document.getElementById(verstecke).style.display = "none";
  document.getElementById(antwort).style.display = "inline";
  document.getElementById(frage).style.display = "none";
  document.getElementById(rp).style.display = "inline";
  document.getElementById(gp).style.display = "inline";
  document.getElementById(yp).style.display = "inline";
  document.getElementById(bp).style.display = "inline";
  document.getElementById(rn).style.display = "inline";
  document.getElementById(gn).style.display = "inline";
  document.getElementById(yn).style.display = "inline";
  document.getElementById(bn).style.display = "inline";
  blink("off");
}

// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket from "./socket"
import * as pip from "phx_in_place"

let channel = socket.channel("pip:demo", {})

channel.join()
  .receive("ok", resp => {
    console.log("Joined successfully", resp);
  })
  .receive("error", resp => { console.log("Unable to join", resp) });

pip.addListeners(channel);

document.addEventListener('pip:update:success', function (e) {
     push_row_update(e.target);
 }, false);

document.addEventListener('pip:update:error', function (e) {
    showErrorMessage(`unable to update field. please try again`);
}, false);

// channel.on("pip:update:error", response => {
//   showErrorMessage(`error: ${response.msg}`);
// });
//
// channel.on("pip:update:success", response => {
//   console.log("pip:update:success received");
//   // showErrorMessage(`error: ${response.msg}`);
// });

 // Takes the id for the record to be updated and a rowType value that matches to the name of the partial to be updated and returns the html to be inserted into the page
function push_row_update(target){
  console.log('attempting row update');
  let tr = target.closest("tr")
  let id = tr.getAttribute("data-id");
  if(tr.classList.contains('updated')) {
    let newone = tr.cloneNode(true);
    tr.parentNode.replaceChild(newone, tr);
  }
  // let rowType = target.closest("tr").className;
  channel.push("row_update", {"row_type": "product_row", "id": id})
  .receive("ok", resp => {
    console.log("updateRow successful: ", resp);
    updateRow(resp);
  })
  .receive("error", msg => {
    console.warn("updateRow Error: ", msg);
  });
}

// replaces row content with the html returned from the server
function updateRow(payload){
  let tr = document.querySelector(`tr#product_${payload["product_id"]}`);
  tr.innerHTML = '';
  tr.classList.add('updated');
  tr.innerHTML = payload["html"];
}

function showErrorMessage(message){
    let el = document.querySelector("#error-message-container")
    el.innerHTML = `<p>${message}</p>`;
    fadeIn(el);
    setTimeout(function(){
      fadeOut(el);
    }, 5000);
}

// fade out
function fadeOut(el){
  el.style.opacity = 1;

  (function fade() {
    if ((el.style.opacity -= .1) < 0) {
      el.style.display = "none";
    } else {
      requestAnimationFrame(fade);
    }
  })();
}

// fade in
function fadeIn(el, display){
  el.style.opacity = 0;
  el.style.display = display || "block";

  (function fade() {
    var val = parseFloat(el.style.opacity);
    if (!((val += .1) > 1)) {
      el.style.opacity = val;
      requestAnimationFrame(fade);
    }
  })();
}

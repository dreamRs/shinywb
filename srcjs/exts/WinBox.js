import $ from "jquery";
import "shiny";
import WinBox from "winbox/src/js/winbox";
import "winbox/dist/css/winbox.min.css";

let winboxes = {};

Shiny.addCustomMessageHandler("WinBox-show", (msg) => {
  var options = msg.options;
  options.html = `<div id="shiny-winbox-${options.id}"></div>`;
  options.root = document.body;
  var winbox = new WinBox(options);
  var $content = $("#shiny-winbox-" + options.id);
  Shiny.renderContent($content, { html: msg.html, deps: msg.deps });
  winbox.body.innerHTML = msg.html;
  winboxes[winbox.id] = winbox;
})

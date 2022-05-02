import $ from "jquery";
import "shiny";
import WinBox from "winbox/src/js/winbox";
import "winbox/dist/css/winbox.min.css";

let winboxes = {};

Shiny.addCustomMessageHandler("WinBox-show", msg => {
  var options = msg.options;
  options.html = `<div id="shiny-winbox-${options.id}"></div>`;
  options.onclose = function() {
    Shiny.unbindAll($content);
  };
  options.onresize = function(width, height) {
    $("#shiny-winbox-" + options.id)
      .find(".html-widget, .shiny-plot-output")
      .trigger("resize");
  };
  if (winboxes.hasOwnProperty(options.id)) {
    winboxes[options.id].close();
  }
  var winbox = new WinBox(options);
  var $content = $("#shiny-winbox-" + options.id);
  Shiny.renderContent($content, { html: msg.html, deps: msg.deps });
  //winbox.body.innerHTML = msg.html;
  winboxes[winbox.id] = winbox;
});

Shiny.addCustomMessageHandler("WinBox-close", msg => {
  if (msg.hasOwnProperty("id")) {
    if (winboxes.hasOwnProperty(msg.id)) {
      winboxes[msg.id].close();
      delete winboxes[msg.id];
    }
  } else {
    if (winboxes.length > 0) {
      var last = winboxes.at(-1);
      winboxes[last].close();
      delete winboxes[last];
    }
  }
});


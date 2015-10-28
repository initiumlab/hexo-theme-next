(function (window, document) {
  "use strict";

  var i;

  // Track clicking on rss button
  var btnRss = document.getElementById('rssText');
  btnRss.addEventListener('click', function (event) {
    ga('send', 'event', 'rss-button', 'click');
  });

  // Track toggling sidebar
  var btnSidebarToggle = document.getElementsByClassName('sidebar-toggle-line-wrap')[0];
  btnSidebarToggle.addEventListener('click', function (event) {
    ga('send', 'event', 'side-bar-toggle', 'click');
  });

  // Track anchors
  var tocAnchors = document.querySelectorAll('.nav li.nav-item');
  for (i = 0; i < tocAnchors.length; i += 1) {
    tocAnchors[i].addEventListener('click', function (event) {
      ga('send', 'event', 'toc-item', 'click', document.title, event.target.textContent);
      console.log(['send', 'event', 'toc-item', 'click', document.title, event.target.textContent]);
    })
  }

} (window, window.document))

{% if theme.social_bar %}
  <script type="text/javascript" src="{{ url_for(theme.js) }}/qrcode.js"></script>
  <script defer type="text/javascript" src="{{ url_for(theme.js) }}/social_bar.js"></script>
{% endif %}
{% macro render(page, renderMode) %}
  <div class='caseEntry'>
    <a id='anchor-{{page.projectCode}}'
       href='{{page.projectMainWebsite}}'
       class='no-fancy showcase-anchor'
       data-projectcode={{page.projectCode}}>
      <img class='caseCover no-fancy' src={{page.coverPath}} alt={{page.coverAlt}} />
    </a>
    <h2 class="caseHeading">
      {{page.title}}
    </h2> 
  </div>
  
  {% if renderMode === 'markdown' %}
  <div class='lightbox' id='lightbox-{{page.projectCode}}'>
    <div class="lightbox-btnClose" id="btnClose-{{page.projectCode}}">
      &#x2573;
    </div>
    <div class="lightbox-innerBox">
        <h1>{{page.title}}</h1>
        <time>{{page.byline}}</time>
        <div class="lightbox-description">
          {{page.content}}
        </div>
        {% if page.images.length > 0 %}
        <div class="imageBox">
          {% for image in page.images %}
            <img src={{image.src}} alt={{image.alt}} class="no-fancy" />
          {% endfor %}
        </div>
        {% endif %}
        {% include '../_partials/share/social_bar.swig' %}
    </div>
  </div>
  {% endif %}

  {% if renderMode === 'html' %}
  {{page.raw.slice(page.raw.indexOf('---') + 3)}}
  {% endif %}
{% endmacro %}

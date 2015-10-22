{% macro render(page, renderMode) %}
  <div class='caseEntry'>
    <a id='anchor-{{page.projectCode}}'
       href='{{page.projectMainWebsite}}'
       class='no-fancy showcase-anchor'
       data-projectcode={{page.projectCode}}>
      <img class='caseCover' src={{page.coverPath}} alt={{page.coverAlt}} />
    </a>
    <h2 class="caseHeading">
      {{page.title}}
    </h2> 
  </div>

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
        <div class="imageBox">
          {% for image in page.images %}
            <img src={{image.src}} alt={{image.alt}} />
          {% endfor %}
        </div>
        {% include '../_partials/share/social_bar.swig' %}
    </div>
  </div>
{% endmacro %}
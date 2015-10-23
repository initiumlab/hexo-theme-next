{% extends '_layout.swig' %}
{% import '_macro/post.swig' as post_template %}
{% import '_macro/sidebar.swig' as sidebar_template %}
{% import '_macro/showcase.swig' as showcase_template %}

{% block title %} {{ config.title }} {% endblock %}

{% block page_class %}
  {% if is_home() %} page-home {% endif %}
{% endblock %}

{% block content %}
  {% include '_partials/logo.swig' %}
  {% include '_partials/quote.swig' %}

  <section id="works">
    <div class='subtitle' id="titleWorks">
      Recent works
    </div>

    <div id="showcase">
      {% for page in site.pages %}
        {% if page.layout === 'showcase' %}
          {{ showcase_template.render(page, page.renderMode) }}
        {% endif %}
      {% endfor %}
    </div>
  </section>

  <div id='posts-homepage-wrapper'>
    <section id="posts" class="posts-expand">
      <div class='subtitle' id='titleBlogs'>
        >> Recent blogs
      </div>
      {% for post in page.posts %}
        {{ post_template.render(post, true) }}
      {% endfor %}
    </section>
  </div>

  {% include '_partials/pagination.swig' %}
  {% include '_scripts/home_script.swig' %}
{% endblock %}

{% block sidebar %}
  {{ sidebar_template.render(false) }}
{% endblock %}
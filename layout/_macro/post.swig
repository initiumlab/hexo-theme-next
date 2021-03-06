{% macro render(post, is_index, post_extra_class, force_auto_excerpt) %}

  <article class="post post-type-{{ post.type | default('normal') }} {{ post_extra_class | default('') }}" itemscope itemtype="http://schema.org/Article">
    <header class="post-header">
      <div style="display: none">
        <img src="{{post.thumbnail}}" alt="thumbnail for the page"
             class="thumbnail no-fancy"
             style="visibility: hidden; width: 1px; height: 1px; margin: 0;" />
      </div>

      {# Not to show title for quote posts that do not have a title #}
      {% if not (is_index and post.type === 'quote' and not post.title) %}
        <h1 class="post-title" itemprop="name headline">
          {# Link posts #}
          {% if post.link %}
            <a class="post-title-link post-title-link-external" target="_blank" href="{{ url_for(post.link) }}" itemprop="url">
              {{ post.title or post.link }}
              <i class="icon-external-link"></i>
            </a>
          {% else %}
            {% if is_index %}
              <a class="post-title-link" href="{{ url_for(post.path) }}" itemprop="url">
                {{ post.title | default(__('post.untitled'))}}
              </a>
            {% else %}
              {{ post.title }}
            {% endif %}
          {% endif %}
        </h1> <!-- h1.post-title -->
      {% endif %}

      <div class="post-meta">

        <div class="post-time">
          <time itemprop="dateCreated" datetime="{{ moment(post.date).format() }}" content="{{ date(post.date, config.date_format) }}">
            {{ date(post.date, config.date_format) }}
          </time>
        </div>

        <div class="post-name">
          <p class="author-info">
          {% for author in post.author %}
             
              {% if author.url %}
                <a href={{author.url}}>
                  <span>{{author.name}}</span>
                </a>
              {% else %}
                <span>{{author.name}}</span>
              {% endif %}

          {% endfor %}
          </p>
        </div>

        <div class='post-tags'>
            {% for tag in post.tags %}
            <div class='post-tag-item'>
              <a href={{'"' + '/tags/'+ tag.name.replace(':', '-') + '/' + '"'}}
                 class='anchor-tag'>
                {{tag.name}}
                </a>
            </div>
            {% endfor %}
          </ul>
        </div>

        {% if post.categories and post.categories.length %}
          <span class="post-category" >
            &nbsp; | &nbsp; {{ __('post.in') }}
            {% for cat in post.categories %}
              <span itemprop="about" itemscope itemtype="https://schema.org/Thing">
                <a href="{{ url_for(cat.path) }}" itemprop="url" rel="index">
                  <span itemprop="name">{{ cat.name }}</span>
                </a>
              </span>

              {% set cat_length = post.categories.length %}
              {% if cat_length > 1 and loop.index !== cat_length %}
                {{ __('symbol.comma') }}
              {% endif %}

            {% endfor %}
          </span>
        {% endif %}

      </div> <!-- post-meta -->

    </header>

    <div class="post-body">

      {# Gallery support #}
      {% if post.photos and post.photos.length %}
        <div class="post-gallery" itemscope itemtype="http://schema.org/ImageGallery">
          {% set COLUMN_NUMBER = 3 %}
          {% for photo in post.photos %}
            {% if loop.index0 % COLUMN_NUMBER === 0 %}<div class="post-gallery-row">{% endif %}
              <a class="post-gallery-img fancybox"
                 href="{{ url_for(photo) }}" rel="gallery_{{ post._id }}"
                 itemscope itemtype="http://schema.org/ImageObject" itemprop="url">
                <img src="{{ url_for(photo) }}" itemprop="contentUrl"/>
              </a>
            {% if loop.index0 % COLUMN_NUMBER === 2 %}</div>{% endif %}
          {% endfor %}

          {# Append end tag for `post-gallery-row` when (photos size mod COLUMN_NUMBER) is less than COLUMN_NUMBER #}
          {% if post.photos.length % COLUMN_NUMBER > 0 %}</div>{% endif %}
        </div>
      {% endif %}

      {% if is_index %}
        {% if force_auto_excerpt %}
          {{ post.excerpt }}
          <div class="post-more-link text-center">
            <a class="btn" href="{{ url_for(post.path) }}{% if theme.scroll_to_more %}{% endif %}" rel="contents">
              {{ __('post.read_more') }} &raquo;
            </a>
          </div>
        {% elif post.description %}
          <span itemprop="description">{{ post.description }}</span>
          <div class="post-more-link text-center">
            <a class="btn" href="{{ url_for(post.path) }}">
              {{ __('post.read_more') }} &raquo;
            </a>
          </div>
        {% elif post.excerpt %}
          {{ post.excerpt }}
          <div class="post-more-link text-center">
            <a class="btn" href="{{ url_for(post.path) }}{% if theme.scroll_to_more %}{% endif %}" rel="contents">
              {{ __('post.read_more') }} &raquo;
            </a>
          </div>
        {% elif theme.auto_excerpt.enable %}
          <span itemprop="articleBody">
            {% set content = post.content | striptags %}
            {{ content.substring(0, theme.auto_excerpt.length) }}
            {% if content.length > theme.auto_excerpt.length %}...{% endif %}
          </span>
          <div class="post-more-link text-center">
            <a class="btn" href="{{ url_for(post.path) }}{% if theme.scroll_to_more %}{% endif %}" rel="contents">
              {{ __('post.read_more') }} &raquo;
            </a>
          </div>
        {% else %}
          <span itemprop="articleBody">{{ post.content }}</span>
        {% endif %}
      {% else %}
        <span itemprop="articleBody">{{ post.content }}</span>
      {% endif  %}
    </div>

    <footer class="post-footer">
    </footer>
  </article>

{% endmacro %}

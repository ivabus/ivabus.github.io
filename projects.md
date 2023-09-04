---
layout: default
title: "Projects"
---

<div>
  <h1 style="font-size: 24px; margin-bottom: 4px;">Projects</h1>
  <div id="blog-archives">
    {% for project in site.projects reversed %}
      {% if project.participant == true %}
        {% continue %}
      {% endif %}
      <article class="post">
          <h2 style="font-size: 12pt; margin: 0 0 0 0;"><a href="{{ project.url }}">{{ project.title }}{% if project.description %} - {{ project.description }} {% endif %}</a></h2>
      </article>
    {% endfor %}
  <!--
  <h1 style="font-size: 24px; margin-bottom: 4px;">Participating</h1>
   {% for project in site.projects reversed %}
      {% if project.participant == false %}
        {% continue %}
      {% endif %}
      <article class="post">
        {% if project.external-url %}
          <h1>
            <a href="{{ project.external-url }}">{{ project.title }}</a> 
            <a class="anchor" href="{{ project.url }}"><i class="icon-anchor"></i></a>
          </h1>
        {% else %}
          <h1><a href="{{ project.url }}">{{ project.title }}{% if project.description %} - {{ project.description }} {% endif %}</a></h1>
        {% endif %}
      </article>
    {% endfor %}
    -->
  </div>
</div>
---
layout: default
title: Ivan Bushchik
---

{% include_relative abouttext.md %}

<div>
  <h1 style="font-size: 24px; margin-bottom: 0;">Recent posts</h1>
  <div id="blog-archives">
    {% for post in site.posts limit:5 %}
      <article class="post" style="margin-top: 5px;">
          <h2 style="font-size: 14pt; margin: 0 0 0 0;"><a href="{{ post.url }}">{{ post.title }}</a></h2>
          <p class="meta"><span class="postdate">{{ post.date | date: "%b %d, %Y" }}</span></p>
          {% if post.summary %}
            <p>{{ post.summary }}</p>
          {% endif %}
          {% if post.img %}
            <img src="{{ post.img }}" width=600 />
          {% endif %}
      </article>
    {% endfor %}
  </div>
</div>
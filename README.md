# R for Information Studies 

This website contains a few projects for those interesting in learning the R
programming language for Information Studies. These projects are intended for 
those of at all skill levels. No programming experience is required!

Before starting any of the weekly activates, make sure to visit the 
[quick start](/r-for-info-studies/quickstart.html) guide to install all of the 
necessary software to complete these projects!

## Weekly Activities
---
<ul>
  {% for post in site.posts %}
    <li>
      <a href="/r-for-info-studies/{{ post.url }}">{{ post.title }}</a>
    </li>
  {% endfor %}
</ul>

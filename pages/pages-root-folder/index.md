---
#
# Use the widgets beneath and the content will be
# inserted automagically in the webpage. To make
# this work, you have to use › layout: frontpage
#
layout: frontpage
permalink: /index.html
breadcrumb: true
header:
    title: R. Checa-Garcia webpage
    pattern: pattern_jquery-dark-grey-tile.png

widget1:
  title: "Research & Teaching"
  url: 'http://rchg.github.io/about/'
  image: research_clipart.jpg
  text: 'On the Research and Teaching have information about my background on both
  aspects of academic live, and also resources, code and publications.'
widget2:
  title: "Science & Computing"
  url: 'http://rchg.github.io/blog/science/'
  text: 'There are two parts related with my work: science mainly Earth Sciences and Computing because the main tool on my daily research involves simulations and models of the earth systems.'
  image: earth2.png
widget3:
  title: "Personal Blog"
  url: 'https://github.com/Phlow/feeling-responsive'
  image: review.jpg
  text: 'This part of my webpage has more personal information related with my hobbies, travels or interests: like sociology, environmental sciences, or social movements.'
widget4:
  title: "Open Letters"
  url: 'Public opinnions or communications.'
  text: 'Public opinnions or communications.'
  image: buho.png
#
# Use the call for action to show a button on the frontpage
#
# To make internal links, just use a permalink like this
# url: /getting-started/
#
# To style the button in different colors, use no value
# to use the main color or success, alert or secondary.
# To change colors see sass/_01_settings_colors.scss
#
#callforaction:
#  url: https://tinyletter.com/feeling-responsive
#  text: Inform me about new updates and features ›
#  style: alert
permalink: /index.html
---

<div id="videoModal" class="reveal-modal large" data-reveal="">
  <div class="flex-video widescreen vimeo" style="display: block;">
    <iframe width="1280" height="720" src="https://www.youtube.com/embed/3b5zCFSmVvU" frameborder="0" allowfullscreen></iframe>
  </div>
  <a class="close-reveal-modal">&#215;</a>
</div>

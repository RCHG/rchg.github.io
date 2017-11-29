---
layout: page
sidebar: right
subheadline: Tips
title: "Matplotlib Tips"
excerpt: "Matplotlib intro and tips"
teaser: "Matplotlib intro and tips"
breadcrumb: true
tags: [Scientific-computing, Visualization, Python]
categories:
    - computing-blog
header:
    title: "Matplotlib"
    pattern: pattern_jquery-dark-grey-tile.png
---



> This post has a list of tiny matplotlib tips. 

### How to Change the fonts

There are several possible directories where the matplotlib preference files are stored. In my Linux Distribution they are at */home/USER/.matplotlib*, therefore to see if a specific font is avaliable we could write in the terminal.

{% highlight bash %}
more .matplotlib/fontList.cache | grep Gentium
{% endhighlight %}

Because this file has the names on the fontList.cache of matplotlib then to choose one font, for example, *Gentium Basic* that we have checked that is in **fontList.cache**

{% highlight python %}
import matplotlib as mlp
mpl.rcParams['font.family'] = 'Gentium Basic'
{% endhighlight %}

Also this can be change directly in the matplotlib rc file. I recommend also take a look to the [matplotlib font API](http://matplotlib.org/api/font_manager_api.html).

### Plotting Time Series

Just an illustrative example on how to plot time series by including a date-time object.

{% highlight python %}
import matplotlib.dates as mdates

years = mdates.YearLocator()          # every year
months = mdates.MonthLocator()        # every month
yearsFmt = mdates.DateFormatter('%Y')

plt.plot(ts_time, ts_val, ls='-', alpha=0.9, ms=4,
        marker='o', lw=1.4)
                     
plt.gcf().autofmt_xdate()
plt.fmt_xdata = mdates.DateFormatter('%Y-%m-%d')
plt.gca().set_xlim(['1978-01-15 00:00:00','2015-01-15 00:00:00'])

plt.gca().xaxis.set_major_locator(years)
plt.gca().xaxis.set_major_formatter(yearsFmt)
plt.gca().xaxis.set_minor_locator(months)
    
plt.show()
{% endhighlight %}

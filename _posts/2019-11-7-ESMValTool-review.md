---
layout: page
sidebar: right
subheadline: Tips
title: "ESMValTool"
excerpt: "Step by Step "
teaser: "Notes to understand ESMValTool"
breadcrumb: true
tags: [climate-models, earth-system-models, python]
categories:
    - computing-blog
header:
    title: ESMValTool
    pattern: pattern_jquery-dark-grey-tile.png
---



This post have just notes about ESMValTool a little bit technical that I kept to understand it, and analyze
how I could help/collaborate with the project.

## Understading the code



### Design principles

After navigate in the code, and try to add few things, here are few remarks about how the code was created:

- Programed in **Python** (although add modules in R, NCL or Julia is possible for specific part of the workflow)
- It follows the **Object Oriented Programming style**
- The core of the code relies on **Iris Cubes**, a library from Met-Office.
- The configuration files are **YAML files** (.yml) so easy to read and visually understand.

#### Programmed in Python

By inspecting the core ESMValCore here is the very schematic intial workflow of the code once you execute an example

{% highlight bash %}
> esmvalcode myrecipe.yml
{% endhighlight %}

<img src='https://g.gravizo.com/svg?
 digraph G {
    size ="4,8";
    esmvaltool -> main_run -> main_main -> read_config_file -> create_work_dir -> process_recipe -> read_recipe -> run_the_recipe;
    main_main -> sanity_checks_recipe;
    read_config_file -> load_cmor_table;
 }
'/>

The actual calculations begin after *run-the-recipe* that is `recipe.run()` as run is a method of recipe. The other preliminary steps are just preparing the scenario. I have indicated that read-config-file, that actually creates an object named `cfg`, is loading the cmor-table (that is another object part of the `cfg` object). This step is relevant as much of the initial steps are related with ensure that the datasets used follows the CMOR and CF conventions (something also hightligthed by Iris Cube phylosophy) 












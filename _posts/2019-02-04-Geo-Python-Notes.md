---
layout: page
sidebar: right
subheadline: Tips
title: "Geo Python Notes"
excerpt: "Step by Step "
teaser: "collection of notes about python and geosciences"
breadcrumb: true
tags: [python, programming]
categories:
    - computing-blog
header:
    title: Geo Python Notes
    pattern: pattern_jquery-dark-grey-tile.png
---

<section id="table-of-contents" class="toc">
<div class="panel radius" markdown="1">
#### Table of Contents
{:.no_toc }
*  TOC
{:toc}
</div>
</section><!-- /#table-of-contents -->

Pieces of Python code in Geosciences
--------------------------------------


### Create a Land and Ocean Masks Filters

It is feasible to create a land-mask filter with Python based on the libraries:

- [geopandas](http://geopandas.org/)
- [rasterio](https://rasterio.readthedocs.io/en/stable/)
- [affine](https://github.com/sgillies/affine)
- [xarray](http://xarray.pydata.org/en/stable/)

The library **geopandas** is need to read the shape-polygonal files downloaded from [naturalearthdata](http://www.naturalearthdata.com/downloads/). The combination of **rasterio** and **affine** allow us to translate that information to pre-defined grids, for which I use the library xarray. Xarray is also used to save the output as netcdf file. 

{% highlight Python %}

import geopandas
from rasterio import features
from affine import Affine
import numpy as np
import xarray as xr

def transform_from_latlon(lat, lon):
    """Uses Affine method of affine library
    """
    lat = np.asarray(lat)
    lon = np.asarray(lon)
    trans = Affine.translation(lon[0], lat[0])
    scale = Affine.scale(lon[1] - lon[0], lat[1] - lat[0])
    
    return trans * scale

def rasterize(shapes, coords, fill=np.nan, **kwargs):
    """Rasterize a list of (geometry, fill_value) tuples onto the given
    xray coordinates. This only works for 1d latitude and longitude
    arrays.
    """
    transform = transform_from_latlon(coords['lat'], coords['lon'])
    out_shape = (len(coords['lat']), len(coords['lon']))
    raster = features.rasterize(shapes, out_shape=out_shape,
                                fill=fill, transform=transform,
                                dtype=float, **kwargs)
    return xr.DataArray(raster, coords=coords, dims=('lat', 'lon'))

def set_model(model=None):

    ds = xr.Dataset(coords={'lon': np.linspace(-180, 180, num=144),
                            'lat': np.linspace(-90, 90, num=143)})
    # If the grid is not so regular it might be better something
    # like:
    # f_model = 'modelgrid.nc'
    # ds_check = xr.open_dataset(f_model)
    # ds['lat']=ds_check['lat'].values
    # ds['lon']=ds_check['lon'].values
        
    name='land_ocean_masks_grid144x143.nc'

    return ds, name

# We need few files that could be downloaded at:
# http://www.naturalearthdata.com/downloads/
# here I am using those with higher resolution.

land = geopandas.read_file('ne_shapes/ne_10m_land.shp')
ocean = geopandas.read_file('ne_shapes/ne_10m_ocean.shp')

ds ,name = set_model(model)
ds['Land'] = rasterize(land.geometry, ds.coords)
ds['Ocean']= rasterize(ocean.geometry, ds.coords)
ds.to_netcdf(name)
ds.close()

{% endhighlight %}

### Wrap longitude of xarray from -180,180 to 0,360

It is quite direct with the last versions of xarray library (>0.11 should work). If we have a data-array named **mydat** and if the longitude has is named as 'lon' then:

{% highlight Python %}
mydat = mydat.assign_coords(lon=(np.mod(mydat.lon, 360))).sortby('lon')
{% endhighlight %}

should be enough.


### Create a netcdf with monthly or seasonaly datasets

Here we asume that we have an xarray DataArray with a time dimension and we aim to create a DataArray which is grouped by months or by seasons. 

{% highlight Python %}

# ncname is our initial netcdf-dataset
# ini_yr, end_yr are initial and last year to include as int values
import pandas as pd
import xarray as xr

def is_within(year, syear1, syear2):
    # This function will be used later to select a time interval
    # between desired years.
    return (year >= syear1) & (year <= syear2)
     
# We open the dataset
data_raw = xr.open_dataset(ncname)
data_new = data_raw.sel(time=is_within(data_raw['time.year'], ini_yr, end_yr))
results = []
labels = []
for label, group in data.groupby('time.season'):
    labels.append(label)
    results.append(group.mean(dim='time'))

new_dataset = xr.concat(results, pd.Index(labels, name='season'))
new_dataset.to_netcdf(ncname.replace('.nc','_seasonal.nc'))
new_dataset.close()
{% endhighlight %}

for a month by month dataset:

{% highlight Python %}

# ncname is our initial netcdf-dataset
# ini_yr, end_yr are initial and last year to include as int values
import pandas as pd
import xarray as xr

def is_within(year, syear1, syear2):
    # This function will be used later to select a time 
    # interval between desired years.
    return (year >= syear1) & (year <= syear2)
     
# We open the dataset
data_raw = xr.open_dataset(ncname)
data_new = data_raw.sel(time=is_within(data_raw['time.year'], ini_yr, end_yr))
results = []
labels = []
for label, group in data.groupby('time.month'):
    labels.append(label)
    results.append(group.mean(dim='time'))

new_dataset = xr.concat(results, pd.Index(labels, name='month'))
new_dataset.to_netcdf(ncname.replace('.nc','_seasonal.nc'))
new_dataset.close()
{% endhighlight %}


<small markdown="1">[Up to table of contents](#toc)</small>
{: .text-right }


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

Pieces of Python code in Geosciences
--------------------------------------


## Create a Land and Ocean Masks Filters

It is feasible to create a land-mask filter with Python based on the libraries:

- [geopandas](https://wiki.haskell.org/Arrays)
- [rasterio](https://wiki.haskell.org/Numeric_Haskell:_A_Vector_Tutorial)
- [affine](https://wiki.haskell.org/Numeric_Haskell:_A_Repa_Tutorial)
- [xarray](https://guide.aelve.com/haskell/arrays-bpid18sd)

import geopandas
from rasterio import features
from affine import Affine
import numpy as np
import xarray as xr

**Arrays**

Second task is to understand the specific type of array (and more advanced definitions like Repa)



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


<small markdown="1">[Up to table of contents](#toc)</small>
{: .text-right }


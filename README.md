# moduleInitR
This is a Basic package to act as a bootstrap for Environment Module System R interface.

The Environment Module System already has an R interface and it works great:

```
    https://github.com/cea-hpc/modules/blob/master/init/r.R.in
```

After installation it can typically be found here: `/usr/share/Modules/init/r.R`.
In order to activate it you can do `source(/usr/share/Modules/init/r.R)` from within R.

However, we wanted a way to push this interface out as a package so that users only have to do load the package instead of use `source`:

```r
library(moduleInitR)
module('load','samtools')
module('load','bcftools')
```

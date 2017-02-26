# iRcotofun

[![Flattr this git repo](https://api.flattr.com/button/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=m.eik&url=https://github.com/unDocUMeantIt/iRcotofun&title=iRcotofun&language=en_GB&tags=github&category=software)

Here's an idea for your next office party: This R package creates a one-file jeopardy-like quiz game in HTML. You must come up with the questions and answers yourself, of course.

![main window](/inst/screenshots/main_window.jpg?raw=true "main window")

## Installation

### Development releases via the project repository

Installation of tha latest stable release is fairly easy, it's available from the project's own repository:

```
install.packages("iRcotofun", repo="https://reaktanz.de/R")
```

To automatically get updates, consider adding the repository to your R configuration. You might also
want to subscribe to the package's [RSS feed](https://reaktanz.de/R/pckg/iRcotofun/RSS.xml) to get notified of new releases.

If you're running a Debian based operating system, you might be interested in the
[precompiled *.deb packages](https://reaktanz.de/R/pckg/iRcotofun/deb_repo.html).

### Installation via GitHub

To install it directly from GitHub, you can use `install_github()` from the [devtools](https://github.com/hadley/devtools) package:

```
library(devtools)
install_github("unDocUMeantIt/iRcotofun") # stable release
install_github("unDocUMeantIt/iRcotofun", ref="develop") # development release
```

## The name

I really couldn't think of a frelling name...

## Contributing

To ask for help, report bugs, suggest feature improvements, or discuss the global
development of the package, please use the issue tracker on GitHub.

### Branches

Please note that all development happens in the `develop` branch. Pull requests against the `master`
branch will be rejected, as it is reserved for the current stable release.

## Licence

Copyright 2014-2017 Meik Michalke <meik.michalke@hhu.de>

iRcotofun is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

iRcotofun is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with iRcotofun.  If not, see <http://www.gnu.org/licenses/>.

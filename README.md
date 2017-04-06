extcite
=======

[![Build Status](https://travis-ci.org/sckott/extcite.svg?branch=master)](https://travis-ci.org/sckott/extcite)

__`extcite` gets DOIS and generates citations for your papers__

## Install

### Development version

```
git clone git@github.com:sckott/extcite.git
cd extcite
rake install
```

> if `rake install` fails, try `sudo rake install`. If that fails, open an issue with what `rake install --trace` gives you

## Examples

### Within Ruby

#### Search

A single paper

```ruby
require 'extcite'
# link to full text available
Extcite.extract(path: 'xxx')
```

Many papers at once

```ruby
require 'extcite'
Extcite.extract(path: 'xxx/')
```

### On the CLI

All pdfs in the current directory:

```shell
extcite extract .
```

Single paper

```shell
extcite extract foo.pdf
```

[changelog]: https://github.com/sckott/extcite/blob/master/CHANGELOG.md

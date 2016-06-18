dozedois
========

[![Build Status](https://travis-ci.org/sckott/dozedois.svg?branch=master)](https://travis-ci.org/sckott/dozedois)

__`dozedois` gets DOIS and generates citations for your papers__

## Install

### Development version

```
git clone git@github.com:sckott/dozedois.git
cd dozedois
rake install
```

> if `rake install` fails, try `sudo rake install`. If that fails, open an issue with what `rake install --trace` gives you

## Examples

### Within Ruby

#### Search

A single paper

```ruby
require 'dozedois'
# link to full text available
dozedois.dois(path: 'xxx')
```

Many papers at once

```ruby
require 'dozedois'
dozedois.dois(path: 'xxx/')
```

### On the CLI

All pdfs in the current directory:

```shell
dozedois doze .
```

Single paper

```shell
dozedois doze foo.pdf
```

[changelog]: https://github.com/sckott/dozedois/blob/master/CHANGELOG.md

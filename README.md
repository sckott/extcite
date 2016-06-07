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

```ruby
dozedois .
```

## To do

* xxx

[changelog]: https://github.com/sckott/dozedois/blob/master/CHANGELOG.md

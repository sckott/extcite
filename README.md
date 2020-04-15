extcite
=======

[![gem version](https://img.shields.io/gem/v/extcite.svg)](https://rubygems.org/gems/extcite)
[![Build Status](https://travis-ci.org/sckott/extcite.svg?branch=master)](https://travis-ci.org/sckott/extcite)
[![codecov.io](http://codecov.io/github/sckott/extcite/coverage.svg?branch=master)](http://codecov.io/github/sckott/extcite?branch=master)

__`extcite` gets DOIS and generates citations for papers__

## Install

### Release version

```
gem install extcite
```

### Development version

```
git clone git@github.com:sckott/extcite.git
cd extcite
rake install
```

> if `rake install` fails, try `sudo rake install`. If that fails, open an issue with what `rake install --trace` gives you

## Examples

### Within Ruby

```ruby
require 'extcite'
```

A single paper

```ruby
require 'net/http'
File.write("foo.pdf", Net::HTTP.get(URI.parse("https://scottchamberlain.info/pdfs/GuoEtal2015PlosOne.pdf")))
Extcite.extract(path: 'foo.pdf')
```

bib citation is written to a file given in `file` param

Many papers at once

```ruby
Dir.mkdir('bar')
File.write("bar/foo1.pdf", Net::HTTP.get(URI.parse("https://scottchamberlain.info/pdfs/Chamberlain&Szocs2013F1000Research.pdf")))
File.write("bar/foo2.pdf", Net::HTTP.get(URI.parse("https://scottchamberlain.info/pdfs/GuoEtal2015PlosOne.pdf")))
Extcite.extract(path: 'bar')
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

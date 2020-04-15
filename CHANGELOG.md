## 0.4.0 (2020-04-15)

* bump serrano version (#55)
* bump bibtex-ruby version (#58)
* bump thor version (#59)
* bump faraday_middleware version (#60)
* updated `extract_text_one` method to use `Timeout.timeout` while looping through pages of a PDF to extract text - sometimes `pdf-reader` hangs, so only allow 1 second max before skipping to the next page
* add error catching to `extract_from_metadata` method for xml parsing of PDF metadata; sometimes PDF metadata is full of non-parseable XML

## 0.3.0 (2020-04-07)

* bump faraday and faraday_middleware versions (#29) (#30)
* bump bibtex-ruby version (#56) (#57)

## 0.2.2 (2019-11-22)

* update dependencies

## 0.2.0 (2019-08-07)

* new method `extract_from_metadata` to try to extract DOIs from one or more PDF metadat sections
* add `dois` method to cli tool, which uses the `extract_from_metadata` method
* `extract` cli method now accepts one or more file paths
* bump dependency versions

## 0.1.0 (2017-04-06)

* First version to Rubygems

## 0.0.9 (2016-06-17)

* battle tested more, fixed a number of bugs
* now works with arxiv papers
* now works with biorxiv, or at least should
* improved extraction of DOIs

## 0.1.0 (2016-06-07)

* just started, :)

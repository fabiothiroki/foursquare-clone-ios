# Foursquare Clone - iOS App

[![Build Status](https://travis-ci.org/fabiothiroki/foursquare-clone-ios.svg?branch=master)](https://travis-ci.org/fabiothiroki/foursquare-clone-ios)
[![codecov.io](https://img.shields.io/codecov/c/github/fabiothiroki/foursquare-clone-ios.svg)](https://codecov.io/gh/fabiothiroki/foursquare-clone-ios)
[![codebeat badge](https://codebeat.co/badges/87d1b8fd-5cf9-433b-b486-62d80a0863e9)](https://codebeat.co/projects/github-com-fabiothiroki-foursquare-clone-ios-master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/fabiothiroki/foursquare-clone-ios/blob/master/LICENSE)

A simple iOS application that uses the Foursquare API to show nearby places of interest.

![simulator screen shot - iphone 5s - 2018-04-09 at 20 55 04](https://user-images.githubusercontent.com/670057/38528933-50023a4c-3c38-11e8-9c4c-3ec7032a2320.png) ![screenshot](https://user-images.githubusercontent.com/670057/38529443-25429808-3c3b-11e8-9451-d622ff523489.gif)


## Setup

### Foursquare API Key

Follow these instructions at [Foursquare Developers page](https://developer.foursquare.com/docs/api/getting-started) to obtain a **Client ID** and a **Client Secret**.
Then copy and paste these values into [ServicesConstants.swift file](https://github.com/fabiothiroki/foursquare-clone-ios/blob/master/Foursquare%20Clone/Services/ServicesConstants.swift).

### Main Dependencies

* Ruby 2.3.4: recommended to install it using [Ruby Version Manager (RVM)](https://rvm.io/)

* Xcode 9.2

### Installation

```sh
gem install bundler
bundle install
bundle exec pod install --repo-update
```

You can now open the `Foursquare Clone.xcworkspace` file and run.

### Test

After installing all dependencies you can run the tests by clicking `Product > Test` or simply `CMD + U`

# Homebrew Puppet Module for not Boxen

Install [Homebrew](http://brew.sh), a package manager for Mac OS X.

This was stolen from Boxen, and modified to work with regular Puppet.

## Usage

```puppet
class {'homebrew':
  user => 'your_user',
}

# Declaring a custom package formula, and installing package

class clojure {
  homebrew::tap { 'homebrew/versions': }

  homebrew::formula {
    'clojure': ; # source defaults to puppet:///modules/clojure/brews/clojure.rb
    'leinengen':
      source => 'puppet:///modules/clojure/brews/leinengen.rb' ;
  }

  package {
    'boxen/brews/clojure':
      ensure => 'aversion' ;
    'boxen/brews/leinengen':
      ensure => 'anotherversion' ;
  }
}

# Installing homebrew formulas, and passing in arbitrary flags, like:
# brew install php54 --with-fpm --without-apache

package { 'php54':
  ensure => present,
  install_options => [
    '--with-fpm',
    '--without-apache'
  ],
  require => Package['zlib']
}
```

## Required Puppet Modules

* `boxen`, >= 1.2
* `repository`, >= 2.0
* `stdlib`, >= 4.0

## Development

Write code. Run `script/cibuild` to test it. Check the `script`
directory for other useful tools.

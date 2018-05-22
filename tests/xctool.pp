class {homebrew:
user => 'graham_gilbert',
}
package {'xctool':
ensure => latest,
provider => 'homebrew'}

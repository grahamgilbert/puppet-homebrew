# Internal: Convert homebrew snapshot into a git repo.
#
# Examples
#
#   include homebrew::repo
class homebrew::repo (
  $user          = $homebrew::user,
  $repositorydir = $homebrew::config::repositorydir,
  $min_revision  = $homebrew::config::min_revision,
) {
  require homebrew

  if $facts[:os]['family'] == 'Darwin' {
    homebrew_repo { $repositorydir:
      min_revision => $min_revision,
      user         => $user
    } -> Package <| |>
  }
}

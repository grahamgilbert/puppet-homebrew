# Public: Install and configure homebrew for use with Boxen.
#
# Examples
#
#   include homebrew

class homebrew(
  $user,
  $cachedir      = $homebrew::config::cachedir,
  $installdir    = $homebrew::config::installdir,
  $repositorydir = $homebrew::config::repositorydir,
  $libdir        = $homebrew::config::libdir,
  $cmddir        = $homebrew::config::cmddir,
  $tapsdir       = $homebrew::config::tapsdir,
  $brewsdir      = $homebrew::config::brewsdir,
  $min_revision  = $homebrew::config::min_revision,
  $repo          = 'Homebrew/brew',
  $set_cflags    = true,
  $set_ldflags   = true,
) inherits homebrew::config {
  include homebrew::repo

  file { ["${installdir}/bin",
          "${installdir}/etc",
          "${installdir}/include",
          "${installdir}/lib",
          "${installdir}/lib/pkgconfig",
          "${installdir}/Library",
          "${installdir}/sbin",
          "${installdir}/share",
          "${installdir}/share/locale",
          "${installdir}/share/man",
          "${installdir}/share/man/man1",
          "${installdir}/share/man/man2",
          "${installdir}/share/man/man3",
          "${installdir}/share/man/man4",
          "${installdir}/share/man/man5",
          "${installdir}/share/man/man6",
          "${installdir}/share/man/man7",
          "${installdir}/share/man/man8",
          "${installdir}/share/info",
          "${installdir}/share/doc",
          "${installdir}/share/aclocal",
          "${installdir}/var",
          "${installdir}/var/log",
          $repositorydir,
          ]:
    ensure  => 'directory',
    owner   => $user,
    group   => 'staff',
    mode    => '0755',
    require => undef,
    before  => Exec["install homebrew to ${repositorydir}"],
  }

  exec { "install homebrew to ${repositorydir}":
    command => "git init -q &&
                git config remote.origin.url https://github.com/${repo} &&
                git config remote.origin.fetch master:refs/remotes/origin/master &&
                git fetch origin master:refs/remotes/origin/master -n &&
                git reset --hard origin/master",
    cwd     => $repositorydir,
    user    => $user,
    path    => '/usr/local/bin:/usr/bin:/usr/sbin:/bin',
    creates => "${repositorydir}/.git",
  }

  File {
    require => Exec["install homebrew to ${repositorydir}"],
  }

  file {
    [
      $cachedir,
      $tapsdir,
      $cmddir,
      "${tapsdir}/boxen",
      $brewsdir,
      "${brewsdir}/cmd"
    ]:
      ensure => 'directory';
  }
}

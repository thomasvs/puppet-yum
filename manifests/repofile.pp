# Define: yum::repofile
#
# This definition saves a repository configuration file.
#
# Parameters:
#   [*path*]     - alternative file location (defaults to name)
#   [*ensure*]   - specifies if repository should be present or absent
#   [*content*]  - content
#   [*source*]   - source (e.g.: puppet:///)
#
# Actions:
#
# Requires:
#   RPM based system
#
# Sample usage:
#   yum::repofile { 'epel.repo':
#     ensure  => present,
#     source => 'puppet:///files/epel.repo'
#   }
#
define yum::repofile (
  $path    = $name,
  $ensure  = present,
  $content = '',
  $source  = '',
) {
  if ($content == '') and ($source == '') {
    fail('Missing params: $content or $source must be specified')
  }

  if ($path =~ /\//) {
    $fullpath = $path
  } else {
    $fullpath = "/etc/yum.repos.d/${name}"
  }

  file { $fullpath:
    ensure => $ensure,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  if $content {
    File[$fullpath] { content => $content }
  }

  if $source {
    File[$fullpath] { source => $source }
  }
}

class hosts {
  $location = lookup('env::location');

  if $location == 'home' {
    contain hosts::home
  }
  else {
    contain hosts::company
  }
}
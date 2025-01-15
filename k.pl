#!/usr/bin/perl
# Name: k.pl
# Author: Jason Campisi
# Date: 1/15/2025
# Repository: https://github.com/xeoron/K
# Purpose: K easily kills a running *nix program by name or count how many processes it is using.
# License: Released under GPL v3 or higher. Details here http://www.gnu.org/licenses/gpl.html

use strict;
use Getopt::Long;
my $name="k.pl";
my $version="Version 2.2.7 of $0 is released under the GPL v3";
my ($program, $force, $pCount, $pid, $silent, $ver, $help ) = ('',0,0,0,0,0,0);

GetOptions(
    "t|target=s" =>\$program,
    "f|force" =>\$force,
    "c|count" =>\$pCount,
    "p|pid" =>\$pid,
    "s|silent" =>\$silent, 
    "v|version" =>\$ver,
    "h|help" =>\$help,
    );

sub _version(){ 
  print $version . "\n";  exit 0;
} #end _version()

sub _printHelp(){ # check required data or if help was called
print <<EOD;
 $name for kill a program by name. 
 K easily kills a *nix based running program by name or provides process detail on the program.
 The *nix command kill requires a process number. K makes it easier to list the process ID's 
 of a program, learn the process count or to terminate a program.

    Example: 
        k -t program_to_kill
        k -c -t "visual studio code"
        k -p -c -t firefox

        -t|target       Target a process by name to terminate      
    Optional:
        -f|force        Force a temperamental process to end
        -c|count        List total number of processes the program is using
        -p|pids         List the process IDs
        -s|silent       Silent mode: don't display feedback
        -v|version      Version and License
        -h|help         Explain usage       
EOD
    exit 0;    
}#end _printHelp()

sub remove_duplicates(@) { #remove array duplicates
    my %seen;
    grep !$seen{$_}++, @_;
}#end remove_duplicates

sub _isRunning(){#end script if program is not running

my (@list, @processID);
my @countIDS = `ps x | grep -i "$program" | grep -v "t $program" | grep -v "grep -i" | sort`;
#important grep -v "t $program" filters out the running k program so it doesn't shut itself down.

   foreach (@countIDS) {
        $_=~s/^\s*(.*?)\s*$/$1/g;  #trim white spaces
        push (@list, $1) if ($_=~m/^(\d+)/); #grab proccess id
   }
   @processID = remove_duplicates(@list) if (@list); #purge duplicates
   if (@processID == 0){ warn "$program is not running\n"; exit 0; }
 
 return @processID; #return process ID's 
}#end _isRunning()

sub main(){
  _version() if ($ver);
  _printHelp() if ($help or $program eq "");
  my @countID = _isRunning();

  if ($pid){
      print "Process Count " . scalar @countID . "\n" . '-' x 17 . "\n" if ($pid && !$silent);
      foreach (@countID) { print "$_\n"; } 
  }elsif ($pCount){
      if (scalar @countID == 1){ print scalar @countID . " process\n"; }
      else{ print scalar @countID . " processes\n"; }
  }elsif ($program){ #kill the program
      print "Shutting down all $program processes\n" if (!$silent);
      my $option="-9";
      $option = "-11" if ($force);
      foreach (@countID){ qx\kill $option $_ >/dev/null 2>&1\; }   #{ kill $option, $_; }  # <-- more secure than using qx\kill $option $_ >/dev/null 2>&1\; 
  }
 return 0;
}#end main

exit main();

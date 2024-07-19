#!/usr/bin/perl
# Name: k.pl
# Author: Jason Campisi
# Date: 7/19/2024
# Purpose: K easily kills a running *nix program by name or count how many processes it is using.
# License: Released under GPL v3 or higher. Details here http://www.gnu.org/licenses/gpl.html

use strict;
use Getopt::Long;
my $name="k.pl";
my $version="Version 2.1.0 of $0 is released under the GPL v3";
my ($program, $force, $pCount, $pid, $silent, $ver, $help ) = ('',0,0,0,0,0,0);

GetOptions(
    't|target=s' =>\$program,
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

sub _getHelp(){ # check required data or if help was called
print <<EOD;
 $name for kill a program by name. 
 K easily kills a running program or count how many processes it is using.
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
}#end _getHelp()

sub uniq(@) { #remove array duplicates
    my %seen;
    grep !$seen{$_}++, @_;
}#end uniq

sub _isRunning(){#end script if program is not running
 my @countIDS = `ps x | grep -i "$program" | grep -v grep | grep -v "t $program"`;  #| awk '{print $1}'
 my (@list, @processID);
   foreach (@countIDS) {
        $_=~s/^\s*(.*?)\s*$/$1/g;  #trim white spaces
        push (@list, $1) if ($_=~m/^(\d+)/); #grab proccess id
   }
   @processID = uniq(@list) if (@list); #purge duplicates
   
   if (@processID == 0){ warn "$program is not running\n"; exit 0; }

 return @processID; #return process ID's 
}#end _isRunning()

sub main(){
  _version() if ($ver);
  _getHelp() if ($help or $program eq "");
  my @countID = _isRunning();

  if ($pid && $program){
      print "Total of " . scalar @countID . " Processes\n" if ($pCount && !$silent);
      foreach (@countID) { print "$_\n"; } 
  }elsif ($pCount && $program){
      print scalar @countID . " processes\n";
  }elsif ($program){ #kill the program
      print "Shutting down all $program processes\n" if (!$silent);
      my $state="-9";
      $state = "-11" if ($force);
      foreach (@countID){ qx\kill $state $_ >/dev/null 2>&1\; }
  }
 return 0;
}#end main

exit main();

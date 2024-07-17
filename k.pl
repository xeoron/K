#!/usr/bin/perl
# Name: k.pl
# Author: Jason Campisi
# Date: 7/17/2024
# Purpose: K easily kills a running program by name or count how many processes it is using.
# License: Released under GPL v3 or higher. Details here http://www.gnu.org/licenses/gpl.html

use strict;
use Getopt::Long;
my $name="k.pl";
my $version="Version 1.0.1 of $0 is released under the GPL v3";
my ($program, $processCount, $ver, $help ) = ('',0,0,0);

GetOptions(
    't=s' =>\$program,
    "c" =>\$processCount, 
    "version|v" =>\$ver,
    "help" =>\$help,
    );

sub _version(){ 
  print $version . "\n";  exit 0;
} #end _version()

sub _getHelp(){ # check required data or if help was called
print <<EOD;
$name for kill a program by name: k easily kills a running program or count how many processes it is using.
    Usage:        $name -t program_to_kill
      
    Optional:
        -c         list number of processes the program is using.
        -v         Version and License
        -help        
EOD
    exit 0;    
}#end _getHelp()

sub _isRunning(){#end script if program is not running
  my $count=`ps x | grep -i $program | grep -v grep | awk '{print $1}' | wc -l`;
     $count=~s/^\s*(.*?)\s*$/$1/;  #trim white spaces
  if (1 >=$count){ 
        print "...$program is not running!\n"; 
        exit 0;
  }  
  return --$count; #return count and because the system call adds a extra 1 to the total remove it
}#end _isRunning()

sub main(){
    _version() if ($ver);
    _getHelp() if ($help or $program eq "");
    my $count = _isRunning();

    if ($processCount && $program){
        print "Total number of proccesses $program is using: $count\n";
    }
    elsif ($program){ #kill the program
        print "Shutting down all $program processes\n";
        `ps x | grep -i $program | grep -v grep | awk '{print $1}' | xargs kill -9 >/dev/null 2>&1`;
    }
 return 0;
}#end main

main();

exit 0;
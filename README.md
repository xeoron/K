K
=====

K easily kills a *nix based running program by name or provides process detail on the program.
The *nix command kill requires a process number. K makes it easier
    to list the process ID's of a program, 
    to learn the total process count, and
    to terminate a running program by name


Usage: Get info on a program or terminate it
=====  
    Example: 
        k -t program_to_shutdown        
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


Requirements
=====
Software:

    Perl v5 or higher
    *nix based system with ps, grep, & kill

Setup
=====
Automated command:

	sudo ./install_k.sh
    sudo ./install_macOS_k.sh

Manual commands:

    cd ./k/
    chmod +x ./k.pl
    Linux: sudo cp ./k.pl /usr/bin/k
    macOS: sudo cp ./k.pl /opt/local/bin/k 


License
=====
k is copyleft 2024 under the <a href="http://www.gnu.org/licenses/gpl-3.0.html">GPL v3</a> or higher.

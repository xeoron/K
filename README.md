K
=====

K easily kills a running program by name or count how many processes it is using.
The *nix command kill requires a process number. K makes it easier.


Usage: To kill a program by name
=====  
    ./k.pl -t program_to_shutdown
    Optional:
        -c         list number of processes the program is using.
        -v         Version and License
        -help     


Requirements
=====
Software:

    Perl v5 of higher
    Terminal

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

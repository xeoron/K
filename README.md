K
=====

K easily kills a running program or count how many processes it is using.
======
end a program looks like this this

    bash-3.2$ k -t filebot
     Killing all filebot processes
    bash-3.2$ 


usage
=====
./k.pl -t program_to_kill
      
    Optional:
        -c         list number of processes the program is using.
        -v         Version and License
        -help     


requirements
=====
software:

    Terminal
    Mac OS X.5 or higher  

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

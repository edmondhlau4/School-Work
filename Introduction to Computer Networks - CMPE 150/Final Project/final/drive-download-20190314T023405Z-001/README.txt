Edmond Ho-Yin Lau
ehlau
CMPE 150
Final Project

Files Attached:
final.py
final_controller.py
README.txt

Sources Used:
openflow.stanford.edu/display/ONL/POX+wiki
sdnhub.org/tutorials/pox

High level logic:

How I approached this final lab, was to first look at lab 1 to see how to create
a network topology.  This took a little longer since there were more hosts and
switches, but this time we incorporated ports into our final lab.  Similarly
I looked at lab 3, because we created a table/flow entry to allow only certain
packets to pass between different hosts.

What I first did was install a table and its entry, match its packet,
set up both idle and hard timeouts, then packet.find (ipv4 and icmp) 
since that is what we are looking for in this lab.

I flooeded non-IP traffic since we were allowed, then if it wasn't IP traffic
I matched the packet.  For Switch ID 1, 2, 3, and 5, they were all pretty similar
simply matching the destination or its source to the appropriate port.  I created
mostly if statements and very little else statements in my program, because if 
statements allowed me to be more specific in what exactly, i.e. if source/
destination is h10/20/30...etc than it would with else statements.  Only used
else statements if it can apply be applied to more than 1. Within each statements, 
I matched the message to the packet, then send it to the appropriate port,
then send the connection.

For switch ID 4 (Core switch), we had multiple steps.  One was to check for the
untrusted host, one to check for trusted, one for the server by either untrusted 
or trusted host.  Lastly, we checked ICMP and its source to see if it would be
dropped or sent to h10,h20,h30.  For the dropped packets, I followed the same way
as lab 3, which is to simply omit the packet.  

How I know my controller works:

Running pingall, the packets that were dropped were packets being sent to h5 which
is the untrusted host.  However packet h5 to h6 succeeds because we were asked to
let the trusted host be able to communicate with each host.
Pingall checks ICMP packets

Iperf between two company hosts succeeds, between one company host and untrusted
hosts succeeds, between one company and trsuted host succeeds, and between untrusted
to server fails.  This lab required us to only block TCP from the server and the
untrusted host, however TCP is allowed throughout the rest.
Iperf checks TCP packets 


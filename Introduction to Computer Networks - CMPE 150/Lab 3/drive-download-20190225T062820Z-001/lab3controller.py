# Lab 3 Skeleton
#
# Based on of_tutorial by James McCauley

from pox.core import core
import pox.openflow.libopenflow_01 as of

log = core.getLogger()

class Firewall (object):
  """
  A Firewall object is created for each switch that connects.
  A Connection object for that switch is passed to the __init__ function.
  """
  def __init__ (self, connection):
    # Keep track of the connection to the switch so that we can
    # send it messages!
    self.connection = connection

    # This binds our PacketIn event listener
    connection.addListeners(self)

  def do_firewall (self, packet, packet_in):
    # The code in here will be executed for every packet.
    #     The rules that needed to be implemeneted
    #     SRC IP		Dest IP			Protocol		Action
    #     Any			Any			ICMP			Accept
    #     Any			Any			ARP			Accept
    #     10.0.0.1		10.0.0.3		TCP			Accept
    #	  10.0.0.3		10.0.0.1		TCP			Accept
    #     Any			Any			-			Drop

    # Sources used for this lab:
    # https://openflow.stanford.edu/display/ONL/POX+Wiki
    # flowgrammable.org/sdn/openflow/classifiers
    # sdnhub.org/tutorials/pox/

    #   Installing table and its entry     
    msg = of.ofp_flow_mod()
    #   Match the packets
    msg.match = of.ofp_match.from_packet(packet)
    # Idle and hard timeouts for our dump-flows
    msg.idle_timeout = 15
    msg.hard_timeout = 30

    # Packet checks for one of the following:
    # Ipv4, ARP, TCP, ICMP
    IPpacket = packet.find('ipv4')
    checkARP = packet.find('arp')
    checkTCP = packet.find('tcp')
    checkICMP = packet.find('icmp')

	# If not IPv4
    if IPpacket is None:
	# If not ARP, drops packet
        if checkARP is None:
            # Adds payload
            msg.data = packet_in
            # Execute the action
            self.connection.send(msg)
            # Print
            print "Dropping packet"
	# Else ARP, accepts packet
        else:
            # Adds payload
            msg.data = packet_in
            # Matching the dl type, 0806 = ARP
            msg.match.dl_type = 0x0806
            # Adds action, packet got sent
            # Sets a destination point
            action = of.ofp_action_output(port = of.OFPP_FLOOD)
            # Flooding ports, doesn't matter, will send
            msg.actions.append(action)
            # Execute the action
            self.connection.send(msg)
            # Print
            print "Accepting packet"
	# Else IPv4
    else:
	# If not TCP
        if checkTCP is None:
		# If not ICMP, drops packet
		if checkICMP is None:
                    # Adds payload
                    msg.data = packet_in
                    # Execute the action
                    self.connection.send(msg)
                    # Print
                    print "Dropping packet"
                # Else ICMP, accepts packet
                else:
		    # Adds payload
                    msg.data = packet_in
                    # Adds the DL type, 1 = ICMP
                    msg.nw_proto = 1
                    # Adds action, packet got sent
                    # Sets a destination point
                    action = of.ofp_action_output(port = of.OFPP_FLOOD)
                    # Flooding ports, doesn't matter, will send
                    msg.actions.append(action)
                    # Execute the action
                    self.connection.send(msg)
                    # Print
                    print "Accepting packet"
	# Else TCP
        else:
		# If the Src and Dst IP match 10.0.0.1 and 10.0.0.3 respectively, accept packet
                if msg.match.nw_src == ("10.0.1.10") and msg.match.nw_dst == ("10.0.1.30"):
                    # Adds payload
                    msg.data = packet_in
                    # Adds the DL type, 6 = TCP
                    msg.nw_proto = 6
                    # Adds action, packet got sent
                    # Sets a destination point
                    action = of.ofp_action_output(port = of.OFPP_FLOOD)
                    # Flooding ports, doesn't matter, will send
                    msg.actions.append(action)
                    # Execute the action
                    self.connection.send(msg)
                    # Print
                    print "Accepting packet from h1 to h3"
		# Else drops packet
                else:
                    # Adds payload
                    msg.data = packet_in
                    # Execute the action
                    self.connection.send(msg)
                    # Print
                    print "Dropping packet"
		# If the Src and Dst IP match 10.0.0.3 and 10.0.0.1 respectively, accept packet
                if msg.match.nw_src == ("10.0.1.30") and msg.match.nw_dst == ("10.0.1.10"):
                    # Adds payload
                    msg.data = packet_in
                    # Adds the DL type, 6 = TCP
                    msg.nw_proto = 6
                    # Adds action, packet got sent
                    # Sets a destination point
                    action = of.ofp_action_output(port = of.OFPP_FLOOD)
                    # Flooding ports, doesn't matter, will send
                    msg.actions.append(action)
                    # Execute the action
                    self.connection.send(msg)
                    # Print
                    print "Accepting packet from h3 to h1"
		# Else drops packet
                else:
                    # Adds payload
                    msg.data = packet_in
                    # Execute the action
                    self.connetion.send(msg)
                    # Print
                    print "Dropping packet"

  def _handle_PacketIn (self, event):
    """
    Handles packet in messages from the switch.
    """

    packet = event.parsed # This is the parsed packet data.
    if not packet.parsed:
      log.warning("Ignoring incomplete packet")
      return

    packet_in = event.ofp # The actual ofp_packet_in message.
    self.do_firewall(packet, packet_in)

def launch ():
  """
  Starts the component
  """
  def start_switch (event):
    log.debug("Controlling %s" % (event.connection,))
    Firewall(event.connection)
  core.openflow.addListenerByName("ConnectionUp", start_switch)

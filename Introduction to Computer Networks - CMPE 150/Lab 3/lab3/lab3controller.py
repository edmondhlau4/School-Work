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
	#	The rules that need to be implemented  
	#	Src IP		Dst IP		Protocol	Action
	#	Any		Any		Icmp		Accept
	#	Any		Any		Arp		Accept
	#	10.0.1.10 (h1)	10.0.1.30 (h3)	TCP		Accept
	#	10.0.1.30 (h3)	10.0.1.10 (h1)	TCP		Accept
	#	Any		Any		-		Drop

	# The table entry
    msg = of.ofp_flow_mod()
    msg.match = of.ofp_match.from_packet(packet)
	# Dump flow entries using idle and hard timeout
    msg.idle_timeout = 25
    msg.hard_timeout = 50

	# To check for any packets
    IPpacket = packet.find('ipv4')
    CheckArp = packet.find('arp')
    CheckTcp = packet.find('tcp')
    CheckIcmp = packet.find('icmp')
   

	# Checks for TCP
	if CheckTcp is not None:
		msg.data = packet_in
		check_tsp.srcip = "10.0.0.1"
		check_tcp.dstip = "10.0.0.3"
		msg.nw_proto = 6
		action = of.ofp_action_output(port = of.OFP_Floor)
		msg.actions.append(action)
	else:
		if IPpacket is not None:
			if CheckIcmp is not None:
				msg.data = packet_in
				msg.nw_proto = 1
				action = of.ofp_action_output(port = of.OFPP_FLOOD)
				msg.actions.append(action)
			else:
				msg.data = packet_in
		else:
			if CheckArp is not None:
				msg.data = packet_in
				msg.match.dl_type = 0x0806
				action = of.ofp_action_output(port = of.OFPP_FLOOD)
				msg.actions.append(action)
			else:
				msg.data = packet_in
    print "Example Code."

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
  core.openflow.addListenerByName("ConnectionUp", start_switch

)


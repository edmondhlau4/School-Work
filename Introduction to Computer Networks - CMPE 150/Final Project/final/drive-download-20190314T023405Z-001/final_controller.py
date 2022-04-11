# Final Skeleton
#
# Hints/Reminders from Lab 4:
# 
# To send an OpenFlow Message telling a switch to send packets out a
# port, do the following, replacing <PORT> with the port number the 
# switch should send the packets out:
#
#    msg = of.ofp_flow_mod()
#    msg.match = of.ofp_match.from_packet(packet)
#    msg.idle_timeout = 30
#    msg.hard_timeout = 30
#
#    msg.actions.append(of.ofp_action_output(port = <PORT>))
#    msg.data = packet_in
#    self.connection.send(msg)
#
# To drop packets, simply omit the action.
#

from pox.core import core
import pox.openflow.libopenflow_01 as of

log = core.getLogger()

class Final (object):
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

  def do_final (self, packet, packet_in, port_on_switch, switch_id):
    # This is where you'll put your code. The following modifications have 
    # been made from Lab 4:
    #   - port_on_switch represents the port that the packet was received on.
    #   - switch_id represents the id of the switch that received the packet
    #      (for example, s1 would have switch_id == 1, s2 would have switch_id == 2, etc...)

    #installing table entry and flows
    msg = of.ofp_flow_mod()
    msg.match = of.ofp_match.from_packet(packet)
    #idle and hard timeouts
    msg.idle_timeout = 30
    msg.hard_timeout = 30
    #packet checks for the following, ICMP and IPv4
    IPpacket = packet.find('ipv4')
    checkICMP = packet.find('icmp')
    
    #flooding all non-IP traffic
    if IPpacket is None:
      msg.data = packet_in
      action = of.ofp_action_output(port = of.OFPP_FLOOD)
      msg.actions.append(action)
      self.connection.send(msg)
    #else match the packet
    else:
      msg.data = packet_in
      msg.match = of.ofp_match.from_packet(packet)
      
      #if switch 1, checks the IP destination and source, goes to the correct outport
      #created a table for each switch ID, to it will install during each statement
      #or to my assumption
      if switch_id == 1:
        if msg.match.nw_src == ('10.0.1.10'):
          msg.match = of.ofp_match.from_packet(packet)
          msg.data = packet_in
          action = of.ofp_action_output(port = 1)
          msg.actions.append(action)
          self.connection.send(msg)
        if msg.match.nw_dst == ('10.0.1.10'):
          msg.match = of.ofp_match.from_packet(packet)
          msg.data = packet_in
          action = of.ofp_action_output(port = 8)
          msg.actions.append(action)
          self.connection.send(msg)
      #if switch 2, does the same 
      if switch_id == 2:
        if msg.match.nw_src == ('10.0.2.20'):
          msg.match = of.ofp_match.from_packet(packet)
          msg.data = packet_in
          action = of.ofp_action_output(port = 1)
          msg.actions.append(action)
          self.connection.send(msg)          
        if msg.match.nw_dst == ('10.0.2.20'):
          msg.match = of.ofp_match.from_packet(packet)
          msg.data = packet_in
          action = of.ofp_action_output(port = 8)
          msg.actions.append(action)
          self.connection.send(msg)
      #if switch 3, does the same
      if switch_id == 3:
        if msg.match.nw_src == ('10.0.3.30'):
          msg.match = of.ofp_match.from_packet(packet)
          msg.data = packet_in
          action = of.ofp_action_output(port = 1)
          msg.actions.append(action)
          self.connection.send(msg)
        if msg.match.nw_dst == ('10.0.3.30'):
          msg = of.ofp_flow_mod()
          msg.match = of.ofp_match.from_packet(packet)
          msg.data = packet_in
          action = of.ofp_action_output(port = 8)
          msg.actions.append(action)
          self.connection.send(msg)
      #if switch 5, does the same
      if switch_id == 5:
        if msg.match.nw_src == ('10.0.4.10'):
          msg.match = of.ofp_match.from_packet(packet)
          msg.data = packet_in
          action = of.ofp_action_output(port = 1)
          msg.actions.append(action)
          self.connection.send(msg)
        if msg.match.nw_dst == ('10.0.4.10'):
          msg.match = of.ofp_match.from_packet(packet)
          msg.data = packet_in
          action = of.ofp_action_output(port = 8)
          msg.actions.append(action)
          self.connection.send(msg)
      #if switch 4, has multiple steps
      if switch_id == 4:
        #if DST is Untrusted Host
        if msg.match.nw_dst == ('156.134.2.12'):
          msg.match = of.ofp_match.from_packet(packet)
          msg.data = packet_in
          action = of.ofp_action_output(port = 5)
          msg.actions.append(action)
          self.connection.send(msg)
        #if DST is Trusted Host
        if msg.match.nw_dst == ('104.82.214.112'):
          msg.match = of.ofp_match.from_packet(packet)
          msg.data = packet_in
          action = of.ofp_action_output(port = 6)
          msg.actions.append(action)
          self.connection.send(msg)
        #if to the server
        if msg.match.nw_dst == ('10.0.4.10'):
          #if src is untrusted, drop
          if msg.match.nw_src == ('156.134.2.12'):
            msg.data = packet_in
            self.connection.send(msg)
          #else, just send it to port 
          else:
            msg.match = of.ofp_match.from_packet(packet)
            msg.data = packet_in
            action = of.ofp_action_output(port = 7)
            msg.actions.append(action)
            self.connection.send(msg)
        #else
        else:
          #if ICMP is there and src from untrusted, drop 
          if checkICMP is not None and msg.match.nw_src == ('156.134.2.12'):
            msg.data = packet_in
            self.connection.send(msg)
          #if dst is h10
          if msg.match.nw_dst == ('10.0.1.10'):
            msg.match = of.ofp_match.from_packet(packet)
            msg.data = packet_in
            action = of.ofp_action_output(port = 1)
            msg.actions.append(action)
            self.connection.send(msg)
          #if dst is h20
          if msg.match.nw_dst == ('10.0.2.20'):
            msg.match = of.ofp_match.from_packet(packet)
            msg.data = packet_in
            action = of.ofp_action_output(port = 2)
            msg.actions.append(action)
            self.connection.send(msg)
          #if dst is h30
          if msg.match.nw_dst == ('10.0.3.30'):
            msg.match = of.ofp_match.from_packet(packet)
            msg.data = packet_in
            action = of.ofp_action_output(port = 3)
            msg.actions.append(action)
            self.connection.send(msg)
          #else
          else:
            msg.data = packet_in
            self.connection.send(msg)

  def _handle_PacketIn (self, event):
    """
    Handles packet in messages from the switch.
    """
    packet = event.parsed # This is the parsed packet data.
    if not packet.parsed:
      log.warning("Ignoring incomplete packet")
      return

    packet_in = event.ofp # The actual ofp_packet_in message.
    self.do_final(packet, packet_in, event.port, event.dpid)

def launch ():
  """
  Starts the component
  """
  def start_switch (event):
    log.debug("Controlling %s" % (event.connection,))
    Final(event.connection)
  core.openflow.addListenerByName("ConnectionUp", start_switch)

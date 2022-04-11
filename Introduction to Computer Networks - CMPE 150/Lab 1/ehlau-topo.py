#!/usr/bin/python

from mininet.topo import Topo
from mininet.net import Mininet
from mininet.cli import CLI

class MyTopology(Topo):
	"""
	A basic topology
	"""
	def _init_(self):
		Topo._int_(self)

		# Set Up Topology Here
		switch = self.addSwitch('s1')		# Adds a switch

		host1 = self.addHost('h1')		# Adds a Host

		self.addLink(host1, switch)		# Add a link

		host2 = self.addHost('h2')		# Adds a Host

		self.addLink(host2, switch)		# Add a link

		switch2 = self.addSwitch('s2')		# Adds a switch

		host3 = self.addHost('h3')		# Adds a host

		self.addLink(host3, switch2)		# Add a link

		host4 = self.addHost('h4')		# Adds a host

		self.addLink(host4, switch2)		# Add a link

		self.addLink(switch1, switch2)

if _name_ == '_main_':
	"""
	If this script is run as an executable (by chmod +x) this is what it will do
	"""

	topo = MyTopology()		## Creates the topology
	net = Mininet( topo=topo )	## Loads the topology
	net.start()			## Starts Mininet

	#Commands here will run on the simulated topology CNI(net)

	net.stop()			## Stops Mininet

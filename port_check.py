import socket
import json
from datetime import datetime
import logging

def get_hosts():
	return [
		'app01-0-ebsi-int-lux.intebsi.xyz',
		'app02-0-ebsi-int-lux.intebsi.xyz',
		'app03-0-ebsi-int-lux.intebsi.xyz',
		'app04-0-ebsi-int-lux.intebsi.xyz',
		'besu01-0-ebsi-int-lux.intebsi.xyz',
		'besu02-0-ebsi-int-lux.intebsi.xyz',
		'besu03-0-ebsi-int-lux.intebsi.xyz',
		'besu04-0-ebsi-int-lux.intebsi.xyz',
		'fabric01-0-ebsi-int-lux.intebsi.xyz',
		'fabric02-0-ebsi-int-lux.intebsi.xyz',
		'fabric03-0-ebsi-int-lux.intebsi.xyz',
		'fabric04-0-ebsi-int-lux.intebsi.xyz'
	]

def get_ports():
	return {
		'Ethereum (Besu) ledger (RPC Service)': 48745,
		'Ethereum (Besu) leger (Syncro Service)': 48733,
		'Cockpit': 48790,
		'Cassandra DB': 7000,
		'NGINX (HTTPS Traffic)': 443
	}

def is_port_open(ip,port):
   s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
   try:
      s.connect((ip, int(port)))
      s.shutdown(2)
      return True
   except:
      return False

logging.basicConfig(level=logging.INFO,format='%(message)s')

hosts = get_hosts()
ports = get_ports()
result = {'test_start':str(datetime.now()),'test_end':None,'hostname':socket.gethostname(),'ebsi_connectivity':{}}

logging.info('Connectivity Testing - Starting' + "\n")

for host in hosts:
	logging.debug(host)
	connected = []
	disconnected = []

	for port in ports:
		if is_port_open(host, ports[port]):
			connected.append(port)
		else:
			disconnected.append(port)

	result['ebsi_connectivity'][host] = {'connected': connected, 'disconnected':disconnected}

result['test_end'] =str(datetime.now())

logging.info('Please paste the following line to support.')
logging.info(json.dumps(result) + "\n")

path = socket.gethostname() + "_port_check.txt"
with open(path, "w") as f:
	f.write(json.dumps(result, indent = 4, sort_keys=True) + "\n")

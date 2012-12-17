#!/usr/local/synodlnatrakt/env/bin/python
import os
import ConfigParser


config = ConfigParser.SafeConfigParser()
config.read('/usr/local/synodlnatrakt/var/config.ini')
protocol = 'http'
port = int(config.get('General', 'port'))

print 'Location: %s://%s:%d' % (protocol, os.environ['SERVER_NAME'], port)
print

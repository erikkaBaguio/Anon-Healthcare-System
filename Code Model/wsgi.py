#!/usr/bin/python
from flask import Flask
import os
from itsdangerous import URLSafeTimedSerializer
from datetime import timedelta

app = Flask(__name__)
app.secret_key = "a_random_secret_key_$%#!@"
app.config["REMEMBER_COOKIE_DURATION"] = timedelta(days=14)
app.debug = True


#Login_serializer used to encryt and decrypt the cookie token for the remember
#me option of flask-login
login_serializer = URLSafeTimedSerializer(app.secret_key)


from app import views


if __name__ == '__main__':
    app.run()

#!/usr/bin/python
import os
import sys
import imp

try:
  virtenv = os.path.join(os.environ.get('OPENSHIFT_PYTHON_DIR','.'), 'virtenv')
  python_version = "python"+str(sys.version_info[0])+"."+str(sys.version_info[1])
  os.environ['PYTHON_EGG_CACHE'] = os.path.join(virtenv, 'lib', python_version, 'site-packages')
  virtualenv = os.path.join(virtenv, 'bin','activate_this.py')
  if(sys.version_info[0] < 3):
    execfile(virtualenv, dict(__file__=virtualenv))
  else:
    exec(open(virtualenv).read(), dict(__file__=virtualenv))

except IOError:
  pass
#
# IMPORTANT: Put any additional includes below this line.  If placed above this
# line, it's possible required libraries won't be in your searchable path
#

from app import app as application

#
# Below for testing only
#
if __name__ == '__main__':
    from wsgiref.simple_server import make_server
    httpd = make_server('localhost', 8051, application)
    # Wait for a single request, serve it and quit.
    httpd.serve_forever()
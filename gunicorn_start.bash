#!/bin/bash

NAME="jimmcgaw"                                   # Name of the application
DJANGODIR=~/source/jimmcgaw                       # Django project directory
SOCKFILE=~/source/jimmcgaw/run/gunicorn.sock  # we will communicte using this unix socket
USER=jim                                        # the user to run as
GROUP=jim                                     # the group to run as
NUM_WORKERS=3                                     # how many worker processes should Gunicorn spawn
DJANGO_SETTINGS_MODULE=jimmcgaw.settings             # which settings file should Django use
DJANGO_WSGI_MODULE=jimmcgaw.wsgi                     # WSGI module name

echo "Starting $NAME as `whoami`"

# Activate the virtual environment
cd $DJANGODIR
source ~/.virtualenvs/jimmcgaw/bin/activate
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$DJANGODIR:$PYTHONPATH

# Create the run directory if it doesn't exist
RUNDIR=$(dirname $SOCKFILE)
test -d $RUNDIR || mkdir -p $RUNDIR

# Start your Django Unicorn
# Programs meant to be run under supervisor should not daemonize themselves (do not use --daemon)
exec ~/.virtualenvs/jimmcgaw/bin/gunicorn ${DJANGO_WSGI_MODULE}:application \
  --name $NAME \
  --workers $NUM_WORKERS \
  --user=$USER --group=$GROUP \
  --bind=unix:$SOCKFILE \
  --log-level=debug \
  --log-file=-
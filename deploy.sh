export PORT=5108
export MIX_ENV=prod
export GIT_PATH=/home/taskapp/src/taskapp
PWD = `pwd`
mix deps.get
(cd assets && npm install --unsafe-perm)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
MIX_ENV=prod mix ecto.create
MIX_ENV=prod mix ecto.migrate
mix release.init
MIX_ENV=prod mix release 
mkdir -p ~/wwww
mkdir -p ~/oldd

NOW=`date +%s`
if [ -d ~/www/taskapp ]; then
	echo mv ~/wwww/taskapp ~/oldd/$NOW
	mv ~/wwww/taskapp ~/oldd/$NOW
fi

mkdir -p ~/wwww/taskapp
REL_TAR=~/src/taskapp/_build/prod/rel/taskapp/releases/0.0.1/taskapp.tar.gz
(cd ~/wwww/taskapp && tar xzvf $REL_TAR)

crontab - <<CRONTAB
@reboot bash /home/taskapp/src/taskapp/start.sh
CRONTAB

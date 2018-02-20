export PORT=5106
export MIX_ENV=prod
export GIT_PATH=/home/taskapp/src/taskapp
PWD = `pwd`
mix deps.get
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
MIX_ENV=prod mix ecto.create
MIX_ENV=prod mix ecto.migrate
MIX_ENV=prod mix release 
mkdir -p ~/www
mkdir -p ~/old

NOW=`date +%s`
if [ -d ~/www/taskapp ]; then
	echo mv ~/www/taskapp ~/old/$NOW
	mv ~/www/taskapp ~/old/$NOW
fi

mkdir -p ~/www/taskapp
REL_TAR=~/src/taskapp/_build/prod/rel/taskapp/releases/0.0.1/taskapp.tar.gz
(cd ~/www/taskapp && tar xzvf $REL_TAR)

crontab - <<CRONTAB
@reboot bash /home/taskapp/src/taskapp/start.sh
CRONTAB

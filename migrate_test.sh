# This script shows a migration design oddity with ActiveRecord: If a
# server stays up across a migration, it doesn't detect the change in
# schema. Since AR queries columns explicitly by name by default, the
# equivalent of "SELECT *" will break.
#
# That makes dropping a column without downtime difficult, because
# even if it's unused, ActiveRecord will want to keep querying it.

# Please don't use this Rails app as a general example of good
# practice.  It's essentially a bug repro, and it does several
# dubious things to keep the code small.


# Break on errors
set -e

echo Create DB if needed
./bin/rake db:create || echo No harm no foul

echo Migrate up to stable version
VERSION=20151126181133 ./bin/rake db:migrate

echo Start the server, which will see that version
./bin/rails server -p 3011 &

echo Wait a minute for the Rails app to start
sleep 5

echo Load the schema into AR
curl http://localhost:3011/posts

echo Then, drop the column
./bin/rake db:migrate

echo 
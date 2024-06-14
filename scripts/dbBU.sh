

heroku pg:backups:capture -v -a sdbsto
heroku pg:backups:download -a sdbsto -o bu/$(date +%d.%m.%Y-%H_%M_%S).bu.sql.pgdmp
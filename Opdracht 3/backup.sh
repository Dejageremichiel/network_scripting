tar -czvf /home/user/backups/backupfile.tar /home/user/testfiles/

if [ ! -s "/etc/cron.weekly/make_backup" ];
		then 
			sudo cp make_backup.sh /etc/cron.d/make_backup
			exit 1
fi

echo 'Tijd zondag 17u'
sudo echo '
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

17 * * * * root cd / && run-parts --report /etc/cron.hourly
25 6 * * * root test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.daily )
0 17 * * 7 root test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.weekly )
52 6 1 * * root test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.monthly$
' > /etc/crontab

su user
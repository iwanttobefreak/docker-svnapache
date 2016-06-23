FROM debian

#Install apache and subversion
RUN apt-get update && apt-get -y install apache2 subversion libapache2-svn

#Enable Subversion in Apache
RUN a2enmod dav && a2enmod dav_lock && a2enmod dav_fs && a2enmod authnz_ldap

#Create /etc/apache2/conf-available/svn.conf
#<Location /svn>
#DAV svn
#SVNParentPath /var/svn
#</Location>

#Create SVN config directory
RUN mkdir /var/svn && chown -R www-data:root /var/svn

#Activate SVN config
RUN a2enconf svn

FROM debian

#Install apache and subversion
RUN apt-get update && apt-get -y install apache2 subversion libapache2-svn

#Enable Subversion in Apache
RUN a2enmod dav && a2enmod dav_lock && a2enmod dav_fs && a2enmod authnz_ldap

#Create /etc/apache2/conf-available/svn.conf
ADD https://raw.githubusercontent.com/iwanttobefreak/docker-svnapache/master/svn.conf /etc/apache2/conf-available/

#Create virtualhost with LDAP authentication
ADD https://raw.githubusercontent.com/iwanttobefreak/docker-svnapache/master/000-default.conf /etc/apache2/sites-enabled/

#Create SVN config directory
RUN mkdir /var/svn && chown -R www-data:root /var/svn

#Create SVN repository
RUN svnadmin create /var/svn

#Activate SVN config
RUN a2enconf svn

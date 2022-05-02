#!/bin/bash
#exit 0

apt-get update -yqq
#apt install -yq --no-install-recommends git bash wget curl ca-certificates
apt install -yq --no-install-recommends ca-certificates

if false ; then
        curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | tee \
          /usr/share/keyrings/jenkins-keyring.asc > /dev/null
        echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
          https://pkg.jenkins.io/debian-stable binary/ | tee \
          /etc/apt/sources.list.d/jenkins.list > /dev/null
fi
apt-get update -yqq
apt-get install jenkins

####export NAME=jenkins
####export JENKINS_HOME="/var/lib/$NAME"
####export JENKINS_LOG=daemon.info
#export HTTP_PORT=8080
# servlet context, important if you want to use apache proxying
#export PREFIX="/$NAME"

#jenkins     8046       1 99 04:38 ?        00:00:15 /usr/bin/java -Djava.awt.headless=true -jar /usr/share/java/jenkins.war --webroot=/var/cache/jenkins/war --httpPort=8080
#/etc/init.d/jenkins start

#cat /var/lib/jenkins/secrets/initialAdminPassword

#ENV JENKINS_USER=jenkins CASC_JENKINS_CONFIG=/var/jenkins_home/config.yaml

####if [[ -v JENKINS_CAC ]]; then
####  echo "Configuration as Code enabled"
####  export JAVA_OPTS=-Djenkins.install.runSetupWizard=false
####  export CASC_JENKINS_CONFIG=/var/jenkins_home/config.yaml
####  /usr/local/bin/install-plugins.sh < /provisioning/plugins.txt
####  if [ ! -e /var/jenkins_home/config.yaml ]; then
####    echo "Configuration as Code: Installing default config"
####    cp /provisioning/config.yaml /var/jenkins_home/config.yaml
####  fi
####fi

# TODO: Could use this.
#####if is root
####if [ "$EUID" -ne 0 ]; then
####    exec /usr/local/bin/jenkins.sh
####fi
####echo "Starting /usr/local/bin/jenkins.sh as ${JENKINS_USER}"
####su-exec ${JENKINS_USER} /usr/local/bin/jenkins.sh

sed -i 's@JENKINS_HOME=/var/lib/$NAME@JENKINS_HOME=/data/jenkins@' /etc/default/jenkins || true

chown -R 'jenkins:jenkins' "${JENKINS_HOME}"

/etc/init.d/jenkins start

# NOTE: Could exec directly.
#!/bin/sh
#echo "[ JENKINS ] : Starting Jenkins master ..."
#exec java -Dhudson.DNSMultiCast.disabled=true -Dhudson.udp=-1 -jar /usr/src/app/jenkins.war &

# Dockerfile to create a GFDL Workstation instance

From centos:7

ENV container docker

LABEL maintainer="Seth.Underwood@noaa.gov"

# Install required packages
RUN yum -y install \
      csh \
      perl \
      bzip2 \
      patch \
      make \
      gcc \
      git \
      which \
      bats \
      epel-release \
      python2-pip \
      netcdf-devel \
      gcc-gfortran \
      netcdf-fortran-devel \
      perl-XML-LibXML \
      perl-Try-Tiny \
      perl-Date-Manip \
      perl-XML-Dumper \
      perl-Email-Valid \
      environment-modules; \
    yum clean all

# The GFDL "helper" scripts
ADD home_gfdl.tar.gz /home/

# Add the fms and fre_test users
RUN groupadd -g 70 f; \
    useradd -g f -u 5144 fms; \
    useradd -g f -u 1181 fre_test

# Install additional items as the fms user
USER fms
# Install perlbrew and a Perl
#ENV PERLBREW_ROOT=/home/fms/opt/perlbrew
#RUN \curl -L https://install.perlbrew.pl > ~/install-perlbrew.sh
#RUN bash ~/install-perlbrew.sh
#RUN source ${PERLBREW_ROOT}/etc/bashrc; \
#    perlbrew -v --notest install perl-5.16.3

# Install FRE and FRE-NCtools
ADD fre-commands_bronx-16.tar /home/fms/local/opt/fre-commands/test
ADD fre-nctools_bronx-16.tar.gz /home/fms/local/opt/fre-nctools/test
COPY fre-test.modulefile /home/fms/local/modulefiles/fre/test

USER root
COPY _modulespath /usr/share/Modules/init/.modulespath

CMD /bin/bash

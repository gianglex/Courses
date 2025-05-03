curl:
  pkg.installed

apache2:
  pkg.installed

apache2_service:
  service.running:
    - name: apache2
    - enable: True
    - watch:
      - file: /etc/apache2/sites-available/exampleenvironment.com.conf

/etc/apache2/sites-available/exampleenvironment.com.conf:
  file.managed:
    - user: root
    - group: root
    - mode: '644'
    - contents: |
        <VirtualHost *:80>
          ServerName exampleenvironment.com
          ServerAlias www.exampleenvironment.com
          DocumentRoot /home/vagrant/public-sites/exampleenvironment.com
          <Directory /home/vagrant/public-sites/exampleenvironment.com>
            Require all granted
          </Directory>
        </VirtualHost>

exampleenvironment.com-enabled:
  cmd.run:
    - name: a2ensite exampleenvironment.com.conf
    - unless: "a2query -s exampleenvironment.com"
    - require:
      - file: /etc/apache2/sites-available/exampleenvironment.com.conf
    - watch_in:
      - service: apache2_service

/home/vagrant/public-sites:
  file.directory:
    - user: vagrant
    - group: vagrant
    - mode: '755'

/home/vagrant/public-sites/exampleenvironment.com:
  file.directory:
    - user: vagrant
    - group: vagrant
    - mode: '755'

/home/vagrant/public-sites/exampleenvironment.com/index.html:
  file.managed:
    - user: vagrant
    - group: vagrant
    - mode: '755'
    - contents: |
        Test page for test environment

exampleenvironment.com-hosts:
  file.append:
    - name: /etc/hosts
    - text: "127.0.0.1 exampleenvironment.com"

curl_localhost:
  cmd.run:
    - name: curl localhost
    - onlyif: test -f /etc/apache2/sites-enabled/exampleenvironment.com.conf
    - onchanges:
      - service: apache2_service

/home/vagrant/fakelogs:
  file.directory:
    - user: vagrant
    - group: vagrant
    - mode: '755'

/home/vagrant/fakelogs/fake.log:
  file.managed:
    - user: vagrant
    - group: vagrant
    - mode: '644'
    - contents: |
        # I'm a fake log. Collect me.
        Fakers gonna fake. 

/home/vagrant/fakelogs/fake2.log:
  file.managed:
    - user: vagrant
    - group: vagrant
    - mode: '644'
    - contents: |
        # I'm a fake log2. Collect me.
        They see me fakin, they hatin. 
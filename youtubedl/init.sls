{%- from "youtubedl/map.jinja" import youtubedl with context -%}

# until https://github.com/saltstack/salt/issues/47042 is resolved.
# Should be 2018.3.2 release.
#/usr/local/bin/youtube-dl:
#  file.managed:
#    - onlyif: test ! -f '/usr/local/bin/youtube-dl'
#    - source: https://yt-dl.org/downloads/latest/youtube-dl
#    - source_hash: https://yt-dl.org/downloads/latest/youtube-dl
#    - show_changes: False
#    - dir_mode: 0755
#    - makedirs: True
#    - user: root
#    - group: root
#    - mode: 0755

youtubedl_package_dependencies:
  pkg.installed:
    - pkgs:
{%- for pkg in youtubedl.package_dependencies %}
      - {{ pkg }}
{%- endfor %}

initial_download:
  cmd.run:
    - name: curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl; chmod 0755 /usr/local/bin/youtube-dl
    - creates: /usr/local/bin/youtube-dl

update_youtubedl:
  cmd.run:
    - name: /usr/local/bin/youtube-dl --update
    - runas: root
    - requires:
      - file: /usr/local/bin/youtube-dl


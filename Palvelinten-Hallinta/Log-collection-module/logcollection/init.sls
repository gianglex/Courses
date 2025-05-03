{% set working_dir = '/logcollection' %}
{% set log_dir = working_dir + '/logs' %}
{% set search_dir = '/' %}
{% set minion_id = grains['id'] %}
{% set log_time = salt['cmd.run']('date +%Y%m%d_%H%M%S') %}
{% set tar_filename = minion_id ~ '_' ~ log_time ~ '.tar.gz' %}
{% set tar_path = working_dir ~ '/' ~ tar_filename %}

create_log_dir:
  file.directory:
    - name: {{ log_dir }}
    - makedirs: True
    - user: root
    - group: root
    - mode: 755

collect_logs:
  cmd.run:
    - name: find {{ search_dir }} -type f -name "*.log" -exec cp --parents {} {{ log_dir }} \; 2>/dev/null
    - runas: root
    - require:
      - file: create_log_dir

create_tar:
  cmd.run:
    - name: tar -czf {{ tar_path }} -C {{ working_dir }} logs
    - runas: root
    - require:
      - cmd: collect_logs

push_files:
  cmd.run:
    - name: salt-call cp.push {{ tar_path }}
    - runas: root
    - require:
      - cmd: create_tar

remove_tmp:
  file.absent:
    - name: {{ working_dir }}
    - require:
      - cmd: push_files

execute 'get.docker.com' do
  command 'curl https://get.docker.com/ | bash'
  not_if 'rpm -q docker-ce'
end

replace_or_add "files" do
  path "/usr/lib/systemd/system/docker.service"
  pattern "LimitNOFILE=.*"
  line "LimitNOFILE=1024"
end

execute 'systemctl daemon-reload' do
  command 'systemctl daemon-reload'
end

service 'docker' do
  action :restart
end

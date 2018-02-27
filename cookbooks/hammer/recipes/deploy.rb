org = 'franmrl'
app = 'hammer'

docker_image "#{org}/#{app}" do
  action :pull
  notifies :redeploy, "docker_container[#{app}]"
end

docker_container "#{app}" do
  repo "#{org}/#{app}"
  detach true
  port "5000:5000"
  container_name app
  restart_policy 'always'
  force true
  action :redeploy
end

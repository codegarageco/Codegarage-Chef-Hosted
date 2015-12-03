define :cg_deploy_site do
  deploy     = params[:deploy_data]
  app_name   = deploy[:app_name]
  port       = deploy[:port]
  hosts      = deploy[:hosts]
  force_ssl  = deploy[:force_ssl]
  deploy_to  = deploy[:deploy_to]
  elbs       = deploy[:elbs] || node[:application][:elbs] || []
  access_log = "#{node['nginx']['log_dir'] || '/var/log/nginx'}/#{app_name}.accesss.log"
  source     = "unicorn.site.erb"

  template "#{node[:nginx][:dir]}/sites-available/#{app_name}" do
    cookbook "application"
    source source
    owner "root"
    group "root"
    mode 0644
    variables app_name: app_name,
              port: port,
              hosts: hosts,
              force_ssl: force_ssl,
              deploy_to: deploy_to,
              elbs: elbs,
              access_log: access_log
  end

  nginx_site "#{app_name}"
end

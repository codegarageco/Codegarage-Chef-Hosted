require 'json'

define :cg_deploy_env do
  deploy = params[:deploy_data]
  deploy_user = deploy[:user]
  deploy_group = deploy[:group]
  deploy_to = deploy[:deploy_to]
  app_name = deploy[:app_name]
  env_path = deploy[:env_path] || "#{deploy_to}/shared/.env"
  envs = deploy[:envs]

  # environment.json
  file "#{deploy[:deploy_to]}/shared/config/environment.json" do
    content JSON.generate(envs || {})
    mode "0755"
    owner deploy_user
    group deploy_group
    action :create
  end

  # create .env
  if envs
    template "#{env_path}" do
      cookbook "application"
      source "env.erb"
      owner deploy_user
      group deploy_group
      mode 0754
      variables config_envs: envs
    end
  else
    Chef::Log.info "envs is nil"
  end
end

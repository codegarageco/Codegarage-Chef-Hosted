define :cg_setup_unicorn do
  deploy = params[:deploy_data]
  application = deploy[:app_name]

  template "#{deploy[:deploy_to]}/shared/scripts/unicorn" do
    cookbook 'application'
    mode '0755'
    owner deploy[:user]
    group deploy[:group]
    source "unicorn.service.erb"
    variables(deploy: deploy, application: application)
  end

  template "#{deploy[:deploy_to]}/shared/config/unicorn.conf" do
    cookbook 'application'
    mode '0644'
    owner deploy[:user]
    group deploy[:group]
    source "unicorn.conf.erb"
    variables(
      deploy: deploy,
      application: application
    )
  end
end

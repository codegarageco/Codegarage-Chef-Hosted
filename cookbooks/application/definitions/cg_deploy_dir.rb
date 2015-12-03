define :cg_deploy_dir do
  deploy = params[:deploy_data]

  # Create deploy to
  deploy_user = deploy[:user]
  deploy_group = deploy[:group]
  deploy_to = deploy[:deploy_to]

  directory "#{deploy_to}" do
    owner deploy_user
    group deploy_group
    mode 0755
    action :create
    recursive true
  end

  # create shared folder
  directory "#{deploy_to}/shared" do
    owner deploy_user
    group deploy_group
    mode 0755
    action :create
  end

  # create shared/ directory structure
  ['log','config','system','pids','scripts','sockets'].each do |dir_name|
  directory "#{deploy_to}/shared/#{dir_name}" do
      group deploy_group
      owner deploy_user
      mode 0770
      action :create
      recursive true
    end
  end

  # create shared folder
  directory "#{deploy_to}/releases" do
    owner deploy_user
    group deploy_group
    mode 0755
    action :create
  end
end

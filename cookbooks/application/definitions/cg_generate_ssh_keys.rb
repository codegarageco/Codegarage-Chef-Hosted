define :cg_generate_ssh_key, :user_account => nil do
  username = params[:user]

  Chef::Log.debug("generate ssh skys for #{username}.")

  execute "generate ssh skys for #{username}." do
    user username
    creates "/home/#{username}/.ssh/id_rsa.pub"
    command "ssh-keygen -t rsa -q -f /home/#{username}/.ssh/id_rsa -P \"\""
  end
end

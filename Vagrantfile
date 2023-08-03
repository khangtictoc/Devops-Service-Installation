Vagrant.configure("2") do |config|
  
  config.vm.box = "generic/centos7"
  config.vm.synced_folder "sharefolder", "/sharefolder_vagrant"
  
  
  ################################### CENTOS 7 ###################################
  
  
  config.vm.define "centos_ctl" do |centos_ctl|
    centos_ctl.vm.network :private_network, ip: "192.168.56.5"
    centos_ctl.vm.hostname = "controller"
    centos_ctl.vm.box = "generic/centos7"
    centos_ctl.vm.provider "virtualbox" do |vb| 
      vb.name = "CentOS7 Ansible Controller"
      vb.memory = 2048
      vb.cpus = 1
      vb.customize ["modifyvm", :id, "--nic2", "hostonly", "--hostonlyadapter2", "VirtualBox Host-Only Ethernet Adapter"]
    end
  end
  
  config.vm.define "centos_target_1" do |centos_target_1|
    centos_target_1.vm.network :private_network, ip: "192.168.56.10"
    centos_target_1.vm.hostname = "target1"
    centos_target_1.vm.box = "generic/centos7"
    centos_target_1.vm.provider "virtualbox" do |vb|
      vb.name = "CentOS7 Ansible Target Node 1"
      vb.memory = 2048
      vb.cpus = 1
      vb.customize ["modifyvm", :id, "--nic2", "hostonly", "--hostonlyadapter2", "VirtualBox Host-Only Ethernet Adapter"]
    end
  end

  config.vm.define "centos_target_2" do |centos_target_2|
    centos_target_2.vm.network :private_network, ip: "192.168.56.15"
    centos_target_2.vm.hostname = "target2"
    centos_target_2.vm.box = "generic/centos7"
    centos_target_2.vm.provider "virtualbox" do |vb|
      vb.name = "CentOS7 Ansible Target Node 2"
      vb.memory = 2048
      vb.cpus = 1
      vb.customize ["modifyvm", :id, "--nic2", "hostonly", "--hostonlyadapter2", "VirtualBox Host-Only Ethernet Adapter"]
    end
  end
  
  config.vm.define "centos_target_3" do |centos_target_3|
    centos_target_3.vm.network :private_network, ip: "192.168.56.20"
    centos_target_3.vm.hostname = "target3"
    centos_target_3.vm.box = "generic/centos7"
    centos_target_3.vm.provider "virtualbox" do |vb|
      vb.name = "CentOS7 Ansible Target Node 3"
      vb.memory = 2048
      vb.cpus = 1
      vb.customize ["modifyvm", :id, "--nic2", "hostonly", "--hostonlyadapter2", "VirtualBox Host-Only Ethernet Adapter"]
    end
  end

  ################################### UBUNTU 18 ###################################

  config.vm.define "ubuntu_ctl" do |ubuntu_ctl|
    ubuntu_ctl.vm.network :private_network, ip: "192.168.56.50"
    ubuntu_ctl.vm.hostname = "controller"
    ubuntu_ctl.vm.box = "generic/ubuntu1804"
    
    # Pre-setup scripts
    ubuntu_ctl.vm.provision "shell", path: "Initial_bash_script/setup-dns.sh"

    ubuntu_ctl.vm.provider "virtualbox" do |vb| 
      vb.name = "Ubuntu18 Ansible Controller"
      vb.memory = 3072
      vb.cpus = 2
      vb.customize ["modifyvm", :id, "--nic2", "hostonly", "--hostonlyadapter2", "VirtualBox Host-Only Ethernet Adapter"]
    end
  end
  
  config.vm.define "ubuntu_target_1" do |ubuntu_target_1|
    ubuntu_target_1.vm.network :private_network, ip: "192.168.56.55"
    ubuntu_target_1.vm.hostname = "target1"
    ubuntu_target_1.vm.box = "generic/ubuntu1804"

    # Pre-setup scripts
    ubuntu_target_1.vm.provision "shell", path: "Initial_bash_script/setup-dns.sh"

    ubuntu_target_1.vm.provider "virtualbox" do |vb|
      vb.name = "Ubuntu18 Ansible Target Node 1"
      vb.memory = 3072
      vb.cpus = 2
      vb.customize ["modifyvm", :id, "--nic2", "hostonly", "--hostonlyadapter2", "VirtualBox Host-Only Ethernet Adapter"]
    end
  end
  
  config.vm.define "ubuntu_target_2" do |ubuntu_target_2|
    ubuntu_target_2.vm.network :private_network, ip: "192.168.56.60"
    ubuntu_target_2.vm.hostname = "target2"
    ubuntu_target_2.vm.box = "generic/ubuntu1804"

    # Pre-setup scripts
    ubuntu_target_2.vm.provision "shell", path: "Initial_bash_script/setup-dns.sh"

    ubuntu_target_2.vm.provider "virtualbox" do |vb|
      vb.name = "Ubuntu18 Ansible Target Node 2"
      vb.memory = 3072
      vb.cpus = 2
      vb.customize ["modifyvm", :id, "--nic2", "hostonly", "--hostonlyadapter2", "VirtualBox Host-Only Ethernet Adapter"]
    end
  end

  config.vm.define "ubuntu_target_3" do |ubuntu_target_3|
    ubuntu_target_3.vm.network :private_network, ip: "192.168.56.65"
    ubuntu_target_3.vm.hostname = "target3"
    ubuntu_target_3.vm.box = "generic/ubuntu1804"

    # Pre-setup scripts
    ubuntu_target_3.vm.provision "shell", path: "Initial_bash_script/setup-dns.sh"

    ubuntu_target_3.vm.provider "virtualbox" do |vb|
      vb.name = "Ubuntu18 Ansible Target Node 3"
      vb.memory = 3072
      vb.cpus = 2
      vb.customize ["modifyvm", :id, "--nic2", "hostonly", "--hostonlyadapter2", "VirtualBox Host-Only Ethernet Adapter"]
    end
  end

end

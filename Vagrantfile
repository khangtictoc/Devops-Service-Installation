
Vagrant.configure("2") do |config|


  config.vm.define "centos7_vm" do |centos7_vm|
    centos7_vm.vm.box = "generic/centos7"
    centos7_vm.vm.provider "virtualbox" do |vb| 
      vb.name = "CentOS 7"
      vb.memory = 4096
      vb.cpus = 2
      vb.customize ["modifyvm", :id, "--nic2", "hostonly", "--hostonlyadapter2", "VirtualBox Host-Only Ethernet Adapter"]
    end
  end

  config.vm.define "ubuntu18_vm" do |ubuntu18_vm|
    ubuntu18_vm.vm.box = "generic/ubuntu1804"
    ubuntu18_vm.vm.provider "virtualbox" do |vb| 
      vb.name = "Ubuntu 18.04"
      vb.memory = 4096
      vb.cpus = 2
      vb.customize ["modifyvm", :id, "--nic2", "hostonly", "--hostonlyadapter2", "VirtualBox Host-Only Ethernet Adapter"]
    end
  end
end

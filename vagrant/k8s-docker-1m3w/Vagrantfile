vm_list = [
    {
        :name => "k8s-master",
        :eth1 => "192.168.121.220",
        :mem => "4096",
        :cpu => "4",
        :sshport => 22230
    },
    {
        :name => "k8s-worker1",
        :eth1 => "192.168.121.221",
        :mem => "4096",
        :cpu => "4",
        :sshport => 22231
    },
    {
        :name => "k8s-worker2",
        :eth1 => "192.168.121.222",
        :mem => "4096",
        :cpu => "4",
        :sshport => 22232
    },
    {
        :name => "k8s-worker3",
        :eth1 => "192.168.121.223",
        :mem => "4096",
        :cpu => "4",
        :sshport => 22233
    }
]

Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2004"
  config.vm.box_check_update = false
  config.vm.synced_folder ".", "/vagrant", type: "nfs", nfs_udp: false
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  vm_list.each do |item|
    config.vm.define item[:name] do |vm_config|
        vm_config.vm.hostname = item[:name]
        vm_config.vm.network "private_network", ip: item[:eth1]
        vm_config.vm.provider "libvirt" do |vb|
            vb.memory = item[:mem]
            vb.cpus = item[:cpu]
            if item[:name] != "k8s-master"
                vb.storage :file, :size => "10G"
            end
        end

        vm_config.vm.provision "shell", path: "scripts/common.sh"
        if item[:name] == "k8s-master"
            vm_config.vm.provision "shell", path: "scripts/master.sh"
        else
            vm_config.vm.provision "shell", path: "scripts/worker.sh"
        end
    end
  end
end

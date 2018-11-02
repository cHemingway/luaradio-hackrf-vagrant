# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile for Luaradio and HackRF
# Needs https://github.com/aidanns/vagrant-reload

Vagrant.configure("2") do |config|

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/xenial64"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
  
    # Customize the amount of memory on the VM:
    vb.memory = "2048"

    # Pass through USB devices
    vb.customize ["modifyvm", :id, "--usb", "on"]
    # Disable USB3.0 as HackRF does not have it
    vb.customize ["modifyvm", :id, "--usbxhci", "off"]
    # HackRF
    vb.customize ['usbfilter', 'add', '0', '--target', :id, '--name', 'HackRF One', '--vendorid', '0x1d50', '--productid', '0x6089']

  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    # HackRF and RTL-SDR
    apt-get install -y hackrf rtl-sdr libusb-1.0-0-dev
    # LuaRadio
    apt-get install -y software-properties-common
    apt-get install -y libvolk1-dev libfftw3-dev libfftw3-3
    add-apt-repository ppa:vsergeev/luaradio
    apt-get update
    apt-get install -y luaradio
  SHELL

  # For HackRF to work, we need to disable USB Autosuspend
  # As the USB module is compiled into the kernel, we need to change the kernel command line
  # This only takes effect after a reboot
  # See https://unix.stackexchange.com/a/175035
  # FIXME: Does this actually apply, does Virtualbox use GRUB or just boot kernel directly?
  config.vm.provision "shell", inline: <<-SHELL
    sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="console=tty1 console=ttyS0"/GRUB_CMDLINE_LINUX_DEFAULT="console=tty1 console=ttyS0 usbcore.autosuspend=-1"/g' /etc/default/grub
    update-grub
  SHELL

  # Add UDEV file so we don't have to use sudo for hackrf
  config.vm.provision "file", source: "52-hackrf.rules", destination: "52-hackrf.rules"
  config.vm.provision "shell", inline: <<-SHELL
    sudo mv -f 52-hackrf.rules /etc/udev/rules.d/ #Need to use sudo here as we don't have perms to copy direct
    sudo udevadm control --reload-rules
    sudo adduser vagrant plugdev
  SHELL

  
  # Now reboot to reattach USB device with new rules, and add user to plugdev
  config.vm.provision :reload

end

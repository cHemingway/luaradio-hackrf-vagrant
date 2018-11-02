## Vagrantfile for [LuaRadio](http://luaradio.io/) with [HackRF](https://greatscottgadgets.com/hackrf/) support

For running LuaRadio on Windows, passes through HackRF USB.
No warranty etc, may not work on all systems.

### Requirements
* [Vagrant](https://www.vagrantup.com/)
* [Virtualbox](https://www.virtualbox.org/)
* Virtualbox [extension pack](https://www.virtualbox.org/manual/ch01.html#intro-installing) (for USB support)
* [vagrant-reload](https://github.com/aidanns/vagrant-reload)

### Installation and test
```shell
# cd to the correct directory
# Start the VM
vagrant up
# SSH in
vagrant ssh
# Run test
luaradio /vagrant/test.lua
# Should output [BenchmarkSink] 9.45 MS/s (75.58 MB/s) or similar
```

### TODO
- [] Check if USB Suspend has actually been disabled
- [] Add remote debugging support for lua
    - [] Debugger
    - [] Port Passthrough
    - [] Add IDE config for debugging (e.g for VSCode)
- [] Add RTL-SDR support as well

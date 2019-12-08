void on_bus_aquired (DBusConnection conn) {
    try {
		uint retval = conn.register_object("/org/freedesktop/Notifications", new DemoServer());
		debug("Regsitered listener %u", retval);
    } catch (IOError e) {
        stderr.printf("Could not register service\n");
    }
}
 
int main (string[] args) {
    if (!Thread.supported ()) {
        stderr.printf ("Cannot run without thread support.\n");
        return 1;
    }

    var fuseThread = new FuseThread("fuse", args);
    Thread<void*> thread_b = new Thread<void*> ("thread_b", fuseThread.thread_func);

    Bus.own_name(BusType.SESSION, "org.freedesktop.Notifications", BusNameOwnerFlags.DO_NOT_QUEUE,
                  on_bus_aquired,
                  () => {},
                  () => {
					  stderr.printf ("Could not aquire name\n");
					  Process.exit(1);
				  });

    new MainLoop().run();
    
    thread_b.join();

    return 0;
}

class FuseThread {

    private string name;
    private string[] args;

    public FuseThread (string name, string[] args) {
        this.name = name;
        this.args = args;
    }

    public void* thread_func () {
        while (true) {
            debug("Starting fuse");
            initialize(args);
            debug("Done with fuse");
        }
    }
}
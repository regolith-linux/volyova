void on_bus_aquired (DBusConnection conn) {
    try {
		uint retval = conn.register_object ("/org/freedesktop/Notifications", new DemoServer ());
		debug("Regsitered listener %u", retval);
    } catch (IOError e) {
        stderr.printf ("Could not register service\n");
    }
}
 
void main () {
    Bus.own_name (BusType.SESSION, "org.freedesktop.Notifications", BusNameOwnerFlags.DO_NOT_QUEUE,
                  on_bus_aquired,
                  () => {},
                  () => {
					  stderr.printf ("Could not aquire name\n");
					  Process.exit(1);
				  });

	new MainLoop ().run ();
}
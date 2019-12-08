/**
 * Sample notification daemon 
 */
 
[DBus (name = "org.freedesktop.Notifications")]
public class DemoServer : Object {
	[DBus (name = "Notify")]
	public uint Notify(string app_name, uint replaces_id, string app_icon, string summary, string body, string[] actions, GLib.HashTable<string, GLib.Variant> hints, int expire_timeout) throws DBusError, IOError {
		debug("Got notification");

		return 0;
	}

	[DBus (name = "GetCapabilities")]
	public string[] get_capabilities() throws DBusError, IOError {
		debug("get_capabilities");
		return {"body"};
	}
	[DBus (name = "NotificationClosed")]
	public void notification_closed(uint id, uint reason) throws DBusError, IOError {
		debug("notification_closed");
	}

	[DBus (name = "CloseNotification")]
	public void close_notification(uint id) throws DBusError, IOError {

		debug("close_notification");
	}

	[DBus (name = "GetServerInformation")]
	public void get_server_information(out string name, out string vendor, out string version, out string spec_version) throws DBusError, IOError {
		name = "sample-notification-daemon";
		vendor = "Vala Sample";
		version = "1.0";
		spec_version = "1";
	}
}
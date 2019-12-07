# Volyova

Freedesktop.org Notification backend which provides a libfuse-based filesystem interface.  It was inspired by [Rofication](https://github.com/DaveDavenport/Rofication). 

# Status

Non-working development phase.

# Scope

This project is intended to provide a general purpose notification daemon for the dbus-based [Freedesktop.org Notification specification](https://developer.gnome.org/notification-spec/).

# Design
## File Interface

File operations can be used to manage notifications as if they were plain files.  Once the daemon is started, a libfuse mount is created and populated by volyova with the existing Notifications.

```bash
~/Notifications             # The mount point for notifications
~/Notifications/count       # Contains the total count of notifications
~/Notifications/all/        # Contains all notifications 
~/Notifications/low/        # Contains low-priority notifications
~/Notifications/normal/     # Contains normal-priority notifications
~/Notifications/critical/   # Contains critical-priority notifications
```

## Check for notifications

```bash
if [ -z "$(ls -A $HOME/Notifications/all)" ]; then
   echo "You have notifications"
else
   echo "You have no notifications"
fi
```

## Read a notification

```bash
cat ~/Notifications/all/message.txt
```

## Delete a notification
```bash
rm ~/Notifications/low/message-1.txt
```

## Clear all notifications
```bash
rm ~/Notifications/all/*
```

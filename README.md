# Volyova

Freedesktop.org Notification backend which provides a libfuse-based filesystem interface.

# Status

Non-working development phase.

# Scope

This project is intended to provide a general purpose notification daemon for the dbus-based [Freedesktop.org Notification specification](https://developer.gnome.org/notification-spec/).

# Design
## File Interface

```bash
~/Notifications
~/Notifications/unread-count
~/Notifications/all/
~/Notifications/low/
~/Notifications/normal/
~/Notifications/critical/
```

## Check for notifications

```bash
if [ -z "$(ls -A /path/to/dir)" ]; then
   echo "You have notifications"
else
   echo "You have no notificatgions"
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

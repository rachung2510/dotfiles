#!/usr/bin/env python3
from i3ipc import Event, Connection

def on_focus(i3, e):
	workspace = i3.get_tree().find_focused().workspace()
	for leaf in workspace.leaves():
		# print(f"{leaf.window_title}: {leaf.focused}")
		if leaf.focused:
			leaf.command("border pixel 3")
		else:
			leaf.command("border none")

i3 = Connection()
i3.on(Event.WINDOW_FOCUS, on_focus)
i3.main()

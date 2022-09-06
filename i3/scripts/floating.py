#!/usr/bin/env python
import i3ipc

EXCLUDE = ['Synapse',]

def on_focus(i3, e):
	tree = i3.get_tree()
	ws = tree.find_focused().workspace()
	for con in tree:
		if con.floating != 'user_off' and con.floating != 'auto_off' and con.window_class not in EXCLUDE:
			con.command('border none')
	# Normal border for focused container, even if floating:
	e.container.command('border pixel 2')

i3 = i3ipc.Connection()
i3.on('window::focus', on_focus)
i3.main()
